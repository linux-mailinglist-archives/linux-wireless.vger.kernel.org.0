Return-Path: <linux-wireless+bounces-2471-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA08883C06A
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 12:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFEB11C22779
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 11:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA704503E;
	Thu, 25 Jan 2024 11:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XfNZ4ipQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C6717735
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jan 2024 11:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706180673; cv=none; b=hPgpj4TwtpNhDx/eRnpFenf0d4jm2EzbOUqLjiO2Yq/3pJPTSaN1uJmGgidnSZr1Ab1RY9XhgYWSnyOqahSnMqoYLZWxIHYI6NQsDDRFyalEDB5apzmYTY5NT+k1+YhRBkm5+ugKMSSa1GKO12bP8tE+ZspSbFAhwNN8Fjdd/dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706180673; c=relaxed/simple;
	bh=nr5osFpr8ceCfNfVpa1htLP2nGoTdg1WkfOAOzQYbMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ezYu7uJBDqsDhCjS1YW+xxB+iAZtRFgf5VqisDUbLrv6YsGbVfsZbvIA+8RXM/Xmfi/Pq1YZLFVS6s2Ao6vf4z46ch///iTDqCMXEFdCO0OwrpRq29+JrTpGF6yisnLurN1+Xeo8wv0C0FXok03cUpYKE8ccRy0VwnzErgCR7NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XfNZ4ipQ; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 262C640013;
	Thu, 25 Jan 2024 11:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706180669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SqeaYWNEEzEl1LPBtDlokhMbz1ntGEH4OsFOSr5xnnk=;
	b=XfNZ4ipQRE1Sfe/umDWjsHvrJDC4MA9p/SJY1LnUOz+Y9pHy5fDNx3lK/vq6PLWLNJek8C
	JJEKjdyRpCh/snxKdVqcCoqYtS/Ek16sbfFhnCpT/Rj6ZKzuKOfdxd/Xsi3Qx7YLOPUuUb
	3Nykfubor7FMTQFC5H7qjjRlxaFsxLQaUq2wHSdQctqCss1BVGViE0KAYPxWBtgIvcDE6k
	O+O+PkNTYBdIz2813271N0ELxFcTOPZy+URIrHQQKgTyUXJKQNTml7X2XdEKvHuu6p8+zs
	TKSugnpY4cNJfzqzIVvJbDk+03HFN/qJNQu60VFEfAal47wJ1EJKCbyAM4wghQ==
Message-ID: <6fa6c238-9938-4e14-9b99-95759b659147@bootlin.com>
Date: Thu, 25 Jan 2024 12:04:28 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: wilc1000: validate chip id during bus probe
To: Ajay.Kathat@microchip.com, davidm@egauge.net
Cc: kvalo@kernel.org, linux-wireless@vger.kernel.org
References: <20240122211315.1444880-2-davidm@egauge.net>
 <20240122220350.1449413-1-davidm@egauge.net>
 <751bf8e4-c81c-495b-9166-9f91f9c4b2d5@bootlin.com>
 <b8e8a3f82fe240506e82322a10be7b4e9f218eca.camel@egauge.net>
 <0d77d857-35ce-43bc-aaf3-2b46c01a44ec@bootlin.com>
 <ab077dbe58b1ea5de0a3b2ca21f275a07af967d2.camel@egauge.net>
 <eb20373c68936f032c322174fbbd3353167d898a.camel@egauge.net>
 <c5118672-7e67-4601-a570-52c8e212aeda@microchip.com>
Content-Language: en-US
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <c5118672-7e67-4601-a570-52c8e212aeda@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 1/25/24 07:23, Ajay.Kathat@microchip.com wrote:
> On 1/24/24 11:45, David Mosberger-Tang wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On Wed, 2024-01-24 at 10:31 -0700, David Mosberger-Tang wrote:
>>> Alexis,
>>>
>>> On Wed, 2024-01-24 at 10:01 +0100, Alexis Lothoré wrote:
>>>> ==================================================================
>>>> BUG: KASAN: slab-use-after-free in wilc_netdev_cleanup+0x294/0x2c0
>>>> Read of size 4 at addr c3c91ce8 by task swapper/1

