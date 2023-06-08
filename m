Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA15727BE9
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jun 2023 11:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234522AbjFHJv4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Jun 2023 05:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234282AbjFHJvz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Jun 2023 05:51:55 -0400
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7230269E
        for <linux-wireless@vger.kernel.org>; Thu,  8 Jun 2023 02:51:49 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-23.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-23.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:5503:0:640:7fc3:0])
        by forward100b.mail.yandex.net (Yandex) with ESMTP id E9D5960145;
        Thu,  8 Jun 2023 12:51:47 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-23.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 8pRApaJDbuQ0-3j6sx4U5;
        Thu, 08 Jun 2023 12:51:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1686217907;
        bh=nQXU0OOrZNFUL3tdLuVUtth2byulINx+mfhN8DpOB0Q=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=H9pWWq5/0d0D7qe/thEY2z2S+y99v5ZfBNKjioCCxjxImGkYffrE822BMPC35AD/5
         XRczmZlg5LsecCDsrDaA4z9dkxWpsDiunbwBHaWpJB3Pyjwv3zZvlFhulyn4tnxHmW
         UgM4XyhuKY4THnnVwVucw6JaoCSIdG1EyDnr7r4M=
Authentication-Results: mail-nwsmtp-smtp-production-main-23.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 4/4] [v2] wifi: rtlwifi: simplify LED management
Date:   Thu,  8 Jun 2023 12:50:51 +0300
Message-Id: <20230608095051.116702-4-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230608095051.116702-1-dmantipov@yandex.ru>
References: <20230605100700.111644-1-dmantipov@yandex.ru>
 <20230608095051.116702-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce 'rtl_init_sw_leds()' to replace per-chip LED
initialization code (and so drop 'struct rtl_led' as no
longer used), drop 'init_sw_leds' and 'deinit_sw_leds'
fields from 'struct rtl_hal_ops', adjust related code.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: adjust to match series
---
 drivers/net/wireless/realtek/rtlwifi/core.c   | 10 ++++
 drivers/net/wireless/realtek/rtlwifi/core.h   |  2 +
 drivers/net/wireless/realtek/rtlwifi/pci.c    |  2 +-
 .../wireless/realtek/rtlwifi/rtl8188ee/hw.c   |  8 +--
 .../wireless/realtek/rtlwifi/rtl8188ee/led.c  | 40 ++++---------
 .../wireless/realtek/rtlwifi/rtl8188ee/led.h  |  5 +-
 .../wireless/realtek/rtlwifi/rtl8188ee/sw.c   |  1 -
 .../wireless/realtek/rtlwifi/rtl8192ce/hw.c   |  8 +--
 .../wireless/realtek/rtlwifi/rtl8192ce/led.c  | 43 ++++---------
 .../wireless/realtek/rtlwifi/rtl8192ce/led.h  |  5 +-
 .../wireless/realtek/rtlwifi/rtl8192ce/sw.c   |  1 -
 .../wireless/realtek/rtlwifi/rtl8192cu/led.c  | 58 ++++--------------
 .../wireless/realtek/rtlwifi/rtl8192cu/led.h  |  6 +-
 .../wireless/realtek/rtlwifi/rtl8192cu/sw.c   |  2 -
 .../wireless/realtek/rtlwifi/rtl8192de/hw.c   |  8 +--
 .../wireless/realtek/rtlwifi/rtl8192de/led.c  | 44 ++++----------
 .../wireless/realtek/rtlwifi/rtl8192de/led.h  |  5 +-
 .../wireless/realtek/rtlwifi/rtl8192de/sw.c   |  1 -
 .../wireless/realtek/rtlwifi/rtl8192ee/hw.c   |  8 +--
 .../wireless/realtek/rtlwifi/rtl8192ee/led.c  | 40 ++++---------
 .../wireless/realtek/rtlwifi/rtl8192ee/led.h  |  5 +-
 .../wireless/realtek/rtlwifi/rtl8192ee/sw.c   |  1 -
 .../wireless/realtek/rtlwifi/rtl8192se/hw.c   | 10 ++--
 .../wireless/realtek/rtlwifi/rtl8192se/led.c  | 44 ++++----------
 .../wireless/realtek/rtlwifi/rtl8192se/led.h  |  5 +-
 .../wireless/realtek/rtlwifi/rtl8192se/sw.c   |  1 -
 .../wireless/realtek/rtlwifi/rtl8723ae/hw.c   |  8 +--
 .../wireless/realtek/rtlwifi/rtl8723ae/led.c  | 44 ++++----------
 .../wireless/realtek/rtlwifi/rtl8723ae/led.h  |  5 +-
 .../wireless/realtek/rtlwifi/rtl8723ae/sw.c   |  1 -
 .../wireless/realtek/rtlwifi/rtl8723be/hw.c   |  8 +--
 .../wireless/realtek/rtlwifi/rtl8723be/led.c  | 44 ++++----------
 .../wireless/realtek/rtlwifi/rtl8723be/led.h  |  5 +-
 .../wireless/realtek/rtlwifi/rtl8723be/sw.c   |  1 -
 .../wireless/realtek/rtlwifi/rtl8821ae/hw.c   | 14 ++---
 .../wireless/realtek/rtlwifi/rtl8821ae/led.c  | 60 ++++++-------------
 .../wireless/realtek/rtlwifi/rtl8821ae/led.h  |  9 ++-
 .../wireless/realtek/rtlwifi/rtl8821ae/sw.c   |  1 -
 drivers/net/wireless/realtek/rtlwifi/usb.c    |  3 +-
 drivers/net/wireless/realtek/rtlwifi/wifi.h   | 14 +----
 40 files changed, 189 insertions(+), 391 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/core.c b/drivers/net/wireless/realtek/rtlwifi/core.c
index 6f10727cdb94..4fb16f5f6f83 100644
--- a/drivers/net/wireless/realtek/rtlwifi/core.c
+++ b/drivers/net/wireless/realtek/rtlwifi/core.c
@@ -1908,6 +1908,16 @@ bool rtl_cmd_send_packet(struct ieee80211_hw *hw, struct sk_buff *skb)
 	return true;
 }
 EXPORT_SYMBOL(rtl_cmd_send_packet);
+
+void rtl_init_sw_leds(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+
+	rtlpriv->ledctl.sw_led0 = LED_PIN_LED0;
+	rtlpriv->ledctl.sw_led1 = LED_PIN_LED1;
+}
+EXPORT_SYMBOL(rtl_init_sw_leds);
+
 const struct ieee80211_ops rtl_ops = {
 	.start = rtl_op_start,
 	.stop = rtl_op_stop,
diff --git a/drivers/net/wireless/realtek/rtlwifi/core.h b/drivers/net/wireless/realtek/rtlwifi/core.h
index 345161b47442..42c2d9e13bb8 100644
--- a/drivers/net/wireless/realtek/rtlwifi/core.h
+++ b/drivers/net/wireless/realtek/rtlwifi/core.h
@@ -51,6 +51,8 @@ enum dm_dig_connect_e {
 };
 
 extern const struct ieee80211_ops rtl_ops;
+
+void rtl_init_sw_leds(struct ieee80211_hw *hw);
 void rtl_fw_cb(const struct firmware *firmware, void *context);
 void rtl_wowlan_fw_cb(const struct firmware *firmware, void *context);
 void rtl_addr_delay(u32 addr);
diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index 028a7c97bacf..9886e719739b 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -2260,7 +2260,7 @@ int rtl_pci_probe(struct pci_dev *pdev,
 		err = -ENODEV;
 		goto fail3;
 	}
-	rtlpriv->cfg->ops->init_sw_leds(hw);
+	rtl_init_sw_leds(hw);
 
 	/*aspm */
 	rtl_pci_init_aspm(hw);
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/hw.c
index de61c9c0ddec..58b1a46066b5 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/hw.c
@@ -803,17 +803,17 @@ static void _rtl88ee_gen_refresh_led_state(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
-	struct rtl_led *pled0 = &rtlpriv->ledctl.sw_led0;
+	enum rtl_led_pin pin0 = rtlpriv->ledctl.sw_led0;
 
 	if (rtlpriv->rtlhal.up_first_time)
 		return;
 
 	if (ppsc->rfoff_reason == RF_CHANGE_BY_IPS)
-		rtl88ee_sw_led_on(hw, pled0);
+		rtl88ee_sw_led_on(hw, pin0);
 	else if (ppsc->rfoff_reason == RF_CHANGE_BY_INIT)
-		rtl88ee_sw_led_on(hw, pled0);
+		rtl88ee_sw_led_on(hw, pin0);
 	else
-		rtl88ee_sw_led_off(hw, pled0);
+		rtl88ee_sw_led_off(hw, pin0);
 }
 
 static bool _rtl88ee_init_mac(struct ieee80211_hw *hw)
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/led.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/led.c
index 006b979da1c6..61f1709b30aa 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/led.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/led.c
@@ -6,23 +6,15 @@
 #include "reg.h"
 #include "led.h"
 
-static void _rtl88ee_init_led(struct ieee80211_hw *hw,
-			      struct rtl_led *pled, enum rtl_led_pin ledpin)
-{
-	pled->hw = hw;
-	pled->ledpin = ledpin;
-	pled->ledon = false;
-}
-
-void rtl88ee_sw_led_on(struct ieee80211_hw *hw, struct rtl_led *pled)
+void rtl88ee_sw_led_on(struct ieee80211_hw *hw, enum rtl_led_pin pin)
 {
 	u8 ledcfg;
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
 	rtl_dbg(rtlpriv, COMP_LED, DBG_LOUD,
-		"LedAddr:%X ledpin=%d\n", REG_LEDCFG2, pled->ledpin);
+		"LedAddr:%X ledpin=%d\n", REG_LEDCFG2, pin);
 
-	switch (pled->ledpin) {
+	switch (pin) {
 	case LED_PIN_GPIO0:
 		break;
 	case LED_PIN_LED0:
@@ -36,21 +28,20 @@ void rtl88ee_sw_led_on(struct ieee80211_hw *hw, struct rtl_led *pled)
 		break;
 	default:
 		rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
-			"switch case %#x not processed\n", pled->ledpin);
+			"unknown LED pin %d\n", pin);
 		break;
 	}
