Return-Path: <linux-wireless+bounces-25998-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8C6B1103F
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 19:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5185AC56A8
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 17:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EAF1DED40;
	Thu, 24 Jul 2025 17:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="ONwfdXn6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D667DA6C;
	Thu, 24 Jul 2025 17:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753377348; cv=none; b=B8FvRtu3FEHr9L96OPpb+cEdm6Liod56SwqsMd8Rj1XibCD2DQMbfDVK3ZjuECn/7Ju4P9SSsqysYaSuR1FALooIv8Two7l4yrXtSusKXGQL2dpWecFv2LkRxICrKzNd68csiUntGu/RAFZx7nm4XVUmsnSiX23JnuAmqyVDN38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753377348; c=relaxed/simple;
	bh=KY8MAnCg6UwKpBYx0hp5WLsQYH/m5Te1TBViPOE67AA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0shFBE9d+daZ4cmM7TB+IS7IBzm6IfDTiM5EG86XJeZpgo5CDUDc00A+MaTtUHavPZJF99odUt9lGpRwYlttMlVP+4QtZbRvNJt1mF4C9qxVOVNBDMDHnbwIu9fOFaV3olb2xZPjKyzO0lf0r8FUAVbP52cb8JYDy92Ju8ddDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=ONwfdXn6; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 446F51C00B7; Thu, 24 Jul 2025 19:15:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1753377341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GTBhuGooGWuu+g85KIF76/LE5jNx1ktdwmI4iGePDVs=;
	b=ONwfdXn6nNAU3fPZa5ytje48X0IwBliGTpOPPnZ3IE8+zxC8tRBXpO0Dqyi52j6SlyeZLW
	ZB/bWOzJUO2/jo9AgM9uKpYBzvSPBXGAwsoEw5fA95Ei++UzuWoSY8g4FUVzJ56eJy8uw/
	SIiD5YheLxVrLzftGltPF04thxL5ISQ=
Date: Thu, 24 Jul 2025 19:15:22 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel list <linux-kernel@vger.kernel.org>, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, peterz@infradead.org, will@kernel.org,
	longman@redhat.com, miriam.rachel.korenblit@intel.com,
	linux-wireless@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
	John Ogness <jogness@linutronix.de>
Subject: Re: locking problems in iwlwifi? was Re: 6.16-rcX: crashing way too
 often on thinkpad X220
Message-ID: <aIJqC/0ZPhgaNdkf@duo.ucw.cz>
References: <aH/L1PCwtwe8Y1+a@duo.ucw.cz>
 <aID6XPLXuGo+ViTm@duo.ucw.cz>
 <aIEC4t2EICdgomZV@duo.ucw.cz>
 <874iv2stk3.ffs@tglx>
 <87zfcurexx.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sCFq5JaPoBZvobQT"
Content-Disposition: inline
In-Reply-To: <87zfcurexx.ffs@tglx>


--sCFq5JaPoBZvobQT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Wed 2025-07-23 19:32:10, Thomas Gleixner wrote:
> On Wed, Jul 23 2025 at 19:31, Thomas Gleixner wrote:
> > On Wed, Jul 23 2025 at 17:42, Pavel Machek wrote:
> >> Did kernel boot on console (w/o X), and got this: not sure if it is
> >> related.
> >> [  402.125635] ------------[ cut here ]------------
> >> [  402.125638] raw_local_irq_restore() called with IRQs enabled
> >> [  402.125645] WARNING: CPU: 3 PID: 387 at kernel/locking/irqflag-debu=
g.c:10 warn_bogus_irq_restore+0x25/0x30
> >> [  402.125654] Modules linked in:
> >> [  402.125661] CPU: 3 UID: 0 PID: 387 Comm: kworker/u16:5 Tainted: G S=
                  6.16.0-rc7+ #303 PREEMPT(voluntary)=20
