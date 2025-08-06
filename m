Return-Path: <linux-wireless+bounces-26180-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7399B1C9C7
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Aug 2025 18:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D54C1164F7F
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Aug 2025 16:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A587228B7E2;
	Wed,  6 Aug 2025 16:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzYxdiJQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE61D42A9D
	for <linux-wireless@vger.kernel.org>; Wed,  6 Aug 2025 16:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754497651; cv=none; b=hdEQYF/I3glZkNvIRxf/li6h16EztoZ64fnjpsyhOkT6IW55HWBAxD1fodlPmN5VTtvWNkgZPWB76vr5hVL1mj9z6lY37J20um5SZHNCHSdpTCO2bkz/Uv72UO//c9CXrngFxvTyyIDKOtfiRFZ5ARR0omGuCjVqMiBSbY+XZaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754497651; c=relaxed/simple;
	bh=0hfVBkOIfMKGwaw9LLFpXnZp0sFsxWwEqbOJt1cSQ6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UPK9y/0bQu2yzWgLOznmURhDo/dKN3abeXZ7Vn4cBQnA/CWrDivwoXmCNxEH9hggy0OCPAdgedV9v/qwO6OHhU9SPBNcVXsAqL+ziGTi2saUYzpeSHzteKmbQMA6/7hKf2moDMkZzUwYJjPpuff1BfxV/0vrxE3SfzXee2ywPxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzYxdiJQ; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so96030a12.2
        for <linux-wireless@vger.kernel.org>; Wed, 06 Aug 2025 09:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754497648; x=1755102448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKRsyb59sI/Pq3XkM5WY2NBv4R8Bed8UvR0P+pyoDtk=;
        b=DzYxdiJQ9/ROYmYDFU4IE/XrRhgU03vKhwmAh8baRXaJdAYy5sQBm6kkts2e0EGVsj
         ACh9OCQpY3VGWy+4Vin1uqbdiRbv3B0U5CjfCWM1MDgyZKOhLVwNiyST89CfZsACAsW8
         Ivgj6XfAScUVF+mzpQPFCvXnkHyQ3/3430tV1uwhAHFLlYh20poRkRKQUy+2x+YU2GY4
         +W1l8wv8ZFwtvPMDP6tVx8FN6I7KG3ix7tFtisa070+CCMSzej8iNkBb9KiKRMPLn2l0
         Y4TdjIONcfFUYeUF8KZjTWH4MX6uvvuEWkmf1x2DuEwE1GWIJCn7P9t+/sswIaPp7zpX
         EM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754497648; x=1755102448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BKRsyb59sI/Pq3XkM5WY2NBv4R8Bed8UvR0P+pyoDtk=;
        b=D0SvSqhOwfv6Z+BHO92V1WavChMk8anqirzFdvvrGqydw3mJgQqaOO6oTRTXAgN5j3
         7vdrskNfutjSckY5izNxJN5KYgpOV6/h3sneePCNQmaYOgja8pyiRT1ykxOO0dmor4lq
         hJrWcCpOEUtFVEs0eqVjUBU+Hn44BAF1CP5jcfFOtjkU1veSlIrv6o1qCX/r0antJkvr
         SZD/wr1z/A5xciXpY79FZ3keT0HyLRXIn/7WtU30nP65ZbzdvyAdYJEK+5w2boXhNTD2
         L5P78Yds69iqyPA5NtLndMOXhreRysyOV687xMRpRFc9J/xy119L9ROYDeF63mGii88N
         6IyQ==
X-Forwarded-Encrypted: i=1; AJvYcCX08IHL92qFRPg53jD8COzlBgxfOHHKh7dJ7ThMCikfyh3Lgb+WLpQiDk/bkNVKtsND4F4tJBJxQyweNrwLvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhXVO4tyZ/aLSvlE3YuYSOIXreK1z7DW7VnUsFppfPFKtHZSsn
	1E45Vsq4BiPPbJdrfxLyP40+U3WZS2Da2IX2A3opVZNelbw/AQoA8JRLyi9eBgS+B243ymD+De+
	9mEoceakXlw1g9JIzUIWsQD5bq27umlA=
X-Gm-Gg: ASbGncv+vwKJaLvYwL2SXfTCWFIOHKK/X77n8TWVD8pJXp1IgERR9Ng2zT+EI1OsdBg
	gtDfezBRfLzkafI4sauh0yUHVaeeXrCFZLyEN6Xda66oBMwWoNbH1MY5Xc8ofoqKB7TQHNSb2eA
	afEyK+MvO9PGdU/ijkoFpG8ODhDy9FBlQbIepNpK7FHYwaTGNaPj1x7502gqO2bMiYDnteRAQgE
	MWv3Oc=
