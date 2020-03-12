Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3463A182A92
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2020 09:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgCLIJC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Mar 2020 04:09:02 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:59246 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgCLIJC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Mar 2020 04:09:02 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 02C88tFm006449, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 02C88tFm006449
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Mar 2020 16:08:55 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 12 Mar 2020 16:08:55 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 12 Mar 2020 16:08:54 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 5/5] rtw88: kick off TX packets once for higher efficiency
Date:   Thu, 12 Mar 2020 16:08:52 +0800
Message-ID: <20200312080852.16684-6-yhchuang@realtek.com>
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

Driver used to kick off every TX packets, that will waste some
time while we can do better to kick off the TX packets once after
they are all prepared to be transmitted.

For PCI, it uses DMA engine to transfer the SKBs to the device,
and the transition of the state of the DMA engine could be a cost.
Driver can save some time to kick off multiple SKBs once so that
the DMA engine will have only one transition.

So, split rtw_hci_ops::tx() to rtw_hci_ops::tx_write() and
rtw_hci_ops::tx_kick_off() to explicitly kick the SKBs off after
they are written to the prepared buffer. For packets come from
ieee80211_ops::tx(), write one and then kick it off immediately.
For packets queued in TX queue, which come from
ieee80211_ops::wake_tx_queue(), we can dequeue them, write them
to the buffer, and then kick them off together.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/hci.h | 20 ++++--
 drivers/net/wireless/realtek/rtw88/pci.c | 92 +++++++++++++++++-------
 drivers/net/wireless/realtek/rtw88/pci.h |  1 +
 drivers/net/wireless/realtek/rtw88/tx.c  | 77 ++++++++++++++------
 drivers/net/wireless/realtek/rtw88/tx.h  |  2 +-
 5 files changed, 136 insertions(+), 56 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/hci.h b/drivers/net/wireless/realtek/rtw88/hci.h
