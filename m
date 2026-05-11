Return-Path: <linux-wireless+bounces-36257-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCkYDKodAmocoAEAu9opvQ
	(envelope-from <linux-wireless+bounces-36257-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 20:19:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFC05143BF
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 20:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44939314889C
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 17:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD98D3FE35F;
	Mon, 11 May 2026 17:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsFIHQnJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BDB2248AF
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 17:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778522301; cv=pass; b=WBPVGMX6Kg7+85FHXESg7kXLRtjfqOxtkY2Vk8taQTjpVutlIAZ+FF3ZlBRWSfPhIL+1BNKBejdYKZLi5OiK78ESEpupptWfkc1YzLr0zMgelA4bMLC2vB14ylVifgfYqD96YLac1JIHo4ewqxDyCF3Px0inl2iunNDcYitW9nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778522301; c=relaxed/simple;
	bh=AN2OJZKTXXJdYUx+dGLGxX0PB9rZ1AHUss2wsvmnTGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dDIVh04sDlJ3iEstXWd18CBoefzs5Su9p2cFtJ3Qb6ChDjLCiwXZ+a0Ui8RtXYotFQ+9tgO8ovmWWEm3BRswaf0NkN+Nq9V9CeK0o7yNwu/5KxZZcbQhrhKmyZnh5G8rFzVw+CSZk+fvS81Fg80dfuJs13M415mvzHwcDciUkIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TsFIHQnJ; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a525aedb24so4602174e87.2
        for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 10:58:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778522298; cv=none;
        d=google.com; s=arc-20240605;
        b=lJqZN1cOVRWUfxY9WWp/uaGz/doTwzIhk1kasueMdRVoMFoQIIFJM9LO5vuEyafwOC
         SyGtaSANUVZya7YBlhZPOQRm3/kXfQIw9Rne3j6NKYQPn3LrFAQK0qpMEZkAJABUjHTc
         MHpd8nUywV9YBDf7eNl+kzhE+wqKoKbs+UEfsKUw4ecy1G1q7BdlmbUPrB/fw/uaEgPK
         DbqOqVKHYbughjCWN7ufmEoB+s2LJsIyxTTo4hKS9eJz2spsegCKcxKGlTPb+xP/KJ+/
         iS656xSVAD91Egr6Sv1s2sSuqj8KBtiw6fM6XauHil67Q5Vl6HnAmWCjOWrHgXEP56hS
         pfgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SY9JiJtIYDNHwNHrC1dYRjhPzwG3k19YHr9rjoF6vFE=;
        fh=Ix2ZZhTNiXGbORYZ+BDgqiEz+x9VQCoZjwc4q4yy+ao=;
        b=F/hEySGISsVHeqqTbdhoypOkm8qDf83x7ZWcBDTDxZscIjCuXPSZiQZLwLp8ezA/5q
         UJD9XL0vhGiItDoNtu266e3cDkLxJPgFOzHLbtURPC9ISvShUrpP5unu0ix0Zrgxq6mj
         cQjIMES2GbN/3wbXRnasQUYtL0SKCBHhNaSz2qP+GaW3NVb6oAq7T2cvY5KziPVBNp4o
         Z/oxFiAqDsvSEwdIV+hbTx1ocomCvzOX7yUOP1MSkr6Ye8eQw6f+5daqQd06ABSl+EcU
         4RStqVuQhEnit6OSyuzdpWsbPlVU+nxFtZh3Ry90VS5/T9b0275bTzV9vON5WXBa01Ar
         LHTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778522298; x=1779127098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SY9JiJtIYDNHwNHrC1dYRjhPzwG3k19YHr9rjoF6vFE=;
        b=TsFIHQnJP1kLtMt4DmyLwO7Xoqq8Ag3lRlkXKdka2pg0u15gN63eJGia7fQgorMDD0
         3ER9XJyYcpAymsrb3Br3b7LzrVKK0GcBt3L9SATziSEGGOyXdT+OwyWETxnWolV2emVz
         8eaHXNEGLuILp8RgdUmp40Q/YIMYl75tEZoEs6+C7AT5640xEwSrVeZm3g4ZCSpVzcfE
         Ec+YTw4l06+GkUmeC1SRdHAdIVa9NkWNM/jD7fZk1Vv10KHvGhTVbWMvaoIM3mYOa6xn
         sMu6n9j2ijU2QzoyWlwOkUZrjJf+DG5ToVANGnK+cWzzhYl2i10Mi2emzSwoUo1vQqMQ
         oE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778522298; x=1779127098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SY9JiJtIYDNHwNHrC1dYRjhPzwG3k19YHr9rjoF6vFE=;
        b=KHGGsAxxwDGNb6u0u1qvIAJb9keEehHHTgiGleUEBkfsWLGsmJzt94kvH61ei0hxT0
         KP8XjlOAewtZUbY1nAHf4lFfzVPF68m3kBnwXoBNbSBH2gJB5zLFOoAyaL9B86TsO/+d
         qHZ+pSSzUpcBVYjIwxYln3TUg38GYyGaIMJAJJkgRXh+Qn7ee8v904SRH50Bf18fFdhO
         KZ5HiEfFCvdVBz+qskz2Exw6gKFGJm5iE5Q+XSwLRGUBl6ZklBKtFidqmL48N+p9LYRL
         uzaYBIr5ly8TW29RP99m56xGjAA2SIUOqEZ6ON5GCH5O1Xq82SCSSbYAbGhJgUZiWJfW
         884A==
X-Forwarded-Encrypted: i=1; AFNElJ9+SoUhk0u3o4eVm4mkIylmAVo/08yuEx6i0nuGs4hWrCmgdbq0hd9XNIR/1I/liMC0Gtm26Jwf3nb8edtp6w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfJHySvv+M3psHBKgVCbG/NkDFTKaKb1+8JBPeqBUlRn1M7f59
	SyhDJtHGUctHu1fV1n533AR2Dp2IG/IoQy+YPOqji9R7V76AhQN5PHLXW+M+HV8oaQ0qEGbHGvb
	a8wWjOUFlcWP8goW4NkdrTY+Su9uC9fE=
X-Gm-Gg: Acq92OEVG+NdqPlxJ+2aYEvlbjs8mCWhGt9sydSnGfGWEU7XDp29ooWKZAzDlQLJxJQ
	z4hl5JZc8t4ZltdK4SQiuoaaeR9MRpOcUMXRISDylwRnmY5N4uJMA3fojGzN7CSzLc8cwmhmGLM
	g/cSirTkE6dHSKNLT62CzXqfJBGzutXWGHqXJPtTRiQQWwALrI+/bYwU1X0uL0cWKNzWCGqqbsz
	qKV5RWzdAd5VTiToJX+RlqMEHJ3qZQEBOSLIynI3yD8wv/pgbFoHx9RZF1nmgehnEXMd6XO59mC
	QhbGts0=
X-Received: by 2002:a05:6512:10cf:b0:5a8:9fd7:c248 with SMTP id
 2adb3069b0e04-5a89fd7c28cmr7353682e87.37.1778522297853; Mon, 11 May 2026
 10:58:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACjnFagN9zeSkwEv3-CSPJDUENPcEcOLjKyQoLQ91Yjn=rq5ww@mail.gmail.com>
 <20260506200918.D68321EA006C@mailuser.phl.internal> <CAGp9LzqkJ8QoOnBAiGu=uum3-LmCB3yHr91sw1HoLw+7ewNx6A@mail.gmail.com>
In-Reply-To: <CAGp9LzqkJ8QoOnBAiGu=uum3-LmCB3yHr91sw1HoLw+7ewNx6A@mail.gmail.com>
From: John Henry <jshenry1963@gmail.com>
Date: Mon, 11 May 2026 13:58:05 -0400
X-Gm-Features: AVHnY4K5s9op3gblhN4NTbgI2jjORItyQKxqE8drbRi9J1gF2iMeHy5tqEB-kgA
Message-ID: <CAN6xzWdsYY0eni7aHG2Q=i2zz-rVxFRJJhCJbUsn=Pn_oDY-bQ@mail.gmail.com>
Subject: Re: [bug report] wifi: mt76: mt7925: iw set txpower fixed accepted
 but ignored
To: Sean Wang <sean.wang@kernel.org>
Cc: Javier Tia <floss@jetm.me>, Bradley Pizzimenti <brad.pizzimenti@gmail.com>, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, nbd@nbd.name, 
	lorenzo@kernel.org, ryder.lee@mediatek.com, shayne.chen@mediatek.com, 
	sean.wang@mediatek.com, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 7BFC05143BF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36257-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[jetm.me,gmail.com,vger.kernel.org,nbd.name,kernel.org,mediatek.com,lists.infradead.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jshenry1963@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[jetm.me:email,infradead.org:url,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Bradley/Sean,

Thank you all very much for the information.
I tested this on mt7921u based Alfa AWUS unit and also an mt7925 based
Netgear Nighthawk unit.
I can confirm that the RF tick issue is present on both models when in
Monitor Mode. I'm assuming it is in the base mt76?

I attempted sudo iw dev wlxxx set txpower fixed nn where nn is the
minimum value, next few values up, and then a few near the max values,
and see no change in the signal strength of the RF Ticks when scanning
through 5 or more channels.

Please keep this in mind when attempting to resolve the known txpower
3dBm issue if possible, or please generate a new bug report for that
specifically so that I can track when it is patched, or in ??? version
so that I can test here locally.

Incidentally, I'd appreciate it if anyone could please attempt to
repeat using the scripts I had shown in the previous posts and confirm
it is indeed seen by others.

Thank you very much for your time and assistance

John Henry




From: Bradley Pizzimenti <brad.pizzimenti@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, nbd@nbd.name, lorenzo@kernel.org,
ryder.lee@mediatek.com, shayne.chen@mediatek.com,
sean.wang@mediatek.com
Subject: [bug report] wifi: mt76: mt7925: iw set txpower fixed
accepted but ignored
Date: Mon, 4 May 2026 15:04:35 -0700 [thread overview]
Message-ID: <CACjnFagN9zeSkwEv3-CSPJDUENPcEcOLjKyQoLQ91Yjn=3Drq5ww@mail.gma=
il.com>
(raw)

Hi there maintainers,

`iw dev <iface> set txpower fixed N` returns success on mt7925 for any
N tested, but the reported txpower never changes from a stuck value of
3.00 dBm. The kernel accepts and ignores the call silently in both
directions (above and below the displayed value), and well below the
regulatory ceiling.

I'm aware there's prior art on the cosmetic 3.00 dBm display issue
(Razvan Grigore's v2 series, Feb 2025; Ming Yen Hsieh's txpower init
refactor, Sept 2025). What seems potentially distinct here is that the
user-issued `iw set txpower fixed N` itself is silently no-op'd,
separate from the reported-value question. Reporting as breadcrumbs
in case the second observation is a separate bug rather than the same
one.

Hardware
--------
MEDIATEK MT7925 [Filogic 360], 802.11be 2x2, PCI 14c3:7925
ASIC revision 0x79250000
Driver in use: mt7925e (in-tree)

Firmware (from dmesg at probe)
------------------------------
mt7925e 0000:01:00.0: HW/SW Version: 0x8a108a10,
                     Build Time: 20260106153007a
mt7925e 0000:01:00.0: WM Firmware Version: ____000000,
                     Build Time: 20260106153120
Files: mediatek/mt7925/WIFI_MT7925_PATCH_MCU_1_1_hdr.bin
       mediatek/mt7925/WIFI_RAM_CODE_MT7925_1_1.bin

Kernel
------
6.18.18-1-MANJARO (close to vanilla 6.18 stable; not yet tested on
wireless-next or nbd168/wireless HEAD -- happy to retest if needed,
but flagging the data point in case it helps as-is).

Tools: iw version 6.17

Regulatory
----------
$ iw reg get
country US: DFS-FCC
   ...
   (5730 - 5850 @ 80), (N/A, 30), (N/A), AUTO-BW
   ...

Connection context: 5GHz channel 161 (5805 MHz), 80 MHz, VHT-MCS,
NSS 1. So we are on a band with a 30 dBm regulatory cap.

Observed
--------
$ iw dev wlp1s0 info | grep txpower
        txpower 3.00 dBm

$ sudo iw dev wlp1s0 set txpower fixed 100   # 1 dBm
$ iw dev wlp1s0 info | grep txpower
        txpower 3.00 dBm

$ sudo iw dev wlp1s0 set txpower fixed 1500  # 15 dBm
$ iw dev wlp1s0 info | grep txpower
        txpower 3.00 dBm

$ sudo iw dev wlp1s0 set txpower auto
$ iw dev wlp1s0 info | grep txpower
        txpower 3.00 dBm

All four `set` invocations return exit code 0. The reported value
never moves.

Expected
--------
Either:
  - The reported txpower follows the requested value (or, where
    capped, the actual applied value with extack indicating the
    cap reason), or
  - The set call returns an error rather than silently ignoring the
    request.

Caveats
-------
- Not yet tested on wireless-next or nbd168/wireless HEAD. If a
  reproduction on a current dev tree would be useful, I can do that.
- I have not verified whether the actual radiated TX power changes
  in response to `set txpower fixed`; I am reporting only the
  user-visible behavior.

Thanks,
Bradley

On Wed, May 6, 2026 at 8:12=E2=80=AFPM Sean Wang <sean.wang@kernel.org> wro=
te:
>
> Hi,
>
> The TX power reporting issue has already been investigated by Lucid
> from the Linux WiFi USB community, and there is a proposed solution.
> I think we can continue checking whether there are any remaining
> issues on top of that work. Please refer to the patches here:
> https://lists.infradead.org/pipermail/linux-mediatek/2026-April/105726.ht=
ml
> Thanks everyone for reporting and raising these concerns.
>
> On Wed, May 6, 2026 at 3:09=E2=80=AFPM Javier Tia <floss@jetm.me> wrote:
> >
> > On Sun May  4 22:04:48 2026 Bradley Pizzimenti wrote:
> > > `iw dev <iface> set txpower fixed N` returns success on mt7925 for
> > > any N tested, but the reported txpower never changes from a stuck
> > > value of 3.00 dBm.
> >
> > Hi Bradley,
> >
> > The 3 dBm display bug is a known issue we have seen when using mt7927
> > and a tested fix has been working well so far. The root cause is that
> > mt7925_mcu_set_rate_txpower() programs the per-band SKU tables into
> > firmware but never assigns phy->txpower_cur. mt76_get_txpower() then
> > computes:
> >
> >   DIV_ROUND_UP(0 + 6, 2) =3D 3
> >
> > regardless of the actual power level. The RF output is unaffected;
> > it is a display-only bug.
> >
> > The fix reads the effective TX power back from the rate power limits
> > after programming the SKU tables and writes it to phy->txpower_cur,
> > following the same pattern used by mt7996:
> >
> >   https://github.com/jetm/mediatek-mt7927-dkms/blob/master/mt7927-wifi-=
14-fix-reported-txpower-always-showing-3-db.patch
> >
> > This is part of a series we are targeting for wireless-next; not
> > yet upstream.
> >
> > > What seems potentially distinct here is that the user-issued
> > > `iw set txpower fixed N` itself is silently no-op'd, separate
> > > from the reported-value question.
> >
> > Agreed those are two separate issues. Our patch addresses the
> > display-only side: after applying it, iw will report the value the
> > firmware is actually using based on the SKU tables, rather than
> > always 3 dBm. Whether `set txpower fixed N` propagates to firmware
> > to change actual output power is orthogonal and not addressed here.
> >
> > If you can test the patch on your MT7925 and confirm the displayed
> > value reflects the correct power after association, a Tested-by
> > would be appreciated.
> >
> > Best,
> > Javier
> >
>

