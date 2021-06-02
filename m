Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 147533983A1
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jun 2021 09:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbhFBHxZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Jun 2021 03:53:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37433 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232282AbhFBHxU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Jun 2021 03:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622620296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y+f0Rpgg0gwVYNW1Y9Krvvm4PfIusPfL9uW367O1ntI=;
        b=KilAQQTUsg2dplFuBZp6GB5JEStuW4aKcCrIjyBrp1vb42eTT66eDnEHh8ppNeYHgsJtfa
        vqhSuWCB+htVDZ3g2BHhVARUGlMtGgV5VUQyLe+orC4muNqVlPDyt6ktep8dCydhlmVj1l
        Qak70SinN+ZEpJsGattWmNpdkgNlJxE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-I6dgOyu9PA2wRC4ckol7XA-1; Wed, 02 Jun 2021 03:51:32 -0400
X-MC-Unique: I6dgOyu9PA2wRC4ckol7XA-1
Received: by mail-ej1-f70.google.com with SMTP id eb10-20020a170907280ab02903d65bd14481so346190ejc.21
        for <linux-wireless@vger.kernel.org>; Wed, 02 Jun 2021 00:51:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y+f0Rpgg0gwVYNW1Y9Krvvm4PfIusPfL9uW367O1ntI=;
        b=EiI/4pyHcbEnkRcO9dgFeh2dH0wF2lDIZ/1zqYDSKK8VZdVXLOReMvOE/HS/PLyO46
         xfGKj6u+7CYKRZf2fznGku+dTIeWX958TH0MqyuEmY4e1KdigDDeenp96KPOZSDQEvce
         qDTO9mV/w7boLddj3O+EXKbFxTKa5K9/AqL3fziCmf+oO3apngK5mi6JD3RDlQFfVEq+
         P3rUTJPK/NLvDSlGWNItTthcrsrVOegGok6ZQxT7JoeKb7JkXJ1q1BOldvNj9WpyWk7G
         9wJIR0o2VGgLMrChPS7bA//MAYmPl3urQI7IDjzcF1dfws5pBlyzgxvk2i1tjYbvPK2I
         M1sQ==
X-Gm-Message-State: AOAM532YlH5T6ECDXDG2k1dV8nFRZk5UmRCixtghJxfvEqI/VUqtLxIJ
        Ct+RrNxkIy8lPvMdP2kBsnsM2K3k1yH5X6XiItiUyftyzfZSRv0HfXX17UH60APmm+KTS4TUI5H
        bA/tl1t/lxgBDA1S6nP2lgBKwFRk=
X-Received: by 2002:a17:906:2510:: with SMTP id i16mr11677784ejb.218.1622620291805;
        Wed, 02 Jun 2021 00:51:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0sR/o/Yumpl2rg9bzsyGs5NERtEaEoQlu+H/n93uTFJ+f1PJPBApZQglMqwHlSIZ4T44uLw==
X-Received: by 2002:a17:906:2510:: with SMTP id i16mr11677767ejb.218.1622620291633;
        Wed, 02 Jun 2021 00:51:31 -0700 (PDT)
Received: from localhost (net-93-71-117-34.cust.vodafonedsl.it. [93.71.117.34])
        by smtp.gmail.com with ESMTPSA id dn4sm780881edb.88.2021.06.02.00.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 00:51:31 -0700 (PDT)
Date:   Wed, 2 Jun 2021 09:51:28 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        robin.chiu@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, Eric.Liang@mediatek.com,
        Stella.Chang@mediatek.com, jemele@google.com, yenlinlai@google.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 3/3] mt76: mt7921: fix sta_state incorrect
 implementation
Message-ID: <YLc4gHgI6FpIGzMZ@lore-desk>
References: <db74f1c3acd2a2729066810ad72b656681a30693.1622610746.git.objelf@gmail.com>
 <129b40e5ff277efc0a1b0ff9b8c3dfb8a44ad7fe.1622610746.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mqgd5ozUDJP6SQDL"
