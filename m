Return-Path: <linux-wireless+bounces-26008-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCBDB11510
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Jul 2025 02:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C8DC3A33A3
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Jul 2025 00:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FB1CA5A;
	Fri, 25 Jul 2025 00:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OINqxZWP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7351362
	for <linux-wireless@vger.kernel.org>; Fri, 25 Jul 2025 00:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753402603; cv=none; b=Uco9N/KM3tKwXEyau8kcUjQ0pdOVWf0YAmaY2XeEyNqBwGNvL0HCbpLX+7kkJ0ytJg64SHxqZrNp/HoA5sWPSMXZ1pVPo1dEn4Tf6Qv3Vmd3dIicFCTVn8kyccWoEFV+2UdgN/6165beL9+DSBrG9cxDFrOzM+1Zl536LawPOro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753402603; c=relaxed/simple;
	bh=w2tyNT/8zoaQV6BVtt0r0C477qGXxBDbaNhaTrvP1xA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=J5YbZockNgavtDny5wVqAcNziaziVnVw4tHgc5R0PWiq3HbK3DCe28fiQiz3DCi/t5wrxdNwUyg0/EBqMTarq1YOs9ZQEq5+8ypZtjtjxfkhEluDnN7gbSLcXQgKF+6UrbHU38Jnsb8iJMJiL3K+fQlm3cnXnR3L3P7yAWYRTEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OINqxZWP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753402600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yxkCG1yTGps2VHoOjMaTU3xu9TxGhl6vX8auTC53uYs=;
	b=OINqxZWPfXvegwvmhZIpkTVN13fnbJzaHLVmke9RtV7aQTH1sVoPqtbE3uQPJsqR8lvG3V
	wdhW7XzWxQa/F/JVZiQcn9nQKAUOkmtH5i4oWBnyJkLYbGkfdhP/eh9HlLQRsreReGEogx
	myVIvvaKuSEXuLvl/FgY4hpvJLwS3aI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-piX3i1LVNqK6n-62hscoMw-1; Thu, 24 Jul 2025 20:16:39 -0400
X-MC-Unique: piX3i1LVNqK6n-62hscoMw-1
X-Mimecast-MFC-AGG-ID: piX3i1LVNqK6n-62hscoMw_1753402598
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e338e627f1so528239985a.0
        for <linux-wireless@vger.kernel.org>; Thu, 24 Jul 2025 17:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753402598; x=1754007398;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yxkCG1yTGps2VHoOjMaTU3xu9TxGhl6vX8auTC53uYs=;
        b=TECLfX1qsRqyXXo2I+LakL7MMPayaIbC0sT89hpF272mNzh7dC7+W74GzclWEEpRNf
         O9Dt9eVfzutltHBfyFPlzEgNcjLONrBZBf34cLIl0PVMmNvQHzu7hBJcRCxlY0RlFxWt
         dA5d7XhTaoL8jp9c2kvN+KxBdly444dLMli9juUkIcFOM6n2BqJG7qH7D6D8nPeQNsgE
         etoe+zX2kQVPuujAVB2bM3RgOCt3pY7vZ7ALS+Uio2uBGwuK01MrJWxptsvFB2a7uG8W
         yKLWspJYa2//mSDNssq6gEUcodFKYB65r9riHMVY/brHe3WbXdasvgkpNaJCctUFYz/J
         iivw==
X-Forwarded-Encrypted: i=1; AJvYcCXuySupDu4omnBn+sbTnhr203pLVwuDrDwqFQ8ap1UKAS5ICqgsJS+1eJAAqGDMGla9qY5KTkLrdCIai8MllA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2QvNaNDIeeXbtDvPd7A3cHOLYF7x79/65CT15f/b+Wljvsiay
	ZJjYkLnK+nRBuGQGkZy3rhifJ2diKuQshydB9et3lida6SdL3B17BBvraBdn/HxurvfgJ2xRfKi
	WUMdEr8j3uGCoR0/6uqUuNZkpFbVnR03+WwzjBGVIpw7kkG13WxjZ9FxAfHffaoayv7a0
