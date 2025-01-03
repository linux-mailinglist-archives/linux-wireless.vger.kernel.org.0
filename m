Return-Path: <linux-wireless+bounces-17024-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E8CA002E6
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 03:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54339162BAB
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 02:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1B514B96E;
	Fri,  3 Jan 2025 02:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="r1ZmIVMN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6143343173
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jan 2025 02:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735872723; cv=none; b=J21zNUivttFnnCqdGR3VPVT1iMXzJnib2EvzZuPmN6lzGPmQpYIvFrslsFUpYu4+gFMT2JcDWaexD+GGWmWEfQOsiHxP3BpnI+YKbvS1aH97t1AmhFJaCvHUy+YcC1JY27OOZ+IXfsxl5jsxda/eFrFpKKPGT6G7TnQs6T9npec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735872723; c=relaxed/simple;
	bh=XAX/AB0MK3+q2UDV7LOJzdMQTzZmaMFlaOJ6R6qKRhI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BEZDVfulXsyAB4Vdq2aqo+Tz+9SADquklC14qC/AZa1cvnt/wsZIQHiAdQyEyxBeswRlynLqjTtZy88l1MqXppRvdGtIbADdkiwRWosxDjvGSQVcaiF1ZYjCReRq6QauRXE5CMjgc8qEBjHe2vN7EEtoab0/qnIem56XC79TD7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=r1ZmIVMN; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5032pwGtB1324774, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1735872718; bh=XAX/AB0MK3+q2UDV7LOJzdMQTzZmaMFlaOJ6R6qKRhI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=r1ZmIVMNCcQc0CWsdt41t3lQsvc7nREnyXEIbPG/Ko9p36q6pV1uAs609o49vZXYu
	 nF3TfsBK/PAfO/EqSNmbiuJ4BY7ypFUFnBlVdctWDsohy4g8+WZ4y9Grzgo3WLh/ha
	 RURzz4xJhdLog6GkHcGe0kzq87ndKoD4Trmt8iPvu3bGzXi/WrFRzzMnOyC+adLO8x
	 rFPnsi9Iwzjl1lqdekpjvBRefM8HUy9rPgE+wUjU9QOMLeO8z6qnRphXWXUfFhPYsS
	 PNVUCLpj1mYdQyl54ODrwTMtvQVwRGbKj434Pfank36/wo9ENnG8gFRK0O4gmruB75
	 914E7sYWJl2ug==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5032pwGtB1324774
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 3 Jan 2025 10:51:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 3 Jan 2025 10:51:59 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 3 Jan
 2025 10:51:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH v2] wifi: rtw89: pci: treat first receiving part as first segment for 8922AE
Date: Fri, 3 Jan 2025 10:51:26 +0800
Message-ID: <20250103025126.15378-1-pkshih@realtek.com>
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

For early chips, the RX BD info contains FS/LS bits for first/last segments
of a receiving packet. For 8922AE, the FS bit should be ignored, or it
may throw warning:

  rtw89_8922ae 0000:1a:00.0: skb should not be ready before first segment start

To have compatible logic, FS determined by what pending skb is existing
(!new) or not.

