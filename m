Return-Path: <linux-wireless+bounces-12882-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C29979AD0
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2024 07:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A07911C229D0
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2024 05:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA3738FA3;
	Mon, 16 Sep 2024 05:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="QA1IrVgK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DBF4501E
	for <linux-wireless@vger.kernel.org>; Mon, 16 Sep 2024 05:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726464804; cv=none; b=pN4rlh2Q1fdXNARoLHmLQ+AwnpDTTZBM/px9DAF04X75WqCGCP7GE3+lzx7gRqarxnLGqVOgUw3bG6C2f2CNpxlz4aRKsDbyzk5pF7dsl7V7jpkA+FWs9GZcPd4Iw57ZYDOp2M/J83VBazAbj/fzdE1FiiPRPQc5113MUnJMvOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726464804; c=relaxed/simple;
	bh=UaoVjKmXA51uA44QYcdqkl4dELXI2cmeAR0Dh65Xw0s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=it5MhVe1yhAV39qON4VZ1sWenXxqL9OWPuH9UTinPr2XxYPSGrPd904IEK1YqRe/bc0jfTXfpn+geHP5emj3I0OnGN0zUoAdroP/NNWKlWjRHFWXkEy0lKdxUpCTI2rp6h27nU1/p9t0zm6HwrB2M3+FAvCk+gMUjFJmNlrctzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=QA1IrVgK; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48G5XFVA02631833, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1726464795; bh=UaoVjKmXA51uA44QYcdqkl4dELXI2cmeAR0Dh65Xw0s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=QA1IrVgKTYMYaQhz0GFz9SbeVomP1e0XivSKwHSnsgTtusCs+Nt9D3VlMUhn8KAHx
	 LsFSgq9X0oZ2pPRKnoELoATUuJ+JbJoRgBRIv4xPlpsOXgHgwuQffvSKs/FL965oZS
	 fCRoGEhH0/Gl/8TDt4sgYbW6Hrziurwp62dGUW9/H6IDgOU60zLWld5cbKt0+yDWSN
	 JD2kb6k/V0mS9uNhZkHI9CPQL2bVl74yEWFmij//XptVQKpw+T7TbNOpvgoQslcWej
	 5T5oWuzXIOYIngOY4fgTiZv/9tstoqHSVXKwD+6AtJtTAErCI4o9kKzLo/xhzVqsJx
	 IJkEjJbZEDLdg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48G5XFVA02631833
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 16 Sep 2024 13:33:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Sep 2024 13:33:16 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 16 Sep
 2024 13:33:14 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 7/7] wifi: rtw89: tweak driver architecture for impending MLO support
Date: Mon, 16 Sep 2024 13:31:58 +0800
Message-ID: <20240916053158.47350-8-pkshih@realtek.com>
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

The drv_priv hooked to mac80211 become as below.

                           (drv_priv)             (instance-0)
 +---------------+       +-----------+          +----------------+
 | ieee80211_vif | <---> | rtw89_vif | -------> | rtw89_vif_link |
 +---------------+       +-----------+    |     +----------------+
                                          |
                                          |       (instance-1)
                                          |     +----------------+
                                          +---> | rtw89_vif_link |
                                                +----------------+

                           (drv_priv)             (instance-0)
 +---------------+       +-----------+          +----------------+
 | ieee80211_sta | <---> | rtw89_sta | -------> | rtw89_sta_link |
 +---------------+       +-----------+    |     +----------------+
                                          |
                                          |       (instance-1)
                                          |     +----------------+
                                          +---> | rtw89_sta_link |
                                                +----------------+

The relation bewteen mac80211 link_id and our link instance is like below.

                 |\
 (link_id)       | \
     0  -------- |  |
     1  -------- |  | ------ instance-0 (link_id: X) -> work on HW band 0
     2  -------- |  |
     ...         |  | ------ instance-1 (link_id: Y) -> work on HW band 1
     14 -------- |  |
                 | /
                 |/

	N.B. For cases of non-MLD connection, we set our link instance-0
	active with link_id 0. So, our code flow can be compatible between
	non-MLD connection and MLD connection.

Based on above, we tweak entire driver architecture first. But, we don't
dynamically enable multiple links here. That will be handled separately.
Most of the things changed here are changing flows to iterate all active
links and read bss_conf/link_sta data according to target link. And, for
cases of scan, ROC, WOW, we use instance-0 to deal with the request.

There are some things listed below, which work for now but need to extend
before multiple active links.
	1. tx path
		select suitable link instance among multiple active links
	2. rx path
		determine rx link by PPDU instead of always link instance-0
	3. CAM
		apply MLD pairwise key to any active links dynamically

Besides, PS code cannot easily work along with tweaking architecture. With
supporting MLO flag (currently false), we disable PS first and will fix it
by another commit in the following.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/cam.c      | 126 ++++-
 drivers/net/wireless/realtek/rtw89/chan.c     |  77 ++-
 drivers/net/wireless/realtek/rtw89/coex.c     |  54 +-
 drivers/net/wireless/realtek/rtw89/core.c     | 504 +++++++++++++-----
 drivers/net/wireless/realtek/rtw89/core.h     | 240 +++++++--
 drivers/net/wireless/realtek/rtw89/debug.c    |  85 ++-
 drivers/net/wireless/realtek/rtw89/fw.c       | 147 ++---
 drivers/net/wireless/realtek/rtw89/fw.h       |  72 ++-
 drivers/net/wireless/realtek/rtw89/mac.c      | 137 +++--
 drivers/net/wireless/realtek/rtw89/mac.h      |   2 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c | 423 +++++++++++----
 drivers/net/wireless/realtek/rtw89/phy.c      | 134 +++--
 drivers/net/wireless/realtek/rtw89/ps.c       |  33 +-
 drivers/net/wireless/realtek/rtw89/regd.c     |  40 +-
 drivers/net/wireless/realtek/rtw89/ser.c      |  63 ++-
 drivers/net/wireless/realtek/rtw89/util.h     |   8 +-
 drivers/net/wireless/realtek/rtw89/wow.c      |  99 ++--
 drivers/net/wireless/realtek/rtw89/wow.h      |   6 +-
 18 files changed, 1615 insertions(+), 635 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/cam.c b/drivers/net/wireless/realtek/rtw89/cam.c
index 7efc6280feaf..8d140b94cb44 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.c
+++ b/drivers/net/wireless/realtek/rtw89/cam.c
@@ -211,24 +211,16 @@ static int rtw89_cam_get_addr_cam_key_idx(struct rtw89_addr_cam_entry *addr_cam,
 	return 0;
 }
 
