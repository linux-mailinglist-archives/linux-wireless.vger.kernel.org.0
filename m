Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79657D8228
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Oct 2023 14:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344814AbjJZMBp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Oct 2023 08:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjJZMBl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Oct 2023 08:01:41 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D0C1A6
        for <linux-wireless@vger.kernel.org>; Thu, 26 Oct 2023 05:01:37 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39QC1M5702779285, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 39QC1M5702779285
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Oct 2023 20:01:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 26 Oct 2023 20:01:22 +0800
Received: from [127.0.1.1] (172.16.17.48) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 26 Oct
 2023 20:01:22 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/4] wifi: rtw89: pci: add new RX ring design to determine full RX ring efficiently
Date:   Thu, 26 Oct 2023 20:00:48 +0800
Message-ID: <20231026120049.9187-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231026120049.9187-1-pkshih@realtek.com>
References: <20231026120049.9187-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.17.48]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

To make hardware efficient to determine if RX ring is full, introduce new
design that checks if reading and writing indices are equal. Comparing
to old design, initial indices of both reading and writing indices are 0
that means empty, and hardware checks full by "writing index + 1 ==
reading index". The "+1" has extra cost for hardware, so new design is
to avoid this.

Take ring size is 256 as an example, the initial reading and writing
indices are 255 and 0 respectively; the initial values mean empty. If two
indices are the same, for example 5 and 5, it means ring is full.

   wp       rp       used_cnt        state
   255      0        0               initial (ring is empty)
   255      1        1               receive 1st packet
   255      2        2               receive 2nd packet
   0        2        1               driver read 1st packet
   1        2        0               driver read 2nd packet (ring is empty)
            :
   5        5        255             ring is full

