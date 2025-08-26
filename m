Return-Path: <linux-wireless+bounces-26623-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E106B357B4
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 10:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A002F1886B42
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 08:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D1228371;
	Tue, 26 Aug 2025 08:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Mr2xg8AW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADAB27A919
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 08:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756198480; cv=none; b=hVLxI7gQ/WydHIpZjmzTNB2T3RPph/7rcAHQJPQDqiStUN6mWlHzR5TrMsELalkiKSx8lWvyCDpZcbIlpPx5gmlnGJ7ffq5uhXUClMIuVyZofIphyxSa/H6TmM0Bn/Uo8fJLksL692G9Vxn51Elp4HgJmLC3dpA2+Iezae1R96Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756198480; c=relaxed/simple;
	bh=NRQApjnewQ4KDlA2muREDgjUgPKH4m6OZnVRpXKu4pw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f2Me4ptiHOpYVVjh17o7Idjv3t2nkYaVcg2HdI+anJKzwNZSdmlNBHFLREUXZwP8gQGPMv3Lh/2XRtxWyukk6ubVXQec/CD+IRAalGZaMdeUnG9u7PpcvEOpYyQxMcCADcrP4dtGV+OzBULk5gL3yuBmqP3MIvGK63Vwt3VA/oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Mr2xg8AW; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57Q8sZAJ11262979, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1756198475; bh=eIzqxaIMWZfXKUC5LV/srUFUNxbbs8wGaKz8k4IBVFU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Mr2xg8AWfaweIAJ69ij48BzIdugLzGQR9lMGhKdNSh7DAaO+wIjWBCdWXJ4axcXs1
	 FOJ5fm9hXTXCboNOrHLe9E8pWU5VG8CkRcSECTiqMGU7ADTAt3aBVFCYUbStOghvsW
	 ygM3N0LVsR+VahQ8vcA9wKiS/rtvG8aOIwdVIYqdyXKfo4CkX7hrJc0E3mDx1yYkXW
	 MkFJuRqUpiyPChKO2BTNGHnfcXylnaJAHECymiRfa5nNU+qVwCgm9XZbp4PBGA8u91
	 /21AP1cd1ggCE6NLNQS59CDrDq/Q12MQYK0ZQaznJvtkPnu2U1iIxGRpmpb0c7TJO6
	 dJ/blM85k6X7A==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57Q8sZAJ11262979
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 16:54:35 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 26 Aug 2025 16:54:35 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Tue, 26 Aug
 2025 16:54:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 09/10] wifi: rtw89: abstract getting function of DMA channel
Date: Tue, 26 Aug 2025 16:53:39 +0800
Message-ID: <20250826085339.28512-1-pkshih@realtek.com>
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

The mapping function from QSEL (almost equivalent EDCA queue) to PCI DMA
channel. Since coming chips change the definition, abstract this function
as a chip_ops.

Don't change logic at all.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     | 46 +++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/core.h     | 10 ++++
 drivers/net/wireless/realtek/rtw89/pci.c      |  2 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  1 +
 drivers/net/wireless/realtek/rtw89/txrx.h     | 37 ---------------
 10 files changed, 59 insertions(+), 42 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 2b658ee89bb6..625baa0cb63c 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -699,6 +699,44 @@ static void rtw89_core_tx_update_llc_hdr(struct rtw89_dev *rtwdev,
 	desc_info->hdr_llc_len >>= 1; /* in unit of 2 bytes */
 }
 
