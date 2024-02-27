Return-Path: <linux-wireless+bounces-4084-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A680886904B
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 13:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAC081C21161
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 12:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FCF13A258;
	Tue, 27 Feb 2024 12:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1P7k4Sa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C600213A267
	for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 12:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709036405; cv=none; b=YiyI9fGqAidv6RZqWeQ7ucFQsFHH9Xr1/eb27tC6/dxMBsnpnIUReRhGm+EEIaJ3Gpwmcy7cc9wn9BujcnnErVEOWZbhOaKRG22tcguXk0w+isSL9N683WFmNEtr7TLRd/rkqmd75ZP11njHV+S6juFbot4s2287RCjdIU5oUxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709036405; c=relaxed/simple;
	bh=nW7KXEEaLCPfga26i7X3zXuzpsGSjvE7OjE+DTRQwCA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=RS0lwqpy7gDMrE8KsjjehE+ARcuRITpaSF2y6qDn80tHS9Jb4yrS7m2gXcy06J2boWN1wcBh+8WVpJQvsTE0+F5tSJdK62sepu5499JoLFRW2vZnxHG2tU1D2+tJPMrFJCSaBnK27WOKvS1tlQLC9Qtq7AVWFahAqIgntOUfUfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1P7k4Sa; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-512e39226efso5645832e87.0
        for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 04:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709036402; x=1709641202; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tCkFfO9aYHHRUW7DIEQwtmcVQre/CtrWWgRSQ2n8UI4=;
        b=m1P7k4Saj90GjjDGsTxc1G9phx47OMnasHUgz78MjNCEi3cEWHslgeHhXW4vs/YzWz
         x/6z3l4PvyqkWWasgq7T0+0W1dbXt6pxsmYEFGsIIG0g0bTDqgwNcVOmhjK9UIliYlnQ
         OhF6COAUG/LwuiTk5URC3QXKoOf3kOO6DHtCqs5j8sqgj3RhObTJZQ6PMbPYzTPZjhSq
         PxMMmfJ8HVNW/0y7WGj99gkpLfKX0GCPqzRT36Qa77yujOCLQYCHyHOxCzZmVRY47ftn
         AEB6S2YThQ5bsVEMG7pjagS+QyqX8Wz5T+ovNYpC1E+5BJBek7kKLeqoV5EprAVOSL7G
         9edg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709036402; x=1709641202;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tCkFfO9aYHHRUW7DIEQwtmcVQre/CtrWWgRSQ2n8UI4=;
        b=T01fHXBQATC8T7prJI/VV4WFlGdzVHJXHww+p1qMh8whZeZrrkW7EIMawiSHMzjt+K
         0ltwCKleTJmCMvxBO/y5yM7jkaZD1aMjJDHwqmZjXkkcWrvbRzR9skfV9JAZVwhkuHgA
         OOtGtOotWxNPKwfF63kLJOC8xTjNimSGo+zR5iExdhvVb1MGN+rpJqDWr9iYXHYrDG4h
         qKFe1bpgtzhkbNc4IlnmfQYcqPSCo7H71B1B1hNUQUB3LgLGOWg2XRGROcVRlzNDlaD2
         9DJCZdhiY+2O214ficoOLS0R6taorERSoQmqbKw8vLs5mUXuPevZvzxy2oKrSzwnROOK
         z4gg==
X-Gm-Message-State: AOJu0YwOZ8cCWRIeUaOVYWEZ4NHwN4jGY2t+EOB5EqghyTCSw7MT8fAT
	/PDiMmcaKihid+FszwVkEhCII5ClwUgBIi8Zd12MJXz2L+rFxqQXjMCvM2HJ
X-Google-Smtp-Source: AGHT+IEYjmwbCD/f+oguUQl5OFl4mTGpmhJACRw0GkIX10M7+gHY6l8vczA16QhqHyqMORuqsDc5ig==
X-Received: by 2002:a05:6512:38c5:b0:511:4253:3a8b with SMTP id p5-20020a05651238c500b0051142533a8bmr6076053lft.42.1709036401715;
        Tue, 27 Feb 2024 04:20:01 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id dj16-20020a05640231b000b00566317ad834sm681406edb.49.2024.02.27.04.20.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 04:20:01 -0800 (PST)
Message-ID: <e2d717f7-2e5b-47ff-a99f-f692e9c07003@gmail.com>
Date: Tue, 27 Feb 2024 14:20:01 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH 3/4] wifi: rtw88: 8821c: Fix beacon loss and disconnect
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <909d9f75-44cd-4710-9d3f-56691fd58090@gmail.com>
Content-Language: en-US
In-Reply-To: <909d9f75-44cd-4710-9d3f-56691fd58090@gmail.com>
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
but the extra table is being loaded at the wrong time.

Move the extra AGC table loading to the right place.

Fixes: 5d6651fe8583 ("rtw88: 8821c: support RFE type2 wifi NIC")
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
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

