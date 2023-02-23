Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661756A041B
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Feb 2023 09:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbjBWIqd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Feb 2023 03:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbjBWIqb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Feb 2023 03:46:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E92A2BF0C
        for <linux-wireless@vger.kernel.org>; Thu, 23 Feb 2023 00:46:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45035B818DC
        for <linux-wireless@vger.kernel.org>; Thu, 23 Feb 2023 08:46:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F5AEC433D2;
        Thu, 23 Feb 2023 08:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677141988;
        bh=0ZTG0Y3VQJoUcThP0atKRpbLQ3wYj0Q2aY9onmg5ud0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QLEIqc++Wz0GTRlLtvQNqiDpDOtJx6TrY2JZ8zn3Db79OuPdiLhuHllqpvXNsGtwi
         /kTiL2Z3Bkrrot0CBhxvefI4oP8i3cFzhm1a3sbPMeWvRCnKOvLiiy+h7n9IsVoz80
         iWsbTYTe9s2T9NclyDl7z/tcsteaUtwgYbmzvX72x167jGDsm8O/Eyqudl+D7Dshtn
         O4eCdE1TnZG1fEexoHEAEUSJDvgJOk8EqMLoxIiF1G+z7k3S/sdIhjY2uRb7zevXq0
         /d8ceXAEV38nw1kJ/Btaygq+a+FplpQU8Jm/mDJpzIG4nnJw6U8OTGoat6yF1VUrLS
         RV4zkdeSHDA4w==
Date:   Thu, 23 Feb 2023 09:46:24 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     nbd@nbd.name, helmut@subdivi.de, lorenzo.bianconi@redhat.com
Subject: Re: [PATCH wireless] wifi: mt76: do not run mt76_unregister_device()
 on unregistered hw
Message-ID: <Y/cn4KVsGVuR27Zg@lore-desk>
References: <be3457d82f4e44bb71a22b2b5db27b644a37b1e1.1677107277.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u95fhuriksMPtGrm"
Content-Disposition: inline
In-Reply-To: <be3457d82f4e44bb71a22b2b5db27b644a37b1e1.1677107277.git.lorenzo@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--u95fhuriksMPtGrm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Trying to probe a mt7921e pci card without firmware results in a
> successful probe where ieee80211_register_hw hasn't been called. When
> removing the driver, ieee802111_unregister_hw is called unconditionally
> leading to a kernel NULL pointer dereference.
> Fix the issue running mt76_unregister_device routine just for registered
> hw.

Reviewing the code better, mt7921 is the only driver registering ieee80211_=
hw in
init work. I do not have a strong opinion if it is better this approach or =
the
fix posted by Helmut, I am fine both ways.

@Felix: what do you think?

Regards,
Lorenzo

>=20
> Link: https://bugs.debian.org/1029116
> Link: https://bugs.kali.org/view.php?id=3D8140
> Reported-by: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
> Fixes: 1c71e03afe4b ("mt76: mt7921: move mt7921_init_hw in a dedicated wo=
rk")
> Tested-by: Helmut Grohne <helmut@freexian.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/wireless/mediatek/mt76/mac80211.c | 8 ++++++++
>  drivers/net/wireless/mediatek/mt76/mt76.h     | 1 +
>  2 files changed, 9 insertions(+)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/=
wireless/mediatek/mt76/mac80211.c
> index b117e4467c87..34abf70f44af 100644
> --- a/drivers/net/wireless/mediatek/mt76/mac80211.c
> +++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
> @@ -539,6 +539,7 @@ int mt76_register_phy(struct mt76_phy *phy, bool vht,
>  	if (ret)
>  		return ret;
> =20
> +	set_bit(MT76_STATE_REGISTERED, &phy->state);
>  	phy->dev->phys[phy->band_idx] =3D phy;
> =20
>  	return 0;
> @@ -549,6 +550,9 @@ void mt76_unregister_phy(struct mt76_phy *phy)
>  {
>  	struct mt76_dev *dev =3D phy->dev;
> =20
> +	if (!test_bit(MT76_STATE_REGISTERED, &phy->state))
> +		return;
> +
>  	if (IS_ENABLED(CONFIG_MT76_LEDS))
>  		mt76_led_cleanup(phy);
>  	mt76_tx_status_check(dev, true);
> @@ -719,6 +723,7 @@ int mt76_register_device(struct mt76_dev *dev, bool v=
ht,
>  		return ret;
> =20
>  	WARN_ON(mt76_worker_setup(hw, &dev->tx_worker, NULL, "tx"));
> +	set_bit(MT76_STATE_REGISTERED, &phy->state);
>  	sched_set_fifo_low(dev->tx_worker.task);
> =20
>  	return 0;
> @@ -729,6 +734,9 @@ void mt76_unregister_device(struct mt76_dev *dev)
>  {
>  	struct ieee80211_hw *hw =3D dev->hw;
> =20
> +	if (!test_bit(MT76_STATE_REGISTERED, &dev->phy.state))
> +		return;
> +
>  	if (IS_ENABLED(CONFIG_MT76_LEDS))
>  		mt76_led_cleanup(&dev->phy);
>  	mt76_tx_status_check(dev, true);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wire=
less/mediatek/mt76/mt76.h
> index ccca0162c8f8..183b0fc5a2d4 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> @@ -402,6 +402,7 @@ struct mt76_tx_cb {
> =20
>  enum {
>  	MT76_STATE_INITIALIZED,
> +	MT76_STATE_REGISTERED,
>  	MT76_STATE_RUNNING,
>  	MT76_STATE_MCU_RUNNING,
>  	MT76_SCANNING,
> --=20
> 2.39.2
>=20

--u95fhuriksMPtGrm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY/cn4AAKCRA6cBh0uS2t
rPhhAQCcxNEM+vPydjeyARW454r+p53f96SPSHAzFPTA7I2iNwEAtW3YAQZ4GP0a
1+bSXffRjXzPYRKstbHQBAR0zrtSags=
=AMea
-----END PGP SIGNATURE-----

--u95fhuriksMPtGrm--
