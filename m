Return-Path: <linux-wireless+bounces-26620-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B982B357B1
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 10:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19713171835
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 08:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADF028371;
	Tue, 26 Aug 2025 08:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="hL7YFauu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E589460
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 08:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756198456; cv=none; b=QbuhmZQuIEgHZUjsL9tyIYP3t+TizswjM1rCfhZ+BNtLWGtCqyLQkGwoRhrbkVQKhqCdDglHqzPH9+kCheIwBnzrD+dwRp710mitm5CBXehzoe84xP4JsZRl0FyQ3ow0XrStoiRWNPQ0S5x9pCFmkkC3c1/d3+hwt4J3/cZc8Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756198456; c=relaxed/simple;
	bh=PwlciA6AsWud7SHurq85F52lwzEZfF66Gfz1SD8eDH4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GjwJHOomwX8rvC3SVS281Wr1sdyfD3bMgQ7COVVQEbvWSnwXJPWrzh4V1McNFRfVsxGq3iBTL30JJuCHOQGAo7hpmOTee57lGFGQnGiO8MiwNOHbk2baX65Tms/JLbFdJ85BOctXAQ6/fgcrS9UtH4q+f7sMgYFpaQ3zqEWc358=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=hL7YFauu; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57Q8sCryD1262278, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1756198452; bh=DupX6AzB3DXfGvplwGsVgiCrIFmLS08OIVIcDDMfx0M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=hL7YFauuwlPx3kcSxc1XV+arWeGIBfwhD0mfaIXl4pAzZ6TwnW+kf2DnFZWDRuw/4
	 7HFD9q+xrqDwKBHptWcNkAChnHp7TTFRv+82MVzEj+KARhSgaTz3dVznNGmQT2HI7v
	 OBe7wQZ7QnPr307sMjhUph7GrfJP7zSkxZJf9BPrOt9zwZ4Zut22HUAbMln1i3upsg
	 36rc3OJe9N31BJ9c2XjqLdFZugdaamb0MH/XzIOh3H/XOq3MkAJrEWSXT2pzC6Q4CM
	 emgW3hoDlNVjy7Fuea0T23rafax27Fqu36qRsBOLBCySmvYSxpS+GGheBjtA2vZ36C
	 Q8YuGKonFqLIQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57Q8sCryD1262278
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 16:54:12 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 26 Aug 2025 16:54:12 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Tue, 26 Aug
 2025 16:54:12 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 06/10] wifi: rtw89: pci: add group BD address design
Date: Tue, 26 Aug 2025 16:53:18 +0800
Message-ID: <20250826085318.28361-1-pkshih@realtek.com>
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

The newly designed group BD address is to use the same starting DMA address
with offset as below picture:

 Original            DMA memory         Group BD address

 +--------+  (*1)   +---------+   (*2)  +--------+
 |  CH 0 -|-------> |         | <-------|- CH 0  | <-+--+--+--+
 +--------+         |         |         |        |   |  |  |  |
 |  CH 1 -|-------> |         |         |  CH 1 -|---+  |  |  |
 +--------+         |         |         |        |      |  |  |
 |  CH 2 -|-------> |         |         |  CH 2 -|------+  |  |
 +--------+         |         |         |        |         |  |
 |  CH 3 -|-------> |         |         |  CH 3 -|---------+  |
 +--------+         |         |         |        |            |
 |    :  -|-------> |         |         |    :  -|------------+
 +--------+         |         |         +--------+   (*3; offset from CH 0)
 |  CH 8 -|-------> |         | <-------|- CH 8  | <-+
 +--------+         |         |         |        |   | (offset from CH 8)
 |    :  -|-------> |         |         |    :  -|---+
 +--------+         +---------+         +--------+

Compare (*1) and (*2), for original design, each DMA channel has
individual DMA address, so it is not necessary to allocate continual
DMA address across channels. For group BD address, only two DMA address
are set, and each channel set the offset (*3) from base address.

