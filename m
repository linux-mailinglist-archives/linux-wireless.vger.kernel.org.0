Return-Path: <linux-wireless+bounces-15952-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B8C9E670E
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 06:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44F56282EF5
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 05:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD6A1990C2;
	Fri,  6 Dec 2024 05:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="g9MHUVOr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D683F198A0F
	for <linux-wireless@vger.kernel.org>; Fri,  6 Dec 2024 05:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733464676; cv=none; b=qxE+Hzhkuzo36KG+lTkeF735rUI6Na9cuoj0pqxhkV3u/gNPRxKriAk8MLsNyLix2gNYFwqxTM9HY30J2neTBT52XZbWMWv6BhGlAsEWQdPOjO5SdNQPbyXxImCSk4rW2nTGuYnQu3+V8v+p5YDRsP9sy2P4ytnIrCKuX3qsKek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733464676; c=relaxed/simple;
	bh=AZbCC6Ztxh0neoeIrEz6UKleylbvekT2q3G/x8DSmsU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hfeKIRfr5owIhiKXDNPlCpW28BYHwsfyFAoSyxlugfY/zKSULN1CK+7EIdCfmjsIe/lnVYn1ZfzHViH3VZXZNaoTb/i5GpUuFHqtJyHUyN2vI4k8vHzc6l+t9vzXy09p6LK/3SPRaiY5GEgMDOft1Y1VMRJ4yMeWM9LSgwaHHT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=g9MHUVOr; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4B65vpHN34127388, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1733464671; bh=AZbCC6Ztxh0neoeIrEz6UKleylbvekT2q3G/x8DSmsU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=g9MHUVOrilWwUzrBZRKbm/U5JyBgjT6OC1YC9ZFLhgWNfXB51Emav+ueuYBH3B30z
	 VDq16C9Q5AqjoERW7BUQUMRz6cCFJAoHSRkMykDhffsqMqG24xOfazG1ssg+IZbP7G
	 uUFtKrx1XGgWZzRI8M9t+dpYFrnIeBG0R/BcQ9JMyUZHyHr6sPHAdEeHRFdXcKUi6P
	 CA4WODfsCTYr8yobhsbS6czVCKw/maJMX6XjI21/Js7aJLLCWkkvjZx9KawfJLo+3v
	 xpE6zLWyNip4GTw6aRSfv0MNzjkjiINdcu/0/EzjPfBeW36EPfIfONbnU9cj23yI3u
	 XILCG9mwaB2DA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4B65vpHN34127388
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 6 Dec 2024 13:57:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 6 Dec 2024 13:57:51 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 6 Dec
 2024 13:57:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <echuang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH 4/7] wifi: rtw89: disable firmware training HE GI and LTF
Date: Fri, 6 Dec 2024 13:57:13 +0800
Message-ID: <20241206055716.18598-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241206055716.18598-1-pkshih@realtek.com>
References: <20241206055716.18598-1-pkshih@realtek.com>
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

Given the performance trade-off associated with firmware training
HE GI/LTF, especially in high attenuation environments, we have
decided to utilize a constant value instead.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h | 10 ++++++++++
 drivers/net/wireless/realtek/rtw89/phy.c  | 24 +++++++++++++++--------
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index ec2a80af04bb..15967978bf4a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -6875,6 +6875,16 @@ bool rtw89_sta_has_beamformer_cap(struct ieee80211_link_sta *link_sta)
 	return false;
 }
 
+static inline
+bool rtw89_sta_link_has_su_mu_4xhe08(struct ieee80211_link_sta *link_sta)
+{
+	if (link_sta->he_cap.he_cap_elem.phy_cap_info[7] &
+	    IEEE80211_HE_PHY_CAP7_HE_SU_MU_PPDU_4XLTF_AND_08_US_GI)
+		return true;
+
+	return false;
+}
+
 static inline struct rtw89_fw_suit *rtw89_fw_suit_get(struct rtw89_dev *rtwdev,
 						      enum rtw89_fw_type type)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 1d4d3dcce060..604ea048c3ab 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -264,16 +264,26 @@ rtw89_ra_mask_eht_rates[4] = {RA_MASK_EHT_1SS_RATES, RA_MASK_EHT_2SS_RATES,
 
 static void rtw89_phy_ra_gi_ltf(struct rtw89_dev *rtwdev,
 				struct rtw89_sta_link *rtwsta_link,
+				struct ieee80211_link_sta *link_sta,
 				const struct rtw89_chan *chan,
 				bool *fix_giltf_en, u8 *fix_giltf)
 {
 	struct cfg80211_bitrate_mask *mask = &rtwsta_link->mask;
 	u8 band = chan->band_type;
 	enum nl80211_band nl_band = rtw89_hw_to_nl80211_band(band);
-	u8 he_gi = mask->control[nl_band].he_gi;
 	u8 he_ltf = mask->control[nl_band].he_ltf;
+	u8 he_gi = mask->control[nl_band].he_gi;
 
-	if (!rtwsta_link->use_cfg_mask)
+	*fix_giltf_en = true;
+
+	if (rtwdev->chip->chip_id == RTL8852C &&
+	    chan->band_width == RTW89_CHANNEL_WIDTH_160 &&
+	    rtw89_sta_link_has_su_mu_4xhe08(link_sta))
+		*fix_giltf = RTW89_GILTF_SGI_4XHE08;
+	else
+		*fix_giltf = RTW89_GILTF_2XHE08;
+
+	if (!(rtwsta_link->use_cfg_mask && link_sta->he_cap.has_he))
 		return;
 
 	if (he_ltf == 2 && he_gi == 2) {
@@ -288,12 +298,7 @@ static void rtw89_phy_ra_gi_ltf(struct rtw89_dev *rtwdev,
 		*fix_giltf = RTW89_GILTF_1XHE16;
 	} else if (he_ltf == 0 && he_gi == 0) {
 		*fix_giltf = RTW89_GILTF_1XHE08;
-	} else {
-		*fix_giltf_en = false;
-		return;
 	}
-
-	*fix_giltf_en = true;
 }
 
 static void rtw89_phy_ra_sta_update(struct rtw89_dev *rtwdev,
@@ -326,6 +331,8 @@ static void rtw89_phy_ra_sta_update(struct rtw89_dev *rtwdev,
 		mode |= RTW89_RA_MODE_EHT;
 		ra_mask |= get_eht_ra_mask(link_sta);
 		high_rate_masks = rtw89_ra_mask_eht_rates;
+		rtw89_phy_ra_gi_ltf(rtwdev, rtwsta_link, link_sta,
+				    chan, &fix_giltf_en, &fix_giltf);
 	} else if (link_sta->he_cap.has_he) {
 		mode |= RTW89_RA_MODE_HE;
 		csi_mode = RTW89_RA_RPT_MODE_HE;
@@ -337,7 +344,8 @@ static void rtw89_phy_ra_sta_update(struct rtw89_dev *rtwdev,
 		if (link_sta->he_cap.he_cap_elem.phy_cap_info[1] &
 		    IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD)
 			ldpc_en = 1;
-		rtw89_phy_ra_gi_ltf(rtwdev, rtwsta_link, chan, &fix_giltf_en, &fix_giltf);
+		rtw89_phy_ra_gi_ltf(rtwdev, rtwsta_link, link_sta,
+				    chan, &fix_giltf_en, &fix_giltf);
 	} else if (link_sta->vht_cap.vht_supported) {
 		u16 mcs_map = le16_to_cpu(link_sta->vht_cap.vht_mcs.rx_mcs_map);
 
-- 
2.25.1


