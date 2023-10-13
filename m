Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20347C914D
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Oct 2023 01:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbjJMXWa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Oct 2023 19:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjJMXW2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Oct 2023 19:22:28 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2072.outbound.protection.outlook.com [40.92.99.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09996BB
        for <linux-wireless@vger.kernel.org>; Fri, 13 Oct 2023 16:22:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7+8CVhxGCRStBIyPqeV8VnntumzVyeoPMTXGbi0pxU80HTAqmvBZ4wiuunJVGv9e1r8CTq+gH/0ZVcOy27K0exX6LsfcYOLDyP1IsIY/eIqgcykXtWc7bzRXgwjYeBk3oGOfZokZHyV1qM28LmVWQqhOJV8xrOCTiBW192B7swquq179Q3u4yeqhA0LTU8Jw1ramgsWbDbGlMgShhdEiU/N7cB+l30ijSeUkPHgbNBECZ+cjpXZlba0j0saNLShortWoN29tsdykWUPa8m+NQ0rjYzejsqtsvevV9Anx2SJX3Rtl5a2kmdJbjb4WjG7IFT9ndGcQELKAveVDt4fSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvY1UXZmJVpx06oc5WN2TTCInIhhuYRfsxLv+dtf2rM=;
 b=RQYBtJOlo2K0DfVJQIK1YDwYsyxHJH++L1sbyjEt6VF/fN3r6lStwrR9qP/z/0m/5PEsjJCz1UxwIihaAG9CJ8nvkcq2or7CIM+rm9AbsgZhvAbeBrhB5JxtOPXyIPDl37DHwK5CrUDDm+lZI6dudQY9t50V3Tt1bqLfQzoC5HfCY+HzeVACgAJ+qnEXMYTAc+YOk6FZXhuQQ5KjR2z6wz+5nLjCk2y+kPl5mmuL7wftwOFSV3J9WraGY8DfjC3kpgLhQITFZQ2OuyBn7QTEonJWfr+OEQ41YrY/5IVUL2jemeUCVRODNmcKJRP1g1TOQBQgf65jCDdXK/FJiqf/LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvY1UXZmJVpx06oc5WN2TTCInIhhuYRfsxLv+dtf2rM=;
 b=sa23bupshmVURIwZo/2YR4hrV4H/7112T6j40Ifo4/6FgsJE//uJOiLWitEvikgpniaaEga0y/fAS2j3t6C5yTpbwX7jd6TzRojGe0nURRnLjHvOCwp8GuVgBekfVDgfAw0IgEfGP3E1julKmHH1/sqmLBvcNZlke+TznlmJrrj5NRwWMAxqJSUGEqZvmCz1JKLEdtLVe+nc0SJ161elwfha2z1um3WWN3JpyzLzbDJb+JaUUTdub/TYspGQYPNYBLCf5ZDkdJmOCLOHRxUM5dOt70YnGp+NXmo16u+FqybmiBTyn6GkB+C0FGykYGmoEK1stMZhOAtgfhugpwvjCQ==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by TYYP286MB1691.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.31; Fri, 13 Oct
 2023 23:22:25 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bbb1:a301:f7b6:744a]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bbb1:a301:f7b6:744a%4]) with mapi id 15.20.6886.030; Fri, 13 Oct 2023
 23:22:24 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     linux-wireless@vger.kernel.org
