Return-Path: <linux-wireless+bounces-14715-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6A09B60B8
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 12:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39200B22BDE
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 11:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BB11E47B0;
	Wed, 30 Oct 2024 11:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ym7TTSkM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA26E1E3DFD;
	Wed, 30 Oct 2024 11:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730286007; cv=none; b=Amf+tgOG3NNhiDVY4OOrpZUxWfIE1tg/elZbNqHRZrEs00F5AZx/+mdnzNHDK1AC8053mHLDYsMVIAZ5iR4QPcZr1uGQyqzInn5HZfur1Rgmc+6oYpXUcIAXkrlnpi3sVaz9cjf4p1B+Ho5YSbYJLeIOO9gnqiRzV5JHQofkVMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730286007; c=relaxed/simple;
	bh=OakBX+RLezysbRjHVFoqGAN0kilo4WleR6cnN3iJ4ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OzE87LgGkWFDiK6uIx/IX74HINAps8uvXmvCQlfdqyyYKkS24GKeRHQyN3O26PzOukRMN+8PoyDmJg7L48piGFwrv7SvpmRw/mDyr7n2YcG/W651VdgCWiDFmB70SMog1F6ggXR6GkLXUErcrOlsDNyiDtByrjnq6Ip4JnTGJ48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ym7TTSkM; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49UAxsum113792;
	Wed, 30 Oct 2024 05:59:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730285995;
	bh=l63k3Jhw1oNpvbtOumlKeE3VOY2fol/XMJbv2YlVDLs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=ym7TTSkMK7JCdrWlrrpPLD0WKp0NFl57xFlQXOUtAkwRcDdZvRr9lN7eW74MMzpQK
	 p04sGadWJe5qkJs62O7JE3NB7koWoUPWapfP32SYMUVIzjvU6LPf1y8vj13+0xRt1F
	 8bv9VPBPBvqOi+GD21SC5v0zMQWyFmJMmjUDlBbk=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49UAxs5R012788
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 30 Oct 2024 05:59:54 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 30
 Oct 2024 05:59:54 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 30 Oct 2024 05:59:54 -0500
Received: from [10.250.202.81] ([10.250.202.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49UAxp7h068380;
	Wed, 30 Oct 2024 05:59:51 -0500
Message-ID: <8024aa1c-5bd1-40d8-b0c3-14b5fcd992e2@ti.com>
Date: Wed, 30 Oct 2024 12:59:50 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/17] dt-bindings: net: wireless: cc33xx: Add
 ti,cc33xx.yaml
To: Krzysztof Kozlowski <krzk@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>, <linux-wireless@vger.kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Sabeeh Khan <sabeeh-khan@ti.com>
References: <20241029172354.4027886-1-michael.nemanov@ti.com>
 <20241029172354.4027886-2-michael.nemanov@ti.com>
 <936b19eb-cde7-4be8-98cf-e60e32b335cd@kernel.org>
Content-Language: en-US
From: "Nemanov, Michael" <michael.nemanov@ti.com>
In-Reply-To: <936b19eb-cde7-4be8-98cf-e60e32b335cd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 10/29/2024 7:28 PM, Krzysztof Kozlowski wrote:
> On 29/10/2024 18:23, Michael Nemanov wrote:
>> Add device-tree bindings for the CC33xx family.
>>
>> Signed-off-by: Michael Nemanov <michael.nemanov@ti.com>
>> ---
>>   .../bindings/net/wireless/ti,cc33xx.yaml      | 59 +++++++++++++++++++
>>   1 file changed, 59 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/net/wireless/ti,cc33xx.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/net/wireless/ti,cc33xx.yaml b/Documentation/devicetree/bindings/net/wireless/ti,cc33xx.yaml
>> new file mode 100644
>> index 000000000000..12a0a2f52f44
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/wireless/ti,cc33xx.yaml
>> @@ -0,0 +1,59 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/net/wireless/ti,cc33xx.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Texas Instruments CC33xx Wireless LAN Controller
>> +
>> +maintainers:
>> +  - Michael Nemanov <michael.nemanov@ti.com>
>> +
>> +description:
>> +  The CC33xx is a family of IEEE 802.11ax chips from Texas Instruments.
>> +  These chips must be connected via SDIO and support in-band / out-of-band IRQ.
>> +
>> +properties:
>> +  $nodename:
>> +    pattern: "^wifi@2"
> 
> This wasn't here, please drop.
 >

In the previous patch you noted there was a mismatch between the reg 
address in the schema (const: 2) and the used in the example (wifi@1). 
The dt_binding_check did not flag this because SDIO is not a simple bus. 
Using this regex seemed like a good alternative. Still drop it?

> 
>> +
>> +  compatible:
>> +    oneOf:
> 
> Why oneOf appeared? Do you plan to grow it? >
>> +      - items:
>> +          - enum:
>> +              - ti,cc3300
>> +              - ti,cc3301
>> +              - ti,cc3350
>> +              - ti,cc3351
>> +          - const: ti,cc33xx
> 
> And how cc33xx could appear? That's a no. Generic compatibles are not
> allowed. Please do not introduce some completely different changes than
> asked for.
> 
> Your changelog does not explain these three. "Fixed compatibility" is
> way too vague, especially that you do not fix anything here.
> 

I was trying to address the feedback from previous patch. You said:

>>>> +static const struct of_device_id cc33xx_sdio_of_match_table[] = {
>>>> +	{ .compatible = "ti,cc3300", .data = &cc33xx_data },
>>>> +	{ .compatible = "ti,cc3301", .data = &cc33xx_data },
>>>> +	{ .compatible = "ti,cc3350", .data = &cc33xx_data },
>>>> +	{ .compatible = "ti,cc3351", .data = &cc33xx_data },
>>>> +	{ }
>>>> +};
>>>
>>>
>>> Eh? What happened here? So devices are compatibles thus make them
>>> compatible in the bindings.
>>>
>>
>> I thought this is the right way to do it (originally taken from [1]).
>> How can I solve it via DT bindings?
> 
> It's all over the bindings (also example-schema). Use fallback and oneOf.
> 

Looking at [2] and [3] as an example I tried to do the same (make cc33xx 
driver compatible with all chip variants).
How should have I done it?

Regards,
Michael.


[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/wireless/ti/wlcore/sdio.c#n204

[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml

[3] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/watchdog/qcom-wdt.c

