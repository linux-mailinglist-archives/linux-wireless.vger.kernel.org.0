Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38EEC596A30
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Aug 2022 09:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbiHQHPw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Aug 2022 03:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiHQHPv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Aug 2022 03:15:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41996B167
        for <linux-wireless@vger.kernel.org>; Wed, 17 Aug 2022 00:15:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97032B81C12
        for <linux-wireless@vger.kernel.org>; Wed, 17 Aug 2022 07:15:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC20C433D6;
        Wed, 17 Aug 2022 07:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660720547;
        bh=kUeje6ndYuhgNs+8vKzDETDexRxUhCASk08Esoi4VMI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JwJ1SttOrG6Po9bSrHRJyco9EpwyNPHNqNi0mqdPeuzZEvtbRTLvT6z212U9UVCZR
         VewhNsfsdVIbwQN5SlOInWhXiH+pF5CRkzRvtZc9pD3VSqyED1QcXkhnPA8cYNpCBC
         /K5PQI6kniQQhP3xTuisFCualKACvIYecGjf9QB+jflOdH0St0MWZEwNZ6xuCFK9jj
         G6oUlLowOS2QXYtwSqltaLjAoqe/JVcNoKct5gLbw+xFA52kqNjtlHfpe6mLyVC8RJ
         bc+38+NLQCPpqdME2tvtHwSNlOhSSYV/rgCLrymtpZu8qrJpdt9FNSvOMBAKjS9pB/
         t9JN48X6AiUKw==
Date:   Wed, 17 Aug 2022 09:15:43 +0200
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
        linux-mediatek@lists.infradead.org,
        Quan Zhou <quan.zhou@mediatek.com>,
        Kaikai Hu <kaikai.hu@mediatek.com>
Subject: Re: [PATCH 5/9] wifi: mt76: mt7921: add unified ROC cmd/event support
Message-ID: <YvyVn439t0z/Yzfy@lore-desk>
References: <cover.1660606893.git.objelf@gmail.com>
 <31abc0972859270b619b098bdcd02d4b8d5fdaa0.1660606893.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uK4OiO01CDmCqjHs"
