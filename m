Return-Path: <linux-wireless+bounces-34162-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDQSNy4gymmu5QUAu9opvQ
	(envelope-from <linux-wireless+bounces-34162-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 09:03:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 448B03562EC
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 09:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EC423013AA3
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 06:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C46A286D73;
	Mon, 30 Mar 2026 06:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="GpIn3tQY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3758124E4B4
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 06:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774853939; cv=none; b=r/lad72olyZe47QG3Kb6sVAeIdnbpXYjAlFqmSOeGxum6yZ4O1s0eXpH7kUAJUPWjMCL9FWOIaQoS6PmdMQmzGOTM77d8UAhyxBJVFZtmP2DrZP7AS4NEfelo7rv1VGgjO4nDyyhti++OGA+DaWCwkWeA1muGnusm6BE+lo3FC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774853939; c=relaxed/simple;
	bh=uNtCrTRppaQnK3EMrdJkaTyzx34f599KlM5YdHCcR5s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rvCbUyF8QAG9fZfDXVwNb18gjwBFSWyHMDZroAfsryBcKgOWXzJGDQqM8esfFB5VzqrY0pezTiM27mLD4snIC7O5lj9BogRAVKhd66CEWMjqacnCLy9M+SkpcZPqUBOOB7u1638F5+z9kHrIHsOqSr/ufyfG+X/yEhmqC+rLY+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=GpIn3tQY; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62U6wsr57673791, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774853934; bh=o/pVCnNsFl3uHJWo3PI1VNfhoiEAeG+/R7VjmxqlqFM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=GpIn3tQYkfgdHhNNa6HH1IFEzVv3oRc4XWBDV18M1Kb24rgFNr0nLHMZiN43IqLg3
	 21ZjHhU2I+hLK/xSeUaV3DqnpXF+0I8ipu21azzGqHCRSgs6HkV2r3yu7qP0MQpyrm
	 knJasrUxO96iU18qDcibvRb5yDkTLHCFB3WXq8ViAezbYoIDRcVMbz5FvCPd/2A8L9
	 YgatXtNCXCsjitp1RV0OwTVZ/aOihiaB3CcFX2NrHlzHMT5QkHG2HoW/jOVY5Yp9Dg
	 p5fk/q6Fd7Ywhly39+qrovlHawlxFI6aMbI6yGdlv/Zvm8W73JzkHS8zgn4CxUyo/j
	 w5z33guDvUckQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62U6wsr57673791
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 14:58:54 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Mar 2026 14:58:55 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 30 Mar 2026 14:58:52 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 30 Mar 2026 14:58:52 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 1/9] wifi: rtw89: 8922d: BB hardware pre-/post-init, TX/RX path and power settings
Date: Mon, 30 Mar 2026 14:58:39 +0800
Message-ID: <20260330065847.48946-2-pkshih@realtek.com>
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
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-34162-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:email,realtek.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MAILSPIKE_FAIL(0.00)[2600:3c0a:e001:db::12fc:5321:query timed out];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 448B03562EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

More settings related to BB pre-/post-initial settings, the TX/RX path
settings, and digital power compensation.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      |  64 ++++
 drivers/net/wireless/realtek/rtw89/rtw8922d.c | 318 ++++++++++++++++++
 2 files changed, 382 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 5d284f310069..e64bd74db83a 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -8384,6 +8384,9 @@
 #define B_BE_PWR_BT_VAL GENMASK(8, 0)
 #define B_BE_PWR_FORCE_COEX_ON GENMASK(29, 27)
 
+#define R_PWR_BOOST_BE4 0x11A64
+#define B_PWR_BOOST_BE4 BIT(8)
+
 #define R_BE_PWR_TH 0x11A78
 #define R_BE_PWR_RSSI_TARGET_LMT 0x11A84
 
@@ -10248,6 +10251,8 @@
 #define R_TSSI_K_P1 0xE7A0
 #define B_TSSI_K_OFDM_P1 GENMASK(29, 20)
 
