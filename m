Return-Path: <linux-wireless+bounces-3897-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 016D885F192
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 07:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABE6D1F22CEE
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 06:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC43125C4;
	Thu, 22 Feb 2024 06:44:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25928C8E2
	for <linux-wireless@vger.kernel.org>; Thu, 22 Feb 2024 06:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708584242; cv=none; b=sZz0YFkrgN+YhlKTbnq0yostp+EWV9HJ+GJirjKhyTGz/2bLQIt8GYJrQWcc2528aLELSOfor6aAC4lcu0PsP9/V24DfFpZgH0knkwSYU08UmOPUNsFkV4nOLoxIMQ6fJPNL3ru3DcUmfDyLXXcsWNFGLrGA5ZLbBag0FXVJOx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708584242; c=relaxed/simple;
	bh=+zHW1ToI9+4ZX+llTnhDH/ELQcD3K8p13cj4klI3e54=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aQbdgBRcrMd49ssDOg8NsHi8W4pAHUM/5W8DJc5YVKomGaE60SfkJM3j0N7EVGnmQttEc1hVIaXAazN3wOY7HyauKnqwRn27a7uqcHjvthnzm4INrQ/I3qX8nWiPKFOPSvcfVY9mdLlWmJ+O7o9UXvTfq54XmqPuE8mh3IBu9XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41M6hqbK71486327, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41M6hqbK71486327
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 14:43:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Thu, 22 Feb 2024 14:43:53 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 22 Feb
 2024 14:43:52 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <timlee@realtek.com>, <damon.chen@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/3] wifi: rtw89: Update EHT PHY beamforming capability
Date: Thu, 22 Feb 2024 14:42:57 +0800
Message-ID: <20240222064258.59782-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240222064258.59782-1-pkshih@realtek.com>
References: <20240222064258.59782-1-pkshih@realtek.com>
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

Adjust beamforming capabilities to accurately reflect the supported
EHT features by WiFi 7 chip 8922A. It includes 1) Unset EHT CQI
feedback and 16-subcarrier grouping. 2) Correct Beamformee SS value.
3) Enable partial and full bandwidth SU/MU feedback.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index d4bca8cd08f2..d474b8d5df3d 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3801,7 +3801,7 @@ static void rtw89_init_eht_cap(struct rtw89_dev *rtwdev,
 	struct ieee80211_sta_eht_cap *eht_cap;
 	struct rtw89_hal *hal = &rtwdev->hal;
 	bool support_320mhz = false;
-	int sts = 3;
+	int sts = 8;
 	u8 val;
 
 	if (chip->chip_gen == RTW89_CHIP_AX)
@@ -3845,18 +3845,16 @@ static void rtw89_init_eht_cap(struct rtw89_dev *rtwdev,
 	eht_cap_elem->phy_cap_info[2] = 0;
 
 	eht_cap_elem->phy_cap_info[3] =
-		IEEE80211_EHT_PHY_CAP3_NG_16_SU_FEEDBACK |
-		IEEE80211_EHT_PHY_CAP3_NG_16_MU_FEEDBACK |
 		IEEE80211_EHT_PHY_CAP3_CODEBOOK_4_2_SU_FDBK |
 		IEEE80211_EHT_PHY_CAP3_CODEBOOK_7_5_MU_FDBK |
-		IEEE80211_EHT_PHY_CAP3_TRIG_CQI_FDBK;
+		IEEE80211_EHT_PHY_CAP3_TRIG_SU_BF_FDBK |
+		IEEE80211_EHT_PHY_CAP3_TRIG_MU_BF_PART_BW_FDBK;
 
 	eht_cap_elem->phy_cap_info[4] =
 		IEEE80211_EHT_PHY_CAP4_POWER_BOOST_FACT_SUPP |
 		u8_encode_bits(1, IEEE80211_EHT_PHY_CAP4_MAX_NC_MASK);
 
 	eht_cap_elem->phy_cap_info[5] =
-		IEEE80211_EHT_PHY_CAP5_NON_TRIG_CQI_FEEDBACK |
 		u8_encode_bits(IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_20US,
 			       IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_MASK);
 
-- 
2.25.1


