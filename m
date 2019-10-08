Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C28F1CF4E7
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2019 10:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730611AbfJHIVP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Oct 2019 04:21:15 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:47344 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730555AbfJHIVO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Oct 2019 04:21:14 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x988L8Ic028141, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x988L8Ic028141
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 8 Oct 2019 16:21:08 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Tue, 8 Oct 2019 16:21:07 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 05/10] rtw88: update regulatory settings implementaion
Date:   Tue, 8 Oct 2019 16:20:56 +0800
Message-ID: <20191008082101.2494-6-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191008082101.2494-1-yhchuang@realtek.com>
References: <20191008082101.2494-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tzu-En Huang <tehuang@realtek.com>

There are two kinds of country/regulatory efuse settings
for Realtek's chipset, one is worldwide and the other is
a specific country. For the chipset with the country setting
being a specific country, driver needs to ensure that the
setting will not be modified when connecting to an AP.

For the chipset with the country setting is worldwide,
driver will follow the NL80211_REGDOM_SET_BY_COUNTRY_IE
regulatory notification from the mac80211 stack.

Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.c |  9 +++-
 drivers/net/wireless/realtek/rtw88/main.h |  2 +
 drivers/net/wireless/realtek/rtw88/regd.c | 61 +++++++++++++++++++----
 3 files changed, 59 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 570b2e358be4..edd490c507b5 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -21,14 +21,17 @@ EXPORT_SYMBOL(rtw_fw_lps_deep_mode);
 bool rtw_bf_support = true;
 unsigned int rtw_debug_mask;
 EXPORT_SYMBOL(rtw_debug_mask);
+bool rtw_allow_user_reg_set;
 
 module_param_named(lps_deep_mode, rtw_fw_lps_deep_mode, uint, 0644);
 module_param_named(support_bf, rtw_bf_support, bool, 0644);
 module_param_named(debug_mask, rtw_debug_mask, uint, 0644);
+module_param_named(allow_user_reg_set, rtw_allow_user_reg_set, bool, 0644);
 
 MODULE_PARM_DESC(lps_deep_mode, "Deeper PS mode. If 0, deep PS is disabled");
 MODULE_PARM_DESC(support_bf, "Set Y to enable beamformee support");
 MODULE_PARM_DESC(debug_mask, "Debugging mask");
+MODULE_PARM_DESC(allow_user_reg_set, "Set Y to allow regulatory settings from user");
 
 static struct ieee80211_channel rtw_channeltable_2g[] = {
 	{.center_freq = 2412, .hw_value = 1,},
@@ -1411,8 +1414,10 @@ int rtw_register_hw(struct rtw_dev *rtwdev, struct ieee80211_hw *hw)
 		return ret;
 	}
 
-	if (regulatory_hint(hw->wiphy, rtwdev->regd.alpha2))
-		rtw_err(rtwdev, "regulatory_hint fail\n");
+	if (!rtwdev->efuse.country_worldwide) {
+		if (regulatory_hint(hw->wiphy, rtwdev->efuse.country_code))
+			rtw_err(rtwdev, "regulatory_hint fail\n");
+	}
 
 	rtw_debugfs_init(rtwdev);
 
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index cb6336b28f12..74d16e49693b 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -31,6 +31,7 @@
 extern bool rtw_bf_support;
 extern unsigned int rtw_fw_lps_deep_mode;
 extern unsigned int rtw_debug_mask;
+extern bool rtw_allow_user_reg_set;
 extern const struct ieee80211_ops rtw_ops;
 extern struct rtw_chip_info rtw8822b_hw_spec;
 extern struct rtw_chip_info rtw8822c_hw_spec;
