Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD774D755B
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Mar 2022 13:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbiCMMym (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 13 Mar 2022 08:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbiCMMyl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 13 Mar 2022 08:54:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC18A66C1
        for <linux-wireless@vger.kernel.org>; Sun, 13 Mar 2022 05:53:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F914B80BE7
        for <linux-wireless@vger.kernel.org>; Sun, 13 Mar 2022 12:53:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A294C340E8;
        Sun, 13 Mar 2022 12:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647176010;
        bh=X6ytNw264jfSWWzcamJOEl4VzEIL+2B16l6j86o5qJo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UgBKYk63GzldBtJB3IBUHwJrwAaNq9Z9hrUF98Ii5OF3kb7y1mlf28D9Dp9a7vv0y
         0iN8zXrbXYOcyyC3NpHZnn1oQeTRJ6akzspgY3jLa6vG8W+R5K6eG7G7/tgUv9e3CG
         Bo/T9lDGFaQCuGDMsXjwO0SpXc7cR2TXB4JyZWSj7J5bsfoWtKpnWisTIYiz5VeB9p
         bb9u5I4lPyp7YAgD5N8LNU6+JrQStegFM+PovV7Wzem2kmr02/X0eXiXPDVZY0bhoy
         48I0SWzqId23X7QavZbkmiCt+3ia3lm31A17UfwMORBfckKexVgJ+DBspBkrns8ARQ
         dxU8uzXi0hRNg==
Date:   Sun, 13 Mar 2022 13:53:21 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, deren.wu@mediatek.com
Subject: Re: [PATCH] mt76: mt7921: move mt7921_init_hw in a dedicated work
Message-ID: <Yi3pQYQH/3pADHpd@lore-desk>
References: <0358e31e71481dec87f7ecb3b040db53076ffc4a.1646654230.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nVmJ3Zux0WHVp3e2"
Content-Disposition: inline
In-Reply-To: <0358e31e71481dec87f7ecb3b040db53076ffc4a.1646654230.git.lorenzo@kernel.org>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--nVmJ3Zux0WHVp3e2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Firmware initialization can take a while. Move mt7921_init_hw routine in
> a dedicated work in order to not slow down bootstrap process.
>=20
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Hi Felix,

let's put this patch on hold for the moment and continue the upstream
discussion. Thanks.

Regards,
Lorenzo

> ---
>  .../net/wireless/mediatek/mt76/mt7921/init.c  | 66 +++++++++++++------
>  .../wireless/mediatek/mt76/mt7921/mt7921.h    |  2 +
>  2 files changed, 49 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/init.c
> index fa6af85bba7b..332af886b95a 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> @@ -165,7 +165,7 @@ static int __mt7921_init_hardware(struct mt7921_dev *=
dev)
> =20
>  static int mt7921_init_hardware(struct mt7921_dev *dev)
>  {
> -	int ret, idx, i;
> +	int ret, i;
> =20
>  	set_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
> =20
> @@ -182,6 +182,13 @@ static int mt7921_init_hardware(struct mt7921_dev *d=
ev)
>  		return ret;
>  	}
> =20
> +	return 0;
> +}
> +
> +static int mt7921_init_wcid(struct mt7921_dev *dev)
> +{
> +	int idx;
> +
>  	/* Beacon and mgmt frames should occupy wcid 0 */
>  	idx =3D mt76_wcid_alloc(dev->mt76.wcid_mask, MT7921_WTBL_STA - 1);
>  	if (idx)
> @@ -195,6 +202,42 @@ static int mt7921_init_hardware(struct mt7921_dev *d=
ev)
>  	return 0;
>  }
> =20
> +static void mt7921_init_work(struct work_struct *work)
> +{
> +	struct mt7921_dev *dev =3D container_of(work, struct mt7921_dev,
> +					      init_work);
> +	int ret;
> +
> +	ret =3D mt7921_init_hardware(dev);
> +	if (ret)
> +		return;
> +
> +	mt76_set_stream_caps(&dev->mphy, true);
> +	mt7921_set_stream_he_caps(&dev->phy);
> +
> +	ret =3D mt76_register_device(&dev->mt76, true, mt76_rates,
> +				   ARRAY_SIZE(mt76_rates));
> +	if (ret) {
> +		dev_err(dev->mt76.dev, "register device failed\n");
> +		return;
> +	}
> +
> +	ret =3D mt7921_init_debugfs(dev);
> +	if (ret) {
> +		dev_err(dev->mt76.dev, "debugfs register failed\n");
> +		goto error;
> +	}
> +
> +	ret =3D mt76_connac_mcu_set_deep_sleep(&dev->mt76, dev->pm.ds_enable);
> +	if (ret)
> +		goto error;
> +
> +	dev->hw_init_done =3D true;
> +	return;
> +error:
> +	mt76_unregister_device(&dev->mt76);
> +}
> +
>  int mt7921_register_device(struct mt7921_dev *dev)
>  {
>  	struct ieee80211_hw *hw =3D mt76_hw(dev);
> @@ -222,6 +265,7 @@ int mt7921_register_device(struct mt7921_dev *dev)
>  	spin_lock_init(&dev->sta_poll_lock);
> =20
>  	INIT_WORK(&dev->reset_work, mt7921_mac_reset_work);
> +	INIT_WORK(&dev->init_work, mt7921_init_work);
> =20
>  	dev->pm.idle_timeout =3D MT7921_PM_TIMEOUT;
>  	dev->pm.stats.last_wake_event =3D jiffies;
> @@ -234,7 +278,7 @@ int mt7921_register_device(struct mt7921_dev *dev)
>  	if (mt76_is_sdio(&dev->mt76))
>  		hw->extra_tx_headroom +=3D MT_SDIO_TXD_SIZE + MT_SDIO_HDR_SIZE;
> =20
> -	ret =3D mt7921_init_hardware(dev);
> +	ret =3D mt7921_init_wcid(dev);
>  	if (ret)
>  		return ret;
> =20
> @@ -262,23 +306,7 @@ int mt7921_register_device(struct mt7921_dev *dev)
>  	dev->mphy.hw->wiphy->available_antennas_rx =3D dev->mphy.chainmask;
>  	dev->mphy.hw->wiphy->available_antennas_tx =3D dev->mphy.chainmask;
> =20
> -	mt76_set_stream_caps(&dev->mphy, true);
> -	mt7921_set_stream_he_caps(&dev->phy);
> -
> -	ret =3D mt76_register_device(&dev->mt76, true, mt76_rates,
> -				   ARRAY_SIZE(mt76_rates));
> -	if (ret)
> -		return ret;
> -
> -	ret =3D mt7921_init_debugfs(dev);
> -	if (ret)
> -		return ret;
> -
> -	ret =3D mt76_connac_mcu_set_deep_sleep(&dev->mt76, dev->pm.ds_enable);
> -	if (ret)
> -		return ret;
> -
> -	dev->hw_init_done =3D true;
> +	queue_work(system_wq, &dev->init_work);
> =20
>  	return 0;
>  }
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers=
/net/wireless/mediatek/mt76/mt7921/mt7921.h
> index 394a677140da..b6c8f84acb64 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> @@ -204,6 +204,8 @@ struct mt7921_dev {
>  	struct list_head sta_poll_list;
>  	spinlock_t sta_poll_lock;
> =20
> +	struct work_struct init_work;
> +
>  	u8 fw_debug;
> =20
>  	struct mt76_connac_pm pm;
> --=20
> 2.35.1
>=20

--nVmJ3Zux0WHVp3e2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYi3pQQAKCRA6cBh0uS2t
rOlUAP9/u6RYbR//EwgiOVzelEU96jULYSHL1bgg566qHzS42gD9EAJbb1lias1P
CebbYwzRpKTkLGhpayWeTUiArnjruwc=
=IlXC
-----END PGP SIGNATURE-----

--nVmJ3Zux0WHVp3e2--
