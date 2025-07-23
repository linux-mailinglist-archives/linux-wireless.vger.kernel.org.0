Return-Path: <linux-wireless+bounces-25956-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A710B0FC36
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 23:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7D731AA5EE3
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 21:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1956F270568;
	Wed, 23 Jul 2025 21:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="ERgPD8M2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E1B207DE2;
	Wed, 23 Jul 2025 21:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753306970; cv=none; b=VoGSkOyrLrJYLF7xeQ8ZMbNd9xMj51TtQo7Xa5wkD3f8xldKsIOoCvp/ZIu+NZop6aHZiTdIZuIlw3sjsnWG1DDPEr/+tB1XyveyLQVun+DzRXd3FzWTziKohX5JolgxXkSgN+OsqxqX5cy5ganMJHk5U4yc9OnoTZ9etWzT9TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753306970; c=relaxed/simple;
	bh=oYbZcy/ReDB7lDzknFRTqYKpaCesVPdKI4A7BMBmBcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oF7AzFCGCbTtpuYqQ44YZshz7Y1zKWVBl54KRVB/m4lslhrnejTP4aCiYQTDyX3esqJksE+nXeIflmL7SRFGm53Y6YtG0iMjKKyo3pxLsPevDo0NudGXAW6q0HFQUYpdy2fhz5zvotMWqbBNrVCJNO/ioXuDh66P//BBJWB0HxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=ERgPD8M2; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 1A3E51C00C8; Wed, 23 Jul 2025 23:42:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1753306963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BdjaOoB+oH42zfDSvMQcXJmhpkW+WkCrXip5wgRommY=;
	b=ERgPD8M2el/4F/jXFSU87UtBoZpOjyGerN3NXg5LrMaJ+M5UWeuPDWFS1GccvUQZud4WNX
	/jeh9jeMwY6wm7AgLzufAl7SBeYui6CrKi71CouNKgxjD4bZAeQiBZYn5upaEjTPmqc+C5
	hPBZs8s84NiW52U1VhVCWxhcIEQIPdw=
Date: Wed, 23 Jul 2025 23:42:30 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: kernel list <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, peterz@infradead.org,
	will@kernel.org, longman@redhat.com,
	miriam.rachel.korenblit@intel.com, linux-wireless@vger.kernel.org
Subject: Re: locking problems in iwlwifi? was Re: 6.16-rcX: crashing way too
 often on thinkpad X220
Message-ID: <aIFXRhGVU0VJidUA@duo.ucw.cz>
References: <aH/L1PCwtwe8Y1+a@duo.ucw.cz>
 <aID6XPLXuGo+ViTm@duo.ucw.cz>
 <aIEC4t2EICdgomZV@duo.ucw.cz>
 <c5c06a93845f72b40c6df82fcbc89d3163a01d8b.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Vr3qKgMlQB7egiaB"
Content-Disposition: inline
In-Reply-To: <c5c06a93845f72b40c6df82fcbc89d3163a01d8b.camel@sipsolutions.net>


--Vr3qKgMlQB7egiaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> On Wed, 2025-07-23 at 17:42 +0200, Pavel Machek wrote:
> > [  402.125635] ------------[ cut here ]------------
> > [  402.125638] raw_local_irq_restore() called with IRQs enabled
> > [  402.125645] WARNING: CPU: 3 PID: 387 at kernel/locking/irqflag-debug=
=2Ec:10 warn_bogus_irq_restore+0x25/0x30
> > [  402.125654] Modules linked in:
> > [  402.125661] CPU: 3 UID: 0 PID: 387 Comm: kworker/u16:5 Tainted: G S =
                 6.16.0-rc7+ #303 PREEMPT(voluntary)=20
> > [  402.125667] Tainted: [S]=3DCPU_OUT_OF_SPEC
> > [  402.125668] Hardware name: LENOVO 4291W3B/4291W3B, BIOS 8DET73WW (1.=
43 ) 10/12/2016
> > [  402.125671] Workqueue: events_unbound cfg80211_wiphy_work
> > [  402.125678] RIP: 0010:warn_bogus_irq_restore+0x25/0x30
> > [  402.125683] Code: 90 90 90 90 90 80 3d 51 3d dc 00 00 74 05 c3 cc cc=
 cc cc 55 48 c7 c7 c0 4f c9 85 48 89 e5 c6 05 38 3d dc 00 01 e8 9b d8 e6 fe=
 <0f> 0b 5d c3 cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90
> > [  402.125686] RSP: 0018:ffffc9000173fb30 EFLAGS: 00010282
> > [  402.125691] RAX: 0000000000000000 RBX: ffffffff8616b460 RCX: 0000000=
000000000
> > [  402.125694] RDX: 0000000000000003 RSI: 0000000000000027 RDI: 0000000=
0ffffffff
> > [  402.125696] RBP: ffffc9000173fb30 R08: 0000000028935f32 R09: 0000000=
000000001
> > [  402.125699] R10: 0000000000000044 R11: ffff888100ba52c8 R12: 0000000=
000000001
> > [  402.125702] R13: ffffc9000173fbcb R14: ffffffff84301224 R15: 0000000=
000000000
> > [  402.125704] FS:  0000000000000000(0000) GS:ffff88829007f000(0000) kn=
lGS:0000000000000000
> > [  402.125707] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  402.125710] CR2: 000055967d471ee0 CR3: 0000000006046001 CR4: 0000000=
0000606b0
> > [  402.125713] Call Trace:
> > [  402.125716]  <TASK>
> > [  402.125719]  console_flush_all+0x41e/0x460
> > [  402.125725]  ? console_flush_all+0x43/0x460
> > [  402.125735]  console_unlock+0x55/0x100
> > [  402.125741]  vprintk_emit+0x157/0x320
> > [  402.125748]  vprintk_default+0x18/0x20
> > [  402.125752]  vprintk+0x9/0x10
> > [  402.125756]  _printk+0x52/0x70
> > [  402.125766]  ieee80211_sta_rx_queued_mgmt+0x4c8/0xd30
> > [  402.125775]  ? __this_cpu_preempt_check+0x13/0x20
> > [  402.125784]  ieee80211_iface_work+0x3ad/0x500
>=20
> That's not great, but I don't see how the driver or wifi subsystem is
> involved ... ieee80211_sta_rx_queued_mgmt() doesn't even use spinlocks
> let alone disable IRQs or use raw_ APIs, and it's in the middle of
> printk anyway.
>=20
> No idea what might be going on here, sorry.

