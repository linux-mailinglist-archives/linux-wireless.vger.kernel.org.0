Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C08A45A49
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2019 12:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfFNKWx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jun 2019 06:22:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36648 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbfFNKWx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jun 2019 06:22:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so1957978wrs.3
        for <linux-wireless@vger.kernel.org>; Fri, 14 Jun 2019 03:22:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8dmny85pTHsSMLFRK/EiaLw3gs7X12IKAEEUiHquVPk=;
        b=pJRDGN8RErkcbm79zg5Ewhj1Yg3GKPsNyAV7wE7zdj6aQnbaFu/00/bTSXva3X3lxr
         C82/jn1VVDQzInGmLQGh93heQpdX7K++vykkdnYKYlaXEKcuigvDOKDSrVZ/DII5c5jM
         HWML6o3aCmVUgkXo+XvC1F7F7Kr2bZ9E0baQUbBsdzKz8AJnymrDzKFsb2dNwmOup8XZ
         w1OAnZX+CYiXxjq9U6U0F+/3w+KWKHP8RtBrFFjzp6fVFAd5+4kbIez0ZOIO+gEwB6NY
         wE47CZTF1lbfYwedlE6N3WcjRjOKMD7LxGivZw2qUf46cY1hrj8dxKc9SXmWUuAT7oo/
         V2zQ==
X-Gm-Message-State: APjAAAUOlSvJt6CNuS9nT897+Wsc5cM2Fh3UHaS6YIODLlaLdlJFiS4O
        zU0qTfuTwM10qMvoHoG1ATZPKQ==
X-Google-Smtp-Source: APXvYqxz0FoxSnzHgLA0rXjkXxlAwsTXxQOQocCkeXkf49PsLwES3qQesVyUhVu8K3zrR+DErWUpKA==
X-Received: by 2002:a5d:4a90:: with SMTP id o16mr5384294wrq.13.1560507771056;
        Fri, 14 Jun 2019 03:22:51 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id a3sm2211571wmb.35.2019.06.14.03.22.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 03:22:50 -0700 (PDT)
Date:   Fri, 14 Jun 2019 12:22:48 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, kvalo@codeaurora.org,
        linux-wireless@vger.kernel.org, nbd@nbd.name
Subject: Re: [PATCH v3 wireless-drivers 3/3] mt76: usb: do not always copy
 the first part of received frames
Message-ID: <20190614102247.GB2669@localhost.localdomain>
References: <cover.1560461404.git.lorenzo@kernel.org>
 <1a9566c0a41ad0d940487a9d3f0008993c075ef2.1560461404.git.lorenzo@kernel.org>
 <20190614075303.GB3395@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
Content-Disposition: inline
In-Reply-To: <20190614075303.GB3395@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, Jun 13, 2019 at 11:43:13PM +0200, Lorenzo Bianconi wrote:
> > Set usb buffer size taking into account skb_shared_info in order to
> > not always copy the first part of received frames if A-MSDU is enabled
> > for SG capable devices. Moreover align usb buffer size to max_ep
> > boundaries and set buf_size to PAGE_SIZE even for sg case
>=20
> I think this should not be applied to wirless-drivers, only first patch
> that fix the bug and optimizations should be done in -next.

ack, right. I think patch 2/3 and 3/3 can go directly in Felix's tree

>=20
> > +	int i, data_size;
> > =20
> > +	data_size =3D rounddown(SKB_WITH_OVERHEAD(q->buf_size),
> > +			      dev->usb.in_ep[MT_EP_IN_PKT_RX].max_packet);
> >  	for (i =3D 0; i < nsgs; i++) {
> >  		struct page *page;
> >  		void *data;
> > @@ -302,7 +304,7 @@ mt76u_fill_rx_sg(struct mt76_dev *dev, struct mt76_=
queue *q, struct urb *urb,
> > =20
> >  		page =3D virt_to_head_page(data);
> >  		offset =3D data - page_address(page);
> > -		sg_set_page(&urb->sg[i], page, q->buf_size, offset);
> > +		sg_set_page(&urb->sg[i], page, data_size, offset);
> <snip>
> > -	q->buf_size =3D dev->usb.sg_en ? MT_RX_BUF_SIZE : PAGE_SIZE;
> >  	q->ndesc =3D MT_NUM_RX_ENTRIES;
> > +	q->buf_size =3D PAGE_SIZE;
> > +
>=20
> This should be associated with decrease of MT_SG_MAX_SIZE to value that
> is actually needed and currently this is 2 for 4k AMSDU.

MT_SG_MAX_SIZE is used even on tx side and I do not think we will end up wi=
th a
huge difference here

>=20
> However I don't think allocating 2 pages to avoid ieee80211 header and SN=
AP
> copy is worth to do. For me best approach would be allocate 1 page for
> 4k AMSDU, 2 for 8k and 3 for 12k (still using sg, but without data_size
> change to avoid 32B copying).

=46rom my point of view it is better to avoid copying if it is possible. Ar=
e you
sure there is no difference?

Regards,
Lorenzo

>=20
> Stanislaw

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXQN1dAAKCRA6cBh0uS2t
rI7pAP0ebDhzTgKi0vXfNqezYTetbQ2W3unzKo1krbgT/Et01QD/Y3azDk75Y/Hd
PdzSONdGoeQQI8GGk+rBEMS90gz2OQ0=
=YcOb
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--
