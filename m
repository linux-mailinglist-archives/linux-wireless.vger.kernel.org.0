Return-Path: <linux-wireless+bounces-18969-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBFFA370F7
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Feb 2025 23:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2CEF3A5EB7
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Feb 2025 22:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8A7189BB5;
	Sat, 15 Feb 2025 22:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjPIM89L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F2DDF59
	for <linux-wireless@vger.kernel.org>; Sat, 15 Feb 2025 22:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739656978; cv=none; b=IprxORHhXDYzjh2LjWNJ4AD6Jr31tUZyEVaCA5/cNtkQqWa3OpQN4DPonOrDP5cS8lfhltYlkRJ7zqVJepQYr3kGY0nSxxFRBJUn6qw147U56x2RgBeReIGxknuMX2IoIgsX2j8MuEoJBHP0cVXtDQgjllTarys3mwhi75uYKgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739656978; c=relaxed/simple;
	bh=67Rc8NpXjFsPum9Ra4nFA7haM+YGxAMxKJlJUQTkzlw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dA0LSkyuEsfmR58SDn16SgNtxfB2pRJheBSYk4qNFMReA+ZxEaE48uXk8dDOivVvI+QAZ0cah99wA9XDGd8NxpYPAPGMF7g/TlpzBzggg+fX1qx7p2oYD58CH9A+LFpvtsE1VHy0QNJ1kwiaCfncAF75wHE41d2u3Z3MXmhWj8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjPIM89L; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e0452f859cso500626a12.2
        for <linux-wireless@vger.kernel.org>; Sat, 15 Feb 2025 14:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739656974; x=1740261774; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tgYSZiV154BnCTr1HG6T5PPWEN74oa3N7N//QpWvHK8=;
        b=WjPIM89L1lla23eBywyju4xUBkBoSaCpJoWDGvzgCdYoKAZVZPyvHdoeROxTbfjcsI
         nDXjiXIPJJnSdfiZsNovBZu4q4J5FkfEdUXpXYH88odyjQRBRXQCjZEAhFzcKQ6ocRe/
         1+Wkb/aeGElhsAxqSHWpp0HpRtWlynkZ8JqhpX2jdxKhqQxcgYOKBMd2KShPCqKJYSt5
         yIETA0oD4Y+uAPqGZNWlGfO/RAN8rzCnU5nSFfjzSILAkSwpJQCVga1MrPgn0Og1Rmm2
         xB1+27wFivBifCegPq7pjYUM+RnkUnbik7lA4Darylgin791gJyqMVvZq2kVH90takGb
         CYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739656974; x=1740261774;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tgYSZiV154BnCTr1HG6T5PPWEN74oa3N7N//QpWvHK8=;
        b=BS1gTzH0gs756QtmH7we7zoJciIjZbi7fbcC9Pdya3gyh8EchicO0OSLBLmlVzLW1n
         Gr+YNnE/ID2DFyChqrOAP9VlHR6G4JzAfXcL00D4bCqpofEctp4HhZqRuo0Vg8+bf7Tz
         ccbNZGpeitT8yxNXq2iJrnO1rFU1kYhnI2PRSu8QYaH7419IK7S5XGSqmPw4Zp6KOqgW
         PjJONbHzLsSV1HmwyTb7WE27OMaEtGtMri/lTZ9gN0u7QRleR2cEjFEHSjrc/lxsfF1c
         wNbLGVp7EfLfgVkNY6N9LdRGIq6HRMHI2PBuEt6f7Q9mAowLDsWdR7Y+HEL6UEtYYE/A
         ANdQ==
X-Gm-Message-State: AOJu0Yzt5G4Nj/+dN4TnRk4FlmoX4TiOy4SoWU3clXnsP37W4Ckb0QtB
	HaYMjomW70EHeH1B2uxq3CeBBXDQz0FVzFHrZ19DmK+yvfrNYlid2SZYMQ==
X-Gm-Gg: ASbGncvIIguqSzysczSN8msFvE5J1R3VEixKJlBzVjiBKHUlNuL8tqARQV24YVpZcfc
	zycBeXS2KpNpf6jPjjAxDTCn64YxsurYwRtsfvlzNOcyh0bkpBbyFBjHx2mThd07XtrlRB3PVGA
	/T5JXNXb2kUMU6vCaIhDUBMvG6r+Ou7Atnqny8OHKM/vX3MMrogCaN3R6UZ8Mn+ZUw7XU0pKXby
	Gz1VyMLnQNqhUAylJMxcE5ohD/efp2AOFMrxtyqsjpBhln8JzQUozh52+Iw1mnlJt3yiIAbIuCO
	PImPjIVjNR3bhN06+1l+j35s
