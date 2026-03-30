Return-Path: <linux-wireless+bounces-34166-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGxhJkkfymmu5QUAu9opvQ
	(envelope-from <linux-wireless+bounces-34166-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 08:59:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F9E35625C
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 08:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 06C0F3004C11
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 06:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B1D286D73;
	Mon, 30 Mar 2026 06:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="XZO7RjhL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5E624E4B4
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 06:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774853959; cv=none; b=GYxvqterP5EXi3xutOqosYaKw6H996qBvjFy6ObjIGmNyU+Bsjsy759MsgkmdvLq/Y0slDELLSSGMdSzk9BP6VtZYrPFYznuORKd/s4+9UUuDxXr6kLBkippkbRUQMh1l1liUK/EwR6L3+Utnui35KKBuHmHmHWEJfDpzv2YYjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774853959; c=relaxed/simple;
	bh=c8TfGKjaC5mZmZPDvkKzEDOZl5JIvhgcLv/ffVru1fI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=If0SVE4QJ4F3qmS69G94HkmdT0KU6ha7FzKqvsgYgXy1Ngk4L0V6dZnJt1voTRCB4SoiAv8mExH7IMxPyNOCTU5UI0hSnYYvY6JB4sw//9gkfK04A5fh77y0aSeZHEvBa2LtP1eJbwJ81BcH4pXdIXWMbEW65zuhlbe/4lzci/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=XZO7RjhL; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62U6xFLe9673841, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774853955; bh=Ij99hMbPg2N4Upkg1qr2lXTtRp2iFCaUaoZAO1Vj1PY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=XZO7RjhLNjQBix1C5xS4ZoITya8TUYLU1P7YDpLNHqIdc9Xz5BAMeFAQyVPkQ0Sae
	 vK/wk1BxydDRbKamoR0gTzNhwatIyZbq/SALMhpyDMPXHakeMQQy4cLQBIFvsjczTy
	 jnXVLc+6Lc3/UyQ3stpRouxc0V9QFGAEjm+mvb+rwvQHWZj/okxjWn3dzHZ9CdBtej
	 yWYTbfePTZqfdn1tq/b03brSK8uY1742+spH7sEhtmYGUwIs3GRrwYLfUFuD9E4PEE
	 SiAbgkvoWYCDKnDWD0i5tJt398JytEZ6G8H2TE8/Yy4OspuU+XLKjjguWEEriFR6Xx
	 qZv6OFq6UnqlA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62U6xFLe9673841
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 14:59:15 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Mar 2026 14:59:15 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 30 Mar 2026 14:59:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 5/9] wifi: rtw89: 8922d: configure TX/RX path assisting in BT coexistence
Date: Mon, 30 Mar 2026 14:58:43 +0800
Message-ID: <20260330065847.48946-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260330065847.48946-1-pkshih@realtek.com>
References: <20260330065847.48946-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34166-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:email,realtek.com:mid]
X-Rspamd-Queue-Id: 15F9E35625C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The BT coexistence mechanism needs to control TX/RX path to co-work with
BT well, and these helpers are provided by BB to configure path.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      |   9 +-
 drivers/net/wireless/realtek/rtw89/rtw8922d.c | 125 ++++++++++++++++++
 2 files changed, 132 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 37de1c827814..78f2cf579fa6 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -10469,8 +10469,9 @@
 #define B_EMLSR_BB_CLK_BE4 GENMASK(31, 30)
 #define R_CHINFO_SEG_BE4 0x200B4
 #define B_CHINFO_SEG_LEN_BE4 GENMASK(12, 10)
-#define R_STS_HDR2_PARSING_BE4 0x2070C
-#define B_STS_HDR2_PARSING_BE4 BIT(10)
+#define R_SEL_GNT_BT_RX_BE4 0x2010C
+#define B_SEL_GNT_BT_RX_PATH0_BE4 GENMASK(3, 0)
+#define B_SEL_GNT_BT_RX_PATH1_BE4 GENMASK(11, 8)
 #define R_SW_SI_WDATA_BE4 0x20370
 #define B_SW_SI_DATA_PATH_BE4 GENMASK(31, 28)
 #define B_SW_SI_DATA_ADR_BE4 GENMASK(27, 20)
