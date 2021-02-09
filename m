Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B977314942
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Feb 2021 08:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhBIHKW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Feb 2021 02:10:22 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:35176 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhBIHKS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Feb 2021 02:10:18 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 11979WigC006624, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 11979WigC006624
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 9 Feb 2021 15:09:32 +0800
Received: from localhost (172.21.69.213) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 9 Feb 2021
 15:09:31 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <phhuang@realtek.com>
Subject: [PATCH v5 3/8] rtw88: add napi support
Date:   Tue, 9 Feb 2021 15:07:50 +0800
Message-ID: <20210209070755.23019-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210209070755.23019-1-pkshih@realtek.com>
References: <20210209070755.23019-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.213]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Po-Hao Huang <phhuang@realtek.com>

Use napi to reduce overhead on rx interrupts.

Driver used to interrupt kernel for every Rx packet, this could
affect both system and network performance. NAPI is a mechanism that
uses polling when processing huge amount of traffic, by doing this
the number of interrupts can be decreased.

Network performance can also benefit from this patch. Since TCP
connection is bidirectional and acks are required for every several
packets. These ack packets occupie the PCI bus bandwidth and could
lead to performance degradation.

When napi is used, GRO receive is enabled by default in the mac80211
stack. So mac80211 won't pass every RX TCP packets to the kernel TCP
network stack immediately. Instead an aggregated large length TCP packet
will be delivered.

This reduces the tx acks sent and gains rx performance. After the patch,
the Rx throughput increases about 25Mbps in 11ac.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.h |   1 +
 drivers/net/wireless/realtek/rtw88/pci.c  | 154 ++++++++++++++++++----
 drivers/net/wireless/realtek/rtw88/pci.h  |  14 +-
 3 files changed, 145 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 296a9b4da4fd..bc2702f73995 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -16,6 +16,7 @@
 
 #include "util.h"
 
+#define RTW_NAPI_WEIGHT_NUM		64
 #define RTW_MAX_MAC_ID_NUM		32
 #define RTW_MAX_SEC_CAM_NUM		32
 #define MAX_PG_CAM_BACKUP_NUM		8
diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 676d861aaf99..786a48649946 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -488,13 +488,14 @@ static void rtw_pci_reset_trx_ring(struct rtw_dev *rtwdev)
 }
 
 static void rtw_pci_enable_interrupt(struct rtw_dev *rtwdev,
-				     struct rtw_pci *rtwpci)
+				     struct rtw_pci *rtwpci, bool exclude_rx)
 {
 	unsigned long flags;
+	u32 imr0_unmask = exclude_rx ? IMR_ROK : 0;
 
 	spin_lock_irqsave(&rtwpci->hwirq_lock, flags);
 
-	rtw_write32(rtwdev, RTK_PCI_HIMR0, rtwpci->irq_mask[0]);
+	rtw_write32(rtwdev, RTK_PCI_HIMR0, rtwpci->irq_mask[0] & ~imr0_unmask);
 	rtw_write32(rtwdev, RTK_PCI_HIMR1, rtwpci->irq_mask[1]);
 	if (rtw_chip_wcpu_11ac(rtwdev))
 		rtw_write32(rtwdev, RTK_PCI_HIMR3, rtwpci->irq_mask[3]);
@@ -555,14 +556,37 @@ static void rtw_pci_dma_release(struct rtw_dev *rtwdev, struct rtw_pci *rtwpci)
 	}
 }
 
+static void rtw_pci_napi_start(struct rtw_dev *rtwdev)
+{
+	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
+
+	if (test_and_set_bit(RTW_PCI_FLAG_NAPI_RUNNING, rtwpci->flags))
+		return;
+
+	napi_enable(&rtwpci->napi);
+}
+
+static void rtw_pci_napi_stop(struct rtw_dev *rtwdev)
+{
+	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
+
+	if (!test_and_clear_bit(RTW_PCI_FLAG_NAPI_RUNNING, rtwpci->flags))
+		return;
+
+	napi_synchronize(&rtwpci->napi);
+	napi_disable(&rtwpci->napi);
+}
+
 static int rtw_pci_start(struct rtw_dev *rtwdev)
 {
 	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
 
 	spin_lock_bh(&rtwpci->irq_lock);
-	rtw_pci_enable_interrupt(rtwdev, rtwpci);
+	rtw_pci_enable_interrupt(rtwdev, rtwpci, false);
 	spin_unlock_bh(&rtwpci->irq_lock);
 
+	rtw_pci_napi_start(rtwdev);
+
 	return 0;
 }
 
