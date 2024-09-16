Return-Path: <linux-wireless+bounces-12881-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D419979ACF
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2024 07:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95420B2351D
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2024 05:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120DC38FB9;
	Mon, 16 Sep 2024 05:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="eMKmvvQR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061243A1BA
	for <linux-wireless@vger.kernel.org>; Mon, 16 Sep 2024 05:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726464796; cv=none; b=UKsC82ekOHovxdt/oAOnPyslDgcJcRAXsSK0qT9KV0bAKxoW/sl1ovBZGcAUlIluhi/pUd6PMooVAP7ZbOZzTERwJsc1vB+eqydcfBsnHyCtLR/oBmUtle9J1ZJU2zXJdTi7zyYuHNgov01idR8RvXLMkE9lwWMW8YrRqtmpSDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726464796; c=relaxed/simple;
	bh=5LExmTHwfh4ybGc1CU/lP83OpKkaoCJwakRetS3OvXA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kglf30ux2oJfli751Dw+R6uZTpjdl2NBr+WoeZe64O/jnwaYYtWOTol4nbulG1BQwyifPQht57TlTJYvWow+/sg2AzTReaXnU41mnmZu0FG/0uX+lKwMCsY73c3s32TrsTshoFoZukK2v1lZ3RbATgyk8RkTj7yD109B7gFaVQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=eMKmvvQR; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48G5XAg842631788, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1726464791; bh=5LExmTHwfh4ybGc1CU/lP83OpKkaoCJwakRetS3OvXA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=eMKmvvQR5WM+Dc5FXlyvHxu04RXhKfq811Z31qRVN+thZdyL7qiXljANBqnahvOes
	 Fj2qjzX3LIOm3wqLDKW/4Pnf2OPqLP2ZZg5VMtjP0PeqJMaApMpWMkg+bCu4C/i9n8
	 uhpvC0w2CI9Cu4IeCeMTYqy9vJK+IwKIsqgNjhvJL6OO7t6srjKTW6nkODwu5r2ft2
	 LyW223lMwurRwrMf36hdZ6Nl9nJr877bmJDo7Zx+vZYrwQ3Ld4Zjl0yppJksxYgeHd
	 hOUioqsS+w/tE3voig95nU3ZlIlfn85cgYKvShoChBSr26Qe1fGFGvs4wilaL+iYoD
	 uS2ZuJ1vNkXug==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48G5XAg842631788
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 16 Sep 2024 13:33:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Sep 2024 13:33:11 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 16 Sep
 2024 13:33:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 6/7] wifi: rtw89: refactor STA related func ahead for MLO
Date: Mon, 16 Sep 2024 13:31:57 +0800
Message-ID: <20240916053158.47350-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240916053158.47350-1-pkshih@realtek.com>
References: <20240916053158.47350-1-pkshih@realtek.com>
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

Refactor STA related functions, e.g. add/assoc/disassoc/disconnect/remove
to separate most link stuffs into sub-functions for MLO reuse.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     | 112 +++++--------
 drivers/net/wireless/realtek/rtw89/core.h     |  40 +++--
 drivers/net/wireless/realtek/rtw89/fw.c       |  17 +-
 drivers/net/wireless/realtek/rtw89/fw.h       |  16 +-
 drivers/net/wireless/realtek/rtw89/mac.c      |  42 +++--
 drivers/net/wireless/realtek/rtw89/mac.h      |  20 ++-
 drivers/net/wireless/realtek/rtw89/mac80211.c | 152 ++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/mac_be.c   |  22 +--
 drivers/net/wireless/realtek/rtw89/phy.c      |   3 +-
 drivers/net/wireless/realtek/rtw89/phy.h      |   2 +-
 drivers/net/wireless/realtek/rtw89/wow.c      |   7 +-
 11 files changed, 261 insertions(+), 172 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index c6d3b8fd98b6..8d2cca0b0a18 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2746,8 +2746,8 @@ static void rtw89_core_ba_work(struct work_struct *work)
 	spin_unlock_bh(&rtwdev->ba_lock);
 }
 
