Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5EB2F7535
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Jan 2021 10:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbhAOJZ6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Jan 2021 04:25:58 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:53903 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbhAOJZ6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Jan 2021 04:25:58 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 10F9PCaP4001209, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 10F9PCaP4001209
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 15 Jan 2021 17:25:12 +0800
Received: from localhost (172.21.69.213) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 15 Jan
 2021 17:25:12 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <phhuang@realtek.com>
Subject: [PATCH v4 3/8] rtw88: add napi support
Date:   Fri, 15 Jan 2021 17:24:00 +0800
Message-ID: <20210115092405.8081-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210115092405.8081-1-pkshih@realtek.com>
References: <20210115092405.8081-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.213]
X-ClientProxiedBy: RTEXMBS01.realtek.com.tw (172.21.6.94) To
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
 drivers/net/wireless/realtek/rtw88/pci.c  | 108 +++++++++++++++++++---
 drivers/net/wireless/realtek/rtw88/pci.h  |   5 +
 3 files changed, 100 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 4b5da1247d66..628a62007629 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -16,6 +16,7 @@
 
 #include "util.h"
 
+#define RTW_NAPI_WEIGHT_NUM		32
 #define RTW_MAX_MAC_ID_NUM		32
 #define RTW_MAX_SEC_CAM_NUM		32
 #define MAX_PG_CAM_BACKUP_NUM		8
diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 676d861aaf99..167bd5d009ee 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -935,16 +935,49 @@ static void rtw_pci_tx_isr(struct rtw_dev *rtwdev, struct rtw_pci *rtwpci,
 	ring->r.rp = cur_rp;
 }
 
