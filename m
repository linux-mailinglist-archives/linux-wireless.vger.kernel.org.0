Return-Path: <linux-wireless+bounces-26001-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E449DB1115F
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 21:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFF463BEC02
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 19:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03B02E8E04;
	Thu, 24 Jul 2025 19:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="cuxqbDbr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA26A214811;
	Thu, 24 Jul 2025 19:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753384068; cv=none; b=uD7A8xgw9JKZW2LhpgkDOcwFdfoevbiB7SAIK4N9QShrZjzPAzYT0JuaR3SmCLgirjvf/ghlTi3AiAZP1B+53wYwTXPsr/FEsERlIbqD6Rf6XW+ZTSsB96rDob0c5emIh1y00YCIiy33vdoBbN/mMVdF3729V3g6aWFpKXhuFXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753384068; c=relaxed/simple;
	bh=qLfaa3hxQTMz4xHWXRnTRJozjDzvZwUWyIagWJWie3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fy7H8o+BkQKrT+2eD/1VsfZkDG3Mh+s+rkQYGDmNN5ZqParrLuxVhdyupfr5moDZ7EbGCMi6LvuADyekU8s0TyYVuBAcz/BxKMb5FzIJi1Op/VyRtAQ6q3hVlgGsxs5Ovz1lskYQuWT0yVrcjXu3X2ZT9N+u+S441uJ4gX3YvcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=cuxqbDbr; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 3DA221C00BE; Thu, 24 Jul 2025 21:07:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1753384062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+CPG32qUX+a082lgMgh6iMG3im+HRm31/xEC/kpxkpc=;
	b=cuxqbDbrA4UrXs90M6itKa4muVjephT+K38WNBs/mbY2Br6VEfcH1eSZgcdpE7SpHN8BNa
	tyCLE+/A9rY6T/zvlRQaW6PM8ywqn2pWv76HAqjShWqlWUlDXWbhM8VcV7myOtOgS/hNFO
	vZ70JzlX8bdb1bnDkSQjr2WSO/FnqU8=
Date: Thu, 24 Jul 2025 21:07:40 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Waiman Long <llong@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	kernel list <linux-kernel@vger.kernel.org>, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, peterz@infradead.org, will@kernel.org,
	miriam.rachel.korenblit@intel.com, linux-wireless@vger.kernel.org,
	Petr Mladek <pmladek@suse.com>, John Ogness <jogness@linutronix.de>
Subject: Re: locking problems in iwlwifi? was Re: 6.16-rcX: crashing way too
 often on thinkpad X220
Message-ID: <aIKEfIjYBPzlE7y7@duo.ucw.cz>
References: <aH/L1PCwtwe8Y1+a@duo.ucw.cz>
 <aID6XPLXuGo+ViTm@duo.ucw.cz>
 <aIEC4t2EICdgomZV@duo.ucw.cz>
 <874iv2stk3.ffs@tglx>
 <87zfcurexx.ffs@tglx>
 <aIJqC/0ZPhgaNdkf@duo.ucw.cz>
 <71548e22-9f3c-469e-a59d-f921da59d927@redhat.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qqk5rXPqhnND/4Sy"
Content-Disposition: inline
In-Reply-To: <71548e22-9f3c-469e-a59d-f921da59d927@redhat.com>


