Return-Path: <linux-wireless+bounces-11430-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0490E9519BD
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 13:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B45D328137D
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 11:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E4B1AE874;
	Wed, 14 Aug 2024 11:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FcXTEYqq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEF21AD9D1
	for <linux-wireless@vger.kernel.org>; Wed, 14 Aug 2024 11:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723634142; cv=none; b=e/oZZI+ChMK2BLOchDZyuMjHpDQHgf7U654KuRItlzAG8wtOJA+lUST9nyV+JarmhubBoIAotEvjDAqpX9ezwevX/3L9VR9Iyyaimh5GpPasA8EFPVewP4F/cMcscgqhpFrDLc3FCV+VPyv2kCMWNDSFCngbr+5AzuLWOtVfyAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723634142; c=relaxed/simple;
	bh=TSRANZP40Gb5UjsJrIapwEDdUuJg5uHFuOiocwJk6ng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EgbSulhjN3U5AU8qxjiLrynzt1uD187sbbkR8Y57dqzJZFrfjmRI2eAsgqo8XBc8o9rCS1owUPJF1T1PrERMXgczH5Mm0AX3G3/gzt8GGN8DYrMvmjfMmOWJAgoBWV48OJby3+cr01Ztap3JL6wN+UI4co+LVDPDjA0IlXrJaQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FcXTEYqq; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3687f91af40so3937868f8f.0
        for <linux-wireless@vger.kernel.org>; Wed, 14 Aug 2024 04:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723634139; x=1724238939; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9/sTqG+/rfHmJHScki4Ugb8gxHrXjBax2B/xarMt7n4=;
        b=FcXTEYqqPPZ8PDMys3cdW/cTANU6v8+6xveaO24bY443WHpFd0xxIHoT6jYBzdZ0/T
         iKBQrsDNLcqldHODGoCVWOMEbrY8bhaRiufdd5PKJe6Twb0gY64ZT9fTg6fOCh9WiytF
         kxW213AqD2sre05Isuffqyc+O4GFOnTgMim9anU2251ZF7ML5+p3JBpr/7AXg1U2UxNU
         yW//nRl2M7oScSgMTXQww20OZY7nNpyk/70MrgjHi7agsOfZ2prRLstqjOhlc3ix6h4O
         qgXfyoIeHtLTk9KGYUYGbNwCOKSEykWIkbhW89LnezWafQGX1fkrBBIv85C3MOok0rvZ
         BwTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723634139; x=1724238939;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9/sTqG+/rfHmJHScki4Ugb8gxHrXjBax2B/xarMt7n4=;
        b=A4DhJ9zB9iT/7KscSVuGbOh2gQWeoeORFh7uA/cI7ruMLkjyzAwRVeuDqAl+DG6YNi
         CfSeJcQNb589KefTXaxQz037E7fRMg68THyrExP9AwU6w9+WTgYh9x712xFwgIrtebaM
         I95UjNQmZJI0D2hlQLqINjnxE/I+0k/6nvJRY34dDPIMgi6DLXpqYD9K9DHWYkeY5y2P
         a5BXs5p9kpD3mYazY3LH220nz3ZURoyOpoTABk0yAWy+8m1A6IGwhj3BbTTmHH5geHsC
         GCdr9ZK23dt2tYBVv+UARGM8G+0rlhC7rRwTm1z4GsPe3tstm7dtSlDKGsp+t+jnsWhi
         gdMw==
X-Forwarded-Encrypted: i=1; AJvYcCU5+6JB6iabLuY9/gGQnEDyb+E7BDdIo7I3fh8qqp3Z7l3ezXFcOzzByfA5Ck5+3AL7FVFm76AtuXyWZop3IBy0hBHiQPmhBs6cz4eHK7Y=
X-Gm-Message-State: AOJu0Yz+dfDg46UvmqueqZEP/v9IVt4oKqVHffmXuAPbEApubF++K9IC
	4G8i1mmOn56vq3Kg3uwKaNyhOU2DxI9BE0jXFjvacGV7VLYDXJW7pEjWhWaKlyE=
