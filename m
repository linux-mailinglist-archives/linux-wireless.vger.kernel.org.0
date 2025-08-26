Return-Path: <linux-wireless+bounces-26615-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94040B357AB
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 10:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51330175CC4
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 08:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4DF9460;
	Tue, 26 Aug 2025 08:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="kY4Lq569"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FB52FE04F
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 08:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756198386; cv=none; b=EhkEtLey/0l5R8/lyAd8SC11cSGTW0pCvnex1bzw1LT4WQM3SVBDJmhjJtT7zShqqOZhK7KhfEIF7rTys6CtEQ+SrHJzcCNP/BXhtPkZzBElhMMSExkPDASh231/8GPp1pd4dyEh+SX4c2xjBBS5TBQQb/28ozj54UR2uL0/pn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756198386; c=relaxed/simple;
	bh=1xhnnEbze1z0SCw2zWjnaWQ0yb19Ze1MhU1kx0+a5aQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S/NprFdnws6sCt5zQC1VXA8UFNy3b7pHq39GDAkIMJOu1oU5cQenBKQEzRZGjBGep5AAB2blVhTeRt/4zzRO2EDZIM4mHggac4L5gEly0cFgYnkCqM8Qrq/X7yQ6+2QjIup3Exe3AzZbmCpIniHCSOZqQt+5Q4NK0tfIF0sxI4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=kY4Lq569; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57Q8r0Uz91261928, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1756198381; bh=fMSaCXq9ang39iBQP0FTJANtIDbq63/tfHorlbryg40=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=kY4Lq5695KiOzyXtwFoj0ZeeJVreWTUacNZRFz/z0c/JNTeVkEt54bg4dj9FVUiU2
	 6Jd+Iz5s3ykvoMcjY0cxEd2kePJsFjP3SkXg85uwnwfnW5APOcWcHyQz22BUop/Ips
	 S3pky4Hb4eRzpuoG1uhNzTMXSosvVYcwN6V4TNfGdZxFkD6AGIFpKKEcOUPRxjf7Bs
	 jhB+POa5BCZ+KmHFicEA+wlVOmI+g81m+iFtjb2TPSaBOML0sV07pXngL003ey2aEt
	 CoMWo0jF0qsMktMsMqdTiwxO23+XSVpeJH/25f7v5sYSwGNfrBkfUHmivtAj1Kb+8k
	 Ep9LF/DjU1IXQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57Q8r0Uz91261928
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 16:53:00 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 26 Aug 2025 16:52:59 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Tue, 26 Aug
 2025 16:52:59 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 01/10] wifi: rtw89: pci: move chip ISR definition out from chip generation
Date: Tue, 26 Aug 2025 16:51:43 +0800
Message-ID: <20250826085152.28164-2-pkshih@realtek.com>
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

The existing WiFi 6 chips can share the same ISR (interrupt status
registers), but the coming WiFi 7 chip 8922DE can't share the same
definition with existing WiFi 7 chip, so move the definition to an
individual struct.

Don't change logic at all.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c      | 19 +++++++++++--------
 drivers/net/wireless/realtek/rtw89/pci.h      |  7 ++++++-
 drivers/net/wireless/realtek/rtw89/pci_be.c   |  5 ++++-
 .../net/wireless/realtek/rtw89/rtw8851be.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8852ae.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8852be.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8852bte.c   |  1 +
 .../net/wireless/realtek/rtw89/rtw8852ce.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8922ae.c    |  1 +
 9 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index a669f2f843aa..162075882fa4 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -885,7 +885,7 @@ static irqreturn_t rtw89_pci_interrupt_threadfn(int irq, void *dev)
 	struct rtw89_dev *rtwdev = dev;
 	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
 	const struct rtw89_pci_info *info = rtwdev->pci_info;
-	const struct rtw89_pci_gen_def *gen_def = info->gen_def;
+	const struct rtw89_pci_isr_def *isr_def = info->isr_def;
 	struct rtw89_pci_isrs isrs;
 	unsigned long flags;
 
