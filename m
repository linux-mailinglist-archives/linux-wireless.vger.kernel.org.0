Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A054014403D
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2020 16:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgAUPLN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Jan 2020 10:11:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:47190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729106AbgAUPLN (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Jan 2020 10:11:13 -0500
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com [213.175.37.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F138D21569;
        Tue, 21 Jan 2020 15:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579619472;
        bh=Nf+pOqPROw4DJFNsxg2rTIhXK+9kSGaNFWOCAAgGwRs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uTOzTNuoC9gXsOuBpvrdaxncYyI0qq6tdigf+tjUeUvao0KRe0tWrHgJom/FIEArX
         DqOArQbvPLiE+1PO68hjOLlvF/283x6LRxtbQIe82d1sHV/bbTTTfAQdAkaUHsTrIj
         7gMvez/MHpaFgGnRQvoa6qpU4YM+z+5qMYs3n+Qw=
Date:   Tue, 21 Jan 2020 16:11:05 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Roy Luo <royluo@google.com>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/7] mt76: mt7615: simplify mcu_set_bmc flow
Message-ID: <20200121151105.GA2396@localhost.localdomain>
References: <ae72dd289f8a26a2c0f42de1f940bb8b6d1f2c29.1579237414.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <ae72dd289f8a26a2c0f42de1f940bb8b6d1f2c29.1579237414.git.ryder.lee@mediatek.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Move mcu_wtbl_bmc into mcu_set_sta_rec_bmc to simplify flow.
>=20
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  .../net/wireless/mediatek/mt76/mt7615/main.c  |  3 +-
>  .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 97 ++++++++-----------
>  .../wireless/mediatek/mt76/mt7615/mt7615.h    |  6 +-
>  3 files changed, 45 insertions(+), 61 deletions(-)
>=20

[...]

> -int mt7615_mcu_set_sta_rec_bmc(struct mt7615_dev *dev,
> -			       struct ieee80211_vif *vif, bool en)
> +int mt7615_mcu_set_bmc(struct mt7615_dev *dev,
> +		       struct ieee80211_vif *vif, bool en)
>  {
>  	struct mt7615_vif *mvif =3D (struct mt7615_vif *)vif->drv_priv;
>  	struct {
>  		struct sta_req_hdr hdr;
>  		struct sta_rec_basic basic;
> -	} req =3D {
> +		u8 buf[MT7615_WTBL_UPDATE_MAX_SIZE];
> +	} __packed req =3D {
>  		.hdr =3D {
>  			.bss_idx =3D mvif->idx,
>  			.wlan_idx =3D mvif->sta.wcid.idx,
> @@ -1109,8 +1059,18 @@ int mt7615_mcu_set_sta_rec_bmc(struct mt7615_dev *=
dev,
>  			.conn_type =3D cpu_to_le32(CONNECTION_INFRA_BC),
>  		},
>  	};
> +	struct wtbl_req_hdr *wtbl_hdr;
> +	struct wtbl_generic *wtbl_g;
> +	struct wtbl_rx *wtbl_rx;
> +	u8 *buf =3D req.buf;
> +
>  	eth_broadcast_addr(req.basic.peer_addr);
> =20
> +	wtbl_hdr =3D (struct wtbl_req_hdr *)buf;
> +	buf +=3D sizeof(*wtbl_hdr);
> +	wtbl_hdr->wlan_idx =3D mvif->sta.wcid.idx;
> +	wtbl_hdr->operation =3D WTBL_RESET_AND_SET;
> +
>  	if (en) {
>  		req.basic.conn_state =3D CONN_STATE_PORT_SECURE;
>  		req.basic.extra_info =3D cpu_to_le16(EXTRA_INFO_VER |
> @@ -1118,10 +1078,37 @@ int mt7615_mcu_set_sta_rec_bmc(struct mt7615_dev =
*dev,
>  	} else {
>  		req.basic.conn_state =3D CONN_STATE_DISCONNECT;
>  		req.basic.extra_info =3D cpu_to_le16(EXTRA_INFO_VER);
> +
> +		__mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_STA_REC_UPDATE,
> +				    &req, (u8 *)wtbl_hdr - (u8 *)&req, true);

we need to check the return value from __mt76_mcu_send_msg here.
Moreover, here (u8 *)wtbl_hdr - (u8 *)&req is
sizeof(struct sta_req_hdr) + sizeof(struct sta_rec_basic), right?
I guess it would be easier to understand if we explicit the length, what do=
 you think?

> +
> +		return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_WTBL_UPDATE,
> +					   (u8 *)wtbl_hdr, buf - (u8 *)wtbl_hdr,
> +					   true);
>  	}
> =20
> +	wtbl_g =3D (struct wtbl_generic *)buf;
> +	buf +=3D sizeof(*wtbl_g);
> +	wtbl_g->tag =3D cpu_to_le16(WTBL_GENERIC);
> +	wtbl_g->len =3D cpu_to_le16(sizeof(*wtbl_g));
> +	wtbl_g->muar_idx =3D 0xe;
> +	eth_broadcast_addr(wtbl_g->peer_addr);
> +
> +	wtbl_rx =3D (struct wtbl_rx *)buf;
> +	buf +=3D sizeof(*wtbl_rx);
> +	wtbl_rx->tag =3D cpu_to_le16(WTBL_RX);
> +	wtbl_rx->len =3D cpu_to_le16(sizeof(*wtbl_rx));
> +	wtbl_rx->rv =3D 1;
> +	wtbl_rx->rca1 =3D 1;
> +	wtbl_rx->rca2 =3D 1;
> +
> +	wtbl_hdr->tlv_num =3D cpu_to_le16(2);
> +
> +	__mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_WTBL_UPDATE,
> +			    (u8 *)wtbl_hdr, buf - (u8 *)wtbl_hdr, true);

we need to check the return value from __mt76_mcu_send_msg here
> +
>  	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_STA_REC_UPDATE,
> -				   &req, sizeof(req), true);
> +				   &req, (u8 *)wtbl_hdr - (u8 *)&req, true);

