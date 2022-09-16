Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F655BB497
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Sep 2022 01:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiIPXFz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Sep 2022 19:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiIPXFy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Sep 2022 19:05:54 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15776BA9F9
        for <linux-wireless@vger.kernel.org>; Fri, 16 Sep 2022 16:05:52 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1oZKP9-00070R-0w;
        Sat, 17 Sep 2022 01:05:51 +0200
Date:   Sat, 17 Sep 2022 00:05:45 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-wireless@vger.kernel.org, Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 05/15] rt2x00: add r calibration for MT7620
Message-ID: <YyUBSRPR0UXP6+ej@makrotopia.org>
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

Add r calibration code as found in mtk driver.

Signed-off-by: Tomislav Požega <pozega.tomislav@gmail.com>
---
 .../net/wireless/ralink/rt2x00/rt2800lib.c    | 150 ++++++++++++++++++
 1 file changed, 150 insertions(+)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index d8b7f90c05c42b..6c107801c83643 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -8482,6 +8482,155 @@ static void rt2800_rf_self_txdc_cal(struct rt2x00_dev *rt2x00dev)
 	rt2800_register_write(rt2x00dev, RF_BYPASS2, mac052c);
 }
 
+static int rt2800_calcrcalibrationcode(struct rt2x00_dev *rt2x00dev, int d1, int d2)
+{
+	int calcode = ((d2 - d1) * 1000) / 43;
+
+	if ((calcode % 10) >= 5)
+		calcode += 10;
+	calcode = (calcode / 10);
+
+	return calcode;
+}
+
+static void rt2800_r_calibration(struct rt2x00_dev *rt2x00dev)
+{
+	u32 savemacsysctrl;
+	u8 saverfb0r1, saverfb0r34, saverfb0r35;
+	u8 saverfb5r4, saverfb5r17, saverfb5r18;
+	u8 saverfb5r19, saverfb5r20;
+	u8 savebbpr22, savebbpr47, savebbpr49;
+	u8 bytevalue = 0;
+	int rcalcode;
+	u8 r_cal_code = 0;
+	char d1 = 0, d2 = 0;
+	u8 rfvalue;
+	u32 MAC_RF_BYPASS0, MAC_RF_CONTROL0, MAC_PWR_PIN_CFG;
+	u32 maccfg, macstatus;
+	int i;
+
+	saverfb0r1 = rt2800_rfcsr_read_bank(rt2x00dev, 0, 1);
+	saverfb0r34 = rt2800_rfcsr_read_bank(rt2x00dev, 0, 34);
+	saverfb0r35 = rt2800_rfcsr_read_bank(rt2x00dev, 0, 35);
+	saverfb5r4 = rt2800_rfcsr_read_bank(rt2x00dev, 5, 4);
+	saverfb5r17 = rt2800_rfcsr_read_bank(rt2x00dev, 5, 17);
+	saverfb5r18 = rt2800_rfcsr_read_bank(rt2x00dev, 5, 18);
+	saverfb5r19 = rt2800_rfcsr_read_bank(rt2x00dev, 5, 19);
+	saverfb5r20 = rt2800_rfcsr_read_bank(rt2x00dev, 5, 20);
+
+	savebbpr22 = rt2800_bbp_read(rt2x00dev, 22);
+	savebbpr47 = rt2800_bbp_read(rt2x00dev, 47);
+	savebbpr49 = rt2800_bbp_read(rt2x00dev, 49);
+
+	savemacsysctrl = rt2800_register_read(rt2x00dev, MAC_SYS_CTRL);
+	MAC_RF_BYPASS0 = rt2800_register_read(rt2x00dev, RF_BYPASS0);
+	MAC_RF_CONTROL0 = rt2800_register_read(rt2x00dev, RF_CONTROL0);
+	MAC_PWR_PIN_CFG = rt2800_register_read(rt2x00dev, PWR_PIN_CFG);
+
+	maccfg = rt2800_register_read(rt2x00dev, MAC_SYS_CTRL);
+	maccfg &= (~0x04);
+	rt2800_register_write(rt2x00dev, MAC_SYS_CTRL, maccfg);
+
+	for (i = 0; i < 10000; i++) {
+		macstatus = rt2800_register_read(rt2x00dev, MAC_STATUS_CFG);
+		if (macstatus & 0x1)
+			usleep_range(50, 100);
+		else
+			break;
+	}
+
+	if (i == 10000)
+		rt2x00_warn(rt2x00dev, "Wait MAC Tx Status to MAX !!!\n");
+
+	maccfg = rt2800_register_read(rt2x00dev, MAC_SYS_CTRL);
+	maccfg &= (~0x04);
+	rt2800_register_write(rt2x00dev, MAC_SYS_CTRL, maccfg);
+
+	for (i = 0; i < 10000; i++) {
+		macstatus = rt2800_register_read(rt2x00dev, MAC_STATUS_CFG);
+		if (macstatus & 0x2)
+			usleep_range(50, 100);
+		else
+			break;
+		}
+
+	if (i == 10000)
+		rt2x00_warn(rt2x00dev, "Wait MAC Rx Status to MAX !!!\n");
+
+	rfvalue = (MAC_RF_BYPASS0 | 0x3004);
+	rt2800_register_write(rt2x00dev, RF_BYPASS0, rfvalue);
+	rfvalue = (MAC_RF_CONTROL0 | (~0x3002));
+	rt2800_register_write(rt2x00dev, RF_CONTROL0, rfvalue);
+
+	rt2800_rfcsr_write_bank(rt2x00dev, 5, 4, 0x27);
+	rt2800_rfcsr_write_bank(rt2x00dev, 5, 17, 0x80);
+	rt2800_rfcsr_write_bank(rt2x00dev, 5, 18, 0x83);
+	rt2800_rfcsr_write_bank(rt2x00dev, 5, 19, 0x00);
+	rt2800_rfcsr_write_bank(rt2x00dev, 5, 20, 0x20);
+
+	rt2800_rfcsr_write_bank(rt2x00dev, 0, 1, 0x00);
+	rt2800_rfcsr_write_bank(rt2x00dev, 0, 34, 0x13);
+	rt2800_rfcsr_write_bank(rt2x00dev, 0, 35, 0x00);
+
+	rt2800_register_write(rt2x00dev, PWR_PIN_CFG, 0x1);
+
+	rt2800_bbp_write(rt2x00dev, 47, 0x04);
+	rt2800_bbp_write(rt2x00dev, 22, 0x80);
+	usleep_range(100, 200);
+	bytevalue = rt2800_bbp_read(rt2x00dev, 49);
+	if (bytevalue > 128)
+		d1 = bytevalue - 256;
+	else
+		d1 = (char)bytevalue;
+	rt2800_bbp_write(rt2x00dev, 22, 0x0);
+	rt2800_rfcsr_write_bank(rt2x00dev, 0, 35, 0x01);
+
+	rt2800_bbp_write(rt2x00dev, 22, 0x80);
+	usleep_range(100, 200);
+	bytevalue = rt2800_bbp_read(rt2x00dev, 49);
+	if (bytevalue > 128)
+		d2 = bytevalue - 256;
+	else
+		d2 = (char)bytevalue;
+	rt2800_bbp_write(rt2x00dev, 22, 0x0);
+
+	rcalcode = rt2800_calcrcalibrationcode(rt2x00dev, d1, d2);
+	if (rcalcode < 0)
+		r_cal_code = 256 + rcalcode;
+	else
+		r_cal_code = (u8)rcalcode;
+
+	rt2800_rfcsr_write_bank(rt2x00dev, 0, 7, r_cal_code);
+
+	rt2800_bbp_write(rt2x00dev, 22, 0x0);
+
+	bytevalue = rt2800_bbp_read(rt2x00dev, 21);
+	bytevalue |= 0x1;
+	rt2800_bbp_write(rt2x00dev, 21, bytevalue);
+	bytevalue = rt2800_bbp_read(rt2x00dev, 21);
+	bytevalue &= (~0x1);
+	rt2800_bbp_write(rt2x00dev, 21, bytevalue);
+
+	rt2800_rfcsr_write_bank(rt2x00dev, 0, 1, saverfb0r1);
+	rt2800_rfcsr_write_bank(rt2x00dev, 0, 34, saverfb0r34);
+	rt2800_rfcsr_write_bank(rt2x00dev, 0, 35, saverfb0r35);
+	rt2800_rfcsr_write_bank(rt2x00dev, 5, 4, saverfb5r4);
+	rt2800_rfcsr_write_bank(rt2x00dev, 5, 17, saverfb5r17);
+	rt2800_rfcsr_write_bank(rt2x00dev, 5, 18, saverfb5r18);
+	rt2800_rfcsr_write_bank(rt2x00dev, 5, 19, saverfb5r19);
+	rt2800_rfcsr_write_bank(rt2x00dev, 5, 20, saverfb5r20);
+
+	rt2800_bbp_write(rt2x00dev, 22, savebbpr22);
+	rt2800_bbp_write(rt2x00dev, 47, savebbpr47);
+	rt2800_bbp_write(rt2x00dev, 49, savebbpr49);
+
+	rt2800_register_write(rt2x00dev, RF_BYPASS0, MAC_RF_BYPASS0);
+	rt2800_register_write(rt2x00dev, RF_CONTROL0, MAC_RF_CONTROL0);
+
+	rt2800_register_write(rt2x00dev, MAC_SYS_CTRL, savemacsysctrl);
+	rt2800_register_write(rt2x00dev, PWR_PIN_CFG, MAC_PWR_PIN_CFG);
+}
+
 static void rt2800_bbp_core_soft_reset(struct rt2x00_dev *rt2x00dev,
 				       bool set_bw, bool is_ht40)
 {
@@ -9089,6 +9238,7 @@ static void rt2800_init_rfcsr_6352(struct rt2x00_dev *rt2x00dev)
 	rt2800_rfcsr_write_dccal(rt2x00dev, 5, 0x00);
 	rt2800_rfcsr_write_dccal(rt2x00dev, 17, 0x7C);
 
+	rt2800_r_calibration(rt2x00dev);
 	rt2800_rf_self_txdc_cal(rt2x00dev);
 	rt2800_bw_filter_calibration(rt2x00dev, true);
 	rt2800_bw_filter_calibration(rt2x00dev, false);
-- 
2.37.3

