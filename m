Return-Path: <linux-wireless+bounces-12288-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A91AF967353
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Aug 2024 23:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBF331C20E2F
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Aug 2024 21:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01E515C156;
	Sat, 31 Aug 2024 21:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Rem7GAXU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D316FCC
	for <linux-wireless@vger.kernel.org>; Sat, 31 Aug 2024 21:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725139141; cv=none; b=ILxrworJQ1knvwUiQHBb6yAaRAcwm56aqPrLSCZrz8qlS8uRppZu0vUL0ZyYgV2srSQyfJWKcfbw60Nlg3aFqt/xYJOs385zMkI8pgIiIkc76HQ+USLLHKmdYl4Q7ubWktaWe1XSjZAjtT9ZuIqTdR338Ji/p8NB0kVweKcfPo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725139141; c=relaxed/simple;
	bh=QuBLYFt0zQinL+hpzSy8hwMn5QFpZPH6AKeWKOSBVcg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pMTJoZaILrljXjffjp9xsPku1+7YJ+lGDYHdGVzw9NvT0C2lCOyGKkr8UkHTT4lsXNh6ks84wqPCROrM5olYhkY0OVy4dt2uee5ZnlPy/MEdXuxbpPRRsIKaH8zMJSetS17L0N7TmGzAKm6LpN5J0DMByO1Ko6Z0dXDBQ4WG8Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Rem7GAXU; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 55FD988D82;
	Sat, 31 Aug 2024 23:18:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725139131;
	bh=wXmW9CHiwXc3NQCm+ZTLoY4oG2IX2sM12DoJQiH7GkE=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=Rem7GAXUstHRKcilM8avMeCWHPRVRE7X/E8vaqnWewiuTgf7Zg58ol7BNxjAkw8Z/
	 YfYao3N02MN63KvK8nOnLsmPae+hFBAD03fDxsEHCetFDHD4VnT2YAhPg04w4aiYKX
	 MMop9jHYR3VeY4pEiWVNXZ7EQ104xMFMRBD0eFYLikdAcl3jazKILUUjTOHxj/22kI
	 rPZQJdVWqRNhZEqkldJYlWF6V3DaGwPmeqykf+PbuZD/jK5ASQeKGHsTXn6YZKWNZn
	 hRLqfqEVX2HahTGygFVS7dVaA7VPpIl6bRjPlFkvQOYqyQL2rUrKhF0rqkuiQg+ZMW
	 GHUsrO8mdzA0Q==
Message-ID: <302ea6b5-1625-4d4c-8866-c8c35f489fbb@denx.de>
Date: Sat, 31 Aug 2024 23:18:24 +0200
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
 <5229bc7c-564d-4195-a6ff-579dbe5c3a49@denx.de>
 <ae40b138-77ad-4044-9448-784be6964195@microchip.com>
 <12b79e2b-08ca-4ba0-8abb-6f1d0be65b3c@denx.de>
 <2bbdc690-aec5-4a11-893e-01270c6d5b84@microchip.com>
Content-Language: en-US
In-Reply-To: <2bbdc690-aec5-4a11-893e-01270c6d5b84@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 8/31/24 7:22 AM, Ajay.Kathat@microchip.com wrote:
> Hi Marek,

Hi,

>>> 2. With this patch, does the ping to the station work during the suspend state?
>>
>> I haven't tested this, but that's unlikely because the host is
>> suspended. Still, that's not really the point here, the point is that
>> the whole WILC gets powered off during suspend/resume without this
>> patch. At least on STM32MP15xx it is, maybe on the Atmel controller it
>> is not, but we cannot depend on that.
> 
> Indeed, you are right. It seems, the test results have dependency on the host
> controller power management behavior. In my setup, the card keep the power,
> when the host is suspended.

Right, currently the driver depends on the controller behavior and it 
works by accident with the atmel controller. This patch fixes that and 
assures this will work on other controllers too.

>>> AFAIR, during host suspend, the firmware continues to run without passing
>>> frames to the host unless 'wowlan' is enabled.
>>>
>>> There is another scenario. Let's assume a host that wants to go to suspend
>>> (power save mode) without caring about the WiFi status, i.e., it is okay to
>>> reconnect with the AP if required (anyway, the AP may disconnect the station
>>> based on inactivity timeout) or have to re-trigger the DHCP request again. But
>>> with this change, the driver would block the host from entering suspend mode.
>>>
>>> How about adding an 'if' check for host pm_caps before calling
>>> sdio_set_host_pm_flags(func, MMC_PM_KEEP_POWER)? In that case, it will only
>>> request when configured by the host platform.
>>
>> Since this driver does not reload the firmware into the card on resume,
>> the card has to be kept powered on during suspend/resume cycle. The card
>> can NOT be powered off during suspend/resume cycle, otherwise the
>> firmware is lost.
>>
>> Without this flag, the card may be powered off during suspend/resume
>> cycle. It possibly does not happen on the Atmel controller, but it does
>> on the STM32MP15xx ARM MMCI one.
>>
> yes, in the Atmel controller, it is not necessary to re-program the firmware
> on resume.

It is if the slot gets powered off across suspend/resume . It could be 
that this does not happen on the hardware you use for testing, but the 
driver cannot depend on that.

[...]

>>> I think, the wilc firmware should resume but the connection with AP may get
>>> closed. Additional commands to scan and reconnect with AP may be required that
>>> should work without downloading the firmware to wilc chip again.
>>
>> Currently, the slot may get powered off and then there is no firmware.
> 
> Currently, driver doesn't support re-programming of the chip when the host
> resumes.

Therefore, the slot MUST stay powered on across suspend/resume.

> Having that support would allow both types of hosts to suspend/resume.
> Added changes to download the firmware asynchronously on resume and it is
> included in the attached patch. It is based on the latest 'for-next' branch. I
> was not able to test it for the suspend scenario without powering the card. If
> possible, could you please try this patch in your setup.
> 
> Incase, there is no improvement with the attached patch then IMO, your patch
> looks safe to keep the MMC_PM_KEEP_POWER state since host resume may not work
> without the card powered-on anyway.

I think the attached patch is a new feature, this patch is a fix for 
existing bug. Please submit the attached patch properly, so it can get 
proper review on the ML.

Thank you

