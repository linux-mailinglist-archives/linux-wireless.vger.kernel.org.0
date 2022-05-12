Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D04A52561B
	for <lists+linux-wireless@lfdr.de>; Thu, 12 May 2022 21:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358212AbiELTyl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 May 2022 15:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358221AbiELTyk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 May 2022 15:54:40 -0400
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2077.outbound.protection.outlook.com [40.107.115.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE4127B338
        for <linux-wireless@vger.kernel.org>; Thu, 12 May 2022 12:54:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XRkaYSA6v1GajOlpzYaDNbSx6D7ATmwgDYJGCriDBJHvIe447HmbCTVsYMXkudezSOt5rzoV7iBMKHwC9c+hYPuAHBZsZ9QF64WRw5dCzzCoxEyDsjM4GhHRQo5cA+oSZGnVMeGCXH+/EqP5r3CjWIdHf3lpQBkrXh1Q3H918rJUqreb/phryBHVagxxNEyIdIkb53izYaYyHnVq3vYnMyr2qnQPHGm8dF72j4pcgohgyhrS3zIZwqVDdvkSUuQO3SL2ztSQ+xzpjyUu2Sic/Zwb8PZE0mRlzkoRN6s3HZsLp+V9HosddLXlb6A0ZbaLVlyhHHpS63cB/9b+F1X0hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHNlDEM4cm8iY+eJAu3WylVQWrhIO31D/wvMidqHlqM=;
 b=TgYZz724kg7NnPNIOiRX0CPfqw6ADcHRsvhoRnIpFmZycZMkHDeqn3IQvkzZfNul9NVJrGNVLcppRPRk+yUwqTRkSSzkudiDzIMnLv2bnZmiG58LfGfXAHez0JxS5txeKUyBpI3DcqSHwduWyOZYbxz+sOH+gdiWKz0mEsbnSp8rTXI8YqKCZC1buGrOhskzlLhM548qNtz7CbJWKeFnuCE3IZqeo8NzpqvXZxMPajrLq6KUZNRFvv+/vCjYNTNuiqv/u/9YRg/80yWr3VQDgY+FnM8RJ9qMBpxOuC7UaRv2K2bHLtDUwwc6X4hWU3hlzSjfNieTsmwZOtlrb/Rs1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucalgary.ca; dmarc=pass action=none header.from=ucalgary.ca;
 dkim=pass header.d=ucalgary.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucalgary.ca;
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:4a::23)
 by YT3PR01MB9530.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:91::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 19:54:28 +0000
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::a17b:bb51:f663:e98f]) by YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::a17b:bb51:f663:e98f%4]) with mapi id 15.20.5227.023; Thu, 12 May 2022
 19:54:28 +0000
