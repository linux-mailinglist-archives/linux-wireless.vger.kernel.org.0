Return-Path: <linux-wireless+bounces-18467-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBCEA27A30
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 19:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2964D165D7E
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 18:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707D6216E39;
	Tue,  4 Feb 2025 18:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjWrqpkR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6211A20DD4B
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 18:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738694428; cv=none; b=OIiyGTkb2HYtm6IGmlp8vu7pYu65gEuBSgCM5aNLYczJl+YxDFRMKlgVZDVICHaXd4fPSkGb5ZcJduOHofkR0fCJ8aLyWKOT3LQbjcNBZAn+oQjpRJlESZbU6+Ryt4uJ62AiSUhjDDUtbWUqZ0lgRasK5UqJkxXnOMKKhKUU8Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738694428; c=relaxed/simple;
	bh=bI0BBcokIzF/80LySoS6lvWJzFpPwj8i8zQsLC5yz20=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=afm1rvj93voVBPu6vtNeOT992vukhOFc7BxyarwfEcfZIfR+hOgEEVbp+oKfwYvtdYRRD6x+Ilj+WRJFgCPrqmgpFo7C4Msm56uEeHjGQ8W6mNxaWxUgXiAIM3yoFOooHG5EN2+iHy1xPrdaMZFSabuIuuxUGi1KRzoEs/wF44U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjWrqpkR; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab7157cf352so16014166b.0
        for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 10:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738694424; x=1739299224; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MKeFxva4ey5PYa+BWeditG9GTrM3RNTkIf+AqRrPRWg=;
        b=VjWrqpkRM3EOc1/EeOn741OqwKF4O5sLTrFY6OXnfMFxA2/c1dYi0sS2PjQYEvOzWR
         QWIGvtdxQSwERHRkkPXOra5Gc2UsJ1B7yKk7esQS1q381UIWSH+Ex9ABVwEm1BhxtOD3
         IYnFMZUuElD2oMP1wvcBiV9GA6no+kO5inXHBGzLrkCtP9jcQTPuq9e8Jn2NWBOLRDQ4
         vgAUIRWrb+Fy+lAit8nflD+FnhmbVA9SEi8aw8/yg5/NAGShGjf9ZfAuSgY/Y/okWf3h
         SuC1osmsdf/o5Lo3jXYuRn+fQeMgRE5ocEvdqXouXLPlGc3i6LqIC/N3hvVzq/S5zw5P
         M9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738694425; x=1739299225;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MKeFxva4ey5PYa+BWeditG9GTrM3RNTkIf+AqRrPRWg=;
        b=U751ndnaTJSs7eaWbUPuEuNXLdB1CIEjhoFV9DXNzDXFh3P0ZdfDaZm/7j7Vespyj9
         YpX3PLAnEeZTDWdUNP3w3EJnbwEaUw3dnkbm2iGphKe2SD0zNjXcOMvgmkvbiqOVbU6f
         mb2jJc+0P3B/F/+Z/gShKaiNiFWYuJwq9749K7MY+2TYVngYndU5qPSkTpFvXdryb5Ue
         DAzWJS/t8Lq1w+A6aHCd4Hc6q35IPNSThdVPDBbCXf2TT/A+g/f+IndFhBgIP2wTHV16
         TGxzYoZH4Uws/m5YF5kofxkXyV5OHLUj2QldtGiniD6L953at8BOP433VQ3H3baOs1U2
         642g==
X-Gm-Message-State: AOJu0Yw3zhKajx+TR7ubL9FARnylB3dydBkdAaAF3toePPRogA0aLJif
	EN+fbIr6cFnXU38GFoLmp5rkQbtZF6lg4nuPM1Nc72ByChCImauREqYiFQ==
