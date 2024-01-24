Return-Path: <linux-wireless+bounces-2431-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EDD83A02A
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 04:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E46DB1C22872
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 03:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B04BA4C;
	Wed, 24 Jan 2024 03:37:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB37B643
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jan 2024 03:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706067445; cv=none; b=MZXCZdK/vALEaRkLngR0mdRIUrP43H7N2b67QXSWpujUVAnrcKYuoMmy4kCqdfXP5/I2bHa7GQ8RT+c2flAcGou4WETg0Heyb5TClc3oeqJOAWO++n/L9RTlNcs4WZrfVeGEFe+qgwiJyCOqKTqaF9arsrpqneqYDiZaX0BXY5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706067445; c=relaxed/simple;
	bh=7o12iAPC2IatryUraEa+JjuSyt3IowptO6gBfcrmJXQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=llwZ11G7F149Y5RIio3mMZSaJibJMK8E3kAjgDNYWKpCa4dJcBzorSDwFVXabrPdDef+0VkDhX858skTcfZw4qkcnn26GNFFAUNTfHfBUlbEGQoaKVA3IvwK3IskytOqe3w0+4AoCiRMlnpdU1Ix3P8Yhm56pnF2xlCarwVIls4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40O3bHj55723725, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40O3bHj55723725
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 11:37:17 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 24 Jan 2024 11:37:17 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 24 Jan
 2024 11:37:17 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/6] wifi: rtw89: 8922a: add RF read/write v2
Date: Wed, 24 Jan 2024 11:36:35 +0800
Message-ID: <20240124033637.12330-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240124033637.12330-1-pkshih@realtek.com>
References: <20240124033637.12330-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)
X-KSE-ServerInfo: RTEXDAG02.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Implement indirect interface v2 to read/write RF registers via PHY
registers for 8922A.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c      | 125 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/phy.h      |   4 +
 drivers/net/wireless/realtek/rtw89/reg.h      |  15 +++
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |   2 +
 4 files changed, 146 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 7880fbaee092..f661be2f1287 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -796,6 +796,71 @@ u32 rtw89_phy_read_rf_v1(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
 }
 EXPORT_SYMBOL(rtw89_phy_read_rf_v1);
 
