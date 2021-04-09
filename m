Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1530B35A8F8
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Apr 2021 00:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbhDIWvP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Apr 2021 18:51:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234602AbhDIWvP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Apr 2021 18:51:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D22661165;
        Fri,  9 Apr 2021 22:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618008661;
        bh=+KgleEtKqIhzP+Cy94v03oFaDcjb76xz/jjO3FAMltc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QcjluBCgzRnDIQ7rkemmWk8EMF6xpRh+nQQSm54sgu486CG39gfYXCdGJRlr/RNTO
         bMqr0R6pf79ZOzQEATsFjBVqfAJv+ll66EurT35dhouUaM7TUv0pt37/h25oHuyNsS
         nRTCEosd4LUOrFCqtfcj8cjjcYLdpNBP5Ts+Fp9zcbX+eWJNiwn2ktY2pIIgK5Xm9h
         yuxhD/d58M5CBLoltaY/xyn/LoBLYRZ2CAvE0DsQ3Tw9tQKHRRY7SXyL/RV5Uzm7/q
         3UIbKbmDKbcz9/9zVbHP5evtkAMLuSnOlZRqAMhi0oQWRElaoRgRZVwnmG+QSLqaw5
         RgSyaGOTY/3+g==
Date:   Sat, 10 Apr 2021 00:50:57 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, shayne.chen@mediatek.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/8] dt-bindings:net:wireless:mediatek,mt76: introduce
 power-limits node
Message-ID: <YHDaUcbhVBJDMskE@lore-desk>
References: <cover.1617625912.git.lorenzo@kernel.org>
 <eb6998d12c7f60a28c7f3eab455d4339656f76e2.1617625912.git.lorenzo@kernel.org>
 <20210409152236.GB3662358@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0jLZZTbisDFIV8aG"
Content-Disposition: inline
In-Reply-To: <20210409152236.GB3662358@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--0jLZZTbisDFIV8aG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, Apr 05, 2021 at 02:40:26PM +0200, Lorenzo Bianconi wrote:
> > Introduce power-limits node in mt76 binding in order to specify
> > per-rate power limit values for each 802.11n/802.11ac rate
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  .../bindings/net/wireless/mediatek,mt76.yaml  | 79 +++++++++++++++++++
> >  1 file changed, 79 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/net/wireless/mediatek,mt=
76.yaml b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
> > index d6f835d17d66..6ede331e3e52 100644
> > --- a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
> > +++ b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
> > @@ -72,6 +72,62 @@ properties:
> >        led-sources:
> >          maxItems: 1
> > =20
> > +  power-limits:
> > +    type: object
> > +    properties:
> > +      regdomain: true
>=20
> This shouldn't really be in ieee80211.yaml if it belongs under=20
> 'power-limits' node. You may need a 2nd power limits schema if this=20
> something that should/can be common.

ack, I will fix it in v2

>=20
> > +
> > +    patternProperties:
> > +      "^r[0-9]+":
> > +        type: object
> > +        patternProperties:
> > +          "^txpower-[256]g$":
> > +            type: object
> > +            patternProperties:
> > +              "^b[0-9]+$":
> > +                type: object
> > +                properties:
> > +                  channels:
> > +                    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +                    minItems: 2
> > +                    maxItems: 2
> > +                    description:
> > +                      Pairs of first and last channel number of the se=
lected
> > +                      band
> > +
> > +                  cck:
> > +                    $ref: /schemas/types.yaml#/definitions/uint32-array
>=20
> What's the range of values? Could be 8-bit?

yes, I will fix it in v2

>=20
> > +                    minItems: 4
> > +                    maxItems: 4
> > +                    description:
> > +                      4 half-dBm per-rate power limit values
> > +
> > +                  mcs:
> > +                    $ref: /schemas/types.yaml#/definitions/uint32-matr=
ix
> > +                    description:
> > +                      Sets of per-rate power limit values for 802.11n/=
802.11ac
> > +                      rates for multiple channel bandwidth settings.
> > +                      Each set starts with the number of channel bandw=
idth
> > +                      settings for which the rate set applies, followe=
d by
> > +                      either 8 or 10 power limit values. The order of =
the
> > +                      channel bandwidth settings is 20, 40, 80 and 160=
 MHz.
> > +
> > +                  ru:
> > +                    $ref: /schemas/types.yaml#/definitions/uint32-matr=
ix
> > +                    description:
> > +                      Sets of per-rate power limit values for 802.11ax=
 rates
> > +                      for multiple channel bandwidth or resource unit =
settings.
> > +                      Each set starts with the number of channel bandw=
idth or
> > +                      resource unit settings for which the rate set ap=
plies,
> > +                      followed by 12 power limit values. The order of =
the
> > +                      channel resource unit settings is RU26, RU52, RU=
106,
> > +                      RU242/SU20, RU484/SU40, RU996/SU80 and RU2x996/S=
U160.
>=20
> These short property names bother me because we don't want 2 property=20
> names with different meanings. A 2-3 letter name seems more likely to=20
> collide. Also, the names aren't really self describing either.
>=20
> > +
> > +                  txs-delta:
> > +                    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +                    description:
> > +                      Half-dBm power delta for different numbers of an=
tennas
> > +
> >  required:
> >    - compatible
> >    - reg
> > @@ -93,6 +149,29 @@ examples:
> >          led {
> >            led-sources =3D <2>;
> >          };
> > +
> > +        power-limits {
> > +          r0 {
> > +            txpower-5g {
> > +               regdomain =3D "FCC";
>=20
> Not the right location for what you've defined.

ack, I will fix it in v2

Regards,
Lorenzo

>=20
> > +               b0 {
> > +                   channels =3D <36 48>;
> > +                   ofdm =3D <23 23 23 23 23 23 23 23>;
> > +                   mcs =3D <1 23 23 23 23 23 23 23 23 23 23>,
> > +                         <3 22 22 22 22 22 22 22 22 22 22>;
> > +                   ru =3D <3 22 22 22 22 22 22 22 22 22 22 22 22>,
> > +                        <4 20 20 20 20 20 20 20 20 20 20 20 20>;
> > +               };
> > +               b1 {
> > +                   channels =3D <100 181>;
> > +                   ofdm =3D <14 14 14 14 14 14 14 14>;
> > +                   mcs =3D <4 14 14 14 14 14 14 14 14 14 14>;
> > +                   txs-delta =3D <12 9 6>;
> > +                   ru =3D <7 14 14 14 14 14 14 14 14 14 14 14 14>;
> > +               };
> > +             };
> > +          };
> > +        };
> >        };
> >      };
> > =20
> > --=20
> > 2.30.2
> >=20

--0jLZZTbisDFIV8aG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYHDaTgAKCRA6cBh0uS2t
rOauAP9u0gG3+ELRXfWXmIKzIC2seqc5JKSPFAMqKQ1traCX2gEAnULEAhwzea1R
M1ytfw74XUJWb5jjMFtx9yuIheuK9ws=
=2vUH
-----END PGP SIGNATURE-----

--0jLZZTbisDFIV8aG--
