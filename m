Return-Path: <linux-wireless+bounces-3188-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D73284ACA7
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 04:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D02721C2287E
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 03:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510617316E;
	Tue,  6 Feb 2024 03:07:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1306156B7C
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 03:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707188835; cv=none; b=HumDMWlj0ZM72L93PkA+HCuhI45s9/OvzZ8eNxtvrvWjfcvJmqtgmyH/Y0srHkBbdxwWZB4Ej4bXZDFdXwFSzWskogGjbOmJlHZDb5Ksgwig/sH9pIgoUSwrlewtJPF0GaAaYuqT72umxBAWb0E1NKAaB/ekp7tq8WOxvbGRzGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707188835; c=relaxed/simple;
	bh=qHAtvYbt4uTpUYeBqhqMuWZe1pH0bkZYgs7I21sWwwk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Okd2nctg+sRNR58NORTZlREIJhKFibZ3jVpzCf8tElypqDWRWMpah/+wizCV3Im7bxoEhWx60yOGbjVzAGCjpeQ54KBucbscgg33Da9rB/kQ4XRlG2CNq/bBQyAhMEGgbrfq/zplqlurdI4NJpdJU9Fb4Dsp0MKbiyqOb6KV1Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 416376NJ03532416, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 416376NJ03532416
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Feb 2024 11:07:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Tue, 6 Feb 2024 11:07:06 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 6 Feb
 2024 11:07:06 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/6] wifi: rtw89: drop TIMING_BEACON_ONLY and sync beacon TSF by self
Date: Tue, 6 Feb 2024 11:06:19 +0800
Message-ID: <20240206030624.23382-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240206030624.23382-1-pkshih@realtek.com>
References: <20240206030624.23382-1-pkshih@realtek.com>
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

Some of our calculation during concurrent mode depend on last beacon
TSF. Originally, we just set IEEE80211_HW_TIMING_BEACON_ONLY and get
what we want from mac80211. But, IEEE80211_HW_TIMING_BEACON_ONLY will
be restricted once we declare MLO.

Since we are about to consider the MLO stuffs, so sync beacon TSF by
ourselves now and unset IEEE80211_HW_TIMING_BEACON_ONLY.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c     |  9 +--------
 drivers/net/wireless/realtek/rtw89/core.c     | 18 ++++++++++++++----
 drivers/net/wireless/realtek/rtw89/core.h     |  1 +
 drivers/net/wireless/realtek/rtw89/mac80211.c |  1 +
 4 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 21449cb9b069..2a95f9db83f9 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -320,19 +320,12 @@ int rtw89_iterate_mcc_roles(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
-/* For now, IEEE80211_HW_TIMING_BEACON_ONLY can make things simple to ensure
- * correctness of MCC calculation logic below. We have noticed that once driver
- * declares WIPHY_FLAG_SUPPORTS_MLO, the use of IEEE80211_HW_TIMING_BEACON_ONLY
- * will be restricted. We will make an alternative in driver when it is ready
- * for MLO.
- */
 static u32 rtw89_mcc_get_tbtt_ofst(struct rtw89_dev *rtwdev,
 				   struct rtw89_mcc_role *role, u64 tsf)
 {
 	struct rtw89_vif *rtwvif = role->rtwvif;
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
 	u32 bcn_intvl_us = ieee80211_tu_to_usec(role->beacon_interval);
-	u64 sync_tsf = vif->bss_conf.sync_tsf;
+	u64 sync_tsf = READ_ONCE(rtwvif->sync_bcn_tsf);
 	u32 remainder;
 
 	if (tsf < sync_tsf) {
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 260da86bf04a..de4c37c48f4e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1868,6 +1868,17 @@ static void rtw89_core_cancel_6ghz_probe_tx(struct rtw89_dev *rtwdev,
 		ieee80211_queue_work(rtwdev->hw, &rtwdev->cancel_6ghz_probe_work);
 }
 
+static void rtw89_vif_sync_bcn_tsf(struct rtw89_vif *rtwvif,
+				   struct ieee80211_hdr *hdr, size_t len)
+{
+	struct ieee80211_mgmt *mgmt = (typeof(mgmt))hdr;
+
+	if (len < offsetof(typeof(*mgmt), u.beacon.variable))
+		return;
+
+	WRITE_ONCE(rtwvif->sync_bcn_tsf, le64_to_cpu(mgmt->u.beacon.timestamp));
+}
+
 static void rtw89_vif_rx_stats_iter(void *data, u8 *mac,
 				    struct ieee80211_vif *vif)
 {
@@ -1898,8 +1909,10 @@ static void rtw89_vif_rx_stats_iter(void *data, u8 *mac,
 		return;
 
 	if (ieee80211_is_beacon(hdr->frame_control)) {
-		if (vif->type == NL80211_IFTYPE_STATION)
+		if (vif->type == NL80211_IFTYPE_STATION) {
+			rtw89_vif_sync_bcn_tsf(rtwvif, hdr, skb->len);
 			rtw89_fw_h2c_rssi_offload(rtwdev, phy_ppdu);
+		}
 		pkt_stat->beacon_nr++;
 	}
 
@@ -4445,9 +4458,6 @@ static int rtw89_core_register_hw(struct rtw89_dev *rtwdev)
 	ieee80211_hw_set(hw, SUPPORTS_MULTI_BSSID);
 	ieee80211_hw_set(hw, WANT_MONITOR_VIF);
 
-	/* ref: description of rtw89_mcc_get_tbtt_ofst() in chan.c */
-	ieee80211_hw_set(hw, TIMING_BEACON_ONLY);
-
 	if (chip->support_bandwidths & BIT(NL80211_CHAN_WIDTH_160))
 		ieee80211_hw_set(hw, SUPPORTS_VHT_EXT_NSS_BW);
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 30cc77ac78c5..927356861cb8 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3043,6 +3043,7 @@ struct rtw89_vif {
 	u8 bcn_hit_cond;
 	u8 hit_rule;
 	u8 last_noa_nr;
+	u64 sync_bcn_tsf;
 	bool offchan;
 	bool trigger;
 	bool lsig_txop;
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index b61c5be8cae3..31d1ffb16e83 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -449,6 +449,7 @@ static void rtw89_ops_bss_info_changed(struct ieee80211_hw *hw,
 		ether_addr_copy(rtwvif->bssid, conf->bssid);
 		rtw89_cam_bssid_changed(rtwdev, rtwvif);
 		rtw89_fw_h2c_cam(rtwdev, rtwvif, NULL, NULL);
+		WRITE_ONCE(rtwvif->sync_bcn_tsf, 0);
 	}
 
 	if (changed & BSS_CHANGED_BEACON)
-- 
2.25.1


