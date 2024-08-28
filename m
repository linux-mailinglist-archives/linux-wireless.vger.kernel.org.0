Return-Path: <linux-wireless+bounces-12125-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCAE962194
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 09:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 948D31F262AF
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 07:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F9B15AAB1;
	Wed, 28 Aug 2024 07:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OwV8opkS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF0115530C
	for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 07:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724830950; cv=none; b=Pbg/Wqttf81dRef8xYZZnrn8cHAMf1H+uv68qoUmGi4Ub3zDPU9fcild0auPemp+D7lat7KMNGdOjCIatOpg75gQ1udgp8Yc4yBfYsoNyveVNeBmicmDL+dvk7nF8nujKzg8RIlqSQIWT8deB6w9wiXW09rdh0/EXKXdDt9VKQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724830950; c=relaxed/simple;
	bh=uCnqNWpmsMaqc8smuRo0gulQiRa0hwlUNVgs+pxkSJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oi8WOeDG11CucawgyPEaHDflcIgxDnbVl6CLmMDvZz+slUj7jzpAkyTTYQALZ7nk21Hpx97Kyd5IwJDZ+PIQei9FcMMnabDtSYqgeu0BOYobVbQujR6i2l5saMonGxaGut9RU/Jp03tZFJYqRywQvJhbLcB8nhhf2jbhjualp20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OwV8opkS; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6AB041C0006;
	Wed, 28 Aug 2024 07:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724830939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NXKByWU8vF5xjRKKZxsI08EpgTiwo/IptfrcvxAEFRg=;
	b=OwV8opkS/MkcBfG6uX2HYo9Vk+g1jCSRzjgB2kzIrzOH68j2hSTyisOsJ1Jyi0qhqsh23L
	hkr0QruCgJsAV+hXDnMsqlU5YWGUlr2U+QYa836cAIhClmIUAeQTxPeysJwO3O/w5ylij6
	Ep9kDmjRGWwvhbJPwR5cKahXe0ZtqDvAb+F3PHtP8vZPV8hTbTAJLd5daiysfSMFJTTMnf
	U2kBDMIGf2YmXoza3x5EJ8tIpdmIUlx/qQS/x1kLpOPqFgRvsRyZvP34fGblgqfmixdPph
	r4ZjKTR8KQq5wupjUo/vp/gAd1lS9jZo/l5r33luPY3q3V94ImZvcYQr7yraSw==
Message-ID: <63266019-bbf0-4f26-9700-e0303a892b2b@bootlin.com>
Date: Wed, 28 Aug 2024 09:42:19 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: wilc1000: Keep slot powered on during
 suspend/resume
To: Marek Vasut <marex@denx.de>, linux-wireless@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>
References: <20240821183823.163268-1-marex@denx.de>
 <a9e673b1-43f3-4341-a035-3e1265b8a544@bootlin.com>
 <60a52cac-964e-40d6-aa96-7bbf34d9c4ac@denx.de>
Content-Language: en-US
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <60a52cac-964e-40d6-aa96-7bbf34d9c4ac@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 8/27/24 17:20, Marek Vasut wrote:
> On 8/27/24 11:53 AM, Alexis Lothoré wrote:

[...]

>>> -    return 0;
>>> +    return sdio_set_host_pm_flags(func, MMC_PM_KEEP_POWER);
>>>   }
>>
>> This change breaks suspend/resume on my wilc1000 setup (sama5d2 wlsom evk +
>> wilc1000 sd):
>>
>> # echo mem > /sys/power/state
>> PM: suspend entry (deep)
>> Filesystems sync: 0.055 seconds
>> Freezing user space processes
>> Freezing user space processes completed (elapsed 0.018 seconds)
>> OOM killer disabled.
>> Freezing remaining freezable tasks
>> Freezing remaining freezable tasks completed (elapsed 0.006 seconds)
>> wilc1000_sdio mmc0:0001:1: sdio suspend
>> wilc1000_sdio mmc0:0001:1: PM: dpm_run_callback(): pm_generic_suspend returns -22
>> wilc1000_sdio mmc0:0001:1: PM: failed to suspend async: error -22
>> PM: Some devices failed to suspend, or early wake event detected
>> OOM killer enabled.
>> Restarting tasks ... done.
>> random: crng reseeded on system resumption
>> PM: suspend exit
>> sh: write error: Invalid argument
>>
>> But I have to dig more to really understand the root cause.
> 
> Does your MMC controller struct mmc_host set .pm_caps |= MMC_PM_KEEP_POWER ?
> Maybe that's the problem, that the controller does not set these PM caps ?

It looks like you are right, my sdmmc controller was missing some
keep-power-in-suspend flag in my device tree, preventing your change to work on
my platform. So it behaves correctly for me with both wilc1000/wilc3000, thanks.

Looks ok for me, but others may have a more informed opinion than me about the
impact of this change.

Thanks,

Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


