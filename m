Return-Path: <linux-wireless+bounces-4272-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7F686D6E6
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 23:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D055288E2A
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 22:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C50200D2;
	Thu, 29 Feb 2024 22:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5TVpGzz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EDE200D6
	for <linux-wireless@vger.kernel.org>; Thu, 29 Feb 2024 22:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709246113; cv=none; b=h1qN1fQpoEf1h6fQV6hQLm3Bw5G/fENEgHvnJiuqBmdOdm8euMipJ9f5Ew7rbwvZISnFhzG+hBW/GPVUuSOcgp7cFCCcNWkLZXOQfIfv8KeDkJEpH4sEXfumdndgj7VBRh/SQWSyS9tpuoicOvxIRh0jxUjOohoYrw3+hQz243A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709246113; c=relaxed/simple;
	bh=Y9ZNtBb2i8bkQqqVZSFI03rn3V2CJEjmODvUowGdR2o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MnbuSN69X7VKpYnfd3PMF5Ss3GggyihC+DekM2rAltexxBJRGG8mby/pDa8o4/h3+9kDm2B9On2iV9+kDqeIfKbN3aHyz7DLlzOabIrqjSdnSFhlnY9KOwq8oKzQoznuAQFSE73F8xhJTg90gf547S3KV/MTTNmOalBcykKKeZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5TVpGzz; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-512f54fc2dbso1232777e87.1
        for <linux-wireless@vger.kernel.org>; Thu, 29 Feb 2024 14:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709246110; x=1709850910; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u8QSQ/xkN8iJeY3GCsJrJUDcbOEjNrSo0xZqIJB6tho=;
        b=h5TVpGzzU6s+yp+mbkoUxL3bdkq9vV8q01CQMnV3O6WmwtiSx/L83L70eWmR8vaerr
         tacMwPePDMx91Pb4Qme3eShHrpgOUdcVAhOpc2QypQpOSIa63yLKKLc2//9sZTp3LuZd
         eDsjA0mLy2AFf6w/yrGOcUEXjQeH0VEVRg1NVfa2GXraKUp70ga1BBnCQXsLj80CZyHi
         aYm4p1Gzf/e9cPYz9f012Kwu/nTlvlPls/p9sKksN56cEnhcE7zUGgjJPbnXfKv+FvDS
         skV5hNy7YEPau8/XxNkGmThQvG+WzoKwG6Ejy+v9DoLYJxfUhJOvM8m4gDUKe9M8vImZ
         hztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709246110; x=1709850910;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u8QSQ/xkN8iJeY3GCsJrJUDcbOEjNrSo0xZqIJB6tho=;
        b=omIQPxs2FTetNjYH9Gsr3Fl77b3Lh7E5smW79bgIHNZJSGUuD9PBaQeqUw2Knl4ILa
         poTBlj3YT9hZ7RReSl0TnHj6SKbWJwYnGGjFNJyWRhbBUEilpuyChFD/sYD+qRYnnYa5
         n3dTecRuLabuTNVwmm7Pc4z9umELFVhNUS5kj68kkDaV6CRZoCgbUN+6kQixsFYyl1pP
         JlPvANcwTig1/Gp+U6dIK7a8YbOt1l+OTMHvFPazSy6BmIzkS7a6ITl2OiHmj6gmJeNW
         nQn1a7MYyBf9Qq0cDJQRshjMyjj9MNbEXETU0aDwnPAy27bdmxtTfty4ocDIes+sJW1K
         /IDw==
X-Gm-Message-State: AOJu0YyHgIebzH2zuEgv+wyDtG4JV0OrW3+27BGnOzSdnK0VDuFT9+kF
	D4qLCVDNIQLwIM+af+6InUm6ObeP4DV8/1t76GaVwKci6R0zP0KZxgaYxDvs
X-Google-Smtp-Source: AGHT+IGZjHzV9RxE+21jdyL1swDMuMZybAcsxLWU+yiIkxTSNEVpjLjxzAaoWQsGeqdnMCvsHviXEw==
X-Received: by 2002:a05:6512:3493:b0:512:ed78:a840 with SMTP id v19-20020a056512349300b00512ed78a840mr2075171lfr.61.1709246110142;
        Thu, 29 Feb 2024 14:35:10 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id f18-20020a05600c155200b00412b68cc169sm3360442wmg.16.2024.02.29.14.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 14:35:09 -0800 (PST)
