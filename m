Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997EE7CF7CC
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Oct 2023 13:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345512AbjJSL7X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Oct 2023 07:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345477AbjJSL7V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Oct 2023 07:59:21 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2058.outbound.protection.outlook.com [40.92.98.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D489F183
        for <linux-wireless@vger.kernel.org>; Thu, 19 Oct 2023 04:59:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtTAxwA2+NVojwbnYq78SmBU1Oat2G4jierVdg6TqHqINleHAG9RmZgHoX65hbumdHUrNEF2yRFAak5vEhlF6f8DRt9VH4CE5sBuq4X6zPVz61s9txZgAWNsxvEk+1HabtR/bmYjeCJQySvWOXzcnn8CS5B31Xtat7fOZaETcclMTVSvDcRdsy2/wEj0eOzhPX6eQvlwBiVGo6Xrn1QhZc3CUSVgCwZlv8EhtJaJ1jHwXoKwVfv7N65QyC0ugSpdkY2wmiKZlgz8rrm4kO/RuHcVMCdJfMB2DnNFjoGa2wZJpTDSvKUTiAtMAus4spVFrs6exk90UnVCKi76T+UEnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YO4duBB9v3ePuxDiJ+DMqt+mufiWbRvk3TlCGAbF5hE=;
 b=M2S6m0agKTXvIUpOfqmqI+oQR2Ahv3IS35U0IMv21w3B3xAZ0utyt/VB8pLavGZt+j3+gUdMtkhyjzdFARFXJGExUlbWREGvELUGqyCNrdRgJ9wrsq5SBY+Z9p9NewwL/G43Iz7mP/uXar41cyqgQRAqwBCArKfVZi+BKotRSU/GEYEZjnABmHVH1BCvmj9cfonBAfbJpihR5ch14ACPsl6TznztGafNpxb130PtF2r6L5fgfMvgiMJni1Gn6v3Epajl5qoFUQmaacKAv2eDZRipg8JHBXwgLBmk2EKAxtRiC346c7V3hvSBaAqHDZ6G8N+Ia+laCeN/2nlHZe2lYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YO4duBB9v3ePuxDiJ+DMqt+mufiWbRvk3TlCGAbF5hE=;
 b=f1nILYjxzXbkIc3wFchacucJYUdLDwP2dtPhESk+T1BOALb/Jv9iTH0HLGH2dyURucGnb4gDp3Wa6K5foO487GcCSfqoe4RMZhovtMFAanna5hSEyWKwHc5Yg0NdoZZ+QNpLPt4S/yAeSaeoZHbN9KTC849HvWTobslr6HVASrJj/qQwvNwFYEvy76++FVxj1ZQuBkwKBkuGXdBCd9PIpJS4j3APDxFOTw0QyfShjLUZ2tn+dUP4vRzPw8cuoV/aguyL1JDxGhgCL6Q9diWAFdVsqRofr6Dkxg3NwMJraAl2gErS204WicL5fRcVmfbb7n1YVZCNXuihhSTK3iiOEQ==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by TYWP286MB2729.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 11:59:17 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::465a:2534:4d99:a25b]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::465a:2534:4d99:a25b%6]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 11:59:17 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     linux-wireless@vger.kernel.org
