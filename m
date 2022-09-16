Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89BB5BB498
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Sep 2022 01:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiIPXGM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Sep 2022 19:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiIPXGL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Sep 2022 19:06:11 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B884BBA9F9
        for <linux-wireless@vger.kernel.org>; Fri, 16 Sep 2022 16:06:10 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1oZKPR-00070k-04;
        Sat, 17 Sep 2022 01:06:09 +0200
Date:   Sat, 17 Sep 2022 00:06:03 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-wireless@vger.kernel.org, Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 06/15] rt2x00: add RXDCOC calibration for MT7620
Message-ID: <YyUBWzXPay3QAXQo@makrotopia.org>
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

Add RXDCOC calibration code from mtk driver.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
[fixed typo reported by Serge Vasilugin <vasilugin@yandex.ru>]
Signed-off-by: Tomislav Požega <pozega.tomislav@gmail.com>
---
 .../net/wireless/ralink/rt2x00/rt2800lib.c    | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index 6c107801c83643..d5b4dba3b27203 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -8631,6 +8631,70 @@ static void rt2800_r_calibration(struct rt2x00_dev *rt2x00dev)
 	rt2800_register_write(rt2x00dev, PWR_PIN_CFG, MAC_PWR_PIN_CFG);
 }
 
+static void rt2800_rxdcoc_calibration(struct rt2x00_dev *rt2x00dev)
+{
+	u8 bbpreg = 0;
+	u32 macvalue = 0, macvalue1 = 0;
+	u8 saverfb0r2, saverfb5r4, saverfb7r4, rfvalue;
+	int i;
+
+	saverfb0r2 = rt2800_rfcsr_read_bank(rt2x00dev, 0, 2);
+	rfvalue = saverfb0r2;
+	rfvalue |= 0x03;
+	rt2800_rfcsr_write_bank(rt2x00dev, 0, 2, rfvalue);
+
+	rt2800_bbp_write(rt2x00dev, 158, 141);
+	bbpreg = rt2800_bbp_read(rt2x00dev, 159);
+	bbpreg |= 0x10;
+	rt2800_bbp_write(rt2x00dev, 159, bbpreg);
+
+	macvalue = rt2800_register_read(rt2x00dev, MAC_SYS_CTRL);
+	rt2800_register_write(rt2x00dev, MAC_SYS_CTRL, 0x8);
+
+	for (i = 0; i < 10000; i++) {
+		macvalue1 = rt2800_register_read(rt2x00dev, MAC_STATUS_CFG);
+		if (macvalue1 & 0x1)
+			usleep_range(50, 100);
+		else
+			break;
+	}
+
+	saverfb5r4 = rt2800_rfcsr_read_bank(rt2x00dev, 5, 4);
+	saverfb7r4 = rt2800_rfcsr_read_bank(rt2x00dev, 7, 4);
+	saverfb5r4 = saverfb5r4 & (~0x40);
+	saverfb7r4 = saverfb7r4 & (~0x40);
+	rt2800_rfcsr_write_dccal(rt2x00dev, 4, 0x64);
+	rt2800_rfcsr_write_bank(rt2x00dev, 5, 4, saverfb5r4);
+	rt2800_rfcsr_write_bank(rt2x00dev, 7, 4, saverfb7r4);
+
+	rt2800_bbp_write(rt2x00dev, 158, 141);
+	bbpreg = rt2800_bbp_read(rt2x00dev, 159);
+	bbpreg = bbpreg & (~0x40);
+	rt2800_bbp_write(rt2x00dev, 159, bbpreg);
+	bbpreg |= 0x48;
+	rt2800_bbp_write(rt2x00dev, 159, bbpreg);
+
+	for (i = 0; i < 10000; i++) {
+		bbpreg = rt2800_bbp_read(rt2x00dev, 159);
+		if ((bbpreg & 0x40) == 0)
+			break;
+		usleep_range(50, 100);
+	}
+
+	bbpreg = rt2800_bbp_read(rt2x00dev, 159);
+	bbpreg = bbpreg & (~0x40);
+	rt2800_bbp_write(rt2x00dev, 159, bbpreg);
+
+	rt2800_register_write(rt2x00dev, MAC_SYS_CTRL, macvalue);
+
+	rt2800_bbp_write(rt2x00dev, 158, 141);
+	bbpreg = rt2800_bbp_read(rt2x00dev, 159);
+	bbpreg &= (~0x10);
+	rt2800_bbp_write(rt2x00dev, 159, bbpreg);
+
+	rt2800_rfcsr_write_bank(rt2x00dev, 0, 2, saverfb0r2);
+}
+
 static void rt2800_bbp_core_soft_reset(struct rt2x00_dev *rt2x00dev,
 				       bool set_bw, bool is_ht40)
 {
@@ -9240,6 +9304,7 @@ static void rt2800_init_rfcsr_6352(struct rt2x00_dev *rt2x00dev)
 
 	rt2800_r_calibration(rt2x00dev);
 	rt2800_rf_self_txdc_cal(rt2x00dev);
+	rt2800_rxdcoc_calibration(rt2x00dev);
 	rt2800_bw_filter_calibration(rt2x00dev, true);
 	rt2800_bw_filter_calibration(rt2x00dev, false);
 }
-- 
2.37.3