The element number and offset of a channel are encoded rather than a
raw number, so add a function to translate numbers into hardware format.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c      | 141 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/pci.h      |  34 ++++-
 .../net/wireless/realtek/rtw89/rtw8851be.c    |   1 +
 .../net/wireless/realtek/rtw89/rtw8852ae.c    |   1 +
 .../net/wireless/realtek/rtw89/rtw8852be.c    |   1 +
 .../net/wireless/realtek/rtw89/rtw8852bte.c   |   1 +
 .../net/wireless/realtek/rtw89/rtw8852ce.c    |   1 +
 .../net/wireless/realtek/rtw89/rtw8922ae.c    |   1 +
 8 files changed, 172 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index d4f78396dfde..55d82af732c0 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -988,6 +988,24 @@ static irqreturn_t rtw89_pci_interrupt_handler(int irq, void *dev)
 	return irqret;
 }
 
+#define DEF_TXCHADDRS_TYPE3(gen, ch_idx, txch, v...) \
+	[RTW89_TXCH_##ch_idx] = { \
+		.num = R_##gen##_##txch##_TXBD_CFG, \
+		.idx = R_##gen##_##txch##_TXBD_IDX ##v, \
+		.bdram = 0, \
+		.desa_l = 0, \
+		.desa_h = 0, \
+	}
+
+#define DEF_TXCHADDRS_TYPE3_GRP_BASE(gen, ch_idx, txch, grp, v...) \
+	[RTW89_TXCH_##ch_idx] = { \
+		.num = R_##gen##_##txch##_TXBD_CFG, \
+		.idx = R_##gen##_##txch##_TXBD_IDX ##v, \
+		.bdram = 0, \
+		.desa_l = R_##gen##_##grp##_TXBD_DESA_L, \
+		.desa_h = R_##gen##_##grp##_TXBD_DESA_H, \
+	}
+
 #define DEF_TXCHADDRS_TYPE2(gen, ch_idx, txch, v...) \
 	[RTW89_TXCH_##ch_idx] = { \
 		.num = R_##gen##_##txch##_TXBD_NUM ##v, \
@@ -1015,6 +1033,22 @@ static irqreturn_t rtw89_pci_interrupt_handler(int irq, void *dev)
 		.desa_h = R_AX_##txch##_TXBD_DESA_H ##v, \
 	}
 
