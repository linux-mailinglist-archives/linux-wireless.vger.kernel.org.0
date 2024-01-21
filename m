Return-Path: <linux-wireless+bounces-2296-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E68978354D0
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jan 2024 08:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35D46B236B9
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jan 2024 07:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005DD364BD;
	Sun, 21 Jan 2024 07:19:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A378364BA
	for <linux-wireless@vger.kernel.org>; Sun, 21 Jan 2024 07:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705821551; cv=none; b=Erd948Iu4N2m5deTqsvtDa6XdzXtgK+1SDN/4OYy1hisJmigPSFW5Uv46Ln3DTASPZ25d5kjsXvV/MhZq5+kkLiKnBNKMZg34PFxDHIGa1ipnZ/YIidWrXVmnb2eKlWzlQOVYNIbUv+ixVjrSRAi2WaIRHg7n5NpYgl9ZRR5MF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705821551; c=relaxed/simple;
	bh=x4OnkdtyBsN2/JNYoDT1OfXKmaBQwCQlSd8a2osGG3A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lArGi8nQMEuOSt8DciufQCKfbJ+0vm53YbD8QBqSzCIM6gLZWJenvWmTkSSaKC21o4KP7vxMZWnrlYHhccU1KvSnzF051llmujqy+k4ID6TEVSqtcaKdCuCHZ6oLzG2z7wjIEaWRS219jVJsdlWA/SCC4kSk5e1dlfNXxTJ5g0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40L7J3A803102121, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40L7J3A803102121
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 21 Jan 2024 15:19:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Sun, 21 Jan 2024 15:19:03 +0800
Received: from [127.0.1.1] (172.16.17.107) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sun, 21 Jan
 2024 15:19:02 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/4] wifi: rtw89: pci: validate RX tag for RXQ and RPQ
Date: Sun, 21 Jan 2024 15:18:25 +0800
Message-ID: <20240121071826.10159-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240121071826.10159-1-pkshih@realtek.com>
References: <20240121071826.10159-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

PCI RX ring is a kind of read/write index ring, and DMA and ring index are
asynchronous, so suddenly driver gets newer index ahead before DMA. To
resolve this rare situation, we use a RX tag as helpers to make sure DMA
is done.

The RX tag is a 13-bit value, and range is from 1 ~ 0x1FFF, but 0 isn't
used so should be skipped.

Only enable this validation to coming WiFi 7 chips, because existing
chips use different design and don't really meet this situation.

Add missed rx_ring_eq_is_full for 8851BE by the way.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c      | 60 +++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/pci.h      |  4 +-
 .../net/wireless/realtek/rtw89/rtw8851be.c    |  2 +
 .../net/wireless/realtek/rtw89/rtw8852ae.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8852be.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8852ce.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8922ae.c    |  1 +
 7 files changed, 63 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 8227dc55e818..b51ec3cbc715 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -155,8 +155,8 @@ static void rtw89_pci_sync_skb_for_device(struct rtw89_dev *rtwdev,
 				   DMA_FROM_DEVICE);
 }
 
