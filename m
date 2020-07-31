Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 107CE233D72
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jul 2020 04:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731190AbgGaCqX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 22:46:23 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:46510 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731124AbgGaCqV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 22:46:21 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 06V2kDYK1008073, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 06V2kDYK1008073
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 31 Jul 2020 10:46:13 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 31 Jul 2020 10:46:13 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 31 Jul 2020 10:46:12 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <tehuang@realtek.com>,
        <briannorris@chromium.org>
Subject: [PATCH v8 1/2] rtw88: add regulatory process strategy for different chipset
Date:   Fri, 31 Jul 2020 10:46:06 +0800
Message-ID: <20200731024607.5817-2-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200731024607.5817-1-yhchuang@realtek.com>
References: <20200731024607.5817-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tzu-En Huang <tehuang@realtek.com>

For Realtek's chipsets, there are 2 different settings of
regulatory domains, worldwide chipsets, and chipsets with a
specific country code. Since we do not want sthe tack to
possibly decrease the driver's regulatory, REGULATORY_STRICT_REG
is set (i.e. rtw88 will have the control of its regulatory).
And ignore regulatory notifications set from user-space,
unless the driver is compiled with the compile flag option
RTW88_REGD_USER_REG_HINTS.

Regarding chipsets with a specific country, driver calls
regulatory_hint() to tell the stack what regulatory it is.
As we do not want the regulatory of this chipset be changed,
the driver will not apply new regulatory notifications from
either NL80211_REGDOM_SET_BY_DRIVER, NL80211_REGDOM_SET_BY_USER
or NL80211_REGDOM_SET_BY_COUNTRY_IE.

For worldwide chipsets, there are many cases we want to describe.

Let's start with the case without RTW88_REGD_USER_REG_HINTS.
In worldwide mode, we want to follow the regulatory of an
associated AP, but we do not want to follow the regulatory from
the other drivers, so we will apply regulatory notifications from
NL80211_REGDOM_SET_BY_COUNTRY_IE.

For cases with RTW88_REGD_USER_REG_HINTS, if there are not any
NL80211_REGDOM_SET_BY_USER notifications, driver will also follow
the AP's regulatory. On the other hand, if there are notifications
from NL80211_REGDOM_SET_BY_USER, we want to make sure that the
settings from user-space will not be violated when associating
to a new AP. Under such situation, stack will change the regulatory
to the AP's. And because we have set REGULATORY_STRICT_REG, the
mac80211 stack will intersect the driver's regulatory with the AP's.
Thus, we provide a custom worldwide regulatory for intersection,
and the result of it will never violate the setting from
NL80211_REGDOM_SET_BY_USER.

Reviewed-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/Kconfig | 10 +++
 drivers/net/wireless/realtek/rtw88/main.c  |  7 +-
 drivers/net/wireless/realtek/rtw88/main.h  |  1 +
 drivers/net/wireless/realtek/rtw88/regd.c  | 74 +++++++++++++++++++---
 drivers/net/wireless/realtek/rtw88/regd.h  |  2 +
 5 files changed, 82 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/Kconfig b/drivers/net/wireless/realtek/rtw88/Kconfig
index e3d7cb6c1290..cc75779e353b 100644
--- a/drivers/net/wireless/realtek/rtw88/Kconfig
+++ b/drivers/net/wireless/realtek/rtw88/Kconfig
@@ -88,4 +88,14 @@ config RTW88_DEBUGFS
 
 	  If unsure, say Y to simplify debug problems
 
+config RTW88_REGD_USER_REG_HINTS
+	bool "Realtek rtw88 user regulatory hints"
+	depends on RTW88_CORE
+	default n
+	help
+	  Enable regulatoy user hints
+
+	  If unsure, say N. This should only be allowed on distributions
+	  that need this to correct the regulatory.
+
 endif
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 7304e8bc5e31..e381b4309663 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1565,8 +1565,11 @@ int rtw_register_hw(struct rtw_dev *rtwdev, struct ieee80211_hw *hw)
 		return ret;
 	}
 
-	if (regulatory_hint(hw->wiphy, rtwdev->regd.alpha2))
-		rtw_err(rtwdev, "regulatory_hint fail\n");
+	if (!rtwdev->efuse.country_worldwide) {
+		ret = regulatory_hint(hw->wiphy, rtwdev->efuse.country_code);
+		if (ret)
+			rtw_warn(rtwdev, "failed to hint regulatory:%d\n", ret);
+	}
 
 	rtw_debugfs_init(rtwdev);
 
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 45ebc5a70b1e..d60830ea6569 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1512,6 +1512,7 @@ struct rtw_efuse {
 	u8 addr[ETH_ALEN];
 	u8 channel_plan;
 	u8 country_code[2];
+	bool country_worldwide;
 	u8 rf_board_option;
 	u8 rfe_option;
 	u8 power_track_type;
diff --git a/drivers/net/wireless/realtek/rtw88/regd.c b/drivers/net/wireless/realtek/rtw88/regd.c
index 69744dd65968..52a7491bb134 100644
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
@@ -332,19 +344,47 @@ static struct rtw_regulatory rtw_regd_find_reg_by_name(char *alpha2)
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(all_chplan_map); i++) {
-		if (!memcmp(all_chplan_map[i].alpha2, alpha2, 2))
+		if (!memcmp(all_chplan_map[i].alpha2, alpha2, RTW_ALPHA2_LEN))
 			return all_chplan_map[i];
 	}
 
 	return rtw_defined_chplan;
 }
 
