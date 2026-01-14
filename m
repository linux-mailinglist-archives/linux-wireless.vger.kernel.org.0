Return-Path: <linux-wireless+bounces-30794-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D75F9D1BF6A
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 02:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6F61300908A
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 01:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7759D2874E1;
	Wed, 14 Jan 2026 01:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="CdmOY1BX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C697717A303
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 01:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768354834; cv=none; b=CpyO92f7Bq76TtRvWVrhb0sj6dKTPXuSmrPCJvCxtfpWfVaePDvyuH4Vym8dOw08quRtwm5s1iwcf92YRXFns35Dip5khuUGqwCFzMp8MIQ3XAVMy0dyMMfZe4TOYk6EjtYJVMnXT5G4m6pRT7yFxm7WDZZ3GTXVgG4MzueOcbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768354834; c=relaxed/simple;
	bh=Ije/Cy09AaMM/pOgpNM0fkiPs+8zNsK1eBryQEYkN94=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sj3OLfLQo42niRuns9EFlC3RcjX1B6ihTIWHVCiCZrERfktc+8qJVTMi0zL6EkAgpF+S7mepv9BaNRAnpEnXweO02jiKWiAOW3MpRE5NFHYjmXxsBaPQ+rat6Zk4c9gT2d1xzcmaSx85Q8/oDyd1h6l6U4VkmDvrHYaLiopXKeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=CdmOY1BX; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60E1eTgZ54168550, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768354829; bh=0E+q6LapjQ1ZIaEmmi0rF9Su6eWRpBYlqsjZrObojes=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=CdmOY1BXh4UQAI50YFWE50gMCs/LSiT6H9gM53XQEjfUjBp6/XlxrwfZdIeesKwkr
	 3AAz62K+T55ct820+RkEWDy+KjAZHtl8aNfUMbzL5x8w/2qvlD5kbXwMqKQ2BQcdG4
	 Lt5iNL0gBdPnwHoDYVC0wzIX8x9g38ECheb6whXTre/JR1O32Xwc3F774FTjJcOCZN
	 2DgyJffWVKzItId7jAgXNC+R8sHaAIoT5sOWwmWcUOlEARmBoYE1WDb0k5lPREfhaD
	 PVTei/95m+JdZSw3NKlopDzrjqwT7NSMOS3H8Kpu8Xn2uV8pbdriL89iMgDCHhyN4U
	 naMYkfK5l1IHg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60E1eTgZ54168550
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 09:40:29 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 14 Jan 2026 09:40:31 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 14 Jan 2026 09:40:30 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 14 Jan 2026 09:40:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <echuang@realtek.com>, <phhuang@realtek.com>
Subject: [PATCH rtw-next 02/12] wifi: rtw89: phy: add {read,write}_rf_v3 for RTL8922D
Date: Wed, 14 Jan 2026 09:39:40 +0800
Message-ID: <20260114013950.19704-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260114013950.19704-1-pkshih@realtek.com>
References: <20260114013950.19704-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Implement to access RF registers for RTL8922D.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c | 122 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/phy.h |   4 +
 drivers/net/wireless/realtek/rtw89/reg.h |  13 +++
 3 files changed, 139 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index d29fbc9cb5ac..a7ae8b277dd5 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -1028,6 +1028,68 @@ u32 rtw89_phy_read_rf_v2(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
 }
 EXPORT_SYMBOL(rtw89_phy_read_rf_v2);
 
