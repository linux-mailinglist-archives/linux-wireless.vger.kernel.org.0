Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0589495A51
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jan 2022 08:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378839AbiAUHIz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Jan 2022 02:08:55 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:44455 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348296AbiAUHIz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Jan 2022 02:08:55 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 20L78iVxA022315, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 20L78iVxA022315
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 21 Jan 2022 15:08:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 21 Jan 2022 15:08:44 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 21 Jan
 2022 15:08:44 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <usama.anjum@collabora.com>,
        <phhuang@realtek.com>
Subject: [PATCH 1/3] rtw88: check for validity before using a pointer
Date:   Fri, 21 Jan 2022 15:08:11 +0800
Message-ID: <20220121070813.9656-2-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Muhammad Usama Anjum <usama.anjum@collabora.com>

ieee80211_probereq_get() can return NULL. Pointer skb should be checked
for validty before use. If it is not valid, list of skbs needs to be
freed.

Fixes: 10d162b2ed39 ("rtw88: 8822c: add ieee80211_ops::hw_scan")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 2f7c036f90221..b56dc43229d28 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -1866,11 +1866,19 @@ static int rtw_hw_scan_update_probe_req(struct rtw_dev *rtwdev,
 					     req->ssids[i].ssid,
 					     req->ssids[i].ssid_len,
 					     req->ie_len);
+		if (!skb)
+			goto out;
 		rtw_append_probe_req_ie(rtwdev, skb, &list, rtwvif);
 		kfree_skb(skb);
 	}
 
 	return _rtw_hw_scan_update_probe_req(rtwdev, num, &list);
+
+out:
+	skb_queue_walk(&list, skb)
+		kfree_skb(skb);
+
+	return -ENOMEM;
 }
 
 static int rtw_add_chan_info(struct rtw_dev *rtwdev, struct rtw_chan_info *info,
-- 
2.25.1

