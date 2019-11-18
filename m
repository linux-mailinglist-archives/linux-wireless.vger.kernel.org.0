Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB73AFFD43
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2019 04:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfKRDPT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Nov 2019 22:15:19 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:38007 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfKRDPT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Nov 2019 22:15:19 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xAI3ExXS028808, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xAI3ExXS028808
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 18 Nov 2019 11:14:59 +0800
Received: from localhost.localdomain (172.21.69.95) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Mon, 18 Nov 2019 11:14:59 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <Larry.Finger@lwfinger.net>, <dev@lynxeye.de>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/2] rtlwifi: rf_lock use non-irqsave spin_lock
Date:   Mon, 18 Nov 2019 11:14:54 +0800
Message-ID: <20191118031455.3893-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.95]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

rf_lock is used to protect RF register access, but they will not called
from interrupt context, so *_irqsave version isn't necessary. Then, these
delays don't affect IRQ services.

The old code holds spin_lock_irqsave() that will be detected a long delay
as below:

  kworker/-276     4d...    0us : _raw_spin_lock_irqsave
  kworker/-276     4d...    0us : rtl8723_phy_rf_serial_read <-rtl8723de_phy_set_rf_reg
  kworker/-276     4d...    1us : rtl8723_phy_query_bb_reg <-rtl8723_phy_rf_serial_read
  kworker/-276     4d...    3us : rtl8723_phy_set_bb_reg <-rtl8723_phy_rf_serial_read
  kworker/-276     4d...    4us : __const_udelay <-rtl8723_phy_rf_serial_read
  kworker/-276     4d...    4us!: delay_mwaitx <-rtl8723_phy_rf_serial_read
  kworker/-276     4d... 1004us : rtl8723_phy_set_bb_reg <-rtl8723_phy_rf_serial_read
  [...]

Reported-by: Lucas Stach <dev@lynxeye.de>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c | 10 ++++------
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c | 10 ++++------
 drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c | 10 ++++------
 drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c | 10 ++++------
 drivers/net/wireless/realtek/rtlwifi/rtl8723be/phy.c | 10 ++++------
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c | 10 ++++------
 6 files changed, 24 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c
index 96d8f25b120f..7e3e512da739 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c
@@ -85,20 +85,19 @@ u32 rtl88e_phy_query_rf_reg(struct ieee80211_hw *hw,
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u32 original_value, readback_value, bitshift;
-	unsigned long flags;
 
 	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), rfpath(%#x), bitmask(%#x)\n",
 		 regaddr, rfpath, bitmask);
 
-	spin_lock_irqsave(&rtlpriv->locks.rf_lock, flags);
+	spin_lock(&rtlpriv->locks.rf_lock);
 
 
 	original_value = _rtl88e_phy_rf_serial_read(hw, rfpath, regaddr);
 	bitshift = _rtl88e_phy_calculate_bit_shift(bitmask);
 	readback_value = (original_value & bitmask) >> bitshift;
 
