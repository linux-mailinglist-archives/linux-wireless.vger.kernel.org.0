Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363B47ABCE2
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Sep 2023 03:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjIWBBa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Sep 2023 21:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjIWBB3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Sep 2023 21:01:29 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2057.outbound.protection.outlook.com [40.92.99.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94563B9
        for <linux-wireless@vger.kernel.org>; Fri, 22 Sep 2023 18:01:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kRSZzuJEbec/7VMnDfE78bEu6xRznmMfSxpKzWEMC2qRSyp5EJeiF+J3Qr/5jvhZRx15dThyRrJA8ioQUpzTXFjyV1affknQ4zGQVOz1rIllOeZd4YLByM+kqpxzeeYpuKmXDO1/nhvEMBQXUxkm7sM026u3tEJ10/f9cy+huvcm6suW4xAzrKH6vEAPw07e/fRGdi+L3MbccmqM78rJZAMk5PE1VMhXTQFcfZIGPQsorUenH0MpMPn7V8sHZFW28vp/TI1tPOet/9P5QTA95cB7fPFHJwnXwPSGy7MfUJPoCE+81KWZpn/84lMuPEU0clPrwlsjw7LvFybtmk8byQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uzi4i0BgdVA56fE13xUT6TUwLaS7HUB0BaxPxBkcswI=;
 b=ZCLyg3H+MlLykWM3sTdCXL8bPHgn8Xo/RgPgNK9NBwhrtBxba+F9brQI18xqRkBsNkUD43jdkVYqPfmlbqcOt2No1WLBVkJsrk2C7BKPiFO+Q7QB39sAhMVK1vMKCRILB7VcKdr5BH5SIRHCT0pRjsR67EYagB5l/gnIWEp3OOQTbwl0wPOaDrJDtVv9mnZM2KYBqBQ0BPvfJR1Nu6yJkzKPXOwpf2bGBSdMtKj6359ho2nd9vaBQ7Wwo99soc7+OXYlgpIIFpdm1yzm/fT8RrAPDU+sf8G6Ae9yG5rB9+5RYpB6p5QvtZhQboAJUyE7J99aiSZvCCEXs/gbLFUgMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uzi4i0BgdVA56fE13xUT6TUwLaS7HUB0BaxPxBkcswI=;
 b=iUxCQWTnQ+OllEgRe+uuIfiw7RV3KhpPxClTl4wiZbMiwM5w+M8JGyvfSMMGvy1vMRqB6Zq4BmLGc6fLUblISlXQu45zmZbzzG6ZeeQcX95mzW1hhTL4MU2mx05FKJRPpcXP6dg2r7A/DzYRId0OtjzBRRvXXVsqSgySRlELqLM0JFM8qgv9aMqQkuV4+yoNsdX+j/ecCcW5S8GOtpKNsFKnYtfCKUYBAylE1GDReCupb//+1kJ9NlPg0826MnR3nsIp9wtIJtmaYjXd2WkgzRPTVg0XLA/rd5xHQUMNAeXSwvuh8ZxLzXt2UJdO+tYAoD7M44hiedHRkGAz7y4/2g==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by TYCP286MB3218.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.14; Sat, 23 Sep
 2023 01:01:20 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bbb1:a301:f7b6:744a]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bbb1:a301:f7b6:744a%4]) with mapi id 15.20.6838.013; Sat, 23 Sep 2023
 01:01:20 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     linux-wireless@vger.kernel.org
