Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3423399CAD
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jun 2021 10:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbhFCIip (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Jun 2021 04:38:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:51824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229479AbhFCIip (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Jun 2021 04:38:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F2B7D61008;
        Thu,  3 Jun 2021 08:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622709421;
        bh=T2j1kK4KUGa2RWqXdkMdX/nO1XjJdI47yipEgTJfLVE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fRw8/3+yp0aKqSWJzU2RQ4rWTFDKl9oO4WtKgJ3AKuD+DK6lmCKb0lXF6KrZZ8i24
         hRbMRnvvkcX9Zosfwm/uNFD7GV/bMo4xD00Arskwr1oAyt4Pkx9PknyqcnZ5kWYz54
         cAlwiiZqw3Hu4nejPHYvk7qFhIwjuZmgS/QqbQgjTfTQvbQZXgMaDYvCERXRMMY1Jn
         D7xeltdksx0zyfI35AJsueC8tv7Zsa+Dz6bj1XzY8VcwnRPmCM1L/VLgMw798C3YHi
         R9TzujHoTBfoCKfoP+NJnO+xyPwFbFuFHiA8d1RNrskwGEr4QCE/MqCulAIynXh3pL
         uMm/wk5ywxk4w==
Date:   Thu, 3 Jun 2021 10:36:56 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com, Soul.Huang@mediatek.com,
        YN.Chen@mediatek.com, Leon.Yen@mediatek.com,
        Eric-SY.Chang@mediatek.com, Deren.Wu@mediatek.com,
        km.lin@mediatek.com, robin.chiu@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, Eric.Liang@mediatek.com,
        Stella.Chang@mediatek.com, jemele@google.com, yenlinlai@google.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 2/2] mt76: mt7921: fix sta_state incorrect
 implementation
Message-ID: <YLiUqHHsVF2ZqL+1@lore-desk>
References: <eefc22e4c64c8605bcaf2aa0feae0ef3d4084ebf.1622688431.git.objelf@gmail.com>
 <e0a33a31da8a69dcf13d30e2d2591329c8d33689.1622688431.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="glSRNysLCxhi4tEa"
Content-Disposition: inline
In-Reply-To: <e0a33a31da8a69dcf13d30e2d2591329c8d33689.1622688431.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--glSRNysLCxhi4tEa
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
> v2->v3: 1. rebase the latest mt76
> 	2. squashing 2/3 to the one
> 	3. add the proper lock in mt7921_mac_sta_assoc
> ---
>  .../net/wireless/mediatek/mt76/mt7921/main.c  | 55 ++++++++-----------
>  .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 20 +++++++
>  .../wireless/mediatek/mt76/mt7921/mt7921.h    |  4 ++
>  .../net/wireless/mediatek/mt76/mt7921/pci.c   |  1 +
>  4 files changed, 49 insertions(+), 31 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/main.c
> index c641a92b140c..af98835b5134 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> @@ -618,18 +618,14 @@ int mt7921_mac_sta_add(struct mt76_dev *mdev, struc=
t ieee80211_vif *vif,
>  	if (ret)
>  		return ret;
> =20
> -	if (vif->type =3D=3D NL80211_IFTYPE_STATION) {
> +	if (vif->type =3D=3D NL80211_IFTYPE_STATION)
>  		mvif->wep_sta =3D msta;
> -		if (!sta->tdls)
> -			mt76_connac_mcu_uni_add_bss(&dev->mphy, vif,
> -						    &mvif->sta.wcid, true);
> -	}
> =20
>  	mt7921_mac_wtbl_update(dev, idx,
>  			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
> =20
>  	ret =3D mt7921_mcu_sta_add(dev, sta, vif, true,
> -				 MT76_STA_INFO_STATE_ASSOC);
> +				 MT76_STA_INFO_STATE_NONE);
>  	if (ret)
>  		return ret;
> =20
> @@ -638,6 +634,27 @@ int mt7921_mac_sta_add(struct mt76_dev *mdev, struct=
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
> +	mt7921_mutex_acquire(dev);
> +
> +	if (vif->type =3D=3D NL80211_IFTYPE_STATION && !sta->tdls)
> +		mt76_connac_mcu_uni_add_bss(&dev->mphy, vif, &mvif->sta.wcid,
> +					    true);
> +
> +	mt7921_mac_wtbl_update(dev, msta->wcid.idx,
> +			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
> +
> +	mt7921_mcu_sta_update(dev, sta, vif, MT76_STA_INFO_STATE_ASSOC);
> +
> +	mt7921_mutex_release(dev);
> +}
> +
>  void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *=
vif,
>  			   struct ieee80211_sta *sta)
>  {
> @@ -793,22 +810,6 @@ mt7921_ampdu_action(struct ieee80211_hw *hw, struct =
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
> @@ -823,15 +824,7 @@ static int mt7921_sta_state(struct ieee80211_hw *hw,
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
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/mcu.c
> index 4f0fd9674950..ab338bdf4f4a 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> @@ -1289,6 +1289,26 @@ int mt7921_mcu_sta_add(struct mt7921_dev *dev, str=
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

It seems to me it is quite the same of mt7921_mcu_sta_add, right?
Why not always use mt7921_mcu_sta_update?

Regards,
Lorenzo

> +}
> +
>  int __mt7921_mcu_drv_pmctrl(struct mt7921_dev *dev)
>  {
>  	struct mt76_phy *mphy =3D &dev->mt76.phy;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers=
/net/wireless/mediatek/mt76/mt7921/mt7921.h
> index d4d84b898011..196e47f89fc1 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> @@ -265,6 +265,8 @@ int mt7921_set_channel(struct mt7921_phy *phy);
>  int mt7921_mcu_sta_add(struct mt7921_dev *dev, struct ieee80211_sta *sta,
>  		       struct ieee80211_vif *vif, bool enable,
>  		       enum mt76_sta_info_state state);
> +int mt7921_mcu_sta_update(struct mt7921_dev *dev, struct ieee80211_sta *=
sta,
> +			  struct ieee80211_vif *vif, u8 state);
>  int mt7921_mcu_set_chan_info(struct mt7921_phy *phy, int cmd);
>  int mt7921_mcu_set_tx(struct mt7921_dev *dev, struct ieee80211_vif *vif);
>  int mt7921_mcu_set_eeprom(struct mt7921_dev *dev);
> @@ -336,6 +338,8 @@ void mt7921_mac_fill_rx_vector(struct mt7921_dev *dev=
, struct sk_buff *skb);
>  void mt7921_mac_tx_free(struct mt7921_dev *dev, struct sk_buff *skb);
>  int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
>  		       struct ieee80211_sta *sta);
> +void mt7921_mac_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *v=
if,
> +			  struct ieee80211_sta *sta);
>  void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *=
vif,
>  			   struct ieee80211_sta *sta);
>  void mt7921_mac_work(struct work_struct *work);
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

--glSRNysLCxhi4tEa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYLiUpAAKCRA6cBh0uS2t
rP3BAP0e+UOpYqAuMuc8Axtzg1ThrClCoNvdP+2cxlF3OA1wdgEAq2i++VXnOLxM
L4TLndtLrAjIr2VjUGjSBs9HqsdZWgE=
=fGJR
-----END PGP SIGNATURE-----

--glSRNysLCxhi4tEa--
