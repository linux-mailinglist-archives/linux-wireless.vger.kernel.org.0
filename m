Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0911906CF
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2020 08:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgCXHw3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Mar 2020 03:52:29 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:57967 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbgCXHw2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Mar 2020 03:52:28 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 02O7qJtq025524, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 02O7qJtq025524
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Mar 2020 15:52:20 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 24 Mar 2020 15:52:20 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 24 Mar 2020 15:52:19 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>,
        <tehuang@realtek.com>
Subject: [PATCH v6 1/2] rtw88: add regulatory process strategy for different chipset
Date:   Tue, 24 Mar 2020 15:52:15 +0800
Message-ID: <20200324075216.22553-2-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200324075216.22553-1-yhchuang@realtek.com>
References: <20200324075216.22553-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB02.realtek.com.tw (172.21.6.95) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tzu-En Huang <tehuang@realtek.com>

If the country code in efuse is not set to a specific regulatory,
then the efuse setting is WW (world-wide).

For the country codes that are set to a specific country, the driver
is not going to apply any new setting notified from the stack.

For the country codes that are not set, which is treated as WW, the
driver hints stack with "00" country code. But when there's any other
regulatory found in IE, notified by NL80211_REGDOM_SET_BY_COUNTRY_IE,
the driver will apply the setting found in the IE for 802.11d.

We want all of the regulatory rules being set strictly, not to loose
the restrictions of the country setting, so apply REGULATORY_STRICT_REG
to all of the regulatory settings.

For user notification (NL80211_REGDOM_SET_BY_USER), we'd like to
default disable it because as FCC publication 594280 states:
"In particular, users must not be relied on to set a country code or
location code to ensure compliance". If any distributions or OSes want
to set regulatory through user space tool (ex, iw reg set), then they
should honor the compile flag option RTW88_REGD_USER_REG_HINTS.

Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---

v3 -> v4
  * squashed with "rtw88: support dynamic user regulatory setting"
  * modify the commit log

v4 -> v5
  * no change

v5 -> v6
  * remove custom world-wide, use stack world-wide
  * surface error codes

 drivers/net/wireless/realtek/rtw88/Kconfig | 10 ++++
 drivers/net/wireless/realtek/rtw88/main.c  |  5 +-
 drivers/net/wireless/realtek/rtw88/regd.c  | 54 ++++++++++++++++++----
 3 files changed, 57 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/Kconfig b/drivers/net/wireless/realtek/rtw88/Kconfig
index 33bd7ed797ff..04b84ec1dfc1 100644
--- a/drivers/net/wireless/realtek/rtw88/Kconfig
+++ b/drivers/net/wireless/realtek/rtw88/Kconfig
@@ -52,4 +52,14 @@ config RTW88_DEBUGFS
 
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
index 7640e97706f5..5d43bef91a3c 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1501,8 +1501,9 @@ int rtw_register_hw(struct rtw_dev *rtwdev, struct ieee80211_hw *hw)
 		return ret;
 	}
 
-	if (regulatory_hint(hw->wiphy, rtwdev->regd.alpha2))
-		rtw_err(rtwdev, "regulatory_hint fail\n");
+	ret = regulatory_hint(hw->wiphy, rtwdev->efuse.country_code);
+	if (ret)
+		rtw_warn(rtwdev, "failed to hint regulatory: %d\n", ret);
 
 	rtw_debugfs_init(rtwdev);
 
diff --git a/drivers/net/wireless/realtek/rtw88/regd.c b/drivers/net/wireless/realtek/rtw88/regd.c
index 69744dd65968..4cc1234bfb9a 100644
--- a/drivers/net/wireless/realtek/rtw88/regd.c
+++ b/drivers/net/wireless/realtek/rtw88/regd.c
@@ -339,12 +339,34 @@ static struct rtw_regulatory rtw_regd_find_reg_by_name(char *alpha2)
 	return rtw_defined_chplan;
 }
 
