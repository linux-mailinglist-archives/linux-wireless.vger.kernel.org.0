Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D990F425BD
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 14:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406162AbfFLM2x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jun 2019 08:28:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40107 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbfFLM2x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jun 2019 08:28:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id p11so16706941wre.7
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2019 05:28:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wOI50hz2miBWNTk9p+QKCu63hJI9jM//4084I5DdVT4=;
        b=Kc3NqlZ/d9KGUUoX0anSvThsXcds6fx1qHbYFqU3G27jpvMhMZnCriA3ULAn7H0eq/
         UTb07+pBVnN8IkK4QHZXLWEoeLW92yQ+Y8lQVzehnEMYRvN/rxoI/ZhS6u7PZSvO5TsS
         pKBeJiD9dOQWxzYVyaCMpq6sSvXQaRXbof8QIFcFpyLKPjlFyoH+sR7b+1K6qyNtuKQy
         QUEHJkxOnboTa2jxonUDP8AgmLVh76/9y4jotaITXivik1EGTGFl9DLHKH5+jrU/6lu6
         SgsYCHrA/ilo8PRN3uXwJOu+PCevS42pNCYzAuLZc3+KPh+iiLdYqqAwj0EWvnjyCuCd
         VP0Q==
X-Gm-Message-State: APjAAAUi0bNyKFgzLcSIN5jsg57e0T6N1J9BMDRK1wrYBk2Lyd/DGjBW
        NVkry1ohBuq1aR6q295i/lakQQ==
X-Google-Smtp-Source: APXvYqzPZJ1AKIXvFNuQkNHYgJgSoOJBnCkksffkpptFJdFyb/sNEre45JFukWJyXL1X6G4T7qpCFA==
X-Received: by 2002:adf:ff84:: with SMTP id j4mr28488817wrr.151.1560342531399;
        Wed, 12 Jun 2019 05:28:51 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id v13sm3470434wmj.46.2019.06.12.05.28.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 05:28:50 -0700 (PDT)
Date:   Wed, 12 Jun 2019 14:28:48 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, nbd@nbd.name,
        kvalo@codeaurora.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mt76: usb: do not always copy the first part of
 received frames
Message-ID: <20190612122845.GH8107@localhost.localdomain>
References: <cover.1559293385.git.lorenzo@kernel.org>
 <2ed0b595a12944a8cfea14e066bcc4fa24f0ba44.1559293385.git.lorenzo@kernel.org>
 <20190612091036.GB2965@redhat.com>
 <20190612095302.GD8107@localhost.localdomain>
 <20190612102502.GB4431@redhat.com>
 <20190612104921.GF8107@localhost.localdomain>
 <20190612115120.GA3496@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+QwZB9vYiNIzNXIj"
Content-Disposition: inline
In-Reply-To: <20190612115120.GA3496@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--+QwZB9vYiNIzNXIj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[...]
>=20
> My sense of humor declined quite drastically lastly ;-/
>=20
> > > > but we can be more cautious since probably copying
> > > > the first 128B will not make any difference
> > >=20
> > > Not sure if I understand what you mean.
> >=20
> > Please correct me if I am wrong but I think max amsdu rx size is 3839B =
for
> > mt76. For the sg_en case this frame will span over multiple sg buffers =
since
> > sg buffer size is 2048B (2 sg buffers). Moreover if we do not take into=
 account
> > skb_shared_info when configuring the sg buffer size we will need to alw=
ays copy
> > the first 128B of the first buffer since received len will be set to 20=
48 and
> > the following if condition will always fail:
> >=20
> > if (SKB_WITH_OVERHEAD(buf_size) >=3D MT_DMA_HDR_LEN + len) {
> > }
>=20
> Ok, that I understand.
>=20
> > > > > And skb_shered_info is needed only in first buffer IIUC.
> > > > >=20
> > > > > Also this patch seems to make first patch unnecessary except for
> > > > > non sg_en case (in which I think rx AMSDU is broken anyway),
> > > > > so I would prefer just to apply first patch.
> > > >=20
> > > > I do not think rx AMSDU is broken for non sg_en case since the max =
rx value
> > > > allowed should be 3839 IIRC and we alloc one page in this case
> > >=20
> > > If that's the case we should be fine, but then I do not understand
> > > why we allocate 8*2k buffers for sg_en case, isn't that AP can
> > > sent AMSDU frame 16k big?
> >=20
> > Sorry I did not get what you mean here, could you please explain?
>=20
> If max RX AMSDU size is 3839B I do not see reason why we allocate
> MT_SG_MAX_SIZE=3D8 of MT_RX_BUF_SIZE=3D2k buffers for sg_en case.
> I thought the reason is that max AMSDU size is 16kB so it fit into
> 8 sg buffers of 2k.
>=20
> In other words, for me, looks like either
> - we can not handle AMSDU for non sg case because we do not
> allocate big enough buffer

I think AMSDU is mandatory and we currently support it even for non-sg case
(since max rx AMSDU is 3839B)

> or
> - we can just use one PAGE_SIZE buffer for rx and remove sg
> buffers for rx completely=20

using sg buffers we can support bigger rx AMSDU size in the future without =
using
huge buffers (e.g. we can try to use IEEE80211_MAX_MPDU_LEN_HT_7935 with
mt76x2u)

Regards,
Lorenzo

>=20
> Do I miss something ?
>=20
> Stanislaw

--+QwZB9vYiNIzNXIj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXQDv+gAKCRA6cBh0uS2t
rIZVAQDOX/3izMO+2QI5CgHjot8A94v5ougnMh8SCC6TigbznAEAuSvrnfKDj8uf
5lZ1Ai68Xsw3Fe3K/jj83MyrJKoyXgw=
=vTVV
-----END PGP SIGNATURE-----

--+QwZB9vYiNIzNXIj--