Does this give any more hints? I seem to have... pretty unhappy wifi,
followed by slab corruption.

Is my assumption correct that this looks like wifi problem?

(I can share full logs via personal email).

BR,
								Pavel

Jul 23 23:29:19 duo kernel: wlp3s0: authenticated
Jul 23 23:29:19 duo kernel: wlp3s0: associate with c8:3a:35:f0:ad:f1 (try 1=
/3)
Jul 23 23:29:19 duo kernel: wlp3s0: RX AssocResp from c8:3a:35:f0:ad:f1 (ca=
pab=3D0x411 status=3D0 aid=3D7)
Jul 23 23:29:19 duo wpa_supplicant[2868]: wlp3s0: Associated with c8:3a:35:=
f0:ad:f1
Jul 23 23:29:19 duo wpa_supplicant[2868]: wlp3s0: CTRL-EVENT-SUBNET-STATUS-=
UPDATE status=3D0
Jul 23 23:29:19 duo kernel: wlp3s0: associated
Jul 23 23:29:19 duo NetworkManager[2853]: <info>  [1753306159.2521] device =
(wlp3s0): supplicant interface state: associating -> associated
Jul 23 23:29:19 duo NetworkManager[2853]: <info>  [1753306159.2522] device =
(wlp3s0): DHCPv4 lease renewal requested
Jul 23 23:29:19 duo NetworkManager[2853]: <info>  [1753306159.2524] dhcp4 (=
wlp3s0): canceled DHCP transaction
Jul 23 23:29:19 duo NetworkManager[2853]: <info>  [1753306159.2525] dhcp4 (=
wlp3s0): state changed extended -> terminated
Jul 23 23:29:19 duo NetworkManager[2853]: <info>  [1753306159.2532] dhcp4 (=
wlp3s0): activation: beginning transaction (timeout in 45 seconds)
Jul 23 23:29:19 duo NetworkManager[2853]: <info>  [1753306159.5357] device =
(wlp3s0): supplicant interface state: associated -> 4way_handshake
Jul 23 23:29:19 duo wpa_supplicant[2868]: wlp3s0: WPA: Key negotiation comp=
leted with c8:3a:35:f0:ad:f1 [PTK=3DCCMP GTK=3DCCMP]
Jul 23 23:29:19 duo wpa_supplicant[2868]: wlp3s0: CTRL-EVENT-CONNECTED - Co=
nnection to c8:3a:35:f0:ad:f1 completed [id=3D0 id_str=3D]
Jul 23 23:29:19 duo NetworkManager[2853]: <info>  [1753306159.5766] device =
(wlp3s0): supplicant interface state: 4way_handshake -> completed
Jul 23 23:29:19 duo wpa_supplicant[2868]: wlp3s0: CTRL-EVENT-SIGNAL-CHANGE =
above=3D1 signal=3D-71 noise=3D9999 txrate=3D0
Jul 23 23:29:23 duo sudo[78117]:    pavel : TTY=3Dpts/1 ; PWD=3D/fast/pavel=
 ; USER=3Droot ; COMMAND=3D/usr/sbin/hdparm -B 255 /dev/sda
Jul 23 23:29:23 duo sudo[78117]: pam_unix(sudo:session): session opened for=
 user root(uid=3D0) by (uid=3D1000)
Jul 23 23:29:23 duo sudo[78117]: pam_unix(sudo:session): session closed for=
 user root