-	spin_unlock_irqrestore(&rtlpriv->locks.rf_lock, flags);
+	spin_unlock(&rtlpriv->locks.rf_lock);
 
 	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), rfpath(%#x), bitmask(%#x), original_value(%#x)\n",
@@ -112,13 +111,12 @@ void rtl88e_phy_set_rf_reg(struct ieee80211_hw *hw,
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u32 original_value, bitshift;
-	unsigned long flags;
 
 	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
 		  regaddr, bitmask, data, rfpath);
 
-	spin_lock_irqsave(&rtlpriv->locks.rf_lock, flags);
+	spin_lock(&rtlpriv->locks.rf_lock);
 
 	if (bitmask != RFREG_OFFSET_MASK) {
 			original_value = _rtl88e_phy_rf_serial_read(hw,
@@ -133,7 +131,7 @@ void rtl88e_phy_set_rf_reg(struct ieee80211_hw *hw,
 	_rtl88e_phy_rf_serial_write(hw, rfpath, regaddr, data);
 
 
-	spin_unlock_irqrestore(&rtlpriv->locks.rf_lock, flags);
+	spin_unlock(&rtlpriv->locks.rf_lock);
 
 	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
index 0ae6371b6318..4b672199c81d 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
@@ -307,16 +307,15 @@ u32 rtl92d_phy_query_rf_reg(struct ieee80211_hw *hw,
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u32 original_value, readback_value, bitshift;
-	unsigned long flags;
 
 	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), rfpath(%#x), bitmask(%#x)\n",
 		 regaddr, rfpath, bitmask);
-	spin_lock_irqsave(&rtlpriv->locks.rf_lock, flags);
+	spin_lock(&rtlpriv->locks.rf_lock);
 	original_value = _rtl92d_phy_rf_serial_read(hw, rfpath, regaddr);
 	bitshift = _rtl92d_phy_calculate_bit_shift(bitmask);
 	readback_value = (original_value & bitmask) >> bitshift;
-	spin_unlock_irqrestore(&rtlpriv->locks.rf_lock, flags);
+	spin_unlock(&rtlpriv->locks.rf_lock);
 	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), rfpath(%#x), bitmask(%#x), original_value(%#x)\n",
 		 regaddr, rfpath, bitmask, original_value);
@@ -329,14 +328,13 @@ void rtl92d_phy_set_rf_reg(struct ieee80211_hw *hw, enum radio_path rfpath,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_phy *rtlphy = &(rtlpriv->phy);
 	u32 original_value, bitshift;
-	unsigned long flags;
 
 	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
 		 regaddr, bitmask, data, rfpath);
 	if (bitmask == 0)
 		return;
-	spin_lock_irqsave(&rtlpriv->locks.rf_lock, flags);
+	spin_lock(&rtlpriv->locks.rf_lock);
 	if (rtlphy->rf_mode != RF_OP_BY_FW) {
 		if (bitmask != RFREG_OFFSET_MASK) {
 			original_value = _rtl92d_phy_rf_serial_read(hw,
@@ -347,7 +345,7 @@ void rtl92d_phy_set_rf_reg(struct ieee80211_hw *hw, enum radio_path rfpath,
 		}
 		_rtl92d_phy_rf_serial_write(hw, rfpath, regaddr, data);
 	}
-	spin_unlock_irqrestore(&rtlpriv->locks.rf_lock, flags);
+	spin_unlock(&rtlpriv->locks.rf_lock);
 	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
 		 regaddr, bitmask, data, rfpath);
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c
index 222abc41669c..89fd83333292 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c
@@ -84,19 +84,18 @@ u32 rtl92ee_phy_query_rf_reg(struct ieee80211_hw *hw,
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u32 original_value, readback_value, bitshift;
-	unsigned long flags;
 
 	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), rfpath(%#x), bitmask(%#x)\n",
 		  regaddr, rfpath, bitmask);
 
-	spin_lock_irqsave(&rtlpriv->locks.rf_lock, flags);
+	spin_lock(&rtlpriv->locks.rf_lock);
 
 	original_value = _rtl92ee_phy_rf_serial_read(hw , rfpath, regaddr);
 	bitshift = _rtl92ee_phy_calculate_bit_shift(bitmask);
 	readback_value = (original_value & bitmask) >> bitshift;
 
-	spin_unlock_irqrestore(&rtlpriv->locks.rf_lock, flags);
+	spin_unlock(&rtlpriv->locks.rf_lock);
 
 	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x),rfpath(%#x),bitmask(%#x),original_value(%#x)\n",
@@ -111,13 +110,12 @@ void rtl92ee_phy_set_rf_reg(struct ieee80211_hw *hw,
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u32 original_value, bitshift;
-	unsigned long flags;
 
 	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
 		  addr, bitmask, data, rfpath);
 
-	spin_lock_irqsave(&rtlpriv->locks.rf_lock, flags);
+	spin_lock(&rtlpriv->locks.rf_lock);
 
 	if (bitmask != RFREG_OFFSET_MASK) {
 		original_value = _rtl92ee_phy_rf_serial_read(hw, rfpath, addr);
@@ -127,7 +125,7 @@ void rtl92ee_phy_set_rf_reg(struct ieee80211_hw *hw,
 
 	_rtl92ee_phy_rf_serial_write(hw, rfpath, addr, data);
 
-	spin_unlock_irqrestore(&rtlpriv->locks.rf_lock, flags);
+	spin_unlock(&rtlpriv->locks.rf_lock);
 
 	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c
index 54a3aec1dfa7..c0ed1c49921c 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c
@@ -37,13 +37,12 @@ u32 rtl8723e_phy_query_rf_reg(struct ieee80211_hw *hw,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u32 original_value = 0, readback_value, bitshift;
 	struct rtl_phy *rtlphy = &rtlpriv->phy;
-	unsigned long flags;
 
 	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), rfpath(%#x), bitmask(%#x)\n",
 		 regaddr, rfpath, bitmask);
 
-	spin_lock_irqsave(&rtlpriv->locks.rf_lock, flags);
+	spin_lock(&rtlpriv->locks.rf_lock);
 
 	if (rtlphy->rf_mode != RF_OP_BY_FW) {
 		original_value = rtl8723_phy_rf_serial_read(hw,
@@ -53,7 +52,7 @@ u32 rtl8723e_phy_query_rf_reg(struct ieee80211_hw *hw,
 	bitshift = rtl8723_phy_calculate_bit_shift(bitmask);
 	readback_value = (original_value & bitmask) >> bitshift;
 
-	spin_unlock_irqrestore(&rtlpriv->locks.rf_lock, flags);
+	spin_unlock(&rtlpriv->locks.rf_lock);
 
 	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), rfpath(%#x), bitmask(%#x), original_value(%#x)\n",
@@ -69,13 +68,12 @@ void rtl8723e_phy_set_rf_reg(struct ieee80211_hw *hw,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_phy *rtlphy = &rtlpriv->phy;
 	u32 original_value = 0, bitshift;
-	unsigned long flags;
 
 	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
 		  regaddr, bitmask, data, rfpath);
 
-	spin_lock_irqsave(&rtlpriv->locks.rf_lock, flags);
+	spin_lock(&rtlpriv->locks.rf_lock);
 
 	if (rtlphy->rf_mode != RF_OP_BY_FW) {
 		if (bitmask != RFREG_OFFSET_MASK) {
@@ -99,7 +97,7 @@ void rtl8723e_phy_set_rf_reg(struct ieee80211_hw *hw,
 		_rtl8723e_phy_fw_rf_serial_write(hw, rfpath, regaddr, data);
 	}
 
-	spin_unlock_irqrestore(&rtlpriv->locks.rf_lock, flags);
+	spin_unlock(&rtlpriv->locks.rf_lock);
 
 	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/phy.c
index aa8a0950fcea..a84fc554a0bf 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/phy.c
@@ -33,19 +33,18 @@ u32 rtl8723be_phy_query_rf_reg(struct ieee80211_hw *hw, enum radio_path rfpath,
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u32 original_value, readback_value, bitshift;
-	unsigned long flags;
 
 	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), rfpath(%#x), bitmask(%#x)\n",
 		  regaddr, rfpath, bitmask);
 
-	spin_lock_irqsave(&rtlpriv->locks.rf_lock, flags);
+	spin_lock(&rtlpriv->locks.rf_lock);
 
 	original_value = rtl8723_phy_rf_serial_read(hw, rfpath, regaddr);
 	bitshift = rtl8723_phy_calculate_bit_shift(bitmask);
 	readback_value = (original_value & bitmask) >> bitshift;
 
-	spin_unlock_irqrestore(&rtlpriv->locks.rf_lock, flags);
+	spin_unlock(&rtlpriv->locks.rf_lock);
 
 	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), rfpath(%#x), bitmask(%#x), original_value(%#x)\n",
@@ -59,13 +58,12 @@ void rtl8723be_phy_set_rf_reg(struct ieee80211_hw *hw, enum radio_path path,
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u32 original_value, bitshift;
-	unsigned long flags;
 
 	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
 		  regaddr, bitmask, data, path);
 
-	spin_lock_irqsave(&rtlpriv->locks.rf_lock, flags);
+	spin_lock(&rtlpriv->locks.rf_lock);
 
 	if (bitmask != RFREG_OFFSET_MASK) {
 			original_value = rtl8723_phy_rf_serial_read(hw, path,
@@ -77,7 +75,7 @@ void rtl8723be_phy_set_rf_reg(struct ieee80211_hw *hw, enum radio_path path,
 
 	rtl8723_phy_rf_serial_write(hw, path, regaddr, data);
 
-	spin_unlock_irqrestore(&rtlpriv->locks.rf_lock, flags);
+	spin_unlock(&rtlpriv->locks.rf_lock);
 
 	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
index 979e434a4e73..3976bef03e4d 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
@@ -139,19 +139,18 @@ u32 rtl8821ae_phy_query_rf_reg(struct ieee80211_hw *hw,
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u32 original_value, readback_value, bitshift;
-	unsigned long flags;
 
 	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), rfpath(%#x), bitmask(%#x)\n",
 		 regaddr, rfpath, bitmask);
 
-	spin_lock_irqsave(&rtlpriv->locks.rf_lock, flags);
+	spin_lock(&rtlpriv->locks.rf_lock);
 
 	original_value = _rtl8821ae_phy_rf_serial_read(hw, rfpath, regaddr);
 	bitshift = _rtl8821ae_phy_calculate_bit_shift(bitmask);
 	readback_value = (original_value & bitmask) >> bitshift;
 
-	spin_unlock_irqrestore(&rtlpriv->locks.rf_lock, flags);
+	spin_unlock(&rtlpriv->locks.rf_lock);
 
 	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), rfpath(%#x), bitmask(%#x), original_value(%#x)\n",
@@ -166,13 +165,12 @@ void rtl8821ae_phy_set_rf_reg(struct ieee80211_hw *hw,
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u32 original_value, bitshift;
-	unsigned long flags;
 
 	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
 		  regaddr, bitmask, data, rfpath);
 
-	spin_lock_irqsave(&rtlpriv->locks.rf_lock, flags);
+	spin_lock(&rtlpriv->locks.rf_lock);
 
 	if (bitmask != RFREG_OFFSET_MASK) {
 		original_value =
@@ -183,7 +181,7 @@ void rtl8821ae_phy_set_rf_reg(struct ieee80211_hw *hw,
 
 	_rtl8821ae_phy_rf_serial_write(hw, rfpath, regaddr, data);
 
-	spin_unlock_irqrestore(&rtlpriv->locks.rf_lock, flags);
+	spin_unlock(&rtlpriv->locks.rf_lock);
 
 	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
-- 
2.21.0