> >> [  402.125667] Tainted: [S]=3DCPU_OUT_OF_SPEC
> >> [  402.125668] Hardware name: LENOVO 4291W3B/4291W3B, BIOS 8DET73WW (1=
=2E43 ) 10/12/2016
> >> [  402.125671] Workqueue: events_unbound cfg80211_wiphy_work
> >> [  402.125678] RIP: 0010:warn_bogus_irq_restore+0x25/0x30
> >> [  402.125683] Code: 90 90 90 90 90 80 3d 51 3d dc 00 00 74 05 c3 cc c=
c cc cc 55 48 c7 c7 c0 4f c9 85 48 89 e5 c6 05 38 3d dc 00 01 e8 9b d8 e6 f=
e <0f> 0b 5d c3 cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90
> >> [  402.125686] RSP: 0018:ffffc9000173fb30 EFLAGS: 00010282
> >> [  402.125691] RAX: 0000000000000000 RBX: ffffffff8616b460 RCX: 000000=
0000000000
> >> [  402.125694] RDX: 0000000000000003 RSI: 0000000000000027 RDI: 000000=
00ffffffff
> >> [  402.125696] RBP: ffffc9000173fb30 R08: 0000000028935f32 R09: 000000=
0000000001
> >> [  402.125699] R10: 0000000000000044 R11: ffff888100ba52c8 R12: 000000=
0000000001
> >> [  402.125702] R13: ffffc9000173fbcb R14: ffffffff84301224 R15: 000000=
0000000000
> >> [  402.125704] FS:  0000000000000000(0000) GS:ffff88829007f000(0000) k=
nlGS:0000000000000000
> >> [  402.125707] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> [  402.125710] CR2: 000055967d471ee0 CR3: 0000000006046001 CR4: 000000=
00000606b0
> >> [  402.125713] Call Trace:
> >> [  402.125716]  <TASK>
> >> [  402.125719]  console_flush_all+0x41e/0x460
> >
> > Can you please decode this, so we can see which part of that code it is?
>=20
> And enable lockdep so that we can see where the interrupts were enabled?

Enabled lockdep and got this one. It seems resume with bad wifi signal
does it on 6.16...?

Is it any good? Any decoding needed?

=2E..
[   32.361445] CPU2 is up
[   32.361729] smpboot: Booting Node 0 Processor 3 APIC 0x3
[   32.361982] Disabled fast string operations
[   32.366800] CPU3 is up
[   32.370186] ACPI: PM: Waking up from system sleep state S3
[   32.393904] ACPI: EC: interrupt unblocked
[   32.396000] sdhci-pci 0000:0d:00.0: MMC controller base frequency change=
d to 50Mhz.
[   32.409738] ACPI: EC: event unblocked
[   32.470808] iwlwifi 0000:03:00.0: Radio type=3D0x1-0x2-0x0
[   32.687300] usb 2-1.4: reset full-speed USB device number 4 using ehci-p=
ci
[   32.758329] ata2: SATA link down (SStatus 0 SControl 300)
[   32.758375] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   32.762316] ata5: SATA link down (SStatus 0 SControl 300)
[   32.764585] ata3.00: ACPI cmd f5/00:00:00:00:00:a0(SECURITY FREEZE LOCK)=
 filtered out
[   32.764593] ata3.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtere=
d out
[   32.771931] sd 2:0:0:0: [sdb] Starting disk
[   32.777439] ata3.00: ACPI cmd f5/00:00:00:00:00:a0(SECURITY FREEZE LOCK)=
 filtered out
[   32.777450] ata3.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtere=
d out
[   32.782731] ata3.00: configured for UDMA/133
[   32.786846] iwlwifi 0000:03:00.0: Radio type=3D0x1-0x2-0x0
[   32.858513] usb 2-1.3: reset full-speed USB device number 3 using ehci-p=
ci
[   33.026331] usb 2-1.6: reset high-speed USB device number 5 using ehci-p=
ci
[   33.662583] psmouse serio1: synaptics: queried max coordinates: x [..547=
2], y [..4448]
[   33.810033] PM: resume devices took 1.404 seconds
[   33.841597] OOM killer enabled.
[   33.841808] ACPI: \_SB_.PCI0.LPC_.EC__.BAT1: docking
[   33.843280] Restarting tasks: Starting
[   33.849066] ACPI: \_SB_.PCI0.LPC_.EC__.BAT1: Unable to dock!
[   33.852744] Restarting tasks: Done
[   33.888306] PM: suspend exit
[   33.941831] Bluetooth: hci0: BCM: chip id 63
[   33.944910] Bluetooth: hci0: BCM: features 0x07
[   33.961985] Bluetooth: hci0: BCM20702A
[   33.962628] Bluetooth: hci0: BCM20702A1 (001.002.014) build 0000
[   33.970094] Bluetooth: hci0: BCM: firmware Patch file not found, tried:
[   33.970993] Bluetooth: hci0: BCM: 'brcm/BCM20702A1-0a5c-21e6.hcd'
[   33.971410] Bluetooth: hci0: BCM: 'brcm/BCM-0a5c-21e6.hcd'
[   34.032198] Bluetooth: MGMT ver 1.23
[   34.838285] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   35.166235] ata1.00: ACPI cmd f5/00:00:00:00:00:a0(SECURITY FREEZE LOCK)=
 filtered out
