Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0569C6F2470
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Apr 2023 13:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjD2LYQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 29 Apr 2023 07:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjD2LYP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 29 Apr 2023 07:24:15 -0400
X-Greylist: delayed 345 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 29 Apr 2023 04:24:13 PDT
Received: from vulcan.natalenko.name (vulcan.natalenko.name [104.207.131.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71791FD3
        for <linux-wireless@vger.kernel.org>; Sat, 29 Apr 2023 04:24:13 -0700 (PDT)
Received: from spock.localnet (unknown [83.148.33.151])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 8ED0512E6B67;
        Sat, 29 Apr 2023 13:18:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1682767101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZE0h0DcEAJL5LiOpSMfb1J7VmBH1Sr5fwQ0949oyNo0=;
        b=VMb1I8bNBOzACCD3JTYnUFS0mAJJTsOmmqHEoSH9J3EKqfrEgXhI8B8tbh1vHEyMR52tES
        JEXwDm3E8HmWC7ZrU0ssoI74IiqyCmFdji2iNMV1JBIkAVCNrgNTnY2vOpw/3v10gHQAkm
        AxLKxWPDWnK8rIXfuaeTk/NYZQTTUT8=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Felix Fietkau <nbd@nbd.name>,
        MeiChia Chiu <MeiChia.Chiu@mediatek.com>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        MeiChia Chiu <MeiChia.Chiu@mediatek.com>,
        Money Wang <Money.Wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>
Subject: Re: [PATCH v2] wifi: mt76: mt7915: remove BW160 and BW80+80 support
Date:   Sat, 29 Apr 2023 13:18:19 +0200
Message-ID: <2313900.mqelP9QxOF@natalenko.name>
In-Reply-To: <20230104090352.31938-1-MeiChia.Chiu@mediatek.com>
References: <20230104090352.31938-1-MeiChia.Chiu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello.

On st=C5=99eda 4. ledna 2023 10:03:52 CEST MeiChia Chiu wrote:
> Remove BW160 and BW80+80 capability in mt7915.
>=20
> Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabor=
a.com>
> Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
> Reviewed-by: Shayne Chen <shayne.chen@mediatek.com>
> Signed-off-by: Money Wang<Money.Wang@mediatek.com>
> Signed-off-by: MeiChia Chiu <MeiChia.Chiu@mediatek.com>
> ---
> v2: update commit message and title
> ---
>  .../net/wireless/mediatek/mt76/mt7915/init.c  | 38 +++++--------------
>  1 file changed, 9 insertions(+), 29 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/n=
et/wireless/mediatek/mt76/mt7915/init.c
> index 571c94835942..c72d673f02dd 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> @@ -38,8 +38,7 @@ static const struct ieee80211_iface_combination if_comb=
[] =3D {
>  				       BIT(NL80211_CHAN_WIDTH_20) |
>  				       BIT(NL80211_CHAN_WIDTH_40) |
>  				       BIT(NL80211_CHAN_WIDTH_80) |
> -				       BIT(NL80211_CHAN_WIDTH_160) |
> -				       BIT(NL80211_CHAN_WIDTH_80P80),
> +				       BIT(NL80211_CHAN_WIDTH_160),
>  	}
>  };
> =20
> @@ -394,11 +393,6 @@ mt7915_init_wiphy(struct mt7915_phy *phy)
>  			phy->mt76->sband_5g.sband.vht_cap.cap |=3D
>  				IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_7991 |
>  				IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK;
> -
> -			if (!dev->dbdc_support)
> -				phy->mt76->sband_5g.sband.vht_cap.cap |=3D
> -					IEEE80211_VHT_CAP_SHORT_GI_160 |
> -					IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ;
>  		} else {
>  			phy->mt76->sband_5g.sband.vht_cap.cap |=3D
>  				IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454 |
> @@ -834,13 +828,9 @@ mt7915_set_stream_he_txbf_caps(struct mt7915_phy *ph=
y,
>  	int sts =3D hweight8(phy->mt76->chainmask);
>  	u8 c, sts_160 =3D sts;
> =20
> -	/* Can do 1/2 of STS in 160Mhz mode for mt7915 */
> -	if (is_mt7915(&dev->mt76)) {
> -		if (!dev->dbdc_support)
> -			sts_160 /=3D 2;
> -		else
> -			sts_160 =3D 0;
> -	}
> +	/* mt7915 doesn't support bw160 */
> +	if (is_mt7915(&dev->mt76))
> +		sts_160 =3D 0;
> =20
>  #ifdef CONFIG_MAC80211_MESH
>  	if (vif =3D=3D NL80211_IFTYPE_MESH_POINT)
> @@ -894,9 +884,6 @@ mt7915_set_stream_he_txbf_caps(struct mt7915_phy *phy,
>  	elem->phy_cap_info[3] |=3D IEEE80211_HE_PHY_CAP3_SU_BEAMFORMER;
>  	elem->phy_cap_info[4] |=3D IEEE80211_HE_PHY_CAP4_MU_BEAMFORMER;
> =20
> -	/* num_snd_dim
> -	 * for mt7915, max supported sts is 2 for bw > 80MHz and 0 if dbdc
> -	 */
>  	c =3D FIELD_PREP(IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_UNDER_80M=
HZ_MASK,
>  		       sts - 1);
>  	if (sts_160)
> @@ -944,15 +931,10 @@ mt7915_init_he_caps(struct mt7915_phy *phy, enum nl=
80211_band band,
>  	int i, idx =3D 0, nss =3D hweight8(phy->mt76->antenna_mask);
>  	u16 mcs_map =3D 0;
>  	u16 mcs_map_160 =3D 0;
> -	u8 nss_160;
> +	u8 nss_160 =3D nss;
> =20
> -	if (!is_mt7915(&dev->mt76))
> -		nss_160 =3D nss;
> -	else if (!dev->dbdc_support)
> -		/* Can do 1/2 of NSS streams in 160Mhz mode for mt7915 */
> -		nss_160 =3D nss / 2;
> -	else
> -		/* Can't do 160MHz with mt7915 dbdc */
> +	/* Can't do 160MHz with mt7915 */
> +	if (is_mt7915(&dev->mt76))
>  		nss_160 =3D 0;
> =20
>  	for (i =3D 0; i < 8; i++) {
> @@ -1002,8 +984,7 @@ mt7915_init_he_caps(struct mt7915_phy *phy, enum nl8=
0211_band band,
>  		else if (nss_160)
>  			he_cap_elem->phy_cap_info[0] =3D
>  				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
> -				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G |
> -				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G;
> +				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
>  		else
>  			he_cap_elem->phy_cap_info[0] =3D
>  				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G;
> @@ -1075,12 +1056,11 @@ mt7915_init_he_caps(struct mt7915_phy *phy, enum =
nl80211_band band,
>  			break;
>  		}
> =20
> +		memset(he_mcs, 0, sizeof(*he_mcs));
>  		he_mcs->rx_mcs_80 =3D cpu_to_le16(mcs_map);
>  		he_mcs->tx_mcs_80 =3D cpu_to_le16(mcs_map);
>  		he_mcs->rx_mcs_160 =3D cpu_to_le16(mcs_map_160);
>  		he_mcs->tx_mcs_160 =3D cpu_to_le16(mcs_map_160);
> -		he_mcs->rx_mcs_80p80 =3D cpu_to_le16(mcs_map_160);
> -		he_mcs->tx_mcs_80p80 =3D cpu_to_le16(mcs_map_160);
> =20
>  		mt7915_set_stream_he_txbf_caps(phy, he_cap, i);

I was negatively surprised by this as I had `VHT160-80PLUS80` in my hostapd=
 config file, and the AP worked just fine, and stopped working after upgrad=
ing the machine to v6.3.

I do understand that the chip doesn't support 80+80, and my AP just works i=
n VHT160 mode, so replacing `VHT160-80PLUS80` with `VHT160` in the config f=
ixed the issue for me. Thanks for bringing BW160 back later in c2f73eacee3b.

But I do want to point out that the commit message should explain the reaso=
n for removal. Also, I'm one of those users of:

```
01:00.0 Unclassified device [0002]: MEDIATEK Corp. MT7915E 802.11ax PCI Exp=
ress Wireless Network Adapter
```

for whom BW160 works just fine.

Thanks.

=2D-=20
Oleksandr Natalenko (post-factum)