-static void rtw89_core_free_sta_pending_ba(struct rtw89_dev *rtwdev,
-					   struct ieee80211_sta *sta)
+void rtw89_core_free_sta_pending_ba(struct rtw89_dev *rtwdev,
+				    struct ieee80211_sta *sta)
 {
 	struct rtw89_txq *rtwtxq, *tmp;
 
@@ -2761,8 +2761,8 @@ static void rtw89_core_free_sta_pending_ba(struct rtw89_dev *rtwdev,
 	spin_unlock_bh(&rtwdev->ba_lock);
 }
 
-static void rtw89_core_free_sta_pending_forbid_ba(struct rtw89_dev *rtwdev,
-						  struct ieee80211_sta *sta)
+void rtw89_core_free_sta_pending_forbid_ba(struct rtw89_dev *rtwdev,
+					   struct ieee80211_sta *sta)
 {
 	struct rtw89_txq *rtwtxq, *tmp;
 
@@ -2778,8 +2778,8 @@ static void rtw89_core_free_sta_pending_forbid_ba(struct rtw89_dev *rtwdev,
 	spin_unlock_bh(&rtwdev->ba_lock);
 }
 
-static void rtw89_core_free_sta_pending_roc_tx(struct rtw89_dev *rtwdev,
-					       struct ieee80211_sta *sta)
+void rtw89_core_free_sta_pending_roc_tx(struct rtw89_dev *rtwdev,
+					struct ieee80211_sta *sta)
 {
 	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
 	struct sk_buff *skb, *tmp;
@@ -3525,26 +3525,19 @@ void rtw89_vif_type_mapping(struct rtw89_vif_link *rtwvif_link, bool assoc)
 	}
 }
 
-int rtw89_core_sta_add(struct rtw89_dev *rtwdev,
-		       struct ieee80211_vif *vif,
-		       struct ieee80211_sta *sta)
+int rtw89_core_sta_link_add(struct rtw89_dev *rtwdev,
+			    struct rtw89_vif_link *rtwvif_link,
+			    struct rtw89_sta_link *rtwsta_link)
 {
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
-	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
+	struct ieee80211_sta *sta = rtwsta_to_sta(rtwsta_link);
 	struct rtw89_hal *hal = &rtwdev->hal;
 	u8 ant_num = hal->ant_diversity ? 2 : rtwdev->chip->rf_path_num;
 	int i;
 	int ret;
 
-	rtwsta_link->rtwdev = rtwdev;
-	rtwsta_link->rtwvif_link = rtwvif_link;
 	rtwsta_link->prev_rssi = 0;
 	INIT_LIST_HEAD(&rtwsta_link->ba_cam_list);
-	skb_queue_head_init(&rtwsta_link->roc_queue);
-
-	for (i = 0; i < ARRAY_SIZE(sta->txq); i++)
-		rtw89_core_txq_init(rtwdev, sta->txq[i]);
-
 	ewma_rssi_init(&rtwsta_link->avg_rssi);
 	ewma_snr_init(&rtwsta_link->avg_snr);
 	ewma_evm_init(&rtwsta_link->evm_1ss);
@@ -3555,9 +3548,6 @@ int rtw89_core_sta_add(struct rtw89_dev *rtwdev,
 	}
 
 	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls) {
-		/* for station mode, assign the mac_id from itself */
-		rtwsta_link->mac_id = rtwvif_link->mac_id;
-
 		/* must do rtw89_reg_6ghz_recalc() before rfk channel */
 		ret = rtw89_reg_6ghz_recalc(rtwdev, rtwvif_link, true);
 		if (ret)
@@ -3567,13 +3557,8 @@ int rtw89_core_sta_add(struct rtw89_dev *rtwdev,
 					 BTC_ROLE_MSTS_STA_CONN_START);
 		rtw89_chip_rfk_channel(rtwdev, rtwvif_link);
 	} else if (vif->type == NL80211_IFTYPE_AP || sta->tdls) {
-		rtwsta_link->mac_id = rtw89_acquire_mac_id(rtwdev);
-		if (rtwsta_link->mac_id == RTW89_MAX_MAC_ID_NUM)
-			return -ENOSPC;
-
 		ret = rtw89_mac_set_macid_pause(rtwdev, rtwsta_link->mac_id, false);
 		if (ret) {
-			rtw89_release_mac_id(rtwdev, rtwsta_link->mac_id);
 			rtw89_warn(rtwdev, "failed to send h2c macid pause\n");
 			return ret;
 		}
@@ -3581,7 +3566,6 @@ int rtw89_core_sta_add(struct rtw89_dev *rtwdev,
 		ret = rtw89_fw_h2c_role_maintain(rtwdev, rtwvif_link, rtwsta_link,
 						 RTW89_ROLE_CREATE);
 		if (ret) {
-			rtw89_release_mac_id(rtwdev, rtwsta_link->mac_id);
 			rtw89_warn(rtwdev, "failed to send h2c role info\n");
 			return ret;
 		}
@@ -3593,44 +3577,33 @@ int rtw89_core_sta_add(struct rtw89_dev *rtwdev,
 		ret = rtw89_chip_h2c_default_dmac_tbl(rtwdev, rtwvif_link, rtwsta_link);
 		if (ret)
 			return ret;
-
-		rtw89_queue_chanctx_change(rtwdev, RTW89_CHANCTX_REMOTE_STA_CHANGE);
 	}
 
 	return 0;
 }
 
-int rtw89_core_sta_disassoc(struct rtw89_dev *rtwdev,
-			    struct ieee80211_vif *vif,
-			    struct ieee80211_sta *sta)
+int rtw89_core_sta_link_disassoc(struct rtw89_dev *rtwdev,
+				 struct rtw89_vif_link *rtwvif_link,
+				 struct rtw89_sta_link *rtwsta_link)
 {
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
-	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
 
 	if (vif->type == NL80211_IFTYPE_STATION)
-		rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, vif, false);
-
-	rtwdev->total_sta_assoc--;
-	if (sta->tdls)
-		rtwvif_link->tdls_peer--;
-	rtwsta_link->disassoc = true;
+		rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, rtwvif_link, false);
 
 	return 0;
 }
 
