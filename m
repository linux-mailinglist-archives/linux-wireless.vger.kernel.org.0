Return-Path: <linux-wireless+bounces-4316-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8006E86EDAB
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Mar 2024 01:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3698F286D2D
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Mar 2024 00:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D64747F;
	Sat,  2 Mar 2024 00:59:49 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BDB7464
	for <linux-wireless@vger.kernel.org>; Sat,  2 Mar 2024 00:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709341188; cv=none; b=bRaPBJsX/28/4KpSmC7VFbrjNV7c29Cd1q3p7jOQbH58lREjHuCsAcso6x/zLZpQFhuNrDNiqjQ9FJtdZb79BZdPq2Keu/xNgx/p+dIqvEpePLmHFdIa0eF226BKLYFNJWZDNQFIWXfxTgIBHhZLVciQYs2ATAWVkgju3n6o0Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709341188; c=relaxed/simple;
	bh=6HlIZVryYgoEGsEeKBs68v3Lqs8Jq+wifQYwuvxEv9A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nlu71Fjug61ch5xHxiuH8mxPOSUocsc8UcsdNpW+3Tyt4BnbFKEffD6UgvcxakbYWZTFXwbRANz85A+8NHXpd6Go/feInopRMbKVfMZlBANAiOGmzLBI6NfLtfOqpQZzjpO5dWNiymGacPpnh2ZLe6e6Q0+5yxEtBtzH1RGu+Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4220xfDsB2370274, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4220xfDsB2370274
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 2 Mar 2024 08:59:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Sat, 2 Mar 2024 08:59:41 +0800
Received: from [127.0.1.1] (172.16.16.155) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 2 Mar
 2024 08:59:41 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <timlee@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/7] wifi: rtw89: update DMA function with different generation
Date: Sat, 2 Mar 2024 08:58:24 +0800
Message-ID: <20240302005828.13666-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240302005828.13666-1-pkshih@realtek.com>
References: <20240302005828.13666-1-pkshih@realtek.com>
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

From: Chin-Yen Lee <timlee@realtek.com>

The register of control and polling function for TX/RX DMA is different
from different generation, so update them. Also rename polling_dma
function to polling_dma_idle to avoid misunderstanding.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h   |  8 +++---
 drivers/net/wireless/realtek/rtw89/pci.c    | 29 ++++++++++++---------
 drivers/net/wireless/realtek/rtw89/pci.h    | 27 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/pci_be.c | 24 ++++++++++++-----
 drivers/net/wireless/realtek/rtw89/wow.c    |  4 +--
 5 files changed, 68 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 956864f0ff8b..59deab4e756e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3118,7 +3118,7 @@ struct rtw89_hci_ops {
 	void (*ctrl_txdma_ch)(struct rtw89_dev *rtwdev, bool enable);
 	void (*ctrl_txdma_fw_ch)(struct rtw89_dev *rtwdev, bool enable);
 	void (*ctrl_trxhci)(struct rtw89_dev *rtwdev, bool enable);
-	int (*poll_txdma_ch)(struct rtw89_dev *rtwdev);
+	int (*poll_txdma_ch_idle)(struct rtw89_dev *rtwdev);
 	void (*clr_idx_all)(struct rtw89_dev *rtwdev);
 	void (*clear)(struct rtw89_dev *rtwdev, struct pci_dev *pdev);
 	void (*disable_intr)(struct rtw89_dev *rtwdev);
@@ -5169,12 +5169,12 @@ static inline void rtw89_hci_ctrl_trxhci(struct rtw89_dev *rtwdev, bool enable)
 		rtwdev->hci.ops->ctrl_trxhci(rtwdev, enable);
 }
 