[   35.167828] ata1.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtere=
d out
[   35.206578] sd 0:0:0:0: [sda] Starting disk
[   35.238578] ata1.00: ACPI cmd f5/00:00:00:00:00:a0(SECURITY FREEZE LOCK)=
 filtered out
[   35.240197] ata1.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtere=
d out
[   35.278928] ata1.00: configured for UDMA/133
[   35.613471] e1000e 0000:00:19.0 enp0s25: NIC Link is Down
[   54.283825] wlp3s0: authenticate with c8:3a:35:f0:ad:f1 (local address=
=3Da0:88:b4:62:a7:30)

[   54.284095] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   54.284097] WARNING: inconsistent lock state
[   54.284100] 6.16.0-rc7+ #305 Tainted: G S                =20
[   54.284104] --------------------------------
[   54.284105] inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
[   54.284108] wpa_supplicant/2940 [HC0[0]:SC0[0]:HE0:SE1] takes:
[   54.284114] ffffffff86263fe0 (console_owner){+.?.}-{0:0}, at: console_lo=
ck_spinning_enable+0x3d/0x60
[   54.284133] {IN-SOFTIRQ-W} state was registered at:
[   54.284135]   lock_acquire+0xdc/0x300
[   54.284144]   console_lock_spinning_enable+0x59/0x60
[   54.284148]   console_flush_all+0x2c0/0x4d0
[   54.284153]   console_unlock+0x55/0x100
[   54.284157]   vprintk_emit+0x15b/0x3a0
[   54.284162]   vprintk_default+0x18/0x20
[   54.284166]   vprintk+0x9/0x10
[   54.284171]   _printk+0x52/0x70
[   54.284177]   _credit_init_bits.part.0+0xec/0x160
[   54.284187]   entropy_timer+0xaa/0xc0
[   54.284194]   call_timer_fn+0xa7/0x260
[   54.284200]   expire_timers+0xef/0x1b0
[   54.284205]   run_timer_base+0xb0/0x140
[   54.284210]   run_timer_softirq+0xb/0x40
[   54.284215]   handle_softirqs+0xcd/0x490
[   54.284222]   irq_exit_rcu+0xa2/0x160
[   54.284227]   sysvec_apic_timer_interrupt+0x9b/0xc0
[   54.284236]   asm_sysvec_apic_timer_interrupt+0x1b/0x20
[   54.284242]   cpuidle_enter_state+0x124/0x550
[   54.284247]   cpuidle_enter+0x29/0x40
[   54.284253]   do_idle+0x1d9/0x260
[   54.284262]   cpu_startup_entry+0x27/0x30
[   54.284270]   start_secondary+0x11e/0x140
[   54.284277]   common_startup_64+0x129/0x138
[   54.284285] irq event stamp: 35912
[   54.284287] hardirqs last  enabled at (35911): [<ffffffff8432d3a1>] __do=
wn_trylock_console_sem+0xb1/0xc0
[   54.284296] hardirqs last disabled at (35912): [<ffffffff84330651>] cons=
ole_flush_all+0x3e1/0x4d0
[   54.284302] softirqs last  enabled at (35906): [<ffffffff85608c7e>] ieee=
80211_check_fast_xmit+0xce/0x820
[   54.284312] softirqs last disabled at (35904): [<ffffffff85608c2c>] ieee=
80211_check_fast_xmit+0x7c/0x820
[   54.284319]=20
               other info that might help us debug this:
[   54.284321]  Possible unsafe locking scenario:

[   54.284322]        CPU0
[   54.284323]        ----
[   54.284324]   lock(console_owner);
[   54.284328]   <Interrupt>
[   54.284329]     lock(console_owner);
[   54.284332]=20
                *** DEADLOCK ***