-	pled->ledon = true;
 }
 
-void rtl88ee_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled)
+void rtl88ee_sw_led_off(struct ieee80211_hw *hw, enum rtl_led_pin pin)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u8 ledcfg;
 
 	rtl_dbg(rtlpriv, COMP_LED, DBG_LOUD,
-		"LedAddr:%X ledpin=%d\n", REG_LEDCFG2, pled->ledpin);
+		"LedAddr:%X ledpin=%d\n", REG_LEDCFG2, pin);
 
-	switch (pled->ledpin) {
+	switch (pin) {
 	case LED_PIN_GPIO0:
 		break;
 	case LED_PIN_LED0:
@@ -73,34 +64,25 @@ void rtl88ee_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled)
 		break;
 	default:
 		rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
-			"switch case %#x not processed\n", pled->ledpin);
+			"unknown LED pin %d\n", pin);
 		break;
 	}
-	pled->ledon = false;
-}
-
-void rtl88ee_init_sw_leds(struct ieee80211_hw *hw)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-
-	_rtl88ee_init_led(hw, &rtlpriv->ledctl.sw_led0, LED_PIN_LED0);
-	_rtl88ee_init_led(hw, &rtlpriv->ledctl.sw_led1, LED_PIN_LED1);
 }
 
 static void _rtl88ee_sw_led_control(struct ieee80211_hw *hw,
 				    enum led_ctl_mode ledaction)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_led *pled0 = &rtlpriv->ledctl.sw_led0;
+	enum rtl_led_pin pin0 = rtlpriv->ledctl.sw_led0;
 
 	switch (ledaction) {
 	case LED_CTL_POWER_ON:
 	case LED_CTL_LINK:
 	case LED_CTL_NO_LINK:
-		rtl88ee_sw_led_on(hw, pled0);
+		rtl88ee_sw_led_on(hw, pin0);
 		break;
 	case LED_CTL_POWER_OFF:
-		rtl88ee_sw_led_off(hw, pled0);
+		rtl88ee_sw_led_off(hw, pin0);
 		break;
 	default:
 		break;
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/led.h b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/led.h
index 67d3dc389ba0..e5cc35d4c298 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/led.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/led.h
@@ -4,9 +4,8 @@
 #ifndef __RTL92CE_LED_H__
 #define __RTL92CE_LED_H__
 
-void rtl88ee_init_sw_leds(struct ieee80211_hw *hw);
-void rtl88ee_sw_led_on(struct ieee80211_hw *hw, struct rtl_led *pled);
-void rtl88ee_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled);
+void rtl88ee_sw_led_on(struct ieee80211_hw *hw, enum rtl_led_pin pin);
+void rtl88ee_sw_led_off(struct ieee80211_hw *hw, enum rtl_led_pin pin);
 void rtl88ee_led_control(struct ieee80211_hw *hw, enum led_ctl_mode ledaction);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/sw.c
index 02b77521b5cd..b77937fe2448 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/sw.c
@@ -230,7 +230,6 @@ static struct rtl_hal_ops rtl8188ee_hal_ops = {
 	.tx_polling = rtl88ee_tx_polling,
 	.enable_hw_sec = rtl88ee_enable_hw_security_config,
 	.set_key = rtl88ee_set_key,
-	.init_sw_leds = rtl88ee_init_sw_leds,
 	.get_bbreg = rtl88e_phy_query_bb_reg,
 	.set_bbreg = rtl88e_phy_set_bb_reg,
 	.get_rfreg = rtl88e_phy_query_rf_reg,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/hw.c
index dc480323c9cb..049c4fe9eeed 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/hw.c
@@ -639,17 +639,17 @@ static void _rtl92ce_gen_refresh_led_state(struct ieee80211_hw *hw)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
-	struct rtl_led *pled0 = &rtlpriv->ledctl.sw_led0;
+	enum rtl_led_pin pin0 = rtlpriv->ledctl.sw_led0;
 
 	if (rtlpci->up_first_time)
 		return;
 
 	if (ppsc->rfoff_reason == RF_CHANGE_BY_IPS)
-		rtl92ce_sw_led_on(hw, pled0);
+		rtl92ce_sw_led_on(hw, pin0);
 	else if (ppsc->rfoff_reason == RF_CHANGE_BY_INIT)
-		rtl92ce_sw_led_on(hw, pled0);
+		rtl92ce_sw_led_on(hw, pin0);
 	else
-		rtl92ce_sw_led_off(hw, pled0);
+		rtl92ce_sw_led_off(hw, pin0);
 }
 
 static bool _rtl92ce_init_mac(struct ieee80211_hw *hw)
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/led.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/led.c
index 57132278eb5c..e9c1abd662f7 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/led.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/led.c
@@ -6,25 +6,17 @@
 #include "reg.h"
 #include "led.h"
 
-static void _rtl92ce_init_led(struct ieee80211_hw *hw,
-			      struct rtl_led *pled, enum rtl_led_pin ledpin)
-{
-	pled->hw = hw;
-	pled->ledpin = ledpin;
-	pled->ledon = false;
-}
-
-void rtl92ce_sw_led_on(struct ieee80211_hw *hw, struct rtl_led *pled)
+void rtl92ce_sw_led_on(struct ieee80211_hw *hw, enum rtl_led_pin pin)
 {
 	u8 ledcfg;
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
 	rtl_dbg(rtlpriv, COMP_LED, DBG_LOUD, "LedAddr:%X ledpin=%d\n",
-		REG_LEDCFG2, pled->ledpin);
+		REG_LEDCFG2, pin);
 
 	ledcfg = rtl_read_byte(rtlpriv, REG_LEDCFG2);
 
-	switch (pled->ledpin) {
+	switch (pin) {
 	case LED_PIN_GPIO0:
 		break;
 	case LED_PIN_LED0:
@@ -35,24 +27,23 @@ void rtl92ce_sw_led_on(struct ieee80211_hw *hw, struct rtl_led *pled)
 		rtl_write_byte(rtlpriv, REG_LEDCFG2, (ledcfg & 0x0f) | BIT(5));
 		break;
 	default:
-		pr_err("switch case %#x not processed\n",
-		       pled->ledpin);
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
+			"unknown LED pin %d\n", pin);
 		break;
 	}
-	pled->ledon = true;
 }
 
-void rtl92ce_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled)
+void rtl92ce_sw_led_off(struct ieee80211_hw *hw, enum rtl_led_pin pin)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u8 ledcfg;
 
 	rtl_dbg(rtlpriv, COMP_LED, DBG_LOUD, "LedAddr:%X ledpin=%d\n",
-		REG_LEDCFG2, pled->ledpin);
+		REG_LEDCFG2, pin);
 
 	ledcfg = rtl_read_byte(rtlpriv, REG_LEDCFG2);
 
-	switch (pled->ledpin) {
+	switch (pin) {
 	case LED_PIN_GPIO0:
 		break;
 	case LED_PIN_LED0:
@@ -69,34 +60,26 @@ void rtl92ce_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled)
 		rtl_write_byte(rtlpriv, REG_LEDCFG2, (ledcfg | BIT(3)));
 		break;
 	default:
-		pr_info("switch case %#x not processed\n", pled->ledpin);
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
+			"unknown LED pin %d\n", pin);
 		break;
 	}
