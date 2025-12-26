Return-Path: <linux-wireless+bounces-30124-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 878E2CDE602
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Dec 2025 07:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 509FE3011A4A
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Dec 2025 06:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE274135A53;
	Fri, 26 Dec 2025 06:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Rp5E/1OR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99C71E1E00
	for <linux-wireless@vger.kernel.org>; Fri, 26 Dec 2025 06:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766729741; cv=none; b=H16iFT5J97ID7n9EXcM7spkNccrcD1+UnOiNvIuG3ZWFFN/LD1PxvC15Qro70s39RCrjEQsLVRQa51rHFSXmSQkspxLTafF8TfMPrM7BFeXABo6bG0df2Z7sGC+kRpBtFIS4SeNZ3N9QxVmo1vWj4Pk/LQNx3M3ZA+YhNVfgEUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766729741; c=relaxed/simple;
	bh=tMAuOQR5GXxUSIIk+kOEf733hCKiiv/QyDKlpZz37v8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CtfE+36I+8KVdFhbLI3Y8lIoN56ObdSkviv5hCf+jsfT1t3F/WZjHVAnr4bQAjFsA3S+Wxw2oh+ERCizXTb8Fu1mMjdRE0Em+NT5GJBRy64ZWAy4bS49MD+tFCGJzkaqtZBcptwAq5LRtDDIeD4r4QIR9pzKUQjNxGqmMaARON8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Rp5E/1OR; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BQ6FbzkE3113599, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766729737; bh=6KqV5ftVBg6ZQCCT6oIMveLCrntcuhT7ZckKmLkM2fQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Rp5E/1ORCsdzDQYo598pNfeEemRKVIEZjN5H8XOWSLywduVgw8yXQYVxwQGloZKlP
	 eR60oBx6uH6fkiuZJKgtDWUceSed5ikf/r3gCOaDuN4oryMYACzxBCmEzy5cr1FjK1
	 f3faL1YIjtXvXeZL/sHyIlcJDGwHpNiJtvbhIMsZYNFE0fTC4G3nNvA+5xT6XqNiiF
	 2L+GpwdLHRLs8cGoEvnAJkVCu/9sSF2wPWmNSwUQS66z4LsMdlhRAOrk4OEVkFW64A
	 mO55P6UmmaIXhlyI8xqtOgnwJvkP9VlwmxjWzkuFXYOef31YbR3GhKqUkTU34RpMEI
	 up/h8BHgftHKQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BQ6FbzkE3113599
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 26 Dec 2025 14:15:37 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 26 Dec 2025 14:15:37 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 26 Dec 2025 14:15:37 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 26 Dec 2025 14:15:37 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <timlee@realtek.com>,
        <dian_syuan0116@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 07/12] wifi: rtw89: read chip ID for RTL8922D variants
Date: Fri, 26 Dec 2025 14:14:41 +0800
Message-ID: <20251226061446.63514-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251226061446.63514-1-pkshih@realtek.com>
References: <20251226061446.63514-1-pkshih@realtek.com>
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
index 8f9c49d2ec5b..70bb044a9d35 100644
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
+	u8 cid;
 	u8 acv;
+	u16 aid;
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


