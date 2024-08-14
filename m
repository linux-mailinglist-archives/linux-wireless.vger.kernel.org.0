Return-Path: <linux-wireless+bounces-11429-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8AB95198A
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 13:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D879F282C8D
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 11:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2581AE84B;
	Wed, 14 Aug 2024 11:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="W4MQ4491"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5359D1AE05E
	for <linux-wireless@vger.kernel.org>; Wed, 14 Aug 2024 11:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723633203; cv=none; b=LGqlHApq2lexYAdic3NDX9zewcH4N7oec3Pir++/uoEpoVPQQfVak2UnCCW8WlZvODOIzQ+s1/vam/qVrw14tSYznkPczlV97+gns0ROSMEbtBy+miCxVT370EgtdfOxAW1LeUgG2mZFnmyXQQIxOBkXA1lBMqBUVg5fxYZKcSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723633203; c=relaxed/simple;
	bh=gkPgVpcGFwGoavkuUi2MpeQrl95zZ+AG1mO5RvrBy8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pr0Cu0M8WWJwOyd0h8b4WguJKFOdtr6DTpn6I03H2AU/4NW9afhjA7H4lZotnRKgso4pjjiSHuK9JN3MzsJ/k4kORW/kdrJCE90EzfJdPX27e/JkndZ4uE4gINaFj580rqOC3XRznST14AREj33Vq4jPj0fXDp4UNkdR/DJ5gUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=W4MQ4491; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fc56fd4de1so5940265ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 14 Aug 2024 04:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723633200; x=1724238000; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3qUjSfJL0D2qc7SMFf2eMAHEIrrW3XFkl0wbXvVknJU=;
        b=W4MQ4491tHExu2t+TZuLwALMeSgBM3+b/9Nf1YZtJ4s0kAmhIioRclCsQd0Xm4V7b2
         szUmWuDuMoBXcBM8NlPVi1wtJBwPwKpwRLX3fRvg0R/ciBKI4yQ2d5MdiIQ1UQlRQAAh
         0M8eUWMWno3RhHgMUyYgNemomFk7sSrYS8mIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723633200; x=1724238000;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qUjSfJL0D2qc7SMFf2eMAHEIrrW3XFkl0wbXvVknJU=;
        b=E7mnAbrwQYhZqMCDcFhKy+qyb0CNT0ZZTcW5GZPcJjrLIpOw2fU5CSrCRz7TehigwO
         v1qkSfM/f/62mVHYPxXc2ea/YQnPBkzR2D5PH2tna+2Nny+FBMzozqqFBrXWpmaO4Ncs
         dQyw72y/vLu4CXA7q42WsInW/FwCvWOo4WeIIa0Mg2YdwTssUtVa+dFrpvDpnjK1YKhE
         sFkwHXJKi8cq0TpkIsGxNZU/dPgryJsTPtYkKchy4jM2RFl2p6fjCNXHTY6XWI+CgP4P
         5ovZSAi8mijen7LTaSnfJKOO+ggXWGfeO7SPgHbP3oFKxumubhOQmi+sBSClvoTzwGLI
         Oezw==
X-Forwarded-Encrypted: i=1; AJvYcCWuLe+2OB51zbZIsa0znbGOKic/4aYPd+A/6RcxVbiiz1yV+2v2CwpVnvMavVu37cbzZ5UrFyGlDJGjfRCJT18qNX6JI04BWUtKZZjBE3g=
X-Gm-Message-State: AOJu0YyyjIPSOR3ZW+yFf8naWoG/q1lCetRzK/oK/pDOtTzFKNRy/Cgl
	Ox4hV4aNmOREMNS+ZxSmLfqPKjAFGIdG6wNlfXcLwxT3pJB4EFUPM2q5pz845w==
X-Google-Smtp-Source: AGHT+IFqOffgtQAjEk0phUboPbU/XKGUxX1A7ojT9F7/rLRq7j3XznoSX+PZCtEeLMgGbxudFio86w==
X-Received: by 2002:a17:902:dac9:b0:1fb:2ebc:d16b with SMTP id d9443c01a7336-201cbba0316mr94862705ad.7.1723633200258;
        Wed, 14 Aug 2024 04:00:00 -0700 (PDT)
Received: from [10.176.68.61] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd14ac10sm27389575ad.102.2024.08.14.03.59.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 03:59:59 -0700 (PDT)
Message-ID: <180f7459-39fa-4e96-83d6-504e7802dc94@broadcom.com>
Date: Wed, 14 Aug 2024 12:59:51 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/5] dt-bindings: net: wireless: brcm4329-fmac: add
 pci14e4,449d
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <1e442710-a233-4ab2-a551-f28ba6394b5b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/2024 12:39 PM, Krzysztof Kozlowski wrote:
> On 14/08/2024 12:08, Arend van Spriel wrote:
>> On 8/14/2024 10:53 AM, Krzysztof Kozlowski wrote:
>>> On 13/08/2024 19:04, Arend Van Spriel wrote:
>>>> On August 13, 2024 10:20:24 AM Jacobe Zang <jacobe.zang@wesion.com> wrote:
>>>>
>>>>> It's the device id used by AP6275P which is the Wi-Fi module
>>>>> used by Rockchip's RK3588 evaluation board and also used in
>>>>> some other RK3588 boards.
>>>>
>>>> Hi Kalle,
>>>>
>>>> There probably will be a v11, but wanted to know how this series will be
>>>> handled as it involves device tree bindings, arm arch device tree spec, and
>>>> brcmfmac driver code. Can it all go through wireless-next?
>>>
>>> No, DTS must not go via wireless-next. Please split it from the series
>>> and provide lore link in changelog for bindings.
>>
>> Hi Krzysztof,
>>
>> Is it really important how the patches travel upstream to Linus. This
>> binding is specific to Broadcom wifi devices so there are no
>> dependencies(?). To clarify what you are asking I assume two separate
>> series:
>>
>> 1) DT binding + Khadas Edge2 DTS  -> devicetree@vger.kernel.org
>> 	reference to:
>> https://patch.msgid.link/20240813082007.2625841-1-jacobe.zang@wesion.com
>>
>> 2) brcmfmac driver changes	  -> linux-wireless@vger.kernel.org
> 
> No. I said only DTS is separate. This was always the rule, since forever.
> 
> Documentation/devicetree/bindings/submitting-patches.rst

I am going slightly mad (by Queen). That documents says:

   1) The Documentation/ and include/dt-bindings/ portion of the patch 
should
      be a separate patch.

and

   4) Submit the entire series to the devicetree mailinglist at

        devicetree@vger.kernel.org

Above I mentioned "series", not "patch". So 1) is a series of 3 patches 
(2 changes to the DT binding file and 1 patch for the Khadas Edge2 DTS. 
Is that correct?

Regards,
Arend

