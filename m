Return-Path: <linux-wireless+bounces-10162-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6031192DBB3
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2024 00:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C8C91C20D2B
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jul 2024 22:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F08145FE9;
	Wed, 10 Jul 2024 22:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyR4fu68"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D162B12CD88
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jul 2024 22:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720649669; cv=none; b=qWxj0FMaN2M6pAlhgD0w7X9KdKfdNaBa/PpxfeI7xeOQbKmwNwzkfvoYELVtGSLLFVohiFeixYWF2IUeWOCjvwzc+Vh+SnahMbjoFalTSQ48AbMoMR8sR4V1PgPFJbohzKOUm/ipO6KaT/MALiif2MlxXNgANGmoN3v9CKXAVyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720649669; c=relaxed/simple;
	bh=3KqhVyxwfarODejuAfBSn6lHpzJSnk8P9uNoFVgrkL0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=VbzG4jRLCoYMHQVk4H88ed75RaEANufCdBaGvGzcnswKWJc6rUHO5Kw24WgJUi/DIfRVyV4LMcMVIvjlx1XWrwStKAHu1zwojIQHiAjQiMT89AyjuyK75i+kkDBYQK0TGUctUyXOOfROUTqrKRA6ME/GuBKeG0i0uVobk3bFhQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RyR4fu68; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42797bcfc77so1380945e9.2
        for <linux-wireless@vger.kernel.org>; Wed, 10 Jul 2024 15:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720649666; x=1721254466; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKobFKQOdSn9FZe13P3h5TD4OMdIfr31+3uW9KNIZ9w=;
        b=RyR4fu68H0sd/qq/wdaWMFR6V5MVwEjJ2qao6U5p0JfHD81sOIsJfm2zByl/95bCK2
         CuWqjJDXbx5QSENguTJzA835HzjoZZhJJE40gp7NHiNgEf45ascaVp91ysL9bGlbAaLz
         mkD6V25lGCH4TkPIubLXqFKs1JvJkyo4C5fjWWNZRE9a1vL0tOCFo7dHdwio4xsXeAHD
         Ix/jQxNs/QmRRMMmu0GD2jIUTIa5zzTckIfJ8pa85oij8m2OjhJhPvdQ3SyabV5ZXWEh
         Q1ZjG6Ah+5FtkL2m2m/0dwdezXmpxTiGE3YjBELwo8iwqAKFVnce4fJeS/6ZhdSOm+mX
         Zjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720649666; x=1721254466;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UKobFKQOdSn9FZe13P3h5TD4OMdIfr31+3uW9KNIZ9w=;
        b=Ht75xk0YMP+dNkzVFy3+Sq4yJJVCw3rwVS5mh8GlzCZrwEyiFOs+6haFj1DAheRsra
         dU2qcYLBfo+rcazi0kYSWa4YI08QLCIg2NoMmxuB5E238WtKtMhe4oH9wJ8Oq0m8/r8g
         uOeKh5s1Mp+rDngFX/7DkXgauL2VnfJlz4FXt7ihubbEj6Nm2l8XmwhintI7WLQioQOq
         YuWCPu8oSaBCN6kJBNoEKfJPXmLoW19+ulD9IzECrcuB4LvXu2JfeIsnSYqAZpe75hlT
         /wii+uMGCzQI/HO7UwU/0LjWesK7aCscdMIJiSuWdTIqi1C1gaf0VLcNcXIP2wmjEvLb
         qkNw==
X-Gm-Message-State: AOJu0YxGByh03rXnlI+UTtPhLFiFg1wjzb8VLvPKe3PB8jc5yT24ALR0
	pgTg+NbFp5onDIZe1nOmf8w3Rcgb+gSEZJAR/1vGYd+IpeAbtIZw+hVoRA==
X-Google-Smtp-Source: AGHT+IECWxxayjEqnh9j/E3PsfXC4VB4ypnyVf+BO47R49fcAE9Rheoj0zKUnYvawdAE1zXpLzeLBw==
X-Received: by 2002:a05:600c:2149:b0:426:686f:cb51 with SMTP id 5b1f17b1804b1-426708fa9bamr40703285e9.40.1720649665824;
        Wed, 10 Jul 2024 15:14:25 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f736188sm95496525e9.31.2024.07.10.15.14.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 15:14:25 -0700 (PDT)
Message-ID: <335d7fa1-0ba5-4b86-bba5-f98834ace1f8@gmail.com>
Date: Thu, 11 Jul 2024 01:14:23 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Nick Morrow <morrownr@gmail.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH] wifi: rtw88: 8821cu: Remove VID/PID 0bda:c82c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

From: Nick Morrow <morrownr@gmail.com>

Remove VID/PID 0bda:c82c as it was inadvertently added to the device
list in driver rtw8821cu. This VID/PID is for the rtw8822cu device
and it is already in the appropriate place for that device.

Cc: stable@vger.kernel.org
Signed-off-by: Nick Morrow <morrownr@gmail.com>
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8821cu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821cu.c b/drivers/net/wireless/realtek/rtw88/rtw8821cu.c
index e2c7d9f87683..a019f4085e73 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821cu.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821cu.c
@@ -31,8 +31,6 @@ static const struct usb_device_id rtw_8821cu_id_table[] = {
 	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xc82b, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
-	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xc82c, 0xff, 0xff, 0xff),
-	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x331d, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* D-Link */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x7392, 0xc811, 0xff, 0xff, 0xff),
-- 
2.45.2


