Return-Path: <linux-wireless+bounces-24598-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81767AEAD92
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 05:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23C8B563249
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 03:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B6119DFB4;
	Fri, 27 Jun 2025 03:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="FhLe/P7y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639411A23B5
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 03:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750996372; cv=none; b=XpDFxlJElIRbxFoJQ+18ZMmsz4fWrYXDNsp2DS3Tw9FhJyjljI68ILzheIfY4uiTRPNdsTc5zOVec0X9ZTtTaZ9sdJ3r4tlB6vgxmYSHJjK5s5wycszw6nrjUneNOCGSXltEQDvhGe0pDyLszGiHZdRE3Dnr7aYsgr69M95SKcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750996372; c=relaxed/simple;
	bh=yelmLNvJEe0SbwGA98+dbZri3pOQQFIfiTXIe123TLU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nPOyDhsPEgnpqeWtdGDPl4vcO3dkwikq/LNUqT6+CaqI5yyVbZLkUxgdQzTazsnQza42qHGhfc0ldcroWsj3sxS09tO3+PlUN3ERGMYHwaR2X+6mq3NF5yQF34P0T5W4zwlRfg30FQnLcx3PGf5MSKD9zOhhttXL3B/yZ96j9fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=FhLe/P7y; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55R3qlzS72041765, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750996367; bh=rdsYmJ4WuZKrwBwq83OxTR2Lea891QAmL0UyWByyLaA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=FhLe/P7yDzjwlw9TVNdEsWUaHnqr4jBx1osRmW1sJuALdLHvJ0GQaBhx/9bJlkkSp
	 69Y3UwnCShjialfy4+v9ErFrs3q1OFb4VUu6Xf+lkdbA56UoEqOsOfjdbVSrlbk77/
	 rB8KYQ0trG9UpI9BXOVZImNmagvbH6G9F9NAZUfgRKSPa86GlPjEctO7wf1mJ2A3Ws
	 hsd3c0npw4ZIOzWMQXuAzmzQhFwXQmqO2BJPY2AximawTeH0MqOnsioxX/fzihgZfM
	 l94Kk/tyU/G31gKKa8LVK0fjzXR9CqfZqYWdE4g8Zptbc1b0AoQH5/2qhawlj1ikaH
	 OlWLynB+9Jhrg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55R3qlzS72041765
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 11:52:47 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 27 Jun 2025 11:53:04 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 27 Jun
 2025 11:53:03 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 2/6] wifi: rtw89: 8851b: set ADC bandwidth select according to calibration value
Date: Fri, 27 Jun 2025 11:51:57 +0800
Message-ID: <20250627035201.16416-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250627035201.16416-1-pkshih@realtek.com>
References: <20250627035201.16416-1-pkshih@realtek.com>
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

To handle hardware characteristic of ADC, calibrate the function and add
a efuse field to record result, which driver uses it to set proper value
accordingly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 28 ++++++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 06ceb77a1cc6..a72cd6e13de2 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3480,6 +3480,7 @@ struct rtw89_efuse {
 	u8 addr[ETH_ALEN];
 	u8 rfe_type;
 	char country_code[2];
+	u8 adc_td;
 };
 
 struct rtw89_phy_rate_pattern {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index c55833f259de..287d53203b38 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -712,12 +712,22 @@ static void rtw8851b_phycap_parsing_gain_comp(struct rtw89_dev *rtwdev, u8 *phyc
 	gain->comp_valid = valid;
 }
 
+static void rtw8851b_phycap_parsing_adc_td(struct rtw89_dev *rtwdev, u8 *phycap_map)
+{
+	u32 phycap_addr = rtwdev->chip->phycap_addr;
+	struct rtw89_efuse *efuse = &rtwdev->efuse;
+	const u32 addr_adc_td = 0x5AF;
+
+	efuse->adc_td = phycap_map[addr_adc_td - phycap_addr] & GENMASK(4, 0);
+}
+
 static int rtw8851b_read_phycap(struct rtw89_dev *rtwdev, u8 *phycap_map)
 {
 	rtw8851b_phycap_parsing_tssi(rtwdev, phycap_map);
 	rtw8851b_phycap_parsing_thermal_trim(rtwdev, phycap_map);
 	rtw8851b_phycap_parsing_pa_bias_trim(rtwdev, phycap_map);
 	rtw8851b_phycap_parsing_gain_comp(rtwdev, phycap_map);
+	rtw8851b_phycap_parsing_adc_td(rtwdev, phycap_map);
 
 	return 0;
 }
@@ -1083,10 +1093,26 @@ static void rtw8851b_ctrl_ch(struct rtw89_dev *rtwdev,
 
 static void rtw8851b_bw_setting(struct rtw89_dev *rtwdev, u8 bw)
 {
+	struct rtw89_efuse *efuse = &rtwdev->efuse;
+	u8 adc_bw_sel;
+
+	switch (efuse->adc_td) {
+	default:
+	case 0x19:
+		adc_bw_sel = 0x4;
+		break;
+	case 0x11:
+		adc_bw_sel = 0x5;
+		break;
+	case 0x9:
+		adc_bw_sel = 0x3;
+		break;
+	}
+
 	rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW0, B_P0_CFCH_CTL, 0x8);
 	rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW0, B_P0_CFCH_EN, 0x2);
 	rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW0, B_P0_CFCH_BW0, 0x2);
-	rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW1, B_P0_CFCH_BW1, 0x4);
+	rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW1, B_P0_CFCH_BW1, adc_bw_sel);
 	rtw89_phy_write32_mask(rtwdev, R_DRCK, B_DRCK_MUL, 0xf);
 	rtw89_phy_write32_mask(rtwdev, R_ADCMOD, B_ADCMOD_LP, 0xa);
 	rtw89_phy_write32_mask(rtwdev, R_P0_RXCK, B_P0_RXCK_ADJ, 0x92);
-- 
2.25.1