same here about the length.

Regards,
Lorenzo

>  }
> =20
>  int mt7615_mcu_set_sta_rec(struct mt7615_dev *dev, struct ieee80211_vif =
*vif,
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers=
/net/wireless/mediatek/mt76/mt7615/mt7615.h
> index eaafae9cc279..84949256601f 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
> @@ -241,14 +241,12 @@ int mt7615_mcu_set_bss_info(struct mt7615_dev *dev,=
 struct ieee80211_vif *vif,
>  void mt7615_mac_set_rates(struct mt7615_phy *phy, struct mt7615_sta *sta,
>  			  struct ieee80211_tx_rate *probe_rate,
>  			  struct ieee80211_tx_rate *rates);
> -int mt7615_mcu_wtbl_bmc(struct mt7615_dev *dev, struct ieee80211_vif *vi=
f,
> -			bool enable);
>  int mt7615_mcu_add_wtbl(struct mt7615_dev *dev, struct ieee80211_vif *vi=
f,
>  			struct ieee80211_sta *sta);
>  int mt7615_mcu_del_wtbl(struct mt7615_dev *dev, struct ieee80211_sta *st=
a);
>  int mt7615_mcu_del_wtbl_all(struct mt7615_dev *dev);
> -int mt7615_mcu_set_sta_rec_bmc(struct mt7615_dev *dev,
> -			       struct ieee80211_vif *vif, bool en);
> +int mt7615_mcu_set_bmc(struct mt7615_dev *dev, struct ieee80211_vif *vif,
> +		       bool en);
>  int mt7615_mcu_set_sta_rec(struct mt7615_dev *dev, struct ieee80211_vif =
*vif,
>  			   struct ieee80211_sta *sta, bool en);
>  int mt7615_mcu_set_bcn(struct ieee80211_hw *hw, struct ieee80211_vif *vi=
f,
> --=20
> 2.18.0

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXicUhwAKCRA6cBh0uS2t
rE0TAP99qoAH5LfpJ/A9pFDbcKQem+kh5Ku+cIQ/ULjuso4SMQD+NpQ7PXYVwOYl
zinnZjga5RmI9cLdqjMoms+G4H6cZAQ=
=4+yn
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
