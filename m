Return-Path: <linux-wireless+bounces-37907-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ykwULkp4NGr/YwYAu9opvQ
	(envelope-from <linux-wireless+bounces-37907-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 00:59:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 140116A3017
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 00:59:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="gJ68E4/t";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37907-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37907-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FDE73037403
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 22:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E5033F58C;
	Thu, 18 Jun 2026 22:59:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A14332916
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 22:59:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781823552; cv=pass; b=oz41BS70v6cfASmBXIigRiiX03n5goIvPSH95wG412zmOL2O0fZtXuaJgt3QLSAKkSIeN+Nzz5YGUEAhSVXbVlgHOUSBIEN3PYxbBkZ2c4pBe7EeSBahuQ81o5lm6A/TTL5rqVAEYXQ4eG7aCotbwagmjn+x1bOIoinGSOhk6OA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781823552; c=relaxed/simple;
	bh=9p8gcgR8GBWgnLx8YJ/TuQziZQS6ye/3fOxmY04nhAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JzoN0cgYwMtOrzJdcH3ftXPI0TAWDANhijHFxF1otoVVuij5coSVpaz8J5A1GLJvnp4F3clpdDdOvZl4Oa2gVew7Us1U09vtjk4rj2a57Zwrq/T7ObZ1kWeRKiC8pvtQMAtGL9tEsA+MJFu8vYqTGzjeP15YujD5KF4jdqYsvqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJ68E4/t; arc=pass smtp.client-ip=209.85.208.53
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-693c69b97e7so2379991a12.2
        for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 15:59:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781823549; cv=none;
        d=google.com; s=arc-20240605;
        b=dHtOFhWbxmtjVJtsRK7tT17wBu6tAwGL/gXE4LQRyvq5HDc4IGV6XKwEMzEZFtYHmc
         vUU6ZGfYvMqjpkm1u4OB4dND/2IxUdjfZjo8dT6xx/dYtSztIU0lGRvX6k33fDPFhvKz
         uoubjNyKEbJPVnOD8vHWgGTG36WMNCIl+MPsqIg/q+OHAvq9LH91rM3rZ+25/n00UuA8
         Ccy+H+zRILX4OJWFqDak9XhB94m1OVeVsuf/Bn+KwJco5gxmHEsLuxut5TNr3hTnHvtQ
         Bj4TkdnkYA5/Iu5ak7HMytU5sgg3i0kwWXc5Y4HXzui78uBkYfaxBk8t8fKLPRje0JrU
         s6IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1xgEvu8OVOefwOCHuciLIclIAnS8jpN4f6jMmcyMRu0=;
        fh=SvuI8bl0c0lD0aUxl1KKnL3hkvLCzUlgzJmOgbJUQRo=;
        b=Ts0rsfTM4WmqR0M58NywEf7JAkRF5Xvkyv2E6fhbE7JjjFF7f/bc3vsxZ0/f1f42Qg
         chjkCK6ZtFt+r6Xu/AHBAJ9geQjSOScvhePG/72HTs+cooGhEWsEYWt6DgfsW25Cw83z
         ly1ndo7mrrlOdRDazV+oiYHDE53gezNUPf9aVTnVGBWQCus0czoXCrRd4/jrzajwx3rZ
         5PotIINuwg25S7sFZI6JHzE2uNLAvV6VYFRoyadyRkXNLxIzbkpLvxQBBBNn3Qx2nMbQ
         2GXvSyH+hAwwZLwHgdFNuu/i1GHkXtlFKvH7dHj6RbUarsIohBBJNSqUniQ1h4Y1/L2z
         Xeeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781823549; x=1782428349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xgEvu8OVOefwOCHuciLIclIAnS8jpN4f6jMmcyMRu0=;
        b=gJ68E4/t7zRWgqmJd4nrgQL1LdEz+lTy29xIOi7RokGh7UGCeLJCLdyd3RKr0jmeqr
         yozSwlgyxV7RNFmrUYEsR4QvXcaEJA5sfX6i07XyHq0hUMQ6BfKhAMYzoKDW7UNdcZVr
         ZZeqhDWZIJVNpCJHHQjoaAzNWArbk6m316Vlhh3qSgVVOSZn7Eg4MCuCY/Fx6Tnh2JeC
         LxWjf1zQcqB4bFrmWqvoqqktCIhl7f2HpH7wbNGBv8w9RBaYH8axt5BJs9tbLZhdr5xH
         spHWFSO+e/JBn0whj7dN388z+hJaaLvlVYS9BgQ6jrt3b2czd+oHFq52cvyLWcA/Lf68
         8W7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781823549; x=1782428349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1xgEvu8OVOefwOCHuciLIclIAnS8jpN4f6jMmcyMRu0=;
        b=YhpmQ7I8h2oFIH+9CAtKGaVV/K6mQd2IS1bUwC6IsIFu+UAuo1pLvAOJrx0RPMoWwC
         LxmUJ4rU77Hj+PmAYRpCE0EBYIUURwhyT3Gz5Wwar/po0EswDiCNl/pQGPP1p9eVUSuN
         V9BBiaHn1D5oUxTV7dkUoTHMQ4rOBjb21pYxIIHri9sgvwePv8PNhJxbC6zG5IjvwEKE
         Uylsszw19iIYejxZ7fr96Qb5Wc0uhdnBbJmq1MYkk4qTSUZtBYi6BMQOReZoQK7dshD+
         08WSzDmBx0mucl5uE4IQzQ9FuVo3myK99d5WNT3Xh7m4fvofeM7FGZ+AI1hEMhnh79zP
         cQDg==
X-Gm-Message-State: AOJu0YzYq3DW/iL+yoLihv1gOzPHjTTtz9/a2nqqVbxpk0Y0GXV6MWAo
	JLZxww5m6Wiky3wXPbQMMvsCe/YlmeLyGScvvUpgdHncYPBjPrFFgLmhIsW6gUD6W/yXI5BhdFU
	P3r7y1OVReKC2jBttfZfVMpY8TpA+s9ZRGg==
X-Gm-Gg: AfdE7cnL/51U+L967B+FeHkzXSIlUbeQkGQWcCfblMU7QGqNyZp6UqnbEnpi1SM/cN2
	tzWYYZN3br0b/iLLlx6C+Udg1axzhXXU4ZY6uraLRIvVWyvMiB/5HelLs7zOeAPsdqRiDpKzFPC
	sBMK8PsUprV8fQq6XW/wO0oeAn43datpmUlZTjNrBjzuojXt0X9pNFFuA4F0X/57bmTiqX/OuuC
	f48mnh1cdxiShggG+IWKwZZ/Ew4L8fN/hMauVKD7VY6yTr4SJ1350zvBgW5JJr3kfqkX+/xt8dv
	erQf9iKyxZIqELLRVHTS6e3abseIB1RBxE1iOjbLDQRG7xzgqUvzx2tyQgPrIz8DXeHfnm9tbA9
	xstMvQbC8grhYV4XNGMx7GEhyPcWrNco6zkIFN/YKhqvJvBNwZUY3ISOhOw==
X-Received: by 2002:a05:6402:2690:b0:68b:ba5c:4951 with SMTP id
 4fb4d7f45d1cf-69711e02bffmr610981a12.23.1781823549035; Thu, 18 Jun 2026
 15:59:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616030652.635121-1-rosenp@gmail.com> <9c08b419-7180-4ecf-8a9d-026a80cbb98a@oss.qualcomm.com>
In-Reply-To: <9c08b419-7180-4ecf-8a9d-026a80cbb98a@oss.qualcomm.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 18 Jun 2026 15:58:57 -0700
X-Gm-Features: AVVi8CcRY0P6xguyUa8FMopHg8XDB6Lib6pakqrO7PU7HAVKNlAlVwEg1bxE22g
Message-ID: <CAKxU2N-TWwn4mXLcTxYR7Uth2ve_J-uWrWLZSSY6YBG1FuqzYg@mail.gmail.com>
Subject: Re: [PATCH ath-next] wifi: ath9k: mark PN9Data as const
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:jeff.johnson@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,m:toke@toke.dk,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37907-lists,linux-wireless=lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,mail.gmail.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 140116A3017

On Thu, Jun 18, 2026 at 2:55=E2=80=AFPM Jeff Johnson
<jeff.johnson@oss.qualcomm.com> wrote:
>
> On 6/15/2026 8:06 PM, Rosen Penev wrote:
> > PN9Data is a read-only lookup table and is never modified.  Adding cons=
t
> > lets the compiler place it in .rodata and prevents accidental writes.
> >
> > Assisted-by: opencode:big-pickle
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/net/wireless/ath/ath9k/tx99.c | 16 ++++++++--------
> >  drivers/net/wireless/ath/ath9k/xmit.c |  2 +-
> >  2 files changed, 9 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/net/wireless/ath/ath9k/tx99.c b/drivers/net/wirele=
ss/ath/ath9k/tx99.c
> > index f2144fd39093..b52d84f6cbc9 100644
> > --- a/drivers/net/wireless/ath/ath9k/tx99.c
> > +++ b/drivers/net/wireless/ath/ath9k/tx99.c
> > @@ -39,14 +39,14 @@ static void ath9k_tx99_stop(struct ath_softc *sc)
> >
> >  static struct sk_buff *ath9k_build_tx99_skb(struct ath_softc *sc)
> >  {
> > -     static u8 PN9Data[] =3D {0xff, 0x87, 0xb8, 0x59, 0xb7, 0xa1, 0xcc=
, 0x24,
> > -                            0x57, 0x5e, 0x4b, 0x9c, 0x0e, 0xe9, 0xea, =
0x50,
> > -                            0x2a, 0xbe, 0xb4, 0x1b, 0xb6, 0xb0, 0x5d, =
0xf1,
> > -                            0xe6, 0x9a, 0xe3, 0x45, 0xfd, 0x2c, 0x53, =
0x18,
> > -                            0x0c, 0xca, 0xc9, 0xfb, 0x49, 0x37, 0xe5, =
0xa8,
> > -                            0x51, 0x3b, 0x2f, 0x61, 0xaa, 0x72, 0x18, =
0x84,
> > -                            0x02, 0x23, 0x23, 0xab, 0x63, 0x89, 0x51, =
0xb3,
> > -                            0xe7, 0x8b, 0x72, 0x90, 0x4c, 0xe8, 0xfb, =
0xc0};
> > +     static const u8 PN9Data[] =3D {0xff, 0x87, 0xb8, 0x59, 0xb7, 0xa1=
, 0xcc, 0x24,
> > +                                  0x57, 0x5e, 0x4b, 0x9c, 0x0e, 0xe9, =
0xea, 0x50,
> > +                                  0x2a, 0xbe, 0xb4, 0x1b, 0xb6, 0xb0, =
0x5d, 0xf1,
> > +                                  0xe6, 0x9a, 0xe3, 0x45, 0xfd, 0x2c, =
0x53, 0x18,
> > +                                  0x0c, 0xca, 0xc9, 0xfb, 0x49, 0x37, =
0xe5, 0xa8,
> > +                                  0x51, 0x3b, 0x2f, 0x61, 0xaa, 0x72, =
0x18, 0x84,
> > +                                  0x02, 0x23, 0x23, 0xab, 0x63, 0x89, =
0x51, 0xb3,
> > +                                  0xe7, 0x8b, 0x72, 0x90, 0x4c, 0xe8, =
0xfb, 0xc0};
> >       u32 len =3D 1200;
> >       struct ieee80211_tx_rate *rate;
> >       struct ieee80211_hw *hw =3D sc->hw;
> > diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wirele=
ss/ath/ath9k/xmit.c
> > index 89d8b3178784..57e451548958 100644
> > --- a/drivers/net/wireless/ath/ath9k/xmit.c
> > +++ b/drivers/net/wireless/ath/ath9k/xmit.c
> > @@ -41,7 +41,7 @@
> >  #define ATH9K_PWRTBL_11NG_HT_SHIFT      12
> >
> >
> > -static u16 bits_per_symbol[][2] =3D {
> > +static const u16 bits_per_symbol[][2] =3D {
>
> unrelated change not mentioned in the commit text?
Yeah. Will do in v2.
>
> >       /* 20MHz 40MHz */
> >       {    26,   54 },     /*  0: BPSK */
> >       {    52,  108 },     /*  1: QPSK 1/2 */
> > --
> > 2.54.0
>

