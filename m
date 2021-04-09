Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E00835A855
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Apr 2021 23:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbhDIV1c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Apr 2021 17:27:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:60284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233687AbhDIV1b (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Apr 2021 17:27:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6900761181;
        Fri,  9 Apr 2021 21:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618003637;
        bh=4Z3jo0gVUZsnT4o5V8Qu+t76Hsi2F24EpdfhvZYCv+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bglBJ11H4X3uf1B7jKTyYQfuiQmUU4ak6Wp9H2BWAG4gZGy22PQE7/sHXF1rTBN+l
         yQYEJ63TwvMBnn68iNas8q74BUu+pycFaW8C8diwhLl1mmuhpg0oNmGZa+M6T7yvBP
         oaf/O3XFHRceamNCS25LmsBDk735AntIxwyTNydgkarh04UfEHYdd8Cwbjcd32BxL/
         46IlH8B6fTYA7B0uN0Yb19PLlB8nIY7ruPi0N+6duyIRqGgbReDGFCZeAknL45bHtL
         BCHzU0dOKvMVx920cBQzuIJQBsx+LG9szASogn8eCFF7s0knMEYfeB2YT/SumBsBSe
         I25uF2ZZ1qnUA==
Date:   Fri, 9 Apr 2021 23:27:13 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, shayne.chen@mediatek.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/8] dt-bindings:net:wireless:ieee80211: introduce
 regdomain property
Message-ID: <YHDGsYmuYmP80ICh@lore-desk>
References: <cover.1617625912.git.lorenzo@kernel.org>
 <1ff764d84e1fb83768c2e9d233c27b0ed1ef4294.1617625912.git.lorenzo@kernel.org>
 <20210409151324.GA3662358@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y4CXlUu0agZS+St2"
Content-Disposition: inline
In-Reply-To: <20210409151324.GA3662358@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--y4CXlUu0agZS+St2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, Apr 05, 2021 at 02:40:25PM +0200, Lorenzo Bianconi wrote:
> > Add regdomain property to ieee80211 binding
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  .../devicetree/bindings/net/wireless/ieee80211.yaml      | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/net/wireless/ieee80211.y=
aml b/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
> > index d58e1571df9b..6557c6348cac 100644
> > --- a/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
> > +++ b/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
> > @@ -30,6 +30,15 @@ properties:
> >        different 5 GHz subbands. Using them incorrectly could not work =
or
> >        decrease performance noticeably
> > =20
> > +  regdomain:
> > +    minItems: 1
> > +    maxItems: 1
> > +    contains:
>=20
> If only 1 entry, then 'contains' is pointless. Just 'enum' is enough.=20
> You also need a 'description'.

ack, I will fix it in v2 moving it in mt76.yaml patch

Regards,
Lorenzo

>=20
> > +      enum:
> > +        - FCC
> > +        - ETSI
> > +        - JP
> > +
> >  additionalProperties: true
> > =20
> >  examples:
> > --=20
> > 2.30.2
> >=20

--y4CXlUu0agZS+St2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYHDGrgAKCRA6cBh0uS2t
rJaoAQD8hu+pN4T2G5mVXS2ffyj+GbhRE7mYJy2jasOHYj/P+QEAthlYPEt6EHsh
T8B/LJK4DvbgbQugALPWZS/ou6BynA4=
=CiW1
-----END PGP SIGNATURE-----

--y4CXlUu0agZS+St2--
