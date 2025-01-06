Return-Path: <linux-wireless+bounces-17106-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0AAA023BC
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2025 12:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 462BC1636C9
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2025 11:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05E6191496;
	Mon,  6 Jan 2025 11:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hdT3pPkd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F18635
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jan 2025 11:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736161343; cv=none; b=rPoK19/TzBQCXB9I2kcAvRFZdFt4iQWcQHR4i0UIQLtLolwdk6qG5qTYI6GyiOAz4fQafArVYuyTf+Oryc2K4hkTw7/Q1WpdGqpkN+8PgNICCoYazlUU/VIAYd+IEg9FAq1fEFwVfD+hUmuBJ9LQvaNTFgYaSXOQSsngBpmJgJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736161343; c=relaxed/simple;
	bh=xenGdwZ+CO+XYVvP+TNK80jdVJE3XKKm/jKtxyk2vV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=M1/u1cxndLMpuhpQoDPu98409SQI8M4ZPl+TiVKT3+PzINP+H/fJ8TME0FAn4XTZMp8r91T/V3m1pML8Q563ugDPI6tGGrPJNfyzjj+5EbNnpZOwMst4BGbGoX6emEltL5NX5akpuadVJimY5m6FZbmxkKRyvY4mpV6hW8ZIX2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hdT3pPkd; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43675b1155bso134683945e9.2
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jan 2025 03:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736161339; x=1736766139; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p/P5eEHPa9/FWZToggvS0ac+uKwxGFRsDufS4dXTo9Y=;
        b=hdT3pPkd09nAUyotudlPtopxd23RbK8qf+KbE1Y93ZuNiMYRdtJeIxt4qFiCkPjfol
         zu31lhwMwAB9vm3GrfKzyEUd3hr9ffg2VQLob9d1gb6qOUQw0Xl7obcDzuMTDveKkSKe
         8BsdzUgtaMdTYbapR/mLw9nE1N65L8RauM/SY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736161339; x=1736766139;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p/P5eEHPa9/FWZToggvS0ac+uKwxGFRsDufS4dXTo9Y=;
        b=bHA6xrqs67J7nnxxtcypntRLswpjEPKbzI5gouxOnaJBYYzGprFPX4BoMgRu21e6tC
         UQIvoLkU6fQiwywrVnjRQp7PrPVPoreDoY6OqfP71Qgl62/9iMBEL5+Z8iMbOS83Ehkc
         oVd83DSQ1w+St95lK8YvdNJx3OQiBciOKtGkq19VMrWFZdrvIi6l+KXObF4AeJGrBmRO
         myhkYFuFM30MwcDsi/gCBhjfT8BRPPUXslCcehv4G1tpCgguJ7bqdnguZGhZaw5Ys+WQ
         NFHBhmrB7PMqCfdGyY+w8Avc/ayEU+oLbi4TIA7PK5D9m66/z3yGdHWQfv1+cGnmaPX7
         eGQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdw61TNHmApEYoDFFM9iGCtEsc/4/ImLLNmQDmJUJPd6B4KB6bzBpvVCmLsNlhyye6HUXpsUrGP2sMfGErAw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz776w6a6YKk1Y3C0fJ4stw35SH6+aVk3SN6XGPXINOXYl8uAdG
	XW1J/3jsQKGxwsLiN46BSQ4ZPkfvXZcPWD0BG7NopVQb1yoWEr3gP+KZT8vpzIaaOQkGbnQN3yF
	Stg==
X-Gm-Gg: ASbGncugOsa3vS1FM0oXhi3Jc7FnqD7rVve2ERAUtrA40S83JdWLwRk+6T/kk5OfryP
	VWNEGeTwgTkukkVBLSIHHzwt8deS0+FfG5jlLNWF/3XEFkXLnPsf724TQ0/MPm/gU29EkYdUX4/
	UkdsNpJErsao62NRhlRJb52ZJx34AEU9J2JG1/3HqvgVhlKKH1nWb4suNIigyAHCrvjWXHBAf8Q
	UHJOFI0XPj0dVHoqX8jrm5GLRfdvsY/6FjkcmwxkkWKPpT4RwVH9AUMTcmhQ6ITQiVnrWwE9DTB
	c+6BQDQ=
X-Google-Smtp-Source: AGHT+IFKUP9T1IGRx66WTIKFnTJfioOVjqfVutOxyBFO+Hv1G8wn4hHH8K93RnxuPSXNNxqDVJ3yIw==
X-Received: by 2002:a05:600c:4f84:b0:434:f7ea:fb44 with SMTP id 5b1f17b1804b1-43668644255mr489932025e9.14.1736161339132;
        Mon, 06 Jan 2025 03:02:19 -0800 (PST)
Received: from [10.176.68.63] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e261sm48345371f8f.76.2025.01.06.03.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 03:02:18 -0800 (PST)
Message-ID: <058aba76-817c-480a-9404-38b030325890@broadcom.com>
Date: Mon, 6 Jan 2025 12:02:17 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmfmac: Check the return value of
 of_property_read_string_index
To: =?UTF-8?Q?Stefan_D=C3=B6singer?= <stefan@codeweavers.com>,
 linux-wireless@vger.kernel.org
References: <20250106103749.5764-1-stefan@codeweavers.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20250106103749.5764-1-stefan@codeweavers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/6/2025 11:37 AM, Stefan Dösinger wrote:
> Somewhen between 6.10 and 6.11 the driver started to crash on my
> MacBookPro14,3. The property doesn't exist and 'tmp' remains
> uninitialized, so we pass a random pointer to devm_kstrdup().

By the looks of it this is an intel-based platform. Is that correct? So 
does it have a devicetree? I would expect the root node find to fail, 
but apparently is does not. Strange though that root node does not have 
a compatible property. Anyway, the analysis looks sane so ...

minor remark below.

Acked-by: Arend van Spriel
> Signed-off-by: Stefan Dösinger <stefan@codeweavers.com>
> 

[...]

> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> index c1f18e2fe540..ee589a7b4f4f 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> @@ -99,13 +99,15 @@ int brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
>   	/* Set board-type to the first string of the machine compatible prop */
>   	root = of_find_node_by_path("/");
>   	if (root && err) {
> -		char *board_type;
> +		char *board_type = NULL;
>   		const char *tmp;
>   
> -		of_property_read_string_index(root, "compatible", 0, &tmp);
> +		err = of_property_read_string_index(root, "compatible", 0, &tmp);
>   
>   		/* get rid of '/' in the compatible string to be able to find the FW */
> -		board_type = devm_kstrdup(dev, tmp, GFP_KERNEL);

No need to use 'err'. You can directly do 
of_property_read_string_index() in the if statement below.

> +		if (!err)
> +			board_type = devm_kstrdup(dev, tmp, GFP_KERNEL);
> +
>   		if (!board_type) {
>   			of_node_put(root);
>   			return 0;