-static void rtw_pci_rx_isr(struct rtw_dev *rtwdev, struct rtw_pci *rtwpci,
+static void rtw_pci_rx_isr(struct rtw_dev *rtwdev)
+{
+	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
+	struct napi_struct *napi = &rtwpci->napi;
+
+	napi_schedule(napi);
+}
+
+static int rtw_pci_get_hw_rx_ring_nr(struct rtw_dev *rtwdev,
+				     struct rtw_pci *rtwpci,
+				     u32 *rp, u32 *wp)
+{
+	struct rtw_pci_rx_ring *ring;
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
+	if (rp)
+		*rp = ring->r.rp;
+	if (wp)
+		*wp = cur_wp;
+
+	return count;
+}
+
+static u32 rtw_pci_rx_napi(struct rtw_dev *rtwdev, struct rtw_pci *rtwpci,
 			   u8 hw_queue)
 {
 	struct rtw_chip_info *chip = rtwdev->chip;
+	struct napi_struct *napi = &rtwpci->napi;
 	struct rtw_pci_rx_ring *ring;
 	struct rtw_rx_pkt_stat pkt_stat;
 	struct ieee80211_rx_status rx_status;
 	struct sk_buff *skb, *new;
-	u32 cur_wp, cur_rp, tmp;
-	u32 count;
+	u32 cur_wp, cur_rp;
+	u32 count, rx_done = 0;
 	u32 pkt_offset;
 	u32 pkt_desc_sz = chip->rx_pkt_desc_sz;
 	u32 buf_desc_sz = chip->rx_buf_desc_sz;
@@ -953,16 +986,8 @@ static void rtw_pci_rx_isr(struct rtw_dev *rtwdev, struct rtw_pci *rtwpci,
 	dma_addr_t dma;
 
 	ring = &rtwpci->rx_rings[RTW_RX_QUEUE_MPDU];
+	count = rtw_pci_get_hw_rx_ring_nr(rtwdev, rtwpci, &cur_rp, &cur_wp);
 
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
@@ -995,7 +1020,8 @@ static void rtw_pci_rx_isr(struct rtw_dev *rtwdev, struct rtw_pci *rtwpci,
 
 			rtw_rx_stats(rtwdev, pkt_stat.vif, new);
 			memcpy(new->cb, &rx_status, sizeof(rx_status));
-			ieee80211_rx_irqsafe(rtwdev->hw, new);
+			ieee80211_rx_napi(rtwdev->hw, NULL, new, napi);
+			rx_done++;
 		}
 
 next_rp:
@@ -1011,6 +1037,8 @@ static void rtw_pci_rx_isr(struct rtw_dev *rtwdev, struct rtw_pci *rtwpci,
 	ring->r.rp = cur_rp;
 	ring->r.wp = cur_wp;
 	rtw_write16(rtwdev, RTK_PCI_RXBD_IDX_MPDUQ, ring->r.rp);
+
+	return rx_done;
 }
 
 static void rtw_pci_irq_recognized(struct rtw_dev *rtwdev,
@@ -1079,7 +1107,7 @@ static irqreturn_t rtw_pci_interrupt_threadfn(int irq, void *dev)
 	if (irq_status[3] & IMR_H2CDOK)
 		rtw_pci_tx_isr(rtwdev, rtwpci, RTW_TX_QUEUE_H2C);
 	if (irq_status[0] & IMR_ROK)
-		rtw_pci_rx_isr(rtwdev, rtwpci, RTW_RX_QUEUE_MPDU);
+		rtw_pci_rx_isr(rtwdev);
 	if (unlikely(irq_status[0] & IMR_C2HCMD))
 		rtw_fw_c2h_cmd_isr(rtwdev);
 
@@ -1485,6 +1513,55 @@ static void rtw_pci_free_irq(struct rtw_dev *rtwdev, struct pci_dev *pdev)
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
+		work_done_once = rtw_pci_rx_napi(rtwdev, rtwpci,
+						 RTW_RX_QUEUE_MPDU);
+		if (work_done_once == 0)
+			break;
+		work_done += work_done_once;
+	}
+	if (work_done < budget) {
+		napi_complete_done(napi, work_done);
+		/* When ISR happens during polling and before napi_complete
+		 * while no further data is received. Data on the dma_ring will
+		 * not be processed immediately. Check whether dma ring is
+		 * empty and perform napi_schedule accordingly.
+		 */
+		if (rtw_pci_get_hw_rx_ring_nr(rtwdev, rtwpci, NULL, NULL))
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
+	napi_enable(&rtwpci->napi);
+}
+
+static void rtw_pci_napi_deinit(struct rtw_dev *rtwdev)
+{
+	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
+
+	napi_synchronize(&rtwpci->napi);
+	napi_disable(&rtwpci->napi);
+	netif_napi_del(&rtwpci->napi);
+}
+
 int rtw_pci_probe(struct pci_dev *pdev,
 		  const struct pci_device_id *id)
 {
@@ -1547,6 +1624,8 @@ int rtw_pci_probe(struct pci_dev *pdev,
 		goto err_destroy_pci;
 	}
 
+	rtw_pci_napi_init(rtwdev);
+
 	return 0;
 
 err_destroy_pci:
@@ -1579,6 +1658,7 @@ void rtw_pci_remove(struct pci_dev *pdev)
 
 	rtw_unregister_hw(rtwdev, hw);
 	rtw_pci_disable_interrupt(rtwdev, rtwpci);
+	rtw_pci_napi_deinit(rtwdev);
 	rtw_pci_destroy(rtwdev, pdev);
 	rtw_pci_declaim(rtwdev, pdev);
 	rtw_pci_free_irq(rtwdev, pdev);
diff --git a/drivers/net/wireless/realtek/rtw88/pci.h b/drivers/net/wireless/realtek/rtw88/pci.h
index 7cdefe229824..6d01bbe38d9e 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.h
+++ b/drivers/net/wireless/realtek/rtw88/pci.h
@@ -51,6 +51,7 @@
 #define RTK_PCI_RXBD_DESA_MPDUQ	0x338
 
 #define TRX_BD_IDX_MASK		GENMASK(11, 0)
+#define TRX_BD_HW_IDX_MASK	GENMASK(27, 16)
 
 /* BCNQ is specialized for rsvd page, does not need to specify a number */
 #define RTK_PCI_TXBD_NUM_H2CQ	0x1328
@@ -205,6 +206,10 @@ struct rtw_pci {
 	u32 irq_mask[4];
 	bool irq_enabled;
 
+	/* napi structure */
+	struct net_device netdev;
+	struct napi_struct napi;
+
 	u16 rx_tag;
 	DECLARE_BITMAP(tx_queued, RTK_MAX_TX_QUEUE_NUM);
 	struct rtw_pci_tx_ring tx_rings[RTK_MAX_TX_QUEUE_NUM];
-- 
2.21.0

