Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB93C20DAE
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2019 19:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfEPRDi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 May 2019 13:03:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36143 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfEPRDi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 May 2019 13:03:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id s17so4250383wru.3
        for <linux-wireless@vger.kernel.org>; Thu, 16 May 2019 10:03:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q8mz36wEZoMW3KFmJ0eiiK+mWxlbrwexQOr/Z7OWr2c=;
        b=ehbvzUdtHrnnihEAVukt2ZRr34An4/JCIyx6uHCfEV4HFmp/bQ/X1EeMuc2kxB2Tp6
         3vtGKX3YyvntBCcfPz3o5Se25ARE7pyXdT+lBV+eB88bvouFXq75VXaIBsRAvd+W/Ts7
         5xhlkmagdJWiUnNm+bOfrthqppaz+AK0xhg4FKHrVhlMBD1v+aDexkyJHETzeYLvlYO3
         68osBp8p1QhvdfgdEc118lx9znUqVoDwgMCI0LwcAknUC8wvd5guqoOwRD7mQPWkmO5B
         YhgERUyF73xnT0MCB0Qy1tr7Hgu2Kfk7iW6ukh5VbHYMvvkfQGubQ+nOWP3n8M6zF3aq
         hK8Q==
X-Gm-Message-State: APjAAAVqO+Km/36/krwegJbf9nY7F2wIfAL7OxeVyIkBMj0be3vCW1Kh
        dgHLblJKl7f/5bkK3okPXRjv5A==
X-Google-Smtp-Source: APXvYqw3eCxOUh3Rc/E6+Xb+uQe3t+D0F0jcHFvKDXiFezK0of5qmKBcJq9QRF54inwpyVKw90X3GQ==
X-Received: by 2002:adf:b446:: with SMTP id v6mr30617185wrd.30.1558026216549;
        Thu, 16 May 2019 10:03:36 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id f16sm4705498wrx.58.2019.05.16.10.03.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 10:03:35 -0700 (PDT)
Date:   Thu, 16 May 2019 19:03:33 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: Re: [PATCH] mt76: mt7615: add preliminary support for mtd eeprom
 parsing
Message-ID: <20190516170332.GA21478@localhost.localdomain>
References: <cover.1557853278.git.lorenzo@kernel.org>
 <80210f745a12498fc6fc0f2616c2afb43658f0f6.1557853278.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <80210f745a12498fc6fc0f2616c2afb43658f0f6.1557853278.git.lorenzo@kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Calibration data are often available on a specific mtd partition on
> embedded devices. Take into account eeprom calibration data if
> available. Calibration free data parsing is currently missing
>=20
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../wireless/mediatek/mt76/mt7615/eeprom.c    | 32 +++++++++++++++----
>  1 file changed, 26 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c b/drivers=
/net/wireless/mediatek/mt76/mt7615/eeprom.c
> index dd5ab46a4f66..0313c604ea61 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c

[...]

>  int mt7615_eeprom_init(struct mt7615_dev *dev)
>  {
>  	int ret;
> @@ -84,7 +98,13 @@ int mt7615_eeprom_init(struct mt7615_dev *dev)
>  	if (ret < 0)
>  		return ret;
> =20
> -	memcpy(dev->mt76.eeprom.data, dev->mt76.otp.data, MT7615_EEPROM_SIZE);
> +	if (dev->mt76.otp.data) {
> +		ret =3D mt7615_check_eeprom(&dev->mt76);
> +		if (ret < 0)
> +			memcpy(dev->mt76.eeprom.data, dev->mt76.otp.data,
> +			       MT7615_EEPROM_SIZE);
> +		/* TODO: take into account cal free data */

reviewing sdk code it seems we do not have cal free data here, I will post =
a v2
removing the comment

Regards,
Lorenzo

> +	}
> =20
>  	dev->mt76.cap.has_2ghz =3D true;
>  	dev->mt76.cap.has_5ghz =3D true;
> --=20
> 2.20.1
>=20

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXN2X4QAKCRA6cBh0uS2t
rNjZAP9/C/+xwUz9egyNUx9DbUpxgNbZm9Crzfzycwkzd3c9dQEA748mEPixqH3X
gT3pFkYOcprV1caxiuSlIM2NYIUiYwk=
=Isd7
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
