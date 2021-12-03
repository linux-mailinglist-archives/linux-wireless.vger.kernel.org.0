Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98185467489
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Dec 2021 11:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379774AbhLCKKo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Dec 2021 05:10:44 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59268 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351346AbhLCKKn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Dec 2021 05:10:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E801562993
        for <linux-wireless@vger.kernel.org>; Fri,  3 Dec 2021 10:07:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6220C53FAD;
        Fri,  3 Dec 2021 10:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638526039;
        bh=s9P9y2xy7BPfS8YneyVgfkTAw04VSer0zO0PacCdhIQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VMd2UkXPlxGTA8N3aU9cz42D1HJpuPMxCaz6ovd1ZNKjpNP0nh43Z36uX5DjE3V0U
         9zthrw3Jyc4iq6unsyLHmoF+tcE+Ff1bvlkDXRb5RMWkgTCy0z7T2ztkpR4+U2mIlK
         8Cljq3f1Sy3jaRA6v71uUSLo/1uHxHQ5lnZUnpsDiSKYr2XVT9SW0SQJ+4/Iirzwvt
         HVcCCdjBrX++NvgYMSiXrlgAXucMdgXJK86Eklfq/GK8wcttBsA0H0+IkwvNs9Rb0+
         q3ehh9aNqPe61YvB+cHm1qonHML7J1ROqWEcK4NVpav+hCTJbcCRYJqziOgwPGDJe0
         akmIpmeg97Ykw==
Date:   Fri, 3 Dec 2021 11:07:15 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: Re: [PATCH] mt76: mt7663: disable 4addr capability
Message-ID: <YansU5YYPpv7+9d4@lore-desk>
References: <009c6c2bc8436f38de85e125cdd7157f1b21a2cf.1638473687.git.lorenzo@kernel.org>
 <59de5a7b-8933-03c7-7ce5-fe58279c7457@nbd.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WhHWiCI678f7oRSe"
Content-Disposition: inline
In-Reply-To: <59de5a7b-8933-03c7-7ce5-fe58279c7457@nbd.name>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--WhHWiCI678f7oRSe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
> On 2021-12-02 20:35, Lorenzo Bianconi wrote:
> > 4addr is not supported by the driver/firmware yet
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >   drivers/net/wireless/mediatek/mt76/mt7615/init.c | 1 +
> >   1 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers=
/net/wireless/mediatek/mt76/mt7615/init.c
> > index 47f23ac905a3..52182ab6d240 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
> > @@ -378,6 +378,7 @@ mt7615_init_wiphy(struct ieee80211_hw *hw)
> >   	if (is_mt7663(&phy->dev->mt76)) {
> >   		wiphy->iface_combinations =3D if_comb;
> >   		wiphy->n_iface_combinations =3D ARRAY_SIZE(if_comb);
> > +		wiphy->flags &=3D ~WIPHY_FLAG_4ADDR_STATION;
> Shouldn't this be done for the offload firmware only?
>=20
> - Felix
ack, right, I did not think about this combination. I tested with non-offlo=
ad
fw and it works. I will post v2 to fix it.

Regards,
Lorenzo

--WhHWiCI678f7oRSe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYansUwAKCRA6cBh0uS2t
rHhdAQDVzl1I4ofXfv5AZCXvTaNnMf0+mqQn5d1wJ9Q1xtSozwEAt7c978hHIfly
jbjid++IEJSPi9OjHDIx6LgOr+S8HAQ=
=rjsD
-----END PGP SIGNATURE-----

--WhHWiCI678f7oRSe--
