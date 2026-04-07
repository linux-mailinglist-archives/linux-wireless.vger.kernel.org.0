Return-Path: <linux-wireless+bounces-34489-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCntBt431WmP2wcAu9opvQ
	(envelope-from <linux-wireless+bounces-34489-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 18:59:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D1E3B2241
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 18:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F3ED3300E48D
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 16:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5313A4517;
	Tue,  7 Apr 2026 16:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUQYB/jY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3CA3CFF7A
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 16:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775581143; cv=pass; b=dfzHTagFQO5DUx0UkDsW25HOQ2mkz8Z06UZ4NtynXWQI/YSkVjAaVW6bz0Jb8hvqQsAofh5fW/ZMMJDiwrSM2usXcggLkvP5Tidki4wgnA7z+YyufZdOuJiDmAZ7Ksui0Xx7ZoLGreTskV1Xph73iLuy3GmJ2kuqA5WCh1m4gVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775581143; c=relaxed/simple;
	bh=tPpgFwDwEPR9VZlW4uVSoXwllNxxfcqOh1vOHIRPAF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PkhHzUQUPCjssWKdfvuBheDsu6tW8VIcJxcr636UPnZcOFtDkA2cD4JrnlDTqcMnxGxO1HkpruKw3TOiusDwpvgsKclSRKAy/mJzjY+DYg1SbgU2OfSlQNYO6bvuUTa1F/uxZsDuJcZnLY7Izx2MFG9shJoMd9UJ5tau9WDjzos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUQYB/jY; arc=pass smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-605a8c4ebc6so3041783137.2
        for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 09:59:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775581140; cv=none;
        d=google.com; s=arc-20240605;
        b=H+8YE/419UAX7SL/vAK8gai7OcIn/F8tUqkEFm5I18Eqx9T/BCvGsgp4D+sLuosLBm
         2EvUV4IVzY2jIqZ0Vyim43v5e6LoDjLtH7JuHwRWO6mJqbC1VxXnpOj1T06qgUDUm4aD
         1Q9G1j7bptC4Rbc36eP6j6Cw+GyBquUXuOTlAW/xfpKctm3tLv/Z2oDKhjCWt3wnDFa2
         FSMFGE3u7145flHwA2yxSAKOq+dv2i+qNYPBfk7FU8Ltmf/HjJosRYqEUUle03gbhvYt
         mZisFu2GczECEKPdvlIbv2lodhbbRgMmUKPwX3MKHz1d74IzsIs5DL+LvEu0DB6Q64kN
         bc+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zpGhqXfBdulE4mZnpZhuVgVxc6xmIgwZa9dFw+bhogo=;
        fh=z13KRDOBL26GXrXq9EJJjW8Udv+4Is3MOUPGIn9PAN4=;
        b=QHuqAaKIDKAVE5lEQxzJvG+d9M6Sfuuett2Kqyj2aki5KUwKfM4bNdurvXzuQNENlB
         oUZILCh/51KYtcszoq2pJ+Wu7+bolZFCbSQsokNeIzc3HiKbrtphaTgpRfdYqo8pU3LP
         4ooSKuzTu86VveP70IIrNkTiQnVoQ5DWgGHcMeJsdafys+g/pB46Ijg4/Y/y9lF3xkRs
         rVtHI1ssCMNR5OFIcVxmmpKkbcblPJwzMnffyn6xfi0bz98cvp4jEIigNMM7THKqRf32
         aUlHIFv2VpbfL59zazfKnU13UQpJ2uy1ddEeDhA42QL99TJ3RH5fM0Q0j9madRUYF2cg
         gNVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775581140; x=1776185940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpGhqXfBdulE4mZnpZhuVgVxc6xmIgwZa9dFw+bhogo=;
        b=ZUQYB/jYO+OzI12WDPzJUFt7jJZs6qMQTkwzA+RPqfM11NbDygfAUqROqnSywqfNDm
         4OY5hgvXM56v3upWt1bTnOHQDc5vfKmY3Mj2YyceA8LFjAl3KoLSUlTXFw7NAfU7E+pK
         4cGxMip4oz/qoRRAfDnlxwNnH4dzAwV6iI/7v+3PNy3k4W+DAomuZM0geZQiO8HknsVt
         +mGCtLg278P6jBB9TAS1+hs0r6Qq6i99cV9YP+TdTzzvfsKrRhjZ+E7HVyUE3t+zDAeM
         nmMyRZHjOnPyxBS4kuNpyHjSliEL8mYsFQ1yB/o7K06tSfZWTk0DLiAAyHuO6zvIoBGb
         qfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775581140; x=1776185940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zpGhqXfBdulE4mZnpZhuVgVxc6xmIgwZa9dFw+bhogo=;
        b=kUaoMuLrxs1FytwPJ79CujtyAGJoPJKqEWV1vv+xiWHZHtkiP9lXONnofJNgC5XusT
         K3eSnzqqlfFEN/LoBTa+1AGZ7q35Y6G71RvpSAloNfIBktMSAuoFZh2VSNT8eTlA/cO6
         J/x16lt69Ay6C8vnWSzG8j4WQPwju92h9+wHkUF+j+89sCw5Hrn4aDJnMXrxlxu3wN4c
         lUmM1P5vx84JdIM2qR+Yh6lCKc5c1tENYPdzB8G73k71TQ7sw5IcpUb03ZA0uGfJuwbH
         0NJ6R2a33ZwNJMQJcXf2EhvkYS+CuJvA2YvCqs5tJ44xyyroq7NyW/Hft2h/Qk3nF8wN
         pXrA==
X-Gm-Message-State: AOJu0YyWi/dR5pFhzQew1tz1NSVT0fFMWzcrFrP3d/ZwgNQGCa40QiuN
	2rOdUF2Rdzg4cu/SjN3siON7dj9dRaWSGH1bSolFtA5JNM18HnccZErCuSlpjGv2fWGpb8o2FTH
	TUTaqgcKtSLI/YoxPywsa8+KzWDmRew4=
X-Gm-Gg: AeBDietXLkzhKC5qZvY8Z+HzrHIYz5GbWQuV/H8EbfyT8XRqLXsrBh+Hx8rsOLevOb1
	SYjMRuxR05eXD79jRz/nlFN30lDZb7scJhbvFM0gl4Zo1XpJ7yCtStipEstZ1HSLsTdxjlI3/gI
	fj0a2n8F6LFpIH05UsGkKde8AyYRND8lfS2cld+t1EJduAihGeHc0lffYXllcnvtw3BT5H84Xl3
	At7HTMITu+5+smgelSNY8XfkdfSUYpAVScOWPML64M4+2PCBKw2qpwSwpz/wraMm5xr84Yuldpl
	N/qA1x37tzelXV38vy1XgnWCStgCU9oOi+yAgjA8
X-Received: by 2002:a05:6102:c02:b0:605:109e:a3d0 with SMTP id
 ada2fe7eead31-605a502d07dmr7189157137.22.1775581140562; Tue, 07 Apr 2026
 09:59:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260406234739.29926-1-joshuaklinesmith@gmail.com>
 <20260406234739.29926-5-joshuaklinesmith@gmail.com> <d4622e31-4012-4c05-9288-529b0bb0aebd@candelatech.com>
 <CANs=ypgdgB_3stm5bCvO8RTat-sxs0N6SAaeYSQ-dyq43U-ZBg@mail.gmail.com> <ddc4ccfe-27e0-7558-9b5b-27b4c4fe54b3@candelatech.com>
In-Reply-To: <ddc4ccfe-27e0-7558-9b5b-27b4c4fe54b3@candelatech.com>
From: Joshua Klinesmith <joshuaklinesmith@gmail.com>
Date: Tue, 7 Apr 2026 12:58:48 -0400
X-Gm-Features: AQROBzAC6bOHKKfWVRG9wTIWvucUZxOT13jtei-vp-8U2bQyptgRLlZFzZ2L7Do
Message-ID: <CANs=ypgceH4NL5xOr2C1FPp8KvDCcUWTu10i+DiXntuOmAfJVA@mail.gmail.com>
Subject: Re: [PATCH wireless 4/4] wifi: mt76: mt7925: fix RCPI chain 3 mask in
 sta_poll RSSI extraction
To: Ben Greear <greearb@candelatech.com>
Cc: linux-wireless@vger.kernel.org, nbd@nbd.name, lorenzo@kernel.org, 
	ryder.lee@mediatek.com, shayne.chen@mediatek.com, sean.wang@mediatek.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-34489-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuaklinesmith@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 12D1E3B2241
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/7/26 12:31, Ben Greear wrote:
> I am more concerned about the trickier patches that you have been posting
> that is utilizing work from upstream vendor code.  How much of that is pu=
re
> AI driven?  How much testing has been done to see if there are actual sta=
bility
> or performance improvements when testing actual hardware?

Hi Ben,

To be straightforward: my workflow involves pulling GitHub issues into
AI prompts along with firmware analysis tooling to identify potential
fixes. I have an MT6000 available, but I have not been doing thorough
on-hardware testing before submitting. That is a gap I need to close.

I will hold off on submitting further patches to the mt76 driver until
I have a proper test workflow in place and can verify changes on real
hardware.

I appreciate you raising this directly.

Joshua

On Tue, Apr 7, 2026 at 12:31=E2=80=AFPM Ben Greear <greearb@candelatech.com=
> wrote:
>
> On 4/7/26 09:00, Joshua Klinesmith wrote:
> > On 4/7/26 11:25, Ben Greear wrote:
> >> How much of this is AI driven?  As far as I know, mt7925 is a 2x2 chip=
set
> >> at max.  So while the patch may be correct, it may also not matter in =
practice
> >> and at least may not need to be backported into stable.
> >
> > Hi Ben,
> >
> > Please accept my apologies. You are correct that the mt7925 is a 2x2
> > chipset, so this does not have a practical impact and should not have
> > been tagged for stable. I did not read the documentation in its
> > entirety before submitting, and that is on me.
> >
> > I will be much more careful and diligent with testing and review going =
forward.
> >
> > Thanks for the feedback.
> >
> > Joshua
>
> I am more concerned about the trickier patches that you have been posting
> that is utilizing work from upstream vendor code.  How much of that is pu=
re
> AI driven?  How much testing has been done to see if there are actual sta=
bility
> or performance improvements when testing actual hardware?
>
> Thanks,
> Ben
>
> > On Tue, Apr 7, 2026 at 11:25=E2=80=AFAM Ben Greear <greearb@candelatech=
.com> wrote:
> >>
> >> On 4/6/26 16:47, Joshua Klinesmith wrote:
> >>> The fourth receive chain RCPI uses GENMASK(31, 14), an 18-bit mask
> >>> spanning bits 14-31. It should be GENMASK(31, 24), an 8-bit mask
> >>> for the fourth byte, consistent with the other three chains and
> >>> with the RCPI3 definitions used elsewhere in the driver
> >>> (MT_PRXV_RCPI3 and MT_TXS7_F0_RCPI_3 both use GENMASK(31, 24)).
> >>
> >> Hello Joshua,
> >>
> >> How much of this is AI driven?  As far as I know, mt7925 is a 2x2 chip=
set
> >> at max.  So while the patch may be correct, it may also not matter in =
practice
> >> and at least may not need to be backported into stable.  If it is a mi=
nor
> >> cleanup that doesn't actually matter, that should be described more cl=
early
> >> in the commit message?
> >>
> >> Some of your patches are touching tricky parts of the code and making
> >> subtle comparisons against how the vendor's driver is written.  How we=
ll has
> >> this been tested and reviewed by a knowledgeable human in general?
> >>
> >> Thanks,
> >> Ben
>
>
> --
> Ben Greear <greearb@candelatech.com>
> Candela Technologies Inc  http://www.candelatech.com
>
>

