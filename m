Return-Path: <linux-wireless+bounces-5262-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D3388B715
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 02:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEBD51F3E80F
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 01:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96E822EE4;
	Tue, 26 Mar 2024 01:48:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AE6208C3
	for <linux-wireless@vger.kernel.org>; Tue, 26 Mar 2024 01:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711417703; cv=none; b=EAK1SEwXPAIryG8/a52/1I2EXaAZFNA/FP6TEYCfi4xF+RxTwltOzX4vuTG+xoUJMKe1JxN1Jn1wOsUIEAws1yar8dM62u2OZlFLBHbBRbimOkakt8VMgPQMPdsD87yILZO8PGeOWLLq5BGOsgpqqbeasoRP0MOfQOwy3zkbYu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711417703; c=relaxed/simple;
	bh=bECuANPufVb5oVvXNTsCh/IJfYO8+N/wwvhOs+FBC8A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c9PWYfXyN6eTDYDGTMsJAlDQa0BjW9jsnA5XejKW79t/cv7LMkpH4nTSKTGU2ZotDldrlxAejM+yi8RU00GX6sX5Dcesgu2brehQvrLXn097NyGqYacS04cZsWmZeMBBExan4SKBdVVTxQ1jXO2qDpz5Ow0iRU3hKtty2D+pO8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42Q1mGzxD3448198, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42Q1mGzxD3448198
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Mar 2024 09:48:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Mar 2024 09:48:17 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 26 Mar
 2024 09:48:17 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <martin.blumenstingl@googlemail.com>
Subject: [PATCH] wifi: rtw89: station mode only for SDIO chips
Date: Tue, 26 Mar 2024 09:47:07 +0800
Message-ID: <20240326014707.17458-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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

Since only station mode has been tested on SDIO chips, only keep it support
for SDIO chips to reflect correct supported features.

Link: https://lore.kernel.org/linux-wireless/87wmpu1do6.fsf@kernel.org/T/#t
Link: https://lore.kernel.org/linux-wireless/36972ff5-0c48-4bd2-8f9a-9649bfa24225@lexina.in/
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
Hi Martin,

I Cc'ed you to prevent you missing this patch that I disable AP mode.

---
 drivers/net/wireless/realtek/rtw88/main.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 81ef4717dbf4..d1f0e7541bfa 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -2203,6 +2203,7 @@ EXPORT_SYMBOL(rtw_core_deinit);
 
 int rtw_register_hw(struct rtw_dev *rtwdev, struct ieee80211_hw *hw)
 {
+	bool sta_mode_only = rtwdev->hci.type == RTW_HCI_TYPE_SDIO;
 	struct rtw_hal *hal = &rtwdev->hal;
 	int max_tx_headroom = 0;
 	int ret;
@@ -2231,10 +2232,13 @@ int rtw_register_hw(struct rtw_dev *rtwdev, struct ieee80211_hw *hw)
 	ieee80211_hw_set(hw, TX_AMSDU);
 	ieee80211_hw_set(hw, SINGLE_SCAN_ON_ALL_BANDS);
 
-	hw->wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
-				     BIT(NL80211_IFTYPE_AP) |
-				     BIT(NL80211_IFTYPE_ADHOC) |
-				     BIT(NL80211_IFTYPE_MESH_POINT);
+	if (sta_mode_only)
+		hw->wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION);
+	else
+		hw->wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
+					     BIT(NL80211_IFTYPE_AP) |
+					     BIT(NL80211_IFTYPE_ADHOC) |
+					     BIT(NL80211_IFTYPE_MESH_POINT);
 	hw->wiphy->available_antennas_tx = hal->antenna_tx;
 	hw->wiphy->available_antennas_rx = hal->antenna_rx;
 
@@ -2245,7 +2249,7 @@ int rtw_register_hw(struct rtw_dev *rtwdev, struct ieee80211_hw *hw)
 	hw->wiphy->max_scan_ssids = RTW_SCAN_MAX_SSIDS;
 	hw->wiphy->max_scan_ie_len = rtw_get_max_scan_ie_len(rtwdev);
 
-	if (rtwdev->chip->id == RTW_CHIP_TYPE_8822C) {
+	if (!sta_mode_only && rtwdev->chip->id == RTW_CHIP_TYPE_8822C) {
 		hw->wiphy->iface_combinations = rtw_iface_combs;
 		hw->wiphy->n_iface_combinations = ARRAY_SIZE(rtw_iface_combs);
 	}
-- 
2.25.1


