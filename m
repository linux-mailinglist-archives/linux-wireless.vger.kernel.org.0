Return-Path: <linux-wireless+bounces-29139-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3F5C71EFC
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 04:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C0C594E04CB
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 03:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403EF2F90CD;
	Thu, 20 Nov 2025 03:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="uPFPXv2/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2ED2FD7C7
	for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 03:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763608304; cv=none; b=E+UCwQyzuaScesnkEry7JYKtS3aF8SK19/JDAvtDCVZvqinljOJlfcQdYq1/4nO2iIMPyegQN9QwCR7FvCPh+u4zESvWfl+bfEHnlnH4YSJWNfkZqY7Ej0eOCpNxaoEha61/qih+YcXDRIeXNhRHqCF9SAWrbN3mBO28mRfWqoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763608304; c=relaxed/simple;
	bh=Or59EsMDY19aZCa9b6n+OeI+SUOOMmgvptGBuSjnLSw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=toCbECcFKIYFwtaYXOiUsFQ8lSxbB0IfuEBYxnlm+xQl7CyBNjU+oru/EsnLpQ52wXbzwf3ItdPv1NzB5K2nUZVrHBhv8XtO/WOhmaBd0qyDUVVQvtFGObqQL9RWdLcQuGa1T+GfGlul+fdSownWdQHcBN6i3qbQYNrX/gMRm+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=uPFPXv2/; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AK3BaaM6696591, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763608296; bh=2B9UC4jF1/EyJcbCmm87vx8VVnWmVvr6/GM/Rin+UoY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=uPFPXv2/PN1LoTv7TGKxEJmDcAhK6V/gj8wuXpIRAlNVqURA0M2bGd1PfHgMiNOaj
	 /3xdW/vA+SkVoHBxAX4tG1aBK/KogSTz1hP70MeNhNgMvDnDGVZZRjeno07TzmVQok
	 quxnp0DelwiRq/3ZajReaJJgSrPHfqtc9l/jyYwutoQNchNEzSTHCanjZh1mIOqnCk
	 qnvJzfZl5k6c5me0GVWsYedFMKJO5G9MXCpHGsigPTfP8R6v0BDEldS0G+hM5+XoNQ
	 Rgbi/lVvOhRoQ96emlo3czI9LdfGjxZ7Rd+7GRS/n5Gxv7VhCA5O/qPrqzh5Aj4ZPs
	 KzQi7niQvn6sg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AK3BaaM6696591
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 11:11:36 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 20 Nov 2025 11:11:36 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Thu, 20 Nov 2025 11:11:36 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <geert@linux-m68k.org>
Subject: [PATCH v2 rtw-next 2/2] wifi: rtw89: avoid to use not consecutive mask in __write_ctrl()
Date: Thu, 20 Nov 2025 11:10:44 +0800
Message-ID: <20251120031044.12493-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251120031044.12493-1-pkshih@realtek.com>
References: <20251120031044.12493-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The power value and enable bit fields can be not consecutive mask, but
normally we expect mask argument of rtw89_mac_txpwr_write32_mask() is
consecutive bit mask. Therefore, change the code accordingly.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: use a macro to use u32_encode_bits() to generate mask before calling         
    inline function to prevent __bad_mask() warning.  