+u8 rtw89_core_get_ch_dma(struct rtw89_dev *rtwdev, u8 qsel)
+{
+	switch (qsel) {
+	default:
+		rtw89_warn(rtwdev, "Cannot map qsel to dma: %d\n", qsel);
+		fallthrough;
+	case RTW89_TX_QSEL_BE_0:
+	case RTW89_TX_QSEL_BE_1:
+	case RTW89_TX_QSEL_BE_2:
+	case RTW89_TX_QSEL_BE_3:
+		return RTW89_TXCH_ACH0;
+	case RTW89_TX_QSEL_BK_0:
+	case RTW89_TX_QSEL_BK_1:
+	case RTW89_TX_QSEL_BK_2:
+	case RTW89_TX_QSEL_BK_3:
+		return RTW89_TXCH_ACH1;
+	case RTW89_TX_QSEL_VI_0:
+	case RTW89_TX_QSEL_VI_1:
+	case RTW89_TX_QSEL_VI_2:
+	case RTW89_TX_QSEL_VI_3:
+		return RTW89_TXCH_ACH2;
+	case RTW89_TX_QSEL_VO_0:
+	case RTW89_TX_QSEL_VO_1:
+	case RTW89_TX_QSEL_VO_2:
+	case RTW89_TX_QSEL_VO_3:
+		return RTW89_TXCH_ACH3;
+	case RTW89_TX_QSEL_B0_MGMT:
+		return RTW89_TXCH_CH8;
+	case RTW89_TX_QSEL_B0_HI:
+		return RTW89_TXCH_CH9;
+	case RTW89_TX_QSEL_B1_MGMT:
+		return RTW89_TXCH_CH10;
+	case RTW89_TX_QSEL_B1_HI:
+		return RTW89_TXCH_CH11;
+	}
+}
+EXPORT_SYMBOL(rtw89_core_get_ch_dma);
+
 static void
 rtw89_core_tx_update_mgmt_info(struct rtw89_dev *rtwdev,
 			       struct rtw89_core_tx_request *tx_req)
