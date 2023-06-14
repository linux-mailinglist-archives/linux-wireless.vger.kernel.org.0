Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C939D720556
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jun 2023 17:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236213AbjFBPGk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Jun 2023 11:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236232AbjFBPGh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Jun 2023 11:06:37 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42DBE43
        for <linux-wireless@vger.kernel.org>; Fri,  2 Jun 2023 08:06:35 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 352F6EyI4004595, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 352F6EyI4004595
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 2 Jun 2023 23:06:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 2 Jun 2023 23:06:28 +0800
Received: from [127.0.1.1] (172.16.22.87) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 2 Jun 2023
 23:06:28 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/8] wifi: rtw89: process regulatory for 6 GHz power type
Date:   Fri, 2 Jun 2023 23:05:52 +0800
Message-ID: <20230602150556.36777-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230602150556.36777-1-pkshih@realtek.com>
References: <20230602150556.36777-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.22.87]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Configure the corresponding power type for 6 GHz regulatory if we can
determine one single target. Otherwise, we use the default one.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     |  7 +-
 drivers/net/wireless/realtek/rtw89/core.h     | 25 ++++-
 drivers/net/wireless/realtek/rtw89/mac80211.c |  9 ++
 drivers/net/wireless/realtek/rtw89/regd.c     | 91 ++++++++++++++++---
 4 files changed, 116 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 1f841dcba0f03..b96ebd73b08dc 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2873,6 +2873,8 @@ int rtw89_core_sta_add(struct rtw89_dev *rtwdev,
 	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls) {
 		/* for station mode, assign the mac_id from itself */
 		rtwsta->mac_id = rtwvif->mac_id;
+		/* must do rtw89_reg_6ghz_power_recalc() before rfk channel */
+		rtw89_reg_6ghz_power_recalc(rtwdev, rtwvif, true);
 		rtw89_btc_ntfy_role_info(rtwdev, rtwvif, rtwsta,
 					 BTC_ROLE_MSTS_STA_CONN_START);
 		rtw89_chip_rfk_channel(rtwdev);
@@ -3046,10 +3048,11 @@ int rtw89_core_sta_remove(struct rtw89_dev *rtwdev,
 	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
 	int ret;
 
-	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
+	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls) {
+		rtw89_reg_6ghz_power_recalc(rtwdev, rtwvif, false);
 		rtw89_btc_ntfy_role_info(rtwdev, rtwvif, rtwsta,
 					 BTC_ROLE_MSTS_STA_DIS_CONN);
-	else if (vif->type == NL80211_IFTYPE_AP || sta->tdls) {
+	} else if (vif->type == NL80211_IFTYPE_AP || sta->tdls) {
 		rtw89_core_release_bit_map(rtwdev->mac_id_map, rtwsta->mac_id);
 
 		ret = rtw89_fw_h2c_role_maintain(rtwdev, rtwvif, rtwsta,
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 6e807fa571c7d..3915ab7ab8a16 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -488,6 +488,15 @@ enum rtw89_regulation_type {
 	RTW89_REGD_NUM,
 };
 
+enum rtw89_reg_6ghz_power {
+	RTW89_REG_6GHZ_POWER_VLP = 0,
+	RTW89_REG_6GHZ_POWER_LPI = 1,
+	RTW89_REG_6GHZ_POWER_STD = 2,
+
+	NUM_OF_RTW89_REG_6GHZ_POWER,
+	RTW89_REG_6GHZ_POWER_DFLT = RTW89_REG_6GHZ_POWER_VLP,
+};
+
 enum rtw89_fw_pkt_ofld_type {
 	RTW89_PKT_OFLD_TYPE_PROBE_RSP = 0,
 	RTW89_PKT_OFLD_TYPE_PS_POLL = 1,
@@ -2682,6 +2691,7 @@ struct rtw89_vif {
 	struct rtw89_dev *rtwdev;
 	struct rtw89_roc roc;
 	enum rtw89_sub_entity_idx sub_entity_idx;
+	enum rtw89_reg_6ghz_power reg_6ghz_power;
 
 	u8 mac_id;
 	u8 port;
@@ -3807,11 +3817,16 @@ struct rtw89_power_trim_info {
 	u8 pa_bias_trim[RF_PATH_MAX];
 };
 
-struct rtw89_regulatory {
+struct rtw89_regd {
 	char alpha2[3];
 	u8 txpwr_regd[RTW89_BAND_MAX];
 };
 
+struct rtw89_regulatory_info {
+	const struct rtw89_regd *regd;
+	enum rtw89_reg_6ghz_power reg_6ghz_power;
+};
+
 enum rtw89_ifs_clm_application {
 	RTW89_IFS_CLM_INIT = 0,
 	RTW89_IFS_CLM_BACKGROUND = 1,
@@ -4161,7 +4176,7 @@ struct rtw89_dev {
 	u8 total_sta_assoc;
 	bool scanning;
 
-	const struct rtw89_regulatory *regd;
+	struct rtw89_regulatory_info regulatory;
 	struct rtw89_sar_info sar;
 
 	struct rtw89_btc btc;
@@ -4848,7 +4863,9 @@ static inline void rtw89_load_txpwr_table(struct rtw89_dev *rtwdev,
 
 static inline u8 rtw89_regd_get(struct rtw89_dev *rtwdev, u8 band)
 {
-	return rtwdev->regd->txpwr_regd[band];
+	const struct rtw89_regd *regd = rtwdev->regulatory.regd;
+
+	return regd->txpwr_regd[band];
 }
 
 static inline void rtw89_ctrl_btg(struct rtw89_dev *rtwdev, bool btg)
@@ -5090,5 +5107,7 @@ void rtw89_core_scan_start(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 			   const u8 *mac_addr, bool hw_scan);
 void rtw89_core_scan_complete(struct rtw89_dev *rtwdev,
 			      struct ieee80211_vif *vif, bool hw_scan);
+void rtw89_reg_6ghz_power_recalc(struct rtw89_dev *rtwdev,
+				 struct rtw89_vif *rtwvif, bool active);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index f40d70f016e4c..8749b3fd26ea0 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -155,6 +155,7 @@ static int rtw89_ops_add_interface(struct ieee80211_hw *hw,
 	rtwvif->phy_idx = RTW89_PHY_0;
 	rtwvif->sub_entity_idx = RTW89_SUB_ENTITY_0;
 	rtwvif->hit_rule = 0;
+	rtwvif->reg_6ghz_power = RTW89_REG_6GHZ_POWER_DFLT;
 	ether_addr_copy(rtwvif->mac_addr, vif->addr);
 	INIT_LIST_HEAD(&rtwvif->general_pkt_list);
 
@@ -460,8 +461,16 @@ static int rtw89_ops_start_ap(struct ieee80211_hw *hw,
 {
 	struct rtw89_dev *rtwdev = hw->priv;
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	const struct rtw89_chan *chan;
 
 	mutex_lock(&rtwdev->mutex);
+
+	chan = rtw89_chan_get(rtwdev, rtwvif->sub_entity_idx);
+	if (chan->band_type == RTW89_BAND_6G) {
+		mutex_unlock(&rtwdev->mutex);
+		return -EOPNOTSUPP;
+	}
+
 	ether_addr_copy(rtwvif->bssid, vif->bss_conf.bssid);
 	rtw89_cam_bssid_changed(rtwdev, rtwvif);
 	rtw89_mac_port_update(rtwdev, rtwvif);
diff --git a/drivers/net/wireless/realtek/rtw89/regd.c b/drivers/net/wireless/realtek/rtw89/regd.c
index 89e027d846aff..34c4d40cfa022 100644
--- a/drivers/net/wireless/realtek/rtw89/regd.c
+++ b/drivers/net/wireless/realtek/rtw89/regd.c
@@ -5,16 +5,17 @@
 #include "acpi.h"
 #include "debug.h"
 #include "ps.h"
+#include "util.h"
 
 #define COUNTRY_REGD(_alpha2, _txpwr_regd...) \
 	{.alpha2 = (_alpha2), \
 	 .txpwr_regd = {_txpwr_regd}, \
 	}
 
-static const struct rtw89_regulatory rtw89_ww_regd =
+static const struct rtw89_regd rtw89_ww_regd =
 	COUNTRY_REGD("00", RTW89_WW, RTW89_WW);
 
-static const struct rtw89_regulatory rtw89_regd_map[] = {
+static const struct rtw89_regd rtw89_regd_map[] = {
 	COUNTRY_REGD("AR", RTW89_MEXICO, RTW89_MEXICO, RTW89_NA),
 	COUNTRY_REGD("BO", RTW89_FCC, RTW89_FCC, RTW89_FCC),
 	COUNTRY_REGD("BR", RTW89_FCC, RTW89_FCC, RTW89_FCC),
@@ -255,7 +256,7 @@ static const struct rtw89_regulatory rtw89_regd_map[] = {
 	COUNTRY_REGD("PS", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 };
 
-static const struct rtw89_regulatory *rtw89_regd_find_reg_by_name(char *alpha2)
+static const struct rtw89_regd *rtw89_regd_find_reg_by_name(char *alpha2)
 {
 	u32 i;
 
@@ -267,7 +268,7 @@ static const struct rtw89_regulatory *rtw89_regd_find_reg_by_name(char *alpha2)
 	return &rtw89_ww_regd;
 }
 
-static bool rtw89_regd_is_ww(const struct rtw89_regulatory *regd)
+static bool rtw89_regd_is_ww(const struct rtw89_regd *regd)
 {
 	return regd == &rtw89_ww_regd;
 }
@@ -397,21 +398,25 @@ int rtw89_regd_init(struct rtw89_dev *rtwdev,
 		    void (*reg_notifier)(struct wiphy *wiphy,
 					 struct regulatory_request *request))
 {
-	const struct rtw89_regulatory *chip_regd;
+	struct rtw89_regulatory_info *regulatory = &rtwdev->regulatory;
+	const struct rtw89_regd *chip_regd;
 	struct wiphy *wiphy = rtwdev->hw->wiphy;
 	int ret;
 
+	regulatory->reg_6ghz_power = RTW89_REG_6GHZ_POWER_DFLT;
+
 	if (!wiphy)
 		return -EINVAL;
 
 	chip_regd = rtw89_regd_find_reg_by_name(rtwdev->efuse.country_code);
 	if (!rtw89_regd_is_ww(chip_regd)) {
-		rtwdev->regd = chip_regd;
+		rtwdev->regulatory.regd = chip_regd;
 		/* Ignore country ie if there is a country domain programmed in chip */
 		wiphy->regulatory_flags |= REGULATORY_COUNTRY_IE_IGNORE;
 		wiphy->regulatory_flags |= REGULATORY_STRICT_REG;
 
-		ret = regulatory_hint(rtwdev->hw->wiphy, rtwdev->regd->alpha2);
+		ret = regulatory_hint(rtwdev->hw->wiphy,
+				      rtwdev->regulatory.regd->alpha2);
 		if (ret)
 			rtw89_warn(rtwdev, "failed to hint regulatory:%d\n", ret);
 
@@ -419,7 +424,7 @@ int rtw89_regd_init(struct rtw89_dev *rtwdev,
 		return 0;
 	}
 
-	rtw89_debug_regd(rtwdev, rtwdev->regd,
+	rtw89_debug_regd(rtwdev, rtwdev->regulatory.regd,
 			 "worldwide roaming chip, follow the setting of stack");
 	return 0;
 }
@@ -428,13 +433,13 @@ static void rtw89_regd_notifier_apply(struct rtw89_dev *rtwdev,
 				      struct wiphy *wiphy,
 				      struct regulatory_request *request)
 {
-	rtwdev->regd = rtw89_regd_find_reg_by_name(request->alpha2);
+	rtwdev->regulatory.regd = rtw89_regd_find_reg_by_name(request->alpha2);
 	/* This notification might be set from the system of distros,
 	 * and it does not expect the regulatory will be modified by
 	 * connecting to an AP (i.e. country ie).
 	 */
 	if (request->initiator == NL80211_REGDOM_SET_BY_USER &&
-	    !rtw89_regd_is_ww(rtwdev->regd))
+	    !rtw89_regd_is_ww(rtwdev->regulatory.regd))
 		wiphy->regulatory_flags |= REGULATORY_COUNTRY_IE_IGNORE;
 	else
 		wiphy->regulatory_flags &= ~REGULATORY_COUNTRY_IE_IGNORE;
@@ -454,7 +459,8 @@ void rtw89_regd_notifier(struct wiphy *wiphy, struct regulatory_request *request
 		goto exit;
 	}
 	rtw89_regd_notifier_apply(rtwdev, wiphy, request);
-	rtw89_debug_regd(rtwdev, rtwdev->regd, "get from initiator %d, alpha2",
+	rtw89_debug_regd(rtwdev, rtwdev->regulatory.regd,
+			 "get from initiator %d, alpha2",
 			 request->initiator);
 
 	rtw89_core_set_chip_txpwr(rtwdev);
@@ -462,3 +468,66 @@ void rtw89_regd_notifier(struct wiphy *wiphy, struct regulatory_request *request
 exit:
 	mutex_unlock(&rtwdev->mutex);
 }
+
+static void __rtw89_reg_6ghz_power_recalc(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_regulatory_info *regulatory = &rtwdev->regulatory;
+	enum rtw89_reg_6ghz_power sel;
+	const struct rtw89_chan *chan;
+	struct rtw89_vif *rtwvif;
+	int count = 0;
+
+	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
+		chan = rtw89_chan_get(rtwdev, rtwvif->sub_entity_idx);
+		if (chan->band_type != RTW89_BAND_6G)
+			continue;
+
+		if (count != 0 && rtwvif->reg_6ghz_power == sel)
+			continue;
+
+		sel = rtwvif->reg_6ghz_power;
+		count++;
+	}
+
+	if (count != 1)
+		sel = RTW89_REG_6GHZ_POWER_DFLT;
+
+	if (regulatory->reg_6ghz_power == sel)
+		return;
+
+	rtw89_debug(rtwdev, RTW89_DBG_REGD,
+		    "recalc 6 GHz reg power type to %d\n", sel);
+
+	regulatory->reg_6ghz_power = sel;
+
+	rtw89_core_set_chip_txpwr(rtwdev);
+}
+
+void rtw89_reg_6ghz_power_recalc(struct rtw89_dev *rtwdev,
+				 struct rtw89_vif *rtwvif, bool active)
+{
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+
+	lockdep_assert_held(&rtwdev->mutex);
+
+	if (active) {
+		switch (vif->bss_conf.power_type) {
+		case IEEE80211_REG_VLP_AP:
+			rtwvif->reg_6ghz_power = RTW89_REG_6GHZ_POWER_VLP;
+			break;
+		case IEEE80211_REG_LPI_AP:
+			rtwvif->reg_6ghz_power = RTW89_REG_6GHZ_POWER_LPI;
+			break;
+		case IEEE80211_REG_SP_AP:
+			rtwvif->reg_6ghz_power = RTW89_REG_6GHZ_POWER_STD;
+			break;
+		default:
+			rtwvif->reg_6ghz_power = RTW89_REG_6GHZ_POWER_DFLT;
+			break;
+		}
+	} else {
+		rtwvif->reg_6ghz_power = RTW89_REG_6GHZ_POWER_DFLT;
+	}
+
+	__rtw89_reg_6ghz_power_recalc(rtwdev);
+}
-- 
2.25.1

