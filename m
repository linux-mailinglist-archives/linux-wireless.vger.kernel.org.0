Return-Path: <linux-wireless+bounces-14549-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFCC9B09C2
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 18:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFDEA284A48
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 16:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E9618660B;
	Fri, 25 Oct 2024 16:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N4HWfhGT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19B5187872
	for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 16:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729873350; cv=none; b=mQbLhdrMeC60WQA8ze2BBTkiy5PTJsB5neMm19Pajc0zlsal9Z2LNUmNmRoi3G2Dqq0KI+VTrVigP4L1GurdipnGuKQpnodN24uRjNpyN4vY6dKhsEDXcBb7W1NJWdd/cy7tTPWclUk8DblQTsHSxK7B5PvqTYtB7dDQgAX1KuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729873350; c=relaxed/simple;
	bh=Nvc3OxwdDJqF6/bh7R12YvLLqr9zIdGMinGLFcdg2v4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ESeMpJgdFMmS59kVnx8IdDGpdnO9RYt63PG0fP+0LHj932BOPey8y54fsEiIV8kJwtRt7yf6cuPWIT2jYTtVALepnpu7hpujk3cDOVfBgYc6t74WV+Wdm/jXjHlGbyFQ9X9A7GUTlneqtjOMtHYZnSdHCjeMoiK3AEGxPuuzrpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N4HWfhGT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729873346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=emwlGOdAV5GPCbDbXU8/cJnDkVRFeD9ng138eIoq4+4=;
	b=N4HWfhGTp2SoEk1Kp7e15WmSp+4hLdM7rWLPbbWTsHKt9Ay55g4CpMEDrz7ozWgXYcDoia
	PYO6v4I5WqSyuYwu7CwIB9zTs8I22wEiAVvC3CFtzKzG3B/hsy/gTTLDA1OPFsr10EJtlG
	YKSKbwirGMJVDS3W3OM5/supobrvRNs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-NQtLBP__MIyp748KI88uqw-1; Fri, 25 Oct 2024 12:22:25 -0400
X-MC-Unique: NQtLBP__MIyp748KI88uqw-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5cbadbef8edso1019534a12.3
        for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 09:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729873344; x=1730478144;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=emwlGOdAV5GPCbDbXU8/cJnDkVRFeD9ng138eIoq4+4=;
        b=wcElSap9AVK0myzT8BYBdrVO+yiY/EXW4QLcTCzo040gn37bPEWuUX+5HH4o2yOb9Y
         bWkVsWiahVSo63dsmH6a2qBgg3YT2+B1vWrabwVYg9Pw0898vVFji6p3iYlQHW1IO22o
         XuflPfkbmF4UQebtzS4OE4RRPBFNq1BQ8J6wwIqOd6tANiyyXX4ORwnDTwELOlcU0Ylk
         LkRpS9SbrSRs62h2TynvxH7mpIzqwqVueSAihcHwuq5wmZzDd8upB8hbjIqHlr1jc5hL
         SPB/3MFkuzBPqD5qxIBrd/FcGpVOsfQ814xiafkQEH6Mr6z24bdeV+2T7TvJbynGvoZc
         FCbQ==
X-Forwarded-Encrypted: i=1; AJvYcCX523rHpM+8CN9F63A9uz2+zTnilMRzSmYuAOSDJCvyb+Tma81zxcyw9qkX587N48RvJH41U78QkbwtY68LVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDZz7TDtcc/y8hUVq0PnPjL+dEoXAq6/ZLZvjHAIPBQs7puxsC
	6YPdADbMbGrxSDmIgZAGBQD1htnF82bLTEE3cb3hVWnAAhAhoL7RuosX2mU32Yt+5S2B9Z6bQvO
	akwoVtFBFo6eZ8FOoqWiq1xD0XwUBpnBktWOynvEHaIx3ALAGRR2zHyHCYbWGXPEd
X-Received: by 2002:a17:907:7f15:b0:a9a:7f84:940b with SMTP id a640c23a62f3a-a9abf8458f3mr1007584766b.10.1729873343929;
        Fri, 25 Oct 2024 09:22:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRdntJoyvupUZ8WixSPs76hFhlXeUzwWu1qndPMO81kxJOWMh5JeS9vrEJtBZYGSJGz+4mZg==
