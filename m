Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996457C914C
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Oct 2023 01:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjJMXW2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Oct 2023 19:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbjJMXW1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Oct 2023 19:22:27 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2072.outbound.protection.outlook.com [40.92.99.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B068BC2
        for <linux-wireless@vger.kernel.org>; Fri, 13 Oct 2023 16:22:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7xUhQ6i0sBLkyhPdw9VnUWOzw+vSLEYLIRp3UZ/Rh/faE8vMciyiLKVKiY0krbo27UFwIRBykxehIj4HXVXoEdds7N9N3plztlDzO98hTNLPmVJYor7K1PNp6y3tD6qlWaN5dY5m3Rd4DiTqnz1Hdpmsvv9rhd4fPOmbvGsbyppnEP8A+Tl3WmbAfK5IEv4Bsj/KFkFuJ9paodNEEyuC8o/R/qibKOm++kMd1GalIcoxXh9wqOXKx/fiiYvlFyMZVyu2mphOg7HFzaj68z0onBm/A08qlL1CvIS0f0s9XfpgCl7l3oOvIRHklWLDo2uBvgyVmf6Kd7SS6MeOvGtoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1C+OECrPgyku3ySESsbfvKbG450xbOMf5+1/jaaWHw=;
 b=bevwldPniCW2hkL5SiDyT6861fvr1yGueeTRswHi2Ri/U+dBGa9OiaXhsyS6zOysXztMCkiCBHQYoPKIP6qKfamBzFoKUjtVlbh1Pz0iUskxpIGshSkHOIehZ4FoRU87O6abVGolFCrx+DVdsKogLCb7FkITzbgY3i3B62ZyDtskKn6MBwMe8wdTFOmepnbB/4M0/m/nVRw7bg7YAn7UeIqT7DU1qJjvVRJ54uRsbpU0MMCIRyAkfaYY0OD2MzisAYQmLXIsnnXG3x+ZWqO1LFYQTvCWJVULuJPq4cIeVeRoG3Mjk3REs8MGPCP4xXboG+Sw91L9K2+nEzciKIpLjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1C+OECrPgyku3ySESsbfvKbG450xbOMf5+1/jaaWHw=;
 b=J7rdCJWGrG7Xl53tMYXUeimI6Se7vJcG3wHDh1/A1tBszwOwwCC1AonRaSX8t6MS6+DseH/E8SibiNuinuVOvdGuxR/FaG07XVdHPk4P57cp2c0SLiHAncwkGrdSFX7p6VNPeTg8TjpKw4Io3z0dFZLmYItlTjNY0DlyVIcCBn2liiGEsLWO1XMvt1gdXlmVTzq5/yMQZV3JItdvIfHNzzQspS5nc8/tyv/s5J19G2bCIE9NAok8HlGNcRUajX5N2gGWmkCoDiuMG6CW/eWRKTpfqbVjx29oL7Fv9cdZCXPYflwywqSOb9vgVQPOzEDkdaYmMcO6oe4Ij4YMuleMcA==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by TYYP286MB1691.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.31; Fri, 13 Oct
 2023 23:22:23 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bbb1:a301:f7b6:744a]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bbb1:a301:f7b6:744a%4]) with mapi id 15.20.6886.030; Fri, 13 Oct 2023
 23:22:23 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     linux-wireless@vger.kernel.org
