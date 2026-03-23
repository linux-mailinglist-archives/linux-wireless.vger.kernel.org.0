Return-Path: <linux-wireless+bounces-33678-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFDHFgCzwGm5KAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33678-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 04:26:56 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6EB2EC330
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 04:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2E6AA3002B47
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 03:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEE21514F8;
	Mon, 23 Mar 2026 03:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="YYbVe8SD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6D415539A
	for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2026 03:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774236410; cv=none; b=ZQr7+PYs6R7O3DLnoYKaLZZSk8Y/iyvp/NCMhsxv9tTn4WOf0ujgDnEYNNLNsw0Q3CjgldOvUBn6AkkLwjcpmtLC5jEW/uEbJ7evZlpIAHKfpwqNIoYMUUHOSzq0VQCRdUSnK5kGVIozvF7H/wwx+/eiQgHWh4r43UwRNvjCfJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774236410; c=relaxed/simple;
	bh=qLxdnamL8AAIsnaVnohLjKTje+yqINBPigFo8yXsBcE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q+2UtAwbFyNo8Eaa3Tnj/BHxOjFl+haxxTIwCr41cReiwV04zvkuOa7Pl+a+CUI93fvT/1Xr4mPVQHSu+NYGzzLWO2LxF1B0n1vGutHKaZRqth2YwHkC60qmxE5GjZoJ5XnWbKzXP9ZPd7nx4KUeSAr1nxsC9hOz/eRdsBB/8HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=YYbVe8SD; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62N3QkTaA2375887, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774236406; bh=s3OkLc3+c9PnH5wo6EgHua7OvFFNmqlQI7A9xaHt6hc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=YYbVe8SDXhgLJHSvHOD82IbttNb3OMwbD1SDTWJACo55qKkpQw4p2ZC26AhB9wM39
	 OGWIXbJlInajfEFJ/SI/Aa3hnsgsdyKTQK2L3px1tp6f0rs+zKIZwvDvSvprLA/p0J
	 aFqZy3bR0cU5HnFmVD3dx9eAK7Z8BoL6G5HqRyT5zen1TgG2j/RD0LjA0yvK8m9DKg
	 k8nVPGfr9XrpNf4UrpXy+nOjRvWoGlQg0YuqHnIuN8uC1cu3TXhCdxF25if0Xfh5Ya
	 3nKWBdf6yoiy9E7vN8YKpPZN93HVW7t61ZeHGFRNB433dWeEwlntqbEngzgeH1N1dv
	 LCJ8bkR0eH17Q==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62N3QkTaA2375887
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2026 11:26:46 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 23 Mar 2026 11:26:46 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 23 Mar 2026 11:26:46 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 23 Mar 2026 11:26:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 6/7] wifi: rtw89: 8922d: add set channel of BB part
Date: Mon, 23 Mar 2026 11:25:55 +0800
Message-ID: <20260323032556.19825-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260323032556.19825-1-pkshih@realtek.com>
References: <20260323032556.19825-1-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33678-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:email,realtek.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4F6EB2EC330
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The set channel of BB part is the main part, which according to channel
and bandwidth to configure CCK SCO, RX gain of LNA and TIA programmed
in efuse for CCK and OFDM rate, and spur elimination of CSI and NBI tones.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |   2 +
 drivers/net/wireless/realtek/rtw89/reg.h      |  64 +-
 drivers/net/wireless/realtek/rtw89/rtw8922d.c | 820 ++++++++++++++++++
 3 files changed, 885 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index cde46ed21d32..696a1d92d62b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5933,6 +5933,8 @@ struct rtw89_phy_efuse_gain {
 	s8 offset2[RF_PATH_MAX][RTW89_GAIN_OFFSET_NR]; /* S(8, 0) */
 	s8 offset_base[RTW89_PHY_NUM]; /* S(8, 4) */
 	s8 rssi_base[RTW89_PHY_NUM]; /* S(8, 4) */
+	s8 ref_gain_base[RTW89_PHY_NUM]; /* S(8, 2) */
+	s8 cck_rpl_base[RTW89_PHY_NUM]; /* S(8, 0) */
 	s8 comp[RF_PATH_MAX][RTW89_SUBBAND_NR]; /* S(8, 0) */
 };
 
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 2195f576facc..5d284f310069 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -8775,6 +8775,7 @@
 #define B_P0_HW_ANTSW_DIS_BY_GNT_BT BIT(12)
 #define B_P0_TRSW_TX_EXTEND GENMASK(3, 0)
 #define R_MAC_PIN_SEL 0x0734
+#define R_MAC_PIN_SEL_BE4 0x20734
 #define B_CH_IDX_SEG0 GENMASK(23, 16)
 #define R_PLCP_HISTOGRAM 0x0738
 #define R_PLCP_HISTOGRAM_BE_V1 0x20738
@@ -10461,6 +10462,13 @@
 #define B_SW_SI_DATA_DAT_BE4 GENMASK(19, 0)
 #define R_SW_SI_READ_ADDR_BE4 0x20378
 #define B_SW_SI_READ_ADDR_BE4 GENMASK(10, 0)
+#define R_RXBW67_BE4 0x2040C
+#define B_RXBW6_BE4 GENMASK(22, 20)
+#define B_RXBW7_BE4 GENMASK(25, 23)
+#define R_RXBW_BE4 0x20410
+#define B_RXBW_BE4 GENMASK(29, 27)
+#define R_ENABLE_CCK0_BE4 0x20700
+#define B_ENABLE_CCK0_BE4 BIT(5)
 #define R_EDCCA_RPT_SEL_BE4 0x20780
 #define R_EDCCA_RPT_SEL_BE4_C1 0x21780
 #define B_EDCCA_RPT_SEL_BE4_MSK 0xE0000
@@ -10486,21 +10494,75 @@
 #define B_IFS_T3_HIS_BE4 GENMASK(15, 0)
 #define B_IFS_T4_HIS_BE4 GENMASK(31, 16)
 
+#define R_TXPWR_RSTB0_BE4 0x2250C
+#define B_TXPWR_RSTB0_BE4 BIT(16)
+#define R_TXPWR_RSTB1_BE4 0x2260C
+#define B_TXPWR_RSTB1_BE4 BIT(16)
+
+#define R_OFDM_OFST_P0_BE4 0x240C8
+#define B_OFDM_OFST_P0_BE4 GENMASK(31, 24)
 #define R_PATH0_RXIDX_INIT_BE4 0x24108
 #define B_PATH0_RXIDX_INIT_BE4 GENMASK(29, 25)
 #define R_PATH0_LNA_INIT_BE4 0x24158
 #define B_PATH0_LNA_INIT_IDX_BE4 GENMASK(14, 12)
+#define R_BAND_SEL0_BE4 0x24160
+#define B_BAND_SEL0_BE4 BIT(26)
 #define R_PATH0_TIA_INIT_BE4 0x24168
 #define B_PATH0_TIA_INIT_IDX_BE4 BIT(18)