Jul 23 23:29:27 duo kernel: iwlwifi 0000:03:00.0: Microcode SW error detect=
ed.  Restarting 0x2000000.
Jul 23 23:29:27 duo kernel: iwlwifi 0000:03:00.0: Loaded firmware version: =
18.168.6.1 6000g2a-6.ucode
Jul 23 23:29:27 duo kernel: iwlwifi 0000:03:00.0: Start IWL Error Log Dump:
Jul 23 23:29:27 duo kernel: iwlwifi 0000:03:00.0: Status: 0x0000044C, count=
: 6
Jul 23 23:29:27 duo kernel: iwlwifi 0000:03:00.0: 0x00001030 | ADVANCED_SYS=
ASSERT         =20
Jul 23 23:29:27 duo kernel: iwlwifi 0000:03:00.0: 0x0000C064 | uPc
Jul 23 23:29:27 duo kernel: iwlwifi 0000:03:00.0: 0x0000C05C | branchlink1
Jul 23 23:29:27 duo kernel: iwlwifi 0000:03:00.0: 0x0000C05C | branchlink2
Jul 23 23:29:27 duo kernel: iwlwifi 0000:03:00.0: 0x0000D6BE | interruptlin=
k1
Jul 23 23:29:27 duo kernel: iwlwifi 0000:03:00.0: 0x00000000 | interruptlin=
k2
Jul 23 23:29:27 duo kernel: iwlwifi 0000:03:00.0: 0x003900EE | data1
Jul 23 23:29:27 duo kernel: iwlwifi 0000:03:00.0: 0x00000000 | data2
Jul 23 23:29:27 duo kernel: iwlwifi 0000:03:00.0: 0x00000800 | line
Jul 23 23:29:27 duo kernel: iwlwifi 0000:03:00.0: 0x14413F07 | beacon time
Jul 23 23:29:27 duo kernel: iwlwifi 0000:03:00.0: 0xF6E050F9 | tsf low
Jul 23 23:29:27 duo kernel: iwlwifi 0000:03:00.0: 0x00000000 | tsf hi
Jul 23 23:29:27 duo kernel: iwlwifi 0000:03:00.0: 0x000005CB | time gp1
Jul 23 23:29:27 duo kernel: iwlwifi 0000:03:00.0: 0x533515F9 | time gp2
Jul 23 23:29:27 duo kernel: iwlwifi 0000:03:00.0: 0x00000000 | time gp3
Jul 23 23:29:27 duo kernel: iwlwifi 0000:03:00.0: 0x754312A8 | uCode version
Jul 23 23:29:27 duo kernel: iwlwifi 0000:03:00.0: 0x000000B0 | hw version
Jul 23 23:29:27 duo kernel: iwlwifi 0000:03:00.0: 0x00488700 | board version
Jul 23 23:29:27 duo kernel: iwlwifi 0000:03:00.0: 0x003A001C | hcmd
Jul 23 23:29:27 duo kernel: iwlwifi 0000:03:00.0: 0xA786300A | isr0
Jul 23 23:29:27 duo kernel: iwlwifi 0000:03:00.0: 0x1141E000 | isr1
Jul 23 23:29:27 duo kernel: iwlwifi 0000:03:00.0: 0x00000F1A | isr2
Jul 23 23:29:27 duo kernel: iwlwifi 0000:03:00.0: 0x014730C0 | isr3
Jul 23 23:29:27 duo kernel: iwlwifi 0000:03:00.0: 0x00000000 | isr4
Jul 23 23:29:27 duo kernel: iwlwifi 0000:03:00.0: 0x00010110 | isr_pref
Jul 23 23:29:27 duo kernel: iwlwifi 0000:03:00.0: 0x00023098 | wait_event
Jul 23 23:29:27 duo kernel: iwlwifi 0000:03:00.0: 0x00004288 | l2p_control
Jul 23 23:29:27 duo kernel: iwlwifi 0000:03:00.0: 0x0000003C | l2p_duration
Jul 23 23:29:27 duo kernel: iwlwifi 0000:03:00.0: 0x00000000 | l2p_mhvalid
Jul 23 23:29:27 duo kernel: iwlwifi 0000:03:00.0: 0x001054F7 | l2p_addr_mat=
ch
Jul 23 23:29:27 duo kernel: iwlwifi 0000:03:00.0: 0x00000015 | lmpm_pmg_sel
Jul 23 23:29:27 duo kernel: iwlwifi 0000:03:00.0: 0x06061222 | timestamp
Jul 23 23:29:27 duo kernel: iwlwifi 0000:03:00.0: 0x000098A8 | flow_handler
Jul 23 23:29:27 duo kernel: iwlwifi 0000:03:00.0: Start IWL Event Log Dump:=
 nothing in log
Jul 23 23:29:27 duo kernel: iwlwifi 0000:03:00.0: Device error - SW reset
Jul 23 23:29:27 duo kernel: ieee80211 phy0: Hardware restart was requested
Jul 23 23:29:27 duo kernel: iwlwifi 0000:03:00.0: Radio type=3D0x1-0x2-0x0
Jul 23 23:29:27 duo kernel: iwlwifi 0000:03:00.0: Radio type=3D0x1-0x2-0x0
Jul 23 23:29:29 duo sudo[78137]:    pavel : TTY=3Dpts/0 ; PWD=3D/fast/pavel=
 ; USER=3Droot ; COMMAND=3D/usr/sbin/hdparm -B 255 /dev/sda
Jul 23 23:29:29 duo sudo[78137]: pam_unix(sudo:session): session opened for=
 user root(uid=3D0) by (uid=3D1000)
Jul 23 23:29:29 duo sudo[78137]: pam_unix(sudo:session): session closed for=
 user root
