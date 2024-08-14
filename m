Return-Path: <linux-wireless+bounces-11440-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67058952057
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 18:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B02D1C20BB0
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 16:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200721BA86E;
	Wed, 14 Aug 2024 16:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="N24OdOki"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E7A1B9B43
	for <linux-wireless@vger.kernel.org>; Wed, 14 Aug 2024 16:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723654034; cv=none; b=Zu1lSpqfeQ9D/rW6S8IX1H0Bh2S1yBdSCeLqtV4B5CQYoorUK04QXrQOsM45zq8aEdJ+IcWwKOdn1wveB7xr5PIUx8fGuRtZI1GH33FnDCEPlmoaU6f85dtwXEGP2w5BJNC5UZ+3g5LaHY4JqOFkzUuVZqzvwvESq4GKyQ1O41I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723654034; c=relaxed/simple;
	bh=GTTdsljCHP48BKxOxQ6j1dEfFE2+NMQn7BEF6Jymyp0=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=tyqTSUVorq/Qr1LZfD62Vl66r8DhGC+LMNWbMyuu2SlkDsVmQEAa9Nszn46b2SOMuO2iDVPD4BgvhesW0qIr9P9T9Wohl4NbGGgvQDmAECxDTNBeh5omKXX9R2l3/DcGgq0SEMd8gmakD7isVl6JZn8GR3E1LEDzEJ2uDR6EWyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=N24OdOki; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a1d81dc0beso614985a.2
        for <linux-wireless@vger.kernel.org>; Wed, 14 Aug 2024 09:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723654031; x=1724258831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0LOkC2hr5mjD/XmAuAJdpJW2ttXWug85zZK1Co9ZjIE=;
        b=N24OdOkifX7HRQa5eXwZdZnM80f8nsictuYml8WBYV2E9mWUbxpB+lOY75Xi1eKaWS
         BXtozyFebq2M/Jo4GaJZVw/eCKKzoZ0e00tQ1AEYGJJSCl30ASnL9FvYVsfyoQtV7qTO
         LinKSGB4wjRH8U+DFnOVF7nBaJtX41sZjigb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723654031; x=1724258831;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0LOkC2hr5mjD/XmAuAJdpJW2ttXWug85zZK1Co9ZjIE=;
        b=f3VLmoAQSJ+LRc8CxJ4bAQKritgPwKr56Q0EldAnidIhTROvHXoNZ2D9KtnwmQnxJP
         dvIom0j+p9TTMtorAtrLhmNNiADu3x9juAIrwdIorS/sL3Wxcsdf3UsGSwgmIe8L6jM+
         JWIbH9qZup4G9prPW1gjV4aj1YxXiB+RuC+pJshCUtclIgq/pqfBRlY/IZnSvJvdA86e
         NL8Cl/jD9aHsBodvARaicdLjsUUuykS9cic1wPekNw5wXfreFezLhcO7uXFqUPfvtsuc
         oe3/7ARljMXt67BObx8X8+ZikalX1rIki6dHTtGfOzKcxzWDGuZ9UpfzYK5+8CfB43Dj
         d3Qg==
X-Forwarded-Encrypted: i=1; AJvYcCWdrKiTk5P93b+y8+EzWq7awqXNzOJMt6Wmfd0y4+seGl6B/rWT/iRdOZn4dEPRmBKjpI8zMvEO8QjtvGZRl0ZNsZ0DERq4oNt7HR7Hu8M=
X-Gm-Message-State: AOJu0YzERrGJK14mZLqx60PYnM9XLgiQB7c3whzN52UEyn6PRNVYdaIK
	LS7yQqIsSZCAsGGDDHmKnvbJ9cxK+vRjoUVSch86KE2HO1to+S118GXiArGTPw==
X-Google-Smtp-Source: AGHT+IHTM4N5IaCtzNPE7RF5w4uRXrZaZMciTBo9YGWGeU+4Fzw/BBwdcOTRcfKTQ2pPneokkJCaEA==
X-Received: by 2002:a05:620a:404b:b0:79f:12e9:1e71 with SMTP id af79cd13be357-7a4ee26d137mr414754385a.0.1723654031043;
        Wed, 14 Aug 2024 09:47:11 -0700 (PDT)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7d6494esm454743585a.2.2024.08.14.09.47.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2024 09:47:10 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Krzysztof Kozlowski <krzk@kernel.org>, Jacobe Zang <jacobe.zang@wesion.com>, <robh@kernel.org>, <krzk+dt@kernel.org>, <heiko@sntech.de>, <kvalo@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>, <conor+dt@kernel.org>
CC: <efectn@protonmail.com>, <dsimic@manjaro.org>, <jagan@edgeble.ai>, <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>, <arend@broadcom.com>, <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>, <megi@xff.cz>, <duoming@zju.edu.cn>, <bhelgaas@google.com>, <minipli@grsecurity.net>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <nick@khadas.com>
Date: Wed, 14 Aug 2024 18:47:04 +0200
Message-ID: <19151c92b40.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <f504a3e7-cb18-41ce-a76d-267d464b6b05@linaro.org>
References: <20240813082007.2625841-1-jacobe.zang@wesion.com>
 <20240813082007.2625841-2-jacobe.zang@wesion.com>
 <1914cb2b1a8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <e7401e25-7802-4dc3-9535-226f32b52be1@kernel.org>
 <062d8d4e-6d61-4f11-a9c0-1bbe1bfe0542@broadcom.com>
 <1e442710-a233-4ab2-a551-f28ba6394b5b@linaro.org>
 <180f7459-39fa-4e96-83d6-504e7802dc94@broadcom.com>
 <df52a968-96be-4f05-8d6f-32a2abde1d91@linaro.org>
 <f504a3e7-cb18-41ce-a76d-267d464b6b05@linaro.org>
