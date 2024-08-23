Return-Path: <linux-wireless+bounces-11819-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1682E95C373
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 04:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B676B1F215CE
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 02:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BC420B33;
	Fri, 23 Aug 2024 02:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="PgNttlw7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C5717C66;
	Fri, 23 Aug 2024 02:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724381706; cv=none; b=r/hIl4Fi3IXDtkU1KaI5RaokBAS3t4W39vHJG1Hh6o7aLbVSFSVo+7tklhpEP9uRxMO0h6Pip+sVJPMd3nr2np1QEC1FnJ3Fjaa2gqFe6N39oYRkS2L0n+Tagn40+6jdMny2jjL2TuiDVlZYRtRbDT5ZtRJglG7rbvimoOkozfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724381706; c=relaxed/simple;
	bh=r0ekU5AqIfC24ilqyeigqM5Fh/Z+yqK7Vwwf84nNzIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qm4QFMsDPRnLY4cWSUgRky2/fo9BZR0pe+q4h+ChnyQb3Ji3iPiqzEf4J7w+GF6khXb6QqYVFY1PnUYAx7N2Ls1EbdZjcIBa3vq7T7yfz8Cb/5U9LSlkgb9QsQVbcdKSVqRpOqcjAXzoPkNHYg/6WoHADksB1oqkQpvOWb9VCYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=PgNttlw7; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 58B9588670;
	Fri, 23 Aug 2024 04:55:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724381701;
	bh=VB9IORftPAVeGro51PxExChME2l7pC/KNvYfuijMbJc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PgNttlw7UQ0us/n5amqD54HZqSBAUEkRA6c/UUVndpa9fZaogEK/PH2KRFpo6TXtW
	 pniQ/sgnBu+HFYIpujXf7lmUUUfHLPBZJ6DrlvxBWARYEdjQhAunLAJr6GNtHuVXCW
	 pkKvPlm4fTKmY/yNmouWHXKWEVWvE+c+5JUJJIIN5ahp0ivU7DkBiDUwR/MZYTgQl3
	 MzY/8WFu+ZVQnQkm1SFbqdIfR1SQgmA5WRM1U37vEpFRH5QY9dXPPgruoiZyElSCds
	 XFObsSfqcFIVhMxSG2QaGpKYBVFNm3LSabxqJYhrpIB09jK8ZT4ruReSyPt39NIROo
	 xjy8TnUzQQvKg==
Message-ID: <8031c3ef-3b16-4200-83aa-0776bdfa8b45@denx.de>
Date: Fri, 23 Aug 2024 03:38:29 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: wireless: wilc1000: Document WILC3000
 compatible string
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-wireless@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Adham Abozaeid <adham.abozaeid@microchip.com>,
 Ajay Singh <ajay.kathat@microchip.com>,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Conor Dooley
 <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Kalle Valo <kvalo@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240821184356.163816-1-marex@denx.de>
 <ztc4h7rgsli2jltrdgu5twnma6dbbt3kbbbo3i4eevb3whkqkv@oabtuskiz7km>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <ztc4h7rgsli2jltrdgu5twnma6dbbt3kbbbo3i4eevb3whkqkv@oabtuskiz7km>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 8/22/24 10:07 AM, Krzysztof Kozlowski wrote:

Hi,

>> diff --git a/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.yaml b/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.yaml
>> index 2460ccc082371..1bf3496c21e64 100644
>> --- a/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.yaml
>> +++ b/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.yaml
>> @@ -16,7 +16,9 @@ description:
>>   
>>   properties:
>>     compatible:
>> -    const: microchip,wilc1000
>> +    enum:
>> +      - microchip,wilc1000
>> +      - microchip,wilc3000
> 
> Your driver change suggests device type is fully auto-detectable

It seems that way, yes.

>, thus
> they are compatible.

I _think_ the hardware is internally somewhat different, the WILC1000 is 
WiFi-only device and the WILC3000 has some extra Bluetooth part (which 
is currently not supported).

Maybe a fallback compatible string would be better here ?