-static inline int rtw89_hci_poll_txdma_ch(struct rtw89_dev *rtwdev)
+static inline int rtw89_hci_poll_txdma_ch_idle(struct rtw89_dev *rtwdev)
 {
 	int ret = 0;
 
-	if (rtwdev->hci.ops->poll_txdma_ch)
-		ret = rtwdev->hci.ops->poll_txdma_ch(rtwdev);
+	if (rtwdev->hci.ops->poll_txdma_ch_idle)
+		ret = rtwdev->hci.ops->poll_txdma_ch_idle(rtwdev);
 	return ret;
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index d4c8799d6f2e..19001130ad94 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -218,7 +218,7 @@ int rtw89_pci_sync_skb_for_device_and_validate_rx_info(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
-static void rtw89_pci_ctrl_txdma_ch_pcie(struct rtw89_dev *rtwdev, bool enable)
+static void rtw89_pci_ctrl_txdma_ch_ax(struct rtw89_dev *rtwdev, bool enable)
 {
 	const struct rtw89_pci_info *info = rtwdev->pci_info;
 	const struct rtw89_reg_def *dma_stop1 = &info->dma_stop1;
@@ -235,7 +235,7 @@ static void rtw89_pci_ctrl_txdma_ch_pcie(struct rtw89_dev *rtwdev, bool enable)
 	}
 }
 
-static void rtw89_pci_ctrl_txdma_fw_ch_pcie(struct rtw89_dev *rtwdev, bool enable)
+static void rtw89_pci_ctrl_txdma_fw_ch_ax(struct rtw89_dev *rtwdev, bool enable)
 {
 	const struct rtw89_pci_info *info = rtwdev->pci_info;
 	const struct rtw89_reg_def *dma_stop1 = &info->dma_stop1;
@@ -2524,7 +2524,7 @@ static void rtw89_pci_clr_idx_all_ax(struct rtw89_dev *rtwdev)
 			  B_AX_CLR_RXQ_IDX | B_AX_CLR_RPQ_IDX);
 }
 
