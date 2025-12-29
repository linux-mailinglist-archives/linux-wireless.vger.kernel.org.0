Return-Path: <linux-wireless+bounces-30154-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B81CE5C70
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Dec 2025 04:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B03DF3007620
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Dec 2025 03:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E8A248F73;
	Mon, 29 Dec 2025 03:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="phwi/LPJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58098224F3
	for <linux-wireless@vger.kernel.org>; Mon, 29 Dec 2025 03:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766977823; cv=none; b=lM5X7jd+DFnY6JJ4aVFVxQJbEbOCutoAlhRamag3wbAGdGGG0i6jZ70fYSxBN+jpR8JWjL9BDBNRdtw1PCOoRlO5gK77wNBiH0Kv1Pu564R++ngvWJH3XHD11LTZF5wa4NlsQxLZDMMUuHRm4i35PnVf0vPaaxcDVXrdjrW+MiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766977823; c=relaxed/simple;
	bh=Uz6Fx83wS78Dg7/4W20j0mPokBI5cjH1x9UuW19hxS8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S6CtCAeMBr4pMF+eyie6q3/Lww4MBq/T+FlVMAXrwlsRJeTnSlohPN63PQ9zgPveJ2Z0FW3a1F+pnx6eGo9jpdHVYFHTMofw/3bgRMuIsEEEQIZB09rPfOqR3LFOvAyunM2aduywdV4SvyZ2tM8CNWsIktV5u8blbQBJALqzJtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=phwi/LPJ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BT3AJeqC282909, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766977819; bh=m8ZmLbx/VfrOGXYFUSNQKC45pe6T103UPRd90Y+0b2E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=phwi/LPJDA5ZGMTRSfkBu4PANYn+ArT8VUZhalZryM+BGKW1P/nT9cHSpy1rBhkp2
	 gRvt5I7AX+aG/Vp+61qmveYw6eM2YPzXB9Z8JG1NRcQ99iv3aCbA36q2r4fD1IWcIJ
	 yQNmyB5udC9z5tg/WJUskL07g9KqeezdqTy8KjkANp63x5c+yVM53VwkO7+ABPJNxs
	 xhCnblYkOIzs9V4wIbG+F0ze1IRuawl9G6Q+4z50h72eRTyJkhO/vGjTR0fV0meSA4
	 s4c8xThjBwZhrnAIns/h3UxhyD1xSHF7ZFfpCVp8VzvrL+24ePfV28Ix2GnYGZF0wn
	 RMGHF3ORqA4+g==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BT3AJeqC282909
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Dec 2025 11:10:19 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 29 Dec 2025 11:10:19 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 29 Dec 2025 11:10:19 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <timlee@realtek.com>,
        <dian_syuan0116@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next v2 07/12] wifi: rtw89: read chip ID for RTL8922D variants