X-Gm-Gg: ASbGnctjzuYz3Jp9u7CLer0GVpBrvQuiyp9/v9h7jK0Zr09ceiOt9svL6GUI6wSYdgx
	PK9bGBQGRg5/KS3aR+8l027U9iuvsnd85p3qJQhGDnUwwPYwoNJJXeYRsCL9bSD1lCP/ZHaFtIc
	YZ7f6iY757Kqhsab39t770S93jo9Zzx8bd1OyiFqBUvu7nhT9uLVpebpr+3vbPlSVMSc6WwKMSJ
	IZ0ABixF3HkC4eVpckp7VgpR6JVD04kDncdP9b60obJjHA5DXBBN+9mEkFDkD3wtYY3+t8HiCTP
	ptGV3hjQVhbQ4dvid23gdzMK
X-Google-Smtp-Source: AGHT+IFKfynLQHr5hTfFgrBEKGzZAkdwfUZm5EMsQhwuMrPtQW3hpBpF5yu9ov+30wWnZTdFITDhIg==
X-Received: by 2002:a17:907:da7:b0:ab3:3b92:8ca5 with SMTP id a640c23a62f3a-ab7483fba3cmr479689766b.12.1738694424433;
        Tue, 04 Feb 2025 10:40:24 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7008b2c04sm759143466b.33.2025.02.04.10.40.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 10:40:24 -0800 (PST)
Message-ID: <502f124e-ccf3-4c09-80a4-1e5c5304822b@gmail.com>
Date: Tue, 4 Feb 2025 20:40:22 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 6/9] wifi: rtw88: Constify some more structs and arrays
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <9fc518ae-7708-42c6-99ca-56ee307555b6@gmail.com>
Content-Language: en-US
In-Reply-To: <9fc518ae-7708-42c6-99ca-56ee307555b6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

These structs and arrays are never modified, so make them const:

rtw_band_2ghz
rtw_band_5ghz
rtw_pci_tx_queue_idx_addr
rtw_pci_ops
rtw_cck_rates
rtw_ofdm_rates
rtw_ht_1s_rates
rtw_ht_2s_rates
rtw_vht_1s_rates
rtw_vht_2s_rates
rtw_rate_section
rtw_rate_size
rtw_sdio_ops
rtw_usb_ops

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Patch is new in v2.
---
 drivers/net/wireless/realtek/rtw88/main.c |  4 ++--
 drivers/net/wireless/realtek/rtw88/main.h |  2 +-
 drivers/net/wireless/realtek/rtw88/pci.c  |  4 ++--
 drivers/net/wireless/realtek/rtw88/phy.c  | 26 ++++++++++++++---------
 drivers/net/wireless/realtek/rtw88/phy.h  | 16 +++++++-------
 drivers/net/wireless/realtek/rtw88/sdio.c |  2 +-
 drivers/net/wireless/realtek/rtw88/usb.c  |  2 +-
 7 files changed, 31 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 0cee0fd8c0ef..8d22df293e78 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -136,7 +136,7 @@ u16 rtw_desc_to_bitrate(u8 desc_rate)
 	return rate.bitrate;
 }
 
