Return-Path: <linux-wireless+bounces-12527-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DE896D124
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 10:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 271401C24AC4
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 08:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2077A1925BF;
	Thu,  5 Sep 2024 08:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/hLPWRz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D527193091;
	Thu,  5 Sep 2024 08:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523278; cv=none; b=R3qmxRWdQEpP7z01fRl8SeVv+qq65legfWrK4XVMyWC121iWf1aZIKfvhIP71lA/hlGLhTHqRmsPYaAcBwAXGkA37L2ROSLrmUK5n+6fB2YyvjcXugC3KnEdx1V/qt53zpDX4Sl8i+bBkev+EnpjgNwwB/mOwtnGR/BOvZn6BOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523278; c=relaxed/simple;
	bh=g/G6fC1t92vBARBFxM4ykEspSqklX1qrJ0Jto4VXSFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u8RQGhSVPpA5mwU8ahlSGmvQ9o4hHo80V3NtoNMDEWVUw3AHPc/rcJZPxQfdScp0F4/2vBvrB8cQvfrsPkxAOClua+7X/wJEYGaBOXtRVxbnqMzoZPn3kfwJj3CILa4jLTwRRaRG/sC/tplNm1ok3kQK8TSPF3hUw3w+7ASe0dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/hLPWRz; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-374ba78f192so219868f8f.3;
        Thu, 05 Sep 2024 01:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725523274; x=1726128074; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LcloJpQ7Qx914ckr6DHP/VtDGnDFfv98JfcoR3vFduA=;
        b=l/hLPWRzfZZkb0ToBX2+3FWa59KTdyO1asCMK3L0dRPbZIhaiACPp06TIP5DPCzJCR
         xzIRo7vokzta9Gkd7mugGgbkoC1KdBZclGJ9sZAl4YQ8DwsnRvfrKSQxvm1BTl/6k2Hv
         kYwNe2gM1NGmrrmfSj/h8DNFFn3Ygv0wHIWQoRUFANwjIQnKQ/N0JnHLj2sKAALyYfdm
         GcfFm18ZI4ewL2H5vb7vILlTWnDVt362+iRLXfDC4t9gZ+u4+phnYSvDa5Vs4QJQb15/
         0bCT2kM439HWJgSpV99Yp6OJuFhJrhkE7OChP9tX27HLjmkdnomhzBDRguQ4TiPmQGAG
         M7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725523274; x=1726128074;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LcloJpQ7Qx914ckr6DHP/VtDGnDFfv98JfcoR3vFduA=;
        b=lciZJBD1J7v50VoMpXYnPG73RoHL5PbpOgtANsMEYnBMpfxY5GNg8HucdMjUvnepj1
         r90VLA/g/Uj3UR84WmXywISNqN/9CkGclNwrJyxdJObl1SLg7A4uPBJ/xKEWGKa5Fd7v
         R1IPRpaJM/2SNNmgaPVUPqV7k14dPOUjBhDvGyUe83zqOcAii1ptFaPthmvNpcTk5s9r
         EcX4Ny1FBHb0V2nwuygT46TsmhWp8J+BKmVWHYmSEQGGttf3Y5v4NY3EhQSx6ssYOhIV
         gilBNqyh6exQ4KXlC+xS8jl+0z9pc/f3ArxWE0xxPYkBDOIXkh2GmqEUxwNpsxHt3Gdu
         h5Pw==
X-Forwarded-Encrypted: i=1; AJvYcCU5QWoNLCsLnc62iwyVBAc77Qh+KCVUagwAz4AE6SIrnGrkWaI4y33HIcuwZqMTWnEPmPflUrpp@vger.kernel.org, AJvYcCWoNHw1iuCxJH0in072YHlrpSW8H64NkfFFguROINAvp40EZ47qoi3EoFTjK21gKJEs34LjTczl6bS9eCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR03r8ekgRmOCV+7YCqhWqqxuHHWzfXnPY5xhf4eMGV6sz2QZ7
	i4B6Zh0gId41KfYiDIbnQOd0pD1yMgk4Ah0Ox6dLrLmQ0aKTcHRw
X-Google-Smtp-Source: AGHT+IH0cTvMC7J9SZVb/l2bMXoWPnfwQMm6bTLm0lrIHjJQ8ONHttlFqy/nKxKAXLIAVrlr7wJFjw==
X-Received: by 2002:adf:fc08:0:b0:374:c2cf:c017 with SMTP id ffacd0b85a97d-376dea47344mr3921448f8f.46.1725523273889;
        Thu, 05 Sep 2024 01:01:13 -0700 (PDT)
Received: from [192.168.2.177] ([81.0.7.156])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374d1dd1e76sm7770962f8f.113.2024.09.05.01.01.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 01:01:12 -0700 (PDT)
Message-ID: <1ac78d8a-c0dc-4f90-9e25-6d9569894670@gmail.com>
Date: Thu, 5 Sep 2024 10:01:11 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mt76: mt7615: check devm_kasprintf() returned value
To: Ma Ke <make24@iscas.ac.cn>, nbd@nbd.name, lorenzo@kernel.org,
 ryder.lee@mediatek.com, shayne.chen@mediatek.com, sean.wang@mediatek.com,
 kvalo@kernel.org, angelogioacchino.delregno@collabora.com,
 ruanjinjie@huawei.com
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 stable@vger.kernel.org
References: <20240905014753.353271-1-make24@iscas.ac.cn>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; keydata=
 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
In-Reply-To: <20240905014753.353271-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/09/2024 03:47, Ma Ke wrote:
> devm_kasprintf() can return a NULL pointer on failure but this returned
> value is not checked. Fix this lack and check the returned value.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 0bb4e9187ea4 ("mt76: mt7615: fix hwmon temp sensor mem use-after-free")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

If you find more problems of that sort in the mediatek wireless drivers, I think 
a better approach would be to send them all as one patch.

> ---
>   drivers/net/wireless/mediatek/mt76/mt7615/init.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
> index f7722f67db57..0b9ebdcda221 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
> @@ -56,6 +56,9 @@ int mt7615_thermal_init(struct mt7615_dev *dev)
>   
>   	name = devm_kasprintf(&wiphy->dev, GFP_KERNEL, "mt7615_%s",
>   			      wiphy_name(wiphy));
> +	if (!name)
> +		return -ENOMEM;
> +
>   	hwmon = devm_hwmon_device_register_with_groups(&wiphy->dev, name, dev,
>   						       mt7615_hwmon_groups);
>   	return PTR_ERR_OR_ZERO(hwmon);

