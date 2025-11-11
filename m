Return-Path: <linux-wireless+bounces-28827-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D618C4B357
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 03:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5004B1893DD2
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 02:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC03D347BCA;
	Tue, 11 Nov 2025 02:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ZjsQo0jS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CAE2BCF43
	for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 02:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762827972; cv=none; b=VrCz8LHh/ZqjphpJL/isSLLVV+cL8IUBUuXXNcrmVSSxCttXmwD/HWoO1AePsemvgy89YAFuEcww3OHeY4N2EIfxUV7OD5wrVqrLVpRKzKTvsaYCN8wMhPUcCuP7mW0XCJEe6hkCRqv5MGsdy3T22G8SXfqY+hBsIPal9A7rRx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762827972; c=relaxed/simple;
	bh=f5MtSdTa31iMerBmkEWXhhT61RtcNQs9Y//HsHXvEzU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZG9BnoxXHSoJwf2BvWXNUv7uQ7B+4aLk2/TH1F6yUxsJD6O215cr09Wy3u9czJc71AWD+bkin2IJJO+li+oE0AOBY0pLN3wN4OoeGJp0BcUISql5P+/8GsTIjTXQra81QdoWZfjoTY9D+Qjmb8Y9LE/GQzh4fUIR1SkdYmM3w20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ZjsQo0jS; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AB2Q8ghC2922264, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762827968; bh=Mrp6CbR51kT/lKQUtXFA2u+Rt4FR3n6kU059FA6/XGQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=ZjsQo0jSnFclHX2VFktpcuiKZ8Hc0BUIOwSHdgEmyiLq84CuhOUu01KWIcaArVJa2
	 ND+u1/w3lm1xDRGeD7icFpRobGCVaSHh/KqnhwddnUlgCIq7BSWTBkOp/aINYeyWU7
	 +WUKzrkHnEv6Y6qeJ9EcVNvoIyWs9GfeszxAyIww5J5geuidOgm2fwrFR5ciTq67q/
	 eXwqcNrWLN8acMeHUyINRUN/eqg43pUccqxuhE1BxhnAozxaRGYOXvo59yY4lgYxhO
	 cg19267e8q+tWlIkG/qIgTweu+vJBr979h41cpJa9DUzmbtwo6ct2fWT4UbGh2H2Ys
	 kPEJpvkYWyYYA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AB2Q8ghC2922264
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 10:26:08 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 11 Nov 2025 10:26:07 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Tue, 11 Nov 2025 10:26:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>
Subject: [PATCH v2 rtw-next 8/8] wifi: rtw89: configure RX antenna if chips can support
Date: Tue, 11 Nov 2025 10:24:52 +0800
Message-ID: <20251111022452.28093-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251111022452.28093-1-pkshih@realtek.com>
References: <20251111022452.28093-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

