Return-Path: <linux-wireless+bounces-25999-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7992BB11082
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 19:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E6FD585D72
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 17:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E912EB5B0;
	Thu, 24 Jul 2025 17:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ic20nQ8b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D28329ACC3
	for <linux-wireless@vger.kernel.org>; Thu, 24 Jul 2025 17:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753379526; cv=none; b=hK5ljWf5ADl+AToudD7z/MWVC1iGDHszKdcIr+hOT9Cf3k4M/UYoFN0T5WSSvbEpL6DXpqafuuNPtNOFRdPdXIr6iPCLi/94UIc0bGX3Geb8uvkYItH7KJDNBcy4b2gxKQc361pwV9f1Mu0zgyGtau5KxzHHlbNLgoHEZ6PNzf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753379526; c=relaxed/simple;
	bh=xulrlVkaCbe/2275beVXMA45QHDKGB5Ae5qgWFg3wS0=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=EsxDPSuxYdfzXDq+Q9OpiXOpNJXsJbEf0LDs84pAgrx7PHzU+2RuO6AoIBx3sxRM+KtamuWbEtrfNglCyKRZt1NEBAEW8EHrl1sOinVul846T1/j8QyJYY5F0om3xDpiAlqX5S8zdjq2CcIzRyAplMFjx+qQ3duH8nRwpGALuHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ic20nQ8b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753379523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TMUDtLM97rcWYkGVG6uRdOQot9w7lpbGWqyfJm/xbwk=;
	b=Ic20nQ8be2hOwVbW4iWoYget0U4DG/VR87KgftGpGG/xww+7hQGJhQUjfpMnwW9CAUVC5m
	PWix/6tuVc86MUtbHHU3JGt+Nsd4PT7sHAg3EXOUh0KqmEdp5RR+ZztuIGbFbSb/4b2Nf2
	C2y9o6HCtBw/5xkteZ7omKcSKEwxjsc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-kCfSGvyjO0a_bpKarVuTHg-1; Thu, 24 Jul 2025 13:52:01 -0400
X-MC-Unique: kCfSGvyjO0a_bpKarVuTHg-1
X-Mimecast-MFC-AGG-ID: kCfSGvyjO0a_bpKarVuTHg_1753379521
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e269587d8eso231373685a.3
        for <linux-wireless@vger.kernel.org>; Thu, 24 Jul 2025 10:52:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753379521; x=1753984321;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TMUDtLM97rcWYkGVG6uRdOQot9w7lpbGWqyfJm/xbwk=;
        b=Mw6nhn9ZlCV5FyVmtGg8QIOESvadu9nUp6cD89QEOizBBm/SImuixAD8xSI347nV6J
         941RuPQbFIZ1eZo+Tv605gGkcf6BtHDgW6k8NcjCaMibQG/SusPc7vT1Ldf0P6G4ydPJ
         4RV6y2ZuFQSFQyV3MnhyE/oBUK9R2xnQcE8B7d2X+OAaeCNxe3ogTiieIMHro7Vc0UvI
         E2OqQiniRw8agOggUy2MZ3FKcOUzoy28LvbvRo0/nSHxLYAxPx5kWKiy7QsHDX5aNjmr
         SIJfr7KLxi/CC4rPJk1fJ47U6FQ4ghO/KAsnFEKU0qWwoEeK60zv8ixGzgD6qZbgKH/J
         jtGA==
X-Forwarded-Encrypted: i=1; AJvYcCUaswVTLkCn6wtZnDw0Z3apkoziq97PFoRSvvEdpsBl2Q3VAVmhNyv9Asgk8cmXadPPq+rZR2Kfte0uBJlIag==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrCvPnFy0ab3riy+HKWE/1zPrTCvBXKWlEL/D8IFYzSOcnueT8
	f8u7gP25SJfwwIEGram8R7gpmN3mjfPLi9bn1jMgo3goO6CgZyOVojyC4cVAmfYTneg5F0pUcuT
	VoSMadzIIMBlQfzOuX7MwNfh01NLkfUkIW/YZwwm6IcLXTR+hRVl2Gkw+hWfsIM2G3vx9
