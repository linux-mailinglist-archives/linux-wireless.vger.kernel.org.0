Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8788F504D25
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Apr 2022 09:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234795AbiDRHXM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Apr 2022 03:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236961AbiDRHXI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Apr 2022 03:23:08 -0400
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2055.outbound.protection.outlook.com [40.107.115.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A00A17A86
        for <linux-wireless@vger.kernel.org>; Mon, 18 Apr 2022 00:20:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYAALu3usfeMhF/RiMy6LNBeikGye12z8NFoC+sgqlpcDVbRZ//vqFxmb5z1LkQtpqtqijRGHhdqxj9fFx7XKMlFQp/5Si9NCF/IOvZFBAMPi1e8wow9Dkku01D8Zg2hskGiL9PgjF7yxyWCzeNbZPSCZ3u4L2HK8QX03F+pprRVVjMKqTTZszDOH6b9UmZB6Q+gtz1HAtzTjec/u69l4+UrmCGUTuDB89q996tacvkwxrWXIuvuFtQr4dWdFED7DNaxTEwV73D/CF1sUQpU0RvSysoN2wxapxdxcblAPC2EAQOLLEM/UgJHzLLvqaFHbxHUiD2G6sHXoJ2EcrW2BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbKNIYoRtWRU/C3a0Shb460OPROnsNf593ZKgTH1Icg=;
 b=byrGTGSfqvOgGqkqSgQgw0U7DjUcvhhMUGUo+wZibsQbylA9JJ+eI/oSvSMoOTTADouPi7fPkU72QXChvoaF9ybBj4sQNbVbz8cFH2uUaz9tgOe0F8eXouEdXgjAHYmvv1uHrzzI8LSz/dwyR2jtt538k+lPBguKg/d170SqB5GARIdoueCbXstAWUzRj8t5Urb5JNleRZMR3vlUM8iOJThuKfre58FTTpfQO1Tv60JIDZsT4T/hf8N8sz2xDQUGfYcBLAKYI0ePOMJ2WpKUaFT4Mixx0J41FLZF4HJPYIESi5lI1bnPA9TPgBKHbRaSQeyPiwsJ5okTNYEr7wl45Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucalgary.ca; dmarc=pass action=none header.from=ucalgary.ca;
 dkim=pass header.d=ucalgary.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucalgary.ca;
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:4a::23)
 by YT1PR01MB4363.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 07:20:25 +0000
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::788b:f975:24ac:69f]) by YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::788b:f975:24ac:69f%6]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 07:20:25 +0000
From:   Wenli Looi <wlooi@ucalgary.ca>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        ath9k-devel@qca.qualcomm.com, Wenli Looi <wlooi@ucalgary.ca>
Subject: [PATCH 8/9] ath9k: rename ar9300_eeprom to ar9300_eeprom_v1
Date:   Mon, 18 Apr 2022 00:13:12 -0700
Message-Id: <20220418071313.882179-9-wlooi@ucalgary.ca>
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
X-MS-Office365-Filtering-Correlation-Id: 3d5d9137-f3d9-4ec8-4d4b-08da210be853
X-MS-TrafficTypeDiagnostic: YT1PR01MB4363:EE_
X-Microsoft-Antispam-PRVS: <YT1PR01MB4363A4C42237CF7EE140ADFCB2F39@YT1PR01MB4363.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kK1gOU+ofjvptyb9kZWNlA87m9FWsTzfEEgDQibmNTTuAPbSDylmedt/GV1ZaPeXxCZffp8+waSdK7YeqDcaaW9r8YjPj7eQCNIqBCY3z+xTZC6bM5lji8FflCpMfe6792fx98SdQSs9mCL9yjBeSPnq/e+lqWKvjEYQV9jAFsxs9/GmAqnYEX9jiMdlbT0Y9QuMwg5ZhdS4+fjd5Rv8BhR8LXcyFJQDpLzGI4Wkl1fjJO8XpGxuJ+AXYfhw8EZzTOy3FKRsIaXHlCL5EEuzC3e7sr4w2U7Kfu37liae3zOfbQl+RY2c7z2pLTtV1+ca6d1U2/bmlYfY3rBynsBFAtn/q9+D3kCgF/8lLd7U9w9YIMDSN/1fZTd3vEKpiskYe+6kQiKGgoXSCotkCho1cYJ3cVJ/Y+V16wrrJZx8kxHk1BDo03UixsTNc2kDAemoT7qk6DxsjL/aECceg68qygAgBJLfTC8Qo3dTShecmY3QwLRPCeZoUZzv25WfrV7rvOsAujm9FZPpRXboDzvwjD8CLx0KS0f+hwhMLDnbrVplUTSbTxIwsMhtyoLz5mgMtuqy/LQtiFVeArt36fR93U3XylMubzJMk2KYYJybZtDca619qJ3wUlk8uWuWJOmRQVMS2lQotOOnQWccbh+TN15edjfGCxm4aWGUAK0uWX9EdjF/wduwRAO5H1OYmq5+/MH1pKNTDWJEnVjAcBHjF79zIPbsWvgs2pug5Vf6Cws=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(86362001)(83380400001)(6666004)(6916009)(54906003)(66946007)(316002)(186003)(30864003)(26005)(786003)(38350700002)(6486002)(38100700002)(19627235002)(107886003)(2616005)(1076003)(4326008)(8676002)(66476007)(66556008)(508600001)(8936002)(6506007)(36756003)(52116002)(2906002)(6512007)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u6Rt5b8yZ+FEfEfRz/60ftsHvcbTopdzEY7Mn/+U8WiriBaoR1qKtHMdFoyt?=
 =?us-ascii?Q?jGLEsIW6EqV4w5rG+nj976J+ft8X8KU4mWIhYTI1LaKgghlMfWdnFajynoX9?=
 =?us-ascii?Q?Za1zYnXWZp8VoKsd+G23XdsBGFvsGlX/LHlcMT7CDfNAYcLwJ7rU51PU9CV8?=
 =?us-ascii?Q?58tjDbanF7cTcSh/vFO4ROZqjETuOPIK5IxfgpNB0zrYmEKxo3KNfRrbt0aI?=
 =?us-ascii?Q?nAyi7U6GgcwDBsz/+JL7DeLGrisPi9wh69cUlh23+bsZTY1/azyQMu+X0zl6?=
 =?us-ascii?Q?jnZPMg/SQQgdlDmMUy4GdX+9N5HfKgk8bYB2F/hfLJAK7H5nl5OecILhAuY7?=
 =?us-ascii?Q?mZmttnOtoGg4HFKdmCZvtsqW4JM0l1/alvLyUsXZLt8w0LlQu7D2QvjDU2gp?=
 =?us-ascii?Q?unkHf+l+SxSZhkRXlCmG87ujnOhvVYf+8a+qxNzbOfi6MLBUgMnk99NLEfsK?=
 =?us-ascii?Q?jWszqNbzUFS8vM/1hpP2mtweb3PlFOUysejztd8BV1Bepz5x3xsxgeW/5Efw?=
 =?us-ascii?Q?liBD9MbJ20ig+prCydu9+NJRa2jeEA44y2F5hYIjBGgrKqXPclEdKPC+oOs4?=
 =?us-ascii?Q?jNeneBH1xAbNvdk82Y/DEGYjrDyx4tpbvIkMvJ7IBdqgONHrK75R6V3iTjBx?=
 =?us-ascii?Q?W7qTmXE/Vq7qPwVrMD1DVb+N9b26f3Ss3RHJj+VFcG0Yghdf22WiYots0KlJ?=
 =?us-ascii?Q?BBIrIeiy5TIiyzhoOTgIibKkitD+g4UH/le/n5AiDQHNh9H+2yppwo+x77Lg?=
 =?us-ascii?Q?xBoQh5r8H4H5rWI+FncA0+jtMlVakmFwL+w4ewgrFXFsOnzSNpQAxgOrwYk2?=
 =?us-ascii?Q?B6BvCEM0xWWdrlmxRQxCRpUUQfm6So1lbeJRDdw3B9ICohKfWVJM/5f46Nqv?=
 =?us-ascii?Q?LyJiSTvk/7E6n7VafAC81KLNNYH3HNPcnbV9DRUeMwCF3owH/bVtZ1LAWoy5?=
 =?us-ascii?Q?fFRD2oR3fddWQrKu1hyPBbBwI0omky+rJ4TSjBDE5GU8DFKt8f3x7yt8fEfn?=
 =?us-ascii?Q?brcjZLe7/8vMryofyM8P+IAVejykOFBYgbJqstUvbOExPdXi0uDKQprfGl8h?=
 =?us-ascii?Q?hblno8oCrunNy6tZganMeCklSiP/n4T8QrF9DYU2u4Zsu1Ras4aTqd47HMfn?=
 =?us-ascii?Q?wda/7F0G9yUudZXmMJpkc5pIXZNXml0Xa2pYridqpRr/fOOBmDANShy3xtdS?=
 =?us-ascii?Q?tuTn7ZpprLcbxXjxyOv3q41JTn4djDWWPaE8TaZE7r/NtM4pkzVSNybfzeIo?=
 =?us-ascii?Q?M9CmG64GHDMYBixqzzpJ3GZYR1IaD9qBCXGwgD8uTC/gUVwfT1MtdaTB9/pG?=
 =?us-ascii?Q?JrDMD19Zb99w6BrqfaxpmybOWChOyVxYtIZgXlxWYnUq6N+NFSNG+VS+s3py?=
 =?us-ascii?Q?4e7/XHi2bmUUgx2qNc3EZqEFPx0+8UV+jkpC48EHqzoZ53MPjQUlngqTyLHJ?=
 =?us-ascii?Q?IwjqoqTJCCgfihpEWK6fMlcHsk/QkbS1bGk8yxUP8zYca+JkyrTWcQu9AFGr?=
 =?us-ascii?Q?EBSHdNkrhJs8Wbx/HuhWYzzvtvQWCRvhI/ck//ymaTJmFauBwOnGvn7nzxZQ?=
 =?us-ascii?Q?gzo6VxW4arefiZdYHy5v8/HgTtprH+SAbl9i3unYIzhFOcBVtMqMxU3xZzuk?=
 =?us-ascii?Q?XkTMHQxRZ5vdWBfwUw6EhWBvE2tnCjyi7x53U29KtcDP7uXre5e5iz6lLJ7b?=
 =?us-ascii?Q?ov9DN0lcqRJKZEsg+zaWVQ4AOSejCNafYkOIwJzlbiPFrr2DtWB92nqDXBdK?=
 =?us-ascii?Q?RGwfxO3tBQ=3D=3D?=
X-OriginatorOrg: ucalgary.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d5d9137-f3d9-4ec8-4d4b-08da210be853
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2022 07:20:25.3414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c609a0ec-a5e3-4631-9686-192280bd9151
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJgkcXDNH8KGxUyP2S/3YQ5dAZHr+tti3c5d6PEzsC3tJPHFR3tbRKGWcrHYJ3vxbtE1/Tp0Rwfi/Fdz2Rs6BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB4363
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

