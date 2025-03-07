Return-Path: <linux-wireless+bounces-19962-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 676C9A55BBC
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 01:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9246517A06D
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 00:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4905F7F9;
	Fri,  7 Mar 2025 00:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUKwy2cT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669D933EC
	for <linux-wireless@vger.kernel.org>; Fri,  7 Mar 2025 00:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741306943; cv=none; b=FG4cMJbq3/BlRHd0w/zZMirxDNUTg+JrsWd/9Xhn3+CVLAusle1rQ9BLMIPukthKQk+ZmSHgcK6xx6XtD/5PDudcRYMxZNzUROw4U1AF1sbT5xQhERZLFLpdfumhJE2fm4DxE8bkigBUzpai6FMuv1X07tFX1bdZUrcNBotVKOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741306943; c=relaxed/simple;
	bh=k7EkVEK4i2hGTu/5+F1u5aPxPoYok/rjccctVeUA4nc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cY0oq0ZyCBZJ2BIQX0fKMS2MTPZDegxGJ6Fhta7ucUNlW1FWiymb3uKtkV8Q2bW62lDPtn91ZgploqamNQQU/ya1mNE0DcFbM05lLh7ZvW0Wfu/ONSqtNcxx8H+6KprCGePQO7bjGTYBfv9KqkIriOFmlZ0fQbEgcv3XGPdnAKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUKwy2cT; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e0573a84fcso1793559a12.2
        for <linux-wireless@vger.kernel.org>; Thu, 06 Mar 2025 16:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741306939; x=1741911739; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pdiospmn1TRGUPULfbPyBCPaoWV9k1tHVrOYnV9N/5Q=;
        b=AUKwy2cT3o+dvJH4rHR2ZBkgiZlCBcISa07HcW081DL3sebwn3E9puRdMrdi2OZub+
         aHMo9nm9IzXuVpfkQlTIlLzTKsMU+TN6AN8xTEFbv44HTwIjW/IFOZJlbBhZbHTRnp7y
         03EpDxHoD3YMI9CcAD46On7T514Eb7t/pja/VtmauN4Z1ChP8HGdG45MZbcQGzWhfIto
         JqcCUL153ZpEEig45gvPVbm7BO7vJ3igZrgr4o36YOulMPaqDAsnRgP03uYO9RqqGgeg
         uNIV3gAXUdhfZGm1f6a/+hU+/8Mq7nnNg67NvbyFP/rzK2CN74AAXerO1YoOia5Mry6/
         ZPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741306939; x=1741911739;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pdiospmn1TRGUPULfbPyBCPaoWV9k1tHVrOYnV9N/5Q=;
        b=DT5gJpb9I10AHVb/cVwTXGtSyq1YiwBifEJqy/3CPuho8HeNb+9a/z4ZNy4a6OiuT9
         Sj10UMxESBELhLBMhUKeT4StW2kaaPZ089mIs7BzfN2oEVfNB+fhCkASZ+WLNOltbaiR
         gOqCcsm5J3eOC4zC+kjjxjk34J21o+S/VTkYLxo3Z4y+rzyDicTqi+P0+bCud7mPmk25
         oIXmVwhq6LnnXcXJ+6Ip6NeRqqBKUCU16nfCku+j0SBOYjxvhySxaFJ+kMr+BRtIWZi9
         8B1sFlGUZxCl3imq5RMdL0aeBYv4v60UbLs3ooV/g4QQ05+3zOfGBbxqMOleGXTOu+Fs
         p/zQ==
X-Gm-Message-State: AOJu0Yxwbx2vxvumHX7jghL67NJoNH/mNApbQNLhbKM7F6B07DqBXKbL
	LIKS+/hqnQFfcAbkIFEjttMMXgKy9bxF/9hMqWcHvHYcWB+xRbuhuHY6Ug==
