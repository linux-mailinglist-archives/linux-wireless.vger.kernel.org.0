Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A53398362
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jun 2021 09:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbhFBHph (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Jun 2021 03:45:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29287 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230348AbhFBHpg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Jun 2021 03:45:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622619833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BgDFaMFbgw0Ep+PbF5AZPdpXKIQE0rXInbQbiv+/ZDI=;
        b=dA4PPPpooQFRtORQ0DqOHROMQQyhr7LIio7JMGWk8fcuNZiNg9sLQE0o1QTmE6vo+emUpV
        icvF38yNwPeCa8Wo8OySbFGTh2suxGGNCt3p33FGEm9CG6HJXBOFA+brqBQIUddhTBU79w
        WugrLJy6pNeXMyMcjUxCy1aBPNldPJ8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-yaG0_BqaMOOpiOljARfL-Q-1; Wed, 02 Jun 2021 03:43:52 -0400
X-MC-Unique: yaG0_BqaMOOpiOljARfL-Q-1
Received: by mail-ej1-f72.google.com with SMTP id eb10-20020a170907280ab02903d65bd14481so340478ejc.21
        for <linux-wireless@vger.kernel.org>; Wed, 02 Jun 2021 00:43:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BgDFaMFbgw0Ep+PbF5AZPdpXKIQE0rXInbQbiv+/ZDI=;
        b=bwLjBr3KotPMk2IgFaw5W3Eo5qhKzJHUcgAZgfwl+ooFor31iFHfqzLbaAF0HKfqw9
         gAKPILnok9U6FZMMa8z9ObVcIlPq0Hkb1QzGYW3N2bBuQS/3ksoADgoIsYYCiXNqc3Fa
         qSdKI21pvMdsMrAf4dBjzYDX2L/YQ9xP4m8gwSOY8ysav09qFeOHm1OiusidPvFHtLNm
         mHlh18IhVOa7CEs872kKy1B7A/pEkTyJn2keX5xAO/zRQKiqeWthVIPbzfPzVSTM/qlQ
         5ZGlx+ly02U9E/uBvDglMqfWadfjHSK+5UILxpHdTHio497JBNc5G9rHlUC4FLkhAisS
         QYGA==
X-Gm-Message-State: AOAM530M/wb4rJFH/385+PPLkIyZ6I8gkeFl2hnyRHuDYGMPFNNFJjeA
        uugEFU9puBZ3RSD8Eb4XIfLbM5Cbw9Y+I1OeWECIpetbkuVkJgimFQMoqhP5v41NkEWoi9LWwPl
        q7i+6GI74gxrNXiYwyov+6EJeuf8=
X-Received: by 2002:aa7:dc17:: with SMTP id b23mr36728448edu.359.1622619829327;
        Wed, 02 Jun 2021 00:43:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAThPT+lyQPvjj+Q0U71Kf1uIO1RWWW1T1Lod3XjDeTYw9/4xTMlGHFJY30nBiK3/8ZbJnlQ==
X-Received: by 2002:aa7:dc17:: with SMTP id b23mr36728416edu.359.1622619829052;
        Wed, 02 Jun 2021 00:43:49 -0700 (PDT)
Received: from localhost (net-93-71-117-34.cust.vodafonedsl.it. [93.71.117.34])
        by smtp.gmail.com with ESMTPSA id p9sm773529edh.61.2021.06.02.00.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 00:43:48 -0700 (PDT)
Date:   Wed, 2 Jun 2021 09:43:45 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        robin.chiu@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, Eric.Liang@mediatek.com,
        Stella.Chang@mediatek.com, jemele@google.com, yenlinlai@google.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/3] mt76: connac: add mt76_connac_mcu_update_sta_cmd
 support
