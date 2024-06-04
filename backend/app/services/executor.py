from uuid import UUID
from typing import List, Set

from sqlalchemy import func
from sqlalchemy.orm import Session, joinedload

from app.entieties.models import *

class TechnitionStability:
    def __init__(self, system_id: UUID) -> None:
        self.system_id = system_id
        self.virtual_machines: List[VirtualMachineModel]
        self.hardware_stability: HardwareTechStabilityModel = HardwareTechStabilityModel()
        self.software_stability: SoftwareTechStabilityModel = SoftwareTechStabilityModel()

    
    @property
    def virtual_machines(self, db: Session) -> List[VirtualMachineModel]:
        if not self.virtual_machines:
            self.virtual_machines = db.query(VirtualMachineModel).\
                filter(VirtualMachineModel.system_id == self.system_id).\
                options(joinedload(VirtualMachineModel.software)).\
                all()
        return self.virtual_machines

    def set_hardware_stability(self, db: Session):
        clusters: Set[str] = set((vm.cluster for vm in self.virtual_machines))
        hardware: List[HardwareModel] = db.query(HardwareModel).filter(
            func.any(HardwareModel.clusters.contains(cluster) for cluster in clusters)
        ).all()

        checked: Set[UUID] = set()
        cpu_avg = ram_avg = memory_avg = 0
        monitoring = 0
        supported = 0
        hard_in_catalog = 0
        purchase = 0

        for h in hardware:
            if h.monitoring:
                monitoring += 1
            if h.cpu_utilization < 75:
                cpu_avg += 1
            if h.ram_utilization < 75:
                ram_avg += 1
            if h.disk_mem_utilization < 75:
                memory_avg += 1
            
            if h.product_id and h.product_id not in checked:
                checked.add(h.product_id)
                hard_in_catalog += 1
                product = db.query(CatalogModel).\
                            filter(CatalogModel.id == h.product_id).\
                            first()
                if product.support:
                    supported += 1
                if product.purchase_available:
                    purchase += 1
        
        self.hardware_stability.compliance_standarts = hard_in_catalog / len(hardware)
        self.hardware_stability.cpu_util = cpu_avg / len(hardware)
        self.hardware_stability.ram_util = ram_avg / len(hardware)
        self.hardware_stability.mem_util = memory_avg / len(hardware)
        self.hardware_stability.monitoring_coverage = monitoring / len(hardware)
        self.hardware_stability.vendor_support = supported / len(hardware)
        self.hardware_stability.purchase_available = purchase / len(hardware)        



    def set_software_stability(self, db: Session):
        n = len(self.virtual_machines)

        cpu_avg = srk = monitoring = ram_avg = memory_avg = 0

        checked_soft = set()
        supported_soft = 0
        soft_in_catalog = 0
        soft_purchase_available = 0
        for v in self.virtual_machines:
            if v.cpu_utilization < 75:
                cpu_avg += 1
            if v.ram_utilization < 75:
                ram_avg += 1
            if v.disk_mem_utilization < 75:
                memory_avg += 1
            if v.monitoring:
                monitoring += 1
            if v.srk:
                srk += 1
            for s in v.software:
                if s.id not in checked_soft:
                    checked_soft.add(s.id)
                    
                    if s.product_id:
                        soft_in_catalog += 1

                        product = db.query(CatalogModel).\
                        filter(CatalogModel.id == s.product_id).\
                        first()

                        if product.purchase_available:
                            soft_purchase_available += 1
                        if product.support:
                            supported_soft += 1
        
        self.software_stability.vendor_support = supported_soft / len(checked_soft)
        self.software_stability.compliance_standarts = soft_in_catalog / len(checked_soft)
        self.software_stability.monitoring_coverage = monitoring / n
        self.software_stability.srk = srk / n
        self.software_stability.cpu_util = cpu_avg / n
        self.software_stability.ram_util = ram_avg / n
        self.software_stability.mem_util = memory_avg / n
        self.software_stability.purchase_available = soft_purchase_available / len(checked_soft)