-static int rtw89_cam_detach_sec_cam(struct rtw89_dev *rtwdev,
-				    struct ieee80211_vif *vif,
-				    struct ieee80211_sta *sta,
-				    const struct rtw89_sec_cam_entry *sec_cam,
-				    bool inform_fw)
+static int __rtw89_cam_detach_sec_cam(struct rtw89_dev *rtwdev,
+				      struct rtw89_vif_link *rtwvif_link,
+				      struct rtw89_sta_link *rtwsta_link,
+				      const struct rtw89_sec_cam_entry *sec_cam,
+				      bool inform_fw)
 {
-	struct rtw89_sta_link *rtwsta_link = sta_to_rtwsta_safe(sta);
-	struct rtw89_vif_link *rtwvif_link;
 	struct rtw89_addr_cam_entry *addr_cam;
 	unsigned int i;
 	int ret = 0;
 
-	if (!vif) {
-		rtw89_err(rtwdev, "No iface for deleting sec cam\n");
-		return -EINVAL;
-	}
-
-	rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 	addr_cam = rtw89_get_addr_cam_of(rtwvif_link, rtwsta_link);
 
 	for_each_set_bit(i, addr_cam->sec_cam_map, RTW89_SEC_CAM_IN_ADDR_CAM) {
@@ -251,24 +243,16 @@ static int rtw89_cam_detach_sec_cam(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
-static int rtw89_cam_attach_sec_cam(struct rtw89_dev *rtwdev,
-				    struct ieee80211_vif *vif,
-				    struct ieee80211_sta *sta,
-				    struct ieee80211_key_conf *key,
-				    struct rtw89_sec_cam_entry *sec_cam)
+static int __rtw89_cam_attach_sec_cam(struct rtw89_dev *rtwdev,
+				      struct rtw89_vif_link *rtwvif_link,
+				      struct rtw89_sta_link *rtwsta_link,
+				      struct ieee80211_key_conf *key,
+				      struct rtw89_sec_cam_entry *sec_cam)
 {
-	struct rtw89_sta_link *rtwsta_link = sta_to_rtwsta_safe(sta);
-	struct rtw89_vif_link *rtwvif_link;
 	struct rtw89_addr_cam_entry *addr_cam;
 	u8 key_idx = 0;
 	int ret;
 
-	if (!vif) {
-		rtw89_err(rtwdev, "No iface for adding sec cam\n");
-		return -EINVAL;
-	}
-
-	rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 	addr_cam = rtw89_get_addr_cam_of(rtwvif_link, rtwsta_link);
 
 	if (key->cipher == WLAN_CIPHER_SUITE_WEP40 ||
@@ -302,6 +286,92 @@ static int rtw89_cam_attach_sec_cam(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
+static int rtw89_cam_detach_sec_cam(struct rtw89_dev *rtwdev,
+				    struct ieee80211_vif *vif,
+				    struct ieee80211_sta *sta,
+				    const struct rtw89_sec_cam_entry *sec_cam,
+				    bool inform_fw)
+{
+	struct rtw89_sta *rtwsta = sta_to_rtwsta_safe(sta);
+	struct rtw89_sta_link *rtwsta_link;
+	struct rtw89_vif_link *rtwvif_link;
+	struct rtw89_vif *rtwvif;
+	unsigned int link_id;
+	int ret;
+
+	if (!vif) {
+		rtw89_err(rtwdev, "No iface for deleting sec cam\n");
+		return -EINVAL;
+	}
+
+	rtwvif = vif_to_rtwvif(vif);
+
+	rtw89_vif_for_each_link(rtwvif, rtwvif_link, link_id) {
+		rtwsta_link = rtwsta ? rtwsta->links[link_id] : NULL;
+		if (rtwsta && !rtwsta_link)
+			continue;
+
+		ret = __rtw89_cam_detach_sec_cam(rtwdev, rtwvif_link, rtwsta_link,
+						 sec_cam, inform_fw);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int rtw89_cam_attach_sec_cam(struct rtw89_dev *rtwdev,
+				    struct ieee80211_vif *vif,
+				    struct ieee80211_sta *sta,
+				    struct ieee80211_key_conf *key,
+				    struct rtw89_sec_cam_entry *sec_cam)
+{
+	struct rtw89_sta *rtwsta = sta_to_rtwsta_safe(sta);
+	struct rtw89_sta_link *rtwsta_link;
+	struct rtw89_vif_link *rtwvif_link;
+	struct rtw89_vif *rtwvif;
+	unsigned int link_id;
+	int key_link_id;
+	int ret;
+
+	if (!vif) {
+		rtw89_err(rtwdev, "No iface for adding sec cam\n");
+		return -EINVAL;
+	}
+
+	rtwvif = vif_to_rtwvif(vif);
+
+	key_link_id = ieee80211_vif_is_mld(vif) ? key->link_id : 0;
+	if (key_link_id >= 0) {
+		rtwvif_link = rtwvif->links[key_link_id];
+		rtwsta_link = rtwsta ? rtwsta->links[key_link_id] : NULL;
+
+		if (!rtwvif_link || (rtwsta && !rtwsta_link)) {
+			rtw89_err(rtwdev, "No drv link for adding sec cam\n");
+			return -ENOLINK;
+		}
+
+		return __rtw89_cam_attach_sec_cam(rtwdev, rtwvif_link,
+						  rtwsta_link, key, sec_cam);
+	}
+
+	/* key_link_id < 0: MLD pairwise key */
+	if (!rtwsta) {
+		rtw89_err(rtwdev, "No sta for adding MLD pairwise sec cam\n");
+		return -EINVAL;
+	}
+
+	rtw89_sta_for_each_link(rtwsta, rtwsta_link, link_id) {
+		rtwvif_link = rtwsta_link->rtwvif_link;
+		ret = __rtw89_cam_attach_sec_cam(rtwdev, rtwvif_link,
+						 rtwsta_link, key, sec_cam);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int rtw89_cam_sec_key_install(struct rtw89_dev *rtwdev,
 				     struct ieee80211_vif *vif,
 				     struct ieee80211_sta *sta,
@@ -708,10 +778,10 @@ void rtw89_cam_fill_addr_cam_info(struct rtw89_dev *rtwdev,
 				  const u8 *scan_mac_addr,
 				  u8 *cmd)
 {
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
+	struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
 	struct rtw89_addr_cam_entry *addr_cam =
 		rtw89_get_addr_cam_of(rtwvif_link, rtwsta_link);
-	struct ieee80211_sta *sta = rtwsta_to_sta_safe(rtwsta_link);
+	struct ieee80211_sta *sta = rtwsta_link_to_sta_safe(rtwsta_link);
 	struct ieee80211_link_sta *link_sta;
 	const u8 *sma = scan_mac_addr ? scan_mac_addr : rtwvif_link->mac_addr;
 	u8 sma_hash, tma_hash, addr_msk_start;
diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 2968c299203b..ba6332da8019 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -234,12 +234,24 @@ void rtw89_entity_init(struct rtw89_dev *rtwdev)
 	rtw89_config_default_chandef(rtwdev);
 }
 
+static bool rtw89_vif_is_active_role(struct rtw89_vif *rtwvif)
+{
+	struct rtw89_vif_link *rtwvif_link;
+	unsigned int link_id;
+
+	rtw89_vif_for_each_link(rtwvif, rtwvif_link, link_id)
+		if (rtwvif_link->chanctx_assigned)
+			return true;
+
+	return false;
+}
+
 static void rtw89_entity_calculate_weight(struct rtw89_dev *rtwdev,
 					  struct rtw89_entity_weight *w)
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
 	const struct rtw89_chanctx_cfg *cfg;
-	struct rtw89_vif_link *rtwvif_link;
+	struct rtw89_vif *rtwvif;
 	int idx;
 
 	for_each_set_bit(idx, hal->entity_map, NUM_OF_RTW89_CHANCTX) {
@@ -254,8 +266,8 @@ static void rtw89_entity_calculate_weight(struct rtw89_dev *rtwdev,
 			w->active_chanctxs++;
 	}
 
-	rtw89_for_each_rtwvif(rtwdev, rtwvif_link) {
-		if (rtwvif_link->chanctx_assigned)
+	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
+		if (rtw89_vif_is_active_role(rtwvif))
 			w->active_roles++;
 	}
 }
@@ -522,14 +534,22 @@ u32 rtw89_mcc_role_fw_macid_bitmap_to_u32(struct rtw89_mcc_role *mcc_role)
 
 static void rtw89_mcc_role_macid_sta_iter(void *data, struct ieee80211_sta *sta)
 {
-	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
-	struct rtw89_vif_link *rtwvif_link = rtwsta_link->rtwvif_link;
 	struct rtw89_mcc_role *mcc_role = data;
-	struct rtw89_vif_link *target = mcc_role->rtwvif_link;
+	struct rtw89_vif *target = mcc_role->rtwvif_link->rtwvif;
+	struct rtw89_sta *rtwsta = sta_to_rtwsta(sta);
+	struct rtw89_vif *rtwvif = rtwsta->rtwvif;
+	struct rtw89_dev *rtwdev = rtwsta->rtwdev;
+	struct rtw89_sta_link *rtwsta_link;
 
-	if (rtwvif_link != target)
+	if (rtwvif != target)
 		return;
 
+	rtwsta_link = rtw89_sta_get_link_inst(rtwsta, 0);
+	if (unlikely(!rtwsta_link)) {
+		rtw89_err(rtwdev, "mcc sta macid: find no link on HW-0\n");
+		return;
+	}
+
 	rtw89_mcc_role_fw_macid_bitmap_set_bit(mcc_role, rtwsta_link->mac_id);
 }
 
@@ -605,7 +625,7 @@ static void rtw89_mcc_fill_role_limit(struct rtw89_dev *rtwdev,
 		return;
 	}
 
-	ret = rtw89_mac_port_get_tsf(rtwdev, mcc_role->rtwvif_link, &tsf);
+	ret = rtw89_mac_port_get_tsf(rtwdev, rtwvif_link, &tsf);
 	if (ret) {
 		rtw89_warn(rtwdev, "MCC failed to get port tsf: %d\n", ret);
 		return;
@@ -727,12 +747,19 @@ static int rtw89_mcc_fill_all_roles(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_mcc_fill_role_selector sel = {};
 	struct rtw89_vif_link *rtwvif_link;
+	struct rtw89_vif *rtwvif;
 	int ret;
 
-	rtw89_for_each_rtwvif(rtwdev, rtwvif_link) {
-		if (!rtwvif_link->chanctx_assigned)
+	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
+		if (!rtw89_vif_is_active_role(rtwvif))
 			continue;
 
+		rtwvif_link = rtw89_vif_get_link_inst(rtwvif, 0);
+		if (unlikely(!rtwvif_link)) {
+			rtw89_err(rtwdev, "mcc fill roles: find no link on HW-0\n");
+			continue;
+		}
+
 		if (sel.bind_vif[rtwvif_link->chanctx_idx]) {
 			rtw89_warn(rtwdev,
 				   "MCC skip extra vif <macid %d> on chanctx[%d]\n",
@@ -2384,12 +2411,30 @@ void rtw89_chanctx_proceed(struct rtw89_dev *rtwdev)
 	rtw89_queue_chanctx_work(rtwdev);
 }
 
+static void __rtw89_swap_chanctx(struct rtw89_vif *rtwvif,
+				 enum rtw89_chanctx_idx idx1,
+				 enum rtw89_chanctx_idx idx2)
+{
+	struct rtw89_vif_link *rtwvif_link;
+	unsigned int link_id;
+
+	rtw89_vif_for_each_link(rtwvif, rtwvif_link, link_id) {
+		if (!rtwvif_link->chanctx_assigned)
+			continue;
+
+		if (rtwvif_link->chanctx_idx == idx1)
+			rtwvif_link->chanctx_idx = idx2;
+		else if (rtwvif_link->chanctx_idx == idx2)
+			rtwvif_link->chanctx_idx = idx1;
+	}
+}
+
 static void rtw89_swap_chanctx(struct rtw89_dev *rtwdev,
 			       enum rtw89_chanctx_idx idx1,
 			       enum rtw89_chanctx_idx idx2)
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
-	struct rtw89_vif_link *rtwvif_link;
+	struct rtw89_vif *rtwvif;
 	u8 cur;
 
 	if (idx1 == idx2)
@@ -2400,14 +2445,8 @@ static void rtw89_swap_chanctx(struct rtw89_dev *rtwdev,
 
 	swap(hal->chanctx[idx1], hal->chanctx[idx2]);
 
-	rtw89_for_each_rtwvif(rtwdev, rtwvif_link) {
-		if (!rtwvif_link->chanctx_assigned)
-			continue;
-		if (rtwvif_link->chanctx_idx == idx1)
-			rtwvif_link->chanctx_idx = idx2;
-		else if (rtwvif_link->chanctx_idx == idx2)
-			rtwvif_link->chanctx_idx = idx1;
-	}
+	rtw89_for_each_rtwvif(rtwdev, rtwvif)
+		__rtw89_swap_chanctx(rtwvif, idx1, idx2);
 
 	cur = atomic_read(&hal->roc_chanctx_idx);
 	if (cur == idx1)
diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index e4ae80742ba3..3b3fd451e445 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -4989,13 +4989,11 @@ struct rtw89_txtime_data {
 	bool reenable;
 };
 
-static void rtw89_tx_time_iter(void *data, struct ieee80211_sta *sta)
+static void __rtw89_tx_time_iter(struct rtw89_vif_link *rtwvif_link,
+				 struct rtw89_sta_link *rtwsta_link,
+				 struct rtw89_txtime_data *iter_data)
 {
-	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
-	struct rtw89_txtime_data *iter_data =
-				(struct rtw89_txtime_data *)data;
 	struct rtw89_dev *rtwdev = iter_data->rtwdev;
-	struct rtw89_vif_link *rtwvif_link = rtwsta_link->rtwvif_link;
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_cx *cx = &btc->cx;
 	struct rtw89_btc_wl_info *wl = &cx->wl;
@@ -5048,6 +5046,21 @@ static void rtw89_tx_time_iter(void *data, struct ieee80211_sta *sta)
 	}
 }
 
+static void rtw89_tx_time_iter(void *data, struct ieee80211_sta *sta)
+{
+	struct rtw89_sta *rtwsta = sta_to_rtwsta(sta);
+	struct rtw89_txtime_data *iter_data =
+				(struct rtw89_txtime_data *)data;
+	struct rtw89_vif_link *rtwvif_link;
+	struct rtw89_sta_link *rtwsta_link;
+	unsigned int link_id;
+
+	rtw89_sta_for_each_link(rtwsta, rtwsta_link, link_id) {
+		rtwvif_link = rtwsta_link->rtwvif_link;
+		__rtw89_tx_time_iter(rtwvif_link, rtwsta_link, iter_data);
+	}
+}
+
 static void _set_wl_tx_limit(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
@@ -7486,7 +7499,7 @@ void rtw89_btc_ntfy_role_info(struct rtw89_dev *rtwdev,
 {
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
 						       rtwvif_link->chanctx_idx);
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
+	struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
 	struct ieee80211_bss_conf *bss_conf;
 	struct ieee80211_link_sta *link_sta;
 	struct rtw89_btc *btc = &rtwdev->btc;
@@ -7792,20 +7805,20 @@ struct rtw89_btc_wl_sta_iter_data {
 	bool is_traffic_change;
 };
 
-static void rtw89_btc_ntfy_wl_sta_iter(void *data, struct ieee80211_sta *sta)
+static
+void __rtw89_btc_ntfy_wl_sta_iter(struct rtw89_vif_link *rtwvif_link,
+				  struct rtw89_sta_link *rtwsta_link,
+				  struct rtw89_btc_wl_sta_iter_data *iter_data)
 {
-	struct rtw89_btc_wl_sta_iter_data *iter_data =
-				(struct rtw89_btc_wl_sta_iter_data *)data;
+	struct rtw89_vif *rtwvif = rtwvif_link->rtwvif;
 	struct rtw89_dev *rtwdev = iter_data->rtwdev;
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_dm *dm = &btc->dm;
 	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_wl_link_info *link_info = NULL;
-	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
 	struct rtw89_traffic_stats *link_info_t = NULL;
-	struct rtw89_vif_link *rtwvif_link = rtwsta_link->rtwvif_link;
-	struct rtw89_traffic_stats *stats = &rtwvif_link->stats;
+	struct rtw89_traffic_stats *stats = &rtwvif->stats;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_btc_wl_role_info *r;
 	struct rtw89_btc_wl_role_info_v1 *r1;
@@ -7823,7 +7836,7 @@ static void rtw89_btc_ntfy_wl_sta_iter(void *data, struct ieee80211_sta *sta)
 	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], rssi=%d\n", rssi);
 
 	link_info = &wl->link_info[port];
-	link_info->stat.traffic = rtwvif_link->stats;
+	link_info->stat.traffic = *stats;
 	link_info_t = &link_info->stat.traffic;
 
 	if (link_info->connected == MLME_NO_LINK) {
@@ -7927,6 +7940,21 @@ static void rtw89_btc_ntfy_wl_sta_iter(void *data, struct ieee80211_sta *sta)
 		iter_data->is_traffic_change = true;
 }
 
+static void rtw89_btc_ntfy_wl_sta_iter(void *data, struct ieee80211_sta *sta)
+{
+	struct rtw89_sta *rtwsta = sta_to_rtwsta(sta);
+	struct rtw89_btc_wl_sta_iter_data *iter_data =
+				(struct rtw89_btc_wl_sta_iter_data *)data;
+	struct rtw89_vif_link *rtwvif_link;
+	struct rtw89_sta_link *rtwsta_link;
+	unsigned int link_id;
+
+	rtw89_sta_for_each_link(rtwsta, rtwsta_link, link_id) {
+		rtwvif_link = rtwsta_link->rtwvif_link;
+		__rtw89_btc_ntfy_wl_sta_iter(rtwvif_link, rtwsta_link, iter_data);
+	}
+}
+
 #define BTC_NHM_CHK_INTVL 20
 
 void rtw89_btc_ntfy_wl_sta(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 8d2cca0b0a18..5b8e65f6de6a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -436,15 +436,6 @@ int rtw89_set_channel(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
-void rtw89_get_channel(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
-		       struct rtw89_chan *chan)
-{
-	const struct cfg80211_chan_def *chandef;
-
-	chandef = rtw89_chandef_get(rtwdev, rtwvif_link->chanctx_idx);
-	rtw89_get_channel_params(chandef, chan);
-}
-
 static enum rtw89_core_tx_type
 rtw89_core_get_tx_type(struct rtw89_dev *rtwdev,
 		       struct sk_buff *skb)
@@ -463,11 +454,11 @@ rtw89_core_tx_update_ampdu_info(struct rtw89_dev *rtwdev,
 				struct rtw89_core_tx_request *tx_req,
 				enum btc_pkt_type pkt_type)
 {
-	struct ieee80211_sta *sta = tx_req->sta;
+	struct rtw89_sta_link *rtwsta_link = tx_req->rtwsta_link;
 	struct rtw89_tx_desc_info *desc_info = &tx_req->desc_info;
 	struct ieee80211_link_sta *link_sta;
 	struct sk_buff *skb = tx_req->skb;
-	struct rtw89_sta_link *rtwsta_link;
+	struct rtw89_sta *rtwsta;
 	u8 ampdu_num;
 	u8 tid;
 
@@ -479,19 +470,19 @@ rtw89_core_tx_update_ampdu_info(struct rtw89_dev *rtwdev,
 	if (!(IEEE80211_SKB_CB(skb)->flags & IEEE80211_TX_CTL_AMPDU))
 		return;
 
-	if (!sta) {
+	if (!rtwsta_link) {
 		rtw89_warn(rtwdev, "cannot set ampdu info without sta\n");
 		return;
 	}
 
 	tid = skb->priority & IEEE80211_QOS_CTL_TAG1D_MASK;
-	rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
+	rtwsta = rtwsta_link->rtwsta;
 
 	rcu_read_lock();
 
 	link_sta = rtw89_sta_rcu_dereference_link(rtwsta_link, false);
-	ampdu_num = (u8)((rtwsta_link->ampdu_params[tid].agg_num ?
-			  rtwsta_link->ampdu_params[tid].agg_num :
+	ampdu_num = (u8)((rtwsta->ampdu_params[tid].agg_num ?
+			  rtwsta->ampdu_params[tid].agg_num :
 			  4 << link_sta->ht_cap.ampdu_factor) - 1);
 
 	desc_info->agg_en = true;
@@ -575,9 +566,10 @@ static u16 rtw89_core_get_mgmt_rate(struct rtw89_dev *rtwdev,
 				    const struct rtw89_chan *chan)
 {
 	struct sk_buff *skb = tx_req->skb;
+	struct rtw89_vif_link *rtwvif_link = tx_req->rtwvif_link;
+	struct rtw89_sta_link *rtwsta_link = tx_req->rtwsta_link;
 	struct ieee80211_tx_info *tx_info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_vif *vif = tx_info->control.vif;
-	struct rtw89_vif_link *rtwvif_link = vif_to_rtwvif_safe(vif);
 	struct ieee80211_bss_conf *bss_conf;
 	u16 lowest_rate;
 	u16 rate;
@@ -596,7 +588,7 @@ static u16 rtw89_core_get_mgmt_rate(struct rtw89_dev *rtwdev,
 	rcu_read_lock();
 
 	bss_conf = rtw89_vif_rcu_dereference_link(rtwvif_link, false);
-	if (!bss_conf->basic_rates || !tx_req->sta) {
+	if (!bss_conf->basic_rates || !rtwsta_link) {
 		rate = lowest_rate;
 		goto out;
 	}
@@ -612,15 +604,12 @@ static u16 rtw89_core_get_mgmt_rate(struct rtw89_dev *rtwdev,
 static u8 rtw89_core_tx_get_mac_id(struct rtw89_dev *rtwdev,
 				   struct rtw89_core_tx_request *tx_req)
 {
-	struct ieee80211_vif *vif = tx_req->vif;
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
-	struct ieee80211_sta *sta = tx_req->sta;
-	struct rtw89_sta_link *rtwsta_link;
+	struct rtw89_vif_link *rtwvif_link = tx_req->rtwvif_link;
+	struct rtw89_sta_link *rtwsta_link = tx_req->rtwsta_link;
 
-	if (!sta)
+	if (!rtwsta_link)
 		return rtwvif_link->mac_id;
 
-	rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
 	return rtwsta_link->mac_id;
 }
 
@@ -640,8 +629,7 @@ rtw89_core_tx_update_mgmt_info(struct rtw89_dev *rtwdev,
 			       struct rtw89_core_tx_request *tx_req)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
-	struct ieee80211_vif *vif = tx_req->vif;
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = tx_req->rtwvif_link;
 	struct rtw89_tx_desc_info *desc_info = &tx_req->desc_info;
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
 						       rtwvif_link->chanctx_idx);
@@ -723,8 +711,7 @@ __rtw89_core_tx_check_he_qos_htc(struct rtw89_dev *rtwdev,
 				 struct rtw89_core_tx_request *tx_req,
 				 enum btc_pkt_type pkt_type)
 {
-	struct ieee80211_sta *sta = tx_req->sta;
-	struct rtw89_sta_link *rtwsta_link = sta_to_rtwsta_safe(sta);
+	struct rtw89_sta_link *rtwsta_link = tx_req->rtwsta_link;
 	struct sk_buff *skb = tx_req->skb;
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	struct ieee80211_link_sta *link_sta;
@@ -763,8 +750,7 @@ static void
 __rtw89_core_tx_adjust_he_qos_htc(struct rtw89_dev *rtwdev,
 				  struct rtw89_core_tx_request *tx_req)
 {
-	struct ieee80211_sta *sta = tx_req->sta;
-	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
+	struct rtw89_sta_link *rtwsta_link = tx_req->rtwsta_link;
 	struct sk_buff *skb = tx_req->skb;
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	__le16 fc = hdr->frame_control;
@@ -794,8 +780,7 @@ rtw89_core_tx_update_he_qos_htc(struct rtw89_dev *rtwdev,
 				enum btc_pkt_type pkt_type)
 {
 	struct rtw89_tx_desc_info *desc_info = &tx_req->desc_info;
-	struct ieee80211_vif *vif = tx_req->vif;
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = tx_req->rtwvif_link;
 
 	if (!__rtw89_core_tx_check_he_qos_htc(rtwdev, tx_req, pkt_type))
 		goto desc_bk;
@@ -816,10 +801,9 @@ rtw89_core_tx_update_he_qos_htc(struct rtw89_dev *rtwdev,
 static u16 rtw89_core_get_data_rate(struct rtw89_dev *rtwdev,
 				    struct rtw89_core_tx_request *tx_req)
 {
-	struct ieee80211_vif *vif = tx_req->vif;
-	struct ieee80211_sta *sta = tx_req->sta;
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
-	struct rtw89_sta_link *rtwsta_link = sta_to_rtwsta_safe(sta);
+	struct rtw89_vif_link *rtwvif_link = tx_req->rtwvif_link;
+	struct rtw89_sta_link *rtwsta_link = tx_req->rtwsta_link;
+	struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
 	struct rtw89_phy_rate_pattern *rate_pattern = &rtwvif_link->rate_pattern;
 	enum rtw89_chanctx_idx idx = rtwvif_link->chanctx_idx;
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, idx);
@@ -860,10 +844,8 @@ static void
 rtw89_core_tx_update_data_info(struct rtw89_dev *rtwdev,
 			       struct rtw89_core_tx_request *tx_req)
 {
-	struct ieee80211_vif *vif = tx_req->vif;
-	struct ieee80211_sta *sta = tx_req->sta;
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
-	struct rtw89_sta_link *rtwsta_link = sta_to_rtwsta_safe(sta);
+	struct rtw89_vif_link *rtwvif_link = tx_req->rtwvif_link;
+	struct rtw89_sta_link *rtwsta_link = tx_req->rtwsta_link;
 	struct rtw89_tx_desc_info *desc_info = &tx_req->desc_info;
 	struct sk_buff *skb = tx_req->skb;
 	u8 tid, tid_indicate;
@@ -1076,16 +1058,37 @@ int rtw89_h2c_tx(struct rtw89_dev *rtwdev,
 int rtw89_core_tx_write(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 			struct ieee80211_sta *sta, struct sk_buff *skb, int *qsel)
 {
+	struct rtw89_sta *rtwsta = sta_to_rtwsta_safe(sta);
+	struct rtw89_vif *rtwvif = vif_to_rtwvif(vif);
 	struct rtw89_core_tx_request tx_req = {0};
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
+	struct rtw89_sta_link *rtwsta_link = NULL;
+	struct rtw89_vif_link *rtwvif_link;
 	int ret;
 
+	/* By default, driver writes tx via the link on HW-0. And then,
+	 * according to links' status, HW can change tx to another link.
+	 */
+
+	if (rtwsta) {
+		rtwsta_link = rtw89_sta_get_link_inst(rtwsta, 0);
+		if (unlikely(!rtwsta_link)) {
+			rtw89_err(rtwdev, "tx: find no sta link on HW-0\n");
+			return -ENOLINK;
+		}
+	}
+
+	rtwvif_link = rtw89_vif_get_link_inst(rtwvif, 0);
+	if (unlikely(!rtwvif_link)) {
+		rtw89_err(rtwdev, "tx: find no vif link on HW-0\n");
+		return -ENOLINK;
+	}
+
 	tx_req.skb = skb;
-	tx_req.sta = sta;
-	tx_req.vif = vif;
+	tx_req.rtwvif_link = rtwvif_link;
+	tx_req.rtwsta_link = rtwsta_link;
 
 	rtw89_traffic_stats_accu(rtwdev, &rtwdev->stats, skb, true);
-	rtw89_traffic_stats_accu(rtwdev, &rtwvif_link->stats, skb, true);
+	rtw89_traffic_stats_accu(rtwdev, &rtwvif->stats, skb, true);
 	rtw89_core_tx_update_desc_info(rtwdev, &tx_req);
 	rtw89_core_tx_wake(rtwdev, &tx_req);
 
@@ -1563,15 +1566,23 @@ static u8 rtw89_get_data_rate_nss(struct rtw89_dev *rtwdev, u16 data_rate)
 static void rtw89_core_rx_process_phy_ppdu_iter(void *data,
 						struct ieee80211_sta *sta)
 {
-	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
 	struct rtw89_rx_phy_ppdu *phy_ppdu = (struct rtw89_rx_phy_ppdu *)data;
-	struct rtw89_dev *rtwdev = rtwsta_link->rtwdev;
+	struct rtw89_sta *rtwsta = sta_to_rtwsta(sta);
+	struct rtw89_dev *rtwdev = rtwsta->rtwdev;
 	struct rtw89_hal *hal = &rtwdev->hal;
+	struct rtw89_sta_link *rtwsta_link;
 	u8 ant_num = hal->ant_diversity ? 2 : rtwdev->chip->rf_path_num;
 	u8 ant_pos = U8_MAX;
 	u8 evm_pos = 0;
 	int i;
 
+	/* FIXME: For single link, taking link on HW-0 here is okay. But, when
+	 * enabling multiple active links, we should determine the right link.
+	 */
+	rtwsta_link = rtw89_sta_get_link_inst(rtwsta, 0);
+	if (unlikely(!rtwsta_link))
+		return;
+
 	if (rtwsta_link->mac_id != phy_ppdu->mac_id || !phy_ppdu->to_self)
 		return;
 
@@ -1927,12 +1938,13 @@ struct rtw89_vif_rx_stats_iter_data {
 };
 
 static void rtw89_stats_trigger_frame(struct rtw89_dev *rtwdev,
-				      struct ieee80211_vif *vif,
+				      struct rtw89_vif_link *rtwvif_link,
 				      struct ieee80211_bss_conf *bss_conf,
 				      struct sk_buff *skb)
 {
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 	struct ieee80211_trigger *tf = (struct ieee80211_trigger *)skb->data;
+	struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
+	struct rtw89_vif *rtwvif = rtwvif_link->rtwvif;
 	u8 *pos, *end, type, tf_bw;
 	u16 aid, tf_rua;
 
@@ -1963,7 +1975,7 @@ static void rtw89_stats_trigger_frame(struct rtw89_dev *rtwdev,
 		if (aid == vif->cfg.aid) {
 			enum nl80211_he_ru_alloc rua = rtw89_he_rua_to_ru_alloc(tf_rua >> 1);
 
-			rtwvif_link->stats.rx_tf_acc++;
+			rtwvif->stats.rx_tf_acc++;
 			rtwdev->stats.rx_tf_acc++;
 			if (tf_bw == IEEE80211_TRIGGER_ULBW_160_80P80MHZ &&
 			    rua <= NL80211_RATE_INFO_HE_RU_ALLOC_106)
@@ -2052,15 +2064,16 @@ static void rtw89_vif_sync_bcn_tsf(struct rtw89_vif_link *rtwvif_link,
 static void rtw89_vif_rx_stats_iter(void *data, u8 *mac,
 				    struct ieee80211_vif *vif)
 {
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 	struct rtw89_vif_rx_stats_iter_data *iter_data = data;
 	struct rtw89_dev *rtwdev = iter_data->rtwdev;
+	struct rtw89_vif *rtwvif = vif_to_rtwvif(vif);
 	struct rtw89_pkt_stat *pkt_stat = &rtwdev->phystat.cur_pkt_stat;
 	struct rtw89_rx_desc_info *desc_info = iter_data->desc_info;
 	struct sk_buff *skb = iter_data->skb;
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct rtw89_rx_phy_ppdu *phy_ppdu = iter_data->phy_ppdu;
 	struct ieee80211_bss_conf *bss_conf;
+	struct rtw89_vif_link *rtwvif_link;
 	const u8 *bssid = iter_data->bssid;
 
 	if (rtwdev->scanning &&
@@ -2070,12 +2083,19 @@ static void rtw89_vif_rx_stats_iter(void *data, u8 *mac,
 
 	rcu_read_lock();
 
+	/* FIXME: For single link, taking link on HW-0 here is okay. But, when
+	 * enabling multiple active links, we should determine the right link.
+	 */
+	rtwvif_link = rtw89_vif_get_link_inst(rtwvif, 0);
+	if (unlikely(!rtwvif_link))
+		goto out;
+
 	bss_conf = rtw89_vif_rcu_dereference_link(rtwvif_link, false);
 	if (!bss_conf->bssid)
 		goto out;
 
 	if (ieee80211_is_trigger(hdr->frame_control)) {
-		rtw89_stats_trigger_frame(rtwdev, vif, bss_conf, skb);
+		rtw89_stats_trigger_frame(rtwdev, rtwvif_link, bss_conf, skb);
 		goto out;
 	}
 
@@ -2097,7 +2117,7 @@ static void rtw89_vif_rx_stats_iter(void *data, u8 *mac,
 	if (desc_info->data_rate < RTW89_HW_RATE_NR)
 		pkt_stat->rx_rate_cnt[desc_info->data_rate]++;
 
-	rtw89_traffic_stats_accu(rtwdev, &rtwvif_link->stats, skb, false);
+	rtw89_traffic_stats_accu(rtwdev, &rtwvif->stats, skb, false);
 
 out:
 	rcu_read_unlock();
@@ -2491,10 +2511,18 @@ void rtw89_core_stats_sta_rx_status_iter(void *data, struct ieee80211_sta *sta)
 	struct rtw89_core_iter_rx_status *iter_data =
 				(struct rtw89_core_iter_rx_status *)data;
 	struct ieee80211_rx_status *rx_status = iter_data->rx_status;
-	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
 	struct rtw89_rx_desc_info *desc_info = iter_data->desc_info;
+	struct rtw89_sta *rtwsta = sta_to_rtwsta(sta);
+	struct rtw89_sta_link *rtwsta_link;
 	u8 mac_id = iter_data->mac_id;
 
+	/* FIXME: For single link, taking link on HW-0 here is okay. But, when
+	 * enabling multiple active links, we should determine the right link.
+	 */
+	rtwsta_link = rtw89_sta_get_link_inst(rtwsta, 0);
+	if (unlikely(!rtwsta_link))
+		return;
+
 	if (mac_id != rtwsta_link->mac_id)
 		return;
 
@@ -2605,6 +2633,10 @@ static enum rtw89_ps_mode rtw89_update_ps_mode(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 
+	/* FIXME: Fix __rtw89_enter_ps_mode() to consider MLO cases. */
+	if (rtwdev->support_mlo)
+		return RTW89_PS_MODE_NONE;
+
 	if (rtw89_disable_ps_mode || !chip->ps_mode_supported ||
 	    RTW89_CHK_FW_FEATURE(NO_DEEP_PS, &rtwdev->fw))
 		return RTW89_PS_MODE_NONE;
@@ -2717,8 +2749,7 @@ static void rtw89_core_ba_work(struct work_struct *work)
 	list_for_each_entry_safe(rtwtxq, tmp, &rtwdev->ba_list, list) {
 		struct ieee80211_txq *txq = rtw89_txq_to_txq(rtwtxq);
 		struct ieee80211_sta *sta = txq->sta;
-		struct rtw89_sta_link *rtwsta_link =
-			sta ? (struct rtw89_sta_link *)sta->drv_priv : NULL;
+		struct rtw89_sta *rtwsta = sta_to_rtwsta_safe(sta);
 		u8 tid = txq->tid;
 
 		if (!sta) {
@@ -2726,7 +2757,7 @@ static void rtw89_core_ba_work(struct work_struct *work)
 			goto skip_ba_work;
 		}
 
-		if (rtwsta_link->disassoc) {
+		if (rtwsta->disassoc) {
 			rtw89_debug(rtwdev, RTW89_DBG_TXRX,
 				    "cannot start BA with disassoc sta\n");
 			goto skip_ba_work;
@@ -2781,11 +2812,11 @@ void rtw89_core_free_sta_pending_forbid_ba(struct rtw89_dev *rtwdev,
 void rtw89_core_free_sta_pending_roc_tx(struct rtw89_dev *rtwdev,
 					struct ieee80211_sta *sta)
 {
-	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
+	struct rtw89_sta *rtwsta = sta_to_rtwsta(sta);
 	struct sk_buff *skb, *tmp;
 
-	skb_queue_walk_safe(&rtwsta_link->roc_queue, skb, tmp) {
-		skb_unlink(skb, &rtwsta_link->roc_queue);
+	skb_queue_walk_safe(&rtwsta->roc_queue, skb, tmp) {
+		skb_unlink(skb, &rtwsta->roc_queue);
 		dev_kfree_skb_any(skb);
 	}
 }
@@ -2795,9 +2826,9 @@ static void rtw89_core_stop_tx_ba_session(struct rtw89_dev *rtwdev,
 {
 	struct ieee80211_txq *txq = rtw89_txq_to_txq(rtwtxq);
 	struct ieee80211_sta *sta = txq->sta;
-	struct rtw89_sta_link *rtwsta_link = sta_to_rtwsta_safe(sta);
+	struct rtw89_sta *rtwsta = sta_to_rtwsta_safe(sta);
 
-	if (unlikely(!rtwsta_link) || unlikely(rtwsta_link->disassoc))
+	if (unlikely(!rtwsta) || unlikely(rtwsta->disassoc))
 		return;
 
 	if (!test_bit(RTW89_TXQ_F_AMPDU, &rtwtxq->flags) ||
@@ -2822,8 +2853,7 @@ static void rtw89_core_txq_check_agg(struct rtw89_dev *rtwdev,
 	struct ieee80211_hw *hw = rtwdev->hw;
 	struct ieee80211_txq *txq = rtw89_txq_to_txq(rtwtxq);
 	struct ieee80211_sta *sta = txq->sta;
-	struct rtw89_sta_link *rtwsta_link =
-		sta ? (struct rtw89_sta_link *)sta->drv_priv : NULL;
+	struct rtw89_sta *rtwsta = sta_to_rtwsta_safe(sta);
 
 	if (test_bit(RTW89_TXQ_F_FORBID_BA, &rtwtxq->flags))
 		return;
@@ -2845,7 +2875,7 @@ static void rtw89_core_txq_check_agg(struct rtw89_dev *rtwdev,
 	}
 
 	spin_lock_bh(&rtwdev->ba_lock);
-	if (!rtwsta_link->disassoc && list_empty(&rtwtxq->list)) {
+	if (!rtwsta->disassoc && list_empty(&rtwtxq->list)) {
 		list_add_tail(&rtwtxq->list, &rtwdev->ba_list);
 		ieee80211_queue_work(hw, &rtwdev->ba_work);
 	}
@@ -2899,11 +2929,19 @@ static bool rtw89_core_txq_agg_wait(struct rtw89_dev *rtwdev,
 				    bool *sched_txq, bool *reinvoke)
 {
 	struct rtw89_txq *rtwtxq = (struct rtw89_txq *)txq->drv_priv;
-	struct ieee80211_sta *sta = txq->sta;
-	struct rtw89_sta_link *rtwsta_link =
-		sta ? (struct rtw89_sta_link *)sta->drv_priv : NULL;
+	struct rtw89_sta *rtwsta = sta_to_rtwsta_safe(txq->sta);
+	struct rtw89_sta_link *rtwsta_link;
 
-	if (!sta || rtwsta_link->max_agg_wait <= 0)
+	if (!rtwsta)
+		return false;
+
+	rtwsta_link = rtw89_sta_get_link_inst(rtwsta, 0);
+	if (unlikely(!rtwsta_link)) {
+		rtw89_err(rtwdev, "agg wait: find no link on HW-0\n");
+		return false;
+	}
+
+	if (rtwsta_link->max_agg_wait <= 0)
 		return false;
 
 	if (rtwdev->stats.tx_tfc_lv <= RTW89_TFC_MID)
@@ -2931,7 +2969,7 @@ static void rtw89_core_txq_schedule(struct rtw89_dev *rtwdev, u8 ac, bool *reinv
 {
 	struct ieee80211_hw *hw = rtwdev->hw;
 	struct ieee80211_txq *txq;
-	struct rtw89_vif_link *rtwvif_link;
+	struct rtw89_vif *rtwvif;
 	struct rtw89_txq *rtwtxq;
 	unsigned long frame_cnt;
 	unsigned long byte_cnt;
@@ -2941,9 +2979,9 @@ static void rtw89_core_txq_schedule(struct rtw89_dev *rtwdev, u8 ac, bool *reinv
 	ieee80211_txq_schedule_start(hw, ac);
 	while ((txq = ieee80211_next_txq(hw, ac))) {
 		rtwtxq = (struct rtw89_txq *)txq->drv_priv;
-		rtwvif_link = (struct rtw89_vif_link *)txq->vif->drv_priv;
+		rtwvif = vif_to_rtwvif(txq->vif);
 
-		if (rtwvif_link->offchan) {
+		if (rtwvif->offchan) {
 			ieee80211_return_txq(hw, txq, true);
 			continue;
 		}
@@ -3017,22 +3055,28 @@ static void rtw89_forbid_ba_work(struct work_struct *w)
 static void rtw89_core_sta_pending_tx_iter(void *data,
 					   struct ieee80211_sta *sta)
 {
-	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
-	struct rtw89_vif_link *rtwvif_target = data;
-	struct rtw89_vif_link *rtwvif_link = rtwsta_link->rtwvif_link;
-	struct rtw89_dev *rtwdev = rtwvif_link->rtwdev;
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
+	struct rtw89_sta *rtwsta = sta_to_rtwsta(sta);
+	struct rtw89_dev *rtwdev = rtwsta->rtwdev;
+	struct rtw89_vif *rtwvif = rtwsta->rtwvif;
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+	struct rtw89_vif_link *target = data;
+	struct rtw89_vif_link *rtwvif_link;
 	struct sk_buff *skb, *tmp;
+	unsigned int link_id;
 	int qsel, ret;
 
-	if (rtwvif_link->chanctx_idx != rtwvif_target->chanctx_idx)
-		return;
+	rtw89_vif_for_each_link(rtwvif, rtwvif_link, link_id)
+		if (rtwvif_link->chanctx_idx == target->chanctx_idx)
+			goto bottom;
 
-	if (skb_queue_len(&rtwsta_link->roc_queue) == 0)
+	return;
+
+bottom:
+	if (skb_queue_len(&rtwsta->roc_queue) == 0)
 		return;
 
-	skb_queue_walk_safe(&rtwsta_link->roc_queue, skb, tmp) {
-		skb_unlink(skb, &rtwsta_link->roc_queue);
+	skb_queue_walk_safe(&rtwsta->roc_queue, skb, tmp) {
+		skb_unlink(skb, &rtwsta->roc_queue);
 
 		ret = rtw89_core_tx_write(rtwdev, vif, sta, skb, &qsel);
 		if (ret) {
@@ -3055,7 +3099,7 @@ static void rtw89_core_handle_sta_pending_tx(struct rtw89_dev *rtwdev,
 static int rtw89_core_send_nullfunc(struct rtw89_dev *rtwdev,
 				    struct rtw89_vif_link *rtwvif_link, bool qos, bool ps)
 {
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
+	struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
 	struct ieee80211_sta *sta;
 	struct ieee80211_hdr *hdr;
 	struct sk_buff *skb;
@@ -3098,19 +3142,27 @@ static int rtw89_core_send_nullfunc(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
-void rtw89_roc_start(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link)
+void rtw89_roc_start(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	struct ieee80211_hw *hw = rtwdev->hw;
-	struct rtw89_roc *roc = &rtwvif_link->roc;
+	struct rtw89_roc *roc = &rtwvif->roc;
+	struct rtw89_vif_link *rtwvif_link;
 	struct cfg80211_chan_def roc_chan;
-	struct rtw89_vif_link *tmp;
+	struct rtw89_vif *tmp_vif;
 	int ret;
 
 	lockdep_assert_held(&rtwdev->mutex);
 
 	rtw89_leave_ips_by_hwflags(rtwdev);
 	rtw89_leave_lps(rtwdev);
+
+	rtwvif_link = rtw89_vif_get_link_inst(rtwvif, 0);
+	if (unlikely(!rtwvif_link)) {
+		rtw89_err(rtwdev, "roc start: find no link on HW-0\n");
+		return;
+	}
+
 	rtw89_chanctx_pause(rtwdev, RTW89_CHANCTX_PAUSE_REASON_ROC);
 
 	ret = rtw89_core_send_nullfunc(rtwdev, rtwvif_link, true, true);
@@ -3118,9 +3170,17 @@ void rtw89_roc_start(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_lin
 		rtw89_debug(rtwdev, RTW89_DBG_TXRX,
 			    "roc send null-1 failed: %d\n", ret);
 
-	rtw89_for_each_rtwvif(rtwdev, tmp)
-		if (tmp->chanctx_idx == rtwvif_link->chanctx_idx)
-			tmp->offchan = true;
+	rtw89_for_each_rtwvif(rtwdev, tmp_vif) {
+		struct rtw89_vif_link *tmp_link;
+		unsigned int link_id;
+
+		rtw89_vif_for_each_link(tmp_vif, tmp_link, link_id) {
+			if (tmp_link->chanctx_idx == rtwvif_link->chanctx_idx) {
+				tmp_vif->offchan = true;
+				break;
+			}
+		}
+	}
 
 	cfg80211_chandef_create(&roc_chan, &roc->chan, NL80211_CHAN_NO_HT);
 	rtw89_config_roc_chandef(rtwdev, rtwvif_link->chanctx_idx, &roc_chan);
@@ -3130,17 +3190,18 @@ void rtw89_roc_start(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_lin
 			  B_AX_A_UC_CAM_MATCH | B_AX_A_BC_CAM_MATCH);
 
 	ieee80211_ready_on_channel(hw);
-	cancel_delayed_work(&rtwvif_link->roc.roc_work);
-	ieee80211_queue_delayed_work(hw, &rtwvif_link->roc.roc_work,
-				     msecs_to_jiffies(rtwvif_link->roc.duration));
+	cancel_delayed_work(&rtwvif->roc.roc_work);
+	ieee80211_queue_delayed_work(hw, &rtwvif->roc.roc_work,
+				     msecs_to_jiffies(rtwvif->roc.duration));
 }
 
-void rtw89_roc_end(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link)
+void rtw89_roc_end(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	struct ieee80211_hw *hw = rtwdev->hw;
-	struct rtw89_roc *roc = &rtwvif_link->roc;
-	struct rtw89_vif_link *tmp;
+	struct rtw89_roc *roc = &rtwvif->roc;
+	struct rtw89_vif_link *rtwvif_link;
+	struct rtw89_vif *tmp_vif;
 	int ret;
 
 	lockdep_assert_held(&rtwdev->mutex);
@@ -3150,6 +3211,12 @@ void rtw89_roc_end(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link)
 	rtw89_leave_ips_by_hwflags(rtwdev);
 	rtw89_leave_lps(rtwdev);
 
+	rtwvif_link = rtw89_vif_get_link_inst(rtwvif, 0);
+	if (unlikely(!rtwvif_link)) {
+		rtw89_err(rtwdev, "roc end: find no link on HW-0\n");
+		return;
+	}
+
 	rtw89_write32_mask(rtwdev,
 			   rtw89_mac_reg_by_idx(rtwdev, mac->rx_fltr, RTW89_MAC_0),
 			   B_AX_RX_FLTR_CFG_MASK,
@@ -3163,9 +3230,8 @@ void rtw89_roc_end(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link)
 		rtw89_debug(rtwdev, RTW89_DBG_TXRX,
 			    "roc send null-0 failed: %d\n", ret);
 
-	rtw89_for_each_rtwvif(rtwdev, tmp)
-		if (tmp->chanctx_idx == rtwvif_link->chanctx_idx)
-			tmp->offchan = false;
+	rtw89_for_each_rtwvif(rtwdev, tmp_vif)
+		tmp_vif->offchan = false;
 
 	rtw89_core_handle_sta_pending_tx(rtwdev, rtwvif_link);
 	queue_work(rtwdev->txq_wq, &rtwdev->txq_work);
@@ -3177,10 +3243,10 @@ void rtw89_roc_end(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link)
 
 void rtw89_roc_work(struct work_struct *work)
 {
-	struct rtw89_vif_link *rtwvif_link = container_of(work, struct rtw89_vif_link,
-							  roc.roc_work.work);
-	struct rtw89_dev *rtwdev = rtwvif_link->rtwdev;
-	struct rtw89_roc *roc = &rtwvif_link->roc;
+	struct rtw89_vif *rtwvif = container_of(work, struct rtw89_vif,
+						roc.roc_work.work);
+	struct rtw89_dev *rtwdev = rtwvif->rtwdev;
+	struct rtw89_roc *roc = &rtwvif->roc;
 
 	mutex_lock(&rtwdev->mutex);
 
@@ -3190,7 +3256,7 @@ void rtw89_roc_work(struct work_struct *work)
 		break;
 	case RTW89_ROC_MGMT:
 	case RTW89_ROC_NORMAL:
-		rtw89_roc_end(rtwdev, rtwvif_link);
+		rtw89_roc_end(rtwdev, rtwvif);
 		break;
 	default:
 		break;
@@ -3252,12 +3318,17 @@ static bool rtw89_traffic_stats_calc(struct rtw89_dev *rtwdev,
 static bool rtw89_traffic_stats_track(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_vif_link *rtwvif_link;
+	struct rtw89_vif *rtwvif;
+	unsigned int link_id;
 	bool tfc_changed;
 
 	tfc_changed = rtw89_traffic_stats_calc(rtwdev, &rtwdev->stats);
-	rtw89_for_each_rtwvif(rtwdev, rtwvif_link) {
-		rtw89_traffic_stats_calc(rtwdev, &rtwvif_link->stats);
-		rtw89_fw_h2c_tp_offload(rtwdev, rtwvif_link);
+
+	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
+		rtw89_traffic_stats_calc(rtwdev, &rtwvif->stats);
+
+		rtw89_vif_for_each_link(rtwvif, rtwvif_link, link_id)
+			rtw89_fw_h2c_tp_offload(rtwdev, rtwvif_link);
 	}
 
 	return tfc_changed;
@@ -3266,25 +3337,32 @@ static bool rtw89_traffic_stats_track(struct rtw89_dev *rtwdev)
 static void rtw89_vif_enter_lps(struct rtw89_dev *rtwdev,
 				struct rtw89_vif_link *rtwvif_link)
 {
-	if ((rtwvif_link->wifi_role != RTW89_WIFI_ROLE_STATION &&
-	     rtwvif_link->wifi_role != RTW89_WIFI_ROLE_P2P_CLIENT) ||
-	    rtwvif_link->tdls_peer)
-		return;
-
-	if (rtwvif_link->offchan)
+	if (rtwvif_link->wifi_role != RTW89_WIFI_ROLE_STATION &&
+	    rtwvif_link->wifi_role != RTW89_WIFI_ROLE_P2P_CLIENT)
 		return;
 
-	if (rtwvif_link->stats.tx_tfc_lv == RTW89_TFC_IDLE &&
-	    rtwvif_link->stats.rx_tfc_lv == RTW89_TFC_IDLE)
-		rtw89_enter_lps(rtwdev, rtwvif_link, true);
+	rtw89_enter_lps(rtwdev, rtwvif_link, true);
 }
 
 static void rtw89_enter_lps_track(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_vif_link *rtwvif_link;
+	struct rtw89_vif *rtwvif;
+	unsigned int link_id;
+
+	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
+		if (rtwvif->tdls_peer)
+			continue;
+		if (rtwvif->offchan)
+			continue;
 
-	rtw89_for_each_rtwvif(rtwdev, rtwvif_link)
-		rtw89_vif_enter_lps(rtwdev, rtwvif_link);
+		if (rtwvif->stats.tx_tfc_lv != RTW89_TFC_IDLE ||
+		    rtwvif->stats.rx_tfc_lv != RTW89_TFC_IDLE)
+			continue;
+
+		rtw89_vif_for_each_link(rtwvif, rtwvif_link, link_id)
+			rtw89_vif_enter_lps(rtwdev, rtwvif_link);
+	}
 }
 
 static void rtw89_core_rfk_track(struct rtw89_dev *rtwdev)
@@ -3468,7 +3546,7 @@ int rtw89_core_release_sta_ba_entry(struct rtw89_dev *rtwdev,
 		break
 void rtw89_vif_type_mapping(struct rtw89_vif_link *rtwvif_link, bool assoc)
 {
-	const struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
+	const struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
 	const struct ieee80211_bss_conf *bss_conf;
 
 	switch (vif->type) {
@@ -3529,8 +3607,8 @@ int rtw89_core_sta_link_add(struct rtw89_dev *rtwdev,
 			    struct rtw89_vif_link *rtwvif_link,
 			    struct rtw89_sta_link *rtwsta_link)
 {
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
-	struct ieee80211_sta *sta = rtwsta_to_sta(rtwsta_link);
+	const struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
+	const struct ieee80211_sta *sta = rtwsta_link_to_sta(rtwsta_link);
 	struct rtw89_hal *hal = &rtwdev->hal;
 	u8 ant_num = hal->ant_diversity ? 2 : rtwdev->chip->rf_path_num;
 	int i;
@@ -3586,7 +3664,7 @@ int rtw89_core_sta_link_disassoc(struct rtw89_dev *rtwdev,
 				 struct rtw89_vif_link *rtwvif_link,
 				 struct rtw89_sta_link *rtwsta_link)
 {
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
+	const struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
 
 	if (vif->type == NL80211_IFTYPE_STATION)
 		rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, rtwvif_link, false);
@@ -3598,8 +3676,8 @@ int rtw89_core_sta_link_disconnect(struct rtw89_dev *rtwdev,
 				   struct rtw89_vif_link *rtwvif_link,
 				   struct rtw89_sta_link *rtwsta_link)
 {
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
-	struct ieee80211_sta *sta = rtwsta_to_sta(rtwsta_link);
+	const struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
+	const struct ieee80211_sta *sta = rtwsta_link_to_sta(rtwsta_link);
 	int ret;
 
 	rtw89_mac_bf_monitor_calc(rtwdev, rtwsta_link, true);
@@ -3641,8 +3719,8 @@ int rtw89_core_sta_link_assoc(struct rtw89_dev *rtwdev,
 			      struct rtw89_vif_link *rtwvif_link,
 			      struct rtw89_sta_link *rtwsta_link)
 {
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
-	struct ieee80211_sta *sta = rtwsta_to_sta(rtwsta_link);
+	const struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
+	const struct ieee80211_sta *sta = rtwsta_link_to_sta(rtwsta_link);
 	struct rtw89_bssid_cam_entry *bssid_cam = rtw89_get_bssid_cam_of(rtwvif_link,
 									 rtwsta_link);
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
@@ -3730,8 +3808,8 @@ int rtw89_core_sta_link_remove(struct rtw89_dev *rtwdev,
 			       struct rtw89_vif_link *rtwvif_link,
 			       struct rtw89_sta_link *rtwsta_link)
 {
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
-	struct ieee80211_sta *sta = rtwsta_to_sta(rtwsta_link);
+	const struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
+	const struct ieee80211_sta *sta = rtwsta_link_to_sta(rtwsta_link);
 	int ret;
 
 	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls) {
@@ -4212,7 +4290,8 @@ void rtw89_core_update_beacon_work(struct work_struct *work)
 	if (rtwvif_link->net_type != RTW89_NET_TYPE_AP_MODE)
 		return;
 
-	rtwdev = rtwvif_link->rtwdev;
+	rtwdev = rtwvif_link->rtwvif->rtwdev;
+
 	mutex_lock(&rtwdev->mutex);
 	rtw89_chip_h2c_update_beacon(rtwdev, rtwvif_link);
 	mutex_unlock(&rtwdev->mutex);
@@ -4409,6 +4488,168 @@ void rtw89_release_mac_id(struct rtw89_dev *rtwdev, u8 mac_id)
 	clear_bit(mac_id, rtwdev->mac_id_map);
 }
 
+void rtw89_init_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+		    u8 mac_id, u8 port)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	u8 support_link_num = chip->support_link_num;
+	u8 support_mld_num = 0;
+	unsigned int link_id;
+	u8 index;
+
+	bitmap_zero(rtwvif->links_inst_map, __RTW89_MLD_MAX_LINK_NUM);
+	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++)
+		rtwvif->links[link_id] = NULL;
+
+	rtwvif->rtwdev = rtwdev;
+
+	if (rtwdev->support_mlo) {
+		rtwvif->links_inst_valid_num = support_link_num;
+		support_mld_num = chip->support_macid_num / support_link_num;
+	} else {
+		rtwvif->links_inst_valid_num = 1;
+	}
+
+	for (index = 0; index < rtwvif->links_inst_valid_num; index++) {
+		struct rtw89_vif_link *inst = &rtwvif->links_inst[index];
+
+		inst->rtwvif = rtwvif;
+		inst->mac_id = mac_id + index * support_mld_num;
+		inst->mac_idx = RTW89_MAC_0 + index;
+		inst->phy_idx = RTW89_PHY_0 + index;
+
+		/* multi-link use the same port id on different HW bands */
+		inst->port = port;
+	}
+}
+
+void rtw89_init_sta(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+		    struct rtw89_sta *rtwsta, u8 mac_id)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	u8 support_link_num = chip->support_link_num;
+	u8 support_mld_num = 0;
+	unsigned int link_id;
+	u8 index;
+
+	bitmap_zero(rtwsta->links_inst_map, __RTW89_MLD_MAX_LINK_NUM);
+	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++)
+		rtwsta->links[link_id] = NULL;
+
+	rtwsta->rtwdev = rtwdev;
+	rtwsta->rtwvif = rtwvif;
+
+	if (rtwdev->support_mlo) {
+		rtwsta->links_inst_valid_num = support_link_num;
+		support_mld_num = chip->support_macid_num / support_link_num;
+	} else {
+		rtwsta->links_inst_valid_num = 1;
+	}
+
+	for (index = 0; index < rtwsta->links_inst_valid_num; index++) {
+		struct rtw89_sta_link *inst = &rtwsta->links_inst[index];
+
+		inst->rtwvif_link = &rtwvif->links_inst[index];
+
+		inst->rtwsta = rtwsta;
+		inst->mac_id = mac_id + index * support_mld_num;
+	}
+}
+
+struct rtw89_vif_link *rtw89_vif_set_link(struct rtw89_vif *rtwvif,
+					  unsigned int link_id)
+{
+	struct rtw89_vif_link *rtwvif_link = rtwvif->links[link_id];
+	u8 index;
+	int ret;
+
+	if (rtwvif_link)
+		return rtwvif_link;
+
+	index = find_first_zero_bit(rtwvif->links_inst_map,
+				    rtwvif->links_inst_valid_num);
+	if (index == rtwvif->links_inst_valid_num) {
+		ret = -EBUSY;
+		goto err;
+	}
+
+	rtwvif_link = &rtwvif->links_inst[index];
+	rtwvif_link->link_id = link_id;
+
+	set_bit(index, rtwvif->links_inst_map);
+	rtwvif->links[link_id] = rtwvif_link;
+	return rtwvif_link;
+
+err:
+	rtw89_err(rtwvif->rtwdev, "vif (link_id %u) failed to set link: %d\n",
+		  link_id, ret);
+	return NULL;
+}
+
+void rtw89_vif_unset_link(struct rtw89_vif *rtwvif, unsigned int link_id)
+{
+	struct rtw89_vif_link **container = &rtwvif->links[link_id];
+	struct rtw89_vif_link *link = *container;
+	u8 index;
+
+	if (!link)
+		return;
+
+	index = rtw89_vif_link_inst_get_index(link);
+	clear_bit(index, rtwvif->links_inst_map);
+	*container = NULL;
+}
+
+struct rtw89_sta_link *rtw89_sta_set_link(struct rtw89_sta *rtwsta,
+					  unsigned int link_id)
+{
+	struct rtw89_vif *rtwvif = rtwsta->rtwvif;
+	struct rtw89_vif_link *rtwvif_link = rtwvif->links[link_id];
+	struct rtw89_sta_link *rtwsta_link = rtwsta->links[link_id];
+	u8 index;
+	int ret;
+
+	if (rtwsta_link)
+		return rtwsta_link;
+
+	if (!rtwvif_link) {
+		ret = -ENOLINK;
+		goto err;
+	}
+
+	index = rtw89_vif_link_inst_get_index(rtwvif_link);
+	if (test_bit(index, rtwsta->links_inst_map)) {
+		ret = -EBUSY;
+		goto err;
+	}
+
+	rtwsta_link = &rtwsta->links_inst[index];
+	rtwsta_link->link_id = link_id;
+
+	set_bit(index, rtwsta->links_inst_map);
+	rtwsta->links[link_id] = rtwsta_link;
+	return rtwsta_link;
+
+err:
+	rtw89_err(rtwsta->rtwdev, "sta (link_id %u) failed to set link: %d\n",
+		  link_id, ret);
+	return NULL;
+}
+
+void rtw89_sta_unset_link(struct rtw89_sta *rtwsta, unsigned int link_id)
+{
+	struct rtw89_sta_link **container = &rtwsta->links[link_id];
+	struct rtw89_sta_link *link = *container;
+	u8 index;
+
+	if (!link)
+		return;
+
+	index = rtw89_sta_link_inst_get_index(link);
+	clear_bit(index, rtwsta->links_inst_map);
+	*container = NULL;
+}
+
 int rtw89_core_init(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
@@ -4519,10 +4760,8 @@ void rtw89_core_scan_start(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwv
 }
 
 void rtw89_core_scan_complete(struct rtw89_dev *rtwdev,
-			      struct ieee80211_vif *vif, bool hw_scan)
+			      struct rtw89_vif_link *rtwvif_link, bool hw_scan)
 {
-	struct rtw89_vif_link *rtwvif_link =
-		vif ? (struct rtw89_vif_link *)vif->drv_priv : NULL;
 	struct ieee80211_bss_conf *bss_conf;
 
 	if (!rtwvif_link)
@@ -4753,7 +4992,7 @@ EXPORT_SYMBOL(rtw89_chip_info_setup);
 void rtw89_chip_cfg_txpwr_ul_tb_offset(struct rtw89_dev *rtwdev,
 				       struct rtw89_vif_link *rtwvif_link)
 {
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
+	struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct ieee80211_bss_conf *bss_conf;
 
@@ -4774,14 +5013,15 @@ void rtw89_chip_cfg_txpwr_ul_tb_offset(struct rtw89_dev *rtwdev,
 static int rtw89_core_register_hw(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
+	u8 n = rtwdev->support_mlo ? chip->support_link_num : 1;
 	struct ieee80211_hw *hw = rtwdev->hw;
 	struct rtw89_efuse *efuse = &rtwdev->efuse;
 	struct rtw89_hal *hal = &rtwdev->hal;
 	int ret;
 	int tx_headroom = IEEE80211_HT_CTL_LEN;
 
-	hw->vif_data_size = sizeof(struct rtw89_vif_link);
-	hw->sta_data_size = sizeof(struct rtw89_sta_link);
+	hw->vif_data_size = struct_size_t(struct rtw89_vif, links_inst, n);
+	hw->sta_data_size = struct_size_t(struct rtw89_sta, links_inst, n);
 	hw->txq_data_size = sizeof(struct rtw89_txq);
 	hw->chanctx_data_size = sizeof(struct rtw89_chanctx_cfg);
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index bfa3dba07fe1..de33320b1354 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -829,6 +829,8 @@ enum rtw89_phy_idx {
 	RTW89_PHY_MAX
 };
 
+#define __RTW89_MLD_MAX_LINK_NUM 2
+
 enum rtw89_chanctx_idx {
 	RTW89_CHANCTX_0 = 0,
 	RTW89_CHANCTX_1 = 1,
@@ -1166,8 +1168,8 @@ struct rtw89_core_tx_request {
 	enum rtw89_core_tx_type tx_type;
 
 	struct sk_buff *skb;
-	struct ieee80211_vif *vif;
-	struct ieee80211_sta *sta;
+	struct rtw89_vif_link *rtwvif_link;
+	struct rtw89_sta_link *rtwsta_link;
 	struct rtw89_tx_desc_info desc_info;
 };
 
@@ -3355,12 +3357,11 @@ struct rtw89_sec_cam_entry {
 };
 
 struct rtw89_sta_link {
+	struct rtw89_sta *rtwsta;
 	unsigned int link_id;
 
 	u8 mac_id;
-	bool disassoc;
 	bool er_cap;
-	struct rtw89_dev *rtwdev;
 	struct rtw89_vif_link *rtwvif_link;
 	struct rtw89_ra_info ra;
 	struct rtw89_ra_report ra_report;
@@ -3372,15 +3373,12 @@ struct rtw89_sta_link {
 	struct ewma_evm evm_1ss;
 	struct ewma_evm evm_min[RF_PATH_MAX];
 	struct ewma_evm evm_max[RF_PATH_MAX];
-	struct rtw89_ampdu_params ampdu_params[IEEE80211_NUM_TIDS];
-	DECLARE_BITMAP(ampdu_map, IEEE80211_NUM_TIDS);
 	struct ieee80211_rx_status rx_status;
 	u16 rx_hw_rate;
 	__le32 htc_template;
 	struct rtw89_addr_cam_entry addr_cam; /* AP mode or TDLS peer only */
 	struct rtw89_bssid_cam_entry bssid_cam; /* TDLS peer only */
 	struct list_head ba_cam_list;
-	struct sk_buff_head roc_queue;
 
 	bool use_cfg_mask;
 	struct cfg80211_bitrate_mask mask;
@@ -3463,11 +3461,9 @@ struct rtw89_p2p_noa_setter {
 };
 
 struct rtw89_vif_link {
+	struct rtw89_vif *rtwvif;
 	unsigned int link_id;
 
-	struct list_head list;
-	struct rtw89_dev *rtwdev;
-	struct rtw89_roc roc;
 	bool chanctx_assigned; /* only valid when running with chanctx_ops */
 	enum rtw89_chanctx_idx chanctx_idx;
 	enum rtw89_reg_6ghz_power reg_6ghz_power;
@@ -3477,7 +3473,6 @@ struct rtw89_vif_link {
 	u8 port;
 	u8 mac_addr[ETH_ALEN];
 	u8 bssid[ETH_ALEN];
-	__be32 ip_addr;
 	u8 phy_idx;
 	u8 mac_idx;
 	u8 net_type;
@@ -3488,7 +3483,6 @@ struct rtw89_vif_link {
 	u8 hit_rule;
 	u8 last_noa_nr;
 	u64 sync_bcn_tsf;
-	bool offchan;
 	bool trigger;
 	bool lsig_txop;
 	u8 tgt_ind;
@@ -3502,15 +3496,11 @@ struct rtw89_vif_link {
 	bool pre_pwr_diff_en;
 	bool pwr_diff_en;
 	u8 def_tri_idx;
-	u32 tdls_peer;
 	struct work_struct update_beacon_work;
 	struct rtw89_addr_cam_entry addr_cam;
 	struct rtw89_bssid_cam_entry bssid_cam;
 	struct ieee80211_tx_queue_params tx_params[IEEE80211_NUM_ACS];
-	struct rtw89_traffic_stats stats;
 	struct rtw89_phy_rate_pattern rate_pattern;
-	struct cfg80211_scan_request *scan_req;
-	struct ieee80211_scan_ies *scan_ies;
 	struct list_head general_pkt_list;
 	struct rtw89_p2p_noa_setter p2p_noa;
 };
@@ -3659,14 +3649,16 @@ struct rtw89_chip_ops {
 				  struct rtw89_vif_link *rtwvif_link,
 				  struct rtw89_sta_link *rtwsta_link);
 	int (*h2c_ampdu_cmac_tbl)(struct rtw89_dev *rtwdev,
-				  struct ieee80211_vif *vif,
-				  struct ieee80211_sta *sta);
+				  struct rtw89_vif_link *rtwvif_link,
+				  struct rtw89_sta_link *rtwsta_link);
 	int (*h2c_default_dmac_tbl)(struct rtw89_dev *rtwdev,
 				    struct rtw89_vif_link *rtwvif_link,
 				    struct rtw89_sta_link *rtwsta_link);
 	int (*h2c_update_beacon)(struct rtw89_dev *rtwdev,
 				 struct rtw89_vif_link *rtwvif_link);
-	int (*h2c_ba_cam)(struct rtw89_dev *rtwdev, struct rtw89_sta_link *rtwsta_link,
+	int (*h2c_ba_cam)(struct rtw89_dev *rtwdev,
+			  struct rtw89_vif_link *rtwvif_link,
+			  struct rtw89_sta_link *rtwsta_link,
 			  bool valid, struct ieee80211_ampdu_params *params);
 
 	void (*btc_set_rfe)(struct rtw89_dev *rtwdev);
@@ -5200,7 +5192,7 @@ struct rtw89_early_h2c {
 };
 
 struct rtw89_hw_scan_info {
-	struct ieee80211_vif *scanning_vif;
+	struct rtw89_vif_link *scanning_vif;
 	struct list_head pkt_list[NUM_NL80211_BANDS];
 	struct rtw89_chan op_chan;
 	bool abort;
@@ -5375,7 +5367,7 @@ struct rtw89_wow_aoac_report {
 };
 
 struct rtw89_wow_param {
-	struct ieee80211_vif *wow_vif;
+	struct rtw89_vif_link *rtwvif_link;
 	DECLARE_BITMAP(flags, RTW89_WOW_FLAG_NUM);
 	struct rtw89_wow_cam_info patterns[RTW89_MAX_PATTERN_NUM];
 	struct rtw89_wow_key_info key_info;
@@ -5612,6 +5604,121 @@ struct rtw89_dev {
 	u8 priv[] __aligned(sizeof(void *));
 };
 
+struct rtw89_vif {
+	struct rtw89_dev *rtwdev;
+	struct list_head list;
+
+	u8 mac_addr[ETH_ALEN];
+	__be32 ip_addr;
+
+	struct rtw89_traffic_stats stats;
+	u32 tdls_peer;
+
+	struct ieee80211_scan_ies *scan_ies;
+	struct cfg80211_scan_request *scan_req;
+
+	struct rtw89_roc roc;
+	bool offchan;
+
+	u8 links_inst_valid_num;
+	DECLARE_BITMAP(links_inst_map, __RTW89_MLD_MAX_LINK_NUM);
+	struct rtw89_vif_link *links[IEEE80211_MLD_MAX_NUM_LINKS];
+	struct rtw89_vif_link links_inst[] __counted_by(links_inst_valid_num);
+};
+
+static inline bool rtw89_vif_assign_link_is_valid(struct rtw89_vif_link **rtwvif_link,
+						  const struct rtw89_vif *rtwvif,
+						  unsigned int link_id)
+{
+	*rtwvif_link = rtwvif->links[link_id];
+	return !!*rtwvif_link;
+}
+
+#define rtw89_vif_for_each_link(rtwvif, rtwvif_link, link_id) \
+	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) \
+		if (rtw89_vif_assign_link_is_valid(&(rtwvif_link), rtwvif, link_id))
+
+struct rtw89_sta {
+	struct rtw89_dev *rtwdev;
+	struct rtw89_vif *rtwvif;
+
+	bool disassoc;
+
+	struct sk_buff_head roc_queue;
+
+	struct rtw89_ampdu_params ampdu_params[IEEE80211_NUM_TIDS];
+	DECLARE_BITMAP(ampdu_map, IEEE80211_NUM_TIDS);
+
+	u8 links_inst_valid_num;
+	DECLARE_BITMAP(links_inst_map, __RTW89_MLD_MAX_LINK_NUM);
+	struct rtw89_sta_link *links[IEEE80211_MLD_MAX_NUM_LINKS];
+	struct rtw89_sta_link links_inst[] __counted_by(links_inst_valid_num);
+};
+
+static inline bool rtw89_sta_assign_link_is_valid(struct rtw89_sta_link **rtwsta_link,
+						  const struct rtw89_sta *rtwsta,
+						  unsigned int link_id)
+{
+	*rtwsta_link = rtwsta->links[link_id];
+	return !!*rtwsta_link;
+}
+
+#define rtw89_sta_for_each_link(rtwsta, rtwsta_link, link_id) \
+	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) \
+		if (rtw89_sta_assign_link_is_valid(&(rtwsta_link), rtwsta, link_id))
+
+static inline u8 rtw89_vif_get_main_macid(struct rtw89_vif *rtwvif)
+{
+	/* const after init, so no need to check if active first */
+	return rtwvif->links_inst[0].mac_id;
+}
+
+static inline u8 rtw89_vif_get_main_port(struct rtw89_vif *rtwvif)
+{
+	/* const after init, so no need to check if active first */
+	return rtwvif->links_inst[0].port;
+}
+
+static inline struct rtw89_vif_link *
+rtw89_vif_get_link_inst(struct rtw89_vif *rtwvif, u8 index)
+{
+	if (index >= rtwvif->links_inst_valid_num ||
+	    !test_bit(index, rtwvif->links_inst_map))
+		return NULL;
+	return &rtwvif->links_inst[index];
+}
+
+static inline
+u8 rtw89_vif_link_inst_get_index(struct rtw89_vif_link *rtwvif_link)
+{
+	struct rtw89_vif *rtwvif = rtwvif_link->rtwvif;
+
+	return rtwvif_link - rtwvif->links_inst;
+}
+
+static inline u8 rtw89_sta_get_main_macid(struct rtw89_sta *rtwsta)
+{
+	/* const after init, so no need to check if active first */
+	return rtwsta->links_inst[0].mac_id;
+}
+
+static inline struct rtw89_sta_link *
+rtw89_sta_get_link_inst(struct rtw89_sta *rtwsta, u8 index)
+{
+	if (index >= rtwsta->links_inst_valid_num ||
+	    !test_bit(index, rtwsta->links_inst_map))
+		return NULL;
+	return &rtwsta->links_inst[index];
+}
+
+static inline
+u8 rtw89_sta_link_inst_get_index(struct rtw89_sta_link *rtwsta_link)
+{
+	struct rtw89_sta *rtwsta = rtwsta_link->rtwsta;
+
+	return rtwsta_link - rtwsta->links_inst;
+}
+
 static inline int rtw89_hci_tx_write(struct rtw89_dev *rtwdev,
 				     struct rtw89_core_tx_request *tx_req)
 {
@@ -5964,44 +6071,78 @@ static inline void rtw89_core_txq_init(struct rtw89_dev *rtwdev,
 	INIT_LIST_HEAD(&rtwtxq->list);
 }
 
-static inline struct ieee80211_vif *rtwvif_to_vif(struct rtw89_vif_link *rtwvif_link)
+static inline struct ieee80211_vif *rtwvif_to_vif(struct rtw89_vif *rtwvif)
 {
-	void *p = rtwvif_link;
+	void *p = rtwvif;
 
 	return container_of(p, struct ieee80211_vif, drv_priv);
 }
 
-static inline struct ieee80211_vif *rtwvif_to_vif_safe(struct rtw89_vif_link *rtwvif_link)
+static inline struct ieee80211_vif *rtwvif_to_vif_safe(struct rtw89_vif *rtwvif)
 {
-	return rtwvif_link ? rtwvif_to_vif(rtwvif_link) : NULL;
+	return rtwvif ? rtwvif_to_vif(rtwvif) : NULL;
 }
 
-static inline struct rtw89_vif_link *vif_to_rtwvif_safe(struct ieee80211_vif *vif)
+static inline
+struct ieee80211_vif *rtwvif_link_to_vif(struct rtw89_vif_link *rtwvif_link)
 {
-	return vif ? (struct rtw89_vif_link *)vif->drv_priv : NULL;
+	return rtwvif_to_vif(rtwvif_link->rtwvif);
 }
 
-static inline struct ieee80211_sta *rtwsta_to_sta(struct rtw89_sta_link *rtwsta_link)
+static inline
+struct ieee80211_vif *rtwvif_link_to_vif_safe(struct rtw89_vif_link *rtwvif_link)
 {
-	void *p = rtwsta_link;
+	return rtwvif_link ? rtwvif_link_to_vif(rtwvif_link) : NULL;
+}
+
+static inline struct rtw89_vif *vif_to_rtwvif(struct ieee80211_vif *vif)
+{
+	return (struct rtw89_vif *)vif->drv_priv;
+}
+
+static inline struct rtw89_vif *vif_to_rtwvif_safe(struct ieee80211_vif *vif)
+{
+	return vif ? vif_to_rtwvif(vif) : NULL;
+}
+
+static inline struct ieee80211_sta *rtwsta_to_sta(struct rtw89_sta *rtwsta)
+{
+	void *p = rtwsta;
 
 	return container_of(p, struct ieee80211_sta, drv_priv);
 }
 
-static inline struct ieee80211_sta *rtwsta_to_sta_safe(struct rtw89_sta_link *rtwsta_link)
+static inline struct ieee80211_sta *rtwsta_to_sta_safe(struct rtw89_sta *rtwsta)
+{
+	return rtwsta ? rtwsta_to_sta(rtwsta) : NULL;
+}
+
+static inline
+struct ieee80211_sta *rtwsta_link_to_sta(struct rtw89_sta_link *rtwsta_link)
+{
+	return rtwsta_to_sta(rtwsta_link->rtwsta);
+}
+
+static inline
+struct ieee80211_sta *rtwsta_link_to_sta_safe(struct rtw89_sta_link *rtwsta_link)
+{
+	return rtwsta_link ? rtwsta_link_to_sta(rtwsta_link) : NULL;
+}
+
+static inline struct rtw89_sta *sta_to_rtwsta(struct ieee80211_sta *sta)
 {
-	return rtwsta_link ? rtwsta_to_sta(rtwsta_link) : NULL;
+	return (struct rtw89_sta *)sta->drv_priv;
 }
 
-static inline struct rtw89_sta_link *sta_to_rtwsta_safe(struct ieee80211_sta *sta)
+static inline struct rtw89_sta *sta_to_rtwsta_safe(struct ieee80211_sta *sta)
 {
-	return sta ? (struct rtw89_sta_link *)sta->drv_priv : NULL;
+	return sta ? sta_to_rtwsta(sta) : NULL;
 }
 
 static inline struct ieee80211_bss_conf *
 __rtw89_vif_rcu_dereference_link(struct rtw89_vif_link *rtwvif_link, bool *nolink)
 {
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
+	struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
 	struct ieee80211_bss_conf *bss_conf;
 
 	bss_conf = rcu_dereference(vif->link_conf[rtwvif_link->link_id]);
@@ -6022,7 +6163,7 @@ __rtw89_vif_rcu_dereference_link(struct rtw89_vif_link *rtwvif_link, bool *nolin
 									\
 	bss_conf = __rtw89_vif_rcu_dereference_link(p, &nolink);	\
 	if (unlikely(nolink) && (assert))				\
-		rtw89_err(p->rtwdev,					\
+		rtw89_err(p->rtwvif->rtwdev,				\
 			  "%s: cannot find exact bss_conf for link_id %u\n",\
 			  __func__, p->link_id);			\
 	bss_conf;							\
@@ -6031,7 +6172,7 @@ __rtw89_vif_rcu_dereference_link(struct rtw89_vif_link *rtwvif_link, bool *nolin
 static inline struct ieee80211_link_sta *
 __rtw89_sta_rcu_dereference_link(struct rtw89_sta_link *rtwsta_link, bool *nolink)
 {
-	struct ieee80211_sta *sta = rtwsta_to_sta(rtwsta_link);
+	struct ieee80211_sta *sta = rtwsta_link_to_sta(rtwsta_link);
 	struct ieee80211_link_sta *link_sta;
 
 	link_sta = rcu_dereference(sta->link[rtwsta_link->link_id]);
@@ -6052,7 +6193,7 @@ __rtw89_sta_rcu_dereference_link(struct rtw89_sta_link *rtwsta_link, bool *nolin
 									\
 	link_sta = __rtw89_sta_rcu_dereference_link(p, &nolink);	\
 	if (unlikely(nolink) && (assert))				\
-		rtw89_err(p->rtwdev,					\
+		rtw89_err(p->rtwsta->rtwdev,				\
 			  "%s: cannot find exact link_sta for link_id %u\n",\
 			  __func__, p->link_id);			\
 	link_sta;							\
@@ -6146,7 +6287,7 @@ struct rtw89_addr_cam_entry *rtw89_get_addr_cam_of(struct rtw89_vif_link *rtwvif
 						   struct rtw89_sta_link *rtwsta_link)
 {
 	if (rtwsta_link) {
-		struct ieee80211_sta *sta = rtwsta_to_sta(rtwsta_link);
+		struct ieee80211_sta *sta = rtwsta_link_to_sta(rtwsta_link);
 
 		if (rtwvif_link->net_type == RTW89_NET_TYPE_AP_MODE || sta->tdls)
 			return &rtwsta_link->addr_cam;
@@ -6159,7 +6300,7 @@ struct rtw89_bssid_cam_entry *rtw89_get_bssid_cam_of(struct rtw89_vif_link *rtwv
 						     struct rtw89_sta_link *rtwsta_link)
 {
 	if (rtwsta_link) {
-		struct ieee80211_sta *sta = rtwsta_to_sta(rtwsta_link);
+		struct ieee80211_sta *sta = rtwsta_link_to_sta(rtwsta_link);
 
 		if (sta->tdls)
 			return &rtwsta_link->bssid_cam;
@@ -6223,8 +6364,7 @@ const struct rtw89_chan_rcd *rtw89_chan_rcd_get(struct rtw89_dev *rtwdev,
 static inline
 const struct rtw89_chan *rtw89_scan_chan_get(struct rtw89_dev *rtwdev)
 {
-	struct ieee80211_vif *vif = rtwdev->scan_info.scanning_vif;
-	struct rtw89_vif_link *rtwvif_link = vif_to_rtwvif_safe(vif);
+	struct rtw89_vif_link *rtwvif_link = rtwdev->scan_info.scanning_vif;
 
 	if (rtwvif_link)
 		return rtw89_chan_get(rtwdev, rtwvif_link->chanctx_idx);
@@ -6686,13 +6826,21 @@ struct rtw89_dev *rtw89_alloc_ieee80211_hw(struct device *device,
 void rtw89_free_ieee80211_hw(struct rtw89_dev *rtwdev);
 u8 rtw89_acquire_mac_id(struct rtw89_dev *rtwdev);
 void rtw89_release_mac_id(struct rtw89_dev *rtwdev, u8 mac_id);
+void rtw89_init_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+		    u8 mac_id, u8 port);
+void rtw89_init_sta(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+		    struct rtw89_sta *rtwsta, u8 mac_id);
+struct rtw89_vif_link *rtw89_vif_set_link(struct rtw89_vif *rtwvif,
+					  unsigned int link_id);
+void rtw89_vif_unset_link(struct rtw89_vif *rtwvif, unsigned int link_id);
+struct rtw89_sta_link *rtw89_sta_set_link(struct rtw89_sta *rtwsta,
+					  unsigned int link_id);
+void rtw89_sta_unset_link(struct rtw89_sta *rtwsta, unsigned int link_id);
 void rtw89_core_set_chip_txpwr(struct rtw89_dev *rtwdev);
 void rtw89_get_default_chandef(struct cfg80211_chan_def *chandef);
 void rtw89_get_channel_params(const struct cfg80211_chan_def *chandef,
 			      struct rtw89_chan *chan);
 int rtw89_set_channel(struct rtw89_dev *rtwdev);
-void rtw89_get_channel(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
-		       struct rtw89_chan *chan);
 u8 rtw89_core_acquire_bit_map(unsigned long *addr, unsigned long size);
 void rtw89_core_release_bit_map(unsigned long *addr, u8 bit);
 void rtw89_core_release_all_bits_map(unsigned long *addr, unsigned int nbits);
@@ -6726,12 +6874,12 @@ int rtw89_core_start(struct rtw89_dev *rtwdev);
 void rtw89_core_stop(struct rtw89_dev *rtwdev);
 void rtw89_core_update_beacon_work(struct work_struct *work);
 void rtw89_roc_work(struct work_struct *work);
-void rtw89_roc_start(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link);
-void rtw89_roc_end(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link);
+void rtw89_roc_start(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
+void rtw89_roc_end(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
 void rtw89_core_scan_start(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
 			   const u8 *mac_addr, bool hw_scan);
 void rtw89_core_scan_complete(struct rtw89_dev *rtwdev,
-			      struct ieee80211_vif *vif, bool hw_scan);
+			      struct rtw89_vif_link *rtwvif_link, bool hw_scan);
 int rtw89_reg_6ghz_recalc(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
 			  bool active);
 void rtw89_core_update_p2p_ps(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index cc7aaf6fa31f..7391f131229a 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -3506,7 +3506,9 @@ static ssize_t rtw89_debug_priv_fw_log_manual_set(struct file *filp,
 	return count;
 }
 
-static void rtw89_sta_info_get_iter(void *data, struct ieee80211_sta *sta)
+static void rtw89_sta_link_info_get_iter(struct seq_file *m,
+					 struct rtw89_dev *rtwdev,
+					 struct rtw89_sta_link *rtwsta_link)
 {
 	static const char * const he_gi_str[] = {
 		[NL80211_RATE_INFO_HE_GI_0_8] = "0.8",
@@ -3518,11 +3520,8 @@ static void rtw89_sta_info_get_iter(void *data, struct ieee80211_sta *sta)
 		[NL80211_RATE_INFO_EHT_GI_1_6] = "1.6",
 		[NL80211_RATE_INFO_EHT_GI_3_2] = "3.2",
 	};
-	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
 	struct rate_info *rate = &rtwsta_link->ra_report.txrate;
 	struct ieee80211_rx_status *status = &rtwsta_link->rx_status;
-	struct seq_file *m = (struct seq_file *)data;
-	struct rtw89_dev *rtwdev = rtwsta_link->rtwdev;
 	struct rtw89_hal *hal = &rtwdev->hal;
 	u8 ant_num = hal->ant_diversity ? 2 : rtwdev->chip->rf_path_num;
 	bool ant_asterisk = hal->tx_path_diversity || hal->ant_diversity;
@@ -3540,7 +3539,7 @@ static void rtw89_sta_info_get_iter(void *data, struct ieee80211_sta *sta)
 
 	rcu_read_unlock();
 
-	seq_printf(m, "TX rate [%d]: ", rtwsta_link->mac_id);
+	seq_printf(m, "TX rate [%u, %u]: ", rtwsta_link->mac_id, rtwsta_link->link_id);
 
 	if (rate->flags & RATE_INFO_FLAGS_MCS)
 		seq_printf(m, "HT MCS-%d%s", rate->mcs,
@@ -3560,11 +3559,11 @@ static void rtw89_sta_info_get_iter(void *data, struct ieee80211_sta *sta)
 		seq_printf(m, "Legacy %d", rate->legacy);
 	seq_printf(m, "%s", rtwsta_link->ra_report.might_fallback_legacy ? " FB_G" : "");
 	seq_printf(m, " BW:%u", rtw89_rate_info_bw_to_mhz(rate->bw));
-	seq_printf(m, "\t(hw_rate=0x%x)", rtwsta_link->ra_report.hw_rate);
-	seq_printf(m, "\t==> agg_wait=%d (%d)\n", rtwsta_link->max_agg_wait,
+	seq_printf(m, " (hw_rate=0x%x)", rtwsta_link->ra_report.hw_rate);
+	seq_printf(m, " ==> agg_wait=%d (%d)\n", rtwsta_link->max_agg_wait,
 		   max_rc_amsdu_len);
 
-	seq_printf(m, "RX rate [%d]: ", rtwsta_link->mac_id);
+	seq_printf(m, "RX rate [%u, %u]: ", rtwsta_link->mac_id, rtwsta_link->link_id);
 
 	switch (status->encoding) {
 	case RX_ENC_LEGACY:
@@ -3591,7 +3590,7 @@ static void rtw89_sta_info_get_iter(void *data, struct ieee80211_sta *sta)
 		break;
 	}
 	seq_printf(m, " BW:%u", rtw89_rate_info_bw_to_mhz(status->bw));
-	seq_printf(m, "\t(hw_rate=0x%x)\n", rtwsta_link->rx_hw_rate);
+	seq_printf(m, " (hw_rate=0x%x)\n", rtwsta_link->rx_hw_rate);
 
 	rssi = ewma_rssi_read(&rtwsta_link->avg_rssi);
 	seq_printf(m, "RSSI: %d dBm (raw=%d, prev=%d) [",
@@ -3620,6 +3619,18 @@ static void rtw89_sta_info_get_iter(void *data, struct ieee80211_sta *sta)
 	seq_printf(m, "SNR: %u\n", snr);
 }
 
+static void rtw89_sta_info_get_iter(void *data, struct ieee80211_sta *sta)
+{
+	struct seq_file *m = (struct seq_file *)data;
+	struct rtw89_sta *rtwsta = sta_to_rtwsta(sta);
+	struct rtw89_dev *rtwdev = rtwsta->rtwdev;
+	struct rtw89_sta_link *rtwsta_link;
+	unsigned int link_id;
+
+	rtw89_sta_for_each_link(rtwsta, rtwsta_link, link_id)
+		rtw89_sta_link_info_get_iter(m, rtwdev, rtwsta_link);
+}
+
 static void
 rtw89_debug_append_rx_rate(struct seq_file *m, struct rtw89_pkt_stat *pkt_stat,
 			   enum rtw89_hw_rate first_rate, int len)
@@ -3746,25 +3757,37 @@ static void rtw89_dump_pkt_offload(struct seq_file *m, struct list_head *pkt_lis
 	seq_puts(m, "\n");
 }
 
-static
-void rtw89_vif_ids_get_iter(void *data, u8 *mac, struct ieee80211_vif *vif)
+static void rtw89_vif_link_ids_get(struct seq_file *m, u8 *mac,
+				   struct rtw89_dev *rtwdev,
+				   struct rtw89_vif_link *rtwvif_link)
 {
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
-	struct rtw89_dev *rtwdev = rtwvif_link->rtwdev;
-	struct seq_file *m = (struct seq_file *)data;
 	struct rtw89_bssid_cam_entry *bssid_cam = &rtwvif_link->bssid_cam;
 
-	seq_printf(m, "VIF [%d] %pM\n", rtwvif_link->mac_id, rtwvif_link->mac_addr);
+	seq_printf(m, "    [%u] %pM\n", rtwvif_link->mac_id, rtwvif_link->mac_addr);
+	seq_printf(m, "\tlink_id=%u\n", rtwvif_link->link_id);
 	seq_printf(m, "\tbssid_cam_idx=%u\n", bssid_cam->bssid_cam_idx);
 	rtw89_dump_addr_cam(m, rtwdev, &rtwvif_link->addr_cam);
 	rtw89_dump_pkt_offload(m, &rtwvif_link->general_pkt_list,
 			       "\tpkt_ofld[GENERAL]: ");
 }
 
-static void rtw89_dump_ba_cam(struct seq_file *m, struct rtw89_sta_link *rtwsta_link)
+static
+void rtw89_vif_ids_get_iter(void *data, u8 *mac, struct ieee80211_vif *vif)
+{
+	struct seq_file *m = (struct seq_file *)data;
+	struct rtw89_vif *rtwvif = vif_to_rtwvif(vif);
+	struct rtw89_dev *rtwdev = rtwvif->rtwdev;
+	struct rtw89_vif_link *rtwvif_link;
+	unsigned int link_id;
+
+	seq_printf(m, "VIF %pM\n", rtwvif->mac_addr);
+	rtw89_vif_for_each_link(rtwvif, rtwvif_link, link_id)
+		rtw89_vif_link_ids_get(m, mac, rtwdev, rtwvif_link);
+}
+
+static void rtw89_dump_ba_cam(struct seq_file *m, struct rtw89_dev *rtwdev,
+			      struct rtw89_sta_link *rtwsta_link)
 {
-	struct rtw89_vif_link *rtwvif_link = rtwsta_link->rtwvif_link;
-	struct rtw89_dev *rtwdev = rtwvif_link->rtwdev;
 	struct rtw89_ba_cam_entry *entry;
 	bool first = true;
 
@@ -3781,24 +3804,36 @@ static void rtw89_dump_ba_cam(struct seq_file *m, struct rtw89_sta_link *rtwsta_
 	seq_puts(m, "\n");
 }
 
-static void rtw89_sta_ids_get_iter(void *data, struct ieee80211_sta *sta)
+static void rtw89_sta_link_ids_get(struct seq_file *m,
+				   struct rtw89_dev *rtwdev,
+				   struct rtw89_sta_link *rtwsta_link)
 {
-	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
-	struct rtw89_dev *rtwdev = rtwsta_link->rtwdev;
-	struct seq_file *m = (struct seq_file *)data;
 	struct ieee80211_link_sta *link_sta;
 
 	rcu_read_lock();
 
 	link_sta = rtw89_sta_rcu_dereference_link(rtwsta_link, true);
 
-	seq_printf(m, "STA [%d] %pM %s\n", rtwsta_link->mac_id, link_sta->addr,
-		   sta->tdls ? "(TDLS)" : "");
+	seq_printf(m, "    [%u] %pM\n", rtwsta_link->mac_id, link_sta->addr);
 
 	rcu_read_unlock();
 
+	seq_printf(m, "\tlink_id=%u\n", rtwsta_link->link_id);
 	rtw89_dump_addr_cam(m, rtwdev, &rtwsta_link->addr_cam);
-	rtw89_dump_ba_cam(m, rtwsta_link);
+	rtw89_dump_ba_cam(m, rtwdev, rtwsta_link);
+}
+
+static void rtw89_sta_ids_get_iter(void *data, struct ieee80211_sta *sta)
+{
+	struct seq_file *m = (struct seq_file *)data;
+	struct rtw89_sta *rtwsta = sta_to_rtwsta(sta);
+	struct rtw89_dev *rtwdev = rtwsta->rtwdev;
+	struct rtw89_sta_link *rtwsta_link;
+	unsigned int link_id;
+
+	seq_printf(m, "STA %pM %s\n", sta->addr, sta->tdls ? "(TDLS)" : "");
+	rtw89_sta_for_each_link(rtwsta, rtwsta_link, link_id)
+		rtw89_sta_link_ids_get(m, rtwdev, rtwsta_link);
 }
 
 static int rtw89_debug_priv_stations_get(struct seq_file *m, void *v)
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 8e890ebae613..37f931e88791 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1909,11 +1909,12 @@ int rtw89_fw_h2c_default_dmac_tbl_v2(struct rtw89_dev *rtwdev,
 }
 EXPORT_SYMBOL(rtw89_fw_h2c_default_dmac_tbl_v2);
 
-int rtw89_fw_h2c_ba_cam(struct rtw89_dev *rtwdev, struct rtw89_sta_link *rtwsta_link,
+int rtw89_fw_h2c_ba_cam(struct rtw89_dev *rtwdev,
+			struct rtw89_vif_link *rtwvif_link,
+			struct rtw89_sta_link *rtwsta_link,
 			bool valid, struct ieee80211_ampdu_params *params)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
-	struct rtw89_vif_link *rtwvif_link = rtwsta_link->rtwvif_link;
 	struct rtw89_h2c_ba_cam *h2c;
 	u8 macid = rtwsta_link->mac_id;
 	u32 len = sizeof(*h2c);
@@ -2043,11 +2044,12 @@ void rtw89_fw_h2c_init_dynamic_ba_cam_v0_ext(struct rtw89_dev *rtwdev)
 	}
 }
 
-int rtw89_fw_h2c_ba_cam_v1(struct rtw89_dev *rtwdev, struct rtw89_sta_link *rtwsta_link,
+int rtw89_fw_h2c_ba_cam_v1(struct rtw89_dev *rtwdev,
+			   struct rtw89_vif_link *rtwvif_link,
+			   struct rtw89_sta_link *rtwsta_link,
 			   bool valid, struct ieee80211_ampdu_params *params)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
-	struct rtw89_vif_link *rtwvif_link = rtwsta_link->rtwvif_link;
 	struct rtw89_h2c_ba_cam_v1 *h2c;
 	u8 macid = rtwsta_link->mac_id;
 	u32 len = sizeof(*h2c);
@@ -2293,6 +2295,7 @@ static struct sk_buff *rtw89_sa_query_get(struct rtw89_dev *rtwdev,
 static struct sk_buff *rtw89_arp_response_get(struct rtw89_dev *rtwdev,
 					      struct rtw89_vif_link *rtwvif_link)
 {
+	struct rtw89_vif *rtwvif = rtwvif_link->rtwvif;
 	u8 sec_hdr_len = rtw89_wow_get_sec_hdr_len(rtwdev);
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
 	struct ieee80211_hdr_3addr *hdr;
@@ -2332,7 +2335,7 @@ static struct sk_buff *rtw89_arp_response_get(struct rtw89_dev *rtwdev,
 	arp_hdr->ar_op = htons(ARPOP_REPLY);
 
 	ether_addr_copy(arp_skb->sender_hw, rtwvif_link->mac_addr);
-	arp_skb->sender_ip = rtwvif_link->ip_addr;
+	arp_skb->sender_ip = rtwvif->ip_addr;
 
 	return skb;
 }
@@ -2342,7 +2345,7 @@ static int rtw89_fw_h2c_add_general_pkt(struct rtw89_dev *rtwdev,
 					enum rtw89_fw_pkt_ofld_type type,
 					u8 *id)
 {
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
+	struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
 	struct rtw89_pktofld_info *info;
 	struct sk_buff *skb;
 	int ret;
@@ -2415,9 +2418,13 @@ void rtw89_fw_release_general_pkt_list_vif(struct rtw89_dev *rtwdev,
 void rtw89_fw_release_general_pkt_list(struct rtw89_dev *rtwdev, bool notify_fw)
 {
 	struct rtw89_vif_link *rtwvif_link;
+	struct rtw89_vif *rtwvif;
+	unsigned int link_id;
 
-	rtw89_for_each_rtwvif(rtwdev, rtwvif_link)
-		rtw89_fw_release_general_pkt_list_vif(rtwdev, rtwvif_link, notify_fw);
+	rtw89_for_each_rtwvif(rtwdev, rtwvif)
+		rtw89_vif_for_each_link(rtwvif, rtwvif_link, link_id)
+			rtw89_fw_release_general_pkt_list_vif(rtwdev, rtwvif_link,
+							      notify_fw);
 }
 
 #define H2C_GENERAL_PKT_LEN 6
@@ -2834,7 +2841,7 @@ int rtw89_fw_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
 				struct rtw89_vif_link *rtwvif_link,
 				struct rtw89_sta_link *rtwsta_link)
 {
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
+	struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
 						       rtwvif_link->chanctx_idx);
@@ -2981,7 +2988,7 @@ int rtw89_fw_h2c_assoc_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 				   struct rtw89_vif_link *rtwvif_link,
 				   struct rtw89_sta_link *rtwsta_link)
 {
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
+	struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, rtwvif_link->chanctx_idx);
 	u8 mac_id = rtwsta_link ? rtwsta_link->mac_id : rtwvif_link->mac_id;
 	struct rtw89_h2c_cctlinfo_ud_g7 *h2c;
@@ -3105,10 +3112,10 @@ int rtw89_fw_h2c_assoc_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 EXPORT_SYMBOL(rtw89_fw_h2c_assoc_cmac_tbl_g7);
 
 int rtw89_fw_h2c_ampdu_cmac_tbl_g7(struct rtw89_dev *rtwdev,
-				   struct ieee80211_vif *vif,
-				   struct ieee80211_sta *sta)
+				   struct rtw89_vif_link *rtwvif_link,
+				   struct rtw89_sta_link *rtwsta_link)
 {
-	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
+	struct rtw89_sta *rtwsta = rtwsta_link->rtwsta;
 	struct rtw89_h2c_cctlinfo_ud_g7 *h2c;
 	u32 len = sizeof(*h2c);
 	struct sk_buff *skb;
@@ -3125,11 +3132,11 @@ int rtw89_fw_h2c_ampdu_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 	skb_put(skb, len);
 	h2c = (struct rtw89_h2c_cctlinfo_ud_g7 *)skb->data;
 
-	for_each_set_bit(tid, rtwsta_link->ampdu_map, IEEE80211_NUM_TIDS) {
+	for_each_set_bit(tid, rtwsta->ampdu_map, IEEE80211_NUM_TIDS) {
 		if (agg_num == 0)
-			agg_num = rtwsta_link->ampdu_params[tid].agg_num;
+			agg_num = rtwsta->ampdu_params[tid].agg_num;
 		else
-			agg_num = min(agg_num, rtwsta_link->ampdu_params[tid].agg_num);
+			agg_num = min(agg_num, rtwsta->ampdu_params[tid].agg_num);
 	}
 
 	if (agg_num <= 0x20)
@@ -3256,7 +3263,7 @@ int rtw89_fw_h2c_update_beacon(struct rtw89_dev *rtwdev,
 {
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
 						       rtwvif_link->chanctx_idx);
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
+	struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
 	struct rtw89_h2c_bcn_upd *h2c;
 	struct sk_buff *skb_beacon;
 	struct ieee80211_hdr *hdr;
@@ -3335,7 +3342,7 @@ int rtw89_fw_h2c_update_beacon_be(struct rtw89_dev *rtwdev,
 				  struct rtw89_vif_link *rtwvif_link)
 {
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, rtwvif_link->chanctx_idx);
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
+	struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
 	struct rtw89_h2c_bcn_upd_be *h2c;
 	struct sk_buff *skb_beacon;
 	struct ieee80211_hdr *hdr;
@@ -3899,7 +3906,8 @@ int rtw89_fw_h2c_rssi_offload(struct rtw89_dev *rtwdev,
 
 int rtw89_fw_h2c_tp_offload(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link)
 {
-	struct rtw89_traffic_stats *stats = &rtwvif_link->stats;
+	struct rtw89_vif *rtwvif = rtwvif_link->rtwvif;
+	struct rtw89_traffic_stats *stats = &rtwvif->stats;
 	struct rtw89_h2c_ofld *h2c;
 	u32 len = sizeof(*h2c);
 	struct sk_buff *skb;
@@ -5030,9 +5038,10 @@ int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev *rtwdev,
 				 struct rtw89_vif_link *rtwvif_link,
 				 bool wowlan)
 {
+	struct rtw89_vif *rtwvif = rtwvif_link->rtwvif;
 	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
 	struct rtw89_wait_info *wait = &rtwdev->mac.fw_ofld_wait;
-	struct cfg80211_scan_request *req = rtwvif_link->scan_req;
+	struct cfg80211_scan_request *req = rtwvif->scan_req;
 	struct rtw89_h2c_scanofld_be_macc_role *macc_role;
 	struct rtw89_chan *op = &scan_info->op_chan;
 	struct rtw89_h2c_scanofld_be_opch *opch;
@@ -5935,12 +5944,10 @@ static void rtw89_release_pkt_list(struct rtw89_dev *rtwdev)
 }
 
 static bool rtw89_is_6ghz_wildcard_probe_req(struct rtw89_dev *rtwdev,
-					     struct rtw89_vif_link *rtwvif_link,
+					     struct cfg80211_scan_request *req,
 					     struct rtw89_pktofld_info *info,
 					     enum nl80211_band band, u8 ssid_idx)
 {
-	struct cfg80211_scan_request *req = rtwvif_link->scan_req;
-
 	if (band != NL80211_BAND_6GHZ)
 		return false;
 
@@ -5960,7 +5967,9 @@ static int rtw89_append_probe_req_ie(struct rtw89_dev *rtwdev,
 				     struct sk_buff *skb, u8 ssid_idx)
 {
 	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
-	struct ieee80211_scan_ies *ies = rtwvif_link->scan_ies;
+	struct rtw89_vif *rtwvif = rtwvif_link->rtwvif;
+	struct ieee80211_scan_ies *ies = rtwvif->scan_ies;
+	struct cfg80211_scan_request *req = rtwvif->scan_req;
 	struct rtw89_pktofld_info *info;
 	struct sk_buff *new;
 	int ret = 0;
@@ -5985,8 +5994,7 @@ static int rtw89_append_probe_req_ie(struct rtw89_dev *rtwdev,
 			goto out;
 		}
 
-		rtw89_is_6ghz_wildcard_probe_req(rtwdev, rtwvif_link, info, band,
-						 ssid_idx);
+		rtw89_is_6ghz_wildcard_probe_req(rtwdev, req, info, band, ssid_idx);
 
 		ret = rtw89_fw_h2c_add_pkt_offload(rtwdev, &info->id, new);
 		if (ret) {
@@ -6005,7 +6013,8 @@ static int rtw89_append_probe_req_ie(struct rtw89_dev *rtwdev,
 static int rtw89_hw_scan_update_probe_req(struct rtw89_dev *rtwdev,
 					  struct rtw89_vif_link *rtwvif_link)
 {
-	struct cfg80211_scan_request *req = rtwvif_link->scan_req;
+	struct rtw89_vif *rtwvif = rtwvif_link->rtwvif;
+	struct cfg80211_scan_request *req = rtwvif->scan_req;
 	struct sk_buff *skb;
 	u8 num = req->n_ssids, i;
 	int ret;
@@ -6029,13 +6038,12 @@ static int rtw89_hw_scan_update_probe_req(struct rtw89_dev *rtwdev,
 }
 
 static int rtw89_update_6ghz_rnr_chan(struct rtw89_dev *rtwdev,
+				      struct ieee80211_scan_ies *ies,
 				      struct cfg80211_scan_request *req,
 				      struct rtw89_mac_chinfo *ch_info)
 {
-	struct ieee80211_vif *vif = rtwdev->scan_info.scanning_vif;
+	struct rtw89_vif_link *rtwvif_link = rtwdev->scan_info.scanning_vif;
 	struct list_head *pkt_list = rtwdev->scan_info.pkt_list;
-	struct rtw89_vif_link *rtwvif_link = vif_to_rtwvif_safe(vif);
-	struct ieee80211_scan_ies *ies = rtwvif_link->scan_ies;
 	struct cfg80211_scan_6ghz_params *params;
 	struct rtw89_pktofld_info *info, *tmp;
 	struct ieee80211_hdr *hdr;
@@ -6154,9 +6162,10 @@ static void rtw89_hw_scan_add_chan(struct rtw89_dev *rtwdev, int chan_type,
 				   struct rtw89_mac_chinfo *ch_info)
 {
 	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
-	struct ieee80211_vif *vif = rtwdev->scan_info.scanning_vif;
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
-	struct cfg80211_scan_request *req = rtwvif_link->scan_req;
+	struct rtw89_vif_link *rtwvif_link = rtwdev->scan_info.scanning_vif;
+	struct rtw89_vif *rtwvif = rtwvif_link->rtwvif;
+	struct ieee80211_scan_ies *ies = rtwvif->scan_ies;
+	struct cfg80211_scan_request *req = rtwvif->scan_req;
 	struct rtw89_chan *op = &rtwdev->scan_info.op_chan;
 	struct rtw89_pktofld_info *info;
 	u8 band, probe_count = 0;
@@ -6181,7 +6190,7 @@ static void rtw89_hw_scan_add_chan(struct rtw89_dev *rtwdev, int chan_type,
 		}
 	}
 
-	ret = rtw89_update_6ghz_rnr_chan(rtwdev, req, ch_info);
+	ret = rtw89_update_6ghz_rnr_chan(rtwdev, ies, req, ch_info);
 	if (ret)
 		rtw89_warn(rtwdev, "RNR fails: %d\n", ret);
 
@@ -6271,9 +6280,9 @@ static void rtw89_hw_scan_add_chan_be(struct rtw89_dev *rtwdev, int chan_type,
 				      struct rtw89_mac_chinfo_be *ch_info)
 {
 	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
-	struct ieee80211_vif *vif = rtwdev->scan_info.scanning_vif;
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
-	struct cfg80211_scan_request *req = rtwvif_link->scan_req;
+	struct rtw89_vif_link *rtwvif_link = rtwdev->scan_info.scanning_vif;
+	struct rtw89_vif *rtwvif = rtwvif_link->rtwvif;
+	struct cfg80211_scan_request *req = rtwvif->scan_req;
 	struct rtw89_pktofld_info *info;
 	u8 band, probe_count = 0, i;
 
@@ -6381,7 +6390,8 @@ int rtw89_pno_scan_add_chan_list_ax(struct rtw89_dev *rtwdev,
 int rtw89_hw_scan_add_chan_list_ax(struct rtw89_dev *rtwdev,
 				   struct rtw89_vif_link *rtwvif_link, bool connected)
 {
-	struct cfg80211_scan_request *req = rtwvif_link->scan_req;
+	struct rtw89_vif *rtwvif = rtwvif_link->rtwvif;
+	struct cfg80211_scan_request *req = rtwvif->scan_req;
 	struct rtw89_mac_chinfo	*ch_info, *tmp;
 	struct ieee80211_channel *channel;
 	struct list_head chan_list;
@@ -6510,7 +6520,8 @@ int rtw89_pno_scan_add_chan_list_be(struct rtw89_dev *rtwdev,
 int rtw89_hw_scan_add_chan_list_be(struct rtw89_dev *rtwdev,
 				   struct rtw89_vif_link *rtwvif_link, bool connected)
 {
-	struct cfg80211_scan_request *req = rtwvif_link->scan_req;
+	struct rtw89_vif *rtwvif = rtwvif_link->rtwvif;
+	struct cfg80211_scan_request *req = rtwvif->scan_req;
 	struct rtw89_mac_chinfo_be *ch_info, *tmp;
 	struct ieee80211_channel *channel;
 	struct list_head chan_list;
@@ -6582,21 +6593,26 @@ static int rtw89_hw_scan_prehandle(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
-void rtw89_hw_scan_start(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
+void rtw89_hw_scan_start(struct rtw89_dev *rtwdev,
+			 struct rtw89_vif_link *rtwvif_link,
 			 struct ieee80211_scan_request *scan_req)
 {
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	struct cfg80211_scan_request *req = &scan_req->req;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
+						       rtwvif_link->chanctx_idx);
+	struct rtw89_vif *rtwvif = rtwvif_link->rtwvif;
 	u32 rx_fltr = rtwdev->hal.rx_fltr;
 	u8 mac_addr[ETH_ALEN];
 
-	rtw89_get_channel(rtwdev, rtwvif_link, &rtwdev->scan_info.op_chan);
-	rtwdev->scan_info.scanning_vif = vif;
+	/* clone op and keep it during scan */
+	rtwdev->scan_info.op_chan = *chan;
+
+	rtwdev->scan_info.scanning_vif = rtwvif_link;
 	rtwdev->scan_info.last_chan_idx = 0;
 	rtwdev->scan_info.abort = false;
-	rtwvif_link->scan_ies = &scan_req->ies;
-	rtwvif_link->scan_req = req;
+	rtwvif->scan_ies = &scan_req->ies;
+	rtwvif->scan_req = req;
 	ieee80211_stop_queues(rtwdev->hw);
 	rtw89_mac_port_cfg_rx_sync(rtwdev, rtwvif_link, false);
 
@@ -6618,33 +6634,36 @@ void rtw89_hw_scan_start(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 	rtw89_chanctx_pause(rtwdev, RTW89_CHANCTX_PAUSE_REASON_HW_SCAN);
 }
 
-void rtw89_hw_scan_complete(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
+void rtw89_hw_scan_complete(struct rtw89_dev *rtwdev,
+			    struct rtw89_vif_link *rtwvif_link,
 			    bool aborted)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
-	struct rtw89_vif_link *rtwvif_link = vif_to_rtwvif_safe(vif);
 	struct cfg80211_scan_info info = {
 		.aborted = aborted,
 	};
+	struct rtw89_vif *rtwvif;
 
-	if (!vif)
+	if (!rtwvif_link)
 		return;
 
+	rtwvif = rtwvif_link->rtwvif;
+
 	rtw89_write32_mask(rtwdev,
 			   rtw89_mac_reg_by_idx(rtwdev, mac->rx_fltr, RTW89_MAC_0),
 			   B_AX_RX_FLTR_CFG_MASK,
 			   rtwdev->hal.rx_fltr);
 
-	rtw89_core_scan_complete(rtwdev, vif, true);
+	rtw89_core_scan_complete(rtwdev, rtwvif_link, true);
 	ieee80211_scan_completed(rtwdev->hw, &info);
 	ieee80211_wake_queues(rtwdev->hw);
 	rtw89_mac_port_cfg_rx_sync(rtwdev, rtwvif_link, true);
 	rtw89_mac_enable_beacon_for_ap_vifs(rtwdev, true);
 
 	rtw89_release_pkt_list(rtwdev);
-	rtwvif_link->scan_req = NULL;
-	rtwvif_link->scan_ies = NULL;
+	rtwvif->scan_req = NULL;
+	rtwvif->scan_ies = NULL;
 	scan_info->last_chan_idx = 0;
 	scan_info->scanning_vif = NULL;
 	scan_info->abort = false;
@@ -6652,14 +6671,15 @@ void rtw89_hw_scan_complete(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 	rtw89_chanctx_proceed(rtwdev);
 }
 
-void rtw89_hw_scan_abort(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif)
+void rtw89_hw_scan_abort(struct rtw89_dev *rtwdev,
+			 struct rtw89_vif_link *rtwvif_link)
 {
 	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
 	int ret;
 
 	scan_info->abort = true;
 
-	ret = rtw89_hw_scan_offload(rtwdev, vif, false);
+	ret = rtw89_hw_scan_offload(rtwdev, rtwvif_link, false);
 	if (ret)
 		rtw89_warn(rtwdev, "rtw89_hw_scan_offload failed ret %d\n", ret);
 
@@ -6668,32 +6688,35 @@ void rtw89_hw_scan_abort(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif)
 	 * RTW89_SCAN_END_SCAN_NOTIFY, so that ieee80211_stop() can flush scan
 	 * work properly.
 	 */
-	rtw89_hw_scan_complete(rtwdev, vif, true);
+	rtw89_hw_scan_complete(rtwdev, rtwvif_link, true);
 }
 
 static bool rtw89_is_any_vif_connected_or_connecting(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_vif_link *rtwvif_link;
-
-	rtw89_for_each_rtwvif(rtwdev, rtwvif_link) {
-		/* This variable implies connected or during attempt to connect */
-		if (!is_zero_ether_addr(rtwvif_link->bssid))
-			return true;
+	struct rtw89_vif *rtwvif;
+	unsigned int link_id;
+
+	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
+		rtw89_vif_for_each_link(rtwvif, rtwvif_link, link_id) {
+			/* This variable implies connected or during attempt to connect */
+			if (!is_zero_ether_addr(rtwvif_link->bssid))
+				return true;
+		}
 	}
 
 	return false;
 }
 
-int rtw89_hw_scan_offload(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
+int rtw89_hw_scan_offload(struct rtw89_dev *rtwdev,
+			  struct rtw89_vif_link *rtwvif_link,
 			  bool enable)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	struct rtw89_scan_option opt = {0};
-	struct rtw89_vif_link *rtwvif_link;
 	bool connected;
 	int ret = 0;
 
-	rtwvif_link = vif ? (struct rtw89_vif_link *)vif->drv_priv : NULL;
 	if (!rtwvif_link)
 		return -EINVAL;
 
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 17e952bd70e3..ccbbc43f33fe 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -4419,8 +4419,8 @@ int rtw89_fw_h2c_assoc_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 				   struct rtw89_vif_link *rtwvif_link,
 				   struct rtw89_sta_link *rtwsta_link);
 int rtw89_fw_h2c_ampdu_cmac_tbl_g7(struct rtw89_dev *rtwdev,
-				   struct ieee80211_vif *vif,
-				   struct ieee80211_sta *sta);
+				   struct rtw89_vif_link *rtwvif_link,
+				   struct rtw89_sta_link *rtwsta_link);
 int rtw89_fw_h2c_txtime_cmac_tbl(struct rtw89_dev *rtwdev,
 				 struct rtw89_sta_link *rtwsta_link);
 int rtw89_fw_h2c_txpath_cmac_tbl(struct rtw89_dev *rtwdev,
@@ -4514,9 +4514,13 @@ void rtw89_fw_release_general_pkt_list_vif(struct rtw89_dev *rtwdev,
 					   struct rtw89_vif_link *rtwvif_link,
 					   bool notify_fw);
 void rtw89_fw_release_general_pkt_list(struct rtw89_dev *rtwdev, bool notify_fw);
-int rtw89_fw_h2c_ba_cam(struct rtw89_dev *rtwdev, struct rtw89_sta_link *rtwsta_link,
+int rtw89_fw_h2c_ba_cam(struct rtw89_dev *rtwdev,
+			struct rtw89_vif_link *rtwvif_link,
+			struct rtw89_sta_link *rtwsta_link,
 			bool valid, struct ieee80211_ampdu_params *params);
-int rtw89_fw_h2c_ba_cam_v1(struct rtw89_dev *rtwdev, struct rtw89_sta_link *rtwsta_link,
+int rtw89_fw_h2c_ba_cam_v1(struct rtw89_dev *rtwdev,
+			   struct rtw89_vif_link *rtwvif_link,
+			   struct rtw89_sta_link *rtwsta_link,
 			   bool valid, struct ieee80211_ampdu_params *params);
 void rtw89_fw_h2c_init_dynamic_ba_cam_v0_ext(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_init_ba_cam_users(struct rtw89_dev *rtwdev, u8 users,
@@ -4535,13 +4539,17 @@ int rtw89_fw_msg_reg(struct rtw89_dev *rtwdev,
 		     struct rtw89_mac_c2h_info *c2h_info);
 int rtw89_fw_h2c_fw_log(struct rtw89_dev *rtwdev, bool enable);
 void rtw89_fw_st_dbg_dump(struct rtw89_dev *rtwdev);
-void rtw89_hw_scan_start(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
-			 struct ieee80211_scan_request *req);
-void rtw89_hw_scan_complete(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
+void rtw89_hw_scan_start(struct rtw89_dev *rtwdev,
+			 struct rtw89_vif_link *rtwvif_link,
+			 struct ieee80211_scan_request *scan_req);
+void rtw89_hw_scan_complete(struct rtw89_dev *rtwdev,
+			    struct rtw89_vif_link *rtwvif_link,
 			    bool aborted);
-int rtw89_hw_scan_offload(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
+int rtw89_hw_scan_offload(struct rtw89_dev *rtwdev,
+			  struct rtw89_vif_link *rtwvif_link,
 			  bool enable);
-void rtw89_hw_scan_abort(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif);
+void rtw89_hw_scan_abort(struct rtw89_dev *rtwdev,
+			 struct rtw89_vif_link *rtwvif_link);
 int rtw89_hw_scan_add_chan_list_ax(struct rtw89_dev *rtwdev,
 				   struct rtw89_vif_link *rtwvif_link, bool connected);
 int rtw89_pno_scan_add_chan_list_ax(struct rtw89_dev *rtwdev,
@@ -4662,25 +4670,59 @@ static inline int rtw89_chip_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
 	return chip->ops->h2c_assoc_cmac_tbl(rtwdev, rtwvif_link, rtwsta_link);
 }
 
-static inline int rtw89_chip_h2c_ampdu_cmac_tbl(struct rtw89_dev *rtwdev,
-						struct ieee80211_vif *vif,
-						struct ieee80211_sta *sta)
+static inline
+int rtw89_chip_h2c_ampdu_link_cmac_tbl(struct rtw89_dev *rtwdev,
+				       struct rtw89_vif_link *rtwvif_link,
+				       struct rtw89_sta_link *rtwsta_link)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 
 	if (chip->ops->h2c_ampdu_cmac_tbl)
-		return chip->ops->h2c_ampdu_cmac_tbl(rtwdev, vif, sta);
+		return chip->ops->h2c_ampdu_cmac_tbl(rtwdev, rtwvif_link,
+						     rtwsta_link);
+
+	return 0;
+}
+
+static inline int rtw89_chip_h2c_ampdu_cmac_tbl(struct rtw89_dev *rtwdev,
+						struct rtw89_vif *rtwvif,
+						struct rtw89_sta *rtwsta)
+{
+	struct rtw89_vif_link *rtwvif_link;
+	struct rtw89_sta_link *rtwsta_link;
+	unsigned int link_id;
+	int ret;
+
+	rtw89_sta_for_each_link(rtwsta, rtwsta_link, link_id) {
+		rtwvif_link = rtwsta_link->rtwvif_link;
+		ret = rtw89_chip_h2c_ampdu_link_cmac_tbl(rtwdev, rtwvif_link,
+							 rtwsta_link);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
 
 static inline
-int rtw89_chip_h2c_ba_cam(struct rtw89_dev *rtwdev, struct rtw89_sta_link *rtwsta_link,
+int rtw89_chip_h2c_ba_cam(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 			  bool valid, struct ieee80211_ampdu_params *params)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_vif_link *rtwvif_link;
+	struct rtw89_sta_link *rtwsta_link;
+	unsigned int link_id;
+	int ret;
+
+	rtw89_sta_for_each_link(rtwsta, rtwsta_link, link_id) {
+		rtwvif_link = rtwsta_link->rtwvif_link;
+		ret = chip->ops->h2c_ba_cam(rtwdev, rtwvif_link, rtwsta_link,
+					    valid, params);
+		if (ret)
+			return ret;
+	}
 
-	return chip->ops->h2c_ba_cam(rtwdev, rtwsta_link, valid, params);
+	return 0;
 }
 
 /* must consider compatibility; don't insert new in the mid */
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 28cc4885105a..4e15d539e3d1 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4298,10 +4298,13 @@ static void rtw89_mac_port_cfg_tx_sw_by_nettype(struct rtw89_dev *rtwdev,
 void rtw89_mac_enable_beacon_for_ap_vifs(struct rtw89_dev *rtwdev, bool en)
 {
 	struct rtw89_vif_link *rtwvif_link;
+	struct rtw89_vif *rtwvif;
+	unsigned int link_id;
 
-	rtw89_for_each_rtwvif(rtwdev, rtwvif_link)
-		if (rtwvif_link->net_type == RTW89_NET_TYPE_AP_MODE)
-			rtw89_mac_port_cfg_tx_sw(rtwdev, rtwvif_link, en);
+	rtw89_for_each_rtwvif(rtwdev, rtwvif)
+		rtw89_vif_for_each_link(rtwvif, rtwvif_link, link_id)
+			if (rtwvif_link->net_type == RTW89_NET_TYPE_AP_MODE)
+				rtw89_mac_port_cfg_tx_sw(rtwdev, rtwvif_link, en);
 }
 
 static void rtw89_mac_port_cfg_bcn_intv(struct rtw89_dev *rtwdev,
@@ -4547,13 +4550,17 @@ static void rtw89_mac_port_tsf_resync_all(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_vif_link *src = NULL, *tmp;
 	u8 offset = 100, vif_aps = 0;
+	struct rtw89_vif *rtwvif;
+	unsigned int link_id;
 	int n_offset = 1;
 
-	rtw89_for_each_rtwvif(rtwdev, tmp) {
-		if (!src || tmp->net_type == RTW89_NET_TYPE_INFRA)
-			src = tmp;
-		if (tmp->net_type == RTW89_NET_TYPE_AP_MODE)
-			vif_aps++;
+	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
+		rtw89_vif_for_each_link(rtwvif, tmp, link_id) {
+			if (!src || tmp->net_type == RTW89_NET_TYPE_INFRA)
+				src = tmp;
+			if (tmp->net_type == RTW89_NET_TYPE_AP_MODE)
+				vif_aps++;
+		}
 	}
 
 	if (vif_aps == 0)
@@ -4561,8 +4568,10 @@ static void rtw89_mac_port_tsf_resync_all(struct rtw89_dev *rtwdev)
 
 	offset /= (vif_aps + 1);
 
-	rtw89_for_each_rtwvif(rtwdev, tmp)
-		rtw89_mac_port_tsf_sync_rand(rtwdev, tmp, src, offset, &n_offset);
+	rtw89_for_each_rtwvif(rtwdev, rtwvif)
+		rtw89_vif_for_each_link(rtwvif, tmp, link_id)
+			rtw89_mac_port_tsf_sync_rand(rtwdev, tmp, src, offset,
+						     &n_offset);
 }
 
 int rtw89_mac_vif_init(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link)
@@ -4699,7 +4708,7 @@ static void rtw89_mac_check_he_obss_narrow_bw_ru_iter(struct wiphy *wiphy,
 void rtw89_mac_set_he_obss_narrow_bw_ru(struct rtw89_dev *rtwdev,
 					struct rtw89_vif_link *rtwvif_link)
 {
-	struct ieee80211_vif *vif = rtwvif_to_vif_safe(rtwvif_link);
+	struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	struct ieee80211_hw *hw = rtwdev->hw;
 	struct ieee80211_bss_conf *bss_conf;
@@ -4768,8 +4777,8 @@ rtw89_mac_c2h_scanofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 {
 	const struct rtw89_c2h_scanofld *c2h =
 		(const struct rtw89_c2h_scanofld *)skb->data;
-	struct ieee80211_vif *vif = rtwdev->scan_info.scanning_vif;
-	struct rtw89_vif_link *rtwvif_link = vif_to_rtwvif_safe(vif);
+	struct rtw89_vif_link *rtwvif_link = rtwdev->scan_info.scanning_vif;
+	struct rtw89_vif *rtwvif;
 	struct rtw89_chan new;
 	u8 reason, status, tx_fail, band, actual_period, expect_period;
 	u32 last_chan = rtwdev->scan_info.last_chan_idx, report_tsf;
@@ -4780,6 +4789,8 @@ rtw89_mac_c2h_scanofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 	if (!rtwvif_link)
 		return;
 
+	rtwvif = rtwvif_link->rtwvif;
+
 	tx_fail = le32_get_bits(c2h->w5, RTW89_C2H_SCANOFLD_W5_TX_FAIL);
 	status = le32_get_bits(c2h->w2, RTW89_C2H_SCANOFLD_W2_STATUS);
 	chan = le32_get_bits(c2h->w2, RTW89_C2H_SCANOFLD_W2_PRI_CH);
@@ -4819,15 +4830,15 @@ rtw89_mac_c2h_scanofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 		if (rtwdev->scan_info.abort)
 			return;
 
-		if (rtwvif_link && rtwvif_link->scan_req &&
-		    last_chan < rtwvif_link->scan_req->n_channels) {
-			ret = rtw89_hw_scan_offload(rtwdev, vif, true);
+		if (rtwvif_link && rtwvif->scan_req &&
+		    last_chan < rtwvif->scan_req->n_channels) {
+			ret = rtw89_hw_scan_offload(rtwdev, rtwvif_link, true);
 			if (ret) {
-				rtw89_hw_scan_abort(rtwdev, vif);
+				rtw89_hw_scan_abort(rtwdev, rtwvif_link);
 				rtw89_warn(rtwdev, "HW scan failed: %d\n", ret);
 			}
 		} else {
-			rtw89_hw_scan_complete(rtwdev, vif, false);
+			rtw89_hw_scan_complete(rtwdev, rtwvif_link, false);
 		}
 		break;
 	case RTW89_SCAN_ENTER_OP_NOTIFY:
@@ -4853,7 +4864,8 @@ static void
 rtw89_mac_bcn_fltr_rpt(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
 		       struct sk_buff *skb)
 {
-	struct ieee80211_vif *vif = rtwvif_to_vif_safe(rtwvif_link);
+	struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
+	struct rtw89_vif *rtwvif = rtwvif_link->rtwvif;
 	enum nl80211_cqm_rssi_threshold_event nl_event;
 	const struct rtw89_c2h_mac_bcnfltr_rpt *c2h =
 		(const struct rtw89_c2h_mac_bcnfltr_rpt *)skb->data;
@@ -4874,7 +4886,7 @@ rtw89_mac_bcn_fltr_rpt(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_l
 
 	switch (type) {
 	case RTW89_BCN_FLTR_BEACON_LOSS:
-		if (!rtwdev->scanning && !rtwvif_link->offchan)
+		if (!rtwdev->scanning && !rtwvif->offchan)
 			ieee80211_connection_loss(vif);
 		else
 			rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, rtwvif_link, true);
@@ -4902,9 +4914,12 @@ rtw89_mac_c2h_bcn_fltr_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h,
 			   u32 len)
 {
 	struct rtw89_vif_link *rtwvif_link;
+	struct rtw89_vif *rtwvif;
+	unsigned int link_id;
 
-	rtw89_for_each_rtwvif(rtwdev, rtwvif_link)
-		rtw89_mac_bcn_fltr_rpt(rtwdev, rtwvif_link, c2h);
+	rtw89_for_each_rtwvif(rtwdev, rtwvif)
+		rtw89_vif_for_each_link(rtwvif, rtwvif_link, link_id)
+			rtw89_mac_bcn_fltr_rpt(rtwdev, rtwvif_link, c2h);
 }
 
 static void
@@ -6112,10 +6127,21 @@ void rtw89_mac_bf_disassoc(struct rtw89_dev *rtwdev,
 void rtw89_mac_bf_set_gid_table(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 				struct ieee80211_bss_conf *conf)
 {
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
-	u8 mac_idx = rtwvif_link->mac_idx;
+	struct rtw89_vif *rtwvif = vif_to_rtwvif(vif);
+	struct rtw89_vif_link *rtwvif_link;
+	u8 mac_idx;
 	__le32 *p;
 
+	rtwvif_link = rtwvif->links[conf->link_id];
+	if (unlikely(!rtwvif_link)) {
+		rtw89_err(rtwdev,
+			  "%s: rtwvif link (link_id %u) is not active\n",
+			  __func__, conf->link_id);
+		return;
+	}
+
+	mac_idx = rtwvif_link->mac_idx;
+
 	rtw89_debug(rtwdev, RTW89_DBG_BF, "update bf GID table\n");
 
 	p = (__le32 *)conf->mu_group.membership;
@@ -6146,20 +6172,30 @@ struct rtw89_mac_bf_monitor_iter_data {
 static
 void rtw89_mac_bf_monitor_calc_iter(void *data, struct ieee80211_sta *sta)
 {
-	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
 	struct rtw89_mac_bf_monitor_iter_data *iter_data =
 				(struct rtw89_mac_bf_monitor_iter_data *)data;
 	struct rtw89_sta_link *down_rtwsta_link = iter_data->down_rtwsta_link;
+	struct rtw89_sta *rtwsta = sta_to_rtwsta(sta);
 	struct ieee80211_link_sta *link_sta;
+	struct rtw89_sta_link *rtwsta_link;
+	bool has_beamformer_cap = false;
 	int *count = &iter_data->count;
-
-	if (down_rtwsta_link == rtwsta_link)
-		return;
+	unsigned int link_id;
 
 	rcu_read_lock();
 
-	link_sta = rtw89_sta_rcu_dereference_link(rtwsta_link, false);
-	if (rtw89_sta_has_beamformer_cap(link_sta))
+	rtw89_sta_for_each_link(rtwsta, rtwsta_link, link_id) {
+		if (rtwsta_link == down_rtwsta_link)
+			continue;
+
+		link_sta = rtw89_sta_rcu_dereference_link(rtwsta_link, false);
+		if (rtw89_sta_has_beamformer_cap(link_sta)) {
+			has_beamformer_cap = true;
+			break;
+		}
+	}
+
+	if (has_beamformer_cap)
 		(*count)++;
 
 	rcu_read_unlock();
@@ -6191,7 +6227,9 @@ void _rtw89_mac_bf_monitor_track(struct rtw89_dev *rtwdev)
 	struct rtw89_vif_link *rtwvif_link;
 	bool en = stats->tx_tfc_lv <= stats->rx_tfc_lv;
 	bool old = test_bit(RTW89_FLAG_BFEE_EN, rtwdev->flags);
+	struct rtw89_vif *rtwvif;
 	bool keep_timer = true;
+	unsigned int link_id;
 	bool old_keep_timer;
 
 	old_keep_timer = test_bit(RTW89_FLAG_BFEE_TIMER_KEEP, rtwdev->flags);
@@ -6200,16 +6238,18 @@ void _rtw89_mac_bf_monitor_track(struct rtw89_dev *rtwdev)
 		keep_timer = false;
 
 	if (keep_timer != old_keep_timer) {
-		rtw89_for_each_rtwvif(rtwdev, rtwvif_link)
-			rtw89_mac_bfee_standby_timer(rtwdev, rtwvif_link->mac_idx,
-						     keep_timer);
+		rtw89_for_each_rtwvif(rtwdev, rtwvif)
+			rtw89_vif_for_each_link(rtwvif, rtwvif_link, link_id)
+				rtw89_mac_bfee_standby_timer(rtwdev, rtwvif_link->mac_idx,
+							     keep_timer);
 	}
 
 	if (en == old)
 		return;
 
-	rtw89_for_each_rtwvif(rtwdev, rtwvif_link)
-		rtw89_mac_bfee_ctrl(rtwdev, rtwvif_link->mac_idx, en);
+	rtw89_for_each_rtwvif(rtwdev, rtwvif)
+		rtw89_vif_for_each_link(rtwvif, rtwvif_link, link_id)
+			rtw89_mac_bfee_ctrl(rtwdev, rtwvif_link->mac_idx, en);
 }
 
 static int
@@ -6393,7 +6433,9 @@ int rtw89_mac_read_xtal_si_ax(struct rtw89_dev *rtwdev, u8 offset, u8 *val)
 }
 
 static
-void rtw89_mac_pkt_drop_sta(struct rtw89_dev *rtwdev, struct rtw89_sta_link *rtwsta_link)
+void rtw89_mac_pkt_drop_sta(struct rtw89_dev *rtwdev,
+			    struct rtw89_vif_link *rtwvif_link,
+			    struct rtw89_sta_link *rtwsta_link)
 {
 	static const enum rtw89_pkt_drop_sel sels[] = {
 		RTW89_PKT_DROP_SEL_MACID_BE_ONCE,
@@ -6401,7 +6443,6 @@ void rtw89_mac_pkt_drop_sta(struct rtw89_dev *rtwdev, struct rtw89_sta_link *rtw
 		RTW89_PKT_DROP_SEL_MACID_VI_ONCE,
 		RTW89_PKT_DROP_SEL_MACID_VO_ONCE,
 	};
-	struct rtw89_vif_link *rtwvif_link = rtwsta_link->rtwvif_link;
 	struct rtw89_pkt_drop_params params = {0};
 	int i;
 
@@ -6419,22 +6460,28 @@ void rtw89_mac_pkt_drop_sta(struct rtw89_dev *rtwdev, struct rtw89_sta_link *rtw
 
 static void rtw89_mac_pkt_drop_vif_iter(void *data, struct ieee80211_sta *sta)
 {
-	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
-	struct rtw89_vif_link *rtwvif_link = rtwsta_link->rtwvif_link;
-	struct rtw89_dev *rtwdev = rtwvif_link->rtwdev;
-	struct rtw89_vif_link *target = data;
+	struct rtw89_sta *rtwsta = sta_to_rtwsta(sta);
+	struct rtw89_vif *rtwvif = rtwsta->rtwvif;
+	struct rtw89_dev *rtwdev = rtwsta->rtwdev;
+	struct rtw89_vif_link *rtwvif_link;
+	struct rtw89_sta_link *rtwsta_link;
+	struct rtw89_vif *target = data;
+	unsigned int link_id;
 
-	if (rtwvif_link != target)
+	if (rtwvif != target)
 		return;
 
-	rtw89_mac_pkt_drop_sta(rtwdev, rtwsta_link);
+	rtw89_sta_for_each_link(rtwsta, rtwsta_link, link_id) {
+		rtwvif_link = rtwsta_link->rtwvif_link;
+		rtw89_mac_pkt_drop_sta(rtwdev, rtwvif_link, rtwsta_link);
+	}
 }
 
-void rtw89_mac_pkt_drop_vif(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link)
+void rtw89_mac_pkt_drop_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 {
 	ieee80211_iterate_stations_atomic(rtwdev->hw,
 					  rtw89_mac_pkt_drop_vif_iter,
-					  rtwvif_link);
+					  rtwvif);
 }
 
 int rtw89_mac_ptk_drop_by_band_and_wait(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index b781b823496f..0c269961a573 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1466,7 +1466,7 @@ int rtw89_mac_read_xtal_si(struct rtw89_dev *rtwdev, u8 offset, u8 *val)
 	return mac->read_xtal_si(rtwdev, offset, val);
 }
 
-void rtw89_mac_pkt_drop_vif(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link);
+void rtw89_mac_pkt_drop_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
 int rtw89_mac_resize_ple_rx_quota(struct rtw89_dev *rtwdev, bool wow);
 int rtw89_mac_ptk_drop_by_band_and_wait(struct rtw89_dev *rtwdev,
 					enum rtw89_mac_idx band);
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index fc05ad1b799b..44ba4dc181b5 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -23,17 +23,16 @@ static void rtw89_ops_tx(struct ieee80211_hw *hw,
 	struct rtw89_dev *rtwdev = hw->priv;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_vif *vif = info->control.vif;
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
+	struct rtw89_vif *rtwvif = vif_to_rtwvif(vif);
 	struct ieee80211_sta *sta = control->sta;
 	u32 flags = IEEE80211_SKB_CB(skb)->flags;
 	int ret, qsel;
 
-	if (rtwvif_link->offchan && !(flags & IEEE80211_TX_CTL_TX_OFFCHAN) && sta) {
-		struct rtw89_sta_link *rtwsta_link =
-			(struct rtw89_sta_link *)sta->drv_priv;
+	if (rtwvif->offchan && !(flags & IEEE80211_TX_CTL_TX_OFFCHAN) && sta) {
+		struct rtw89_sta *rtwsta = sta_to_rtwsta(sta);
 
 		rtw89_debug(rtwdev, RTW89_DBG_TXRX, "ops_tx during offchan\n");
-		skb_queue_tail(&rtwsta_link->roc_queue, skb);
+		skb_queue_tail(&rtwsta->roc_queue, skb);
 		return;
 	}
 
@@ -158,7 +157,8 @@ static int rtw89_ops_add_interface(struct ieee80211_hw *hw,
 				   struct ieee80211_vif *vif)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
+	struct rtw89_vif *rtwvif = vif_to_rtwvif(vif);
+	struct rtw89_vif_link *rtwvif_link;
 	u8 mac_id, port;
 	int ret = 0;
 
@@ -173,13 +173,6 @@ static int rtw89_ops_add_interface(struct ieee80211_hw *hw,
 		vif->driver_flags |= IEEE80211_VIF_BEACON_FILTER |
 				     IEEE80211_VIF_SUPPORTS_CQM_RSSI;
 
-	rtwvif_link->rtwdev = rtwdev;
-	rtwvif_link->roc.state = RTW89_ROC_IDLE;
-	rtwvif_link->offchan = false;
-	INIT_DELAYED_WORK(&rtwvif_link->roc.roc_work, rtw89_roc_work);
-
-	rtw89_traffic_stats_init(rtwdev, &rtwvif_link->stats);
-
 	mac_id = rtw89_acquire_mac_id(rtwdev);
 	if (mac_id == RTW89_MAX_MAC_ID_NUM) {
 		ret = -ENOSPC;
@@ -192,27 +185,40 @@ static int rtw89_ops_add_interface(struct ieee80211_hw *hw,
 		goto release_macid;
 	}
 
-	rtwvif_link->mac_idx = RTW89_MAC_0;
-	rtwvif_link->phy_idx = RTW89_PHY_0;
-	rtwvif_link->mac_id = mac_id;
-	rtwvif_link->port = port;
+	rtw89_init_vif(rtwdev, rtwvif, mac_id, port);
 
 	rtw89_core_txq_init(rtwdev, vif->txq);
 
-	if (!rtw89_rtwvif_in_list(rtwdev, rtwvif_link))
-		list_add_tail(&rtwvif_link->list, &rtwdev->rtwvifs_list);
+	if (!rtw89_rtwvif_in_list(rtwdev, rtwvif))
+		list_add_tail(&rtwvif->list, &rtwdev->rtwvifs_list);
+
+	ether_addr_copy(rtwvif->mac_addr, vif->addr);
+
+	rtwvif->offchan = false;
+	rtwvif->roc.state = RTW89_ROC_IDLE;
+	INIT_DELAYED_WORK(&rtwvif->roc.roc_work, rtw89_roc_work);
+
+	rtw89_traffic_stats_init(rtwdev, &rtwvif->stats);
+
+	rtwvif_link = rtw89_vif_set_link(rtwvif, 0);
+	if (!rtwvif_link) {
+		ret = -EINVAL;
+		goto release_port;
+	}
 
 	ret = __rtw89_ops_add_iface_link(rtwdev, rtwvif_link);
 	if (ret)
-		goto release_port;
+		goto unset_link;
 
 	rtw89_recalc_lps(rtwdev);
 
 	mutex_unlock(&rtwdev->mutex);
 	return 0;
 
+unset_link:
+	rtw89_vif_unset_link(rtwvif, 0);
 release_port:
-	list_del_init(&rtwvif_link->list);
+	list_del_init(&rtwvif->list);
 	rtw89_core_release_bit_map(rtwdev->hw_port, port);
 release_macid:
 	rtw89_release_mac_id(rtwdev, mac_id);
@@ -226,20 +232,35 @@ static void rtw89_ops_remove_interface(struct ieee80211_hw *hw,
 				       struct ieee80211_vif *vif)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
+	struct rtw89_vif *rtwvif = vif_to_rtwvif(vif);
+	u8 macid = rtw89_vif_get_main_macid(rtwvif);
+	u8 port = rtw89_vif_get_main_port(rtwvif);
+	struct rtw89_vif_link *rtwvif_link;
 
 	rtw89_debug(rtwdev, RTW89_DBG_STATE, "remove vif %pM type %d p2p %d\n",
 		    vif->addr, vif->type, vif->p2p);
 
-	cancel_delayed_work_sync(&rtwvif_link->roc.roc_work);
+	cancel_delayed_work_sync(&rtwvif->roc.roc_work);
 
 	mutex_lock(&rtwdev->mutex);
 
+	rtwvif_link = rtwvif->links[0];
+	if (unlikely(!rtwvif_link)) {
+		rtw89_err(rtwdev,
+			  "%s: rtwvif link (link_id %u) is not active\n",
+			  __func__, 0);
+		goto bottom;
+	}
+
 	__rtw89_ops_remove_iface_link(rtwdev, rtwvif_link);
 
-	rtw89_core_release_bit_map(rtwdev->hw_port, rtwvif_link->port);
-	rtw89_release_mac_id(rtwdev, rtwvif_link->mac_id);
-	list_del_init(&rtwvif_link->list);
+	rtw89_vif_unset_link(rtwvif, 0);
+
+bottom:
+	list_del_init(&rtwvif->list);
+	rtw89_core_release_bit_map(rtwdev->hw_port, port);
+	rtw89_release_mac_id(rtwdev, macid);
+
 	rtw89_recalc_lps(rtwdev);
 	rtw89_enter_ips_by_hwflags(rtwdev);
 
@@ -460,8 +481,10 @@ static int __rtw89_ops_sta_add(struct rtw89_dev *rtwdev,
 			       struct ieee80211_vif *vif,
 			       struct ieee80211_sta *sta)
 {
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
-	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
+	struct rtw89_vif *rtwvif = vif_to_rtwvif(vif);
+	struct rtw89_sta *rtwsta = sta_to_rtwsta(sta);
+	struct rtw89_vif_link *rtwvif_link;
+	struct rtw89_sta_link *rtwsta_link;
 	bool acquire_macid = false;
 	u8 macid;
 	int ret;
@@ -469,7 +492,7 @@ static int __rtw89_ops_sta_add(struct rtw89_dev *rtwdev,
 
 	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls) {
 		/* for station mode, assign the mac_id from itself */
-		macid = rtwvif_link->mac_id;
+		macid = rtw89_vif_get_main_macid(rtwvif);
 	} else {
 		macid = rtw89_acquire_mac_id(rtwdev);
 		if (macid == RTW89_MAX_MAC_ID_NUM)
@@ -478,24 +501,32 @@ static int __rtw89_ops_sta_add(struct rtw89_dev *rtwdev,
 		acquire_macid = true;
 	}
 
-	rtwsta_link->rtwdev = rtwdev;
-	rtwsta_link->rtwvif_link = rtwvif_link;
-	rtwsta_link->mac_id = macid;
+	rtw89_init_sta(rtwdev, rtwvif, rtwsta, macid);
 
 	for (i = 0; i < ARRAY_SIZE(sta->txq); i++)
 		rtw89_core_txq_init(rtwdev, sta->txq[i]);
 
-	skb_queue_head_init(&rtwsta_link->roc_queue);
+	skb_queue_head_init(&rtwsta->roc_queue);
+
+	rtwsta_link = rtw89_sta_set_link(rtwsta, sta->deflink.link_id);
+	if (!rtwsta_link) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	rtwvif_link = rtwsta_link->rtwvif_link;
 
 	ret = rtw89_core_sta_link_add(rtwdev, rtwvif_link, rtwsta_link);
 	if (ret)
-		goto err;
+		goto unset_link;
 
 	if (vif->type == NL80211_IFTYPE_AP || sta->tdls)
 		rtw89_queue_chanctx_change(rtwdev, RTW89_CHANCTX_REMOTE_STA_CHANGE);
 
 	return 0;
 
+unset_link:
+	rtw89_sta_unset_link(rtwsta, sta->deflink.link_id);
 err:
 	if (acquire_macid)
 		rtw89_release_mac_id(rtwdev, macid);
@@ -508,20 +539,27 @@ static int __rtw89_ops_sta_assoc(struct rtw89_dev *rtwdev,
 				 struct ieee80211_sta *sta,
 				 bool station_mode)
 {
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
-	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
+	struct rtw89_vif *rtwvif = vif_to_rtwvif(vif);
+	struct rtw89_sta *rtwsta = sta_to_rtwsta(sta);
+	struct rtw89_vif_link *rtwvif_link;
+	struct rtw89_sta_link *rtwsta_link;
+	unsigned int link_id;
 	int ret;
 
-	if (station_mode)
-		rtw89_vif_type_mapping(rtwvif_link, true);
+	rtw89_sta_for_each_link(rtwsta, rtwsta_link, link_id) {
+		rtwvif_link = rtwsta_link->rtwvif_link;
 
-	ret = rtw89_core_sta_link_assoc(rtwdev, rtwvif_link, rtwsta_link);
-	if (ret)
-		return ret;
+		if (station_mode)
+			rtw89_vif_type_mapping(rtwvif_link, true);
+
+		ret = rtw89_core_sta_link_assoc(rtwdev, rtwvif_link, rtwsta_link);
+		if (ret)
+			return ret;
+	}
 
 	rtwdev->total_sta_assoc++;
 	if (sta->tdls)
-		rtwvif_link->tdls_peer++;
+		rtwvif->tdls_peer++;
 
 	return 0;
 }
@@ -530,19 +568,25 @@ static int __rtw89_ops_sta_disassoc(struct rtw89_dev *rtwdev,
 				    struct ieee80211_vif *vif,
 				    struct ieee80211_sta *sta)
 {
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
-	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
+	struct rtw89_vif *rtwvif = vif_to_rtwvif(vif);
+	struct rtw89_sta *rtwsta = sta_to_rtwsta(sta);
+	struct rtw89_vif_link *rtwvif_link;
+	struct rtw89_sta_link *rtwsta_link;
+	unsigned int link_id;
 	int ret;
 
-	ret = rtw89_core_sta_link_disassoc(rtwdev, rtwvif_link, rtwsta_link);
-	if (ret)
-		return ret;
+	rtw89_sta_for_each_link(rtwsta, rtwsta_link, link_id) {
+		rtwvif_link = rtwsta_link->rtwvif_link;
+		ret = rtw89_core_sta_link_disassoc(rtwdev, rtwvif_link, rtwsta_link);
+		if (ret)
+			return ret;
+	}
 
-	rtwsta_link->disassoc = true;
+	rtwsta->disassoc = true;
 
 	rtwdev->total_sta_assoc--;
 	if (sta->tdls)
-		rtwvif_link->tdls_peer--;
+		rtwvif->tdls_peer--;
 
 	return 0;
 }
@@ -551,17 +595,22 @@ static int __rtw89_ops_sta_disconnect(struct rtw89_dev *rtwdev,
 				      struct ieee80211_vif *vif,
 				      struct ieee80211_sta *sta)
 {
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
-	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
+	struct rtw89_sta *rtwsta = sta_to_rtwsta(sta);
+	struct rtw89_vif_link *rtwvif_link;
+	struct rtw89_sta_link *rtwsta_link;
+	unsigned int link_id;
 	int ret;
 
 	rtw89_core_free_sta_pending_ba(rtwdev, sta);
 	rtw89_core_free_sta_pending_forbid_ba(rtwdev, sta);
 	rtw89_core_free_sta_pending_roc_tx(rtwdev, sta);
 
-	ret = rtw89_core_sta_link_disconnect(rtwdev, rtwvif_link, rtwsta_link);
-	if (ret)
-		return ret;
+	rtw89_sta_for_each_link(rtwsta, rtwsta_link, link_id) {
+		rtwvif_link = rtwsta_link->rtwvif_link;
+		ret = rtw89_core_sta_link_disconnect(rtwdev, rtwvif_link, rtwsta_link);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
@@ -570,14 +619,21 @@ static int __rtw89_ops_sta_remove(struct rtw89_dev *rtwdev,
 				  struct ieee80211_vif *vif,
 				  struct ieee80211_sta *sta)
 {
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
-	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
-	u8 macid = rtwsta_link->mac_id;
+	struct rtw89_sta *rtwsta = sta_to_rtwsta(sta);
+	u8 macid = rtw89_sta_get_main_macid(rtwsta);
+	struct rtw89_vif_link *rtwvif_link;
+	struct rtw89_sta_link *rtwsta_link;
+	unsigned int link_id;
 	int ret;
 
-	ret = rtw89_core_sta_link_remove(rtwdev, rtwvif_link, rtwsta_link);
-	if (ret)
-		return ret;
+	rtw89_sta_for_each_link(rtwsta, rtwsta_link, link_id) {
+		rtwvif_link = rtwsta_link->rtwvif_link;
+		ret = rtw89_core_sta_link_remove(rtwdev, rtwvif_link, rtwsta_link);
+		if (ret)
+			return ret;
+
+		rtw89_sta_unset_link(rtwsta, link_id);
+	}
 
 	if (vif->type == NL80211_IFTYPE_AP || sta->tdls) {
 		rtw89_release_mac_id(rtwdev, macid);
@@ -613,11 +669,22 @@ static void __rtw89_ops_bss_link_assoc(struct rtw89_dev *rtwdev,
 	rtw89_mac_set_he_obss_narrow_bw_ru(rtwdev, rtwvif_link);
 }
 
+static void __rtw89_ops_bss_assoc(struct rtw89_dev *rtwdev,
+				  struct ieee80211_vif *vif)
+{
+	struct rtw89_vif *rtwvif = vif_to_rtwvif(vif);
+	struct rtw89_vif_link *rtwvif_link;
+	unsigned int link_id;
+
+	rtw89_vif_for_each_link(rtwvif, rtwvif_link, link_id)
+		__rtw89_ops_bss_link_assoc(rtwdev, rtwvif_link);
+}
+
 static void rtw89_ops_vif_cfg_changed(struct ieee80211_hw *hw,
 				      struct ieee80211_vif *vif, u64 changed)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
+	struct rtw89_vif *rtwvif = vif_to_rtwvif(vif);
 
 	mutex_lock(&rtwdev->mutex);
 	rtw89_leave_ps_mode(rtwdev);
@@ -625,7 +692,7 @@ static void rtw89_ops_vif_cfg_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_ASSOC) {
 		if (vif->cfg.assoc) {
 			rtw89_station_mode_sta_assoc(rtwdev, vif);
-			__rtw89_ops_bss_link_assoc(rtwdev, rtwvif_link);
+			__rtw89_ops_bss_assoc(rtwdev, vif);
 
 			rtw89_queue_chanctx_work(rtwdev);
 		} else {
@@ -641,7 +708,7 @@ static void rtw89_ops_vif_cfg_changed(struct ieee80211_hw *hw,
 		rtw89_recalc_lps(rtwdev);
 
 	if (changed & BSS_CHANGED_ARP_FILTER)
-		rtwvif_link->ip_addr = vif->cfg.arp_addr_list[0];
+		rtwvif->ip_addr = vif->cfg.arp_addr_list[0];
 
 	mutex_unlock(&rtwdev->mutex);
 }
@@ -652,11 +719,20 @@ static void rtw89_ops_link_info_changed(struct ieee80211_hw *hw,
 					u64 changed)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
+	struct rtw89_vif *rtwvif = vif_to_rtwvif(vif);
+	struct rtw89_vif_link *rtwvif_link;
 
 	mutex_lock(&rtwdev->mutex);
 	rtw89_leave_ps_mode(rtwdev);
 
+	rtwvif_link = rtwvif->links[conf->link_id];
+	if (unlikely(!rtwvif_link)) {
+		rtw89_err(rtwdev,
+			  "%s: rtwvif link (link_id %u) is not active\n",
+			  __func__, conf->link_id);
+		goto out;
+	}
+
 	if (changed & BSS_CHANGED_BSSID) {
 		ether_addr_copy(rtwvif_link->bssid, conf->bssid);
 		rtw89_cam_bssid_changed(rtwdev, rtwvif_link);
@@ -685,6 +761,7 @@ static void rtw89_ops_link_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_TPE)
 		rtw89_reg_6ghz_recalc(rtwdev, rtwvif_link, true);
 
+out:
 	mutex_unlock(&rtwdev->mutex);
 }
 
@@ -693,11 +770,20 @@ static int rtw89_ops_start_ap(struct ieee80211_hw *hw,
 			      struct ieee80211_bss_conf *link_conf)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
+	struct rtw89_vif *rtwvif = vif_to_rtwvif(vif);
+	struct rtw89_vif_link *rtwvif_link;
 	const struct rtw89_chan *chan;
 
 	mutex_lock(&rtwdev->mutex);
 
+	rtwvif_link = rtwvif->links[link_conf->link_id];
+	if (unlikely(!rtwvif_link)) {
+		rtw89_err(rtwdev,
+			  "%s: rtwvif link (link_id %u) is not active\n",
+			  __func__, link_conf->link_id);
+		goto out;
+	}
+
 	chan = rtw89_chan_get(rtwdev, rtwvif_link->chanctx_idx);
 	if (chan->band_type == RTW89_BAND_6G) {
 		mutex_unlock(&rtwdev->mutex);
@@ -717,6 +803,8 @@ static int rtw89_ops_start_ap(struct ieee80211_hw *hw,
 	rtw89_chip_rfk_channel(rtwdev, rtwvif_link);
 
 	rtw89_queue_chanctx_work(rtwdev);
+
+out:
 	mutex_unlock(&rtwdev->mutex);
 
 	return 0;
@@ -727,12 +815,24 @@ void rtw89_ops_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		       struct ieee80211_bss_conf *link_conf)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
+	struct rtw89_vif *rtwvif = vif_to_rtwvif(vif);
+	struct rtw89_vif_link *rtwvif_link;
 
 	mutex_lock(&rtwdev->mutex);
+
+	rtwvif_link = rtwvif->links[link_conf->link_id];
+	if (unlikely(!rtwvif_link)) {
+		rtw89_err(rtwdev,
+			  "%s: rtwvif link (link_id %u) is not active\n",
+			  __func__, link_conf->link_id);
+		goto out;
+	}
+
 	rtw89_mac_stop_ap(rtwdev, rtwvif_link);
 	rtw89_chip_h2c_assoc_cmac_tbl(rtwdev, rtwvif_link, NULL);
 	rtw89_fw_h2c_join_info(rtwdev, rtwvif_link, NULL, true);
+
+out:
 	mutex_unlock(&rtwdev->mutex);
 }
 
@@ -740,10 +840,13 @@ static int rtw89_ops_set_tim(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
 			     bool set)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
-	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
-	struct rtw89_vif_link *rtwvif_link = rtwsta_link->rtwvif_link;
+	struct rtw89_sta *rtwsta = sta_to_rtwsta(sta);
+	struct rtw89_vif *rtwvif = rtwsta->rtwvif;
+	struct rtw89_vif_link *rtwvif_link;
+	unsigned int link_id;
 
-	ieee80211_queue_work(rtwdev->hw, &rtwvif_link->update_beacon_work);
+	rtw89_vif_for_each_link(rtwvif, rtwvif_link, link_id)
+		ieee80211_queue_work(rtwdev->hw, &rtwvif_link->update_beacon_work);
 
 	return 0;
 }
@@ -754,15 +857,29 @@ static int rtw89_ops_conf_tx(struct ieee80211_hw *hw,
 			     const struct ieee80211_tx_queue_params *params)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
+	struct rtw89_vif *rtwvif = vif_to_rtwvif(vif);
+	struct rtw89_vif_link *rtwvif_link;
+	int ret = 0;
 
 	mutex_lock(&rtwdev->mutex);
 	rtw89_leave_ps_mode(rtwdev);
+
+	rtwvif_link = rtwvif->links[link_id];
+	if (unlikely(!rtwvif_link)) {
+		rtw89_err(rtwdev,
+			  "%s: rtwvif link (link_id %u) is not active\n",
+			  __func__, link_id);
+		ret = -ENOLINK;
+		goto out;
+	}
+
 	rtwvif_link->tx_params[ac] = *params;
 	__rtw89_conf_tx(rtwdev, rtwvif_link, ac);
+
+out:
 	mutex_unlock(&rtwdev->mutex);
 
-	return 0;
+	return ret;
 }
 
 static int __rtw89_ops_sta_state(struct ieee80211_hw *hw,
@@ -860,7 +977,8 @@ static int rtw89_ops_ampdu_action(struct ieee80211_hw *hw,
 {
 	struct rtw89_dev *rtwdev = hw->priv;
 	struct ieee80211_sta *sta = params->sta;
-	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
+	struct rtw89_sta *rtwsta = sta_to_rtwsta(sta);
+	struct rtw89_vif *rtwvif = vif_to_rtwvif(vif);
 	u16 tid = params->tid;
 	struct ieee80211_txq *txq = sta->txq[tid];
 	struct rtw89_txq *rtwtxq = (struct rtw89_txq *)txq->drv_priv;
@@ -873,29 +991,29 @@ static int rtw89_ops_ampdu_action(struct ieee80211_hw *hw,
 	case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
 		mutex_lock(&rtwdev->mutex);
 		clear_bit(RTW89_TXQ_F_AMPDU, &rtwtxq->flags);
-		clear_bit(tid, rtwsta_link->ampdu_map);
-		rtw89_chip_h2c_ampdu_cmac_tbl(rtwdev, vif, sta);
+		clear_bit(tid, rtwsta->ampdu_map);
+		rtw89_chip_h2c_ampdu_cmac_tbl(rtwdev, rtwvif, rtwsta);
 		mutex_unlock(&rtwdev->mutex);
 		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
 		break;
 	case IEEE80211_AMPDU_TX_OPERATIONAL:
 		mutex_lock(&rtwdev->mutex);
 		set_bit(RTW89_TXQ_F_AMPDU, &rtwtxq->flags);
-		rtwsta_link->ampdu_params[tid].agg_num = params->buf_size;
-		rtwsta_link->ampdu_params[tid].amsdu = params->amsdu;
-		set_bit(tid, rtwsta_link->ampdu_map);
+		rtwsta->ampdu_params[tid].agg_num = params->buf_size;
+		rtwsta->ampdu_params[tid].amsdu = params->amsdu;
+		set_bit(tid, rtwsta->ampdu_map);
 		rtw89_leave_ps_mode(rtwdev);
-		rtw89_chip_h2c_ampdu_cmac_tbl(rtwdev, vif, sta);
+		rtw89_chip_h2c_ampdu_cmac_tbl(rtwdev, rtwvif, rtwsta);
 		mutex_unlock(&rtwdev->mutex);
 		break;
 	case IEEE80211_AMPDU_RX_START:
 		mutex_lock(&rtwdev->mutex);
-		rtw89_chip_h2c_ba_cam(rtwdev, rtwsta_link, true, params);
+		rtw89_chip_h2c_ba_cam(rtwdev, rtwsta, true, params);
 		mutex_unlock(&rtwdev->mutex);
 		break;
 	case IEEE80211_AMPDU_RX_STOP:
 		mutex_lock(&rtwdev->mutex);
-		rtw89_chip_h2c_ba_cam(rtwdev, rtwsta_link, false, params);
+		rtw89_chip_h2c_ba_cam(rtwdev, rtwsta, false, params);
 		mutex_unlock(&rtwdev->mutex);
 		break;
 	default:
@@ -924,7 +1042,12 @@ static void rtw89_ops_sta_statistics(struct ieee80211_hw *hw,
 				     struct ieee80211_sta *sta,
 				     struct station_info *sinfo)
 {
-	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
+	struct rtw89_sta *rtwsta = sta_to_rtwsta(sta);
+	struct rtw89_sta_link *rtwsta_link;
+
+	rtwsta_link = rtw89_sta_get_link_inst(rtwsta, 0);
+	if (unlikely(!rtwsta_link))
+		return;
 
 	sinfo->txrate = rtwsta_link->ra_report.txrate;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
@@ -933,14 +1056,14 @@ static void rtw89_ops_sta_statistics(struct ieee80211_hw *hw,
 static
 void __rtw89_drop_packets(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif)
 {
-	struct rtw89_vif_link *rtwvif_link;
+	struct rtw89_vif *rtwvif;
 
 	if (vif) {
-		rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
-		rtw89_mac_pkt_drop_vif(rtwdev, rtwvif_link);
+		rtwvif = vif_to_rtwvif(vif);
+		rtw89_mac_pkt_drop_vif(rtwdev, rtwvif);
 	} else {
-		rtw89_for_each_rtwvif(rtwdev, rtwvif_link)
-			rtw89_mac_pkt_drop_vif(rtwdev, rtwvif_link);
+		rtw89_for_each_rtwvif(rtwdev, rtwvif)
+			rtw89_mac_pkt_drop_vif(rtwdev, rtwvif);
 	}
 }
 
@@ -970,14 +1093,20 @@ struct rtw89_iter_bitrate_mask_data {
 static void rtw89_ra_mask_info_update_iter(void *data, struct ieee80211_sta *sta)
 {
 	struct rtw89_iter_bitrate_mask_data *br_data = data;
-	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwsta_link->rtwvif_link);
+	struct rtw89_sta *rtwsta = sta_to_rtwsta(sta);
+	struct rtw89_vif *rtwvif = rtwsta->rtwvif;
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+	struct rtw89_sta_link *rtwsta_link;
+	unsigned int link_id;
 
 	if (vif != br_data->vif || vif->p2p)
 		return;
 
-	rtwsta_link->use_cfg_mask = true;
-	rtwsta_link->mask = *br_data->mask;
+	rtw89_sta_for_each_link(rtwsta, rtwsta_link, link_id) {
+		rtwsta_link->use_cfg_mask = true;
+		rtwsta_link->mask = *br_data->mask;
+	}
+
 	rtw89_phy_ra_update_sta(br_data->rtwdev, sta, IEEE80211_RC_SUPP_RATES_CHANGED);
 }
 
@@ -1047,10 +1176,20 @@ static void rtw89_ops_sw_scan_start(struct ieee80211_hw *hw,
 				    const u8 *mac_addr)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
+	struct rtw89_vif *rtwvif = vif_to_rtwvif(vif);
+	struct rtw89_vif_link *rtwvif_link;
 
 	mutex_lock(&rtwdev->mutex);
+
+	rtwvif_link = rtw89_vif_get_link_inst(rtwvif, 0);
+	if (unlikely(!rtwvif_link)) {
+		rtw89_err(rtwdev, "sw scan start: find no link on HW-0\n");
+		goto out;
+	}
+
 	rtw89_core_scan_start(rtwdev, rtwvif_link, mac_addr, false);
+
+out:
 	mutex_unlock(&rtwdev->mutex);
 }
 
@@ -1058,9 +1197,20 @@ static void rtw89_ops_sw_scan_complete(struct ieee80211_hw *hw,
 				       struct ieee80211_vif *vif)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
+	struct rtw89_vif *rtwvif = vif_to_rtwvif(vif);
+	struct rtw89_vif_link *rtwvif_link;
 
 	mutex_lock(&rtwdev->mutex);
-	rtw89_core_scan_complete(rtwdev, vif, false);
+
+	rtwvif_link = rtw89_vif_get_link_inst(rtwvif, 0);
+	if (unlikely(!rtwvif_link)) {
+		rtw89_err(rtwdev, "sw scan complete: find no link on HW-0\n");
+		goto out;
+	}
+
+	rtw89_core_scan_complete(rtwdev, rtwvif_link, false);
+
+out:
 	mutex_unlock(&rtwdev->mutex);
 }
 
@@ -1077,22 +1227,35 @@ static int rtw89_ops_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			     struct ieee80211_scan_request *req)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
-	struct rtw89_vif_link *rtwvif_link = vif_to_rtwvif_safe(vif);
-	int ret = 0;
+	struct rtw89_vif *rtwvif = vif_to_rtwvif(vif);
+	struct rtw89_vif_link *rtwvif_link;
+	int ret;
 
 	if (!RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD, &rtwdev->fw))
 		return 1;
 
-	if (rtwdev->scanning || rtwvif_link->offchan)
-		return -EBUSY;
-
 	mutex_lock(&rtwdev->mutex);
-	rtw89_hw_scan_start(rtwdev, vif, req);
-	ret = rtw89_hw_scan_offload(rtwdev, vif, true);
+
+	if (rtwdev->scanning || rtwvif->offchan) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	rtwvif_link = rtw89_vif_get_link_inst(rtwvif, 0);
+	if (unlikely(!rtwvif_link)) {
+		rtw89_err(rtwdev, "hw scan: find no link on HW-0\n");
+		ret = -ENOLINK;
+		goto out;
+	}
+
+	rtw89_hw_scan_start(rtwdev, rtwvif_link, req);
+	ret = rtw89_hw_scan_offload(rtwdev, rtwvif_link, true);
 	if (ret) {
-		rtw89_hw_scan_abort(rtwdev, vif);
+		rtw89_hw_scan_abort(rtwdev, rtwvif_link);
 		rtw89_err(rtwdev, "HW scan failed with status: %d\n", ret);
 	}
+
+out:
 	mutex_unlock(&rtwdev->mutex);
 
 	return ret;
@@ -1102,6 +1265,8 @@ static void rtw89_ops_cancel_hw_scan(struct ieee80211_hw *hw,
 				     struct ieee80211_vif *vif)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
+	struct rtw89_vif *rtwvif = vif_to_rtwvif(vif);
+	struct rtw89_vif_link *rtwvif_link;
 
 	if (!RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD, &rtwdev->fw))
 		return;
@@ -1110,7 +1275,16 @@ static void rtw89_ops_cancel_hw_scan(struct ieee80211_hw *hw,
 		return;
 
 	mutex_lock(&rtwdev->mutex);
-	rtw89_hw_scan_abort(rtwdev, vif);
+
+	rtwvif_link = rtw89_vif_get_link_inst(rtwvif, 0);
+	if (unlikely(!rtwvif_link)) {
+		rtw89_err(rtwdev, "cancel hw scan: find no link on HW-0\n");
+		goto out;
+	}
+
+	rtw89_hw_scan_abort(rtwdev, rtwvif_link);
+
+out:
 	mutex_unlock(&rtwdev->mutex);
 }
 
@@ -1163,11 +1337,24 @@ static int rtw89_ops_assign_vif_chanctx(struct ieee80211_hw *hw,
 					struct ieee80211_chanctx_conf *ctx)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
+	struct rtw89_vif *rtwvif = vif_to_rtwvif(vif);
+	struct rtw89_vif_link *rtwvif_link;
 	int ret;
 
 	mutex_lock(&rtwdev->mutex);
+
+	rtwvif_link = rtwvif->links[link_conf->link_id];
+	if (unlikely(!rtwvif_link)) {
+		rtw89_err(rtwdev,
+			  "%s: rtwvif link (link_id %u) is not active\n",
+			  __func__, link_conf->link_id);
+		ret = -ENOLINK;
+		goto out;
+	}
+
 	ret = rtw89_chanctx_ops_assign_vif(rtwdev, rtwvif_link, ctx);
+
+out:
 	mutex_unlock(&rtwdev->mutex);
 
 	return ret;
@@ -1179,9 +1366,19 @@ static void rtw89_ops_unassign_vif_chanctx(struct ieee80211_hw *hw,
 					   struct ieee80211_chanctx_conf *ctx)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
+	struct rtw89_vif *rtwvif = vif_to_rtwvif(vif);
+	struct rtw89_vif_link *rtwvif_link;
 
 	mutex_lock(&rtwdev->mutex);
+
+	rtwvif_link = rtwvif->links[link_conf->link_id];
+	if (unlikely(!rtwvif_link)) {
+		rtw89_err(rtwdev,
+			  "%s: rtwvif link (link_id %u) is not active\n",
+			  __func__, link_conf->link_id);
+		return;
+	}
+
 	rtw89_chanctx_ops_unassign_vif(rtwdev, rtwvif_link, ctx);
 	mutex_unlock(&rtwdev->mutex);
 }
@@ -1193,10 +1390,10 @@ static int rtw89_ops_remain_on_channel(struct ieee80211_hw *hw,
 				       enum ieee80211_roc_type type)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
-	struct rtw89_vif_link *rtwvif_link = vif_to_rtwvif_safe(vif);
-	struct rtw89_roc *roc = &rtwvif_link->roc;
+	struct rtw89_vif *rtwvif = vif_to_rtwvif_safe(vif);
+	struct rtw89_roc *roc = &rtwvif->roc;
 
-	if (!vif)
+	if (!rtwvif)
 		return -EINVAL;
 
 	mutex_lock(&rtwdev->mutex);
@@ -1218,7 +1415,7 @@ static int rtw89_ops_remain_on_channel(struct ieee80211_hw *hw,
 	roc->chan = *chan;
 	roc->type = type;
 
-	rtw89_roc_start(rtwdev, rtwvif_link);
+	rtw89_roc_start(rtwdev, rtwvif);
 
 	mutex_unlock(&rtwdev->mutex);
 
@@ -1229,15 +1426,15 @@ static int rtw89_ops_cancel_remain_on_channel(struct ieee80211_hw *hw,
 					      struct ieee80211_vif *vif)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
-	struct rtw89_vif_link *rtwvif_link = vif_to_rtwvif_safe(vif);
+	struct rtw89_vif *rtwvif = vif_to_rtwvif_safe(vif);
 
-	if (!rtwvif_link)
+	if (!rtwvif)
 		return -EINVAL;
 
-	cancel_delayed_work_sync(&rtwvif_link->roc.roc_work);
+	cancel_delayed_work_sync(&rtwvif->roc.roc_work);
 
 	mutex_lock(&rtwdev->mutex);
-	rtw89_roc_end(rtwdev, rtwvif_link);
+	rtw89_roc_end(rtwdev, rtwvif);
 	mutex_unlock(&rtwdev->mutex);
 
 	return 0;
@@ -1246,8 +1443,8 @@ static int rtw89_ops_cancel_remain_on_channel(struct ieee80211_hw *hw,
 static void rtw89_set_tid_config_iter(void *data, struct ieee80211_sta *sta)
 {
 	struct cfg80211_tid_config *tid_config = data;
-	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
-	struct rtw89_dev *rtwdev = rtwsta_link->rtwvif_link->rtwdev;
+	struct rtw89_sta *rtwsta = sta_to_rtwsta(sta);
+	struct rtw89_dev *rtwdev = rtwsta->rtwdev;
 
 	rtw89_core_set_tid_config(rtwdev, sta, tid_config);
 }
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index da9491213b7b..4b47b45f897c 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -466,12 +466,12 @@ static void rtw89_phy_ra_sta_update(struct rtw89_dev *rtwdev,
 	ra->csi_mode = csi_mode;
 }
 
-void rtw89_phy_ra_update_sta(struct rtw89_dev *rtwdev, struct ieee80211_sta *sta,
-			     u32 changed)
+static void __rtw89_phy_ra_update_sta(struct rtw89_dev *rtwdev,
+				      struct rtw89_vif_link *rtwvif_link,
+				      struct rtw89_sta_link *rtwsta_link,
+				      u32 changed)
 {
-	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
-	struct rtw89_vif_link *rtwvif_link = rtwsta_link->rtwvif_link;
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
+	struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
 	struct rtw89_ra_info *ra = &rtwsta_link->ra;
 	struct ieee80211_link_sta *link_sta;
 
@@ -499,6 +499,20 @@ void rtw89_phy_ra_update_sta(struct rtw89_dev *rtwdev, struct ieee80211_sta *sta
 	rtw89_fw_h2c_ra(rtwdev, ra, false);
 }
 
+void rtw89_phy_ra_update_sta(struct rtw89_dev *rtwdev, struct ieee80211_sta *sta,
+			     u32 changed)
+{
+	struct rtw89_sta *rtwsta = sta_to_rtwsta(sta);
+	struct rtw89_vif_link *rtwvif_link;
+	struct rtw89_sta_link *rtwsta_link;
+	unsigned int link_id;
+
+	rtw89_sta_for_each_link(rtwsta, rtwsta_link, link_id) {
+		rtwvif_link = rtwsta_link->rtwvif_link;
+		__rtw89_phy_ra_update_sta(rtwdev, rtwvif_link, rtwsta_link, changed);
+	}
+}
+
 static bool __check_rate_pattern(struct rtw89_phy_rate_pattern *next,
 				 u16 rate_base, u64 ra_mask, u8 ra_mode,
 				 u32 rate_ctrl, u32 ctrl_skip, bool force)
@@ -533,12 +547,12 @@ static bool __check_rate_pattern(struct rtw89_phy_rate_pattern *next,
 		[RTW89_CHIP_BE] = RTW89_HW_RATE_V1_ ## rate, \
 	}
 
-void rtw89_phy_rate_pattern_vif(struct rtw89_dev *rtwdev,
-				struct ieee80211_vif *vif,
-				const struct cfg80211_bitrate_mask *mask)
+static
+void __rtw89_phy_rate_pattern_vif(struct rtw89_dev *rtwdev,
+				  struct rtw89_vif_link *rtwvif_link,
+				  const struct cfg80211_bitrate_mask *mask)
 {
 	struct ieee80211_supported_band *sband;
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 	struct rtw89_phy_rate_pattern next_pattern = {0};
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
 						       rtwvif_link->chanctx_idx);
@@ -623,6 +637,18 @@ void rtw89_phy_rate_pattern_vif(struct rtw89_dev *rtwdev,
 	rtw89_debug(rtwdev, RTW89_DBG_RA, "unset rate pattern\n");
 }
 
+void rtw89_phy_rate_pattern_vif(struct rtw89_dev *rtwdev,
+				struct ieee80211_vif *vif,
+				const struct cfg80211_bitrate_mask *mask)
+{
+	struct rtw89_vif *rtwvif = vif_to_rtwvif(vif);
+	struct rtw89_vif_link *rtwvif_link;
+	unsigned int link_id;
+
+	rtw89_vif_for_each_link(rtwvif, rtwvif_link, link_id)
+		__rtw89_phy_rate_pattern_vif(rtwdev, rtwvif_link, mask);
+}
+
 static void rtw89_phy_ra_update_sta_iter(void *data, struct ieee80211_sta *sta)
 {
 	struct rtw89_dev *rtwdev = (struct rtw89_dev *)data;
@@ -640,7 +666,7 @@ void rtw89_phy_ra_update(struct rtw89_dev *rtwdev)
 void rtw89_phy_ra_assoc(struct rtw89_dev *rtwdev, struct rtw89_sta_link *rtwsta_link)
 {
 	struct rtw89_vif_link *rtwvif_link = rtwsta_link->rtwvif_link;
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
+	struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
 	struct rtw89_ra_info *ra = &rtwsta_link->ra;
 	u8 rssi = ewma_rssi_read(&rtwsta_link->avg_rssi) >> RSSI_FACTOR;
 	struct ieee80211_link_sta *link_sta;
@@ -2688,13 +2714,17 @@ static void __rtw89_phy_c2h_ra_rpt_iter(struct rtw89_sta_link *rtwsta_link,
 static void rtw89_phy_c2h_ra_rpt_iter(void *data, struct ieee80211_sta *sta)
 {
 	struct rtw89_phy_iter_ra_data *ra_data = (struct rtw89_phy_iter_ra_data *)data;
-	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
+	struct rtw89_sta *rtwsta = sta_to_rtwsta(sta);
+	struct rtw89_sta_link *rtwsta_link;
 	struct ieee80211_link_sta *link_sta;
+	unsigned int link_id;
 
 	rcu_read_lock();
 
-	link_sta = rtw89_sta_rcu_dereference_link(rtwsta_link, false);
-	__rtw89_phy_c2h_ra_rpt_iter(rtwsta_link, link_sta, ra_data);
+	rtw89_sta_for_each_link(rtwsta, rtwsta_link, link_id) {
+		link_sta = rtw89_sta_rcu_dereference_link(rtwsta_link, false);
+		__rtw89_phy_c2h_ra_rpt_iter(rtwsta_link, link_sta, ra_data);
+	}
 
 	rcu_read_unlock();
 }
@@ -4422,7 +4452,7 @@ void rtw89_phy_ul_tb_ctrl_check(struct rtw89_dev *rtwdev,
 				struct rtw89_phy_ul_tb_check_data *ul_tb_data)
 {
 	struct rtw89_traffic_stats *stats = &rtwdev->stats;
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
+	struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
 
 	if (rtwvif_link->wifi_role != RTW89_WIFI_ROLE_STATION)
 		return;
@@ -4488,6 +4518,8 @@ void rtw89_phy_ul_tb_ctrl_track(struct rtw89_dev *rtwdev)
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_phy_ul_tb_check_data ul_tb_data = {};
 	struct rtw89_vif_link *rtwvif_link;
+	struct rtw89_vif *rtwvif;
+	unsigned int link_id;
 
 	if (!chip->ul_tb_waveform_ctrl && !chip->ul_tb_pwr_diff)
 		return;
@@ -4495,8 +4527,9 @@ void rtw89_phy_ul_tb_ctrl_track(struct rtw89_dev *rtwdev)
 	if (rtwdev->total_sta_assoc != 1)
 		return;
 
-	rtw89_for_each_rtwvif(rtwdev, rtwvif_link)
-		rtw89_phy_ul_tb_ctrl_check(rtwdev, rtwvif_link, &ul_tb_data);
+	rtw89_for_each_rtwvif(rtwdev, rtwvif)
+		rtw89_vif_for_each_link(rtwvif, rtwvif_link, link_id)
+			rtw89_phy_ul_tb_ctrl_check(rtwdev, rtwvif_link, &ul_tb_data);
 
 	if (!ul_tb_data.valid)
 		return;
@@ -4660,12 +4693,10 @@ struct rtw89_phy_iter_rssi_data {
 	bool rssi_changed;
 };
 
-static void rtw89_phy_stat_rssi_update_iter(void *data,
-					    struct ieee80211_sta *sta)
+static
+void __rtw89_phy_stat_rssi_update_iter(struct rtw89_sta_link *rtwsta_link,
+				       struct rtw89_phy_iter_rssi_data *rssi_data)
 {
-	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
-	struct rtw89_phy_iter_rssi_data *rssi_data =
-					(struct rtw89_phy_iter_rssi_data *)data;
 	struct rtw89_phy_ch_info *ch_info = rssi_data->ch_info;
 	unsigned long rssi_curr;
 
@@ -4685,6 +4716,19 @@ static void rtw89_phy_stat_rssi_update_iter(void *data,
 	}
 }
 
+static void rtw89_phy_stat_rssi_update_iter(void *data,
+					    struct ieee80211_sta *sta)
+{
+	struct rtw89_phy_iter_rssi_data *rssi_data =
+					(struct rtw89_phy_iter_rssi_data *)data;
+	struct rtw89_sta *rtwsta = sta_to_rtwsta(sta);
+	struct rtw89_sta_link *rtwsta_link;
+	unsigned int link_id;
+
+	rtw89_sta_for_each_link(rtwsta, rtwsta_link, link_id)
+		__rtw89_phy_stat_rssi_update_iter(rtwsta_link, rssi_data);
+}
+
 static void rtw89_phy_stat_rssi_update(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_phy_iter_rssi_data rssi_data = {0};
@@ -5788,24 +5832,13 @@ void rtw89_phy_dig(struct rtw89_dev *rtwdev)
 		rtw89_phy_dig_sdagc_follow_pagc_config(rtwdev, false);
 }
 
-static void rtw89_phy_tx_path_div_sta_iter(void *data, struct ieee80211_sta *sta)
+static void __rtw89_phy_tx_path_div_sta_iter(struct rtw89_dev *rtwdev,
+					     struct rtw89_sta_link *rtwsta_link)
 {
-	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
-	struct rtw89_dev *rtwdev = rtwsta_link->rtwdev;
-	struct rtw89_vif_link *rtwvif_link = rtwsta_link->rtwvif_link;
 	struct rtw89_hal *hal = &rtwdev->hal;
-	bool *done = data;
 	u8 rssi_a, rssi_b;
 	u32 candidate;
 
-	if (rtwvif_link->wifi_role != RTW89_WIFI_ROLE_STATION || sta->tdls)
-		return;
-
-	if (*done)
-		return;
-
-	*done = true;
-
 	rssi_a = ewma_rssi_read(&rtwsta_link->rssi[RF_PATH_A]);
 	rssi_b = ewma_rssi_read(&rtwsta_link->rssi[RF_PATH_B]);
 
@@ -5831,6 +5864,37 @@ static void rtw89_phy_tx_path_div_sta_iter(void *data, struct ieee80211_sta *sta
 	}
 }
 
+static void rtw89_phy_tx_path_div_sta_iter(void *data, struct ieee80211_sta *sta)
+{
+	struct rtw89_sta *rtwsta = sta_to_rtwsta(sta);
+	struct rtw89_dev *rtwdev = rtwsta->rtwdev;
+	struct rtw89_vif *rtwvif = rtwsta->rtwvif;
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+	struct rtw89_vif_link *rtwvif_link;
+	struct rtw89_sta_link *rtwsta_link;
+	unsigned int link_id;
+	bool *done = data;
+
+	if (WARN(ieee80211_vif_is_mld(vif), "MLD mix path_div\n"))
+		return;
+
+	if (sta->tdls)
+		return;
+
+	if (*done)
+		return;
+
+	rtw89_sta_for_each_link(rtwsta, rtwsta_link, link_id) {
+		rtwvif_link = rtwsta_link->rtwvif_link;
+		if (rtwvif_link->wifi_role != RTW89_WIFI_ROLE_STATION)
+			continue;
+
+		*done = true;
+		__rtw89_phy_tx_path_div_sta_iter(rtwdev, rtwsta_link);
+		return;
+	}
+}
+
 void rtw89_phy_tx_path_div_track(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
@@ -6040,7 +6104,7 @@ void rtw89_phy_dm_init(struct rtw89_dev *rtwdev)
 void rtw89_phy_set_bss_color(struct rtw89_dev *rtwdev,
 			     struct rtw89_vif_link *rtwvif_link)
 {
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
+	struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const struct rtw89_reg_def *bss_clr_vld = &chip->bss_clr_vld;
 	enum rtw89_phy_idx phy_idx = RTW89_PHY_0;
diff --git a/drivers/net/wireless/realtek/rtw89/ps.c b/drivers/net/wireless/realtek/rtw89/ps.c
index ded0b73bd678..c1c12abc2ea9 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.c
+++ b/drivers/net/wireless/realtek/rtw89/ps.c
@@ -147,6 +147,8 @@ static void rtw89_leave_lps_vif(struct rtw89_dev *rtwdev,
 void rtw89_leave_lps(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_vif_link *rtwvif_link;
+	struct rtw89_vif *rtwvif;
+	unsigned int link_id;
 
 	lockdep_assert_held(&rtwdev->mutex);
 
@@ -155,21 +157,25 @@ void rtw89_leave_lps(struct rtw89_dev *rtwdev)
 
 	__rtw89_leave_ps_mode(rtwdev);
 
-	rtw89_for_each_rtwvif(rtwdev, rtwvif_link)
-		rtw89_leave_lps_vif(rtwdev, rtwvif_link);
+	rtw89_for_each_rtwvif(rtwdev, rtwvif)
+		rtw89_vif_for_each_link(rtwvif, rtwvif_link, link_id)
+			rtw89_leave_lps_vif(rtwdev, rtwvif_link);
 }
 
 void rtw89_enter_ips(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_vif_link *rtwvif_link;
+	struct rtw89_vif *rtwvif;
+	unsigned int link_id;
 
 	set_bit(RTW89_FLAG_INACTIVE_PS, rtwdev->flags);
 
 	if (!test_bit(RTW89_FLAG_POWERON, rtwdev->flags))
 		return;
 
-	rtw89_for_each_rtwvif(rtwdev, rtwvif_link)
-		rtw89_mac_vif_deinit(rtwdev, rtwvif_link);
+	rtw89_for_each_rtwvif(rtwdev, rtwvif)
+		rtw89_vif_for_each_link(rtwvif, rtwvif_link, link_id)
+			rtw89_mac_vif_deinit(rtwdev, rtwvif_link);
 
 	rtw89_core_stop(rtwdev);
 }
@@ -177,6 +183,8 @@ void rtw89_enter_ips(struct rtw89_dev *rtwdev)
 void rtw89_leave_ips(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_vif_link *rtwvif_link;
+	struct rtw89_vif *rtwvif;
+	unsigned int link_id;
 	int ret;
 
 	if (test_bit(RTW89_FLAG_POWERON, rtwdev->flags))
@@ -188,8 +196,9 @@ void rtw89_leave_ips(struct rtw89_dev *rtwdev)
 
 	rtw89_set_channel(rtwdev);
 
-	rtw89_for_each_rtwvif(rtwdev, rtwvif_link)
-		rtw89_mac_vif_init(rtwdev, rtwvif_link);
+	rtw89_for_each_rtwvif(rtwdev, rtwvif)
+		rtw89_vif_for_each_link(rtwvif, rtwvif_link, link_id)
+			rtw89_mac_vif_init(rtwdev, rtwvif_link);
 
 	clear_bit(RTW89_FLAG_INACTIVE_PS, rtwdev->flags);
 }
@@ -269,16 +278,22 @@ void rtw89_process_p2p_ps(struct rtw89_dev *rtwdev,
 void rtw89_recalc_lps(struct rtw89_dev *rtwdev)
 {
 	struct ieee80211_vif *vif, *found_vif = NULL;
-	struct rtw89_vif_link *rtwvif_link;
+	struct rtw89_vif *rtwvif;
 	enum rtw89_entity_mode mode;
 	int count = 0;
 
+	/* FIXME: Fix rtw89_enter_lps() and __rtw89_enter_ps_mode()
+	 * to take MLO cases into account before doing the following.
+	 */
+	if (rtwdev->support_mlo)
+		goto disable_lps;
+
 	mode = rtw89_get_entity_mode(rtwdev);
 	if (mode == RTW89_ENTITY_MODE_MCC)
 		goto disable_lps;
 
-	rtw89_for_each_rtwvif(rtwdev, rtwvif_link) {
-		vif = rtwvif_to_vif(rtwvif_link);
+	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
+		vif = rtwvif_to_vif(rtwvif);
 
 		if (vif->type != NL80211_IFTYPE_STATION) {
 			count = 0;
diff --git a/drivers/net/wireless/realtek/rtw89/regd.c b/drivers/net/wireless/realtek/rtw89/regd.c
index aa5ae0244372..bb064a086970 100644
--- a/drivers/net/wireless/realtek/rtw89/regd.c
+++ b/drivers/net/wireless/realtek/rtw89/regd.c
@@ -794,21 +794,25 @@ static bool __rtw89_reg_6ghz_tpe_recalc(struct rtw89_dev *rtwdev)
 	struct rtw89_regulatory_info *regulatory = &rtwdev->regulatory;
 	struct rtw89_reg_6ghz_tpe new = {};
 	struct rtw89_vif_link *rtwvif_link;
+	struct rtw89_vif *rtwvif;
+	unsigned int link_id;
 	bool changed = false;
 
-	rtw89_for_each_rtwvif(rtwdev, rtwvif_link) {
+	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
 		const struct rtw89_reg_6ghz_tpe *tmp;
 		const struct rtw89_chan *chan;
 
-		chan = rtw89_chan_get(rtwdev, rtwvif_link->chanctx_idx);
-		if (chan->band_type != RTW89_BAND_6G)
-			continue;
+		rtw89_vif_for_each_link(rtwvif, rtwvif_link, link_id) {
+			chan = rtw89_chan_get(rtwdev, rtwvif_link->chanctx_idx);
+			if (chan->band_type != RTW89_BAND_6G)
+				continue;
 
-		tmp = &rtwvif_link->reg_6ghz_tpe;
-		if (!tmp->valid)
-			continue;
+			tmp = &rtwvif_link->reg_6ghz_tpe;
+			if (!tmp->valid)
+				continue;
 
-		tpe_intersect_constraint(&new, tmp->constraint);
+			tpe_intersect_constraint(&new, tmp->constraint);
+		}
 	}
 
 	if (memcmp(&regulatory->reg_6ghz_tpe, &new,
@@ -873,19 +877,23 @@ static bool __rtw89_reg_6ghz_power_recalc(struct rtw89_dev *rtwdev)
 	enum rtw89_reg_6ghz_power sel;
 	const struct rtw89_chan *chan;
 	struct rtw89_vif_link *rtwvif_link;
+	struct rtw89_vif *rtwvif;
+	unsigned int link_id;
 	int count = 0;
 	u8 index;
 
-	rtw89_for_each_rtwvif(rtwdev, rtwvif_link) {
-		chan = rtw89_chan_get(rtwdev, rtwvif_link->chanctx_idx);
-		if (chan->band_type != RTW89_BAND_6G)
-			continue;
+	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
+		rtw89_vif_for_each_link(rtwvif, rtwvif_link, link_id) {
+			chan = rtw89_chan_get(rtwdev, rtwvif_link->chanctx_idx);
+			if (chan->band_type != RTW89_BAND_6G)
+				continue;
 
-		if (count != 0 && rtwvif_link->reg_6ghz_power == sel)
-			continue;
+			if (count != 0 && rtwvif_link->reg_6ghz_power == sel)
+				continue;
 
-		sel = rtwvif_link->reg_6ghz_power;
-		count++;
+			sel = rtwvif_link->reg_6ghz_power;
+			count++;
+		}
 	}
 
 	if (count != 1)
diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
index 50b66eaf9bd0..7b203bb7f151 100644
--- a/drivers/net/wireless/realtek/rtw89/ser.c
+++ b/drivers/net/wireless/realtek/rtw89/ser.c
@@ -298,54 +298,71 @@ static void drv_resume_rx(struct rtw89_ser *ser)
 	clear_bit(RTW89_SER_DRV_STOP_RX, ser->flags);
 }
 
-static void ser_reset_vif(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link)
+static void ser_reset_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 {
-	rtw89_core_release_bit_map(rtwdev->hw_port, rtwvif_link->port);
-	rtwvif_link->net_type = RTW89_NET_TYPE_NO_LINK;
-	rtwvif_link->trigger = false;
-	rtwvif_link->tdls_peer = 0;
+	struct rtw89_vif_link *rtwvif_link;
+	unsigned int link_id;
+
+	rtwvif->tdls_peer = 0;
+
+	rtw89_vif_for_each_link(rtwvif, rtwvif_link, link_id) {
+		rtw89_core_release_bit_map(rtwdev->hw_port, rtwvif_link->port);
+		rtwvif_link->net_type = RTW89_NET_TYPE_NO_LINK;
+		rtwvif_link->trigger = false;
+	}
 }
 
 static void ser_sta_deinit_cam_iter(void *data, struct ieee80211_sta *sta)
 {
-	struct rtw89_vif_link *target_rtwvif = (struct rtw89_vif_link *)data;
-	struct rtw89_sta_link *rtwsta_link = (struct rtw89_sta_link *)sta->drv_priv;
-	struct rtw89_vif_link *rtwvif_link = rtwsta_link->rtwvif_link;
-	struct rtw89_dev *rtwdev = rtwvif_link->rtwdev;
+	struct rtw89_vif *target_rtwvif = (struct rtw89_vif *)data;
+	struct rtw89_sta *rtwsta = sta_to_rtwsta(sta);
+	struct rtw89_vif *rtwvif = rtwsta->rtwvif;
+	struct rtw89_dev *rtwdev = rtwvif->rtwdev;
+	struct rtw89_vif_link *rtwvif_link;
+	struct rtw89_sta_link *rtwsta_link;
+	unsigned int link_id;
 
-	if (rtwvif_link != target_rtwvif)
+	if (rtwvif != target_rtwvif)
 		return;
 
-	if (rtwvif_link->net_type == RTW89_NET_TYPE_AP_MODE || sta->tdls)
-		rtw89_cam_deinit_addr_cam(rtwdev, &rtwsta_link->addr_cam);
-	if (sta->tdls)
-		rtw89_cam_deinit_bssid_cam(rtwdev, &rtwsta_link->bssid_cam);
+	rtw89_sta_for_each_link(rtwsta, rtwsta_link, link_id) {
+		rtwvif_link = rtwsta_link->rtwvif_link;
 
-	INIT_LIST_HEAD(&rtwsta_link->ba_cam_list);
+		if (rtwvif_link->net_type == RTW89_NET_TYPE_AP_MODE || sta->tdls)
+			rtw89_cam_deinit_addr_cam(rtwdev, &rtwsta_link->addr_cam);
+		if (sta->tdls)
+			rtw89_cam_deinit_bssid_cam(rtwdev, &rtwsta_link->bssid_cam);
+
+		INIT_LIST_HEAD(&rtwsta_link->ba_cam_list);
+	}
 }
 
-static void ser_deinit_cam(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link)
+static void ser_deinit_cam(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 {
+	struct rtw89_vif_link *rtwvif_link;
+	unsigned int link_id;
+
 	ieee80211_iterate_stations_atomic(rtwdev->hw,
 					  ser_sta_deinit_cam_iter,
-					  rtwvif_link);
+					  rtwvif);
 
-	rtw89_cam_deinit(rtwdev, rtwvif_link);
+	rtw89_vif_for_each_link(rtwvif, rtwvif_link, link_id)
+		rtw89_cam_deinit(rtwdev, rtwvif_link);
 
 	bitmap_zero(rtwdev->cam_info.ba_cam_map, RTW89_MAX_BA_CAM_NUM);
 }
 
 static void ser_reset_mac_binding(struct rtw89_dev *rtwdev)
 {
-	struct rtw89_vif_link *rtwvif_link;
+	struct rtw89_vif *rtwvif;
 
 	rtw89_cam_reset_keys(rtwdev);
-	rtw89_for_each_rtwvif(rtwdev, rtwvif_link)
-		ser_deinit_cam(rtwdev, rtwvif_link);
+	rtw89_for_each_rtwvif(rtwdev, rtwvif)
+		ser_deinit_cam(rtwdev, rtwvif);
 
 	rtw89_core_release_all_bits_map(rtwdev->mac_id_map, RTW89_MAX_MAC_ID_NUM);
-	rtw89_for_each_rtwvif(rtwdev, rtwvif_link)
-		ser_reset_vif(rtwdev, rtwvif_link);
+	rtw89_for_each_rtwvif(rtwdev, rtwvif)
+		ser_reset_vif(rtwdev, rtwvif);
 
 	rtwdev->total_sta_assoc = 0;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/util.h b/drivers/net/wireless/realtek/rtw89/util.h
index a5e87a8d8642..e669544cafd3 100644
--- a/drivers/net/wireless/realtek/rtw89/util.h
+++ b/drivers/net/wireless/realtek/rtw89/util.h
@@ -21,14 +21,14 @@
  * twice cause the list to be added twice.
  */
 static inline bool rtw89_rtwvif_in_list(struct rtw89_dev *rtwdev,
-					struct rtw89_vif_link *new)
+					struct rtw89_vif *new)
 {
-	struct rtw89_vif_link *rtwvif_link;
+	struct rtw89_vif *rtwvif;
 
 	lockdep_assert_held(&rtwdev->mutex);
 
-	rtw89_for_each_rtwvif(rtwdev, rtwvif_link)
-		if (rtwvif_link == new)
+	rtw89_for_each_rtwvif(rtwdev, rtwvif)
+		if (rtwvif == new)
 			return true;
 
 	return false;
diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index 97b527d04ad7..3e81fd974ec1 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -421,7 +421,8 @@ static void rtw89_wow_construct_key_info(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
 	struct rtw89_wow_key_info *key_info = &rtw_wow->key_info;
-	struct ieee80211_vif *wow_vif = rtwdev->wow.wow_vif;
+	struct rtw89_vif_link *rtwvif_link = rtwdev->wow.rtwvif_link;
+	struct ieee80211_vif *wow_vif = rtwvif_link_to_vif(rtwvif_link);
 	bool err = false;
 
 	rcu_read_lock();
@@ -596,7 +597,8 @@ static int rtw89_wow_get_aoac_rpt(struct rtw89_dev *rtwdev, bool rx_ready)
 static struct ieee80211_key_conf *rtw89_wow_gtk_rekey(struct rtw89_dev *rtwdev,
 						      u32 cipher, u8 keyidx, u8 *gtk)
 {
-	struct ieee80211_vif *wow_vif = rtwdev->wow.wow_vif;
+	struct rtw89_vif_link *rtwvif_link = rtwdev->wow.rtwvif_link;
+	struct ieee80211_vif *wow_vif = rtwvif_link_to_vif(rtwvif_link);
 	const struct rtw89_cipher_info *cipher_info;
 	struct ieee80211_key_conf *rekey_conf;
 	struct ieee80211_key_conf *key;
@@ -632,8 +634,8 @@ static struct ieee80211_key_conf *rtw89_wow_gtk_rekey(struct rtw89_dev *rtwdev,
 
 static void rtw89_wow_update_key_info(struct rtw89_dev *rtwdev, bool rx_ready)
 {
-	struct ieee80211_vif *wow_vif = rtwdev->wow.wow_vif;
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)wow_vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = rtwdev->wow.rtwvif_link;
+	struct ieee80211_vif *wow_vif = rtwvif_link_to_vif(rtwvif_link);
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
 	struct rtw89_wow_aoac_report *aoac_rpt = &rtw_wow->aoac_rpt;
 	struct rtw89_set_key_info_iter_data data = {.error = false,
@@ -689,16 +691,14 @@ static void rtw89_wow_leave_deep_ps(struct rtw89_dev *rtwdev)
 
 static void rtw89_wow_enter_deep_ps(struct rtw89_dev *rtwdev)
 {
-	struct ieee80211_vif *wow_vif = rtwdev->wow.wow_vif;
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)wow_vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = rtwdev->wow.rtwvif_link;
 
 	__rtw89_enter_ps_mode(rtwdev, rtwvif_link);
 }
 
 static void rtw89_wow_enter_ps(struct rtw89_dev *rtwdev)
 {
-	struct ieee80211_vif *wow_vif = rtwdev->wow.wow_vif;
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)wow_vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = rtwdev->wow.rtwvif_link;
 
 	if (rtw89_wow_mgd_linked(rtwdev))
 		rtw89_enter_lps(rtwdev, rtwvif_link, false);
@@ -708,8 +708,7 @@ static void rtw89_wow_enter_ps(struct rtw89_dev *rtwdev)
 
 static void rtw89_wow_leave_ps(struct rtw89_dev *rtwdev, bool enable_wow)
 {
-	struct ieee80211_vif *wow_vif = rtwdev->wow.wow_vif;
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)wow_vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = rtwdev->wow.rtwvif_link;
 
 	if (rtw89_wow_mgd_linked(rtwdev)) {
 		rtw89_leave_lps(rtwdev);
@@ -742,6 +741,8 @@ static void rtw89_wow_set_rx_filter(struct rtw89_dev *rtwdev, bool enable)
 
 static void rtw89_wow_show_wakeup_reason(struct rtw89_dev *rtwdev)
 {
+	struct rtw89_vif_link *rtwvif_link = rtwdev->wow.rtwvif_link;
+	struct ieee80211_vif *wow_vif = rtwvif_link_to_vif(rtwvif_link);
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
 	struct rtw89_wow_aoac_report *aoac_rpt = &rtw_wow->aoac_rpt;
 	struct cfg80211_wowlan_nd_info nd_info;
@@ -788,36 +789,34 @@ static void rtw89_wow_show_wakeup_reason(struct rtw89_dev *rtwdev)
 		break;
 	default:
 		rtw89_warn(rtwdev, "Unknown wakeup reason %x\n", reason);
-		ieee80211_report_wowlan_wakeup(rtwdev->wow.wow_vif, NULL,
-					       GFP_KERNEL);
+		ieee80211_report_wowlan_wakeup(wow_vif, NULL, GFP_KERNEL);
 		return;
 	}
 
-	ieee80211_report_wowlan_wakeup(rtwdev->wow.wow_vif, &wakeup,
-				       GFP_KERNEL);
+	ieee80211_report_wowlan_wakeup(wow_vif, &wakeup, GFP_KERNEL);
 }
 
 static void rtw89_wow_vif_iter(struct rtw89_dev *rtwdev,
 			       struct rtw89_vif_link *rtwvif_link)
 {
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
+	struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
 
 	/* Current WoWLAN function support setting of only vif in
 	 * infra mode or no link mode. When one suitable vif is found,
 	 * stop the iteration.
 	 */
-	if (rtw_wow->wow_vif || vif->type != NL80211_IFTYPE_STATION)
+	if (rtw_wow->rtwvif_link || vif->type != NL80211_IFTYPE_STATION)
 		return;
 
 	switch (rtwvif_link->net_type) {
 	case RTW89_NET_TYPE_INFRA:
 		if (rtw_wow_has_mgd_features(rtwdev))
-			rtw_wow->wow_vif = vif;
+			rtw_wow->rtwvif_link = rtwvif_link;
 		break;
 	case RTW89_NET_TYPE_NO_LINK:
 		if (rtw_wow->pno_inited)
-			rtw_wow->wow_vif = vif;
+			rtw_wow->rtwvif_link = rtwvif_link;
 		break;
 	default:
 		break;
@@ -1049,7 +1048,7 @@ static void rtw89_wow_clear_wakeups(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
 
-	rtw_wow->wow_vif = NULL;
+	rtw_wow->rtwvif_link = NULL;
 	rtw89_core_release_all_bits_map(rtw_wow->flags, RTW89_WOW_FLAG_NUM);
 	rtw_wow->pattern_cnt = 0;
 	rtw_wow->pno_inited = false;
@@ -1076,6 +1075,7 @@ static int rtw89_wow_set_wakeups(struct rtw89_dev *rtwdev,
 {
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
 	struct rtw89_vif_link *rtwvif_link;
+	struct rtw89_vif *rtwvif;
 
 	if (wowlan->disconnect)
 		set_bit(RTW89_WOW_FLAG_EN_DISCONNECT, rtw_wow->flags);
@@ -1087,21 +1087,25 @@ static int rtw89_wow_set_wakeups(struct rtw89_dev *rtwdev,
 	if (wowlan->nd_config)
 		rtw89_wow_init_pno(rtwdev, wowlan->nd_config);
 
-	rtw89_for_each_rtwvif(rtwdev, rtwvif_link)
+	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
+		/* use the link on HW-0 to do wow flow */
+		rtwvif_link = rtw89_vif_get_link_inst(rtwvif, 0);
+		if (!rtwvif_link)
+			continue;
+
 		rtw89_wow_vif_iter(rtwdev, rtwvif_link);
+	}
 
-	if (!rtw_wow->wow_vif)
+	rtwvif_link = rtw_wow->rtwvif_link;
+	if (!rtwvif_link)
 		return -EPERM;
 
-	rtwvif_link = (struct rtw89_vif_link *)rtw_wow->wow_vif->drv_priv;
 	return rtw89_wow_parse_patterns(rtwdev, rtwvif_link, wowlan);
 }
 
 static int rtw89_wow_cfg_wake_pno(struct rtw89_dev *rtwdev, bool wow)
 {
-	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
-	struct ieee80211_vif *wow_vif = rtw_wow->wow_vif;
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)wow_vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = rtwdev->wow.rtwvif_link;
 	int ret;
 
 	ret = rtw89_fw_h2c_cfg_pno(rtwdev, rtwvif_link, true);
@@ -1128,15 +1132,20 @@ static int rtw89_wow_cfg_wake_pno(struct rtw89_dev *rtwdev, bool wow)
 static int rtw89_wow_cfg_wake(struct rtw89_dev *rtwdev, bool wow)
 {
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
-	struct ieee80211_vif *wow_vif = rtw_wow->wow_vif;
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)wow_vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = rtw_wow->rtwvif_link;
+	struct ieee80211_vif *wow_vif = rtwvif_link_to_vif(rtwvif_link);
 	struct ieee80211_sta *wow_sta;
 	struct rtw89_sta_link *rtwsta_link = NULL;
+	struct rtw89_sta *rtwsta;
 	int ret;
 
-	wow_sta = ieee80211_find_sta(wow_vif, rtwvif_link->bssid);
-	if (wow_sta)
-		rtwsta_link = (struct rtw89_sta_link *)wow_sta->drv_priv;
+	wow_sta = ieee80211_find_sta(wow_vif, wow_vif->cfg.ap_addr);
+	if (wow_sta) {
+		rtwsta = sta_to_rtwsta(wow_sta);
+		rtwsta_link = rtwsta->links[rtwvif_link->link_id];
+		if (!rtwsta_link)
+			return -ENOLINK;
+	}
 
 	if (wow) {
 		if (rtw_wow->pattern_cnt)
@@ -1199,25 +1208,30 @@ static int rtw89_wow_swap_fw(struct rtw89_dev *rtwdev, bool wow)
 	enum rtw89_fw_type fw_type = wow ? RTW89_FW_WOWLAN : RTW89_FW_NORMAL;
 	enum rtw89_chip_gen chip_gen = rtwdev->chip->chip_gen;
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
-	struct ieee80211_vif *wow_vif = rtw_wow->wow_vif;
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)wow_vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = rtw_wow->rtwvif_link;
+	struct ieee80211_vif *wow_vif = rtwvif_link_to_vif(rtwvif_link);
 	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	bool include_bb = !!chip->bbmcu_nr;
 	bool disable_intr_for_dlfw = false;
 	struct ieee80211_sta *wow_sta;
 	struct rtw89_sta_link *rtwsta_link = NULL;
+	struct rtw89_sta *rtwsta;
 	bool is_conn = true;
 	int ret;
 
 	if (chip_id == RTL8852C || chip_id == RTL8922A)
 		disable_intr_for_dlfw = true;
 
-	wow_sta = ieee80211_find_sta(wow_vif, rtwvif_link->bssid);
-	if (wow_sta)
-		rtwsta_link = (struct rtw89_sta_link *)wow_sta->drv_priv;
-	else
+	wow_sta = ieee80211_find_sta(wow_vif, wow_vif->cfg.ap_addr);
+	if (wow_sta) {
+		rtwsta = sta_to_rtwsta(wow_sta);
+		rtwsta_link = rtwsta->links[rtwvif_link->link_id];
+		if (!rtwsta_link)
+			return -ENOLINK;
+	} else {
 		is_conn = false;
+	}
 
 	if (disable_intr_for_dlfw)
 		rtw89_hci_disable_intr(rtwdev);
@@ -1372,9 +1386,7 @@ static int rtw89_wow_disable_trx_pre(struct rtw89_dev *rtwdev)
 
 static int rtw89_wow_disable_trx_post(struct rtw89_dev *rtwdev)
 {
-	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
-	struct ieee80211_vif *vif = rtw_wow->wow_vif;
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = rtwdev->wow.rtwvif_link;
 	int ret;
 
 	ret = rtw89_mac_cfg_ppdu_status(rtwdev, RTW89_MAC_0, true);
@@ -1446,8 +1458,7 @@ static int rtw89_pno_scan_offload(struct rtw89_dev *rtwdev, bool enable)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
-	struct ieee80211_vif *wow_vif = rtw_wow->wow_vif;
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)wow_vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = rtwdev->wow.rtwvif_link;
 	int interval = rtw_wow->nd_config->scan_plans[0].interval;
 	struct rtw89_scan_option opt = {};
 	int ret;
@@ -1489,8 +1500,7 @@ static int rtw89_pno_scan_offload(struct rtw89_dev *rtwdev, bool enable)
 static int rtw89_wow_fw_start(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
-	struct ieee80211_vif *wow_vif = rtw_wow->wow_vif;
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)wow_vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = rtw_wow->rtwvif_link;
 	int ret;
 
 	if (rtw89_wow_no_link(rtwdev)) {
@@ -1558,8 +1568,7 @@ static int rtw89_wow_fw_start(struct rtw89_dev *rtwdev)
 static int rtw89_wow_fw_stop(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
-	struct ieee80211_vif *wow_vif = rtw_wow->wow_vif;
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)wow_vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = rtw_wow->rtwvif_link;
 	int ret;
 
 	if (rtw89_wow_no_link(rtwdev)) {
diff --git a/drivers/net/wireless/realtek/rtw89/wow.h b/drivers/net/wireless/realtek/rtw89/wow.h
index a80b4b84587d..f91991e8f2e3 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.h
+++ b/drivers/net/wireless/realtek/rtw89/wow.h
@@ -97,16 +97,14 @@ static inline int rtw89_wow_get_sec_hdr_len(struct rtw89_dev *rtwdev)
 #ifdef CONFIG_PM
 static inline bool rtw89_wow_mgd_linked(struct rtw89_dev *rtwdev)
 {
-	struct ieee80211_vif *wow_vif = rtwdev->wow.wow_vif;
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)wow_vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = rtwdev->wow.rtwvif_link;
 
 	return rtwvif_link->net_type == RTW89_NET_TYPE_INFRA;
 }
 
 static inline bool rtw89_wow_no_link(struct rtw89_dev *rtwdev)
 {
-	struct ieee80211_vif *wow_vif = rtwdev->wow.wow_vif;
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)wow_vif->drv_priv;
+	struct rtw89_vif_link *rtwvif_link = rtwdev->wow.rtwvif_link;
 
 	return rtwvif_link->net_type == RTW89_NET_TYPE_NO_LINK;
 }
-- 
2.25.1


