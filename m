Return-Path: <linux-wireless+bounces-35403-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPUyFJ6572kbEQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35403-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 21:31:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E75A4794F7
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 21:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F161A301CCE8
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 19:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852FF41B357;
	Mon, 27 Apr 2026 19:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnGdPNlo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB2041B363
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 19:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777318299; cv=pass; b=n5IU5JBofWMWFm9wGb6Y7quHGJ3dhSYzvdf+niqfxtNLc5lJRSvTgBRV/YVZI9TEwE6cbZzYgB+yQTbkRlUqtRt7ZdZXwfAEtHINXMEiqkXI3WHDteJ+TQBU6yiy3bhZaT6qA0gAxYDIi3d72G3xS0YL488EtaDhN2WhQnlXiTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777318299; c=relaxed/simple;
	bh=9aXUzqoNJSyGNOQj43s3xvURUf1bKjBjTH1nNIEzZCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cvZI9UshzFo+RwhAoHqT1JUEopGdxVAKYz9st985u8dtw7CVpzUllowhIIhLGVkdWd0xmkDVWpevh4SPmaGHDymlFAJ/dRA+jXT6svEIS5uJc4udGIaLMsBAIPNli/kbhRuyf5NlhLPPfMRlNS+tb4jq8Qc4fV9cC3fPj96nDAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnGdPNlo; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-678adefbd26so5436845a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 12:31:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777318296; cv=none;
        d=google.com; s=arc-20240605;
        b=BC4pqu5QxS7lmwP/h2Eu4hvHtmfPVxcJEy3x+V5Qq3siIskvi/msKl8pOuiXTzXHpr
         cjOvi1Wdvbjf+TMsDvzXuiCRAdRMpFRjbNgyG9E19N9e2BLmGLqgTB8MZWhLqfQsGiVS
         vFQQRkJZEC/grj0gUQpx/DvSYqoYxNvxiayxYpxLHDNEb6/+MpqwR5WhvDFEXAzkwulu
         0LPvOkQLup223yVkd5LgZXCbIbWjWTyg2TTb8Clj4wZSTjRq6XA7e4gskBlqRjPd/wfi
         RwgyQASpqXo7JSoSf+F8dR3vInP7SkQRXEVOeS3ktm6SdzFoOqqvDbC7l9glFKF61SIM
         LfXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1TRHaqOiMqisoX67+SJ+v5svNBphdJyCvNxffWxh+To=;
        fh=YGJEsgNfR00xAohdTiJA61vGqZeqctthBG8Y5wTzMeM=;
        b=IRXuCoJgJZoSQQRxb50Ahgg3lKYdxtELtlkDcTqcnCJX06DHOUEREwHeHxZBjucx2I
         rC5gDW+8c3BcYem2nqg6yyGObHWCm0+9I6fADd6X4Ptxo6IHRRmCjRFW6rmJ5/sNA0qP
         TEU2ZSEDpxAr4qHxr3VTVh2qR1PuaQ6N0qX3GHyBxmSznvBdNjNvNJ1nNyZHLNPUzS6q
         YcAHeXWiHn2IhilzjBn0kXsLZAunCFHPoIkINTyvLhlRhWZ1Evyx58mtSEqvTu6H2C0g
         BQBcUgeYJXaH2A1kPjkmRpPdVnpDxilDghq8nqrwysYYfD2YnLr9+ERGPjjIHhU6DpI8
         A3Pw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777318296; x=1777923096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1TRHaqOiMqisoX67+SJ+v5svNBphdJyCvNxffWxh+To=;
        b=WnGdPNlovxu4/1QRvy9JvQHJ0kIETlzk4iZnI2Ky55AIRj6sKHz2xpA470NhwvUQ90
         zJ83+a5yuPkHEu8602tikOiFGgakFgpfWXDK6tQaYp41q5xDDl+MuImEA07v3TcTgE0l
         Y+wGcV4pHqfatxqgLemSKOJKX/WGqvPFLsjqwxeM8X64WAQA7ZAJolwYfXE6EcfRViS/
         Brp6uE8q/Cud0UP8FwpQvhyVsz+dfvKOep2/iEZxRjzR+UBln2O3so6d22BM+cmPGpNy
         9H+wgqGXuIELc0hJ+fkzf2rdtk1OhThwQbdngwVXomCU/W26rgsGCKa7HVyFLq6HgFcR
         E7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777318296; x=1777923096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1TRHaqOiMqisoX67+SJ+v5svNBphdJyCvNxffWxh+To=;
        b=cJ3aBFpV00HYYXSFNAfW3qF+cnzBXsvVz+f3q9+CQ8hXUCVRAAoDHuRCict2OfQpts
         VhZ5nusjcznMgR5pd7K5A1rx5iFrFmlxqXHGNjYK9jYXu6WHBmr1eK/Sm5ANLV0YZ63e
         3yl3f92PKEEsF/3pxn/IkfJqL7h/xQy1bh3wi9FZuvcvJOrzHzXvWHNnBo3iIoDPUyGI
         StVW1/u2Mh7IcPpR8HoXxI0k98htPCRqlqeSHFkTLbLvvdeSeQ0eapMPNQG4hatuv4EF
         c94LUITdXrPo53IvletW3xfxv0HG1V8OKMDPREdso87O6hkcUDvB1tcBOkX9f1XKoeeJ
         SNEw==
