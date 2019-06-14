Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBDA45D24
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2019 14:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbfFNMqm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jun 2019 08:46:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44195 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbfFNMqm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jun 2019 08:46:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id r16so2370661wrl.11
        for <linux-wireless@vger.kernel.org>; Fri, 14 Jun 2019 05:46:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dtpGu947f+kuYlzl6Zkpl6cqZLvCpE24ultOtZXG/6k=;
        b=AJ9hdj6SWlHmduOZK/E+/MjyONosWYJFYoUK6LIcCTo7lW9FxSXi0/6W0/mbDzL+G7
         s4VsG3S0rQxqHX6QPYLJ5ArgM/ON3X9cZhtCtoDMYtFKd4Kx7mIVOltfNQiPDjeIQnbk
         lu4LjU1VJdClqUPo7Ed73buX7LEepGGet6pdiQQlk3JVKU336wGn5ekZDJOWu3ve8jLw
         qOgHNkuhWB7oLiTDsbzgj9DMFy2Af6EdpyeZdEjuzOhpk8CdQ7up7Py8lekqdlFNdvlt
         BYhdzgWvv8reyiIwWGv2UtxNEZvsdfSRSQhjcJxuzfVG7XK+WS7gf9JJbURHBiWY/F1l
         o3zA==
X-Gm-Message-State: APjAAAXeMbGqat7mxS73mYQ+s+XJfQ1MUa8Eg83nz+gDSIC8n9Y4Y2OE
        cBmtLlAeFMkW9UxwurUUWsFvhA==
X-Google-Smtp-Source: APXvYqxJt2wDI6zU57KDvevylmmhkzZDOrc/32J03SCP29HB3p/xgUC3AZjHlwKNG+ZwQRCt8nRJGQ==
X-Received: by 2002:adf:8367:: with SMTP id 94mr14238437wrd.179.1560516399590;
        Fri, 14 Jun 2019 05:46:39 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id r3sm4715994wrr.61.2019.06.14.05.46.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 05:46:38 -0700 (PDT)
Date:   Fri, 14 Jun 2019 14:46:36 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, kvalo@codeaurora.org,
        linux-wireless@vger.kernel.org, nbd@nbd.name
Subject: Re: [PATCH v3 wireless-drivers 3/3] mt76: usb: do not always copy
 the first part of received frames
Message-ID: <20190614124635.GD2669@localhost.localdomain>
References: <cover.1560461404.git.lorenzo@kernel.org>
 <1a9566c0a41ad0d940487a9d3f0008993c075ef2.1560461404.git.lorenzo@kernel.org>
 <20190614075303.GB3395@redhat.com>
 <20190614102247.GB2669@localhost.localdomain>
 <20190614110442.GA17298@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lc9FT7cWel8HagAv"
Content-Disposition: inline
In-Reply-To: <20190614110442.GA17298@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--lc9FT7cWel8HagAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri, Jun 14, 2019 at 12:22:48PM +0200, Lorenzo Bianconi wrote:
> > > On Thu, Jun 13, 2019 at 11:43:13PM +0200, Lorenzo Bianconi wrote:
> > > > Set usb buffer size taking into account skb_shared_info in order to
> > > > not always copy the first part of received frames if A-MSDU is enab=
led
> > > > for SG capable devices. Moreover align usb buffer size to max_ep
> > > > boundaries and set buf_size to PAGE_SIZE even for sg case
> > >=20
> > > I think this should not be applied to wirless-drivers, only first pat=
ch
> > > that fix the bug and optimizations should be done in -next.
> >=20
> > ack, right. I think patch 2/3 and 3/3 can go directly in Felix's tree
> >=20
> > >=20
> > > > +	int i, data_size;
> > > > =20
> > > > +	data_size =3D rounddown(SKB_WITH_OVERHEAD(q->buf_size),
> > > > +			      dev->usb.in_ep[MT_EP_IN_PKT_RX].max_packet);
> > > >  	for (i =3D 0; i < nsgs; i++) {
> > > >  		struct page *page;
> > > >  		void *data;
> > > > @@ -302,7 +304,7 @@ mt76u_fill_rx_sg(struct mt76_dev *dev, struct m=
t76_queue *q, struct urb *urb,
> > > > =20
> > > >  		page =3D virt_to_head_page(data);
> > > >  		offset =3D data - page_address(page);
> > > > -		sg_set_page(&urb->sg[i], page, q->buf_size, offset);
> > > > +		sg_set_page(&urb->sg[i], page, data_size, offset);
> > > <snip>
> > > > -	q->buf_size =3D dev->usb.sg_en ? MT_RX_BUF_SIZE : PAGE_SIZE;
> > > >  	q->ndesc =3D MT_NUM_RX_ENTRIES;
> > > > +	q->buf_size =3D PAGE_SIZE;
> > > > +
> > >=20
> > > This should be associated with decrease of MT_SG_MAX_SIZE to value th=
at
> > > is actually needed and currently this is 2 for 4k AMSDU.
> >=20
> > MT_SG_MAX_SIZE is used even on tx side and I do not think we will end u=
p with a
> > huge difference here
>=20
> So use different value as argument for mt76u_fill_rx_sg() in
> mt76u_rx_urb_alloc(). After changing buf_size to PAGE_SIZE we will
> allocate 8 pages per rx queue entry, but only 2 pages will be used
> (with data_size change, 1 without data_size change). Or I'm wrong?

yes, it is right (we will use two pages with data_size change). Maybe bette=
r to
use 4 pages for each rx queue entry? (otherwise we will probably change it =
in
the future)

>=20
> > > However I don't think allocating 2 pages to avoid ieee80211 header an=
d SNAP
> > > copy is worth to do. For me best approach would be allocate 1 page for
> > > 4k AMSDU, 2 for 8k and 3 for 12k (still using sg, but without data_si=
ze
> > > change to avoid 32B copying).
> >=20
> > From my point of view it is better to avoid copying if it is possible. =
Are you
> > sure there is no difference?
>=20
> I do not understand what you mean by difference here.

tpt differences, not sure if there are any

Regards,
Lorenzo

>=20
> Stanislaw

--lc9FT7cWel8HagAv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXQOXKAAKCRA6cBh0uS2t
rB7QAQCfJt10qzCycycy6teI+eEpLE4CpHVuDrxLhG8au3oHfAD+Ikwz4MStc1UG
D31AjocPFjIh8yEFmfvU9dPYGQl9vAo=
=XVwB
-----END PGP SIGNATURE-----

--lc9FT7cWel8HagAv--