Cc:     Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH 3/3] wifi: rt2x00: rework MT7620 PA/LNA RF calibration
Date:   Sat, 14 Oct 2023 07:21:30 +0800
Message-ID: <TYAP286MB031551F2B4A929484A35EF28BCD2A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231013232130.416-1-yangshiji66@outlook.com>
References: <20231013232130.416-1-yangshiji66@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [lBGTfHv+G5FlaqKCitlau+NIALSeTE5LvntsXrvZ94M=]
X-ClientProxiedBy: TYBP286CA0031.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::19) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20231013232130.416-4-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|TYYP286MB1691:EE_
X-MS-Office365-Filtering-Correlation-Id: 1856485a-fd59-4cc6-1791-08dbcc43420d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Do7QUnWsb1or38uKPAHrYtf3SvSxAaLycV4OzdI+YSRoJwdVyvV/JdQb2Fv3PM4WAvtzCccOU4hLHxeTIvB21TnY2sxsxyBy1QtyfkIOf/E0rmlFpGkW+eI/RPkpyLtzHggRyNYJIXhG0Y29UpkIelH1pF1FgROC1eB6VsCKJlA56S19ou+SNAmCFXGeIZ57I00gtsNtUHYwiM3j1jnJt7kegUM2TFsXuLHdJNjlnS3A9EThMHGLXwbzfbuaWgVdM7HRVEIMc70btFQEvWdwoBqSc51OTHeitxw19ldg2u1SOBNFh+sDXnAtw/kJ6vC1ZhEdTwZ6fGcAK7miYKU5gQeDBF21jjbuEHTprjHkb9dnhtiy6vKKLRHz1jPGdUozP7T9ogfgwW1B7KDR4gOqAd/tsoXoPWw42MPImXDi5bwdu4agPVbIkRJElA6mQiiu3f2YfJza73RwPDDmfuItAqF2e61fwFxi0BnHcFc/DDKi06/Af98bDg6eyry4rDkS6dXESudKWJRnDrxJoH3BQ7d2kaEZsVPZgMxUTo63udPpccOTbjj90yWZOk9vW8U6hxwQ6aYSbIpGuu0qPweBtMn5+UsF6/G+8Sgwq3uRP/g=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N/eBKIYQDbz8jIyJe3/toEVwvj3W4Zk+c9kp+SM/1XPjqfqQaBK8mVB6LKUK?=
 =?us-ascii?Q?9K3TRMr96JYV4uppPpkQWfsBIxjMQUwwH9BMd+IVJCUBBbyvkovinMhi7WfP?=
 =?us-ascii?Q?VJYO//UQ+jI2yheUo/YHPR9qQuH9SqQm+DmHJb+30//zVNDy3tXII5AtA8Wn?=
 =?us-ascii?Q?Id8+9IFYAKDzdbqiz9+VQYeycIxzOHOFRxpWzeS+T+gt3J/8QCRTHLnA8L/K?=
 =?us-ascii?Q?aZyHfLW3wTfYJoGL+c1i9vCV/Inxm0RqISQCcPMw5KK9kqCW4U78mY/3EBqn?=
 =?us-ascii?Q?/LgcK82ggguujiHwaayGlRkxNPp33i3aJ+xs7gHJ+fcHdsp+1ut78zB5tShe?=
 =?us-ascii?Q?EzPPsRDWqgsMUu5y2G9ncqpngOiKqSv6kHzOmzD9vJpdXtd6SO06wh8tE3Km?=
 =?us-ascii?Q?wFimzKOyPSyseCNlgmA5e/U9J/o+fXX0siyuBsH5KXhstLojXlcpjt5WEZSs?=
 =?us-ascii?Q?KClv8MIcebQg2ZNfR4h3cKNdyddpdbc6W5ND/xXl9FyQtG3f2eNTqFupErTX?=
 =?us-ascii?Q?/KTwjVCewmZv9pBK3ze79yaqDiKMtFJhPZ+WAQXHxaH3xoP3fXfXgUMjJoEV?=
 =?us-ascii?Q?pNaHFmGxyPGW3Gj+3JFRerhQB4oe2JTSLebj7KaJCU5j4LNpjdqOFhGChoAL?=
 =?us-ascii?Q?C+UindihEuZdc8xRZL6UzXw0GBYamAnArDq6eKp/pdsuRZdWFZ0DX/KSzZZ1?=
 =?us-ascii?Q?oypYNrHGx/fELLnMlgFy5zeLQtOI4xINr7zuVcXJhjcnqcXe5iZDw/422wXz?=
 =?us-ascii?Q?D/aFj/BEHbo1ftWB88SufGfaffqm1SL+jjxKDFyv4XJmmrP14jhfScw9thcJ?=
 =?us-ascii?Q?ziA1JUL+XaDjWj76uPbF8tEiX1GEaXMFG8wZFe3NOT+m1CbK5bjejeJVaTiL?=
 =?us-ascii?Q?t0FSMqTveYsnjxo9AzCNS1jwXtKRpCQmyY4C09lPnedEcckn/lSLuxminPDR?=
 =?us-ascii?Q?u19CCuAxUtEPQVlQK4/8O1jvtZ/cattth2EBQgeRHqH3DnBlxOpWDm2P41rn?=
 =?us-ascii?Q?bVA673qcIkPIwdThoflqX2xWBINhS0s/PEXoVf3gu602ydW00ob4udDo072o?=
 =?us-ascii?Q?xdY8T8PNRTFUDI2/3X0sI0ajQcsXG84A7ZN3ODF+4GnDKsVM+b+OmeV7jOxV?=
 =?us-ascii?Q?CNDj6LEWdcMYt1Co+LJaFa2M2lNol39rXe59zCA3ZHZgi+h80owx0sfvaZBq?=
 =?us-ascii?Q?+Xxs61Rb+rhiubNOTi33BBzOOdaMq/GiMLw3rkiz+SNsH2GT+7YjCjQ7Y6g?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1856485a-fd59-4cc6-1791-08dbcc43420d
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 23:22:24.9241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB1691
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 .../net/wireless/ralink/rt2x00/rt2800lib.c    | 179 ++++++++++++------
 drivers/net/wireless/ralink/rt2x00/rt2x00.h   |   6 +
 2 files changed, 132 insertions(+), 53 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index ae969ec20..6e483eba2 100644
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
 
@@ -10663,14 +10618,6 @@ static void rt2800_init_rfcsr_6352(struct rt2x00_dev *rt2x00dev)
 
 	rt2800_rfcsr_write_dccal(rt2x00dev, 5, 0x00);
 	rt2800_rfcsr_write_dccal(rt2x00dev, 17, 0x7C);
-
-	rt2800_r_calibration(rt2x00dev);
-	rt2800_rf_self_txdc_cal(rt2x00dev);
-	rt2800_rxdcoc_calibration(rt2x00dev);
-	rt2800_bw_filter_calibration(rt2x00dev, true);
-	rt2800_bw_filter_calibration(rt2x00dev, false);
-	rt2800_loft_iq_calibration(rt2x00dev);
-	rt2800_rxiq_calibration(rt2x00dev);
 }
 
 static void rt2800_init_rfcsr(struct rt2x00_dev *rt2x00dev)
@@ -10722,6 +10669,128 @@ static void rt2800_init_rfcsr(struct rt2x00_dev *rt2x00dev)
 	}
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
 int rt2800_enable_radio(struct rt2x00_dev *rt2x00dev)
 {
 	u32 reg;
@@ -10762,6 +10831,10 @@ int rt2800_enable_radio(struct rt2x00_dev *rt2x00dev)
 	rt2800_init_bbp(rt2x00dev);
 	rt2800_init_rfcsr(rt2x00dev);
 
+	/* Do calibration and init PA/LNA for RT6352 */
+	if (rt2x00_rt(rt2x00dev, RT6352))
+		rt2800_calibration_rt6352(rt2x00dev);
+
 	if (rt2x00_is_usb(rt2x00dev) &&
 	    (rt2x00_rt(rt2x00dev, RT3070) ||
 	     rt2x00_rt(rt2x00dev, RT3071) ||
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

