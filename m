Return-Path: <linux-wireless+bounces-29256-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDA1C7D433
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Nov 2025 17:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B321B4E1229
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Nov 2025 16:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F9314F125;
	Sat, 22 Nov 2025 16:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXsEmhWD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566051D63D1
	for <linux-wireless@vger.kernel.org>; Sat, 22 Nov 2025 16:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763830666; cv=none; b=MJNlONsu37yUj9EPdjR1aMHCt7GYddUuzA1t0a2kIZIm5t3u4IhAZnkJNVgXqby5NPTmK+RXaHjQEXUrklLqTUL3FfpSJNPOOcto6i1xfjEDoFTZy7DndbAOcjwgszhcxaY/7MzZKFWmHuyNI0GIzM7296W5mM9mR0cqL3Dkzn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763830666; c=relaxed/simple;
	bh=fs2lYtrZNV3KZp6UxTLBsAy379d9ku/fF4PuWVPTvRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+UpR+ZucftwLhY6vWoFwH8CEJ4w2THHOeNaGawUcY9gVMezPcuVfDXk/5h918vT3hXi/PdcGOJctkhTD59wUuiYtWlQTAjoQ8ICfhBp951bJABS5KrcvSlw7PPnq972aengFSUq25+Qd0tFmpEes/9QMCAuPDDghH4XxyfOdAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXsEmhWD; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b725ead5800so378157866b.1
        for <linux-wireless@vger.kernel.org>; Sat, 22 Nov 2025 08:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763830663; x=1764435463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+OUGVg+qzpVBZ5O3rUCAbdonkufD8EHD+NzO79QMHoU=;
        b=fXsEmhWD2XiLpIH11kDYwnJYjHjdzCYtuIdJotQjZJPcCjQFe2i+CaFzMj8WsDrGf+
         yqlyPgQLfQPwf6osXOmVO8eD2MUMU2i5sRPaAq2gt2DjNp9CYK6yeubPnaebkvigoedE
         Kh58hsXm4cOQJgRLhNlG88jAFbXbATecsJf7vxyL1Qzh78kW/qnxB8hBinD4UKZp5tyQ
         ZXK6wDZ1UV6RJQag1TO6vZHhDUIPpX5PjaDjAopZ6IjMlgfOgbaR9L4A/z04hf0eEInJ
         TruIBMZWjUeJCXQhxuBsMT437hdLgnQ9m9wSt124W4PieCEXJW7qRYCQvRqpbxwp1m4J
         jrTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763830663; x=1764435463;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+OUGVg+qzpVBZ5O3rUCAbdonkufD8EHD+NzO79QMHoU=;
        b=nMfM79wz3fzcUsEa0CmI6z/5OT/zGRy+jRfbq2BiGi9F4AycQn66iyTT+7huq0MN5P
         +c09hCOcQXW6j41K637QaTF7Be9u1mZP3QVsymJIBVSZEADkxZHbCVaS2nE31mkjfyeY
         lVKGCEM4K1+1szvT47wwDvCXn1inM28uU9+N5ic81uunGWrdMttp/veHl4jdgeFRz38M
         DX5bX0qXzwPTxt1W9a4tvOQVbN0DAeBn3I4uDByCygc0QbWdU0hoE1t33H6IYxtGWhrK
         N6yWg42LV4LMMzdkw7Xwl0MT/ukF1gR7bymC6N7BTcltU5rPhblnBHSFg3dhkr79QfhN
         q/Iw==
X-Gm-Message-State: AOJu0YxfQ+dTwI/fULws3xwuaNqzCfNMW78MzueDn+fPmSIlC2Br3ujt
	Kh2AU/NSme6cAPO7KrkyniH13zRuu6qJ2K+WwAcmbHP1m8CQi1VnglDZZWGAaw==
X-Gm-Gg: ASbGnctsNvToK5eNA9MnFodADFaqBFulZrRW1ddJDYjjhRvfZga//iA18fS6JnwlXY3
	QmgA4nYbNBjOJmJ0aVP2YN/d69UAVeRInQ3oMjCcidcFgCRJuE36H/oAEEB59X3+yDI1j9hKhlj
	RZLVzY3YVFjT24oVnZCkllC9IArkR3BkSeQZ+zATMrXsfJDS4O30w5Ji/y9ujdjTvB31BNhqk7p
	4x0/H7KajAnDy/x9xipFd0wwIj5jVkAvF0NNy/WVRKVaPAEXfwfBL9ymnlv/ZYLkq3yE0n2Ho8+
	097nhRkLCdy5rA1/F3hcPWGLasq4utEoh004I4k16EbPipf41NNuVaDlFIM0zl4nv5ByOMxpbG0
	eHNKIEDmLUVDqtwsfU5Rm+PLPiY/nBRbMTSfn5IHy1W+AiQgS/cwTaWoNBq0S60gl6rLCVjtVLm
	jc7CgK5FOCI+174ak1
