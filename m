Return-Path: <linux-wireless+bounces-18695-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 079D9A2E717
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 09:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0D6016294D
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 08:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0143E1C173C;
	Mon, 10 Feb 2025 08:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=technux.se header.i=@technux.se header.b="KPjRa3GG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from m101-out-mua-2.websupport.se (m101-out-mua-2.websupport.se [109.235.175.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636751B87F1
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 08:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.235.175.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739177877; cv=none; b=C3j/Af+xf5rIMNfWBafi1HzuzdhAz41P49D3I5L/iSiWMijUkVoiZQ49z5c9cJeSpXC5i2UtNQSZtLd2cyO5UmoXAf9ej7KC8A4AhSo0cgqXhuIGk6xTuqE/zhiakVWdJv4jFlV9DvP0hoKwy5Ro6sJ/UZVlAVVIwvAMIc9oqGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739177877; c=relaxed/simple;
	bh=jV1OCprPNPXMUVT8LdxDCdF1Ny7xlcy2gSvEO+EVKvM=;
	h=MIME-Version:Date:From:To:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=mxSUVvrhW+VlP9bXpAES+Wl2sNUsjhDOaCmh/8fF4LNDEN0J7u4N0zYXVUClGMMwm8Toro6DJk99eBie4oGAP3XxAhoKTBRZAWdu5+We2S36Csk4zFjrGiyiB97oeApJm/ZG6O4u4KojpSqfwcf4ZS9V/Q172UC3evTzv2Zvd4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=technux.se; spf=pass smtp.mailfrom=technux.se; dkim=pass (2048-bit key) header.d=technux.se header.i=@technux.se header.b=KPjRa3GG; arc=none smtp.client-ip=109.235.175.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=technux.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=technux.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=technux.se; s=mail;
	t=1739177864; bh=erL/yD+CYCl9Vlw4qhCTdydItDWTrcxTvbYV7w5/m8o=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=KPjRa3GG+jF6zqq7SAio7OLnA1MTqTmJaj/mSRpOgZ3gw2/Nn7Z94CFTMmrzFc+QY
	 IN3HMUFZAYImoY/F1sGwcRBXVK7zCkP9BagdN/lFThqUpUTBweAsoDhuoixZiOtUPB
	 ZW1bonKwmkyB0JGHVDpPYLZg8yxQbsWghwBRDVLSV/ZnKT3SzEeoUNvrDBTt9LmQ1W
	 QOl/l0km0oBHoVz/tmF/edVSQCl6FL5zouLU5vnUzOcVDM0W8bNZgubt2Cj0DfmWLm
	 LGB/XCMo3LwCNKOHS51UQlRV3jhO5we7OBEwrBN0S6KYaQifFV0pr7cYjGnDrvOrIF
	 ld2YeFDIxNCUg==
