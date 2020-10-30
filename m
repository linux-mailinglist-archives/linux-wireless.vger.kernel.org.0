Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92DD52A0054
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Oct 2020 09:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgJ3Is6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Oct 2020 04:48:58 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:50448 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgJ3Isz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Oct 2020 04:48:55 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 09U8mlfC7013488, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 09U8mlfC7013488
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 30 Oct 2020 16:48:47 +0800
Received: from localhost.localdomain (172.21.69.222) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Fri, 30 Oct 2020 16:48:47 +0800
From:   <tehuang@realtek.com>
To:     <kvalo@codeaurora.org>, <tony0620emma@gmail.com>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH v2 4/4] rtw88: decide lps deep mode from firmware feature.
Date:   Fri, 30 Oct 2020 16:48:26 +0800
Message-ID: <20201030084826.9034-5-tehuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201030084826.9034-1-tehuang@realtek.com>
References: <20201030084826.9034-1-tehuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.69.222]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chin-Yen Lee <timlee@realtek.com>

This patch checks the supported lps deep mode from firmware feature,
and allows different firmware have different deep power mode.
Original module parameter rtw_fw_lps_deep_mode is replaced with
rtw_disable_lps_deep_mode for user to disable lps deep mode.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c       |  3 +-
 drivers/net/wireless/realtek/rtw88/mac80211.c |  2 +-
 drivers/net/wireless/realtek/rtw88/main.c     | 36 ++++++++++++++-----
 drivers/net/wireless/realtek/rtw88/main.h     |  3 +-
 drivers/net/wireless/realtek/rtw88/ps.c       | 14 ++++++--
 drivers/net/wireless/realtek/rtw88/ps.h       |  2 +-
 drivers/net/wireless/realtek/rtw88/wow.c      |  5 +--
 7 files changed, 48 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 29fffacf4085..3cd46759802c 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -13,6 +13,7 @@
 #include "debug.h"
 #include "util.h"
 #include "wow.h"
+#include "ps.h"
 
 static void rtw_fw_c2h_cmd_handle_ext(struct rtw_dev *rtwdev,
 				      struct sk_buff *skb)
@@ -631,7 +632,7 @@ void rtw_fw_set_nlo_info(struct rtw_dev *rtwdev, bool enable)
 
 	SET_NLO_FUN_EN(h2c_pkt, enable);
 	if (enable) {
-		if (rtw_fw_lps_deep_mode)
+		if (rtw_get_lps_deep_mode(rtwdev) != LPS_DEEP_MODE_NONE)
 			SET_NLO_PS_32K(h2c_pkt, enable);
 		SET_NLO_IGNORE_SECURITY(h2c_pkt, enable);
 		SET_NLO_LOC_NLO_INFO(h2c_pkt, loc_nlo);
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index c92fba2fa480..c69397719fdf 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -519,7 +519,7 @@ static int rtw_ops_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	}
 
 	/* download new cam settings for PG to backup */
-	if (rtw_fw_lps_deep_mode == LPS_DEEP_MODE_PG)
+	if (rtw_get_lps_deep_mode(rtwdev) == LPS_DEEP_MODE_PG)
 		rtw_fw_download_rsvd_page(rtwdev);
 
 out:
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 5c46f5d2e87c..71d90b98d6f1 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -16,17 +16,17 @@
 #include "debug.h"
 #include "bf.h"
 
-unsigned int rtw_fw_lps_deep_mode;
-EXPORT_SYMBOL(rtw_fw_lps_deep_mode);
+bool rtw_disable_lps_deep_mode;
+EXPORT_SYMBOL(rtw_disable_lps_deep_mode);
 bool rtw_bf_support = true;
 unsigned int rtw_debug_mask;
 EXPORT_SYMBOL(rtw_debug_mask);
 
-module_param_named(lps_deep_mode, rtw_fw_lps_deep_mode, uint, 0644);
+module_param_named(disable_lps_deep, rtw_disable_lps_deep_mode, bool, 0644);
 module_param_named(support_bf, rtw_bf_support, bool, 0644);
 module_param_named(debug_mask, rtw_debug_mask, uint, 0644);
 
