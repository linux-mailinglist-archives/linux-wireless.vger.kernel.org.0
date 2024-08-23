Return-Path: <linux-wireless+bounces-11821-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA2595C379
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 04:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBC302834A6
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 02:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F5338FA5;
	Fri, 23 Aug 2024 02:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="dZuT/R7C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9B628DC3;
	Fri, 23 Aug 2024 02:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724381709; cv=none; b=NUdKko2k9WmclCr700eS5zRQ1HJzCVi+xiJKpUiMTXXPk17yX8f8YdmbpatqJ8ZkKm7wLigGAhEKVCnVu++y7UNTTctl1tQzyU3KsRWKg56VQMNsAwZF5/D9nr3lGEt0HSJO20Y8T2fyGVgs53Xewf/smu49T4g5AbIsbG4tWzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724381709; c=relaxed/simple;
	bh=3H3inGK3FdVtB59opXLPzBkVlqEPsWA+B4dhRLOlAp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oLVeb1oCjTD60PLIuJsgLNOXBRQuOQGpQZnzbikXlZRDnbt9pWUH8Z2og1qocCBpR9f5TeiIqGlIuVQ52QpuiVIAPRugXylgR/4cclHkM/gRn6C1NfI6sJI3hR0xtg9aDFBcYVnWDYPia2XLi+fOezm6uJ50FkCho3UL3Y+7NZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=dZuT/R7C; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 6010C889B4;
	Fri, 23 Aug 2024 04:55:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724381704;
	bh=v6/AEad34vXME+nOC1OR+VXilYDdLKEl9WOj8eeP57M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dZuT/R7CiO/QoKRXW9kZF640EcVPM8pEhteksQWI1Eu1+cXKiTsAMrtp7R3s6fk7o
	 7XbIgiNO65H1JLCOtZ6WnPbHWeep4DlJ7e58JkzntKZ8FR+une4pLSbqywjPlr7VuF
	 O8kCTGPd5VWr+1TnQsQK+/E/zt2468U78wx4o3N+VLz88/zNkHFN9YsTfqpatsAKL2
	 uv2VOwuaX7BQfJ5JxsJqLxNyfMljAqVZnWc6fXTq1BwxptfdDN7K/E6QwHQ0iJfTJ+
	 6fpAmH0aUYvT1rRdvxS2n/WfOpTXQK/SJI3tsVwc1BkUmvnosxeMU2OCmugHhzkV6g
	 txSlfjJqaDkog==
Message-ID: <201b31cb-ef17-4e18-9a4e-ff4193d06afb@denx.de>
Date: Fri, 23 Aug 2024 04:46:58 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: wilc1000: Add WILC3000 support
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 linux-wireless@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>,
 "David S. Miller" <davem@davemloft.net>,
 Adham Abozaeid <adham.abozaeid@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Conor Dooley
 <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Kalle Valo <kvalo@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240821184356.163816-1-marex@denx.de>
 <20240821184356.163816-2-marex@denx.de>
 <bbaf1b15-2d0e-4699-91cc-17fa7a18559b@bootlin.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <bbaf1b15-2d0e-4699-91cc-17fa7a18559b@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 8/22/24 2:10 PM, Alexis Lothoré wrote:
> Hello Marek,

Hi,

> I was coincidentally working on adding wilc3000 support upstream too.

I hope you weren't too far along with that and I didn't waste too much 
of your time/effort here.

> My work is
> also based on downstream tree, so my comments will likely reflect the reworks I
> was doing or intended to do.
> For the record, I have some wilc1000 and wilc3000 modules, in both  sdio and spi
> setups.

Nice, I only have this WILC3000 SDIO device .

> On 8/21/24 20:42, Marek Vasut wrote:
>> From: Ajay Singh <ajay.kathat@microchip.com>
> 
> [...]
> 
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
>>   		}
> 
> I wonder if this additional enum (enum wilc_chip_type)  is really useful. We
> already store the raw chipid, which just needs to be masked to know about the
> device type. We should likely store one or the other but not both, otherwise we
> may just risk to create desync without really saving useful info.
> 
> Also, this change makes wilc1000-sdio failing to build as module (missing symbol
> export on wilc_get_chipid)