Replying a bit late to your initial questions:
- I am running an ARM32 platform (SAMA5D27)
- for the wilc_netdev_cleanup line, the 0x294 offset indeed points to
list_for_each_entry_rcu(vif, &wilc->vif_list, list) in my case, but you seemed
to have identified this already.

>>>
>>> OK, I think I see what's going on: it's the list traversal.  Here is what
>>> wilc_netdev_cleanup() does:
>>>
>>>       list_for_each_entry_rcu(vif, &wilc->vif_list, list) {
>>>               if (vif->ndev)
>>>                       unregister_netdev(vif->ndev);
>>>       }
>>>
>>> The problem is that "vif" is the private part of the netdev, so when the netdev
>>> is freed, the vif structure is no longer valid and list_for_each_entry_rcu()
>>> ends up dereferencing a dangling pointer.

Your diagnostic sounds relevant :)

>>> Ajay or Alexis, could you propose a fix for this - this is not something I'm
>>> familiar with.
>>
>> Actually, after staring at the code a little longer, is there anything wrong
>> with delaying the unregister_netdev() call until after the vif has been removed
>> from the vif-list?  Something along the lines of the below.

I guess you _could_ do something like this, but I think you have to be very
careful about potential races. If I'm not wrong the following could happen:
- you enter the wilc_netdev_cleanup and start removing vifs from list
- meanwhile, because your net device is still registered, userspace can start
calling concurrently some cgf80211_ops
- some of those ops may try to get the vif matching your netdevice from the
list, but it is not there anymore

Maybe some rtnl or wiphy lock (used from cfg80211 core or net core) will save
you from this for some of wilc_netdev_cleanup calls, but I think that won't be
true for the one in the error path of the probe chain.

> I think we need to investigate the actual reason for Kasan warning.
> First, we need to confirm if this warning exists without the patch(test
> by simulating a force error in wilc_bus_probe()). When
> wilc_netdev_cleanup() is also called from wilc_bus_remove(), I believe
> this warning was not observed. Once it is confirmed, the fix can be done
> accordingly.

It happens too in wilc_bus_remove:
echo "spi0.1" > /sys/bus/spi/drivers/wilc1000_spi/unbind

==================================================================
BUG: KASAN: slab-use-after-free in wilc_netdev_cleanup+0xf0/0x244
Read of size 4 at addr c3c91ce8 by task sh/91

CPU: 0 PID: 91 Comm: sh Not tainted 6.7.0-wt+ #845
Hardware name: Atmel SAMA5
 unwind_backtrace from show_stack+0x18/0x1c
 show_stack from dump_stack_lvl+0x34/0x48
 dump_stack_lvl from print_report+0x154/0x500
 print_report from kasan_report+0xd8/0x100
 kasan_report from wilc_netdev_cleanup+0xf0/0x244
 wilc_netdev_cleanup from wilc_bus_remove+0x50/0x5c
 wilc_bus_remove from spi_remove+0x40/0x50
 spi_remove from device_release_driver_internal+0x21c/0x2ac
 device_release_driver_internal from unbind_store+0x70/0xac
 unbind_store from kernfs_fop_write_iter+0x1a0/0x284
 kernfs_fop_write_iter from vfs_write+0x38c/0x6f4
 vfs_write from ksys_write+0xd8/0x178
 ksys_write from ret_fast_syscall+0x0/0x1c
Exception stack(0xc588ffa8 to 0xc588fff0)
ffa0:                   00000007 004eff68 00000001 004eff68 00000007 00000001
ffc0: 00000007 004eff68 00000001 00000004 00000007 b69546c0 00000020 004ed190
ffe0: 00000004 b6954678 aec3a041 aebd1a26

> Avoiding netdev initialization in wilc_cfg80211_init() would require lot
> of modification and changes in API call order. IMO the Kasan warning fix
> should be independent of netdev initialization order and it should
> free-up the resources for all cases. Suppose if the card is not present,
> the probe API should clean-up and exit gracefully. For detecting the
> chip_id, I have created the below patch considering the above scenarios,
> please check if it makes sense.

Agree about the wilc_netdev_cleanup fix being a separated topic, to be handled
accordingly.
Still, the scenario I mention above, if true, makes me more confident that we
should not register at all the netdevice before being able to manage it. Maybe
those cases are already handled correctly with some checks to make sure no real
crash occurs, but all those checks could be avoided if we did not register the
netdevice so early

Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


