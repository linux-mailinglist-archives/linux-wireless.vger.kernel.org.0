Return-Path: <linux-wireless+bounces-11820-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A5A95C377
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 04:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 663581C23371
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 02:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666372D058;
	Fri, 23 Aug 2024 02:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="dY8bH6cp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF4F1AACC;
	Fri, 23 Aug 2024 02:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724381707; cv=none; b=dIPbebKt/lsmcNGW99Qb7GW5H4Tzx9BaYZBbdGZQvwGipxYnhx9o1odoAzfxCtosVtYQjXIPjJ6x0J2mMzTHXCZkxcA9Yc8JfLSK9wovsP0XaRAa12vq9kH8wZJz5jYUiWE1kU4hqpMcvWkkAftEmfxYf8w6yILuImRjaBQjjNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724381707; c=relaxed/simple;
	bh=iTlt53gQK9+9Hz9DvTV/gOOgL3RNRtRRwY1kkPCv7vU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sBLIYPD9LtuJeBQZ1Yey2QCxfEUL7T9bMcdPYR1S2a0J8PukzxAxCbCctR2nlD+Ji6ktswKQm+oOFoah8NLMETkqB8OS8i8IlESTWUY1Wu5BR5/tdk6Oxn5DPRMJmt9xl57J3OdyvUuPVDJdKEVgOYQaHV9ggc0tCVKQEa32WsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=dY8bH6cp; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 26DA088901;
	Fri, 23 Aug 2024 04:55:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724381703;
	bh=LxYL+39b8LWjrZZ3Cgpz/anGz2pUwUNj0nbkQtQj0UI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dY8bH6cpnI0iijGVuZbf+2BPa12H63tEMngXnRt1baZL+/8MeAIXSGvjt/+nvIOGl
	 f0m/zX+MtKblgiXA9ombeHG66+SziYTAM+9w2IQnnkWepE/1DT8sPzgGzL/2xhWJmy
	 FZaVQimA694jzsNtDvQIcN5BpS2fikX1paE3lwttFagdOrzZWcvoFU989vljiNPKcL
	 /pF4Ts60axUREXDmiBXyax+ydyHrCFEr1qQ0bGhINL2spM25DzZ8faZQ3sgjbbUXwq
	 Hc10JOx/NYf2wj2ES5WlQyW0Rbv+lu+j2OEZ67E0yuUHWrV6WevjPH3qnl9o+8ttS9
	 7JFW4OJ/gSUEg==
Message-ID: <89601525-cd39-4a66-8efe-216823a9d766@denx.de>
Date: Fri, 23 Aug 2024 03:42:19 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: wilc1000: Add WILC3000 support
To: Simon Horman <horms@kernel.org>
Cc: linux-wireless@vger.kernel.org, Ajay Singh <ajay.kathat@microchip.com>,
 "David S. Miller" <davem@davemloft.net>,
 Adham Abozaeid <adham.abozaeid@microchip.com>,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Conor Dooley
 <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Kalle Valo <kvalo@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240821184356.163816-1-marex@denx.de>
 <20240821184356.163816-2-marex@denx.de> <20240822102609.GK2164@kernel.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240822102609.GK2164@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 8/22/24 12:26 PM, Simon Horman wrote:
> On Wed, Aug 21, 2024 at 08:42:33PM +0200, Marek Vasut wrote:
>> From: Ajay Singh <ajay.kathat@microchip.com>
>>
>> Add support for the WILC3000 chip. The chip is similar to WILC1000,
>> except that the register layout is slightly different and it does
>> not support WPA3/SAE.
>>
>> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
>> Signed-off-by: Marek Vasut <marex@denx.de>
> 
> ...
> 
>> diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/wireless/microchip/wilc1000/sdio.c
>> index 41122199d51eb..7b99fcc450fd3 100644
>> --- a/drivers/net/wireless/microchip/wilc1000/sdio.c
>> +++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
>> @@ -764,9 +764,13 @@ static int wilc_sdio_init(struct wilc *wilc, bool resume)
>>   	 *      make sure can read back chip id correctly
>>   	 **/
>>   	if (!resume) {
>> -		ret = wilc_sdio_read_reg(wilc, WILC_CHIPID, &chipid);
>> -		if (ret) {
>> -			dev_err(&func->dev, "Fail cmd read chip id...\n");
>> +		chipid = wilc_get_chipid(wilc, true);
>> +		if (is_wilc3000(chipid)) {
>> +			wilc->chip = WILC_3000;
>> +		} else if (is_wilc1000(chipid)) {
>> +			wilc->chip = WILC_1000;
>> +		} else {
>> +			dev_err(&func->dev, "Unsupported chipid: %x\n", chipid);
>>   			return ret;
> 
> Hi Marek and Ajay,
> 
> It seems that with this change ret will be 0 here.
> Perhaps an negative error code should be returned instead?

Fixed by returning -EINVAL , thanks .