+#define R_OFDM_RPL_BIAS_P0_BE4 0x2420C
+#define B_OFDM_RPL_BIAS_P0_BE4 GENMASK(11, 2)
+#define R_OFDM_OFST_P1_BE4 0x244C8
+#define B_OFDM_OFST_P1_BE4 GENMASK(31, 24)
 #define R_PATH1_RXIDX_INIT_BE4 0x24508
 #define B_PATH1_RXIDX_INIT_BE4 GENMASK(29, 25)
 #define R_PATH1_LNA_INIT_BE4 0x24558
 #define B_PATH1_LNA_INIT_IDX_BE4 GENMASK(14, 12)
+#define R_BAND_SEL1_BE4 0x24560
+#define B_BAND_SEL1_BE4 BIT(26)
 #define R_PATH1_TIA_INIT_BE4 0x24568
 #define B_PATH1_TIA_INIT_IDX_BE4 BIT(18)
+#define R_OFDM_RPL_BIAS_P1_BE4 0x2460C
+#define B_OFDM_RPL_BIAS_P1_BE4 GENMASK(11, 2)
 #define R_TX_CFR_MANUAL_EN_BE4 0x2483C
 #define B_TX_CFR_MANUAL_EN_BE4_M BIT(30)
-
+#define R_PCOEFF0_BE4 0x24880
+#define B_PCOEFF01_BE4 GENMASK(23, 0)
+#define R_PCOEFF2_BE4 0x24884
+#define B_PCOEFF23_BE4 GENMASK(23, 0)
+#define R_PCOEFF4_BE4 0x24888
+#define B_PCOEFF45_BE4 GENMASK(23, 0)
+#define R_PCOEFF6_BE4 0x2488C
+#define B_PCOEFF67_BE4 GENMASK(23, 0)
+#define R_PCOEFF8_BE4 0x24890
+#define B_PCOEFF89_BE4 GENMASK(23, 0)
+#define R_PCOEFF10_BE4 0x24894
+#define B_PCOEFF10_BE4 GENMASK(23, 0)
+#define R_PCOEFF12_BE4 0x24898
+#define B_PCOEFF12_BE4 GENMASK(23, 0)
+#define R_PCOEFF14_BE4 0x2489C
+#define B_PCOEFF14_BE4 GENMASK(23, 0)
+#define R_BW_BE4 0x24EE4
+#define B_BW_BE4 GENMASK(6, 4)
+#define B_PRISB_BE4 GENMASK(3, 0)
+#define R_FC0_BE4 0x24EE8
+#define B_FC0_BE4 GENMASK(12, 0)
+#define R_FC0_INV_BE4 0x24EF4
+#define B_FC0_INV_BE4 GENMASK(15, 0)
+
+#define R_CCK_RPL_OFST_BE4 0x26084
+#define B_CCK_RPL_OFST_BE4 GENMASK(7, 0)
+#define R_BK_FC0_INV_BE4 0x2608C
+#define B_BK_FC0_INV_BE4 GENMASK(18, 0)
+#define R_CCK_FC0_INV_BE4 0x26090
+#define B_CCK_FC0_INV_BE4 GENMASK(18, 0)
+#define R_GAIN_BIAS_BE4 0x260A0
+#define B_GAIN_BIAS_BW20_BE4 GENMASK(11, 6)
+#define B_GAIN_BIAS_BW40_BE4 GENMASK(17, 12)
+#define R_AWGN_DET_BE4 0x2668C
+#define B_AWGN_DET_BE4 GENMASK(17, 9)
+#define R_CSI_WGT_BE4 0x26770
+#define B_CSI_WGT_EN_BE4 BIT(0)
+#define B_CSI_WGT_IDX_BE4 GENMASK(31, 20)
 #define R_CHINFO_OPT_BE4 0x267C8
 #define B_CHINFO_OPT_BE4 GENMASK(14, 13)
 #define R_CHINFO_NX_BE4 0x267D0
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.c b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
index a341734ef54d..f6b36b90dec8 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
@@ -8,6 +8,7 @@
 #include "phy.h"
 #include "reg.h"
 #include "rtw8922d.h"
+#include "util.h"
 
 #define RTW8922D_FW_FORMAT_MAX 0
 #define RTW8922D_FW_BASENAME "rtw89/rtw8922d_fw"
@@ -927,6 +928,825 @@ static void rtw8922d_set_channel_mac(struct rtw89_dev *rtwdev,
 	rtw89_write32_mask(rtwdev, reg, B_BE_SIFS_MACTXEN_TB_T1_DOT05US_MASK, sifs);
 }
 