@@ -893,13 +893,13 @@ static irqreturn_t rtw89_pci_interrupt_threadfn(int irq, void *dev)
 	rtw89_chip_recognize_intrs(rtwdev, rtwpci, &isrs);
 	spin_unlock_irqrestore(&rtwpci->irq_lock, flags);
 
-	if (unlikely(isrs.isrs[0] & gen_def->isr_rdu))
+	if (unlikely(isrs.isrs[0] & isr_def->isr_rdu))
 		rtw89_pci_isr_rxd_unavail(rtwdev, rtwpci);
 
-	if (unlikely(isrs.halt_c2h_isrs & gen_def->isr_halt_c2h))
+	if (unlikely(isrs.halt_c2h_isrs & isr_def->isr_halt_c2h))
 		rtw89_ser_notify(rtwdev, rtw89_mac_get_err_status(rtwdev));
 
-	if (unlikely(isrs.halt_c2h_isrs & gen_def->isr_wdt_timeout))
+	if (unlikely(isrs.halt_c2h_isrs & isr_def->isr_wdt_timeout))
 		rtw89_ser_notify(rtwdev, MAC_AX_ERR_L2_ERR_WDT_TIMEOUT_INT);
 
 	if (unlikely(rtwpci->under_recovery))
@@ -4228,18 +4228,18 @@ static int rtw89_pci_napi_poll(struct napi_struct *napi, int budget)
 	struct rtw89_dev *rtwdev = container_of(napi, struct rtw89_dev, napi);
 	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
 	const struct rtw89_pci_info *info = rtwdev->pci_info;
-	const struct rtw89_pci_gen_def *gen_def = info->gen_def;
+	const struct rtw89_pci_isr_def *isr_def = info->isr_def;
 	unsigned long flags;
 	int work_done;
 
 	rtwdev->napi_budget_countdown = budget;
 
-	rtw89_write32(rtwdev, gen_def->isr_clear_rpq.addr, gen_def->isr_clear_rpq.data);
+	rtw89_write32(rtwdev, isr_def->isr_clear_rpq.addr, isr_def->isr_clear_rpq.data);
 	work_done = rtw89_pci_poll_rpq_dma(rtwdev, rtwpci, rtwdev->napi_budget_countdown);
 	if (work_done == budget)
 		return budget;
 