+static bool rtw_regd_is_ww(struct rtw_regulatory *reg)
+{
+	if (reg->txpwr_regd == RTW_REGD_WW)
+		return true;
+	return false;
+}
+
+static bool rtw_regd_is_match(struct rtw_dev *rtwdev, char *alpha2)
+{
+	return !memcmp(rtwdev->regd.alpha2, alpha2, RTW_ALPHA2_LEN);
+}
+
 static int rtw_regd_notifier_apply(struct rtw_dev *rtwdev,
 				   struct wiphy *wiphy,
 				   struct regulatory_request *request)
 {
-	if (request->initiator == NL80211_REGDOM_SET_BY_USER)
+	if (rtw_regd_is_match(rtwdev, request->alpha2)) {
+		rtw_regd_apply_world_flags(wiphy, request->initiator);
 		return 0;
+	}
+	if (request->initiator == NL80211_REGDOM_SET_BY_DRIVER)
+		return -ENOTSUPP;
+	if (request->initiator == NL80211_REGDOM_SET_BY_USER &&
+	    !IS_ENABLED(CONFIG_RTW88_REGD_USER_REG_HINTS))
+		return -EPERM;
+	if (request->initiator == NL80211_REGDOM_SET_BY_COUNTRY_IE &&
+	    !rtw_regd_is_ww(&rtwdev->regd))
+		return -EINVAL;
+	if (request->initiator == NL80211_REGDOM_SET_BY_CORE &&
+	    !rtwdev->efuse.country_worldwide) {
+		rtwdev->regd =
+			rtw_regd_find_reg_by_name(rtwdev->efuse.country_code);
+		return 0;
+	}
 	rtwdev->regd = rtw_regd_find_reg_by_name(request->alpha2);
 	rtw_regd_apply_world_flags(wiphy, request->initiator);
 
@@ -352,15 +392,22 @@ static int rtw_regd_notifier_apply(struct rtw_dev *rtwdev,
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
 
@@ -377,7 +424,7 @@ int rtw_regd_init(struct rtw_dev *rtwdev,
 		return -EINVAL;
 
 	rtwdev->regd = rtw_regd_find_reg_by_name(rtwdev->efuse.country_code);
-	rtw_regd_init_wiphy(&rtwdev->regd, wiphy, reg_notifier);
+	rtw_regd_init_wiphy(rtwdev, wiphy, reg_notifier);
 
 	return 0;
 }
@@ -387,12 +434,19 @@ void rtw_regd_notifier(struct wiphy *wiphy, struct regulatory_request *request)
 	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
 	struct rtw_dev *rtwdev = hw->priv;
 	struct rtw_hal *hal = &rtwdev->hal;
+	int ret;
 
-	rtw_regd_notifier_apply(rtwdev, wiphy, request);
+	ret = rtw_regd_notifier_apply(rtwdev, wiphy, request);
+	if (ret) {
+		rtw_warn(rtwdev, "failed to apply regulatory from initiator %d: %d\n",
+			 request->initiator, ret);
+		return;
+	}
 	rtw_dbg(rtwdev, RTW_DBG_REGD,
 		"get alpha2 %c%c from initiator %d, mapping to chplan 0x%x, txregd %d\n",
-		request->alpha2[0], request->alpha2[1], request->initiator,
-		rtwdev->regd.chplan, rtwdev->regd.txpwr_regd);
+		request->alpha2[0], request->alpha2[1],
+		request->initiator, rtwdev->regd.chplan,
+		rtwdev->regd.txpwr_regd);
 
 	rtw_phy_set_tx_power_level(rtwdev, hal->current_channel);
 }
diff --git a/drivers/net/wireless/realtek/rtw88/regd.h b/drivers/net/wireless/realtek/rtw88/regd.h
index 5d4578331788..5eb252c41383 100644
--- a/drivers/net/wireless/realtek/rtw88/regd.h
+++ b/drivers/net/wireless/realtek/rtw88/regd.h
@@ -64,6 +64,8 @@ enum country_code_type {
 	COUNTRY_CODE_MAX
 };
 
+#define RTW_ALPHA2_LEN 2
+
 int rtw_regd_init(struct rtw_dev *rtwdev,
 		  void (*reg_notifier)(struct wiphy *wiphy,
 				       struct regulatory_request *request));
-- 
2.17.1

