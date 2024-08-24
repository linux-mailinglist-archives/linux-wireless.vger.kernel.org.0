Return-Path: <linux-wireless+bounces-11891-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEC395E00C
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Aug 2024 23:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CB6A1C20DB8
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Aug 2024 21:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F06143C4B;
	Sat, 24 Aug 2024 21:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="TlVDoP9k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8042328E0F;
	Sat, 24 Aug 2024 21:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724535304; cv=none; b=pZfmQvLwj5AL8xBX7jA2wUIHHt7CNouypECbdJg7l1+EENPeAgGcv5te3yWy+EYA+bOss5ARnDREh5zUhmqmhZ17Ditlcv4WE0BDMigZI/hw7g7baLS+/O8WonbC6szkMIW9kRWqmkPlJSHWlSixdRa4mY91e71q1O4fBtei9Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724535304; c=relaxed/simple;
	bh=o38WZi9pkl2m6WJPJmjqzjb3BYUPjWfOhmDpRPhAa7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IHDfMH/eVCmFCicTiT56VEntA178dJMF9oVTEf0W2gjJgffrpGRLBtSVUv3XqAyCiwXOuaEoMpytOva8VdnehWyeWP8nmZmUKniosrm3KJW1x225op62sn8/ASz6A2lKO/DNSiVm7PMPM20PMky/ZbXZlovcw9FhCHPR/vnq3pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=TlVDoP9k; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 3ECD58888F;
	Sat, 24 Aug 2024 23:34:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724535295;
	bh=e4zyjZJf6xqCKXroarDmr4dscjZVxpZsdflBz5n9XvI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TlVDoP9kQZz3G2/RSNk7ws0p1y9yQT+jjsa1TJjcM9zO0qSjUJAnjgSFxWwqEEW59
	 r1AS0//0wgG2054uiJWkAQkxaoX8SfOjjhGcjKAADIESFJM+00/4joLZnxB0tquARu
	 /S0QELZtpIOssu+oMaBbfeEklKrGHoQs9iW6nk27rqlwH4x6TlSbtZl/e7q9NdnUXG
	 C8YjOvaUK5OjuvT0gQ+gxdJ2PyIp9fQ5kRd424Bc/BkrXGC+SAKm2HyafDaMt7SeDe
	 q9F8gCEm1IojlvKi+fVo9FYH2SM17MQR7vdz06qmkUn9d0tEscCfCu5bOxhw1l00ig
	 eWUGaK6RXeWHA==
Message-ID: <6a3d9171-3d5b-413d-bc48-cbc6ca10c48a@denx.de>
Date: Sat, 24 Aug 2024 23:21:31 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] dt-bindings: wireless: wilc1000: Document WILC3000
 compatible string
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-wireless@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Adham Abozaeid <adham.abozaeid@microchip.com>,
 Ajay Singh <ajay.kathat@microchip.com>,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Conor Dooley
 <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Kalle Valo <kvalo@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240823161131.94305-1-marex@denx.de>
 <facfaca2-e26e-4cab-9240-fdb0eac5c5fd@kernel.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <facfaca2-e26e-4cab-9240-fdb0eac5c5fd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 8/24/24 8:22 AM, Krzysztof Kozlowski wrote:

Hi,

>> diff --git a/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.yaml b/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.yaml
>> index 2460ccc082371..b8ee6cdab3c25 100644
>> --- a/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.yaml
>> +++ b/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.yaml
>> @@ -16,7 +16,11 @@ description:
>>   
>>   properties:
>>     compatible:
>> -    const: microchip,wilc1000
>> +    oneOf:
>> +      - items:
>> +          - const: microchip,wilc1000
>> +          - const: microchip,wilc3000
> 
> That's wrong order of compatibles. Fallback is wilc1000, so should be
> the last item.

Right, fixed, thanks.

