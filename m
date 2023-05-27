Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54EF271335F
	for <lists+linux-wireless@lfdr.de>; Sat, 27 May 2023 10:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbjE0IaM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 27 May 2023 04:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjE0IaL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 27 May 2023 04:30:11 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577CEDF;
        Sat, 27 May 2023 01:30:10 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34R8TnyaE019719, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34R8TnyaE019719
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Sat, 27 May 2023 16:29:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Sat, 27 May 2023 16:30:01 +0800
Received: from [127.0.1.1] (172.16.16.243) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Sat, 27 May
 2023 16:30:01 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>, <tony0620emma@gmail.com>
CC:     <stable@vger.kernel.org>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/3] wifi: rtw88: correct PS calculation for SUPPORTS_DYNAMIC_PS
Date:   Sat, 27 May 2023 16:29:37 +0800
Message-ID: <20230527082939.11206-2-pkshih@realtek.com>
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
interface is added or removed. It is allowed to enter PS only if single
one station vif is working. Without this fix, driver doesn't enter PS
anymore that causes higher power consumption.

Fixes: bcde60e599fb ("rtw88: remove misleading module parameter rtw_fw_support_lps")
Cc: stable@vger.kernel.org # 6.1+
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/mac80211.c | 14 +++---
 drivers/net/wireless/realtek/rtw88/main.c     |  4 +-
 drivers/net/wireless/realtek/rtw88/ps.c       | 43 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/ps.h       |  2 +
 4 files changed, 52 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 02cd19ee6e4c4..95808130a76a5 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -88,15 +88,6 @@ static int rtw_ops_config(struct ieee80211_hw *hw, u32 changed)
 		}
 	}
 
-	if (changed & IEEE80211_CONF_CHANGE_PS) {
-		if (hw->conf.flags & IEEE80211_CONF_PS) {
-			rtwdev->ps_enabled = true;
-		} else {
-			rtwdev->ps_enabled = false;
-			rtw_leave_lps(rtwdev);
-		}
-	}
-
 	if (changed & IEEE80211_CONF_CHANGE_CHANNEL)
 		rtw_set_channel(rtwdev);
 
@@ -215,6 +206,7 @@ static int rtw_ops_add_interface(struct ieee80211_hw *hw,
 	config |= PORT_SET_BCN_CTRL;
 	rtw_vif_port_config(rtwdev, rtwvif, config);
 	rtw_core_port_switch(rtwdev, vif);
+	rtw_recalc_lps(rtwdev, vif);
 
 	mutex_unlock(&rtwdev->mutex);
 
@@ -246,6 +238,7 @@ static void rtw_ops_remove_interface(struct ieee80211_hw *hw,
 	config |= PORT_SET_BCN_CTRL;
 	rtw_vif_port_config(rtwdev, rtwvif, config);
 	clear_bit(rtwvif->port, rtwdev->hw_port);
+	rtw_recalc_lps(rtwdev, NULL);
 
 	mutex_unlock(&rtwdev->mutex);
 }
@@ -440,6 +433,9 @@ static void rtw_ops_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_ERP_SLOT)
 		rtw_conf_tx(rtwdev, rtwvif);
 
+	if (changed & BSS_CHANGED_PS)
+		rtw_recalc_lps(rtwdev, NULL);
+
 	rtw_vif_port_config(rtwdev, rtwvif, config);
 
 	mutex_unlock(&rtwdev->mutex);
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 5bf6b45815578..d49019d972387 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -271,8 +271,8 @@ static void rtw_watch_dog_work(struct work_struct *work)
 	 * more than two stations associated to the AP, then we can not enter
 	 * lps, because fw does not handle the overlapped beacon interval
 	 *
-	 * mac80211 should iterate vifs and determine if driver can enter
-	 * ps by passing IEEE80211_CONF_PS to us, all we need to do is to
+	 * rtw_recalc_lps() iterate vifs and determine if driver can enter
+	 * ps by vif->type and vif->cfg.ps, all we need to do here is to
 	 * get that vif and check if device is having traffic more than the
 	 * threshold.
 	 */
diff --git a/drivers/net/wireless/realtek/rtw88/ps.c b/drivers/net/wireless/realtek/rtw88/ps.c
index 996365575f44f..53933fb38a330 100644
--- a/drivers/net/wireless/realtek/rtw88/ps.c
+++ b/drivers/net/wireless/realtek/rtw88/ps.c
@@ -299,3 +299,46 @@ void rtw_leave_lps_deep(struct rtw_dev *rtwdev)
 
 	__rtw_leave_lps_deep(rtwdev);
 }
+
+struct rtw_vif_recalc_lps_iter_data {
+	struct rtw_dev *rtwdev;
+	struct ieee80211_vif *found_vif;
+	int count;
+};
+
+static void __rtw_vif_recalc_lps(struct rtw_vif_recalc_lps_iter_data *data,
+				 struct ieee80211_vif *vif)
+{
+	if (data->count < 0)
+		return;
+
+	if (vif->type != NL80211_IFTYPE_STATION) {
+		data->count = -1;
+		return;
+	}
+
+	data->count++;
+	data->found_vif = vif;
+}
+
+static void rtw_vif_recalc_lps_iter(void *data, u8 *mac,
+				    struct ieee80211_vif *vif)
+{
+	__rtw_vif_recalc_lps(data, vif);
+}
+
+void rtw_recalc_lps(struct rtw_dev *rtwdev, struct ieee80211_vif *new_vif)
+{
+	struct rtw_vif_recalc_lps_iter_data data = { .rtwdev = rtwdev };
+
+	if (new_vif)
+		__rtw_vif_recalc_lps(&data, new_vif);
+	rtw_iterate_vifs(rtwdev, rtw_vif_recalc_lps_iter, &data);
+
+	if (data.count == 1 && data.found_vif->cfg.ps) {
+		rtwdev->ps_enabled = true;
+	} else {
+		rtwdev->ps_enabled = false;
+		rtw_leave_lps(rtwdev);
+	}
+}
diff --git a/drivers/net/wireless/realtek/rtw88/ps.h b/drivers/net/wireless/realtek/rtw88/ps.h
index c194386f6db53..5ae83d2526cfd 100644
--- a/drivers/net/wireless/realtek/rtw88/ps.h
+++ b/drivers/net/wireless/realtek/rtw88/ps.h
@@ -23,4 +23,6 @@ void rtw_enter_lps(struct rtw_dev *rtwdev, u8 port_id);
 void rtw_leave_lps(struct rtw_dev *rtwdev);
 void rtw_leave_lps_deep(struct rtw_dev *rtwdev);
 enum rtw_lps_deep_mode rtw_get_lps_deep_mode(struct rtw_dev *rtwdev);
+void rtw_recalc_lps(struct rtw_dev *rtwdev, struct ieee80211_vif *new_vif);
+
 #endif
-- 
2.25.1

