Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7C260C684
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Oct 2022 10:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiJYId2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Oct 2022 04:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiJYId1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Oct 2022 04:33:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2AFA3F55
        for <linux-wireless@vger.kernel.org>; Tue, 25 Oct 2022 01:33:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 518F5B81BB9
        for <linux-wireless@vger.kernel.org>; Tue, 25 Oct 2022 08:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F04AC433D6;
        Tue, 25 Oct 2022 08:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666686803;
        bh=LHTcKR+3y7J23LlcMdGj2MOCWs0GNbwZfPXXqFYul5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NRBP3BrCJBzDzeOemxKt4jNhjlepJrh8dMvAtR9NtFvZ9lUOR8BadeiSgqscZwAhz
         +v/9Go+dBSvpUVlL/Uz4d7VZvA6qcmPEX32M078AB/EK4cN5skOKPIskNGnhFnEyFr
         b7pkbAyCV8JsWlKwUX4vjNoI94fjAmaPgQeqrE9MM3A8Qs4G1oLJOhDCyydBxPFk2f
         s5MM+/Wqe02AUznZWi/fNxj0RnR8bdr+oZvTvvumHvXz9kqy7qQ4smZ9uJdo779CG+
         ekYyvz3EoiDEdC/ZXvCB5uGJtVYn27/cMb2I3PoZNe+ssoio7EiDfRqgroBl/Sb//p
         aPKEPp6QRknRg==
Date:   Tue, 25 Oct 2022 10:33:20 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Deren Wu <Deren.Wu@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Subject: Re: [PATCH v2] wifi: mt76: fix bandwidth 80MHz link fail in 6GHz band
Message-ID: <Y1efUIq4aCFO7V6j@lore-desk>
References: <85b5e8374fc9b86fb955060c1840f3b2a1d187e4.1666614616.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ILge1HdLp7MQdi0U"
Content-Disposition: inline
In-Reply-To: <85b5e8374fc9b86fb955060c1840f3b2a1d187e4.1666614616.git.deren.wu@mediatek.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--ILge1HdLp7MQdi0U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
>=20
> Due to information missing, the firmware may be fail on bandwidth
> related settings in mt7921/mt7922. Add new cmd STA_REC_HE_V2 to apply
> additional capabilities in 6GHz band.
>=20
> Tested-by: Ben Greear <greearb@candelatech.com>
> Co-developed-by: Deren Wu <deren.wu@mediatek.com>
> Signed-off-by: Deren Wu <deren.wu@mediatek.com>
> Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
> ---
> v2: Fix le16/cpu type problem, reported by kernel test robot <lkp@intel.c=
om>
> ---
>  .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 34 +++++++++++++++++++
>  .../wireless/mediatek/mt76/mt76_connac_mcu.h  | 11 ++++++
>  2 files changed, 45 insertions(+)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drive=
rs/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> index 011fc9729b38..9bba18d24c71 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> @@ -744,6 +744,39 @@ mt76_connac_mcu_sta_he_tlv(struct sk_buff *skb, stru=
ct ieee80211_sta *sta)
>  	he->pkt_ext =3D 2;
>  }
> =20
> +static void
> +mt76_connac_mcu_sta_he_tlv_v2(struct sk_buff *skb, struct ieee80211_sta =
*sta)

Is this tlv available just for 7921 fw? If so I guess we should add it just=
 for
it since mt76_connac_mcu_sta_tlv is used even by other chipsets.

Regards,
Lorenzo

> +{
> +	struct ieee80211_sta_he_cap *he_cap =3D &sta->deflink.he_cap;
> +	struct ieee80211_he_cap_elem *elem =3D &he_cap->he_cap_elem;
> +	struct sta_rec_he_v2 *he;
> +	struct tlv *tlv;
> +
> +	tlv =3D mt76_connac_mcu_add_tlv(skb, STA_REC_HE_V2, sizeof(*he));
> +
> +	he =3D (struct sta_rec_he_v2 *)tlv;
> +	memcpy(he->he_phy_cap, elem->phy_cap_info, sizeof(he->he_phy_cap));
> +	memcpy(he->he_mac_cap, elem->mac_cap_info, sizeof(he->he_mac_cap));
> +
> +	switch (sta->deflink.bandwidth) {
> +	case IEEE80211_STA_RX_BW_160:
> +		if (elem->phy_cap_info[0] &
> +		    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)
> +			he->max_nss_mcs[CMD_HE_MCS_BW8080] =3D
> +				he_cap->he_mcs_nss_supp.rx_mcs_80p80;
> +
> +		he->max_nss_mcs[CMD_HE_MCS_BW160] =3D
> +				he_cap->he_mcs_nss_supp.rx_mcs_160;
> +		fallthrough;
> +	default:
> +		he->max_nss_mcs[CMD_HE_MCS_BW80] =3D
> +				he_cap->he_mcs_nss_supp.rx_mcs_80;
> +		break;
> +	}
> +
> +	he->pkt_ext =3D IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_16US;
> +}
> +
>  static u8
>  mt76_connac_get_phy_mode_v2(struct mt76_phy *mphy, struct ieee80211_vif =
*vif,
>  			    enum nl80211_band band, struct ieee80211_sta *sta)
> @@ -838,6 +871,7 @@ void mt76_connac_mcu_sta_tlv(struct mt76_phy *mphy, s=
truct sk_buff *skb,
>  	/* starec he */
>  	if (sta->deflink.he_cap.has_he) {
>  		mt76_connac_mcu_sta_he_tlv(skb, sta);
> +		mt76_connac_mcu_sta_he_tlv_v2(skb, sta);
>  		if (band =3D=3D NL80211_BAND_6GHZ &&
>  		    sta_state =3D=3D MT76_STA_INFO_STATE_ASSOC) {
>  			struct sta_rec_he_6g_capa *he_6g_capa;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drive=
rs/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> index cf4ce3b1fc21..8166722d4717 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> @@ -354,6 +354,16 @@ struct sta_rec_he {
>  	u8 rsv2[2];
>  } __packed;
> =20
> +struct sta_rec_he_v2 {
> +	__le16 tag;
> +	__le16 len;
> +	u8 he_mac_cap[6];
> +	u8 he_phy_cap[11];
> +	u8 pkt_ext;
> +	/* 0: BW80, 1: BW160, 2: BW8080 */
> +	__le16 max_nss_mcs[CMD_HE_MCS_BW_NUM];
> +} __packed;
> +
>  struct sta_rec_amsdu {
>  	__le16 tag;
>  	__le16 len;
> @@ -779,6 +789,7 @@ enum {
>  	STA_REC_BFEE,
>  	STA_REC_PHY =3D 0x15,
>  	STA_REC_HE_6G =3D 0x17,
> +	STA_REC_HE_V2 =3D 0x19,
>  	STA_REC_MAX_NUM
>  };
> =20
> --=20
> 2.18.0
>=20

--ILge1HdLp7MQdi0U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY1efUAAKCRA6cBh0uS2t
rOslAQCNdQalNGDSeN/+grsejdDXEvlgFFNWzz6kBr5VimAg1QEA3DiqC34X+SKl
GEY2aYwWYGpXQmHGq8WNFn9v3xcT6A8=
=h88U
-----END PGP SIGNATURE-----

--ILge1HdLp7MQdi0U--