X-Google-Smtp-Source: AGHT+IH6vL77K0F+FOI5EapxF6X+Udy6LtotpCRryDr1e1TWyn3yq7qNdb1xLXgvzbAi+AhvixzSiVNN9mxhuN+HGUU=
X-Received: by 2002:a05:6402:4558:b0:612:b742:5bba with SMTP id
 4fb4d7f45d1cf-617960d32cfmr2794188a12.13.1754497647805; Wed, 06 Aug 2025
 09:27:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806070005.1429-1-hujy652@gmail.com> <DBVFA7TPXKHU.33YF5JEOR1ZLT@gmail.com>
In-Reply-To: <DBVFA7TPXKHU.33YF5JEOR1ZLT@gmail.com>
From: Zhi-Jun You <hujy652@gmail.com>
Date: Thu, 7 Aug 2025 00:27:16 +0800
X-Gm-Features: Ac12FXyqQkfo1UOOBM-sReiwGwPCnQZ1-Yn7USfnfD30_SCYmcpO17i7YRBiyXU
Message-ID: <CAHGaMk_N5+YUwW99GoMp5Zv+-ueZWdyqfRNrJPQkRsyqkQcRTg@mail.gmail.com>
Subject: Re: [RFC PATCH] wifi: ath10k: support flush_sta method
To: Nicolas Escande <nico.escande@gmail.com>
Cc: jjohnson@kernel.org, linux-wireless@vger.kernel.org, 
	ath10k@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

AFAIK there's no easy way to tell if it works.
According to another commit [0] after sending the command it still
needs to go through tx completion->ath10k_txrx_tx_unref.

Best you can do is the debug message.(ATH10K_DBG_WMI, ATH10K_DBG_HTT)

[0]: https://lore.kernel.org/linux-wireless/20200415233730.10581-1-wgong@co=
deaurora.org/

Best regards,
Zhi-Jun You


On Wed, Aug 6, 2025 at 10:42=E2=80=AFPM Nicolas Escande <nico.escande@gmail=
.com> wrote:
>
> On Wed Aug 6, 2025 at 9:00 AM CEST, Zhi-Jun You wrote:
> > When a STA is marked as no longer authorized, if the driver doesn't
> > implement flush_sta(), mac80211 calls ieee80211_flush_queues() to
> > flush hardware queues to avoid sending unencrypted frames.
> >
> > This has became a problem for ath10k because ieee80211_flush_queues()
> > will stop all traffic and call ath10k_flush, which waits until the
> > whole HW queue is empty. In a busy environment this will trigger a
> > timeout warning and stalls other STAs.
> >
> > Fix this by implementing flush_sta method using WMI command to flush
> > frames of a specific STA.
> > Flushed frames will be marked as discard in tx complete indication.
> >
> > ops->flush_sta will be set to NULL if htt.disable_tx_comp is set to
> > true.
> >
> > Tested-on: QCA9984 hw1.0 PCI 10.4-3.9.0.2-00157
> >
> > Signed-off-by: Zhi-Jun You <hujy652@gmail.com>
> > ---
> >  drivers/net/wireless/ath/ath10k/mac.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wirele=
ss/ath/ath10k/mac.c
> > index 24dd794e31ea..6959f20334a7 100644
> > --- a/drivers/net/wireless/ath/ath10k/mac.c
> > +++ b/drivers/net/wireless/ath/ath10k/mac.c
> > @@ -8135,6 +8135,20 @@ static void ath10k_flush(struct ieee80211_hw *hw=
, struct ieee80211_vif *vif,
> >       mutex_unlock(&ar->conf_mutex);
> >  }
> >
> > +static void ath10k_mac_op_flush_sta(struct ieee80211_hw *hw, struct ie=
ee80211_vif *vif,
> > +                          struct ieee80211_sta *sta)
> > +{
> > +     struct ath10k_vif *arvif =3D (void *)vif->drv_priv;
> > +     struct ath10k *ar =3D hw->priv;
> > +     u32 bitmap =3D 0xFFFFFFFF;
> > +     int ret =3D 0;
> > +
> > +     ret =3D ath10k_wmi_peer_flush(ar, arvif->vdev_id, sta->addr, bitm=
ap);
> > +     if (ret)
> > +             ath10k_warn(ar, "failed to flush sta (sta %pM)\n",
> > +                         sta->addr);
>
> Hello,
>
> Just to be sure, you have seen real improvements from this ?
> Because I remember trying this exact WMI command two years ago and I coul=
dn't be
> sure it was actually doing something. That's one of the reasons why we en=
ded up
> doing the per peer frame accounting as posted by remi here
> https://lore.kernel.org/linux-wireless/17d26d6a3e80ff03939ee7935fdc07f979=
b61a4f.1732293922.git.repk@triplefau.lt/
>
> Thanks

