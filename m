Return-Path: <linux-wireless+bounces-12877-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D6B979ACA
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2024 07:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03846282A76
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2024 05:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7762134BD;
	Mon, 16 Sep 2024 05:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Zc3q+wmW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F8938FA3
	for <linux-wireless@vger.kernel.org>; Mon, 16 Sep 2024 05:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726464781; cv=none; b=Siyg54e/rZ602X0otcrHWPVnfAuGrwdxH6FL4hHsJp19cXvosVgPUcCkbsFUf4j030lvxtdT55VGL4AJFL7b2pSYFuG/tjeaAlkYC5P4GavTmhJKeNzIRj6EGVTTz+qnBD27/RMG8Khx+7gHt77R4yqUatI6ZX+FCP1p7IguBik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726464781; c=relaxed/simple;
	bh=6wNzhli9dg4BTSl6pfiCbW5psmiOPLiwrVhQJluhP7U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mTRAfjmDzp4B4WhmgDbIgqDawIavv16uohTmqBKWH/0A5hGlSNCKDgu5ODliig+KWzWdBXgpSwYvr45TS/iS78oHcvKutmgenqBKzU+0Fx8p9PEQL+2UOajFBYQOTjROomppZB6lMO8h1zce81JY6xQUvQcf3I+1j2TfQ9eKdBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Zc3q+wmW; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48G5WmipE2631684, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1726464768; bh=6wNzhli9dg4BTSl6pfiCbW5psmiOPLiwrVhQJluhP7U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Zc3q+wmWzPd5FvWSfI58Ur46aAFHt9x819HPt9kEpYkgOvaax9Pxse1gv7J2Balqy
	 X69VDD2pV7Uogn/8msTvLAWj0UWHhUHrPU/KEJD6BrKs2U62SctxnfHdZUVVHQ1rVi
	 Qy+A5h1ZnDkLfuMJXnOpShajEVymTTxmMDHBFRYpCoyaufjLXJN163a0SgIc6/ZxJN
	 i4eslzfq/WJabw97UX1YbdhrZz/Wr1E1VEdpf302rbhcJgVZbcz6Fhr0Dp/yz71JFT
	 nxigY7WrbIqUFYo49uy5qegXv2Osn0iW2jDYkGQPdCVdBudOGqvGfhP+RnfORcGsyV
	 LxPZEw54HPfIA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48G5WmipE2631684
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 16 Sep 2024 13:32:48 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Sep 2024 13:32:48 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 16 Sep
 2024 13:32:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 1/7] wifi: rtw89: rename rtw89_vif to rtw89_vif_link ahead for MLO
Date: Mon, 16 Sep 2024 13:31:52 +0800
Message-ID: <20240916053158.47350-2-pkshih@realtek.com>
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
e.g. struct rtw89_vif_link *vif_to_rtwvif_safe(struct ieee80211_vif *vif)

No logic is changed.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/cam.c      | 109 +++--
 drivers/net/wireless/realtek/rtw89/cam.h      |  16 +-
 drivers/net/wireless/realtek/rtw89/chan.c     | 162 +++----
 drivers/net/wireless/realtek/rtw89/chan.h     |   4 +-
 drivers/net/wireless/realtek/rtw89/coex.c     |  33 +-
 drivers/net/wireless/realtek/rtw89/coex.h     |   3 +-
 drivers/net/wireless/realtek/rtw89/core.c     | 275 +++++------
 drivers/net/wireless/realtek/rtw89/core.h     |  72 +--
 drivers/net/wireless/realtek/rtw89/debug.c    |  17 +-
 drivers/net/wireless/realtek/rtw89/fw.c       | 356 +++++++-------
 drivers/net/wireless/realtek/rtw89/fw.h       |  78 +--
 drivers/net/wireless/realtek/rtw89/mac.c      | 446 +++++++++---------
 drivers/net/wireless/realtek/rtw89/mac.h      |  70 +--
 drivers/net/wireless/realtek/rtw89/mac80211.c | 207 ++++----
 drivers/net/wireless/realtek/rtw89/mac_be.c   |  14 +-
 drivers/net/wireless/realtek/rtw89/phy.c      |  74 +--
 drivers/net/wireless/realtek/rtw89/phy.h      |   2 +-
 drivers/net/wireless/realtek/rtw89/ps.c       |  92 ++--
 drivers/net/wireless/realtek/rtw89/ps.h       |  10 +-
 drivers/net/wireless/realtek/rtw89/regd.c     |  46 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  13 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  12 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  13 +-
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |  13 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  12 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  10 +-
 drivers/net/wireless/realtek/rtw89/ser.c      |  36 +-
 drivers/net/wireless/realtek/rtw89/util.h     |   8 +-
 drivers/net/wireless/realtek/rtw89/wow.c      | 125 ++---
 drivers/net/wireless/realtek/rtw89/wow.h      |   8 +-
 30 files changed, 1200 insertions(+), 1136 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/cam.c b/drivers/net/wireless/realtek/rtw89/cam.c
index 4476fc7e53db..a3e6d40b3078 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.c
+++ b/drivers/net/wireless/realtek/rtw89/cam.c
@@ -218,7 +218,7 @@ static int rtw89_cam_detach_sec_cam(struct rtw89_dev *rtwdev,
 				    bool inform_fw)
 {
 	struct rtw89_sta *rtwsta = sta_to_rtwsta_safe(sta);
-	struct rtw89_vif *rtwvif;
+	struct rtw89_vif_link *rtwvif_link;
 	struct rtw89_addr_cam_entry *addr_cam;
 	unsigned int i;
 	int ret = 0;
@@ -228,8 +228,8 @@ static int rtw89_cam_detach_sec_cam(struct rtw89_dev *rtwdev,
 		return -EINVAL;
 	}
 
-	rtwvif = (struct rtw89_vif *)vif->drv_priv;
-	addr_cam = rtw89_get_addr_cam_of(rtwvif, rtwsta);
+	rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
+	addr_cam = rtw89_get_addr_cam_of(rtwvif_link, rtwsta);
 
 	for_each_set_bit(i, addr_cam->sec_cam_map, RTW89_SEC_CAM_IN_ADDR_CAM) {
 		if (addr_cam->sec_ent[i] != sec_cam->sec_cam_idx)
@@ -239,11 +239,11 @@ static int rtw89_cam_detach_sec_cam(struct rtw89_dev *rtwdev,
 	}
 
 	if (inform_fw) {
-		ret = rtw89_chip_h2c_dctl_sec_cam(rtwdev, rtwvif, rtwsta);
+		ret = rtw89_chip_h2c_dctl_sec_cam(rtwdev, rtwvif_link, rtwsta);
 		if (ret)
 			rtw89_err(rtwdev,
 				  "failed to update dctl cam del key: %d\n", ret);
-		ret = rtw89_fw_h2c_cam(rtwdev, rtwvif, rtwsta, NULL);
+		ret = rtw89_fw_h2c_cam(rtwdev, rtwvif_link, rtwsta, NULL);
 		if (ret)
 			rtw89_err(rtwdev, "failed to update cam del key: %d\n", ret);
 	}
@@ -258,7 +258,7 @@ static int rtw89_cam_attach_sec_cam(struct rtw89_dev *rtwdev,
 				    struct rtw89_sec_cam_entry *sec_cam)
 {
 	struct rtw89_sta *rtwsta = sta_to_rtwsta_safe(sta);
-	struct rtw89_vif *rtwvif;
+	struct rtw89_vif_link *rtwvif_link;
 	struct rtw89_addr_cam_entry *addr_cam;
 	u8 key_idx = 0;
 	int ret;
@@ -268,8 +268,8 @@ static int rtw89_cam_attach_sec_cam(struct rtw89_dev *rtwdev,
 		return -EINVAL;
 	}
 
-	rtwvif = (struct rtw89_vif *)vif->drv_priv;
-	addr_cam = rtw89_get_addr_cam_of(rtwvif, rtwsta);
+	rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
+	addr_cam = rtw89_get_addr_cam_of(rtwvif_link, rtwsta);
 
 	if (key->cipher == WLAN_CIPHER_SUITE_WEP40 ||
 	    key->cipher == WLAN_CIPHER_SUITE_WEP104)
@@ -285,13 +285,13 @@ static int rtw89_cam_attach_sec_cam(struct rtw89_dev *rtwdev,
 	addr_cam->sec_ent_keyid[key_idx] = key->keyidx;
 	addr_cam->sec_ent[key_idx] = sec_cam->sec_cam_idx;
 	set_bit(key_idx, addr_cam->sec_cam_map);
-	ret = rtw89_chip_h2c_dctl_sec_cam(rtwdev, rtwvif, rtwsta);
+	ret = rtw89_chip_h2c_dctl_sec_cam(rtwdev, rtwvif_link, rtwsta);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to update dctl cam sec entry: %d\n",
 			  ret);
 		return ret;
 	}
-	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif, rtwsta, NULL);
+	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif_link, rtwsta, NULL);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to update addr cam sec entry: %d\n",
 			  ret);
@@ -485,10 +485,10 @@ void rtw89_cam_deinit_bssid_cam(struct rtw89_dev *rtwdev,
 	clear_bit(bssid_cam->bssid_cam_idx, cam_info->bssid_cam_map);
 }
 
-void rtw89_cam_deinit(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+void rtw89_cam_deinit(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link)
 {
-	struct rtw89_addr_cam_entry *addr_cam = &rtwvif->addr_cam;
-	struct rtw89_bssid_cam_entry *bssid_cam = &rtwvif->bssid_cam;
+	struct rtw89_addr_cam_entry *addr_cam = &rtwvif_link->addr_cam;
+	struct rtw89_bssid_cam_entry *bssid_cam = &rtwvif_link->bssid_cam;
 
 	rtw89_cam_deinit_addr_cam(rtwdev, addr_cam);
 	rtw89_cam_deinit_bssid_cam(rtwdev, bssid_cam);
@@ -593,7 +593,7 @@ static int rtw89_cam_get_avail_bssid_cam(struct rtw89_dev *rtwdev,
 }
 
 int rtw89_cam_init_bssid_cam(struct rtw89_dev *rtwdev,
-			     struct rtw89_vif *rtwvif,
+			     struct rtw89_vif_link *rtwvif_link,
 			     struct rtw89_bssid_cam_entry *bssid_cam,
 			     const u8 *bssid)
 {
@@ -613,7 +613,7 @@ int rtw89_cam_init_bssid_cam(struct rtw89_dev *rtwdev,
 	}
 
 	bssid_cam->bssid_cam_idx = bssid_cam_idx;
-	bssid_cam->phy_idx = rtwvif->phy_idx;
+	bssid_cam->phy_idx = rtwvif_link->phy_idx;
 	bssid_cam->len = BSSID_CAM_ENT_SIZE;
 	bssid_cam->offset = 0;
 	bssid_cam->valid = true;
@@ -622,20 +622,21 @@ int rtw89_cam_init_bssid_cam(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
-void rtw89_cam_bssid_changed(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+void rtw89_cam_bssid_changed(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link)
 {
-	struct rtw89_bssid_cam_entry *bssid_cam = &rtwvif->bssid_cam;
+	struct rtw89_bssid_cam_entry *bssid_cam = &rtwvif_link->bssid_cam;
 
-	ether_addr_copy(bssid_cam->bssid, rtwvif->bssid);
+	ether_addr_copy(bssid_cam->bssid, rtwvif_link->bssid);
 }
 
-int rtw89_cam_init(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+int rtw89_cam_init(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link)
 {
-	struct rtw89_addr_cam_entry *addr_cam = &rtwvif->addr_cam;
-	struct rtw89_bssid_cam_entry *bssid_cam = &rtwvif->bssid_cam;
+	struct rtw89_addr_cam_entry *addr_cam = &rtwvif_link->addr_cam;
+	struct rtw89_bssid_cam_entry *bssid_cam = &rtwvif_link->bssid_cam;
 	int ret;
 
-	ret = rtw89_cam_init_bssid_cam(rtwdev, rtwvif, bssid_cam, rtwvif->bssid);
+	ret = rtw89_cam_init_bssid_cam(rtwdev, rtwvif_link, bssid_cam,
+				       rtwvif_link->bssid);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to init bssid cam\n");
 		return ret;
@@ -651,11 +652,12 @@ int rtw89_cam_init(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 }
 
 int rtw89_cam_fill_bssid_cam_info(struct rtw89_dev *rtwdev,
-				  struct rtw89_vif *rtwvif,
+				  struct rtw89_vif_link *rtwvif_link,
 				  struct rtw89_sta *rtwsta, u8 *cmd)
 {
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
-	struct rtw89_bssid_cam_entry *bssid_cam = rtw89_get_bssid_cam_of(rtwvif, rtwsta);
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
+	struct rtw89_bssid_cam_entry *bssid_cam = rtw89_get_bssid_cam_of(rtwvif_link,
+									 rtwsta);
 	u8 bss_color = vif->bss_conf.he_bss_color.color;
 	u8 bss_mask;
 
@@ -694,19 +696,20 @@ static u8 rtw89_cam_addr_hash(u8 start, const u8 *addr)
 }
 
 void rtw89_cam_fill_addr_cam_info(struct rtw89_dev *rtwdev,
-				  struct rtw89_vif *rtwvif,
+				  struct rtw89_vif_link *rtwvif_link,
 				  struct rtw89_sta *rtwsta,
 				  const u8 *scan_mac_addr,
 				  u8 *cmd)
 {
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
-	struct rtw89_addr_cam_entry *addr_cam = rtw89_get_addr_cam_of(rtwvif, rtwsta);
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
+	struct rtw89_addr_cam_entry *addr_cam =
+		rtw89_get_addr_cam_of(rtwvif_link, rtwsta);
 	struct ieee80211_sta *sta = rtwsta_to_sta_safe(rtwsta);
-	const u8 *sma = scan_mac_addr ? scan_mac_addr : rtwvif->mac_addr;
+	const u8 *sma = scan_mac_addr ? scan_mac_addr : rtwvif_link->mac_addr;
 	u8 sma_hash, tma_hash, addr_msk_start;
 	u8 sma_start = 0;
 	u8 tma_start = 0;
-	u8 *tma = sta ? sta->addr : rtwvif->bssid;
+	u8 *tma = sta ? sta->addr : rtwvif_link->bssid;
 
 	if (addr_cam->addr_mask != 0) {
 		addr_msk_start = __ffs(addr_cam->addr_mask);
@@ -723,10 +726,10 @@ void rtw89_cam_fill_addr_cam_info(struct rtw89_dev *rtwdev,
 	FWCMD_SET_ADDR_LEN(cmd, addr_cam->len);
 
 	FWCMD_SET_ADDR_VALID(cmd, addr_cam->valid);
-	FWCMD_SET_ADDR_NET_TYPE(cmd, rtwvif->net_type);
-	FWCMD_SET_ADDR_BCN_HIT_COND(cmd, rtwvif->bcn_hit_cond);
-	FWCMD_SET_ADDR_HIT_RULE(cmd, rtwvif->hit_rule);
-	FWCMD_SET_ADDR_BB_SEL(cmd, rtwvif->phy_idx);
+	FWCMD_SET_ADDR_NET_TYPE(cmd, rtwvif_link->net_type);
+	FWCMD_SET_ADDR_BCN_HIT_COND(cmd, rtwvif_link->bcn_hit_cond);
+	FWCMD_SET_ADDR_HIT_RULE(cmd, rtwvif_link->hit_rule);
+	FWCMD_SET_ADDR_BB_SEL(cmd, rtwvif_link->phy_idx);
 	FWCMD_SET_ADDR_ADDR_MASK(cmd, addr_cam->addr_mask);
 	FWCMD_SET_ADDR_MASK_SEL(cmd, addr_cam->mask_sel);
 	FWCMD_SET_ADDR_SMA_HASH(cmd, sma_hash);
@@ -748,20 +751,20 @@ void rtw89_cam_fill_addr_cam_info(struct rtw89_dev *rtwdev,
 	FWCMD_SET_ADDR_TMA4(cmd, tma[4]);
 	FWCMD_SET_ADDR_TMA5(cmd, tma[5]);
 
-	FWCMD_SET_ADDR_PORT_INT(cmd, rtwvif->port);
-	FWCMD_SET_ADDR_TSF_SYNC(cmd, rtwvif->port);
-	FWCMD_SET_ADDR_TF_TRS(cmd, rtwvif->trigger);
-	FWCMD_SET_ADDR_LSIG_TXOP(cmd, rtwvif->lsig_txop);
-	FWCMD_SET_ADDR_TGT_IND(cmd, rtwvif->tgt_ind);
-	FWCMD_SET_ADDR_FRM_TGT_IND(cmd, rtwvif->frm_tgt_ind);
-	FWCMD_SET_ADDR_MACID(cmd, rtwsta ? rtwsta->mac_id : rtwvif->mac_id);
-	if (rtwvif->net_type == RTW89_NET_TYPE_INFRA)
+	FWCMD_SET_ADDR_PORT_INT(cmd, rtwvif_link->port);
+	FWCMD_SET_ADDR_TSF_SYNC(cmd, rtwvif_link->port);
+	FWCMD_SET_ADDR_TF_TRS(cmd, rtwvif_link->trigger);
+	FWCMD_SET_ADDR_LSIG_TXOP(cmd, rtwvif_link->lsig_txop);
+	FWCMD_SET_ADDR_TGT_IND(cmd, rtwvif_link->tgt_ind);
+	FWCMD_SET_ADDR_FRM_TGT_IND(cmd, rtwvif_link->frm_tgt_ind);
+	FWCMD_SET_ADDR_MACID(cmd, rtwsta ? rtwsta->mac_id : rtwvif_link->mac_id);
+	if (rtwvif_link->net_type == RTW89_NET_TYPE_INFRA)
 		FWCMD_SET_ADDR_AID12(cmd, vif->cfg.aid & 0xfff);
-	else if (rtwvif->net_type == RTW89_NET_TYPE_AP_MODE)
+	else if (rtwvif_link->net_type == RTW89_NET_TYPE_AP_MODE)
 		FWCMD_SET_ADDR_AID12(cmd, sta ? sta->aid & 0xfff : 0);
-	FWCMD_SET_ADDR_WOL_PATTERN(cmd, rtwvif->wowlan_pattern);
-	FWCMD_SET_ADDR_WOL_UC(cmd, rtwvif->wowlan_uc);
-	FWCMD_SET_ADDR_WOL_MAGIC(cmd, rtwvif->wowlan_magic);
+	FWCMD_SET_ADDR_WOL_PATTERN(cmd, rtwvif_link->wowlan_pattern);
+	FWCMD_SET_ADDR_WOL_UC(cmd, rtwvif_link->wowlan_uc);
+	FWCMD_SET_ADDR_WOL_MAGIC(cmd, rtwvif_link->wowlan_magic);
 	FWCMD_SET_ADDR_WAPI(cmd, addr_cam->wapi);
 	FWCMD_SET_ADDR_SEC_ENT_MODE(cmd, addr_cam->sec_ent_mode);
 	FWCMD_SET_ADDR_SEC_ENT0_KEYID(cmd, addr_cam->sec_ent_keyid[0]);
@@ -783,15 +786,16 @@ void rtw89_cam_fill_addr_cam_info(struct rtw89_dev *rtwdev,
 }
 
 void rtw89_cam_fill_dctl_sec_cam_info_v1(struct rtw89_dev *rtwdev,
-					 struct rtw89_vif *rtwvif,
+					 struct rtw89_vif_link *rtwvif_link,
 					 struct rtw89_sta *rtwsta,
 					 struct rtw89_h2c_dctlinfo_ud_v1 *h2c)
 {
-	struct rtw89_addr_cam_entry *addr_cam = rtw89_get_addr_cam_of(rtwvif, rtwsta);
+	struct rtw89_addr_cam_entry *addr_cam =
+		rtw89_get_addr_cam_of(rtwvif_link, rtwsta);
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
 	u8 *ptk_tx_iv = rtw_wow->key_info.ptk_tx_iv;
 
-	h2c->c0 = le32_encode_bits(rtwsta ? rtwsta->mac_id : rtwvif->mac_id,
+	h2c->c0 = le32_encode_bits(rtwsta ? rtwsta->mac_id : rtwvif_link->mac_id,
 				   DCTLINFO_V1_C0_MACID) |
 		  le32_encode_bits(1, DCTLINFO_V1_C0_OP);
 
@@ -862,15 +866,16 @@ void rtw89_cam_fill_dctl_sec_cam_info_v1(struct rtw89_dev *rtwdev,
 }
 
 void rtw89_cam_fill_dctl_sec_cam_info_v2(struct rtw89_dev *rtwdev,
-					 struct rtw89_vif *rtwvif,
+					 struct rtw89_vif_link *rtwvif_link,
 					 struct rtw89_sta *rtwsta,
 					 struct rtw89_h2c_dctlinfo_ud_v2 *h2c)
 {
-	struct rtw89_addr_cam_entry *addr_cam = rtw89_get_addr_cam_of(rtwvif, rtwsta);
+	struct rtw89_addr_cam_entry *addr_cam =
+		rtw89_get_addr_cam_of(rtwvif_link, rtwsta);
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
 	u8 *ptk_tx_iv = rtw_wow->key_info.ptk_tx_iv;
 
-	h2c->c0 = le32_encode_bits(rtwsta ? rtwsta->mac_id : rtwvif->mac_id,
+	h2c->c0 = le32_encode_bits(rtwsta ? rtwsta->mac_id : rtwvif_link->mac_id,
 				   DCTLINFO_V2_C0_MACID) |
 		  le32_encode_bits(1, DCTLINFO_V2_C0_OP);
 
diff --git a/drivers/net/wireless/realtek/rtw89/cam.h b/drivers/net/wireless/realtek/rtw89/cam.h
index 5d7b624c2dd4..18ede69144b6 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.h
+++ b/drivers/net/wireless/realtek/rtw89/cam.h
@@ -526,33 +526,33 @@ struct rtw89_h2c_dctlinfo_ud_v2 {
 #define DCTLINFO_V2_W12_MLD_TA_BSSID_H_V1 GENMASK(15, 0)
 #define DCTLINFO_V2_W12_ALL GENMASK(15, 0)
 
-int rtw89_cam_init(struct rtw89_dev *rtwdev, struct rtw89_vif *vif);
-void rtw89_cam_deinit(struct rtw89_dev *rtwdev, struct rtw89_vif *vif);
+int rtw89_cam_init(struct rtw89_dev *rtwdev, struct rtw89_vif_link *vif);
+void rtw89_cam_deinit(struct rtw89_dev *rtwdev, struct rtw89_vif_link *vif);
 int rtw89_cam_init_addr_cam(struct rtw89_dev *rtwdev,
 			    struct rtw89_addr_cam_entry *addr_cam,
 			    const struct rtw89_bssid_cam_entry *bssid_cam);
 void rtw89_cam_deinit_addr_cam(struct rtw89_dev *rtwdev,
 			       struct rtw89_addr_cam_entry *addr_cam);
 int rtw89_cam_init_bssid_cam(struct rtw89_dev *rtwdev,
-			     struct rtw89_vif *rtwvif,
+			     struct rtw89_vif_link *rtwvif_link,
 			     struct rtw89_bssid_cam_entry *bssid_cam,
 			     const u8 *bssid);
 void rtw89_cam_deinit_bssid_cam(struct rtw89_dev *rtwdev,
 				struct rtw89_bssid_cam_entry *bssid_cam);
 void rtw89_cam_fill_addr_cam_info(struct rtw89_dev *rtwdev,
-				  struct rtw89_vif *vif,
+				  struct rtw89_vif_link *vif,
 				  struct rtw89_sta *rtwsta,
 				  const u8 *scan_mac_addr, u8 *cmd);
 void rtw89_cam_fill_dctl_sec_cam_info_v1(struct rtw89_dev *rtwdev,
-					 struct rtw89_vif *rtwvif,
+					 struct rtw89_vif_link *rtwvif_link,
 					 struct rtw89_sta *rtwsta,
 					 struct rtw89_h2c_dctlinfo_ud_v1 *h2c);
 void rtw89_cam_fill_dctl_sec_cam_info_v2(struct rtw89_dev *rtwdev,
-					 struct rtw89_vif *rtwvif,
+					 struct rtw89_vif_link *rtwvif_link,
 					 struct rtw89_sta *rtwsta,
 					 struct rtw89_h2c_dctlinfo_ud_v2 *h2c);
 int rtw89_cam_fill_bssid_cam_info(struct rtw89_dev *rtwdev,
-				  struct rtw89_vif *rtwvif,
+				  struct rtw89_vif_link *rtwvif_link,
 				  struct rtw89_sta *rtwsta, u8 *cmd);
 int rtw89_cam_sec_key_add(struct rtw89_dev *rtwdev,
 			  struct ieee80211_vif *vif,
@@ -564,6 +564,6 @@ int rtw89_cam_sec_key_del(struct rtw89_dev *rtwdev,
 			  struct ieee80211_key_conf *key,
 			  bool inform_fw);
 void rtw89_cam_bssid_changed(struct rtw89_dev *rtwdev,
-			     struct rtw89_vif *rtwvif);
+			     struct rtw89_vif_link *rtwvif_link);
 void rtw89_cam_reset_keys(struct rtw89_dev *rtwdev);
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 7070c85e2c28..f20431c3e201 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -239,7 +239,7 @@ static void rtw89_entity_calculate_weight(struct rtw89_dev *rtwdev,
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
 	const struct rtw89_chanctx_cfg *cfg;
-	struct rtw89_vif *rtwvif;
+	struct rtw89_vif_link *rtwvif_link;
 	int idx;
 
 	for_each_set_bit(idx, hal->entity_map, NUM_OF_RTW89_CHANCTX) {
@@ -254,8 +254,8 @@ static void rtw89_entity_calculate_weight(struct rtw89_dev *rtwdev,
 			w->active_chanctxs++;
 	}
 
-	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
-		if (rtwvif->chanctx_assigned)
+	rtw89_for_each_rtwvif(rtwdev, rtwvif_link) {
+		if (rtwvif_link->chanctx_assigned)
 			w->active_roles++;
 	}
 }
@@ -387,9 +387,9 @@ int rtw89_iterate_mcc_roles(struct rtw89_dev *rtwdev,
 static u32 rtw89_mcc_get_tbtt_ofst(struct rtw89_dev *rtwdev,
 				   struct rtw89_mcc_role *role, u64 tsf)
 {
-	struct rtw89_vif *rtwvif = role->rtwvif;
+	struct rtw89_vif_link *rtwvif_link = role->rtwvif_link;
 	u32 bcn_intvl_us = ieee80211_tu_to_usec(role->beacon_interval);
-	u64 sync_tsf = READ_ONCE(rtwvif->sync_bcn_tsf);
+	u64 sync_tsf = READ_ONCE(rtwvif_link->sync_bcn_tsf);
 	u32 remainder;
 
 	if (tsf < sync_tsf) {
@@ -413,8 +413,8 @@ static int __mcc_fw_req_tsf(struct rtw89_dev *rtwdev, u64 *tsf_ref, u64 *tsf_aux
 	int ret;
 
 	req.group = mcc->group;
-	req.macid_x = ref->rtwvif->mac_id;
-	req.macid_y = aux->rtwvif->mac_id;
+	req.macid_x = ref->rtwvif_link->mac_id;
+	req.macid_y = aux->rtwvif_link->mac_id;
 	ret = rtw89_fw_h2c_mcc_req_tsf(rtwdev, &req, &rpt);
 	if (ret) {
 		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
@@ -440,10 +440,10 @@ static int __mrc_fw_req_tsf(struct rtw89_dev *rtwdev, u64 *tsf_ref, u64 *tsf_aux
 	BUILD_BUG_ON(RTW89_MAC_MRC_MAX_REQ_TSF_NUM < NUM_OF_RTW89_MCC_ROLES);
 
 	arg.num = 2;
-	arg.infos[0].band = ref->rtwvif->mac_idx;
-	arg.infos[0].port = ref->rtwvif->port;
-	arg.infos[1].band = aux->rtwvif->mac_idx;
-	arg.infos[1].port = aux->rtwvif->port;
+	arg.infos[0].band = ref->rtwvif_link->mac_idx;
+	arg.infos[0].port = ref->rtwvif_link->port;
+	arg.infos[1].band = aux->rtwvif_link->mac_idx;
+	arg.infos[1].port = aux->rtwvif_link->port;
 
 	ret = rtw89_fw_h2c_mrc_req_tsf(rtwdev, &arg, &rpt);
 	if (ret) {
@@ -523,11 +523,11 @@ u32 rtw89_mcc_role_fw_macid_bitmap_to_u32(struct rtw89_mcc_role *mcc_role)
 static void rtw89_mcc_role_macid_sta_iter(void *data, struct ieee80211_sta *sta)
 {
 	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
-	struct rtw89_vif *rtwvif = rtwsta->rtwvif;
+	struct rtw89_vif_link *rtwvif_link = rtwsta->rtwvif_link;
 	struct rtw89_mcc_role *mcc_role = data;
-	struct rtw89_vif *target = mcc_role->rtwvif;
+	struct rtw89_vif_link *target = mcc_role->rtwvif_link;
 
-	if (rtwvif != target)
+	if (rtwvif_link != target)
 		return;
 
 	rtw89_mcc_role_fw_macid_bitmap_set_bit(mcc_role, rtwsta->mac_id);
@@ -536,9 +536,9 @@ static void rtw89_mcc_role_macid_sta_iter(void *data, struct ieee80211_sta *sta)
 static void rtw89_mcc_fill_role_macid_bitmap(struct rtw89_dev *rtwdev,
 					     struct rtw89_mcc_role *mcc_role)
 {
-	struct rtw89_vif *rtwvif = mcc_role->rtwvif;
+	struct rtw89_vif_link *rtwvif_link = mcc_role->rtwvif_link;
 
-	rtw89_mcc_role_fw_macid_bitmap_set_bit(mcc_role, rtwvif->mac_id);
+	rtw89_mcc_role_fw_macid_bitmap_set_bit(mcc_role, rtwvif_link->mac_id);
 	ieee80211_iterate_stations_atomic(rtwdev->hw,
 					  rtw89_mcc_role_macid_sta_iter,
 					  mcc_role);
@@ -564,7 +564,7 @@ static void rtw89_mcc_fill_role_policy(struct rtw89_dev *rtwdev,
 static void rtw89_mcc_fill_role_limit(struct rtw89_dev *rtwdev,
 				      struct rtw89_mcc_role *mcc_role)
 {
-	struct ieee80211_vif *vif = rtwvif_to_vif(mcc_role->rtwvif);
+	struct ieee80211_vif *vif = rtwvif_to_vif(mcc_role->rtwvif_link);
 	struct ieee80211_p2p_noa_desc *noa_desc;
 	u32 bcn_intvl_us = ieee80211_tu_to_usec(mcc_role->beacon_interval);
 	u32 max_toa_us, max_tob_us, max_dur_us;
@@ -597,7 +597,7 @@ static void rtw89_mcc_fill_role_limit(struct rtw89_dev *rtwdev,
 		return;
 	}
 
-	ret = rtw89_mac_port_get_tsf(rtwdev, mcc_role->rtwvif, &tsf);
+	ret = rtw89_mac_port_get_tsf(rtwdev, mcc_role->rtwvif_link, &tsf);
 	if (ret) {
 		rtw89_warn(rtwdev, "MCC failed to get port tsf: %d\n", ret);
 		return;
@@ -632,14 +632,14 @@ static void rtw89_mcc_fill_role_limit(struct rtw89_dev *rtwdev,
 }
 
 static int rtw89_mcc_fill_role(struct rtw89_dev *rtwdev,
-			       struct rtw89_vif *rtwvif,
+			       struct rtw89_vif_link *rtwvif_link,
 			       struct rtw89_mcc_role *role)
 {
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
 	const struct rtw89_chan *chan;
 
 	memset(role, 0, sizeof(*role));
-	role->rtwvif = rtwvif;
+	role->rtwvif_link = rtwvif_link;
 	role->beacon_interval = vif->bss_conf.beacon_int;
 
 	if (!role->beacon_interval) {
@@ -650,10 +650,10 @@ static int rtw89_mcc_fill_role(struct rtw89_dev *rtwdev,
 
 	role->duration = role->beacon_interval / 2;
 
-	chan = rtw89_chan_get(rtwdev, rtwvif->chanctx_idx);
+	chan = rtw89_chan_get(rtwdev, rtwvif_link->chanctx_idx);
 	role->is_2ghz = chan->band_type == RTW89_BAND_2G;
-	role->is_go = rtwvif->wifi_role == RTW89_WIFI_ROLE_P2P_GO;
-	role->is_gc = rtwvif->wifi_role == RTW89_WIFI_ROLE_P2P_CLIENT;
+	role->is_go = rtwvif_link->wifi_role == RTW89_WIFI_ROLE_P2P_GO;
+	role->is_gc = rtwvif_link->wifi_role == RTW89_WIFI_ROLE_P2P_CLIENT;
 
 	rtw89_mcc_fill_role_macid_bitmap(rtwdev, role);
 	rtw89_mcc_fill_role_policy(rtwdev, role);
@@ -678,7 +678,7 @@ static void rtw89_mcc_fill_bt_role(struct rtw89_dev *rtwdev)
 }
 
 struct rtw89_mcc_fill_role_selector {
-	struct rtw89_vif *bind_vif[NUM_OF_RTW89_CHANCTX];
+	struct rtw89_vif_link *bind_vif[NUM_OF_RTW89_CHANCTX];
 };
 
 static_assert((u8)NUM_OF_RTW89_CHANCTX >= NUM_OF_RTW89_MCC_ROLES);
@@ -689,7 +689,7 @@ static int rtw89_mcc_fill_role_iterator(struct rtw89_dev *rtwdev,
 					void *data)
 {
 	struct rtw89_mcc_fill_role_selector *sel = data;
-	struct rtw89_vif *role_vif = sel->bind_vif[ordered_idx];
+	struct rtw89_vif_link *role_vif = sel->bind_vif[ordered_idx];
 	int ret;
 
 	if (!role_vif) {
@@ -712,21 +712,21 @@ static int rtw89_mcc_fill_role_iterator(struct rtw89_dev *rtwdev,
 static int rtw89_mcc_fill_all_roles(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_mcc_fill_role_selector sel = {};
-	struct rtw89_vif *rtwvif;
+	struct rtw89_vif_link *rtwvif_link;
 	int ret;
 
-	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
-		if (!rtwvif->chanctx_assigned)
+	rtw89_for_each_rtwvif(rtwdev, rtwvif_link) {
+		if (!rtwvif_link->chanctx_assigned)
 			continue;
 
-		if (sel.bind_vif[rtwvif->chanctx_idx]) {
+		if (sel.bind_vif[rtwvif_link->chanctx_idx]) {
 			rtw89_warn(rtwdev,
 				   "MCC skip extra vif <macid %d> on chanctx[%d]\n",
-				   rtwvif->mac_id, rtwvif->chanctx_idx);
+				   rtwvif_link->mac_id, rtwvif_link->chanctx_idx);
 			continue;
 		}
 
-		sel.bind_vif[rtwvif->chanctx_idx] = rtwvif;
+		sel.bind_vif[rtwvif_link->chanctx_idx] = rtwvif_link;
 	}
 
 	ret = rtw89_iterate_mcc_roles(rtwdev, rtw89_mcc_fill_role_iterator, &sel);
@@ -754,13 +754,13 @@ static void rtw89_mcc_assign_pattern(struct rtw89_dev *rtwdev,
 	memset(&pattern->courtesy, 0, sizeof(pattern->courtesy));
 
 	if (pattern->tob_aux <= 0 || pattern->toa_aux <= 0) {
-		pattern->courtesy.macid_tgt = aux->rtwvif->mac_id;
-		pattern->courtesy.macid_src = ref->rtwvif->mac_id;
+		pattern->courtesy.macid_tgt = aux->rtwvif_link->mac_id;
+		pattern->courtesy.macid_src = ref->rtwvif_link->mac_id;
 		pattern->courtesy.slot_num = RTW89_MCC_DFLT_COURTESY_SLOT;
 		pattern->courtesy.enable = true;
 	} else if (pattern->tob_ref <= 0 || pattern->toa_ref <= 0) {
-		pattern->courtesy.macid_tgt = ref->rtwvif->mac_id;
-		pattern->courtesy.macid_src = aux->rtwvif->mac_id;
+		pattern->courtesy.macid_tgt = ref->rtwvif_link->mac_id;
+		pattern->courtesy.macid_src = aux->rtwvif_link->mac_id;
 		pattern->courtesy.slot_num = RTW89_MCC_DFLT_COURTESY_SLOT;
 		pattern->courtesy.enable = true;
 	}
@@ -1263,7 +1263,7 @@ static void rtw89_mcc_sync_tbtt(struct rtw89_dev *rtwdev,
 	u64 tsf_src;
 	int ret;
 
-	ret = rtw89_mac_port_get_tsf(rtwdev, src->rtwvif, &tsf_src);
+	ret = rtw89_mac_port_get_tsf(rtwdev, src->rtwvif_link, &tsf_src);
 	if (ret) {
 		rtw89_warn(rtwdev, "MCC failed to get port tsf: %d\n", ret);
 		return;
@@ -1280,12 +1280,12 @@ static void rtw89_mcc_sync_tbtt(struct rtw89_dev *rtwdev,
 	div_u64_rem(tbtt_tgt, bcn_intvl_src_us, &remainder);
 	tsf_ofst_tgt = bcn_intvl_src_us - remainder;
 
-	config->sync.macid_tgt = tgt->rtwvif->mac_id;
-	config->sync.band_tgt = tgt->rtwvif->mac_idx;
-	config->sync.port_tgt = tgt->rtwvif->port;
-	config->sync.macid_src = src->rtwvif->mac_id;
-	config->sync.band_src = src->rtwvif->mac_idx;
-	config->sync.port_src = src->rtwvif->port;
+	config->sync.macid_tgt = tgt->rtwvif_link->mac_id;
+	config->sync.band_tgt = tgt->rtwvif_link->mac_idx;
+	config->sync.port_tgt = tgt->rtwvif_link->port;
+	config->sync.macid_src = src->rtwvif_link->mac_id;
+	config->sync.band_src = src->rtwvif_link->mac_idx;
+	config->sync.port_src = src->rtwvif_link->port;
 	config->sync.offset = tsf_ofst_tgt / 1024;
 	config->sync.enable = true;
 
@@ -1294,7 +1294,7 @@ static void rtw89_mcc_sync_tbtt(struct rtw89_dev *rtwdev,
 		    config->sync.macid_tgt, config->sync.macid_src,
 		    config->sync.offset);
 
-	rtw89_mac_port_tsf_sync(rtwdev, tgt->rtwvif, src->rtwvif,
+	rtw89_mac_port_tsf_sync(rtwdev, tgt->rtwvif_link, src->rtwvif_link,
 				config->sync.offset);
 }
 
@@ -1305,13 +1305,13 @@ static int rtw89_mcc_fill_start_tsf(struct rtw89_dev *rtwdev)
 	struct rtw89_mcc_config *config = &mcc->config;
 	u32 bcn_intvl_ref_us = ieee80211_tu_to_usec(ref->beacon_interval);
 	u32 tob_ref_us = ieee80211_tu_to_usec(config->pattern.tob_ref);
-	struct rtw89_vif *rtwvif = ref->rtwvif;
+	struct rtw89_vif_link *rtwvif_link = ref->rtwvif_link;
 	u64 tsf, start_tsf;
 	u32 cur_tbtt_ofst;
 	u64 min_time;
 	int ret;
 
-	ret = rtw89_mac_port_get_tsf(rtwdev, rtwvif, &tsf);
+	ret = rtw89_mac_port_get_tsf(rtwdev, rtwvif_link, &tsf);
 	if (ret) {
 		rtw89_warn(rtwdev, "MCC failed to get port tsf: %d\n", ret);
 		return ret;
@@ -1390,13 +1390,13 @@ static int __mcc_fw_add_role(struct rtw89_dev *rtwdev, struct rtw89_mcc_role *ro
 	const struct rtw89_chan *chan;
 	int ret;
 
-	chan = rtw89_chan_get(rtwdev, role->rtwvif->chanctx_idx);
+	chan = rtw89_chan_get(rtwdev, role->rtwvif_link->chanctx_idx);
 	req.central_ch_seg0 = chan->channel;
 	req.primary_ch = chan->primary_channel;
 	req.bandwidth = chan->band_width;
 	req.ch_band_type = chan->band_type;
 
-	req.macid = role->rtwvif->mac_id;
+	req.macid = role->rtwvif_link->mac_id;
 	req.group = mcc->group;
 	req.c2h_rpt = policy->c2h_rpt;
 	req.tx_null_early = policy->tx_null_early;
@@ -1421,7 +1421,7 @@ static int __mcc_fw_add_role(struct rtw89_dev *rtwdev, struct rtw89_mcc_role *ro
 	}
 
 	ret = rtw89_fw_h2c_mcc_macid_bitmap(rtwdev, mcc->group,
-					    role->rtwvif->mac_id,
+					    role->rtwvif_link->mac_id,
 					    role->macid_bitmap);
 	if (ret) {
 		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
@@ -1448,7 +1448,7 @@ void __mrc_fw_add_role(struct rtw89_dev *rtwdev, struct rtw89_mcc_role *role,
 	slot_arg->duration = role->duration;
 	slot_arg->role_num = 1;
 
-	chan = rtw89_chan_get(rtwdev, role->rtwvif->chanctx_idx);
+	chan = rtw89_chan_get(rtwdev, role->rtwvif_link->chanctx_idx);
 
 	slot_arg->roles[0].role_type = RTW89_H2C_MRC_ROLE_WIFI;
 	slot_arg->roles[0].is_master = role == ref;
@@ -1458,7 +1458,7 @@ void __mrc_fw_add_role(struct rtw89_dev *rtwdev, struct rtw89_mcc_role *role,
 	slot_arg->roles[0].primary_ch = chan->primary_channel;
 	slot_arg->roles[0].en_tx_null = !policy->dis_tx_null;
 	slot_arg->roles[0].null_early = policy->tx_null_early;
-	slot_arg->roles[0].macid = role->rtwvif->mac_id;
+	slot_arg->roles[0].macid = role->rtwvif_link->mac_id;
 	slot_arg->roles[0].macid_main_bitmap =
 		rtw89_mcc_role_fw_macid_bitmap_to_u32(role);
 }
@@ -1569,7 +1569,7 @@ static int __mcc_fw_start(struct rtw89_dev *rtwdev, bool replace)
 		}
 	}
 
-	req.macid = ref->rtwvif->mac_id;
+	req.macid = ref->rtwvif_link->mac_id;
 	req.tsf_high = config->start_tsf >> 32;
 	req.tsf_low = config->start_tsf;
 
@@ -1598,7 +1598,7 @@ static void __mrc_fw_add_courtesy(struct rtw89_dev *rtwdev,
 	if (!courtesy->enable)
 		return;
 
-	if (courtesy->macid_src == ref->rtwvif->mac_id) {
+	if (courtesy->macid_src == ref->rtwvif_link->mac_id) {
 		slot_arg_src = &arg->slots[ref->slot_idx];
 		slot_idx_tgt = aux->slot_idx;
 	} else {
@@ -1717,9 +1717,9 @@ static int __mcc_fw_set_duration_no_bt(struct rtw89_dev *rtwdev, bool sync_chang
 	struct rtw89_fw_mcc_duration req = {
 		.group = mcc->group,
 		.btc_in_group = false,
-		.start_macid = ref->rtwvif->mac_id,
-		.macid_x = ref->rtwvif->mac_id,
-		.macid_y = aux->rtwvif->mac_id,
+		.start_macid = ref->rtwvif_link->mac_id,
+		.macid_x = ref->rtwvif_link->mac_id,
+		.macid_y = aux->rtwvif_link->mac_id,
 		.duration_x = ref->duration,
 		.duration_y = aux->duration,
 		.start_tsf_high = config->start_tsf >> 32,
@@ -1813,18 +1813,18 @@ static void rtw89_mcc_handle_beacon_noa(struct rtw89_dev *rtwdev, bool enable)
 	struct ieee80211_p2p_noa_desc noa_desc = {};
 	u64 start_time = config->start_tsf;
 	u32 interval = config->mcc_interval;
-	struct rtw89_vif *rtwvif_go;
+	struct rtw89_vif_link *rtwvif_go;
 	u32 duration;
 
 	if (mcc->mode != RTW89_MCC_MODE_GO_STA)
 		return;
 
 	if (ref->is_go) {
-		rtwvif_go = ref->rtwvif;
+		rtwvif_go = ref->rtwvif_link;
 		start_time += ieee80211_tu_to_usec(ref->duration);
 		duration = config->mcc_interval - ref->duration;
 	} else if (aux->is_go) {
-		rtwvif_go = aux->rtwvif;
+		rtwvif_go = aux->rtwvif_link;
 		start_time += ieee80211_tu_to_usec(pattern->tob_ref) +
 			      ieee80211_tu_to_usec(config->beacon_offset) +
 			      ieee80211_tu_to_usec(pattern->toa_aux);
@@ -1865,9 +1865,9 @@ static void rtw89_mcc_start_beacon_noa(struct rtw89_dev *rtwdev)
 		return;
 
 	if (ref->is_go)
-		rtw89_fw_h2c_tsf32_toggle(rtwdev, ref->rtwvif, true);
+		rtw89_fw_h2c_tsf32_toggle(rtwdev, ref->rtwvif_link, true);
 	else if (aux->is_go)
-		rtw89_fw_h2c_tsf32_toggle(rtwdev, aux->rtwvif, true);
+		rtw89_fw_h2c_tsf32_toggle(rtwdev, aux->rtwvif_link, true);
 
 	rtw89_mcc_handle_beacon_noa(rtwdev, true);
 }
@@ -1882,9 +1882,9 @@ static void rtw89_mcc_stop_beacon_noa(struct rtw89_dev *rtwdev)
 		return;
 
 	if (ref->is_go)
-		rtw89_fw_h2c_tsf32_toggle(rtwdev, ref->rtwvif, false);
+		rtw89_fw_h2c_tsf32_toggle(rtwdev, ref->rtwvif_link, false);
 	else if (aux->is_go)
-		rtw89_fw_h2c_tsf32_toggle(rtwdev, aux->rtwvif, false);
+		rtw89_fw_h2c_tsf32_toggle(rtwdev, aux->rtwvif_link, false);
 
 	rtw89_mcc_handle_beacon_noa(rtwdev, false);
 }
@@ -1942,7 +1942,7 @@ struct rtw89_mcc_stop_sel {
 static void rtw89_mcc_stop_sel_fill(struct rtw89_mcc_stop_sel *sel,
 				    const struct rtw89_mcc_role *mcc_role)
 {
-	sel->mac_id = mcc_role->rtwvif->mac_id;
+	sel->mac_id = mcc_role->rtwvif_link->mac_id;
 	sel->slot_idx = mcc_role->slot_idx;
 }
 
@@ -1953,7 +1953,7 @@ static int rtw89_mcc_stop_sel_iterator(struct rtw89_dev *rtwdev,
 {
 	struct rtw89_mcc_stop_sel *sel = data;
 
-	if (!mcc_role->rtwvif->chanctx_assigned)
+	if (!mcc_role->rtwvif_link->chanctx_assigned)
 		return 0;
 
 	rtw89_mcc_stop_sel_fill(sel, mcc_role);
@@ -2081,7 +2081,7 @@ static int __mcc_fw_upd_macid_bitmap(struct rtw89_dev *rtwdev,
 	int ret;
 
 	ret = rtw89_fw_h2c_mcc_macid_bitmap(rtwdev, mcc->group,
-					    upd->rtwvif->mac_id,
+					    upd->rtwvif_link->mac_id,
 					    upd->macid_bitmap);
 	if (ret) {
 		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
@@ -2106,7 +2106,7 @@ static int __mrc_fw_upd_macid_bitmap(struct rtw89_dev *rtwdev,
 	int i;
 
 	arg.sch_idx = mcc->group;
-	arg.macid = upd->rtwvif->mac_id;
+	arg.macid = upd->rtwvif_link->mac_id;
 
 	for (i = 0; i < 32; i++) {
 		if (add & BIT(i)) {
@@ -2144,7 +2144,7 @@ static int rtw89_mcc_upd_map_iterator(struct rtw89_dev *rtwdev,
 				      void *data)
 {
 	struct rtw89_mcc_role upd = {
-		.rtwvif = mcc_role->rtwvif,
+		.rtwvif_link = mcc_role->rtwvif_link,
 	};
 	int ret;
 
@@ -2375,7 +2375,7 @@ static void rtw89_swap_chanctx(struct rtw89_dev *rtwdev,
 			       enum rtw89_chanctx_idx idx2)
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
-	struct rtw89_vif *rtwvif;
+	struct rtw89_vif_link *rtwvif_link;
 	u8 cur;
 
 	if (idx1 == idx2)
@@ -2386,13 +2386,13 @@ static void rtw89_swap_chanctx(struct rtw89_dev *rtwdev,
 
 	swap(hal->chanctx[idx1], hal->chanctx[idx2]);
 
-	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
-		if (!rtwvif->chanctx_assigned)
+	rtw89_for_each_rtwvif(rtwdev, rtwvif_link) {
+		if (!rtwvif_link->chanctx_assigned)
 			continue;
-		if (rtwvif->chanctx_idx == idx1)
-			rtwvif->chanctx_idx = idx2;
-		else if (rtwvif->chanctx_idx == idx2)
-			rtwvif->chanctx_idx = idx1;
+		if (rtwvif_link->chanctx_idx == idx1)
+			rtwvif_link->chanctx_idx = idx2;
+		else if (rtwvif_link->chanctx_idx == idx2)
+			rtwvif_link->chanctx_idx = idx1;
 	}
 
 	cur = atomic_read(&hal->roc_chanctx_idx);
@@ -2444,14 +2444,14 @@ void rtw89_chanctx_ops_change(struct rtw89_dev *rtwdev,
 }
 
 int rtw89_chanctx_ops_assign_vif(struct rtw89_dev *rtwdev,
-				 struct rtw89_vif *rtwvif,
+				 struct rtw89_vif_link *rtwvif_link,
 				 struct ieee80211_chanctx_conf *ctx)
 {
 	struct rtw89_chanctx_cfg *cfg = (struct rtw89_chanctx_cfg *)ctx->drv_priv;
 	struct rtw89_entity_weight w = {};
 
-	rtwvif->chanctx_idx = cfg->idx;
-	rtwvif->chanctx_assigned = true;
+	rtwvif_link->chanctx_idx = cfg->idx;
+	rtwvif_link->chanctx_assigned = true;
 	cfg->ref_count++;
 
 	if (cfg->idx == RTW89_CHANCTX_0)
@@ -2469,7 +2469,7 @@ int rtw89_chanctx_ops_assign_vif(struct rtw89_dev *rtwdev,
 }
 
 void rtw89_chanctx_ops_unassign_vif(struct rtw89_dev *rtwdev,
-				    struct rtw89_vif *rtwvif,
+				    struct rtw89_vif_link *rtwvif_link,
 				    struct ieee80211_chanctx_conf *ctx)
 {
 	struct rtw89_chanctx_cfg *cfg = (struct rtw89_chanctx_cfg *)ctx->drv_priv;
@@ -2479,8 +2479,8 @@ void rtw89_chanctx_ops_unassign_vif(struct rtw89_dev *rtwdev,
 	enum rtw89_entity_mode new;
 	int ret;
 
-	rtwvif->chanctx_idx = RTW89_CHANCTX_0;
-	rtwvif->chanctx_assigned = false;
+	rtwvif_link->chanctx_idx = RTW89_CHANCTX_0;
+	rtwvif_link->chanctx_assigned = false;
 	cfg->ref_count--;
 
 	if (cfg->ref_count != 0)
diff --git a/drivers/net/wireless/realtek/rtw89/chan.h b/drivers/net/wireless/realtek/rtw89/chan.h
index c6d31984e575..4ed777ea5064 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.h
+++ b/drivers/net/wireless/realtek/rtw89/chan.h
@@ -106,10 +106,10 @@ void rtw89_chanctx_ops_change(struct rtw89_dev *rtwdev,
 			      struct ieee80211_chanctx_conf *ctx,
 			      u32 changed);
 int rtw89_chanctx_ops_assign_vif(struct rtw89_dev *rtwdev,
-				 struct rtw89_vif *rtwvif,
+				 struct rtw89_vif_link *rtwvif_link,
 				 struct ieee80211_chanctx_conf *ctx);
 void rtw89_chanctx_ops_unassign_vif(struct rtw89_dev *rtwdev,
-				    struct rtw89_vif *rtwvif,
+				    struct rtw89_vif_link *rtwvif_link,
 				    struct ieee80211_chanctx_conf *ctx);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index df51b29142aa..af9f975983ae 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -4995,12 +4995,12 @@ static void rtw89_tx_time_iter(void *data, struct ieee80211_sta *sta)
 	struct rtw89_txtime_data *iter_data =
 				(struct rtw89_txtime_data *)data;
 	struct rtw89_dev *rtwdev = iter_data->rtwdev;
-	struct rtw89_vif *rtwvif = rtwsta->rtwvif;
+	struct rtw89_vif_link *rtwvif_link = rtwsta->rtwvif_link;
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_cx *cx = &btc->cx;
 	struct rtw89_btc_wl_info *wl = &cx->wl;
 	struct rtw89_btc_wl_link_info *plink = NULL;
-	u8 port = rtwvif->port;
+	u8 port = rtwvif_link->port;
 	u32 tx_time = iter_data->tx_time;
 	u8 tx_retry = iter_data->tx_retry;
 	u16 enable = iter_data->enable;
@@ -7479,12 +7479,13 @@ static void _update_bt_info(struct rtw89_dev *rtwdev, u8 *buf, u32 len)
 	_run_coex(rtwdev, BTC_RSN_UPDATE_BT_INFO);
 }
 
-void rtw89_btc_ntfy_role_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+void rtw89_btc_ntfy_role_info(struct rtw89_dev *rtwdev,
+			      struct rtw89_vif_link *rtwvif_link,
 			      struct rtw89_sta *rtwsta, enum btc_role_state state)
 {
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
-						       rtwvif->chanctx_idx);
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+						       rtwvif_link->chanctx_idx);
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
 	struct ieee80211_sta *sta = rtwsta_to_sta(rtwsta);
 	struct rtw89_btc *btc = &rtwdev->btc;
 	const struct rtw89_btc_ver *ver = btc->ver;
@@ -7497,7 +7498,7 @@ void rtw89_btc_ntfy_role_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif
 	rtw89_debug(rtwdev, RTW89_DBG_BTC,
 		    "[BTC], role is STA=%d\n",
 		    vif->type == NL80211_IFTYPE_STATION);
-	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], port=%d\n", rtwvif->port);
+	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], port=%d\n", rtwvif_link->port);
 	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], band=%d ch=%d bw=%d\n",
 		    chan->band_type, chan->channel, chan->band_width);
 	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], associated=%d\n",
@@ -7525,15 +7526,15 @@ void rtw89_btc_ntfy_role_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif
 		r.mode = mode;
 	}
 
-	if (rtwvif->wifi_role >= RTW89_WIFI_ROLE_MLME_MAX)
+	if (rtwvif_link->wifi_role >= RTW89_WIFI_ROLE_MLME_MAX)
 		return;
 
 	rtw89_debug(rtwdev, RTW89_DBG_BTC,
-		    "[BTC], wifi_role=%d\n", rtwvif->wifi_role);
+		    "[BTC], wifi_role=%d\n", rtwvif_link->wifi_role);
 
-	r.role = rtwvif->wifi_role;
-	r.phy = rtwvif->phy_idx;
-	r.pid = rtwvif->port;
+	r.role = rtwvif_link->wifi_role;
+	r.phy = rtwvif_link->phy_idx;
+	r.pid = rtwvif_link->port;
 	r.active = true;
 	r.connected = MLME_LINKED;
 	r.bcn_period = vif->bss_conf.beacon_int;
@@ -7545,7 +7546,7 @@ void rtw89_btc_ntfy_role_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif
 	r.chdef.center_ch = chan->channel;
 	r.chdef.bw = chan->band_width;
 	r.chdef.chan = chan->primary_channel;
-	ether_addr_copy(r.mac_addr, rtwvif->mac_addr);
+	ether_addr_copy(r.mac_addr, rtwvif_link->mac_addr);
 
 	if (rtwsta && vif->type == NL80211_IFTYPE_STATION)
 		r.mac_id = rtwsta->mac_id;
@@ -7791,14 +7792,14 @@ static void rtw89_btc_ntfy_wl_sta_iter(void *data, struct ieee80211_sta *sta)
 	struct rtw89_btc_wl_link_info *link_info = NULL;
 	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
 	struct rtw89_traffic_stats *link_info_t = NULL;
-	struct rtw89_vif *rtwvif = rtwsta->rtwvif;
-	struct rtw89_traffic_stats *stats = &rtwvif->stats;
+	struct rtw89_vif_link *rtwvif_link = rtwsta->rtwvif_link;
+	struct rtw89_traffic_stats *stats = &rtwvif_link->stats;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_btc_wl_role_info *r;
 	struct rtw89_btc_wl_role_info_v1 *r1;
 	u32 last_tx_rate, last_rx_rate;
 	u16 last_tx_lvl, last_rx_lvl;
-	u8 port = rtwvif->port;
+	u8 port = rtwvif_link->port;
 	u8 rssi;
 	u8 busy = 0;
 	u8 dir = 0;
@@ -7810,7 +7811,7 @@ static void rtw89_btc_ntfy_wl_sta_iter(void *data, struct ieee80211_sta *sta)
 	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], rssi=%d\n", rssi);
 
 	link_info = &wl->link_info[port];
-	link_info->stat.traffic = rtwvif->stats;
+	link_info->stat.traffic = rtwvif_link->stats;
 	link_info_t = &link_info->stat.traffic;
 
 	if (link_info->connected == MLME_NO_LINK) {
diff --git a/drivers/net/wireless/realtek/rtw89/coex.h b/drivers/net/wireless/realtek/rtw89/coex.h
index de53b56632f7..2a3bd1ead7c3 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.h
+++ b/drivers/net/wireless/realtek/rtw89/coex.h
@@ -271,7 +271,8 @@ void rtw89_btc_ntfy_eapol_packet_work(struct work_struct *work);
 void rtw89_btc_ntfy_arp_packet_work(struct work_struct *work);
 void rtw89_btc_ntfy_dhcp_packet_work(struct work_struct *work);
 void rtw89_btc_ntfy_icmp_packet_work(struct work_struct *work);
-void rtw89_btc_ntfy_role_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+void rtw89_btc_ntfy_role_info(struct rtw89_dev *rtwdev,
+			      struct rtw89_vif_link *rtwvif_link,
 			      struct rtw89_sta *rtwsta, enum btc_role_state state);
 void rtw89_btc_ntfy_radio_state(struct rtw89_dev *rtwdev, enum btc_rfctrl rf_state);
 void rtw89_btc_ntfy_wl_rfk(struct rtw89_dev *rtwdev, u8 phy_map,
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 4553810634c6..314c2e2ef8e9 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -436,12 +436,12 @@ int rtw89_set_channel(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
-void rtw89_get_channel(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+void rtw89_get_channel(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
 		       struct rtw89_chan *chan)
 {
 	const struct cfg80211_chan_def *chandef;
 
-	chandef = rtw89_chandef_get(rtwdev, rtwvif->chanctx_idx);
+	chandef = rtw89_chandef_get(rtwdev, rtwvif_link->chanctx_idx);
 	rtw89_get_channel_params(chandef, chan);
 }
 
@@ -591,12 +591,12 @@ static u8 rtw89_core_tx_get_mac_id(struct rtw89_dev *rtwdev,
 				   struct rtw89_core_tx_request *tx_req)
 {
 	struct ieee80211_vif *vif = tx_req->vif;
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 	struct ieee80211_sta *sta = tx_req->sta;
 	struct rtw89_sta *rtwsta;
 
 	if (!sta)
-		return rtwvif->mac_id;
+		return rtwvif_link->mac_id;
 
 	rtwsta = (struct rtw89_sta *)sta->drv_priv;
 	return rtwsta->mac_id;
@@ -619,10 +619,10 @@ rtw89_core_tx_update_mgmt_info(struct rtw89_dev *rtwdev,
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct ieee80211_vif *vif = tx_req->vif;
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 	struct rtw89_tx_desc_info *desc_info = &tx_req->desc_info;
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
-						       rtwvif->chanctx_idx);
+						       rtwvif_link->chanctx_idx);
 	struct sk_buff *skb = tx_req->skb;
 	u8 qsel, ch_dma;
 
@@ -631,7 +631,7 @@ rtw89_core_tx_update_mgmt_info(struct rtw89_dev *rtwdev,
 
 	desc_info->qsel = qsel;
 	desc_info->ch_dma = ch_dma;
-	desc_info->port = desc_info->hiq ? rtwvif->port : 0;
+	desc_info->port = desc_info->hiq ? rtwvif_link->port : 0;
 	desc_info->mac_id = rtw89_core_tx_get_mac_id(rtwdev, tx_req);
 	desc_info->hw_ssn_sel = RTW89_MGMT_HW_SSN_SEL;
 	desc_info->hw_seq_mode = RTW89_MGMT_HW_SEQ_MODE;
@@ -762,7 +762,7 @@ rtw89_core_tx_update_he_qos_htc(struct rtw89_dev *rtwdev,
 {
 	struct rtw89_tx_desc_info *desc_info = &tx_req->desc_info;
 	struct ieee80211_vif *vif = tx_req->vif;
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 
 	if (!__rtw89_core_tx_check_he_qos_htc(rtwdev, tx_req, pkt_type))
 		goto desc_bk;
@@ -773,10 +773,10 @@ rtw89_core_tx_update_he_qos_htc(struct rtw89_dev *rtwdev,
 	desc_info->a_ctrl_bsr = true;
 
 desc_bk:
-	if (!rtwvif || rtwvif->last_a_ctrl == desc_info->a_ctrl_bsr)
+	if (!rtwvif_link || rtwvif_link->last_a_ctrl == desc_info->a_ctrl_bsr)
 		return;
 
-	rtwvif->last_a_ctrl = desc_info->a_ctrl_bsr;
+	rtwvif_link->last_a_ctrl = desc_info->a_ctrl_bsr;
 	desc_info->bk = true;
 }
 
@@ -785,9 +785,9 @@ static u16 rtw89_core_get_data_rate(struct rtw89_dev *rtwdev,
 {
 	struct ieee80211_vif *vif = tx_req->vif;
 	struct ieee80211_sta *sta = tx_req->sta;
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
-	struct rtw89_phy_rate_pattern *rate_pattern = &rtwvif->rate_pattern;
-	enum rtw89_chanctx_idx idx = rtwvif->chanctx_idx;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
+	struct rtw89_phy_rate_pattern *rate_pattern = &rtwvif_link->rate_pattern;
+	enum rtw89_chanctx_idx idx = rtwvif_link->chanctx_idx;
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, idx);
 	u16 lowest_rate;
 
@@ -813,7 +813,7 @@ rtw89_core_tx_update_data_info(struct rtw89_dev *rtwdev,
 {
 	struct ieee80211_vif *vif = tx_req->vif;
 	struct ieee80211_sta *sta = tx_req->sta;
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 	struct rtw89_sta *rtwsta = sta_to_rtwsta_safe(sta);
 	struct rtw89_tx_desc_info *desc_info = &tx_req->desc_info;
 	struct sk_buff *skb = tx_req->skb;
@@ -829,7 +829,7 @@ rtw89_core_tx_update_data_info(struct rtw89_dev *rtwdev,
 	desc_info->tid_indicate = tid_indicate;
 	desc_info->qsel = qsel;
 	desc_info->mac_id = rtw89_core_tx_get_mac_id(rtwdev, tx_req);
-	desc_info->port = desc_info->hiq ? rtwvif->port : 0;
+	desc_info->port = desc_info->hiq ? rtwvif_link->port : 0;
 	desc_info->er_cap = rtwsta ? rtwsta->er_cap : false;
 	desc_info->stbc = rtwsta ? rtwsta->ra.stbc_cap : false;
 	desc_info->ldpc = rtwsta ? rtwsta->ra.ldpc_cap : false;
@@ -1028,7 +1028,7 @@ int rtw89_core_tx_write(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 			struct ieee80211_sta *sta, struct sk_buff *skb, int *qsel)
 {
 	struct rtw89_core_tx_request tx_req = {0};
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 	int ret;
 
 	tx_req.skb = skb;
@@ -1036,7 +1036,7 @@ int rtw89_core_tx_write(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 	tx_req.vif = vif;
 
 	rtw89_traffic_stats_accu(rtwdev, &rtwdev->stats, skb, true);
-	rtw89_traffic_stats_accu(rtwdev, &rtwvif->stats, skb, true);
+	rtw89_traffic_stats_accu(rtwdev, &rtwvif_link->stats, skb, true);
 	rtw89_core_tx_update_desc_info(rtwdev, &tx_req);
 	rtw89_core_tx_wake(rtwdev, &tx_req);
 
@@ -1879,14 +1879,14 @@ static void rtw89_stats_trigger_frame(struct rtw89_dev *rtwdev,
 				      struct ieee80211_vif *vif,
 				      struct sk_buff *skb)
 {
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 	struct ieee80211_trigger *tf = (struct ieee80211_trigger *)skb->data;
 	u8 *pos, *end, type, tf_bw;
 	u16 aid, tf_rua;
 
 	if (!ether_addr_equal(vif->bss_conf.bssid, tf->ta) ||
-	    rtwvif->wifi_role != RTW89_WIFI_ROLE_STATION ||
-	    rtwvif->net_type == RTW89_NET_TYPE_NO_LINK)
+	    rtwvif_link->wifi_role != RTW89_WIFI_ROLE_STATION ||
+	    rtwvif_link->net_type == RTW89_NET_TYPE_NO_LINK)
 		return;
 
 	type = le64_get_bits(tf->common_info, IEEE80211_TRIGGER_TYPE_MASK);
@@ -1911,11 +1911,11 @@ static void rtw89_stats_trigger_frame(struct rtw89_dev *rtwdev,
 		if (aid == vif->cfg.aid) {
 			enum nl80211_he_ru_alloc rua = rtw89_he_rua_to_ru_alloc(tf_rua >> 1);
 
-			rtwvif->stats.rx_tf_acc++;
+			rtwvif_link->stats.rx_tf_acc++;
 			rtwdev->stats.rx_tf_acc++;
 			if (tf_bw == IEEE80211_TRIGGER_ULBW_160_80P80MHZ &&
 			    rua <= NL80211_RATE_INFO_HE_RU_ALLOC_106)
-				rtwvif->pwr_diff_en = true;
+				rtwvif_link->pwr_diff_en = true;
 			break;
 		}
 
@@ -1986,7 +1986,7 @@ static void rtw89_core_cancel_6ghz_probe_tx(struct rtw89_dev *rtwdev,
 		ieee80211_queue_work(rtwdev->hw, &rtwdev->cancel_6ghz_probe_work);
 }
 
-static void rtw89_vif_sync_bcn_tsf(struct rtw89_vif *rtwvif,
+static void rtw89_vif_sync_bcn_tsf(struct rtw89_vif_link *rtwvif_link,
 				   struct ieee80211_hdr *hdr, size_t len)
 {
 	struct ieee80211_mgmt *mgmt = (typeof(mgmt))hdr;
@@ -1994,13 +1994,13 @@ static void rtw89_vif_sync_bcn_tsf(struct rtw89_vif *rtwvif,
 	if (len < offsetof(typeof(*mgmt), u.beacon.variable))
 		return;
 
-	WRITE_ONCE(rtwvif->sync_bcn_tsf, le64_to_cpu(mgmt->u.beacon.timestamp));
+	WRITE_ONCE(rtwvif_link->sync_bcn_tsf, le64_to_cpu(mgmt->u.beacon.timestamp));
 }
 
 static void rtw89_vif_rx_stats_iter(void *data, u8 *mac,
 				    struct ieee80211_vif *vif)
 {
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 	struct rtw89_vif_rx_stats_iter_data *iter_data = data;
 	struct rtw89_dev *rtwdev = iter_data->rtwdev;
 	struct rtw89_pkt_stat *pkt_stat = &rtwdev->phystat.cur_pkt_stat;
@@ -2029,7 +2029,7 @@ static void rtw89_vif_rx_stats_iter(void *data, u8 *mac,
 	if (ieee80211_is_beacon(hdr->frame_control)) {
 		if (vif->type == NL80211_IFTYPE_STATION &&
 		    !test_bit(RTW89_FLAG_WOWLAN, rtwdev->flags)) {
-			rtw89_vif_sync_bcn_tsf(rtwvif, hdr, skb->len);
+			rtw89_vif_sync_bcn_tsf(rtwvif_link, hdr, skb->len);
 			rtw89_fw_h2c_rssi_offload(rtwdev, phy_ppdu);
 		}
 		pkt_stat->beacon_nr++;
@@ -2041,7 +2041,7 @@ static void rtw89_vif_rx_stats_iter(void *data, u8 *mac,
 	if (desc_info->data_rate < RTW89_HW_RATE_NR)
 		pkt_stat->rx_rate_cnt[desc_info->data_rate]++;
 
-	rtw89_traffic_stats_accu(rtwdev, &rtwvif->stats, skb, false);
+	rtw89_traffic_stats_accu(rtwdev, &rtwvif_link->stats, skb, false);
 }
 
 static void rtw89_core_rx_stats(struct rtw89_dev *rtwdev,
@@ -2869,7 +2869,7 @@ static void rtw89_core_txq_schedule(struct rtw89_dev *rtwdev, u8 ac, bool *reinv
 {
 	struct ieee80211_hw *hw = rtwdev->hw;
 	struct ieee80211_txq *txq;
-	struct rtw89_vif *rtwvif;
+	struct rtw89_vif_link *rtwvif_link;
 	struct rtw89_txq *rtwtxq;
 	unsigned long frame_cnt;
 	unsigned long byte_cnt;
@@ -2879,9 +2879,9 @@ static void rtw89_core_txq_schedule(struct rtw89_dev *rtwdev, u8 ac, bool *reinv
 	ieee80211_txq_schedule_start(hw, ac);
 	while ((txq = ieee80211_next_txq(hw, ac))) {
 		rtwtxq = (struct rtw89_txq *)txq->drv_priv;
-		rtwvif = (struct rtw89_vif *)txq->vif->drv_priv;
+		rtwvif_link = (struct rtw89_vif_link *)txq->vif->drv_priv;
 
-		if (rtwvif->offchan) {
+		if (rtwvif_link->offchan) {
 			ieee80211_return_txq(hw, txq, true);
 			continue;
 		}
@@ -2956,13 +2956,14 @@ static void rtw89_core_sta_pending_tx_iter(void *data,
 					   struct ieee80211_sta *sta)
 {
 	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
-	struct rtw89_vif *rtwvif_target = data, *rtwvif = rtwsta->rtwvif;
-	struct rtw89_dev *rtwdev = rtwvif->rtwdev;
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+	struct rtw89_vif_link *rtwvif_target = data;
+	struct rtw89_vif_link *rtwvif_link = rtwsta->rtwvif_link;
+	struct rtw89_dev *rtwdev = rtwvif_link->rtwdev;
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
 	struct sk_buff *skb, *tmp;
 	int qsel, ret;
 
-	if (rtwvif->chanctx_idx != rtwvif_target->chanctx_idx)
+	if (rtwvif_link->chanctx_idx != rtwvif_target->chanctx_idx)
 		return;
 
 	if (skb_queue_len(&rtwsta->roc_queue) == 0)
@@ -2982,17 +2983,17 @@ static void rtw89_core_sta_pending_tx_iter(void *data,
 }
 
 static void rtw89_core_handle_sta_pending_tx(struct rtw89_dev *rtwdev,
-					     struct rtw89_vif *rtwvif)
+					     struct rtw89_vif_link *rtwvif_link)
 {
 	ieee80211_iterate_stations_atomic(rtwdev->hw,
 					  rtw89_core_sta_pending_tx_iter,
-					  rtwvif);
+					  rtwvif_link);
 }
 
 static int rtw89_core_send_nullfunc(struct rtw89_dev *rtwdev,
-				    struct rtw89_vif *rtwvif, bool qos, bool ps)
+				    struct rtw89_vif_link *rtwvif_link, bool qos, bool ps)
 {
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
 	struct ieee80211_sta *sta;
 	struct ieee80211_hdr *hdr;
 	struct sk_buff *skb;
@@ -3035,13 +3036,13 @@ static int rtw89_core_send_nullfunc(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
-void rtw89_roc_start(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+void rtw89_roc_start(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	struct ieee80211_hw *hw = rtwdev->hw;
-	struct rtw89_roc *roc = &rtwvif->roc;
+	struct rtw89_roc *roc = &rtwvif_link->roc;
 	struct cfg80211_chan_def roc_chan;
-	struct rtw89_vif *tmp;
+	struct rtw89_vif_link *tmp;
 	int ret;
 
 	lockdep_assert_held(&rtwdev->mutex);
@@ -3050,34 +3051,34 @@ void rtw89_roc_start(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	rtw89_leave_lps(rtwdev);
 	rtw89_chanctx_pause(rtwdev, RTW89_CHANCTX_PAUSE_REASON_ROC);
 
-	ret = rtw89_core_send_nullfunc(rtwdev, rtwvif, true, true);
+	ret = rtw89_core_send_nullfunc(rtwdev, rtwvif_link, true, true);
 	if (ret)
 		rtw89_debug(rtwdev, RTW89_DBG_TXRX,
 			    "roc send null-1 failed: %d\n", ret);
 
 	rtw89_for_each_rtwvif(rtwdev, tmp)
-		if (tmp->chanctx_idx == rtwvif->chanctx_idx)
+		if (tmp->chanctx_idx == rtwvif_link->chanctx_idx)
 			tmp->offchan = true;
 
 	cfg80211_chandef_create(&roc_chan, &roc->chan, NL80211_CHAN_NO_HT);
-	rtw89_config_roc_chandef(rtwdev, rtwvif->chanctx_idx, &roc_chan);
+	rtw89_config_roc_chandef(rtwdev, rtwvif_link->chanctx_idx, &roc_chan);
 	rtw89_set_channel(rtwdev);
 	rtw89_write32_clr(rtwdev,
 			  rtw89_mac_reg_by_idx(rtwdev, mac->rx_fltr, RTW89_MAC_0),
 			  B_AX_A_UC_CAM_MATCH | B_AX_A_BC_CAM_MATCH);
 
 	ieee80211_ready_on_channel(hw);
-	cancel_delayed_work(&rtwvif->roc.roc_work);
-	ieee80211_queue_delayed_work(hw, &rtwvif->roc.roc_work,
-				     msecs_to_jiffies(rtwvif->roc.duration));
+	cancel_delayed_work(&rtwvif_link->roc.roc_work);
+	ieee80211_queue_delayed_work(hw, &rtwvif_link->roc.roc_work,
+				     msecs_to_jiffies(rtwvif_link->roc.duration));
 }
 
-void rtw89_roc_end(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+void rtw89_roc_end(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	struct ieee80211_hw *hw = rtwdev->hw;
-	struct rtw89_roc *roc = &rtwvif->roc;
-	struct rtw89_vif *tmp;
+	struct rtw89_roc *roc = &rtwvif_link->roc;
+	struct rtw89_vif_link *tmp;
 	int ret;
 
 	lockdep_assert_held(&rtwdev->mutex);
@@ -3093,18 +3094,18 @@ void rtw89_roc_end(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 			   rtwdev->hal.rx_fltr);
 
 	roc->state = RTW89_ROC_IDLE;
-	rtw89_config_roc_chandef(rtwdev, rtwvif->chanctx_idx, NULL);
+	rtw89_config_roc_chandef(rtwdev, rtwvif_link->chanctx_idx, NULL);
 	rtw89_chanctx_proceed(rtwdev);
-	ret = rtw89_core_send_nullfunc(rtwdev, rtwvif, true, false);
+	ret = rtw89_core_send_nullfunc(rtwdev, rtwvif_link, true, false);
 	if (ret)
 		rtw89_debug(rtwdev, RTW89_DBG_TXRX,
 			    "roc send null-0 failed: %d\n", ret);
 
 	rtw89_for_each_rtwvif(rtwdev, tmp)
-		if (tmp->chanctx_idx == rtwvif->chanctx_idx)
+		if (tmp->chanctx_idx == rtwvif_link->chanctx_idx)
 			tmp->offchan = false;
 
-	rtw89_core_handle_sta_pending_tx(rtwdev, rtwvif);
+	rtw89_core_handle_sta_pending_tx(rtwdev, rtwvif_link);
 	queue_work(rtwdev->txq_wq, &rtwdev->txq_work);
 
 	if (hw->conf.flags & IEEE80211_CONF_IDLE)
@@ -3114,10 +3115,10 @@ void rtw89_roc_end(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 
 void rtw89_roc_work(struct work_struct *work)
 {
-	struct rtw89_vif *rtwvif = container_of(work, struct rtw89_vif,
-						roc.roc_work.work);
-	struct rtw89_dev *rtwdev = rtwvif->rtwdev;
-	struct rtw89_roc *roc = &rtwvif->roc;
+	struct rtw89_vif_link *rtwvif_link = container_of(work, struct rtw89_vif_link,
+							  roc.roc_work.work);
+	struct rtw89_dev *rtwdev = rtwvif_link->rtwdev;
+	struct rtw89_roc *roc = &rtwvif_link->roc;
 
 	mutex_lock(&rtwdev->mutex);
 
@@ -3127,7 +3128,7 @@ void rtw89_roc_work(struct work_struct *work)
 		break;
 	case RTW89_ROC_MGMT:
 	case RTW89_ROC_NORMAL:
-		rtw89_roc_end(rtwdev, rtwvif);
+		rtw89_roc_end(rtwdev, rtwvif_link);
 		break;
 	default:
 		break;
@@ -3188,39 +3189,40 @@ static bool rtw89_traffic_stats_calc(struct rtw89_dev *rtwdev,
 
 static bool rtw89_traffic_stats_track(struct rtw89_dev *rtwdev)
 {
-	struct rtw89_vif *rtwvif;
+	struct rtw89_vif_link *rtwvif_link;
 	bool tfc_changed;
 
 	tfc_changed = rtw89_traffic_stats_calc(rtwdev, &rtwdev->stats);
-	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
-		rtw89_traffic_stats_calc(rtwdev, &rtwvif->stats);
-		rtw89_fw_h2c_tp_offload(rtwdev, rtwvif);
+	rtw89_for_each_rtwvif(rtwdev, rtwvif_link) {
+		rtw89_traffic_stats_calc(rtwdev, &rtwvif_link->stats);
+		rtw89_fw_h2c_tp_offload(rtwdev, rtwvif_link);
 	}
 
 	return tfc_changed;
 }
 
-static void rtw89_vif_enter_lps(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+static void rtw89_vif_enter_lps(struct rtw89_dev *rtwdev,
+				struct rtw89_vif_link *rtwvif_link)
 {
-	if ((rtwvif->wifi_role != RTW89_WIFI_ROLE_STATION &&
-	     rtwvif->wifi_role != RTW89_WIFI_ROLE_P2P_CLIENT) ||
-	    rtwvif->tdls_peer)
+	if ((rtwvif_link->wifi_role != RTW89_WIFI_ROLE_STATION &&
+	     rtwvif_link->wifi_role != RTW89_WIFI_ROLE_P2P_CLIENT) ||
+	    rtwvif_link->tdls_peer)
 		return;
 
-	if (rtwvif->offchan)
+	if (rtwvif_link->offchan)
 		return;
 
-	if (rtwvif->stats.tx_tfc_lv == RTW89_TFC_IDLE &&
-	    rtwvif->stats.rx_tfc_lv == RTW89_TFC_IDLE)
-		rtw89_enter_lps(rtwdev, rtwvif, true);
+	if (rtwvif_link->stats.tx_tfc_lv == RTW89_TFC_IDLE &&
+	    rtwvif_link->stats.rx_tfc_lv == RTW89_TFC_IDLE)
+		rtw89_enter_lps(rtwdev, rtwvif_link, true);
 }
 
 static void rtw89_enter_lps_track(struct rtw89_dev *rtwdev)
 {
-	struct rtw89_vif *rtwvif;
+	struct rtw89_vif_link *rtwvif_link;
 
-	rtw89_for_each_rtwvif(rtwdev, rtwvif)
-		rtw89_vif_enter_lps(rtwdev, rtwvif);
+	rtw89_for_each_rtwvif(rtwdev, rtwvif_link)
+		rtw89_vif_enter_lps(rtwdev, rtwvif_link);
 }
 
 static void rtw89_core_rfk_track(struct rtw89_dev *rtwdev)
@@ -3396,24 +3398,24 @@ int rtw89_core_release_sta_ba_entry(struct rtw89_dev *rtwdev,
 
 #define RTW89_TYPE_MAPPING(_type)	\
 	case NL80211_IFTYPE_ ## _type:	\
-		rtwvif->wifi_role = RTW89_WIFI_ROLE_ ## _type;	\
+		rtwvif_link->wifi_role = RTW89_WIFI_ROLE_ ## _type;	\
 		break
 void rtw89_vif_type_mapping(struct ieee80211_vif *vif, bool assoc)
 {
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 
 	switch (vif->type) {
 	case NL80211_IFTYPE_STATION:
 		if (vif->p2p)
-			rtwvif->wifi_role = RTW89_WIFI_ROLE_P2P_CLIENT;
+			rtwvif_link->wifi_role = RTW89_WIFI_ROLE_P2P_CLIENT;
 		else
-			rtwvif->wifi_role = RTW89_WIFI_ROLE_STATION;
+			rtwvif_link->wifi_role = RTW89_WIFI_ROLE_STATION;
 		break;
 	case NL80211_IFTYPE_AP:
 		if (vif->p2p)
-			rtwvif->wifi_role = RTW89_WIFI_ROLE_P2P_GO;
+			rtwvif_link->wifi_role = RTW89_WIFI_ROLE_P2P_GO;
 		else
-			rtwvif->wifi_role = RTW89_WIFI_ROLE_AP;
+			rtwvif_link->wifi_role = RTW89_WIFI_ROLE_AP;
 		break;
 	RTW89_TYPE_MAPPING(ADHOC);
 	RTW89_TYPE_MAPPING(MONITOR);
@@ -3426,23 +3428,23 @@ void rtw89_vif_type_mapping(struct ieee80211_vif *vif, bool assoc)
 	switch (vif->type) {
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_MESH_POINT:
-		rtwvif->net_type = RTW89_NET_TYPE_AP_MODE;
-		rtwvif->self_role = RTW89_SELF_ROLE_AP;
+		rtwvif_link->net_type = RTW89_NET_TYPE_AP_MODE;
+		rtwvif_link->self_role = RTW89_SELF_ROLE_AP;
 		break;
 	case NL80211_IFTYPE_ADHOC:
-		rtwvif->net_type = RTW89_NET_TYPE_AD_HOC;
-		rtwvif->self_role = RTW89_SELF_ROLE_CLIENT;
+		rtwvif_link->net_type = RTW89_NET_TYPE_AD_HOC;
+		rtwvif_link->self_role = RTW89_SELF_ROLE_CLIENT;
 		break;
 	case NL80211_IFTYPE_STATION:
 		if (assoc) {
-			rtwvif->net_type = RTW89_NET_TYPE_INFRA;
-			rtwvif->trigger = vif->bss_conf.he_support;
+			rtwvif_link->net_type = RTW89_NET_TYPE_INFRA;
+			rtwvif_link->trigger = vif->bss_conf.he_support;
 		} else {
-			rtwvif->net_type = RTW89_NET_TYPE_NO_LINK;
-			rtwvif->trigger = false;
+			rtwvif_link->net_type = RTW89_NET_TYPE_NO_LINK;
+			rtwvif_link->trigger = false;
 		}
-		rtwvif->self_role = RTW89_SELF_ROLE_CLIENT;
-		rtwvif->addr_cam.sec_ent_mode = RTW89_ADDR_CAM_SEC_NORMAL;
+		rtwvif_link->self_role = RTW89_SELF_ROLE_CLIENT;
+		rtwvif_link->addr_cam.sec_ent_mode = RTW89_ADDR_CAM_SEC_NORMAL;
 		break;
 	case NL80211_IFTYPE_MONITOR:
 		break;
@@ -3456,7 +3458,7 @@ int rtw89_core_sta_add(struct rtw89_dev *rtwdev,
 		       struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta)
 {
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
 	struct rtw89_hal *hal = &rtwdev->hal;
 	u8 ant_num = hal->ant_diversity ? 2 : rtwdev->chip->rf_path_num;
@@ -3464,7 +3466,7 @@ int rtw89_core_sta_add(struct rtw89_dev *rtwdev,
 	int ret;
 
 	rtwsta->rtwdev = rtwdev;
-	rtwsta->rtwvif = rtwvif;
+	rtwsta->rtwvif_link = rtwvif_link;
 	rtwsta->prev_rssi = 0;
 	INIT_LIST_HEAD(&rtwsta->ba_cam_list);
 	skb_queue_head_init(&rtwsta->roc_queue);
@@ -3483,16 +3485,16 @@ int rtw89_core_sta_add(struct rtw89_dev *rtwdev,
 
 	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls) {
 		/* for station mode, assign the mac_id from itself */
-		rtwsta->mac_id = rtwvif->mac_id;
+		rtwsta->mac_id = rtwvif_link->mac_id;
 
 		/* must do rtw89_reg_6ghz_recalc() before rfk channel */
-		ret = rtw89_reg_6ghz_recalc(rtwdev, rtwvif, true);
+		ret = rtw89_reg_6ghz_recalc(rtwdev, rtwvif_link, true);
 		if (ret)
 			return ret;
 
-		rtw89_btc_ntfy_role_info(rtwdev, rtwvif, rtwsta,
+		rtw89_btc_ntfy_role_info(rtwdev, rtwvif_link, rtwsta,
 					 BTC_ROLE_MSTS_STA_CONN_START);
-		rtw89_chip_rfk_channel(rtwdev, rtwvif);
+		rtw89_chip_rfk_channel(rtwdev, rtwvif_link);
 	} else if (vif->type == NL80211_IFTYPE_AP || sta->tdls) {
 		rtwsta->mac_id = rtw89_acquire_mac_id(rtwdev);
 		if (rtwsta->mac_id == RTW89_MAX_MAC_ID_NUM)
@@ -3505,7 +3507,7 @@ int rtw89_core_sta_add(struct rtw89_dev *rtwdev,
 			return ret;
 		}
 
-		ret = rtw89_fw_h2c_role_maintain(rtwdev, rtwvif, rtwsta,
+		ret = rtw89_fw_h2c_role_maintain(rtwdev, rtwvif_link, rtwsta,
 						 RTW89_ROLE_CREATE);
 		if (ret) {
 			rtw89_release_mac_id(rtwdev, rtwsta->mac_id);
@@ -3513,11 +3515,11 @@ int rtw89_core_sta_add(struct rtw89_dev *rtwdev,
 			return ret;
 		}
 
-		ret = rtw89_chip_h2c_default_cmac_tbl(rtwdev, rtwvif, rtwsta);
+		ret = rtw89_chip_h2c_default_cmac_tbl(rtwdev, rtwvif_link, rtwsta);
 		if (ret)
 			return ret;
 
-		ret = rtw89_chip_h2c_default_dmac_tbl(rtwdev, rtwvif, rtwsta);
+		ret = rtw89_chip_h2c_default_dmac_tbl(rtwdev, rtwvif_link, rtwsta);
 		if (ret)
 			return ret;
 
@@ -3531,7 +3533,7 @@ int rtw89_core_sta_disassoc(struct rtw89_dev *rtwdev,
 			    struct ieee80211_vif *vif,
 			    struct ieee80211_sta *sta)
 {
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
 
 	if (vif->type == NL80211_IFTYPE_STATION)
@@ -3539,7 +3541,7 @@ int rtw89_core_sta_disassoc(struct rtw89_dev *rtwdev,
 
 	rtwdev->total_sta_assoc--;
 	if (sta->tdls)
-		rtwvif->tdls_peer--;
+		rtwvif_link->tdls_peer--;
 	rtwsta->disassoc = true;
 
 	return 0;
@@ -3549,7 +3551,7 @@ int rtw89_core_sta_disconnect(struct rtw89_dev *rtwdev,
 			      struct ieee80211_vif *vif,
 			      struct ieee80211_sta *sta)
 {
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
 	int ret;
 
@@ -3566,7 +3568,7 @@ int rtw89_core_sta_disconnect(struct rtw89_dev *rtwdev,
 
 	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls) {
 		rtw89_vif_type_mapping(vif, false);
-		rtw89_fw_release_general_pkt_list_vif(rtwdev, rtwvif, true);
+		rtw89_fw_release_general_pkt_list_vif(rtwdev, rtwvif_link, true);
 	}
 
 	ret = rtw89_chip_h2c_assoc_cmac_tbl(rtwdev, vif, sta);
@@ -3575,14 +3577,14 @@ int rtw89_core_sta_disconnect(struct rtw89_dev *rtwdev,
 		return ret;
 	}
 
-	ret = rtw89_fw_h2c_join_info(rtwdev, rtwvif, rtwsta, true);
+	ret = rtw89_fw_h2c_join_info(rtwdev, rtwvif_link, rtwsta, true);
 	if (ret) {
 		rtw89_warn(rtwdev, "failed to send h2c join info\n");
 		return ret;
 	}
 
 	/* update cam aid mac_id net_type */
-	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif, rtwsta, NULL);
+	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif_link, rtwsta, NULL);
 	if (ret) {
 		rtw89_warn(rtwdev, "failed to send h2c cam\n");
 		return ret;
@@ -3595,16 +3597,18 @@ int rtw89_core_sta_assoc(struct rtw89_dev *rtwdev,
 			 struct ieee80211_vif *vif,
 			 struct ieee80211_sta *sta)
 {
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
-	struct rtw89_bssid_cam_entry *bssid_cam = rtw89_get_bssid_cam_of(rtwvif, rtwsta);
+	struct rtw89_bssid_cam_entry *bssid_cam = rtw89_get_bssid_cam_of(rtwvif_link,
+									 rtwsta);
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
-						       rtwvif->chanctx_idx);
+						       rtwvif_link->chanctx_idx);
 	int ret;
 
 	if (vif->type == NL80211_IFTYPE_AP || sta->tdls) {
 		if (sta->tdls) {
-			ret = rtw89_cam_init_bssid_cam(rtwdev, rtwvif, bssid_cam, sta->addr);
+			ret = rtw89_cam_init_bssid_cam(rtwdev, rtwvif_link, bssid_cam,
+						       sta->addr);
 			if (ret) {
 				rtw89_warn(rtwdev, "failed to send h2c init bssid cam for TDLS\n");
 				return ret;
@@ -3624,14 +3628,14 @@ int rtw89_core_sta_assoc(struct rtw89_dev *rtwdev,
 		return ret;
 	}
 
-	ret = rtw89_fw_h2c_join_info(rtwdev, rtwvif, rtwsta, false);
+	ret = rtw89_fw_h2c_join_info(rtwdev, rtwvif_link, rtwsta, false);
 	if (ret) {
 		rtw89_warn(rtwdev, "failed to send h2c join info\n");
 		return ret;
 	}
 
 	/* update cam aid mac_id net_type */
-	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif, rtwsta, NULL);
+	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif_link, rtwsta, NULL);
 	if (ret) {
 		rtw89_warn(rtwdev, "failed to send h2c cam\n");
 		return ret;
@@ -3639,7 +3643,7 @@ int rtw89_core_sta_assoc(struct rtw89_dev *rtwdev,
 
 	rtwdev->total_sta_assoc++;
 	if (sta->tdls)
-		rtwvif->tdls_peer++;
+		rtwvif_link->tdls_peer++;
 	rtw89_phy_ra_assoc(rtwdev, sta);
 	rtw89_mac_bf_assoc(rtwdev, vif, sta);
 	rtw89_mac_bf_monitor_calc(rtwdev, sta, false);
@@ -3651,12 +3655,12 @@ int rtw89_core_sta_assoc(struct rtw89_dev *rtwdev,
 		    !(bss_conf->he_oper.params & IEEE80211_HE_OPERATION_ER_SU_DISABLE))
 			rtwsta->er_cap = true;
 
-		rtw89_btc_ntfy_role_info(rtwdev, rtwvif, rtwsta,
+		rtw89_btc_ntfy_role_info(rtwdev, rtwvif_link, rtwsta,
 					 BTC_ROLE_MSTS_STA_CONN_END);
 		rtw89_core_get_no_ul_ofdma_htc(rtwdev, &rtwsta->htc_template, chan);
-		rtw89_phy_ul_tb_assoc(rtwdev, rtwvif);
+		rtw89_phy_ul_tb_assoc(rtwdev, rtwvif_link);
 
-		ret = rtw89_fw_h2c_general_pkt(rtwdev, rtwvif, rtwsta->mac_id);
+		ret = rtw89_fw_h2c_general_pkt(rtwdev, rtwvif_link, rtwsta->mac_id);
 		if (ret) {
 			rtw89_warn(rtwdev, "failed to send h2c general packet\n");
 			return ret;
@@ -3672,18 +3676,18 @@ int rtw89_core_sta_remove(struct rtw89_dev *rtwdev,
 			  struct ieee80211_vif *vif,
 			  struct ieee80211_sta *sta)
 {
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
 	int ret;
 
 	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls) {
-		rtw89_reg_6ghz_recalc(rtwdev, rtwvif, false);
-		rtw89_btc_ntfy_role_info(rtwdev, rtwvif, rtwsta,
+		rtw89_reg_6ghz_recalc(rtwdev, rtwvif_link, false);
+		rtw89_btc_ntfy_role_info(rtwdev, rtwvif_link, rtwsta,
 					 BTC_ROLE_MSTS_STA_DIS_CONN);
 	} else if (vif->type == NL80211_IFTYPE_AP || sta->tdls) {
 		rtw89_release_mac_id(rtwdev, rtwsta->mac_id);
 
-		ret = rtw89_fw_h2c_role_maintain(rtwdev, rtwvif, rtwsta,
+		ret = rtw89_fw_h2c_role_maintain(rtwdev, rtwvif_link, rtwsta,
 						 RTW89_ROLE_REMOVE);
 		if (ret) {
 			rtw89_warn(rtwdev, "failed to send h2c role info\n");
@@ -4152,15 +4156,15 @@ static void rtw89_core_ppdu_sts_init(struct rtw89_dev *rtwdev)
 void rtw89_core_update_beacon_work(struct work_struct *work)
 {
 	struct rtw89_dev *rtwdev;
-	struct rtw89_vif *rtwvif = container_of(work, struct rtw89_vif,
-						update_beacon_work);
+	struct rtw89_vif_link *rtwvif_link = container_of(work, struct rtw89_vif_link,
+							  update_beacon_work);
 
-	if (rtwvif->net_type != RTW89_NET_TYPE_AP_MODE)
+	if (rtwvif_link->net_type != RTW89_NET_TYPE_AP_MODE)
 		return;
 
-	rtwdev = rtwvif->rtwdev;
+	rtwdev = rtwvif_link->rtwdev;
 	mutex_lock(&rtwdev->mutex);
-	rtw89_chip_h2c_update_beacon(rtwdev, rtwvif);
+	rtw89_chip_h2c_update_beacon(rtwdev, rtwvif_link);
 	mutex_unlock(&rtwdev->mutex);
 }
 
@@ -4444,38 +4448,39 @@ void rtw89_core_deinit(struct rtw89_dev *rtwdev)
 }
 EXPORT_SYMBOL(rtw89_core_deinit);
 
-void rtw89_core_scan_start(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+void rtw89_core_scan_start(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
 			   const u8 *mac_addr, bool hw_scan)
 {
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
-						       rtwvif->chanctx_idx);
+						       rtwvif_link->chanctx_idx);
 
 	rtwdev->scanning = true;
 	rtw89_leave_lps(rtwdev);
 	if (hw_scan)
 		rtw89_leave_ips_by_hwflags(rtwdev);
 
-	ether_addr_copy(rtwvif->mac_addr, mac_addr);
+	ether_addr_copy(rtwvif_link->mac_addr, mac_addr);
 	rtw89_btc_ntfy_scan_start(rtwdev, RTW89_PHY_0, chan->band_type);
-	rtw89_chip_rfk_scan(rtwdev, rtwvif, true);
+	rtw89_chip_rfk_scan(rtwdev, rtwvif_link, true);
 	rtw89_hci_recalc_int_mit(rtwdev);
 	rtw89_phy_config_edcca(rtwdev, true);
 
-	rtw89_fw_h2c_cam(rtwdev, rtwvif, NULL, mac_addr);
+	rtw89_fw_h2c_cam(rtwdev, rtwvif_link, NULL, mac_addr);
 }
 
 void rtw89_core_scan_complete(struct rtw89_dev *rtwdev,
 			      struct ieee80211_vif *vif, bool hw_scan)
 {
-	struct rtw89_vif *rtwvif = vif ? (struct rtw89_vif *)vif->drv_priv : NULL;
+	struct rtw89_vif_link *rtwvif_link =
+		vif ? (struct rtw89_vif_link *)vif->drv_priv : NULL;
 
-	if (!rtwvif)
+	if (!rtwvif_link)
 		return;
 
-	ether_addr_copy(rtwvif->mac_addr, vif->addr);
-	rtw89_fw_h2c_cam(rtwdev, rtwvif, NULL, NULL);
+	ether_addr_copy(rtwvif_link->mac_addr, vif->addr);
+	rtw89_fw_h2c_cam(rtwdev, rtwvif_link, NULL, NULL);
 
-	rtw89_chip_rfk_scan(rtwdev, rtwvif, false);
+	rtw89_chip_rfk_scan(rtwdev, rtwvif_link, false);
 	rtw89_btc_ntfy_scan_finish(rtwdev, RTW89_PHY_0);
 	rtw89_phy_config_edcca(rtwdev, false);
 
@@ -4697,7 +4702,7 @@ static int rtw89_core_register_hw(struct rtw89_dev *rtwdev)
 	int ret;
 	int tx_headroom = IEEE80211_HT_CTL_LEN;
 
-	hw->vif_data_size = sizeof(struct rtw89_vif);
+	hw->vif_data_size = sizeof(struct rtw89_vif_link);
 	hw->sta_data_size = sizeof(struct rtw89_sta);
 	hw->txq_data_size = sizeof(struct rtw89_txq);
 	hw->chanctx_data_size = sizeof(struct rtw89_chanctx_cfg);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 4ed9034fdb46..e897c4f79f06 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3359,7 +3359,7 @@ struct rtw89_sta {
 	bool disassoc;
 	bool er_cap;
 	struct rtw89_dev *rtwdev;
-	struct rtw89_vif *rtwvif;
+	struct rtw89_vif_link *rtwvif_link;
 	struct rtw89_ra_info ra;
 	struct rtw89_ra_report ra_report;
 	int max_agg_wait;
@@ -3460,7 +3460,7 @@ struct rtw89_p2p_noa_setter {
 	u8 noa_index;
 };
 
-struct rtw89_vif {
+struct rtw89_vif_link {
 	struct list_head list;
 	struct rtw89_dev *rtwdev;
 	struct rtw89_roc roc;
@@ -3599,11 +3599,11 @@ struct rtw89_chip_ops {
 	void (*rfk_hw_init)(struct rtw89_dev *rtwdev);
 	void (*rfk_init)(struct rtw89_dev *rtwdev);
 	void (*rfk_init_late)(struct rtw89_dev *rtwdev);
-	void (*rfk_channel)(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
+	void (*rfk_channel)(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link);
 	void (*rfk_band_changed)(struct rtw89_dev *rtwdev,
 				 enum rtw89_phy_idx phy_idx,
 				 const struct rtw89_chan *chan);
-	void (*rfk_scan)(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+	void (*rfk_scan)(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
 			 bool start);
 	void (*rfk_track)(struct rtw89_dev *rtwdev);
 	void (*power_trim)(struct rtw89_dev *rtwdev);
@@ -3646,10 +3646,10 @@ struct rtw89_chip_ops {
 			   u32 *tx_en, enum rtw89_sch_tx_sel sel);
 	int (*resume_sch_tx)(struct rtw89_dev *rtwdev, u8 mac_idx, u32 tx_en);
 	int (*h2c_dctl_sec_cam)(struct rtw89_dev *rtwdev,
-				struct rtw89_vif *rtwvif,
+				struct rtw89_vif_link *rtwvif_link,
 				struct rtw89_sta *rtwsta);
 	int (*h2c_default_cmac_tbl)(struct rtw89_dev *rtwdev,
-				    struct rtw89_vif *rtwvif,
+				    struct rtw89_vif_link *rtwvif_link,
 				    struct rtw89_sta *rtwsta);
 	int (*h2c_assoc_cmac_tbl)(struct rtw89_dev *rtwdev,
 				  struct ieee80211_vif *vif,
@@ -3658,10 +3658,10 @@ struct rtw89_chip_ops {
 				  struct ieee80211_vif *vif,
 				  struct ieee80211_sta *sta);
 	int (*h2c_default_dmac_tbl)(struct rtw89_dev *rtwdev,
-				    struct rtw89_vif *rtwvif,
+				    struct rtw89_vif_link *rtwvif_link,
 				    struct rtw89_sta *rtwsta);
 	int (*h2c_update_beacon)(struct rtw89_dev *rtwdev,
-				 struct rtw89_vif *rtwvif);
+				 struct rtw89_vif_link *rtwvif_link);
 	int (*h2c_ba_cam)(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 			  bool valid, struct ieee80211_ampdu_params *params);
 
@@ -5408,7 +5408,7 @@ struct rtw89_mcc_policy {
 };
 
 struct rtw89_mcc_role {
-	struct rtw89_vif *rtwvif;
+	struct rtw89_vif_link *rtwvif_link;
 	struct rtw89_mcc_policy policy;
 	struct rtw89_mcc_limit limit;
 
@@ -5960,21 +5960,21 @@ static inline void rtw89_core_txq_init(struct rtw89_dev *rtwdev,
 	INIT_LIST_HEAD(&rtwtxq->list);
 }
 
-static inline struct ieee80211_vif *rtwvif_to_vif(struct rtw89_vif *rtwvif)
+static inline struct ieee80211_vif *rtwvif_to_vif(struct rtw89_vif_link *rtwvif_link)
 {
-	void *p = rtwvif;
+	void *p = rtwvif_link;
 
 	return container_of(p, struct ieee80211_vif, drv_priv);
 }
 
-static inline struct ieee80211_vif *rtwvif_to_vif_safe(struct rtw89_vif *rtwvif)
+static inline struct ieee80211_vif *rtwvif_to_vif_safe(struct rtw89_vif_link *rtwvif_link)
 {
-	return rtwvif ? rtwvif_to_vif(rtwvif) : NULL;
+	return rtwvif_link ? rtwvif_to_vif(rtwvif_link) : NULL;
 }
 
-static inline struct rtw89_vif *vif_to_rtwvif_safe(struct ieee80211_vif *vif)
+static inline struct rtw89_vif_link *vif_to_rtwvif_safe(struct ieee80211_vif *vif)
 {
-	return vif ? (struct rtw89_vif *)vif->drv_priv : NULL;
+	return vif ? (struct rtw89_vif_link *)vif->drv_priv : NULL;
 }
 
 static inline struct ieee80211_sta *rtwsta_to_sta(struct rtw89_sta *rtwsta)
@@ -6078,20 +6078,20 @@ enum nl80211_he_ru_alloc rtw89_he_rua_to_ru_alloc(u16 rua)
 }
 
 static inline
-struct rtw89_addr_cam_entry *rtw89_get_addr_cam_of(struct rtw89_vif *rtwvif,
+struct rtw89_addr_cam_entry *rtw89_get_addr_cam_of(struct rtw89_vif_link *rtwvif_link,
 						   struct rtw89_sta *rtwsta)
 {
 	if (rtwsta) {
 		struct ieee80211_sta *sta = rtwsta_to_sta(rtwsta);
 
-		if (rtwvif->net_type == RTW89_NET_TYPE_AP_MODE || sta->tdls)
+		if (rtwvif_link->net_type == RTW89_NET_TYPE_AP_MODE || sta->tdls)
 			return &rtwsta->addr_cam;
 	}
-	return &rtwvif->addr_cam;
+	return &rtwvif_link->addr_cam;
 }
 
 static inline
-struct rtw89_bssid_cam_entry *rtw89_get_bssid_cam_of(struct rtw89_vif *rtwvif,
+struct rtw89_bssid_cam_entry *rtw89_get_bssid_cam_of(struct rtw89_vif_link *rtwvif_link,
 						     struct rtw89_sta *rtwsta)
 {
 	if (rtwsta) {
@@ -6100,7 +6100,7 @@ struct rtw89_bssid_cam_entry *rtw89_get_bssid_cam_of(struct rtw89_vif *rtwvif,
 		if (sta->tdls)
 			return &rtwsta->bssid_cam;
 	}
-	return &rtwvif->bssid_cam;
+	return &rtwvif_link->bssid_cam;
 }
 
 static inline
@@ -6160,10 +6160,10 @@ static inline
 const struct rtw89_chan *rtw89_scan_chan_get(struct rtw89_dev *rtwdev)
 {
 	struct ieee80211_vif *vif = rtwdev->scan_info.scanning_vif;
-	struct rtw89_vif *rtwvif = vif_to_rtwvif_safe(vif);
+	struct rtw89_vif_link *rtwvif_link = vif_to_rtwvif_safe(vif);
 
-	if (rtwvif)
-		return rtw89_chan_get(rtwdev, rtwvif->chanctx_idx);
+	if (rtwvif_link)
+		return rtw89_chan_get(rtwdev, rtwvif_link->chanctx_idx);
 	else
 		return rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 }
@@ -6240,12 +6240,12 @@ static inline void rtw89_chip_rfk_init_late(struct rtw89_dev *rtwdev)
 }
 
 static inline void rtw89_chip_rfk_channel(struct rtw89_dev *rtwdev,
-					  struct rtw89_vif *rtwvif)
+					  struct rtw89_vif_link *rtwvif_link)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 
 	if (chip->ops->rfk_channel)
-		chip->ops->rfk_channel(rtwdev, rtwvif);
+		chip->ops->rfk_channel(rtwdev, rtwvif_link);
 }
 
 static inline void rtw89_chip_rfk_band_changed(struct rtw89_dev *rtwdev,
@@ -6259,12 +6259,12 @@ static inline void rtw89_chip_rfk_band_changed(struct rtw89_dev *rtwdev,
 }
 
 static inline void rtw89_chip_rfk_scan(struct rtw89_dev *rtwdev,
-				       struct rtw89_vif *rtwvif, bool start)
+				       struct rtw89_vif_link *rtwvif_link, bool start)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 
 	if (chip->ops->rfk_scan)
-		chip->ops->rfk_scan(rtwdev, rtwvif, start);
+		chip->ops->rfk_scan(rtwdev, rtwvif_link, start);
 }
 
 static inline void rtw89_chip_rfk_track(struct rtw89_dev *rtwdev)
@@ -6351,14 +6351,14 @@ static inline
 void rtw89_chip_cfg_txpwr_ul_tb_offset(struct rtw89_dev *rtwdev,
 				       struct ieee80211_vif *vif)
 {
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 
 	if (!vif->bss_conf.he_support || !vif->cfg.assoc)
 		return;
 
 	if (chip->ops->set_txpwr_ul_tb_offset)
-		chip->ops->set_txpwr_ul_tb_offset(rtwdev, 0, rtwvif->mac_idx);
+		chip->ops->set_txpwr_ul_tb_offset(rtwdev, 0, rtwvif_link->mac_idx);
 }
 
 static inline void rtw89_chip_digital_pwr_comp(struct rtw89_dev *rtwdev,
@@ -6457,14 +6457,14 @@ int rtw89_chip_resume_sch_tx(struct rtw89_dev *rtwdev, u8 mac_idx, u32 tx_en)
 
 static inline
 int rtw89_chip_h2c_dctl_sec_cam(struct rtw89_dev *rtwdev,
-				struct rtw89_vif *rtwvif,
+				struct rtw89_vif_link *rtwvif_link,
 				struct rtw89_sta *rtwsta)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 
 	if (!chip->ops->h2c_dctl_sec_cam)
 		return 0;
-	return chip->ops->h2c_dctl_sec_cam(rtwdev, rtwvif, rtwsta);
+	return chip->ops->h2c_dctl_sec_cam(rtwdev, rtwvif_link, rtwsta);
 }
 
 static inline u8 *get_hdr_bssid(struct ieee80211_hdr *hdr)
@@ -6640,7 +6640,7 @@ void rtw89_get_default_chandef(struct cfg80211_chan_def *chandef);
 void rtw89_get_channel_params(const struct cfg80211_chan_def *chandef,
 			      struct rtw89_chan *chan);
 int rtw89_set_channel(struct rtw89_dev *rtwdev);
-void rtw89_get_channel(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+void rtw89_get_channel(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
 		       struct rtw89_chan *chan);
 u8 rtw89_core_acquire_bit_map(unsigned long *addr, unsigned long size);
 void rtw89_core_release_bit_map(unsigned long *addr, u8 bit);
@@ -6665,13 +6665,13 @@ int rtw89_core_start(struct rtw89_dev *rtwdev);
 void rtw89_core_stop(struct rtw89_dev *rtwdev);
 void rtw89_core_update_beacon_work(struct work_struct *work);
 void rtw89_roc_work(struct work_struct *work);
-void rtw89_roc_start(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
-void rtw89_roc_end(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
-void rtw89_core_scan_start(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+void rtw89_roc_start(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link);
+void rtw89_roc_end(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link);
+void rtw89_core_scan_start(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
 			   const u8 *mac_addr, bool hw_scan);
 void rtw89_core_scan_complete(struct rtw89_dev *rtwdev,
 			      struct ieee80211_vif *vif, bool hw_scan);
-int rtw89_reg_6ghz_recalc(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+int rtw89_reg_6ghz_recalc(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
 			  bool active);
 void rtw89_core_update_p2p_ps(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif);
 void rtw89_core_ntfy_btc_event(struct rtw89_dev *rtwdev, enum rtw89_btc_hmsg event);
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 29f85210f919..26327e4b071d 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -3740,21 +3740,22 @@ static void rtw89_dump_pkt_offload(struct seq_file *m, struct list_head *pkt_lis
 static
 void rtw89_vif_ids_get_iter(void *data, u8 *mac, struct ieee80211_vif *vif)
 {
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
-	struct rtw89_dev *rtwdev = rtwvif->rtwdev;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
+	struct rtw89_dev *rtwdev = rtwvif_link->rtwdev;
 	struct seq_file *m = (struct seq_file *)data;
-	struct rtw89_bssid_cam_entry *bssid_cam = &rtwvif->bssid_cam;
+	struct rtw89_bssid_cam_entry *bssid_cam = &rtwvif_link->bssid_cam;
 
-	seq_printf(m, "VIF [%d] %pM\n", rtwvif->mac_id, rtwvif->mac_addr);
+	seq_printf(m, "VIF [%d] %pM\n", rtwvif_link->mac_id, rtwvif_link->mac_addr);
 	seq_printf(m, "\tbssid_cam_idx=%u\n", bssid_cam->bssid_cam_idx);
-	rtw89_dump_addr_cam(m, rtwdev, &rtwvif->addr_cam);
-	rtw89_dump_pkt_offload(m, &rtwvif->general_pkt_list, "\tpkt_ofld[GENERAL]: ");
+	rtw89_dump_addr_cam(m, rtwdev, &rtwvif_link->addr_cam);
+	rtw89_dump_pkt_offload(m, &rtwvif_link->general_pkt_list,
+			       "\tpkt_ofld[GENERAL]: ");
 }
 
 static void rtw89_dump_ba_cam(struct seq_file *m, struct rtw89_sta *rtwsta)
 {
-	struct rtw89_vif *rtwvif = rtwsta->rtwvif;
-	struct rtw89_dev *rtwdev = rtwvif->rtwdev;
+	struct rtw89_vif_link *rtwvif_link = rtwsta->rtwvif_link;
+	struct rtw89_dev *rtwdev = rtwvif_link->rtwdev;
 	struct rtw89_ba_cam_entry *entry;
 	bool first = true;
 
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index d9b0e7ebe619..1d5de66bf945 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1741,7 +1741,7 @@ void rtw89_fw_log_dump(struct rtw89_dev *rtwdev, u8 *buf, u32 len)
 }
 
 #define H2C_CAM_LEN 60
-int rtw89_fw_h2c_cam(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+int rtw89_fw_h2c_cam(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
 		     struct rtw89_sta *rtwsta, const u8 *scan_mac_addr)
 {
 	struct sk_buff *skb;
@@ -1753,8 +1753,9 @@ int rtw89_fw_h2c_cam(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 		return -ENOMEM;
 	}
 	skb_put(skb, H2C_CAM_LEN);
-	rtw89_cam_fill_addr_cam_info(rtwdev, rtwvif, rtwsta, scan_mac_addr, skb->data);
-	rtw89_cam_fill_bssid_cam_info(rtwdev, rtwvif, rtwsta, skb->data);
+	rtw89_cam_fill_addr_cam_info(rtwdev, rtwvif_link, rtwsta, scan_mac_addr,
+				     skb->data);
+	rtw89_cam_fill_bssid_cam_info(rtwdev, rtwvif_link, rtwsta, skb->data);
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_MAC,
@@ -1776,7 +1777,7 @@ int rtw89_fw_h2c_cam(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 }
 
 int rtw89_fw_h2c_dctl_sec_cam_v1(struct rtw89_dev *rtwdev,
-				 struct rtw89_vif *rtwvif,
+				 struct rtw89_vif_link *rtwvif_link,
 				 struct rtw89_sta *rtwsta)
 {
 	struct rtw89_h2c_dctlinfo_ud_v1 *h2c;
@@ -1792,7 +1793,7 @@ int rtw89_fw_h2c_dctl_sec_cam_v1(struct rtw89_dev *rtwdev,
 	skb_put(skb, len);
 	h2c = (struct rtw89_h2c_dctlinfo_ud_v1 *)skb->data;
 
-	rtw89_cam_fill_dctl_sec_cam_info_v1(rtwdev, rtwvif, rtwsta, h2c);
+	rtw89_cam_fill_dctl_sec_cam_info_v1(rtwdev, rtwvif_link, rtwsta, h2c);
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_MAC,
@@ -1815,7 +1816,7 @@ int rtw89_fw_h2c_dctl_sec_cam_v1(struct rtw89_dev *rtwdev,
 EXPORT_SYMBOL(rtw89_fw_h2c_dctl_sec_cam_v1);
 
 int rtw89_fw_h2c_dctl_sec_cam_v2(struct rtw89_dev *rtwdev,
-				 struct rtw89_vif *rtwvif,
+				 struct rtw89_vif_link *rtwvif_link,
 				 struct rtw89_sta *rtwsta)
 {
 	struct rtw89_h2c_dctlinfo_ud_v2 *h2c;
@@ -1831,7 +1832,7 @@ int rtw89_fw_h2c_dctl_sec_cam_v2(struct rtw89_dev *rtwdev,
 	skb_put(skb, len);
 	h2c = (struct rtw89_h2c_dctlinfo_ud_v2 *)skb->data;
 
-	rtw89_cam_fill_dctl_sec_cam_info_v2(rtwdev, rtwvif, rtwsta, h2c);
+	rtw89_cam_fill_dctl_sec_cam_info_v2(rtwdev, rtwvif_link, rtwsta, h2c);
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_MAC,
@@ -1854,10 +1855,10 @@ int rtw89_fw_h2c_dctl_sec_cam_v2(struct rtw89_dev *rtwdev,
 EXPORT_SYMBOL(rtw89_fw_h2c_dctl_sec_cam_v2);
 
 int rtw89_fw_h2c_default_dmac_tbl_v2(struct rtw89_dev *rtwdev,
-				     struct rtw89_vif *rtwvif,
+				     struct rtw89_vif_link *rtwvif_link,
 				     struct rtw89_sta *rtwsta)
 {
-	u8 mac_id = rtwsta ? rtwsta->mac_id : rtwvif->mac_id;
+	u8 mac_id = rtwsta ? rtwsta->mac_id : rtwvif_link->mac_id;
 	struct rtw89_h2c_dctlinfo_ud_v2 *h2c;
 	u32 len = sizeof(*h2c);
 	struct sk_buff *skb;
@@ -1912,7 +1913,7 @@ int rtw89_fw_h2c_ba_cam(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 			bool valid, struct ieee80211_ampdu_params *params)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
-	struct rtw89_vif *rtwvif = rtwsta->rtwvif;
+	struct rtw89_vif_link *rtwvif_link = rtwsta->rtwvif_link;
 	struct rtw89_h2c_ba_cam *h2c;
 	u8 macid = rtwsta->mac_id;
 	u32 len = sizeof(*h2c);
@@ -1960,7 +1961,8 @@ int rtw89_fw_h2c_ba_cam(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 
 	if (chip->bacam_ver == RTW89_BACAM_V0_EXT) {
 		h2c->w1 |= le32_encode_bits(1, RTW89_H2C_BA_CAM_W1_STD_EN) |
-			   le32_encode_bits(rtwvif->mac_idx, RTW89_H2C_BA_CAM_W1_BAND);
+			   le32_encode_bits(rtwvif_link->mac_idx,
+					    RTW89_H2C_BA_CAM_W1_BAND);
 	}
 
 end:
@@ -2043,7 +2045,7 @@ int rtw89_fw_h2c_ba_cam_v1(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 			   bool valid, struct ieee80211_ampdu_params *params)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
-	struct rtw89_vif *rtwvif = rtwsta->rtwvif;
+	struct rtw89_vif_link *rtwvif_link = rtwsta->rtwvif_link;
 	struct rtw89_h2c_ba_cam_v1 *h2c;
 	u8 macid = rtwsta->mac_id;
 	u32 len = sizeof(*h2c);
@@ -2092,7 +2094,8 @@ int rtw89_fw_h2c_ba_cam_v1(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 	entry_idx += chip->bacam_dynamic_num; /* std entry right after dynamic ones */
 	h2c->w1 = le32_encode_bits(entry_idx, RTW89_H2C_BA_CAM_V1_W1_ENTRY_IDX_MASK) |
 		  le32_encode_bits(1, RTW89_H2C_BA_CAM_V1_W1_STD_ENTRY_EN) |
-		  le32_encode_bits(!!rtwvif->mac_idx, RTW89_H2C_BA_CAM_V1_W1_BAND_SEL);
+		  le32_encode_bits(!!rtwvif_link->mac_idx,
+				   RTW89_H2C_BA_CAM_V1_W1_BAND_SEL);
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_MAC,
@@ -2197,11 +2200,11 @@ int rtw89_fw_h2c_fw_log(struct rtw89_dev *rtwdev, bool enable)
 }
 
 static struct sk_buff *rtw89_eapol_get(struct rtw89_dev *rtwdev,
-				       struct rtw89_vif *rtwvif)
+				       struct rtw89_vif_link *rtwvif_link)
 {
 	static const u8 gtkbody[] = {0xAA, 0xAA, 0x03, 0x00, 0x00, 0x00, 0x88,
 				     0x8E, 0x01, 0x03, 0x00, 0x5F, 0x02, 0x03};
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
 	struct ieee80211_bss_conf *bss_conf = &vif->bss_conf;
 	u8 sec_hdr_len = rtw89_wow_get_sec_hdr_len(rtwdev);
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
@@ -2241,9 +2244,9 @@ static struct sk_buff *rtw89_eapol_get(struct rtw89_dev *rtwdev,
 }
 
 static struct sk_buff *rtw89_sa_query_get(struct rtw89_dev *rtwdev,
-					  struct rtw89_vif *rtwvif)
+					  struct rtw89_vif_link *rtwvif_link)
 {
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
 	struct ieee80211_bss_conf *bss_conf = &vif->bss_conf;
 	u8 sec_hdr_len = rtw89_wow_get_sec_hdr_len(rtwdev);
 	struct ieee80211_hdr_3addr *hdr;
@@ -2272,7 +2275,7 @@ static struct sk_buff *rtw89_sa_query_get(struct rtw89_dev *rtwdev,
 }
 
 static struct sk_buff *rtw89_arp_response_get(struct rtw89_dev *rtwdev,
-					      struct rtw89_vif *rtwvif)
+					      struct rtw89_vif_link *rtwvif_link)
 {
 	u8 sec_hdr_len = rtw89_wow_get_sec_hdr_len(rtwdev);
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
@@ -2295,9 +2298,9 @@ static struct sk_buff *rtw89_arp_response_get(struct rtw89_dev *rtwdev,
 		fc = cpu_to_le16(IEEE80211_FTYPE_DATA | IEEE80211_FCTL_TODS);
 
 	hdr->frame_control = fc;
-	ether_addr_copy(hdr->addr1, rtwvif->bssid);
-	ether_addr_copy(hdr->addr2, rtwvif->mac_addr);
-	ether_addr_copy(hdr->addr3, rtwvif->bssid);
+	ether_addr_copy(hdr->addr1, rtwvif_link->bssid);
+	ether_addr_copy(hdr->addr2, rtwvif_link->mac_addr);
+	ether_addr_copy(hdr->addr3, rtwvif_link->bssid);
 
 	skb_put_zero(skb, sec_hdr_len);
 
@@ -2312,18 +2315,18 @@ static struct sk_buff *rtw89_arp_response_get(struct rtw89_dev *rtwdev,
 	arp_hdr->ar_pln = 4;
 	arp_hdr->ar_op = htons(ARPOP_REPLY);
 
-	ether_addr_copy(arp_skb->sender_hw, rtwvif->mac_addr);
-	arp_skb->sender_ip = rtwvif->ip_addr;
+	ether_addr_copy(arp_skb->sender_hw, rtwvif_link->mac_addr);
+	arp_skb->sender_ip = rtwvif_link->ip_addr;
 
 	return skb;
 }
 
 static int rtw89_fw_h2c_add_general_pkt(struct rtw89_dev *rtwdev,
-					struct rtw89_vif *rtwvif,
+					struct rtw89_vif_link *rtwvif_link,
 					enum rtw89_fw_pkt_ofld_type type,
 					u8 *id)
 {
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
 	struct rtw89_pktofld_info *info;
 	struct sk_buff *skb;
 	int ret;
@@ -2346,13 +2349,13 @@ static int rtw89_fw_h2c_add_general_pkt(struct rtw89_dev *rtwdev,
 		skb = ieee80211_nullfunc_get(rtwdev->hw, vif, -1, true);
 		break;
 	case RTW89_PKT_OFLD_TYPE_EAPOL_KEY:
-		skb = rtw89_eapol_get(rtwdev, rtwvif);
+		skb = rtw89_eapol_get(rtwdev, rtwvif_link);
 		break;
 	case RTW89_PKT_OFLD_TYPE_SA_QUERY:
-		skb = rtw89_sa_query_get(rtwdev, rtwvif);
+		skb = rtw89_sa_query_get(rtwdev, rtwvif_link);
 		break;
 	case RTW89_PKT_OFLD_TYPE_ARP_RSP:
-		skb = rtw89_arp_response_get(rtwdev, rtwvif);
+		skb = rtw89_arp_response_get(rtwdev, rtwvif_link);
 		break;
 	default:
 		goto err;
@@ -2367,7 +2370,7 @@ static int rtw89_fw_h2c_add_general_pkt(struct rtw89_dev *rtwdev,
 	if (ret)
 		goto err;
 
-	list_add_tail(&info->list, &rtwvif->general_pkt_list);
+	list_add_tail(&info->list, &rtwvif_link->general_pkt_list);
 	*id = info->id;
 	return 0;
 
@@ -2377,9 +2380,10 @@ static int rtw89_fw_h2c_add_general_pkt(struct rtw89_dev *rtwdev,
 }
 
 void rtw89_fw_release_general_pkt_list_vif(struct rtw89_dev *rtwdev,
-					   struct rtw89_vif *rtwvif, bool notify_fw)
+					   struct rtw89_vif_link *rtwvif_link,
+					   bool notify_fw)
 {
-	struct list_head *pkt_list = &rtwvif->general_pkt_list;
+	struct list_head *pkt_list = &rtwvif_link->general_pkt_list;
 	struct rtw89_pktofld_info *info, *tmp;
 
 	list_for_each_entry_safe(info, tmp, pkt_list, list) {
@@ -2394,16 +2398,16 @@ void rtw89_fw_release_general_pkt_list_vif(struct rtw89_dev *rtwdev,
 
 void rtw89_fw_release_general_pkt_list(struct rtw89_dev *rtwdev, bool notify_fw)
 {
-	struct rtw89_vif *rtwvif;
+	struct rtw89_vif_link *rtwvif_link;
 
-	rtw89_for_each_rtwvif(rtwdev, rtwvif)
-		rtw89_fw_release_general_pkt_list_vif(rtwdev, rtwvif, notify_fw);
+	rtw89_for_each_rtwvif(rtwdev, rtwvif_link)
+		rtw89_fw_release_general_pkt_list_vif(rtwdev, rtwvif_link, notify_fw);
 }
 
 #define H2C_GENERAL_PKT_LEN 6
 #define H2C_GENERAL_PKT_ID_UND 0xff
 int rtw89_fw_h2c_general_pkt(struct rtw89_dev *rtwdev,
-			     struct rtw89_vif *rtwvif, u8 macid)
+			     struct rtw89_vif_link *rtwvif_link, u8 macid)
 {
 	u8 pkt_id_ps_poll = H2C_GENERAL_PKT_ID_UND;
 	u8 pkt_id_null = H2C_GENERAL_PKT_ID_UND;
@@ -2411,11 +2415,11 @@ int rtw89_fw_h2c_general_pkt(struct rtw89_dev *rtwdev,
 	struct sk_buff *skb;
 	int ret;
 
-	rtw89_fw_h2c_add_general_pkt(rtwdev, rtwvif,
+	rtw89_fw_h2c_add_general_pkt(rtwdev, rtwvif_link,
 				     RTW89_PKT_OFLD_TYPE_PS_POLL, &pkt_id_ps_poll);
-	rtw89_fw_h2c_add_general_pkt(rtwdev, rtwvif,
+	rtw89_fw_h2c_add_general_pkt(rtwdev, rtwvif_link,
 				     RTW89_PKT_OFLD_TYPE_NULL_DATA, &pkt_id_null);
-	rtw89_fw_h2c_add_general_pkt(rtwdev, rtwvif,
+	rtw89_fw_h2c_add_general_pkt(rtwdev, rtwvif_link,
 				     RTW89_PKT_OFLD_TYPE_QOS_NULL, &pkt_id_qos_null);
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_GENERAL_PKT_LEN);
@@ -2494,10 +2498,10 @@ int rtw89_fw_h2c_lps_parm(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
-int rtw89_fw_h2c_lps_ch_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+int rtw89_fw_h2c_lps_ch_info(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link)
 {
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
-						       rtwvif->chanctx_idx);
+						       rtwvif_link->chanctx_idx);
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_h2c_lps_ch_info *h2c;
 	u32 len = sizeof(*h2c);
@@ -2550,8 +2554,8 @@ int rtw89_fw_h2c_p2p_act(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 			 struct ieee80211_p2p_noa_desc *desc,
 			 u8 act, u8 noa_id)
 {
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
-	bool p2p_type_gc = rtwvif->wifi_role == RTW89_WIFI_ROLE_P2P_CLIENT;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
+	bool p2p_type_gc = rtwvif_link->wifi_role == RTW89_WIFI_ROLE_P2P_CLIENT;
 	u8 ctwindow_oppps = vif->bss_conf.p2p_noa_attr.oppps_ctwindow;
 	struct sk_buff *skb;
 	u8 *cmd;
@@ -2565,7 +2569,7 @@ int rtw89_fw_h2c_p2p_act(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 	skb_put(skb, H2C_P2P_ACT_LEN);
 	cmd = skb->data;
 
-	RTW89_SET_FWCMD_P2P_MACID(cmd, rtwvif->mac_id);
+	RTW89_SET_FWCMD_P2P_MACID(cmd, rtwvif_link->mac_id);
 	RTW89_SET_FWCMD_P2P_P2PID(cmd, 0);
 	RTW89_SET_FWCMD_P2P_NOAID(cmd, noa_id);
 	RTW89_SET_FWCMD_P2P_ACT(cmd, act);
@@ -2622,11 +2626,11 @@ static void __rtw89_fw_h2c_set_tx_path(struct rtw89_dev *rtwdev,
 
 #define H2C_CMC_TBL_LEN 68
 int rtw89_fw_h2c_default_cmac_tbl(struct rtw89_dev *rtwdev,
-				  struct rtw89_vif *rtwvif,
+				  struct rtw89_vif_link *rtwvif_link,
 				  struct rtw89_sta *rtwsta)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
-	u8 macid = rtwsta ? rtwsta->mac_id : rtwvif->mac_id;
+	u8 macid = rtwsta ? rtwsta->mac_id : rtwvif_link->mac_id;
 	struct sk_buff *skb;
 	int ret;
 
@@ -2648,7 +2652,7 @@ int rtw89_fw_h2c_default_cmac_tbl(struct rtw89_dev *rtwdev,
 	}
 	SET_CMC_TBL_DOPPLER_CTRL(skb->data, 0);
 	SET_CMC_TBL_TXPWR_TOLERENCE(skb->data, 0);
-	if (rtwvif->net_type == RTW89_NET_TYPE_AP_MODE)
+	if (rtwvif_link->net_type == RTW89_NET_TYPE_AP_MODE)
 		SET_CMC_TBL_DATA_DCM(skb->data, 0);
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
@@ -2671,10 +2675,10 @@ int rtw89_fw_h2c_default_cmac_tbl(struct rtw89_dev *rtwdev,
 EXPORT_SYMBOL(rtw89_fw_h2c_default_cmac_tbl);
 
 int rtw89_fw_h2c_default_cmac_tbl_g7(struct rtw89_dev *rtwdev,
-				     struct rtw89_vif *rtwvif,
+				     struct rtw89_vif_link *rtwvif_link,
 				     struct rtw89_sta *rtwsta)
 {
-	u8 mac_id = rtwsta ? rtwsta->mac_id : rtwvif->mac_id;
+	u8 mac_id = rtwsta ? rtwsta->mac_id : rtwvif_link->mac_id;
 	struct rtw89_h2c_cctlinfo_ud_g7 *h2c;
 	u32 len = sizeof(*h2c);
 	struct sk_buff *skb;
@@ -2814,12 +2818,12 @@ int rtw89_fw_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_sta *rtwsta = sta_to_rtwsta_safe(sta);
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
-						       rtwvif->chanctx_idx);
+						       rtwvif_link->chanctx_idx);
 	struct sk_buff *skb;
 	u8 pads[RTW89_PPE_BW_NUM];
-	u8 mac_id = rtwsta ? rtwsta->mac_id : rtwvif->mac_id;
+	u8 mac_id = rtwsta ? rtwsta->mac_id : rtwvif_link->mac_id;
 	u16 lowest_rate;
 	int ret;
 
@@ -2851,7 +2855,7 @@ int rtw89_fw_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
 		SET_CMC_TBL_ULDL(skb->data, 1);
 	else
 		SET_CMC_TBL_ULDL(skb->data, 0);
-	SET_CMC_TBL_MULTI_PORT_ID(skb->data, rtwvif->port);
+	SET_CMC_TBL_MULTI_PORT_ID(skb->data, rtwvif_link->port);
 	if (chip->h2c_cctl_func_id == H2C_FUNC_MAC_CCTLINFO_UD_V1) {
 		SET_CMC_TBL_NOMINAL_PKT_PADDING_V1(skb->data, pads[RTW89_CHANNEL_WIDTH_20]);
 		SET_CMC_TBL_NOMINAL_PKT_PADDING40_V1(skb->data, pads[RTW89_CHANNEL_WIDTH_40]);
@@ -2866,7 +2870,7 @@ int rtw89_fw_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
 	if (sta)
 		SET_CMC_TBL_BSR_QUEUE_SIZE_FORMAT(skb->data,
 						  sta->deflink.he_cap.has_he);
-	if (rtwvif->net_type == RTW89_NET_TYPE_AP_MODE)
+	if (rtwvif_link->net_type == RTW89_NET_TYPE_AP_MODE)
 		SET_CMC_TBL_DATA_DCM(skb->data, 0);
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
@@ -2949,10 +2953,10 @@ int rtw89_fw_h2c_assoc_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 				   struct ieee80211_vif *vif,
 				   struct ieee80211_sta *sta)
 {
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 	struct rtw89_sta *rtwsta = sta_to_rtwsta_safe(sta);
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, rtwvif->chanctx_idx);
-	u8 mac_id = rtwsta ? rtwsta->mac_id : rtwvif->mac_id;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, rtwvif_link->chanctx_idx);
+	u8 mac_id = rtwsta ? rtwsta->mac_id : rtwvif_link->mac_id;
 	struct rtw89_h2c_cctlinfo_ud_g7 *h2c;
 	u8 pads[RTW89_PPE_BW_NUM];
 	u32 len = sizeof(*h2c);
@@ -3000,10 +3004,10 @@ int rtw89_fw_h2c_assoc_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 	h2c->w3 = le32_encode_bits(0, CCTLINFO_G7_W3_RTS_TXCNT_LMT_SEL);
 	h2c->m3 = cpu_to_le32(CCTLINFO_G7_W3_RTS_TXCNT_LMT_SEL);
 
-	h2c->w4 = le32_encode_bits(rtwvif->port, CCTLINFO_G7_W4_MULTI_PORT_ID);
+	h2c->w4 = le32_encode_bits(rtwvif_link->port, CCTLINFO_G7_W4_MULTI_PORT_ID);
 	h2c->m4 = cpu_to_le32(CCTLINFO_G7_W4_MULTI_PORT_ID);
 
-	if (rtwvif->net_type == RTW89_NET_TYPE_AP_MODE) {
+	if (rtwvif_link->net_type == RTW89_NET_TYPE_AP_MODE) {
 		h2c->w4 |= le32_encode_bits(0, CCTLINFO_G7_W4_DATA_DCM);
 		h2c->m4 |= cpu_to_le32(CCTLINFO_G7_W4_DATA_DCM);
 	}
@@ -3209,11 +3213,11 @@ int rtw89_fw_h2c_txpath_cmac_tbl(struct rtw89_dev *rtwdev,
 }
 
 int rtw89_fw_h2c_update_beacon(struct rtw89_dev *rtwdev,
-			       struct rtw89_vif *rtwvif)
+			       struct rtw89_vif_link *rtwvif_link)
 {
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
-						       rtwvif->chanctx_idx);
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+						       rtwvif_link->chanctx_idx);
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
 	struct rtw89_h2c_bcn_upd *h2c;
 	struct sk_buff *skb_beacon;
 	struct ieee80211_hdr *hdr;
@@ -3240,7 +3244,7 @@ int rtw89_fw_h2c_update_beacon(struct rtw89_dev *rtwdev,
 		return -ENOMEM;
 	}
 
-	noa_len = rtw89_p2p_noa_fetch(rtwvif, &noa_data);
+	noa_len = rtw89_p2p_noa_fetch(rtwvif_link, &noa_data);
 	if (noa_len &&
 	    (noa_len <= skb_tailroom(skb_beacon) ||
 	     pskb_expand_head(skb_beacon, 0, noa_len, GFP_KERNEL) == 0)) {
@@ -3260,11 +3264,11 @@ int rtw89_fw_h2c_update_beacon(struct rtw89_dev *rtwdev,
 	skb_put(skb, len);
 	h2c = (struct rtw89_h2c_bcn_upd *)skb->data;
 
-	h2c->w0 = le32_encode_bits(rtwvif->port, RTW89_H2C_BCN_UPD_W0_PORT) |
+	h2c->w0 = le32_encode_bits(rtwvif_link->port, RTW89_H2C_BCN_UPD_W0_PORT) |
 		  le32_encode_bits(0, RTW89_H2C_BCN_UPD_W0_MBSSID) |
-		  le32_encode_bits(rtwvif->mac_idx, RTW89_H2C_BCN_UPD_W0_BAND) |
+		  le32_encode_bits(rtwvif_link->mac_idx, RTW89_H2C_BCN_UPD_W0_BAND) |
 		  le32_encode_bits(tim_offset | BIT(7), RTW89_H2C_BCN_UPD_W0_GRP_IE_OFST);
-	h2c->w1 = le32_encode_bits(rtwvif->mac_id, RTW89_H2C_BCN_UPD_W1_MACID) |
+	h2c->w1 = le32_encode_bits(rtwvif_link->mac_id, RTW89_H2C_BCN_UPD_W1_MACID) |
 		  le32_encode_bits(RTW89_MGMT_HW_SSN_SEL, RTW89_H2C_BCN_UPD_W1_SSN_SEL) |
 		  le32_encode_bits(RTW89_MGMT_HW_SEQ_MODE, RTW89_H2C_BCN_UPD_W1_SSN_MODE) |
 		  le32_encode_bits(beacon_rate, RTW89_H2C_BCN_UPD_W1_RATE);
@@ -3289,10 +3293,10 @@ int rtw89_fw_h2c_update_beacon(struct rtw89_dev *rtwdev,
 EXPORT_SYMBOL(rtw89_fw_h2c_update_beacon);
 
 int rtw89_fw_h2c_update_beacon_be(struct rtw89_dev *rtwdev,
-				  struct rtw89_vif *rtwvif)
+				  struct rtw89_vif_link *rtwvif_link)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, rtwvif->chanctx_idx);
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, rtwvif_link->chanctx_idx);
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
 	struct rtw89_h2c_bcn_upd_be *h2c;
 	struct sk_buff *skb_beacon;
 	struct ieee80211_hdr *hdr;
@@ -3319,7 +3323,7 @@ int rtw89_fw_h2c_update_beacon_be(struct rtw89_dev *rtwdev,
 		return -ENOMEM;
 	}
 
-	noa_len = rtw89_p2p_noa_fetch(rtwvif, &noa_data);
+	noa_len = rtw89_p2p_noa_fetch(rtwvif_link, &noa_data);
 	if (noa_len &&
 	    (noa_len <= skb_tailroom(skb_beacon) ||
 	     pskb_expand_head(skb_beacon, 0, noa_len, GFP_KERNEL) == 0)) {
@@ -3339,11 +3343,11 @@ int rtw89_fw_h2c_update_beacon_be(struct rtw89_dev *rtwdev,
 	skb_put(skb, len);
 	h2c = (struct rtw89_h2c_bcn_upd_be *)skb->data;
 
-	h2c->w0 = le32_encode_bits(rtwvif->port, RTW89_H2C_BCN_UPD_BE_W0_PORT) |
+	h2c->w0 = le32_encode_bits(rtwvif_link->port, RTW89_H2C_BCN_UPD_BE_W0_PORT) |
 		  le32_encode_bits(0, RTW89_H2C_BCN_UPD_BE_W0_MBSSID) |
-		  le32_encode_bits(rtwvif->mac_idx, RTW89_H2C_BCN_UPD_BE_W0_BAND) |
+		  le32_encode_bits(rtwvif_link->mac_idx, RTW89_H2C_BCN_UPD_BE_W0_BAND) |
 		  le32_encode_bits(tim_offset | BIT(7), RTW89_H2C_BCN_UPD_BE_W0_GRP_IE_OFST);
-	h2c->w1 = le32_encode_bits(rtwvif->mac_id, RTW89_H2C_BCN_UPD_BE_W1_MACID) |
+	h2c->w1 = le32_encode_bits(rtwvif_link->mac_id, RTW89_H2C_BCN_UPD_BE_W1_MACID) |
 		  le32_encode_bits(RTW89_MGMT_HW_SSN_SEL, RTW89_H2C_BCN_UPD_BE_W1_SSN_SEL) |
 		  le32_encode_bits(RTW89_MGMT_HW_SEQ_MODE, RTW89_H2C_BCN_UPD_BE_W1_SSN_MODE) |
 		  le32_encode_bits(beacon_rate, RTW89_H2C_BCN_UPD_BE_W1_RATE);
@@ -3373,22 +3377,22 @@ EXPORT_SYMBOL(rtw89_fw_h2c_update_beacon_be);
 
 #define H2C_ROLE_MAINTAIN_LEN 4
 int rtw89_fw_h2c_role_maintain(struct rtw89_dev *rtwdev,
-			       struct rtw89_vif *rtwvif,
+			       struct rtw89_vif_link *rtwvif_link,
 			       struct rtw89_sta *rtwsta,
 			       enum rtw89_upd_mode upd_mode)
 {
 	struct sk_buff *skb;
-	u8 mac_id = rtwsta ? rtwsta->mac_id : rtwvif->mac_id;
+	u8 mac_id = rtwsta ? rtwsta->mac_id : rtwvif_link->mac_id;
 	u8 self_role;
 	int ret;
 
-	if (rtwvif->net_type == RTW89_NET_TYPE_AP_MODE) {
+	if (rtwvif_link->net_type == RTW89_NET_TYPE_AP_MODE) {
 		if (rtwsta)
 			self_role = RTW89_SELF_ROLE_AP_CLIENT;
 		else
-			self_role = rtwvif->self_role;
+			self_role = rtwvif_link->self_role;
 	} else {
-		self_role = rtwvif->self_role;
+		self_role = rtwvif_link->self_role;
 	}
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_ROLE_MAINTAIN_LEN);
@@ -3400,7 +3404,7 @@ int rtw89_fw_h2c_role_maintain(struct rtw89_dev *rtwdev,
 	SET_FWROLE_MAINTAIN_MACID(skb->data, mac_id);
 	SET_FWROLE_MAINTAIN_SELF_ROLE(skb->data, self_role);
 	SET_FWROLE_MAINTAIN_UPD_MODE(skb->data, upd_mode);
-	SET_FWROLE_MAINTAIN_WIFI_ROLE(skb->data, rtwvif->wifi_role);
+	SET_FWROLE_MAINTAIN_WIFI_ROLE(skb->data, rtwvif_link->wifi_role);
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_MAC, H2C_CL_MAC_MEDIA_RPT,
@@ -3421,11 +3425,11 @@ int rtw89_fw_h2c_role_maintain(struct rtw89_dev *rtwdev,
 }
 
 static enum rtw89_fw_sta_type
-rtw89_fw_get_sta_type(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+rtw89_fw_get_sta_type(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
 		      struct rtw89_sta *rtwsta)
 {
 	struct ieee80211_sta *sta = rtwsta_to_sta_safe(rtwsta);
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
 
 	if (!sta)
 		goto by_vif;
@@ -3446,14 +3450,14 @@ rtw89_fw_get_sta_type(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 		return RTW89_FW_N_AC_STA;
 }
 
-int rtw89_fw_h2c_join_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+int rtw89_fw_h2c_join_info(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
 			   struct rtw89_sta *rtwsta, bool dis_conn)
 {
 	struct sk_buff *skb;
-	u8 mac_id = rtwsta ? rtwsta->mac_id : rtwvif->mac_id;
-	u8 self_role = rtwvif->self_role;
+	u8 mac_id = rtwsta ? rtwsta->mac_id : rtwvif_link->mac_id;
+	u8 self_role = rtwvif_link->self_role;
 	enum rtw89_fw_sta_type sta_type;
-	u8 net_type = rtwvif->net_type;
+	u8 net_type = rtwvif_link->net_type;
 	struct rtw89_h2c_join_v1 *h2c_v1;
 	struct rtw89_h2c_join *h2c;
 	u32 len = sizeof(*h2c);
@@ -3480,16 +3484,17 @@ int rtw89_fw_h2c_join_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 
 	h2c->w0 = le32_encode_bits(mac_id, RTW89_H2C_JOININFO_W0_MACID) |
 		  le32_encode_bits(dis_conn, RTW89_H2C_JOININFO_W0_OP) |
-		  le32_encode_bits(rtwvif->mac_idx, RTW89_H2C_JOININFO_W0_BAND) |
-		  le32_encode_bits(rtwvif->wmm, RTW89_H2C_JOININFO_W0_WMM) |
-		  le32_encode_bits(rtwvif->trigger, RTW89_H2C_JOININFO_W0_TGR) |
+		  le32_encode_bits(rtwvif_link->mac_idx, RTW89_H2C_JOININFO_W0_BAND) |
+		  le32_encode_bits(rtwvif_link->wmm, RTW89_H2C_JOININFO_W0_WMM) |
+		  le32_encode_bits(rtwvif_link->trigger, RTW89_H2C_JOININFO_W0_TGR) |
 		  le32_encode_bits(0, RTW89_H2C_JOININFO_W0_ISHESTA) |
 		  le32_encode_bits(0, RTW89_H2C_JOININFO_W0_DLBW) |
 		  le32_encode_bits(0, RTW89_H2C_JOININFO_W0_TF_MAC_PAD) |
 		  le32_encode_bits(0, RTW89_H2C_JOININFO_W0_DL_T_PE) |
-		  le32_encode_bits(rtwvif->port, RTW89_H2C_JOININFO_W0_PORT_ID) |
+		  le32_encode_bits(rtwvif_link->port, RTW89_H2C_JOININFO_W0_PORT_ID) |
 		  le32_encode_bits(net_type, RTW89_H2C_JOININFO_W0_NET_TYPE) |
-		  le32_encode_bits(rtwvif->wifi_role, RTW89_H2C_JOININFO_W0_WIFI_ROLE) |
+		  le32_encode_bits(rtwvif_link->wifi_role,
+				   RTW89_H2C_JOININFO_W0_WIFI_ROLE) |
 		  le32_encode_bits(self_role, RTW89_H2C_JOININFO_W0_SELF_ROLE);
 
 	if (!format_v1)
@@ -3497,7 +3502,7 @@ int rtw89_fw_h2c_join_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 
 	h2c_v1 = (struct rtw89_h2c_join_v1 *)skb->data;
 
-	sta_type = rtw89_fw_get_sta_type(rtwdev, rtwvif, rtwsta);
+	sta_type = rtw89_fw_get_sta_type(rtwdev, rtwvif_link, rtwsta);
 
 	h2c_v1->w1 = le32_encode_bits(sta_type, RTW89_H2C_JOININFO_W1_STA_TYPE);
 	h2c_v1->w2 = 0;
@@ -3618,7 +3623,7 @@ int rtw89_fw_h2c_macid_pause(struct rtw89_dev *rtwdev, u8 sh, u8 grp,
 }
 
 #define H2C_EDCA_LEN 12
-int rtw89_fw_h2c_set_edca(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+int rtw89_fw_h2c_set_edca(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
 			  u8 ac, u32 val)
 {
 	struct sk_buff *skb;
@@ -3631,7 +3636,7 @@ int rtw89_fw_h2c_set_edca(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 	}
 	skb_put(skb, H2C_EDCA_LEN);
 	RTW89_SET_EDCA_SEL(skb->data, 0);
-	RTW89_SET_EDCA_BAND(skb->data, rtwvif->mac_idx);
+	RTW89_SET_EDCA_BAND(skb->data, rtwvif_link->mac_idx);
 	RTW89_SET_EDCA_WMM(skb->data, 0);
 	RTW89_SET_EDCA_AC(skb->data, ac);
 	RTW89_SET_EDCA_PARAM(skb->data, val);
@@ -3655,7 +3660,8 @@ int rtw89_fw_h2c_set_edca(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 }
 
 #define H2C_TSF32_TOGL_LEN 4
-int rtw89_fw_h2c_tsf32_toggle(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+int rtw89_fw_h2c_tsf32_toggle(struct rtw89_dev *rtwdev,
+			      struct rtw89_vif_link *rtwvif_link,
 			      bool en)
 {
 	struct sk_buff *skb;
@@ -3671,9 +3677,9 @@ int rtw89_fw_h2c_tsf32_toggle(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif
 	skb_put(skb, H2C_TSF32_TOGL_LEN);
 	cmd = skb->data;
 
-	RTW89_SET_FWCMD_TSF32_TOGL_BAND(cmd, rtwvif->mac_idx);
+	RTW89_SET_FWCMD_TSF32_TOGL_BAND(cmd, rtwvif_link->mac_idx);
 	RTW89_SET_FWCMD_TSF32_TOGL_EN(cmd, en);
-	RTW89_SET_FWCMD_TSF32_TOGL_PORT(cmd, rtwvif->port);
+	RTW89_SET_FWCMD_TSF32_TOGL_PORT(cmd, rtwvif_link->port);
 	RTW89_SET_FWCMD_TSF32_TOGL_EARLY(cmd, early_us);
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
@@ -3730,7 +3736,7 @@ int rtw89_fw_h2c_set_bcn_fltr_cfg(struct rtw89_dev *rtwdev,
 				  struct ieee80211_vif *vif,
 				  bool connect)
 {
-	struct rtw89_vif *rtwvif = vif_to_rtwvif_safe(vif);
+	struct rtw89_vif_link *rtwvif_link = vif_to_rtwvif_safe(vif);
 	struct ieee80211_bss_conf *bss_conf = vif ? &vif->bss_conf : NULL;
 	s32 thold = RTW89_DEFAULT_CQM_THOLD;
 	u32 hyst = RTW89_DEFAULT_CQM_HYST;
@@ -3742,7 +3748,7 @@ int rtw89_fw_h2c_set_bcn_fltr_cfg(struct rtw89_dev *rtwdev,
 	if (!RTW89_CHK_FW_FEATURE(BEACON_FILTER, &rtwdev->fw))
 		return -EINVAL;
 
-	if (!rtwvif || !bss_conf || rtwvif->net_type != RTW89_NET_TYPE_INFRA)
+	if (!rtwvif_link || !bss_conf || rtwvif_link->net_type != RTW89_NET_TYPE_INFRA)
 		return -EINVAL;
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
@@ -3768,7 +3774,7 @@ int rtw89_fw_h2c_set_bcn_fltr_cfg(struct rtw89_dev *rtwdev,
 		  le32_encode_bits(hyst, RTW89_H2C_BCNFLTR_W0_RSSI_HYST) |
 		  le32_encode_bits(thold + MAX_RSSI,
 				   RTW89_H2C_BCNFLTR_W0_RSSI_THRESHOLD) |
-		  le32_encode_bits(rtwvif->mac_id, RTW89_H2C_BCNFLTR_W0_MAC_ID);
+		  le32_encode_bits(rtwvif_link->mac_id, RTW89_H2C_BCNFLTR_W0_MAC_ID);
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_MAC, H2C_CL_MAC_FW_OFLD,
@@ -3833,15 +3839,15 @@ int rtw89_fw_h2c_rssi_offload(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
-int rtw89_fw_h2c_tp_offload(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+int rtw89_fw_h2c_tp_offload(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link)
 {
-	struct rtw89_traffic_stats *stats = &rtwvif->stats;
+	struct rtw89_traffic_stats *stats = &rtwvif_link->stats;
 	struct rtw89_h2c_ofld *h2c;
 	u32 len = sizeof(*h2c);
 	struct sk_buff *skb;
 	int ret;
 
-	if (rtwvif->net_type != RTW89_NET_TYPE_INFRA)
+	if (rtwvif_link->net_type != RTW89_NET_TYPE_INFRA)
 		return -EINVAL;
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
@@ -3853,7 +3859,7 @@ int rtw89_fw_h2c_tp_offload(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	skb_put(skb, len);
 	h2c = (struct rtw89_h2c_ofld *)skb->data;
 
-	h2c->w0 = le32_encode_bits(rtwvif->mac_id, RTW89_H2C_OFLD_W0_MAC_ID) |
+	h2c->w0 = le32_encode_bits(rtwvif_link->mac_id, RTW89_H2C_OFLD_W0_MAC_ID) |
 		  le32_encode_bits(stats->tx_throughput, RTW89_H2C_OFLD_W0_TX_TP) |
 		  le32_encode_bits(stats->rx_throughput, RTW89_H2C_OFLD_W0_RX_TP);
 
@@ -4858,7 +4864,7 @@ int rtw89_fw_h2c_scan_list_offload_be(struct rtw89_dev *rtwdev, int ch_num,
 #define RTW89_SCAN_DELAY_TSF_UNIT 104800
 int rtw89_fw_h2c_scan_offload_ax(struct rtw89_dev *rtwdev,
 				 struct rtw89_scan_option *option,
-				 struct rtw89_vif *rtwvif,
+				 struct rtw89_vif_link *rtwvif_link,
 				 bool wowlan)
 {
 	struct rtw89_wait_info *wait = &rtwdev->mac.fw_ofld_wait;
@@ -4880,7 +4886,7 @@ int rtw89_fw_h2c_scan_offload_ax(struct rtw89_dev *rtwdev,
 	h2c = (struct rtw89_h2c_scanofld *)skb->data;
 
 	if (option->delay) {
-		ret = rtw89_mac_port_get_tsf(rtwdev, rtwvif, &tsf);
+		ret = rtw89_mac_port_get_tsf(rtwdev, rtwvif_link, &tsf);
 		if (ret) {
 			rtw89_warn(rtwdev, "NLO failed to get port tsf: %d\n", ret);
 			scan_mode = RTW89_SCAN_IMMEDIATE;
@@ -4890,8 +4896,8 @@ int rtw89_fw_h2c_scan_offload_ax(struct rtw89_dev *rtwdev,
 		}
 	}
 
-	h2c->w0 = le32_encode_bits(rtwvif->mac_id, RTW89_H2C_SCANOFLD_W0_MACID) |
-		  le32_encode_bits(rtwvif->port, RTW89_H2C_SCANOFLD_W0_PORT_ID) |
+	h2c->w0 = le32_encode_bits(rtwvif_link->mac_id, RTW89_H2C_SCANOFLD_W0_MACID) |
+		  le32_encode_bits(rtwvif_link->port, RTW89_H2C_SCANOFLD_W0_PORT_ID) |
 		  le32_encode_bits(RTW89_PHY_0, RTW89_H2C_SCANOFLD_W0_BAND) |
 		  le32_encode_bits(option->enable, RTW89_H2C_SCANOFLD_W0_OPERATION);
 
@@ -4963,12 +4969,12 @@ static void rtw89_scan_get_6g_disabled_chan(struct rtw89_dev *rtwdev,
 
 int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev *rtwdev,
 				 struct rtw89_scan_option *option,
-				 struct rtw89_vif *rtwvif,
+				 struct rtw89_vif_link *rtwvif_link,
 				 bool wowlan)
 {
 	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
 	struct rtw89_wait_info *wait = &rtwdev->mac.fw_ofld_wait;
-	struct cfg80211_scan_request *req = rtwvif->scan_req;
+	struct cfg80211_scan_request *req = rtwvif_link->scan_req;
 	struct rtw89_h2c_scanofld_be_macc_role *macc_role;
 	struct rtw89_chan *op = &scan_info->op_chan;
 	struct rtw89_h2c_scanofld_be_opch *opch;
@@ -5016,8 +5022,8 @@ int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev *rtwdev,
 		  le32_encode_bits(option->repeat, RTW89_H2C_SCANOFLD_BE_W0_REPEAT) |
 		  le32_encode_bits(true, RTW89_H2C_SCANOFLD_BE_W0_NOTIFY_END) |
 		  le32_encode_bits(true, RTW89_H2C_SCANOFLD_BE_W0_LEARN_CH) |
-		  le32_encode_bits(rtwvif->mac_id, RTW89_H2C_SCANOFLD_BE_W0_MACID) |
-		  le32_encode_bits(rtwvif->port, RTW89_H2C_SCANOFLD_BE_W0_PORT) |
+		  le32_encode_bits(rtwvif_link->mac_id, RTW89_H2C_SCANOFLD_BE_W0_MACID) |
+		  le32_encode_bits(rtwvif_link->port, RTW89_H2C_SCANOFLD_BE_W0_PORT) |
 		  le32_encode_bits(option->band, RTW89_H2C_SCANOFLD_BE_W0_BAND);
 
 	h2c->w1 = le32_encode_bits(option->num_macc_role, RTW89_H2C_SCANOFLD_BE_W1_NUM_MACC_ROLE) |
@@ -5082,11 +5088,11 @@ int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev *rtwdev,
 
 	for (i = 0; i < option->num_opch; i++) {
 		opch = ptr;
-		opch->w0 = le32_encode_bits(rtwvif->mac_id,
+		opch->w0 = le32_encode_bits(rtwvif_link->mac_id,
 					    RTW89_H2C_SCANOFLD_BE_OPCH_W0_MACID) |
 			   le32_encode_bits(option->band,
 					    RTW89_H2C_SCANOFLD_BE_OPCH_W0_BAND) |
-			   le32_encode_bits(rtwvif->port,
+			   le32_encode_bits(rtwvif_link->port,
 					    RTW89_H2C_SCANOFLD_BE_OPCH_W0_PORT) |
 			   le32_encode_bits(RTW89_SCAN_OPMODE_INTV,
 					    RTW89_H2C_SCANOFLD_BE_OPCH_W0_POLICY) |
@@ -5871,11 +5877,11 @@ static void rtw89_release_pkt_list(struct rtw89_dev *rtwdev)
 }
 
 static bool rtw89_is_6ghz_wildcard_probe_req(struct rtw89_dev *rtwdev,
-					     struct rtw89_vif *rtwvif,
+					     struct rtw89_vif_link *rtwvif_link,
 					     struct rtw89_pktofld_info *info,
 					     enum nl80211_band band, u8 ssid_idx)
 {
-	struct cfg80211_scan_request *req = rtwvif->scan_req;
+	struct cfg80211_scan_request *req = rtwvif_link->scan_req;
 
 	if (band != NL80211_BAND_6GHZ)
 		return false;
@@ -5892,11 +5898,11 @@ static bool rtw89_is_6ghz_wildcard_probe_req(struct rtw89_dev *rtwdev,
 }
 
 static int rtw89_append_probe_req_ie(struct rtw89_dev *rtwdev,
-				     struct rtw89_vif *rtwvif,
+				     struct rtw89_vif_link *rtwvif_link,
 				     struct sk_buff *skb, u8 ssid_idx)
 {
 	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
-	struct ieee80211_scan_ies *ies = rtwvif->scan_ies;
+	struct ieee80211_scan_ies *ies = rtwvif_link->scan_ies;
 	struct rtw89_pktofld_info *info;
 	struct sk_buff *new;
 	int ret = 0;
@@ -5921,7 +5927,7 @@ static int rtw89_append_probe_req_ie(struct rtw89_dev *rtwdev,
 			goto out;
 		}
 
-		rtw89_is_6ghz_wildcard_probe_req(rtwdev, rtwvif, info, band,
+		rtw89_is_6ghz_wildcard_probe_req(rtwdev, rtwvif_link, info, band,
 						 ssid_idx);
 
 		ret = rtw89_fw_h2c_add_pkt_offload(rtwdev, &info->id, new);
@@ -5939,22 +5945,22 @@ static int rtw89_append_probe_req_ie(struct rtw89_dev *rtwdev,
 }
 
 static int rtw89_hw_scan_update_probe_req(struct rtw89_dev *rtwdev,
-					  struct rtw89_vif *rtwvif)
+					  struct rtw89_vif_link *rtwvif_link)
 {
-	struct cfg80211_scan_request *req = rtwvif->scan_req;
+	struct cfg80211_scan_request *req = rtwvif_link->scan_req;
 	struct sk_buff *skb;
 	u8 num = req->n_ssids, i;
 	int ret;
 
 	for (i = 0; i < num; i++) {
-		skb = ieee80211_probereq_get(rtwdev->hw, rtwvif->mac_addr,
+		skb = ieee80211_probereq_get(rtwdev->hw, rtwvif_link->mac_addr,
 					     req->ssids[i].ssid,
 					     req->ssids[i].ssid_len,
 					     req->ie_len);
 		if (!skb)
 			return -ENOMEM;
 
-		ret = rtw89_append_probe_req_ie(rtwdev, rtwvif, skb, i);
+		ret = rtw89_append_probe_req_ie(rtwdev, rtwvif_link, skb, i);
 		kfree_skb(skb);
 
 		if (ret)
@@ -5970,8 +5976,8 @@ static int rtw89_update_6ghz_rnr_chan(struct rtw89_dev *rtwdev,
 {
 	struct ieee80211_vif *vif = rtwdev->scan_info.scanning_vif;
 	struct list_head *pkt_list = rtwdev->scan_info.pkt_list;
-	struct rtw89_vif *rtwvif = vif_to_rtwvif_safe(vif);
-	struct ieee80211_scan_ies *ies = rtwvif->scan_ies;
+	struct rtw89_vif_link *rtwvif_link = vif_to_rtwvif_safe(vif);
+	struct ieee80211_scan_ies *ies = rtwvif_link->scan_ies;
 	struct cfg80211_scan_6ghz_params *params;
 	struct rtw89_pktofld_info *info, *tmp;
 	struct ieee80211_hdr *hdr;
@@ -6000,7 +6006,7 @@ static int rtw89_update_6ghz_rnr_chan(struct rtw89_dev *rtwdev,
 		if (found)
 			continue;
 
-		skb = ieee80211_probereq_get(rtwdev->hw, rtwvif->mac_addr,
+		skb = ieee80211_probereq_get(rtwdev->hw, rtwvif_link->mac_addr,
 					     NULL, 0, req->ie_len);
 		skb_put_data(skb, ies->ies[NL80211_BAND_6GHZ], ies->len[NL80211_BAND_6GHZ]);
 		skb_put_data(skb, ies->common_ies, ies->common_ie_len);
@@ -6091,8 +6097,8 @@ static void rtw89_hw_scan_add_chan(struct rtw89_dev *rtwdev, int chan_type,
 {
 	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
 	struct ieee80211_vif *vif = rtwdev->scan_info.scanning_vif;
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
-	struct cfg80211_scan_request *req = rtwvif->scan_req;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
+	struct cfg80211_scan_request *req = rtwvif_link->scan_req;
 	struct rtw89_chan *op = &rtwdev->scan_info.op_chan;
 	struct rtw89_pktofld_info *info;
 	u8 band, probe_count = 0;
@@ -6208,8 +6214,8 @@ static void rtw89_hw_scan_add_chan_be(struct rtw89_dev *rtwdev, int chan_type,
 {
 	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
 	struct ieee80211_vif *vif = rtwdev->scan_info.scanning_vif;
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
-	struct cfg80211_scan_request *req = rtwvif->scan_req;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
+	struct cfg80211_scan_request *req = rtwvif_link->scan_req;
 	struct rtw89_pktofld_info *info;
 	u8 band, probe_count = 0, i;
 
@@ -6265,7 +6271,7 @@ static void rtw89_hw_scan_add_chan_be(struct rtw89_dev *rtwdev, int chan_type,
 }
 
 int rtw89_pno_scan_add_chan_list_ax(struct rtw89_dev *rtwdev,
-				    struct rtw89_vif *rtwvif)
+				    struct rtw89_vif_link *rtwvif_link)
 {
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
 	struct cfg80211_sched_scan_request *nd_config = rtw_wow->nd_config;
@@ -6315,9 +6321,9 @@ int rtw89_pno_scan_add_chan_list_ax(struct rtw89_dev *rtwdev,
 }
 
 int rtw89_hw_scan_add_chan_list_ax(struct rtw89_dev *rtwdev,
-				   struct rtw89_vif *rtwvif, bool connected)
+				   struct rtw89_vif_link *rtwvif_link, bool connected)
 {
-	struct cfg80211_scan_request *req = rtwvif->scan_req;
+	struct cfg80211_scan_request *req = rtwvif_link->scan_req;
 	struct rtw89_mac_chinfo	*ch_info, *tmp;
 	struct ieee80211_channel *channel;
 	struct list_head chan_list;
@@ -6392,7 +6398,7 @@ int rtw89_hw_scan_add_chan_list_ax(struct rtw89_dev *rtwdev,
 }
 
 int rtw89_pno_scan_add_chan_list_be(struct rtw89_dev *rtwdev,
-				    struct rtw89_vif *rtwvif)
+				    struct rtw89_vif_link *rtwvif_link)
 {
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
 	struct cfg80211_sched_scan_request *nd_config = rtw_wow->nd_config;
@@ -6444,9 +6450,9 @@ int rtw89_pno_scan_add_chan_list_be(struct rtw89_dev *rtwdev,
 }
 
 int rtw89_hw_scan_add_chan_list_be(struct rtw89_dev *rtwdev,
-				   struct rtw89_vif *rtwvif, bool connected)
+				   struct rtw89_vif_link *rtwvif_link, bool connected)
 {
-	struct cfg80211_scan_request *req = rtwvif->scan_req;
+	struct cfg80211_scan_request *req = rtwvif_link->scan_req;
 	struct rtw89_mac_chinfo_be *ch_info, *tmp;
 	struct ieee80211_channel *channel;
 	struct list_head chan_list;
@@ -6503,17 +6509,17 @@ int rtw89_hw_scan_add_chan_list_be(struct rtw89_dev *rtwdev,
 }
 
 static int rtw89_hw_scan_prehandle(struct rtw89_dev *rtwdev,
-				   struct rtw89_vif *rtwvif, bool connected)
+				   struct rtw89_vif_link *rtwvif_link, bool connected)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	int ret;
 
-	ret = rtw89_hw_scan_update_probe_req(rtwdev, rtwvif);
+	ret = rtw89_hw_scan_update_probe_req(rtwdev, rtwvif_link);
 	if (ret) {
 		rtw89_err(rtwdev, "Update probe request failed\n");
 		goto out;
 	}
-	ret = mac->add_chan_list(rtwdev, rtwvif, connected);
+	ret = mac->add_chan_list(rtwdev, rtwvif_link, connected);
 out:
 	return ret;
 }
@@ -6521,27 +6527,27 @@ static int rtw89_hw_scan_prehandle(struct rtw89_dev *rtwdev,
 void rtw89_hw_scan_start(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 			 struct ieee80211_scan_request *scan_req)
 {
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	struct cfg80211_scan_request *req = &scan_req->req;
 	u32 rx_fltr = rtwdev->hal.rx_fltr;
 	u8 mac_addr[ETH_ALEN];
 
-	rtw89_get_channel(rtwdev, rtwvif, &rtwdev->scan_info.op_chan);
+	rtw89_get_channel(rtwdev, rtwvif_link, &rtwdev->scan_info.op_chan);
 	rtwdev->scan_info.scanning_vif = vif;
 	rtwdev->scan_info.last_chan_idx = 0;
 	rtwdev->scan_info.abort = false;
-	rtwvif->scan_ies = &scan_req->ies;
-	rtwvif->scan_req = req;
+	rtwvif_link->scan_ies = &scan_req->ies;
+	rtwvif_link->scan_req = req;
 	ieee80211_stop_queues(rtwdev->hw);
-	rtw89_mac_port_cfg_rx_sync(rtwdev, rtwvif, false);
+	rtw89_mac_port_cfg_rx_sync(rtwdev, rtwvif_link, false);
 
 	if (req->flags & NL80211_SCAN_FLAG_RANDOM_ADDR)
 		get_random_mask_addr(mac_addr, req->mac_addr,
 				     req->mac_addr_mask);
 	else
 		ether_addr_copy(mac_addr, vif->addr);
-	rtw89_core_scan_start(rtwdev, rtwvif, mac_addr, true);
+	rtw89_core_scan_start(rtwdev, rtwvif_link, mac_addr, true);
 
 	rx_fltr &= ~B_AX_A_BCN_CHK_EN;
 	rx_fltr &= ~B_AX_A_BC;
@@ -6559,7 +6565,7 @@ void rtw89_hw_scan_complete(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
-	struct rtw89_vif *rtwvif = vif_to_rtwvif_safe(vif);
+	struct rtw89_vif_link *rtwvif_link = vif_to_rtwvif_safe(vif);
 	struct cfg80211_scan_info info = {
 		.aborted = aborted,
 	};
@@ -6575,12 +6581,12 @@ void rtw89_hw_scan_complete(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 	rtw89_core_scan_complete(rtwdev, vif, true);
 	ieee80211_scan_completed(rtwdev->hw, &info);
 	ieee80211_wake_queues(rtwdev->hw);
-	rtw89_mac_port_cfg_rx_sync(rtwdev, rtwvif, true);
+	rtw89_mac_port_cfg_rx_sync(rtwdev, rtwvif_link, true);
 	rtw89_mac_enable_beacon_for_ap_vifs(rtwdev, true);
 
 	rtw89_release_pkt_list(rtwdev);
-	rtwvif->scan_req = NULL;
-	rtwvif->scan_ies = NULL;
+	rtwvif_link->scan_req = NULL;
+	rtwvif_link->scan_ies = NULL;
 	scan_info->last_chan_idx = 0;
 	scan_info->scanning_vif = NULL;
 	scan_info->abort = false;
@@ -6609,11 +6615,11 @@ void rtw89_hw_scan_abort(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif)
 
 static bool rtw89_is_any_vif_connected_or_connecting(struct rtw89_dev *rtwdev)
 {
-	struct rtw89_vif *rtwvif;
+	struct rtw89_vif_link *rtwvif_link;
 
-	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
+	rtw89_for_each_rtwvif(rtwdev, rtwvif_link) {
 		/* This variable implies connected or during attempt to connect */
-		if (!is_zero_ether_addr(rtwvif->bssid))
+		if (!is_zero_ether_addr(rtwvif_link->bssid))
 			return true;
 	}
 
@@ -6625,19 +6631,19 @@ int rtw89_hw_scan_offload(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	struct rtw89_scan_option opt = {0};
-	struct rtw89_vif *rtwvif;
+	struct rtw89_vif_link *rtwvif_link;
 	bool connected;
 	int ret = 0;
 
-	rtwvif = vif ? (struct rtw89_vif *)vif->drv_priv : NULL;
-	if (!rtwvif)
+	rtwvif_link = vif ? (struct rtw89_vif_link *)vif->drv_priv : NULL;
+	if (!rtwvif_link)
 		return -EINVAL;
 
 	connected = rtw89_is_any_vif_connected_or_connecting(rtwdev);
 	opt.enable = enable;
 	opt.target_ch_mode = connected;
 	if (enable) {
-		ret = rtw89_hw_scan_prehandle(rtwdev, rtwvif, connected);
+		ret = rtw89_hw_scan_prehandle(rtwdev, rtwvif_link, connected);
 		if (ret)
 			goto out;
 	}
@@ -6652,7 +6658,7 @@ int rtw89_hw_scan_offload(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 		opt.opch_end = connected ? 0 : RTW89_CHAN_INVALID;
 	}
 
-	ret = mac->scan_offload(rtwdev, &opt, rtwvif, false);
+	ret = mac->scan_offload(rtwdev, &opt, rtwvif_link, false);
 out:
 	return ret;
 }
@@ -6758,7 +6764,7 @@ int rtw89_fw_h2c_pkt_drop(struct rtw89_dev *rtwdev,
 }
 
 #define H2C_KEEP_ALIVE_LEN 4
-int rtw89_fw_h2c_keep_alive(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+int rtw89_fw_h2c_keep_alive(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
 			    bool enable)
 {
 	struct sk_buff *skb;
@@ -6766,7 +6772,7 @@ int rtw89_fw_h2c_keep_alive(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 	int ret;
 
 	if (enable) {
-		ret = rtw89_fw_h2c_add_general_pkt(rtwdev, rtwvif,
+		ret = rtw89_fw_h2c_add_general_pkt(rtwdev, rtwvif_link,
 						   RTW89_PKT_OFLD_TYPE_NULL_DATA,
 						   &pkt_id);
 		if (ret)
@@ -6784,7 +6790,7 @@ int rtw89_fw_h2c_keep_alive(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 	RTW89_SET_KEEP_ALIVE_ENABLE(skb->data, enable);
 	RTW89_SET_KEEP_ALIVE_PKT_NULL_ID(skb->data, pkt_id);
 	RTW89_SET_KEEP_ALIVE_PERIOD(skb->data, 5);
-	RTW89_SET_KEEP_ALIVE_MACID(skb->data, rtwvif->mac_id);
+	RTW89_SET_KEEP_ALIVE_MACID(skb->data, rtwvif_link->mac_id);
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_MAC,
@@ -6806,7 +6812,7 @@ int rtw89_fw_h2c_keep_alive(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 	return ret;
 }
 
-int rtw89_fw_h2c_arp_offload(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+int rtw89_fw_h2c_arp_offload(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
 			     bool enable)
 {
 	struct rtw89_h2c_arp_offload *h2c;
@@ -6816,7 +6822,7 @@ int rtw89_fw_h2c_arp_offload(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 	int ret;
 
 	if (enable) {
-		ret = rtw89_fw_h2c_add_general_pkt(rtwdev, rtwvif,
+		ret = rtw89_fw_h2c_add_general_pkt(rtwdev, rtwvif_link,
 						   RTW89_PKT_OFLD_TYPE_ARP_RSP,
 						   &pkt_id);
 		if (ret)
@@ -6834,7 +6840,7 @@ int rtw89_fw_h2c_arp_offload(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 
 	h2c->w0 = le32_encode_bits(enable, RTW89_H2C_ARP_OFFLOAD_W0_ENABLE) |
 		  le32_encode_bits(0, RTW89_H2C_ARP_OFFLOAD_W0_ACTION) |
-		  le32_encode_bits(rtwvif->mac_id, RTW89_H2C_ARP_OFFLOAD_W0_MACID) |
+		  le32_encode_bits(rtwvif_link->mac_id, RTW89_H2C_ARP_OFFLOAD_W0_MACID) |
 		  le32_encode_bits(pkt_id, RTW89_H2C_ARP_OFFLOAD_W0_PKT_ID);
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
@@ -6859,11 +6865,11 @@ int rtw89_fw_h2c_arp_offload(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 
 #define H2C_DISCONNECT_DETECT_LEN 8
 int rtw89_fw_h2c_disconnect_detect(struct rtw89_dev *rtwdev,
-				   struct rtw89_vif *rtwvif, bool enable)
+				   struct rtw89_vif_link *rtwvif_link, bool enable)
 {
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
 	struct sk_buff *skb;
-	u8 macid = rtwvif->mac_id;
+	u8 macid = rtwvif_link->mac_id;
 	int ret;
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_DISCONNECT_DETECT_LEN);
@@ -6902,7 +6908,7 @@ int rtw89_fw_h2c_disconnect_detect(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
-int rtw89_fw_h2c_cfg_pno(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+int rtw89_fw_h2c_cfg_pno(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
 			 bool enable)
 {
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
@@ -6923,7 +6929,7 @@ int rtw89_fw_h2c_cfg_pno(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 
 	h2c->w0 = le32_encode_bits(enable, RTW89_H2C_NLO_W0_ENABLE) |
 		  le32_encode_bits(enable, RTW89_H2C_NLO_W0_IGNORE_CIPHER) |
-		  le32_encode_bits(rtwvif->mac_id, RTW89_H2C_NLO_W0_MACID);
+		  le32_encode_bits(rtwvif_link->mac_id, RTW89_H2C_NLO_W0_MACID);
 
 	if (enable) {
 		h2c->nlo_cnt = nd_config->n_match_sets;
@@ -6953,12 +6959,12 @@ int rtw89_fw_h2c_cfg_pno(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 	return ret;
 }
 
-int rtw89_fw_h2c_wow_global(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+int rtw89_fw_h2c_wow_global(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
 			    bool enable)
 {
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
 	struct rtw89_h2c_wow_global *h2c;
-	u8 macid = rtwvif->mac_id;
+	u8 macid = rtwvif_link->mac_id;
 	u32 len = sizeof(*h2c);
 	struct sk_buff *skb;
 	int ret;
@@ -7002,12 +7008,12 @@ int rtw89_fw_h2c_wow_global(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 
 #define H2C_WAKEUP_CTRL_LEN 4
 int rtw89_fw_h2c_wow_wakeup_ctrl(struct rtw89_dev *rtwdev,
-				 struct rtw89_vif *rtwvif,
+				 struct rtw89_vif_link *rtwvif_link,
 				 bool enable)
 {
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
 	struct sk_buff *skb;
-	u8 macid = rtwvif->mac_id;
+	u8 macid = rtwvif_link->mac_id;
 	int ret;
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_WAKEUP_CTRL_LEN);
@@ -7100,13 +7106,13 @@ int rtw89_fw_wow_cam_update(struct rtw89_dev *rtwdev,
 }
 
 int rtw89_fw_h2c_wow_gtk_ofld(struct rtw89_dev *rtwdev,
-			      struct rtw89_vif *rtwvif,
+			      struct rtw89_vif_link *rtwvif_link,
 			      bool enable)
 {
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
 	struct rtw89_wow_gtk_info *gtk_info = &rtw_wow->gtk_info;
 	struct rtw89_h2c_wow_gtk_ofld *h2c;
-	u8 macid = rtwvif->mac_id;
+	u8 macid = rtwvif_link->mac_id;
 	u32 len = sizeof(*h2c);
 	u8 pkt_id_sa_query = 0;
 	struct sk_buff *skb;
@@ -7128,14 +7134,14 @@ int rtw89_fw_h2c_wow_gtk_ofld(struct rtw89_dev *rtwdev,
 	if (!enable)
 		goto hdr;
 
-	ret = rtw89_fw_h2c_add_general_pkt(rtwdev, rtwvif,
+	ret = rtw89_fw_h2c_add_general_pkt(rtwdev, rtwvif_link,
 					   RTW89_PKT_OFLD_TYPE_EAPOL_KEY,
 					   &pkt_id_eapol);
 	if (ret)
 		goto fail;
 
 	if (gtk_info->igtk_keyid) {
-		ret = rtw89_fw_h2c_add_general_pkt(rtwdev, rtwvif,
+		ret = rtw89_fw_h2c_add_general_pkt(rtwdev, rtwvif_link,
 						   RTW89_PKT_OFLD_TYPE_SA_QUERY,
 						   &pkt_id_sa_query);
 		if (ret)
@@ -7173,7 +7179,7 @@ int rtw89_fw_h2c_wow_gtk_ofld(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
-int rtw89_fw_h2c_fwips(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+int rtw89_fw_h2c_fwips(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
 		       bool enable)
 {
 	struct rtw89_wait_info *wait = &rtwdev->mac.ps_wait;
@@ -7189,7 +7195,7 @@ int rtw89_fw_h2c_fwips(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 	skb_put(skb, len);
 	h2c = (struct rtw89_h2c_fwips *)skb->data;
 
-	h2c->w0 = le32_encode_bits(rtwvif->mac_id, RTW89_H2C_FW_IPS_W0_MACID) |
+	h2c->w0 = le32_encode_bits(rtwvif_link->mac_id, RTW89_H2C_FW_IPS_W0_MACID) |
 		  le32_encode_bits(enable, RTW89_H2C_FW_IPS_W0_ENABLE);
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index ad47e77d740b..4e2f7a478d75 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -4404,13 +4404,13 @@ void rtw89_h2c_pkt_set_hdr(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 			   u8 type, u8 cat, u8 class, u8 func,
 			   bool rack, bool dack, u32 len);
 int rtw89_fw_h2c_default_cmac_tbl(struct rtw89_dev *rtwdev,
-				  struct rtw89_vif *rtwvif,
+				  struct rtw89_vif_link *rtwvif_link,
 				  struct rtw89_sta *rtwsta);
 int rtw89_fw_h2c_default_cmac_tbl_g7(struct rtw89_dev *rtwdev,
-				     struct rtw89_vif *rtwvif,
+				     struct rtw89_vif_link *rtwvif_link,
 				     struct rtw89_sta *rtwsta);
 int rtw89_fw_h2c_default_dmac_tbl_v2(struct rtw89_dev *rtwdev,
-				     struct rtw89_vif *rtwvif,
+				     struct rtw89_vif_link *rtwvif_link,
 				     struct rtw89_sta *rtwsta);
 int rtw89_fw_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
 				struct ieee80211_vif *vif,
@@ -4426,29 +4426,29 @@ int rtw89_fw_h2c_txtime_cmac_tbl(struct rtw89_dev *rtwdev,
 int rtw89_fw_h2c_txpath_cmac_tbl(struct rtw89_dev *rtwdev,
 				 struct rtw89_sta *rtwsta);
 int rtw89_fw_h2c_update_beacon(struct rtw89_dev *rtwdev,
-			       struct rtw89_vif *rtwvif);
+			       struct rtw89_vif_link *rtwvif_link);
 int rtw89_fw_h2c_update_beacon_be(struct rtw89_dev *rtwdev,
-				  struct rtw89_vif *rtwvif);
-int rtw89_fw_h2c_cam(struct rtw89_dev *rtwdev, struct rtw89_vif *vif,
+				  struct rtw89_vif_link *rtwvif_link);
+int rtw89_fw_h2c_cam(struct rtw89_dev *rtwdev, struct rtw89_vif_link *vif,
 		     struct rtw89_sta *rtwsta, const u8 *scan_mac_addr);
 int rtw89_fw_h2c_dctl_sec_cam_v1(struct rtw89_dev *rtwdev,
-				 struct rtw89_vif *rtwvif,
+				 struct rtw89_vif_link *rtwvif_link,
 				 struct rtw89_sta *rtwsta);
 int rtw89_fw_h2c_dctl_sec_cam_v2(struct rtw89_dev *rtwdev,
-				 struct rtw89_vif *rtwvif,
+				 struct rtw89_vif_link *rtwvif_link,
 				 struct rtw89_sta *rtwsta);
 void rtw89_fw_c2h_irqsafe(struct rtw89_dev *rtwdev, struct sk_buff *c2h);
 void rtw89_fw_c2h_work(struct work_struct *work);
 int rtw89_fw_h2c_role_maintain(struct rtw89_dev *rtwdev,
-			       struct rtw89_vif *rtwvif,
+			       struct rtw89_vif_link *rtwvif_link,
 			       struct rtw89_sta *rtwsta,
 			       enum rtw89_upd_mode upd_mode);
-int rtw89_fw_h2c_join_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+int rtw89_fw_h2c_join_info(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
 			   struct rtw89_sta *rtwsta, bool dis_conn);
 int rtw89_fw_h2c_notify_dbcc(struct rtw89_dev *rtwdev, bool en);
 int rtw89_fw_h2c_macid_pause(struct rtw89_dev *rtwdev, u8 sh, u8 grp,
 			     bool pause);
-int rtw89_fw_h2c_set_edca(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+int rtw89_fw_h2c_set_edca(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
 			  u8 ac, u32 val);
 int rtw89_fw_h2c_set_ofld_cfg(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_set_bcn_fltr_cfg(struct rtw89_dev *rtwdev,
@@ -4456,7 +4456,7 @@ int rtw89_fw_h2c_set_bcn_fltr_cfg(struct rtw89_dev *rtwdev,
 				  bool connect);
 int rtw89_fw_h2c_rssi_offload(struct rtw89_dev *rtwdev,
 			      struct rtw89_rx_phy_ppdu *phy_ppdu);
-int rtw89_fw_h2c_tp_offload(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
+int rtw89_fw_h2c_tp_offload(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link);
 int rtw89_fw_h2c_ra(struct rtw89_dev *rtwdev, struct rtw89_ra_info *ra, bool csi);
 int rtw89_fw_h2c_cxdrv_init(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_cxdrv_init_v7(struct rtw89_dev *rtwdev, u8 type);
@@ -4478,11 +4478,11 @@ int rtw89_fw_h2c_scan_list_offload_be(struct rtw89_dev *rtwdev, int ch_num,
 				      struct list_head *chan_list);
 int rtw89_fw_h2c_scan_offload_ax(struct rtw89_dev *rtwdev,
 				 struct rtw89_scan_option *opt,
-				 struct rtw89_vif *vif,
+				 struct rtw89_vif_link *vif,
 				 bool wowlan);
 int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev *rtwdev,
 				 struct rtw89_scan_option *opt,
-				 struct rtw89_vif *vif,
+				 struct rtw89_vif_link *vif,
 				 bool wowlan);
 int rtw89_fw_h2c_rf_reg(struct rtw89_dev *rtwdev,
 			struct rtw89_fw_h2c_rf_reg_info *info,
@@ -4508,10 +4508,11 @@ int rtw89_fw_h2c_raw_with_hdr(struct rtw89_dev *rtwdev,
 int rtw89_fw_h2c_raw(struct rtw89_dev *rtwdev, const u8 *buf, u16 len);
 void rtw89_fw_send_all_early_h2c(struct rtw89_dev *rtwdev);
 void rtw89_fw_free_all_early_h2c(struct rtw89_dev *rtwdev);
-int rtw89_fw_h2c_general_pkt(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+int rtw89_fw_h2c_general_pkt(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
 			     u8 macid);
 void rtw89_fw_release_general_pkt_list_vif(struct rtw89_dev *rtwdev,
-					   struct rtw89_vif *rtwvif, bool notify_fw);
+					   struct rtw89_vif_link *rtwvif_link,
+					   bool notify_fw);
 void rtw89_fw_release_general_pkt_list(struct rtw89_dev *rtwdev, bool notify_fw);
 int rtw89_fw_h2c_ba_cam(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 			bool valid, struct ieee80211_ampdu_params *params);
@@ -4524,8 +4525,8 @@ int rtw89_fw_h2c_init_ba_cam_users(struct rtw89_dev *rtwdev, u8 users,
 int rtw89_fw_h2c_lps_parm(struct rtw89_dev *rtwdev,
 			  struct rtw89_lps_parm *lps_param);
 int rtw89_fw_h2c_lps_ch_info(struct rtw89_dev *rtwdev,
-			     struct rtw89_vif *rtwvif);
-int rtw89_fw_h2c_fwips(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+			     struct rtw89_vif_link *rtwvif_link);
+int rtw89_fw_h2c_fwips(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
 		       bool enable);
 struct sk_buff *rtw89_fw_h2c_alloc_skb_with_hdr(struct rtw89_dev *rtwdev, u32 len);
 struct sk_buff *rtw89_fw_h2c_alloc_skb_no_hdr(struct rtw89_dev *rtwdev, u32 len);
@@ -4542,41 +4543,42 @@ int rtw89_hw_scan_offload(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 			  bool enable);
 void rtw89_hw_scan_abort(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif);
 int rtw89_hw_scan_add_chan_list_ax(struct rtw89_dev *rtwdev,
-				   struct rtw89_vif *rtwvif, bool connected);
+				   struct rtw89_vif_link *rtwvif_link, bool connected);
 int rtw89_pno_scan_add_chan_list_ax(struct rtw89_dev *rtwdev,
-				    struct rtw89_vif *rtwvif);
+				    struct rtw89_vif_link *rtwvif_link);
 int rtw89_hw_scan_add_chan_list_be(struct rtw89_dev *rtwdev,
-				   struct rtw89_vif *rtwvif, bool connected);
+				   struct rtw89_vif_link *rtwvif_link, bool connected);
 int rtw89_pno_scan_add_chan_list_be(struct rtw89_dev *rtwdev,
-				    struct rtw89_vif *rtwvif);
+				    struct rtw89_vif_link *rtwvif_link);
 int rtw89_fw_h2c_trigger_cpu_exception(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_pkt_drop(struct rtw89_dev *rtwdev,
 			  const struct rtw89_pkt_drop_params *params);
 int rtw89_fw_h2c_p2p_act(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 			 struct ieee80211_p2p_noa_desc *desc,
 			 u8 act, u8 noa_id);
-int rtw89_fw_h2c_tsf32_toggle(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+int rtw89_fw_h2c_tsf32_toggle(struct rtw89_dev *rtwdev,
+			      struct rtw89_vif_link *rtwvif_link,
 			      bool en);
-int rtw89_fw_h2c_wow_global(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+int rtw89_fw_h2c_wow_global(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
 			    bool enable);
 int rtw89_fw_h2c_wow_wakeup_ctrl(struct rtw89_dev *rtwdev,
-				 struct rtw89_vif *rtwvif, bool enable);
-int rtw89_fw_h2c_cfg_pno(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+				 struct rtw89_vif_link *rtwvif_link, bool enable);
+int rtw89_fw_h2c_cfg_pno(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
 			 bool enable);
-int rtw89_fw_h2c_keep_alive(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+int rtw89_fw_h2c_keep_alive(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
 			    bool enable);
 int rtw89_fw_h2c_arp_offload(struct rtw89_dev *rtwdev,
-			     struct rtw89_vif *rtwvif, bool enable);
+			     struct rtw89_vif_link *rtwvif_link, bool enable);
 int rtw89_fw_h2c_disconnect_detect(struct rtw89_dev *rtwdev,
-				   struct rtw89_vif *rtwvif, bool enable);
-int rtw89_fw_h2c_wow_global(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+				   struct rtw89_vif_link *rtwvif_link, bool enable);
+int rtw89_fw_h2c_wow_global(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
 			    bool enable);
 int rtw89_fw_h2c_wow_wakeup_ctrl(struct rtw89_dev *rtwdev,
-				 struct rtw89_vif *rtwvif, bool enable);
+				 struct rtw89_vif_link *rtwvif_link, bool enable);
 int rtw89_fw_wow_cam_update(struct rtw89_dev *rtwdev,
 			    struct rtw89_wow_cam_info *cam_info);
 int rtw89_fw_h2c_wow_gtk_ofld(struct rtw89_dev *rtwdev,
-			      struct rtw89_vif *rtwvif,
+			      struct rtw89_vif_link *rtwvif_link,
 			      bool enable);
 int rtw89_fw_h2c_wow_request_aoac(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_add_mcc(struct rtw89_dev *rtwdev,
@@ -4621,32 +4623,32 @@ static inline void rtw89_fw_h2c_init_ba_cam(struct rtw89_dev *rtwdev)
 }
 
 static inline int rtw89_chip_h2c_default_cmac_tbl(struct rtw89_dev *rtwdev,
-						  struct rtw89_vif *rtwvif,
+						  struct rtw89_vif_link *rtwvif_link,
 						  struct rtw89_sta *rtwsta)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 
-	return chip->ops->h2c_default_cmac_tbl(rtwdev, rtwvif, rtwsta);
+	return chip->ops->h2c_default_cmac_tbl(rtwdev, rtwvif_link, rtwsta);
 }
 
 static inline int rtw89_chip_h2c_default_dmac_tbl(struct rtw89_dev *rtwdev,
-						  struct rtw89_vif *rtwvif,
+						  struct rtw89_vif_link *rtwvif_link,
 						  struct rtw89_sta *rtwsta)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 
 	if (chip->ops->h2c_default_dmac_tbl)
-		return chip->ops->h2c_default_dmac_tbl(rtwdev, rtwvif, rtwsta);
+		return chip->ops->h2c_default_dmac_tbl(rtwdev, rtwvif_link, rtwsta);
 
 	return 0;
 }
 
 static inline int rtw89_chip_h2c_update_beacon(struct rtw89_dev *rtwdev,
-					       struct rtw89_vif *rtwvif)
+					       struct rtw89_vif_link *rtwvif_link)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 
-	return chip->ops->h2c_update_beacon(rtwdev, rtwvif);
+	return chip->ops->h2c_update_beacon(rtwdev, rtwvif_link);
 }
 
 static inline int rtw89_chip_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index c70a23a763b0..e1956c722436 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4076,17 +4076,17 @@ static const struct rtw89_port_reg rtw89_port_base_ax = {
 };
 
 static void rtw89_mac_check_packet_ctrl(struct rtw89_dev *rtwdev,
-					struct rtw89_vif *rtwvif, u8 type)
+					struct rtw89_vif_link *rtwvif_link, u8 type)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	const struct rtw89_port_reg *p = mac->port_base;
-	u8 mask = B_AX_PTCL_DBG_INFO_MASK_BY_PORT(rtwvif->port);
+	u8 mask = B_AX_PTCL_DBG_INFO_MASK_BY_PORT(rtwvif_link->port);
 	u32 reg_info, reg_ctrl;
 	u32 val;
 	int ret;
 
-	reg_info = rtw89_mac_reg_by_idx(rtwdev, p->ptcl_dbg_info, rtwvif->mac_idx);
-	reg_ctrl = rtw89_mac_reg_by_idx(rtwdev, p->ptcl_dbg, rtwvif->mac_idx);
+	reg_info = rtw89_mac_reg_by_idx(rtwdev, p->ptcl_dbg_info, rtwvif_link->mac_idx);
+	reg_ctrl = rtw89_mac_reg_by_idx(rtwdev, p->ptcl_dbg, rtwvif_link->mac_idx);
 
 	rtw89_write32_mask(rtwdev, reg_ctrl, B_AX_PTCL_DBG_SEL_MASK, type);
 	rtw89_write32_set(rtwdev, reg_ctrl, B_AX_PTCL_DBG_EN);
@@ -4098,26 +4098,32 @@ static void rtw89_mac_check_packet_ctrl(struct rtw89_dev *rtwdev,
 		rtw89_warn(rtwdev, "Polling beacon packet empty fail\n");
 }
 
-static void rtw89_mac_bcn_drop(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+static void rtw89_mac_bcn_drop(struct rtw89_dev *rtwdev,
+			       struct rtw89_vif_link *rtwvif_link)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	const struct rtw89_port_reg *p = mac->port_base;
 
-	rtw89_write32_set(rtwdev, p->bcn_drop_all, BIT(rtwvif->port));
-	rtw89_write32_port_mask(rtwdev, rtwvif, p->tbtt_prohib, B_AX_TBTT_SETUP_MASK, 1);
-	rtw89_write32_port_mask(rtwdev, rtwvif, p->bcn_area, B_AX_BCN_MSK_AREA_MASK, 0);
-	rtw89_write32_port_mask(rtwdev, rtwvif, p->tbtt_prohib, B_AX_TBTT_HOLD_MASK, 0);
-	rtw89_write32_port_mask(rtwdev, rtwvif, p->bcn_early, B_AX_BCNERLY_MASK, 2);
-	rtw89_write16_port_mask(rtwdev, rtwvif, p->tbtt_early, B_AX_TBTTERLY_MASK, 1);
-	rtw89_write32_port_mask(rtwdev, rtwvif, p->bcn_space, B_AX_BCN_SPACE_MASK, 1);
-	rtw89_write32_port_set(rtwdev, rtwvif, p->port_cfg, B_AX_BCNTX_EN);
-
-	rtw89_mac_check_packet_ctrl(rtwdev, rtwvif, AX_PTCL_DBG_BCNQ_NUM0);
-	if (rtwvif->port == RTW89_PORT_0)
-		rtw89_mac_check_packet_ctrl(rtwdev, rtwvif, AX_PTCL_DBG_BCNQ_NUM1);
-
-	rtw89_write32_clr(rtwdev, p->bcn_drop_all, BIT(rtwvif->port));
-	rtw89_write32_port_clr(rtwdev, rtwvif, p->port_cfg, B_AX_TBTT_PROHIB_EN);
+	rtw89_write32_set(rtwdev, p->bcn_drop_all, BIT(rtwvif_link->port));
+	rtw89_write32_port_mask(rtwdev, rtwvif_link, p->tbtt_prohib, B_AX_TBTT_SETUP_MASK,
+				1);
+	rtw89_write32_port_mask(rtwdev, rtwvif_link, p->bcn_area, B_AX_BCN_MSK_AREA_MASK,
+				0);
+	rtw89_write32_port_mask(rtwdev, rtwvif_link, p->tbtt_prohib, B_AX_TBTT_HOLD_MASK,
+				0);
+	rtw89_write32_port_mask(rtwdev, rtwvif_link, p->bcn_early, B_AX_BCNERLY_MASK, 2);
+	rtw89_write16_port_mask(rtwdev, rtwvif_link, p->tbtt_early,
+				B_AX_TBTTERLY_MASK, 1);
+	rtw89_write32_port_mask(rtwdev, rtwvif_link, p->bcn_space,
+				B_AX_BCN_SPACE_MASK, 1);
+	rtw89_write32_port_set(rtwdev, rtwvif_link, p->port_cfg, B_AX_BCNTX_EN);
+
+	rtw89_mac_check_packet_ctrl(rtwdev, rtwvif_link, AX_PTCL_DBG_BCNQ_NUM0);
+	if (rtwvif_link->port == RTW89_PORT_0)
+		rtw89_mac_check_packet_ctrl(rtwdev, rtwvif_link, AX_PTCL_DBG_BCNQ_NUM1);
+
+	rtw89_write32_clr(rtwdev, p->bcn_drop_all, BIT(rtwvif_link->port));
+	rtw89_write32_port_clr(rtwdev, rtwvif_link, p->port_cfg, B_AX_TBTT_PROHIB_EN);
 	fsleep(2000);
 }
 
@@ -4131,286 +4137,294 @@ static void rtw89_mac_bcn_drop(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvi
 #define BCN_ERLY_SET_DLY (10 * 2)
 
 static void rtw89_mac_port_cfg_func_sw(struct rtw89_dev *rtwdev,
-				       struct rtw89_vif *rtwvif)
+				       struct rtw89_vif_link *rtwvif_link)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	const struct rtw89_port_reg *p = mac->port_base;
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	bool need_backup = false;
 	u32 backup_val;
 
-	if (!rtw89_read32_port_mask(rtwdev, rtwvif, p->port_cfg, B_AX_PORT_FUNC_EN))
+	if (!rtw89_read32_port_mask(rtwdev, rtwvif_link, p->port_cfg, B_AX_PORT_FUNC_EN))
 		return;
 
-	if (chip->chip_id == RTL8852A && rtwvif->port != RTW89_PORT_0) {
+	if (chip->chip_id == RTL8852A && rtwvif_link->port != RTW89_PORT_0) {
 		need_backup = true;
-		backup_val = rtw89_read32_port(rtwdev, rtwvif, p->tbtt_prohib);
+		backup_val = rtw89_read32_port(rtwdev, rtwvif_link, p->tbtt_prohib);
 	}
 
-	if (rtwvif->net_type == RTW89_NET_TYPE_AP_MODE)
-		rtw89_mac_bcn_drop(rtwdev, rtwvif);
+	if (rtwvif_link->net_type == RTW89_NET_TYPE_AP_MODE)
+		rtw89_mac_bcn_drop(rtwdev, rtwvif_link);
 
 	if (chip->chip_id == RTL8852A) {
-		rtw89_write32_port_clr(rtwdev, rtwvif, p->tbtt_prohib, B_AX_TBTT_SETUP_MASK);
-		rtw89_write32_port_mask(rtwdev, rtwvif, p->tbtt_prohib, B_AX_TBTT_HOLD_MASK, 1);
-		rtw89_write16_port_clr(rtwdev, rtwvif, p->tbtt_early, B_AX_TBTTERLY_MASK);
-		rtw89_write16_port_clr(rtwdev, rtwvif, p->bcn_early, B_AX_BCNERLY_MASK);
+		rtw89_write32_port_clr(rtwdev, rtwvif_link, p->tbtt_prohib,
+				       B_AX_TBTT_SETUP_MASK);
+		rtw89_write32_port_mask(rtwdev, rtwvif_link, p->tbtt_prohib,
+					B_AX_TBTT_HOLD_MASK, 1);
+		rtw89_write16_port_clr(rtwdev, rtwvif_link, p->tbtt_early,
+				       B_AX_TBTTERLY_MASK);
+		rtw89_write16_port_clr(rtwdev, rtwvif_link, p->bcn_early,
+				       B_AX_BCNERLY_MASK);
 	}
 
 	msleep(vif->bss_conf.beacon_int + 1);
-	rtw89_write32_port_clr(rtwdev, rtwvif, p->port_cfg, B_AX_PORT_FUNC_EN |
+	rtw89_write32_port_clr(rtwdev, rtwvif_link, p->port_cfg, B_AX_PORT_FUNC_EN |
 							    B_AX_BRK_SETUP);
-	rtw89_write32_port_set(rtwdev, rtwvif, p->port_cfg, B_AX_TSFTR_RST);
-	rtw89_write32_port(rtwdev, rtwvif, p->bcn_cnt_tmr, 0);
+	rtw89_write32_port_set(rtwdev, rtwvif_link, p->port_cfg, B_AX_TSFTR_RST);
+	rtw89_write32_port(rtwdev, rtwvif_link, p->bcn_cnt_tmr, 0);
 
 	if (need_backup)
-		rtw89_write32_port(rtwdev, rtwvif, p->tbtt_prohib, backup_val);
+		rtw89_write32_port(rtwdev, rtwvif_link, p->tbtt_prohib, backup_val);
 }
 
 static void rtw89_mac_port_cfg_tx_rpt(struct rtw89_dev *rtwdev,
-				      struct rtw89_vif *rtwvif, bool en)
+				      struct rtw89_vif_link *rtwvif_link, bool en)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	const struct rtw89_port_reg *p = mac->port_base;
 
 	if (en)
-		rtw89_write32_port_set(rtwdev, rtwvif, p->port_cfg, B_AX_TXBCN_RPT_EN);
+		rtw89_write32_port_set(rtwdev, rtwvif_link, p->port_cfg,
+				       B_AX_TXBCN_RPT_EN);
 	else
-		rtw89_write32_port_clr(rtwdev, rtwvif, p->port_cfg, B_AX_TXBCN_RPT_EN);
+		rtw89_write32_port_clr(rtwdev, rtwvif_link, p->port_cfg,
+				       B_AX_TXBCN_RPT_EN);
 }
 
 static void rtw89_mac_port_cfg_rx_rpt(struct rtw89_dev *rtwdev,
-				      struct rtw89_vif *rtwvif, bool en)
+				      struct rtw89_vif_link *rtwvif_link, bool en)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	const struct rtw89_port_reg *p = mac->port_base;
 
 	if (en)
-		rtw89_write32_port_set(rtwdev, rtwvif, p->port_cfg, B_AX_RXBCN_RPT_EN);
+		rtw89_write32_port_set(rtwdev, rtwvif_link, p->port_cfg,
+				       B_AX_RXBCN_RPT_EN);
 	else
-		rtw89_write32_port_clr(rtwdev, rtwvif, p->port_cfg, B_AX_RXBCN_RPT_EN);
+		rtw89_write32_port_clr(rtwdev, rtwvif_link, p->port_cfg,
+				       B_AX_RXBCN_RPT_EN);
 }
 
 static void rtw89_mac_port_cfg_net_type(struct rtw89_dev *rtwdev,
-					struct rtw89_vif *rtwvif)
+					struct rtw89_vif_link *rtwvif_link)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	const struct rtw89_port_reg *p = mac->port_base;
 
-	rtw89_write32_port_mask(rtwdev, rtwvif, p->port_cfg, B_AX_NET_TYPE_MASK,
-				rtwvif->net_type);
+	rtw89_write32_port_mask(rtwdev, rtwvif_link, p->port_cfg, B_AX_NET_TYPE_MASK,
+				rtwvif_link->net_type);
 }
 
 static void rtw89_mac_port_cfg_bcn_prct(struct rtw89_dev *rtwdev,
-					struct rtw89_vif *rtwvif)
+					struct rtw89_vif_link *rtwvif_link)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	const struct rtw89_port_reg *p = mac->port_base;
-	bool en = rtwvif->net_type != RTW89_NET_TYPE_NO_LINK;
+	bool en = rtwvif_link->net_type != RTW89_NET_TYPE_NO_LINK;
 	u32 bits = B_AX_TBTT_PROHIB_EN | B_AX_BRK_SETUP;
 
 	if (en)
-		rtw89_write32_port_set(rtwdev, rtwvif, p->port_cfg, bits);
+		rtw89_write32_port_set(rtwdev, rtwvif_link, p->port_cfg, bits);
 	else
-		rtw89_write32_port_clr(rtwdev, rtwvif, p->port_cfg, bits);
+		rtw89_write32_port_clr(rtwdev, rtwvif_link, p->port_cfg, bits);
 }
 
 static void rtw89_mac_port_cfg_rx_sw(struct rtw89_dev *rtwdev,
-				     struct rtw89_vif *rtwvif)
+				     struct rtw89_vif_link *rtwvif_link)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	const struct rtw89_port_reg *p = mac->port_base;
-	bool en = rtwvif->net_type == RTW89_NET_TYPE_INFRA ||
-		  rtwvif->net_type == RTW89_NET_TYPE_AD_HOC;
+	bool en = rtwvif_link->net_type == RTW89_NET_TYPE_INFRA ||
+		  rtwvif_link->net_type == RTW89_NET_TYPE_AD_HOC;
 	u32 bit = B_AX_RX_BSSID_FIT_EN;
 
 	if (en)
-		rtw89_write32_port_set(rtwdev, rtwvif, p->port_cfg, bit);
+		rtw89_write32_port_set(rtwdev, rtwvif_link, p->port_cfg, bit);
 	else
-		rtw89_write32_port_clr(rtwdev, rtwvif, p->port_cfg, bit);
+		rtw89_write32_port_clr(rtwdev, rtwvif_link, p->port_cfg, bit);
 }
 
 void rtw89_mac_port_cfg_rx_sync(struct rtw89_dev *rtwdev,
-				struct rtw89_vif *rtwvif, bool en)
+				struct rtw89_vif_link *rtwvif_link, bool en)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	const struct rtw89_port_reg *p = mac->port_base;
 
 	if (en)
-		rtw89_write32_port_set(rtwdev, rtwvif, p->port_cfg, B_AX_TSF_UDT_EN);
+		rtw89_write32_port_set(rtwdev, rtwvif_link, p->port_cfg, B_AX_TSF_UDT_EN);
 	else
-		rtw89_write32_port_clr(rtwdev, rtwvif, p->port_cfg, B_AX_TSF_UDT_EN);
+		rtw89_write32_port_clr(rtwdev, rtwvif_link, p->port_cfg, B_AX_TSF_UDT_EN);
 }
 
 static void rtw89_mac_port_cfg_rx_sync_by_nettype(struct rtw89_dev *rtwdev,
-						  struct rtw89_vif *rtwvif)
+						  struct rtw89_vif_link *rtwvif_link)
 {
-	bool en = rtwvif->net_type == RTW89_NET_TYPE_INFRA ||
-		  rtwvif->net_type == RTW89_NET_TYPE_AD_HOC;
+	bool en = rtwvif_link->net_type == RTW89_NET_TYPE_INFRA ||
+		  rtwvif_link->net_type == RTW89_NET_TYPE_AD_HOC;
 
-	rtw89_mac_port_cfg_rx_sync(rtwdev, rtwvif, en);
+	rtw89_mac_port_cfg_rx_sync(rtwdev, rtwvif_link, en);
 }
 
 static void rtw89_mac_port_cfg_tx_sw(struct rtw89_dev *rtwdev,
-				     struct rtw89_vif *rtwvif, bool en)
+				     struct rtw89_vif_link *rtwvif_link, bool en)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	const struct rtw89_port_reg *p = mac->port_base;
 
 	if (en)
-		rtw89_write32_port_set(rtwdev, rtwvif, p->port_cfg, B_AX_BCNTX_EN);
+		rtw89_write32_port_set(rtwdev, rtwvif_link, p->port_cfg, B_AX_BCNTX_EN);
 	else
-		rtw89_write32_port_clr(rtwdev, rtwvif, p->port_cfg, B_AX_BCNTX_EN);
+		rtw89_write32_port_clr(rtwdev, rtwvif_link, p->port_cfg, B_AX_BCNTX_EN);
 }
 
 static void rtw89_mac_port_cfg_tx_sw_by_nettype(struct rtw89_dev *rtwdev,
-						struct rtw89_vif *rtwvif)
+						struct rtw89_vif_link *rtwvif_link)
 {
-	bool en = rtwvif->net_type == RTW89_NET_TYPE_AP_MODE ||
-		  rtwvif->net_type == RTW89_NET_TYPE_AD_HOC;
+	bool en = rtwvif_link->net_type == RTW89_NET_TYPE_AP_MODE ||
+		  rtwvif_link->net_type == RTW89_NET_TYPE_AD_HOC;
 
-	rtw89_mac_port_cfg_tx_sw(rtwdev, rtwvif, en);
+	rtw89_mac_port_cfg_tx_sw(rtwdev, rtwvif_link, en);
 }
 
 void rtw89_mac_enable_beacon_for_ap_vifs(struct rtw89_dev *rtwdev, bool en)
 {
-	struct rtw89_vif *rtwvif;
+	struct rtw89_vif_link *rtwvif_link;
 
-	rtw89_for_each_rtwvif(rtwdev, rtwvif)
-		if (rtwvif->net_type == RTW89_NET_TYPE_AP_MODE)
-			rtw89_mac_port_cfg_tx_sw(rtwdev, rtwvif, en);
+	rtw89_for_each_rtwvif(rtwdev, rtwvif_link)
+		if (rtwvif_link->net_type == RTW89_NET_TYPE_AP_MODE)
+			rtw89_mac_port_cfg_tx_sw(rtwdev, rtwvif_link, en);
 }
 
 static void rtw89_mac_port_cfg_bcn_intv(struct rtw89_dev *rtwdev,
-					struct rtw89_vif *rtwvif)
+					struct rtw89_vif_link *rtwvif_link)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	const struct rtw89_port_reg *p = mac->port_base;
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
 	u16 bcn_int = vif->bss_conf.beacon_int ? vif->bss_conf.beacon_int : BCN_INTERVAL;
 
-	rtw89_write32_port_mask(rtwdev, rtwvif, p->bcn_space, B_AX_BCN_SPACE_MASK,
+	rtw89_write32_port_mask(rtwdev, rtwvif_link, p->bcn_space, B_AX_BCN_SPACE_MASK,
 				bcn_int);
 }
 
 static void rtw89_mac_port_cfg_hiq_win(struct rtw89_dev *rtwdev,
-				       struct rtw89_vif *rtwvif)
+				       struct rtw89_vif_link *rtwvif_link)
 {
-	u8 win = rtwvif->net_type == RTW89_NET_TYPE_AP_MODE ? 16 : 0;
+	u8 win = rtwvif_link->net_type == RTW89_NET_TYPE_AP_MODE ? 16 : 0;
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	const struct rtw89_port_reg *p = mac->port_base;
-	u8 port = rtwvif->port;
+	u8 port = rtwvif_link->port;
 	u32 reg;
 
-	reg = rtw89_mac_reg_by_idx(rtwdev, p->hiq_win[port], rtwvif->mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, p->hiq_win[port], rtwvif_link->mac_idx);
 	rtw89_write8(rtwdev, reg, win);
 }
 
 static void rtw89_mac_port_cfg_hiq_dtim(struct rtw89_dev *rtwdev,
-					struct rtw89_vif *rtwvif)
+					struct rtw89_vif_link *rtwvif_link)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	const struct rtw89_port_reg *p = mac->port_base;
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
 	u32 addr;
 
-	addr = rtw89_mac_reg_by_idx(rtwdev, p->md_tsft, rtwvif->mac_idx);
+	addr = rtw89_mac_reg_by_idx(rtwdev, p->md_tsft, rtwvif_link->mac_idx);
 	rtw89_write8_set(rtwdev, addr, B_AX_UPD_HGQMD | B_AX_UPD_TIMIE);
 
-	rtw89_write16_port_mask(rtwdev, rtwvif, p->dtim_ctrl, B_AX_DTIM_NUM_MASK,
+	rtw89_write16_port_mask(rtwdev, rtwvif_link, p->dtim_ctrl, B_AX_DTIM_NUM_MASK,
 				vif->bss_conf.dtim_period);
 }
 
 static void rtw89_mac_port_cfg_bcn_setup_time(struct rtw89_dev *rtwdev,
-					      struct rtw89_vif *rtwvif)
+					      struct rtw89_vif_link *rtwvif_link)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	const struct rtw89_port_reg *p = mac->port_base;
 
-	rtw89_write32_port_mask(rtwdev, rtwvif, p->tbtt_prohib,
+	rtw89_write32_port_mask(rtwdev, rtwvif_link, p->tbtt_prohib,
 				B_AX_TBTT_SETUP_MASK, BCN_SETUP_DEF);
 }
 
 static void rtw89_mac_port_cfg_bcn_hold_time(struct rtw89_dev *rtwdev,
-					     struct rtw89_vif *rtwvif)
+					     struct rtw89_vif_link *rtwvif_link)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	const struct rtw89_port_reg *p = mac->port_base;
 
-	rtw89_write32_port_mask(rtwdev, rtwvif, p->tbtt_prohib,
+	rtw89_write32_port_mask(rtwdev, rtwvif_link, p->tbtt_prohib,
 				B_AX_TBTT_HOLD_MASK, BCN_HOLD_DEF);
 }
 
 static void rtw89_mac_port_cfg_bcn_mask_area(struct rtw89_dev *rtwdev,
-					     struct rtw89_vif *rtwvif)
+					     struct rtw89_vif_link *rtwvif_link)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	const struct rtw89_port_reg *p = mac->port_base;
 
-	rtw89_write32_port_mask(rtwdev, rtwvif, p->bcn_area,
+	rtw89_write32_port_mask(rtwdev, rtwvif_link, p->bcn_area,
 				B_AX_BCN_MSK_AREA_MASK, BCN_MASK_DEF);
 }
 
 static void rtw89_mac_port_cfg_tbtt_early(struct rtw89_dev *rtwdev,
-					  struct rtw89_vif *rtwvif)
+					  struct rtw89_vif_link *rtwvif_link)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	const struct rtw89_port_reg *p = mac->port_base;
 
-	rtw89_write16_port_mask(rtwdev, rtwvif, p->tbtt_early,
+	rtw89_write16_port_mask(rtwdev, rtwvif_link, p->tbtt_early,
 				B_AX_TBTTERLY_MASK, TBTT_ERLY_DEF);
 }
 
 static void rtw89_mac_port_cfg_bss_color(struct rtw89_dev *rtwdev,
-					 struct rtw89_vif *rtwvif)
+					 struct rtw89_vif_link *rtwvif_link)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	const struct rtw89_port_reg *p = mac->port_base;
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
 	static const u32 masks[RTW89_PORT_NUM] = {
 		B_AX_BSS_COLOB_AX_PORT_0_MASK, B_AX_BSS_COLOB_AX_PORT_1_MASK,
 		B_AX_BSS_COLOB_AX_PORT_2_MASK, B_AX_BSS_COLOB_AX_PORT_3_MASK,
 		B_AX_BSS_COLOB_AX_PORT_4_MASK,
 	};
-	u8 port = rtwvif->port;
+	u8 port = rtwvif_link->port;
 	u32 reg_base;
 	u32 reg;
 	u8 bss_color;
 
 	bss_color = vif->bss_conf.he_bss_color.color;
 	reg_base = port >= 4 ? p->bss_color + 4 : p->bss_color;
-	reg = rtw89_mac_reg_by_idx(rtwdev, reg_base, rtwvif->mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, reg_base, rtwvif_link->mac_idx);
 	rtw89_write32_mask(rtwdev, reg, masks[port], bss_color);
 }
 
 static void rtw89_mac_port_cfg_mbssid(struct rtw89_dev *rtwdev,
-				      struct rtw89_vif *rtwvif)
+				      struct rtw89_vif_link *rtwvif_link)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	const struct rtw89_port_reg *p = mac->port_base;
-	u8 port = rtwvif->port;
+	u8 port = rtwvif_link->port;
 	u32 reg;
 
-	if (rtwvif->net_type == RTW89_NET_TYPE_AP_MODE)
+	if (rtwvif_link->net_type == RTW89_NET_TYPE_AP_MODE)
 		return;
 
 	if (port == 0) {
-		reg = rtw89_mac_reg_by_idx(rtwdev, p->mbssid, rtwvif->mac_idx);
+		reg = rtw89_mac_reg_by_idx(rtwdev, p->mbssid, rtwvif_link->mac_idx);
 		rtw89_write32_clr(rtwdev, reg, B_AX_P0MB_ALL_MASK);
 	}
 }
 
 static void rtw89_mac_port_cfg_hiq_drop(struct rtw89_dev *rtwdev,
-					struct rtw89_vif *rtwvif)
+					struct rtw89_vif_link *rtwvif_link)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	const struct rtw89_port_reg *p = mac->port_base;
-	u8 port = rtwvif->port;
+	u8 port = rtwvif_link->port;
 	u32 reg;
 	u32 val;
 
-	reg = rtw89_mac_reg_by_idx(rtwdev, p->mbssid_drop, rtwvif->mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, p->mbssid_drop, rtwvif_link->mac_idx);
 	val = rtw89_read32(rtwdev, reg);
 	val &= ~FIELD_PREP(B_AX_PORT_DROP_4_0_MASK, BIT(port));
 	if (port == 0)
@@ -4419,31 +4433,31 @@ static void rtw89_mac_port_cfg_hiq_drop(struct rtw89_dev *rtwdev,
 }
 
 static void rtw89_mac_port_cfg_func_en(struct rtw89_dev *rtwdev,
-				       struct rtw89_vif *rtwvif, bool enable)
+				       struct rtw89_vif_link *rtwvif_link, bool enable)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	const struct rtw89_port_reg *p = mac->port_base;
 
 	if (enable)
-		rtw89_write32_port_set(rtwdev, rtwvif, p->port_cfg,
+		rtw89_write32_port_set(rtwdev, rtwvif_link, p->port_cfg,
 				       B_AX_PORT_FUNC_EN);
 	else
-		rtw89_write32_port_clr(rtwdev, rtwvif, p->port_cfg,
+		rtw89_write32_port_clr(rtwdev, rtwvif_link, p->port_cfg,
 				       B_AX_PORT_FUNC_EN);
 }
 
 static void rtw89_mac_port_cfg_bcn_early(struct rtw89_dev *rtwdev,
-					 struct rtw89_vif *rtwvif)
+					 struct rtw89_vif_link *rtwvif_link)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	const struct rtw89_port_reg *p = mac->port_base;
 
-	rtw89_write32_port_mask(rtwdev, rtwvif, p->bcn_early, B_AX_BCNERLY_MASK,
+	rtw89_write32_port_mask(rtwdev, rtwvif_link, p->bcn_early, B_AX_BCNERLY_MASK,
 				BCN_ERLY_DEF);
 }
 
 static void rtw89_mac_port_cfg_tbtt_shift(struct rtw89_dev *rtwdev,
-					  struct rtw89_vif *rtwvif)
+					  struct rtw89_vif_link *rtwvif_link)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	const struct rtw89_port_reg *p = mac->port_base;
@@ -4452,20 +4466,20 @@ static void rtw89_mac_port_cfg_tbtt_shift(struct rtw89_dev *rtwdev,
 	if (rtwdev->chip->chip_id != RTL8852C)
 		return;
 
-	if (rtwvif->wifi_role != RTW89_WIFI_ROLE_P2P_CLIENT &&
-	    rtwvif->wifi_role != RTW89_WIFI_ROLE_STATION)
+	if (rtwvif_link->wifi_role != RTW89_WIFI_ROLE_P2P_CLIENT &&
+	    rtwvif_link->wifi_role != RTW89_WIFI_ROLE_STATION)
 		return;
 
 	val = FIELD_PREP(B_AX_TBTT_SHIFT_OFST_MAG, 1) |
 			 B_AX_TBTT_SHIFT_OFST_SIGN;
 
-	rtw89_write16_port_mask(rtwdev, rtwvif, p->tbtt_shift,
+	rtw89_write16_port_mask(rtwdev, rtwvif_link, p->tbtt_shift,
 				B_AX_TBTT_SHIFT_OFST_MASK, val);
 }
 
 void rtw89_mac_port_tsf_sync(struct rtw89_dev *rtwdev,
-			     struct rtw89_vif *rtwvif,
-			     struct rtw89_vif *rtwvif_src,
+			     struct rtw89_vif_link *rtwvif_link,
+			     struct rtw89_vif_link *rtwvif_src,
 			     u16 offset_tu)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
@@ -4473,8 +4487,8 @@ void rtw89_mac_port_tsf_sync(struct rtw89_dev *rtwdev,
 	u32 val, reg;
 
 	val = RTW89_PORT_OFFSET_TU_TO_32US(offset_tu);
-	reg = rtw89_mac_reg_by_idx(rtwdev, p->tsf_sync + rtwvif->port * 4,
-				   rtwvif->mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, p->tsf_sync + rtwvif_link->port * 4,
+				   rtwvif_link->mac_idx);
 
 	rtw89_write32_mask(rtwdev, reg, B_AX_SYNC_PORT_SRC, rtwvif_src->port);
 	rtw89_write32_mask(rtwdev, reg, B_AX_SYNC_PORT_OFFSET_VAL, val);
@@ -4482,16 +4496,16 @@ void rtw89_mac_port_tsf_sync(struct rtw89_dev *rtwdev,
 }
 
 static void rtw89_mac_port_tsf_sync_rand(struct rtw89_dev *rtwdev,
-					 struct rtw89_vif *rtwvif,
-					 struct rtw89_vif *rtwvif_src,
+					 struct rtw89_vif_link *rtwvif_link,
+					 struct rtw89_vif_link *rtwvif_src,
 					 u8 offset, int *n_offset)
 {
-	if (rtwvif->net_type != RTW89_NET_TYPE_AP_MODE || rtwvif == rtwvif_src)
+	if (rtwvif_link->net_type != RTW89_NET_TYPE_AP_MODE || rtwvif_link == rtwvif_src)
 		return;
 
 	/* adjust offset randomly to avoid beacon conflict */
 	offset = offset - offset / 4 + get_random_u32() % (offset / 2);
-	rtw89_mac_port_tsf_sync(rtwdev, rtwvif, rtwvif_src,
+	rtw89_mac_port_tsf_sync(rtwdev, rtwvif_link, rtwvif_src,
 				(*n_offset) * offset);
 
 	(*n_offset)++;
@@ -4499,7 +4513,7 @@ static void rtw89_mac_port_tsf_sync_rand(struct rtw89_dev *rtwdev,
 
 static void rtw89_mac_port_tsf_resync_all(struct rtw89_dev *rtwdev)
 {
-	struct rtw89_vif *src = NULL, *tmp;
+	struct rtw89_vif_link *src = NULL, *tmp;
 	u8 offset = 100, vif_aps = 0;
 	int n_offset = 1;
 
@@ -4519,100 +4533,100 @@ static void rtw89_mac_port_tsf_resync_all(struct rtw89_dev *rtwdev)
 		rtw89_mac_port_tsf_sync_rand(rtwdev, tmp, src, offset, &n_offset);
 }
 
-int rtw89_mac_vif_init(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+int rtw89_mac_vif_init(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link)
 {
 	int ret;
 
-	ret = rtw89_mac_port_update(rtwdev, rtwvif);
+	ret = rtw89_mac_port_update(rtwdev, rtwvif_link);
 	if (ret)
 		return ret;
 
-	rtw89_mac_dmac_tbl_init(rtwdev, rtwvif->mac_id);
-	rtw89_mac_cmac_tbl_init(rtwdev, rtwvif->mac_id);
+	rtw89_mac_dmac_tbl_init(rtwdev, rtwvif_link->mac_id);
+	rtw89_mac_cmac_tbl_init(rtwdev, rtwvif_link->mac_id);
 
-	ret = rtw89_mac_set_macid_pause(rtwdev, rtwvif->mac_id, false);
+	ret = rtw89_mac_set_macid_pause(rtwdev, rtwvif_link->mac_id, false);
 	if (ret)
 		return ret;
 
-	ret = rtw89_fw_h2c_role_maintain(rtwdev, rtwvif, NULL, RTW89_ROLE_CREATE);
+	ret = rtw89_fw_h2c_role_maintain(rtwdev, rtwvif_link, NULL, RTW89_ROLE_CREATE);
 	if (ret)
 		return ret;
 
-	ret = rtw89_fw_h2c_join_info(rtwdev, rtwvif, NULL, true);
+	ret = rtw89_fw_h2c_join_info(rtwdev, rtwvif_link, NULL, true);
 	if (ret)
 		return ret;
 
-	ret = rtw89_cam_init(rtwdev, rtwvif);
+	ret = rtw89_cam_init(rtwdev, rtwvif_link);
 	if (ret)
 		return ret;
 
-	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif, NULL, NULL);
+	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif_link, NULL, NULL);
 	if (ret)
 		return ret;
 
-	ret = rtw89_chip_h2c_default_cmac_tbl(rtwdev, rtwvif, NULL);
+	ret = rtw89_chip_h2c_default_cmac_tbl(rtwdev, rtwvif_link, NULL);
 	if (ret)
 		return ret;
 
-	ret = rtw89_chip_h2c_default_dmac_tbl(rtwdev, rtwvif, NULL);
+	ret = rtw89_chip_h2c_default_dmac_tbl(rtwdev, rtwvif_link, NULL);
 	if (ret)
 		return ret;
 
 	return 0;
 }
 
-int rtw89_mac_vif_deinit(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+int rtw89_mac_vif_deinit(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link)
 {
 	int ret;
 
-	ret = rtw89_fw_h2c_role_maintain(rtwdev, rtwvif, NULL, RTW89_ROLE_REMOVE);
+	ret = rtw89_fw_h2c_role_maintain(rtwdev, rtwvif_link, NULL, RTW89_ROLE_REMOVE);
 	if (ret)
 		return ret;
 
-	rtw89_cam_deinit(rtwdev, rtwvif);
+	rtw89_cam_deinit(rtwdev, rtwvif_link);
 
-	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif, NULL, NULL);
+	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif_link, NULL, NULL);
 	if (ret)
 		return ret;
 
 	return 0;
 }
 
-int rtw89_mac_port_update(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+int rtw89_mac_port_update(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link)
 {
-	u8 port = rtwvif->port;
+	u8 port = rtwvif_link->port;
 
 	if (port >= RTW89_PORT_NUM)
 		return -EINVAL;
 
-	rtw89_mac_port_cfg_func_sw(rtwdev, rtwvif);
-	rtw89_mac_port_cfg_tx_rpt(rtwdev, rtwvif, false);
-	rtw89_mac_port_cfg_rx_rpt(rtwdev, rtwvif, false);
-	rtw89_mac_port_cfg_net_type(rtwdev, rtwvif);
-	rtw89_mac_port_cfg_bcn_prct(rtwdev, rtwvif);
-	rtw89_mac_port_cfg_rx_sw(rtwdev, rtwvif);
-	rtw89_mac_port_cfg_rx_sync_by_nettype(rtwdev, rtwvif);
-	rtw89_mac_port_cfg_tx_sw_by_nettype(rtwdev, rtwvif);
-	rtw89_mac_port_cfg_bcn_intv(rtwdev, rtwvif);
-	rtw89_mac_port_cfg_hiq_win(rtwdev, rtwvif);
-	rtw89_mac_port_cfg_hiq_dtim(rtwdev, rtwvif);
-	rtw89_mac_port_cfg_hiq_drop(rtwdev, rtwvif);
-	rtw89_mac_port_cfg_bcn_setup_time(rtwdev, rtwvif);
-	rtw89_mac_port_cfg_bcn_hold_time(rtwdev, rtwvif);
-	rtw89_mac_port_cfg_bcn_mask_area(rtwdev, rtwvif);
-	rtw89_mac_port_cfg_tbtt_early(rtwdev, rtwvif);
-	rtw89_mac_port_cfg_tbtt_shift(rtwdev, rtwvif);
-	rtw89_mac_port_cfg_bss_color(rtwdev, rtwvif);
-	rtw89_mac_port_cfg_mbssid(rtwdev, rtwvif);
-	rtw89_mac_port_cfg_func_en(rtwdev, rtwvif, true);
+	rtw89_mac_port_cfg_func_sw(rtwdev, rtwvif_link);
+	rtw89_mac_port_cfg_tx_rpt(rtwdev, rtwvif_link, false);
+	rtw89_mac_port_cfg_rx_rpt(rtwdev, rtwvif_link, false);
+	rtw89_mac_port_cfg_net_type(rtwdev, rtwvif_link);
+	rtw89_mac_port_cfg_bcn_prct(rtwdev, rtwvif_link);
+	rtw89_mac_port_cfg_rx_sw(rtwdev, rtwvif_link);
+	rtw89_mac_port_cfg_rx_sync_by_nettype(rtwdev, rtwvif_link);
+	rtw89_mac_port_cfg_tx_sw_by_nettype(rtwdev, rtwvif_link);
+	rtw89_mac_port_cfg_bcn_intv(rtwdev, rtwvif_link);
+	rtw89_mac_port_cfg_hiq_win(rtwdev, rtwvif_link);
+	rtw89_mac_port_cfg_hiq_dtim(rtwdev, rtwvif_link);
+	rtw89_mac_port_cfg_hiq_drop(rtwdev, rtwvif_link);
+	rtw89_mac_port_cfg_bcn_setup_time(rtwdev, rtwvif_link);
+	rtw89_mac_port_cfg_bcn_hold_time(rtwdev, rtwvif_link);
+	rtw89_mac_port_cfg_bcn_mask_area(rtwdev, rtwvif_link);
+	rtw89_mac_port_cfg_tbtt_early(rtwdev, rtwvif_link);
+	rtw89_mac_port_cfg_tbtt_shift(rtwdev, rtwvif_link);
+	rtw89_mac_port_cfg_bss_color(rtwdev, rtwvif_link);
+	rtw89_mac_port_cfg_mbssid(rtwdev, rtwvif_link);
+	rtw89_mac_port_cfg_func_en(rtwdev, rtwvif_link, true);
 	rtw89_mac_port_tsf_resync_all(rtwdev);
 	fsleep(BCN_ERLY_SET_DLY);
-	rtw89_mac_port_cfg_bcn_early(rtwdev, rtwvif);
+	rtw89_mac_port_cfg_bcn_early(rtwdev, rtwvif_link);
 
 	return 0;
 }
 
-int rtw89_mac_port_get_tsf(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+int rtw89_mac_port_get_tsf(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
 			   u64 *tsf)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
@@ -4620,12 +4634,12 @@ int rtw89_mac_port_get_tsf(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 	u32 tsf_low, tsf_high;
 	int ret;
 
-	ret = rtw89_mac_check_mac_en(rtwdev, rtwvif->mac_idx, RTW89_CMAC_SEL);
+	ret = rtw89_mac_check_mac_en(rtwdev, rtwvif_link->mac_idx, RTW89_CMAC_SEL);
 	if (ret)
 		return ret;
 
-	tsf_low = rtw89_read32_port(rtwdev, rtwvif, p->tsftr_l);
-	tsf_high = rtw89_read32_port(rtwdev, rtwvif, p->tsftr_h);
+	tsf_low = rtw89_read32_port(rtwdev, rtwvif_link, p->tsftr_l);
+	tsf_high = rtw89_read32_port(rtwdev, rtwvif_link, p->tsftr_h);
 	*tsf = (u64)tsf_high << 32 | tsf_low;
 
 	return 0;
@@ -4653,7 +4667,7 @@ static void rtw89_mac_check_he_obss_narrow_bw_ru_iter(struct wiphy *wiphy,
 void rtw89_mac_set_he_obss_narrow_bw_ru(struct rtw89_dev *rtwdev,
 					struct ieee80211_vif *vif)
 {
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	struct ieee80211_hw *hw = rtwdev->hw;
 	bool tolerated = true;
@@ -4670,44 +4684,44 @@ void rtw89_mac_set_he_obss_narrow_bw_ru(struct rtw89_dev *rtwdev,
 			  &tolerated);
 
 	reg = rtw89_mac_reg_by_idx(rtwdev, mac->narrow_bw_ru_dis.addr,
-				   rtwvif->mac_idx);
+				   rtwvif_link->mac_idx);
 	if (tolerated)
 		rtw89_write32_clr(rtwdev, reg, mac->narrow_bw_ru_dis.mask);
 	else
 		rtw89_write32_set(rtwdev, reg, mac->narrow_bw_ru_dis.mask);
 }
 
-void rtw89_mac_stop_ap(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+void rtw89_mac_stop_ap(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link)
 {
-	rtw89_mac_port_cfg_func_sw(rtwdev, rtwvif);
+	rtw89_mac_port_cfg_func_sw(rtwdev, rtwvif_link);
 }
 
-int rtw89_mac_add_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+int rtw89_mac_add_vif(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link)
 {
 	int ret;
 
-	rtwvif->mac_id = rtw89_acquire_mac_id(rtwdev);
-	if (rtwvif->mac_id == RTW89_MAX_MAC_ID_NUM)
+	rtwvif_link->mac_id = rtw89_acquire_mac_id(rtwdev);
+	if (rtwvif_link->mac_id == RTW89_MAX_MAC_ID_NUM)
 		return -ENOSPC;
 
-	ret = rtw89_mac_vif_init(rtwdev, rtwvif);
+	ret = rtw89_mac_vif_init(rtwdev, rtwvif_link);
 	if (ret)
 		goto release_mac_id;
 
 	return 0;
 
 release_mac_id:
-	rtw89_release_mac_id(rtwdev, rtwvif->mac_id);
+	rtw89_release_mac_id(rtwdev, rtwvif_link->mac_id);
 
 	return ret;
 }
 
-int rtw89_mac_remove_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+int rtw89_mac_remove_vif(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link)
 {
 	int ret;
 
-	ret = rtw89_mac_vif_deinit(rtwdev, rtwvif);
-	rtw89_release_mac_id(rtwdev, rtwvif->mac_id);
+	ret = rtw89_mac_vif_deinit(rtwdev, rtwvif_link);
+	rtw89_release_mac_id(rtwdev, rtwvif_link->mac_id);
 
 	return ret;
 }
@@ -4731,7 +4745,7 @@ rtw89_mac_c2h_scanofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 	const struct rtw89_c2h_scanofld *c2h =
 		(const struct rtw89_c2h_scanofld *)skb->data;
 	struct ieee80211_vif *vif = rtwdev->scan_info.scanning_vif;
-	struct rtw89_vif *rtwvif = vif_to_rtwvif_safe(vif);
+	struct rtw89_vif_link *rtwvif_link = vif_to_rtwvif_safe(vif);
 	struct rtw89_chan new;
 	u8 reason, status, tx_fail, band, actual_period, expect_period;
 	u32 last_chan = rtwdev->scan_info.last_chan_idx, report_tsf;
@@ -4739,7 +4753,7 @@ rtw89_mac_c2h_scanofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 	u16 chan;
 	int ret;
 
-	if (!rtwvif)
+	if (!rtwvif_link)
 		return;
 
 	tx_fail = le32_get_bits(c2h->w5, RTW89_C2H_SCANOFLD_W5_TX_FAIL);
@@ -4781,8 +4795,8 @@ rtw89_mac_c2h_scanofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 		if (rtwdev->scan_info.abort)
 			return;
 
-		if (rtwvif && rtwvif->scan_req &&
-		    last_chan < rtwvif->scan_req->n_channels) {
+		if (rtwvif_link && rtwvif_link->scan_req &&
+		    last_chan < rtwvif_link->scan_req->n_channels) {
 			ret = rtw89_hw_scan_offload(rtwdev, vif, true);
 			if (ret) {
 				rtw89_hw_scan_abort(rtwdev, vif);
@@ -4795,14 +4809,14 @@ rtw89_mac_c2h_scanofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 	case RTW89_SCAN_ENTER_OP_NOTIFY:
 	case RTW89_SCAN_ENTER_CH_NOTIFY:
 		if (rtw89_is_op_chan(rtwdev, band, chan)) {
-			rtw89_assign_entity_chan(rtwdev, rtwvif->chanctx_idx,
+			rtw89_assign_entity_chan(rtwdev, rtwvif_link->chanctx_idx,
 						 &rtwdev->scan_info.op_chan);
 			rtw89_mac_enable_beacon_for_ap_vifs(rtwdev, true);
 			ieee80211_wake_queues(rtwdev->hw);
 		} else {
 			rtw89_chan_create(&new, chan, chan, band,
 					  RTW89_CHANNEL_WIDTH_20);
-			rtw89_assign_entity_chan(rtwdev, rtwvif->chanctx_idx,
+			rtw89_assign_entity_chan(rtwdev, rtwvif_link->chanctx_idx,
 						 &new);
 		}
 		break;
@@ -4812,10 +4826,10 @@ rtw89_mac_c2h_scanofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 }
 
 static void
-rtw89_mac_bcn_fltr_rpt(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+rtw89_mac_bcn_fltr_rpt(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
 		       struct sk_buff *skb)
 {
-	struct ieee80211_vif *vif = rtwvif_to_vif_safe(rtwvif);
+	struct ieee80211_vif *vif = rtwvif_to_vif_safe(rtwvif_link);
 	enum nl80211_cqm_rssi_threshold_event nl_event;
 	const struct rtw89_c2h_mac_bcnfltr_rpt *c2h =
 		(const struct rtw89_c2h_mac_bcnfltr_rpt *)skb->data;
@@ -4827,7 +4841,7 @@ rtw89_mac_bcn_fltr_rpt(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 	event = le32_get_bits(c2h->w2, RTW89_C2H_MAC_BCNFLTR_RPT_W2_EVENT);
 	mac_id = le32_get_bits(c2h->w2, RTW89_C2H_MAC_BCNFLTR_RPT_W2_MACID);
 
-	if (mac_id != rtwvif->mac_id)
+	if (mac_id != rtwvif_link->mac_id)
 		return;
 
 	rtw89_debug(rtwdev, RTW89_DBG_FW,
@@ -4836,7 +4850,7 @@ rtw89_mac_bcn_fltr_rpt(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 
 	switch (type) {
 	case RTW89_BCN_FLTR_BEACON_LOSS:
-		if (!rtwdev->scanning && !rtwvif->offchan)
+		if (!rtwdev->scanning && !rtwvif_link->offchan)
 			ieee80211_connection_loss(vif);
 		else
 			rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, vif, true);
@@ -4863,10 +4877,10 @@ static void
 rtw89_mac_c2h_bcn_fltr_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h,
 			   u32 len)
 {
-	struct rtw89_vif *rtwvif;
+	struct rtw89_vif_link *rtwvif_link;
 
-	rtw89_for_each_rtwvif(rtwdev, rtwvif)
-		rtw89_mac_bcn_fltr_rpt(rtwdev, rtwvif, c2h);
+	rtw89_for_each_rtwvif(rtwdev, rtwvif_link)
+		rtw89_mac_bcn_fltr_rpt(rtwdev, rtwvif_link, c2h);
 }
 
 static void
@@ -5934,10 +5948,10 @@ static int rtw89_mac_set_csi_para_reg_ax(struct rtw89_dev *rtwdev,
 					 struct ieee80211_vif *vif,
 					 struct ieee80211_sta *sta)
 {
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
-	u8 mac_idx = rtwvif->mac_idx;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
+	u8 mac_idx = rtwvif_link->mac_idx;
 	u8 nc = 1, nr = 3, ng = 0, cb = 1, cs = 1, ldpc_en = 1, stbc_en = 1;
-	u8 port_sel = rtwvif->port;
+	u8 port_sel = rtwvif_link->port;
 	u8 sound_dim = 3, t;
 	u8 *phy_cap = sta->deflink.he_cap.he_cap_elem.phy_cap_info;
 	u32 reg;
@@ -5992,10 +6006,10 @@ static int rtw89_mac_csi_rrsc_ax(struct rtw89_dev *rtwdev,
 				 struct ieee80211_vif *vif,
 				 struct ieee80211_sta *sta)
 {
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 	u32 rrsc = BIT(RTW89_MAC_BF_RRSC_6M) | BIT(RTW89_MAC_BF_RRSC_24M);
 	u32 reg;
-	u8 mac_idx = rtwvif->mac_idx;
+	u8 mac_idx = rtwvif_link->mac_idx;
 	int ret;
 
 	ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
@@ -6031,12 +6045,12 @@ static void rtw89_mac_bf_assoc_ax(struct rtw89_dev *rtwdev,
 				  struct ieee80211_vif *vif,
 				  struct ieee80211_sta *sta)
 {
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 
 	if (rtw89_sta_has_beamformer_cap(sta)) {
 		rtw89_debug(rtwdev, RTW89_DBG_BF,
 			    "initialize bfee for new association\n");
-		rtw89_mac_init_bfee_ax(rtwdev, rtwvif->mac_idx);
+		rtw89_mac_init_bfee_ax(rtwdev, rtwvif_link->mac_idx);
 		rtw89_mac_set_csi_para_reg_ax(rtwdev, vif, sta);
 		rtw89_mac_csi_rrsc_ax(rtwdev, vif, sta);
 	}
@@ -6045,16 +6059,16 @@ static void rtw89_mac_bf_assoc_ax(struct rtw89_dev *rtwdev,
 void rtw89_mac_bf_disassoc(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta)
 {
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 
-	rtw89_mac_bfee_ctrl(rtwdev, rtwvif->mac_idx, false);
+	rtw89_mac_bfee_ctrl(rtwdev, rtwvif_link->mac_idx, false);
 }
 
 void rtw89_mac_bf_set_gid_table(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 				struct ieee80211_bss_conf *conf)
 {
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
-	u8 mac_idx = rtwvif->mac_idx;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
+	u8 mac_idx = rtwvif_link->mac_idx;
 	__le32 *p;
 
 	rtw89_debug(rtwdev, RTW89_DBG_BF, "update bf GID table\n");
@@ -6121,7 +6135,7 @@ void rtw89_mac_bf_monitor_calc(struct rtw89_dev *rtwdev,
 void _rtw89_mac_bf_monitor_track(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_traffic_stats *stats = &rtwdev->stats;
-	struct rtw89_vif *rtwvif;
+	struct rtw89_vif_link *rtwvif_link;
 	bool en = stats->tx_tfc_lv <= stats->rx_tfc_lv;
 	bool old = test_bit(RTW89_FLAG_BFEE_EN, rtwdev->flags);
 	bool keep_timer = true;
@@ -6133,16 +6147,16 @@ void _rtw89_mac_bf_monitor_track(struct rtw89_dev *rtwdev)
 		keep_timer = false;
 
 	if (keep_timer != old_keep_timer) {
-		rtw89_for_each_rtwvif(rtwdev, rtwvif)
-			rtw89_mac_bfee_standby_timer(rtwdev, rtwvif->mac_idx,
+		rtw89_for_each_rtwvif(rtwdev, rtwvif_link)
+			rtw89_mac_bfee_standby_timer(rtwdev, rtwvif_link->mac_idx,
 						     keep_timer);
 	}
 
 	if (en == old)
 		return;
 
-	rtw89_for_each_rtwvif(rtwdev, rtwvif)
-		rtw89_mac_bfee_ctrl(rtwdev, rtwvif->mac_idx, en);
+	rtw89_for_each_rtwvif(rtwdev, rtwvif_link)
+		rtw89_mac_bfee_ctrl(rtwdev, rtwvif_link->mac_idx, en);
 }
 
 static int
@@ -6150,7 +6164,7 @@ __rtw89_mac_set_tx_time(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 			u32 tx_time)
 {
 #define MAC_AX_DFLT_TX_TIME 5280
-	u8 mac_idx = rtwsta->rtwvif->mac_idx;
+	u8 mac_idx = rtwsta->rtwvif_link->mac_idx;
 	u32 max_tx_time = tx_time == 0 ? MAC_AX_DFLT_TX_TIME : tx_time;
 	u32 reg;
 	int ret = 0;
@@ -6192,7 +6206,7 @@ int rtw89_mac_set_tx_time(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 int rtw89_mac_get_tx_time(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 			  u32 *tx_time)
 {
-	u8 mac_idx = rtwsta->rtwvif->mac_idx;
+	u8 mac_idx = rtwsta->rtwvif_link->mac_idx;
 	u32 reg;
 	int ret = 0;
 
@@ -6234,7 +6248,7 @@ int rtw89_mac_set_tx_retry_limit(struct rtw89_dev *rtwdev,
 int rtw89_mac_get_tx_retry_limit(struct rtw89_dev *rtwdev,
 				 struct rtw89_sta *rtwsta, u8 *tx_retry)
 {
-	u8 mac_idx = rtwsta->rtwvif->mac_idx;
+	u8 mac_idx = rtwsta->rtwvif_link->mac_idx;
 	u32 reg;
 	int ret = 0;
 
@@ -6255,10 +6269,10 @@ int rtw89_mac_get_tx_retry_limit(struct rtw89_dev *rtwdev,
 }
 
 int rtw89_mac_set_hw_muedca_ctrl(struct rtw89_dev *rtwdev,
-				 struct rtw89_vif *rtwvif, bool en)
+				 struct rtw89_vif_link *rtwvif_link, bool en)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
-	u8 mac_idx = rtwvif->mac_idx;
+	u8 mac_idx = rtwvif_link->mac_idx;
 	u16 set = mac->muedca_ctrl.mask;
 	u32 reg;
 	u32 ret;
@@ -6334,15 +6348,15 @@ void rtw89_mac_pkt_drop_sta(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta)
 		RTW89_PKT_DROP_SEL_MACID_VI_ONCE,
 		RTW89_PKT_DROP_SEL_MACID_VO_ONCE,
 	};
-	struct rtw89_vif *rtwvif = rtwsta->rtwvif;
+	struct rtw89_vif_link *rtwvif_link = rtwsta->rtwvif_link;
 	struct rtw89_pkt_drop_params params = {0};
 	int i;
 
 	params.mac_band = RTW89_MAC_0;
 	params.macid = rtwsta->mac_id;
-	params.port = rtwvif->port;
+	params.port = rtwvif_link->port;
 	params.mbssid = 0;
-	params.tf_trs = rtwvif->trigger;
+	params.tf_trs = rtwvif_link->trigger;
 
 	for (i = 0; i < ARRAY_SIZE(sels); i++) {
 		params.sel = sels[i];
@@ -6353,21 +6367,21 @@ void rtw89_mac_pkt_drop_sta(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta)
 static void rtw89_mac_pkt_drop_vif_iter(void *data, struct ieee80211_sta *sta)
 {
 	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
-	struct rtw89_vif *rtwvif = rtwsta->rtwvif;
-	struct rtw89_dev *rtwdev = rtwvif->rtwdev;
-	struct rtw89_vif *target = data;
+	struct rtw89_vif_link *rtwvif_link = rtwsta->rtwvif_link;
+	struct rtw89_dev *rtwdev = rtwvif_link->rtwdev;
+	struct rtw89_vif_link *target = data;
 
-	if (rtwvif != target)
+	if (rtwvif_link != target)
 		return;
 
 	rtw89_mac_pkt_drop_sta(rtwdev, rtwsta);
 }
 
-void rtw89_mac_pkt_drop_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+void rtw89_mac_pkt_drop_vif(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link)
 {
 	ieee80211_iterate_stations_atomic(rtwdev->hw,
 					  rtw89_mac_pkt_drop_vif_iter,
-					  rtwvif);
+					  rtwvif_link);
 }
 
 int rtw89_mac_ptk_drop_by_band_and_wait(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 67c2a4507124..6839028991d4 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1004,12 +1004,12 @@ struct rtw89_mac_gen_def {
 	bool (*is_txq_empty)(struct rtw89_dev *rtwdev);
 
 	int (*add_chan_list)(struct rtw89_dev *rtwdev,
-			     struct rtw89_vif *rtwvif, bool connected);
+			     struct rtw89_vif_link *rtwvif_link, bool connected);
 	int (*add_chan_list_pno)(struct rtw89_dev *rtwdev,
-				 struct rtw89_vif *rtwvif);
+				 struct rtw89_vif_link *rtwvif_link);
 	int (*scan_offload)(struct rtw89_dev *rtwdev,
 			    struct rtw89_scan_option *option,
-			    struct rtw89_vif *rtwvif,
+			    struct rtw89_vif_link *rtwvif_link,
 			    bool wowlan);
 
 	int (*wow_config_mac)(struct rtw89_dev *rtwdev, bool enable_wow);
@@ -1033,81 +1033,89 @@ u32 rtw89_mac_reg_by_port(struct rtw89_dev *rtwdev, u32 base, u8 port, u8 mac_id
 }
 
 static inline u32
-rtw89_read32_port(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif, u32 base)
+rtw89_read32_port(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link, u32 base)
 {
 	u32 reg;
 
-	reg = rtw89_mac_reg_by_port(rtwdev, base, rtwvif->port, rtwvif->mac_idx);
+	reg = rtw89_mac_reg_by_port(rtwdev, base, rtwvif_link->port,
+				    rtwvif_link->mac_idx);
 	return rtw89_read32(rtwdev, reg);
 }
 
 static inline u32
-rtw89_read32_port_mask(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+rtw89_read32_port_mask(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
 		       u32 base, u32 mask)
 {
 	u32 reg;
 
-	reg = rtw89_mac_reg_by_port(rtwdev, base, rtwvif->port, rtwvif->mac_idx);
+	reg = rtw89_mac_reg_by_port(rtwdev, base, rtwvif_link->port,
+				    rtwvif_link->mac_idx);
 	return rtw89_read32_mask(rtwdev, reg, mask);
 }
 
 static inline void
-rtw89_write32_port(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif, u32 base,
+rtw89_write32_port(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link, u32 base,
 		   u32 data)
 {
 	u32 reg;
 
-	reg = rtw89_mac_reg_by_port(rtwdev, base, rtwvif->port, rtwvif->mac_idx);
+	reg = rtw89_mac_reg_by_port(rtwdev, base, rtwvif_link->port,
+				    rtwvif_link->mac_idx);
 	rtw89_write32(rtwdev, reg, data);
 }
 
 static inline void
-rtw89_write32_port_mask(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+rtw89_write32_port_mask(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
 			u32 base, u32 mask, u32 data)
 {
 	u32 reg;
 
-	reg = rtw89_mac_reg_by_port(rtwdev, base, rtwvif->port, rtwvif->mac_idx);
+	reg = rtw89_mac_reg_by_port(rtwdev, base, rtwvif_link->port,
+				    rtwvif_link->mac_idx);
 	rtw89_write32_mask(rtwdev, reg, mask, data);
 }
 
 static inline void
-rtw89_write16_port_mask(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+rtw89_write16_port_mask(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
 			u32 base, u32 mask, u16 data)
 {
 	u32 reg;
 
-	reg = rtw89_mac_reg_by_port(rtwdev, base, rtwvif->port, rtwvif->mac_idx);
+	reg = rtw89_mac_reg_by_port(rtwdev, base, rtwvif_link->port,
+				    rtwvif_link->mac_idx);
 	rtw89_write16_mask(rtwdev, reg, mask, data);
 }
 
 static inline void
-rtw89_write32_port_clr(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+rtw89_write32_port_clr(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
 		       u32 base, u32 bit)
 {
 	u32 reg;
 
-	reg = rtw89_mac_reg_by_port(rtwdev, base, rtwvif->port, rtwvif->mac_idx);
+	reg = rtw89_mac_reg_by_port(rtwdev, base, rtwvif_link->port,
+				    rtwvif_link->mac_idx);
 	rtw89_write32_clr(rtwdev, reg, bit);
 }
 
 static inline void
-rtw89_write16_port_clr(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+rtw89_write16_port_clr(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
 		       u32 base, u16 bit)
 {
 	u32 reg;
 
-	reg = rtw89_mac_reg_by_port(rtwdev, base, rtwvif->port, rtwvif->mac_idx);
+	reg = rtw89_mac_reg_by_port(rtwdev, base, rtwvif_link->port,
+				    rtwvif_link->mac_idx);
 	rtw89_write16_clr(rtwdev, reg, bit);
 }
 
 static inline void
-rtw89_write32_port_set(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+rtw89_write32_port_set(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
 		       u32 base, u32 bit)
 {
 	u32 reg;
 
-	reg = rtw89_mac_reg_by_port(rtwdev, base, rtwvif->port, rtwvif->mac_idx);
+	reg = rtw89_mac_reg_by_port(rtwdev, base, rtwvif_link->port,
+				    rtwvif_link->mac_idx);
 	rtw89_write32_set(rtwdev, reg, bit);
 }
 
@@ -1139,21 +1147,21 @@ int rtw89_mac_dle_dfi_qempty_cfg(struct rtw89_dev *rtwdev,
 				 struct rtw89_mac_dle_dfi_qempty *qempty);
 void rtw89_mac_dump_l0_to_l1(struct rtw89_dev *rtwdev,
 			     enum mac_ax_err_info err);
-int rtw89_mac_add_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *vif);
-int rtw89_mac_port_update(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
+int rtw89_mac_add_vif(struct rtw89_dev *rtwdev, struct rtw89_vif_link *vif);
+int rtw89_mac_port_update(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link);
 void rtw89_mac_port_tsf_sync(struct rtw89_dev *rtwdev,
-			     struct rtw89_vif *rtwvif,
-			     struct rtw89_vif *rtwvif_src,
+			     struct rtw89_vif_link *rtwvif_link,
+			     struct rtw89_vif_link *rtwvif_src,
 			     u16 offset_tu);
-int rtw89_mac_port_get_tsf(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+int rtw89_mac_port_get_tsf(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
 			   u64 *tsf);
 void rtw89_mac_port_cfg_rx_sync(struct rtw89_dev *rtwdev,
-				struct rtw89_vif *rtwvif, bool en);
+				struct rtw89_vif_link *rtwvif_link, bool en);
 void rtw89_mac_set_he_obss_narrow_bw_ru(struct rtw89_dev *rtwdev,
 					struct ieee80211_vif *vif);
-void rtw89_mac_stop_ap(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
+void rtw89_mac_stop_ap(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link);
 void rtw89_mac_enable_beacon_for_ap_vifs(struct rtw89_dev *rtwdev, bool en);
-int rtw89_mac_remove_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *vif);
+int rtw89_mac_remove_vif(struct rtw89_dev *rtwdev, struct rtw89_vif_link *vif);
 int rtw89_mac_enable_bb_rf(struct rtw89_dev *rtwdev);
 int rtw89_mac_disable_bb_rf(struct rtw89_dev *rtwdev);
 
@@ -1268,10 +1276,10 @@ void rtw89_mac_bf_monitor_calc(struct rtw89_dev *rtwdev,
 			       struct ieee80211_sta *sta, bool disconnect);
 void _rtw89_mac_bf_monitor_track(struct rtw89_dev *rtwdev);
 void rtw89_mac_bfee_ctrl(struct rtw89_dev *rtwdev, u8 mac_idx, bool en);
-int rtw89_mac_vif_init(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
-int rtw89_mac_vif_deinit(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
+int rtw89_mac_vif_init(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link);
+int rtw89_mac_vif_deinit(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link);
 int rtw89_mac_set_hw_muedca_ctrl(struct rtw89_dev *rtwdev,
-				 struct rtw89_vif *rtwvif, bool en);
+				 struct rtw89_vif_link *rtwvif_link, bool en);
 int rtw89_mac_set_macid_pause(struct rtw89_dev *rtwdev, u8 macid, bool pause);
 
 static inline void rtw89_mac_bf_monitor_track(struct rtw89_dev *rtwdev)
@@ -1454,7 +1462,7 @@ int rtw89_mac_read_xtal_si(struct rtw89_dev *rtwdev, u8 offset, u8 *val)
 	return mac->read_xtal_si(rtwdev, offset, val);
 }
 
-void rtw89_mac_pkt_drop_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
+void rtw89_mac_pkt_drop_vif(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link);
 int rtw89_mac_resize_ple_rx_quota(struct rtw89_dev *rtwdev, bool wow);
 int rtw89_mac_ptk_drop_by_band_and_wait(struct rtw89_dev *rtwdev,
 					enum rtw89_mac_idx band);
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 48ad0d0f76bf..bc0ff64c1c98 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -23,12 +23,12 @@ static void rtw89_ops_tx(struct ieee80211_hw *hw,
 	struct rtw89_dev *rtwdev = hw->priv;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_vif *vif = info->control.vif;
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 	struct ieee80211_sta *sta = control->sta;
 	u32 flags = IEEE80211_SKB_CB(skb)->flags;
 	int ret, qsel;
 
-	if (rtwvif->offchan && !(flags & IEEE80211_TX_CTL_TX_OFFCHAN) && sta) {
+	if (rtwvif_link->offchan && !(flags & IEEE80211_TX_CTL_TX_OFFCHAN) && sta) {
 		struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
 
 		rtw89_debug(rtwdev, RTW89_DBG_TXRX, "ops_tx during offchan\n");
@@ -109,7 +109,7 @@ static int rtw89_ops_add_interface(struct ieee80211_hw *hw,
 				   struct ieee80211_vif *vif)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 	int ret = 0;
 
 	rtw89_debug(rtwdev, RTW89_DBG_STATE, "add vif %pM type %d, p2p %d\n",
@@ -123,46 +123,46 @@ static int rtw89_ops_add_interface(struct ieee80211_hw *hw,
 		vif->driver_flags |= IEEE80211_VIF_BEACON_FILTER |
 				     IEEE80211_VIF_SUPPORTS_CQM_RSSI;
 
-	rtwvif->rtwdev = rtwdev;
-	rtwvif->roc.state = RTW89_ROC_IDLE;
-	rtwvif->offchan = false;
-	if (!rtw89_rtwvif_in_list(rtwdev, rtwvif))
-		list_add_tail(&rtwvif->list, &rtwdev->rtwvifs_list);
+	rtwvif_link->rtwdev = rtwdev;
+	rtwvif_link->roc.state = RTW89_ROC_IDLE;
+	rtwvif_link->offchan = false;
+	if (!rtw89_rtwvif_in_list(rtwdev, rtwvif_link))
+		list_add_tail(&rtwvif_link->list, &rtwdev->rtwvifs_list);
 
-	INIT_WORK(&rtwvif->update_beacon_work, rtw89_core_update_beacon_work);
-	INIT_DELAYED_WORK(&rtwvif->roc.roc_work, rtw89_roc_work);
+	INIT_WORK(&rtwvif_link->update_beacon_work, rtw89_core_update_beacon_work);
+	INIT_DELAYED_WORK(&rtwvif_link->roc.roc_work, rtw89_roc_work);
 	rtw89_leave_ps_mode(rtwdev);
 
-	rtw89_traffic_stats_init(rtwdev, &rtwvif->stats);
+	rtw89_traffic_stats_init(rtwdev, &rtwvif_link->stats);
 	rtw89_vif_type_mapping(vif, false);
-	rtwvif->port = rtw89_core_acquire_bit_map(rtwdev->hw_port,
-						  RTW89_PORT_NUM);
-	if (rtwvif->port == RTW89_PORT_NUM) {
+	rtwvif_link->port = rtw89_core_acquire_bit_map(rtwdev->hw_port,
+						       RTW89_PORT_NUM);
+	if (rtwvif_link->port == RTW89_PORT_NUM) {
 		ret = -ENOSPC;
-		list_del_init(&rtwvif->list);
+		list_del_init(&rtwvif_link->list);
 		goto out;
 	}
 
-	rtwvif->bcn_hit_cond = 0;
-	rtwvif->mac_idx = RTW89_MAC_0;
-	rtwvif->phy_idx = RTW89_PHY_0;
-	rtwvif->chanctx_idx = RTW89_CHANCTX_0;
-	rtwvif->chanctx_assigned = false;
-	rtwvif->hit_rule = 0;
-	rtwvif->reg_6ghz_power = RTW89_REG_6GHZ_POWER_DFLT;
-	ether_addr_copy(rtwvif->mac_addr, vif->addr);
-	INIT_LIST_HEAD(&rtwvif->general_pkt_list);
-
-	ret = rtw89_mac_add_vif(rtwdev, rtwvif);
+	rtwvif_link->bcn_hit_cond = 0;
+	rtwvif_link->mac_idx = RTW89_MAC_0;
+	rtwvif_link->phy_idx = RTW89_PHY_0;
+	rtwvif_link->chanctx_idx = RTW89_CHANCTX_0;
+	rtwvif_link->chanctx_assigned = false;
+	rtwvif_link->hit_rule = 0;
+	rtwvif_link->reg_6ghz_power = RTW89_REG_6GHZ_POWER_DFLT;
+	ether_addr_copy(rtwvif_link->mac_addr, vif->addr);
+	INIT_LIST_HEAD(&rtwvif_link->general_pkt_list);
+
+	ret = rtw89_mac_add_vif(rtwdev, rtwvif_link);
 	if (ret) {
-		rtw89_core_release_bit_map(rtwdev->hw_port, rtwvif->port);
-		list_del_init(&rtwvif->list);
+		rtw89_core_release_bit_map(rtwdev->hw_port, rtwvif_link->port);
+		list_del_init(&rtwvif_link->list);
 		goto out;
 	}
 
 	rtw89_core_txq_init(rtwdev, vif->txq);
 
-	rtw89_btc_ntfy_role_info(rtwdev, rtwvif, NULL, BTC_ROLE_START);
+	rtw89_btc_ntfy_role_info(rtwdev, rtwvif_link, NULL, BTC_ROLE_START);
 
 	rtw89_recalc_lps(rtwdev);
 out:
@@ -175,20 +175,20 @@ static void rtw89_ops_remove_interface(struct ieee80211_hw *hw,
 				       struct ieee80211_vif *vif)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 
 	rtw89_debug(rtwdev, RTW89_DBG_STATE, "remove vif %pM type %d p2p %d\n",
 		    vif->addr, vif->type, vif->p2p);
 
-	cancel_work_sync(&rtwvif->update_beacon_work);
-	cancel_delayed_work_sync(&rtwvif->roc.roc_work);
+	cancel_work_sync(&rtwvif_link->update_beacon_work);
+	cancel_delayed_work_sync(&rtwvif_link->roc.roc_work);
 
 	mutex_lock(&rtwdev->mutex);
 	rtw89_leave_ps_mode(rtwdev);
-	rtw89_btc_ntfy_role_info(rtwdev, rtwvif, NULL, BTC_ROLE_STOP);
-	rtw89_mac_remove_vif(rtwdev, rtwvif);
-	rtw89_core_release_bit_map(rtwdev->hw_port, rtwvif->port);
-	list_del_init(&rtwvif->list);
+	rtw89_btc_ntfy_role_info(rtwdev, rtwvif_link, NULL, BTC_ROLE_STOP);
+	rtw89_mac_remove_vif(rtwdev, rtwvif_link);
+	rtw89_core_release_bit_map(rtwdev->hw_port, rtwvif_link->port);
+	list_del_init(&rtwvif_link->list);
 	rtw89_recalc_lps(rtwdev);
 	rtw89_enter_ips_by_hwflags(rtwdev);
 
@@ -311,11 +311,11 @@ static const u8 ac_to_fw_idx[IEEE80211_NUM_ACS] = {
 };
 
 static u8 rtw89_aifsn_to_aifs(struct rtw89_dev *rtwdev,
-			      struct rtw89_vif *rtwvif, u8 aifsn)
+			      struct rtw89_vif_link *rtwvif_link, u8 aifsn)
 {
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
-						       rtwvif->chanctx_idx);
+						       rtwvif_link->chanctx_idx);
 	u8 slot_time;
 	u8 sifs;
 
@@ -326,9 +326,9 @@ static u8 rtw89_aifsn_to_aifs(struct rtw89_dev *rtwdev,
 }
 
 static void ____rtw89_conf_tx_edca(struct rtw89_dev *rtwdev,
-				   struct rtw89_vif *rtwvif, u16 ac)
+				   struct rtw89_vif_link *rtwvif_link, u16 ac)
 {
-	struct ieee80211_tx_queue_params *params = &rtwvif->tx_params[ac];
+	struct ieee80211_tx_queue_params *params = &rtwvif_link->tx_params[ac];
 	u32 val;
 	u8 ecw_max, ecw_min;
 	u8 aifs;
@@ -336,12 +336,12 @@ static void ____rtw89_conf_tx_edca(struct rtw89_dev *rtwdev,
 	/* 2^ecw - 1 = cw; ecw = log2(cw + 1) */
 	ecw_max = ilog2(params->cw_max + 1);
 	ecw_min = ilog2(params->cw_min + 1);
-	aifs = rtw89_aifsn_to_aifs(rtwdev, rtwvif, params->aifs);
+	aifs = rtw89_aifsn_to_aifs(rtwdev, rtwvif_link, params->aifs);
 	val = FIELD_PREP(FW_EDCA_PARAM_TXOPLMT_MSK, params->txop) |
 	      FIELD_PREP(FW_EDCA_PARAM_CWMAX_MSK, ecw_max) |
 	      FIELD_PREP(FW_EDCA_PARAM_CWMIN_MSK, ecw_min) |
 	      FIELD_PREP(FW_EDCA_PARAM_AIFS_MSK, aifs);
-	rtw89_fw_h2c_set_edca(rtwdev, rtwvif, ac_to_fw_idx[ac], val);
+	rtw89_fw_h2c_set_edca(rtwdev, rtwvif_link, ac_to_fw_idx[ac], val);
 }
 
 #define R_MUEDCA_ACS_PARAM(acs) {R_AX_MUEDCA_ ## acs ## _PARAM_0, \
@@ -355,9 +355,9 @@ static const u32 ac_to_mu_edca_param[IEEE80211_NUM_ACS][RTW89_CHIP_GEN_NUM] = {
 };
 
 static void ____rtw89_conf_tx_mu_edca(struct rtw89_dev *rtwdev,
-				      struct rtw89_vif *rtwvif, u16 ac)
+				      struct rtw89_vif_link *rtwvif_link, u16 ac)
 {
-	struct ieee80211_tx_queue_params *params = &rtwvif->tx_params[ac];
+	struct ieee80211_tx_queue_params *params = &rtwvif_link->tx_params[ac];
 	struct ieee80211_he_mu_edca_param_ac_rec *mu_edca;
 	int gen = rtwdev->chip->chip_gen;
 	u8 aifs, aifsn;
@@ -370,32 +370,33 @@ static void ____rtw89_conf_tx_mu_edca(struct rtw89_dev *rtwdev,
 
 	mu_edca = &params->mu_edca_param_rec;
 	aifsn = FIELD_GET(GENMASK(3, 0), mu_edca->aifsn);
-	aifs = aifsn ? rtw89_aifsn_to_aifs(rtwdev, rtwvif, aifsn) : 0;
+	aifs = aifsn ? rtw89_aifsn_to_aifs(rtwdev, rtwvif_link, aifsn) : 0;
 	timer_32us = mu_edca->mu_edca_timer << 8;
 
 	val = FIELD_PREP(B_AX_MUEDCA_BE_PARAM_0_TIMER_MASK, timer_32us) |
 	      FIELD_PREP(B_AX_MUEDCA_BE_PARAM_0_CW_MASK, mu_edca->ecw_min_max) |
 	      FIELD_PREP(B_AX_MUEDCA_BE_PARAM_0_AIFS_MASK, aifs);
-	reg = rtw89_mac_reg_by_idx(rtwdev, ac_to_mu_edca_param[ac][gen], rtwvif->mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, ac_to_mu_edca_param[ac][gen],
+				   rtwvif_link->mac_idx);
 	rtw89_write32(rtwdev, reg, val);
 
-	rtw89_mac_set_hw_muedca_ctrl(rtwdev, rtwvif, true);
+	rtw89_mac_set_hw_muedca_ctrl(rtwdev, rtwvif_link, true);
 }
 
 static void __rtw89_conf_tx(struct rtw89_dev *rtwdev,
-			    struct rtw89_vif *rtwvif, u16 ac)
+			    struct rtw89_vif_link *rtwvif_link, u16 ac)
 {
-	____rtw89_conf_tx_edca(rtwdev, rtwvif, ac);
-	____rtw89_conf_tx_mu_edca(rtwdev, rtwvif, ac);
+	____rtw89_conf_tx_edca(rtwdev, rtwvif_link, ac);
+	____rtw89_conf_tx_mu_edca(rtwdev, rtwvif_link, ac);
 }
 
 static void rtw89_conf_tx(struct rtw89_dev *rtwdev,
-			  struct rtw89_vif *rtwvif)
+			  struct rtw89_vif_link *rtwvif_link)
 {
 	u16 ac;
 
 	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++)
-		__rtw89_conf_tx(rtwdev, rtwvif, ac);
+		__rtw89_conf_tx(rtwdev, rtwvif_link, ac);
 }
 
 static void rtw89_station_mode_sta_assoc(struct rtw89_dev *rtwdev,
@@ -421,7 +422,7 @@ static void rtw89_ops_vif_cfg_changed(struct ieee80211_hw *hw,
 				      struct ieee80211_vif *vif, u64 changed)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 
 	mutex_lock(&rtwdev->mutex);
 	rtw89_leave_ps_mode(rtwdev);
@@ -431,7 +432,7 @@ static void rtw89_ops_vif_cfg_changed(struct ieee80211_hw *hw,
 			rtw89_station_mode_sta_assoc(rtwdev, vif);
 			rtw89_phy_set_bss_color(rtwdev, vif);
 			rtw89_chip_cfg_txpwr_ul_tb_offset(rtwdev, vif);
-			rtw89_mac_port_update(rtwdev, rtwvif);
+			rtw89_mac_port_update(rtwdev, rtwvif_link);
 			rtw89_mac_set_he_obss_narrow_bw_ru(rtwdev, vif);
 
 			rtw89_queue_chanctx_work(rtwdev);
@@ -448,7 +449,7 @@ static void rtw89_ops_vif_cfg_changed(struct ieee80211_hw *hw,
 		rtw89_recalc_lps(rtwdev);
 
 	if (changed & BSS_CHANGED_ARP_FILTER)
-		rtwvif->ip_addr = vif->cfg.arp_addr_list[0];
+		rtwvif_link->ip_addr = vif->cfg.arp_addr_list[0];
 
 	mutex_unlock(&rtwdev->mutex);
 }
@@ -459,23 +460,23 @@ static void rtw89_ops_link_info_changed(struct ieee80211_hw *hw,
 					u64 changed)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 
 	mutex_lock(&rtwdev->mutex);
 	rtw89_leave_ps_mode(rtwdev);
 
 	if (changed & BSS_CHANGED_BSSID) {
-		ether_addr_copy(rtwvif->bssid, conf->bssid);
-		rtw89_cam_bssid_changed(rtwdev, rtwvif);
-		rtw89_fw_h2c_cam(rtwdev, rtwvif, NULL, NULL);
-		WRITE_ONCE(rtwvif->sync_bcn_tsf, 0);
+		ether_addr_copy(rtwvif_link->bssid, conf->bssid);
+		rtw89_cam_bssid_changed(rtwdev, rtwvif_link);
+		rtw89_fw_h2c_cam(rtwdev, rtwvif_link, NULL, NULL);
+		WRITE_ONCE(rtwvif_link->sync_bcn_tsf, 0);
 	}
 
 	if (changed & BSS_CHANGED_BEACON)
-		rtw89_chip_h2c_update_beacon(rtwdev, rtwvif);
+		rtw89_chip_h2c_update_beacon(rtwdev, rtwvif_link);
 
 	if (changed & BSS_CHANGED_ERP_SLOT)
-		rtw89_conf_tx(rtwdev, rtwvif);
+		rtw89_conf_tx(rtwdev, rtwvif_link);
 
 	if (changed & BSS_CHANGED_HE_BSS_COLOR)
 		rtw89_phy_set_bss_color(rtwdev, vif);
@@ -490,7 +491,7 @@ static void rtw89_ops_link_info_changed(struct ieee80211_hw *hw,
 		rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, vif, true);
 
 	if (changed & BSS_CHANGED_TPE)
-		rtw89_reg_6ghz_recalc(rtwdev, rtwvif, true);
+		rtw89_reg_6ghz_recalc(rtwdev, rtwvif_link, true);
 
 	mutex_unlock(&rtwdev->mutex);
 }
@@ -500,12 +501,12 @@ static int rtw89_ops_start_ap(struct ieee80211_hw *hw,
 			      struct ieee80211_bss_conf *link_conf)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 	const struct rtw89_chan *chan;
 
 	mutex_lock(&rtwdev->mutex);
 
-	chan = rtw89_chan_get(rtwdev, rtwvif->chanctx_idx);
+	chan = rtw89_chan_get(rtwdev, rtwvif_link->chanctx_idx);
 	if (chan->band_type == RTW89_BAND_6G) {
 		mutex_unlock(&rtwdev->mutex);
 		return -EOPNOTSUPP;
@@ -514,14 +515,14 @@ static int rtw89_ops_start_ap(struct ieee80211_hw *hw,
 	if (rtwdev->scanning)
 		rtw89_hw_scan_abort(rtwdev, rtwdev->scan_info.scanning_vif);
 
-	ether_addr_copy(rtwvif->bssid, vif->bss_conf.bssid);
-	rtw89_cam_bssid_changed(rtwdev, rtwvif);
-	rtw89_mac_port_update(rtwdev, rtwvif);
+	ether_addr_copy(rtwvif_link->bssid, vif->bss_conf.bssid);
+	rtw89_cam_bssid_changed(rtwdev, rtwvif_link);
+	rtw89_mac_port_update(rtwdev, rtwvif_link);
 	rtw89_chip_h2c_assoc_cmac_tbl(rtwdev, vif, NULL);
-	rtw89_fw_h2c_role_maintain(rtwdev, rtwvif, NULL, RTW89_ROLE_TYPE_CHANGE);
-	rtw89_fw_h2c_join_info(rtwdev, rtwvif, NULL, true);
-	rtw89_fw_h2c_cam(rtwdev, rtwvif, NULL, NULL);
-	rtw89_chip_rfk_channel(rtwdev, rtwvif);
+	rtw89_fw_h2c_role_maintain(rtwdev, rtwvif_link, NULL, RTW89_ROLE_TYPE_CHANGE);
+	rtw89_fw_h2c_join_info(rtwdev, rtwvif_link, NULL, true);
+	rtw89_fw_h2c_cam(rtwdev, rtwvif_link, NULL, NULL);
+	rtw89_chip_rfk_channel(rtwdev, rtwvif_link);
 
 	rtw89_queue_chanctx_work(rtwdev);
 	mutex_unlock(&rtwdev->mutex);
@@ -534,12 +535,12 @@ void rtw89_ops_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		       struct ieee80211_bss_conf *link_conf)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 
 	mutex_lock(&rtwdev->mutex);
-	rtw89_mac_stop_ap(rtwdev, rtwvif);
+	rtw89_mac_stop_ap(rtwdev, rtwvif_link);
 	rtw89_chip_h2c_assoc_cmac_tbl(rtwdev, vif, NULL);
-	rtw89_fw_h2c_join_info(rtwdev, rtwvif, NULL, true);
+	rtw89_fw_h2c_join_info(rtwdev, rtwvif_link, NULL, true);
 	mutex_unlock(&rtwdev->mutex);
 }
 
@@ -548,9 +549,9 @@ static int rtw89_ops_set_tim(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
 {
 	struct rtw89_dev *rtwdev = hw->priv;
 	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
-	struct rtw89_vif *rtwvif = rtwsta->rtwvif;
+	struct rtw89_vif_link *rtwvif_link = rtwsta->rtwvif_link;
 
-	ieee80211_queue_work(rtwdev->hw, &rtwvif->update_beacon_work);
+	ieee80211_queue_work(rtwdev->hw, &rtwvif_link->update_beacon_work);
 
 	return 0;
 }
@@ -561,12 +562,12 @@ static int rtw89_ops_conf_tx(struct ieee80211_hw *hw,
 			     const struct ieee80211_tx_queue_params *params)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 
 	mutex_lock(&rtwdev->mutex);
 	rtw89_leave_ps_mode(rtwdev);
-	rtwvif->tx_params[ac] = *params;
-	__rtw89_conf_tx(rtwdev, rtwvif, ac);
+	rtwvif_link->tx_params[ac] = *params;
+	__rtw89_conf_tx(rtwdev, rtwvif_link, ac);
 	mutex_unlock(&rtwdev->mutex);
 
 	return 0;
@@ -740,14 +741,14 @@ static void rtw89_ops_sta_statistics(struct ieee80211_hw *hw,
 static
 void __rtw89_drop_packets(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif)
 {
-	struct rtw89_vif *rtwvif;
+	struct rtw89_vif_link *rtwvif_link;
 
 	if (vif) {
-		rtwvif = (struct rtw89_vif *)vif->drv_priv;
-		rtw89_mac_pkt_drop_vif(rtwdev, rtwvif);
+		rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
+		rtw89_mac_pkt_drop_vif(rtwdev, rtwvif_link);
 	} else {
-		rtw89_for_each_rtwvif(rtwdev, rtwvif)
-			rtw89_mac_pkt_drop_vif(rtwdev, rtwvif);
+		rtw89_for_each_rtwvif(rtwdev, rtwvif_link)
+			rtw89_mac_pkt_drop_vif(rtwdev, rtwvif_link);
 	}
 }
 
@@ -778,7 +779,7 @@ static void rtw89_ra_mask_info_update_iter(void *data, struct ieee80211_sta *sta
 {
 	struct rtw89_iter_bitrate_mask_data *br_data = data;
 	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwsta->rtwvif);
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwsta->rtwvif_link);
 
 	if (vif != br_data->vif || vif->p2p)
 		return;
@@ -854,10 +855,10 @@ static void rtw89_ops_sw_scan_start(struct ieee80211_hw *hw,
 				    const u8 *mac_addr)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 
 	mutex_lock(&rtwdev->mutex);
-	rtw89_core_scan_start(rtwdev, rtwvif, mac_addr, false);
+	rtw89_core_scan_start(rtwdev, rtwvif_link, mac_addr, false);
 	mutex_unlock(&rtwdev->mutex);
 }
 
@@ -884,13 +885,13 @@ static int rtw89_ops_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			     struct ieee80211_scan_request *req)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
-	struct rtw89_vif *rtwvif = vif_to_rtwvif_safe(vif);
+	struct rtw89_vif_link *rtwvif_link = vif_to_rtwvif_safe(vif);
 	int ret = 0;
 
 	if (!RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD, &rtwdev->fw))
 		return 1;
 
-	if (rtwdev->scanning || rtwvif->offchan)
+	if (rtwdev->scanning || rtwvif_link->offchan)
 		return -EBUSY;
 
 	mutex_lock(&rtwdev->mutex);
@@ -970,11 +971,11 @@ static int rtw89_ops_assign_vif_chanctx(struct ieee80211_hw *hw,
 					struct ieee80211_chanctx_conf *ctx)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 	int ret;
 
 	mutex_lock(&rtwdev->mutex);
-	ret = rtw89_chanctx_ops_assign_vif(rtwdev, rtwvif, ctx);
+	ret = rtw89_chanctx_ops_assign_vif(rtwdev, rtwvif_link, ctx);
 	mutex_unlock(&rtwdev->mutex);
 
 	return ret;
@@ -986,10 +987,10 @@ static void rtw89_ops_unassign_vif_chanctx(struct ieee80211_hw *hw,
 					   struct ieee80211_chanctx_conf *ctx)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 
 	mutex_lock(&rtwdev->mutex);
-	rtw89_chanctx_ops_unassign_vif(rtwdev, rtwvif, ctx);
+	rtw89_chanctx_ops_unassign_vif(rtwdev, rtwvif_link, ctx);
 	mutex_unlock(&rtwdev->mutex);
 }
 
@@ -1000,8 +1001,8 @@ static int rtw89_ops_remain_on_channel(struct ieee80211_hw *hw,
 				       enum ieee80211_roc_type type)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
-	struct rtw89_vif *rtwvif = vif_to_rtwvif_safe(vif);
-	struct rtw89_roc *roc = &rtwvif->roc;
+	struct rtw89_vif_link *rtwvif_link = vif_to_rtwvif_safe(vif);
+	struct rtw89_roc *roc = &rtwvif_link->roc;
 
 	if (!vif)
 		return -EINVAL;
@@ -1025,7 +1026,7 @@ static int rtw89_ops_remain_on_channel(struct ieee80211_hw *hw,
 	roc->chan = *chan;
 	roc->type = type;
 
-	rtw89_roc_start(rtwdev, rtwvif);
+	rtw89_roc_start(rtwdev, rtwvif_link);
 
 	mutex_unlock(&rtwdev->mutex);
 
@@ -1036,15 +1037,15 @@ static int rtw89_ops_cancel_remain_on_channel(struct ieee80211_hw *hw,
 					      struct ieee80211_vif *vif)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
-	struct rtw89_vif *rtwvif = vif_to_rtwvif_safe(vif);
+	struct rtw89_vif_link *rtwvif_link = vif_to_rtwvif_safe(vif);
 
-	if (!rtwvif)
+	if (!rtwvif_link)
 		return -EINVAL;
 
-	cancel_delayed_work_sync(&rtwvif->roc.roc_work);
+	cancel_delayed_work_sync(&rtwvif_link->roc.roc_work);
 
 	mutex_lock(&rtwdev->mutex);
-	rtw89_roc_end(rtwdev, rtwvif);
+	rtw89_roc_end(rtwdev, rtwvif_link);
 	mutex_unlock(&rtwdev->mutex);
 
 	return 0;
@@ -1054,7 +1055,7 @@ static void rtw89_set_tid_config_iter(void *data, struct ieee80211_sta *sta)
 {
 	struct cfg80211_tid_config *tid_config = data;
 	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
-	struct rtw89_dev *rtwdev = rtwsta->rtwvif->rtwdev;
+	struct rtw89_dev *rtwdev = rtwsta->rtwvif_link->rtwdev;
 
 	rtw89_core_set_tid_config(rtwdev, sta, tid_config);
 }
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 31f0a5225b11..bc3215939f37 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -2094,10 +2094,10 @@ static int rtw89_mac_set_csi_para_reg_be(struct rtw89_dev *rtwdev,
 					 struct ieee80211_vif *vif,
 					 struct ieee80211_sta *sta)
 {
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 	u8 nc = 1, nr = 3, ng = 0, cb = 1, cs = 1, ldpc_en = 1, stbc_en = 1;
-	u8 mac_idx = rtwvif->mac_idx;
-	u8 port_sel = rtwvif->port;
+	u8 mac_idx = rtwvif_link->mac_idx;
+	u8 port_sel = rtwvif_link->port;
 	u8 sound_dim = 3, t;
 	u8 *phy_cap;
 	u32 reg;
@@ -2158,9 +2158,9 @@ static int rtw89_mac_csi_rrsc_be(struct rtw89_dev *rtwdev,
 				 struct ieee80211_vif *vif,
 				 struct ieee80211_sta *sta)
 {
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 	u32 rrsc = BIT(RTW89_MAC_BF_RRSC_6M) | BIT(RTW89_MAC_BF_RRSC_24M);
-	u8 mac_idx = rtwvif->mac_idx;
+	u8 mac_idx = rtwvif_link->mac_idx;
 	int ret;
 	u32 reg;
 
@@ -2198,12 +2198,12 @@ static void rtw89_mac_bf_assoc_be(struct rtw89_dev *rtwdev,
 				  struct ieee80211_vif *vif,
 				  struct ieee80211_sta *sta)
 {
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 
 	if (rtw89_sta_has_beamformer_cap(sta)) {
 		rtw89_debug(rtwdev, RTW89_DBG_BF,
 			    "initialize bfee for new association\n");
-		rtw89_mac_init_bfee_be(rtwdev, rtwvif->mac_idx);
+		rtw89_mac_init_bfee_be(rtwdev, rtwvif_link->mac_idx);
 		rtw89_mac_set_csi_para_reg_be(rtwdev, vif, sta);
 		rtw89_mac_csi_rrsc_be(rtwdev, vif, sta);
 	}
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index c7165e757842..742720f1a429 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -298,12 +298,12 @@ static void rtw89_phy_ra_sta_update(struct rtw89_dev *rtwdev,
 				    struct ieee80211_sta *sta, bool csi)
 {
 	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
-	struct rtw89_vif *rtwvif = rtwsta->rtwvif;
-	struct rtw89_phy_rate_pattern *rate_pattern = &rtwvif->rate_pattern;
+	struct rtw89_vif_link *rtwvif_link = rtwsta->rtwvif_link;
+	struct rtw89_phy_rate_pattern *rate_pattern = &rtwvif_link->rate_pattern;
 	struct rtw89_ra_info *ra = &rtwsta->ra;
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
-						       rtwvif->chanctx_idx);
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwsta->rtwvif);
+						       rtwvif_link->chanctx_idx);
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwsta->rtwvif_link);
 	const u64 *high_rate_masks = rtw89_ra_mask_ht_rates;
 	u8 rssi = ewma_rssi_read(&rtwsta->avg_rssi);
 	u64 ra_mask = 0;
@@ -458,7 +458,7 @@ static void rtw89_phy_ra_sta_update(struct rtw89_dev *rtwdev,
 	ra->fixed_csi_rate_en = false;
 	ra->ra_csi_rate_en = true;
 	ra->cr_tbl_sel = false;
-	ra->band_num = rtwvif->phy_idx;
+	ra->band_num = rtwvif_link->phy_idx;
 	ra->csi_bw = bw_mode;
 	ra->csi_gi_ltf = RTW89_GILTF_LGI_4XHE32;
 	ra->csi_mcs_ss_idx = 5;
@@ -528,10 +528,10 @@ void rtw89_phy_rate_pattern_vif(struct rtw89_dev *rtwdev,
 				const struct cfg80211_bitrate_mask *mask)
 {
 	struct ieee80211_supported_band *sband;
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 	struct rtw89_phy_rate_pattern next_pattern = {0};
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
-						       rtwvif->chanctx_idx);
+						       rtwvif_link->chanctx_idx);
 	static const u16 hw_rate_he[][RTW89_CHIP_GEN_NUM] = {
 		RTW89_HW_RATE_BY_CHIP_GEN(HE_NSS1_MCS0),
 		RTW89_HW_RATE_BY_CHIP_GEN(HE_NSS2_MCS0),
@@ -600,7 +600,7 @@ void rtw89_phy_rate_pattern_vif(struct rtw89_dev *rtwdev,
 	if (!next_pattern.enable)
 		goto out;
 
-	rtwvif->rate_pattern = next_pattern;
+	rtwvif_link->rate_pattern = next_pattern;
 	rtw89_debug(rtwdev, RTW89_DBG_RA,
 		    "configure pattern: rate 0x%x, mask 0x%llx, mode 0x%x\n",
 		    next_pattern.rate,
@@ -609,7 +609,7 @@ void rtw89_phy_rate_pattern_vif(struct rtw89_dev *rtwdev,
 	return;
 
 out:
-	rtwvif->rate_pattern.enable = false;
+	rtwvif_link->rate_pattern.enable = false;
 	rtw89_debug(rtwdev, RTW89_DBG_RA, "unset rate pattern\n");
 }
 
@@ -4290,33 +4290,33 @@ void rtw89_phy_cfo_parse(struct rtw89_dev *rtwdev, s16 cfo_val,
 	cfo->packet_count++;
 }
 
-void rtw89_phy_ul_tb_assoc(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+void rtw89_phy_ul_tb_assoc(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
-						       rtwvif->chanctx_idx);
+						       rtwvif_link->chanctx_idx);
 	struct rtw89_phy_ul_tb_info *ul_tb_info = &rtwdev->ul_tb_info;
 
 	if (!chip->ul_tb_waveform_ctrl)
 		return;
 
-	rtwvif->def_tri_idx =
+	rtwvif_link->def_tri_idx =
 		rtw89_phy_read32_mask(rtwdev, R_DCFO_OPT, B_TXSHAPE_TRIANGULAR_CFG);
 
 	if (chip->chip_id == RTL8852B && rtwdev->hal.cv > CHIP_CBV)
-		rtwvif->dyn_tb_bedge_en = false;
+		rtwvif_link->dyn_tb_bedge_en = false;
 	else if (chan->band_type >= RTW89_BAND_5G &&
 		 chan->band_width >= RTW89_CHANNEL_WIDTH_40)
-		rtwvif->dyn_tb_bedge_en = true;
+		rtwvif_link->dyn_tb_bedge_en = true;
 	else
-		rtwvif->dyn_tb_bedge_en = false;
+		rtwvif_link->dyn_tb_bedge_en = false;
 
 	rtw89_debug(rtwdev, RTW89_DBG_UL_TB,
 		    "[ULTB] def_if_bandedge=%d, def_tri_idx=%d\n",
-		    ul_tb_info->def_if_bandedge, rtwvif->def_tri_idx);
+		    ul_tb_info->def_if_bandedge, rtwvif_link->def_tri_idx);
 	rtw89_debug(rtwdev, RTW89_DBG_UL_TB,
 		    "[ULTB] dyn_tb_begde_en=%d, dyn_tb_tri_en=%d\n",
-		    rtwvif->dyn_tb_bedge_en, ul_tb_info->dyn_tb_tri_en);
+		    rtwvif_link->dyn_tb_bedge_en, ul_tb_info->dyn_tb_tri_en);
 }
 
 struct rtw89_phy_ul_tb_check_data {
@@ -4338,7 +4338,7 @@ struct rtw89_phy_power_diff {
 };
 
 static void rtw89_phy_ofdma_power_diff(struct rtw89_dev *rtwdev,
-				       struct rtw89_vif *rtwvif)
+				       struct rtw89_vif_link *rtwvif_link)
 {
 	static const struct rtw89_phy_power_diff table[2] = {
 		{0x0, 0x0, 0x0, 0x0, 0xf4, 0x3, 0x3},
@@ -4350,13 +4350,13 @@ static void rtw89_phy_ofdma_power_diff(struct rtw89_dev *rtwdev,
 	if (!rtwdev->chip->ul_tb_pwr_diff)
 		return;
 
-	if (rtwvif->pwr_diff_en == rtwvif->pre_pwr_diff_en) {
-		rtwvif->pwr_diff_en = false;
+	if (rtwvif_link->pwr_diff_en == rtwvif_link->pre_pwr_diff_en) {
+		rtwvif_link->pwr_diff_en = false;
 		return;
 	}
 
-	rtwvif->pre_pwr_diff_en = rtwvif->pwr_diff_en;
-	param = &table[rtwvif->pwr_diff_en];
+	rtwvif_link->pre_pwr_diff_en = rtwvif_link->pwr_diff_en;
+	param = &table[rtwvif_link->pwr_diff_en];
 
 	rtw89_phy_write32_mask(rtwdev, R_Q_MATRIX_00, B_Q_MATRIX_00_REAL,
 			       param->q_00);
@@ -4365,32 +4365,32 @@ static void rtw89_phy_ofdma_power_diff(struct rtw89_dev *rtwdev,
 	rtw89_phy_write32_mask(rtwdev, R_CUSTOMIZE_Q_MATRIX,
 			       B_CUSTOMIZE_Q_MATRIX_EN, param->q_matrix_en);
 
-	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_PWR_UL_TB_1T, rtwvif->mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_PWR_UL_TB_1T, rtwvif_link->mac_idx);
 	rtw89_write32_mask(rtwdev, reg, B_AX_PWR_UL_TB_1T_NORM_BW160,
 			   param->ultb_1t_norm_160);
 
-	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_PWR_UL_TB_2T, rtwvif->mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_PWR_UL_TB_2T, rtwvif_link->mac_idx);
 	rtw89_write32_mask(rtwdev, reg, B_AX_PWR_UL_TB_2T_NORM_BW160,
 			   param->ultb_2t_norm_160);
 
-	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_PATH_COM1, rtwvif->mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_PATH_COM1, rtwvif_link->mac_idx);
 	rtw89_write32_mask(rtwdev, reg, B_AX_PATH_COM1_NORM_1STS,
 			   param->com1_norm_1sts);
 
-	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_PATH_COM2, rtwvif->mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_PATH_COM2, rtwvif_link->mac_idx);
 	rtw89_write32_mask(rtwdev, reg, B_AX_PATH_COM2_RESP_1STS_PATH,
 			   param->com2_resp_1sts_path);
 }
 
 static
 void rtw89_phy_ul_tb_ctrl_check(struct rtw89_dev *rtwdev,
-				struct rtw89_vif *rtwvif,
+				struct rtw89_vif_link *rtwvif_link,
 				struct rtw89_phy_ul_tb_check_data *ul_tb_data)
 {
 	struct rtw89_traffic_stats *stats = &rtwdev->stats;
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
 
-	if (rtwvif->wifi_role != RTW89_WIFI_ROLE_STATION)
+	if (rtwvif_link->wifi_role != RTW89_WIFI_ROLE_STATION)
 		return;
 
 	if (!vif->cfg.assoc)
@@ -4403,11 +4403,11 @@ void rtw89_phy_ul_tb_ctrl_check(struct rtw89_dev *rtwdev,
 			ul_tb_data->low_tf_client = true;
 
 		ul_tb_data->valid = true;
-		ul_tb_data->def_tri_idx = rtwvif->def_tri_idx;
-		ul_tb_data->dyn_tb_bedge_en = rtwvif->dyn_tb_bedge_en;
+		ul_tb_data->def_tri_idx = rtwvif_link->def_tri_idx;
+		ul_tb_data->dyn_tb_bedge_en = rtwvif_link->dyn_tb_bedge_en;
 	}
 
-	rtw89_phy_ofdma_power_diff(rtwdev, rtwvif);
+	rtw89_phy_ofdma_power_diff(rtwdev, rtwvif_link);
 }
 
 static void rtw89_phy_ul_tb_waveform_ctrl(struct rtw89_dev *rtwdev,
@@ -4453,7 +4453,7 @@ void rtw89_phy_ul_tb_ctrl_track(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_phy_ul_tb_check_data ul_tb_data = {};
-	struct rtw89_vif *rtwvif;
+	struct rtw89_vif_link *rtwvif_link;
 
 	if (!chip->ul_tb_waveform_ctrl && !chip->ul_tb_pwr_diff)
 		return;
@@ -4461,8 +4461,8 @@ void rtw89_phy_ul_tb_ctrl_track(struct rtw89_dev *rtwdev)
 	if (rtwdev->total_sta_assoc != 1)
 		return;
 
-	rtw89_for_each_rtwvif(rtwdev, rtwvif)
-		rtw89_phy_ul_tb_ctrl_check(rtwdev, rtwvif, &ul_tb_data);
+	rtw89_for_each_rtwvif(rtwdev, rtwvif_link)
+		rtw89_phy_ul_tb_ctrl_check(rtwdev, rtwvif_link, &ul_tb_data);
 
 	if (!ul_tb_data.valid)
 		return;
@@ -5757,13 +5757,13 @@ static void rtw89_phy_tx_path_div_sta_iter(void *data, struct ieee80211_sta *sta
 {
 	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
 	struct rtw89_dev *rtwdev = rtwsta->rtwdev;
-	struct rtw89_vif *rtwvif = rtwsta->rtwvif;
+	struct rtw89_vif_link *rtwvif_link = rtwsta->rtwvif_link;
 	struct rtw89_hal *hal = &rtwdev->hal;
 	bool *done = data;
 	u8 rssi_a, rssi_b;
 	u32 candidate;
 
-	if (rtwvif->wifi_role != RTW89_WIFI_ROLE_STATION || sta->tdls)
+	if (rtwvif_link->wifi_role != RTW89_WIFI_ROLE_STATION || sta->tdls)
 		return;
 
 	if (*done)
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 6dd8ec46939a..dc85840312da 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -957,7 +957,7 @@ void rtw89_phy_set_bss_color(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif
 void rtw89_phy_tssi_ctrl_set_bandedge_cfg(struct rtw89_dev *rtwdev,
 					  enum rtw89_mac_idx mac_idx,
 					  enum rtw89_tssi_bandedge_cfg bandedge_cfg);
-void rtw89_phy_ul_tb_assoc(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
+void rtw89_phy_ul_tb_assoc(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link);
 void rtw89_phy_ul_tb_ctrl_track(struct rtw89_dev *rtwdev);
 u8 rtw89_encode_chan_idx(struct rtw89_dev *rtwdev, u8 central_ch, u8 band);
 void rtw89_decode_chan_idx(struct rtw89_dev *rtwdev, u8 chan_idx,
diff --git a/drivers/net/wireless/realtek/rtw89/ps.c b/drivers/net/wireless/realtek/rtw89/ps.c
index aebd6404f802..42a73bba7f5c 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.c
+++ b/drivers/net/wireless/realtek/rtw89/ps.c
@@ -62,9 +62,9 @@ static void rtw89_ps_power_mode_change(struct rtw89_dev *rtwdev, bool enter)
 		rtw89_mac_power_mode_change(rtwdev, enter);
 }
 
-void __rtw89_enter_ps_mode(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+void __rtw89_enter_ps_mode(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link)
 {
-	if (rtwvif->wifi_role == RTW89_WIFI_ROLE_P2P_CLIENT)
+	if (rtwvif_link->wifi_role == RTW89_WIFI_ROLE_P2P_CLIENT)
 		return;
 
 	if (!rtwdev->ps_mode)
@@ -85,23 +85,25 @@ void __rtw89_leave_ps_mode(struct rtw89_dev *rtwdev)
 		rtw89_ps_power_mode_change(rtwdev, false);
 }
 
-static void __rtw89_enter_lps(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+static void __rtw89_enter_lps(struct rtw89_dev *rtwdev,
+			      struct rtw89_vif_link *rtwvif_link)
 {
 	struct rtw89_lps_parm lps_param = {
-		.macid = rtwvif->mac_id,
+		.macid = rtwvif_link->mac_id,
 		.psmode = RTW89_MAC_AX_PS_MODE_LEGACY,
 		.lastrpwm = RTW89_LAST_RPWM_PS,
 	};
 
 	rtw89_btc_ntfy_radio_state(rtwdev, BTC_RFCTRL_FW_CTRL);
 	rtw89_fw_h2c_lps_parm(rtwdev, &lps_param);
-	rtw89_fw_h2c_lps_ch_info(rtwdev, rtwvif);
+	rtw89_fw_h2c_lps_ch_info(rtwdev, rtwvif_link);
 }
 
-static void __rtw89_leave_lps(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+static void __rtw89_leave_lps(struct rtw89_dev *rtwdev,
+			      struct rtw89_vif_link *rtwvif_link)
 {
 	struct rtw89_lps_parm lps_param = {
-		.macid = rtwvif->mac_id,
+		.macid = rtwvif_link->mac_id,
 		.psmode = RTW89_MAC_AX_PS_MODE_ACTIVE,
 		.lastrpwm = RTW89_LAST_RPWM_ACTIVE,
 	};
@@ -109,7 +111,7 @@ static void __rtw89_leave_lps(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif
 	rtw89_fw_h2c_lps_parm(rtwdev, &lps_param);
 	rtw89_fw_leave_lps_check(rtwdev, 0);
 	rtw89_btc_ntfy_radio_state(rtwdev, BTC_RFCTRL_WL_ON);
-	rtw89_chip_digital_pwr_comp(rtwdev, rtwvif->phy_idx);
+	rtw89_chip_digital_pwr_comp(rtwdev, rtwvif_link->phy_idx);
 }
 
 void rtw89_leave_ps_mode(struct rtw89_dev *rtwdev)
@@ -119,7 +121,7 @@ void rtw89_leave_ps_mode(struct rtw89_dev *rtwdev)
 	__rtw89_leave_ps_mode(rtwdev);
 }
 
-void rtw89_enter_lps(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+void rtw89_enter_lps(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
 		     bool ps_mode)
 {
 	lockdep_assert_held(&rtwdev->mutex);
@@ -127,23 +129,24 @@ void rtw89_enter_lps(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 	if (test_and_set_bit(RTW89_FLAG_LEISURE_PS, rtwdev->flags))
 		return;
 
-	__rtw89_enter_lps(rtwdev, rtwvif);
+	__rtw89_enter_lps(rtwdev, rtwvif_link);
 	if (ps_mode)
-		__rtw89_enter_ps_mode(rtwdev, rtwvif);
+		__rtw89_enter_ps_mode(rtwdev, rtwvif_link);
 }
 
-static void rtw89_leave_lps_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+static void rtw89_leave_lps_vif(struct rtw89_dev *rtwdev,
+				struct rtw89_vif_link *rtwvif_link)
 {
-	if (rtwvif->wifi_role != RTW89_WIFI_ROLE_STATION &&
-	    rtwvif->wifi_role != RTW89_WIFI_ROLE_P2P_CLIENT)
+	if (rtwvif_link->wifi_role != RTW89_WIFI_ROLE_STATION &&
+	    rtwvif_link->wifi_role != RTW89_WIFI_ROLE_P2P_CLIENT)
 		return;
 
-	__rtw89_leave_lps(rtwdev, rtwvif);
+	__rtw89_leave_lps(rtwdev, rtwvif_link);
 }
 
 void rtw89_leave_lps(struct rtw89_dev *rtwdev)
 {
-	struct rtw89_vif *rtwvif;
+	struct rtw89_vif_link *rtwvif_link;
 
 	lockdep_assert_held(&rtwdev->mutex);
 
@@ -152,28 +155,28 @@ void rtw89_leave_lps(struct rtw89_dev *rtwdev)
 
 	__rtw89_leave_ps_mode(rtwdev);
 
-	rtw89_for_each_rtwvif(rtwdev, rtwvif)
-		rtw89_leave_lps_vif(rtwdev, rtwvif);
+	rtw89_for_each_rtwvif(rtwdev, rtwvif_link)
+		rtw89_leave_lps_vif(rtwdev, rtwvif_link);
 }
 
 void rtw89_enter_ips(struct rtw89_dev *rtwdev)
 {
-	struct rtw89_vif *rtwvif;
+	struct rtw89_vif_link *rtwvif_link;
 
 	set_bit(RTW89_FLAG_INACTIVE_PS, rtwdev->flags);
 
 	if (!test_bit(RTW89_FLAG_POWERON, rtwdev->flags))
 		return;
 
-	rtw89_for_each_rtwvif(rtwdev, rtwvif)
-		rtw89_mac_vif_deinit(rtwdev, rtwvif);
+	rtw89_for_each_rtwvif(rtwdev, rtwvif_link)
+		rtw89_mac_vif_deinit(rtwdev, rtwvif_link);
 
 	rtw89_core_stop(rtwdev);
 }
 
 void rtw89_leave_ips(struct rtw89_dev *rtwdev)
 {
-	struct rtw89_vif *rtwvif;
+	struct rtw89_vif_link *rtwvif_link;
 	int ret;
 
 	if (test_bit(RTW89_FLAG_POWERON, rtwdev->flags))
@@ -185,8 +188,8 @@ void rtw89_leave_ips(struct rtw89_dev *rtwdev)
 
 	rtw89_set_channel(rtwdev);
 
-	rtw89_for_each_rtwvif(rtwdev, rtwvif)
-		rtw89_mac_vif_init(rtwdev, rtwvif);
+	rtw89_for_each_rtwvif(rtwdev, rtwvif_link)
+		rtw89_mac_vif_init(rtwdev, rtwvif_link);
 
 	clear_bit(RTW89_FLAG_INACTIVE_PS, rtwdev->flags);
 }
@@ -197,34 +200,35 @@ void rtw89_set_coex_ctrl_lps(struct rtw89_dev *rtwdev, bool btc_ctrl)
 		rtw89_leave_lps(rtwdev);
 }
 
-static void rtw89_tsf32_toggle(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+static void rtw89_tsf32_toggle(struct rtw89_dev *rtwdev,
+			       struct rtw89_vif_link *rtwvif_link,
 			       enum rtw89_p2pps_action act)
 {
 	if (act == RTW89_P2P_ACT_UPDATE || act == RTW89_P2P_ACT_REMOVE)
 		return;
 
 	if (act == RTW89_P2P_ACT_INIT)
-		rtw89_fw_h2c_tsf32_toggle(rtwdev, rtwvif, true);
+		rtw89_fw_h2c_tsf32_toggle(rtwdev, rtwvif_link, true);
 	else if (act == RTW89_P2P_ACT_TERMINATE)
-		rtw89_fw_h2c_tsf32_toggle(rtwdev, rtwvif, false);
+		rtw89_fw_h2c_tsf32_toggle(rtwdev, rtwvif_link, false);
 }
 
 static void rtw89_p2p_disable_all_noa(struct rtw89_dev *rtwdev,
 				      struct ieee80211_vif *vif)
 {
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 	enum rtw89_p2pps_action act;
 	u8 noa_id;
 
-	if (rtwvif->last_noa_nr == 0)
+	if (rtwvif_link->last_noa_nr == 0)
 		return;
 
-	for (noa_id = 0; noa_id < rtwvif->last_noa_nr; noa_id++) {
-		if (noa_id == rtwvif->last_noa_nr - 1)
+	for (noa_id = 0; noa_id < rtwvif_link->last_noa_nr; noa_id++) {
+		if (noa_id == rtwvif_link->last_noa_nr - 1)
 			act = RTW89_P2P_ACT_TERMINATE;
 		else
 			act = RTW89_P2P_ACT_REMOVE;
-		rtw89_tsf32_toggle(rtwdev, rtwvif, act);
+		rtw89_tsf32_toggle(rtwdev, rtwvif_link, act);
 		rtw89_fw_h2c_p2p_act(rtwdev, vif, NULL, act, noa_id);
 	}
 }
@@ -232,7 +236,7 @@ static void rtw89_p2p_disable_all_noa(struct rtw89_dev *rtwdev,
 static void rtw89_p2p_update_noa(struct rtw89_dev *rtwdev,
 				 struct ieee80211_vif *vif)
 {
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 	struct ieee80211_p2p_noa_desc *desc;
 	enum rtw89_p2pps_action act;
 	u8 noa_id;
@@ -246,10 +250,10 @@ static void rtw89_p2p_update_noa(struct rtw89_dev *rtwdev,
 			act = RTW89_P2P_ACT_INIT;
 		else
 			act = RTW89_P2P_ACT_UPDATE;
-		rtw89_tsf32_toggle(rtwdev, rtwvif, act);
+		rtw89_tsf32_toggle(rtwdev, rtwvif_link, act);
 		rtw89_fw_h2c_p2p_act(rtwdev, vif, desc, act, noa_id);
 	}
-	rtwvif->last_noa_nr = noa_id;
+	rtwvif_link->last_noa_nr = noa_id;
 }
 
 void rtw89_process_p2p_ps(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif)
@@ -261,7 +265,7 @@ void rtw89_process_p2p_ps(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif)
 void rtw89_recalc_lps(struct rtw89_dev *rtwdev)
 {
 	struct ieee80211_vif *vif, *found_vif = NULL;
-	struct rtw89_vif *rtwvif;
+	struct rtw89_vif_link *rtwvif_link;
 	enum rtw89_entity_mode mode;
 	int count = 0;
 
@@ -269,8 +273,8 @@ void rtw89_recalc_lps(struct rtw89_dev *rtwdev)
 	if (mode == RTW89_ENTITY_MODE_MCC)
 		goto disable_lps;
 
-	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
-		vif = rtwvif_to_vif(rtwvif);
+	rtw89_for_each_rtwvif(rtwdev, rtwvif_link) {
+		vif = rtwvif_to_vif(rtwvif_link);
 
 		if (vif->type != NL80211_IFTYPE_STATION) {
 			count = 0;
@@ -291,9 +295,9 @@ void rtw89_recalc_lps(struct rtw89_dev *rtwdev)
 	rtwdev->lps_enabled = false;
 }
 
-void rtw89_p2p_noa_renew(struct rtw89_vif *rtwvif)
+void rtw89_p2p_noa_renew(struct rtw89_vif_link *rtwvif_link)
 {
-	struct rtw89_p2p_noa_setter *setter = &rtwvif->p2p_noa;
+	struct rtw89_p2p_noa_setter *setter = &rtwvif_link->p2p_noa;
 	struct rtw89_p2p_noa_ie *ie = &setter->ie;
 	struct rtw89_p2p_ie_head *p2p_head = &ie->p2p_head;
 	struct rtw89_noa_attr_head *noa_head = &ie->noa_head;
@@ -318,10 +322,10 @@ void rtw89_p2p_noa_renew(struct rtw89_vif *rtwvif)
 	noa_head->oppps_ctwindow = 0;
 }
 
-void rtw89_p2p_noa_append(struct rtw89_vif *rtwvif,
+void rtw89_p2p_noa_append(struct rtw89_vif_link *rtwvif_link,
 			  const struct ieee80211_p2p_noa_desc *desc)
 {
-	struct rtw89_p2p_noa_setter *setter = &rtwvif->p2p_noa;
+	struct rtw89_p2p_noa_setter *setter = &rtwvif_link->p2p_noa;
 	struct rtw89_p2p_noa_ie *ie = &setter->ie;
 	struct rtw89_p2p_ie_head *p2p_head = &ie->p2p_head;
 	struct rtw89_noa_attr_head *noa_head = &ie->noa_head;
@@ -338,9 +342,9 @@ void rtw89_p2p_noa_append(struct rtw89_vif *rtwvif,
 	ie->noa_desc[setter->noa_count++] = *desc;
 }
 
-u8 rtw89_p2p_noa_fetch(struct rtw89_vif *rtwvif, void **data)
+u8 rtw89_p2p_noa_fetch(struct rtw89_vif_link *rtwvif_link, void **data)
 {
-	struct rtw89_p2p_noa_setter *setter = &rtwvif->p2p_noa;
+	struct rtw89_p2p_noa_setter *setter = &rtwvif_link->p2p_noa;
 	struct rtw89_p2p_noa_ie *ie = &setter->ie;
 	void *tail;
 
diff --git a/drivers/net/wireless/realtek/rtw89/ps.h b/drivers/net/wireless/realtek/rtw89/ps.h
index 54486e4550b6..d0be56ee16a2 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.h
+++ b/drivers/net/wireless/realtek/rtw89/ps.h
@@ -5,21 +5,21 @@
 #ifndef __RTW89_PS_H_
 #define __RTW89_PS_H_
 
-void rtw89_enter_lps(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+void rtw89_enter_lps(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
 		     bool ps_mode);
 void rtw89_leave_lps(struct rtw89_dev *rtwdev);
 void __rtw89_leave_ps_mode(struct rtw89_dev *rtwdev);
-void __rtw89_enter_ps_mode(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
+void __rtw89_enter_ps_mode(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link);
 void rtw89_leave_ps_mode(struct rtw89_dev *rtwdev);
 void rtw89_enter_ips(struct rtw89_dev *rtwdev);
 void rtw89_leave_ips(struct rtw89_dev *rtwdev);
 void rtw89_set_coex_ctrl_lps(struct rtw89_dev *rtwdev, bool btc_ctrl);
 void rtw89_process_p2p_ps(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif);
 void rtw89_recalc_lps(struct rtw89_dev *rtwdev);
-void rtw89_p2p_noa_renew(struct rtw89_vif *rtwvif);
-void rtw89_p2p_noa_append(struct rtw89_vif *rtwvif,
+void rtw89_p2p_noa_renew(struct rtw89_vif_link *rtwvif_link);
+void rtw89_p2p_noa_append(struct rtw89_vif_link *rtwvif_link,
 			  const struct ieee80211_p2p_noa_desc *desc);
-u8 rtw89_p2p_noa_fetch(struct rtw89_vif *rtwvif, void **data);
+u8 rtw89_p2p_noa_fetch(struct rtw89_vif_link *rtwvif_link, void **data);
 
 static inline void rtw89_leave_ips_by_hwflags(struct rtw89_dev *rtwdev)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/regd.c b/drivers/net/wireless/realtek/rtw89/regd.c
index a7720a1f17a7..0fd8e132fdf0 100644
--- a/drivers/net/wireless/realtek/rtw89/regd.c
+++ b/drivers/net/wireless/realtek/rtw89/regd.c
@@ -793,18 +793,18 @@ static bool __rtw89_reg_6ghz_tpe_recalc(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_regulatory_info *regulatory = &rtwdev->regulatory;
 	struct rtw89_reg_6ghz_tpe new = {};
-	struct rtw89_vif *rtwvif;
+	struct rtw89_vif_link *rtwvif_link;
 	bool changed = false;
 
-	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
+	rtw89_for_each_rtwvif(rtwdev, rtwvif_link) {
 		const struct rtw89_reg_6ghz_tpe *tmp;
 		const struct rtw89_chan *chan;
 
-		chan = rtw89_chan_get(rtwdev, rtwvif->chanctx_idx);
+		chan = rtw89_chan_get(rtwdev, rtwvif_link->chanctx_idx);
 		if (chan->band_type != RTW89_BAND_6G)
 			continue;
 
-		tmp = &rtwvif->reg_6ghz_tpe;
+		tmp = &rtwvif_link->reg_6ghz_tpe;
 		if (!tmp->valid)
 			continue;
 
@@ -831,16 +831,16 @@ static bool __rtw89_reg_6ghz_tpe_recalc(struct rtw89_dev *rtwdev)
 }
 
 static int rtw89_reg_6ghz_tpe_recalc(struct rtw89_dev *rtwdev,
-				     struct rtw89_vif *rtwvif, bool active,
+				     struct rtw89_vif_link *rtwvif_link, bool active,
 				     unsigned int *changed)
 {
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
 	struct ieee80211_bss_conf *bss_conf = &vif->bss_conf;
-	struct rtw89_reg_6ghz_tpe *tpe = &rtwvif->reg_6ghz_tpe;
+	struct rtw89_reg_6ghz_tpe *tpe = &rtwvif_link->reg_6ghz_tpe;
 
 	memset(tpe, 0, sizeof(*tpe));
 
-	if (!active || rtwvif->reg_6ghz_power != RTW89_REG_6GHZ_POWER_STD)
+	if (!active || rtwvif_link->reg_6ghz_power != RTW89_REG_6GHZ_POWER_STD)
 		goto bottom;
 
 	rtw89_calculate_tpe(rtwdev, tpe, &bss_conf->tpe);
@@ -867,19 +867,19 @@ static bool __rtw89_reg_6ghz_power_recalc(struct rtw89_dev *rtwdev)
 	const struct rtw89_regd *regd = regulatory->regd;
 	enum rtw89_reg_6ghz_power sel;
 	const struct rtw89_chan *chan;
-	struct rtw89_vif *rtwvif;
+	struct rtw89_vif_link *rtwvif_link;
 	int count = 0;
 	u8 index;
 
-	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
-		chan = rtw89_chan_get(rtwdev, rtwvif->chanctx_idx);
+	rtw89_for_each_rtwvif(rtwdev, rtwvif_link) {
+		chan = rtw89_chan_get(rtwdev, rtwvif_link->chanctx_idx);
 		if (chan->band_type != RTW89_BAND_6G)
 			continue;
 
-		if (count != 0 && rtwvif->reg_6ghz_power == sel)
+		if (count != 0 && rtwvif_link->reg_6ghz_power == sel)
 			continue;
 
-		sel = rtwvif->reg_6ghz_power;
+		sel = rtwvif_link->reg_6ghz_power;
 		count++;
 	}
 
@@ -908,35 +908,35 @@ static bool __rtw89_reg_6ghz_power_recalc(struct rtw89_dev *rtwdev)
 }
 
 static int rtw89_reg_6ghz_power_recalc(struct rtw89_dev *rtwdev,
-				       struct rtw89_vif *rtwvif, bool active,
+				       struct rtw89_vif_link *rtwvif_link, bool active,
 				       unsigned int *changed)
 {
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
 
 	if (active) {
 		switch (vif->bss_conf.power_type) {
 		case IEEE80211_REG_VLP_AP:
-			rtwvif->reg_6ghz_power = RTW89_REG_6GHZ_POWER_VLP;
+			rtwvif_link->reg_6ghz_power = RTW89_REG_6GHZ_POWER_VLP;
 			break;
 		case IEEE80211_REG_LPI_AP:
-			rtwvif->reg_6ghz_power = RTW89_REG_6GHZ_POWER_LPI;
+			rtwvif_link->reg_6ghz_power = RTW89_REG_6GHZ_POWER_LPI;
 			break;
 		case IEEE80211_REG_SP_AP:
-			rtwvif->reg_6ghz_power = RTW89_REG_6GHZ_POWER_STD;
+			rtwvif_link->reg_6ghz_power = RTW89_REG_6GHZ_POWER_STD;
 			break;
 		default:
-			rtwvif->reg_6ghz_power = RTW89_REG_6GHZ_POWER_DFLT;
+			rtwvif_link->reg_6ghz_power = RTW89_REG_6GHZ_POWER_DFLT;
 			break;
 		}
 	} else {
-		rtwvif->reg_6ghz_power = RTW89_REG_6GHZ_POWER_DFLT;
+		rtwvif_link->reg_6ghz_power = RTW89_REG_6GHZ_POWER_DFLT;
 	}
 
 	*changed += __rtw89_reg_6ghz_power_recalc(rtwdev);
 	return 0;
 }
 
-int rtw89_reg_6ghz_recalc(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+int rtw89_reg_6ghz_recalc(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
 			  bool active)
 {
 	unsigned int changed = 0;
@@ -948,11 +948,11 @@ int rtw89_reg_6ghz_recalc(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 	 * so must do reg_6ghz_tpe_recalc() after reg_6ghz_power_recalc().
 	 */
 
-	ret = rtw89_reg_6ghz_power_recalc(rtwdev, rtwvif, active, &changed);
+	ret = rtw89_reg_6ghz_power_recalc(rtwdev, rtwvif_link, active, &changed);
 	if (ret)
 		return ret;
 
-	ret = rtw89_reg_6ghz_tpe_recalc(rtwdev, rtwvif, active, &changed);
+	ret = rtw89_reg_6ghz_tpe_recalc(rtwdev, rtwvif_link, active, &changed);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 1679bd408ef3..f9766bf30e71 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -1590,10 +1590,11 @@ static void rtw8851b_rfk_init(struct rtw89_dev *rtwdev)
 	rtw8851b_rx_dck(rtwdev, RTW89_PHY_0, RTW89_CHANCTX_0);
 }
 
-static void rtw8851b_rfk_channel(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+static void rtw8851b_rfk_channel(struct rtw89_dev *rtwdev,
+				 struct rtw89_vif_link *rtwvif_link)
 {
-	enum rtw89_chanctx_idx chanctx_idx = rtwvif->chanctx_idx;
-	enum rtw89_phy_idx phy_idx = rtwvif->phy_idx;
+	enum rtw89_chanctx_idx chanctx_idx = rtwvif_link->chanctx_idx;
+	enum rtw89_phy_idx phy_idx = rtwvif_link->phy_idx;
 
 	rtw8851b_rx_dck(rtwdev, phy_idx, chanctx_idx);
 	rtw8851b_iqk(rtwdev, phy_idx, chanctx_idx);
@@ -1608,10 +1609,12 @@ static void rtw8851b_rfk_band_changed(struct rtw89_dev *rtwdev,
 	rtw8851b_tssi_scan(rtwdev, phy_idx, chan);
 }
 
-static void rtw8851b_rfk_scan(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+static void rtw8851b_rfk_scan(struct rtw89_dev *rtwdev,
+			      struct rtw89_vif_link *rtwvif_link,
 			      bool start)
 {
-	rtw8851b_wifi_scan_notify(rtwdev, start, rtwvif->phy_idx, rtwvif->chanctx_idx);
+	rtw8851b_wifi_scan_notify(rtwdev, start, rtwvif_link->phy_idx,
+				  rtwvif_link->chanctx_idx);
 }
 
 static void rtw8851b_rfk_track(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index dde96bd63021..42d369d2e916 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -1350,10 +1350,11 @@ static void rtw8852a_rfk_init(struct rtw89_dev *rtwdev)
 	rtw8852a_rx_dck(rtwdev, RTW89_PHY_0, true, RTW89_CHANCTX_0);
 }
 
-static void rtw8852a_rfk_channel(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+static void rtw8852a_rfk_channel(struct rtw89_dev *rtwdev,
+				 struct rtw89_vif_link *rtwvif_link)
 {
-	enum rtw89_chanctx_idx chanctx_idx = rtwvif->chanctx_idx;
-	enum rtw89_phy_idx phy_idx = rtwvif->phy_idx;
+	enum rtw89_chanctx_idx chanctx_idx = rtwvif_link->chanctx_idx;
+	enum rtw89_phy_idx phy_idx = rtwvif_link->phy_idx;
 
 	rtw8852a_rx_dck(rtwdev, phy_idx, true, chanctx_idx);
 	rtw8852a_iqk(rtwdev, phy_idx, chanctx_idx);
@@ -1368,10 +1369,11 @@ static void rtw8852a_rfk_band_changed(struct rtw89_dev *rtwdev,
 	rtw8852a_tssi_scan(rtwdev, phy_idx, chan);
 }
 
-static void rtw8852a_rfk_scan(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+static void rtw8852a_rfk_scan(struct rtw89_dev *rtwdev,
+			      struct rtw89_vif_link *rtwvif_link,
 			      bool start)
 {
-	rtw8852a_wifi_scan_notify(rtwdev, start, rtwvif->phy_idx);
+	rtw8852a_wifi_scan_notify(rtwdev, start, rtwvif_link->phy_idx);
 }
 
 static void rtw8852a_rfk_track(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 12be52f76427..364aa21cbd44 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -562,10 +562,11 @@ static void rtw8852b_rfk_init(struct rtw89_dev *rtwdev)
 	rtw8852b_rx_dck(rtwdev, RTW89_PHY_0, RTW89_CHANCTX_0);
 }
 
-static void rtw8852b_rfk_channel(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+static void rtw8852b_rfk_channel(struct rtw89_dev *rtwdev,
+				 struct rtw89_vif_link *rtwvif_link)
 {
-	enum rtw89_chanctx_idx chanctx_idx = rtwvif->chanctx_idx;
-	enum rtw89_phy_idx phy_idx = rtwvif->phy_idx;
+	enum rtw89_chanctx_idx chanctx_idx = rtwvif_link->chanctx_idx;
+	enum rtw89_phy_idx phy_idx = rtwvif_link->phy_idx;
 
 	rtw8852b_rx_dck(rtwdev, phy_idx, chanctx_idx);
 	rtw8852b_iqk(rtwdev, phy_idx, chanctx_idx);
@@ -580,10 +581,12 @@ static void rtw8852b_rfk_band_changed(struct rtw89_dev *rtwdev,
 	rtw8852b_tssi_scan(rtwdev, phy_idx, chan);
 }
 
-static void rtw8852b_rfk_scan(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+static void rtw8852b_rfk_scan(struct rtw89_dev *rtwdev,
+			      struct rtw89_vif_link *rtwvif_link,
 			      bool start)
 {
-	rtw8852b_wifi_scan_notify(rtwdev, start, rtwvif->phy_idx, rtwvif->chanctx_idx);
+	rtw8852b_wifi_scan_notify(rtwdev, start, rtwvif_link->phy_idx,
+				  rtwvif_link->chanctx_idx);
 }
 
 static void rtw8852b_rfk_track(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index 7dfdcb5964e1..dab7e71ec6a1 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -535,10 +535,11 @@ static void rtw8852bt_rfk_init(struct rtw89_dev *rtwdev)
 	rtw8852bt_rx_dck(rtwdev, RTW89_PHY_0, RTW89_CHANCTX_0);
 }
 
-static void rtw8852bt_rfk_channel(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+static void rtw8852bt_rfk_channel(struct rtw89_dev *rtwdev,
+				  struct rtw89_vif_link *rtwvif_link)
 {
-	enum rtw89_chanctx_idx chanctx_idx = rtwvif->chanctx_idx;
-	enum rtw89_phy_idx phy_idx = rtwvif->phy_idx;
+	enum rtw89_chanctx_idx chanctx_idx = rtwvif_link->chanctx_idx;
+	enum rtw89_phy_idx phy_idx = rtwvif_link->phy_idx;
 
 	rtw8852bt_rx_dck(rtwdev, phy_idx, chanctx_idx);
 	rtw8852bt_iqk(rtwdev, phy_idx, chanctx_idx);
@@ -553,10 +554,12 @@ static void rtw8852bt_rfk_band_changed(struct rtw89_dev *rtwdev,
 	rtw8852bt_tssi_scan(rtwdev, phy_idx, chan);
 }
 
-static void rtw8852bt_rfk_scan(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+static void rtw8852bt_rfk_scan(struct rtw89_dev *rtwdev,
+			       struct rtw89_vif_link *rtwvif_link,
 			       bool start)
 {
-	rtw8852bt_wifi_scan_notify(rtwdev, start, rtwvif->phy_idx, rtwvif->chanctx_idx);
+	rtw8852bt_wifi_scan_notify(rtwdev, start, rtwvif_link->phy_idx,
+				   rtwvif_link->chanctx_idx);
 }
 
 static void rtw8852bt_rfk_track(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 1c6e89ab0f4b..dbe77abb2c48 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -1846,10 +1846,11 @@ static void rtw8852c_rfk_init(struct rtw89_dev *rtwdev)
 	rtw8852c_rx_dck(rtwdev, RTW89_PHY_0, false);
 }
 
-static void rtw8852c_rfk_channel(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+static void rtw8852c_rfk_channel(struct rtw89_dev *rtwdev,
+				 struct rtw89_vif_link *rtwvif_link)
 {
-	enum rtw89_chanctx_idx chanctx_idx = rtwvif->chanctx_idx;
-	enum rtw89_phy_idx phy_idx = rtwvif->phy_idx;
+	enum rtw89_chanctx_idx chanctx_idx = rtwvif_link->chanctx_idx;
+	enum rtw89_phy_idx phy_idx = rtwvif_link->phy_idx;
 
 	rtw8852c_mcc_get_ch_info(rtwdev, phy_idx);
 	rtw8852c_rx_dck(rtwdev, phy_idx, false);
@@ -1866,10 +1867,11 @@ static void rtw8852c_rfk_band_changed(struct rtw89_dev *rtwdev,
 	rtw8852c_tssi_scan(rtwdev, phy_idx, chan);
 }
 
-static void rtw8852c_rfk_scan(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+static void rtw8852c_rfk_scan(struct rtw89_dev *rtwdev,
+			      struct rtw89_vif_link *rtwvif_link,
 			      bool start)
 {
-	rtw8852c_wifi_scan_notify(rtwdev, start, rtwvif->phy_idx);
+	rtw8852c_wifi_scan_notify(rtwdev, start, rtwvif_link->phy_idx);
 }
 
 static void rtw8852c_rfk_track(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 63b1ff2f98ed..ef7747adbcc2 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2020,11 +2020,12 @@ static void _wait_rx_mode(struct rtw89_dev *rtwdev, u8 kpath)
 	}
 }
 
-static void rtw8922a_rfk_channel(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+static void rtw8922a_rfk_channel(struct rtw89_dev *rtwdev,
+				 struct rtw89_vif_link *rtwvif_link)
 {
-	enum rtw89_chanctx_idx chanctx_idx = rtwvif->chanctx_idx;
+	enum rtw89_chanctx_idx chanctx_idx = rtwvif_link->chanctx_idx;
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, chanctx_idx);
-	enum rtw89_phy_idx phy_idx = rtwvif->phy_idx;
+	enum rtw89_phy_idx phy_idx = rtwvif_link->phy_idx;
 	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, RF_AB, chanctx_idx);
 	u32 tx_en;
 
@@ -2050,7 +2051,8 @@ static void rtw8922a_rfk_band_changed(struct rtw89_dev *rtwdev,
 	rtw89_phy_rfk_tssi_and_wait(rtwdev, phy_idx, chan, RTW89_TSSI_SCAN, 6);
 }
 
-static void rtw8922a_rfk_scan(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+static void rtw8922a_rfk_scan(struct rtw89_dev *rtwdev,
+			      struct rtw89_vif_link *rtwvif_link,
 			      bool start)
 {
 }
diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
index 5fc2faa9ba5a..2058f4bf271d 100644
--- a/drivers/net/wireless/realtek/rtw89/ser.c
+++ b/drivers/net/wireless/realtek/rtw89/ser.c
@@ -298,25 +298,25 @@ static void drv_resume_rx(struct rtw89_ser *ser)
 	clear_bit(RTW89_SER_DRV_STOP_RX, ser->flags);
 }
 
-static void ser_reset_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+static void ser_reset_vif(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link)
 {
-	rtw89_core_release_bit_map(rtwdev->hw_port, rtwvif->port);
-	rtwvif->net_type = RTW89_NET_TYPE_NO_LINK;
-	rtwvif->trigger = false;
-	rtwvif->tdls_peer = 0;
+	rtw89_core_release_bit_map(rtwdev->hw_port, rtwvif_link->port);
+	rtwvif_link->net_type = RTW89_NET_TYPE_NO_LINK;
+	rtwvif_link->trigger = false;
+	rtwvif_link->tdls_peer = 0;
 }
 
 static void ser_sta_deinit_cam_iter(void *data, struct ieee80211_sta *sta)
 {
-	struct rtw89_vif *target_rtwvif = (struct rtw89_vif *)data;
+	struct rtw89_vif_link *target_rtwvif = (struct rtw89_vif_link *)data;
 	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
-	struct rtw89_vif *rtwvif = rtwsta->rtwvif;
-	struct rtw89_dev *rtwdev = rtwvif->rtwdev;
+	struct rtw89_vif_link *rtwvif_link = rtwsta->rtwvif_link;
+	struct rtw89_dev *rtwdev = rtwvif_link->rtwdev;
 
-	if (rtwvif != target_rtwvif)
+	if (rtwvif_link != target_rtwvif)
 		return;
 
-	if (rtwvif->net_type == RTW89_NET_TYPE_AP_MODE || sta->tdls)
+	if (rtwvif_link->net_type == RTW89_NET_TYPE_AP_MODE || sta->tdls)
 		rtw89_cam_deinit_addr_cam(rtwdev, &rtwsta->addr_cam);
 	if (sta->tdls)
 		rtw89_cam_deinit_bssid_cam(rtwdev, &rtwsta->bssid_cam);
@@ -324,28 +324,28 @@ static void ser_sta_deinit_cam_iter(void *data, struct ieee80211_sta *sta)
 	INIT_LIST_HEAD(&rtwsta->ba_cam_list);
 }
 
-static void ser_deinit_cam(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+static void ser_deinit_cam(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link)
 {
 	ieee80211_iterate_stations_atomic(rtwdev->hw,
 					  ser_sta_deinit_cam_iter,
-					  rtwvif);
+					  rtwvif_link);
 
-	rtw89_cam_deinit(rtwdev, rtwvif);
+	rtw89_cam_deinit(rtwdev, rtwvif_link);
 
 	bitmap_zero(rtwdev->cam_info.ba_cam_map, RTW89_MAX_BA_CAM_NUM);
 }
 
 static void ser_reset_mac_binding(struct rtw89_dev *rtwdev)
 {
-	struct rtw89_vif *rtwvif;
+	struct rtw89_vif_link *rtwvif_link;
 
 	rtw89_cam_reset_keys(rtwdev);
-	rtw89_for_each_rtwvif(rtwdev, rtwvif)
-		ser_deinit_cam(rtwdev, rtwvif);
+	rtw89_for_each_rtwvif(rtwdev, rtwvif_link)
+		ser_deinit_cam(rtwdev, rtwvif_link);
 
 	rtw89_core_release_all_bits_map(rtwdev->mac_id_map, RTW89_MAX_MAC_ID_NUM);
-	rtw89_for_each_rtwvif(rtwdev, rtwvif)
-		ser_reset_vif(rtwdev, rtwvif);
+	rtw89_for_each_rtwvif(rtwdev, rtwvif_link)
+		ser_reset_vif(rtwdev, rtwvif_link);
 
 	rtwdev->total_sta_assoc = 0;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/util.h b/drivers/net/wireless/realtek/rtw89/util.h
index e669544cafd3..a5e87a8d8642 100644
--- a/drivers/net/wireless/realtek/rtw89/util.h
+++ b/drivers/net/wireless/realtek/rtw89/util.h
@@ -21,14 +21,14 @@
  * twice cause the list to be added twice.
  */
 static inline bool rtw89_rtwvif_in_list(struct rtw89_dev *rtwdev,
-					struct rtw89_vif *new)
+					struct rtw89_vif_link *new)
 {
-	struct rtw89_vif *rtwvif;
+	struct rtw89_vif_link *rtwvif_link;
 
 	lockdep_assert_held(&rtwdev->mutex);
 
-	rtw89_for_each_rtwvif(rtwdev, rtwvif)
-		if (rtwvif == new)
+	rtw89_for_each_rtwvif(rtwdev, rtwvif_link)
+		if (rtwvif_link == new)
 			return true;
 
 	return false;
diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index 86e24e07780d..5902eb37d618 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -682,26 +682,26 @@ static void rtw89_wow_leave_deep_ps(struct rtw89_dev *rtwdev)
 static void rtw89_wow_enter_deep_ps(struct rtw89_dev *rtwdev)
 {
 	struct ieee80211_vif *wow_vif = rtwdev->wow.wow_vif;
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)wow_vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)wow_vif->drv_priv;
 
-	__rtw89_enter_ps_mode(rtwdev, rtwvif);
+	__rtw89_enter_ps_mode(rtwdev, rtwvif_link);
 }
 
 static void rtw89_wow_enter_ps(struct rtw89_dev *rtwdev)
 {
 	struct ieee80211_vif *wow_vif = rtwdev->wow.wow_vif;
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)wow_vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)wow_vif->drv_priv;
 
 	if (rtw89_wow_mgd_linked(rtwdev))
-		rtw89_enter_lps(rtwdev, rtwvif, false);
+		rtw89_enter_lps(rtwdev, rtwvif_link, false);
 	else if (rtw89_wow_no_link(rtwdev))
-		rtw89_fw_h2c_fwips(rtwdev, rtwvif, true);
+		rtw89_fw_h2c_fwips(rtwdev, rtwvif_link, true);
 }
 
 static void rtw89_wow_leave_ps(struct rtw89_dev *rtwdev, bool enable_wow)
 {
 	struct ieee80211_vif *wow_vif = rtwdev->wow.wow_vif;
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)wow_vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)wow_vif->drv_priv;
 
 	if (rtw89_wow_mgd_linked(rtwdev)) {
 		rtw89_leave_lps(rtwdev);
@@ -709,7 +709,7 @@ static void rtw89_wow_leave_ps(struct rtw89_dev *rtwdev, bool enable_wow)
 		if (enable_wow)
 			rtw89_leave_ips(rtwdev);
 		else
-			rtw89_fw_h2c_fwips(rtwdev, rtwvif, false);
+			rtw89_fw_h2c_fwips(rtwdev, rtwvif_link, false);
 	}
 }
 
@@ -789,10 +789,11 @@ static void rtw89_wow_show_wakeup_reason(struct rtw89_dev *rtwdev)
 				       GFP_KERNEL);
 }
 
-static void rtw89_wow_vif_iter(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+static void rtw89_wow_vif_iter(struct rtw89_dev *rtwdev,
+			       struct rtw89_vif_link *rtwvif_link)
 {
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
 
 	/* Current WoWLAN function support setting of only vif in
 	 * infra mode or no link mode. When one suitable vif is found,
@@ -801,7 +802,7 @@ static void rtw89_wow_vif_iter(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvi
 	if (rtw_wow->wow_vif || vif->type != NL80211_IFTYPE_STATION)
 		return;
 
-	switch (rtwvif->net_type) {
+	switch (rtwvif_link->net_type) {
 	case RTW89_NET_TYPE_INFRA:
 		if (rtw_wow_has_mgd_features(rtwdev))
 			rtw_wow->wow_vif = vif;
@@ -865,7 +866,7 @@ static u16 rtw89_calc_crc(u8 *pdata, int length)
 	return ~crc;
 }
 
-static int rtw89_wow_pattern_get_type(struct rtw89_vif *rtwvif,
+static int rtw89_wow_pattern_get_type(struct rtw89_vif_link *rtwvif_link,
 				      struct rtw89_wow_cam_info *rtw_pattern,
 				      const u8 *pattern, u8 da_mask)
 {
@@ -885,7 +886,7 @@ static int rtw89_wow_pattern_get_type(struct rtw89_vif *rtwvif,
 		rtw_pattern->bc = true;
 	else if (is_multicast_ether_addr(da))
 		rtw_pattern->mc = true;
-	else if (ether_addr_equal(da, rtwvif->mac_addr) &&
+	else if (ether_addr_equal(da, rtwvif_link->mac_addr) &&
 		 da_mask == GENMASK(5, 0))
 		rtw_pattern->uc = true;
 	else if (!da_mask) /*da_mask == 0 mean wildcard*/
@@ -897,7 +898,7 @@ static int rtw89_wow_pattern_get_type(struct rtw89_vif *rtwvif,
 }
 
 static int rtw89_wow_pattern_generate(struct rtw89_dev *rtwdev,
-				      struct rtw89_vif *rtwvif,
+				      struct rtw89_vif_link *rtwvif_link,
 				      const struct cfg80211_pkt_pattern *pkt_pattern,
 				      struct rtw89_wow_cam_info *rtw_pattern)
 {
@@ -916,7 +917,7 @@ static int rtw89_wow_pattern_generate(struct rtw89_dev *rtwdev,
 	mask_len = DIV_ROUND_UP(len, 8);
 	memset(rtw_pattern, 0, sizeof(*rtw_pattern));
 
-	ret = rtw89_wow_pattern_get_type(rtwvif, rtw_pattern, pattern,
+	ret = rtw89_wow_pattern_get_type(rtwvif_link, rtw_pattern, pattern,
 					 mask[0] & GENMASK(5, 0));
 	if (ret)
 		return ret;
@@ -970,7 +971,7 @@ static int rtw89_wow_pattern_generate(struct rtw89_dev *rtwdev,
 }
 
 static int rtw89_wow_parse_patterns(struct rtw89_dev *rtwdev,
-				    struct rtw89_vif *rtwvif,
+				    struct rtw89_vif_link *rtwvif_link,
 				    struct cfg80211_wowlan *wowlan)
 {
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
@@ -983,7 +984,7 @@ static int rtw89_wow_parse_patterns(struct rtw89_dev *rtwdev,
 
 	for (i = 0; i < wowlan->n_patterns; i++) {
 		rtw_pattern = &rtw_wow->patterns[i];
-		ret = rtw89_wow_pattern_generate(rtwdev, rtwvif,
+		ret = rtw89_wow_pattern_generate(rtwdev, rtwvif_link,
 						 &wowlan->patterns[i],
 						 rtw_pattern);
 		if (ret) {
@@ -1066,7 +1067,7 @@ static int rtw89_wow_set_wakeups(struct rtw89_dev *rtwdev,
 				 struct cfg80211_wowlan *wowlan)
 {
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
-	struct rtw89_vif *rtwvif;
+	struct rtw89_vif_link *rtwvif_link;
 
 	if (wowlan->disconnect)
 		set_bit(RTW89_WOW_FLAG_EN_DISCONNECT, rtw_wow->flags);
@@ -1078,36 +1079,36 @@ static int rtw89_wow_set_wakeups(struct rtw89_dev *rtwdev,
 	if (wowlan->nd_config)
 		rtw89_wow_init_pno(rtwdev, wowlan->nd_config);
 
-	rtw89_for_each_rtwvif(rtwdev, rtwvif)
-		rtw89_wow_vif_iter(rtwdev, rtwvif);
+	rtw89_for_each_rtwvif(rtwdev, rtwvif_link)
+		rtw89_wow_vif_iter(rtwdev, rtwvif_link);
 
 	if (!rtw_wow->wow_vif)
 		return -EPERM;
 
-	rtwvif = (struct rtw89_vif *)rtw_wow->wow_vif->drv_priv;
-	return rtw89_wow_parse_patterns(rtwdev, rtwvif, wowlan);
+	rtwvif_link = (struct rtw89_vif_link *)rtw_wow->wow_vif->drv_priv;
+	return rtw89_wow_parse_patterns(rtwdev, rtwvif_link, wowlan);
 }
 
 static int rtw89_wow_cfg_wake_pno(struct rtw89_dev *rtwdev, bool wow)
 {
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
 	struct ieee80211_vif *wow_vif = rtw_wow->wow_vif;
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)wow_vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)wow_vif->drv_priv;
 	int ret;
 
-	ret = rtw89_fw_h2c_cfg_pno(rtwdev, rtwvif, true);
+	ret = rtw89_fw_h2c_cfg_pno(rtwdev, rtwvif_link, true);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to config pno\n");
 		return ret;
 	}
 
-	ret = rtw89_fw_h2c_wow_wakeup_ctrl(rtwdev, rtwvif, wow);
+	ret = rtw89_fw_h2c_wow_wakeup_ctrl(rtwdev, rtwvif_link, wow);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to fw wow wakeup ctrl\n");
 		return ret;
 	}
 
-	ret = rtw89_fw_h2c_wow_global(rtwdev, rtwvif, wow);
+	ret = rtw89_fw_h2c_wow_global(rtwdev, rtwvif_link, wow);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to fw wow global\n");
 		return ret;
@@ -1120,33 +1121,33 @@ static int rtw89_wow_cfg_wake(struct rtw89_dev *rtwdev, bool wow)
 {
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
 	struct ieee80211_vif *wow_vif = rtw_wow->wow_vif;
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)wow_vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)wow_vif->drv_priv;
 	struct ieee80211_sta *wow_sta;
 	struct rtw89_sta *rtwsta = NULL;
 	int ret;
 
-	wow_sta = ieee80211_find_sta(wow_vif, rtwvif->bssid);
+	wow_sta = ieee80211_find_sta(wow_vif, rtwvif_link->bssid);
 	if (wow_sta)
 		rtwsta = (struct rtw89_sta *)wow_sta->drv_priv;
 
 	if (wow) {
 		if (rtw_wow->pattern_cnt)
-			rtwvif->wowlan_pattern = true;
+			rtwvif_link->wowlan_pattern = true;
 		if (test_bit(RTW89_WOW_FLAG_EN_MAGIC_PKT, rtw_wow->flags))
-			rtwvif->wowlan_magic = true;
+			rtwvif_link->wowlan_magic = true;
 	} else {
-		rtwvif->wowlan_pattern = false;
-		rtwvif->wowlan_magic = false;
+		rtwvif_link->wowlan_pattern = false;
+		rtwvif_link->wowlan_magic = false;
 	}
 
-	ret = rtw89_fw_h2c_wow_wakeup_ctrl(rtwdev, rtwvif, wow);
+	ret = rtw89_fw_h2c_wow_wakeup_ctrl(rtwdev, rtwvif_link, wow);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to fw wow wakeup ctrl\n");
 		return ret;
 	}
 
 	if (wow) {
-		ret = rtw89_chip_h2c_dctl_sec_cam(rtwdev, rtwvif, rtwsta);
+		ret = rtw89_chip_h2c_dctl_sec_cam(rtwdev, rtwvif_link, rtwsta);
 		if (ret) {
 			rtw89_err(rtwdev, "failed to update dctl cam sec entry: %d\n",
 				  ret);
@@ -1154,13 +1155,13 @@ static int rtw89_wow_cfg_wake(struct rtw89_dev *rtwdev, bool wow)
 		}
 	}
 
-	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif, rtwsta, NULL);
+	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif_link, rtwsta, NULL);
 	if (ret) {
 		rtw89_warn(rtwdev, "failed to send h2c cam\n");
 		return ret;
 	}
 
-	ret = rtw89_fw_h2c_wow_global(rtwdev, rtwvif, wow);
+	ret = rtw89_fw_h2c_wow_global(rtwdev, rtwvif_link, wow);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to fw wow global\n");
 		return ret;
@@ -1191,7 +1192,7 @@ static int rtw89_wow_swap_fw(struct rtw89_dev *rtwdev, bool wow)
 	enum rtw89_chip_gen chip_gen = rtwdev->chip->chip_gen;
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
 	struct ieee80211_vif *wow_vif = rtw_wow->wow_vif;
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)wow_vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)wow_vif->drv_priv;
 	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	bool include_bb = !!chip->bbmcu_nr;
@@ -1204,7 +1205,7 @@ static int rtw89_wow_swap_fw(struct rtw89_dev *rtwdev, bool wow)
 	if (chip_id == RTL8852C || chip_id == RTL8922A)
 		disable_intr_for_dlfw = true;
 
-	wow_sta = ieee80211_find_sta(wow_vif, rtwvif->bssid);
+	wow_sta = ieee80211_find_sta(wow_vif, rtwvif_link->bssid);
 	if (wow_sta)
 		rtwsta = (struct rtw89_sta *)wow_sta->drv_priv;
 	else
@@ -1224,7 +1225,7 @@ static int rtw89_wow_swap_fw(struct rtw89_dev *rtwdev, bool wow)
 
 	rtw89_phy_init_rf_reg(rtwdev, true);
 
-	ret = rtw89_fw_h2c_role_maintain(rtwdev, rtwvif, rtwsta,
+	ret = rtw89_fw_h2c_role_maintain(rtwdev, rtwvif_link, rtwsta,
 					 RTW89_ROLE_FW_RESTORE);
 	if (ret) {
 		rtw89_warn(rtwdev, "failed to send h2c role maintain\n");
@@ -1240,20 +1241,20 @@ static int rtw89_wow_swap_fw(struct rtw89_dev *rtwdev, bool wow)
 	if (!is_conn)
 		rtw89_cam_reset_keys(rtwdev);
 
-	ret = rtw89_fw_h2c_join_info(rtwdev, rtwvif, rtwsta, !is_conn);
+	ret = rtw89_fw_h2c_join_info(rtwdev, rtwvif_link, rtwsta, !is_conn);
 	if (ret) {
 		rtw89_warn(rtwdev, "failed to send h2c join info\n");
 		return ret;
 	}
 
-	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif, rtwsta, NULL);
+	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif_link, rtwsta, NULL);
 	if (ret) {
 		rtw89_warn(rtwdev, "failed to send h2c cam\n");
 		return ret;
 	}
 
 	if (is_conn) {
-		ret = rtw89_fw_h2c_general_pkt(rtwdev, rtwvif, rtwsta->mac_id);
+		ret = rtw89_fw_h2c_general_pkt(rtwdev, rtwvif_link, rtwsta->mac_id);
 		if (ret) {
 			rtw89_warn(rtwdev, "failed to send h2c general packet\n");
 			return ret;
@@ -1377,7 +1378,7 @@ static int rtw89_wow_disable_trx_post(struct rtw89_dev *rtwdev)
 }
 
 static void rtw89_fw_release_pno_pkt_list(struct rtw89_dev *rtwdev,
-					  struct rtw89_vif *rtwvif)
+					  struct rtw89_vif_link *rtwvif_link)
 {
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
 	struct list_head *pkt_list = &rtw_wow->pno_pkt_list;
@@ -1391,7 +1392,7 @@ static void rtw89_fw_release_pno_pkt_list(struct rtw89_dev *rtwdev,
 }
 
 static int rtw89_pno_scan_update_probe_req(struct rtw89_dev *rtwdev,
-					   struct rtw89_vif *rtwvif)
+					   struct rtw89_vif_link *rtwvif_link)
 {
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
 	struct cfg80211_sched_scan_request *nd_config = rtw_wow->nd_config;
@@ -1401,7 +1402,7 @@ static int rtw89_pno_scan_update_probe_req(struct rtw89_dev *rtwdev,
 	int ret;
 
 	for (i = 0; i < num; i++) {
-		skb = ieee80211_probereq_get(rtwdev->hw, rtwvif->mac_addr,
+		skb = ieee80211_probereq_get(rtwdev->hw, rtwvif_link->mac_addr,
 					     nd_config->match_sets[i].ssid.ssid,
 					     nd_config->match_sets[i].ssid.ssid_len,
 					     nd_config->ie_len);
@@ -1413,7 +1414,7 @@ static int rtw89_pno_scan_update_probe_req(struct rtw89_dev *rtwdev,
 		info = kzalloc(sizeof(*info), GFP_KERNEL);
 		if (!info) {
 			kfree_skb(skb);
-			rtw89_fw_release_pno_pkt_list(rtwdev, rtwvif);
+			rtw89_fw_release_pno_pkt_list(rtwdev, rtwvif_link);
 			return -ENOMEM;
 		}
 
@@ -1421,7 +1422,7 @@ static int rtw89_pno_scan_update_probe_req(struct rtw89_dev *rtwdev,
 		if (ret) {
 			kfree_skb(skb);
 			kfree(info);
-			rtw89_fw_release_pno_pkt_list(rtwdev, rtwvif);
+			rtw89_fw_release_pno_pkt_list(rtwdev, rtwvif_link);
 			return ret;
 		}
 
@@ -1437,19 +1438,19 @@ static int rtw89_pno_scan_offload(struct rtw89_dev *rtwdev, bool enable)
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
 	struct ieee80211_vif *wow_vif = rtw_wow->wow_vif;
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)wow_vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)wow_vif->drv_priv;
 	int interval = rtw_wow->nd_config->scan_plans[0].interval;
 	struct rtw89_scan_option opt = {};
 	int ret;
 
 	if (enable) {
-		ret = rtw89_pno_scan_update_probe_req(rtwdev, rtwvif);
+		ret = rtw89_pno_scan_update_probe_req(rtwdev, rtwvif_link);
 		if (ret) {
 			rtw89_err(rtwdev, "Update probe request failed\n");
 			return ret;
 		}
 
-		ret = mac->add_chan_list_pno(rtwdev, rtwvif);
+		ret = mac->add_chan_list_pno(rtwdev, rtwvif_link);
 		if (ret) {
 			rtw89_err(rtwdev, "Update channel list failed\n");
 			return ret;
@@ -1471,7 +1472,7 @@ static int rtw89_pno_scan_offload(struct rtw89_dev *rtwdev, bool enable)
 		opt.opch_end = RTW89_CHAN_INVALID;
 	}
 
-	mac->scan_offload(rtwdev, &opt, rtwvif, true);
+	mac->scan_offload(rtwdev, &opt, rtwvif_link, true);
 
 	return 0;
 }
@@ -1480,7 +1481,7 @@ static int rtw89_wow_fw_start(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
 	struct ieee80211_vif *wow_vif = rtw_wow->wow_vif;
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)wow_vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)wow_vif->drv_priv;
 	int ret;
 
 	if (rtw89_wow_no_link(rtwdev)) {
@@ -1499,25 +1500,25 @@ static int rtw89_wow_fw_start(struct rtw89_dev *rtwdev)
 		rtw89_wow_pattern_write(rtwdev);
 		rtw89_wow_construct_key_info(rtwdev);
 
-		ret = rtw89_fw_h2c_keep_alive(rtwdev, rtwvif, true);
+		ret = rtw89_fw_h2c_keep_alive(rtwdev, rtwvif_link, true);
 		if (ret) {
 			rtw89_err(rtwdev, "wow: failed to enable keep alive\n");
 			return ret;
 		}
 
-		ret = rtw89_fw_h2c_disconnect_detect(rtwdev, rtwvif, true);
+		ret = rtw89_fw_h2c_disconnect_detect(rtwdev, rtwvif_link, true);
 		if (ret) {
 			rtw89_err(rtwdev, "wow: failed to enable disconnect detect\n");
 			return ret;
 		}
 
-		ret = rtw89_fw_h2c_wow_gtk_ofld(rtwdev, rtwvif, true);
+		ret = rtw89_fw_h2c_wow_gtk_ofld(rtwdev, rtwvif_link, true);
 		if (ret) {
 			rtw89_err(rtwdev, "wow: failed to enable GTK offload\n");
 			return ret;
 		}
 
-		ret = rtw89_fw_h2c_arp_offload(rtwdev, rtwvif, true);
+		ret = rtw89_fw_h2c_arp_offload(rtwdev, rtwvif_link, true);
 		if (ret)
 			rtw89_warn(rtwdev, "wow: failed to enable arp offload\n");
 	}
@@ -1549,7 +1550,7 @@ static int rtw89_wow_fw_stop(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
 	struct ieee80211_vif *wow_vif = rtw_wow->wow_vif;
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)wow_vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)wow_vif->drv_priv;
 	int ret;
 
 	if (rtw89_wow_no_link(rtwdev)) {
@@ -1559,35 +1560,35 @@ static int rtw89_wow_fw_stop(struct rtw89_dev *rtwdev)
 			return ret;
 		}
 
-		ret = rtw89_fw_h2c_cfg_pno(rtwdev, rtwvif, false);
+		ret = rtw89_fw_h2c_cfg_pno(rtwdev, rtwvif_link, false);
 		if (ret) {
 			rtw89_err(rtwdev, "wow: failed to disable pno\n");
 			return ret;
 		}
 
-		rtw89_fw_release_pno_pkt_list(rtwdev, rtwvif);
+		rtw89_fw_release_pno_pkt_list(rtwdev, rtwvif_link);
 	} else {
 		rtw89_wow_pattern_clear(rtwdev);
 
-		ret = rtw89_fw_h2c_keep_alive(rtwdev, rtwvif, false);
+		ret = rtw89_fw_h2c_keep_alive(rtwdev, rtwvif_link, false);
 		if (ret) {
 			rtw89_err(rtwdev, "wow: failed to disable keep alive\n");
 			return ret;
 		}
 
-		ret = rtw89_fw_h2c_disconnect_detect(rtwdev, rtwvif, false);
+		ret = rtw89_fw_h2c_disconnect_detect(rtwdev, rtwvif_link, false);
 		if (ret) {
 			rtw89_err(rtwdev, "wow: failed to disable disconnect detect\n");
 			return ret;
 		}
 
-		ret = rtw89_fw_h2c_wow_gtk_ofld(rtwdev, rtwvif, false);
+		ret = rtw89_fw_h2c_wow_gtk_ofld(rtwdev, rtwvif_link, false);
 		if (ret) {
 			rtw89_err(rtwdev, "wow: failed to disable GTK offload\n");
 			return ret;
 		}
 
-		ret = rtw89_fw_h2c_arp_offload(rtwdev, rtwvif, false);
+		ret = rtw89_fw_h2c_arp_offload(rtwdev, rtwvif_link, false);
 		if (ret)
 			rtw89_warn(rtwdev, "wow: failed to disable arp offload\n");
 
diff --git a/drivers/net/wireless/realtek/rtw89/wow.h b/drivers/net/wireless/realtek/rtw89/wow.h
index 3fbc2b87c058..a80b4b84587d 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.h
+++ b/drivers/net/wireless/realtek/rtw89/wow.h
@@ -98,17 +98,17 @@ static inline int rtw89_wow_get_sec_hdr_len(struct rtw89_dev *rtwdev)
 static inline bool rtw89_wow_mgd_linked(struct rtw89_dev *rtwdev)
 {
 	struct ieee80211_vif *wow_vif = rtwdev->wow.wow_vif;
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)wow_vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)wow_vif->drv_priv;
 
-	return rtwvif->net_type == RTW89_NET_TYPE_INFRA;
+	return rtwvif_link->net_type == RTW89_NET_TYPE_INFRA;
 }
 
 static inline bool rtw89_wow_no_link(struct rtw89_dev *rtwdev)
 {
 	struct ieee80211_vif *wow_vif = rtwdev->wow.wow_vif;
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)wow_vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)wow_vif->drv_priv;
 
-	return rtwvif->net_type == RTW89_NET_TYPE_NO_LINK;
+	return rtwvif_link->net_type == RTW89_NET_TYPE_NO_LINK;
 }
 
 static inline bool rtw_wow_has_mgd_features(struct rtw89_dev *rtwdev)
-- 
2.25.1


