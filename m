Return-Path: <linux-wireless+bounces-11426-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2174D951912
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 12:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B79E1C20D8C
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 10:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362D61B0101;
	Wed, 14 Aug 2024 10:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DD7OpIbQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABDA1AE85A
	for <linux-wireless@vger.kernel.org>; Wed, 14 Aug 2024 10:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723631889; cv=none; b=VrcDanZkOUo1jewD2yDh/NH7Y3GW7vQ4Qdd+N6yhtGtpNLTCIxi77tFFaZ7c6OpU8EW++t4fp4l2SFjYiHj/+ZSfCr8Mao35oOOXnh5Q6h4ZCsHV6fQyWXPJRAs2cSrQWqnBXq1t1wF6kAlVS6M2/8LraBTZFSXqHeFBdVh4xXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723631889; c=relaxed/simple;
	bh=BjLFDKJyMJol4iq7ns3l6PNcv2TAWojsCWm8EzURTP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dBtZBhItQYdSdA8CJa7jhpp1VX5Sk2+Vb/F196Mx5d6WNUx01lq8zioNiXiiL7E8SrgO8q93tvZSDhDR94xgGgdcYGPDO9FXMKDegV/hEEosgEA4XvdNGYORmne/BSD0SgzCQtnNtEGjKGTIIwBJRv5QqhWQ30hpQxo3JAYAMI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DD7OpIbQ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-368440b073bso446478f8f.0
        for <linux-wireless@vger.kernel.org>; Wed, 14 Aug 2024 03:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723631886; x=1724236686; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fNKkWw51f5wypgz5w1sJpTMeYJTuNSrvezVgh7cX/iw=;
        b=DD7OpIbQzKUaMSOAKsPFGdPVDH4oT+5nuwnyrNo93E2y/w6bbTo+S9g5yLCx41oPRI
         9aFguTIb+a3yojSJwW0CW+MRoXlu35C/DIm6un32o7TDegumRiwaNUmT4y3f8dBdlwdt
         4ui0WfkUUiryyFjvubnAdMIQcAdEBlNse1hEtqOo8SD+5oAfV3UIN8OnnDwdt9mQmtdR
         79ZbJe2s28BTPJlvmIvNrglGKJ44XeyFjd/ohzVc7L0kuyFm++vfM5n1OdrBeHXaXmF6
         Ikti87u24oxT1Yv85eiTSmdXSAp3ydfRzhwvaUKRaWbu7NesMKL5U5m2CJ+PVDEX+bl8
         Jw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723631886; x=1724236686;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fNKkWw51f5wypgz5w1sJpTMeYJTuNSrvezVgh7cX/iw=;
        b=ukEo02yIVWeP2uSvtR29mILURTGddX/FOJi+yaH2ZFvut5J82+/S4wB+EKCW97o6tJ
         Nxrp3Xvqtx+qeyUxjI2i1SH/i2UItBF6k9Vxul/zpYbThSGzZSdbY+jr0MtQTFxRYAwm
         T5sB3ZnodUg1nuo7y0OS4mNR2LfRH4zCOLONnf9Df0XQMcQ/9lD7RpCnPvL25L6NnuFM
         7Ucm5driIl37JrA984J92CKVCEhqonPOkgepO6RIUuMhbGM33wvyM4LpY1QM0dWfOntd
         nRYOTL/wwWm5lLmgVnrklJJgmOoSJmWl7FU8l96l20xT2bBMiaesnGtTi98EXxGc8+qW
         yoIg==
X-Forwarded-Encrypted: i=1; AJvYcCXm/n7itn2BnVWH+7Yc7b6JKnrHGNnixMyFAG6qbttgTR5wwJ8HfpccJzPLhvVBvGXTzB6NV3xlALuWTQvHLJPjjYXzXWRoa/zyimsRsak=
X-Gm-Message-State: AOJu0Yy6xVjbwjJ4+Kr3H3gtFsAgWm+90hqOOx0QSQQBxDYQkJe4ET4g
	bQMbJloxf7bPuVp4x4J1qf+fOl9GGPn0Lqd1n0NEWhCih2vFIqIO0mJY09cOM4k=
X-Google-Smtp-Source: AGHT+IFAKzLv7ilDET28IMwrLig755ftX5WyeocJ71rGFpy8qsd2JDPFQqU5/gZhPVT74JHfONE3xg==
X-Received: by 2002:adf:e549:0:b0:36b:a9e8:6b5 with SMTP id ffacd0b85a97d-37179620f6dmr1306544f8f.10.1723631885531;
        Wed, 14 Aug 2024 03:38:05 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4e51eb10sm12424380f8f.84.2024.08.14.03.38.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 03:38:04 -0700 (PDT)
Message-ID: <7bf93d78-ba51-45b9-85d7-2b7e4e0b2e56@linaro.org>
Date: Wed, 14 Aug 2024 12:38:02 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/5] dt-bindings: net: wireless: brcm4329-fmac: add
 pci14e4,449d
To: Jacobe Zang <jacobe.zang@wesion.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Arend Van Spriel <arend.vanspriel@broadcom.com>, robh@kernel.org,
 krzk+dt@kernel.org, heiko@sntech.de, kvalo@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, conor+dt@kernel.org
Cc: efectn@protonmail.com, dsimic@manjaro.org, jagan@edgeble.ai,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 arend@broadcom.com, linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 megi@xff.cz, duoming@zju.edu.cn, bhelgaas@google.com,
 minipli@grsecurity.net, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, nick@khadas.com
References: <20240813082007.2625841-1-jacobe.zang@wesion.com>
 <20240813082007.2625841-2-jacobe.zang@wesion.com>
 <1914cb2b1a8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <e7401e25-7802-4dc3-9535-226f32b52be1@kernel.org>
 <05785794-6eca-4ade-a990-2deac7156c48@wesion.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <05785794-6eca-4ade-a990-2deac7156c48@wesion.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/08/2024 11:12, Jacobe Zang wrote:
> 
> 
> On 2024/8/14 16:53, Krzysztof Kozlowski wrote:
>> On 13/08/2024 19:04, Arend Van Spriel wrote:
>>> On August 13, 2024 10:20:24 AM Jacobe Zang <jacobe.zang@wesion.com> wrote:
>>>
>>>> It's the device id used by AP6275P which is the Wi-Fi module
>>>> used by Rockchip's RK3588 evaluation board and also used in
>>>> some other RK3588 boards.
>>>
>>> Hi Kalle,
>>>
>>> There probably will be a v11, but wanted to know how this series will be
>>> handled as it involves device tree bindings, arm arch device tree spec, and
>>> brcmfmac driver code. Can it all go through wireless-next?
>>
>> No, DTS must not go via wireless-next. Please split it from the series
>> and provide lore link in changelog for bindings.
>>
> 
> I'm little confused that I should push bindings as a series, DTS as a 
> series and driver as a series separately, so next time I should push 3 
> series, right?

No. I said only DTS.

Best regards,
Krzysztof


