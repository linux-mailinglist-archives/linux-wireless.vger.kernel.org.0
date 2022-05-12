Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D59F525618
	for <lists+linux-wireless@lfdr.de>; Thu, 12 May 2022 21:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358219AbiELTya (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 May 2022 15:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358214AbiELTy2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 May 2022 15:54:28 -0400
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2077.outbound.protection.outlook.com [40.107.115.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6103E2701B2
        for <linux-wireless@vger.kernel.org>; Thu, 12 May 2022 12:54:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htPe59JqmSQMvJLkXNzLDhy+grYZiQGw0OPlcCdwY0fctI6ejU1aeWiz9TNmcpap22+Vv7LEat9+g2uto2CEpnKE0Eqgzx2ZGCe8bDzxPUi9viJ+FDNeGWTgam6e2YEV7o+eKTpLIKPodZprUMNg+kAttE/5AO0fPnm5cfXx66ColVjzFrIl4AIhmRGLthXpjuW+ViYtoVNtV4amSfmApTFWURKuK7Aj/xHbCsVU7P4wLOgkb0WUlToO7RY7OLavYOMFry8p2myaGy0IK4WWSl+r8wLGkrbwHE/POJKx+ChtLVEveOEXv5VWZPyKjde3K9qzEG6j1jW3B+AlWO901Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DeEiZ/r6YIjLF8UWRnymrAd8zm2EzyMWJwTXlr5cCzE=;
 b=Oqw3p416EpFqIr7WGKQ/PnIO0rjpFpTUxhMf5ffpXmdy11kvz64FNDPnOivLFZ6LdfMatfwnb56aNgcJsspISFPkMc/WrkwukzD8UtkBzo4+ZZmxMjjrnrVZ+jTSJAncfS/rHCApLplG5nL0vhqY/lufXw8U0APaIc+TBimiqyfHZTLJNVugajZXFd91B8qDplAOdwl/2oq+Rs8XweSwWukh5SxTfQXlTuDbUnyi0lNX9certgxZ2JnGbpTPOjbGvQ4fZmhLrJTHPwW43eglIxyk+FVBDsVQo79tdAITC8/Aqzj+TeQmN9vPKDzNFJBJ3IDDNbPEATf17V7mo5FP3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucalgary.ca; dmarc=pass action=none header.from=ucalgary.ca;
 dkim=pass header.d=ucalgary.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucalgary.ca;
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:4a::23)
 by YT3PR01MB9530.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:91::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 19:54:23 +0000
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::a17b:bb51:f663:e98f]) by YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::a17b:bb51:f663:e98f%4]) with mapi id 15.20.5227.023; Thu, 12 May 2022
 19:54:23 +0000
