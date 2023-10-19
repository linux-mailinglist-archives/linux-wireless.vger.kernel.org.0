Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F167CF7CB
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Oct 2023 13:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345477AbjJSL7Z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Oct 2023 07:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345510AbjJSL7X (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Oct 2023 07:59:23 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2058.outbound.protection.outlook.com [40.92.98.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8FFBE
        for <linux-wireless@vger.kernel.org>; Thu, 19 Oct 2023 04:59:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jl2kzNCJgHvTMM5FPYZ/ji1Qt2/TSAPSonaVU6EWaCKLr1izWOb7Vqqx7YhM4W0i+qGVa7qxvidghn8zJhV5w/opUPQ9C2ebSd/R5JGb+DydL2xWHNOiFiSd6wDIP99fqHofRSrZbtRB+miGIgjQSkggWC09uIq+h9zLyQ5hREKG5JaGSv/svdXsRw7v+hPzu9nBH9Cs0+fOTmhFLjrrclg2NXKnzgIBPoCKfU715O3xKM+5+iwGuHzQ1heVJ76xeFSD4OHMd4XjQcU6ctmh4/uYPGwv1cmkBsBKvYIBU1JMj8ZyhvXTumjiyXp4ocDjN4wektUeIhKBA0yiox0Taw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pc0bAkvhUhiRJF8uj1mMFNtaNi7yZe7xthGQaMlogsA=;
 b=NSCXlEtEwLy2KFsdrWvTsTWHNIUC5O8V46j//w+ni1Zru60HkiT0Gkx6EyzalALlYkbnvyODZr0jkGdEODePT+IFrewScmLzMu1Whlk4ymVYWQDTHyywhNFwdwxmT6x8y4ycL1M81ElTn9Uube3L0jkhC5G5ZLQnSQydaozaZ3yLYsXrQry2KducLiyBPDKD059Rcqt3npytGFFaXiOeqxxe9k7jvXy2BkciJiC04CoxfuYt3giteGG5gWrjFM53wjrxCkpNkOG+bnTIqnlTlPw8CuW9WYx7bqC5/VqhDshRF/gXklYXtbcR9WWimleiETtSaB8CzDsWw7NCy6RT3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pc0bAkvhUhiRJF8uj1mMFNtaNi7yZe7xthGQaMlogsA=;
 b=oDAxKcelJbxHM66khOG9T3BnDL5p1gYvK/rR76KJUxKdajTw5MovPESAtdSn7QJWAg5d7oU3Y0prf7T3oogHRN0PWpiJEQgkStyh/gDlz066EI9SYMmkgNMYLfRF5Iub2IK+8CNJ1ipIXDCTsMnHuQ1DfbsA+2wloA9yB1FXx+CRezdMbdPaB6YL+kpMLlX6fMoNRARKM9GPZMyEX9dNDZKcMsMDDE74zuK2xIgfA1nDhweGlmfJMvbMO7t8ZGmaaODHctouPncTh8Y1hlj5bEEc0Q3XrsAySBuyVe8hF/GSBQjg97kdlVfh7wAVVaIjnDmalCiUD0QZF1+9IkBWaQ==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by TYWP286MB2729.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 11:59:19 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::465a:2534:4d99:a25b]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::465a:2534:4d99:a25b%6]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 11:59:19 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     linux-wireless@vger.kernel.org
