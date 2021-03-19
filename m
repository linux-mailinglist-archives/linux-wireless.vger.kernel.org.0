Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100B5341505
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Mar 2021 06:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbhCSFna (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Mar 2021 01:43:30 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:39695 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbhCSFnE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Mar 2021 01:43:04 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 12J5gwpA7007653, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 12J5gwpA7007653
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 19 Mar 2021 13:42:58 +0800
Received: from localhost (172.21.69.146) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 19 Mar
 2021 13:42:58 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <ku920601@realtek.com>,
        <phhuang@realtek.com>, <shaofu@realtek.com>,
        <steventing@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH 1/7] rtw88: add flush hci support
Date:   Fri, 19 Mar 2021 13:42:12 +0800
Message-ID: <20210319054218.3319-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210319054218.3319-1-pkshih@realtek.com>
References: <20210319054218.3319-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.146]
X-ClientProxiedBy: RTEXMBS01.realtek.com.tw (172.21.6.94) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Though mac queue flushing has been supported, sometimes data may be waiting
on interface from host to chip. If it occurs, there may still be data that
flows into mac just after we do flush. To avoid that, we add the hci part
of flushing.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/hci.h      | 16 +++++
 drivers/net/wireless/realtek/rtw88/mac80211.c |  2 +
 drivers/net/wireless/realtek/rtw88/pci.c      | 69 +++++++++++++++++++
 3 files changed, 87 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/hci.h b/drivers/net/wireless/realtek/rtw88/hci.h
index 2cba327e6218..4c6fc6fb3f83 100644
--- a/drivers/net/wireless/realtek/rtw88/hci.h
+++ b/drivers/net/wireless/realtek/rtw88/hci.h
@@ -11,6 +11,7 @@ struct rtw_hci_ops {
 			struct rtw_tx_pkt_info *pkt_info,
 			struct sk_buff *skb);
 	void (*tx_kick_off)(struct rtw_dev *rtwdev);
+	void (*flush_queues)(struct rtw_dev *rtwdev, u32 queues, bool drop);
 	int (*setup)(struct rtw_dev *rtwdev);
 	int (*start)(struct rtw_dev *rtwdev);
 	void (*stop)(struct rtw_dev *rtwdev);
@@ -258,4 +259,19 @@ static inline enum rtw_hci_type rtw_hci_type(struct rtw_dev *rtwdev)
 	return rtwdev->hci.type;
 }
 
+static inline void rtw_hci_flush_queues(struct rtw_dev *rtwdev, u32 queues,
+					bool drop)
+{
+	if (rtwdev->hci.ops->flush_queues)
+		rtwdev->hci.ops->flush_queues(rtwdev, queues, drop);
+}
+
+static inline void rtw_hci_flush_all_queues(struct rtw_dev *rtwdev, bool drop)
+{
+	if (rtwdev->hci.ops->flush_queues)
+		rtwdev->hci.ops->flush_queues(rtwdev,
+					      BIT(rtwdev->hw->queues) - 1,
+					      drop);
+}
+
 #endif
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 2351dfb0d2e2..333df6b38113 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -520,6 +520,7 @@ static int rtw_ops_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 				  hw_key_type, hw_key_idx);
 		break;
 	case DISABLE_KEY:
+		rtw_hci_flush_all_queues(rtwdev, false);
 		rtw_mac_flush_all_queues(rtwdev, false);
 		rtw_sec_clear_cam(rtwdev, sec, key->hw_key_idx);
 		break;
@@ -670,6 +671,7 @@ static void rtw_ops_flush(struct ieee80211_hw *hw,
 	mutex_lock(&rtwdev->mutex);
 	rtw_leave_lps_deep(rtwdev);
 
+	rtw_hci_flush_queues(rtwdev, queues, drop);
 	rtw_mac_flush_queues(rtwdev, queues, drop);
 	mutex_unlock(&rtwdev->mutex);
 }
diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 786a48649946..b8115b31839e 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -671,6 +671,8 @@ static u8 ac_to_hwq[] = {
 	[IEEE80211_AC_BK] = RTW_TX_QUEUE_BK,
 };
 
+static_assert(ARRAY_SIZE(ac_to_hwq) == IEEE80211_NUM_ACS);
+
 static u8 rtw_hw_queue_mapping(struct sk_buff *skb)
 {
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
@@ -727,6 +729,72 @@ static void rtw_pci_dma_check(struct rtw_dev *rtwdev,
 	rtwpci->rx_tag = (rtwpci->rx_tag + 1) % RX_TAG_MAX;
 }
 
+static u32 __pci_get_hw_tx_ring_rp(struct rtw_dev *rtwdev, u8 pci_q)
+{
+	u32 bd_idx_addr = rtw_pci_tx_queue_idx_addr[pci_q];
+	u32 bd_idx = rtw_read16(rtwdev, bd_idx_addr + 2);
+
+	return FIELD_GET(TRX_BD_IDX_MASK, bd_idx);
+}
+
+static void __pci_flush_queue(struct rtw_dev *rtwdev, u8 pci_q, bool drop)
+{
+	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
+	struct rtw_pci_tx_ring *ring = &rtwpci->tx_rings[pci_q];
+	u32 cur_rp;
+	u8 i;
+
+	/* Because the time taked by the I/O in __pci_get_hw_tx_ring_rp is a
+	 * bit dynamic, it's hard to define a reasonable fixed total timeout to
+	 * use read_poll_timeout* helper. Instead, we can ensure a reasonable
+	 * polling times, so we just use for loop with udelay here.
+	 */
+	for (i = 0; i < 30; i++) {
+		cur_rp = __pci_get_hw_tx_ring_rp(rtwdev, pci_q);
+		if (cur_rp == ring->r.wp)
+			return;
+
+		udelay(1);
+	}
+
+	if (!drop)
+		rtw_warn(rtwdev, "timed out to flush pci tx ring[%d]\n", pci_q);
+}
+
+static void __rtw_pci_flush_queues(struct rtw_dev *rtwdev, u32 pci_queues,
+				   bool drop)
+{
+	u8 q;
+
+	for (q = 0; q < RTK_MAX_TX_QUEUE_NUM; q++) {
+		/* It may be not necessary to flush BCN and H2C tx queues. */
+		if (q == RTW_TX_QUEUE_BCN || q == RTW_TX_QUEUE_H2C)
+			continue;
+
+		if (pci_queues & BIT(q))
+			__pci_flush_queue(rtwdev, q, drop);
+	}
+}
+
+static void rtw_pci_flush_queues(struct rtw_dev *rtwdev, u32 queues, bool drop)
+{
+	u32 pci_queues = 0;
+	u8 i;
+
+	/* If all of the hardware queues are requested to flush,
+	 * flush all of the pci queues.
+	 */
+	if (queues == BIT(rtwdev->hw->queues) - 1) {
+		pci_queues = BIT(RTK_MAX_TX_QUEUE_NUM) - 1;
+	} else {
+		for (i = 0; i < rtwdev->hw->queues; i++)
+			if (queues & BIT(i))
+				pci_queues |= BIT(ac_to_hwq[i]);
+	}
+
+	__rtw_pci_flush_queues(rtwdev, pci_queues, drop);
+}
+
 static void rtw_pci_tx_kick_off_queue(struct rtw_dev *rtwdev, u8 queue)
 {
 	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
@@ -1490,6 +1558,7 @@ static void rtw_pci_destroy(struct rtw_dev *rtwdev, struct pci_dev *pdev)
 static struct rtw_hci_ops rtw_pci_ops = {
 	.tx_write = rtw_pci_tx_write,
 	.tx_kick_off = rtw_pci_tx_kick_off,
+	.flush_queues = rtw_pci_flush_queues,
 	.setup = rtw_pci_setup,
 	.start = rtw_pci_start,
 	.stop = rtw_pci_stop,
-- 
2.21.0