-	pled->ledon = false;
-}
-
-void rtl92ce_init_sw_leds(struct ieee80211_hw *hw)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-
-	_rtl92ce_init_led(hw, &rtlpriv->ledctl.sw_led0, LED_PIN_LED0);
-	_rtl92ce_init_led(hw, &rtlpriv->ledctl.sw_led1, LED_PIN_LED1);
 }
 
 static void _rtl92ce_sw_led_control(struct ieee80211_hw *hw,
 				    enum led_ctl_mode ledaction)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_led *pled0 = &rtlpriv->ledctl.sw_led0;
+	enum rtl_led_pin pin0 = rtlpriv->ledctl.sw_led0;
 
 	switch (ledaction) {
 	case LED_CTL_POWER_ON:
 	case LED_CTL_LINK:
 	case LED_CTL_NO_LINK:
-		rtl92ce_sw_led_on(hw, pled0);
+		rtl92ce_sw_led_on(hw, pin0);
 		break;
 	case LED_CTL_POWER_OFF:
-		rtl92ce_sw_led_off(hw, pled0);
+		rtl92ce_sw_led_off(hw, pin0);
 		break;
 	default:
 		break;
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/led.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/led.h
index 97ab1e00af5f..66dc28d62003 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/led.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/led.h
@@ -4,9 +4,8 @@
 #ifndef __RTL92CE_LED_H__
 #define __RTL92CE_LED_H__
 
-void rtl92ce_init_sw_leds(struct ieee80211_hw *hw);
-void rtl92ce_sw_led_on(struct ieee80211_hw *hw, struct rtl_led *pled);
-void rtl92ce_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled);
+void rtl92ce_sw_led_on(struct ieee80211_hw *hw, enum rtl_led_pin pin);
+void rtl92ce_sw_led_off(struct ieee80211_hw *hw, enum rtl_led_pin pin);
 void rtl92ce_led_control(struct ieee80211_hw *hw, enum led_ctl_mode ledaction);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/sw.c
index ed68c850f9a2..e452275d8789 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/sw.c
@@ -207,7 +207,6 @@ static struct rtl_hal_ops rtl8192ce_hal_ops = {
 	.tx_polling = rtl92ce_tx_polling,
 	.enable_hw_sec = rtl92ce_enable_hw_security_config,
 	.set_key = rtl92ce_set_key,
-	.init_sw_leds = rtl92ce_init_sw_leds,
 	.get_bbreg = rtl92c_phy_query_bb_reg,
 	.set_bbreg = rtl92c_phy_set_bb_reg,
 	.set_rfreg = rtl92ce_phy_set_rf_reg,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/led.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/led.c
index 1488f52a2d2f..b429b2ef78c5 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/led.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/led.c
@@ -6,27 +6,15 @@
 #include "reg.h"
 #include "led.h"
 
-static void _rtl92cu_init_led(struct ieee80211_hw *hw,
-			      struct rtl_led *pled, enum rtl_led_pin ledpin)
-{
-	pled->hw = hw;
-	pled->ledpin = ledpin;
-	pled->ledon = false;
-}
-
-static void rtl92cu_deinit_led(struct rtl_led *pled)
-{
-}
-
-void rtl92cu_sw_led_on(struct ieee80211_hw *hw, struct rtl_led *pled)
+void rtl92cu_sw_led_on(struct ieee80211_hw *hw, enum rtl_led_pin pin)
 {
 	u8 ledcfg;
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
 	rtl_dbg(rtlpriv, COMP_LED, DBG_LOUD, "LedAddr:%X ledpin=%d\n",
-		REG_LEDCFG2, pled->ledpin);
+		REG_LEDCFG2, pin);
 	ledcfg = rtl_read_byte(rtlpriv, REG_LEDCFG2);
-	switch (pled->ledpin) {
+	switch (pin) {
 	case LED_PIN_GPIO0:
 		break;
 	case LED_PIN_LED0:
@@ -37,22 +25,21 @@ void rtl92cu_sw_led_on(struct ieee80211_hw *hw, struct rtl_led *pled)
 		rtl_write_byte(rtlpriv, REG_LEDCFG2, (ledcfg & 0x0f) | BIT(5));
 		break;
 	default:
-		pr_err("switch case %#x not processed\n",
-		       pled->ledpin);
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
+			"unknown LED pin %d\n", pin);
 		break;
 	}
-	pled->ledon = true;
 }
 
-void rtl92cu_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled)
+void rtl92cu_sw_led_off(struct ieee80211_hw *hw, enum rtl_led_pin pin)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u8 ledcfg;
 
 	rtl_dbg(rtlpriv, COMP_LED, DBG_LOUD, "LedAddr:%X ledpin=%d\n",
-		REG_LEDCFG2, pled->ledpin);
+		REG_LEDCFG2, pin);
 	ledcfg = rtl_read_byte(rtlpriv, REG_LEDCFG2);
-	switch (pled->ledpin) {
+	switch (pin) {
 	case LED_PIN_GPIO0:
 		break;
 	case LED_PIN_LED0:
@@ -69,36 +56,14 @@ void rtl92cu_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled)
 		rtl_write_byte(rtlpriv, REG_LEDCFG2, (ledcfg | BIT(3)));
 		break;
 	default:
-		pr_err("switch case %#x not processed\n",
-		       pled->ledpin);
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
+			"unknown LED pin %d\n", pin);
 		break;
 	}
-	pled->ledon = false;
-}
-
-void rtl92cu_init_sw_leds(struct ieee80211_hw *hw)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-
-	_rtl92cu_init_led(hw, &rtlpriv->ledctl.sw_led0, LED_PIN_LED0);
-	_rtl92cu_init_led(hw, &rtlpriv->ledctl.sw_led1, LED_PIN_LED1);
-}
-
-void rtl92cu_deinit_sw_leds(struct ieee80211_hw *hw)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-
-	rtl92cu_deinit_led(&rtlpriv->ledctl.sw_led0);
-	rtl92cu_deinit_led(&rtlpriv->ledctl.sw_led1);
-}
-
-static void _rtl92cu_sw_led_control(struct ieee80211_hw *hw,
-				    enum led_ctl_mode ledaction)
-{
 }
 
 void rtl92cu_led_control(struct ieee80211_hw *hw,
-			enum led_ctl_mode ledaction)
+			 enum led_ctl_mode ledaction)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
@@ -114,5 +79,4 @@ void rtl92cu_led_control(struct ieee80211_hw *hw,
 		return;
 	}
 	rtl_dbg(rtlpriv, COMP_LED, DBG_LOUD, "ledaction %d\n", ledaction);
-	_rtl92cu_sw_led_control(hw, ledaction);
 }
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/led.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/led.h
index 3fc1e7c8f78b..8175f8bddd6d 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/led.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/led.h
@@ -4,10 +4,8 @@
 #ifndef __RTL92CU_LED_H__
 #define __RTL92CU_LED_H__
 
-void rtl92cu_init_sw_leds(struct ieee80211_hw *hw);
-void rtl92cu_deinit_sw_leds(struct ieee80211_hw *hw);
-void rtl92cu_sw_led_on(struct ieee80211_hw *hw, struct rtl_led *pled);
-void rtl92cu_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled);
+void rtl92cu_sw_led_on(struct ieee80211_hw *hw, enum rtl_led_pin pin);
+void rtl92cu_sw_led_off(struct ieee80211_hw *hw, enum rtl_led_pin pin);
 void rtl92cu_led_control(struct ieee80211_hw *hw, enum led_ctl_mode ledaction);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c
index 876c14d46c2f..e6403d4c937c 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c
@@ -115,8 +115,6 @@ static struct rtl_hal_ops rtl8192cu_hal_ops = {
 	.led_control = rtl92cu_led_control,
 	.enable_hw_sec = rtl92cu_enable_hw_security_config,
 	.set_key = rtl92c_set_key,
-	.init_sw_leds = rtl92cu_init_sw_leds,
-	.deinit_sw_leds = rtl92cu_deinit_sw_leds,
 	.get_bbreg = rtl92c_phy_query_bb_reg,
 	.set_bbreg = rtl92c_phy_set_bb_reg,
 	.get_rfreg = rtl92cu_phy_query_rf_reg,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.c
index df1e36fbc348..31a18bbface9 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.c
@@ -595,16 +595,16 @@ static void _rtl92de_gen_refresh_led_state(struct ieee80211_hw *hw)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
-	struct rtl_led *pled0 = &rtlpriv->ledctl.sw_led0;
+	enum rtl_led_pin pin0 = rtlpriv->ledctl.sw_led0;
 
 	if (rtlpci->up_first_time)
 		return;
 	if (ppsc->rfoff_reason == RF_CHANGE_BY_IPS)
-		rtl92de_sw_led_on(hw, pled0);
+		rtl92de_sw_led_on(hw, pin0);
 	else if (ppsc->rfoff_reason == RF_CHANGE_BY_INIT)
-		rtl92de_sw_led_on(hw, pled0);
+		rtl92de_sw_led_on(hw, pin0);
 	else
-		rtl92de_sw_led_off(hw, pled0);
+		rtl92de_sw_led_off(hw, pin0);
 }
 
 static bool _rtl92de_init_mac(struct ieee80211_hw *hw)
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/led.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/led.c
index 93d1c6a610c3..1b57f51ce0dd 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/led.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/led.c
@@ -6,23 +6,15 @@
 #include "reg.h"
 #include "led.h"
 
