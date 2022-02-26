Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560754C54F0
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Feb 2022 10:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiBZJmD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 26 Feb 2022 04:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiBZJmC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 26 Feb 2022 04:42:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1D12AB0F2
        for <linux-wireless@vger.kernel.org>; Sat, 26 Feb 2022 01:41:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 947A860F84
        for <linux-wireless@vger.kernel.org>; Sat, 26 Feb 2022 09:41:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E476C340E8;
        Sat, 26 Feb 2022 09:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645868487;
        bh=tx4xIClhI9pVqQlAX4OiJzJbfs7O2RB96wmk5ufRnWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qWR3GkQJXt7d2NP5jHigBUeDt1dBI8/CrEK3KVNFuah8wMLhm9wXxwmRV9Uxwfsr0
         JdN1lslG3ACr3qQhNNSueJfDRdvGZ05qfX2bgLRbj7GoM3e5lOICpPQj2VxWgNNBCv
         9QMy+288ZXLabIv2Po63wr+DVEPP3avhDqweNDbVo0t54PrivEUjRtptSJ70HaYYNk
         8e+VAelSKbaWF42Xd2QpAHWMFK4sgawuN2Ah1DVA/3+CbsmxQf4S4cohPBjAnKdJJq
         4SlUAgJ1pyCiB1fLp8QjS0TVFZocqKHF1r/nu4ZJfEiMyvXBeHGwzqrXryothoxse3
         RChClzpynFAuw==
Date:   Sat, 26 Feb 2022 10:41:23 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com, Soul.Huang@mediatek.com,
        YN.Chen@mediatek.com, Leon.Yen@mediatek.com,
        Eric-SY.Chang@mediatek.com, Mark-YW.Chen@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        jenhao.yang@mediatek.com, robin.chiu@mediatek.com,
        Eddie.Chen@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, ted.huang@mediatek.com,
        Eric.Liang@mediatek.com, Stella.Chang@mediatek.com,
        Tom.Chou@mediatek.com, steve.lee@mediatek.com, jsiuda@google.com,
        frankgor@google.com, jemele@google.com, abhishekpandit@google.com,
        shawnku@google.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/2] mt76: mt7921: fix up the monitor mode
