Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C84443AE728
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jun 2021 12:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhFUKcu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Jun 2021 06:32:50 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:40497 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbhFUKct (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Jun 2021 06:32:49 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 15LAUSJ10005853, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 15LAUSJ10005853
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 21 Jun 2021 18:30:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 21 Jun 2021 18:30:28 +0800
Received: from localhost (172.16.16.17) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 21 Jun
 2021 18:30:27 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <phhuang@realtek.com>
Subject: [PATCH] rtw88: fix c2h memory leak
Date:   Mon, 21 Jun 2021 18:30:23 +0800
Message-ID: <20210621103023.41928-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.17]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/21/2021 09:53:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzYvMjEgpFekyCAwODo0NzowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 06/21/2021 10:01:30
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 164498 [Jun 21 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 448 448 71fb1b37213ce9a885768d4012c46ac449c77b17
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;realtek.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/21/2021 10:03:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Po-Hao Huang <phhuang@realtek.com>

Fix erroneous code that leads to unreferenced objects. During H2C
operations, some functions returned without freeing the memory that only
the function have access to. Release these objects when they're no longer
needed to avoid potentially memory leaks.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c | 8 +++++++-
 drivers/net/wireless/realtek/rtw88/fw.c   | 2 ++
 drivers/net/wireless/realtek/rtw88/main.c | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index cedbf3825848..6ecb01294ddd 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -591,8 +591,10 @@ void rtw_coex_info_response(struct rtw_dev *rtwdev, struct sk_buff *skb)
 	struct rtw_coex *coex = &rtwdev->coex;
 	u8 *payload = get_payload_from_coex_resp(skb);
 
-	if (payload[0] != COEX_RESP_ACK_BY_WL_FW)
+	if (payload[0] != COEX_RESP_ACK_BY_WL_FW) {
+		dev_kfree_skb_any(skb);
 		return;
+	}
 
 	skb_queue_tail(&coex->queue, skb);
 	wake_up(&coex->wait);
@@ -3523,6 +3525,7 @@ static bool rtw_coex_get_bt_reg(struct rtw_dev *rtwdev,
 
 	payload = get_payload_from_coex_resp(skb);
 	*val = GET_COEX_RESP_BT_REG_VAL(payload);
+	dev_kfree_skb_any(skb);
 
 	return true;
 }
@@ -3543,6 +3546,7 @@ static bool rtw_coex_get_bt_patch_version(struct rtw_dev *rtwdev,
 	payload = get_payload_from_coex_resp(skb);
 	*patch_version = GET_COEX_RESP_BT_PATCH_VER(payload);
 	ret = true;
+	dev_kfree_skb_any(skb);
 
 out:
 	return ret;
@@ -3564,6 +3568,7 @@ static bool rtw_coex_get_bt_supported_version(struct rtw_dev *rtwdev,
 	payload = get_payload_from_coex_resp(skb);
 	*supported_version = GET_COEX_RESP_BT_SUPP_VER(payload);
 	ret = true;
+	dev_kfree_skb_any(skb);
 
 out:
 	return ret;
@@ -3585,6 +3590,7 @@ static bool rtw_coex_get_bt_supported_feature(struct rtw_dev *rtwdev,
 	payload = get_payload_from_coex_resp(skb);
 	*supported_feature = GET_COEX_RESP_BT_SUPP_FEAT(payload);
 	ret = true;
+	dev_kfree_skb_any(skb);
 
 out:
 	return ret;
diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 58f4e47aa96a..d4c92b3de440 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -245,10 +245,12 @@ void rtw_fw_c2h_cmd_rx_irqsafe(struct rtw_dev *rtwdev, u32 pkt_offset,
 		break;
 	case C2H_WLAN_RFON:
 		complete(&rtwdev->lps_leave_check);
+		dev_kfree_skb_any(skb);
 		break;
 	case C2H_SCAN_RESULT:
 		complete(&rtwdev->fw_scan_density);
 		rtw_fw_scan_result(rtwdev, c2h->payload, len);
+		dev_kfree_skb_any(skb);
 		break;
 	default:
 		/* pass offset for further operation */
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 47f4838d0c58..eb961ea6c47f 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1831,6 +1831,7 @@ void rtw_core_deinit(struct rtw_dev *rtwdev)
 	destroy_workqueue(rtwdev->tx_wq);
 	spin_lock_irqsave(&rtwdev->tx_report.q_lock, flags);
 	skb_queue_purge(&rtwdev->tx_report.queue);
+	skb_queue_purge(&rtwdev->coex.queue);
 	spin_unlock_irqrestore(&rtwdev->tx_report.q_lock, flags);
 
 	list_for_each_entry_safe(rsvd_pkt, tmp, &rtwdev->rsvd_page_list,
-- 
2.25.1

