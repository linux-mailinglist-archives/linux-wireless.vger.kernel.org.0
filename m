Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9707208AE
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jun 2023 19:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235496AbjFBR5c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Jun 2023 13:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbjFBR5b (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Jun 2023 13:57:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948719F
        for <linux-wireless@vger.kernel.org>; Fri,  2 Jun 2023 10:57:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29A2062B97
        for <linux-wireless@vger.kernel.org>; Fri,  2 Jun 2023 17:57:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE93C4339B;
        Fri,  2 Jun 2023 17:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685728649;
        bh=mvN5M0iGqD7SXXGwWWLrqk3W79voWGsffhlUFGaufC4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=onYFmJogHGFmh+csAtb2E17lDMAY74JSS8/d7doKguBUbNsCFdoPwe/mPD4F+0MRt
         66o0yNKzN6cu4dwcGdjXrV8hc8CfTF1XLQMjz2qsjBivKMEA8tu4C/0RFZEBD79p5O
         8m2ujeCGUjNTVzfYZeL11cZA1C//j+iQ0ab3Wn15kvQwq4D2KmpTPAm5yAv/cbpEbg
         2sAn1bMTLGTptuAKzT/nctNKA4okVJXRe0yhtQsF1F4fj96IV9VhyOYPoz+Fxa4VLm
         rTbgT/6jqR+vIjwEj2EPn7e7RXEPz+MIXSrnyzPX9htMf+tHDskKP8dVw37iNnHMzX
         dmLqLHNjGxTAw==
Date:   Fri, 2 Jun 2023 19:57:25 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Shayne Chen <shayne.chen@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Peter Chiu <chui-hao.chiu@mediatek.com>
Subject: Re: [PATCH 07/12] wifi: mt76: connac: add a new bss_info tag for
 setting ifs time
Message-ID: <ZHothb9YzTAUcKz+@lore-desk>
References: <20230602152108.26860-1-shayne.chen@mediatek.com>
 <20230602152108.26860-7-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YvpdQ4zsZ5JQlJO5"
Content-Disposition: inline
In-Reply-To: <20230602152108.26860-7-shayne.chen@mediatek.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--YvpdQ4zsZ5JQlJO5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Peter Chiu <chui-hao.chiu@mediatek.com>
>=20
> Add a new bss_info tag id UNI_BSS_INFO_IFS_TIME. This is used for
> setting IFS time by mcu command.
>=20
> Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drive=
rs/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> index 4a21c237ea6e..3790d68525e5 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> @@ -1288,6 +1288,7 @@ enum {
>  	UNI_BSS_INFO_UAPSD =3D 19,
>  	UNI_BSS_INFO_PS =3D 21,
>  	UNI_BSS_INFO_BCNFT =3D 22,
> +	UNI_BSS_INFO_IFS_TIME =3D 23,
>  	UNI_BSS_INFO_OFFLOAD =3D 25,
>  	UNI_BSS_INFO_MLD =3D 26,

same here, this patch can be merged with 8/12.

Regards,
Lorenzo

>  };
> --=20
> 2.39.2
>=20

--YvpdQ4zsZ5JQlJO5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZHothQAKCRA6cBh0uS2t
rDtPAP4ouJrh0cFPM8L52UtVpfHvIYXcF8lsYmeK1VuCj4u2ewEA2GKHK9VLMJC1
p56s+EnJXrXSLbNf7gln3UBxRjT9Aw4=
=mAYh
-----END PGP SIGNATURE-----

--YvpdQ4zsZ5JQlJO5--