X-Google-Smtp-Source: AGHT+IGQR2K+8oB9rl4LdszDdgZ1zAbDRGTLWKw8HJ6tmpfxZcxiuNPJ2kqkhKPL+e7MCjq3lfauqA==
X-Received: by 2002:a17:906:f58f:b0:b76:26bc:f95f with SMTP id a640c23a62f3a-b7671244c1amr573051266b.0.1763830662444;
        Sat, 22 Nov 2025 08:57:42 -0800 (PST)
Received: from localhost ([94.19.228.143])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b7654ff3987sm782530866b.48.2025.11.22.08.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 08:57:41 -0800 (PST)
Date: Sat, 22 Nov 2025 19:57:41 +0300
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org, piotr.oniszczuk@gmail.com,
	rtl8821cerfe2@gmail.com, stable@vger.kernel.org,
	regressions@lists.linux.dev,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH rtw-next] wifi: rtw88: sdio: use indirect IO for device
 registers before power-on
Message-ID: <aSHrhbt29k6GJB8e@skv.local>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org,
	piotr.oniszczuk@gmail.com, rtl8821cerfe2@gmail.com,
	stable@vger.kernel.org, regressions@lists.linux.dev,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20250724004815.7043-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250724004815.7043-1-pkshih@realtek.com>

Hi,

This patch was recently backported to stable kernels (v6.12.58) and it broke
wlan on PinePhone, that uses 8723cs SDIO chip. The same problem
appears of course on latest 6.18-rc6. Reverting this change resolves
the problem.

```
$ sudo dmesg | grep -i rtw88
[   24.940551] rtw88_8723cs mmc1:0001:1: WOW Firmware version 11.0.0, H2C version 0
[   24.953085] rtw88_8723cs mmc1:0001:1: Firmware version 11.0.0, H2C version 0
[   24.955892] rtw88_8723cs mmc1:0001:1: sdio read32 failed (0xf0): -110
[   24.973135] rtw88_8723cs mmc1:0001:1: sdio write8 failed (0x1c): -110
[   24.980673] rtw88_8723cs mmc1:0001:1: sdio read32 failed (0xf0): -110
...
[   25.446691] rtw88_8723cs mmc1:0001:1: sdio read8 failed (0x100): -110
[   25.453569] rtw88_8723cs mmc1:0001:1: mac power on failed
[   25.459077] rtw88_8723cs mmc1:0001:1: failed to power on mac
[   25.464841] rtw88_8723cs mmc1:0001:1: failed to setup chip efuse info
[   25.464856] rtw88_8723cs mmc1:0001:1: failed to setup chip information
[   25.478341] rtw88_8723cs mmc1:0001:1: probe with driver rtw88_8723cs failed with error -114
```

On 25-07-24 08:48, Ping-Ke Shih wrote:
> The register REG_SYS_CFG1 is used to determine chip basic information
> as arguments of following flows, such as download firmware and load PHY
> parameters, so driver read the value early (before power-on).
> 
> However, the direct IO is disallowed before power-on, or it causes wrong
> values, which driver recognizes a chip as a wrong type RF_1T1R, but
> actually RF_2T2R, causing driver warns:
> 
>   rtw88_8822cs mmc1:0001:1: unsupported rf path (1)
> 
> Fix it by using indirect IO before power-on.
> 
> Reported-by: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
> Closes: https://lore.kernel.org/linux-wireless/699C22B4-A3E3-4206-97D0-22AB3348EBF6@gmail.com/T/#t
> Suggested-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  drivers/net/wireless/realtek/rtw88/sdio.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
> index cc2d4fef3587..99d7c629eac6 100644
> --- a/drivers/net/wireless/realtek/rtw88/sdio.c
> +++ b/drivers/net/wireless/realtek/rtw88/sdio.c
> @@ -144,6 +144,10 @@ static u32 rtw_sdio_to_io_address(struct rtw_dev *rtwdev, u32 addr,
>  
>  static bool rtw_sdio_use_direct_io(struct rtw_dev *rtwdev, u32 addr)
>  {
> +	if (!test_bit(RTW_FLAG_POWERON, rtwdev->flags) &&
> +	    !rtw_sdio_is_bus_addr(addr))
> +		return false;
> +
>  	return !rtw_sdio_is_sdio30_supported(rtwdev) ||
>  		rtw_sdio_is_bus_addr(addr);
>  }
> -- 
> 2.25.1
> 

-- 
Best regards,
Andrey Skvortsov

