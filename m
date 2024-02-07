Return-Path: <linux-wireless+bounces-3282-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF4684C901
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 11:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6CAFB21ECC
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 10:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35711758E;
	Wed,  7 Feb 2024 10:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ecKhy86N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC30D171AD
	for <linux-wireless@vger.kernel.org>; Wed,  7 Feb 2024 10:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707303286; cv=none; b=rzPNh+Zh1iFb+SLmELbQQy9AFrw0FKTlEjNDnqOH0/2GemgdUDVIMbHb7LcgVnOdUY3FrwF63to9pC+0Vyut4STzt+zF7TafljFnj/NdUaaJi2A021cxrQCsCq5oBfvrH9oV3B0MDNISbMDoi5jG2BrDyCuwNvRwq63R5VoRDlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707303286; c=relaxed/simple;
	bh=qzkJQUSSGCuhWlP0mzgJFZW5RBBaMbrFFqRyVxhCrV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rX9TKxkzkAcQ70mQe4JaOg20EGv1MTUz7Lg7Q+OpSzH1jjytoWc+g/rgpGd+VaOtt6IODCX6lK0xXBch7m+UX+f8HF4VYsmz15sJ2oeisP5UnT5SxpjU1dVdg9pW7xe3180nD2mC/ALcSh5CIH5QyVrphWN9+c4rOSiK7o4Fxh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ecKhy86N; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1F5F820011;
	Wed,  7 Feb 2024 10:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707303276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yuTTejDWwzTbUrgscsX6EpSv3xhWfdM8pt7A/drO950=;
	b=ecKhy86NZJU2rWRp/ABcCzYm3Q1xY/0nFmOLKDPHT8loJKPUl0Z+E6cJOcOZ2UVlJ7ouoD
	N+XAwXaOeQuzl8vkHiiZcEzQtk/rWGXp+x+3osBwQYUN+CACQsrP2pQcwG8d38Wn+/x7xZ
	zKesGxPLF9cmbtPqzW+7+YTAaABStRRtKEjeqwvK5in0rqaTxKlmVFE/lSQRH4WC6gQcMK
	hXrn4/3udVPHiorlE6KnaFlA6Lq3LbXE73KfjidIm55Ryg0NlghSZ4tr9ZxAFcgF+Kzkrr
	cXfyrwURwaMYCMm4mgcpoFYBt7kHjT8NJyht//af3w944lbPfaMXfw7Z9fjkEQ==
Message-ID: <3de19fad-ae1b-42b4-8a19-fa40215cc75a@bootlin.com>
Date: Wed, 7 Feb 2024 11:54:35 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] wifi: wilc1000: validate chip id during bus probe
To: David Mosberger-Tang <davidm@egauge.net>, linux-wireless@vger.kernel.org
Cc: Ajay.Kathat@microchip.com, kvalo@kernel.org,
 Claudiu Beznea <claudiu.beznea@microchip.com>
References: <20240207044559.2717200-1-davidm@egauge.net>
Content-Language: en-US
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <20240207044559.2717200-1-davidm@egauge.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 2/7/24 05:49, David Mosberger-Tang wrote:
> Previously, the driver created a net device (typically wlan0) as soon
> as the module was loaded.  This commit changes the driver to follow
> normal Linux convention of creating the net device only when bus
> probing detects a supported chip.

Running your series on my platform showed some new warnings in the nominal case
(ie when module is correctly wired onto the SPI bus), but after digging a bit, I
doubt it is due to your patch. Applying some specific reverts makes me think
that the issue is somewhere around recent XDMAC PM runtime support, especially
650b0e990cbd ("dmaengine: at_xdmac: add runtime pm support") (Ccing Claudiu
Beznea for a second opinion, + traces below)

So ignoring that, LGTM, and wlan0 indeed does not appear after boot when I mess
with the module wiring on the bus.

Tested-by: Alexis Lothoré <alexis.lothore@bootlin.com>

---
Traces of the locking warnings, observed on SAMA5D27-WLSOM1-EVK:

BUG: sleeping function called from invalid context at
drivers/base/power/runtime.c:1164
in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 1, name: swapper
preempt_count: 1, expected: 0
4 locks held by swapper/1:
 #0: c4bc7878 (&dev->mutex){....}-{3:3}, at: __driver_attach+0x218/0x5d4
 #1: c43ee3a8 (&ctlr->bus_lock_mutex){+.+.}-{3:3}, at: spi_sync+0x50/0xa8
 #2: c43ee2f4 (&ctlr->io_mutex){+.+.}-{3:3}, at: __spi_sync+0x8ac/0xf78
 #3: c4128304 (&atchan->lock){....}-{2:2}, at: at_xdmac_issue_pending+0x34/0x164
