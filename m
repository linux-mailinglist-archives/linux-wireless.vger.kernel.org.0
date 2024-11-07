Return-Path: <linux-wireless+bounces-15105-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC7C9C0B0C
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 17:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8B84B23F98
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 16:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C166216DE8;
	Thu,  7 Nov 2024 16:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="vqIW2SJA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609E5215F78;
	Thu,  7 Nov 2024 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995859; cv=none; b=pcWTuPcFWFaH7u2HB/j/dMfEdAwPWvUXDOAXxK0kOoetXszO95cLGTR6qllc3Sn24cqZoFwU8Ddw0wblQC6ExC882DY36ORPmtfL854H0i2Owg8PB8eeuoQ1dZlM1gXp/TvFAvn7OVy4nINf/5LawcuokUatibnMcAsiwxnQU5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995859; c=relaxed/simple;
	bh=A9w+u3CsqskKvuGeLw6D4GG/x+d1Y3h3vOx2YposhFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xvl/hQOfrp60PSmQZIZFvGkCX3dhTAi0ll/mUlDPNznF5HiCuKFfJdanFtdB0ZVBkrBue2Lp/0xHmsLbtp0Tl3+vmkegmJEJ4eaIhrLOnTDqiSKntplnwdraYRht82aezrWFdfdACE0sL/1+gF3LPc3AVGIgVNnel00oU2wD2QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=vqIW2SJA; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id BAF4188EFB;
	Thu,  7 Nov 2024 17:10:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1730995850;
	bh=tc9Yi/GcN5ZUBUaiPp9JFPJV349+IorIcrOsLbesgS8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vqIW2SJAS1XrOUfrR8XNirugxJLH7+gWouXUwJl9bVpZrJQy9YYzigwMpePr5X97o
	 oDxki4xEPXi0vtfT1HtB0x02X8yeWcLhMERGetNZDRUup9IRGKSYjWaV6hYRn/IEvD
	 wkbj4RrKKFE9Ry2VKFORTi9X8G93oSLf+Ed6eHT77xHkuibQ+XNjpXq5D5yjcVkVlm
	 Oymenkt/364BxAG2WsUXqDOFmWLGgW1cTEV/LXk8Az7My/Iul8T7H9lLWRWl2Y8CgG
	 hEW9R/a06g6CM9WVIuR8qYL2TyUhFnbmpczB2p4DQ3OPzuMKFhZc12/ch8soGwXmyA
	 uFue+xYdJHtPA==
Message-ID: <fcdfa93a-2db4-49ad-8947-ca43be329250@denx.de>
Date: Thu, 7 Nov 2024 17:10:13 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: wilc1000: Rework bus locking
To: Ajay.Kathat@microchip.com, alexis.lothore@bootlin.com,
 linux-wireless@vger.kernel.org
Cc: davem@davemloft.net, adham.abozaeid@microchip.com,
 claudiu.beznea@tuxon.dev, conor+dt@kernel.org, edumazet@google.com,
 kuba@kernel.org, kvalo@kernel.org, krzk+dt@kernel.org, pabeni@redhat.com,
 robh@kernel.org, devicetree@vger.kernel.org, netdev@vger.kernel.org
References: <20241022013855.284783-1-marex@denx.de>
 <c9e98811-15f5-427a-82f7-2e7fff4a9873@bootlin.com>
 <8e28ba76-ecfa-49b6-89b5-1edabb22129d@denx.de>
 <a4c8c489-c6b9-4a38-84ab-f08409baccff@microchip.com>
 <5e2a5056-78ac-4be0-83ca-4aa55f524535@denx.de>
 <880baad9-be3d-41b2-bea3-620f915ca397@microchip.com>
 <9d20b408-72a4-49f0-aca6-108dfdd65f99@denx.de>
 <16e5c8d7-64ac-424e-9430-b683ae16a34e@denx.de>
 <9888f605-ee68-4bd3-8d1d-aeef247d23d0@microchip.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <9888f605-ee68-4bd3-8d1d-aeef247d23d0@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 11/7/24 2:28 AM, Ajay.Kathat@microchip.com wrote:
> Hi Marek,

Hello Ajay,

> On 11/4/24 04:44, Marek Vasut wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the
>> content is safe
>>
>> On 10/23/24 8:47 PM, Marek Vasut wrote:
>>
>> Hello again,
>>
>>>> Is power-save enabled during the test. With PS enabled, The SDIO
>>>> commands may
>>>> fail momentarily but it should recover.
>>>
>>> It seems it gets enabled after first ifconfig up, that's a good hint,
>>> I'll try to disable it and see if that makes them errors go away. Thanks!
>>>
>>> Do you have any details on WHY would such sporadic errors occur and how
>>> to make those go away even with PS enabled ?
>> Can you explain why does uAPSD (iw ...set power_save off) adversely
>> affect SDIO bus stability ?
>>
> 
> SDIO bus errors can occur for different reasons and those errors can be of
> recoverable or non-recoverable type. For non-recoverable failures like
> firmware crashes, the retry mechanism may not help to resolve the issue. If
> the error is recoverable then driver should work with retry attempts.
> I think you are observing the bus errors messages and it is recovering after
> that. Is my understanding correct?

I don't know. Is there any way to make the WILC firmware produce debug 
output , so we can figure out what is going on "on the other side" ?

Are you able to provide me (maybe off-list) some debug firmware build ?
(or can I get firmware sources and build and debug my own WILC firmware 
on the Cortus CPU?)

> With the previous shared test procedure, which makes the interface up/down
> continuously, the station may not go into the Doze/Awake sequence since that
> mode switching gets activated after connection with AP.

What does this mean ? I can trigger the SDIO errors even without being 
connected to any AP , so this is something between the WILC and the SDIO 
host, the radio is likely not involved , right ?

>> Can you explain how to prevent that or shall we disable uAPSD altogether ?
> 
> Could you please share the test procedure and logs. I am occupied at the
> moment but I shall make some time to look into it and get a better understanding.

The simplest test procedure is this:

$ while true ; do ifconfig wlan0 up ; ifconfig wlan0 down ; done

As for the logs, MMCI controller sporadically reports either Command or 
Data CRC error, so likely the SDIO response (from WILC to Host) is 
corrupted.

