Return-Path: <linux-wireless+bounces-12114-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC8E961EEE
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 07:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05FF21F24F0E
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 05:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C0C1553AA;
	Wed, 28 Aug 2024 05:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="J6m+cjWq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F105C1537D4
	for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 05:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724824368; cv=none; b=gLmFxYHv/sdR4ijAb63nHXJzD+l8FrTdDHtCVMDIp+1GdxoDZeqWkSKezqj3vLspTuaDuXjxInjaTsgyAUoPBYX2F3jW5DKbF9S4j0WkAg7n4IsE7sjMSAp8koiwM9X3QJjB0rscNiaSeutuVdkoWJ02dB9dP9IS++3UBDM0Mlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724824368; c=relaxed/simple;
	bh=cAevEhmHlA2raL17/rPLEa3Mos62DR2RFiOPXKOH5Kg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TXvWDykpes09ntbGqAtDStNVh3FabuigPxQ8XdjRl2AKY0gPBqGgsZr2tckrtjUFtA6xlSZe1mFkP+8AgQfuW61jq+0iRdtJ3yK1aJkDFUsQr7BMUYJbojcbnj5jhd/4xl0rM/ILs5qE4kYfE1VGK5omK/fBDYcU/TAvm2oHA3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=J6m+cjWq; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47S5qhbO71896012, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724824363; bh=cAevEhmHlA2raL17/rPLEa3Mos62DR2RFiOPXKOH5Kg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=J6m+cjWqggfxcBD2OrCRjlXtRdvXBg4EgwqVMRqmL9cVPfJX2yQ442I60bDAdShed
	 N5X2221+kSNXpB86GCH9x6STHc5yCS82CTkkiSwwOqDJ076MPHgG4KpMLGwJv+oizT
	 g/Gj7rE4WraFewCRIp+CbgNd2V5N8/l8ZzSt2h8bMxZAzGsOGEm+xN8vMyCejAT13A
	 ZPCUOGG/sEc3FwJzqt2UDv8ss+vs1fIcRJBAfINlniuahcb55au7VFUIjjima0mEpG
	 tQ7o7nZlIxAy/txwjLg38Qro+enpLeIqtg50bvpBVkMPOrXBZMEGitUmuQcvP7rXqy
	 7aYFK9wMzGH7w==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47S5qhbO71896012
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 13:52:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 Aug 2024 13:52:44 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 28 Aug
 2024 13:52:43 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <echuang@realtek.com>
Subject: [PATCH 2/2] wifi: rtw89: use frequency domain RSSI
Date: Wed, 28 Aug 2024 13:52:17 +0800
Message-ID: <20240828055217.10263-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240828055217.10263-1-pkshih@realtek.com>
References: <20240828055217.10263-1-pkshih@realtek.com>
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

From: Eric Huang <echuang@realtek.com>

To get more accurate RSSI, this commit includes frequency domain RSSI
info in RSSI calculation. Add correspond physts parsing and macro to
get frequency domain RSSI information for supported IC.

Signed-off-by: Eric Huang <echuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     | 73 ++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/core.h     | 17 +++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 .../wireless/realtek/rtw89/rtw8852b_common.c  | 14 ++++
 .../wireless/realtek/rtw89/rtw8852b_common.h  |  9 +++
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 33 +++++++++
 drivers/net/wireless/realtek/rtw89/txrx.h     | 59 ++++++++++++++-
 11 files changed, 208 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index dc642697d74a..1486738540bb 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1583,11 +1583,27 @@ static u16 rtw89_core_get_phy_status_ie_len(struct rtw89_dev *rtwdev,
 	return ie_len;
 }
 