X-Gm-Gg: ASbGncs4tpYsDMjgNX8DNRjr6gaJ8yyrF6tviSNxKhGVFljIw40f+r7VJpRA91qBEYP
	KGOi20OLXkyfmkpWqkG48CnvJCYJtFe+XHZXyGhn1L2eEx86w9UsQpPQnHhwR0QnMQUTH21/OOf
	MK9yfklVvjc0aZyyehdmB7rdgfxxz+0bbA+WZkvYA+T3jO6HGJBk26ZmDGMOVbZCGmrwq1NLRU9
	xkD7UVTbk8DrV4HHIGDAfXjrCFPCxTw6Hs6OH/Bh9a7rrty9m1mRDeclzVZeyTt/ON5LX3tWPCz
	72zv7+OrIPYDakGJaXLjoHdxJ6wNJwuHG6onr1MAgipxvvdUkG+SL4y66AIwMujlSxmMbFhUCh5
	TIr/iUfk2/A==
X-Received: by 2002:a05:620a:260e:b0:7e3:3288:8ec3 with SMTP id af79cd13be357-7e62a1d8f0bmr1280989185a.32.1753379520493;
        Thu, 24 Jul 2025 10:52:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IES5trMp/rMPFEzeFfVIg1nSSGzwsA9Bv0CIJM5M44RBZc8RPMjeN0kEexldMY6rGl08q3sjA==
X-Received: by 2002:a05:620a:260e:b0:7e3:3288:8ec3 with SMTP id af79cd13be357-7e62a1d8f0bmr1280983985a.32.1753379519982;
        Thu, 24 Jul 2025 10:51:59 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e632e1a73dsm149328785a.58.2025.07.24.10.51.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 10:51:59 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <71548e22-9f3c-469e-a59d-f921da59d927@redhat.com>
Date: Thu, 24 Jul 2025 13:51:57 -0400
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: locking problems in iwlwifi? was Re: 6.16-rcX: crashing way too
 often on thinkpad X220
To: Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>
Cc: kernel list <linux-kernel@vger.kernel.org>, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 peterz@infradead.org, will@kernel.org, miriam.rachel.korenblit@intel.com,
 linux-wireless@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
 John Ogness <jogness@linutronix.de>
References: <aH/L1PCwtwe8Y1+a@duo.ucw.cz> <aID6XPLXuGo+ViTm@duo.ucw.cz>
 <aIEC4t2EICdgomZV@duo.ucw.cz> <874iv2stk3.ffs@tglx> <87zfcurexx.ffs@tglx>
 <aIJqC/0ZPhgaNdkf@duo.ucw.cz>