I think I have a separate patch for this, one which folds 
wilc_get_chipid() entirely into wlan.c , and then follow up which uses 
is_wilc1000() / is_wilc3000() all over the place to discern the two MACs 
based on cached chip ID . That should work, I'll test it and submit it 
later today I hope.

> [...]
> 
>> -	/* select VMM table 0 */
>> -	if (val & SEL_VMM_TBL0)
>> -		reg |= BIT(5);
>> -	/* select VMM table 1 */
>> -	if (val & SEL_VMM_TBL1)
>> -		reg |= BIT(6);
>> -	/* enable VMM */
>> -	if (val & EN_VMM)
>> -		reg |= BIT(7);
>> +	if (wilc->chip == WILC_1000) {
> 
> wilc1000 should likely remain the default/fallback ?

I am now validating whether the hardware is either wilc1000 or wilc3000 
up front based on the chip ID early in init, so no other option can 
occur here, so there is no need for fallback, it is either wilc1000 or 
wilc3000 now (*). I think keeping them ordered alphanumerically is the 
nicer option.

> [...]
> 
>> @@ -1232,10 +1234,7 @@ static int wilc_validate_chipid(struct wilc *wilc)
>>   		dev_err(&spi->dev, "Fail cmd read chip id...\n");
>>   		return ret;
>>   	}
>> -	if (!is_wilc1000(chipid)) {
>> -		dev_err(&spi->dev, "Unknown chip id 0x%x\n", chipid);
>> -		return -ENODEV;
>> -	}
>> +
> 
> Instead of dropping any filtering (and then making the function name become
> irrelevant), why not ensuring that it is at least either a wilc1000 or a wilc3000 ?

Right, done.

[...]

>> +void chip_wakeup(struct wilc *wilc)
>> +{
>> +	if (wilc->chip == WILC_1000)
>> +		chip_wakeup_wilc1000(wilc);
>> +	else
>> +		chip_wakeup_wilc3000(wilc);
>> +}
>>   EXPORT_SYMBOL_GPL(chip_wakeup);
> 
> This new support makes a few places in wlan.c, netdev.c and in bus files
> (sdio.c, spi.c) install (sometimes big) branches on the device type (chip init,
> sleep, wakeup, read interrupt, clear interrupt, txq handling, etc), because the
> registers are different, the masks are different, the number of involved
> registers may not be the same, wilc3000 may need more operations to perform the
> same thing... I feel like it will make it harder in the long run to maintain the
> driver, especially if some new variants are added later.

I agree the code is ugly. Looking at the roadmap, it seems the next 
thing is WILCS02 which has its own driver, and for the WILC1000/3000 
inherited from atmel this seems to be the end of the road.

> Those branches tend to
> show that some operations in those files are too specific to the targeted
> device. I was examining the possibility to start creating device-type specific
> files (wilc1000.c, wilc3000.c) and move those operations as "device-specific"
> ops. Then wlan/netdev would call those chip-specific ops, which in turn may call
> the hif_func ops. It may need some rework in the bus files to fit this new
> hierarchy, but it may allow to keep netdev and wlan unaware of the device type,
> and since wilc3000 has bluetooth, it may also make it easier to introduce the
> corresponding support later. What do you think about it ? Ajay, any opinion on
> this ?

I did something like that for KSZ8851, that had bus-specific ops. I 
vaguely recall there was feedback that the function pointer indirection 
had non-trivial overhead due to spectre mitigations, and in case of the 
handle_txq() here, the chip specific ops would be called in a while() {} 
loop.

I can imagine some of the long functions like wilc_sdio_clear_int_ext or 
the handle_txq could be split up a bit, but likely only by factoring out 
some of the code into static functions. But looking at this closer, both 
pieces which are wilc1000/3000 specific in those functions manipulate 
with variables which would have to be passed in into that factored out 
code as function arguments, so I am not sure if this would improve 
readability by much either.

[...]