From:   Wenli Looi <wlooi@ucalgary.ca>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Wenli Looi <wlooi@ucalgary.ca>
Subject: [PATCH v2 6/9] ath9k: group some ar9300 eeprom functions at the top
Date:   Thu, 12 May 2022 12:53:16 -0700
Message-Id: <20220512195319.14635-7-wlooi@ucalgary.ca>
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
X-MS-Office365-Filtering-Correlation-Id: 366e07a8-4996-4a74-4723-08da3451366f
X-MS-TrafficTypeDiagnostic: YT3PR01MB9530:EE_
X-Microsoft-Antispam-PRVS: <YT3PR01MB9530BC08A69DCFD54C06A143B2CB9@YT3PR01MB9530.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BAIYWtGhTI5pLGM3RweA4HmqImTfY1Q/Kbt9azdlXNt2uaCigxjVhcYbnC/R1En5nO3LT8BnKdy/I5vs9wEI4kZfeb3/Gb3RM/Cx6wMoy72gxvZxtAFDC+iFKxuaFowEAN9rPTlTML4rpbr/Wi1dJOwu3e729DAPm4Ro+KT3BSST93khdc0DVZQYcxmkPIntdoyv6Ec4QAOwzRwpppYWzbkzfXkGfCo2Mtvy/LMm4z76WVrwkDYSpoy/GqlpJg4bqpEkYOhqXb95iL4slWOsy1kM3FQXIFgz5HKZiWIDx/V8W5IdIQZY0HXU+JpvNEAaq/TbzwM6SMBP5w0TmjB71PWyXHx/dVHjkuybbB5xVKDnJC2j+wapdGe4uvO8W0ziGlZA+RsW3/C8WnNiQ3Q3oSeOA4C6X/bBWxHsTKfl4VPLMHziHHTbcc+HM1Y/PmAesb8a0CMkOFK0dxoqPXUfwHpyKaIyyvTfEkxgSfKSY4QBtYOsvcK7wOTD5N4W2pvXQwBZurMaZvixXPiG9L7g1Of6fvP4ipuR+J/4L6QDUoU1jDgBqoikC5B7jhThssrGUdOMMtBhYNBkQIweL8CVUTDrk8bKJygKzt9PNH2jra4Yl8kSYAOZBzu51Ic/vT+7xOWSp1KkF5nDzOxXXaRmQNun/2TNR2qGhdfOOeym2MoYOYz+QH5KfZroxLrFLAKqI2hdTU1Q+nDA5iyePU1s7P6mpZr7hJnHpC3wAFAr1L0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(83380400001)(36756003)(38350700002)(6666004)(508600001)(6916009)(316002)(786003)(54906003)(2616005)(38100700002)(186003)(2906002)(4326008)(8676002)(107886003)(1076003)(86362001)(66556008)(8936002)(66946007)(66476007)(6506007)(6512007)(5660300002)(26005)(52116002)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TFBYN8R9STU3vpX/Dy19O2GDWilUAugng1Qzll8LjDIqTtPEKD2cTdZaYat8?=
 =?us-ascii?Q?JsEQfafPDkFIq/2Q894O++6NxDV5R1f/KlHX2TDNdLBv1LzrOdIzMdzkFGAY?=
 =?us-ascii?Q?1eZHKFMw16J9bU3HcAn0jlITHK3BedszorgWljtJGf0j/Y89tKSj3cDl9Qpy?=
 =?us-ascii?Q?2rkv4stzLbHOEaWAvohL10fpwZR0eCcWpdAraht0V3mnS8UcXOJrner5AVwU?=
 =?us-ascii?Q?CC4xRcOv8T2oyLikpXaDFZL3rLA+bFt2dmSjgMy9hiUhJKhXWLyYXygt0OGI?=
 =?us-ascii?Q?8K0BKjTg+YGUQgOvb0+erZQ1juWktfVpZY7ohHMk8ePgBtlipIbM8Z8uICEr?=
 =?us-ascii?Q?xyRmyxVZLt9NCD2/EQidW6AnIgAQsfbbWOJTIbE+Ff+9uCYr2mk3bNuUyWP5?=
 =?us-ascii?Q?6V+6ytjeSHwPHLCok/ARk7vys1r/zf/36A9+aIWuxRlLjv1IVn4MuHWC8fPE?=
 =?us-ascii?Q?HdfJA50kX5idsXhMgpYpw21GyAkJgTq9k2p3JmbySW1zAf4Tf+KApH7TKi9T?=
 =?us-ascii?Q?eSuVmfdBDSb11b++Ay1vJurgC8nhUjdHvRY0Uqi9GnZaIwlVjn/ZdUBP5uDe?=
 =?us-ascii?Q?w2dUbA98xYX6TGSflCZya9I8aRvvRXUeQvt5jBh+kIgh9NqLMo8vghEYdgR3?=
 =?us-ascii?Q?LSH96GanqVwu27oJJPduE194LDZzpmTSlI/nNOShI2BZ6QlYp0dtDvlGd0YC?=
 =?us-ascii?Q?F2ZfxURlN+ifnsaxdI8A08U4zdIvpXEn1WPNCsmUgB9Exog2m/MsBnM4Qhc+?=
 =?us-ascii?Q?3kjlmsh8+jdEJIb7Xx8RdD4a0nN1CgebX1J75Aj2CioSb0jvUbOugLRK0dVW?=
 =?us-ascii?Q?4JWqn2x0gryP33KeelCyTUIy3vItRnrBCs8dBMbaWcK4/QJpsgoH+GSDTp5N?=
 =?us-ascii?Q?FhDhLVclff5sbB/JTurtg/uNhwA5OlnMuy4bBDF5FBxH/d/SF3Dhw0Ittyq3?=
 =?us-ascii?Q?8u+4B2gj2Zz4YruY3DXBlTmdacC/80CDc6TTPz/xznBJc7K4H1d4G537sJtG?=
 =?us-ascii?Q?qrlNqj4ygdudkDGxIJKWF2mtS+8OiyWcYJ77Sj0nCSX3EOSspOd/BUzVYlkC?=
 =?us-ascii?Q?TO2LKqOVIA/QrhvFkqWdnfRBv3Fpd6xA1DhSD+s1t1U9rAdoDqtcQuMEE46p?=
 =?us-ascii?Q?qdS3VulaAVc+VrGwkUG6ChAe0RNrbdaTaynFJEpYZOLO2elyVGAmT/zO3DXb?=
 =?us-ascii?Q?UwhfiKoTCO8C81ozk7RcOyl2Ao34g3Yr5LhMAv7ENq8VKVi7Zj05oetdbTPr?=
 =?us-ascii?Q?BXS2nn39A0kNYnpv/uZFy9g8DjzZcm/Y7zp3ZbrpMYhk14HYs6yFB5QQ3j6k?=
 =?us-ascii?Q?E55dERDXlRp9HWcv9yrRTloJmfL4bNvAx6y/raAIbx8tTGZ0KMqw1zSgzF00?=
 =?us-ascii?Q?Mb8TmgOEIZLPs37XURE25qseoM2nEEWzd0BuJPyN9R7NeUZgTFfUe2NIczxz?=
 =?us-ascii?Q?OKBaljAP9n5Ljm+nwSpJ6RGcnzP4oGo0WnvUTr3iYiLsTx75jDMnrIA2yM5C?=
 =?us-ascii?Q?US7KN0qRHij/5WKkdM52DvZxfnxTLdIwmuKTAm0QZvKSVpalCCZB+Vt5AY9I?=
 =?us-ascii?Q?3Y9fHy3F9ZgRhZkaeYOXZVEU2AM3vuFtJI3m8HV029ODdPYOFRgDsB1n51q8?=
 =?us-ascii?Q?ezRBdFEcOt7hZyxywXDrela3ptothWB2qfL2ejuSiZBXQUfo720hwloZWZpB?=
 =?us-ascii?Q?q6P7Dq3z6FXJ4Q8HBzNaCOBfwACDrz3YtWQtsHynT/LE9Xf2Uhmci1IR48X1?=
 =?us-ascii?Q?dEdBeeEV7A=3D=3D?=
