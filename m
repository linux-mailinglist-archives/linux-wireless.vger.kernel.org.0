Return-Path: <linux-wireless+bounces-12876-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAFA979AC9
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2024 07:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 787502828BA
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2024 05:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848EA33991;
	Mon, 16 Sep 2024 05:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="uSL/qN+W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E2B134BD
	for <linux-wireless@vger.kernel.org>; Mon, 16 Sep 2024 05:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726464780; cv=none; b=DjX2EtcSuXJNg/INW2vjOO4vYtIFqOyQUPdkKw3SeD81ljInzHCznUt0IuooRUfkTa+s2wu9Hn+PozSjrIwCPKw/BdEqaol7Z72/sZOYeXCWkA/PUoUdkrmAee5jFcB6WI8R14ZRAI6sFLGTemufUOL4XmF51Sb0HdMJDtyrE6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726464780; c=relaxed/simple;
	bh=xlkUsJuTAzu4LLBmojref7mf+p/74JaHF1kYkWZzDik=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mL0KNR/RTIO/hV4zi41SoZW8ktdCoh5eNDFfA+bHtvFoGj8RLrt8ANQ20CVqnWBfKRxVPHlfAoUs3ZXcP6aRW9rQolMkGaBXIZXAj9B1KkEKBWrdjqydYchmd9HKBtdqHCi/T7B8xrHNM7rwv4Xz0jBkC2Q3uT9WiA+ikQZ61BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=uSL/qN+W; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48G5WqH422631690, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1726464772; bh=xlkUsJuTAzu4LLBmojref7mf+p/74JaHF1kYkWZzDik=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=uSL/qN+WeIXoIgoNxfBSDEOg/HgeuPCAXdOMvepOipkof4BkePd6gVgdVujUbYA/J
	 CBNzuBEx9v4ESS/COHfwZKIoIoz37WUdfusnDbbgg9M8PnrD/r0ipMg4zrpi6VJ5JU
	 SdVUbeHPKvtFPfbh5gykZYoHaNLRxD7B1Nw41oNUKJ2l7/ooW3+PJDKPMeMeWuWTeG
	 lo8DsH3RVwrO37A85Efz+LEz/SnpXnAUWlp8B3xHS6JqbKOksB1u5LQDZXtY7/sZuF
	 IfxsdxDp7mNob6vGrVtB5tJFCDDCmk8i4aVbyj83eqGAxVeVSvLHq2PVRsYHpAni15
	 PuPk3V7Yocfqw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48G5WqH422631690
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 16 Sep 2024 13:32:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Sep 2024 13:32:52 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 16 Sep
 2024 13:32:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 2/7] wifi: rtw89: rename rtw89_sta to rtw89_sta_link ahead for MLO
Date: Mon, 16 Sep 2024 13:31:53 +0800
Message-ID: <20240916053158.47350-3-pkshih@realtek.com>
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

This is an intermediate version that is separated from subsequent major
MLO changes, so some functions' namings are not really determined here.
e.g. struct rtw89_sta_link *sta_to_rtwsta_safe(struct ieee80211_sta *sta)

No logic is changed.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/cam.c      |  43 ++--
 drivers/net/wireless/realtek/rtw89/cam.h      |   8 +-
 drivers/net/wireless/realtek/rtw89/chan.c     |   6 +-
 drivers/net/wireless/realtek/rtw89/coex.c     |  57 +++---
 drivers/net/wireless/realtek/rtw89/coex.h     |   3 +-
 drivers/net/wireless/realtek/rtw89/core.c     | 193 +++++++++---------
 drivers/net/wireless/realtek/rtw89/core.h     |  48 ++---
 drivers/net/wireless/realtek/rtw89/debug.c    |  50 ++---
 drivers/net/wireless/realtek/rtw89/fw.c       | 102 ++++-----
 drivers/net/wireless/realtek/rtw89/fw.h       |  36 ++--
 drivers/net/wireless/realtek/rtw89/mac.c      |  60 +++---
 drivers/net/wireless/realtek/rtw89/mac.h      |   8 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c |  39 ++--
 drivers/net/wireless/realtek/rtw89/phy.c      |  80 ++++----
 drivers/net/wireless/realtek/rtw89/ser.c      |  10 +-
 drivers/net/wireless/realtek/rtw89/wow.c      |  20 +-
 16 files changed, 392 insertions(+), 371 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/cam.c b/drivers/net/wireless/realtek/rtw89/cam.c
index a3e6d40b3078..80deb0712b83 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.c
+++ b/drivers/net/wireless/realtek/rtw89/cam.c
@@ -217,7 +217,7 @@ static int rtw89_cam_detach_sec_cam(struct rtw89_dev *rtwdev,
 				    const struct rtw89_sec_cam_entry *sec_cam,
 				    bool inform_fw)
 {
-	struct rtw89_sta *rtwsta = sta_to_rtwsta_safe(sta);
+	struct rtw89_sta_link *rtwsta_link = sta_to_rtwsta_safe(sta);
 	struct rtw89_vif_link *rtwvif_link;
 	struct rtw89_addr_cam_entry *addr_cam;
 	unsigned int i;
@@ -229,7 +229,7 @@ static int rtw89_cam_detach_sec_cam(struct rtw89_dev *rtwdev,
 	}
 
 	rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
-	addr_cam = rtw89_get_addr_cam_of(rtwvif_link, rtwsta);
+	addr_cam = rtw89_get_addr_cam_of(rtwvif_link, rtwsta_link);
 
 	for_each_set_bit(i, addr_cam->sec_cam_map, RTW89_SEC_CAM_IN_ADDR_CAM) {
 		if (addr_cam->sec_ent[i] != sec_cam->sec_cam_idx)
@@ -239,11 +239,11 @@ static int rtw89_cam_detach_sec_cam(struct rtw89_dev *rtwdev,
 	}
 
 	if (inform_fw) {
-		ret = rtw89_chip_h2c_dctl_sec_cam(rtwdev, rtwvif_link, rtwsta);
+		ret = rtw89_chip_h2c_dctl_sec_cam(rtwdev, rtwvif_link, rtwsta_link);
 		if (ret)
 			rtw89_err(rtwdev,
 				  "failed to update dctl cam del key: %d\n", ret);
-		ret = rtw89_fw_h2c_cam(rtwdev, rtwvif_link, rtwsta, NULL);
+		ret = rtw89_fw_h2c_cam(rtwdev, rtwvif_link, rtwsta_link, NULL);
 		if (ret)
 			rtw89_err(rtwdev, "failed to update cam del key: %d\n", ret);
 	}
@@ -257,7 +257,7 @@ static int rtw89_cam_attach_sec_cam(struct rtw89_dev *rtwdev,
 				    struct ieee80211_key_conf *key,
 				    struct rtw89_sec_cam_entry *sec_cam)
 {
-	struct rtw89_sta *rtwsta = sta_to_rtwsta_safe(sta);
+	struct rtw89_sta_link *rtwsta_link = sta_to_rtwsta_safe(sta);
 	struct rtw89_vif_link *rtwvif_link;
 	struct rtw89_addr_cam_entry *addr_cam;
 	u8 key_idx = 0;
@@ -269,7 +269,7 @@ static int rtw89_cam_attach_sec_cam(struct rtw89_dev *rtwdev,
 	}
 
 	rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
-	addr_cam = rtw89_get_addr_cam_of(rtwvif_link, rtwsta);
+	addr_cam = rtw89_get_addr_cam_of(rtwvif_link, rtwsta_link);
 
 	if (key->cipher == WLAN_CIPHER_SUITE_WEP40 ||
 	    key->cipher == WLAN_CIPHER_SUITE_WEP104)
@@ -285,13 +285,13 @@ static int rtw89_cam_attach_sec_cam(struct rtw89_dev *rtwdev,
 	addr_cam->sec_ent_keyid[key_idx] = key->keyidx;
 	addr_cam->sec_ent[key_idx] = sec_cam->sec_cam_idx;
 	set_bit(key_idx, addr_cam->sec_cam_map);
-	ret = rtw89_chip_h2c_dctl_sec_cam(rtwdev, rtwvif_link, rtwsta);
+	ret = rtw89_chip_h2c_dctl_sec_cam(rtwdev, rtwvif_link, rtwsta_link);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to update dctl cam sec entry: %d\n",
 			  ret);
 		return ret;
 	}
-	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif_link, rtwsta, NULL);
+	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif_link, rtwsta_link, NULL);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to update addr cam sec entry: %d\n",
 			  ret);
@@ -653,11 +653,11 @@ int rtw89_cam_init(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link)
 
 int rtw89_cam_fill_bssid_cam_info(struct rtw89_dev *rtwdev,
 				  struct rtw89_vif_link *rtwvif_link,
-				  struct rtw89_sta *rtwsta, u8 *cmd)
+				  struct rtw89_sta_link *rtwsta_link, u8 *cmd)
 {
 	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
 	struct rtw89_bssid_cam_entry *bssid_cam = rtw89_get_bssid_cam_of(rtwvif_link,
-									 rtwsta);
+									 rtwsta_link);
 	u8 bss_color = vif->bss_conf.he_bss_color.color;
 	u8 bss_mask;
 