-static void _rtl92ce_init_led(struct ieee80211_hw *hw,
-			      struct rtl_led *pled, enum rtl_led_pin ledpin)
-{
-	pled->hw = hw;
-	pled->ledpin = ledpin;
-	pled->ledon = false;
-}
-
-void rtl92de_sw_led_on(struct ieee80211_hw *hw, struct rtl_led *pled)
+void rtl92de_sw_led_on(struct ieee80211_hw *hw, enum rtl_led_pin pin)
 {
 	u8 ledcfg;
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
 	rtl_dbg(rtlpriv, COMP_LED, DBG_LOUD, "LedAddr:%X ledpin=%d\n",
-		REG_LEDCFG2, pled->ledpin);
+		REG_LEDCFG2, pin);
 
-	switch (pled->ledpin) {
+	switch (pin) {
 	case LED_PIN_GPIO0:
 		break;
 	case LED_PIN_LED0:
@@ -44,24 +36,23 @@ void rtl92de_sw_led_on(struct ieee80211_hw *hw, struct rtl_led *pled)
 		rtl_write_byte(rtlpriv, REG_LEDCFG2, (ledcfg & 0x0f) | BIT(5));
 		break;
 	default:
-		pr_err("switch case %#x not processed\n",
-		       pled->ledpin);
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
+			"unknown LED pin %d\n", pin);
 		break;
 	}
-	pled->ledon = true;
 }
 
-void rtl92de_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled)
+void rtl92de_sw_led_off(struct ieee80211_hw *hw, enum rtl_led_pin pin)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u8 ledcfg;
 
 	rtl_dbg(rtlpriv, COMP_LED, DBG_LOUD, "LedAddr:%X ledpin=%d\n",
-		REG_LEDCFG2, pled->ledpin);
+		REG_LEDCFG2, pin);
 
 	ledcfg = rtl_read_byte(rtlpriv, REG_LEDCFG2);
 
-	switch (pled->ledpin) {
+	switch (pin) {
 	case LED_PIN_GPIO0:
 		break;
 	case LED_PIN_LED0:
@@ -78,35 +69,26 @@ void rtl92de_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled)
 		rtl_write_byte(rtlpriv, REG_LEDCFG2, (ledcfg | BIT(3)));
 		break;
 	default:
-		pr_err("switch case %#x not processed\n",
-		       pled->ledpin);
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
+			"unknown LED pin %d\n", pin);
 		break;
 	}
-	pled->ledon = false;
-}
-
-void rtl92de_init_sw_leds(struct ieee80211_hw *hw)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-
-	_rtl92ce_init_led(hw, &rtlpriv->ledctl.sw_led0, LED_PIN_LED0);
-	_rtl92ce_init_led(hw, &rtlpriv->ledctl.sw_led1, LED_PIN_LED1);
 }
 
 static void _rtl92ce_sw_led_control(struct ieee80211_hw *hw,
 				    enum led_ctl_mode ledaction)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_led *pled0 = &rtlpriv->ledctl.sw_led0;
+	enum rtl_led_pin pin0 = rtlpriv->ledctl.sw_led0;
 
 	switch (ledaction) {
 	case LED_CTL_POWER_ON:
 	case LED_CTL_LINK:
 	case LED_CTL_NO_LINK:
-		rtl92de_sw_led_on(hw, pled0);
+		rtl92de_sw_led_on(hw, pin0);
 		break;
 	case LED_CTL_POWER_OFF:
-		rtl92de_sw_led_off(hw, pled0);
+		rtl92de_sw_led_off(hw, pin0);
 		break;
 	default:
 		break;
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/led.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/led.h
index 7599c7e5ecc3..33e544ad6f99 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/led.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/led.h
@@ -4,9 +4,8 @@
 #ifndef __RTL92CE_LED_H__
 #define __RTL92CE_LED_H__
 
-void rtl92de_init_sw_leds(struct ieee80211_hw *hw);
-void rtl92de_sw_led_on(struct ieee80211_hw *hw, struct rtl_led *pled);
-void rtl92de_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled);
+void rtl92de_sw_led_on(struct ieee80211_hw *hw, enum rtl_led_pin pin);
+void rtl92de_sw_led_off(struct ieee80211_hw *hw, enum rtl_led_pin pin);
 void rtl92de_led_control(struct ieee80211_hw *hw, enum led_ctl_mode ledaction);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/sw.c
index a74724c971b9..11f319c97124 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/sw.c
@@ -220,7 +220,6 @@ static struct rtl_hal_ops rtl8192de_hal_ops = {
 	.tx_polling = rtl92de_tx_polling,
 	.enable_hw_sec = rtl92de_enable_hw_security_config,
 	.set_key = rtl92de_set_key,
-	.init_sw_leds = rtl92de_init_sw_leds,
 	.get_bbreg = rtl92d_phy_query_bb_reg,
 	.set_bbreg = rtl92d_phy_set_bb_reg,
 	.get_rfreg = rtl92d_phy_query_rf_reg,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/hw.c
index 47d8999e31c0..ebb7abd0c9ad 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/hw.c
@@ -714,17 +714,17 @@ static void _rtl92ee_gen_refresh_led_state(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
-	struct rtl_led *pled0 = &rtlpriv->ledctl.sw_led0;
+	enum rtl_led_pin pin0 = rtlpriv->ledctl.sw_led0;
 
 	if (rtlpriv->rtlhal.up_first_time)
 		return;
 
 	if (ppsc->rfoff_reason == RF_CHANGE_BY_IPS)
-		rtl92ee_sw_led_on(hw, pled0);
+		rtl92ee_sw_led_on(hw, pin0);
 	else if (ppsc->rfoff_reason == RF_CHANGE_BY_INIT)
-		rtl92ee_sw_led_on(hw, pled0);
+		rtl92ee_sw_led_on(hw, pin0);
 	else
-		rtl92ee_sw_led_off(hw, pled0);
+		rtl92ee_sw_led_off(hw, pin0);
 }
 
 static bool _rtl92ee_init_mac(struct ieee80211_hw *hw)
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/led.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/led.c
index fb4ea3a8481f..e8800f62dc1b 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/led.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/led.c
@@ -6,23 +6,15 @@
 #include "reg.h"
 #include "led.h"
 
-static void _rtl92ee_init_led(struct ieee80211_hw *hw,
-			      struct rtl_led *pled, enum rtl_led_pin ledpin)
-{
-	pled->hw = hw;
-	pled->ledpin = ledpin;
-	pled->ledon = false;
-}
-
-void rtl92ee_sw_led_on(struct ieee80211_hw *hw, struct rtl_led *pled)
+void rtl92ee_sw_led_on(struct ieee80211_hw *hw, enum rtl_led_pin pin)
 {
 	u32 ledcfg;
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
 	rtl_dbg(rtlpriv, COMP_LED, DBG_LOUD,
-		"LedAddr:%X ledpin=%d\n", REG_LEDCFG2, pled->ledpin);
+		"LedAddr:%X ledpin=%d\n", REG_LEDCFG2, pin);
 
-	switch (pled->ledpin) {
+	switch (pin) {
 	case LED_PIN_GPIO0:
 		break;
 	case LED_PIN_LED0:
@@ -39,21 +31,20 @@ void rtl92ee_sw_led_on(struct ieee80211_hw *hw, struct rtl_led *pled)
 		break;
 	default:
 		rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
-			"switch case %#x not processed\n", pled->ledpin);
+			"unknown LED pin %d\n", pin);
 		break;
 	}
-	pled->ledon = true;
 }
 
-void rtl92ee_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled)
+void rtl92ee_sw_led_off(struct ieee80211_hw *hw, enum rtl_led_pin pin)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u32 ledcfg;
 
 	rtl_dbg(rtlpriv, COMP_LED, DBG_LOUD,
-		"LedAddr:%X ledpin=%d\n", REG_LEDCFG2, pled->ledpin);
+		"LedAddr:%X ledpin=%d\n", REG_LEDCFG2, pin);
 
