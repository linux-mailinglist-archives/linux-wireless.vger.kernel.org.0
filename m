Return-Path: <linux-wireless+bounces-2438-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CB383A4D5
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 10:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AC971F2258F
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 09:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4BC17BA4;
	Wed, 24 Jan 2024 09:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TUFwoV2d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A21F519
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jan 2024 09:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706086904; cv=none; b=imo1c78IYBC2xx19sJo0UFBZZGfpCcpMg8roLW7JkvgABgMvZ9TK4LkJptLh3M7cuprgvXkIVsfRocYDr39D0x3eYmcHX8K+6LoO33uahHviVHw1RLadj6Z3ogdwfIWWYzTjnD0ekTlcPvQxkygLYwZ4b/RJWbwsAANkhKHe0VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706086904; c=relaxed/simple;
	bh=nzeUvXvKw3g3KCUnFHIO160tbyy44bmwsoZXck2MAhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ViAv+2RenRJWngeJUPyzotIGZDfk6Z/k7Az3sbYn2Z2ppeK1L0gcvFB/kIqMD90l+RBxG74rMONN3gbb+W1wd14hI4meUlQZwb3fnv2zArpstOBu1ievG2eyJU7xMefDN3VokN6rvW8Q0pH6yGZiem+z7MnhK/s2nvqSd65ADWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TUFwoV2d; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4823EFF815;
	Wed, 24 Jan 2024 09:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706086894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DiXZ21uLRaE1J+4zVPH+lMJdKUmM2MWQFYtJjaiokYc=;
	b=TUFwoV2d5JkK3lNTR7zsflSS6qE6xx4fcldQBGzkM8sMd6ldUnxAW6pSmSZqErwWy95jGj
	MDwzuluvuaNYpePV3puIfcdZYKoUSL5h3kG78apMirdOD32nnTQ+sFIaMa9ih4dv1l8YRD
	ufXUvhfIeQW/aGvQ7Ou77TdyyzfklqKS3lUOAuxn/27LsTleQCL1AMqqwvfKrFv5qHrffd
	ZCyj9gb1BZWMdMQ/4VWxhAho+uPzzMdr04BINk1CqP+EPlCIaVvNCSnYloTMh2CsqGomqE
	gzZp7P6P8s/TqL26YDHCuQUyPAJvtIEmVkc1ieo+vxUVUgUygGTaQTHsSv6J5A==
Message-ID: <0d77d857-35ce-43bc-aaf3-2b46c01a44ec@bootlin.com>
Date: Wed, 24 Jan 2024 10:01:33 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: wilc1000: validate chip id during bus probe
To: David Mosberger-Tang <davidm@egauge.net>, linux-wireless@vger.kernel.org
Cc: Ajay.Kathat@microchip.com, kvalo@kernel.org
References: <20240122211315.1444880-2-davidm@egauge.net>
 <20240122220350.1449413-1-davidm@egauge.net>
 <751bf8e4-c81c-495b-9166-9f91f9c4b2d5@bootlin.com>
 <b8e8a3f82fe240506e82322a10be7b4e9f218eca.camel@egauge.net>
Content-Language: en-US
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <b8e8a3f82fe240506e82322a10be7b4e9f218eca.camel@egauge.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 1/23/24 18:39, David Mosberger-Tang wrote:
> On Tue, 2024-01-23 at 11:18 +0100, Alexis Lothoré wrote:
>> On 1/22/24 23:03, David Mosberger-Tang wrote:

[...]

