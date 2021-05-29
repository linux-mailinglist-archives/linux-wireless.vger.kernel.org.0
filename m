Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF902394C57
	for <lists+linux-wireless@lfdr.de>; Sat, 29 May 2021 15:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbhE2NnE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 29 May 2021 09:43:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229666AbhE2NnE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 29 May 2021 09:43:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2DF861206;
        Sat, 29 May 2021 13:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622295688;
        bh=S2JqlfZshOAIrvs72EijV0/6qGJSOnJbKfh6oKD7vN8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oNiaEuPFDpPRYDzgY3yb7LPhTyNMaHSh9gurf/5HvSbJzG+C+2GOi5mLozQqUPoq8
         jnJnRqa9mm9MIJBYmUT6N2qDxUfQsO4lJl5o96UhXoAbteXrm2GPM3Wm8Vwxri6Scn
         pOfmBC9gNz7VRryQEWma7bqwoUec7Ar28UvcCQ18dzYriqOho2lciEt4F9FOKzvD+r
         gTjn5NeOPkUAW0mEqm/mIo0ztfrm2LGWDhH5/bSQrbLBpiLVqaXG+UOPq8/sy8mgMa
         1j+nYNbeoxgzapFsQL6BeAFQzZS30riAQgxjoO0+Ah2RUbWjsEYc1iv7MMb1jL1u17
         3ND1XHha21z+g==
Date:   Sat, 29 May 2021 15:41:23 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     kvalo@codeaurora.org
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, sean.wang@mediatek.com
Subject: Re: [PATCH v2 5.13] mt76: mt7615: do not set MT76_STATE_PM at
 bootstrap
Message-ID: <YLJEgzafftYq7JBg@lore-desk>
References: <e5a2618574007113d844874420f7855891abf167.1621085028.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BMr6Ci4IaaGDUoB0"
Content-Disposition: inline
In-Reply-To: <e5a2618574007113d844874420f7855891abf167.1621085028.git.lorenzo@kernel.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--BMr6Ci4IaaGDUoB0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Remove MT76_STATE_PM in mt7615_init_device() and introduce
> __mt7663s_mcu_drv_pmctrl for fw loading in mt7663s.
> This patch fixes a crash at bootstrap for device (e.g. mt7622) that do
> not support runtime-pm
>=20
> Fixes: 7f2bc8ba11a0 ("mt76: connac: introduce wake counter for fw_pmctrl =
synchronization")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Hi Kalle,

any news about this patch?

Regards,
Lorenzo

> ---
> Changes since v1:
> - use proper Fixes commit hash
> ---
>  .../net/wireless/mediatek/mt76/mt7615/init.c  |  1 -
>  .../wireless/mediatek/mt76/mt7615/sdio_mcu.c  | 19 ++++++++++++-------
>  .../wireless/mediatek/mt76/mt7615/usb_mcu.c   |  3 ---
>  3 files changed, 12 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/n=
et/wireless/mediatek/mt76/mt7615/init.c
> index 86341d1f82f3..d20f05a7717d 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
> @@ -510,7 +510,6 @@ void mt7615_init_device(struct mt7615_dev *dev)
>  	mutex_init(&dev->pm.mutex);
>  	init_waitqueue_head(&dev->pm.wait);
>  	spin_lock_init(&dev->pm.txq_lock);
> -	set_bit(MT76_STATE_PM, &dev->mphy.state);
>  	INIT_DELAYED_WORK(&dev->mphy.mac_work, mt7615_mac_work);
>  	INIT_DELAYED_WORK(&dev->phy.scan_work, mt7615_scan_work);
>  	INIT_DELAYED_WORK(&dev->coredump.work, mt7615_coredump_work);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c b/drive=
rs/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
> index 17fe4187d1de..d1be78b0711c 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
> @@ -51,16 +51,13 @@ mt7663s_mcu_send_message(struct mt76_dev *mdev, struc=
t sk_buff *skb,
>  	return ret;
>  }
> =20
> -static int mt7663s_mcu_drv_pmctrl(struct mt7615_dev *dev)
> +static int __mt7663s_mcu_drv_pmctrl(struct mt7615_dev *dev)
>  {
>  	struct sdio_func *func =3D dev->mt76.sdio.func;
>  	struct mt76_phy *mphy =3D &dev->mt76.phy;
>  	u32 status;
>  	int ret;
> =20
> -	if (!test_and_clear_bit(MT76_STATE_PM, &mphy->state))
> -		goto out;
> -
>  	sdio_claim_host(func);
> =20
>  	sdio_writel(func, WHLPCR_FW_OWN_REQ_CLR, MCR_WHLPCR, NULL);
> @@ -76,13 +73,21 @@ static int mt7663s_mcu_drv_pmctrl(struct mt7615_dev *=
dev)
>  	}
> =20
>  	sdio_release_host(func);
> -
> -out:
>  	dev->pm.last_activity =3D jiffies;
> =20
>  	return 0;
>  }
> =20
> +static int mt7663s_mcu_drv_pmctrl(struct mt7615_dev *dev)
> +{
> +	struct mt76_phy *mphy =3D &dev->mt76.phy;
> +
> +	if (test_and_clear_bit(MT76_STATE_PM, &mphy->state))
> +		return __mt7663s_mcu_drv_pmctrl(dev);
> +
> +	return 0;
> +}
> +
>  static int mt7663s_mcu_fw_pmctrl(struct mt7615_dev *dev)
>  {
>  	struct sdio_func *func =3D dev->mt76.sdio.func;
> @@ -123,7 +128,7 @@ int mt7663s_mcu_init(struct mt7615_dev *dev)
>  	struct mt7615_mcu_ops *mcu_ops;
>  	int ret;
> =20
> -	ret =3D mt7663s_mcu_drv_pmctrl(dev);
> +	ret =3D __mt7663s_mcu_drv_pmctrl(dev);
>  	if (ret)
>  		return ret;
> =20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c b/driver=
s/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
> index c55698f9c49a..028ff432d811 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
> @@ -55,10 +55,7 @@ int mt7663u_mcu_init(struct mt7615_dev *dev)
> =20
>  	dev->mt76.mcu_ops =3D &mt7663u_mcu_ops,
> =20
> -	/* usb does not support runtime-pm */
> -	clear_bit(MT76_STATE_PM, &dev->mphy.state);
>  	mt76_set(dev, MT_UDMA_TX_QSEL, MT_FW_DL_EN);
> -
>  	if (test_and_clear_bit(MT76_STATE_POWER_OFF, &dev->mphy.state)) {
>  		mt7615_mcu_restart(&dev->mt76);
>  		if (!mt76_poll_msec(dev, MT_CONN_ON_MISC,
> --=20
> 2.31.1
>=20

--BMr6Ci4IaaGDUoB0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYLJEfgAKCRA6cBh0uS2t
rD44AQDujya8Nhf8vCjAYz4nG4ieDsbKNvWeQlp4sAcQyOG3JwEA9c/ZC8ar0Aal
eke1e5khEYzj0W45EzIS1muz5P6dCwo=
=cS6K
-----END PGP SIGNATURE-----

--BMr6Ci4IaaGDUoB0--