Message-ID: <YLc2sWcgBT5sqgcm@lore-desk>
References: <db74f1c3acd2a2729066810ad72b656681a30693.1622610746.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dwKDF4a27uR5qajW"
Content-Disposition: inline
In-Reply-To: <db74f1c3acd2a2729066810ad72b656681a30693.1622610746.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--dwKDF4a27uR5qajW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> Add mt76_connac_mcu_update_sta_cmd support that is the prerequisite patch
> for we are able to update the station record with the current state the
> station has into the offload firmware at runtime.
>=20
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
> v1->v2: no change
> ---
>  .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  6 ++--
>  .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 32 ++++++++++++++-----
>  .../wireless/mediatek/mt76/mt76_connac_mcu.h  | 16 ++++++++--
>  .../net/wireless/mediatek/mt76/mt7921/main.c  |  8 +++--
>  .../net/wireless/mediatek/mt76/mt7921/mcu.c   |  3 +-
>  .../wireless/mediatek/mt76/mt7921/mt7921.h    |  2 +-
>  6 files changed, 50 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7615/mcu.c
> index fc9cd8da2a11..3352c3559c09 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> @@ -1024,9 +1024,10 @@ mt7615_mcu_wtbl_sta_add(struct mt7615_phy *phy, st=
ruct ieee80211_vif *vif,
>  	if (IS_ERR(sskb))
>  		return PTR_ERR(sskb);
> =20
> -	mt76_connac_mcu_sta_basic_tlv(sskb, vif, sta, enable);
> +	mt76_connac_mcu_sta_basic_tlv(sskb, vif, sta, enable, true);
>  	if (enable && sta)
> -		mt76_connac_mcu_sta_tlv(phy->mt76, sskb, sta, vif, 0);
> +		mt76_connac_mcu_sta_tlv(phy->mt76, sskb, sta, vif, 0,
> +					MT76_STA_INFO_STATE_3);
> =20
>  	wtbl_hdr =3D mt76_connac_mcu_alloc_wtbl_req(&dev->mt76, &msta->wcid,
>  						  WTBL_RESET_AND_SET, NULL,
> @@ -1152,6 +1153,7 @@ __mt7615_mcu_add_sta(struct mt76_phy *phy, struct i=
eee80211_vif *vif,
>  		.vif =3D vif,
>  		.enable =3D enable,
>  		.cmd =3D cmd,
> +		.state =3D MT76_STA_INFO_STATE_3,

it seems to me this parameter is used only by mt7921, right? So we can drop
this chunk

>  	};
> =20
>  	info.wcid =3D sta ? (struct mt76_wcid *)sta->drv_priv : &mvif->sta.wcid;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drive=
rs/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> index 73359defa176..c49e4763fa4c 100644
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
> +static int mt76_connac_mcu_sta_cmd(struct mt76_phy *phy,
> +				   struct mt76_sta_cmd_info *info,
> +				   bool newly)
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
> @@ -902,8 +905,21 @@ int mt76_connac_mcu_add_sta_cmd(struct mt76_phy *phy,
> =20
>  	return mt76_mcu_skb_send_msg(dev, skb, info->cmd, true);
>  }
> +
> +int mt76_connac_mcu_add_sta_cmd(struct mt76_phy *phy,
> +				struct mt76_sta_cmd_info *info)
> +{
> +	return mt76_connac_mcu_sta_cmd(phy, info, true);
> +}
>  EXPORT_SYMBOL_GPL(mt76_connac_mcu_add_sta_cmd);
> =20
> +int mt76_connac_mcu_update_sta_cmd(struct mt76_phy *phy,
> +				   struct mt76_sta_cmd_info *info)
> +{
> +	return mt76_connac_mcu_sta_cmd(phy, info, false);
> +}
> +EXPORT_SYMBOL_GPL(mt76_connac_mcu_update_sta_cmd);

Do we really need these 2 routines? Maybe better to have them static inline=
 in
mt76_connac_mcu.h

> +
>  void mt76_connac_mcu_wtbl_ba_tlv(struct mt76_dev *dev, struct sk_buff *s=
kb,
>  				 struct ieee80211_ampdu_params *params,
>  				 bool enable, bool tx, void *sta_wtbl,
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drive=
rs/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> index d64b8058b744..6666507f43ed 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> @@ -902,6 +902,14 @@ struct mt76_connac_suspend_tlv {
>  	u8 pad[5];
>  } __packed;
> =20
> + /* 0: state 1 - unauthenticated & unassociated
> +  * 1: state 2 - authenticated & unassociated
> +  * 2: state 3 - authenticated & associated
> +  */
> +#define MT76_STA_INFO_STATE_1	0
> +#define MT76_STA_INFO_STATE_2	1
> +#define MT76_STA_INFO_STATE_3	2
> +
>  struct mt76_sta_cmd_info {
>  	struct ieee80211_sta *sta;
>  	struct mt76_wcid *wcid;
> @@ -911,6 +919,7 @@ struct mt76_sta_cmd_info {
>  	bool enable;
>  	int cmd;
>  	u8 rcpi;
> +	u8 state;
>  };
> =20
>  #define MT_SKU_POWER_LIMIT	161
> @@ -980,7 +989,8 @@ int mt76_connac_mcu_set_channel_domain(struct mt76_ph=
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
> @@ -995,7 +1005,7 @@ int mt76_connac_mcu_sta_update_hdr_trans(struct mt76=
_dev *dev,
>  void mt76_connac_mcu_sta_tlv(struct mt76_phy *mphy, struct sk_buff *skb,
>  			     struct ieee80211_sta *sta,
>  			     struct ieee80211_vif *vif,
> -			     u8 rcpi);
> +			     u8 rcpi, u8 state);
>  void mt76_connac_mcu_wtbl_ht_tlv(struct mt76_dev *dev, struct sk_buff *s=
kb,
>  				 struct ieee80211_sta *sta, void *sta_wtbl,
>  				 void *wtbl_tlv);
> @@ -1019,6 +1029,8 @@ int mt76_connac_mcu_uni_add_bss(struct mt76_phy *ph=
y,
>  				bool enable);
>  int mt76_connac_mcu_add_sta_cmd(struct mt76_phy *phy,
>  				struct mt76_sta_cmd_info *info);
> +int mt76_connac_mcu_update_sta_cmd(struct mt76_phy *phy,
> +				   struct mt76_sta_cmd_info *info);
>  void mt76_connac_mcu_beacon_loss_iter(void *priv, u8 *mac,
>  				      struct ieee80211_vif *vif);
>  int mt76_connac_mcu_set_rts_thresh(struct mt76_dev *dev, u32 val, u8 ban=
d);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/main.c
> index 472afd4ea487..ece0cecf049d 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> @@ -570,7 +570,8 @@ static void mt7921_bss_info_changed(struct ieee80211_=
hw *hw,
>  		mt7921_mcu_uni_bss_ps(dev, vif);
> =20
>  	if (changed & BSS_CHANGED_ASSOC) {
> -		mt7921_mcu_sta_add(dev, NULL, vif, true);
> +		mt7921_mcu_sta_add(dev, NULL, vif, true,
> +				   MT76_STA_INFO_STATE_3);
>  		mt7921_bss_bcnft_apply(dev, vif, info->assoc);
>  	}
> =20
> @@ -616,7 +617,8 @@ int mt7921_mac_sta_add(struct mt76_dev *mdev, struct =
ieee80211_vif *vif,
>  	mt7921_mac_wtbl_update(dev, idx,
>  			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
> =20
> -	ret =3D mt7921_mcu_sta_add(dev, sta, vif, true);
> +	ret =3D mt7921_mcu_sta_add(dev, sta, vif, true,
> +				 MT76_STA_INFO_STATE_3);
>  	if (ret)
>  		return ret;
> =20
> @@ -634,7 +636,7 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, str=
uct ieee80211_vif *vif,
>  	mt76_connac_free_pending_tx_skbs(&dev->pm, &msta->wcid);
>  	mt76_connac_pm_wake(&dev->mphy, &dev->pm);
> =20
> -	mt7921_mcu_sta_add(dev, sta, vif, false);
> +	mt7921_mcu_sta_add(dev, sta, vif, false, MT76_STA_INFO_STATE_1);
>  	mt7921_mac_wtbl_update(dev, msta->wcid.idx,
>  			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
> =20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/mcu.c
> index 4c97c5bdbf86..631f408520c9 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> @@ -1322,7 +1322,7 @@ int mt7921_mcu_set_bss_pm(struct mt7921_dev *dev, s=
truct ieee80211_vif *vif,
>  }
> =20
>  int mt7921_mcu_sta_add(struct mt7921_dev *dev, struct ieee80211_sta *sta,
> -		       struct ieee80211_vif *vif, bool enable)
> +		       struct ieee80211_vif *vif, bool enable, u8 state)
>  {
>  	struct mt7921_vif *mvif =3D (struct mt7921_vif *)vif->drv_priv;
>  	int rssi =3D -ewma_rssi_read(&mvif->rssi);
> @@ -1330,6 +1330,7 @@ int mt7921_mcu_sta_add(struct mt7921_dev *dev, stru=
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
> index a9b21fcc321c..694f85e52222 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> @@ -261,7 +261,7 @@ int mt7921_mcu_add_key(struct mt7921_dev *dev, struct=
 ieee80211_vif *vif,
>  		       enum set_key_cmd cmd);
>  int mt7921_set_channel(struct mt7921_phy *phy);
>  int mt7921_mcu_sta_add(struct mt7921_dev *dev, struct ieee80211_sta *sta,
> -		       struct ieee80211_vif *vif, bool enable);
> +		       struct ieee80211_vif *vif, bool enable, u8 state);

enum here

Regards,
Lorenzo

>  int mt7921_mcu_set_chan_info(struct mt7921_phy *phy, int cmd);
>  int mt7921_mcu_set_tx(struct mt7921_dev *dev, struct ieee80211_vif *vif);
>  int mt7921_mcu_set_eeprom(struct mt7921_dev *dev);
> --=20
> 2.25.1
>=20

--dwKDF4a27uR5qajW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYLc2rAAKCRA6cBh0uS2t
rIAyAP4wEWTZIjJ16s4nDBVu0owakLjAfrWDZ/PkKSxH7BzedgEA7YMHB7mnB0uQ
vhsi5XJCmtqlqn7iPTR5C05Ag2zFKw4=
=X6q6
-----END PGP SIGNATURE-----

--dwKDF4a27uR5qajW--