-int rtw89_core_sta_disconnect(struct rtw89_dev *rtwdev,
-			      struct ieee80211_vif *vif,
-			      struct ieee80211_sta *sta)
+int rtw89_core_sta_link_disconnect(struct rtw89_dev *rtwdev,
+				   struct rtw89_vif_link *rtwvif_link,
+				   struct rtw89_sta_link *rtwsta_link)
 {
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
-	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
+	struct ieee80211_sta *sta = rtwsta_to_sta(rtwsta_link);
 	int ret;
 
-	rtw89_mac_bf_monitor_calc(rtwdev, sta, true);
-	rtw89_mac_bf_disassoc(rtwdev, vif, sta);
-	rtw89_core_free_sta_pending_ba(rtwdev, sta);
-	rtw89_core_free_sta_pending_forbid_ba(rtwdev, sta);
-	rtw89_core_free_sta_pending_roc_tx(rtwdev, sta);
+	rtw89_mac_bf_monitor_calc(rtwdev, rtwsta_link, true);
+	rtw89_mac_bf_disassoc(rtwdev, rtwvif_link, rtwsta_link);
 
 	if (vif->type == NL80211_IFTYPE_AP || sta->tdls)
 		rtw89_cam_deinit_addr_cam(rtwdev, &rtwsta_link->addr_cam);
@@ -3642,7 +3615,7 @@ int rtw89_core_sta_disconnect(struct rtw89_dev *rtwdev,
 		rtw89_fw_release_general_pkt_list_vif(rtwdev, rtwvif_link, true);
 	}
 
-	ret = rtw89_chip_h2c_assoc_cmac_tbl(rtwdev, vif, sta);
+	ret = rtw89_chip_h2c_assoc_cmac_tbl(rtwdev, rtwvif_link, rtwsta_link);
 	if (ret) {
 		rtw89_warn(rtwdev, "failed to send h2c cmac table\n");
 		return ret;
@@ -3664,12 +3637,12 @@ int rtw89_core_sta_disconnect(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
-int rtw89_core_sta_assoc(struct rtw89_dev *rtwdev,
-			 struct ieee80211_vif *vif,
-			 struct ieee80211_sta *sta)
+int rtw89_core_sta_link_assoc(struct rtw89_dev *rtwdev,
+			      struct rtw89_vif_link *rtwvif_link,
+			      struct rtw89_sta_link *rtwsta_link)
 {
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
-	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
+	struct ieee80211_sta *sta = rtwsta_to_sta(rtwsta_link);
 	struct rtw89_bssid_cam_entry *bssid_cam = rtw89_get_bssid_cam_of(rtwvif_link,
 									 rtwsta_link);
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
@@ -3701,7 +3674,7 @@ int rtw89_core_sta_assoc(struct rtw89_dev *rtwdev,
 		}
 	}
 
-	ret = rtw89_chip_h2c_assoc_cmac_tbl(rtwdev, vif, sta);
+	ret = rtw89_chip_h2c_assoc_cmac_tbl(rtwdev, rtwvif_link, rtwsta_link);
 	if (ret) {
 		rtw89_warn(rtwdev, "failed to send h2c cmac table\n");
 		return ret;
@@ -3720,12 +3693,9 @@ int rtw89_core_sta_assoc(struct rtw89_dev *rtwdev,
 		return ret;
 	}
 
-	rtwdev->total_sta_assoc++;
-	if (sta->tdls)
-		rtwvif_link->tdls_peer++;
-	rtw89_phy_ra_assoc(rtwdev, sta);
-	rtw89_mac_bf_assoc(rtwdev, vif, sta);
-	rtw89_mac_bf_monitor_calc(rtwdev, sta, false);
+	rtw89_phy_ra_assoc(rtwdev, rtwsta_link);
+	rtw89_mac_bf_assoc(rtwdev, rtwvif_link, rtwsta_link);
+	rtw89_mac_bf_monitor_calc(rtwdev, rtwsta_link, false);
 
 	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls) {
 		struct ieee80211_bss_conf *bss_conf;
@@ -3750,18 +3720,18 @@ int rtw89_core_sta_assoc(struct rtw89_dev *rtwdev,
 			return ret;
 		}
 
-		rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, vif, true);
+		rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, rtwvif_link, true);
 	}
 
 	return ret;
 }
 
-int rtw89_core_sta_remove(struct rtw89_dev *rtwdev,
-			  struct ieee80211_vif *vif,
-			  struct ieee80211_sta *sta)
+int rtw89_core_sta_link_remove(struct rtw89_dev *rtwdev,
+			       struct rtw89_vif_link *rtwvif_link,
+			       struct rtw89_sta_link *rtwsta_link)
 {
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
-	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
+	struct ieee80211_sta *sta = rtwsta_to_sta(rtwsta_link);
 	int ret;
 
 	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls) {
@@ -3769,16 +3739,12 @@ int rtw89_core_sta_remove(struct rtw89_dev *rtwdev,
 		rtw89_btc_ntfy_role_info(rtwdev, rtwvif_link, rtwsta_link,
 					 BTC_ROLE_MSTS_STA_DIS_CONN);
 	} else if (vif->type == NL80211_IFTYPE_AP || sta->tdls) {
-		rtw89_release_mac_id(rtwdev, rtwsta_link->mac_id);
-
 		ret = rtw89_fw_h2c_role_maintain(rtwdev, rtwvif_link, rtwsta_link,
 						 RTW89_ROLE_REMOVE);
 		if (ret) {
 			rtw89_warn(rtwdev, "failed to send h2c role info\n");
 			return ret;
 		}
-
-		rtw89_queue_chanctx_change(rtwdev, RTW89_CHANCTX_REMOTE_STA_CHANGE);
 	}
 
 	return 0;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 2b3976c6daf7..bfa3dba07fe1 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3656,8 +3656,8 @@ struct rtw89_chip_ops {
 				    struct rtw89_vif_link *rtwvif_link,
 				    struct rtw89_sta_link *rtwsta_link);
 	int (*h2c_assoc_cmac_tbl)(struct rtw89_dev *rtwdev,
-				  struct ieee80211_vif *vif,
-				  struct ieee80211_sta *sta);
+				  struct rtw89_vif_link *rtwvif_link,
+				  struct rtw89_sta_link *rtwsta_link);
 	int (*h2c_ampdu_cmac_tbl)(struct rtw89_dev *rtwdev,
 				  struct ieee80211_vif *vif,
 				  struct ieee80211_sta *sta);
@@ -6656,21 +6656,21 @@ void rtw89_core_napi_start(struct rtw89_dev *rtwdev);
 void rtw89_core_napi_stop(struct rtw89_dev *rtwdev);
 int rtw89_core_napi_init(struct rtw89_dev *rtwdev);
 void rtw89_core_napi_deinit(struct rtw89_dev *rtwdev);