+#define R_BBWRAP_ELMSR_BE4 0x11974
+#define B_BBWRAP_ELMSR_EN_BE4 GENMASK(29, 28)
 #define R_COMP_CIM3K_BE4 0x11998
 #define B_COMP_CIM3K_OW_BE4 BIT(1)
 #define B_COMP_CIM3K_TH_BE4 BIT(2)
@@ -10452,6 +10457,12 @@
 #define R_BANDEDGE_DBWY_BE4 0x11AD0
 #define B_BANDEDGE_DBW160_BE4 BIT(0)
 
+#define R_SYS_DBCC_BE4 0x20000
+#define B_SYS_DBCC_BE4 BIT(0)
+#define B_SYS_DBCC_24G_BAND_SEL_BE4 BIT(1)
+#define R_EMLSR_SWITCH_BE4 0x20044
+#define B_EMLSR_SWITCH_BE4 GENMASK(27, 12)
+#define B_EMLSR_BB_CLK_BE4 GENMASK(31, 30)
 #define R_CHINFO_SEG_BE4 0x200B4
 #define B_CHINFO_SEG_LEN_BE4 GENMASK(12, 10)
 #define R_STS_HDR2_PARSING_BE4 0x2070C
@@ -10467,11 +10478,25 @@
 #define B_RXBW7_BE4 GENMASK(25, 23)
 #define R_RXBW_BE4 0x20410
 #define B_RXBW_BE4 GENMASK(29, 27)
+#define R_TXERRCT_EN_BE4 0x20518
+#define B_TXERRCT_EN_BE4 BIT(13)
+#define R_TXERRCT1_EN_BE4 0x2051C
+#define B_TXERRCT1_EN_BE4 BIT(31)
 #define R_ENABLE_CCK0_BE4 0x20700
 #define B_ENABLE_CCK0_BE4 BIT(5)
+#define R_RSTB_ASYNC_BE4 0x20704
+#define B_RSTB_ASYNC_BE4 BIT(1)
 #define R_EDCCA_RPT_SEL_BE4 0x20780
 #define R_EDCCA_RPT_SEL_BE4_C1 0x21780
 #define B_EDCCA_RPT_SEL_BE4_MSK 0xE0000
+#define R_IMR_TX_ERROR_BE4 0x20920
+#define B_IMR_TX_ERROR_BE4 BIT(30)
+#define R_TXINFO_PATH_BE4 0x209A4
+#define B_TXINFO_PATH_EN_BE4 BIT(17)
+#define B_TXINFO_PATH_MA_BE4 BIT(18)
+#define B_TXINFO_PATH_MB_BE4 BIT(19)
+#define R_SHAPER_COEFF_BE4 0x20CBC
+#define B_SHAPER_COEFF_BE4 BIT(19)
 #define R_IFS_T1_AVG_BE4 0x20EDC
 #define B_IFS_T1_AVG_BE4 GENMASK(15, 0)
 #define B_IFS_T2_AVG_BE4 GENMASK(31, 16)
@@ -10494,6 +10519,12 @@
 #define B_IFS_T3_HIS_BE4 GENMASK(15, 0)
 #define B_IFS_T4_HIS_BE4 GENMASK(31, 16)
 
+#define R_TX_ERROR_SEL_BE4 0x21254
+#define B_TX_ERROR_PSDU_BE4 BIT(11)
+#define B_TX_ERROR_NSYM_BE4 BIT(10)
+#define B_TX_ERROR_LSIG_BE4 BIT(9)
+#define B_TX_ERROR_TXINFO_BE4 BIT(8)
+
 #define R_TXPWR_RSTB0_BE4 0x2250C
 #define B_TXPWR_RSTB0_BE4 BIT(16)
 #define R_TXPWR_RSTB1_BE4 0x2260C
@@ -10546,6 +10577,10 @@
 #define B_PRISB_BE4 GENMASK(3, 0)
 #define R_FC0_BE4 0x24EE8
 #define B_FC0_BE4 GENMASK(12, 0)
