Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2CF457EB6
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Nov 2021 15:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237349AbhKTOVH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 20 Nov 2021 09:21:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:54962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237326AbhKTOVH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 20 Nov 2021 09:21:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D7D260551;
        Sat, 20 Nov 2021 14:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637417883;
        bh=9KmAEb/uZZRR/mVTUiqW5ENHCLJFRB0/aBh1encn6fk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bPCoZnnZbkcndPsWfBEVQKOn+ywZ7Knc/vylReEn+t3XRxqIFWDpFtRtg/0dILlMw
         RInW1Gb/6wrcCblUz0zAqsOspfpwxs45jbOwu2caCN0IcY/u91vTYuX45biEOBx4g/
         S2ZZxopNeXnpjazUaRk/IQbe68cbuM2eBbq1VetKXBHE/l9OZHakM5GyFAigjAdrKR
         C1Ip5PutI93Yh2GoyRrSqcXIgtvxiwefOpnrbFTb8zLwaPyXtkHEias5ae2AkqB/55
         aChNI2W6eDuXcS5T+u82mx9oqRt3l12BHoIjEJMUmMsRDF480b8uu9+lpryYG922Vv
         VA4a7N84sTb1A==
Date:   Sat, 20 Nov 2021 15:18:00 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com, Soul.Huang@mediatek.com,
        YN.Chen@mediatek.com, Leon.Yen@mediatek.com,
        Eric-SY.Chang@mediatek.com, Mark-YW.Chen@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, posh.sun@mediatek.com, ted.huang@mediatek.com,
        Eric.Liang@mediatek.com, Stella.Chang@mediatek.com,
        Tom.Chou@mediatek.com, steve.lee@mediatek.com, jsiuda@google.com,
        frankgor@google.com, jemele@google.com, abhishekpandit@google.com,
        shawnku@google.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/2] mt76: mt7921s: fix the device cannot sleep deeply in
 suspend
Message-ID: <YZkDmDIqnePjIF+O@lore-desk>
References: <92851c34c3758b7d50f3eaa24b1a27adccde2b1a.1637363831.git.objelf@gmail.com>
 <a00f3858dd6896f56a5b730c457a8e825c664028.1637363831.git.objelf@gmail.com>
 <YZjxh5thdYgFV735@lore-desk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0SpmjVgj5QLLuOCs"