-int rtw89_core_sta_add(struct rtw89_dev *rtwdev,
-		       struct ieee80211_vif *vif,
-		       struct ieee80211_sta *sta);
-int rtw89_core_sta_assoc(struct rtw89_dev *rtwdev,
-			 struct ieee80211_vif *vif,
-			 struct ieee80211_sta *sta);
-int rtw89_core_sta_disassoc(struct rtw89_dev *rtwdev,
-			    struct ieee80211_vif *vif,
-			    struct ieee80211_sta *sta);
-int rtw89_core_sta_disconnect(struct rtw89_dev *rtwdev,
-			      struct ieee80211_vif *vif,
-			      struct ieee80211_sta *sta);
-int rtw89_core_sta_remove(struct rtw89_dev *rtwdev,
-			  struct ieee80211_vif *vif,
-			  struct ieee80211_sta *sta);
+int rtw89_core_sta_link_add(struct rtw89_dev *rtwdev,
+			    struct rtw89_vif_link *rtwvif_link,
+			    struct rtw89_sta_link *rtwsta_link);
+int rtw89_core_sta_link_assoc(struct rtw89_dev *rtwdev,
+			      struct rtw89_vif_link *rtwvif_link,
+			      struct rtw89_sta_link *rtwsta_link);
+int rtw89_core_sta_link_disassoc(struct rtw89_dev *rtwdev,
+				 struct rtw89_vif_link *rtwvif_link,
+				 struct rtw89_sta_link *rtwsta_link);
+int rtw89_core_sta_link_disconnect(struct rtw89_dev *rtwdev,
+				   struct rtw89_vif_link *rtwvif_link,
+				   struct rtw89_sta_link *rtwsta_link);
+int rtw89_core_sta_link_remove(struct rtw89_dev *rtwdev,
+			       struct rtw89_vif_link *rtwvif_link,
+			       struct rtw89_sta_link *rtwsta_link);
 void rtw89_core_set_tid_config(struct rtw89_dev *rtwdev,
 			       struct ieee80211_sta *sta,
 			       struct cfg80211_tid_config *tid_config);
@@ -6702,6 +6702,12 @@ int rtw89_core_acquire_sta_ba_entry(struct rtw89_dev *rtwdev,
 int rtw89_core_release_sta_ba_entry(struct rtw89_dev *rtwdev,
 				    struct rtw89_sta_link *rtwsta_link, u8 tid,
 				    u8 *cam_idx);
+void rtw89_core_free_sta_pending_ba(struct rtw89_dev *rtwdev,
+				    struct ieee80211_sta *sta);
+void rtw89_core_free_sta_pending_forbid_ba(struct rtw89_dev *rtwdev,
+					   struct ieee80211_sta *sta);
+void rtw89_core_free_sta_pending_roc_tx(struct rtw89_dev *rtwdev,
+					struct ieee80211_sta *sta);
 void rtw89_vif_type_mapping(struct rtw89_vif_link *rtwvif_link, bool assoc);
 int rtw89_chip_info_setup(struct rtw89_dev *rtwdev);
 void rtw89_chip_cfg_txpwr_ul_tb_offset(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 52e5dbe7e59d..8e890ebae613 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2831,12 +2831,11 @@ static void __get_sta_he_pkt_padding(struct rtw89_dev *rtwdev,
 }
 
 int rtw89_fw_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
-				struct ieee80211_vif *vif,
-				struct ieee80211_sta *sta)
+				struct rtw89_vif_link *rtwvif_link,
+				struct rtw89_sta_link *rtwsta_link)
 {
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
 	const struct rtw89_chip_info *chip = rtwdev->chip;
-	struct rtw89_sta_link *rtwsta_link = sta_to_rtwsta_safe(sta);
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
 						       rtwvif_link->chanctx_idx);
 	struct ieee80211_link_sta *link_sta;
@@ -2979,11 +2978,10 @@ static void __get_sta_eht_pkt_padding(struct rtw89_dev *rtwdev,
 }
 
 int rtw89_fw_h2c_assoc_cmac_tbl_g7(struct rtw89_dev *rtwdev,
-				   struct ieee80211_vif *vif,
-				   struct ieee80211_sta *sta)
+				   struct rtw89_vif_link *rtwvif_link,
+				   struct rtw89_sta_link *rtwsta_link)
 {
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
-	struct rtw89_sta_link *rtwsta_link = sta_to_rtwsta_safe(sta);
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, rtwvif_link->chanctx_idx);
 	u8 mac_id = rtwsta_link ? rtwsta_link->mac_id : rtwvif_link->mac_id;
 	struct rtw89_h2c_cctlinfo_ud_g7 *h2c;
@@ -3788,10 +3786,9 @@ int rtw89_fw_h2c_set_ofld_cfg(struct rtw89_dev *rtwdev)
 }
 
 int rtw89_fw_h2c_set_bcn_fltr_cfg(struct rtw89_dev *rtwdev,
-				  struct ieee80211_vif *vif,
+				  struct rtw89_vif_link *rtwvif_link,
 				  bool connect)
 {
-	struct rtw89_vif_link *rtwvif_link = vif_to_rtwvif_safe(vif);
 	struct ieee80211_bss_conf *bss_conf;
 	s32 thold = RTW89_DEFAULT_CQM_THOLD;
 	u32 hyst = RTW89_DEFAULT_CQM_HYST;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index b13512c3feb2..17e952bd70e3 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -4413,11 +4413,11 @@ int rtw89_fw_h2c_default_dmac_tbl_v2(struct rtw89_dev *rtwdev,
 				     struct rtw89_vif_link *rtwvif_link,
 				     struct rtw89_sta_link *rtwsta_link);
 int rtw89_fw_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
-				struct ieee80211_vif *vif,
-				struct ieee80211_sta *sta);
+				struct rtw89_vif_link *rtwvif_link,
+				struct rtw89_sta_link *rtwsta_link);
 int rtw89_fw_h2c_assoc_cmac_tbl_g7(struct rtw89_dev *rtwdev,
-				   struct ieee80211_vif *vif,
-				   struct ieee80211_sta *sta);
+				   struct rtw89_vif_link *rtwvif_link,
+				   struct rtw89_sta_link *rtwsta_link);
 int rtw89_fw_h2c_ampdu_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 				   struct ieee80211_vif *vif,
 				   struct ieee80211_sta *sta);