From:   Wenli Looi <wlooi@ucalgary.ca>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Wenli Looi <wlooi@ucalgary.ca>
Subject: [PATCH v2 9/9] ath9k: add ar9300_eeprom_v2
Date:   Thu, 12 May 2022 12:53:19 -0700
Message-Id: <20220512195319.14635-10-wlooi@ucalgary.ca>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220512195319.14635-1-wlooi@ucalgary.ca>
References: <20220512195319.14635-1-wlooi@ucalgary.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: BYAPR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::39) To YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:4a::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64bf1e09-992e-41fd-e27d-08da345138fe
X-MS-TrafficTypeDiagnostic: YT3PR01MB9530:EE_
X-Microsoft-Antispam-PRVS: <YT3PR01MB953091D200CF3F949FDBD07AB2CB9@YT3PR01MB9530.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OTOay08Q8ZaX2CGJvs2USEnB9XTMY1SCS2PY7j4EdQO5hWemW+DKAqpF381g2VwrR5Nfzd+kvMCSaB/na0GQNRNVEeiaVA2XDwyOtFVF++1o6k5Jjmr77nWEc50eXMwFUZLO1OPuUFTUtzmGa86PEHl5h7C70aw3NXhNgzU4JtKRa0G0dqAiIm4GLsS4Fdgjj8dtPookAPqdznG4IP0l8NiuOA0UpnDk2zT2drcjnk8Dm5pUXjO8cnvtoaszkYlL2xuDJtuCWxxsngKfO8M86hNXyQ4RACRTBxffBa9/RKQxO0YElOTUR7jajV+c5NxNdP0QrQELRUUwGDNGZhvVSEBz62feoAfJXxKn91dK0Dhw5lHAZa5tdIshW5SCtISeP6Avr+H4ko9k6C8342Z860WWhhXZ5vSDKx6ECwuE32EE/K9GJhqZiiQjbNwsbqPRZ/vRppSMhz5EXTohL9gcdfwQ64GMdTtNOmaoz3YfBhZ0tlrbxoZbIKwRPZ1Bg4Qcg3X7wtL7szjuHekOgYrJ8+SoBoG7fdTkoDNipdCg66lYuV9qjvh7TszHC0O1IWHb3LmecVRgnslZkQG4noEZphS6DJxI88Ejz10seVZtKRWe3uux2Z9wFHF16yPYN2u09l+TYBCrcLv/mUfrnC8Gd4vvi7fozg/qa+no26UESyauQThoDxAPsJq9JBw0op/rlzw2vZkIpldKouktH+Vhgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(83380400001)(36756003)(38350700002)(6666004)(508600001)(6916009)(316002)(786003)(54906003)(19627235002)(2616005)(38100700002)(186003)(2906002)(4326008)(8676002)(107886003)(1076003)(86362001)(66556008)(8936002)(66946007)(66476007)(6506007)(30864003)(6512007)(5660300002)(26005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gnIWkCcjwMFCUQH0u/dLdnvaw0d2zKCRnKnzDHmVFsS/FcM69KNzIPKQeiOm?=
 =?us-ascii?Q?3dWMT3k5lttITE1wnqKw+VsEyycTNNrUFsiGysRtvZf6C1NwFCpy5T7TWfoX?=
 =?us-ascii?Q?60YZNKW4h4X/AuEKR+UOsFKTDfyQELDKm226CgpJDCWZEKHc5iLwsH35uSNY?=
 =?us-ascii?Q?4kLd9rkqkSCecIo0vDCYEbIHEg4TXJz8JPyFX+tPWk2omd6H7Qc121D5S1fz?=
 =?us-ascii?Q?q8aH+op4T9koCkMqvSi+vvpHkUNaxNDSw+pW3O34uxyq/3D0AsBoeh0/WmWe?=
 =?us-ascii?Q?3n6BXwJblx2tmEHIStkZp5jaMiqD3MGiQl6UNmI1glsRTpJdwGrgyA0f6YEl?=
 =?us-ascii?Q?m4IO1B7iXxp2fLCxqF9b+ZfvcmOpedgrCC+Y6Zi6SO9GshcoIbD0ZDInnJrF?=
 =?us-ascii?Q?5TOTBTOV//ahSXruYVyi9/SV249nXaG6zukLF1xpsKgh7Vs4nyjIjVOV2S8S?=
 =?us-ascii?Q?azIDYebhfO2GdQawBmDdafVRJ8eqEqcygLGfLzRTSDhYPQEpFraVEx2WnA/L?=
 =?us-ascii?Q?Mbj/+vkYSVYeP9QYI2COd7KMo0CSCGZYt3C7CmvWK4unfImKOr51eNFqC2Du?=
 =?us-ascii?Q?FvA3EYJqgxqQR74/xRt8i691eQWbGZ9VjdhRzxDAMRlZerfRyYSkK2B6T3xE?=
 =?us-ascii?Q?1WUqILZeq8sFkz0r5h2fYsOhfvTuj3ibmHDAB8G3OaycO0ENXc3U/SvLmpaf?=
 =?us-ascii?Q?qq9aqRsIvntR7/xtHhdR66BNbsLjgd8L2wLxTAF65qfEDORNPjxhJid7F0rm?=
 =?us-ascii?Q?0u5B6Sue6ohZJc6HDbbURtuiULIDDXZ6StRIx6W+4PtrkRniR0wpP/aOs7VJ?=
 =?us-ascii?Q?AqNyPTEY7uT5vryv/8iY8t02mjarcqY81IYPoYjQKZk46Gu94f+67DdEN73H?=
 =?us-ascii?Q?LwfP7XH7M940tsqWWzID6TM8EoC046NIcnwkRA0Bn5wlBVrgqxAAmxNHuDY8?=
 =?us-ascii?Q?XjBM+bV3Ywbol2+mLqrFkOQUqnGDagC4jYYh6MI+MWSf9Z/O790QhUIaJGrA?=
 =?us-ascii?Q?ardhET7IFkRqDVTzim2iGU1yx0u2b3SgHHSQpw/yLlTwR9RDdIfKBJtoTLOx?=
 =?us-ascii?Q?LtsuFZI3r/NGJxnlhIAfJX/l5A9aN0yVZrOAkHpdrS9dhcbhNtKHhdUCsqPe?=
 =?us-ascii?Q?8CZ6WK/QC7kG4pJQkKyOy0QrF7A70fIh2FxuVNe0mRx1/aJAZSTjRFD3MBpd?=
 =?us-ascii?Q?ogwtnzBfSrY5JtoQXYmgV5F2p3deePenFKq17CjYFAV8cmHnjoxJ4TZ2zfgd?=
 =?us-ascii?Q?AV4e4brT+ep8gdJq+jajR7x8V+tszMm7/TN2jMtFAjfxC+FmnKavFXu2M7Bh?=
 =?us-ascii?Q?FwrSrGKfm7A26mzP8Zpbh5E7xnk04iyfhabwyexpGyFvDgzmooFLQfmBXm6o?=
 =?us-ascii?Q?yMsvcUuZyy2RSXOvj6qH/PQTMy+PrQnsIUNGVSoN0bLCp6QDJlWqRJTMSfwA?=
 =?us-ascii?Q?PBENlhCRzXYCQsN0sZ8p7E9SrEZ/Bk3/IT3x0iJXxpfzLj0LDyIdgtPkc2Nm?=
 =?us-ascii?Q?lkSBjhXRwYVe9gzppAmDLrSrzDE+xxIhJ5Z7sEPG2osojkUJon0m7kkzlZfT?=
 =?us-ascii?Q?k9syBZ/2qk3AHveE7fKhL99BWysz+h9fAqU9yapBUmiKOawf1LG/tSZ87x/8?=
 =?us-ascii?Q?P+HvuKPJMLdxREvfOdFbeJ4XH51rpyT/eKLFenEc2dboaSfS5jKPstEIOX4C?=
 =?us-ascii?Q?YRTVocxkuIEbl8ZdW2EB9nwqV1AcaQ7ISa3e7NYVn7d+j3Nc6WKFESoqBg0w?=
 =?us-ascii?Q?8lqRgjxr5A=3D=3D?=
X-OriginatorOrg: ucalgary.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 64bf1e09-992e-41fd-e27d-08da345138fe
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 19:54:28.1757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c609a0ec-a5e3-4631-9686-192280bd9151
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7TmslbP6iZ85sooRRdjl/ejWnjrUo0uD/2TWKtrb+1VWogbWJ6XqF58CbNxxh7MAW5Qu9rl8vhuiMQKUOgiSvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9530
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This adds support for the 4-chain eeprom used by QCN550x. The
abstraction layer over the eeprom allows the code to work with both V1
and V2 eeprom types.

Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>
---
 .../net/wireless/ath/ath9k/ar9003_eeprom.c    | 325 ++++++++++++++----
 .../net/wireless/ath/ath9k/ar9003_eeprom.h    | 100 ++++++
 drivers/net/wireless/ath/ath9k/hw.h           |   1 +
 drivers/net/wireless/ath/ath9k/reg.h          |   1 +
 4 files changed, 352 insertions(+), 75 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
index 11c7b57a1..4f5b753d7 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
@@ -2984,16 +2984,20 @@ static int ath9k_hw_ar9300_get_eeprom_rev(struct ath_hw *ah)
 
 static struct ar9300_base_eep_hdr *ar9003_base_header(struct ath_hw *ah)
 {
-	return &ah->eeprom.ar9300_eep_v1.baseEepHeader;
+	return AR_SREV_AR9300_EEPROM_V2(ah) ?
+		       &ah->eeprom.ar9300_eep_v2.baseEepHeader :
+			     &ah->eeprom.ar9300_eep_v1.baseEepHeader;
 }
 
 static struct ar9300_BaseExtension_1 *ar9003_base_ext1(struct ath_hw *ah)
 {
-	return &ah->eeprom.ar9300_eep_v1.base_ext1;
+	return AR_SREV_AR9300_EEPROM_V2(ah) ?
+		       &ah->eeprom.ar9300_eep_v2.base_ext1 :
+			     &ah->eeprom.ar9300_eep_v1.base_ext1;
 }
 
-static struct ar9300_modal_eep_header_v1 *ar9003_modal_header(struct ath_hw *ah,
-							   bool is2ghz)
+static struct ar9300_modal_eep_header_v1 *
+ar9003_modal_header_v1(struct ath_hw *ah, bool is2ghz)
 {
 	struct ar9300_eeprom_v1 *eep = &ah->eeprom.ar9300_eep_v1;
 
@@ -3003,206 +3007,348 @@ static struct ar9300_modal_eep_header_v1 *ar9003_modal_header(struct ath_hw *ah,
 		return &eep->modalHeader5G;
 }
 
+static struct ar9300_modal_eep_header_v2 *
+ar9003_modal_header_v2(struct ath_hw *ah, bool is2ghz)
+{
+	struct ar9300_eeprom_v2 *eep = &ah->eeprom.ar9300_eep_v2;
+
+	if (is2ghz)
+		return &eep->modalHeader2G;
+	else
+		return &eep->modalHeader5G;
+}
+
 static int8_t ar9003_ant_gain(struct ath_hw *ah, bool is2ghz)
 {
-	return ar9003_modal_header(ah, is2ghz)->antennaGain;
+	return AR_SREV_AR9300_EEPROM_V2(ah) ?
+		       ar9003_modal_header_v2(ah, is2ghz)->antennaGain :
+			     ar9003_modal_header_v1(ah, is2ghz)->antennaGain;
 }
 
 static u8 ar9003_cal_freq_pier(struct ath_hw *ah, int idx, bool is2ghz)
 {
-	struct ar9300_eeprom_v1 *eep = &ah->eeprom.ar9300_eep_v1;
-	return is2ghz ? eep->calFreqPier2G[idx] : eep->calFreqPier5G[idx];
+	if (AR_SREV_AR9300_EEPROM_V2(ah)) {
+		struct ar9300_eeprom_v2 *eep = &ah->eeprom.ar9300_eep_v2;
+		return is2ghz ? eep->calFreqPier2G[idx] :
+				      eep->calFreqPier5G[idx];
+	} else {
+		struct ar9300_eeprom_v1 *eep = &ah->eeprom.ar9300_eep_v1;
+		return is2ghz ? eep->calFreqPier2G[idx] :
+				      eep->calFreqPier5G[idx];
+	}
 }
 
 static struct ar9300_cal_data_per_freq_op_loop *
 ar9003_cal_pier_data(struct ath_hw *ah, int chain, int idx, bool is2ghz)
 {
-	struct ar9300_eeprom_v1 *eep = &ah->eeprom.ar9300_eep_v1;
-	return is2ghz ? &eep->calPierData2G[chain][idx] :
-			      &eep->calPierData5G[chain][idx];
+	if (AR_SREV_AR9300_EEPROM_V2(ah)) {
+		struct ar9300_eeprom_v2 *eep = &ah->eeprom.ar9300_eep_v2;
+		return is2ghz ? &eep->calPierData2G[chain][idx] :
+				      &eep->calPierData5G[chain][idx];
+	} else {
+		struct ar9300_eeprom_v1 *eep = &ah->eeprom.ar9300_eep_v1;
+		return is2ghz ? &eep->calPierData2G[chain][idx] :
+				      &eep->calPierData5G[chain][idx];
+	}
 }
 
 static u8 ar9003_cal_target_freqbin(struct ath_hw *ah, int idx, bool is2ghz)
 {
-	struct ar9300_eeprom_v1 *eep = &ah->eeprom.ar9300_eep_v1;
-	return is2ghz ? eep->calTarget_freqbin_2G[idx] :
-			      eep->calTarget_freqbin_5G[idx];
+	if (AR_SREV_AR9300_EEPROM_V2(ah)) {
+		struct ar9300_eeprom_v2 *eep = &ah->eeprom.ar9300_eep_v2;
+		return is2ghz ? eep->calTarget_freqbin_2G[idx] :
+				      eep->calTarget_freqbin_5G[idx];
+	} else {
+		struct ar9300_eeprom_v1 *eep = &ah->eeprom.ar9300_eep_v1;
+		return is2ghz ? eep->calTarget_freqbin_2G[idx] :
+				      eep->calTarget_freqbin_5G[idx];
+	}
 }
 
 static u8 ar9003_cal_target_freqbin_cck(struct ath_hw *ah, int idx)
 {
-	struct ar9300_eeprom_v1 *eep = &ah->eeprom.ar9300_eep_v1;
-	return eep->calTarget_freqbin_Cck[idx];
+	if (AR_SREV_AR9300_EEPROM_V2(ah)) {
+		struct ar9300_eeprom_v2 *eep = &ah->eeprom.ar9300_eep_v2;
+		return eep->calTarget_freqbin_Cck[idx];
+	} else {
+		struct ar9300_eeprom_v1 *eep = &ah->eeprom.ar9300_eep_v1;
+		return eep->calTarget_freqbin_Cck[idx];
+	}
 }
 
 static u8 ar9003_cal_target_freqbin_ht20(struct ath_hw *ah, int idx,
 					 bool is2ghz)
 {
-	struct ar9300_eeprom_v1 *eep = &ah->eeprom.ar9300_eep_v1;
-	return is2ghz ? eep->calTarget_freqbin_2GHT20[idx] :
-			      eep->calTarget_freqbin_5GHT20[idx];
+	if (AR_SREV_AR9300_EEPROM_V2(ah)) {
+		struct ar9300_eeprom_v2 *eep = &ah->eeprom.ar9300_eep_v2;
+		return is2ghz ? eep->calTarget_freqbin_2GHT20[idx] :
+				      eep->calTarget_freqbin_5GHT20[idx];
+	} else {
+		struct ar9300_eeprom_v1 *eep = &ah->eeprom.ar9300_eep_v1;
+		return is2ghz ? eep->calTarget_freqbin_2GHT20[idx] :
+				      eep->calTarget_freqbin_5GHT20[idx];
+	}
 }
 
 static u8 ar9003_cal_target_freqbin_ht40(struct ath_hw *ah, int idx,
 					 bool is2ghz)
 {
-	struct ar9300_eeprom_v1 *eep = &ah->eeprom.ar9300_eep_v1;
-	return is2ghz ? eep->calTarget_freqbin_2GHT40[idx] :
-			      eep->calTarget_freqbin_5GHT40[idx];
+	if (AR_SREV_AR9300_EEPROM_V2(ah)) {
+		struct ar9300_eeprom_v2 *eep = &ah->eeprom.ar9300_eep_v2;
+		return is2ghz ? eep->calTarget_freqbin_2GHT40[idx] :
+				      eep->calTarget_freqbin_5GHT40[idx];
+	} else {
+		struct ar9300_eeprom_v1 *eep = &ah->eeprom.ar9300_eep_v1;
+		return is2ghz ? eep->calTarget_freqbin_2GHT40[idx] :
+				      eep->calTarget_freqbin_5GHT40[idx];
+	}
 }
 
 static u8 ar9003_cal_target_power(struct ath_hw *ah, int idx, int rateIndex,
 				  bool is2ghz)
 {
-	struct ar9300_eeprom_v1 *eep = &ah->eeprom.ar9300_eep_v1;
-	return is2ghz ? eep->calTargetPower2G[idx].tPow2x[rateIndex] :
-			      eep->calTargetPower5G[idx].tPow2x[rateIndex];
+	if (AR_SREV_AR9300_EEPROM_V2(ah)) {
+		struct ar9300_eeprom_v2 *eep = &ah->eeprom.ar9300_eep_v2;
+		return is2ghz ? eep->calTargetPower2G[idx].tPow2x[rateIndex] :
+				      eep->calTargetPower5G[idx].tPow2x[rateIndex];
+	} else {
+		struct ar9300_eeprom_v1 *eep = &ah->eeprom.ar9300_eep_v1;
+		return is2ghz ? eep->calTargetPower2G[idx].tPow2x[rateIndex] :
+				      eep->calTargetPower5G[idx].tPow2x[rateIndex];
+	}
 }
 
 static u8 ar9003_cal_target_power_cck(struct ath_hw *ah, int idx, int rateIndex)
 {
-	struct ar9300_eeprom_v1 *eep = &ah->eeprom.ar9300_eep_v1;
-	return eep->calTargetPowerCck[idx].tPow2x[rateIndex];
+	if (AR_SREV_AR9300_EEPROM_V2(ah)) {
+		struct ar9300_eeprom_v2 *eep = &ah->eeprom.ar9300_eep_v2;
+		return eep->calTargetPowerCck[idx].tPow2x[rateIndex];
+	} else {
+		struct ar9300_eeprom_v1 *eep = &ah->eeprom.ar9300_eep_v1;
+		return eep->calTargetPowerCck[idx].tPow2x[rateIndex];
+	}
 }
 
 static u8 ar9003_cal_target_power_ht20(struct ath_hw *ah, int idx,
 				       int rateIndex, bool is2ghz)
 {
-	struct ar9300_eeprom_v1 *eep = &ah->eeprom.ar9300_eep_v1;
-	return is2ghz ? eep->calTargetPower2GHT20[idx].tPow2x[rateIndex] :
-			      eep->calTargetPower5GHT20[idx].tPow2x[rateIndex];
+	if (AR_SREV_AR9300_EEPROM_V2(ah)) {
+		struct ar9300_eeprom_v2 *eep = &ah->eeprom.ar9300_eep_v2;
+		return is2ghz ?
+			       eep->calTargetPower2GHT20[idx].tPow2x[rateIndex] :
+				     eep->calTargetPower5GHT20[idx].tPow2x[rateIndex];
+	} else {
+		struct ar9300_eeprom_v1 *eep = &ah->eeprom.ar9300_eep_v1;
+		return is2ghz ?
+			       eep->calTargetPower2GHT20[idx].tPow2x[rateIndex] :
+				     eep->calTargetPower5GHT20[idx].tPow2x[rateIndex];
+	}
 }
 
 static u8 ar9003_cal_target_power_ht40(struct ath_hw *ah, int idx,
 				       int rateIndex, bool is2ghz)
 {
-	struct ar9300_eeprom_v1 *eep = &ah->eeprom.ar9300_eep_v1;
-	return is2ghz ? eep->calTargetPower2GHT40[idx].tPow2x[rateIndex] :
-			      eep->calTargetPower5GHT40[idx].tPow2x[rateIndex];
+	if (AR_SREV_AR9300_EEPROM_V2(ah)) {
+		struct ar9300_eeprom_v2 *eep = &ah->eeprom.ar9300_eep_v2;
+		return is2ghz ?
+			       eep->calTargetPower2GHT40[idx].tPow2x[rateIndex] :
+				     eep->calTargetPower5GHT40[idx].tPow2x[rateIndex];
+	} else {
+		struct ar9300_eeprom_v1 *eep = &ah->eeprom.ar9300_eep_v1;
+		return is2ghz ?
+			       eep->calTargetPower2GHT40[idx].tPow2x[rateIndex] :
+				     eep->calTargetPower5GHT40[idx].tPow2x[rateIndex];
+	}
 }
 
 static u8 ar9003_ctl_freqbin(struct ath_hw *ah, int idx, int edge, bool is2ghz)
 {
-	struct ar9300_eeprom_v1 *eep = &ah->eeprom.ar9300_eep_v1;
-	return is2ghz ? eep->ctl_freqbin_2G[idx][edge] :
-			      eep->ctl_freqbin_5G[idx][edge];
+	if (AR_SREV_AR9300_EEPROM_V2(ah)) {
+		struct ar9300_eeprom_v2 *eep = &ah->eeprom.ar9300_eep_v2;
+		return is2ghz ? eep->ctl_freqbin_2G[idx][edge] :
+				      eep->ctl_freqbin_5G[idx][edge];
+	} else {
+		struct ar9300_eeprom_v1 *eep = &ah->eeprom.ar9300_eep_v1;
+		return is2ghz ? eep->ctl_freqbin_2G[idx][edge] :
+				      eep->ctl_freqbin_5G[idx][edge];
+	}
 }
 
 static u8 ar9003_ctl_index(struct ath_hw *ah, int idx, bool is2ghz)
 {
-	struct ar9300_eeprom_v1 *eep = &ah->eeprom.ar9300_eep_v1;
-	return is2ghz ? eep->ctlIndex_2G[idx] : eep->ctlIndex_5G[idx];
+	if (AR_SREV_AR9300_EEPROM_V2(ah)) {
+		struct ar9300_eeprom_v2 *eep = &ah->eeprom.ar9300_eep_v2;
+		return is2ghz ? eep->ctlIndex_2G[idx] : eep->ctlIndex_5G[idx];
+	} else {
+		struct ar9300_eeprom_v1 *eep = &ah->eeprom.ar9300_eep_v1;
+		return is2ghz ? eep->ctlIndex_2G[idx] : eep->ctlIndex_5G[idx];
+	}
 }
 
 static u8 ar9003_ctl_power_data(struct ath_hw *ah, int idx, int edge,
 				bool is2ghz)
 {
-	struct ar9300_eeprom_v1 *eep = &ah->eeprom.ar9300_eep_v1;
-	return is2ghz ? eep->ctlPowerData_2G[idx].ctlEdges[edge] :
-			      eep->ctlPowerData_5G[idx].ctlEdges[edge];
+	if (AR_SREV_AR9300_EEPROM_V2(ah)) {
+		struct ar9300_eeprom_v2 *eep = &ah->eeprom.ar9300_eep_v2;
+		return is2ghz ? eep->ctlPowerData_2G[idx].ctlEdges[edge] :
+				      eep->ctlPowerData_5G[idx].ctlEdges[edge];
+	} else {
+		struct ar9300_eeprom_v1 *eep = &ah->eeprom.ar9300_eep_v1;
+		return is2ghz ? eep->ctlPowerData_2G[idx].ctlEdges[edge] :
+				      eep->ctlPowerData_5G[idx].ctlEdges[edge];
+	}
 }
 
 static u16 ar9003_hw_ant_ctrl_chain_get(struct ath_hw *ah, int chain,
 					bool is2ghz)
 {
-	__le16 val = ar9003_modal_header(ah, is2ghz)->antCtrlChain[chain];
+	__le16 val =
+		AR_SREV_AR9300_EEPROM_V2(ah) ?
+			ar9003_modal_header_v2(ah, is2ghz)->antCtrlChain[chain] :
+			      ar9003_modal_header_v1(ah, is2ghz)->antCtrlChain[chain];
 	return le16_to_cpu(val);
 }
 
 u32 ar9003_hw_ant_ctrl_common_get(struct ath_hw *ah, bool is2ghz)
 {
-	return le32_to_cpu(ar9003_modal_header(ah, is2ghz)->antCtrlCommon);
+	__le32 val = AR_SREV_AR9300_EEPROM_V2(ah) ?
+			     ar9003_modal_header_v2(ah, is2ghz)->antCtrlCommon :
+				   ar9003_modal_header_v1(ah, is2ghz)->antCtrlCommon;
+	return le32_to_cpu(val);
 }
 
 u32 ar9003_hw_ant_ctrl_common_2_get(struct ath_hw *ah, bool is2ghz)
 {
-	return le32_to_cpu(ar9003_modal_header(ah, is2ghz)->antCtrlCommon2);
+	__le32 val =
+		AR_SREV_AR9300_EEPROM_V2(ah) ?
+			ar9003_modal_header_v2(ah, is2ghz)->antCtrlCommon2 :
+			      ar9003_modal_header_v1(ah, is2ghz)->antCtrlCommon2;
+	return le32_to_cpu(val);
 }
 
 static int8_t ar9003_noise_floor_thres(struct ath_hw *ah, int chain,
 				       bool is2ghz)
 {
-	return ar9003_modal_header(ah, is2ghz)->noiseFloorThreshCh[chain];
+	return AR_SREV_AR9300_EEPROM_V2(ah) ?
+		       ar9003_modal_header_v2(ah, is2ghz)
+			       ->noiseFloorThreshCh[chain] :
+			     ar9003_modal_header_v1(ah, is2ghz)
+			       ->noiseFloorThreshCh[chain];
 }
 
 static int8_t ar9003_quick_drop(struct ath_hw *ah, bool is2ghz)
 {
-	return ar9003_modal_header(ah, is2ghz)->quick_drop;
+	return AR_SREV_AR9300_EEPROM_V2(ah) ?
+		       ar9003_modal_header_v2(ah, is2ghz)->quick_drop :
+			     ar9003_modal_header_v1(ah, is2ghz)->quick_drop;
 }
 
 static int8_t ar9003_temp_slope(struct ath_hw *ah, bool is2ghz)
 {
-	return ar9003_modal_header(ah, is2ghz)->tempSlope;
+	return AR_SREV_AR9300_EEPROM_V2(ah) ?
+		       ar9003_modal_header_v2(ah, is2ghz)->tempSlope :
+			     ar9003_modal_header_v1(ah, is2ghz)->tempSlope;
 }
 
 static int8_t ar9003_temp_slope_high(struct ath_hw *ah)
 {
-	return ah->eeprom.ar9300_eep_v1.base_ext2.tempSlopeHigh;
+	return AR_SREV_AR9300_EEPROM_V2(ah) ?
+		       ah->eeprom.ar9300_eep_v2.base_ext2.tempSlopeHigh :
+			     ah->eeprom.ar9300_eep_v1.base_ext2.tempSlopeHigh;
 }
 
 static int8_t ar9003_temp_slope_low(struct ath_hw *ah)
 {
-	return ah->eeprom.ar9300_eep_v1.base_ext2.tempSlopeLow;
+	return AR_SREV_AR9300_EEPROM_V2(ah) ?
+		       ah->eeprom.ar9300_eep_v2.base_ext2.tempSlopeLow :
+			     ah->eeprom.ar9300_eep_v1.base_ext2.tempSlopeLow;
 }
 
 static u8 ar9003_tx_end_to_xpa_off(struct ath_hw *ah, bool is2ghz)
 {
-	return ar9003_modal_header(ah, is2ghz)->txEndToXpaOff;
+	return AR_SREV_AR9300_EEPROM_V2(ah) ?
+		       ar9003_modal_header_v2(ah, is2ghz)->txEndToXpaOff :
+			     ar9003_modal_header_v1(ah, is2ghz)->txEndToXpaOff;
 }
 
 static u8 ar9003_tx_frame_to_xpa_on(struct ath_hw *ah, bool is2ghz)
 {
-	return ar9003_modal_header(ah, is2ghz)->txFrameToXpaOn;
+	return AR_SREV_AR9300_EEPROM_V2(ah) ?
+		       ar9003_modal_header_v2(ah, is2ghz)->txFrameToXpaOn :
+			     ar9003_modal_header_v1(ah, is2ghz)->txFrameToXpaOn;
 }
 
 static u8 ar9003_xatten1_db_high(struct ath_hw *ah, int chain)
 {
-	return ah->eeprom.ar9300_eep_v1.base_ext2.xatten1DBHigh[chain];
+	return AR_SREV_AR9300_EEPROM_V2(ah) ?
+		       ah->eeprom.ar9300_eep_v2.base_ext2.xatten1DBHigh[chain] :
+			     ah->eeprom.ar9300_eep_v1.base_ext2.xatten1DBHigh[chain];
 }
 
 static u8 ar9003_xatten1_db_low(struct ath_hw *ah, int chain)
 {
-	return ah->eeprom.ar9300_eep_v1.base_ext2.xatten1DBLow[chain];
+	return AR_SREV_AR9300_EEPROM_V2(ah) ?
+		       ah->eeprom.ar9300_eep_v2.base_ext2.xatten1DBLow[chain] :
+			     ah->eeprom.ar9300_eep_v1.base_ext2.xatten1DBLow[chain];
 }
 
 static u8 ar9003_xatten1_db_margin_high(struct ath_hw *ah, int chain)
 {
-	return ah->eeprom.ar9300_eep_v1.base_ext2.xatten1MarginHigh[chain];
+	return AR_SREV_AR9300_EEPROM_V2(ah) ?
+		       ah->eeprom.ar9300_eep_v2.base_ext2
+			       .xatten1MarginHigh[chain] :
+			     ah->eeprom.ar9300_eep_v1.base_ext2
+			       .xatten1MarginHigh[chain];
 }
 
 static u8 ar9003_xatten1_db_margin_low(struct ath_hw *ah, int chain)
 {
-	return ah->eeprom.ar9300_eep_v1.base_ext2.xatten1MarginLow[chain];
+	return AR_SREV_AR9300_EEPROM_V2(ah) ? ah->eeprom.ar9300_eep_v2.base_ext2
+						      .xatten1MarginLow[chain] :
+						    ah->eeprom.ar9300_eep_v1.base_ext2
+						      .xatten1MarginLow[chain];
 }
 
 static u8 ar9003_xatten1_db(struct ath_hw *ah, int chain, bool is2ghz)
 {
-	return ar9003_modal_header(ah, is2ghz)->xatten1DB[chain];
+	return AR_SREV_AR9300_EEPROM_V2(ah) ?
+		       ar9003_modal_header_v2(ah, is2ghz)->xatten1DB[chain] :
+			     ar9003_modal_header_v1(ah, is2ghz)->xatten1DB[chain];
 }
 
 static u8 ar9003_xatten1_margin(struct ath_hw *ah, int chain, bool is2ghz)
 {
-	return ar9003_modal_header(ah, is2ghz)->xatten1Margin[chain];
+	return AR_SREV_AR9300_EEPROM_V2(ah) ?
+		       ar9003_modal_header_v2(ah, is2ghz)->xatten1Margin[chain] :
+			     ar9003_modal_header_v1(ah, is2ghz)->xatten1Margin[chain];
 }
 
 static u8 ar9003_xlna_bias_strength(struct ath_hw *ah, bool is2ghz)
 {
-	return ar9003_modal_header(ah, is2ghz)->xlna_bias_strength;
+	return AR_SREV_AR9300_EEPROM_V2(ah) ?
+		       ar9003_modal_header_v2(ah, is2ghz)->xlna_bias_strength :
+			     ar9003_modal_header_v1(ah, is2ghz)->xlna_bias_strength;
 }
 
 static u8 ar9003_xpa_bias_lvl(struct ath_hw *ah, bool is2ghz)
 {
-	return ar9003_modal_header(ah, is2ghz)->xpaBiasLvl;
+	return AR_SREV_AR9300_EEPROM_V2(ah) ?
+		       ar9003_modal_header_v2(ah, is2ghz)->xpaBiasLvl :
+			     ar9003_modal_header_v1(ah, is2ghz)->xpaBiasLvl;
 }
 
 static u8 *ar9003_mac_addr(struct ath_hw *ah)
 {
-	return ah->eeprom.ar9300_eep_v1.macAddr;
+	return AR_SREV_AR9300_EEPROM_V2(ah) ? ah->eeprom.ar9300_eep_v2.macAddr :
+						    ah->eeprom.ar9300_eep_v1.macAddr;
 }
 
 static u16 ar9003_switch_com_spdt_get(struct ath_hw *ah, bool is2ghz)
 {
-	return le16_to_cpu(ar9003_modal_header(ah, is2ghz)->switchcomspdt);
+	__le16 val = AR_SREV_AR9300_EEPROM_V2(ah) ?
+			     ar9003_modal_header_v2(ah, is2ghz)->switchcomspdt :
+				   ar9003_modal_header_v1(ah, is2ghz)->switchcomspdt;
+	return le16_to_cpu(val);
 }
 
 static u32 ath9k_hw_ar9300_get_eeprom(struct ath_hw *ah,
@@ -3512,7 +3658,10 @@ static int ar9300_eeprom_restore_internal(struct ath_hw *ah,
 	int it;
 	u16 checksum, mchecksum;
 	struct ath_common *common = ath9k_hw_common(ah);
-	struct ar9300_eeprom_v1 *eep;
+	union {
+		struct ar9300_eeprom_v1 v1;
+		struct ar9300_eeprom_v2 v2;
+	} *eep;
 	eeprom_read_op read;
 
 	if (ath9k_hw_use_flash(ah)) {
@@ -3522,8 +3671,10 @@ static int ar9300_eeprom_restore_internal(struct ath_hw *ah,
 			return -EIO;
 
 		/* check if eeprom contains valid data */
-		eep = (struct ar9300_eeprom_v1 *) mptr;
-		txrx = eep->baseEepHeader.txrxMask;
+		eep = (void *)mptr;
+		txrx = AR_SREV_AR9300_EEPROM_V2(ah) ?
+			       eep->v2.baseEepHeader.txrxMask :
+				     eep->v1.baseEepHeader.txrxMask;
 		if (txrx != 0 && txrx != 0xff)
 			return 0;
 	}
@@ -3625,10 +3776,12 @@ static int ar9300_eeprom_restore_internal(struct ath_hw *ah,
  */
 static bool ath9k_hw_ar9300_fill_eeprom(struct ath_hw *ah)
 {
-	u8 *mptr = (u8 *) &ah->eeprom.ar9300_eep_v1;
+	u8 *mptr = (u8 *)&ah->eeprom;
+	int mdata_size = AR_SREV_AR9300_EEPROM_V2(ah) ?
+				 sizeof(struct ar9300_eeprom_v2) :
+				       sizeof(struct ar9300_eeprom_v1);
 
-	if (ar9300_eeprom_restore_internal(ah, mptr,
-			sizeof(struct ar9300_eeprom_v1)) < 0)
+	if (ar9300_eeprom_restore_internal(ah, mptr, mdata_size) < 0)
 		return false;
 
 	return true;
@@ -3638,32 +3791,44 @@ static bool ath9k_hw_ar9300_fill_eeprom(struct ath_hw *ah)
 
 static int8_t ar9003_adc_desired_size(struct ath_hw *ah, bool is2ghz)
 {
-	return ar9003_modal_header(ah, is2ghz)->adcDesiredSize;
+	return AR_SREV_AR9300_EEPROM_V2(ah) ?
+		       ar9003_modal_header_v2(ah, is2ghz)->adcDesiredSize :
+			     ar9003_modal_header_v1(ah, is2ghz)->adcDesiredSize;
 }
 
 static u8 ar9003_switch_settling(struct ath_hw *ah, bool is2ghz)
 {
-	return ar9003_modal_header(ah, is2ghz)->switchSettling;
+	return AR_SREV_AR9300_EEPROM_V2(ah) ?
+		       ar9003_modal_header_v2(ah, is2ghz)->switchSettling :
+			     ar9003_modal_header_v1(ah, is2ghz)->switchSettling;
 }
 
 static u8 ar9003_tx_clip(struct ath_hw *ah, bool is2ghz)
 {
-	return ar9003_modal_header(ah, is2ghz)->txClip;
+	return AR_SREV_AR9300_EEPROM_V2(ah) ?
+		       ar9003_modal_header_v2(ah, is2ghz)->txClip :
+			     ar9003_modal_header_v1(ah, is2ghz)->txClip;
 }
 
 static u8 ar9003_tx_frame_to_data_start(struct ath_hw *ah, bool is2ghz)
 {
-	return ar9003_modal_header(ah, is2ghz)->txFrameToDataStart;
+	return AR_SREV_AR9300_EEPROM_V2(ah) ?
+		       ar9003_modal_header_v2(ah, is2ghz)->txFrameToDataStart :
+			     ar9003_modal_header_v1(ah, is2ghz)->txFrameToDataStart;
 }
 
 static u8 ar9003_tx_frame_to_pa_on(struct ath_hw *ah, bool is2ghz)
 {
-	return ar9003_modal_header(ah, is2ghz)->txFrameToPaOn;
+	return AR_SREV_AR9300_EEPROM_V2(ah) ?
+		       ar9003_modal_header_v2(ah, is2ghz)->txFrameToPaOn :
+			     ar9003_modal_header_v1(ah, is2ghz)->txFrameToPaOn;
 }
 
 static int8_t ar9003_volt_slope(struct ath_hw *ah, bool is2ghz)
 {
-	return ar9003_modal_header(ah, is2ghz)->voltSlope;
+	return AR_SREV_AR9300_EEPROM_V2(ah) ?
+		       ar9003_modal_header_v2(ah, is2ghz)->voltSlope :
+			     ar9003_modal_header_v1(ah, is2ghz)->voltSlope;
 }
 
 static u32 ar9003_dump_modal_eeprom(struct ath_hw *ah, char *buf, u32 len,
@@ -5768,17 +5933,27 @@ s32 ar9003_hw_get_rx_gain_idx(struct ath_hw *ah)
 
 u8 *ar9003_get_spur_chan_ptr(struct ath_hw *ah, bool is2ghz)
 {
-	return ar9003_modal_header(ah, is2ghz)->spurChans;
+	return AR_SREV_AR9300_EEPROM_V2(ah) ?
+		       ar9003_modal_header_v2(ah, is2ghz)->spurChans :
+			     ar9003_modal_header_v1(ah, is2ghz)->spurChans;
 }
 
 u32 ar9003_get_paprd_rate_mask_ht20(struct ath_hw *ah, bool is2ghz)
 {
-	return le32_to_cpu(ar9003_modal_header(ah, is2ghz)->papdRateMaskHt20);
+	__le32 val =
+		AR_SREV_AR9300_EEPROM_V2(ah) ?
+			ar9003_modal_header_v2(ah, is2ghz)->papdRateMaskHt20 :
+			      ar9003_modal_header_v1(ah, is2ghz)->papdRateMaskHt20;
+	return le32_to_cpu(val);
 }
 
 u32 ar9003_get_paprd_rate_mask_ht40(struct ath_hw *ah, bool is2ghz)
 {
-	return le32_to_cpu(ar9003_modal_header(ah, is2ghz)->papdRateMaskHt40);
+	__le32 val =
+		AR_SREV_AR9300_EEPROM_V2(ah) ?
+			ar9003_modal_header_v2(ah, is2ghz)->papdRateMaskHt40 :
+			      ar9003_modal_header_v1(ah, is2ghz)->papdRateMaskHt40;
+	return le32_to_cpu(val);
 }
 
 unsigned int ar9003_get_paprd_scale_factor(struct ath_hw *ah,
diff --git a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.h b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.h
index b020092e8..8516d9705 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.h
+++ b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.h
@@ -42,6 +42,7 @@
 #define AR9300_CUSTOMER_DATA_SIZE    20
 
 #define AR9300_EEPROM_V1_MAX_CHAINS  3
+#define AR9300_EEPROM_V2_MAX_CHAINS  4
 #define AR9300_ANT_16S               25
 #define AR9300_FUTURE_MODAL_SZ       6
 
@@ -252,6 +253,45 @@ struct ar9300_modal_eep_header_v1 {
 	u8 futureModal[7];
 } __packed;
 
+struct ar9300_modal_eep_header_v2 {
+	/* 4 idle, t1, t2, b (4 bits per setting) */
+	__le32 antCtrlCommon;
+	/* 4 ra1l1, ra2l1, ra1l2, ra2l2, ra12 */
+	__le32 antCtrlCommon2;
+	/* 6 idle, t, r, rx1, rx12, b (2 bits each) */
+	__le16 antCtrlChain[AR9300_EEPROM_V2_MAX_CHAINS];
+	/* 3 xatten1_db for AR9280 (0xa20c/b20c 5:0) */
+	u8 xatten1DB[AR9300_EEPROM_V2_MAX_CHAINS];
+	/* 3  xatten1_margin for merlin (0xa20c/b20c 16:12 */
+	u8 xatten1Margin[AR9300_EEPROM_V2_MAX_CHAINS];
+	int8_t tempSlope;
+	int8_t voltSlope;
+	/* spur channels in usual fbin coding format */
+	u8 spurChans[AR_EEPROM_MODAL_SPURS];
+	/* 3  Check if the register is per chain */
+	int8_t noiseFloorThreshCh[AR9300_EEPROM_V2_MAX_CHAINS];
+	u8 reserved[13];
+	int8_t quick_drop;
+	u8 xpaBiasLvl;
+	u8 txFrameToDataStart;
+	u8 txFrameToPaOn;
+	u8 txClip;
+	int8_t antennaGain;
+	u8 switchSettling;
+	int8_t adcDesiredSize;
+	u8 txEndToXpaOff;
+	u8 txEndToRxOn;
+	u8 txFrameToXpaOn;
+	u8 thresh62;
+	__le32 papdRateMaskHt20;
+	__le32 reserved2;
+	__le32 papdRateMaskHt40;
+	__le32 reserved3;
+	__le16 switchcomspdt;
+	u8 xlna_bias_strength;
+	u8 futureModal[7];
+} __packed;
+
 struct ar9300_cal_data_per_freq_op_loop {
 	int8_t refPower;
 	/* pdadc voltage at power measurement */
@@ -274,6 +314,10 @@ struct cal_tgt_pow_ht_v1 {
 	u8 tPow2x[14];
 } __packed;
 
+struct cal_tgt_pow_ht_v2 {
+	u8 tPow2x[18];
+} __packed;
+
 struct cal_ctl_data_2g {
 	u8 ctlEdges[AR9300_NUM_BAND_EDGES_2G];
 } __packed;
@@ -309,6 +353,15 @@ struct ar9300_BaseExtension_2_v1 {
 	u8   xatten1MarginHigh[AR9300_EEPROM_V1_MAX_CHAINS];
 } __packed;
 
+struct ar9300_BaseExtension_2_v2 {
+	int8_t    tempSlopeLow;
+	int8_t    tempSlopeHigh;
+	u8   xatten1DBLow[AR9300_EEPROM_V2_MAX_CHAINS];
+	u8   xatten1MarginLow[AR9300_EEPROM_V2_MAX_CHAINS];
+	u8   xatten1DBHigh[AR9300_EEPROM_V2_MAX_CHAINS];
+	u8   xatten1MarginHigh[AR9300_EEPROM_V2_MAX_CHAINS];
+} __packed;
+
 struct ar9300_eeprom_v1 {
 	u8 eepromVersion;
 	u8 templateVersion;
@@ -356,6 +409,53 @@ struct ar9300_eeprom_v1 {
 	struct cal_ctl_data_5g ctlPowerData_5G[AR9300_NUM_CTLS_5G];
 } __packed;
 
+struct ar9300_eeprom_v2 {
+	u8 eepromVersion;
+	u8 templateVersion;
+	u8 macAddr[6];
+	u8 custData[AR9300_CUSTOMER_DATA_SIZE];
+
+	struct ar9300_base_eep_hdr baseEepHeader;
+
+	struct ar9300_modal_eep_header_v2 modalHeader2G;
+	struct ar9300_BaseExtension_1 base_ext1;
+	u8 calFreqPier2G[AR9300_NUM_2G_CAL_PIERS];
+	struct ar9300_cal_data_per_freq_op_loop
+	 calPierData2G[AR9300_EEPROM_V2_MAX_CHAINS][AR9300_NUM_2G_CAL_PIERS];
+	u8 calTarget_freqbin_Cck[AR9300_NUM_2G_CCK_TARGET_POWERS];
+	u8 calTarget_freqbin_2G[AR9300_NUM_2G_20_TARGET_POWERS];
+	u8 calTarget_freqbin_2GHT20[AR9300_NUM_2G_20_TARGET_POWERS];
+	u8 calTarget_freqbin_2GHT40[AR9300_NUM_2G_40_TARGET_POWERS];
+	struct cal_tgt_pow_legacy
+	 calTargetPowerCck[AR9300_NUM_2G_CCK_TARGET_POWERS];
+	struct cal_tgt_pow_legacy
+	 calTargetPower2G[AR9300_NUM_2G_20_TARGET_POWERS];
+	struct cal_tgt_pow_ht_v2
+	 calTargetPower2GHT20[AR9300_NUM_2G_20_TARGET_POWERS];
+	struct cal_tgt_pow_ht_v2
+	 calTargetPower2GHT40[AR9300_NUM_2G_40_TARGET_POWERS];
+	u8 ctlIndex_2G[AR9300_NUM_CTLS_2G];
+	u8 ctl_freqbin_2G[AR9300_NUM_CTLS_2G][AR9300_NUM_BAND_EDGES_2G];
+	struct cal_ctl_data_2g ctlPowerData_2G[AR9300_NUM_CTLS_2G];
+	struct ar9300_modal_eep_header_v2 modalHeader5G;
+	struct ar9300_BaseExtension_2_v2 base_ext2;
+	u8 calFreqPier5G[AR9300_NUM_5G_CAL_PIERS];
+	struct ar9300_cal_data_per_freq_op_loop
+	 calPierData5G[AR9300_EEPROM_V2_MAX_CHAINS][AR9300_NUM_5G_CAL_PIERS];
+	u8 calTarget_freqbin_5G[AR9300_NUM_5G_20_TARGET_POWERS];
+	u8 calTarget_freqbin_5GHT20[AR9300_NUM_5G_20_TARGET_POWERS];
+	u8 calTarget_freqbin_5GHT40[AR9300_NUM_5G_40_TARGET_POWERS];
+	struct cal_tgt_pow_legacy
+	 calTargetPower5G[AR9300_NUM_5G_20_TARGET_POWERS];
+	struct cal_tgt_pow_ht_v2
+	 calTargetPower5GHT20[AR9300_NUM_5G_20_TARGET_POWERS];
+	struct cal_tgt_pow_ht_v2
+	 calTargetPower5GHT40[AR9300_NUM_5G_40_TARGET_POWERS];
+	u8 ctlIndex_5G[AR9300_NUM_CTLS_5G];
+	u8 ctl_freqbin_5G[AR9300_NUM_CTLS_5G][AR9300_NUM_BAND_EDGES_5G];
+	struct cal_ctl_data_5g ctlPowerData_5G[AR9300_NUM_CTLS_5G];
+} __packed;
+
 s32 ar9003_hw_get_tx_gain_idx(struct ath_hw *ah);
 s32 ar9003_hw_get_rx_gain_idx(struct ath_hw *ah);
 u32 ar9003_hw_ant_ctrl_common_get(struct ath_hw *ah, bool is2ghz);
diff --git a/drivers/net/wireless/ath/ath9k/hw.h b/drivers/net/wireless/ath/ath9k/hw.h
index 22349c2b7..c5111735c 100644
--- a/drivers/net/wireless/ath/ath9k/hw.h
+++ b/drivers/net/wireless/ath/ath9k/hw.h
@@ -790,6 +790,7 @@ struct ath_hw {
 		struct ar5416_eeprom_4k map4k;
 		struct ar9287_eeprom map9287;
 		struct ar9300_eeprom_v1 ar9300_eep_v1;
+		struct ar9300_eeprom_v2 ar9300_eep_v2;
 	} eeprom;
 	const struct eeprom_ops *eep_ops;
 
diff --git a/drivers/net/wireless/ath/ath9k/reg.h b/drivers/net/wireless/ath/ath9k/reg.h
index 5ec263b7f..38cf3f576 100644
--- a/drivers/net/wireless/ath/ath9k/reg.h
+++ b/drivers/net/wireless/ath/ath9k/reg.h
@@ -1000,6 +1000,7 @@
 	(AR_SREV_9340(_ah) || AR_SREV_9531(_ah) || AR_SREV_9550(_ah) || \
 	 AR_SREV_9561(_ah) || AR_SREV_5502(_ah))
 #define AR_SREV_AR9003_RXS_V2(_ah) (AR_SREV_5502(_ah))
+#define AR_SREV_AR9300_EEPROM_V2(_ah) (AR_SREV_5502(_ah))
 
 /* NOTE: When adding chips newer than Peacock, add chip check here */
 #define AR_SREV_9580_10_OR_LATER(_ah) \
-- 
2.25.1

