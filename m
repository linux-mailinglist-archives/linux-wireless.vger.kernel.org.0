Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E047252561A
	for <lists+linux-wireless@lfdr.de>; Thu, 12 May 2022 21:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358223AbiELTyh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 May 2022 15:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358221AbiELTye (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 May 2022 15:54:34 -0400
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2077.outbound.protection.outlook.com [40.107.115.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E26F270C80
        for <linux-wireless@vger.kernel.org>; Thu, 12 May 2022 12:54:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6kO3ovjyTZJYnL9r1wwAm7rHaMGDTpZeXaDgGbZyaRjkvb+Ve5/toJMyprtD/oNB5n0pbcFTqn2oIfcNtauZFR8FioGzDylS5SyeNsLSQJq6UYZswl4+jGR5chgTEQQqM95PaeQWNjpO7y8RPhyAgE3sCiHIYnHasQoF5+kNfLlF0+PdCzND5aprTer7QIXtgo23CQSRs7JcjqQciO5hXPNkxJXiftnyyVlDsX9mnYnK7nFxwQsTEkN2vzvQWxypWwWwf0IxX882E5tfV++4SitXsK6RxS7toGdOpWU11+KUZVxevcYNFktQrBpg8B3hrokCJmlnnPKf38WzpCsBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbKNIYoRtWRU/C3a0Shb460OPROnsNf593ZKgTH1Icg=;
 b=J4AdWZeHxN5OVMFlqDq+slp5oRvd2+Iiy1azO8A1KgnMdVJ+HPzQ0/lS6WMot8yZUz+PL0ORDbTP/fl4GZgebC7OF84ESzl9UbeDQkY3skYurgVfnpovLx3vc8sCfLaCNxxKejcwx6AiubQWGYOIlbe/yQZuT+Zo+rpWO6WWFB1Hf5bSYCsb/TvIDfzIV7o+y9JfsoaF6L2TccgcwzNDHahU0uyRUAbL6LM7fQ1btA1rUhYUuOquE56qpZI///ZrWHedk0SJPsOwoO99RUQafMlA+HIzsmLMvXJjXBK3WXe6XemJ+9Aj1Eg3Cz+F/Inchn4KTjWrGsC3vjKH/uF2Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucalgary.ca; dmarc=pass action=none header.from=ucalgary.ca;
 dkim=pass header.d=ucalgary.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucalgary.ca;
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:4a::23)
 by YT3PR01MB9530.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:91::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 19:54:26 +0000
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::a17b:bb51:f663:e98f]) by YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::a17b:bb51:f663:e98f%4]) with mapi id 15.20.5227.023; Thu, 12 May 2022
 19:54:26 +0000
