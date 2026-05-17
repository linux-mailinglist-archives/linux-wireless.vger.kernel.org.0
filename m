Return-Path: <linux-wireless+bounces-36554-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FdEHKu8CWrlnAQAu9opvQ
	(envelope-from <linux-wireless+bounces-36554-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 15:03:39 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6978561106
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 15:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5B1B302DA20
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 13:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2B7376BD1;
	Sun, 17 May 2026 13:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeM8UHbd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ABD378D98
	for <linux-wireless@vger.kernel.org>; Sun, 17 May 2026 13:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779022938; cv=pass; b=XDVrpGB7zwmjaJ0X6qIwsEQ/XeJMbZRLJ4Gt4qSZjZn2uBwoRm4sdx6I/9d0lCA3bYB2EemtXzYlCH4TQpYWV3h5I+JUn2kwH1dNkY06Agj19fyxKUJdxQJW1hafIbhGUEdxT30NL6XdKlnA9MAf+s0Saqwc+bY+FBCvxETWmKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779022938; c=relaxed/simple;
	bh=cHLfInepgd6zPb/tpkxXUTHwI3zIh0WLknl+85pKlCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nu6LR4+YeF3B9rFVYyutYi7035q2CiZSHOtsxAZDeveYqwYCe55PxvfbXY6NlqYTA7YTz6CPFCFo0265qV3aJ3L966OOuuWm7OdZ2Gph22nDBon6Z3GKLq7xT2Ca6sWmd3OQRiC5hGD3Y5dtI+zNYkPE8Bk7jIwVjjtB31s4XNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IeM8UHbd; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a8cb92f26aso1545155e87.1
        for <linux-wireless@vger.kernel.org>; Sun, 17 May 2026 06:02:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779022931; cv=none;
        d=google.com; s=arc-20240605;
        b=Uaz025sDHxNkV8ubQJtn1re8CBb8AKs4lvlP/Kz4m3gxzOcaII3n2JjiWpofwVzNH1
         bbm8yXVsiee9hIg9/wBGABUjoZ8/6GgoYLGOyxdQnGVhWf2iKJMecTyMRVdyfUGT1IMm
         WVuMiuMWSvZqke2J2KE/mFBAIYcwb9vluC6Cw5cZwgAcCnbA1dgKGwTNtes6N7aQ1ZE/
         f1ngAC+x4Zbs0Y3uWo34u7QV1L3DRWjr7UQ0e2JUkVcfcARNoQm+pY0CjRrLW60cPrzt
         fDTmSQxU3QnJle89iCtdvX/JZb10tjKHZKoI+xzAuyelhsRRbSTL6flw2GWcMcUOERJn
         r3FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FhotB3WmZS4RdLDhV3zhLMq1HMhtHjJJYY8Fard8AIs=;
        fh=aJb0b2fDexTSvw3VvxnB6lpoh6AgTVbePXDx6+WP09E=;
        b=jS3mnxjRayIYqwtutgJkg5LjCMdH6KNlziOAACt61IV1A6aR0ktmhaIKvoYGdpA+O/
         s1PVEoveodUfLcV2M1AVCqQ7tRFswinKW9jEFSXnO7TlKVet3Oh0B5x3q6kZQYtjO/IS
         FbFS7KCyQ4RTG2LzLe1X2rYMoA/4zZUSKMXYLh79VWOv8EjoyIILW3TFcW/t9TydV0In
         QopBZfCsEdV1GnBQN2Ra79mkCWjx/abDPjayKFUrWyg3mDSyJg6D1D+tjuQ3o14E9If+
         9/+IdNQ61buZrqRKFT2f2H5m5vlXsxKMcJed7Q/Jcq84jaulFKYfeQQ7Ef+MmF023ldx
         H8ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779022931; x=1779627731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhotB3WmZS4RdLDhV3zhLMq1HMhtHjJJYY8Fard8AIs=;
        b=IeM8UHbdRgPHVTL1JTUmGXwu34eKNQqyqFzILJ3jrqJG9LFdQ7W9676E9HJfeu7LC8
         QBWtVLboTMnvIEFa36av1CoXpEXBKxWMLsiFV+QUM0tmIDaPAkVwd8O71bTpB4OTCOTt
         XuNmCJMPo5G/sbYVeKc4cb5ZV5PduxIiVDLm569QsD1qSivrVJEQXzfWzDEj++3ZnaSg
         NN44omCa5uvGN5MLwskG1aU1l1ojCJISNAoV7C8XQlUoUw2jq/Hx03VqHZ/59RRvCtwp
         gV3EO9rfS/oqs/VrGGFaleqZa8LkGFFRjPU02Fq6Z6wuciM6q+py1hx/d2jfY5ixkisT
         xpvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779022931; x=1779627731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FhotB3WmZS4RdLDhV3zhLMq1HMhtHjJJYY8Fard8AIs=;
        b=bz7hHJSdwg11Na03btQ0GZEP8BVbNMgx8LUwIJ8mUSlYycLZ3hWigN33pVAOmARwj9
         Gu1hGX3BLub2xxM2fw5GbfdROGiVRG7OrU8zWqR6QUjg6UdtfKvYk71fvtKQbcEkAxvD
         xOYQCQ7slTdwb02Zi1BxI9Oc2tD+RWaLA/Y/2AoFcdpCnyikfb3eyt0fniFiSm1S7MV4
         /1XAaYpDSYgyjoDuPW5OhMU7VUtDCzNg/YYb3Z+EcC0Q+njvObbYeM/jrtc7g/AtaICP
         SLswJCmr26N+1p23MSfWiHxlTbFIbar29ABUxR6GTweLUSfRWbWTyvw5vHfNEgRzI7PT
         029w==
X-Forwarded-Encrypted: i=1; AFNElJ9frOU13HRRP3Z2AYtjtJOUslWCgSzZxDAPC1mdH2pJoAON3Osm9O4MmL/lB6EhsStQuzZYdeOdgKMApCsN+g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/t/MIR5yijYcCKEdHvFzLYAZn3809UWGLOOT1wgFBKtZGZCCl
	kzqV6UcKCVEMbcSSDzi6dChWeFDHWrniolnU8SGMMUcRIePtUQPA139NdYAPSZMh5pbAR6Yvx/Q
	TLG4lTSku95/FwgGTLxhKGKj0zEPW7dg=
X-Gm-Gg: Acq92OF1b2OwqU1b72hZ3H7Qk+YI8NgRakNPXsE4FiUfc/3b+QKkblEBDKrQfgRluev
	Ikwbsoif1/ZcjOhdcedWDOVu5gBS3GwdP9KqGnko9/uOdQuw0XZ5aK0OVED0dgUSh+a7pJIk2P8
	hPY2FspTtDK8Nn6z1a4o+imx1U10kh3PI4Uute9CemBrFTjLmjfflPR2Eu2v7BsvQmWy2auG1np
	goPyI3XVXMr1sDjy4yRjJJiKx0+vpQ4o01NRqOLZlzEZxjGFt8q+/4+6ZxA3c4qVRbfdsv0LSgN
	fDHTrJgPqFU7qEjy+w==
X-Received: by 2002:a05:6512:b9d:b0:5a9:d3a4:a25c with SMTP id
 2adb3069b0e04-5aa0e7470d1mr2980752e87.37.1779022930147; Sun, 17 May 2026
 06:02:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACjnFagN9zeSkwEv3-CSPJDUENPcEcOLjKyQoLQ91Yjn=rq5ww@mail.gmail.com>
 <20260506200918.D68321EA006C@mailuser.phl.internal> <CAGp9LzqkJ8QoOnBAiGu=uum3-LmCB3yHr91sw1HoLw+7ewNx6A@mail.gmail.com>
 <CAN6xzWdsYY0eni7aHG2Q=i2zz-rVxFRJJhCJbUsn=Pn_oDY-bQ@mail.gmail.com>
In-Reply-To: <CAN6xzWdsYY0eni7aHG2Q=i2zz-rVxFRJJhCJbUsn=Pn_oDY-bQ@mail.gmail.com>
From: John Henry <jshenry1963@gmail.com>
Date: Sun, 17 May 2026 09:01:59 -0400
X-Gm-Features: AVHnY4IMQ_YzMKlit-aEQHdc_R-PD7schhIkAMTGveoOUQVZ-GY9WU5-GFVhZ9s
Message-ID: <CAN6xzWcetGmoWtBA1Rm2vFaFGT8efeTw5LH1KPLZeGOtfGj2fQ@mail.gmail.com>
Subject: Re: [bug report] wifi: mt76: mt7925: iw set txpower fixed accepted
 but ignored
To: Sean Wang <sean.wang@kernel.org>
Cc: Javier Tia <floss@jetm.me>, Bradley Pizzimenti <brad.pizzimenti@gmail.com>, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, nbd@nbd.name, 
	lorenzo@kernel.org, ryder.lee@mediatek.com, shayne.chen@mediatek.com, 
	sean.wang@mediatek.com, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Deren Wu <deren.wu@mediatek.com>, 
	Nick Morrow <morrownr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E6978561106
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36554-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[jetm.me,gmail.com,vger.kernel.org,nbd.name,kernel.org,mediatek.com,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jshenry1963@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Just a kind reminder of this issue, has anyone been able to reproduce
this monitor mode issue?
When scanning through channels, and the list of channels is > 4, there
is a large transmit tick/burst coming from the MT7921u and the MT7925.
This can easily be seen on an RF Spectrum Analyzer.
Confirmed on an Alfa AWUS036AXML consumer product and the Netgear
Nighthawk A9000.
This can be reproduced with simple scripts.

Reproduction with stock iw commands (no custom code):

IFACE=3D$(iw dev | awk '/Interface wl/ {print $2; exit}')
iw reg set US ; sleep 1
ip link set "$IFACE" down
iw dev "$IFACE" set type monitor
ip link set "$IFACE" up

# This triggers narrowband bursts at channel center on each retune:
while true; do
  for f in 2412 2417 2422 2427 2432; do
    iw dev "$IFACE" set freq "$f" HT20
  done
done

# This does NOT (only 4 frequencies):
while true; do
  for f in 2412 2422 2462 2484; do
    iw dev "$IFACE" set freq "$f" HT20
  done
done

Bursts are ~800 kHz wide at the base, -30 to -50 dBm OTA at close
range, brief (estimated few hundred microseconds), at channel
frequency. tx_stats counters remain zero throughout.
On Mon, May 11, 2026 at 1:58=E2=80=AFPM John Henry <jshenry1963@gmail.com> =
wrote:
>
> Bradley/Sean,
>
> Thank you all very much for the information.
> I tested this on mt7921u based Alfa AWUS unit and also an mt7925 based
> Netgear Nighthawk unit.
> I can confirm that the RF tick issue is present on both models when in
> Monitor Mode. I'm assuming it is in the base mt76?
>
> I attempted sudo iw dev wlxxx set txpower fixed nn where nn is the
> minimum value, next few values up, and then a few near the max values,
> and see no change in the signal strength of the RF Ticks when scanning
> through 5 or more channels.
>
> Please keep this in mind when attempting to resolve the known txpower
> 3dBm issue if possible, or please generate a new bug report for that
> specifically so that I can track when it is patched, or in ??? version
> so that I can test here locally.
>
> Incidentally, I'd appreciate it if anyone could please attempt to
> repeat using the scripts I had shown in the previous posts and confirm
> it is indeed seen by others.
>
> Thank you very much for your time and assistance
>
> John Henry
>
>
>
>
> From: Bradley Pizzimenti <brad.pizzimenti@gmail.com>
> To: linux-wireless@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org, nbd@nbd.name, lorenzo@kernel.org,
> ryder.lee@mediatek.com, shayne.chen@mediatek.com,
> sean.wang@mediatek.com
> Subject: [bug report] wifi: mt76: mt7925: iw set txpower fixed
> accepted but ignored
> Date: Mon, 4 May 2026 15:04:35 -0700 [thread overview]
> Message-ID: <CACjnFagN9zeSkwEv3-CSPJDUENPcEcOLjKyQoLQ91Yjn=3Drq5ww@mail.g=
mail.com>
> (raw)
>
> Hi there maintainers,
>
> `iw dev <iface> set txpower fixed N` returns success on mt7925 for any
> N tested, but the reported txpower never changes from a stuck value of
> 3.00 dBm. The kernel accepts and ignores the call silently in both
> directions (above and below the displayed value), and well below the
> regulatory ceiling.
>
> I'm aware there's prior art on the cosmetic 3.00 dBm display issue
> (Razvan Grigore's v2 series, Feb 2025; Ming Yen Hsieh's txpower init
> refactor, Sept 2025). What seems potentially distinct here is that the
> user-issued `iw set txpower fixed N` itself is silently no-op'd,
> separate from the reported-value question. Reporting as breadcrumbs
> in case the second observation is a separate bug rather than the same
> one.
>
> Hardware
> --------
> MEDIATEK MT7925 [Filogic 360], 802.11be 2x2, PCI 14c3:7925
> ASIC revision 0x79250000
> Driver in use: mt7925e (in-tree)
>
> Firmware (from dmesg at probe)
> ------------------------------
> mt7925e 0000:01:00.0: HW/SW Version: 0x8a108a10,
>                      Build Time: 20260106153007a
> mt7925e 0000:01:00.0: WM Firmware Version: ____000000,
>                      Build Time: 20260106153120
> Files: mediatek/mt7925/WIFI_MT7925_PATCH_MCU_1_1_hdr.bin
>        mediatek/mt7925/WIFI_RAM_CODE_MT7925_1_1.bin
>
> Kernel
> ------
> 6.18.18-1-MANJARO (close to vanilla 6.18 stable; not yet tested on
> wireless-next or nbd168/wireless HEAD -- happy to retest if needed,
> but flagging the data point in case it helps as-is).
>
> Tools: iw version 6.17
>
> Regulatory
> ----------
> $ iw reg get
> country US: DFS-FCC
>    ...
>    (5730 - 5850 @ 80), (N/A, 30), (N/A), AUTO-BW
>    ...
>
> Connection context: 5GHz channel 161 (5805 MHz), 80 MHz, VHT-MCS,
> NSS 1. So we are on a band with a 30 dBm regulatory cap.
>
> Observed
> --------
> $ iw dev wlp1s0 info | grep txpower
>         txpower 3.00 dBm
>
> $ sudo iw dev wlp1s0 set txpower fixed 100   # 1 dBm
> $ iw dev wlp1s0 info | grep txpower
>         txpower 3.00 dBm
>
> $ sudo iw dev wlp1s0 set txpower fixed 1500  # 15 dBm
> $ iw dev wlp1s0 info | grep txpower
>         txpower 3.00 dBm
>
> $ sudo iw dev wlp1s0 set txpower auto
> $ iw dev wlp1s0 info | grep txpower
>         txpower 3.00 dBm
>
> All four `set` invocations return exit code 0. The reported value
> never moves.
>
> Expected
> --------
> Either:
>   - The reported txpower follows the requested value (or, where
>     capped, the actual applied value with extack indicating the
>     cap reason), or
>   - The set call returns an error rather than silently ignoring the
>     request.
>
> Caveats
> -------
> - Not yet tested on wireless-next or nbd168/wireless HEAD. If a
>   reproduction on a current dev tree would be useful, I can do that.
> - I have not verified whether the actual radiated TX power changes
>   in response to `set txpower fixed`; I am reporting only the
>   user-visible behavior.
>
> Thanks,
> Bradley
>
> On Wed, May 6, 2026 at 8:12=E2=80=AFPM Sean Wang <sean.wang@kernel.org> w=
rote:
> >
> > Hi,
> >
> > The TX power reporting issue has already been investigated by Lucid
> > from the Linux WiFi USB community, and there is a proposed solution.
> > I think we can continue checking whether there are any remaining
> > issues on top of that work. Please refer to the patches here:
> > https://lists.infradead.org/pipermail/linux-mediatek/2026-April/105726.=
html
> > Thanks everyone for reporting and raising these concerns.
> >
> > On Wed, May 6, 2026 at 3:09=E2=80=AFPM Javier Tia <floss@jetm.me> wrote=
:
> > >
> > > On Sun May  4 22:04:48 2026 Bradley Pizzimenti wrote:
> > > > `iw dev <iface> set txpower fixed N` returns success on mt7925 for
> > > > any N tested, but the reported txpower never changes from a stuck
> > > > value of 3.00 dBm.
> > >
> > > Hi Bradley,
> > >
> > > The 3 dBm display bug is a known issue we have seen when using mt7927
> > > and a tested fix has been working well so far. The root cause is that
> > > mt7925_mcu_set_rate_txpower() programs the per-band SKU tables into
> > > firmware but never assigns phy->txpower_cur. mt76_get_txpower() then
> > > computes:
> > >
> > >   DIV_ROUND_UP(0 + 6, 2) =3D 3
> > >
> > > regardless of the actual power level. The RF output is unaffected;
> > > it is a display-only bug.
> > >
> > > The fix reads the effective TX power back from the rate power limits
> > > after programming the SKU tables and writes it to phy->txpower_cur,
> > > following the same pattern used by mt7996:
> > >
> > >   https://github.com/jetm/mediatek-mt7927-dkms/blob/master/mt7927-wif=
i-14-fix-reported-txpower-always-showing-3-db.patch
> > >
> > > This is part of a series we are targeting for wireless-next; not
> > > yet upstream.
> > >
> > > > What seems potentially distinct here is that the user-issued
> > > > `iw set txpower fixed N` itself is silently no-op'd, separate
> > > > from the reported-value question.
> > >
> > > Agreed those are two separate issues. Our patch addresses the
> > > display-only side: after applying it, iw will report the value the
> > > firmware is actually using based on the SKU tables, rather than
> > > always 3 dBm. Whether `set txpower fixed N` propagates to firmware
> > > to change actual output power is orthogonal and not addressed here.
> > >
> > > If you can test the patch on your MT7925 and confirm the displayed
> > > value reflects the correct power after association, a Tested-by
> > > would be appreciated.
> > >
> > > Best,
> > > Javier
> > >
> >

