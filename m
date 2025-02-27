Return-Path: <linux-wireless+bounces-19506-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC4AA47056
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 01:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33F4A7A387B
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 00:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247C1270058;
	Thu, 27 Feb 2025 00:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUkcdDSh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD5927004D
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 00:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740616634; cv=none; b=gkhvicR2Bb4Cr3LRpD97yZjwsQB8j1OyrAetjyTLO8q6dgCRB330YFUdkLYZx6loidBDpg0ZQjVCnvbjKkV5ITUkDva/D3+/+KXWwQFoom6E2+F7iFKcXyGMOwr0FhgW9ibIXgE0K41TnsfFWKjKLRKfarJvfrEbhs71jSDdXmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740616634; c=relaxed/simple;
	bh=GIR1Gs2pdP57VP2x61fBuIMMkpbloGhmhv6eJUTYVTQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IBskoMKGu0QeqHuXIDH636n0HemBuVngyOiJ0um4H2unvVWkCxlWMHwDLk0WwtkoQ/c4G0PR77au8nOgfXsxAnBIVFOeCXzl9ae5m4w9pRf9ECAOwOjHYUjRJW5+YarxuuKouknJqXczIA2k/7C5dVLYaP6oGSSLiZJk4s0kQrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUkcdDSh; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e0b70fb1daso503464a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 16:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740616630; x=1741221430; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IJrh8CoC7l6jkeRYomleiynidFDTKA3ItURKqMmta8Y=;
        b=JUkcdDSh7RoWkpXPaI0D62mlIUQPam9mAiSf1umP/3UuMqoK8hWtolB2PvxWuOBcl3
         +Y4L1Zn4t7TasIeHQpVTEdcTV4uDN3W8X0hDGV6UGyPe9Jp1ofTEZSwVHyqw3jmbAseb
         KKulHhdp/V84fhlG3U43wR3p0B7W43FRXQemkZc45KsCfKxO3GwTJqGBDopFptiLx7vI
         rLJsGgyjOWmCcBRt+6PvAS1jJcDiSPox03ESuq4Yp8hE7HGL15QisyzOP+PdblUDIk0X
         OH95U7NAbvIMMvg3rMmtqNx2kRZRt1LI5+AYRiAd6FKC9xNYMWgm74LYZOQnIC4CLDxB
         1OhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740616630; x=1741221430;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IJrh8CoC7l6jkeRYomleiynidFDTKA3ItURKqMmta8Y=;
        b=xAWAllzyYu14o7GgLWn/gRlqiycX33utwdO0dW9hElrZRaMubP0+f0lZ14z6BQFPWM
         MDWqISudCuslLkQ7xxUl1fFyU7/OstbUVIevcBIg1v+FrWxY50gocGABCeZ8CI2GGKC1
         W6sPNg9hqNbeYsGDwLnWV1AF3BCBwRFwRDceb/weUvAmPl9vmS9j/s29eua/XO/koVaD
         Tz0mkLoayILkHQWTSk06JtaXzcDpHtocJcnrfXQoHd30GUQfVnPnyEoidvdgfCejqWn6
         PSLg90yM7+uYl3R2frY6znEUmS+5sx4FdxoYVt1t7/mBLUciAWqcZ5ye0TbVZfxEitOg
         TUDQ==
X-Gm-Message-State: AOJu0YweAsgLIcZSMohjtJWzwNKvGFMJdghBebVw/J+q+m+7ULgjsU5A
	0I+EOocDSNvAYyIRmELO2zSY+3glZ5wOHfPamy24Cc7hSSWsLlqGAl8ljA==
X-Gm-Gg: ASbGncvzhDY9B9WKNWMbI3dSgn3kaFr4ZwutWAjsivD+ZI7CiSXlYjhqWoCUGhSANX4
	OHFUqYA4QCwlBItGO/kUaEweZfTH73PYRxwOHUGuie+FZeXd2XOPsTMXbxQ6jMA3E9egWAeUUAh
	jEnpFZe1DAkkQKWIpIKePefNyni5icYOUPgM2j26TKR0BWww5SH4Mxo+rKp8zm9zZACZ6qjQKKP
	Iwv2dYts/Fc161YDDRw3th7z1OPxJiXLQ1CFKuvfj74xCj6g9fvsG8IC+1wQJF/c4NSwGWh4nGJ
	FUcAd5t4et7tFnh/6SK4szdVtcHeFK8e5Bs=