[   54.284333] 8 locks held by wpa_supplicant/2940:
[   54.284336]  #0: ffffffff8646f9b0 (cb_lock){++++}-{4:4}, at: genl_rcv+0x=
15/0x40
[   54.284351]  #1: ffff888103068768 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: nl=
80211_pre_doit+0xc2/0x250
[   54.284367]  #2: ffffffff86344200 (console_lock){+.+.}-{0:0}, at: vprint=
k_default+0x18/0x20
[   54.284376]  #3: ffffffff86344250 (console_srcu){....}-{0:0}, at: consol=
e_flush_all+0x43/0x4d0
[   54.284386]  #4: ffffffff86263fe0 (console_owner){+.?.}-{0:0}, at: conso=
le_lock_spinning_enable+0x3d/0x60
[   54.284395]  #5: ffffffff86263f60 (printk_legacy_map-wait-type-override)=
{+...}-{4:4}, at: console_flush_all+0x2d2/0x4d0
[   54.284404]  #6: ffffffff863ed2f8 (printing_lock){+...}-{3:3}, at: vt_co=
nsole_print+0x55/0x470
[   54.284415]  #7: ffffffff86346ac0 (rcu_read_lock){....}-{1:3}, at: __flu=
sh_work+0x5e/0x550
[   54.284428]=20
               stack backtrace:
[   54.284433] CPU: 3 UID: 0 PID: 2940 Comm: wpa_supplicant Tainted: G S   =
               6.16.0-rc7+ #305 PREEMPT(voluntary)=20
[   54.284441] Tainted: [S]=3DCPU_OUT_OF_SPEC
[   54.284443] Hardware name: LENOVO 4291W3B/4291W3B, BIOS 8DET73WW (1.43 )=
 10/12/2016
[   54.284446] Call Trace:
[   54.284448]  <TASK>
[   54.284450]  dump_stack_lvl+0x88/0xd0
[   54.284458]  dump_stack+0x10/0x20
[   54.284463]  print_usage_bug.part.0+0x237/0x2d0
[   54.284470]  mark_lock.part.0+0xa9c/0xfb0
[   54.284479]  mark_held_locks+0x4d/0x80
[   54.284486]  lockdep_hardirqs_on_prepare+0xff/0x1c0
[   54.284493]  trace_hardirqs_on+0x5a/0xe0
[   54.284500]  _raw_spin_unlock_irq+0x23/0x60
[   54.284505]  __flush_work+0x3b4/0x550
[   54.284513]  ? __timer_delete+0x2f/0xd0
[   54.284519]  ? timer_delete+0xb/0x20
[   54.284524]  ? try_to_grab_pending+0x12a/0x320
[   54.284534]  cancel_delayed_work_sync+0x65/0x70
[   54.284539]  fbcon_cursor+0xbe/0x160
[   54.284548]  hide_cursor+0x2c/0xc0
[   54.284553]  vt_console_print+0x45e/0x470
[   54.284560]  console_flush_all+0x301/0x4d0
[   54.284565]  ? console_flush_all+0x2d2/0x4d0
[   54.284569]  ? console_flush_all+0x43/0x4d0
[   54.284572]  ? console_flush_all+0x2d2/0x4d0
[   54.284579]  console_unlock+0x55/0x100
[   54.284584]  vprintk_emit+0x15b/0x3a0
[   54.284590]  vprintk_default+0x18/0x20
[   54.284595]  vprintk+0x9/0x10
[   54.284600]  _printk+0x52/0x70
[   54.284608]  ieee80211_mgd_auth+0x2a3/0x5e0
[   54.284619]  ? __this_cpu_preempt_check+0x13/0x20
[   54.284625]  ieee80211_auth+0x13/0x20
[   54.284631]  cfg80211_mlme_auth+0xeb/0x2a0
[   54.284640]  nl80211_authenticate+0x341/0x3a0
[   54.284653]  genl_family_rcv_msg_doit.constprop.0+0xd4/0x130
[   54.284663]  genl_rcv_msg+0x14c/0x250
[   54.284669]  ? __pfx_nl80211_pre_doit+0x10/0x10
[   54.284676]  ? __pfx_nl80211_authenticate+0x10/0x10
[   54.284684]  ? __pfx_nl80211_post_doit+0x10/0x10
[   54.284691]  ? __pfx_genl_rcv_msg+0x10/0x10
[   54.284697]  netlink_rcv_skb+0x55/0x100
[   54.284706]  genl_rcv+0x24/0x40
[   54.284712]  netlink_unicast+0x1e8/0x2b0
[   54.284718]  netlink_sendmsg+0x1e3/0x400
[   54.284726]  ____sys_sendmsg+0x2a0/0x2f0
[   54.284736]  ? copy_msghdr_from_user+0x71/0xb0
[   54.284744]  ___sys_sendmsg+0x85/0xd0
[   54.284751]  ? find_held_lock+0x31/0x90
[   54.284756]  ? __might_fault+0x2c/0x70
[   54.284762]  ? __this_cpu_preempt_check+0x13/0x20
[   54.284766]  ? __might_fault+0x2c/0x70
[   54.284771]  ? __might_fault+0x2c/0x70
[   54.284776]  ? debug_smp_processor_id+0x17/0x20
[   54.284781]  __sys_sendmsg+0x6e/0xd0
[   54.284788]  ? do_syscall_64+0x39/0x2c0
[   54.284795]  __x64_sys_sendmsg+0x1a/0x20
[   54.284801]  x64_sys_call+0x929/0x2150
[   54.284808]  do_syscall_64+0x71/0x2c0
[   54.284814]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   54.284819] RIP: 0033:0x7f79e0d28fb3
[   54.284825] Code: 64 89 02 48 c7 c0 ff ff ff ff eb b7 66 2e 0f 1f 84 00 =
00 00 00 00 90 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 2e 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 89 54 24 1c 48
[   54.284831] RSP: 002b:00007ffc79c940b8 EFLAGS: 00000246 ORIG_RAX: 000000=
000000002e
[   54.284837] RAX: ffffffffffffffda RBX: 000055b73b414650 RCX: 00007f79e0d=
28fb3
[   54.284840] RDX: 0000000000000000 RSI: 00007ffc79c940f0 RDI: 00000000000=
00006
[   54.284843] RBP: 000055b73b44dc70 R08: 0000000000000004 R09: 00007f79e0d=
fabe0
[   54.284846] R10: 00007ffc79c941c4 R11: 0000000000000246 R12: 000055b73b4=
14560
[   54.284849] R13: 00007ffc79c940f0 R14: 00007ffc79c941c4 R15: 000055b73b4=
53f20
[   54.284856]  </TASK>
[   54.285774] ------------[ cut here ]------------
[   54.285777] raw_local_irq_restore() called with IRQs enabled
[   54.285788] WARNING: CPU: 3 PID: 2940 at kernel/locking/irqflag-debug.c:=
10 warn_bogus_irq_restore+0x25/0x30
[   54.285801] Modules linked in:
[   54.285807] CPU: 3 UID: 0 PID: 2940 Comm: wpa_supplicant Tainted: G S   =
               6.16.0-rc7+ #305 PREEMPT(voluntary)=20
