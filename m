Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF193464945
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Dec 2021 09:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243756AbhLAIKB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Dec 2021 03:10:01 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:38985 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237530AbhLAIKA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Dec 2021 03:10:00 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1B186YwB4031440, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1B186YwB4031440
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 1 Dec 2021 16:06:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 1 Dec 2021 16:06:34 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 1 Dec
 2021 16:06:34 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH] rtw89: fix sending wrong rtwsta->mac_id to firmware to fill address CAM
Date:   Wed, 1 Dec 2021 16:06:06 +0800
Message-ID: <20211201080607.11211-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 12/01/2021 07:51:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzEyLzEgpFekyCAwNjowMDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

With wrong rtwsta->mac_id, it can't send out ack properly when we receive
assoc response occasionally. Then, it failed to connect an AP.

The cause is that we store 'sta' and use it somewhere. To correct this,
remove the variable and use mac_id in drv_priv of 'sta' or 'vif' passed
by mac80211.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
This patch is followed by other two patchset with Awaiting Upstream state:
 1. [PATCH 0/2] rtw89: correct scan behavior and results
 2. [PATCH v3 0/3] rtw89: fix crash when loading firmware file on certain platforms  
---
 drivers/net/wireless/realtek/rtw89/cam.c      | 43 ++++++++-----------
 drivers/net/wireless/realtek/rtw89/cam.h      |  1 +
 drivers/net/wireless/realtek/rtw89/core.c     | 12 +++---
 drivers/net/wireless/realtek/rtw89/core.h     | 19 ++++----
 drivers/net/wireless/realtek/rtw89/fw.c       |  4 +-
 drivers/net/wireless/realtek/rtw89/fw.h       |  2 +-
 drivers/net/wireless/realtek/rtw89/mac.c      |  4 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c |  6 +--
 8 files changed, 43 insertions(+), 48 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/cam.c b/drivers/net/wireless/realtek/rtw89/cam.c
index ce5056ad1e5c8..bd34e4bbe107b 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.c
+++ b/drivers/net/wireless/realtek/rtw89/cam.c
@@ -219,6 +219,7 @@ static int rtw89_cam_attach_sec_cam(struct rtw89_dev *rtwdev,
 				    struct ieee80211_key_conf *key,
 				    struct rtw89_sec_cam_entry *sec_cam)
 {
+	struct rtw89_sta *rtwsta = sta_to_rtwsta_safe(sta);
 	struct rtw89_vif *rtwvif;
 	struct rtw89_addr_cam_entry *addr_cam;
 	u8 key_idx = 0;
@@ -243,7 +244,7 @@ static int rtw89_cam_attach_sec_cam(struct rtw89_dev *rtwdev,
 	addr_cam->sec_ent[key_idx] = sec_cam->sec_cam_idx;
 	addr_cam->sec_entries[key_idx] = sec_cam;
 	set_bit(key_idx, addr_cam->sec_cam_map);
-	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif, NULL);
+	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif, rtwsta, NULL);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to update addr cam sec entry: %d\n",
 			  ret);
