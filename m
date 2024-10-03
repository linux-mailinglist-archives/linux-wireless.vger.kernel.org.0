Return-Path: <linux-wireless+bounces-13471-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1329898EFD8
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 14:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B816A1F23C16
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 12:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D283E1922CA;
	Thu,  3 Oct 2024 12:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cVfrwbep"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E324148823
	for <linux-wireless@vger.kernel.org>; Thu,  3 Oct 2024 12:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727960296; cv=none; b=DgJMXjVfxFZ1DhMcZNF0VNX+C1Ui97hy8C91aIJOIiPy/jQyTfEqVtLiISBf+M1AnT6s6Mf9E6aicaAxvvzCnYPwd5lRch3UuX1lfyeA1D9HZKLxj7K3SD9IrydPe+qbpNRCnmlHimV4IzjNh6OOnfNvy5aSSS/fxSZDdOB8i5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727960296; c=relaxed/simple;
	bh=EHC9K7LC/KapwhfkbDv0Sja397CEQF2+Ey5WtGCNpFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J6Lso1b6Ax+co13ILEQiC/l+p7xoCKx8K/x1pTJd8mmYrrBLcLK7hodetp08tTeWMEKHhKjjjbnviUNulUCymBzUGJQbdZyAACmRIIs8Z3Da3dY+NXacEMJdD3hjkvScz/7hJ7Y2G4VJHtWyRVYunCJ2AwLMvEeRFXhMeAayGcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cVfrwbep; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D8DAAE0003;
	Thu,  3 Oct 2024 12:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727960287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oIQYycru0zgI2gSkCuHj6lz72C0LaYrUVpc7oMXOY30=;
	b=cVfrwbeps6AQ2xQbf0h1ImlaKsTCcxp+dBuGjWm18DY8EZTU8x9bzkgzjz7SKF+uJCTBn9
	103Jj+Ki7TqgIo/Rbzic8DIwx0jxvIzSHF6YNyMrzowyYakljsyKnXR1ETm59hPL2yZs8m
	KaQlObU0o2jHK3UVw4/yuLX5V423uQpiJWx8qH+WanmDVAIEDuXos/6Sz4rRcXdeqSjDCK
	b2bb+/RGby7XqoiUZ2WPm4odL7HW9lcZTWjxLizosE8HeySfpb4nbJDd7hqp8GHqhD1miU
	yAg5UVlL8HqGz66rUXTclgl1v4xJO/HBKPMt3FjaMFz1h5PkFA+OcMo2aqIDGA==
Message-ID: <923ee7fa-d7fe-40b4-802a-b89d9b84c20d@bootlin.com>
Date: Thu, 3 Oct 2024 14:58:06 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: wilc1000: Keep slot powered on during
 suspend/resume
To: Marek Vasut <marex@denx.de>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
References: <20240926195113.2823392-1-marex@denx.de>
 <87ed5481ro.fsf@kernel.org> <b3429a32-111b-4bab-9f4f-84c75bb3a049@denx.de>
 <372e6f65-79f1-4a64-a323-2939269a8a45@bootlin.com>
 <1e7351db-366b-4e4a-b423-92867f24cbb5@denx.de>
Content-Language: en-US
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <1e7351db-366b-4e4a-b423-92867f24cbb5@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 10/3/24 12:49, Marek Vasut wrote:
> On 10/3/24 10:31 AM, Alexis Lothoré wrote:
>> On 9/29/24 17:23, Marek Vasut wrote:
>>> On 9/28/24 1:18 PM, Kalle Valo wrote:
>>>> Marek Vasut <marex@denx.de> writes:
>>>>
>>>>> The WILC3000 can suspend and enter low power state. According to local
>>>>> measurements, the WILC3000 consumes the same amount of power if the slot
>>>>> is powered up and WILC3000 is suspended, and if the WILC3000 is powered
>>>>> off. Use the former option, keep the WILC3000 powered up as that allows
>>>>> for things like WoWlan to work.
>>>>>
>>>>> Note that this is tested on WILC3000 only, not on WILC1000 .
>>>>>
>>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>>> ---
>>>>> Cc: Ajay Singh <ajay.kathat@microchip.com>
>>>>> Cc: Alexis Lothoré <alexis.lothore@bootlin.com>
>>>>> Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
>>>>> Cc: Kalle Valo <kvalo@kernel.org>
>>>>> Cc: Marek Vasut <marex@denx.de>
>>>>> Cc: linux-wireless@vger.kernel.org
>>>>> ---
>>>>> V2: Rebase on next-20240926
>>>>
>>>> BTW I recommend using wireless-next as the baseline for wireless
>>>> patches. For example, wireless-next is not pulled to linux-next during
>>>> merge windows or other patches in linux-next might create unnecessary
>>>> conflicts. Of course most of the cases using linux-next is fine.
>>> I didn't know there was one such tree, added to remotes, thanks !
>>
>> +1, as already mentioned in previous revisions, I would gladly test wilc3000
>> changes on both wilc3000 and wilc1000 on my platform, and having the series on
>> top of wireless-next would allow to do it on top of any change also affecting
>> the driver in wireless-next :)
> 
> I just had a look at a diff between wireless-next/main and next/master 20241003
> for drivers/net/wireless/microchip , there are no changes to the driver between
> the two trees, so it should be possible to test this patch on either tree. Can
> you give it a try ? Ideally test this patch separately on WILC1000 across
> suspend/resume and check if it works. You might need the MMC controller fix
> which sets struct mmc_host .pm_caps |= MMC_PM_KEEP_POWER for your controller ,
> unless this is already upstream.
> 
> The WILC3000 series depends on this patch.
> 
Meh, you are right, I have read too fast your answer to my initial question
about used base branch, and omitted the suspend/resume patch (I assumed it
conflicted because of some other patches in wireless-next).

Thanks,

Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

