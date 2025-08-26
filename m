Return-Path: <linux-wireless+bounces-26618-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D23B357AE
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 10:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C10744E3F0D
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 08:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C6F2FCC1D;
	Tue, 26 Aug 2025 08:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="FFbUhHZ2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AC02FC891
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 08:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756198401; cv=none; b=MaDbjA6DKN4NgYMAzzbsvdTzv4a2ombQy1Oo2mq8OXq0OBY3NlY4grKJLdx85KdLqssFU05VPb+tlc2xcAzGXBO/2l9vOIi+AdrtrIPqbxkxgWEG6YESPUl4hxCG6dDr6do8i7tKDqFJQSpOI/SpKvoO1m/RpRTJYuVwMxeK1HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756198401; c=relaxed/simple;
	bh=SEaZYWq8Lx81fl8Phg5391v5m+zy86IwaOxW2+e5lk4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IOPg2RG2H8v7d9HxFUD2K+sC8Lo3a0Nv8JpWQFR7J+uEL37VZ6hGtcBIAg7PJOidK8ndodh6CFBazZCNXADS5sKAqpjtm0iK3Wtk2KrdRZ/jaT6hyldsdOQq6OyCkzSj52my8bNyw0OetUxv2xuguUx9LDTWUdHvCNupCQQCj78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=FFbUhHZ2; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57Q8rGJu91261959, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1756198396; bh=FErBu0PBnU4GS2RhLd2ejzZuFKtmCRuvd2faH1rKILA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=FFbUhHZ2JemwQBhVi6T7ExtiLqZ/t+3u9bPP6+OnbW4Ca0lKVdWT8B55QpwyJutuU
	 ArbL34lpSx012kvnZyWKWAexsFZ+0QvI+0o9LQ+nN5bFXVB5gUqAkrk9HpA3G6wqjA
	 y5fLoix5gv2gOZWpTXSyv7eYT5i1Be4Mq4S09MnIuSRtneseTJLbU9n9Q8T7UCZhJl
	 oZz2j6KI7DIPrlQZFagalG4one8DfWJjUHbkNQYZbPmx3XQoTkAOsL0aEAp68O5jmv
	 OlXLw9BAeun4nK7LE0RYG36LOlXJoCQOb9JOjuG4q2DjBI3i/KcKDWdHdPPw+oZZbG
	 vhj0ohKxrcHHg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57Q8rGJu91261959
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 16:53:16 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 26 Aug 2025 16:53:16 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Tue, 26 Aug
 2025 16:53:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 04/10] wifi: rtw89: pci: add struct rtw89_{tx,rx}_rings to put related fields
Date: Tue, 26 Aug 2025 16:51:46 +0800
Message-ID: <20250826085152.28164-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250826085152.28164-1-pkshih@realtek.com>
References: <20250826085152.28164-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTKEXHMBS06.realtek.com.tw (10.21.1.56)

The new hardware design will expect a continual memory region across
all rings, so a new field will be added to describe the region. To
help the changes, add struct and make changes ahead.