Message-ID: <276c31d8-b9a8-4e54-a3ac-09b74657aff7@gmail.com>
Date: Fri, 1 Mar 2024 00:35:09 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 3/4] wifi: rtw88: 8821c: Fix beacon loss and disconnect
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Sascha Hauer <sha@pengutronix.de>
References: <f12ed39d-28e8-4b8b-8d22-447bcf295afc@gmail.com>
In-Reply-To: <f12ed39d-28e8-4b8b-8d22-447bcf295afc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Tenda U9 V2.0, which contains RTL8811CU, is practically unusable because
of frequent disconnections:

Feb 23 14:46:45 ideapad2 wpa_supplicant[427]: wlp3s0f3u2: CTRL-EVENT-BEACON-LOSS
Feb 23 14:46:46 ideapad2 wpa_supplicant[427]: wlp3s0f3u2: CTRL-EVENT-DISCONNECTED
	bssid=90:55:de:__:__:__ reason=4 locally_generated=1

Feb 23 14:46:52 ideapad2 wpa_supplicant[427]: wlp3s0f3u2: CTRL-EVENT-CONNECTED
	- Connection to 90:55:de:__:__:__ completed [id=0 id_str=]
Feb 23 14:46:54 ideapad2 wpa_supplicant[427]: wlp3s0f3u2: CTRL-EVENT-BEACON-LOSS
Feb 23 14:46:55 ideapad2 wpa_supplicant[427]: wlp3s0f3u2: CTRL-EVENT-DISCONNECTED
	bssid=90:55:de:__:__:__ reason=4 locally_generated=1

Feb 23 14:47:01 ideapad2 wpa_supplicant[427]: wlp3s0f3u2: CTRL-EVENT-CONNECTED
	- Connection to 90:55:de:__:__:__ completed [id=0 id_str=]
Feb 23 14:47:04 ideapad2 wpa_supplicant[427]: wlp3s0f3u2: CTRL-EVENT-BEACON-LOSS
Feb 23 14:47:05 ideapad2 wpa_supplicant[427]: wlp3s0f3u2: CTRL-EVENT-DISCONNECTED
	bssid=90:55:de:__:__:__ reason=4 locally_generated=1

This is caused by a mistake in the chip initialisation. This version of
the chip requires loading an extra AGC table right after the main one,
but the extra table is being loaded at the wrong time, in
rtw_chip_board_info_setup().

Move the extra AGC table loading to the right place, in
rtw_phy_load_tables().

The rtw_chip_board_info_setup() can only do "software" things, and
rtw_phy_load_tables() can really do IO.

Fixes: 5d6651fe8583 ("rtw88: 8821c: support RFE type2 wifi NIC")
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Add more information in the commit message.
---
 drivers/net/wireless/realtek/rtw88/main.c | 2 --
 drivers/net/wireless/realtek/rtw88/phy.c  | 3 +++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 6d22628129d0..ffba6b88f392 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -2032,8 +2032,6 @@ static int rtw_chip_board_info_setup(struct rtw_dev *rtwdev)
 	rtw_phy_setup_phy_cond(rtwdev, hal->pkg_type);
 
 	rtw_phy_init_tx_power(rtwdev);
-	if (rfe_def->agc_btg_tbl)
-		rtw_load_table(rtwdev, rfe_def->agc_btg_tbl);
 	rtw_load_table(rtwdev, rfe_def->phy_pg_tbl);
 	rtw_load_table(rtwdev, rfe_def->txpwr_lmt_tbl);
 	rtw_phy_tx_power_by_rate_config(hal);
diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index 128e75a81bf3..37ef80c9091d 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -1761,12 +1761,15 @@ static void rtw_load_rfk_table(struct rtw_dev *rtwdev)
 
 void rtw_phy_load_tables(struct rtw_dev *rtwdev)
 {
+	const struct rtw_rfe_def *rfe_def = rtw_get_rfe_def(rtwdev);
 	const struct rtw_chip_info *chip = rtwdev->chip;
 	u8 rf_path;
 
 	rtw_load_table(rtwdev, chip->mac_tbl);
 	rtw_load_table(rtwdev, chip->bb_tbl);
 	rtw_load_table(rtwdev, chip->agc_tbl);
+	if (rfe_def->agc_btg_tbl)
+		rtw_load_table(rtwdev, rfe_def->agc_btg_tbl);
 	rtw_load_rfk_table(rtwdev);
 
 	for (rf_path = 0; rf_path < rtwdev->hal.rf_path_num; rf_path++) {
-- 
2.43.2