-	switch (pled->ledpin) {
+	switch (pin) {
 	case LED_PIN_GPIO0:
 		break;
 	case LED_PIN_LED0:
@@ -69,34 +60,25 @@ void rtl92ee_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled)
 		break;
 	default:
 		rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
-			"switch case %#x not processed\n", pled->ledpin);
+			"unknown LED pin %d\n", pin);
 		break;
 	}
-	pled->ledon = false;
-}
-
-void rtl92ee_init_sw_leds(struct ieee80211_hw *hw)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-
-	_rtl92ee_init_led(hw, &rtlpriv->ledctl.sw_led0, LED_PIN_LED0);
-	_rtl92ee_init_led(hw, &rtlpriv->ledctl.sw_led1, LED_PIN_LED1);
 }
 
 static void _rtl92ee_sw_led_control(struct ieee80211_hw *hw,
 				    enum led_ctl_mode ledaction)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_led *pled0 = &rtlpriv->ledctl.sw_led0;
+	enum rtl_led_pin pin0 = rtlpriv->ledctl.sw_led0;
 
 	switch (ledaction) {
 	case LED_CTL_POWER_ON:
 	case LED_CTL_LINK:
 	case LED_CTL_NO_LINK:
-		rtl92ee_sw_led_on(hw, pled0);
+		rtl92ee_sw_led_on(hw, pin0);
 		break;
 	case LED_CTL_POWER_OFF:
-		rtl92ee_sw_led_off(hw, pled0);
+		rtl92ee_sw_led_off(hw, pin0);
 		break;
 	default:
 		break;
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/led.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/led.h
index 6d775e14846f..08b8ff328b63 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/led.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/led.h
@@ -4,9 +4,8 @@
 #ifndef __RTL92E_LED_H__
 #define __RTL92E_LED_H__
 
-void rtl92ee_init_sw_leds(struct ieee80211_hw *hw);
-void rtl92ee_sw_led_on(struct ieee80211_hw *hw, struct rtl_led *pled);
-void rtl92ee_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled);
+void rtl92ee_sw_led_on(struct ieee80211_hw *hw, enum rtl_led_pin pin);
+void rtl92ee_sw_led_off(struct ieee80211_hw *hw, enum rtl_led_pin pin);
 void rtl92ee_led_control(struct ieee80211_hw *hw, enum led_ctl_mode ledaction);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/sw.c
index 7a16563b3a5d..616a47d8d97a 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/sw.c
@@ -220,7 +220,6 @@ static struct rtl_hal_ops rtl8192ee_hal_ops = {
 	.tx_polling = rtl92ee_tx_polling,
 	.enable_hw_sec = rtl92ee_enable_hw_security_config,
 	.set_key = rtl92ee_set_key,
-	.init_sw_leds = rtl92ee_init_sw_leds,
 	.get_bbreg = rtl92ee_phy_query_bb_reg,
 	.set_bbreg = rtl92ee_phy_set_bb_reg,
 	.get_rfreg = rtl92ee_phy_query_rf_reg,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/hw.c
index 4ae8f69c64f9..e5775b94f04e 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/hw.c
@@ -731,12 +731,12 @@ static void _rtl92se_macconfig_before_fwdownload(struct ieee80211_hw *hw)
 	/* After MACIO reset,we must refresh LED state. */
 	if ((ppsc->rfoff_reason == RF_CHANGE_BY_IPS) ||
 	   (ppsc->rfoff_reason == 0)) {
-		struct rtl_led *pled0 = &rtlpriv->ledctl.sw_led0;
+		enum rtl_led_pin pin0 = rtlpriv->ledctl.sw_led0;
 		enum rf_pwrstate rfpwr_state_toset;
 		rfpwr_state_toset = _rtl92se_rf_onoff_detect(hw);
 
 		if (rfpwr_state_toset == ERFON)
-			rtl92se_sw_led_on(hw, pled0);
+			rtl92se_sw_led_on(hw, pin0);
 	}
 }
 
@@ -1371,15 +1371,15 @@ static void _rtl92se_gen_refreshledstate(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
-	struct rtl_led *pled0 = &rtlpriv->ledctl.sw_led0;
+	enum rtl_led_pin pin0 = rtlpriv->ledctl.sw_led0;
 
 	if (rtlpci->up_first_time)
 		return;
 
 	if (rtlpriv->psc.rfoff_reason == RF_CHANGE_BY_IPS)
-		rtl92se_sw_led_on(hw, pled0);
+		rtl92se_sw_led_on(hw, pin0);
 	else
-		rtl92se_sw_led_off(hw, pled0);
+		rtl92se_sw_led_off(hw, pin0);
 }
 
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/led.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/led.c
index ecbf425f679f..7378d7493586 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/led.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/led.c
@@ -6,33 +6,17 @@
 #include "reg.h"
 #include "led.h"
 
-static void _rtl92se_init_led(struct ieee80211_hw *hw,
-			      struct rtl_led *pled, enum rtl_led_pin ledpin)
-{
-	pled->hw = hw;
-	pled->ledpin = ledpin;
-	pled->ledon = false;
-}
-
-void rtl92se_init_sw_leds(struct ieee80211_hw *hw)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-
-	_rtl92se_init_led(hw, &rtlpriv->ledctl.sw_led0, LED_PIN_LED0);
-	_rtl92se_init_led(hw, &rtlpriv->ledctl.sw_led1, LED_PIN_LED1);
-}
-
-void rtl92se_sw_led_on(struct ieee80211_hw *hw, struct rtl_led *pled)
+void rtl92se_sw_led_on(struct ieee80211_hw *hw, enum rtl_led_pin pin)
 {
 	u8 ledcfg;
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
 	rtl_dbg(rtlpriv, COMP_LED, DBG_LOUD, "LedAddr:%X ledpin=%d\n",
-		LEDCFG, pled->ledpin);
+		LEDCFG, pin);
 
 	ledcfg = rtl_read_byte(rtlpriv, LEDCFG);
 
-	switch (pled->ledpin) {
+	switch (pin) {
 	case LED_PIN_GPIO0:
 		break;
 	case LED_PIN_LED0:
@@ -42,14 +26,13 @@ void rtl92se_sw_led_on(struct ieee80211_hw *hw, struct rtl_led *pled)
 		rtl_write_byte(rtlpriv, LEDCFG, ledcfg & 0x0f);
 		break;
 	default:
-		pr_err("switch case %#x not processed\n",
-		       pled->ledpin);
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
+			"unknown LED pin %d\n", pin);
 		break;
 	}
-	pled->ledon = true;
 }
 
-void rtl92se_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled)
+void rtl92se_sw_led_off(struct ieee80211_hw *hw, enum rtl_led_pin pin)
 {
 	struct rtl_priv *rtlpriv;
 	u8 ledcfg;
@@ -58,11 +41,11 @@ void rtl92se_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled)
 	if (!rtlpriv || rtlpriv->max_fw_size)
 		return;
 	rtl_dbg(rtlpriv, COMP_LED, DBG_LOUD, "LedAddr:%X ledpin=%d\n",
-		LEDCFG, pled->ledpin);
+		LEDCFG, pin);
 
 	ledcfg = rtl_read_byte(rtlpriv, LEDCFG);
 
-	switch (pled->ledpin) {
+	switch (pin) {
 	case LED_PIN_GPIO0:
 		break;
 	case LED_PIN_LED0:
@@ -77,27 +60,26 @@ void rtl92se_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled)
 		rtl_write_byte(rtlpriv, LEDCFG, (ledcfg | BIT(3)));
 		break;
 	default:
-		pr_err("switch case %#x not processed\n",
-		       pled->ledpin);
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
+			"unknown LED pin %d\n", pin);
 		break;
 	}
-	pled->ledon = false;
 }
 
 static void _rtl92se_sw_led_control(struct ieee80211_hw *hw,
 				    enum led_ctl_mode ledaction)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_led *pled0 = &rtlpriv->ledctl.sw_led0;
+	enum rtl_led_pin pin0 = rtlpriv->ledctl.sw_led0;
 
 	switch (ledaction) {
 	case LED_CTL_POWER_ON:
 	case LED_CTL_LINK:
 	case LED_CTL_NO_LINK:
-		rtl92se_sw_led_on(hw, pled0);
+		rtl92se_sw_led_on(hw, pin0);
 		break;
 	case LED_CTL_POWER_OFF:
-		rtl92se_sw_led_off(hw, pled0);
+		rtl92se_sw_led_off(hw, pin0);
 		break;
 	default:
 		break;
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/led.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/led.h
index c9e481a8d943..43fcc3c77bc1 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/led.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/led.h
@@ -4,9 +4,8 @@
 #ifndef __REALTEK_PCI92SE_LED_H__
 #define __REALTEK_PCI92SE_LED_H__
 
-void rtl92se_init_sw_leds(struct ieee80211_hw *hw);
-void rtl92se_sw_led_on(struct ieee80211_hw *hw,	struct rtl_led *pled);
-void rtl92se_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled);
+void rtl92se_sw_led_on(struct ieee80211_hw *hw, enum rtl_led_pin pin);
+void rtl92se_sw_led_off(struct ieee80211_hw *hw, enum rtl_led_pin pin);
 void rtl92se_led_control(struct ieee80211_hw *hw, enum led_ctl_mode ledaction);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c