Content-Disposition: inline
In-Reply-To: <YZjxh5thdYgFV735@lore-desk>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--0SpmjVgj5QLLuOCs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > From: Sean Wang <sean.wang@mediatek.com>
> >=20
> > According to the MT7921S firmware, the cmd MCU_UNI_CMD_HIF_CTRL have to
> > be last MCU command to execute in suspend handler and all data traffic
> > have to be stopped before the cmd MCU_UNI_CMD_HIF_CTRL starts as well
> > in order that mt7921 can successfully fall into the deep sleep mode.
> >=20
> > Where we reuse the flag MT76_STATE_SUSPEND and avoid creating
> > another global flag to stop all of the traffic onto the SDIO bus.
> >=20
> > Fixes: 48fab5bbef40 ("mt76: mt7921: introduce mt7921s support")
> > Reported-by: Leon Yen <leon.yen@mediatek.com>
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > ---
> >  .../wireless/mediatek/mt76/mt76_connac_mcu.c  |  2 +-
> >  .../net/wireless/mediatek/mt76/mt7921/main.c  |  3 --
> >  .../net/wireless/mediatek/mt76/mt7921/sdio.c  | 34 ++++++++++++-------
> >  drivers/net/wireless/mediatek/mt76/sdio.c     |  3 +-
> >  .../net/wireless/mediatek/mt76/sdio_txrx.c    |  3 +-
> >  5 files changed, 27 insertions(+), 18 deletions(-)
> >=20
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/dri=
vers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> > index 26b4b875dcc0..61c4c86e79c8 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> > @@ -2461,7 +2461,7 @@ void mt76_connac_mcu_set_suspend_iter(void *priv,=
 u8 *mac,
> >  				      struct ieee80211_vif *vif)
> >  {
> >  	struct mt76_phy *phy =3D priv;
> > -	bool suspend =3D test_bit(MT76_STATE_SUSPEND, &phy->state);
> > +	bool suspend =3D !test_bit(MT76_STATE_RUNNING, &phy->state);
> >  	struct ieee80211_hw *hw =3D phy->hw;
> >  	struct cfg80211_wowlan *wowlan =3D hw->wiphy->wowlan_config;
> >  	int i;
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers=
/net/wireless/mediatek/mt76/mt7921/main.c
> > index e022251b4006..0b2a6b7f22ea 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> > @@ -1242,8 +1242,6 @@ static int mt7921_suspend(struct ieee80211_hw *hw,
> >  	mt7921_mutex_acquire(dev);
> > =20
> >  	clear_bit(MT76_STATE_RUNNING, &phy->mt76->state);
> > -
> > -	set_bit(MT76_STATE_SUSPEND, &phy->mt76->state);
> >  	ieee80211_iterate_active_interfaces(hw,
> >  					    IEEE80211_IFACE_ITER_RESUME_ALL,
> >  					    mt76_connac_mcu_set_suspend_iter,
> > @@ -1262,7 +1260,6 @@ static int mt7921_resume(struct ieee80211_hw *hw)
> >  	mt7921_mutex_acquire(dev);
> > =20
> >  	set_bit(MT76_STATE_RUNNING, &phy->mt76->state);
> > -	clear_bit(MT76_STATE_SUSPEND, &phy->mt76->state);
> >  	ieee80211_iterate_active_interfaces(hw,
> >  					    IEEE80211_IFACE_ITER_RESUME_ALL,
> >  					    mt76_connac_mcu_set_suspend_iter,
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers=
/net/wireless/mediatek/mt76/mt7921/sdio.c
> > index 5fee489c7a99..5c88b6b8d097 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
> > @@ -206,6 +206,8 @@ static int mt7921s_suspend(struct device *__dev)
> >  	int err;
> > =20
> >  	pm->suspended =3D true;
> > +	set_bit(MT76_STATE_SUSPEND, &mdev->phy.state);
> > +
> >  	cancel_delayed_work_sync(&pm->ps_work);
> >  	cancel_work_sync(&pm->wake_work);
> > =20
> > @@ -213,10 +215,6 @@ static int mt7921s_suspend(struct device *__dev)
> >  	if (err < 0)
> >  		goto restore_suspend;
> > =20
> > -	err =3D mt76_connac_mcu_set_hif_suspend(mdev, true);
> > -	if (err)
> > -		goto restore_suspend;
> > -
> >  	/* always enable deep sleep during suspend to reduce
> >  	 * power consumption
> >  	 */
> > @@ -224,34 +222,45 @@ static int mt7921s_suspend(struct device *__dev)
> > =20
> >  	mt76_txq_schedule_all(&dev->mphy);
> >  	mt76_worker_disable(&mdev->tx_worker);
> > -	mt76_worker_disable(&mdev->sdio.txrx_worker);
> >  	mt76_worker_disable(&mdev->sdio.status_worker);
> > -	mt76_worker_disable(&mdev->sdio.net_worker);
> >  	cancel_work_sync(&mdev->sdio.stat_work);
> >  	clear_bit(MT76_READING_STATS, &dev->mphy.state);
> > -
> >  	mt76_tx_status_check(mdev, true);
> > =20
> > -	err =3D mt7921_mcu_fw_pmctrl(dev);
> > +	mt76_worker_schedule(&mdev->sdio.txrx_worker);
>=20
> I guess mt76_worker_disable() is supposed to do it, right?
> I guess we can assume txrx_worker is no longer running here, right?

I can see it now, txrx_worker can be running on the different cpu.
I guess we need to add just the wait_event_timeout() and move
mt76_connac_mcu_set_hif_suspend() below. What do you think?
Can you please try the chunk below?

Regards,
Lorenzo

>=20
> > +	wait_event_timeout(dev->mt76.sdio.wait,
> > +			   mt76s_txqs_empty(&dev->mt76), 5 * HZ);
> > +
> > +	/* It is supposed that SDIO bus is idle at the point */
> > +	err =3D mt76_connac_mcu_set_hif_suspend(mdev, true);
> >  	if (err)
> >  		goto restore_worker;
> > =20
> > +	mt76_worker_disable(&mdev->sdio.txrx_worker);
> > +	mt76_worker_disable(&mdev->sdio.net_worker);
> > +
> > +	err =3D mt7921_mcu_fw_pmctrl(dev);
> > +	if (err)
> > +		goto restore_txrx_worker;
> > +
> >  	sdio_set_host_pm_flags(func, MMC_PM_KEEP_POWER);
> > =20
> >  	return 0;
> > =20
> > +restore_txrx_worker:
> > +	mt76_worker_enable(&mdev->sdio.net_worker);
> > +	mt76_worker_enable(&mdev->sdio.txrx_worker);
> > +	mt76_connac_mcu_set_hif_suspend(mdev, false);
> > +
> >  restore_worker:
> >  	mt76_worker_enable(&mdev->tx_worker);
> > -	mt76_worker_enable(&mdev->sdio.txrx_worker);
> >  	mt76_worker_enable(&mdev->sdio.status_worker);
> > -	mt76_worker_enable(&mdev->sdio.net_worker);
> > =20
> >  	if (!pm->ds_enable)
> >  		mt76_connac_mcu_set_deep_sleep(mdev, false);
> > =20
> > -	mt76_connac_mcu_set_hif_suspend(mdev, false);
> > -
> >  restore_suspend:
> > +	clear_bit(MT76_STATE_SUSPEND, &mdev->phy.state);
> >  	pm->suspended =3D false;
> > =20
> >  	return err;
> > @@ -266,6 +275,7 @@ static int mt7921s_resume(struct device *__dev)
> >  	int err;
> > =20
> >  	pm->suspended =3D false;
> > +	clear_bit(MT76_STATE_SUSPEND, &mdev->phy.state);
> > =20
> >  	err =3D mt7921_mcu_drv_pmctrl(dev);
> >  	if (err < 0)
> > diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wi=
reless/mediatek/mt76/sdio.c
> > index c99acc21225e..b0bc7be0fb1f 100644
> > --- a/drivers/net/wireless/mediatek/mt76/sdio.c
> > +++ b/drivers/net/wireless/mediatek/mt76/sdio.c
> > @@ -479,7 +479,8 @@ static void mt76s_status_worker(struct mt76_worker =
*w)
> >  			resched =3D true;
> > =20
> >  		if (dev->drv->tx_status_data &&
> > -		    !test_and_set_bit(MT76_READING_STATS, &dev->phy.state))
> > +		    !test_and_set_bit(MT76_READING_STATS, &dev->phy.state) &&
> > +		    !test_bit(MT76_STATE_SUSPEND, &dev->phy.state))
> >  			queue_work(dev->wq, &dev->sdio.stat_work);
> >  	} while (nframes > 0);
> > =20
> > diff --git a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c b/drivers/n=
et/wireless/mediatek/mt76/sdio_txrx.c
> > index 649a56790b89..801590a0a334 100644
> > --- a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
> > +++ b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
> > @@ -317,7 +317,8 @@ void mt76s_txrx_worker(struct mt76_sdio *sdio)
> >  		if (ret > 0)
> >  			nframes +=3D ret;
> > =20
> > -		if (test_bit(MT76_MCU_RESET, &dev->phy.state)) {
> > +		if (test_bit(MT76_MCU_RESET, &dev->phy.state) ||
> > +		    test_bit(MT76_STATE_SUSPEND, &dev->phy.state)) {
> >  			if (!mt76s_txqs_empty(dev))
> >  				continue;
> >  			else
>=20
> since mt76s_tx_run_queue will not run if MT76_MCU_RESET is set, do we rea=
lly
> need to check it for each iteration or is fine something like:
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c b/drivers/net=
/wireless/mediatek/mt76/sdio_txrx.c
> index 649a56790b89..68f30a83fa5d 100644
> --- a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
> +++ b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
> @@ -317,14 +317,12 @@ void mt76s_txrx_worker(struct mt76_sdio *sdio)
>  		if (ret > 0)
>  			nframes +=3D ret;
> =20
> -		if (test_bit(MT76_MCU_RESET, &dev->phy.state)) {
> -			if (!mt76s_txqs_empty(dev))
> -				continue;
> -			else
> -				wake_up(&sdio->wait);
> -		}
>  	} while (nframes > 0);
> =20
> +	if (test_bit(MT76_MCU_RESET, &dev->phy.state) &&
> +	    mt76s_txqs_empty(dev))
> +		wake_up(&sdio->wait);
> +
>  	/* enable interrupt */
>  	sdio_writel(sdio->func, WHLPCR_INT_EN_SET, MCR_WHLPCR, NULL);
>  	sdio_release_host(sdio->func);
>=20
> Regards,
> Lorenzo
>=20
> > --=20
> > 2.25.1
> >=20



--0SpmjVgj5QLLuOCs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYZkDmAAKCRA6cBh0uS2t
rK64AQDdCYF6KuDlm7BbIR0lnBY8vX/bSICZ2IxikOVtJrbZvAEAuPwMSckFPneg
QT9VSAIm7GtyDDszWRWOLspIUNL+8wM=
=hmjL
-----END PGP SIGNATURE-----

--0SpmjVgj5QLLuOCs--