--Qqk5rXPqhnND/4Sy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > Can you please decode this, so we can see which part of that code i=
t is?
> > > And enable lockdep so that we can see where the interrupts were enabl=
ed?
> > Enabled lockdep and got this one. It seems resume with bad wifi signal
> > does it on 6.16...?
> >=20
> > Is it any good? Any decoding needed?
> >=20
> > ...
> > [   32.361445] CPU2 is up
> > [   32.361729] smpboot: Booting Node 0 Processor 3 APIC 0x3
> > [   32.361982] Disabled fast string operations
> > [   32.366800] CPU3 is up
> > [   32.370186] ACPI: PM: Waking up from system sleep state S3
> > [   32.393904] ACPI: EC: interrupt unblocked
> > [   32.396000] sdhci-pci 0000:0d:00.0: MMC controller base frequency ch=
anged to 50Mhz.
> > [   32.409738] ACPI: EC: event unblocked
> > [   32.470808] iwlwifi 0000:03:00.0: Radio type=3D0x1-0x2-0x0
> > [   32.687300] usb 2-1.4: reset full-speed USB device number 4 using eh=
ci-pci
> > [   32.758329] ata2: SATA link down (SStatus 0 SControl 300)
> > [   32.758375] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> > [   32.762316] ata5: SATA link down (SStatus 0 SControl 300)
> > [   32.764585] ata3.00: ACPI cmd f5/00:00:00:00:00:a0(SECURITY FREEZE L=
OCK) filtered out
> > [   32.764593] ata3.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) fil=
tered out
> > [   32.771931] sd 2:0:0:0: [sdb] Starting disk
> > [   32.777439] ata3.00: ACPI cmd f5/00:00:00:00:00:a0(SECURITY FREEZE L=
OCK) filtered out
> > [   32.777450] ata3.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) fil=
tered out
> > [   32.782731] ata3.00: configured for UDMA/133
> > [   32.786846] iwlwifi 0000:03:00.0: Radio type=3D0x1-0x2-0x0
> > [   32.858513] usb 2-1.3: reset full-speed USB device number 3 using eh=
ci-pci
> > [   33.026331] usb 2-1.6: reset high-speed USB device number 5 using eh=
ci-pci
> > [   33.662583] psmouse serio1: synaptics: queried max coordinates: x [.=
=2E5472], y [..4448]
> > [   33.810033] PM: resume devices took 1.404 seconds
> > [   33.841597] OOM killer enabled.
> > [   33.841808] ACPI: \_SB_.PCI0.LPC_.EC__.BAT1: docking
> > [   33.843280] Restarting tasks: Starting
> > [   33.849066] ACPI: \_SB_.PCI0.LPC_.EC__.BAT1: Unable to dock!
> > [   33.852744] Restarting tasks: Done
> > [   33.888306] PM: suspend exit
> > [   33.941831] Bluetooth: hci0: BCM: chip id 63
> > [   33.944910] Bluetooth: hci0: BCM: features 0x07
> > [   33.961985] Bluetooth: hci0: BCM20702A
> > [   33.962628] Bluetooth: hci0: BCM20702A1 (001.002.014) build 0000
> > [   33.970094] Bluetooth: hci0: BCM: firmware Patch file not found, tri=
ed:
> > [   33.970993] Bluetooth: hci0: BCM: 'brcm/BCM20702A1-0a5c-21e6.hcd'
> > [   33.971410] Bluetooth: hci0: BCM: 'brcm/BCM-0a5c-21e6.hcd'
> > [   34.032198] Bluetooth: MGMT ver 1.23
> > [   34.838285] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> > [   35.166235] ata1.00: ACPI cmd f5/00:00:00:00:00:a0(SECURITY FREEZE L=
OCK) filtered out
> > [   35.167828] ata1.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) fil=
tered out
> > [   35.206578] sd 0:0:0:0: [sda] Starting disk
> > [   35.238578] ata1.00: ACPI cmd f5/00:00:00:00:00:a0(SECURITY FREEZE L=
OCK) filtered out
> > [   35.240197] ata1.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) fil=
tered out
> > [   35.278928] ata1.00: configured for UDMA/133
> > [   35.613471] e1000e 0000:00:19.0 enp0s25: NIC Link is Down
> > [   54.283825] wlp3s0: authenticate with c8:3a:35:f0:ad:f1 (local addre=
ss=3Da0:88:b4:62:a7:30)
> >=20
> > [   54.284095] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [   54.284097] WARNING: inconsistent lock state
> > [   54.284100] 6.16.0-rc7+ #305 Tainted: G S
> > [   54.284104] --------------------------------
> > [   54.284105] inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
> > [   54.284108] wpa_supplicant/2940 [HC0[0]:SC0[0]:HE0:SE1] takes:
> > [   54.284114] ffffffff86263fe0 (console_owner){+.?.}-{0:0}, at: consol=
e_lock_spinning_enable+0x3d/0x60
>=20
> The lockdep warning just means that console_owner_lock is acquired both in
> softirq context and in task context with interrupt enabled. That can leads
> to deadlock. So the remedy is to always take console_owner_lock with
> interrupt disabled, i.e. with
> raw_spin_lock_irqsave/raw_spin_lock_irqrestore.

So you suspect problem is in the printk code?

Best regards,
								Pavel
--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, and Musk!

--Qqk5rXPqhnND/4Sy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaIKEfAAKCRAw5/Bqldv6
8itcAKCQ3QrGVmwnbJ5wGuP3VvjxNCcAYgCgsCe1crHDec+kJBqddlStxW970SQ=
=5Pdn
-----END PGP SIGNATURE-----

--Qqk5rXPqhnND/4Sy--

