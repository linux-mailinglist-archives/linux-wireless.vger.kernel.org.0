Return-Path: <linux-wireless+bounces-10560-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCD493DDC8
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jul 2024 10:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C980AB2102A
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jul 2024 08:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F8F42045;
	Sat, 27 Jul 2024 08:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="PvEWBik0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D7F37144
	for <linux-wireless@vger.kernel.org>; Sat, 27 Jul 2024 08:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722067652; cv=none; b=Gz/Km/lhBvkJdWBnG86oOGDqC9fKTXhix1uQ2somLGCKU5cWCc37g2dXYf9BixR8KgMLbFoeN1F0OjCM2cteLBKqDTq+0kcHFH/RwEaMXb2ciVp6aB4QxYGW00srK5BcaLIv4PID7j3/0id6SFXoxeWyXJ5iFt8Y2U39OgcbLRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722067652; c=relaxed/simple;
	bh=RCCqbnxLkIVSvpHPf6MjkfJcErzfxh1dj0udWRz6MTk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k424UoKhi07/7am3IwXy+sIlw6rKkzqCOq5Nhh2iotaGNJIZWt7+7Dp9xPlsS31EjWvB6O39DWJQnmUkAz5mVvUy+54/F2cPtfNrZoAkKZFCpz6DQRn8Qd5Dfa/Mfv9GpalhY0HRr7RQPrEYof/v9ukMGXKJ5C+f1dJTycxSy5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=PvEWBik0; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46R87SY501417428, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1722067648; bh=RCCqbnxLkIVSvpHPf6MjkfJcErzfxh1dj0udWRz6MTk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=PvEWBik0n0A0k+iZNS9TZvrpVH21XBy3CQmterabRsdL523TeoWeBlqZrez5aBDH8
	 b4IGlF20tO8EbRgwfDwKEaldjnwel0hhN2klbzSIKx7e/SToGpa3hpjDbWNQl7/ZWd
	 vq3P0RdGF1X2KQB78Slo+0CgZui4LAaWmRAgD+ksxsC+kuLQOShwcdqnWUz1nxBlel
	 xTlKmQKXhdoYzdR5P3ePEhrGet4B3d1WH4r8TMr1Zr0NglZDGvD3bJalmGrL+mrFRJ
	 Vrh/+D5TWBoM8t+Ddxvc2Y+yzaVZXfj/zNAKgtCGg9R9qLGcbw7L9AJE15Tgyl+qUE
	 mZkjgZJrzY90w==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46R87SY501417428
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sat, 27 Jul 2024 16:07:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 27 Jul 2024 16:07:28 +0800
Received: from [127.0.1.1] (172.16.17.30) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 27 Jul
 2024 16:07:27 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 5/7] wifi: rtw89: pass rtwvif to RFK scan
Date: Sat, 27 Jul 2024 16:06:48 +0800
Message-ID: <20240727080650.12195-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240727080650.12195-1-pkshih@realtek.com>
References: <20240727080650.12195-1-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

For chips supporting multiple channels, they need to get target info
from rtwvif, e.g. PHY index and Chanctx index.

