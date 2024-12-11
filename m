Return-Path: <linux-wireless+bounces-16242-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C78B99EC849
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 10:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91FD71888444
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 09:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4DD240364;
	Wed, 11 Dec 2024 09:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="g42bVglG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01078240361
	for <linux-wireless@vger.kernel.org>; Wed, 11 Dec 2024 09:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733907887; cv=none; b=nbSQ5tSAq0seONsp9587hlP+X/Tvjx3tRBfGrtwjjmwIEOwBihzi/nRvP6aZVF9KO28Qauu2gV58fyZgbV2LBAfw9p6o4K0VDHIYO4NegrHYE483TL1gMpMy5MPhosxOPNe5pJFzGwTMGJp8XXgW7YAuOxBYBR/mSCserogQ/Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733907887; c=relaxed/simple;
	bh=GQXmoo3N/u/EbFgV75OCIAQmQ/jn3/PEnSGNr5M7/RQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eYZtvo0m5Rmn4IVeSqZmn14U11epYghXqozf/wseN+i5YNy/A3Z7yfVhy2ltG/CHu8yUmw3pV548zLpma+C45hpbdWnyx/Jls+RxqOjdzEVC8wAJZOkHdsJPK4y9lUUJYJV69jF6F4c2Hw8hauOkDLK2/t2E8xFnbNDGe2LcnWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=g42bVglG; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6d8edad9932so36707246d6.0
        for <linux-wireless@vger.kernel.org>; Wed, 11 Dec 2024 01:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733907885; x=1734512685; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3OCeLUzu3s0t+0nrCWm7hdzwL7W0M+2gSpmnee8mlAE=;
        b=g42bVglGfTpmZL5CEljM/iz8kZAYzCUSsE4uZmKw1KoJHbsmBRbzjTsWP4S6/4t9Dv
         e19vvSznrNfK2shp2e1fy+EMRxE2tMnK5Za5wCCrlIvEnVyqBfWJmeJ06UE4YeHvIaB5
         fcwLN9L619GOUSdDho2dSkVIYSCy4OLOcFKzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733907885; x=1734512685;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OCeLUzu3s0t+0nrCWm7hdzwL7W0M+2gSpmnee8mlAE=;
        b=NtUh7QAWm1IV+qAbKGrAtglRtyRz2ZpQlOnDQCtISvWimzOhCvMkJjCLqKTwK9hDNn
         0/RXky/z/9pnU+GUM3c8BghvgbUnTIXwiK4AUdEI0WxbqWcJZZm9Jgto08h036o24G7t
         EJA4LiD17YyBLRx/NUjB8tQC815qcAb2VskvGeJG6sKD4To++Qoo2jY+mSfDgsw4RSff
         HAWsLCwiBWkr1WDWtnroerzOcryf9zWNvOaS/IIkhrJ8TN0kLIf+qcroRbA90JX01EC4
         sxKgGx1JGBPJuZpKCAGRUtvWDw/UngIgXLYbzn7QxUConvVposl2P8jpNIFhDWhU7o/W
         5Atw==
X-Forwarded-Encrypted: i=1; AJvYcCVChOTVPwloXnqL+eB8jAzGvo1V+zuEPe9+F8XnNYypmAGzjqM2K+XXZoUJ8CPL8Ma+2ov90+FCFdHXFlJ+gA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9wodvV9UywFcJWSH8aHLVb3liTQDezkKV6+RAJTsdxom+jl9o
	eXQ157ofgo3Bzr5AeAHiHlnsUe53AoO/dwIfd6BYY72thqmfhm2etYcfFyJedB2SSxZR2ayDxdi
	XNg==