@@ -1293,6 +1294,7 @@ struct rtw_efuse {
 	u8 addr[ETH_ALEN];
 	u8 channel_plan;
 	u8 country_code[2];
+	bool country_worldwide;
 	u8 rf_board_option;
 	u8 rfe_option;
 	u8 power_track_type;
diff --git a/drivers/net/wireless/realtek/rtw88/regd.c b/drivers/net/wireless/realtek/rtw88/regd.c
index 69744dd65968..454149548382 100644
--- a/drivers/net/wireless/realtek/rtw88/regd.c
+++ b/drivers/net/wireless/realtek/rtw88/regd.c
@@ -7,6 +7,18 @@
 #include "debug.h"
 #include "phy.h"
 
+static const struct ieee80211_regdomain rtw88_world_regdom = {
+	.n_reg_rules = 5,
+	.alpha2 =  "99",
+	.reg_rules = {
+		REG_RULE(2412 - 10, 2462 + 10, 40, 0, 20, 0),
+		REG_RULE(2467 - 10, 2484 + 10, 40, 0, 20, NL80211_RRF_NO_IR),
+		REG_RULE(5180 - 10, 5240 + 10, 80, 0, 20, NL80211_RRF_NO_IR),
+		REG_RULE(5260 - 10, 5700 + 10, 80, 0, 20,
+			 NL80211_RRF_NO_IR | NL80211_RRF_DFS),
+		REG_RULE(5745 - 10, 5825 + 10, 80, 0, 20, NL80211_RRF_NO_IR),
+	}
+};
 #define COUNTRY_CHPLAN_ENT(_alpha2, _chplan, _txpwr_regd) \
 	{.alpha2 = (_alpha2), \
 	 .chplan = (_chplan), \
@@ -339,12 +351,31 @@ static struct rtw_regulatory rtw_regd_find_reg_by_name(char *alpha2)
 	return rtw_defined_chplan;
 }
 
+static bool rtw_regd_is_ww(struct rtw_regulatory *reg)
+{
+	if (reg->txpwr_regd == RTW_REGD_WW)
+		return true;
+	return false;
+}
+
 static int rtw_regd_notifier_apply(struct rtw_dev *rtwdev,
 				   struct wiphy *wiphy,
 				   struct regulatory_request *request)
 {
-	if (request->initiator == NL80211_REGDOM_SET_BY_USER)
+	if (request->initiator == NL80211_REGDOM_SET_BY_DRIVER)
+		return -EINVAL;
+	if (request->initiator == NL80211_REGDOM_SET_BY_USER &&
+	    !rtw_allow_user_reg_set)
+		return -EINVAL;
+	if (request->initiator == NL80211_REGDOM_SET_BY_COUNTRY_IE &&
+	    !rtw_regd_is_ww(&rtwdev->regd))
+		return -EINVAL;
+	if (request->initiator == NL80211_REGDOM_SET_BY_CORE &&
+	    !rtwdev->efuse.country_worldwide) {
+		rtwdev->regd =
+			rtw_regd_find_reg_by_name(rtwdev->efuse.country_code);
 		return 0;
+	}
 	rtwdev->regd = rtw_regd_find_reg_by_name(request->alpha2);
 	rtw_regd_apply_world_flags(wiphy, request->initiator);
 
@@ -352,15 +383,22 @@ static int rtw_regd_notifier_apply(struct rtw_dev *rtwdev,
 }
 
 static int
-rtw_regd_init_wiphy(struct rtw_regulatory *reg, struct wiphy *wiphy,
+rtw_regd_init_wiphy(struct rtw_dev *rtwdev, struct wiphy *wiphy,
 		    void (*reg_notifier)(struct wiphy *wiphy,
 					 struct regulatory_request *request))
 {
+	struct rtw_regulatory *reg = &rtwdev->regd;
+
 	wiphy->reg_notifier = reg_notifier;
 
-	wiphy->regulatory_flags &= ~REGULATORY_CUSTOM_REG;
-	wiphy->regulatory_flags &= ~REGULATORY_STRICT_REG;
-	wiphy->regulatory_flags &= ~REGULATORY_DISABLE_BEACON_HINTS;
+	if (rtw_regd_is_ww(reg)) {
+		rtwdev->efuse.country_worldwide = true;
+		wiphy->regulatory_flags |= REGULATORY_CUSTOM_REG;
+		wiphy_apply_custom_regulatory(wiphy, &rtw88_world_regdom);
+	} else {
+		rtwdev->efuse.country_worldwide = false;
+	}
+	wiphy->regulatory_flags |= REGULATORY_STRICT_REG;
 
 	rtw_regd_apply_hw_cap_flags(wiphy);
 
@@ -377,7 +415,7 @@ int rtw_regd_init(struct rtw_dev *rtwdev,
 		return -EINVAL;
 
 	rtwdev->regd = rtw_regd_find_reg_by_name(rtwdev->efuse.country_code);
-	rtw_regd_init_wiphy(&rtwdev->regd, wiphy, reg_notifier);
+	rtw_regd_init_wiphy(rtwdev, wiphy, reg_notifier);
 
 	return 0;
 }
@@ -388,11 +426,12 @@ void rtw_regd_notifier(struct wiphy *wiphy, struct regulatory_request *request)
 	struct rtw_dev *rtwdev = hw->priv;
 	struct rtw_hal *hal = &rtwdev->hal;
 
-	rtw_regd_notifier_apply(rtwdev, wiphy, request);
-	rtw_dbg(rtwdev, RTW_DBG_REGD,
-		"get alpha2 %c%c from initiator %d, mapping to chplan 0x%x, txregd %d\n",
-		request->alpha2[0], request->alpha2[1], request->initiator,
-		rtwdev->regd.chplan, rtwdev->regd.txpwr_regd);
+	if (!rtw_regd_notifier_apply(rtwdev, wiphy, request))
+		rtw_dbg(rtwdev, RTW_DBG_REGD,
+			"get alpha2 %c%c from initiator %d, mapping to chplan 0x%x, txregd %d\n",
+			request->alpha2[0], request->alpha2[1],
+			request->initiator, rtwdev->regd.chplan,
+			rtwdev->regd.txpwr_regd);
 
 	rtw_phy_set_tx_power_level(rtwdev, hal->current_channel);
 }
-- 
2.17.1

