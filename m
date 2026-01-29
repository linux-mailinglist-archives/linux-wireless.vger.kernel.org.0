Return-Path: <linux-wireless+bounces-31291-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id FxMADIX6emlSAQIAu9opvQ
	(envelope-from <linux-wireless+bounces-31291-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 07:13:25 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC9DAC2A6
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 07:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 616CA3008A69
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 06:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3230368275;
	Thu, 29 Jan 2026 06:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0406ziM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0C7352923
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 06:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769667201; cv=none; b=FBUHmjifJXBmtUKL2w8h00RRUWEb+yACiCrQvU/RtC7Cd+Iv/cFz7bcypEnaBm8gfBOlLBvN+XaKyIWzCq0I0n4PoK2XT80JW24ISYht+qwF7rxOiWE+2ZQz5M6NtvXr8GGNU3lYoU5JK0tCz52u3kwPoJhZ0ykc1JfayZWYxh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769667201; c=relaxed/simple;
	bh=BFbjrLJ/PTbN1EwdFqpx7TU5Rs4CEN760xmvAW7LfoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Csp4/K7d7Lqyzw8ukA6vXjPTGXyF1R5KHZsPViSjd4G6mWkRj+gCCm9rSnjKbwndvqUxmyWmfFGnT/b3wKpsspdX7c807BsrrOgFnJ63XkI8T0QPlkRGxN+HvTYBPKC2OLYIahr8ubm+K7SsEwDqkn3lPe1ePIvvtiBGJhJwZjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0406ziM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5D1C19425
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 06:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769667201;
	bh=BFbjrLJ/PTbN1EwdFqpx7TU5Rs4CEN760xmvAW7LfoY=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=K0406ziMm41sPKGR7QIFzk3a0dYiPlMQEpL+IY3/oGKhkEMD6nil35UXu8y6IoL+C
	 pqOVIEDL4yv3xhbi4CdHvO6r8ANKQKOm6lIcN7e0YuKCxbg87KOIixZwf+xWMgBSbf
	 ycUhH/0VjcOEja2eo6BNM6DI7HICP2rzkO0FBhbGL04xlQWCaIxRv/QwRT2WmbfVLm
	 dxrbafVWIXn9nDx7Gx44oWg+xF/+Djfqv4hrjiTFmLK/W8eFXCxxFzffuEwan4zrV5
	 BDXF3pqzgDz6Y6WelmGQj0toRMGuHvDDUFb62wzWyd+MkIQCtv8YZodCtkYkFQQJTG
	 9uZ8a2h6KbvNg==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-382fb535b73so5149281fa.0
        for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 22:13:21 -0800 (PST)
X-Gm-Message-State: AOJu0YzE9nrCr0dWV8RvFKsWgOzLL3Df8/cuxSEhMz6nTZ1Dk3jJSisE
	imMVPTG9UjphW2QrJUIg0Hl8ct9rUMt4S7T6e2HP3zOF1nY5qu27XPPKbdrhEkdK6RGsttnPz9H
	EkicIMpDkUB0zzksHinQjzynPGYWDLEM=
X-Received: by 2002:a05:6512:4019:b0:59c:b91d:3a56 with SMTP id
 2adb3069b0e04-59e04013e12mr2740311e87.2.1769667199411; Wed, 28 Jan 2026
 22:13:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128102525.872517-1-gaurav.kansal@nic.in> <CAHrRpuk7Xqab+BC57m_5KWJVr8rc+_LHWwKr-pWmvR3y9W2ghA@mail.gmail.com>
In-Reply-To: <CAHrRpuk7Xqab+BC57m_5KWJVr8rc+_LHWwKr-pWmvR3y9W2ghA@mail.gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Thu, 29 Jan 2026 14:13:07 +0800
X-Gmail-Original-Message-ID: <CAGb2v64jhYNkf_O-mkhcE3=zpvpDG7C54WJEDfn1sKM1hB9GFw@mail.gmail.com>
X-Gm-Features: AZwV_QiVnR2uKuydYO8raxzfaSV1FXqRXAOJyIHTjzFjWAV068fe-Hz3dhHQoLE
Message-ID: <CAGb2v64jhYNkf_O-mkhcE3=zpvpDG7C54WJEDfn1sKM1hB9GFw@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: add IN rules for lower 6 GHz (5925-6425
 MHz) LPI and VLP
To: gaurav.kansal@nic.in
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org, 
	Ping-Ke Shih <pkshih@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-31291-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[wens@kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wens@kernel.org,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wikipedia.org:url,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gauravkansal.in:url,nic.in:email,dot.gov.in:url,cra.ir:url]
X-Rspamd-Queue-Id: 6CC9DAC2A6
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 10:10=E2=80=AFAM Ping-Ke Shih <pkshih@gmail.com> wr=
ote:
>
> <gaurav.kansal@nic.in> wrote=EF=BC=9A
> >
> > From: Gaurav Kansal <gaurav.kansal@nic.in>
> >
> >     DoT / Gazette notification (20 Jan 2026) delicensed lower 6 GHz (59=
25-6425 MHz).
> >     Add rules for:
> >      - Low Power Indoor (LPI) 5925-6425 MHz, up to 1000 mW (30 dBm) EIR=
P, NO-OUTDOOR
> >      - Very Low Power (VLP) 5925-6425 MHz, up to 25 mW (14 dBm) EIRP
> >
> >     References:
> >      - DoT / Gazette notification (Jan 20, 2026)
> >        https://blog.gauravkansal.in/2026/01/Gazette%20on%20the%20Use%20=
of%20Low%20Power%20and%20Very%20Low%20Power%20Wireless%20Access%20System%20=
in%20Lower%206%20GHz%20band%20-%202026.pdf
>
> Is it possible to tag original official link?
>
> >        https://blog.gauravkansal.in/2026/01/Opening-India-Lower-6-GHz-B=
and-for-Wireless-Use:-A-Strategic-Regulatory-Landmark.html
> >        https://en.wikipedia.org/w/index.php?title=3DList_of_WLAN_channe=
ls#India_2
> >      - Linux wireless-regdb db.txt format docs
> >     Signed-off-by: Gaurav Kansal gaurav.kansal@nic.in

Somehow your commit message is indented.

Please have an empty line before the Signed-off-by.

> > ---
> >  db.txt | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/db.txt b/db.txt
> > index dc72989..0f90f6e 100644
> > --- a/db.txt
> > +++ b/db.txt
> > @@ -974,12 +974,20 @@ country IL: DFS-ETSI
> >  # Source:
> >  # https://dot.gov.in/spectrummanagement/delicensing-24-24835-ghz-band-=
gsr-45-e-5150-5350-ghz-gsr-46-e-and-5725-5875-ghz
> >  # https://dot.gov.in/spectrummanagement/license-exemption-5-ghz-gsr-10=
48e-dated-22102018
> > +# Info about 6 GHz added by Gaurav Kansal (gaurav.kansal@nic.in)
> > +# Lower 6 GHz delicensed for India: 5925-6425 MHz (on 21.Jan.2026)
> > +# LPI: Low Power Indoor (indoor only) =E2=80=94 1000 mW =3D 30 dBm EIR=
P
> > +# VLP: Very Low Power (outdoor allowed at very low EIRP) =E2=80=94 25 =
mW =3D 14 dBm EIRP
> > +# https://blog.gauravkansal.in/2026/01/Opening-India-Lower-6-GHz-Band-=
for-Wireless-Use:-A-Strategic-Regulatory-Landmark.html
> > +# https://blog.gauravkansal.in/2026/01/Gazette%20on%20the%20Use%20of%2=
0Low%20Power%20and%20Very%20Low%20Power%20Wireless%20Access%20System%20in%2=
0Lower%206%20GHz%20band%20-%202026.pdf
> >  country IN:
> >         (2402 - 2482 @ 40), (30)
> >         (5150 - 5250 @ 80), (30)
> >         (5250 - 5350 @ 80), (24), DFS
> >         (5470 - 5725 @ 160), (24), DFS
> >         (5725 - 5875 @ 80), (30)
> > +       (5925 - 6425 @ 320), (1000 mW), NO-OUTDOOR, AUTO-BW
>
> I'd prefer in unit of dBm as [1].

Please stick with what the official document uses.

> I think no need AUTO-BW that is to merge adjacent rules to have large ban=
dwidth.
>
> > +        (5925 - 6425 @ 320), (25 mW), AUTO-BW
>
> Use tab as indent instead.
>
> I'm not aware we can possibly have two entries with the same frequency ra=
nge,
> and I only added one entry for indoor (or no indoor/outdoor restriction) =
before.
> Checking freq_reg_info_regd(), I think only first matched entry is adopte=
d, but
> no error to build reg-db by 'make'.

That's my impression as well. Linux cannot handle two rules for the same
band. Only one is ever used.


ChenYu

> >
> >  # Source:
> >  # https://asnad.cra.ir/fa/Public/Documents/Details/73af8590-f065-eb11-=
968f-0050569b0899
> > --
> > 2.47.3
> >
> >

