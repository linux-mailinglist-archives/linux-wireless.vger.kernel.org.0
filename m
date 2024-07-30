Return-Path: <linux-wireless+bounces-10677-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24600940EA3
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 12:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96A00B231BF
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 10:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EE1197A66;
	Tue, 30 Jul 2024 10:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PQpTmfjT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DF9194ACA
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jul 2024 10:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722334113; cv=none; b=YOh/V7uzQSbphSS2hqRurz/kD6AqKM0bI4PMee/iev1UZZe88cfgA30Tkt+CkI+mpBrm0VYgBgDV1xXy0rGBk5MqR3580U2TIgNjnEc7OZDnQn2ypWZg4KK35Fv/hZLPAyPgGgPXQnkhCWs+g4VM9mz7UhCum5jFnoK52B9RPBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722334113; c=relaxed/simple;
	bh=RnWCz84PVjtWkbkwbunfz/EotkXeNNxFhFHG+6twB7Q=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=BMMNXMZ6NmHCpbzdLH4WJ7zeIEv02IDjPOXuP9Bf62Z7aAI08EIrlWKKPYRJPrKJlIbwfPeNcjBz/A3YAL6D7VfQXJ1mMf+NyjeaZnv6VpqfAA8+Z1MFLMbr0pE9q4kpvFFz76Mt0ebweSXturH7DCdMFrPsCvE9fglURR9IPVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PQpTmfjT; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70d18112b60so3076051b3a.1
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jul 2024 03:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722334111; x=1722938911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=it0G31C3nK4iT57/TuCykaOG5f+2KUhsEgQE63zlvQ8=;
        b=PQpTmfjTzCmEF7EbHiq6uxU1mWdmHpROX1MM9QkmV5hT1WbnF/ybwwjG6qVCNW/GeH
         141Y/xA/WgrZf8eZV1yUWYqoJNkjyMuyCwpoN//+/qkCoCDsHlD3FlS87kncBuF35dqf
         ymw3/+ySbj9OVC2VnuXq1nPF0R2OmdcXwP+ls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722334111; x=1722938911;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=it0G31C3nK4iT57/TuCykaOG5f+2KUhsEgQE63zlvQ8=;
        b=aIjjNzuKPIEQvsYCmPRkFA7SfFYnYtP+pydBeBraYrbGFpnF7SXroytxMaJP8/I2ol
         MhGvLGHfqxM/OPx6BdZTP/zGDxaZBfMvzpv1GbR56mXj8lSSAxMTI/umNW7+yfHJuiId
         qFFLXOlxj1i+9FUYCxbF7u2nW+sFeCy5KpntKSzC6lzg4sfOM6PXIBdou2/KtKGoNREM
         N5A2Snctc3aMshX3uEj3Z+/5VOSbq+p3Ps3/SWTtzT22opQdEtdOgQANY8+pOfBs+D4A
         MtqAsXGxlF0Z5e7+pcCCdp+eD4XTYeaDQXKWbsgaPzIiCZ++KFyc14/TnYguheqkifOp
         urNw==
X-Forwarded-Encrypted: i=1; AJvYcCV/zNmO0JZYluVfFoFsZ/9YCSNsfAtsalp4Gd+sSyuS9V/SWGyIO5ggxerevUUEHqak6JG4vdKjXFt0n2xDaHtopkCYrThMCrTM9dHTlUM=
X-Gm-Message-State: AOJu0Yw0hT5u5M1Kl2a+HTjEokpSoP2ncFdvSttOWiquMVdQDYEmCPrr
	bumYJm5nPAfyLEqBWB4MM2yNW4y0jLONGC6m9wogf8S9VJ9bOUGj6mZlaeiEbg==
