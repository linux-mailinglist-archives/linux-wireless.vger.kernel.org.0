Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16FA7DA6E1
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Oct 2023 14:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbjJ1MP6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 28 Oct 2023 08:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjJ1MP4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 28 Oct 2023 08:15:56 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2100.outbound.protection.outlook.com [40.92.98.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430B9AF
        for <linux-wireless@vger.kernel.org>; Sat, 28 Oct 2023 05:15:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGkIYcTHgCEMMIH0smMuJ7mV6UzvhZF3BmVFPKuFDkr1r9IfN7DX4A7l+XK+lDKW+rAduXkhw6vVP+LHh+9kTUiYuxxd4DBhSLjJwH8BRoMqE3uIJkSy6kyHXDj3hNR8igYVffQqqBIkCm2o7ZPvhBsByoGtNh42fDty47+OIn++0g3HNdq3WUvko7jJwGfiWdZDXc+BZYOU7AO0ttKRBjBEbUWExTrJ/8f98SBLeZx7caPfL24R8PtdQNfW8FO7ft0Lva2WzBj/K7Vrjdb1Ijfw5IVNlZ82zMfLaIPtHUraP7OgwKmgD2c4ezVxErs2cPvNfvDQ5bz4tQGn8CK0OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIX+Y85cQQ9eyn1do9h7yoORpYKyEL4r3v6J+r0cMx8=;
 b=ZW9HcTizc4EBMmrAbWBwVvrQXyByQR+fOCILVuHPjnnVujq6pif36FHuwyVxzokplm6fAQbfsUOpZTzpj0k79fBR2Bboa08/71AydjpxP7mTgaIwLL7y+b7i41qWA5DWQyJFvxTOK9g95efmkij3YNTzjmmSo8xQBYZX9sOvSGKj6FfXXEXaYBlydu06U901/9Qg9IDZBpU5BECFTyL4GqKl8JfZ8I1LekPF6tYIMNMr8SlYG7Z2zJSj9Vp2w/k1Nsbo3Jt1bFtQYWPee/avdAFyAdfQG+riZTuNsnF4aT9+aWfGCWC96snjk8BugfeBXfjkNhAVgoTqgugwlbc6Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIX+Y85cQQ9eyn1do9h7yoORpYKyEL4r3v6J+r0cMx8=;
 b=n3dEQQ27Suv70vzZcOVkJGYBF9zls2iz9l7I8gNUUzduaFvjAsLLRxsm2nATBhuF0b2DiiRVOD0KbJYKU8qzeHG0ejOf1PeS2RXDJNpLWNkzyHsjaXrkqQbVuaNE8o6yB0eQRQG+kGDFqkPrPpmAkjNnSNJ+eYanjc0bxL8PXQyBIUmsCZ7OlDcGs94hMiV/ipqO7OySiA5jDlr/GhDQBMlF3DxpoPrw3SIppnvIWL931taSgDOmAWQc1NiZOSpZi4OkY0HR08SrVA8egGX1/swFxtvgb78g+mzyvUm/VQrZOZcYXMVc78/MK9JQKSDA1Uu+Ucx8Ij696kLYWknZTw==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by TYCP286MB2504.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:20e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.23; Sat, 28 Oct
 2023 12:15:48 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::465a:2534:4d99:a25b]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::465a:2534:4d99:a25b%6]) with mapi id 15.20.6933.019; Sat, 28 Oct 2023
 12:15:48 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     linux-wireless@vger.kernel.org
Cc:     Stanislaw Gruszka <stf_xl@wp.pl>, Kalle Valo <kvalo@kernel.org>,
        Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH 2/3] wifi: rt2x00: disable RTS threshold for rt2800 by default
