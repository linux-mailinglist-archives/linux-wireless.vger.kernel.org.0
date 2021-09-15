Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8DD40C5D8
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Sep 2021 15:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbhIONE3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Sep 2021 09:04:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56882 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229670AbhIONE3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Sep 2021 09:04:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631710990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vsS4gxvVFGdA0MkE8p8zJnAT8/RU139LbW1zE3u6VyQ=;
        b=W0x74eJy6kWFBxnZ9GKgwlsiITnRssoTYu63ktFsLb+qPzxD2xyiVf37dCZVh+KxcZPSmH
        hLo8whvnnJ5WdJ4Q55Gb4h2mkzZNF2J0vA89FrefLVt4Q0f9qlEBAYlm01TkvO7jdi2DBO
        AkV6Jk7Y07bkppCK+FP6+NUvUijcDz0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-0fIsTJs4PB6MdtX3_AIf7A-1; Wed, 15 Sep 2021 09:03:08 -0400
X-MC-Unique: 0fIsTJs4PB6MdtX3_AIf7A-1
Received: by mail-ej1-f72.google.com with SMTP id v19-20020a170906b013b02905b2f1bbf8f3so1496275ejy.6
        for <linux-wireless@vger.kernel.org>; Wed, 15 Sep 2021 06:03:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vsS4gxvVFGdA0MkE8p8zJnAT8/RU139LbW1zE3u6VyQ=;
        b=xQ+llgVzYQr0Ip4QOd04KBUmNzsFu6EX4ctlTZPDQIeOalaaej3JuaweIsfeB128+b
         DKL8AeSs3bokJ2rNxnIpOEnpZOVLnDUxktBT93p3cFx5K4ZfJJ7FMTo7r01ym5QkRdbn
         XzRbuX/jTWmKDb5VHSAKK6+tLjxnf10sOWcN1VmmICLvv/Q0vW9utTN+zRn5AcpR7sdN
         5nBjQIrqsmtJgj/TgPbgj4NeOWPNAbpIlYZFw2H4/HrK7vhkKGkEHUpD+dpmo/37hTmQ
         woQYGRREkxiHFkuiZredXEZwc2c9s3jxKwRLAUi3HmSeudEsCXgtPYiuhiCBtPkbqv09
         DZGg==
X-Gm-Message-State: AOAM533JFOKtRUQz75JXdaCNo1ag2UDhIgWKBugeTus1QFXGs0TfwxXc
        zGpoxhNVfa+pZ26qWSGii6pKjjdF7BC4DPbIebI85KkpUxLQsGLAKqnRGPZgWxkXvBKq5u5Psry
        iPnRqMioonOmSgjFOt9Xi5Nt57Ws=
X-Received: by 2002:a17:906:844d:: with SMTP id e13mr19862540ejy.223.1631710987452;
        Wed, 15 Sep 2021 06:03:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzeZlEPWaqRm4oWWVnZnxSWTn/hIL8kXRCQMija2PHxmYNMvLmQDeu/3SRN6pYBd7zzQ7/5rw==
X-Received: by 2002:a17:906:844d:: with SMTP id e13mr19862511ejy.223.1631710987131;
        Wed, 15 Sep 2021 06:03:07 -0700 (PDT)
Received: from localhost (net-130-25-199-50.cust.vodafonedsl.it. [130.25.199.50])
        by smtp.gmail.com with ESMTPSA id di4sm7090471edb.34.2021.09.15.06.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 06:03:06 -0700 (PDT)
Date:   Wed, 15 Sep 2021 15:03:03 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, posh.sun@mediatek.com, ted.huang@mediatek.com,
        Eric.Liang@mediatek.com, Stella.Chang@mediatek.com,
        steve.lee@mediatek.com, jemele@google.com, shawnku@google.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v1 02/16] mt76: mt7921: refactor dma.c to be pcie specific
Message-ID: <YUHvB0gohA90G9Yj@lore-desk>
References: <cover.1631667941.git.objelf@gmail.com>
 <aa4827ded213e62c4c5521f219f52257ddeb3b1a.1631667941.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Wg5HF+xfc9U35FXT"
