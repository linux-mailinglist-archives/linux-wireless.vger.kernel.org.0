Return-Path: <linux-wireless+bounces-12610-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 871B896FB46
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 20:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B273C1C213CE
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 18:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74906823DF;
	Fri,  6 Sep 2024 18:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="OPqWp21U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02B4224D7
	for <linux-wireless@vger.kernel.org>; Fri,  6 Sep 2024 18:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725647816; cv=none; b=upGVu+I3P+Ts8qy6P4qTP3pkVcYg7DfQ24wRP2Qt4qsDBYNqX6YWsR4NczPxDRyZB4sNfTEZP78CTz47ITWGNthJ/9EiVAYrfL2BYngtcMeYaqJ29D15Q3k8HRKUd6YipZGlVLGFP73CL4uASgAFsrndC1sNLZCHcoqqCUDz9RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725647816; c=relaxed/simple;
	bh=GYisDck8zJOGRcjl5UlpN1CH818QfkBGQ9AO7mJTd94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kkEp1KULRMErcs4r8wvIC9Ae+07t7/G7T8Hu56CS74tytbX8n0gJTuYHSQglRY/L+0wbzP4cKyz1yaZLU/qFsgJe+T4V2Aya4vQI6FTKaQJdd0HoJpDQMT7twBZSNPGYL4+srIDKdoGTb8K7ZpsDoG+OMlVHIuh1fk9oZsMPkII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=OPqWp21U; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id BAD7E88D29;
	Fri,  6 Sep 2024 20:27:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725647221;
	bh=4u7XveVPUEdkxisZE03JxFsS4Sn2jUuvjkarTFfgmaU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OPqWp21URfGSxei/Cl4QMh3Jk/et1I7erizMw30rGxz8wkMxgGKgptGWcvRe05cp8
	 O80WwbLJ14gMc+qacuNWhVibAszLz8Vg78zgW3Oo1NhPXgeqI+e/g/snjjVU/pn4mE
	 D1HITOag9KnqxyDC+upKZGVvsW5YfZn6E1BB9fmY4GGZI9EU9J7hfuJb4ksraWRYRF
	 xmCEwEmtaWJ7ALS+RluuTjJNjjYT4s+5fjjFmWey8IUH0ICKSCwp2pC29LULeN/Ziv
	 Lt+4PKKMxNw6+sLbB/J9ymwI9wlr039Tyy08yKQDkzO4FnlyTUo9q/TbQ/QBT13Iz6
	 c+ZSly79Edfig==
Message-ID: <49541dc5-e2ab-4d7d-aaa8-ae76e580a39e@denx.de>
Date: Fri, 6 Sep 2024 20:23:13 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: wilc1000: Keep slot powered on during
 suspend/resume
To: Kalle Valo <kvalo@kernel.org>
Cc: Ajay.Kathat@microchip.com, alexis.lothore@bootlin.com,
 linux-wireless@vger.kernel.org, claudiu.beznea@tuxon.dev
References: <20240821183823.163268-1-marex@denx.de>
 <a9e673b1-43f3-4341-a035-3e1265b8a544@bootlin.com>
 <60a52cac-964e-40d6-aa96-7bbf34d9c4ac@denx.de>
 <63266019-bbf0-4f26-9700-e0303a892b2b@bootlin.com>
 <0518770b-8975-4681-a32e-e82f540d9a73@microchip.com>
 <5229bc7c-564d-4195-a6ff-579dbe5c3a49@denx.de>
 <ae40b138-77ad-4044-9448-784be6964195@microchip.com>
 <12b79e2b-08ca-4ba0-8abb-6f1d0be65b3c@denx.de> <874j73e1dp.fsf@kernel.org>
 <5ba25a08-dc7f-4eb6-8982-e7a246178ba0@denx.de> <87ed62kodu.fsf@kernel.org>
 <2d5f4d63-ab91-40d6-ae0c-81d4bc847fbf@denx.de> <87tteuimqc.fsf@kernel.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <87tteuimqc.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 9/5/24 9:27 AM, Kalle Valo wrote:
> Marek Vasut <marex@denx.de> writes:
> 
>>>>> Are you also taking into account hibernation? During hibernation the
>>>>> device will be powered off. I can't remember the details right now but
>>>>> wanted to mention this.
>>>>
>>>> I don't think I am. Isn't hibernation actually a full shutdown, so the
>>>> hardware does get reinitialized ?
>>> I don't know how it works exactly nor what you exactly mean with
>>> reinitalized.
>>
>> My understanding is that hibernation is suspend-to-disk, isn't it ?
> 
> Yes, that's what I mean.
> 
>> (that's not something that is even available on my hardware)
> 
> Yeah, I'm guessing wilc1000 is used more in embedded enviroments where
> hibernation is not really an important, it's used more in laptops. So I
> guess it won't be a big problem if wilc1000 doesn't support hibernation
> but please try to keep it in mind still.
> 
>> Doesn't the hardware get completely turned OFF during suspend-to-disk
>> and then turned ON (and therefore initialized again) on
>> resume-from-disk?
> 
> I'm not sure how it works exactly but my experience is that for
> hibernation a driver cannot assume that the firmware is running during
> resume.
> 
>>> But at least with ath11k hibernation didn't work when it
>>> left the firmware running during suspend.
>>
>> Is there a thread on lore or some details of this you could point me to?
> 
> See commit 166a490f59ac ("wifi: ath11k: support hibernation") and the
> commits before that. I'm sure that there's more info about hibernation
> but don't have any pointers.

Ah, thank you.

The firmware reloading support should be addressed by some sort of 
future variant of patch Ajay sent as attachment in [1], that should then 
also deal with the hibernation part. I asked them to post the patch 
properly to the ML.

What about this patch, it fixes suspend/resume for me and with a fix to 
the atmel controller I suggested to Alexis in this thread, it should not 
have any adverse effects .

[1] 
https://lore.kernel.org/all/2bbdc690-aec5-4a11-893e-01270c6d5b84@microchip.com/

