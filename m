Return-Path: <linux-wireless+bounces-18836-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1309A321EA
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 10:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D749A163934
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 09:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8A81EF0BC;
	Wed, 12 Feb 2025 09:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=technux.se header.i=@technux.se header.b="DgQ0Pdtj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from m101-out-mua-2.websupport.se (m101-out-mua-2.websupport.se [109.235.175.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F81205ADD
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 09:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.235.175.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739351966; cv=none; b=lLAxYsO1u/XQTPyd7n1Ur7qexntV7pTaQfA45Le4e90RZrP1NFjQRyFmoRBcLCyW3EwteL1Gp+ckSoprh2cpV2i/S0J8y5EGUb27/nWnyvpXF+OwhPAoDAa1YpwCfAW/pJSNzEkIZVl0STN8KlpKOVVwFfwDRWsvg5LedsnMs1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739351966; c=relaxed/simple;
	bh=BDAVn67X42AcmTW0YuB+a264MkxPBz2t63EvqbcJKOQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Gx7gSZ2RBx9e86RAXoDKetJmCe39XlWXpSgBPhylp6/k6/MKTOJGEAA6G44huqtX+xgBvWFHliKquqdWHhIhwpHUR5mDd78Z81o68HoWAKcjUZnstkIbrtTv0DW/mj2bFJl9a1hIL/Y8+6vjrQA3XX7S5rIczIUUI4rIhLN6Sbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=technux.se; spf=pass smtp.mailfrom=technux.se; dkim=pass (2048-bit key) header.d=technux.se header.i=@technux.se header.b=DgQ0Pdtj; arc=none smtp.client-ip=109.235.175.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=technux.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=technux.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=technux.se; s=mail;
	t=1739351953; bh=KmhgRHV7Uq+yzRBTFaDmOvyEBLeFye9RMWnZbfUoXe0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DgQ0Pdtj10pFQYI6UH9hyMlm3ktM6hvVgNlNTchkEyyWAYK5jQi+RXPrgzgatJhdY
	 DCUE6UlHYcAddy0heOGLLpJsbgwudcnLfdOpVNJsl4Ia9nWcAv0md/zTNA/bmP11eZ
	 k98xKErKDEX5VgXlKeyUwvR9qPokTquBLAP+q4VzFtLo7qDpJxBXMbDIO4wZ8kMOnC
	 DJBioHlnAY9DodZA9lNLErgTsSE+4fMWl0BzVd4Dcaz/VhlvW6lSA7PxfQ6ItspMsi
	 0agL5WxYEcMS861SuIqWgseyEDC9LNpC7cwM+LQfb6mKkPXB+YxKExen0xQcYXfrWP
	 YQsK2G+o9qmKQ==
