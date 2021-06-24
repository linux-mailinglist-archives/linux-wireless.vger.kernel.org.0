Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852183B2513
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jun 2021 04:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhFXChb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Jun 2021 22:37:31 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:53874 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhFXChb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Jun 2021 22:37:31 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 15O2Z5Bw8012073, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 15O2Z5Bw8012073
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 24 Jun 2021 10:35:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 24 Jun 2021 10:35:04 +0800
Received: from localhost (172.16.16.17) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 24 Jun
 2021 10:35:03 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <phhuang@realtek.com>
Subject: [PATCH v2] rtw88: fix c2h memory leak
Date:   Thu, 24 Jun 2021 10:34:59 +0800
Message-ID: <20210624023459.10294-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 06/24/2021 02:19:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzYvMjMgpFWkyCAxMDo1NTowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 06/24/2021 02:15:42
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 164592 [Jun 23 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 448 448 71fb1b37213ce9a885768d4012c46ac449c77b17
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;realtek.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/24/2021 02:19:00
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
v2: fix merge conflicts
---
 drivers/net/wireless/realtek/rtw88/coex.c | 11 ++++++++++-
 drivers/net/wireless/realtek/rtw88/fw.c   |  2 ++
 drivers/net/wireless/realtek/rtw88/main.c |  1 +
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index 103e87745be6..2551e228b581 100644
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
@@ -3515,6 +3517,7 @@ static bool rtw_coex_get_bt_reg(struct rtw_dev *rtwdev,
 
 	payload = get_payload_from_coex_resp(skb);
 	*val = GET_COEX_RESP_BT_REG_VAL(payload);
+	dev_kfree_skb_any(skb);
 
 	return true;
 }
@@ -3533,6 +3536,8 @@ static bool rtw_coex_get_bt_patch_version(struct rtw_dev *rtwdev,
 
 	payload = get_payload_from_coex_resp(skb);
 	*patch_version = GET_COEX_RESP_BT_PATCH_VER(payload);
+	dev_kfree_skb_any(skb);
+
 	return true;
 }
 
@@ -3550,6 +3555,8 @@ static bool rtw_coex_get_bt_supported_version(struct rtw_dev *rtwdev,
 
 	payload = get_payload_from_coex_resp(skb);
 	*supported_version = GET_COEX_RESP_BT_SUPP_VER(payload);
+	dev_kfree_skb_any(skb);
+
 	return true;
 }
 
@@ -3567,6 +3574,8 @@ static bool rtw_coex_get_bt_supported_feature(struct rtw_dev *rtwdev,
 
 	payload = get_payload_from_coex_resp(skb);
 	*supported_feature = GET_COEX_RESP_BT_SUPP_FEAT(payload);
+	dev_kfree_skb_any(skb);
+
 	return true;
 }
 
diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 176e8b67530e..3bfa5ecc0053 100644
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
index 4a9a8544e8ca..c6364837e83b 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1899,6 +1899,7 @@ void rtw_core_deinit(struct rtw_dev *rtwdev)
 	destroy_workqueue(rtwdev->tx_wq);
 	spin_lock_irqsave(&rtwdev->tx_report.q_lock, flags);
 	skb_queue_purge(&rtwdev->tx_report.queue);
+	skb_queue_purge(&rtwdev->coex.queue);
 	spin_unlock_irqrestore(&rtwdev->tx_report.q_lock, flags);
 
 	list_for_each_entry_safe(rsvd_pkt, tmp, &rtwdev->rsvd_page_list,
-- 
2.25.1

