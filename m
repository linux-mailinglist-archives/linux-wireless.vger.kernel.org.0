Return-Path: <linux-wireless+bounces-8770-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40551902E42
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 04:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC8E6283378
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 02:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8215A94C;
	Tue, 11 Jun 2024 02:20:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD848485
	for <linux-wireless@vger.kernel.org>; Tue, 11 Jun 2024 02:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718072432; cv=none; b=jkb4Ysl9ybwhzHY/COo9OU6gSUH1KXCklGzmrxh7U845+ifCzPLK2vyWgFr0cK7iIO8cfvH79j9Oe1wtjjsvxsIjL6p6CFhZLlTwPMRSKTCUzR8qaNCMkHPTaM2LIiQqnpNU4DgZutHz7729ka8VBzZF9fvnzCMIY9tNlWe6GLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718072432; c=relaxed/simple;
	bh=HWw4/FDzZDAmN32SC9Wa84aZwkk2Xx9u019PFhSAw5c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iOh0O+LtYdPMc2kzvwuoQNPVfd+eWwVInYvCqMLhEBN9lDO3XjBGxdxKNoh7ZjaWDEvpvG3ps+cK5TQAdaxQkyU95CwX/ENB5LIOVKh9QtinWGuHUwaSFYiqZf14T1XzC1zvSpl8ueZCuGz6D0hZ0ZVU8AD5eE0LwlqwXJrQw+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45B2KRdpC3648975, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45B2KRdpC3648975
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 11 Jun 2024 10:20:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Jun 2024 10:20:27 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 11 Jun
 2024 10:20:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 1/2] wifi: rtw89: pci: support 36-bit PCI DMA address
Date: Tue, 11 Jun 2024 10:19:00 +0800
Message-ID: <20240611021901.26394-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Modern platforms can install more than 4GB memory, so DMA address can
larger than 32 bits. If a platform doesn't enable IOMMU, kernel needs extra
works of swiotlb to help DMA that packets reside on memory over 4GB.

The DMA addressing capability of Realtek WiFi chips is 36 bits, so set
LSB 4 bits of high 32-bit address to register and TX/RX descriptor, which
below figure shows 3-level pointers in TX direction, and RX direction is
similar but 2-level pointers only.

  +--------+
  |        | register to head of TX BD
  +---|----+
      |       +---------+
      +-----> |  TX BD  | (in memory)
              +----|----+
                   |        +---------+
                   +------> |  TX WD  | (in memory)
                            +----|----+
                                 |        +--------+
                                 +------> |   skb  |
                                          +--------+

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
  - fix typo of 'Modern'
  - use upper_32_bits() to get high 32-bit DMA address