Cc:     Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH] wifi: rt2x00: fix MT7620 low RSSI issue
Date:   Sat, 23 Sep 2023 09:01:01 +0800
Message-ID: <TYAP286MB031571CDB146C414A908A66DBCFEA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [0uTnhV3KAyaD+OOLShHEYmkSnPKNkucB]
X-ClientProxiedBy: TYCP286CA0127.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::9) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20230923010101.11773-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|TYCP286MB3218:EE_
X-MS-Office365-Filtering-Correlation-Id: 8002503b-63a2-49c4-4555-08dbbbd09599
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PuAyoOy78aypQLHVBG1m+iHMjPS3eP3eqAZcy1RN2BwljRLI6N2QFlTYPhJ0YD2xYqwonbko4hWlyE3k3fRYLAjuchUdCB82Qqbne4dTP2D6cm4em2qgSYfP1vbWAzqYDQEtr1p3mffnMv+rPwDFr6fx5asHadaEz6qfS1mokIiJI9b6p2J/89XQ3Z2yYFUGd5AtnfKmZ+5h2CoBiwb+tB0ItyCklepTNr3PaR9DUfLjCbFSaKx5d1b9n1JV7Et4GQost0VtookLoA6PvQj8I6zTbwOQRQAiT58yddrssH+7pP9HRX6qr7xh4ELO3dmB0IonF5bCq32LX+QDczbVmD9k57GgtHA5wFLQVBwaVyLuJTOxZ6v6k5lTVrzcjFWEDwBxRLAzrC+IobBqhk12L+IWIZ9PrRdHIqDkzFaLdg+re3kVrvyan+sVzvK+VuV1MClbMOdbWKKt/bjoA/GOxEUt/59JHvG5m6PSeH9yNQYPUpsCKDdV0WJaJ2lfqeztfpZmppc5Cdcsp6ZueFM3hRRVKYNgAy6IF7fvHHJT52kpspqtV+UTre6VAYUFJHi51l2Cw3zRfSJOrU6gRuifNXGlSnrLgh9cvz8AAnGyJrFsQx6lKTGCBMs5PdgVHszw
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XY9744JUuAKlJ1QgwFMA/WUFoFA1Or4LYNATN0icsP2Sle8F9gX/4kAxRDHB?=
 =?us-ascii?Q?9zAFS4ZAyZgILYv2k50mkepYLg/e+smFgqWGBwYgTzygqk2HRUQj5m9zAsfZ?=
 =?us-ascii?Q?hui2va5RIim2RAyZeG31prD8UEGPlv//iVL0oDGQQrBcus5jILBvBAkmayEK?=
 =?us-ascii?Q?EAgzKajRFiWisOzk1QMgVV9Zy7ZEmynLBqQ3cAWaB8uo0zXWLmXylv4Cu+MO?=
 =?us-ascii?Q?xnh6TxgjsABzT0QD549mxAUyN9bcZlN90jOEelbeBUGT4OGiwLRhcGcWRqx7?=
 =?us-ascii?Q?gwiUSM6dhb9DhWd3EiAUoifBZ2uRAEht7sluvnQEbKy4klT8Z5QQbIyYtG+L?=
 =?us-ascii?Q?wpZAbWCPAFqRnlxE/+4U06kbgF3hpq+GsHwLL3wndksq9+YZ7fOiGDzn4BIo?=
 =?us-ascii?Q?/DuJVaeuz0sBmouL8TiecP78qf84ePx6zLOIv+uaTHimsK9B7BvltJoGOy7k?=
 =?us-ascii?Q?Gg81q7QShUCG17I6SNm6EbEleHO7KaI5AoBdU6UTT9Iykz5Q4XbN/2BlWGzh?=
 =?us-ascii?Q?RVI6jvLWMssLct4ogCArkwjQPbrn0vMA0wx9ArdAtCXV0PUM4hxsyBBMzH+g?=
 =?us-ascii?Q?5RAWvscizRUZFaxXQzGltiBzZ/nRzI7h919EcbB2N6JbMR0g0LR0QYOIAFTJ?=
 =?us-ascii?Q?1NduNjMlhF3FxrRq7lgiyJUt/zJvvd6Gbc0zMJx95KotWwmBqeTxiftSIHbo?=
 =?us-ascii?Q?g2+8W497H04+hIRkMhZEcpqnseR/KgA5hWi965+opRL98e5vE57mcZJXzpMr?=
 =?us-ascii?Q?yVRcmxcyffoSGEaPaIpbwV9Tgs3K522J45LLyGolaJKA9VOP/Y7CUVk+CVsk?=
 =?us-ascii?Q?/O4JNN0TzMEMEaIRo2YjgOiemyNam29I40yec65dKJxY7IC9Bmc3jZxo4MqI?=
 =?us-ascii?Q?9ZrJtO207AQpCiNqa7u/Oau3ZH8odWc5zyuwaMbljnh3C72m5aYuAMkxVCyz?=
 =?us-ascii?Q?ovf0DZW+5sGq+BhdW99TlywTgFIgFzS2haYEhbCJKVjg2ZMvj4nXZE5XKaWY?=
 =?us-ascii?Q?gcbCeezLJyp9bMJUUThiiYk7iFEFeeDwzVM3ypEJ0ubnZyMQR3w2IV1e60ez?=
 =?us-ascii?Q?Dz4fFtXtec8ocospWV+Dtf/mwv0PM+HCZ9xfL2+pgX7/QkdU6jAKjblIxVhi?=
 =?us-ascii?Q?NRT6H6tSONyJJmRfHqkB5Mhqkjj7Jripi09jZSLQKhGbpYiRxq1IjIkmchZt?=
 =?us-ascii?Q?eTdkxWIDM/+SZzfAsJ8b+uZwhUhoiBbGm9eGuEIyUGSDZqBJo/QFMdGjmag?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8002503b-63a2-49c4-4555-08dbbbd09599
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2023 01:01:20.6265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3218
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mediatek vendor driver[1], MT7620 (RT6352) uses different RSSI
base value '-2' compared to the other RT2x00 chips. This patch
introduces the SoC specific base value to fix the low RSSI value
reports on MT7620.

