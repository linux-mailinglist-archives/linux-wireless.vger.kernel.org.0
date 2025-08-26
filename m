Return-Path: <linux-wireless+bounces-26622-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B600B357B3
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 10:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4947E174A36
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 08:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48AE1B6D08;
	Tue, 26 Aug 2025 08:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="bzbK8/+E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7BE9460
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 08:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756198472; cv=none; b=ehvC3ExyxwMezBKm4+OA58nMpBE69SwP+OxO0ph6RrQzr/8+vLLDwTlKzcltYL940G8wnpn1/SK2A9XJ9fiMhp/mP9naOIlug2u72NVM2euPGayJUEEkIQSxge/LhkiJ9T1dy0teqAnvzjINp7y0rw9y9DzhGUAODyGz+tFyEEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756198472; c=relaxed/simple;
	bh=88lFRuwSmlLwVbeYNGfMfHOJb3K4u4Ou0BEHVT1kOBY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nMIHoeNCtoOQYGX4SgfSC/EgCo9Y3vYyRA86X6qX5WeaTUiPJHq5cq+ri+6hXWWnoDrXR4YV6VPyNc8Cq1HZ/PhHnzYHXKfMXaRufRsPqaiQWyFqEy9wnwL5Pdhb/8QYJCPqJ4CXwaAh4VdZgJlk3FppN7u16fI+p9pCM9/mBHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=bzbK8/+E; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57Q8sRJN11262411, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1756198468; bh=3vV+qzoka4Hbk0GAjzMcGj+KED53p9smAyh7mt1OH9I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=bzbK8/+Ezhd2ZT6fvlTe9DUjctb/9VufnR2qkzcnMIVpPJZ8HtdyXd71pV703mTip
	 GrwX5ipl7KkxiKCIfzLYa6PVgafC/6wWsXZ9LZGc5sex/MuMlOq2xcAnr1jM2Fk4nM
	 cV4we2ksyChKs0VCTnxlBJO6eue+Jl4cwHQ6SEkCinknSmCu9NP/pe+eHpw8bel+IY
	 R4XXmzCpI3X8OlwE25o/cyP14kyNyfu7duUq0HhF/6aOuuanHOFGjg7w0JfefXxies
	 uJnJ6vFiyvEARt9soldpKUM8rXR05wwC1M+kVIQQLrwyFAMXN6E1upum6CtY0Gwsa3
	 1fCBGwjPSg7gw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57Q8sRJN11262411
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 16:54:28 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 26 Aug 2025 16:54:27 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Tue, 26 Aug
 2025 16:54:27 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 08/10] wifi: rtw89: pci: add RPP parser v1
Date: Tue, 26 Aug 2025 16:53:32 +0800
Message-ID: <20250826085332.28463-1-pkshih@realtek.com>
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

The new format contains more information including TX DMA channel, actual
TX link and etc.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c | 12 ++++++++++++
 drivers/net/wireless/realtek/rtw89/pci.h | 15 +++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index cc54694859a6..1316671cb31b 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -580,6 +580,18 @@ void rtw89_pci_parse_rpp(struct rtw89_dev *rtwdev, void *_rpp,
 }
 EXPORT_SYMBOL(rtw89_pci_parse_rpp);
 
+void rtw89_pci_parse_rpp_v1(struct rtw89_dev *rtwdev, void *_rpp,
+			    struct rtw89_pci_rpp_info *rpp_info)
+{
+	const struct rtw89_pci_rpp_fmt_v1 *rpp = _rpp;
+
+	rpp_info->seq = le32_get_bits(rpp->w0, RTW89_PCI_RPP_W0_PCIE_SEQ_V1_MASK);
+	rpp_info->qsel = le32_get_bits(rpp->w1, RTW89_PCI_RPP_W1_QSEL_V1_MASK);
+	rpp_info->tx_status = le32_get_bits(rpp->w0, RTW89_PCI_RPP_W0_TX_STATUS_V1_MASK);
+	rpp_info->txch = le32_get_bits(rpp->w0, RTW89_PCI_RPP_W0_DMA_CH_MASK);
+}
+EXPORT_SYMBOL(rtw89_pci_parse_rpp_v1);
+
 static void rtw89_pci_release_rpp(struct rtw89_dev *rtwdev, void *rpp)
 {
 	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index b0c6f4d38bf5..fc8268eb44db 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -1498,6 +1498,19 @@ struct rtw89_pci_rpp_fmt {
 	__le32 dword;
 } __packed;
 
+#define RTW89_PCI_RPP_W0_MACID_V1_MASK		GENMASK(9, 0)
+#define RTW89_PCI_RPP_W0_DMA_CH_MASK		GENMASK(13, 10)
+#define RTW89_PCI_RPP_W0_TX_STATUS_V1_MASK	GENMASK(16, 14)
+#define RTW89_PCI_RPP_W0_PCIE_SEQ_V1_MASK	GENMASK(31, 17)
+#define RTW89_PCI_RPP_W1_QSEL_V1_MASK		GENMASK(5, 0)
+#define RTW89_PCI_RPP_W1_TID_IND		BIT(6)
+#define RTW89_PCI_RPP_W1_CHANGE_LINK		BIT(7)
+
+struct rtw89_pci_rpp_fmt_v1 {
+	__le32 w0;
+	__le32 w1;
+} __packed;
+
 struct rtw89_pci_rx_bd_32 {
 	__le16 buf_size;
 	__le16 opt;
@@ -1736,6 +1749,8 @@ u32 rtw89_pci_fill_txaddr_info_v1(struct rtw89_dev *rtwdev,
 				  dma_addr_t dma, u8 *add_info_nr);
 void rtw89_pci_parse_rpp(struct rtw89_dev *rtwdev, void *_rpp,
 			 struct rtw89_pci_rpp_info *rpp_info);
+void rtw89_pci_parse_rpp_v1(struct rtw89_dev *rtwdev, void *_rpp,
+			    struct rtw89_pci_rpp_info *rpp_info);
 void rtw89_pci_ctrl_dma_all(struct rtw89_dev *rtwdev, bool enable);
 void rtw89_pci_config_intr_mask(struct rtw89_dev *rtwdev);
 void rtw89_pci_config_intr_mask_v1(struct rtw89_dev *rtwdev);
-- 
2.25.1