index cad56389182c..2cba327e6218 100644
--- a/drivers/net/wireless/realtek/rtw88/hci.h
+++ b/drivers/net/wireless/realtek/rtw88/hci.h
@@ -7,9 +7,10 @@
 
 /* ops for PCI, USB and SDIO */
 struct rtw_hci_ops {
-	int (*tx)(struct rtw_dev *rtwdev,
-		  struct rtw_tx_pkt_info *pkt_info,
-		  struct sk_buff *skb);
+	int (*tx_write)(struct rtw_dev *rtwdev,
+			struct rtw_tx_pkt_info *pkt_info,
+			struct sk_buff *skb);
+	void (*tx_kick_off)(struct rtw_dev *rtwdev);
 	int (*setup)(struct rtw_dev *rtwdev);
 	int (*start)(struct rtw_dev *rtwdev);
 	void (*stop)(struct rtw_dev *rtwdev);
@@ -28,11 +29,16 @@ struct rtw_hci_ops {
 	void (*write32)(struct rtw_dev *rtwdev, u32 addr, u32 val);
 };
 
-static inline int rtw_hci_tx(struct rtw_dev *rtwdev,
-			     struct rtw_tx_pkt_info *pkt_info,
-			     struct sk_buff *skb)
+static inline int rtw_hci_tx_write(struct rtw_dev *rtwdev,
+				   struct rtw_tx_pkt_info *pkt_info,
+				   struct sk_buff *skb)
 {
-	return rtwdev->hci.ops->tx(rtwdev, pkt_info, skb);
+	return rtwdev->hci.ops->tx_write(rtwdev, pkt_info, skb);
+}
+
+static inline void rtw_hci_tx_kick_off(struct rtw_dev *rtwdev)
+{
+	return rtwdev->hci.ops->tx_kick_off(rtwdev);
 }
 
 static inline int rtw_hci_setup(struct rtw_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 812944a7b4bd..e37c71495c0d 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -691,9 +691,34 @@ static void rtw_pci_dma_check(struct rtw_dev *rtwdev,
 	rtwpci->rx_tag = (rtwpci->rx_tag + 1) % RX_TAG_MAX;
 }
 
-static int rtw_pci_xmit(struct rtw_dev *rtwdev,
-			struct rtw_tx_pkt_info *pkt_info,
-			struct sk_buff *skb, u8 queue)
+static void rtw_pci_tx_kick_off_queue(struct rtw_dev *rtwdev, u8 queue)
+{
+	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
+	struct rtw_pci_tx_ring *ring;
+	u32 bd_idx;
+
+	ring = &rtwpci->tx_rings[queue];
+	bd_idx = rtw_pci_tx_queue_idx_addr[queue];
+
+	spin_lock_bh(&rtwpci->irq_lock);
+	rtw_pci_deep_ps_leave(rtwdev);
+	rtw_write16(rtwdev, bd_idx, ring->r.wp & TRX_BD_IDX_MASK);
+	spin_unlock_bh(&rtwpci->irq_lock);
+}
+
+static void rtw_pci_tx_kick_off(struct rtw_dev *rtwdev)
+{
+	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
+	u8 queue;
+
+	for (queue = 0; queue < RTK_MAX_TX_QUEUE_NUM; queue++)
+		if (test_and_clear_bit(queue, rtwpci->tx_queued))
+			rtw_pci_tx_kick_off_queue(rtwdev, queue);
+}
+
+static int rtw_pci_tx_write_data(struct rtw_dev *rtwdev,
+				 struct rtw_tx_pkt_info *pkt_info,
+				 struct sk_buff *skb, u8 queue)
 {
 	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
 	struct rtw_chip_info *chip = rtwdev->chip;
@@ -706,7 +731,6 @@ static int rtw_pci_xmit(struct rtw_dev *rtwdev,
 	u32 psb_len;
 	u8 *pkt_desc;
 	struct rtw_pci_tx_buffer_desc *buf_desc;
-	u32 bd_idx;
 
 	ring = &rtwpci->tx_rings[queue];
 
@@ -745,22 +769,17 @@ static int rtw_pci_xmit(struct rtw_dev *rtwdev,
 
 	spin_lock_bh(&rtwpci->irq_lock);
 
-	rtw_pci_deep_ps_leave(rtwdev);
 	skb_queue_tail(&ring->queue, skb);
 
-	/* kick off tx queue */
-	if (queue != RTW_TX_QUEUE_BCN) {
-		if (++ring->r.wp >= ring->r.len)
-			ring->r.wp = 0;
-		bd_idx = rtw_pci_tx_queue_idx_addr[queue];
-		rtw_write16(rtwdev, bd_idx, ring->r.wp & TRX_BD_IDX_MASK);
-	} else {
-		u32 reg_bcn_work;
-
-		reg_bcn_work = rtw_read8(rtwdev, RTK_PCI_TXBD_BCN_WORK);
-		reg_bcn_work |= BIT_PCI_BCNQ_FLAG;
-		rtw_write8(rtwdev, RTK_PCI_TXBD_BCN_WORK, reg_bcn_work);
-	}
+	if (queue == RTW_TX_QUEUE_BCN)
+		goto out_unlock;
+
+	/* update write-index, and kick it off later */
+	set_bit(queue, rtwpci->tx_queued);
+	if (++ring->r.wp >= ring->r.len)
+		ring->r.wp = 0;
+
+out_unlock:
 	spin_unlock_bh(&rtwpci->irq_lock);
 
 	return 0;
@@ -771,36 +790,58 @@ static int rtw_pci_write_data_rsvd_page(struct rtw_dev *rtwdev, u8 *buf,
 {
 	struct sk_buff *skb;
 	struct rtw_tx_pkt_info pkt_info = {0};
+	u8 reg_bcn_work;
+	int ret;
 
 	skb = rtw_tx_write_data_rsvd_page_get(rtwdev, &pkt_info, buf, size);
 	if (!skb)
 		return -ENOMEM;
 
-	return rtw_pci_xmit(rtwdev, &pkt_info, skb, RTW_TX_QUEUE_BCN);
+	ret = rtw_pci_tx_write_data(rtwdev, &pkt_info, skb, RTW_TX_QUEUE_BCN);
+	if (ret) {
+		rtw_err(rtwdev, "failed to write rsvd page data\n");
+		return ret;
+	}
+
+	/* reserved pages go through beacon queue */
+	reg_bcn_work = rtw_read8(rtwdev, RTK_PCI_TXBD_BCN_WORK);
+	reg_bcn_work |= BIT_PCI_BCNQ_FLAG;
+	rtw_write8(rtwdev, RTK_PCI_TXBD_BCN_WORK, reg_bcn_work);
+
+	return 0;
 }
 
 static int rtw_pci_write_data_h2c(struct rtw_dev *rtwdev, u8 *buf, u32 size)
 {
 	struct sk_buff *skb;
 	struct rtw_tx_pkt_info pkt_info = {0};
+	int ret;
 
 	skb = rtw_tx_write_data_h2c_get(rtwdev, &pkt_info, buf, size);
 	if (!skb)
 		return -ENOMEM;
 
-	return rtw_pci_xmit(rtwdev, &pkt_info, skb, RTW_TX_QUEUE_H2C);
+	ret = rtw_pci_tx_write_data(rtwdev, &pkt_info, skb, RTW_TX_QUEUE_H2C);
+	if (ret) {
+		rtw_err(rtwdev, "failed to write h2c data\n");
+		return ret;
+	}
+
+	rtw_pci_tx_kick_off_queue(rtwdev, RTW_TX_QUEUE_H2C);
+
+	return 0;
 }
 
-static int rtw_pci_tx(struct rtw_dev *rtwdev,
-		      struct rtw_tx_pkt_info *pkt_info,
-		      struct sk_buff *skb)
+static int rtw_pci_tx_write(struct rtw_dev *rtwdev,
+			    struct rtw_tx_pkt_info *pkt_info,
+			    struct sk_buff *skb)
 {
 	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
 	struct rtw_pci_tx_ring *ring;
 	u8 queue = rtw_hw_queue_mapping(skb);
 	int ret;
 
-	ret = rtw_pci_xmit(rtwdev, pkt_info, skb, queue);
+	ret = rtw_pci_tx_write_data(rtwdev, pkt_info, skb, queue);
 	if (ret)
 		return ret;
 
@@ -1374,7 +1415,8 @@ static void rtw_pci_destroy(struct rtw_dev *rtwdev, struct pci_dev *pdev)
 }
 
 static struct rtw_hci_ops rtw_pci_ops = {
-	.tx = rtw_pci_tx,
+	.tx_write = rtw_pci_tx_write,
+	.tx_kick_off = rtw_pci_tx_kick_off,
 	.setup = rtw_pci_setup,
 	.start = rtw_pci_start,
 	.stop = rtw_pci_stop,
diff --git a/drivers/net/wireless/realtek/rtw88/pci.h b/drivers/net/wireless/realtek/rtw88/pci.h
index 67b5e2fe2b62..3ac4fb328d31 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.h
+++ b/drivers/net/wireless/realtek/rtw88/pci.h
@@ -208,6 +208,7 @@ struct rtw_pci {
 	bool irq_enabled;
 
 	u16 rx_tag;
+	DECLARE_BITMAP(tx_queued, RTK_MAX_TX_QUEUE_NUM);
 	struct rtw_pci_tx_ring tx_rings[RTK_MAX_TX_QUEUE_NUM];
 	struct rtw_pci_rx_ring rx_rings[RTK_MAX_RX_QUEUE_NUM];
 	u16 link_ctrl;
diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index 0447228e66be..b31eb4d9664b 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -221,7 +221,7 @@ void rtw_tx_report_handle(struct rtw_dev *rtwdev, struct sk_buff *skb)
 
 static void rtw_tx_mgmt_pkt_info_update(struct rtw_dev *rtwdev,
 					struct rtw_tx_pkt_info *pkt_info,
-					struct ieee80211_tx_control *control,
+					struct ieee80211_sta *sta,
 					struct sk_buff *skb)
 {
 	pkt_info->use_rate = true;
@@ -231,10 +231,9 @@ static void rtw_tx_mgmt_pkt_info_update(struct rtw_dev *rtwdev,
 
 static void rtw_tx_data_pkt_info_update(struct rtw_dev *rtwdev,
 					struct rtw_tx_pkt_info *pkt_info,
-					struct ieee80211_tx_control *control,
+					struct ieee80211_sta *sta,
 					struct sk_buff *skb)
 {
-	struct ieee80211_sta *sta = control->sta;
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct rtw_sta_info *si;
@@ -293,7 +292,7 @@ static void rtw_tx_data_pkt_info_update(struct rtw_dev *rtwdev,
 
 void rtw_tx_pkt_info_update(struct rtw_dev *rtwdev,
 			    struct rtw_tx_pkt_info *pkt_info,
-			    struct ieee80211_tx_control *control,
+			    struct ieee80211_sta *sta,
 			    struct sk_buff *skb)
 {
 	struct rtw_chip_info *chip = rtwdev->chip;
@@ -305,15 +304,15 @@ void rtw_tx_pkt_info_update(struct rtw_dev *rtwdev,
 	u8 sec_type = 0;
 	bool bmc;
 
-	if (control->sta) {
-		si = (struct rtw_sta_info *)control->sta->drv_priv;
+	if (sta) {
+		si = (struct rtw_sta_info *)sta->drv_priv;
 		vif = si->vif;
 	}
 
 	if (ieee80211_is_mgmt(fc) || ieee80211_is_nullfunc(fc))
-		rtw_tx_mgmt_pkt_info_update(rtwdev, pkt_info, control, skb);
+		rtw_tx_mgmt_pkt_info_update(rtwdev, pkt_info, sta, skb);
 	else if (ieee80211_is_data(fc))
-		rtw_tx_data_pkt_info_update(rtwdev, pkt_info, control, skb);
+		rtw_tx_data_pkt_info_update(rtwdev, pkt_info, sta, skb);
 
 	if (info->control.hw_key) {
 		struct ieee80211_key_conf *key = info->control.hw_key;
@@ -427,10 +426,16 @@ void rtw_tx(struct rtw_dev *rtwdev,
 	    struct sk_buff *skb)
 {
 	struct rtw_tx_pkt_info pkt_info = {0};
+	int ret;
 
-	rtw_tx_pkt_info_update(rtwdev, &pkt_info, control, skb);
-	if (rtw_hci_tx(rtwdev, &pkt_info, skb))
+	rtw_tx_pkt_info_update(rtwdev, &pkt_info, control->sta, skb);
+	ret = rtw_hci_tx_write(rtwdev, &pkt_info, skb);
+	if (ret) {
+		rtw_err(rtwdev, "failed to write TX skb to HCI\n");
 		goto out;
+	}
+
+	rtw_hci_tx_kick_off(rtwdev);
 
 	return;
 
@@ -470,37 +475,61 @@ static void rtw_txq_check_agg(struct rtw_dev *rtwdev,
 	ieee80211_queue_work(rtwdev->hw, &rtwdev->ba_work);
 }
 
-static bool rtw_txq_dequeue(struct rtw_dev *rtwdev,
-			    struct rtw_txq *rtwtxq)
+static int rtw_txq_push_skb(struct rtw_dev *rtwdev,
+			    struct rtw_txq *rtwtxq,
+			    struct sk_buff *skb)
 {
 	struct ieee80211_txq *txq = rtwtxq_to_txq(rtwtxq);
-	struct ieee80211_tx_control control;
-	struct sk_buff *skb;
-
-	skb = ieee80211_tx_dequeue(rtwdev->hw, txq);
-	if (!skb)
-		return false;
+	struct rtw_tx_pkt_info pkt_info = {0};
+	int ret;
 
 	rtw_txq_check_agg(rtwdev, rtwtxq, skb);
 
-	control.sta = txq->sta;
-	rtw_tx(rtwdev, &control, skb);
+	rtw_tx_pkt_info_update(rtwdev, &pkt_info, txq->sta, skb);
+	ret = rtw_hci_tx_write(rtwdev, &pkt_info, skb);
+	if (ret) {
+		rtw_err(rtwdev, "failed to write TX skb to HCI\n");
+		return ret;
+	}
 	rtwtxq->last_push = jiffies;
 
-	return true;
+	return 0;
+}
+
+static struct sk_buff *rtw_txq_dequeue(struct rtw_dev *rtwdev,
+				       struct rtw_txq *rtwtxq)
+{
+	struct ieee80211_txq *txq = rtwtxq_to_txq(rtwtxq);
+	struct sk_buff *skb;
+
+	skb = ieee80211_tx_dequeue(rtwdev->hw, txq);
+	if (!skb)
+		return NULL;
+
+	return skb;
 }
 
 static void rtw_txq_push(struct rtw_dev *rtwdev,
 			 struct rtw_txq *rtwtxq,
 			 unsigned long frames)
 {
+	struct sk_buff *skb;
+	int ret;
 	int i;
 
 	rcu_read_lock();
 
-	for (i = 0; i < frames; i++)
-		if (!rtw_txq_dequeue(rtwdev, rtwtxq))
+	for (i = 0; i < frames; i++) {
+		skb = rtw_txq_dequeue(rtwdev, rtwtxq);
+		if (!skb)
+			break;
+
+		ret = rtw_txq_push_skb(rtwdev, rtwtxq, skb);
+		if (ret) {
+			rtw_err(rtwdev, "failed to pusk skb, ret %d\n", ret);
 			break;
+		}
+	}
 
 	rcu_read_unlock();
 }
@@ -523,6 +552,8 @@ void rtw_tx_tasklet(unsigned long data)
 		list_del_init(&rtwtxq->list);
 	}
 
+	rtw_hci_tx_kick_off(rtwdev);
+
 	spin_unlock_bh(&rtwdev->txq_lock);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw88/tx.h b/drivers/net/wireless/realtek/rtw88/tx.h
index e8e7756866b1..e488a2643eb3 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.h
+++ b/drivers/net/wireless/realtek/rtw88/tx.h
@@ -85,7 +85,7 @@ void rtw_txq_cleanup(struct rtw_dev *rtwdev, struct ieee80211_txq *txq);
 void rtw_tx_tasklet(unsigned long data);
 void rtw_tx_pkt_info_update(struct rtw_dev *rtwdev,
 			    struct rtw_tx_pkt_info *pkt_info,
-			    struct ieee80211_tx_control *control,
+			    struct ieee80211_sta *sta,
 			    struct sk_buff *skb);
 void rtw_tx_fill_tx_desc(struct rtw_tx_pkt_info *pkt_info, struct sk_buff *skb);
 void rtw_tx_report_enqueue(struct rtw_dev *rtwdev, struct sk_buff *skb, u8 sn);
-- 
2.17.1

