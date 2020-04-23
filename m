Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E3D1B5B70
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2020 14:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgDWMad (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Apr 2020 08:30:33 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:43527 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgDWMad (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Apr 2020 08:30:33 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 03NCUQGW0023101, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 03NCUQGW0023101
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 23 Apr 2020 20:30:26 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 23 Apr 2020 20:30:26 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 23 Apr 2020 20:30:25 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <pkshih@realtek.com>
Subject: [PATCH v2 4/8] rtw88: handle C2H_CCX_TX_RPT to know if packet TX'ed successfully
Date:   Thu, 23 Apr 2020 20:30:18 +0800
Message-ID: <20200423123022.10176-5-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200423123022.10176-1-yhchuang@realtek.com>
References: <20200423123022.10176-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB02.realtek.com.tw (172.21.6.95) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

TX status report of 8723D differs from 8822B/8822C, it uses
C2H_CCX_TX_RPT (0x03) with different format. With sequence number
and TX status, driver can know if certain packet was transmitted
successfully.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c |  6 +++++-
 drivers/net/wireless/realtek/rtw88/fw.h |  7 +++++--
 drivers/net/wireless/realtek/rtw88/tx.c | 11 ++++++++---
 drivers/net/wireless/realtek/rtw88/tx.h |  2 +-
 4 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index dde7823143ea..11fa1fc7f1cb 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -25,7 +25,7 @@ static void rtw_fw_c2h_cmd_handle_ext(struct rtw_dev *rtwdev,
 
 	switch (sub_cmd_id) {
 	case C2H_CCX_RPT:
-		rtw_tx_report_handle(rtwdev, skb);
+		rtw_tx_report_handle(rtwdev, skb, C2H_CCX_RPT);
 		break;
 	default:
 		break;
@@ -142,6 +142,9 @@ void rtw_fw_c2h_cmd_handle(struct rtw_dev *rtwdev, struct sk_buff *skb)
 		goto unlock;
 
 	switch (c2h->id) {
+	case C2H_CCX_TX_RPT:
+		rtw_tx_report_handle(rtwdev, skb, C2H_CCX_TX_RPT);
+		break;
 	case C2H_BT_INFO:
 		rtw_coex_bt_info_notify(rtwdev, c2h->payload, len);
 		break;
@@ -155,6 +158,7 @@ void rtw_fw_c2h_cmd_handle(struct rtw_dev *rtwdev, struct sk_buff *skb)
 		rtw_fw_ra_report_handle(rtwdev, c2h->payload, len);
 		break;
 	default:
+		rtw_dbg(rtwdev, RTW_DBG_FW, "C2H 0x%x isn't handled\n", c2h->id);
 		break;
 	}
 
diff --git a/drivers/net/wireless/realtek/rtw88/fw.h b/drivers/net/wireless/realtek/rtw88/fw.h
index 2933ef741e53..470e1809645a 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.h
+++ b/drivers/net/wireless/realtek/rtw88/fw.h
@@ -26,6 +26,7 @@
 #define FW_START_ADDR_LEGACY		0x1000
 
 enum rtw_c2h_cmd_id {
+	C2H_CCX_TX_RPT = 0x03,
 	C2H_BT_INFO = 0x09,
 	C2H_BT_MP_INFO = 0x0b,
 	C2H_RA_RPT = 0x0c,
@@ -218,8 +219,10 @@ struct rtw_fw_hdr_legacy {
 } __packed;
 
 /* C2H */
-#define GET_CCX_REPORT_SEQNUM(c2h_payload)	(c2h_payload[8] & 0xfc)
-#define GET_CCX_REPORT_STATUS(c2h_payload)	(c2h_payload[9] & 0xc0)
+#define GET_CCX_REPORT_SEQNUM_V0(c2h_payload)	(c2h_payload[6] & 0xfc)
+#define GET_CCX_REPORT_STATUS_V0(c2h_payload)	(c2h_payload[0] & 0xc0)
+#define GET_CCX_REPORT_SEQNUM_V1(c2h_payload)	(c2h_payload[8] & 0xfc)
+#define GET_CCX_REPORT_STATUS_V1(c2h_payload)	(c2h_payload[9] & 0xc0)
 
 #define GET_RA_REPORT_RATE(c2h_payload)		(c2h_payload[0] & 0x7f)
 #define GET_RA_REPORT_SGI(c2h_payload)		((c2h_payload[0] & 0x80) >> 7)
diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index 60989987f67b..79c42118825f 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -196,7 +196,7 @@ static void rtw_tx_report_tx_status(struct rtw_dev *rtwdev,
 	ieee80211_tx_status_irqsafe(rtwdev->hw, skb);
 }
 
-void rtw_tx_report_handle(struct rtw_dev *rtwdev, struct sk_buff *skb)
+void rtw_tx_report_handle(struct rtw_dev *rtwdev, struct sk_buff *skb, int src)
 {
 	struct rtw_tx_report *tx_report = &rtwdev->tx_report;
 	struct rtw_c2h_cmd *c2h;
@@ -207,8 +207,13 @@ void rtw_tx_report_handle(struct rtw_dev *rtwdev, struct sk_buff *skb)
 
 	c2h = get_c2h_from_skb(skb);
 
-	sn = GET_CCX_REPORT_SEQNUM(c2h->payload);
-	st = GET_CCX_REPORT_STATUS(c2h->payload);
+	if (src == C2H_CCX_TX_RPT) {
+		sn = GET_CCX_REPORT_SEQNUM_V0(c2h->payload);
+		st = GET_CCX_REPORT_STATUS_V0(c2h->payload);
+	} else {
+		sn = GET_CCX_REPORT_SEQNUM_V1(c2h->payload);
+		st = GET_CCX_REPORT_STATUS_V1(c2h->payload);
+	}
 
 	spin_lock_irqsave(&tx_report->q_lock, flags);
 	skb_queue_walk_safe(&tx_report->queue, cur, tmp) {
diff --git a/drivers/net/wireless/realtek/rtw88/tx.h b/drivers/net/wireless/realtek/rtw88/tx.h
index b973de0f4dc0..72dfd4059f03 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.h
+++ b/drivers/net/wireless/realtek/rtw88/tx.h
@@ -95,7 +95,7 @@ void rtw_tx_pkt_info_update(struct rtw_dev *rtwdev,
 			    struct sk_buff *skb);
 void rtw_tx_fill_tx_desc(struct rtw_tx_pkt_info *pkt_info, struct sk_buff *skb);
 void rtw_tx_report_enqueue(struct rtw_dev *rtwdev, struct sk_buff *skb, u8 sn);
-void rtw_tx_report_handle(struct rtw_dev *rtwdev, struct sk_buff *skb);
+void rtw_tx_report_handle(struct rtw_dev *rtwdev, struct sk_buff *skb, int src);
 void rtw_rsvd_page_pkt_info_update(struct rtw_dev *rtwdev,
 				   struct rtw_tx_pkt_info *pkt_info,
 				   struct sk_buff *skb);
-- 
2.17.1

