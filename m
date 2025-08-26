Return-Path: <linux-wireless+bounces-26621-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F690B357B2
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 10:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 020CD4E3EE0
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 08:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A079460;
	Tue, 26 Aug 2025 08:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="PjgEyonz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E45C227E82
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 08:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756198466; cv=none; b=EG5GbMhhXYkRswXJq59ajqtv3mmHMmt4McFvfMA6hW3ZzkzwjbGJ3Z2t6p9gyVtaqMK0JdUmgqA2i+8gteWceZcc6Yx9LWatcPwD54qvupRT6+MvuID93vsOjLI1Yqt7n5Ig2MB+f/oEurp/nxMQavigxQTsSxzYWvR/vDUKBlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756198466; c=relaxed/simple;
	bh=TKgM6/6RhtvlYbnMrML/3huK+qaOWIP0e4BOwXSkQu0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZhwGgt3sVlZkq7DwDGFIvjucM44otqyoqOhm1ebl0LhtOBk+Q5yMFB+vuhb09r5qCx+Wn8j/dwCl/RVmDSE21UK2Wx6md3xaC10cK3zg3UmQx0GShK6j9gBUezNEZL27YdWWh2mEAqb0a8mZ4z2aqQ7cHAluI9h7sdBPQyDVU7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=PjgEyonz; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57Q8sK6y91262356, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1756198460; bh=RBKJb9zC/MrY29wPCfg5k4909QpFe5ErMDnsfnmw3Uo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=PjgEyonzCUSwbu7j9TXFLLs/ibfJTvumkln5kElSBVMfHDIJO3v7M2hz11j9QGumG
	 FGJBSFUzDetjNSrG7fSfBggUwHB4qaor3RY+Ynv4gEO4JvwZQfCu79hKNRPxb+TtVT
	 4/Ii/w11f3zFBeMUwlSQuDP7XbkyUdzTrxv3f+jfHuVrIXiNivpVY9muXqCY+WelVq
	 t4M3Zhuhhefm/4+HB+3js9S58dNgo2rVlcz0/rZ9dPQOWgDxUzRpR6ajEOOoRd29we
	 vkoGn9DSNRSPiBAOuKiyABHXzVKs/kRLshILdDVxXSRDXrCp+vGggHUg6wcWN0IkE5
	 YqoiqLTAP12uw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57Q8sK6y91262356
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 16:54:20 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 26 Aug 2025 16:54:20 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Tue, 26 Aug
 2025 16:54:20 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 07/10] wifi: rtw89: pci: abstract RPP parser
Date: Tue, 26 Aug 2025 16:53:24 +0800
Message-ID: <20250826085324.28414-1-pkshih@realtek.com>
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

RPP is short for release report of payload, which carries information
assisting TX completion. Since coming chips change the format, abstract
the parser ahead.

Don't change logic at all.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c      | 46 +++++++++++--------
 drivers/net/wireless/realtek/rtw89/pci.h      | 12 +++++
 .../net/wireless/realtek/rtw89/rtw8851be.c    |  2 +
 .../net/wireless/realtek/rtw89/rtw8852ae.c    |  2 +
 .../net/wireless/realtek/rtw89/rtw8852be.c    |  2 +
 .../net/wireless/realtek/rtw89/rtw8852bte.c   |  2 +
 .../net/wireless/realtek/rtw89/rtw8852ce.c    |  2 +
 .../net/wireless/realtek/rtw89/rtw8922ae.c    |  2 +
 8 files changed, 52 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 55d82af732c0..cc54694859a6 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -568,31 +568,40 @@ static void rtw89_pci_release_txwd_skb(struct rtw89_dev *rtwdev,
 		rtw89_pci_enqueue_txwd(tx_ring, txwd);
 }
 
