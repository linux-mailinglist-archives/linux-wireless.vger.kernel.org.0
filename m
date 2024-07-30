Return-Path: <linux-wireless+bounces-10682-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC13941057
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 13:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F8EF284765
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 11:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDCD19B3C4;
	Tue, 30 Jul 2024 11:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Nd+EfQ+w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F524195F3A
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jul 2024 11:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722338229; cv=none; b=UFONsUlJsWSv5I2x7VKgAQudQRjir9oHTjD6DozluxdPWOtmgAz92Hvrf6lQ5KTMSnPleSGLODCceAs2n9ZvrQyegDkkk6XphxgPIVvfALew2JBec9syWNqsdsJtehJMlUcYbynCuenXlm7In/LjIRwbmeIoVyQ4PsBlbIRTMl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722338229; c=relaxed/simple;
	bh=0c0bFjkp6lOGtIuddq5kJa8o0xZsFNb6mXA9glrX6aU=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ptqvrfy5Fu/opi0N+nqB3d5pspYhETfAwvYqCA5pPy+Yd4G2hJywuYRbpvpVu8NfXCqoanNch1YeIVe1O/Q1H7JZi5uy6PtHCHH+6i5dqoQAgl8UeZEcD6TmjjR9n5mQVu78aRfuGIg6qUuHdrveTOd79c+NY4MDwgwxH62/4IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Nd+EfQ+w; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70d18112b60so3117515b3a.1
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jul 2024 04:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722338227; x=1722943027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zMjbsaf9Qg0PIMOUCDvNeB4fJscDIysusSNb+GlHnFs=;
        b=Nd+EfQ+wIj9qw10KlWIT2v8R7MM1vJIS5xk08TZMHj2pkl0eLoEl0US5hFI9orFTta
         ZKMaaevAYeNzsm500qLWn8xShKGVzHYwsBBYXLfVyc9dRMhL7HO7BzlAlWESqeivzsVl
         3pRVfp1L1arNye74db56Fk4hFLzHr/yhjpf5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722338227; x=1722943027;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zMjbsaf9Qg0PIMOUCDvNeB4fJscDIysusSNb+GlHnFs=;
        b=tTxQXCZuurzBpAsjSK5nzj4zjv0YAYI9+8Ackx0Uhb13VLNx0EJ8jRHC4qAFPrUOVa
         og1NbgSrp/Za/855KsBbI1rCPPG9ZJoSjXdjmg2RJf8pWx5tIF8B24D99PSQu5g7fDOs
         7vmC/Sm21T0MEYdnk4d0Qb8wBGjn29cTcCp+pbMR2AeZLpaLXbZPBYatuhBPvEoknYPh
         JzHM0ZNq74IrX/g/968kTBUne1r8WjwaYCX48Hbz1IfTwRxJn6zrDOQcHIE+m+5uk5zL
         /0eutQrtR8fx1tj07FMICDgK9SPZdgYLHgHsRrvUAp1Bm83yPU0rFLpB9tJsodw6tCt1
         WlQw==
X-Forwarded-Encrypted: i=1; AJvYcCVi7pQazM1eh1aGASO/WmEwFJbNdnIFk7JejHhiB3af4QgLqWk2bQrBtFIOkKaKl3Wfrng16h4O7pKzCMEvyeAzB4uYUX7emjmGUqQpHPY=
X-Gm-Message-State: AOJu0YxpYS/IBfjVeX6UzWwA+MGz+0H90z9kXuI6NZ9mieutl+CfOdss
	d1LOzg0ZZ+CunDT8EspQgqxj3prAA5S11QUp14J8/DihBiKSq/zc6228Wkqb8g==
X-Google-Smtp-Source: AGHT+IH4GPuLW4JZ70pCnepe2Vow6yWK71i6a+LS+KmDte3yg0ALlYZIjJj1WsTlusgr/MqCrENMNw==
X-Received: by 2002:a05:6a20:7346:b0:1be:c41d:b6b7 with SMTP id adf61e73a8af0-1c4e47fb70fmr3042955637.19.1722338226714;
        Tue, 30 Jul 2024 04:17:06 -0700 (PDT)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead81272esm8462046b3a.97.2024.07.30.04.16.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2024 04:17:06 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Jacobe Zang <jacobe.zang@wesion.com>, <robh@kernel.org>, <krzk+dt@kernel.org>, <heiko@sntech.de>, <kvalo@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>, <conor+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>
CC: <efectn@protonmail.com>, <dsimic@manjaro.org>, <jagan@edgeble.ai>, <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>, <arend@broadcom.com>, <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>, <megi@xff.cz>, <duoming@zju.edu.cn>, <bhelgaas@google.com>, <minipli@grsecurity.net>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <nick@khadas.com>
Date: Tue, 30 Jul 2024 13:16:57 +0200
Message-ID: <191035b8c28.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <3d3b8e0a-7492-4db1-bd73-c30a488edaa7@kernel.org>
References: <20240730033053.4092132-1-jacobe.zang@wesion.com>
 <20240730033053.4092132-3-jacobe.zang@wesion.com>
 <191025b5268.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <f45c1fa7-f321-4a1f-b65c-6ed326a18268@kernel.org>
 <191030eac78.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <3d3b8e0a-7492-4db1-bd73-c30a488edaa7@kernel.org>
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

On July 30, 2024 12:18:20 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 30/07/2024 11:52, Arend Van Spriel wrote:
>> On July 30, 2024 11:01:43 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
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
> Yes, it is handled correctly. That's a basic use-case, handled by CCF
> since some years (~12?). Anyway, whatever OS is doing (or not doing)
> with the clocks is independent of the bindings here. The question is

Agree. Probably the bindings would not be the place to document this if it 
would be an issue.

> about hardware - does this node, which represents PCI interface of the
> chip, has/uses the clocks.

The schematics I found for the wifi module and the khadas edge platform 
show these are indeed wired to the chip.

Regards,
Arend

> Best regards,
> Krzysztof