index 6d352a3161b8..30bce381c3bb 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c
@@ -260,7 +260,6 @@ static struct rtl_hal_ops rtl8192se_hal_ops = {
 	.tx_polling = rtl92se_tx_polling,
 	.enable_hw_sec = rtl92se_enable_hw_security_config,
 	.set_key = rtl92se_set_key,
-	.init_sw_leds = rtl92se_init_sw_leds,
 	.get_bbreg = rtl92s_phy_query_bb_reg,
 	.set_bbreg = rtl92s_phy_set_bb_reg,
 	.get_rfreg = rtl92s_phy_query_rf_reg,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.c
index 965d98b9b09f..d26d4c4314a3 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.c
@@ -643,17 +643,17 @@ static void _rtl8723e_gen_refresh_led_state(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
-	struct rtl_led *pled0 = &rtlpriv->ledctl.sw_led0;
+	enum rtl_led_pin pin0 = rtlpriv->ledctl.sw_led0;
 
 	if (rtlpriv->rtlhal.up_first_time)
 		return;
 
 	if (ppsc->rfoff_reason == RF_CHANGE_BY_IPS)
-		rtl8723e_sw_led_on(hw, pled0);
+		rtl8723e_sw_led_on(hw, pin0);
 	else if (ppsc->rfoff_reason == RF_CHANGE_BY_INIT)
-		rtl8723e_sw_led_on(hw, pled0);
+		rtl8723e_sw_led_on(hw, pin0);
 	else
-		rtl8723e_sw_led_off(hw, pled0);
+		rtl8723e_sw_led_off(hw, pin0);
 }
 
 static bool _rtl8712e_init_mac(struct ieee80211_hw *hw)
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/led.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/led.c
index 7fab02e01a8c..b084f894ab93 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/led.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/led.c
@@ -6,23 +6,15 @@
 #include "reg.h"
 #include "led.h"
 
-static void _rtl8723e_init_led(struct ieee80211_hw *hw,
-			       struct rtl_led *pled, enum rtl_led_pin ledpin)
-{
-	pled->hw = hw;
-	pled->ledpin = ledpin;
-	pled->ledon = false;
-}
-
-void rtl8723e_sw_led_on(struct ieee80211_hw *hw, struct rtl_led *pled)
+void rtl8723e_sw_led_on(struct ieee80211_hw *hw, enum rtl_led_pin pin)
 {
 	u8 ledcfg;
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
 	rtl_dbg(rtlpriv, COMP_LED, DBG_LOUD,
-		"LedAddr:%X ledpin=%d\n", REG_LEDCFG2, pled->ledpin);
+		"LedAddr:%X ledpin=%d\n", REG_LEDCFG2, pin);
 
-	switch (pled->ledpin) {
+	switch (pin) {
 	case LED_PIN_GPIO0:
 		break;
 	case LED_PIN_LED0:
@@ -36,24 +28,23 @@ void rtl8723e_sw_led_on(struct ieee80211_hw *hw, struct rtl_led *pled)
 		rtl_write_byte(rtlpriv, REG_LEDCFG1, ledcfg & 0x10);
 		break;
 	default:
-		pr_err("switch case %#x not processed\n",
-		       pled->ledpin);
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
+			"unknown LED pin %d\n", pin);
 		break;
 	}
-	pled->ledon = true;
 }
 
-void rtl8723e_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled)
+void rtl8723e_sw_led_off(struct ieee80211_hw *hw, enum rtl_led_pin pin)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u8 ledcfg;
 
 	rtl_dbg(rtlpriv, COMP_LED, DBG_LOUD,
-		"LedAddr:%X ledpin=%d\n", REG_LEDCFG2, pled->ledpin);
+		"LedAddr:%X ledpin=%d\n", REG_LEDCFG2, pin);
 
 	ledcfg = rtl_read_byte(rtlpriv, REG_LEDCFG2);
 
-	switch (pled->ledpin) {
+	switch (pin) {
 	case LED_PIN_GPIO0:
 		break;
 	case LED_PIN_LED0:
@@ -77,35 +68,26 @@ void rtl8723e_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled)
 
 		break;
 	default:
-		pr_err("switch case %#x not processed\n",
-		       pled->ledpin);
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
+			"unknown LED pin %d\n", pin);
 		break;
 	}
-	pled->ledon = false;
-}
-
-void rtl8723e_init_sw_leds(struct ieee80211_hw *hw)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-
-	_rtl8723e_init_led(hw, &rtlpriv->ledctl.sw_led0, LED_PIN_LED0);
-	_rtl8723e_init_led(hw, &rtlpriv->ledctl.sw_led1, LED_PIN_LED1);
 }
 
 static void _rtl8723e_sw_led_control(struct ieee80211_hw *hw,
 				     enum led_ctl_mode ledaction)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_led *pled0 = &rtlpriv->ledctl.sw_led0;
+	enum rtl_led_pin pin0 = rtlpriv->ledctl.sw_led0;
 
 	switch (ledaction) {
 	case LED_CTL_POWER_ON:
 	case LED_CTL_LINK:
 	case LED_CTL_NO_LINK:
-		rtl8723e_sw_led_on(hw, pled0);
+		rtl8723e_sw_led_on(hw, pin0);
 		break;
 	case LED_CTL_POWER_OFF:
-		rtl8723e_sw_led_off(hw, pled0);
+		rtl8723e_sw_led_off(hw, pin0);
 		break;
 	default:
 		break;
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/led.h b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/led.h
index 9f85845d23cd..6db5290da806 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/led.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/led.h
@@ -4,9 +4,8 @@
 #ifndef __RTL92CE_LED_H__
 #define __RTL92CE_LED_H__
 
-void rtl8723e_init_sw_leds(struct ieee80211_hw *hw);
-void rtl8723e_sw_led_on(struct ieee80211_hw *hw, struct rtl_led *pled);
-void rtl8723e_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled);
+void rtl8723e_sw_led_on(struct ieee80211_hw *hw, enum rtl_led_pin pin);
+void rtl8723e_sw_led_off(struct ieee80211_hw *hw, enum rtl_led_pin pin);
 void rtl8723e_led_control(struct ieee80211_hw *hw, enum led_ctl_mode ledaction);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/sw.c
index 7828acb1de3f..c821436a1991 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/sw.c
@@ -223,7 +223,6 @@ static struct rtl_hal_ops rtl8723e_hal_ops = {
 	.tx_polling = rtl8723e_tx_polling,
 	.enable_hw_sec = rtl8723e_enable_hw_security_config,
 	.set_key = rtl8723e_set_key,
-	.init_sw_leds = rtl8723e_init_sw_leds,
 	.get_bbreg = rtl8723_phy_query_bb_reg,
 	.set_bbreg = rtl8723_phy_set_bb_reg,
 	.get_rfreg = rtl8723e_phy_query_rf_reg,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c
index 0ba3bbed6ed3..15575644551f 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c
@@ -793,17 +793,17 @@ static void _rtl8723be_gen_refresh_led_state(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
-	struct rtl_led *pled0 = &rtlpriv->ledctl.sw_led0;
+	enum rtl_led_pin pin0 = rtlpriv->ledctl.sw_led0;
 
 	if (rtlpriv->rtlhal.up_first_time)
 		return;
 
 	if (ppsc->rfoff_reason == RF_CHANGE_BY_IPS)
-		rtl8723be_sw_led_on(hw, pled0);
+		rtl8723be_sw_led_on(hw, pin0);
 	else if (ppsc->rfoff_reason == RF_CHANGE_BY_INIT)
-		rtl8723be_sw_led_on(hw, pled0);
+		rtl8723be_sw_led_on(hw, pin0);
 	else
-		rtl8723be_sw_led_off(hw, pled0);
+		rtl8723be_sw_led_off(hw, pin0);
 }
 
 static bool _rtl8723be_init_mac(struct ieee80211_hw *hw)
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/led.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/led.c
index 3954624ab314..ba20cb7509a9 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/led.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/led.c
@@ -6,23 +6,15 @@
 #include "reg.h"
 #include "led.h"
 
-static void _rtl8723be_init_led(struct ieee80211_hw *hw,  struct rtl_led *pled,
-				enum rtl_led_pin ledpin)
-{
-	pled->hw = hw;
-	pled->ledpin = ledpin;
-	pled->ledon = false;
-}
-
-void rtl8723be_sw_led_on(struct ieee80211_hw *hw, struct rtl_led *pled)
+void rtl8723be_sw_led_on(struct ieee80211_hw *hw, enum rtl_led_pin pin)
 {
 	u8 ledcfg;
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
 	rtl_dbg(rtlpriv, COMP_LED, DBG_LOUD,
-		"LedAddr:%X ledpin=%d\n", REG_LEDCFG2, pled->ledpin);
+		"LedAddr:%X ledpin=%d\n", REG_LEDCFG2, pin);
 
-	switch (pled->ledpin) {
+	switch (pin) {
 	case LED_PIN_GPIO0:
 		break;
 	case LED_PIN_LED0:
@@ -35,24 +27,23 @@ void rtl8723be_sw_led_on(struct ieee80211_hw *hw, struct rtl_led *pled)
 		rtl_write_byte(rtlpriv, REG_LEDCFG1, ledcfg & 0x10);
 		break;
 	default:
-		pr_err("switch case %#x not processed\n",
-		       pled->ledpin);
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
+			"unknown LED pin %d\n", pin);
 		break;
 	}
-	pled->ledon = true;
 }
 
