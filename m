Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348944E7F34
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Mar 2022 06:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiCZFxa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 26 Mar 2022 01:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiCZFx2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 26 Mar 2022 01:53:28 -0400
Received: from CAN01-QB1-obe.outbound.protection.outlook.com (mail-eopbgr660069.outbound.protection.outlook.com [40.107.66.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDAEDAFD1
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 22:51:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IritsFi6subym+ixVYiEeUfPjL0mmqi/7xZBDT1a8kJNdSzn8Iud+2eYInD9Aw6Jm5GDXSQWjVE9ekPrRtkUedyLePBiHXtLIwd0nYsn+mNt/YHe7BBRnhzzlACjU4Gm/bpcT0SZ+37ihrginhvmkSRbz03jiPyK6Y15Q69auDJY4H0q9cFV0lOkj8wjsMCMBnqokk5ZEKHX+X1deJSAIyLA/VoY5IBMvtfoteMVO59BNFdpspTM4CDNvJ+aso5fwVBSYrsbIGI/tjNbt0DeHy1xpXHydfXIdsgETLYFUx+AgezW2GKVB04lU6i+BRbi2KdRQ3QheCjKl4OxSeA8JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Kdi/ovCChVPYyXmBOqRn1FT0XSV2FXNiWZfXHMt9iM=;
 b=Zbuf5N0DVo2HR59h3T9uZAnpoqrnjapwEOocWZkqQrpKkZ8CPAugBuPYiHKR7Ws8Vguc+v75eOfs4rYK8ZqD7s+5fmZUVvVDjT+zgtBu/VqiYp4f/zgHo00Tv2BHx/e1D2bOQLfd55fYXd2jCMLgOInuu4b+ZsZ8TMt3gcSVMSutGa/uURJPCy38JP+YPCbayhkUhVDQjOOneqMriCjG9IGxKSqMaCL+2lwGs+sHsa/2YdSf6Q3okr6K97plyvY7LopV/PdaAfFa7ekj2IDj7XXJRDDzWgOUCwJuepaTVe676oKUINATucg54rnprABDeVE6rUAnGX1Q/ktzGkFlXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucalgary.ca; dmarc=pass action=none header.from=ucalgary.ca;
 dkim=pass header.d=ucalgary.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucalgary.ca;
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:4a::23)
 by YT2PR01MB8821.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:b8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Sat, 26 Mar
 2022 05:51:45 +0000
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::dd8c:6e57:c431:9323]) by YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::dd8c:6e57:c431:9323%6]) with mapi id 15.20.5102.022; Sat, 26 Mar 2022
 05:51:44 +0000
From:   Wenli Looi <wlooi@ucalgary.ca>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        ath9k-devel@qca.qualcomm.com, Wenli Looi <wlooi@ucalgary.ca>
Subject: [PATCH] ath9k: make is2ghz consistent in ar9003_eeprom
Date:   Fri, 25 Mar 2022 23:47:55 -0600
Message-Id: <20220326054754.27812-1-wlooi@ucalgary.ca>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MW4PR04CA0350.namprd04.prod.outlook.com
 (2603:10b6:303:8a::25) To YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:4a::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be4e9ad8-b61b-43fe-2351-08da0eecb507