Don't change logic at all.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c    | 48 ++++++++++-----------
 drivers/net/wireless/realtek/rtw89/pci.h    | 12 +++++-
 drivers/net/wireless/realtek/rtw89/pci_be.c |  4 +-
 3 files changed, 36 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index e3fbe43a95ea..d4677df35861 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -134,7 +134,7 @@ static void rtw89_pci_release_fwcmd(struct rtw89_dev *rtwdev,
 static void rtw89_pci_reclaim_tx_fwcmd(struct rtw89_dev *rtwdev,
 				       struct rtw89_pci *rtwpci)
 {
-	struct rtw89_pci_tx_ring *tx_ring = &rtwpci->tx_rings[RTW89_TXCH_CH12];
+	struct rtw89_pci_tx_ring *tx_ring = &rtwpci->tx.rings[RTW89_TXCH_CH12];
 	u32 cnt;
 
 	cnt = rtw89_pci_txbd_recalc(rtwdev, tx_ring);
@@ -440,7 +440,7 @@ static int rtw89_pci_poll_rxq_dma(struct rtw89_dev *rtwdev,
 	int countdown = rtwdev->napi_budget_countdown;
 	u32 cnt;
 
-	rx_ring = &rtwpci->rx_rings[RTW89_RXCH_RXQ];
+	rx_ring = &rtwpci->rx.rings[RTW89_RXCH_RXQ];
 
 	cnt = rtw89_pci_rxbd_recalc(rtwdev, rx_ring);
 	if (!cnt)
@@ -588,7 +588,7 @@ static void rtw89_pci_release_rpp(struct rtw89_dev *rtwdev,
 		return;
 	}
 
-	tx_ring = &rtwpci->tx_rings[txch];
+	tx_ring = &rtwpci->tx.rings[txch];
 	wd_ring = &tx_ring->wd_ring;
 	txwd = &wd_ring->pages[seq];
 
@@ -694,7 +694,7 @@ static int rtw89_pci_poll_rpq_dma(struct rtw89_dev *rtwdev,
 	u32 cnt;
 	int work_done;
 
-	rx_ring = &rtwpci->rx_rings[RTW89_RXCH_RPQ];
+	rx_ring = &rtwpci->rx.rings[RTW89_RXCH_RPQ];
 
 	spin_lock_bh(&rtwpci->trx_lock);
 
@@ -724,7 +724,7 @@ static void rtw89_pci_isr_rxd_unavail(struct rtw89_dev *rtwdev,
 	int i;
 
 	for (i = 0; i < RTW89_RXCH_NUM; i++) {
-		rx_ring = &rtwpci->rx_rings[i];
+		rx_ring = &rtwpci->rx.rings[i];
 		bd_ring = &rx_ring->bd_ring;
 
 		reg_idx = rtw89_read32(rtwdev, bd_ring->addr.idx);
@@ -1139,7 +1139,7 @@ static
 u32 __rtw89_pci_check_and_reclaim_tx_fwcmd_resource(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
-	struct rtw89_pci_tx_ring *tx_ring = &rtwpci->tx_rings[RTW89_TXCH_CH12];
+	struct rtw89_pci_tx_ring *tx_ring = &rtwpci->tx.rings[RTW89_TXCH_CH12];
 	u32 cnt;
 
 	spin_lock_bh(&rtwpci->trx_lock);
@@ -1155,7 +1155,7 @@ u32 __rtw89_pci_check_and_reclaim_tx_resource_noio(struct rtw89_dev *rtwdev,
 						   u8 txch)
 {
 	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
-	struct rtw89_pci_tx_ring *tx_ring = &rtwpci->tx_rings[txch];
+	struct rtw89_pci_tx_ring *tx_ring = &rtwpci->tx.rings[txch];
 	struct rtw89_pci_tx_wd_ring *wd_ring = &tx_ring->wd_ring;
 	u32 cnt;
 
@@ -1172,7 +1172,7 @@ static u32 __rtw89_pci_check_and_reclaim_tx_resource(struct rtw89_dev *rtwdev,
 						     u8 txch)
 {
 	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
-	struct rtw89_pci_tx_ring *tx_ring = &rtwpci->tx_rings[txch];
+	struct rtw89_pci_tx_ring *tx_ring = &rtwpci->tx.rings[txch];
 	struct rtw89_pci_tx_wd_ring *wd_ring = &tx_ring->wd_ring;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	u32 bd_cnt, wd_cnt, min_cnt = 0;
@@ -1180,7 +1180,7 @@ static u32 __rtw89_pci_check_and_reclaim_tx_resource(struct rtw89_dev *rtwdev,
 	enum rtw89_debug_mask debug_mask;
 	u32 cnt;
 
-	rx_ring = &rtwpci->rx_rings[RTW89_RXCH_RPQ];
+	rx_ring = &rtwpci->rx.rings[RTW89_RXCH_RPQ];
 
 	spin_lock_bh(&rtwpci->trx_lock);
 	bd_cnt = rtw89_pci_get_avail_txbd_num(tx_ring);
@@ -1265,7 +1265,7 @@ static void rtw89_pci_tx_bd_ring_update(struct rtw89_dev *rtwdev, struct rtw89_p
 static void rtw89_pci_ops_tx_kick_off(struct rtw89_dev *rtwdev, u8 txch)
 {
 	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
-	struct rtw89_pci_tx_ring *tx_ring = &rtwpci->tx_rings[txch];
+	struct rtw89_pci_tx_ring *tx_ring = &rtwpci->tx.rings[txch];
 
 	if (rtwdev->hci.paused) {
 		set_bit(txch, rtwpci->kick_map);
@@ -1285,7 +1285,7 @@ static void rtw89_pci_tx_kick_off_pending(struct rtw89_dev *rtwdev)
 		if (!test_and_clear_bit(txch, rtwpci->kick_map))
 			continue;
 
-		tx_ring = &rtwpci->tx_rings[txch];
+		tx_ring = &rtwpci->tx.rings[txch];
 		__rtw89_pci_tx_kick_off(rtwdev, tx_ring);
 	}
 }
@@ -1293,7 +1293,7 @@ static void rtw89_pci_tx_kick_off_pending(struct rtw89_dev *rtwdev)
 static void __pci_flush_txch(struct rtw89_dev *rtwdev, u8 txch, bool drop)
 {
 	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
-	struct rtw89_pci_tx_ring *tx_ring = &rtwpci->tx_rings[txch];
+	struct rtw89_pci_tx_ring *tx_ring = &rtwpci->tx.rings[txch];
 	struct rtw89_pci_dma_ring *bd_ring = &tx_ring->bd_ring;
 	u32 cur_idx, cur_rp;
 	u8 i;
@@ -1559,7 +1559,7 @@ static int rtw89_pci_tx_write(struct rtw89_dev *rtwdev, struct rtw89_core_tx_req
 		return -EINVAL;
 	}
 
-	tx_ring = &rtwpci->tx_rings[txch];
+	tx_ring = &rtwpci->tx.rings[txch];
 	spin_lock_bh(&rtwpci->trx_lock);
 
 	n_avail_txbd = rtw89_pci_get_avail_txbd_num(tx_ring);
@@ -1665,7 +1665,7 @@ static void rtw89_pci_reset_trx_rings(struct rtw89_dev *rtwdev)
 		if (info->tx_dma_ch_mask & BIT(i))
 			continue;
 
-		tx_ring = &rtwpci->tx_rings[i];
+		tx_ring = &rtwpci->tx.rings[i];
 		bd_ring = &tx_ring->bd_ring;
 		bd_ram = bd_ram_table ? &bd_ram_table[i] : NULL;
 		addr_num = bd_ring->addr.num;
@@ -1687,7 +1687,7 @@ static void rtw89_pci_reset_trx_rings(struct rtw89_dev *rtwdev)
 	}
 
 	for (i = 0; i < RTW89_RXCH_NUM; i++) {
-		rx_ring = &rtwpci->rx_rings[i];
+		rx_ring = &rtwpci->rx.rings[i];
 		bd_ring = &rx_ring->bd_ring;
 		addr_num = bd_ring->addr.num;
 		addr_idx = bd_ring->addr.idx;
@@ -1736,7 +1736,7 @@ void rtw89_pci_ops_reset(struct rtw89_dev *rtwdev)
 						skb_queue_len(&rtwpci->h2c_queue), true);
 			continue;
 		}
-		rtw89_pci_release_tx_ring(rtwdev, &rtwpci->tx_rings[txch]);
+		rtw89_pci_release_tx_ring(rtwdev, &rtwpci->tx.rings[txch]);
 	}
 	spin_unlock_bh(&rtwpci->trx_lock);
 }
@@ -1812,14 +1812,14 @@ void rtw89_pci_switch_bd_idx_addr(struct rtw89_dev *rtwdev, bool low_power)
 		return;
 
 	for (i = 0; i < RTW89_TXCH_NUM; i++) {
-		tx_ring = &rtwpci->tx_rings[i];
+		tx_ring = &rtwpci->tx.rings[i];
 		tx_ring->bd_ring.addr.idx = low_power ?
 					    bd_idx_addr->tx_bd_addrs[i] :
 					    dma_addr_set->tx[i].idx;
 	}
 
 	for (i = 0; i < RTW89_RXCH_NUM; i++) {
-		rx_ring = &rtwpci->rx_rings[i];
+		rx_ring = &rtwpci->rx.rings[i];
 		rx_ring->bd_ring.addr.idx = low_power ?
 					    bd_idx_addr->rx_bd_addrs[i] :
 					    dma_addr_set->rx[i].idx;
@@ -3272,7 +3272,7 @@ static void rtw89_pci_free_tx_rings(struct rtw89_dev *rtwdev,
 	for (i = 0; i < RTW89_TXCH_NUM; i++) {
 		if (info->tx_dma_ch_mask & BIT(i))
 			continue;
-		tx_ring = &rtwpci->tx_rings[i];
+		tx_ring = &rtwpci->tx.rings[i];
 		rtw89_pci_free_tx_wd_ring(rtwdev, pdev, tx_ring);
 		rtw89_pci_free_tx_ring(rtwdev, pdev, tx_ring);
 	}
@@ -3318,7 +3318,7 @@ static void rtw89_pci_free_rx_rings(struct rtw89_dev *rtwdev,
 	int i;
 
 	for (i = 0; i < RTW89_RXCH_NUM; i++) {
-		rx_ring = &rtwpci->rx_rings[i];
+		rx_ring = &rtwpci->rx.rings[i];
 		rtw89_pci_free_rx_ring(rtwdev, pdev, rx_ring);
 	}
 }
@@ -3470,7 +3470,7 @@ static int rtw89_pci_alloc_tx_rings(struct rtw89_dev *rtwdev,
 	for (i = 0; i < RTW89_TXCH_NUM; i++) {
 		if (info->tx_dma_ch_mask & BIT(i))
 			continue;
-		tx_ring = &rtwpci->tx_rings[i];
+		tx_ring = &rtwpci->tx.rings[i];
 		desc_size = sizeof(struct rtw89_pci_tx_bd_32);
 		len = RTW89_PCI_TXBD_NUM_MAX;
 		ret = rtw89_pci_alloc_tx_ring(rtwdev, pdev, tx_ring,
@@ -3486,7 +3486,7 @@ static int rtw89_pci_alloc_tx_rings(struct rtw89_dev *rtwdev,
 err_free:
 	tx_allocated = i;
 	for (i = 0; i < tx_allocated; i++) {
-		tx_ring = &rtwpci->tx_rings[i];
+		tx_ring = &rtwpci->tx.rings[i];
 		rtw89_pci_free_tx_ring(rtwdev, pdev, tx_ring);
 	}
 
@@ -3588,7 +3588,7 @@ static int rtw89_pci_alloc_rx_rings(struct rtw89_dev *rtwdev,
 	int ret;
 
 	for (i = 0; i < RTW89_RXCH_NUM; i++) {
-		rx_ring = &rtwpci->rx_rings[i];
+		rx_ring = &rtwpci->rx.rings[i];
 		desc_size = sizeof(struct rtw89_pci_rx_bd_32);
 		len = RTW89_PCI_RXBD_NUM_MAX;
 		ret = rtw89_pci_alloc_rx_ring(rtwdev, pdev, rx_ring,
@@ -3604,7 +3604,7 @@ static int rtw89_pci_alloc_rx_rings(struct rtw89_dev *rtwdev,
 err_free:
 	rx_allocated = i;
 	for (i = 0; i < rx_allocated; i++) {
-		rx_ring = &rtwpci->rx_rings[i];
+		rx_ring = &rtwpci->rx.rings[i];
 		rtw89_pci_free_rx_ring(rtwdev, pdev, rx_ring);
 	}
 
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index 6558f60ec914..3156b4f9ebfc 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -1524,6 +1524,10 @@ struct rtw89_pci_tx_ring {
 	u64 tx_mac_id_drop;
 };
 
+struct rtw89_pci_tx_rings {
+	struct rtw89_pci_tx_ring rings[RTW89_TXCH_NUM];
+};
+
 struct rtw89_pci_rx_ring {
 	struct rtw89_pci_dma_ring bd_ring;
 	struct sk_buff *buf[RTW89_PCI_RXBD_NUM_MAX];
@@ -1533,6 +1537,10 @@ struct rtw89_pci_rx_ring {
 	u32 target_rx_tag:13;
 };
 
+struct rtw89_pci_rx_rings {
+	struct rtw89_pci_rx_ring rings[RTW89_RXCH_NUM];
+};
+
 struct rtw89_pci_isrs {
 	u32 ind_isrs;
 	u32 halt_c2h_isrs;
@@ -1550,8 +1558,8 @@ struct rtw89_pci {
 	bool low_power;
 	bool under_recovery;
 	bool enable_dac;
-	struct rtw89_pci_tx_ring tx_rings[RTW89_TXCH_NUM];
-	struct rtw89_pci_rx_ring rx_rings[RTW89_RXCH_NUM];
+	struct rtw89_pci_tx_rings tx;
+	struct rtw89_pci_rx_rings rx;
 	struct sk_buff_head h2c_queue;
 	struct sk_buff_head h2c_release_queue;
 	DECLARE_BITMAP(kick_map, RTW89_TXCH_NUM);
diff --git a/drivers/net/wireless/realtek/rtw89/pci_be.c b/drivers/net/wireless/realtek/rtw89/pci_be.c
index ecfe1b60e847..e4590879b800 100644
--- a/drivers/net/wireless/realtek/rtw89/pci_be.c
+++ b/drivers/net/wireless/realtek/rtw89/pci_be.c
@@ -175,10 +175,10 @@ static void rtw89_pci_clr_idx_all_be(struct rtw89_dev *rtwdev)
 	rtw89_write32(rtwdev, R_BE_RXBD_RWPTR_CLR1_V1,
 		      B_BE_CLR_RXQ0_IDX | B_BE_CLR_RPQ0_IDX);
 
-	rx_ring = &rtwpci->rx_rings[RTW89_RXCH_RXQ];
+	rx_ring = &rtwpci->rx.rings[RTW89_RXCH_RXQ];
 	rtw89_write16(rtwdev, R_BE_RXQ0_RXBD_IDX_V1, rx_ring->bd_ring.len - 1);
 
-	rx_ring = &rtwpci->rx_rings[RTW89_RXCH_RPQ];
+	rx_ring = &rtwpci->rx.rings[RTW89_RXCH_RPQ];
 	rtw89_write16(rtwdev, R_BE_RPQ0_RXBD_IDX_V1, rx_ring->bd_ring.len - 1);
 }
 
-- 
2.25.1


