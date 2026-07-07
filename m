Return-Path: <linux-wireless+bounces-38715-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tnbyCjxGTGpxigEAu9opvQ
	(envelope-from <linux-wireless+bounces-38715-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 02:20:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E78071676D
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 02:20:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=msbs.com header.s=dkimprovmx2 header.b=GEVQolyz;
	dmarc=pass (policy=none) header.from=msbs.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38715-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38715-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03F8630363FD
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2026 00:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A62C1E51E0;
	Tue,  7 Jul 2026 00:18:37 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail4.mxsw2.infra.improvmx.com (mail4.mxsw2.infra.improvmx.com [51.158.91.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBDF1A6813
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jul 2026 00:18:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783383517; cv=none; b=fIiKGmdpXzSIHFMb143Z+k26ybhI8CoapmXHHxlcX230D3VCqjsS/0QJRSr8AA+HUf+5fQIw7b1qLNWro8aDrWbpIm3I8civmRrvWVaC+vgv79TPGtSRSkCD0ccRjguNOGCQUrzqrPG6gfvTrxMNhPSbbrluL7/hRdY2QwS5sJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783383517; c=relaxed/simple;
	bh=PMQiM5eBVmU0LoAzw5OFyjtzlzaRKLO+l1L/lXziWpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LEETbIhJwJ6RXemu8bkw+h2OAVKkZPP9gAfli7+iOk4eq/2mH9DeCV1bbzeNNmOG5h06xtXlCZE+jtpEWfrxLVuOX/QDyla23IKNhN7YbnT6g9WfgVyW14lfWghCnvc57ZGJsxtvxWaP6QalUudiDRvPZhYSXGjXQYKFMzIBOiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=msbs.com; spf=pass smtp.mailfrom=msbs.com; dkim=pass (2048-bit key) header.d=msbs.com header.i=@msbs.com header.b=GEVQolyz; arc=none smtp.client-ip=51.158.91.226
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=msbs.com;
 i=@msbs.com; q=dns/txt; s=dkimprovmx2; t=1783383385; h=date : from :
 to : subject : content-type : feedback-id : message-id;
 bh=ey3QhB6J3gnwrfAIUZr8wNCqwKOYSyeo95dRaK+/vzk=;
 b=GEVQolyzAlGaBS2VMNAvGsWkuU5hj7GHnDV8zOjwIy407HaR2vTFcRsAFTYCyPcQ/DJKa
 kaj4qBW7Wbs+gfGdjJhk6ir1xzOdexvv0V97qWanWckAW4s5o6Lxhee+OoWGFdgci6DPr5S
 SbFO+bM+UBaaDNNdVsFRnd5SQ56My0aNmpJCzQJMbGtvAP1hL6VYPkmPyWhSn9hEc27d3d6
 etLsWxavJPegMlXU8YeIngWY1tvU/OUHXPEMqwO+Wi8AFDkvx3WhgpcgvVEQ8g1uFwiSB+5
 z1/sprr2U9eKShElv12K5/LVD72KFEwWugSr6vtf+EL40iiNqHF0roFT0k3w==
X-Sending-Service: ImprovMX v3.0.0
Feedback-ID: bXNicy5jb20=:send:ImprovMX
X-ImprovMX-Server-Id: 088d2cf
X-ImprovMX-Session-Id:
 6c00779a-0465-4a11-8afd-6391e82931cc
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com.
 [209.85.208.182])
    by mx1.improvmx.com with ESMTPSA (version=TLSv1.3
 cipher=TLS_AES_256_GCM_SHA384 bits=256/256)
    for <linux-wireless@vger.kernel.org>;
    Tue, 07 Jul 2026 00:16:23 -0000
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-39b1026e171so35446261fa.1
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jul 2026 17:16:22 -0700 (PDT)
X-Gm-Message-State: AOJu0YyfqW9VC+qnJAh1EJQZpuDWs8D8Glx0eqZpvkPxOS/PIAXzb3Kw
	YW8oeBg3detWplnEsR6Y2gEwyWgLAn7CIHQKjvXz7mXGQ/MF4TlOiECAACAEUmOigmqRcPZ5vxT
	BmbvovWTMYYAaQizwrUJNK6INisg12js=
X-Received: by 2002:a2e:9b95:0:b0:393:8ba5:3d01 with SMTP id
 38308e7fff4ca-39c5ffa4574mr4697491fa.22.1783383377035; Mon, 06 Jul 2026
 17:16:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPpkL-yLfeNwsePSGDK7m8ctzPLXTVto1HhrufHv12HO0+B1Vw@mail.gmail.com>
 <CAPpkL-y54ySw8ftqeumccNEVatY0Zt6-Ag4PejYddK5WcsiV3A@mail.gmail.com> <870f1c80-5027-4503-b6c4-6df80eea7df3@leemhuis.info>
In-Reply-To: <870f1c80-5027-4503-b6c4-6df80eea7df3@leemhuis.info>
From: B X <brent@msbs.com>
Date: Mon, 6 Jul 2026 20:16:05 -0400
X-Gmail-Original-Message-ID: <CAPpkL-xcQJu2Y_7h_moAJ1XEMimQVByz6+_cZCmAj6RqZr0cGQ@mail.gmail.com>
X-Gm-Features: AVVi8CfAhBrZ2u3uERpszP9KdYBi5EX9GEnu78omY7Lc_zd7GvlznoDbleUyEoc
Message-ID: <CAPpkL-xcQJu2Y_7h_moAJ1XEMimQVByz6+_cZCmAj6RqZr0cGQ@mail.gmail.com>
Subject: Re: [REGRESSION] mt7925e: fails to read EEPROM MAC on 7.2-rc2, falls
 back to random MAC (worked on 7.1-rc7 and 7.0.x)
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: linux-wireless@vger.kernel.org, nbd@nbd.name, lorenzo@kernel.org, 
	ryder.lee@mediatek.com, shayne.chen@mediatek.com, sean.wang@mediatek.com, 
	regressions@lists.linux.dev, Rosen Penev <rosenp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[msbs.com,none];
	R_DKIM_ALLOW(-0.20)[msbs.com:s=dkimprovmx2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,nbd.name,kernel.org,mediatek.com,lists.linux.dev,gmail.com];
	TAGGED_FROM(0.00)[bounces-38715-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:regressions@leemhuis.info,m:linux-wireless@vger.kernel.org,m:nbd@nbd.name,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:regressions@lists.linux.dev,m:rosenp@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[msbs.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[brent@msbs.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brent@msbs.com,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,msbs.com:from_mime,msbs.com:email,msbs.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E78071676D

Confirmed -- the patch fixes it.

I applied 20260630210215.400379-1-rosenp@gmail.com on top of 7.2-rc2 and
booted it on my x86 Strix Halo (MT7925 RZ717, non-OF PCIe card). With the
patch, the "Invalid MAC address, using random address" line is gone and the
adapter comes up with its real EEPROM MAC (ac:f2:3c:35:31:15). Stock 7.2-rc=
2
without the patch reproduces the random-MAC behaviour on the same hardware.

Tested-by: Brent Paine <bkpaine1@gmail.com>

Brent

On Mon, Jul 6, 2026 at 10:21=E2=80=AFAM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
>
>
> On 7/6/26 15:35, B X wrote:
> > B X <brent@msbs.com>
> > 8:12=E2=80=AFAM (1 hour ago)
> > to linux-wireless, nbd, lorenzo, ryder.lee, shayne.chen, sean.wang,
> > regressions, Brent
> >
> > Hi,
> >
> > Reporting a regression in the mt7925e driver: on Linux 7.2.0-rc2 the ad=
apter
> > fails to read its stored (EEPROM/efuse) MAC address and substitutes a r=
andom
> > one. The same hardware read its real MAC correctly on every earlier ker=
nel,
> > including the immediately-preceding boot one day earlier on 7.0.0-22.
>
> Sounds a lot like it's the problem "wifi: mt76: fix MAC address for non
> OF pcie cards" aims to fix:
> https://lore.kernel.org/all/20260630210215.400379-1-rosenp@gmail.com/
>
> Would be great if you could confirm.
>
> Ciao, Thorsten
>
> > Verified with Claude Code when my ATT fiber kept failing to pin IP on
> > my Halo Strix
> >
> > Hardware
> > --------
> > MediaTek MT7925 (RZ717) Wi-Fi 7 160MHz
> > PCI ID: [14c3:0717], driver mt7925e
> > Platform: AMD "Strix Halo" (Ryzen AI Max) mini-PC
> > linux-firmware: 20260319.git217ca6e4
> >
> > Symptom (kernel 7.2.0-rc2, 2026-07-06)
> > --------------------------------------
> >   mt7925e 0000:c3:00.0: enabling device (0000 -> 0002)
> >   mt7925e 0000:c3:00.0: ASIC revision: 79250000
> >   mt7925e 0000:c3:00.0: HW/SW Version: 0x8a108a10, Build Time: 20260106=
153007a
> >   mt7925e 0000:c3:00.0: WM Firmware Version: ____000000, Build Time:
> > 20260106153120
> >   mt7925e 0000:c3:00.0: Invalid MAC address, using random address
> > 12:1f:34:c6:57:04
> >   mt7925e 0000:c3:00.0 wlp195s0: renamed from wlan0
> >
> > The driver then brings the interface up with the random MAC 12:1f:34:c6=
:57:04.
> >
> > Last known good (kernel 7.0.0-22, 2026-07-05, same machine, no MAC over=
ride)
> > -----------------------------------------------------------------------=
-----
> >   mt7925e 0000:c3:00.0: ASIC revision: 79250000
> >   mt7925e 0000:c3:00.0: HW/SW Version: 0x8a108a10, Build Time: 20260106=
153007a
> >   mt7925e 0000:c3:00.0: WM Firmware Version: ____000000, Build Time:
> > 20260106153120
> >   ...
> >   wlp195s0: authenticate with <ap> (local address=3Dac:f2:3c:35:31:15)
> >
> > i.e. the real MAC ac:f2:3c:35:31:15 was read straight off the adapter. =
Note
> > the firmware init lines (ASIC revision, HW/SW Version, WM Firmware Vers=
ion,
> > build times) are byte-identical between the good and bad boots -- only =
the
> > kernel differs, and only the MAC read fails. This rules out a firmware =
or
> > bad-NVRAM cause: the same silicon read the MAC correctly ~24h earlier.
> >
> > Regression range
> > ----------------
> > Confirmed good on: 7.0.0, 7.0.0-22, 7.0.0-27, 7.1.0-rc7 (dozens of boot=
s,
> > journal-verified, no "Invalid MAC address" line on any of them).
> > First and only bad boot: 7.2.0-rc2.
> >
> > So the regression landed between 7.1-rc7 and 7.2-rc2. I have not bisect=
ed to
> > the exact commit yet, but I can -- the machine builds kernels quickly -=
- if a
> > bisect would help pin it down.
> >
> > Not reboot-type dependent: on the good kernels (7.0.0-22 / 7.0.0-27) th=
e
> > correct MAC was read reliably across both warm/clean reboots and cold/h=
ard
> > power cycles. The failure does not correlate with reboot type or chip p=
ower
> > state -- it correlates only with the kernel version (7.2-rc2).
> >
> > Impact
> > ------
> > The substituted MAC is random per boot, changing the adapter's L2 ident=
ity.
> > This breaks router-side DHCP reservations / fixed-IP allocations keyed =
on MAC:
> > the host stops receiving its pinned address and lands on an arbitrary l=
ease.
> > Any MT7925 user relying on MAC-based address pinning is affected. Curre=
nt
> > workaround here is forcing the real MAC via NetworkManager cloned-mac-a=
ddress.
> >
> > #regzbot introduced: v7.1..v7.2-rc2
> >
> >
> >
> > Thanks,
> >
> >
> > Brent Paine, AWS, CCNP
> >
> > git bkpaine1
> > Medium bkpaine1
> >
> >
> > On Mon, Jul 6, 2026 at 8:12=E2=80=AFAM B X <brent@msbs.com> wrote:
> >>
> >> Hi,
> >>
> >> Reporting a regression in the mt7925e driver: on Linux 7.2.0-rc2 the a=
dapter
> >> fails to read its stored (EEPROM/efuse) MAC address and substitutes a =
random
> >> one. The same hardware read its real MAC correctly on every earlier ke=
rnel,
> >> including the immediately-preceding boot one day earlier on 7.0.0-22.
> >>
> >> Verified with Claude Code when my ATT fiber kept failing to pin IP on =
my Halo Strix
> >>
> >> Hardware
> >> --------
> >> MediaTek MT7925 (RZ717) Wi-Fi 7 160MHz
> >> PCI ID: [14c3:0717], driver mt7925e
> >> Platform: AMD "Strix Halo" (Ryzen AI Max) mini-PC
> >> linux-firmware: 20260319.git217ca6e4
> >>
> >> Symptom (kernel 7.2.0-rc2, 2026-07-06)
> >> --------------------------------------
> >>   mt7925e 0000:c3:00.0: enabling device (0000 -> 0002)
> >>   mt7925e 0000:c3:00.0: ASIC revision: 79250000
> >>   mt7925e 0000:c3:00.0: HW/SW Version: 0x8a108a10, Build Time: 2026010=
6153007a
> >>   mt7925e 0000:c3:00.0: WM Firmware Version: ____000000, Build Time: 2=
0260106153120
> >>   mt7925e 0000:c3:00.0: Invalid MAC address, using random address 12:1=
f:34:c6:57:04
> >>   mt7925e 0000:c3:00.0 wlp195s0: renamed from wlan0
> >>
> >> The driver then brings the interface up with the random MAC 12:1f:34:c=
6:57:04.
> >>
> >> Last known good (kernel 7.0.0-22, 2026-07-05, same machine, no MAC ove=
rride)
> >> ----------------------------------------------------------------------=
------
> >>   mt7925e 0000:c3:00.0: ASIC revision: 79250000
> >>   mt7925e 0000:c3:00.0: HW/SW Version: 0x8a108a10, Build Time: 2026010=
6153007a
> >>   mt7925e 0000:c3:00.0: WM Firmware Version: ____000000, Build Time: 2=
0260106153120
> >>   ...
> >>   wlp195s0: authenticate with <ap> (local address=3Dac:f2:3c:35:31:15)
> >>
> >> i.e. the real MAC ac:f2:3c:35:31:15 was read straight off the adapter.=
 Note
> >> the firmware init lines (ASIC revision, HW/SW Version, WM Firmware Ver=
sion,
> >> build times) are byte-identical between the good and bad boots -- only=
 the
> >> kernel differs, and only the MAC read fails. This rules out a firmware=
 or
> >> bad-NVRAM cause: the same silicon read the MAC correctly ~24h earlier.
> >>
> >> Regression range
> >> ----------------
> >> Confirmed good on: 7.0.0, 7.0.0-22, 7.0.0-27, 7.1.0-rc7 (dozens of boo=
ts,
> >> journal-verified, no "Invalid MAC address" line on any of them).
> >> First and only bad boot: 7.2.0-rc2.
> >>
> >> So the regression landed between 7.1-rc7 and 7.2-rc2. I have not bisec=
ted to
> >> the exact commit yet, but I can -- the machine builds kernels quickly =
-- if a
> >> bisect would help pin it down.
> >>
> >> Not reboot-type dependent: on the good kernels (7.0.0-22 / 7.0.0-27) t=
he
> >> correct MAC was read reliably across both warm/clean reboots and cold/=
hard
> >> power cycles. The failure does not correlate with reboot type or chip =
power
> >> state -- it correlates only with the kernel version (7.2-rc2).
> >>
> >> Impact
> >> ------
> >> The substituted MAC is random per boot, changing the adapter's L2 iden=
tity.
> >> This breaks router-side DHCP reservations / fixed-IP allocations keyed=
 on MAC:
> >> the host stops receiving its pinned address and lands on an arbitrary =
lease.
> >> Any MT7925 user relying on MAC-based address pinning is affected. Curr=
ent
> >> workaround here is forcing the real MAC via NetworkManager cloned-mac-=
address.
> >>
> >> #regzbot introduced: v7.1..v7.2-rc2
> >>
> >>
> >>
> >> Thanks,
> >>
> >>
> >> Brent Paine, AWS, CCNP
> >>
> >> git bkpaine1
> >> Medium bkpaine1
>

