Return-Path: <linux-wireless+bounces-3615-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E594E8560FA
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 12:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C1F9290067
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 11:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0C012AAFF;
	Thu, 15 Feb 2024 11:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfgrE8Jd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445D11756B;
	Thu, 15 Feb 2024 11:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707995346; cv=none; b=ZA2/2363CO+DYo2IV+T5YLrMoyaI7kjNhApElL6MfoomTidCmigOYqrd97JD5T59J12mYTavAcO5p3XiW11quZTK/LUdCMygBNHgNoHrto1UbYR4gYqCKxbWkSBE8XiwAY7NAsHKY1EiY1D30uxepV3MF9/qBa2vESvBzNMKyMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707995346; c=relaxed/simple;
	bh=5o9HX9pcCploLMCEfmoaEmIIHFQ5ybRnxDGqQXvAVyM=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=bo7NnvKXhEyzHV2BpH8yYDr2eucrMuyGO4WVqdiGAiiV30qgn+NvZetmpFRUfKyJVfxzYz5EU51C6MhjMmiFHTw/0i+Ov5J8pA4JeymV//g+Dw4ygGB/TgZBbLf9D7IJCTuwwcKpnhTlkt+kwziUuU3Cq4AclMWZA1coN/GH9w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfgrE8Jd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE835C43394;
	Thu, 15 Feb 2024 11:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707995345;
	bh=5o9HX9pcCploLMCEfmoaEmIIHFQ5ybRnxDGqQXvAVyM=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=bfgrE8Jd4t7i1+Zp473GjEpaU7ujF4beXyEio9iFUfqKAGjQR64HFnHBI/ES1V9AH
	 /shb9NgKBRM8QU4TEb3CtmykdyKAE/V8/Iy2x8wDGSPbG+bv+PdEfJi2xhJcI0mWUa
	 CHZGPNo4rFfxyY3KbbvJ9d45TivPu2cujwFs27dnVzD0BeUJzoBTgzV7YdZZUEV7w/
	 y/tcpTS58dmKzcGSOQPeT8zSI1JK2EpkIWeXxHCcLECigtyYV77gk/SlNDlRMoJoPw
	 UI6dvERNyWX09ay6DVvxGF664R9dHkmRPnVZkc82YoQkZZljSKnwQaehefLhtbGiPW
	 X6VPq0F4gEmUg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] wifi: wilc1000: prevent use-after-free on vif when
 cleaning up all interfaces
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240212-wilc_rework_deinit-v1-1-9203ae56c27f@bootlin.com>
References: <20240212-wilc_rework_deinit-v1-1-9203ae56c27f@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: linux-wireless@vger.kernel.org, Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 David Mosberger-Tang <davidm@egauge.net>, linux-kernel@vger.kernel.org,
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170799534217.3764215.15607229596917179924.kvalo@kernel.org>
Date: Thu, 15 Feb 2024 11:09:03 +0000 (UTC)

Alexis Lothoré <alexis.lothore@bootlin.com> wrote:

