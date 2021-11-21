Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C3245869B
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Nov 2021 22:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhKUVqY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 21 Nov 2021 16:46:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:37176 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229586AbhKUVqY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 21 Nov 2021 16:46:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637530998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2iyFN2ouNpAbaW2ecmYacgfRXu8R7sEqLFn3id1kdVY=;
        b=iHul/C9cO4cEimjaXW7RxcKAiAUqAD55b89mgbGIVathiNf4ir/BXpNe6h26kHxzYXtUlj
        PSKLQCyZO/lqQZVnz6Ijf92bajCHBQvse6/6++1ZId+d6Ipe3EK+KhQqFI8MewASvMdjNi
        LiOiHc6m5gQ2UKgk6TEWQ24oOKhLtxg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367-nO3JFHZaNo6-EtYhI8a8AA-1; Sun, 21 Nov 2021 16:43:16 -0500
X-MC-Unique: nO3JFHZaNo6-EtYhI8a8AA-1
Received: by mail-ed1-f72.google.com with SMTP id v9-20020a50d849000000b003dcb31eabaaso12983250edj.13
        for <linux-wireless@vger.kernel.org>; Sun, 21 Nov 2021 13:43:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2iyFN2ouNpAbaW2ecmYacgfRXu8R7sEqLFn3id1kdVY=;
        b=CVeY5Q7elcc556gzQ/cYTNeeIEesWVKf9u69a1hBVpud3jj3gqMM28vYkKHDJXAvUl
         5l0NnvMPC0AX+HbOUsChUpWpbRs+h3QCzH7D8p2+sP7y9ZOT8i6YB9zLB2dGZi8SATVf
         pjE/YFW0NBQ7hNxOnItkOR2fc5IA5Zv6S6o4Ql+CeRcCgI1jIebqxdflPS11zjCfZ1ox
         D5Sh5F4oHneH20ypxUaPGmsM9Vz6lQ0McRccIwwi6v/Xnep63/z+rliXwMIVGaiR1rsj
         TiiBaZfw5WNjsYIBIFXnA6T8NbyRgL1wGNkKGepbBOYZSxo3JK7+SkBRjxTnFNjF5Y9f
         QYeg==
X-Gm-Message-State: AOAM530USI+Fa9TTVHMGVsmlxNhoWZ5zptk/0R+SV4HW9LKep7i3caL1
        zM+CapvTYmkGa6qOUc3bZZePqOplEFC+0PagKEtpL9G08zJNXvTkD1Abnw2uLRfuWbxBY8OV1JI
        uMB2mgdl3FzSt3JmiMZKXpDibpo0=
X-Received: by 2002:a17:906:4fc4:: with SMTP id i4mr36073024ejw.81.1637530995247;
        Sun, 21 Nov 2021 13:43:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyvOEcZwGcBECfj6EwNtsd0mg9tg4INpm0xQAAwMqMPZ5xsJDdDduJET5lFAtuNZxbFb/aisA==
X-Received: by 2002:a17:906:4fc4:: with SMTP id i4mr36072988ejw.81.1637530994949;
        Sun, 21 Nov 2021 13:43:14 -0800 (PST)
Received: from localhost (net-93-151-197-210.cust.vodafonedsl.it. [93.151.197.210])
        by smtp.gmail.com with ESMTPSA id ga37sm2446072ejc.65.2021.11.21.13.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Nov 2021 13:43:14 -0800 (PST)
Date:   Sun, 21 Nov 2021 22:43:12 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, posh.sun@mediatek.com, ted.huang@mediatek.com,
        Eric.Liang@mediatek.com, Stella.Chang@mediatek.com,
        steve.lee@mediatek.com, jsiuda@google.com, frankgor@google.com,
        jemele@google.com, shawnku@google.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/2] mt76: mt7921s: fix the device cannot sleep deeply in
 suspend
Message-ID: <YZq9cBbzwtvzEKyN@lore-desk>
References: <YZkDmDIqnePjIF+O@lore-desk--annotate>
 <1637440161-1946-1-git-send-email-sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CoDL8wbKOFWHQBWy"
