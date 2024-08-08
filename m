Return-Path: <linux-wireless+bounces-11114-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0D394B821
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 09:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 851CC2894D4
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 07:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAC818756D;
	Thu,  8 Aug 2024 07:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSjzOH8P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A5A1373;
	Thu,  8 Aug 2024 07:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723103145; cv=none; b=Fi7cyn+4EBg9dxrw4OaYOcoRjJXSWFtnileUnE3eZ+7lE6k/4JXynH6+KrnaokCsEU8zeZgkk6gwdvAQf7mLgNoV8g/NSK66syiXCqQVzGHBSbkm+X5POa1743Fyc56dqP/9GR7wpErSHGDdOn5kR5d8+d2uy8bWeEJaXQyrddY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723103145; c=relaxed/simple;
	bh=GaziUuowzvNdFYxe3L0FWdTA+XXUKkthzkrZzoXQewQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HJV9yGz6ObSgWP3XWu7ZLJdyfTlJ86K/+Z2H3hd2Rr9m5E6x3Ric1NdftbCFrGmHOShrsgA/ZzX8VpMsVz2jcBO0zHcww4qg3exS11KOqkbTbb+aRLPrEM8D7emQquHrGbKdyBBXpP9nuazeEOtvvYLKFUyprWIBkC/DiEDfwhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSjzOH8P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B40C32782;
	Thu,  8 Aug 2024 07:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723103145;
	bh=GaziUuowzvNdFYxe3L0FWdTA+XXUKkthzkrZzoXQewQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rSjzOH8Pv1wdMVp2IkGjWfQyFaxJNy+TNgb4O/zaRRTc1jkEgOU8BU6vtEEJJtUWp
	 Re+vwvFVbxY+ACMayD1/77vpTGTH37r7cX/qu2oh/VDGN5griLTMe5Ck9YU0EfulpX
	 0G7+XMlOdAWRTABR5z6I2+PY6Hhv/aiAuGTDtRJqTnIKl6CzVwYV0pWoaxl1lWlrCX
	 UbaE7MIobjsVY3h0cHg0z4Q/aLmSNEWlrxIxlI9Pg5RtpGtiGuXiWUiMeeKF4G/m/s
	 tk7Qb+aTolYKBaxxYu3UdFrFTmcJs4Zwu/mSjIVeGFdCBCi+aoedR7HPVGqCgTxbT6
	 zTG2BIK3VqpfA==
Message-ID: <ec9c0623-4cb1-4c38-b910-01ef779f47e4@kernel.org>
Date: Thu, 8 Aug 2024 09:45:38 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/17] dt-bindings: net: wireless: cc33xx: Add
 ti,cc33xx.yaml
To: "Nemanov, Michael" <michael.nemanov@ti.com>, Kalle Valo
 <kvalo@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Sabeeh Khan <sabeeh-khan@ti.com>
References: <20240806170018.638585-1-michael.nemanov@ti.com>
 <20240806170018.638585-18-michael.nemanov@ti.com>
 <40031203-63c6-46b5-b647-d344d4503bb7@kernel.org>
 <0da6f8ce-e220-47b9-86dd-537ad4b328e5@ti.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <0da6f8ce-e220-47b9-86dd-537ad4b328e5@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/08/2024 17:51, Nemanov, Michael wrote:
> On 8/7/2024 10:06 AM, Krzysztof Kozlowski wrote:
>> On 06/08/2024 19:00, Michael Nemanov wrote:
>>
>> Thank you for your patch. There is something to discuss/improve.
>>
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - ti,cc3300
>>> +      - ti,cc3301
>>> +      - ti,cc3350
>>> +      - ti,cc3351
>>> +
>>> +  reg:
>>> +    description:
>>> +      must be set to 2
>>
>> Then just const: 2 and drop free form text.
>>
>>> +    maxItems: 1
>>> +
>>> +  interrupts:
>>> +    description:
>>> +      The out-of-band interrupt line.
>>> +      Can be IRQ_TYPE_EDGE_RISING or IRQ_TYPE_LEVEL_HIGH.
>>> +      If property is omitted, SDIO in-band IRQ will be used.
>>> +    maxItems: 1
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>> +
>>> +    // SDIO example:
>>
>> Drop, obvious.
>>
>>> +    mmc {
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +
>>> +        wifi@1{
>>
>> Missing space.
>>
>> Also, this does not match reg. Test your DTS with W=1 and FIX ALL warnings.
>>
>> Best regards,
>> Krzysztof
>>
> 
> Will fix all above.
> 
> I'm currently testing my .yaml with:
> make dt_binding_check DT_CHECKER_FLAGS=-m \ 
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/net/wireless/ti,cc33xx.yaml
> 
> It reports no warnings. Adding W=1 doesn't seem to change anything. Am I 
> missing something?

I said test your DTS, not bindings.

Best regards,
Krzysztof