-MODULE_PARM_DESC(lps_deep_mode, "Deeper PS mode. If 0, deep PS is disabled");
+MODULE_PARM_DESC(disable_lps_deep, "Set Y to disable Deep PS");
 MODULE_PARM_DESC(support_bf, "Set Y to enable beamformee support");
 MODULE_PARM_DESC(debug_mask, "Debugging mask");
 
@@ -1023,6 +1023,26 @@ static int rtw_wait_firmware_completion(struct rtw_dev *rtwdev)
 	return 0;
 }
 
+static enum rtw_lps_deep_mode rtw_update_lps_deep_mode(struct rtw_dev *rtwdev,
+						       struct rtw_fw_state *fw)
+{
+	struct rtw_chip_info *chip = rtwdev->chip;
+
+	if (rtw_disable_lps_deep_mode || !chip->lps_deep_mode_supported ||
+	    !fw->feature)
+		return LPS_DEEP_MODE_NONE;
+
+	if ((chip->lps_deep_mode_supported & BIT(LPS_DEEP_MODE_PG)) &&
+	    (fw->feature & FW_FEATURE_PG))
+		return LPS_DEEP_MODE_PG;
+
+	if ((chip->lps_deep_mode_supported & BIT(LPS_DEEP_MODE_LCLK)) &&
+	    (fw->feature & FW_FEATURE_LCLK))
+		return LPS_DEEP_MODE_LCLK;
+
+	return LPS_DEEP_MODE_NONE;
+}
+
 static int rtw_power_on(struct rtw_dev *rtwdev)
 {
 	struct rtw_chip_info *chip = rtwdev->chip;
@@ -1097,6 +1117,9 @@ int rtw_core_start(struct rtw_dev *rtwdev)
 
 	rtw_sec_enable_sec_engine(rtwdev);
 
+	rtwdev->lps_conf.deep_mode = rtw_update_lps_deep_mode(rtwdev, &rtwdev->fw);
+	rtwdev->lps_conf.wow_deep_mode = rtw_update_lps_deep_mode(rtwdev, &rtwdev->wow_fw);
+
 	/* rcr reset after powered on */
 	rtw_write32(rtwdev, REG_RCR, rtwdev->hal.rcr);
 
@@ -1657,10 +1680,6 @@ int rtw_core_init(struct rtw_dev *rtwdev)
 	rtwdev->sec.total_cam_num = 32;
 	rtwdev->hal.current_channel = 1;
 	set_bit(RTW_BC_MC_MACID, rtwdev->mac_id_map);
-	if (!(BIT(rtw_fw_lps_deep_mode) & chip->lps_deep_mode_supported))
-		rtwdev->lps_conf.deep_mode = LPS_DEEP_MODE_NONE;
-	else
-		rtwdev->lps_conf.deep_mode = rtw_fw_lps_deep_mode;
 
 	rtw_stats_init(rtwdev);
 
@@ -1685,6 +1704,7 @@ int rtw_core_init(struct rtw_dev *rtwdev)
 			return ret;
 		}
 	}
+
 	return 0;
 }
 EXPORT_SYMBOL(rtw_core_init);
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 53ddd8661c44..bbfc3312eef5 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -37,7 +37,7 @@
 #define RTW_TP_SHIFT			18 /* bytes/2s --> Mbps */
 
 extern bool rtw_bf_support;
-extern unsigned int rtw_fw_lps_deep_mode;
+extern bool rtw_disable_lps_deep_mode;
 extern unsigned int rtw_debug_mask;
 extern const struct ieee80211_ops rtw_ops;
 