Jul 23 23:29:47 duo wpa_supplicant[2868]: wlp3s0: CTRL-EVENT-SIGNAL-CHANGE =
above=3D1 signal=3D-58 noise=3D9999 txrate=3D54000
Jul 23 23:29:47 duo kernel: iwlwifi 0000:03:00.0: Microcode SW error detect=
ed.  Restarting 0x2000000.
Jul 23 23:29:47 duo kernel: iwlwifi 0000:03:00.0: Loaded firmware version: =
18.168.6.1 6000g2a-6.ucode
Jul 23 23:29:47 duo kernel: iwlwifi 0000:03:00.0: Start IWL Error Log Dump:
Jul 23 23:29:47 duo kernel: iwlwifi 0000:03:00.0: Status: 0x0000044C, count=
: 6
Jul 23 23:29:47 duo kernel: iwlwifi 0000:03:00.0: 0x00001030 | ADVANCED_SYS=
ASSERT         =20
Jul 23 23:29:47 duo kernel: iwlwifi 0000:03:00.0: 0x0000C064 | uPc
Jul 23 23:29:47 duo kernel: iwlwifi 0000:03:00.0: 0x0000C05C | branchlink1
Jul 23 23:29:47 duo kernel: iwlwifi 0000:03:00.0: 0x0000C05C | branchlink2
Jul 23 23:29:47 duo kernel: iwlwifi 0000:03:00.0: 0x0000D6BE | interruptlin=
k1
Jul 23 23:29:47 duo kernel: iwlwifi 0000:03:00.0: 0x00000000 | interruptlin=
k2
Jul 23 23:29:47 duo kernel: iwlwifi 0000:03:00.0: 0x0045011D | data1
Jul 23 23:29:47 duo kernel: iwlwifi 0000:03:00.0: 0x00000000 | data2
Jul 23 23:29:47 duo kernel: iwlwifi 0000:03:00.0: 0x00000800 | line
Jul 23 23:29:47 duo kernel: iwlwifi 0000:03:00.0: 0x30406BE5 | beacon time
Jul 23 23:29:47 duo kernel: iwlwifi 0000:03:00.0: 0xF816841B | tsf low
Jul 23 23:29:47 duo kernel: iwlwifi 0000:03:00.0: 0x00000000 | tsf hi
Jul 23 23:29:47 duo kernel: iwlwifi 0000:03:00.0: 0x0000056B | time gp1
Jul 23 23:29:47 duo kernel: iwlwifi 0000:03:00.0: 0x01312AC3 | time gp2
Jul 23 23:29:47 duo kernel: iwlwifi 0000:03:00.0: 0x00000000 | time gp3
Jul 23 23:29:47 duo kernel: iwlwifi 0000:03:00.0: 0x754312A8 | uCode version
Jul 23 23:29:47 duo kernel: iwlwifi 0000:03:00.0: 0x000000B0 | hw version
Jul 23 23:29:47 duo kernel: iwlwifi 0000:03:00.0: 0x00488700 | board version
Jul 23 23:29:47 duo kernel: iwlwifi 0000:03:00.0: 0x000C001C | hcmd
Jul 23 23:29:47 duo kernel: iwlwifi 0000:03:00.0: 0xA7F6300A | isr0
Jul 23 23:29:47 duo kernel: iwlwifi 0000:03:00.0: 0x0101E000 | isr1
Jul 23 23:29:47 duo kernel: iwlwifi 0000:03:00.0: 0x00000E1A | isr2
Jul 23 23:29:47 duo kernel: iwlwifi 0000:03:00.0: 0x014768C0 | isr3
Jul 23 23:29:47 duo kernel: iwlwifi 0000:03:00.0: 0x00000000 | isr4
Jul 23 23:29:47 duo kernel: iwlwifi 0000:03:00.0: 0x10014112 | isr_pref
Jul 23 23:29:47 duo kernel: iwlwifi 0000:03:00.0: 0x00023098 | wait_event
Jul 23 23:29:47 duo kernel: iwlwifi 0000:03:00.0: 0x000000C4 | l2p_control
Jul 23 23:29:47 duo kernel: iwlwifi 0000:03:00.0: 0x00000586 | l2p_duration
Jul 23 23:29:47 duo kernel: iwlwifi 0000:03:00.0: 0x00000007 | l2p_mhvalid
Jul 23 23:29:47 duo kernel: iwlwifi 0000:03:00.0: 0x00101042 | l2p_addr_mat=
ch
Jul 23 23:29:47 duo kernel: iwlwifi 0000:03:00.0: 0x00000015 | lmpm_pmg_sel
Jul 23 23:29:47 duo kernel: iwlwifi 0000:03:00.0: 0x06061222 | timestamp
Jul 23 23:29:47 duo kernel: iwlwifi 0000:03:00.0: 0x0000A8B8 | flow_handler
Jul 23 23:29:47 duo kernel: iwlwifi 0000:03:00.0: Start IWL Event Log Dump:=
 nothing in log
Jul 23 23:29:47 duo kernel: iwlwifi 0000:03:00.0: Device error - SW reset
Jul 23 23:29:47 duo kernel: ieee80211 phy0: Hardware restart was requested
Jul 23 23:29:47 duo kernel: iwlwifi 0000:03:00.0: Radio type=3D0x1-0x2-0x0
Jul 23 23:29:48 duo kernel: iwlwifi 0000:03:00.0: Radio type=3D0x1-0x2-0x0
Jul 23 23:29:53 duo sudo[78189]:    pavel : TTY=3Dpts/1 ; PWD=3D/fast/pavel=
 ; USER=3Droot ; COMMAND=3D/usr/sbin/hdparm -B 255 /dev/sda
Jul 23 23:29:53 duo sudo[78189]: pam_unix(sudo:session): session opened for=
 user root(uid=3D0) by (uid=3D1000)
