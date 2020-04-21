Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F351B2614
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2020 14:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbgDUMbl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Apr 2020 08:31:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:39550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728316AbgDUMbk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Apr 2020 08:31:40 -0400
Received: from lore-desk-wlan (unknown [151.48.159.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09D8820781;
        Tue, 21 Apr 2020 12:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587472299;
        bh=1O91xaMMmCfaSelZKpJbO6FZwLCqbwoOAF2KFReCh5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VKbRoNhr24B6I1QJ+cUC2LcoVdQYDYqCQpwSIlis2KTa0kBMpAiCx3QncK/F4EDB7
         e6CRqg2JnGFjEzUcRZzf6QsCfttElHrQmfj+pfPMjdKKp5HxKd2pkFD9dqQrAXxFCr
         jijBsZKbVgP+ciBnZQClhB9/IS+fSRTejE6qnZ6o=
Date:   Tue, 21 Apr 2020 14:31:33 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com, ryder.lee@mediatek.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/3] mt76: mt7615: Fix up WMM setting for STA mode
Message-ID: <20200421123133.GA44668@lore-desk-wlan>
References: <1467d47fd111b5711fa74410833153bdc9e01b72.1587445885.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
In-Reply-To: <1467d47fd111b5711fa74410833153bdc9e01b72.1587445885.git.sean.wang@mediatek.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> Have to perform WMM setup until BSS become active according to firmware
> usage. Otherwise, the current usage would break WMM setting in STA mode.
>=20
> Fixes: 04b8e65922f6 ("mt76: add mac80211 driver for MT7615 PCIe-based chi=
psets")
> Suggested-by: YF Luo <Yf.Luo@mediatek.com>
> Suggested-by: Soul Huang <Soul.Huang@mediatek.com>
> Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  .../net/wireless/mediatek/mt76/mt7615/main.c  | 11 ++++++-
>  .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 32 ++++++++++++-------
>  .../wireless/mediatek/mt76/mt7615/mt7615.h    | 10 ++++--
>  3 files changed, 38 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7615/main.c
> index 417903a8e2ec..cdc8babca85a 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
> @@ -424,7 +424,13 @@ mt7615_conf_tx(struct ieee80211_hw *hw, struct ieee8=
0211_vif *vif, u16 queue,
> =20
>  	queue +=3D mvif->wmm_idx * MT7615_MAX_WMM_SETS;
> =20
> -	return mt7615_mcu_set_wmm(dev, queue, params);
> +	/* Have to set wmm up until BSS become active */
> +	mvif->wmm[queue].cw_min =3D params->cw_min;
> +	mvif->wmm[queue].cw_max =3D params->cw_max;
> +	mvif->wmm[queue].aifs =3D params->aifs;
> +	mvif->wmm[queue].txop =3D params->txop;

Hi Sean,

I think we can reuse ieee80211_tx_queue_params here since we are adding the
same fields.

> +
> +	return 0;
>  }
> =20
>  static void mt7615_configure_filter(struct ieee80211_hw *hw,
> @@ -503,6 +509,9 @@ static void mt7615_bss_info_changed(struct ieee80211_=
hw *hw,
>  		}
>  	}
> =20
> +	if (changed & (BSS_CHANGED_QOS | BSS_CHANGED_BEACON_ENABLED))
> +		mt7615_mcu_set_wmm(dev, vif);
> +
>  	if (changed & BSS_CHANGED_BEACON_ENABLED) {
>  		mt7615_mcu_add_bss_info(phy, vif, info->enable_beacon);
>  		mt7615_mcu_sta_add(dev, vif, NULL, info->enable_beacon);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7615/mcu.c
> index 8b543e8dadb8..045bde7f554d 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> @@ -2269,8 +2269,7 @@ int mt7615_mcu_set_rts_thresh(struct mt7615_phy *ph=
y, u32 val)
>  				   &req, sizeof(req), true);
>  }
> =20
> -int mt7615_mcu_set_wmm(struct mt7615_dev *dev, u8 queue,
> -		       const struct ieee80211_tx_queue_params *params)
> +int mt7615_mcu_set_wmm(struct mt7615_dev *dev, struct ieee80211_vif *vif)

If we add someting like "mt7615_apply_wmm_parameters()" in main.c we can re=
use the
current code

>  {
>  #define WMM_AIFS_SET	BIT(0)
>  #define WMM_CW_MIN_SET	BIT(1)
> @@ -2289,21 +2288,30 @@ int mt7615_mcu_set_wmm(struct mt7615_dev *dev, u8=
 queue,
>  		__le16 txop;
>  	} __packed req =3D {
>  		.number =3D 1,
> -		.queue =3D queue,
>  		.valid =3D WMM_PARAM_SET,
> -		.aifs =3D params->aifs,
>  		.cw_min =3D 5,
>  		.cw_max =3D cpu_to_le16(10),
> -		.txop =3D cpu_to_le16(params->txop),
>  	};
> +	struct mt7615_vif *mvif =3D (struct mt7615_vif *)vif->drv_priv;
> +	int ac, err;
> =20
> -	if (params->cw_min)
> -		req.cw_min =3D fls(params->cw_min);
> -	if (params->cw_max)
> -		req.cw_max =3D cpu_to_le16(fls(params->cw_max));
> +	for (ac =3D 0; ac < IEEE80211_NUM_ACS; ac++) {
> +		req.queue =3D ac + mvif->wmm_idx * MT7615_MAX_WMM_SETS;
> +		req.aifs =3D mvif->wmm[ac].aifs;
> +		req.txop =3D cpu_to_le16(mvif->wmm[ac].txop);
> =20
> -	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_EDCA_UPDATE,
> -				   &req, sizeof(req), true);
> +		if (mvif->wmm[ac].cw_min)
> +			req.cw_min =3D fls(mvif->wmm[ac].cw_min);
> +		if (mvif->wmm[ac].cw_max)
> +			req.cw_max =3D cpu_to_le16(fls(mvif->wmm[ac].cw_max));
> +
> +		err =3D __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_EDCA_UPDATE,
> +					  &req, sizeof(req), true);
> +		if (err < 0)
> +			return err;
> +	}
> +
> +	return 0;
>  }
> =20
>  int mt7615_mcu_set_dbdc(struct mt7615_dev *dev)
> @@ -3353,7 +3361,7 @@ void mt7615_mcu_set_suspend_iter(void *priv, u8 *ma=
c,
>  	int i;
> =20
>  	mt7615_mcu_set_bss_pm(phy->dev, vif, suspend);
> -=09
> +
>  	mt7615_mcu_set_gtk_rekey(phy->dev, vif, suspend);

I have not sent this patch yet :)