X-Received: by 2002:a17:907:7f15:b0:a9a:7f84:940b with SMTP id a640c23a62f3a-a9abf8458f3mr1007579766b.10.1729873343429;
        Fri, 25 Oct 2024 09:22:23 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82de5ba00738ac8dadaac7543.dip.versatel-1u1.de. [2001:16b8:2de5:ba00:738a:c8da:daac:7543])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f298ef6sm86580966b.136.2024.10.25.09.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 09:22:23 -0700 (PDT)
Message-ID: <19f734499f24df1f1835248eba19b136d41cc1d4.camel@redhat.com>
Subject: Re: [PATCH 02/10] ata: ahci: Replace deprecated PCI functions
From: Philipp Stanner <pstanner@redhat.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Damien Le Moal <dlemoal@kernel.org>, 
 Niklas Cassel <cassel@kernel.org>, Giovanni Cabiddu
 <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,  Boris Brezillon
 <bbrezillon@kernel.org>, Arnaud Ebalard <arno@natisbad.org>, Srujana Challa
 <schalla@marvell.com>,  Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Miri Korenblit
 <miriam.rachel.korenblit@intel.com>, Kalle Valo <kvalo@kernel.org>, Serge
 Semin <fancer.lancer@gmail.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang
 <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Kevin Cernekee <cernekee@gmail.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>,  Mark Brown <broonie@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <u.kleine-koenig@pengutronix.de>, Jie Wang <jie.wang@intel.com>, Tero
 Kristo <tero.kristo@linux.intel.com>, Adam Guerin <adam.guerin@intel.com>,
 Shashank Gupta <shashank.gupta@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Bharat Bhushan <bbhushan2@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, Johannes Berg
 <johannes.berg@intel.com>, Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
  Gregory Greenman <gregory.greenman@intel.com>, Benjamin Berg
 <benjamin.berg@intel.com>, Yedidya Benshimol
 <yedidya.ben.shimol@intel.com>, Breno Leitao <leitao@debian.org>, Florian
 Fainelli <florian.fainelli@broadcom.com>, linux-doc@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
 qat-linux@intel.com,  linux-crypto@vger.kernel.org,
 linux-wireless@vger.kernel.org,  ntb@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-serial <linux-serial@vger.kernel.org>,
 linux-sound@vger.kernel.org
Date: Fri, 25 Oct 2024 18:22:21 +0200
In-Reply-To: <282ba5d4-cdad-a6f4-8ee0-1936c532dbc5@linux.intel.com>
References: <20241025145959.185373-1-pstanner@redhat.com>
	 <20241025145959.185373-3-pstanner@redhat.com>
	 <282ba5d4-cdad-a6f4-8ee0-1936c532dbc5@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-10-25 at 18:55 +0300, Ilpo J=C3=A4rvinen wrote:
