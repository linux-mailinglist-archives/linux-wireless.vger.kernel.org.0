Return-Path: <linux-wireless+bounces-7382-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A822B8C0D24
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 11:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2853B226BE
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 09:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8F214AD3A;
	Thu,  9 May 2024 09:07:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFD614A4D0
	for <linux-wireless@vger.kernel.org>; Thu,  9 May 2024 09:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715245648; cv=none; b=JG4lRi9KbruFtiHZfGyduLP/qMk4vsMhHZXEZYYJ+bWdhI+74TrSmU0XJZ0kEtECLi/G7r8TTZCgAuhXNjO3OmJ0rkECZJs1LCAovEFFNRfyo3WtrALhn6vZN7HrdzRkNA1ECnHzTYud6WcWDn1yLG/itUJouzR69GDzJM0UmPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715245648; c=relaxed/simple;
	bh=LLQVzVM+qNZqrhOGBIFMwrvh3ZvdiInGM6cAsHVTUP0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oRy6yaOVbHzFIXuaXEPNoQlOveLhje7RQPeAwZD4d5h9xKShE9qNvz22mPNg43ehnDHvWVqGS7hmzBobsGGEQ9BYtJ9LvkJRDjHQWfmWm5Kv9tHTT7whxfI7mKyDeJF3JlBOsFciSthOL08mTmnDyfhNLGJK7uh6Vc4CNV3OQAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44997OVh81425768, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44997OVh81425768
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 9 May 2024 17:07:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 May 2024 17:07:24 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 9 May
 2024 17:07:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 4/4] wifi: rtw89: support mac_id number according to chip
Date: Thu, 9 May 2024 17:06:46 +0800
Message-ID: <20240509090646.35304-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240509090646.35304-1-pkshih@realtek.com>
References: <20240509090646.35304-1-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

On 802.11be chips, to consider MLO, HW doesn't design number
of support mac_id as large as before. And, it might be various
according to chip. For example, old chips support mac_id up to
128, but RTL8922a only supports mac_id up to 32.