@@ -4452,7 +4452,7 @@ int rtw89_fw_h2c_set_edca(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvi
 			  u8 ac, u32 val);
 int rtw89_fw_h2c_set_ofld_cfg(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_set_bcn_fltr_cfg(struct rtw89_dev *rtwdev,
-				  struct ieee80211_vif *vif,
+				  struct rtw89_vif_link *rtwvif_link,
 				  bool connect);
 int rtw89_fw_h2c_rssi_offload(struct rtw89_dev *rtwdev,
 			      struct rtw89_rx_phy_ppdu *phy_ppdu);
@@ -4654,12 +4654,12 @@ static inline int rtw89_chip_h2c_update_beacon(struct rtw89_dev *rtwdev,
 }
 
 static inline int rtw89_chip_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
-						struct ieee80211_vif *vif,
-						struct ieee80211_sta *sta)
+						struct rtw89_vif_link *rtwvif_link,
+						struct rtw89_sta_link *rtwsta_link)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 
-	return chip->ops->h2c_assoc_cmac_tbl(rtwdev, vif, sta);
+	return chip->ops->h2c_assoc_cmac_tbl(rtwdev, rtwvif_link, rtwsta_link);
 }
 
 static inline int rtw89_chip_h2c_ampdu_cmac_tbl(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index a7b89a25d7c4..28cc4885105a 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4877,7 +4877,7 @@ rtw89_mac_bcn_fltr_rpt(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_l
 		if (!rtwdev->scanning && !rtwvif_link->offchan)
 			ieee80211_connection_loss(vif);
 		else
-			rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, vif, true);
+			rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, rtwvif_link, true);
 		return;
 	case RTW89_BCN_FLTR_NOTIFY:
 		nl_event = NL80211_CQM_RSSI_THRESHOLD_EVENT_HIGH;
@@ -5969,11 +5969,9 @@ static int rtw89_mac_init_bfee_ax(struct rtw89_dev *rtwdev, u8 mac_idx)
 }
 
 static int rtw89_mac_set_csi_para_reg_ax(struct rtw89_dev *rtwdev,
-					 struct ieee80211_vif *vif,
-					 struct ieee80211_sta *sta)
+					 struct rtw89_vif_link *rtwvif_link,
+					 struct rtw89_sta_link *rtwsta_link)
 {
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
-	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
 	u8 nc = 1, nr = 3, ng = 0, cb = 1, cs = 1, ldpc_en = 1, stbc_en = 1;
 	struct ieee80211_link_sta *link_sta;
 	u8 mac_idx = rtwvif_link->mac_idx;
@@ -6036,11 +6034,9 @@ static int rtw89_mac_set_csi_para_reg_ax(struct rtw89_dev *rtwdev,
 }
 
 static int rtw89_mac_csi_rrsc_ax(struct rtw89_dev *rtwdev,
-				 struct ieee80211_vif *vif,
-				 struct ieee80211_sta *sta)
+				 struct rtw89_vif_link *rtwvif_link,
+				 struct rtw89_sta_link *rtwsta_link)
 {
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
-	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
 	u32 rrsc = BIT(RTW89_MAC_BF_RRSC_6M) | BIT(RTW89_MAC_BF_RRSC_24M);
 	struct ieee80211_link_sta *link_sta;
 	u8 mac_idx = rtwvif_link->mac_idx;
@@ -6084,11 +6080,9 @@ static int rtw89_mac_csi_rrsc_ax(struct rtw89_dev *rtwdev,
 }
 
 static void rtw89_mac_bf_assoc_ax(struct rtw89_dev *rtwdev,
-				  struct ieee80211_vif *vif,
-				  struct ieee80211_sta *sta)
+				  struct rtw89_vif_link *rtwvif_link,
+				  struct rtw89_sta_link *rtwsta_link)
 {
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
-	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
 	struct ieee80211_link_sta *link_sta;
 	bool has_beamformer_cap;
 
@@ -6103,16 +6097,15 @@ static void rtw89_mac_bf_assoc_ax(struct rtw89_dev *rtwdev,
 		rtw89_debug(rtwdev, RTW89_DBG_BF,
 			    "initialize bfee for new association\n");
 		rtw89_mac_init_bfee_ax(rtwdev, rtwvif_link->mac_idx);
-		rtw89_mac_set_csi_para_reg_ax(rtwdev, vif, sta);
-		rtw89_mac_csi_rrsc_ax(rtwdev, vif, sta);
+		rtw89_mac_set_csi_para_reg_ax(rtwdev, rtwvif_link, rtwsta_link);
+		rtw89_mac_csi_rrsc_ax(rtwdev, rtwvif_link, rtwsta_link);
 	}
 }
 
-void rtw89_mac_bf_disassoc(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
-			   struct ieee80211_sta *sta)
+void rtw89_mac_bf_disassoc(struct rtw89_dev *rtwdev,
+			   struct rtw89_vif_link *rtwvif_link,
+			   struct rtw89_sta_link *rtwsta_link)
 {
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
-
 	rtw89_mac_bfee_ctrl(rtwdev, rtwvif_link->mac_idx, false);
 }
 
