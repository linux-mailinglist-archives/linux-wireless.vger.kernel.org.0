Return-Path: <linux-wireless+bounces-26270-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B18B0B210B7
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 18:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C00517CEEF
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 15:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8BD2D47E4;
	Mon, 11 Aug 2025 15:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KagQ26yy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943CB2C21E9
	for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 15:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754926414; cv=none; b=dB4/PMl9ecQNYLYEkXkEYJcx9WhMnXxsfGNAlbC6gnVoN8jID+USkeCuugKr0NW2zvlDFD/kGWqubWVvMS+6IHf5gfQKgls0EMuDhqJSLElbE0uTqXEcuYTIR5f2Fu3sNcQG12hoSAEn3x7MpliUFbw9DU/XPPxNFyPwI7RNgUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754926414; c=relaxed/simple;
	bh=/pWxoYfLjAdAdAWgObRcIFZvhaUnf/vE5ij1Wz3Za4c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rYOTb6ZCfOeEYfH7HbaWkjhOV3oFMIQjsaz0f2K64EUaXgJV4+oqBvc1wLBkdSb6kI0mhRcAxnZZJ1vUpx74HH/KsX8VFlYYVgtvpukhlPYShh106kp0dAH79Z42TSNDN1GH+yzh9YwOL0hKNRZ7vmA5PgocoJm98Kz7FuXAIQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KagQ26yy; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-458ba079338so35088235e9.1
        for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 08:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754926411; x=1755531211; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G5J8wjZWPfWYu1YaXrptanzmmraHASS1ULU7kIdDquY=;
        b=KagQ26yy2FQxeN/P7B8ari9j0rotBwC/D08RyIrhxOD9jC1fCsBXbCsb3RZTEDiy44
         hWD1FTALKJ+ZeuMW2DCj+H+yAUQeLGEpDPlL5XKymUTHK8TI2Q4TmJtIvGxIP/o3ZZol
         kTeDvb/No5EeqdWzflANjWnSi3aRAZt5Fl2bNXCUHnp82CoWbKPbBkV7gWYTY8GNPv8M
         vXlDelK60yIzaqghQiMCSlNdE0fyAEq5Zr7xqnl42bKFGZA1vhSB9LSAP2b5vzz+xUtL
         +VYVKBZaMQVi2ZR69jo7ew5XLaR09pdGwCWdsH54sj951/gpGsub6BQ0uF3WjkdxSyuG
         XhmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754926411; x=1755531211;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G5J8wjZWPfWYu1YaXrptanzmmraHASS1ULU7kIdDquY=;
        b=Fg6Q1vCthU2RPA5nWn3toz3g3M6vZF1hfUNq55I5Gf1Oo1qdc6Zdgt0hQk5uJ9lgBL
         IcQNRw3QvQ6yVvKBrzQq2X5nMKc502A8XhjgBaBX7gSRRRZATr6KWHWDwB2WBEmJDFNz
         XOSUiYvNuBe4NAZ73qRxCclTqeUwtpW0iqs+3FARrP3RGV6dpUAE8akBmqt2EFKOlQ39
         Shfny8K9R279PNRktm2cglBgEaV0b1jlhDCaD7RQ46yoc1gLWiBscaUp1gFLBt/y3325
         K8CzTXWTaNUH5WbApwdfn1gjTwmLPqFFPXNwMmdcmsdUgg5g+fGtz3dhdsDPxjQdawCG
         G4AA==
X-Gm-Message-State: AOJu0Yzz8REsB+IuGc9e2Zwn3vzZTqhtBk9/GXKse3CnUgYHGyJHDJb9
	04y7k1jnjSAqXFQBwKlwJT0yWAqXBunk7BJfWV4LlRugzAbzfFnQg6fKUO54Yg==
X-Gm-Gg: ASbGncvZXO1LLE7s/w2QphBLas66ZYyM7eQgqnH2od+eaUFs0XiB3AjxiLvCHzHJMNz
	KyCzvLYVVXCNCSvRB5Ka+6m6CJLigVB/zHTbZeDnKwDEywPr9czV++EW3BjQvZ/sf9I7ga9rvhl
	mJC9kHVTXn4Q+4w8k2O7vWZSpTWEqqmsVbjCcOGhQHbF9Rafv8PHpk9TZXamKSYJUI+ujNTqdTW
	te1C8SfD+Yl8loKbZ3/JtSOO2hkdVacdqdhITbt9dEPN4AcMRQsnIc8a/+XpUWTpu/Lryj09dDG
	KkfY0/rwr9Qo+zsEqaS0kApsbSEkidi6/dM467xL3WQEnKe8tp0q2r3vaOvpxHLWn7NINmMIFCp
	vXyQarA8usxdxqrqYuws9CT7ZqnWFnQ==
X-Google-Smtp-Source: AGHT+IG3v+PCvggDK97i5+hKG4G9Lw8f8UWqxqIx+V1MwdcYAD8AoenxNfcupEXLbbPeZbOzEJCvJQ==
X-Received: by 2002:a05:600c:3e06:b0:458:6f13:aa4a with SMTP id 5b1f17b1804b1-45a10d4fd0fmr435885e9.6.1754926410833;
        Mon, 11 Aug 2025 08:33:30 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459eec47306sm196760315e9.28.2025.08.11.08.33.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 08:33:30 -0700 (PDT)
Message-ID: <f147b2ab-4505-435a-aa32-62964e4f1f1e@gmail.com>
Date: Mon, 11 Aug 2025 18:33:28 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 2/2] wifi: rtl8xxxu: Don't claim USB ID 07b8:8188
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Helge Deller <deller@gmx.de>
References: <2e5e2348-bdb3-44b2-92b2-0231dbf464b0@gmail.com>
Content-Language: en-US
In-Reply-To: <2e5e2348-bdb3-44b2-92b2-0231dbf464b0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This ID appears to be RTL8188SU, not RTL8188CU. This is the wrong driver
for RTL8188SU. The r8712u driver from staging used to handle this ID.

Closes: https://lore.kernel.org/linux-wireless/ee0acfef-a753-4f90-87df-15f8eaa9c3a8@gmx.de/
Cc: stable@vger.kernel.org
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index 8ed1218654d3..44f901aa3b3f 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -7998,8 +7998,6 @@ static const struct usb_device_id dev_table[] = {
 	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0x06f8, 0xe033, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192cu_fops},
-{USB_DEVICE_AND_INTERFACE_INFO(0x07b8, 0x8188, 0xff, 0xff, 0xff),
-	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0x07b8, 0x8189, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0x0846, 0x9041, 0xff, 0xff, 0xff),
-- 
2.50.1