> =20
>  	mt7615_mcu_set_suspend_mode(phy->dev, vif, suspend, 1, true);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers=
/net/wireless/mediatek/mt76/mt7615/mt7615.h
> index 3e84c2dc0f93..ad37463a02d6 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
> @@ -152,6 +152,13 @@ struct mt7615_vif {
>  	u8 scan_seq_num;
> =20
>  	struct mt7615_sta sta;
> +
> +	struct {
> +		u16 cw_min;
> +		u16 cw_max;
> +		u16 txop;
> +		u8 aifs;
> +	} wmm[IEEE80211_NUM_ACS];

something like ieee80211_tx_queue_params wmm[IEEE80211_NUM_ACS]

>  };
> =20
>  struct mib_stats {
> @@ -386,8 +393,7 @@ void mt7615_mac_set_rates(struct mt7615_phy *phy, str=
uct mt7615_sta *sta,
>  			  struct ieee80211_tx_rate *rates);
>  int mt7615_mcu_del_wtbl_all(struct mt7615_dev *dev);
>  int mt7615_mcu_set_chan_info(struct mt7615_phy *phy, int cmd);
> -int mt7615_mcu_set_wmm(struct mt7615_dev *dev, u8 queue,
> -		       const struct ieee80211_tx_queue_params *params);
> +int mt7615_mcu_set_wmm(struct mt7615_dev *dev, struct ieee80211_vif *vif=
);
>  void mt7615_mcu_rx_event(struct mt7615_dev *dev, struct sk_buff *skb);
>  int mt7615_mcu_rdd_cmd(struct mt7615_dev *dev,
>  		       enum mt7615_rdd_cmd cmd, u8 index,
> --=20
> 2.25.1

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXp7nowAKCRA6cBh0uS2t
rP2+AQCaZpgC+U7XDohX8cPfEmybEBA3dwQ/v5NlvSiWjniD1QEA0Kifl7+/efyG
JBv3P9s4VG/V1CSkQRSxjUgNVzRWdgk=
=pW8H
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
