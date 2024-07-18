Return-Path: <linux-wireless+bounces-10324-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1AB93467E
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 04:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A002B21DC3
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 02:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135B618EB0;
	Thu, 18 Jul 2024 02:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="QmG9bFeP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1197124B4A
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 02:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721271148; cv=none; b=SuF4+67xdoACdsCAJ052GPgdBbl1jGBDX81AgK1Iwwu8KnAERm5Q+0URs69uKomFTprtrh6EqYA6lBFY+C/YY1Bqe5lM/WqnZjhIS5BrXdMxeDZE/l+NNAmrdvTDt/3W2+kQlcACodwzdlmhH/fUXpnaW0p19pUghNSv+d6VeZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721271148; c=relaxed/simple;
	bh=WoLE2ZIjneL1OPlveb7oGoIUXny0sFMoyUuGJp1M9b8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gitAPQUkjMahHL7SPEGDCHJmToSnvNKKb7e+c+qcvKAPWwU2fpOdd3kYiuAydZyaN9WrqedBy4WHce36hKf8jLkCPO2xfV7VykZ9rgGNB/Kov/nYr8uf9pEskG8IH14jn6Hoz52avRTBt8uBc2kkCpt+D1R7ajDcB5bXOGgF5KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=QmG9bFeP; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46I2qJ5M12860435, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1721271139; bh=WoLE2ZIjneL1OPlveb7oGoIUXny0sFMoyUuGJp1M9b8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=QmG9bFePMxojZk0KMLtRvBZV1fqeNEFv77t4uZK7nbgs3ZcrYMPI3eCCxemnuYGYg
	 uoXzB80AdaPPhjSjXBttDVyPlnoW0/d2/JW0U2zUEMWdimynRabFFejx/YaDB/5qA+
	 KR65FN1jszQzRZ3ejV5KEO/V68wgtH+NudFVZLCq5W5pXnwCNyTx6KNwQgEIACDKI0
	 tQZD+qfsxxsIPa0dFcBXGOndD2GO34UA/5btySfF+WGHaHTlwHv+Jb1UQuwZOBQaLy
	 E6ccB251NcmMrvbI1hr2sly8t4whyK4RUndFB52wr4N0Ce9Yv0B8tjiydbSwAF0Kid
	 mPLTItE8fI0dg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46I2qJ5M12860435
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 10:52:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 18 Jul 2024 10:52:20 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 18 Jul
 2024 10:52:19 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/6] wifi: rtw89: 8852bt: add set_channel_rf
Date: Thu, 18 Jul 2024 10:51:33 +0800
Message-ID: <20240718025138.18777-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240718025138.18777-1-pkshih@realtek.com>
References: <20240718025138.18777-1-pkshih@realtek.com>
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

Add RF part of set_channel() is to configure RF registers, and then
hardware can TX/RX on specified frequency and bandwidth.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 .../wireless/realtek/rtw89/rtw8852bt_rfk.c    | 226 ++++++++++++++++++
 .../wireless/realtek/rtw89/rtw8852bt_rfk.h    |   3 +
 2 files changed, 229 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
index 5bdabb45e968..0f2a74269b98 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
@@ -4017,3 +4017,229 @@ void rtw8852bt_wifi_scan_notify(struct rtw89_dev *rtwdev, bool scan_start,
 	else
 		rtw8852bt_tssi_default_txagc(rtwdev, phy_idx, false);
 }
