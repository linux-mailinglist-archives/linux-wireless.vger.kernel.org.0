Return-Path: <linux-wireless+bounces-12207-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 874BA964A66
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2024 17:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A80E31C22560
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2024 15:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A25A1B29AB;
	Thu, 29 Aug 2024 15:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="nl+rgtxP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6BD1A01CA
	for <linux-wireless@vger.kernel.org>; Thu, 29 Aug 2024 15:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724946277; cv=none; b=lmsKpbjfX/SnmnwMo58l7xQPQ6xvb1vTBef80gGnOPuOY+IxChpen/zNa/o1/fxBgxJtnbUge5pNMKj6INbvIE/aDBuI06TAi9nD/TE8FrRSMtVAtVhCivcLfz1TXh1LyC505itqReIxGs8n05b8SbCHsss2anx1cL/G4pBoZX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724946277; c=relaxed/simple;
	bh=ZTb+OT2bkEBVU8WbacnjMAx2elU+4rW1WHiD7gmZCGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cVoX32WweXXWqH1EUYws5fQakSVPeC0THJt2c4/iC3JrHM6POryhaNeGjPQV3MwSAMZCp/yS32KTj3SBaKDYLt8YpxMQJoGVS24b1LfWOUxzRUlcaXT5CzEM7Yu0ISb+PXdTkqdtM9USzjZmPu6uFaKNdnM1wX9xPhwZVa07yJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=nl+rgtxP; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id F23C688C6A;
	Thu, 29 Aug 2024 17:44:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724946273;
	bh=e0FxXAPZizxFTGTgImErnWgjteCt0ZaQPYTqVBLqblk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nl+rgtxPIAtJm6ijwTmUbMhfMDwzWaTr4wkvWyFXcqfIq0g/chgCIrIaSv6tCsSVU
	 NIqLXbD2INcrArhUArUnbL5qk3Fu6vFIHMcwd2W6+Z2T4sxPNdOwp6J0I7MZA23JIV
	 rWVdDGeKfhxi9yTkuNOYd2DWgVoyzkcKZly5MiizK/zcPXTsE9ER3XTumLbRd5ARlT
	 EWRmhETvtp0CwLPsovgN6MefwdpBJi4iSifM+fYJ7Y+FLakjYT0Nike5mpWSgCyWDq
	 uOaM92ryIVdis8UkqYa1wor8vfI+5k1mA2LPvMg/LswqswT1L+IrF8s6GoDPfRIqFS
	 PisenOCAqRKVA==
Message-ID: <12b79e2b-08ca-4ba0-8abb-6f1d0be65b3c@denx.de>
Date: Thu, 29 Aug 2024 17:38:12 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <ae40b138-77ad-4044-9448-784be6964195@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 8/29/24 7:51 AM, Ajay.Kathat@microchip.com wrote:

Hi,

>> This patch assures the chip does not get power-cycled during
>> suspend/resume cycle, which makes it lose state (and firmware), so the
>> chip is unusable after resume without this patch.
>>
> 
> During host suspend, the firmware doesn't get power-cycled and also doesn't
> forward the frames to the host.

If the slot is powered OFF, which it currently can be, then the entire 
WILC gets power-cycled.

> 1. Without this patch, is the station getting disconnected from the AP during
> the suspend state? Does a rescan and reconnect help to resume the connection
> with the AP?

Rescan doesn't work because there is no firmware in the WILC.

> 2. With this patch, does the ping to the station work during the suspend state?

I haven't tested this, but that's unlikely because the host is 
suspended. Still, that's not really the point here, the point is that 
the whole WILC gets powered off during suspend/resume without this 
patch. At least on STM32MP15xx it is, maybe on the Atmel controller it 
is not, but we cannot depend on that.

> AFAIR, during host suspend, the firmware continues to run without passing
> frames to the host unless 'wowlan' is enabled.
> 
> There is another scenario. Let's assume a host that wants to go to suspend
> (power save mode) without caring about the WiFi status, i.e., it is okay to
> reconnect with the AP if required (anyway, the AP may disconnect the station
> based on inactivity timeout) or have to re-trigger the DHCP request again. But
> with this change, the driver would block the host from entering suspend mode.
> 
> How about adding an 'if' check for host pm_caps before calling
> sdio_set_host_pm_flags(func, MMC_PM_KEEP_POWER)? In that case, it will only
> request when configured by the host platform.

Since this driver does not reload the firmware into the card on resume, 
the card has to be kept powered on during suspend/resume cycle. The card 
can NOT be powered off during suspend/resume cycle, otherwise the 
firmware is lost.

Without this flag, the card may be powered off during suspend/resume 
cycle. It possibly does not happen on the Atmel controller, but it does 
on the STM32MP15xx ARM MMCI one.

Now, since the card does consume about the same amount of power whether 
it is powered OFF or whether it is powered ON but suspended, I opt for 
the later option -- keep the card powered ON, suspend it, and that's 
what this patch does. This also allows us to support WoWlan then.

>>> It may be that when the
>>> power consumption was measured,the WILC suspend state is not enabled because
>>> of MMC controller pm_caps in the test setup.
>>>
>>> I think it is better to have a generic patch for any host which has
>>> MMC_PM_KEEP_POWER capabilities defined or not. With proposed patch, driver
>>> will not allow the host to go into the suspend state when MMC_PM_KEEP_POWER is
>>> not set in PM caps. I think, sdio_set_host_pm_flags() should only be called if
>>> MMC_PM_KEEP_POWER is defined in the host.
>>
>> To retain firmware in the chip, the chip must not be powered off during
>> suspend/resume, which is what this patch assures. Without this patch,
>> the controller may power off the slot during suspend/resume and the WILC
>> will lose firmware and be unusable after resume.
>>
>>> Actually, WILC can support suspend mode with or without this host
>>> capabilities. For SDIO, the host can be wake-up using the external IRQ GPIO
>>> (uses out-of-band, instead of in-band interrupt) on WILC.
>>>
>>> To test wake-on-wlan(wowlan) in suspend mode, the IRQ pin from WILC should be
>>> connected with the host that will help to interrupt/wake the host when any
>>> WiFi packet arrives. Without 'wowlan' enabled in suspend mode, the host should
>>> be allowed to go into suspend mode but it can't be wake-up by WiFi packets.
>>> All the packets will be dropped in the firmware in suspend state.
>>>
>>> WILC supports only ANY option for wowlan. So, after connecting the IRQ line
>>> with host, the below commands can be used to test "wowlan" in suspend state.
>>>
>>>
>>> #  iw phy <phyname> wowlan enable any
>>> #  echo mem > /sys/power/state
>>
>> If the WILC is powered off because the slot is powered off, WILC cannot
>> resume anything.
> 
> I think, the wilc firmware should resume but the connection with AP may get
> closed. Additional commands to scan and reconnect with AP may be required that
> should work without downloading the firmware to wilc chip again.

Currently, the slot may get powered off and then there is no firmware.

