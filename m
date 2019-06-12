Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA1BE42174
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 11:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437737AbfFLJxI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jun 2019 05:53:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39892 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437415AbfFLJxI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jun 2019 05:53:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id x4so13523762wrt.6
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2019 02:53:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VVhE7iZd36zR1LOe4i7mf8BRoSS45j81UOesfJcvyiA=;
        b=h8yc92XxmkSg1PzCyfukGwjh1H1hWYBGyshJuNDSa6IfjQYnhMApJLM+JFU0JlFCfM
         Ore3bhibuhiak6eWou6xzpqqzC/mlN5yHLOteKLRY5Lc210/6X3x15QZ8iLqMJbR3/pV
         NQArXGeVVjC5HPonPXe7gtboEsQ9L3Sg5BqxnrmXDg2Oy/+QUb9BpGT4SH1RFcc2vYcF
         7KcJXA38SnfJVge9ET9lQO108+H3UWaSfGUrKzMex6HrE3wZYdL63oesZ5SLpSX+StmZ
         rkUTpG1JPq5Hff+AeOEd2alWBR28Gtrd2eX3J5JkEzExi8koHW2RepUixcqrPC9FULDX
         TCTw==
X-Gm-Message-State: APjAAAVlz1ehYYGSUCXeiav91awx0hTKzZNz170pT6RBGd25CdnlYpCN
        xAhGRo3NWlTgo710L2VRg+TZxg==
X-Google-Smtp-Source: APXvYqylaKKe04PWmg6OFzVdLzP0QmzyjGVKfeBvl1N4aC+29oVkWS24CzujtOUm0kaIWTNY4QCSRg==
X-Received: by 2002:adf:f909:: with SMTP id b9mr20595666wrr.119.1560333185919;
        Wed, 12 Jun 2019 02:53:05 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id s12sm3681516wmh.34.2019.06.12.02.53.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 02:53:05 -0700 (PDT)
Date:   Wed, 12 Jun 2019 11:53:03 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, nbd@nbd.name,
        kvalo@codeaurora.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mt76: usb: do not always copy the first part of
 received frames
Message-ID: <20190612095302.GD8107@localhost.localdomain>
References: <cover.1559293385.git.lorenzo@kernel.org>
 <2ed0b595a12944a8cfea14e066bcc4fa24f0ba44.1559293385.git.lorenzo@kernel.org>
 <20190612091036.GB2965@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Km1U/tdNT/EmXiR1"
Content-Disposition: inline
In-Reply-To: <20190612091036.GB2965@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--Km1U/tdNT/EmXiR1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri, May 31, 2019 at 11:38:23AM +0200, Lorenzo Bianconi wrote:

[...]

> >  	}
> > =20
> >  	urb->num_sgs =3D max_t(int, i, urb->num_sgs);
> > -	urb->transfer_buffer_length =3D urb->num_sgs * q->buf_size,
> > +	urb->transfer_buffer_length =3D urb->num_sgs * data_size;
> >  	sg_init_marker(urb->sg, urb->num_sgs);
> > =20
> >  	return i ? : -ENOMEM;
> > @@ -611,8 +611,12 @@ static int mt76u_alloc_rx(struct mt76_dev *dev)
> >  	if (!q->entry)
> >  		return -ENOMEM;
> > =20
> > -	q->buf_size =3D dev->usb.sg_en ? MT_RX_BUF_SIZE : PAGE_SIZE;
> > +	if (dev->usb.sg_en)
> > +		q->buf_size =3D MT_BUF_WITH_OVERHEAD(MT_RX_BUF_SIZE);
>=20
> I strongly recommend to not doing this. While this should work
> in theory creating buffer with size of 2k + some bytes might
> trigger various bugs in dma mapping or other low level code.

even in practice actually :) but we can be more cautious since probably cop=
ying
the first 128B will not make any difference

>=20
> And skb_shered_info is needed only in first buffer IIUC.
>=20
> Also this patch seems to make first patch unnecessary except for
> non sg_en case (in which I think rx AMSDU is broken anyway),
> so I would prefer just to apply first patch.

I do not think rx AMSDU is broken for non sg_en case since the max rx value
allowed should be 3839 IIRC and we alloc one page in this case

Regards,
Lorenzo

>=20
> Stanislaw
>=20

--Km1U/tdNT/EmXiR1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXQDLewAKCRA6cBh0uS2t
rB0vAP9wHIDCzMk96w27Q43y4bLilwtfv6S0/moHO8BdQFcNNQD/b3M4xvKXhmZz
MlPFDgseZcnXMGhZXVaZ/DRaK9L8mQ0=
=3Ukz
-----END PGP SIGNATURE-----

--Km1U/tdNT/EmXiR1--