X-Gm-Gg: ASbGncstRhsgjeWYcZ61dsI/nBg4F14C//8vD/Qh/1UrQfy7Wp7Cdc8kqXO4M4hFlHA
	1ZI+XAnSEld2RQlA3SUJzDUhgglgGx23M12+CYh6CdLsoHAP1FK0iVl2YF61mpfyrRlR/buYzhd
	f6ohXPk1mFQwrXCXC8MPBPxJzPSgYNbpYpr7iYTzPEAJaJN0GqfLI4X2UmnLHz6GhzO99J/tduT
	pTWu9CbUGkvNuBylJR2DkJV65q7ju5r07re2TzS2mHBPCKxVfzw6Rx/5gQJWnKOtY8SqwJ74+WV
	w8F6XEXxnim8/udg8GCYhCYdDSY9og==
X-Google-Smtp-Source: AGHT+IEfMCeoAQAReffC1K6XtwrHukpBsP+1FtpMEks02p3U9Jp/5r16mP+kh+sseyZD2jBtnZF4Dg==
X-Received: by 2002:a05:6214:c22:b0:6d8:97ea:4362 with SMTP id 6a1803df08f44-6d934bb71c9mr36525196d6.38.1733907884870;
        Wed, 11 Dec 2024 01:04:44 -0800 (PST)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6d0071798sm336904885a.41.2024.12.11.01.04.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 01:04:44 -0800 (PST)
Message-ID: <72e8c5cd-11fb-48d8-af53-589e8cb406d5@broadcom.com>
Date: Wed, 11 Dec 2024 10:04:39 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmfmac: handle possible pci_enable_msi() error
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
References: <20241210070320.836260-1-dmantipov@yandex.ru>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20241210070320.836260-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/10/2024 8:03 AM, Dmitry Antipov wrote:
> Generally it's a good idea to handle error which may be returned from
> 'pci_enable_msi()', so add relevant check to 'brcmf_pcie_request_irq()'
> and adjust the latter to return actual 'request_threaded_irq()' error
> instead of hardcoded -EIO. Compile tested only.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

Hi Dmitry,

I had a deja-vu regarding this patch. So scavenging around in 
linux-wireless patchwork I found this. May look familiar ;-)

https://patchwork.kernel.org/project/linux-wireless/patch/20230614075848.80536-2-dmantipov@yandex.ru/

Regards,
Arend

> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>   .../broadcom/brcm80211/brcmfmac/pcie.c        | 20 ++++++++++++-------
>   1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> index e4395b1f8c11..f0e05cb0cfa7 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> @@ -963,6 +963,7 @@ static irqreturn_t brcmf_pcie_isr_thread(int irq, void *arg)
>   
>   static int brcmf_pcie_request_irq(struct brcmf_pciedev_info *devinfo)
>   {
> +	int ret;
>   	struct pci_dev *pdev = devinfo->pdev;
>   	struct brcmf_bus *bus = dev_get_drvdata(&pdev->dev);
>   
> @@ -970,16 +971,21 @@ static int brcmf_pcie_request_irq(struct brcmf_pciedev_info *devinfo)
>   
>   	brcmf_dbg(PCIE, "Enter\n");
>   
> -	pci_enable_msi(pdev);
> -	if (request_threaded_irq(pdev->irq, brcmf_pcie_quick_check_isr,
> -				 brcmf_pcie_isr_thread, IRQF_SHARED,
> -				 "brcmf_pcie_intr", devinfo)) {
> +	ret = pci_enable_msi(pdev);
> +	if (ret)
> +		return ret;
> +
> +	ret = request_threaded_irq(pdev->irq, brcmf_pcie_quick_check_isr,
> +				   brcmf_pcie_isr_thread, IRQF_SHARED,
> +				   "brcmf_pcie_intr", devinfo);
> +	if (ret) {
>   		pci_disable_msi(pdev);
>   		brcmf_err(bus, "Failed to request IRQ %d\n", pdev->irq);
> -		return -EIO;
> +	} else {
> +		devinfo->irq_allocated = true;
>   	}
> -	devinfo->irq_allocated = true;
> -	return 0;
> +
> +	return ret;
>   }
>   
>   


