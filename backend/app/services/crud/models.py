from app.services.crud.fabric import FabricCRUD
from app.entieties.models import *
from app.entieties.schema import *


hardware_crud = FabricCRUD[HardwareModel, HardwareCreate, HardwareUpdate](HardwareModel)
software_crud = FabricCRUD[SoftwareModel, SoftwareCreate, SoftwareUpdate](SoftwareModel)
vendor_crud = FabricCRUD[VendorModel, VendorCreate, VendorUpdate](VendorModel)
vm_crud = FabricCRUD[VirtualMachineModel, VirtualMachineCreate, VirtualMachineUpdate](VirtualMachineModel)
info_system_crud = FabricCRUD[InfoSystemModel, InfoSystemCreate, InfoSystemUpdate](InfoSystemModel)
catalog_crud = FabricCRUD[CatalogModel, CatalogCreate, CatalogUpdate](CatalogModel)