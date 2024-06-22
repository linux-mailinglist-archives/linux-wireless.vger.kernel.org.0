Return-Path: <linux-wireless+bounces-9458-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAB2913613
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Jun 2024 22:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCECB1F22EE6
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Jun 2024 20:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99F35CDF0;
	Sat, 22 Jun 2024 20:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgkMXqIX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D47316419;
	Sat, 22 Jun 2024 20:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719089853; cv=none; b=epBtZNGmSN8HYLzwF2zhALufrofwQ3xZELbAiT8Tgu9zi06UedyAl84RH97wj1UTHFqR9Q6ZdKfdqmAYS+ba2ExK5WS6iWITE8TEd1gufN20xhndRyrHSdCLq778v2VXg9DInOD8MhFDMnC6hPce8lCGUWSB+fVu/mk1r8FDFno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719089853; c=relaxed/simple;
	bh=eUnPmrc5D8ZkLz919iwpd8FUpywsWQUxj3eJWqTRVkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=P/AOdLhPfiJo+Os35ZrSfekyeQ++NEjDjUem7wMQ1DhMGdtuLW9R0GmEsqtHimoQGAoPWwJrh2Oe2sD52mmarGMoirzRfBXlikJW5x9SVKPa3JvpCxblaxwyw+cmJxam/uMFb6gMrJpb+y+pxNIJ6GfyxJ9+W79XJDEioCs25i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgkMXqIX; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57d457357easo532431a12.3;
        Sat, 22 Jun 2024 13:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719089850; x=1719694650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tDuouZW9wT93zAqYjaMqCHOs9/kAyeb6T4KmmMAcbBg=;
        b=XgkMXqIXFW2s/t9tGnWolYNdscJnB0QZH9zI2TER0ORGR6HUnj5Ajbxhq5+905znV5
         up8/2NZy6mTFn5Byym0bzCKMlOrcsEaZFDoXvgvS5R+IOvvWLEc3VO/Xs+8HY/fLAlf5
         0w3kNAFD64WL7b93bvnf3ceBXJrOIzG5QwT9l4HtTszlJ5yimoFgQsedF7PVeqbQP3Ah
         OluXXZugf8pSCiDZTa5RvgIWJOlNM1oHznSysl/xYkPcAa8rL3kOktkcpgmsD0D0wBEN
         OuWob7czjs/fWDLrrj+TQu5Jju6OhIvQB1hJWWkUsx9YDcIrn5kno1GO0e6EbUdpubY4
         dI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719089850; x=1719694650;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tDuouZW9wT93zAqYjaMqCHOs9/kAyeb6T4KmmMAcbBg=;
        b=OvpRZZDXtCsp4SOJxlxrAfYLv60lWIcieNwGA50O4WFgaZ2sK+BAdFeOszZT6+4QLL
         nMnrvzEJblyw2wngnC2pVoIGd+AnNaGlcGYOWJ4x5EYNKbq/MrDNJ8WAwbtEfcLTzV9C
         Nk6TY6UiVGYH4bJLJHG2ikjy/DIDMErQ+eIzT1jezL14p/PMON9ErF2cIrSTIj6quJow
         keQxTwVlFIkQf0Ul/rH3A7sSjxFCEz1U38AARcib52kdTkNltDHuc83zPpUf6xByk2YW
         tyAXOvmqt9o93KZx7ydufdGS3mUT22LRINqvIUQL2lg10JzuB0/cv0oDmK9mEgyMqqtJ
         G1iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWotuW6rWOKRzv83Ec94zH2zftMxObeopP94+L6dpx364uW/DAWO9K7K+fYiXfYIj3iU55MO7/iLdKyeEtl1H6pfeKK7pvtQeYhRu/z6b0PZ8jIjWKt6rxLicZTp4TKYJx/cvH8tsUHUPMfxoo=
X-Gm-Message-State: AOJu0YysL7OIMzbQZ2fk87ZW2pSvRn+Ga2AQeqAvGwjubRhwecEwtjUm
	4C3sj79kMJJt3zZswNLVBzdU9pNpmUZ2lyD4jEWNbDOv1jzgtV4=