Cc:     Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH V2 2/3] wifi: rt2x00: rework MT7620 channel config function
Date:   Thu, 19 Oct 2023 19:58:57 +0800
Message-ID: <TYAP286MB0315622A4340BFFA530B1B86BCD4A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231019115859.2791-1-yangshiji66@outlook.com>
References: <20231019115859.2791-1-yangshiji66@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [ytzwQs3hrZpEtWKw1jONlmdpbsKQsQAM]
X-ClientProxiedBy: TYCPR01CA0196.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::20) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20231019115859.2791-3-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|TYWP286MB2729:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c166a8a-e748-4f83-0be1-08dbd09ad201
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9cgpoRPfOV1wYJSKz0euzhH2UBSzkldpjHq7JiQIGNDCNM6I57GUVJhRiByKHQ/nTnmlborawokAAlVWF/7vBcH3uX9KZzxzkqkAjzofMut9evLXZ8IslsszRhLNPvPRMzAveYiZicjJXkgWIw8DBdvTyfE9+BcaIH3rezi3hyOgYdGT7vSFuGt9VFoxrbOVCH0cpa0p+zaEPVdCcput6TeGxINGIhmm1UdElqvZRVJ88cLOW+UdAw2U5JgIhn0pw8l2xSRPT+KPSWorbs+IPl9oBz7X8AAeNgl+pp9r9e20mCeQP7omNXs747zDduQzdDrgwUqlgclb2xGLIbdU9FwFDomMSh+KayTztQuzneNA/hqjUNF6adSOkVjIG8U8nqzOKgB0t7ScbD/f8JFqpjY0zc5zQiHPSmkRHJ+vkXQKRtvKur2W9JTKHUm3/kqCzxEbXnXojTrLpUOTElIeUlKkPhqUKU/HHcXOb6abXscXrLup0J2lt8Ai8kfzCqZIhybhKZhITVfsd1k4aX3rBNYOqyyi0ed86e7fNvWiESVw3ESR9fgu/waCgG6eP8ew6VtFSTQwWGuWf3XtiluqiT6jOC2MahIWX9IlrKXi3mJi0AsMkqij6TFslMTH8ouH
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pseL8vvOsmxVIjbHsNbMUthMdBVC7VkrEy3PEWGgBQqni1jUmCamzV7kDqxe?=
 =?us-ascii?Q?yYRFYDnnTipC2KDInrfyRLWCUOFcCy01lliKsgaOWEqSF4bEMBDkdaTkjOx3?=
 =?us-ascii?Q?zjamw8/WPtRDaePhHDQoe5UZbMsqkkMPDTwFQ+BAfMTvxGQ5Aqg5Q1GOrtaS?=
 =?us-ascii?Q?PiLDbIIVOUjfb/n69mATiKI35D4f2ZxNjukP5LadaxLHrF3KkJrbPSHv213j?=
 =?us-ascii?Q?ZSXjSKy12o50ryl7wVUARaP1COgL0C1vvPMyU7R5CGpHZ5CwmJXT/X+Ts1oX?=
 =?us-ascii?Q?DhZkuEM9U1vZZjWJebUQQ5ErSLauNtDHKSEGffrVp3wl/Wv80406le0cJX2N?=
 =?us-ascii?Q?dQ48JHLzD84eNwg2RLaEY4HdlJNBz2jD5Xs48thcZlexb8xik3+ihbe9vANC?=
 =?us-ascii?Q?LAu/lnXK85D75zgGlVTXBoUgt/uQa1N/O5AHhZ84Ytn374mhCi2Uln/qj1PI?=
 =?us-ascii?Q?cyNXKoi6bo7wuVv6rZFXdIgiIms8txc1keNQAqeBP8DzxledzbozZDkuOM/I?=
 =?us-ascii?Q?0SD/CL5O6deM8gR5JgVEfMwlnZgTPtlGetO24deEkTHgTJuJbit35bkpCV0Y?=
 =?us-ascii?Q?X3ZCF9MsNwA5IcqqLOBFaaObPWQX5Um6czWHYaN4/Xz6cYFc8mDzJBmLi+mi?=
 =?us-ascii?Q?UKF324vMtF+723DirLRFqKOyhtCTPcGZEY0qbEn7PrEMlF0hx+T1cmOb3a6m?=
 =?us-ascii?Q?sC/E5rW1bEANCI+0X6cBwmWQR2jmu/5/m06ypR9ukOjN5Ucp/batWzbEVISY?=
 =?us-ascii?Q?PpeahZnrM2s00J4V7Z+LNNow+rgrjNLZBGm73smfRvIapXeTzPTm2P+gpNYc?=
 =?us-ascii?Q?v8guEHZ9s+MYIbKp6pYUcGI4Xe7j/JiRW6OJ7SQlRhIuOl8JwLWo9vr6k4Wx?=
 =?us-ascii?Q?5vkSpRufVpDB+j/uCV0FeV3GyaZMYH1lfHaJN1X7laXZGwXz6wFxQ80l2wsV?=
 =?us-ascii?Q?Rw1QErWgvAgXLv1JlboKYJqfTH7oBH1Y4ALeK8v3+gLQDMbOTyeKJhTQdsqf?=
 =?us-ascii?Q?SWpjDQ5Y2Kq1H5C5lyxdKjomsgZS6LapTkxleqtCjBDk41W2WcUbjg/ImhkS?=
 =?us-ascii?Q?HixXQIRDQj1l0kpM20+sAyj6MVbNj9/VhTKTei+Mmp2YNubdVeaYdgBq8hmf?=
 =?us-ascii?Q?aCSKTavY3CNjQU7AjL2cnRL2NqAYMLWo/OEXIDHFIofJAjuM5aKljLd4Knwr?=
 =?us-ascii?Q?kCW+bOqlNs4tmhA0iSuOxQUfkm6Q5ZZcWeCn/V7i1y0nODKNf8i6fB6X1nM?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c166a8a-e748-4f83-0be1-08dbd09ad201
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 11:59:17.6605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2729
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