X-MS-TrafficTypeDiagnostic: YT2PR01MB8821:EE_
X-Microsoft-Antispam-PRVS: <YT2PR01MB8821543313B9A1A626EB5D94B21B9@YT2PR01MB8821.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N4YFZ1jTVg62knac1naX50yuQhPw7arVj6fap7//ir97vvRvWaRHJpPSDK1PBx8sridFtK4gG6btr1KuxAMRr6h29Y6/dp/IpazFbILsswqcte5AaoAL9aRMLzR3EFeTaKOF8//P043G5T4ubLwZkOdq5k/VzVZS9cIc5/UbfvSZJZcIFh9/+JCfQD0XZP9Jqpx+YNBOCRbynqG/+WUMxf9eOzzLXr5xS9dI/MUmoYmjbj6soy/BvKfyAPGgzNXIqRqW/JE/72/6YVIWDsB/Ek4N7gHsAoOGSDw98ofXnX8AOhhhVxXQXrlDs3T/Bvi4WR2hcKLNm65UjN8dyOqaP/fwSn+BH0ejBaLblPXx2iZkJhVAJ4TpDSUSbR8SMl7UyAgZX3Phuacu63X+slRe3y6J/qWE3j9bdkay9BXBqdmz/UJkxw2lUwj7eYG4BtwperNdo+P5L3ga9ruyPs7ciusyBQhGaA/zuNtxicdb+slFkgiB7036uUfYnpfJOQ04JOLSULAj/TTuWwIpZ6f5mUpmDMJdAY+uWG80W31E4DJRwZsZ/uqQQzVi1NZN1LlL4e3SysloOkX++sJUZVF4wLRy7c+OfeiXmJfAmQlhudreqp3Z5msbGSHJ+AJ6kXtIlxVQgJLdC12Po0ioUGQqNK7ggfI/kTqKb+Da6PGPm82/j5ciilfYWCiiLj0Ad1xL0/WuNNuoVuP5Bp1rR6XG2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(83380400001)(66946007)(66556008)(508600001)(6666004)(52116002)(36756003)(26005)(186003)(107886003)(2616005)(1076003)(316002)(786003)(54906003)(6916009)(86362001)(4326008)(2906002)(38350700002)(8676002)(38100700002)(6512007)(8936002)(5660300002)(66476007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VqPD/cOc9h1rzy7y+ksEYY3Wc144jzr1SoaC2yfp8OF0derfMQwfKba4nN4J?=
 =?us-ascii?Q?QwH7LVdh/lh1tRcjLUbq36QluouGVk+P1R4cTmRwbYEgG9/mLCAqAJQtEdhj?=
 =?us-ascii?Q?qUeSQhmF9I2ab17wSF5UXeXOk0c3r80f1ovStoyqu+7bpbyXAgIWl5ATxKqE?=
 =?us-ascii?Q?yh2yPFIfT/Cdhb7nKBiwJp2o32EARDG3tNtog/SdLoylYyAcEPzrpV+Aa7LK?=
 =?us-ascii?Q?JIk6q3urVvi8f5m8nOq0tedeZQsHESM1ajJ26LJmbQYgiXN2V6kGlXyU8VJP?=
 =?us-ascii?Q?kuioXiU69FfZq6QyWWCVdVQWhqO3NlRmmYRI7i8ZO8rwYyGvDvY5MrxwOJ1r?=
 =?us-ascii?Q?UKIF0+Eb9Od4sbR5jixsC+Nb5je23gvyKrNx3yrQB30JbpmWxfEF22Mo0cef?=
 =?us-ascii?Q?S46mc6NfLnwP9QBFEh4FtqFyfgT/z5FOS38VmzydR3t9r8846+qsQlB9a1yS?=
 =?us-ascii?Q?Yf2mlU483B/c4serzeX2+Z86nezxgawtn2gZmympZHpzXu2beUbPyzOlb00l?=
 =?us-ascii?Q?jtKhTQNKJsGijJ4ic7kA41mqvSBuV/LaaIFxu2+puhRZtejVTQkk8slE0lHb?=
 =?us-ascii?Q?+RbiKlw2HRZD3dWA2uuwemC2UlnO+C24YV/gJAOvjdXgi5gVUJ3lEzNZr1CO?=
 =?us-ascii?Q?p10g6bOLESZytjk9WkYyysBOekxMuK3ZZDNla9U621y81rDEeR+i7K0FYN3o?=
 =?us-ascii?Q?bXRafPTarEDxkIm3+RGMvvx6Ud7gL0FVNkK5jiAmGrXh1PpD33//dJsYXiUj?=
 =?us-ascii?Q?9w04LF5xZDHpXgBCux6R3NI6rWAFXXpI81u+/0ERLKU8Bp1MyQDauuHRrBJ5?=
 =?us-ascii?Q?hd5FupwqWIhOFJkcGSIw2WdCTsx0xWsHp3ZaCmRJHM0sw5qaTjq0U8qawat1?=
 =?us-ascii?Q?Ck9nARH2wIPWq45Lot/84PHQhlCaYKgBEw9Zi9OzDfoqEjm3ANLELt0UQYtU?=
 =?us-ascii?Q?OcM9qYkSIaCfJN8EDqNkcyPtVHMOUJE/LZ1hdfKmnr71coF3TI3RqnGJbIF+?=
 =?us-ascii?Q?47h8FaH/GOOdAh7OsFdw1cyZLJ8jiT49wESmiIMNu2/rshiesKrnoeVbf9dN?=
 =?us-ascii?Q?Rvl5gjixA4tY7SLEhT2ZyWHjgE3mb7XHVeYxmmWJws3jWcFkxsBxY6CBcbZ8?=
 =?us-ascii?Q?HsKv3+gVczYMkrs6gE7lqO4mPN+HdTcOaQ/fziRWSqDoskC48rI61hCQJUbE?=
 =?us-ascii?Q?m9niFQ/Tj3K0KWM9OFqMCcPCokn4m1+k9cT+8s530pnSI5ZmRik58x2Qs3NY?=
 =?us-ascii?Q?TIJHYwe4mT02084hYvD5rSTo6TTGXSYi18qvGkcPr0AgmCDbJ85iekBgjY/e?=
 =?us-ascii?Q?VyY5q960ZcoA6D3LscI68KpZm+TvMqOom7KUc0+ZwzAVT0MbqJe48p/vl7H6?=
 =?us-ascii?Q?70k1e4+3kejoVypjTMmFXwyLN5fsv+IPlJNtq+7ZUvIKUSIFAgruCgwUxLJx?=
 =?us-ascii?Q?0yKTwtXCtnJUj45AB+AhNEfRVSQYx0K3Fa51VSzXYBQRpv46h8rAF/KNtX3z?=
 =?us-ascii?Q?KiYT1/7Dj4Uk7VFnTf+1GIZFIHGiXbWg+Ou/j0zcxroV/98XeKdD4jibB0+M?=
 =?us-ascii?Q?T9EeJir0SbgKcHv57oRQFxeF1yAwD0CrURAe8EfPN2BkhlJHoU0+q1ntnzyv?=
 =?us-ascii?Q?Gy7RIGCp0qbZkmsVrCssL07jwwA+x3VhXlD4Oa+tvlpRvoZqvAMCAvprBIC0?=
 =?us-ascii?Q?smjzwlQ5WRO2/pvrhZSfKakw5KH+jTxRxYfdcMFLsc/HtroUt6qxK/cq/hK7?=
 =?us-ascii?Q?KBJ6cpQmmA=3D=3D?=