-static int rtw89_poll_txdma_ch_idle_pcie(struct rtw89_dev *rtwdev)
+static int rtw89_pci_poll_txdma_ch_idle_ax(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_pci_info *info = rtwdev->pci_info;
 	u32 ret, check, dma_busy;
@@ -2551,7 +2551,7 @@ static int rtw89_poll_txdma_ch_idle_pcie(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
-static int rtw89_poll_rxdma_ch_idle_pcie(struct rtw89_dev *rtwdev)
+static int rtw89_pci_poll_rxdma_ch_idle_ax(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_pci_info *info = rtwdev->pci_info;
 	u32 ret, check, dma_busy;
@@ -2571,13 +2571,13 @@ static int rtw89_pci_poll_dma_all_idle(struct rtw89_dev *rtwdev)
 {
 	u32 ret;
 
-	ret = rtw89_poll_txdma_ch_idle_pcie(rtwdev);
+	ret = rtw89_pci_poll_txdma_ch_idle_ax(rtwdev);
 	if (ret) {
 		rtw89_err(rtwdev, "txdma ch busy\n");
 		return ret;
 	}
 
-	ret = rtw89_poll_rxdma_ch_idle_pcie(rtwdev);
+	ret = rtw89_pci_poll_rxdma_ch_idle_ax(rtwdev);
 	if (ret) {
 		rtw89_err(rtwdev, "rxdma ch busy\n");
 		return ret;
@@ -2756,8 +2756,8 @@ static int rtw89_pci_ops_mac_pre_init_ax(struct rtw89_dev *rtwdev)
 	}
 
 	/* disable all channels except to FW CMD channel to download firmware */
-	rtw89_pci_ctrl_txdma_ch_pcie(rtwdev, false);
-	rtw89_pci_ctrl_txdma_fw_ch_pcie(rtwdev, true);
+	rtw89_pci_ctrl_txdma_ch_ax(rtwdev, false);
+	rtw89_pci_ctrl_txdma_fw_ch_ax(rtwdev, true);
 
 	/* start DMA activities */
 	rtw89_pci_ctrl_dma_all(rtwdev, true);
@@ -2870,7 +2870,7 @@ static int rtw89_pci_ops_mac_post_init_ax(struct rtw89_dev *rtwdev)
 	}
 
 	/* enable DMA for all queues */
-	rtw89_pci_ctrl_txdma_ch_pcie(rtwdev, true);
+	rtw89_pci_ctrl_txdma_ch_ax(rtwdev, true);
 
 	/* Release PCI IO */
 	rtw89_write32_clr(rtwdev, info->dma_stop1.addr,
@@ -4093,6 +4093,10 @@ const struct rtw89_pci_gen_def rtw89_pci_gen_ax = {
 	.lv1rst_stop_dma = rtw89_pci_lv1rst_stop_dma_ax,
 	.lv1rst_start_dma = rtw89_pci_lv1rst_start_dma_ax,
 
+	.ctrl_txdma_ch = rtw89_pci_ctrl_txdma_ch_ax,
+	.ctrl_txdma_fw_ch = rtw89_pci_ctrl_txdma_fw_ch_ax,
+	.poll_txdma_ch_idle = rtw89_pci_poll_txdma_ch_idle_ax,
+
 	.aspm_set = rtw89_pci_aspm_set_ax,
 	.clkreq_set = rtw89_pci_clkreq_set_ax,
 	.l1ss_set = rtw89_pci_l1ss_set_ax,
@@ -4130,10 +4134,11 @@ static const struct rtw89_hci_ops rtw89_pci_ops = {
 	.recovery_start = rtw89_pci_ops_recovery_start,
 	.recovery_complete = rtw89_pci_ops_recovery_complete,
 
-	.ctrl_txdma_ch	= rtw89_pci_ctrl_txdma_ch_pcie,
-	.ctrl_txdma_fw_ch = rtw89_pci_ctrl_txdma_fw_ch_pcie,
+	.ctrl_txdma_ch	= rtw89_pci_ctrl_txdma_ch,
+	.ctrl_txdma_fw_ch = rtw89_pci_ctrl_txdma_fw_ch,
 	.ctrl_trxhci	= rtw89_pci_ctrl_dma_trx,
-	.poll_txdma_ch	= rtw89_poll_txdma_ch_idle_pcie,
+	.poll_txdma_ch_idle = rtw89_pci_poll_txdma_ch_idle,
+
 	.clr_idx_all	= rtw89_pci_clr_idx_all,
 	.clear		= rtw89_pci_clear_resource,
 	.disable_intr	= rtw89_pci_disable_intr_lock,
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index c1954cb12030..4a817dd9822e 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -1243,6 +1243,10 @@ struct rtw89_pci_gen_def {
 	int (*lv1rst_stop_dma)(struct rtw89_dev *rtwdev);
 	int (*lv1rst_start_dma)(struct rtw89_dev *rtwdev);
 
+	void (*ctrl_txdma_ch)(struct rtw89_dev *rtwdev, bool enable);
+	void (*ctrl_txdma_fw_ch)(struct rtw89_dev *rtwdev, bool enable);
+	int (*poll_txdma_ch_idle)(struct rtw89_dev *rtwdev);
+
 	void (*aspm_set)(struct rtw89_dev *rtwdev, bool enable);
 	void (*clkreq_set)(struct rtw89_dev *rtwdev, bool enable);
 	void (*l1ss_set)(struct rtw89_dev *rtwdev, bool enable);
@@ -1709,4 +1713,27 @@ static inline int rtw89_pci_reset_bdram(struct rtw89_dev *rtwdev)
 	return gen_def->rst_bdram(rtwdev);
 }
 
+static inline void rtw89_pci_ctrl_txdma_ch(struct rtw89_dev *rtwdev, bool enable)
+{
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
+	const struct rtw89_pci_gen_def *gen_def = info->gen_def;
+
+	return gen_def->ctrl_txdma_ch(rtwdev, enable);
+}
+
+static inline void rtw89_pci_ctrl_txdma_fw_ch(struct rtw89_dev *rtwdev, bool enable)
+{
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
+	const struct rtw89_pci_gen_def *gen_def = info->gen_def;
+
+	return gen_def->ctrl_txdma_fw_ch(rtwdev, enable);
+}
+
+static inline int rtw89_pci_poll_txdma_ch_idle(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
+	const struct rtw89_pci_gen_def *gen_def = info->gen_def;
+
+	return gen_def->poll_txdma_ch_idle(rtwdev);
+}
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/pci_be.c b/drivers/net/wireless/realtek/rtw89/pci_be.c
index 0276d5d05925..1a3f02c687f7 100644
--- a/drivers/net/wireless/realtek/rtw89/pci_be.c
+++ b/drivers/net/wireless/realtek/rtw89/pci_be.c
@@ -317,8 +317,7 @@ static void rtw89_pci_ser_setting_be(struct rtw89_dev *rtwdev)
 	rtw89_write32(rtwdev, R_BE_REG_PL1_MASK, val32);
 }
 
-static void rtw89_pci_ctrl_txdma_ch_be(struct rtw89_dev *rtwdev, bool all_en,
-				       bool h2c_en)
+static void rtw89_pci_ctrl_txdma_ch_be(struct rtw89_dev *rtwdev, bool enable)
 {
 	u32 mask_all;
 	u32 val;
@@ -331,12 +330,19 @@ static void rtw89_pci_ctrl_txdma_ch_be(struct rtw89_dev *rtwdev, bool all_en,
 	val = rtw89_read32(rtwdev, R_BE_HAXI_DMA_STOP1);
 	val |= B_BE_STOP_CH13 | B_BE_STOP_CH14;
 
-	if (all_en)
+	if (enable)
 		val &= ~mask_all;
 	else
 		val |= mask_all;
 
-	if (h2c_en)
+	rtw89_write32(rtwdev, R_BE_HAXI_DMA_STOP1, val);
+}
+
+static void rtw89_pci_ctrl_txdma_fw_ch_be(struct rtw89_dev *rtwdev, bool enable)
+{
+	u32 val = rtw89_read32(rtwdev, R_BE_HAXI_DMA_STOP1);
+
+	if (enable)
 		val &= ~B_BE_STOP_CH12;
 	else
 		val |= B_BE_STOP_CH12;
@@ -375,7 +381,8 @@ static int rtw89_pci_ops_mac_pre_init_be(struct rtw89_dev *rtwdev)
 	rtw89_pci_pcie_setting_be(rtwdev);
 	rtw89_pci_ser_setting_be(rtwdev);
 
-	rtw89_pci_ctrl_txdma_ch_be(rtwdev, false, true);
+	rtw89_pci_ctrl_txdma_ch_be(rtwdev, false);
+	rtw89_pci_ctrl_txdma_fw_ch_be(rtwdev, true);
 	rtw89_pci_ctrl_trxdma_pcie_be(rtwdev, MAC_AX_PCIE_ENABLE,
 				      MAC_AX_PCIE_ENABLE, MAC_AX_PCIE_ENABLE);
 
@@ -485,7 +492,8 @@ static int rtw89_pci_ops_mac_post_init_be(struct rtw89_dev *rtwdev)
 	rtw89_pci_ctrl_trxdma_pcie_be(rtwdev, MAC_AX_PCIE_IGNORE,
 				      MAC_AX_PCIE_IGNORE, MAC_AX_PCIE_ENABLE);
 	rtw89_pci_ctrl_wpdma_pcie_be(rtwdev, true);
-	rtw89_pci_ctrl_txdma_ch_be(rtwdev, true, true);
+	rtw89_pci_ctrl_txdma_ch_be(rtwdev, true);
+	rtw89_pci_ctrl_txdma_fw_ch_be(rtwdev, true);
 	rtw89_pci_configure_mit_be(rtwdev);
 
 	return 0;
@@ -559,6 +567,10 @@ const struct rtw89_pci_gen_def rtw89_pci_gen_be = {
 	.lv1rst_stop_dma = rtw89_pci_lv1rst_stop_dma_be,
 	.lv1rst_start_dma = rtw89_pci_lv1rst_start_dma_be,
 
+	.ctrl_txdma_ch = rtw89_pci_ctrl_txdma_ch_be,
+	.ctrl_txdma_fw_ch = rtw89_pci_ctrl_txdma_fw_ch_be,
+	.poll_txdma_ch_idle = rtw89_pci_poll_txdma_ch_idle_be,
+
 	.aspm_set = rtw89_pci_aspm_set_be,
 	.clkreq_set = rtw89_pci_clkreq_set_be,
 	.l1ss_set = rtw89_pci_l1ss_set_be,
diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index 852f8a7794be..286c59931fca 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -560,7 +560,7 @@ static int rtw89_wow_enable_trx_pre(struct rtw89_dev *rtwdev)
 
 	rtw89_mac_ptk_drop_by_band_and_wait(rtwdev, RTW89_MAC_0);
 
-	ret = rtw89_hci_poll_txdma_ch(rtwdev);
+	ret = rtw89_hci_poll_txdma_ch_idle(rtwdev);
 	if (ret) {
 		rtw89_err(rtwdev, "txdma ch busy\n");
 		return ret;
@@ -583,7 +583,7 @@ static int rtw89_wow_enable_trx_post(struct rtw89_dev *rtwdev)
 	rtw89_hci_disable_intr(rtwdev);
 	rtw89_hci_ctrl_trxhci(rtwdev, false);
 
-	ret = rtw89_hci_poll_txdma_ch(rtwdev);
+	ret = rtw89_hci_poll_txdma_ch_idle(rtwdev);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to poll txdma ch idle pcie\n");
 		return ret;
-- 
2.25.1