Note: 'rp' is hardware writing index

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c      | 48 ++++++++++++++++---
 drivers/net/wireless/realtek/rtw89/pci.h      |  1 +
 .../net/wireless/realtek/rtw89/rtw8852ae.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8852be.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8852ce.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8922ae.c    |  1 +
 6 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 910f30a209be..13775c36a46b 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -41,6 +41,7 @@ static u32 rtw89_pci_dma_recalc(struct rtw89_dev *rtwdev,
 				struct rtw89_pci_dma_ring *bd_ring,
 				u32 cur_idx, bool tx)
 {
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
 	u32 cnt, cur_rp, wp, rp, len;
 
 	rp = bd_ring->rp;
@@ -48,10 +49,14 @@ static u32 rtw89_pci_dma_recalc(struct rtw89_dev *rtwdev,
 	len = bd_ring->len;
 
 	cur_rp = FIELD_GET(TXBD_HW_IDX_MASK, cur_idx);
-	if (tx)
+	if (tx) {
 		cnt = cur_rp >= rp ? cur_rp - rp : len - (rp - cur_rp);
-	else
+	} else {
+		if (info->rx_ring_eq_is_full)
+			wp += 1;
+
 		cnt = cur_rp >= wp ? cur_rp - wp : len - (wp - cur_rp);
+	}
 
 	bd_ring->rp = cur_rp;
 
@@ -226,6 +231,21 @@ rtw89_skb_put_rx_data(struct rtw89_dev *rtwdev, bool fs, bool ls,
 	return true;
 }
 
+static u32 rtw89_pci_get_rx_skb_idx(struct rtw89_dev *rtwdev,
+				    struct rtw89_pci_dma_ring *bd_ring)
+{
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
+	u32 wp = bd_ring->wp;
+
+	if (!info->rx_ring_eq_is_full)
+		return wp;
+
+	if (++wp >= bd_ring->len)
+		wp = 0;
+
+	return wp;
+}
+
 static u32 rtw89_pci_rxbd_deliver_skbs(struct rtw89_dev *rtwdev,
 				       struct rtw89_pci_rx_ring *rx_ring)
 {
@@ -235,12 +255,14 @@ static u32 rtw89_pci_rxbd_deliver_skbs(struct rtw89_dev *rtwdev,
 	struct sk_buff *new = rx_ring->diliver_skb;
 	struct sk_buff *skb;
 	u32 rxinfo_size = sizeof(struct rtw89_pci_rxbd_info);
+	u32 skb_idx;
 	u32 offset;
 	u32 cnt = 1;
 	bool fs, ls;
 	int ret;
 
-	skb = rx_ring->buf[bd_ring->wp];
+	skb_idx = rtw89_pci_get_rx_skb_idx(rtwdev, bd_ring);
+	skb = rx_ring->buf[skb_idx];
 	rtw89_pci_sync_skb_for_cpu(rtwdev, skb);
 
 	ret = rtw89_pci_rxbd_info_update(rtwdev, skb);
@@ -525,10 +547,12 @@ static u32 rtw89_pci_release_tx_skbs(struct rtw89_dev *rtwdev,
 	u32 cnt = 0;
 	u32 rpp_size = sizeof(struct rtw89_pci_rpp_fmt);
 	u32 rxinfo_size = sizeof(struct rtw89_pci_rxbd_info);
+	u32 skb_idx;
 	u32 offset;
 	int ret;
 
-	skb = rx_ring->buf[bd_ring->wp];
+	skb_idx = rtw89_pci_get_rx_skb_idx(rtwdev, bd_ring);
+	skb = rx_ring->buf[skb_idx];
 	rtw89_pci_sync_skb_for_cpu(rtwdev, skb);
 
 	ret = rtw89_pci_rxbd_info_update(rtwdev, skb);
@@ -1454,6 +1478,7 @@ static void rtw89_pci_reset_trx_rings(struct rtw89_dev *rtwdev)
 	struct rtw89_pci_dma_ring *bd_ring;
 	const struct rtw89_pci_bd_ram *bd_ram;
 	u32 addr_num;
+	u32 addr_idx;
 	u32 addr_bdram;
 	u32 addr_desa_l;
 	u32 val32;
@@ -1487,14 +1512,21 @@ static void rtw89_pci_reset_trx_rings(struct rtw89_dev *rtwdev)
 		rx_ring = &rtwpci->rx_rings[i];
 		bd_ring = &rx_ring->bd_ring;
 		addr_num = bd_ring->addr.num;
+		addr_idx = bd_ring->addr.idx;
 		addr_desa_l = bd_ring->addr.desa_l;
-		bd_ring->wp = 0;
+		if (info->rx_ring_eq_is_full)
+			bd_ring->wp = bd_ring->len - 1;
+		else
+			bd_ring->wp = 0;
 		bd_ring->rp = 0;
 		rx_ring->diliver_skb = NULL;
 		rx_ring->diliver_desc.ready = false;
 
 		rtw89_write16(rtwdev, addr_num, bd_ring->len);
 		rtw89_write32(rtwdev, addr_desa_l, bd_ring->dma);
+
+		if (info->rx_ring_eq_is_full)
+			rtw89_write16(rtwdev, addr_idx, bd_ring->wp);
 	}
 }
 
@@ -3060,6 +3092,7 @@ static int rtw89_pci_alloc_rx_ring(struct rtw89_dev *rtwdev,
 				   struct rtw89_pci_rx_ring *rx_ring,
 				   u32 desc_size, u32 len, u32 rxch)
 {
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
 	const struct rtw89_pci_ch_dma_addr *rxch_addr;
 	struct sk_buff *skb;
 	u8 *head;
@@ -3086,7 +3119,10 @@ static int rtw89_pci_alloc_rx_ring(struct rtw89_dev *rtwdev,
 	rx_ring->bd_ring.len = len;
 	rx_ring->bd_ring.desc_size = desc_size;
 	rx_ring->bd_ring.addr = *rxch_addr;
-	rx_ring->bd_ring.wp = 0;
+	if (info->rx_ring_eq_is_full)
+		rx_ring->bd_ring.wp = len - 1;
+	else
+		rx_ring->bd_ring.wp = 0;
 	rx_ring->bd_ring.rp = 0;
 	rx_ring->buf_sz = buf_sz;
 	rx_ring->diliver_skb = NULL;
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index 56e1980c9882..e16507a5ec5a 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -937,6 +937,7 @@ struct rtw89_pci_info {
 	enum mac_ax_pcie_func_ctrl autok_en;
 	enum mac_ax_pcie_func_ctrl io_rcy_en;
 	enum mac_ax_io_rcy_tmr io_rcy_tmr;
+	bool rx_ring_eq_is_full;
 
 	u32 init_cfg_reg;
 	u32 txhci_en_bit;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
index d835a44a1d0d..5895a7019375 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
@@ -24,6 +24,7 @@ static const struct rtw89_pci_info rtw8852a_pci_info = {
 	.autok_en		= MAC_AX_PCIE_DISABLE,
 	.io_rcy_en		= MAC_AX_PCIE_DISABLE,
 	.io_rcy_tmr		= MAC_AX_IO_RCY_ANA_TMR_6MS,
+	.rx_ring_eq_is_full	= false,
 
 	.init_cfg_reg		= R_AX_PCIE_INIT_CFG1,
 	.txhci_en_bit		= B_AX_TXHCI_EN,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852be.c b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
index ecf39d2d9f81..626a00dcddb6 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852be.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
@@ -24,6 +24,7 @@ static const struct rtw89_pci_info rtw8852b_pci_info = {
 	.autok_en		= MAC_AX_PCIE_DISABLE,
 	.io_rcy_en		= MAC_AX_PCIE_DISABLE,
 	.io_rcy_tmr		= MAC_AX_IO_RCY_ANA_TMR_6MS,
+	.rx_ring_eq_is_full	= false,
 
 	.init_cfg_reg		= R_AX_PCIE_INIT_CFG1,
 	.txhci_en_bit		= B_AX_TXHCI_EN,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
index 80490a5437df..5d34e56d9106 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
@@ -33,6 +33,7 @@ static const struct rtw89_pci_info rtw8852c_pci_info = {
 	.autok_en		= MAC_AX_PCIE_DISABLE,
 	.io_rcy_en		= MAC_AX_PCIE_ENABLE,
 	.io_rcy_tmr		= MAC_AX_IO_RCY_ANA_TMR_6MS,
+	.rx_ring_eq_is_full	= false,
 
 	.init_cfg_reg		= R_AX_HAXI_INIT_CFG1,
 	.txhci_en_bit		= B_AX_TXHCI_EN_V1,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922ae.c b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
index ffb31784d8ca..c0c720daece1 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
@@ -23,6 +23,7 @@ static const struct rtw89_pci_info rtw8922a_pci_info = {
 	.autok_en		= MAC_AX_PCIE_DISABLE,
 	.io_rcy_en		= MAC_AX_PCIE_ENABLE,
 	.io_rcy_tmr		= MAC_AX_IO_RCY_ANA_TMR_DEF,
+	.rx_ring_eq_is_full	= true,
 
 	.init_cfg_reg		= R_BE_HAXI_INIT_CFG1,
 	.txhci_en_bit		= B_BE_TXDMA_EN,
-- 
2.25.1