-void rtl8723be_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled)
+void rtl8723be_sw_led_off(struct ieee80211_hw *hw, enum rtl_led_pin pin)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u8 ledcfg;
 
 	rtl_dbg(rtlpriv, COMP_LED, DBG_LOUD,
-		"LedAddr:%X ledpin=%d\n", REG_LEDCFG2, pled->ledpin);
+		"LedAddr:%X ledpin=%d\n", REG_LEDCFG2, pin);
 
 	ledcfg = rtl_read_byte(rtlpriv, REG_LEDCFG2);
 
-	switch (pled->ledpin) {
+	switch (pin) {
 	case LED_PIN_GPIO0:
 		break;
 	case LED_PIN_LED0:
@@ -76,35 +67,26 @@ void rtl8723be_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled)
 
 		break;
 	default:
-		pr_err("switch case %#x not processed\n",
-		       pled->ledpin);
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
+			"unknown LED pin %d\n", pin);
 		break;
 	}
-	pled->ledon = false;
-}
-
-void rtl8723be_init_sw_leds(struct ieee80211_hw *hw)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-
-	_rtl8723be_init_led(hw, &rtlpriv->ledctl.sw_led0, LED_PIN_LED0);
-	_rtl8723be_init_led(hw, &rtlpriv->ledctl.sw_led1, LED_PIN_LED1);
 }
 
 static void _rtl8723be_sw_led_control(struct ieee80211_hw *hw,
 				      enum led_ctl_mode ledaction)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_led *pled0 = &rtlpriv->ledctl.sw_led0;
+	enum rtl_led_pin pin0 = rtlpriv->ledctl.sw_led0;
 
 	switch (ledaction) {
 	case LED_CTL_POWER_ON:
 	case LED_CTL_LINK:
 	case LED_CTL_NO_LINK:
-		rtl8723be_sw_led_on(hw, pled0);
+		rtl8723be_sw_led_on(hw, pin0);
 		break;
 	case LED_CTL_POWER_OFF:
-		rtl8723be_sw_led_off(hw, pled0);
+		rtl8723be_sw_led_off(hw, pin0);
 		break;
 	default:
 		break;
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/led.h b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/led.h
index 8ac59374b632..3ca9277152f7 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/led.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/led.h
@@ -4,9 +4,8 @@
 #ifndef __RTL8723BE_LED_H__
 #define __RTL8723BE_LED_H__
 
-void rtl8723be_init_sw_leds(struct ieee80211_hw *hw);
-void rtl8723be_sw_led_on(struct ieee80211_hw *hw, struct rtl_led *pled);
-void rtl8723be_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled);
+void rtl8723be_sw_led_on(struct ieee80211_hw *hw, enum rtl_led_pin pin);
+void rtl8723be_sw_led_off(struct ieee80211_hw *hw, enum rtl_led_pin pin);
 void rtl8723be_led_control(struct ieee80211_hw *hw,
 			   enum led_ctl_mode ledaction);
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
index d220e8955e37..43b611d5288d 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
@@ -227,7 +227,6 @@ static struct rtl_hal_ops rtl8723be_hal_ops = {
 	.tx_polling = rtl8723be_tx_polling,
 	.enable_hw_sec = rtl8723be_enable_hw_security_config,
 	.set_key = rtl8723be_set_key,
-	.init_sw_leds = rtl8723be_init_sw_leds,
 	.get_bbreg = rtl8723_phy_query_bb_reg,
 	.set_bbreg = rtl8723_phy_set_bb_reg,
 	.get_rfreg = rtl8723be_phy_query_rf_reg,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
index a7e3250957dc..3f8f6da33b12 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
@@ -869,7 +869,7 @@ static void _rtl8821ae_gen_refresh_led_state(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
-	struct rtl_led *pled0 = &rtlpriv->ledctl.sw_led0;
+	enum rtl_led_pin pin0 = rtlpriv->ledctl.sw_led0;
 	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
 
 	if (rtlpriv->rtlhal.up_first_time)
@@ -877,19 +877,19 @@ static void _rtl8821ae_gen_refresh_led_state(struct ieee80211_hw *hw)
 
 	if (ppsc->rfoff_reason == RF_CHANGE_BY_IPS)
 		if (rtlhal->hw_type == HARDWARE_TYPE_RTL8812AE)
-			rtl8812ae_sw_led_on(hw, pled0);
+			rtl8812ae_sw_led_on(hw, pin0);
 		else
-			rtl8821ae_sw_led_on(hw, pled0);
+			rtl8821ae_sw_led_on(hw, pin0);
 	else if (ppsc->rfoff_reason == RF_CHANGE_BY_INIT)
 		if (rtlhal->hw_type == HARDWARE_TYPE_RTL8812AE)
-			rtl8812ae_sw_led_on(hw, pled0);
+			rtl8812ae_sw_led_on(hw, pin0);
 		else
-			rtl8821ae_sw_led_on(hw, pled0);
+			rtl8821ae_sw_led_on(hw, pin0);
 	else
 		if (rtlhal->hw_type == HARDWARE_TYPE_RTL8812AE)
-			rtl8812ae_sw_led_off(hw, pled0);
+			rtl8812ae_sw_led_off(hw, pin0);
 		else
-			rtl8821ae_sw_led_off(hw, pled0);
+			rtl8821ae_sw_led_off(hw, pin0);
 }
 
 static bool _rtl8821ae_init_mac(struct ieee80211_hw *hw)
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/led.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/led.c
index 7d6fb134c10f..8bd58db3b3c9 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/led.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/led.c
@@ -6,24 +6,15 @@
 #include "reg.h"
 #include "led.h"
 
-static void _rtl8821ae_init_led(struct ieee80211_hw *hw,
-				struct rtl_led *pled,
-				enum rtl_led_pin ledpin)
-{
-	pled->hw = hw;
-	pled->ledpin = ledpin;
-	pled->ledon = false;
-}
-
-void rtl8821ae_sw_led_on(struct ieee80211_hw *hw, struct rtl_led *pled)
+void rtl8821ae_sw_led_on(struct ieee80211_hw *hw, enum rtl_led_pin pin)
 {
 	u8 ledcfg;
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
 	rtl_dbg(rtlpriv, COMP_LED, DBG_LOUD,
-		"LedAddr:%X ledpin=%d\n", REG_LEDCFG2, pled->ledpin);
+		"LedAddr:%X ledpin=%d\n", REG_LEDCFG2, pin);
 
-	switch (pled->ledpin) {
+	switch (pin) {
 	case LED_PIN_GPIO0:
 		break;
 	case LED_PIN_LED0:
@@ -38,19 +29,18 @@ void rtl8821ae_sw_led_on(struct ieee80211_hw *hw, struct rtl_led *pled)
 		break;
 	default:
 		rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
-			"switch case %#x not processed\n", pled->ledpin);
+			"unknown LED pin %d\n", pin);
 		break;
 	}
-	pled->ledon = true;
 }
 