[   54.285814] Tainted: [S]=3DCPU_OUT_OF_SPEC
[   54.285817] Hardware name: LENOVO 4291W3B/4291W3B, BIOS 8DET73WW (1.43 )=
 10/12/2016
[   54.285820] RIP: 0010:warn_bogus_irq_restore+0x25/0x30
[   54.285828] Code: 90 90 90 90 90 80 3d c2 5f e3 00 00 74 05 c3 cc cc cc =
cc 55 48 c7 c7 98 2f fa 85 c6 05 ac 5f e3 00 01 48 89 e5 e8 db 23 be fe <0f=
> 0b 5d c3 cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90
[   54.285834] RSP: 0018:ffffc90001acb690 EFLAGS: 00010282
[   54.285839] RAX: 0000000000000000 RBX: ffffffff863ed460 RCX: 00000000000=
00000
[   54.285843] RDX: 0000000000000003 RSI: 0000000000000027 RDI: 00000000fff=
fffff
[   54.285847] RBP: ffffc90001acb690 R08: 0000000000000000 R09: 00000000000=
00000
[   54.285850] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00001
[   54.285853] R13: ffffc90001acb72b R14: 0000000000000200 R15: 00000000000=
00000
[   54.285857] FS:  00007f79e08da1c0(0000) GS:ffff88828fcf5000(0000) knlGS:=
0000000000000000
[   54.285862] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   54.285865] CR2: 000055b73b455000 CR3: 000000010b07e005 CR4: 00000000000=
606b0
[   54.285869] Call Trace:
[   54.285872]  <TASK>
[   54.285874]  console_flush_all+0x47d/0x4d0
[   54.285880]  ? console_flush_all+0x43/0x4d0
[   54.285885]  ? console_flush_all+0x2d2/0x4d0
[   54.285892]  console_unlock+0x55/0x100
[   54.285898]  vprintk_emit+0x15b/0x3a0
[   54.285904]  vprintk_default+0x18/0x20
[   54.285910]  vprintk+0x9/0x10
[   54.285915]  _printk+0x52/0x70
[   54.285924]  ieee80211_mgd_auth+0x2a3/0x5e0
[   54.285934]  ? __this_cpu_preempt_check+0x13/0x20
[   54.285940]  ieee80211_auth+0x13/0x20
[   54.285945]  cfg80211_mlme_auth+0xeb/0x2a0
[   54.285954]  nl80211_authenticate+0x341/0x3a0
[   54.285967]  genl_family_rcv_msg_doit.constprop.0+0xd4/0x130
[   54.285977]  genl_rcv_msg+0x14c/0x250
[   54.285984]  ? __pfx_nl80211_pre_doit+0x10/0x10
[   54.285991]  ? __pfx_nl80211_authenticate+0x10/0x10
[   54.286000]  ? __pfx_nl80211_post_doit+0x10/0x10
[   54.286007]  ? __pfx_genl_rcv_msg+0x10/0x10
[   54.286014]  netlink_rcv_skb+0x55/0x100
[   54.286023]  genl_rcv+0x24/0x40
[   54.286029]  netlink_unicast+0x1e8/0x2b0
[   54.286036]  netlink_sendmsg+0x1e3/0x400
[   54.286044]  ____sys_sendmsg+0x2a0/0x2f0
[   54.286052]  ? copy_msghdr_from_user+0x71/0xb0
[   54.286061]  ___sys_sendmsg+0x85/0xd0
[   54.286068]  ? find_held_lock+0x31/0x90
[   54.286073]  ? __might_fault+0x2c/0x70
[   54.286078]  ? __this_cpu_preempt_check+0x13/0x20
[   54.286083]  ? __might_fault+0x2c/0x70
[   54.286088]  ? __might_fault+0x2c/0x70
[   54.286094]  ? debug_smp_processor_id+0x17/0x20
[   54.286100]  __sys_sendmsg+0x6e/0xd0
[   54.286108]  ? do_syscall_64+0x39/0x2c0
[   54.286114]  __x64_sys_sendmsg+0x1a/0x20
[   54.286168]  x64_sys_call+0x929/0x2150
[   54.286182]  do_syscall_64+0x71/0x2c0
[   54.286193]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   54.286200] RIP: 0033:0x7f79e0d28fb3
[   54.286207] Code: 64 89 02 48 c7 c0 ff ff ff ff eb b7 66 2e 0f 1f 84 00 =
00 00 00 00 90 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 2e 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 89 54 24 1c 48
[   54.286215] RSP: 002b:00007ffc79c940b8 EFLAGS: 00000246 ORIG_RAX: 000000=
000000002e
[   54.286225] RAX: ffffffffffffffda RBX: 000055b73b414650 RCX: 00007f79e0d=
28fb3
[   54.286230] RDX: 0000000000000000 RSI: 00007ffc79c940f0 RDI: 00000000000=
00006
[   54.286235] RBP: 000055b73b44dc70 R08: 0000000000000004 R09: 00007f79e0d=
fabe0
[   54.286246] R10: 00007ffc79c941c4 R11: 0000000000000246 R12: 000055b73b4=
14560
[   54.286247] R13: 00007ffc79c940f0 R14: 00007ffc79c941c4 R15: 000055b73b4=
53f20
[   54.286266]  </TASK>
[   54.286269] irq event stamp: 35912
[   54.286273] hardirqs last  enabled at (35911): [<ffffffff8432d3a1>] __do=
wn_trylock_console_sem+0xb1/0xc0
[   54.286286] hardirqs last disabled at (35912): [<ffffffff84330651>] cons=
ole_flush_all+0x3e1/0x4d0
[   54.286294] softirqs last  enabled at (35906): [<ffffffff85608c7e>] ieee=
80211_check_fast_xmit+0xce/0x820
[   54.286306] softirqs last disabled at (35904): [<ffffffff85608c2c>] ieee=
80211_check_fast_xmit+0x7c/0x820
[   54.286318] ---[ end trace 0000000000000000 ]---
[   54.373428] wlp3s0: send auth to c8:3a:35:f0:ad:f1 (try 1/3)
[   54.381882] wlp3s0: authenticated
[   54.386240] wlp3s0: associate with c8:3a:35:f0:ad:f1 (try 1/3)
[   54.392641] wlp3s0: RX AssocResp from c8:3a:35:f0:ad:f1 (capab=3D0x411 s=
tatus=3D0 aid=3D6)
[   54.413392] wlp3s0: associated

Best regards,
											Pavel

--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, and Musk!

--sCFq5JaPoBZvobQT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaIJqKgAKCRAw5/Bqldv6
8nVKAJ4yLEp8w4gK5pG5vWkCi7XXFx+8RACfT/GsXyo1BFX+AoTfgYp1uUa852E=
=6god
-----END PGP SIGNATURE-----

--sCFq5JaPoBZvobQT--