User-Agent: AquaMail/1.51.5 (build: 105105504)
Subject: Re: [PATCH v10 1/5] dt-bindings: net: wireless: brcm4329-fmac: add pci14e4,449d
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On August 14, 2024 4:08:52 PM Krzysztof Kozlowski 
<krzysztof.kozlowski@linaro.org> wrote:

> On 14/08/2024 13:15, Krzysztof Kozlowski wrote:
>> On 14/08/2024 12:59, Arend van Spriel wrote:
>>> On 8/14/2024 12:39 PM, Krzysztof Kozlowski wrote:
>>>> On 14/08/2024 12:08, Arend van Spriel wrote:
>>>>> On 8/14/2024 10:53 AM, Krzysztof Kozlowski wrote:
>>>>>> On 13/08/2024 19:04, Arend Van Spriel wrote:
>>>>>>> On August 13, 2024 10:20:24 AM Jacobe Zang <jacobe.zang@wesion.com> wrote:
>>>>>>>
>>>>>>>> It's the device id used by AP6275P which is the Wi-Fi module
>>>>>>>> used by Rockchip's RK3588 evaluation board and also used in
>>>>>>>> some other RK3588 boards.
>>>>>>>
>>>>>>> Hi Kalle,
>>>>>>>
>>>>>>> There probably will be a v11, but wanted to know how this series will be
>>>>>>> handled as it involves device tree bindings, arm arch device tree spec, and
>>>>>>> brcmfmac driver code. Can it all go through wireless-next?
>>>>>>
>>>>>> No, DTS must not go via wireless-next. Please split it from the series
>>>>>> and provide lore link in changelog for bindings.
>>>>>
>>>>> Hi Krzysztof,
>>>>>
>>>>> Is it really important how the patches travel upstream to Linus. This
>>>>> binding is specific to Broadcom wifi devices so there are no
>>>>> dependencies(?). To clarify what you are asking I assume two separate
>>>>> series:
>>>>>
>>>>> 1) DT binding + Khadas Edge2 DTS  -> devicetree@vger.kernel.org
>>>>> reference to:
>>>>> https://patch.msgid.link/20240813082007.2625841-1-jacobe.zang@wesion.com
>>>>>
>>>>> 2) brcmfmac driver changes  -> linux-wireless@vger.kernel.org
>>>>
>>>> No. I said only DTS is separate. This was always the rule, since forever.
>>>>
>>>> Documentation/devicetree/bindings/submitting-patches.rst
>>>
>>> I am going slightly mad (by Queen). That documents says:
>>>
>>> 1) The Documentation/ and include/dt-bindings/ portion of the patch
>>> should
>>> be a separate patch.
>>>
>>> and
>>>
>>> 4) Submit the entire series to the devicetree mailinglist at
>>>
>>> devicetree@vger.kernel.org
>>>
>>> Above I mentioned "series", not "patch". So 1) is a series of 3 patches
>>> (2 changes to the DT binding file and 1 patch for the Khadas Edge2 DTS.
>>> Is that correct?
>>
>> My bookmark to elixir.bootling does not work, so could not paste
>> specific line. Now it works, so:
>>
>> https://elixir.bootlin.com/linux/v6.11-rc3/source/Documentation/devicetree/bindings/submitting-patches.rst#L79
>>
>> The rule was/is:
>> 1. Binding for typical devices always go via subsystem tree, with the
>> driver changes.
>> There can be exceptions from above, e.g. some subsystems do not pick up
>> bindings, so Rob does. But how patches are organized is not an exception
>> - it is completely normal workflow.
>>
>> 2. DTS *always* goes via SoC maintainer. DTS cannot go via any other
>> driver subsystem tree. There is no exception here. There cannot be an
>> exception, because it would mean the hardware depends on driver, which
>> is obviously false.
>
> In case my message was not clear: we talk here about organizing
> patchsets, not individual patches. If you ask about patches, then DTS,
> bindings and driver are all separate patches. This set already is split
> like that, so this was fine and I did not comment on it. Only through
> whom the DTS patch goes - separate tree.

I used the "series" which is my term for "patchset". Sorry for confusion. 
So "[PATCH 3/5] arm64: dts: rockchip: Add AP6275P wireless support to 
Khadas Edge 2" should be submitted to rockchip soc related tree and the 
rest can go through the wireless-next tree. Got it.

Regards,
Arend
---
$ ./scripts/get_maintainer.pl -f 
arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
Rob Herring <robh@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED 
DEVICE TREE BINDINGS)
Krzysztof Kozlowski <krzk+dt@kernel.org> (maintainer:OPEN FIRMWARE AND 
FLATTENED DEVICE TREE BINDINGS)
Conor Dooley <conor+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED 
DEVICE TREE BINDINGS)
Heiko Stuebner <heiko@sntech.de> (maintainer:ARM/Rockchip SoC 
support,commit_signer:11/11=100%,authored:1/11=9%,removed_lines:1/1=100%)
Muhammed Efe Cetin <efectn@protonmail.com> 
(commit_signer:10/11=91%,authored:10/11=91%,added_lines:685/685=100%)
Dragan Simic <dsimic@manjaro.org> (commit_signer:1/11=9%)
devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE 
TREE BINDINGS)
linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support)
linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support)
linux-kernel@vger.kernel.org (open list)

>
> And just in case: this is neither specific to wireless nor to Broadcom.
> This is for entire Linux kernel.
>
> Best regards,
> Krzysztof




