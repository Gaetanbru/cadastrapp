-- Create view proprietebatie based on Arcopole Models

CREATE MATERIALIZED VIEW #schema_cadastrapp.proprietebatie AS
	SELECT 
		proprietebatie.id_local,
		proprietebatie.parcelle,
		proprietebatie.comptecommunal, 
		proprietebatie.dnupro,
		proprietebatie.cgocommune,
		proprietebatie.ccopre,
		proprietebatie.ccosec,
		proprietebatie.dnupla,
		proprietebatie.jdatat,
		proprietebatie.dnvoiri,
		proprietebatie.dindic,
		proprietebatie.natvoi,
		proprietebatie.dvoilib,
		proprietebatie.ccoriv,
		proprietebatie.dnubat,
		proprietebatie.descr,
		proprietebatie.dniv,
		proprietebatie.dpor,
		proprietebatie.invar,
		proprietebatie.ccoaff,
		proprietebatie.ccoeva,
		proprietebatie.cconlc,
		proprietebatie.dcapec,
		proprietebatie.revcad,
		proprietebatie.ccolloc,
		proprietebatie.gnextl,
		proprietebatie.jandeb,
		proprietebatie.janimp,
		proprietebatie.fcexb,
		proprietebatie.pexb,
		proprietebatie.mvltieomx,
		proprietebatie.bateom,
		proprietebatie.dvldif2a,
		proprietebatie.vlbaia,
		proprietebatie.vlbaia_com,
		proprietebatie.vlbaia_dep,
		proprietebatie.vlbaia_reg,
		proprietebatie.jannat 
	FROM dblink('host=#DBHost_arcopole dbname=#DBName_arcopole user=#DBUser_arcopole password=#DBpasswd_arcopole'::text,
		'select 
			local.id_local,
			invar.codparc as parcelle,
			local.dnupro as comptecommunal , 
			local.dnupro,
			invar.codcomm as cgocommune,
			ltrim(substr(invar.codparc,7,3), ''0'') as ccopre,
			ltrim(substr(invar.codparc,10,2), ''0'') ccosec ,
			substr(invar.codparc,12,4) as dnupla,
			local.jdatat,
			ltrim(invar.dnvoiri, ''0'') as dnvoiri,
			invar.dindic,
			'''' as natvoi,
			invar.dvoilib,
			invar.ccoriv,
			invar.dnubat,
			invar.NDESC as descr,
			invar.dniv,
			invar.dpor,
			invar.invar,
			pev.ccoaff,
			local.ccoeva,
			local.cconlc,
			pev.dcapec,
			CAST(pev.dvlpera AS INTEGER)/2 as revcad,
			exopev.ccolloc,
			exopev.gnextl,
			exopev.jandeb,
			exopev.janimp,
			exopev.FCEXBA2 as fcexb,
			exopev.pexb,
			taxpev.BAOMEC  as mvltieomx,
			taxpev.bateom,
			CAST (exopev.dvldif2a AS INTEGER) as dvldif2a,
			CAST (taxpev.vlbaia AS INTEGER) as vlbaia,
			CAST (taxpev.vlbaia AS INTEGER) as  vlbaia_com,
			CAST (taxpev.vlbaia_dep AS INTEGER) as vlbaia_dep,
			CAST (taxpev.vlbaia_reg AS INTEGER) as vlbaia_reg,
			local.jannat   
		from #DBSchema_arcopole.dgi_local local
			left join #DBSchema_arcopole.dgi_invar invar on local.id_local=invar.invar
			left join #DBSchema_arcopole.dgi_voie voie on voie.id_voie=invar.id_voie
			left join #DBSchema_arcopole.dgi_pev pev on pev.codlot=invar.codlot and pev.invar=invar.invar
			left join #DBSchema_arcopole.dgi_exopev exopev on exopev.id_pev=pev.id_pev
			left join #DBSchema_arcopole.dgi_taxpev as taxpev on taxpev.id_pev=pev.id_pev'::text) 
	proprietebatie(
		id_local character varying(16),
		parcelle character varying(19),
		comptecommunal character varying(12), 
		dnupro character varying(12), 
		cgocommune character varying(6),
		ccopre character varying(3),
		ccosec character varying(2),
		dnupla character varying(4),
		jdatat character varying(8),
		dnvoiri character varying(4),
		dindic character varying(1),
		natvoi character varying(4),
		dvoilib character varying(30),
		ccoriv character varying(4),
		dnubat character varying(2),
		descr character varying(2),
		dniv character varying(2),
		dpor character varying(5),
		invar character varying(16),
		ccoaff character varying(1),
		ccoeva character varying(1),
		cconlc character varying(2),
		dcapec character varying(2),
		revcad integer,
		ccolloc character varying(2),
		gnextl character varying(2),
		jandeb character varying(4),
		janimp character varying(4),
		fcexb character varying(9),
		pexb character varying(5),
		mvltieomx character varying(9),
		bateom  character varying(9),
		dvldif2a integer,
		vlbaia integer,
		vlbaia_com integer,
		vlbaia_dep integer,
		vlbaia_reg integer,
		jannat character varying(10));


ALTER TABLE #schema_cadastrapp.proprietebatie OWNER TO #user_cadastrapp;

