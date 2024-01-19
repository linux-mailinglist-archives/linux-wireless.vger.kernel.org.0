Return-Path: <linux-wireless+bounces-2231-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D1F832586
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 09:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 717711F230CE
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 08:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1D528E15;
	Fri, 19 Jan 2024 08:16:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D28B28E0A
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jan 2024 08:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705652162; cv=none; b=SBPobhYEbqnweJz2lfPbFTRHq6HV2Z80aKg4oOWNJsn2dIQDjWjU6OmBRjQZYbDYskEluYay2TKqkago0au8hNhX34Mytro68n4e126gYTjRAoM4V8lJQa8sI76bSxVBAe4lkFCtwdi+EkxIZ8+dj66x651yNQx0m1QvUm3AYng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705652162; c=relaxed/simple;
	bh=FbQOS4tBU9AwKfwBNbxS6aOIuev8hL1aVFb6onwDHSY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nwhG6C/shl5hOLrXQI6YxV+LnuX6v/ZQE4x3i42XjOO9e/kSwRjiujhVOzoiCkTK5+vzcb+q2Ix9ZRilfo2bq5pcaP3xTAU3Z3wywtTp/5RToFNs5b2ifBjM1/mFD3up6O9aaKFffDeaTyHvxMXl9xqyceqFWIH+16O/fgl1OAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40J8FtL622212493, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40J8FtL622212493
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jan 2024 16:15:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Fri, 19 Jan 2024 16:15:56 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 19 Jan
 2024 16:15:55 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <gary.chang@realtek.com>, <phhuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 7/8] wifi: rtw89: fix HW scan timeout due to TSF sync issue
Date: Fri, 19 Jan 2024 16:15:00 +0800
Message-ID: <20240119081501.25223-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240119081501.25223-1-pkshih@realtek.com>
References: <20240119081501.25223-1-pkshih@realtek.com>
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

From: Chih-Kang Chang <gary.chang@realtek.com>

When STA connects to an AP and doesn't receive any beacon yet, the
hardware scan is triggered. This scan begins with the default TSF
value. Once STA receives a beacon when switches back to the operating
channel, its TSF synchronizes with the AP. However, if there is a
significant difference in TSF values between the default value and
the synchronized value, it will cause firmware fail to trigger
interrupt, and the C2H won't be sent out. As a result, the scan
continues until a timeout occurs. To fix this issue, we disable TSF
synchronization during scanning to prevent drastic TSF changes, and
enable TSF synchronization after scan.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c  |  5 +++--
 drivers/net/wireless/realtek/rtw89/mac.c | 17 ++++++++++++-----
 drivers/net/wireless/realtek/rtw89/mac.h |  2 ++
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 231dd884645a..e49360e29faf 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -4873,6 +4873,7 @@ void rtw89_hw_scan_start(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 	rtwvif->scan_ies = &scan_req->ies;
 	rtwvif->scan_req = req;
 	ieee80211_stop_queues(rtwdev->hw);
+	rtw89_mac_port_cfg_rx_sync(rtwdev, rtwvif, false);
 
 	if (req->flags & NL80211_SCAN_FLAG_RANDOM_ADDR)
 		get_random_mask_addr(mac_addr, req->mac_addr,
@@ -4897,10 +4898,10 @@ void rtw89_hw_scan_complete(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
+	struct rtw89_vif *rtwvif = vif_to_rtwvif_safe(vif);
 	struct cfg80211_scan_info info = {
 		.aborted = aborted,
 	};
-	struct rtw89_vif *rtwvif;
 
 	if (!vif)
 		return;
@@ -4913,10 +4914,10 @@ void rtw89_hw_scan_complete(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 	rtw89_core_scan_complete(rtwdev, vif, true);
 	ieee80211_scan_completed(rtwdev->hw, &info);
 	ieee80211_wake_queues(rtwdev->hw);
+	rtw89_mac_port_cfg_rx_sync(rtwdev, rtwvif, true);
 	rtw89_mac_enable_beacon_for_ap_vifs(rtwdev, true);
 
 	rtw89_release_pkt_list(rtwdev);
-	rtwvif = (struct rtw89_vif *)vif->drv_priv;
 	rtwvif->scan_req = NULL;
 	rtwvif->scan_ies = NULL;
 	scan_info->last_chan_idx = 0;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 03553b63a4a8..b224d06e5f3c 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4185,13 +4185,11 @@ static void rtw89_mac_port_cfg_rx_sw(struct rtw89_dev *rtwdev,
 		rtw89_write32_port_clr(rtwdev, rtwvif, p->port_cfg, bit);
 }
 
-static void rtw89_mac_port_cfg_rx_sync(struct rtw89_dev *rtwdev,
-				       struct rtw89_vif *rtwvif)
+void rtw89_mac_port_cfg_rx_sync(struct rtw89_dev *rtwdev,
+				struct rtw89_vif *rtwvif, bool en)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	const struct rtw89_port_reg *p = mac->port_base;
-	bool en = rtwvif->net_type == RTW89_NET_TYPE_INFRA ||
-		  rtwvif->net_type == RTW89_NET_TYPE_AD_HOC;
 
 	if (en)
 		rtw89_write32_port_set(rtwdev, rtwvif, p->port_cfg, B_AX_TSF_UDT_EN);
@@ -4199,6 +4197,15 @@ static void rtw89_mac_port_cfg_rx_sync(struct rtw89_dev *rtwdev,
 		rtw89_write32_port_clr(rtwdev, rtwvif, p->port_cfg, B_AX_TSF_UDT_EN);
 }
 
+static void rtw89_mac_port_cfg_rx_sync_by_nettype(struct rtw89_dev *rtwdev,
+						  struct rtw89_vif *rtwvif)
+{
+	bool en = rtwvif->net_type == RTW89_NET_TYPE_INFRA ||
+		  rtwvif->net_type == RTW89_NET_TYPE_AD_HOC;
+
+	rtw89_mac_port_cfg_rx_sync(rtwdev, rtwvif, en);
+}
+
 static void rtw89_mac_port_cfg_tx_sw(struct rtw89_dev *rtwdev,
 				     struct rtw89_vif *rtwvif, bool en)
 {
@@ -4538,7 +4545,7 @@ int rtw89_mac_port_update(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	rtw89_mac_port_cfg_net_type(rtwdev, rtwvif);
 	rtw89_mac_port_cfg_bcn_prct(rtwdev, rtwvif);
 	rtw89_mac_port_cfg_rx_sw(rtwdev, rtwvif);
-	rtw89_mac_port_cfg_rx_sync(rtwdev, rtwvif);
+	rtw89_mac_port_cfg_rx_sync_by_nettype(rtwdev, rtwvif);
 	rtw89_mac_port_cfg_tx_sw_by_nettype(rtwdev, rtwvif);
 	rtw89_mac_port_cfg_bcn_intv(rtwdev, rtwvif);
 	rtw89_mac_port_cfg_hiq_win(rtwdev, rtwvif);
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 54ce16a2c475..181d03d1f78a 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1086,6 +1086,8 @@ void rtw89_mac_port_tsf_sync(struct rtw89_dev *rtwdev,
 			     u16 offset_tu);
 int rtw89_mac_port_get_tsf(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 			   u64 *tsf);
+void rtw89_mac_port_cfg_rx_sync(struct rtw89_dev *rtwdev,
+				struct rtw89_vif *rtwvif, bool en);
 void rtw89_mac_set_he_obss_narrow_bw_ru(struct rtw89_dev *rtwdev,
 					struct ieee80211_vif *vif);
 void rtw89_mac_stop_ap(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
-- 
2.25.1


