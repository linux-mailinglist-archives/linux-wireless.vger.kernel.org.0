Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF9D44D012
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Nov 2021 03:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbhKKCkT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Nov 2021 21:40:19 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:52887 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbhKKCkT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Nov 2021 21:40:19 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1AB2bQJ71008604, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1AB2bQJ71008604
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 11 Nov 2021 10:37:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 11 Nov 2021 10:37:26 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 11 Nov
 2021 10:37:25 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <phhuang@realtek.com>
Subject: [PATCH 1/2] rtw89: update scan_mac_addr during scanning period
Date:   Thu, 11 Nov 2021 10:37:05 +0800
Message-ID: <20211111023706.14154-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211111023706.14154-1-pkshih@realtek.com>
References: <20211111023706.14154-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 11/11/2021 02:24:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzExLzExIKRXpMggMTI6MjM6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 11/11/2021 02:21:48
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 167193 [Nov 11 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 465 465 eb31509370142567679dd183ac984a0cb2ee3296
X-KSE-AntiSpam-Info: {Tracking_all_Bitcoin, bb}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;realtek.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/11/2021 02:24:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Update scan_mac_addr to address CAM as A1, so hardware can ACK probe
response properly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/cam.c      | 22 ++++++++++---------
 drivers/net/wireless/realtek/rtw89/cam.h      |  3 ++-
 drivers/net/wireless/realtek/rtw89/core.c     |  4 ++--
 drivers/net/wireless/realtek/rtw89/fw.c       |  5 +++--
 drivers/net/wireless/realtek/rtw89/fw.h       |  3 ++-
 drivers/net/wireless/realtek/rtw89/mac.c      |  4 ++--
 drivers/net/wireless/realtek/rtw89/mac80211.c |  6 ++++-
 7 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/cam.c b/drivers/net/wireless/realtek/rtw89/cam.c
index ad7a8155dbed3..ce5056ad1e5c8 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.c
+++ b/drivers/net/wireless/realtek/rtw89/cam.c
@@ -243,7 +243,7 @@ static int rtw89_cam_attach_sec_cam(struct rtw89_dev *rtwdev,
 	addr_cam->sec_ent[key_idx] = sec_cam->sec_cam_idx;
 	addr_cam->sec_entries[key_idx] = sec_cam;
 	set_bit(key_idx, addr_cam->sec_cam_map);
-	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif);
+	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif, NULL);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to update addr cam sec entry: %d\n",
 			  ret);
