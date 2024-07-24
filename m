Return-Path: <linux-wireless+bounces-10471-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A722A93AC3E
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2024 07:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53C9D1F22146
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2024 05:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94F825632;
	Wed, 24 Jul 2024 05:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="GwI654e1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB989208D7
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jul 2024 05:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721798821; cv=none; b=NrSaqASEwRkjBeAW9j22zx7ITW89lpXZsDzZP1u49fXbuT30w/w8fPdngPWmcr+2dliDt0EzxOfAEAnYKowN7M1IJ/K6HxSD6fKJeKUROGmjYGzsM+LCpJcnExdg/RSBZVGJUX3eWkG6Nb5MgoNaxMv5E8U2Xo0AXp6sX/cSrG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721798821; c=relaxed/simple;
	bh=hKT8AdGJXxbnSjb5N17pNWh/rNFsJcZ0AJnr5dIT0NM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qr/rLubRiF/YJPftI2gchNaO8sAz7uHLUsNdDRSiFdErNd2g+IJKWioopClkYkbiB8ibq2Qx//PS6iTCWPnPACJ8Ei4QV4qrX27OrQDZ7yuLVIc8I153qLnpNhNya5WtjkQTz8NJb8jWCgDVMGXlwtYRr5at82DOrSQ8RnMKKh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=GwI654e1; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46O5QwDvA1894650, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1721798818; bh=hKT8AdGJXxbnSjb5N17pNWh/rNFsJcZ0AJnr5dIT0NM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=GwI654e16e13t7/h8IAKJEnpyM6CDuvrSKoLxDnV1VhXP15xSEjjMMN/s8bngD0a2
	 RGOgkNa1BYToXwFSOJF3jyKBk7lNRqxbvKV8Ya4EAsnDDa99BJx63A97BHAid7n9V9
	 upNrYTJTUQN2ZHoO8Lau5na3B9rzQyzlrMSrMiDyR/bYReMGIHpVjCWDj4liAFCNj/
	 GATC2xpJCLsfyKlQJ628yQvbfelp7lsHfLGVewVwLrZE3LQCQsgiSRMXGZ3cWBoVIW
	 cj4aPPvPudX2nZkLixFGeeTEjb7S4XE7FksdnBMP0WAr+XAp6TBhUqF4rLwAhrMgob
	 i/N7zBn6cmdIA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46O5QwDvA1894650
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jul 2024 13:26:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 24 Jul 2024 13:26:58 +0800
Received: from [127.0.1.1] (172.16.23.66) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 24 Jul
 2024 13:26:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH 4/4] wifi: rtw89: fix typo of rtw89_phy_ra_updata_XXX
Date: Wed, 24 Jul 2024 13:26:26 +0800
Message-ID: <20240724052626.12774-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240724052626.12774-1-pkshih@realtek.com>
References: <20240724052626.12774-1-pkshih@realtek.com>
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

`updata` should be `update`

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac80211.c | 4 ++--
 drivers/net/wireless/realtek/rtw89/phy.c      | 8 ++++----
 drivers/net/wireless/realtek/rtw89/phy.h      | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index b95fa288c5f5..7d6a44eb8a99 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -783,7 +783,7 @@ static void rtw89_ra_mask_info_update_iter(void *data, struct ieee80211_sta *sta
 
 	rtwsta->use_cfg_mask = true;
 	rtwsta->mask = *br_data->mask;
-	rtw89_phy_ra_updata_sta(br_data->rtwdev, sta, IEEE80211_RC_SUPP_RATES_CHANGED);
+	rtw89_phy_ra_update_sta(br_data->rtwdev, sta, IEEE80211_RC_SUPP_RATES_CHANGED);
 }
 
 static void rtw89_ra_mask_info_update(struct rtw89_dev *rtwdev,
@@ -925,7 +925,7 @@ static void rtw89_ops_sta_rc_update(struct ieee80211_hw *hw,
 {
 	struct rtw89_dev *rtwdev = hw->priv;
 
-	rtw89_phy_ra_updata_sta(rtwdev, sta, changed);
+	rtw89_phy_ra_update_sta(rtwdev, sta, changed);
 }
 
 static int rtw89_ops_add_chanctx(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index ad11d1414874..9579260b5a73 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -462,7 +462,7 @@ static void rtw89_phy_ra_sta_update(struct rtw89_dev *rtwdev,
 	ra->csi_mode = csi_mode;
 }
 
-void rtw89_phy_ra_updata_sta(struct rtw89_dev *rtwdev, struct ieee80211_sta *sta,
+void rtw89_phy_ra_update_sta(struct rtw89_dev *rtwdev, struct ieee80211_sta *sta,
 			     u32 changed)
 {
 	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
@@ -610,17 +610,17 @@ void rtw89_phy_rate_pattern_vif(struct rtw89_dev *rtwdev,
 	rtw89_debug(rtwdev, RTW89_DBG_RA, "unset rate pattern\n");
 }
 
-static void rtw89_phy_ra_updata_sta_iter(void *data, struct ieee80211_sta *sta)
+static void rtw89_phy_ra_update_sta_iter(void *data, struct ieee80211_sta *sta)
 {
 	struct rtw89_dev *rtwdev = (struct rtw89_dev *)data;
 
-	rtw89_phy_ra_updata_sta(rtwdev, sta, IEEE80211_RC_SUPP_RATES_CHANGED);
+	rtw89_phy_ra_update_sta(rtwdev, sta, IEEE80211_RC_SUPP_RATES_CHANGED);
 }
 
 void rtw89_phy_ra_update(struct rtw89_dev *rtwdev)
 {
 	ieee80211_iterate_stations_atomic(rtwdev->hw,
-					  rtw89_phy_ra_updata_sta_iter,
+					  rtw89_phy_ra_update_sta_iter,
 					  rtwdev);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index d8df553b9cb0..512f17d808fe 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -894,7 +894,7 @@ void rtw89_phy_set_txpwr_limit_ru(struct rtw89_dev *rtwdev,
 
 void rtw89_phy_ra_assoc(struct rtw89_dev *rtwdev, struct ieee80211_sta *sta);
 void rtw89_phy_ra_update(struct rtw89_dev *rtwdev);
-void rtw89_phy_ra_updata_sta(struct rtw89_dev *rtwdev, struct ieee80211_sta *sta,
+void rtw89_phy_ra_update_sta(struct rtw89_dev *rtwdev, struct ieee80211_sta *sta,
 			     u32 changed);
 void rtw89_phy_rate_pattern_vif(struct rtw89_dev *rtwdev,
 				struct ieee80211_vif *vif,
-- 
2.25.1