+
+static void _bw_setting(struct rtw89_dev *rtwdev, enum rtw89_rf_path path,
+			enum rtw89_bandwidth bw, bool dav)
+{
+	u32 rf_reg18;
+	u32 reg18_addr = dav ? RR_CFGCH : RR_CFGCH_V1;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[RFK]===> %s\n", __func__);
+
+	rf_reg18 = rtw89_read_rf(rtwdev, path, reg18_addr, RFREG_MASK);
+	if (rf_reg18 == INV_RF_DATA) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[RFK]Invalid RF_0x18 for Path-%d\n", path);
+		return;
+	}
+	rf_reg18 &= ~RR_CFGCH_BW;
+
+	switch (bw) {
+	case RTW89_CHANNEL_WIDTH_5:
+	case RTW89_CHANNEL_WIDTH_10:
+	case RTW89_CHANNEL_WIDTH_20:
+		rf_reg18 |= FIELD_PREP(RR_CFGCH_BW, CFGCH_BW_20M);
+		break;
+	case RTW89_CHANNEL_WIDTH_40:
+		rf_reg18 |= FIELD_PREP(RR_CFGCH_BW, CFGCH_BW_40M);
+		break;
+	case RTW89_CHANNEL_WIDTH_80:
+		rf_reg18 |= FIELD_PREP(RR_CFGCH_BW, CFGCH_BW_80M);
+		break;
+	default:
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[RFK]Fail to set CH\n");
+	}
+
+	rf_reg18 &= ~(RR_CFGCH_POW_LCK | RR_CFGCH_TRX_AH | RR_CFGCH_BCN |
+		      RR_CFGCH_BW2) & RFREG_MASK;
+	rf_reg18 |= RR_CFGCH_BW2;
+	rtw89_write_rf(rtwdev, path, reg18_addr, RFREG_MASK, rf_reg18);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[RFK] set %x at path%d, %x =0x%x\n",
+		    bw, path, reg18_addr,
+		    rtw89_read_rf(rtwdev, path, reg18_addr, RFREG_MASK));
+}
+
+static void _ctrl_bw(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+		     enum rtw89_bandwidth bw)
+{
+	_bw_setting(rtwdev, RF_PATH_A, bw, true);
+	_bw_setting(rtwdev, RF_PATH_B, bw, true);
+	_bw_setting(rtwdev, RF_PATH_A, bw, false);
+	_bw_setting(rtwdev, RF_PATH_B, bw, false);
+}
+
+static bool _set_s0_arfc18(struct rtw89_dev *rtwdev, u32 val)
+{
+	u32 tmp;
+	int ret;
+
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LCK_TRG, RR_LCK_TRGSEL, 0x1);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_CFGCH, RFREG_MASK, val);
+
+	ret = read_poll_timeout_atomic(rtw89_read_rf, tmp, tmp == 0, 1, 1000,
+				       false, rtwdev, RF_PATH_A, RR_LPF, RR_LPF_BUSY);
+	if (ret)
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[LCK]LCK timeout\n");
+
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LCK_TRG, RR_LCK_TRGSEL, 0x0);
+	return !!ret;
+}
+
+static void _lck_check(struct rtw89_dev *rtwdev)
+{
+	u32 tmp;
+
+	if (rtw89_read_rf(rtwdev, RF_PATH_A, RR_SYNFB, RR_SYNFB_LK) == 0) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[LCK]SYN MMD reset\n");
+
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_MMD, RR_MMD_RST_EN, 0x1);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_MMD, RR_MMD_RST_SYN, 0x0);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_MMD, RR_MMD_RST_SYN, 0x1);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_MMD, RR_MMD_RST_EN, 0x0);
+	}
+
+	udelay(10);
+
+	if (rtw89_read_rf(rtwdev, RF_PATH_A, RR_SYNFB, RR_SYNFB_LK) == 0) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[LCK]re-set RF 0x18\n");
+
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_LCK_TRG, RR_LCK_TRGSEL, 0x1);
+		tmp = rtw89_read_rf(rtwdev, RF_PATH_A, RR_CFGCH, RFREG_MASK);
+		_set_s0_arfc18(rtwdev, tmp);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_LCK_TRG, RR_LCK_TRGSEL, 0x0);
+	}
+
+	if (rtw89_read_rf(rtwdev, RF_PATH_A, RR_SYNFB, RR_SYNFB_LK) == 0) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[LCK]SYN off/on\n");
+
+		tmp = rtw89_read_rf(rtwdev, RF_PATH_A, RR_POW, RFREG_MASK);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_POW, RFREG_MASK, tmp);
+		tmp = rtw89_read_rf(rtwdev, RF_PATH_A, RR_SX, RFREG_MASK);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_SX, RFREG_MASK, tmp);
+
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_SYNLUT, RR_SYNLUT_MOD, 0x1);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_POW, RR_POW_SYN, 0x0);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_POW, RR_POW_SYN, 0x3);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_SYNLUT, RR_SYNLUT_MOD, 0x0);
+
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_LCK_TRG, RR_LCK_TRGSEL, 0x1);
+		tmp = rtw89_read_rf(rtwdev, RF_PATH_A, RR_CFGCH, RFREG_MASK);
+		_set_s0_arfc18(rtwdev, tmp);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_LCK_TRG, RR_LCK_TRGSEL, 0x0);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[LCK]0xb2=%x, 0xc5=%x\n",
+			    rtw89_read_rf(rtwdev, RF_PATH_A, RR_VCO, RFREG_MASK),
+			    rtw89_read_rf(rtwdev, RF_PATH_A, RR_SYNFB, RFREG_MASK));
+	}
+}
+
+static void _set_ch(struct rtw89_dev *rtwdev, u32 val)
+{
+	bool timeout;
+	u32 bak;
+
+	bak = rtw89_read_rf(rtwdev, RF_PATH_A, RR_LDO, RFREG_MASK);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LDO, RR_LDO_SEL, 0x1);
+	timeout = _set_s0_arfc18(rtwdev, val);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LDO, RFREG_MASK, bak);
+	if (!timeout)
+		_lck_check(rtwdev);
+}
+
+static void _ch_setting(struct rtw89_dev *rtwdev, enum rtw89_rf_path path,
+			u8 central_ch, bool dav)
+{
+	u32 reg18_addr = dav ? RR_CFGCH : RR_CFGCH_V1;
+	bool is_2g_ch = central_ch <= 14;
+	u32 rf_reg18;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[RFK]===> %s\n", __func__);
+
+	rf_reg18 = rtw89_read_rf(rtwdev, path, reg18_addr, RFREG_MASK);
+	rf_reg18 &= ~(RR_CFGCH_BAND1 | RR_CFGCH_POW_LCK | RR_CFGCH_TRX_AH |
+		      RR_CFGCH_BCN | RR_CFGCH_BAND0 | RR_CFGCH_CH);
+	rf_reg18 |= FIELD_PREP(RR_CFGCH_CH, central_ch);
+
+	if (!is_2g_ch)
+		rf_reg18 |= FIELD_PREP(RR_CFGCH_BAND1, CFGCH_BAND1_5G) |
+			    FIELD_PREP(RR_CFGCH_BAND0, CFGCH_BAND0_5G);
+
+	rf_reg18 &= ~(RR_CFGCH_POW_LCK | RR_CFGCH_TRX_AH | RR_CFGCH_BCN |
+		      RR_CFGCH_BW2) & RFREG_MASK;
+	rf_reg18 |= RR_CFGCH_BW2;
+
+	if (path == RF_PATH_A && dav)
+		_set_ch(rtwdev, rf_reg18);
+	else
+		rtw89_write_rf(rtwdev, path, reg18_addr, RFREG_MASK, rf_reg18);
+
+	rtw89_write_rf(rtwdev, path, RR_LCKST, RR_LCKST_BIN, 0);
+	rtw89_write_rf(rtwdev, path, RR_LCKST, RR_LCKST_BIN, 1);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[RFK]CH: %d for Path-%d, reg0x%x = 0x%x\n",
+		    central_ch, path, reg18_addr,
+		    rtw89_read_rf(rtwdev, path, reg18_addr, RFREG_MASK));
+}
+
+static void _ctrl_ch(struct rtw89_dev *rtwdev, u8 central_ch)
+{
+	_ch_setting(rtwdev, RF_PATH_A, central_ch, true);
+	_ch_setting(rtwdev, RF_PATH_B, central_ch, true);
+	_ch_setting(rtwdev, RF_PATH_A, central_ch, false);
+	_ch_setting(rtwdev, RF_PATH_B, central_ch, false);
+}
+
+static void _set_rxbb_bw(struct rtw89_dev *rtwdev, enum rtw89_bandwidth bw,
+			 enum rtw89_rf_path path)
+{
+	rtw89_write_rf(rtwdev, path, RR_LUTWE2, RR_LUTWE2_RTXBW, 0x1);
+	rtw89_write_rf(rtwdev, path, RR_LUTWA, RR_LUTWA_M2, 0x12);
+
+	if (bw == RTW89_CHANNEL_WIDTH_20)
+		rtw89_write_rf(rtwdev, path, RR_LUTWD0, RR_LUTWD0_LB, 0x1b);
+	else if (bw == RTW89_CHANNEL_WIDTH_40)
+		rtw89_write_rf(rtwdev, path, RR_LUTWD0, RR_LUTWD0_LB, 0x13);
+	else if (bw == RTW89_CHANNEL_WIDTH_80)
+		rtw89_write_rf(rtwdev, path, RR_LUTWD0, RR_LUTWD0_LB, 0xb);
+	else
+		rtw89_write_rf(rtwdev, path, RR_LUTWD0, RR_LUTWD0_LB, 0x3);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[RFK] set S%d RXBB BW 0x3F = 0x%x\n",
+		    path, rtw89_read_rf(rtwdev, path, RR_LUTWD0, RR_LUTWD0_LB));
+
+	rtw89_write_rf(rtwdev, path, RR_LUTWE2, RR_LUTWE2_RTXBW, 0x0);
+}
+
+static void _rxbb_bw(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+		     enum rtw89_bandwidth bw)
+{
+	u8 kpath, path;
+
+	kpath = _kpath(rtwdev, phy);
+
+	for (path = 0; path < RF_PATH_NUM_8852BT; path++) {
+		if (!(kpath & BIT(path)))
+			continue;
+
+		_set_rxbb_bw(rtwdev, bw, path);
+	}
+}
+
+static void rtw8852bt_ctrl_bw_ch(struct rtw89_dev *rtwdev,
+				 enum rtw89_phy_idx phy, u8 central_ch,
+				 enum rtw89_band band, enum rtw89_bandwidth bw)
+{
+	_ctrl_ch(rtwdev, central_ch);
+	_ctrl_bw(rtwdev, phy, bw);
+	_rxbb_bw(rtwdev, phy, bw);
+}
+
+void rtw8852bt_set_channel_rf(struct rtw89_dev *rtwdev,
+			      const struct rtw89_chan *chan,
+			      enum rtw89_phy_idx phy_idx)
+{
+	rtw8852bt_ctrl_bw_ch(rtwdev, phy_idx, chan->channel, chan->band_type,
+			     chan->band_width);
+}
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h
index 09918835c6e8..ef3d98f80400 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h
@@ -18,5 +18,8 @@ void rtw8852bt_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, bool hwtx_
 void rtw8852bt_tssi_scan(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy);
 void rtw8852bt_wifi_scan_notify(struct rtw89_dev *rtwdev, bool scan_start,
 				enum rtw89_phy_idx phy_idx);
+void rtw8852bt_set_channel_rf(struct rtw89_dev *rtwdev,
+			      const struct rtw89_chan *chan,
+			      enum rtw89_phy_idx phy_idx);
 
 #endif
-- 
2.25.1