X-OriginatorOrg: ucalgary.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: be4e9ad8-b61b-43fe-2351-08da0eecb507
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2022 05:51:44.0748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c609a0ec-a5e3-4631-9686-192280bd9151
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NrZB1LI1746AMZmLtYUMDegEnQtJs02vxyHOM5JPxaCRLJPxNFTDM5OzUhMPGCm1EiPqEFIzepwJzGScrPh6HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8821
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Replace a "mode" variable indicating "is 5ghz" with an "is2ghz" variable
to make it consistent with other functions in the file.

Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>
---
Here's another suggested cleanup that should be helpful for QCN550x
support as well.

 .../net/wireless/ath/ath9k/ar9003_eeprom.c    | 46 +++++++++----------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
index abf12de0e..16bfcd0a1 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
@@ -4747,7 +4747,7 @@ static void ar9003_hw_get_target_power_eeprom(struct ath_hw *ah,
 }
 
 static int ar9003_hw_cal_pier_get(struct ath_hw *ah,
-				  int mode,
+				  bool is2ghz,
 				  int ipier,
 				  int ichain,
 				  int *pfrequency,
@@ -4757,7 +4757,6 @@ static int ar9003_hw_cal_pier_get(struct ath_hw *ah,
 {
 	u8 *pCalPier;
 	struct ar9300_cal_data_per_freq_op_loop *pCalPierStruct;
-	int is2GHz;
 	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
 	struct ath_common *common = ath9k_hw_common(ah);
 
@@ -4768,17 +4767,7 @@ static int ar9003_hw_cal_pier_get(struct ath_hw *ah,
 		return -1;
 	}
 
-	if (mode) {		/* 5GHz */
-		if (ipier >= AR9300_NUM_5G_CAL_PIERS) {
-			ath_dbg(common, EEPROM,
-				"Invalid 5GHz cal pier index, must be less than %d\n",
-				AR9300_NUM_5G_CAL_PIERS);
-			return -1;
-		}
-		pCalPier = &(eep->calFreqPier5G[ipier]);
-		pCalPierStruct = &(eep->calPierData5G[ichain][ipier]);
-		is2GHz = 0;
-	} else {
+	if (is2ghz) {
 		if (ipier >= AR9300_NUM_2G_CAL_PIERS) {
 			ath_dbg(common, EEPROM,
 				"Invalid 2GHz cal pier index, must be less than %d\n",
@@ -4788,10 +4777,18 @@ static int ar9003_hw_cal_pier_get(struct ath_hw *ah,
 
 		pCalPier = &(eep->calFreqPier2G[ipier]);
 		pCalPierStruct = &(eep->calPierData2G[ichain][ipier]);
-		is2GHz = 1;
+	} else {
+		if (ipier >= AR9300_NUM_5G_CAL_PIERS) {
+			ath_dbg(common, EEPROM,
+				"Invalid 5GHz cal pier index, must be less than %d\n",
+				AR9300_NUM_5G_CAL_PIERS);
+			return -1;
+		}
+		pCalPier = &(eep->calFreqPier5G[ipier]);
+		pCalPierStruct = &(eep->calPierData5G[ichain][ipier]);
 	}
 
-	*pfrequency = ath9k_hw_fbin2freq(*pCalPier, is2GHz);
+	*pfrequency = ath9k_hw_fbin2freq(*pCalPier, is2ghz);
 	*pcorrection = pCalPierStruct->refPower;
 	*ptemperature = pCalPierStruct->tempMeas;
 	*pvoltage = pCalPierStruct->voltMeas;
@@ -4960,7 +4957,6 @@ static void ar9003_hw_power_control_override(struct ath_hw *ah,
 static int ar9003_hw_calibration_apply(struct ath_hw *ah, int frequency)
 {
 	int ichain, ipier, npier;
-	int mode;
 	int lfrequency[AR9300_MAX_CHAINS],
 	    lcorrection[AR9300_MAX_CHAINS],
 	    ltemperature[AR9300_MAX_CHAINS], lvoltage[AR9300_MAX_CHAINS],
@@ -4976,12 +4972,12 @@ static int ar9003_hw_calibration_apply(struct ath_hw *ah, int frequency)
 	int pfrequency, pcorrection, ptemperature, pvoltage,
 	    pnf_cal, pnf_pwr;
 	struct ath_common *common = ath9k_hw_common(ah);
+	bool is2ghz = frequency < 4000;
 
-	mode = (frequency >= 4000);
-	if (mode)
-		npier = AR9300_NUM_5G_CAL_PIERS;
-	else
+	if (is2ghz)
 		npier = AR9300_NUM_2G_CAL_PIERS;
+	else
+		npier = AR9300_NUM_5G_CAL_PIERS;
 
 	for (ichain = 0; ichain < AR9300_MAX_CHAINS; ichain++) {
 		lfrequency[ichain] = 0;
@@ -4990,7 +4986,7 @@ static int ar9003_hw_calibration_apply(struct ath_hw *ah, int frequency)
 	/* identify best lower and higher frequency calibration measurement */
 	for (ichain = 0; ichain < AR9300_MAX_CHAINS; ichain++) {
 		for (ipier = 0; ipier < npier; ipier++) {
-			if (!ar9003_hw_cal_pier_get(ah, mode, ipier, ichain,
+			if (!ar9003_hw_cal_pier_get(ah, is2ghz, ipier, ichain,
 						    &pfrequency, &pcorrection,
 						    &ptemperature, &pvoltage,
 						    &pnf_cal, &pnf_pwr)) {
@@ -5127,12 +5123,12 @@ static int ar9003_hw_calibration_apply(struct ath_hw *ah, int frequency)
 
 	/* Store calibrated noise floor values */
 	for (ichain = 0; ichain < AR9300_MAX_CHAINS; ichain++)
-		if (mode) {
-			ah->nf_5g.cal[ichain] = nf_cal[ichain];
-			ah->nf_5g.pwr[ichain] = nf_pwr[ichain];
-		} else {
+		if (is2ghz) {
 			ah->nf_2g.cal[ichain] = nf_cal[ichain];
 			ah->nf_2g.pwr[ichain] = nf_pwr[ichain];
+		} else {
+			ah->nf_5g.cal[ichain] = nf_cal[ichain];
+			ah->nf_5g.pwr[ichain] = nf_pwr[ichain];
 		}
 
 	return 0;
-- 
2.25.1