@@ -712,7 +750,7 @@ rtw89_core_tx_update_mgmt_info(struct rtw89_dev *rtwdev,
 	u8 qsel, ch_dma;
 
 	qsel = rtw89_core_get_qsel_mgmt(rtwdev, tx_req);
-	ch_dma = rtw89_core_get_ch_dma(rtwdev, qsel);
+	ch_dma = rtw89_chip_get_ch_dma(rtwdev, qsel);
 
 	desc_info->qsel = qsel;
 	desc_info->ch_dma = ch_dma;
@@ -929,7 +967,7 @@ rtw89_core_tx_update_data_info(struct rtw89_dev *rtwdev,
 	tid = skb->priority & IEEE80211_QOS_CTL_TAG1D_MASK;
 	tid_indicate = rtw89_core_get_tid_indicate(rtwdev, tid);
 	qsel = desc_info->hiq ? RTW89_TX_QSEL_B0_HI : rtw89_core_get_qsel(rtwdev, tid);
-	ch_dma = rtw89_core_get_ch_dma(rtwdev, qsel);
+	ch_dma = rtw89_chip_get_ch_dma(rtwdev, qsel);
 
 	desc_info->ch_dma = ch_dma;
 	desc_info->tid_indicate = tid_indicate;
@@ -1079,7 +1117,7 @@ void rtw89_core_tx_kick_off(struct rtw89_dev *rtwdev, u8 qsel)
 {
 	u8 ch_dma;
 
-	ch_dma = rtw89_core_get_ch_dma(rtwdev, qsel);
+	ch_dma = rtw89_chip_get_ch_dma(rtwdev, qsel);
 
 	rtw89_hci_tx_kick_off(rtwdev, ch_dma);
 }
@@ -3664,7 +3702,7 @@ static u32 rtw89_check_and_reclaim_tx_resource(struct rtw89_dev *rtwdev, u8 tid)
 	u8 qsel, ch_dma;
 
 	qsel = rtw89_core_get_qsel(rtwdev, tid);
-	ch_dma = rtw89_core_get_ch_dma(rtwdev, qsel);
+	ch_dma = rtw89_chip_get_ch_dma(rtwdev, qsel);
 
 	return rtw89_hci_check_and_reclaim_tx_resource(rtwdev, ch_dma);
 }
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index a5fef3c84b20..22f7fb30ff96 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3760,6 +3760,7 @@ struct rtw89_chip_ops {
 	void (*fill_txdesc_fwcmd)(struct rtw89_dev *rtwdev,
 				  struct rtw89_tx_desc_info *desc_info,
 				  void *txdesc);
+	u8 (*get_ch_dma)(struct rtw89_dev *rtwdev, u8 qsel);
 	int (*cfg_ctrl_path)(struct rtw89_dev *rtwdev, bool wl);
 	int (*mac_cfg_gnt)(struct rtw89_dev *rtwdev,
 			   const struct rtw89_mac_ax_coex_gnt *gnt_cfg);
@@ -7197,6 +7198,14 @@ void rtw89_chip_fill_txdesc_fwcmd(struct rtw89_dev *rtwdev,
 	chip->ops->fill_txdesc_fwcmd(rtwdev, desc_info, txdesc);
 }
 
+static inline
+u8 rtw89_chip_get_ch_dma(struct rtw89_dev *rtwdev, u8 qsel)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	return chip->ops->get_ch_dma(rtwdev, qsel);
+}
+
 static inline
 void rtw89_chip_mac_cfg_gnt(struct rtw89_dev *rtwdev,
 			    const struct rtw89_mac_ax_coex_gnt *gnt_cfg)
@@ -7441,6 +7450,7 @@ void rtw89_core_fill_txdesc_fwcmd_v1(struct rtw89_dev *rtwdev,
 void rtw89_core_fill_txdesc_fwcmd_v2(struct rtw89_dev *rtwdev,
 				     struct rtw89_tx_desc_info *desc_info,
 				     void *txdesc);
+u8 rtw89_core_get_ch_dma(struct rtw89_dev *rtwdev, u8 qsel);
 void rtw89_core_rx(struct rtw89_dev *rtwdev,
 		   struct rtw89_rx_desc_info *desc_info,
 		   struct sk_buff *skb);
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 1316671cb31b..b0c2ad22cbb3 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -576,7 +576,7 @@ void rtw89_pci_parse_rpp(struct rtw89_dev *rtwdev, void *_rpp,
 	rpp_info->seq = le32_get_bits(rpp->dword, RTW89_PCI_RPP_SEQ);
 	rpp_info->qsel = le32_get_bits(rpp->dword, RTW89_PCI_RPP_QSEL);
 	rpp_info->tx_status = le32_get_bits(rpp->dword, RTW89_PCI_RPP_TX_STATUS);
-	rpp_info->txch = rtw89_core_get_ch_dma(rtwdev, rpp_info->qsel);
+	rpp_info->txch = rtw89_chip_get_ch_dma(rtwdev, rpp_info->qsel);
 }
 EXPORT_SYMBOL(rtw89_pci_parse_rpp);
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 084bbf9ecf0b..edcbda124916 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2537,6 +2537,7 @@ static const struct rtw89_chip_ops rtw8851b_chip_ops = {
 	.query_rxdesc		= rtw89_core_query_rxdesc,
 	.fill_txdesc		= rtw89_core_fill_txdesc,
 	.fill_txdesc_fwcmd	= rtw89_core_fill_txdesc,
+	.get_ch_dma		= rtw89_core_get_ch_dma,
 	.cfg_ctrl_path		= rtw89_mac_cfg_ctrl_path,
 	.mac_cfg_gnt		= rtw89_mac_cfg_gnt,
 	.stop_sch_tx		= rtw89_mac_stop_sch_tx,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index d4200246eecc..232f4c1bee1b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2178,6 +2178,7 @@ static const struct rtw89_chip_ops rtw8852a_chip_ops = {
 	.query_rxdesc		= rtw89_core_query_rxdesc,
 	.fill_txdesc		= rtw89_core_fill_txdesc,
 	.fill_txdesc_fwcmd	= rtw89_core_fill_txdesc,
+	.get_ch_dma		= rtw89_core_get_ch_dma,
 	.cfg_ctrl_path		= rtw89_mac_cfg_ctrl_path,
 	.mac_cfg_gnt		= rtw89_mac_cfg_gnt,
 	.stop_sch_tx		= rtw89_mac_stop_sch_tx,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 6f33f6db2763..0777e336aaa1 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -842,6 +842,7 @@ static const struct rtw89_chip_ops rtw8852b_chip_ops = {
 	.query_rxdesc		= rtw89_core_query_rxdesc,
 	.fill_txdesc		= rtw89_core_fill_txdesc,
 	.fill_txdesc_fwcmd	= rtw89_core_fill_txdesc,
+	.get_ch_dma		= rtw89_core_get_ch_dma,
 	.cfg_ctrl_path		= rtw89_mac_cfg_ctrl_path,
 	.mac_cfg_gnt		= rtw89_mac_cfg_gnt,
 	.stop_sch_tx		= rtw89_mac_stop_sch_tx,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index 9427823aca2f..b3a79ebc7e75 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -708,6 +708,7 @@ static const struct rtw89_chip_ops rtw8852bt_chip_ops = {
 	.query_rxdesc		= rtw89_core_query_rxdesc,
 	.fill_txdesc		= rtw89_core_fill_txdesc,
 	.fill_txdesc_fwcmd	= rtw89_core_fill_txdesc,
+	.get_ch_dma		= rtw89_core_get_ch_dma,
 	.cfg_ctrl_path		= rtw89_mac_cfg_ctrl_path,
 	.mac_cfg_gnt		= rtw89_mac_cfg_gnt,
 	.stop_sch_tx		= rtw89_mac_stop_sch_tx,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index b0418e89802f..440801d63343 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2962,6 +2962,7 @@ static const struct rtw89_chip_ops rtw8852c_chip_ops = {
 	.query_rxdesc		= rtw89_core_query_rxdesc,
 	.fill_txdesc		= rtw89_core_fill_txdesc_v1,
 	.fill_txdesc_fwcmd	= rtw89_core_fill_txdesc_fwcmd_v1,
+	.get_ch_dma		= rtw89_core_get_ch_dma,
 	.cfg_ctrl_path		= rtw89_mac_cfg_ctrl_path_v1,
 	.mac_cfg_gnt		= rtw89_mac_cfg_gnt_v1,
 	.stop_sch_tx		= rtw89_mac_stop_sch_tx_v1,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index d7d09d832252..8eb0cb9bb23e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2817,6 +2817,7 @@ static const struct rtw89_chip_ops rtw8922a_chip_ops = {
 	.query_rxdesc		= rtw89_core_query_rxdesc_v2,
 	.fill_txdesc		= rtw89_core_fill_txdesc_v2,
 	.fill_txdesc_fwcmd	= rtw89_core_fill_txdesc_fwcmd_v2,
+	.get_ch_dma		= rtw89_core_get_ch_dma,
 	.cfg_ctrl_path		= rtw89_mac_cfg_ctrl_path_v2,
 	.mac_cfg_gnt		= rtw89_mac_cfg_gnt_v2,
 	.stop_sch_tx		= rtw89_mac_stop_sch_tx_v2,
diff --git a/drivers/net/wireless/realtek/rtw89/txrx.h b/drivers/net/wireless/realtek/rtw89/txrx.h
index ec01bfc363da..82d6874337b5 100644
--- a/drivers/net/wireless/realtek/rtw89/txrx.h
+++ b/drivers/net/wireless/realtek/rtw89/txrx.h
@@ -732,43 +732,6 @@ rtw89_core_get_qsel_mgmt(struct rtw89_dev *rtwdev, struct rtw89_core_tx_request
 		return RTW89_TX_QSEL_B0_MGMT;
 }
 
-static inline u8 rtw89_core_get_ch_dma(struct rtw89_dev *rtwdev, u8 qsel)
-{
-	switch (qsel) {
-	default:
-		rtw89_warn(rtwdev, "Cannot map qsel to dma: %d\n", qsel);
-		fallthrough;
-	case RTW89_TX_QSEL_BE_0:
-	case RTW89_TX_QSEL_BE_1:
-	case RTW89_TX_QSEL_BE_2:
-	case RTW89_TX_QSEL_BE_3:
-		return RTW89_TXCH_ACH0;
-	case RTW89_TX_QSEL_BK_0:
-	case RTW89_TX_QSEL_BK_1:
-	case RTW89_TX_QSEL_BK_2:
-	case RTW89_TX_QSEL_BK_3:
-		return RTW89_TXCH_ACH1;
-	case RTW89_TX_QSEL_VI_0:
-	case RTW89_TX_QSEL_VI_1:
-	case RTW89_TX_QSEL_VI_2:
-	case RTW89_TX_QSEL_VI_3:
-		return RTW89_TXCH_ACH2;
-	case RTW89_TX_QSEL_VO_0:
-	case RTW89_TX_QSEL_VO_1:
-	case RTW89_TX_QSEL_VO_2:
-	case RTW89_TX_QSEL_VO_3:
-		return RTW89_TXCH_ACH3;
-	case RTW89_TX_QSEL_B0_MGMT:
-		return RTW89_TXCH_CH8;
-	case RTW89_TX_QSEL_B0_HI:
-		return RTW89_TXCH_CH9;
-	case RTW89_TX_QSEL_B1_MGMT:
-		return RTW89_TXCH_CH10;
-	case RTW89_TX_QSEL_B1_HI:
-		return RTW89_TXCH_CH11;
-	}
-}
-
 static inline u8 rtw89_core_get_tid_indicate(struct rtw89_dev *rtwdev, u8 tid)
 {
 	switch (tid) {
-- 
2.25.1


