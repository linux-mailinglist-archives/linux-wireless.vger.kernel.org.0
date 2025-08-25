Return-Path: <linux-wireless+bounces-26598-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CC0B34AA3
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Aug 2025 20:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 965B71796E3
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Aug 2025 18:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D615427D77B;
	Mon, 25 Aug 2025 18:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GIMBXs1n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com [209.85.128.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181EC27AC5A
	for <linux-wireless@vger.kernel.org>; Mon, 25 Aug 2025 18:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756147840; cv=none; b=sgnsq9u4LePKEVRMPh9saAa/9gTTV6B2j/nqAwa0DGQOeu8idRbjpt8taM+JhHNMyZ9IhOgV01cTXCNodKIYev1f9vWBm8419MgT8TiRiB6rziwJSdxaBDJ9qM4ABA84cNjKMQWAeIUIRdA+ajo6SnZplHahbTQlgQvP+B4Y7MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756147840; c=relaxed/simple;
	bh=LgPf7tO7LA4Nq5C0p3/tFJPAPdgLytXg8fU47WqWOAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lCcggqVamo2tVtXqA+BZR0NS0BLjVsXIOFNRE/rm4MW6I9+oInrC97sNr3/bzH6Ma7YmFo3wN0oppT6eNJiDARY6EXjG7EUOBl7oIfQBQksyjt266eyi5v5fxKRPx8nuE3/CL85wtuHsnInJKG1VNX82bhGU6ZnOFiTQYqLs3HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GIMBXs1n; arc=none smtp.client-ip=209.85.128.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f226.google.com with SMTP id 00721157ae682-71d6059fb47so38848927b3.3
        for <linux-wireless@vger.kernel.org>; Mon, 25 Aug 2025 11:50:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756147838; x=1756752638;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=liJTTmWIhLEKq1u6NIvPKDgRgEjQMcr2uJNbg3L27ug=;
        b=iquiFRANUrT6pNMLxnu/IRGNLLrHKM2vChbkokyd5dEmJn3GN/sY1JJc2i3gfGviWf
         KIeS47SKlR5KctFNJ7LfiR0JDgEg9OD2l8vmI1vMZQljb4lm+JvQEvoRJarXimXvvGNI
         sfBrJ1cv8zV5ZeWRWogsQmMcIuuag+UaiG+nFl65cjUj+0vtm0a5WfbfOC292hp4O1F+
         QoY3JlagZ30UE1PBpjDtlTsRWYPgMOSGzttKAWjHtN7KKwYktxaAu9Qk4bRSnEMOaZdd
         vk8j9/0lawG7//gLY+VEyuArDEjCZEisF4RRMvX3DjqxJbE/7KTjBkxyOg0l6pTmt3eV
         ihOg==
X-Gm-Message-State: AOJu0YxIKxeY0nIs3OtJWAdLaJ6NIVNnNeZXKujd0X3vAgqo1wPcXwhP
	nXPwyWVjLBvQIBC+UrQlf4uBIIqJYYk2trxeZ2GfOgrI4vNGd9JQLUwR0NfjHFUtdGqEug9/71E
	DBabdfMWNDZ0Ux4X8r1b/xSlDkgRCNO6Nn1XrWPaMfMGQNkCGmJVdyBqVlMf5C6ZteFCIYenET/
	wU7wW9Bs1rJdKXWuyDHsWBWn62HtP3pkk1fJSU/PkXLMYSliHHNNxaT/FfjlCVRaOa2JDzKy9sM
	XqKMei5BOslI3mfKKdyR0N6RJ06
X-Gm-Gg: ASbGncv6a29TUfRVmWDeDUcZgVE5FAzeBSsgHyYTkLPLFbCf8Iuj4Hk0mZJ8gVfT9Yj
	jNjUxycz/ejF8TH6OHwHUOa4T8lNTBrvrKbROlqkSox8f8/TWENhnrNM40HLUlfAyaW3BzyUMdN
	l5Ysd5E1VnBquDWqBR582jsLJ76/BZ3W+4EpNbB0VS3yi6onkGCVawCtwr4ew/62gmzK8FqKRGr
	7Eg+mpJ10sYA6DDJOqgw6NlNK907KEXzGyJhKI0wPb5qfbuBfbcIhuZRpZnwHwRUmZn8qov6rMz
	cyAI8w/ROgupKh2MoXlsSlC0SKuoLqUO3/RlKMGoxIb/Ju9quBQet4f34vJOd1Z8Tv9NhJCvb2R
	NcKIGAPYocKX+BVs/qVepxZeA/BSR00apO4vJd+VvxJ8zIgaDuEWZuwOFmF1RZxOYGuGT4lTZCA
	zvWgk=
X-Google-Smtp-Source: AGHT+IG1/UCVwYsfWQolnH2nY0mczMf2TrKJDG327vVSMVnm2EzFiU8cF6zOsd8GllhtI8/3Ay5k7x8EhVeR
X-Received: by 2002:a05:690c:6e82:b0:70e:2d3d:ace6 with SMTP id 00721157ae682-71fdc2e7b14mr129691797b3.15.1756147837903;
        Mon, 25 Aug 2025 11:50:37 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id 3f1490d57ef6-e96d7dc545bsm75059276.5.2025.08.25.11.50.37
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Aug 2025 11:50:37 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-afe81959cb3so108223566b.1
        for <linux-wireless@vger.kernel.org>; Mon, 25 Aug 2025 11:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756147835; x=1756752635; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=liJTTmWIhLEKq1u6NIvPKDgRgEjQMcr2uJNbg3L27ug=;
        b=GIMBXs1ndciUy9oTrFYuMoLTJ34XA9tfobZZm+H/WzmIVMS6ebaB6q5btAwbETvS8S
         FQRdtDNRWGq3YzrBnJz1RDh1FvD+I2GpfmnGG9W+mkBul5qpvE32fVmQ10EpS4W1l8KX
         bw9BCccY4vTO7DeMCtYE069sONPF2nTK49CgE=
X-Received: by 2002:a17:907:d644:b0:af9:6863:9d41 with SMTP id a640c23a62f3a-afe9ce96076mr50858466b.14.1756147835296;
        Mon, 25 Aug 2025 11:50:35 -0700 (PDT)
X-Received: by 2002:a17:907:d644:b0:af9:6863:9d41 with SMTP id a640c23a62f3a-afe9ce96076mr50856266b.14.1756147834837;
        Mon, 25 Aug 2025 11:50:34 -0700 (PDT)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe48fc07f9sm603202266b.25.2025.08.25.11.50.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 11:50:34 -0700 (PDT)
Message-ID: <11546959-3090-4070-93fa-349bc64f3bdd@broadcom.com>
Date: Mon, 25 Aug 2025 20:50:31 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] wifi: cfg80211: simplify the code
To: tanzheng <tanzheng@kylinos.cn>, johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250825055123.960168-1-tanzheng@kylinos.cn>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20250825055123.960168-1-tanzheng@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 8/25/2025 7:51 AM, tanzheng wrote:
> Simplifying the code makes it more readable：
> 1.Use dev_name instead of pdev->driver->name.
> 2.There is no need to call wiphy_dev again.

Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>

