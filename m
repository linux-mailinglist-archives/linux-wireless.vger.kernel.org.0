Return-Path: <linux-wireless+bounces-11432-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7BD951CA2
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 16:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B32D1C216BD
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 14:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C5D1B29DB;
	Wed, 14 Aug 2024 14:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MOKlONNL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABC51B29C2
	for <linux-wireless@vger.kernel.org>; Wed, 14 Aug 2024 14:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723644535; cv=none; b=morr9dda9mGzTI6aqWuQY69U7rsVWJk4gcBIk5sMT8i+Er5V6EPb4zUqfSg0CWcc6lU31zeaGlvFcCXkGMrL/Oj1Zq4WyMmXqG/xfFcjqeexUtpOHE2WoiyM0n0qGBGyL8qZ7oulSwgQV6wcPhzANFgCts5qFu/dYy7Bmni2juc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723644535; c=relaxed/simple;
	bh=gkysqq+eLkCi72KkUF3mmkTlr9D3RYFJHiqsDd5o8oo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RvTz4B4jb8ZzAj9nGWID3DnEsybjhMJhueEX1dtRy8JSohOkb5BhOB/8vYf9+ue8T3j62vtJCIfk9uvM1WN5AV5hrS1R+NtAyfpLMmQuxUuUDfglovbGXCqE34Yh80epRmCSIyxKnWR9cNx46IXFNzByLvjK1lX0fO+NKrTJxP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MOKlONNL; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-368313809a4so559971f8f.0
        for <linux-wireless@vger.kernel.org>; Wed, 14 Aug 2024 07:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723644532; x=1724249332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=N82Nc2+gY4/+lTNM9bo2pmanPWXfOJy6ZWbbOExaRpU=;
        b=MOKlONNLCgOrJnkneGdvJ78/SfBYYus3A9BHGVscm53nbV9zHatVGCFE+8O7ExP/h4
         1VrJz1m+gKGlCoGxaWQZcSKK17JGJOSa8ayd059gkNqo8db4bcZAZw1TrXAPzBlLeEB7
         eCVg2qXmstPYvKWDXwrXNoYF42WTcnqEsQy5fgFlwnY/xGk203PVZ2nH0X0OYPMwLmO9
         K7oRjXI3rHbrCqTq3mhKW6pYqHYjwDPaFl7GrCr4OVACqXHeKo3ATziHrZI/qwqKwUGj
         h9WUdNKA3FcBMtERY3MZIFLWo91yBBBODrM1nCHUi3b7tEa4sNseMuKUC6aqp63SihDL
         5Bew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723644532; x=1724249332;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N82Nc2+gY4/+lTNM9bo2pmanPWXfOJy6ZWbbOExaRpU=;
        b=SZZzG601n2BrosMvUeX+/x7DnnQtO85PYsJclOeXHn+D+Eb8jKLgGZFXDIfVmKIfO1
         TR2shqAT+ghcuTX7sVu5RUrK/BWpb8tg+socxFuleJmbKRXuK8SIe1G/+Fe5mrOv93v3
         sUS2SJ2wcA98u+hkMb/m25FOagIVSTC5HJ9FV72yYfaQraFduU2SKJYB8hbLqwiiWkV7
         xvdgwqNYxREs8aknj2sQz9Bxp23MHhf+pBQRo8zx4bIDEYy5L+7jUUQsS2CtfXw++l2M
         7oRLTQM9EnJiiKRfqbujCrT2wSfrTPPUT/7UJ1rdK3RCeNtjjUJBYPQfL2bah9jG6Sld
         RspQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJg5zAuteeudH13BokJxQNwDpieGsR4N7VYPPlY6+79BbCXk6IImR5wT9PxhbxUh3S29IUv83R0tx71byhvn3xLqHmgqw1VLgCMw175VE=
X-Gm-Message-State: AOJu0Ywu7Ky6NHVCUIfLEXHV9EltGqvUz9PFfbn2KxLa1pyG/pDaDlS+
	hMyEuBLQXBM4aqii/b332bDUvgGbW//3E1yGPgUfvIKVEnWGLALL1IeVgslZhDQ=