-	rtw89_write32(rtwdev, gen_def->isr_clear_rxq.addr, gen_def->isr_clear_rxq.data);
+	rtw89_write32(rtwdev, isr_def->isr_clear_rxq.addr, isr_def->isr_clear_rxq.data);
 	work_done += rtw89_pci_poll_rxq_dma(rtwdev, rtwpci, rtwdev->napi_budget_countdown);
 	if (work_done < budget && napi_complete_done(napi, work_done)) {
 		spin_lock_irqsave(&rtwpci->irq_lock, flags);
@@ -4394,14 +4394,17 @@ const struct pci_error_handlers rtw89_pci_err_handler = {
 };
 EXPORT_SYMBOL(rtw89_pci_err_handler);
 
-const struct rtw89_pci_gen_def rtw89_pci_gen_ax = {
+const struct rtw89_pci_isr_def rtw89_pci_isr_ax = {
 	.isr_rdu = B_AX_RDU_INT,
 	.isr_halt_c2h = B_AX_HALT_C2H_INT_EN,
 	.isr_wdt_timeout = B_AX_WDT_TIMEOUT_INT_EN,
 	.isr_clear_rpq = {R_AX_PCIE_HISR00, B_AX_RPQDMA_INT | B_AX_RPQBD_FULL_INT},
 	.isr_clear_rxq = {R_AX_PCIE_HISR00, B_AX_RXP1DMA_INT | B_AX_RXDMA_INT |
 					    B_AX_RDU_INT},
+};
+EXPORT_SYMBOL(rtw89_pci_isr_ax);
 
+const struct rtw89_pci_gen_def rtw89_pci_gen_ax = {
 	.mac_pre_init = rtw89_pci_ops_mac_pre_init_ax,
 	.mac_pre_deinit = rtw89_pci_ops_mac_pre_deinit_ax,
 	.mac_post_init = rtw89_pci_ops_mac_post_init_ax,
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index 52f527069da6..14b1d388d46b 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -1267,13 +1267,15 @@ struct rtw89_pci_bd_ram {
 	u8 min_num;
 };
 
-struct rtw89_pci_gen_def {
+struct rtw89_pci_isr_def {
 	u32 isr_rdu;
 	u32 isr_halt_c2h;
 	u32 isr_wdt_timeout;
 	struct rtw89_reg2_def isr_clear_rpq;
 	struct rtw89_reg2_def isr_clear_rxq;
+};
 
+struct rtw89_pci_gen_def {
 	int (*mac_pre_init)(struct rtw89_dev *rtwdev);
 	int (*mac_pre_deinit)(struct rtw89_dev *rtwdev);
 	int (*mac_post_init)(struct rtw89_dev *rtwdev);
@@ -1311,6 +1313,7 @@ struct rtw89_pci_ssid_quirk {
 
 struct rtw89_pci_info {
 	const struct rtw89_pci_gen_def *gen_def;
+	const struct rtw89_pci_isr_def *isr_def;
 	enum mac_ax_bd_trunc_mode txbd_trunc_mode;
 	enum mac_ax_bd_trunc_mode rxbd_trunc_mode;
 	enum mac_ax_rxbd_mode rxbd_mode;
@@ -1628,6 +1631,8 @@ extern const struct rtw89_pci_ch_dma_addr_set rtw89_pci_ch_dma_addr_set_v1;
 extern const struct rtw89_pci_ch_dma_addr_set rtw89_pci_ch_dma_addr_set_be;
 extern const struct rtw89_pci_bd_ram rtw89_bd_ram_table_dual[RTW89_TXCH_NUM];
 extern const struct rtw89_pci_bd_ram rtw89_bd_ram_table_single[RTW89_TXCH_NUM];
+extern const struct rtw89_pci_isr_def rtw89_pci_isr_ax;
+extern const struct rtw89_pci_isr_def rtw89_pci_isr_be;
 extern const struct rtw89_pci_gen_def rtw89_pci_gen_ax;
 extern const struct rtw89_pci_gen_def rtw89_pci_gen_be;
 
diff --git a/drivers/net/wireless/realtek/rtw89/pci_be.c b/drivers/net/wireless/realtek/rtw89/pci_be.c
index 12e6a0cbb889..29ca58b86085 100644
--- a/drivers/net/wireless/realtek/rtw89/pci_be.c
+++ b/drivers/net/wireless/realtek/rtw89/pci_be.c
@@ -665,13 +665,16 @@ static int __maybe_unused rtw89_pci_resume_be(struct device *dev)
 SIMPLE_DEV_PM_OPS(rtw89_pm_ops_be, rtw89_pci_suspend_be, rtw89_pci_resume_be);
 EXPORT_SYMBOL(rtw89_pm_ops_be);
 
-const struct rtw89_pci_gen_def rtw89_pci_gen_be = {
+const struct rtw89_pci_isr_def rtw89_pci_isr_be = {
 	.isr_rdu = B_BE_RDU_CH1_INT_V1 | B_BE_RDU_CH0_INT_V1,
 	.isr_halt_c2h = B_BE_HALT_C2H_INT,
 	.isr_wdt_timeout = B_BE_WDT_TIMEOUT_INT,
 	.isr_clear_rpq = {R_BE_PCIE_DMA_ISR, B_BE_PCIE_RX_RPQ0_ISR_V1},
 	.isr_clear_rxq = {R_BE_PCIE_DMA_ISR, B_BE_PCIE_RX_RX0P2_ISR_V1},
+};
+EXPORT_SYMBOL(rtw89_pci_isr_be);
 
+const struct rtw89_pci_gen_def rtw89_pci_gen_be = {
 	.mac_pre_init = rtw89_pci_ops_mac_pre_init_be,
 	.mac_pre_deinit = rtw89_pci_ops_mac_pre_deinit_be,
 	.mac_post_init = rtw89_pci_ops_mac_post_init_be,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851be.c b/drivers/net/wireless/realtek/rtw89/rtw8851be.c
index 598730831707..c9d60870ed9e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851be.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851be.c
@@ -11,6 +11,7 @@
 
 static const struct rtw89_pci_info rtw8851b_pci_info = {
 	.gen_def		= &rtw89_pci_gen_ax,
+	.isr_def		= &rtw89_pci_isr_ax,
 	.txbd_trunc_mode	= MAC_AX_BD_TRUNC,
 	.rxbd_trunc_mode	= MAC_AX_BD_TRUNC,
 	.rxbd_mode		= MAC_AX_RXBD_PKT,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
index 90ffaf9f4f6a..1bfade7e7e1b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
@@ -11,6 +11,7 @@
 
 static const struct rtw89_pci_info rtw8852a_pci_info = {
 	.gen_def		= &rtw89_pci_gen_ax,
+	.isr_def		= &rtw89_pci_isr_ax,
 	.txbd_trunc_mode	= MAC_AX_BD_TRUNC,
 	.rxbd_trunc_mode	= MAC_AX_BD_TRUNC,
 	.rxbd_mode		= MAC_AX_RXBD_PKT,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852be.c b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
index b0726f590ca2..8f7676a0a89e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852be.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
@@ -11,6 +11,7 @@
 
 static const struct rtw89_pci_info rtw8852b_pci_info = {
 	.gen_def		= &rtw89_pci_gen_ax,
+	.isr_def		= &rtw89_pci_isr_ax,
 	.txbd_trunc_mode	= MAC_AX_BD_TRUNC,
 	.rxbd_trunc_mode	= MAC_AX_BD_TRUNC,
 	.rxbd_mode		= MAC_AX_RXBD_PKT,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bte.c b/drivers/net/wireless/realtek/rtw89/rtw8852bte.c
index a584c75b801d..642ab20e9d06 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bte.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bte.c
@@ -17,6 +17,7 @@ static const struct rtw89_pci_ssid_quirk rtw8852bt_pci_ssid_quirks[] = {
 
 static const struct rtw89_pci_info rtw8852bt_pci_info = {
 	.gen_def		= &rtw89_pci_gen_ax,
+	.isr_def		= &rtw89_pci_isr_ax,
 	.txbd_trunc_mode	= MAC_AX_BD_TRUNC,
 	.rxbd_trunc_mode	= MAC_AX_BD_TRUNC,
 	.rxbd_mode		= MAC_AX_RXBD_PKT,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
index db01d3966c27..4c7682f1d00c 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
@@ -20,6 +20,7 @@ static const struct rtw89_pci_bd_idx_addr rtw8852c_bd_idx_addr_low_power = {
 
 static const struct rtw89_pci_info rtw8852c_pci_info = {
 	.gen_def		= &rtw89_pci_gen_ax,
+	.isr_def		= &rtw89_pci_isr_ax,
 	.txbd_trunc_mode	= MAC_AX_BD_TRUNC,
 	.rxbd_trunc_mode	= MAC_AX_BD_TRUNC,
 	.rxbd_mode		= MAC_AX_RXBD_PKT,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922ae.c b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
index b730d79edd10..a0fc6b2832e1 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
@@ -17,6 +17,7 @@ static const struct rtw89_pci_ssid_quirk rtw8922a_pci_ssid_quirks[] = {
 
 static const struct rtw89_pci_info rtw8922a_pci_info = {
 	.gen_def		= &rtw89_pci_gen_be,
+	.isr_def		= &rtw89_pci_isr_be,
 	.txbd_trunc_mode	= MAC_AX_BD_TRUNC,
 	.rxbd_trunc_mode	= MAC_AX_BD_TRUNC,
 	.rxbd_mode		= MAC_AX_RXBD_PKT,
-- 
2.25.1


