Return-Path: <linux-wireless+bounces-5309-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6410688D373
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 01:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95B842817D5
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 00:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394344A32;
	Wed, 27 Mar 2024 00:43:11 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9C42901
	for <linux-wireless@vger.kernel.org>; Wed, 27 Mar 2024 00:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711500191; cv=none; b=E8o0gYYkNdUiQCobj5W0Owf7ZFgSt2J5qi7GhNvOG0APKqzYoztBUmFs4+DvkjfBH+DTQl9SXPjphWTr2p9biGWFNdA3ze1Qd76oMJVn5uUw2icfjtVFYn3JSPwcCWo/F2RnCYpEHSI2H/YtKa/WG4SKRTKdzY2Q7egNkFBfC/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711500191; c=relaxed/simple;
	bh=MWnLpb8FjuzisnQFVgu1xv6bEX/uedl+1mglJ0Kd77k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ag5/F+1ryC5PnT6JjSHvEltPbqY/9ZIbB6rhmHqAhd+HXg4JaGSxO+GUQ9a4Wjshm38YK/PfV33Y65K6r/cdmPWqQ2bvxbJXZGjQx9QnaBZLFEDL54O2AjWW7Pc7TOBpwgF+laM7wZ1naKmJSqlwJsZel9kuHYIYYd7OjAmxkuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42R0h4nY5153715, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42R0h4nY5153715
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Mar 2024 08:43:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Mar 2024 08:43:05 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 27 Mar
 2024 08:43:05 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2] wifi: rtw88: station mode only for SDIO chips
Date: Wed, 27 Mar 2024 08:41:55 +0800
Message-ID: <20240327004155.7172-1-pkshih@realtek.com>
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
v2: correct subject prefix that should be "rtw88" instead of "rtw89"
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


