Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFDDC104CC4
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2019 08:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfKUHpC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Nov 2019 02:45:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:45276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfKUHpC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Nov 2019 02:45:02 -0500
Received: from localhost.localdomain (unknown [77.139.212.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DDD22088F;
        Thu, 21 Nov 2019 07:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574322301;
        bh=UuwEkwbivUAOKONDgTeXGMEkYHxRS6+0R5QX9nwQriw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yoCKBAy/ES4N1ILECpxhZP6S6/WuSFHdKprR3meLeP//GUA674ItDQc/JM45D+3Bm
         /7jdgLt31AosYJb6EAdzILtxeihMm3tmNfiD49II6LbeF0I2ckJxjh/GMm5wSxXkL8
         HkDLG8iwPgZwwr4xYh12CDhe3QHS15oFukm7aoTc=
Date:   Thu, 21 Nov 2019 09:44:52 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, ryder.lee@mediatek.com,
        royluo@google.com
Subject: Re: [PATCH v2 3/3] mt76: mt7615: add set_coverage class support
Message-ID: <20191121074452.GA2299@localhost.localdomain>
References: <cover.1574253996.git.lorenzo@kernel.org>
 <7c9088415ce08fd8b71eda9b53a4a213865886aa.1574253996.git.lorenzo@kernel.org>
 <0101016e8cbff2f0-f543727d-0d42-45d5-a536-64e5545d4946-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: <0101016e8cbff2f0-f543727d-0d42-45d5-a536-64e5545d4946-000000@us-west-2.amazonses.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>=20
> > Add the capability to configure actimeout for mt7615 driver. Moreover
>=20
> acktimeout?

Hi Kalle,

yes, it suppposed to be acktimeout

>=20
> > configure slottime according to the value provided by mac80211
> >
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> [...]
>=20
> > --- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
> > @@ -60,6 +60,47 @@ void mt7615_mac_reset_counters(struct mt7615_dev *de=
v)
> >  	mt76_set(dev, MT_WF_RMAC_MIB_AIRTIME0, MT_WF_RMAC_MIB_RXTIME_CLR);
> >  }
> > =20
> > +/* XXX: DBDC support */
> > +void mt7615_mac_set_timing(struct mt7615_dev *dev)
>=20
> Should this be "FIXME:"? Thought don't remember what style is used in
> mt76.

actually for DBDC we used TODO. Should I resend?

Regards,
Lorenzo

>=20
> --=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXdZAcAAKCRA6cBh0uS2t
rJSEAQDQQlOZfzfhrDKnerpPoDZ2m3IYQk4szfu7TbMrZOYd3QD/WQAjnOUkNwRq
vu/mCDqMmB/0C6pDCcx8tuqEyEegvAE=
=oY2+
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
