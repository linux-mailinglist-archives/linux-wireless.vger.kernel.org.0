Return-Path: <linux-wireless+bounces-34911-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kM5WDt104WkCtgAAu9opvQ
	(envelope-from <linux-wireless+bounces-34911-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 01:46:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DF4415B67
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 01:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29D5530B2AA8
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 23:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1CC3932FC;
	Thu, 16 Apr 2026 23:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8Din40l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B53383C84
	for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 23:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776382941; cv=pass; b=R6+97457sDmZFEAjCIbQIePsDiIr1H2ZT2XpdQy3YidY5O72EXMGC+nFrIiSPe6L0xDJhLGv608bKw5YfeMX0O4LmB8h7MU3outisC2xMdoTphsyWsIls0jYP91Wbaql5pQvEKt3duvmd4wKPJ2ieOu88UsFugftCYjcjIy8CMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776382941; c=relaxed/simple;
	bh=A0XcEWMIzQEfEk4y5kf7wT/V9G3+KTqPX97NWZPNeVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q2LJd1hzvISQODVIuqgt6Ol/mHvatuzuF9ajF+b/49unQW87q9Y7zQPt5CaZgYSnkBLsRoLvWDctjNymVgSFOH/6J1dM4f6cdBAWrsZ6aUe4gY+z16+Htiq9lCxmR0BZLR89gJXcp+8DuE1YgDGwg+iHFEtF31hSlhexctH5wK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8Din40l; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b9c3e2cf3c0so19844666b.1
        for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 16:42:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776382939; cv=none;
        d=google.com; s=arc-20240605;
        b=CxJCxEUkMbBagCzOMNU6fY/YcjRK8s20D0B/sc8n15szjORwaRIYCWSOf68XNnGgf8
         6SLy2UC+DqEEn3qbLvBJJDlb/kGUnZg8RkvEBJKFK4x7CZQ4fWxpCQ9vqDzlM+LuayR3
         VIj3qMBOIIF2eobTvVKay1CVClNebSsQf5qWvyFzX481U0OQGovitMm4k9qG1bX3wluC
         B13AOBhyby/E+6LT9u+N7cz4V03IryvVHnhBUHolNlQ7cPMaR3FQKk7o9Tw+A32tpi3Y
         S5F6tagB25/5/sGPgyU9vetgqc6Tk6s7PyZXLoKGBh6AVCgZpjqQCNSgI8s5FOFQVdeN
         HaUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nse/DWwNbpa4wmBINJ6dgJECI+vb1SIXvoEai89q45c=;
        fh=SvuI8bl0c0lD0aUxl1KKnL3hkvLCzUlgzJmOgbJUQRo=;
        b=O+h/aSeQSQ+0FFOLC++B3XORMYbSUoGU/1doU/bB52TYJjT4dd2QnauSwUeKVY3W+j
         Lk3S+7Qwc38PRcI2wE69uTtFdwy3ayqqh6RT9PM5OYoIwbO3tYA8OeQCAfGctZdgkdpG
         3BBv7oK7L0fejSx4L0pEpf4iAKvT5HfvVFALvvPcNNn4dTofHpVn4IJNZYuk/F9u+GKC
         235J1r2IidDEDtHm1BRK42h+V+KUWJl0hKuYWYrHc+gvSMT7INBzc6PuXJY7mDvVuU8P
         aGnzIJqRnugcySNpYiI5e3/KxYXzOtwAwuiAla9ko5VbtZKp/rhjNnrB4m30GCQFjddl
         JimQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776382939; x=1776987739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nse/DWwNbpa4wmBINJ6dgJECI+vb1SIXvoEai89q45c=;
        b=K8Din40lMdvNJBizJNNk/NqquM9Cf2zjuh56JsQowwJRCbzaqe2OMw5Vk6oHWBXvHf
         MRs5ciMhDwT4hymW4FDkrwXUi2TmAoBoylN2viYK6rp7EvPK3mp6mtBtXclc9kpee/9j
         a0KmyylhAJNbJXixpU2y74YnTW5KDGS5fae2btZu4D2HMCX7KA7ngm/PEw1uyrZ2HsgZ
         hqv2KvAU2fuAlKYtgRqgYBrH8SXHtfddMMqINLn7CPn53uyiXg8sIXoA9JOymnadRgOL
         NyjJg5+yaOogC770TQ81h5LMtlejGbJTMImkfJsQZjEblWFVzQNXo72ezEcIgYhZjoX0
         +iBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776382939; x=1776987739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nse/DWwNbpa4wmBINJ6dgJECI+vb1SIXvoEai89q45c=;
        b=EmFD9Lr1RUq/WYJfmE4l9HxcbKZGZblyJfMD5rcEGyZPuPzg9np3htnaUHiwoZH9Bt
         ebCG7nSASMrDELghWJH4WRIyVGd82GD064lYhSXM11TiBfCEaqt1s/j46GCUpZC7d6hj
         sgfXTxKt4RPbfGUu5OneB/WWTeYagmFMdmtMPHoEOT3QGZg6S5naC3RkRPnl6aW5pYRh
         +hjsF99LrGOxKdgNdkHI7Vg23cI/19z6DSVhw63++Zepdrbjq/85odd2uOh+LDppfxEb
         lKCm2FZculnFBe+kxQj0SM5pp5wt2oT+FsBIa0kBShUpiv/6yMWDQH2V+JQxd07jcDKX
         JUAw==
X-Gm-Message-State: AOJu0YyUnH6hKEWdIEkysLBKYu/AmFUuO1mxwZAC5PzoVzSrZSbPIqEr
	NPU/Bl+SPYRC3doQqA2J7oPe1w0RBxbPs44erM8v6gwknKImsRLKfT+sRTWyjqii1o/kzZfSPH7
	/9Wact875zCwl5UqpnCqKHAhmjXrnQX0=
X-Gm-Gg: AeBDievVwFRi+66OVV8ZEOIKHQmIAEW3uEp/4XfUBYIGwbKiKmhcdyUPCxDqeenuy6O
	tx/vnywF7f1JoBG/pBro6tNPQvqY8uFe4ei322CGHf23dI/qbH2/xoStNnN5XoPY0HxOkQRaxI3
	TX1SjZktdQlr5QTLt8oqH4P9vRQAW9vG9lcG5zXMbJp5mRNwWATjRBL4ggSQyFcM8YnYx04FMfs
	bzkN0DxI6x/X3sstx5o6T1OuUVTljet4fHyYq6N7Ti0174WuDXoxA35KyfgGbX7mCjc7B1oMKOn
	Ea+8Vhf0GeNby8EEMbbRUZ3b5Ejq6QaU5NSHmVr2KXvDDo4lA10rKrwmzYU3mJuB56BE19JNyHL
	JDLgxum1XuIVFk+b9
X-Received: by 2002:a17:907:c912:b0:b96:e0b1:ccf4 with SMTP id
 a640c23a62f3a-ba41ac028d9mr17076466b.47.1776382938476; Thu, 16 Apr 2026
 16:42:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223224445.27352-1-rosenp@gmail.com> <2e123142-b931-45e1-98e4-dc7283266d10@oss.qualcomm.com>
In-Reply-To: <2e123142-b931-45e1-98e4-dc7283266d10@oss.qualcomm.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 16 Apr 2026 16:42:06 -0700
X-Gm-Features: AQROBzDDi8LcfW21Rw4IKSuZ0QSIKQkhrC5N6EM3nVnwosAI7aGOsPedN6B42U0
Message-ID: <CAKxU2N_jjaO9_+795za5Qt8FxkO_sSdbEUPjeBEvFKwuAH+3Lw@mail.gmail.com>
Subject: Re: [PATCH ath-next] wifi: ath9k: use kmemdup and kcalloc
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34911-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 90DF4415B67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 4:09=E2=80=AFPM Jeff Johnson
<jeff.johnson@oss.qualcomm.com> wrote:
>
> On 2/23/2026 2:44 PM, Rosen Penev wrote:
> > Simplifies the code slightly by removing temporary variables.
> > multiplication overflow is also gained for free.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/net/wireless/ath/ath9k/ar9002_hw.c   | 6 +++---
> >  drivers/net/wireless/ath/ath9k/common-init.c | 8 ++------
> >  drivers/net/wireless/ath/ath9k/init.c        | 8 +++-----
> >  drivers/net/wireless/ath/ath9k/recv.c        | 4 +---
> >  4 files changed, 9 insertions(+), 17 deletions(-)
> >
> ...
> > diff --git a/drivers/net/wireless/ath/ath9k/init.c b/drivers/net/wirele=
ss/ath/ath9k/init.c
> > index b52ddb237dcf..e52775dda6a7 100644
> > --- a/drivers/net/wireless/ath/ath9k/init.c
> > +++ b/drivers/net/wireless/ath/ath9k/init.c
> > @@ -297,7 +297,7 @@ int ath_descdma_setup(struct ath_softc *sc, struct =
ath_descdma *dd,
> >  {
> >       struct ath_common *common =3D ath9k_hw_common(sc->sc_ah);
> >       u8 *ds;
> > -     int i, bsize, desc_len;
> > +     int i, desc_len;
> >
> >       ath_dbg(common, CONFIG, "%s DMA: %u buffers %u desc/buf\n",
> >               name, nbuf, ndesc);
> > @@ -351,8 +351,7 @@ int ath_descdma_setup(struct ath_softc *sc, struct =
ath_descdma *dd,
> >       if (is_tx) {
> >               struct ath_buf *bf;
> >
> > -             bsize =3D sizeof(struct ath_buf) * nbuf;
> > -             bf =3D devm_kzalloc(sc->dev, bsize, GFP_KERNEL);
> > +             bf =3D devm_kcalloc(sc->dev, sizeof(*bf), nbuf, GFP_KERNE=
L);
> >               if (!bf)
> >                       return -ENOMEM;
> >
> > @@ -382,8 +381,7 @@ int ath_descdma_setup(struct ath_softc *sc, struct =
ath_descdma *dd,
> >       } else {
> >               struct ath_rxbuf *bf;
> >
> > -             bsize =3D sizeof(struct ath_rxbuf) * nbuf;
> > -             bf =3D devm_kzalloc(sc->dev, bsize, GFP_KERNEL);
> > +             bf =3D devm_kcalloc(sc->dev, sizeof(struct ath_rxbuf), nb=
uf, GFP_KERNEL);
>
> use sizeof(*bf) here as well?
> If so, I can fix this in my pending branch
Sure
>
> >               if (!bf)
> >                       return -ENOMEM;
> >
> > diff --git a/drivers/net/wireless/ath/ath9k/recv.c b/drivers/net/wirele=
ss/ath/ath9k/recv.c
> > index 34c74ed99b7b..93b41a1bb2af 100644
> > --- a/drivers/net/wireless/ath/ath9k/recv.c
> > +++ b/drivers/net/wireless/ath/ath9k/recv.c
> > @@ -202,7 +202,6 @@ static int ath_rx_edma_init(struct ath_softc *sc, i=
nt nbufs)
> >       struct sk_buff *skb;
> >       struct ath_rxbuf *bf;
> >       int error =3D 0, i;
> > -     u32 size;
> >
> >       ath9k_hw_set_rx_bufsize(ah, common->rx_bufsize -
> >                                   ah->caps.rx_status_len);
> > @@ -212,8 +211,7 @@ static int ath_rx_edma_init(struct ath_softc *sc, i=
nt nbufs)
> >       ath_rx_edma_init_queue(&sc->rx.rx_edma[ATH9K_RX_QUEUE_HP],
> >                              ah->caps.rx_hp_qdepth);
> >
> > -     size =3D sizeof(struct ath_rxbuf) * nbufs;
> > -     bf =3D devm_kzalloc(sc->dev, size, GFP_KERNEL);
> > +     bf =3D devm_kcalloc(sc->dev, sizeof(struct ath_rxbuf), nbufs, GFP=
_KERNEL);
>
> here as well?
Sure
>
> >       if (!bf)
> >               return -ENOMEM;
> >
> > --
> > 2.53.0
> >
> >
>