Jul 23 23:29:53 duo sudo[78189]: pam_unix(sudo:session): session closed for=
 user root
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: Microcode SW error detect=
ed.  Restarting 0x2000000.
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: Loaded firmware version: =
18.168.6.1 6000g2a-6.ucode
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: Start IWL Error Log Dump:
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: Status: 0x0000044C, count=
: 6
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: 0x00001030 | ADVANCED_SYS=
ASSERT         =20
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: 0x0000C064 | uPc
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: 0x0000C05C | branchlink1
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: 0x0000C05C | branchlink2
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: 0x0000D6BE | interruptlin=
k1
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: 0x00000000 | interruptlin=
k2
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: 0x003C00FA | data1
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: 0x00000000 | data2
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: 0x00000800 | line
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: 0x0D005446 | beacon time
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: 0xF86E1BBA | tsf low
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: 0x00000000 | tsf hi
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: 0x00000577 | time gp1
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: 0x00528405 | time gp2
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: 0x00000000 | time gp3
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: 0x754312A8 | uCode version
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: 0x000000B0 | hw version
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: 0x00488700 | board version
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: 0x000A001C | hcmd
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: 0xA7F63008 | isr0
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: 0x0101E000 | isr1
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: 0x00000E1A | isr2
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: 0x014730C0 | isr3
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: 0x00000000 | isr4
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: 0x10010112 | isr_pref
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: 0x00023098 | wait_event
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: 0x000000C4 | l2p_control
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: 0x00000592 | l2p_duration
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: 0x00000007 | l2p_mhvalid
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: 0x00101042 | l2p_addr_mat=
ch
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: 0x00000015 | lmpm_pmg_sel
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: 0x06061222 | timestamp
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: 0x00000818 | flow_handler
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: Start IWL Event Log Dump:=
 nothing in log
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: Device error - reprobe!
Jul 23 23:29:53 duo wpa_supplicant[2868]: wlp3s0: CTRL-EVENT-DISCONNECTED b=
ssid=3Dc8:3a:35:f0:ad:f1 reason=3D3 locally_generated=3D1
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: Command REPLY_LEDS_CMD fa=
iled: FW Error
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: Command REPLY_LEDS_CMD fa=
iled: FW Error
Jul 23 23:29:53 duo kernel: wlp3s0: deauthenticating from c8:3a:35:f0:ad:f1=
 by local choice (Reason: 3=3DDEAUTH_LEAVING)
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: Command REPLY_TXFIFO_FLUS=
H failed: FW Error
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: flush request fail
Jul 23 23:29:53 duo kernel: ------------[ cut here ]------------
Jul 23 23:29:53 duo kernel: bad state =3D 0
Jul 23 23:29:53 duo kernel: WARNING: CPU: 2 PID: 40123 at drivers/net/wirel=
ess/intel/iwlwifi/iwl-trans.c:755 iwl_trans_wait_tx_queues_empty+0x44/0x50
Jul 23 23:29:53 duo kernel: Modules linked in:
Jul 23 23:29:53 duo kernel: CPU: 2 UID: 0 PID: 40123 Comm: kworker/2:0 Tain=
ted: G S      W           6.16.0-rc7+ #303 PREEMPT(voluntary)=20
Jul 23 23:29:53 duo kernel: Tainted: [S]=3DCPU_OUT_OF_SPEC, [W]=3DWARN
Jul 23 23:29:53 duo kernel: Hardware name: LENOVO 4291W3B/4291W3B, BIOS 8DE=
T73WW (1.43 ) 10/12/2016
Jul 23 23:29:53 duo kernel: Workqueue: events iwl_trans_reprobe_wk
Jul 23 23:29:53 duo kernel: RIP: 0010:iwl_trans_wait_tx_queues_empty+0x44/0=
x50
Jul 23 23:29:53 duo kernel: Code: cc cc cc 80 3d d8 df 47 01 00 b8 fb ff ff=
 ff 75 ec 44 89 c6 48 c7 c7 27 a0 d8 85 89 45 fc c6 05 bd df 47 01 01 e8 8c=
 79 52 ff <0f> 0b 8b 45 fc c9 c3 cc cc cc cc 90 90 90 90 90 90 90 90 90 90 =