Date: Mon, 29 Dec 2025 11:09:21 +0800
Message-ID: <20251229030926.27004-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251229030926.27004-1-pkshih@realtek.com>
References: <20251229030926.27004-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The coming RTL8922D has many kinds of hardware variants. Read chips ID
ahead, so we can configure proper hardware settings accordingly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: add enum reference of AID and CID to comment
---
 drivers/net/wireless/realtek/rtw89/core.c     | 27 ++++++++++++++++---
 drivers/net/wireless/realtek/rtw89/core.h     | 13 +++++++++
 drivers/net/wireless/realtek/rtw89/mac.h      |  2 ++
 drivers/net/wireless/realtek/rtw89/reg.h      |  7 +++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  2 --
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  2 --
 .../wireless/realtek/rtw89/rtw8852b_common.c  |  2 --
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  2 --
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  2 --
 9 files changed, 46 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 51aa3d0eb2ef..78cbfd6677e1 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -6081,7 +6081,9 @@ void rtw89_core_scan_complete(struct rtw89_dev *rtwdev,
 static void rtw89_read_chip_ver(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_hal *hal = &rtwdev->hal;
 	int ret;
+	u8 val2;
 	u8 val;
 	u8 cv;
 
@@ -6093,14 +6095,28 @@ static void rtw89_read_chip_ver(struct rtw89_dev *rtwdev)
 			cv = CHIP_CBV;
 	}
 
-	rtwdev->hal.cv = cv;
+	hal->cv = cv;
 
-	if (rtw89_is_rtl885xb(rtwdev)) {
+	if (rtw89_is_rtl885xb(rtwdev) || chip->chip_gen >= RTW89_CHIP_BE) {
 		ret = rtw89_mac_read_xtal_si(rtwdev, XTAL_SI_CV, &val);
 		if (ret)
 			return;
 
-		rtwdev->hal.acv = u8_get_bits(val, XTAL_SI_ACV_MASK);
+		hal->acv = u8_get_bits(val, XTAL_SI_ACV_MASK);
+	}
+
+	if (chip->chip_gen >= RTW89_CHIP_BE) {
+		hal->cid =
+			rtw89_read32_mask(rtwdev, R_BE_SYS_CHIPINFO, B_BE_HW_ID_MASK);
+
+		ret = rtw89_mac_read_xtal_si(rtwdev, XTAL_SI_CHIP_ID_L, &val);
+		if (ret)
+			return;
+		ret = rtw89_mac_read_xtal_si(rtwdev, XTAL_SI_CHIP_ID_H, &val2);
+		if (ret)
+			return;
+
+		hal->aid = val | val2 << 8;
 	}
 }
 
@@ -6310,6 +6326,8 @@ void rtw89_core_rfkill_poll(struct rtw89_dev *rtwdev, bool force)
 
 int rtw89_chip_info_setup(struct rtw89_dev *rtwdev)
 {
+	struct rtw89_efuse *efuse = &rtwdev->efuse;
+	struct rtw89_hal *hal = &rtwdev->hal;
 	int ret;
 
 	rtw89_read_chip_ver(rtwdev);
@@ -6349,6 +6367,9 @@ int rtw89_chip_info_setup(struct rtw89_dev *rtwdev)
 	rtw89_core_setup_rfe_parms(rtwdev);
 	rtwdev->ps_mode = rtw89_update_ps_mode(rtwdev);
 
+	rtw89_info(rtwdev, "chip info CID: %x, CV: %x, AID: %x, ACV: %x, RFE: %d\n",
+		   hal->cid, hal->cv, hal->aid, hal->acv, efuse->rfe_type);
+
 out:
 	rtw89_mac_pwr_off(rtwdev);
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 8f9c49d2ec5b..6e39894990bf 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -159,6 +159,17 @@ enum rtw89_core_chip_id {
 	RTL8922D,
 };
 
+enum rtw89_core_chip_cid {
+	RTL8922D_CID7025 = 0x74,
+	RTL8922D_CID7090 = 0x79,
+};
+
+enum rtw89_core_chip_aid {
+	RTL8922D_AID1348 = 0x1348,
+	RTL8922D_AID7060 = 0x7060,
+	RTL8922D_AID7102 = 0x7102,
+};
+
 enum rtw89_chip_gen {
 	RTW89_CHIP_AX,
 	RTW89_CHIP_BE,
@@ -5034,7 +5045,9 @@ enum rtw89_dm_type {
 struct rtw89_hal {
 	u32 rx_fltr;
 	u8 cv;
+	u8 cid; /* enum rtw89_core_chip_cid */
 	u8 acv;
+	u16 aid; /* enum rtw89_core_chip_aid */
 	u32 antenna_tx;
 	u32 antenna_rx;
 	u8 tx_nss;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 2f3138b155f9..79755032df2c 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1573,6 +1573,8 @@ enum rtw89_mac_xtal_si_offset {
 	XTAL_SI_APBT = 0xD1,
 	XTAL_SI_PLL = 0xE0,
 	XTAL_SI_PLL_1 = 0xE1,
+	XTAL_SI_CHIP_ID_L = 0xFD,
+	XTAL_SI_CHIP_ID_H = 0xFE,
 };
 
 static inline
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 28ceab7726c6..081623f84dd9 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -4267,6 +4267,13 @@
 #define R_BE_PCIE_MIO_INTD 0x00E8
 #define B_BE_PCIE_MIO_DATA_MASK GENMASK(31, 0)
 
+#define R_BE_SYS_CHIPINFO 0x00FC
+#define B_BE_USB2_SEL BIT(31)
+#define B_BE_U3PHY_RST_V1 BIT(30)
+#define B_BE_U3_TERM_DETECT BIT(29)
+#define B_BE_VERIFY_ENV_MASK GENMASK(9, 8)
+#define B_BE_HW_ID_MASK GENMASK(7, 0)
+
 #define R_BE_HALT_H2C_CTRL 0x0160
 #define B_BE_HALT_H2C_TRIGGER BIT(0)
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 7e97220b723a..e3933946d1ca 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -633,8 +633,6 @@ static int rtw8851b_read_efuse(struct rtw89_dev *rtwdev, u8 *log_map,
 	efuse->rfe_type = map->rfe_type;
 	efuse->xtal_cap = map->xtal_k;
 
-	rtw89_info(rtwdev, "chip rfe_type is %d\n", efuse->rfe_type);
-
 	return 0;
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 58e041016c26..46f5e9c50222 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -678,8 +678,6 @@ static int rtw8852a_read_efuse(struct rtw89_dev *rtwdev, u8 *log_map,
 	efuse->rfe_type = map->rfe_type;
 	efuse->xtal_cap = map->xtal_k;
 
-	rtw89_info(rtwdev, "chip rfe_type is %d\n", efuse->rfe_type);
-
 	return 0;
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
index 4e72f4961837..65b839323e3e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
@@ -265,8 +265,6 @@ static int __rtw8852bx_read_efuse(struct rtw89_dev *rtwdev, u8 *log_map,
 	efuse->rfe_type = map->rfe_type;
 	efuse->xtal_cap = map->xtal_k;
 
-	rtw89_info(rtwdev, "chip rfe_type is %d\n", efuse->rfe_type);
-
 	return 0;
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 2110c714394d..c20c732d2f6a 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -600,8 +600,6 @@ static int rtw8852c_read_efuse(struct rtw89_dev *rtwdev, u8 *log_map,
 	efuse->rfe_type = map->rfe_type;
 	efuse->xtal_cap = map->xtal_k;
 
-	rtw89_info(rtwdev, "chip rfe_type is %d\n", efuse->rfe_type);
-
 	return 0;
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 0383c3bd60dd..795c00d65d5e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -628,8 +628,6 @@ static int rtw8922a_read_efuse_rf(struct rtw89_dev *rtwdev, u8 *log_map)
 	rtw8922a_efuse_parsing_tssi(rtwdev, map);
 	rtw8922a_efuse_parsing_gain_offset(rtwdev, map);
 
-	rtw89_info(rtwdev, "chip rfe_type is %d\n", efuse->rfe_type);
-
 	return 0;
 }
 
-- 
2.25.1


