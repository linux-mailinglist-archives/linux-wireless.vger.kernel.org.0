Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA772D4945
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 19:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733310AbgLISmv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 13:42:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57317 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733155AbgLISmn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 13:42:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607539277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MUuXGmzlvNA0nqHFSPBjY5QQLvxqOwA8Xwb7SFNgqDc=;
        b=J79RtTD34FE3QYVn9SbZybWajUpRAyNQJUm8sZirbA3rhACtw7HFAoYVC0SgDHAwat0q7r
        aqk/Ge0cAv2enuDfgV89jGE2zzk/epW9vtHzW2CwWbCiy58C1qvsnTrMg94ChToScvJH02
        MWp4nAYnybnWM7vjpOMP7YyTvTBlbyE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-5NEchfhQO5yg7QGYOBKb9A-1; Wed, 09 Dec 2020 13:41:15 -0500
X-MC-Unique: 5NEchfhQO5yg7QGYOBKb9A-1
Received: by mail-wm1-f70.google.com with SMTP id f12so906231wmf.6
        for <linux-wireless@vger.kernel.org>; Wed, 09 Dec 2020 10:41:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MUuXGmzlvNA0nqHFSPBjY5QQLvxqOwA8Xwb7SFNgqDc=;
        b=Jjvg/XbP647+XOvQYozRFkeUa9MjLyVWUdkBflT1rHLONAq8oRznWiz3iFj+PiljxA
         jkmA2vRC8IMtRSK9oD7S5UDM05XNECaRoTMr7+UIcHc4CyJUqcjY/iuw3y4MaJYKISJ5
         sImpge77NzkxsVEvlcP3ebrbVfFmXIWRPM6p7eqsawqhV0lMN4B2PdKB8xDeqRycM8o1
         rk04h1QsB574Xc4c9eXTcmUeN4labWWYD9ZUGZ6qntBpcgu+0d278kOuFa2xK9KnAkwi
         eqcKbYfVr/4+pNzVnaEQXA483o35+mz/TiZNIAoDo0s8T032VtH0lyGbir8c64WS5Egh
         ZthQ==
X-Gm-Message-State: AOAM5314gdEOIJ7iKPyLaVI2z7V12xgofNaYyuInYpchbKAz9BVFujgc
        8CkUuLjmR/Oqyxp8Fs/SamnyO1OfvHAN4LxAUvTTBjPcvW18txxkx+nWTB/6pr0yMluVP55odQS
        eqeB+nOLf8/71v2b01NlyfioxJk8=
X-Received: by 2002:a1c:2ecc:: with SMTP id u195mr4225676wmu.27.1607539273945;
        Wed, 09 Dec 2020 10:41:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzw0a0hAtstycfl5aKOmDMEIiB4WHqnPE9xMfyLcrctS8QgJaY29lJVZwVTDb248TEDDWzIUg==
X-Received: by 2002:a1c:2ecc:: with SMTP id u195mr4225657wmu.27.1607539273725;
        Wed, 09 Dec 2020 10:41:13 -0800 (PST)
Received: from localhost ([151.66.8.153])
        by smtp.gmail.com with ESMTPSA id h184sm5557179wmh.23.2020.12.09.10.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 10:41:13 -0800 (PST)