Date:   Sat, 28 Oct 2023 20:15:31 +0800
Message-ID: <TYAP286MB0315DBC21F89552F7D235E56BCA3A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231028121532.5397-1-yangshiji66@outlook.com>
References: <20231028121532.5397-1-yangshiji66@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [AaaSacL6L0cfZjbXo5CmFtUqVGGDrU5gGSb1vM8u2P8=]
X-ClientProxiedBy: TYCP286CA0322.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::11) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20231028121532.5397-2-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|TYCP286MB2504:EE_
X-MS-Office365-Filtering-Correlation-Id: 98fed0d1-9ff0-453c-fbdf-08dbd7af9e41
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eWBa0p+H+lzhcbhcRJlOL7ObcPpgFEn527olDltggtHTqIZiUxEa1LeM8wGHbcB+5dhafLEWbJGUvQkqS41qDT+5eN6umVSzv6a6m45PJHO+GpW8xThESZd73tEmJKdeaW1nl7/k8cr8UD7xVejg9Gs9UJnbpt68Ruy+x1rrSSxxXX9V9YLQNMe88GZOE9pWrpvSteHCVIhYlWyrlFdjv+gkBlU5OjK40b+oclKo9erzJKPY+97aPImv7uRnd70ne8s5T6HkXbyez8ldkh5mcIl7j12tnx6lqKwPP89IOY5z0/LqqzLGX07yqTm+XG5Pgax7/fGh0LhoYUwRZXcJvuu/zDC+pn9YcGddfMgJilNGuCBYSOw9cXE+UuVsDMwxb+CGFUob/QTThpackkyhTTyQhu+UDvVj1UkQLEKJCi1ddTAeUJyS5+oyaupIoSoaGiTxYocj0gyXWCl98uZ3dmTDzwYY5LW06X5GM3vUrqKIsnqn2XUivIVcWatZQR/ESIEuZh605pLke4RpNXbz+w1JeAuTQTVpOOEW0IqizwefJURFkf0LK435NzJppYb55l6UctALFQx9EV+9F1M06Z+NF3mYNHWuPibEPSRP6yg=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DNxk1E31NUoQZZlBfUBeaLR7IZHxOSiM9BaCPLFJRUtrmzCxPvdVro/OXNL0?=
 =?us-ascii?Q?gBQEqn+Jcx22bl0G6SXIGbZ+VQJ5araPU6jfRCMa4ZBz291UJK6QpCykatAw?=
 =?us-ascii?Q?Ix9d58BE4x5ZX4tyaSsztu8MQXTxGFhgcDVLA9cr3hznf5uJ9nQPTULfIaOT?=
 =?us-ascii?Q?E7IKuTlUYxP48mOQChjJklTO9vuRY7mnhiO/zbI4aQXcbsx5jDjQTSMO+5xC?=
 =?us-ascii?Q?kwACo4WCsrrtBmuiyZIr5Zmmaf+bjIOVkSeGUNVz33kqzD/wI78+wpyCXVsm?=
 =?us-ascii?Q?zi//9z4EXdKN8LV2FFjfnonkoDL9wLhu1VqNXiEQUYqkg5ynurCIsvk4hpyc?=
 =?us-ascii?Q?6BwrzPc2t/niQZ7p2RJCup9Qs2D4wc3TXNSjhAvdu64ucX36r72756qBaOTu?=
 =?us-ascii?Q?LR1QAhnCwPktnPSj/P3i9fJjI415+2QkOD0IgesORITb4vsCFsv3NOyWuNcV?=
 =?us-ascii?Q?HPTjiIVEHLHWMDjGSF+5zLwLuLlQOYLIdMVl9kKHl7EEnELl+Xbr9+seHiFz?=
 =?us-ascii?Q?k4McRomhDYfP+SDO63M1rr6tws9Ki+HJivoJ2yrflHusBjGIyaynUdvlARwB?=
 =?us-ascii?Q?wWasrMKzR/mz2j8w+32gzE97zaUh4LBKTBlUx/i5lYme19cbzajs+fpKkQGM?=
 =?us-ascii?Q?iue1ICs4Ly4AzJHVvk0IL44naHvrl0mS8/LzuxrV4/sRaus3iapDZ0r5Vyj/?=
 =?us-ascii?Q?MqKMuBl7geb2FHRFrXCzzZS3z81S+Eql0LHFocMz8yrY3mTKzVNEWldoQToe?=
 =?us-ascii?Q?PE93lPt4SJDWLlJwV8NppZM67FeW5z2XY+gH/JKDZ2YUONSe9sQY0mXQvHaO?=
 =?us-ascii?Q?RgZEIZ8WP7ZntJ0K/R0t8Cg4rNMhiahgYCXaulKU6kehFH8t6OvpS6HpXt4p?=
 =?us-ascii?Q?EqsAYLwZqLnKyAa89nVeEDs2cRsjzKhSq4mCaL4K7irZ6bM/aBIeMAoVkJ/8?=
 =?us-ascii?Q?/kFGHjTE9rNP34mLe6uxScdNxUPj/FhdxMGKPbqAvDh4usliUqoYF+Oil2Ap?=
 =?us-ascii?Q?4RfWdeckFTbnD1i0ica1/+T5kg6lf4WmWMkf+YMpHVMu7PbC6B/vCsyGTdAx?=
 =?us-ascii?Q?284H8nMSnQDZ//CuAXI/JfmcSosp0trG8b50LGkLmgmIqbO2ONCdaZa8jlAe?=
 =?us-ascii?Q?AwB+50ntrWMCvmuzbnuydJRXu+6Wb1NJcWuFwaTKfpEY76Pvg2LvYzNdJDDC?=
 =?us-ascii?Q?Lq2IUIlaDY2Kg5aIbV54Ab1BuWjEsb00+ednyl1euKkzaAr0wWcbVwWJanc?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98fed0d1-9ff0-453c-fbdf-08dbd7af9e41
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2023 12:15:48.1057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2504
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Disable the RTS threshold for OFDM and CCK rates by default as the
initial RTS threshold is 'IEEE80211_MAX_RTS_THRESHOLD'. And RTS
thresholds for all other rates have already been disabled when init.

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index 6ca2f2c23..bcc63f1cb 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -6104,7 +6104,7 @@ static int rt2800_init_registers(struct rt2x00_dev *rt2x00dev)
 	rt2x00_set_field32(&reg, CCK_PROT_CFG_TX_OP_ALLOW_MM40, 0);
 	rt2x00_set_field32(&reg, CCK_PROT_CFG_TX_OP_ALLOW_GF20, 1);
 	rt2x00_set_field32(&reg, CCK_PROT_CFG_TX_OP_ALLOW_GF40, 0);