+static void rtw89_core_parse_phy_status_ie01_v2(struct rtw89_dev *rtwdev,
+						const struct rtw89_phy_sts_iehdr *iehdr,
+						struct rtw89_rx_phy_ppdu *phy_ppdu)
+{
+	const struct rtw89_phy_sts_ie01_v2 *ie;
+	u8 *rpl_fd = phy_ppdu->rpl_fd;
+
+	ie = (const struct rtw89_phy_sts_ie01_v2 *)iehdr;
+	rpl_fd[RF_PATH_A] = le32_get_bits(ie->w8, RTW89_PHY_STS_IE01_V2_W8_RPL_FD_A);
+	rpl_fd[RF_PATH_B] = le32_get_bits(ie->w8, RTW89_PHY_STS_IE01_V2_W8_RPL_FD_B);
+	rpl_fd[RF_PATH_C] = le32_get_bits(ie->w9, RTW89_PHY_STS_IE01_V2_W9_RPL_FD_C);
+	rpl_fd[RF_PATH_D] = le32_get_bits(ie->w9, RTW89_PHY_STS_IE01_V2_W9_RPL_FD_D);
+
+	phy_ppdu->bw_idx = le32_get_bits(ie->w5, RTW89_PHY_STS_IE01_V2_W5_BW_IDX);
+}
+
 static void rtw89_core_parse_phy_status_ie01(struct rtw89_dev *rtwdev,
 					     const struct rtw89_phy_sts_iehdr *iehdr,
 					     struct rtw89_rx_phy_ppdu *phy_ppdu)
 {
-	const struct rtw89_phy_sts_ie0 *ie = (const struct rtw89_phy_sts_ie0 *)iehdr;
+	const struct rtw89_phy_sts_ie01 *ie = (const struct rtw89_phy_sts_ie01 *)iehdr;
 	s16 cfo;
 	u32 t;
 
@@ -1598,12 +1614,17 @@ static void rtw89_core_parse_phy_status_ie01(struct rtw89_dev *rtwdev,
 		phy_ppdu->stbc = le32_get_bits(ie->w2, RTW89_PHY_STS_IE01_W2_STBC);
 	}
 
+	if (!phy_ppdu->hdr_2_en)
+		phy_ppdu->rx_path_en =
+			le32_get_bits(ie->w0, RTW89_PHY_STS_IE01_W0_RX_PATH_EN);
+
 	if (phy_ppdu->rate < RTW89_HW_RATE_OFDM6)
 		return;
 
 	if (!phy_ppdu->to_self)
 		return;
 
+	phy_ppdu->rpl_avg = le32_get_bits(ie->w0, RTW89_PHY_STS_IE01_W0_RSSI_AVG_FD);
 	phy_ppdu->ofdm.avg_snr = le32_get_bits(ie->w2, RTW89_PHY_STS_IE01_W2_AVG_SNR);
 	phy_ppdu->ofdm.evm_max = le32_get_bits(ie->w2, RTW89_PHY_STS_IE01_W2_EVM_MAX);
 	phy_ppdu->ofdm.evm_min = le32_get_bits(ie->w2, RTW89_PHY_STS_IE01_W2_EVM_MIN);
@@ -1619,6 +1640,39 @@ static void rtw89_core_parse_phy_status_ie01(struct rtw89_dev *rtwdev,
 	}
 
 	rtw89_phy_cfo_parse(rtwdev, cfo, phy_ppdu);
+
+	if (rtwdev->chip->chip_gen == RTW89_CHIP_BE)
+		rtw89_core_parse_phy_status_ie01_v2(rtwdev, iehdr, phy_ppdu);
+}
+
+static void rtw89_core_parse_phy_status_ie00(struct rtw89_dev *rtwdev,
+					     const struct rtw89_phy_sts_iehdr *iehdr,
+					     struct rtw89_rx_phy_ppdu *phy_ppdu)
+{
+	const struct rtw89_phy_sts_ie00 *ie = (const struct rtw89_phy_sts_ie00 *)iehdr;
+	u16 tmp_rpl;
+
+	tmp_rpl = le32_get_bits(ie->w0, RTW89_PHY_STS_IE00_W0_RPL);
+	phy_ppdu->rpl_avg = tmp_rpl >> 1;
+}
+
+static void rtw89_core_parse_phy_status_ie00_v2(struct rtw89_dev *rtwdev,
+						const struct rtw89_phy_sts_iehdr *iehdr,
+						struct rtw89_rx_phy_ppdu *phy_ppdu)
+{
+	const struct rtw89_phy_sts_ie00_v2 *ie;
+	u8 *rpl_path = phy_ppdu->rpl_path;
+	u16 tmp_rpl[RF_PATH_MAX];
+	u8 i;
+
+	ie = (const struct rtw89_phy_sts_ie00_v2 *)iehdr;
+	tmp_rpl[RF_PATH_A] = le32_get_bits(ie->w4, RTW89_PHY_STS_IE00_V2_W4_RPL_TD_A);
+	tmp_rpl[RF_PATH_B] = le32_get_bits(ie->w4, RTW89_PHY_STS_IE00_V2_W4_RPL_TD_B);
+	tmp_rpl[RF_PATH_C] = le32_get_bits(ie->w4, RTW89_PHY_STS_IE00_V2_W4_RPL_TD_C);
+	tmp_rpl[RF_PATH_D] = le32_get_bits(ie->w5, RTW89_PHY_STS_IE00_V2_W5_RPL_TD_D);
+
+	for (i = 0; i < RF_PATH_MAX; i++)
+		rpl_path[i] = tmp_rpl[i] >> 1;
 }
 
 static int rtw89_core_process_phy_status_ie(struct rtw89_dev *rtwdev,
@@ -1630,6 +1684,11 @@ static int rtw89_core_process_phy_status_ie(struct rtw89_dev *rtwdev,
 	ie = le32_get_bits(iehdr->w0, RTW89_PHY_STS_IEHDR_TYPE);
 
 	switch (ie) {
+	case RTW89_PHYSTS_IE00_CMN_CCK:
+		rtw89_core_parse_phy_status_ie00(rtwdev, iehdr, phy_ppdu);
+		if (rtwdev->chip->chip_gen == RTW89_CHIP_BE)
+			rtw89_core_parse_phy_status_ie00_v2(rtwdev, iehdr, phy_ppdu);
+		break;
 	case RTW89_PHYSTS_IE01_CMN_OFDM:
 		rtw89_core_parse_phy_status_ie01(rtwdev, iehdr, phy_ppdu);
 		break;
@@ -1640,6 +1699,13 @@ static int rtw89_core_process_phy_status_ie(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
+static void rtw89_core_update_phy_ppdu_hdr_v2(struct rtw89_rx_phy_ppdu *phy_ppdu)
+{
+	const struct rtw89_phy_sts_hdr_v2 *hdr = phy_ppdu->buf + PHY_STS_HDR_LEN;
+
+	phy_ppdu->rx_path_en = le32_get_bits(hdr->w0, RTW89_PHY_STS_HDR_V2_W0_PATH_EN);
+}
+
 static void rtw89_core_update_phy_ppdu(struct rtw89_rx_phy_ppdu *phy_ppdu)
 {
 	const struct rtw89_phy_sts_hdr *hdr = phy_ppdu->buf;
@@ -1651,6 +1717,10 @@ static void rtw89_core_update_phy_ppdu(struct rtw89_rx_phy_ppdu *phy_ppdu)
 	rssi[RF_PATH_B] = le32_get_bits(hdr->w1, RTW89_PHY_STS_HDR_W1_RSSI_B);
 	rssi[RF_PATH_C] = le32_get_bits(hdr->w1, RTW89_PHY_STS_HDR_W1_RSSI_C);
 	rssi[RF_PATH_D] = le32_get_bits(hdr->w1, RTW89_PHY_STS_HDR_W1_RSSI_D);
+
+	phy_ppdu->hdr_2_en = le32_get_bits(hdr->w0, RTW89_PHY_STS_HDR_W0_HDR_2_EN);
+	if (phy_ppdu->hdr_2_en)
+		rtw89_core_update_phy_ppdu_hdr_v2(phy_ppdu);
 }
 
 static int rtw89_core_rx_process_phy_ppdu(struct rtw89_dev *rtwdev,
@@ -1703,6 +1773,7 @@ static int rtw89_core_rx_parse_phy_sts(struct rtw89_dev *rtwdev,
 		}
 	}
 
+	rtw89_chip_convert_rpl_to_rssi(rtwdev, phy_ppdu);
 	rtw89_phy_antdiv_parse(rtwdev, phy_ppdu);
 
 	return 0;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 34dbe7f132f8..7c217eb61c4c 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -797,6 +797,11 @@ struct rtw89_rx_phy_ppdu {
 	u8 chan_idx;
 	u8 ie;
 	u16 rate;
+	u8 rpl_avg;
+	u8 rpl_path[RF_PATH_MAX];
+	u8 rpl_fd[RF_PATH_MAX];
+	u8 bw_idx;
+	u8 rx_path_en;
 	struct {
 		bool has;
 		u8 avg_snr;
@@ -809,6 +814,7 @@ struct rtw89_rx_phy_ppdu {
 	bool stbc;
 	bool to_self;
 	bool valid;
+	bool hdr_2_en;
 };
 
 enum rtw89_mac_idx {
@@ -3613,6 +3619,8 @@ struct rtw89_chip_ops {
 	void (*query_ppdu)(struct rtw89_dev *rtwdev,
 			   struct rtw89_rx_phy_ppdu *phy_ppdu,
 			   struct ieee80211_rx_status *status);
+	void (*convert_rpl_to_rssi)(struct rtw89_dev *rtwdev,
+				    struct rtw89_rx_phy_ppdu *phy_ppdu);
 	void (*ctrl_nbtg_bt_tx)(struct rtw89_dev *rtwdev, bool en,
 				enum rtw89_phy_idx phy_idx);
 	void (*cfg_txrx_path)(struct rtw89_dev *rtwdev);
@@ -6302,6 +6310,15 @@ static inline void rtw89_chip_query_ppdu(struct rtw89_dev *rtwdev,
 		chip->ops->query_ppdu(rtwdev, phy_ppdu, status);
 }
 
+static inline void rtw89_chip_convert_rpl_to_rssi(struct rtw89_dev *rtwdev,
+						  struct rtw89_rx_phy_ppdu *phy_ppdu)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	if (chip->ops->convert_rpl_to_rssi)
+		chip->ops->convert_rpl_to_rssi(rtwdev, phy_ppdu);
+}
+
 static inline void rtw89_ctrl_nbtg_bt_tx(struct rtw89_dev *rtwdev, bool en,
 					 enum rtw89_phy_idx phy_idx)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 6dc07edd18a2..1679bd408ef3 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2387,6 +2387,7 @@ static const struct rtw89_chip_ops rtw8851b_chip_ops = {
 	.get_thermal		= rtw8851b_get_thermal,
 	.ctrl_btg_bt_rx		= rtw8851b_ctrl_btg_bt_rx,
 	.query_ppdu		= rtw8851b_query_ppdu,
+	.convert_rpl_to_rssi	= NULL,
 	.ctrl_nbtg_bt_tx	= rtw8851b_ctrl_nbtg_bt_tx,
 	.cfg_txrx_path		= rtw8851b_bb_cfg_txrx_path,
 	.set_txpwr_ul_tb_offset	= rtw8851b_set_txpwr_ul_tb_offset,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 5eadb0cba29c..dde96bd63021 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2113,6 +2113,7 @@ static const struct rtw89_chip_ops rtw8852a_chip_ops = {
 	.get_thermal		= rtw8852a_get_thermal,
 	.ctrl_btg_bt_rx		= rtw8852a_ctrl_btg_bt_rx,
 	.query_ppdu		= rtw8852a_query_ppdu,
+	.convert_rpl_to_rssi	= NULL,
 	.ctrl_nbtg_bt_tx	= rtw8852a_ctrl_nbtg_bt_tx,
 	.cfg_txrx_path		= NULL,
 	.set_txpwr_ul_tb_offset	= rtw8852a_set_txpwr_ul_tb_offset,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index b7e92ce9256b..12be52f76427 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -741,6 +741,7 @@ static const struct rtw89_chip_ops rtw8852b_chip_ops = {
 	.get_thermal		= rtw8852bx_get_thermal,
 	.ctrl_btg_bt_rx		= rtw8852bx_ctrl_btg_bt_rx,
 	.query_ppdu		= rtw8852bx_query_ppdu,
+	.convert_rpl_to_rssi	= rtw8852bx_convert_rpl_to_rssi,
 	.ctrl_nbtg_bt_tx	= rtw8852bx_ctrl_nbtg_bt_tx,
 	.cfg_txrx_path		= rtw8852bx_bb_cfg_txrx_path,
 	.set_txpwr_ul_tb_offset	= rtw8852bx_set_txpwr_ul_tb_offset,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
index bd05880cfe8f..ede0ca5426ae 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
@@ -1947,6 +1947,19 @@ static void __rtw8852bx_query_ppdu(struct rtw89_dev *rtwdev,
 		rtw8852bx_fill_freq_with_ppdu(rtwdev, phy_ppdu, status);
 }
 
+static void __rtw8852bx_convert_rpl_to_rssi(struct rtw89_dev *rtwdev,
+					    struct rtw89_rx_phy_ppdu *phy_ppdu)
+{
+	u8 delta = phy_ppdu->rpl_avg - phy_ppdu->rssi_avg;
+	u8 *rssi = phy_ppdu->rssi;
+	u8 i;
+
+	for (i = 0; i < RF_PATH_NUM_8852BX; i++)
+		rssi[i] += delta;
+
+	phy_ppdu->rssi_avg = phy_ppdu->rpl_avg;
+}
+
 static int __rtw8852bx_mac_enable_bb_rf(struct rtw89_dev *rtwdev)
 {
 	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
@@ -2029,6 +2042,7 @@ const struct rtw8852bx_info rtw8852bx_info = {
 	.ctrl_nbtg_bt_tx = __rtw8852bx_ctrl_nbtg_bt_tx,
 	.ctrl_btg_bt_rx = __rtw8852bx_ctrl_btg_bt_rx,
 	.query_ppdu = __rtw8852bx_query_ppdu,
+	.convert_rpl_to_rssi = __rtw8852bx_convert_rpl_to_rssi,
 	.read_efuse = __rtw8852bx_read_efuse,
 	.read_phycap = __rtw8852bx_read_phycap,
 	.power_trim = __rtw8852bx_power_trim,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.h b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.h
index a916e38c76c1..3dce5422f41e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.h
@@ -146,6 +146,8 @@ struct rtw8852bx_info {
 	void (*query_ppdu)(struct rtw89_dev *rtwdev,
 			   struct rtw89_rx_phy_ppdu *phy_ppdu,
 			   struct ieee80211_rx_status *status);
+	void (*convert_rpl_to_rssi)(struct rtw89_dev *rtwdev,
+				    struct rtw89_rx_phy_ppdu *phy_ppdu);
 	int (*read_efuse)(struct rtw89_dev *rtwdev, u8 *log_map,
 			  enum rtw89_efuse_block block);
 	int (*read_phycap)(struct rtw89_dev *rtwdev, u8 *phycap_map);
@@ -293,6 +295,13 @@ void rtw8852bx_query_ppdu(struct rtw89_dev *rtwdev,
 	rtw8852bx_info.query_ppdu(rtwdev, phy_ppdu, status);
 }
 
+static inline
+void rtw8852bx_convert_rpl_to_rssi(struct rtw89_dev *rtwdev,
+				   struct rtw89_rx_phy_ppdu *phy_ppdu)
+{
+	rtw8852bx_info.convert_rpl_to_rssi(rtwdev, phy_ppdu);
+}
+
 static inline
 int rtw8852bx_read_efuse(struct rtw89_dev *rtwdev, u8 *log_map,
 			 enum rtw89_efuse_block block)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index 52a76d2646e9..7dfdcb5964e1 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -675,6 +675,7 @@ static const struct rtw89_chip_ops rtw8852bt_chip_ops = {
 	.get_thermal		= rtw8852bx_get_thermal,
 	.ctrl_btg_bt_rx		= rtw8852bx_ctrl_btg_bt_rx,
 	.query_ppdu		= rtw8852bx_query_ppdu,
+	.convert_rpl_to_rssi	= rtw8852bx_convert_rpl_to_rssi,
 	.ctrl_nbtg_bt_tx	= rtw8852bx_ctrl_nbtg_bt_tx,
 	.cfg_txrx_path		= rtw8852bx_bb_cfg_txrx_path,
 	.set_txpwr_ul_tb_offset	= rtw8852bx_set_txpwr_ul_tb_offset,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 4a7eaebcdddc..1c6e89ab0f4b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2890,6 +2890,7 @@ static const struct rtw89_chip_ops rtw8852c_chip_ops = {
 	.get_thermal		= rtw8852c_get_thermal,
 	.ctrl_btg_bt_rx		= rtw8852c_ctrl_btg_bt_rx,
 	.query_ppdu		= rtw8852c_query_ppdu,
+	.convert_rpl_to_rssi	= NULL,
 	.ctrl_nbtg_bt_tx	= rtw8852c_ctrl_nbtg_bt_tx,
 	.cfg_txrx_path		= rtw8852c_bb_cfg_txrx_path,
 	.set_txpwr_ul_tb_offset	= rtw8852c_set_txpwr_ul_tb_offset,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 3387989299c9..24073c820d4f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2497,6 +2497,38 @@ static void rtw8922a_query_ppdu(struct rtw89_dev *rtwdev,
 		rtw8922a_fill_freq_with_ppdu(rtwdev, phy_ppdu, status);
 }
 
+static void rtw8922a_convert_rpl_to_rssi(struct rtw89_dev *rtwdev,
+					 struct rtw89_rx_phy_ppdu *phy_ppdu)
+{
+	/* Mapping to BW: 5, 10, 20, 40, 80, 160, 80_80 */
+	static const u8 bw_compensate[] = {0, 0, 0, 6, 12, 18, 0};
+	u8 *rssi = phy_ppdu->rssi;
+	u8 compensate = 0;
+	u16 rpl_tmp;
+	u8 i;
+
+	if (phy_ppdu->bw_idx < ARRAY_SIZE(bw_compensate))
+		compensate = bw_compensate[phy_ppdu->bw_idx];
+
+	for (i = 0; i < RF_PATH_NUM_8922A; i++) {
+		if (!(phy_ppdu->rx_path_en & BIT(i))) {
+			rssi[i] = 0;
+			phy_ppdu->rpl_path[i] = 0;
+			phy_ppdu->rpl_fd[i] = 0;
+		}
+		if (phy_ppdu->rate >= RTW89_HW_RATE_OFDM6) {
+			rpl_tmp = phy_ppdu->rpl_fd[i];
+			if (rpl_tmp)
+				rpl_tmp += compensate;
+
+			phy_ppdu->rpl_path[i] = rpl_tmp;
+		}
+		rssi[i] = phy_ppdu->rpl_path[i];
+	}
+
+	phy_ppdu->rssi_avg = phy_ppdu->rpl_avg;
+}
+
 static int rtw8922a_mac_enable_bb_rf(struct rtw89_dev *rtwdev)
 {
 	rtw89_write8_set(rtwdev, R_BE_FEN_RST_ENABLE,
@@ -2552,6 +2584,7 @@ static const struct rtw89_chip_ops rtw8922a_chip_ops = {
 	.get_thermal		= rtw8922a_get_thermal,
 	.ctrl_btg_bt_rx		= rtw8922a_ctrl_btg_bt_rx,
 	.query_ppdu		= rtw8922a_query_ppdu,
+	.convert_rpl_to_rssi	= rtw8922a_convert_rpl_to_rssi,
 	.ctrl_nbtg_bt_tx	= rtw8922a_ctrl_nbtg_bt_tx,
 	.cfg_txrx_path		= rtw8922a_bb_cfg_txrx_path,
 	.set_txpwr_ul_tb_offset	= NULL,
diff --git a/drivers/net/wireless/realtek/rtw89/txrx.h b/drivers/net/wireless/realtek/rtw89/txrx.h
index a33280ec2a25..b2e47829983f 100644
--- a/drivers/net/wireless/realtek/rtw89/txrx.h
+++ b/drivers/net/wireless/realtek/rtw89/txrx.h
@@ -441,6 +441,7 @@ struct rtw89_phy_sts_hdr {
 } __packed;
 
 #define RTW89_PHY_STS_HDR_W0_IE_MAP GENMASK(4, 0)
+#define RTW89_PHY_STS_HDR_W0_HDR_2_EN BIT(5)
 #define RTW89_PHY_STS_HDR_W0_VALID BIT(7)
 #define RTW89_PHY_STS_HDR_W0_LEN GENMASK(15, 8)
 #define RTW89_PHY_STS_HDR_W0_RSSI_AVG GENMASK(31, 24)
@@ -449,6 +450,13 @@ struct rtw89_phy_sts_hdr {
 #define RTW89_PHY_STS_HDR_W1_RSSI_C GENMASK(23, 16)
 #define RTW89_PHY_STS_HDR_W1_RSSI_D GENMASK(31, 24)
 
+struct rtw89_phy_sts_hdr_v2 {
+	__le32 w0;
+	__le32 w1;
+} __packed;
+
+#define RTW89_PHY_STS_HDR_V2_W0_PATH_EN GENMASK(20, 16)
+
 struct rtw89_phy_sts_iehdr {
 	__le32 w0;
 };
@@ -552,13 +560,43 @@ struct rtw89_phy_sts_iehdr {
 #define BE_RXD_HDR_OFFSET_MASK GENMASK(20, 16)
 #define BE_RXD_WL_HD_IV_LEN_MASK GENMASK(26, 21)
 
-struct rtw89_phy_sts_ie0 {
+struct rtw89_phy_sts_ie00 {
+	__le32 w0;
+	__le32 w1;
+	__le32 w2;
+	__le32 w3;
+} __packed;
+
+#define RTW89_PHY_STS_IE00_W0_RPL GENMASK(15, 7)
+
+struct rtw89_phy_sts_ie00_v2 {
 	__le32 w0;
 	__le32 w1;
 	__le32 w2;
+	__le32 w3;
+	__le32 w4;
+	__le32 w5;
+	__le32 w6;
+	__le32 w7;
+} __packed;
+
+#define RTW89_PHY_STS_IE00_V2_W4_RPL_TD_A GENMASK(8, 0)
+#define RTW89_PHY_STS_IE00_V2_W4_RPL_TD_B GENMASK(17, 9)
+#define RTW89_PHY_STS_IE00_V2_W4_RPL_TD_C GENMASK(26, 18)
+#define RTW89_PHY_STS_IE00_V2_W5_RPL_TD_D GENMASK(8, 0)
+
+struct rtw89_phy_sts_ie01 {
+	__le32 w0;
+	__le32 w1;
+	__le32 w2;
+	__le32 w3;
+	__le32 w4;
+	__le32 w5;
 } __packed;
 
 #define RTW89_PHY_STS_IE01_W0_CH_IDX GENMASK(23, 16)
+#define RTW89_PHY_STS_IE01_W0_RSSI_AVG_FD GENMASK(15, 8)
+#define RTW89_PHY_STS_IE01_W0_RX_PATH_EN GENMASK(31, 28)
 #define RTW89_PHY_STS_IE01_W1_FD_CFO GENMASK(19, 8)
 #define RTW89_PHY_STS_IE01_W1_PREMB_CFO GENMASK(31, 20)
 #define RTW89_PHY_STS_IE01_W2_AVG_SNR GENMASK(5, 0)
@@ -567,6 +605,25 @@ struct rtw89_phy_sts_ie0 {
 #define RTW89_PHY_STS_IE01_W2_LDPC BIT(28)
 #define RTW89_PHY_STS_IE01_W2_STBC BIT(30)
 
+struct rtw89_phy_sts_ie01_v2 {
+	__le32 w0;
+	__le32 w1;
+	__le32 w2;
+	__le32 w3;
+	__le32 w4;
+	__le32 w5;
+	__le32 w6;
+	__le32 w7;
+	__le32 w8;
+	__le32 w9;
+} __packed;
+
+#define RTW89_PHY_STS_IE01_V2_W5_BW_IDX GENMASK(31, 29)
+#define RTW89_PHY_STS_IE01_V2_W8_RPL_FD_A GENMASK(11, 4)
+#define RTW89_PHY_STS_IE01_V2_W8_RPL_FD_B GENMASK(23, 16)
+#define RTW89_PHY_STS_IE01_V2_W9_RPL_FD_C GENMASK(11, 4)
+#define RTW89_PHY_STS_IE01_V2_W9_RPL_FD_D GENMASK(23, 16)
+
 enum rtw89_tx_channel {
 	RTW89_TXCH_ACH0	= 0,
 	RTW89_TXCH_ACH1	= 1,
-- 
2.25.1