@@ -6146,7 +6139,7 @@ void rtw89_mac_bf_set_gid_table(struct rtw89_dev *rtwdev, struct ieee80211_vif *
 
 struct rtw89_mac_bf_monitor_iter_data {
 	struct rtw89_dev *rtwdev;
-	struct ieee80211_sta *down_sta;
+	struct rtw89_sta_link *down_rtwsta_link;
 	int count;
 };
 
@@ -6156,11 +6149,11 @@ void rtw89_mac_bf_monitor_calc_iter(void *data, struct ieee80211_sta *sta)
 	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
 	struct rtw89_mac_bf_monitor_iter_data *iter_data =
 				(struct rtw89_mac_bf_monitor_iter_data *)data;
-	struct ieee80211_sta *down_sta = iter_data->down_sta;
+	struct rtw89_sta_link *down_rtwsta_link = iter_data->down_rtwsta_link;
 	struct ieee80211_link_sta *link_sta;
 	int *count = &iter_data->count;
 
-	if (down_sta == sta)
+	if (down_rtwsta_link == rtwsta_link)
 		return;
 
 	rcu_read_lock();
@@ -6173,12 +6166,13 @@ void rtw89_mac_bf_monitor_calc_iter(void *data, struct ieee80211_sta *sta)
 }
 
 void rtw89_mac_bf_monitor_calc(struct rtw89_dev *rtwdev,
-			       struct ieee80211_sta *sta, bool disconnect)
+			       struct rtw89_sta_link *rtwsta_link,
+			       bool disconnect)
 {
 	struct rtw89_mac_bf_monitor_iter_data data;
 
 	data.rtwdev = rtwdev;
-	data.down_sta = disconnect ? sta : NULL;
+	data.down_rtwsta_link = disconnect ? rtwsta_link : NULL;
 	data.count = 0;
 	ieee80211_iterate_stations_atomic(rtwdev->hw,
 					  rtw89_mac_bf_monitor_calc_iter,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index f2a31cba226e..b781b823496f 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -951,8 +951,9 @@ struct rtw89_mac_gen_def {
 	void (*dmac_func_pre_en)(struct rtw89_dev *rtwdev);
 	void (*dle_func_en)(struct rtw89_dev *rtwdev, bool enable);
 	void (*dle_clk_en)(struct rtw89_dev *rtwdev, bool enable);
-	void (*bf_assoc)(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
-			 struct ieee80211_sta *sta);
+	void (*bf_assoc)(struct rtw89_dev *rtwdev,
+			 struct rtw89_vif_link *rtwvif_link,
+			 struct rtw89_sta_link *rtwsta_link);
 
 	int (*typ_fltr_opt)(struct rtw89_dev *rtwdev,
 			    enum rtw89_machdr_frame_type type,
@@ -1259,21 +1260,24 @@ void rtw89_mac_power_mode_change(struct rtw89_dev *rtwdev, bool enter);
 void rtw89_mac_notify_wake(struct rtw89_dev *rtwdev);
 
 static inline
-void rtw89_mac_bf_assoc(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
-			struct ieee80211_sta *sta)
+void rtw89_mac_bf_assoc(struct rtw89_dev *rtwdev,
+			struct rtw89_vif_link *rtwvif_link,
+			struct rtw89_sta_link *rtwsta_link)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 
 	if (mac->bf_assoc)
-		mac->bf_assoc(rtwdev, vif, sta);
+		mac->bf_assoc(rtwdev, rtwvif_link, rtwsta_link);
 }
 
-void rtw89_mac_bf_disassoc(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
-			   struct ieee80211_sta *sta);
+void rtw89_mac_bf_disassoc(struct rtw89_dev *rtwdev,
+			   struct rtw89_vif_link *rtwvif_link,
+			   struct rtw89_sta_link *rtwsta_link);
 void rtw89_mac_bf_set_gid_table(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 				struct ieee80211_bss_conf *conf);
 void rtw89_mac_bf_monitor_calc(struct rtw89_dev *rtwdev,
-			       struct ieee80211_sta *sta, bool disconnect);
+			       struct rtw89_sta_link *rtwsta_link,
+			       bool disconnect);
 void _rtw89_mac_bf_monitor_track(struct rtw89_dev *rtwdev);
 void rtw89_mac_bfee_ctrl(struct rtw89_dev *rtwdev, u8 mac_idx, bool en);
 int rtw89_mac_vif_init(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link);
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index d3fad66e56cd..fc05ad1b799b 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -456,10 +456,140 @@ static void rtw89_conf_tx(struct rtw89_dev *rtwdev,
 		__rtw89_conf_tx(rtwdev, rtwvif_link, ac);
 }
 
+static int __rtw89_ops_sta_add(struct rtw89_dev *rtwdev,
+			       struct ieee80211_vif *vif,
+			       struct ieee80211_sta *sta)
+{
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
+	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
+	bool acquire_macid = false;
+	u8 macid;
+	int ret;
+	int i;
+
+	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls) {
+		/* for station mode, assign the mac_id from itself */
+		macid = rtwvif_link->mac_id;
+	} else {
+		macid = rtw89_acquire_mac_id(rtwdev);
+		if (macid == RTW89_MAX_MAC_ID_NUM)
+			return -ENOSPC;
+
+		acquire_macid = true;
+	}
+
+	rtwsta_link->rtwdev = rtwdev;
+	rtwsta_link->rtwvif_link = rtwvif_link;
+	rtwsta_link->mac_id = macid;
+
+	for (i = 0; i < ARRAY_SIZE(sta->txq); i++)
+		rtw89_core_txq_init(rtwdev, sta->txq[i]);
+
+	skb_queue_head_init(&rtwsta_link->roc_queue);
+
+	ret = rtw89_core_sta_link_add(rtwdev, rtwvif_link, rtwsta_link);
+	if (ret)
+		goto err;
+
+	if (vif->type == NL80211_IFTYPE_AP || sta->tdls)
+		rtw89_queue_chanctx_change(rtwdev, RTW89_CHANCTX_REMOTE_STA_CHANGE);
+
+	return 0;
+
+err:
+	if (acquire_macid)
+		rtw89_release_mac_id(rtwdev, macid);
+
+	return ret;
+}
+
+static int __rtw89_ops_sta_assoc(struct rtw89_dev *rtwdev,
+				 struct ieee80211_vif *vif,
+				 struct ieee80211_sta *sta,
+				 bool station_mode)
+{
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
+	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
+	int ret;
+
+	if (station_mode)
+		rtw89_vif_type_mapping(rtwvif_link, true);
+
+	ret = rtw89_core_sta_link_assoc(rtwdev, rtwvif_link, rtwsta_link);
+	if (ret)
+		return ret;
+
+	rtwdev->total_sta_assoc++;
+	if (sta->tdls)
+		rtwvif_link->tdls_peer++;
+
+	return 0;
+}
+
+static int __rtw89_ops_sta_disassoc(struct rtw89_dev *rtwdev,
+				    struct ieee80211_vif *vif,
+				    struct ieee80211_sta *sta)
+{
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
+	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
+	int ret;
+
+	ret = rtw89_core_sta_link_disassoc(rtwdev, rtwvif_link, rtwsta_link);
+	if (ret)
+		return ret;
+
+	rtwsta_link->disassoc = true;
+
+	rtwdev->total_sta_assoc--;
+	if (sta->tdls)
+		rtwvif_link->tdls_peer--;
+
+	return 0;
+}
+
+static int __rtw89_ops_sta_disconnect(struct rtw89_dev *rtwdev,
+				      struct ieee80211_vif *vif,
+				      struct ieee80211_sta *sta)
+{
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
+	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
+	int ret;
+
+	rtw89_core_free_sta_pending_ba(rtwdev, sta);
+	rtw89_core_free_sta_pending_forbid_ba(rtwdev, sta);
+	rtw89_core_free_sta_pending_roc_tx(rtwdev, sta);
+
+	ret = rtw89_core_sta_link_disconnect(rtwdev, rtwvif_link, rtwsta_link);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int __rtw89_ops_sta_remove(struct rtw89_dev *rtwdev,
+				  struct ieee80211_vif *vif,
+				  struct ieee80211_sta *sta)
+{
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
+	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
+	u8 macid = rtwsta_link->mac_id;
+	int ret;
+
+	ret = rtw89_core_sta_link_remove(rtwdev, rtwvif_link, rtwsta_link);
+	if (ret)
+		return ret;
+
+	if (vif->type == NL80211_IFTYPE_AP || sta->tdls) {
+		rtw89_release_mac_id(rtwdev, macid);
+		rtw89_queue_chanctx_change(rtwdev, RTW89_CHANCTX_REMOTE_STA_CHANGE);
+	}
+
+	return 0;
+}
+
 static void rtw89_station_mode_sta_assoc(struct rtw89_dev *rtwdev,
 					 struct ieee80211_vif *vif)
 {
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 	struct ieee80211_sta *sta;
 
 	if (vif->type != NL80211_IFTYPE_STATION)
@@ -471,9 +601,7 @@ static void rtw89_station_mode_sta_assoc(struct rtw89_dev *rtwdev,
 		return;
 	}
 
-	rtw89_vif_type_mapping(rtwvif_link, true);
-
-	rtw89_core_sta_assoc(rtwdev, vif, sta);
+	__rtw89_ops_sta_assoc(rtwdev, vif, sta, true);
 }
 
 static void __rtw89_ops_bss_link_assoc(struct rtw89_dev *rtwdev,
@@ -552,7 +680,7 @@ static void rtw89_ops_link_info_changed(struct ieee80211_hw *hw,
 		rtw89_core_update_p2p_ps(rtwdev, rtwvif_link, conf);
 
 	if (changed & BSS_CHANGED_CQM)
-		rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, vif, true);
+		rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, rtwvif_link, true);
 
 	if (changed & BSS_CHANGED_TPE)
 		rtw89_reg_6ghz_recalc(rtwdev, rtwvif_link, true);
@@ -582,7 +710,7 @@ static int rtw89_ops_start_ap(struct ieee80211_hw *hw,
 	ether_addr_copy(rtwvif_link->bssid, link_conf->bssid);
 	rtw89_cam_bssid_changed(rtwdev, rtwvif_link);
 	rtw89_mac_port_update(rtwdev, rtwvif_link);
-	rtw89_chip_h2c_assoc_cmac_tbl(rtwdev, vif, NULL);
+	rtw89_chip_h2c_assoc_cmac_tbl(rtwdev, rtwvif_link, NULL);
 	rtw89_fw_h2c_role_maintain(rtwdev, rtwvif_link, NULL, RTW89_ROLE_TYPE_CHANGE);
 	rtw89_fw_h2c_join_info(rtwdev, rtwvif_link, NULL, true);
 	rtw89_fw_h2c_cam(rtwdev, rtwvif_link, NULL, NULL);
@@ -603,7 +731,7 @@ void rtw89_ops_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	mutex_lock(&rtwdev->mutex);
 	rtw89_mac_stop_ap(rtwdev, rtwvif_link);
-	rtw89_chip_h2c_assoc_cmac_tbl(rtwdev, vif, NULL);
+	rtw89_chip_h2c_assoc_cmac_tbl(rtwdev, rtwvif_link, NULL);
 	rtw89_fw_h2c_join_info(rtwdev, rtwvif_link, NULL, true);
 	mutex_unlock(&rtwdev->mutex);
 }
@@ -647,26 +775,26 @@ static int __rtw89_ops_sta_state(struct ieee80211_hw *hw,
 
 	if (old_state == IEEE80211_STA_NOTEXIST &&
 	    new_state == IEEE80211_STA_NONE)
-		return rtw89_core_sta_add(rtwdev, vif, sta);
+		return __rtw89_ops_sta_add(rtwdev, vif, sta);
 
 	if (old_state == IEEE80211_STA_AUTH &&
 	    new_state == IEEE80211_STA_ASSOC) {
 		if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
 			return 0; /* defer to bss_info_changed to have vif info */
-		return rtw89_core_sta_assoc(rtwdev, vif, sta);
+		return __rtw89_ops_sta_assoc(rtwdev, vif, sta, false);
 	}
 
 	if (old_state == IEEE80211_STA_ASSOC &&
 	    new_state == IEEE80211_STA_AUTH)
-		return rtw89_core_sta_disassoc(rtwdev, vif, sta);
+		return __rtw89_ops_sta_disassoc(rtwdev, vif, sta);
 
 	if (old_state == IEEE80211_STA_AUTH &&
 	    new_state == IEEE80211_STA_NONE)
-		return rtw89_core_sta_disconnect(rtwdev, vif, sta);
+		return __rtw89_ops_sta_disconnect(rtwdev, vif, sta);
 
 	if (old_state == IEEE80211_STA_NONE &&
 	    new_state == IEEE80211_STA_NOTEXIST)
-		return rtw89_core_sta_remove(rtwdev, vif, sta);
+		return __rtw89_ops_sta_remove(rtwdev, vif, sta);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 184a014a56bf..f22eaa83297f 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -2091,11 +2091,9 @@ static int rtw89_mac_init_bfee_be(struct rtw89_dev *rtwdev, u8 mac_idx)
 }
 
 static int rtw89_mac_set_csi_para_reg_be(struct rtw89_dev *rtwdev,
-					 struct ieee80211_vif *vif,
-					 struct ieee80211_sta *sta)
+					 struct rtw89_vif_link *rtwvif_link,
+					 struct rtw89_sta_link *rtwsta_link)
 {
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
-	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
 	u8 nc = 1, nr = 3, ng = 0, cb = 1, cs = 1, ldpc_en = 1, stbc_en = 1;
 	struct ieee80211_link_sta *link_sta;
 	u8 mac_idx = rtwvif_link->mac_idx;
@@ -2162,11 +2160,9 @@ static int rtw89_mac_set_csi_para_reg_be(struct rtw89_dev *rtwdev,
 }
 
 static int rtw89_mac_csi_rrsc_be(struct rtw89_dev *rtwdev,
-				 struct ieee80211_vif *vif,
-				 struct ieee80211_sta *sta)
+				 struct rtw89_vif_link *rtwvif_link,
+				 struct rtw89_sta_link *rtwsta_link)
 {
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
-	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
 	u32 rrsc = BIT(RTW89_MAC_BF_RRSC_6M) | BIT(RTW89_MAC_BF_RRSC_24M);
 	struct ieee80211_link_sta *link_sta;
 	u8 mac_idx = rtwvif_link->mac_idx;
@@ -2210,11 +2206,9 @@ static int rtw89_mac_csi_rrsc_be(struct rtw89_dev *rtwdev,
 }
 
 static void rtw89_mac_bf_assoc_be(struct rtw89_dev *rtwdev,
-				  struct ieee80211_vif *vif,
-				  struct ieee80211_sta *sta)
+				  struct rtw89_vif_link *rtwvif_link,
+				  struct rtw89_sta_link *rtwsta_link)
 {
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
-	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
 	struct ieee80211_link_sta *link_sta;
 	bool has_beamformer_cap;
 
@@ -2229,8 +2223,8 @@ static void rtw89_mac_bf_assoc_be(struct rtw89_dev *rtwdev,
 		rtw89_debug(rtwdev, RTW89_DBG_BF,
 			    "initialize bfee for new association\n");
 		rtw89_mac_init_bfee_be(rtwdev, rtwvif_link->mac_idx);
-		rtw89_mac_set_csi_para_reg_be(rtwdev, vif, sta);
-		rtw89_mac_csi_rrsc_be(rtwdev, vif, sta);
+		rtw89_mac_set_csi_para_reg_be(rtwdev, rtwvif_link, rtwsta_link);
+		rtw89_mac_csi_rrsc_be(rtwdev, rtwvif_link, rtwsta_link);
 	}
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index f6f2b003c412..da9491213b7b 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -637,9 +637,8 @@ void rtw89_phy_ra_update(struct rtw89_dev *rtwdev)
 					  rtwdev);
 }
 