X-OriginatorOrg: ucalgary.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 366e07a8-4996-4a74-4723-08da3451366f
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 19:54:23.8322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c609a0ec-a5e3-4631-9686-192280bd9151
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jKD4mGx5qgxIBufAW+LuieANgTyLoCEvYfDfDx5f7ZC1asKQV8vlioOIh6NmMvc1d7oz1kFrZqPMUFmaUWDidg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9530
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

These functions will be part of an abstraction layer that works with
both old and new AR9300 eeprom formats.

Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>
---
 .../net/wireless/ath/ath9k/ar9003_eeprom.c    | 90 +++++++++----------
 1 file changed, 45 insertions(+), 45 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
index 49be3a315..6257d74c6 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
@@ -2970,6 +2970,51 @@ static int interpolate(int x, int xa, int xb, int ya, int yb)
 	return ya + factor + plus;
 }
 
+/* XXX: review hardware docs */
+static int ath9k_hw_ar9300_get_eeprom_ver(struct ath_hw *ah)
+{
+	return ah->eeprom.ar9300_eep.eepromVersion;
+}
+
+/* XXX: could be read from the eepromVersion, not sure yet */
+static int ath9k_hw_ar9300_get_eeprom_rev(struct ath_hw *ah)
+{
+	return 0;
+}
+
+static struct ar9300_modal_eep_header *ar9003_modal_header(struct ath_hw *ah,
+							   bool is2ghz)
+{
+	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
+
+	if (is2ghz)
+		return &eep->modalHeader2G;
+	else
+		return &eep->modalHeader5G;
+}
+
+static u16 ar9003_hw_ant_ctrl_chain_get(struct ath_hw *ah, int chain,
+					bool is2ghz)
+{
+	__le16 val = ar9003_modal_header(ah, is2ghz)->antCtrlChain[chain];
+	return le16_to_cpu(val);
+}
+
+u32 ar9003_hw_ant_ctrl_common_get(struct ath_hw *ah, bool is2ghz)
+{
+	return le32_to_cpu(ar9003_modal_header(ah, is2ghz)->antCtrlCommon);
+}
+
+u32 ar9003_hw_ant_ctrl_common_2_get(struct ath_hw *ah, bool is2ghz)
+{
+	return le32_to_cpu(ar9003_modal_header(ah, is2ghz)->antCtrlCommon2);
+}
+
+static u16 ar9003_switch_com_spdt_get(struct ath_hw *ah, bool is2ghz)
+{
+	return le16_to_cpu(ar9003_modal_header(ah, is2ghz)->switchcomspdt);
+}
+
 static u32 ath9k_hw_ar9300_get_eeprom(struct ath_hw *ah,
 				      enum eeprom_param param)
 {
@@ -3578,29 +3623,6 @@ static u32 ath9k_hw_ar9003_dump_eeprom(struct ath_hw *ah, bool dump_base_hdr,
 }
 #endif
 
-/* XXX: review hardware docs */
-static int ath9k_hw_ar9300_get_eeprom_ver(struct ath_hw *ah)
-{
-	return ah->eeprom.ar9300_eep.eepromVersion;
-}
-
-/* XXX: could be read from the eepromVersion, not sure yet */
-static int ath9k_hw_ar9300_get_eeprom_rev(struct ath_hw *ah)
-{
-	return 0;
-}
-
-static struct ar9300_modal_eep_header *ar9003_modal_header(struct ath_hw *ah,
-							   bool is2ghz)
-{
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
-
-	if (is2ghz)
-		return &eep->modalHeader2G;
-	else
-		return &eep->modalHeader5G;
-}
-
 static void ar9003_hw_xpa_bias_level_apply(struct ath_hw *ah, bool is2ghz)
 {
 	int bias = ar9003_modal_header(ah, is2ghz)->xpaBiasLvl;
@@ -3622,28 +3644,6 @@ static void ar9003_hw_xpa_bias_level_apply(struct ath_hw *ah, bool is2ghz)
 	}
 }
 
-static u16 ar9003_switch_com_spdt_get(struct ath_hw *ah, bool is2ghz)
-{
-	return le16_to_cpu(ar9003_modal_header(ah, is2ghz)->switchcomspdt);
-}
-
-u32 ar9003_hw_ant_ctrl_common_get(struct ath_hw *ah, bool is2ghz)
-{
-	return le32_to_cpu(ar9003_modal_header(ah, is2ghz)->antCtrlCommon);
-}
-
-u32 ar9003_hw_ant_ctrl_common_2_get(struct ath_hw *ah, bool is2ghz)
-{
-	return le32_to_cpu(ar9003_modal_header(ah, is2ghz)->antCtrlCommon2);
-}
-
-static u16 ar9003_hw_ant_ctrl_chain_get(struct ath_hw *ah, int chain,
-					bool is2ghz)
-{
-	__le16 val = ar9003_modal_header(ah, is2ghz)->antCtrlChain[chain];
-	return le16_to_cpu(val);
-}
-
 static void ar9003_hw_ant_ctrl_apply(struct ath_hw *ah, bool is2ghz)
 {
 	struct ath_common *common = ath9k_hw_common(ah);
-- 
2.25.1