-static int rtw89_pci_rxbd_info_update(struct rtw89_dev *rtwdev,
-				      struct sk_buff *skb)
+static void rtw89_pci_rxbd_info_update(struct rtw89_dev *rtwdev,
+				       struct sk_buff *skb)
 {
 	struct rtw89_pci_rxbd_info *rxbd_info;
 	struct rtw89_pci_rx_info *rx_info = RTW89_PCI_RX_SKB_CB(skb);
@@ -166,10 +166,58 @@ static int rtw89_pci_rxbd_info_update(struct rtw89_dev *rtwdev,
 	rx_info->ls = le32_get_bits(rxbd_info->dword, RTW89_PCI_RXBD_LS);
 	rx_info->len = le32_get_bits(rxbd_info->dword, RTW89_PCI_RXBD_WRITE_SIZE);
 	rx_info->tag = le32_get_bits(rxbd_info->dword, RTW89_PCI_RXBD_TAG);
+}
+
+static int rtw89_pci_validate_rx_tag(struct rtw89_dev *rtwdev,
+				     struct rtw89_pci_rx_ring *rx_ring,
+				     struct sk_buff *skb)
+{
+	struct rtw89_pci_rx_info *rx_info = RTW89_PCI_RX_SKB_CB(skb);
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
+	u32 target_rx_tag;
+
+	if (!info->check_rx_tag)
+		return 0;
+
+	/* valid range is 1 ~ 0x1FFF */
+	if (rx_ring->target_rx_tag == 0)
+		target_rx_tag = 1;
+	else
+		target_rx_tag = rx_ring->target_rx_tag;
+
+	if (rx_info->tag != target_rx_tag) {
+		rtw89_debug(rtwdev, RTW89_DBG_UNEXP, "mismatch RX tag 0x%x 0x%x\n",
+			    rx_info->tag, target_rx_tag);
+		return -EAGAIN;
+	}
 
 	return 0;
 }
 
+static
+int rtw89_pci_sync_skb_for_device_and_validate_rx_info(struct rtw89_dev *rtwdev,
+						       struct rtw89_pci_rx_ring *rx_ring,
+						       struct sk_buff *skb)
+{
+	struct rtw89_pci_rx_info *rx_info = RTW89_PCI_RX_SKB_CB(skb);
+	int rx_tag_retry = 100;
+	int ret;
+
+	do {
+		rtw89_pci_sync_skb_for_cpu(rtwdev, skb);
+		rtw89_pci_rxbd_info_update(rtwdev, skb);
+
+		ret = rtw89_pci_validate_rx_tag(rtwdev, rx_ring, skb);
+		if (ret != -EAGAIN)
+			break;
+	} while (rx_tag_retry--);
+
+	/* update target rx_tag for next RX */
+	rx_ring->target_rx_tag = rx_info->tag + 1;
+
+	return ret;
+}
+
 static void rtw89_pci_ctrl_txdma_ch_pcie(struct rtw89_dev *rtwdev, bool enable)
 {
 	const struct rtw89_pci_info *info = rtwdev->pci_info;
@@ -259,9 +307,8 @@ static u32 rtw89_pci_rxbd_deliver_skbs(struct rtw89_dev *rtwdev,
 
 	skb_idx = rtw89_pci_get_rx_skb_idx(rtwdev, bd_ring);
 	skb = rx_ring->buf[skb_idx];
-	rtw89_pci_sync_skb_for_cpu(rtwdev, skb);
 
-	ret = rtw89_pci_rxbd_info_update(rtwdev, skb);
+	ret = rtw89_pci_sync_skb_for_device_and_validate_rx_info(rtwdev, rx_ring, skb);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to update %d RXBD info: %d\n",
 			  bd_ring->wp, ret);
@@ -549,9 +596,8 @@ static u32 rtw89_pci_release_tx_skbs(struct rtw89_dev *rtwdev,
 
 	skb_idx = rtw89_pci_get_rx_skb_idx(rtwdev, bd_ring);
 	skb = rx_ring->buf[skb_idx];
-	rtw89_pci_sync_skb_for_cpu(rtwdev, skb);
 
-	ret = rtw89_pci_rxbd_info_update(rtwdev, skb);
+	ret = rtw89_pci_sync_skb_for_device_and_validate_rx_info(rtwdev, rx_ring, skb);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to update %d RXBD info: %d\n",
 			  bd_ring->wp, ret);
@@ -1550,6 +1596,7 @@ static void rtw89_pci_reset_trx_rings(struct rtw89_dev *rtwdev)
 		bd_ring->rp = 0;
 		rx_ring->diliver_skb = NULL;
 		rx_ring->diliver_desc.ready = false;
+		rx_ring->target_rx_tag = 0;
 
 		rtw89_write16(rtwdev, addr_num, bd_ring->len);
 		rtw89_write32(rtwdev, addr_desa_l, bd_ring->dma);
@@ -3213,6 +3260,7 @@ static int rtw89_pci_alloc_rx_ring(struct rtw89_dev *rtwdev,
 	rx_ring->buf_sz = buf_sz;
 	rx_ring->diliver_skb = NULL;
 	rx_ring->diliver_desc.ready = false;
+	rx_ring->target_rx_tag = 0;
 
 	for (i = 0; i < len; i++) {
 		skb = dev_alloc_skb(buf_sz);
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index 1fb7c209fa0d..0543221b4c58 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -1235,6 +1235,7 @@ struct rtw89_pci_info {
 	enum mac_ax_pcie_func_ctrl io_rcy_en;
 	enum mac_ax_io_rcy_tmr io_rcy_tmr;
 	bool rx_ring_eq_is_full;
+	bool check_rx_tag;
 
 	u32 init_cfg_reg;
 	u32 txhci_en_bit;
@@ -1277,7 +1278,7 @@ struct rtw89_pci_tx_data {
 
 struct rtw89_pci_rx_info {
 	dma_addr_t dma;
-	u32 fs:1, ls:1, tag:11, len:14;
+	u32 fs:1, ls:1, tag:13, len:14;
 };
 
 #define RTW89_PCI_TXBD_OPTION_LS	BIT(14)
@@ -1406,6 +1407,7 @@ struct rtw89_pci_rx_ring {
 	u32 buf_sz;
 	struct sk_buff *diliver_skb;
 	struct rtw89_rx_desc_info diliver_desc;
+	u32 target_rx_tag:13;
 };
 
 struct rtw89_pci_isrs {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851be.c b/drivers/net/wireless/realtek/rtw89/rtw8851be.c
index ade69bd30fc8..ca1374a71727 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851be.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851be.c
@@ -25,6 +25,8 @@ static const struct rtw89_pci_info rtw8851b_pci_info = {
 	.autok_en		= MAC_AX_PCIE_DISABLE,
 	.io_rcy_en		= MAC_AX_PCIE_DISABLE,
 	.io_rcy_tmr		= MAC_AX_IO_RCY_ANA_TMR_6MS,
+	.rx_ring_eq_is_full	= false,
+	.check_rx_tag		= false,
 
 	.init_cfg_reg		= R_AX_PCIE_INIT_CFG1,
 	.txhci_en_bit		= B_AX_TXHCI_EN,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
index f1e890bde049..7c6ffedb77e2 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
@@ -26,6 +26,7 @@ static const struct rtw89_pci_info rtw8852a_pci_info = {
 	.io_rcy_en		= MAC_AX_PCIE_DISABLE,
 	.io_rcy_tmr		= MAC_AX_IO_RCY_ANA_TMR_6MS,
 	.rx_ring_eq_is_full	= false,
+	.check_rx_tag		= false,
 
 	.init_cfg_reg		= R_AX_PCIE_INIT_CFG1,
 	.txhci_en_bit		= B_AX_TXHCI_EN,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852be.c b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
index 920b20bbcfb7..ed71364e6437 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852be.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
@@ -26,6 +26,7 @@ static const struct rtw89_pci_info rtw8852b_pci_info = {
 	.io_rcy_en		= MAC_AX_PCIE_DISABLE,
 	.io_rcy_tmr		= MAC_AX_IO_RCY_ANA_TMR_6MS,
 	.rx_ring_eq_is_full	= false,
+	.check_rx_tag		= false,
 
 	.init_cfg_reg		= R_AX_PCIE_INIT_CFG1,
 	.txhci_en_bit		= B_AX_TXHCI_EN,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
index 4592de3dbd94..583ea673a4f5 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
@@ -35,6 +35,7 @@ static const struct rtw89_pci_info rtw8852c_pci_info = {
 	.io_rcy_en		= MAC_AX_PCIE_ENABLE,
 	.io_rcy_tmr		= MAC_AX_IO_RCY_ANA_TMR_6MS,
 	.rx_ring_eq_is_full	= false,
+	.check_rx_tag		= false,
 
 	.init_cfg_reg		= R_AX_HAXI_INIT_CFG1,
 	.txhci_en_bit		= B_AX_TXHCI_EN_V1,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922ae.c b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
index 7b3d98d2c402..9f46fb166105 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
@@ -26,6 +26,7 @@ static const struct rtw89_pci_info rtw8922a_pci_info = {
 	.io_rcy_en		= MAC_AX_PCIE_ENABLE,
 	.io_rcy_tmr		= MAC_AX_IO_RCY_ANA_TMR_DEF,
 	.rx_ring_eq_is_full	= true,
+	.check_rx_tag		= true,
 
 	.init_cfg_reg		= R_BE_HAXI_INIT_CFG1,
 	.txhci_en_bit		= B_BE_TXDMA_EN,
-- 
2.25.1