X-Google-Smtp-Source: AGHT+IHVH37+Lt/fzF02yYhwwmY//Z5gGz+sGuV4Q3R8dw3gTQRZD1B+H3ai4hArVRKyCKJYGgGtSw==
X-Received: by 2002:a05:6402:5107:b0:5de:481a:cbc1 with SMTP id 4fb4d7f45d1cf-5e4a0d88e47mr8335295a12.16.1740616630259;
        Wed, 26 Feb 2025 16:37:10 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.155])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb51f9sm252629a12.55.2025.02.26.16.37.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 16:37:09 -0800 (PST)
Message-ID: <2a18fa0f-0a80-4059-b69c-907e18d85893@gmail.com>
Date: Thu, 27 Feb 2025 02:37:08 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 1/7] wifi: rtw88: Add some definitions for RTL8814AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <8e9d900e-0721-425c-8466-bd57742c9f86@gmail.com>
Content-Language: en-US
In-Reply-To: <8e9d900e-0721-425c-8466-bd57742c9f86@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Add various register definitions which will be used by the new driver.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/reg.h | 45 +++++++++++++++++++++---
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index 209b6fc08a73..e87cccc2ffdd 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -8,6 +8,7 @@
 #define REG_SYS_FUNC_EN		0x0002
 #define BIT_FEN_EN_25_1		BIT(13)
 #define BIT_FEN_ELDR		BIT(12)
+#define BIT_FEN_PCIEA		BIT(6)
 #define BIT_FEN_CPUEN		BIT(2)
 #define BIT_FEN_USBA		BIT(2)
 #define BIT_FEN_BB_GLB_RST	BIT(1)
@@ -39,6 +40,9 @@
 #define BIT_RF_RSTB		BIT(1)
 #define BIT_RF_EN		BIT(0)
 
+#define REG_RF_CTRL1		0x0020
+#define REG_RF_CTRL2		0x0021
+
 #define REG_AFE_CTRL1		0x0024
 #define BIT_MAC_CLK_SEL		(BIT(20) | BIT(21))
 #define REG_EFUSE_CTRL		0x0030
@@ -73,6 +77,8 @@
 #define BIT_BT_PTA_EN		BIT(5)
 #define BIT_WLRFE_4_5_EN	BIT(2)
 
+#define REG_GPIO_PIN_CTRL	0x0044
+
 #define REG_LED_CFG		0x004C
 #define BIT_LNAON_SEL_EN	BIT(26)
 #define BIT_PAPE_SEL_EN		BIT(25)
@@ -110,6 +116,7 @@
 #define BIT_SDIO_PAD_E5		BIT(18)
 
 #define REG_RF_B_CTRL		0x76
+#define REG_RF_CTRL3		0x0076
 
 #define REG_AFE_CTRL_4		0x0078
 #define BIT_CK320M_AFE_EN	BIT(4)
@@ -603,6 +610,13 @@
 #define REG_CCA2ND		0x0838
 #define REG_L1PKTH		0x0848
 #define REG_CLKTRK		0x0860
+#define REG_CSI_MASK_SETTING1	0x0874
+#define REG_NBI_SETTING		0x087c
+#define BIT_NBI_ENABLE		BIT(13)
+#define REG_CSI_FIX_MASK0	0x0880
+#define REG_CSI_FIX_MASK1	0x0884
+#define REG_CSI_FIX_MASK6	0x0898
+#define REG_CSI_FIX_MASK7	0x089c
 #define REG_ADCCLK		0x08AC
 #define REG_HSSI_READ		0x08B0
 #define REG_FPGA0_XCD_RF_PARA	0x08B4
@@ -611,7 +625,7 @@
 #define REG_ANTSEL_SW		0x0900
 #define REG_DAC_RSTB		0x090c
 #define REG_SINGLE_TONE_CONT_TX	0x0914
-
+#define REG_AGC_TABLE		0x0958
 #define REG_RFE_CTRL_E		0x0974
 #define REG_2ND_CCA_CTRL	0x0976
 #define REG_IQK_COM00		0x0978
@@ -623,8 +637,10 @@
 #define REG_RXSB		0x0a00
 #define REG_CCK_RX		0x0a04
 #define REG_CCK_PD_TH		0x0a0a