-	rt2x00_set_field32(&reg, CCK_PROT_CFG_RTS_TH_EN, 1);
+	rt2x00_set_field32(&reg, CCK_PROT_CFG_RTS_TH_EN, 0);
 	rt2800_register_write(rt2x00dev, CCK_PROT_CFG, reg);
 
 	reg = rt2800_register_read(rt2x00dev, OFDM_PROT_CFG);
@@ -6117,7 +6117,7 @@ static int rt2800_init_registers(struct rt2x00_dev *rt2x00dev)
 	rt2x00_set_field32(&reg, OFDM_PROT_CFG_TX_OP_ALLOW_MM40, 0);
 	rt2x00_set_field32(&reg, OFDM_PROT_CFG_TX_OP_ALLOW_GF20, 1);
 	rt2x00_set_field32(&reg, OFDM_PROT_CFG_TX_OP_ALLOW_GF40, 0);
-	rt2x00_set_field32(&reg, OFDM_PROT_CFG_RTS_TH_EN, 1);
+	rt2x00_set_field32(&reg, OFDM_PROT_CFG_RTS_TH_EN, 0);
 	rt2800_register_write(rt2x00dev, OFDM_PROT_CFG, reg);
 
 	reg = rt2800_register_read(rt2x00dev, MM20_PROT_CFG);
-- 
2.39.2