Cc:     Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH V2 3/3] wifi: rt2x00: rework MT7620 PA/LNA RF calibration
Date:   Thu, 19 Oct 2023 19:58:58 +0800
Message-ID: <TYAP286MB0315979F92DC563019B8F238BCD4A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231019115859.2791-1-yangshiji66@outlook.com>
References: <20231019115859.2791-1-yangshiji66@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [p80y12FRyRhwvt2Yq82Wzeujl79BdPaX]
X-ClientProxiedBy: TYCPR01CA0196.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::20) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20231019115859.2791-4-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|TYWP286MB2729:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f8995bf-77a9-46c1-17c9-08dbd09ad30c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EY4vBYM7jRh3zaj4J3Y8RSnHHuMIzHomBxWzTl+rxtiNsRgpGrQqVas2ch6MUd3FBUs8ppbgCWXY523Hm9tsZLH/8XI6WSAOGc02Ufx8CNRuJMYuHylhWYq/CqkTiCX5Kd9PRh/kbikaUwbLMszskAirjXpSAlZaNFRz7UTuV7edSwep4ARMBNatpumo/0Pm9JPLZn4WNTlr/hy7RLdlYjodYN0+Ga42SD+rdW7r7uo0gwlbVZQkAIxKR636egNQUj1eQodPo37I2JOWxZqW14SBNWs4FH5hfNJz+Z0CVhyzEngKByt5OrHnCtf8pKhkMrny/JPT1te/GdPv5866eEQwdiHwjQ7Pz38+TG88MyeHCS25pIebDocB+p7FYYB3lUZF23nghwjo+6BEIoP9OMfOpELbb72lpHNuYY2N07nS++otYmmRM7ydb7HJLUlfwudcSevwXaI1UAUcxGTT9nfvKSGhSJKP2gVPv56k9/bqDGDyP0cVW3ge4h9N+FnhFLDFwvuXgN1MYsMAdK1kg0StoMPqKX6XTkm0vsJsT55vcVsW/qhPZrMf0jZ0ufL6t0v8Ktqr/1k+tQ+aZO3x2vSnz17UzJ7AYRCHXM/lTHRRf6mmBHhGtuBoUvPg6qTt
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ab1A5yF0ueS1XuYJwrajnupomuzwe7EarPiS32hLsBUOFPsVX7EML1BTC3SB?=
 =?us-ascii?Q?kutRsc8td3yTVLWYYNI1sXstxSANoAH9z3ZzQ81S3NA2FG2ladHjc69Objeu?=
 =?us-ascii?Q?lOf6PrUAXCCrwrXubcEx6ye0fFthBtG9l1/1WkDzaRhlqwlXZQm37rP0AXF/?=
 =?us-ascii?Q?SqdSxiUym0zAEZJIdtm/zx2M83QTZgzK200jYx+/X5dKT00GEbXmae4Jo8Hz?=
 =?us-ascii?Q?snIwxH4AMY5Rxqnlvq1tDJGlHZBcdVFIckKofuQ3OR+P12p4m3l/vkzXNU4v?=
 =?us-ascii?Q?Bi8vjmeo+q2BEXNhcCRtwUm/PUKC+7lt6+98QtJf3h5At3b/Nk63kPeX6jm3?=
 =?us-ascii?Q?qOi2roo8fclhzC9ufZw+LkrAfbtoP07qrYAoCnvoe/LRfQXegFtoKimxaQ5h?=
 =?us-ascii?Q?hOrcp2Gim7bVl1PBzNlCZYf2qDrhFsHGF67aVuMzwAnXczIfpzETjeJeka9c?=
 =?us-ascii?Q?GVSnktPEQmVhzILEm/mRqZm1+Y7q3OQKkP+wSqLCmKUx9rFKFxa6BV9ejjss?=
 =?us-ascii?Q?Yjs0VsUgMcSZq9ntxTWBNqX4ulTbCL4oZW999syS8+GZ2YEHauEmbaH8O+JG?=
 =?us-ascii?Q?n7Ij60SlxR/CnU3N3JElXjvvEYQiIKswUrMz9A0MxWSAapSj6BbKjzxQq1Oy?=
 =?us-ascii?Q?R7AqBv5V9WGsSxF+yPTna6FVzwbczuCrF9JYRXtRKGBG2SpaDud947bM8quY?=
 =?us-ascii?Q?0zJQOtxCZwhKnTDTXnk204dySA1Ds8yDzKM2AA44YkEZFo+6JkctT6oO1QSG?=
 =?us-ascii?Q?U9DKyZY0T1xCe7Db97e7GcxuKhL6vdHtZqlGuEDYfd0bHFBDy2xEU0oU0atv?=
 =?us-ascii?Q?8b+U9xIq4PChvnQAHIWo2osEqWj5Vgs68h0EtkgR1WfhGGVekND/0XQm7IvG?=
 =?us-ascii?Q?o9MYmH4TKOfD5RSjMIGHEeQZM84TtOLx4inhHz2jXardhdZAZ9e6ll/vHPuR?=
 =?us-ascii?Q?N9sgRIFKepGvywUYHBtzcwQu/LtuMA4J38bVURY59BIWsuAglmc0F5rvgqd7?=
 =?us-ascii?Q?Ecj02lTDY+kUn88eL9jp2Af9gSFNRP5lok8sWkHSOVd0016v0bLrHzo4NzfN?=
 =?us-ascii?Q?w9a9ZytOhUl2Ifsy4lyXRwl+IWoFdoIqZBpVbCAo9s/mMvL7KgVeH3fMygLW?=
 =?us-ascii?Q?4oB9UFzvO+eACofQY7sQfJxn5IKvMbzZWpZG0RJ4WHMo2d4T/O7wZ0ATITDz?=
 =?us-ascii?Q?VVO39Mt/fAKo/N0sWSTw6yRunrSkuKF/syZq0z+HI59B+0nCS7DyDu59alI?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f8995bf-77a9-46c1-17c9-08dbd09ad30c
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 11:59:19.3255
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