Content-Language: en-US
In-Reply-To: <aIJqC/0ZPhgaNdkf@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/24/25 1:15 PM, Pavel Machek wrote:
> Hi!
>
> On Wed 2025-07-23 19:32:10, Thomas Gleixner wrote:
>> On Wed, Jul 23 2025 at 19:31, Thomas Gleixner wrote:
>>> On Wed, Jul 23 2025 at 17:42, Pavel Machek wrote:
>>>> Did kernel boot on console (w/o X), and got this: not sure if it is
>>>> related.
>>>> [  402.125635] ------------[ cut here ]------------
>>>> [  402.125638] raw_local_irq_restore() called with IRQs enabled
>>>> [  402.125645] WARNING: CPU: 3 PID: 387 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x25/0x30
>>>> [  402.125654] Modules linked in:
>>>> [  402.125661] CPU: 3 UID: 0 PID: 387 Comm: kworker/u16:5 Tainted: G S                  6.16.0-rc7+ #303 PREEMPT(voluntary)
>>>> [  402.125667] Tainted: [S]=CPU_OUT_OF_SPEC
>>>> [  402.125668] Hardware name: LENOVO 4291W3B/4291W3B, BIOS 8DET73WW (1.43 ) 10/12/2016
>>>> [  402.125671] Workqueue: events_unbound cfg80211_wiphy_work
>>>> [  402.125678] RIP: 0010:warn_bogus_irq_restore+0x25/0x30
>>>> [  402.125683] Code: 90 90 90 90 90 80 3d 51 3d dc 00 00 74 05 c3 cc cc cc cc 55 48 c7 c7 c0 4f c9 85 48 89 e5 c6 05 38 3d dc 00 01 e8 9b d8 e6 fe <0f> 0b 5d c3 cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90
>>>> [  402.125686] RSP: 0018:ffffc9000173fb30 EFLAGS: 00010282
>>>> [  402.125691] RAX: 0000000000000000 RBX: ffffffff8616b460 RCX: 0000000000000000
>>>> [  402.125694] RDX: 0000000000000003 RSI: 0000000000000027 RDI: 00000000ffffffff
>>>> [  402.125696] RBP: ffffc9000173fb30 R08: 0000000028935f32 R09: 0000000000000001
>>>> [  402.125699] R10: 0000000000000044 R11: ffff888100ba52c8 R12: 0000000000000001
>>>> [  402.125702] R13: ffffc9000173fbcb R14: ffffffff84301224 R15: 0000000000000000
>>>> [  402.125704] FS:  0000000000000000(0000) GS:ffff88829007f000(0000) knlGS:0000000000000000
>>>> [  402.125707] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> [  402.125710] CR2: 000055967d471ee0 CR3: 0000000006046001 CR4: 00000000000606b0
>>>> [  402.125713] Call Trace:
>>>> [  402.125716]  <TASK>
>>>> [  402.125719]  console_flush_all+0x41e/0x460
>>> Can you please decode this, so we can see which part of that code it is?
>> And enable lockdep so that we can see where the interrupts were enabled?
> Enabled lockdep and got this one. It seems resume with bad wifi signal
> does it on 6.16...?
>
> Is it any good? Any decoding needed?
>
> ...
> [   32.361445] CPU2 is up
> [   32.361729] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [   32.361982] Disabled fast string operations
> [   32.366800] CPU3 is up
> [   32.370186] ACPI: PM: Waking up from system sleep state S3
> [   32.393904] ACPI: EC: interrupt unblocked
> [   32.396000] sdhci-pci 0000:0d:00.0: MMC controller base frequency changed to 50Mhz.
> [   32.409738] ACPI: EC: event unblocked
> [   32.470808] iwlwifi 0000:03:00.0: Radio type=0x1-0x2-0x0
> [   32.687300] usb 2-1.4: reset full-speed USB device number 4 using ehci-pci
> [   32.758329] ata2: SATA link down (SStatus 0 SControl 300)
> [   32.758375] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [   32.762316] ata5: SATA link down (SStatus 0 SControl 300)
> [   32.764585] ata3.00: ACPI cmd f5/00:00:00:00:00:a0(SECURITY FREEZE LOCK) filtered out
> [   32.764593] ata3.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
> [   32.771931] sd 2:0:0:0: [sdb] Starting disk
> [   32.777439] ata3.00: ACPI cmd f5/00:00:00:00:00:a0(SECURITY FREEZE LOCK) filtered out
> [   32.777450] ata3.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
> [   32.782731] ata3.00: configured for UDMA/133
> [   32.786846] iwlwifi 0000:03:00.0: Radio type=0x1-0x2-0x0
> [   32.858513] usb 2-1.3: reset full-speed USB device number 3 using ehci-pci
> [   33.026331] usb 2-1.6: reset high-speed USB device number 5 using ehci-pci
> [   33.662583] psmouse serio1: synaptics: queried max coordinates: x [..5472], y [..4448]
> [   33.810033] PM: resume devices took 1.404 seconds
> [   33.841597] OOM killer enabled.
> [   33.841808] ACPI: \_SB_.PCI0.LPC_.EC__.BAT1: docking
> [   33.843280] Restarting tasks: Starting
> [   33.849066] ACPI: \_SB_.PCI0.LPC_.EC__.BAT1: Unable to dock!
> [   33.852744] Restarting tasks: Done
> [   33.888306] PM: suspend exit
> [   33.941831] Bluetooth: hci0: BCM: chip id 63
> [   33.944910] Bluetooth: hci0: BCM: features 0x07
> [   33.961985] Bluetooth: hci0: BCM20702A
> [   33.962628] Bluetooth: hci0: BCM20702A1 (001.002.014) build 0000
> [   33.970094] Bluetooth: hci0: BCM: firmware Patch file not found, tried:
> [   33.970993] Bluetooth: hci0: BCM: 'brcm/BCM20702A1-0a5c-21e6.hcd'
> [   33.971410] Bluetooth: hci0: BCM: 'brcm/BCM-0a5c-21e6.hcd'
> [   34.032198] Bluetooth: MGMT ver 1.23
> [   34.838285] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [   35.166235] ata1.00: ACPI cmd f5/00:00:00:00:00:a0(SECURITY FREEZE LOCK) filtered out
> [   35.167828] ata1.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
> [   35.206578] sd 0:0:0:0: [sda] Starting disk
> [   35.238578] ata1.00: ACPI cmd f5/00:00:00:00:00:a0(SECURITY FREEZE LOCK) filtered out
> [   35.240197] ata1.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
> [   35.278928] ata1.00: configured for UDMA/133
> [   35.613471] e1000e 0000:00:19.0 enp0s25: NIC Link is Down
> [   54.283825] wlp3s0: authenticate with c8:3a:35:f0:ad:f1 (local address=a0:88:b4:62:a7:30)
>
> [   54.284095] ================================
> [   54.284097] WARNING: inconsistent lock state
> [   54.284100] 6.16.0-rc7+ #305 Tainted: G S
> [   54.284104] --------------------------------
> [   54.284105] inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
> [   54.284108] wpa_supplicant/2940 [HC0[0]:SC0[0]:HE0:SE1] takes:
> [   54.284114] ffffffff86263fe0 (console_owner){+.?.}-{0:0}, at: console_lock_spinning_enable+0x3d/0x60

