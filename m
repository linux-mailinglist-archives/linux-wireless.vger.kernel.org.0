Return-Path: <linux-wireless+bounces-29295-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1C2C82C54
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 00:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 508D14E2019
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Nov 2025 23:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2001D2F6162;
	Mon, 24 Nov 2025 23:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9rY2ZdR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293FA2F5492
	for <linux-wireless@vger.kernel.org>; Mon, 24 Nov 2025 23:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764025717; cv=none; b=aK9BxCUUU1fpy1BNz9aJw0cYEM1K0fFqWxht7hryBksXLVSWNUbMEAq1wKk9gocmGjoM8pN/t+SFqowCphMWTv7k5tqraZ8qmPs3X5u+nj+ntMCETYE6y/s2jXwoPRn0LnyzAwC6RlH5j2swOuBs4zDE6K4IhfSUtMgtsXhXisc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764025717; c=relaxed/simple;
	bh=bka4Ok+xY/vHf8rj5t8CVxoP4nJIrCSCQdt2nklsCog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QI12LTIihIIC0U/QTE6KKdQGNGmCF/6VDrUQ4qgt8AVB6009ULB55EUy4uzSozs0s6jwSmwiArg3nLLFKWpcVGc8xvhOmrlrDr/S0Hjlcdltv6JLKX3iT2OyoQIpP/dkzTACFVGbS8diQGm0lRco4rzhPK9Kx0Q4AxQH7TKabDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9rY2ZdR; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6418b55f86dso8178637a12.1
        for <linux-wireless@vger.kernel.org>; Mon, 24 Nov 2025 15:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764025713; x=1764630513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/WHGJKwl1pNV1oMFP/7W/iGcAIvgG1g+5RGn0OeZ18=;
        b=V9rY2ZdRK9hFVuwdJumT8v+zjl7956+NytNmXPFRIlcgK7CBy/eTo+WLH809rh82K2
         +OGtXfj4gSAwoKEIE4nlgGYaODYK/oA3LT1StDnYHLJ4v6WzlpbJfe0Pmh28w3XbPX8v
         b3XhApjkDct4GQX9/5MhG+WlvDji3AO/Uo0xbkkpC0hWeJKUjQkgNbD8K57OkIwi+9be
         wtJbwuyW6yr63NdGVGb7B9B0njBXyp6G5vPEpvq6P5kQ1S81nEWhWnsb8x/bGPyRlBD6
         dgd3WtJ0hbCtCavWjLOMAwd6WWXPA+ixp956R9dJpYiaXNyciif82LL7HE/8wZUKfuw+
         f6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764025713; x=1764630513;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u/WHGJKwl1pNV1oMFP/7W/iGcAIvgG1g+5RGn0OeZ18=;
        b=aOL8nerTaXNiOb9ojj9ajAv12FZCRPyLnRo9JTBb9R3DOr42X+m2ST9jVdFVwe1eU9
         jBlYPj84YrFZsb/KgTSjFGa2OQ5YkJdEEQIKB5sXSzF/NSGtyhlXyr56Aeqm6wPvacIH
         7+ncJRMi+O5+FbCmHl+6teO+WxtD1K9uF7hnmXJa+I9EX9rMeNTyQU/lGvV+kfYGKL5a
         hNOWO6AU6lYE4M9Uydw/Pqxwm/c3IlZTk6ChoCaPqwyUa0wmkkgwQqzTerPfLSKHiaqk
         rLHVAg2zaK5vOaS72yegOopuYc/NGpsBCDnMH4Blyn6cgH7Zs1UeXPAcpX05VcMw1WZr
         tQKw==
X-Gm-Message-State: AOJu0YwEdxXLW3HZnxuDyV7sfYAmkBeRVUdtT6SlgFUa1lm0UVacMaZB
	3AU1Q31OBDIroqXt4zgNLC2b/yMAX43BYlzwvOogSYZcdm8CtDX59HAh
X-Gm-Gg: ASbGnctFNM6wEwhrq+hCz3hVipT+i3odK5fQ+xBQwJmpa1gawiriyXPUVwbE1Epes7o
	SO17NEgn07m+kB9AMHKgJ+Clv3G304oRVS9b+rPJhfXJP8Qnbud4kPMxjr3vvkm4Z3xDxMs0kbr
	vhdpANcCBSeDefGhLy1mQ1Qph+ZzbgDPhxLps9Wju+D6Qm1bBbyrW7pwG8orW/v2MZOKesfXI1Y
	0v1sIkleDwkePAQmFt/efkRZwIDuEZRMOOCGW+cN3NdEYqXcpQgtbXodtTruYbnQM5RpzLxhMUu
	dDl2ccUOdprydrNWKNHZIMl86lkt/e6VXQ2Mm3XHdIijkafLUqZRcbyZ3d5fssWxNLbYTrViDxI
	rjHBLQSvzPxbiWoeD8tk2Uo051tJc7sFaZqI+K9AhNAh8MOhu1A4Y1oNvWwEbVag3ggQBX9VcrZ
	e38ODQT6oYk3bk1CrL
