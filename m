Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69B98399CA8
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jun 2021 10:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbhFCIhg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Jun 2021 04:37:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:50756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229479AbhFCIhf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Jun 2021 04:37:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 058EE613C9;
        Thu,  3 Jun 2021 08:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622709350;
        bh=UFYZnhgTFctTSXF2aMwrOTGHyqGiJVJmgGLfT7xCIBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pw+4QEe5DyeJiS8agPYyt8aT3YnzrfXxZJ3cOms2/fVuylb+bduWwojgvhRXbPJIy
         ZxG9Cwrb+4rfidY44EtTqcxnEd1AtsDUjnMJSYw/kOg1W4WmNgteIy2L8ZSCOYU1F6
         /vq6PYfez+6Ofy91rPepm9uJ8HH0oSPgxaSk4GWwcfaSkgPnAKv3ETa5/WU5NnJ7Br
         eDgA0dqw45Ye9DB9xaB+7iOjXgRqpuUgBUl2PGHdrnHPFozXzmGDnjrKFEJ/1uFtqm
         XMWsg07VZ6/4cdd2PAQRGXkTAWvACCNHagmU7bndINtOyWgxVE4a2W9LLnVZshk0uq
         TZxOzReZXwXRA==
Date:   Thu, 3 Jun 2021 10:35:45 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com, Soul.Huang@mediatek.com,
        YN.Chen@mediatek.com, Leon.Yen@mediatek.com,
        Eric-SY.Chang@mediatek.com, Deren.Wu@mediatek.com,
        km.lin@mediatek.com, robin.chiu@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, Eric.Liang@mediatek.com,
        Stella.Chang@mediatek.com, jemele@google.com, yenlinlai@google.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 1/2] mt76: connac: add mt76_connac_mcu_update_sta_cmd
 support
Message-ID: <YLiUYdCtg7YBUWHx@lore-desk>
References: <eefc22e4c64c8605bcaf2aa0feae0ef3d4084ebf.1622688431.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RM9Yksc8nRDGmtZJ"
Content-Disposition: inline
In-Reply-To: <eefc22e4c64c8605bcaf2aa0feae0ef3d4084ebf.1622688431.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--RM9Yksc8nRDGmtZJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> Add mt76_connac_mcu_update_sta_cmd support that is the prerequisite patch
> for we are able to update the station record with the current state the
> station has into the offload firmware at runtime.

could you please rebase it on top of "mt76: connac: fix UC entry is being o=
verwritten"?
https://patchwork.kernel.org/project/linux-wireless/patch/3d30cb9e40df970e2=
f4ef09c975f9fd6f7dc02dd.1622649436.git.lorenzo@kernel.org/

