Return-Path: <linux-wireless+bounces-28823-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 484E4C4B34E
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 03:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22C301892F17
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 02:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9DF347FCC;
	Tue, 11 Nov 2025 02:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="S2UyB7dT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EB72BCF43
	for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 02:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762827951; cv=none; b=oUf/vbI2j5fn1LLbQwt5sPRcR+J35mZq7kn5wNztrcwVj5SL84SX/8Z0IsCGeomdNZw+qVVaDCyyDp8Wl1QrSvqqF/kFWABeRrsCNAjnO8jwgKnLmLeT9VWjtm3MBdVX8GYUHZi0Ier0I07CUhxXo1g0yVNm0y+y/3UKgNRY2UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762827951; c=relaxed/simple;
	bh=JhDzMg8jV3Wlj8KboulP1+jqFbIXYxq3lJAQzZepNeY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cwc5flZK3vnrLACL03XQGLP27AXppgJ4yd6nSoYxDRiueAsOpLtXBTwPTlUpxAgz0kj1w0KlS+oQA52eDItap8kRGQxG8o7ZEz6ili/1+AjFV3GrhyinEbBDHSm82QDl+BRQPoJ1JNjYfr8RQeg/pjlX8SCza8+rDk429l5jxBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=S2UyB7dT; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AB2PkThA2922207, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762827946; bh=H2pG+602ANVwxv87YRtx4/mW3FXV87bLSX0BhEHZd7U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=S2UyB7dTQ5JfXhfh9i7XjsRBED8gc4AlGGo9NNmpYR4a5aYUnx6Vw4aAshxoLbnfX
	 t/dFqiG6MxDVW2mEZEeEiIES2gLVqmJpJVwWfFPg0uv4qCrBN7pz8pusKh+UU9kmQr
	 gruHn5PDoJVDw/ZofcoGnhrz9GjWDs7uA8pC6V79fcEcN/4qH0N+DSJaJQVRnlCBFx
	 EXfxTXhNRfjkF9UZzIIQFBkl6oLC4H2kmV5rkrlMdjO8Tths2RXPgvaideIFg3kDhZ
	 S+6bLd435GRqf16OLL0RW90UAj1nAXurFZBah9KJOQsg40F1D/WO3cwntbDjW7wYFl
	 xnvyMIOUDY21Q==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AB2PkThA2922207
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 10:25:46 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 11 Nov 2025 10:25:47 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 11 Nov 2025 10:25:46 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Tue, 11 Nov 2025 10:25:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>
Subject: [PATCH v2 rtw-next 4/8] wifi: rtw89: 8852c: add compensation of thermal value from efuse calibration
Date: Tue, 11 Nov 2025 10:24:48 +0800
Message-ID: <20251111022452.28093-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251111022452.28093-1-pkshih@realtek.com>
References: <20251111022452.28093-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The 3th bit of thermal value programmed in efuse means 8 (2 ^ 3) grams.
Check the bit and signed bit, and add compensation to final thermal.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 27 +++++++++++++++----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 8550ae3bcb64..6be56c2fa0c7 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -670,12 +670,16 @@ static void rtw8852c_phycap_parsing_thermal_trim(struct rtw89_dev *rtwdev,
 	}
 }
 
+#define __THM_MASK_SIGN BIT(0)
+#define __THM_MASK_3BITS GENMASK(3, 1)
+#define __THM_MASK_VAL8 BIT(4)
+
 static void rtw8852c_thermal_trim(struct rtw89_dev *rtwdev)
 {
-#define __thm_setting(raw)				\
-({							\
-	u8 __v = (raw);					\
-	((__v & 0x1) << 3) | ((__v & 0x1f) >> 1);	\
+#define __thm_setting(raw)						  \
+({									  \
+	u8 __v = (raw);							  \
+	((__v & __THM_MASK_SIGN) << 3) | ((__v & __THM_MASK_3BITS) >> 1); \
 })
 	struct rtw89_power_trim_info *info = &rtwdev->pwr_trim;
 	u8 i, val;
@@ -2516,13 +2520,26 @@ static void rtw8852c_bb_cfg_txrx_path(struct rtw89_dev *rtwdev)
 
 static u8 rtw8852c_get_thermal(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path)
 {
+	struct rtw89_power_trim_info *info = &rtwdev->pwr_trim;
+	s8 comp = 0;
+	u8 val;
+
 	rtw89_write_rf(rtwdev, rf_path, RR_TM, RR_TM_TRI, 0x1);
 	rtw89_write_rf(rtwdev, rf_path, RR_TM, RR_TM_TRI, 0x0);
 	rtw89_write_rf(rtwdev, rf_path, RR_TM, RR_TM_TRI, 0x1);
 
 	fsleep(200);
 
-	return rtw89_read_rf(rtwdev, rf_path, RR_TM, RR_TM_VAL);
+	val = rtw89_read_rf(rtwdev, rf_path, RR_TM, RR_TM_VAL);
+
+	if (info->pg_thermal_trim) {
+		u8 trim = info->thermal_trim[rf_path];
+
+		if (trim & __THM_MASK_VAL8)
+			comp = 8 * (trim & __THM_MASK_SIGN ? -1 : 1);
+	}
+
+	return val + comp;
 }
 
 static void rtw8852c_btc_set_rfe(struct rtw89_dev *rtwdev)
-- 
2.25.1


