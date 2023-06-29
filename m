Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C5F7430F1
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jun 2023 01:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjF2XQy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Jun 2023 19:16:54 -0400
Received: from mail-yqbcan01on2069.outbound.protection.outlook.com ([40.107.116.69]:57870
        "EHLO CAN01-YQB-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230415AbjF2XQu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Jun 2023 19:16:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KC1K17wh9yLpGtHqYBt25tx8rQI4yAm0nWDeXV1OklYGWynDABAbd+7zdGJNBr/ubKfkGGaabOHtpy6Pve62F1vZrrBPTuIXrw1IYj6IiUH3lHabCZZ+WdY4FwKyGk58CDSc8aRCgQ+V5aKStAnAFLE7YoJPW2rk6yMV0ftHASNF4COyIfIQygOGFb9BZ2VL0VzqaS1fDlvjtuma/2AuTUOn/fHxKD7PifCJI92A/b2eWWGXZdHM55VhYCDicVlnvwCbzamN3leBAiBvx3Kqhyaa+MXcd5Xc+OJXaVAmzFpD/K6FfTD/PRMYxb3iAwosdMJfPZx1nsMGMJisRiBWCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahZxxTtvb03E64NQPTS/WByP8+M2b6EwlDcgV/PPxX4=;
 b=g/UNHtvY7QTHSwXcPbhXVY+XMff7PsQASDhiR4cTIv0Lb2oWKBs6e6O8Dnrn5FFYKCHHvSBjXBOy9WojStzLQMdOug9+edokBG6mqiG951/iVwRL39qgNigE3/5oUIJyuUUYv+mlPvx9I0V6GbQgJqIzy9zaPvCjNTmD6YpkgbUPIJ33DZ/a/R42qJGHVRjWz/g3h9Ppw+ZkCtap31/LGy2wFbiYPKTlMJi/OSTqpMHJPmLhUpMUStCytSjqQvXXXEHTFDKJv4sY3kli1BC37hMQpJf/jUGXftbogwJL0TiKuV7K0lnz6Z7GYJ0tYfZYwUCTzgFr0J/hlKxLb8nlqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucalgary.ca; dmarc=pass action=none header.from=ucalgary.ca;
 dkim=pass header.d=ucalgary.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucalgary.ca;
Received: from YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:16::19)
 by YT3PR01MB6082.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:5f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 23:16:48 +0000