Content-Disposition: inline
In-Reply-To: <1637440161-1946-1-git-send-email-sean.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--CoDL8wbKOFWHQBWy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> >> > From: Sean Wang <sean.wang@mediatek.com>
> >> >
> >> > According to the MT7921S firmware, the cmd MCU_UNI_CMD_HIF_CTRL have
> >> > to be last MCU command to execute in suspend handler and all data
> >> > traffic have to be stopped before the cmd MCU_UNI_CMD_HIF_CTRL
> >> > starts as well in order that mt7921 can successfully fall into the d=
eep sleep mode.
> >> >
> >> > Where we reuse the flag MT76_STATE_SUSPEND and avoid creating
> >> > another global flag to stop all of the traffic onto the SDIO bus.
> >> >
> >> > Fixes: 48fab5bbef40 ("mt76: mt7921: introduce mt7921s support")
> >> > Reported-by: Leon Yen <leon.yen@mediatek.com>
> >> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> >> > ---
> >> >  .../wireless/mediatek/mt76/mt76_connac_mcu.c  |  2 +-
> >> > .../net/wireless/mediatek/mt76/mt7921/main.c  |  3 --
> >> > .../net/wireless/mediatek/mt76/mt7921/sdio.c  | 34 ++++++++++++-----=
--
> >> >  drivers/net/wireless/mediatek/mt76/sdio.c     |  3 +-
> >> >  .../net/wireless/mediatek/mt76/sdio_txrx.c    |  3 +-
> >> >  5 files changed, 27 insertions(+), 18 deletions(-)
> >> >
> >> > diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> >> > b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> >> > index 26b4b875dcc0..61c4c86e79c8 100644
> >> > --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> >> > +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> >> > @@ -2461,7 +2461,7 @@ void mt76_connac_mcu_set_suspend_iter(void *pr=
iv, u8 *mac,
> >> >				      struct ieee80211_vif *vif)  {
> >> >	struct mt76_phy *phy =3D priv;
> >> > -	bool suspend =3D test_bit(MT76_STATE_SUSPEND, &phy->state);
> >> > +	bool suspend =3D !test_bit(MT76_STATE_RUNNING, &phy->state);
> >> >	struct ieee80211_hw *hw =3D phy->hw;
> >> >	struct cfg80211_wowlan *wowlan =3D hw->wiphy->wowlan_config;
> >> >	int i;
> >> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> >> > b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> >> > index e022251b4006..0b2a6b7f22ea 100644
> >> > --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> >> > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> >> > @@ -1242,8 +1242,6 @@ static int mt7921_suspend(struct ieee80211_hw =
*hw,
> >> >	mt7921_mutex_acquire(dev);
> >> >
> >> >	clear_bit(MT76_STATE_RUNNING, &phy->mt76->state);
> >> > -
> >> > -	set_bit(MT76_STATE_SUSPEND, &phy->mt76->state);
> >> >	ieee80211_iterate_active_interfaces(hw,
> >> >					    IEEE80211_IFACE_ITER_RESUME_ALL,
> >> >					    mt76_connac_mcu_set_suspend_iter, @@ -1262,7 +1260,6 @@
> >> > static int mt7921_resume(struct ieee80211_hw *hw)
> >> >	mt7921_mutex_acquire(dev);
> >> >
> >> >	set_bit(MT76_STATE_RUNNING, &phy->mt76->state);
> >> > -	clear_bit(MT76_STATE_SUSPEND, &phy->mt76->state);
> >> >	ieee80211_iterate_active_interfaces(hw,
> >> >					    IEEE80211_IFACE_ITER_RESUME_ALL,
> >> >					    mt76_connac_mcu_set_suspend_iter, diff --git
> >> > a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
> >> > b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
> >> > index 5fee489c7a99..5c88b6b8d097 100644
> >> > --- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
> >> > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
> >> > @@ -206,6 +206,8 @@ static int mt7921s_suspend(struct device *__dev)
> >> >	int err;
> >> >
> >> >	pm->suspended =3D true;
> >> > +	set_bit(MT76_STATE_SUSPEND, &mdev->phy.state);
> >> > +
> >> >	cancel_delayed_work_sync(&pm->ps_work);
> >> >	cancel_work_sync(&pm->wake_work);
> >> >
> >> > @@ -213,10 +215,6 @@ static int mt7921s_suspend(struct device *__dev)
> >> >	if (err < 0)
> >> >		goto restore_suspend;
> >> >
> >> > -	err =3D mt76_connac_mcu_set_hif_suspend(mdev, true);
> >> > -	if (err)
> >> > -		goto restore_suspend;
> >> > -
> >> >	/* always enable deep sleep during suspend to reduce
> >> >	 * power consumption
> >> >	 */
> >> > @@ -224,34 +222,45 @@ static int mt7921s_suspend(struct device
> >> > *__dev)
> >> >
> >> >	mt76_txq_schedule_all(&dev->mphy);
> >> >	mt76_worker_disable(&mdev->tx_worker);
> >> > -	mt76_worker_disable(&mdev->sdio.txrx_worker);
> >> >	mt76_worker_disable(&mdev->sdio.status_worker);
> >> > -	mt76_worker_disable(&mdev->sdio.net_worker);
> >> >	cancel_work_sync(&mdev->sdio.stat_work);
> >> >	clear_bit(MT76_READING_STATS, &dev->mphy.state);
> >> > -
> >> >	mt76_tx_status_check(mdev, true);
> >> >
> >> > -	err =3D mt7921_mcu_fw_pmctrl(dev);
> >> > +	mt76_worker_schedule(&mdev->sdio.txrx_worker);
> >>
> >> I guess mt76_worker_disable() is supposed to do it, right?
> >> I guess we can assume txrx_worker is no longer running here, right?
> >
> >I can see it now, txrx_worker can be running on the different cpu.
> >I guess we need to add just the wait_event_timeout() and move
> >mt76_connac_mcu_set_hif_suspend() below. What do you think?
> >Can you please try the chunk below?
>=20
> mt76_connac_mcu_set_hif_suspend have to rely on txrx_worker and net_worke=
r to
> send the command MCU_UNI_CMD_HIF_CTRL and receive the corresponding event,
> so that is why we cannnot disable txrx_worker and net_worker with mt76_wo=
rker_disable
> until the mt76_connac_mcu_set_hif_suspend is done.

ack, right. I forgot about this double dependency :)

>=20
> >
> >Regards,
> >Lorenzo
> >
> >>
> >> > +	wait_event_timeout(dev->mt76.sdio.wait,
> >> > +			   mt76s_txqs_empty(&dev->mt76), 5 * HZ);
> >> > +
> >> > +	/* It is supposed that SDIO bus is idle at the point */
> >> > +	err =3D mt76_connac_mcu_set_hif_suspend(mdev, true);
> >> >	if (err)
> >> >		goto restore_worker;
> >> >
> >> > +	mt76_worker_disable(&mdev->sdio.txrx_worker);
> >> > +	mt76_worker_disable(&mdev->sdio.net_worker);
> >> > +
> >> > +	err =3D mt7921_mcu_fw_pmctrl(dev);
> >> > +	if (err)
> >> > +		goto restore_txrx_worker;
> >> > +
> >> >	sdio_set_host_pm_flags(func, MMC_PM_KEEP_POWER);
> >> >
> >> >	return 0;
> >> >
> >> > +restore_txrx_worker:
> >> > +	mt76_worker_enable(&mdev->sdio.net_worker);
> >> > +	mt76_worker_enable(&mdev->sdio.txrx_worker);
> >> > +	mt76_connac_mcu_set_hif_suspend(mdev, false);
> >> > +
> >> >  restore_worker:
> >> >	mt76_worker_enable(&mdev->tx_worker);
> >> > -	mt76_worker_enable(&mdev->sdio.txrx_worker);
> >> >	mt76_worker_enable(&mdev->sdio.status_worker);
> >> > -	mt76_worker_enable(&mdev->sdio.net_worker);
> >> >
> >> >	if (!pm->ds_enable)
> >> >		mt76_connac_mcu_set_deep_sleep(mdev, false);
> >> >
> >> > -	mt76_connac_mcu_set_hif_suspend(mdev, false);
> >> > -
> >> >  restore_suspend:
> >> > +	clear_bit(MT76_STATE_SUSPEND, &mdev->phy.state);
> >> >	pm->suspended =3D false;
> >> >
> >> >	return err;
> >> > @@ -266,6 +275,7 @@ static int mt7921s_resume(struct device *__dev)
> >> >	int err;
> >> >
> >> >	pm->suspended =3D false;
> >> > +	clear_bit(MT76_STATE_SUSPEND, &mdev->phy.state);
> >> >
> >> >	err =3D mt7921_mcu_drv_pmctrl(dev);
> >> >	if (err < 0)
> >> > diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c
> >> > b/drivers/net/wireless/mediatek/mt76/sdio.c
> >> > index c99acc21225e..b0bc7be0fb1f 100644
> >> > --- a/drivers/net/wireless/mediatek/mt76/sdio.c
> >> > +++ b/drivers/net/wireless/mediatek/mt76/sdio.c
> >> > @@ -479,7 +479,8 @@ static void mt76s_status_worker(struct mt76_work=
er *w)
> >> >			resched =3D true;
> >> >
> >> >		if (dev->drv->tx_status_data &&
> >> > -		    !test_and_set_bit(MT76_READING_STATS, &dev->phy.state))
> >> > +		    !test_and_set_bit(MT76_READING_STATS, &dev->phy.state) &&
> >> > +		    !test_bit(MT76_STATE_SUSPEND, &dev->phy.state))
> >> >			queue_work(dev->wq, &dev->sdio.stat_work);
> >> >	} while (nframes > 0);
> >> >
> >> > diff --git a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
> >> > b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
> >> > index 649a56790b89..801590a0a334 100644
> >> > --- a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
> >> > +++ b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
> >> > @@ -317,7 +317,8 @@ void mt76s_txrx_worker(struct mt76_sdio *sdio)
> >> >		if (ret > 0)
> >> >			nframes +=3D ret;
> >> >
> >> > -		if (test_bit(MT76_MCU_RESET, &dev->phy.state)) {
> >> > +		if (test_bit(MT76_MCU_RESET, &dev->phy.state) ||
> >> > +		    test_bit(MT76_STATE_SUSPEND, &dev->phy.state)) {
> >> >			if (!mt76s_txqs_empty(dev))
> >> >				continue;
> >> >			else
> >>
> >> since mt76s_tx_run_queue will not run if MT76_MCU_RESET is set, do we
> >> really need to check it for each iteration or is fine something like:
> >>
> >> diff --git a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
> >> b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
> >> index 649a56790b89..68f30a83fa5d 100644
> >> --- a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
> >> +++ b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
> >> @@ -317,14 +317,12 @@ void mt76s_txrx_worker(struct mt76_sdio *sdio)
> >>		if (ret > 0)
> >>			nframes +=3D ret;
> >>
> >> -		if (test_bit(MT76_MCU_RESET, &dev->phy.state)) {
> >> -			if (!mt76s_txqs_empty(dev))
> >> -				continue;
> >> -			else
> >> -				wake_up(&sdio->wait);
> >> -		}
> >>	} while (nframes > 0);
> >>
> >> +	if (test_bit(MT76_MCU_RESET, &dev->phy.state) &&
> >> +	    mt76s_txqs_empty(dev))
> >> +		wake_up(&sdio->wait);
> >> +
>=20
> If doing so, mt76s_txqs_empty may not always be true because enqueuing pa=
ckets
> to q_tx or MCU command to q_mcu simultanenously from the other contexts in
> different cpu is possible.
>=20
> It seemed to me we should check it for each iteration to guarantee that w=
e can
> wake up the one that is waiting for the all the queues are empty at some =
time.

IIUC what we are interested here is there are no queued frames into the hw
queues during suspend or reset, right?

>=20
> >>	/* enable interrupt */
> >>	sdio_writel(sdio->func, WHLPCR_INT_EN_SET, MCR_WHLPCR, NULL);
> >>	sdio_release_host(sdio->func);
> >>
> >> Regards,
> >> Lorenzo
> >>
> >> > --
> >> > 2.25.1
> >> >
> >
> >
> >
>=20

--CoDL8wbKOFWHQBWy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYZq9cAAKCRA6cBh0uS2t
rAAEAQDdG6RxR4EcCo2lVK6tXSpauo5fIBSe9nsuXbllDAvbKwD9ED9QCR/o9ucN
Z+fkc9GROkKYXrVb5ApsnNFmBOQefQs=
=7q3c
-----END PGP SIGNATURE-----

--CoDL8wbKOFWHQBWy--