X-Gm-Gg: ASbGncv9+5heptEW3Z9B/i/f8NPyZUOCKT+Y1Jvtplg24fsKCHjMhcH+upHwetR4yoR
	CofFr7utQP2bBpXXuotCovQjThSGVwdodR+0mPK1JSoZkjuydIGLPH8CQkNwQRYXAfiIlct3enf
	afGmo1fD4MXbZYn7HFcq/Igk5fkbhGF0p47xN3MapUuAXPF7D6SD5MuYM+S9iO0SnwkICkP+JNA
	aNW4FaCyLPPDUTwUoR1YzWfhAfqdTfxlLwN8AcLNqeQ7npsFQJdEHIppq3WZTs/uqsO6ERjhWy5
	jf263vjzxmDa1zM/MM8xzlUfq7/6FAXpZuOz+Lg8qWC74JwOqF9u3w==
X-Google-Smtp-Source: AGHT+IEEG9ula12vmPC1ODCyFRFESqqGyfrVY42Tow+QBd7GnP6QlPtop9bo/Fly3mR1v21DruLwWQ==
X-Received: by 2002:a17:907:8c5:b0:ac2:4d00:d00c with SMTP id a640c23a62f3a-ac252ef914cmr99272866b.49.1741306939521;
        Thu, 06 Mar 2025 16:22:19 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac254346ce8sm35394366b.177.2025.03.06.16.22.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 16:22:19 -0800 (PST)
Message-ID: <1dcb5abb-26f8-4db5-be36-057de56465e5@gmail.com>
Date: Fri, 7 Mar 2025 02:22:17 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 1/7] wifi: rtw88: Add some definitions for
 RTL8814AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <d25331f4-653d-4ab1-b3dd-0ec1a73209e0@gmail.com>
Content-Language: en-US
In-Reply-To: <d25331f4-653d-4ab1-b3dd-0ec1a73209e0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Add various register definitions which will be used by the new driver.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
- Define more register and bit names.
---
 drivers/net/wireless/realtek/rtw88/reg.h | 66 ++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index 209b6fc08a73..08e9494977e0 100644
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
@@ -603,15 +610,25 @@
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
 #define REG_RX_MCS_LIMIT	0x08BC
 #define REG_ADC160		0x08C4
+#define REG_DBGSEL		0x08fc
 #define REG_ANTSEL_SW		0x0900
 #define REG_DAC_RSTB		0x090c
+#define REG_PSD			0x0910
+#define BIT_PSD_INI		GENMASK(23, 22)
 #define REG_SINGLE_TONE_CONT_TX	0x0914
-
+#define REG_AGC_TABLE		0x0958
 #define REG_RFE_CTRL_E		0x0974
 #define REG_2ND_CCA_CTRL	0x0976
 #define REG_IQK_COM00		0x0978
@@ -621,10 +638,18 @@
 
 #define REG_FAS			0x09a4
 #define REG_RXSB		0x0a00
+#define BIT_RXSB_ANA_DIV	BIT(15)
 #define REG_CCK_RX		0x0a04
 #define REG_CCK_PD_TH		0x0a0a
-
-#define REG_CCK0_FAREPORT	0xa2c
+#define REG_PRECTRL		0x0a14
+#define BIT_DIS_CO_PATHSEL	BIT(7)
+#define BIT_IQ_WGT		GENMASK(9, 8)
+#define REG_CCA_MF		0x0a20
+#define BIT_MBC_WIN		GENMASK(5, 4)
+#define REG_CCK0_TX_FILTER1	0x0a20
+#define REG_CCK0_TX_FILTER2	0x0a24
+#define REG_CCK0_DEBUG_PORT	0x0a28
+#define REG_CCK0_FAREPORT	0x0a2c
 #define BIT_CCK0_2RX		BIT(18)
 #define BIT_CCK0_MRC		BIT(22)
 #define REG_FA_CCK		0x0a5c
@@ -643,10 +668,18 @@
 #define DIS_DPD_RATEVHT2SS_MCS1	BIT(9)
 #define DIS_DPD_RATEALL		GENMASK(9, 0)
 