Received: from YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::684c:a6dd:94c8:78bc]) by YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::684c:a6dd:94c8:78bc%4]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 23:16:48 +0000
From:   Wenli Looi <wlooi@ucalgary.ca>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [PATCH v3 01/11] wifi: ath9k: group some ar9300 eeprom functions at the top
Date:   Thu, 29 Jun 2023 16:16:15 -0700
Message-Id: <20230629231625.951744-2-wlooi@ucalgary.ca>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230629231625.951744-1-wlooi@ucalgary.ca>
References: <20230629231625.951744-1-wlooi@ucalgary.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: BY3PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::7) To YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:16::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YTBPR01MB3310:EE_|YT3PR01MB6082:EE_
X-MS-Office365-Filtering-Correlation-Id: 6778d28f-e6ec-43a0-4ff0-08db78f6e94e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uKICYkXMENiudpRhg1Y4YE6baEGo2dcOIDek20l2hmeTFGL6m9N2mEzBqm7W7lt9a7+ZZLy32LKoMYhcLjg22+tUEh/Syg7TiHKGZv3BnPjNc0I3vTLA6tJ/j0WDtuuFwLW2sG0cTnq2+YDDN23ds0l/i0eu0yvOD8PRa97OB1NCWg0wur0ByDTOm1IpeIW5nIJXZOX+/h7u6spf4A6a+jNN2RNwDDYACqScknQ/G2h29FsQFVWyXlhy1PXOHam/8YD149Z7Jxrd50NV28ilIY8zRDud6ks9UyfDER6UArAewYjrgd6XHgXETACcDOlaaaWXfI5i4qisLM2qUBmGzf3UHHlS7/Bq2JRd7A6lskzL4PGJhv7Giqjx2at0r0DyUN/2RyvHYJ0SJAH1bDwB7KVMLTCeW6KLUUu5GYBkhCuAnK2GpZEiv2UqU3C2FQJonUEEqM5QPVWuZa8RItDtwIiS+ucm3+Tv+3M1/wvPsjqX1DQVAbM++KKP7pkhCgkZC6H7k5DQcCwZrEDuFOM419xhmdWP2BTT5lOby8hQ4PNF0HC+8L/SXcBcWjfCK4V+9+/tf4T32JfKCu9LPKNq+AJ26sqSFMrpj6TkE37XWwU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199021)(6506007)(1076003)(36756003)(8676002)(2906002)(6512007)(6486002)(478600001)(83380400001)(6666004)(2616005)(186003)(26005)(5660300002)(316002)(86362001)(6916009)(41300700001)(66476007)(8936002)(4326008)(38100700002)(786003)(66946007)(66556008)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4Qk6n1XQgkXfsIZt2EvuE0LzzO534XNycQTQ9TTOj4FvAq5KgeNHko+jRntY?=
 =?us-ascii?Q?0Plgiu70O6ksKsNVFvMvTecmXiU0OCUc9qP/55OHcmhoreUsy9ams+jdmwOR?=
 =?us-ascii?Q?a3V87nV0g9CteUeTQ6SWuqEJTbQsDV+bdjE4TeB3YCbeFrIZtmv1YMWS4lxy?=
 =?us-ascii?Q?GQ6KcKxzfixROfd7Yr71vB1uytM7KZ2Ar59nVKWLidElvrxtu1ceNA0dVh5o?=
 =?us-ascii?Q?8aEVNFBvnvTwmlS/vjQml2L8JTrR4XvmwtFSziGiaAL6bDwyynuUGkynmkvP?=
 =?us-ascii?Q?3zalCwE2G2IrISJhh0oAy/ChQlS5nx3MvQYtSoQM1/Hc4ykjbZ0Ck5FFCE8Y?=
 =?us-ascii?Q?Xfim4Cw0axRD+GkoTW/t6kqKFB5l3H0IPzm1JbHrvG3lJR26vcm/G3cqThVP?=
 =?us-ascii?Q?NFgtKg1pvkVG6nTf5u+nBVLWa0uMNY/UTdnQNrFvv+cwmiOzQ0jsmrlyR66k?=
 =?us-ascii?Q?OLDN/nQ+5tXdsgP3JvVyUZXuw6uU3Rkd0MByQv3Zcw4Yne9oMbhmO8MOpuvC?=
 =?us-ascii?Q?mgbP7dDtAPfR4RdkQfh0tLYGXuazap1oGEyJFcNVFpkRaKXTZFncK7LniCeo?=
 =?us-ascii?Q?ssvpWV1KJ0LJnfCNFQXvnx+hPehQJtxMU4dswGVQHQNUJQ8Ke+Jm3qTojAzw?=
 =?us-ascii?Q?9gxAF5R/2rkyP7Ouj7jVVL7vS3Fr0GYIhKcq/EnrPXHe+ItoYQFzJz7XUcwv?=
 =?us-ascii?Q?ROZmswkEP0WvcHDbaA5H+z0X8EoRp7URfiBsoCKdkSbvSlqyoD0D1QxnS0ep?=
 =?us-ascii?Q?inLr+Kpzi6AGGb/HVGfQmZTpQJdzbMIOp9PmGZGvCoWzxhKefjQYNSOvAGGl?=
 =?us-ascii?Q?YAN7hqMRlj4a9ODohpIumSGjmRq5oZvgZiRowG3at/ShX/PGEmHqy+iMazMz?=
 =?us-ascii?Q?D/9Ch2CaH+zfs3aDrYOPskGfQprrK3Q0ZZ2wY7xw0mvdCQGDNU2m8fgvkNGX?=
 =?us-ascii?Q?cAVpas6X9uB7BZ/RGFhGHcbRKsfWFM5/1JHpEC9UtL3xUAGK+KIIwxH+Z8gl?=
 =?us-ascii?Q?JEHS5rL/y2ym2XQS2DVxb92tSAQvkRwg6w4LVeRuwMskILAjuf1u6IPC8fkW?=
 =?us-ascii?Q?CNJS/KsWKF5Rp8L0TF1Nm1esJ87nYOQQSzN14xw8ubcZ+ST26aLOkqET1d2A?=
 =?us-ascii?Q?4l9Usm8YEb6NYG/mtIfVLr5Pf6FiR5oho1j5jrqnGJ21A934vgDCqEQPR5Al?=
 =?us-ascii?Q?CXxXf+BIqUm8f7ytKbLwp5GyrPo6Zg8vtkpgJFE649wvMtQ2/cqJFeeg9Abc?=
 =?us-ascii?Q?R72Hxrc/+hDR1wPuL+JA+Uyo0VsbtGUbOl4xaUm60qzs70fbwht3mguMWick?=
 =?us-ascii?Q?bBH97hHGM38bW8NOFe5/1CH1zwxKJL3XKcRK0WexwfJ1i6pd8ECikHyuPhmN?=
 =?us-ascii?Q?t/ZEsLdTLZZcVIlc3E47zSUxMdtdWwGiNeEaxJ/jmmxF8L9QTnadZ+eCYyIi?=
 =?us-ascii?Q?H/EhoXFgTTg/C9gCdGd+me/q7E70vmSx0GcmxEGQ2e2NtAOA/O1FJ8sfjpZH?=
 =?us-ascii?Q?BUWw2XtHbF0KIITIVHQzN8CQ3k1aQRkaiVLAMYgdhPbc+FvKg3rXRUGtpcAQ?=
 =?us-ascii?Q?GpE35m5QzupyG4CKZ1yVCJMz3nZKkY5Nxvph2Szk?=
X-OriginatorOrg: ucalgary.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 6778d28f-e6ec-43a0-4ff0-08db78f6e94e
X-MS-Exchange-CrossTenant-AuthSource: YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 23:16:48.0131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c609a0ec-a5e3-4631-9686-192280bd9151
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3RUg7wbCBb0f+7bZ0bPg3pgOGsfD41CywVf+X1Q4ZVXMLgij/BCkIi4N2MJfaw+UkJkZUJ/GmYHulz3vCB8Jbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB6082
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

These functions will be part of an abstraction layer that works with
both AR9300 and QCN5502 EEPROM formats.

This change does not appear to affect the final binary.

Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>
---
 .../net/wireless/ath/ath9k/ar9003_eeprom.c    | 90 +++++++++----------
 1 file changed, 45 insertions(+), 45 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
index 944f46cdf3..58dce556b0 100644
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
@@ -3620,28 +3642,6 @@ static void ar9003_hw_xpa_bias_level_apply(struct ath_hw *ah, bool is2ghz)
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
2.34.1

