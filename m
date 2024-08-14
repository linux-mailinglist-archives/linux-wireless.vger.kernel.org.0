Return-Path: <linux-wireless+bounces-11428-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1351A951943
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 12:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 900441F26672
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 10:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA671AE854;
	Wed, 14 Aug 2024 10:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QgBiCUtp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3727E1AE05F
	for <linux-wireless@vger.kernel.org>; Wed, 14 Aug 2024 10:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723632309; cv=none; b=gu6EtV5+N8oi3KJEhr4JQEXJtrcxs2ljVRQCVKJ/EtOe5HAKTjsOud89J3Ng+b5BtRztPL2TgpTqJoJhvuF/Z6pHsbXi8MabwiTNsiMewt+2pIkwOQTiN1uKkrUerB5f90ZiAbtASeSVANFvnnTkH3Q3E6Vhhf9332G18cX6xOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723632309; c=relaxed/simple;
	bh=cZ9BkgG63rEN8kNe9FhooxE8MhReOnBZMnAbDlarQAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O8G3YfZoYeERJt6ItXBLPXYei1F8/RppTDNGt2FsHS0kA9ChTremMB0qvLMB8W4yVoM4y29REscrdHyHghZAsukdg0ybCVrtpF9q/GroE1nxSxDuQQnH5EKN2hwKTAQwrmWppAxrYNd/Ocr3rs8HWzKziDUtA/zhplqtqLuMXJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QgBiCUtp; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6b79fc76d03so36859116d6.1
        for <linux-wireless@vger.kernel.org>; Wed, 14 Aug 2024 03:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723632305; x=1724237105; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LFk4lh3cCjG0SR06SvOvwiuhTMezfgXvWpzfkPomYos=;
        b=QgBiCUtpXay0ZhB65ngHKiBM74LRtmQEDxXXIn2/XXjq0QggV11C+PHdes5yT0WZII
         1UU4rqBRDAfKfcKR6LgFstRXi+v80/a+9EaCzbiSEsGqLuhT5OrdJjPCjOEw73cYOOeL
         J2UqsUf0nRPwQhDRuL6TLvQZNbVdaf2SzV268=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723632305; x=1724237105;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFk4lh3cCjG0SR06SvOvwiuhTMezfgXvWpzfkPomYos=;
        b=O3WWs+5xRU1rGIsDw33egVv7w8UT2TD+jrm41SFa8IdOAaFLHnM+VdrzY/oMU5C2Es
         lbbg1N90tZ9ZdUs/2Qzg/YF0hG6TGdmrKMMREQm7rfQuBQGtxCyc0T/4zC19RuNipGnv
         IDcrgwc8d87Yg9lmCXM5C+aYIL5ymnRNiFlVUJ94Z8Sb0ZrpE7QLsTJK6hD2dk9iOsXY
         tYE8lJUT15xcjv2/jHi3xHO0u8PKlHu8y2wLF903pE0qw0GQAYLY9B6kUmbsDaTKqNh+
         9L6c1P00VHdhfG8VM8zmPCU5FUJzxjHRvNSnOeRR/ZEmdt+d0z0fIT8hzQ+GPQyaQyOR
         bhhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGMuXv8S0Gl79TuGpZKmthkcrBlI7qXMV+F4ZGNygP2ipF2Qq2qw0XWN59/rN7yC4shW0YHXBfcra3T5B5yQzYQRX8rkI3whrSbNJ6KNA=
X-Gm-Message-State: AOJu0YxRChLHyw9Wm/cuftMu6D8p6FplDxLP4j+X4EQsabChi+J4cTna
	b8eTOI57LUS8hc2ZzyQ9nkOBWIi+vciW/jJqUQOdH0MeK+i5GvGEsK6kokO+BQ==
X-Google-Smtp-Source: AGHT+IGINV7Cr6/yUzciRzHq2zhc1Ek5UNVW7N0rj9HFgKO7ExivX+a6umTbzKbdjzFu5OuVUGXsyg==
X-Received: by 2002:a0c:f7ce:0:b0:6bf:6714:43b3 with SMTP id 6a1803df08f44-6bf6714448emr2393696d6.21.1723632304908;
        Wed, 14 Aug 2024 03:45:04 -0700 (PDT)