If chip->ops->cfg_txrx_path is implemented, a chip can support to configure
RX antenna, so accept setting via iw tool.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac80211.c      |  5 +++++
 .../net/wireless/realtek/rtw89/rtw8852b_common.c   |  6 +++++-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      | 14 ++++++++++++--
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      | 12 +++++++++++-
 4 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 14c8864bd201..6f7571c7c274 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -1147,12 +1147,17 @@ int rtw89_ops_set_antenna(struct ieee80211_hw *hw, int radio_idx, u32 tx_ant, u3
 {
 	struct rtw89_dev *rtwdev = hw->priv;
 	struct rtw89_hal *hal = &rtwdev->hal;
+	const struct rtw89_chip_info *chip;
 
 	lockdep_assert_wiphy(hw->wiphy);
 
+	chip = rtwdev->chip;
+
 	if (hal->ant_diversity) {
 		if (tx_ant != rx_ant || hweight32(tx_ant) != 1)
 			return -EINVAL;
+	} else if (chip->ops->cfg_txrx_path) {
+		/* With cfg_txrx_path ops, chips can configure rx_ant */
 	} else if (rx_ant != hw->wiphy->available_antennas_rx && rx_ant != hal->antenna_rx) {
 		return -EINVAL;
 	}
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
index 3fb2972ae6f6..4e72f4961837 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
@@ -1747,11 +1747,15 @@ static void __rtw8852bx_bb_cfg_txrx_path(struct rtw89_dev *rtwdev)
 	struct rtw89_hal *hal = &rtwdev->hal;
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	enum rtw89_rf_path_bit rx_path = hal->antenna_rx ? hal->antenna_rx : RF_AB;
+	u8 rx_nss = rtwdev->hal.rx_nss;
+
+	if (rx_path != RF_AB)
+		rx_nss = 1;
 
 	rtw8852bx_bb_ctrl_rx_path(rtwdev, rx_path, chan);
 	rtw8852bx_bb_ctrl_rf_mode_rx_path(rtwdev, rx_path);
 
-	if (rtwdev->hal.rx_nss == 1) {
+	if (rx_nss == 1) {
 		rtw89_phy_write32_mask(rtwdev, R_RXHT_MCS_LIMIT, B_RXHT_MCS_LIMIT, 0);
 		rtw89_phy_write32_mask(rtwdev, R_RXVHT_MCS_LIMIT, B_RXVHT_MCS_LIMIT, 0);
 		rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHE_MAX_NSS, 0);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 6be56c2fa0c7..ee81a6792eee 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2502,10 +2502,20 @@ static void rtw8852c_ctrl_nbtg_bt_tx(struct rtw89_dev *rtwdev, bool en,
 static void rtw8852c_bb_cfg_txrx_path(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
+	u8 nrx_path = RF_PATH_AB;
+	u8 rx_nss = hal->rx_nss;
 
-	rtw8852c_bb_cfg_rx_path(rtwdev, RF_PATH_AB);
+	if (hal->antenna_rx == RF_A)
+		nrx_path = RF_PATH_A;
+	else if (hal->antenna_rx == RF_B)
+		nrx_path = RF_PATH_B;
 
-	if (hal->rx_nss == 1) {
+	if (nrx_path != RF_PATH_AB)
+		rx_nss = 1;
+
+	rtw8852c_bb_cfg_rx_path(rtwdev, nrx_path);
+
+	if (rx_nss == 1) {
 		rtw89_phy_write32_mask(rtwdev, R_RXHT_MCS_LIMIT, B_RXHT_MCS_LIMIT, 0);
 		rtw89_phy_write32_mask(rtwdev, R_RXVHT_MCS_LIMIT, B_RXVHT_MCS_LIMIT, 0);
 		rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHE_MAX_NSS, 0);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 61f3a0a3f440..11e8b50a3291 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2347,19 +2347,29 @@ static void rtw8922a_bb_cfg_txrx_path(struct rtw89_dev *rtwdev)
 	enum rtw89_band band = chan->band_type;
 	struct rtw89_hal *hal = &rtwdev->hal;
 	u8 ntx_path = RF_PATH_AB;
+	u8 nrx_path = RF_PATH_AB;
 	u32 tx_en0, tx_en1;
+	u8 rx_nss = 2;
 
 	if (hal->antenna_tx == RF_A)
 		ntx_path = RF_PATH_A;
 	else if (hal->antenna_tx == RF_B)
 		ntx_path = RF_PATH_B;
 
+	if (hal->antenna_rx == RF_A)
+		nrx_path = RF_PATH_A;
+	else if (hal->antenna_rx == RF_B)
+		nrx_path = RF_PATH_B;
+
+	if (nrx_path != RF_PATH_AB)
+		rx_nss = 1;
+
 	rtw8922a_hal_reset(rtwdev, RTW89_PHY_0, RTW89_MAC_0, band, &tx_en0, true);
 	if (rtwdev->dbcc_en)
 		rtw8922a_hal_reset(rtwdev, RTW89_PHY_1, RTW89_MAC_1, band,
 				   &tx_en1, true);
 
-	rtw8922a_ctrl_trx_path(rtwdev, ntx_path, 2, RF_PATH_AB, 2);
+	rtw8922a_ctrl_trx_path(rtwdev, ntx_path, 2, nrx_path, rx_nss);
 
 	rtw8922a_hal_reset(rtwdev, RTW89_PHY_0, RTW89_MAC_0, band, &tx_en0, false);
 	if (rtwdev->dbcc_en)
-- 
2.25.1


