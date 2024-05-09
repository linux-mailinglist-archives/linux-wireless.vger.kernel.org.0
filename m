Return-Path: <linux-wireless+bounces-7380-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C41348C0D22
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 11:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E72F31C20C98
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 09:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB02614883E;
	Thu,  9 May 2024 09:07:20 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBB214A4D0
	for <linux-wireless@vger.kernel.org>; Thu,  9 May 2024 09:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715245640; cv=none; b=Lmk5ylSG+9x2GV/fSSarDHKZzGecUTHWOWjLiI8hSY4LVo/I5llPwxN9r3LQYhQrEVlqkOFKIW1SoiqT7+rR3KP7Vs0fUJXE9qRAvj5a+E0LpBAufvLLUPx+UmWVsAYHUAhjRGxX5qx55kiuJ2SGnMfSrOFV8Of2WClnVdxBDy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715245640; c=relaxed/simple;
	bh=ZuWBmkpni25496rQGmDtv6m/WI0WWEYvOIbWlj+ji0E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RggDlRC3dii9B4cJi5F17PsuWJZc4/993O4ahrxs+gXFogYS/mR04K5Q6KSPrf67YsvH08PWLNZuiC0mVPDc5mb5XjvnoV58TMBt7Re9NnbXRh/TNppn9FERAfCNQcs2US8+jEVlNTOABCzlOwv0xm5Qmyq0fd4HngDKtmBgxG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44997GWG01425652, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44997GWG01425652
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 9 May 2024 17:07:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 May 2024 17:07:16 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 9 May
 2024 17:07:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 2/4] wifi: rtw89: cam: tweak relation between sec CAM and addr CAM
Date: Thu, 9 May 2024 17:06:44 +0800
Message-ID: <20240509090646.35304-3-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

From: Zong-Zhe Yang <kevin_yang@realtek.com>

In original code architecture, sec CAM is a component of addr CAM.
Hence, sec CAM could not be shared. After MLO, each link has its own
addr CAM. However, one MLD PTK takes only one sec CAM but it needs to
work on multiple links' addr CAMs. So, we now manage sec CAMs in global
pool, and each of them is not bound to a single addr CAM now.

before:

+-----------------+         +--------------------+
| rtw89_{vif/sta} |   ...   | ieee80211_key_conf |
+-----------------+         +--------------------+
        ^                              |
        V                              | hw_key_idx
        |                              |
        |                              V
        |                             +--
   +----------+   addr_cam::key_idx   |  \        +---------+
   | addr_cam |<>---------------------|   |-------| sec_cam |
   +----------+                       |  /        +---------+
                                      +--

after:

+----------------------+         +--------------------+
| rtw89_{vif/sta}_link |   ...   | ieee80211_key_conf |
+----------------------+         +--------------------+
        ^                                   |
        V                                   | hw_key_idx
        |                                   |
        |                                   V
        |                                  --+                  +---------+
        |              +---------+        /  |  sec_cam_idx     | global  |
        |              | sec_cam |-------|   |----------------<>| sec_cam |
        |              +---------+        \  |                  | pool    |
        |                   ^              --+                  +---------+
        |                   |
        |               (*) |
   +----------+             |
   | addr_cam |-------------+
   +----------+

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/cam.c   | 79 ++++++++++++++--------
 drivers/net/wireless/realtek/rtw89/core.c  | 20 ++----
 drivers/net/wireless/realtek/rtw89/core.h  |  2 +-
 drivers/net/wireless/realtek/rtw89/debug.c | 16 +++--
 4 files changed, 67 insertions(+), 50 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/cam.c b/drivers/net/wireless/realtek/rtw89/cam.c
index 1864f543a6c6..35291efbbae9 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.c
+++ b/drivers/net/wireless/realtek/rtw89/cam.c
@@ -211,6 +211,46 @@ static int rtw89_cam_get_addr_cam_key_idx(struct rtw89_addr_cam_entry *addr_cam,
 	return 0;
 }
 