90
Jul 23 23:29:53 duo kernel: RSP: 0018:ffffc9000b2bf7f8 EFLAGS: 00010282
Jul 23 23:29:53 duo kernel: RAX: 0000000000000000 RBX: ffff888101f63060 RCX=
: 0000000000000000
Jul 23 23:29:53 duo kernel: RDX: 0000000000000002 RSI: 0000000000000027 RDI=
: 00000000ffffffff
Jul 23 23:29:53 duo kernel: RBP: ffffc9000b2bf800 R08: ffffffff8613bc08 R09=
: 00000000ffffdfff
Jul 23 23:29:53 duo kernel: R10: 0000000000000aa3 R11: ffffffff8610bc20 R12=
: 00000000000ffdef
Jul 23 23:29:53 duo kernel: R13: 0000000000000000 R14: ffff888101f60e00 R15=
: ffff888101f630d8
Jul 23 23:29:53 duo kernel: FS:  0000000000000000(0000) GS:ffff88828ffff000=
(0000) knlGS:0000000000000000
Jul 23 23:29:53 duo kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800500=
33
Jul 23 23:29:53 duo kernel: CR2: 000055f98d7e8cb0 CR3: 000000010911e004 CR4=
: 00000000000606b0
Jul 23 23:29:53 duo kernel: Call Trace:
Jul 23 23:29:53 duo kernel:  <TASK>
Jul 23 23:29:53 duo kernel:  iwlagn_mac_flush+0x90/0xb0
Jul 23 23:29:53 duo kernel:  __ieee80211_flush_queues+0x1aa/0x200
Jul 23 23:29:53 duo kernel:  ieee80211_flush_queues+0xe/0x20
Jul 23 23:29:53 duo kernel:  ieee80211_set_disassoc+0x6c4/0x940
Jul 23 23:29:53 duo kernel:  ieee80211_mgd_deauth+0x120/0x5b0
Jul 23 23:29:53 duo kernel:  ieee80211_deauth+0x13/0x20
Jul 23 23:29:53 duo kernel:  cfg80211_mlme_deauth+0xac/0x140
Jul 23 23:29:53 duo kernel:  cfg80211_mlme_down+0x96/0xc0
Jul 23 23:29:53 duo kernel:  cfg80211_disconnect+0x152/0x170
Jul 23 23:29:53 duo kernel:  cfg80211_leave+0x180/0x1b0
Jul 23 23:29:53 duo kernel:  cfg80211_netdev_notifier_call+0xed/0x3e0
Jul 23 23:29:53 duo kernel:  raw_notifier_call_chain+0x44/0x60
Jul 23 23:29:53 duo kernel:  call_netdevice_notifiers_info+0x40/0x80
Jul 23 23:29:53 duo kernel:  __dev_close_many+0x5a/0x200
Jul 23 23:29:53 duo kernel:  dev_close_many+0xa4/0x180
Jul 23 23:29:53 duo kernel:  netif_close+0x8c/0xc0
Jul 23 23:29:53 duo kernel:  dev_close+0x27/0x70
Jul 23 23:29:53 duo kernel:  cfg80211_shutdown_all_interfaces+0x4b/0xf0
Jul 23 23:29:53 duo kernel:  ieee80211_remove_interfaces+0x44/0x220
Jul 23 23:29:53 duo kernel:  ieee80211_unregister_hw+0x39/0x140
Jul 23 23:29:53 duo kernel:  iwlagn_mac_unregister+0x27/0x40
Jul 23 23:29:53 duo kernel:  iwl_op_mode_dvm_stop+0x16/0xb0
Jul 23 23:29:53 duo kernel:  _iwl_op_mode_stop+0x35/0x70
Jul 23 23:29:53 duo kernel:  iwl_drv_stop+0x2b/0xa0
Jul 23 23:29:53 duo kernel:  iwl_pci_remove+0x29/0x40
Jul 23 23:29:53 duo kernel:  pci_device_remove+0x3c/0xa0
Jul 23 23:29:53 duo kernel:  device_remove+0x41/0x70
Jul 23 23:29:53 duo kernel:  device_release_driver_internal+0x1a6/0x210
Jul 23 23:29:53 duo kernel:  device_driver_detach+0xf/0x20
Jul 23 23:29:53 duo kernel:  device_reprobe+0x18/0x90
Jul 23 23:29:53 duo kernel:  iwl_trans_reprobe_wk+0x17/0x50
Jul 23 23:29:53 duo kernel:  process_one_work+0x3fb/0x500
Jul 23 23:29:53 duo kernel:  ? process_one_work+0x3bf/0x500
Jul 23 23:29:53 duo kernel:  ? process_one_work+0x3bf/0x500
Jul 23 23:29:53 duo kernel:  ? process_one_work+0x3bf/0x500
Jul 23 23:29:53 duo kernel:  worker_thread+0x189/0x340
Jul 23 23:29:53 duo kernel:  ? __pfx_worker_thread+0x10/0x10
Jul 23 23:29:53 duo kernel:  kthread+0x104/0x260
Jul 23 23:29:53 duo kernel:  ? __pfx_kthread+0x10/0x10
Jul 23 23:29:53 duo kernel:  ret_from_fork+0x7d/0xe0
Jul 23 23:29:53 duo kernel:  ? __pfx_kthread+0x10/0x10
Jul 23 23:29:53 duo kernel:  ret_from_fork_asm+0x1a/0x30
Jul 23 23:29:53 duo kernel:  </TASK>
Jul 23 23:29:53 duo kernel: ---[ end trace 0000000000000000 ]---
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: Command REPLY_ADD_STA fai=
led: FW Error
Jul 23 23:29:53 duo kernel: wlp3s0: HW problem - can not stop rx aggregatio=
n for c8:3a:35:f0:ad:f1 tid 0
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: Command REPLY_ADD_STA fai=
led: FW Error
Jul 23 23:29:53 duo kernel: wlp3s0: failed to remove key (0, c8:3a:35:f0:ad=
:f1) from hardware (-5)
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: Command REPLY_QOS_PARAM f=
ailed: FW Error
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: Failed to update QoS
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: Command REPLY_RXON failed=
: FW Error
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: Error clearing ASSOC_MSK =
on BSS (-5)
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: Command REPLY_RXON failed=
: FW Error
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: Error clearing ASSOC_MSK =
on BSS (-5)
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: Command REPLY_RXON failed=
: FW Error
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: Error clearing ASSOC_MSK =
on BSS (-5)
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: Command REPLY_RXON failed=
: FW Error
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: Error clearing ASSOC_MSK =
on BSS (-5)
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: Command REPLY_ADD_STA fai=
led: FW Error
Jul 23 23:29:53 duo kernel: wlp3s0: failed to remove key (1, ff:ff:ff:ff:ff=
:ff) from hardware (-5)
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: Command REPLY_RXON failed=
: FW Error
Jul 23 23:29:53 duo kernel: iwlwifi 0000:03:00.0: Error clearing ASSOC_MSK =
on BSS (-5)
Jul 23 23:29:53 duo avahi-daemon[2850]: Interface wlp3s0.IPv4 no longer rel=
evant for mDNS.
Jul 23 23:29:53 duo avahi-daemon[2850]: Leaving mDNS multicast group on int=
erface wlp3s0.IPv4 with address 192.168.1.110.
Jul 23 23:29:53 duo avahi-daemon[2850]: Withdrawing address record for 192.=
168.1.110 on wlp3s0.
Jul 23 23:29:53 duo NetworkManager[2853]: <info>  [1753306193.6437] device =
(wlp3s0): state change: activated -> unmanaged (reason 'removed', sys-iface=
-state: 'removed')
Jul 23 23:29:53 duo NetworkManager[2853]: <info>  [1753306193.6710] dhcp4 (=
wlp3s0): canceled DHCP transaction
Jul 23 23:29:53 duo NetworkManager[2853]: <info>  [1753306193.6711] dhcp4 (=
wlp3s0): state changed unknown -> terminated
Jul 23 23:29:53 duo systemd[1]: Starting Load/Save RF Kill Switch Status...
Jul 23 23:29:53 duo kernel: ------------[ cut here ]------------
Jul 23 23:29:53 duo kernel: WARNING: CPU: 2 PID: 40123 at mm/slab_common.c:=
1002 __ksize+0xe9/0x110
Jul 23 23:29:53 duo kernel: Modules linked in:
Jul 23 23:29:53 duo kernel: CPU: 2 UID: 0 PID: 40123 Comm: kworker/2:0 Tain=
ted: G S      W           6.16.0-rc7+ #303 PREEMPT(voluntary)=20
Jul 23 23:29:53 duo kernel: Tainted: [S]=3DCPU_OUT_OF_SPEC, [W]=3DWARN
Jul 23 23:29:53 duo kernel: Hardware name: LENOVO 4291W3B/4291W3B, BIOS 8DE=
T73WW (1.43 ) 10/12/2016
Jul 23 23:29:53 duo kernel: Workqueue: events iwl_trans_reprobe_wk
Jul 23 23:29:53 duo kernel: RIP: 0010:__ksize+0xe9/0x110
Jul 23 23:29:53 duo kernel: Code: 29 48 89 d9 48 29 d1 48 c1 f9 06 48 89 ca=
 48 c1 e2 0c 48 03 15 a8 5c a6 01 48 39 d6 75 12 48 8b 13 83 e2 40 48 0f 44=
 c7 eb 8e <0f> 0b 31 c0 eb 88 0f 0b 31 c0 eb 82 48 8b 05 34 5a c9 01 e9 2d =