@@ -664,6 +664,7 @@ enum rtw_pwr_state {
 struct rtw_lps_conf {
 	enum rtw_lps_mode mode;
 	enum rtw_lps_deep_mode deep_mode;
+	enum rtw_lps_deep_mode wow_deep_mode;
 	enum rtw_pwr_state state;
 	u8 awake_interval;
 	u8 rlbm;
diff --git a/drivers/net/wireless/realtek/rtw88/ps.c b/drivers/net/wireless/realtek/rtw88/ps.c
index 233b3df264b3..3bead34c3d10 100644
--- a/drivers/net/wireless/realtek/rtw88/ps.c
+++ b/drivers/net/wireless/realtek/rtw88/ps.c
@@ -77,7 +77,7 @@ void rtw_power_mode_change(struct rtw_dev *rtwdev, bool enter)
 	request ^= request | BIT_RPWM_TOGGLE;
 	if (enter) {
 		request |= POWER_MODE_LCLK;
-		if (rtw_fw_lps_deep_mode == LPS_DEEP_MODE_PG)
+		if (rtw_get_lps_deep_mode(rtwdev) == LPS_DEEP_MODE_PG)
 			request |= POWER_MODE_PG;
 	}
 	/* Each request require an ack from firmware */
@@ -195,9 +195,17 @@ static void rtw_leave_lps_core(struct rtw_dev *rtwdev)
 	rtw_coex_lps_notify(rtwdev, COEX_LPS_DISABLE);
 }
 
+enum rtw_lps_deep_mode rtw_get_lps_deep_mode(struct rtw_dev *rtwdev)
+{
+	if (test_bit(RTW_FLAG_WOWLAN, rtwdev->flags))
+		return rtwdev->lps_conf.wow_deep_mode;
+	else
+		return rtwdev->lps_conf.deep_mode;
+}
+
 static void __rtw_enter_lps_deep(struct rtw_dev *rtwdev)
 {
-	if (rtwdev->lps_conf.deep_mode == LPS_DEEP_MODE_NONE)
+	if (rtw_get_lps_deep_mode(rtwdev) == LPS_DEEP_MODE_NONE)
 		return;
 
 	if (!test_bit(RTW_FLAG_LEISURE_PS, rtwdev->flags)) {
@@ -206,7 +214,7 @@ static void __rtw_enter_lps_deep(struct rtw_dev *rtwdev)
 		return;
 	}
 
-	if (rtw_fw_lps_deep_mode == LPS_DEEP_MODE_PG)
+	if (rtw_get_lps_deep_mode(rtwdev) == LPS_DEEP_MODE_PG)
 		rtw_fw_set_pg_info(rtwdev);
 
 	rtw_hci_deep_ps(rtwdev, true);
diff --git a/drivers/net/wireless/realtek/rtw88/ps.h b/drivers/net/wireless/realtek/rtw88/ps.h
index 915b200081fc..7819391c8663 100644
--- a/drivers/net/wireless/realtek/rtw88/ps.h
+++ b/drivers/net/wireless/realtek/rtw88/ps.h
@@ -21,5 +21,5 @@ void rtw_power_mode_change(struct rtw_dev *rtwdev, bool enter);
 void rtw_enter_lps(struct rtw_dev *rtwdev, u8 port_id);
 void rtw_leave_lps(struct rtw_dev *rtwdev);
 void rtw_leave_lps_deep(struct rtw_dev *rtwdev);
-
+enum rtw_lps_deep_mode rtw_get_lps_deep_mode(struct rtw_dev *rtwdev);
 #endif
diff --git a/drivers/net/wireless/realtek/rtw88/wow.c b/drivers/net/wireless/realtek/rtw88/wow.c
index 2fcdf70a3a77..b419bc28861f 100644
--- a/drivers/net/wireless/realtek/rtw88/wow.c
+++ b/drivers/net/wireless/realtek/rtw88/wow.c
@@ -555,7 +555,7 @@ static int rtw_wow_leave_no_link_ps(struct rtw_dev *rtwdev)
 	int ret = 0;
 
 	if (test_bit(RTW_FLAG_WOWLAN, rtwdev->flags)) {
-		if (rtw_fw_lps_deep_mode)
+		if (rtw_get_lps_deep_mode(rtwdev) != LPS_DEEP_MODE_NONE)
 			rtw_leave_lps_deep(rtwdev);
 	} else {
 		if (test_bit(RTW_FLAG_INACTIVE_PS, rtwdev->flags)) {
@@ -616,7 +616,8 @@ static int rtw_wow_enter_ps(struct rtw_dev *rtwdev)
 
 	if (rtw_wow_mgd_linked(rtwdev))
 		ret = rtw_wow_enter_linked_ps(rtwdev);
-	else if (rtw_wow_no_link(rtwdev) && rtw_fw_lps_deep_mode)
+	else if (rtw_wow_no_link(rtwdev) &&
+		 rtw_get_lps_deep_mode(rtwdev) != LPS_DEEP_MODE_NONE)
 		ret = rtw_wow_enter_no_link_ps(rtwdev);
 
 	return ret;
-- 
2.17.1