+static bool rtw_regd_is_ww(struct rtw_regulatory *reg)
+{
+	if (reg->txpwr_regd == RTW_REGD_WW)
+		return true;
+
+	return false;
+}
+
 static int rtw_regd_notifier_apply(struct rtw_dev *rtwdev,
 				   struct wiphy *wiphy,
 				   struct regulatory_request *request)
 {
-	if (request->initiator == NL80211_REGDOM_SET_BY_USER)
+	if (request->initiator == NL80211_REGDOM_SET_BY_DRIVER)
+		return -ENOTSUPP;
+
+	if (request->initiator == NL80211_REGDOM_SET_BY_USER &&
+	    !IS_ENABLED(CONFIG_RTW88_REGD_USER_REG_HINTS))
+		return -EPERM;
+
+	if (request->initiator == NL80211_REGDOM_SET_BY_CORE) {
+		char *country_code;
+
+		/* return to the efuse setting */
+		country_code = rtwdev->efuse.country_code;
+		rtwdev->regd = rtw_regd_find_reg_by_name(country_code);
 		return 0;
+	}
+
 	rtwdev->regd = rtw_regd_find_reg_by_name(request->alpha2);
 	rtw_regd_apply_world_flags(wiphy, request->initiator);
 
@@ -352,16 +374,20 @@ static int rtw_regd_notifier_apply(struct rtw_dev *rtwdev,
 }
 
 static int
-rtw_regd_init_wiphy(struct rtw_regulatory *reg, struct wiphy *wiphy,
+rtw_regd_init_wiphy(struct rtw_dev *rtwdev, struct wiphy *wiphy,
 		    void (*reg_notifier)(struct wiphy *wiphy,
 					 struct regulatory_request *request))
 {
-	wiphy->reg_notifier = reg_notifier;
+	struct rtw_regulatory *reg = &rtwdev->regd;
 
-	wiphy->regulatory_flags &= ~REGULATORY_CUSTOM_REG;
-	wiphy->regulatory_flags &= ~REGULATORY_STRICT_REG;
-	wiphy->regulatory_flags &= ~REGULATORY_DISABLE_BEACON_HINTS;
+	if (rtw_regd_is_ww(reg)) {
+		/* "00" implies worldwide in stack */
+		rtwdev->efuse.country_code[0] = '0';
+		rtwdev->efuse.country_code[1] = '0';
+	}
 
+	wiphy->reg_notifier = reg_notifier;
+	wiphy->regulatory_flags |= REGULATORY_STRICT_REG;
 	rtw_regd_apply_hw_cap_flags(wiphy);
 
 	return 0;
@@ -377,7 +403,7 @@ int rtw_regd_init(struct rtw_dev *rtwdev,
 		return -EINVAL;
 
 	rtwdev->regd = rtw_regd_find_reg_by_name(rtwdev->efuse.country_code);
-	rtw_regd_init_wiphy(&rtwdev->regd, wiphy, reg_notifier);
+	rtw_regd_init_wiphy(rtwdev, wiphy, reg_notifier);
 
 	return 0;
 }
@@ -387,12 +413,20 @@ void rtw_regd_notifier(struct wiphy *wiphy, struct regulatory_request *request)
 	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
 	struct rtw_dev *rtwdev = hw->priv;
 	struct rtw_hal *hal = &rtwdev->hal;
+	int ret;
+
+	ret = rtw_regd_notifier_apply(rtwdev, wiphy, request);
+	if (ret) {
+		rtw_warn(rtwdev, "failed to apply regulatory from initiator %d: %d\n",
+			 request->initiator, ret);
+		return;
+	}
 
-	rtw_regd_notifier_apply(rtwdev, wiphy, request);
 	rtw_dbg(rtwdev, RTW_DBG_REGD,
 		"get alpha2 %c%c from initiator %d, mapping to chplan 0x%x, txregd %d\n",
-		request->alpha2[0], request->alpha2[1], request->initiator,
-		rtwdev->regd.chplan, rtwdev->regd.txpwr_regd);
+		request->alpha2[0], request->alpha2[1],
+		request->initiator, rtwdev->regd.chplan,
+		rtwdev->regd.txpwr_regd);
 
 	rtw_phy_set_tx_power_level(rtwdev, hal->current_channel);
 }
-- 
2.17.1

