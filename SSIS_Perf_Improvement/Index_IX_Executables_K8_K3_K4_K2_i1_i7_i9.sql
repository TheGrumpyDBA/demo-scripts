--# -----------------------------------------------------
--# Copyright (C) 2018  Timothy T. Hobbs, The Grumpy DBA

--# This program is free software: you can redistribute it and/or modify
--# it under the terms of the GNU General Public License as published by
--# the Free Software Foundation, either version 3 of the License, or
--# (at your option) any later version.

--# This program is distributed in the hope that it will be useful,
--# but WITHOUT ANY WARRANTY; without even the implied warranty of
--# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--# GNU General Public License for more details.

--# You should have received a copy of the GNU General Public License
--# along with this program.  If not, see <https://www.gnu.org/licenses/>.
--# -----------------------------------------------------

USE SSISDB;
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
-------------------------------------------------------
-- This script creates an index on the SSISDB.internal.executables table 
-- that is needed for SSIS performance.
------------------------------------------------------
/*
Update Log
Date		Developer		Change Description
----------  ------------    ---------------------------------------------------
2018-07-19  Tim Hobbs		Initial Creation
*/

IF NOT EXISTS (SELECT 1 FROM SYS.Indexes WHERE NAME='IX_executables_K8_K3_K4_K2_i1_i7_i9')
BEGIN
CREATE NONCLUSTERED INDEX IX_executables_K8_K3_K4_K2_i1_i7_i9
    ON internal.executables
		(
			executable_guid ASC,
			project_version_lsn ASC,
			package_name ASC,
			project_id ASC
		)
	INCLUDE
		(
			executable_id,
			executable_name,
			package_path
		)
WITH (FILLFACTOR = 100, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END

GO

SET ANSI_NULLS OFF
GO
SET ANSI_PADDING OFF
GO