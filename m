Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FAF578D52
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Jul 2022 00:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbiGRWIH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Jul 2022 18:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiGRWIG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Jul 2022 18:08:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5625731DE1
        for <linux-wireless@vger.kernel.org>; Mon, 18 Jul 2022 15:08:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFAC260C38
        for <linux-wireless@vger.kernel.org>; Mon, 18 Jul 2022 22:08:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6733DC341C0;
        Mon, 18 Jul 2022 22:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658182084;
        bh=j1NDFj27vPrFOzzjYxK9T5C/OvNtxqUHE+3AMJSwJmA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XJo9pCeq4dqfMyynm7wy9HBYwj6UsMbQ0pNczuEtkLXCw72Mb6D3K5NjAGezFrY4d
         eF5lkuv+fqqWFzrB32Dq9O/JvEGSk5tvZQX37G3l8xNzR5hVRpTFwvIL+WQ5JyrZSh
         Dzo0e0TGBvmJm3Umv3yuHNIY1nGz1WXrhS1IdV0/6qzKrtPvHhLsjtKnj77BquQ7NT
         CB62T3saXXsxFjHl6w1vuODp3rRPkpESeJEcYMYh+5Sc92w3n9ALVl9w9BHghCtyDz
         SXFnjZ2NTG98tvuexq7Mf/4oX/2lR5eY7WBfNsnLth73H+xn0MyCW3BcOG3moYNalB
         qxZ86QcymE9Ew==
Date:   Tue, 19 Jul 2022 00:08:00 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com, Soul.Huang@mediatek.com,
        YN.Chen@mediatek.com, Leon.Yen@mediatek.com,
        Eric-SY.Chang@mediatek.com, Deren.Wu@mediatek.com,
        km.lin@mediatek.com, jenhao.yang@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, posh.sun@mediatek.com, ted.huang@mediatek.com,
        Stella.Chang@mediatek.com, Tom.Chou@mediatek.com,
        steve.lee@mediatek.com, jsiuda@google.com, frankgor@google.com,
        kuabhs@google.com, druth@google.com, abhishekpandit@google.com,
        shawnku@google.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/4] mt76: mt7921e: fix race issue between reset and
 suspend/resume
Message-ID: <YtXZwKyAh/MZ73rf@lore-desk>
References: <a1437e413116364ac9f3b777c7922ca0728ddc0d.1658176701.git.sean.wang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lMne5WnSCz3v6Rdu"
Content-Disposition: inline
In-Reply-To: <a1437e413116364ac9f3b777c7922ca0728ddc0d.1658176701.git.sean.wang@kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--lMne5WnSCz3v6Rdu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> It is unexpected that the reset work is running simultaneously with
> the suspend or resume context and it is possible that reset work is still
> running even after mt7921 is suspended if we don't fix the race issue.
>=20
> Thus, the suspend procedure should be waiting until the reset is completed
> at the beginning and ignore the subsequent the reset requests.
>=20
> In case there is an error that happens during either suspend or resume
> handler, we will schedule a reset task to recover the error before
> returning the error code to ensure we can immediately fix the error there.
>=20
> Fixes: 0c1ce9884607 ("mt76: mt7921: add wifi reset support")
> Co-developed-by: YN Chen <YN.Chen@mediatek.com>
> Signed-off-by: YN Chen <YN.Chen@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7921/mac.c |  5 +++++
>  drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 13 +++++++++----
>  2 files changed, 14 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/mac.c
> index 47f0aa81ab02..6bd9fc9228a2 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> @@ -780,6 +780,7 @@ void mt7921_mac_reset_work(struct work_struct *work)
>  void mt7921_reset(struct mt76_dev *mdev)
>  {
>  	struct mt7921_dev *dev =3D container_of(mdev, struct mt7921_dev, mt76);
> +	struct mt76_connac_pm *pm =3D &dev->pm;
> =20
>  	if (!dev->hw_init_done)
>  		return;
> @@ -787,8 +788,12 @@ void mt7921_reset(struct mt76_dev *mdev)
>  	if (dev->hw_full_reset)
>  		return;
> =20
> +	if (pm->suspended)
> +		return;
> +
>  	queue_work(dev->mt76.wq, &dev->reset_work);
>  }
> +EXPORT_SYMBOL_GPL(mt7921_reset);
> =20
>  void mt7921_mac_update_mib_stats(struct mt7921_phy *phy)
>  {
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/pci.c
> index 9d1ba838e54f..07573ea55389 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> @@ -363,6 +363,7 @@ static int mt7921_pci_suspend(struct device *device)
>  	int i, err;
> =20
>  	pm->suspended =3D true;
> +	cancel_work_sync(&dev->reset_work);

should we just wait for the reset to complete here instead of cancelling? (=
e.g. flush_work)

Regards,
Lorenzo

>  	cancel_delayed_work_sync(&pm->ps_work);
>  	cancel_work_sync(&pm->wake_work);
> =20
> @@ -424,6 +425,9 @@ static int mt7921_pci_suspend(struct device *device)
>  restore_suspend:
>  	pm->suspended =3D false;
> =20
> +	if (err < 0)
> +		mt7921_reset(&dev->mt76);
> +
>  	return err;
>  }
> =20
> @@ -437,7 +441,7 @@ static int mt7921_pci_resume(struct device *device)
> =20
>  	err =3D mt7921_mcu_drv_pmctrl(dev);
>  	if (err < 0)
> -		return err;
> +		goto failed;
> =20
>  	mt7921_wpdma_reinit_cond(dev);
> =20
> @@ -467,11 +471,12 @@ static int mt7921_pci_resume(struct device *device)
>  		mt76_connac_mcu_set_deep_sleep(&dev->mt76, false);
> =20
>  	err =3D mt76_connac_mcu_set_hif_suspend(mdev, false);
> -	if (err)
> -		return err;
> -
> +failed:
>  	pm->suspended =3D false;
> =20
> +	if (err < 0)
> +		mt7921_reset(&dev->mt76);
> +
>  	return err;
>  }
> =20
> --=20
> 2.25.1
>=20

--lMne5WnSCz3v6Rdu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYtXZwAAKCRA6cBh0uS2t
rLqHAPwPGKvUYKWttSzuLfEnfn6GsozYfdiIRPC2TeDbzTTBgwD/V8zxuZFzcRfr
xZII4Sr/it8t0NcuMfuHFpgfwfFqZQY=
=V8iT
-----END PGP SIGNATURE-----

--lMne5WnSCz3v6Rdu--