The lockdep warning just means that console_owner_lock is acquired both 
in softirq context and in task context with interrupt enabled. That can 
leads to deadlock. So the remedy is to always take console_owner_lock 
with interrupt disabled, i.e. with 
raw_spin_lock_irqsave/raw_spin_lock_irqrestore.

Cheers,
Longman

> [   54.284133] {IN-SOFTIRQ-W} state was registered at:
> [   54.284135]   lock_acquire+0xdc/0x300
> [   54.284144]   console_lock_spinning_enable+0x59/0x60
> [   54.284148]   console_flush_all+0x2c0/0x4d0
> [   54.284153]   console_unlock+0x55/0x100
> [   54.284157]   vprintk_emit+0x15b/0x3a0
> [   54.284162]   vprintk_default+0x18/0x20
> [   54.284166]   vprintk+0x9/0x10
> [   54.284171]   _printk+0x52/0x70
> [   54.284177]   _credit_init_bits.part.0+0xec/0x160
> [   54.284187]   entropy_timer+0xaa/0xc0
> [   54.284194]   call_timer_fn+0xa7/0x260
> [   54.284200]   expire_timers+0xef/0x1b0
> [   54.284205]   run_timer_base+0xb0/0x140
> [   54.284210]   run_timer_softirq+0xb/0x40
> [   54.284215]   handle_softirqs+0xcd/0x490
> [   54.284222]   irq_exit_rcu+0xa2/0x160
> [   54.284227]   sysvec_apic_timer_interrupt+0x9b/0xc0
> [   54.284236]   asm_sysvec_apic_timer_interrupt+0x1b/0x20
> [   54.284242]   cpuidle_enter_state+0x124/0x550
> [   54.284247]   cpuidle_enter+0x29/0x40
> [   54.284253]   do_idle+0x1d9/0x260
> [   54.284262]   cpu_startup_entry+0x27/0x30
> [   54.284270]   start_secondary+0x11e/0x140
> [   54.284277]   common_startup_64+0x129/0x138
> [   54.284285] irq event stamp: 35912
> [   54.284287] hardirqs last  enabled at (35911): [<ffffffff8432d3a1>] __down_trylock_console_sem+0xb1/0xc0
> [   54.284296] hardirqs last disabled at (35912): [<ffffffff84330651>] console_flush_all+0x3e1/0x4d0
> [   54.284302] softirqs last  enabled at (35906): [<ffffffff85608c7e>] ieee80211_check_fast_xmit+0xce/0x820
> [   54.284312] softirqs last disabled at (35904): [<ffffffff85608c2c>] ieee80211_check_fast_xmit+0x7c/0x820
> [   54.284319]
>                 other info that might help us debug this:
> [   54.284321]  Possible unsafe locking scenario:
>
> [   54.284322]        CPU0
> [   54.284323]        ----
> [   54.284324]   lock(console_owner);
> [   54.284328]   <Interrupt>
> [   54.284329]     lock(console_owner);
> [   54.284332]
>                  *** DEADLOCK ***
>
> [   54.284333] 8 locks held by wpa_supplicant/2940:
> [   54.284336]  #0: ffffffff8646f9b0 (cb_lock){++++}-{4:4}, at: genl_rcv+0x15/0x40
> [   54.284351]  #1: ffff888103068768 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: nl80211_pre_doit+0xc2/0x250
> [   54.284367]  #2: ffffffff86344200 (console_lock){+.+.}-{0:0}, at: vprintk_default+0x18/0x20
> [   54.284376]  #3: ffffffff86344250 (console_srcu){....}-{0:0}, at: console_flush_all+0x43/0x4d0
> [   54.284386]  #4: ffffffff86263fe0 (console_owner){+.?.}-{0:0}, at: console_lock_spinning_enable+0x3d/0x60
> [   54.284395]  #5: ffffffff86263f60 (printk_legacy_map-wait-type-override){+...}-{4:4}, at: console_flush_all+0x2d2/0x4d0
> [   54.284404]  #6: ffffffff863ed2f8 (printing_lock){+...}-{3:3}, at: vt_console_print+0x55/0x470
> [   54.284415]  #7: ffffffff86346ac0 (rcu_read_lock){....}-{1:3}, at: __flush_work+0x5e/0x550
> [   54.284428]
>                 stack backtrace:
> [   54.284433] CPU: 3 UID: 0 PID: 2940 Comm: wpa_supplicant Tainted: G S                  6.16.0-rc7+ #305 PREEMPT(voluntary)
> [   54.284441] Tainted: [S]=CPU_OUT_OF_SPEC
> [   54.284443] Hardware name: LENOVO 4291W3B/4291W3B, BIOS 8DET73WW (1.43 ) 10/12/2016
> [   54.284446] Call Trace:
> [   54.284448]  <TASK>
> [   54.284450]  dump_stack_lvl+0x88/0xd0
> [   54.284458]  dump_stack+0x10/0x20
> [   54.284463]  print_usage_bug.part.0+0x237/0x2d0
> [   54.284470]  mark_lock.part.0+0xa9c/0xfb0
> [   54.284479]  mark_held_locks+0x4d/0x80
> [   54.284486]  lockdep_hardirqs_on_prepare+0xff/0x1c0
> [   54.284493]  trace_hardirqs_on+0x5a/0xe0
> [   54.284500]  _raw_spin_unlock_irq+0x23/0x60
> [   54.284505]  __flush_work+0x3b4/0x550
> [   54.284513]  ? __timer_delete+0x2f/0xd0
> [   54.284519]  ? timer_delete+0xb/0x20
> [   54.284524]  ? try_to_grab_pending+0x12a/0x320
> [   54.284534]  cancel_delayed_work_sync+0x65/0x70
> [   54.284539]  fbcon_cursor+0xbe/0x160
> [   54.284548]  hide_cursor+0x2c/0xc0
> [   54.284553]  vt_console_print+0x45e/0x470
> [   54.284560]  console_flush_all+0x301/0x4d0
> [   54.284565]  ? console_flush_all+0x2d2/0x4d0
> [   54.284569]  ? console_flush_all+0x43/0x4d0
> [   54.284572]  ? console_flush_all+0x2d2/0x4d0
> [   54.284579]  console_unlock+0x55/0x100
> [   54.284584]  vprintk_emit+0x15b/0x3a0
> [   54.284590]  vprintk_default+0x18/0x20
> [   54.284595]  vprintk+0x9/0x10
> [   54.284600]  _printk+0x52/0x70
> [   54.284608]  ieee80211_mgd_auth+0x2a3/0x5e0
> [   54.284619]  ? __this_cpu_preempt_check+0x13/0x20
> [   54.284625]  ieee80211_auth+0x13/0x20
> [   54.284631]  cfg80211_mlme_auth+0xeb/0x2a0
> [   54.284640]  nl80211_authenticate+0x341/0x3a0
> [   54.284653]  genl_family_rcv_msg_doit.constprop.0+0xd4/0x130
> [   54.284663]  genl_rcv_msg+0x14c/0x250
> [   54.284669]  ? __pfx_nl80211_pre_doit+0x10/0x10
> [   54.284676]  ? __pfx_nl80211_authenticate+0x10/0x10
> [   54.284684]  ? __pfx_nl80211_post_doit+0x10/0x10
> [   54.284691]  ? __pfx_genl_rcv_msg+0x10/0x10
> [   54.284697]  netlink_rcv_skb+0x55/0x100
> [   54.284706]  genl_rcv+0x24/0x40
> [   54.284712]  netlink_unicast+0x1e8/0x2b0
> [   54.284718]  netlink_sendmsg+0x1e3/0x400
> [   54.284726]  ____sys_sendmsg+0x2a0/0x2f0
> [   54.284736]  ? copy_msghdr_from_user+0x71/0xb0
> [   54.284744]  ___sys_sendmsg+0x85/0xd0
> [   54.284751]  ? find_held_lock+0x31/0x90
> [   54.284756]  ? __might_fault+0x2c/0x70
> [   54.284762]  ? __this_cpu_preempt_check+0x13/0x20
> [   54.284766]  ? __might_fault+0x2c/0x70
> [   54.284771]  ? __might_fault+0x2c/0x70
> [   54.284776]  ? debug_smp_processor_id+0x17/0x20
> [   54.284781]  __sys_sendmsg+0x6e/0xd0
> [   54.284788]  ? do_syscall_64+0x39/0x2c0
> [   54.284795]  __x64_sys_sendmsg+0x1a/0x20
> [   54.284801]  x64_sys_call+0x929/0x2150
> [   54.284808]  do_syscall_64+0x71/0x2c0
> [   54.284814]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   54.284819] RIP: 0033:0x7f79e0d28fb3
> [   54.284825] Code: 64 89 02 48 c7 c0 ff ff ff ff eb b7 66 2e 0f 1f 84 00 00 00 00 00 90 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 89 54 24 1c 48
> [   54.284831] RSP: 002b:00007ffc79c940b8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> [   54.284837] RAX: ffffffffffffffda RBX: 000055b73b414650 RCX: 00007f79e0d28fb3
> [   54.284840] RDX: 0000000000000000 RSI: 00007ffc79c940f0 RDI: 0000000000000006
> [   54.284843] RBP: 000055b73b44dc70 R08: 0000000000000004 R09: 00007f79e0dfabe0
> [   54.284846] R10: 00007ffc79c941c4 R11: 0000000000000246 R12: 000055b73b414560
> [   54.284849] R13: 00007ffc79c940f0 R14: 00007ffc79c941c4 R15: 000055b73b453f20
> [   54.284856]  </TASK>
> [   54.285774] ------------[ cut here ]------------
> [   54.285777] raw_local_irq_restore() called with IRQs enabled
> [   54.285788] WARNING: CPU: 3 PID: 2940 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x25/0x30
> [   54.285801] Modules linked in:
> [   54.285807] CPU: 3 UID: 0 PID: 2940 Comm: wpa_supplicant Tainted: G S                  6.16.0-rc7+ #305 PREEMPT(voluntary)
> [   54.285814] Tainted: [S]=CPU_OUT_OF_SPEC
> [   54.285817] Hardware name: LENOVO 4291W3B/4291W3B, BIOS 8DET73WW (1.43 ) 10/12/2016
> [   54.285820] RIP: 0010:warn_bogus_irq_restore+0x25/0x30
> [   54.285828] Code: 90 90 90 90 90 80 3d c2 5f e3 00 00 74 05 c3 cc cc cc cc 55 48 c7 c7 98 2f fa 85 c6 05 ac 5f e3 00 01 48 89 e5 e8 db 23 be fe <0f> 0b 5d c3 cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90
> [   54.285834] RSP: 0018:ffffc90001acb690 EFLAGS: 00010282
> [   54.285839] RAX: 0000000000000000 RBX: ffffffff863ed460 RCX: 0000000000000000
> [   54.285843] RDX: 0000000000000003 RSI: 0000000000000027 RDI: 00000000ffffffff
> [   54.285847] RBP: ffffc90001acb690 R08: 0000000000000000 R09: 0000000000000000
> [   54.285850] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
> [   54.285853] R13: ffffc90001acb72b R14: 0000000000000200 R15: 0000000000000000
> [   54.285857] FS:  00007f79e08da1c0(0000) GS:ffff88828fcf5000(0000) knlGS:0000000000000000
> [   54.285862] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   54.285865] CR2: 000055b73b455000 CR3: 000000010b07e005 CR4: 00000000000606b0
> [   54.285869] Call Trace:
> [   54.285872]  <TASK>
> [   54.285874]  console_flush_all+0x47d/0x4d0
> [   54.285880]  ? console_flush_all+0x43/0x4d0
> [   54.285885]  ? console_flush_all+0x2d2/0x4d0
> [   54.285892]  console_unlock+0x55/0x100
> [   54.285898]  vprintk_emit+0x15b/0x3a0
> [   54.285904]  vprintk_default+0x18/0x20
> [   54.285910]  vprintk+0x9/0x10
> [   54.285915]  _printk+0x52/0x70
> [   54.285924]  ieee80211_mgd_auth+0x2a3/0x5e0
> [   54.285934]  ? __this_cpu_preempt_check+0x13/0x20
> [   54.285940]  ieee80211_auth+0x13/0x20
> [   54.285945]  cfg80211_mlme_auth+0xeb/0x2a0
> [   54.285954]  nl80211_authenticate+0x341/0x3a0
> [   54.285967]  genl_family_rcv_msg_doit.constprop.0+0xd4/0x130
> [   54.285977]  genl_rcv_msg+0x14c/0x250
> [   54.285984]  ? __pfx_nl80211_pre_doit+0x10/0x10
> [   54.285991]  ? __pfx_nl80211_authenticate+0x10/0x10
> [   54.286000]  ? __pfx_nl80211_post_doit+0x10/0x10
> [   54.286007]  ? __pfx_genl_rcv_msg+0x10/0x10
> [   54.286014]  netlink_rcv_skb+0x55/0x100
> [   54.286023]  genl_rcv+0x24/0x40
> [   54.286029]  netlink_unicast+0x1e8/0x2b0
> [   54.286036]  netlink_sendmsg+0x1e3/0x400
> [   54.286044]  ____sys_sendmsg+0x2a0/0x2f0
> [   54.286052]  ? copy_msghdr_from_user+0x71/0xb0
> [   54.286061]  ___sys_sendmsg+0x85/0xd0
> [   54.286068]  ? find_held_lock+0x31/0x90
> [   54.286073]  ? __might_fault+0x2c/0x70
> [   54.286078]  ? __this_cpu_preempt_check+0x13/0x20
> [   54.286083]  ? __might_fault+0x2c/0x70
> [   54.286088]  ? __might_fault+0x2c/0x70
> [   54.286094]  ? debug_smp_processor_id+0x17/0x20
> [   54.286100]  __sys_sendmsg+0x6e/0xd0
> [   54.286108]  ? do_syscall_64+0x39/0x2c0
> [   54.286114]  __x64_sys_sendmsg+0x1a/0x20
> [   54.286168]  x64_sys_call+0x929/0x2150
> [   54.286182]  do_syscall_64+0x71/0x2c0
> [   54.286193]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   54.286200] RIP: 0033:0x7f79e0d28fb3
> [   54.286207] Code: 64 89 02 48 c7 c0 ff ff ff ff eb b7 66 2e 0f 1f 84 00 00 00 00 00 90 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 89 54 24 1c 48
> [   54.286215] RSP: 002b:00007ffc79c940b8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> [   54.286225] RAX: ffffffffffffffda RBX: 000055b73b414650 RCX: 00007f79e0d28fb3
> [   54.286230] RDX: 0000000000000000 RSI: 00007ffc79c940f0 RDI: 0000000000000006
> [   54.286235] RBP: 000055b73b44dc70 R08: 0000000000000004 R09: 00007f79e0dfabe0
> [   54.286246] R10: 00007ffc79c941c4 R11: 0000000000000246 R12: 000055b73b414560
> [   54.286247] R13: 00007ffc79c940f0 R14: 00007ffc79c941c4 R15: 000055b73b453f20
> [   54.286266]  </TASK>
> [   54.286269] irq event stamp: 35912
> [   54.286273] hardirqs last  enabled at (35911): [<ffffffff8432d3a1>] __down_trylock_console_sem+0xb1/0xc0
> [   54.286286] hardirqs last disabled at (35912): [<ffffffff84330651>] console_flush_all+0x3e1/0x4d0
> [   54.286294] softirqs last  enabled at (35906): [<ffffffff85608c7e>] ieee80211_check_fast_xmit+0xce/0x820
> [   54.286306] softirqs last disabled at (35904): [<ffffffff85608c2c>] ieee80211_check_fast_xmit+0x7c/0x820
> [   54.286318] ---[ end trace 0000000000000000 ]---
> [   54.373428] wlp3s0: send auth to c8:3a:35:f0:ad:f1 (try 1/3)
> [   54.381882] wlp3s0: authenticated
> [   54.386240] wlp3s0: associate with c8:3a:35:f0:ad:f1 (try 1/3)
> [   54.392641] wlp3s0: RX AssocResp from c8:3a:35:f0:ad:f1 (capab=0x411 status=0 aid=6)
> [   54.413392] wlp3s0: associated
>
> Best regards,
> 											Pavel
>