From:   Wenli Looi <wlooi@ucalgary.ca>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Wenli Looi <wlooi@ucalgary.ca>
Subject: [PATCH v2 8/9] ath9k: rename ar9300_eeprom to ar9300_eeprom_v1
Date:   Thu, 12 May 2022 12:53:18 -0700
Message-Id: <20220512195319.14635-9-wlooi@ucalgary.ca>
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
X-MS-Office365-Filtering-Correlation-Id: 479c6517-6e2f-4a58-1928-08da3451380e
X-MS-TrafficTypeDiagnostic: YT3PR01MB9530:EE_
X-Microsoft-Antispam-PRVS: <YT3PR01MB9530312B8D822D6A215111F1B2CB9@YT3PR01MB9530.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qNeViQlnu/0pes3YJpbcmETHWpQu61VRd3XMJR7B3tfQ8DeHZq1tzyQEgjjimdxL6Sjn7g1h1HJT5hZcsuAIC8CX3w3yU363zcrTSoRWwURaC6i8GI9CFQ86FL2Yymu4GuWXJIdixSYRZZJga9gPSt0AvPxQrDddBfcmyc/trwnJBtyHa5sJ5tSypzzSAz5GFnQ+3R8LtJJZ/7AnhgZR5XIjh2nZCKRrpOwha09r/VhI9r01WvlXLohR+4iP29RNiCOhg1OqkXKifLLVNljKxhCX+1TSIkYIjD395PH72DV4B7H5bNixsG6syNOVX8+esoVQESDQSKxYGR9xsG1RjjzU3I6Cycel0qoXxnEz8lUTX0OdvKXOTTWdXOGEkSzlU81BJHpOcFRJCcADW0bsv720sth/+3cGBCEF2A2nC8Hp9Lmk1xyRAXO4HdUwxyhJjxkvnmJ7QLoyww+AwNyV13hrFo4nYVDmSlRJya7G7/187wqel06hznPNB02VKYZgGj33gQfI4xaytlC1e7n7Qm8jcENk/NAMbGhvHSel+B7OWED8Inz9jBKpyxvvKHpF0mSxpFyLCY8QP06bb/7v7oNnPl50JmOMeOtPLpmep6QTNTH2PtKpIi5toy0WLaqNweTF6ZjAv6y8sEu6yIw2kIErWqcT+tPQbTrDdGIALMwANy6Dsh5C3bQJJ/LIyIzyFpuzvrSbaRFfxVviRY+A4uA0H256ghX3Y+rBf64PPNM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(83380400001)(36756003)(38350700002)(6666004)(508600001)(6916009)(316002)(786003)(54906003)(19627235002)(2616005)(38100700002)(186003)(2906002)(4326008)(8676002)(107886003)(1076003)(86362001)(66556008)(8936002)(66946007)(66476007)(6506007)(30864003)(6512007)(5660300002)(26005)(52116002)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R0by6zyMET6TDCmsNjEZtJVM7otHm2oQ0b/z1fhc6RcqwHGPUz9yZsRw/MP8?=
 =?us-ascii?Q?4E0rQDzepE2mIgV1lIyhZXiPrgmd/Sz0kM7+tbt0/OeiwUzRy2+xoJ1fJdIC?=
 =?us-ascii?Q?5cpCJ7dvmSZwOeBAH0bGrQiCayB5Ta1vAwgT0wPkHG1EU7/qUuiYBq9iYGeO?=
 =?us-ascii?Q?DVAUZvK8X5bATokPymiSK6dyGn65BkqOEF2RmQhC/Tg3Cxzy1xDk2/wjweZc?=
 =?us-ascii?Q?nZ528Pj5VNLItzv4dKwHBpHliOrkwqIOyN/H2jPU/XvZ6iwU5S33wR0VvYbr?=
 =?us-ascii?Q?3/d3ySOV7XimS+DVtqLvyhbp95UNLGO6H7TETFlXj7yvrvYGAjmNpDU/ySx2?=
 =?us-ascii?Q?XUQuKwQQC4ok6ptUrPpsgOqBe1qSHI8UuGYG93RULf1kXnVv10OYGz+11Fk5?=
 =?us-ascii?Q?w7boPF84YZmSSAjhDSCk8OyRH9OulKW5Qs3yhY0vLpr+EnDaLw3zYX1iCqVY?=
 =?us-ascii?Q?tGsm75w5lieBPTqnxA3vd/KOBCc5Ejz/Wn32g1JNjXRDQ+bZbJLm5nCgH38N?=
 =?us-ascii?Q?t8/hIwJm9y1ClacetDzGzRxeficMZ5W7FbjTcRm4+a47OuJLYLinakdqiVZy?=
 =?us-ascii?Q?/dn2MZVj9e4z0PV+ELB0Vx73ObiVNPfkj8HD5vxMHpkezip14oBM1Hd9l+OL?=
 =?us-ascii?Q?fUcJDDWQVZHyurdstOzjltG7yKe78AkD6eb5pb4TDtRk1tQT32WxWfxZiDVV?=
 =?us-ascii?Q?7mVi2fipSubobwppj32VziqFvF4ZMKY4ksaONrWjyrnxVnf3cFyzVcrSYeYv?=
 =?us-ascii?Q?TAY3wm1b00VoSM/lMTve888TOowEsUn1el7n/IaZCZpyhyPlwBzVPoAhIT34?=
 =?us-ascii?Q?DNvQL4eFEO/AtMif5EW/vP9aaKN25108MN5jQE5TFmoD6yar2hI7Al5uCg2d?=
 =?us-ascii?Q?L9vbNq53SJkDSAQlGz6LW04VE3JCW47t6azFwyJ4U8jeTsh2IUQuYZjRWaId?=
 =?us-ascii?Q?wXv75ul164B0WT8i2hgwwRwg36l6MxKKXx2J7ohidnYFnTCVKWZg5m8rUNF6?=
 =?us-ascii?Q?heXIMcWcfuTlClVF9QbpGwDmzkUGvMEl65fx5qksZNrPVD3/MjlCnC7+2JKr?=
 =?us-ascii?Q?K3yhDWyIQW7aWKUzqEYor1rBz9ZsJ811S/kCvCp/yjvwl59ej1jXq7LA4kNA?=
 =?us-ascii?Q?muTN4Ic/2gx2o8A16Whh3NSQT3SLm/uR450DuYvUh2W7AX16RoeY8vToRlQ8?=
 =?us-ascii?Q?z+VPhhr5Q/QIc/xOzQMJC8AnTIYZVSxwmffJ+5OyTQRK3YxH7gYLexYNie6i?=
 =?us-ascii?Q?/C+UPV7HWFJEHh4DT/cewJEnSG7IfXO+CCcF3Lfp/ZPGtxfH9nAOP2lL+4If?=
 =?us-ascii?Q?XCHghbscXif+gP4uGEn6BQhJD+N1eechABvTvuI4dAUdtoiPVoOu4xFDbR/I?=
 =?us-ascii?Q?LRcZT+JIx3gagsd2jqJ2Hv3fRM0H5tzqzC+/niyKBuZlqfY5DxoWyhcPNVRi?=
 =?us-ascii?Q?3smqnuTCkZFjkUZ56JBBNHIeTz93TWRT0dUBX/yzusyBbsHRdZynSs+sq9pD?=
 =?us-ascii?Q?EqNekkbr7lwHu+DAlwoYzwQX4V0l7ZWFqJWKcIXy968OSMlrGBNwxJYdYUYf?=
 =?us-ascii?Q?AhdxTc53PippGpd6YlsuR91CfrYuik6numoYKAmDxM6VGDM01+nKTT8pepEd?=
 =?us-ascii?Q?jGSOk0ouGuvS29jy/6q4UBH3Xu1OFN2C/+fB3JpU/vRVkV3A+dbrNSQ3IDny?=
 =?us-ascii?Q?mBj5BfN0S7JYhBg1RMiZji+sVxhdGFjQbBCFHT/EaunBxxEyu7nIYxSCrxdq?=
 =?us-ascii?Q?xKHfJLMAbQ=3D=3D?=