@@ -697,14 +697,14 @@ static u8 rtw89_cam_addr_hash(u8 start, const u8 *addr)
 
 void rtw89_cam_fill_addr_cam_info(struct rtw89_dev *rtwdev,
 				  struct rtw89_vif_link *rtwvif_link,
-				  struct rtw89_sta *rtwsta,
+				  struct rtw89_sta_link *rtwsta_link,
 				  const u8 *scan_mac_addr,
 				  u8 *cmd)
 {
 	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
 	struct rtw89_addr_cam_entry *addr_cam =
-		rtw89_get_addr_cam_of(rtwvif_link, rtwsta);
-	struct ieee80211_sta *sta = rtwsta_to_sta_safe(rtwsta);
+		rtw89_get_addr_cam_of(rtwvif_link, rtwsta_link);
+	struct ieee80211_sta *sta = rtwsta_to_sta_safe(rtwsta_link);
 	const u8 *sma = scan_mac_addr ? scan_mac_addr : rtwvif_link->mac_addr;
 	u8 sma_hash, tma_hash, addr_msk_start;
 	u8 sma_start = 0;
@@ -757,7 +757,8 @@ void rtw89_cam_fill_addr_cam_info(struct rtw89_dev *rtwdev,
 	FWCMD_SET_ADDR_LSIG_TXOP(cmd, rtwvif_link->lsig_txop);
 	FWCMD_SET_ADDR_TGT_IND(cmd, rtwvif_link->tgt_ind);
 	FWCMD_SET_ADDR_FRM_TGT_IND(cmd, rtwvif_link->frm_tgt_ind);
-	FWCMD_SET_ADDR_MACID(cmd, rtwsta ? rtwsta->mac_id : rtwvif_link->mac_id);
+	FWCMD_SET_ADDR_MACID(cmd, rtwsta_link ? rtwsta_link->mac_id :
+						rtwvif_link->mac_id);
 	if (rtwvif_link->net_type == RTW89_NET_TYPE_INFRA)
 		FWCMD_SET_ADDR_AID12(cmd, vif->cfg.aid & 0xfff);
 	else if (rtwvif_link->net_type == RTW89_NET_TYPE_AP_MODE)
@@ -787,15 +788,16 @@ void rtw89_cam_fill_addr_cam_info(struct rtw89_dev *rtwdev,
 
 void rtw89_cam_fill_dctl_sec_cam_info_v1(struct rtw89_dev *rtwdev,
 					 struct rtw89_vif_link *rtwvif_link,
-					 struct rtw89_sta *rtwsta,
+					 struct rtw89_sta_link *rtwsta_link,
 					 struct rtw89_h2c_dctlinfo_ud_v1 *h2c)
 {
 	struct rtw89_addr_cam_entry *addr_cam =
-		rtw89_get_addr_cam_of(rtwvif_link, rtwsta);
+		rtw89_get_addr_cam_of(rtwvif_link, rtwsta_link);
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
 	u8 *ptk_tx_iv = rtw_wow->key_info.ptk_tx_iv;
 
-	h2c->c0 = le32_encode_bits(rtwsta ? rtwsta->mac_id : rtwvif_link->mac_id,
+	h2c->c0 = le32_encode_bits(rtwsta_link ? rtwsta_link->mac_id :
+						 rtwvif_link->mac_id,
 				   DCTLINFO_V1_C0_MACID) |
 		  le32_encode_bits(1, DCTLINFO_V1_C0_OP);
 
@@ -867,15 +869,16 @@ void rtw89_cam_fill_dctl_sec_cam_info_v1(struct rtw89_dev *rtwdev,
 
 void rtw89_cam_fill_dctl_sec_cam_info_v2(struct rtw89_dev *rtwdev,
 					 struct rtw89_vif_link *rtwvif_link,
-					 struct rtw89_sta *rtwsta,
+					 struct rtw89_sta_link *rtwsta_link,
 					 struct rtw89_h2c_dctlinfo_ud_v2 *h2c)
 {
 	struct rtw89_addr_cam_entry *addr_cam =
-		rtw89_get_addr_cam_of(rtwvif_link, rtwsta);
+		rtw89_get_addr_cam_of(rtwvif_link, rtwsta_link);
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
 	u8 *ptk_tx_iv = rtw_wow->key_info.ptk_tx_iv;
 
-	h2c->c0 = le32_encode_bits(rtwsta ? rtwsta->mac_id : rtwvif_link->mac_id,
+	h2c->c0 = le32_encode_bits(rtwsta_link ? rtwsta_link->mac_id :
+						 rtwvif_link->mac_id,
 				   DCTLINFO_V2_C0_MACID) |
 		  le32_encode_bits(1, DCTLINFO_V2_C0_OP);
 
diff --git a/drivers/net/wireless/realtek/rtw89/cam.h b/drivers/net/wireless/realtek/rtw89/cam.h
index 18ede69144b6..a6f72edd30fe 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.h
+++ b/drivers/net/wireless/realtek/rtw89/cam.h
@@ -541,19 +541,19 @@ void rtw89_cam_deinit_bssid_cam(struct rtw89_dev *rtwdev,
 				struct rtw89_bssid_cam_entry *bssid_cam);
 void rtw89_cam_fill_addr_cam_info(struct rtw89_dev *rtwdev,
 				  struct rtw89_vif_link *vif,
-				  struct rtw89_sta *rtwsta,
+				  struct rtw89_sta_link *rtwsta_link,
 				  const u8 *scan_mac_addr, u8 *cmd);
 void rtw89_cam_fill_dctl_sec_cam_info_v1(struct rtw89_dev *rtwdev,
 					 struct rtw89_vif_link *rtwvif_link,
-					 struct rtw89_sta *rtwsta,
+					 struct rtw89_sta_link *rtwsta_link,
 					 struct rtw89_h2c_dctlinfo_ud_v1 *h2c);
 void rtw89_cam_fill_dctl_sec_cam_info_v2(struct rtw89_dev *rtwdev,
 					 struct rtw89_vif_link *rtwvif_link,
-					 struct rtw89_sta *rtwsta,
+					 struct rtw89_sta_link *rtwsta_link,
 					 struct rtw89_h2c_dctlinfo_ud_v2 *h2c);
 int rtw89_cam_fill_bssid_cam_info(struct rtw89_dev *rtwdev,
 				  struct rtw89_vif_link *rtwvif_link,
-				  struct rtw89_sta *rtwsta, u8 *cmd);
+				  struct rtw89_sta_link *rtwsta_link, u8 *cmd);
 int rtw89_cam_sec_key_add(struct rtw89_dev *rtwdev,
 			  struct ieee80211_vif *vif,
 			  struct ieee80211_sta *sta,
diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index f20431c3e201..2f14ac668716 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -522,15 +522,15 @@ u32 rtw89_mcc_role_fw_macid_bitmap_to_u32(struct rtw89_mcc_role *mcc_role)
 
 static void rtw89_mcc_role_macid_sta_iter(void *data, struct ieee80211_sta *sta)
 {
-	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
-	struct rtw89_vif_link *rtwvif_link = rtwsta->rtwvif_link;
+	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = rtwsta_link->rtwvif_link;
 	struct rtw89_mcc_role *mcc_role = data;
 	struct rtw89_vif_link *target = mcc_role->rtwvif_link;
 
 	if (rtwvif_link != target)
 		return;
 
-	rtw89_mcc_role_fw_macid_bitmap_set_bit(mcc_role, rtwsta->mac_id);
+	rtw89_mcc_role_fw_macid_bitmap_set_bit(mcc_role, rtwsta_link->mac_id);
 }
 
 static void rtw89_mcc_fill_role_macid_bitmap(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index af9f975983ae..174e79b73352 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -4991,11 +4991,11 @@ struct rtw89_txtime_data {
 
 static void rtw89_tx_time_iter(void *data, struct ieee80211_sta *sta)
 {
-	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
+	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
 	struct rtw89_txtime_data *iter_data =
 				(struct rtw89_txtime_data *)data;
 	struct rtw89_dev *rtwdev = iter_data->rtwdev;
-	struct rtw89_vif_link *rtwvif_link = rtwsta->rtwvif_link;
+	struct rtw89_vif_link *rtwvif_link = rtwsta_link->rtwvif_link;
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_cx *cx = &btc->cx;
 	struct rtw89_btc_wl_info *wl = &cx->wl;
@@ -5023,8 +5023,8 @@ static void rtw89_tx_time_iter(void *data, struct ieee80211_sta *sta)
 
 	/* backup the original tx time before tx-limit on */
 	if (reenable) {
-		rtw89_mac_get_tx_time(rtwdev, rtwsta, &plink->tx_time);
-		rtw89_mac_get_tx_retry_limit(rtwdev, rtwsta, &plink->tx_retry);
+		rtw89_mac_get_tx_time(rtwdev, rtwsta_link, &plink->tx_time);
+		rtw89_mac_get_tx_retry_limit(rtwdev, rtwsta_link, &plink->tx_retry);
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
 			    "[BTC], %s(): reenable, tx_time=%d tx_retry= %d\n",
 			    __func__, plink->tx_time, plink->tx_retry);
@@ -5032,16 +5032,16 @@ static void rtw89_tx_time_iter(void *data, struct ieee80211_sta *sta)
 
 	/* restore the original tx time if no tx-limit */
 	if (!enable) {
-		rtw89_mac_set_tx_time(rtwdev, rtwsta, true, plink->tx_time);
-		rtw89_mac_set_tx_retry_limit(rtwdev, rtwsta, true,
+		rtw89_mac_set_tx_time(rtwdev, rtwsta_link, true, plink->tx_time);
+		rtw89_mac_set_tx_retry_limit(rtwdev, rtwsta_link, true,
 					     plink->tx_retry);
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
 			    "[BTC], %s(): restore, tx_time=%d tx_retry= %d\n",
 			    __func__, plink->tx_time, plink->tx_retry);
 
 	} else {
-		rtw89_mac_set_tx_time(rtwdev, rtwsta, false, tx_time);
-		rtw89_mac_set_tx_retry_limit(rtwdev, rtwsta, false, tx_retry);
+		rtw89_mac_set_tx_time(rtwdev, rtwsta_link, false, tx_time);
+		rtw89_mac_set_tx_retry_limit(rtwdev, rtwsta_link, false, tx_retry);
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
 			    "[BTC], %s(): set, tx_time=%d tx_retry= %d\n",
 			    __func__, tx_time, tx_retry);
@@ -7481,12 +7481,13 @@ static void _update_bt_info(struct rtw89_dev *rtwdev, u8 *buf, u32 len)
 
 void rtw89_btc_ntfy_role_info(struct rtw89_dev *rtwdev,
 			      struct rtw89_vif_link *rtwvif_link,
-			      struct rtw89_sta *rtwsta, enum btc_role_state state)
+			      struct rtw89_sta_link *rtwsta_link,
+			      enum btc_role_state state)
 {
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
 						       rtwvif_link->chanctx_idx);
 	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
-	struct ieee80211_sta *sta = rtwsta_to_sta(rtwsta);
+	struct ieee80211_sta *sta = rtwsta_to_sta(rtwsta_link);
 	struct rtw89_btc *btc = &rtwdev->btc;
 	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
@@ -7507,9 +7508,9 @@ void rtw89_btc_ntfy_role_info(struct rtw89_dev *rtwdev,
 		    "[BTC], bcn_period=%d dtim_period=%d\n",
 		    vif->bss_conf.beacon_int, vif->bss_conf.dtim_period);
 
-	if (rtwsta) {
+	if (rtwsta_link) {
 		rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], STA mac_id=%d\n",
-			    rtwsta->mac_id);
+			    rtwsta_link->mac_id);
 
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
 			    "[BTC], STA support HE=%d VHT=%d HT=%d\n",
@@ -7548,8 +7549,8 @@ void rtw89_btc_ntfy_role_info(struct rtw89_dev *rtwdev,
 	r.chdef.chan = chan->primary_channel;
 	ether_addr_copy(r.mac_addr, rtwvif_link->mac_addr);
 
-	if (rtwsta && vif->type == NL80211_IFTYPE_STATION)
-		r.mac_id = rtwsta->mac_id;
+	if (rtwsta_link && vif->type == NL80211_IFTYPE_STATION)
+		r.mac_id = rtwsta_link->mac_id;
 
 	btc->dm.cnt_notify[BTC_NCNT_ROLE_INFO]++;
 
@@ -7790,9 +7791,9 @@ static void rtw89_btc_ntfy_wl_sta_iter(void *data, struct ieee80211_sta *sta)
 	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_wl_link_info *link_info = NULL;
-	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
+	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
 	struct rtw89_traffic_stats *link_info_t = NULL;
-	struct rtw89_vif_link *rtwvif_link = rtwsta->rtwvif_link;
+	struct rtw89_vif_link *rtwvif_link = rtwsta_link->rtwvif_link;
 	struct rtw89_traffic_stats *stats = &rtwvif_link->stats;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_btc_wl_role_info *r;
@@ -7807,7 +7808,7 @@ static void rtw89_btc_ntfy_wl_sta_iter(void *data, struct ieee80211_sta *sta)
 	u8 i = 0;
 	bool is_sta_change = false, is_traffic_change = false;
 
-	rssi = ewma_rssi_read(&rtwsta->avg_rssi) >> RSSI_FACTOR;
+	rssi = ewma_rssi_read(&rtwsta_link->avg_rssi) >> RSSI_FACTOR;
 	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], rssi=%d\n", rssi);
 
 	link_info = &wl->link_info[port];
@@ -7859,19 +7860,19 @@ static void rtw89_btc_ntfy_wl_sta_iter(void *data, struct ieee80211_sta *sta)
 	iter_data->busy_all |= busy;
 	iter_data->dir_all |= BIT(dir);
 
-	if (rtwsta->rx_hw_rate <= RTW89_HW_RATE_CCK2 &&
+	if (rtwsta_link->rx_hw_rate <= RTW89_HW_RATE_CCK2 &&
 	    last_rx_rate > RTW89_HW_RATE_CCK2 &&
 	    link_info_t->rx_tfc_lv > RTW89_TFC_IDLE)
 		link_info->rx_rate_drop_cnt++;
 
-	if (last_tx_rate != rtwsta->ra_report.hw_rate ||
-	    last_rx_rate != rtwsta->rx_hw_rate ||
+	if (last_tx_rate != rtwsta_link->ra_report.hw_rate ||
+	    last_rx_rate != rtwsta_link->rx_hw_rate ||
 	    last_tx_lvl != link_info_t->tx_tfc_lv ||
 	    last_rx_lvl != link_info_t->rx_tfc_lv)
 		is_traffic_change = true;
 
-	link_info_t->tx_rate = rtwsta->ra_report.hw_rate;
-	link_info_t->rx_rate = rtwsta->rx_hw_rate;
+	link_info_t->tx_rate = rtwsta_link->ra_report.hw_rate;
+	link_info_t->rx_rate = rtwsta_link->rx_hw_rate;
 
 	if (link_info->role == RTW89_WIFI_ROLE_STATION ||
 	    link_info->role == RTW89_WIFI_ROLE_P2P_CLIENT) {
@@ -7883,19 +7884,19 @@ static void rtw89_btc_ntfy_wl_sta_iter(void *data, struct ieee80211_sta *sta)
 		r = &wl->role_info;
 		r->active_role[port].tx_lvl = stats->tx_tfc_lv;
 		r->active_role[port].rx_lvl = stats->rx_tfc_lv;
-		r->active_role[port].tx_rate = rtwsta->ra_report.hw_rate;
-		r->active_role[port].rx_rate = rtwsta->rx_hw_rate;
+		r->active_role[port].tx_rate = rtwsta_link->ra_report.hw_rate;
+		r->active_role[port].rx_rate = rtwsta_link->rx_hw_rate;
 	} else if (ver->fwlrole == 1) {
 		r1 = &wl->role_info_v1;
 		r1->active_role_v1[port].tx_lvl = stats->tx_tfc_lv;
 		r1->active_role_v1[port].rx_lvl = stats->rx_tfc_lv;
-		r1->active_role_v1[port].tx_rate = rtwsta->ra_report.hw_rate;
-		r1->active_role_v1[port].rx_rate = rtwsta->rx_hw_rate;
+		r1->active_role_v1[port].tx_rate = rtwsta_link->ra_report.hw_rate;
+		r1->active_role_v1[port].rx_rate = rtwsta_link->rx_hw_rate;
 	} else if (ver->fwlrole == 2) {
 		dm->trx_info.tx_lvl = stats->tx_tfc_lv;
 		dm->trx_info.rx_lvl = stats->rx_tfc_lv;
-		dm->trx_info.tx_rate = rtwsta->ra_report.hw_rate;
-		dm->trx_info.rx_rate = rtwsta->rx_hw_rate;
+		dm->trx_info.tx_rate = rtwsta_link->ra_report.hw_rate;
+		dm->trx_info.rx_rate = rtwsta_link->rx_hw_rate;
 	}
 
 	dm->trx_info.tx_tp = link_info_t->tx_throughput;
diff --git a/drivers/net/wireless/realtek/rtw89/coex.h b/drivers/net/wireless/realtek/rtw89/coex.h
index 2a3bd1ead7c3..dbdb56e063ef 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.h
+++ b/drivers/net/wireless/realtek/rtw89/coex.h
@@ -273,7 +273,8 @@ void rtw89_btc_ntfy_dhcp_packet_work(struct work_struct *work);
 void rtw89_btc_ntfy_icmp_packet_work(struct work_struct *work);
 void rtw89_btc_ntfy_role_info(struct rtw89_dev *rtwdev,
 			      struct rtw89_vif_link *rtwvif_link,
-			      struct rtw89_sta *rtwsta, enum btc_role_state state);
+			      struct rtw89_sta_link *rtwsta_link,
+			      enum btc_role_state state);
 void rtw89_btc_ntfy_radio_state(struct rtw89_dev *rtwdev, enum btc_rfctrl rf_state);
 void rtw89_btc_ntfy_wl_rfk(struct rtw89_dev *rtwdev, u8 phy_map,
 			   enum btc_wl_rfk_type type,
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 314c2e2ef8e9..2b6a8fe0e53b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -466,7 +466,7 @@ rtw89_core_tx_update_ampdu_info(struct rtw89_dev *rtwdev,
 	struct ieee80211_sta *sta = tx_req->sta;
 	struct rtw89_tx_desc_info *desc_info = &tx_req->desc_info;
 	struct sk_buff *skb = tx_req->skb;
-	struct rtw89_sta *rtwsta;
+	struct rtw89_sta_link *rtwsta_link;
 	u8 ampdu_num;
 	u8 tid;
 
@@ -484,10 +484,10 @@ rtw89_core_tx_update_ampdu_info(struct rtw89_dev *rtwdev,
 	}
 
 	tid = skb->priority & IEEE80211_QOS_CTL_TAG1D_MASK;
-	rtwsta = (struct rtw89_sta *)sta->drv_priv;
+	rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
 
-	ampdu_num = (u8)((rtwsta->ampdu_params[tid].agg_num ?
-			  rtwsta->ampdu_params[tid].agg_num :
+	ampdu_num = (u8)((rtwsta_link->ampdu_params[tid].agg_num ?
+			  rtwsta_link->ampdu_params[tid].agg_num :
 			  4 << sta->deflink.ht_cap.ampdu_factor) - 1);
 
 	desc_info->agg_en = true;
@@ -593,13 +593,13 @@ static u8 rtw89_core_tx_get_mac_id(struct rtw89_dev *rtwdev,
 	struct ieee80211_vif *vif = tx_req->vif;
 	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 	struct ieee80211_sta *sta = tx_req->sta;
-	struct rtw89_sta *rtwsta;
+	struct rtw89_sta_link *rtwsta_link;
 
 	if (!sta)
 		return rtwvif_link->mac_id;
 
-	rtwsta = (struct rtw89_sta *)sta->drv_priv;
-	return rtwsta->mac_id;
+	rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
+	return rtwsta_link->mac_id;
 }
 
 static void rtw89_core_tx_update_llc_hdr(struct rtw89_dev *rtwdev,
@@ -702,7 +702,7 @@ __rtw89_core_tx_check_he_qos_htc(struct rtw89_dev *rtwdev,
 				 enum btc_pkt_type pkt_type)
 {
 	struct ieee80211_sta *sta = tx_req->sta;
-	struct rtw89_sta *rtwsta = sta_to_rtwsta_safe(sta);
+	struct rtw89_sta_link *rtwsta_link = sta_to_rtwsta_safe(sta);
 	struct sk_buff *skb = tx_req->skb;
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	__le16 fc = hdr->frame_control;
@@ -720,7 +720,7 @@ __rtw89_core_tx_check_he_qos_htc(struct rtw89_dev *rtwdev,
 	if (skb_headroom(skb) < IEEE80211_HT_CTL_LEN)
 		return false;
 
-	if (rtwsta && rtwsta->ra_report.might_fallback_legacy)
+	if (rtwsta_link && rtwsta_link->ra_report.might_fallback_legacy)
 		return false;
 
 	return true;
@@ -731,7 +731,7 @@ __rtw89_core_tx_adjust_he_qos_htc(struct rtw89_dev *rtwdev,
 				  struct rtw89_core_tx_request *tx_req)
 {
 	struct ieee80211_sta *sta = tx_req->sta;
-	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
+	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
 	struct sk_buff *skb = tx_req->skb;
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	__le16 fc = hdr->frame_control;
@@ -747,7 +747,7 @@ __rtw89_core_tx_adjust_he_qos_htc(struct rtw89_dev *rtwdev,
 	hdr = data;
 	htc = data + hdr_len;
 	hdr->frame_control |= cpu_to_le16(IEEE80211_FCTL_ORDER);
-	*htc = rtwsta->htc_template ? rtwsta->htc_template :
+	*htc = rtwsta_link->htc_template ? rtwsta_link->htc_template :
 	       le32_encode_bits(RTW89_HTC_VARIANT_HE, RTW89_HTC_MASK_VARIANT) |
 	       le32_encode_bits(RTW89_HTC_VARIANT_HE_CID_CAS, RTW89_HTC_MASK_CTL_ID);
 
@@ -814,7 +814,7 @@ rtw89_core_tx_update_data_info(struct rtw89_dev *rtwdev,
 	struct ieee80211_vif *vif = tx_req->vif;
 	struct ieee80211_sta *sta = tx_req->sta;
 	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
-	struct rtw89_sta *rtwsta = sta_to_rtwsta_safe(sta);
+	struct rtw89_sta_link *rtwsta_link = sta_to_rtwsta_safe(sta);
 	struct rtw89_tx_desc_info *desc_info = &tx_req->desc_info;
 	struct sk_buff *skb = tx_req->skb;
 	u8 tid, tid_indicate;
@@ -830,9 +830,9 @@ rtw89_core_tx_update_data_info(struct rtw89_dev *rtwdev,
 	desc_info->qsel = qsel;
 	desc_info->mac_id = rtw89_core_tx_get_mac_id(rtwdev, tx_req);
 	desc_info->port = desc_info->hiq ? rtwvif_link->port : 0;
-	desc_info->er_cap = rtwsta ? rtwsta->er_cap : false;
-	desc_info->stbc = rtwsta ? rtwsta->ra.stbc_cap : false;
-	desc_info->ldpc = rtwsta ? rtwsta->ra.ldpc_cap : false;
+	desc_info->er_cap = rtwsta_link ? rtwsta_link->er_cap : false;
+	desc_info->stbc = rtwsta_link ? rtwsta_link->ra.stbc_cap : false;
+	desc_info->ldpc = rtwsta_link ? rtwsta_link->ra.ldpc_cap : false;
 
 	/* enable wd_info for AMPDU */
 	desc_info->en_wd_info = true;
@@ -1514,16 +1514,16 @@ static u8 rtw89_get_data_rate_nss(struct rtw89_dev *rtwdev, u16 data_rate)
 static void rtw89_core_rx_process_phy_ppdu_iter(void *data,
 						struct ieee80211_sta *sta)
 {
-	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
+	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
 	struct rtw89_rx_phy_ppdu *phy_ppdu = (struct rtw89_rx_phy_ppdu *)data;
-	struct rtw89_dev *rtwdev = rtwsta->rtwdev;
+	struct rtw89_dev *rtwdev = rtwsta_link->rtwdev;
 	struct rtw89_hal *hal = &rtwdev->hal;
 	u8 ant_num = hal->ant_diversity ? 2 : rtwdev->chip->rf_path_num;
 	u8 ant_pos = U8_MAX;
 	u8 evm_pos = 0;
 	int i;
 
-	if (rtwsta->mac_id != phy_ppdu->mac_id || !phy_ppdu->to_self)
+	if (rtwsta_link->mac_id != phy_ppdu->mac_id || !phy_ppdu->to_self)
 		return;
 
 	if (hal->ant_diversity && hal->antenna_rx) {
@@ -1531,22 +1531,24 @@ static void rtw89_core_rx_process_phy_ppdu_iter(void *data,
 		evm_pos = ant_pos;
 	}
 
-	ewma_rssi_add(&rtwsta->avg_rssi, phy_ppdu->rssi_avg);
+	ewma_rssi_add(&rtwsta_link->avg_rssi, phy_ppdu->rssi_avg);
 
 	if (ant_pos < ant_num) {
-		ewma_rssi_add(&rtwsta->rssi[ant_pos], phy_ppdu->rssi[0]);
+		ewma_rssi_add(&rtwsta_link->rssi[ant_pos], phy_ppdu->rssi[0]);
 	} else {
 		for (i = 0; i < rtwdev->chip->rf_path_num; i++)
-			ewma_rssi_add(&rtwsta->rssi[i], phy_ppdu->rssi[i]);
+			ewma_rssi_add(&rtwsta_link->rssi[i], phy_ppdu->rssi[i]);
 	}
 
 	if (phy_ppdu->ofdm.has && (phy_ppdu->has_data || phy_ppdu->has_bcn)) {
-		ewma_snr_add(&rtwsta->avg_snr, phy_ppdu->ofdm.avg_snr);
+		ewma_snr_add(&rtwsta_link->avg_snr, phy_ppdu->ofdm.avg_snr);
 		if (rtw89_get_data_rate_nss(rtwdev, phy_ppdu->rate) == 1) {
-			ewma_evm_add(&rtwsta->evm_1ss, phy_ppdu->ofdm.evm_min);
+			ewma_evm_add(&rtwsta_link->evm_1ss, phy_ppdu->ofdm.evm_min);
 		} else {
-			ewma_evm_add(&rtwsta->evm_min[evm_pos], phy_ppdu->ofdm.evm_min);
-			ewma_evm_add(&rtwsta->evm_max[evm_pos], phy_ppdu->ofdm.evm_max);
+			ewma_evm_add(&rtwsta_link->evm_min[evm_pos],
+				     phy_ppdu->ofdm.evm_min);
+			ewma_evm_add(&rtwsta_link->evm_max[evm_pos],
+				     phy_ppdu->ofdm.evm_max);
 		}
 	}
 }
@@ -2432,15 +2434,15 @@ void rtw89_core_stats_sta_rx_status_iter(void *data, struct ieee80211_sta *sta)
 	struct rtw89_core_iter_rx_status *iter_data =
 				(struct rtw89_core_iter_rx_status *)data;
 	struct ieee80211_rx_status *rx_status = iter_data->rx_status;
-	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
+	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
 	struct rtw89_rx_desc_info *desc_info = iter_data->desc_info;
 	u8 mac_id = iter_data->mac_id;
 
-	if (mac_id != rtwsta->mac_id)
+	if (mac_id != rtwsta_link->mac_id)
 		return;
 
-	rtwsta->rx_status = *rx_status;
-	rtwsta->rx_hw_rate = desc_info->data_rate;
+	rtwsta_link->rx_status = *rx_status;
+	rtwsta_link->rx_hw_rate = desc_info->data_rate;
 }
 
 static void rtw89_core_stats_sta_rx_status(struct rtw89_dev *rtwdev,
@@ -2658,7 +2660,8 @@ static void rtw89_core_ba_work(struct work_struct *work)
 	list_for_each_entry_safe(rtwtxq, tmp, &rtwdev->ba_list, list) {
 		struct ieee80211_txq *txq = rtw89_txq_to_txq(rtwtxq);
 		struct ieee80211_sta *sta = txq->sta;
-		struct rtw89_sta *rtwsta = sta ? (struct rtw89_sta *)sta->drv_priv : NULL;
+		struct rtw89_sta_link *rtwsta_link =
+			sta ? (struct rtw89_sta_link *)sta->drv_priv : NULL;
 		u8 tid = txq->tid;
 
 		if (!sta) {
@@ -2666,7 +2669,7 @@ static void rtw89_core_ba_work(struct work_struct *work)
 			goto skip_ba_work;
 		}
 
-		if (rtwsta->disassoc) {
+		if (rtwsta_link->disassoc) {
 			rtw89_debug(rtwdev, RTW89_DBG_TXRX,
 				    "cannot start BA with disassoc sta\n");
 			goto skip_ba_work;
@@ -2721,11 +2724,11 @@ static void rtw89_core_free_sta_pending_forbid_ba(struct rtw89_dev *rtwdev,
 static void rtw89_core_free_sta_pending_roc_tx(struct rtw89_dev *rtwdev,
 					       struct ieee80211_sta *sta)
 {
-	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
+	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
 	struct sk_buff *skb, *tmp;
 
-	skb_queue_walk_safe(&rtwsta->roc_queue, skb, tmp) {
-		skb_unlink(skb, &rtwsta->roc_queue);
+	skb_queue_walk_safe(&rtwsta_link->roc_queue, skb, tmp) {
+		skb_unlink(skb, &rtwsta_link->roc_queue);
 		dev_kfree_skb_any(skb);
 	}
 }
@@ -2735,9 +2738,9 @@ static void rtw89_core_stop_tx_ba_session(struct rtw89_dev *rtwdev,
 {
 	struct ieee80211_txq *txq = rtw89_txq_to_txq(rtwtxq);
 	struct ieee80211_sta *sta = txq->sta;
-	struct rtw89_sta *rtwsta = sta_to_rtwsta_safe(sta);
+	struct rtw89_sta_link *rtwsta_link = sta_to_rtwsta_safe(sta);
 
-	if (unlikely(!rtwsta) || unlikely(rtwsta->disassoc))
+	if (unlikely(!rtwsta_link) || unlikely(rtwsta_link->disassoc))
 		return;
 
 	if (!test_bit(RTW89_TXQ_F_AMPDU, &rtwtxq->flags) ||
@@ -2762,7 +2765,8 @@ static void rtw89_core_txq_check_agg(struct rtw89_dev *rtwdev,
 	struct ieee80211_hw *hw = rtwdev->hw;
 	struct ieee80211_txq *txq = rtw89_txq_to_txq(rtwtxq);
 	struct ieee80211_sta *sta = txq->sta;
-	struct rtw89_sta *rtwsta = sta ? (struct rtw89_sta *)sta->drv_priv : NULL;
+	struct rtw89_sta_link *rtwsta_link =
+		sta ? (struct rtw89_sta_link *)sta->drv_priv : NULL;
 
 	if (test_bit(RTW89_TXQ_F_FORBID_BA, &rtwtxq->flags))
 		return;
@@ -2784,7 +2788,7 @@ static void rtw89_core_txq_check_agg(struct rtw89_dev *rtwdev,
 	}
 
 	spin_lock_bh(&rtwdev->ba_lock);
-	if (!rtwsta->disassoc && list_empty(&rtwtxq->list)) {
+	if (!rtwsta_link->disassoc && list_empty(&rtwtxq->list)) {
 		list_add_tail(&rtwtxq->list, &rtwdev->ba_list);
 		ieee80211_queue_work(hw, &rtwdev->ba_work);
 	}
@@ -2839,9 +2843,10 @@ static bool rtw89_core_txq_agg_wait(struct rtw89_dev *rtwdev,
 {
 	struct rtw89_txq *rtwtxq = (struct rtw89_txq *)txq->drv_priv;
 	struct ieee80211_sta *sta = txq->sta;
-	struct rtw89_sta *rtwsta = sta ? (struct rtw89_sta *)sta->drv_priv : NULL;
+	struct rtw89_sta_link *rtwsta_link =
+		sta ? (struct rtw89_sta_link *)sta->drv_priv : NULL;
 
-	if (!sta || rtwsta->max_agg_wait <= 0)
+	if (!sta || rtwsta_link->max_agg_wait <= 0)
 		return false;
 
 	if (rtwdev->stats.tx_tfc_lv <= RTW89_TFC_MID)
@@ -2855,7 +2860,7 @@ static bool rtw89_core_txq_agg_wait(struct rtw89_dev *rtwdev,
 		return false;
 	}
 
-	if (*frame_cnt == 1 && rtwtxq->wait_cnt < rtwsta->max_agg_wait) {
+	if (*frame_cnt == 1 && rtwtxq->wait_cnt < rtwsta_link->max_agg_wait) {
 		*reinvoke = true;
 		rtwtxq->wait_cnt++;
 		return true;
@@ -2955,9 +2960,9 @@ static void rtw89_forbid_ba_work(struct work_struct *w)
 static void rtw89_core_sta_pending_tx_iter(void *data,
 					   struct ieee80211_sta *sta)
 {
-	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
+	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
 	struct rtw89_vif_link *rtwvif_target = data;
-	struct rtw89_vif_link *rtwvif_link = rtwsta->rtwvif_link;
+	struct rtw89_vif_link *rtwvif_link = rtwsta_link->rtwvif_link;
 	struct rtw89_dev *rtwdev = rtwvif_link->rtwdev;
 	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
 	struct sk_buff *skb, *tmp;
@@ -2966,11 +2971,11 @@ static void rtw89_core_sta_pending_tx_iter(void *data,
 	if (rtwvif_link->chanctx_idx != rtwvif_target->chanctx_idx)
 		return;
 
-	if (skb_queue_len(&rtwsta->roc_queue) == 0)
+	if (skb_queue_len(&rtwsta_link->roc_queue) == 0)
 		return;
 
-	skb_queue_walk_safe(&rtwsta->roc_queue, skb, tmp) {
-		skb_unlink(skb, &rtwsta->roc_queue);
+	skb_queue_walk_safe(&rtwsta_link->roc_queue, skb, tmp) {
+		skb_unlink(skb, &rtwsta_link->roc_queue);
 
 		ret = rtw89_core_tx_write(rtwdev, vif, sta, skb, &qsel);
 		if (ret) {
@@ -3328,7 +3333,8 @@ void rtw89_core_release_all_bits_map(unsigned long *addr, unsigned int nbits)
 }
 
 int rtw89_core_acquire_sta_ba_entry(struct rtw89_dev *rtwdev,
-				    struct rtw89_sta *rtwsta, u8 tid, u8 *cam_idx)
+				    struct rtw89_sta_link *rtwsta_link, u8 tid,
+				    u8 *cam_idx)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_cam_info *cam_info = &rtwdev->cam_info;
@@ -3365,7 +3371,7 @@ int rtw89_core_acquire_sta_ba_entry(struct rtw89_dev *rtwdev,
 	}
 
 	entry->tid = tid;
-	list_add_tail(&entry->list, &rtwsta->ba_cam_list);
+	list_add_tail(&entry->list, &rtwsta_link->ba_cam_list);
 
 	*cam_idx = idx;
 
@@ -3373,7 +3379,8 @@ int rtw89_core_acquire_sta_ba_entry(struct rtw89_dev *rtwdev,
 }
 
 int rtw89_core_release_sta_ba_entry(struct rtw89_dev *rtwdev,
-				    struct rtw89_sta *rtwsta, u8 tid, u8 *cam_idx)
+				    struct rtw89_sta_link *rtwsta_link, u8 tid,
+				    u8 *cam_idx)
 {
 	struct rtw89_cam_info *cam_info = &rtwdev->cam_info;
 	struct rtw89_ba_cam_entry *entry = NULL, *tmp;
@@ -3381,7 +3388,7 @@ int rtw89_core_release_sta_ba_entry(struct rtw89_dev *rtwdev,
 
 	lockdep_assert_held(&rtwdev->mutex);
 
-	list_for_each_entry_safe(entry, tmp, &rtwsta->ba_cam_list, list) {
+	list_for_each_entry_safe(entry, tmp, &rtwsta_link->ba_cam_list, list) {
 		if (entry->tid != tid)
 			continue;
 
@@ -3459,67 +3466,67 @@ int rtw89_core_sta_add(struct rtw89_dev *rtwdev,
 		       struct ieee80211_sta *sta)
 {
 	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
-	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
+	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
 	struct rtw89_hal *hal = &rtwdev->hal;
 	u8 ant_num = hal->ant_diversity ? 2 : rtwdev->chip->rf_path_num;
 	int i;
 	int ret;
 
-	rtwsta->rtwdev = rtwdev;
-	rtwsta->rtwvif_link = rtwvif_link;
-	rtwsta->prev_rssi = 0;
-	INIT_LIST_HEAD(&rtwsta->ba_cam_list);
-	skb_queue_head_init(&rtwsta->roc_queue);
+	rtwsta_link->rtwdev = rtwdev;
+	rtwsta_link->rtwvif_link = rtwvif_link;
+	rtwsta_link->prev_rssi = 0;
+	INIT_LIST_HEAD(&rtwsta_link->ba_cam_list);
+	skb_queue_head_init(&rtwsta_link->roc_queue);
 
 	for (i = 0; i < ARRAY_SIZE(sta->txq); i++)
 		rtw89_core_txq_init(rtwdev, sta->txq[i]);
 
-	ewma_rssi_init(&rtwsta->avg_rssi);
-	ewma_snr_init(&rtwsta->avg_snr);
-	ewma_evm_init(&rtwsta->evm_1ss);
+	ewma_rssi_init(&rtwsta_link->avg_rssi);
+	ewma_snr_init(&rtwsta_link->avg_snr);
+	ewma_evm_init(&rtwsta_link->evm_1ss);
 	for (i = 0; i < ant_num; i++) {
-		ewma_rssi_init(&rtwsta->rssi[i]);
-		ewma_evm_init(&rtwsta->evm_min[i]);
-		ewma_evm_init(&rtwsta->evm_max[i]);
+		ewma_rssi_init(&rtwsta_link->rssi[i]);
+		ewma_evm_init(&rtwsta_link->evm_min[i]);
+		ewma_evm_init(&rtwsta_link->evm_max[i]);
 	}
 
 	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls) {
 		/* for station mode, assign the mac_id from itself */
-		rtwsta->mac_id = rtwvif_link->mac_id;
+		rtwsta_link->mac_id = rtwvif_link->mac_id;
 
 		/* must do rtw89_reg_6ghz_recalc() before rfk channel */
 		ret = rtw89_reg_6ghz_recalc(rtwdev, rtwvif_link, true);
 		if (ret)
 			return ret;
 
-		rtw89_btc_ntfy_role_info(rtwdev, rtwvif_link, rtwsta,
+		rtw89_btc_ntfy_role_info(rtwdev, rtwvif_link, rtwsta_link,
 					 BTC_ROLE_MSTS_STA_CONN_START);
 		rtw89_chip_rfk_channel(rtwdev, rtwvif_link);
 	} else if (vif->type == NL80211_IFTYPE_AP || sta->tdls) {
-		rtwsta->mac_id = rtw89_acquire_mac_id(rtwdev);
-		if (rtwsta->mac_id == RTW89_MAX_MAC_ID_NUM)
+		rtwsta_link->mac_id = rtw89_acquire_mac_id(rtwdev);
+		if (rtwsta_link->mac_id == RTW89_MAX_MAC_ID_NUM)
 			return -ENOSPC;
 
-		ret = rtw89_mac_set_macid_pause(rtwdev, rtwsta->mac_id, false);
+		ret = rtw89_mac_set_macid_pause(rtwdev, rtwsta_link->mac_id, false);
 		if (ret) {
-			rtw89_release_mac_id(rtwdev, rtwsta->mac_id);
+			rtw89_release_mac_id(rtwdev, rtwsta_link->mac_id);
 			rtw89_warn(rtwdev, "failed to send h2c macid pause\n");
 			return ret;
 		}
 
-		ret = rtw89_fw_h2c_role_maintain(rtwdev, rtwvif_link, rtwsta,
+		ret = rtw89_fw_h2c_role_maintain(rtwdev, rtwvif_link, rtwsta_link,
 						 RTW89_ROLE_CREATE);
 		if (ret) {
-			rtw89_release_mac_id(rtwdev, rtwsta->mac_id);
+			rtw89_release_mac_id(rtwdev, rtwsta_link->mac_id);
 			rtw89_warn(rtwdev, "failed to send h2c role info\n");
 			return ret;
 		}
 
-		ret = rtw89_chip_h2c_default_cmac_tbl(rtwdev, rtwvif_link, rtwsta);
+		ret = rtw89_chip_h2c_default_cmac_tbl(rtwdev, rtwvif_link, rtwsta_link);
 		if (ret)
 			return ret;
 
-		ret = rtw89_chip_h2c_default_dmac_tbl(rtwdev, rtwvif_link, rtwsta);
+		ret = rtw89_chip_h2c_default_dmac_tbl(rtwdev, rtwvif_link, rtwsta_link);
 		if (ret)
 			return ret;
 
@@ -3534,7 +3541,7 @@ int rtw89_core_sta_disassoc(struct rtw89_dev *rtwdev,
 			    struct ieee80211_sta *sta)
 {
 	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
-	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
+	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
 
 	if (vif->type == NL80211_IFTYPE_STATION)
 		rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, vif, false);
@@ -3542,7 +3549,7 @@ int rtw89_core_sta_disassoc(struct rtw89_dev *rtwdev,
 	rtwdev->total_sta_assoc--;
 	if (sta->tdls)
 		rtwvif_link->tdls_peer--;
-	rtwsta->disassoc = true;
+	rtwsta_link->disassoc = true;
 
 	return 0;
 }
@@ -3552,7 +3559,7 @@ int rtw89_core_sta_disconnect(struct rtw89_dev *rtwdev,
 			      struct ieee80211_sta *sta)
 {
 	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
-	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
+	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
 	int ret;
 
 	rtw89_mac_bf_monitor_calc(rtwdev, sta, true);
@@ -3562,9 +3569,9 @@ int rtw89_core_sta_disconnect(struct rtw89_dev *rtwdev,
 	rtw89_core_free_sta_pending_roc_tx(rtwdev, sta);
 
 	if (vif->type == NL80211_IFTYPE_AP || sta->tdls)
-		rtw89_cam_deinit_addr_cam(rtwdev, &rtwsta->addr_cam);
+		rtw89_cam_deinit_addr_cam(rtwdev, &rtwsta_link->addr_cam);
 	if (sta->tdls)
-		rtw89_cam_deinit_bssid_cam(rtwdev, &rtwsta->bssid_cam);
+		rtw89_cam_deinit_bssid_cam(rtwdev, &rtwsta_link->bssid_cam);
 
 	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls) {
 		rtw89_vif_type_mapping(vif, false);
@@ -3577,14 +3584,14 @@ int rtw89_core_sta_disconnect(struct rtw89_dev *rtwdev,
 		return ret;
 	}
 
-	ret = rtw89_fw_h2c_join_info(rtwdev, rtwvif_link, rtwsta, true);
+	ret = rtw89_fw_h2c_join_info(rtwdev, rtwvif_link, rtwsta_link, true);
 	if (ret) {
 		rtw89_warn(rtwdev, "failed to send h2c join info\n");
 		return ret;
 	}
 
 	/* update cam aid mac_id net_type */
-	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif_link, rtwsta, NULL);
+	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif_link, rtwsta_link, NULL);
 	if (ret) {
 		rtw89_warn(rtwdev, "failed to send h2c cam\n");
 		return ret;
@@ -3598,9 +3605,9 @@ int rtw89_core_sta_assoc(struct rtw89_dev *rtwdev,
 			 struct ieee80211_sta *sta)
 {
 	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
-	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
+	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
 	struct rtw89_bssid_cam_entry *bssid_cam = rtw89_get_bssid_cam_of(rtwvif_link,
-									 rtwsta);
+									 rtwsta_link);
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
 						       rtwvif_link->chanctx_idx);
 	int ret;
@@ -3615,7 +3622,7 @@ int rtw89_core_sta_assoc(struct rtw89_dev *rtwdev,
 			}
 		}
 
-		ret = rtw89_cam_init_addr_cam(rtwdev, &rtwsta->addr_cam, bssid_cam);
+		ret = rtw89_cam_init_addr_cam(rtwdev, &rtwsta_link->addr_cam, bssid_cam);
 		if (ret) {
 			rtw89_warn(rtwdev, "failed to send h2c init addr cam\n");
 			return ret;
@@ -3628,14 +3635,14 @@ int rtw89_core_sta_assoc(struct rtw89_dev *rtwdev,
 		return ret;
 	}
 
-	ret = rtw89_fw_h2c_join_info(rtwdev, rtwvif_link, rtwsta, false);
+	ret = rtw89_fw_h2c_join_info(rtwdev, rtwvif_link, rtwsta_link, false);
 	if (ret) {
 		rtw89_warn(rtwdev, "failed to send h2c join info\n");
 		return ret;
 	}
 
 	/* update cam aid mac_id net_type */
-	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif_link, rtwsta, NULL);
+	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif_link, rtwsta_link, NULL);
 	if (ret) {
 		rtw89_warn(rtwdev, "failed to send h2c cam\n");
 		return ret;
@@ -3653,14 +3660,14 @@ int rtw89_core_sta_assoc(struct rtw89_dev *rtwdev,
 
 		if (bss_conf->he_support &&
 		    !(bss_conf->he_oper.params & IEEE80211_HE_OPERATION_ER_SU_DISABLE))
-			rtwsta->er_cap = true;
+			rtwsta_link->er_cap = true;
 
-		rtw89_btc_ntfy_role_info(rtwdev, rtwvif_link, rtwsta,
+		rtw89_btc_ntfy_role_info(rtwdev, rtwvif_link, rtwsta_link,
 					 BTC_ROLE_MSTS_STA_CONN_END);
-		rtw89_core_get_no_ul_ofdma_htc(rtwdev, &rtwsta->htc_template, chan);
+		rtw89_core_get_no_ul_ofdma_htc(rtwdev, &rtwsta_link->htc_template, chan);
 		rtw89_phy_ul_tb_assoc(rtwdev, rtwvif_link);
 
-		ret = rtw89_fw_h2c_general_pkt(rtwdev, rtwvif_link, rtwsta->mac_id);
+		ret = rtw89_fw_h2c_general_pkt(rtwdev, rtwvif_link, rtwsta_link->mac_id);
 		if (ret) {
 			rtw89_warn(rtwdev, "failed to send h2c general packet\n");
 			return ret;
@@ -3677,17 +3684,17 @@ int rtw89_core_sta_remove(struct rtw89_dev *rtwdev,
 			  struct ieee80211_sta *sta)
 {
 	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
-	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
+	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
 	int ret;
 
 	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls) {
 		rtw89_reg_6ghz_recalc(rtwdev, rtwvif_link, false);
-		rtw89_btc_ntfy_role_info(rtwdev, rtwvif_link, rtwsta,
+		rtw89_btc_ntfy_role_info(rtwdev, rtwvif_link, rtwsta_link,
 					 BTC_ROLE_MSTS_STA_DIS_CONN);
 	} else if (vif->type == NL80211_IFTYPE_AP || sta->tdls) {
-		rtw89_release_mac_id(rtwdev, rtwsta->mac_id);
+		rtw89_release_mac_id(rtwdev, rtwsta_link->mac_id);
 
-		ret = rtw89_fw_h2c_role_maintain(rtwdev, rtwvif_link, rtwsta,
+		ret = rtw89_fw_h2c_role_maintain(rtwdev, rtwvif_link, rtwsta_link,
 						 RTW89_ROLE_REMOVE);
 		if (ret) {
 			rtw89_warn(rtwdev, "failed to send h2c role info\n");
@@ -4703,7 +4710,7 @@ static int rtw89_core_register_hw(struct rtw89_dev *rtwdev)
 	int tx_headroom = IEEE80211_HT_CTL_LEN;
 
 	hw->vif_data_size = sizeof(struct rtw89_vif_link);
-	hw->sta_data_size = sizeof(struct rtw89_sta);
+	hw->sta_data_size = sizeof(struct rtw89_sta_link);
 	hw->txq_data_size = sizeof(struct rtw89_txq);
 	hw->chanctx_data_size = sizeof(struct rtw89_chanctx_cfg);
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index e897c4f79f06..5e22da91213b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3354,7 +3354,7 @@ struct rtw89_sec_cam_entry {
 	u8 key[32];
 };
 
-struct rtw89_sta {
+struct rtw89_sta_link {
 	u8 mac_id;
 	bool disassoc;
 	bool er_cap;
@@ -3647,10 +3647,10 @@ struct rtw89_chip_ops {
 	int (*resume_sch_tx)(struct rtw89_dev *rtwdev, u8 mac_idx, u32 tx_en);
 	int (*h2c_dctl_sec_cam)(struct rtw89_dev *rtwdev,
 				struct rtw89_vif_link *rtwvif_link,
-				struct rtw89_sta *rtwsta);
+				struct rtw89_sta_link *rtwsta_link);
 	int (*h2c_default_cmac_tbl)(struct rtw89_dev *rtwdev,
 				    struct rtw89_vif_link *rtwvif_link,
-				    struct rtw89_sta *rtwsta);
+				    struct rtw89_sta_link *rtwsta_link);
 	int (*h2c_assoc_cmac_tbl)(struct rtw89_dev *rtwdev,
 				  struct ieee80211_vif *vif,
 				  struct ieee80211_sta *sta);
@@ -3659,10 +3659,10 @@ struct rtw89_chip_ops {
 				  struct ieee80211_sta *sta);
 	int (*h2c_default_dmac_tbl)(struct rtw89_dev *rtwdev,
 				    struct rtw89_vif_link *rtwvif_link,
-				    struct rtw89_sta *rtwsta);
+				    struct rtw89_sta_link *rtwsta_link);
 	int (*h2c_update_beacon)(struct rtw89_dev *rtwdev,
 				 struct rtw89_vif_link *rtwvif_link);
-	int (*h2c_ba_cam)(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
+	int (*h2c_ba_cam)(struct rtw89_dev *rtwdev, struct rtw89_sta_link *rtwsta_link,
 			  bool valid, struct ieee80211_ampdu_params *params);
 
 	void (*btc_set_rfe)(struct rtw89_dev *rtwdev);
@@ -5977,21 +5977,21 @@ static inline struct rtw89_vif_link *vif_to_rtwvif_safe(struct ieee80211_vif *vi
 	return vif ? (struct rtw89_vif_link *)vif->drv_priv : NULL;
 }
 
-static inline struct ieee80211_sta *rtwsta_to_sta(struct rtw89_sta *rtwsta)
+static inline struct ieee80211_sta *rtwsta_to_sta(struct rtw89_sta_link *rtwsta_link)
 {
-	void *p = rtwsta;
+	void *p = rtwsta_link;
 
 	return container_of(p, struct ieee80211_sta, drv_priv);
 }
 
-static inline struct ieee80211_sta *rtwsta_to_sta_safe(struct rtw89_sta *rtwsta)
+static inline struct ieee80211_sta *rtwsta_to_sta_safe(struct rtw89_sta_link *rtwsta_link)
 {
-	return rtwsta ? rtwsta_to_sta(rtwsta) : NULL;
+	return rtwsta_link ? rtwsta_to_sta(rtwsta_link) : NULL;
 }
 
-static inline struct rtw89_sta *sta_to_rtwsta_safe(struct ieee80211_sta *sta)
+static inline struct rtw89_sta_link *sta_to_rtwsta_safe(struct ieee80211_sta *sta)
 {
-	return sta ? (struct rtw89_sta *)sta->drv_priv : NULL;
+	return sta ? (struct rtw89_sta_link *)sta->drv_priv : NULL;
 }
 
 static inline u8 rtw89_hw_to_rate_info_bw(enum rtw89_bandwidth hw_bw)
@@ -6079,26 +6079,26 @@ enum nl80211_he_ru_alloc rtw89_he_rua_to_ru_alloc(u16 rua)
 
 static inline
 struct rtw89_addr_cam_entry *rtw89_get_addr_cam_of(struct rtw89_vif_link *rtwvif_link,
-						   struct rtw89_sta *rtwsta)
+						   struct rtw89_sta_link *rtwsta_link)
 {
-	if (rtwsta) {
-		struct ieee80211_sta *sta = rtwsta_to_sta(rtwsta);
+	if (rtwsta_link) {
+		struct ieee80211_sta *sta = rtwsta_to_sta(rtwsta_link);
 
 		if (rtwvif_link->net_type == RTW89_NET_TYPE_AP_MODE || sta->tdls)
-			return &rtwsta->addr_cam;
+			return &rtwsta_link->addr_cam;
 	}
 	return &rtwvif_link->addr_cam;
 }
 
 static inline
 struct rtw89_bssid_cam_entry *rtw89_get_bssid_cam_of(struct rtw89_vif_link *rtwvif_link,
-						     struct rtw89_sta *rtwsta)
+						     struct rtw89_sta_link *rtwsta_link)
 {
-	if (rtwsta) {
-		struct ieee80211_sta *sta = rtwsta_to_sta(rtwsta);
+	if (rtwsta_link) {
+		struct ieee80211_sta *sta = rtwsta_to_sta(rtwsta_link);
 
 		if (sta->tdls)
-			return &rtwsta->bssid_cam;
+			return &rtwsta_link->bssid_cam;
 	}
 	return &rtwvif_link->bssid_cam;
 }
@@ -6458,13 +6458,13 @@ int rtw89_chip_resume_sch_tx(struct rtw89_dev *rtwdev, u8 mac_idx, u32 tx_en)
 static inline
 int rtw89_chip_h2c_dctl_sec_cam(struct rtw89_dev *rtwdev,
 				struct rtw89_vif_link *rtwvif_link,
-				struct rtw89_sta *rtwsta)
+				struct rtw89_sta_link *rtwsta_link)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 
 	if (!chip->ops->h2c_dctl_sec_cam)
 		return 0;
-	return chip->ops->h2c_dctl_sec_cam(rtwdev, rtwvif_link, rtwsta);
+	return chip->ops->h2c_dctl_sec_cam(rtwdev, rtwvif_link, rtwsta_link);
 }
 
 static inline u8 *get_hdr_bssid(struct ieee80211_hdr *hdr)
@@ -6646,9 +6646,11 @@ u8 rtw89_core_acquire_bit_map(unsigned long *addr, unsigned long size);
 void rtw89_core_release_bit_map(unsigned long *addr, u8 bit);
 void rtw89_core_release_all_bits_map(unsigned long *addr, unsigned int nbits);
 int rtw89_core_acquire_sta_ba_entry(struct rtw89_dev *rtwdev,
-				    struct rtw89_sta *rtwsta, u8 tid, u8 *cam_idx);
+				    struct rtw89_sta_link *rtwsta_link, u8 tid,
+				    u8 *cam_idx);
 int rtw89_core_release_sta_ba_entry(struct rtw89_dev *rtwdev,
-				    struct rtw89_sta *rtwsta, u8 tid, u8 *cam_idx);
+				    struct rtw89_sta_link *rtwsta_link, u8 tid,
+				    u8 *cam_idx);
 void rtw89_vif_type_mapping(struct ieee80211_vif *vif, bool assoc);
 int rtw89_chip_info_setup(struct rtw89_dev *rtwdev);
 bool rtw89_ra_report_to_bitrate(struct rtw89_dev *rtwdev, u8 rpt_rate, u16 *bitrate);
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 26327e4b071d..f09f1a251b16 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -3518,11 +3518,11 @@ static void rtw89_sta_info_get_iter(void *data, struct ieee80211_sta *sta)
 		[NL80211_RATE_INFO_EHT_GI_1_6] = "1.6",
 		[NL80211_RATE_INFO_EHT_GI_3_2] = "3.2",
 	};
-	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
-	struct rate_info *rate = &rtwsta->ra_report.txrate;
-	struct ieee80211_rx_status *status = &rtwsta->rx_status;
+	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
+	struct rate_info *rate = &rtwsta_link->ra_report.txrate;
+	struct ieee80211_rx_status *status = &rtwsta_link->rx_status;
 	struct seq_file *m = (struct seq_file *)data;
-	struct rtw89_dev *rtwdev = rtwsta->rtwdev;
+	struct rtw89_dev *rtwdev = rtwsta_link->rtwdev;
 	struct rtw89_hal *hal = &rtwdev->hal;
 	u8 ant_num = hal->ant_diversity ? 2 : rtwdev->chip->rf_path_num;
 	bool ant_asterisk = hal->tx_path_diversity || hal->ant_diversity;
@@ -3531,7 +3531,7 @@ static void rtw89_sta_info_get_iter(void *data, struct ieee80211_sta *sta)
 	u8 snr;
 	int i;
 
-	seq_printf(m, "TX rate [%d]: ", rtwsta->mac_id);
+	seq_printf(m, "TX rate [%d]: ", rtwsta_link->mac_id);
 
 	if (rate->flags & RATE_INFO_FLAGS_MCS)
 		seq_printf(m, "HT MCS-%d%s", rate->mcs,
@@ -3549,13 +3549,13 @@ static void rtw89_sta_info_get_iter(void *data, struct ieee80211_sta *sta)
 			   eht_gi_str[rate->eht_gi] : "N/A");
 	else
 		seq_printf(m, "Legacy %d", rate->legacy);
-	seq_printf(m, "%s", rtwsta->ra_report.might_fallback_legacy ? " FB_G" : "");
+	seq_printf(m, "%s", rtwsta_link->ra_report.might_fallback_legacy ? " FB_G" : "");
 	seq_printf(m, " BW:%u", rtw89_rate_info_bw_to_mhz(rate->bw));
-	seq_printf(m, "\t(hw_rate=0x%x)", rtwsta->ra_report.hw_rate);
-	seq_printf(m, "\t==> agg_wait=%d (%d)\n", rtwsta->max_agg_wait,
+	seq_printf(m, "\t(hw_rate=0x%x)", rtwsta_link->ra_report.hw_rate);
+	seq_printf(m, "\t==> agg_wait=%d (%d)\n", rtwsta_link->max_agg_wait,
 		   sta->deflink.agg.max_rc_amsdu_len);
 
-	seq_printf(m, "RX rate [%d]: ", rtwsta->mac_id);
+	seq_printf(m, "RX rate [%d]: ", rtwsta_link->mac_id);
 
 	switch (status->encoding) {
 	case RX_ENC_LEGACY:
@@ -3582,24 +3582,24 @@ static void rtw89_sta_info_get_iter(void *data, struct ieee80211_sta *sta)
 		break;
 	}
 	seq_printf(m, " BW:%u", rtw89_rate_info_bw_to_mhz(status->bw));
-	seq_printf(m, "\t(hw_rate=0x%x)\n", rtwsta->rx_hw_rate);
+	seq_printf(m, "\t(hw_rate=0x%x)\n", rtwsta_link->rx_hw_rate);
 
-	rssi = ewma_rssi_read(&rtwsta->avg_rssi);
+	rssi = ewma_rssi_read(&rtwsta_link->avg_rssi);
 	seq_printf(m, "RSSI: %d dBm (raw=%d, prev=%d) [",
-		   RTW89_RSSI_RAW_TO_DBM(rssi), rssi, rtwsta->prev_rssi);
+		   RTW89_RSSI_RAW_TO_DBM(rssi), rssi, rtwsta_link->prev_rssi);
 	for (i = 0; i < ant_num; i++) {
-		rssi = ewma_rssi_read(&rtwsta->rssi[i]);
+		rssi = ewma_rssi_read(&rtwsta_link->rssi[i]);
 		seq_printf(m, "%d%s%s", RTW89_RSSI_RAW_TO_DBM(rssi),
 			   ant_asterisk && (hal->antenna_tx & BIT(i)) ? "*" : "",
 			   i + 1 == ant_num ? "" : ", ");
 	}
 	seq_puts(m, "]\n");
 
-	evm_1ss = ewma_evm_read(&rtwsta->evm_1ss);
+	evm_1ss = ewma_evm_read(&rtwsta_link->evm_1ss);
 	seq_printf(m, "EVM: [%2u.%02u, ", evm_1ss >> 2, (evm_1ss & 0x3) * 25);
 	for (i = 0; i < (hal->ant_diversity ? 2 : 1); i++) {
-		evm_min = ewma_evm_read(&rtwsta->evm_min[i]);
-		evm_max = ewma_evm_read(&rtwsta->evm_max[i]);
+		evm_min = ewma_evm_read(&rtwsta_link->evm_min[i]);
+		evm_max = ewma_evm_read(&rtwsta_link->evm_max[i]);
 
 		seq_printf(m, "%s(%2u.%02u, %2u.%02u)", i == 0 ? "" : " ",
 			   evm_min >> 2, (evm_min & 0x3) * 25,
@@ -3607,7 +3607,7 @@ static void rtw89_sta_info_get_iter(void *data, struct ieee80211_sta *sta)
 	}
 	seq_puts(m, "]\t");
 
-	snr = ewma_snr_read(&rtwsta->avg_snr);
+	snr = ewma_snr_read(&rtwsta_link->avg_snr);
 	seq_printf(m, "SNR: %u\n", snr);
 }
 
@@ -3752,14 +3752,14 @@ void rtw89_vif_ids_get_iter(void *data, u8 *mac, struct ieee80211_vif *vif)
 			       "\tpkt_ofld[GENERAL]: ");
 }
 
-static void rtw89_dump_ba_cam(struct seq_file *m, struct rtw89_sta *rtwsta)
+static void rtw89_dump_ba_cam(struct seq_file *m, struct rtw89_sta_link *rtwsta_link)
 {
-	struct rtw89_vif_link *rtwvif_link = rtwsta->rtwvif_link;
+	struct rtw89_vif_link *rtwvif_link = rtwsta_link->rtwvif_link;
 	struct rtw89_dev *rtwdev = rtwvif_link->rtwdev;
 	struct rtw89_ba_cam_entry *entry;
 	bool first = true;
 
-	list_for_each_entry(entry, &rtwsta->ba_cam_list, list) {
+	list_for_each_entry(entry, &rtwsta_link->ba_cam_list, list) {
 		if (first) {
 			seq_puts(m, "\tba_cam ");
 			first = false;
@@ -3774,14 +3774,14 @@ static void rtw89_dump_ba_cam(struct seq_file *m, struct rtw89_sta *rtwsta)
 
 static void rtw89_sta_ids_get_iter(void *data, struct ieee80211_sta *sta)
 {
-	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
-	struct rtw89_dev *rtwdev = rtwsta->rtwdev;
+	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
+	struct rtw89_dev *rtwdev = rtwsta_link->rtwdev;
 	struct seq_file *m = (struct seq_file *)data;
 
-	seq_printf(m, "STA [%d] %pM %s\n", rtwsta->mac_id, sta->addr,
+	seq_printf(m, "STA [%d] %pM %s\n", rtwsta_link->mac_id, sta->addr,
 		   sta->tdls ? "(TDLS)" : "");
-	rtw89_dump_addr_cam(m, rtwdev, &rtwsta->addr_cam);
-	rtw89_dump_ba_cam(m, rtwsta);
+	rtw89_dump_addr_cam(m, rtwdev, &rtwsta_link->addr_cam);
+	rtw89_dump_ba_cam(m, rtwsta_link);
 }
 
 static int rtw89_debug_priv_stations_get(struct seq_file *m, void *v)
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 1d5de66bf945..03775064ee0c 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1742,7 +1742,7 @@ void rtw89_fw_log_dump(struct rtw89_dev *rtwdev, u8 *buf, u32 len)
 
 #define H2C_CAM_LEN 60
 int rtw89_fw_h2c_cam(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
-		     struct rtw89_sta *rtwsta, const u8 *scan_mac_addr)
+		     struct rtw89_sta_link *rtwsta_link, const u8 *scan_mac_addr)
 {
 	struct sk_buff *skb;
 	int ret;
@@ -1753,9 +1753,9 @@ int rtw89_fw_h2c_cam(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_lin
 		return -ENOMEM;
 	}
 	skb_put(skb, H2C_CAM_LEN);
-	rtw89_cam_fill_addr_cam_info(rtwdev, rtwvif_link, rtwsta, scan_mac_addr,
+	rtw89_cam_fill_addr_cam_info(rtwdev, rtwvif_link, rtwsta_link, scan_mac_addr,
 				     skb->data);
-	rtw89_cam_fill_bssid_cam_info(rtwdev, rtwvif_link, rtwsta, skb->data);
+	rtw89_cam_fill_bssid_cam_info(rtwdev, rtwvif_link, rtwsta_link, skb->data);
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_MAC,
@@ -1778,7 +1778,7 @@ int rtw89_fw_h2c_cam(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_lin
 
 int rtw89_fw_h2c_dctl_sec_cam_v1(struct rtw89_dev *rtwdev,
 				 struct rtw89_vif_link *rtwvif_link,
-				 struct rtw89_sta *rtwsta)
+				 struct rtw89_sta_link *rtwsta_link)
 {
 	struct rtw89_h2c_dctlinfo_ud_v1 *h2c;
 	u32 len = sizeof(*h2c);
@@ -1793,7 +1793,7 @@ int rtw89_fw_h2c_dctl_sec_cam_v1(struct rtw89_dev *rtwdev,
 	skb_put(skb, len);
 	h2c = (struct rtw89_h2c_dctlinfo_ud_v1 *)skb->data;
 
-	rtw89_cam_fill_dctl_sec_cam_info_v1(rtwdev, rtwvif_link, rtwsta, h2c);
+	rtw89_cam_fill_dctl_sec_cam_info_v1(rtwdev, rtwvif_link, rtwsta_link, h2c);
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_MAC,
@@ -1817,7 +1817,7 @@ EXPORT_SYMBOL(rtw89_fw_h2c_dctl_sec_cam_v1);
 
 int rtw89_fw_h2c_dctl_sec_cam_v2(struct rtw89_dev *rtwdev,
 				 struct rtw89_vif_link *rtwvif_link,
-				 struct rtw89_sta *rtwsta)
+				 struct rtw89_sta_link *rtwsta_link)
 {
 	struct rtw89_h2c_dctlinfo_ud_v2 *h2c;
 	u32 len = sizeof(*h2c);
@@ -1832,7 +1832,7 @@ int rtw89_fw_h2c_dctl_sec_cam_v2(struct rtw89_dev *rtwdev,
 	skb_put(skb, len);
 	h2c = (struct rtw89_h2c_dctlinfo_ud_v2 *)skb->data;
 
-	rtw89_cam_fill_dctl_sec_cam_info_v2(rtwdev, rtwvif_link, rtwsta, h2c);
+	rtw89_cam_fill_dctl_sec_cam_info_v2(rtwdev, rtwvif_link, rtwsta_link, h2c);
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_MAC,
@@ -1856,9 +1856,9 @@ EXPORT_SYMBOL(rtw89_fw_h2c_dctl_sec_cam_v2);
 
 int rtw89_fw_h2c_default_dmac_tbl_v2(struct rtw89_dev *rtwdev,
 				     struct rtw89_vif_link *rtwvif_link,
-				     struct rtw89_sta *rtwsta)
+				     struct rtw89_sta_link *rtwsta_link)
 {
-	u8 mac_id = rtwsta ? rtwsta->mac_id : rtwvif_link->mac_id;
+	u8 mac_id = rtwsta_link ? rtwsta_link->mac_id : rtwvif_link->mac_id;
 	struct rtw89_h2c_dctlinfo_ud_v2 *h2c;
 	u32 len = sizeof(*h2c);
 	struct sk_buff *skb;
@@ -1909,21 +1909,23 @@ int rtw89_fw_h2c_default_dmac_tbl_v2(struct rtw89_dev *rtwdev,
 }
 EXPORT_SYMBOL(rtw89_fw_h2c_default_dmac_tbl_v2);
 
-int rtw89_fw_h2c_ba_cam(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
+int rtw89_fw_h2c_ba_cam(struct rtw89_dev *rtwdev, struct rtw89_sta_link *rtwsta_link,
 			bool valid, struct ieee80211_ampdu_params *params)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
-	struct rtw89_vif_link *rtwvif_link = rtwsta->rtwvif_link;
+	struct rtw89_vif_link *rtwvif_link = rtwsta_link->rtwvif_link;
 	struct rtw89_h2c_ba_cam *h2c;
-	u8 macid = rtwsta->mac_id;
+	u8 macid = rtwsta_link->mac_id;
 	u32 len = sizeof(*h2c);
 	struct sk_buff *skb;
 	u8 entry_idx;
 	int ret;
 
 	ret = valid ?
-	      rtw89_core_acquire_sta_ba_entry(rtwdev, rtwsta, params->tid, &entry_idx) :
-	      rtw89_core_release_sta_ba_entry(rtwdev, rtwsta, params->tid, &entry_idx);
+	      rtw89_core_acquire_sta_ba_entry(rtwdev, rtwsta_link, params->tid,
+					      &entry_idx) :
+	      rtw89_core_release_sta_ba_entry(rtwdev, rtwsta_link, params->tid,
+					      &entry_idx);
 	if (ret) {
 		/* it still works even if we don't have static BA CAM, because
 		 * hardware can create dynamic BA CAM automatically.
@@ -2041,13 +2043,13 @@ void rtw89_fw_h2c_init_dynamic_ba_cam_v0_ext(struct rtw89_dev *rtwdev)
 	}
 }
 
-int rtw89_fw_h2c_ba_cam_v1(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
+int rtw89_fw_h2c_ba_cam_v1(struct rtw89_dev *rtwdev, struct rtw89_sta_link *rtwsta_link,
 			   bool valid, struct ieee80211_ampdu_params *params)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
-	struct rtw89_vif_link *rtwvif_link = rtwsta->rtwvif_link;
+	struct rtw89_vif_link *rtwvif_link = rtwsta_link->rtwvif_link;
 	struct rtw89_h2c_ba_cam_v1 *h2c;
-	u8 macid = rtwsta->mac_id;
+	u8 macid = rtwsta_link->mac_id;
 	u32 len = sizeof(*h2c);
 	struct sk_buff *skb;
 	u8 entry_idx;
@@ -2055,8 +2057,10 @@ int rtw89_fw_h2c_ba_cam_v1(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 	int ret;
 
 	ret = valid ?
-	      rtw89_core_acquire_sta_ba_entry(rtwdev, rtwsta, params->tid, &entry_idx) :
-	      rtw89_core_release_sta_ba_entry(rtwdev, rtwsta, params->tid, &entry_idx);
+	      rtw89_core_acquire_sta_ba_entry(rtwdev, rtwsta_link, params->tid,
+					      &entry_idx) :
+	      rtw89_core_release_sta_ba_entry(rtwdev, rtwsta_link, params->tid,
+					      &entry_idx);
 	if (ret) {
 		/* it still works even if we don't have static BA CAM, because
 		 * hardware can create dynamic BA CAM automatically.
@@ -2627,10 +2631,10 @@ static void __rtw89_fw_h2c_set_tx_path(struct rtw89_dev *rtwdev,
 #define H2C_CMC_TBL_LEN 68
 int rtw89_fw_h2c_default_cmac_tbl(struct rtw89_dev *rtwdev,
 				  struct rtw89_vif_link *rtwvif_link,
-				  struct rtw89_sta *rtwsta)
+				  struct rtw89_sta_link *rtwsta_link)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
-	u8 macid = rtwsta ? rtwsta->mac_id : rtwvif_link->mac_id;
+	u8 macid = rtwsta_link ? rtwsta_link->mac_id : rtwvif_link->mac_id;
 	struct sk_buff *skb;
 	int ret;
 
@@ -2676,9 +2680,9 @@ EXPORT_SYMBOL(rtw89_fw_h2c_default_cmac_tbl);
 
 int rtw89_fw_h2c_default_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 				     struct rtw89_vif_link *rtwvif_link,
-				     struct rtw89_sta *rtwsta)
+				     struct rtw89_sta_link *rtwsta_link)
 {
-	u8 mac_id = rtwsta ? rtwsta->mac_id : rtwvif_link->mac_id;
+	u8 mac_id = rtwsta_link ? rtwsta_link->mac_id : rtwvif_link->mac_id;
 	struct rtw89_h2c_cctlinfo_ud_g7 *h2c;
 	u32 len = sizeof(*h2c);
 	struct sk_buff *skb;
@@ -2817,13 +2821,13 @@ int rtw89_fw_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
 				struct ieee80211_sta *sta)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
-	struct rtw89_sta *rtwsta = sta_to_rtwsta_safe(sta);
+	struct rtw89_sta_link *rtwsta_link = sta_to_rtwsta_safe(sta);
 	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
 						       rtwvif_link->chanctx_idx);
 	struct sk_buff *skb;
 	u8 pads[RTW89_PPE_BW_NUM];
-	u8 mac_id = rtwsta ? rtwsta->mac_id : rtwvif_link->mac_id;
+	u8 mac_id = rtwsta_link ? rtwsta_link->mac_id : rtwvif_link->mac_id;
 	u16 lowest_rate;
 	int ret;
 
@@ -2954,9 +2958,9 @@ int rtw89_fw_h2c_assoc_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 				   struct ieee80211_sta *sta)
 {
 	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
-	struct rtw89_sta *rtwsta = sta_to_rtwsta_safe(sta);
+	struct rtw89_sta_link *rtwsta_link = sta_to_rtwsta_safe(sta);
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, rtwvif_link->chanctx_idx);
-	u8 mac_id = rtwsta ? rtwsta->mac_id : rtwvif_link->mac_id;
+	u8 mac_id = rtwsta_link ? rtwsta_link->mac_id : rtwvif_link->mac_id;
 	struct rtw89_h2c_cctlinfo_ud_g7 *h2c;
 	u8 pads[RTW89_PPE_BW_NUM];
 	u32 len = sizeof(*h2c);
@@ -3069,7 +3073,7 @@ int rtw89_fw_h2c_ampdu_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 				   struct ieee80211_vif *vif,
 				   struct ieee80211_sta *sta)
 {
-	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
+	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
 	struct rtw89_h2c_cctlinfo_ud_g7 *h2c;
 	u32 len = sizeof(*h2c);
 	struct sk_buff *skb;
@@ -3086,11 +3090,11 @@ int rtw89_fw_h2c_ampdu_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 	skb_put(skb, len);
 	h2c = (struct rtw89_h2c_cctlinfo_ud_g7 *)skb->data;
 
-	for_each_set_bit(tid, rtwsta->ampdu_map, IEEE80211_NUM_TIDS) {
+	for_each_set_bit(tid, rtwsta_link->ampdu_map, IEEE80211_NUM_TIDS) {
 		if (agg_num == 0)
-			agg_num = rtwsta->ampdu_params[tid].agg_num;
+			agg_num = rtwsta_link->ampdu_params[tid].agg_num;
 		else
-			agg_num = min(agg_num, rtwsta->ampdu_params[tid].agg_num);
+			agg_num = min(agg_num, rtwsta_link->ampdu_params[tid].agg_num);
 	}
 
 	if (agg_num <= 0x20)
@@ -3106,7 +3110,7 @@ int rtw89_fw_h2c_ampdu_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 	else if (agg_num > 0x200 && agg_num <= 0x400)
 		ba_bmap = 5;
 
-	h2c->c0 = le32_encode_bits(rtwsta->mac_id, CCTLINFO_G7_C0_MACID) |
+	h2c->c0 = le32_encode_bits(rtwsta_link->mac_id, CCTLINFO_G7_C0_MACID) |
 		  le32_encode_bits(1, CCTLINFO_G7_C0_OP);
 
 	h2c->w3 = le32_encode_bits(ba_bmap, CCTLINFO_G7_W3_BA_BMAP);
@@ -3132,7 +3136,7 @@ int rtw89_fw_h2c_ampdu_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 EXPORT_SYMBOL(rtw89_fw_h2c_ampdu_cmac_tbl_g7);
 
 int rtw89_fw_h2c_txtime_cmac_tbl(struct rtw89_dev *rtwdev,
-				 struct rtw89_sta *rtwsta)
+				 struct rtw89_sta_link *rtwsta_link)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct sk_buff *skb;
@@ -3144,15 +3148,15 @@ int rtw89_fw_h2c_txtime_cmac_tbl(struct rtw89_dev *rtwdev,
 		return -ENOMEM;
 	}
 	skb_put(skb, H2C_CMC_TBL_LEN);
-	SET_CTRL_INFO_MACID(skb->data, rtwsta->mac_id);
+	SET_CTRL_INFO_MACID(skb->data, rtwsta_link->mac_id);
 	SET_CTRL_INFO_OPERATION(skb->data, 1);
-	if (rtwsta->cctl_tx_time) {
+	if (rtwsta_link->cctl_tx_time) {
 		SET_CMC_TBL_AMPDU_TIME_SEL(skb->data, 1);
-		SET_CMC_TBL_AMPDU_MAX_TIME(skb->data, rtwsta->ampdu_max_time);
+		SET_CMC_TBL_AMPDU_MAX_TIME(skb->data, rtwsta_link->ampdu_max_time);
 	}
-	if (rtwsta->cctl_tx_retry_limit) {
+	if (rtwsta_link->cctl_tx_retry_limit) {
 		SET_CMC_TBL_DATA_TXCNT_LMT_SEL(skb->data, 1);
-		SET_CMC_TBL_DATA_TX_CNT_LMT(skb->data, rtwsta->data_tx_cnt_lmt);
+		SET_CMC_TBL_DATA_TX_CNT_LMT(skb->data, rtwsta_link->data_tx_cnt_lmt);
 	}
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
@@ -3174,7 +3178,7 @@ int rtw89_fw_h2c_txtime_cmac_tbl(struct rtw89_dev *rtwdev,
 }
 
 int rtw89_fw_h2c_txpath_cmac_tbl(struct rtw89_dev *rtwdev,
-				 struct rtw89_sta *rtwsta)
+				 struct rtw89_sta_link *rtwsta_link)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct sk_buff *skb;
@@ -3189,7 +3193,7 @@ int rtw89_fw_h2c_txpath_cmac_tbl(struct rtw89_dev *rtwdev,
 		return -ENOMEM;
 	}
 	skb_put(skb, H2C_CMC_TBL_LEN);
-	SET_CTRL_INFO_MACID(skb->data, rtwsta->mac_id);
+	SET_CTRL_INFO_MACID(skb->data, rtwsta_link->mac_id);
 	SET_CTRL_INFO_OPERATION(skb->data, 1);
 
 	__rtw89_fw_h2c_set_tx_path(rtwdev, skb);
@@ -3378,16 +3382,16 @@ EXPORT_SYMBOL(rtw89_fw_h2c_update_beacon_be);
 #define H2C_ROLE_MAINTAIN_LEN 4
 int rtw89_fw_h2c_role_maintain(struct rtw89_dev *rtwdev,
 			       struct rtw89_vif_link *rtwvif_link,
-			       struct rtw89_sta *rtwsta,
+			       struct rtw89_sta_link *rtwsta_link,
 			       enum rtw89_upd_mode upd_mode)
 {
 	struct sk_buff *skb;
-	u8 mac_id = rtwsta ? rtwsta->mac_id : rtwvif_link->mac_id;
+	u8 mac_id = rtwsta_link ? rtwsta_link->mac_id : rtwvif_link->mac_id;
 	u8 self_role;
 	int ret;
 
 	if (rtwvif_link->net_type == RTW89_NET_TYPE_AP_MODE) {
-		if (rtwsta)
+		if (rtwsta_link)
 			self_role = RTW89_SELF_ROLE_AP_CLIENT;
 		else
 			self_role = rtwvif_link->self_role;
@@ -3426,9 +3430,9 @@ int rtw89_fw_h2c_role_maintain(struct rtw89_dev *rtwdev,
 
 static enum rtw89_fw_sta_type
 rtw89_fw_get_sta_type(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
-		      struct rtw89_sta *rtwsta)
+		      struct rtw89_sta_link *rtwsta_link)
 {
-	struct ieee80211_sta *sta = rtwsta_to_sta_safe(rtwsta);
+	struct ieee80211_sta *sta = rtwsta_to_sta_safe(rtwsta_link);
 	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
 
 	if (!sta)
@@ -3451,10 +3455,10 @@ rtw89_fw_get_sta_type(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_li
 }
 
 int rtw89_fw_h2c_join_info(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
-			   struct rtw89_sta *rtwsta, bool dis_conn)
+			   struct rtw89_sta_link *rtwsta_link, bool dis_conn)
 {
 	struct sk_buff *skb;
-	u8 mac_id = rtwsta ? rtwsta->mac_id : rtwvif_link->mac_id;
+	u8 mac_id = rtwsta_link ? rtwsta_link->mac_id : rtwvif_link->mac_id;
 	u8 self_role = rtwvif_link->self_role;
 	enum rtw89_fw_sta_type sta_type;
 	u8 net_type = rtwvif_link->net_type;
@@ -3469,7 +3473,7 @@ int rtw89_fw_h2c_join_info(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwv
 		format_v1 = true;
 	}
 
-	if (net_type == RTW89_NET_TYPE_AP_MODE && rtwsta) {
+	if (net_type == RTW89_NET_TYPE_AP_MODE && rtwsta_link) {
 		self_role = RTW89_SELF_ROLE_AP_CLIENT;
 		net_type = dis_conn ? RTW89_NET_TYPE_NO_LINK : net_type;
 	}
@@ -3502,7 +3506,7 @@ int rtw89_fw_h2c_join_info(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwv
 
 	h2c_v1 = (struct rtw89_h2c_join_v1 *)skb->data;
 
-	sta_type = rtw89_fw_get_sta_type(rtwdev, rtwvif_link, rtwsta);
+	sta_type = rtw89_fw_get_sta_type(rtwdev, rtwvif_link, rtwsta_link);
 
 	h2c_v1->w1 = le32_encode_bits(sta_type, RTW89_H2C_JOININFO_W1_STA_TYPE);
 	h2c_v1->w2 = 0;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 4e2f7a478d75..00e52a33516b 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -4405,13 +4405,13 @@ void rtw89_h2c_pkt_set_hdr(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 			   bool rack, bool dack, u32 len);
 int rtw89_fw_h2c_default_cmac_tbl(struct rtw89_dev *rtwdev,
 				  struct rtw89_vif_link *rtwvif_link,
-				  struct rtw89_sta *rtwsta);
+				  struct rtw89_sta_link *rtwsta_link);
 int rtw89_fw_h2c_default_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 				     struct rtw89_vif_link *rtwvif_link,
-				     struct rtw89_sta *rtwsta);
+				     struct rtw89_sta_link *rtwsta_link);
 int rtw89_fw_h2c_default_dmac_tbl_v2(struct rtw89_dev *rtwdev,
 				     struct rtw89_vif_link *rtwvif_link,
-				     struct rtw89_sta *rtwsta);
+				     struct rtw89_sta_link *rtwsta_link);
 int rtw89_fw_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
 				struct ieee80211_vif *vif,
 				struct ieee80211_sta *sta);
@@ -4422,29 +4422,29 @@ int rtw89_fw_h2c_ampdu_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 				   struct ieee80211_vif *vif,
 				   struct ieee80211_sta *sta);
 int rtw89_fw_h2c_txtime_cmac_tbl(struct rtw89_dev *rtwdev,
-				 struct rtw89_sta *rtwsta);
+				 struct rtw89_sta_link *rtwsta_link);
 int rtw89_fw_h2c_txpath_cmac_tbl(struct rtw89_dev *rtwdev,
-				 struct rtw89_sta *rtwsta);
+				 struct rtw89_sta_link *rtwsta_link);
 int rtw89_fw_h2c_update_beacon(struct rtw89_dev *rtwdev,
 			       struct rtw89_vif_link *rtwvif_link);
 int rtw89_fw_h2c_update_beacon_be(struct rtw89_dev *rtwdev,
 				  struct rtw89_vif_link *rtwvif_link);
 int rtw89_fw_h2c_cam(struct rtw89_dev *rtwdev, struct rtw89_vif_link *vif,
-		     struct rtw89_sta *rtwsta, const u8 *scan_mac_addr);
+		     struct rtw89_sta_link *rtwsta_link, const u8 *scan_mac_addr);
 int rtw89_fw_h2c_dctl_sec_cam_v1(struct rtw89_dev *rtwdev,
 				 struct rtw89_vif_link *rtwvif_link,
-				 struct rtw89_sta *rtwsta);
+				 struct rtw89_sta_link *rtwsta_link);
 int rtw89_fw_h2c_dctl_sec_cam_v2(struct rtw89_dev *rtwdev,
 				 struct rtw89_vif_link *rtwvif_link,
-				 struct rtw89_sta *rtwsta);
+				 struct rtw89_sta_link *rtwsta_link);
 void rtw89_fw_c2h_irqsafe(struct rtw89_dev *rtwdev, struct sk_buff *c2h);
 void rtw89_fw_c2h_work(struct work_struct *work);
 int rtw89_fw_h2c_role_maintain(struct rtw89_dev *rtwdev,
 			       struct rtw89_vif_link *rtwvif_link,
-			       struct rtw89_sta *rtwsta,
+			       struct rtw89_sta_link *rtwsta_link,
 			       enum rtw89_upd_mode upd_mode);
 int rtw89_fw_h2c_join_info(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
-			   struct rtw89_sta *rtwsta, bool dis_conn);
+			   struct rtw89_sta_link *rtwsta_link, bool dis_conn);
 int rtw89_fw_h2c_notify_dbcc(struct rtw89_dev *rtwdev, bool en);
 int rtw89_fw_h2c_macid_pause(struct rtw89_dev *rtwdev, u8 sh, u8 grp,
 			     bool pause);
@@ -4514,9 +4514,9 @@ void rtw89_fw_release_general_pkt_list_vif(struct rtw89_dev *rtwdev,
 					   struct rtw89_vif_link *rtwvif_link,
 					   bool notify_fw);
 void rtw89_fw_release_general_pkt_list(struct rtw89_dev *rtwdev, bool notify_fw);
-int rtw89_fw_h2c_ba_cam(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
+int rtw89_fw_h2c_ba_cam(struct rtw89_dev *rtwdev, struct rtw89_sta_link *rtwsta_link,
 			bool valid, struct ieee80211_ampdu_params *params);
-int rtw89_fw_h2c_ba_cam_v1(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
+int rtw89_fw_h2c_ba_cam_v1(struct rtw89_dev *rtwdev, struct rtw89_sta_link *rtwsta_link,
 			   bool valid, struct ieee80211_ampdu_params *params);
 void rtw89_fw_h2c_init_dynamic_ba_cam_v0_ext(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_init_ba_cam_users(struct rtw89_dev *rtwdev, u8 users,
@@ -4624,21 +4624,21 @@ static inline void rtw89_fw_h2c_init_ba_cam(struct rtw89_dev *rtwdev)
 
 static inline int rtw89_chip_h2c_default_cmac_tbl(struct rtw89_dev *rtwdev,
 						  struct rtw89_vif_link *rtwvif_link,
-						  struct rtw89_sta *rtwsta)
+						  struct rtw89_sta_link *rtwsta_link)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 
-	return chip->ops->h2c_default_cmac_tbl(rtwdev, rtwvif_link, rtwsta);
+	return chip->ops->h2c_default_cmac_tbl(rtwdev, rtwvif_link, rtwsta_link);
 }
 
 static inline int rtw89_chip_h2c_default_dmac_tbl(struct rtw89_dev *rtwdev,
 						  struct rtw89_vif_link *rtwvif_link,
-						  struct rtw89_sta *rtwsta)
+						  struct rtw89_sta_link *rtwsta_link)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 
 	if (chip->ops->h2c_default_dmac_tbl)
-		return chip->ops->h2c_default_dmac_tbl(rtwdev, rtwvif_link, rtwsta);
+		return chip->ops->h2c_default_dmac_tbl(rtwdev, rtwvif_link, rtwsta_link);
 
 	return 0;
 }
@@ -4673,12 +4673,12 @@ static inline int rtw89_chip_h2c_ampdu_cmac_tbl(struct rtw89_dev *rtwdev,
 }
 
 static inline
-int rtw89_chip_h2c_ba_cam(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
+int rtw89_chip_h2c_ba_cam(struct rtw89_dev *rtwdev, struct rtw89_sta_link *rtwsta_link,
 			  bool valid, struct ieee80211_ampdu_params *params)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 
-	return chip->ops->h2c_ba_cam(rtwdev, rtwsta, valid, params);
+	return chip->ops->h2c_ba_cam(rtwdev, rtwsta_link, valid, params);
 }
 
 /* must consider compatibility; don't insert new in the mid */
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index e1956c722436..d6cd3ed1e7fc 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -6160,18 +6160,18 @@ void _rtw89_mac_bf_monitor_track(struct rtw89_dev *rtwdev)
 }
 
 static int
-__rtw89_mac_set_tx_time(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
+__rtw89_mac_set_tx_time(struct rtw89_dev *rtwdev, struct rtw89_sta_link *rtwsta_link,
 			u32 tx_time)
 {
 #define MAC_AX_DFLT_TX_TIME 5280
-	u8 mac_idx = rtwsta->rtwvif_link->mac_idx;
+	u8 mac_idx = rtwsta_link->rtwvif_link->mac_idx;
 	u32 max_tx_time = tx_time == 0 ? MAC_AX_DFLT_TX_TIME : tx_time;
 	u32 reg;
 	int ret = 0;
 
-	if (rtwsta->cctl_tx_time) {
-		rtwsta->ampdu_max_time = (max_tx_time - 512) >> 9;
-		ret = rtw89_fw_h2c_txtime_cmac_tbl(rtwdev, rtwsta);
+	if (rtwsta_link->cctl_tx_time) {
+		rtwsta_link->ampdu_max_time = (max_tx_time - 512) >> 9;
+		ret = rtw89_fw_h2c_txtime_cmac_tbl(rtwdev, rtwsta_link);
 	} else {
 		ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
 		if (ret) {
@@ -6187,31 +6187,31 @@ __rtw89_mac_set_tx_time(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 	return ret;
 }
 
-int rtw89_mac_set_tx_time(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
+int rtw89_mac_set_tx_time(struct rtw89_dev *rtwdev, struct rtw89_sta_link *rtwsta_link,
 			  bool resume, u32 tx_time)
 {
 	int ret = 0;
 
 	if (!resume) {
-		rtwsta->cctl_tx_time = true;
-		ret = __rtw89_mac_set_tx_time(rtwdev, rtwsta, tx_time);
+		rtwsta_link->cctl_tx_time = true;
+		ret = __rtw89_mac_set_tx_time(rtwdev, rtwsta_link, tx_time);
 	} else {
-		ret = __rtw89_mac_set_tx_time(rtwdev, rtwsta, tx_time);
-		rtwsta->cctl_tx_time = false;
+		ret = __rtw89_mac_set_tx_time(rtwdev, rtwsta_link, tx_time);
+		rtwsta_link->cctl_tx_time = false;
 	}
 
 	return ret;
 }
 
-int rtw89_mac_get_tx_time(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
+int rtw89_mac_get_tx_time(struct rtw89_dev *rtwdev, struct rtw89_sta_link *rtwsta_link,
 			  u32 *tx_time)
 {
-	u8 mac_idx = rtwsta->rtwvif_link->mac_idx;
+	u8 mac_idx = rtwsta_link->rtwvif_link->mac_idx;
 	u32 reg;
 	int ret = 0;
 
-	if (rtwsta->cctl_tx_time) {
-		*tx_time = (rtwsta->ampdu_max_time + 1) << 9;
+	if (rtwsta_link->cctl_tx_time) {
+		*tx_time = (rtwsta_link->ampdu_max_time + 1) << 9;
 	} else {
 		ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
 		if (ret) {
@@ -6227,33 +6227,33 @@ int rtw89_mac_get_tx_time(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 }
 
 int rtw89_mac_set_tx_retry_limit(struct rtw89_dev *rtwdev,
-				 struct rtw89_sta *rtwsta,
+				 struct rtw89_sta_link *rtwsta_link,
 				 bool resume, u8 tx_retry)
 {
 	int ret = 0;
 
-	rtwsta->data_tx_cnt_lmt = tx_retry;
+	rtwsta_link->data_tx_cnt_lmt = tx_retry;
 
 	if (!resume) {
-		rtwsta->cctl_tx_retry_limit = true;
-		ret = rtw89_fw_h2c_txtime_cmac_tbl(rtwdev, rtwsta);
+		rtwsta_link->cctl_tx_retry_limit = true;
+		ret = rtw89_fw_h2c_txtime_cmac_tbl(rtwdev, rtwsta_link);
 	} else {
-		ret = rtw89_fw_h2c_txtime_cmac_tbl(rtwdev, rtwsta);
-		rtwsta->cctl_tx_retry_limit = false;
+		ret = rtw89_fw_h2c_txtime_cmac_tbl(rtwdev, rtwsta_link);
+		rtwsta_link->cctl_tx_retry_limit = false;
 	}
 
 	return ret;
 }
 
 int rtw89_mac_get_tx_retry_limit(struct rtw89_dev *rtwdev,
-				 struct rtw89_sta *rtwsta, u8 *tx_retry)
+				 struct rtw89_sta_link *rtwsta_link, u8 *tx_retry)
 {
-	u8 mac_idx = rtwsta->rtwvif_link->mac_idx;
+	u8 mac_idx = rtwsta_link->rtwvif_link->mac_idx;
 	u32 reg;
 	int ret = 0;
 
-	if (rtwsta->cctl_tx_retry_limit) {
-		*tx_retry = rtwsta->data_tx_cnt_lmt;
+	if (rtwsta_link->cctl_tx_retry_limit) {
+		*tx_retry = rtwsta_link->data_tx_cnt_lmt;
 	} else {
 		ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
 		if (ret) {
@@ -6340,7 +6340,7 @@ int rtw89_mac_read_xtal_si_ax(struct rtw89_dev *rtwdev, u8 offset, u8 *val)
 }
 
 static
-void rtw89_mac_pkt_drop_sta(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta)
+void rtw89_mac_pkt_drop_sta(struct rtw89_dev *rtwdev, struct rtw89_sta_link *rtwsta_link)
 {
 	static const enum rtw89_pkt_drop_sel sels[] = {
 		RTW89_PKT_DROP_SEL_MACID_BE_ONCE,
@@ -6348,12 +6348,12 @@ void rtw89_mac_pkt_drop_sta(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta)
 		RTW89_PKT_DROP_SEL_MACID_VI_ONCE,
 		RTW89_PKT_DROP_SEL_MACID_VO_ONCE,
 	};
-	struct rtw89_vif_link *rtwvif_link = rtwsta->rtwvif_link;
+	struct rtw89_vif_link *rtwvif_link = rtwsta_link->rtwvif_link;
 	struct rtw89_pkt_drop_params params = {0};
 	int i;
 
 	params.mac_band = RTW89_MAC_0;
-	params.macid = rtwsta->mac_id;
+	params.macid = rtwsta_link->mac_id;
 	params.port = rtwvif_link->port;
 	params.mbssid = 0;
 	params.tf_trs = rtwvif_link->trigger;
@@ -6366,15 +6366,15 @@ void rtw89_mac_pkt_drop_sta(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta)
 
 static void rtw89_mac_pkt_drop_vif_iter(void *data, struct ieee80211_sta *sta)
 {
-	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
-	struct rtw89_vif_link *rtwvif_link = rtwsta->rtwvif_link;
+	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = rtwsta_link->rtwvif_link;
 	struct rtw89_dev *rtwdev = rtwvif_link->rtwdev;
 	struct rtw89_vif_link *target = data;
 
 	if (rtwvif_link != target)
 		return;
 
-	rtw89_mac_pkt_drop_sta(rtwdev, rtwsta);
+	rtw89_mac_pkt_drop_sta(rtwdev, rtwsta_link);
 }
 
 void rtw89_mac_pkt_drop_vif(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link)
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 6839028991d4..3ea2dcbfa5b8 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1384,15 +1384,15 @@ static inline bool rtw89_mac_get_power_state(struct rtw89_dev *rtwdev)
 	return !!val;
 }
 
-int rtw89_mac_set_tx_time(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
+int rtw89_mac_set_tx_time(struct rtw89_dev *rtwdev, struct rtw89_sta_link *rtwsta_link,
 			  bool resume, u32 tx_time);
-int rtw89_mac_get_tx_time(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
+int rtw89_mac_get_tx_time(struct rtw89_dev *rtwdev, struct rtw89_sta_link *rtwsta_link,
 			  u32 *tx_time);
 int rtw89_mac_set_tx_retry_limit(struct rtw89_dev *rtwdev,
-				 struct rtw89_sta *rtwsta,
+				 struct rtw89_sta_link *rtwsta_link,
 				 bool resume, u8 tx_retry);
 int rtw89_mac_get_tx_retry_limit(struct rtw89_dev *rtwdev,
-				 struct rtw89_sta *rtwsta, u8 *tx_retry);
+				 struct rtw89_sta_link *rtwsta_link, u8 *tx_retry);
 
 enum rtw89_mac_xtal_si_offset {
 	XTAL0 = 0x0,
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index bc0ff64c1c98..392a38fcf461 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -29,10 +29,11 @@ static void rtw89_ops_tx(struct ieee80211_hw *hw,
 	int ret, qsel;
 
 	if (rtwvif_link->offchan && !(flags & IEEE80211_TX_CTL_TX_OFFCHAN) && sta) {
-		struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
+		struct rtw89_sta_link *rtwsta_link =
+			(struct rtw89_sta_link *)sta->drv_priv;
 
 		rtw89_debug(rtwdev, RTW89_DBG_TXRX, "ops_tx during offchan\n");
-		skb_queue_tail(&rtwsta->roc_queue, skb);
+		skb_queue_tail(&rtwsta_link->roc_queue, skb);
 		return;
 	}
 
@@ -548,8 +549,8 @@ static int rtw89_ops_set_tim(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
 			     bool set)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
-	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
-	struct rtw89_vif_link *rtwvif_link = rtwsta->rtwvif_link;
+	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = rtwsta_link->rtwvif_link;
 
 	ieee80211_queue_work(rtwdev->hw, &rtwvif_link->update_beacon_work);
 
@@ -668,7 +669,7 @@ static int rtw89_ops_ampdu_action(struct ieee80211_hw *hw,
 {
 	struct rtw89_dev *rtwdev = hw->priv;
 	struct ieee80211_sta *sta = params->sta;
-	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
+	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
 	u16 tid = params->tid;
 	struct ieee80211_txq *txq = sta->txq[tid];
 	struct rtw89_txq *rtwtxq = (struct rtw89_txq *)txq->drv_priv;
@@ -681,7 +682,7 @@ static int rtw89_ops_ampdu_action(struct ieee80211_hw *hw,
 	case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
 		mutex_lock(&rtwdev->mutex);
 		clear_bit(RTW89_TXQ_F_AMPDU, &rtwtxq->flags);
-		clear_bit(tid, rtwsta->ampdu_map);
+		clear_bit(tid, rtwsta_link->ampdu_map);
 		rtw89_chip_h2c_ampdu_cmac_tbl(rtwdev, vif, sta);
 		mutex_unlock(&rtwdev->mutex);
 		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
@@ -689,21 +690,21 @@ static int rtw89_ops_ampdu_action(struct ieee80211_hw *hw,
 	case IEEE80211_AMPDU_TX_OPERATIONAL:
 		mutex_lock(&rtwdev->mutex);
 		set_bit(RTW89_TXQ_F_AMPDU, &rtwtxq->flags);
-		rtwsta->ampdu_params[tid].agg_num = params->buf_size;
-		rtwsta->ampdu_params[tid].amsdu = params->amsdu;
-		set_bit(tid, rtwsta->ampdu_map);
+		rtwsta_link->ampdu_params[tid].agg_num = params->buf_size;
+		rtwsta_link->ampdu_params[tid].amsdu = params->amsdu;
+		set_bit(tid, rtwsta_link->ampdu_map);
 		rtw89_leave_ps_mode(rtwdev);
 		rtw89_chip_h2c_ampdu_cmac_tbl(rtwdev, vif, sta);
 		mutex_unlock(&rtwdev->mutex);
 		break;
 	case IEEE80211_AMPDU_RX_START:
 		mutex_lock(&rtwdev->mutex);
-		rtw89_chip_h2c_ba_cam(rtwdev, rtwsta, true, params);
+		rtw89_chip_h2c_ba_cam(rtwdev, rtwsta_link, true, params);
 		mutex_unlock(&rtwdev->mutex);
 		break;
 	case IEEE80211_AMPDU_RX_STOP:
 		mutex_lock(&rtwdev->mutex);
-		rtw89_chip_h2c_ba_cam(rtwdev, rtwsta, false, params);
+		rtw89_chip_h2c_ba_cam(rtwdev, rtwsta_link, false, params);
 		mutex_unlock(&rtwdev->mutex);
 		break;
 	default:
@@ -732,9 +733,9 @@ static void rtw89_ops_sta_statistics(struct ieee80211_hw *hw,
 				     struct ieee80211_sta *sta,
 				     struct station_info *sinfo)
 {
-	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
+	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
 
-	sinfo->txrate = rtwsta->ra_report.txrate;
+	sinfo->txrate = rtwsta_link->ra_report.txrate;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
 }
 
@@ -778,14 +779,14 @@ struct rtw89_iter_bitrate_mask_data {
 static void rtw89_ra_mask_info_update_iter(void *data, struct ieee80211_sta *sta)
 {
 	struct rtw89_iter_bitrate_mask_data *br_data = data;
-	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwsta->rtwvif_link);
+	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwsta_link->rtwvif_link);
 
 	if (vif != br_data->vif || vif->p2p)
 		return;
 
-	rtwsta->use_cfg_mask = true;
-	rtwsta->mask = *br_data->mask;
+	rtwsta_link->use_cfg_mask = true;
+	rtwsta_link->mask = *br_data->mask;
 	rtw89_phy_ra_update_sta(br_data->rtwdev, sta, IEEE80211_RC_SUPP_RATES_CHANGED);
 }
 
@@ -1054,8 +1055,8 @@ static int rtw89_ops_cancel_remain_on_channel(struct ieee80211_hw *hw,
 static void rtw89_set_tid_config_iter(void *data, struct ieee80211_sta *sta)
 {
 	struct cfg80211_tid_config *tid_config = data;
-	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
-	struct rtw89_dev *rtwdev = rtwsta->rtwvif_link->rtwdev;
+	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
+	struct rtw89_dev *rtwdev = rtwsta_link->rtwvif_link->rtwdev;
 
 	rtw89_core_set_tid_config(rtwdev, sta, tid_config);
 }
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 742720f1a429..e632e74601cb 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -195,15 +195,16 @@ static u64 rtw89_phy_ra_mask_recover(u64 ra_mask, u64 ra_mask_bak)
 	return ra_mask;
 }
 
-static u64 rtw89_phy_ra_mask_cfg(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
+static u64 rtw89_phy_ra_mask_cfg(struct rtw89_dev *rtwdev,
+				 struct rtw89_sta_link *rtwsta_link,
 				 const struct rtw89_chan *chan)
 {
-	struct ieee80211_sta *sta = rtwsta_to_sta(rtwsta);
-	struct cfg80211_bitrate_mask *mask = &rtwsta->mask;
+	struct ieee80211_sta *sta = rtwsta_to_sta(rtwsta_link);
+	struct cfg80211_bitrate_mask *mask = &rtwsta_link->mask;
 	enum nl80211_band band;
 	u64 cfg_mask;
 
-	if (!rtwsta->use_cfg_mask)
+	if (!rtwsta_link->use_cfg_mask)
 		return -1;
 
 	switch (chan->band_type) {
@@ -261,17 +262,17 @@ rtw89_ra_mask_eht_rates[4] = {RA_MASK_EHT_1SS_RATES, RA_MASK_EHT_2SS_RATES,
 			      RA_MASK_EHT_3SS_RATES, RA_MASK_EHT_4SS_RATES};
 
 static void rtw89_phy_ra_gi_ltf(struct rtw89_dev *rtwdev,
-				struct rtw89_sta *rtwsta,
+				struct rtw89_sta_link *rtwsta_link,
 				const struct rtw89_chan *chan,
 				bool *fix_giltf_en, u8 *fix_giltf)
 {
-	struct cfg80211_bitrate_mask *mask = &rtwsta->mask;
+	struct cfg80211_bitrate_mask *mask = &rtwsta_link->mask;
 	u8 band = chan->band_type;
 	enum nl80211_band nl_band = rtw89_hw_to_nl80211_band(band);
 	u8 he_gi = mask->control[nl_band].he_gi;
 	u8 he_ltf = mask->control[nl_band].he_ltf;
 
-	if (!rtwsta->use_cfg_mask)
+	if (!rtwsta_link->use_cfg_mask)
 		return;
 
 	if (he_ltf == 2 && he_gi == 2) {
@@ -297,15 +298,15 @@ static void rtw89_phy_ra_gi_ltf(struct rtw89_dev *rtwdev,
 static void rtw89_phy_ra_sta_update(struct rtw89_dev *rtwdev,
 				    struct ieee80211_sta *sta, bool csi)
 {
-	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
-	struct rtw89_vif_link *rtwvif_link = rtwsta->rtwvif_link;
+	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = rtwsta_link->rtwvif_link;
 	struct rtw89_phy_rate_pattern *rate_pattern = &rtwvif_link->rate_pattern;
-	struct rtw89_ra_info *ra = &rtwsta->ra;
+	struct rtw89_ra_info *ra = &rtwsta_link->ra;
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
 						       rtwvif_link->chanctx_idx);
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwsta->rtwvif_link);
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwsta_link->rtwvif_link);
 	const u64 *high_rate_masks = rtw89_ra_mask_ht_rates;
-	u8 rssi = ewma_rssi_read(&rtwsta->avg_rssi);
+	u8 rssi = ewma_rssi_read(&rtwsta_link->avg_rssi);
 	u64 ra_mask = 0;
 	u64 ra_mask_bak;
 	u8 mode = 0;
@@ -335,7 +336,7 @@ static void rtw89_phy_ra_sta_update(struct rtw89_dev *rtwdev,
 		if (sta->deflink.he_cap.he_cap_elem.phy_cap_info[1] &
 		    IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD)
 			ldpc_en = 1;
-		rtw89_phy_ra_gi_ltf(rtwdev, rtwsta, chan, &fix_giltf_en, &fix_giltf);
+		rtw89_phy_ra_gi_ltf(rtwdev, rtwsta_link, chan, &fix_giltf_en, &fix_giltf);
 	} else if (sta->deflink.vht_cap.vht_supported) {
 		u16 mcs_map = le16_to_cpu(sta->deflink.vht_cap.vht_mcs.rx_mcs_map);
 
@@ -405,7 +406,7 @@ static void rtw89_phy_ra_sta_update(struct rtw89_dev *rtwdev,
 		ra_mask &= rtw89_phy_ra_mask_rssi(rtwdev, rssi, 0);
 
 	ra_mask = rtw89_phy_ra_mask_recover(ra_mask, ra_mask_bak);
-	ra_mask &= rtw89_phy_ra_mask_cfg(rtwdev, rtwsta, chan);
+	ra_mask &= rtw89_phy_ra_mask_cfg(rtwdev, rtwsta_link, chan);
 
 	switch (sta->deflink.bandwidth) {
 	case IEEE80211_STA_RX_BW_160:
@@ -435,15 +436,15 @@ static void rtw89_phy_ra_sta_update(struct rtw89_dev *rtwdev,
 		ra->dcm_cap = 1;
 
 	if (rate_pattern->enable && !vif->p2p) {
-		ra_mask = rtw89_phy_ra_mask_cfg(rtwdev, rtwsta, chan);
+		ra_mask = rtw89_phy_ra_mask_cfg(rtwdev, rtwsta_link, chan);
 		ra_mask &= rate_pattern->ra_mask;
 		mode = rate_pattern->ra_mode;
 	}
 
 	ra->bw_cap = bw_mode;
-	ra->er_cap = rtwsta->er_cap;
+	ra->er_cap = rtwsta_link->er_cap;
 	ra->mode_ctrl = mode;
-	ra->macid = rtwsta->mac_id;
+	ra->macid = rtwsta_link->mac_id;
 	ra->stbc_cap = stbc_en;
 	ra->ldpc_cap = ldpc_en;
 	ra->ss_num = min(sta->deflink.rx_nss, rtwdev->hal.tx_nss) - 1;
@@ -468,8 +469,8 @@ static void rtw89_phy_ra_sta_update(struct rtw89_dev *rtwdev,
 void rtw89_phy_ra_update_sta(struct rtw89_dev *rtwdev, struct ieee80211_sta *sta,
 			     u32 changed)
 {
-	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
-	struct rtw89_ra_info *ra = &rtwsta->ra;
+	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
+	struct rtw89_ra_info *ra = &rtwsta_link->ra;
 
 	rtw89_phy_ra_sta_update(rtwdev, sta, false);
 
@@ -629,9 +630,9 @@ void rtw89_phy_ra_update(struct rtw89_dev *rtwdev)
 
 void rtw89_phy_ra_assoc(struct rtw89_dev *rtwdev, struct ieee80211_sta *sta)
 {
-	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
-	struct rtw89_ra_info *ra = &rtwsta->ra;
-	u8 rssi = ewma_rssi_read(&rtwsta->avg_rssi) >> RSSI_FACTOR;
+	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
+	struct rtw89_ra_info *ra = &rtwsta_link->ra;
+	u8 rssi = ewma_rssi_read(&rtwsta_link->avg_rssi) >> RSSI_FACTOR;
 	bool csi = rtw89_sta_has_beamformer_cap(sta);
 
 	rtw89_phy_ra_sta_update(rtwdev, sta, csi);
@@ -2557,10 +2558,10 @@ static void rtw89_phy_c2h_ra_rpt_iter(void *data, struct ieee80211_sta *sta)
 {
 	struct rtw89_phy_iter_ra_data *ra_data = (struct rtw89_phy_iter_ra_data *)data;
 	struct rtw89_dev *rtwdev = ra_data->rtwdev;
-	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
+	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
 	const struct rtw89_c2h_ra_rpt *c2h =
 		(const struct rtw89_c2h_ra_rpt *)ra_data->c2h->data;
-	struct rtw89_ra_report *ra_report = &rtwsta->ra_report;
+	struct rtw89_ra_report *ra_report = &rtwsta_link->ra_report;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	bool format_v1 = chip->chip_gen == RTW89_CHIP_BE;
 	u8 mode, rate, bw, giltf, mac_id;
@@ -2570,7 +2571,7 @@ static void rtw89_phy_c2h_ra_rpt_iter(void *data, struct ieee80211_sta *sta)
 	u8 t;
 
 	mac_id = le32_get_bits(c2h->w2, RTW89_C2H_RA_RPT_W2_MACID);
-	if (mac_id != rtwsta->mac_id)
+	if (mac_id != rtwsta_link->mac_id)
 		return;
 
 	rate = le32_get_bits(c2h->w3, RTW89_C2H_RA_RPT_W3_MCSNSS);
@@ -2662,7 +2663,7 @@ static void rtw89_phy_c2h_ra_rpt_iter(void *data, struct ieee80211_sta *sta)
 			     u16_encode_bits(rate, RTW89_HW_RATE_MASK_VAL);
 	ra_report->might_fallback_legacy = mcs <= 2;
 	sta->deflink.agg.max_rc_amsdu_len = get_max_amsdu_len(rtwdev, ra_report);
-	rtwsta->max_agg_wait = sta->deflink.agg.max_rc_amsdu_len / 1500 - 1;
+	rtwsta_link->max_agg_wait = sta->deflink.agg.max_rc_amsdu_len / 1500 - 1;
 }
 
 static void
@@ -4629,23 +4630,24 @@ struct rtw89_phy_iter_rssi_data {
 static void rtw89_phy_stat_rssi_update_iter(void *data,
 					    struct ieee80211_sta *sta)
 {
-	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
+	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
 	struct rtw89_phy_iter_rssi_data *rssi_data =
 					(struct rtw89_phy_iter_rssi_data *)data;
 	struct rtw89_phy_ch_info *ch_info = rssi_data->ch_info;
 	unsigned long rssi_curr;
 
-	rssi_curr = ewma_rssi_read(&rtwsta->avg_rssi);
+	rssi_curr = ewma_rssi_read(&rtwsta_link->avg_rssi);
 
 	if (rssi_curr < ch_info->rssi_min) {
 		ch_info->rssi_min = rssi_curr;
-		ch_info->rssi_min_macid = rtwsta->mac_id;
+		ch_info->rssi_min_macid = rtwsta_link->mac_id;
 	}
 
-	if (rtwsta->prev_rssi == 0) {
-		rtwsta->prev_rssi = rssi_curr;
-	} else if (abs((int)rtwsta->prev_rssi - (int)rssi_curr) > (3 << RSSI_FACTOR)) {
-		rtwsta->prev_rssi = rssi_curr;
+	if (rtwsta_link->prev_rssi == 0) {
+		rtwsta_link->prev_rssi = rssi_curr;
+	} else if (abs((int)rtwsta_link->prev_rssi - (int)rssi_curr) >
+		   (3 << RSSI_FACTOR)) {
+		rtwsta_link->prev_rssi = rssi_curr;
 		rssi_data->rssi_changed = true;
 	}
 }
@@ -5755,9 +5757,9 @@ void rtw89_phy_dig(struct rtw89_dev *rtwdev)
 
 static void rtw89_phy_tx_path_div_sta_iter(void *data, struct ieee80211_sta *sta)
 {
-	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
-	struct rtw89_dev *rtwdev = rtwsta->rtwdev;
-	struct rtw89_vif_link *rtwvif_link = rtwsta->rtwvif_link;
+	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
+	struct rtw89_dev *rtwdev = rtwsta_link->rtwdev;
+	struct rtw89_vif_link *rtwvif_link = rtwsta_link->rtwvif_link;
 	struct rtw89_hal *hal = &rtwdev->hal;
 	bool *done = data;
 	u8 rssi_a, rssi_b;
@@ -5771,8 +5773,8 @@ static void rtw89_phy_tx_path_div_sta_iter(void *data, struct ieee80211_sta *sta
 
 	*done = true;
 
-	rssi_a = ewma_rssi_read(&rtwsta->rssi[RF_PATH_A]);
-	rssi_b = ewma_rssi_read(&rtwsta->rssi[RF_PATH_B]);
+	rssi_a = ewma_rssi_read(&rtwsta_link->rssi[RF_PATH_A]);
+	rssi_b = ewma_rssi_read(&rtwsta_link->rssi[RF_PATH_B]);
 
 	if (rssi_a > rssi_b + RTW89_TX_DIV_RSSI_RAW_TH)
 		candidate = RF_A;
@@ -5785,7 +5787,7 @@ static void rtw89_phy_tx_path_div_sta_iter(void *data, struct ieee80211_sta *sta
 		return;
 
 	hal->antenna_tx = candidate;
-	rtw89_fw_h2c_txpath_cmac_tbl(rtwdev, rtwsta);
+	rtw89_fw_h2c_txpath_cmac_tbl(rtwdev, rtwsta_link);
 
 	if (hal->antenna_tx == RF_A) {
 		rtw89_phy_write32_mask(rtwdev, R_P0_RFMODE, B_P0_RFMODE_MUX, 0x12);
diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
index 2058f4bf271d..50b66eaf9bd0 100644
--- a/drivers/net/wireless/realtek/rtw89/ser.c
+++ b/drivers/net/wireless/realtek/rtw89/ser.c
@@ -309,19 +309,19 @@ static void ser_reset_vif(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvi
 static void ser_sta_deinit_cam_iter(void *data, struct ieee80211_sta *sta)
 {
 	struct rtw89_vif_link *target_rtwvif = (struct rtw89_vif_link *)data;
-	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
-	struct rtw89_vif_link *rtwvif_link = rtwsta->rtwvif_link;
+	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = rtwsta_link->rtwvif_link;
 	struct rtw89_dev *rtwdev = rtwvif_link->rtwdev;
 
 	if (rtwvif_link != target_rtwvif)
 		return;
 
 	if (rtwvif_link->net_type == RTW89_NET_TYPE_AP_MODE || sta->tdls)
-		rtw89_cam_deinit_addr_cam(rtwdev, &rtwsta->addr_cam);
+		rtw89_cam_deinit_addr_cam(rtwdev, &rtwsta_link->addr_cam);
 	if (sta->tdls)
-		rtw89_cam_deinit_bssid_cam(rtwdev, &rtwsta->bssid_cam);
+		rtw89_cam_deinit_bssid_cam(rtwdev, &rtwsta_link->bssid_cam);
 
-	INIT_LIST_HEAD(&rtwsta->ba_cam_list);
+	INIT_LIST_HEAD(&rtwsta_link->ba_cam_list);
 }
 
 static void ser_deinit_cam(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link)
diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index 5902eb37d618..5046fef55222 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -1123,12 +1123,12 @@ static int rtw89_wow_cfg_wake(struct rtw89_dev *rtwdev, bool wow)
 	struct ieee80211_vif *wow_vif = rtw_wow->wow_vif;
 	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)wow_vif->drv_priv;
 	struct ieee80211_sta *wow_sta;
-	struct rtw89_sta *rtwsta = NULL;
+	struct rtw89_sta_link *rtwsta_link = NULL;
 	int ret;
 
 	wow_sta = ieee80211_find_sta(wow_vif, rtwvif_link->bssid);
 	if (wow_sta)
-		rtwsta = (struct rtw89_sta *)wow_sta->drv_priv;
+		rtwsta_link = (struct rtw89_sta_link *)wow_sta->drv_priv;
 
 	if (wow) {
 		if (rtw_wow->pattern_cnt)
@@ -1147,7 +1147,7 @@ static int rtw89_wow_cfg_wake(struct rtw89_dev *rtwdev, bool wow)
 	}
 
 	if (wow) {
-		ret = rtw89_chip_h2c_dctl_sec_cam(rtwdev, rtwvif_link, rtwsta);
+		ret = rtw89_chip_h2c_dctl_sec_cam(rtwdev, rtwvif_link, rtwsta_link);
 		if (ret) {
 			rtw89_err(rtwdev, "failed to update dctl cam sec entry: %d\n",
 				  ret);
@@ -1155,7 +1155,7 @@ static int rtw89_wow_cfg_wake(struct rtw89_dev *rtwdev, bool wow)
 		}
 	}
 
-	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif_link, rtwsta, NULL);
+	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif_link, rtwsta_link, NULL);
 	if (ret) {
 		rtw89_warn(rtwdev, "failed to send h2c cam\n");
 		return ret;
@@ -1198,7 +1198,7 @@ static int rtw89_wow_swap_fw(struct rtw89_dev *rtwdev, bool wow)
 	bool include_bb = !!chip->bbmcu_nr;
 	bool disable_intr_for_dlfw = false;
 	struct ieee80211_sta *wow_sta;
-	struct rtw89_sta *rtwsta = NULL;
+	struct rtw89_sta_link *rtwsta_link = NULL;
 	bool is_conn = true;
 	int ret;
 
@@ -1207,7 +1207,7 @@ static int rtw89_wow_swap_fw(struct rtw89_dev *rtwdev, bool wow)
 
 	wow_sta = ieee80211_find_sta(wow_vif, rtwvif_link->bssid);
 	if (wow_sta)
-		rtwsta = (struct rtw89_sta *)wow_sta->drv_priv;
+		rtwsta_link = (struct rtw89_sta_link *)wow_sta->drv_priv;
 	else
 		is_conn = false;
 
@@ -1225,7 +1225,7 @@ static int rtw89_wow_swap_fw(struct rtw89_dev *rtwdev, bool wow)
 
 	rtw89_phy_init_rf_reg(rtwdev, true);
 
-	ret = rtw89_fw_h2c_role_maintain(rtwdev, rtwvif_link, rtwsta,
+	ret = rtw89_fw_h2c_role_maintain(rtwdev, rtwvif_link, rtwsta_link,
 					 RTW89_ROLE_FW_RESTORE);
 	if (ret) {
 		rtw89_warn(rtwdev, "failed to send h2c role maintain\n");
@@ -1241,20 +1241,20 @@ static int rtw89_wow_swap_fw(struct rtw89_dev *rtwdev, bool wow)
 	if (!is_conn)
 		rtw89_cam_reset_keys(rtwdev);
 
-	ret = rtw89_fw_h2c_join_info(rtwdev, rtwvif_link, rtwsta, !is_conn);
+	ret = rtw89_fw_h2c_join_info(rtwdev, rtwvif_link, rtwsta_link, !is_conn);
 	if (ret) {
 		rtw89_warn(rtwdev, "failed to send h2c join info\n");
 		return ret;
 	}
 
-	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif_link, rtwsta, NULL);
+	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif_link, rtwsta_link, NULL);
 	if (ret) {
 		rtw89_warn(rtwdev, "failed to send h2c cam\n");
 		return ret;
 	}
 
 	if (is_conn) {
-		ret = rtw89_fw_h2c_general_pkt(rtwdev, rtwvif_link, rtwsta->mac_id);
+		ret = rtw89_fw_h2c_general_pkt(rtwdev, rtwvif_link, rtwsta_link->mac_id);
 		if (ret) {
 			rtw89_warn(rtwdev, "failed to send h2c general packet\n");
 			return ret;
-- 
2.25.1


