Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB64203A0C
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2020 16:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbgFVOxs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jun 2020 10:53:48 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21864 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729280AbgFVOxr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jun 2020 10:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592837625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P7taa7KigpgUZeLwSBQmyXWitMWaWACRV2B/k/C5al0=;
        b=gRStwUcLtw61tpAoCwUgIqKOCrQA4OKSb9xWCrKE8qnzqjz5H7e4XFay7W9ZwO79e4TNSf
        nTV64SA6n7zpvQ7+5shsboCatJyJgpI+0HvxqxvsGXIzeNsO4mI8rOa01P8Ep3voHo0zQx
        6Dva+E5yASxXfEz5gb7GYs42vltpcQA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-EazmJF60OC-3O3DTayO21w-1; Mon, 22 Jun 2020 10:53:43 -0400
X-MC-Unique: EazmJF60OC-3O3DTayO21w-1
Received: by mail-wr1-f70.google.com with SMTP id w4so10952123wrl.13
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2020 07:53:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P7taa7KigpgUZeLwSBQmyXWitMWaWACRV2B/k/C5al0=;
        b=pobp+Mc3oS44gs27WzSL4TYVyNj4eVc4YPPr0umZMOR+qwTM1rXTH+Naf+M50DsIDy
         jbp4KGfxrXjkh8aWX2fLhUdbHWZ+NNs5Jes52ObFUM5xw8ty7XnSDqZKEjN1JXdnxs+D
         hoeuxDncLDh02JV4S50awk0chpdzMmRJDLeAvtr/4LJR5koU2cof14cpzJsoFDl8m2Xa
         +/EZ8EFKI5vn/qFQ4L2A974xLYeU0UOBmG9T5ZuWsap5OG/JI0mB5beEFSqw4CJq/a8p
         uwINauBU++rQY1CFn/0UtIg0AYHzsP+JwOcklhmuckiBa6/lUvYABJZEzCjqhbMVxEoq
         mcIw==
X-Gm-Message-State: AOAM531EEykFWZp0tOG0LFv7HikqtDemObW6wfFnCfDsnyJ/oI5uvZ6D
        oVlKHZFtdoMIYrE6gETRZUQwH0CKRy/FYfbu5cuWm8pOwmcJwf5PUbK4++xnBen/jusZtBPGsTn
        IVHUHgcrFL7ioA66E01yjz2guQ4Q=
X-Received: by 2002:a5d:4e81:: with SMTP id e1mr5512127wru.22.1592837622435;
        Mon, 22 Jun 2020 07:53:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyUuKsQy1lYYQH5S5wcZD53SekQyD8JGsIHp4PC0g4E/zNEVCx/JYFP61TwuMuJ4vKGweBlJw==
X-Received: by 2002:a5d:4e81:: with SMTP id e1mr5512094wru.22.1592837622169;
        Mon, 22 Jun 2020 07:53:42 -0700 (PDT)
Received: from localhost ([151.48.138.186])
        by smtp.gmail.com with ESMTPSA id e25sm19318997wrc.69.2020.06.22.07.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 07:53:41 -0700 (PDT)
Date:   Mon, 22 Jun 2020 16:53:38 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Oleksandr Natalenko <oleksandr@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Felix Fietkau <nbd@nbd.name>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: mt7612 suspend/resume issue
Message-ID: <20200622145338.GB27892@localhost.localdomain>
References: <20200618090556.pepjdbnba2gqzcbe@butterfly.localdomain>
 <20200618111859.GC698688@lore-desk.lan>
 <20200619150132.2zrc3ojqhtbn432u@butterfly.localdomain>
 <20200621205412.GB271428@localhost.localdomain>
 <CAHcwAbR4govGK3RPyfKWRgFRhFanWtpJLrB_PEjcoiBDJ3_Adg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DBIVS5p969aUjpLe"
Content-Disposition: inline
In-Reply-To: <CAHcwAbR4govGK3RPyfKWRgFRhFanWtpJLrB_PEjcoiBDJ3_Adg@mail.gmail.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hello, Lorenzo.
>=20
> On Sun, Jun 21, 2020 at 10:54 PM Lorenzo Bianconi <lorenzo@kernel.org> wr=
ote:
> > > > +static int __maybe_unused
> > > > +mt76x2e_suspend(struct pci_dev *pdev, pm_message_t state)
> > > > +{
> > > > +   struct mt76_dev *mdev =3D pci_get_drvdata(pdev);
> > > > +   struct mt76x02_dev *dev =3D container_of(mdev, struct mt76x02_d=
ev, mt76);
> > > > +   int i, err;
> >
> > can you please double-check what is the PCI state requested during susp=
end?
>=20
> Do you mean ACPI S3 (this is the state the system enters)?  If not,
> what should I check and where?

yes, right. Just for debugging, can you please force the card in PCI_D0 dur=
ing the
suspend?

Regards,
Lorenzo

>=20
> Thanks.
>=20
> --=20
>   Best regards,
>     Oleksandr Natalenko (post-factum)
>     Principal Software Maintenance Engineer
>=20

--DBIVS5p969aUjpLe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXvDF7wAKCRA6cBh0uS2t
rJ4uAP9lKuUy0QTisY2SFP33vemkDckUeiQV2JsSGBnBdJ4FIQD/Yo4wkX1kg1Dr
YM/2gw/OmT+M00BF1XWr3MJF0Tx7sQo=
=rEPw
-----END PGP SIGNATURE-----

--DBIVS5p969aUjpLe--

