Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBFA596A1F
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Aug 2022 09:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbiHQHNe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Aug 2022 03:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiHQHNd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Aug 2022 03:13:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274D013F4E
        for <linux-wireless@vger.kernel.org>; Wed, 17 Aug 2022 00:13:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7EF3611EB
        for <linux-wireless@vger.kernel.org>; Wed, 17 Aug 2022 07:13:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931BDC433D6;
        Wed, 17 Aug 2022 07:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660720411;
        bh=mhZyqtoYy74PdAAdFlxbk1IepIpS4DZICwM5GpUN0/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I3I/7/JloP1B15y/+FaDFfU6Jja6tqxGoxDwfOY+5aSVAjz8FkwxS2SV2KzzM5IPe
         qpIFimsXSb6vvQ5NJHeR+wSNgWi7tudIr1q4BdnFNs+qpO/XC1XRQp+Ux5QspIx+SA
         idEkSwemW3MeRqVaLDOxT07sqb4hj03seADYN5aVpFasSEzVpenB17oZ68mHqblZmE
         iVQ856AWmA5gbpN7Mu8PedOj1qVwDfcvoPn5x07p2blmimQ1VvANaWEVEv7/smDhJV
         MDvoP4nNPAqaBsg7sFqYDeETvaTUfr6CIoRBUqGMulsmvuLmwwNJc+xvBs1ldaa8rW
         AzWvQ3GZ3Cs0w==
Date:   Wed, 17 Aug 2022 09:13:27 +0200
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
Subject: Re: [PATCH 2/9] wifi: mt76: connac: add mt76_connac_mcu_uni_set_chctx
Message-ID: <YvyVF9DDOYr0XjP8@lore-desk>
References: <cover.1660606893.git.objelf@gmail.com>
 <57ebfc95640b3f062a1211bf939f9edfd9f58372.1660606893.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2GslY2MDrXwxf8RI"