-
-#define REG_CCK0_FAREPORT	0xa2c
+#define REG_CCK0_TX_FILTER1	0x0a20
+#define REG_CCK0_TX_FILTER2	0x0a24
+#define REG_CCK0_DEBUG_PORT	0x0a28
+#define REG_CCK0_FAREPORT	0x0a2c
 #define BIT_CCK0_2RX		BIT(18)
 #define BIT_CCK0_MRC		BIT(22)
 #define REG_FA_CCK		0x0a5c
@@ -647,6 +663,7 @@
 
 #define REG_3WIRE_SWA		0x0c00
 #define REG_RX_IQC_AB_A		0x0c10
+#define REG_RX_IQC_CD_A		0x0c14
 #define REG_TXSCALE_A		0x0c1c
 #define BB_SWING_MASK		GENMASK(31, 21)
 #define REG_TX_AGC_A_CCK_11_CCK_1		0xc20
@@ -674,7 +691,7 @@
 #define REG_LSSI_WRITE_A	0x0c90
 #define REG_PREDISTA		0x0c90
 #define REG_TXAGCIDX		0x0c94
-
+#define REG_TX_AGC_A		0x0c94
 #define REG_RFE_PINMUX_A	0x0cb0
 #define REG_RFE_INV_A		0x0cb4
 #define REG_RFE_CTRL8		0x0cb4
@@ -683,6 +700,7 @@
 #define DPDT_CTRL_PIN		0x77
 #define RFE_INV_MASK		0x3ff00000
 #define REG_RFECTL_A		0x0cb8
+#define REG_RFE_INV0		0x0cbc
 #define REG_RFE_INV8		0x0cbd
 #define BIT_MASK_RFE_INV89	GENMASK(1, 0)
 #define REG_RFE_INV16		0x0cbe
@@ -703,6 +721,7 @@
 
 #define REG_3WIRE_SWB		0x0e00
 #define REG_RX_IQC_AB_B		0x0e10
+#define REG_RX_IQC_CD_B		0x0e14
 #define REG_TXSCALE_B		0x0e1c
 #define REG_TX_AGC_B_CCK_11_CCK_1		0xe20
 #define REG_TX_AGC_B_OFDM18_OFDM6		0xe24
@@ -729,6 +748,7 @@
 #define REG_LSSI_WRITE_B	0x0e90
 #define REG_PREDISTB		0x0e90
 #define REG_INIDLYB		0x0e94
+#define REG_TX_AGC_B		0x0e94
 #define REG_RFE_PINMUX_B	0x0eb0
 #define REG_RFE_INV_B		0x0eb4
 #define REG_RFECTL_B		0x0eb8
@@ -746,6 +766,8 @@
 #define REG_FA_OFDM		0x0f48
 #define REG_CCA_CCK		0x0fcc
 
+#define REG_SYS_CFG3_8814A	0x1000
+
 #define REG_ANAPARSW_MAC_0	0x1010
 #define BIT_CF_L_V2		GENMASK(29, 28)
 
@@ -863,10 +885,25 @@
 #define LTECOEX_WRITE_DATA REG_WL2LTECOEX_INDIRECT_ACCESS_WRITE_DATA_V1
 #define LTECOEX_READ_DATA REG_WL2LTECOEX_INDIRECT_ACCESS_READ_DATA_V1
 
+#define REG_RX_IQC_AB_C		0x1810
+#define REG_RX_IQC_CD_C		0x1814
+#define REG_TXSCALE_C		0x181c
+#define REG_CK_MONHC		0x185c
+#define REG_AFE_PWR1_C		0x1860
 #define REG_IGN_GNT_BT1	0x1860
+#define REG_TX_AGC_C		0x1894
+#define REG_RFE_PINMUX_C	0x18b4
 
 #define REG_RFESEL_CTRL	0x1990
 
+#define REG_RX_IQC_AB_D		0x1a10
+#define REG_RX_IQC_CD_D		0x1a14
+#define REG_TXSCALE_D		0x1a1c
+#define REG_CK_MONHD		0x1a5c
+#define REG_AFE_PWR1_D		0x1a60
+#define REG_TX_AGC_D		0x1a94
+#define REG_RFE_PINMUX_D	0x1ab4
+
 #define REG_NOMASK_TXBT	0x1ca7
 #define REG_ANAPAR	0x1c30
 #define BIT_ANAPAR_BTPS	BIT(22)
-- 
2.48.1


