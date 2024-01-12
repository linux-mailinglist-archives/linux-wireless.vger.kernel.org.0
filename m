Return-Path: <linux-wireless+bounces-1789-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE97D82BB43
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 07:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81861B24B06
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 06:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FA95C8F3;
	Fri, 12 Jan 2024 06:27:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1905C8F1
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 06:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40C6RHsE42174031, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40C6RHsE42174031
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jan 2024 14:27:17 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Fri, 12 Jan 2024 14:27:17 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 12 Jan
 2024 14:27:17 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/4] wifi: rtw89: declare EXT NSS BW of VHT capability
Date: Fri, 12 Jan 2024 14:26:40 +0800
Message-ID: <20240112062640.36922-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240112062640.36922-1-pkshih@realtek.com>
References: <20240112062640.36922-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

According to IEEE Std. 802.11, it defines:
Indicates whether the STA is capable of interpreting the Extended NSS BW
Support subfield of the VHT Capabilities Information field.

Some AP such as TP-LINK BE19000 would check it for bandwidth settings, so
causes 80MHz rate when associating on 160 MHz bandwidth. Declare this
capability to yield expected result.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 7f3060898ea8..8522eb0f0ad2 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3648,6 +3648,10 @@ static void rtw89_init_vht_cap(struct rtw89_dev *rtwdev,
 	vht_cap->vht_mcs.tx_mcs_map = cpu_to_le16(tx_mcs_map);
 	vht_cap->vht_mcs.rx_highest = highest[hal->rx_nss - 1];
 	vht_cap->vht_mcs.tx_highest = highest[hal->tx_nss - 1];
+
+	if (ieee80211_hw_check(rtwdev->hw, SUPPORTS_VHT_EXT_NSS_BW))
+		vht_cap->vht_mcs.tx_highest |=
+			cpu_to_le16(IEEE80211_VHT_EXT_NSS_BW_CAPABLE);
 }
 
 static void rtw89_init_he_cap(struct rtw89_dev *rtwdev,
@@ -4391,6 +4395,7 @@ EXPORT_SYMBOL(rtw89_chip_info_setup);
 
 static int rtw89_core_register_hw(struct rtw89_dev *rtwdev)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct ieee80211_hw *hw = rtwdev->hw;
 	struct rtw89_efuse *efuse = &rtwdev->efuse;
 	struct rtw89_hal *hal = &rtwdev->hal;
@@ -4428,6 +4433,9 @@ static int rtw89_core_register_hw(struct rtw89_dev *rtwdev)
 	/* ref: description of rtw89_mcc_get_tbtt_ofst() in chan.c */
 	ieee80211_hw_set(hw, TIMING_BEACON_ONLY);
 
+	if (chip->support_bandwidths & BIT(NL80211_CHAN_WIDTH_160))
+		ieee80211_hw_set(hw, SUPPORTS_VHT_EXT_NSS_BW);
+
 	if (RTW89_CHK_FW_FEATURE(BEACON_FILTER, &rtwdev->fw))
 		ieee80211_hw_set(hw, CONNECTION_MONITOR);
 
-- 
2.25.1


