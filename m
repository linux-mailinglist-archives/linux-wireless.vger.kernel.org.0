Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79100495A53
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jan 2022 08:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378847AbiAUHI6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Jan 2022 02:08:58 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:44461 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378846AbiAUHI5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Jan 2022 02:08:57 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 20L78mHY2022506, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 20L78mHY2022506
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 21 Jan 2022 15:08:48 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 21 Jan 2022 15:08:48 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 21 Jan
 2022 15:08:48 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <usama.anjum@collabora.com>,
        <phhuang@realtek.com>
Subject: [PATCH 3/3] rtw88: fix memory overrun and memory leak during hw_scan
Date:   Fri, 21 Jan 2022 15:08:13 +0800
Message-ID: <20220121070813.9656-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220121070813.9656-1-pkshih@realtek.com>
References: <20220121070813.9656-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 01/21/2022 06:52:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEvMjEgpFekyCAwNjowMDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Po-Hao Huang <phhuang@realtek.com>

Previously we allocated less memory than actual required, overwrite
to the buffer causes the mm module to complaint and raise access
violation faults. Along with potential memory leaks when returned
early. Fix these by passing the correct size and proper deinit flow.

Fixes: 10d162b2ed39 ("rtw88: 8822c: add ieee80211_ops::hw_scan")
Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c | 34 +++++++++++++++++--------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index a631042753eab..ce9535cce7232 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -1784,9 +1784,9 @@ void rtw_fw_scan_notify(struct rtw_dev *rtwdev, bool start)
 	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
 }
 
-static void rtw_append_probe_req_ie(struct rtw_dev *rtwdev, struct sk_buff *skb,
-				    struct sk_buff_head *list,
-				    struct rtw_vif *rtwvif)
+static int rtw_append_probe_req_ie(struct rtw_dev *rtwdev, struct sk_buff *skb,
+				   struct sk_buff_head *list, u8 *bands,
+				   struct rtw_vif *rtwvif)
 {
 	struct ieee80211_scan_ies *ies = rtwvif->scan_ies;
 	struct rtw_chip_info *chip = rtwdev->chip;
@@ -1797,19 +1797,24 @@ static void rtw_append_probe_req_ie(struct rtw_dev *rtwdev, struct sk_buff *skb,
 		if (!(BIT(idx) & chip->band))
 			continue;
 		new = skb_copy(skb, GFP_KERNEL);
+		if (!new)
+			return -ENOMEM;
 		skb_put_data(new, ies->ies[idx], ies->len[idx]);
 		skb_put_data(new, ies->common_ies, ies->common_ie_len);
 		skb_queue_tail(list, new);
+		(*bands)++;
 	}
+
+	return 0;
 }
 
-static int _rtw_hw_scan_update_probe_req(struct rtw_dev *rtwdev, u8 num_ssids,
+static int _rtw_hw_scan_update_probe_req(struct rtw_dev *rtwdev, u8 num_probes,
 					 struct sk_buff_head *probe_req_list)
 {
 	struct rtw_chip_info *chip = rtwdev->chip;
 	struct sk_buff *skb, *tmp;
 	u8 page_offset = 1, *buf, page_size = chip->page_size;
-	u8 pages = page_offset + num_ssids * RTW_PROBE_PG_CNT;
+	u8 pages = page_offset + num_probes * RTW_PROBE_PG_CNT;
 	u16 pg_addr = rtwdev->fifo.rsvd_h2c_info_addr, loc;
 	u16 buf_offset = page_size * page_offset;
 	u8 tx_desc_sz = chip->tx_pkt_desc_sz;
@@ -1848,6 +1853,8 @@ static int _rtw_hw_scan_update_probe_req(struct rtw_dev *rtwdev, u8 num_ssids,
 	rtwdev->scan_info.probe_pg_size = page_offset;
 out:
 	kfree(buf);
+	skb_queue_walk(probe_req_list, skb)
+		kfree_skb(skb);
 
 	return ret;
 }
@@ -1858,7 +1865,8 @@ static int rtw_hw_scan_update_probe_req(struct rtw_dev *rtwdev,
 	struct cfg80211_scan_request *req = rtwvif->scan_req;
 	struct sk_buff_head list;
 	struct sk_buff *skb;
-	u8 num = req->n_ssids, i;
+	u8 num = req->n_ssids, i, bands = 0;
+	int ret;
 
 	skb_queue_head_init(&list);
 	for (i = 0; i < num; i++) {
@@ -1866,19 +1874,25 @@ static int rtw_hw_scan_update_probe_req(struct rtw_dev *rtwdev,
 					     req->ssids[i].ssid,
 					     req->ssids[i].ssid_len,
 					     req->ie_len);
-		if (!skb)
+		if (!skb) {
+			ret = -ENOMEM;
 			goto out;
-		rtw_append_probe_req_ie(rtwdev, skb, &list, rtwvif);
+		}
+		ret = rtw_append_probe_req_ie(rtwdev, skb, &list, &bands,
+					      rtwvif);
+		if (ret)
+			goto out;
+
 		kfree_skb(skb);
 	}
 
-	return _rtw_hw_scan_update_probe_req(rtwdev, num, &list);
+	return _rtw_hw_scan_update_probe_req(rtwdev, num * bands, &list);
 
 out:
 	skb_queue_walk(&list, skb)
 		kfree_skb(skb);
 
-	return -ENOMEM;
+	return ret;
 }
 
 static int rtw_add_chan_info(struct rtw_dev *rtwdev, struct rtw_chan_info *info,
-- 
2.25.1