+#define DEF_RXCHADDRS_TYPE3(gen, ch_idx, rxch, v...) \
+	[RTW89_RXCH_##ch_idx] = { \
+		.num = R_##gen##_RX_##rxch##_RXBD_CONFIG, \
+		.idx = R_##gen##_##ch_idx##0_RXBD_IDX ##v, \
+		.desa_l = 0, \
+		.desa_h = 0, \
+	}
+
+#define DEF_RXCHADDRS_TYPE3_GRP_BASE(gen, ch_idx, rxch, grp, v...) \
+	[RTW89_RXCH_##ch_idx] = { \
+		.num = R_##gen##_RX_##rxch##_RXBD_CONFIG, \
+		.idx = R_##gen##_##ch_idx##0_RXBD_IDX ##v, \
+		.desa_l = R_##gen##_##grp##_RXBD_DESA_L, \
+		.desa_h = R_##gen##_##grp##_RXBD_DESA_H, \
+	}
+
 #define DEF_RXCHADDRS(gen, ch_idx, rxch, v...) \
 	[RTW89_RXCH_##ch_idx] = { \
 		.num = R_##gen##_##rxch##_RXBD_NUM ##v, \
@@ -1092,8 +1126,36 @@ const struct rtw89_pci_ch_dma_addr_set rtw89_pci_ch_dma_addr_set_be = {
 };
 EXPORT_SYMBOL(rtw89_pci_ch_dma_addr_set_be);
 
+const struct rtw89_pci_ch_dma_addr_set rtw89_pci_ch_dma_addr_set_be_v1 = {
+	.tx = {
+		DEF_TXCHADDRS_TYPE3_GRP_BASE(BE, ACH0, CH0, ACQ, _V1),
+		/* no CH1 */
+		DEF_TXCHADDRS_TYPE3(BE, ACH2, CH2, _V1),
+		/* no CH3 */
+		DEF_TXCHADDRS_TYPE3(BE, ACH4, CH4, _V1),
+		/* no CH5 */
+		DEF_TXCHADDRS_TYPE3(BE, ACH6, CH6, _V1),
+		/* no CH7 */
+		DEF_TXCHADDRS_TYPE3_GRP_BASE(BE, CH8, CH8, NACQ, _V1),
+		/* no CH9 */
+		DEF_TXCHADDRS_TYPE3(BE, CH10, CH10, _V1),
+		/* no CH11 */
+		DEF_TXCHADDRS_TYPE3(BE, CH12, CH12, _V1),
+	},
+	.rx = {
+		DEF_RXCHADDRS_TYPE3_GRP_BASE(BE, RXQ, CH0, HOST0, _V1),
+		DEF_RXCHADDRS_TYPE3(BE, RPQ, CH1, _V1),
+	},
+};
+EXPORT_SYMBOL(rtw89_pci_ch_dma_addr_set_be_v1);
+
+#undef DEF_TXCHADDRS_TYPE3
+#undef DEF_TXCHADDRS_TYPE3_GRP_BASE
+#undef DEF_TXCHADDRS_TYPE2
 #undef DEF_TXCHADDRS_TYPE1
 #undef DEF_TXCHADDRS
+#undef DEF_RXCHADDRS_TYPE3
+#undef DEF_RXCHADDRS_TYPE3_GRP_BASE
 #undef DEF_RXCHADDRS
 
 static int rtw89_pci_get_txch_addrs(struct rtw89_dev *rtwdev,
@@ -1645,6 +1707,41 @@ static void rtw89_pci_init_wp_16sel(struct rtw89_dev *rtwdev)
 	}
 }
 
