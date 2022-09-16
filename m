Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485AC5BB495
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Sep 2022 01:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiIPXFi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Sep 2022 19:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiIPXFg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Sep 2022 19:05:36 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C43274BAF
        for <linux-wireless@vger.kernel.org>; Fri, 16 Sep 2022 16:05:35 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1oZKOr-000709-1X;
        Sat, 17 Sep 2022 01:05:33 +0200
Date:   Sat, 17 Sep 2022 00:05:27 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-wireless@vger.kernel.org, Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 04/15] rt2x00: add RF self TXDC calibration for MT7620
Message-ID: <YyUBN0F9t8GfTEQ3@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tomislav Požega <pozega.tomislav@gmail.com>

Add TX self calibration based on mtk driver.

Signed-off-by: Tomislav Požega <pozega.tomislav@gmail.com>
---
 .../net/wireless/ralink/rt2x00/rt2800lib.c    | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index b34453bd87174f..d8b7f90c05c42b 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -8435,6 +8435,53 @@ static void rt2800_init_rfcsr_5592(struct rt2x00_dev *rt2x00dev)
 	rt2800_led_open_drain_enable(rt2x00dev);
 }
 
+static void rt2800_rf_self_txdc_cal(struct rt2x00_dev *rt2x00dev)
+{
+	u8 rfb5r1_org, rfb7r1_org, rfvalue;
+	u32 mac0518, mac051c, mac0528, mac052c;
+	u8 i;
+
+	mac0518 = rt2800_register_read(rt2x00dev, RF_CONTROL0);
+	mac051c = rt2800_register_read(rt2x00dev, RF_BYPASS0);
+	mac0528 = rt2800_register_read(rt2x00dev, RF_CONTROL2);
+	mac052c = rt2800_register_read(rt2x00dev, RF_BYPASS2);
+
+	rt2800_register_write(rt2x00dev, RF_BYPASS0, 0x0);
+	rt2800_register_write(rt2x00dev, RF_BYPASS2, 0x0);
+
+	rt2800_register_write(rt2x00dev, RF_CONTROL0, 0xC);
+	rt2800_register_write(rt2x00dev, RF_BYPASS0, 0x3306);
+	rt2800_register_write(rt2x00dev, RF_CONTROL2, 0x3330);
+	rt2800_register_write(rt2x00dev, RF_BYPASS2, 0xfffff);
+	rfb5r1_org = rt2800_rfcsr_read_bank(rt2x00dev, 5, 1);
+	rfb7r1_org = rt2800_rfcsr_read_bank(rt2x00dev, 7, 1);
+
+	rt2800_rfcsr_write_bank(rt2x00dev, 5, 1, 0x4);
+	for (i = 0; i < 100; i = i + 1) {
+		usleep_range(50, 100);
+		rfvalue = rt2800_rfcsr_read_bank(rt2x00dev, 5, 1);
+		if ((rfvalue & 0x04) != 0x4)
+			break;
+	}
+	rt2800_rfcsr_write_bank(rt2x00dev, 5, 1, rfb5r1_org);
+
+	rt2800_rfcsr_write_bank(rt2x00dev, 7, 1, 0x4);
+	for (i = 0; i < 100; i = i + 1) {
+		usleep_range(50, 100);
+		rfvalue = rt2800_rfcsr_read_bank(rt2x00dev, 7, 1);
+		if ((rfvalue & 0x04) != 0x4)
+			break;
+	}
+	rt2800_rfcsr_write_bank(rt2x00dev, 7, 1, rfb7r1_org);
+
+	rt2800_register_write(rt2x00dev, RF_BYPASS0, 0x0);
+	rt2800_register_write(rt2x00dev, RF_BYPASS2, 0x0);
+	rt2800_register_write(rt2x00dev, RF_CONTROL0, mac0518);
+	rt2800_register_write(rt2x00dev, RF_BYPASS0, mac051c);
+	rt2800_register_write(rt2x00dev, RF_CONTROL2, mac0528);
+	rt2800_register_write(rt2x00dev, RF_BYPASS2, mac052c);
+}
+
 static void rt2800_bbp_core_soft_reset(struct rt2x00_dev *rt2x00dev,
 				       bool set_bw, bool is_ht40)
 {
@@ -9042,6 +9089,7 @@ static void rt2800_init_rfcsr_6352(struct rt2x00_dev *rt2x00dev)
 	rt2800_rfcsr_write_dccal(rt2x00dev, 5, 0x00);
 	rt2800_rfcsr_write_dccal(rt2x00dev, 17, 0x7C);
 
+	rt2800_rf_self_txdc_cal(rt2x00dev);
 	rt2800_bw_filter_calibration(rt2x00dev, true);
 	rt2800_bw_filter_calibration(rt2x00dev, false);
 }
-- 
2.37.3