@@ -10490,9 +10491,13 @@
 #define B_ENABLE_CCK0_BE4 BIT(5)
 #define R_RSTB_ASYNC_BE4 0x20704
 #define B_RSTB_ASYNC_BE4 BIT(1)
+#define R_STS_HDR2_PARSING_BE4 0x2070C
+#define B_STS_HDR2_PARSING_BE4 BIT(10)
 #define R_EDCCA_RPT_SEL_BE4 0x20780
 #define R_EDCCA_RPT_SEL_BE4_C1 0x21780
 #define B_EDCCA_RPT_SEL_BE4_MSK 0xE0000
+#define R_SEL_GNT_BT_RXPHY_BE4 0x2079C
+#define B_SEL_GNT_BT_RXPHY_BE4 GENMASK(11, 8)
 #define R_IMR_TX_ERROR_BE4 0x20920
 #define B_IMR_TX_ERROR_BE4 BIT(30)
 #define R_TXINFO_PATH_BE4 0x209A4
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.c b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
index 9c62a5f12962..cfe9752abddc 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
@@ -238,6 +238,35 @@ static const struct rtw89_efuse_block_cfg rtw8922d_efuse_blocks[] = {
 	[RTW89_EFUSE_BLOCK_ADIE]		= {.offset = 0x70000, .size = 0x10},
 };
 