+static u16 rtw89_pci_enc_bd_cfg(struct rtw89_dev *rtwdev, u16 bd_num,
+				u32 dma_offset)
+{
+	u16 dma_offset_sel;
+	u16 num_sel;
+
+	/* B_BE_TX_NUM_SEL_MASK, B_BE_RX_NUM_SEL_MASK:
+	 *  0 -> 0
+	 *  1 -> 64 = 2^6
+	 *  2 -> 128 = 2^7
+	 *    ...
+	 *  7 -> 4096 = 2^12
+	 */
+	num_sel = ilog2(bd_num) - 5;
+
+	if (hweight16(bd_num) != 1)
+		rtw89_warn(rtwdev, "bd_num %u is not power of 2\n", bd_num);
+
+	/* B_BE_TX_START_OFFSET_MASK, B_BE_RX_START_OFFSET_MASK:
+	 *  0 -> 0    = 0 * 2^9
+	 *  1 -> 512  = 1 * 2^9
+	 *  2 -> 1024 = 2 * 2^9
+	 *  3 -> 1536 = 3 * 2^9
+	 *    ...
+	 *  255 -> 130560 = 255 * 2^9
+	 */
+	dma_offset_sel = dma_offset >> 9;
+
+	if (dma_offset % 512)
+		rtw89_warn(rtwdev, "offset %u is not multiple of 512\n", dma_offset);
+
+	return u16_encode_bits(num_sel, B_BE_TX_NUM_SEL_MASK) |
+	       u16_encode_bits(dma_offset_sel, B_BE_TX_START_OFFSET_MASK);
+}
+
 static void rtw89_pci_reset_trx_rings(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
@@ -1654,10 +1751,12 @@ static void rtw89_pci_reset_trx_rings(struct rtw89_dev *rtwdev)
 	struct rtw89_pci_rx_ring *rx_ring;
 	struct rtw89_pci_dma_ring *bd_ring;
 	const struct rtw89_pci_bd_ram *bd_ram;
+	dma_addr_t group_dma_base = 0;
+	u16 num_or_offset;
+	u32 addr_desa_l;
+	u32 addr_bdram;
 	u32 addr_num;
 	u32 addr_idx;
-	u32 addr_bdram;
-	u32 addr_desa_l;
 	u32 val32;
 	int i;
 
@@ -1674,7 +1773,18 @@ static void rtw89_pci_reset_trx_rings(struct rtw89_dev *rtwdev)
 		bd_ring->wp = 0;
 		bd_ring->rp = 0;
 
-		rtw89_write16(rtwdev, addr_num, bd_ring->len);
+		if (info->group_bd_addr) {
+			if (addr_desa_l)
+				group_dma_base = bd_ring->dma;
+
+			num_or_offset =
+				rtw89_pci_enc_bd_cfg(rtwdev, bd_ring->len,
+						     bd_ring->dma - group_dma_base);
+		} else {
+			num_or_offset = bd_ring->len;
+		}
+		rtw89_write16(rtwdev, addr_num, num_or_offset);
+
 		if (addr_bdram && bd_ram) {
 			val32 = FIELD_PREP(BDRAM_SIDX_MASK, bd_ram->start_idx) |
 				FIELD_PREP(BDRAM_MAX_MASK, bd_ram->max_num) |
@@ -1682,8 +1792,10 @@ static void rtw89_pci_reset_trx_rings(struct rtw89_dev *rtwdev)
 
 			rtw89_write32(rtwdev, addr_bdram, val32);
 		}
-		rtw89_write32(rtwdev, addr_desa_l, bd_ring->dma);
-		rtw89_write32(rtwdev, addr_desa_l + 4, upper_32_bits(bd_ring->dma));
+		if (addr_desa_l) {
+			rtw89_write32(rtwdev, addr_desa_l, bd_ring->dma);
+			rtw89_write32(rtwdev, addr_desa_l + 4, upper_32_bits(bd_ring->dma));
+		}
 	}
 
 	for (i = 0; i < RTW89_RXCH_NUM; i++) {
@@ -1701,9 +1813,22 @@ static void rtw89_pci_reset_trx_rings(struct rtw89_dev *rtwdev)
 		rx_ring->diliver_desc.ready = false;
 		rx_ring->target_rx_tag = 0;
 
-		rtw89_write16(rtwdev, addr_num, bd_ring->len);
-		rtw89_write32(rtwdev, addr_desa_l, bd_ring->dma);
-		rtw89_write32(rtwdev, addr_desa_l + 4, upper_32_bits(bd_ring->dma));
+		if (info->group_bd_addr) {
+			if (addr_desa_l)
+				group_dma_base = bd_ring->dma;
+
+			num_or_offset =
+				rtw89_pci_enc_bd_cfg(rtwdev, bd_ring->len,
+						     bd_ring->dma - group_dma_base);
+		} else {
+			num_or_offset = bd_ring->len;
+		}
+		rtw89_write16(rtwdev, addr_num, num_or_offset);
+
+		if (addr_desa_l) {
+			rtw89_write32(rtwdev, addr_desa_l, bd_ring->dma);
+			rtw89_write32(rtwdev, addr_desa_l + 4, upper_32_bits(bd_ring->dma));
+		}
 
 		if (info->rx_ring_eq_is_full)
 			rtw89_write16(rtwdev, addr_idx, bd_ring->wp);
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index f00d717b668b..e8a856537b7c 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -808,9 +808,25 @@
 #define R_BE_CH13_TXBD_NUM_V1 0xB04C
 #define R_BE_CH14_TXBD_NUM_V1 0xB04E
 
+#define R_BE_CH0_TXBD_CFG 0xB030
+#define R_BE_CH2_TXBD_CFG 0xB034
+#define R_BE_CH4_TXBD_CFG 0xB038
+#define R_BE_CH6_TXBD_CFG 0xB03C
+#define R_BE_CH8_TXBD_CFG 0xB040
+#define R_BE_CH10_TXBD_CFG 0xB044
+#define R_BE_CH12_TXBD_CFG 0xB048
+#define B_BE_TX_FLAG BIT(14)
+#define B_BE_TX_START_OFFSET_MASK GENMASK(12, 4)
+#define B_BE_TX_NUM_SEL_MASK GENMASK(2, 0)
+
 #define R_BE_RXQ0_RXBD_NUM_V1 0xB050
 #define R_BE_RPQ0_RXBD_NUM_V1 0xB052
 
+#define R_BE_RX_CH0_RXBD_CONFIG 0xB050
+#define R_BE_RX_CH1_RXBD_CONFIG 0xB052
+#define B_BE_RX_START_OFFSET_MASK GENMASK(11, 4)
+#define B_BE_RX_NUM_SEL_MASK GENMASK(2, 0)
+
 #define R_BE_CH0_TXBD_IDX_V1 0xB100
 #define R_BE_CH1_TXBD_IDX_V1 0xB104
 #define R_BE_CH2_TXBD_IDX_V1 0xB108
@@ -861,11 +877,25 @@
 #define R_BE_CH14_TXBD_DESA_L_V1 0xB270
 #define R_BE_CH14_TXBD_DESA_H_V1 0xB274
 
+#define R_BE_ACQ_TXBD_DESA_L 0xB200
+#define B_BE_TX_ACQ_DESA_L_MASK GENMASK(31, 3)
+#define R_BE_ACQ_TXBD_DESA_H 0xB204
+#define B_BE_TX_ACQ_DESA_H_MASK GENMASK(7, 0)
+#define R_BE_NACQ_TXBD_DESA_L 0xB240
+#define B_BE_TX_NACQ_DESA_L_MASK GENMASK(31, 3)
+#define R_BE_NACQ_TXBD_DESA_H 0xB244
+#define B_BE_TX_NACQ_DESA_H_MASK GENMASK(7, 0)
+
 #define R_BE_RXQ0_RXBD_DESA_L_V1 0xB300
 #define R_BE_RXQ0_RXBD_DESA_H_V1 0xB304
 #define R_BE_RPQ0_RXBD_DESA_L_V1 0xB308
 #define R_BE_RPQ0_RXBD_DESA_H_V1 0xB30C
 
+#define R_BE_HOST0_RXBD_DESA_L 0xB300
+#define B_BE_RX_HOST0_DESA_L_MASK GENMASK(31, 3)
+#define R_BE_HOST0_RXBD_DESA_H 0xB304
+#define B_BE_RX_HOST0_DESA_H_MASK GENMASK(7, 0)
+
 #define R_BE_WP_ADDR_H_SEL0_3_V1 0xB420
 #define R_BE_WP_ADDR_H_SEL4_7_V1 0xB424
 #define R_BE_WP_ADDR_H_SEL8_11_V1 0xB428
@@ -1273,7 +1303,7 @@ struct rtw89_pci_bd_idx_addr {
 };
 
 struct rtw89_pci_ch_dma_addr {
-	u32 num;
+	u32 num; /* also `offset` addr for group_bd_addr design */
 	u32 idx;
 	u32 bdram;
 	u32 desa_l;
@@ -1355,6 +1385,7 @@ struct rtw89_pci_info {
 	bool rx_ring_eq_is_full;
 	bool check_rx_tag;
 	bool no_rxbd_fs;
+	bool group_bd_addr;
 
 	u32 init_cfg_reg;
 	u32 txhci_en_bit;
@@ -1669,6 +1700,7 @@ extern const struct pci_error_handlers rtw89_pci_err_handler;
 extern const struct rtw89_pci_ch_dma_addr_set rtw89_pci_ch_dma_addr_set;
 extern const struct rtw89_pci_ch_dma_addr_set rtw89_pci_ch_dma_addr_set_v1;
 extern const struct rtw89_pci_ch_dma_addr_set rtw89_pci_ch_dma_addr_set_be;
+extern const struct rtw89_pci_ch_dma_addr_set rtw89_pci_ch_dma_addr_set_be_v1;
 extern const struct rtw89_pci_bd_ram rtw89_bd_ram_table_dual[RTW89_TXCH_NUM];
 extern const struct rtw89_pci_bd_ram rtw89_bd_ram_table_single[RTW89_TXCH_NUM];
 extern const struct rtw89_pci_isr_def rtw89_pci_isr_ax;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851be.c b/drivers/net/wireless/realtek/rtw89/rtw8851be.c
index c9d60870ed9e..d2ea1e237a1f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851be.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851be.c
@@ -29,6 +29,7 @@ static const struct rtw89_pci_info rtw8851b_pci_info = {
 	.rx_ring_eq_is_full	= false,
 	.check_rx_tag		= false,
 	.no_rxbd_fs		= false,
+	.group_bd_addr		= false,
 
 	.init_cfg_reg		= R_AX_PCIE_INIT_CFG1,
 	.txhci_en_bit		= B_AX_TXHCI_EN,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
index 1bfade7e7e1b..d733264b5dd1 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
@@ -29,6 +29,7 @@ static const struct rtw89_pci_info rtw8852a_pci_info = {
 	.rx_ring_eq_is_full	= false,
 	.check_rx_tag		= false,
 	.no_rxbd_fs		= false,
+	.group_bd_addr		= false,
 
 	.init_cfg_reg		= R_AX_PCIE_INIT_CFG1,
 	.txhci_en_bit		= B_AX_TXHCI_EN,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852be.c b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
index 8f7676a0a89e..146a1f2292d7 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852be.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
@@ -29,6 +29,7 @@ static const struct rtw89_pci_info rtw8852b_pci_info = {
 	.rx_ring_eq_is_full	= false,
 	.check_rx_tag		= false,
 	.no_rxbd_fs		= false,
+	.group_bd_addr		= false,
 
 	.init_cfg_reg		= R_AX_PCIE_INIT_CFG1,
 	.txhci_en_bit		= B_AX_TXHCI_EN,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bte.c b/drivers/net/wireless/realtek/rtw89/rtw8852bte.c
index 642ab20e9d06..5373b13e3470 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bte.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bte.c
@@ -35,6 +35,7 @@ static const struct rtw89_pci_info rtw8852bt_pci_info = {
 	.rx_ring_eq_is_full	= false,
 	.check_rx_tag		= false,
 	.no_rxbd_fs		= false,
+	.group_bd_addr		= false,
 
 	.init_cfg_reg		= R_AX_PCIE_INIT_CFG1,
 	.txhci_en_bit		= B_AX_TXHCI_EN,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
index 4c7682f1d00c..b2bf4ba6ddd8 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
@@ -38,6 +38,7 @@ static const struct rtw89_pci_info rtw8852c_pci_info = {
 	.rx_ring_eq_is_full	= false,
 	.check_rx_tag		= false,
 	.no_rxbd_fs		= false,
+	.group_bd_addr		= false,
 
 	.init_cfg_reg		= R_AX_HAXI_INIT_CFG1,
 	.txhci_en_bit		= B_AX_TXHCI_EN_V1,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922ae.c b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
index a0fc6b2832e1..32144fc66e4a 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
@@ -35,6 +35,7 @@ static const struct rtw89_pci_info rtw8922a_pci_info = {
 	.rx_ring_eq_is_full	= true,
 	.check_rx_tag		= true,
 	.no_rxbd_fs		= true,
+	.group_bd_addr		= false,
 
 	.init_cfg_reg		= R_BE_HAXI_INIT_CFG1,
 	.txhci_en_bit		= B_BE_TXDMA_EN,
-- 
2.25.1


