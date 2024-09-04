Return-Path: <linux-wireless+bounces-12468-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B34096B5AD
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 11:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBC8F283A91
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 09:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5B519750B;
	Wed,  4 Sep 2024 09:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVgYHbWl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7624BA27;
	Wed,  4 Sep 2024 08:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725440401; cv=none; b=a0nQvyFnZZHrL1MojWddQG9njIjA8LoyF4s/GaPy5OUNdMrtWM4za2iQfsh5f0wPonWdDMD3XZwkky2gAeLOfmTPpFIybcLSzFKFFe8qmHXFPhH6Y16T1VDGFpjx3vuPS0Ukt6dkLHupIheMVIe6eL0OknDRxl4WFMKQidBp9zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725440401; c=relaxed/simple;
	bh=+G2usgn4a+EGpk3Mm4DFdRwFN0xwQO5uU5+f3cz4bKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tXg5YmUzC4MLk5x4hBJFUIQyTEr0u4a3iNeAR4Jk4/Hd87AcsOEmxSNbVvL/Z3gN9oxrfK+Edo81NoqcYcGPwokc6GmZFrJYgmODZlv32auFtV3BUDFI+6w9VvqNMG56YA5IKWZmRBHAEDf0I6AtrFBpxfP/EcRPL69mHfGK8yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVgYHbWl; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4280ca0791bso54331985e9.1;
        Wed, 04 Sep 2024 01:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725440398; x=1726045198; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4F1EGCjC7Ig/iohj+d8dfMJ/hszHiORISM5N/rkuWTw=;
        b=BVgYHbWl45XbDf/moD5B9y1I/qkDxk4mlgnx/y2Bkh0CqA1BDMv/KCw3GTNruy9fIo
         1tRX2XL5s2elT4EP5Y2AZ75nFMDHfzypBFTz3PUlX0tjdUt2Lalrj4r7039djpxR3MzV
         umvw1UK/TL5+3WuqSfzTE/TJQO04bEk6whyqlQFJt0ZCWqFYRizFT92mBdy3qpW0eRzt
         K1GpqC9IGX4QA6/xstSBVR5SsNAveRKiG02OyQgs0Xd3Bwsum7fIwbl3Q7ZbWd/7/WGo
         lNFx2E8CldYIL5kz9KYs1ylbC5Ce1iRCnksirjKTWjtRsjGBL11iiRuQE4hBCzhwzVYM
         rmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725440398; x=1726045198;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4F1EGCjC7Ig/iohj+d8dfMJ/hszHiORISM5N/rkuWTw=;
        b=tuaRWXZWDDhSa3Z2zYOF0fxyMkPz2L/xB/cmcTTUq/ZkBRi0pALGPizclGkGgg9++J
         Ten4FDYXYbE6irrJK8XukU3vcHnDdDo4fv9ZKXE+b6fY7LKjbbCz+qy5L+ikMbI273Rn
         XyVOP0chhMFwJRz28fPdKYDztbX/uysIA/OghT+RQ7QushOd79WywKH6qk8Man/zPtrB
         wiuBOYUolYUkr8xK/dSiPVlSdy8HX8m0d9gQ9fkw+N39+vK12VqDxWUa8HAYGXV7DZZG
         cmYiTPJMld1VqcDb+IguhRIszaBZx8OOY/t5cBT81zgvaWq9NwiffbOXlJfSxB1d2mo0
         Qv9w==
X-Forwarded-Encrypted: i=1; AJvYcCWW38YMy6dekzTNZZ8yOgfY+FxsXIHtmXoSA5EhWDd6XfLnf2Yl2cJ1ZMC3rRpRgtRyLju2ebt7UmPZMiU=@vger.kernel.org, AJvYcCWnrZAdr6tR5+PeeHUIrCe6Geo2eFLi2eDZCt53KXPanrsM2C7ZXnWlGMLEQewp7XSfK76D5p7x@vger.kernel.org
X-Gm-Message-State: AOJu0YwzKsl0s9gw9rOY0Srsqk5390IKKCxhGcsy+OigMAFgJO5pL5vp
	CIj3ycVtWUI6983temDyEuk1ARzu1UfqoKWUg5sEepj8kKToGwD1
X-Google-Smtp-Source: AGHT+IEGftMYPNkw/FmcSACDFkJgVxkXL0fkXDxQ94ugLPxET1a6Q/gWIxS0tgGbWMwIDlsgEN2Gzg==
X-Received: by 2002:a05:600c:3b22:b0:428:2502:75b5 with SMTP id 5b1f17b1804b1-42c8de79fefmr24571655e9.11.1725440397749;
        Wed, 04 Sep 2024 01:59:57 -0700 (PDT)
Received: from [192.168.0.20] ([148.56.230.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bba3f2875sm178104535e9.41.2024.09.04.01.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 01:59:56 -0700 (PDT)
Message-ID: <84bab711-7666-4766-8c25-b8b0e44f182e@gmail.com>
Date: Wed, 4 Sep 2024 10:59:53 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] mt76: mt7915: check devm_kasprintf() returned
 value
To: Ma Ke <make24@iscas.ac.cn>, nbd@nbd.name, lorenzo@kernel.org,
 ryder.lee@mediatek.com, shayne.chen@mediatek.com, sean.wang@mediatek.com,
 kvalo@kernel.org, angelogioacchino.delregno@collabora.com,
 johannes.berg@intel.com, ruanjinjie@huawei.com, howard-yh.hsu@mediatek.com,
 chui-hao.chiu@mediatek.com, greearb@candelatech.com,
 akpm@linux-foundation.org
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 stable@vger.kernel.org
References: <20240903014955.4145423-1-make24@iscas.ac.cn>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; keydata=
 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
In-Reply-To: <20240903014955.4145423-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/09/2024 03:49, Ma Ke wrote:
> devm_kasprintf() can return a NULL pointer on failure but this returned
> value is not checked. Fix this lack and check the returned value.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 6ae39b7c7ed4 ("wifi: mt76: mt7921: Support temp sensor")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/net/wireless/mediatek/mt76/mt7915/init.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> index a978f434dc5e..7bc3b4cd3592 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> @@ -194,6 +194,8 @@ static int mt7915_thermal_init(struct mt7915_phy *phy)
>   
>   	name = devm_kasprintf(&wiphy->dev, GFP_KERNEL, "mt7915_%s",
>   			      wiphy_name(wiphy));
> +	if (!name)
> +		return -ENOMEM;
>   
>   	cdev = thermal_cooling_device_register(name, phy, &mt7915_thermal_ops);
>   	if (!IS_ERR(cdev)) {

