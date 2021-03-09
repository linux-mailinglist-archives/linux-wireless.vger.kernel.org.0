Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5E7332557
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Mar 2021 13:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhCIMVA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Mar 2021 07:21:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:34180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229546AbhCIMUv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Mar 2021 07:20:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3AD4765268;
        Tue,  9 Mar 2021 12:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615292450;
        bh=6CKbaU16lYxYAdKwx8raAJYFk3RT75IbkduD7MuH2eQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RM+xs/wst3b8yCTd/b1sm27bTDW1+dxlsLb1xHhXKA8UeNgu4drBu1bwswo4D0RGl
         4pi795xEmAyx2bg0xb8jsC5GmRu+lmm/XVzw+tyJakKFbX9Qeq82KB79dtse+N9G9l
         Jq0zqUd6ijGuFUGyEuaBNB1CAFTlVTCltPnTzCsSxBXbOfsF00/m4QghB22FiN+RCT
         3ICld4gxVZJ/lHOSMCidnEUKjXeYVzILthq3Z/6osi19cxtsrELoCZAYeBPIfp8ACP
         qHqpvMypwzJ4Cz7xOADDcu8uZe4C/eviJG2R+bBnwdDHhdMQ3eKIdAuO6UmnsFt87V
         cntpRduhkALzA==
Date:   Tue, 9 Mar 2021 13:20:45 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings:net:wireless:mediatek,mt76: txt to yaml
 conversion
Message-ID: <YEdoHTn7DktII2XN@lore-desk>
References: <b78122c8ddcbf4ac66adc2c0280665a84e7e9010.1615151665.git.lorenzo@kernel.org>
 <20210308230810.GA3111033@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fH0x3Q43UYus4Dt/"
Content-Disposition: inline
In-Reply-To: <20210308230810.GA3111033@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--fH0x3Q43UYus4Dt/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sun, Mar 07, 2021 at 10:20:44PM +0100, Lorenzo Bianconi wrote:
> > Convert mt76 dts bindings from .txt to .yaml

[...]

Hi Rob,

thx for the review.

> > +  reg:
> > +    maxItems: 1
> > +    description:
> > +      Address and length of the register set for the device
>=20
> That's every reg, drop.

ack, I will fix it in v2

>=20
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +    description:
> > +      Main device interrupt
>=20
> Are there others besides 'main'? If not, drop description.

right. I will fix it in v2

>=20
> > +
> > +  power-domains:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
>=20
> Don't need a type for common properties.

ack,  I will fix it in v2

>=20
> > +    description:
> > +      Phandle to the power domain that the WMAC is part of.
>=20
> That's every 'power-domains'. Just need to define how many: 'maxItems: 1'

ack,  I will fix it in v2

>=20
> > +      This property is MT7622 specific
>=20
> This can be a schema.

Can you please specify what you mean here?

>=20
> > +
> > +  mediatek,infracfg:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      Phandle to the infrastructure bus fabric syscon node.
> > +      This property is MT7622 specific
> > +
> > +  ieee80211-freq-limit:
> > +    maxItems: 1
>=20
> Just make sure, only 1 freq supported?

here we can convert ieee80211.txt in ieee80211.yaml and just refer to it,
right?

>=20
> > +    description:
> > +      List of supported frequency ranges in KHz
> > +
> > +  mediatek,mtd-eeprom:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    description:
> > +      Phandle to a MTD partition + offset containing EEPROM data
> > +
> > +  big-endian:
> > +    type: boolean
> > +    description:
> > +      Specify if the radio eeprom partition is written in big-endian
> > +
> > +  mediatek,eeprom-merge-otp:
> > +    type: boolean
> > +    description:
> > +      Merge EEPROM data with OTP data. Can be used on boards where the=
 flash
> > +      calibration data is generic and specific calibration data should=
 be
> > +      pulled from the OTP ROM
> > +
> > +  led:
> > +    type: object
> > +    properties:
> > +      led-sources:
> > +        $ref: /schemas/types.yaml#/definitions/uint32-array
>=20
> No constraints for how many array entries?

ack, I will fix in v2.

Regards,
Lorenzo

>=20
> > +        description:
> > +          List of device current outputs the LED is connected to
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    pcie0 {
> > +      #address-cells =3D <3>;
> > +      #size-cells =3D <2>;
> > +      wifi@0,0 {
> > +        compatible =3D "mediatek,mt76";
> > +        reg =3D <0x0000 0 0 0 0>;
> > +        ieee80211-freq-limit =3D <5000000 6000000>;
> > +        mediatek,mtd-eeprom =3D <&factory 0x8000>;
> > +        big-endian;
> > +
> > +        led {
> > +          led-sources =3D <2>;
> > +        };
> > +      };
> > +    };
> > +
> > +  - |
> > +    wmac: wmac@10300000 {
> > +      compatible =3D "mediatek,mt7628-wmac";
> > +      reg =3D <0x10300000 0x100000>;
> > +
> > +      interrupt-parent =3D <&cpuintc>;
> > +      interrupts =3D <6>;
> > +
> > +      mediatek,mtd-eeprom =3D <&factory 0x0>;
> > +    };
> > +
> > +  - |
> > +    wlmac: wmac@18000000 {
> > +      compatible =3D "mediatek,mt7622-wmac";
> > +      reg =3D <0x10300000 0x100000>;
> > +      interrupts =3D <0 211 8>;
> > +
> > +      mediatek,infracfg =3D <&infracfg>;
> > +
> > +      power-domains =3D <&scpsys 3>;
> > +    };
> > --=20
> > 2.29.2
> >=20

--fH0x3Q43UYus4Dt/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYEdoGwAKCRA6cBh0uS2t
rApBAP4gyKFIt6ugl7qbZFasfnRVzxi7t0hzIaJZj0U7rVNFfAD/T3KpHRH+QLXH
3H8obr2Uwy83FLJPS0qVCCYx8+rk3wU=
=9Lav
-----END PGP SIGNATURE-----

--fH0x3Q43UYus4Dt/--
