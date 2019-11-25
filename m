Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC2EE108F63
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2019 14:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbfKYN7b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Nov 2019 08:59:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:60094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727722AbfKYN7a (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Nov 2019 08:59:30 -0500
Received: from localhost.localdomain (unknown [77.139.212.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B55F120863;
        Mon, 25 Nov 2019 13:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574690370;
        bh=BFIX1z6IfLkHFqLjwxsd22Vjr2cFxSS2Ywenikz+514=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qp1zeNzxbG7ffZBphZSIG+yxqIY3xAuHHMg5Lm1w9iTCv5tv8AzZuDTg1tq5+c+CA
         r7l18QTFFF+vJBq655nJumMQfmkmijTnlZ8lqJ3UHshz1hQ5d0BPf82UWIkO7+pPzV
         ZcNAm5z7nvxL2c/4cUtFi+dk/+n2oLMZfCK42QBw=
Date:   Mon, 25 Nov 2019 15:59:22 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, kevin.patrick.schmidt@googlemail.com
Subject: Re: [PATCH] mt76: eeprom: add support for big endian eeprom partition
Message-ID: <20191125135922.GC3528@localhost.localdomain>
References: <61e89623446ed8914e5969114c7ae8c623f3e3ba.1574502651.git.lorenzo@kernel.org>
 <87k17o83lk.fsf@tynnyri.adurom.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mvpLiMfbWzRoNl4x"
Content-Disposition: inline
In-Reply-To: <87k17o83lk.fsf@tynnyri.adurom.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>=20
> > mt76x0e users reported some devices (e.g TP-Link Archer VR200v) have
> > been flashed with big endian radio partition. Add the possibility to
> > specify eeprom endianness using big-endian dts property and in case
> > covert eeprom data in little endian
> >
> > Tested-by: Kevin Schmidt <kevin.patrick.schmidt@googlemail.com>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/net/wireless/mediatek/mt76/eeprom.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/=
wireless/mediatek/mt76/eeprom.c
> > index 804224e81103..33d992d5662a 100644
> > --- a/drivers/net/wireless/mediatek/mt76/eeprom.c
> > +++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
> > @@ -64,6 +64,16 @@ mt76_get_of_eeprom(struct mt76_dev *dev, int len)
> >  		goto out_put_node;
> >  	}
> > =20
> > +	if (of_property_read_bool(dev->dev->of_node, "big-endian")) {
> > +		u8 *data =3D (u8 *)dev->eeprom.data;
> > +		int i;
> > +
> > +		/* convert eeprom data in Little Endian */
> > +		for (i =3D 0; i < round_down(len, 2); i +=3D 2)
> > +			put_unaligned_le16(get_unaligned_be16(&data[i]),
> > +					   &data[i]);
> > +	}
>=20
> What about the bindings documentation? I don't see this "big-endian"
> documented in the mt76 doc, at least.

Right, I will fold a patch for it in v2.

Regards,
Lorenzo
>=20
> --=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches

--mvpLiMfbWzRoNl4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXdveNwAKCRA6cBh0uS2t
rCzMAP9AiMS4WikfSc54zCU6M7l8kaRMqUzU0F4DlrXESS2HRAEA0vHvQ/3fflbd
Jv/xUr0dxAIiyhc462621a/Xn8xnPgs=
=hu7n
-----END PGP SIGNATURE-----

--mvpLiMfbWzRoNl4x--