+static const u32 rtw8922d_sco_barker_threshold[14] = {
+	0x1fe4f, 0x1ff5e, 0x2006c, 0x2017b, 0x2028a, 0x20399, 0x204a8, 0x205b6,
+	0x206c5, 0x207d4, 0x208e3, 0x209f2, 0x20b00, 0x20d8a
+};
+
+static const u32 rtw8922d_sco_cck_threshold[14] = {
+	0x2bdac, 0x2bf21, 0x2c095, 0x2c209, 0x2c37e, 0x2c4f2, 0x2c666, 0x2c7db,
+	0x2c94f, 0x2cac3, 0x2cc38, 0x2cdac, 0x2cf21, 0x2d29e
+};
+
+static int rtw8922d_ctrl_sco_cck(struct rtw89_dev *rtwdev,
+				 u8 primary_ch, enum rtw89_bandwidth bw,
+				 enum rtw89_phy_idx phy_idx)
+{
+	u8 ch_element;
+
+	if (primary_ch >= 14)
+		return -EINVAL;
+
+	ch_element = primary_ch - 1;
+
+	rtw89_phy_write32_idx(rtwdev, R_BK_FC0_INV_BE4, B_BK_FC0_INV_BE4,
+			      rtw8922d_sco_barker_threshold[ch_element],
+			      phy_idx);
+	rtw89_phy_write32_idx(rtwdev, R_CCK_FC0_INV_BE4, B_CCK_FC0_INV_BE4,
+			      rtw8922d_sco_cck_threshold[ch_element],
+			      phy_idx);
+
+	return 0;
+}
+
+static void rtw8922d_ctrl_ch_core(struct rtw89_dev *rtwdev,
+				  const struct rtw89_chan *chan,
+				  enum rtw89_phy_idx phy_idx)
+{
+	u16 central_freq = chan->freq;
+	u16 sco;
+
+	if (chan->band_type == RTW89_BAND_2G) {
+		rtw89_phy_write32_idx(rtwdev, R_BAND_SEL0_BE4, B_BAND_SEL0_BE4,
+				      1, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BAND_SEL1_BE4, B_BAND_SEL1_BE4,
+				      1, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_ENABLE_CCK0_BE4, B_ENABLE_CCK0_BE4,
+				      1, phy_idx);
+	} else {
+		rtw89_phy_write32_idx(rtwdev, R_BAND_SEL0_BE4, B_BAND_SEL0_BE4,
+				      0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BAND_SEL1_BE4, B_BAND_SEL1_BE4,
+				      0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_ENABLE_CCK0_BE4, B_ENABLE_CCK0_BE4,
+				      0, phy_idx);
+	}
+
+	rtw89_phy_write32_idx(rtwdev, R_FC0_BE4, B_FC0_BE4, central_freq, phy_idx);
+
+	sco = phy_div((BIT(0) << 27) + (central_freq / 2), central_freq);
+	rtw89_phy_write32_idx(rtwdev, R_FC0_INV_BE4, B_FC0_INV_BE4, sco, phy_idx);
+}
+
+struct rtw8922d_bb_gain {
+	u32 gain_g[BB_PATH_NUM_8922D];
+	u32 gain_a[BB_PATH_NUM_8922D];
+	u32 gain_g_mask;
+	u32 gain_a_mask;
+};
+
+static const struct rtw89_reg_def rpl_comp_bw160[RTW89_BW20_SC_160M] = {
+	{ .addr = 0x241E8, .mask = 0xFF00},
+	{ .addr = 0x241E8, .mask = 0xFF0000},
+	{ .addr = 0x241E8, .mask = 0xFF000000},
+	{ .addr = 0x241EC, .mask = 0xFF},
+	{ .addr = 0x241EC, .mask = 0xFF00},
+	{ .addr = 0x241EC, .mask = 0xFF0000},
+	{ .addr = 0x241EC, .mask = 0xFF000000},
+	{ .addr = 0x241F0, .mask = 0xFF}
+};
+
+static const struct rtw89_reg_def rpl_comp_bw80[RTW89_BW20_SC_80M] = {
+	{ .addr = 0x241F4, .mask = 0xFF},
+	{ .addr = 0x241F4, .mask = 0xFF00},
+	{ .addr = 0x241F4, .mask = 0xFF0000},
+	{ .addr = 0x241F4, .mask = 0xFF000000}
+};
+
+static const struct rtw89_reg_def rpl_comp_bw40[RTW89_BW20_SC_40M] = {
+	{ .addr = 0x241F0, .mask = 0xFF0000},
+	{ .addr = 0x241F0, .mask = 0xFF000000}
+};
+
+static const struct rtw89_reg_def rpl_comp_bw20[RTW89_BW20_SC_20M] = {
+	{ .addr = 0x241F0, .mask = 0xFF00}
+};
+
+static const struct rtw8922d_bb_gain bb_gain_lna[LNA_GAIN_NUM] = {
+	{ .gain_g = {0x2409C, 0x2449C}, .gain_a = {0x2406C, 0x2446C},
+	  .gain_g_mask = 0xFF00, .gain_a_mask = 0xFF},
+	{ .gain_g = {0x2409C, 0x2449C}, .gain_a = {0x2406C, 0x2446C},
+	  .gain_g_mask = 0xFF000000, .gain_a_mask = 0xFF0000},
+	{ .gain_g = {0x240A0, 0x244A0}, .gain_a = {0x24070, 0x24470},
+	  .gain_g_mask = 0xFF00, .gain_a_mask = 0xFF},
+	{ .gain_g = {0x240A0, 0x244A0}, .gain_a = {0x24070, 0x24470},
+	  .gain_g_mask = 0xFF000000, .gain_a_mask = 0xFF0000},
+	{ .gain_g = {0x240A4, 0x244A4}, .gain_a = {0x24074, 0x24474},
+	  .gain_g_mask = 0xFF00, .gain_a_mask = 0xFF},
+	{ .gain_g = {0x240A4, 0x244A4}, .gain_a = {0x24074, 0x24474},
+	  .gain_g_mask = 0xFF000000, .gain_a_mask = 0xFF0000},
+	{ .gain_g = {0x240A8, 0x244A8}, .gain_a = {0x24078, 0x24478},
+	  .gain_g_mask = 0xFF00, .gain_a_mask = 0xFF},
+};
+
+static const struct rtw8922d_bb_gain bb_gain_tia[TIA_GAIN_NUM] = {
+	{ .gain_g = {0x24054, 0x24454}, .gain_a = {0x24054, 0x24454},
+	  .gain_g_mask = 0x7FC0000, .gain_a_mask = 0x1FF},
+	{ .gain_g = {0x24058, 0x24458}, .gain_a = {0x24054, 0x24454},
+	  .gain_g_mask = 0x1FF, .gain_a_mask = 0x3FE00 },
+};
+
+static const struct rtw8922d_bb_gain bb_op1db_lna[LNA_GAIN_NUM] = {
+	{ .gain_g = {0x240AC, 0x244AC}, .gain_a = {0x24078, 0x24478},
+	  .gain_g_mask = 0xFF00, .gain_a_mask = 0xFF000000},
+	{ .gain_g = {0x240AC, 0x244AC}, .gain_a = {0x2407C, 0x2447C},
+	  .gain_g_mask = 0xFF0000, .gain_a_mask = 0xFF},
+	{ .gain_g = {0x240AC, 0x244AC}, .gain_a = {0x2407C, 0x2447C},
+	  .gain_g_mask = 0xFF000000, .gain_a_mask = 0xFF00},
+	{ .gain_g = {0x240B0, 0x244B0}, .gain_a = {0x2407C, 0x2447C},
+	  .gain_g_mask = 0xFF, .gain_a_mask = 0xFF0000},
+	{ .gain_g = {0x240B0, 0x244B0}, .gain_a = {0x2407C, 0x2447C},
+	  .gain_g_mask = 0xFF00, .gain_a_mask = 0xFF000000},
+	{ .gain_g = {0x240B0, 0x244B0}, .gain_a = {0x24080, 0x24480},
+	  .gain_g_mask = 0xFF0000, .gain_a_mask = 0xFF},
+	{ .gain_g = {0x240B0, 0x244B0}, .gain_a = {0x24080, 0x24480},
+	  .gain_g_mask = 0xFF000000, .gain_a_mask = 0xFF00},
+};
+
+static const struct rtw8922d_bb_gain bb_op1db_tia_lna[TIA_LNA_OP1DB_NUM] = {
+	{ .gain_g = {0x240B4, 0x244B4}, .gain_a = {0x24080, 0x24480},
+	  .gain_g_mask = 0xFF0000, .gain_a_mask = 0xFF000000},
+	{ .gain_g = {0x240B4, 0x244B4}, .gain_a = {0x24084, 0x24484},
+	  .gain_g_mask = 0xFF000000, .gain_a_mask = 0xFF},
+	{ .gain_g = {0x240B8, 0x244B8}, .gain_a = {0x24084, 0x24484},
+	  .gain_g_mask = 0xFF, .gain_a_mask = 0xFF00},
+	{ .gain_g = {0x240B8, 0x244B8}, .gain_a = {0x24084, 0x24484},
+	  .gain_g_mask = 0xFF00, .gain_a_mask = 0xFF0000},
+	{ .gain_g = {0x240B8, 0x244B8}, .gain_a = {0x24084, 0x24484},
+	  .gain_g_mask = 0xFF0000, .gain_a_mask = 0xFF000000},
+	{ .gain_g = {0x240B8, 0x244B8}, .gain_a = {0x24088, 0x24488},
+	  .gain_g_mask = 0xFF000000, .gain_a_mask = 0xFF},
+	{ .gain_g = {0x240BC, 0x244BC}, .gain_a = {0x24088, 0x24488},
+	  .gain_g_mask = 0xFF, .gain_a_mask = 0xFF00},
+	{ .gain_g = {0x240BC, 0x244BC}, .gain_a = {0x24088, 0x24488},
+	  .gain_g_mask = 0xFF00, .gain_a_mask = 0xFF0000},
+};
+
+static void rtw8922d_set_rpl_gain(struct rtw89_dev *rtwdev,
+				  const struct rtw89_chan *chan,
+				  enum rtw89_rf_path path,
+				  enum rtw89_phy_idx phy_idx)
+{
+	const struct rtw89_phy_bb_gain_info_be *gain = &rtwdev->bb_gain.be;
+	u8 gain_band = rtw89_subband_to_gain_band_be(chan->subband_type);
+	u32 reg_path_ofst = 0;
+	u32 mask;
+	s32 val;
+	u32 reg;
+	int i;
+
+	if (path == RF_PATH_B)
+		reg_path_ofst = 0x400;
+
+	for (i = 0; i < RTW89_BW20_SC_160M; i++) {
+		reg = rpl_comp_bw160[i].addr | reg_path_ofst;
+		mask = rpl_comp_bw160[i].mask;
+		val = gain->rpl_ofst_160[gain_band][path][i];
+		rtw89_phy_write32_idx(rtwdev, reg, mask, val, phy_idx);
+	}
+
+	for (i = 0; i < RTW89_BW20_SC_80M; i++) {
+		reg = rpl_comp_bw80[i].addr | reg_path_ofst;
+		mask = rpl_comp_bw80[i].mask;
+		val = gain->rpl_ofst_80[gain_band][path][i];
+		rtw89_phy_write32_idx(rtwdev, reg, mask, val, phy_idx);
+	}
+
+	for (i = 0; i < RTW89_BW20_SC_40M; i++) {
+		reg = rpl_comp_bw40[i].addr | reg_path_ofst;
+		mask = rpl_comp_bw40[i].mask;
+		val = gain->rpl_ofst_40[gain_band][path][i];
+		rtw89_phy_write32_idx(rtwdev, reg, mask, val, phy_idx);
+	}
+
+	for (i = 0; i < RTW89_BW20_SC_20M; i++) {
+		reg = rpl_comp_bw20[i].addr | reg_path_ofst;
+		mask = rpl_comp_bw20[i].mask;
+		val = gain->rpl_ofst_20[gain_band][path][i];
+		rtw89_phy_write32_idx(rtwdev, reg, mask, val, phy_idx);
+	}
+}
+
+static void rtw8922d_set_lna_tia_gain(struct rtw89_dev *rtwdev,
+				      const struct rtw89_chan *chan,
+				      enum rtw89_rf_path path,
+				      enum rtw89_phy_idx phy_idx)
+{
+	const struct rtw89_phy_bb_gain_info_be *gain = &rtwdev->bb_gain.be;
+	u8 gain_band = rtw89_subband_to_gain_band_be(chan->subband_type);
+	enum rtw89_phy_bb_bw_be bw_type;
+	u32 mask;
+	s32 val;
+	u32 reg;
+	int i;
+
+	bw_type = chan->band_width <= RTW89_CHANNEL_WIDTH_40 ?
+		  RTW89_BB_BW_20_40 : RTW89_BB_BW_80_160_320;
+
+	for (i = 0; i < LNA_GAIN_NUM; i++) {
+		if (chan->band_type == RTW89_BAND_2G) {
+			reg = bb_gain_lna[i].gain_g[path];
+			mask = bb_gain_lna[i].gain_g_mask;
+		} else {
+			reg = bb_gain_lna[i].gain_a[path];
+			mask = bb_gain_lna[i].gain_a_mask;
+		}
+		val = gain->lna_gain[gain_band][bw_type][path][i];
+		rtw89_phy_write32_idx(rtwdev, reg, mask, val, phy_idx);
+	}
+
+	for (i = 0; i < TIA_GAIN_NUM; i++) {
+		if (chan->band_type == RTW89_BAND_2G) {
+			reg = bb_gain_tia[i].gain_g[path];
+			mask = bb_gain_tia[i].gain_g_mask;
+		} else {
+			reg = bb_gain_tia[i].gain_a[path];
+			mask = bb_gain_tia[i].gain_a_mask;
+		}
+		val = gain->tia_gain[gain_band][bw_type][path][i];
+		rtw89_phy_write32_idx(rtwdev, reg, mask, val, phy_idx);
+	}
+}
+
+static void rtw8922d_set_op1db(struct rtw89_dev *rtwdev,
+			       const struct rtw89_chan *chan,
+			       enum rtw89_rf_path path,
+			       enum rtw89_phy_idx phy_idx)
+{
+	const struct rtw89_phy_bb_gain_info_be *gain = &rtwdev->bb_gain.be;
+	u8 gain_band = rtw89_subband_to_gain_band_be(chan->subband_type);
+	enum rtw89_phy_bb_bw_be bw_type;
+	u32 mask;
+	s32 val;
+	u32 reg;
+	int i;
+
+	bw_type = chan->band_width <= RTW89_CHANNEL_WIDTH_40 ?
+		  RTW89_BB_BW_20_40 : RTW89_BB_BW_80_160_320;
+
+	for (i = 0; i < LNA_GAIN_NUM; i++) {
+		if (chan->band_type == RTW89_BAND_2G) {
+			reg = bb_op1db_lna[i].gain_g[path];
+			mask = bb_op1db_lna[i].gain_g_mask;
+		} else {
+			reg = bb_op1db_lna[i].gain_a[path];
+			mask = bb_op1db_lna[i].gain_a_mask;
+		}
+		val = gain->lna_op1db[gain_band][bw_type][path][i];
+		rtw89_phy_write32_idx(rtwdev, reg, mask, val, phy_idx);
+	}
+
+	for (i = 0; i < TIA_LNA_OP1DB_NUM; i++) {
+		if (chan->band_type == RTW89_BAND_2G) {
+			reg = bb_op1db_tia_lna[i].gain_g[path];
+			mask = bb_op1db_tia_lna[i].gain_g_mask;
+		} else {
+			reg = bb_op1db_tia_lna[i].gain_a[path];
+			mask = bb_op1db_tia_lna[i].gain_a_mask;
+		}
+		val = gain->tia_lna_op1db[gain_band][bw_type][path][i];
+		rtw89_phy_write32_idx(rtwdev, reg, mask, val, phy_idx);
+	}
+}
+
+static void rtw8922d_set_gain(struct rtw89_dev *rtwdev,
+			      const struct rtw89_chan *chan,
+			      enum rtw89_rf_path path,
+			      enum rtw89_phy_idx phy_idx)
+{
+	rtw8922d_set_rpl_gain(rtwdev, chan, path, phy_idx);
+	rtw8922d_set_lna_tia_gain(rtwdev, chan, path, phy_idx);
+	rtw8922d_set_op1db(rtwdev, chan, path, phy_idx);
+}
+
+static s8 rtw8922d_get_rx_gain_by_chan(struct rtw89_dev *rtwdev,
+				       const struct rtw89_chan *chan,
+				       enum rtw89_rf_path path, bool is_cck)
+{
+	struct rtw89_phy_efuse_gain *gain = &rtwdev->efuse_gain;
+	enum rtw89_gain_offset band;
+	u8 fc_ch = chan->channel;
+	s8 normal_efuse = 0;
+
+	if (path > RF_PATH_B)
+		return 0;
+
+	if (is_cck) {
+		if (fc_ch >= 1 && fc_ch <= 7)
+			return gain->offset[path][RTW89_GAIN_OFFSET_2G_CCK];
+		else if (fc_ch >= 8 && fc_ch <= 14)
+			return gain->offset2[path][RTW89_GAIN_OFFSET_2G_CCK];
+
+		return 0;
+	}
+
+	band = rtw89_subband_to_gain_offset_band_of_ofdm(chan->subband_type);
+
+	if (band == RTW89_GAIN_OFFSET_2G_OFDM) {
+		if (fc_ch >= 1 && fc_ch <= 7)
+			normal_efuse = gain->offset[path][band];
+		else if (fc_ch >= 8 && fc_ch <= 14)
+			normal_efuse = gain->offset2[path][band];
+	} else if (band == RTW89_GAIN_OFFSET_5G_LOW) {
+		if (fc_ch == 50)
+			normal_efuse = (gain->offset[path][band] + gain->offset2[path][band]) >> 1;
+		else if (fc_ch >= 36 && fc_ch <= 48)
+			normal_efuse = gain->offset[path][band];
+		else if (fc_ch >= 52 && fc_ch <= 64)
+			normal_efuse = gain->offset2[path][band];
+
+	} else if (band == RTW89_GAIN_OFFSET_5G_MID) {
+		if (fc_ch == 122)
+			normal_efuse = (gain->offset[path][band] + gain->offset2[path][band]) >> 1;
+		else if (fc_ch >= 100 && fc_ch <= 120)
+			normal_efuse = gain->offset[path][band];
+		else if (fc_ch >= 124 && fc_ch <= 144)
+			normal_efuse = gain->offset2[path][band];
+	} else if (band == RTW89_GAIN_OFFSET_5G_HIGH) {
+		if (fc_ch == 163)
+			normal_efuse = (gain->offset[path][band] + gain->offset2[path][band]) >> 1;
+		else if (fc_ch >= 149 && fc_ch <= 161)
+			normal_efuse = gain->offset[path][band];
+		else if (fc_ch >= 165 && fc_ch <= 177)
+			normal_efuse = gain->offset2[path][band];
+	} else if (band == RTW89_GAIN_OFFSET_6G_L0) {
+		if (fc_ch == 15)
+			normal_efuse = (gain->offset[path][band] + gain->offset2[path][band]) >> 1;
+		else if (fc_ch >= 1 && fc_ch <= 13)
+			normal_efuse = gain->offset[path][band];
+		else if (fc_ch >= 17 && fc_ch <= 29)
+			normal_efuse = gain->offset2[path][band];
+	} else if (band == RTW89_GAIN_OFFSET_6G_L1) {
+		if (fc_ch == 47)
+			normal_efuse = (gain->offset[path][band] + gain->offset2[path][band]) >> 1;
+		else if (fc_ch >= 33 && fc_ch <= 45)
+			normal_efuse = gain->offset[path][band];
+		else if (fc_ch >= 49 && fc_ch <= 61)
+			normal_efuse = gain->offset2[path][band];
+	} else if (band == RTW89_GAIN_OFFSET_6G_M0) {
+		if (fc_ch == 79)
+			normal_efuse = (gain->offset[path][band] + gain->offset2[path][band]) >> 1;
+		else if (fc_ch >= 65 && fc_ch <= 77)
+			normal_efuse = gain->offset[path][band];
+		else if (fc_ch >= 81 && fc_ch <= 93)
+			normal_efuse = gain->offset2[path][band];
+	} else if (band == RTW89_GAIN_OFFSET_6G_M1) {
+		if (fc_ch == 111)
+			normal_efuse = (gain->offset[path][band] + gain->offset2[path][band]) >> 1;
+		else if (fc_ch >= 97 && fc_ch <= 109)
+			normal_efuse = gain->offset[path][band];
+		else if (fc_ch >= 113 && fc_ch <= 125)
+			normal_efuse = gain->offset2[path][band];
+	} else if (band == RTW89_GAIN_OFFSET_6G_H0) {
+		if (fc_ch == 143)
+			normal_efuse = (gain->offset[path][band] + gain->offset2[path][band]) >> 1;
+		else if (fc_ch >= 129 && fc_ch <= 141)
+			normal_efuse = gain->offset[path][band];
+		else if (fc_ch >= 145 && fc_ch <= 157)
+			normal_efuse = gain->offset2[path][band];
+	} else if (band == RTW89_GAIN_OFFSET_6G_H1) {
+		if (fc_ch == 175)
+			normal_efuse = (gain->offset[path][band] + gain->offset2[path][band]) >> 1;
+		else if (fc_ch >= 161 && fc_ch <= 173)
+			normal_efuse = gain->offset[path][band];
+		else if (fc_ch >= 177 && fc_ch <= 189)
+			normal_efuse = gain->offset2[path][band];
+	} else if (band == RTW89_GAIN_OFFSET_6G_UH0) {
+		if (fc_ch == 207)
+			normal_efuse = (gain->offset[path][band] + gain->offset2[path][band]) >> 1;
+		else if (fc_ch >= 193 && fc_ch <= 205)
+			normal_efuse = gain->offset[path][band];
+		else if (fc_ch >= 209 && fc_ch <= 221)
+			normal_efuse = gain->offset2[path][band];
+	} else if (band == RTW89_GAIN_OFFSET_6G_UH1) {
+		if (fc_ch == 239)
+			normal_efuse = (gain->offset[path][band] + gain->offset2[path][band]) >> 1;
+		else if (fc_ch >= 225 && fc_ch <= 237)
+			normal_efuse = gain->offset[path][band];
+		else if (fc_ch >= 241 && fc_ch <= 253)
+			normal_efuse = gain->offset2[path][band];
+	} else {
+		normal_efuse = gain->offset[path][band];
+	}
+
+	return normal_efuse;
+}
+
+static void rtw8922d_calc_rx_gain_normal_cck(struct rtw89_dev *rtwdev,
+					     const struct rtw89_chan *chan,
+					     enum rtw89_rf_path path,
+					     enum rtw89_phy_idx phy_idx,
+					     struct rtw89_phy_calc_efuse_gain *calc)
+{
+	struct rtw89_phy_efuse_gain *gain = &rtwdev->efuse_gain;
+	s8 rx_gain_offset;
+
+	rx_gain_offset = -rtw8922d_get_rx_gain_by_chan(rtwdev, chan, path, true);
+
+	if (chan->band_width == RTW89_CHANNEL_WIDTH_40)
+		rx_gain_offset += (3 << 2); /* compensate RPL loss of 3dB */
+
+	calc->cck_mean_gain_bias = (rx_gain_offset & 0x3) << 1;
+	calc->cck_rpl_ofst = (rx_gain_offset >> 2) + gain->cck_rpl_base[phy_idx];
+}
+
+static void rtw8922d_set_rx_gain_normal_cck(struct rtw89_dev *rtwdev,
+					    const struct rtw89_chan *chan,
+					    enum rtw89_rf_path path,
+					    enum rtw89_phy_idx phy_idx)
+{
+	struct rtw89_phy_calc_efuse_gain calc = {};
+
+	rtw8922d_calc_rx_gain_normal_cck(rtwdev, chan, path, phy_idx, &calc);
+
+	rtw89_phy_write32_idx(rtwdev, R_GAIN_BIAS_BE4, B_GAIN_BIAS_BW20_BE4,
+			      calc.cck_mean_gain_bias, phy_idx);
+	rtw89_phy_write32_idx(rtwdev, R_GAIN_BIAS_BE4, B_GAIN_BIAS_BW40_BE4,
+			      calc.cck_mean_gain_bias, phy_idx);
+	rtw89_phy_write32_idx(rtwdev, R_CCK_RPL_OFST_BE4, B_CCK_RPL_OFST_BE4,
+			      calc.cck_rpl_ofst, phy_idx);
+}
+
+static void rtw8922d_calc_rx_gain_normal_ofdm(struct rtw89_dev *rtwdev,
+					      const struct rtw89_chan *chan,
+					      enum rtw89_rf_path path,
+					      enum rtw89_phy_idx phy_idx,
+					      struct rtw89_phy_calc_efuse_gain *calc)
+{
+	struct rtw89_phy_efuse_gain *gain = &rtwdev->efuse_gain;
+	s8 rx_gain_offset;
+
+	rx_gain_offset = rtw8922d_get_rx_gain_by_chan(rtwdev, chan, path, false);
+	calc->rssi_ofst = (rx_gain_offset + gain->ref_gain_base[phy_idx]) & 0xff;
+}
+
+static void rtw8922d_set_rx_gain_normal_ofdm(struct rtw89_dev *rtwdev,
+					     const struct rtw89_chan *chan,
+					     enum rtw89_rf_path path,
+					     enum rtw89_phy_idx phy_idx)
+{
+	static const u32 rssi_ofst_addr[2] = {R_OFDM_OFST_P0_BE4, R_OFDM_OFST_P1_BE4};
+	static const u32 rssi_ofst_addr_m[2] = {B_OFDM_OFST_P0_BE4, B_OFDM_OFST_P1_BE4};
+	static const u32 rpl_bias_comp[2] = {R_OFDM_RPL_BIAS_P0_BE4, R_OFDM_RPL_BIAS_P1_BE4};
+	static const u32 rpl_bias_comp_m[2] = {B_OFDM_RPL_BIAS_P0_BE4, B_OFDM_RPL_BIAS_P1_BE4};
+	struct rtw89_phy_calc_efuse_gain calc = {};
+
+	rtw8922d_calc_rx_gain_normal_ofdm(rtwdev, chan, path, phy_idx, &calc);
+
+	rtw89_phy_write32_idx(rtwdev, rssi_ofst_addr[path], rssi_ofst_addr_m[path],
+			      calc.rssi_ofst, phy_idx);
+	rtw89_phy_write32_idx(rtwdev, rpl_bias_comp[path], rpl_bias_comp_m[path], 0, phy_idx);
+}
+
+static void rtw8922d_set_rx_gain_normal(struct rtw89_dev *rtwdev,
+					const struct rtw89_chan *chan,
+					enum rtw89_rf_path path,
+					enum rtw89_phy_idx phy_idx)
+{
+	struct rtw89_phy_efuse_gain *gain = &rtwdev->efuse_gain;
+
+	if (!gain->offset_valid)
+		return;
+
+	if (chan->band_type == RTW89_BAND_2G)
+		rtw8922d_set_rx_gain_normal_cck(rtwdev, chan, path, phy_idx);
+
+	rtw8922d_set_rx_gain_normal_ofdm(rtwdev, chan, path, phy_idx);
+}
+
+static void rtw8922d_set_cck_parameters(struct rtw89_dev *rtwdev,
+					const struct rtw89_chan *chan,
+					enum rtw89_phy_idx phy_idx)
+{
+	u8 regd = rtw89_regd_get(rtwdev, chan->band_type);
+	u8 central_ch = chan->channel;
+
+	if (central_ch == 14) {
+		rtw89_phy_write32_idx(rtwdev, R_PCOEFF0_BE4, B_PCOEFF01_BE4, 0x3b13ff, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_PCOEFF2_BE4, B_PCOEFF23_BE4, 0x1c42de, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_PCOEFF4_BE4, B_PCOEFF45_BE4, 0xfdb0ad, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_PCOEFF6_BE4, B_PCOEFF67_BE4, 0xf60f6e, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_PCOEFF8_BE4, B_PCOEFF89_BE4, 0xfd8f92, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_PCOEFF10_BE4, B_PCOEFF10_BE4, 0x2d011, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_PCOEFF12_BE4, B_PCOEFF12_BE4, 0x1c02c, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_PCOEFF14_BE4, B_PCOEFF14_BE4, 0xfff00a, phy_idx);
+
+		return;
+	}
+
+	if (regd == RTW89_FCC) {
+		rtw89_phy_write32_idx(rtwdev, R_PCOEFF0_BE4, B_PCOEFF01_BE4, 0x39A3BC, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_PCOEFF2_BE4, B_PCOEFF23_BE4, 0x2AA339, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_PCOEFF4_BE4, B_PCOEFF45_BE4, 0x15B202, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_PCOEFF6_BE4, B_PCOEFF67_BE4, 0x0550C7, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_PCOEFF8_BE4, B_PCOEFF89_BE4, 0xfe0009, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_PCOEFF10_BE4, B_PCOEFF10_BE4, 0xfd7fd3, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_PCOEFF12_BE4, B_PCOEFF12_BE4, 0xfeffe2, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_PCOEFF14_BE4, B_PCOEFF14_BE4, 0xffeff8, phy_idx);
+	} else {
+		rtw89_phy_write32_idx(rtwdev, R_PCOEFF0_BE4, B_PCOEFF01_BE4, 0x3d23ff, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_PCOEFF2_BE4, B_PCOEFF23_BE4, 0x29b354, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_PCOEFF4_BE4, B_PCOEFF45_BE4, 0xfc1c8, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_PCOEFF6_BE4, B_PCOEFF67_BE4, 0xfdb053, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_PCOEFF8_BE4, B_PCOEFF89_BE4, 0xf86f9a, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_PCOEFF10_BE4, B_PCOEFF10_BE4, 0xfaef92, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_PCOEFF12_BE4, B_PCOEFF12_BE4, 0xfe5fcc, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_PCOEFF14_BE4, B_PCOEFF14_BE4, 0xffdff5, phy_idx);
+	}
+}
+
+static void rtw8922d_ctrl_ch(struct rtw89_dev *rtwdev,
+			     const struct rtw89_chan *chan,
+			     enum rtw89_phy_idx phy_idx)
+{
+	u16 central_freq = chan->freq;
+	u8 band = chan->band_type;
+	u8 chan_idx;
+
+	if (!central_freq) {
+		rtw89_warn(rtwdev, "Invalid central_freq\n");
+		return;
+	}
+
+	rtw8922d_ctrl_ch_core(rtwdev, chan, phy_idx);
+
+	chan_idx = rtw89_encode_chan_idx(rtwdev, chan->primary_channel, band);
+	rtw89_phy_write32_idx(rtwdev, R_MAC_PIN_SEL_BE4, B_CH_IDX_SEG0, chan_idx, phy_idx);
+
+	rtw8922d_set_gain(rtwdev, chan, RF_PATH_A, phy_idx);
+	rtw8922d_set_gain(rtwdev, chan, RF_PATH_B, phy_idx);
+
+	rtw8922d_set_rx_gain_normal(rtwdev, chan, RF_PATH_A, phy_idx);
+	rtw8922d_set_rx_gain_normal(rtwdev, chan, RF_PATH_B, phy_idx);
+
+	if (band == RTW89_BAND_2G)
+		rtw8922d_set_cck_parameters(rtwdev, chan, phy_idx);
+}
+
+static void rtw8922d_ctrl_bw(struct rtw89_dev *rtwdev, u8 pri_sb, u8 bw,
+			     enum rtw89_phy_idx phy_idx)
+{
+	switch (bw) {
+	default:
+	case RTW89_CHANNEL_WIDTH_20:
+		rtw89_phy_write32_idx(rtwdev, R_BW_BE4, B_BW_BE4, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BW_BE4, B_PRISB_BE4, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RXBW_BE4, B_RXBW_BE4, 0x2, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RXBW67_BE4, B_RXBW6_BE4, 0x2, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RXBW67_BE4, B_RXBW7_BE4, 0x2, phy_idx);
+		break;
+	case RTW89_CHANNEL_WIDTH_40:
+		rtw89_phy_write32_idx(rtwdev, R_BW_BE4, B_BW_BE4, 0x1, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BW_BE4, B_PRISB_BE4, pri_sb, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RXBW_BE4, B_RXBW_BE4, 0x3, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RXBW67_BE4, B_RXBW6_BE4, 0x3, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RXBW67_BE4, B_RXBW7_BE4, 0x3, phy_idx);
+		break;
+	case RTW89_CHANNEL_WIDTH_80:
+		rtw89_phy_write32_idx(rtwdev, R_BW_BE4, B_BW_BE4, 0x2, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BW_BE4, B_PRISB_BE4, pri_sb, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RXBW_BE4, B_RXBW_BE4, 0x4, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RXBW67_BE4, B_RXBW6_BE4, 0x4, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RXBW67_BE4, B_RXBW7_BE4, 0x4, phy_idx);
+		break;
+	case RTW89_CHANNEL_WIDTH_160:
+		rtw89_phy_write32_idx(rtwdev, R_BW_BE4, B_BW_BE4, 0x3, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_BW_BE4, B_PRISB_BE4, pri_sb, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RXBW_BE4, B_RXBW_BE4, 0x5, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RXBW67_BE4, B_RXBW6_BE4, 0x5, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RXBW67_BE4, B_RXBW7_BE4, 0x5, phy_idx);
+		break;
+	}
+}
+
+static const u16 spur_nbi_a[] = {6400};
+static const u16 spur_csi[] = {6400};
+
+static u32 rtw8922d_spur_freq(struct rtw89_dev *rtwdev, const struct rtw89_chan *chan,
+			      bool nbi_or_csi, enum rtw89_rf_path path)
+{
+	static const u16 cbw[RTW89_CHANNEL_WIDTH_ORDINARY_NUM] = {
+		20, 40, 80, 160, 320,
+	};
+	u16 freq_lower, freq_upper, freq;
+	const u16 *spur_freq;
+	int spur_freq_nr, i;
+
+	if (rtwdev->hal.aid != RTL8922D_AID7060)
+		return 0;
+
+	if (nbi_or_csi && path == RF_PATH_A) {
+		spur_freq = spur_nbi_a;
+		spur_freq_nr = ARRAY_SIZE(spur_nbi_a);
+	} else if (!nbi_or_csi) {
+		spur_freq = spur_csi;
+		spur_freq_nr = ARRAY_SIZE(spur_csi);
+	} else {
+		return 0;
+	}
+
+	if (chan->band_width >= RTW89_CHANNEL_WIDTH_ORDINARY_NUM)
+		return 0;
+
+	freq_lower = chan->freq - cbw[chan->band_width] / 2;
+	freq_upper = chan->freq + cbw[chan->band_width] / 2;
+
+	for (i = 0; i < spur_freq_nr; i++) {
+		freq = spur_freq[i];
+
+		if (freq >= freq_lower && freq <= freq_upper)
+			return freq;
+	}
+
+	return 0;
+}
+
+#define CARRIER_SPACING_312_5 312500 /* 312.5 kHz */
+#define CARRIER_SPACING_78_125 78125 /* 78.125 kHz */
+#define MAX_TONE_NUM 2048
+
+static void rtw8922d_set_csi_tone_idx(struct rtw89_dev *rtwdev,
+				      const struct rtw89_chan *chan,
+				      enum rtw89_phy_idx phy_idx)
+{
+	s32 freq_diff, csi_idx, csi_tone_idx;
+	u32 spur_freq;
+
+	spur_freq = rtw8922d_spur_freq(rtwdev, chan, false, RF_PATH_AB);
+	if (spur_freq == 0) {
+		rtw89_phy_write32_idx(rtwdev, R_CSI_WGT_BE4, B_CSI_WGT_EN_BE4,
+				      0, phy_idx);
+		return;
+	}
+
+	freq_diff = (spur_freq - chan->freq) * 1000000;
+	csi_idx = s32_div_u32_round_closest(freq_diff, CARRIER_SPACING_78_125);
+	s32_div_u32_round_down(csi_idx, MAX_TONE_NUM, &csi_tone_idx);
+
+	rtw89_phy_write32_idx(rtwdev, R_CSI_WGT_BE4, B_CSI_WGT_IDX_BE4,
+			      csi_tone_idx, phy_idx);
+	rtw89_phy_write32_idx(rtwdev, R_CSI_WGT_BE4, B_CSI_WGT_EN_BE4, 1, phy_idx);
+}
+
+static const struct rtw89_nbi_reg_def rtw8922d_nbi_reg_def[] = {
+	[RF_PATH_A] = {
+		.notch1_idx = {0x241A0, 0xFF},
+		.notch1_frac_idx = {0x241A0, 0xC00},
+		.notch1_en = {0x241A0, 0x1000},
+		.notch2_idx = {0x241AC, 0xFF},
+		.notch2_frac_idx = {0x241AC, 0xC00},
+		.notch2_en = {0x241AC, 0x1000},
+	},
+	[RF_PATH_B] = {
+		.notch1_idx = {0x245A0, 0xFF},
+		.notch1_frac_idx = {0x241A0, 0xC00},
+		.notch1_en = {0x245A0, 0x1000},
+		.notch2_idx = {0x245AC, 0xFF},
+		.notch2_frac_idx = {0x245AC, 0xC00},
+		.notch2_en = {0x245AC, 0x1000},
+	},
+};
+
+static void rtw8922d_set_nbi_tone_idx(struct rtw89_dev *rtwdev,
+				      const struct rtw89_chan *chan,
+				      enum rtw89_rf_path path,
+				      enum rtw89_phy_idx phy_idx)
+{
+	const struct rtw89_nbi_reg_def *nbi = &rtw8922d_nbi_reg_def[path];
+	s32 nbi_frac_idx, nbi_frac_tone_idx;
+	s32 nbi_idx, nbi_tone_idx;
+	bool notch2_chk = false;
+	u32 spur_freq, fc;
+	s32 freq_diff;
+
+	spur_freq = rtw8922d_spur_freq(rtwdev, chan, true, path);
+	if (spur_freq == 0) {
+		rtw89_phy_write32_idx(rtwdev, nbi->notch1_en.addr,
+				      nbi->notch1_en.mask, 0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, nbi->notch2_en.addr,
+				      nbi->notch2_en.mask, 0, phy_idx);
+		return;
+	}
+
+	fc = chan->freq;
+	if (chan->band_width == RTW89_CHANNEL_WIDTH_160) {
+		fc = (spur_freq > fc) ? fc + 40 : fc - 40;
+		if ((fc > spur_freq &&
+		     chan->channel < chan->primary_channel) ||
+		    (fc < spur_freq &&
+		     chan->channel > chan->primary_channel))
+			notch2_chk = true;
+	}
+
+	freq_diff = (spur_freq - fc) * 1000000;
+	nbi_idx = s32_div_u32_round_down(freq_diff, CARRIER_SPACING_312_5,
+					 &nbi_frac_idx);
+
+	if (chan->band_width == RTW89_CHANNEL_WIDTH_20) {
+		s32_div_u32_round_down(nbi_idx + 32, 64, &nbi_tone_idx);
+	} else {
+		u16 tone_para = (chan->band_width == RTW89_CHANNEL_WIDTH_40) ?
+				128 : 256;
+
+		s32_div_u32_round_down(nbi_idx, tone_para, &nbi_tone_idx);
+	}
+	nbi_frac_tone_idx =
+		s32_div_u32_round_closest(nbi_frac_idx, CARRIER_SPACING_78_125);
+
+	if (chan->band_width == RTW89_CHANNEL_WIDTH_160 && notch2_chk) {
+		rtw89_phy_write32_idx(rtwdev, nbi->notch2_idx.addr,
+				      nbi->notch2_idx.mask, nbi_tone_idx, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, nbi->notch2_frac_idx.addr,
+				      nbi->notch2_frac_idx.mask, nbi_frac_tone_idx,
+				      phy_idx);
+		rtw89_phy_write32_idx(rtwdev, nbi->notch2_en.addr,
+				      nbi->notch2_en.mask, 0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, nbi->notch2_en.addr,
+				      nbi->notch2_en.mask, 1, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, nbi->notch1_en.addr,
+				      nbi->notch1_en.mask, 0, phy_idx);
+	} else {
+		rtw89_phy_write32_idx(rtwdev, nbi->notch1_idx.addr,
+				      nbi->notch1_idx.mask, nbi_tone_idx, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, nbi->notch1_frac_idx.addr,
+				      nbi->notch1_frac_idx.mask, nbi_frac_tone_idx,
+				      phy_idx);
+		rtw89_phy_write32_idx(rtwdev, nbi->notch1_en.addr,
+				      nbi->notch1_en.mask, 0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, nbi->notch1_en.addr,
+				      nbi->notch1_en.mask, 1, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, nbi->notch2_en.addr,
+				      nbi->notch2_en.mask, 0, phy_idx);
+	}
+}
+
+static void rtw8922d_spur_elimination(struct rtw89_dev *rtwdev,
+				      const struct rtw89_chan *chan,
+				      enum rtw89_phy_idx phy_idx)
+{
+	rtw8922d_set_csi_tone_idx(rtwdev, chan, phy_idx);
+	rtw8922d_set_nbi_tone_idx(rtwdev, chan, RF_PATH_A, phy_idx);
+	rtw8922d_set_nbi_tone_idx(rtwdev, chan, RF_PATH_B, phy_idx);
+}
+
+static void rtw8922d_tssi_reset(struct rtw89_dev *rtwdev,
+				enum rtw89_rf_path path,
+				enum rtw89_phy_idx phy_idx)
+{
+	if (rtwdev->mlo_dbcc_mode == MLO_1_PLUS_1_1RF) {
+		if (phy_idx == RTW89_PHY_0) {
+			rtw89_phy_write32_mask(rtwdev, R_TXPWR_RSTB0_BE4,
+					       B_TXPWR_RSTB0_BE4, 0x0);
+			rtw89_phy_write32_mask(rtwdev, R_TXPWR_RSTB0_BE4,
+					       B_TXPWR_RSTB0_BE4, 0x1);
+		} else {
+			rtw89_phy_write32_mask(rtwdev, R_TXPWR_RSTB1_BE4,
+					       B_TXPWR_RSTB1_BE4, 0x0);
+			rtw89_phy_write32_mask(rtwdev, R_TXPWR_RSTB1_BE4,
+					       B_TXPWR_RSTB1_BE4, 0x1);
+		}
+	} else {
+		rtw89_phy_write32_mask(rtwdev, R_TXPWR_RSTB0_BE4, B_TXPWR_RSTB0_BE4, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_TXPWR_RSTB0_BE4, B_TXPWR_RSTB0_BE4, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_TXPWR_RSTB1_BE4, B_TXPWR_RSTB1_BE4, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_TXPWR_RSTB1_BE4, B_TXPWR_RSTB1_BE4, 0x1);
+	}
+}
+
+static void rtw8922d_set_channel_bb(struct rtw89_dev *rtwdev,
+				    const struct rtw89_chan *chan,
+				    enum rtw89_phy_idx phy_idx)
+{
+	struct rtw89_hal *hal = &rtwdev->hal;
+	bool cck_en = chan->band_type == RTW89_BAND_2G;
+	u8 pri_sb = chan->pri_sb_idx;
+	u32 val;
+
+	rtw89_phy_bb_wrap_set_rfsi_ct_opt(rtwdev, phy_idx);
+	rtw8922d_ctrl_ch(rtwdev, chan, phy_idx);
+	rtw8922d_ctrl_bw(rtwdev, pri_sb, chan->band_width, phy_idx);
+	rtw89_phy_bb_wrap_set_rfsi_bandedge_ch(rtwdev, chan, phy_idx);
+
+	if (cck_en)
+		rtw8922d_ctrl_sco_cck(rtwdev, chan->primary_channel,
+				      chan->band_width, phy_idx);
+
+	rtw8922d_spur_elimination(rtwdev, chan, phy_idx);
+
+	if (hal->cid == RTL8922D_CID7025) {
+		if (chan->band_width == RTW89_CHANNEL_WIDTH_160)
+			val = 0x1f9;
+		else if (chan->band_width == RTW89_CHANNEL_WIDTH_80)
+			val = 0x1f5;
+		else
+			val = 0x1e2;
+
+		rtw89_phy_write32_idx(rtwdev, R_AWGN_DET_BE4, B_AWGN_DET_BE4, val, phy_idx);
+	}
+
+	rtw8922d_tssi_reset(rtwdev, RF_PATH_AB, phy_idx);
+}
+
 MODULE_FIRMWARE(RTW8922D_MODULE_FIRMWARE);
 MODULE_FIRMWARE(RTW8922DS_MODULE_FIRMWARE);
 MODULE_AUTHOR("Realtek Corporation");
-- 
2.25.1