@@ -371,6 +372,7 @@ int rtw89_cam_sec_key_del(struct rtw89_dev *rtwdev,
 			  struct ieee80211_key_conf *key,
 			  bool inform_fw)
 {
+	struct rtw89_sta *rtwsta = sta_to_rtwsta_safe(sta);
 	struct rtw89_cam_info *cam_info = &rtwdev->cam_info;
 	struct rtw89_vif *rtwvif;
 	struct rtw89_addr_cam_entry *addr_cam;
@@ -394,7 +396,7 @@ int rtw89_cam_sec_key_del(struct rtw89_dev *rtwdev,
 	clear_bit(key_idx, addr_cam->sec_cam_map);
 	addr_cam->sec_entries[key_idx] = NULL;
 	if (inform_fw) {
-		ret = rtw89_fw_h2c_cam(rtwdev, rtwvif, NULL);
+		ret = rtw89_fw_h2c_cam(rtwdev, rtwvif, rtwsta, NULL);
 		if (ret)
 			rtw89_err(rtwdev, "failed to update cam del key: %d\n", ret);
 	}
@@ -536,12 +538,8 @@ static int rtw89_cam_init_bssid_cam(struct rtw89_dev *rtwdev,
 
 void rtw89_cam_bssid_changed(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 {
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
-	struct rtw89_addr_cam_entry *addr_cam = &rtwvif->addr_cam;
 	struct rtw89_bssid_cam_entry *bssid_cam = &rtwvif->bssid_cam;
 
-	if (vif->type == NL80211_IFTYPE_STATION)
-		ether_addr_copy(addr_cam->tma, rtwvif->bssid);
 	ether_addr_copy(bssid_cam->bssid, rtwvif->bssid);
 }
 
@@ -606,17 +604,18 @@ static u8 rtw89_cam_addr_hash(u8 start, const u8 *addr)
 
 void rtw89_cam_fill_addr_cam_info(struct rtw89_dev *rtwdev,
 				  struct rtw89_vif *rtwvif,
+				  struct rtw89_sta *rtwsta,
 				  const u8 *scan_mac_addr,
 				  u8 *cmd)
 {
 	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
-	struct ieee80211_sta *sta;
-	struct rtw89_sta *rtwsta;
 	struct rtw89_addr_cam_entry *addr_cam = &rtwvif->addr_cam;
+	struct ieee80211_sta *sta = rtwsta_to_sta_safe(rtwsta);
 	const u8 *sma = scan_mac_addr ? scan_mac_addr : rtwvif->mac_addr;
 	u8 sma_hash, tma_hash, addr_msk_start;
 	u8 sma_start = 0;
 	u8 tma_start = 0;
+	u8 *tma = sta ? sta->addr : rtwvif->bssid;
 
 	if (addr_cam->addr_mask != 0) {
 		addr_msk_start = __ffs(addr_cam->addr_mask);
@@ -626,7 +625,7 @@ void rtw89_cam_fill_addr_cam_info(struct rtw89_dev *rtwdev,
 			tma_start = addr_msk_start;
 	}
 	sma_hash = rtw89_cam_addr_hash(sma_start, sma);
-	tma_hash = rtw89_cam_addr_hash(tma_start, addr_cam->tma);
+	tma_hash = rtw89_cam_addr_hash(tma_start, tma);
 
 	FWCMD_SET_ADDR_IDX(cmd, addr_cam->addr_cam_idx);
 	FWCMD_SET_ADDR_OFFSET(cmd, addr_cam->offset);
@@ -651,12 +650,12 @@ void rtw89_cam_fill_addr_cam_info(struct rtw89_dev *rtwdev,
 	FWCMD_SET_ADDR_SMA4(cmd, sma[4]);
 	FWCMD_SET_ADDR_SMA5(cmd, sma[5]);
 
-	FWCMD_SET_ADDR_TMA0(cmd, addr_cam->tma[0]);
-	FWCMD_SET_ADDR_TMA1(cmd, addr_cam->tma[1]);
-	FWCMD_SET_ADDR_TMA2(cmd, addr_cam->tma[2]);
-	FWCMD_SET_ADDR_TMA3(cmd, addr_cam->tma[3]);
-	FWCMD_SET_ADDR_TMA4(cmd, addr_cam->tma[4]);
-	FWCMD_SET_ADDR_TMA5(cmd, addr_cam->tma[5]);
+	FWCMD_SET_ADDR_TMA0(cmd, tma[0]);
+	FWCMD_SET_ADDR_TMA1(cmd, tma[1]);
+	FWCMD_SET_ADDR_TMA2(cmd, tma[2]);
+	FWCMD_SET_ADDR_TMA3(cmd, tma[3]);
+	FWCMD_SET_ADDR_TMA4(cmd, tma[4]);
+	FWCMD_SET_ADDR_TMA5(cmd, tma[5]);
 
 	FWCMD_SET_ADDR_PORT_INT(cmd, rtwvif->port);
 	FWCMD_SET_ADDR_TSF_SYNC(cmd, rtwvif->port);
@@ -664,15 +663,11 @@ void rtw89_cam_fill_addr_cam_info(struct rtw89_dev *rtwdev,
 	FWCMD_SET_ADDR_LSIG_TXOP(cmd, rtwvif->lsig_txop);
 	FWCMD_SET_ADDR_TGT_IND(cmd, rtwvif->tgt_ind);
 	FWCMD_SET_ADDR_FRM_TGT_IND(cmd, rtwvif->frm_tgt_ind);
-
-	if (vif->type == NL80211_IFTYPE_STATION) {
-		sta = rtwvif->mgd.ap;
-		if (sta) {
-			rtwsta = (struct rtw89_sta *)sta->drv_priv;
-			FWCMD_SET_ADDR_MACID(cmd, rtwsta->mac_id);
-			FWCMD_SET_ADDR_AID12(cmd, vif->bss_conf.aid & 0xfff);
-		}
-	}
+	FWCMD_SET_ADDR_MACID(cmd, rtwsta ? rtwsta->mac_id : rtwvif->mac_id);
+	if (rtwvif->net_type == RTW89_NET_TYPE_INFRA)
+		FWCMD_SET_ADDR_AID12(cmd, vif->bss_conf.aid & 0xfff);
+	else if (rtwvif->net_type == RTW89_NET_TYPE_AP_MODE)
+		FWCMD_SET_ADDR_AID12(cmd, sta ? sta->aid & 0xfff : 0);
 	FWCMD_SET_ADDR_WOL_PATTERN(cmd, rtwvif->wowlan_pattern);
 	FWCMD_SET_ADDR_WOL_UC(cmd, rtwvif->wowlan_uc);
 	FWCMD_SET_ADDR_WOL_MAGIC(cmd, rtwvif->wowlan_magic);
diff --git a/drivers/net/wireless/realtek/rtw89/cam.h b/drivers/net/wireless/realtek/rtw89/cam.h
index c0f9ef12f530a..33a3ad582b818 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.h
+++ b/drivers/net/wireless/realtek/rtw89/cam.h
@@ -348,6 +348,7 @@ int rtw89_cam_init(struct rtw89_dev *rtwdev, struct rtw89_vif *vif);
 void rtw89_cam_deinit(struct rtw89_dev *rtwdev, struct rtw89_vif *vif);
 void rtw89_cam_fill_addr_cam_info(struct rtw89_dev *rtwdev,
 				  struct rtw89_vif *vif,
+				  struct rtw89_sta *rtwsta,
 				  const u8 *scan_mac_addr, u8 *cmd);
 int rtw89_cam_fill_bssid_cam_info(struct rtw89_dev *rtwdev,
 				  struct rtw89_vif *vif, u8 *cmd);
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 2c079388a664e..8212496ae9ef7 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1854,7 +1854,8 @@ int rtw89_core_sta_add(struct rtw89_dev *rtwdev,
 	ewma_rssi_init(&rtwsta->avg_rssi);
 
 	if (vif->type == NL80211_IFTYPE_STATION) {
-		rtwvif->mgd.ap = sta;
+		/* for station mode, assign the mac_id from itself */
+		rtwsta->mac_id = rtwvif->mac_id;
 		rtw89_btc_ntfy_role_info(rtwdev, rtwvif, rtwsta,
 					 BTC_ROLE_MSTS_STA_CONN_START);
 		rtw89_chip_rfk_channel(rtwdev);
@@ -1880,6 +1881,7 @@ int rtw89_core_sta_disconnect(struct rtw89_dev *rtwdev,
 			      struct ieee80211_sta *sta)
 {
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
 	int ret;
 
 	rtw89_mac_bf_monitor_calc(rtwdev, sta, true);
@@ -1901,7 +1903,7 @@ int rtw89_core_sta_disconnect(struct rtw89_dev *rtwdev,
 	}
 
 	/* update cam aid mac_id net_type */
-	rtw89_fw_h2c_cam(rtwdev, rtwvif, NULL);
+	rtw89_fw_h2c_cam(rtwdev, rtwvif, rtwsta, NULL);
 	if (ret) {
 		rtw89_warn(rtwdev, "failed to send h2c cam\n");
 		return ret;
@@ -1926,10 +1928,6 @@ int rtw89_core_sta_assoc(struct rtw89_dev *rtwdev,
 		return ret;
 	}
 
-	/* for station mode, assign the mac_id from itself */
-	if (vif->type == NL80211_IFTYPE_STATION)
-		rtwsta->mac_id = rtwvif->mac_id;
-
 	ret = rtw89_fw_h2c_join_info(rtwdev, rtwvif, 0);
 	if (ret) {
 		rtw89_warn(rtwdev, "failed to send h2c join info\n");
@@ -1937,7 +1935,7 @@ int rtw89_core_sta_assoc(struct rtw89_dev *rtwdev,
 	}
 
 	/* update cam aid mac_id net_type */
-	rtw89_fw_h2c_cam(rtwdev, rtwvif, NULL);
+	rtw89_fw_h2c_cam(rtwdev, rtwvif, rtwsta, NULL);
 	if (ret) {
 		rtw89_warn(rtwdev, "failed to send h2c cam\n");
 		return ret;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 01cc6d9ce428b..52e13f79805d5 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1868,7 +1868,6 @@ struct rtw89_addr_cam_entry {
 	u8 wapi		: 1;
 	u8 mask_sel	: 2;
 	u8 bssid_cam_idx: 6;
-	u8 tma[ETH_ALEN];
 	u8 sma[ETH_ALEN];
 
 	u8 sec_ent_mode;
@@ -1937,14 +1936,6 @@ struct rtw89_vif {
 	bool wowlan_magic;
 	bool is_hesta;
 	bool last_a_ctrl;
-	union {
-		struct {
-			struct ieee80211_sta *ap;
-		} mgd;
-		struct {
-			struct list_head sta_list;
-		} ap;
-	};
 	struct rtw89_addr_cam_entry addr_cam;
 	struct rtw89_bssid_cam_entry bssid_cam;
 	struct ieee80211_tx_queue_params tx_params[IEEE80211_NUM_ACS];
@@ -3131,6 +3122,16 @@ static inline struct ieee80211_sta *rtwsta_to_sta(struct rtw89_sta *rtwsta)
 	return container_of(p, struct ieee80211_sta, drv_priv);
 }
 
+static inline struct ieee80211_sta *rtwsta_to_sta_safe(struct rtw89_sta *rtwsta)
+{
+	return rtwsta ? rtwsta_to_sta(rtwsta) : NULL;
+}
+
+static inline struct rtw89_sta *sta_to_rtwsta_safe(struct ieee80211_sta *sta)
+{
+	return sta ? (struct rtw89_sta *)sta->drv_priv : NULL;
+}
+
 static inline
 void rtw89_chip_set_channel_prepare(struct rtw89_dev *rtwdev,
 				    struct rtw89_channel_help_params *p)
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index c9aa86e5d4e4b..d4b59fbe73659 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -524,7 +524,7 @@ void rtw89_unload_firmware(struct rtw89_dev *rtwdev)
 
 #define H2C_CAM_LEN 60
 int rtw89_fw_h2c_cam(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
-		     const u8 *scan_mac_addr)
+		     struct rtw89_sta *rtwsta, const u8 *scan_mac_addr)
 {
 	struct sk_buff *skb;
 
@@ -534,7 +534,7 @@ int rtw89_fw_h2c_cam(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 		return -ENOMEM;
 	}
 	skb_put(skb, H2C_CAM_LEN);
-	rtw89_cam_fill_addr_cam_info(rtwdev, rtwvif, scan_mac_addr, skb->data);
+	rtw89_cam_fill_addr_cam_info(rtwdev, rtwvif, rtwsta, scan_mac_addr, skb->data);
 	rtw89_cam_fill_bssid_cam_info(rtwdev, rtwvif, skb->data);
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 865170a89c4ae..2d36dc27222ff 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -1757,7 +1757,7 @@ int rtw89_fw_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
 int rtw89_fw_h2c_txtime_cmac_tbl(struct rtw89_dev *rtwdev,
 				 struct rtw89_sta *rtwsta);
 int rtw89_fw_h2c_cam(struct rtw89_dev *rtwdev, struct rtw89_vif *vif,
-		     const u8 *scan_mac_addr);
+		     struct rtw89_sta *rtwsta, const u8 *scan_mac_addr);
 void rtw89_fw_c2h_irqsafe(struct rtw89_dev *rtwdev, struct sk_buff *c2h);
 void rtw89_fw_c2h_work(struct work_struct *work);
 int rtw89_fw_h2c_vif_maintain(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 6a67ae46e22e5..f8bb5517e8085 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -2991,7 +2991,7 @@ int rtw89_mac_vif_init(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	if (ret)
 		return ret;
 
-	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif, NULL);
+	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif, NULL, NULL);
 	if (ret)
 		return ret;
 
@@ -3012,7 +3012,7 @@ int rtw89_mac_vif_deinit(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 
 	rtw89_cam_deinit(rtwdev, rtwvif);
 
-	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif, NULL);
+	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif, NULL, NULL);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 16381adf006ec..757685de6b072 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -336,7 +336,7 @@ static void rtw89_ops_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_BSSID) {
 		ether_addr_copy(rtwvif->bssid, conf->bssid);
 		rtw89_cam_bssid_changed(rtwdev, rtwvif);
-		rtw89_fw_h2c_cam(rtwdev, rtwvif, NULL);
+		rtw89_fw_h2c_cam(rtwdev, rtwvif, NULL, NULL);
 	}
 
 	if (changed & BSS_CHANGED_ERP_SLOT)
@@ -624,7 +624,7 @@ static void rtw89_ops_sw_scan_start(struct ieee80211_hw *hw,
 	rtw89_btc_ntfy_scan_start(rtwdev, RTW89_PHY_0, hal->current_band_type);
 	rtw89_chip_rfk_scan(rtwdev, true);
 	rtw89_hci_recalc_int_mit(rtwdev);
-	rtw89_fw_h2c_cam(rtwdev, rtwvif, mac_addr);
+	rtw89_fw_h2c_cam(rtwdev, rtwvif, NULL, mac_addr);
 	mutex_unlock(&rtwdev->mutex);
 }
 
@@ -635,7 +635,7 @@ static void rtw89_ops_sw_scan_complete(struct ieee80211_hw *hw,
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
 
 	mutex_lock(&rtwdev->mutex);
-	rtw89_fw_h2c_cam(rtwdev, rtwvif, NULL);
+	rtw89_fw_h2c_cam(rtwdev, rtwvif, NULL, NULL);
 	rtw89_chip_rfk_scan(rtwdev, false);
 	rtw89_btc_ntfy_scan_finish(rtwdev, RTW89_PHY_0);
 	rtwdev->scanning = false;
-- 
2.25.1