+#define REG_CCA			0x0a70
+#define BIT_CCA_CO		BIT(7)
+#define REG_ANTSEL		0x0a74
+#define BIT_ANT_BYCO		BIT(8)
+#define REG_CCKTX		0x0a84
+#define BIT_CMB_CCA_2R		BIT(28)
+
 #define REG_CNTRST		0x0b58
 
 #define REG_3WIRE_SWA		0x0c00
 #define REG_RX_IQC_AB_A		0x0c10
+#define REG_RX_IQC_CD_A		0x0c14
 #define REG_TXSCALE_A		0x0c1c
 #define BB_SWING_MASK		GENMASK(31, 21)
 #define REG_TX_AGC_A_CCK_11_CCK_1		0xc20
@@ -674,7 +707,7 @@
 #define REG_LSSI_WRITE_A	0x0c90
 #define REG_PREDISTA		0x0c90
 #define REG_TXAGCIDX		0x0c94
-
+#define REG_TX_AGC_A		0x0c94
 #define REG_RFE_PINMUX_A	0x0cb0
 #define REG_RFE_INV_A		0x0cb4
 #define REG_RFE_CTRL8		0x0cb4
@@ -683,6 +716,7 @@
 #define DPDT_CTRL_PIN		0x77
 #define RFE_INV_MASK		0x3ff00000
 #define REG_RFECTL_A		0x0cb8
+#define REG_RFE_INV0		0x0cbc
 #define REG_RFE_INV8		0x0cbd
 #define BIT_MASK_RFE_INV89	GENMASK(1, 0)
 #define REG_RFE_INV16		0x0cbe
@@ -703,6 +737,7 @@
 
 #define REG_3WIRE_SWB		0x0e00
 #define REG_RX_IQC_AB_B		0x0e10
+#define REG_RX_IQC_CD_B		0x0e14
 #define REG_TXSCALE_B		0x0e1c
 #define REG_TX_AGC_B_CCK_11_CCK_1		0xe20
 #define REG_TX_AGC_B_OFDM18_OFDM6		0xe24
@@ -729,6 +764,7 @@
 #define REG_LSSI_WRITE_B	0x0e90
 #define REG_PREDISTB		0x0e90
 #define REG_INIDLYB		0x0e94
+#define REG_TX_AGC_B		0x0e94
 #define REG_RFE_PINMUX_B	0x0eb0
 #define REG_RFE_INV_B		0x0eb4
 #define REG_RFECTL_B		0x0eb8
@@ -744,8 +780,11 @@
 #define REG_CRC_HT		0x0f10
 #define REG_CRC_OFDM		0x0f14
 #define REG_FA_OFDM		0x0f48
+#define REG_DBGRPT		0x0fa0
 #define REG_CCA_CCK		0x0fcc
 
+#define REG_SYS_CFG3_8814A	0x1000
+
 #define REG_ANAPARSW_MAC_0	0x1010
 #define BIT_CF_L_V2		GENMASK(29, 28)
 
@@ -863,9 +902,27 @@
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
+#define REG_AGC_TBL		0x1998
+
+#define REG_RX_IQC_AB_D		0x1a10
+#define REG_RX_IQC_CD_D		0x1a14
+#define REG_TXSCALE_D		0x1a1c
+#define REG_CK_MONHD		0x1a5c
+#define REG_AFE_PWR1_D		0x1a60
+#define REG_TX_AGC_D		0x1a94
+#define REG_RFE_PINMUX_D	0x1ab4
+#define REG_RFE_INVSEL_D	0x1abc
+#define BIT_RFE_SELSW0_D	GENMASK(27, 20)
 
 #define REG_NOMASK_TXBT	0x1ca7
 #define REG_ANAPAR	0x1c30
@@ -906,6 +963,7 @@
 #define RF18_BAND_MASK	(BIT(16) | BIT(9) | BIT(8))
 #define RF18_CHANNEL_MASK	(MASKBYTE0)
 #define RF18_RFSI_MASK	(BIT(18) | BIT(17))
+#define RF_RCK1_V1	0x1c
 #define RF_RCK		0x1d
 #define RF_MODE_TABLE_ADDR	0x30
 #define RF_MODE_TABLE_DATA0	0x31
-- 
2.48.1


