Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB75D326CB2
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Feb 2021 11:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhB0K1H (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 27 Feb 2021 05:27:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:34694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229991AbhB0K1D (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 27 Feb 2021 05:27:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 175AE64ED5;
        Sat, 27 Feb 2021 10:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614421582;
        bh=XO6UU8J6psHkJ5PcrSAcSy2M7xNonSzXvs10KkOZ7ns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HckBmWJprwk1f0/ZkIO2GRWAKm7KTneLAYQbgZhKopclXa25iJOV7dLOfhdpEkDge
         uRkXio1EWLYc+2msoVUwXoPORpaYaR0p5YppdxlKkxgQDSAjsrn4PIGtkYyGkgAtDQ
         fIT1288ksmDRQDmu06spbURI80+xqJLnnCMGqy+R3GEaKah7c8+7RC6g431iKkaCH2
         vgwSDIfaA1dbf2F7iXdsBd6/y8ixzlhzNizE9AC97ahiluHVW8YuwPupEb8ak9EAk0
         hYK296YY89ESPAAZFaDBJSiBfuOt48nclDsQarHC6m2pbUVMsOXrOiabwKA7XkNOUi
         5+/3h6bos+FUQ==
Date:   Sat, 27 Feb 2021 11:26:18 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 4/5] mt76: mt7915: stop ext_phy queue when mac reset
 happens
Message-ID: <YDoeSgKugYwjQw4M@lore-desk>
References: <d6f2573790582538e8ba82f87a4c35329692ee32.1614411256.git.ryder.lee@mediatek.com>
 <20a4b03ba4a347a76df67291680704dfdb7da5d6.1614411256.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iNypzeBZfhswFpZY"
Content-Disposition: inline
In-Reply-To: <20a4b03ba4a347a76df67291680704dfdb7da5d6.1614411256.git.ryder.lee@mediatek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--iNypzeBZfhswFpZY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Stop Tx burst for ext_phy after mac reset.
>=20
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7915/mac.c
> index 6b6ea33bd320..c653cd01b8d8 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> @@ -1607,9 +1607,10 @@ void mt7915_mac_reset_work(struct work_struct *wor=
k)
>  	set_bit(MT76_MCU_RESET, &dev->mphy.state);
>  	wake_up(&dev->mt76.mcu.wait);
>  	cancel_delayed_work_sync(&dev->mphy.mac_work);
> -	if (phy2)
> +	if (phy2) {
> +		set_bit(MT76_RESET, &phy2->mt76->state);
>  		cancel_delayed_work_sync(&phy2->mt76->mac_work);

same question here as mt7615, do we really need this?

Regards,
Lorenzo

> -
> +	}
>  	/* lock/unlock all queues to ensure that no tx is pending */
>  	mt76_txq_schedule_all(&dev->mphy);
>  	if (ext_phy)
> @@ -1637,6 +1638,8 @@ void mt7915_mac_reset_work(struct work_struct *work)
> =20
>  	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
>  	clear_bit(MT76_RESET, &dev->mphy.state);
> +	if (phy2)
> +		clear_bit(MT76_RESET, &phy2->mt76->state);
> =20
>  	mt76_worker_enable(&dev->mt76.tx_worker);
>  	napi_enable(&dev->mt76.tx_napi);
> --=20
> 2.18.0
>=20

--iNypzeBZfhswFpZY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYDoeRwAKCRA6cBh0uS2t
rMCfAP4vuBHRkZxjZU6lLdA3uMeNdc8eXWNBP2F84H+Sd5r6LAD+ONh7K0Xda4S1
67JHWJitN17qOBdYkYzkeiUGZpC8Iww=
=9yZY
-----END PGP SIGNATURE-----

--iNypzeBZfhswFpZY--
