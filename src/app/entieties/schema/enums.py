from enum import Enum


class SoftwareType(str, Enum):
    domain_controller = "Domain Controller"
    web_server = "Web Server"
    database = "Database"


class ProductType(str, Enum):
    hardware = "hardware"
    software = "software"


class Location(str, Enum):
    spb = "Saint-Petersburg"
    moscow = "Moscow"