X-Google-Smtp-Source: AGHT+IE8pWzEn3GYGJmVaQOhWZnN4MyxbNOiMYpmw4jr1uhP8B0tULVgmQ43KQ9QX4yiRyTUOyLFxw==
X-Received: by 2002:a50:ccc8:0:b0:57c:5fc8:c95d with SMTP id 4fb4d7f45d1cf-57d4bd720cfmr520591a12.18.1719089849669;
        Sat, 22 Jun 2024 13:57:29 -0700 (PDT)
Received: from ?IPV6:2a02:810b:f40:4600:108d:ce41:c0b8:26cd? ([2a02:810b:f40:4600:108d:ce41:c0b8:26cd])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d3042d8b1sm2760722a12.45.2024.06.22.13.57.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jun 2024 13:57:29 -0700 (PDT)
Message-ID: <d17fe45e-3cf6-40cb-a2a7-b690d7b7056d@gmail.com>
Date: Sat, 22 Jun 2024 22:57:28 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmfmac: of: Support interrupts-extended
To: Arend Van Spriel <arend.vanspriel@broadcom.com>,
 Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-kernel@vger.kernel.org
References: <20240621225558.280462-1-knaerzche@gmail.com>
 <190402b87a8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <19040354ba8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <f81489b4-ed60-43df-826a-1f9593802be8@gmail.com>
 <190410e7d38.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Content-Language: en-US
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <190410e7d38.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Am 22.06.24 um 19:46 schrieb Arend Van Spriel:
> On June 22, 2024 4:07:40 PM Alex Bee <knaerzche@gmail.com> wrote:
>
>> Am 22.06.24 um 15:49 schrieb Arend Van Spriel:
>>> On June 22, 2024 3:38:32 PM Arend Van Spriel
>>> <arend.vanspriel@broadcom.com> wrote:
>>>
>>>> On June 22, 2024 12:56:02 AM Alex Bee <knaerzche@gmail.com> wrote:
>>>>
>>>>> This "new" version of defining external interrupts is around for a 
>>>>> very
>>>>> long time now and supported and preferred by irq_of_parse_and_map
>>>>> respectively of_irq_parse_one.
>>>>>
>>>>> Support it in brcmfmac as well by checking if either "interrupts" or
>>>>> "interrupts-extended" property exists as indication if
>>>>> irq_of_parse_and_map
>>>>> should be called.
>>>>
>>>> All very interesting, but why should we add code for something that
>>>> is not
>>>> specified in the bindings documentation?
>>>>
>>>> NAK (for now). Feel free to update the bindings document.
>> Sure, if you insist on it, I can update the bindings document. So far 
>> not
>> many (no) users did that, as it is clearly specified as an 
>> alternative in
>> devicetree/bindings/interrupt-controller/interrupts.txt (sure, it's 
>> not yet
>> converted to yaml yet).
>
> Right. So in my opinion that should be handled by the interrupt 
> subsystem. Hence I dived into irq_of_parse_and_map(). I would suggest 
> to open code that:
>
And as you can see: It's already handled by the interrupt subsystem - all
what prevents it from working in it's intended behavior is this strange
of_property_present check.
> /* make sure there are interrupts defined in the node */
> - if (!of_property_present(np, "interrupts"))
> + if (of_irq_parse_one(...))
>  return;
>
Agreed. That's even better - I also didn't fully understand why this
of_property_present was chosen in the first place. Actually I wanted to
send something similar first with only calling of_irq_parse_one and return
early if it fails, but the result doesn't allow to differentiate between
"no interrupt defined" and "interrupt mapping failed" - so open coding it
seems required, unfortunately..
> irq = irq_create_of_mapping(...);
>
>> Which is a much nicer form, imho.
>> And by the way for instance
>> arch/arm/boot/dts/qcom/qcom-apq8026-lg-lenok.dts already uses it that 
>> way
>> and the interrupt will currently not picked up (at least not by this
>> driver).
>
> I expected the "nicer" argument would be thrown in at some point. 
> Esthetics are never a technical argument, but let's not debate that 
> ;-) Hopefully you can agree with my suggestion.
>
I wouldn't want the 'nicer'-argument to be an argument, as I don't like
that either: so sorry for that. My point was: Why wouldn’t we support it
in brcmfmac also?

So will resend with you suggestion applied: Remove !of_property_present
check completely and do the two steps of_irq_parse_one and
irq_create_of_mapping separately.

Alex

> Regards,
> Arend
>
>