+static u32 rtw89_phy_read_full_rf_v2_a(struct rtw89_dev *rtwdev,
+				       enum rtw89_rf_path rf_path, u32 addr)
+{
+	static const u16 r_addr_ofst[2] = {0x2C24, 0x2D24};
+	static const u16 addr_ofst[2] = {0x2ADC, 0x2BDC};
+	bool busy, done;
+	int ret;
+	u32 val;
+
+	rtw89_phy_write32_mask(rtwdev, addr_ofst[rf_path], B_HWSI_ADD_CTL_MASK, 0x1);
+	ret = read_poll_timeout_atomic(rtw89_phy_read32_mask, busy, !busy,
+				       1, 3800, false,
+				       rtwdev, r_addr_ofst[rf_path], B_HWSI_VAL_BUSY);
+	if (ret) {
+		rtw89_warn(rtwdev, "poll HWSI is busy\n");
+		return INV_RF_DATA;
+	}
+
+	rtw89_phy_write32_mask(rtwdev, addr_ofst[rf_path], B_HWSI_ADD_MASK, addr);
+	rtw89_phy_write32_mask(rtwdev, addr_ofst[rf_path], B_HWSI_ADD_RD, 0x1);
+	udelay(2);
+
+	ret = read_poll_timeout_atomic(rtw89_phy_read32_mask, done, done,
+				       1, 3800, false,
+				       rtwdev, r_addr_ofst[rf_path], B_HWSI_VAL_RDONE);
+	if (ret) {
+		rtw89_warn(rtwdev, "read HWSI is busy\n");
+		val = INV_RF_DATA;
+		goto out;
+	}
+
+	val = rtw89_phy_read32_mask(rtwdev, r_addr_ofst[rf_path], RFREG_MASK);
+out:
+	rtw89_phy_write32_mask(rtwdev, addr_ofst[rf_path], B_HWSI_ADD_POLL_MASK, 0);
+
+	return val;
+}
+
+static u32 rtw89_phy_read_rf_v2_a(struct rtw89_dev *rtwdev,
+				  enum rtw89_rf_path rf_path, u32 addr, u32 mask)
+{
+	u32 val;
+
+	val = rtw89_phy_read_full_rf_v2_a(rtwdev, rf_path, addr);
+
+	return (val & mask) >> __ffs(mask);
+}
+
+u32 rtw89_phy_read_rf_v2(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
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
+		return rtw89_phy_read_rf_v2_a(rtwdev, rf_path, addr, mask);
+}
+EXPORT_SYMBOL(rtw89_phy_read_rf_v2);
+
 bool rtw89_phy_write_rf(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
 			u32 addr, u32 mask, u32 data)
 {
@@ -875,6 +940,66 @@ bool rtw89_phy_write_rf_v1(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
 }
 EXPORT_SYMBOL(rtw89_phy_write_rf_v1);
 
+static
+bool rtw89_phy_write_full_rf_v2_a(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
+				  u32 addr, u32 data)
+{
+	static const u32 addr_is_idle[2] = {0x2C24, 0x2D24};
+	static const u32 addr_ofst[2] = {0x2AE0, 0x2BE0};
+	bool busy;
+	u32 val;
+	int ret;
+
+	ret = read_poll_timeout_atomic(rtw89_phy_read32_mask, busy, !busy,
+				       1, 3800, false,
+				       rtwdev, addr_is_idle[rf_path], BIT(29));
+	if (ret) {
+		rtw89_warn(rtwdev, "[%s] HWSI is busy\n", __func__);
+		return false;
+	}
+
+	val = u32_encode_bits(addr, B_HWSI_DATA_ADDR) |
+	      u32_encode_bits(data, B_HWSI_DATA_VAL);
+
+	rtw89_phy_write32(rtwdev, addr_ofst[rf_path], val);
+
+	return true;
+}
+
+static
+bool rtw89_phy_write_rf_a_v2(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
+			     u32 addr, u32 mask, u32 data)
+{
+	u32 val;
+
+	if (mask == RFREG_MASK) {
+		val = data;
+	} else {
+		val = rtw89_phy_read_full_rf_v2_a(rtwdev, rf_path, addr);
+		val &= ~mask;
+		val |= (data << __ffs(mask)) & mask;
+	}
+
+	return rtw89_phy_write_full_rf_v2_a(rtwdev, rf_path, addr, val);
+}
+
+bool rtw89_phy_write_rf_v2(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
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
+		return rtw89_phy_write_rf_a_v2(rtwdev, rf_path, addr, mask, data);
+}
+EXPORT_SYMBOL(rtw89_phy_write_rf_v2);
+
 static bool rtw89_chip_rf_v1(struct rtw89_dev *rtwdev)
 {
 	return rtwdev->chip->ops->write_rf == rtw89_phy_write_rf_v1;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index c05f724a84ce..13903ca1eaa9 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -781,10 +781,14 @@ u32 rtw89_phy_read_rf(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
 		      u32 addr, u32 mask);
 u32 rtw89_phy_read_rf_v1(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
 			 u32 addr, u32 mask);
+u32 rtw89_phy_read_rf_v2(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
+			 u32 addr, u32 mask);
 bool rtw89_phy_write_rf(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
 			u32 addr, u32 mask, u32 data);
 bool rtw89_phy_write_rf_v1(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
 			   u32 addr, u32 mask, u32 data);
+bool rtw89_phy_write_rf_v2(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
+			   u32 addr, u32 mask, u32 data);
 void rtw89_phy_init_bb_reg(struct rtw89_dev *rtwdev);
 void rtw89_phy_init_rf_reg(struct rtw89_dev *rtwdev, bool noio);
 void rtw89_phy_config_rf_reg_v1(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index da7a668c9c16..6b15fa431b22 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -7994,6 +7994,21 @@
 #define B_AFEDAC1 GENMASK(2, 0)
 #define R_IQKDPK_HC 0x2AB8
 #define B_IQKDPK_HC BIT(28)
+#define R_HWSI_ADD0 0x2ADC
+#define R_HWSI_ADD1 0x2BDC
+#define B_HWSI_ADD_MASK GENMASK(11, 4)
+#define B_HWSI_ADD_CTL_MASK GENMASK(2, 0)
+#define B_HWSI_ADD_RD BIT(2)
+#define B_HWSI_ADD_POLL_MASK GENMASK(1, 0)
+#define B_HWSI_ADD_RUN BIT(1)
+#define B_HWSI_ADD_BUSY BIT(0)
+#define R_HWSI_DATA 0x2AE0
+#define B_HWSI_DATA_VAL GENMASK(27, 8)
+#define B_HWSI_DATA_ADDR GENMASK(7, 0)
+#define R_HWSI_VAL0 0x2C24
+#define R_HWSI_VAL1 0x2D24
+#define B_HWSI_VAL_RDONE BIT(31)
+#define B_HWSI_VAL_BUSY BIT(29)
 #define R_P1_EN_SOUND_WO_NDP 0x2D7C
 #define B_P1_EN_SOUND_WO_NDP BIT(1)
 #define R_EDCCA_RPT_A_BE 0x2E38
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 2481f983b426..1c5ceb5564c3 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -1594,6 +1594,8 @@ static const struct rtw89_chip_ops rtw8922a_chip_ops = {
 	.bb_postinit		= rtw8922a_bb_postinit,
 	.bb_reset		= rtw8922a_bb_reset,
 	.bb_sethw		= rtw8922a_bb_sethw,
+	.read_rf		= rtw89_phy_read_rf_v2,
+	.write_rf		= rtw89_phy_write_rf_v2,
 	.set_channel		= rtw8922a_set_channel,
 	.read_efuse		= rtw8922a_read_efuse,
 	.read_phycap		= rtw8922a_read_phycap,
-- 
2.25.1