-static struct ieee80211_supported_band rtw_band_2ghz = {
+static const struct ieee80211_supported_band rtw_band_2ghz = {
 	.band = NL80211_BAND_2GHZ,
 
 	.channels = rtw_channeltable_2g,
@@ -149,7 +149,7 @@ static struct ieee80211_supported_band rtw_band_2ghz = {
 	.vht_cap = {0},
 };
 
-static struct ieee80211_supported_band rtw_band_5ghz = {
+static const struct ieee80211_supported_band rtw_band_5ghz = {
 	.band = NL80211_BAND_5GHZ,
 
 	.channels = rtw_channeltable_5g,
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 993c381e734b..c982d9d3c5d7 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -61,7 +61,7 @@ enum rtw_hci_type {
 };
 
 struct rtw_hci {
-	struct rtw_hci_ops *ops;
+	const struct rtw_hci_ops *ops;
 	enum rtw_hci_type type;
 
 	u32 rpwm_addr;
diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 0ecaefc4c83d..bb4c4ccb31d4 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -20,7 +20,7 @@ module_param_named(disable_aspm, rtw_pci_disable_aspm, bool, 0644);
 MODULE_PARM_DESC(disable_msi, "Set Y to disable MSI interrupt support");
 MODULE_PARM_DESC(disable_aspm, "Set Y to disable PCI ASPM support");
 
-static u32 rtw_pci_tx_queue_idx_addr[] = {
+static const u32 rtw_pci_tx_queue_idx_addr[] = {
 	[RTW_TX_QUEUE_BK]	= RTK_PCI_TXBD_IDX_BKQ,
 	[RTW_TX_QUEUE_BE]	= RTK_PCI_TXBD_IDX_BEQ,
 	[RTW_TX_QUEUE_VI]	= RTK_PCI_TXBD_IDX_VIQ,
@@ -1591,7 +1591,7 @@ static void rtw_pci_destroy(struct rtw_dev *rtwdev, struct pci_dev *pdev)
 	rtw_pci_io_unmapping(rtwdev, pdev);
 }
 
-static struct rtw_hci_ops rtw_pci_ops = {
+static const struct rtw_hci_ops rtw_pci_ops = {
 	.tx_write = rtw_pci_tx_write,
 	.tx_kick_off = rtw_pci_tx_kick_off,
 	.flush_queues = rtw_pci_flush_queues,
diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index 8ed20c89d216..f6528016973d 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -52,44 +52,50 @@ static const u32 db_invert_table[12][8] = {
 	 1995262315,	2511886432U,	3162277660U,	3981071706U}
 };
 
-u8 rtw_cck_rates[] = { DESC_RATE1M, DESC_RATE2M, DESC_RATE5_5M, DESC_RATE11M };
-u8 rtw_ofdm_rates[] = {
+const u8 rtw_cck_rates[] = { DESC_RATE1M, DESC_RATE2M, DESC_RATE5_5M, DESC_RATE11M };
+
+const u8 rtw_ofdm_rates[] = {
 	DESC_RATE6M,  DESC_RATE9M,  DESC_RATE12M,
 	DESC_RATE18M, DESC_RATE24M, DESC_RATE36M,
 	DESC_RATE48M, DESC_RATE54M
 };
-u8 rtw_ht_1s_rates[] = {
+
+const u8 rtw_ht_1s_rates[] = {
 	DESC_RATEMCS0, DESC_RATEMCS1, DESC_RATEMCS2,
 	DESC_RATEMCS3, DESC_RATEMCS4, DESC_RATEMCS5,
 	DESC_RATEMCS6, DESC_RATEMCS7
 };
-u8 rtw_ht_2s_rates[] = {
+
+const u8 rtw_ht_2s_rates[] = {
 	DESC_RATEMCS8,  DESC_RATEMCS9,  DESC_RATEMCS10,
 	DESC_RATEMCS11, DESC_RATEMCS12, DESC_RATEMCS13,
 	DESC_RATEMCS14, DESC_RATEMCS15
 };
-u8 rtw_vht_1s_rates[] = {
+
+const u8 rtw_vht_1s_rates[] = {
 	DESC_RATEVHT1SS_MCS0, DESC_RATEVHT1SS_MCS1,
 	DESC_RATEVHT1SS_MCS2, DESC_RATEVHT1SS_MCS3,
 	DESC_RATEVHT1SS_MCS4, DESC_RATEVHT1SS_MCS5,
 	DESC_RATEVHT1SS_MCS6, DESC_RATEVHT1SS_MCS7,
 	DESC_RATEVHT1SS_MCS8, DESC_RATEVHT1SS_MCS9
 };
-u8 rtw_vht_2s_rates[] = {
+
+const u8 rtw_vht_2s_rates[] = {
 	DESC_RATEVHT2SS_MCS0, DESC_RATEVHT2SS_MCS1,
 	DESC_RATEVHT2SS_MCS2, DESC_RATEVHT2SS_MCS3,
 	DESC_RATEVHT2SS_MCS4, DESC_RATEVHT2SS_MCS5,
 	DESC_RATEVHT2SS_MCS6, DESC_RATEVHT2SS_MCS7,
 	DESC_RATEVHT2SS_MCS8, DESC_RATEVHT2SS_MCS9
 };
-u8 *rtw_rate_section[RTW_RATE_SECTION_MAX] = {
+
+const u8 * const rtw_rate_section[RTW_RATE_SECTION_MAX] = {
 	rtw_cck_rates, rtw_ofdm_rates,
 	rtw_ht_1s_rates, rtw_ht_2s_rates,
 	rtw_vht_1s_rates, rtw_vht_2s_rates
 };
 EXPORT_SYMBOL(rtw_rate_section);
 
-u8 rtw_rate_size[RTW_RATE_SECTION_MAX] = {
+const u8 rtw_rate_size[RTW_RATE_SECTION_MAX] = {
 	ARRAY_SIZE(rtw_cck_rates),
 	ARRAY_SIZE(rtw_ofdm_rates),
 	ARRAY_SIZE(rtw_ht_1s_rates),
@@ -2214,7 +2220,7 @@ static void rtw_phy_set_tx_power_index_by_rs(struct rtw_dev *rtwdev,
 {
 	struct rtw_hal *hal = &rtwdev->hal;
 	u8 regd = rtw_regd_get(rtwdev);
-	u8 *rates;
+	const u8 *rates;
 	u8 size;
 	u8 rate;
 	u8 pwr_idx;
@@ -2274,7 +2280,7 @@ EXPORT_SYMBOL(rtw_phy_set_tx_power_level);
 
 static void
 rtw_phy_tx_power_by_rate_config_by_path(struct rtw_hal *hal, u8 path,
-					u8 rs, u8 size, u8 *rates)
+					u8 rs, u8 size, const u8 *rates)
 {
 	u8 rate;
 	u8 base_idx, rate_idx;
diff --git a/drivers/net/wireless/realtek/rtw88/phy.h b/drivers/net/wireless/realtek/rtw88/phy.h
index ccfcbd3ced03..ce6ee16a77dc 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.h
+++ b/drivers/net/wireless/realtek/rtw88/phy.h
@@ -7,14 +7,14 @@
 
 #include "debug.h"
 
-extern u8 rtw_cck_rates[];
-extern u8 rtw_ofdm_rates[];
-extern u8 rtw_ht_1s_rates[];
-extern u8 rtw_ht_2s_rates[];
-extern u8 rtw_vht_1s_rates[];
-extern u8 rtw_vht_2s_rates[];
-extern u8 *rtw_rate_section[];
-extern u8 rtw_rate_size[];
+extern const u8 rtw_cck_rates[];
+extern const u8 rtw_ofdm_rates[];
+extern const u8 rtw_ht_1s_rates[];
+extern const u8 rtw_ht_2s_rates[];
+extern const u8 rtw_vht_1s_rates[];
+extern const u8 rtw_vht_2s_rates[];
+extern const u8 * const rtw_rate_section[];
+extern const u8 rtw_rate_size[];
 
 void rtw_phy_init(struct rtw_dev *rtwdev);
 void rtw_phy_dynamic_mechanism(struct rtw_dev *rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index e024061bdbf7..6209a49312f1 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -1147,7 +1147,7 @@ static void rtw_sdio_declaim(struct rtw_dev *rtwdev,
 	sdio_release_host(sdio_func);
 }
 
-static struct rtw_hci_ops rtw_sdio_ops = {
+static const struct rtw_hci_ops rtw_sdio_ops = {
 	.tx_write = rtw_sdio_tx_write,
 	.tx_kick_off = rtw_sdio_tx_kick_off,
 	.setup = rtw_sdio_setup,
diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index c4908db4ff0e..c8092fa0d9f1 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -881,7 +881,7 @@ static void rtw_usb_dynamic_rx_agg(struct rtw_dev *rtwdev, bool enable)
 	}
 }
 
-static struct rtw_hci_ops rtw_usb_ops = {
+static const struct rtw_hci_ops rtw_usb_ops = {
 	.tx_write = rtw_usb_tx_write,
 	.tx_kick_off = rtw_usb_tx_kick_off,
 	.setup = rtw_usb_setup,
-- 
2.48.1


