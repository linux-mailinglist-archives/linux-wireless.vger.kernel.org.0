Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9283983BF
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jun 2021 10:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhFBICq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Jun 2021 04:02:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45063 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232298AbhFBICj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Jun 2021 04:02:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622620854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JhTNYg0UXB2ejGVfxIE9halIgMdMaFFp/+elkOmXlM0=;
        b=WO0npnrEElN+k7qkvNrWw2B0TufyL4qMSohr82rfr+lyUQ9Y5Iikdviq72IvCKaFcbgkyy
        4Ar1pGDaJavt+x1s9CdjFNlwNQGhME5uhAYwPnZ3MW/ZmJs3ZiKDQZGy7V4P0xT7PhAMG6
        rPDg55HU6B/7Ptwf2+JY1SKofFrivS0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-5oLi96SwNEqfEQOUtyroXw-1; Wed, 02 Jun 2021 04:00:50 -0400
X-MC-Unique: 5oLi96SwNEqfEQOUtyroXw-1
Received: by mail-ed1-f70.google.com with SMTP id y7-20020aa7ce870000b029038fd7cdcf3bso921849edv.15
        for <linux-wireless@vger.kernel.org>; Wed, 02 Jun 2021 01:00:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JhTNYg0UXB2ejGVfxIE9halIgMdMaFFp/+elkOmXlM0=;
        b=GzjhNHt+02CFP7eDSlyYBlm9BDZch+ktFrEm9Nx/gTiw+Lfq/raG2DnIdZ0rvofCef
         M6i8S+v1KUBAQ2ISR2QLLm1rzRNOfDFANRb8sxsLlv0mWTdE8hZ2t4yC1JfhoH6CQT8w
         Hf24AhqugG+eJnfTIk/+tpPk6MSOunYw/Yx+B78zPFFquvHZCoznIMNwDh4zkb1gBw/9
         w0/RjcotPE/vJj0Hccbc45/4UUQ5BMwNms/m1IiqGeDM32wg8zMKfnTauh5rBxJCrZwP
         KIv6ig+k1/EvZ9UygNOf3dbNv6ky/7wafzgDmax7MC5wqES69n8CBLylWQamrxYSTpmq
         OTmg==
X-Gm-Message-State: AOAM53023fdGH4nIzR5BJ1dWk85CRH3p9RR9hz/NniZ4WNpipL9vkN+3
        H/X2ZUe1zGReSAqvgrVdjdF09RpeDbJafe52fjxhfWxEwvmD6eEl+kAIQeyjfxBV6VNCJJPsi1R
        Am4ClzLPYOmyjP5vfU6yWGQFsKJs=
X-Received: by 2002:a17:906:174e:: with SMTP id d14mr33331982eje.397.1622620849410;
        Wed, 02 Jun 2021 01:00:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4kBQQ+qVbLdHbp+3IgNhckO2HU0Frk857T6F/mIv2SQNg0q0hJFEo9hzt9BWkahSiLcGoNQ==
X-Received: by 2002:a17:906:174e:: with SMTP id d14mr33331968eje.397.1622620849195;
        Wed, 02 Jun 2021 01:00:49 -0700 (PDT)
Received: from localhost (net-93-71-117-34.cust.vodafonedsl.it. [93.71.117.34])
        by smtp.gmail.com with ESMTPSA id o4sm760191edc.94.2021.06.02.01.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 01:00:48 -0700 (PDT)
Date:   Wed, 2 Jun 2021 10:00:45 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        robin.chiu@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, Eric.Liang@mediatek.com,
        Stella.Chang@mediatek.com, jemele@google.com, yenlinlai@google.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 2/3] mt76: mt7921: add mt7921_mcu_sta_update support
Message-ID: <YLc6rWoCtuCdJDiZ@lore-desk>
References: <db74f1c3acd2a2729066810ad72b656681a30693.1622610746.git.objelf@gmail.com>
 <b6998d5ed25f86e1afce68060d840e0e37cb6670.1622610746.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hTneQT6p+ZoNK9OO"
