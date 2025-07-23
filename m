Return-Path: <linux-wireless+bounces-25926-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DF7B0EE27
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 11:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 249431898BB3
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 09:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E4E27EC78;
	Wed, 23 Jul 2025 09:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="X39/nwTq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD06244679
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 09:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753261983; cv=none; b=KbNwNlDDSEDyIruUJ4uqRLEejPJRzopdSXUXSzq6jR/EcBLHbtgSLBZK4NwgQTGFD3qXvMrwQ1pmvZG0kV68CqpLpG5aexcde5o5FAKTXmNUSvPUo9xfOHjxmSh89gXqPx11p7Vq1DblK7ueIRgottwQ70qV+X8G57b+VdKcdV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753261983; c=relaxed/simple;
	bh=B76ihxut+RTOwAk/ZY+XwbBsQLdvPADMyfOyBfrfq9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UiCxn5lszf5x9mcSR69i40EISq60IOme8g3R2G7qz56/N4lP3LBzvO3m76T+/8szH8bQh5vJgIH/jSaCBbdOXS6MwA7vkhZToGRSN7ROV8TVWlvSPC/Ms+6lhGl8GrSb9C0vfYoftlUw8cYb574V9Nj2DqyeA33uEvjrzxCxvj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=X39/nwTq; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7e2e3108841so757922185a.3
        for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 02:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1753261981; x=1753866781; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p9W9cxmfvm/gKuw4B8eiMLG3yBzNpODIQa8i5xJ6Gzo=;
        b=X39/nwTq1PzHFYSAnhfXMhY4gOK138w4GuMfIybcJ/Le1/39ZePe7nboiJosN5smZh
         n8vkwSnZRBfXaMQZ7EJe84+iLNj00FSxiJE1D2xb5GQFveInZFB8HqlJWfEgwV4bLSEK
         mNsdj90EK3QBZ3dVcemnuiL3+gJtsxXYeS6iA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753261981; x=1753866781;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9W9cxmfvm/gKuw4B8eiMLG3yBzNpODIQa8i5xJ6Gzo=;
        b=g0cOemQdg7EGueTX1imAGtF9msP38qZ7ztQIp+BoOXKchSEbn6P/MyqgBEUQUCzSJs
         6Dv/WKLKitmh29IzdUMqUqN3aqz6YSaWIVj4tyrqoMq4KfQv+6nL7MzrelCrAgDG5Mfy
         T3i5SYPUzP/lplMmKbPBmkbh+lg1QMHx1jyMq61X88I/xYGwRxXCsBn8TkyFK7KPgvDl
         19uHkFQeV6Hd4euFyNFLafGlxmKFYZRWYWKp8Z35HBPkmGiLR/U61j0Wg936tZ5W5DOm
         T3GivlRnGlahG0CwGVlXx712dL074fOQRNlSYloG3NLclomcmPslHU1uIUUuiAANb3gN
         HwMA==
X-Gm-Message-State: AOJu0YyXjVpfwzGglComseWkFVzO0aKlOojgj7ml7NItRsLmQjXGkKXY
	RnHler8qczzIrSLUvlCHlT1cRwpjunvc0cgX3P+CkXh7QaqRqrZc8uS4PNz2eg6XrA==
X-Gm-Gg: ASbGnctlAPkI2gscD+MDfkrOTC8d19e5CBwUei5/PTpneWJJu8U6XWkoFZ4obzuXdvI
	9KxY41ZrWwtYBIOESKBl9vKdnLSllr1NUScoAdxb88CdlD9XCc8rI5k97PfZsmG9faT03kh2rF6
	qrBY2GfN6I/IaIn6UvSnG0NLTNPRmJqigSkSpYvtSzLs4mTySH/lny5FIEgPTYyNBaMpabRIWSI
	T6CcO3giwYU/FSjPd5Vi48WP1EyPh4L2nTGJmDrXtiN5Ma/hrTSLl52faiqoH3R3+sdb+T333IO
	1w/Q3kxIzfPPn0gTZVcQCCslFtH8kV3R2IMa6FDB97cfuGykTy+Td9JEEyaTSvfCDfpNt3z3x9/
	uu7t7d1FqEDD19d9hrlM5DhxQE4t9ZrUDSTd5g2J0QG66g5xPj3Zc