ff
Jul 23 23:29:53 duo kernel: RSP: 0018:ffffc9000b2bfc88 EFLAGS: 00010246
Jul 23 23:29:53 duo kernel: RAX: 8000000000000000 RBX: ffffea000777f640 RCX=
: ffffffffffffffff
Jul 23 23:29:53 duo kernel: RDX: ffffea0000000000 RSI: ffff8881ddfd9c80 RDI=
: ffff8881ddfd9c80
Jul 23 23:29:53 duo kernel: RBP: ffffc9000b2bfc90 R08: 0000000000000000 R09=
: 000000000020000a
Jul 23 23:29:53 duo kernel: R10: 00000000000000db R11: ffff88813dd989b8 R12=
: ffff8881ddfd9c80
Jul 23 23:29:53 duo kernel: R13: 0000000000000000 R14: 0000000000000d70 R15=
: 0000000000000057
Jul 23 23:29:53 duo kernel: FS:  0000000000000000(0000) GS:ffff88828ffff000=
(0000) knlGS:0000000000000000
Jul 23 23:29:53 duo kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800500=
33
Jul 23 23:29:53 duo kernel: CR2: 00000ac403a953c8 CR3: 0000000129dce002 CR4=
: 00000000000606b0
Jul 23 23:29:53 duo kernel: Call Trace:
Jul 23 23:29:53 duo kernel:  <TASK>
Jul 23 23:29:53 duo kernel:  kfree_sensitive+0x14/0x50
Jul 23 23:29:53 duo kernel:  iwl_pcie_tx_free+0x16b/0x260
Jul 23 23:29:53 duo kernel:  iwl_trans_pcie_free+0x201/0x230
Jul 23 23:29:53 duo kernel:  iwl_pci_remove+0x31/0x40
Jul 23 23:29:53 duo kernel:  pci_device_remove+0x3c/0xa0
Jul 23 23:29:53 duo kernel:  device_remove+0x41/0x70
Jul 23 23:29:53 duo kernel:  device_release_driver_internal+0x1a6/0x210
Jul 23 23:29:53 duo kernel:  device_driver_detach+0xf/0x20
Jul 23 23:29:53 duo kernel:  device_reprobe+0x18/0x90
Jul 23 23:29:53 duo kernel:  iwl_trans_reprobe_wk+0x17/0x50
Jul 23 23:29:53 duo kernel:  process_one_work+0x3fb/0x500
Jul 23 23:29:53 duo kernel:  ? process_one_work+0x3bf/0x500
Jul 23 23:29:53 duo kernel:  ? process_one_work+0x3bf/0x500
Jul 23 23:29:53 duo kernel:  ? process_one_work+0x3bf/0x500
Jul 23 23:29:53 duo kernel:  worker_thread+0x189/0x340
Jul 23 23:29:53 duo kernel:  ? __pfx_worker_thread+0x10/0x10
Jul 23 23:29:53 duo kernel:  kthread+0x104/0x260
Jul 23 23:29:53 duo kernel:  ? __pfx_kthread+0x10/0x10
Jul 23 23:29:53 duo kernel:  ret_from_fork+0x7d/0xe0
Jul 23 23:29:53 duo kernel:  ? __pfx_kthread+0x10/0x10
Jul 23 23:29:53 duo kernel:  ret_from_fork_asm+0x1a/0x30
Jul 23 23:29:53 duo kernel:  </TASK>
Jul 23 23:29:53 duo kernel: ---[ end trace 0000000000000000 ]---
Jul 23 23:29:53 duo kernel: ------------[ cut here ]------------
Jul 23 23:29:53 duo kernel: WARNING: CPU: 2 PID: 40123 at mm/slub.c:4753 fr=
ee_large_kmalloc+0xb5/0xd0
Jul 23 23:29:53 duo kernel: Modules linked in:
Jul 23 23:29:53 duo kernel: CPU: 2 UID: 0 PID: 40123 Comm: kworker/2:0 Tain=
ted: G S      W           6.16.0-rc7+ #303 PREEMPT(voluntary)=20
Jul 23 23:29:53 duo kernel: Tainted: [S]=3DCPU_OUT_OF_SPEC, [W]=3DWARN
Jul 23 23:29:53 duo kernel: Hardware name: LENOVO 4291W3B/4291W3B, BIOS 8DE=
T73WW (1.43 ) 10/12/2016
Jul 23 23:29:53 duo kernel: Workqueue: events iwl_trans_reprobe_wk
Jul 23 23:29:53 duo kernel: RIP: 0010:free_large_kmalloc+0xb5/0xd0
Jul 23 23:29:53 duo kernel: Code: ca 85 48 89 55 f0 c6 05 51 30 dd 01 01 e8=
 83 51 f0 ff 48 8b 55 f0 eb 96 4c 89 e7 e8 95 3a fa ff 4c 8b 65 f8 c9 c3 cc=
 cc cc cc <0f> 0b 48 c7 c6 08 7f ca 85 4c 89 e7 e8 6a 6f fc ff 4c 8b 65 f8 =
