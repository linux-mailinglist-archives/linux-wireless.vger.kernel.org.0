Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED7D810E120
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Dec 2019 10:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbfLAJOr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Dec 2019 04:14:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:54594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbfLAJOr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Dec 2019 04:14:47 -0500
Received: from localhost.localdomain (unknown [77.139.212.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D52F120715;
        Sun,  1 Dec 2019 09:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575191687;
        bh=JoyaiuUsM+xLd5WZYj0oK4m58UMyFNE5xffDaWaFS1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VEBpOJTfK/rBZPKpxpZ3ZwJXvMRVelgRIIRtH+TVXx06IBgvM36MklOUnZ37Yo5Cg
         PEvr2tVrWR3FTdJzOj+8/oP1Ei6m5ylm0oMLOUViaev3wb8gV1QdXzWZJ77lbvOgoF
         t9rkde+bNHnZf01TUPSa+0/LAg1rjcRIsqtwgyVI=
Date:   Sun, 1 Dec 2019 11:14:39 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        kevin.patrick.schmidt@googlemail.com, paweldembicki@gmail.com,
        freifunk@adrianschmutzler.de, nbd@nbd.name
Subject: Re: [PATCH] mt76: mt76x0: fix default mac address overwrite
Message-ID: <20191201091439.GA5150@localhost.localdomain>
References: <567a7cda15f641acb6eab5970370c9bfac96793e.1574548832.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <567a7cda15f641acb6eab5970370c9bfac96793e.1574548832.git.lorenzo@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Current implementation always use default eeprom mac address to
> configure device registers even if it is updated using
> mt76_eeprom_override. Fix it initializing macaddr filed of mt76_dev data
> structure with eeprom mac address and running mt76_eeprom_override
> before mt76x02_mac_setaddr
>=20
> Fixes: d1bc9bf2072c ("mt76: mt76x0: eeprom: add support for MAC address f=
rom OF")
> Tested-by: Kevin Schmidt <kevin.patrick.schmidt@googlemail.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Hi Kalle,

since the commit d1bc9bf2072c is already in Linus's tree and multiple users
reported regression due this commit, could you please apply this patch in
wireless-drivers tree?

Regards,
Lorenzo

> ---
>  drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c b/drivers=
/net/wireless/mediatek/mt76/mt76x0/eeprom.c
> index a03e2d01fba7..d1405528b504 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c
> @@ -342,8 +342,11 @@ int mt76x0_eeprom_init(struct mt76x02_dev *dev)
>  	dev_info(dev->mt76.dev, "EEPROM ver:%02hhx fae:%02hhx\n",
>  		 version, fae);
> =20
> -	mt76x02_mac_setaddr(dev, dev->mt76.eeprom.data + MT_EE_MAC_ADDR);
> +	memcpy(dev->mt76.macaddr, (u8 *)dev->mt76.eeprom.data + MT_EE_MAC_ADDR,
> +	       ETH_ALEN);
>  	mt76_eeprom_override(&dev->mt76);
> +	mt76x02_mac_setaddr(dev, dev->mt76.macaddr);
> +
>  	mt76x0_set_chip_cap(dev);
>  	mt76x0_set_freq_offset(dev);
>  	mt76x0_set_temp_offset(dev);
> --=20
> 2.21.0
>=20

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXeOEfAAKCRA6cBh0uS2t
rNDlAP9xaiCs/G9RuxAkyZJmgMPie3H/UIuNCVLfS/HR6OSQ5AD+OHq3p3EkKdJg
SrqEPEpZbt7JGfejN38yPEDkfQhy+gw=
=p39k
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
