Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CAC5A0BB9
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Aug 2022 10:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237774AbiHYIlh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Aug 2022 04:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238070AbiHYIlc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Aug 2022 04:41:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FECFA722F
        for <linux-wireless@vger.kernel.org>; Thu, 25 Aug 2022 01:41:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D331DB827A0
        for <linux-wireless@vger.kernel.org>; Thu, 25 Aug 2022 08:41:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CEEFC433D7;
        Thu, 25 Aug 2022 08:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661416886;
        bh=H2QZFKgh6j5irNfACvqxlvc4RiYU/z0FyKpvIZAthR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OBqP7NB9PjHdpQQq5z88fXWkddQe/YsZcaGnTVGw3ELYS0e6FI8UBhvrkwfYvqY5M
         o7j6Qg+37DWnRvBkDCRuCb5qdHN0a8VwtzDTc9I8f2p/vaxUvvKP+bARu1d90jLzKu
         Ign2TAfRR7RdYFIhwArWXstNgGwRQzi5kUmRpJDJfeYQvDCXjffwXzUlzujhwT/zUx
         g7fKXZDD11ZIuU1Uw/4V9+1m9RlImV2BbxLL+kQV7S7Ky1cOUs02cq1Y8egLcOTPeF
         ZwwIFeilutAIq/wP9TAdV+XO5vdk1ClyJ7YJsLsc+O2WEYASc1eez1o7e9eCMhye3h
         0Omruh8G8l1hg==
Date:   Thu, 25 Aug 2022 10:41:22 +0200
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
Subject: Re: [PATCH] mt76: mt7921: reset msta->airtime_ac while clearing up
 hw value
Message-ID: <Ywc1srMmMu51Nuzv@lore-desk>
References: <fd716a393e20d5db89f4f9d705d6dbbfde7260a6.1661400412.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GBjSkNIqgczU0Eds"
Content-Disposition: inline
In-Reply-To: <fd716a393e20d5db89f4f9d705d6dbbfde7260a6.1661400412.git.objelf@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--GBjSkNIqgczU0Eds
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> We should reset mstat->airtime_ac along with clear up the entries in the
> hardware WLAN table for the Rx and Rx accumulative airtime. Otherwsie, the
> value msta->airtime_ac - [tx, rx]_last may be a negative and that is not
> the actual airtime the device took in the last run.

the only point where we need it is mt7921_mac_sta_assoc() since in
mt7921_mac_sta_add() airtime_ac array is supposed to be already 0 and in
mt7921_mac_sta_remove() we are removing the sta. Is my understanding correc=
t?
If so, is it better to just add a memset(, 0, ..) in mt7921_mac_sta_assoc()?

Regards,
Lorenzo

>=20
> Reported-by: YN Chen <YN.Chen@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7921/mac.c   | 15 ++++++++++-----
>  drivers/net/wireless/mediatek/mt76/mt7921/main.c  |  9 +++------
>  .../net/wireless/mediatek/mt76/mt7921/mt7921.h    |  2 ++
>  3 files changed, 15 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/mac.c
> index 47f0aa81ab02..87dd0babff7a 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> @@ -46,6 +46,14 @@ bool mt7921_mac_wtbl_update(struct mt7921_dev *dev, in=
t idx, u32 mask)
>  			 0, 5000);
>  }
> =20
> +void mt7921_mac_sta_airtime_clear(struct mt7921_dev *dev,
> +				  struct mt7921_sta *msta)
> +{
> +	mt7921_mac_wtbl_update(dev, msta->wcid.idx,
> +			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
> +	memset(msta->airtime_ac, 0, sizeof(msta->airtime_ac));
> +}
> +
>  void mt7921_mac_sta_poll(struct mt7921_dev *dev)
>  {
>  	static const u8 ac_to_tid[] =3D {
> @@ -100,11 +108,8 @@ void mt7921_mac_sta_poll(struct mt7921_dev *dev)
>  			addr +=3D 8;
>  		}
> =20
> -		if (clear) {
> -			mt7921_mac_wtbl_update(dev, idx,
> -					       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
> -			memset(msta->airtime_ac, 0, sizeof(msta->airtime_ac));
> -		}
> +		if (clear)
> +			mt7921_mac_sta_airtime_clear(dev, msta);
> =20
>  		if (!msta->wcid.sta)
>  			continue;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/main.c
> index 1438a9f8d1fd..9d70884e24af 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> @@ -723,8 +723,7 @@ int mt7921_mac_sta_add(struct mt76_dev *mdev, struct =
ieee80211_vif *vif,
>  	if (vif->type =3D=3D NL80211_IFTYPE_STATION)
>  		mvif->wep_sta =3D msta;
> =20
> -	mt7921_mac_wtbl_update(dev, idx,
> -			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
> +	mt7921_mac_sta_airtime_clear(dev, msta);
> =20
>  	ret =3D mt7921_mcu_sta_update(dev, sta, vif, true,
>  				    MT76_STA_INFO_STATE_NONE);
> @@ -750,8 +749,7 @@ void mt7921_mac_sta_assoc(struct mt76_dev *mdev, stru=
ct ieee80211_vif *vif,
>  		mt76_connac_mcu_uni_add_bss(&dev->mphy, vif, &mvif->sta.wcid,
>  					    true);
> =20
> -	mt7921_mac_wtbl_update(dev, msta->wcid.idx,
> -			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
> +	mt7921_mac_sta_airtime_clear(dev, msta);
> =20
>  	mt7921_mcu_sta_update(dev, sta, vif, true, MT76_STA_INFO_STATE_ASSOC);
> =20
> @@ -769,8 +767,7 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, str=
uct ieee80211_vif *vif,
>  	mt76_connac_pm_wake(&dev->mphy, &dev->pm);
> =20
>  	mt7921_mcu_sta_update(dev, sta, vif, false, MT76_STA_INFO_STATE_NONE);
> -	mt7921_mac_wtbl_update(dev, msta->wcid.idx,
> -			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
> +	mt7921_mac_sta_airtime_clear(dev, msta);
> =20
>  	if (vif->type =3D=3D NL80211_IFTYPE_STATION) {
>  		struct mt7921_vif *mvif =3D (struct mt7921_vif *)vif->drv_priv;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers=
/net/wireless/mediatek/mt76/mt7921/mt7921.h
> index c161031ac62a..8b704d08509d 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> @@ -362,6 +362,8 @@ void mt7921_stop(struct ieee80211_hw *hw);
>  int mt7921_mac_init(struct mt7921_dev *dev);
>  bool mt7921_mac_wtbl_update(struct mt7921_dev *dev, int idx, u32 mask);
>  void mt7921_mac_reset_counters(struct mt7921_phy *phy);
> +void mt7921_mac_sta_airtime_clear(struct mt7921_dev *dev,
> +				  struct mt7921_sta *msta);
>  void mt7921_mac_set_timing(struct mt7921_phy *phy);
>  int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
>  		       struct ieee80211_sta *sta);
> --=20
> 2.25.1
>=20

--GBjSkNIqgczU0Eds
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYwc1sgAKCRA6cBh0uS2t
rNOxAPsECOLlQF/2VpapcI3Y3xn1EgbJRfjKrcUJkCoZQdFH+wD+L3ppCfAFtnUz
9FB5FYkBrVZRHHsGQiXvXPoTpmKlDgk=
=SeO5
-----END PGP SIGNATURE-----

--GBjSkNIqgczU0Eds--