[1] Found on MT76x2E_MT7620_LinuxAP_V3.0.4.0_P3 ConvertToRssi().

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index e65cc00fa..a652379cd 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -856,6 +856,7 @@ static int rt2800_agc_to_rssi(struct rt2x00_dev *rt2x00dev, u32 rxwi_w2)
 	s8 rssi0 = rt2x00_get_field32(rxwi_w2, RXWI_W2_RSSI0);
 	s8 rssi1 = rt2x00_get_field32(rxwi_w2, RXWI_W2_RSSI1);
 	s8 rssi2 = rt2x00_get_field32(rxwi_w2, RXWI_W2_RSSI2);
+	s8 base_val = rt2x00_rt(rt2x00dev, RT6352) ? -2 : -12;
 	u16 eeprom;
 	u8 offset0;
 	u8 offset1;
@@ -880,9 +881,9 @@ static int rt2800_agc_to_rssi(struct rt2x00_dev *rt2x00dev, u32 rxwi_w2)
 	 * If the value in the descriptor is 0, it is considered invalid
 	 * and the default (extremely low) rssi value is assumed
 	 */
-	rssi0 = (rssi0) ? (-12 - offset0 - rt2x00dev->lna_gain - rssi0) : -128;
-	rssi1 = (rssi1) ? (-12 - offset1 - rt2x00dev->lna_gain - rssi1) : -128;
-	rssi2 = (rssi2) ? (-12 - offset2 - rt2x00dev->lna_gain - rssi2) : -128;
+	rssi0 = (rssi0) ? (base_val - offset0 - rt2x00dev->lna_gain - rssi0) : -128;
+	rssi1 = (rssi1) ? (base_val - offset1 - rt2x00dev->lna_gain - rssi1) : -128;
+	rssi2 = (rssi2) ? (base_val - offset2 - rt2x00dev->lna_gain - rssi2) : -128;
 
 	/*
 	 * mac80211 only accepts a single RSSI value. Calculating the
-- 
2.39.2

