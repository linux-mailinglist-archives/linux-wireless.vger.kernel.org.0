Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A961A7C128
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2019 14:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfGaMXH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Jul 2019 08:23:07 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:36784 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfGaMXH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Jul 2019 08:23:07 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x6VCMsi5007666, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x6VCMsi5007666
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 31 Jul 2019 20:22:54 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.439.0; Wed, 31 Jul 2019 20:22:54 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>,
        <sgruszka@redhat.com>
Subject: [PATCH v3 1/3] rtw88: allow c2h operation in irq context
Date:   Wed, 31 Jul 2019 20:22:45 +0800
Message-ID: <1564575767-27557-2-git-send-email-yhchuang@realtek.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564575767-27557-1-git-send-email-yhchuang@realtek.com>
References: <1564575767-27557-1-git-send-email-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

Some of the c2h operations are small and can be done
under interrupt context. For the rest that requires
more operations or can go sleep, enqueue onto c2h queue.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
v1 -> v2
    rebase onto the latest wireless-drivers-next
    fixed conflicts in pci.c

v2 -> v3
    no change

 drivers/net/wireless/realtek/rtw88/fw.c  | 27 ++++++++++++++++++++++++---
 drivers/net/wireless/realtek/rtw88/fw.h  |  2 ++
 drivers/net/wireless/realtek/rtw88/pci.c |  6 ++----
 3 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 62847797..3c4dcb7 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -36,9 +36,6 @@ void rtw_fw_c2h_cmd_handle(struct rtw_dev *rtwdev, struct sk_buff *skb)
 	c2h = (struct rtw_c2h_cmd *)(skb->data + pkt_offset);
 	len = skb->len - pkt_offset - 2;
 
-	rtw_dbg(rtwdev, RTW_DBG_FW, "recv C2H, id=0x%02x, seq=0x%02x, len=%d\n",
-		c2h->id, c2h->seq, len);
-
 	switch (c2h->id) {
 	case C2H_HALMAC:
 		rtw_fw_c2h_cmd_handle_ext(rtwdev, skb);
@@ -48,6 +45,30 @@ void rtw_fw_c2h_cmd_handle(struct rtw_dev *rtwdev, struct sk_buff *skb)
 	}
 }
 
+void rtw_fw_c2h_cmd_rx_irqsafe(struct rtw_dev *rtwdev, u32 pkt_offset,
+			       struct sk_buff *skb)
+{
+	struct rtw_c2h_cmd *c2h;
+	u8 len;
+
+	c2h = (struct rtw_c2h_cmd *)(skb->data + pkt_offset);
+	len = skb->len - pkt_offset - 2;
+	*((u32 *)skb->cb) = pkt_offset;
+
+	rtw_dbg(rtwdev, RTW_DBG_FW, "recv C2H, id=0x%02x, seq=0x%02x, len=%d\n",
+		c2h->id, c2h->seq, len);
+
+	switch (c2h->id) {
+	default:
+		/* pass offset for further operation */
+		*((u32 *)skb->cb) = pkt_offset;
+		skb_queue_tail(&rtwdev->c2h_queue, skb);
+		ieee80211_queue_work(rtwdev->hw, &rtwdev->c2h_work);
+		break;
+	}
+}
+EXPORT_SYMBOL(rtw_fw_c2h_cmd_rx_irqsafe);
+
 static void rtw_fw_send_h2c_command(struct rtw_dev *rtwdev,
 				    u8 *h2c)
 {
diff --git a/drivers/net/wireless/realtek/rtw88/fw.h b/drivers/net/wireless/realtek/rtw88/fw.h
index 7034663..67f6cf7 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.h
+++ b/drivers/net/wireless/realtek/rtw88/fw.h
@@ -200,6 +200,8 @@ static inline struct rtw_c2h_cmd *get_c2h_from_skb(struct sk_buff *skb)
 	return (struct rtw_c2h_cmd *)(skb->data + pkt_offset);
 }
 
+void rtw_fw_c2h_cmd_rx_irqsafe(struct rtw_dev *rtwdev, u32 pkt_offset,
+			       struct sk_buff *skb);
 void rtw_fw_c2h_cmd_handle(struct rtw_dev *rtwdev, struct sk_buff *skb);
 void rtw_fw_send_general_info(struct rtw_dev *rtwdev);
 void rtw_fw_send_phydm_info(struct rtw_dev *rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 23dd06a..4776195 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -8,6 +8,7 @@
 #include "pci.h"
 #include "tx.h"
 #include "rx.h"
+#include "fw.h"
 #include "debug.h"
 
 static u32 rtw_pci_tx_queue_idx_addr[] = {
@@ -822,10 +823,7 @@ static void rtw_pci_rx_isr(struct rtw_dev *rtwdev, struct rtw_pci *rtwpci,
 		skb_put_data(new, skb->data, new_len);
 
 		if (pkt_stat.is_c2h) {
-			 /* pass rx_desc & offset for further operation */
-			*((u32 *)new->cb) = pkt_offset;
-			skb_queue_tail(&rtwdev->c2h_queue, new);
-			ieee80211_queue_work(rtwdev->hw, &rtwdev->c2h_work);
+			rtw_fw_c2h_cmd_rx_irqsafe(rtwdev, pkt_offset, new);
 		} else {
 			/* remove rx_desc */
 			skb_pull(new, pkt_offset);
-- 
2.7.4