@@ -570,6 +594,8 @@ static void rtw_pci_stop(struct rtw_dev *rtwdev)
 {
 	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
 
+	rtw_pci_napi_stop(rtwdev);
+
 	spin_lock_bh(&rtwpci->irq_lock);
 	rtw_pci_disable_interrupt(rtwdev, rtwpci);
 	rtw_pci_dma_release(rtwdev, rtwpci);
@@ -935,16 +961,43 @@ static void rtw_pci_tx_isr(struct rtw_dev *rtwdev, struct rtw_pci *rtwpci,
 	ring->r.rp = cur_rp;
 }
 
-static void rtw_pci_rx_isr(struct rtw_dev *rtwdev, struct rtw_pci *rtwpci,
-			   u8 hw_queue)
+static void rtw_pci_rx_isr(struct rtw_dev *rtwdev)
+{
+	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
+	struct napi_struct *napi = &rtwpci->napi;
+
+	napi_schedule(napi);
+}
+
+static int rtw_pci_get_hw_rx_ring_nr(struct rtw_dev *rtwdev,
+				     struct rtw_pci *rtwpci)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_pci_rx_ring *ring;
+	int count = 0;
+	u32 tmp, cur_wp;
+
+	ring = &rtwpci->rx_rings[RTW_RX_QUEUE_MPDU];
+	tmp = rtw_read32(rtwdev, RTK_PCI_RXBD_IDX_MPDUQ);
+	cur_wp = u32_get_bits(tmp, TRX_BD_HW_IDX_MASK);
+	if (cur_wp >= ring->r.wp)
+		count = cur_wp - ring->r.wp;
+	else
+		count = ring->r.len - (ring->r.wp - cur_wp);
+
+	return count;
+}
+
+static u32 rtw_pci_rx_napi(struct rtw_dev *rtwdev, struct rtw_pci *rtwpci,
+			   u8 hw_queue, u32 limit)
+{
+	struct rtw_chip_info *chip = rtwdev->chip;
+	struct napi_struct *napi = &rtwpci->napi;
+	struct rtw_pci_rx_ring *ring = &rtwpci->rx_rings[RTW_RX_QUEUE_MPDU];
 	struct rtw_rx_pkt_stat pkt_stat;
 	struct ieee80211_rx_status rx_status;
 	struct sk_buff *skb, *new;
-	u32 cur_wp, cur_rp, tmp;
-	u32 count;
+	u32 cur_rp = ring->r.rp;
+	u32 count, rx_done = 0;
 	u32 pkt_offset;
 	u32 pkt_desc_sz = chip->rx_pkt_desc_sz;
 	u32 buf_desc_sz = chip->rx_buf_desc_sz;
@@ -952,17 +1005,9 @@ static void rtw_pci_rx_isr(struct rtw_dev *rtwdev, struct rtw_pci *rtwpci,
 	u8 *rx_desc;
 	dma_addr_t dma;
 
-	ring = &rtwpci->rx_rings[RTW_RX_QUEUE_MPDU];
+	count = rtw_pci_get_hw_rx_ring_nr(rtwdev, rtwpci);
+	count = min(count, limit);
 
-	tmp = rtw_read32(rtwdev, RTK_PCI_RXBD_IDX_MPDUQ);
-	cur_wp = tmp >> 16;
-	cur_wp &= TRX_BD_IDX_MASK;
-	if (cur_wp >= ring->r.wp)
-		count = cur_wp - ring->r.wp;
-	else
-		count = ring->r.len - (ring->r.wp - cur_wp);
-
-	cur_rp = ring->r.rp;
 	while (count--) {
 		rtw_pci_dma_check(rtwdev, ring, cur_rp);
 		skb = ring->buf[cur_rp];
@@ -995,7 +1040,8 @@ static void rtw_pci_rx_isr(struct rtw_dev *rtwdev, struct rtw_pci *rtwpci,
 
 			rtw_rx_stats(rtwdev, pkt_stat.vif, new);
 			memcpy(new->cb, &rx_status, sizeof(rx_status));
-			ieee80211_rx_irqsafe(rtwdev->hw, new);
+			ieee80211_rx_napi(rtwdev->hw, NULL, new, napi);
+			rx_done++;
 		}
 
 next_rp:
@@ -1009,8 +1055,13 @@ static void rtw_pci_rx_isr(struct rtw_dev *rtwdev, struct rtw_pci *rtwpci,
 	}
 
 	ring->r.rp = cur_rp;
-	ring->r.wp = cur_wp;
+	/* 'rp', the last position we have read, is seen as previous posistion
+	 * of 'wp' that is used to calculate 'count' next time.
+	 */
+	ring->r.wp = cur_rp;
 	rtw_write16(rtwdev, RTK_PCI_RXBD_IDX_MPDUQ, ring->r.rp);
+
+	return rx_done;
 }
 
 static void rtw_pci_irq_recognized(struct rtw_dev *rtwdev,
@@ -1060,6 +1111,7 @@ static irqreturn_t rtw_pci_interrupt_threadfn(int irq, void *dev)
 	struct rtw_dev *rtwdev = dev;
 	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
 	u32 irq_status[4];
+	bool rx = false;
 
 	spin_lock_bh(&rtwpci->irq_lock);
 	rtw_pci_irq_recognized(rtwdev, rtwpci, irq_status);
@@ -1078,13 +1130,15 @@ static irqreturn_t rtw_pci_interrupt_threadfn(int irq, void *dev)
 		rtw_pci_tx_isr(rtwdev, rtwpci, RTW_TX_QUEUE_VI);
 	if (irq_status[3] & IMR_H2CDOK)
 		rtw_pci_tx_isr(rtwdev, rtwpci, RTW_TX_QUEUE_H2C);
-	if (irq_status[0] & IMR_ROK)
-		rtw_pci_rx_isr(rtwdev, rtwpci, RTW_RX_QUEUE_MPDU);
+	if (irq_status[0] & IMR_ROK) {
+		rtw_pci_rx_isr(rtwdev);
+		rx = true;
+	}
 	if (unlikely(irq_status[0] & IMR_C2HCMD))
 		rtw_fw_c2h_cmd_isr(rtwdev);
 
 	/* all of the jobs for this interrupt have been done */
-	rtw_pci_enable_interrupt(rtwdev, rtwpci);
+	rtw_pci_enable_interrupt(rtwdev, rtwpci, rx);
 	spin_unlock_bh(&rtwpci->irq_lock);
 
 	return IRQ_HANDLED;
@@ -1485,6 +1539,56 @@ static void rtw_pci_free_irq(struct rtw_dev *rtwdev, struct pci_dev *pdev)
 	pci_free_irq_vectors(pdev);
 }
 
+static int rtw_pci_napi_poll(struct napi_struct *napi, int budget)
+{
+	struct rtw_pci *rtwpci = container_of(napi, struct rtw_pci, napi);
+	struct rtw_dev *rtwdev = container_of((void *)rtwpci, struct rtw_dev,
+					      priv);
+	int work_done = 0;
+
+	while (work_done < budget) {
+		u32 work_done_once;
+
+		work_done_once = rtw_pci_rx_napi(rtwdev, rtwpci, RTW_RX_QUEUE_MPDU,
+						 budget - work_done);
+		if (work_done_once == 0)
+			break;
+		work_done += work_done_once;
+	}
+	if (work_done < budget) {
+		napi_complete_done(napi, work_done);
+		spin_lock_bh(&rtwpci->irq_lock);
+		rtw_pci_enable_interrupt(rtwdev, rtwpci, false);
+		spin_unlock_bh(&rtwpci->irq_lock);
+		/* When ISR happens during polling and before napi_complete
+		 * while no further data is received. Data on the dma_ring will
+		 * not be processed immediately. Check whether dma ring is
+		 * empty and perform napi_schedule accordingly.
+		 */
+		if (rtw_pci_get_hw_rx_ring_nr(rtwdev, rtwpci))
+			napi_schedule(napi);
+	}
+
+	return work_done;
+}
+
+static void rtw_pci_napi_init(struct rtw_dev *rtwdev)
+{
+	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
+
+	init_dummy_netdev(&rtwpci->netdev);
+	netif_napi_add(&rtwpci->netdev, &rtwpci->napi, rtw_pci_napi_poll,
+		       RTW_NAPI_WEIGHT_NUM);
+}
+
+static void rtw_pci_napi_deinit(struct rtw_dev *rtwdev)
+{
+	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
+
+	rtw_pci_napi_stop(rtwdev);
+	netif_napi_del(&rtwpci->napi);
+}
+
 int rtw_pci_probe(struct pci_dev *pdev,
 		  const struct pci_device_id *id)
 {
@@ -1527,6 +1631,8 @@ int rtw_pci_probe(struct pci_dev *pdev,
 		goto err_pci_declaim;
 	}
 
+	rtw_pci_napi_init(rtwdev);
+
 	ret = rtw_chip_info_setup(rtwdev);
 	if (ret) {
 		rtw_err(rtwdev, "failed to setup chip information\n");
@@ -1550,6 +1656,7 @@ int rtw_pci_probe(struct pci_dev *pdev,
 	return 0;
 
 err_destroy_pci:
+	rtw_pci_napi_deinit(rtwdev);
 	rtw_pci_destroy(rtwdev, pdev);
 
 err_pci_declaim:
@@ -1579,6 +1686,7 @@ void rtw_pci_remove(struct pci_dev *pdev)
 
 	rtw_unregister_hw(rtwdev, hw);
 	rtw_pci_disable_interrupt(rtwdev, rtwpci);
+	rtw_pci_napi_deinit(rtwdev);
 	rtw_pci_destroy(rtwdev, pdev);
 	rtw_pci_declaim(rtwdev, pdev);
 	rtw_pci_free_irq(rtwdev, pdev);
diff --git a/drivers/net/wireless/realtek/rtw88/pci.h b/drivers/net/wireless/realtek/rtw88/pci.h
index 7cdefe229824..e76fc549a788 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.h
+++ b/drivers/net/wireless/realtek/rtw88/pci.h
@@ -51,6 +51,7 @@
 #define RTK_PCI_RXBD_DESA_MPDUQ	0x338
 
 #define TRX_BD_IDX_MASK		GENMASK(11, 0)
+#define TRX_BD_HW_IDX_MASK	GENMASK(27, 16)
 
 /* BCNQ is specialized for rsvd page, does not need to specify a number */
 #define RTK_PCI_TXBD_NUM_H2CQ	0x1328
@@ -142,6 +143,12 @@
 /* IMR 3 */
 #define IMR_H2CDOK		BIT(16)
 
+enum rtw_pci_flags {
+	RTW_PCI_FLAG_NAPI_RUNNING,
+
+	NUM_OF_RTW_PCI_FLAGS,
+};
+
 /* one element is reserved to know if the ring is closed */
 static inline int avail_desc(u32 wp, u32 rp, u32 len)
 {
@@ -200,16 +207,21 @@ struct rtw_pci {
 
 	/* Used for PCI interrupt. */
 	spinlock_t hwirq_lock;
-	/* Used for PCI TX queueing. */
+	/* Used for PCI TX ring/queueing, and enable INT. */
 	spinlock_t irq_lock;
 	u32 irq_mask[4];
 	bool irq_enabled;
 
+	/* napi structure */
+	struct net_device netdev;
+	struct napi_struct napi;
+
 	u16 rx_tag;
 	DECLARE_BITMAP(tx_queued, RTK_MAX_TX_QUEUE_NUM);
 	struct rtw_pci_tx_ring tx_rings[RTK_MAX_TX_QUEUE_NUM];
 	struct rtw_pci_rx_ring rx_rings[RTK_MAX_RX_QUEUE_NUM];
 	u16 link_ctrl;
+	DECLARE_BITMAP(flags, NUM_OF_RTW_PCI_FLAGS);
 
 	void __iomem *mmap;
 };
-- 
2.21.0