Besides, the mac_id acquiring function will be extended when
impending MLO support.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     | 28 +++++++++++++++----
 drivers/net/wireless/realtek/rtw89/core.h     |  3 ++
 drivers/net/wireless/realtek/rtw89/mac.c      |  7 ++---
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  1 +
 8 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 1382bd24ba3b..8b6cb310eaba 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3343,14 +3343,13 @@ int rtw89_core_sta_add(struct rtw89_dev *rtwdev,
 					 BTC_ROLE_MSTS_STA_CONN_START);
 		rtw89_chip_rfk_channel(rtwdev);
 	} else if (vif->type == NL80211_IFTYPE_AP || sta->tdls) {
-		rtwsta->mac_id = rtw89_core_acquire_bit_map(rtwdev->mac_id_map,
-							    RTW89_MAX_MAC_ID_NUM);
+		rtwsta->mac_id = rtw89_acquire_mac_id(rtwdev);
 		if (rtwsta->mac_id == RTW89_MAX_MAC_ID_NUM)
 			return -ENOSPC;
 
 		ret = rtw89_mac_set_macid_pause(rtwdev, rtwsta->mac_id, false);
 		if (ret) {
-			rtw89_core_release_bit_map(rtwdev->mac_id_map, rtwsta->mac_id);
+			rtw89_release_mac_id(rtwdev, rtwsta->mac_id);
 			rtw89_warn(rtwdev, "failed to send h2c macid pause\n");
 			return ret;
 		}
@@ -3358,7 +3357,7 @@ int rtw89_core_sta_add(struct rtw89_dev *rtwdev,
 		ret = rtw89_fw_h2c_role_maintain(rtwdev, rtwvif, rtwsta,
 						 RTW89_ROLE_CREATE);
 		if (ret) {
-			rtw89_core_release_bit_map(rtwdev->mac_id_map, rtwsta->mac_id);
+			rtw89_release_mac_id(rtwdev, rtwsta->mac_id);
 			rtw89_warn(rtwdev, "failed to send h2c role info\n");
 			return ret;
 		}
@@ -3531,7 +3530,7 @@ int rtw89_core_sta_remove(struct rtw89_dev *rtwdev,
 		rtw89_btc_ntfy_role_info(rtwdev, rtwvif, rtwsta,
 					 BTC_ROLE_MSTS_STA_DIS_CONN);
 	} else if (vif->type == NL80211_IFTYPE_AP || sta->tdls) {
-		rtw89_core_release_bit_map(rtwdev->mac_id_map, rtwsta->mac_id);
+		rtw89_release_mac_id(rtwdev, rtwsta->mac_id);
 
 		ret = rtw89_fw_h2c_role_maintain(rtwdev, rtwvif, rtwsta,
 						 RTW89_ROLE_REMOVE);
@@ -4181,6 +4180,25 @@ void rtw89_core_stop(struct rtw89_dev *rtwdev)
 	rtw89_hci_reset(rtwdev);
 }
 
+u8 rtw89_acquire_mac_id(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	u8 mac_id_num = chip->support_macid_num;
+	u8 mac_id;
+
+	mac_id = find_first_zero_bit(rtwdev->mac_id_map, mac_id_num);
+	if (mac_id == mac_id_num)
+		return RTW89_MAX_MAC_ID_NUM;
+
+	set_bit(mac_id, rtwdev->mac_id_map);
+	return mac_id;
+}
+
+void rtw89_release_mac_id(struct rtw89_dev *rtwdev, u8 mac_id)
+{
+	clear_bit(mac_id, rtwdev->mac_id_map);
+}
+
 int rtw89_core_init(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 32ae500579bb..c0f2afb4888a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4143,6 +4143,7 @@ struct rtw89_chip_info {
 	u8 wde_qempty_acq_grpnum;
 	u8 wde_qempty_mgq_grpsel;
 	u32 rf_base_addr[2];
+	u8 support_macid_num;
 	u8 support_chanctx_num;
 	u8 support_bands;
 	u16 support_bandwidths;
@@ -6470,6 +6471,8 @@ struct rtw89_dev *rtw89_alloc_ieee80211_hw(struct device *device,
 					   u32 bus_data_size,
 					   const struct rtw89_chip_info *chip);
 void rtw89_free_ieee80211_hw(struct rtw89_dev *rtwdev);
+u8 rtw89_acquire_mac_id(struct rtw89_dev *rtwdev);
+void rtw89_release_mac_id(struct rtw89_dev *rtwdev, u8 mac_id);
 void rtw89_core_set_chip_txpwr(struct rtw89_dev *rtwdev);
 void rtw89_get_default_chandef(struct cfg80211_chan_def *chandef);
 void rtw89_get_channel_params(const struct cfg80211_chan_def *chandef,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 3fe0046f6eaa..baefc30b88c4 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4664,8 +4664,7 @@ int rtw89_mac_add_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 {
 	int ret;
 
-	rtwvif->mac_id = rtw89_core_acquire_bit_map(rtwdev->mac_id_map,
-						    RTW89_MAX_MAC_ID_NUM);
+	rtwvif->mac_id = rtw89_acquire_mac_id(rtwdev);
 	if (rtwvif->mac_id == RTW89_MAX_MAC_ID_NUM)
 		return -ENOSPC;
 
@@ -4676,7 +4675,7 @@ int rtw89_mac_add_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	return 0;
 
 release_mac_id:
-	rtw89_core_release_bit_map(rtwdev->mac_id_map, rtwvif->mac_id);
+	rtw89_release_mac_id(rtwdev, rtwvif->mac_id);
 
 	return ret;
 }
@@ -4686,7 +4685,7 @@ int rtw89_mac_remove_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	int ret;
 
 	ret = rtw89_mac_vif_deinit(rtwdev, rtwvif);
-	rtw89_core_release_bit_map(rtwdev->mac_id_map, rtwvif->mac_id);
+	rtw89_release_mac_id(rtwdev, rtwvif->mac_id);
 
 	return ret;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 87b51823244d..78e276f321c2 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2447,6 +2447,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.dig_table		= NULL,
 	.dig_regs		= &rtw8851b_dig_regs,
 	.tssi_dbw_table		= NULL,
+	.support_macid_num	= RTW89_MAX_MAC_ID_NUM,
 	.support_chanctx_num	= 0,
 	.support_rnr		= false,
 	.support_bands		= BIT(NL80211_BAND_2GHZ) |
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index e93cee1456bd..aebbceea93f8 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2162,6 +2162,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.dig_table		= &rtw89_8852a_phy_dig_table,
 	.dig_regs		= &rtw8852a_dig_regs,
 	.tssi_dbw_table		= NULL,
+	.support_macid_num	= RTW89_MAX_MAC_ID_NUM,
 	.support_chanctx_num	= 1,
 	.support_rnr		= false,
 	.support_bands		= BIT(NL80211_BAND_2GHZ) |
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index d351096fa4b4..53ae00b5ab7c 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -2610,6 +2610,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.dig_table		= NULL,
 	.dig_regs		= &rtw8852b_dig_regs,
 	.tssi_dbw_table		= NULL,
+	.support_macid_num	= RTW89_MAX_MAC_ID_NUM,
 	.support_chanctx_num	= 0,
 	.support_rnr		= false,
 	.support_bands		= BIT(NL80211_BAND_2GHZ) |
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 3571b41786d7..544ea1d3b577 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2941,6 +2941,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.dig_table		= NULL,
 	.dig_regs		= &rtw8852c_dig_regs,
 	.tssi_dbw_table		= &rtw89_8852c_tssi_dbw_table,
+	.support_macid_num	= RTW89_MAX_MAC_ID_NUM,
 	.support_chanctx_num	= 2,
 	.support_rnr		= false,
 	.support_bands		= BIT(NL80211_BAND_2GHZ) |
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 3b3ea3a7c19a..cc4f251caadd 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2544,6 +2544,7 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.dig_table		= NULL,
 	.dig_regs		= &rtw8922a_dig_regs,
 	.tssi_dbw_table		= NULL,
+	.support_macid_num	= 32,
 	.support_chanctx_num	= 2,
 	.support_rnr		= true,
 	.support_bands		= BIT(NL80211_BAND_2GHZ) |
-- 
2.25.1


