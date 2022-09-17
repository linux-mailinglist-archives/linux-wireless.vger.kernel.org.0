Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F6F5BBA52
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Sep 2022 22:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiIQU1F (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Sep 2022 16:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiIQU1D (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Sep 2022 16:27:03 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EB42ED74
        for <linux-wireless@vger.kernel.org>; Sat, 17 Sep 2022 13:27:02 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1oZeOz-0003nT-0D;
        Sat, 17 Sep 2022 22:27:01 +0200
Date:   Sat, 17 Sep 2022 21:26:55 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-wireless@vger.kernel.org, Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v3 03/16] rt2x00: add support for external PA on MT7620
Message-ID: <af2c68ff831816a86fc39b0c10911c129a1f03dc.1663445157.git.daniel@makrotopia.org>
References: <cover.1663445157.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1663445157.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Implement support for external PA connected to MT7620A.

Signed-off-by: Tomislav Požega <pozega.tomislav@gmail.com>
[pozega.tomislav@gmail.com: use chanreg and dccal helpers.]
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
---
 drivers/net/wireless/ralink/rt2x00/rt2800.h   |  1 +
 .../net/wireless/ralink/rt2x00/rt2800lib.c    | 52 ++++++++++++++++++-
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800.h b/drivers/net/wireless/ralink/rt2x00/rt2800.h
index d758e887445783..431502021dc2fe 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800.h
@@ -2739,6 +2739,7 @@ enum rt2800_eeprom_word {
 #define EEPROM_NIC_CONF2_RX_STREAM	FIELD16(0x000f)
 #define EEPROM_NIC_CONF2_TX_STREAM	FIELD16(0x00f0)
 #define EEPROM_NIC_CONF2_CRYSTAL	FIELD16(0x0600)
+#define EEPROM_NIC_CONF2_EXTERNAL_PA	FIELD16(0x8000)
 
 /*
  * EEPROM LNA
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index cc9c5554fdc9ca..b34453bd87174f 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -4368,6 +4368,43 @@ static void rt2800_config_channel(struct rt2x00_dev *rt2x00dev,
 		rt2800_iq_calibrate(rt2x00dev, rf->channel);
 	}
 
+	if (rt2x00_rt(rt2x00dev, RT6352)) {
+		if (test_bit(CAPABILITY_EXTERNAL_PA_TX0,
+			     &rt2x00dev->cap_flags)) {
+			reg = rt2800_register_read(rt2x00dev, RF_CONTROL3);
+			reg |= 0x00000101;
+			rt2800_register_write(rt2x00dev, RF_CONTROL3, reg);
+
+			reg = rt2800_register_read(rt2x00dev, RF_BYPASS3);
+			reg |= 0x00000101;
+			rt2800_register_write(rt2x00dev, RF_BYPASS3, reg);
+
+			rt2800_rfcsr_write_chanreg(rt2x00dev, 43, 0x73);
+			rt2800_rfcsr_write_chanreg(rt2x00dev, 44, 0x73);
+			rt2800_rfcsr_write_chanreg(rt2x00dev, 45, 0x73);
+			rt2800_rfcsr_write_chanreg(rt2x00dev, 46, 0x27);
+			rt2800_rfcsr_write_chanreg(rt2x00dev, 47, 0xC8);
+			rt2800_rfcsr_write_chanreg(rt2x00dev, 48, 0xA4);
+			rt2800_rfcsr_write_chanreg(rt2x00dev, 49, 0x05);
+			rt2800_rfcsr_write_chanreg(rt2x00dev, 54, 0x27);
+			rt2800_rfcsr_write_chanreg(rt2x00dev, 55, 0xC8);
+			rt2800_rfcsr_write_chanreg(rt2x00dev, 56, 0xA4);
+			rt2800_rfcsr_write_chanreg(rt2x00dev, 57, 0x05);
+			rt2800_rfcsr_write_chanreg(rt2x00dev, 58, 0x27);
+			rt2800_rfcsr_write_chanreg(rt2x00dev, 59, 0xC8);
+			rt2800_rfcsr_write_chanreg(rt2x00dev, 60, 0xA4);
+			rt2800_rfcsr_write_chanreg(rt2x00dev, 61, 0x05);
+			rt2800_rfcsr_write_dccal(rt2x00dev, 05, 0x00);
+
+			rt2800_register_write(rt2x00dev, TX0_RF_GAIN_CORRECT,
+					      0x36303636);
+			rt2800_register_write(rt2x00dev, TX0_RF_GAIN_ATTEN,
+					      0x6C6C6B6C);
+			rt2800_register_write(rt2x00dev, TX1_RF_GAIN_ATTEN,
+					      0x6C6C6B6C);
+		}
+	}
+
 	bbp = rt2800_bbp_read(rt2x00dev, 4);
 	rt2x00_set_field8(&bbp, BBP4_BANDWIDTH, 2 * conf_is_ht40(conf));
 	rt2800_bbp_write(rt2x00dev, 4, bbp);
@@ -9566,7 +9603,8 @@ static int rt2800_init_eeprom(struct rt2x00_dev *rt2x00dev)
 	 */
 	eeprom = rt2800_eeprom_read(rt2x00dev, EEPROM_NIC_CONF1);
 
-	if (rt2x00_rt(rt2x00dev, RT3352)) {
+	if (rt2x00_rt(rt2x00dev, RT3352) ||
+	    rt2x00_rt(rt2x00dev, RT6352)) {
 		if (rt2x00_get_field16(eeprom,
 		    EEPROM_NIC_CONF1_EXTERNAL_TX0_PA_3352))
 		    __set_bit(CAPABILITY_EXTERNAL_PA_TX0,
@@ -9577,6 +9615,18 @@ static int rt2800_init_eeprom(struct rt2x00_dev *rt2x00dev)
 			      &rt2x00dev->cap_flags);
 	}
 
+	eeprom = rt2800_eeprom_read(rt2x00dev, EEPROM_NIC_CONF2);
+
+	if (rt2x00_rt(rt2x00dev, RT6352) && eeprom != 0 && eeprom != 0xffff) {
+		if (!rt2x00_get_field16(eeprom,
+					EEPROM_NIC_CONF2_EXTERNAL_PA)) {
+			__clear_bit(CAPABILITY_EXTERNAL_PA_TX0,
+				    &rt2x00dev->cap_flags);
+			__clear_bit(CAPABILITY_EXTERNAL_PA_TX1,
+				    &rt2x00dev->cap_flags);
+		}
+	}
+
 	return 0;
 }
 
-- 
2.37.3

