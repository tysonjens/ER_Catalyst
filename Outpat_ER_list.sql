SELECT fch.HeaderID,
	   dp.EMPI,		
       --fch.PatientSK,		
       fch.ClaimNumber,		
       --fch.HMONumber,		
       --et.Encounter_Type_Long_Name,		
	   MIN(dt.Date_BK) AS FROM_Date,		
       MAX(dt2.Date_BK) AS TO_DATE,		
       dt3.Date_BK AS Header_date,	
       prd.Product_Category_Name,
	   hp.HealthPlan_Name,	
	   st.Model_Name,
	   st.Region_Name,	
       ct.ClaimType,		
       ct.ClaimType1,		
       ct.ClaimType2,		
       ct.ClaimType3,		
	   ct.ClaimType4,	
	   --MAX(ft.Fund_Type_Name) AS FundType,	  
       v.Vendor_Name,		
       v.Vendor_Type_Name,		
       fch.APPAMount,		
       fch. BilledAmount,		
       fch.AllowableAmount,		
       fch.APPDays,		
       fch.Days,		
       fch.APPUnit,		
       fch.BilledUnit,
	   fch.EmergencyFlag,		
       fch.ERWithAdmit,		
       fch.Admit,		
	   fch.Visit,	
	   fch.FixedCost,	
       ds.Discharge_Code,		
       ds.Discharge_Status_Description,		
	   drg.MS_DRG_Code,	
	   drg.CMS_RWF
FROM National_Analytics.dbo.FACTCLAIMHEADER fch		
    JOIN National_Analytics.dbo.FACT_CLAIM fc ON fc.HeaderID = fch.HeaderID		
    --JOIN National_Analytics.dbo.DIMREADMITSFOLLOWUPS rdm	ON rdm.ReAdmitFollowUpSK = fch.ReAdmitFollowUpSK		
    JOIN National_Analytics.dbo.DIM_ENCOUNTER_TYPE et ON et.Encounter_Type_SK = fch.EncounterTypeSK		
    JOIN National_Analytics.dbo.DimClaimType ct	ON ct.ClaimTypeSK = fc.ClaimTypeSK		
    JOIN National_Analytics.dbo.DIM_DATE dt ON dt.Date_SK = fc.Date_Service_From_SK		
    JOIN National_Analytics.dbo.DIM_DATE dt2 ON dt2.Date_SK = fc.Date_Service_To_SK		
    JOIN National_Analytics.dbo.SITE_MARKET_HIERARCHY st ON st.Site_Market_Hierarchy_SK = fch.SiteMarketHierarchySK		
    JOIN National_Analytics.dbo.DIM_VENDOR v ON v.Vendor_SK = fch.VendorSK		
    JOIN National_Analytics.dbo.DIM_PRODUCT prd	ON prd.Product_SK = fch.ProductSK		
    JOIN National_Analytics.dbo.DIM_DATE dt3 ON dt3.Date_SK = fch.ServicePeriodSK		
    JOIN National_Analytics.dbo.DIM_DISCHARGE_STATUS ds	 ON ds.Discharge_Status_SK = fch.DischargeStatusSK		
	JOIN NATIONAL_ANALYTICS.dbo.DIM_MS_DRG drg ON drg.MS_DRG_SK = fc.MS_DRG_SK	
	JOIN NATIONAL_ANALYTICS.dbo.DIM_HEALTHPLAN hp ON hp.HealthPlan_SK = fch.HealthplanSK	
	JOIN NATIONAL_ANALYTICS.dbo.DIM_FUND_TYPE ft ON ft.Fund_Type_SK = fc.Fund_Type_SK
	JOIN NATIONAL_ANALYTICS.dbo.DIM_PATIENT dp ON dp.Patient_SK = fch.PatientSK	
WHERE st.Super_Region_Name LIKE '%CALI%'		
      AND dt3.Date_SK >= 20160101	
	  AND dt3.Date_SK < 20180701
	  AND ct.ClaimType3 = 'Emergency Room'
	  AND ct.ClaimType1 = 'Outpatient Hospital'

GROUP BY 		
		
fch.HeaderID,
dp.EMPI,	
--fch.PatientSK,		
fch.ClaimNumber,		
--fch.HMONumber,		
--et.Encounter_Type_Long_Name,		
dt.Date_BK,		
dt2.Date_BK,		
dt3.Date_BK,	
prd.Product_Category_Name,
hp.HealthPlan_Name,	
st.Model_Name,
st.Region_Name,	
ct.ClaimType,		
ct.ClaimType1,		
ct.ClaimType2,		
ct.ClaimType3,		
ct.ClaimType4,	
--ft.Fund_Type_Name,	  
v.Vendor_Name,		
v.Vendor_Type_Name,		
fch.APPAMount,		
fch.BilledAmount,		
fch.AllowableAmount,		
fch.APPDays,		
fch.Days,		
fch.APPUnit,		
fch.BilledUnit,
fch.EmergencyFlag,		
fch.ERWithAdmit,		
fch.Admit,		
fch.Visit,	
fch.FixedCost,	
ds.Discharge_Code,		
ds.Discharge_Status_Description,		
drg.MS_DRG_Code,	
drg.CMS_RWF