Since we expect every single receiving packet in single one segment,
enlarge 4 bytes for RX BD info, and add a debug message to note if
RX buffer is possibly smaller than expected size.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: correct wording in commit message
---
 drivers/net/wireless/realtek/rtw89/pci.c        | 12 +++++++++---
 drivers/net/wireless/realtek/rtw89/pci.h        |  4 +++-
 drivers/net/wireless/realtek/rtw89/rtw8851be.c  |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852ae.c  |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852be.c  |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852bte.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852ce.c  |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922ae.c  |  1 +
 8 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index c3a027735d0f..a95e57679cab 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -321,10 +321,11 @@ static u32 rtw89_pci_get_rx_skb_idx(struct rtw89_dev *rtwdev,
 static u32 rtw89_pci_rxbd_deliver_skbs(struct rtw89_dev *rtwdev,
 				       struct rtw89_pci_rx_ring *rx_ring)
 {
-	struct rtw89_pci_dma_ring *bd_ring = &rx_ring->bd_ring;
-	struct rtw89_pci_rx_info *rx_info;
 	struct rtw89_rx_desc_info *desc_info = &rx_ring->diliver_desc;
+	struct rtw89_pci_dma_ring *bd_ring = &rx_ring->bd_ring;
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
 	struct sk_buff *new = rx_ring->diliver_skb;
+	struct rtw89_pci_rx_info *rx_info;
 	struct sk_buff *skb;
 	u32 rxinfo_size = sizeof(struct rtw89_pci_rxbd_info);
 	u32 skb_idx;
@@ -344,9 +345,14 @@ static u32 rtw89_pci_rxbd_deliver_skbs(struct rtw89_dev *rtwdev,
 	}
 
 	rx_info = RTW89_PCI_RX_SKB_CB(skb);
-	fs = rx_info->fs;
+	fs = info->no_rxbd_fs ? !new : rx_info->fs;
 	ls = rx_info->ls;
 
+	if (unlikely(!fs || !ls))
+		rtw89_debug(rtwdev, RTW89_DBG_UNEXP,
+			    "unexpected fs/ls=%d/%d tag=%u len=%u new->len=%u\n",
+			    fs, ls, rx_info->tag, rx_info->len, new ? new->len : 0);
+
 	if (fs) {
 		if (new) {
 			rtw89_debug(rtwdev, RTW89_DBG_UNEXP,
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index d52db4ca1b99..4d11c3dd60a5 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -1051,7 +1051,8 @@
 #define RTW89_PCI_TXWD_NUM_MAX		512
 #define RTW89_PCI_TXWD_PAGE_SIZE	128
 #define RTW89_PCI_ADDRINFO_MAX		4
-#define RTW89_PCI_RX_BUF_SIZE		(11454 + 40) /* +40 for rtw89_rxdesc_long_v2 */
+/* +40 for rtw89_rxdesc_long_v2; +4 for rtw89_pci_rxbd_info */
+#define RTW89_PCI_RX_BUF_SIZE		(11454 + 40 + 4)
 
 #define RTW89_PCI_POLL_BDRAM_RST_CNT	100
 #define RTW89_PCI_MULTITAG		8
@@ -1324,6 +1325,7 @@ struct rtw89_pci_info {
 	enum mac_ax_io_rcy_tmr io_rcy_tmr;
 	bool rx_ring_eq_is_full;
 	bool check_rx_tag;
+	bool no_rxbd_fs;
 
 	u32 init_cfg_reg;
 	u32 txhci_en_bit;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851be.c b/drivers/net/wireless/realtek/rtw89/rtw8851be.c
index 651cbce1dd7e..cfe744cc7f30 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851be.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851be.c
@@ -27,6 +27,7 @@ static const struct rtw89_pci_info rtw8851b_pci_info = {
 	.io_rcy_tmr		= MAC_AX_IO_RCY_ANA_TMR_6MS,
 	.rx_ring_eq_is_full	= false,
 	.check_rx_tag		= false,
+	.no_rxbd_fs		= false,
 
 	.init_cfg_reg		= R_AX_PCIE_INIT_CFG1,
 	.txhci_en_bit		= B_AX_TXHCI_EN,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
index 701187d69e14..08e39f0572bc 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
@@ -27,6 +27,7 @@ static const struct rtw89_pci_info rtw8852a_pci_info = {
 	.io_rcy_tmr		= MAC_AX_IO_RCY_ANA_TMR_6MS,
 	.rx_ring_eq_is_full	= false,
 	.check_rx_tag		= false,
+	.no_rxbd_fs		= false,
 
 	.init_cfg_reg		= R_AX_PCIE_INIT_CFG1,
 	.txhci_en_bit		= B_AX_TXHCI_EN,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852be.c b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
index a13ea1cce4a7..42004ac52aee 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852be.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
@@ -27,6 +27,7 @@ static const struct rtw89_pci_info rtw8852b_pci_info = {
 	.io_rcy_tmr		= MAC_AX_IO_RCY_ANA_TMR_6MS,
 	.rx_ring_eq_is_full	= false,
 	.check_rx_tag		= false,
+	.no_rxbd_fs		= false,
 
 	.init_cfg_reg		= R_AX_PCIE_INIT_CFG1,
 	.txhci_en_bit		= B_AX_TXHCI_EN,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bte.c b/drivers/net/wireless/realtek/rtw89/rtw8852bte.c
index d1eebecfcd73..e482c9893e11 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bte.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bte.c
@@ -33,6 +33,7 @@ static const struct rtw89_pci_info rtw8852bt_pci_info = {
 	.io_rcy_tmr		= MAC_AX_IO_RCY_ANA_TMR_6MS,
 	.rx_ring_eq_is_full	= false,
 	.check_rx_tag		= false,
+	.no_rxbd_fs		= false,
 
 	.init_cfg_reg		= R_AX_PCIE_INIT_CFG1,
 	.txhci_en_bit		= B_AX_TXHCI_EN,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
index 1a46878be96b..6b565acc4cdf 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
@@ -36,6 +36,7 @@ static const struct rtw89_pci_info rtw8852c_pci_info = {
 	.io_rcy_tmr		= MAC_AX_IO_RCY_ANA_TMR_6MS,
 	.rx_ring_eq_is_full	= false,
 	.check_rx_tag		= false,
+	.no_rxbd_fs		= false,
 
 	.init_cfg_reg		= R_AX_HAXI_INIT_CFG1,
 	.txhci_en_bit		= B_AX_TXHCI_EN_V1,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922ae.c b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
index edfb1f220af0..568d5bd134f9 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
@@ -33,6 +33,7 @@ static const struct rtw89_pci_info rtw8922a_pci_info = {
 	.io_rcy_tmr		= MAC_AX_IO_RCY_ANA_TMR_DEF,
 	.rx_ring_eq_is_full	= true,
 	.check_rx_tag		= true,
+	.no_rxbd_fs		= true,
 
 	.init_cfg_reg		= R_BE_HAXI_INIT_CFG1,
 	.txhci_en_bit		= B_BE_TXDMA_EN,
-- 
2.25.1