Content-Disposition: inline
In-Reply-To: <b6998d5ed25f86e1afce68060d840e0e37cb6670.1622610746.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--hTneQT6p+ZoNK9OO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> Add mt7921_mcu_sta_update support to make we are able to update the stati=
on
> record with the current state the station has into the mt7921 firmware at
> runtime. That is the prerequisite patch to fix .sta_state incorrect
> implementation for the mt7921 driver.
>=20
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
> v1->v2: no change
> ---
>  .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 20 +++++++++++++++++++
>  .../wireless/mediatek/mt76/mt7921/mt7921.h    |  2 ++
>  2 files changed, 22 insertions(+)

What about squashing this patch with 3/3? it is just used there.

Regards,
Lorenzo

>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/mcu.c
> index 631f408520c9..3f53bd9b2b55 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> @@ -1342,6 +1342,26 @@ int mt7921_mcu_sta_add(struct mt7921_dev *dev, str=
uct ieee80211_sta *sta,
>  	return mt76_connac_mcu_add_sta_cmd(&dev->mphy, &info);
>  }
> =20
> +int mt7921_mcu_sta_update(struct mt7921_dev *dev, struct ieee80211_sta *=
sta,
> +			  struct ieee80211_vif *vif, u8 state)
> +{
> +	struct mt7921_vif *mvif =3D (struct mt7921_vif *)vif->drv_priv;
> +	int rssi =3D -ewma_rssi_read(&mvif->rssi);
> +	struct mt76_sta_cmd_info info =3D {
> +		.sta =3D sta,
> +		.vif =3D vif,
> +		.enable =3D true,
> +		.state =3D state,
> +		.cmd =3D MCU_UNI_CMD_STA_REC_UPDATE,
> +		.rcpi =3D to_rcpi(rssi),
> +	};
> +	struct mt7921_sta *msta;
> +
> +	msta =3D sta ? (struct mt7921_sta *)sta->drv_priv : NULL;
> +	info.wcid =3D msta ? &msta->wcid : &mvif->sta.wcid;
> +	return mt76_connac_mcu_update_sta_cmd(&dev->mphy, &info);
> +}
> +
>  int __mt7921_mcu_drv_pmctrl(struct mt7921_dev *dev)
>  {
>  	struct mt76_phy *mphy =3D &dev->mt76.phy;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers=
/net/wireless/mediatek/mt76/mt7921/mt7921.h
> index 694f85e52222..13d0f472b043 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> @@ -262,6 +262,8 @@ int mt7921_mcu_add_key(struct mt7921_dev *dev, struct=
 ieee80211_vif *vif,
>  int mt7921_set_channel(struct mt7921_phy *phy);
>  int mt7921_mcu_sta_add(struct mt7921_dev *dev, struct ieee80211_sta *sta,
>  		       struct ieee80211_vif *vif, bool enable, u8 state);
> +int mt7921_mcu_sta_update(struct mt7921_dev *dev, struct ieee80211_sta *=
sta,
> +			  struct ieee80211_vif *vif, u8 state);
>  int mt7921_mcu_set_chan_info(struct mt7921_phy *phy, int cmd);
>  int mt7921_mcu_set_tx(struct mt7921_dev *dev, struct ieee80211_vif *vif);
>  int mt7921_mcu_set_eeprom(struct mt7921_dev *dev);
> --=20
> 2.25.1
>=20

--hTneQT6p+ZoNK9OO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYLc6qQAKCRA6cBh0uS2t
rOjaAP9XHhEzeIC5SDLO2xrrEm8Y+sP6n3LgsmXhGrrj0xxGxAD/cLV97Y64JDbL
M5McDNe2ica+NLDi2bjnCxn5xDb3iwk=
=YGUP
-----END PGP SIGNATURE-----

--hTneQT6p+ZoNK9OO--