Received: from m101-u6-ing.websupport.se (unknown [10.30.6.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by m101-out-mua-2.websupport.se (Postfix) with ESMTPS id 4YtCS119d3z1ZwW;
	Wed, 12 Feb 2025 10:19:13 +0100 (CET)
X-Authenticated-Sender: petter@technux.se
Authentication-Results: m101-u6-ing.websupport.se;
	auth=pass smtp.auth=petter@technux.se smtp.mailfrom=petter@technux.se
Received: from roundcube.ws.int (unknown [109.235.175.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: petter@technux.se)
	by m101-u6-ing.websupport.se (Postfix) with ESMTPSA id 4YtCS05TtLz1R7Y;
	Wed, 12 Feb 2025 10:19:12 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 12 Feb 2025 10:19:11 +0100
From: petter@technux.se
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: rtl8821cerfe2@gmail.com, Linux wireless <linux-wireless@vger.kernel.org>
Subject: Re: rtw88: 8821au: locking issues possible caused by firmware failed
 to leave lps state / failed to get tx report
In-Reply-To: <ff0487ce0bff400b819d8d8d55a04f19@realtek.com>
References: <84d07bb6109ae42ce4e708d6e293f6de@technux.se>
 <110cbd37e935161dbe0039a708f6428d@technux.se>
 <ff0487ce0bff400b819d8d8d55a04f19@realtek.com>
User-Agent: Roundcube Webmail/1.6.9
Message-ID: <b557c127e0c305f3eddb9456e172c609@technux.se>
X-Sender: petter@technux.se
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Out-Rspamd-Queue-Id: 4YtCS05TtLz1R7Y
X-Rspamd-Action: no action
X-Out-Spamd-Result: default: False [0.00 / 1000.00];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:41528, ipnet:109.235.175.0/24, country:SE];
	ARC_NA(0.00)[];
	WS_IP_WHITELIST(0.00)[109.235.175.24]
X-Out-Rspamd-Server: m101-rspamd-out-5
X-Rspamd-Pre-Result: action=no action;
	module=multimap;
	Matched map: WS_IP_WHITELIST
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 6792
X-purgate-ID: 155908::1739351953-C743DF5A-8DB4CF4F/0/0

On 2025-02-11 01:45, Ping-Ke Shih wrote:
> petter@technux.se <petter@technux.se> wrote:
>> 
>> I have seen some issues with the LM808 dongle (8821au). I'm running
>> 6.12.12 kernel with all missing rtw88 patches cherry-picked from 
>> latest
>> Linux-wireless main track. The dongle seems to be working fine most of
>> the time, when running traffic and load it, but sometimes during low
>> traffic/idle I can see below crash that loop around. Any good ideas 
>> what
>> is going on here? (running on armhf based platform)
> 
> Can you try the latest kernel?
> 
>> 
>> BR Petter
>> 
>> Issue 1:
>> ================
>> 
>> Feb 08 10:32:08 machine kernel: rtw_8821au 1-1:1.0: firmware failed to
>> leave lps state
>> Feb 08 10:32:08 machine kernel:
>> Feb 08 10:32:08 machine kernel:
>> ============================================
>> Feb 08 10:32:08 machine kernel: WARNING: possible recursive locking
>> detected
>> Feb 08 10:32:08 machine kernel: 6.12.12-g8e187440f820 #0 Not tainted
>> Feb 08 10:32:08 machine kernel:
>> --------------------------------------------
>> Feb 08 10:32:08 machine kernel: kworker/u4:4/25 is trying to acquire
>> lock:
>> Feb 08 10:32:08 machine kernel: c4d8f050 (&rtwdev->mutex){+.+.}-{3:3},
>> at: rtw_leave_lps+0x1d4/0x208 [rtw88_core]
>> Feb 08 10:32:08 machine kernel:
>>                                but task is already holding lock:
>> Feb 08 10:32:08 machine kernel: c4d8f050 (&rtwdev->mutex){+.+.}-{3:3},
>> at: rtw_watch_dog_work+0x44/0x2e8 [rtw88_core]
>> Feb 08 10:32:08 machine kernel:
>>                                other info that might help us debug 
>> this:
>> Feb 08 10:32:08 machine kernel:  Possible unsafe locking scenario:
>> Feb 08 10:32:08 machine kernel:        CPU0
>> Feb 08 10:32:08 machine kernel:        ----
>> Feb 08 10:32:08 machine kernel:   lock(&rtwdev->mutex);
>> Feb 08 10:32:08 machine kernel:   lock(&rtwdev->mutex);
>> Feb 08 10:32:08 machine kernel:
>>                                 *** DEADLOCK ***
>> Feb 08 10:32:08 machine kernel:  May be due to missing lock nesting
>> notation
>> Feb 08 10:32:08 machine kernel: 3 locks held by kworker/u4:4/25:
>> Feb 08 10:32:08 machine kernel:  #0: c4eb64b4
>> ((wq_completion)phy0){+.+.}-{0:0}, at: process_one_work+0x1ac/0x71c
>> Feb 08 10:32:08 machine kernel:  #1: f090df20
>> ((work_completion)(&(&rtwdev->watch_dog_work)->work)){+.+.}-{0:0}, at:
>> process_one_work+0x1d8/0x71c
>> Feb 08 10:32:08 machine kernel:  #2: c4d8f050
>> (&rtwdev->mutex){+.+.}-{3:3}, at: rtw_watch_dog_work+0x44/0x2e8
>> [rtw88_core]
> 
> There is a mutex_lock(&rtwdev->mutex) at rtw_watch_dog_work() 
> obviously, but
> I can't find rtw_leave_lps() tries to hold a lock. Could you use 
> addr2line to
> address where rtw_leave_lps+0x1d4/0x208 locate?
> 
> 
>> 
>> Issue 2:
>> ================
>> 
>> Feb 07 20:23:45 machine kernel: rtw_8821au 1-1:1.0: firmware failed to
>> leave lps state
>> Feb 07 20:23:46 machine kernel: rtw_8821au 1-1:1.0: failed to get tx
>> report from firmware
>> Feb 07 20:23:46 machine kernel: BUG: scheduling while atomic:
>> swapper/0/0/0x00000103
>> Feb 07 20:23:46 machine kernel: INFO: lockdep is turned off.
>> Feb 07 20:23:46 machine kernel: Modules linked in: rtw88_8821au
>> rtw88_8821a rtw88_88xxa rtw88_usb rtw88_core mac80211 libarc4 cfg80211
>> imx_sdma ip_tables x_tables
>> Feb 07 20:23:46 machine kernel: irq event stamp: 10781843
>> Feb 07 20:23:46 machine kernel: hardirqs last  enabled at (10781842):
>> [<c0100c58>] __irq_svc+0xb8/0xd4
>> Feb 07 20:23:46 machine kernel: hardirqs last disabled at (10781843):
>> [<c0dcf33c>] _raw_spin_lock_irqsave+0x64/0x68
>> Feb 07 20:23:46 machine kernel: softirqs last  enabled at (10781808):
>> [<c012cbbc>] handle_softirqs+0x2b4/0x4a8
>> Feb 07 20:23:46 machine kernel: softirqs last disabled at (10781821):
>> [<c012cf30>] __irq_exit_rcu+0x12c/0x198
>> Feb 07 20:23:46 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 
>> Not
>> tainted 6.12.12-g8e187440f820 #0
>> Feb 07 20:23:46 machine kernel: Hardware name: Freescale i.MX6 SoloX
>> (Device Tree)
>> Feb 07 20:23:46 machine kernel: Call trace:
>> Feb 07 20:23:46 machine kernel:  unwind_backtrace from
>> show_stack+0x10/0x14
>> Feb 07 20:23:46 machine kernel:  show_stack from
>> dump_stack_lvl+0x88/0xb8
>> Feb 07 20:23:46 machine kernel:  dump_stack_lvl from
>> __schedule_bug+0x64/0x84
>> Feb 07 20:23:46 machine kernel:  __schedule_bug from
>> __schedule+0x944/0xc70
>> Feb 07 20:23:46 machine kernel:  __schedule from schedule+0x50/0x130
>> Feb 07 20:23:46 machine kernel:  schedule from
>> schedule_preempt_disabled+0x1c/0x2c
>> Feb 07 20:23:46 machine kernel:  schedule_preempt_disabled from
>> __mutex_lock+0x7d4/0x914
>> Feb 07 20:23:46 machine kernel:  __mutex_lock from
>> mutex_lock_nested+0x1c/0x24
>> Feb 07 20:23:46 machine kernel:  mutex_lock_nested from
>> rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
>> Feb 07 20:23:46 machine kernel:  rtw_tx_report_purge_timer 
>> [rtw88_core]
>> from call_timer_fn+0xb4/0x310
>> Feb 07 20:23:46 machine kernel:  call_timer_fn from
>> __run_timers+0x278/0x324
>> Feb 07 20:23:46 machine kernel:  __run_timers from
>> run_timer_base+0x4c/0x6c
>> Feb 07 20:23:46 machine kernel:  run_timer_base from
>> run_timer_softirq+0x14/0x38
>> Feb 07 20:23:46 machine kernel:  run_timer_softirq from
>> handle_softirqs+0x160/0x4a8
>> Feb 07 20:23:46 machine kernel:  handle_softirqs from
>> __irq_exit_rcu+0x12c/0x198
>> Feb 07 20:23:46 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
>> Feb 07 20:23:46 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
>> Feb 07 20:23:46 machine kernel: Exception stack(0xc1401f48 to
> 
> rtw_tx_report_purge_timer() is a timer handler in BH context, so 
> sleeping
> is disallowed. I also can't find where it tries to hold a lock.
> Please help to point out where rtw_tx_report_purge_timer+0x44/0x74 is.

I have troubleshooted this further and thanks for you input, that made 
me realize that this is due to a custom patch we had that is resetting 
the rtw88 drivers if they run into a stall mode that we have suffered 
from time-to-time (that I forget to remove). But when we integrated [1] 
into our kernel tree, I guess we had a more likely situation to get 
issues when taking our mutexes above due to BX context. So I removed our 
workaround code, since [1] is aimed to fix the issue we where trying to 
workaround anyway. Sorry for the inconvenience! And a big thanks for 
helping me figured out why this suddenly started to happen when using 
latest rtw88 patches from linux-wireless.

BR Petter

[1] : 
https://lore.kernel.org/linux-wireless/6aa9254f7ee84c289527e6e205d52bcb@realtek.com/T/#t

