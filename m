Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1EFF182A90
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2020 09:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgCLIJC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Mar 2020 04:09:02 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:59245 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgCLIJB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Mar 2020 04:09:01 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 02C88sBw006400, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 02C88sBw006400
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Mar 2020 16:08:54 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 12 Mar 2020 16:08:54 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 12 Mar 2020 16:08:54 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 2/5] rtw88: extract alloc rsvd_page and h2c skb routines
Date:   Thu, 12 Mar 2020 16:08:49 +0800
Message-ID: <20200312080852.16684-3-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200312080852.16684-1-yhchuang@realtek.com>
References: <20200312080852.16684-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

Extract skb allocation routines for rsvd_page and h2c.
These routines should also be used by USB and SDIO.

This should not change the logic at all.
memset() for pkt_info is unnecessary, just declare as {0}.
Also skb_put()/memcpy() can be replaced by skb_put_data().

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/pci.c | 27 ++----------
 drivers/net/wireless/realtek/rtw88/tx.c  | 54 ++++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/tx.h  |  8 ++++
 3 files changed, 66 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index b1f14d1fa2b3..c0fd579d9551 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -760,43 +760,24 @@ static int rtw_pci_write_data_rsvd_page(struct rtw_dev *rtwdev, u8 *buf,
 					u32 size)
 {
 	struct sk_buff *skb;
-	struct rtw_tx_pkt_info pkt_info;
-	u32 tx_pkt_desc_sz;
-	u32 length;
+	struct rtw_tx_pkt_info pkt_info = {0};
 
-	tx_pkt_desc_sz = rtwdev->chip->tx_pkt_desc_sz;
-	length = size + tx_pkt_desc_sz;
-	skb = dev_alloc_skb(length);
+	skb = rtw_tx_write_data_rsvd_page_get(rtwdev, &pkt_info, buf, size);
 	if (!skb)
 		return -ENOMEM;
 
-	skb_reserve(skb, tx_pkt_desc_sz);
-	memcpy((u8 *)skb_put(skb, size), buf, size);
-	memset(&pkt_info, 0, sizeof(pkt_info));
-	pkt_info.tx_pkt_size = size;
-	pkt_info.offset = tx_pkt_desc_sz;
-
 	return rtw_pci_xmit(rtwdev, &pkt_info, skb, RTW_TX_QUEUE_BCN);
 }
 
 static int rtw_pci_write_data_h2c(struct rtw_dev *rtwdev, u8 *buf, u32 size)
 {
 	struct sk_buff *skb;
-	struct rtw_tx_pkt_info pkt_info;
-	u32 tx_pkt_desc_sz;
-	u32 length;
+	struct rtw_tx_pkt_info pkt_info = {0};
 
-	tx_pkt_desc_sz = rtwdev->chip->tx_pkt_desc_sz;
-	length = size + tx_pkt_desc_sz;
-	skb = dev_alloc_skb(length);
+	skb = rtw_tx_write_data_h2c_get(rtwdev, &pkt_info, buf, size);
 	if (!skb)
 		return -ENOMEM;
 
-	skb_reserve(skb, tx_pkt_desc_sz);
-	memcpy((u8 *)skb_put(skb, size), buf, size);
-	memset(&pkt_info, 0, sizeof(pkt_info));
-	pkt_info.tx_pkt_size = size;
-
 	return rtw_pci_xmit(rtwdev, &pkt_info, skb, RTW_TX_QUEUE_H2C);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index 24c39c60c99a..0447228e66be 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -6,6 +6,7 @@
 #include "tx.h"
 #include "fw.h"
 #include "ps.h"
+#include "debug.h"
 
 static
 void rtw_tx_stats(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
@@ -368,6 +369,59 @@ void rtw_rsvd_page_pkt_info_update(struct rtw_dev *rtwdev,
 	pkt_info->ls = true;
 }
 
+struct sk_buff *
+rtw_tx_write_data_rsvd_page_get(struct rtw_dev *rtwdev,
+				struct rtw_tx_pkt_info *pkt_info,
+				u8 *buf, u32 size)
+{
+	struct rtw_chip_info *chip = rtwdev->chip;
+	struct sk_buff *skb;
+	u32 tx_pkt_desc_sz;
+	u32 length;
+
+	tx_pkt_desc_sz = chip->tx_pkt_desc_sz;
+	length = size + tx_pkt_desc_sz;
+	skb = dev_alloc_skb(length);
+	if (!skb) {
+		rtw_err(rtwdev, "failed to alloc write data rsvd page skb\n");
+		return NULL;
+	}
+
+	skb_reserve(skb, tx_pkt_desc_sz);
+	skb_put_data(skb, buf, size);
+	pkt_info->tx_pkt_size = size;
+	pkt_info->offset = tx_pkt_desc_sz;
+
+	return skb;
+}
+EXPORT_SYMBOL(rtw_tx_write_data_rsvd_page_get);
+
+struct sk_buff *
+rtw_tx_write_data_h2c_get(struct rtw_dev *rtwdev,
+			  struct rtw_tx_pkt_info *pkt_info,
+			  u8 *buf, u32 size)
+{
+	struct rtw_chip_info *chip = rtwdev->chip;
+	struct sk_buff *skb;
+	u32 tx_pkt_desc_sz;
+	u32 length;
+
+	tx_pkt_desc_sz = chip->tx_pkt_desc_sz;
+	length = size + tx_pkt_desc_sz;
+	skb = dev_alloc_skb(length);
+	if (!skb) {
+		rtw_err(rtwdev, "failed to alloc write data h2c skb\n");
+		return NULL;
+	}
+
+	skb_reserve(skb, tx_pkt_desc_sz);
+	skb_put_data(skb, buf, size);
+	pkt_info->tx_pkt_size = size;
+
+	return skb;
+}
+EXPORT_SYMBOL(rtw_tx_write_data_h2c_get);
+
 void rtw_tx(struct rtw_dev *rtwdev,
 	    struct ieee80211_tx_control *control,
 	    struct sk_buff *skb)
diff --git a/drivers/net/wireless/realtek/rtw88/tx.h b/drivers/net/wireless/realtek/rtw88/tx.h
index 9ca4f74a501b..e8e7756866b1 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.h
+++ b/drivers/net/wireless/realtek/rtw88/tx.h
@@ -93,5 +93,13 @@ void rtw_tx_report_handle(struct rtw_dev *rtwdev, struct sk_buff *skb);
 void rtw_rsvd_page_pkt_info_update(struct rtw_dev *rtwdev,
 				   struct rtw_tx_pkt_info *pkt_info,
 				   struct sk_buff *skb);
+struct sk_buff *
+rtw_tx_write_data_rsvd_page_get(struct rtw_dev *rtwdev,
+				struct rtw_tx_pkt_info *pkt_info,
+				u8 *buf, u32 size);
+struct sk_buff *
+rtw_tx_write_data_h2c_get(struct rtw_dev *rtwdev,
+			  struct rtw_tx_pkt_info *pkt_info,
+			  u8 *buf, u32 size);
 
 #endif
-- 
2.17.1