Date:   Wed, 9 Dec 2020 19:41:09 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/2] mt76: mt7915: reset token when mac_reset happens
Message-ID: <20201209184109.GB2735@lore-desk>
References: <96fb46ff1e2e3a9c0646a3b3dce43c3840b7bae0.1607536573.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Content-Disposition: inline
In-Reply-To: <96fb46ff1e2e3a9c0646a3b3dce43c3840b7bae0.1607536573.git.ryder.lee@mediatek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Reset buffering token in mt7915_mac_reset_work() to avoid possible leakeg=
e,
> which leads to Tx stop after mac reset.
>=20
> Tested-by: Bo Jiao <bo.jiao@mediatek.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  .../net/wireless/mediatek/mt76/mt7915/init.c  | 17 +-------------
>  .../net/wireless/mediatek/mt76/mt7915/mac.c   | 23 +++++++++++++++++++
>  .../wireless/mediatek/mt76/mt7915/mt7915.h    |  1 +
>  3 files changed, 25 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/n=
et/wireless/mediatek/mt76/mt7915/init.c
> index ff29a8090739..255ccd7e3d27 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> @@ -672,27 +672,12 @@ int mt7915_register_device(struct mt7915_dev *dev)
> =20
>  void mt7915_unregister_device(struct mt7915_dev *dev)
>  {
> -	struct mt76_txwi_cache *txwi;
> -	int id;
> -
>  	mt7915_unregister_ext_phy(dev);
>  	mt76_unregister_device(&dev->mt76);
>  	mt7915_mcu_exit(dev);
>  	mt7915_dma_cleanup(dev);
> =20
> -	spin_lock_bh(&dev->token_lock);
> -	idr_for_each_entry(&dev->token, txwi, id) {
> -		mt7915_txp_skb_unmap(&dev->mt76, txwi);
> -		if (txwi->skb) {
> -			struct ieee80211_hw *hw;
> -
> -			hw =3D mt76_tx_status_get_hw(&dev->mt76, txwi->skb);
> -			ieee80211_free_txskb(hw, txwi->skb);
> -		}
> -		mt76_put_txwi(&dev->mt76, txwi);

it seems to me you are not using latest codebase here. I guess you are miss=
ing
the commit below:

commit 5342758d5522dbf8081360be9c8545bac84b80f3
Author: Felix Fietkau <nbd@nbd.name>
Date:   Sat Nov 21 16:00:14 2020 +0100

mt76: mt7915: stop queues when running out of tx tokens

Avoids packet drops under load with lots of stations

Regards,
Lorenzo

> -	}
> -	spin_unlock_bh(&dev->token_lock);
> -	idr_destroy(&dev->token);
> +	mt7915_tx_token_put(dev);
> =20
>  	mt76_free_device(&dev->mt76);
>  }
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7915/mac.c
> index 7f08c88d3282..25623e450bc5 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> @@ -1466,6 +1466,26 @@ mt7915_dma_reset(struct mt7915_phy *phy)
>  		 MT_WFDMA1_GLO_CFG_TX_DMA_EN | MT_WFDMA1_GLO_CFG_RX_DMA_EN);
>  }
> =20
> +void mt7915_tx_token_put(struct mt7915_dev *dev);
> +{
> +	struct mt76_txwi_cache *txwi;
> +	int id;
> +
> +	spin_lock_bh(&dev->token_lock);
> +	idr_for_each_entry(&dev->token, txwi, id) {
> +		mt7915_txp_skb_unmap(&dev->mt76, txwi);
> +		if (txwi->skb) {
> +			struct ieee80211_hw *hw;
> +
> +			hw =3D mt76_tx_status_get_hw(&dev->mt76, txwi->skb);
> +			ieee80211_free_txskb(hw, txwi->skb);
> +		}
> +		mt76_put_txwi(&dev->mt76, txwi);
> +	}
> +	spin_unlock_bh(&dev->token_lock);
> +	idr_destroy(&dev->token);
> +}
> +
>  /* system error recovery */
>  void mt7915_mac_reset_work(struct work_struct *work)
>  {
> @@ -1506,6 +1526,9 @@ void mt7915_mac_reset_work(struct work_struct *work)
> =20
>  	mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_DMA_STOPPED);
> =20
> +	mt7915_tx_token_put(dev);
> +	idr_init(&dev->token);
> +
>  	if (mt7915_wait_reset_state(dev, MT_MCU_CMD_RESET_DONE)) {
>  		mt7915_dma_reset(&dev->phy);
> =20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers=
/net/wireless/mediatek/mt76/mt7915/mt7915.h
> index 5bf76c74373f..3cee1cffc95e 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
> @@ -468,6 +468,7 @@ int mt7915_tx_prepare_skb(struct mt76_dev *mdev, void=
 *txwi_ptr,
>  			  struct ieee80211_sta *sta,
>  			  struct mt76_tx_info *tx_info);
>  void mt7915_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_ent=
ry *e);
> +void mt7915_tx_token_put(struct mt7915_dev *dev);
>  int mt7915_init_tx_queues(struct mt7915_phy *phy, int idx, int n_desc);
>  void mt7915_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
>  			 struct sk_buff *skb);
> --=20
> 2.18.0
>=20

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCX9EaQwAKCRA6cBh0uS2t
rNLGAP4+MjR1yUwoTUosuMZYLerMkvGPeeszKH33x5hzyksLcQEAwJwNwd1xwwTR
NCGjAqxku4H19Sgz5oWAIFiMIT4RTwE=
=UP9M
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--