Received: from [10.176.68.61] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82c87843sm42263316d6.31.2024.08.14.03.45.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 03:45:04 -0700 (PDT)
Message-ID: <8de856d4-8526-4662-bb29-898b80476df9@broadcom.com>
Date: Wed, 14 Aug 2024 12:44:58 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 4/5] wifi: brcmfmac: Add optional lpo clock enable
 support
To: Alexey Charkov <alchark@gmail.com>, Jacobe Zang <jacobe.zang@wesion.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, heiko@sntech.de, kvalo@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, conor+dt@kernel.org, linux-rockchip@lists.infradead.org,
 efectn@protonmail.com, dsimic@manjaro.org, jagan@edgeble.ai,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, arend@broadcom.com,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org, megi@xff.cz,
 duoming@zju.edu.cn, bhelgaas@google.com, minipli@grsecurity.net,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 nick@khadas.com, Sai Krishna <saikrishnag@marvell.com>
References: <20240813082007.2625841-1-jacobe.zang@wesion.com>
 <20240813082007.2625841-5-jacobe.zang@wesion.com>
 <721da64c-42ec-4be6-8ad3-e2685a84823a@broadcom.com>
 <2269063.vFx2qVVIhK@latitude-fedora>
 <fa019ee9-3f4d-4bea-92a7-929713518dc9@wesion.com>
 <CABjd4YwTbG8pm_xwrOVtVwMwvarvz2SB9bapH3LDMqPn6pH9Ew@mail.gmail.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <CABjd4YwTbG8pm_xwrOVtVwMwvarvz2SB9bapH3LDMqPn6pH9Ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/14/2024 11:48 AM, Alexey Charkov wrote:
> On Wed, Aug 14, 2024 at 12:27 PM Jacobe Zang <jacobe.zang@wesion.com> wrote:
>>
>>
>>
>> On 2024/8/14 16:47, Alexey Charkov wrote:
>>> Hi Arend, Jacobe,
>>>
>>> On Tuesday, August 13, 2024 2:57:28 PM GMT+3 Arend van Spriel wrote:
>>>> On 8/13/2024 10:20 AM, Jacobe Zang wrote:
>>>>> WiFi modules often require 32kHz clock to function. Add support to
>>>>> enable the clock to PCIe driver and move "brcm,bcm4329-fmac" check
>>>>> to the top of brcmf_of_probe. Change function prototypes from void
>>>>> to int and add appropriate errno's for return values that will be
>>>>> send to bus when error occurred.
>>>>
>>>> I was going to say it looks good to me, but....
>>>>
>>>>> Co-developed-by: Ondrej Jirman <megi@xff.cz>
>>>>> Signed-off-by: Ondrej Jirman <megi@xff.cz>
>>>>> Co-developed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>>>>> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>>>>> Reviewed-by: Sai Krishna <saikrishnag@marvell.com>
>>>>> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
>>>>> ---
>>>>>
>>>>>     .../broadcom/brcm80211/brcmfmac/bcmsdh.c      |  4 +-
>>>>>     .../broadcom/brcm80211/brcmfmac/common.c      |  3 +-
>>>>>     .../wireless/broadcom/brcm80211/brcmfmac/of.c | 53 +++++++++++--------
>>>>>     .../wireless/broadcom/brcm80211/brcmfmac/of.h |  9 ++--
>>>>>     .../broadcom/brcm80211/brcmfmac/pcie.c        |  3 ++
>>>>>     .../broadcom/brcm80211/brcmfmac/sdio.c        | 22 +++++---
>>>>>     .../broadcom/brcm80211/brcmfmac/usb.c         |  3 ++
>>>>>     7 files changed, 61 insertions(+), 36 deletions(-)
>>>>
>>>> [...]
>>>>
>>>>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
>>>>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c index
>>>>> e406e11481a62..f19dc7355e0e8 100644
>>>>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
>>>>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
>>>>
>>>> [...]
>>>>
>>>>> @@ -113,33 +118,39 @@ void brcmf_of_probe(struct device *dev, enum
>>>>> brcmf_bus_type bus_type,>
>>>>>              of_node_put(root);
>>>>>
>>>>>      }
>>>>>
>>>>> -   if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac"))
>>>>> -           return;
>>>>> -
>>>>>
>>>>>      err = brcmf_of_get_country_codes(dev, settings);
>>>>>      if (err)
>>>>>
>>>>>              brcmf_err("failed to get OF country code map (err=%d)
>>> \n", err);
>>>>>
>>>>>      of_get_mac_address(np, settings->mac);
>>>>>
>>>>> -   if (bus_type != BRCMF_BUSTYPE_SDIO)
>>>>> -           return;
>>>>> +   if (bus_type == BRCMF_BUSTYPE_SDIO) {
>>>>
>>>> Don't like the fact that this now has an extra indentation level and it
>>>> offers no extra benefit. Just keep the original if-statement and return
>>>> 0. Consequently the LPO clock code should move just before the if-statement.
>>>>> +           if (of_property_read_u32(np, "brcm,drive-strength",
>>> &val) == 0)
>>>>> +                   sdio->drive_strength = val;
>>>>>
>>>>> -   if (of_property_read_u32(np, "brcm,drive-strength", &val) == 0)
>>>>> -           sdio->drive_strength = val;
>>>>> +           /* make sure there are interrupts defined in the node */
>>>>> +           if (!of_property_present(np, "interrupts"))
>>>>> +                   return 0;
>>>>>
>>>>> -   /* make sure there are interrupts defined in the node */
>>>>> -   if (!of_property_present(np, "interrupts"))
>>>>> -           return;
>>>>> +           irq = irq_of_parse_and_map(np, 0);
>>>>> +           if (!irq) {
>>>>> +                   brcmf_err("interrupt could not be
>>> mapped\n");
>>>>> +                   return 0;
>>>>> +           }
>>>>> +           irqf = irqd_get_trigger_type(irq_get_irq_data(irq));
>>>>> +
>>>>> +           sdio->oob_irq_supported = true;
>>>>> +           sdio->oob_irq_nr = irq;
>>>>> +           sdio->oob_irq_flags = irqf;
>>>>> +   }
>>>>>
>>>>> -   irq = irq_of_parse_and_map(np, 0);
>>>>> -   if (!irq) {
>>>>> -           brcmf_err("interrupt could not be mapped\n");
>>>>> -           return;
>>>>> +   clk = devm_clk_get_optional_enabled(dev, "lpo");
>>>>> +   if (!IS_ERR_OR_NULL(clk)) {
>>>>> +           brcmf_dbg(INFO, "enabling 32kHz clock\n");
>>>>> +           return clk_set_rate(clk, 32768);
>>>>> +   } else {
>>>>> +           return PTR_ERR_OR_ZERO(clk);
>>>>>
>>>>>      }
>>>>
>>>> Change this to:
>>>>    > +        clk = devm_clk_get_optional_enabled(dev, "lpo");
>>>>    > +        if (IS_ERR_OR_NULL(clk)) {
>>>>    > +                return PTR_ERR_OR_ZERO(clk);
>>>
>>> Perhaps in this case we should go for IS_ERR and PTR_ERR respectively.
>>> devm_clk_get_optional_enabled would return NULL when the optional clock is not
>>> found, so NULL is not an error state but serves as a dummy clock that can be> used with clk_set_rate.
>>
>> I think we don't need to set clock rate for clock is NULL. So it should
>> be changed to:
>>
>> +       clk = devm_clk_get_optional_enabled(dev, "lpo");
>> +       if (IS_ERR(clk)) {
>> +               return PTR_ERR(clk);
>> +       } else if (clk) {
>> +               brcmf_dbg(INFO, "enabling 32kHz clock\n");
>> +               clk_set_rate(clk, 32768);
>> +       }
> 
> If clk is NULL then clk_set_rate returns immediately with status zero,
> so there is little difference from whether you wrap it into another if
> (clk) or not. You can probably drop the debug statement altogether and
> call clk_set_rate unconditionally - this will look neater.

The construct above is indeed only needed to get the debug statement 
correct given the behavior of clk_set_rate(). However, for debugging it 
is useful to know that the LPO clock is defined and used or not. Maybe 
do this:

        clk = devm_clk_get_optional_enabled(dev, "lpo");
        if (IS_ERR(clk))
                return PTR_ERR(clk);

        brcmf_dbg(INFO, "%s LPO clock\n", clk ? "enable" : "no");
        clk_set_rate(clk, 32768);

Regards,
Arend