X-Google-Smtp-Source: AGHT+IHPKTeh7IvvDNE3k5/yfiEeZhfikPr0CHce40sB1/ZhibesGiGUUJfU46YfXvEL9kv7YBJCbw==
X-Received: by 2002:a5d:490f:0:b0:362:5816:f134 with SMTP id ffacd0b85a97d-371777696edmr1820585f8f.13.1723634138526;
        Wed, 14 Aug 2024 04:15:38 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4ecc7a52sm12521667f8f.103.2024.08.14.04.15.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 04:15:37 -0700 (PDT)
Message-ID: <df52a968-96be-4f05-8d6f-32a2abde1d91@linaro.org>
Date: Wed, 14 Aug 2024 13:15:35 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/5] dt-bindings: net: wireless: brcm4329-fmac: add
 pci14e4,449d
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Jacobe Zang <jacobe.zang@wesion.com>,
 robh@kernel.org, krzk+dt@kernel.org, heiko@sntech.de, kvalo@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, conor+dt@kernel.org
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
 <062d8d4e-6d61-4f11-a9c0-1bbe1bfe0542@broadcom.com>
 <1e442710-a233-4ab2-a551-f28ba6394b5b@linaro.org>
 <180f7459-39fa-4e96-83d6-504e7802dc94@broadcom.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <180f7459-39fa-4e96-83d6-504e7802dc94@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/08/2024 12:59, Arend van Spriel wrote:
> On 8/14/2024 12:39 PM, Krzysztof Kozlowski wrote:
>> On 14/08/2024 12:08, Arend van Spriel wrote:
>>> On 8/14/2024 10:53 AM, Krzysztof Kozlowski wrote:
>>>> On 13/08/2024 19:04, Arend Van Spriel wrote:
>>>>> On August 13, 2024 10:20:24 AM Jacobe Zang <jacobe.zang@wesion.com> wrote:
>>>>>
>>>>>> It's the device id used by AP6275P which is the Wi-Fi module
>>>>>> used by Rockchip's RK3588 evaluation board and also used in
>>>>>> some other RK3588 boards.
>>>>>
>>>>> Hi Kalle,
>>>>>
>>>>> There probably will be a v11, but wanted to know how this series will be
>>>>> handled as it involves device tree bindings, arm arch device tree spec, and
>>>>> brcmfmac driver code. Can it all go through wireless-next?
>>>>
>>>> No, DTS must not go via wireless-next. Please split it from the series
>>>> and provide lore link in changelog for bindings.
>>>
>>> Hi Krzysztof,
>>>
>>> Is it really important how the patches travel upstream to Linus. This
>>> binding is specific to Broadcom wifi devices so there are no
>>> dependencies(?). To clarify what you are asking I assume two separate
>>> series:
>>>
>>> 1) DT binding + Khadas Edge2 DTS  -> devicetree@vger.kernel.org
>>> 	reference to:
>>> https://patch.msgid.link/20240813082007.2625841-1-jacobe.zang@wesion.com
>>>
>>> 2) brcmfmac driver changes	  -> linux-wireless@vger.kernel.org
>>
>> No. I said only DTS is separate. This was always the rule, since forever.
>>
>> Documentation/devicetree/bindings/submitting-patches.rst
> 
> I am going slightly mad (by Queen). That documents says:
> 
>    1) The Documentation/ and include/dt-bindings/ portion of the patch 
> should
>       be a separate patch.
> 
> and
> 
>    4) Submit the entire series to the devicetree mailinglist at
> 
>         devicetree@vger.kernel.org
> 
> Above I mentioned "series", not "patch". So 1) is a series of 3 patches 
> (2 changes to the DT binding file and 1 patch for the Khadas Edge2 DTS. 
> Is that correct?
> 

My bookmark to elixir.bootling does not work, so could not paste
specific line. Now it works, so:

https://elixir.bootlin.com/linux/v6.11-rc3/source/Documentation/devicetree/bindings/submitting-patches.rst#L79

The rule was/is:
1. Binding for typical devices always go via subsystem tree, with the
driver changes.
There can be exceptions from above, e.g. some subsystems do not pick up
bindings, so Rob does. But how patches are organized is not an exception
- it is completely normal workflow.

2. DTS *always* goes via SoC maintainer. DTS cannot go via any other
driver subsystem tree. There is no exception here. There cannot be an
exception, because it would mean the hardware depends on driver, which
is obviously false.

Best regards,
Krzysztof


