Return-Path: <linux-wireless+bounces-24599-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84807AEAD94
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 05:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F2411675B5
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 03:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67CA1A0BD0;
	Fri, 27 Jun 2025 03:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="nAOKVUtm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2E41A262D
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 03:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750996374; cv=none; b=toM6vYA7BzTJyea6JNEAmsfcSYM035SMjdtKJmfRFXY2jFyvFX+IAcQ58fviW9M4yijtSb5Ty198ruCBjQzO8mGTpBj4TUZb5zBGiBIR/hweTy+0ziYcZXm2uECrRLw53x8ve6xAYB0vyEyhRdKpe3xD9k0rB9r+9uIes1MdAHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750996374; c=relaxed/simple;
	bh=DacIhrsjf5fbiuUBLJUiBkzauH6iYEPXb9o9kD19cfo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gm7p6U1x+K0PEA/3D6tVu13XEZt0jn8UUtJIdNAopF7BgVgxrFzDFdHhLnNb+yc0fAtTa9BEi3iAIWx0cCkQL+TGEqPwzI0AbFtkDvY3sGDuRSP2oWw/HbAGaYpVEEe1C+MJzYx7FKwobVX1ynixr999hsv+2Y5JhEjDfvvWsQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=nAOKVUtm; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55R3qow172041767, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750996370; bh=eSO0m6Q2NaLbkbkeOZuU+TjTPizR9zF+E06CvZ5pLPg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=nAOKVUtmKPOewhT04tDE54dgQ78qGcqlr1Ib9FUqq3TLKFGIxqtCvAmNXSj74m9Mn
	 +cFMzthG1gmCLGOEBTjilVyswo9iQ77om7tV0idqqgc2hfbO1ujqolR1wZjAsbtIDO
	 zoyrYOdYGcoHfkNiqsIhp6tKo33EJeYMcEgAkLOi+p0Axs53c7HDY1WkiH/5cUOMIf
	 o+wTs0Kxcy0v6ycS5QYum7leKangebFpGAdT4u7RbPtFIig3SV+hTlg9gz/GOW3XYG
	 oBPjUxwBdvm85hMs0Rnq8AoFOYWwPScLOSMxwtJ8Z5711GyGH4tbSDRG6pTJ4plyiK
	 tEeJvYObzJ0jA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55R3qow172041767
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 11:52:50 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 27 Jun 2025 11:53:06 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 27 Jun
 2025 11:53:06 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 3/6] wifi: rtw89: 8851b: adjust ADC setting for RF calibration
Date: Fri, 27 Jun 2025 11:51:58 +0800
Message-ID: <20250627035201.16416-4-pkshih@realtek.com>
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

To get expected result of RF calibration at runtime, adjust ADC setting
ahead for coming changes of RF calibration.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 25 ++++++++++++++++---
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 287d53203b38..7801732d5b8b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -1109,39 +1109,56 @@ static void rtw8851b_bw_setting(struct rtw89_dev *rtwdev, u8 bw)
 		break;
 	}
 
-	rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW0, B_P0_CFCH_CTL, 0x8);
-	rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW0, B_P0_CFCH_EN, 0x2);
-	rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW0, B_P0_CFCH_BW0, 0x2);
 	rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW1, B_P0_CFCH_BW1, adc_bw_sel);
 	rtw89_phy_write32_mask(rtwdev, R_DRCK, B_DRCK_MUL, 0xf);
 	rtw89_phy_write32_mask(rtwdev, R_ADCMOD, B_ADCMOD_LP, 0xa);
-	rtw89_phy_write32_mask(rtwdev, R_P0_RXCK, B_P0_RXCK_ADJ, 0x92);
+	rtw89_phy_write32_mask(rtwdev, R_DCIM, B_DCIM_RC, 0x3);
 
 	switch (bw) {
 	case RTW89_CHANNEL_WIDTH_5:
+		rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW0, B_P0_CFCH_CTL, 0x8);
+		rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW0, B_P0_CFCH_EN, 0x2);
+		rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW0, B_P0_CFCH_BW0, 0x2);
 		rtw89_phy_write32_mask(rtwdev, R_DCIM, B_DCIM_FR, 0x1);
 		rtw89_phy_write32_mask(rtwdev, R_WDADC, B_WDADC_SEL, 0x0);
 		rtw89_phy_write32_mask(rtwdev, R_ADDCK0D, B_ADDCK_DS, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_P0_RXCK, B_P0_RXCK_ADJ, 0x92);
 		break;
 	case RTW89_CHANNEL_WIDTH_10:
+		rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW0, B_P0_CFCH_CTL, 0x8);
+		rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW0, B_P0_CFCH_EN, 0x2);
+		rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW0, B_P0_CFCH_BW0, 0x2);
 		rtw89_phy_write32_mask(rtwdev, R_DCIM, B_DCIM_FR, 0x1);
 		rtw89_phy_write32_mask(rtwdev, R_WDADC, B_WDADC_SEL, 0x1);
 		rtw89_phy_write32_mask(rtwdev, R_ADDCK0D, B_ADDCK_DS, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_P0_RXCK, B_P0_RXCK_ADJ, 0x92);
 		break;
 	case RTW89_CHANNEL_WIDTH_20:
+		rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW0, B_P0_CFCH_CTL, 0x8);
+		rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW0, B_P0_CFCH_EN, 0x2);
+		rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW0, B_P0_CFCH_BW0, 0x2);
 		rtw89_phy_write32_mask(rtwdev, R_DCIM, B_DCIM_FR, 0x2);
 		rtw89_phy_write32_mask(rtwdev, R_WDADC, B_WDADC_SEL, 0x2);
 		rtw89_phy_write32_mask(rtwdev, R_ADDCK0D, B_ADDCK_DS, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_P0_RXCK, B_P0_RXCK_ADJ, 0x92);
 		break;
 	case RTW89_CHANNEL_WIDTH_40:
+		rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW0, B_P0_CFCH_CTL, 0x8);
+		rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW0, B_P0_CFCH_EN, 0x2);
+		rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW0, B_P0_CFCH_BW0, 0x2);
 		rtw89_phy_write32_mask(rtwdev, R_DCIM, B_DCIM_FR, 0x2);
 		rtw89_phy_write32_mask(rtwdev, R_WDADC, B_WDADC_SEL, 0x2);
 		rtw89_phy_write32_mask(rtwdev, R_ADDCK0D, B_ADDCK_DS, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_P0_RXCK, B_P0_RXCK_ADJ, 0x92);
 		break;
 	case RTW89_CHANNEL_WIDTH_80:
+		rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW0, B_P0_CFCH_CTL, 0x8);
+		rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW0, B_P0_CFCH_EN, 0x2);
+		rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW0, B_P0_CFCH_BW0, 0x2);
 		rtw89_phy_write32_mask(rtwdev, R_DCIM, B_DCIM_FR, 0x0);
 		rtw89_phy_write32_mask(rtwdev, R_WDADC, B_WDADC_SEL, 0x2);
 		rtw89_phy_write32_mask(rtwdev, R_ADDCK0D, B_ADDCK_DS, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_P0_RXCK, B_P0_RXCK_ADJ, 0x92);
 		break;
 	default:
 		rtw89_warn(rtwdev, "Fail to set ADC\n");
-- 
2.25.1