Content-Disposition: inline
In-Reply-To: <129b40e5ff277efc0a1b0ff9b8c3dfb8a44ad7fe.1622610746.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--mqgd5ozUDJP6SQDL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> When .sta_state is implemented, mac80211 assumes that the station entry is
> usable after the NOTEXIST->NONE transition.
>=20
> So we should create the sta entry as early as possible in order that
> mac80211 pass assoc/auth frames to mt76 with the newly created sta entry,
> and add .sta_assoc to mt76 core to refresh the sta entry again when sta is
> being associated.
>=20
> Fixes: 8aa5a9b7361c ("mt76: mt7921: enable deep sleep at runtime")
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
> v1->v2: Put back the careless change not belonged to the patch to keep
> 	mt7921_mcu_sta_add for BC entry and mt76_connac_mcu_uni_add_bss
> 	on the association.
> ---
>  .../net/wireless/mediatek/mt76/mt7921/main.c  | 53 ++++++++-----------
>  .../wireless/mediatek/mt76/mt7921/mt7921.h    |  2 +
>  .../net/wireless/mediatek/mt76/mt7921/pci.c   |  1 +
>  3 files changed, 26 insertions(+), 30 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/main.c
> index ece0cecf049d..ae07367a091a 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> @@ -610,15 +610,11 @@ int mt7921_mac_sta_add(struct mt76_dev *mdev, struc=
t ieee80211_vif *vif,
>  	if (ret)
>  		return ret;
> =20
> -	if (vif->type =3D=3D NL80211_IFTYPE_STATION && !sta->tdls)
> -		mt76_connac_mcu_uni_add_bss(&dev->mphy, vif, &mvif->sta.wcid,
> -					    true);
> -
>  	mt7921_mac_wtbl_update(dev, idx,
>  			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
> =20
>  	ret =3D mt7921_mcu_sta_add(dev, sta, vif, true,
> -				 MT76_STA_INFO_STATE_3);
> +				 MT76_STA_INFO_STATE_1);
>  	if (ret)
>  		return ret;
> =20
> @@ -627,6 +623,27 @@ int mt7921_mac_sta_add(struct mt76_dev *mdev, struct=
 ieee80211_vif *vif,
>  	return 0;
>  }
> =20
> +void mt7921_mac_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *v=
if,
> +			  struct ieee80211_sta *sta)
> +{
> +	struct mt7921_dev *dev =3D container_of(mdev, struct mt7921_dev, mt76);
> +	struct mt7921_sta *msta =3D (struct mt7921_sta *)sta->drv_priv;
> +	struct mt7921_vif *mvif =3D (struct mt7921_vif *)vif->drv_priv;
> +

here you need to grab grub the dev mutex because mt76 code does not do it f=
or
you

%s/mt76_connac_pm_wake(&dev->mphy, &dev->pm)/mt7921_mutex_acquire()/
> +	mt76_connac_pm_wake(&dev->mphy, &dev->pm);
> +
> +	if (vif->type =3D=3D NL80211_IFTYPE_STATION && !sta->tdls)
> +		mt76_connac_mcu_uni_add_bss(&dev->mphy, vif, &mvif->sta.wcid,
> +					    true);
> +
> +	mt7921_mac_wtbl_update(dev, msta->wcid.idx,
> +			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
> +
> +	mt7921_mcu_sta_update(dev, sta, vif, MT76_STA_INFO_STATE_3);
> +
> +	mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
%s/mt76_connac_power_save_sched/mt7921_mutex_release/
> +}
> +
>  void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *=
vif,
>  			   struct ieee80211_sta *sta)
>  {
> @@ -781,22 +798,6 @@ mt7921_ampdu_action(struct ieee80211_hw *hw, struct =
ieee80211_vif *vif,
>  	return ret;
>  }
> =20
> -static int
> -mt7921_sta_add(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
> -	       struct ieee80211_sta *sta)
> -{
> -	return mt76_sta_state(hw, vif, sta, IEEE80211_STA_NOTEXIST,
> -			      IEEE80211_STA_NONE);
> -}
> -
> -static int
> -mt7921_sta_remove(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
> -		  struct ieee80211_sta *sta)
> -{
> -	return mt76_sta_state(hw, vif, sta, IEEE80211_STA_NONE,
> -			      IEEE80211_STA_NOTEXIST);
> -}
> -
>  static int mt7921_sta_state(struct ieee80211_hw *hw,
>  			    struct ieee80211_vif *vif,
>  			    struct ieee80211_sta *sta,
> @@ -811,15 +812,7 @@ static int mt7921_sta_state(struct ieee80211_hw *hw,
>  		mt7921_mutex_release(dev);
>  	}
> =20
> -	if (old_state =3D=3D IEEE80211_STA_AUTH &&
> -	    new_state =3D=3D IEEE80211_STA_ASSOC) {
> -		return mt7921_sta_add(hw, vif, sta);
> -	} else if (old_state =3D=3D IEEE80211_STA_ASSOC &&
> -		   new_state =3D=3D IEEE80211_STA_AUTH) {
> -		return mt7921_sta_remove(hw, vif, sta);
> -	}
> -
> -	return 0;
> +	return mt76_sta_state(hw, vif, sta, old_state, new_state);
>  }
> =20
>  static int
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers=
/net/wireless/mediatek/mt76/mt7921/mt7921.h
> index 13d0f472b043..e97a74341ccd 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> @@ -264,6 +264,8 @@ int mt7921_mcu_sta_add(struct mt7921_dev *dev, struct=
 ieee80211_sta *sta,
>  		       struct ieee80211_vif *vif, bool enable, u8 state);
>  int mt7921_mcu_sta_update(struct mt7921_dev *dev, struct ieee80211_sta *=
sta,
>  			  struct ieee80211_vif *vif, u8 state);
> +void mt7921_mac_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *v=
if,
> +			  struct ieee80211_sta *sta);
>  int mt7921_mcu_set_chan_info(struct mt7921_phy *phy, int cmd);
>  int mt7921_mcu_set_tx(struct mt7921_dev *dev, struct ieee80211_vif *vif);
>  int mt7921_mcu_set_eeprom(struct mt7921_dev *dev);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/pci.c
> index 13263f50dc00..27906b2cd912 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> @@ -106,6 +106,7 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
>  		.rx_poll_complete =3D mt7921_rx_poll_complete,
>  		.sta_ps =3D mt7921_sta_ps,
>  		.sta_add =3D mt7921_mac_sta_add,
> +		.sta_assoc =3D mt7921_mac_sta_assoc,
>  		.sta_remove =3D mt7921_mac_sta_remove,
>  		.update_survey =3D mt7921_update_channel,
>  	};
> --=20
> 2.25.1
>=20

--mqgd5ozUDJP6SQDL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYLc4egAKCRA6cBh0uS2t
rGzwAQD8IbmW3FYmLgelgNHokp8ahwkrUg4lUkY4HTl3f0dBSQD7BvbELrGaESi0
pk+BU/AV5VldmF2Annh8U16y3OgarwY=
=EKZY
-----END PGP SIGNATURE-----

--mqgd5ozUDJP6SQDL--