---
 drivers/net/wireless/realtek/rtw89/pci.c      | 85 ++++++++++++++++---
 drivers/net/wireless/realtek/rtw89/pci.h      | 24 ++++--
 .../net/wireless/realtek/rtw89/rtw8851be.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8852ae.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8852be.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8852ce.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8922ae.c    |  1 +
 7 files changed, 95 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index d22d9676ab5a..6b7fb533e264 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -1298,10 +1298,12 @@ u32 rtw89_pci_fill_txaddr_info(struct rtw89_dev *rtwdev,
 			       dma_addr_t dma, u8 *add_info_nr)
 {
 	struct rtw89_pci_tx_addr_info_32 *txaddr_info = txaddr_info_addr;
+	__le16 option;
 
 	txaddr_info->length = cpu_to_le16(total_len);
-	txaddr_info->option = cpu_to_le16(RTW89_PCI_ADDR_MSDU_LS |
-					  RTW89_PCI_ADDR_NUM(1));
+	option = cpu_to_le16(RTW89_PCI_ADDR_MSDU_LS | RTW89_PCI_ADDR_NUM(1));
+	option |= le16_encode_bits(upper_32_bits(dma), RTW89_PCI_ADDR_HIGH_MASK);
+	txaddr_info->option = option;
 	txaddr_info->dma = cpu_to_le32(dma);
 
 	*add_info_nr = 1;
@@ -1328,6 +1330,8 @@ u32 rtw89_pci_fill_txaddr_info_v1(struct rtw89_dev *rtwdev,
 		length_option = FIELD_PREP(B_PCIADDR_LEN_V1_MASK, len) |
 				FIELD_PREP(B_PCIADDR_HIGH_SEL_V1_MASK, 0) |
 				FIELD_PREP(B_PCIADDR_LS_V1_MASK, remain == 0);
+		length_option |= u16_encode_bits(upper_32_bits(dma),
+						 B_PCIADDR_HIGH_SEL_V1_MASK);
 		txaddr_info->length_opt = cpu_to_le16(length_option);
 		txaddr_info->dma_low_lsb = cpu_to_le16(FIELD_GET(GENMASK(15, 0), dma));
 		txaddr_info->dma_low_msb = cpu_to_le16(FIELD_GET(GENMASK(31, 16), dma));
@@ -1418,6 +1422,7 @@ static int rtw89_pci_fwcmd_submit(struct rtw89_dev *rtwdev,
 	struct sk_buff *skb = tx_req->skb;
 	struct rtw89_pci_tx_data *tx_data = RTW89_PCI_TX_SKB_CB(skb);
 	dma_addr_t dma;
+	__le16 opt;
 
 	txdesc = skb_push(skb, txdesc_size);
 	memset(txdesc, 0, txdesc_size);
@@ -1430,7 +1435,9 @@ static int rtw89_pci_fwcmd_submit(struct rtw89_dev *rtwdev,
 	}
 
 	tx_data->dma = dma;
-	txbd->option = cpu_to_le16(RTW89_PCI_TXBD_OPTION_LS);
+	opt = cpu_to_le16(RTW89_PCI_TXBD_OPT_LS);
+	opt |= le16_encode_bits(upper_32_bits(dma), RTW89_PCI_TXBD_OPT_DMA_HI);
+	txbd->opt = opt;
 	txbd->length = cpu_to_le16(skb->len);
 	txbd->dma = cpu_to_le32(tx_data->dma);
 	skb_queue_tail(&rtwpci->h2c_queue, skb);
@@ -1446,6 +1453,7 @@ static int rtw89_pci_txbd_submit(struct rtw89_dev *rtwdev,
 				 struct rtw89_core_tx_request *tx_req)
 {
 	struct rtw89_pci_tx_wd *txwd;
+	__le16 opt;
 	int ret;
 
 	/* FWCMD queue doesn't have wd pages. Instead, it submits the CMD
@@ -1470,7 +1478,9 @@ static int rtw89_pci_txbd_submit(struct rtw89_dev *rtwdev,
 
 	list_add_tail(&txwd->list, &tx_ring->busy_pages);
 
-	txbd->option = cpu_to_le16(RTW89_PCI_TXBD_OPTION_LS);
+	opt = cpu_to_le16(RTW89_PCI_TXBD_OPT_LS);
+	opt |= le16_encode_bits(upper_32_bits(txwd->paddr), RTW89_PCI_TXBD_OPT_DMA_HI);
+	txbd->opt = opt;
 	txbd->length = cpu_to_le16(txwd->len);
 	txbd->dma = cpu_to_le32(txwd->paddr);
 
@@ -1569,6 +1579,25 @@ const struct rtw89_pci_bd_ram rtw89_bd_ram_table_single[RTW89_TXCH_NUM] = {
 };
 EXPORT_SYMBOL(rtw89_bd_ram_table_single);
 
+static void rtw89_pci_init_wp_16sel(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
+	u32 addr = info->wp_sel_addr;
+	u32 val;
+	int i;
+
+	if (!info->wp_sel_addr)
+		return;
+
+	for (i = 0; i < 16; i += 4) {
+		val = u32_encode_bits(i + 0, MASKBYTE0) |
+		      u32_encode_bits(i + 1, MASKBYTE1) |
+		      u32_encode_bits(i + 2, MASKBYTE2) |
+		      u32_encode_bits(i + 3, MASKBYTE3);
+		rtw89_write32(rtwdev, addr + i, val);
+	}
+}
+
 static void rtw89_pci_reset_trx_rings(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
@@ -1607,6 +1636,7 @@ static void rtw89_pci_reset_trx_rings(struct rtw89_dev *rtwdev)
 			rtw89_write32(rtwdev, addr_bdram, val32);
 		}
 		rtw89_write32(rtwdev, addr_desa_l, bd_ring->dma);
+		rtw89_write32(rtwdev, addr_desa_l + 4, upper_32_bits(bd_ring->dma));
 	}
 
 	for (i = 0; i < RTW89_RXCH_NUM; i++) {
@@ -1626,10 +1656,13 @@ static void rtw89_pci_reset_trx_rings(struct rtw89_dev *rtwdev)
 
 		rtw89_write16(rtwdev, addr_num, bd_ring->len);
 		rtw89_write32(rtwdev, addr_desa_l, bd_ring->dma);
+		rtw89_write32(rtwdev, addr_desa_l + 4, upper_32_bits(bd_ring->dma));
 
 		if (info->rx_ring_eq_is_full)
 			rtw89_write16(rtwdev, addr_idx, bd_ring->wp);
 	}
+
+	rtw89_pci_init_wp_16sel(rtwdev);
 }
 
 static void rtw89_pci_release_tx_ring(struct rtw89_dev *rtwdev,
@@ -2990,6 +3023,27 @@ static void rtw89_pci_declaim_device(struct rtw89_dev *rtwdev,
 	pci_disable_device(pdev);
 }
 
+static void rtw89_pci_cfg_dac(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	if (!rtwpci->enable_dac)
+		return;
+
+	switch (chip->chip_id) {
+	case RTL8852A:
+	case RTL8852B:
+	case RTL8851B:
+	case RTL8852BT:
+		break;
+	default:
+		return;
+	}
+
+	rtw89_pci_config_byte_set(rtwdev, RTW89_PCIE_L1_CTRL, RTW89_PCIE_BIT_EN_64BITS);
+}
+
 static int rtw89_pci_setup_mapping(struct rtw89_dev *rtwdev,
 				   struct pci_dev *pdev)
 {
@@ -3004,16 +3058,17 @@ static int rtw89_pci_setup_mapping(struct rtw89_dev *rtwdev,
 		goto err;
 	}
 
-	ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
-	if (ret) {
-		rtw89_err(rtwdev, "failed to set dma mask to 32-bit\n");
-		goto err_release_regions;
-	}
-
-	ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
-	if (ret) {
-		rtw89_err(rtwdev, "failed to set consistent dma mask to 32-bit\n");
-		goto err_release_regions;
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(36));
+	if (!ret) {
+		rtwpci->enable_dac = true;
+		rtw89_pci_cfg_dac(rtwdev);
+	} else {
+		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+		if (ret) {
+			rtw89_err(rtwdev,
+				  "failed to set dma and consistent mask to 32/36-bit\n");
+			goto err_release_regions;
+		}
 	}
 
 	resource_len = pci_resource_len(pdev, bar_id);
@@ -3164,6 +3219,7 @@ static int rtw89_pci_init_rx_bd(struct rtw89_dev *rtwdev, struct pci_dev *pdev,
 	memset(rx_bd, 0, sizeof(*rx_bd));
 	rx_bd->buf_size = cpu_to_le16(buf_sz);
 	rx_bd->dma = cpu_to_le32(dma);
+	rx_bd->opt = le16_encode_bits(upper_32_bits(dma), RTW89_PCI_RXBD_OPT_DMA_HI);
 	rx_info->dma = dma;
 
 	return 0;
@@ -4151,6 +4207,7 @@ static int __maybe_unused rtw89_pci_resume(struct device *dev)
 	}
 	rtw89_pci_l2_hci_ldo(rtwdev);
 	rtw89_pci_disable_eq(rtwdev);
+	rtw89_pci_cfg_dac(rtwdev);
 	rtw89_pci_filter_out(rtwdev);
 	rtw89_pci_link_cfg(rtwdev);
 	rtw89_pci_l1ss_cfg(rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index 7666753ae983..48c3ab735db2 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -724,6 +724,11 @@
 #define B_AX_CH11_BUSY			BIT(1)
 #define B_AX_CH10_BUSY			BIT(0)
 
+#define R_AX_WP_ADDR_H_SEL0_3 0x1334
+#define R_AX_WP_ADDR_H_SEL4_7 0x1338
+#define R_AX_WP_ADDR_H_SEL8_11 0x133C
+#define R_AX_WP_ADDR_H_SEL12_15 0x1340
+
 #define R_BE_HAXI_DMA_STOP1 0xB010
 #define B_BE_STOP_WPDMA BIT(31)
 #define B_BE_STOP_CH14 BIT(14)
@@ -823,6 +828,11 @@
 #define R_BE_RPQ0_RXBD_DESA_L_V1 0xB308
 #define R_BE_RPQ0_RXBD_DESA_H_V1 0xB30C
 
+#define R_BE_WP_ADDR_H_SEL0_3_V1 0xB420
+#define R_BE_WP_ADDR_H_SEL4_7_V1 0xB424
+#define R_BE_WP_ADDR_H_SEL8_11_V1 0xB428
+#define R_BE_WP_ADDR_H_SEL12_15_V1 0xB42C
+
 /* Configure */
 #define R_AX_PCIE_INIT_CFG2		0x1004
 #define B_AX_WD_ITVL_IDLE		GENMASK(27, 24)
@@ -1055,6 +1065,7 @@
 #define RTW89_PCIE_TIMER_CTRL		0x0718
 #define RTW89_PCIE_BIT_L1SUB		BIT(5)
 #define RTW89_PCIE_L1_CTRL		0x0719
+#define RTW89_PCIE_BIT_EN_64BITS	BIT(5)
 #define RTW89_PCIE_BIT_CLK		BIT(4)
 #define RTW89_PCIE_BIT_L1		BIT(3)
 #define RTW89_PCIE_CLK_CTRL		0x0725
@@ -1304,6 +1315,7 @@ struct rtw89_pci_info {
 	u32 rpwm_addr;
 	u32 cpwm_addr;
 	u32 mit_addr;
+	u32 wp_sel_addr;
 	u32 tx_dma_ch_mask;
 	const struct rtw89_pci_bd_idx_addr *bd_idx_addr_low_power;
 	const struct rtw89_pci_ch_dma_addr_set *dma_addr_set;
@@ -1330,11 +1342,11 @@ struct rtw89_pci_rx_info {
 	u32 fs:1, ls:1, tag:13, len:14;
 };
 
-#define RTW89_PCI_TXBD_OPTION_LS	BIT(14)
-
 struct rtw89_pci_tx_bd_32 {
 	__le16 length;
-	__le16 option;
+	__le16 opt;
+#define RTW89_PCI_TXBD_OPT_LS		BIT(14)
+#define RTW89_PCI_TXBD_OPT_DMA_HI	GENMASK(13, 6)
 	__le32 dma;
 } __packed;
 
@@ -1349,7 +1361,7 @@ struct rtw89_pci_tx_wp_info {
 
 #define RTW89_PCI_ADDR_MSDU_LS		BIT(15)
 #define RTW89_PCI_ADDR_LS		BIT(14)
-#define RTW89_PCI_ADDR_HIGH(a)		(((a) << 6) & GENMASK(13, 6))
+#define RTW89_PCI_ADDR_HIGH_MASK	GENMASK(13, 6)
 #define RTW89_PCI_ADDR_NUM(x)		((x) & GENMASK(5, 0))
 
 struct rtw89_pci_tx_addr_info_32 {
@@ -1386,7 +1398,8 @@ struct rtw89_pci_rpp_fmt {
 
 struct rtw89_pci_rx_bd_32 {
 	__le16 buf_size;
-	__le16 rsvd;
+	__le16 opt;
+#define RTW89_PCI_RXBD_OPT_DMA_HI	GENMASK(13, 6)
 	__le32 dma;
 } __packed;
 
@@ -1475,6 +1488,7 @@ struct rtw89_pci {
 	bool running;
 	bool low_power;
 	bool under_recovery;
+	bool enable_dac;
 	struct rtw89_pci_tx_ring tx_rings[RTW89_TXCH_NUM];
 	struct rtw89_pci_rx_ring rx_rings[RTW89_RXCH_NUM];
 	struct sk_buff_head h2c_queue;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851be.c b/drivers/net/wireless/realtek/rtw89/rtw8851be.c
index ec3629d95fda..d334924faec8 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851be.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851be.c
@@ -46,6 +46,7 @@ static const struct rtw89_pci_info rtw8851b_pci_info = {
 	.rpwm_addr		= R_AX_PCIE_HRPWM,
 	.cpwm_addr		= R_AX_CPWM,
 	.mit_addr		= R_AX_INT_MIT_RX,
+	.wp_sel_addr		= 0,
 	.tx_dma_ch_mask		= BIT(RTW89_TXCH_ACH4) | BIT(RTW89_TXCH_ACH5) |
 				  BIT(RTW89_TXCH_ACH6) | BIT(RTW89_TXCH_ACH7) |
 				  BIT(RTW89_TXCH_CH10) | BIT(RTW89_TXCH_CH11),
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
index fdee5dd4ba14..9a675e2193bc 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
@@ -46,6 +46,7 @@ static const struct rtw89_pci_info rtw8852a_pci_info = {
 	.rpwm_addr		= R_AX_PCIE_HRPWM,
 	.cpwm_addr		= R_AX_CPWM,
 	.mit_addr		= R_AX_INT_MIT_RX,
+	.wp_sel_addr		= 0,
 	.tx_dma_ch_mask		= 0,
 	.bd_idx_addr_low_power	= NULL,
 	.dma_addr_set		= &rtw89_pci_ch_dma_addr_set,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852be.c b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
index 5f941122655c..d8f9d92ca0fb 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852be.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
@@ -46,6 +46,7 @@ static const struct rtw89_pci_info rtw8852b_pci_info = {
 	.rpwm_addr		= R_AX_PCIE_HRPWM,
 	.cpwm_addr		= R_AX_CPWM,
 	.mit_addr		= R_AX_INT_MIT_RX,
+	.wp_sel_addr		= 0,
 	.tx_dma_ch_mask		= BIT(RTW89_TXCH_ACH4) | BIT(RTW89_TXCH_ACH5) |
 				  BIT(RTW89_TXCH_ACH6) | BIT(RTW89_TXCH_ACH7) |
 				  BIT(RTW89_TXCH_CH10) | BIT(RTW89_TXCH_CH11),
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
index e07c7f3ade41..8aaad7d58c0d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
@@ -55,6 +55,7 @@ static const struct rtw89_pci_info rtw8852c_pci_info = {
 	.rpwm_addr		= R_AX_PCIE_HRPWM_V1,
 	.cpwm_addr		= R_AX_PCIE_CRPWM,
 	.mit_addr		= R_AX_INT_MIT_RX_V1,
+	.wp_sel_addr		= R_AX_WP_ADDR_H_SEL0_3,
 	.tx_dma_ch_mask		= 0,
 	.bd_idx_addr_low_power	= &rtw8852c_bd_idx_addr_low_power,
 	.dma_addr_set		= &rtw89_pci_ch_dma_addr_set_v1,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922ae.c b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
index ce8aaa9501e1..47f855a7a268 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
@@ -46,6 +46,7 @@ static const struct rtw89_pci_info rtw8922a_pci_info = {
 	.rpwm_addr		= R_BE_PCIE_HRPWM,
 	.cpwm_addr		= R_BE_PCIE_CRPWM,
 	.mit_addr		= R_BE_PCIE_MIT_CH_EN,
+	.wp_sel_addr		= R_BE_WP_ADDR_H_SEL0_3_V1,
 	.tx_dma_ch_mask		= 0,
 	.bd_idx_addr_low_power	= NULL,
 	.dma_addr_set		= &rtw89_pci_ch_dma_addr_set_be,
-- 
2.25.1