Cc:     Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH 2/3] wifi: rt2x00: rework MT7620 channel config function
Date:   Sat, 14 Oct 2023 07:21:29 +0800
Message-ID: <TYAP286MB0315DEAEAFE9470077066EFABCD2A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231013232130.416-1-yangshiji66@outlook.com>
References: <20231013232130.416-1-yangshiji66@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [RbpzqHzuEBnShHC64BHf21TB/oW+hMvhOgb7votRxEU=]
X-ClientProxiedBy: TYBP286CA0031.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::19) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20231013232130.416-3-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|TYYP286MB1691:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d88d417-2217-4fbf-9301-08dbcc43412a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DW2eeFaXczsjbSjRInib3aZLEvzyatC+FpZjHS0SbmdTZgYSuL1m1W2N63k30N1XTloYZhwNRMbo/AIYZJgEqBJeNX+47vSKjytJutn1Sr0GdGkETNpUVJybA1wqqtKq51tgfX1Fs7oHLQpOvnaGxqV2PCimuWf3l1z3Yuh6jlQA+qnz0uywQMBMUPtU6ENP5A8POfYpd5rEH7XE54LqaUNl8wIsE9zLTN0QJT4dkpFfpE0AMQhnYgVtjMJCd7h74q1g2bnln8gZzjqST26lBSeQjTfJZ2pOxt8VR/6i+1aDJEGgsnXILckiU4VvULcs6RXRXK5ijiN+Nw6Z5+zugQ/9YZGOGoViSPjwvezR/SGx/lW328dcdtDSsXEKOu9NPM75/drtDsidKJQk0yGxWgMUm2m/c5Fg0rkFtkt/S2I7k/r0hUErWHFf3zeU8ES/LTPbPflQogEuZsSvk06QXHzfi9w6Roqqz+wLDtu838WUEqcGaA4P6KAWfU7Rb/ye0Pk0Do7bhZZqNXHG2mFndMtZHGTN1FGNlPOgm6MQZgcznA6m4L2mj3QU24zbOupVgvBBlkMgQ1JqglfHo5ygTVtQVCR00JY4g1FC2KkpGSgy0shwbDg+a2gglsvipIdn
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zkjZqf3fW8cBhPmWOXK4452ww4p1HBuB1DEFSllzkfNzrBs8HUpbF9hFivJ+?=
 =?us-ascii?Q?OukKjmthqmlXASdfhRDxxdhJTLLkYeWlaif3y7MaeIEmPTXnWI9Gndmzruyp?=
 =?us-ascii?Q?YxVNQVsV6v6yxLm722lVU621yU4w0dOorCD0EhoCZzj3RTD3g5DQXm99Okp1?=
 =?us-ascii?Q?QiosRkK0dOb+ho5k/PciJviyEEOugm+QobPlZgGnYxVU55o5++sfG7Lr1Nyy?=
 =?us-ascii?Q?rEISSi7Hg9tStsPW1Mcwn4TAfAonO56OhsvXce/jmj+HmN/oGuOb/HVpqnTq?=
 =?us-ascii?Q?WmUoNL0294UlBuXWxlh3PGv1wTjuxeolnL8JXKS9aLtTpTGC0dv2SjIlGvFo?=
 =?us-ascii?Q?+Uu4qfL3lAntNly6VZ37Z2E+MrHe/XVuvgjVsdQ7nQaWzblYT5bnqyOIiMmk?=
 =?us-ascii?Q?oX6/vm54NOL3+3MAGTpVtuFoaL25rYJMoUo1n0X0jj3cN8CoFEY61cfwp7hK?=
 =?us-ascii?Q?aGXENs7f5zoscDDwidUtwRd7qxp376ZvDCT4tAEoozhD1l1EwaAzmlMAffho?=
 =?us-ascii?Q?yYl/gYD78hk1EuVRPwWlUBsuN2Ogf0W4/loXCJBUQKRu6WXnm1IQpReFudF3?=
 =?us-ascii?Q?eNaR8E8I2V9X3ulUzAvEsBLhLpexRHNUmAggEe8Un4mP+Er1zfC9sMcUCgeq?=
 =?us-ascii?Q?TL1DmlldzSCCsAEg86q3eP89VbTFKhbCtdaY45Az8Ht6Qom3Xz5W7hmqYagg?=
 =?us-ascii?Q?naazNbHkgnFnGkY2waf5/4BWSpXBY1UEoPzetbqWJ/HRHTk0oqLy0gWjYaeN?=
 =?us-ascii?Q?1fgkKkmnmspVrp3Dms+P+x5pIRCY3IqxEvyvI/4xEJR4X4aYnqcOgjJj1a4q?=
 =?us-ascii?Q?HjHvAtpXYsjTorSpZpbeCLOgNhWarHcOll3EUwhnMQ8RDZv7vOYjIcX9IDlu?=
 =?us-ascii?Q?bArAZ7dPzJSKfiuDrHFrgFsr28hKVB5P1k2IOnjZfia+Uh+PmtVW5hRRXzYq?=
 =?us-ascii?Q?EVJlhjGYqQ6QqYXKo4RgIKUqZEIB8FQoc6+fDf06RQLllyAe2U69MNukmMnO?=
 =?us-ascii?Q?SAgtQI0uUpY+/a4lxri487VzMqcpHJJHrA8WJcXtWjHkUtLjt0ZjSrMsTENy?=
 =?us-ascii?Q?cOcFyQ5Ot0tx1tVrffEwyfbdV2BXj8now/oEcfxCMDrLfiANEsWLJAfmsvst?=
 =?us-ascii?Q?GmdzKChoW6emPZwa9VEixiQCPf5X9lHuijlTGrU80G5MuGEYLzLcE8Db4JkW?=
 =?us-ascii?Q?ugI1LJFm9DxaRGxVYZ6vfU//5RX5EBJd9B62HMgVqT7PNXEaGsttjqqJtuI?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d88d417-2217-4fbf-9301-08dbcc43412a
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 23:22:23.4554
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
index acc720ef4..ae969ec20 100644
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

