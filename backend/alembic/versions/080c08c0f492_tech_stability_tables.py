"""Tech stability tables

Revision ID: 080c08c0f492
Revises: 9d2ce33e2fd8
Create Date: 2024-06-04 15:24:37.163834

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = '080c08c0f492'
down_revision: Union[str, None] = '9d2ce33e2fd8'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('hardware_tech_stability',
    sa.Column('id', sa.BigInteger(), autoincrement=True, nullable=False),
    sa.Column('created_at', sa.DateTime(), nullable=False),
    sa.Column('info_system_id', sa.UUID(), nullable=False),
    sa.Column('internal_support', sa.Float(), nullable=False),
    sa.Column('vendor_support', sa.Float(), nullable=False),
    sa.Column('purchasing_possibility', sa.Float(), nullable=True),
    sa.Column('equipment_wear', sa.Float(), nullable=True),
    sa.Column('monitoring_coverage', sa.Float(), nullable=False),
    sa.Column('utilization', sa.Float(), nullable=False),
    sa.Column('compliance_standarts', sa.Float(), nullable=True),
    sa.ForeignKeyConstraint(['info_system_id'], ['info_system.id'], ),
    sa.PrimaryKeyConstraint('id')
    )
    op.create_table('software_tech_stability',
    sa.Column('id', sa.BigInteger(), autoincrement=True, nullable=False),
    sa.Column('created_at', sa.DateTime(), nullable=False),
    sa.Column('info_system_id', sa.UUID(), nullable=False),
    sa.Column('internal_support', sa.Float(), nullable=False),
    sa.Column('vendor_support', sa.Float(), nullable=False),
    sa.Column('monitoring_coverage', sa.Float(), nullable=False),
    sa.Column('utilization', sa.Float(), nullable=False),
    sa.Column('compliance_standarts', sa.Float(), nullable=False),
    sa.ForeignKeyConstraint(['info_system_id'], ['info_system.id'], ),
    sa.PrimaryKeyConstraint('id')
    )
    # ### end Alembic commands ###


def downgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_table('software_tech_stability')
    op.drop_table('hardware_tech_stability')
    # ### end Alembic commands ###
