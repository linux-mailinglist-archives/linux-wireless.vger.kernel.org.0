Return-Path: <linux-wireless+bounces-21808-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07953A95AA2
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 03:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33AD91747BD
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 01:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FFD156678;
	Tue, 22 Apr 2025 01:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="HRks1XU8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A400018C930
	for <linux-wireless@vger.kernel.org>; Tue, 22 Apr 2025 01:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745286431; cv=none; b=QiebED4k4GkLb+joWT1fLmvB0VlS6whHSgy0v/t3/3MmJqZwJAmW5qzpc2gEjthxXgreKYCBjwnVTOL4fbl/XBGVG8PidziGTQp0SgvblttDu26kTx+l3RKXu0k04zrRE5WVfpUyfXhBNqsFyPLh6uXFhs0NrmnGccQlvMz4CUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745286431; c=relaxed/simple;
	bh=D5I1Kuw5AlgBcTOrIs/CjbRMpJgOc2P0I/DsdmAl0kk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VltLYe9/6l5GYpjHAhgUdHZAsR47x2t5slZGlXCoQ8FpxHbUnmzTtgeS/9kyYDKF/q2uMI8JRV4b14B7ftVYIu56xpafq8LbIke0jtjXFjUPVbv97FIC5Yeglh2mCAfPTxqAWVBrptgeX3V9jKo/pWLoRgDc9ACXQWp7Li/IR2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=HRks1XU8; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53M1l6N113859512, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745286426; bh=D5I1Kuw5AlgBcTOrIs/CjbRMpJgOc2P0I/DsdmAl0kk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=HRks1XU88XPv0TMj+VQitsKWY9ZMOAdt1wdCDGe3tlX1y0ADAbWFS88vwNs0ofxWb
	 yVXl3VfIZDgA+dfiKgNeMlqtOoTSkjqCBmtn4BYjwT5+nvcOCNlB1FMYcvcDoLCXsv
	 pBx6f3v46ZC82IWnVp05HsW2wWOoBm6xVFLl7Cq7tgkuZpdE4uiyRjjGKrGtqUabcv
	 cqq5R2Jh3b00TJE7xhO7jCltMvzbBTCYjUclGwlikWbsNRih4yTSEvTmAY1fyh2pHT
	 TyFj1ls6bQ6ECJMeO4IjG1+f6AHYyc2LDN85pvGrXtTdjoXfwwsTtrtTve6AITrRX1
	 KZ/jO5UGQA8Kw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53M1l6N113859512
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 22 Apr 2025 09:47:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Apr 2025 09:47:06 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 22 Apr
 2025 09:47:06 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 03/12] wifi: rtw89: add suffix "_ax" to Wi-Fi 6 HW scan struct and func
Date: Tue, 22 Apr 2025 09:46:11 +0800
Message-ID: <20250422014620.18421-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250422014620.18421-1-pkshih@realtek.com>
References: <20250422014620.18421-1-pkshih@realtek.com>
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

These stuffs have no suffix, but not universal, and only work for Wi-Fi 6.
Since the corresponding HW scan struct/func of Wi-Fi 7 have suffix "_be",
to avoid misunderstanding and improve readability, also add suffix "_ax"
to these Wi-Fi 6 stuffs.

(No logic is changed.)

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 36 ++++++++++++-------------
 drivers/net/wireless/realtek/rtw89/fw.h |  2 +-
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 10cffc8ab7b5..5cf4b3cba047 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -5308,12 +5308,12 @@ int rtw89_fw_h2c_add_pkt_offload(struct rtw89_dev *rtwdev, u8 *id,
 }
 
 static
