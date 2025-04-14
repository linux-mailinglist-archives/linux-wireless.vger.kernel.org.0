Return-Path: <linux-wireless+bounces-21499-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A854A87BC8
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Apr 2025 11:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D7383A933F
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Apr 2025 09:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5809F1CDFD5;
	Mon, 14 Apr 2025 09:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PAVmTvfb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827F625E822
	for <linux-wireless@vger.kernel.org>; Mon, 14 Apr 2025 09:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744622550; cv=none; b=UEAf1Q6pHWIEGcNBrYbfFQCglhbLiOrWyZ6iTfzW/cut3FUrWma8DhHrImMdePsXAKxHfxoco4BHEkmQ736MgL2vG7bp/BwPJEwGbJeRWkRsXRLX2gsTBSbe3oMB0qWo5TtH2emCO94dIvRgLk0IV2C3cUxnGq33quT6w3nU5NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744622550; c=relaxed/simple;
	bh=CT/YENH049lc/i4S8uPToUWuRtetJFIzO7sFqNFctRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ap3L5KUuv1+1wYGX6N95Y388kNkEWKSpfI4jmiJL7zswhicZ98aF+s4fHPIC8vGiKyRWgjsSX30t8AzUC79hthRXFTNC+5RNOdzzr0geTOBMMrxgSyODJeFbXp2+XSpLWCzX3kWdS4Bxk/o78hiYLgWTDdE5Hz9DvkuYZ2egfp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PAVmTvfb; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3feaedb4d2cso2401263b6e.1
        for <linux-wireless@vger.kernel.org>; Mon, 14 Apr 2025 02:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1744622547; x=1745227347; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FZYQSYGdR0512/dBOk/+VrpM7DLNp+23vtrCwIaDtks=;
        b=PAVmTvfbdfWCniOh8O8+LLR/jtwout66OfiifD8QMdwuel/uITYzimbgmuYIDKOc8d
         JaB+2nMOk5meY/Zd9oYkZrhGw1Gy9YNYasTG2LWHphyHEvk16goM5744VczewFjYyQV0
         I47fvmcvr7OhGXRZxnYSqVk8SO9vHNWbOSniU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744622547; x=1745227347;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZYQSYGdR0512/dBOk/+VrpM7DLNp+23vtrCwIaDtks=;
        b=Kv0XHXpUznwZTqLl3hNwdy4zYyDk6Fz92jepyjnBHOEasJvJc1hDnHUuckphSnnx5j
         QAPVAk2REKHzNgNth5Trh2c9Cx41ev0b6RScfR6/wP5gBvViKbWil2WaaaXyWnJiKtx8
         FnhitEuVX0TWJNOPJytSu0PgOYfIHb/fgBoJyc1IvKBuAHawSC9xDWsn20XTeD1zLHTK
         4N+8R48nlvAgD1in7nrbDa465chftc1dVikmckjVP9YfD6cyeIR2DQSjrtW4T7hU5LTU
         9ZYoISKBdbABzH2BlIrpDl8zDSXFENl+m0gYo5udBnOOAamD4sObd4HZf/MoqxRyQv4r
         ToDw==
X-Gm-Message-State: AOJu0YzP6lcR3GVI0WEA4uCLFL2TQnNg/VG7b1KJxhBLcsDmLWzwHHia
	6sVVOXVrCF4yhCr1/1H0B6WqluqUHQBfuHzwBbxlSFUIcjJoefIpSXs4lvFw2A==
X-Gm-Gg: ASbGncu+CzW1zImsUEMxUr6adT8YR3oXvNZsOICTIzUGaaVKRUBdVWQ4jUDX9rKgIlE
	N70J0XCV92+Fau9tPHkxaRs6ENkv7L4LfGI/GYxnGsG2KYgzUGCg0yb7PsLsr6JhV0LRkgIzsXQ
	mQ75mEbX6BE/rw/uCMcMPIC2s2Cywo+v4W/7henHXNzvhz6GedWXR4rMLCJNVJiuMjCk3l8tVhi
	nLlPKyB9mtJenuIzqy5Vc43uX0gwWSyzUsGR38pOb7aGUkrwjEDLcFdmyuaMttDkcPnU8U171kt
	PREc0nT7GKkEiYDltb0Hl8iA8QJa27ioUrcHktsqAILmsf6QT1ap/8TkxVO7TifGxb8=
X-Google-Smtp-Source: AGHT+IHMPGnr/AdAt7EyHWCE+ffxwrVPeYCLplVvTrY0KgmPGnMZH/mTkah55Cp9IUWwsF6F+Wh6ug==
X-Received: by 2002:a05:6808:3095:b0:3f8:3eeb:11a3 with SMTP id 5614622812f47-4008505c41fmr8010437b6e.11.1744622547068;
        Mon, 14 Apr 2025 02:22:27 -0700 (PDT)
Received: from [10.176.68.80] ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-400762d5603sm1862462b6e.26.2025.04.14.02.22.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 02:22:25 -0700 (PDT)
Message-ID: <d59805fc-578b-4421-90e3-40e322be0652@broadcom.com>
Date: Mon, 14 Apr 2025 11:22:21 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmfmac: avoid calling
 platform_driver_unregister() more than once
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: linux-wireless@vger.kernel.org, lvc-project@linuxtesting.org
References: <20250414083403.561646-1-dmantipov@yandex.ru>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20250414083403.561646-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/14/2025 10:34 AM, Dmitry Antipov wrote:
> Since 'platform_driver_probe()' may call to 'platform_driver_unregister()'
> itself (and denote such a case with -ENODEV), this case should be catched
> to avoid calling 'platform_driver_unregister()' for a driver which is not
> actually registered. Compile tested only.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

This is unnecessary. Will try and clarify below...

> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
> index cfcf01eb0daa..d60ed50e8bde 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
> @@ -602,11 +602,11 @@ static struct platform_driver brcmf_pd = {
>   
>   static int __init brcmfmac_module_init(void)
>   {
> -	int err;
> +	int err, probe;
>   
>   	/* Get the platform data (if available) for our devices */
> -	err = platform_driver_probe(&brcmf_pd, brcmf_common_pd_probe);
> -	if (err == -ENODEV)
> +	probe = platform_driver_probe(&brcmf_pd, brcmf_common_pd_probe);
> +	if (probe == -ENODEV)
>   		brcmf_dbg(INFO, "No platform data available.\n");
>   
>   	/* Initialize global module paramaters */
> @@ -615,7 +615,7 @@ static int __init brcmfmac_module_init(void)
>   	/* Continue the initialization by registering the different busses */
>   	err = brcmf_core_init();
>   	if (err) {
> -		if (brcmfmac_pdata)
> +		if (probe != -ENODEV)

When the platform_driver_probe() fails it means that brcmfmac_pdata will 
be NULL so it provides the same info as the returned error. So the net 
result is the same and no platform_driver_unregister() will be called.

Regards,
Arend

