Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39A171335E
	for <lists+linux-wireless@lfdr.de>; Sat, 27 May 2023 10:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbjE0IaO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 27 May 2023 04:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjE0IaM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 27 May 2023 04:30:12 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2101E1;
        Sat, 27 May 2023 01:30:10 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34R8To962019723, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34R8To962019723
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Sat, 27 May 2023 16:29:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Sat, 27 May 2023 16:30:02 +0800
Received: from [127.0.1.1] (172.16.16.243) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Sat, 27 May
 2023 16:30:02 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>, <tony0620emma@gmail.com>
CC:     <stable@vger.kernel.org>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/3] wifi: rtw89: correct PS calculation for SUPPORTS_DYNAMIC_PS
Date:   Sat, 27 May 2023 16:29:38 +0800
Message-ID: <20230527082939.11206-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230527082939.11206-1-pkshih@realtek.com>
References: <20230527082939.11206-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.243]
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

This driver relies on IEEE80211_CONF_PS of hw->conf.flags to turn off PS or
turn on dynamic PS controlled by driver and firmware. Though this would be
incorrect, it did work before because the flag is always recalculated until
the commit 28977e790b5d ("wifi: mac80211: skip powersave recalc if driver SUPPORTS_DYNAMIC_PS")
is introduced by kernel 5.20 to skip to recalculate IEEE80211_CONF_PS
of hw->conf.flags if driver sets SUPPORTS_DYNAMIC_PS.

Correct this by doing recalculation while BSS_CHANGED_PS is changed and
interface is added or removed. For now, it is allowed to enter PS only if
single one station vif is working, and it could possible to have PS per
vif after firmware can support it. Without this fix, driver doesn't
enter PS anymore that causes higher power consumption.

Fixes: e3ec7017f6a2 ("rtw89: add Realtek 802.11ax driver")
Cc: stable@vger.kernel.org # 6.1+
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac80211.c | 15 +++++------
 drivers/net/wireless/realtek/rtw89/ps.c       | 26 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/ps.h       |  1 +
 3 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index f40d70f016e4c..0ffd7fb489a5e 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -89,15 +89,6 @@ static int rtw89_ops_config(struct ieee80211_hw *hw, u32 changed)
 	    !(hw->conf.flags & IEEE80211_CONF_IDLE))
 		rtw89_leave_ips(rtwdev);
 
-	if (changed & IEEE80211_CONF_CHANGE_PS) {
-		if (hw->conf.flags & IEEE80211_CONF_PS) {
-			rtwdev->lps_enabled = true;
-		} else {
-			rtw89_leave_lps(rtwdev);
-			rtwdev->lps_enabled = false;
-		}
-	}
-
 	if (changed & IEEE80211_CONF_CHANGE_CHANNEL) {
 		rtw89_config_entity_chandef(rtwdev, RTW89_SUB_ENTITY_0,
 					    &hw->conf.chandef);
@@ -168,6 +159,8 @@ static int rtw89_ops_add_interface(struct ieee80211_hw *hw,
 	rtw89_core_txq_init(rtwdev, vif->txq);
 
 	rtw89_btc_ntfy_role_info(rtwdev, rtwvif, NULL, BTC_ROLE_START);
+
+	rtw89_recalc_lps(rtwdev);
 out:
 	mutex_unlock(&rtwdev->mutex);
 
@@ -192,6 +185,7 @@ static void rtw89_ops_remove_interface(struct ieee80211_hw *hw,
 	rtw89_mac_remove_vif(rtwdev, rtwvif);
 	rtw89_core_release_bit_map(rtwdev->hw_port, rtwvif->port);
 	list_del_init(&rtwvif->list);
+	rtw89_recalc_lps(rtwdev);
 	rtw89_enter_ips_by_hwflags(rtwdev);
 
 	mutex_unlock(&rtwdev->mutex);
@@ -451,6 +445,9 @@ static void rtw89_ops_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_CQM)
 		rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, vif, true);
 
+	if (changed & BSS_CHANGED_PS)
+		rtw89_recalc_lps(rtwdev);
+
 	mutex_unlock(&rtwdev->mutex);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/ps.c b/drivers/net/wireless/realtek/rtw89/ps.c
index fa94335f699aa..84201ef19c176 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.c
+++ b/drivers/net/wireless/realtek/rtw89/ps.c
@@ -252,3 +252,29 @@ void rtw89_process_p2p_ps(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif)
 	rtw89_p2p_disable_all_noa(rtwdev, vif);
 	rtw89_p2p_update_noa(rtwdev, vif);
 }
+
+void rtw89_recalc_lps(struct rtw89_dev *rtwdev)
+{
+	struct ieee80211_vif *vif, *found_vif = NULL;
+	struct rtw89_vif *rtwvif;
+	int count = 0;
+
+	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
+		vif = rtwvif_to_vif(rtwvif);
+
+		if (vif->type != NL80211_IFTYPE_STATION) {
+			count = 0;
+			break;
+		}
+
+		count++;
+		found_vif = vif;
+	}
+
+	if (count == 1 && found_vif->cfg.ps) {
+		rtwdev->lps_enabled = true;
+	} else {
+		rtw89_leave_lps(rtwdev);
+		rtwdev->lps_enabled = false;
+	}
+}
diff --git a/drivers/net/wireless/realtek/rtw89/ps.h b/drivers/net/wireless/realtek/rtw89/ps.h
index 73c008db04264..4c18f49204b28 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.h
+++ b/drivers/net/wireless/realtek/rtw89/ps.h
@@ -15,6 +15,7 @@ void rtw89_enter_ips(struct rtw89_dev *rtwdev);
 void rtw89_leave_ips(struct rtw89_dev *rtwdev);
 void rtw89_set_coex_ctrl_lps(struct rtw89_dev *rtwdev, bool btc_ctrl);
 void rtw89_process_p2p_ps(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif);
+void rtw89_recalc_lps(struct rtw89_dev *rtwdev);
 
 static inline void rtw89_leave_ips_by_hwflags(struct rtw89_dev *rtwdev)
 {
-- 
2.25.1