X-Google-Smtp-Source: AGHT+IGGQZRvEPE+V692/ByODBIStowiEq4wuN3gXmgZ+FT8xM6RPK+LS1vzrQ+0Ru/xT8SeNfVF0w==
X-Received: by 2002:a05:6402:51c7:b0:643:c8b:8d30 with SMTP id 4fb4d7f45d1cf-645546a3a94mr12871488a12.30.1764025712967;
        Mon, 24 Nov 2025 15:08:32 -0800 (PST)
Received: from localhost ([94.19.228.143])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-645363c56a4sm13295513a12.15.2025.11.24.15.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 15:08:32 -0800 (PST)
Date: Tue, 25 Nov 2025 02:08:31 +0300
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"piotr.oniszczuk@gmail.com" <piotr.oniszczuk@gmail.com>,
	"rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH rtw-next] wifi: rtw88: sdio: use indirect IO for device
 registers before power-on
Message-ID: <aSTlb1TEwNaFbdFf@skv.local>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"piotr.oniszczuk@gmail.com" <piotr.oniszczuk@gmail.com>,
	"rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20250724004815.7043-1-pkshih@realtek.com>
 <aSHrhbt29k6GJB8e@skv.local>
 <4562797ed9514344b562f7a8e58e6988@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4562797ed9514344b562f7a8e58e6988@realtek.com>

On 25-11-24 08:16, Ping-Ke Shih wrote:
> Andrey Skvortsov <andrej.skvortzov@gmail.com> wrote:
> > Hi,
> > 
> > This patch was recently backported to stable kernels (v6.12.58) and it broke
> > wlan on PinePhone, that uses 8723cs SDIO chip. The same problem
> > appears of course on latest 6.18-rc6. Reverting this change resolves
> > the problem.
> > 
> > ```
> > $ sudo dmesg | grep -i rtw88
> > [   24.940551] rtw88_8723cs mmc1:0001:1: WOW Firmware version 11.0.0, H2C version 0
> > [   24.953085] rtw88_8723cs mmc1:0001:1: Firmware version 11.0.0, H2C version 0
> > [   24.955892] rtw88_8723cs mmc1:0001:1: sdio read32 failed (0xf0): -110
I see it fails with timeout on the first operation to read chip version.

> > [   24.973135] rtw88_8723cs mmc1:0001:1: sdio write8 failed (0x1c): -110
> > [   24.980673] rtw88_8723cs mmc1:0001:1: sdio read32 failed (0xf0): -110
> > ...
> > [   25.446691] rtw88_8723cs mmc1:0001:1: sdio read8 failed (0x100): -110
> > [   25.453569] rtw88_8723cs mmc1:0001:1: mac power on failed
> > [   25.459077] rtw88_8723cs mmc1:0001:1: failed to power on mac
> > [   25.464841] rtw88_8723cs mmc1:0001:1: failed to setup chip efuse info
> > [   25.464856] rtw88_8723cs mmc1:0001:1: failed to setup chip information
> > [   25.478341] rtw88_8723cs mmc1:0001:1: probe with driver rtw88_8723cs failed with error -114
> > ```
> > 
> 
> Check original link of this patch [1] that 8822cs read incorrect from 0xf0
> resulting in "rtw88_8822cs mmc1:0001:1: unsupported rf path (1)".
Sorry, I haven't meant, that this patch should be reverted. I see,
that it solves real problem. I've meant, that patch caused this
regression was identified and it was confirmed by reverting it.

> I wonder if we can add additional checking rule of chip ID, like:

I've tried suggested change and wlan is recognized again.

> 
> --- a/drivers/net/wireless/realtek/rtw88/sdio.c
> +++ b/drivers/net/wireless/realtek/rtw88/sdio.c
> @@ -144,8 +144,10 @@ static u32 rtw_sdio_to_io_address(struct rtw_dev *rtwdev, u32 addr,
> 
>  static bool rtw_sdio_use_direct_io(struct rtw_dev *rtwdev, u32 addr)
>  {
> +       bool might_indirect_under_power_off = rtwdev->chip->id != RTW_CHIP_TYPE_8703B;
> +
>         if (!test_bit(RTW_FLAG_POWERON, rtwdev->flags) &&
> -           !rtw_sdio_is_bus_addr(addr))
> +           !rtw_sdio_is_bus_addr(addr) && might_indirect_under_power_off)
>                 return false;
> 
>         return !rtw_sdio_is_sdio30_supported(rtwdev) ||
> 
> [1] https://lore.kernel.org/linux-wireless/699C22B4-A3E3-4206-97D0-22AB3348EBF6@gmail.com/T/#t
> 

-- 
Best regards,
Andrey Skvortsov