1. Move the channel configuration code from rt2800_vco_calibration()
   to the rt2800_config_channel().
2. Use MT7620 SoC specific AGC initial LNA value instead of the
   RT5592's value.
3. BBP{195,196} pairing write has been replaced with
   rt2800_bbp_glrt_write() to reduce redundant code.

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 .../net/wireless/ralink/rt2x00/rt2800lib.c    | 91 +++++++------------
 1 file changed, 35 insertions(+), 56 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index 08d979f69..66ee50320 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -3913,14 +3913,6 @@ static void rt2800_config_channel_rf7620(struct rt2x00_dev *rt2x00dev,
 		rfcsr |= tx_agc_fc;
 		rt2800_rfcsr_write_bank(rt2x00dev, 7, 59, rfcsr);
 	}
-
-	if (conf_is_ht40(conf)) {
-		rt2800_bbp_glrt_write(rt2x00dev, 141, 0x10);
-		rt2800_bbp_glrt_write(rt2x00dev, 157, 0x2f);
-	} else {
-		rt2800_bbp_glrt_write(rt2x00dev, 141, 0x1a);
-		rt2800_bbp_glrt_write(rt2x00dev, 157, 0x40);
-	}
 }
 
 static void rt2800_config_alc_rt6352(struct rt2x00_dev *rt2x00dev,
@@ -4489,32 +4481,46 @@ static void rt2800_config_channel(struct rt2x00_dev *rt2x00dev,
 		usleep_range(1000, 1500);
 	}
 
-	if (rt2x00_rt(rt2x00dev, RT5592) || rt2x00_rt(rt2x00dev, RT6352)) {
-		reg = 0x10;
-		if (!conf_is_ht40(conf)) {
-			if (rt2x00_rt(rt2x00dev, RT6352) &&
-			    rt2x00_has_cap_external_lna_bg(rt2x00dev)) {
-				reg |= 0x5;
-			} else {
-				reg |= 0xa;
-			}
-		}
-		rt2800_bbp_write(rt2x00dev, 195, 141);
-		rt2800_bbp_write(rt2x00dev, 196, reg);
+	if (rt2x00_rt(rt2x00dev, RT5592)) {
+		bbp = conf_is_ht40(conf) ? 0x10 : 0x1a;
+		rt2800_bbp_glrt_write(rt2x00dev, 141, bbp);
 
-		/* AGC init.
-		 * Despite the vendor driver using different values here for
-		 * RT6352 chip, we use 0x1c for now. This may have to be changed
-		 * once TSSI got implemented.
-		 */
-		reg = (rf->channel <= 14 ? 0x1c : 0x24) + 2*rt2x00dev->lna_gain;
-		rt2800_bbp_write_with_rx_chain(rt2x00dev, 66, reg);
+		bbp = (rf->channel <= 14 ? 0x1c : 0x24) + 2 * rt2x00dev->lna_gain;
+		rt2800_bbp_write_with_rx_chain(rt2x00dev, 66, bbp);
 
-		if (rt2x00_rt(rt2x00dev, RT5592))
-			rt2800_iq_calibrate(rt2x00dev, rf->channel);
+		rt2800_iq_calibrate(rt2x00dev, rf->channel);
 	}
 
 	if (rt2x00_rt(rt2x00dev, RT6352)) {
+		/* BBP for GLRT BW */
+		bbp = conf_is_ht40(conf) ?
+		      0x10 : rt2x00_has_cap_external_lna_bg(rt2x00dev) ?
+		      0x15 : 0x1a;
+		rt2800_bbp_glrt_write(rt2x00dev, 141, bbp);
+
+		bbp = conf_is_ht40(conf) ? 0x2f : 0x40;
+		rt2800_bbp_glrt_write(rt2x00dev, 157, bbp);
+
+		if (rt2x00dev->default_ant.rx_chain_num == 1) {
+			rt2800_bbp_write(rt2x00dev, 91, 0x07);
+			rt2800_bbp_write(rt2x00dev, 95, 0x1a);
+			rt2800_bbp_glrt_write(rt2x00dev, 128, 0xa0);
+			rt2800_bbp_glrt_write(rt2x00dev, 170, 0x12);
+			rt2800_bbp_glrt_write(rt2x00dev, 171, 0x10);
+		} else {
+			rt2800_bbp_write(rt2x00dev, 91, 0x06);
+			rt2800_bbp_write(rt2x00dev, 95, 0x9a);
+			rt2800_bbp_glrt_write(rt2x00dev, 128, 0xe0);
+			rt2800_bbp_glrt_write(rt2x00dev, 170, 0x30);
+			rt2800_bbp_glrt_write(rt2x00dev, 171, 0x30);
+		}
+
+		/* AGC init */
+		bbp = rf->channel <= 14 ? 0x04 + 2 * rt2x00dev->lna_gain : 0;
+		rt2800_bbp_write_with_rx_chain(rt2x00dev, 66, bbp);
+
+		usleep_range(1000, 1500);
+
 		if (test_bit(CAPABILITY_EXTERNAL_PA_TX0,
 			     &rt2x00dev->cap_flags)) {
 			reg = rt2800_register_read(rt2x00dev, RF_CONTROL3);
@@ -5660,26 +5666,6 @@ void rt2800_vco_calibration(struct rt2x00_dev *rt2x00dev)
 	rt2800_register_write(rt2x00dev, TX_PIN_CFG, tx_pin);
 
 	if (rt2x00_rt(rt2x00dev, RT6352)) {
-		if (rt2x00dev->default_ant.rx_chain_num == 1) {
-			rt2800_bbp_write(rt2x00dev, 91, 0x07);
-			rt2800_bbp_write(rt2x00dev, 95, 0x1A);
-			rt2800_bbp_write(rt2x00dev, 195, 128);
-			rt2800_bbp_write(rt2x00dev, 196, 0xA0);
-			rt2800_bbp_write(rt2x00dev, 195, 170);
-			rt2800_bbp_write(rt2x00dev, 196, 0x12);
-			rt2800_bbp_write(rt2x00dev, 195, 171);
-			rt2800_bbp_write(rt2x00dev, 196, 0x10);
-		} else {
-			rt2800_bbp_write(rt2x00dev, 91, 0x06);
-			rt2800_bbp_write(rt2x00dev, 95, 0x9A);
-			rt2800_bbp_write(rt2x00dev, 195, 128);
-			rt2800_bbp_write(rt2x00dev, 196, 0xE0);
-			rt2800_bbp_write(rt2x00dev, 195, 170);
-			rt2800_bbp_write(rt2x00dev, 196, 0x30);
-			rt2800_bbp_write(rt2x00dev, 195, 171);
-			rt2800_bbp_write(rt2x00dev, 196, 0x30);
-		}
-
 		if (rt2x00_has_cap_external_lna_bg(rt2x00dev)) {
 			rt2800_bbp_write(rt2x00dev, 75, 0x68);
 			rt2800_bbp_write(rt2x00dev, 76, 0x4C);
@@ -5687,13 +5673,6 @@ void rt2800_vco_calibration(struct rt2x00_dev *rt2x00dev)
 			rt2800_bbp_write(rt2x00dev, 80, 0x0C);
 			rt2800_bbp_write(rt2x00dev, 82, 0xB6);
 		}
-
-		/* On 11A, We should delay and wait RF/BBP to be stable
-		 * and the appropriate time should be 1000 micro seconds
-		 * 2005/06/05 - On 11G, we also need this delay time.
-		 * Otherwise it's difficult to pass the WHQL.
-		 */
-		usleep_range(1000, 1500);
 	}
 }
 EXPORT_SYMBOL_GPL(rt2800_vco_calibration);
-- 
2.39.2

