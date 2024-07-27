Return-Path: <linux-wireless+bounces-10559-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8268693DDC7
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jul 2024 10:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E6E2284212
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jul 2024 08:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B897381BE;
	Sat, 27 Jul 2024 08:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="poI6OliG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D382629D
	for <linux-wireless@vger.kernel.org>; Sat, 27 Jul 2024 08:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722067651; cv=none; b=YWO+HSk7dq8FksVOXf63TDiF6wYSoJ2c39SX4gZgWUSOB9Tnkzq/s5XQqo/FOeU5cLu4HRPd4yNOjMnExceBK8IGkpKbhyJUrttl4VLcBYRHfM+0cKs2VpepdDdj7zCfh6qjt79Mb5t+wbKc9gKriBqYQ6qZo2qwQwtFlFlOVL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722067651; c=relaxed/simple;
	bh=AQiVYwHJgcIvctgQ0oiWrOJ/s+mlisO5XCAUgQ/Gt5k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cTbFgjrFcVdzwDNa0LIhSoJciAvLyyh5v67BTDaSEuwTJBhQ6NEY7aTJULBSozRY/WV67T9w/wBSOkhgDT+uTqttwhMMDtCjbnerScUXpxbebfy4+Bf/LB++lxnwdXsl5opYyDWDk/Sq7oK6q/ErzG4g8Y7sIAfSiiSJY/kIPh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=poI6OliG; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46R87SY301417428, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1722067648; bh=AQiVYwHJgcIvctgQ0oiWrOJ/s+mlisO5XCAUgQ/Gt5k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=poI6OliGxaxSlX0W0j6Fvf+gL/P3ezjiXkDit9Qpc9lksWjKxZml1TMLzIklAFtSR
	 +YtQugDYg9wgml+2NY5eSfFjG57ssVflzuJXuHmyvhQEM+lzt6ILRurTswJha+pNr4
	 JrxtZdwIXFt9FLLjusy6TFV1gl+ywsRnk/zP1FqS3Aon/BAKJSDIv2NKQIf54d9BWU
	 3RqwvkW4bAVKTuQyEj4Gbf1kGMYqi1rIYZ1HCLSYK21B3HMOK1qZfnA3P8qEXt2lDu
	 ywlCEnnywj0s5N8WKDOQ1C7wrovAm3DqbTatKzVHa6cuM++cYQMZzhyHZKAS6BK1ZX
	 C5ZliCWQ51iOg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46R87SY301417428
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sat, 27 Jul 2024 16:07:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 27 Jul 2024 16:07:27 +0800
Received: from [127.0.1.1] (172.16.17.30) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 27 Jul
 2024 16:07:22 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 4/7] wifi: rtw89: pass rtwvif to RFK channel
Date: Sat, 27 Jul 2024 16:06:47 +0800
Message-ID: <20240727080650.12195-5-pkshih@realtek.com>
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

