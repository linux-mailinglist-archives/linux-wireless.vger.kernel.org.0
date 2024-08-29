Return-Path: <linux-wireless+bounces-12198-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C2F963855
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2024 04:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C67862860EA
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2024 02:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A1144C77;
	Thu, 29 Aug 2024 02:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="XRWcuxZS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4C31CA85
	for <linux-wireless@vger.kernel.org>; Thu, 29 Aug 2024 02:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724899652; cv=none; b=IM4PsXdPYkBi63hZJb25nzRbkVeRV1zUWo4PuzUWOLklem+X+q+YUo5C/YA4WSkOIdqYNjyyTa8d66VvoDokeCxtEoITiSP3xivPm+4t8lctdWCG5W+vGgNT4gko55tvJ7c81NesGPct+dU/lW4bW1BqvihAaT/cn5fd6yI+hvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724899652; c=relaxed/simple;
	bh=uUqhpps80VJEzgbok64iq8mWJaGI/SQdITUHdKBhB5o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=f29eC4m3mAMXZrdGUWRaR9bxHyUEroV7j2Db8US5Ayp0rJHV9HVBDQIz2w3w4TZBhkKC58abhF9nyiagcYv42oSDjf/vxogOLk2sjTD48+Oqg0qs6t9havF0T3dvgYPM/BJmV1ucCYf6X/FDbIwGIMAcxKyERM3hYfDu7UDu9+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=XRWcuxZS; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id BF1FD88A43;
	Thu, 29 Aug 2024 04:47:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724899645;
	bh=tO18a5tCYIOCv+JXh7RJFOynQdzfa8USyrmdhna+tuA=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=XRWcuxZSi4vAFO47H+32WRUq+SfutJ24aa4yyHtlF25q/Rd9PnuqzJyTAG8raOYAi
	 heVrfn6fhGCGxFYyjDmAOfIXDzLgl+6EiFj+9xY0g+rGYWLTZ9cfy6fH8yJZAEGHA7
	 Mx4ELNheGBaBGJP17/Ae8br9QuFWyhL3XjPsL6BuYx8F/7PgoSE/ya3Glk8S7UUS+N
	 f5z5ua25iTQCUvOdpqfoJY4yuDswa3ZukHP+OU2DzCbkbqFLdeVAhbFrSv4MjIpOSr
	 mug0d9jGLuFiFBBMTYcAFiLGk2+9/+kka2YjEZGh8OnSZo+t0IclyjlgQ9YkzaqR5a
	 9DtfoCcL6J0qw==
Message-ID: <5229bc7c-564d-4195-a6ff-579dbe5c3a49@denx.de>
Date: Thu, 29 Aug 2024 04:45:49 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] wifi: wilc1000: Keep slot powered on during
 suspend/resume
To: Ajay.Kathat@microchip.com, alexis.lothore@bootlin.com,
 linux-wireless@vger.kernel.org
Cc: claudiu.beznea@tuxon.dev, kvalo@kernel.org
References: <20240821183823.163268-1-marex@denx.de>
 <a9e673b1-43f3-4341-a035-3e1265b8a544@bootlin.com>
 <60a52cac-964e-40d6-aa96-7bbf34d9c4ac@denx.de>
 <63266019-bbf0-4f26-9700-e0303a892b2b@bootlin.com>
 <0518770b-8975-4681-a32e-e82f540d9a73@microchip.com>
Content-Language: en-US
In-Reply-To: <0518770b-8975-4681-a32e-e82f540d9a73@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 8/29/24 3:45 AM, Ajay.Kathat@microchip.com wrote:
> Hi,

Hi,

>>>> This change breaks suspend/resume on my wilc1000 setup (sama5d2 wlsom evk +
>>>> wilc1000 sd):
>>>>
>>>> # echo mem > /sys/power/state
>>>> PM: suspend entry (deep)
>>>> Filesystems sync: 0.055 seconds
>>>> Freezing user space processes
>>>> Freezing user space processes completed (elapsed 0.018 seconds)
>>>> OOM killer disabled.
>>>> Freezing remaining freezable tasks
>>>> Freezing remaining freezable tasks completed (elapsed 0.006 seconds)
>>>> wilc1000_sdio mmc0:0001:1: sdio suspend
>>>> wilc1000_sdio mmc0:0001:1: PM: dpm_run_callback(): pm_generic_suspend returns -22
>>>> wilc1000_sdio mmc0:0001:1: PM: failed to suspend async: error -22
>>>> PM: Some devices failed to suspend, or early wake event detected
>>>> OOM killer enabled.
>>>> Restarting tasks ... done.
>>>> random: crng reseeded on system resumption
>>>> PM: suspend exit
>>>> sh: write error: Invalid argument
>>>>
>>>> But I have to dig more to really understand the root cause.
>>>
>>> Does your MMC controller struct mmc_host set .pm_caps |= MMC_PM_KEEP_POWER ?
>>> Maybe that's the problem, that the controller does not set these PM caps ?
>>
>> It looks like you are right, my sdmmc controller was missing some
>> keep-power-in-suspend flag in my device tree, preventing your change to work on
>> my platform. So it behaves correctly for me with both wilc1000/wilc3000, thanks.
>>
>> Looks ok for me, but others may have a more informed opinion than me about the
>> impact of this change.
>>
> 
> When the host suspend is triggered, the WILC power consumption should be
> reduced since it is controlled via chip_allow_sleep() sequence which is
> irrespective of MMC_PM_KEEP_POWER flag state of the host. So I'm not sure why
> there was no difference observed in Marek's setup.

I think you misunderstood the patch description, there is no measurable 
power consumption difference with/without this patch. The chip does 
either get powered off (without this patch) or enter some sort of low 
power state (with this patch), which I can see on the drop in power 
consumption during suspend/resume.

This patch assures the chip does not get power-cycled during 
suspend/resume cycle, which makes it lose state (and firmware), so the 
chip is unusable after resume without this patch.

> It may be that when the
> power consumption was measured,the WILC suspend state is not enabled because
> of MMC controller pm_caps in the test setup.
> 
> I think it is better to have a generic patch for any host which has
> MMC_PM_KEEP_POWER capabilities defined or not. With proposed patch, driver
> will not allow the host to go into the suspend state when MMC_PM_KEEP_POWER is
> not set in PM caps. I think, sdio_set_host_pm_flags() should only be called if
> MMC_PM_KEEP_POWER is defined in the host.

To retain firmware in the chip, the chip must not be powered off during 
suspend/resume, which is what this patch assures. Without this patch, 
the controller may power off the slot during suspend/resume and the WILC 
will lose firmware and be unusable after resume.

> Actually, WILC can support suspend mode with or without this host
> capabilities. For SDIO, the host can be wake-up using the external IRQ GPIO
> (uses out-of-band, instead of in-band interrupt) on WILC.
> 
> To test wake-on-wlan(wowlan) in suspend mode, the IRQ pin from WILC should be
> connected with the host that will help to interrupt/wake the host when any
> WiFi packet arrives. Without 'wowlan' enabled in suspend mode, the host should
> be allowed to go into suspend mode but it can't be wake-up by WiFi packets.
> All the packets will be dropped in the firmware in suspend state.
> 
> WILC supports only ANY option for wowlan. So, after connecting the IRQ line
> with host, the below commands can be used to test "wowlan" in suspend state.
> 
> 
> #  iw phy <phyname> wowlan enable any
> #  echo mem > /sys/power/state

If the WILC is powered off because the slot is powered off, WILC cannot 
resume anything.