+static void rtw8922d_sel_bt_rx_path(struct rtw89_dev *rtwdev, u8 val,
+				    enum rtw89_rf_path rx_path)
+{
+	if (rx_path == RF_PATH_A)
+		rtw89_phy_write32_mask(rtwdev, R_SEL_GNT_BT_RX_BE4,
+				       B_SEL_GNT_BT_RX_PATH0_BE4, val);
+	else if (rx_path == RF_PATH_B)
+		rtw89_phy_write32_mask(rtwdev, R_SEL_GNT_BT_RX_BE4,
+				       B_SEL_GNT_BT_RX_PATH1_BE4, val);
+	else
+		rtw89_warn(rtwdev, "[%s] Not support path = %d\n", __func__, rx_path);
+}
+
+static void rtw8922d_sel_bt_rx_phy(struct rtw89_dev *rtwdev, u8 val,
+				   enum rtw89_phy_idx phy_idx)
+{
+	rtw89_phy_write32_idx(rtwdev, R_SEL_GNT_BT_RXPHY_BE4,
+			      B_SEL_GNT_BT_RXPHY_BE4, val, phy_idx);
+}
+
+static void rtw8922d_set_gbt_bt_rx_sel(struct rtw89_dev *rtwdev, bool en,
+				       enum rtw89_phy_idx phy_idx)
+{
+	rtw8922d_sel_bt_rx_path(rtwdev, 0x3, RF_PATH_A);
+	rtw8922d_sel_bt_rx_phy(rtwdev, 0x0, RTW89_PHY_0);
+	rtw8922d_sel_bt_rx_path(rtwdev, 0x3, RF_PATH_B);
+	rtw8922d_sel_bt_rx_phy(rtwdev, 0x0, RTW89_PHY_1);
+}
+
 static int rtw8922d_pwr_on_func(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
@@ -2437,6 +2466,102 @@ static void rtw8922d_set_txpwr_ctrl(struct rtw89_dev *rtwdev,
 	rtw8922d_set_txpwr_ref(rtwdev, chan, phy_idx);
 }
 
+static void rtw8922d_ctrl_trx_path(struct rtw89_dev *rtwdev,
+				   enum rtw89_rf_path tx_path, u8 tx_nss,
+				   enum rtw89_rf_path rx_path, u8 rx_nss)
+{
+	enum rtw89_phy_idx phy_idx;
+
+	for (phy_idx = RTW89_PHY_0; phy_idx <= RTW89_PHY_1; phy_idx++) {
+		rtw8922d_ctrl_tx_path_tmac(rtwdev, tx_path, phy_idx);
+		rtw8922d_ctrl_rx_path_tmac(rtwdev, rx_path, phy_idx);
+
+		rtw8922d_tssi_reset(rtwdev, rx_path, phy_idx);
+	}
+}
+
+static void rtw8922d_ctrl_nbtg_bt_tx(struct rtw89_dev *rtwdev, bool en,
+				     enum rtw89_phy_idx phy_idx)
+{
+	if (en) {
+		rtw89_phy_write32_idx(rtwdev, R_FORCE_FIR_A, B_FORCE_FIR_A, 0x3, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RXBY_WBADC_A, B_RXBY_WBADC_A,
+				      0xf, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BT_RXBY_WBADC_A, B_BT_RXBY_WBADC_A,
+				      0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BT_SHARE_A, B_BT_TRK_OFF_A, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_OP1DB_A, B_OP1DB_A, 0x80, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_OP1DB1_A, B_TIA10_A, 0x8080, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BACKOFF_A, B_LNA_IBADC_A, 0x34, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BKOFF_A, B_BKOFF_IBADC_A, 0x34, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_FORCE_FIR_B, B_FORCE_FIR_B, 0x3, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RXBY_WBADC_B, B_RXBY_WBADC_B,
+				      0xf, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BT_RXBY_WBADC_B, B_BT_RXBY_WBADC_B,
+				      0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BT_SHARE_B, B_BT_TRK_OFF_B, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_LNA_TIA, B_TIA1_B, 0x80, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BACKOFF_B, B_LNA_IBADC_B, 0x34, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BKOFF_B, B_BKOFF_IBADC_B, 0x34, phy_idx);
+	} else {
+		rtw89_phy_write32_idx(rtwdev, R_FORCE_FIR_A, B_FORCE_FIR_A, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RXBY_WBADC_A, B_RXBY_WBADC_A,
+				      0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BT_RXBY_WBADC_A, B_BT_RXBY_WBADC_A,
+				      0x1, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BT_SHARE_A, B_BT_TRK_OFF_A, 0x1, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_OP1DB_A, B_OP1DB_A, 0x1a, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_OP1DB1_A, B_TIA10_A, 0x2a2a, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BACKOFF_A, B_LNA_IBADC_A, 0x7a6, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BKOFF_A, B_BKOFF_IBADC_A, 0x26, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_FORCE_FIR_B, B_FORCE_FIR_B, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RXBY_WBADC_B, B_RXBY_WBADC_B,
+				      0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BT_RXBY_WBADC_B, B_BT_RXBY_WBADC_B,
+				      0x1, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BT_SHARE_B, B_BT_TRK_OFF_B, 0x1, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_LNA_TIA, B_TIA1_B, 0x2a, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BACKOFF_B, B_LNA_IBADC_B, 0x7a6, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BKOFF_B, B_BKOFF_IBADC_B, 0x26, phy_idx);
+	}
+}
+
+static void rtw8922d_bb_cfg_txrx_path(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
+	enum rtw89_band band = chan->band_type;
+	struct rtw89_hal *hal = &rtwdev->hal;
+	u8 ntx_path = RF_PATH_AB;
+	u8 nrx_path = RF_PATH_AB;
+	u32 tx_en0, tx_en1;
+	u8 rx_nss = 2;
+
+	if (hal->antenna_tx == RF_A)
+		ntx_path = RF_PATH_A;
+	else if (hal->antenna_tx == RF_B)
+		ntx_path = RF_PATH_B;
+
+	if (hal->antenna_rx == RF_A)
+		nrx_path = RF_PATH_A;
+	else if (hal->antenna_rx == RF_B)
+		nrx_path = RF_PATH_B;
+
+	if (nrx_path != RF_PATH_AB)
+		rx_nss = 1;
+
+	rtw8922d_hal_reset(rtwdev, RTW89_PHY_0, RTW89_MAC_0, band, &tx_en0, true);
+	if (rtwdev->dbcc_en)
+		rtw8922d_hal_reset(rtwdev, RTW89_PHY_1, RTW89_MAC_1, band,
+				   &tx_en1, true);
+
+	rtw8922d_ctrl_trx_path(rtwdev, ntx_path, 2, nrx_path, rx_nss);
+
+	rtw8922d_hal_reset(rtwdev, RTW89_PHY_0, RTW89_MAC_0, band, &tx_en0, false);
+	if (rtwdev->dbcc_en)
+		rtw8922d_hal_reset(rtwdev, RTW89_PHY_1, RTW89_MAC_1, band,
+				   &tx_en1, false);
+}
+
 MODULE_FIRMWARE(RTW8922D_MODULE_FIRMWARE);
 MODULE_FIRMWARE(RTW8922DS_MODULE_FIRMWARE);
 MODULE_AUTHOR("Realtek Corporation");
-- 
2.25.1