+#define R_ANT_RX_1RCCA_BE4 0x24EEC
+#define B_ANT_RX_1RCCA_BE4 GENMASK(17, 14)
+#define R_ANT_RX_BE4 0x24EF0
+#define B_ANT_RX_BE4 GENMASK(3, 0)
 #define R_FC0_INV_BE4 0x24EF4
 #define B_FC0_INV_BE4 GENMASK(15, 0)
 
@@ -10569,6 +10604,32 @@
 #define B_CHINFO_NX_BE4 GENMASK(16, 6)
 #define R_CHINFO_ALG_BE4 0x267C8
 #define B_CHINFO_ALG_BE4 GENMASK(31, 30)
+#define R_RX_AWGN02_BE4 0x2680C
+#define B_RX_AWGN11_BE4 GENMASK(23, 18)
+#define R_RX_AWGN00_BE4 0x26814
+#define B_RX_AWGN04_BE4 GENMASK(5, 0)
+#define B_RX_AWGN07_BE4 GENMASK(23, 18)
+#define R_RX_AWGN01_BE4 0x26818
+#define B_RX_AWGN09_BE4 GENMASK(5, 0)
+#define R_RXCH_BCC0_BE4 0x26824
+#define B_RXCH_MCS4_BE4 GENMASK(29, 24)
+#define R_RXCH_BCC1_BE4 0x26828
+#define B_RXCH_MCS5_BE4 GENMASK(5, 0)
+#define B_RXCH_MCS6_BE4 GENMASK(11, 6)
+#define B_RXCH_MCS7_BE4 GENMASK(17, 12)
+#define B_RXCH_MCS8_BE4 GENMASK(23, 18)
+#define B_RXCH_MCS9_BE4 GENMASK(29, 24)
+#define R_RX_LDPC02_BE4 0x26834
+#define B_RX_LDPC10_BE4 GENMASK(17, 12)
+#define B_RX_LDPC11_BE4 GENMASK(23, 18)
+#define R_RX_LDPC00_BE4 0x2683C
+#define B_RX_LDPC04_BE4 GENMASK(5, 0)
+#define B_RX_LDPC05_BE4 GENMASK(11, 6)
+#define B_RX_LDPC06_BE4 GENMASK(17, 12)
+#define B_RX_LDPC07_BE4 GENMASK(23, 18)
+#define B_RX_LDPC08_BE4 GENMASK(29, 24)
+#define R_RX_LDPC01_BE4 0x26840
+#define B_RX_LDPC09_BE4 GENMASK(5, 0)
 
 #define R_SW_SI_DATA_BE4 0x2CF4C
 #define B_SW_SI_READ_DATA_BE4 GENMASK(19, 0)
@@ -10576,6 +10637,9 @@
 #define B_SW_SI_R_BUSY_BE4 BIT(25)
 #define B_SW_SI_READ_DATA_DONE_BE4 BIT(26)
 
+#define R_RX_PATH0_TBL0_BE4 0x2E028
+#define R_RX_PATH1_TBL0_BE4 0x2E128
+
 /* WiFi CPU local domain */
 #define R_AX_WDT_CTRL 0x0040
 #define B_AX_WDT_EN BIT(31)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.c b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
index 1b5fc6c9ea85..51b025d898ff 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2026  Realtek Corporation
  */
 
+#include "chan.h"
 #include "debug.h"
 #include "efuse.h"
 #include "mac.h"
@@ -1690,6 +1691,94 @@ static void rtw8922d_spur_elimination(struct rtw89_dev *rtwdev,
 	rtw8922d_set_nbi_tone_idx(rtwdev, chan, RF_PATH_B, phy_idx);
 }
 
