Return-Path: <linux-wireless+bounces-29018-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6237BC623E7
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 04:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 434024E1333
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 03:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0006823D7C5;
	Mon, 17 Nov 2025 03:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="QkaHsP2I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9833A313E25
	for <linux-wireless@vger.kernel.org>; Mon, 17 Nov 2025 03:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763350212; cv=none; b=MPqYzlPC705Pxm8ycCEZy2fNtbd2+FCHFhNsZF+myNROS84mAkSU4RcMeI9WmE+fTrk+VvFsGkhmQUbITHYeEJKKlZRRhnqVcDe5F99uq2noDRcxdT2zCad+bFNW+V0U7mleZkdfTmu/Em5Zkm+85PMTSghz68r2n04ADGylg20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763350212; c=relaxed/simple;
	bh=RfVaflTyae87KeEcYA9aN5k3D4q5UaAOEYf/S0765J4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ShvEV4pdpDqX85ttaFSCTkcXhJpdhM+IxRLWDZHFzPgB3qUvR9y4CGpeahuWBfdEsO1pKdkd2T4dC+P00+EHLGjNbY1uFzrXqxpDBLpz1biqgOiCfWI4ziOyZaQO++/87g+CxP7IkcmHNepnXQ5jke6W4mBxlTD2vcWysGp7o4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=QkaHsP2I; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AH3Tx2mA2763595, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763350199; bh=VzhXkUuL8df6Gj9dJVhLdS6zmhS5OQIYku6cJQMi634=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=QkaHsP2IrKBNdAfuwh/FpDfieaUE3Va1xwr53S5OwWRj8UHXCxs6mzCjnFyLmsm8f
	 EuRAp/gBHIiF0o7YvU7w/SPnq3dfEYR4pDtHBLMt81ZTv1Bne8lyBf7BSvcHaeU12a
	 6ss6Va/6qU8/76E4nvxbUdMnScs+uPpmsekM+u0lMTKNQBI2diOdj8h2bqOW93jycl
	 5jmQgHChBVHE92+ZxxcWSiX6E/xlCiZwN+TPeLNuTCVerZkV2jWgjvEq2gZ3wrfD/G
	 8TDmLPe6rtulc3OyG9gyaxPMRBxUNTWKZBd0LrIkPVykUdJEBPGUWxw0DVQsDBolSu
	 GXxMc2jaEB71A==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AH3Tx2mA2763595
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 11:29:59 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 17 Nov 2025 11:30:00 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Mon, 17 Nov 2025 11:30:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <geert@linux-m68k.org>
Subject: [PATCH rtw-next 2/2] wifi: rtw89: avoid to use not consecutive mask in __write_ctrl()
Date: Mon, 17 Nov 2025 11:29:10 +0800
Message-ID: <20251117032910.11224-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251117032910.11224-1-pkshih@realtek.com>
References: <20251117032910.11224-1-pkshih@realtek.com>
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
 drivers/net/wireless/realtek/rtw89/mac.h      | 20 ++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 26 +++++--------------
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 26 +++++--------------
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 26 +++++--------------
 4 files changed, 41 insertions(+), 57 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 3cc97fd0c0ec..01a9fb7c9e31 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1456,6 +1456,26 @@ static inline int rtw89_mac_txpwr_write32_mask(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
+static inline
+void rtw89_mac_write_txpwr_ctrl(struct rtw89_dev *rtwdev, u32 reg, u32 mask, u32 val,
+				u32 mask_en, bool cond)
+{
+	u32 wrt = u32_encode_bits(val, mask);
+	u32 val32;
+	int ret;
+
+	if (cond)
+		wrt |= mask_en;
+
+	ret = rtw89_mac_txpwr_read32(rtwdev, RTW89_PHY_0, reg, &val32);
+	if (ret)
+		return;
+
+	val32 &= ~(mask | mask_en);
+	val32 |= wrt;
+	rtw89_mac_txpwr_write32(rtwdev, RTW89_PHY_0, reg, val32);
+}
+
 static inline void rtw89_mac_ctrl_hci_dma_tx(struct rtw89_dev *rtwdev,
 					     bool enable)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 2019f6022cbb..1253c4af2fb2 100644
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
index 38cd151f8c3f..de02d52150c1 100644
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
index ee81a6792eee..7fd1485d1eb7 100644
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