X-Gm-Gg: ASbGncvR6Dc8X0hgUwWR2U4ESjPNuNL4yFUMm7YzZAXagmkswPFlqiXZkh0jqTP5Jc8
	IuzLnlyu3icRFHCZH9Ndrei5h5shpbyIU2LDEuFRv3m+X/sPdxLZE0BkQ460xQupYdpY9S4jSff
	HvxgXygVeaL+AUZNbWXyba3kp+3grKZsGD5PneRohZKV5SNdWf8IlLiu5rbpNarMl8COHSH2tNt
	zD/KEepoVU77gMPTL/YJ1KiJphOgQkC6F5wM0GPQIZ1MDqePLGYG44ktZRhznYx79yLaV+qOHYz
	l+xmvNTv2pQDAMdS247dzp2ccpB4yLq2w0a49uUAVlKUGshcvu1N1kRWyHit9ajPTkTZuXNiQLU
	HNJS3Q0jFLw==
X-Received: by 2002:a05:620a:a0b:b0:7e3:3da8:1d06 with SMTP id af79cd13be357-7e62a194985mr933152885a.54.1753402598274;
        Thu, 24 Jul 2025 17:16:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIxp8r8rY48I41C8InfUkbbre2eucccOUajs9doqLqYJz5vXJaT0VW2+hA21MpNGYwWsFNDA==
X-Received: by 2002:a05:620a:a0b:b0:7e3:3da8:1d06 with SMTP id af79cd13be357-7e62a194985mr933148885a.54.1753402597708;
        Thu, 24 Jul 2025 17:16:37 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e632e38544sm186374085a.71.2025.07.24.17.16.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 17:16:36 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <6a27ffeb-a79b-4623-9ad3-392973a1fcce@redhat.com>
Date: Thu, 24 Jul 2025 20:16:35 -0400
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: locking problems in iwlwifi? was Re: 6.16-rcX: crashing way too
 often on thinkpad X220
To: John Ogness <jogness@linutronix.de>, Waiman Long <llong@redhat.com>,
 Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>
Cc: kernel list <linux-kernel@vger.kernel.org>, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 peterz@infradead.org, will@kernel.org, miriam.rachel.korenblit@intel.com,
 linux-wireless@vger.kernel.org, Petr Mladek <pmladek@suse.com>
References: <aH/L1PCwtwe8Y1+a@duo.ucw.cz> <aID6XPLXuGo+ViTm@duo.ucw.cz>
 <aIEC4t2EICdgomZV@duo.ucw.cz> <874iv2stk3.ffs@tglx> <87zfcurexx.ffs@tglx>
 <aIJqC/0ZPhgaNdkf@duo.ucw.cz>
 <71548e22-9f3c-469e-a59d-f921da59d927@redhat.com>
 <848qkdtlsl.fsf@jogness.linutronix.de>