1. Move MT7620 PA/LNA calibration code to dedicated functions.
2. For external PA/LNA devices, restore RF and BBP registers before
   R-Calibration.
3. Do Rx DCOC calibration again before RXIQ calibration.
4. Add some missing LNA related registers' initialization.

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 .../net/wireless/ralink/rt2x00/rt2800lib.c    | 176 ++++++++++++------
 drivers/net/wireless/ralink/rt2x00/rt2x00.h   |   6 +
 2 files changed, 130 insertions(+), 52 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index 66ee50320..8d40f52da 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -4520,41 +4520,6 @@ static void rt2800_config_channel(struct rt2x00_dev *rt2x00dev,
 		rt2800_bbp_write_with_rx_chain(rt2x00dev, 66, bbp);
 
 		usleep_range(1000, 1500);
-
-		if (test_bit(CAPABILITY_EXTERNAL_PA_TX0,
-			     &rt2x00dev->cap_flags)) {
-			reg = rt2800_register_read(rt2x00dev, RF_CONTROL3);
-			reg |= 0x00000101;
-			rt2800_register_write(rt2x00dev, RF_CONTROL3, reg);
-
-			reg = rt2800_register_read(rt2x00dev, RF_BYPASS3);
-			reg |= 0x00000101;
-			rt2800_register_write(rt2x00dev, RF_BYPASS3, reg);
-
-			rt2800_rfcsr_write_chanreg(rt2x00dev, 43, 0x73);
-			rt2800_rfcsr_write_chanreg(rt2x00dev, 44, 0x73);
-			rt2800_rfcsr_write_chanreg(rt2x00dev, 45, 0x73);
-			rt2800_rfcsr_write_chanreg(rt2x00dev, 46, 0x27);
-			rt2800_rfcsr_write_chanreg(rt2x00dev, 47, 0xC8);
-			rt2800_rfcsr_write_chanreg(rt2x00dev, 48, 0xA4);
-			rt2800_rfcsr_write_chanreg(rt2x00dev, 49, 0x05);
-			rt2800_rfcsr_write_chanreg(rt2x00dev, 54, 0x27);
-			rt2800_rfcsr_write_chanreg(rt2x00dev, 55, 0xC8);
-			rt2800_rfcsr_write_chanreg(rt2x00dev, 56, 0xA4);
-			rt2800_rfcsr_write_chanreg(rt2x00dev, 57, 0x05);
-			rt2800_rfcsr_write_chanreg(rt2x00dev, 58, 0x27);
-			rt2800_rfcsr_write_chanreg(rt2x00dev, 59, 0xC8);
-			rt2800_rfcsr_write_chanreg(rt2x00dev, 60, 0xA4);
-			rt2800_rfcsr_write_chanreg(rt2x00dev, 61, 0x05);
-			rt2800_rfcsr_write_dccal(rt2x00dev, 05, 0x00);
-
-			rt2800_register_write(rt2x00dev, TX0_RF_GAIN_CORRECT,
-					      0x36303636);
-			rt2800_register_write(rt2x00dev, TX0_RF_GAIN_ATTEN,
-					      0x6C6C6B6C);
-			rt2800_register_write(rt2x00dev, TX1_RF_GAIN_ATTEN,
-					      0x6C6C6B6C);
-		}
 	}
 
 	bbp = rt2800_bbp_read(rt2x00dev, 4);
