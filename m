Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7B44CF190
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Mar 2022 07:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbiCGGG6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Mar 2022 01:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235458AbiCGGG4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Mar 2022 01:06:56 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9E85F266
        for <linux-wireless@vger.kernel.org>; Sun,  6 Mar 2022 22:06:01 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22765qjjE022559, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22765qjjE022559
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 7 Mar 2022 14:05:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 7 Mar 2022 14:05:52 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 7 Mar
 2022 14:05:52 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 04/13] rtw89: pci: use a struct to describe all registers address related to DMA channel
Date:   Mon, 7 Mar 2022 14:04:48 +0800
Message-ID: <20220307060457.56789-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307060457.56789-1-pkshih@realtek.com>
References: <20220307060457.56789-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 03/07/2022 05:48:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvNyCkV6TIIDAzOjQ5OjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We have had a struct rtw89_pci_ch_dma_addr to describe register address,
so use it as regular. Since the addresses should be changed dynamically
according to operating mode, I don't change it to be constant.

These changes don't affect the logic, so I put them in this separated
patch.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c | 35 ++++++++++--------------
 drivers/net/wireless/realtek/rtw89/pci.h |  6 +---
 2 files changed, 15 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 38ad47126848f..e79bfc335b446 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -62,7 +62,7 @@ static u32 rtw89_pci_txbd_recalc(struct rtw89_dev *rtwdev,
 				 struct rtw89_pci_tx_ring *tx_ring)
 {
 	struct rtw89_pci_dma_ring *bd_ring = &tx_ring->bd_ring;
-	u32 addr_idx = bd_ring->addr_idx;
+	u32 addr_idx = bd_ring->addr.idx;
 	u32 cnt, idx;
 
 	idx = rtw89_read32(rtwdev, addr_idx);
@@ -121,7 +121,7 @@ static u32 rtw89_pci_rxbd_recalc(struct rtw89_dev *rtwdev,
 				 struct rtw89_pci_rx_ring *rx_ring)
 {
 	struct rtw89_pci_dma_ring *bd_ring = &rx_ring->bd_ring;
-	u32 addr_idx = bd_ring->addr_idx;
+	u32 addr_idx = bd_ring->addr.idx;
 	u32 cnt, idx;
 
 	idx = rtw89_read32(rtwdev, addr_idx);
@@ -304,7 +304,7 @@ static void rtw89_pci_rxbd_deliver(struct rtw89_dev *rtwdev,
 		cnt -= rx_cnt;
 	}
 
-	rtw89_write16(rtwdev, bd_ring->addr_idx, bd_ring->wp);
+	rtw89_write16(rtwdev, bd_ring->addr.idx, bd_ring->wp);
 }
 
 static int rtw89_pci_poll_rxq_dma(struct rtw89_dev *rtwdev,
@@ -555,7 +555,7 @@ static void rtw89_pci_release_tx(struct rtw89_dev *rtwdev,
 		cnt -= release_cnt;
 	}
 
-	rtw89_write16(rtwdev, bd_ring->addr_idx, bd_ring->wp);
+	rtw89_write16(rtwdev, bd_ring->addr.idx, bd_ring->wp);
 }
 
 static int rtw89_pci_poll_rpq_dma(struct rtw89_dev *rtwdev,
@@ -598,7 +598,7 @@ static void rtw89_pci_isr_rxd_unavail(struct rtw89_dev *rtwdev,
 		rx_ring = &rtwpci->rx_rings[i];
 		bd_ring = &rx_ring->bd_ring;
 
-		reg_idx = rtw89_read32(rtwdev, bd_ring->addr_idx);
+		reg_idx = rtw89_read32(rtwdev, bd_ring->addr.idx);
 		hw_idx = FIELD_GET(TXBD_HW_IDX_MASK, reg_idx);
 		host_idx = FIELD_GET(TXBD_HOST_IDX_MASK, reg_idx);
 		hw_idx_next = (hw_idx + 1) % bd_ring->len;
@@ -876,7 +876,7 @@ static void __rtw89_pci_tx_kick_off(struct rtw89_dev *rtwdev, struct rtw89_pci_t
 	struct rtw89_pci_dma_ring *bd_ring = &tx_ring->bd_ring;
 	u32 host_idx, addr;
 
-	addr = bd_ring->addr_idx;
+	addr = bd_ring->addr.idx;
 	host_idx = bd_ring->wp;
 	rtw89_write16(rtwdev, addr, host_idx);
 }
@@ -918,7 +918,7 @@ static void __pci_flush_txch(struct rtw89_dev *rtwdev, u8 txch, bool drop)
 	 * just use for loop with udelay here.
 	 */
 	for (i = 0; i < 60; i++) {
-		cur_idx = rtw89_read32(rtwdev, bd_ring->addr_idx);
+		cur_idx = rtw89_read32(rtwdev, bd_ring->addr.idx);
 		cur_rp = FIELD_GET(TXBD_HW_IDX_MASK, cur_idx);
 		if (cur_rp == bd_ring->wp)
 			return;
@@ -1179,9 +1179,9 @@ static void rtw89_pci_reset_trx_rings(struct rtw89_dev *rtwdev)
 		tx_ring = &rtwpci->tx_rings[i];
 		bd_ring = &tx_ring->bd_ring;
 		bd_ram = &bd_ram_table[i];
-		addr_num = bd_ring->addr_num;
-		addr_bdram = bd_ring->addr_bdram;
-		addr_desa_l = bd_ring->addr_desa_l;
+		addr_num = bd_ring->addr.num;
+		addr_bdram = bd_ring->addr.bdram;
+		addr_desa_l = bd_ring->addr.desa_l;
 		bd_ring->wp = 0;
 		bd_ring->rp = 0;
 
@@ -1197,8 +1197,8 @@ static void rtw89_pci_reset_trx_rings(struct rtw89_dev *rtwdev)
 	for (i = 0; i < RTW89_RXCH_NUM; i++) {
 		rx_ring = &rtwpci->rx_rings[i];
 		bd_ring = &rx_ring->bd_ring;
-		addr_num = bd_ring->addr_num;
-		addr_desa_l = bd_ring->addr_desa_l;
+		addr_num = bd_ring->addr.num;
+		addr_desa_l = bd_ring->addr.desa_l;
 		bd_ring->wp = 0;
 		bd_ring->rp = 0;
 		rx_ring->diliver_skb = NULL;
@@ -2256,11 +2256,7 @@ static int rtw89_pci_alloc_tx_ring(struct rtw89_dev *rtwdev,
 	tx_ring->bd_ring.dma = dma;
 	tx_ring->bd_ring.len = len;
 	tx_ring->bd_ring.desc_size = desc_size;
-	tx_ring->bd_ring.addr_num = txch_addr->num;
-	tx_ring->bd_ring.addr_idx = txch_addr->idx;
-	tx_ring->bd_ring.addr_bdram = txch_addr->bdram;
-	tx_ring->bd_ring.addr_desa_l = txch_addr->desa_l;
-	tx_ring->bd_ring.addr_desa_h = txch_addr->desa_h;
+	tx_ring->bd_ring.addr = *txch_addr;
 	tx_ring->bd_ring.wp = 0;
 	tx_ring->bd_ring.rp = 0;
 	tx_ring->txch = txch;
@@ -2337,10 +2333,7 @@ static int rtw89_pci_alloc_rx_ring(struct rtw89_dev *rtwdev,
 	rx_ring->bd_ring.dma = dma;
 	rx_ring->bd_ring.len = len;
 	rx_ring->bd_ring.desc_size = desc_size;
-	rx_ring->bd_ring.addr_num = rxch_addr->num;
-	rx_ring->bd_ring.addr_idx = rxch_addr->idx;
-	rx_ring->bd_ring.addr_desa_l = rxch_addr->desa_l;
-	rx_ring->bd_ring.addr_desa_h = rxch_addr->desa_h;
+	rx_ring->bd_ring.addr = *rxch_addr;
 	rx_ring->bd_ring.wp = 0;
 	rx_ring->bd_ring.rp = 0;
 	rx_ring->buf_sz = buf_sz;
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index b48306da566c1..b84acd0d0582a 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -537,11 +537,7 @@ struct rtw89_pci_dma_ring {
 	u8 desc_size;
 	dma_addr_t dma;
 
-	u32 addr_num;
-	u32 addr_idx;
-	u32 addr_bdram;
-	u32 addr_desa_l;
-	u32 addr_desa_h;
+	struct rtw89_pci_ch_dma_addr addr;
 
 	u32 len;
 	u32 wp; /* host idx */
-- 
2.25.1