c9
Jul 23 23:29:53 duo kernel: RSP: 0018:ffffc9000b2bfc30 EFLAGS: 00010297
Jul 23 23:29:53 duo kernel: RAX: 00000000000000f2 RBX: ffff8881ddfd9c80 RCX=
: ffffffffffffffff
Jul 23 23:29:53 duo kernel: RDX: 0000000000000000 RSI: ffff8881ddfd9c80 RDI=
: ffffea000777f640
Jul 23 23:29:53 duo kernel: RBP: ffffc9000b2bfc40 R08: 0000000000000000 R09=
: 000000000020000a
Jul 23 23:29:53 duo kernel: R10: 00000000000000db R11: ffff88813dd989b8 R12=
: ffffea000777f640
Jul 23 23:29:53 duo kernel: R13: 0000000000000000 R14: 0000000000000d70 R15=
: 0000000000000057
Jul 23 23:29:53 duo kernel: FS:  0000000000000000(0000) GS:ffff88828ffff000=
(0000) knlGS:0000000000000000
Jul 23 23:29:53 duo kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800500=
33
Jul 23 23:29:53 duo kernel: CR2: 00000ac403a953c8 CR3: 0000000129dce002 CR4=
: 00000000000606b0
Jul 23 23:29:53 duo kernel: Call Trace:
Jul 23 23:29:53 duo kernel:  <TASK>
Jul 23 23:29:53 duo kernel:  kfree+0xef/0x210
Jul 23 23:29:53 duo kernel:  ? __ksize+0xeb/0x110
Jul 23 23:29:53 duo kernel:  kfree_sensitive+0x21/0x50
Jul 23 23:29:53 duo kernel:  iwl_pcie_tx_free+0x16b/0x260
Jul 23 23:29:53 duo kernel:  iwl_trans_pcie_free+0x201/0x230
Jul 23 23:29:53 duo kernel:  iwl_pci_remove+0x31/0x40
Jul 23 23:29:53 duo kernel:  pci_device_remove+0x3c/0xa0
Jul 23 23:29:53 duo kernel:  device_remove+0x41/0x70
Jul 23 23:29:53 duo kernel:  device_release_driver_internal+0x1a6/0x210
Jul 23 23:29:53 duo kernel:  device_driver_detach+0xf/0x20
Jul 23 23:29:53 duo kernel:  device_reprobe+0x18/0x90
Jul 23 23:29:53 duo kernel:  iwl_trans_reprobe_wk+0x17/0x50
Jul 23 23:29:53 duo kernel:  process_one_work+0x3fb/0x500
Jul 23 23:29:53 duo kernel:  ? process_one_work+0x3bf/0x500
Jul 23 23:29:53 duo kernel:  ? process_one_work+0x3bf/0x500
Jul 23 23:29:53 duo kernel:  ? process_one_work+0x3bf/0x500
Jul 23 23:29:53 duo kernel:  worker_thread+0x189/0x340
Jul 23 23:29:53 duo kernel:  ? __pfx_worker_thread+0x10/0x10
Jul 23 23:29:53 duo kernel:  kthread+0x104/0x260
Jul 23 23:29:53 duo kernel:  ? __pfx_kthread+0x10/0x10
Jul 23 23:29:53 duo kernel:  ret_from_fork+0x7d/0xe0
Jul 23 23:29:53 duo kernel:  ? __pfx_kthread+0x10/0x10
Jul 23 23:29:53 duo kernel:  ret_from_fork_asm+0x1a/0x30
Jul 23 23:29:53 duo kernel:  </TASK>
Jul 23 23:29:53 duo kernel: ---[ end trace 0000000000000000 ]---
Jul 23 23:29:53 duo kernel: page: refcount:1 mapcount:0 mapping:00000000000=
00000 index:0xffff8881ddfd9d00 pfn:0x1ddfd9
Jul 23 23:29:53 duo kernel: flags: 0x8000000000000000(zone=3D2)
Jul 23 23:29:53 duo kernel: page_type: f2(table)
Jul 23 23:29:53 duo kernel: raw: 8000000000000000 0000000000000000 dead0000=
00000122 0000000000000000
Jul 23 23:29:53 duo kernel: raw: ffff8881ddfd9d00 ffff88801f09d680 00000001=
f2000000 0000000000000000
Jul 23 23:29:53 duo kernel: page dumped because: Not a kmalloc allocation
Jul 23 23:29:53 duo kernel: BUG: kernel NULL pointer dereference, address: =
0000000000000000
Jul 23 23:29:53 duo kernel: #PF: supervisor instruction fetch in kernel mode
Jul 23 23:29:53 duo kernel: #PF: error_code(0x0010) - not-present page
Jul 23 23:29:53 duo kernel: PGD 0 P4D 0=20
Jul 23 23:29:53 duo kernel: Oops: Oops: 0010 [#1] SMP PTI
Jul 23 23:29:53 duo kernel: CPU: 3 UID: 0 PID: 3093 Comm: Xorg Tainted: G S=
      W           6.16.0-rc7+ #303 PREEMPT(voluntary)=20
Jul 23 23:29:53 duo kernel: Tainted: [S]=3DCPU_OUT_OF_SPEC, [W]=3DWARN
Jul 23 23:29:53 duo kernel: Hardware name: LENOVO 4291W3B/4291W3B, BIOS 8DE=
T73WW (1.43 ) 10/12/2016
Jul 23 23:29:53 duo dbus-daemon[3483]: [session uid=3D1000 pid=3D3483] Acti=
vating service name=3D'org.freedesktop.Notifications' requested by ':1.45' =
(uid=3D1000 pid=3D3746 comm=3D"nm-applet ")


--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, and Musk!

--Vr3qKgMlQB7egiaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaIFXRgAKCRAw5/Bqldv6
8nEdAJ9amSihiZub1tVI+aKemPyZ5Se7BgCfd08U/H35rEd07Y/nQSmMzCsa1kE=
=8DZG
-----END PGP SIGNATURE-----

--Vr3qKgMlQB7egiaB--

