Return-Path: <linux-wireless+bounces-30926-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB89D38C52
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Jan 2026 05:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A3C6A303FCCE
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Jan 2026 04:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CAD326922;
	Sat, 17 Jan 2026 04:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ti2sEfar"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D56B3254A7
	for <linux-wireless@vger.kernel.org>; Sat, 17 Jan 2026 04:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768624953; cv=none; b=oBEZMLJJ1fX3HcJdM2Eu5TgxnfepHD+0RsCNiRnsi1mGGl70Z9m9KPEWJ76NrzNZFDFGCXXcbXdt83IfkhP14b9Eje4s3JDW+QBm7/Umsl2nc7t1fhwtUdTs9lwNLV0SQskKRrVNk8pPAAiQebBUrCeMzISdpoxnsjiEqEqGVVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768624953; c=relaxed/simple;
	bh=d7kR6kDPRd284cHlevQMbo1+XFmgkbTLleFjJG2yGpI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HO3iHZWy2IMp/GmTl7S8aK63Lxe4tCp4zEPNS5rQZ03KS6kx0S87bPFszqLmfLNOziM5inSUukiLYbTI03Jn4sGy1NpgQWiYF/LhrzuRLY5hGPPh4sl12PPHfFmj24sKUDz2SBOvlDMhIdGXehocNtlCXrwHveIXzJ80W1pyyQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ti2sEfar; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60H4gTnE52464491, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768624949; bh=lDxUFRqPhqVlftdM5r8dcNJXUVMvH9p5K8df9aJAza8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=ti2sEfarUKkWMLaO73qzmdmuuSMUXy7QDuCmrLIuHDw5IUKR1QVfOEuZUi3bZ/FFG
	 T3f75fIhfdacIBsjgJSuU7W8joAeeonJHTtT1MAA1y5BRTKorNMwHWBmnbicc1NU0c
	 M3tvpJcFCzaCM3Ij+UqMlTY+Dh3druABqLgyTQ25bSLIGmBYsHK6WqlbqI9+rwnTY1
	 JBJ7XRqkX2wF4jmOURB5YImlJioZjbQ4sCBi3nJ1M3Zj8/fmo4SybAB0Qz6FK42toQ
	 IfeYJzQuOhi3vPnZhhfzyvqMJy3CBhsmd1w8vYuK89HBMcvGVPfm8Hxn0HqGmiztID
	 fPgzXYh3pajQQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60H4gTnE52464491
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sat, 17 Jan 2026 12:42:29 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Sat, 17 Jan 2026 12:42:30 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Sat, 17 Jan 2026 12:42:29 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Sat, 17 Jan 2026 12:42:29 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <echuang@realtek.com>, <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 6/9] wifi: rtw89: phy: update TSSI flow for RTL8922D
Date: Sat, 17 Jan 2026 12:41:54 +0800
Message-ID: <20260117044157.2392958-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260117044157.2392958-1-pkshih@realtek.com>
References: <20260117044157.2392958-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Zong-Zhe Yang <kevin_yang@realtek.com>

TSSI is to do TX compensation caused by temperature. The RTL8922D defines
different H2C command format. Update it accordingly.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c  |  7 +++-
 drivers/net/wireless/realtek/rtw89/phy.c | 46 +++++++++++++++++-------
 2 files changed, 40 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 46161e06a1d9..a0de6a17166c 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -7291,6 +7291,7 @@ int rtw89_fw_h2c_rf_pre_ntfy_mcc(struct rtw89_dev *rtwdev, enum rtw89_phy_idx ph
 int rtw89_fw_h2c_rf_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
 			 const struct rtw89_chan *chan, enum rtw89_tssi_mode tssi_mode)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_efuse *efuse = &rtwdev->efuse;
 	struct rtw89_hal *hal = &rtwdev->hal;
 	struct rtw89_h2c_rf_tssi *h2c;
@@ -7311,11 +7312,15 @@ int rtw89_fw_h2c_rf_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
 	h2c->ch = chan->channel;
 	h2c->bw = chan->band_width;
 	h2c->band = chan->band_type;
-	h2c->hwtx_en = true;
 	h2c->cv = hal->cv;
 	h2c->tssi_mode = tssi_mode;
 	h2c->rfe_type = efuse->rfe_type;
 
+	if (chip->chip_id == RTL8922A)
+		h2c->hwtx_en = true;
+	else
+		h2c->hwtx_en = false;
+
 	rtw89_phy_rfk_tssi_fill_fwcmd_efuse_to_de(rtwdev, phy_idx, chan, h2c);
 	rtw89_phy_rfk_tssi_fill_fwcmd_tmeter_tbl(rtwdev, phy_idx, chan, h2c);
 
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 5c7c76a53d60..cf7484e4cec4 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -4444,6 +4444,7 @@ void rtw89_phy_rfk_tssi_fill_fwcmd_efuse_to_de(struct rtw89_dev *rtwdev,
 					       const struct rtw89_chan *chan,
 					       struct rtw89_h2c_rf_tssi *h2c)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
 	u8 ch = chan->channel;
 	s8 trim_de;