X-OriginatorOrg: ucalgary.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 479c6517-6e2f-4a58-1928-08da3451380e
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 19:54:26.5508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c609a0ec-a5e3-4631-9686-192280bd9151
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x7xsbj4eb7KHO9CwrGzhU2mDXm3twOV4gW7q6HrL82dccgTAmBB3dX145KPRhBJbiX7Uj8xYEnComUDw0Nm85A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9530
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This clearly distinguishes it from ar9300_eeprom_v2 which will be
introduced next. It will break external patches involving ar9300_eeprom,
which is desired because those patches will probably be no longer
correct. The number of chains in the eeprom is also decoupled from
AR9300_MAX_CHAINS, which is the number of chains supported by the
driver.

Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>
---
 .../net/wireless/ath/ath9k/ar9003_eeprom.c    | 74 +++++++++----------
 .../net/wireless/ath/ath9k/ar9003_eeprom.h    | 44 +++++------
 drivers/net/wireless/ath/ath9k/hw.h           |  2 +-
 3 files changed, 60 insertions(+), 60 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
index 03eeee767..11c7b57a1 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
@@ -43,7 +43,7 @@
 static int ar9003_hw_power_interpolate(int32_t x,
 				       int32_t *px, int32_t *py, u_int16_t np);
 
-static const struct ar9300_eeprom ar9300_default = {
+static const struct ar9300_eeprom_v1 ar9300_default = {
 	.eepromVersion = 2,
 	.templateVersion = 2,
 	.macAddr = {0, 2, 3, 4, 5, 6},
@@ -622,7 +622,7 @@ static const struct ar9300_eeprom ar9300_default = {
 	 }
 };
 
-static const struct ar9300_eeprom ar9300_x113 = {
+static const struct ar9300_eeprom_v1 ar9300_x113 = {
 	.eepromVersion = 2,
 	.templateVersion = 6,
 	.macAddr = {0x00, 0x03, 0x7f, 0x0, 0x0, 0x0},
@@ -1201,7 +1201,7 @@ static const struct ar9300_eeprom ar9300_x113 = {
 };
 
 
-static const struct ar9300_eeprom ar9300_h112 = {
+static const struct ar9300_eeprom_v1 ar9300_h112 = {
 	.eepromVersion = 2,
 	.templateVersion = 3,
 	.macAddr = {0x00, 0x03, 0x7f, 0x0, 0x0, 0x0},
@@ -1780,7 +1780,7 @@ static const struct ar9300_eeprom ar9300_h112 = {
 };
 
 
-static const struct ar9300_eeprom ar9300_x112 = {
+static const struct ar9300_eeprom_v1 ar9300_x112 = {
 	.eepromVersion = 2,
 	.templateVersion = 5,
 	.macAddr = {0x00, 0x03, 0x7f, 0x0, 0x0, 0x0},
@@ -2358,7 +2358,7 @@ static const struct ar9300_eeprom ar9300_x112 = {
 	}
 };
 
-static const struct ar9300_eeprom ar9300_h116 = {
+static const struct ar9300_eeprom_v1 ar9300_h116 = {
 	.eepromVersion = 2,
 	.templateVersion = 4,
 	.macAddr = {0x00, 0x03, 0x7f, 0x0, 0x0, 0x0},
@@ -2937,7 +2937,7 @@ static const struct ar9300_eeprom ar9300_h116 = {
 };
 
 
-static const struct ar9300_eeprom *ar9300_eep_templates[] = {
+static const struct ar9300_eeprom_v1 *ar9300_eep_templates[] = {
 	&ar9300_default,
 	&ar9300_x112,
 	&ar9300_h116,
@@ -2945,7 +2945,7 @@ static const struct ar9300_eeprom *ar9300_eep_templates[] = {
 	&ar9300_x113,
 };
 
-static const struct ar9300_eeprom *ar9003_eeprom_struct_find_by_id(int id)
+static const struct ar9300_eeprom_v1 *ar9003_eeprom_struct_find_by_id(int id)
 {
 	int it;
 
@@ -2973,7 +2973,7 @@ static int interpolate(int x, int xa, int xb, int ya, int yb)
 /* XXX: review hardware docs */
 static int ath9k_hw_ar9300_get_eeprom_ver(struct ath_hw *ah)
 {
-	return ah->eeprom.ar9300_eep.eepromVersion;
+	return ah->eeprom.ar9300_eep_v1.eepromVersion;
 }
 
 /* XXX: could be read from the eepromVersion, not sure yet */
@@ -2984,18 +2984,18 @@ static int ath9k_hw_ar9300_get_eeprom_rev(struct ath_hw *ah)
 
 static struct ar9300_base_eep_hdr *ar9003_base_header(struct ath_hw *ah)
 {
-	return &ah->eeprom.ar9300_eep.baseEepHeader;
+	return &ah->eeprom.ar9300_eep_v1.baseEepHeader;
 }
 
 static struct ar9300_BaseExtension_1 *ar9003_base_ext1(struct ath_hw *ah)
 {
-	return &ah->eeprom.ar9300_eep.base_ext1;
+	return &ah->eeprom.ar9300_eep_v1.base_ext1;
 }
 
-static struct ar9300_modal_eep_header *ar9003_modal_header(struct ath_hw *ah,
+static struct ar9300_modal_eep_header_v1 *ar9003_modal_header(struct ath_hw *ah,
 							   bool is2ghz)
 {
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
+	struct ar9300_eeprom_v1 *eep = &ah->eeprom.ar9300_eep_v1;
 
 	if (is2ghz)
 		return &eep->modalHeader2G;
@@ -3010,35 +3010,35 @@ static int8_t ar9003_ant_gain(struct ath_hw *ah, bool is2ghz)
 
 static u8 ar9003_cal_freq_pier(struct ath_hw *ah, int idx, bool is2ghz)
 {
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
+	struct ar9300_eeprom_v1 *eep = &ah->eeprom.ar9300_eep_v1;
 	return is2ghz ? eep->calFreqPier2G[idx] : eep->calFreqPier5G[idx];
 }
 
 static struct ar9300_cal_data_per_freq_op_loop *
 ar9003_cal_pier_data(struct ath_hw *ah, int chain, int idx, bool is2ghz)
 {
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
+	struct ar9300_eeprom_v1 *eep = &ah->eeprom.ar9300_eep_v1;
 	return is2ghz ? &eep->calPierData2G[chain][idx] :
 			      &eep->calPierData5G[chain][idx];
 }
 
 static u8 ar9003_cal_target_freqbin(struct ath_hw *ah, int idx, bool is2ghz)
 {
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
+	struct ar9300_eeprom_v1 *eep = &ah->eeprom.ar9300_eep_v1;
 	return is2ghz ? eep->calTarget_freqbin_2G[idx] :
 			      eep->calTarget_freqbin_5G[idx];
 }
 
 static u8 ar9003_cal_target_freqbin_cck(struct ath_hw *ah, int idx)
 {
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
+	struct ar9300_eeprom_v1 *eep = &ah->eeprom.ar9300_eep_v1;
 	return eep->calTarget_freqbin_Cck[idx];
 }
 
 static u8 ar9003_cal_target_freqbin_ht20(struct ath_hw *ah, int idx,
 					 bool is2ghz)
 {
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
+	struct ar9300_eeprom_v1 *eep = &ah->eeprom.ar9300_eep_v1;
 	return is2ghz ? eep->calTarget_freqbin_2GHT20[idx] :
 			      eep->calTarget_freqbin_5GHT20[idx];
 }
@@ -3046,7 +3046,7 @@ static u8 ar9003_cal_target_freqbin_ht20(struct ath_hw *ah, int idx,
 static u8 ar9003_cal_target_freqbin_ht40(struct ath_hw *ah, int idx,
 					 bool is2ghz)
 {
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
+	struct ar9300_eeprom_v1 *eep = &ah->eeprom.ar9300_eep_v1;
 	return is2ghz ? eep->calTarget_freqbin_2GHT40[idx] :
 			      eep->calTarget_freqbin_5GHT40[idx];
 }
@@ -3054,21 +3054,21 @@ static u8 ar9003_cal_target_freqbin_ht40(struct ath_hw *ah, int idx,
 static u8 ar9003_cal_target_power(struct ath_hw *ah, int idx, int rateIndex,
 				  bool is2ghz)
 {
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
+	struct ar9300_eeprom_v1 *eep = &ah->eeprom.ar9300_eep_v1;
 	return is2ghz ? eep->calTargetPower2G[idx].tPow2x[rateIndex] :
 			      eep->calTargetPower5G[idx].tPow2x[rateIndex];
 }
 
 static u8 ar9003_cal_target_power_cck(struct ath_hw *ah, int idx, int rateIndex)
 {
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
+	struct ar9300_eeprom_v1 *eep = &ah->eeprom.ar9300_eep_v1;
 	return eep->calTargetPowerCck[idx].tPow2x[rateIndex];
 }
 
 static u8 ar9003_cal_target_power_ht20(struct ath_hw *ah, int idx,
 				       int rateIndex, bool is2ghz)
 {
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
+	struct ar9300_eeprom_v1 *eep = &ah->eeprom.ar9300_eep_v1;
 	return is2ghz ? eep->calTargetPower2GHT20[idx].tPow2x[rateIndex] :
 			      eep->calTargetPower5GHT20[idx].tPow2x[rateIndex];
 }
@@ -3076,28 +3076,28 @@ static u8 ar9003_cal_target_power_ht20(struct ath_hw *ah, int idx,
 static u8 ar9003_cal_target_power_ht40(struct ath_hw *ah, int idx,
 				       int rateIndex, bool is2ghz)
 {
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
+	struct ar9300_eeprom_v1 *eep = &ah->eeprom.ar9300_eep_v1;
 	return is2ghz ? eep->calTargetPower2GHT40[idx].tPow2x[rateIndex] :
 			      eep->calTargetPower5GHT40[idx].tPow2x[rateIndex];
 }
 
 static u8 ar9003_ctl_freqbin(struct ath_hw *ah, int idx, int edge, bool is2ghz)
 {
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
+	struct ar9300_eeprom_v1 *eep = &ah->eeprom.ar9300_eep_v1;
 	return is2ghz ? eep->ctl_freqbin_2G[idx][edge] :
 			      eep->ctl_freqbin_5G[idx][edge];
 }
 
 static u8 ar9003_ctl_index(struct ath_hw *ah, int idx, bool is2ghz)
 {
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
+	struct ar9300_eeprom_v1 *eep = &ah->eeprom.ar9300_eep_v1;
 	return is2ghz ? eep->ctlIndex_2G[idx] : eep->ctlIndex_5G[idx];
 }
 
 static u8 ar9003_ctl_power_data(struct ath_hw *ah, int idx, int edge,
 				bool is2ghz)
 {
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
+	struct ar9300_eeprom_v1 *eep = &ah->eeprom.ar9300_eep_v1;
 	return is2ghz ? eep->ctlPowerData_2G[idx].ctlEdges[edge] :
 			      eep->ctlPowerData_5G[idx].ctlEdges[edge];
 }
@@ -3137,12 +3137,12 @@ static int8_t ar9003_temp_slope(struct ath_hw *ah, bool is2ghz)
 
 static int8_t ar9003_temp_slope_high(struct ath_hw *ah)
 {
-	return ah->eeprom.ar9300_eep.base_ext2.tempSlopeHigh;
+	return ah->eeprom.ar9300_eep_v1.base_ext2.tempSlopeHigh;
 }
 
 static int8_t ar9003_temp_slope_low(struct ath_hw *ah)
 {
-	return ah->eeprom.ar9300_eep.base_ext2.tempSlopeLow;
+	return ah->eeprom.ar9300_eep_v1.base_ext2.tempSlopeLow;
 }
 
 static u8 ar9003_tx_end_to_xpa_off(struct ath_hw *ah, bool is2ghz)
@@ -3157,22 +3157,22 @@ static u8 ar9003_tx_frame_to_xpa_on(struct ath_hw *ah, bool is2ghz)
 
 static u8 ar9003_xatten1_db_high(struct ath_hw *ah, int chain)
 {
-	return ah->eeprom.ar9300_eep.base_ext2.xatten1DBHigh[chain];
+	return ah->eeprom.ar9300_eep_v1.base_ext2.xatten1DBHigh[chain];
 }
 
 static u8 ar9003_xatten1_db_low(struct ath_hw *ah, int chain)
 {
-	return ah->eeprom.ar9300_eep.base_ext2.xatten1DBLow[chain];
+	return ah->eeprom.ar9300_eep_v1.base_ext2.xatten1DBLow[chain];
 }
 
 static u8 ar9003_xatten1_db_margin_high(struct ath_hw *ah, int chain)
 {
-	return ah->eeprom.ar9300_eep.base_ext2.xatten1MarginHigh[chain];
+	return ah->eeprom.ar9300_eep_v1.base_ext2.xatten1MarginHigh[chain];
 }
 
 static u8 ar9003_xatten1_db_margin_low(struct ath_hw *ah, int chain)
 {
-	return ah->eeprom.ar9300_eep.base_ext2.xatten1MarginLow[chain];
+	return ah->eeprom.ar9300_eep_v1.base_ext2.xatten1MarginLow[chain];
 }
 
 static u8 ar9003_xatten1_db(struct ath_hw *ah, int chain, bool is2ghz)
@@ -3197,7 +3197,7 @@ static u8 ar9003_xpa_bias_lvl(struct ath_hw *ah, bool is2ghz)
 
 static u8 *ar9003_mac_addr(struct ath_hw *ah)
 {
-	return ah->eeprom.ar9300_eep.macAddr;
+	return ah->eeprom.ar9300_eep_v1.macAddr;
 }
 
 static u16 ar9003_switch_com_spdt_get(struct ath_hw *ah, bool is2ghz)
@@ -3421,7 +3421,7 @@ static int ar9300_compress_decision(struct ath_hw *ah,
 				    u8 *word, int length, int mdata_size)
 {
 	struct ath_common *common = ath9k_hw_common(ah);
-	const struct ar9300_eeprom *eep = NULL;
+	const struct ar9300_eeprom_v1 *eep = NULL;
 
 	switch (code) {
 	case _CompressNone:
@@ -3512,7 +3512,7 @@ static int ar9300_eeprom_restore_internal(struct ath_hw *ah,
 	int it;
 	u16 checksum, mchecksum;
 	struct ath_common *common = ath9k_hw_common(ah);
-	struct ar9300_eeprom *eep;
+	struct ar9300_eeprom_v1 *eep;
 	eeprom_read_op read;
 
 	if (ath9k_hw_use_flash(ah)) {
@@ -3522,7 +3522,7 @@ static int ar9300_eeprom_restore_internal(struct ath_hw *ah,
 			return -EIO;
 
 		/* check if eeprom contains valid data */
-		eep = (struct ar9300_eeprom *) mptr;
+		eep = (struct ar9300_eeprom_v1 *) mptr;
 		txrx = eep->baseEepHeader.txrxMask;
 		if (txrx != 0 && txrx != 0xff)
 			return 0;
@@ -3625,10 +3625,10 @@ static int ar9300_eeprom_restore_internal(struct ath_hw *ah,
  */
 static bool ath9k_hw_ar9300_fill_eeprom(struct ath_hw *ah)
 {
-	u8 *mptr = (u8 *) &ah->eeprom.ar9300_eep;
+	u8 *mptr = (u8 *) &ah->eeprom.ar9300_eep_v1;
 
 	if (ar9300_eeprom_restore_internal(ah, mptr,
-			sizeof(struct ar9300_eeprom)) < 0)
+			sizeof(struct ar9300_eeprom_v1)) < 0)
 		return false;
 
 	return true;
diff --git a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.h b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.h
index f8ae20318..b020092e8 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.h
+++ b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.h
@@ -41,7 +41,7 @@
 #define AR9300_EEPMISC_WOW           0x02
 #define AR9300_CUSTOMER_DATA_SIZE    20
 
-#define AR9300_MAX_CHAINS            3
+#define AR9300_EEPROM_V1_MAX_CHAINS  3
 #define AR9300_ANT_16S               25
 #define AR9300_FUTURE_MODAL_SZ       6
 
@@ -215,23 +215,23 @@ struct ar9300_base_eep_hdr {
 	__le32 swreg;
 } __packed;
 
-struct ar9300_modal_eep_header {
+struct ar9300_modal_eep_header_v1 {
 	/* 4 idle, t1, t2, b (4 bits per setting) */
 	__le32 antCtrlCommon;
 	/* 4 ra1l1, ra2l1, ra1l2, ra2l2, ra12 */
 	__le32 antCtrlCommon2;
 	/* 6 idle, t, r, rx1, rx12, b (2 bits each) */
-	__le16 antCtrlChain[AR9300_MAX_CHAINS];
+	__le16 antCtrlChain[AR9300_EEPROM_V1_MAX_CHAINS];
 	/* 3 xatten1_db for AR9280 (0xa20c/b20c 5:0) */
-	u8 xatten1DB[AR9300_MAX_CHAINS];
+	u8 xatten1DB[AR9300_EEPROM_V1_MAX_CHAINS];
 	/* 3  xatten1_margin for merlin (0xa20c/b20c 16:12 */
-	u8 xatten1Margin[AR9300_MAX_CHAINS];
+	u8 xatten1Margin[AR9300_EEPROM_V1_MAX_CHAINS];
 	int8_t tempSlope;
 	int8_t voltSlope;
 	/* spur channels in usual fbin coding format */
 	u8 spurChans[AR_EEPROM_MODAL_SPURS];
 	/* 3  Check if the register is per chain */
-	int8_t noiseFloorThreshCh[AR9300_MAX_CHAINS];
+	int8_t noiseFloorThreshCh[AR9300_EEPROM_V1_MAX_CHAINS];
 	u8 reserved[11];
 	int8_t quick_drop;
 	u8 xpaBiasLvl;
@@ -270,7 +270,7 @@ struct cal_tgt_pow_legacy {
 	u8 tPow2x[4];
 } __packed;
 
-struct cal_tgt_pow_ht {
+struct cal_tgt_pow_ht_v1 {
 	u8 tPow2x[14];
 } __packed;
 
@@ -300,16 +300,16 @@ struct ar9300_BaseExtension_1 {
 	int8_t quick_drop_high;
 } __packed;
 
-struct ar9300_BaseExtension_2 {
+struct ar9300_BaseExtension_2_v1 {
 	int8_t    tempSlopeLow;
 	int8_t    tempSlopeHigh;
-	u8   xatten1DBLow[AR9300_MAX_CHAINS];
-	u8   xatten1MarginLow[AR9300_MAX_CHAINS];
-	u8   xatten1DBHigh[AR9300_MAX_CHAINS];
-	u8   xatten1MarginHigh[AR9300_MAX_CHAINS];
+	u8   xatten1DBLow[AR9300_EEPROM_V1_MAX_CHAINS];
+	u8   xatten1MarginLow[AR9300_EEPROM_V1_MAX_CHAINS];
+	u8   xatten1DBHigh[AR9300_EEPROM_V1_MAX_CHAINS];
+	u8   xatten1MarginHigh[AR9300_EEPROM_V1_MAX_CHAINS];
 } __packed;
 
-struct ar9300_eeprom {
+struct ar9300_eeprom_v1 {
 	u8 eepromVersion;
 	u8 templateVersion;
 	u8 macAddr[6];
@@ -317,11 +317,11 @@ struct ar9300_eeprom {
 
 	struct ar9300_base_eep_hdr baseEepHeader;
 
-	struct ar9300_modal_eep_header modalHeader2G;
+	struct ar9300_modal_eep_header_v1 modalHeader2G;
 	struct ar9300_BaseExtension_1 base_ext1;
 	u8 calFreqPier2G[AR9300_NUM_2G_CAL_PIERS];
 	struct ar9300_cal_data_per_freq_op_loop
-	 calPierData2G[AR9300_MAX_CHAINS][AR9300_NUM_2G_CAL_PIERS];
+	 calPierData2G[AR9300_EEPROM_V1_MAX_CHAINS][AR9300_NUM_2G_CAL_PIERS];
 	u8 calTarget_freqbin_Cck[AR9300_NUM_2G_CCK_TARGET_POWERS];
 	u8 calTarget_freqbin_2G[AR9300_NUM_2G_20_TARGET_POWERS];
 	u8 calTarget_freqbin_2GHT20[AR9300_NUM_2G_20_TARGET_POWERS];
@@ -330,26 +330,26 @@ struct ar9300_eeprom {
 	 calTargetPowerCck[AR9300_NUM_2G_CCK_TARGET_POWERS];
 	struct cal_tgt_pow_legacy
 	 calTargetPower2G[AR9300_NUM_2G_20_TARGET_POWERS];
-	struct cal_tgt_pow_ht
+	struct cal_tgt_pow_ht_v1
 	 calTargetPower2GHT20[AR9300_NUM_2G_20_TARGET_POWERS];
-	struct cal_tgt_pow_ht
+	struct cal_tgt_pow_ht_v1
 	 calTargetPower2GHT40[AR9300_NUM_2G_40_TARGET_POWERS];
 	u8 ctlIndex_2G[AR9300_NUM_CTLS_2G];
 	u8 ctl_freqbin_2G[AR9300_NUM_CTLS_2G][AR9300_NUM_BAND_EDGES_2G];
 	struct cal_ctl_data_2g ctlPowerData_2G[AR9300_NUM_CTLS_2G];
-	struct ar9300_modal_eep_header modalHeader5G;
-	struct ar9300_BaseExtension_2 base_ext2;
+	struct ar9300_modal_eep_header_v1 modalHeader5G;
+	struct ar9300_BaseExtension_2_v1 base_ext2;
 	u8 calFreqPier5G[AR9300_NUM_5G_CAL_PIERS];
 	struct ar9300_cal_data_per_freq_op_loop
-	 calPierData5G[AR9300_MAX_CHAINS][AR9300_NUM_5G_CAL_PIERS];
+	 calPierData5G[AR9300_EEPROM_V1_MAX_CHAINS][AR9300_NUM_5G_CAL_PIERS];
 	u8 calTarget_freqbin_5G[AR9300_NUM_5G_20_TARGET_POWERS];
 	u8 calTarget_freqbin_5GHT20[AR9300_NUM_5G_20_TARGET_POWERS];
 	u8 calTarget_freqbin_5GHT40[AR9300_NUM_5G_40_TARGET_POWERS];
 	struct cal_tgt_pow_legacy
 	 calTargetPower5G[AR9300_NUM_5G_20_TARGET_POWERS];
-	struct cal_tgt_pow_ht
+	struct cal_tgt_pow_ht_v1
 	 calTargetPower5GHT20[AR9300_NUM_5G_20_TARGET_POWERS];
-	struct cal_tgt_pow_ht
+	struct cal_tgt_pow_ht_v1
 	 calTargetPower5GHT40[AR9300_NUM_5G_40_TARGET_POWERS];
 	u8 ctlIndex_5G[AR9300_NUM_CTLS_5G];
 	u8 ctl_freqbin_5G[AR9300_NUM_CTLS_5G][AR9300_NUM_BAND_EDGES_5G];
diff --git a/drivers/net/wireless/ath/ath9k/hw.h b/drivers/net/wireless/ath/ath9k/hw.h
index 759a5991a..22349c2b7 100644
--- a/drivers/net/wireless/ath/ath9k/hw.h
+++ b/drivers/net/wireless/ath/ath9k/hw.h
@@ -789,7 +789,7 @@ struct ath_hw {
 		struct ar5416_eeprom_def def;
 		struct ar5416_eeprom_4k map4k;
 		struct ar9287_eeprom map9287;
-		struct ar9300_eeprom ar9300_eep;
+		struct ar9300_eeprom_v1 ar9300_eep_v1;
 	} eeprom;
 	const struct eeprom_ops *eep_ops;
 
-- 
2.25.1

