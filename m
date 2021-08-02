Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC17A3DD09C
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Aug 2021 08:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbhHBGcg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Aug 2021 02:32:36 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:40032 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbhHBGce (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Aug 2021 02:32:34 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1726WJFO0015010, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1726WJFO0015010
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 2 Aug 2021 14:32:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 2 Aug 2021 14:32:19 +0800
Received: from localhost (172.16.21.121) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 2 Aug 2021
 14:32:18 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <timlee@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH 2/4] rtw88: add regulatory strategy by chip type
Date:   Mon, 2 Aug 2021 14:31:38 +0800
Message-ID: <20210802063140.25670-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210802063140.25670-1-pkshih@realtek.com>
References: <20210802063140.25670-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.21.121]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/02/2021 06:13:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzgvMiCkV6TIIDA2OjAxOjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 08/02/2021 06:21:01
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 165335 [Aug 01 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 449 449 5db59deca4a4f5e6ea34a93b13bc730e229092f4
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;realtek.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/02/2021 06:23:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Realtek chips can program a specific country domain on efuse to
indicate what is the expected rtw_regulatory. For chips with a
PGed country domain, we set REGULATORY_STRICT_REG to tell stack
to consider follow-up regulatory_hint() as the superset of our
regulatory rule. Besides, on driver side, only the request via
NL80211_REGDOM_SET_BY_DRIVER, which matches PGed country domain,
will be handled to keep rtw_regulatory unchanged.

For worldwide roaming chips, i.e. ones without a specific PGed
country domain, system of distro can set expected regulatory via
NL80211_REGDOM_SET_BY_USER. With setting from it, rtw_regulatory
will handle the requests only via NL80211_REGDOM_SET_BY_USER to
follow setting from system of distro. REGULATORY_COUNTRY_IE_IGNORE
will then be set to tell stack to ignore country IE for us. The
restrictions mentioned above will remain until 00, i.e. worldwide,
is set via NL80211_REGDOM_SET_BY_USER.

On the other hand, for worldwide roamin chips, if there is no
specific regulatory set via NL80211_REGDOM_SET_BY_USER, requests
from all regulatory notifications will be handled by rtw_regulatory.
And REGULATORY_COUNTRY_IE_IGNORE won't be set.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.c |  13 +-
 drivers/net/wireless/realtek/rtw88/main.h |  15 +-
 drivers/net/wireless/realtek/rtw88/regd.c | 180 +++++++++++++++++-----
 drivers/net/wireless/realtek/rtw88/regd.h |   6 +-
 4 files changed, 171 insertions(+), 43 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 6bb55e663fc3..f458496bddd5 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1964,7 +1964,11 @@ int rtw_register_hw(struct rtw_dev *rtwdev, struct ieee80211_hw *hw)
 	rtw_set_supported_band(hw, rtwdev->chip);
 	SET_IEEE80211_PERM_ADDR(hw, rtwdev->efuse.addr);
 
-	rtw_regd_init(rtwdev, rtw_regd_notifier);
+	ret = rtw_regd_init(rtwdev);
+	if (ret) {
+		rtw_err(rtwdev, "failed to init regd\n");
+		return ret;
+	}
 
 	ret = ieee80211_register_hw(hw);
 	if (ret) {
@@ -1972,8 +1976,11 @@ int rtw_register_hw(struct rtw_dev *rtwdev, struct ieee80211_hw *hw)
 		return ret;
 	}
 
-	if (regulatory_hint(hw->wiphy, rtwdev->regd.alpha2))
-		rtw_err(rtwdev, "regulatory_hint fail\n");
+	ret = rtw_regd_hint(rtwdev);
+	if (ret) {
+		rtw_err(rtwdev, "failed to hint regd\n");
+		return ret;
+	}
 
 	rtw_debugfs_init(rtwdev);
 
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 0d1bbc7e34a8..2e5cebba1f21 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -804,6 +804,19 @@ struct rtw_regulatory {
 	u8 txpwr_regd_5g;
 };
 
+enum rtw_regd_state {
+	RTW_REGD_STATE_WORLDWIDE,
+	RTW_REGD_STATE_PROGRAMMED,
+	RTW_REGD_STATE_SETTING,
+
+	RTW_REGD_STATE_NR,
+};
+
+struct rtw_regd {
+	enum rtw_regd_state state;
+	const struct rtw_regulatory *regulatory;
+};
+
 struct rtw_chip_ops {
 	int (*mac_init)(struct rtw_dev *rtwdev);
 	int (*dump_fw_crash)(struct rtw_dev *rtwdev);
@@ -1833,7 +1846,7 @@ struct rtw_dev {
 	struct rtw_efuse efuse;
 	struct rtw_sec_desc sec;
 	struct rtw_traffic_stats stats;
-	struct rtw_regulatory regd;
+	struct rtw_regd regd;
 	struct rtw_bf_info bf_info;
 
 	struct rtw_dm_info dm_info;
diff --git a/drivers/net/wireless/realtek/rtw88/regd.c b/drivers/net/wireless/realtek/rtw88/regd.c
index a00ac08acf28..cd50f419f85d 100644
--- a/drivers/net/wireless/realtek/rtw88/regd.c
+++ b/drivers/net/wireless/realtek/rtw88/regd.c
@@ -16,14 +16,14 @@
 #define rtw_dbg_regd_dump(_dev, _msg, _args...)			\
 do {								\
 	struct rtw_dev *__d = (_dev);				\
-	const struct rtw_regulatory *__r =  &__d->regd;		\
+	const struct rtw_regd *__r =  &__d->regd;		\
 	rtw_dbg(__d, RTW_DBG_REGD, _msg				\
 		"apply alpha2 %c%c, regd {%d, %d}\n",		\
 		##_args,					\
-		__r->alpha2[0],					\
-		__r->alpha2[1],					\
-		__r->txpwr_regd_2g,				\
-		__r->txpwr_regd_5g);				\
+		__r->regulatory->alpha2[0],			\
+		__r->regulatory->alpha2[1],			\
+		__r->regulatory->txpwr_regd_2g,			\
+		__r->regulatory->txpwr_regd_5g);		\
 } while (0)
 
 /* If country code is not correctly defined in efuse,
@@ -306,67 +306,177 @@ static void rtw_regd_apply_hw_cap_flags(struct wiphy *wiphy)
 	}
 }
 
-static struct rtw_regulatory rtw_regd_find_reg_by_name(char *alpha2)
+static bool rtw_reg_is_ww(const struct rtw_regulatory *reg)
+{
+	return reg == &rtw_reg_ww;
+}
+
+static bool rtw_reg_match(const struct rtw_regulatory *reg, const char *alpha2)
+{
+	return memcmp(reg->alpha2, alpha2, 2) == 0;
+}
+
+static const struct rtw_regulatory *rtw_reg_find_by_name(const char *alpha2)
 {
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(rtw_reg_map); i++) {
-		if (!memcmp(rtw_reg_map[i].alpha2, alpha2, 2))
-			return rtw_reg_map[i];
+		if (rtw_reg_match(&rtw_reg_map[i], alpha2))
+			return &rtw_reg_map[i];
 	}
 
-	return rtw_reg_ww;
+	return &rtw_reg_ww;
 }
 
-static int rtw_regd_notifier_apply(struct rtw_dev *rtwdev,
-				   struct wiphy *wiphy,
-				   struct regulatory_request *request)
+static
+void rtw_regd_notifier(struct wiphy *wiphy, struct regulatory_request *request);
+
+/* call this before ieee80211_register_hw() */
+int rtw_regd_init(struct rtw_dev *rtwdev)
 {
-	if (request->initiator == NL80211_REGDOM_SET_BY_USER)
-		return 0;
-	rtwdev->regd = rtw_regd_find_reg_by_name(request->alpha2);
+	struct wiphy *wiphy = rtwdev->hw->wiphy;
+	const struct rtw_regulatory *chip_reg;
 
-	return 0;
-}
+	if (!wiphy)
+		return -EINVAL;
 
-static int
-rtw_regd_init_wiphy(struct rtw_regulatory *reg, struct wiphy *wiphy,
-		    void (*reg_notifier)(struct wiphy *wiphy,
-					 struct regulatory_request *request))
-{
-	wiphy->reg_notifier = reg_notifier;
+	wiphy->reg_notifier = rtw_regd_notifier;
 
-	wiphy->regulatory_flags &= ~REGULATORY_CUSTOM_REG;
-	wiphy->regulatory_flags &= ~REGULATORY_STRICT_REG;
-	wiphy->regulatory_flags &= ~REGULATORY_DISABLE_BEACON_HINTS;
+	chip_reg = rtw_reg_find_by_name(rtwdev->efuse.country_code);
+	if (!rtw_reg_is_ww(chip_reg)) {
+		rtwdev->regd.state = RTW_REGD_STATE_PROGRAMMED;
 
-	rtw_regd_apply_hw_cap_flags(wiphy);
+		/* Set REGULATORY_STRICT_REG before ieee80211_register_hw(),
+		 * stack will wait for regulatory_hint() and consider it
+		 * as the superset for our regulatory rule.
+		 */
+		wiphy->regulatory_flags |= REGULATORY_STRICT_REG;
+		wiphy->regulatory_flags |= REGULATORY_COUNTRY_IE_IGNORE;
+	} else {
+		rtwdev->regd.state = RTW_REGD_STATE_WORLDWIDE;
+	}
 
+	rtwdev->regd.regulatory = &rtw_reg_ww;
+	rtw_dbg_regd_dump(rtwdev, "regd init state %d: ", rtwdev->regd.state);
+
+	rtw_regd_apply_hw_cap_flags(wiphy);
 	return 0;
 }
 
-int rtw_regd_init(struct rtw_dev *rtwdev,
-		  void (*reg_notifier)(struct wiphy *wiphy,
-				       struct regulatory_request *request))
+/* call this after ieee80211_register_hw() */
+int rtw_regd_hint(struct rtw_dev *rtwdev)
 {
 	struct wiphy *wiphy = rtwdev->hw->wiphy;
+	int ret;
 
 	if (!wiphy)
 		return -EINVAL;
 
-	rtwdev->regd = rtw_regd_find_reg_by_name(rtwdev->efuse.country_code);
-	rtw_regd_init_wiphy(&rtwdev->regd, wiphy, reg_notifier);
+	if (rtwdev->regd.state == RTW_REGD_STATE_PROGRAMMED) {
+		rtw_dbg(rtwdev, RTW_DBG_REGD,
+			"country domain %c%c is PGed on efuse",
+			rtwdev->efuse.country_code[0],
+			rtwdev->efuse.country_code[1]);
+
+		ret = regulatory_hint(wiphy, rtwdev->efuse.country_code);
+		if (ret) {
+			rtw_warn(rtwdev,
+				 "failed to hint regulatory: %d\n", ret);
+			return ret;
+		}
+	}
 
 	return 0;
 }
 
+static bool rtw_regd_mgmt_worldwide(struct rtw_dev *rtwdev,
+				    struct rtw_regd *next_regd,
+				    struct regulatory_request *request)
+{
+	struct wiphy *wiphy = rtwdev->hw->wiphy;
+
+	next_regd->state = RTW_REGD_STATE_WORLDWIDE;
+
+	if (request->initiator == NL80211_REGDOM_SET_BY_USER &&
+	    !rtw_reg_is_ww(next_regd->regulatory)) {
+		next_regd->state = RTW_REGD_STATE_SETTING;
+		wiphy->regulatory_flags |= REGULATORY_COUNTRY_IE_IGNORE;
+	}
+
+	return true;
+}
+
+static bool rtw_regd_mgmt_programmed(struct rtw_dev *rtwdev,
+				     struct rtw_regd *next_regd,
+				     struct regulatory_request *request)
+{
+	if (request->initiator == NL80211_REGDOM_SET_BY_DRIVER &&
+	    rtw_reg_match(next_regd->regulatory, rtwdev->efuse.country_code)) {
+		next_regd->state = RTW_REGD_STATE_PROGRAMMED;
+		return true;
+	}
+
+	return false;
+}
+
+static bool rtw_regd_mgmt_setting(struct rtw_dev *rtwdev,
+				  struct rtw_regd *next_regd,
+				  struct regulatory_request *request)
+{
+	struct wiphy *wiphy = rtwdev->hw->wiphy;
+
+	if (request->initiator != NL80211_REGDOM_SET_BY_USER)
+		return false;
+
+	next_regd->state = RTW_REGD_STATE_SETTING;
+
+	if (rtw_reg_is_ww(next_regd->regulatory)) {
+		next_regd->state = RTW_REGD_STATE_WORLDWIDE;
+		wiphy->regulatory_flags &= ~REGULATORY_COUNTRY_IE_IGNORE;
+	}
+
+	return true;
+}
+
+static bool (*const rtw_regd_handler[RTW_REGD_STATE_NR])
+	(struct rtw_dev *, struct rtw_regd *, struct regulatory_request *) = {
+	[RTW_REGD_STATE_WORLDWIDE] = rtw_regd_mgmt_worldwide,
+	[RTW_REGD_STATE_PROGRAMMED] = rtw_regd_mgmt_programmed,
+	[RTW_REGD_STATE_SETTING] = rtw_regd_mgmt_setting,
+};
+
+static bool rtw_regd_state_hdl(struct rtw_dev *rtwdev,
+			       struct rtw_regd *next_regd,
+			       struct regulatory_request *request)
+{
+	next_regd->regulatory = rtw_reg_find_by_name(request->alpha2);
+	return rtw_regd_handler[rtwdev->regd.state](rtwdev, next_regd, request);
+}
+
+static
 void rtw_regd_notifier(struct wiphy *wiphy, struct regulatory_request *request)
 {
 	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
 	struct rtw_dev *rtwdev = hw->priv;
 	struct rtw_hal *hal = &rtwdev->hal;
+	struct rtw_regd next_regd = {0};
+	bool hdl;
+
+	hdl = rtw_regd_state_hdl(rtwdev, &next_regd, request);
+	if (!hdl) {
+		rtw_dbg(rtwdev, RTW_DBG_REGD,
+			"regd state %d: ignore request %c%c of initiator %d\n",
+			rtwdev->regd.state,
+			request->alpha2[0],
+			request->alpha2[1],
+			request->initiator);
+		return;
+	}
+
+	rtw_dbg(rtwdev, RTW_DBG_REGD, "regd state: %d -> %d\n",
+		rtwdev->regd.state, next_regd.state);
 
-	rtw_regd_notifier_apply(rtwdev, wiphy, request);
+	rtwdev->regd = next_regd;
 	rtw_dbg_regd_dump(rtwdev, "get alpha2 %c%c from initiator %d: ",
 			  request->alpha2[0],
 			  request->alpha2[1],
@@ -381,8 +491,8 @@ u8 rtw_regd_get(struct rtw_dev *rtwdev)
 	u8 band = hal->current_band_type;
 
 	return band == RTW_BAND_2G ?
-	       rtwdev->regd.txpwr_regd_2g :
-	       rtwdev->regd.txpwr_regd_5g;
+	       rtwdev->regd.regulatory->txpwr_regd_2g :
+	       rtwdev->regd.regulatory->txpwr_regd_5g;
 }
 EXPORT_SYMBOL(rtw_regd_get);
 
diff --git a/drivers/net/wireless/realtek/rtw88/regd.h b/drivers/net/wireless/realtek/rtw88/regd.h
index 18b54ac65a2d..34cb13d0cd9e 100644
--- a/drivers/net/wireless/realtek/rtw88/regd.h
+++ b/drivers/net/wireless/realtek/rtw88/regd.h
@@ -64,10 +64,8 @@ enum country_code_type {
 	COUNTRY_CODE_MAX
 };
 
-int rtw_regd_init(struct rtw_dev *rtwdev,
-		  void (*reg_notifier)(struct wiphy *wiphy,
-				       struct regulatory_request *request));
-void rtw_regd_notifier(struct wiphy *wiphy, struct regulatory_request *request);
+int rtw_regd_init(struct rtw_dev *rtwdev);
+int rtw_regd_hint(struct rtw_dev *rtwdev);
 u8 rtw_regd_get(struct rtw_dev *rtwdev);
 bool rtw_regd_has_alt(u8 regd, u8 *regd_alt);
 #endif
-- 
2.25.1

