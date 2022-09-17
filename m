Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6C45BB986
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Sep 2022 18:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiIQQpw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Sep 2022 12:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiIQQpv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Sep 2022 12:45:51 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BC231DC0
        for <linux-wireless@vger.kernel.org>; Sat, 17 Sep 2022 09:45:48 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1oZaws-0002dt-2Q;
        Sat, 17 Sep 2022 18:45:46 +0200
Date:   Sat, 17 Sep 2022 17:45:41 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-wireless@vger.kernel.org, Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 04/16] rt2x00: move up and reuse busy wait functions
Message-ID: <5bab3172b5168e3af155fdac0b59ec7d22ba94ef.1663431288.git.daniel@makrotopia.org>
References: <cover.1663431288.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1663431288.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move bbp_ready and rf_ready busy wait functions up in the code so they
can more easily be used. Allow specifying register mask in rf_ready
function which is useful for calibration routines which will be added
in follow-up commits.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 .../net/wireless/ralink/rt2x00/rt2800lib.c    | 99 +++++++++----------
 1 file changed, 46 insertions(+), 53 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index b34453bd87174f..cf5463cb7b642b 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -2143,6 +2143,48 @@ void rt2800_config_erp(struct rt2x00_dev *rt2x00dev, struct rt2x00lib_erp *erp,
 }
 EXPORT_SYMBOL_GPL(rt2800_config_erp);
 
+static int rt2800_wait_bbp_rf_ready(struct rt2x00_dev *rt2x00dev,
+				    const struct rt2x00_field32 mask)
+{
+	unsigned int i;
+	u32 reg;
+
+	for (i = 0; i < REGISTER_BUSY_COUNT; i++) {
+		reg = rt2800_register_read(rt2x00dev, MAC_STATUS_CFG);
+		if (!rt2x00_get_field32(reg, mask))
+			return 0;
+
+		udelay(REGISTER_BUSY_DELAY);
+	}
+
+	rt2x00_err(rt2x00dev, "BBP/RF register access failed, aborting\n");
+	return -EACCES;
+}
+
+static int rt2800_wait_bbp_ready(struct rt2x00_dev *rt2x00dev)
+{
+	unsigned int i;
+	u8 value;
+
+	/*
+	 * BBP was enabled after firmware was loaded,
+	 * but we need to reactivate it now.
+	 */
+	rt2800_register_write(rt2x00dev, H2M_BBP_AGENT, 0);
+	rt2800_register_write(rt2x00dev, H2M_MAILBOX_CSR, 0);
+	msleep(1);
+
+	for (i = 0; i < REGISTER_BUSY_COUNT; i++) {
+		value = rt2800_bbp_read(rt2x00dev, 0);
+		if ((value != 0xff) && (value != 0x00))
+			return 0;
+		udelay(REGISTER_BUSY_DELAY);
+	}
+
+	rt2x00_err(rt2x00dev, "BBP register access failed, aborting\n");
+	return -EACCES;
+}
+
 static void rt2800_config_3572bt_ant(struct rt2x00_dev *rt2x00dev)
 {
 	u32 reg;
@@ -3799,10 +3841,9 @@ static void rt2800_config_alc(struct rt2x00_dev *rt2x00dev,
 			      struct ieee80211_channel *chan,
 			      int power_level) {
 	u16 eeprom, target_power, max_power;
-	u32 mac_sys_ctrl, mac_status;
+	u32 mac_sys_ctrl;
 	u32 reg;
 	u8 bbp;
-	int i;
 
 	/* hardware unit is 0.5dBm, limited to 23.5dBm */
 	power_level *= 2;
@@ -3838,16 +3879,8 @@ static void rt2800_config_alc(struct rt2x00_dev *rt2x00dev,
 	/* Disable Tx/Rx */
 	rt2800_register_write(rt2x00dev, MAC_SYS_CTRL, 0);
 	/* Check MAC Tx/Rx idle */
-	for (i = 0; i < 10000; i++) {
-		mac_status = rt2800_register_read(rt2x00dev, MAC_STATUS_CFG);
-		if (mac_status & 0x3)
-			usleep_range(50, 200);
-		else
-			break;
-	}
-
-	if (i == 10000)
-		rt2x00_warn(rt2x00dev, "Wait MAC Status to MAX !!!\n");
+	if (unlikely(rt2800_wait_bbp_rf_ready(rt2x00dev, MAC_STATUS_CFG_BBP_RF_BUSY)))
+		rt2x00_warn(rt2x00dev, "RF busy while configuring ALC\n");
 
 	if (chan->center_freq > 2457) {
 		bbp = rt2800_bbp_read(rt2x00dev, 30);
@@ -6249,46 +6282,6 @@ static int rt2800_init_registers(struct rt2x00_dev *rt2x00dev)
 	return 0;
 }
 
-static int rt2800_wait_bbp_rf_ready(struct rt2x00_dev *rt2x00dev)
-{
-	unsigned int i;
-	u32 reg;
-
-	for (i = 0; i < REGISTER_BUSY_COUNT; i++) {
-		reg = rt2800_register_read(rt2x00dev, MAC_STATUS_CFG);
-		if (!rt2x00_get_field32(reg, MAC_STATUS_CFG_BBP_RF_BUSY))
-			return 0;
-
-		udelay(REGISTER_BUSY_DELAY);
-	}
-
-	rt2x00_err(rt2x00dev, "BBP/RF register access failed, aborting\n");
-	return -EACCES;
-}
-
-static int rt2800_wait_bbp_ready(struct rt2x00_dev *rt2x00dev)
-{
-	unsigned int i;
-	u8 value;
-
-	/*
-	 * BBP was enabled after firmware was loaded,
-	 * but we need to reactivate it now.
-	 */
-	rt2800_register_write(rt2x00dev, H2M_BBP_AGENT, 0);
-	rt2800_register_write(rt2x00dev, H2M_MAILBOX_CSR, 0);
-	msleep(1);
-
-	for (i = 0; i < REGISTER_BUSY_COUNT; i++) {
-		value = rt2800_bbp_read(rt2x00dev, 0);
-		if ((value != 0xff) && (value != 0x00))
-			return 0;
-		udelay(REGISTER_BUSY_DELAY);
-	}
-
-	rt2x00_err(rt2x00dev, "BBP register access failed, aborting\n");
-	return -EACCES;
-}
 
 static void rt2800_bbp4_mac_if_ctrl(struct rt2x00_dev *rt2x00dev)
 {
@@ -9110,7 +9103,7 @@ int rt2800_enable_radio(struct rt2x00_dev *rt2x00dev)
 	/*
 	 * Wait BBP/RF to wake up.
 	 */
-	if (unlikely(rt2800_wait_bbp_rf_ready(rt2x00dev)))
+	if (unlikely(rt2800_wait_bbp_rf_ready(rt2x00dev, MAC_STATUS_CFG_BBP_RF_BUSY)))
 		return -EIO;
 
 	/*
-- 
2.37.3