X-Gm-Message-State: AOJu0Yx8/d9CrYMScPYia9AmWfYAmmkwioZCRo1qKgGpeEPDePpu7vYg
	DVbrScpkx6yC1eVvLidpMcbP8mRDmkIDXwPCjtzHvVaDwxnVFt0dLrcy7qV08yrrgZR3/tgz87E
	1PeXbV6/YjJR5CNNPXfDL1AJOhaG3mPo=
X-Gm-Gg: AeBDiesPSmt6tihzAoSlAhDuXUkUXRajfB8Ny7nQ780muZUNRjXuQvEOcpiCdyTZ1WK
	9NFRgEqZyrojKlkDWwjCbUz4l24vet/Od4QzqSUX9TszEbmEIZexMGEi76fxEFGPKv0DM69ZyFB
	9HrWLSMdaVyCjEw9HEGDCDRar19i5IB82Qy38yVXkbZPvLOTeITpl+rZbXxg/Uhg724PDedefPT
	XLBw7E99D4APIZwUi6ZzsfI9oNXOVtEr+OLPqOd9LEf2/mPKOYRaJLmWue6T8Rjz/1ZK7E66SXR
	LX7KSHp0h9xQRv/XRrth2GwoepvEYcl+KJN9yqxPkLW4qXZA9NsEuZFZcZ2n/HpbpyaGx8whP9v
	Nc+RvAPn+/GsRLpGy19aSKhSZ/aUOJTSkSYa1yG2DoMZZW21U5z1hs2x/BaY=
X-Received: by 2002:a17:907:6ea2:b0:bad:d530:dbf7 with SMTP id
 a640c23a62f3a-bb804727dfemr7884666b.32.1777318296025; Mon, 27 Apr 2026
 12:31:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427051604.953450-1-rosenp@gmail.com> <5416906.31r3eYUQgx@nb0018864>
In-Reply-To: <5416906.31r3eYUQgx@nb0018864>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 27 Apr 2026 12:31:24 -0700
X-Gm-Features: AVHnY4KnxDQiyQjZO2aBV50kUfbP1XrmXUdNZIj5Gyxhy8Eyg5Gl3p2SFrsX1V8
Message-ID: <CAKxU2N_x_ZSnDzRG02c4u6AbYJW-tbq2Et54GHaORgQYGYp2Xw@mail.gmail.com>
Subject: Re: [PATCH] wifi: wfx: handle EPROBE_DEFER with of_get_mac_address
To: =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 6E75A4794F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35403-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,silabs.com:email]

On Mon, Apr 27, 2026 at 12:49=E2=80=AFAM J=C3=A9r=C3=B4me Pouiller
<jerome.pouiller@silabs.com> wrote:
>
> Hello Rosen,
>
> On Monday 27 April 2026 07:16:04 Central European Summer Time Rosen Penev=
 wrote:
> >
> > In case nvmem gets used and is not ready in time for probe of wfx,
> > EPROBE_DEFER gets called. Return it so that a proper MAC address can be
> > specified in such a case.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/net/wireless/silabs/wfx/main.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/net/wireless/silabs/wfx/main.c b/drivers/net/wirel=
ess/silabs/wfx/main.c
> > index dda36e41eed1..dc40a9bd986d 100644
> > --- a/drivers/net/wireless/silabs/wfx/main.c
> > +++ b/drivers/net/wireless/silabs/wfx/main.c
> > @@ -445,6 +445,8 @@ int wfx_probe(struct wfx_dev *wdev)
> >         for (i =3D 0; i < ARRAY_SIZE(wdev->addresses); i++) {
> >                 eth_zero_addr(wdev->addresses[i].addr);
> >                 err =3D of_get_mac_address(wdev->dev->of_node, wdev->ad=
dresses[i].addr);
> > +               if (err =3D=3D -EPROBE_DEFER)
> > +                       goto irq_unsubscribe;
> >                 if (!err)
> >                         wdev->addresses[i].addr[ETH_ALEN - 1] +=3D i;
> >                 else
>
> I assume this patch works when WF200 is connected on SPI with reset GPIO
> configured. However, for SDIO and without gpio reset, we can't run the
> device initialisation twice.
>
> I believe the check has to happen before the call to wfx_init_device().
>
> To check it works as expected, can you also test your patch without the
> reset-gpio attribute?
I do not have this hardware.
>
>
> --
> J=C3=A9r=C3=B4me Pouiller
>
>