-void rtw89_phy_ra_assoc(struct rtw89_dev *rtwdev, struct ieee80211_sta *sta)
+void rtw89_phy_ra_assoc(struct rtw89_dev *rtwdev, struct rtw89_sta_link *rtwsta_link)
 {
-	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
 	struct rtw89_vif_link *rtwvif_link = rtwsta_link->rtwvif_link;
 	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
 	struct rtw89_ra_info *ra = &rtwsta_link->ra;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 882a473ecf7b..7e335c02ee6f 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -892,7 +892,7 @@ void rtw89_phy_set_txpwr_limit_ru(struct rtw89_dev *rtwdev,
 	phy->set_txpwr_limit_ru(rtwdev, chan, phy_idx);
 }
 
-void rtw89_phy_ra_assoc(struct rtw89_dev *rtwdev, struct ieee80211_sta *sta);
+void rtw89_phy_ra_assoc(struct rtw89_dev *rtwdev, struct rtw89_sta_link *rtwsta_link);
 void rtw89_phy_ra_update(struct rtw89_dev *rtwdev);
 void rtw89_phy_ra_update_sta(struct rtw89_dev *rtwdev, struct ieee80211_sta *sta,
 			     u32 changed);
diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index 20b776ae634e..97b527d04ad7 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -1240,7 +1240,7 @@ static int rtw89_wow_swap_fw(struct rtw89_dev *rtwdev, bool wow)
 		return ret;
 	}
 