>> I have a working wilc-over-spi setup with which I can easily unplug the module,
>> so I gave a try to your series, and while the lack of chip detect indeed makes
>> the netdevice registration not executed, I've got a nasty kasan warning:
>>
>>  driver_probe_device from __driver_attach+0x1a0/0x29c
>>
>>
>>
>>                                                  [141/1863]
>>  __driver_attach from bus_for_each_dev+0xf0/0x14c
>>  bus_for_each_dev from bus_add_driver+0x130/0x288
>>  bus_add_driver from driver_register+0xd4/0x1c0
>>  driver_register from do_one_initcall+0xfc/0x204
>>  do_one_initcall from kernel_init_freeable+0x240/0x2a0
>>  kernel_init_freeable from kernel_init+0x20/0x144
>>  kernel_init from ret_from_fork+0x14/0x28
>> Exception stack(0xc3163fb0 to 0xc3163ff8)
>> 3fa0:                                     00000000 00000000 00000000 00000000
>> 3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>> 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>>
>> Allocated by task 1:
>>  kasan_set_track+0x3c/0x5c
>>  __kasan_kmalloc+0x8c/0x94
>>  __kmalloc_node+0x64/0x184
>>  kvmalloc_node+0x48/0x114
>>  alloc_netdev_mqs+0x68/0x664
>>  alloc_etherdev_mqs+0x28/0x34
>>  wilc_netdev_ifc_init+0x34/0x37c
>>  wilc_cfg80211_init+0x278/0x330
>>  wilc_bus_probe+0xb4/0x398
>>  spi_probe+0xb8/0xdc
>>  really_probe+0x134/0x588
>>  __driver_probe_device+0xe0/0x288
>>  driver_probe_device+0x60/0x118
>>  __driver_attach+0x1a0/0x29c
>>  bus_for_each_dev+0xf0/0x14c
>>  bus_add_driver+0x130/0x288
>>  driver_register+0xd4/0x1c0
>>  do_one_initcall+0xfc/0x204
>>  kernel_init_freeable+0x240/0x2a0
>>  kernel_init+0x20/0x144
>>  ret_from_fork+0x14/0x28
>>
>> Freed by task 1:
>>  kasan_set_track+0x3c/0x5c
>>  kasan_save_free_info+0x30/0x3c
>>  __kasan_slab_free+0xe4/0x12c
>>  __kmem_cache_free+0x94/0x1cc
>>  device_release+0x54/0xf8
>>  kobject_put+0xf4/0x238
>>  netdev_run_todo+0x414/0x7dc
>>  wilc_netdev_cleanup+0xe4/0x244
>>  wilc_bus_probe+0x2b8/0x398
>>  spi_probe+0xb8/0xdc
>>  really_probe+0x134/0x588
>>  __driver_probe_device+0xe0/0x288
>>  driver_probe_device+0x60/0x118
>>  __driver_attach+0x1a0/0x29c
>>  bus_for_each_dev+0xf0/0x14c
>>  bus_add_driver+0x130/0x288
>>  driver_register+0xd4/0x1c0
>>  do_one_initcall+0xfc/0x204
>>  kernel_init_freeable+0x240/0x2a0
>>  kernel_init+0x20/0x144
>>  ret_from_fork+0x14/0x28
>>
>> It looks like an already existing/dormant issue in the error-managing path of
>> spi probe of the driver (looks like we are trying to unregister a netdevice
>> which has never been registered ?), but since your series triggers it, it should
>> be handled too.
> 
> I need help interpreting this.  What does KASAN actually complain about?  A
> double free or something else?

I see that the kasan dump from my last email is truncated, but the first line
clearly mentions a use-after-free:

==================================================================
BUG: KASAN: slab-use-after-free in wilc_netdev_cleanup+0x294/0x2c0
Read of size 4 at addr c3c91ce8 by task swapper/1

CPU: 0 PID: 1 Comm: swapper Not tainted 6.7.0-wt+ #843
Hardware name: Atmel SAMA5
 unwind_backtrace from show_stack+0x18/0x1c
 show_stack from dump_stack_lvl+0x34/0x48
 dump_stack_lvl from print_report+0x154/0x500
 print_report from kasan_report+0xd8/0x100
 kasan_report from wilc_netdev_cleanup+0x294/0x2c0
 wilc_netdev_cleanup from wilc_bus_probe+0x2b8/0x398
 wilc_bus_probe from spi_probe+0xb8/0xdc
 spi_probe from really_probe+0x134/0x588
 really_probe from __driver_probe_device+0xe0/0x288
 __driver_probe_device from driver_probe_device+0x60/0x118
 driver_probe_device from __driver_attach+0x1a0/0x29c
 __driver_attach from bus_for_each_dev+0xf0/0x14c
 bus_for_each_dev from bus_add_driver+0x130/0x288
 bus_add_driver from driver_register+0xd4/0x1c0
 driver_register from do_one_initcall+0xfc/0x204
 do_one_initcall from kernel_init_freeable+0x240/0x2a0
 kernel_init_freeable from kernel_init+0x20/0x144
 kernel_init from ret_from_fork+0x14/0x28

Not sure though what's wrong without digging further.

> register_netdev() does get called (through wilc_cfg80211_init()) and then when
> the chip detect fails, unregister_netdev() gets called (from
> wilc_netdev_cleanup()), so I don't see any obvious issues, but there is a lot of
> other stuff going on there that I'm not familiar with.

My bad, your statement made me realize I overlooked things here: aside from the
kasan warning, your patch makes the probe function do the following steps:
- create and register (wiphy and) netdevice
- check if chip is detected on bus
- unregister/clean up everything if chip does not respond

There's no point in pre-registering the netdevice so early if we add an error
path due to chip being absent, I would even say that the whole point of your
series is to prevent registering the device if chip can not be accessed. So IMHO
chip detection should be done before trying to register the netdevice. It will
prevent all the complications due to the whole reverse unregistration (and all
weird issues that can occur because of device being registered while not being
fully ready)

>>> +	if (base_id != WILC_1000_BASE_ID && base_id != WILC_3000_BASE_ID) {
>>
>> - WILC3000 is currently not supported (yet) by the upstream driver, so there is
>> no reason to validate its presence if we can not handle it later. Any mention of
>> it should then be removed from this series
> 
> Oh, I didn't realize that.  I was just going off of this web page:
> 
>  https://www.microchip.com/en-us/software-library/wilc1000_3000_linux_driver

Understood, but again, your patch must be based on upstream trees :)

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