-void rtl8812ae_sw_led_on(struct ieee80211_hw *hw, struct rtl_led *pled)
+void rtl8812ae_sw_led_on(struct ieee80211_hw *hw, enum rtl_led_pin pin)
 {
 	u16	ledreg = REG_LEDCFG1;
 	u8	ledcfg = 0;
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
-	switch (pled->ledpin) {
+	switch (pin) {
 	case LED_PIN_LED0:
 		ledreg = REG_LEDCFG1;
 		break;
@@ -66,27 +56,26 @@ void rtl8812ae_sw_led_on(struct ieee80211_hw *hw, struct rtl_led *pled)
 
 	rtl_dbg(rtlpriv, COMP_LED, DBG_LOUD,
 		"In SwLedOn, LedAddr:%X LEDPIN=%d\n",
-		ledreg, pled->ledpin);
+		ledreg, pin);
 
 	ledcfg =  rtl_read_byte(rtlpriv, ledreg);
 	ledcfg |= BIT(5); /*Set 0x4c[21]*/
 	ledcfg &= ~(BIT(7) | BIT(6) | BIT(3) | BIT(2) | BIT(1) | BIT(0));
 		/*Clear 0x4c[23:22] and 0x4c[19:16]*/
 	rtl_write_byte(rtlpriv, ledreg, ledcfg); /*SW control led0 on.*/
-	pled->ledon = true;
 }
 
-void rtl8821ae_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled)
+void rtl8821ae_sw_led_off(struct ieee80211_hw *hw, enum rtl_led_pin pin)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u8 ledcfg;
 
 	rtl_dbg(rtlpriv, COMP_LED, DBG_LOUD,
-		"LedAddr:%X ledpin=%d\n", REG_LEDCFG2, pled->ledpin);
+		"LedAddr:%X ledpin=%d\n", REG_LEDCFG2, pin);
 
 	ledcfg = rtl_read_byte(rtlpriv, REG_LEDCFG2);
 
-	switch (pled->ledpin) {
+	switch (pin) {
 	case LED_PIN_GPIO0:
 		break;
 	case LED_PIN_LED0:
@@ -110,18 +99,17 @@ void rtl8821ae_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled)
 		break;
 	default:
 		rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
-			"switch case %#x not processed\n", pled->ledpin);
+			"unknown LED pin %d\n", pin);
 		break;
 	}
-	pled->ledon = false;
 }
 
-void rtl8812ae_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled)
+void rtl8812ae_sw_led_off(struct ieee80211_hw *hw, enum rtl_led_pin pin)
 {
 	u16 ledreg = REG_LEDCFG1;
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
-	switch (pled->ledpin) {
+	switch (pin) {
 	case LED_PIN_LED0:
 		ledreg = REG_LEDCFG1;
 		break;
@@ -137,7 +125,7 @@ void rtl8812ae_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled)
 
 	rtl_dbg(rtlpriv, COMP_LED, DBG_LOUD,
 		"In SwLedOff,LedAddr:%X LEDPIN=%d\n",
-		ledreg, pled->ledpin);
+		ledreg, pin);
 	/*Open-drain arrangement for controlling the LED*/
 	if (rtlpriv->ledctl.led_opendrain) {
 		u8 ledcfg = rtl_read_byte(rtlpriv, ledreg);
@@ -152,23 +140,13 @@ void rtl8812ae_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled)
 	} else {
 		rtl_write_byte(rtlpriv, ledreg, 0x28);
 	}
-
-	pled->ledon = false;
-}
-
-void rtl8821ae_init_sw_leds(struct ieee80211_hw *hw)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-
-	_rtl8821ae_init_led(hw, &rtlpriv->ledctl.sw_led0, LED_PIN_LED0);
-	_rtl8821ae_init_led(hw, &rtlpriv->ledctl.sw_led1, LED_PIN_LED1);
 }
 
 static void _rtl8821ae_sw_led_control(struct ieee80211_hw *hw,
 				      enum led_ctl_mode ledaction)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_led *pled0 = &rtlpriv->ledctl.sw_led0;
+	enum rtl_led_pin pin0 = rtlpriv->ledctl.sw_led0;
 	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
 
 	switch (ledaction) {
@@ -176,15 +154,15 @@ static void _rtl8821ae_sw_led_control(struct ieee80211_hw *hw,
 	case LED_CTL_LINK:
 	case LED_CTL_NO_LINK:
 		if (rtlhal->hw_type == HARDWARE_TYPE_RTL8812AE)
-			rtl8812ae_sw_led_on(hw, pled0);
+			rtl8812ae_sw_led_on(hw, pin0);
 		else
-			rtl8821ae_sw_led_on(hw, pled0);
+			rtl8821ae_sw_led_on(hw, pin0);
 		break;
 	case LED_CTL_POWER_OFF:
 		if (rtlhal->hw_type == HARDWARE_TYPE_RTL8812AE)
-			rtl8812ae_sw_led_off(hw, pled0);
+			rtl8812ae_sw_led_off(hw, pin0);
 		else
-			rtl8821ae_sw_led_off(hw, pled0);
+			rtl8821ae_sw_led_off(hw, pin0);
 		break;
 	default:
 		break;
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/led.h b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/led.h
index 249a37a8d9db..76d5c0b0e39e 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/led.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/led.h
@@ -4,11 +4,10 @@
 #ifndef __RTL8821AE_LED_H__
 #define __RTL8821AE_LED_H__
 
-void rtl8821ae_init_sw_leds(struct ieee80211_hw *hw);
-void rtl8821ae_sw_led_on(struct ieee80211_hw *hw, struct rtl_led *pled);
-void rtl8812ae_sw_led_on(struct ieee80211_hw *hw, struct rtl_led *pled);
-void rtl8821ae_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled);
-void rtl8812ae_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled);
+void rtl8821ae_sw_led_on(struct ieee80211_hw *hw, enum rtl_led_pin pin);
+void rtl8812ae_sw_led_on(struct ieee80211_hw *hw, enum rtl_led_pin pin);
+void rtl8821ae_sw_led_off(struct ieee80211_hw *hw, enum rtl_led_pin pin);
+void rtl8812ae_sw_led_off(struct ieee80211_hw *hw, enum rtl_led_pin pin);
 void rtl8821ae_led_control(struct ieee80211_hw *hw,
 			   enum led_ctl_mode ledaction);
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/sw.c
index 950542a24e31..0bca542e103f 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/sw.c
@@ -269,7 +269,6 @@ static struct rtl_hal_ops rtl8821ae_hal_ops = {
 	.tx_polling = rtl8821ae_tx_polling,
 	.enable_hw_sec = rtl8821ae_enable_hw_security_config,
 	.set_key = rtl8821ae_set_key,
-	.init_sw_leds = rtl8821ae_init_sw_leds,
 	.get_bbreg = rtl8821ae_phy_query_bb_reg,
 	.set_bbreg = rtl8821ae_phy_set_bb_reg,
 	.get_rfreg = rtl8821ae_phy_query_rf_reg,
diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wireless/realtek/rtlwifi/usb.c
index a8eebafb9a7e..969fb31d7985 100644
--- a/drivers/net/wireless/realtek/rtlwifi/usb.c
+++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
@@ -1068,7 +1068,7 @@ int rtl_usb_probe(struct usb_interface *intf,
 		pr_err("Can't init_sw_vars\n");
 		goto error_out;
 	}
-	rtlpriv->cfg->ops->init_sw_leds(hw);
+	rtl_init_sw_leds(hw);
 
 	err = ieee80211_register_hw(hw);
 	if (err) {
@@ -1117,7 +1117,6 @@ void rtl_usb_disconnect(struct usb_interface *intf)
 	rtl_usb_deinit(hw);
 	rtl_deinit_core(hw);
 	kfree(rtlpriv->usb_data);
-	rtlpriv->cfg->ops->deinit_sw_leds(hw);
 	rtlpriv->cfg->ops->deinit_sw_vars(hw);
 	_rtl_usb_io_handler_release(hw);
 	usb_put_dev(rtlusb->udev);
diff --git a/drivers/net/wireless/realtek/rtlwifi/wifi.h b/drivers/net/wireless/realtek/rtlwifi/wifi.h
index a16b779080cb..5b4979771dbf 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -1070,18 +1070,10 @@ struct rtl_probe_rsp {
 	struct rtl_info_element info_element[];
 } __packed;
 
-/*LED related.*/
-/*ledpin Identify how to implement this SW led.*/
-struct rtl_led {
-	void *hw;
-	enum rtl_led_pin ledpin;
-	bool ledon;
-};
-
 struct rtl_led_ctl {
 	bool led_opendrain;
-	struct rtl_led sw_led0;
-	struct rtl_led sw_led1;
+	enum rtl_led_pin sw_led0;
+	enum rtl_led_pin sw_led1;
 };
 
 struct rtl_qos_parameters {
@@ -2287,8 +2279,6 @@ struct rtl_hal_ops {
 	void (*set_key)(struct ieee80211_hw *hw, u32 key_index,
 			u8 *macaddr, bool is_group, u8 enc_algo,
 			bool is_wepkey, bool clear_all);
-	void (*init_sw_leds)(struct ieee80211_hw *hw);
-	void (*deinit_sw_leds)(struct ieee80211_hw *hw);
 	u32 (*get_bbreg)(struct ieee80211_hw *hw, u32 regaddr, u32 bitmask);
 	void (*set_bbreg)(struct ieee80211_hw *hw, u32 regaddr, u32 bitmask,
 			  u32 data);
-- 
2.40.1