Content-Disposition: inline
In-Reply-To: <aa4827ded213e62c4c5521f219f52257ddeb3b1a.1631667941.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--Wg5HF+xfc9U35FXT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> This is a preliminary patch to introduce mt7921s support.
>=20
> make dma.c be used dedicately for mt7921e.
>=20
> by moving out mt7921_tx_cleanup from dma.c to mcu.c and then renaming
> mt7921_tx_cleanup to refect the exact thing the function actually does.
>=20
> Finally, dma.c totally become pcie specific one, only needed to
> be compiled only when CONFIG_MT7921E is enabled.
>=20
> Tested-by: Deren Wu <deren.wu@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7921/dma.c    | 8 +-------
>  drivers/net/wireless/mediatek/mt76/mt7921/mac.c    | 2 +-
>  drivers/net/wireless/mediatek/mt76/mt7921/mcu.c    | 6 ++++++
>  drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h | 2 +-
>  4 files changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/dma.c
> index 802e40e42040..d3e2036a1974 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
> @@ -19,12 +19,6 @@ int mt7921_init_tx_queues(struct mt7921_phy *phy, int =
idx, int n_desc)
>  	return 0;
>  }
> =20
> -void mt7921_tx_cleanup(struct mt7921_dev *dev)
> -{
> -	mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[MT_MCUQ_WM], false);
> -	mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[MT_MCUQ_WA], false);
> -}
> -
>  static int mt7921_poll_tx(struct napi_struct *napi, int budget)
>  {
>  	struct mt7921_dev *dev;
> @@ -37,7 +31,7 @@ static int mt7921_poll_tx(struct napi_struct *napi, int=
 budget)
>  		return 0;
>  	}
> =20
> -	mt7921_tx_cleanup(dev);
> +	mt7921_mcu_tx_cleanup(dev);
>  	if (napi_complete(napi))
>  		mt7921_irq_enable(dev, MT_INT_TX_DONE_ALL);
>  	mt76_connac_pm_unref(&dev->mphy, &dev->pm);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/mac.c
> index d811702a3a2c..580a88b7841e 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> @@ -1392,7 +1392,7 @@ void mt7921_pm_wake_work(struct work_struct *work)
>  		mt76_for_each_q_rx(&dev->mt76, i)
>  			napi_schedule(&dev->mt76.napi[i]);
>  		mt76_connac_pm_dequeue_skbs(mphy, &dev->pm);
> -		mt7921_tx_cleanup(dev);
> +		mt7921_mcu_tx_cleanup(dev);
>  		if (test_bit(MT76_STATE_RUNNING, &mphy->state))
>  			ieee80211_queue_delayed_work(mphy->hw, &mphy->mac_work,
>  						     MT7921_WATCHDOG_TIME);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/mcu.c
> index ecdc879216b9..6ba431347b3b 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> @@ -1369,3 +1369,9 @@ int mt7921_get_txpwr_info(struct mt7921_dev *dev, s=
truct mt7921_txpwr *txpwr)
> =20
>  	return 0;
>  }
> +
> +void mt7921_mcu_tx_cleanup(struct mt7921_dev *dev)
> +{
> +	mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[MT_MCUQ_WM], false);
> +	mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[MT_MCUQ_WA], false);
> +}

I guess it can be inline in mt7921.h, are you reusing it later?

> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers=
/net/wireless/mediatek/mt76/mt7921/mt7921.h
> index 70c0f41180a1..4c1c7c4eafac 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> @@ -330,7 +330,7 @@ void mt7921_mac_work(struct work_struct *work);
>  void mt7921_mac_reset_work(struct work_struct *work);
>  void mt7921_mac_update_mib_stats(struct mt7921_phy *phy);
>  void mt7921_reset(struct mt76_dev *mdev);
> -void mt7921_tx_cleanup(struct mt7921_dev *dev);
> +void mt7921_mcu_tx_cleanup(struct mt7921_dev *dev);
>  int mt7921e_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
>  			   enum mt76_txq_id qid, struct mt76_wcid *wcid,
>  			   struct ieee80211_sta *sta,
> --=20
> 2.25.1
>=20

--Wg5HF+xfc9U35FXT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYUHvBQAKCRA6cBh0uS2t
rAZdAQDSbK+6Fki/iQTIapHMDc8bXQcSy0XPn+rkKZ0OEUsSIwEAuq1eGv1HEEZQ
w9jpUCkTBs5Q3IVo4i2vy7bn+NN28Qo=
=W87t
-----END PGP SIGNATURE-----

--Wg5HF+xfc9U35FXT--

