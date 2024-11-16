Return-Path: <linux-wireless+bounces-15420-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A879D00C0
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Nov 2024 21:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAA77B21613
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Nov 2024 20:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCFD194C78;
	Sat, 16 Nov 2024 20:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="JQOZxKP3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C5D1946AA;
	Sat, 16 Nov 2024 20:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731787665; cv=none; b=No6rwdoVeUkOjRgCg2sExtSKyfSAA9jGpdk+wwpE59ZJXGEpJRNh9pF0Q+6npJD+zKotJrLMNxKDNWTdVVAz697PxV3VAWVyOl/8Kt/hkKK6Sx1VavpjVp5HhciO4wY0HAL+42JFPIz+/3KY2S0k8BQuvCSiBkOAt5CWCh4QFQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731787665; c=relaxed/simple;
	bh=5rtxGu68PLWrXyTEJNBr68hhrntpwpZdOSN9YWdsbfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qxiVqSsmdln+TjVfPRmDgwPyjT3nA7y3o5lzewuNKz/WLYdmENM+91eclN2OSQ85pNrv+VNgnLfiWULn69XiWdN01myxb8V8dnYLolXF2K93rwmABeR6RSQlJJLuk67IDnkt2mzYgJsuQtoozXZokA9tbqaByVGwNJIlLjCb01I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=JQOZxKP3; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 40BBA89698;
	Sat, 16 Nov 2024 21:07:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731787655;
	bh=msWG5qnuSAmchrjZIHWSe5yibi3jg0xEpfJtIVvoQA0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JQOZxKP3VnpaHDzeb2po7GNni8qWiMQve1IWLtAaq1+5mSjtN24PUPimlzF/6AHC1
	 U8a+ONq23zJkAah8DAfn22UvOArHyWcUDdkBSWpKHFlb6IY8OYZmywqxK4Q3295oFF
	 fPv6GRs5arWYat28D4lnKYRN1DAbvUdj5ndlmYt9fsGrMWp+Ld34ORgN+sVhT0r5Qv
	 qyr5Bb6JCRB98vN4avDSYVag8IDSLlol/nUZRmeok5Yrn1pzUg3Da6UxSnhJUFCLM3
	 mLOGXtKy2197fkhOCAXvKQuWikwhkiqxMNKQxZsDmMs+clqx+AH4W0ISuqxOI+XUj1
	 Udg2euHimVxRw==
Message-ID: <b287f8f9-600e-4e69-b7ec-25990275575e@denx.de>
Date: Sat, 16 Nov 2024 20:57:36 +0100
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
 <fcdfa93a-2db4-49ad-8947-ca43be329250@denx.de>
 <260a505e-53ec-4f1d-94fe-2b71af48f1b7@denx.de>
 <b61b5b11-b078-4cf5-bb40-7c3ff8ffa972@microchip.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <b61b5b11-b078-4cf5-bb40-7c3ff8ffa972@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 11/15/24 9:04 PM, Ajay.Kathat@microchip.com wrote:

Hello Ajay,

>>>>> Can you explain how to prevent that or shall we disable uAPSD
>>>>> altogether ?
>>>>
>>>> Could you please share the test procedure and logs. I am occupied at the
>>>> moment but I shall make some time to look into it and get a better
>>>> understanding.
>>>
>>> The simplest test procedure is this:
>>>
>>> $ while true ; do ifconfig wlan0 up ; ifconfig wlan0 down ; done
>>>
>>> As for the logs, MMCI controller sporadically reports either Command or
>>> Data CRC error, so likely the SDIO response (from WILC to Host) is
>>> corrupted.
>>
>> Are there any news ?
> 
> I did test the same procedure in my setup, but I couldn't reproduce this issue
> even after running it for a long duration. In my test setup, I used the
> sama5d27-som1-ek1 host and wilc3000 firmware version 16.3.
> 
> I think this issue could be related to the host MMCI controller driver.
> Normally, the wilc SDIO bus failures are captured by driver logs with an error
> code (e.g., timeout), but if the MMCI controller is outputting the warning
> message, then the error could be related to it. Does the MMCI controller error
> point to any specific function?

Either CMD52 or CMD53 errors out with CRC error, this is recognized by 
the controller. That points to sporadic CRC error during SDIO transfer.

> Which host was used to test this scenario, and
> is it possible to test with different host or different configuration on the
> same host

I am observing sporadic command and data CRC errors on STM32MP157F 
system with SDIO WILC3000.

, like disabling power save on the host?
I already tested disabling power save.

Can you explain why does uAPSD (iw ...set power_save off) adversely 
affect SDIO bus stability ?

Can you explain how to prevent that or shall we disable uAPSD altogether ?

Is there any way to make the WILC firmware produce debug output , so we 
can figure out what is going on "on the other side" ?

Are you able to provide me (maybe off-list) some debug firmware build ?
(or can I get firmware sources and build and debug my own WILC firmware 
on the Cortus CPU?)

I can trigger the SDIO errors even without being connected to any AP , 
so this is something between the WILC and the SDIO host, the radio is 
likely not involved , right ?