>=20
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
> v1->v2: no change
> v2->v3: 1. rebase the latest mt76
> 	2. turn into using enum mt76_sta_info_state
> 	3. drop unneeded .state parameter passing in __mt7615_mcu_add_sta
> 	4. make mt76_connac_mcu_add_sta_cmd and
> 	   mt76_connac_mcu_update_sta_cmd static inline in
> 	   mt76_connac_mcu.h
> ---
>  .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  5 +--
>  .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 21 +++++++------
>  .../wireless/mediatek/mt76/mt76_connac_mcu.h  | 31 ++++++++++++++++---
>  .../net/wireless/mediatek/mt76/mt7921/main.c  |  8 +++--
>  .../net/wireless/mediatek/mt76/mt7921/mcu.c   |  4 ++-
>  .../wireless/mediatek/mt76/mt7921/mt7921.h    |  3 +-
>  6 files changed, 52 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7615/mcu.c
> index cf4a4f2637d5..2f73bcb607dd 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> @@ -1028,9 +1028,10 @@ mt7615_mcu_wtbl_sta_add(struct mt7615_phy *phy, st=
ruct ieee80211_vif *vif,
>  	if (IS_ERR(sskb))
>  		return PTR_ERR(sskb);
> =20
> -	mt76_connac_mcu_sta_basic_tlv(sskb, vif, sta, enable);
> +	mt76_connac_mcu_sta_basic_tlv(sskb, vif, sta, enable, true);
>  	if (enable && sta)
> -		mt76_connac_mcu_sta_tlv(phy->mt76, sskb, sta, vif, 0);
> +		mt76_connac_mcu_sta_tlv(phy->mt76, sskb, sta, vif, 0,
> +					MT76_STA_INFO_STATE_ASSOC);
> =20
>  	wtbl_hdr =3D mt76_connac_mcu_alloc_wtbl_req(&dev->mt76, &msta->wcid,
>  						  WTBL_RESET_AND_SET, NULL,
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drive=
rs/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> index b155e7b8d89d..45465eb3581a 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> @@ -304,7 +304,7 @@ EXPORT_SYMBOL_GPL(mt76_connac_mcu_alloc_wtbl_req);
>  void mt76_connac_mcu_sta_basic_tlv(struct sk_buff *skb,
>  				   struct ieee80211_vif *vif,
>  				   struct ieee80211_sta *sta,
> -				   bool enable)
> +				   bool enable, bool newly)
>  {
>  	struct sta_rec_basic *basic;
>  	struct tlv *tlv;
> @@ -316,7 +316,8 @@ void mt76_connac_mcu_sta_basic_tlv(struct sk_buff *sk=
b,
>  	basic->extra_info =3D cpu_to_le16(EXTRA_INFO_VER);
> =20
>  	if (enable) {
> -		basic->extra_info |=3D cpu_to_le16(EXTRA_INFO_NEW);
> +		if (newly)
> +			basic->extra_info |=3D cpu_to_le16(EXTRA_INFO_NEW);
>  		basic->conn_state =3D CONN_STATE_PORT_SECURE;
>  	} else {
>  		basic->conn_state =3D CONN_STATE_DISCONNECT;
> @@ -709,7 +710,7 @@ mt76_connac_get_phy_mode_v2(struct mt76_phy *mphy, st=
ruct ieee80211_vif *vif,
>  void mt76_connac_mcu_sta_tlv(struct mt76_phy *mphy, struct sk_buff *skb,
>  			     struct ieee80211_sta *sta,
>  			     struct ieee80211_vif *vif,
> -			     u8 rcpi)
> +			     u8 rcpi, u8 sta_state)
>  {
>  	struct cfg80211_chan_def *chandef =3D &mphy->chandef;
>  	enum nl80211_band band =3D chandef->chan->band;
> @@ -770,7 +771,7 @@ void mt76_connac_mcu_sta_tlv(struct mt76_phy *mphy, s=
truct sk_buff *skb,
> =20
>  	tlv =3D mt76_connac_mcu_add_tlv(skb, STA_REC_STATE, sizeof(*state));
>  	state =3D (struct sta_rec_state *)tlv;
> -	state->state =3D 2;
> +	state->state =3D sta_state;
> =20
>  	if (sta->vht_cap.vht_supported) {
>  		state->vht_opmode =3D sta->bandwidth;
> @@ -862,8 +863,9 @@ void mt76_connac_mcu_wtbl_ht_tlv(struct mt76_dev *dev=
, struct sk_buff *skb,
>  }
>  EXPORT_SYMBOL_GPL(mt76_connac_mcu_wtbl_ht_tlv);
> =20
> -int mt76_connac_mcu_add_sta_cmd(struct mt76_phy *phy,
> -				struct mt76_sta_cmd_info *info)
> +int mt76_connac_mcu_sta_cmd(struct mt76_phy *phy,
> +			    struct mt76_sta_cmd_info *info,
> +			    bool newly)
>  {
>  	struct mt76_vif *mvif =3D (struct mt76_vif *)info->vif->drv_priv;
>  	struct mt76_dev *dev =3D phy->dev;
> @@ -875,10 +877,11 @@ int mt76_connac_mcu_add_sta_cmd(struct mt76_phy *ph=
y,
>  	if (IS_ERR(skb))
>  		return PTR_ERR(skb);
> =20
> -	mt76_connac_mcu_sta_basic_tlv(skb, info->vif, info->sta, info->enable);
> +	mt76_connac_mcu_sta_basic_tlv(skb, info->vif, info->sta, info->enable,
> +				      newly);
>  	if (info->enable && info->sta)
>  		mt76_connac_mcu_sta_tlv(phy, skb, info->sta, info->vif,
> -					info->rcpi);
> +					info->rcpi, info->state);
> =20
>  	sta_wtbl =3D mt76_connac_mcu_add_tlv(skb, STA_REC_WTBL,
>  					   sizeof(struct tlv));
> @@ -902,7 +905,7 @@ int mt76_connac_mcu_add_sta_cmd(struct mt76_phy *phy,
> =20
>  	return mt76_mcu_skb_send_msg(dev, skb, info->cmd, true);
>  }
> -EXPORT_SYMBOL_GPL(mt76_connac_mcu_add_sta_cmd);
> +EXPORT_SYMBOL_GPL(mt76_connac_mcu_sta_cmd);
> =20
>  void mt76_connac_mcu_wtbl_ba_tlv(struct mt76_dev *dev, struct sk_buff *s=
kb,
>  				 struct ieee80211_ampdu_params *params,
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drive=
rs/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> index 3076417ead5f..c7b809ff3045 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> @@ -904,6 +904,12 @@ struct mt76_connac_suspend_tlv {
>  	u8 pad[5];
>  } __packed;
> =20
> +enum mt76_sta_info_state {
> +	MT76_STA_INFO_STATE_NONE,
> +	MT76_STA_INFO_STATE_AUTH,
> +	MT76_STA_INFO_STATE_ASSOC
> +};
> +
>  struct mt76_sta_cmd_info {
>  	struct ieee80211_sta *sta;
>  	struct mt76_wcid *wcid;
> @@ -913,6 +919,7 @@ struct mt76_sta_cmd_info {
>  	bool enable;
>  	int cmd;
>  	u8 rcpi;
> +	u8 state;
why not enum mt76_sta_info_state here swapping with rcpi?
>  };
> =20
>  #define MT_SKU_POWER_LIMIT	161
> @@ -982,7 +989,8 @@ int mt76_connac_mcu_set_channel_domain(struct mt76_ph=
y *phy);
>  int mt76_connac_mcu_set_vif_ps(struct mt76_dev *dev, struct ieee80211_vi=
f *vif);
>  void mt76_connac_mcu_sta_basic_tlv(struct sk_buff *skb,
>  				   struct ieee80211_vif *vif,
> -				   struct ieee80211_sta *sta, bool enable);
> +				   struct ieee80211_sta *sta, bool enable,
> +				   bool newly);
>  void mt76_connac_mcu_wtbl_generic_tlv(struct mt76_dev *dev, struct sk_bu=
ff *skb,
>  				      struct ieee80211_vif *vif,
>  				      struct ieee80211_sta *sta, void *sta_wtbl,
> @@ -997,7 +1005,7 @@ int mt76_connac_mcu_sta_update_hdr_trans(struct mt76=
_dev *dev,
>  void mt76_connac_mcu_sta_tlv(struct mt76_phy *mphy, struct sk_buff *skb,
>  			     struct ieee80211_sta *sta,
>  			     struct ieee80211_vif *vif,
> -			     u8 rcpi);
> +			     u8 rcpi, u8 state);

why not enum mt76_sta_info_state here?

>  void mt76_connac_mcu_wtbl_ht_tlv(struct mt76_dev *dev, struct sk_buff *s=
kb,
>  				 struct ieee80211_sta *sta, void *sta_wtbl,
>  				 void *wtbl_tlv);
> @@ -1019,8 +1027,9 @@ int mt76_connac_mcu_uni_add_bss(struct mt76_phy *ph=
y,
>  				struct ieee80211_vif *vif,
>  				struct mt76_wcid *wcid,
>  				bool enable);
> -int mt76_connac_mcu_add_sta_cmd(struct mt76_phy *phy,
> -				struct mt76_sta_cmd_info *info);
> +int mt76_connac_mcu_sta_cmd(struct mt76_phy *phy,
> +			    struct mt76_sta_cmd_info *info,
> +			    bool newly);
>  void mt76_connac_mcu_beacon_loss_iter(void *priv, u8 *mac,
>  				      struct ieee80211_vif *vif);
>  int mt76_connac_mcu_set_rts_thresh(struct mt76_dev *dev, u32 val, u8 ban=
d);
> @@ -1059,4 +1068,18 @@ int mt76_connac_mcu_set_deep_sleep(struct mt76_dev=
 *dev, bool enable);
>  void mt76_connac_mcu_coredump_event(struct mt76_dev *dev, struct sk_buff=
 *skb,
>  				    struct mt76_connac_coredump *coredump);
>  int mt76_connac_mcu_set_rate_txpower(struct mt76_phy *phy);
> +
> +static inline int
> +mt76_connac_mcu_add_sta_cmd(struct mt76_phy *phy,
> +			    struct mt76_sta_cmd_info *info)
> +{
> +	return mt76_connac_mcu_sta_cmd(phy, info, true);
> +}
> +
> +static inline int
> +mt76_connac_mcu_update_sta_cmd(struct mt76_phy *phy,
> +			       struct mt76_sta_cmd_info *info)
> +{
> +	return mt76_connac_mcu_sta_cmd(phy, info, false);
> +}
>  #endif /* __MT76_CONNAC_MCU_H */
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/main.c
> index 84930ad5ebc7..c641a92b140c 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> @@ -578,7 +578,8 @@ static void mt7921_bss_info_changed(struct ieee80211_=
hw *hw,
>  		mt7921_mcu_uni_bss_ps(dev, vif);
> =20
>  	if (changed & BSS_CHANGED_ASSOC) {
> -		mt7921_mcu_sta_add(dev, NULL, vif, true);
> +		mt7921_mcu_sta_add(dev, NULL, vif, true,
> +				   MT76_STA_INFO_STATE_ASSOC);
>  		mt7921_bss_bcnft_apply(dev, vif, info->assoc);
>  	}
> =20
> @@ -627,7 +628,8 @@ int mt7921_mac_sta_add(struct mt76_dev *mdev, struct =
ieee80211_vif *vif,
>  	mt7921_mac_wtbl_update(dev, idx,
>  			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
> =20
> -	ret =3D mt7921_mcu_sta_add(dev, sta, vif, true);
> +	ret =3D mt7921_mcu_sta_add(dev, sta, vif, true,
> +				 MT76_STA_INFO_STATE_ASSOC);
>  	if (ret)
>  		return ret;
> =20
> @@ -645,7 +647,7 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, str=
uct ieee80211_vif *vif,
>  	mt76_connac_free_pending_tx_skbs(&dev->pm, &msta->wcid);
>  	mt76_connac_pm_wake(&dev->mphy, &dev->pm);
> =20
> -	mt7921_mcu_sta_add(dev, sta, vif, false);
> +	mt7921_mcu_sta_add(dev, sta, vif, false, MT76_STA_INFO_STATE_NONE);
>  	mt7921_mac_wtbl_update(dev, msta->wcid.idx,
>  			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
> =20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/mcu.c
> index ffc83717fd0d..4f0fd9674950 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> @@ -1268,7 +1268,8 @@ int mt7921_mcu_set_bss_pm(struct mt7921_dev *dev, s=
truct ieee80211_vif *vif,
>  }
> =20
>  int mt7921_mcu_sta_add(struct mt7921_dev *dev, struct ieee80211_sta *sta,
> -		       struct ieee80211_vif *vif, bool enable)
> +		       struct ieee80211_vif *vif, bool enable,
> +		       enum mt76_sta_info_state state)
>  {
>  	struct mt7921_vif *mvif =3D (struct mt7921_vif *)vif->drv_priv;
>  	int rssi =3D -ewma_rssi_read(&mvif->rssi);
> @@ -1276,6 +1277,7 @@ int mt7921_mcu_sta_add(struct mt7921_dev *dev, stru=
ct ieee80211_sta *sta,
>  		.sta =3D sta,
>  		.vif =3D vif,
>  		.enable =3D enable,
> +		.state =3D state,
>  		.cmd =3D MCU_UNI_CMD_STA_REC_UPDATE,
>  		.rcpi =3D to_rcpi(rssi),
>  	};
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers=
/net/wireless/mediatek/mt76/mt7921/mt7921.h
> index 8aa8d2ecdffa..d4d84b898011 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> @@ -263,7 +263,8 @@ int mt7921_mcu_add_key(struct mt7921_dev *dev, struct=
 ieee80211_vif *vif,
>  		       enum set_key_cmd cmd);
>  int mt7921_set_channel(struct mt7921_phy *phy);
>  int mt7921_mcu_sta_add(struct mt7921_dev *dev, struct ieee80211_sta *sta,
> -		       struct ieee80211_vif *vif, bool enable);
> +		       struct ieee80211_vif *vif, bool enable,
> +		       enum mt76_sta_info_state state);
>  int mt7921_mcu_set_chan_info(struct mt7921_phy *phy, int cmd);
>  int mt7921_mcu_set_tx(struct mt7921_dev *dev, struct ieee80211_vif *vif);
>  int mt7921_mcu_set_eeprom(struct mt7921_dev *dev);
> --=20
> 2.25.1
>=20

--RM9Yksc8nRDGmtZJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYLiUXAAKCRA6cBh0uS2t
rC0RAQDnCOncTmA2bA7WXUF4L2lszRRGuSJUlN8WfGqe1WodQAEA/OICUGNr9rvN
jgthFBMe7Z72bekJluUzUdrMRN0lMQs=
=k/gZ
-----END PGP SIGNATURE-----

--RM9Yksc8nRDGmtZJ--