irq event stamp: 112350
hardirqs last  enabled at (112349): [<c1a63dc0>]
_raw_spin_unlock_irqrestore+0x8c/0xa8
hardirqs last disabled at (112350): [<c1a639e4>] _raw_spin_lock_irqsave+0xa0/0xac
softirqs last  enabled at (112326): [<c0101b68>] __do_softirq+0x754/0xad4
softirqs last disabled at (112317): [<c015814c>] __irq_exit_rcu+0x28c/0x34c
CPU: 0 PID: 1 Comm: swapper Not tainted 6.8.0-rc1+ #87
Hardware name: Atmel SAMA5
 unwind_backtrace from show_stack+0x18/0x1c
 show_stack from dump_stack_lvl+0x34/0x58
 dump_stack_lvl from __might_resched+0x38c/0x598
 __might_resched from __pm_runtime_resume+0x108/0x120
 __pm_runtime_resume from at_xdmac_chan_is_enabled+0x88/0x230
 at_xdmac_chan_is_enabled from at_xdmac_issue_pending+0x40/0x164
 at_xdmac_issue_pending from atmel_spi_one_transfer+0xac0/0x38d4
 atmel_spi_one_transfer from spi_transfer_one_message+0xbb4/0x1e20
 spi_transfer_one_message from __spi_pump_transfer_message+0xa44/0x1a40
 __spi_pump_transfer_message from __spi_sync+0x924/0xf78
 __spi_sync from spi_sync+0x5c/0xa8
 spi_sync from wilc_spi_tx_rx+0x178/0x1ec
 wilc_spi_tx_rx from wilc_spi_single_read+0x1b4/0x5f8
 wilc_spi_single_read from spi_internal_read+0xc0/0x158
 spi_internal_read from wilc_spi_configure_bus_protocol+0x1e4/0x464
 wilc_spi_configure_bus_protocol from wilc_bus_probe+0x4fc/0x838
 wilc_bus_probe from spi_probe+0x158/0x1b0
 spi_probe from really_probe+0x270/0xdf4
 really_probe from __driver_probe_device+0x1dc/0x580
 __driver_probe_device from driver_probe_device+0x60/0x140
 driver_probe_device from __driver_attach+0x228/0x5d4
 __driver_attach from bus_for_each_dev+0x13c/0x1a8
 bus_for_each_dev from bus_add_driver+0x2a0/0x608
 bus_add_driver from driver_register+0x24c/0x578
 driver_register from do_one_initcall+0x180/0x310
 do_one_initcall from kernel_init_freeable+0x424/0x484
 kernel_init_freeable from kernel_init+0x20/0x148
 kernel_init from ret_from_fork+0x14/0x28
Exception stack(0xc396bfb0 to 0xc396bff8)
bfa0:                                     00000000 00000000 00000000 00000000
bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
bfe0: 00000000 00000000 00000000 00000000 00000013 00000000

================================
WARNING: inconsistent lock state
6.8.0-rc1+ #87 Tainted: G        W
--------------------------------
inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
swapper/1 [HC0[0]:SC1[1]:HE0:SE0] takes:
c4128220 (&atchan->lock){+.?.}-{2:2}, at: at_xdmac_tasklet+0x108/0x1350
{SOFTIRQ-ON-W} state was registered at:
  lockdep_hardirqs_on_prepare+0x338/0x5c4
  trace_hardirqs_on+0xdc/0x368
  _raw_spin_unlock_irq+0x28/0x7c
  __rpm_callback+0x160/0x370
  rpm_callback+0x118/0x148
  rpm_resume+0xbac/0x1438
  __pm_runtime_resume+0xb8/0x120
  at_xdmac_chan_is_enabled+0x88/0x230
  at_xdmac_issue_pending+0x40/0x164
  atmel_spi_one_transfer+0xac0/0x38d4
  spi_transfer_one_message+0xbb4/0x1e20
  __spi_pump_transfer_message+0xa44/0x1a40
  __spi_sync+0x924/0xf78
  spi_sync+0x5c/0xa8
  wilc_spi_tx_rx+0x178/0x1ec
  wilc_spi_single_read+0x1b4/0x5f8
  spi_internal_read+0xc0/0x158
  wilc_spi_configure_bus_protocol+0x1e4/0x464
  wilc_bus_probe+0x4fc/0x838
  spi_probe+0x158/0x1b0
  really_probe+0x270/0xdf4
  __driver_probe_device+0x1dc/0x580
  driver_probe_device+0x60/0x140
  __driver_attach+0x228/0x5d4
  bus_for_each_dev+0x13c/0x1a8
  bus_add_driver+0x2a0/0x608
  driver_register+0x24c/0x578
  do_one_initcall+0x180/0x310
  kernel_init_freeable+0x424/0x484
  kernel_init+0x20/0x148
  ret_from_fork+0x14/0x28
