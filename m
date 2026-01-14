Return-Path: <linux-wireless+bounces-30821-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F49D1F23B
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 14:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEC2D3025A63
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 13:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8723123D7C8;
	Wed, 14 Jan 2026 13:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BKfQ8tHG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vk1-f227.google.com (mail-vk1-f227.google.com [209.85.221.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A67218596
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 13:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768398332; cv=none; b=jRGmiWqTFgLS88EoYkrZN/490urg5IH/H/CafRbDwhn2UvaC/CMD6DiltJ3vy98EVoHF7ilbFDcOK1TRqZTxYabf9AHiQ/1MAwTz8ZhvA5QsIZaaoiryxfFawo292k4xWqSKke2D6QoKgBWrobqcVlT8tfQR5JbH9sFVZG3CmP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768398332; c=relaxed/simple;
	bh=vOb3CSRTNTCpH8NeWFLP0MUbTOOhehnejDJe7frRXbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QAJYzxmXTRdt3IwbwBFYQ73NXQk+JM1Bce911VLnLLySoHHeyJ9GmC2WTcPFqX1TQAVtR3d9pHde1Cdyxy9MgYnkTVjVG2rPS17cu2UCfI8CE3cEsWCzsgHywFhdxqpTbZ4sKcjcy43pM3iK3Iz8HZ8BfOmD6mgb9xsUboY9qYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BKfQ8tHG; arc=none smtp.client-ip=209.85.221.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f227.google.com with SMTP id 71dfb90a1353d-56378a18ba4so1195098e0c.1
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 05:45:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768398327; x=1769003127;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z47x1uvVUM2IS56zlJQKoYRwLdGmlbxVa36JQqN7LFM=;
        b=O6TTrOhO7h+b3lQcQ6ljMIBuPoXX9kQjJHqCaLViGQdtiiUmkJYti5xZdeNqDkSUPI
         6AslDqzKLDJvGUGc4aBuGHLFEav0rtqINy2mwNNiMSfUZCiWcQcKzXkeshUpOXzBXlsR
         SwwNBIGi3CX9IuOR2Uew6xVOtkKa/IPrMxOEDlEw699elodhb9uISf7LFGJ7O+qdL8v6
         tyQ/k2tDO0kFBtAVaw95dIDR1tVvUSDFQdeT7rAoqB6APv6w9+/mQev3GR6XxQdxYHqK
         kpyE980YkG3HRWopbEwnHn+bG/iTOp3cX8I3heJzwvBH74fhNElWEtucxrX896jPeMUB
         6P6g==
X-Forwarded-Encrypted: i=1; AJvYcCUYu4xZdceHF0YYLDHj71LJCqzx4FRpbEBkAaAP6tWitw9X6R/S9UIVBAGv3G8edsT42fPNVIWTqW1iUOtOhg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtyldzbFDsXS9vf6jiiat0+OnlOcjOtXyWuYiXScuvUs+Ol4u/
	RrsuxiHNCtzkySa55bCbSw3nrIzoaLqYGeQVp6CVAiFXMeczpSjWjkMJEPdtDVR93y85AEQ4FIy
	gNnAEF4jIqGad/E3AiwHX1tLxOoo+gAHxTJb53N+uvDD056RQEX5XV7BhV7rggmeCViYApoud8n
	kcO+PRo5QcltCAh+K54lXVMwIic3SP3KkQhyVNMWT9IRuQsr2BeSN8sbluBL05bKp4rD6NIdOcs
	HDgQIOnJQL0vHKnzXgcFuLc3bje
X-Gm-Gg: AY/fxX7zIE1EJH1JBmGPTtSgup6aj8luMbZATWXILUs6J9Du50F2eZC9MKKA3vLwKov
	BDyCRsQ8PiOD0GdSwlgyTVjtgJrR/Qx9EtpaQ4JpouHeGzewe7YCgK+nveK8izxGqVaSlZRC/xN
	2dvTx74SK3z/eVmFQiTbrehgpyxYvbOJ9n9OS0gmXbI1BwuyIh+IY3ED8lmd5E05HNLhFE1kN/L
	A66FuJ8pYzNwbbLsCUi6SBzQZ7/oBgmbZzbN9QYca+9BTn5YhwqrouLSO43pbwAIadFbE8i6/xU
	eKJxC39VlklzWWqsKvU0F0HZt7pKzZHhygcbaXCAr3GmPtqgpRzXCaOkEQ8I9altbT5w/Sf6QTO
	ukKNRVoYeWBGyRDTBUz1nm1BEPJFLbQSzjAEVv6xAaZ8Io38AbgqxRYeiGtcXjYplfJ2wz5Tg0X
	SA2VYPmKbk2RQ6t2eWu58V5vgL7o2pRxVAHUkZmT8FUs8k0hSDocA=
X-Received: by 2002:a05:6102:b15:b0:5ef:b816:d272 with SMTP id ada2fe7eead31-5f17f3f810emr900876137.4.1768398326144;
        Wed, 14 Jan 2026 05:45:26 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-5f172f78cb1sm753800137.2.2026.01.14.05.45.25
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Jan 2026 05:45:26 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-12338d13f2cso529755c88.1
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 05:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768398325; x=1769003125; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Z47x1uvVUM2IS56zlJQKoYRwLdGmlbxVa36JQqN7LFM=;
        b=BKfQ8tHG5Dacb5ydwwHQPMU6AO0/Mzv78C1GSSGXXN0aiXGiBrGTBzJl3sAFA9jUFk
         6xDN1KA4ADL8jl0CpG9KZ8F/NZNi9D/QUbddJB09KR+kYN3OSXpJ2qs8n3Ra5ikDKVNB
         cK8N5XKQojG0qmjkCIh7U1Wg8lt+fQBaztbg8=
X-Forwarded-Encrypted: i=1; AJvYcCXNdqbP7+kF912qF0Aac0pQmMsk1CzHEGWwu15h0gWkRN/VHaG0gq38NymouaZy/KLdJZWZ0uwjr16+Sd41BA==@vger.kernel.org
X-Received: by 2002:a05:7022:7e05:b0:119:e569:f61b with SMTP id a92af1059eb24-12336a46907mr2685855c88.20.1768398324862;
        Wed, 14 Jan 2026 05:45:24 -0800 (PST)
X-Received: by 2002:a05:7022:7e05:b0:119:e569:f61b with SMTP id a92af1059eb24-12336a46907mr2685805c88.20.1768398324250;
        Wed, 14 Jan 2026 05:45:24 -0800 (PST)
Received: from [10.229.41.31] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f2434abesm30964345c88.4.2026.01.14.05.45.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 05:45:23 -0800 (PST)
Message-ID: <74e3bb49-ebbe-4692-b278-c04f2a30bf96@broadcom.com>
Date: Wed, 14 Jan 2026 14:45:16 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmfmac: Fix potential kernel oops when probe
 fails
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com
References: <CGME20251231143556eucas1p141b278048039730d03edf85c6f3e5350@eucas1p1.samsung.com>
 <20251231143544.4158840-1-m.szyprowski@samsung.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20251231143544.4158840-1-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 12/31/2025 3:35 PM, Marek Szyprowski wrote:
> When probe of the sdio brcmfmac device fails for some reasons (i.e.
> missing firmware), the sdiodev->bus is set to error instead of NULL, thus
> the cleanup later in brcmf_sdio_remove() tries to free resources via
> invalid bus pointer. Fix this.

Hi Marek,

Thanks for the fix. Please consider my suggestion below...

> Fixes: 0ff0843310b7 ("wifi: brcmfmac: Add optional lpo clock enable support")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> index 6a3f187320fc..6615748fa5bb 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> @@ -954,6 +954,7 @@ int brcmf_sdiod_probe(struct brcmf_sdio_dev *sdiodev)

Maybe use a local variable bus and assign it only on success:

>   	bus = brcmf_sdio_probe(sdiodev);
>   	if (IS_ERR(bus)) {
>   		ret = PTR_ERR(bus);
>   		goto out;
>   	}
> +	sdiodev->bus = bus;
>   	brcmf_sdiod_host_fixup(sdiodev->func2->card->host);

Regards,
Arend