-static void rtw89_pci_release_rpp(struct rtw89_dev *rtwdev,
-				  struct rtw89_pci_rpp_fmt *rpp)
+void rtw89_pci_parse_rpp(struct rtw89_dev *rtwdev, void *_rpp,
+			 struct rtw89_pci_rpp_info *rpp_info)
+{
+	const struct rtw89_pci_rpp_fmt *rpp = _rpp;
+
+	rpp_info->seq = le32_get_bits(rpp->dword, RTW89_PCI_RPP_SEQ);
+	rpp_info->qsel = le32_get_bits(rpp->dword, RTW89_PCI_RPP_QSEL);
+	rpp_info->tx_status = le32_get_bits(rpp->dword, RTW89_PCI_RPP_TX_STATUS);
+	rpp_info->txch = rtw89_core_get_ch_dma(rtwdev, rpp_info->qsel);
+}
+EXPORT_SYMBOL(rtw89_pci_parse_rpp);
+
+static void rtw89_pci_release_rpp(struct rtw89_dev *rtwdev, void *rpp)
 {
 	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
-	struct rtw89_pci_tx_ring *tx_ring;
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
+	struct rtw89_pci_rpp_info rpp_info = {};
 	struct rtw89_pci_tx_wd_ring *wd_ring;
+	struct rtw89_pci_tx_ring *tx_ring;
 	struct rtw89_pci_tx_wd *txwd;
-	u16 seq;
-	u8 qsel, tx_status, txch;
 
-	seq = le32_get_bits(rpp->dword, RTW89_PCI_RPP_SEQ);
-	qsel = le32_get_bits(rpp->dword, RTW89_PCI_RPP_QSEL);
-	tx_status = le32_get_bits(rpp->dword, RTW89_PCI_RPP_TX_STATUS);
-	txch = rtw89_core_get_ch_dma(rtwdev, qsel);
+	info->parse_rpp(rtwdev, rpp, &rpp_info);
 
-	if (txch == RTW89_TXCH_CH12) {
+	if (rpp_info.txch == RTW89_TXCH_CH12) {
 		rtw89_warn(rtwdev, "should no fwcmd release report\n");
 		return;
 	}
 
-	tx_ring = &rtwpci->tx.rings[txch];
+	tx_ring = &rtwpci->tx.rings[rpp_info.txch];
 	wd_ring = &tx_ring->wd_ring;
-	txwd = &wd_ring->pages[seq];
+	txwd = &wd_ring->pages[rpp_info.seq];
 
-	rtw89_pci_release_txwd_skb(rtwdev, tx_ring, txwd, seq, tx_status);
+	rtw89_pci_release_txwd_skb(rtwdev, tx_ring, txwd, rpp_info.seq,
+				   rpp_info.tx_status);
 }
 
 static void rtw89_pci_release_pending_txwd_skb(struct rtw89_dev *rtwdev,
@@ -617,13 +626,14 @@ static u32 rtw89_pci_release_tx_skbs(struct rtw89_dev *rtwdev,
 				     u32 max_cnt)
 {
 	struct rtw89_pci_dma_ring *bd_ring = &rx_ring->bd_ring;
-	struct rtw89_pci_rx_info *rx_info;
-	struct rtw89_pci_rpp_fmt *rpp;
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
 	struct rtw89_rx_desc_info desc_info = {};
+	struct rtw89_pci_rx_info *rx_info;
 	struct sk_buff *skb;
-	u32 cnt = 0;
-	u32 rpp_size = sizeof(struct rtw89_pci_rpp_fmt);
+	void *rpp;
 	u32 rxinfo_size = sizeof(struct rtw89_pci_rxbd_info);
+	u32 rpp_size = info->rpp_fmt_size;
+	u32 cnt = 0;
 	u32 skb_idx;
 	u32 offset;
 	int ret;
@@ -649,7 +659,7 @@ static u32 rtw89_pci_release_tx_skbs(struct rtw89_dev *rtwdev,
 	/* first segment has RX desc */
 	offset = desc_info.offset + desc_info.rxd_len;
 	for (; offset + rpp_size <= rx_info->len; offset += rpp_size) {
-		rpp = (struct rtw89_pci_rpp_fmt *)(skb->data + offset);
+		rpp = skb->data + offset;
 		rtw89_pci_release_rpp(rtwdev, rpp);
 	}
 
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index e8a856537b7c..b0c6f4d38bf5 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -1365,6 +1365,13 @@ struct rtw89_pci_ssid_quirk {
 	unsigned long bitmap; /* bitmap of rtw89_quirks */
 };
 
+struct rtw89_pci_rpp_info {
+	u16 seq;
+	u8 qsel;
+	u8 tx_status;
+	u8 txch;
+};
+
 struct rtw89_pci_info {
 	const struct rtw89_pci_gen_def *gen_def;
 	const struct rtw89_pci_isr_def *isr_def;
@@ -1386,6 +1393,7 @@ struct rtw89_pci_info {
 	bool check_rx_tag;
 	bool no_rxbd_fs;
 	bool group_bd_addr;
+	u32 rpp_fmt_size;
 
 	u32 init_cfg_reg;
 	u32 txhci_en_bit;
@@ -1415,6 +1423,8 @@ struct rtw89_pci_info {
 	u32 (*fill_txaddr_info)(struct rtw89_dev *rtwdev,
 				void *txaddr_info_addr, u32 total_len,
 				dma_addr_t dma, u8 *add_info_nr);
+	void (*parse_rpp)(struct rtw89_dev *rtwdev, void *rpp,
+			  struct rtw89_pci_rpp_info *rpp_info);
 	void (*config_intr_mask)(struct rtw89_dev *rtwdev);
 	void (*enable_intr)(struct rtw89_dev *rtwdev, struct rtw89_pci *rtwpci);
 	void (*disable_intr)(struct rtw89_dev *rtwdev, struct rtw89_pci *rtwpci);
@@ -1724,6 +1734,8 @@ u32 rtw89_pci_fill_txaddr_info(struct rtw89_dev *rtwdev,
 u32 rtw89_pci_fill_txaddr_info_v1(struct rtw89_dev *rtwdev,
 				  void *txaddr_info_addr, u32 total_len,
 				  dma_addr_t dma, u8 *add_info_nr);
+void rtw89_pci_parse_rpp(struct rtw89_dev *rtwdev, void *_rpp,
+			 struct rtw89_pci_rpp_info *rpp_info);
 void rtw89_pci_ctrl_dma_all(struct rtw89_dev *rtwdev, bool enable);
 void rtw89_pci_config_intr_mask(struct rtw89_dev *rtwdev);
 void rtw89_pci_config_intr_mask_v1(struct rtw89_dev *rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851be.c b/drivers/net/wireless/realtek/rtw89/rtw8851be.c
index d2ea1e237a1f..ce59ac9f56ba 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851be.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851be.c
@@ -30,6 +30,7 @@ static const struct rtw89_pci_info rtw8851b_pci_info = {
 	.check_rx_tag		= false,
 	.no_rxbd_fs		= false,
 	.group_bd_addr		= false,
+	.rpp_fmt_size		= sizeof(struct rtw89_pci_rpp_fmt),
 
 	.init_cfg_reg		= R_AX_PCIE_INIT_CFG1,
 	.txhci_en_bit		= B_AX_TXHCI_EN,
@@ -59,6 +60,7 @@ static const struct rtw89_pci_info rtw8851b_pci_info = {
 
 	.ltr_set		= rtw89_pci_ltr_set,
 	.fill_txaddr_info	= rtw89_pci_fill_txaddr_info,
+	.parse_rpp		= rtw89_pci_parse_rpp,
 	.config_intr_mask	= rtw89_pci_config_intr_mask,
 	.enable_intr		= rtw89_pci_enable_intr,
 	.disable_intr		= rtw89_pci_disable_intr,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
index d733264b5dd1..9e05e831569d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
@@ -30,6 +30,7 @@ static const struct rtw89_pci_info rtw8852a_pci_info = {
 	.check_rx_tag		= false,
 	.no_rxbd_fs		= false,
 	.group_bd_addr		= false,
+	.rpp_fmt_size		= sizeof(struct rtw89_pci_rpp_fmt),
 
 	.init_cfg_reg		= R_AX_PCIE_INIT_CFG1,
 	.txhci_en_bit		= B_AX_TXHCI_EN,
@@ -57,6 +58,7 @@ static const struct rtw89_pci_info rtw8852a_pci_info = {
 
 	.ltr_set		= rtw89_pci_ltr_set,
 	.fill_txaddr_info	= rtw89_pci_fill_txaddr_info,
+	.parse_rpp		= rtw89_pci_parse_rpp,
 	.config_intr_mask	= rtw89_pci_config_intr_mask,
 	.enable_intr		= rtw89_pci_enable_intr,
 	.disable_intr		= rtw89_pci_disable_intr,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852be.c b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
index 146a1f2292d7..12db0d0be547 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852be.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
@@ -30,6 +30,7 @@ static const struct rtw89_pci_info rtw8852b_pci_info = {
 	.check_rx_tag		= false,
 	.no_rxbd_fs		= false,
 	.group_bd_addr		= false,
+	.rpp_fmt_size		= sizeof(struct rtw89_pci_rpp_fmt),
 
 	.init_cfg_reg		= R_AX_PCIE_INIT_CFG1,
 	.txhci_en_bit		= B_AX_TXHCI_EN,
@@ -59,6 +60,7 @@ static const struct rtw89_pci_info rtw8852b_pci_info = {
 
 	.ltr_set		= rtw89_pci_ltr_set,
 	.fill_txaddr_info	= rtw89_pci_fill_txaddr_info,
+	.parse_rpp		= rtw89_pci_parse_rpp,
 	.config_intr_mask	= rtw89_pci_config_intr_mask,
 	.enable_intr		= rtw89_pci_enable_intr,
 	.disable_intr		= rtw89_pci_disable_intr,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bte.c b/drivers/net/wireless/realtek/rtw89/rtw8852bte.c
index 5373b13e3470..8c995aa95325 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bte.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bte.c
@@ -36,6 +36,7 @@ static const struct rtw89_pci_info rtw8852bt_pci_info = {
 	.check_rx_tag		= false,
 	.no_rxbd_fs		= false,
 	.group_bd_addr		= false,
+	.rpp_fmt_size		= sizeof(struct rtw89_pci_rpp_fmt),
 
 	.init_cfg_reg		= R_AX_PCIE_INIT_CFG1,
 	.txhci_en_bit		= B_AX_TXHCI_EN,
@@ -65,6 +66,7 @@ static const struct rtw89_pci_info rtw8852bt_pci_info = {
 
 	.ltr_set		= rtw89_pci_ltr_set,
 	.fill_txaddr_info	= rtw89_pci_fill_txaddr_info,
+	.parse_rpp		= rtw89_pci_parse_rpp,
 	.config_intr_mask	= rtw89_pci_config_intr_mask,
 	.enable_intr		= rtw89_pci_enable_intr,
 	.disable_intr		= rtw89_pci_disable_intr,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
index b2bf4ba6ddd8..150fed189414 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
@@ -39,6 +39,7 @@ static const struct rtw89_pci_info rtw8852c_pci_info = {
 	.check_rx_tag		= false,
 	.no_rxbd_fs		= false,
 	.group_bd_addr		= false,
+	.rpp_fmt_size		= sizeof(struct rtw89_pci_rpp_fmt),
 
 	.init_cfg_reg		= R_AX_HAXI_INIT_CFG1,
 	.txhci_en_bit		= B_AX_TXHCI_EN_V1,
@@ -66,6 +67,7 @@ static const struct rtw89_pci_info rtw8852c_pci_info = {
 
 	.ltr_set		= rtw89_pci_ltr_set_v1,
 	.fill_txaddr_info	= rtw89_pci_fill_txaddr_info_v1,
+	.parse_rpp		= rtw89_pci_parse_rpp,
 	.config_intr_mask	= rtw89_pci_config_intr_mask_v1,
 	.enable_intr		= rtw89_pci_enable_intr_v1,
 	.disable_intr		= rtw89_pci_disable_intr_v1,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922ae.c b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
index 32144fc66e4a..90c62b757c57 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
@@ -36,6 +36,7 @@ static const struct rtw89_pci_info rtw8922a_pci_info = {
 	.check_rx_tag		= true,
 	.no_rxbd_fs		= true,
 	.group_bd_addr		= false,
+	.rpp_fmt_size		= sizeof(struct rtw89_pci_rpp_fmt),
 
 	.init_cfg_reg		= R_BE_HAXI_INIT_CFG1,
 	.txhci_en_bit		= B_BE_TXDMA_EN,
@@ -63,6 +64,7 @@ static const struct rtw89_pci_info rtw8922a_pci_info = {
 
 	.ltr_set		= rtw89_pci_ltr_set_v2,
 	.fill_txaddr_info	= rtw89_pci_fill_txaddr_info_v1,
+	.parse_rpp		= rtw89_pci_parse_rpp,
 	.config_intr_mask	= rtw89_pci_config_intr_mask_v2,
 	.enable_intr		= rtw89_pci_enable_intr_v2,
 	.disable_intr		= rtw89_pci_disable_intr_v2,
-- 
2.25.1


