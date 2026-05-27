Return-Path: <linux-wireless+bounces-37042-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KhKDGnJ5F2rMGQgAu9opvQ
	(envelope-from <linux-wireless+bounces-37042-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 01:08:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 667CE5EADD4
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 01:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5EAB23008FC4
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 23:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D8F3939D2;
	Wed, 27 May 2026 23:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxUUcd8L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB8F390C8A
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 23:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779923307; cv=none; b=bl9vgyVADtZ+7ECa96WSnJW52wWgKzFLyN2nn9ju5edC91FUdh4krG8RwEv8iHfT0UN/6oS4/WAHo6tGO3jMfQci/nuZ1rLxk5QJdBeQ4YNE2v9yw5CUQwchNdRmRETvXKWWBPlP0+H9+YMgRtfySjd4QBWVnq1oVJv0IGyXUuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779923307; c=relaxed/simple;
	bh=qZ19zf46bNLLW9ZqflOu4eds+3Vn2y44DckmFC8qM6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F8QXiCOYZMEfF1LKDoi+lcvQgoix4OqIe/BSuLDC6YyR3A/p7dzEyd2FUGUYYMzoO1LtvAY4OjwO5vYFmYeZmsWB0A2ilbAXH+TOBwZ5ny08WTmQI0M5m5PAGFd3ExDzpP32P4a6suIhT1tVTing3hwsKd9rc0nyhSrz3JhTv1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxUUcd8L; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F3C1F00ADB
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 23:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779923305;
	bh=0WVyQig7ZuVGJIY/+WC97L19CBbGyFEtfGtUCmnpbbM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=KxUUcd8Lhf65q3HZzVf4uEZauOiWVruOaU1fgY6QiX/G8xDOgncAXWg7XbVeNSdSt
	 tT4hcwrARxt+b/VpYAt33U0yC7WHn8aS1n+SaOe0p1gUuuy85WO2Sp8Mw8iGFKNZvX
	 dwZzk/BCPncZCHGNT6wZUY65unalhaZhj0hRXzjwBsLZqvYq2DTsTQLxH6bqowkj91
	 LqQFGknWUB91Hj6gLmP6xO2fCdEjpH2nHH3O7R1L9BnW6kOaZlxSdiGPve19KAuXa8
	 V63t59vSGAlB0sESK0y3jtPOl61gaqZ6rktoaajRagddglX+I4+uYAU/WbxwR5genO
	 NbpeIfGq0fztg==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39389398838so104981541fa.3
        for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 16:08:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9fvbKA+TWNGasn6nN4iEjf3ds34iq9i0HpuqPcifi7tauPaLVvaEJZKan7mjs/blx1W18GFPxDaclF7mIASg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzfDvbrVqtZJ9vn45FmmETCFmlOlwiKLxvCGSNmQFLVUW2iLbu
	BlneoXsC0h9k0BJI8s2EpEkaYOjxT5lY6ARt+yYLU/RoVP3V3n36249XE0v/cDVcxw5PWgD1/e9
	pXgVBaotUM+26QUbBk5gMMtFW2bIx84M=
X-Received: by 2002:a05:651c:1595:b0:395:c810:a61e with SMTP id
 38308e7fff4ca-395d8bbc310mr92717411fa.6.1779923303504; Wed, 27 May 2026
 16:08:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN6xzWcVDRLVTV-SQcs6osZjnfhLM728NP7+W8+sFcTDmeVipw@mail.gmail.com>
In-Reply-To: <CAN6xzWcVDRLVTV-SQcs6osZjnfhLM728NP7+W8+sFcTDmeVipw@mail.gmail.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Wed, 27 May 2026 18:08:12 -0500
X-Gmail-Original-Message-ID: <CAGp9LzrmUGQLK5giHVgOjJ5pzGNnfLaV02iWdodT7aDNBbNUqg@mail.gmail.com>
X-Gm-Features: AVHnY4I4tlMigaJEVngJSC5_0I6ePShr2YjyerB-J8-6H0yep3I8zxUIWqpRafE
Message-ID: <CAGp9LzrmUGQLK5giHVgOjJ5pzGNnfLaV02iWdodT7aDNBbNUqg@mail.gmail.com>
Subject: Re: [bug report] wifi: mt76: mt7921: mt7925monitor-mode per-channel
 retune emits narrowband RF burst
To: John Henry <jshenry1963@gmail.com>
Cc: Javier Tia <floss@jetm.me>, Bradley Pizzimenti <brad.pizzimenti@gmail.com>, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, nbd@nbd.name, 
	lorenzo@kernel.org, ryder.lee@mediatek.com, shayne.chen@mediatek.com, 
	sean.wang@mediatek.com, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Deren Wu <deren.wu@mediatek.com>, 
	Nick Morrow <morrownr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37042-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[jetm.me,gmail.com,vger.kernel.org,nbd.name,kernel.org,mediatek.com,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,infradead.org:url,mail.gmail.com:mid,jetm.me:email]
X-Rspamd-Queue-Id: 667CE5EADD4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi John,

On Wed, May 27, 2026 at 7:24=E2=80=AFAM John Henry <jshenry1963@gmail.com> =
wrote:
>
> Just a kind reminder of this issue.
>
> Please advise if this is already taken up in a separate issue I am
> unaware of, but it is not directly related to the "iw set txpower
> fixed accepted but ignored" issue.
>
> On products available in the market, e.g.  the Alfa AWUS036AXML
> consumer product and the Netgear Nighthawk A9000, in Monitor Mode
> there is RF generated when scanning through channels and we get to 5
> or more channels in succession.
> This does not seem to occur at all in managed mode.
>
> This means if we scan the 2.4GHz channel list, an RF Spectrum analyzer
> will show a narrow pulse generated on each channel as we progress
> through the channels.
> This can 100% be reproduced using standard iw set channel commands as
> shown below:
> FACE=3D$(iw dev | awk '/Interface wl/ {print $2; exit}')
> iw reg set US ; sleep 1
> ip link set "$IFACE" down
> iw dev "$IFACE" set type monitor
> ip link set "$IFACE" up
>
> # This triggers narrowband bursts at channel center on each retune:
> while true; do
>   for f in 2412 2417 2422 2427 2432; do
>     iw dev "$IFACE" set freq "$f" HT20
>   done
> done
>

I have thought about this issue for a while. A possible workaround
would be to reset WFSYS / firmware after five consecutive `set
channel` operations in monitor mode, then restore the current monitor
channel context. The WFSYS reset may take hundreds of milliseconds to
complete, which is the cost we would need to pay.

> No special software required to reproduce.
> I have shown that this occurs on all MT7921 based products, along with
> MT7925 based products.
> It does not occur if the channel list is set to the same 4 over and
> over, no RF generated.
>
> There are no calibration channel commands going from the driver to the
> firmware, so I believe this is a firmware bug.
>
> Best Regards,
> John Henry
>
> On Sun, May 17, 2026 at 9:01=E2=80=AFAM John Henry <jshenry1963@gmail.com=
> wrote:
> >
> > Just a kind reminder of this issue, has anyone been able to reproduce
> > this monitor mode issue?
> > When scanning through channels, and the list of channels is > 4, there
> > is a large transmit tick/burst coming from the MT7921u and the MT7925.
> > This can easily be seen on an RF Spectrum Analyzer.
> > Confirmed on an Alfa AWUS036AXML consumer product and the Netgear
> > Nighthawk A9000.
> > This can be reproduced with simple scripts.
> >
> > Reproduction with stock iw commands (no custom code):
> >
> > IFACE=3D$(iw dev | awk '/Interface wl/ {print $2; exit}')
> > iw reg set US ; sleep 1
> > ip link set "$IFACE" down
> > iw dev "$IFACE" set type monitor
> > ip link set "$IFACE" up
> >
> > # This triggers narrowband bursts at channel center on each retune:
> > while true; do
> >   for f in 2412 2417 2422 2427 2432; do
> >     iw dev "$IFACE" set freq "$f" HT20
> >   done
> > done
> >
> > # This does NOT (only 4 frequencies):
> > while true; do
> >   for f in 2412 2422 2462 2484; do
> >     iw dev "$IFACE" set freq "$f" HT20
> >   done
> > done
> >
> > Bursts are ~800 kHz wide at the base, -30 to -50 dBm OTA at close
> > range, brief (estimated few hundred microseconds), at channel
> > frequency. tx_stats counters remain zero throughout.
> > On Mon, May 11, 2026 at 1:58=E2=80=AFPM John Henry <jshenry1963@gmail.c=
om> wrote:
> > >
> > > Bradley/Sean,
> > >
> > > Thank you all very much for the information.
> > > I tested this on mt7921u based Alfa AWUS unit and also an mt7925 base=
d
> > > Netgear Nighthawk unit.
> > > I can confirm that the RF tick issue is present on both models when i=
n
> > > Monitor Mode. I'm assuming it is in the base mt76?
> > >
> > > I attempted sudo iw dev wlxxx set txpower fixed nn where nn is the
> > > minimum value, next few values up, and then a few near the max values=
,
> > > and see no change in the signal strength of the RF Ticks when scannin=
g
> > > through 5 or more channels.
> > >
> > > Please keep this in mind when attempting to resolve the known txpower
> > > 3dBm issue if possible, or please generate a new bug report for that
> > > specifically so that I can track when it is patched, or in ??? versio=
n
> > > so that I can test here locally.
> > >
> > > Incidentally, I'd appreciate it if anyone could please attempt to
> > > repeat using the scripts I had shown in the previous posts and confir=
m
> > > it is indeed seen by others.
> > >
> > > Thank you very much for your time and assistance
> > >
> > > John Henry
> > >
> > >
> > >
> > >
> > > From: Bradley Pizzimenti <brad.pizzimenti@gmail.com>
> > > To: linux-wireless@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org, nbd@nbd.name, lorenzo@kernel.org,
> > > ryder.lee@mediatek.com, shayne.chen@mediatek.com,
> > > sean.wang@mediatek.com
> > > Subject: [bug report] wifi: mt76: mt7925: iw set txpower fixed
> > > accepted but ignored
> > > Date: Mon, 4 May 2026 15:04:35 -0700 [thread overview]
> > > Message-ID: <CACjnFagN9zeSkwEv3-CSPJDUENPcEcOLjKyQoLQ91Yjn=3Drq5ww@ma=
il.gmail.com>
> > > (raw)
> > >
> > > Hi there maintainers,
> > >
> > > `iw dev <iface> set txpower fixed N` returns success on mt7925 for an=
y
> > > N tested, but the reported txpower never changes from a stuck value o=
f
> > > 3.00 dBm. The kernel accepts and ignores the call silently in both
> > > directions (above and below the displayed value), and well below the
> > > regulatory ceiling.
> > >
> > > I'm aware there's prior art on the cosmetic 3.00 dBm display issue
> > > (Razvan Grigore's v2 series, Feb 2025; Ming Yen Hsieh's txpower init
> > > refactor, Sept 2025). What seems potentially distinct here is that th=
e
> > > user-issued `iw set txpower fixed N` itself is silently no-op'd,
> > > separate from the reported-value question. Reporting as breadcrumbs
> > > in case the second observation is a separate bug rather than the same
> > > one.
> > >
> > > Hardware
> > > --------
> > > MEDIATEK MT7925 [Filogic 360], 802.11be 2x2, PCI 14c3:7925
> > > ASIC revision 0x79250000
> > > Driver in use: mt7925e (in-tree)
> > >
> > > Firmware (from dmesg at probe)
> > > ------------------------------
> > > mt7925e 0000:01:00.0: HW/SW Version: 0x8a108a10,
> > >                      Build Time: 20260106153007a
> > > mt7925e 0000:01:00.0: WM Firmware Version: ____000000,
> > >                      Build Time: 20260106153120
> > > Files: mediatek/mt7925/WIFI_MT7925_PATCH_MCU_1_1_hdr.bin
> > >        mediatek/mt7925/WIFI_RAM_CODE_MT7925_1_1.bin
> > >
> > > Kernel
> > > ------
> > > 6.18.18-1-MANJARO (close to vanilla 6.18 stable; not yet tested on
> > > wireless-next or nbd168/wireless HEAD -- happy to retest if needed,
> > > but flagging the data point in case it helps as-is).
> > >
> > > Tools: iw version 6.17
> > >
> > > Regulatory
> > > ----------
> > > $ iw reg get
> > > country US: DFS-FCC
> > >    ...
> > >    (5730 - 5850 @ 80), (N/A, 30), (N/A), AUTO-BW
> > >    ...
> > >
> > > Connection context: 5GHz channel 161 (5805 MHz), 80 MHz, VHT-MCS,
> > > NSS 1. So we are on a band with a 30 dBm regulatory cap.
> > >
> > > Observed
> > > --------
> > > $ iw dev wlp1s0 info | grep txpower
> > >         txpower 3.00 dBm
> > >
> > > $ sudo iw dev wlp1s0 set txpower fixed 100   # 1 dBm
> > > $ iw dev wlp1s0 info | grep txpower
> > >         txpower 3.00 dBm
> > >
> > > $ sudo iw dev wlp1s0 set txpower fixed 1500  # 15 dBm
> > > $ iw dev wlp1s0 info | grep txpower
> > >         txpower 3.00 dBm
> > >
> > > $ sudo iw dev wlp1s0 set txpower auto
> > > $ iw dev wlp1s0 info | grep txpower
> > >         txpower 3.00 dBm
> > >
> > > All four `set` invocations return exit code 0. The reported value
> > > never moves.
> > >
> > > Expected
> > > --------
> > > Either:
> > >   - The reported txpower follows the requested value (or, where
> > >     capped, the actual applied value with extack indicating the
> > >     cap reason), or
> > >   - The set call returns an error rather than silently ignoring the
> > >     request.
> > >
> > > Caveats
> > > -------
> > > - Not yet tested on wireless-next or nbd168/wireless HEAD. If a
> > >   reproduction on a current dev tree would be useful, I can do that.
> > > - I have not verified whether the actual radiated TX power changes
> > >   in response to `set txpower fixed`; I am reporting only the
> > >   user-visible behavior.
> > >
> > > Thanks,
> > > Bradley
> > >
> > > On Wed, May 6, 2026 at 8:12=E2=80=AFPM Sean Wang <sean.wang@kernel.or=
g> wrote:
> > > >
> > > > Hi,
> > > >
> > > > The TX power reporting issue has already been investigated by Lucid
> > > > from the Linux WiFi USB community, and there is a proposed solution=
.
> > > > I think we can continue checking whether there are any remaining
> > > > issues on top of that work. Please refer to the patches here:
> > > > https://lists.infradead.org/pipermail/linux-mediatek/2026-April/105=
726.html
> > > > Thanks everyone for reporting and raising these concerns.
> > > >
> > > > On Wed, May 6, 2026 at 3:09=E2=80=AFPM Javier Tia <floss@jetm.me> w=
rote:
> > > > >
> > > > > On Sun May  4 22:04:48 2026 Bradley Pizzimenti wrote:
> > > > > > `iw dev <iface> set txpower fixed N` returns success on mt7925 =
for
> > > > > > any N tested, but the reported txpower never changes from a stu=
ck
> > > > > > value of 3.00 dBm.
> > > > >
> > > > > Hi Bradley,
> > > > >
> > > > > The 3 dBm display bug is a known issue we have seen when using mt=
7927
> > > > > and a tested fix has been working well so far. The root cause is =
that
> > > > > mt7925_mcu_set_rate_txpower() programs the per-band SKU tables in=
to
> > > > > firmware but never assigns phy->txpower_cur. mt76_get_txpower() t=
hen
> > > > > computes:
> > > > >
> > > > >   DIV_ROUND_UP(0 + 6, 2) =3D 3
> > > > >
> > > > > regardless of the actual power level. The RF output is unaffected=
;
> > > > > it is a display-only bug.
> > > > >
> > > > > The fix reads the effective TX power back from the rate power lim=
its
> > > > > after programming the SKU tables and writes it to phy->txpower_cu=
r,
> > > > > following the same pattern used by mt7996:
> > > > >
> > > > >   https://github.com/jetm/mediatek-mt7927-dkms/blob/master/mt7927=
-wifi-14-fix-reported-txpower-always-showing-3-db.patch
> > > > >
> > > > > This is part of a series we are targeting for wireless-next; not
> > > > > yet upstream.
> > > > >
> > > > > > What seems potentially distinct here is that the user-issued
> > > > > > `iw set txpower fixed N` itself is silently no-op'd, separate
> > > > > > from the reported-value question.
> > > > >
> > > > > Agreed those are two separate issues. Our patch addresses the
> > > > > display-only side: after applying it, iw will report the value th=
e
> > > > > firmware is actually using based on the SKU tables, rather than
> > > > > always 3 dBm. Whether `set txpower fixed N` propagates to firmwar=
e
> > > > > to change actual output power is orthogonal and not addressed her=
e.
> > > > >
> > > > > If you can test the patch on your MT7925 and confirm the displaye=
d
> > > > > value reflects the correct power after association, a Tested-by
> > > > > would be appreciated.
> > > > >
> > > > > Best,
> > > > > Javier
> > > > >
> > > >

