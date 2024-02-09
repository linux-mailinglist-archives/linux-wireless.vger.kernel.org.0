Return-Path: <linux-wireless+bounces-3376-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 844AB84F073
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 07:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2489AB2922F
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 06:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9041D657B0;
	Fri,  9 Feb 2024 06:53:55 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE21657AB
	for <linux-wireless@vger.kernel.org>; Fri,  9 Feb 2024 06:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707461635; cv=none; b=twD4dx62qJ90ekDb10z9vMCkHyvnUbm6PKLxYLI5D4Rj7+ooT914JgJh1YVQEQTxgmo+OJUJniqLmu/yppzcAe7SdAgse1T4ur25X6amjFUvgrYSgBG4BrCBJs8VrCc0HGai/Lwj9AIwiRjGp4R3vuMcYiKYu3o4MW/6cv0CklY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707461635; c=relaxed/simple;
	bh=66lXwcibHzZayG4J8SABxxpqV/qiw6kZGGIqA3nXMM0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m/5flYYCRWuuOt4Uun2X+u45BNFWFv7wWHOaxu6f3MF+nv9PD5lkhVq7PRGvP4S0qxBpHmFxF4Q8RwC+LxQiCyO3xEQ9xJMgNuC5DJhbFzdYMmtBm+8Wp5SqbpO8bWtAi1rlvYOMsVledXOS9OUEdUW1zDYBM7GXSrW+U+8OKP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4196rmavF548409, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4196rmavF548409
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Feb 2024 14:53:48 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Fri, 9 Feb 2024 14:53:48 +0800
Received: from [127.0.1.1] (172.16.16.210) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 9 Feb
 2024 14:53:48 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <gary.chang@realtek.com>, <phhuang@realtek.com>, <kevin_yang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 07/11] wifi: rtw89: differentiate narrow_bw_ru_dis setting according to chip gen
Date: Fri, 9 Feb 2024 14:52:25 +0800
Message-ID: <20240209065229.34515-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240209065229.34515-1-pkshih@realtek.com>
References: <20240209065229.34515-1-pkshih@realtek.com>
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

When there are OBSS that cannot interpret 26-tone RU transmissions,
we should disable 26-tone RU HE TB PPDU transmissions. So, add registers
accordingly.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c    | 12 +++++++++---
 drivers/net/wireless/realtek/rtw89/mac.h    |  1 +
 drivers/net/wireless/realtek/rtw89/mac_be.c |  4 ++++
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 44d5195437de..16690295b73e 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4619,6 +4619,7 @@ void rtw89_mac_set_he_obss_narrow_bw_ru(struct rtw89_dev *rtwdev,
 					struct ieee80211_vif *vif)
 {
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	struct ieee80211_hw *hw = rtwdev->hw;
 	bool tolerated = true;
 	u32 reg;
@@ -4633,11 +4634,12 @@ void rtw89_mac_set_he_obss_narrow_bw_ru(struct rtw89_dev *rtwdev,
 			  rtw89_mac_check_he_obss_narrow_bw_ru_iter,
 			  &tolerated);
 
-	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_RXTRIG_TEST_USER_2, rtwvif->mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, mac->narrow_bw_ru_dis.addr,
+				   rtwvif->mac_idx);
 	if (tolerated)
-		rtw89_write32_clr(rtwdev, reg, B_AX_RXTRIG_RU26_DIS);
+		rtw89_write32_clr(rtwdev, reg, mac->narrow_bw_ru_dis.mask);
 	else
-		rtw89_write32_set(rtwdev, reg, B_AX_RXTRIG_RU26_DIS);
+		rtw89_write32_set(rtwdev, reg, mac->narrow_bw_ru_dis.mask);
 }
 
 void rtw89_mac_stop_ap(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
@@ -6206,6 +6208,10 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
 		.mask = B_AX_BFMEE_HT_NDPA_EN | B_AX_BFMEE_VHT_NDPA_EN |
 			B_AX_BFMEE_HE_NDPA_EN,
 	},
+	.narrow_bw_ru_dis = {
+		.addr = R_AX_RXTRIG_TEST_USER_2,
+		.mask = B_AX_RXTRIG_RU26_DIS,
+	},
 
 	.check_mac_en = rtw89_mac_check_mac_en_ax,
 	.sys_init = sys_init_ax,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index b0a3b2a9eb5b..c5ebac1d5990 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -898,6 +898,7 @@ struct rtw89_mac_gen_def {
 
 	struct rtw89_reg_def muedca_ctrl;
 	struct rtw89_reg_def bfee_ctrl;
+	struct rtw89_reg_def narrow_bw_ru_dis;
 
 	int (*check_mac_en)(struct rtw89_dev *rtwdev, u8 band,
 			    enum rtw89_mac_hwmod_sel sel);
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index f4b51183e3f4..6388c56a3c90 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -2400,6 +2400,10 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 		.mask = B_BE_BFMEE_HT_NDPA_EN | B_BE_BFMEE_VHT_NDPA_EN |
 			B_BE_BFMEE_HE_NDPA_EN | B_BE_BFMEE_EHT_NDPA_EN,
 	},
+	.narrow_bw_ru_dis = {
+		.addr = R_BE_RXTRIG_TEST_USER_2,
+		.mask = B_BE_RXTRIG_RU26_DIS,
+	},
 
 	.check_mac_en = rtw89_mac_check_mac_en_be,
 	.sys_init = sys_init_be,
-- 
2.25.1