irq event stamp: 112385
hardirqs last  enabled at (112384): [<c015888c>] tasklet_action_common+0xa4/0xbdc
hardirqs last disabled at (112385): [<c1a63938>] _raw_spin_lock_irq+0x9c/0xa8
softirqs last  enabled at (112368): [<c0101b68>] __do_softirq+0x754/0xad4
softirqs last disabled at (112381): [<c015814c>] __irq_exit_rcu+0x28c/0x34c

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&atchan->lock);
  <Interrupt>
    lock(&atchan->lock);

 *** DEADLOCK ***

3 locks held by swapper/1:
 #0: c4bc7878 (&dev->mutex){....}-{3:3}, at: __driver_attach+0x218/0x5d4
 #1: c43ee3a8 (&ctlr->bus_lock_mutex){+.+.}-{3:3}, at: spi_sync+0x50/0xa8
 #2: c43ee2f4 (&ctlr->io_mutex){+.+.}-{3:3}, at: __spi_sync+0x8ac/0xf78

stack backtrace:
CPU: 0 PID: 1 Comm: swapper Tainted: G        W          6.8.0-rc1+ #87
Hardware name: Atmel SAMA5
 unwind_backtrace from show_stack+0x18/0x1c
 show_stack from dump_stack_lvl+0x34/0x58
 dump_stack_lvl from mark_lock+0x21c8/0x3628
 mark_lock from __lock_acquire+0x14e4/0x54bc
 __lock_acquire from lock_acquire.part.0+0x1a0/0x420
 lock_acquire.part.0 from _raw_spin_lock_irq+0x88/0xa8
 _raw_spin_lock_irq from at_xdmac_tasklet+0x108/0x1350
 at_xdmac_tasklet from tasklet_action_common+0x4a8/0xbdc
 tasklet_action_common from __do_softirq+0x2f4/0xad4
 __do_softirq from __irq_exit_rcu+0x28c/0x34c
 __irq_exit_rcu from irq_exit+0x10/0x28
 irq_exit from call_with_stack+0x18/0x20
 call_with_stack from __irq_svc+0x80/0x9c
Exception stack(0xc396b4c0 to 0xc396b508)
b4c0: 00000080 00000001 00011fb2 200000d3 60000053 c4128210 c4128244 c4128160
b4e0: d08cd028 00000013 b782502c c396b900 00000000 c396b510 c1a45fbc c1a63d74
b500: 20000053 ffffffff
 __irq_svc from _raw_spin_unlock_irqrestore+0x40/0xa8
 _raw_spin_unlock_irqrestore from atmel_spi_one_transfer+0xb34/0x38d4
 atmel_spi_one_transfer from spi_transfer_one_message+0xbb4/0x1e20
 spi_transfer_one_message from __spi_pump_transfer_message+0xa44/0x1a40
 __spi_pump_transfer_message from __spi_sync+0x924/0xf78
 __spi_sync from spi_sync+0x5c/0xa8
 spi_sync from wilc_spi_tx_rx+0x178/0x1ec
 wilc_spi_tx_rx from wilc_spi_single_read+0x1b4/0x5f8
 wilc_spi_single_read from spi_internal_read+0xc0/0x158
 spi_internal_read from wilc_spi_configure_bus_protocol+0x1e4/0x464
 wilc_spi_configure_bus_protocol from wilc_bus_probe+0x4fc/0x838
 wilc_bus_probe from spi_probe+0x158/0x1b0
 spi_probe from really_probe+0x270/0xdf4
 really_probe from __driver_probe_device+0x1dc/0x580
 __driver_probe_device from driver_probe_device+0x60/0x140
 driver_probe_device from __driver_attach+0x228/0x5d4
 __driver_attach from bus_for_each_dev+0x13c/0x1a8
 bus_for_each_dev from bus_add_driver+0x2a0/0x608
 bus_add_driver from driver_register+0x24c/0x578
 driver_register from do_one_initcall+0x180/0x310
 do_one_initcall from kernel_init_freeable+0x424/0x484
 kernel_init_freeable from kernel_init+0x20/0x148
 kernel_init from ret_from_fork+0x14/0x28
Exception stack(0xc396bfb0 to 0xc396bff8)
bfa0:                                     00000000 00000000 00000000 00000000
bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
bfe0: 00000000 00000000 00000000 00000000 00000013 00000000

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