X-Google-Smtp-Source: AGHT+IGshW2OzxRzfxWGvcbO0sAFmjyAkWIraUtC7GDL6IIXZLZQRc2Ic/SOA1XlSk6flzreTwMvTw==
X-Received: by 2002:a05:6a00:3e22:b0:70b:5368:a212 with SMTP id d2e1a72fcca58-70efe49ddcbmr2198191b3a.15.1722334110893;
        Tue, 30 Jul 2024 03:08:30 -0700 (PDT)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead6e33e2sm8106343b3a.28.2024.07.30.03.08.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2024 03:08:30 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Jacobe Zang <jacobe.zang@wesion.com>, Krzysztof Kozlowski <krzk@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>, <heiko@sntech.de>, <kvalo@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>, <conor+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>
CC: <efectn@protonmail.com>, <dsimic@manjaro.org>, <jagan@edgeble.ai>, <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>, <arend@broadcom.com>, <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>, <megi@xff.cz>, <duoming@zju.edu.cn>, <bhelgaas@google.com>, <minipli@grsecurity.net>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, Nick Xie <nick@khadas.com>
Date: Tue, 30 Jul 2024 12:08:19 +0200
Message-ID: <191031cb638.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <TYZPR03MB7001AA581B8B63AC19A7977C80B02@TYZPR03MB7001.apcprd03.prod.outlook.com>
References: <20240730033053.4092132-1-jacobe.zang@wesion.com>
 <20240730033053.4092132-3-jacobe.zang@wesion.com>
 <191025b5268.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <f45c1fa7-f321-4a1f-b65c-6ed326a18268@kernel.org>
 <191030eac78.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <TYZPR03MB7001AA581B8B63AC19A7977C80B02@TYZPR03MB7001.apcprd03.prod.outlook.com>
User-Agent: AquaMail/1.51.5 (build: 105105504)
Subject: Re: [PATCH v5 2/5] dt-bindings: net: wireless: brcm4329-fmac: add clock description for AP6275P
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On July 30, 2024 12:00:25 PM Jacobe Zang <jacobe.zang@wesion.com> wrote:

>>> On 30/07/2024 08:37, Arend Van Spriel wrote:
>>>> + Linus W
>>>>
>>>> On July 30, 2024 5:31:15 AM Jacobe Zang <jacobe.zang@wesion.com> wrote:
>>>>
>>>>> Not only AP6275P Wi-Fi device but also all Broadcom wireless devices allow
>>>>> external low power clock input. In DTS the clock as an optional choice in
>>>>> the absence of an internal clock.
>>>>>
>>>>> Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>>>>> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
>>>>> ---
>>>>> .../bindings/net/wireless/brcm,bcm4329-fmac.yaml          | 8 ++++++++
>>>>> 1 file changed, 8 insertions(+)
>>>>>
>>>>> diff --git
>>>>> a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
>>>>> b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
>>>>> index 2c2093c77ec9a..a3607d55ef367 100644
>>>>> --- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
>>>>> +++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
>>>>> @@ -122,6 +122,14 @@ properties:
>>>>> NVRAM. This would normally be filled in by the bootloader from platform
>>>>> configuration data.
>>>>>
>>>>> +  clocks:
>>>>> +    items:
>>>>> +      - description: External Low Power Clock input (32.768KHz)
>>>>> +
>>>>> +  clock-names:
>>>>> +    items:
>>>>> +      - const: lpo
>>>>> +
>>>>
>>>> We still have an issue that this clock input is also present in the
>>>> bindings specification broadcom-bluetooth.yaml (not in bluetooth
>>>> subfolder). This clock is actually a chip resource. What happens if both
>>>> are defined and both wifi and bt drivers try to enable this clock? Can this
>>>> be expressed in yaml or can we only put a textual warning in the property
>>>> descriptions?
>>>
>>> Just like all clocks, what would happen? It will be enabled.
>>
>> Oh, wow! Cool stuff. But seriously is it not a problem to have two entities
>> controlling one and the same clock? Is this use-case taken into account by
>> the clock framework?
>
> I have enabled the same clock both in bluetooth and wifi just now, they worked
> well. Maybe this make sense?

What happens if you unload one of the drivers? Also would like to know if 
you are using an nvram file. If so can you share it's content.

Regards,
Arend