---
 drivers/net/wireless/realtek/rtw89/mac.h      | 26 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 26 +++++--------------
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 26 +++++--------------
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 26 +++++--------------
 4 files changed, 47 insertions(+), 57 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 0007229d6753..64a7fd527f3e 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1458,6 +1458,32 @@ static inline int rtw89_mac_txpwr_write32_mask(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
+static inline
+void __rtw89_mac_write_txpwr_ctrl(struct rtw89_dev *rtwdev, u32 reg, u32 mask,
+				  u32 set, u32 mask_en, bool cond)
+{
+	u32 val32;
+	int ret;
+
+	ret = rtw89_mac_txpwr_read32(rtwdev, RTW89_PHY_0, reg, &val32);
+	if (ret)
+		return;
+
+	val32 &= ~(mask | mask_en);
+	val32 |= set;
+
+	if (cond)
+		val32 |= mask_en;
+
+	rtw89_mac_txpwr_write32(rtwdev, RTW89_PHY_0, reg, val32);
+}
+
+#define rtw89_mac_write_txpwr_ctrl(_rtwdev, _reg, _mask, _val, _mask_en, _cond)    \
+do {										   \
+	u32 _set = u32_encode_bits(_val, _mask);				   \
+	__rtw89_mac_write_txpwr_ctrl(_rtwdev, _reg, _mask, _set, _mask_en, _cond); \
+} while (0)
+
 static inline void rtw89_mac_ctrl_hci_dma_tx(struct rtw89_dev *rtwdev,
 					     bool enable)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 84b628d23882..7134b88ccf76 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2291,18 +2291,6 @@ rtw8851b_btc_set_wl_txpwr_ctrl(struct rtw89_dev *rtwdev, u32 txpwr_val)
 	union rtw8851b_btc_wl_txpwr_ctrl arg = { .txpwr_val = txpwr_val };
 	s32 val;
 
-#define __write_ctrl(_reg, _msk, _val, _en, _cond)		\
-do {								\
-	u32 _wrt = FIELD_PREP(_msk, _val);			\
-	BUILD_BUG_ON(!!(_msk & _en));				\
-	if (_cond)						\
-		_wrt |= _en;					\
-	else							\
-		_wrt &= ~_en;					\
-	rtw89_mac_txpwr_write32_mask(rtwdev, RTW89_PHY_0, _reg,	\
-				     _msk | _en, _wrt);		\
-} while (0)
-
 	switch (arg.ctrl_all_time) {
 	case 0xffff:
 		val = 0;
@@ -2312,9 +2300,10 @@ do {								\
 		break;
 	}
 
-	__write_ctrl(R_AX_PWR_RATE_CTRL, B_AX_FORCE_PWR_BY_RATE_VALUE_MASK,
-		     val, B_AX_FORCE_PWR_BY_RATE_EN,
-		     arg.ctrl_all_time != 0xffff);
+	rtw89_mac_write_txpwr_ctrl(rtwdev, R_AX_PWR_RATE_CTRL,
+				   B_AX_FORCE_PWR_BY_RATE_VALUE_MASK,
+				   val, B_AX_FORCE_PWR_BY_RATE_EN,
+				   arg.ctrl_all_time != 0xffff);
 
 	switch (arg.ctrl_gnt_bt) {
 	case 0xffff:
@@ -2325,10 +2314,9 @@ do {								\
 		break;
 	}
 
-	__write_ctrl(R_AX_PWR_COEXT_CTRL, B_AX_TXAGC_BT_MASK, val,
-		     B_AX_TXAGC_BT_EN, arg.ctrl_gnt_bt != 0xffff);
-
-#undef __write_ctrl
+	rtw89_mac_write_txpwr_ctrl(rtwdev, R_AX_PWR_COEXT_CTRL,
+				   B_AX_TXAGC_BT_MASK, val,
+				   B_AX_TXAGC_BT_EN, arg.ctrl_gnt_bt != 0xffff);
 }
 
 static
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 70fb05bc5e98..f88af57fac65 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -761,18 +761,6 @@ rtw8852b_btc_set_wl_txpwr_ctrl(struct rtw89_dev *rtwdev, u32 txpwr_val)
 	union rtw8852b_btc_wl_txpwr_ctrl arg = { .txpwr_val = txpwr_val };
 	s32 val;
 
-#define __write_ctrl(_reg, _msk, _val, _en, _cond)		\
-do {								\
-	u32 _wrt = FIELD_PREP(_msk, _val);			\
-	BUILD_BUG_ON(!!(_msk & _en));				\
-	if (_cond)						\
-		_wrt |= _en;					\
-	else							\
-		_wrt &= ~_en;					\
-	rtw89_mac_txpwr_write32_mask(rtwdev, RTW89_PHY_0, _reg,	\
-				     _msk | _en, _wrt);		\
-} while (0)
-
 	switch (arg.ctrl_all_time) {
 	case 0xffff:
 		val = 0;
@@ -782,9 +770,10 @@ do {								\
 		break;
 	}
 
-	__write_ctrl(R_AX_PWR_RATE_CTRL, B_AX_FORCE_PWR_BY_RATE_VALUE_MASK,
-		     val, B_AX_FORCE_PWR_BY_RATE_EN,
-		     arg.ctrl_all_time != 0xffff);
+	rtw89_mac_write_txpwr_ctrl(rtwdev, R_AX_PWR_RATE_CTRL,
+				   B_AX_FORCE_PWR_BY_RATE_VALUE_MASK,
+				   val, B_AX_FORCE_PWR_BY_RATE_EN,
+				   arg.ctrl_all_time != 0xffff);
 
 	switch (arg.ctrl_gnt_bt) {
 	case 0xffff:
@@ -795,10 +784,9 @@ do {								\
 		break;
 	}
 
-	__write_ctrl(R_AX_PWR_COEXT_CTRL, B_AX_TXAGC_BT_MASK, val,
-		     B_AX_TXAGC_BT_EN, arg.ctrl_gnt_bt != 0xffff);
-
-#undef __write_ctrl
+	rtw89_mac_write_txpwr_ctrl(rtwdev, R_AX_PWR_COEXT_CTRL,
+				   B_AX_TXAGC_BT_MASK, val,
+				   B_AX_TXAGC_BT_EN, arg.ctrl_gnt_bt != 0xffff);
 }
 
 static const struct rtw89_chip_ops rtw8852b_chip_ops = {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index db99450e9158..d2a91232ea27 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2760,18 +2760,6 @@ rtw8852c_btc_set_wl_txpwr_ctrl(struct rtw89_dev *rtwdev, u32 txpwr_val)
 	union rtw8852c_btc_wl_txpwr_ctrl arg = { .txpwr_val = txpwr_val };
 	s32 val;
 
-#define __write_ctrl(_reg, _msk, _val, _en, _cond)		\
-do {								\
-	u32 _wrt = FIELD_PREP(_msk, _val);			\
-	BUILD_BUG_ON((_msk & _en) != 0);			\
-	if (_cond)						\
-		_wrt |= _en;					\
-	else							\
-		_wrt &= ~_en;					\
-	rtw89_mac_txpwr_write32_mask(rtwdev, RTW89_PHY_0, _reg,	\
-				     _msk | _en, _wrt);		\
-} while (0)
-
 	switch (arg.ctrl_all_time) {
 	case 0xffff:
 		val = 0;
@@ -2781,9 +2769,10 @@ do {								\
 		break;
 	}
 
-	__write_ctrl(R_AX_PWR_RATE_CTRL, B_AX_FORCE_PWR_BY_RATE_VALUE_MASK,
-		     val, B_AX_FORCE_PWR_BY_RATE_EN,
-		     arg.ctrl_all_time != 0xffff);
+	rtw89_mac_write_txpwr_ctrl(rtwdev, R_AX_PWR_RATE_CTRL,
+				   B_AX_FORCE_PWR_BY_RATE_VALUE_MASK,
+				   val, B_AX_FORCE_PWR_BY_RATE_EN,
+				   arg.ctrl_all_time != 0xffff);
 
 	switch (arg.ctrl_gnt_bt) {
 	case 0xffff:
@@ -2794,10 +2783,9 @@ do {								\
 		break;
 	}
 
-	__write_ctrl(R_AX_PWR_COEXT_CTRL, B_AX_TXAGC_BT_MASK, val,
-		     B_AX_TXAGC_BT_EN, arg.ctrl_gnt_bt != 0xffff);
-
-#undef __write_ctrl
+	rtw89_mac_write_txpwr_ctrl(rtwdev, R_AX_PWR_COEXT_CTRL,
+				   B_AX_TXAGC_BT_MASK, val,
+				   B_AX_TXAGC_BT_EN, arg.ctrl_gnt_bt != 0xffff);
 }
 
 static
-- 
2.25.1


