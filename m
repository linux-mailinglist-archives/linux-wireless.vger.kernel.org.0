Return-Path: <linux-wireless+bounces-28409-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A71BDC203C4
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 14:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CC20421E39
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 13:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777A732E699;
	Thu, 30 Oct 2025 13:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AEEO4qE/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yx1-f100.google.com (mail-yx1-f100.google.com [74.125.224.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0139322C80
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 13:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761830837; cv=none; b=unPDTjFXac5P9aRtlNLWZQUmiAq502KpqGSLd1b/QQDkqjv2vsTIunJYWoM6+8B8HzNO+UzeZ6EP2pf9+mztTd7e4Buua/obLsB6eWTmFh7Js+1ov5+dZeIiGStMfEh+ULJOW7cxAYwX5lG1zOWRQ6tYkolTPOIF/ME9ahLawUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761830837; c=relaxed/simple;
	bh=1qUD48hf7Zf4bL0s/Ql9Y1pI9LG/2BGYn8uIuRM7T6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hT/KlbukjCwVEBwKxM8dSXUEboPysqh+GVh0dhJM5ujvGOvGqM1F25hm/oftgjgsK6CxjmH6lvFr3i665fP4xnIJdYZdX8siw5mzVRrejvt5S9Yh7GKZBTuBMb3bLxGENFwM7wWVSJhvPWldSZv2cx9sISwOSWrmxUS5V81B35Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AEEO4qE/; arc=none smtp.client-ip=74.125.224.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f100.google.com with SMTP id 956f58d0204a3-63f870cc79aso601539d50.0
        for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 06:27:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761830835; x=1762435635;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dMXWIu8U60uApRCrqyrIhfDspTa+9zuuI22qzRz3bTA=;
        b=U2BfMPnvZR1nJe7B8CmlObbVQmE1I9FjyswCIhsLCvWxpYZTBkCRjSaw9FBr7InOVT
         07cEQciA7aNGFVdaeTDC9AU4yY+YE38Vyf3TfYt8dzmeUKTx0g5zbqNcOv35gm9Wbmk1
         HjAYmrYJRJsWMeUlHnzlSGWQ0Nb3CxJkFxysi0+Cr99JzTNHrGJx2QNy+URTPSd6cs+p
         /EK8qjH9C0Fs2bh6MPFOAve4yVEgst5nCgQDuyyfAcnEgocCmMza63qycTERXFp9p41W
         q8PnKIlQSoXpf7IcrbEzHlZDSYtrxxiGf1Wm3bQaLE1A4i+oB559gfPuJRys5NDFhalY
         8edg==
X-Forwarded-Encrypted: i=1; AJvYcCVgwx4yrct5Cix7kgGoGfaC4vpKbOWptBVVF7LU/Wd4F2JeJm1YTLLRQ+ovLzyriRNx0LftbyNY6P3amqNX8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd4hwZ2FETkGYFjXAiv+lBe9my01ggGuDMQhn6HNj3UIhCtpRF
	gW8PHaIsVQAAgx3xJg697633gejBKx2tTnVxJfSXDxXlPMdusp0wNV9hWzugPPGBc7U5lK/qa3k
	oAoFS6JZuJX1qDrIHgIk5c9BTNYoWuSvv9bLFtrB3CRzZHq8D+M3MEcM69V9fnvV/57WqHemDoP
	t6QXkoBPZ6CF3fAK8+6sciPHtzn0ULjU0BZ9vT6mnqCMpEqUt0N45h8X6TNHUAAonEOa87HCOUi
	zroYnQbJD3bsDIHI10hfqDat04W
X-Gm-Gg: ASbGncuxZto5dPLnyLh+l/6S6whm17ERZhcRcpxuDLcxqoTPXyDYoym80hmQKWlzQ+v
	XcocFwKJfr+Fq4kK0lVrPjCcI5AmbQkDNqXRlacor9JXXP9XHfMbSH8nxX+6ew9HM9OIyICWEzw
	HX5LGgRnKW4/Gau2T065DO+BQA/wvP4ZZ8rj/DM8fwlHlgttI5ASCVEuZN+Venbbwq2l9vjdQyB
	xR/uI/EjicPYuawCjRx3Mgh2ij9gbxkKwjIgoILdlvUxEzNrSaPA1AOXgR7b4YLTGBdJpbHy6b5
	zefMV53vsj3r2DqhVFAqffHpUxy1HckVtUbpYRSQnTo2/z3/75DErWTJN0eYZzPAHp9231omoV6
	O8dL3qczgHLd61iE5fxytyWiZPO/0Kd+HTVuehieAszCjzCxH6KR/foeoVYJTEXXSAXUJK/CuIw
	Skmdaz9B2UwflnY1rT0zy/I0iG7/fZdw9B7/TVGTIo
X-Google-Smtp-Source: AGHT+IGXFoGlRhntrrvEchttE8k2yzgARcYgke60R/qDBLeysVezwI3bsAC04U1f+VZzmRzq1ZlLLi6GcbOB
X-Received: by 2002:a05:690c:9a8f:b0:785:bfa1:223a with SMTP id 00721157ae682-78628f8d9edmr60711877b3.45.1761830834621;
        Thu, 30 Oct 2025 06:27:14 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-786444a5f68sm376177b3.12.2025.10.30.06.27.14
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Oct 2025 06:27:14 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8904a9e94ebso267088585a.1
        for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 06:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1761830834; x=1762435634; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dMXWIu8U60uApRCrqyrIhfDspTa+9zuuI22qzRz3bTA=;
        b=AEEO4qE/GVz5H/LknnNrdMy5UIPE7EtayioLrjSQ8vqikvVpDgueiphI+bqoA3ewSd
         LvOH7YIyz9MdlOUqfJlXeOgEIc2hZL4mDot3QLDaKl+lgdcbLvPtqEyNLCNsI1M7Xl3i
         rd2/d+W4AL0x6t1I56MddRvMMt9F8YFSgR/y4=
X-Forwarded-Encrypted: i=1; AJvYcCW+m9fiMOtZ9Bfhi+v06+KxO2HBsoMjuaMzeG/wMzqU0jEF0dzBM7zgIKNQv080pzcSn41eVRgO6PIvpYnEng==@vger.kernel.org
X-Received: by 2002:a05:620a:45a7:b0:82e:6ec8:9887 with SMTP id af79cd13be357-8a8e3b9b881mr886990885a.24.1761830828815;
        Thu, 30 Oct 2025 06:27:08 -0700 (PDT)
X-Received: by 2002:a05:620a:45a7:b0:82e:6ec8:9887 with SMTP id af79cd13be357-8a8e3b9b881mr886986885a.24.1761830828170;
        Thu, 30 Oct 2025 06:27:08 -0700 (PDT)
Received: from [10.176.2.229] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f25e8685fsm1259974385a.50.2025.10.30.06.27.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 06:27:07 -0700 (PDT)
Message-ID: <17ed1078-772e-4c01-ba7c-63c58d89c0d9@broadcom.com>
Date: Thu, 30 Oct 2025 14:27:05 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmfmac: Add null pointer check to
 brcmf_acpi_probe
To: Li Qiang <liqiang01@kylinos.cn>, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com
Cc: linux-kernel@vger.kernel.org
References: <20251015071607.96415-1-liqiang01@kylinos.cn>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20251015071607.96415-1-liqiang01@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/15/2025 9:16 AM, Li Qiang wrote:
> devm_kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure.

Thanks. However, it does not make sense to just bail out. 
settings->board_type will still be NULL and apparently that is not an 
issue. It is used to fill the firmware request (see struct 
brcmf_fw_request [1]) which is done for PCIe devices in 
brcmf_pcie_prepare_fw_request() [2].

So struct brcmf_fw_request::board_types array may hold NULL pointers 
which is not an issue.

So this patch does not solve a problem.

Regards,
Arend

[1] 
https://elixir.bootlin.com/linux/v6.17.5/source/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.h#L67
[2] 
https://elixir.bootlin.com/linux/v6.17.5/source/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c#L2264

> Fixes: 0f485805d008a ("wifi: brcmfmac: acpi: Add support for fetching Apple ACPI properties")
> Signed-off-by: Li Qiang <liqiang01@kylinos.cn>
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/acpi.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/acpi.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/acpi.c
> index c4a54861bfb4..f8f6433bdf69 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/acpi.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/acpi.c
> @@ -25,6 +25,8 @@ void brcmf_acpi_probe(struct device *dev, enum brcmf_bus_type bus_type,
>   		settings->board_type = devm_kasprintf(dev, GFP_KERNEL,
>   						      "apple,%s",
>   						      o->string.pointer);
> +		if (!settings->board_type)
> +			return;
>   	} else {
>   		brcmf_dbg(INFO, "No ACPI module-instance\n");
>   		return;