> Signed-off-by: Zheng tan <tanzheng@kylinos.cn>
> ---
>   net/wireless/ethtool.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/wireless/ethtool.c b/net/wireless/ethtool.c
> index 2613d6ac0fda..0acfdc44b479 100644
> --- a/net/wireless/ethtool.c
> +++ b/net/wireless/ethtool.c
> @@ -10,7 +10,7 @@ void cfg80211_get_drvinfo(struct net_device *dev, struct ethtool_drvinfo *info)
>   	struct device *pdev = wiphy_dev(wdev->wiphy);
>   
>   	if (pdev->driver)
> -		strscpy(info->driver, pdev->driver->name,
> +		strscpy(info->driver, dev_name(pdev),
Did you test this with some wifi device before and after applying the 
patch. This is not correct as pdev->driver->name is the name of the 
*driver* and dev_name(pdev) is the name of the *device*. Those are two 
different things.

>   			sizeof(info->driver));
>   	else
>   		strscpy(info->driver, "N/A", sizeof(info->driver));
> @@ -23,7 +23,7 @@ void cfg80211_get_drvinfo(struct net_device *dev, struct ethtool_drvinfo *info)
>   	else
>   		strscpy(info->fw_version, "N/A", sizeof(info->fw_version));
>   
> -	strscpy(info->bus_info, dev_name(wiphy_dev(wdev->wiphy)),
> +	strscpy(info->bus_info, dev_name(pdev),

This makes sense.

>   		sizeof(info->bus_info));
>   }
>   EXPORT_SYMBOL(cfg80211_get_drvinfo);

