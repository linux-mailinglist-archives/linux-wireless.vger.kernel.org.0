Return-Path: <linux-wireless+bounces-10673-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5C8940E50
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 11:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C6171F247B1
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 09:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC330194C78;
	Tue, 30 Jul 2024 09:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="V2w9peLG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493C91946DA
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jul 2024 09:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722333185; cv=none; b=of4seGP0Xilr5W5TQ8LiQ6EYjak0va3pIm009Cjznt4xJKTkwBVZfNIJ8LRHR2yO0WlhumsWeo4Tz4Sp9JMkydI2p31WEVgTkTRbf1WFdfc73aVmbfrnJoFKkxuI3/1SBowlENb7z7JVvSb0Rr16SgBJSqIC8xQFnZrf8moCPTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722333185; c=relaxed/simple;
	bh=yyO3hcRLNuqAV2Gf157yrnXtadAYEe17pUI/1dgy2Ho=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=hBOvsdqjPXhobHHzbcVK07rFJ8jI9xiokG9lK3A54X9T8tz/p5e4iB24vsHCRha0Hf+D6ysOXzayNzuObF7kpkWE8sxv+NwCFWnIMiLyLhujN1PcOIRI8CJ+nFQlxCgc1AF/8gr1giM0QNiACVvzi5QmI3IRVQJgrxcGp7W6fmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=V2w9peLG; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52efdf02d13so6967253e87.2
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jul 2024 02:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722333181; x=1722937981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RA46jBL+SPUUXOwt3hGVdpN7JmCGwJMtQwXehgaQlLY=;
        b=V2w9peLGXrcmmgqenpSNQmrmZwyV1BOPyeC1QfYu+bB0jh7NrhsXoyFOdYxFN4fquq
         qDfRVUznX9nw1ZPIt6GGGdUB+EIrt/ufNS2WLGX/A2FUVABWAXfNdWzPlV2ymvUWz/xx
         DM/08NOouP9eggvHspF/K9x/y0WgSC28lW3ww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722333181; x=1722937981;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RA46jBL+SPUUXOwt3hGVdpN7JmCGwJMtQwXehgaQlLY=;
        b=uG3+wxim2WEMdzPiRCVNXnXwXmNt72WRfYIw4pWr67cDp5cjxIYsM/cNYaD9AQ7nfU
         zkYycwUUCCEwzLf8uQe/HDqddLpyUwAPpOGH147ydhOn5hChcoyf+ok3vRJKZZxJIiP+
         Y4klygP1T81gtdPrMkpnUlqw9x9S80bFpd4NMAalsgjnlkjriAE3lZJa/oAAveILBpu8
         /t0kV/2NaMHJIIUueBX39iLzsgzujAvEuhdSGJ/eX3Hug05ujtWg8/eukGSxVvdXnQzK
         0Gjn3C9g38yDSSsc29vEtLTpyUwS5azGjJfgvu9xzILlYMvvq31hACoPphg5rL8xfF+h
         1rvA==
X-Forwarded-Encrypted: i=1; AJvYcCVnzc6YXPPOjNFWZqE0nPwsk27lkfAxISWabRe4btUhF3TvfEC2knUNyb5sWOjHabKBIsJi4dsyUVCkSpnZMHksi5VgNSiEWZBetPfoEm0=
X-Gm-Message-State: AOJu0Yyx3y42fz8xSmvjZTTF7CoLaT+9NwnzvVmyXWG3B51YY2l6qrOg
	zDJyUURibveyRVAehguwF2XhloF/blQ4YLBtkHWD4bk0BS0JBCZENeJRUIw33A==
X-Google-Smtp-Source: AGHT+IHlCt/1eobcVjTAVX4BrkBS2kd5LjzvzW4U/MFQXgveeXv+o8QcHY9jzRml82ZRhYYMl0R/EQ==
X-Received: by 2002:a05:6512:2c0d:b0:529:b718:8d00 with SMTP id 2adb3069b0e04-5309b2694e5mr8676169e87.8.1722333181165;
        Tue, 30 Jul 2024 02:53:01 -0700 (PDT)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad41961sm624701966b.131.2024.07.30.02.52.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2024 02:53:00 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Jacobe Zang <jacobe.zang@wesion.com>, <robh@kernel.org>, <krzk+dt@kernel.org>, <heiko@sntech.de>, <kvalo@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>, <conor+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>
CC: <efectn@protonmail.com>, <dsimic@manjaro.org>, <jagan@edgeble.ai>, <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>, <arend@broadcom.com>, <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>, <megi@xff.cz>, <duoming@zju.edu.cn>, <bhelgaas@google.com>, <minipli@grsecurity.net>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <nick@khadas.com>
Date: Tue, 30 Jul 2024 11:52:59 +0200
Message-ID: <191030eac78.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <f45c1fa7-f321-4a1f-b65c-6ed326a18268@kernel.org>
References: <20240730033053.4092132-1-jacobe.zang@wesion.com>
 <20240730033053.4092132-3-jacobe.zang@wesion.com>
 <191025b5268.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <f45c1fa7-f321-4a1f-b65c-6ed326a18268@kernel.org>
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

On July 30, 2024 11:01:43 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 30/07/2024 08:37, Arend Van Spriel wrote:
>> + Linus W
>>
>> On July 30, 2024 5:31:15 AM Jacobe Zang <jacobe.zang@wesion.com> wrote:
>>
>>> Not only AP6275P Wi-Fi device but also all Broadcom wireless devices allow
>>> external low power clock input. In DTS the clock as an optional choice in
>>> the absence of an internal clock.
>>>
>>> Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>>> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
>>> ---
>>> .../bindings/net/wireless/brcm,bcm4329-fmac.yaml          | 8 ++++++++
>>> 1 file changed, 8 insertions(+)
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
>>> b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
>>> index 2c2093c77ec9a..a3607d55ef367 100644
>>> --- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
>>> +++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
>>> @@ -122,6 +122,14 @@ properties:
>>> NVRAM. This would normally be filled in by the bootloader from platform
>>> configuration data.
>>>
>>> +  clocks:
>>> +    items:
>>> +      - description: External Low Power Clock input (32.768KHz)
>>> +
>>> +  clock-names:
>>> +    items:
>>> +      - const: lpo
>>> +
>>
>> We still have an issue that this clock input is also present in the
>> bindings specification broadcom-bluetooth.yaml (not in bluetooth
>> subfolder). This clock is actually a chip resource. What happens if both
>> are defined and both wifi and bt drivers try to enable this clock? Can this
>> be expressed in yaml or can we only put a textual warning in the property
>> descriptions?
>
> Just like all clocks, what would happen? It will be enabled.

Oh, wow! Cool stuff. But seriously is it not a problem to have two entities 
controlling one and the same clock? Is this use-case taken into account by 
the clock framework?

Regards,
Arend



