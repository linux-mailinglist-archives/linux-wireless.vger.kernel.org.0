Return-Path: <linux-wireless+bounces-23768-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B97FACEEA8
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 13:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFAFE16AFB3
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 11:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D0E214818;
	Thu,  5 Jun 2025 11:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="hoGHPUMW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B4921ABC9
	for <linux-wireless@vger.kernel.org>; Thu,  5 Jun 2025 11:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749123764; cv=none; b=hUXyJtXmcT8Ue0WsfBpFA5otIwnD6EnH4bOSSHfiKapyw0N9XT1eaQFk1Lbo7/LtYYDA7SprcWPDQCr9tETE21I7f6tyMwhQyv+PFufELBFN6JoTVQCBuCKpBzgM7hr9+fsmIyzYKcgkZqLRZgMaqrQKK/YmYQr83U7X1RFU76o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749123764; c=relaxed/simple;
	bh=brvwJsb08YeIPWDs06Heqce4BvouscEpRPO04JWkpLs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GsrYsOod9FIZD9FOG344ghuem7lxb5EzJ/cnUoM4SrVacBq8tWY4x3vbn3BCEoVH2o9ge6R7GCzDLMo4mYkuAI0KSl2gYkoUv7BcNJdsKI1bs/QCzpwddzdeoAtH65R/oToBsML2gMAgPphJlA2ZK7q20lEg7iK13OmnXl3mIVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=hoGHPUMW; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 555BgeY231471223, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749123760; bh=J3g0hWM6aJcyzEnDjvcvV75rE78cHuHEX6TTRkicGQA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=hoGHPUMWBDuZMgyI108X9VH31x5pDOCI85witlvtr2OxGlha+d0gpiCi28XZMmpwT
	 K+Qp7SvobRep8szugWEpa7KXjSs9Gzm233pCK2NL8K8MibGwfZlDRZEPUNOxw99iox
	 ACrYyF4HFU98jNLO6LaawqNa6DPZJ++pC9wIyr9I5GEfvY9Kic48jjjmLi5Qvt985p
	 sPJOBxbIqURB3RY6D/qStYjjiwl7EWc+zcuFbn0Z6JMgTkNlyqR80u1SUZtGx3NF4/
	 iceV2UIsKz8OBV9XzSQsq+mfft80Fj4uv4utK/kWwXKHIhwSMoUqkIpBSQJ9ipyDOw
	 mmFcfji6bs/Ig==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 555BgeY231471223
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 5 Jun 2025 19:42:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Jun 2025 19:42:40 +0800
Received: from [127.0.1.1] (10.22.226.54) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 5 Jun
 2025 19:42:39 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <echuang@realtek.com>, <damon.chen@realtek.com>, <phhuang@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 5/5] wifi: rtw89: fix EHT 20MHz TX rate for non-AP STA
Date: Thu, 5 Jun 2025 19:42:07 +0800
Message-ID: <20250605114207.12381-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250605114207.12381-1-pkshih@realtek.com>
References: <20250605114207.12381-1-pkshih@realtek.com>
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

From: Kuan-Chung Chen <damon.chen@realtek.com>

The 4-octet EHT MCS/NSS subfield is only used for 20 MHz-only
non-AP STA. Correct the interpretation of this subfield to
prevent improper rate limitations.

Fixes: f1dfcee2eae9 ("wifi: rtw89: Correct EHT TX rate on 20MHz connection")
Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 158550485797..a05841304e0e 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -119,10 +119,12 @@ static u64 get_eht_mcs_ra_mask(u8 *max_nss, u8 start_mcs, u8 n_nss)
 	return mask;
 }
 
-static u64 get_eht_ra_mask(struct ieee80211_link_sta *link_sta)
+static u64 get_eht_ra_mask(struct rtw89_vif_link *rtwvif_link,
+			   struct ieee80211_link_sta *link_sta)
 {
-	struct ieee80211_sta_eht_cap *eht_cap = &link_sta->eht_cap;
+	struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
 	struct ieee80211_eht_mcs_nss_supp_20mhz_only *mcs_nss_20mhz;
+	struct ieee80211_sta_eht_cap *eht_cap = &link_sta->eht_cap;
 	struct ieee80211_eht_mcs_nss_supp_bw *mcs_nss;
 	u8 *he_phy_cap = link_sta->he_cap.he_cap_elem.phy_cap_info;
 
@@ -136,8 +138,8 @@ static u64 get_eht_ra_mask(struct ieee80211_link_sta *link_sta)
 		/* MCS 9, 11, 13 */
 		return get_eht_mcs_ra_mask(mcs_nss->rx_tx_max_nss, 9, 3);
 	case IEEE80211_STA_RX_BW_20:
-		if (!(he_phy_cap[0] &
-		      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_MASK_ALL)) {
+		if (vif->type == NL80211_IFTYPE_AP &&
+		    !(he_phy_cap[0] & IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_MASK_ALL)) {
 			mcs_nss_20mhz = &eht_cap->eht_mcs_nss_supp.only_20mhz;
 			/* MCS 7, 9, 11, 13 */
 			return get_eht_mcs_ra_mask(mcs_nss_20mhz->rx_tx_max_nss, 7, 4);
@@ -332,7 +334,7 @@ static void rtw89_phy_ra_sta_update(struct rtw89_dev *rtwdev,
 	/* Set the ra mask from sta's capability */
 	if (link_sta->eht_cap.has_eht) {
 		mode |= RTW89_RA_MODE_EHT;
-		ra_mask |= get_eht_ra_mask(link_sta);
+		ra_mask |= get_eht_ra_mask(rtwvif_link, link_sta);
 
 		if (rtwdev->hal.no_mcs_12_13)
 			high_rate_masks = rtw89_ra_mask_eht_mcs0_11;
-- 
2.25.1


