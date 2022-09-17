Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2E45BB987
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Sep 2022 18:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiIQQqQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Sep 2022 12:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiIQQqO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Sep 2022 12:46:14 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4913207D
        for <linux-wireless@vger.kernel.org>; Sat, 17 Sep 2022 09:46:13 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1oZaxH-0002eF-1C;
        Sat, 17 Sep 2022 18:46:11 +0200
Date:   Sat, 17 Sep 2022 17:46:05 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-wireless@vger.kernel.org, Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 05/16] rt2x00: add RF self TXDC calibration for MT7620
Message-ID: <1966de8202ca74135be344acb2afd2de4b1fe058.1663431288.git.daniel@makrotopia.org>
References: <cover.1663431288.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1663431288.git.daniel@makrotopia.org>
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
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
---
v2: use ++i instead of i = i + 1 in loops

 .../net/wireless/ralink/rt2x00/rt2800lib.c    | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index cf5463cb7b642b..ed2c6105899b8d 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -8428,6 +8428,53 @@ static void rt2800_init_rfcsr_5592(struct rt2x00_dev *rt2x00dev)
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
+	for (i = 0; i < 100; ++i) {
+		usleep_range(50, 100);
+		rfvalue = rt2800_rfcsr_read_bank(rt2x00dev, 5, 1);
+		if ((rfvalue & 0x04) != 0x4)
+			break;
+	}
+	rt2800_rfcsr_write_bank(rt2x00dev, 5, 1, rfb5r1_org);
+
+	rt2800_rfcsr_write_bank(rt2x00dev, 7, 1, 0x4);
+	for (i = 0; i < 100; ++i) {
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
@@ -9035,6 +9082,7 @@ static void rt2800_init_rfcsr_6352(struct rt2x00_dev *rt2x00dev)
 	rt2800_rfcsr_write_dccal(rt2x00dev, 5, 0x00);
 	rt2800_rfcsr_write_dccal(rt2x00dev, 17, 0x7C);
 
+	rt2800_rf_self_txdc_cal(rt2x00dev);
 	rt2800_bw_filter_calibration(rt2x00dev, true);
 	rt2800_bw_filter_calibration(rt2x00dev, false);
 }
-- 
2.37.3