+static int rtw89_cam_detach_sec_cam(struct rtw89_dev *rtwdev,
+				    struct ieee80211_vif *vif,
+				    struct ieee80211_sta *sta,
+				    const struct rtw89_sec_cam_entry *sec_cam,
+				    bool inform_fw)
+{
+	struct rtw89_sta *rtwsta = sta_to_rtwsta_safe(sta);
+	struct rtw89_vif *rtwvif;
+	struct rtw89_addr_cam_entry *addr_cam;
+	unsigned int i;
+	int ret = 0;
+
+	if (!vif) {
+		rtw89_err(rtwdev, "No iface for deleting sec cam\n");
+		return -EINVAL;
+	}
+
+	rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	addr_cam = rtw89_get_addr_cam_of(rtwvif, rtwsta);
+
+	for_each_set_bit(i, addr_cam->sec_cam_map, RTW89_SEC_CAM_IN_ADDR_CAM) {
+		if (addr_cam->sec_ent[i] != sec_cam->sec_cam_idx)
+			continue;
+
+		clear_bit(i, addr_cam->sec_cam_map);
+	}
+
+	if (inform_fw) {
+		ret = rtw89_chip_h2c_dctl_sec_cam(rtwdev, rtwvif, rtwsta);
+		if (ret)
+			rtw89_err(rtwdev,
+				  "failed to update dctl cam del key: %d\n", ret);
+		ret = rtw89_fw_h2c_cam(rtwdev, rtwvif, rtwsta, NULL);
+		if (ret)
+			rtw89_err(rtwdev, "failed to update cam del key: %d\n", ret);
+	}
+
+	return ret;
+}
+
 static int rtw89_cam_attach_sec_cam(struct rtw89_dev *rtwdev,
 				    struct ieee80211_vif *vif,
 				    struct ieee80211_sta *sta,
@@ -242,10 +282,8 @@ static int rtw89_cam_attach_sec_cam(struct rtw89_dev *rtwdev,
 		return ret;
 	}
 
-	key->hw_key_idx = key_idx;
 	addr_cam->sec_ent_keyid[key_idx] = key->keyidx;
 	addr_cam->sec_ent[key_idx] = sec_cam->sec_cam_idx;
-	addr_cam->sec_entries[key_idx] = sec_cam;
 	set_bit(key_idx, addr_cam->sec_cam_map);
 	ret = rtw89_chip_h2c_dctl_sec_cam(rtwdev, rtwvif, rtwsta);
 	if (ret) {
@@ -258,7 +296,6 @@ static int rtw89_cam_attach_sec_cam(struct rtw89_dev *rtwdev,
 		rtw89_err(rtwdev, "failed to update addr cam sec entry: %d\n",
 			  ret);
 		clear_bit(key_idx, addr_cam->sec_cam_map);
-		addr_cam->sec_entries[key_idx] = NULL;
 		return ret;
 	}
 
@@ -295,6 +332,9 @@ static int rtw89_cam_sec_key_install(struct rtw89_dev *rtwdev,
 		goto err_release_cam;
 	}
 
+	key->hw_key_idx = sec_cam_idx;
+	cam_info->sec_entries[sec_cam_idx] = sec_cam;
+
 	sec_cam->sec_cam_idx = sec_cam_idx;
 	sec_cam->type = hw_key_type;
 	sec_cam->len = RTW89_SEC_CAM_LEN;
@@ -316,6 +356,7 @@ static int rtw89_cam_sec_key_install(struct rtw89_dev *rtwdev,
 	return 0;
 
 err_release_cam:
+	cam_info->sec_entries[sec_cam_idx] = NULL;
 	kfree(sec_cam);
 	clear_bit(sec_cam_idx, cam_info->sec_cam_map);
 	if (ext_key)
@@ -386,42 +427,22 @@ int rtw89_cam_sec_key_del(struct rtw89_dev *rtwdev,
 			  struct ieee80211_key_conf *key,
 			  bool inform_fw)
 {
-	struct rtw89_sta *rtwsta = sta_to_rtwsta_safe(sta);
 	struct rtw89_cam_info *cam_info = &rtwdev->cam_info;
-	struct rtw89_vif *rtwvif;
-	struct rtw89_addr_cam_entry *addr_cam;
-	struct rtw89_sec_cam_entry *sec_cam;
-	u8 key_idx = key->hw_key_idx;
+	const struct rtw89_sec_cam_entry *sec_cam;
 	u8 sec_cam_idx;
-	int ret = 0;
-
-	if (!vif) {
-		rtw89_err(rtwdev, "No iface for deleting sec cam\n");
-		return -EINVAL;
-	}
+	int ret;
 
-	rtwvif = (struct rtw89_vif *)vif->drv_priv;
-	addr_cam = rtw89_get_addr_cam_of(rtwvif, rtwsta);
-	sec_cam = addr_cam->sec_entries[key_idx];
+	sec_cam_idx = key->hw_key_idx;
+	sec_cam = cam_info->sec_entries[sec_cam_idx];
 	if (!sec_cam)
 		return -EINVAL;
 
-	/* detach sec cam from addr cam */
-	clear_bit(key_idx, addr_cam->sec_cam_map);
-	addr_cam->sec_entries[key_idx] = NULL;
-	if (inform_fw) {
-		ret = rtw89_chip_h2c_dctl_sec_cam(rtwdev, rtwvif, rtwsta);
-		if (ret)
-			rtw89_err(rtwdev, "failed to update dctl cam del key: %d\n", ret);
-		ret = rtw89_fw_h2c_cam(rtwdev, rtwvif, rtwsta, NULL);
-		if (ret)
-			rtw89_err(rtwdev, "failed to update cam del key: %d\n", ret);
-	}
+	ret = rtw89_cam_detach_sec_cam(rtwdev, vif, sta, sec_cam, inform_fw);
 
 	/* clear valid bit in addr cam will disable sec cam,
 	 * so we don't need to send H2C command again
 	 */
-	sec_cam_idx = sec_cam->sec_cam_idx;
+	cam_info->sec_entries[sec_cam_idx] = NULL;
 	clear_bit(sec_cam_idx, cam_info->sec_cam_map);
 	if (sec_cam->ext_key)
 		clear_bit(sec_cam_idx + 1, cam_info->sec_cam_map);
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 53997fa51ba0..1382bd24ba3b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -499,31 +499,21 @@ static void
 rtw89_core_tx_update_sec_key(struct rtw89_dev *rtwdev,
 			     struct rtw89_core_tx_request *tx_req)
 {
+	struct rtw89_cam_info *cam_info = &rtwdev->cam_info;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
-	struct ieee80211_vif *vif = tx_req->vif;
-	struct ieee80211_sta *sta = tx_req->sta;
+	const struct rtw89_sec_cam_entry *sec_cam;
 	struct ieee80211_tx_info *info;
 	struct ieee80211_key_conf *key;
-	struct rtw89_vif *rtwvif;
-	struct rtw89_sta *rtwsta = sta_to_rtwsta_safe(sta);
-	struct rtw89_addr_cam_entry *addr_cam;
-	struct rtw89_sec_cam_entry *sec_cam;
 	struct rtw89_tx_desc_info *desc_info = &tx_req->desc_info;
 	struct sk_buff *skb = tx_req->skb;
 	u8 sec_type = RTW89_SEC_KEY_TYPE_NONE;
+	u8 sec_cam_idx;
 	u64 pn64;
 
-	if (!vif) {
-		rtw89_warn(rtwdev, "cannot set sec key without vif\n");
-		return;
-	}
-
-	rtwvif = (struct rtw89_vif *)vif->drv_priv;
-	addr_cam = rtw89_get_addr_cam_of(rtwvif, rtwsta);
-
 	info = IEEE80211_SKB_CB(skb);
 	key = info->control.hw_key;
-	sec_cam = addr_cam->sec_entries[key->hw_key_idx];
+	sec_cam_idx = key->hw_key_idx;
+	sec_cam = cam_info->sec_entries[sec_cam_idx];
 	if (!sec_cam) {
 		rtw89_warn(rtwdev, "sec cam entry is empty\n");
 		return;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 0648458110ce..32ae500579bb 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3249,7 +3249,6 @@ struct rtw89_addr_cam_entry {
 	DECLARE_BITMAP(sec_cam_map, RTW89_SEC_CAM_IN_ADDR_CAM);
 	u8 sec_ent_keyid[RTW89_SEC_CAM_IN_ADDR_CAM];
 	u8 sec_ent[RTW89_SEC_CAM_IN_ADDR_CAM];
-	struct rtw89_sec_cam_entry *sec_entries[RTW89_SEC_CAM_IN_ADDR_CAM];
 };
 
 struct rtw89_bssid_cam_entry {
@@ -4436,6 +4435,7 @@ struct rtw89_cam_info {
 	DECLARE_BITMAP(sec_cam_map, RTW89_MAX_SEC_CAM_NUM);
 	DECLARE_BITMAP(ba_cam_map, RTW89_MAX_BA_CAM_NUM);
 	struct rtw89_ba_cam_entry ba_cam_entry[RTW89_MAX_BA_CAM_NUM];
+	const struct rtw89_sec_cam_entry *sec_entries[RTW89_MAX_SEC_CAM_NUM];
 };
 
 enum rtw89_sar_sources {
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index affffc4092ba..210f192ac9ec 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -3645,17 +3645,21 @@ static int rtw89_debug_priv_phy_info_get(struct seq_file *m, void *v)
 }
 
 static void rtw89_dump_addr_cam(struct seq_file *m,
+				struct rtw89_dev *rtwdev,
 				struct rtw89_addr_cam_entry *addr_cam)
 {
-	struct rtw89_sec_cam_entry *sec_entry;
+	struct rtw89_cam_info *cam_info = &rtwdev->cam_info;
+	const struct rtw89_sec_cam_entry *sec_entry;
+	u8 sec_cam_idx;
 	int i;
 
 	seq_printf(m, "\taddr_cam_idx=%u\n", addr_cam->addr_cam_idx);
 	seq_printf(m, "\t-> bssid_cam_idx=%u\n", addr_cam->bssid_cam_idx);
 	seq_printf(m, "\tsec_cam_bitmap=%*ph\n", (int)sizeof(addr_cam->sec_cam_map),
 		   addr_cam->sec_cam_map);
-	for (i = 0; i < RTW89_SEC_CAM_IN_ADDR_CAM; i++) {
-		sec_entry = addr_cam->sec_entries[i];
+	for_each_set_bit(i, addr_cam->sec_cam_map, RTW89_SEC_CAM_IN_ADDR_CAM) {
+		sec_cam_idx = addr_cam->sec_ent[i];
+		sec_entry = cam_info->sec_entries[sec_cam_idx];
 		if (!sec_entry)
 			continue;
 		seq_printf(m, "\tsec[%d]: sec_cam_idx %u", i, sec_entry->sec_cam_idx);
@@ -3694,12 +3698,13 @@ static
 void rtw89_vif_ids_get_iter(void *data, u8 *mac, struct ieee80211_vif *vif)
 {
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct rtw89_dev *rtwdev = rtwvif->rtwdev;
 	struct seq_file *m = (struct seq_file *)data;
 	struct rtw89_bssid_cam_entry *bssid_cam = &rtwvif->bssid_cam;
 
 	seq_printf(m, "VIF [%d] %pM\n", rtwvif->mac_id, rtwvif->mac_addr);
 	seq_printf(m, "\tbssid_cam_idx=%u\n", bssid_cam->bssid_cam_idx);
-	rtw89_dump_addr_cam(m, &rtwvif->addr_cam);
+	rtw89_dump_addr_cam(m, rtwdev, &rtwvif->addr_cam);
 	rtw89_dump_pkt_offload(m, &rtwvif->general_pkt_list, "\tpkt_ofld[GENERAL]: ");
 }
 
@@ -3726,11 +3731,12 @@ static void rtw89_dump_ba_cam(struct seq_file *m, struct rtw89_sta *rtwsta)
 static void rtw89_sta_ids_get_iter(void *data, struct ieee80211_sta *sta)
 {
 	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
+	struct rtw89_dev *rtwdev = rtwsta->rtwdev;
 	struct seq_file *m = (struct seq_file *)data;
 
 	seq_printf(m, "STA [%d] %pM %s\n", rtwsta->mac_id, sta->addr,
 		   sta->tdls ? "(TDLS)" : "");
-	rtw89_dump_addr_cam(m, &rtwsta->addr_cam);
+	rtw89_dump_addr_cam(m, rtwdev, &rtwsta->addr_cam);
 	rtw89_dump_ba_cam(m, rtwsta);
 }
 
-- 
2.25.1