Received: from m101-u5-ing.websupport.se (unknown [10.30.5.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by m101-out-mua-2.websupport.se (Postfix) with ESMTPS id 4Yrz476zT9zMKD;
	Mon, 10 Feb 2025 09:57:43 +0100 (CET)
X-Authenticated-Sender: petter@technux.se
Authentication-Results: m101-u5-ing.websupport.se;
	auth=pass smtp.auth=petter@technux.se smtp.mailfrom=petter@technux.se
Received: from roundcube.ws.int (unknown [109.235.175.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: petter@technux.se)
	by m101-u5-ing.websupport.se (Postfix) with ESMTPSA id 4Yrz474Jgmz2rSQ;
	Mon, 10 Feb 2025 09:57:43 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 10 Feb 2025 09:57:43 +0100
From: petter@technux.se
To: pkshih@realtek.com, rtl8821cerfe2@gmail.com, Linux wireless
 <linux-wireless@vger.kernel.org>
Subject: rtw88: 8821au: locking issues possible caused by firmware failed to
 leave lps state / failed to get tx report
In-Reply-To: <84d07bb6109ae42ce4e708d6e293f6de@technux.se>
References: <84d07bb6109ae42ce4e708d6e293f6de@technux.se>
User-Agent: Roundcube Webmail/1.6.9
Message-ID: <110cbd37e935161dbe0039a708f6428d@technux.se>
X-Sender: petter@technux.se
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Out-Rspamd-Server: m101-rspamd-out-5
X-Out-Rspamd-Queue-Id: 4Yrz474Jgmz2rSQ
X-Out-Spamd-Result: default: False [0.00 / 1000.00];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:41528, ipnet:109.235.175.0/24, country:SE];
	ARC_NA(0.00)[];
	WS_IP_WHITELIST(0.00)[109.235.175.26]
X-Rspamd-Pre-Result: action=no action;
	module=multimap;
	Matched map: WS_IP_WHITELIST
X-Rspamd-Action: no action
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 197992
X-purgate-ID: 155908::1739177863-C7C3EF5A-6F9C5EEB/0/0

Hi,

I have seen some issues with the LM808 dongle (8821au). I'm running 
6.12.12 kernel with all missing rtw88 patches cherry-picked from latest 
Linux-wireless main track. The dongle seems to be working fine most of 
the time, when running traffic and load it, but sometimes during low 
traffic/idle I can see below crash that loop around. Any good ideas what 
is going on here? (running on armhf based platform)

BR Petter

Issue 1:
================

Feb 08 10:32:08 machine kernel: rtw_8821au 1-1:1.0: firmware failed to 
leave lps state
Feb 08 10:32:08 machine kernel:
Feb 08 10:32:08 machine kernel: 
============================================
Feb 08 10:32:08 machine kernel: WARNING: possible recursive locking 
detected
Feb 08 10:32:08 machine kernel: 6.12.12-g8e187440f820 #0 Not tainted
Feb 08 10:32:08 machine kernel: 
--------------------------------------------
Feb 08 10:32:08 machine kernel: kworker/u4:4/25 is trying to acquire 
lock:
Feb 08 10:32:08 machine kernel: c4d8f050 (&rtwdev->mutex){+.+.}-{3:3}, 
at: rtw_leave_lps+0x1d4/0x208 [rtw88_core]
Feb 08 10:32:08 machine kernel:
                               but task is already holding lock:
Feb 08 10:32:08 machine kernel: c4d8f050 (&rtwdev->mutex){+.+.}-{3:3}, 
at: rtw_watch_dog_work+0x44/0x2e8 [rtw88_core]
Feb 08 10:32:08 machine kernel:
                               other info that might help us debug this:
Feb 08 10:32:08 machine kernel:  Possible unsafe locking scenario:
Feb 08 10:32:08 machine kernel:        CPU0
Feb 08 10:32:08 machine kernel:        ----
Feb 08 10:32:08 machine kernel:   lock(&rtwdev->mutex);
Feb 08 10:32:08 machine kernel:   lock(&rtwdev->mutex);
Feb 08 10:32:08 machine kernel:
                                *** DEADLOCK ***
Feb 08 10:32:08 machine kernel:  May be due to missing lock nesting 
notation
Feb 08 10:32:08 machine kernel: 3 locks held by kworker/u4:4/25:
Feb 08 10:32:08 machine kernel:  #0: c4eb64b4 
((wq_completion)phy0){+.+.}-{0:0}, at: process_one_work+0x1ac/0x71c
Feb 08 10:32:08 machine kernel:  #1: f090df20 
((work_completion)(&(&rtwdev->watch_dog_work)->work)){+.+.}-{0:0}, at: 
process_one_work+0x1d8/0x71c
Feb 08 10:32:08 machine kernel:  #2: c4d8f050 
(&rtwdev->mutex){+.+.}-{3:3}, at: rtw_watch_dog_work+0x44/0x2e8 
[rtw88_core]
Feb 08 10:32:08 machine kernel:
                               stack backtrace:
Feb 08 10:32:08 machine kernel: CPU: 0 UID: 0 PID: 25 Comm: kworker/u4:4 
Not tainted 6.12.12-g8e187440f820 #0
Feb 08 10:32:08 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 08 10:32:08 machine kernel: Workqueue: phy0 rtw_watch_dog_work 
[rtw88_core]
Feb 08 10:32:08 machine kernel: Call trace:
Feb 08 10:32:08 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 08 10:32:08 machine kernel:  show_stack from 
dump_stack_lvl+0x88/0xb8
Feb 08 10:32:08 machine kernel:  dump_stack_lvl from 
print_deadlock_bug+0x1d8/0x240
Feb 08 10:32:08 machine kernel:  print_deadlock_bug from 
__lock_acquire+0x1304/0x29d4
Feb 08 10:32:08 machine kernel:  __lock_acquire from 
lock_acquire.part.0+0xe0/0x29c
Feb 08 10:32:08 machine kernel:  lock_acquire.part.0 from 
__mutex_lock+0x9c/0x914
Feb 08 10:32:08 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 08 10:32:08 machine kernel:  mutex_lock_nested from 
rtw_leave_lps+0x1d4/0x208 [rtw88_core]
Feb 08 10:32:08 machine kernel:  rtw_leave_lps [rtw88_core] from 
rtw_watch_dog_work+0x1b8/0x2e8 [rtw88_core]
Feb 08 10:32:08 machine kernel:  rtw_watch_dog_work [rtw88_core] from 
process_one_work+0x244/0x71c
Feb 08 10:32:08 machine kernel:  process_one_work from 
worker_thread+0x170/0x350
Feb 08 10:32:08 machine kernel:  worker_thread from kthread+0x110/0x130
Feb 08 10:32:08 machine kernel:  kthread from ret_from_fork+0x14/0x24
Feb 08 10:32:08 machine kernel: Exception stack(0xf090dfb0 to 
0xf090dff8)
Feb 08 10:32:08 machine kernel: dfa0:                                    
  00000000 00000000 00000000 00000000
Feb 08 10:32:08 machine kernel: dfc0: 00000000 00000000 00000000 
00000000 00000000 00000000 00000000 00000000
Feb 08 10:32:08 machine kernel: dfe0: 00000000 00000000 00000000 
00000000 00000013 00000000
Feb 08 10:32:08 machine kernel: rtw_8821au 1-1:1.0: failed to get tx 
report from firmware
Feb 08 10:32:08 machine kernel: BUG: scheduling while atomic: 
swapper/0/0/0x00000103
Feb 08 10:32:08 machine kernel: INFO: lockdep is turned off.
Feb 08 10:32:08 machine kernel: Modules linked in: rtw88_8821au 
rtw88_8821a rtw88_88xxa rtw88_usb rtw88_core mac80211 libarc4 cfg80211 
imx_sdma ip_tables x_tables
Feb 08 10:32:08 machine kernel: irq event stamp: 1674268
Feb 08 10:32:08 machine kernel: hardirqs last  enabled at (1674267): 
[<c0100c58>] __irq_svc+0xb8/0xd4
Feb 08 10:32:08 machine kernel: hardirqs last disabled at (1674268): 
[<c0dc50d4>] __schedule+0x490/0xc70
Feb 08 10:32:08 machine kernel: softirqs last  enabled at (1674266): 
[<c012cbbc>] handle_softirqs+0x2b4/0x4a8
Feb 08 10:32:08 machine kernel: softirqs last disabled at (1674251): 
[<c012cf30>] __irq_exit_rcu+0x12c/0x198
Feb 08 10:32:08 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not 
tainted 6.12.12-g8e187440f820 #0
Feb 08 10:32:08 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 08 10:32:08 machine kernel: Call trace:
Feb 08 10:32:08 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 08 10:32:08 machine kernel:  show_stack from 
dump_stack_lvl+0x88/0xb8
Feb 08 10:32:08 machine kernel:  dump_stack_lvl from 
__schedule_bug+0x64/0x84
Feb 08 10:32:08 machine kernel:  __schedule_bug from 
__schedule+0x944/0xc70
Feb 08 10:32:08 machine kernel:  __schedule from schedule+0x50/0x130
Feb 08 10:32:08 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 08 10:32:08 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x7d4/0x914
Feb 08 10:32:08 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 08 10:32:08 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 08 10:32:08 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 08 10:32:08 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 08 10:32:08 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 08 10:32:08 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 08 10:32:08 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 08 10:32:08 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 08 10:32:08 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 08 10:32:08 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 08 10:32:08 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 08 10:32:08 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 08 10:32:08 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 08 10:32:08 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 60070013 
ffffffff
Feb 08 10:32:08 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 08 10:32:08 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 08 10:32:08 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 08 10:32:08 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 08 10:32:08 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 08 10:32:08 machine kernel: bad: scheduling from the idle thread!
Feb 08 10:32:08 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 08 10:32:08 machine kernel: Tainted: [W]=WARN
Feb 08 10:32:08 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 08 10:32:08 machine kernel: Call trace:
Feb 08 10:32:08 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 08 10:32:08 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 08 10:32:08 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 08 10:32:08 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 08 10:32:08 machine kernel:  __schedule from schedule+0x50/0x130
Feb 08 10:32:08 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 08 10:32:08 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 08 10:32:08 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 08 10:32:08 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 08 10:32:08 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 08 10:32:08 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 08 10:32:08 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 08 10:32:08 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 08 10:32:08 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 08 10:32:08 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 08 10:32:08 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 08 10:32:08 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 08 10:32:08 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 08 10:32:08 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 08 10:32:08 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 08 10:32:08 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 60070013 
ffffffff
Feb 08 10:32:08 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 08 10:32:08 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 08 10:32:08 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 08 10:32:08 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 08 10:32:08 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 08 10:32:09 machine kernel: bad: scheduling from the idle thread!
Feb 08 10:32:09 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 08 10:32:09 machine kernel: Tainted: [W]=WARN
Feb 08 10:32:09 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 08 10:32:09 machine kernel: Call trace:
Feb 08 10:32:09 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 08 10:32:09 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 08 10:32:09 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 08 10:32:09 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 08 10:32:09 machine kernel:  __schedule from schedule+0x50/0x130
Feb 08 10:32:09 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 08 10:32:09 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 08 10:32:09 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 08 10:32:09 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 08 10:32:09 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 08 10:32:09 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 08 10:32:09 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 08 10:32:09 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 08 10:32:09 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 08 10:32:09 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 08 10:32:09 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 08 10:32:09 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 08 10:32:09 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 08 10:32:09 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 08 10:32:09 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 08 10:32:09 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 60070013 
ffffffff
Feb 08 10:32:09 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 08 10:32:09 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 08 10:32:09 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 08 10:32:09 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 08 10:32:09 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 08 10:32:09 machine kernel: bad: scheduling from the idle thread!
Feb 08 10:32:09 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 08 10:32:09 machine kernel: Tainted: [W]=WARN
Feb 08 10:32:09 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 08 10:32:09 machine kernel: Call trace:
Feb 08 10:32:09 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 08 10:32:09 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 08 10:32:09 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 08 10:32:09 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 08 10:32:09 machine kernel:  __schedule from schedule+0x50/0x130
Feb 08 10:32:09 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 08 10:32:09 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 08 10:32:09 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 08 10:32:09 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 08 10:32:09 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 08 10:32:09 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 08 10:32:09 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 08 10:32:09 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 08 10:32:09 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 08 10:32:09 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 08 10:32:09 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 08 10:32:09 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 08 10:32:09 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 08 10:32:09 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 08 10:32:09 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 08 10:32:09 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 60070013 
ffffffff
Feb 08 10:32:09 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 08 10:32:09 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 08 10:32:09 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 08 10:32:09 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 08 10:32:09 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 08 10:32:09 machine kernel: bad: scheduling from the idle thread!
Feb 08 10:32:09 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 08 10:32:09 machine kernel: Tainted: [W]=WARN
Feb 08 10:32:09 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 08 10:32:09 machine kernel: Call trace:
Feb 08 10:32:09 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 08 10:32:09 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 08 10:32:09 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 08 10:32:09 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 08 10:32:09 machine kernel:  __schedule from schedule+0x50/0x130
Feb 08 10:32:09 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 08 10:32:09 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 08 10:32:09 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 08 10:32:09 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 08 10:32:09 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 08 10:32:09 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 08 10:32:09 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 08 10:32:09 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 08 10:32:09 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 08 10:32:09 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 08 10:32:09 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 08 10:32:09 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 08 10:32:09 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 08 10:32:09 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 08 10:32:09 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 08 10:32:09 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 60070013 
ffffffff
Feb 08 10:32:09 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 08 10:32:09 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 08 10:32:09 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 08 10:32:09 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 08 10:32:09 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 08 10:32:09 machine kernel: bad: scheduling from the idle thread!
Feb 08 10:32:09 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 08 10:32:09 machine kernel: Tainted: [W]=WARN
Feb 08 10:32:09 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 08 10:32:09 machine kernel: Call trace:
Feb 08 10:32:09 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 08 10:32:09 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 08 10:32:09 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 08 10:32:09 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 08 10:32:09 machine kernel:  __schedule from schedule+0x50/0x130
Feb 08 10:32:09 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 08 10:32:09 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 08 10:32:09 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 08 10:32:09 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 08 10:32:09 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 08 10:32:09 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 08 10:32:09 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 08 10:32:09 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 08 10:32:09 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 08 10:32:09 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 08 10:32:09 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 08 10:32:09 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 08 10:32:09 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 08 10:32:09 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 08 10:32:09 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 08 10:32:09 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 60070013 
ffffffff
Feb 08 10:32:09 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 08 10:32:09 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 08 10:32:09 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 08 10:32:09 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 08 10:32:09 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 08 10:32:09 machine kernel: bad: scheduling from the idle thread!
Feb 08 10:32:09 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 08 10:32:09 machine kernel: Tainted: [W]=WARN
Feb 08 10:32:09 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 08 10:32:09 machine kernel: Call trace:
Feb 08 10:32:09 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 08 10:32:09 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 08 10:32:09 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 08 10:32:09 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 08 10:32:09 machine kernel:  __schedule from schedule+0x50/0x130
Feb 08 10:32:09 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 08 10:32:09 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 08 10:32:09 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 08 10:32:09 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 08 10:32:09 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 08 10:32:09 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 08 10:32:09 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 08 10:32:09 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 08 10:32:09 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 08 10:32:09 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 08 10:32:09 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 08 10:32:09 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 08 10:32:09 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 08 10:32:09 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 08 10:32:09 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 08 10:32:09 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 60070013 
ffffffff
Feb 08 10:32:09 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 08 10:32:09 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 08 10:32:09 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 08 10:32:09 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 08 10:32:09 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 08 10:32:10 machine kernel: bad: scheduling from the idle thread!
Feb 08 10:32:10 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 08 10:32:10 machine kernel: Tainted: [W]=WARN
Feb 08 10:32:10 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 08 10:32:10 machine kernel: Call trace:
Feb 08 10:32:10 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 08 10:32:10 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 08 10:32:10 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 08 10:32:10 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 08 10:32:10 machine kernel:  __schedule from schedule+0x50/0x130
Feb 08 10:32:10 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 08 10:32:10 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 08 10:32:10 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 08 10:32:10 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 08 10:32:10 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 08 10:32:10 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 08 10:32:10 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 08 10:32:10 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 08 10:32:10 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 08 10:32:10 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 08 10:32:10 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 08 10:32:10 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 08 10:32:10 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 08 10:32:10 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 08 10:32:10 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 08 10:32:10 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 60070013 
ffffffff
Feb 08 10:32:10 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 08 10:32:10 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 08 10:32:10 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 08 10:32:10 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 08 10:32:10 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 08 10:32:10 machine kernel: bad: scheduling from the idle thread!
Feb 08 10:32:10 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 08 10:32:10 machine kernel: Tainted: [W]=WARN
Feb 08 10:32:10 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 08 10:32:10 machine kernel: Call trace:
Feb 08 10:32:10 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 08 10:32:10 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 08 10:32:10 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 08 10:32:10 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 08 10:32:10 machine kernel:  __schedule from schedule+0x50/0x130
Feb 08 10:32:10 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 08 10:32:10 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 08 10:32:10 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 08 10:32:10 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 08 10:32:10 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 08 10:32:10 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 08 10:32:10 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 08 10:32:10 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 08 10:32:10 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 08 10:32:10 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 08 10:32:10 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 08 10:32:10 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 08 10:32:10 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 08 10:32:10 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 08 10:32:10 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 08 10:32:10 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 60070013 
ffffffff
Feb 08 10:32:10 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 08 10:32:10 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 08 10:32:10 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 08 10:32:10 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 08 10:32:10 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 08 10:32:10 machine kernel: bad: scheduling from the idle thread!
Feb 08 10:32:10 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 08 10:32:10 machine kernel: Tainted: [W]=WARN
Feb 08 10:32:10 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 08 10:32:10 machine kernel: Call trace:
Feb 08 10:32:10 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 08 10:32:10 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 08 10:32:10 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 08 10:32:10 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 08 10:32:10 machine kernel:  __schedule from schedule+0x50/0x130
Feb 08 10:32:10 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 08 10:32:10 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 08 10:32:10 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 08 10:32:10 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 08 10:32:10 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 08 10:32:10 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 08 10:32:10 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 08 10:32:10 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 08 10:32:10 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 08 10:32:10 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 08 10:32:10 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 08 10:32:10 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 08 10:32:10 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 08 10:32:10 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 08 10:32:10 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 08 10:32:10 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 60070013 
ffffffff
Feb 08 10:32:10 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 08 10:32:10 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 08 10:32:10 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 08 10:32:10 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 08 10:32:10 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 08 10:32:10 machine kernel: bad: scheduling from the idle thread!
Feb 08 10:32:10 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 08 10:32:10 machine kernel: Tainted: [W]=WARN
Feb 08 10:32:10 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 08 10:32:10 machine kernel: Call trace:
Feb 08 10:32:10 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 08 10:32:10 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 08 10:32:10 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 08 10:32:10 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 08 10:32:10 machine kernel:  __schedule from schedule+0x50/0x130
Feb 08 10:32:10 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 08 10:32:10 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 08 10:32:10 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 08 10:32:10 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 08 10:32:10 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 08 10:32:10 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 08 10:32:10 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 08 10:32:10 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 08 10:32:10 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 08 10:32:10 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 08 10:32:10 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 08 10:32:10 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 08 10:32:10 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 08 10:32:10 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 08 10:32:10 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 08 10:32:10 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 60070013 
ffffffff
Feb 08 10:32:10 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 08 10:32:10 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 08 10:32:10 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 08 10:32:10 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 08 10:32:10 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 08 10:32:10 machine kernel: bad: scheduling from the idle thread!
Feb 08 10:32:10 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 08 10:32:10 machine kernel: Tainted: [W]=WARN
Feb 08 10:32:10 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 08 10:32:10 machine kernel: Call trace:
Feb 08 10:32:10 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 08 10:32:10 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 08 10:32:10 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 08 10:32:10 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 08 10:32:10 machine kernel:  __schedule from schedule+0x50/0x130
Feb 08 10:32:10 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 08 10:32:10 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 08 10:32:10 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 08 10:32:10 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 08 10:32:10 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 08 10:32:10 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 08 10:32:10 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 08 10:32:10 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 08 10:32:10 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 08 10:32:10 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 08 10:32:10 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 08 10:32:10 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 08 10:32:10 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 08 10:32:10 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 08 10:32:10 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 08 10:32:10 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 60070013 
ffffffff
Feb 08 10:32:10 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 08 10:32:10 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 08 10:32:10 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 08 10:32:10 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 08 10:32:10 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 08 10:32:10 machine kernel: bad: scheduling from the idle thread!
Feb 08 10:32:10 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 08 10:32:10 machine kernel: Tainted: [W]=WARN
Feb 08 10:32:10 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 08 10:32:10 machine kernel: Call trace:
Feb 08 10:32:10 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 08 10:32:10 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 08 10:32:10 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 08 10:32:10 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 08 10:32:10 machine kernel:  __schedule from schedule+0x50/0x130
Feb 08 10:32:10 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 08 10:32:10 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 08 10:32:10 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 08 10:32:10 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 08 10:32:10 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 08 10:32:10 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 08 10:32:10 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 08 10:32:10 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 08 10:32:10 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 08 10:32:10 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 08 10:32:10 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 08 10:32:10 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 08 10:32:10 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 08 10:32:10 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 08 10:32:10 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 08 10:32:10 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 60070013 
ffffffff
Feb 08 10:32:10 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 08 10:32:10 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 08 10:32:10 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 08 10:32:10 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 08 10:32:10 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 08 10:32:11 machine kernel: bad: scheduling from the idle thread!
Feb 08 10:32:11 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 08 10:32:11 machine kernel: Tainted: [W]=WARN
Feb 08 10:32:11 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 08 10:32:11 machine kernel: Call trace:
Feb 08 10:32:11 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 08 10:32:11 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 08 10:32:11 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 08 10:32:11 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 08 10:32:11 machine kernel:  __schedule from schedule+0x50/0x130
Feb 08 10:32:11 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 08 10:32:11 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 08 10:32:11 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 08 10:32:11 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 08 10:32:11 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 08 10:32:11 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 08 10:32:11 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 08 10:32:11 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 08 10:32:11 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8

Feb 08 10:32:08 banan kernel: rtw_8821au 1-1:1.0: firmware failed to 
leave lps state
Feb 08 10:32:08 banan kernel:
Feb 08 10:32:08 banan kernel: 
============================================
Feb 08 10:32:08 banan kernel: WARNING: possible recursive locking 
detected
Feb 08 10:32:08 banan kernel: 6.12.12-edge-g8e187440f820 #0 Not tainted
Feb 08 10:32:08 banan kernel: 
--------------------------------------------
Feb 08 10:32:08 banan kernel: kworker/u4:4/25 is trying to acquire lock:
Feb 08 10:32:08 banan kernel: c4d8f050 (&rtwdev->mutex){+.+.}-{3:3}, at: 
rtw_leave_lps+0x1d4/0x208 [rtw88_core]
Feb 08 10:32:08 banan kernel:
                               but task is already holding lock:
Feb 08 10:32:08 banan kernel: c4d8f050 (&rtwdev->mutex){+.+.}-{3:3}, at: 
rtw_watch_dog_work+0x44/0x2e8 [rtw88_core]
Feb 08 10:32:08 banan kernel:
                               other info that might help us debug this:
Feb 08 10:32:08 banan kernel:  Possible unsafe locking scenario:
Feb 08 10:32:08 banan kernel:        CPU0
Feb 08 10:32:08 banan kernel:        ----
Feb 08 10:32:08 banan kernel:   lock(&rtwdev->mutex);
Feb 08 10:32:08 banan kernel:   lock(&rtwdev->mutex);
Feb 08 10:32:08 banan kernel:
                                *** DEADLOCK ***
Feb 08 10:32:08 banan kernel:  May be due to missing lock nesting 
notation
Feb 08 10:32:08 banan kernel: 3 locks held by kworker/u4:4/25:
Feb 08 10:32:08 banan kernel:  #0: c4eb64b4 
((wq_completion)phy0){+.+.}-{0:0}, at: process_one_work+0x1ac/0x71c
Feb 08 10:32:08 banan kernel:  #1: f090df20 
((work_completion)(&(&rtwdev->watch_dog_work)->work)){+.+.}-{0:0}, at: 
process_one_work+0x1d8/0x71c
Feb 08 10:32:08 banan kernel:  #2: c4d8f050 
(&rtwdev->mutex){+.+.}-{3:3}, at: rtw_watch_dog_work+0x44/0x2e8 
[rtw88_core]
Feb 08 10:32:08 banan kernel:
                               stack backtrace:
Feb 08 10:32:08 banan kernel: CPU: 0 UID: 0 PID: 25 Comm: kworker/u4:4 
Not tainted 6.12.12-edge-g8e187440f820 #0
Feb 08 10:32:08 banan kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 08 10:32:08 banan kernel: Workqueue: phy0 rtw_watch_dog_work 
[rtw88_core]
Feb 08 10:32:08 banan kernel: Call trace:
Feb 08 10:32:08 banan kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 08 10:32:08 banan kernel:  show_stack from dump_stack_lvl+0x88/0xb8
Feb 08 10:32:08 banan kernel:  dump_stack_lvl from 
print_deadlock_bug+0x1d8/0x240
Feb 08 10:32:08 banan kernel:  print_deadlock_bug from 
__lock_acquire+0x1304/0x29d4
Feb 08 10:32:08 banan kernel:  __lock_acquire from 
lock_acquire.part.0+0xe0/0x29c
Feb 08 10:32:08 banan kernel:  lock_acquire.part.0 from 
__mutex_lock+0x9c/0x914
Feb 08 10:32:08 banan kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 08 10:32:08 banan kernel:  mutex_lock_nested from 
rtw_leave_lps+0x1d4/0x208 [rtw88_core]
Feb 08 10:32:08 banan kernel:  rtw_leave_lps [rtw88_core] from 
rtw_watch_dog_work+0x1b8/0x2e8 [rtw88_core]
Feb 08 10:32:08 banan kernel:  rtw_watch_dog_work [rtw88_core] from 
process_one_work+0x244/0x71c
Feb 08 10:32:08 banan kernel:  process_one_work from 
worker_thread+0x170/0x350
Feb 08 10:32:08 banan kernel:  worker_thread from kthread+0x110/0x130
Feb 08 10:32:08 banan kernel:  kthread from ret_from_fork+0x14/0x24
Feb 08 10:32:08 banan kernel: Exception stack(0xf090dfb0 to 0xf090dff8)
Feb 08 10:32:08 banan kernel: dfa0:                                     
00000000 00000000 00000000 00000000
Feb 08 10:32:08 banan kernel: dfc0: 00000000 00000000 00000000 00000000 
00000000 00000000 00000000 00000000
Feb 08 10:32:08 banan kernel: dfe0: 00000000 00000000 00000000 00000000 
00000013 00000000
Feb 08 10:32:08 banan kernel: rtw_8821au 1-1:1.0: failed to get tx 
report from firmware
Feb 08 10:32:08 banan kernel: BUG: scheduling while atomic: 
swapper/0/0/0x00000103
Feb 08 10:32:08 banan kernel: INFO: lockdep is turned off.
Feb 08 10:32:08 banan kernel: Modules linked in: rtw88_8821au 
rtw88_8821a rtw88_88xxa rtw88_usb rtw88_core mac80211 libarc4 cfg80211 
imx_sdma ip_tables x_tables
Feb 08 10:32:08 banan kernel: irq event stamp: 1674268
Feb 08 10:32:08 banan kernel: hardirqs last  enabled at (1674267): 
[<c0100c58>] __irq_svc+0xb8/0xd4
Feb 08 10:32:08 banan kernel: hardirqs last disabled at (1674268): 
[<c0dc50d4>] __schedule+0x490/0xc70
Feb 08 10:32:08 banan kernel: softirqs last  enabled at (1674266): 
[<c012cbbc>] handle_softirqs+0x2b4/0x4a8
Feb 08 10:32:08 banan kernel: softirqs last disabled at (1674251): 
[<c012cf30>] __irq_exit_rcu+0x12c/0x198
Feb 08 10:32:08 banan kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not 
tainted 6.12.12-edge-g8e187440f820 #0
Feb 08 10:32:08 banan kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 08 10:32:08 banan kernel: Call trace:
Feb 08 10:32:08 banan kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 08 10:32:08 banan kernel:  show_stack from dump_stack_lvl+0x88/0xb8
Feb 08 10:32:08 banan kernel:  dump_stack_lvl from 
__schedule_bug+0x64/0x84
Feb 08 10:32:08 banan kernel:  __schedule_bug from 
__schedule+0x944/0xc70
Feb 08 10:32:08 banan kernel:  __schedule from schedule+0x50/0x130
Feb 08 10:32:08 banan kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 08 10:32:08 banan kernel:  schedule_preempt_disabled from 
__mutex_lock+0x7d4/0x914
Feb 08 10:32:08 banan kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 08 10:32:08 banan kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 08 10:32:08 banan kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 08 10:32:08 banan kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 08 10:32:08 banan kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 08 10:32:08 banan kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 08 10:32:08 banan kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 08 10:32:08 banan kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 08 10:32:08 banan kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 08 10:32:08 banan kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 08 10:32:08 banan kernel: Exception stack(0xc1401f48 to 0xc1401f90)
Feb 08 10:32:08 banan kernel: 1f40:                   c0dc3ae0 2e43c000 
00000001 00000000 c017b020 c1416840
Feb 08 10:32:08 banan kernel: 1f60: c1416840 c14125c0 c11f3820 00000000 
00000068 ffffffff 00000000 c1401f98
Feb 08 10:32:08 banan kernel: 1f80: c0dc3ae0 c0dc3ae4 60070013 ffffffff
Feb 08 10:32:08 banan kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 08 10:32:08 banan kernel:  default_idle_call from do_idle+0xc0/0x128
Feb 08 10:32:08 banan kernel:  do_idle from cpu_startup_entry+0x28/0x2c
Feb 08 10:32:08 banan kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 08 10:32:08 banan kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 08 10:32:08 banan kernel: bad: scheduling from the idle thread!
Feb 08 10:32:08 banan kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-edge-g8e187440f820 #0
Feb 08 10:32:08 banan kernel: Tainted: [W]=WARN
Feb 08 10:32:08 banan kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 08 10:32:08 banan kernel: Call trace:
Feb 08 10:32:08 banan kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 08 10:32:08 banan kernel:  show_stack from dump_stack_lvl+0xa8/0xb8
Feb 08 10:32:08 banan kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 08 10:32:08 banan kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 08 10:32:08 banan kernel:  __schedule from schedule+0x50/0x130
Feb 08 10:32:08 banan kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 08 10:32:08 banan kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 08 10:32:08 banan kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 08 10:32:08 banan kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 08 10:32:08 banan kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 08 10:32:08 banan kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 08 10:32:08 banan kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 08 10:32:08 banan kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 08 10:32:08 banan kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 08 10:32:08 banan kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 08 10:32:08 banan kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 08 10:32:08 banan kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 08 10:32:08 banan kernel: Exception stack(0xc1401f48 to 0xc1401f90)
Feb 08 10:32:08 banan kernel: 1f40:                   c0dc3ae0 2e43c000 
00000001 00000000 c017b020 c1416840
Feb 08 10:32:08 banan kernel: 1f60: c1416840 c14125c0 c11f3820 00000000 
00000068 ffffffff 00000000 c1401f98
Feb 08 10:32:08 banan kernel: 1f80: c0dc3ae0 c0dc3ae4 60070013 ffffffff
Feb 08 10:32:08 banan kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 08 10:32:08 banan kernel:  default_idle_call from do_idle+0xc0/0x128
Feb 08 10:32:08 banan kernel:  do_idle from cpu_startup_entry+0x28/0x2c
Feb 08 10:32:08 banan kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 08 10:32:08 banan kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 08 10:32:09 banan kernel: bad: scheduling from the idle thread!
Feb 08 10:32:09 banan kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-edge-g8e187440f820 #0
Feb 08 10:32:09 banan kernel: Tainted: [W]=WARN
Feb 08 10:32:09 banan kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 08 10:32:09 banan kernel: Call trace:
Feb 08 10:32:09 banan kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 08 10:32:09 banan kernel:  show_stack from dump_stack_lvl+0xa8/0xb8
Feb 08 10:32:09 banan kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 08 10:32:09 banan kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 08 10:32:09 banan kernel:  __schedule from schedule+0x50/0x130
Feb 08 10:32:09 banan kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 08 10:32:09 banan kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 08 10:32:09 banan kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 08 10:32:09 banan kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 08 10:32:09 banan kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 08 10:32:09 banan kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 08 10:32:09 banan kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 08 10:32:09 banan kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 08 10:32:09 banan kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 08 10:32:09 banan kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 08 10:32:09 banan kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 08 10:32:09 banan kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 08 10:32:09 banan kernel: Exception stack(0xc1401f48 to 0xc1401f90)
Feb 08 10:32:09 banan kernel: 1f40:                   c0dc3ae0 2e43c000 
00000001 00000000 c017b020 c1416840
Feb 08 10:32:09 banan kernel: 1f60: c1416840 c14125c0 c11f3820 00000000 
00000068 ffffffff 00000000 c1401f98
Feb 08 10:32:09 banan kernel: 1f80: c0dc3ae0 c0dc3ae4 60070013 ffffffff
Feb 08 10:32:09 banan kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 08 10:32:09 banan kernel:  default_idle_call from do_idle+0xc0/0x128
Feb 08 10:32:09 banan kernel:  do_idle from cpu_startup_entry+0x28/0x2c
Feb 08 10:32:09 banan kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 08 10:32:09 banan kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 08 10:32:09 banan kernel: bad: scheduling from the idle thread!
Feb 08 10:32:09 banan kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-edge-g8e187440f820 #0
Feb 08 10:32:09 banan kernel: Tainted: [W]=WARN
Feb 08 10:32:09 banan kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 08 10:32:09 banan kernel: Call trace:
Feb 08 10:32:09 banan kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 08 10:32:09 banan kernel:  show_stack from dump_stack_lvl+0xa8/0xb8
Feb 08 10:32:09 banan kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 08 10:32:09 banan kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 08 10:32:09 banan kernel:  __schedule from schedule+0x50/0x130
Feb 08 10:32:09 banan kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 08 10:32:09 banan kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 08 10:32:09 banan kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 08 10:32:09 banan kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 08 10:32:09 banan kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 08 10:32:09 banan kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 08 10:32:09 banan kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 08 10:32:09 banan kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 08 10:32:09 banan kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 08 10:32:09 banan kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 08 10:32:09 banan kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 08 10:32:09 banan kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 08 10:32:09 banan kernel: Exception stack(0xc1401f48 to 0xc1401f90)
Feb 08 10:32:09 banan kernel: 1f40:                   c0dc3ae0 2e43c000 
00000001 00000000 c017b020 c1416840
Feb 08 10:32:09 banan kernel: 1f60: c1416840 c14125c0 c11f3820 00000000 
00000068 ffffffff 00000000 c1401f98
Feb 08 10:32:09 banan kernel: 1f80: c0dc3ae0 c0dc3ae4 60070013 ffffffff
Feb 08 10:32:09 banan kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 08 10:32:09 banan kernel:  default_idle_call from do_idle+0xc0/0x128
Feb 08 10:32:09 banan kernel:  do_idle from cpu_startup_entry+0x28/0x2c
Feb 08 10:32:09 banan kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 08 10:32:09 banan kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 08 10:32:09 banan kernel: bad: scheduling from the idle thread!
Feb 08 10:32:09 banan kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-edge-g8e187440f820 #0
Feb 08 10:32:09 banan kernel: Tainted: [W]=WARN
Feb 08 10:32:09 banan kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 08 10:32:09 banan kernel: Call trace:
Feb 08 10:32:09 banan kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 08 10:32:09 banan kernel:  show_stack from dump_stack_lvl+0xa8/0xb8
Feb 08 10:32:09 banan kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 08 10:32:09 banan kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 08 10:32:09 banan kernel:  __schedule from schedule+0x50/0x130
Feb 08 10:32:09 banan kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 08 10:32:09 banan kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 08 10:32:09 banan kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 08 10:32:09 banan kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 08 10:32:09 banan kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 08 10:32:09 banan kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 08 10:32:09 banan kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 08 10:32:09 banan kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 08 10:32:09 banan kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 08 10:32:09 banan kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 08 10:32:09 banan kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 08 10:32:09 banan kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 08 10:32:09 banan kernel: Exception stack(0xc1401f48 to 0xc1401f90)
Feb 08 10:32:09 banan kernel: 1f40:                   c0dc3ae0 2e43c000 
00000001 00000000 c017b020 c1416840
Feb 08 10:32:09 banan kernel: 1f60: c1416840 c14125c0 c11f3820 00000000 
00000068 ffffffff 00000000 c1401f98
Feb 08 10:32:09 banan kernel: 1f80: c0dc3ae0 c0dc3ae4 60070013 ffffffff
Feb 08 10:32:09 banan kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 08 10:32:09 banan kernel:  default_idle_call from do_idle+0xc0/0x128
Feb 08 10:32:09 banan kernel:  do_idle from cpu_startup_entry+0x28/0x2c
Feb 08 10:32:09 banan kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 08 10:32:09 banan kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 08 10:32:09 banan kernel: bad: scheduling from the idle thread!
Feb 08 10:32:09 banan kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-edge-g8e187440f820 #0
Feb 08 10:32:09 banan kernel: Tainted: [W]=WARN
Feb 08 10:32:09 banan kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 08 10:32:09 banan kernel: Call trace:
Feb 08 10:32:09 banan kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 08 10:32:09 banan kernel:  show_stack from dump_stack_lvl+0xa8/0xb8
Feb 08 10:32:09 banan kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 08 10:32:09 banan kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 08 10:32:09 banan kernel:  __schedule from schedule+0x50/0x130
Feb 08 10:32:09 banan kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 08 10:32:09 banan kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 08 10:32:09 banan kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 08 10:32:09 banan kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 08 10:32:09 banan kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 08 10:32:09 banan kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 08 10:32:09 banan kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 08 10:32:09 banan kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 08 10:32:09 banan kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 08 10:32:09 banan kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 08 10:32:09 banan kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 08 10:32:09 banan kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 08 10:32:09 banan kernel: Exception stack(0xc1401f48 to 0xc1401f90)
Feb 08 10:32:09 banan kernel: 1f40:                   c0dc3ae0 2e43c000 
00000001 00000000 c017b020 c1416840
Feb 08 10:32:09 banan kernel: 1f60: c1416840 c14125c0 c11f3820 00000000 
00000068 ffffffff 00000000 c1401f98
Feb 08 10:32:09 banan kernel: 1f80: c0dc3ae0 c0dc3ae4 60070013 ffffffff
Feb 08 10:32:09 banan kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 08 10:32:09 banan kernel:  default_idle_call from do_idle+0xc0/0x128
Feb 08 10:32:09 banan kernel:  do_idle from cpu_startup_entry+0x28/0x2c
Feb 08 10:32:09 banan kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 08 10:32:09 banan kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 08 10:32:09 banan kernel: bad: scheduling from the idle thread!
Feb 08 10:32:09 banan kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-edge-g8e187440f820 #0
Feb 08 10:32:09 banan kernel: Tainted: [W]=WARN
Feb 08 10:32:09 banan kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 08 10:32:09 banan kernel: Call trace:
Feb 08 10:32:09 banan kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 08 10:32:09 banan kernel:  show_stack from dump_stack_lvl+0xa8/0xb8
Feb 08 10:32:09 banan kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 08 10:32:09 banan kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 08 10:32:09 banan kernel:  __schedule from schedule+0x50/0x130
Feb 08 10:32:09 banan kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 08 10:32:09 banan kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 08 10:32:09 banan kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 08 10:32:09 banan kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 08 10:32:09 banan kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 08 10:32:09 banan kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 08 10:32:09 banan kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 08 10:32:09 banan kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 08 10:32:09 banan kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 08 10:32:09 banan kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 08 10:32:09 banan kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 08 10:32:09 banan kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 08 10:32:09 banan kernel: Exception stack(0xc1401f48 to 0xc1401f90)
Feb 08 10:32:09 banan kernel: 1f40:                   c0dc3ae0 2e43c000 
00000001 00000000 c017b020 c1416840
Feb 08 10:32:09 banan kernel: 1f60: c1416840 c14125c0 c11f3820 00000000 
00000068 ffffffff 00000000 c1401f98
Feb 08 10:32:09 banan kernel: 1f80: c0dc3ae0 c0dc3ae4 60070013 ffffffff
Feb 08 10:32:09 banan kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 08 10:32:09 banan kernel:  default_idle_call from do_idle+0xc0/0x128
Feb 08 10:32:09 banan kernel:  do_idle from cpu_startup_entry+0x28/0x2c
Feb 08 10:32:09 banan kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 08 10:32:09 banan kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 08 10:32:10 banan kernel: bad: scheduling from the idle thread!
Feb 08 10:32:10 banan kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-edge-g8e187440f820 #0
Feb 08 10:32:10 banan kernel: Tainted: [W]=WARN
Feb 08 10:32:10 banan kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 08 10:32:10 banan kernel: Call trace:
Feb 08 10:32:10 banan kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 08 10:32:10 banan kernel:  show_stack from dump_stack_lvl+0xa8/0xb8
Feb 08 10:32:10 banan kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 08 10:32:10 banan kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 08 10:32:10 banan kernel:  __schedule from schedule+0x50/0x130
Feb 08 10:32:10 banan kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 08 10:32:10 banan kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 08 10:32:10 banan kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 08 10:32:10 banan kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 08 10:32:10 banan kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 08 10:32:10 banan kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 08 10:32:10 banan kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 08 10:32:10 banan kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 08 10:32:10 banan kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 08 10:32:10 banan kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 08 10:32:10 banan kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 08 10:32:10 banan kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 08 10:32:10 banan kernel: Exception stack(0xc1401f48 to 0xc1401f90)
Feb 08 10:32:10 banan kernel: 1f40:                   c0dc3ae0 2e43c000 
00000001 00000000 c017b020 c1416840
Feb 08 10:32:10 banan kernel: 1f60: c1416840 c14125c0 c11f3820 00000000 
00000068 ffffffff 00000000 c1401f98
Feb 08 10:32:10 banan kernel: 1f80: c0dc3ae0 c0dc3ae4 60070013 ffffffff
Feb 08 10:32:10 banan kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 08 10:32:10 banan kernel:  default_idle_call from do_idle+0xc0/0x128
Feb 08 10:32:10 banan kernel:  do_idle from cpu_startup_entry+0x28/0x2c
Feb 08 10:32:10 banan kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 08 10:32:10 banan kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 08 10:32:10 banan kernel: bad: scheduling from the idle thread!
Feb 08 10:32:10 banan kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-edge-g8e187440f820 #0
Feb 08 10:32:10 banan kernel: Tainted: [W]=WARN
Feb 08 10:32:10 banan kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 08 10:32:10 banan kernel: Call trace:
Feb 08 10:32:10 banan kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 08 10:32:10 banan kernel:  show_stack from dump_stack_lvl+0xa8/0xb8
Feb 08 10:32:10 banan kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 08 10:32:10 banan kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 08 10:32:10 banan kernel:  __schedule from schedule+0x50/0x130
Feb 08 10:32:10 banan kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 08 10:32:10 banan kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 08 10:32:10 banan kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 08 10:32:10 banan kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 08 10:32:10 banan kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 08 10:32:10 banan kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 08 10:32:10 banan kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 08 10:32:10 banan kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 08 10:32:10 banan kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 08 10:32:10 banan kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 08 10:32:10 banan kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 08 10:32:10 banan kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 08 10:32:10 banan kernel: Exception stack(0xc1401f48 to 0xc1401f90)
Feb 08 10:32:10 banan kernel: 1f40:                   c0dc3ae0 2e43c000 
00000001 00000000 c017b020 c1416840
Feb 08 10:32:10 banan kernel: 1f60: c1416840 c14125c0 c11f3820 00000000 
00000068 ffffffff 00000000 c1401f98
Feb 08 10:32:10 banan kernel: 1f80: c0dc3ae0 c0dc3ae4 60070013 ffffffff
Feb 08 10:32:10 banan kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 08 10:32:10 banan kernel:  default_idle_call from do_idle+0xc0/0x128
Feb 08 10:32:10 banan kernel:  do_idle from cpu_startup_entry+0x28/0x2c
Feb 08 10:32:10 banan kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 08 10:32:10 banan kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 08 10:32:10 banan kernel: bad: scheduling from the idle thread!
Feb 08 10:32:10 banan kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-edge-g8e187440f820 #0
Feb 08 10:32:10 banan kernel: Tainted: [W]=WARN
Feb 08 10:32:10 banan kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 08 10:32:10 banan kernel: Call trace:
Feb 08 10:32:10 banan kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 08 10:32:10 banan kernel:  show_stack from dump_stack_lvl+0xa8/0xb8
Feb 08 10:32:10 banan kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 08 10:32:10 banan kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 08 10:32:10 banan kernel:  __schedule from schedule+0x50/0x130
Feb 08 10:32:10 banan kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 08 10:32:10 banan kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 08 10:32:10 banan kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 08 10:32:10 banan kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 08 10:32:10 banan kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 08 10:32:10 banan kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 08 10:32:10 banan kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 08 10:32:10 banan kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 08 10:32:10 banan kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 08 10:32:10 banan kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 08 10:32:10 banan kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 08 10:32:10 banan kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 08 10:32:10 banan kernel: Exception stack(0xc1401f48 to 0xc1401f90)
Feb 08 10:32:10 banan kernel: 1f40:                   c0dc3ae0 2e43c000 
00000001 00000000 c017b020 c1416840
Feb 08 10:32:10 banan kernel: 1f60: c1416840 c14125c0 c11f3820 00000000 
00000068 ffffffff 00000000 c1401f98
Feb 08 10:32:10 banan kernel: 1f80: c0dc3ae0 c0dc3ae4 60070013 ffffffff
Feb 08 10:32:10 banan kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 08 10:32:10 banan kernel:  default_idle_call from do_idle+0xc0/0x128
Feb 08 10:32:10 banan kernel:  do_idle from cpu_startup_entry+0x28/0x2c
Feb 08 10:32:10 banan kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 08 10:32:10 banan kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 08 10:32:10 banan kernel: bad: scheduling from the idle thread!
Feb 08 10:32:10 banan kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-edge-g8e187440f820 #0
Feb 08 10:32:10 banan kernel: Tainted: [W]=WARN
Feb 08 10:32:10 banan kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 08 10:32:10 banan kernel: Call trace:
Feb 08 10:32:10 banan kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 08 10:32:10 banan kernel:  show_stack from dump_stack_lvl+0xa8/0xb8
Feb 08 10:32:10 banan kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 08 10:32:10 banan kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 08 10:32:10 banan kernel:  __schedule from schedule+0x50/0x130
Feb 08 10:32:10 banan kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 08 10:32:10 banan kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 08 10:32:10 banan kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 08 10:32:10 banan kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 08 10:32:10 banan kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 08 10:32:10 banan kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 08 10:32:10 banan kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 08 10:32:10 banan kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 08 10:32:10 banan kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 08 10:32:10 banan kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 08 10:32:10 banan kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 08 10:32:10 banan kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 08 10:32:10 banan kernel: Exception stack(0xc1401f48 to 0xc1401f90)
Feb 08 10:32:10 banan kernel: 1f40:                   c0dc3ae0 2e43c000 
00000001 00000000 c017b020 c1416840
Feb 08 10:32:10 banan kernel: 1f60: c1416840 c14125c0 c11f3820 00000000 
00000068 ffffffff 00000000 c1401f98
Feb 08 10:32:10 banan kernel: 1f80: c0dc3ae0 c0dc3ae4 60070013 ffffffff
Feb 08 10:32:10 banan kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 08 10:32:10 banan kernel:  default_idle_call from do_idle+0xc0/0x128
Feb 08 10:32:10 banan kernel:  do_idle from cpu_startup_entry+0x28/0x2c
Feb 08 10:32:10 banan kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 08 10:32:10 banan kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 08 10:32:10 banan kernel: bad: scheduling from the idle thread!
Feb 08 10:32:10 banan kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-edge-g8e187440f820 #0
Feb 08 10:32:10 banan kernel: Tainted: [W]=WARN
Feb 08 10:32:10 banan kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 08 10:32:10 banan kernel: Call trace:
Feb 08 10:32:10 banan kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 08 10:32:10 banan kernel:  show_stack from dump_stack_lvl+0xa8/0xb8
Feb 08 10:32:10 banan kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 08 10:32:10 banan kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 08 10:32:10 banan kernel:  __schedule from schedule+0x50/0x130
Feb 08 10:32:10 banan kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 08 10:32:10 banan kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 08 10:32:10 banan kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 08 10:32:10 banan kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 08 10:32:10 banan kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 08 10:32:10 banan kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 08 10:32:10 banan kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 08 10:32:10 banan kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 08 10:32:10 banan kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 08 10:32:10 banan kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 08 10:32:10 banan kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 08 10:32:10 banan kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 08 10:32:10 banan kernel: Exception stack(0xc1401f48 to 0xc1401f90)
Feb 08 10:32:10 banan kernel: 1f40:                   c0dc3ae0 2e43c000 
00000001 00000000 c017b020 c1416840
Feb 08 10:32:10 banan kernel: 1f60: c1416840 c14125c0 c11f3820 00000000 
00000068 ffffffff 00000000 c1401f98
Feb 08 10:32:10 banan kernel: 1f80: c0dc3ae0 c0dc3ae4 60070013 ffffffff
Feb 08 10:32:10 banan kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 08 10:32:10 banan kernel:  default_idle_call from do_idle+0xc0/0x128
Feb 08 10:32:10 banan kernel:  do_idle from cpu_startup_entry+0x28/0x2c
Feb 08 10:32:10 banan kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 08 10:32:10 banan kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 08 10:32:10 banan kernel: bad: scheduling from the idle thread!
Feb 08 10:32:10 banan kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-edge-g8e187440f820 #0
Feb 08 10:32:10 banan kernel: Tainted: [W]=WARN
Feb 08 10:32:10 banan kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 08 10:32:10 banan kernel: Call trace:
Feb 08 10:32:10 banan kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 08 10:32:10 banan kernel:  show_stack from dump_stack_lvl+0xa8/0xb8
Feb 08 10:32:10 banan kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 08 10:32:10 banan kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 08 10:32:10 banan kernel:  __schedule from schedule+0x50/0x130
Feb 08 10:32:10 banan kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 08 10:32:10 banan kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 08 10:32:10 banan kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 08 10:32:10 banan kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 08 10:32:10 banan kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 08 10:32:10 banan kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 08 10:32:10 banan kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 08 10:32:10 banan kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 08 10:32:10 banan kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 08 10:32:10 banan kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 08 10:32:10 banan kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 08 10:32:10 banan kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 08 10:32:10 banan kernel: Exception stack(0xc1401f48 to 0xc1401f90)
Feb 08 10:32:10 banan kernel: 1f40:                   c0dc3ae0 2e43c000 
00000001 00000000 c017b020 c1416840
Feb 08 10:32:10 banan kernel: 1f60: c1416840 c14125c0 c11f3820 00000000 
00000068 ffffffff 00000000 c1401f98
Feb 08 10:32:10 banan kernel: 1f80: c0dc3ae0 c0dc3ae4 60070013 ffffffff
Feb 08 10:32:10 banan kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 08 10:32:10 banan kernel:  default_idle_call from do_idle+0xc0/0x128
Feb 08 10:32:10 banan kernel:  do_idle from cpu_startup_entry+0x28/0x2c
Feb 08 10:32:10 banan kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 08 10:32:10 banan kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 08 10:32:11 banan kernel: bad: scheduling from the idle thread!
Feb 08 10:32:11 banan kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-edge-g8e187440f820 #0
Feb 08 10:32:11 banan kernel: Tainted: [W]=WARN
Feb 08 10:32:11 banan kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 08 10:32:11 banan kernel: Call trace:
Feb 08 10:32:11 banan kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 08 10:32:11 banan kernel:  show_stack from dump_stack_lvl+0xa8/0xb8
Feb 08 10:32:11 banan kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 08 10:32:11 banan kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 08 10:32:11 banan kernel:  __schedule from schedule+0x50/0x130
Feb 08 10:32:11 banan kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 08 10:32:11 banan kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 08 10:32:11 banan kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 08 10:32:11 banan kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 08 10:32:11 banan kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 08 10:32:11 banan kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 08 10:32:11 banan kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 08 10:32:11 banan kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 08 10:32:11 banan kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8


Issue 2:
================

Feb 07 20:23:45 machine kernel: rtw_8821au 1-1:1.0: firmware failed to 
leave lps state
Feb 07 20:23:46 machine kernel: rtw_8821au 1-1:1.0: failed to get tx 
report from firmware
Feb 07 20:23:46 machine kernel: BUG: scheduling while atomic: 
swapper/0/0/0x00000103
Feb 07 20:23:46 machine kernel: INFO: lockdep is turned off.
Feb 07 20:23:46 machine kernel: Modules linked in: rtw88_8821au 
rtw88_8821a rtw88_88xxa rtw88_usb rtw88_core mac80211 libarc4 cfg80211 
imx_sdma ip_tables x_tables
Feb 07 20:23:46 machine kernel: irq event stamp: 10781843
Feb 07 20:23:46 machine kernel: hardirqs last  enabled at (10781842): 
[<c0100c58>] __irq_svc+0xb8/0xd4
Feb 07 20:23:46 machine kernel: hardirqs last disabled at (10781843): 
[<c0dcf33c>] _raw_spin_lock_irqsave+0x64/0x68
Feb 07 20:23:46 machine kernel: softirqs last  enabled at (10781808): 
[<c012cbbc>] handle_softirqs+0x2b4/0x4a8
Feb 07 20:23:46 machine kernel: softirqs last disabled at (10781821): 
[<c012cf30>] __irq_exit_rcu+0x12c/0x198
Feb 07 20:23:46 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not 
tainted 6.12.12-g8e187440f820 #0
Feb 07 20:23:46 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 07 20:23:46 machine kernel: Call trace:
Feb 07 20:23:46 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 07 20:23:46 machine kernel:  show_stack from 
dump_stack_lvl+0x88/0xb8
Feb 07 20:23:46 machine kernel:  dump_stack_lvl from 
__schedule_bug+0x64/0x84
Feb 07 20:23:46 machine kernel:  __schedule_bug from 
__schedule+0x944/0xc70
Feb 07 20:23:46 machine kernel:  __schedule from schedule+0x50/0x130
Feb 07 20:23:46 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 07 20:23:46 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x7d4/0x914
Feb 07 20:23:46 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 07 20:23:46 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 07 20:23:46 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 07 20:23:46 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 07 20:23:46 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 07 20:23:46 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 07 20:23:46 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 07 20:23:46 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 07 20:23:46 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 07 20:23:46 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 07 20:23:46 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 07 20:23:46 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 07 20:23:46 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 07 20:23:46 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 600e0013 
ffffffff
Feb 07 20:23:46 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 07 20:23:46 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 07 20:23:46 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 07 20:23:46 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 07 20:23:46 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 07 20:23:46 machine kernel: bad: scheduling from the idle thread!
Feb 07 20:23:46 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 07 20:23:46 machine kernel: Tainted: [W]=WARN
Feb 07 20:23:46 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 07 20:23:46 machine kernel: Call trace:
Feb 07 20:23:46 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 07 20:23:46 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 07 20:23:46 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 07 20:23:46 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 07 20:23:46 machine kernel:  __schedule from schedule+0x50/0x130
Feb 07 20:23:46 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 07 20:23:46 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 07 20:23:46 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 07 20:23:46 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 07 20:23:46 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 07 20:23:46 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 07 20:23:46 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 07 20:23:46 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 07 20:23:46 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 07 20:23:46 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 07 20:23:46 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 07 20:23:46 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 07 20:23:46 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 07 20:23:46 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 07 20:23:46 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 07 20:23:46 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 600e0013 
ffffffff
Feb 07 20:23:46 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 07 20:23:46 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 07 20:23:46 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 07 20:23:46 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 07 20:23:46 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 07 20:23:46 machine kernel: bad: scheduling from the idle thread!
Feb 07 20:23:46 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 07 20:23:46 machine kernel: Tainted: [W]=WARN
Feb 07 20:23:46 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 07 20:23:46 machine kernel: Call trace:
Feb 07 20:23:46 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 07 20:23:46 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 07 20:23:46 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 07 20:23:46 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 07 20:23:46 machine kernel:  __schedule from schedule+0x50/0x130
Feb 07 20:23:46 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 07 20:23:46 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 07 20:23:46 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 07 20:23:46 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 07 20:23:46 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 07 20:23:46 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 07 20:23:46 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 07 20:23:46 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 07 20:23:46 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 07 20:23:46 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 07 20:23:46 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 07 20:23:46 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 07 20:23:46 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 07 20:23:46 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 07 20:23:46 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 07 20:23:46 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 600e0013 
ffffffff
Feb 07 20:23:46 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 07 20:23:46 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 07 20:23:46 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 07 20:23:46 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 07 20:23:46 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 07 20:23:47 machine kernel: bad: scheduling from the idle thread!
Feb 07 20:23:47 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 07 20:23:47 machine kernel: Tainted: [W]=WARN
Feb 07 20:23:47 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 07 20:23:47 machine kernel: Call trace:
Feb 07 20:23:47 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 07 20:23:47 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 07 20:23:47 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 07 20:23:47 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 07 20:23:47 machine kernel:  __schedule from schedule+0x50/0x130
Feb 07 20:23:47 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 07 20:23:47 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 07 20:23:47 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 07 20:23:47 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 07 20:23:47 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 07 20:23:47 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 07 20:23:47 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 07 20:23:47 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 07 20:23:47 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 07 20:23:47 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 07 20:23:47 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 07 20:23:47 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 07 20:23:47 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 07 20:23:47 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 07 20:23:47 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 07 20:23:47 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 600e0013 
ffffffff
Feb 07 20:23:47 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 07 20:23:47 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 07 20:23:47 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 07 20:23:47 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 07 20:23:47 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 07 20:23:47 machine kernel: bad: scheduling from the idle thread!
Feb 07 20:23:47 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 07 20:23:47 machine kernel: Tainted: [W]=WARN
Feb 07 20:23:47 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 07 20:23:47 machine kernel: Call trace:
Feb 07 20:23:47 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 07 20:23:47 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 07 20:23:47 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 07 20:23:47 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 07 20:23:47 machine kernel:  __schedule from schedule+0x50/0x130
Feb 07 20:23:47 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 07 20:23:47 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 07 20:23:47 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 07 20:23:47 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 07 20:23:47 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 07 20:23:47 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 07 20:23:47 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 07 20:23:47 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 07 20:23:47 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 07 20:23:47 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 07 20:23:47 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 07 20:23:47 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 07 20:23:47 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 07 20:23:47 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 07 20:23:47 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 07 20:23:47 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 600e0013 
ffffffff
Feb 07 20:23:47 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 07 20:23:47 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 07 20:23:47 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 07 20:23:47 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 07 20:23:47 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 07 20:23:47 machine kernel: bad: scheduling from the idle thread!
Feb 07 20:23:47 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 07 20:23:47 machine kernel: Tainted: [W]=WARN
Feb 07 20:23:47 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 07 20:23:47 machine kernel: Call trace:
Feb 07 20:23:47 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 07 20:23:47 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 07 20:23:47 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 07 20:23:47 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 07 20:23:47 machine kernel:  __schedule from schedule+0x50/0x130
Feb 07 20:23:47 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 07 20:23:47 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 07 20:23:47 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 07 20:23:47 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 07 20:23:47 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 07 20:23:47 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 07 20:23:47 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 07 20:23:47 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 07 20:23:47 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 07 20:23:47 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 07 20:23:47 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 07 20:23:47 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 07 20:23:47 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 07 20:23:47 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 07 20:23:47 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 07 20:23:47 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 600e0013 
ffffffff
Feb 07 20:23:47 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 07 20:23:47 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 07 20:23:47 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 07 20:23:47 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 07 20:23:47 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 07 20:23:47 machine kernel: bad: scheduling from the idle thread!
Feb 07 20:23:47 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 07 20:23:47 machine kernel: Tainted: [W]=WARN
Feb 07 20:23:47 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 07 20:23:47 machine kernel: Call trace:
Feb 07 20:23:47 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 07 20:23:47 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 07 20:23:47 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 07 20:23:47 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 07 20:23:47 machine kernel:  __schedule from schedule+0x50/0x130
Feb 07 20:23:47 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 07 20:23:47 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 07 20:23:47 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 07 20:23:47 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 07 20:23:47 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 07 20:23:47 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 07 20:23:47 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 07 20:23:47 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 07 20:23:47 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 07 20:23:47 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 07 20:23:47 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 07 20:23:47 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 07 20:23:47 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 07 20:23:47 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 07 20:23:47 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 07 20:23:47 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 600e0013 
ffffffff
Feb 07 20:23:47 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 07 20:23:47 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 07 20:23:47 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 07 20:23:47 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 07 20:23:47 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 07 20:23:47 machine kernel: bad: scheduling from the idle thread!
Feb 07 20:23:47 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 07 20:23:47 machine kernel: Tainted: [W]=WARN
Feb 07 20:23:47 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 07 20:23:47 machine kernel: Call trace:
Feb 07 20:23:47 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 07 20:23:47 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 07 20:23:47 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 07 20:23:47 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 07 20:23:47 machine kernel:  __schedule from schedule+0x50/0x130
Feb 07 20:23:47 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 07 20:23:47 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 07 20:23:47 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 07 20:23:47 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 07 20:23:47 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 07 20:23:47 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 07 20:23:47 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 07 20:23:47 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 07 20:23:47 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 07 20:23:47 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 07 20:23:47 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 07 20:23:47 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 07 20:23:47 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 07 20:23:47 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 07 20:23:47 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 07 20:23:47 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 600e0013 
ffffffff
Feb 07 20:23:47 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 07 20:23:47 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 07 20:23:47 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 07 20:23:47 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 07 20:23:47 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 07 20:23:48 machine kernel: bad: scheduling from the idle thread!
Feb 07 20:23:48 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 07 20:23:48 machine kernel: Tainted: [W]=WARN
Feb 07 20:23:48 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 07 20:23:48 machine kernel: Call trace:
Feb 07 20:23:48 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 07 20:23:48 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 07 20:23:48 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 07 20:23:48 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 07 20:23:48 machine kernel:  __schedule from schedule+0x50/0x130
Feb 07 20:23:48 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 07 20:23:48 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 07 20:23:48 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 07 20:23:48 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 07 20:23:48 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 07 20:23:48 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 07 20:23:48 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 07 20:23:48 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 07 20:23:48 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 07 20:23:48 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 07 20:23:48 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 07 20:23:48 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 07 20:23:48 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 07 20:23:48 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 07 20:23:48 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 07 20:23:48 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 600e0013 
ffffffff
Feb 07 20:23:48 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 07 20:23:48 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 07 20:23:48 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 07 20:23:48 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 07 20:23:48 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 07 20:23:48 machine kernel: bad: scheduling from the idle thread!
Feb 07 20:23:48 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 07 20:23:48 machine kernel: Tainted: [W]=WARN
Feb 07 20:23:48 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 07 20:23:48 machine kernel: Call trace:
Feb 07 20:23:48 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 07 20:23:48 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 07 20:23:48 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 07 20:23:48 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 07 20:23:48 machine kernel:  __schedule from schedule+0x50/0x130
Feb 07 20:23:48 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 07 20:23:48 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 07 20:23:48 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 07 20:23:48 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 07 20:23:48 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 07 20:23:48 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 07 20:23:48 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 07 20:23:48 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 07 20:23:48 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 07 20:23:48 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 07 20:23:48 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 07 20:23:48 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 07 20:23:48 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 07 20:23:48 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 07 20:23:48 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 07 20:23:48 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 600e0013 
ffffffff
Feb 07 20:23:48 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 07 20:23:48 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 07 20:23:48 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 07 20:23:48 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 07 20:23:48 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 07 20:23:48 machine kernel: bad: scheduling from the idle thread!
Feb 07 20:23:48 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 07 20:23:48 machine kernel: Tainted: [W]=WARN
Feb 07 20:23:48 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 07 20:23:48 machine kernel: Call trace:
Feb 07 20:23:48 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 07 20:23:48 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 07 20:23:48 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 07 20:23:48 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 07 20:23:48 machine kernel:  __schedule from schedule+0x50/0x130
Feb 07 20:23:48 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 07 20:23:48 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 07 20:23:48 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 07 20:23:48 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 07 20:23:48 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 07 20:23:48 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 07 20:23:48 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 07 20:23:48 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 07 20:23:48 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 07 20:23:48 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 07 20:23:48 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 07 20:23:48 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 07 20:23:48 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 07 20:23:48 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 07 20:23:48 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 07 20:23:48 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 600e0013 
ffffffff
Feb 07 20:23:48 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 07 20:23:48 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 07 20:23:48 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 07 20:23:48 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 07 20:23:48 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 07 20:23:48 machine kernel: bad: scheduling from the idle thread!
Feb 07 20:23:48 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 07 20:23:48 machine kernel: Tainted: [W]=WARN
Feb 07 20:23:48 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 07 20:23:48 machine kernel: Call trace:
Feb 07 20:23:48 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 07 20:23:48 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 07 20:23:48 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 07 20:23:48 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 07 20:23:48 machine kernel:  __schedule from schedule+0x50/0x130
Feb 07 20:23:48 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 07 20:23:48 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 07 20:23:48 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 07 20:23:48 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 07 20:23:48 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 07 20:23:48 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 07 20:23:48 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 07 20:23:48 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 07 20:23:48 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 07 20:23:48 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 07 20:23:48 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 07 20:23:48 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 07 20:23:48 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 07 20:23:48 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 07 20:23:48 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 07 20:23:48 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 600e0013 
ffffffff
Feb 07 20:23:48 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 07 20:23:48 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 07 20:23:48 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 07 20:23:48 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 07 20:23:48 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 07 20:23:48 machine kernel: bad: scheduling from the idle thread!
Feb 07 20:23:48 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 07 20:23:48 machine kernel: Tainted: [W]=WARN
Feb 07 20:23:48 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 07 20:23:48 machine kernel: Call trace:
Feb 07 20:23:48 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 07 20:23:48 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 07 20:23:48 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 07 20:23:48 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 07 20:23:48 machine kernel:  __schedule from schedule+0x50/0x130
Feb 07 20:23:48 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 07 20:23:48 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 07 20:23:48 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 07 20:23:48 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 07 20:23:48 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 07 20:23:48 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 07 20:23:48 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 07 20:23:48 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 07 20:23:48 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 07 20:23:48 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 07 20:23:48 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 07 20:23:48 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 07 20:23:48 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 07 20:23:48 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 07 20:23:48 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 07 20:23:48 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 600e0013 
ffffffff
Feb 07 20:23:48 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 07 20:23:48 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 07 20:23:48 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 07 20:23:48 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 07 20:23:48 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 07 20:23:49 machine kernel: bad: scheduling from the idle thread!
Feb 07 20:23:49 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 07 20:23:49 machine kernel: Tainted: [W]=WARN
Feb 07 20:23:49 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 07 20:23:49 machine kernel: Call trace:
Feb 07 20:23:49 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 07 20:23:49 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 07 20:23:49 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 07 20:23:49 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 07 20:23:49 machine kernel:  __schedule from schedule+0x50/0x130
Feb 07 20:23:49 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 07 20:23:49 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 07 20:23:49 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 07 20:23:49 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 07 20:23:49 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 07 20:23:49 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 07 20:23:49 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 07 20:23:49 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 07 20:23:49 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 07 20:23:49 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 07 20:23:49 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 07 20:23:49 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 07 20:23:49 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 07 20:23:49 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 07 20:23:49 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 07 20:23:49 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 600e0013 
ffffffff
Feb 07 20:23:49 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 07 20:23:49 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 07 20:23:49 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 07 20:23:49 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 07 20:23:49 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 07 20:23:49 machine kernel: bad: scheduling from the idle thread!
Feb 07 20:23:49 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 07 20:23:49 machine kernel: Tainted: [W]=WARN
Feb 07 20:23:49 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 07 20:23:49 machine kernel: Call trace:
Feb 07 20:23:49 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 07 20:23:49 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 07 20:23:49 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 07 20:23:49 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 07 20:23:49 machine kernel:  __schedule from schedule+0x50/0x130
Feb 07 20:23:49 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 07 20:23:49 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 07 20:23:49 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 07 20:23:49 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 07 20:23:49 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 07 20:23:49 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 07 20:23:49 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 07 20:23:49 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 07 20:23:49 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 07 20:23:49 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 07 20:23:49 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 07 20:23:49 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 07 20:23:49 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 07 20:23:49 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 07 20:23:49 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 07 20:23:49 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 600e0013 
ffffffff
Feb 07 20:23:49 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 07 20:23:49 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 07 20:23:49 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 07 20:23:49 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 07 20:23:49 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 07 20:23:49 machine kernel: bad: scheduling from the idle thread!
Feb 07 20:23:49 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 07 20:23:49 machine kernel: Tainted: [W]=WARN
Feb 07 20:23:49 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 07 20:23:49 machine kernel: Call trace:
Feb 07 20:23:49 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 07 20:23:49 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 07 20:23:49 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 07 20:23:49 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 07 20:23:49 machine kernel:  __schedule from schedule+0x50/0x130
Feb 07 20:23:49 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 07 20:23:49 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 07 20:23:49 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 07 20:23:49 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 07 20:23:49 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 07 20:23:49 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 07 20:23:49 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 07 20:23:49 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 07 20:23:49 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 07 20:23:49 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 07 20:23:49 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 07 20:23:49 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 07 20:23:49 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 07 20:23:49 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 07 20:23:49 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 07 20:23:49 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 600e0013 
ffffffff
Feb 07 20:23:49 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 07 20:23:49 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 07 20:23:49 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 07 20:23:49 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 07 20:23:49 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 07 20:23:49 machine kernel: bad: scheduling from the idle thread!
Feb 07 20:23:49 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 07 20:23:49 machine kernel: Tainted: [W]=WARN
Feb 07 20:23:49 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 07 20:23:49 machine kernel: Call trace:
Feb 07 20:23:49 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 07 20:23:49 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 07 20:23:49 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 07 20:23:49 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 07 20:23:49 machine kernel:  __schedule from schedule+0x50/0x130
Feb 07 20:23:49 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 07 20:23:49 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 07 20:23:49 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 07 20:23:49 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 07 20:23:49 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 07 20:23:49 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 07 20:23:49 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 07 20:23:49 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 07 20:23:49 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 07 20:23:49 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 07 20:23:49 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 07 20:23:49 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 07 20:23:49 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 07 20:23:49 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 07 20:23:49 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 07 20:23:49 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 600e0013 
ffffffff
Feb 07 20:23:49 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 07 20:23:49 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 07 20:23:49 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 07 20:23:49 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 07 20:23:49 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 07 20:23:49 machine kernel: bad: scheduling from the idle thread!
Feb 07 20:23:49 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 07 20:23:49 machine kernel: Tainted: [W]=WARN
Feb 07 20:23:49 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 07 20:23:49 machine kernel: Call trace:
Feb 07 20:23:49 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 07 20:23:49 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 07 20:23:49 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 07 20:23:49 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 07 20:23:49 machine kernel:  __schedule from schedule+0x50/0x130
Feb 07 20:23:49 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 07 20:23:49 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 07 20:23:49 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 07 20:23:49 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 07 20:23:49 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 07 20:23:49 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 07 20:23:49 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 07 20:23:49 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 07 20:23:49 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 07 20:23:49 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 07 20:23:49 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 07 20:23:49 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 07 20:23:49 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 07 20:23:49 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 07 20:23:49 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 07 20:23:49 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 600e0013 
ffffffff
Feb 07 20:23:49 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 07 20:23:49 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 07 20:23:49 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 07 20:23:49 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 07 20:23:49 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 07 20:23:49 machine kernel: bad: scheduling from the idle thread!
Feb 07 20:23:49 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 07 20:23:49 machine kernel: Tainted: [W]=WARN
Feb 07 20:23:49 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 07 20:23:49 machine kernel: Call trace:
Feb 07 20:23:49 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 07 20:23:49 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 07 20:23:49 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 07 20:23:49 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 07 20:23:49 machine kernel:  __schedule from schedule+0x50/0x130
Feb 07 20:23:49 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 07 20:23:49 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 07 20:23:49 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 07 20:23:49 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 07 20:23:49 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 07 20:23:49 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 07 20:23:49 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 07 20:23:49 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 07 20:23:49 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 07 20:23:50 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 07 20:23:50 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 07 20:23:50 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 07 20:23:50 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 07 20:23:50 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 07 20:23:50 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 07 20:23:50 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 600e0013 
ffffffff
Feb 07 20:23:50 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 07 20:23:50 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 07 20:23:50 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 07 20:23:50 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 07 20:23:50 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 07 20:23:50 machine kernel: bad: scheduling from the idle thread!
Feb 07 20:23:50 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 07 20:23:50 machine kernel: Tainted: [W]=WARN
Feb 07 20:23:50 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 07 20:23:50 machine kernel: Call trace:
Feb 07 20:23:50 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 07 20:23:50 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 07 20:23:50 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 07 20:23:50 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 07 20:23:50 machine kernel:  __schedule from schedule+0x50/0x130
Feb 07 20:23:50 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 07 20:23:50 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 07 20:23:50 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 07 20:23:50 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 07 20:23:50 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 07 20:23:50 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 07 20:23:50 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 07 20:23:50 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 07 20:23:50 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 07 20:23:50 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 07 20:23:50 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 07 20:23:50 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 07 20:23:50 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 07 20:23:50 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 07 20:23:50 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 07 20:23:50 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 600e0013 
ffffffff
Feb 07 20:23:50 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 07 20:23:50 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 07 20:23:50 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 07 20:23:50 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 07 20:23:50 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 07 20:23:50 machine kernel: bad: scheduling from the idle thread!
Feb 07 20:23:50 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 07 20:23:50 machine kernel: Tainted: [W]=WARN
Feb 07 20:23:50 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 07 20:23:50 machine kernel: Call trace:
Feb 07 20:23:50 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 07 20:23:50 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 07 20:23:50 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 07 20:23:50 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 07 20:23:50 machine kernel:  __schedule from schedule+0x50/0x130
Feb 07 20:23:50 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 07 20:23:50 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 07 20:23:50 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 07 20:23:50 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 07 20:23:50 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 07 20:23:50 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 07 20:23:50 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 07 20:23:50 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 07 20:23:50 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 07 20:23:50 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 07 20:23:50 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 07 20:23:50 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 07 20:23:50 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 07 20:23:50 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 07 20:23:50 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 07 20:23:50 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 600e0013 
ffffffff
Feb 07 20:23:50 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 07 20:23:50 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 07 20:23:50 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 07 20:23:50 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 07 20:23:50 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 07 20:23:50 machine kernel: bad: scheduling from the idle thread!
Feb 07 20:23:50 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 07 20:23:50 machine kernel: Tainted: [W]=WARN
Feb 07 20:23:50 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 07 20:23:50 machine kernel: Call trace:
Feb 07 20:23:50 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 07 20:23:50 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 07 20:23:50 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 07 20:23:50 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 07 20:23:50 machine kernel:  __schedule from schedule+0x50/0x130
Feb 07 20:23:50 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 07 20:23:50 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 07 20:23:50 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 07 20:23:50 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 07 20:23:50 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 07 20:23:50 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 07 20:23:50 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 07 20:23:50 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 07 20:23:50 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 07 20:23:50 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 07 20:23:50 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 07 20:23:50 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 07 20:23:50 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 07 20:23:50 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 07 20:23:50 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 07 20:23:50 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 600e0013 
ffffffff
Feb 07 20:23:50 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 07 20:23:50 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 07 20:23:50 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 07 20:23:50 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 07 20:23:50 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 07 20:23:50 machine kernel: bad: scheduling from the idle thread!
Feb 07 20:23:50 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 07 20:23:50 machine kernel: Tainted: [W]=WARN
Feb 07 20:23:50 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 07 20:23:50 machine kernel: Call trace:
Feb 07 20:23:50 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 07 20:23:50 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 07 20:23:50 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 07 20:23:50 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 07 20:23:50 machine kernel:  __schedule from schedule+0x50/0x130
Feb 07 20:23:50 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 07 20:23:50 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 07 20:23:50 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 07 20:23:50 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 07 20:23:50 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 07 20:23:50 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 07 20:23:50 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 07 20:23:50 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 07 20:23:50 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 07 20:23:50 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 07 20:23:50 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 07 20:23:50 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 07 20:23:50 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 07 20:23:50 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 07 20:23:50 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 07 20:23:50 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 600e0013 
ffffffff
Feb 07 20:23:50 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 07 20:23:50 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 07 20:23:50 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 07 20:23:50 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 07 20:23:50 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 07 20:23:50 machine kernel: bad: scheduling from the idle thread!
Feb 07 20:23:50 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 07 20:23:50 machine kernel: Tainted: [W]=WARN
Feb 07 20:23:50 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 07 20:23:50 machine kernel: Call trace:
Feb 07 20:23:50 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 07 20:23:50 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 07 20:23:50 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 07 20:23:50 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 07 20:23:50 machine kernel:  __schedule from schedule+0x50/0x130
Feb 07 20:23:50 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 07 20:23:50 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 07 20:23:50 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 07 20:23:50 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 07 20:23:50 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 07 20:23:50 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 07 20:23:50 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 07 20:23:50 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 07 20:23:50 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 07 20:23:50 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 07 20:23:50 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 07 20:23:50 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 07 20:23:50 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 07 20:23:50 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 07 20:23:50 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 07 20:23:50 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 600e0013 
ffffffff
Feb 07 20:23:50 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 07 20:23:50 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 07 20:23:50 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 07 20:23:50 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 07 20:23:50 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 07 20:23:51 machine kernel: bad: scheduling from the idle thread!
Feb 07 20:23:51 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 07 20:23:51 machine kernel: Tainted: [W]=WARN
Feb 07 20:23:51 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 07 20:23:51 machine kernel: Call trace:
Feb 07 20:23:51 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 07 20:23:51 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 07 20:23:51 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 07 20:23:51 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 07 20:23:51 machine kernel:  __schedule from schedule+0x50/0x130
Feb 07 20:23:51 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 07 20:23:51 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 07 20:23:51 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 07 20:23:51 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 07 20:23:51 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 07 20:23:51 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 07 20:23:51 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 07 20:23:51 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 07 20:23:51 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 07 20:23:51 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 07 20:23:51 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 07 20:23:51 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 07 20:23:51 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 07 20:23:51 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 07 20:23:51 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 07 20:23:51 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 600e0013 
ffffffff
Feb 07 20:23:51 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 07 20:23:51 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 07 20:23:51 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 07 20:23:51 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 07 20:23:51 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 07 20:23:51 machine kernel: bad: scheduling from the idle thread!
Feb 07 20:23:51 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 07 20:23:51 machine kernel: Tainted: [W]=WARN
Feb 07 20:23:51 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 07 20:23:51 machine kernel: Call trace:
Feb 07 20:23:51 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 07 20:23:51 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 07 20:23:51 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 07 20:23:51 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 07 20:23:51 machine kernel:  __schedule from schedule+0x50/0x130
Feb 07 20:23:51 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 07 20:23:51 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 07 20:23:51 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 07 20:23:51 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 07 20:23:51 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 07 20:23:51 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 07 20:23:51 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 07 20:23:51 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 07 20:23:51 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 07 20:23:51 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 07 20:23:51 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 07 20:23:51 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 07 20:23:51 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 07 20:23:51 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 07 20:23:51 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 07 20:23:51 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 600e0013 
ffffffff
Feb 07 20:23:51 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 07 20:23:51 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 07 20:23:51 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 07 20:23:51 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 07 20:23:51 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 07 20:23:51 machine kernel: bad: scheduling from the idle thread!
Feb 07 20:23:51 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 07 20:23:51 machine kernel: Tainted: [W]=WARN
Feb 07 20:23:51 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 07 20:23:51 machine kernel: Call trace:
Feb 07 20:23:51 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 07 20:23:51 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 07 20:23:51 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 07 20:23:51 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 07 20:23:51 machine kernel:  __schedule from schedule+0x50/0x130
Feb 07 20:23:51 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 07 20:23:51 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 07 20:23:51 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 07 20:23:51 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 07 20:23:51 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 07 20:23:51 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 07 20:23:51 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 07 20:23:51 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 07 20:23:51 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 07 20:23:51 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 07 20:23:51 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 07 20:23:51 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 07 20:23:51 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 07 20:23:51 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 07 20:23:51 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 07 20:23:51 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 600e0013 
ffffffff
Feb 07 20:23:51 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 07 20:23:51 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 07 20:23:51 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 07 20:23:51 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 07 20:23:51 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 07 20:23:51 machine kernel: bad: scheduling from the idle thread!
Feb 07 20:23:51 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 07 20:23:51 machine kernel: Tainted: [W]=WARN
Feb 07 20:23:51 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 07 20:23:51 machine kernel: Call trace:
Feb 07 20:23:51 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 07 20:23:51 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 07 20:23:51 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 07 20:23:51 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 07 20:23:51 machine kernel:  __schedule from schedule+0x50/0x130
Feb 07 20:23:51 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 07 20:23:51 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 07 20:23:51 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 07 20:23:51 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 07 20:23:51 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 07 20:23:51 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 07 20:23:51 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 07 20:23:51 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 07 20:23:51 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 07 20:23:51 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 07 20:23:51 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 07 20:23:51 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 07 20:23:51 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 07 20:23:51 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 07 20:23:51 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 07 20:23:51 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 600e0013 
ffffffff
Feb 07 20:23:51 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 07 20:23:51 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 07 20:23:51 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 07 20:23:51 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 07 20:23:51 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 07 20:23:51 machine kernel: bad: scheduling from the idle thread!
Feb 07 20:23:51 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 07 20:23:51 machine kernel: Tainted: [W]=WARN
Feb 07 20:23:51 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 07 20:23:51 machine kernel: Call trace:
Feb 07 20:23:51 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 07 20:23:51 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 07 20:23:51 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 07 20:23:51 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 07 20:23:51 machine kernel:  __schedule from schedule+0x50/0x130
Feb 07 20:23:51 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 07 20:23:51 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 07 20:23:51 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 07 20:23:51 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 07 20:23:51 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 07 20:23:51 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 07 20:23:51 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 07 20:23:51 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 07 20:23:51 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 07 20:23:51 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 07 20:23:51 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 07 20:23:51 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 07 20:23:51 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 07 20:23:51 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 07 20:23:51 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 07 20:23:51 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 600e0013 
ffffffff
Feb 07 20:23:51 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 07 20:23:51 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 07 20:23:51 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 07 20:23:51 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 07 20:23:51 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 07 20:23:52 machine kernel: bad: scheduling from the idle thread!
Feb 07 20:23:52 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 07 20:23:52 machine kernel: Tainted: [W]=WARN
Feb 07 20:23:52 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 07 20:23:52 machine kernel: Call trace:
Feb 07 20:23:52 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 07 20:23:52 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 07 20:23:52 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 07 20:23:52 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 07 20:23:52 machine kernel:  __schedule from schedule+0x50/0x130
Feb 07 20:23:52 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 07 20:23:52 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 07 20:23:52 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 07 20:23:52 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 07 20:23:52 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 07 20:23:52 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 07 20:23:52 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 07 20:23:52 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 07 20:23:52 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 07 20:23:52 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 07 20:23:52 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 07 20:23:52 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 07 20:23:52 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 07 20:23:52 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 07 20:23:52 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 07 20:23:52 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 600e0013 
ffffffff
Feb 07 20:23:52 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 07 20:23:52 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 07 20:23:52 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 07 20:23:52 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 07 20:23:52 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 07 20:23:52 machine kernel: bad: scheduling from the idle thread!
Feb 07 20:23:52 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 07 20:23:52 machine kernel: Tainted: [W]=WARN
Feb 07 20:23:52 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 07 20:23:52 machine kernel: Call trace:
Feb 07 20:23:52 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 07 20:23:52 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 07 20:23:52 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 07 20:23:52 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 07 20:23:52 machine kernel:  __schedule from schedule+0x50/0x130
Feb 07 20:23:52 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 07 20:23:52 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 07 20:23:52 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 07 20:23:52 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 07 20:23:52 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 07 20:23:52 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 07 20:23:52 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 07 20:23:52 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 07 20:23:52 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 07 20:23:52 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 07 20:23:52 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 07 20:23:52 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 07 20:23:52 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 07 20:23:52 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 07 20:23:52 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 07 20:23:52 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 600e0013 
ffffffff
Feb 07 20:23:52 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 07 20:23:52 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 07 20:23:52 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 07 20:23:52 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 07 20:23:52 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 07 20:23:52 machine kernel: bad: scheduling from the idle thread!
Feb 07 20:23:52 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 07 20:23:52 machine kernel: Tainted: [W]=WARN
Feb 07 20:23:52 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 07 20:23:52 machine kernel: Call trace:
Feb 07 20:23:52 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 07 20:23:52 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 07 20:23:52 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 07 20:23:52 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 07 20:23:52 machine kernel:  __schedule from schedule+0x50/0x130
Feb 07 20:23:52 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 07 20:23:52 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 07 20:23:52 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 07 20:23:52 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 07 20:23:52 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 07 20:23:52 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 07 20:23:52 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 07 20:23:52 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 07 20:23:52 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 07 20:23:52 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 07 20:23:52 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 07 20:23:52 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 07 20:23:52 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 07 20:23:52 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 07 20:23:52 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 07 20:23:52 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 600e0013 
ffffffff
Feb 07 20:23:52 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 07 20:23:52 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 07 20:23:52 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 07 20:23:52 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 07 20:23:52 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 07 20:23:52 machine kernel: bad: scheduling from the idle thread!
Feb 07 20:23:52 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 07 20:23:52 machine kernel: Tainted: [W]=WARN
Feb 07 20:23:52 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 07 20:23:52 machine kernel: Call trace:
Feb 07 20:23:52 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 07 20:23:52 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 07 20:23:52 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 07 20:23:52 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 07 20:23:52 machine kernel:  __schedule from schedule+0x50/0x130
Feb 07 20:23:52 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 07 20:23:52 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 07 20:23:52 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 07 20:23:52 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 07 20:23:52 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 07 20:23:52 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 07 20:23:52 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 07 20:23:52 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 07 20:23:52 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 07 20:23:52 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 07 20:23:52 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 07 20:23:52 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 07 20:23:52 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 07 20:23:52 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 07 20:23:52 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 07 20:23:52 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 600e0013 
ffffffff
Feb 07 20:23:52 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 07 20:23:52 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 07 20:23:52 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 07 20:23:52 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 07 20:23:52 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 07 20:23:52 machine kernel: bad: scheduling from the idle thread!
Feb 07 20:23:52 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 07 20:23:52 machine kernel: Tainted: [W]=WARN
Feb 07 20:23:52 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 07 20:23:52 machine kernel: Call trace:
Feb 07 20:23:52 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 07 20:23:52 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 07 20:23:52 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 07 20:23:52 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 07 20:23:52 machine kernel:  __schedule from schedule+0x50/0x130
Feb 07 20:23:52 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 07 20:23:52 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 07 20:23:52 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 07 20:23:52 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 07 20:23:52 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 07 20:23:52 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 07 20:23:52 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 07 20:23:52 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 07 20:23:52 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 07 20:23:52 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 07 20:23:52 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 07 20:23:52 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 07 20:23:52 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 07 20:23:52 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 07 20:23:52 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 07 20:23:52 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 600e0013 
ffffffff
Feb 07 20:23:52 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 07 20:23:52 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 07 20:23:52 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 07 20:23:52 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 07 20:23:52 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 07 20:23:53 machine kernel: bad: scheduling from the idle thread!
Feb 07 20:23:53 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 07 20:23:53 machine kernel: Tainted: [W]=WARN
Feb 07 20:23:53 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 07 20:23:53 machine kernel: Call trace:
Feb 07 20:23:53 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 07 20:23:53 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 07 20:23:53 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 07 20:23:53 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 07 20:23:53 machine kernel:  __schedule from schedule+0x50/0x130
Feb 07 20:23:53 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 07 20:23:53 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 07 20:23:53 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 07 20:23:53 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 07 20:23:53 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 07 20:23:53 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 07 20:23:53 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 07 20:23:53 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 07 20:23:53 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 07 20:23:53 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 07 20:23:53 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 07 20:23:53 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 07 20:23:53 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 07 20:23:53 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 07 20:23:53 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 07 20:23:53 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 600e0013 
ffffffff
Feb 07 20:23:53 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 07 20:23:53 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 07 20:23:53 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 07 20:23:53 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 07 20:23:53 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 07 20:23:53 machine kernel: bad: scheduling from the idle thread!
Feb 07 20:23:53 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 07 20:23:53 machine kernel: Tainted: [W]=WARN
Feb 07 20:23:53 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 07 20:23:53 machine kernel: Call trace:
Feb 07 20:23:53 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 07 20:23:53 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 07 20:23:53 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 07 20:23:53 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 07 20:23:53 machine kernel:  __schedule from schedule+0x50/0x130
Feb 07 20:23:53 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 07 20:23:53 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 07 20:23:53 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 07 20:23:53 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 07 20:23:53 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 07 20:23:53 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 07 20:23:53 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 07 20:23:53 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 07 20:23:53 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 07 20:23:53 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 07 20:23:53 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 07 20:23:53 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 07 20:23:53 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 07 20:23:53 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 07 20:23:53 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 07 20:23:53 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 600e0013 
ffffffff
Feb 07 20:23:53 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 07 20:23:53 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 07 20:23:53 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 07 20:23:53 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 07 20:23:53 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 07 20:23:53 machine kernel: bad: scheduling from the idle thread!
Feb 07 20:23:53 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 07 20:23:53 machine kernel: Tainted: [W]=WARN
Feb 07 20:23:53 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 07 20:23:53 machine kernel: Call trace:
Feb 07 20:23:53 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 07 20:23:53 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 07 20:23:53 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 07 20:23:53 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 07 20:23:53 machine kernel:  __schedule from schedule+0x50/0x130
Feb 07 20:23:53 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 07 20:23:53 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 07 20:23:53 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 07 20:23:53 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 07 20:23:53 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 07 20:23:53 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 07 20:23:53 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 07 20:23:53 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 07 20:23:53 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 07 20:23:53 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 07 20:23:53 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 07 20:23:53 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 07 20:23:53 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 07 20:23:53 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 07 20:23:53 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 07 20:23:53 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 600e0013 
ffffffff
Feb 07 20:23:53 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 07 20:23:53 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 07 20:23:53 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 07 20:23:53 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 07 20:23:53 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 07 20:23:53 machine kernel: bad: scheduling from the idle thread!
Feb 07 20:23:53 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 07 20:23:53 machine kernel: Tainted: [W]=WARN
Feb 07 20:23:53 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 07 20:23:53 machine kernel: Call trace:
Feb 07 20:23:53 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 07 20:23:53 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 07 20:23:53 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 07 20:23:53 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 07 20:23:53 machine kernel:  __schedule from schedule+0x50/0x130
Feb 07 20:23:53 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 07 20:23:53 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 07 20:23:53 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 07 20:23:53 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 07 20:23:53 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 07 20:23:53 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 07 20:23:53 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 07 20:23:53 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 07 20:23:53 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 07 20:23:53 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 07 20:23:53 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 07 20:23:53 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 07 20:23:53 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 07 20:23:53 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 07 20:23:53 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 07 20:23:53 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 600e0013 
ffffffff
Feb 07 20:23:53 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 07 20:23:53 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 07 20:23:53 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 07 20:23:53 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 07 20:23:53 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 07 20:23:53 machine kernel: bad: scheduling from the idle thread!
Feb 07 20:23:53 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 07 20:23:53 machine kernel: Tainted: [W]=WARN
Feb 07 20:23:53 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 07 20:23:53 machine kernel: Call trace:
Feb 07 20:23:53 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 07 20:23:53 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 07 20:23:53 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 07 20:23:53 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 07 20:23:53 machine kernel:  __schedule from schedule+0x50/0x130
Feb 07 20:23:53 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 07 20:23:53 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 07 20:23:53 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 07 20:23:53 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 07 20:23:53 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 07 20:23:53 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 07 20:23:53 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 07 20:23:53 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 07 20:23:53 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 07 20:23:53 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 07 20:23:53 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 07 20:23:53 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 07 20:23:53 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 07 20:23:53 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 07 20:23:53 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 07 20:23:53 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 600e0013 
ffffffff
Feb 07 20:23:53 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 07 20:23:53 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 07 20:23:53 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 07 20:23:53 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 07 20:23:53 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 07 20:23:54 machine kernel: bad: scheduling from the idle thread!
Feb 07 20:23:54 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 07 20:23:54 machine kernel: Tainted: [W]=WARN
Feb 07 20:23:54 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 07 20:23:54 machine kernel: Call trace:
Feb 07 20:23:54 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 07 20:23:54 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 07 20:23:54 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 07 20:23:54 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 07 20:23:54 machine kernel:  __schedule from schedule+0x50/0x130
Feb 07 20:23:54 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 07 20:23:54 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 07 20:23:54 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 07 20:23:54 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 07 20:23:54 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 07 20:23:54 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 07 20:23:54 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 07 20:23:54 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 07 20:23:54 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 07 20:23:54 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 07 20:23:54 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 07 20:23:54 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 07 20:23:54 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 07 20:23:54 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 07 20:23:54 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 07 20:23:54 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 600e0013 
ffffffff
Feb 07 20:23:54 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 07 20:23:54 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 07 20:23:54 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 07 20:23:54 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 07 20:23:54 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 07 20:23:54 machine kernel: bad: scheduling from the idle thread!
Feb 07 20:23:54 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 07 20:23:54 machine kernel: Tainted: [W]=WARN
Feb 07 20:23:54 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 07 20:23:54 machine kernel: Call trace:
Feb 07 20:23:54 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 07 20:23:54 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 07 20:23:54 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 07 20:23:54 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 07 20:23:54 machine kernel:  __schedule from schedule+0x50/0x130
Feb 07 20:23:54 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 07 20:23:54 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 07 20:23:54 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 07 20:23:54 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 07 20:23:54 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 07 20:23:54 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 07 20:23:54 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 07 20:23:54 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 07 20:23:54 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 07 20:23:54 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 07 20:23:54 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 07 20:23:54 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 07 20:23:54 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 07 20:23:54 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 07 20:23:54 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 07 20:23:54 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 600e0013 
ffffffff
Feb 07 20:23:54 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 07 20:23:54 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 07 20:23:54 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 07 20:23:54 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 07 20:23:54 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 07 20:23:54 machine kernel: bad: scheduling from the idle thread!
Feb 07 20:23:54 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 07 20:23:54 machine kernel: Tainted: [W]=WARN
Feb 07 20:23:54 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 07 20:23:54 machine kernel: Call trace:
Feb 07 20:23:54 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 07 20:23:54 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 07 20:23:54 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 07 20:23:54 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 07 20:23:54 machine kernel:  __schedule from schedule+0x50/0x130
Feb 07 20:23:54 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 07 20:23:54 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 07 20:23:54 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 07 20:23:54 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 07 20:23:54 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 07 20:23:54 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 07 20:23:54 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 07 20:23:54 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 07 20:23:54 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 07 20:23:54 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 07 20:23:54 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 07 20:23:54 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 07 20:23:54 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 07 20:23:54 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 07 20:23:54 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 07 20:23:54 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 600e0013 
ffffffff
Feb 07 20:23:54 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 07 20:23:54 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 07 20:23:54 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 07 20:23:54 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 07 20:23:54 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 07 20:23:54 machine kernel: bad: scheduling from the idle thread!
Feb 07 20:23:54 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 07 20:23:54 machine kernel: Tainted: [W]=WARN
Feb 07 20:23:54 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 07 20:23:54 machine kernel: Call trace:
Feb 07 20:23:54 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 07 20:23:54 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 07 20:23:54 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 07 20:23:54 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 07 20:23:54 machine kernel:  __schedule from schedule+0x50/0x130
Feb 07 20:23:54 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 07 20:23:54 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 07 20:23:54 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 07 20:23:54 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 07 20:23:54 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 07 20:23:54 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 07 20:23:54 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 07 20:23:54 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 07 20:23:54 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 07 20:23:54 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 07 20:23:54 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 07 20:23:54 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 07 20:23:54 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 07 20:23:54 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 07 20:23:54 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 07 20:23:54 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 600e0013 
ffffffff
Feb 07 20:23:54 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 07 20:23:54 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 07 20:23:54 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 07 20:23:54 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 07 20:23:54 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 07 20:23:54 machine kernel: bad: scheduling from the idle thread!
Feb 07 20:23:54 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 07 20:23:54 machine kernel: Tainted: [W]=WARN
Feb 07 20:23:54 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 07 20:23:54 machine kernel: Call trace:
Feb 07 20:23:54 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 07 20:23:54 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 07 20:23:54 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 07 20:23:54 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 07 20:23:54 machine kernel:  __schedule from schedule+0x50/0x130
Feb 07 20:23:54 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 07 20:23:54 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 07 20:23:54 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 07 20:23:54 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 07 20:23:54 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 07 20:23:54 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 07 20:23:54 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 07 20:23:54 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 07 20:23:54 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 07 20:23:54 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 07 20:23:54 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 07 20:23:54 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 07 20:23:54 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 07 20:23:54 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 07 20:23:54 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 07 20:23:54 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 600e0013 
ffffffff
Feb 07 20:23:54 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 07 20:23:54 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 07 20:23:54 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 07 20:23:54 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 07 20:23:54 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 07 20:23:54 machine kernel: bad: scheduling from the idle thread!
Feb 07 20:23:54 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 07 20:23:54 machine kernel: Tainted: [W]=WARN
Feb 07 20:23:54 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 07 20:23:54 machine kernel: Call trace:
Feb 07 20:23:54 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 07 20:23:54 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 07 20:23:54 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 07 20:23:55 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 07 20:23:55 machine kernel:  __schedule from schedule+0x50/0x130
Feb 07 20:23:55 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 07 20:23:55 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 07 20:23:55 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 07 20:23:55 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 07 20:23:55 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 07 20:23:55 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 07 20:23:55 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 07 20:23:55 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 07 20:23:55 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 07 20:23:55 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 07 20:23:55 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 07 20:23:55 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 07 20:23:55 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 07 20:23:55 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 07 20:23:55 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 07 20:23:55 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 600e0013 
ffffffff
Feb 07 20:23:55 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 07 20:23:55 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 07 20:23:55 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 07 20:23:55 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 07 20:23:55 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 07 20:23:55 machine kernel: bad: scheduling from the idle thread!
Feb 07 20:23:55 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 07 20:23:55 machine kernel: Tainted: [W]=WARN
Feb 07 20:23:55 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 07 20:23:55 machine kernel: Call trace:
Feb 07 20:23:55 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
Feb 07 20:23:55 machine kernel:  show_stack from 
dump_stack_lvl+0xa8/0xb8
Feb 07 20:23:55 machine kernel:  dump_stack_lvl from 
dequeue_task_idle+0x20/0x50
Feb 07 20:23:55 machine kernel:  dequeue_task_idle from 
__schedule+0x428/0xc70
Feb 07 20:23:55 machine kernel:  __schedule from schedule+0x50/0x130
Feb 07 20:23:55 machine kernel:  schedule from 
schedule_preempt_disabled+0x1c/0x2c
Feb 07 20:23:55 machine kernel:  schedule_preempt_disabled from 
__mutex_lock+0x4dc/0x914
Feb 07 20:23:55 machine kernel:  __mutex_lock from 
mutex_lock_nested+0x1c/0x24
Feb 07 20:23:55 machine kernel:  mutex_lock_nested from 
rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
Feb 07 20:23:55 machine kernel:  rtw_tx_report_purge_timer [rtw88_core] 
from call_timer_fn+0xb4/0x310
Feb 07 20:23:55 machine kernel:  call_timer_fn from 
__run_timers+0x278/0x324
Feb 07 20:23:55 machine kernel:  __run_timers from 
run_timer_base+0x4c/0x6c
Feb 07 20:23:55 machine kernel:  run_timer_base from 
run_timer_softirq+0x14/0x38
Feb 07 20:23:55 machine kernel:  run_timer_softirq from 
handle_softirqs+0x160/0x4a8
Feb 07 20:23:55 machine kernel:  handle_softirqs from 
__irq_exit_rcu+0x12c/0x198
Feb 07 20:23:55 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
Feb 07 20:23:55 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
Feb 07 20:23:55 machine kernel: Exception stack(0xc1401f48 to 
0xc1401f90)
Feb 07 20:23:55 machine kernel: 1f40:                   c0dc3ae0 
2e43c000 00000001 00000000 c017b020 c1416840
Feb 07 20:23:55 machine kernel: 1f60: c1416840 c14125c0 c11f3820 
00000000 00000068 ffffffff 00000000 c1401f98
Feb 07 20:23:55 machine kernel: 1f80: c0dc3ae0 c0dc3ae4 600e0013 
ffffffff
Feb 07 20:23:55 machine kernel:  __irq_svc from 
default_idle_call+0x1c/0x1f4
Feb 07 20:23:55 machine kernel:  default_idle_call from 
do_idle+0xc0/0x128
Feb 07 20:23:55 machine kernel:  do_idle from 
cpu_startup_entry+0x28/0x2c
Feb 07 20:23:55 machine kernel:  cpu_startup_entry from 
rest_init+0x150/0x17c
Feb 07 20:23:55 machine kernel:  rest_init from start_kernel+0x618/0x6dc
Feb 07 20:23:55 machine kernel: bad: scheduling from the idle thread!
Feb 07 20:23:55 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
Tainted: G        W          6.12.12-g8e187440f820 #0
Feb 07 20:23:55 machine kernel: Tainted: [W]=WARN
Feb 07 20:23:55 machine kernel: Hardware name: Freescale i.MX6 SoloX 
(Device Tree)
Feb 07 20:23:55 machine kernel: Call trace:
Feb 07 20:23:55 machine kernel:  unwind_backtrace from 
show_stack+0x10/0x14
.
.
.
(keeps going....)

