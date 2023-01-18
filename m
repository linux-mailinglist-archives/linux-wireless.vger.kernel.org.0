Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7436722CF
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jan 2023 17:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjARQSu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Jan 2023 11:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjARQSP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Jan 2023 11:18:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD2813D5F
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 08:13:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64EECB81D8E
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 16:13:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3636C433D2;
        Wed, 18 Jan 2023 16:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674058413;
        bh=KzPKGXPnXYOt358vnWUhJJgGbXzewwE0wiwFyChRPAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pqlMuPUs1rSqgu9V7AoGGTaxHdzuQNDhYekVWF9R8U7qtKFMJ9BqCzqlBA4kmFw5T
         aAn2jfssrzYOZxt2fQO8H9gcZJIT6b03YcaTaMNgQFZe1wB+4vEW9CN0m3iqqGhVC7
         E2eARM0nFxAoaVtGIHQVE1tDGKotQWgYeS5O871R/JaAjs7yFm3WKyRoFHQBBWmy3u
         0X6V5FDvHLuoKvpAkyRrVFTYsPoNgsgg3vKztgxrmA9nrxVDnN1ZRYVG2P0gkZpSbb
         54qeDf/YpRlYN3HqPaQyrpEnpY3CA26GalJsFRhItkJpcJ2i2hAT+6MYl7UGLA64/f
         xdmREhRau8QWQ==
Date:   Wed, 18 Jan 2023 17:13:29 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Shayne Chen <shayne.chen@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 06/13] wifi: mt76: add EHT rate stats for ethtool
Message-ID: <Y8gaqTqI/un8dgZd@lore-desk>
References: <20230109165731.682-1-shayne.chen@mediatek.com>
 <20230109165731.682-7-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="17+pKBupczAMysgX"
Content-Disposition: inline
In-Reply-To: <20230109165731.682-7-shayne.chen@mediatek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--17+pKBupczAMysgX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Add support to get EHT rate stats from ethtool.
> This is the preliminary patch to add EHT support for mt7996.
>=20
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt76.h        | 2 +-
>  drivers/net/wireless/mediatek/mt76/mt7996/main.c | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wire=
less/mediatek/mt76/mt76.h
> index b3fd3abfdd9f..3d3c68b9e1cf 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> @@ -272,7 +272,7 @@ enum mt76_phy_type {
> =20
>  struct mt76_sta_stats {
>  	u64 tx_mode[__MT_PHY_TYPE_MAX];
> -	u64 tx_bw[4];		/* 20, 40, 80, 160 */
> +	u64 tx_bw[5];		/* 20, 40, 80, 160, 320 */

Hi Shayne,

I think this change will break mt7915 ethtool support. In particular it will
break tx_bw for loop in mt76_ethtool_worker().

Regards,
Lorenzo

>  	u64 tx_nss[4];		/* 1, 2, 3, 4 */
>  	u64 tx_mcs[16];		/* mcs idx */
>  	u64 tx_bytes;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7996/main.c
> index c423b052e4f4..9ea2e1198477 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> @@ -1084,10 +1084,14 @@ static const char mt7996_gstrings_stats[][ETH_GST=
RING_LEN] =3D {
>  	"v_tx_mode_he_ext_su",
>  	"v_tx_mode_he_tb",
>  	"v_tx_mode_he_mu",
> +	"v_tx_mode_eht_su",
> +	"v_tx_mode_eht_trig",
> +	"v_tx_mode_eht_mu",
>  	"v_tx_bw_20",
>  	"v_tx_bw_40",
>  	"v_tx_bw_80",
>  	"v_tx_bw_160",
> +	"v_tx_bw_320",
>  	"v_tx_mcs_0",
>  	"v_tx_mcs_1",
>  	"v_tx_mcs_2",
> @@ -1100,6 +1104,8 @@ static const char mt7996_gstrings_stats[][ETH_GSTRI=
NG_LEN] =3D {
>  	"v_tx_mcs_9",
>  	"v_tx_mcs_10",
>  	"v_tx_mcs_11",
> +	"v_tx_mcs_12",
> +	"v_tx_mcs_13",
>  };
> =20
>  #define MT7996_SSTATS_LEN ARRAY_SIZE(mt7996_gstrings_stats)
> --=20
> 2.25.1
>=20

--17+pKBupczAMysgX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY8gaqQAKCRA6cBh0uS2t
rCjbAP9gamsCGrHCI7lRONjPAy30luSazvHeHFDCzXXxtwIDygEA7kk0hRdlqvZe
feHpFAfzcmJZ+zzwlnA6XyJkvOhfAgo=
=bmhD
-----END PGP SIGNATURE-----

--17+pKBupczAMysgX--