> On Fri, 25 Oct 2024, Philipp Stanner wrote:
>=20
> > pcim_iomap_regions_request_all() and pcim_iomap_table() have been
> > deprecated by the PCI subsystem in commit e354bb84a4c1 ("PCI:
> > Deprecate
> > pcim_iomap_table(), pcim_iomap_regions_request_all()").
> >=20
> > Replace these functions with their successors, pcim_iomap() and
> > pcim_request_all_regions().
> >=20
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > Acked-by: Damien Le Moal <dlemoal@kernel.org>
> > ---
> > =C2=A0drivers/ata/acard-ahci.c | 6 ++++--
> > =C2=A0drivers/ata/ahci.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 6 ++++--
> > =C2=A02 files changed, 8 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/ata/acard-ahci.c b/drivers/ata/acard-ahci.c
> > index 547f56341705..3999305b5356 100644
> > --- a/drivers/ata/acard-ahci.c
> > +++ b/drivers/ata/acard-ahci.c
> > @@ -370,7 +370,7 @@ static int acard_ahci_init_one(struct pci_dev
> > *pdev, const struct pci_device_id
> > =C2=A0	/* AHCI controllers often implement SFF compatible
> > interface.
> > =C2=A0	 * Grab all PCI BARs just in case.
> > =C2=A0	 */
> > -	rc =3D pcim_iomap_regions_request_all(pdev, 1 <<
> > AHCI_PCI_BAR, DRV_NAME);
> > +	rc =3D pcim_request_all_regions(pdev, DRV_NAME);
> > =C2=A0	if (rc =3D=3D -EBUSY)
> > =C2=A0		pcim_pin_device(pdev);
> > =C2=A0	if (rc)
> > @@ -386,7 +386,9 @@ static int acard_ahci_init_one(struct pci_dev
> > *pdev, const struct pci_device_id
> > =C2=A0	if (!(hpriv->flags & AHCI_HFLAG_NO_MSI))
> > =C2=A0		pci_enable_msi(pdev);
> > =C2=A0
> > -	hpriv->mmio =3D pcim_iomap_table(pdev)[AHCI_PCI_BAR];
> > +	hpriv->mmio =3D pcim_iomap(pdev, AHCI_PCI_BAR, 0);
> > +	if (!hpriv->mmio)
> > +		return -ENOMEM;
> > =C2=A0
> > =C2=A0	/* save initial config */
> > =C2=A0	ahci_save_initial_config(&pdev->dev, hpriv);
> > diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> > index 45f63b09828a..2043dfb52ae8 100644
> > --- a/drivers/ata/ahci.c
> > +++ b/drivers/ata/ahci.c
> > @@ -1869,7 +1869,7 @@ static int ahci_init_one(struct pci_dev
> > *pdev, const struct pci_device_id *ent)
> > =C2=A0	/* AHCI controllers often implement SFF compatible
> > interface.
> > =C2=A0	 * Grab all PCI BARs just in case.
> > =C2=A0	 */
> > -	rc =3D pcim_iomap_regions_request_all(pdev, 1 <<
> > ahci_pci_bar, DRV_NAME);
> > +	rc =3D pcim_request_all_regions(pdev, DRV_NAME);
> > =C2=A0	if (rc =3D=3D -EBUSY)
> > =C2=A0		pcim_pin_device(pdev);
> > =C2=A0	if (rc)
> > @@ -1893,7 +1893,9 @@ static int ahci_init_one(struct pci_dev
> > *pdev, const struct pci_device_id *ent)
> > =C2=A0	if (ahci_sb600_enable_64bit(pdev))
> > =C2=A0		hpriv->flags &=3D ~AHCI_HFLAG_32BIT_ONLY;
> > =C2=A0
> > -	hpriv->mmio =3D pcim_iomap_table(pdev)[ahci_pci_bar];
> > +	hpriv->mmio =3D pcim_iomap(pdev, ahci_pci_bar, 0);
> > +	if (!hpriv->mmio)
> > +		return -ENOMEM;
>=20
> Hi,
>=20
> I've probably lost the big picture somewhere and the coverletter
> wasn't=20
> helpful focusing only the most immediate goal of getting rid of the=20
> deprecated function.
>=20
> These seem to only pcim_iomap() a single BAR. So my question is, what
> is=20
> the reason for using pcim_request_all_regions() and not=20
> pcim_request_region() as mentioned in the commit message of the
> commit=20
> e354bb84a4c1 ("PCI: Deprecate pcim_iomap_table(),=20
> pcim_iomap_regions_request_all()")?

That commit message isn't that precise and / or was written when
pcim_request_all_regions() was still an internal helper function.

>=20
> I understand it's strictly not wrong to use
> pcim_request_all_regions()
> but I'm just trying to understand the logic behind the selection.
> I'm sorry if this is a stupid question, it's just what I couldn't
> figure=20
> out on my own while trying to review these patches.
>=20

The reason pcim_request_all_regions() is used in the entire series is
to keep behavior of the drivers 100% identical.
pcim_iomap_regions_request_all() performs a region request on *all* PCI
BARs and then ioremap()s *specific* ones; namely those set by the
barmask.

It seems to me that those drivers were only using
pcim_iomap_regions_request_all() precisely because of that feature:
they want to reserve all BARs through a region request. You could do
that manually with

for (int i =3D 0; i < PCI_STD_NUM_BARS; i++) pcim_request_region();
mem =3D pcim_iomap(...);

When you look at Patch #10 you'll see the implementation of
pcim_iomap_regions_request_all() and will discover that it itself uses
pcim_request_all_regions().

So you could consider this series a partial code-move that handily also
gets rid of a complicated function that prevents us from removing,
ultimately, the problematic function pcim_iomap_table().


Hope this helps,
P.

> (I admit not reading all the related discussions in the earlier
> versions.)
>=20