@@ -5664,16 +5629,6 @@ void rt2800_vco_calibration(struct rt2x00_dev *rt2x00dev)
 		}
 	}
 	rt2800_register_write(rt2x00dev, TX_PIN_CFG, tx_pin);
-
-	if (rt2x00_rt(rt2x00dev, RT6352)) {
-		if (rt2x00_has_cap_external_lna_bg(rt2x00dev)) {
-			rt2800_bbp_write(rt2x00dev, 75, 0x68);
-			rt2800_bbp_write(rt2x00dev, 76, 0x4C);
-			rt2800_bbp_write(rt2x00dev, 79, 0x1C);
-			rt2800_bbp_write(rt2x00dev, 80, 0x0C);
-			rt2800_bbp_write(rt2x00dev, 82, 0xB6);
-		}
-	}
 }
 EXPORT_SYMBOL_GPL(rt2800_vco_calibration);
 
@@ -10400,6 +10355,128 @@ static void rt2800_bw_filter_calibration(struct rt2x00_dev *rt2x00dev,
 	rt2800_register_write(rt2x00dev, RF_BYPASS0, MAC_RF_BYPASS0);
 }
 
+static void rt2800_restore_rf_bbp_rt6352(struct rt2x00_dev *rt2x00dev)
+{
+	if (rt2x00_has_cap_external_pa(rt2x00dev)) {
+		rt2800_register_write(rt2x00dev, RF_CONTROL3, 0x0);
+		rt2800_register_write(rt2x00dev, RF_BYPASS3, 0x0);
+	}
+
+	if (rt2x00_has_cap_external_lna_bg(rt2x00dev)) {
+		rt2800_rfcsr_write_chanreg(rt2x00dev, 14, 0x16);
+		rt2800_rfcsr_write_chanreg(rt2x00dev, 17, 0x23);
+		rt2800_rfcsr_write_chanreg(rt2x00dev, 18, 0x02);
+	}
+
+	if (rt2x00_has_cap_external_pa(rt2x00dev)) {
+		rt2800_rfcsr_write_chanreg(rt2x00dev, 43, 0xd3);
+		rt2800_rfcsr_write_chanreg(rt2x00dev, 44, 0xb3);
+		rt2800_rfcsr_write_chanreg(rt2x00dev, 45, 0xd5);
+		rt2800_rfcsr_write_chanreg(rt2x00dev, 46, 0x27);
+		rt2800_rfcsr_write_chanreg(rt2x00dev, 47, 0x6c);
+		rt2800_rfcsr_write_chanreg(rt2x00dev, 48, 0xfc);
+		rt2800_rfcsr_write_chanreg(rt2x00dev, 49, 0x1f);
+		rt2800_rfcsr_write_chanreg(rt2x00dev, 54, 0x27);
+		rt2800_rfcsr_write_chanreg(rt2x00dev, 55, 0x66);
+		rt2800_rfcsr_write_chanreg(rt2x00dev, 56, 0xff);
+		rt2800_rfcsr_write_chanreg(rt2x00dev, 57, 0x1c);
+		rt2800_rfcsr_write_chanreg(rt2x00dev, 58, 0x20);
+		rt2800_rfcsr_write_chanreg(rt2x00dev, 59, 0x6b);
+		rt2800_rfcsr_write_chanreg(rt2x00dev, 60, 0xf7);
+		rt2800_rfcsr_write_chanreg(rt2x00dev, 61, 0x09);
+	}
+
+	if (rt2x00_has_cap_external_lna_bg(rt2x00dev)) {
+		rt2800_bbp_write(rt2x00dev, 75, 0x60);
+		rt2800_bbp_write(rt2x00dev, 76, 0x44);
+		rt2800_bbp_write(rt2x00dev, 79, 0x1c);
+		rt2800_bbp_write(rt2x00dev, 80, 0x0c);
+		rt2800_bbp_write(rt2x00dev, 82, 0xB6);
+	}
+
+	if (rt2x00_has_cap_external_pa(rt2x00dev)) {
+		rt2800_register_write(rt2x00dev, TX0_RF_GAIN_CORRECT, 0x3630363a);
+		rt2800_register_write(rt2x00dev, TX0_RF_GAIN_ATTEN, 0x6c6c666c);
+		rt2800_register_write(rt2x00dev, TX1_RF_GAIN_ATTEN, 0x6c6c666c);
+	}
+}
+
+static void rt2800_calibration_rt6352(struct rt2x00_dev *rt2x00dev)
+{
+	u32 reg;
+
+	if (rt2x00_has_cap_external_pa(rt2x00dev) ||
+	    rt2x00_has_cap_external_lna_bg(rt2x00dev))
+		rt2800_restore_rf_bbp_rt6352(rt2x00dev);
+
+	rt2800_r_calibration(rt2x00dev);
+	rt2800_rf_self_txdc_cal(rt2x00dev);
+	rt2800_rxdcoc_calibration(rt2x00dev);
+	rt2800_bw_filter_calibration(rt2x00dev, true);
+	rt2800_bw_filter_calibration(rt2x00dev, false);
+	rt2800_loft_iq_calibration(rt2x00dev);
+
+	/* missing DPD calibration for internal PA devices */
+
+	rt2800_rxdcoc_calibration(rt2x00dev);
+	rt2800_rxiq_calibration(rt2x00dev);
+
+	if (!rt2x00_has_cap_external_pa(rt2x00dev) &&
+	    !rt2x00_has_cap_external_lna_bg(rt2x00dev))
+		return;
+
+	if (rt2x00_has_cap_external_pa(rt2x00dev)) {
+		reg = rt2800_register_read(rt2x00dev, RF_CONTROL3);
+		reg |= 0x00000101;
+		rt2800_register_write(rt2x00dev, RF_CONTROL3, reg);
+
+		reg = rt2800_register_read(rt2x00dev, RF_BYPASS3);
+		reg |= 0x00000101;
+		rt2800_register_write(rt2x00dev, RF_BYPASS3, reg);
+	}
+
+	if (rt2x00_has_cap_external_lna_bg(rt2x00dev)) {
+		rt2800_rfcsr_write_chanreg(rt2x00dev, 14, 0x66);
+		rt2800_rfcsr_write_chanreg(rt2x00dev, 17, 0x20);
+		rt2800_rfcsr_write_chanreg(rt2x00dev, 18, 0x42);
+	}
+
+	if (rt2x00_has_cap_external_pa(rt2x00dev)) {
+		rt2800_rfcsr_write_chanreg(rt2x00dev, 43, 0x73);
+		rt2800_rfcsr_write_chanreg(rt2x00dev, 44, 0x73);
+		rt2800_rfcsr_write_chanreg(rt2x00dev, 45, 0x73);
+		rt2800_rfcsr_write_chanreg(rt2x00dev, 46, 0x27);
+		rt2800_rfcsr_write_chanreg(rt2x00dev, 47, 0xc8);
+		rt2800_rfcsr_write_chanreg(rt2x00dev, 48, 0xa4);
+		rt2800_rfcsr_write_chanreg(rt2x00dev, 49, 0x05);
+		rt2800_rfcsr_write_chanreg(rt2x00dev, 54, 0x27);
+		rt2800_rfcsr_write_chanreg(rt2x00dev, 55, 0xc8);
+		rt2800_rfcsr_write_chanreg(rt2x00dev, 56, 0xa4);
+		rt2800_rfcsr_write_chanreg(rt2x00dev, 57, 0x05);
+		rt2800_rfcsr_write_chanreg(rt2x00dev, 58, 0x27);
+		rt2800_rfcsr_write_chanreg(rt2x00dev, 59, 0xc8);
+		rt2800_rfcsr_write_chanreg(rt2x00dev, 60, 0xa4);
+		rt2800_rfcsr_write_chanreg(rt2x00dev, 61, 0x05);
+	}
+
+	if (rt2x00_has_cap_external_pa(rt2x00dev))
+		rt2800_rfcsr_write_dccal(rt2x00dev, 05, 0x00);
+
+	if (rt2x00_has_cap_external_lna_bg(rt2x00dev)) {
+		rt2800_bbp_write(rt2x00dev, 75, 0x68);
+		rt2800_bbp_write(rt2x00dev, 76, 0x4c);
+		rt2800_bbp_write(rt2x00dev, 79, 0x1c);
+		rt2800_bbp_write(rt2x00dev, 80, 0x0c);
+		rt2800_bbp_write(rt2x00dev, 82, 0xb6);
+	}
+
+	if (rt2x00_has_cap_external_pa(rt2x00dev)) {
+		rt2800_register_write(rt2x00dev, TX0_RF_GAIN_CORRECT, 0x36303636);
+		rt2800_register_write(rt2x00dev, TX0_RF_GAIN_ATTEN, 0x6c6c6b6c);
+		rt2800_register_write(rt2x00dev, TX1_RF_GAIN_ATTEN, 0x6c6c6b6c);
+	}
+}
+
 static void rt2800_init_rfcsr_6352(struct rt2x00_dev *rt2x00dev)
 {
 	/* Initialize RF central register to default value */
@@ -10664,13 +10741,8 @@ static void rt2800_init_rfcsr_6352(struct rt2x00_dev *rt2x00dev)
 	rt2800_rfcsr_write_dccal(rt2x00dev, 5, 0x00);
 	rt2800_rfcsr_write_dccal(rt2x00dev, 17, 0x7C);
 
-	rt2800_r_calibration(rt2x00dev);
-	rt2800_rf_self_txdc_cal(rt2x00dev);
-	rt2800_rxdcoc_calibration(rt2x00dev);
-	rt2800_bw_filter_calibration(rt2x00dev, true);
-	rt2800_bw_filter_calibration(rt2x00dev, false);
-	rt2800_loft_iq_calibration(rt2x00dev);
-	rt2800_rxiq_calibration(rt2x00dev);
+	/* Do calibration and init PA/LNA */
+	rt2800_calibration_rt6352(rt2x00dev);
 }
 
 static void rt2800_init_rfcsr(struct rt2x00_dev *rt2x00dev)
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00.h b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
index b8338a422..0f6252ea6 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
@@ -1267,6 +1267,12 @@ rt2x00_has_cap_external_lna_bg(struct rt2x00_dev *rt2x00dev)
 	return rt2x00_has_cap_flag(rt2x00dev, CAPABILITY_EXTERNAL_LNA_BG);
 }
 
+static inline bool
+rt2x00_has_cap_external_pa(struct rt2x00_dev *rt2x00dev)
+{
+	return rt2x00_has_cap_flag(rt2x00dev, CAPABILITY_EXTERNAL_PA_TX0);
+}
+
 static inline bool
 rt2x00_has_cap_double_antenna(struct rt2x00_dev *rt2x00dev)
 {
-- 
2.39.2