Message-ID: <Yhn1w5YF3d0NW7qE@lore-desk>
References: <c61deba952e23bcfa98e28778bc11af524ad2f1e.1645832790.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zyMKXVW4MtbXm0SY"
Content-Disposition: inline
In-Reply-To: <c61deba952e23bcfa98e28778bc11af524ad2f1e.1645832790.git.objelf@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--zyMKXVW4MtbXm0SY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> Properly set up the monitor mode the firmware can support to fix up
> RTS/CTS and beacon frames cannot be captured and forwarded to the host.
>=20
> Tested-by: Deren Wu <deren.wu@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
> v2: 1. add Tested-by tag
>     2. make mt76_connac_mcu_set_sniffer mt7921 specific
>     3. align the structure declartion
> ---
>  .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  1 +
>  .../net/wireless/mediatek/mt76/mt7921/main.c  | 23 +++++++-------
>  .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 30 +++++++++++++++++++
>  .../wireless/mediatek/mt76/mt7921/mt7921.h    |  2 ++
>  4 files changed, 46 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drive=
rs/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> index 384c3eab1c8a..e5857d2cf78c 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> @@ -993,6 +993,7 @@ enum {
>  	MCU_UNI_CMD_SUSPEND =3D 0x05,
>  	MCU_UNI_CMD_OFFLOAD =3D 0x06,
>  	MCU_UNI_CMD_HIF_CTRL =3D 0x07,
> +	MCU_UNI_CMD_SNIFFER =3D 0x24,
>  };
> =20
>  enum {
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/main.c
> index b6e836a4fad7..0f3c56530e66 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> @@ -479,6 +479,16 @@ mt7921_pm_interface_iter(void *priv, u8 *mac, struct=
 ieee80211_vif *vif)
>  	mt7921_mcu_set_beacon_filter(dev, vif, dev->pm.enable);
>  }
> =20
> +static void
> +mt7921_sniffer_interface_iter(void *priv, u8 *mac, struct ieee80211_vif =
*vif)
> +{
> +	struct mt7921_dev *dev =3D priv;
> +	struct ieee80211_hw *hw =3D mt76_hw(dev);
> +	bool enabled =3D !!(hw->conf.flags & IEEE80211_CONF_MONITOR);
> +
> +	mt7921_mcu_set_sniffer(dev, vif, enabled);
> +}
> +
>  void mt7921_set_runtime_pm(struct mt7921_dev *dev)
>  {
>  	struct ieee80211_hw *hw =3D dev->mphy.hw;
> @@ -516,16 +526,9 @@ static int mt7921_config(struct ieee80211_hw *hw, u3=
2 changed)
>  	}
> =20
>  	if (changed & IEEE80211_CONF_CHANGE_MONITOR) {
> -		bool enabled =3D !!(hw->conf.flags & IEEE80211_CONF_MONITOR);
> -
> -		if (!enabled)
> -			phy->rxfilter |=3D MT_WF_RFCR_DROP_OTHER_UC;
> -		else
> -			phy->rxfilter &=3D ~MT_WF_RFCR_DROP_OTHER_UC;

Hi Sean,

phy->rxfilter is used even in other codepath (e.g. mt7921_tm_set() or
mt7921_configure_filter()). I guess we should keep it updated here doing
something like:

		if (hw->conf.flags & IEEE80211_CONF_MONITOR)
			phy->rxfilter &=3D ~MT_WF_RFCR_DROP_OTHER_UC;
		else
			phy->rxfilter |=3D MT_WF_RFCR_DROP_OTHER_UC;

Agree?

Regards,
Lorenzo

> -
> -		mt76_rmw_field(dev, MT_DMA_DCR0(0), MT_DMA_DCR0_RXD_G5_EN,
> -			       enabled);
> -		mt76_wr(dev, MT_WF_RFCR(0), phy->rxfilter);
> +		ieee80211_iterate_active_interfaces(hw,
> +						    IEEE80211_IFACE_ITER_RESUME_ALL,
> +						    mt7921_sniffer_interface_iter, dev);
>  		mt7921_set_runtime_pm(dev);
>  	}
> =20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/mcu.c
> index 33a836825cca..ab790e5df863 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> @@ -1133,3 +1133,33 @@ int mt7921_get_txpwr_info(struct mt7921_dev *dev, =
struct mt7921_txpwr *txpwr)
> =20
>  	return 0;
>  }
> +
> +int mt7921_mcu_set_sniffer(struct mt7921_dev *dev, struct ieee80211_vif =
*vif,
> +			   bool enable)
> +{
> +	struct mt76_vif *mvif =3D (struct mt76_vif *)vif->drv_priv;
> +	struct {
> +		struct {
> +			u8 band_idx;
> +			u8 pad[3];
> +		} __packed hdr;
> +		struct sniffer_enable_tlv {
> +			__le16 tag;
> +			__le16 len;
> +			u8 enable;
> +			u8 pad[3];
> +		} __packed enable;
> +	} req =3D {
> +		.hdr =3D {
> +			.band_idx =3D mvif->band_idx,
> +		},
> +		.enable =3D {
> +			.tag =3D cpu_to_le16(0),
> +			.len =3D cpu_to_le16(sizeof(struct sniffer_enable_tlv)),
> +			.enable =3D enable,
> +		},
> +	};
> +
> +	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(SNIFFER), &req, sizeof=
(req),
> +				 true);
> +}
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers=
/net/wireless/mediatek/mt76/mt7921/mt7921.h
> index 9edc83f06139..9575d571b425 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> @@ -452,4 +452,6 @@ void mt7921s_tx_complete_skb(struct mt76_dev *mdev, s=
truct mt76_queue_entry *e);
>  bool mt7921s_tx_status_data(struct mt76_dev *mdev, u8 *update);
>  void mt7921_mac_add_txs(struct mt7921_dev *dev, void *data);
>  void mt7921_set_runtime_pm(struct mt7921_dev *dev);
> +int mt7921_mcu_set_sniffer(struct mt7921_dev *dev, struct ieee80211_vif =
*vif,
> +			   bool enable);
>  #endif
> --=20
> 2.25.1
>=20

--zyMKXVW4MtbXm0SY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYhn1wwAKCRA6cBh0uS2t
rCnAAP94z/LFOOeDRss4qYfAKouWAz6SFAyYxFNQsQDqOEeZgAEAiNelJUxCSyHA
oCAVQ+wAAMfURgFLecqubSC8UMw12AA=
=bT2S
-----END PGP SIGNATURE-----

--zyMKXVW4MtbXm0SY--