Content-Disposition: inline
In-Reply-To: <31abc0972859270b619b098bdcd02d4b8d5fdaa0.1660606893.git.objelf@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--uK4OiO01CDmCqjHs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug 16, Sean Wang wrote:
> From: Quan Zhou <quan.zhou@mediatek.com>
>=20
> Add unified ROC cmd/event which is only supported by the newer fw.
>=20
> Co-developed-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Co-developed-by: Deren Wu <deren.wu@mediatek.com>
> Signed-off-by: Deren Wu <deren.wu@mediatek.com>
> Co-developed-by: Kaikai Hu <kaikai.hu@mediatek.com>
> Signed-off-by: Kaikai Hu <kaikai.hu@mediatek.com>
> Signed-off-by: Quan Zhou <quan.zhou@mediatek.com>
> ---
>  .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  10 +-
>  .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 119 ++++++++++++++++++
>  .../wireless/mediatek/mt76/mt7921/mt7921.h    |  19 +++
>  3 files changed, 147 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drive=
rs/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> index 1fcc3e8c5380..f3c1e1dc574a 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> @@ -114,11 +114,15 @@ struct mt76_connac2_mcu_rxd {
> =20
>  	u8 eid;
>  	u8 seq;
> -	u8 rsv[2];
> +	u8 option;
> +	u8 __rsv;
> +

nit: remove new line here and use 'u8 rsv' to be consistent with the rest of
the code.

> =20
>  	u8 ext_eid;
>  	u8 rsv1[2];
>  	u8 s2d_index;
> +
> +	u8 tlv[0];
>  };
> =20
>  struct mt76_connac2_patch_hdr {
> @@ -938,6 +942,9 @@ enum {
>  	DEV_INFO_MAX_NUM
>  };
> =20
> +#define MCU_UNI_CMD_EVENT                       BIT(1)
> +#define MCU_UNI_CMD_UNSOLICITED_EVENT           BIT(2)
> +
>  /* event table */
>  enum {
>  	MCU_EVENT_TARGET_ADDRESS_LEN =3D 0x01,
> @@ -1144,6 +1151,7 @@ enum {
>  	MCU_UNI_CMD_OFFLOAD =3D 0x06,
>  	MCU_UNI_CMD_HIF_CTRL =3D 0x07,
>  	MCU_UNI_CMD_SNIFFER =3D 0x24,
> +	MCU_UNI_CMD_ROC =3D 0x27,
>  };
> =20
>  enum {
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/mcu.c
> index da12d0ae0835..76c8afc00c24 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> @@ -275,6 +275,23 @@ mt7921_mcu_rx_unsolicited_event(struct mt7921_dev *d=
ev, struct sk_buff *skb)
>  	dev_kfree_skb(skb);
>  }
> =20
> +static void
> +mt7921_mcu_uni_rx_unsolicited_event(struct mt7921_dev *dev,
> +				    struct sk_buff *skb)
> +{
> +	struct mt76_connac2_mcu_rxd *rxd;
> +
> +	rxd =3D (struct mt76_connac2_mcu_rxd *)skb->data;
> +
> +	switch (rxd->eid) {
> +	case MCU_UNI_EVENT_ROC:
> +		break;
> +	default:
> +		break;
> +	}
> +	dev_kfree_skb(skb);
> +}
> +
>  void mt7921_mcu_rx_event(struct mt7921_dev *dev, struct sk_buff *skb)
>  {
>  	struct mt76_connac2_mcu_rxd *rxd;
> @@ -284,6 +301,11 @@ void mt7921_mcu_rx_event(struct mt7921_dev *dev, str=
uct sk_buff *skb)
> =20
>  	rxd =3D (struct mt76_connac2_mcu_rxd *)skb->data;
> =20
> +	if (rxd->option & MCU_UNI_CMD_UNSOLICITED_EVENT) {
> +		mt7921_mcu_uni_rx_unsolicited_event(dev, skb);
> +		return;
> +	}
> +
>  	if (rxd->eid =3D=3D 0x6) {
>  		mt76_mcu_rx_event(&dev->mt76, skb);
>  		return;
> @@ -521,6 +543,103 @@ int mt7921_mcu_set_tx(struct mt7921_dev *dev, struc=
t ieee80211_vif *vif)
>  				 &req_mu, sizeof(req_mu), false);
>  }
> =20
> +int mt7921_mcu_set_roc(struct mt7921_phy *phy, struct mt7921_vif *vif,
> +		       struct ieee80211_channel *chan, int duration,
> +		       enum mt7921_roc_req type, u8 token_id)
> +{
> +	int center_ch =3D ieee80211_frequency_to_channel(chan->center_freq);
> +	struct mt7921_dev *dev =3D phy->dev;
> +	struct {
> +		struct {
> +			u8 rsv[4];
> +		} __packed hdr;
> +		struct roc_acquire_tlv {
> +			__le16 tag;
> +			__le16 len;
> +			u8 bss_idx;
> +			u8 tokenid;
> +			u8 control_channel;
> +			u8 sco;
> +			u8 band;
> +			u8 bw;
> +			u8 center_chan;
> +			u8 center_chan2;
> +			u8 bw_from_ap;
> +			u8 center_chan_from_ap;
> +			u8 center_chan2_from_ap;
> +			u8 reqtype;
> +			__le32 maxinterval;
> +			u8 dbdcband;
> +			u8 rsv[3];
> +		} __packed roc;
> +	} __packed req =3D {
> +		.roc =3D {
> +			.tag =3D cpu_to_le16(UNI_ROC_ACQUIRE),
> +			.len =3D cpu_to_le16(sizeof(struct roc_acquire_tlv)),
> +			.tokenid =3D token_id,
> +			.reqtype =3D type,
> +			.maxinterval =3D cpu_to_le32(duration),
> +			.bss_idx =3D vif->mt76.idx,
> +			.control_channel =3D chan->hw_value,
> +			.bw =3D CMD_CBW_20MHZ,
> +			.bw_from_ap =3D CMD_CBW_20MHZ,
> +			.center_chan =3D center_ch,
> +			.center_chan_from_ap =3D center_ch,
> +			.dbdcband =3D 0xff, /* auto */
> +		},
> +	};
> +
> +	if (chan->hw_value < center_ch)
> +		req.roc.sco =3D 1; /* SCA */
> +	else if (chan->hw_value > center_ch)
> +		req.roc.sco =3D 3; /* SCB */
> +
> +	switch (chan->band) {
> +	case NL80211_BAND_6GHZ:
> +		req.roc.band =3D 3;
> +		break;
> +	case NL80211_BAND_5GHZ:
> +		req.roc.band =3D 2;
> +		break;
> +	default:
> +		req.roc.band =3D 1;
> +		break;
> +	}
> +
> +	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(ROC),
> +				 &req, sizeof(req), false);
> +}
> +
> +int mt7921_mcu_abort_roc(struct mt7921_phy *phy, struct mt7921_vif *vif,
> +			 u8 token_id)
> +{
> +	struct mt7921_dev *dev =3D phy->dev;
> +	struct {
> +		struct {
> +			u8 rsv[4];
> +		} __packed hdr;
> +		struct roc_abort_tlv {
> +			__le16 tag;
> +			__le16 len;
> +			u8 bss_idx;
> +			u8 tokenid;
> +			u8 dbdcband;
> +			u8 rsv[5];
> +		} __packed abort;
> +	} __packed req =3D {
> +		.abort =3D {
> +			.tag =3D cpu_to_le16(UNI_ROC_ABORT),
> +			.len =3D cpu_to_le16(sizeof(struct roc_abort_tlv)),
> +			.tokenid =3D token_id,
> +			.bss_idx =3D vif->mt76.idx,
> +			.dbdcband =3D 0xff, /* auto*/
> +		},
> +	};
> +
> +	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(ROC),
> +				 &req, sizeof(req), false);
> +}
> +
>  int mt7921_mcu_set_chan_info(struct mt7921_phy *phy, int cmd)
>  {
>  	struct mt7921_dev *dev =3D phy->dev;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers=
/net/wireless/mediatek/mt76/mt7921/mt7921.h
> index c161031ac62a..c9044d546e94 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> @@ -51,6 +51,20 @@
>  #define MT7921_SDIO_HDR_TX_BYTES	GENMASK(15, 0)
>  #define MT7921_SDIO_HDR_PKT_TYPE	GENMASK(17, 16)
> =20
> +#define MCU_UNI_EVENT_ROC  0x27
> +
> +enum {
> +	UNI_ROC_ACQUIRE,
> +	UNI_ROC_ABORT,
> +	UNI_ROC_NUM
> +};
> +
> +enum mt7921_roc_req {
> +	MT7921_ROC_REQ_JOIN,
> +	MT7921_ROC_REQ_ROC,
> +	MT7921_ROC_REQ_NUM
> +};
> +
>  enum mt7921_sdio_pkt_type {
>  	MT7921_SDIO_TXD,
>  	MT7921_SDIO_DATA,
> @@ -479,4 +493,9 @@ mt7921_init_acpi_sar_power(struct mt7921_phy *phy, bo=
ol set_default)
>  #endif
>  int mt7921_set_tx_sar_pwr(struct ieee80211_hw *hw,
>  			  const struct cfg80211_sar_specs *sar);
> +int mt7921_mcu_set_roc(struct mt7921_phy *phy, struct mt7921_vif *vif,
> +		       struct ieee80211_channel *chan, int duration,
> +		       enum mt7921_roc_req type, u8 token_id);
> +int mt7921_mcu_abort_roc(struct mt7921_phy *phy, struct mt7921_vif *vif,
> +			 u8 token_id);
>  #endif
> --=20
> 2.25.1
>=20

--uK4OiO01CDmCqjHs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYvyVnwAKCRA6cBh0uS2t
rCuhAP9MsTzYfGjqlqavFbHGgjzm+qAo9Z4UpzALA1DaHl6HuQD/aDJvSv4gVNE1
ELcID2s3yX6DxjNXb3ekzu5Ivn/L/QM=
=eDiS
-----END PGP SIGNATURE-----

--uK4OiO01CDmCqjHs--
