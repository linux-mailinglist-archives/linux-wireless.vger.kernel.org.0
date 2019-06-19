Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85CA54C219
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2019 22:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfFSUJP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Jun 2019 16:09:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33920 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfFSUJP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Jun 2019 16:09:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id k11so600854wrl.1
        for <linux-wireless@vger.kernel.org>; Wed, 19 Jun 2019 13:09:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vDOHCyvMK/Vb7odmOhJJhUOHp65K6oTP+Z5A/bmIxdM=;
        b=bpIJz2qou1QOmq763a6/EVtgPQl61NYmBpOX6dmhDXIryVU63jS3GUUItQ9UjVR9uL
         DUFZ9qA2Lako/mhkfYUIgY2Qz+E+vddfgqHPd2XHn/hcgVyPZwRIdTWiwJ/AUnPwI1f4
         fU5W2Nwb8XfWNnKLzXQbdofAi36arbfDOE1aPMSN67nHRVrPHQwvDDIqQhDwSL+2qwqM
         22d/CYQHQ4XCu6Tr2x0LTjSR7nr2J1jCZ0Hts9lG3RCF4MiEuwCJci+pCf5I74VNBT6u
         ajcpUV9n400iZUziV6rj7yUMkZfRnXmzNoUzmMk643h9b8LzzAxvQEEYig2QZ7VY06iG
         a/xA==
X-Gm-Message-State: APjAAAXkKUB7E9DeMRVumIE0L6fD3TwfKTyZE1k56LFfnuqNcDslAT7Q
        /12d08ziG4u0wsVIEgxw+CeEeA==
X-Google-Smtp-Source: APXvYqz9Xpfb5anMktOhqf1eTTzMC0XonQqPfIg8VqohVHFAg5pCXal3HtPqRKlpfrYXiQe/iA7R5w==
X-Received: by 2002:adf:ebcd:: with SMTP id v13mr13393080wrn.263.1560974952650;
        Wed, 19 Jun 2019 13:09:12 -0700 (PDT)
Received: from lore-desk-wlan ([151.66.61.123])
        by smtp.gmail.com with ESMTPSA id r131sm2731444wmf.4.2019.06.19.13.09.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 13:09:12 -0700 (PDT)
Date:   Wed, 19 Jun 2019 22:09:09 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, kvalo@codeaurora.org,
        linux-wireless@vger.kernel.org, nbd@nbd.name
Subject: Re: [PATCH v3 wireless-drivers 3/3] mt76: usb: do not always copy
 the first part of received frames
Message-ID: <20190619200908.GA31657@lore-desk-wlan>
References: <cover.1560461404.git.lorenzo@kernel.org>
 <1a9566c0a41ad0d940487a9d3f0008993c075ef2.1560461404.git.lorenzo@kernel.org>
 <20190614075303.GB3395@redhat.com>
 <20190614102247.GB2669@localhost.localdomain>
 <20190614110442.GA17298@redhat.com>
 <20190614124635.GD2669@localhost.localdomain>
 <20190615094016.GA20197@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <20190615094016.GA20197@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri, Jun 14, 2019 at 02:46:36PM +0200, Lorenzo Bianconi wrote:
> > > >=20
> > > > ack, right. I think patch 2/3 and 3/3 can go directly in Felix's tr=
ee
> > > >=20
> > > > >=20
> > > > > > +	int i, data_size;
> > > > > > =20
> > > > > > +	data_size =3D rounddown(SKB_WITH_OVERHEAD(q->buf_size),
> > > > > > +			      dev->usb.in_ep[MT_EP_IN_PKT_RX].max_packet);
> > > > > >  	for (i =3D 0; i < nsgs; i++) {
> > > > > >  		struct page *page;
> > > > > >  		void *data;
> > > > > > @@ -302,7 +304,7 @@ mt76u_fill_rx_sg(struct mt76_dev *dev, stru=
ct mt76_queue *q, struct urb *urb,
> > > > > > =20
> > > > > >  		page =3D virt_to_head_page(data);
> > > > > >  		offset =3D data - page_address(page);
> > > > > > -		sg_set_page(&urb->sg[i], page, q->buf_size, offset);
> > > > > > +		sg_set_page(&urb->sg[i], page, data_size, offset);
> > > > > <snip>
> > > > > > -	q->buf_size =3D dev->usb.sg_en ? MT_RX_BUF_SIZE : PAGE_SIZE;
> > > > > >  	q->ndesc =3D MT_NUM_RX_ENTRIES;
> > > > > > +	q->buf_size =3D PAGE_SIZE;
> > > > > > +
> > > > >=20
> > > > > This should be associated with decrease of MT_SG_MAX_SIZE to valu=
e that
> > > > > is actually needed and currently this is 2 for 4k AMSDU.
> > > >=20
> > > > MT_SG_MAX_SIZE is used even on tx side and I do not think we will e=
nd up with a
> > > > huge difference here
> > >=20
> > > So use different value as argument for mt76u_fill_rx_sg() in
> > > mt76u_rx_urb_alloc(). After changing buf_size to PAGE_SIZE we will
> > > allocate 8 pages per rx queue entry, but only 2 pages will be used
> > > (with data_size change, 1 without data_size change). Or I'm wrong?
> >=20
> > yes, it is right (we will use two pages with data_size change). Maybe b=
etter to
> > use 4 pages for each rx queue entry? (otherwise we will probably change=
 it in
> > the future)
>=20
> We should not allocate more than is required. If support for bigger
> rx AMSDUs will be added and announced in vht/ht capabilities to remote
> stations, then increase of number of segments will be needed.
>=20
> > > > > However I don't think allocating 2 pages to avoid ieee80211 heade=
r and SNAP
> > > > > copy is worth to do. For me best approach would be allocate 1 pag=
e for
> > > > > 4k AMSDU, 2 for 8k and 3 for 12k (still using sg, but without dat=
a_size
> > > > > change to avoid 32B copying).
> > > >=20
> > > > From my point of view it is better to avoid copying if it is possib=
le. Are you
> > > > sure there is no difference?
> > >=20
> > > I do not understand what you mean by difference here.
> >=20
> > tpt differences, not sure if there are any
>=20
> I would not expect any measurable difference in tpt nor in cpu usage
> either way.
>=20
> But I think, if some AMSDU subframe will be spited into two fragments,
> data most likely will need to be linearised/copied, at some point before
> passed to application, what will overcome any benefit of avoiding coping
> 802.11 header. Thought, I don't think this somehow will be visible in
> benchmarking.

Sorry for the late reply. I think so.
I will post a v4 soon.

Regards,
Lorenzo

>=20
> Stanislaw

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXQqWYQAKCRA6cBh0uS2t
rCyfAP46TBPYzq84Lab3fUrA/jmFXXAKOSdiM1Ff806lZXDpMwD/Qy+haDSTSGRA
zz+nYDwDEohDprlWUfbxU+cdEyZ7og8=
=AvEW
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