So, change rfk_channel prototype and pass rtwvif ahead.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c      | 2 +-
 drivers/net/wireless/realtek/rtw89/core.h      | 7 ++++---
 drivers/net/wireless/realtek/rtw89/mac80211.c  | 2 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c  | 4 ++--
 drivers/net/wireless/realtek/rtw89/rtw8852a.c  | 4 ++--
 drivers/net/wireless/realtek/rtw89/rtw8852b.c  | 4 ++--
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c | 4 ++--
 drivers/net/wireless/realtek/rtw89/rtw8852c.c  | 4 ++--
 drivers/net/wireless/realtek/rtw89/rtw8922a.c  | 4 ++--
 9 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index e9f453889006..0a784a23f27f 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3384,7 +3384,7 @@ int rtw89_core_sta_add(struct rtw89_dev *rtwdev,
 
 		rtw89_btc_ntfy_role_info(rtwdev, rtwvif, rtwsta,
 					 BTC_ROLE_MSTS_STA_CONN_START);
-		rtw89_chip_rfk_channel(rtwdev);
+		rtw89_chip_rfk_channel(rtwdev, rtwvif);
 	} else if (vif->type == NL80211_IFTYPE_AP || sta->tdls) {
 		rtwsta->mac_id = rtw89_acquire_mac_id(rtwdev);
 		if (rtwsta->mac_id == RTW89_MAX_MAC_ID_NUM)
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index b3ede3c1fadf..6c75c64cd653 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3537,7 +3537,7 @@ struct rtw89_chip_ops {
 	void (*rfk_hw_init)(struct rtw89_dev *rtwdev);
 	void (*rfk_init)(struct rtw89_dev *rtwdev);
 	void (*rfk_init_late)(struct rtw89_dev *rtwdev);
-	void (*rfk_channel)(struct rtw89_dev *rtwdev);
+	void (*rfk_channel)(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
 	void (*rfk_band_changed)(struct rtw89_dev *rtwdev,
 				 enum rtw89_phy_idx phy_idx);
 	void (*rfk_scan)(struct rtw89_dev *rtwdev, bool start);
@@ -6140,12 +6140,13 @@ static inline void rtw89_chip_rfk_init_late(struct rtw89_dev *rtwdev)
 		chip->ops->rfk_init_late(rtwdev);
 }
 
-static inline void rtw89_chip_rfk_channel(struct rtw89_dev *rtwdev)
+static inline void rtw89_chip_rfk_channel(struct rtw89_dev *rtwdev,
+					  struct rtw89_vif *rtwvif)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 
 	if (chip->ops->rfk_channel)
-		chip->ops->rfk_channel(rtwdev);
+		chip->ops->rfk_channel(rtwdev, rtwvif);
 }
 
 static inline void rtw89_chip_rfk_band_changed(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 9a0f74b92ea4..0933959fbb7a 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -519,7 +519,7 @@ static int rtw89_ops_start_ap(struct ieee80211_hw *hw,
 	rtw89_fw_h2c_role_maintain(rtwdev, rtwvif, NULL, RTW89_ROLE_TYPE_CHANGE);
 	rtw89_fw_h2c_join_info(rtwdev, rtwvif, NULL, true);
 	rtw89_fw_h2c_cam(rtwdev, rtwvif, NULL, NULL);
-	rtw89_chip_rfk_channel(rtwdev);
+	rtw89_chip_rfk_channel(rtwdev, rtwvif);
 
 	rtw89_queue_chanctx_work(rtwdev);
 	mutex_unlock(&rtwdev->mutex);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 25370ebe177b..e66012b549dd 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -1581,9 +1581,9 @@ static void rtw8851b_rfk_init(struct rtw89_dev *rtwdev)
 	rtw8851b_rx_dck(rtwdev, RTW89_PHY_0);
 }
 
-static void rtw8851b_rfk_channel(struct rtw89_dev *rtwdev)
+static void rtw8851b_rfk_channel(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 {
-	enum rtw89_phy_idx phy_idx = RTW89_PHY_0;
+	enum rtw89_phy_idx phy_idx = rtwvif->phy_idx;
 
 	rtw8851b_rx_dck(rtwdev, phy_idx);
 	rtw8851b_iqk(rtwdev, phy_idx);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 365973bb1673..5b4043ae305c 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -1336,9 +1336,9 @@ static void rtw8852a_rfk_init(struct rtw89_dev *rtwdev)
 	rtw8852a_rx_dck(rtwdev, RTW89_PHY_0, true);
 }
 
-static void rtw8852a_rfk_channel(struct rtw89_dev *rtwdev)
+static void rtw8852a_rfk_channel(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 {
-	enum rtw89_phy_idx phy_idx = RTW89_PHY_0;
+	enum rtw89_phy_idx phy_idx = rtwvif->phy_idx;
 
 	rtw8852a_rx_dck(rtwdev, phy_idx, true);
 	rtw8852a_iqk(rtwdev, phy_idx);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index a22847a311ad..9837ad14285a 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -553,9 +553,9 @@ static void rtw8852b_rfk_init(struct rtw89_dev *rtwdev)
 	rtw8852b_rx_dck(rtwdev, RTW89_PHY_0);
 }
 
-static void rtw8852b_rfk_channel(struct rtw89_dev *rtwdev)
+static void rtw8852b_rfk_channel(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 {
-	enum rtw89_phy_idx phy_idx = RTW89_PHY_0;
+	enum rtw89_phy_idx phy_idx = rtwvif->phy_idx;
 
 	rtw8852b_rx_dck(rtwdev, phy_idx);
 	rtw8852b_iqk(rtwdev, phy_idx);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index dd9fbddc411a..8cec325f86e4 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -526,9 +526,9 @@ static void rtw8852bt_rfk_init(struct rtw89_dev *rtwdev)
 	rtw8852bt_rx_dck(rtwdev, RTW89_PHY_0);
 }
 
-static void rtw8852bt_rfk_channel(struct rtw89_dev *rtwdev)
+static void rtw8852bt_rfk_channel(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 {
-	enum rtw89_phy_idx phy_idx = RTW89_PHY_0;
+	enum rtw89_phy_idx phy_idx = rtwvif->phy_idx;
 
 	rtw8852bt_rx_dck(rtwdev, phy_idx);
 	rtw8852bt_iqk(rtwdev, phy_idx);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 34517afc8290..a3364294970e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -1837,9 +1837,9 @@ static void rtw8852c_rfk_init(struct rtw89_dev *rtwdev)
 	rtw8852c_rx_dck(rtwdev, RTW89_PHY_0, false);
 }
 
-static void rtw8852c_rfk_channel(struct rtw89_dev *rtwdev)
+static void rtw8852c_rfk_channel(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 {
-	enum rtw89_phy_idx phy_idx = RTW89_PHY_0;
+	enum rtw89_phy_idx phy_idx = rtwvif->phy_idx;
 
 	rtw8852c_mcc_get_ch_info(rtwdev, phy_idx);
 	rtw8852c_rx_dck(rtwdev, phy_idx, false);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index a22bab77f4b8..99dca6f38077 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -1953,9 +1953,9 @@ static void _wait_rx_mode(struct rtw89_dev *rtwdev, u8 kpath)
 	}
 }
 
-static void rtw8922a_rfk_channel(struct rtw89_dev *rtwdev)
+static void rtw8922a_rfk_channel(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 {
-	enum rtw89_phy_idx phy_idx = RTW89_PHY_0;
+	enum rtw89_phy_idx phy_idx = rtwvif->phy_idx;
 	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, RF_AB);
 	u32 tx_en;
 
-- 
2.25.1