@@ -394,7 +394,7 @@ int rtw89_cam_sec_key_del(struct rtw89_dev *rtwdev,
 	clear_bit(key_idx, addr_cam->sec_cam_map);
 	addr_cam->sec_entries[key_idx] = NULL;
 	if (inform_fw) {
-		ret = rtw89_fw_h2c_cam(rtwdev, rtwvif);
+		ret = rtw89_fw_h2c_cam(rtwdev, rtwvif, NULL);
 		if (ret)
 			rtw89_err(rtwdev, "failed to update cam del key: %d\n", ret);
 	}
@@ -593,7 +593,7 @@ int rtw89_cam_fill_bssid_cam_info(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
-static u8 rtw89_cam_addr_hash(u8 start, u8 *addr)
+static u8 rtw89_cam_addr_hash(u8 start, const u8 *addr)
 {
 	u8 hash = 0;
 	u8 i;
@@ -606,12 +606,14 @@ static u8 rtw89_cam_addr_hash(u8 start, u8 *addr)
 
 void rtw89_cam_fill_addr_cam_info(struct rtw89_dev *rtwdev,
 				  struct rtw89_vif *rtwvif,
+				  const u8 *scan_mac_addr,
 				  u8 *cmd)
 {
 	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
 	struct ieee80211_sta *sta;
 	struct rtw89_sta *rtwsta;
 	struct rtw89_addr_cam_entry *addr_cam = &rtwvif->addr_cam;
+	const u8 *sma = scan_mac_addr ? scan_mac_addr : rtwvif->mac_addr;
 	u8 sma_hash, tma_hash, addr_msk_start;
 	u8 sma_start = 0;
 	u8 tma_start = 0;
@@ -623,7 +625,7 @@ void rtw89_cam_fill_addr_cam_info(struct rtw89_dev *rtwdev,
 		else if (addr_cam->mask_sel == RTW89_TMA)
 			tma_start = addr_msk_start;
 	}
-	sma_hash = rtw89_cam_addr_hash(sma_start, rtwvif->mac_addr);
+	sma_hash = rtw89_cam_addr_hash(sma_start, sma);
 	tma_hash = rtw89_cam_addr_hash(tma_start, addr_cam->tma);
 
 	FWCMD_SET_ADDR_IDX(cmd, addr_cam->addr_cam_idx);
@@ -642,12 +644,12 @@ void rtw89_cam_fill_addr_cam_info(struct rtw89_dev *rtwdev,
 
 	FWCMD_SET_ADDR_BSSID_CAM_IDX(cmd, addr_cam->bssid_cam_idx);
 
-	FWCMD_SET_ADDR_SMA0(cmd, rtwvif->mac_addr[0]);
-	FWCMD_SET_ADDR_SMA1(cmd, rtwvif->mac_addr[1]);
-	FWCMD_SET_ADDR_SMA2(cmd, rtwvif->mac_addr[2]);
-	FWCMD_SET_ADDR_SMA3(cmd, rtwvif->mac_addr[3]);
-	FWCMD_SET_ADDR_SMA4(cmd, rtwvif->mac_addr[4]);
-	FWCMD_SET_ADDR_SMA5(cmd, rtwvif->mac_addr[5]);
+	FWCMD_SET_ADDR_SMA0(cmd, sma[0]);
+	FWCMD_SET_ADDR_SMA1(cmd, sma[1]);
+	FWCMD_SET_ADDR_SMA2(cmd, sma[2]);
+	FWCMD_SET_ADDR_SMA3(cmd, sma[3]);
+	FWCMD_SET_ADDR_SMA4(cmd, sma[4]);
+	FWCMD_SET_ADDR_SMA5(cmd, sma[5]);
 
 	FWCMD_SET_ADDR_TMA0(cmd, addr_cam->tma[0]);
 	FWCMD_SET_ADDR_TMA1(cmd, addr_cam->tma[1]);
diff --git a/drivers/net/wireless/realtek/rtw89/cam.h b/drivers/net/wireless/realtek/rtw89/cam.h
index 41d7d27120276..c0f9ef12f530a 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.h
+++ b/drivers/net/wireless/realtek/rtw89/cam.h
@@ -347,7 +347,8 @@ static inline void FWCMD_SET_ADDR_BSSID_BSSID5(void *cmd, u32 value)
 int rtw89_cam_init(struct rtw89_dev *rtwdev, struct rtw89_vif *vif);
 void rtw89_cam_deinit(struct rtw89_dev *rtwdev, struct rtw89_vif *vif);
 void rtw89_cam_fill_addr_cam_info(struct rtw89_dev *rtwdev,
-				  struct rtw89_vif *vif, u8 *cmd);
+				  struct rtw89_vif *vif,
+				  const u8 *scan_mac_addr, u8 *cmd);
 int rtw89_cam_fill_bssid_cam_info(struct rtw89_dev *rtwdev,
 				  struct rtw89_vif *vif, u8 *cmd);
 int rtw89_cam_sec_key_add(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index d02ec5a735cb1..6c91e99fd28f1 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1872,7 +1872,7 @@ int rtw89_core_sta_disconnect(struct rtw89_dev *rtwdev,
 	}
 
 	/* update cam aid mac_id net_type */
-	rtw89_fw_h2c_cam(rtwdev, rtwvif);
+	rtw89_fw_h2c_cam(rtwdev, rtwvif, NULL);
 	if (ret) {
 		rtw89_warn(rtwdev, "failed to send h2c cam\n");
 		return ret;
@@ -1908,7 +1908,7 @@ int rtw89_core_sta_assoc(struct rtw89_dev *rtwdev,
 	}
 
 	/* update cam aid mac_id net_type */
-	rtw89_fw_h2c_cam(rtwdev, rtwvif);
+	rtw89_fw_h2c_cam(rtwdev, rtwvif, NULL);
 	if (ret) {
 		rtw89_warn(rtwdev, "failed to send h2c cam\n");
 		return ret;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 65ef3dc9d0614..c9aa86e5d4e4b 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -523,7 +523,8 @@ void rtw89_unload_firmware(struct rtw89_dev *rtwdev)
 }
 
 #define H2C_CAM_LEN 60
-int rtw89_fw_h2c_cam(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+int rtw89_fw_h2c_cam(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+		     const u8 *scan_mac_addr)
 {
 	struct sk_buff *skb;
 
@@ -533,7 +534,7 @@ int rtw89_fw_h2c_cam(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 		return -ENOMEM;
 	}
 	skb_put(skb, H2C_CAM_LEN);
-	rtw89_cam_fill_addr_cam_info(rtwdev, rtwvif, skb->data);
+	rtw89_cam_fill_addr_cam_info(rtwdev, rtwvif, scan_mac_addr, skb->data);
 	rtw89_cam_fill_bssid_cam_info(rtwdev, rtwvif, skb->data);
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 3877c0eb7c580..7dee23574c5fc 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -1590,7 +1590,8 @@ int rtw89_fw_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
 				struct ieee80211_sta *sta);
 int rtw89_fw_h2c_txtime_cmac_tbl(struct rtw89_dev *rtwdev,
 				 struct rtw89_sta *rtwsta);
-int rtw89_fw_h2c_cam(struct rtw89_dev *rtwdev, struct rtw89_vif *vif);
+int rtw89_fw_h2c_cam(struct rtw89_dev *rtwdev, struct rtw89_vif *vif,
+		     const u8 *scan_mac_addr);
 void rtw89_fw_c2h_irqsafe(struct rtw89_dev *rtwdev, struct sk_buff *c2h);
 void rtw89_fw_c2h_work(struct work_struct *work);
 int rtw89_fw_h2c_vif_maintain(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index afcd07ab1de79..6a67ae46e22e5 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -2991,7 +2991,7 @@ int rtw89_mac_vif_init(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	if (ret)
 		return ret;
 
-	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif);
+	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif, NULL);
 	if (ret)
 		return ret;
 
@@ -3012,7 +3012,7 @@ int rtw89_mac_vif_deinit(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 
 	rtw89_cam_deinit(rtwdev, rtwvif);
 
-	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif);
+	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif, NULL);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 16dc6fb7dbb0b..16381adf006ec 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -336,7 +336,7 @@ static void rtw89_ops_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_BSSID) {
 		ether_addr_copy(rtwvif->bssid, conf->bssid);
 		rtw89_cam_bssid_changed(rtwdev, rtwvif);
-		rtw89_fw_h2c_cam(rtwdev, rtwvif);
+		rtw89_fw_h2c_cam(rtwdev, rtwvif, NULL);
 	}
 
 	if (changed & BSS_CHANGED_ERP_SLOT)
@@ -615,6 +615,7 @@ static void rtw89_ops_sw_scan_start(struct ieee80211_hw *hw,
 				    const u8 *mac_addr)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
 	struct rtw89_hal *hal = &rtwdev->hal;
 
 	mutex_lock(&rtwdev->mutex);
@@ -623,6 +624,7 @@ static void rtw89_ops_sw_scan_start(struct ieee80211_hw *hw,
 	rtw89_btc_ntfy_scan_start(rtwdev, RTW89_PHY_0, hal->current_band_type);
 	rtw89_chip_rfk_scan(rtwdev, true);
 	rtw89_hci_recalc_int_mit(rtwdev);
+	rtw89_fw_h2c_cam(rtwdev, rtwvif, mac_addr);
 	mutex_unlock(&rtwdev->mutex);
 }
 
@@ -630,8 +632,10 @@ static void rtw89_ops_sw_scan_complete(struct ieee80211_hw *hw,
 				       struct ieee80211_vif *vif)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
 
 	mutex_lock(&rtwdev->mutex);
+	rtw89_fw_h2c_cam(rtwdev, rtwvif, NULL);
 	rtw89_chip_rfk_scan(rtwdev, false);
 	rtw89_btc_ntfy_scan_finish(rtwdev, RTW89_PHY_0);
 	rtwdev->scanning = false;
-- 
2.25.1