+static const u32 bbrst_mask[2] = {B_BE_FEN_BBPLAT_RSTB, B_BE_FEN_BB1PLAT_RSTB};
+static const u32 glbrst_mask[2] = {B_BE_FEN_BB_IP_RSTN, B_BE_FEN_BB1_IP_RSTN};
+static const u32 chip_top_bitmask[2] = {0xffff, 0xffff0000};
+
+static void rtw8922d_bb_preinit(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+{
+	rtw89_write32_mask(rtwdev, R_BE_FEN_RST_ENABLE, glbrst_mask[phy_idx], 0x0);
+	rtw89_write32_mask(rtwdev, R_BE_FEN_RST_ENABLE, bbrst_mask[phy_idx], 0x0);
+	rtw89_write32_mask(rtwdev, R_BE_DMAC_SYS_CR32B, chip_top_bitmask[phy_idx], 0x74F9);
+	rtw89_write32_mask(rtwdev, R_BE_FEN_RST_ENABLE, glbrst_mask[phy_idx], 0x1);
+	rtw89_phy_write32_idx(rtwdev, R_RSTB_ASYNC_BE4,  B_RSTB_ASYNC_BE4, 0, phy_idx);
+	rtw89_write32_mask(rtwdev, R_BE_FEN_RST_ENABLE, bbrst_mask[phy_idx], 0x1);
+}
+
+static void rtw8922d_bb_postinit(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+{
+	rtw89_phy_write32_idx_clr(rtwdev, R_SHAPER_COEFF_BE4, B_SHAPER_COEFF_BE4, phy_idx);
+	rtw89_phy_write32_idx_set(rtwdev, R_SHAPER_COEFF_BE4, B_SHAPER_COEFF_BE4, phy_idx);
+}
+
+static void rtw8922d_bb_reset_en(struct rtw89_dev *rtwdev, enum rtw89_band band,
+				 bool en, enum rtw89_phy_idx phy_idx)
+{
+	if (en)
+		rtw89_phy_write32_idx(rtwdev, R_RSTB_ASYNC_BE4, B_RSTB_ASYNC_BE4, 1, phy_idx);
+	else
+		rtw89_phy_write32_idx(rtwdev, R_RSTB_ASYNC_BE4, B_RSTB_ASYNC_BE4, 0, phy_idx);
+}
+
+static int rtw8922d_ctrl_tx_path_tmac(struct rtw89_dev *rtwdev,
+				      enum rtw89_rf_path tx_path,
+				      enum rtw89_phy_idx phy_idx)
+{
+	struct rtw89_reg2_def path_com_cr[] = {
+		{0x11A00, 0x21C86900},
+		{0x11A04, 0x00E4E433},
+		{0x11A08, 0x39390CC9},
+		{0x11A10, 0x10CC0000},
+		{0x11A14, 0x00240393},
+		{0x11A18, 0x201C8600},
+		{0x11B38, 0x39393FDB},
+		{0x11B3C, 0x00E4E4FF},
+	};
+	int ret = 0;
+	u32 reg;
+	int i;
+
+	rtw89_phy_write32_idx(rtwdev, R_TXINFO_PATH_BE4, B_TXINFO_PATH_EN_BE4, 0x0, phy_idx);
+	rtw89_phy_write32_idx(rtwdev, R_TXINFO_PATH_BE4, B_TXINFO_PATH_MA_BE4, 0x0, phy_idx);
+	rtw89_phy_write32_idx(rtwdev, R_TXINFO_PATH_BE4, B_TXINFO_PATH_MB_BE4, 0x0, phy_idx);
+
+	if (phy_idx == RTW89_PHY_1 && !rtwdev->dbcc_en)
+		return 0;
+
+	if (tx_path == RF_PATH_A) {
+		path_com_cr[1].data = 0x40031;
+		path_com_cr[2].data = 0x1000C48;
+		path_com_cr[5].data = 0x200;
+		path_com_cr[6].data = 0x1000C48;
+		path_com_cr[7].data = 0x40031;
+	} else if (tx_path == RF_PATH_B) {
+		path_com_cr[1].data = 0x40032;
+		path_com_cr[2].data = 0x1000C88;
+		path_com_cr[5].data = 0x400;
+		path_com_cr[6].data = 0x1000C88;
+		path_com_cr[7].data = 0x40032;
+	} else if (tx_path == RF_PATH_AB) {
+		path_com_cr[1].data = 0x00E4E433;
+		path_com_cr[2].data = 0x39390CC9;
+		path_com_cr[5].data = 0x201C8600;
+		path_com_cr[6].data = 0x1010CC9;
+		path_com_cr[7].data = 0x40433;
+	} else {
+		ret = -EINVAL;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(path_com_cr); i++) {
+		reg = rtw89_mac_reg_by_idx(rtwdev, path_com_cr[i].addr, phy_idx);
+		rtw89_write32(rtwdev, reg, path_com_cr[i].data);
+	}
+
+	return ret;
+}
+
+static void rtw8922d_bb_reset(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+{
+}
+
 static void rtw8922d_tssi_reset(struct rtw89_dev *rtwdev,
 				enum rtw89_rf_path path,
 				enum rtw89_phy_idx phy_idx)
@@ -1714,6 +1803,235 @@ static void rtw8922d_tssi_reset(struct rtw89_dev *rtwdev,
 	}
 }
 
+static int rtw8922d_ctrl_rx_path_tmac(struct rtw89_dev *rtwdev,
+				      enum rtw89_rf_path rx_path,
+				      enum rtw89_phy_idx phy_idx)
+{
+	enum rtw89_rf_path_bit path;
+
+	if (rx_path == RF_PATH_A)
+		path = RF_A;
+	else if (rx_path == RF_PATH_B)
+		path = RF_B;
+	else
+		path = RF_AB;
+
+	rtw89_phy_write32_idx(rtwdev, R_ANT_RX_BE4, B_ANT_RX_BE4, path, phy_idx);
+	rtw89_phy_write32_idx(rtwdev, R_ANT_RX_1RCCA_BE4, B_ANT_RX_1RCCA_BE4,
+			      path, phy_idx);
+
+	if (rx_path == RF_PATH_AB) {
+		rtw89_phy_write32_idx(rtwdev, R_RXCH_BCC0_BE4, B_RXCH_MCS4_BE4, 8, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RXCH_BCC1_BE4, B_RXCH_MCS5_BE4, 4, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RXCH_BCC1_BE4, B_RXCH_MCS6_BE4, 3, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RXCH_BCC1_BE4, B_RXCH_MCS7_BE4, 7, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RXCH_BCC1_BE4, B_RXCH_MCS8_BE4, 2, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RXCH_BCC1_BE4, B_RXCH_MCS9_BE4, 2, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RX_AWGN00_BE4, B_RX_AWGN04_BE4, 4, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RX_AWGN00_BE4, B_RX_AWGN07_BE4, 2, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RX_AWGN01_BE4, B_RX_AWGN09_BE4, 0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RX_AWGN02_BE4, B_RX_AWGN11_BE4, 1, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RX_LDPC00_BE4, B_RX_LDPC04_BE4, 8, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RX_LDPC00_BE4, B_RX_LDPC05_BE4, 5, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RX_LDPC00_BE4, B_RX_LDPC06_BE4, 3, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RX_LDPC00_BE4, B_RX_LDPC07_BE4, 5, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RX_LDPC00_BE4, B_RX_LDPC08_BE4, 1, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RX_LDPC01_BE4, B_RX_LDPC09_BE4, 2, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RX_LDPC02_BE4, B_RX_LDPC10_BE4, 4, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RX_LDPC02_BE4, B_RX_LDPC11_BE4, 2, phy_idx);
+	} else {
+		rtw89_phy_write32_idx(rtwdev, R_RXCH_BCC0_BE4, B_RXCH_MCS4_BE4, 13, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RXCH_BCC1_BE4, B_RXCH_MCS5_BE4, 15, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RXCH_BCC1_BE4, B_RXCH_MCS6_BE4, 6, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RXCH_BCC1_BE4, B_RXCH_MCS7_BE4, 15, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RXCH_BCC1_BE4, B_RXCH_MCS8_BE4, 4, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RXCH_BCC1_BE4, B_RXCH_MCS9_BE4, 15, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RX_AWGN00_BE4, B_RX_AWGN04_BE4, 9, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RX_AWGN00_BE4, B_RX_AWGN07_BE4, 3, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RX_AWGN01_BE4, B_RX_AWGN09_BE4, 1, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RX_AWGN02_BE4, B_RX_AWGN11_BE4, 0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RX_LDPC00_BE4, B_RX_LDPC04_BE4, 9, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RX_LDPC00_BE4, B_RX_LDPC05_BE4, 8, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RX_LDPC00_BE4, B_RX_LDPC06_BE4, 6, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RX_LDPC00_BE4, B_RX_LDPC07_BE4, 16, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RX_LDPC00_BE4, B_RX_LDPC08_BE4, 4, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RX_LDPC01_BE4, B_RX_LDPC09_BE4, 9, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RX_LDPC02_BE4, B_RX_LDPC10_BE4, 9, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RX_LDPC02_BE4, B_RX_LDPC11_BE4, 7, phy_idx);
+	}
+
+	return 0;
+}
+
+static void rtw8922d_set_digital_pwr_comp(struct rtw89_dev *rtwdev,
+					  const struct rtw89_chan *chan, u8 nss,
+					  enum rtw89_rf_path path,
+					  enum rtw89_phy_idx phy_idx)
+{
+#define DIGITAL_PWR_COMP_REG_NUM 22
+	static const u32 pw_comp_cr[2] = {R_RX_PATH0_TBL0_BE4, R_RX_PATH1_TBL0_BE4};
+	const __le32 (*pwr_comp_val)[2][RTW89_TX_COMP_BAND_NR]
+				    [BB_PATH_NUM_8922D][DIGITAL_PWR_COMP_REG_NUM];
+	struct rtw89_fw_elm_info *elm_info = &rtwdev->fw.elm_info;
+	const struct rtw89_fw_element_hdr *txcomp_elm = elm_info->tx_comp;
+	const __le32 *digital_pwr_comp;
+	u32 addr, val;
+	u32 i;
+
+	if (sizeof(*pwr_comp_val) != le32_to_cpu(txcomp_elm->size)) {
+		rtw89_debug(rtwdev, RTW89_DBG_UNEXP,
+			    "incorrect power comp size %d\n",
+			    le32_to_cpu(txcomp_elm->size));
+		return;
+	}
+
+	pwr_comp_val = (const void *)txcomp_elm->u.common.contents;
+	digital_pwr_comp = (*pwr_comp_val)[nss][chan->tx_comp_band][path];
+	addr = pw_comp_cr[path];
+
+	for (i = 0; i < DIGITAL_PWR_COMP_REG_NUM; i++, addr += 4) {
+		val = le32_to_cpu(digital_pwr_comp[i]);
+		rtw89_phy_write32_idx(rtwdev, addr, MASKDWORD, val, phy_idx);
+	}
+}
+
+static void rtw8922d_digital_pwr_comp(struct rtw89_dev *rtwdev,
+				      enum rtw89_phy_idx phy_idx)
+{
+	const struct rtw89_chan *chan0 = rtw89_mgnt_chan_get(rtwdev, 0);
+	const struct rtw89_chan *chan1 = rtw89_mgnt_chan_get(rtwdev, 1);
+
+	if (rtwdev->mlo_dbcc_mode == MLO_1_PLUS_1_1RF) {
+		rtw8922d_set_digital_pwr_comp(rtwdev, chan0, 0, RF_PATH_A, RTW89_PHY_0);
+		rtw8922d_set_digital_pwr_comp(rtwdev, chan1, 0, RF_PATH_B, RTW89_PHY_1);
+	} else {
+		rtw8922d_set_digital_pwr_comp(rtwdev, chan0, 1, RF_PATH_A, phy_idx);
+		rtw8922d_set_digital_pwr_comp(rtwdev, chan0, 1, RF_PATH_B, phy_idx);
+	}
+}
+
+static int rtw8922d_ctrl_mlo(struct rtw89_dev *rtwdev, enum rtw89_mlo_dbcc_mode mode,
+			     bool pwr_comp)
+{
+	const struct rtw89_chan *chan1;
+	u32 reg0, reg1;
+	u8 cck_phy_idx;
+
+	if (mode == MLO_2_PLUS_0_1RF) {
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_SWITCH_BE4, 0xBBBB);
+		udelay(1);
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_BB_CLK_BE4, 0x3);
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_SWITCH_BE4, 0xAFFF);
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_SWITCH_BE4, 0xEBAD);
+		udelay(1);
+
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_BB_CLK_BE4, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_SWITCH_BE4, 0xEAAD);
+	} else if (mode == MLO_0_PLUS_2_1RF) {
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_SWITCH_BE4, 0xBBBB);
+		udelay(1);
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_BB_CLK_BE4, 0x3);
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_SWITCH_BE4, 0xAFFF);
+		udelay(1);
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_SWITCH_BE4, 0xEFFF);
+
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_BB_CLK_BE4, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_SWITCH_BE4, 0xEEFF);
+	} else if ((mode == MLO_1_PLUS_1_1RF) || (mode == DBCC_LEGACY)) {
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_SWITCH_BE4, 0xBBBB);
+		udelay(1);
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_BB_CLK_BE4, 0x3);
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_SWITCH_BE4, 0xAFFF);
+		udelay(1);
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_BB_CLK_BE4, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_SWITCH_BE4, 0x3AAB);
+	} else {
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_SWITCH_BE4, 0x6180);
+		udelay(1);
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_BB_CLK_BE4, 0x3);
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_SWITCH_BE4, 0x180);
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_BB_CLK_BE4, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_SWITCH_BE4, 0x0);
+	}
+
+	if (pwr_comp)
+		rtw8922d_digital_pwr_comp(rtwdev, RTW89_PHY_0);
+
+	reg0 = R_BBWRAP_ELMSR_BE4;
+	reg1 = rtw89_mac_reg_by_idx(rtwdev, reg0, 1);
+
+	if (mode == MLO_2_PLUS_0_1RF) {
+		rtw89_phy_write32_mask(rtwdev, R_SYS_DBCC_BE4,
+				       B_SYS_DBCC_24G_BAND_SEL_BE4, RTW89_PHY_0);
+		rtw89_write32_mask(rtwdev, reg0, B_BBWRAP_ELMSR_EN_BE4, 0);
+		rtw89_write32_mask(rtwdev, reg1, B_BBWRAP_ELMSR_EN_BE4, 0);
+	} else if (mode == MLO_0_PLUS_2_1RF) {
+		rtw89_phy_write32_mask(rtwdev, R_SYS_DBCC_BE4,
+				       B_SYS_DBCC_24G_BAND_SEL_BE4, RTW89_PHY_0);
+		rtw89_write32_mask(rtwdev, reg0, B_BBWRAP_ELMSR_EN_BE4, 0);
+		rtw89_write32_mask(rtwdev, reg1, B_BBWRAP_ELMSR_EN_BE4, 0);
+	} else if ((mode == MLO_1_PLUS_1_1RF) || (mode == DBCC_LEGACY)) {
+		chan1 = rtw89_mgnt_chan_get(rtwdev, 1);
+		cck_phy_idx = chan1->band_type == RTW89_BAND_2G ?
+			      RTW89_PHY_1 : RTW89_PHY_0;
+
+		rtw89_phy_write32_mask(rtwdev, R_SYS_DBCC_BE4,
+				       B_SYS_DBCC_24G_BAND_SEL_BE4, cck_phy_idx);
+		rtw89_write32_mask(rtwdev, reg0, B_BBWRAP_ELMSR_EN_BE4, 0x3);
+		rtw89_write32_mask(rtwdev, reg1, B_BBWRAP_ELMSR_EN_BE4, 0x3);
+	} else {
+		rtw89_phy_write32_mask(rtwdev, R_SYS_DBCC_BE4,
+				       B_SYS_DBCC_24G_BAND_SEL_BE4, RTW89_PHY_0);
+		rtw89_write32_mask(rtwdev, reg0, B_BBWRAP_ELMSR_EN_BE4, 0);
+		rtw89_write32_mask(rtwdev, reg1, B_BBWRAP_ELMSR_EN_BE4, 0);
+	}
+
+	udelay(1);
+
+	return 0;
+}
+
+static void rtw8922d_bb_sethw(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_phy_efuse_gain *gain = &rtwdev->efuse_gain;
+	struct rtw89_hal *hal = &rtwdev->hal;
+	enum rtw89_phy_idx phy_idx;
+	u32 reg;
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_PWR_BOOST, RTW89_PHY_0);
+	rtw89_write32_clr(rtwdev, reg, B_BE_PWR_CTRL_SEL);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_PWR_BOOST, RTW89_PHY_1);
+	rtw89_write32_clr(rtwdev, reg, B_BE_PWR_CTRL_SEL);
+
+	if (hal->cid == RTL8922D_CID7090) {
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_PWR_BOOST_BE4, RTW89_PHY_0);
+		rtw89_write32_set(rtwdev, reg, B_PWR_BOOST_BE4);
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_PWR_BOOST_BE4, RTW89_PHY_1);
+		rtw89_write32_set(rtwdev, reg, B_PWR_BOOST_BE4);
+	}
+
+	rtw89_phy_write32_mask(rtwdev, R_TX_ERROR_SEL_BE4, B_TX_ERROR_PSDU_BE4, 0);
+	rtw89_phy_write32_mask(rtwdev, R_TX_ERROR_SEL_BE4, B_TX_ERROR_NSYM_BE4, 1);
+	rtw89_phy_write32_mask(rtwdev, R_TX_ERROR_SEL_BE4, B_TX_ERROR_LSIG_BE4, 1);
+	rtw89_phy_write32_mask(rtwdev, R_TX_ERROR_SEL_BE4, B_TX_ERROR_TXINFO_BE4, 1);
+	rtw89_phy_write32_mask(rtwdev, R_TXERRCT_EN_BE4, B_TXERRCT_EN_BE4, 0);
+	rtw89_phy_write32_mask(rtwdev, R_TXERRCT1_EN_BE4, B_TXERRCT1_EN_BE4, 0);
+	rtw89_phy_write32_idx(rtwdev, R_IMR_TX_ERROR_BE4, B_IMR_TX_ERROR_BE4, 1, RTW89_PHY_0);
+	rtw89_phy_write32_idx(rtwdev, R_IMR_TX_ERROR_BE4, B_IMR_TX_ERROR_BE4, 1, RTW89_PHY_1);
+
+	rtw8922d_ctrl_mlo(rtwdev, rtwdev->mlo_dbcc_mode, false);
+
+	/* read these registers after loading BB parameters */
+	for (phy_idx = RTW89_PHY_0; phy_idx < RTW89_PHY_NUM; phy_idx++) {
+		gain->ref_gain_base[phy_idx] =
+			rtw89_phy_read32_idx(rtwdev, R_OFDM_OFST_P0_BE4,
+					     B_OFDM_OFST_P0_BE4, phy_idx);
+		gain->cck_rpl_base[phy_idx] =
+			rtw89_phy_read32_idx(rtwdev, R_CCK_RPL_OFST_BE4,
+					     B_CCK_RPL_OFST_BE4, phy_idx);
+	}
+}
+
 static void rtw8922d_set_channel_bb(struct rtw89_dev *rtwdev,
 				    const struct rtw89_chan *chan,
 				    enum rtw89_phy_idx phy_idx)
-- 
2.25.1