X-Google-Smtp-Source: AGHT+IHYQn+bDRTnvYy3tUvO5uXq/Gqet9vE6G4erFZ1Vx+RxrUDfvVQ2ylgx6/vw2iaETMkTUTjlw==
X-Received: by 2002:a05:6402:13c9:b0:5d3:e45d:ba91 with SMTP id 4fb4d7f45d1cf-5e0361916c7mr4801529a12.32.1739656974197;
        Sat, 15 Feb 2025 14:02:54 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.253])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1d3744sm5271065a12.42.2025.02.15.14.02.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Feb 2025 14:02:53 -0800 (PST)
Message-ID: <db9d68ca-a2ed-4f07-a80c-adf1bf403000@gmail.com>
Date: Sun, 16 Feb 2025 00:02:51 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 8/8] wifi: rtw88: Extend rtw_debugfs_get_tx_pwr_tbl() for
 RTL8814AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <12ab9180-45e9-40e5-98e0-6ef7b6c463d5@gmail.com>
Content-Language: en-US
In-Reply-To: <12ab9180-45e9-40e5-98e0-6ef7b6c463d5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Make it print the TX power details for all RF paths, not just A and B,
and for all the rates supported by the chip, not just 1SS and 2SS
rates.

Also skip the RF paths and rates not supported by the chip.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Print only information about the RF paths and spatial streams the
   chip actually has.
---
 drivers/net/wireless/realtek/rtw88/debug.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/debug.c b/drivers/net/wireless/realtek/rtw88/debug.c
index 1adb03d1210a..b67d69b01f87 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.c
+++ b/drivers/net/wireless/realtek/rtw88/debug.c
@@ -692,9 +692,11 @@ static int rtw_debugfs_get_tx_pwr_tbl(struct seq_file *m, void *v)
 {
 	struct rtw_debugfs_priv *debugfs_priv = m->private;
 	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
+	struct rtw_power_params pwr_param = {0};
 	struct rtw_hal *hal = &rtwdev->hal;
+	u8 nss = rtwdev->efuse.hw_cap.nss;
 	u8 path, rate, bw, ch, regd;
-	struct rtw_power_params pwr_param = {0};
+	u8 max_ht_rate, max_rate;
 
 	mutex_lock(&rtwdev->mutex);
 	bw = hal->current_band_width;
@@ -707,19 +709,23 @@ static int rtw_debugfs_get_tx_pwr_tbl(struct seq_file *m, void *v)
 	seq_printf(m, "%-4s %-10s %-9s %-9s (%-4s %-4s %-4s) %-4s\n",
 		   "path", "rate", "pwr", "base", "byr", "lmt", "sar", "rem");
 
+	max_ht_rate = DESC_RATEMCS0 + nss * 8 - 1;
+
+	if (rtwdev->chip->vht_supported)
+		max_rate = DESC_RATEVHT1SS_MCS0 + nss * 10 - 1;
+	else
+		max_rate = max_ht_rate;
+
 	mutex_lock(&hal->tx_power_mutex);
-	for (path = RF_PATH_A; path <= RF_PATH_B; path++) {
+	for (path = RF_PATH_A; path < hal->rf_path_num; path++) {
 		/* there is no CCK rates used in 5G */
 		if (hal->current_band_type == RTW_BAND_5G)
 			rate = DESC_RATE6M;
 		else
 			rate = DESC_RATE1M;
 
-		/* now, not support vht 3ss and vht 4ss*/
-		for (; rate <= DESC_RATEVHT2SS_MCS9; rate++) {
-			/* now, not support ht 3ss and ht 4ss*/
-			if (rate > DESC_RATEMCS15 &&
-			    rate < DESC_RATEVHT1SS_MCS0)
+		for (; rate <= max_rate; rate++) {
+			if (rate > max_ht_rate && rate <= DESC_RATEMCS31)
 				continue;
 
 			rtw_get_tx_power_params(rtwdev, path, rate, bw,
-- 
2.48.1