+static u32 rtw89_phy_read_full_rf_v3_a(struct rtw89_dev *rtwdev,
+				       enum rtw89_rf_path rf_path, u32 addr)
+{
+	bool done;
+	u32 busy;
+	int ret;
+	u32 val;
+
+	ret = read_poll_timeout_atomic(rtw89_phy_read32_mask, busy, !busy,
+				       1, 30, false,
+				       rtwdev, R_SW_SI_DATA_BE4,
+				       B_SW_SI_W_BUSY_BE4 | B_SW_SI_R_BUSY_BE4);
+	if (ret) {
+		rtw89_warn(rtwdev, "poll HWSI is busy\n");
+		return INV_RF_DATA;
+	}
+
+	val = u32_encode_bits(rf_path, GENMASK(10, 8)) |
+	      u32_encode_bits(addr, GENMASK(7, 0));
+
+	rtw89_phy_write32_mask(rtwdev, R_SW_SI_READ_ADDR_BE4, B_SW_SI_READ_ADDR_BE4, val);
+
+	ret = read_poll_timeout_atomic(rtw89_phy_read32_mask, done, done,
+				       1, 30, false,
+				       rtwdev, R_SW_SI_DATA_BE4, B_SW_SI_READ_DATA_DONE_BE4);
+	if (ret) {
+		rtw89_warn(rtwdev, "read HWSI is busy\n");
+		return INV_RF_DATA;
+	}
+
+	val = rtw89_phy_read32_mask(rtwdev, R_SW_SI_DATA_BE4, B_SW_SI_READ_DATA_BE4);
+
+	return val;
+}
+
+static u32 rtw89_phy_read_rf_v3_a(struct rtw89_dev *rtwdev,
+				  enum rtw89_rf_path rf_path, u32 addr, u32 mask)
+{
+	u32 val;
+
+	val = rtw89_phy_read_full_rf_v3_a(rtwdev, rf_path, addr);
+
+	return (val & mask) >> __ffs(mask);
+}
+
+u32 rtw89_phy_read_rf_v3(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
+			 u32 addr, u32 mask)
+{
+	bool ad_sel = u32_get_bits(addr, RTW89_RF_ADDR_ADSEL_MASK);
+
+	if (rf_path >= rtwdev->chip->rf_path_num) {
+		rtw89_err(rtwdev, "unsupported rf path (%d)\n", rf_path);
+		return INV_RF_DATA;
+	}
+
+	if (ad_sel)
+		return rtw89_phy_read_rf(rtwdev, rf_path, addr, mask);
+	else
+		return rtw89_phy_read_rf_v3_a(rtwdev, rf_path, addr, mask);
+}
+EXPORT_SYMBOL(rtw89_phy_read_rf_v3);
+
 bool rtw89_phy_write_rf(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
 			u32 addr, u32 mask, u32 data)
 {
@@ -1167,6 +1229,66 @@ bool rtw89_phy_write_rf_v2(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
 }
 EXPORT_SYMBOL(rtw89_phy_write_rf_v2);
 
+static
+bool rtw89_phy_write_full_rf_v3_a(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
+				  u32 addr, u32 data)
+{
+	u32 busy;
+	u32 val;
+	int ret;
+
+	ret = read_poll_timeout_atomic(rtw89_phy_read32_mask, busy, !busy,
+				       1, 30, false,
+				       rtwdev, R_SW_SI_DATA_BE4,
+				       B_SW_SI_W_BUSY_BE4 | B_SW_SI_R_BUSY_BE4);
+	if (ret) {
+		rtw89_warn(rtwdev, "[%s] HWSI is busy\n", __func__);
+		return false;
+	}
+
+	val = u32_encode_bits(rf_path, B_SW_SI_DATA_PATH_BE4) |
+	      u32_encode_bits(addr, B_SW_SI_DATA_ADR_BE4) |
+	      u32_encode_bits(data, B_SW_SI_DATA_DAT_BE4);
+
+	rtw89_phy_write32(rtwdev, R_SW_SI_WDATA_BE4, val);
+
+	return true;
+}
+
+static
+bool rtw89_phy_write_rf_a_v3(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
+			     u32 addr, u32 mask, u32 data)
+{
+	u32 val;
+
+	if (mask == RFREG_MASK) {
+		val = data;
+	} else {
+		val = rtw89_phy_read_full_rf_v3_a(rtwdev, rf_path, addr);
+		val &= ~mask;
+		val |= (data << __ffs(mask)) & mask;
+	}
+
+	return rtw89_phy_write_full_rf_v3_a(rtwdev, rf_path, addr, val);
+}
+
+bool rtw89_phy_write_rf_v3(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
+			   u32 addr, u32 mask, u32 data)
+{
+	bool ad_sel = u32_get_bits(addr, RTW89_RF_ADDR_ADSEL_MASK);
+
+	if (rf_path >= rtwdev->chip->rf_path_num) {
+		rtw89_err(rtwdev, "unsupported rf path (%d)\n", rf_path);
+		return INV_RF_DATA;
+	}
+
+	if (ad_sel)
+		return rtw89_phy_write_rf(rtwdev, rf_path, addr, mask, data);
+	else
+		return rtw89_phy_write_rf_a_v3(rtwdev, rf_path, addr, mask, data);
+}
+EXPORT_SYMBOL(rtw89_phy_write_rf_v3);
+
 static bool rtw89_chip_rf_v1(struct rtw89_dev *rtwdev)
 {
 	return rtwdev->chip->ops->write_rf == rtw89_phy_write_rf_v1;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 9caacffd0af8..444b4ff86ebc 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -823,12 +823,16 @@ u32 rtw89_phy_read_rf_v1(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
 			 u32 addr, u32 mask);
 u32 rtw89_phy_read_rf_v2(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
 			 u32 addr, u32 mask);
+u32 rtw89_phy_read_rf_v3(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
+			 u32 addr, u32 mask);
 bool rtw89_phy_write_rf(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
 			u32 addr, u32 mask, u32 data);
 bool rtw89_phy_write_rf_v1(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
 			   u32 addr, u32 mask, u32 data);
 bool rtw89_phy_write_rf_v2(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
 			   u32 addr, u32 mask, u32 data);
+bool rtw89_phy_write_rf_v3(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
+			   u32 addr, u32 mask, u32 data);
 void rtw89_phy_init_bb_reg(struct rtw89_dev *rtwdev);
 void rtw89_phy_init_bb_afe(struct rtw89_dev *rtwdev);
 void rtw89_phy_init_rf_reg(struct rtw89_dev *rtwdev, bool noio);
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index edf0223b28a3..c06723fdb4d3 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -9893,6 +9893,19 @@
 #define R_TSSI_K_P1 0xE7A0
 #define B_TSSI_K_OFDM_P1 GENMASK(29, 20)
 
+#define R_SW_SI_WDATA_BE4 0x20370
+#define B_SW_SI_DATA_PATH_BE4 GENMASK(31, 28)
+#define B_SW_SI_DATA_ADR_BE4 GENMASK(27, 20)
+#define B_SW_SI_DATA_DAT_BE4 GENMASK(19, 0)
+#define R_SW_SI_READ_ADDR_BE4 0x20378
+#define B_SW_SI_READ_ADDR_BE4 GENMASK(10, 0)
+
+#define R_SW_SI_DATA_BE4 0x2CF4C
+#define B_SW_SI_READ_DATA_BE4 GENMASK(19, 0)
+#define B_SW_SI_W_BUSY_BE4 BIT(24)
+#define B_SW_SI_R_BUSY_BE4 BIT(25)
+#define B_SW_SI_READ_DATA_DONE_BE4 BIT(26)
+
 /* WiFi CPU local domain */
 #define R_AX_WDT_CTRL 0x0040
 #define B_AX_WDT_EN BIT(31)
-- 
2.25.1