X-Google-Smtp-Source: AGHT+IGDqgiodX5asQzw8Eqc0zS1NjySybHtSTj+w8HqPC6KzCZ1oRb7Ab3PGuHo2p4wURp/PaZg9Q==
X-Received: by 2002:a5d:4530:0:b0:360:8c88:ab82 with SMTP id ffacd0b85a97d-371796a10b9mr1591919f8f.30.1723644532127;
        Wed, 14 Aug 2024 07:08:52 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4cfefa29sm12945847f8f.61.2024.08.14.07.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 07:08:51 -0700 (PDT)
Message-ID: <f504a3e7-cb18-41ce-a76d-267d464b6b05@linaro.org>
Date: Wed, 14 Aug 2024 16:08:49 +0200
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
 <df52a968-96be-4f05-8d6f-32a2abde1d91@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <df52a968-96be-4f05-8d6f-32a2abde1d91@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/08/2024 13:15, Krzysztof Kozlowski wrote:
> On 14/08/2024 12:59, Arend van Spriel wrote:
>> On 8/14/2024 12:39 PM, Krzysztof Kozlowski wrote:
>>> On 14/08/2024 12:08, Arend van Spriel wrote:
>>>> On 8/14/2024 10:53 AM, Krzysztof Kozlowski wrote:
>>>>> On 13/08/2024 19:04, Arend Van Spriel wrote:
>>>>>> On August 13, 2024 10:20:24 AM Jacobe Zang <jacobe.zang@wesion.com> wrote:
>>>>>>
>>>>>>> It's the device id used by AP6275P which is the Wi-Fi module
>>>>>>> used by Rockchip's RK3588 evaluation board and also used in
>>>>>>> some other RK3588 boards.
>>>>>>
>>>>>> Hi Kalle,
>>>>>>
>>>>>> There probably will be a v11, but wanted to know how this series will be
>>>>>> handled as it involves device tree bindings, arm arch device tree spec, and
>>>>>> brcmfmac driver code. Can it all go through wireless-next?
>>>>>
>>>>> No, DTS must not go via wireless-next. Please split it from the series
>>>>> and provide lore link in changelog for bindings.
>>>>
>>>> Hi Krzysztof,
>>>>
>>>> Is it really important how the patches travel upstream to Linus. This
>>>> binding is specific to Broadcom wifi devices so there are no
>>>> dependencies(?). To clarify what you are asking I assume two separate
>>>> series:
>>>>
>>>> 1) DT binding + Khadas Edge2 DTS  -> devicetree@vger.kernel.org
>>>> 	reference to:
>>>> https://patch.msgid.link/20240813082007.2625841-1-jacobe.zang@wesion.com
>>>>
>>>> 2) brcmfmac driver changes	  -> linux-wireless@vger.kernel.org
>>>
>>> No. I said only DTS is separate. This was always the rule, since forever.
>>>
>>> Documentation/devicetree/bindings/submitting-patches.rst
>>
>> I am going slightly mad (by Queen). That documents says:
>>
>>    1) The Documentation/ and include/dt-bindings/ portion of the patch 
>> should
>>       be a separate patch.
>>
>> and
>>
>>    4) Submit the entire series to the devicetree mailinglist at
>>
>>         devicetree@vger.kernel.org
>>
>> Above I mentioned "series", not "patch". So 1) is a series of 3 patches 
>> (2 changes to the DT binding file and 1 patch for the Khadas Edge2 DTS. 
>> Is that correct?
>>
> 
> My bookmark to elixir.bootling does not work, so could not paste
> specific line. Now it works, so:
> 
> https://elixir.bootlin.com/linux/v6.11-rc3/source/Documentation/devicetree/bindings/submitting-patches.rst#L79
> 
> The rule was/is:
> 1. Binding for typical devices always go via subsystem tree, with the
> driver changes.
> There can be exceptions from above, e.g. some subsystems do not pick up
> bindings, so Rob does. But how patches are organized is not an exception
> - it is completely normal workflow.
> 
> 2. DTS *always* goes via SoC maintainer. DTS cannot go via any other
> driver subsystem tree. There is no exception here. There cannot be an
> exception, because it would mean the hardware depends on driver, which
> is obviously false.

In case my message was not clear: we talk here about organizing
patchsets, not individual patches. If you ask about patches, then DTS,
bindings and driver are all separate patches. This set already is split
like that, so this was fine and I did not comment on it. Only through
whom the DTS patch goes - separate tree.

And just in case: this is neither specific to wireless nor to Broadcom.
This is for entire Linux kernel.

Best regards,
Krzysztof


