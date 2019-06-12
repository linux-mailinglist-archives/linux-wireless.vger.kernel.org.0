Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F94E423DC
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 13:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbfFLLRc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jun 2019 07:17:32 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54543 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbfFLLRc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jun 2019 07:17:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id g135so6148902wme.4
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2019 04:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j1de1PrVPPcfkQoLPiIkuc4XOx2Yy+MlXR1vQ17+OQc=;
        b=BKpZ474S2rHhr/OLOD2xl2IOMjBscoOW0u28Dn2tkRSjrPWqCHV7Nt861xJGvv7HxL
         qqYGysUUTAuD0wdSZ6KVjaXiDHX79hWPGr5B8LBweFgCU6O26xoCCniFXsDgHwFPQycL
         ehNfrrd0oh0Ad4ALAUI0HkRDoBcKAXPMpfC6r/82iAmD2YeWMJWk64rcGZ8yR7eA4MTd
         LJiLGqeDsvr1EZkvluMpV5SwsE+Moy8X/YCoj8Zl7vh+J8w0AGIPP5IoaC7crOK7hLbH
         vVpo//+GXCaO6nH7ycUmqYp/X0Db9FfI0pQtKK+NNcxabtw+pQsbHbNd/C3MI8X5p9Im
         q1Ig==
X-Gm-Message-State: APjAAAU1p/JC8eqqXN65ynhtEYqa9NH1ePfBXOo+d1vRTrPU2jrZDQ2F
        lZcn3TJVqyBIc8iYJaJSCF4v2A==
X-Google-Smtp-Source: APXvYqxVs0JZpqxHlPJ+TtC9a3VLkTQepBjL9Z6MzBq2v6t115V7qAGgpZLE3CTnbim07dA7tJCDYA==
X-Received: by 2002:a1c:ca06:: with SMTP id a6mr22305516wmg.48.1560338250231;
        Wed, 12 Jun 2019 04:17:30 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id u1sm5561352wml.14.2019.06.12.04.17.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 04:17:29 -0700 (PDT)
Date:   Wed, 12 Jun 2019 13:17:27 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, nbd@nbd.name,
        kvalo@codeaurora.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mt76: usb: fix rx A-MSDU support
Message-ID: <20190612111726.GG8107@localhost.localdomain>
References: <cover.1559293385.git.lorenzo@kernel.org>
 <52ea155d9889aa15df44b4910806b74fa2fd9056.1559293385.git.lorenzo@kernel.org>
 <20190612085844.GA2965@redhat.com>
 <20190612094519.GC8107@localhost.localdomain>
 <20190612100014.GA4431@redhat.com>
 <20190612102133.GE8107@localhost.localdomain>
 <20190612105801.GA2600@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8S1fMsFYqgBC+BN/"
Content-Disposition: inline
In-Reply-To: <20190612105801.GA2600@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--8S1fMsFYqgBC+BN/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, Jun 12, 2019 at 12:21:34PM +0200, Lorenzo Bianconi wrote:
> > On Jun 12, Stanislaw Gruszka wrote:
> > > On Wed, Jun 12, 2019 at 11:45:21AM +0200, Lorenzo Bianconi wrote:
> > > > > > +mt76u_build_rx_skb(u8 *data, int len, int buf_size,
> > > > > > +		   int *nsgs)
> > > > > > +{
> > > > > > +	int data_len =3D min(len, MT_SKB_HEAD_LEN);
> > >=20
> > > Oh, and this looks unneeded as well as for len < MT_SKB_HEAD_LEN=3D128
> > > we will go through fast path.
> >=20
> > I guess if we remove data_len =3D min(len, MT_SKB_HEAD_LEN) and even *n=
sgs =3D 0 at
> > the end we are making some assumptions on the value of MT_SKB_HEAD_LEN =
and
> > buf_size. In the patch I just avoided them but maybe we can just assume=
 that
> > MT_SKB_HEAD_LEN and buf_size will not changed in the future. What do you
> > think?
>=20
> Yes, sure. Other drivers just use 128 value directly and don't even
> create a macro for that. And if somebody will decide to change
> buf_size it will not be small value.

Ok, I will simplify it in v2

>=20
> > > > > mt7601u and iwlmvm just copy hdrlen + 8 and put the rest
> > > > > of the buffer in fragment, which supose to be more efficient,
> > > > > see comment in iwl_mvm_pass_packet_to_mac80211().
> > > >=20
> > > > Right here we copy 128B instead of 32 but I think it is good to hav=
e L3 and L4
> > > > header in the linear area of the skb since otherwise the stack will=
 need to
> > > > align them
> > >=20
> > > Not sure if understand, I think aliment of L3 & L4 headers will be
> > > the same, assuming ieee80211 header is aligned the same in fragment
> > > buffer and in linear area. But if you think this is better to copy th=
ose
> > > to linear area I'm ok with that.
> >=20
> > Sorry I have not been so clear. I mean in the stack before accessing a =
given
> > header we will run pskb_may_pull() that can end up copying the skb if t=
here is
> > not enough space in the skb->head
>=20
> Ok, so L3 and L4 headers should be in linear area of skb and if not=20
> network stack will copy them from fragment. But I wonder why other
> drivers just copy ieee80211_hdr and SNAP ? Isn't that if we copy=20
> 128B then is possible that part of the payload will be in linear
> area and part in fragment, whereas is expected that payload
> will not be broken into two parts?

I think the payload can be split in multiple skb fragments, the constraint =
is
just related to header parsing

Regards,
Lorenzo



>=20
> Stanislaw

--8S1fMsFYqgBC+BN/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXQDfQwAKCRA6cBh0uS2t
rDDtAP491tp1JlE/akouftzGYRMlKSFeVSnWrNE/liO3+QT1fQEA49O/6PzYH2w2
hRNTIaoDE/4Bp8Y9iIYs8X/Acw4Ubwk=
=ROjx
-----END PGP SIGNATURE-----

--8S1fMsFYqgBC+BN/--