X-Google-Smtp-Source: AGHT+IHTl3LvdMwZDOaqiUVkAagRIUUwNLQ6SaCbHjiRfvXendnnH8kUY6uNwWnpTlXitLRJH+BYYA==
X-Received: by 2002:a05:620a:27c5:b0:7e3:35da:941a with SMTP id af79cd13be357-7e62a1606a1mr312370385a.14.1753261980581;
        Wed, 23 Jul 2025 02:13:00 -0700 (PDT)
Received: from [10.176.2.145] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c44cdesm620619585a.61.2025.07.23.02.12.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 02:12:59 -0700 (PDT)
Message-ID: <62004d9f-7222-4a93-a06a-34861edcf2b6@broadcom.com>
Date: Wed, 23 Jul 2025 11:12:56 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next] wifi: brcmfmac: remove 43752 SDIO
 incorrectly labelled as a Cypress chip
To: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 wlan-kernel-dev-list@infineon.com
References: <20250721102618.1453-1-gokulkumar.sivakumar@infineon.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20250721102618.1453-1-gokulkumar.sivakumar@infineon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/21/2025 12:26 PM, Gokul Sivakumar wrote:
> Cypress(Infineon) is not the vendor for this 43752 SDIO WLAN chip, and so
> has not officially released any firmware binary for it. It is incorrect to
> maintain this WLAN chip with firmware vendor ID as "CYW".
> 
> Fixes: d2587c57ffd8 ("brcmfmac: add 43752 SDIO ids and initialization")
> Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c    | 1 -
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c      | 4 ++--
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c      | 5 +----
>   .../net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h    | 1 -
>   include/linux/mmc/sdio_ids.h                                 | 1 -
>   5 files changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> index 8ab7d1e34a6e..de4634cad461 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> @@ -999,7 +999,6 @@ static const struct sdio_device_id brcmf_sdmmc_ids[] = {
>   	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43751, WCC),
>   	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373, CYW),
>   	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43012, CYW),
> -	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752, CYW),

Thanks for the patch, but simply dropping support for this device 
probably means users who have this chipset will report a regression. So 
I suggest to make it a WCC chipset and only drop the CYPRESS indication 
like done in chip.c in this patch (see below).

Regards,
Arend

>   	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_89359, CYW),
>   	CYW_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43439, CYW),
>   	{ /* end: all zeroes */ }
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
> index 9074ab49e806..4239f2b21e54 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
> @@ -738,8 +738,8 @@ static u32 brcmf_chip_tcm_rambase(struct brcmf_chip_priv *ci)
>   	case BRCM_CC_4364_CHIP_ID:
>   	case CY_CC_4373_CHIP_ID:
>   		return 0x160000;
> -	case CY_CC_43752_CHIP_ID:
>   	case BRCM_CC_43751_CHIP_ID:
> +	case BRCM_CC_43752_CHIP_ID:
>   	case BRCM_CC_4377_CHIP_ID:
>   		return 0x170000;
>   	case BRCM_CC_4378_CHIP_ID:
> @@ -1452,7 +1452,7 @@ bool brcmf_chip_sr_capable(struct brcmf_chip *pub)
>   		return (reg & CC_SR_CTL0_ENABLE_MASK) != 0;
>   	case BRCM_CC_4359_CHIP_ID:
>   	case BRCM_CC_43751_CHIP_ID:
> -	case CY_CC_43752_CHIP_ID:
> +	case BRCM_CC_43752_CHIP_ID:
>   	case CY_CC_43012_CHIP_ID:
>   		addr = CORE_CC_REG(pmu->base, retention_ctl);
>   		reg = chip->ops->read32(chip->ctx, addr);

