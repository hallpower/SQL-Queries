/*
Query um unbearbeitete Retouren aus der eBayFFXML rauszusuchen. 
*/

select 	xml.[Protocol Entry No_]
		, xml.[Entry No_]
		, xml.[File No_]
		, xml.[Timestamp Upload_Download]
		, xml.[Message Type]
		, xml.Message
from Urban_Nav600_SL.dbo.[Urban-Brand GmbH$eBayFFXML] xml
where xml.Status = 4 								-- Fehler
-- 	and xml.[Message Type] = 'SalesOrderReturn' 	-- Retoure
	and xml.[Is Cleared] = 0 						-- Nicht erledigt
	and xml.[Setup Code] = 'BER_FIEGE' 				-- windeln.de