@@ -4467,9 +4468,14 @@ void rtw89_phy_rfk_tssi_fill_fwcmd_efuse_to_de(struct rtw89_dev *rtwdev,
 		cck_de = tssi_info->tssi_cck[i][gidx];
 		val = u32_get_bits(cck_de + trim_de, 0xff);
 
-		h2c->curr_tssi_cck_de[i] = 0x0;
-		h2c->curr_tssi_cck_de_20m[i] = val;
-		h2c->curr_tssi_cck_de_40m[i] = val;
+		if (chip->chip_id == RTL8922A) {
+			h2c->curr_tssi_cck_de[i] = 0x0;
+			h2c->curr_tssi_cck_de_20m[i] = val;
+			h2c->curr_tssi_cck_de_40m[i] = val;
+		} else {
+			h2c->curr_tssi_cck_de[i] = val;
+		}
+
 		h2c->curr_tssi_efuse_cck_de[i] = cck_de;
 
 		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
@@ -4478,12 +4484,17 @@ void rtw89_phy_rfk_tssi_fill_fwcmd_efuse_to_de(struct rtw89_dev *rtwdev,
 		ofdm_de = phy_tssi_get_ofdm_de(rtwdev, phy, chan, i);
 		val = u32_get_bits(ofdm_de + trim_de, 0xff);
 
-		h2c->curr_tssi_ofdm_de[i] = 0x0;
-		h2c->curr_tssi_ofdm_de_20m[i] = val;
-		h2c->curr_tssi_ofdm_de_40m[i] = val;
-		h2c->curr_tssi_ofdm_de_80m[i] = val;
-		h2c->curr_tssi_ofdm_de_160m[i] = val;
-		h2c->curr_tssi_ofdm_de_320m[i] = val;
+		if (chip->chip_id == RTL8922A) {
+			h2c->curr_tssi_ofdm_de[i] = 0x0;
+			h2c->curr_tssi_ofdm_de_20m[i] = val;
+			h2c->curr_tssi_ofdm_de_40m[i] = val;
+			h2c->curr_tssi_ofdm_de_80m[i] = val;
+			h2c->curr_tssi_ofdm_de_160m[i] = val;
+			h2c->curr_tssi_ofdm_de_320m[i] = val;
+		} else {
+			h2c->curr_tssi_ofdm_de[i] = val;
+		}
+
 		h2c->curr_tssi_efuse_ofdm_de[i] = ofdm_de;
 
 		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
@@ -4498,10 +4509,12 @@ void rtw89_phy_rfk_tssi_fill_fwcmd_tmeter_tbl(struct rtw89_dev *rtwdev,
 {
 	struct rtw89_fw_txpwr_track_cfg *trk = rtwdev->fw.elm_info.txpwr_trk;
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const s8 *thm_up[RF_PATH_B + 1] = {};
 	const s8 *thm_down[RF_PATH_B + 1] = {};
 	u8 subband = chan->subband_type;
-	s8 thm_ofst[128] = {0};
+	s8 thm_ofst[128] = {};
+	int multiplier;
 	u8 thermal;
 	u8 path;
 	u8 i, j;
@@ -4565,6 +4578,11 @@ void rtw89_phy_rfk_tssi_fill_fwcmd_tmeter_tbl(struct rtw89_dev *rtwdev,
 	rtw89_debug(rtwdev, RTW89_DBG_TSSI,
 		    "[TSSI] tmeter tbl on subband: %u\n", subband);
 
+	if (chip->chip_id == RTL8922A)
+		multiplier = 1;
+	else
+		multiplier = -1;
+
 	for (path = RF_PATH_A; path <= RF_PATH_B; path++) {
 		thermal = tssi_info->thermal[path];
 		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
@@ -4579,16 +4597,20 @@ void rtw89_phy_rfk_tssi_fill_fwcmd_tmeter_tbl(struct rtw89_dev *rtwdev,
 		h2c->pg_thermal[path] = thermal;
 
 		i = 0;
-		for (j = 0; j < 64; j++)
+		for (j = 0; j < 64; j++) {
 			thm_ofst[j] = i < DELTA_SWINGIDX_SIZE ?
 				      thm_up[path][i++] :
 				      thm_up[path][DELTA_SWINGIDX_SIZE - 1];
+			thm_ofst[j] *= multiplier;
+		}
 
 		i = 1;
-		for (j = 127; j >= 64; j--)
+		for (j = 127; j >= 64; j--) {
 			thm_ofst[j] = i < DELTA_SWINGIDX_SIZE ?
 				      -thm_down[path][i++] :
 				      -thm_down[path][DELTA_SWINGIDX_SIZE - 1];
+			thm_ofst[j] *= multiplier;
+		}
 
 		for (i = 0; i < 128; i += 4) {
 			h2c->ftable[path][i + 0] = thm_ofst[i + 3];
-- 
2.25.1


