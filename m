Return-Path: <linux-wireless+bounces-15326-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 199169CE153
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2024 15:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2E491F20F63
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2024 14:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AEF1BDAAF;
	Fri, 15 Nov 2024 14:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="P50ODpCV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D283A1BF;
	Fri, 15 Nov 2024 14:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731681253; cv=none; b=jdn+rxZ0Q9aaoBYCfaCFuxO82QbW3fUhKz6zHfyWC8bezAEeyFcTeYiGorRw5o+gWrYW9IvjcSsfdQ3ielywfwsLqqFzr6JIS4++9zbca1Q1OdEYOGHBUHkyr2X2cOyOocmuuT1iktkrwCLndKglxvgHJQervW2zeElVubpn4GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731681253; c=relaxed/simple;
	bh=zWFX2tUCt5gRVS/WKP2q9JAATNdCQBEJW3R8bpJZ4BI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VBEjElR4HWfXLEaBtF8V5b/TYEZ/vTozNZgblt3gjfsQKqqU8nS9ubD505BFxxyndEHGRM+v7d3GCMEx8WRbmNk+Co7Fgcv/yp3NzEfKLgk2EZL0KFosyXIb/YtaMGL2SGgfJeOIqmh4pt1GfG+IMbop9lmitOzubaloLPMNBSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=P50ODpCV; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 2D63788C4D;
	Fri, 15 Nov 2024 15:34:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731681249;
	bh=FnufdwssipE6MronlZn8ANtj66OQzimJrDLQq6f0j2w=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=P50ODpCVa/F9Ycy8dQtFaP7F5OUfQYSHBrdRxYjycrD5htBtNLvVV8Al3Gt2JbeX0
	 5aPmcb9AVe27CD5etvDT/XUiiPMEUrtoVTTzbNdlSUY1jiDjkquGjqlt4CHy5gX24U
	 +Dt8Ay9zQOzZj16Ta9fy9rTps7tcPrrOVcwYbs97GQ0cQq9sOfD864/PXcEajhGewe
	 bEelSinYWtcanBbLQA8Pu3f1M/r0zwlHnCfPtgzIezs1JasOLpP4Tv2VPfRKI4bSV/
	 s0ZM7onkXpdwWZarT6xnjfrAr1b1lqfpDU3v30hJp7NXcbqD8WIy5o+WQ0CceljKSa
	 N/M+fRXzcLDRA==
Message-ID: <260a505e-53ec-4f1d-94fe-2b71af48f1b7@denx.de>
Date: Fri, 15 Nov 2024 15:33:30 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: wilc1000: Rework bus locking
From: Marek Vasut <marex@denx.de>
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
 <fcdfa93a-2db4-49ad-8947-ca43be329250@denx.de>
Content-Language: en-US
In-Reply-To: <fcdfa93a-2db4-49ad-8947-ca43be329250@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 11/7/24 5:10 PM, Marek Vasut wrote:
> On 11/7/24 2:28 AM, Ajay.Kathat@microchip.com wrote:
>> Hi Marek,
> 
> Hello Ajay,
> 
>> On 11/4/24 04:44, Marek Vasut wrote:
>>> EXTERNAL EMAIL: Do not click links or open attachments unless you 
>>> know the
>>> content is safe
>>>
>>> On 10/23/24 8:47 PM, Marek Vasut wrote:
>>>
>>> Hello again,
>>>
>>>>> Is power-save enabled during the test. With PS enabled, The SDIO
>>>>> commands may
>>>>> fail momentarily but it should recover.
>>>>
>>>> It seems it gets enabled after first ifconfig up, that's a good hint,
>>>> I'll try to disable it and see if that makes them errors go away. 
>>>> Thanks!
>>>>
>>>> Do you have any details on WHY would such sporadic errors occur and how
>>>> to make those go away even with PS enabled ?
>>> Can you explain why does uAPSD (iw ...set power_save off) adversely
>>> affect SDIO bus stability ?
>>>
>>
>> SDIO bus errors can occur for different reasons and those errors can 
>> be of
>> recoverable or non-recoverable type. For non-recoverable failures like
>> firmware crashes, the retry mechanism may not help to resolve the 
>> issue. If
>> the error is recoverable then driver should work with retry attempts.
>> I think you are observing the bus errors messages and it is recovering 
>> after
>> that. Is my understanding correct?
> 
> I don't know. Is there any way to make the WILC firmware produce debug 
> output , so we can figure out what is going on "on the other side" ?
> 
> Are you able to provide me (maybe off-list) some debug firmware build ?
> (or can I get firmware sources and build and debug my own WILC firmware 
> on the Cortus CPU?)
> 
>> With the previous shared test procedure, which makes the interface up/ 
>> down
>> continuously, the station may not go into the Doze/Awake sequence 
>> since that
>> mode switching gets activated after connection with AP.
> 
> What does this mean ? I can trigger the SDIO errors even without being 
> connected to any AP , so this is something between the WILC and the SDIO 
> host, the radio is likely not involved , right ?
> 
>>> Can you explain how to prevent that or shall we disable uAPSD 
>>> altogether ?
>>
>> Could you please share the test procedure and logs. I am occupied at the
>> moment but I shall make some time to look into it and get a better 
>> understanding.
> 
> The simplest test procedure is this:
> 
> $ while true ; do ifconfig wlan0 up ; ifconfig wlan0 down ; done
> 
> As for the logs, MMCI controller sporadically reports either Command or 
> Data CRC error, so likely the SDIO response (from WILC to Host) is 
> corrupted.

Are there any news ?