-	ret = rtw89_chip_h2c_assoc_cmac_tbl(rtwdev, wow_vif, wow_sta);
+	ret = rtw89_chip_h2c_assoc_cmac_tbl(rtwdev, rtwvif_link, rtwsta_link);
 	if (ret) {
 		rtw89_warn(rtwdev, "failed to send h2c assoc cmac tbl\n");
 		return ret;
@@ -1267,7 +1267,7 @@ static int rtw89_wow_swap_fw(struct rtw89_dev *rtwdev, bool wow)
 			rtw89_warn(rtwdev, "failed to send h2c general packet\n");
 			return ret;
 		}
-		rtw89_phy_ra_assoc(rtwdev, wow_sta);
+		rtw89_phy_ra_assoc(rtwdev, rtwsta_link);
 		rtw89_phy_set_bss_color(rtwdev, rtwvif_link);
 		rtw89_chip_cfg_txpwr_ul_tb_offset(rtwdev, rtwvif_link);
 	}
@@ -1374,13 +1374,14 @@ static int rtw89_wow_disable_trx_post(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
 	struct ieee80211_vif *vif = rtw_wow->wow_vif;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 	int ret;
 
 	ret = rtw89_mac_cfg_ppdu_status(rtwdev, RTW89_MAC_0, true);
 	if (ret)
 		rtw89_err(rtwdev, "cfg ppdu status\n");
 
-	rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, vif, true);
+	rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, rtwvif_link, true);
 
 	return ret;
 }
-- 
2.25.1