Content-Language: en-US
In-Reply-To: <848qkdtlsl.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/24/25 3:45 PM, John Ogness wrote:
> On 2025-07-24, Waiman Long <llong@redhat.com> wrote:
>> On 7/24/25 1:15 PM, Pavel Machek wrote:
>>> Hi!
>>>
>>> On Wed 2025-07-23 19:32:10, Thomas Gleixner wrote:
>>>> On Wed, Jul 23 2025 at 19:31, Thomas Gleixner wrote:
>>>>> On Wed, Jul 23 2025 at 17:42, Pavel Machek wrote:
>>>>>> Did kernel boot on console (w/o X), and got this: not sure if it is
>>>>>> related.
>>>>>> [  402.125635] ------------[ cut here ]------------
>>>>>> [  402.125638] raw_local_irq_restore() called with IRQs enabled
>>>>>> [  402.125645] WARNING: CPU: 3 PID: 387 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x25/0x30
>>>>>> [  402.125654] Modules linked in:
>>>>>> [  402.125661] CPU: 3 UID: 0 PID: 387 Comm: kworker/u16:5 Tainted: G S                  6.16.0-rc7+ #303 PREEMPT(voluntary)
>>>>>> [  402.125667] Tainted: [S]=CPU_OUT_OF_SPEC
>>>>>> [  402.125668] Hardware name: LENOVO 4291W3B/4291W3B, BIOS 8DET73WW (1.43 ) 10/12/2016
>>>>>> [  402.125671] Workqueue: events_unbound cfg80211_wiphy_work
>>>>>> [  402.125678] RIP: 0010:warn_bogus_irq_restore+0x25/0x30
>>>>>> [  402.125683] Code: 90 90 90 90 90 80 3d 51 3d dc 00 00 74 05 c3 cc cc cc cc 55 48 c7 c7 c0 4f c9 85 48 89 e5 c6 05 38 3d dc 00 01 e8 9b d8 e6 fe <0f> 0b 5d c3 cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90
>>>>>> [  402.125686] RSP: 0018:ffffc9000173fb30 EFLAGS: 00010282
>>>>>> [  402.125691] RAX: 0000000000000000 RBX: ffffffff8616b460 RCX: 0000000000000000
>>>>>> [  402.125694] RDX: 0000000000000003 RSI: 0000000000000027 RDI: 00000000ffffffff
>>>>>> [  402.125696] RBP: ffffc9000173fb30 R08: 0000000028935f32 R09: 0000000000000001
>>>>>> [  402.125699] R10: 0000000000000044 R11: ffff888100ba52c8 R12: 0000000000000001
>>>>>> [  402.125702] R13: ffffc9000173fbcb R14: ffffffff84301224 R15: 0000000000000000
>>>>>> [  402.125704] FS:  0000000000000000(0000) GS:ffff88829007f000(0000) knlGS:0000000000000000
>>>>>> [  402.125707] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>> [  402.125710] CR2: 000055967d471ee0 CR3: 0000000006046001 CR4: 00000000000606b0
>>>>>> [  402.125713] Call Trace:
>>>>>> [  402.125716]  <TASK>
>>>>>> [  402.125719]  console_flush_all+0x41e/0x460
>>>>> Can you please decode this, so we can see which part of that code it is?
>>>> And enable lockdep so that we can see where the interrupts were enabled?
>>> Enabled lockdep and got this one. It seems resume with bad wifi signal
>>> does it on 6.16...?
>>>
>>> Is it any good? Any decoding needed?
>>>
>>> ...
>>> [   32.361445] CPU2 is up
>>> [   32.361729] smpboot: Booting Node 0 Processor 3 APIC 0x3
>>> [   32.361982] Disabled fast string operations
>>> [   32.366800] CPU3 is up
>>> [   32.370186] ACPI: PM: Waking up from system sleep state S3
>>> [   32.393904] ACPI: EC: interrupt unblocked
>>> [   32.396000] sdhci-pci 0000:0d:00.0: MMC controller base frequency changed to 50Mhz.
>>> [   32.409738] ACPI: EC: event unblocked
>>> [   32.470808] iwlwifi 0000:03:00.0: Radio type=0x1-0x2-0x0
>>> [   32.687300] usb 2-1.4: reset full-speed USB device number 4 using ehci-pci
>>> [   32.758329] ata2: SATA link down (SStatus 0 SControl 300)
>>> [   32.758375] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>>> [   32.762316] ata5: SATA link down (SStatus 0 SControl 300)
>>> [   32.764585] ata3.00: ACPI cmd f5/00:00:00:00:00:a0(SECURITY FREEZE LOCK) filtered out
>>> [   32.764593] ata3.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
>>> [   32.771931] sd 2:0:0:0: [sdb] Starting disk
>>> [   32.777439] ata3.00: ACPI cmd f5/00:00:00:00:00:a0(SECURITY FREEZE LOCK) filtered out
>>> [   32.777450] ata3.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
>>> [   32.782731] ata3.00: configured for UDMA/133
>>> [   32.786846] iwlwifi 0000:03:00.0: Radio type=0x1-0x2-0x0
>>> [   32.858513] usb 2-1.3: reset full-speed USB device number 3 using ehci-pci
>>> [   33.026331] usb 2-1.6: reset high-speed USB device number 5 using ehci-pci
>>> [   33.662583] psmouse serio1: synaptics: queried max coordinates: x [..5472], y [..4448]
>>> [   33.810033] PM: resume devices took 1.404 seconds
>>> [   33.841597] OOM killer enabled.
>>> [   33.841808] ACPI: \_SB_.PCI0.LPC_.EC__.BAT1: docking
>>> [   33.843280] Restarting tasks: Starting
>>> [   33.849066] ACPI: \_SB_.PCI0.LPC_.EC__.BAT1: Unable to dock!
>>> [   33.852744] Restarting tasks: Done
>>> [   33.888306] PM: suspend exit
>>> [   33.941831] Bluetooth: hci0: BCM: chip id 63
>>> [   33.944910] Bluetooth: hci0: BCM: features 0x07
>>> [   33.961985] Bluetooth: hci0: BCM20702A
>>> [   33.962628] Bluetooth: hci0: BCM20702A1 (001.002.014) build 0000
>>> [   33.970094] Bluetooth: hci0: BCM: firmware Patch file not found, tried:
>>> [   33.970993] Bluetooth: hci0: BCM: 'brcm/BCM20702A1-0a5c-21e6.hcd'
>>> [   33.971410] Bluetooth: hci0: BCM: 'brcm/BCM-0a5c-21e6.hcd'
>>> [   34.032198] Bluetooth: MGMT ver 1.23
>>> [   34.838285] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
>>> [   35.166235] ata1.00: ACPI cmd f5/00:00:00:00:00:a0(SECURITY FREEZE LOCK) filtered out
>>> [   35.167828] ata1.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
>>> [   35.206578] sd 0:0:0:0: [sda] Starting disk
>>> [   35.238578] ata1.00: ACPI cmd f5/00:00:00:00:00:a0(SECURITY FREEZE LOCK) filtered out
>>> [   35.240197] ata1.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
>>> [   35.278928] ata1.00: configured for UDMA/133
>>> [   35.613471] e1000e 0000:00:19.0 enp0s25: NIC Link is Down
>>> [   54.283825] wlp3s0: authenticate with c8:3a:35:f0:ad:f1 (local address=a0:88:b4:62:a7:30)
>>>
>>> [   54.284095] ================================
>>> [   54.284097] WARNING: inconsistent lock state
>>> [   54.284100] 6.16.0-rc7+ #305 Tainted: G S
>>> [   54.284104] --------------------------------
>>> [   54.284105] inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
>>> [   54.284108] wpa_supplicant/2940 [HC0[0]:SC0[0]:HE0:SE1] takes:
>>> [   54.284114] ffffffff86263fe0 (console_owner){+.?.}-{0:0}, at: console_lock_spinning_enable+0x3d/0x60
>> The lockdep warning just means that console_owner_lock is acquired both
>> in softirq context and in task context with interrupt enabled. That can
>> leads to deadlock. So the remedy is to always take console_owner_lock
>> with interrupt disabled, i.e. with
>> raw_spin_lock_irqsave/raw_spin_lock_irqrestore.
> There are only 3 functions using this lock:
>
> 1. console_lock_spinning_enable()
> 2. console_lock_spinning_disable_and_check()
> 3. console_trylock_spinning()
>
> For all call sites of 1 and 2, it is surrounded by
> printk_safe_enter_irqsave()/_exit_irqrestore() calls. These explicitly
> call local_irq_save()/_restore().
>
> For 3, it explicitly calls
> printk_safe_enter_irqsave()/_exit_irqrestore().
>
> I wonder if this is a false positive because console_trylock_spinning()
> annotates the acquire after re-enabling interrupts:
>
> static int console_trylock_spinning(void)
> {
> 	...
> 	printk_safe_exit_irqrestore(flags);
> 	...
> 	mutex_acquire(&console_lock_dep_map, 0, 1, _THIS_IP_);
> 	...
> }
>
> As to the crashing problem at hand, it might be faster to bisect the
> wireless-next-2025-05-22 merge.

I am sorry for confusing conole_owner_lock with the console_owner 
lockdep map. Yes, this lockdep splat should be a false positive. You do 
need to put the mutex_acquire before printk_safe_exit_irqrestore() to 
avoid this splat.

Cheers,
Longman


