Return-Path: <linux-wireless+bounces-17494-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3305A10729
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 13:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1601018865C4
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 12:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D2522DC33;
	Tue, 14 Jan 2025 12:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Yn0skfuY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D275520F99F;
	Tue, 14 Jan 2025 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736859370; cv=none; b=T8oSRRBd6sgTcYV2HZ/QDvX5fr/hqA36bId/Fnxdc7Kfc38C5qixVMshvUa6kOpIOoZBZVgLZ93IaCD5vZUVdzCXTj2jLGbdhHzSkLb+fzqBEtFkVm/vmTXAu+2prXJj4EjlGDLuG42wW/7hHDD304TEiChNKgdDrSJ+XGhb210=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736859370; c=relaxed/simple;
	bh=cRa6DlNY88dqACmn8NHfWCUMFSzodXQ9XDTOj4ExC4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N5L1aq2Y22TP8RUENb8gbybAFxq3r0pdufLBKL8TVW7owDDRU5KG3Rm5Qj8Bx1m2AA5Z5iah2SjTAyAEu01bqum5c4s/Sx1NFtE9JBkxRZ+PZ0KvSb2LyLcWlStgbyvA97heCm8IAVOE98mbNT18mo0f1MrDdzGNmbPU6SgMWGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Yn0skfuY; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E33AB1BF205;
	Tue, 14 Jan 2025 12:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736859366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=26minFAOLunkoKuCgOuz4/1DbgGwtrQNhEPhg7ljzz4=;
	b=Yn0skfuYxhFIl27tHGdvt5f4y4TiCocLFZ/gttcLaT6NRNdpFmWorJJ6+RjfDgZLeQPSK5
	YrLFmW5MNeTwJukEi2/4Obe/RtxfwMigKO5DelMFKcYbie0FY+AfxdJhLeGKvKLgXJsSjR
	jOooCbBUCi17eIG6ogD/qgftijXa/av0WYlmI6D3PKiyQK72vDfCugHLZR/ywez+OW6Rt8
	Tk60EengE5urTq3xS7tq4gGoEflL3SdFcnrzyCPGReHcs/1lC/xyhFHsn/UAz+JPJyRQXE
	GIxKFS+G1hM3UuyMZIPDcSeq+gGWuy7psa8oMXmea0X2P5fMoCmLaf5UE+3IGA==
Message-ID: <165a166c-d402-48d9-a190-44a710fa4d1c@bootlin.com>
Date: Tue, 14 Jan 2025 13:56:05 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: wilc1000: unregister wiphy only after netdev
 registration
To: Kalle Valo <kvalo@kernel.org>
Cc: Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Marek Vasut <marex@denx.de>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250114-wilc1000_modprobe-v1-1-ad19d46f0c07@bootlin.com>
 <87frllr3h1.fsf@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <87frllr3h1.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 1/14/25 13:20, Kalle Valo wrote:
> Alexis Lothoré <alexis.lothore@bootlin.com> writes:
> 
>> wiphy_unregister/wiphy_free has been recently decoupled from
>> wilc_netdev_cleanup to fix a faulty error path in sdio/spi probe
>> functions. However this change introduced a new failure when simply
>> loading then unloading the driver:
>>   $ modprobe wilc1000-sdio; modprobe -r wilc1000-sdio
>>   WARNING: CPU: 0 PID: 115 at net/wireless/core.c:1145 wiphy_unregister+0x904/0xc40 [cfg80211]
>>   Modules linked in: wilc1000_sdio(-) wilc1000 cfg80211 bluetooth ecdh_generic ecc
>>   CPU: 0 UID: 0 PID: 115 Comm: modprobe Not tainted 6.13.0-rc6+ #45
>>   Hardware name: Atmel SAMA5
>>   Call trace:
>>    unwind_backtrace from show_stack+0x18/0x1c
>>    show_stack from dump_stack_lvl+0x44/0x70
>>    dump_stack_lvl from __warn+0x118/0x27c
>>    __warn from warn_slowpath_fmt+0xcc/0x140
>>    warn_slowpath_fmt from wiphy_unregister+0x904/0xc40 [cfg80211]
>>    wiphy_unregister [cfg80211] from wilc_sdio_remove+0xb0/0x15c [wilc1000_sdio]
>>    wilc_sdio_remove [wilc1000_sdio] from sdio_bus_remove+0x104/0x3f0
>>    sdio_bus_remove from device_release_driver_internal+0x424/0x5dc
>>    device_release_driver_internal from driver_detach+0x120/0x224
>>    driver_detach from bus_remove_driver+0x17c/0x314
>>    bus_remove_driver from sys_delete_module+0x310/0x46c
>>    sys_delete_module from ret_fast_syscall+0x0/0x1c
>>   Exception stack(0xd0acbfa8 to 0xd0acbff0)
>>   bfa0:                   0044b210 0044b210 0044b24c 00000800 00000000 00000000
>>   bfc0: 0044b210 0044b210 00000000 00000081 00000000 0044b210 00000000 00000000
>>   bfe0: 00448e24 b6af99c4 0043ea0d aea2e12c
>>   irq event stamp: 0
>>   hardirqs last  enabled at (0): [<00000000>] 0x0
>>   hardirqs last disabled at (0): [<c01588f0>] copy_process+0x1c4c/0x7bec
>>   softirqs last  enabled at (0): [<c0158944>] copy_process+0x1ca0/0x7bec
>>   softirqs last disabled at (0): [<00000000>] 0x0
>>
>> The warning is triggered by the fact that there is still a
>> wireless_device linked to the wiphy we are unregistering, due to
>> wiphy_unregister now being called after net device unregister (performed
>> in wilc_netdev_cleanup). Fix this warning by moving wiphy_unregister
>> after wilc_netdev_cleanup is nominal paths (ie: driver removal).
>> wilc_netdev_cleanup ordering is left untouched in error paths in probe
>> function because net device is not registered in those paths (so the
>> warning can not trigger), yet the wiphy can still be registered, and we
>> still some cleanup steps from wilc_netdev_cleanup.
>>
>> Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
>> ---
>> I clearly overlooked this simple scenario/misunderstood expected
>> unregistration order when fixing some spi probe error path, my bad (see
>> commit 89a7616e1715 ("ARM: dts: at91-sama5d27_wlsom1: update bluetooth
>> chip description") in wireless-next)
> 
> No worries, bugs are business as usual.
> 
>> @Kalle: 89a7616e1715 (the faulty commit) is only in wireless-next for
>> now IIUC, so I did not provide any Fixes: tag to prevent any faulty SHA1
>> if those commits end up being picked in stable tree (however, the faulty
>> commit _has_ a Fixes tag). Please let me know if we should proceed
>> differently.
> 
> Hmm, I don't really follow you here. I feel that always adding the Fixes
> tag is the safest option, that way it's clear for everyone what commit
> we are fixing.

I was thinking about the fact that the faulty commit SHA1 may change because of
a merge, and then break the Fixes: tag, but maybe I am overthinking.

So if it's ok for you, I would like to add the Fixes tag
> but I can't find commit 89a7616e1715 anywhere.

Gaah, indeed that's not the correct SHA1. The faulty commit in wireless-next is
in fact commit 1be94490b6b8 ("wifi: wilc1000: unregister wiphy only if it has
been registered")

Thanks,

Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

