Return-Path: <linux-wireless+bounces-3319-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D9B84D7CD
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 03:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAEA7287132
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 02:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B0E20325;
	Thu,  8 Feb 2024 02:30:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19041E897
	for <linux-wireless@vger.kernel.org>; Thu,  8 Feb 2024 02:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707359423; cv=none; b=AWeJEiBoyn8M5QdRXIxPJotWtQEO3gi6PtX5mX3X7e6lrf+ZhZWK+XISNZX4+6aO8uEw96vyIO8Es/cWyNyGReQ+pwqtPOe6fqWdTl1zXDBlSBGv0srrZA0aJU29I9ydvvaGbbiny+BcLIGqN5kx5G1oW5Hs3+gK/JGmSGcBoOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707359423; c=relaxed/simple;
	bh=66lXwcibHzZayG4J8SABxxpqV/qiw6kZGGIqA3nXMM0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uPBU+/SNVh8JnxRT/8ME/mDDfREgg5Get6dcDCx8i4lcK/JS5Jsj2PfiKq4lyHVAOqBnpz2IURrFsagetDJKyeutUHPH+mwisRyALwMXc5IOujfAIfWwbm/q0YUHvEXEx+u2XfRrbbH+y5Lx9UyNqBhgsuB5mCc33l0YJTJsI6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4182UGKX0192096, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4182UGKX0192096
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Feb 2024 10:30:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Thu, 8 Feb 2024 10:30:17 +0800
Received: from [127.0.1.1] (172.16.17.45) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 8 Feb
 2024 10:30:16 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <gary.chang@realtek.com>, <phhuang@realtek.com>, <kevin_yang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 07/11] wifi: rtw89: differentiate narrow_bw_ru_dis setting according to chip gen
Date: Thu, 8 Feb 2024 10:28:53 +0800
Message-ID: <20240208022857.14379-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240208022857.14379-1-pkshih@realtek.com>
References: <20240208022857.14379-1-pkshih@realtek.com>
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