> wilc_netdev_cleanup currently triggers a KASAN warning, which can be
> observed on interface registration error path, or simply by
> removing the module/unbinding device from driver:
> 
> echo spi0.1 > /sys/bus/spi/drivers/wilc1000_spi/unbind
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in wilc_netdev_cleanup+0x508/0x5cc
> Read of size 4 at addr c54d1ce8 by task sh/86
> 
> CPU: 0 PID: 86 Comm: sh Not tainted 6.8.0-rc1+ #117
> Hardware name: Atmel SAMA5
>  unwind_backtrace from show_stack+0x18/0x1c
>  show_stack from dump_stack_lvl+0x34/0x58
>  dump_stack_lvl from print_report+0x154/0x500
>  print_report from kasan_report+0xac/0xd8
>  kasan_report from wilc_netdev_cleanup+0x508/0x5cc
>  wilc_netdev_cleanup from wilc_bus_remove+0xc8/0xec
>  wilc_bus_remove from spi_remove+0x8c/0xac
>  spi_remove from device_release_driver_internal+0x434/0x5f8
>  device_release_driver_internal from unbind_store+0xbc/0x108
>  unbind_store from kernfs_fop_write_iter+0x398/0x584
>  kernfs_fop_write_iter from vfs_write+0x728/0xf88
>  vfs_write from ksys_write+0x110/0x1e4
>  ksys_write from ret_fast_syscall+0x0/0x1c
> 
> [...]
> 
> Allocated by task 1:
>  kasan_save_track+0x30/0x5c
>  __kasan_kmalloc+0x8c/0x94
>  __kmalloc_node+0x1cc/0x3e4
>  kvmalloc_node+0x48/0x180
>  alloc_netdev_mqs+0x68/0x11dc
>  alloc_etherdev_mqs+0x28/0x34
>  wilc_netdev_ifc_init+0x34/0x8ec
>  wilc_cfg80211_init+0x690/0x910
>  wilc_bus_probe+0xe0/0x4a0
>  spi_probe+0x158/0x1b0
>  really_probe+0x270/0xdf4
>  __driver_probe_device+0x1dc/0x580
>  driver_probe_device+0x60/0x140
>  __driver_attach+0x228/0x5d4
>  bus_for_each_dev+0x13c/0x1a8
>  bus_add_driver+0x2a0/0x608
>  driver_register+0x24c/0x578
>  do_one_initcall+0x180/0x310
>  kernel_init_freeable+0x424/0x484
>  kernel_init+0x20/0x148
>  ret_from_fork+0x14/0x28
> 
> Freed by task 86:
>  kasan_save_track+0x30/0x5c
>  kasan_save_free_info+0x38/0x58
>  __kasan_slab_free+0xe4/0x140
>  kfree+0xb0/0x238
>  device_release+0xc0/0x2a8
>  kobject_put+0x1d4/0x46c
>  netdev_run_todo+0x8fc/0x11d0
>  wilc_netdev_cleanup+0x1e4/0x5cc
>  wilc_bus_remove+0xc8/0xec
>  spi_remove+0x8c/0xac
>  device_release_driver_internal+0x434/0x5f8
>  unbind_store+0xbc/0x108
>  kernfs_fop_write_iter+0x398/0x584
>  vfs_write+0x728/0xf88
>  ksys_write+0x110/0x1e4
>  ret_fast_syscall+0x0/0x1c
>  [...]
> 
> David Mosberger-Tan initial investigation [1] showed that this
> use-after-free is due to netdevice unregistration during vif list
> traversal. When unregistering a net device, since the needs_free_netdev has
> been set to true during registration, the netdevice object is also freed,
> and as a consequence, the corresponding vif object too, since it is
> attached to it as private netdevice data. The next occurrence of the loop
> then tries to access freed vif pointer to the list to move forward in the
> list.
> 
> Fix this use-after-free thanks to two mechanisms:
> - navigate in the list with list_for_each_entry_safe, which allows to
>   safely modify the list as we go through each element. For each element,
>   remove it from the list with list_del_rcu
> - make sure to wait for RCU grace period end after each vif removal to make
>   sure it is safe to free the corresponding vif too (through
>   unregister_netdev)
> 
> Since we are in a RCU "modifier" path (not a "reader" path), and because
> such path is expected not to be concurrent to any other modifier (we are
> using the vif_mutex lock), we do not need to use RCU list API, that's why
> we can benefit from list_for_each_entry_safe.
> 
> [1] https://lore.kernel.org/linux-wireless/ab077dbe58b1ea5de0a3b2ca21f275a07af967d2.camel@egauge.net/
> 
> Fixes: 8399918f3056 ("staging: wilc1000: use RCU list to maintain vif interfaces list")
> Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>

Patch applied to wireless-next.git, thanks.

cb5942b77c05 wifi: wilc1000: prevent use-after-free on vif when cleaning up all interfaces

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240212-wilc_rework_deinit-v1-1-9203ae56c27f@bootlin.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


