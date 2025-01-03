Return-Path: <linux-wireless+bounces-17023-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3014BA002DB
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 03:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43F771883DCB
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 02:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58532186E20;
	Fri,  3 Jan 2025 02:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Ugh97MsT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818AA19C56C
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jan 2025 02:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735872407; cv=none; b=l8+AAIAXhjJsYhf8eYvgRKJ8B1wjG8jhBvzWmU/TwpnpV9JNP5YK9iyr+OLg4yzLSfGho97M5EnVl1h1r2RGB0sEB+BKFV5g16WW5HTmdEpZJ3W0c9+/cH1OYPbSIaesrbKSo9W9Kl8xo8Enob7leo0/7tdfbdqIxGzg9oZUwzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735872407; c=relaxed/simple;
	bh=isxJd3HQKk7XxPIJpWxBeVOrZ4BCNldeeyd9lC8IW2U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OvJljbd2SFuS7n9j8uN4NQvuiwpbxjtCiwipgjCBH0FUYRLnJaSqLbCuTc/+gJNo0LkLmN8bcjvloiwmB5TwMfYI8uumPAE5KsD9lJO7Tu8afhBmO76AlguCJyhath5tYgp6MpIWNv5SQGP2JgUiL7RfaRTvoSay/Jo37DchtkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Ugh97MsT; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5032kfDsB1321071, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1735872402; bh=isxJd3HQKk7XxPIJpWxBeVOrZ4BCNldeeyd9lC8IW2U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=Ugh97MsTsrhdQ///8Qwe4VQfvxtsmPUeCqVr9XKKU72/hhxSdBVdtfx7gxkWShBtL
	 BxMK8fUULf6Lln2DVJxC5rG4gH8MszJ/njlMzFCdhKc4iPrYVNFc1KqkJtrnOaO444
	 NtgW50tI0kkVrtUOSytqRAAtDCfZPBumLW1k8PCQLsAC6tJjmq/CakKuKYKrchuEqS
	 /umNjsonp016mI6Sz7MpjZz3HWzcCPM7eLWKH7oFXz7F6RTjTBao3Qg4KE3eqiq30n
	 W/3Epmmwz10o8JU7Hb5mgdNI0bT7SYfWebvYXlaMhAo29mX06LiJretL4Tg12zuZFv
	 Wbw6XocEh7TbQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5032kfDsB1321071
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 3 Jan 2025 10:46:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 3 Jan 2025 10:46:42 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 3 Jan
 2025 10:46:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw89: pci: treat first receiving part as first segment for 8922AE
Date: Fri, 3 Jan 2025 10:46:09 +0800
Message-ID: <20250103024609.15135-1-pkshih@realtek.com>
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
enlarge 4 bytes for RX BD info, add a debug message to note if RX buffer
is possibly smaller than expected size.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
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