So, change rfk_scan prototype and pass rtwvif ahead.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c      | 4 ++--
 drivers/net/wireless/realtek/rtw89/core.h      | 8 +++++---
 drivers/net/wireless/realtek/rtw89/rtw8851b.c  | 5 +++--
 drivers/net/wireless/realtek/rtw89/rtw8852a.c  | 5 +++--
 drivers/net/wireless/realtek/rtw89/rtw8852b.c  | 5 +++--
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c | 5 +++--
 drivers/net/wireless/realtek/rtw89/rtw8852c.c  | 5 +++--
 drivers/net/wireless/realtek/rtw89/rtw8922a.c  | 3 ++-
 8 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 0a784a23f27f..871ad32c3056 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4342,7 +4342,7 @@ void rtw89_core_scan_start(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 
 	ether_addr_copy(rtwvif->mac_addr, mac_addr);
 	rtw89_btc_ntfy_scan_start(rtwdev, RTW89_PHY_0, chan->band_type);
-	rtw89_chip_rfk_scan(rtwdev, true);
+	rtw89_chip_rfk_scan(rtwdev, rtwvif, true);
 	rtw89_hci_recalc_int_mit(rtwdev);
 	rtw89_phy_config_edcca(rtwdev, true);
 
@@ -4360,7 +4360,7 @@ void rtw89_core_scan_complete(struct rtw89_dev *rtwdev,
 	ether_addr_copy(rtwvif->mac_addr, vif->addr);
 	rtw89_fw_h2c_cam(rtwdev, rtwvif, NULL, NULL);
 
-	rtw89_chip_rfk_scan(rtwdev, false);
+	rtw89_chip_rfk_scan(rtwdev, rtwvif, false);
 	rtw89_btc_ntfy_scan_finish(rtwdev, RTW89_PHY_0);
 	rtw89_phy_config_edcca(rtwdev, false);
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 6c75c64cd653..d7d98678184b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3540,7 +3540,8 @@ struct rtw89_chip_ops {
 	void (*rfk_channel)(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
 	void (*rfk_band_changed)(struct rtw89_dev *rtwdev,
 				 enum rtw89_phy_idx phy_idx);
-	void (*rfk_scan)(struct rtw89_dev *rtwdev, bool start);
+	void (*rfk_scan)(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+			 bool start);
 	void (*rfk_track)(struct rtw89_dev *rtwdev);
 	void (*power_trim)(struct rtw89_dev *rtwdev);
 	void (*set_txpwr)(struct rtw89_dev *rtwdev,
@@ -6158,12 +6159,13 @@ static inline void rtw89_chip_rfk_band_changed(struct rtw89_dev *rtwdev,
 		chip->ops->rfk_band_changed(rtwdev, phy_idx);
 }
 
-static inline void rtw89_chip_rfk_scan(struct rtw89_dev *rtwdev, bool start)
+static inline void rtw89_chip_rfk_scan(struct rtw89_dev *rtwdev,
+				       struct rtw89_vif *rtwvif, bool start)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 
 	if (chip->ops->rfk_scan)
-		chip->ops->rfk_scan(rtwdev, start);
+		chip->ops->rfk_scan(rtwdev, rtwvif, start);
 }
 
 static inline void rtw89_chip_rfk_track(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index e66012b549dd..c181d88a299e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -1597,9 +1597,10 @@ static void rtw8851b_rfk_band_changed(struct rtw89_dev *rtwdev,
 	rtw8851b_tssi_scan(rtwdev, phy_idx);
 }
 
-static void rtw8851b_rfk_scan(struct rtw89_dev *rtwdev, bool start)
+static void rtw8851b_rfk_scan(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+			      bool start)
 {
-	rtw8851b_wifi_scan_notify(rtwdev, start, RTW89_PHY_0);
+	rtw8851b_wifi_scan_notify(rtwdev, start, rtwvif->phy_idx);
 }
 
 static void rtw8851b_rfk_track(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 5b4043ae305c..9856e90b837e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -1352,9 +1352,10 @@ static void rtw8852a_rfk_band_changed(struct rtw89_dev *rtwdev,
 	rtw8852a_tssi_scan(rtwdev, phy_idx);
 }
 
-static void rtw8852a_rfk_scan(struct rtw89_dev *rtwdev, bool start)
+static void rtw8852a_rfk_scan(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+			      bool start)
 {
-	rtw8852a_wifi_scan_notify(rtwdev, start, RTW89_PHY_0);
+	rtw8852a_wifi_scan_notify(rtwdev, start, rtwvif->phy_idx);
 }
 
 static void rtw8852a_rfk_track(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 9837ad14285a..019223312c6c 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -569,9 +569,10 @@ static void rtw8852b_rfk_band_changed(struct rtw89_dev *rtwdev,
 	rtw8852b_tssi_scan(rtwdev, phy_idx);
 }
 
-static void rtw8852b_rfk_scan(struct rtw89_dev *rtwdev, bool start)
+static void rtw8852b_rfk_scan(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+			      bool start)
 {
-	rtw8852b_wifi_scan_notify(rtwdev, start, RTW89_PHY_0);
+	rtw8852b_wifi_scan_notify(rtwdev, start, rtwvif->phy_idx);
 }
 
 static void rtw8852b_rfk_track(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index 8cec325f86e4..e54bafb0fd45 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -542,9 +542,10 @@ static void rtw8852bt_rfk_band_changed(struct rtw89_dev *rtwdev,
 	rtw8852bt_tssi_scan(rtwdev, phy_idx);
 }
 
-static void rtw8852bt_rfk_scan(struct rtw89_dev *rtwdev, bool start)
+static void rtw8852bt_rfk_scan(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+			       bool start)
 {
-	rtw8852bt_wifi_scan_notify(rtwdev, start, RTW89_PHY_0);
+	rtw8852bt_wifi_scan_notify(rtwdev, start, rtwvif->phy_idx);
 }
 
 static void rtw8852bt_rfk_track(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index a3364294970e..8f35f887242e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -1855,9 +1855,10 @@ static void rtw8852c_rfk_band_changed(struct rtw89_dev *rtwdev,
 	rtw8852c_tssi_scan(rtwdev, phy_idx);
 }
 
-static void rtw8852c_rfk_scan(struct rtw89_dev *rtwdev, bool start)
+static void rtw8852c_rfk_scan(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+			      bool start)
 {
-	rtw8852c_wifi_scan_notify(rtwdev, start, RTW89_PHY_0);
+	rtw8852c_wifi_scan_notify(rtwdev, start, rtwvif->phy_idx);
 }
 
 static void rtw8852c_rfk_track(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 99dca6f38077..4e77ea55767b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -1980,7 +1980,8 @@ static void rtw8922a_rfk_band_changed(struct rtw89_dev *rtwdev,
 	rtw89_phy_rfk_tssi_and_wait(rtwdev, phy_idx, RTW89_TSSI_SCAN, 6);
 }
 
-static void rtw8922a_rfk_scan(struct rtw89_dev *rtwdev, bool start)
+static void rtw8922a_rfk_scan(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+			      bool start)
 {
 }
 
-- 
2.25.1


