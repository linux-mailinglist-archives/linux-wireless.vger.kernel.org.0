Return-Path: <linux-wireless+bounces-7381-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 683F78C0D23
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 11:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98F261C21119
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 09:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75F214A4DD;
	Thu,  9 May 2024 09:07:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB76F14AD3A
	for <linux-wireless@vger.kernel.org>; Thu,  9 May 2024 09:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715245644; cv=none; b=PyxSD164FH6hOX5Z8My/xp/XrsqiX08wbLZ1qBt4SSrJL63aRruavuwXD2clXUaoCXbCyODBKkwRZs88jhmDZDJsgQMCvW2djwBf+RELBQZR0BXG1S0/gEQgS2RrQ/byheGuDCDcdmmPxq+az0Ham9XM95qo9K1w0XV4n3NwWzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715245644; c=relaxed/simple;
	bh=MeSPTYzHt4ufSUjgo/Sfc3ICHYD/1p71cMsjtD0v0tU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d/Bh1GU/ucPwqREVugKmEw8YfwuYz9bgO9Fe7D1tofN3871cmCATV16akrdF3imXXjhPYwWw6Kr0B61afDrghCx0ZhCo9Fffdd3XxZnJlZG/O8+7YHHCGYxch8Va9TthkdAJWNJ3tzyLRdyQ+Q+u7ueRgZfYSGXEntiMuAc/N/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44997Ka941425761, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44997Ka941425761
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 9 May 2024 17:07:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 May 2024 17:07:21 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 9 May
 2024 17:07:20 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 3/4] wifi: rtw89: switch to register vif_cfg_changed and link_info_changed
Date: Thu, 9 May 2024 17:06:45 +0800
Message-ID: <20240509090646.35304-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240509090646.35304-1-pkshih@realtek.com>
References: <20240509090646.35304-1-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

For impending MLO support, we drop bss_info_changed callback ahead and
switch to register new callbacks, vif_cfg_changed and link_info_changed,
which are introduced by mac80211 for multi-link point of view.

Besides, there is a place where we called ieee80211_find_sta() under
station mode. To work on both non-MLD and MLD connection, we should
call ieee80211_find_sta() with vif->cfg.ap_addr.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac80211.c | 42 ++++++++++++-------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 1ec97250e88e..41b286da3d59 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -397,15 +397,14 @@ static void rtw89_conf_tx(struct rtw89_dev *rtwdev,
 }
 
 static void rtw89_station_mode_sta_assoc(struct rtw89_dev *rtwdev,
-					 struct ieee80211_vif *vif,
-					 struct ieee80211_bss_conf *conf)
+					 struct ieee80211_vif *vif)
 {
 	struct ieee80211_sta *sta;
 
 	if (vif->type != NL80211_IFTYPE_STATION)
 		return;
 
-	sta = ieee80211_find_sta(vif, conf->bssid);
+	sta = ieee80211_find_sta(vif, vif->cfg.ap_addr);
 	if (!sta) {
 		rtw89_err(rtwdev, "can't find sta to set sta_assoc state\n");
 		return;
@@ -416,10 +415,8 @@ static void rtw89_station_mode_sta_assoc(struct rtw89_dev *rtwdev,
 	rtw89_core_sta_assoc(rtwdev, vif, sta);
 }
 
-static void rtw89_ops_bss_info_changed(struct ieee80211_hw *hw,
-				       struct ieee80211_vif *vif,
-				       struct ieee80211_bss_conf *conf,
-				       u64 changed)
+static void rtw89_ops_vif_cfg_changed(struct ieee80211_hw *hw,
+				      struct ieee80211_vif *vif, u64 changed)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
@@ -429,7 +426,7 @@ static void rtw89_ops_bss_info_changed(struct ieee80211_hw *hw,
 
 	if (changed & BSS_CHANGED_ASSOC) {
 		if (vif->cfg.assoc) {
-			rtw89_station_mode_sta_assoc(rtwdev, vif, conf);
+			rtw89_station_mode_sta_assoc(rtwdev, vif);
 			rtw89_phy_set_bss_color(rtwdev, vif);
 			rtw89_chip_cfg_txpwr_ul_tb_offset(rtwdev, vif);
 			rtw89_mac_port_update(rtwdev, rtwvif);
@@ -445,6 +442,26 @@ static void rtw89_ops_bss_info_changed(struct ieee80211_hw *hw,
 		}
 	}
 
+	if (changed & BSS_CHANGED_PS)
+		rtw89_recalc_lps(rtwdev);
+
+	if (changed & BSS_CHANGED_ARP_FILTER)
+		rtwvif->ip_addr = vif->cfg.arp_addr_list[0];
+
+	mutex_unlock(&rtwdev->mutex);
+}
+
+static void rtw89_ops_link_info_changed(struct ieee80211_hw *hw,
+					struct ieee80211_vif *vif,
+					struct ieee80211_bss_conf *conf,
+					u64 changed)
+{
+	struct rtw89_dev *rtwdev = hw->priv;
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+
+	mutex_lock(&rtwdev->mutex);
+	rtw89_leave_ps_mode(rtwdev);
+
 	if (changed & BSS_CHANGED_BSSID) {
 		ether_addr_copy(rtwvif->bssid, conf->bssid);
 		rtw89_cam_bssid_changed(rtwdev, rtwvif);
@@ -470,12 +487,6 @@ static void rtw89_ops_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_CQM)
 		rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, vif, true);
 
-	if (changed & BSS_CHANGED_PS)
-		rtw89_recalc_lps(rtwdev);
-
-	if (changed & BSS_CHANGED_ARP_FILTER)
-		rtwvif->ip_addr = vif->cfg.arp_addr_list[0];
-
 	mutex_unlock(&rtwdev->mutex);
 }
 
@@ -1143,7 +1154,8 @@ const struct ieee80211_ops rtw89_ops = {
 	.change_interface       = rtw89_ops_change_interface,
 	.remove_interface	= rtw89_ops_remove_interface,
 	.configure_filter	= rtw89_ops_configure_filter,
-	.bss_info_changed	= rtw89_ops_bss_info_changed,
+	.vif_cfg_changed	= rtw89_ops_vif_cfg_changed,
+	.link_info_changed	= rtw89_ops_link_info_changed,
 	.start_ap		= rtw89_ops_start_ap,
 	.stop_ap		= rtw89_ops_stop_ap,
 	.set_tim		= rtw89_ops_set_tim,
-- 
2.25.1


