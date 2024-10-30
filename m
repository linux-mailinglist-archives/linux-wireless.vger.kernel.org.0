Return-Path: <linux-wireless+bounces-14732-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB869B62C2
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 13:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D12EB21406
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 12:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885261E882B;
	Wed, 30 Oct 2024 12:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lNjIEzTI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DBA1E7C1D;
	Wed, 30 Oct 2024 12:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730290505; cv=none; b=a9d0Aib7oh84mA9YP9HBLjxDIAq+l6cjQ6RCoGF2k+bnFqJWUOuv/tEHa/z2eiWPge1USpgdcqpxT/NXUueQlGazGvTyoQ8G+T0P7IdkDPgENjSN6IE4XeKVzX07D/CKFY8H42iN8mmK40R4XKmWjQziJSgxV9cBxfOXB02UFD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730290505; c=relaxed/simple;
	bh=U7yrooYPgfoJ8DXXEy3+qGTnaeyv5NSw22xvBQrzcEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=f9Gfcp5hYspxk+SDwCYlVEAmHMoiVtHn1Fm0Mbo3ifUOeOc5tFOrKljuM+b93PqfzmmU3iar2iVqtRRstSvYXVuY5xfT1SGebtP0UNJGj24qLlP285EjMAg4WbT10yoSnN+Ng8hQ0hVVAfNZvyWHMmkrEqwGv/+s9pEUmIbtTVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lNjIEzTI; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49UCEs3Q046386;
	Wed, 30 Oct 2024 07:14:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730290494;
	bh=hEqQ1qpqZb8TB5oDmGeSGKH2Lagktizrv4yzLYIgTBU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=lNjIEzTIbDhnyrTf1dUnb4rJACF9W4x7JZjhaqz5ZsWwabRkE3joy0qPjZ/OzxL5e
	 kQW20q2kUtZokTigcBbPiWmxDWWu7l4iBUYKAE6QeG5KMVOSWCc1DS2XHurL6HfthY
	 GAQAMXOA8kS+LQr4Ea4P+grv0CgMxqWGbTfNu57U=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49UCEsEM105209
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 30 Oct 2024 07:14:54 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 30
 Oct 2024 07:14:54 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 30 Oct 2024 07:14:54 -0500
Received: from [10.250.202.81] ([10.250.202.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49UCEo2g024212;
	Wed, 30 Oct 2024 07:14:51 -0500
Message-ID: <3fc3c670-ce63-4a27-9d12-1c6c996cf914@ti.com>
Date: Wed, 30 Oct 2024 14:14:50 +0200
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
 <8024aa1c-5bd1-40d8-b0c3-14b5fcd992e2@ti.com>
 <bda36285-dc70-4dff-85ed-9c04c0f7ba44@kernel.org>
Content-Language: en-US
From: "Nemanov, Michael" <michael.nemanov@ti.com>
In-Reply-To: <bda36285-dc70-4dff-85ed-9c04c0f7ba44@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 10/30/2024 1:09 PM, Krzysztof Kozlowski wrote:
> On 30/10/2024 11:59, Nemanov, Michael wrote:
>>>
>>> Your changelog does not explain these three. "Fixed compatibility" is
>>> way too vague, especially that you do not fix anything here.
>>>
>>
>> I was trying to address the feedback from previous patch. You said:
>>
>>>>>> +static const struct of_device_id cc33xx_sdio_of_match_table[] = {
>>>>>> +	{ .compatible = "ti,cc3300", .data = &cc33xx_data },
>>>>>> +	{ .compatible = "ti,cc3301", .data = &cc33xx_data },
>>>>>> +	{ .compatible = "ti,cc3350", .data = &cc33xx_data },
>>>>>> +	{ .compatible = "ti,cc3351", .data = &cc33xx_data },
>>>>>> +	{ }
>>>>>> +};
>>>>>
>>>>>
>>>>> Eh? What happened here? So devices are compatibles thus make them
>>>>> compatible in the bindings.
>>>>>
>>>>
>>>> I thought this is the right way to do it (originally taken from [1]).
>>>> How can I solve it via DT bindings?
>>>
>>> It's all over the bindings (also example-schema). Use fallback and oneOf.
>>>
>>
>> Looking at [2] and [3] as an example I tried to do the same (make cc33xx
>> driver compatible with all chip variants).
>> How should have I done it?
> 
> qcom-wdt is quite a different device. It's true you should have here
> oneOf, but for a purpose. oneOf without purpose does not make sense, right?
> 
> I think other TI bindings would serve you as an example. Or this one:
> 
> https://elixir.bootlin.com/linux/v6.3-rc6/source/Documentation/devicetree/bindings/sound/nvidia,tegra210-ope.yaml#L31
> 
> 
> Best regards,
> Krzysztof
> 

OK.
So I should make one of the variants the base and declare others as 
compatible? i.e:

--Bindings--

   compatible:
     oneOf:
       - const: ti,cc3300
       - items:
           - enum:
               - ti,cc3301
               - ti,cc3350
               - ti,cc3351
           - const: ti,cc3300


--Driver--

static const struct of_device_id cc33xx_sdio_of_match_table[] = {
	{ .compatible = "ti,cc3300", .data = &cc33xx_data },
	{ }
};



