Return-Path: <linux-wireless+bounces-2428-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EF283A027
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 04:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBC261C2287F
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 03:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927298465;
	Wed, 24 Jan 2024 03:37:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E48F1381
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jan 2024 03:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706067435; cv=none; b=JBOZ53ZOtHprFwITvLWGt5DfjXmLPnjQscDKpXYuggJSb0Xt6twChAuswuh+hGDiEo6a6mwSIsPVjW4XTJzFdzZuX2jIz9X9Fa5oohBuCRP32REpWJilCJZYRYTGZy/Ddkf4w5qWPNq4LJNyZIEPJruHjeoKDXBociF10uoDy/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706067435; c=relaxed/simple;
	bh=Oxc0cUtJEsuiPzsODHxmVBfKhPNQXkU48F6X3OXVHPQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ie+ppICVIYcUr6XmupRGBDfT0k75GvyAwaJ8cQzIzRoUq6UFqqItJ8b+1SKlsK/NXuv5Y8JsKd7SYzcDV+znqJCUl0bDAeon8LCrM44UMRcw/vn2HNJy17mZrz6FFD7qIXlbToOJP+s2dgHmZP1wivfW+PM5lD75j8x3Ztztgn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40O3b6cG5723697, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40O3b6cG5723697
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 11:37:06 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 24 Jan 2024 11:37:06 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 24 Jan
 2024 11:37:06 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/6] wifi: rtw89: 8922a: hook handlers of TX/RX descriptors to chip_ops
Date: Wed, 24 Jan 2024 11:36:32 +0800
Message-ID: <20240124033637.12330-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240124033637.12330-1-pkshih@realtek.com>
References: <20240124033637.12330-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)
X-KSE-ServerInfo: RTEXDAG02.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Hook implemented handlers to chip_ops, and fill packet frequency and signal
strength to RX status from RX PPDU status packet.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index f34e2a8bff07..9c7465d0715b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -1250,6 +1250,39 @@ static void rtw8922a_ctrl_nbtg_bt_tx(struct rtw89_dev *rtwdev, bool en,
 	}
 }
 
+static void rtw8922a_fill_freq_with_ppdu(struct rtw89_dev *rtwdev,
+					 struct rtw89_rx_phy_ppdu *phy_ppdu,
+					 struct ieee80211_rx_status *status)
+{
+	u8 chan_idx = phy_ppdu->chan_idx;
+	enum nl80211_band band;
+	u8 ch;
+
+	if (chan_idx == 0)
+		return;
+
+	rtw89_decode_chan_idx(rtwdev, chan_idx, &ch, &band);
+	status->freq = ieee80211_channel_to_frequency(ch, band);
+	status->band = band;
+}
+
+static void rtw8922a_query_ppdu(struct rtw89_dev *rtwdev,
+				struct rtw89_rx_phy_ppdu *phy_ppdu,
+				struct ieee80211_rx_status *status)
+{
+	u8 path;
+	u8 *rx_power = phy_ppdu->rssi;
+
+	status->signal =
+		RTW89_RSSI_RAW_TO_DBM(max(rx_power[RF_PATH_A], rx_power[RF_PATH_B]));
+	for (path = 0; path < rtwdev->chip->rf_path_num; path++) {
+		status->chains |= BIT(path);
+		status->chain_signal[path] = RTW89_RSSI_RAW_TO_DBM(rx_power[path]);
+	}
+	if (phy_ppdu->valid)
+		rtw8922a_fill_freq_with_ppdu(rtwdev, phy_ppdu, status);
+}
+
 static int rtw8922a_mac_enable_bb_rf(struct rtw89_dev *rtwdev)
 {
 	rtw89_write8_set(rtwdev, R_BE_FEN_RST_ENABLE,
@@ -1291,10 +1324,14 @@ static const struct rtw89_chip_ops rtw8922a_chip_ops = {
 	.set_txpwr_ctrl		= rtw8922a_set_txpwr_ctrl,
 	.init_txpwr_unit	= NULL,
 	.ctrl_btg_bt_rx		= rtw8922a_ctrl_btg_bt_rx,
+	.query_ppdu		= rtw8922a_query_ppdu,
 	.ctrl_nbtg_bt_tx	= rtw8922a_ctrl_nbtg_bt_tx,
 	.set_txpwr_ul_tb_offset	= NULL,
 	.pwr_on_func		= rtw8922a_pwr_on_func,
 	.pwr_off_func		= rtw8922a_pwr_off_func,
+	.query_rxdesc		= rtw89_core_query_rxdesc_v2,
+	.fill_txdesc		= rtw89_core_fill_txdesc_v2,
+	.fill_txdesc_fwcmd	= rtw89_core_fill_txdesc_fwcmd_v2,
 	.h2c_dctl_sec_cam	= rtw89_fw_h2c_dctl_sec_cam_v2,
 	.h2c_default_cmac_tbl	= rtw89_fw_h2c_default_cmac_tbl_g7,
 	.h2c_assoc_cmac_tbl	= rtw89_fw_h2c_assoc_cmac_tbl_g7,
-- 
2.25.1


