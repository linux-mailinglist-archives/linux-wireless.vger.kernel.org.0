Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 336AF422F7
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 12:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408046AbfFLKt1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jun 2019 06:49:27 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46181 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407093AbfFLKt0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jun 2019 06:49:26 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so16313630wrw.13
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2019 03:49:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PQUOLq004AOBqWVaILDJQGC4kVD+rEQv5fEs4nDzDPQ=;
        b=JR0JKgvSzWHvei/KND5vVpiEu7BAXn8ALKXFmR1gQGijU/0JajzV89a3JBhiqMXXO6
         bYEY8T14k7p6tKR5cH7u6rn8s6oInfrAC0bOzLX0h8OCo1fZbPcGNz1skuhYrbBWeJEs
         OfpEjn8NxeCcwgcmLMlWkdjkfTNlTTUPklEK/72qhIBb4t99qOyU42GYT2464oqU+6SU
         Vi+WoxXewhLXdnBd7nplqnGCWzLmq5nxPNUW2DGVFMYAYBq4+isn8mY1cm2rFI02ZG56
         F9ZuC/RHVi+sOghBrMOjBJjn46QUdHT7WPst+KsgkLujBFPg7GHYiY/B1N1WyTe8VCEd
         OHag==
X-Gm-Message-State: APjAAAW439ClyZfs+5XpuNbyRVK131lEQuDdOki+VF9b92LI/nF9Gh/S
        GwxSQV0fk+tfOdeCGmRgYyaojw==
X-Google-Smtp-Source: APXvYqw7lFQXfk1Q1ImPayOzK7ZimH73pNPLniFD1MxFHXjhZWv2E6yT2VNtfyx1N+LIpquepHnyOA==
X-Received: by 2002:a5d:52c7:: with SMTP id r7mr53130989wrv.110.1560336565354;
        Wed, 12 Jun 2019 03:49:25 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id y38sm27767008wrd.41.2019.06.12.03.49.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 03:49:24 -0700 (PDT)
Date:   Wed, 12 Jun 2019 12:49:22 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, nbd@nbd.name,
        kvalo@codeaurora.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mt76: usb: do not always copy the first part of
 received frames
Message-ID: <20190612104921.GF8107@localhost.localdomain>
References: <cover.1559293385.git.lorenzo@kernel.org>
 <2ed0b595a12944a8cfea14e066bcc4fa24f0ba44.1559293385.git.lorenzo@kernel.org>
 <20190612091036.GB2965@redhat.com>
 <20190612095302.GD8107@localhost.localdomain>
 <20190612102502.GB4431@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8JPrznbw0YAQ/KXy"
Content-Disposition: inline
In-Reply-To: <20190612102502.GB4431@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--8JPrznbw0YAQ/KXy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, Jun 12, 2019 at 11:53:03AM +0200, Lorenzo Bianconi wrote:
> > > On Fri, May 31, 2019 at 11:38:23AM +0200, Lorenzo Bianconi wrote:
> >=20
> > [...]
> >=20
> > > >  	}
> > > > =20
> > > >  	urb->num_sgs =3D max_t(int, i, urb->num_sgs);
> > > > -	urb->transfer_buffer_length =3D urb->num_sgs * q->buf_size,
> > > > +	urb->transfer_buffer_length =3D urb->num_sgs * data_size;
> > > >  	sg_init_marker(urb->sg, urb->num_sgs);
> > > > =20
> > > >  	return i ? : -ENOMEM;
> > > > @@ -611,8 +611,12 @@ static int mt76u_alloc_rx(struct mt76_dev *dev)
> > > >  	if (!q->entry)
> > > >  		return -ENOMEM;
> > > > =20
> > > > -	q->buf_size =3D dev->usb.sg_en ? MT_RX_BUF_SIZE : PAGE_SIZE;
> > > > +	if (dev->usb.sg_en)
> > > > +		q->buf_size =3D MT_BUF_WITH_OVERHEAD(MT_RX_BUF_SIZE);
> > >=20
> > > I strongly recommend to not doing this. While this should work
> > > in theory creating buffer with size of 2k + some bytes might
> > > trigger various bugs in dma mapping or other low level code.
> >=20
> > even in practice actually :)
>=20
> I wouldn't be sure about this. It's not common to have buffers of
> such size and crossing pages boundaries. It really can trigger
> nasty bugs on various IOMMU drivers.

I was just joking, I mean that it worked in the tests I carried out, but I
agree it can trigger some issues in buggy IOMMU drivers

>=20
> > but we can be more cautious since probably copying
> > the first 128B will not make any difference
>=20
> Not sure if I understand what you mean.

Please correct me if I am wrong but I think max amsdu rx size is 3839B for
mt76. For the sg_en case this frame will span over multiple sg buffers since
sg buffer size is 2048B (2 sg buffers). Moreover if we do not take into acc=
ount
skb_shared_info when configuring the sg buffer size we will need to always =
copy
the first 128B of the first buffer since received len will be set to 2048 a=
nd
the following if condition will always fail:

if (SKB_WITH_OVERHEAD(buf_size) >=3D MT_DMA_HDR_LEN + len) {
}

>=20
> > > And skb_shered_info is needed only in first buffer IIUC.
> > >=20
> > > Also this patch seems to make first patch unnecessary except for
> > > non sg_en case (in which I think rx AMSDU is broken anyway),
> > > so I would prefer just to apply first patch.
> >=20
> > I do not think rx AMSDU is broken for non sg_en case since the max rx v=
alue
> > allowed should be 3839 IIRC and we alloc one page in this case
>=20
> If that's the case we should be fine, but then I do not understand
> why we allocate 8*2k buffers for sg_en case, isn't that AP can
> sent AMSDU frame 16k big?

Sorry I did not get what you mean here, could you please explain?

Regards,
Lorenzo

>=20
> Stanislaw
>=20

--8JPrznbw0YAQ/KXy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXQDYrgAKCRA6cBh0uS2t
rOZCAP4xDy4uWnsqvTxCkpOzU+uPWZ99QAiJcnwjNWM+KLdRHgD9EHrvcWkZorpJ
fO4e6QPsunawatvMlEAs7yd1Zu82qAs=
=mAXI
-----END PGP SIGNATURE-----

--8JPrznbw0YAQ/KXy--
