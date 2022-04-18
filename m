Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D47C504D21
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Apr 2022 09:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236953AbiDRHXE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Apr 2022 03:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236961AbiDRHXD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Apr 2022 03:23:03 -0400
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2055.outbound.protection.outlook.com [40.107.115.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADA517056
        for <linux-wireless@vger.kernel.org>; Mon, 18 Apr 2022 00:20:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLl+8qz0lWNGY3HZIfxwqoYa8JOYyOrdZFKl/BjrzEB3UlkNgvLn+wySWqb54obVkh3EemlPJB15/IL/iQANweAGctlafZxq27cU1a8/vZAMk69y5nrC774eECFTJnZxwipidCMYDGTOKx/Lh7MTc/jFIhvVys/sApPHNuWJfl5d5hUVlnyPIQPKvYCWH1YLkviVIIIx//1MGAMafLxVrdwCrllGgyA/fgIDhqa1qSVV5wik3tRb8ODAjamMsspmge6KX285p3EAPI7SedjpNlP+KQYsQ/u/xbMi52v/RzhXh6E6ZR975uUs/1dTHHOdf8vbSr9vDrcQKOgMXKoYsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DeEiZ/r6YIjLF8UWRnymrAd8zm2EzyMWJwTXlr5cCzE=;
 b=PrqP0Rfv8Uo3Wd90AsRBdm+/2d8npbPYI876XwlzkZNfo0XeKIjZt0tdkRPI5ywxDs395McJjZEA4uCznkaHQlcv50XDdJRpVm5ptQza7SH/vAZkxPp8caoAho7dMf1yyRjL2y2xFWmIZ5xXWHSMfGNfJ7l5sd6HBfrcRQq/5pWuujA7ZP7HC62CQqO7ROxYAgMB6lf/kGGYBnaRVd6qJVJ/nLAHgRPpruifXLx+BTagG5MLGGvpzxJAs5yR63yWpkCm1z6HdVID0ZR/bKhA76AdVjSgwxoiU/MX1C+SqMxgitDJajVhjVc+X7taexVgID2tnxtaBZLPYEqh0qLi2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucalgary.ca; dmarc=pass action=none header.from=ucalgary.ca;
 dkim=pass header.d=ucalgary.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucalgary.ca;
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:4a::23)
 by YT1PR01MB4363.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 07:20:21 +0000
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::788b:f975:24ac:69f]) by YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::788b:f975:24ac:69f%6]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 07:20:21 +0000
From:   Wenli Looi <wlooi@ucalgary.ca>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        ath9k-devel@qca.qualcomm.com, Wenli Looi <wlooi@ucalgary.ca>
Subject: [PATCH 6/9] ath9k: group some ar9300 eeprom functions at the top
Date:   Mon, 18 Apr 2022 00:13:10 -0700
Message-Id: <20220418071313.882179-7-wlooi@ucalgary.ca>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220418071313.882179-1-wlooi@ucalgary.ca>
References: <20220418071313.882179-1-wlooi@ucalgary.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: SJ0PR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::9) To YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:4a::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 249eb902-273a-491d-d1b0-08da210be646
X-MS-TrafficTypeDiagnostic: YT1PR01MB4363:EE_
X-Microsoft-Antispam-PRVS: <YT1PR01MB4363C38B7D75063803DEA682B2F39@YT1PR01MB4363.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ro1mBr1Pb2TaSxngq/135sSSb/yAy+6YG+4kKQE7l9PiczM337ZnUHIu4YzVpqQfdLaWHfNeW7ZbxsqkK2z+s9dLE2NHRLzhoL70mCMOIXnI9WcP9pAEal1dii7NsvPqu/24UHI/TUjNYpV3XuY5V/kVzJduk0Bw03LCdAmYbg64JAyFXOE+uLmP7UVU0keDY+UEk4SA4qUHMCJUZkO5Axn8/dnGET4WGCxSfPE8SlkxsuXpPECIV6fFEMwIbmOkkUPq6Tf1naK+2AO3eM27HziQ729mUt4niutuUxiAdr7I7WjEpSJGg+xpglHoqnAMMowL0TjuaTqVhdcaObCmv+6ivngc6vKVztTTZXTSceOJeVRkhSQSXVNBNFgMnp9/INu5ODkq9ExjJfXm0VYW5UHYHZp0wdDHpJ5BoIpnbNCEXxa1XT4CX0/PpBfdh+C/eV8ODEl44pZZAHtrgA9mHt4LZ9FpC1STjn9P3SIB7Qvyowq6LohK5/112lof0R/6Jggj6r2aa5VD3+Q2Mb8F80s3ZbmF7MrewEScDSpQnOmfii4b7FjX5oijca+pNxTKxEfP9/Jsh7Cili+dNRTduar51o9GwpGGDyNKwc34vmIOSEYTUcznNhjf71C+I4PdY+w5jjIzgvLjRoNTY8OX9bcirpVobs7+/k2SNcNU1PpUD9lxRyLyiUSO/Y8OVTDs7C5Jb2dXbnb90YhmdboEwVTiCIiW+6iE+Jx5EFju+bc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(86362001)(83380400001)(6666004)(6916009)(54906003)(66946007)(316002)(186003)(26005)(786003)(38350700002)(6486002)(38100700002)(107886003)(2616005)(1076003)(4326008)(8676002)(66476007)(66556008)(508600001)(8936002)(6506007)(36756003)(52116002)(2906002)(6512007)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EQGy+CvcyX06x3d8Sx/fZdi5oo0fmDtRwiB6QARRWGTZO0PJFlOn5MdndXAb?=
 =?us-ascii?Q?m3uLp0PEip9BEedf6ct2dusQWvbKzto0RhdvXNZ5bAfmodSrGMbOokXBKN5I?=
 =?us-ascii?Q?Cx4GPpeZoyS5WaSpD5R+tpq6wG3pXWVYT/iOvrE6h1EzB6eaT0BGxm0lOo3h?=
 =?us-ascii?Q?qqEZVcW7r86lPZZd8qx6Ls00vMP234yHNtUNTZrY94S6g9jl5X6vKetwR8O7?=
 =?us-ascii?Q?b+TxlZB1/bi2YzQBWfucx0Udvy/1VSqJXvf4goOXGL5Q8cD4QdbPFry250Pm?=
 =?us-ascii?Q?5HKSDaFTvmJHomKe5F2vOoa3oAlX05eOsPFdhLjfWXHU3Jq2zPqv7GaQKHba?=
 =?us-ascii?Q?0Me2yvYJI6vHFPHz8EMytvvqHvYgsH5CxQaU7fh3e+DzyVjAXFM0j9+1W0jn?=
 =?us-ascii?Q?H2VfWfupDfEB5GbEgX0trw4LVBShqzoPE4yL97o2VMlBd+nHl7R8O7CEbhxE?=
 =?us-ascii?Q?LFqv66UmMFC/hXBhkzYFwmwThqR2Y5M08claC4mZZFez0ByTv/ADKpqbvnzW?=
 =?us-ascii?Q?b/2HIIti6zCrdlB0n9KTUxpLfd1ZImSQSgCdTsHy6uFlotEX8AKO66nMhNMN?=
 =?us-ascii?Q?O8+54WrOP2ANK5UD3rAPVVIWE50j+WVlKsmon6AoTQMFxGqnO7C6jMnvxyXv?=
 =?us-ascii?Q?fPwauCSPoqCqV5IexR+KtK4hUQB/7/yfwevrR3J4aAQexz9yCm83YRWXG+Pw?=
 =?us-ascii?Q?7DUlZDG+l57q/5FI1aQqHNcgoEXAggxM/j/rWMUi3TkCV7/IDJzQG35ZuPSF?=
 =?us-ascii?Q?AmOSwQBbZhORfFzG2u1SFFLrSClm6iSfmnVtlZgqrAJhNy9a7QWuKBa87eXj?=
 =?us-ascii?Q?yTzeN8aVioV34LnC29aIcqinjcuJQq0v/sonRtAqhwM8Z4btbINHSCpBC4Tn?=
 =?us-ascii?Q?GtshacQ7mBuTVRwntwxleYqw7POC+99IOUg2l3J9+Yh9A4MPp3a+X4t3oD4Y?=
 =?us-ascii?Q?sfx+4RUwrSEeJxrpL2mMzQkubW+Uh4BAhfMHXxcUvL4C8kgI/V7NC3mOTGCb?=
 =?us-ascii?Q?0X941xogvGIzLjyJK0wM7GdqIQ8r8Yu8/l/PIrf2ZXY1QV6IzLDKJo32Iyjn?=
 =?us-ascii?Q?vSfmtT6vdjvcPE41TV7alUBmiyhRp4rB1nClMg1ieJ+LWGVr0zi3cJ7mgxa4?=
 =?us-ascii?Q?TlqZRbJdkRECM9B0cAK4v214A6LqyWFE+9upT/f6edxEWHaVt7gC8yM4n9eB?=
 =?us-ascii?Q?cTKV5sUBQMhrC/tco/uIqCEhC3ay6W6bcfRaro8RJ/hzMP/yXHRzl0gU7zBo?=
 =?us-ascii?Q?2lHH0ogNcWGUtCiy4dEwD4sitOfZaRouaXiSXcrBB3rWBMxiE4B/GNBOpIbK?=
 =?us-ascii?Q?DLTU38JzpqtJGQ/2shKI0IbFtuzCemB66TRsq6ZRJUVWyWoSBteON+aDEdpu?=
 =?us-ascii?Q?4bfcPjzUZbvVast44w+uL4PbIjwThzy7FgUiPuSufG9L4AQH3ZN7/xMvZP1V?=
 =?us-ascii?Q?De/Wf4kikT+vq9gejro7u7e6yrse3L71ysU0dI2jywd+yT64EwKwrVhhLij8?=
 =?us-ascii?Q?7fhjk3rThlRF7WbKFfpFPvS7Cwu0OAGRWwyxNsTLGYA44eGFNAsDyaejw3CH?=
 =?us-ascii?Q?twCxjR13BiEE9Z6BiQCC7Y4ukaBbLpigCTlPzzPlVUC7A1qvs7ELxe7QVd2E?=
 =?us-ascii?Q?aMtIiDyh1C4lfy7AFALExn9LoyC45OUNbNvKM5idqCJMYqcO371+p1k7GqhN?=
 =?us-ascii?Q?6efcSrfsqJ44zWDhMMzoVaJKIlVjmKvZY8DBEbSLkPgM1TVDn8iUZizXvTXH?=
 =?us-ascii?Q?DpNlDySUTg=3D=3D?=
X-OriginatorOrg: ucalgary.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 249eb902-273a-491d-d1b0-08da210be646
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2022 07:20:21.8885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c609a0ec-a5e3-4631-9686-192280bd9151
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8vVbIb2uKiFKrluGUPxH3FvoQ757RgrFqYxjXpNQdpaE2IS9nTWCadJUYwR7WWuuF+y86xEit6fvVhV6HB5ozA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB4363
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

