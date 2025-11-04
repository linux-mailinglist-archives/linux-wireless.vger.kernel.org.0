Return-Path: <linux-wireless+bounces-28526-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C164DC3036C
	for <lists+linux-wireless@lfdr.de>; Tue, 04 Nov 2025 10:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C4123B39D4
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Nov 2025 09:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C283126A4;
	Tue,  4 Nov 2025 09:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="TOXIq4UZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8780F3126A8
	for <linux-wireless@vger.kernel.org>; Tue,  4 Nov 2025 09:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762247470; cv=none; b=Wt/cARlnpuBpOzCRg3mBQ+DDmnMxi7gaNIorXcPlhZr3X5kARZWzcWwWmIpgyG1mpwIBDjya9TNNQK6oRlEmOKCCp3Y44tRf6pVxlgpCEV+c7rMvf71nlm3BdRJyVCKA9xcXfsBmO13R4Z2sUdFZ18hgFU90CXXNs5LbAbLKpBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762247470; c=relaxed/simple;
	bh=z3Me+3iiZVhNeiVmRsqnVXczlVxuR2D4k2wpbPRsEJ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iqrz9TydPQI/e/5wJRtcpT3UrkBftupkrT8YHhdzUgbLaNCdb0OKanKgCilkAPPPVBVIpLXWx9IPAF2dMeFrk6xY4cOGEVhvUkxmIszS+V6Z8u7eFF6pRMxd2eSqnrT/2Y0UAt1oHYfki+ZIPc+WPYoBzWXFlbHzhuWD+WFk9qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=TOXIq4UZ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5A49B4wW43073467, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762247465; bh=M2idH3I1Mhv5e1XKZRwDaIgvxcSAY5iZFS1yc21LI7M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=TOXIq4UZEm2RDRBPoJ1kJIWt10ypyPBq9juwld5rp9Q+irYuhxOgUC/GpDg7Mvcb7
	 GlLg15Ton/gFMirCzcRjJse2Ox4anyfBdhLovSyNEv/kq2XrtpvIII26J8nZ40vojr
	 Fw89+BV8xF/dpqByT3vRc2RrFtj5juKX2RxlkWt8Cf+RoziFGbX6zms2rKhjIB0sfB
	 o4rnnhwIHXK+zFGwcoDUyMi3CNJ3N5wRy7ommr3EkrlEGUJ1X3u2Ay3l8eDIE3MgUr
	 dEPLqVu1AP6O5ToF3RjJ9X8U2K+n4sPqmtYmmNrCalHSYOsh3ooe2CR4MmGzIhDtHf
	 YNHtSSf1PIjxA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5A49B4wW43073467
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 4 Nov 2025 17:11:05 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 4 Nov 2025 17:11:05 +0800
Received: from [127.0.1.1] (172.21.146.58) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Tue, 4 Nov 2025 17:11:05 +0800
From: <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>
Subject: [PATCH rtw-next 4/8] wifi: rtw89: 8852c: add compensation of thermal value from efuse calibration
Date: Tue, 4 Nov 2025 17:14:09 +0800
Message-ID: <1762247653-26864-5-git-send-email-pkshih@realtek.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1762247653-26864-1-git-send-email-pkshih@realtek.com>
References: <1762247653-26864-1-git-send-email-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Ping-Ke Shih <pkshih@realtek.com>

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


