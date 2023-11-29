Return-Path: <linux-wireless+bounces-191-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA9B7FCFA5
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 08:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C10B1C20E0E
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 07:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2735E107AD;
	Wed, 29 Nov 2023 07:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B1A1710
	for <linux-wireless@vger.kernel.org>; Tue, 28 Nov 2023 23:02:07 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AT71x8iA2598107, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AT71x8iA2598107
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Nov 2023 15:01:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 29 Nov 2023 15:02:00 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 29 Nov
 2023 15:01:59 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <gary.chang@realtek.com>, <phhuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/4] wifi: rtw89: refine remain on channel flow to improve P2P connection
Date: Wed, 29 Nov 2023 15:00:45 +0800
Message-ID: <20231129070046.18443-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231129070046.18443-1-pkshih@realtek.com>
References: <20231129070046.18443-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

From: Chih-Kang Chang <gary.chang@realtek.com>

We add a scanning check to avoid entering IPS after ROC (remain on
channel) during scanning. Additionally, When P2P scanning, the flow is
`1. p2p_listen step` and `2. configure filter` and `3. p2p_scan starts`
in wpas, but in kernel, cfg80211 uses another workqueue to notify driver
the filter change, so sometimes we see (1 > 3 > 2), that will cause Rx
filter related to scan to be cleared. Therefore, we add a scanning check
when configure filter to avoid scan results to be filtered. Finally, we
cancel the ROC delayed workqueue before entering ROC to avoid entering
twice, which might cause leaving ROC too early.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     |  6 +++---
 drivers/net/wireless/realtek/rtw89/mac80211.c | 18 ++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/ps.h       |  4 ++++
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 74bf29643823..b913f1828769 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2883,9 +2883,6 @@ void rtw89_roc_start(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 
 	lockdep_assert_held(&rtwdev->mutex);
 
-	ieee80211_queue_delayed_work(hw, &rtwvif->roc.roc_work,
-				     msecs_to_jiffies(rtwvif->roc.duration));
-
 	rtw89_leave_ips_by_hwflags(rtwdev);
 	rtw89_leave_lps(rtwdev);
 	rtw89_chanctx_pause(rtwdev, RTW89_CHANCTX_PAUSE_REASON_ROC);
@@ -2907,6 +2904,9 @@ void rtw89_roc_start(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 			  B_AX_A_UC_CAM_MATCH | B_AX_A_BC_CAM_MATCH);
 
 	ieee80211_ready_on_channel(hw);
+	cancel_delayed_work(&rtwvif->roc.roc_work);
+	ieee80211_queue_delayed_work(hw, &rtwvif->roc.roc_work,
+				     msecs_to_jiffies(rtwvif->roc.duration));
 }
 
 void rtw89_roc_end(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 31d1f7891675..5c3a3d9c272a 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -226,6 +226,7 @@ static void rtw89_ops_configure_filter(struct ieee80211_hw *hw,
 {
 	struct rtw89_dev *rtwdev = hw->priv;
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	u32 rx_fltr;
 
 	mutex_lock(&rtwdev->mutex);
 	rtw89_leave_ps_mode(rtwdev);
@@ -272,16 +273,29 @@ static void rtw89_ops_configure_filter(struct ieee80211_hw *hw,
 		}
 	}
 
+	rx_fltr = rtwdev->hal.rx_fltr;
+
+	/* mac80211 doesn't configure filter when HW scan, driver need to
+	 * set by itself. However, during P2P scan might have configure
+	 * filter to overwrite filter that HW scan needed, so we need to
+	 * check scan and append related filter
+	 */
+	if (rtwdev->scanning) {
+		rx_fltr &= ~B_AX_A_BCN_CHK_EN;
+		rx_fltr &= ~B_AX_A_BC;
+		rx_fltr &= ~B_AX_A_A1_MATCH;
+	}
+
 	rtw89_write32_mask(rtwdev,
 			   rtw89_mac_reg_by_idx(rtwdev, mac->rx_fltr, RTW89_MAC_0),
 			   B_AX_RX_FLTR_CFG_MASK,
-			   rtwdev->hal.rx_fltr);
+			   rx_fltr);
 	if (!rtwdev->dbcc_en)
 		goto out;
 	rtw89_write32_mask(rtwdev,
 			   rtw89_mac_reg_by_idx(rtwdev, mac->rx_fltr, RTW89_MAC_1),
 			   B_AX_RX_FLTR_CFG_MASK,
-			   rtwdev->hal.rx_fltr);
+			   rx_fltr);
 
 out:
 	mutex_unlock(&rtwdev->mutex);
diff --git a/drivers/net/wireless/realtek/rtw89/ps.h b/drivers/net/wireless/realtek/rtw89/ps.h
index aff0fba71cb0..54486e4550b6 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.h
+++ b/drivers/net/wireless/realtek/rtw89/ps.h
@@ -33,6 +33,10 @@ static inline void rtw89_enter_ips_by_hwflags(struct rtw89_dev *rtwdev)
 {
 	struct ieee80211_hw *hw = rtwdev->hw;
 
+	/* prevent entering IPS after ROC, but it is scanning */
+	if (rtwdev->scanning)
+		return;
+
 	if (hw->conf.flags & IEEE80211_CONF_IDLE)
 		rtw89_enter_ips(rtwdev);
 }
-- 
2.25.1


