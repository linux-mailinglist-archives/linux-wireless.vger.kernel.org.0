Return-Path: <linux-wireless+bounces-32070-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOMBBB7TmGmuNAMAu9opvQ
	(envelope-from <linux-wireless+bounces-32070-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 22:33:18 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0A116B01B
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 22:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B7AD3300442A
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 21:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B190030EF92;
	Fri, 20 Feb 2026 21:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzbJSsp1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4563B296BC1
	for <linux-wireless@vger.kernel.org>; Fri, 20 Feb 2026 21:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771623190; cv=pass; b=My5HM2mt/gp4P/AGA5EkLfprdrBUMZ2sXS/KM8v/3BaZCaqnatCmSHVUX+TeVQ9azTZQvFrL7dMeoIhL+DDAcCadszfPzP3wS5W08NeGR7aKdwpG9+YDL2D6QaBBpSm+I/sqFgcUeYg/KyR1Ll4Xfu50Fobgq6N/b6j5fQ78DE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771623190; c=relaxed/simple;
	bh=YqvdFNKbeLUnJ6eLeaUCQ0ji9cFGHJABd9RSH/KlFpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JKHNHIuXWXO6iJM5qh4W00ipqMA3ha6Ph0f0bTu8dsipw68a/W3QoDuUs6XEj9ukB6m7Hpmg2iSkgZ+KmszK3kGbB6l47fMZ95SNAkpA+CBfUoxElQmo6yUfGxBnka6Pi8GblJTinnwol/KxO0IdpXs/BeMrjmlNUWzo1BKvQpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzbJSsp1; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-65a40f3f048so4616021a12.3
        for <linux-wireless@vger.kernel.org>; Fri, 20 Feb 2026 13:33:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771623187; cv=none;
        d=google.com; s=arc-20240605;
        b=G0VC4XyOFtTriqIDpFwRQVBSvpIp1BG/k7z2wEUbJA7Em6ai0+9nh6juPGbaUG0+0/
         86ZMO/8rqgpEIueATpqOJEvn0c+gDhhcWG4wq6JgTcExdc7URMFKghIfEuNk+339Jzp7
         iC5fq3DEFTykGY7kP3gp52tT8f27g281YB2YjerRhHzIoFHuVwNlH3oUJ78U4culv9G1
         pjIbUglvob3r2kwCm8cEFM17LdpV75McPOeS2Vz0PJaRvY32eIR+W03DC71aK3ZMHH56
         IVXoFVaMfz9ieDclvhrk7rkzlO754sXcU+Gn164oUUaFgh/WW+Rv2N8z9EGNsCW32MMi
         hd7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6OV7LemBquxu4QQBWKkZoCizYdEzuuWnP3GrsdQObEM=;
        fh=C5sWzTxBEKYY/LVoEe/NunCantQBIv61beLmSuCbQmg=;
        b=D9BtCyobsJhwl7g/NoLe/J1Qse9Ubqznmtbh33vvzxRAPV1oURdHaVLvudDa6A5Y3P
         50/GgyQcLERw6jMr3gXEvKz7MIFkivpx1waXon2arMRuOnhx6ZxVSAizHPWVhkxAeeGl
         vl9xKbGS3Ze1qkGYd8Yqt+ygJyUHw7BoYiyw19lIoQ0m30bJ8l5fkt/Ewkmg5M3RzhQv
         4Ax2MemT0NsT4R2SSUOEhHBJ8TAR7Mx1vx0dBsDPrAYfSrN3P795UjKFoOgmooGdG0DA
         arum2CyVOHtCmY3jTLYYuhnHT6T3sAXXi0WLvl/7LVpy6FhDJCm1KYvSle7S/2h8G2ql
         /1qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771623187; x=1772227987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6OV7LemBquxu4QQBWKkZoCizYdEzuuWnP3GrsdQObEM=;
        b=dzbJSsp1GcKw5uxLJ+FtVQEvVYLibr43606Aknmzjxk8JctFfF0n8e7u0soOW+stEf
         34Spvpo1xsgWbOwGAmq8jjR+vH0YBV/scqJPpj9qA6WnUPsWhWIkXRGInLGmMe+sTe4P
         kdz9GQD0KABeAhQ2ncZgLIO/GDYuVAdBpXzHfTFbKCzTlZnPlfPlMUZwQifnZ6vGR5pj
         8pklqXt/jj3QyeLoqpjL6awBu1bWiAzGfSkam0fD3CY2i6wpGBgLdYzUqgBjHwxl7gWF
         /IIslqyjtVnKXr9VsTcRekm0qpsleU14sE8ZdZU8tsknElq11hkorQq5htCFZRgX/FFs
         3i+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771623187; x=1772227987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6OV7LemBquxu4QQBWKkZoCizYdEzuuWnP3GrsdQObEM=;
        b=WOBrSwYcecpuQiGt7FsLjfd0N+sUGcqbUkRCYgd+NTd6DCSPF5YUFKnayd6thUm0Xs
         u0QSuW7mYUnqS54uJFMJaGQgGeK9KhdancEwkE+JyzwfS2J3khVrMnAZeJX5y1O/pwf4
         HuJ7PWRrwdyun9vmGm68gzNONAAcUCYNH2nNHvyhVgA+wQjgfIJF50uVrdGpyLQ8l0OP
         P2G70seil4qe5gAIEMQ9JoSkPex5c5OXBpwFUwwZQaKrQvjC9yB8l1M/GW0zM8T381xq
         ubrLco2NsB3q4rIw+1ksfqMHoM/bS4WjCSkGnuGEHy9WvX8sch15IJT76crAKoQultqA
         b+EQ==
X-Gm-Message-State: AOJu0YwwwxcYL5m9dHlvKads+yy0geTNXY5TF/Twt/vi1H0+LcDTNNuK
	/aEJiZ0o15Hhof2quAHMjXmJK5Dn1VIFVzOIrWxEs18783sddoM7O73mvd4NWUHuZPg0cp7aKNX
	ASi8cA/u2j2yS3ju/nD6IS3sfqd+WRtE=
X-Gm-Gg: AZuq6aLvndwiFOgpgOj9xlgoVh4690VlHTQg7uaES6FLRr9dKyxXaDP5FEQ924OYl6h
	g0X0ECkS1n9CfK4e25PB3g5SldOEKGf+usEfS/Iv+MXLtOPciG+eM6v3QzwpMpLN8aK/Tl+poQ2
	CdtHcIG4FV+GXR7F6EDsjAjCRiCOOSZyZ71sUguvOucenglMmBSj80Vfx7+MCZCZQca9eaExeSA
	SiFSdhk9xx8ytdGxedC95G5yq8ui9fCiNuqBo02e5jxJoiAeE5iP3PAhsxQ6BFFcnuB2HDV7D6t
	zx9dD693X6T3Acb/Pnb9
X-Received: by 2002:a17:906:f049:b0:b8e:9e11:6615 with SMTP id
 a640c23a62f3a-b9081bbdee5mr56258466b.47.1771623187132; Fri, 20 Feb 2026
 13:33:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220020908.40115-1-rosenp@gmail.com> <20260220103739.GA20961@wp.pl>
In-Reply-To: <20260220103739.GA20961@wp.pl>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 20 Feb 2026 13:32:55 -0800
X-Gm-Features: AaiRm512NQOGCzQTBndqb3gmKlyAeXkrNIOih903Sq3746BZEcfZ8zp4PRt41yc
Message-ID: <CAKxU2N9teQSu+JTszxo_jbaYwfOT63513DziRq0X8KNkVj_jqw@mail.gmail.com>
Subject: Re: [PATCH] wifi: rt2x00: use non of nvmem_cell_get
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-wireless@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32070-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[wp.pl];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,wp.pl:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2F0A116B01B
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 2:37=E2=80=AFAM Stanislaw Gruszka <stf_xl@wp.pl> wr=
ote:
>
> On Thu, Feb 19, 2026 at 06:09:08PM -0800, Rosen Penev wrote:
> > The library doesn't necessarily depend on OF. This codepath is used by
> > both soc (OF only) and pci (no such requirement). After this, the only
> > of specific function is of_get_mac_address, which is needed for nvmem.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
>
> > ---
> >  drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/n=
et/wireless/ralink/rt2x00/rt2800lib.c
> > index 65d0f805459c..93e4ce604171 100644
> > --- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> > +++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> > @@ -10965,13 +10965,13 @@ EXPORT_SYMBOL_GPL(rt2800_read_eeprom_efuse);
> >
> >  int rt2800_read_eeprom_nvmem(struct rt2x00_dev *rt2x00dev)
> >  {
> > -     struct device_node *np =3D rt2x00dev->dev->of_node;
> > +     struct device *dev =3D rt2x00dev->dev;
> >       unsigned int len =3D rt2x00dev->ops->eeprom_size;
> >       struct nvmem_cell *cell;
> >       const void *data;
> >       size_t retlen;
> >
> > -     cell =3D of_nvmem_cell_get(np, "eeprom");
> > +     cell =3D nvmem_cell_get(dev, "eeprom");
most usages of nvmem_cell_get in wireless use devm instead. Seems
pointless to extend the lifetime of cell until removal but what do I
know...
> >       if (IS_ERR(cell))
> >               return PTR_ERR(cell);
> >
> > --
> > 2.53.0
> >