Content-Disposition: inline
In-Reply-To: <57ebfc95640b3f062a1211bf939f9edfd9f58372.1660606893.git.objelf@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--2GslY2MDrXwxf8RI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug 16, Sean Wang wrote:
> From: Sean Wang <sean.wang@mediatek.com>
>=20
> add mt76_connac_mcu_uni_set_chctx to set up the channel context per BSS
> in the firmware
>=20
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 83 +++++++++++++++++++
>  .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  3 +
>  2 files changed, 86 insertions(+)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drive=
rs/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> index 0afcadce87fc..3d5c70765d4f 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> @@ -1311,6 +1311,89 @@ mt76_connac_mcu_uni_bss_he_tlv(struct mt76_phy *ph=
y, struct ieee80211_vif *vif,
>  	he->max_nss_mcs[CMD_HE_MCS_BW8080] =3D cap->he_mcs_nss_supp.tx_mcs_80p8=
0;
>  }
> =20
> +int mt76_connac_mcu_uni_set_chctx(struct mt76_phy *phy, struct mt76_vif =
*mvif,
> +				  struct ieee80211_chanctx_conf *ctx)
> +{
> +	struct cfg80211_chan_def *chandef =3D ctx ? &ctx->def : &phy->chandef;
> +	int freq1 =3D chandef->center_freq1, freq2 =3D chandef->center_freq2;
> +	enum nl80211_band band =3D chandef->chan->band;
> +	struct mt76_dev *mdev =3D phy->dev;
> +

nit: remove new-line here.

> +	struct {
> +		struct {
> +			u8 bss_idx;
> +			u8 pad[3];
> +		} __packed hdr;
> +		struct rlm_tlv {
> +			__le16 tag;
> +			__le16 len;
> +			u8 control_channel;
> +			u8 center_chan;
> +			u8 center_chan2;
> +			u8 bw;
> +			u8 tx_streams;
> +			u8 rx_streams;
> +			u8 short_st;
> +			u8 ht_op_info;
> +			u8 sco;
> +			u8 band;
> +			u8 pad[2];
> +		} __packed rlm;
> +	} __packed rlm_req =3D {
> +		.hdr =3D {
> +			.bss_idx =3D mvif->idx,
> +		},
> +		.rlm =3D {
> +			.tag =3D cpu_to_le16(UNI_BSS_INFO_RLM),
> +			.len =3D cpu_to_le16(sizeof(struct rlm_tlv)),
> +			.control_channel =3D chandef->chan->hw_value,
> +			.center_chan =3D ieee80211_frequency_to_channel(freq1),
> +			.center_chan2 =3D ieee80211_frequency_to_channel(freq2),
> +			.tx_streams =3D hweight8(phy->antenna_mask),
> +			.ht_op_info =3D 4, /* set HT 40M allowed */
> +			.rx_streams =3D phy->chainmask,
> +			.short_st =3D true,
> +			.band =3D band,
> +		},
> +	};
> +
> +	switch (chandef->width) {
> +	case NL80211_CHAN_WIDTH_40:
> +		rlm_req.rlm.bw =3D CMD_CBW_40MHZ;
> +		break;
> +	case NL80211_CHAN_WIDTH_80:
> +		rlm_req.rlm.bw =3D CMD_CBW_80MHZ;
> +		break;
> +	case NL80211_CHAN_WIDTH_80P80:
> +		rlm_req.rlm.bw =3D CMD_CBW_8080MHZ;
> +		break;
> +	case NL80211_CHAN_WIDTH_160:
> +		rlm_req.rlm.bw =3D CMD_CBW_160MHZ;
> +		break;
> +	case NL80211_CHAN_WIDTH_5:
> +		rlm_req.rlm.bw =3D CMD_CBW_5MHZ;
> +		break;
> +	case NL80211_CHAN_WIDTH_10:
> +		rlm_req.rlm.bw =3D CMD_CBW_10MHZ;
> +		break;
> +	case NL80211_CHAN_WIDTH_20_NOHT:
> +	case NL80211_CHAN_WIDTH_20:
> +	default:
> +		rlm_req.rlm.bw =3D CMD_CBW_20MHZ;
> +		rlm_req.rlm.ht_op_info =3D 0;
> +		break;
> +	}
> +
> +	if (rlm_req.rlm.control_channel < rlm_req.rlm.center_chan)
> +		rlm_req.rlm.sco =3D 1; /* SCA */
> +	else if (rlm_req.rlm.control_channel > rlm_req.rlm.center_chan)
> +		rlm_req.rlm.sco =3D 3; /* SCB */
> +
> +	return mt76_mcu_send_msg(mdev, MCU_UNI_CMD(BSS_INFO_UPDATE), &rlm_req,
> +				 sizeof(rlm_req), true);
> +}
> +EXPORT_SYMBOL_GPL(mt76_connac_mcu_uni_set_chctx);
> +
>  int mt76_connac_mcu_uni_add_bss(struct mt76_phy *phy,
>  				struct ieee80211_vif *vif,
>  				struct mt76_wcid *wcid,
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drive=
rs/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> index f1d7c05bd794..bf60b00d6020 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> @@ -1727,6 +1727,9 @@ int mt76_connac_mcu_uni_add_dev(struct mt76_phy *ph=
y,
>  int mt76_connac_mcu_sta_ba(struct mt76_dev *dev, struct mt76_vif *mvif,
>  			   struct ieee80211_ampdu_params *params,
>  			   int cmd, bool enable, bool tx);
> +int mt76_connac_mcu_uni_set_chctx(struct mt76_phy *phy,
> +				  struct mt76_vif *vif,
> +				  struct ieee80211_chanctx_conf *ctx);
>  int mt76_connac_mcu_uni_add_bss(struct mt76_phy *phy,
>  				struct ieee80211_vif *vif,
>  				struct mt76_wcid *wcid,
> --=20
> 2.25.1
>=20

--2GslY2MDrXwxf8RI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYvyVFwAKCRA6cBh0uS2t
rGNCAQCPxiW91wzRGGTLnFAJ8uf3uK/Mx/eVC3xm+4bPL/5tkQEApIxosB+EOd1k
dvoALnYkX32pP3p12wbsUZuFmPwYNAQ=
=T+/Z
-----END PGP SIGNATURE-----

--2GslY2MDrXwxf8RI--
