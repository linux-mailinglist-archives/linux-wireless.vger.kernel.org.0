Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA67326CAF
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Feb 2021 11:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhB0KY0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 27 Feb 2021 05:24:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:34010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230124AbhB0KYV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 27 Feb 2021 05:24:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ABDAB60C40;
        Sat, 27 Feb 2021 10:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614421420;
        bh=d35awyMx+zvfndcIRzL/TRwPxUZq9gKbGdfr7GTZCcI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UR9Ehi6uCdnsbVwfGY6AvK1tRzMZUbnFR6YdunRnYqMFRww+JbomdWimjdWY++PWf
         u/+MTU5FY9pAvep1gm+5TeF5Dl6R3VI0UFzp8/wPtk4GitAbMFhWvTTsVbKdxFJuGO
         KOJs3dEsO51CSEsVUqv8OcU3HiP31ObqZCfutzQEvuMnTLP4wxHNPi/gjbFK3WgUtw
         mM+hiD53nebk1dhl822kYAGUgoOesFFRVrJeHVQvF7Jr7283iZ3HgZ+cwC8cFxLeC1
         eAxraAjVJuxAT/1JhcA5xX/JFfA2myAplSd8x88/xPZQCnZ6o9v3J3+iAJMKxAtGEz
         tDUcIRi5i2OeQ==
Date:   Sat, 27 Feb 2021 11:23:35 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/5] mt76: mt7615: stop ext_phy queue when mac reset
 happens
Message-ID: <YDodpxIQzPA8754l@lore-desk>
References: <d6f2573790582538e8ba82f87a4c35329692ee32.1614411256.git.ryder.lee@mediatek.com>
 <3794a3ffadc4a08548a1223e6955671977e78e49.1614411256.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="z3bhdhiqw4YTHhg7"
Content-Disposition: inline
In-Reply-To: <3794a3ffadc4a08548a1223e6955671977e78e49.1614411256.git.ryder.lee@mediatek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--z3bhdhiqw4YTHhg7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Stop Tx burst for ext_phy after mac reset.
>=20
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7615/mac.c
> index df2dc77a323a..0f613063c1ff 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
> @@ -2085,6 +2085,7 @@ void mt7615_mac_reset_work(struct work_struct *work)
>  	del_timer_sync(&dev->phy.roc_timer);
>  	cancel_work_sync(&dev->phy.roc_work);
>  	if (phy2) {
> +		set_bit(MT76_RESET, &phy2->mt76->state);

Hi Ryder,

since we run mt76_txq_schedule_all then and mt76_worker_disable few lines b=
elow, what is the point
of setting the state to RESET?

Regards,
Lorenzo

>  		cancel_delayed_work_sync(&phy2->mt76->mac_work);
>  		del_timer_sync(&phy2->roc_timer);
>  		cancel_work_sync(&phy2->roc_work);
> @@ -2118,6 +2119,8 @@ void mt7615_mac_reset_work(struct work_struct *work)
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

--z3bhdhiqw4YTHhg7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYDodpQAKCRA6cBh0uS2t
rAo6AP9KKosBajGY7uX6nsVb1rdvB8jy/jMYre+3BCnjSVydvAD8CNYS+0rQnZll
0oVEPkDnr0WIeOzN2rSdUrrqI1WZdQY=
=nEED
-----END PGP SIGNATURE-----

--z3bhdhiqw4YTHhg7--