-int rtw89_fw_h2c_scan_list_offload(struct rtw89_dev *rtwdev, int ch_num,
-				   struct list_head *chan_list)
+int rtw89_fw_h2c_scan_list_offload_ax(struct rtw89_dev *rtwdev, int ch_num,
+				      struct list_head *chan_list)
 {
 	struct rtw89_wait_info *wait = &rtwdev->mac.fw_ofld_wait;
 	struct rtw89_h2c_chinfo_elem *elem;
-	struct rtw89_mac_chinfo *ch_info;
+	struct rtw89_mac_chinfo_ax *ch_info;
 	struct rtw89_h2c_chinfo *h2c;
 	struct sk_buff *skb;
 	unsigned int cond;
@@ -6648,10 +6648,10 @@ static int rtw89_hw_scan_update_probe_req(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
-static int rtw89_update_6ghz_rnr_chan(struct rtw89_dev *rtwdev,
-				      struct ieee80211_scan_ies *ies,
-				      struct cfg80211_scan_request *req,
-				      struct rtw89_mac_chinfo *ch_info)
+static int rtw89_update_6ghz_rnr_chan_ax(struct rtw89_dev *rtwdev,
+					 struct ieee80211_scan_ies *ies,
+					 struct cfg80211_scan_request *req,
+					 struct rtw89_mac_chinfo_ax *ch_info)
 {
 	struct rtw89_vif_link *rtwvif_link = rtwdev->scan_info.scanning_vif;
 	struct list_head *pkt_list = rtwdev->scan_info.pkt_list;
@@ -6723,7 +6723,7 @@ static int rtw89_update_6ghz_rnr_chan(struct rtw89_dev *rtwdev,
 
 static void rtw89_pno_scan_add_chan_ax(struct rtw89_dev *rtwdev,
 				       int chan_type, int ssid_num,
-				       struct rtw89_mac_chinfo *ch_info)
+				       struct rtw89_mac_chinfo_ax *ch_info)
 {
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
 	struct rtw89_pktofld_info *info;
@@ -6771,9 +6771,9 @@ static void rtw89_pno_scan_add_chan_ax(struct rtw89_dev *rtwdev,
 	}
 }
 
-static void rtw89_hw_scan_add_chan(struct rtw89_dev *rtwdev, int chan_type,
-				   int ssid_num,
-				   struct rtw89_mac_chinfo *ch_info)
+static void rtw89_hw_scan_add_chan_ax(struct rtw89_dev *rtwdev, int chan_type,
+				      int ssid_num,
+				      struct rtw89_mac_chinfo_ax *ch_info)
 {
 	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
 	struct rtw89_vif_link *rtwvif_link = rtwdev->scan_info.scanning_vif;
@@ -6804,7 +6804,7 @@ static void rtw89_hw_scan_add_chan(struct rtw89_dev *rtwdev, int chan_type,
 		}
 	}
 
-	ret = rtw89_update_6ghz_rnr_chan(rtwdev, ies, req, ch_info);
+	ret = rtw89_update_6ghz_rnr_chan_ax(rtwdev, ies, req, ch_info);
 	if (ret)
 		rtw89_warn(rtwdev, "RNR fails: %d\n", ret);
 
@@ -6960,7 +6960,7 @@ int rtw89_pno_scan_add_chan_list_ax(struct rtw89_dev *rtwdev,
 {
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
 	struct cfg80211_sched_scan_request *nd_config = rtw_wow->nd_config;
-	struct rtw89_mac_chinfo	*ch_info, *tmp;
+	struct rtw89_mac_chinfo_ax *ch_info, *tmp;
 	struct ieee80211_channel *channel;
 	struct list_head chan_list;
 	int list_len;
@@ -6994,7 +6994,7 @@ int rtw89_pno_scan_add_chan_list_ax(struct rtw89_dev *rtwdev,
 		rtw89_pno_scan_add_chan_ax(rtwdev, type, nd_config->n_match_sets, ch_info);
 		list_add_tail(&ch_info->list, &chan_list);
 	}
-	ret = rtw89_fw_h2c_scan_list_offload(rtwdev, list_len, &chan_list);
+	ret = rtw89_fw_h2c_scan_list_offload_ax(rtwdev, list_len, &chan_list);
 
 out:
 	list_for_each_entry_safe(ch_info, tmp, &chan_list, list) {
@@ -7010,7 +7010,7 @@ int rtw89_hw_scan_add_chan_list_ax(struct rtw89_dev *rtwdev,
 {
 	struct rtw89_vif *rtwvif = rtwvif_link->rtwvif;
 	struct cfg80211_scan_request *req = rtwvif->scan_req;
-	struct rtw89_mac_chinfo	*ch_info, *tmp;
+	struct rtw89_mac_chinfo_ax *ch_info, *tmp;
 	struct ieee80211_channel *channel;
 	struct list_head chan_list;
 	bool random_seq = req->flags & NL80211_SCAN_FLAG_RANDOM_SN;
@@ -7049,7 +7049,7 @@ int rtw89_hw_scan_add_chan_list_ax(struct rtw89_dev *rtwdev,
 			type = RTW89_CHAN_DFS;
 		else
 			type = RTW89_CHAN_ACTIVE;
-		rtw89_hw_scan_add_chan(rtwdev, type, req->n_ssids, ch_info);
+		rtw89_hw_scan_add_chan_ax(rtwdev, type, req->n_ssids, ch_info);
 
 		if (connected &&
 		    off_chan_time + ch_info->period > RTW89_OFF_CHAN_TIME) {
@@ -7063,7 +7063,7 @@ int rtw89_hw_scan_add_chan_list_ax(struct rtw89_dev *rtwdev,
 			type = RTW89_CHAN_OPERATE;
 			tmp->period = req->duration_mandatory ?
 				      req->duration : RTW89_CHANNEL_TIME;
-			rtw89_hw_scan_add_chan(rtwdev, type, 0, tmp);
+			rtw89_hw_scan_add_chan_ax(rtwdev, type, 0, tmp);
 			list_add_tail(&tmp->list, &chan_list);
 			off_chan_time = 0;
 			list_len++;
@@ -7072,7 +7072,7 @@ int rtw89_hw_scan_add_chan_list_ax(struct rtw89_dev *rtwdev,
 		off_chan_time += ch_info->period;
 	}
 	rtwdev->scan_info.last_chan_idx = idx;
-	ret = rtw89_fw_h2c_scan_list_offload(rtwdev, list_len, &chan_list);
+	ret = rtw89_fw_h2c_scan_list_offload_ax(rtwdev, list_len, &chan_list);
 
 out:
 	list_for_each_entry_safe(ch_info, tmp, &chan_list, list) {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 5ef948343912..1395ac9d6b78 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -335,7 +335,7 @@ struct rtw89_fw_macid_pause_sleep_grp {
 
 #define RTW89_BCN_LOSS_CNT 60
 
-struct rtw89_mac_chinfo {
+struct rtw89_mac_chinfo_ax {
 	u8 period;
 	u8 dwell_time;
 	u8 central_ch;
-- 
2.25.1


