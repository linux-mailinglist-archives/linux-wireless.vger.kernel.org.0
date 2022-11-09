Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC83622B72
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Nov 2022 13:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiKIMXW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Nov 2022 07:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiKIMXV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Nov 2022 07:23:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610E2250
        for <linux-wireless@vger.kernel.org>; Wed,  9 Nov 2022 04:23:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24579B81E21
        for <linux-wireless@vger.kernel.org>; Wed,  9 Nov 2022 12:23:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC4EC433C1;
        Wed,  9 Nov 2022 12:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667996597;
        bh=kqYezkJ/OwLF81BrpqzBRwkgR1PfPxPSMDoLYP15RAY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kqTAZPK96eaepNDjtJqr2PkoBnNcWnXBOCuzOXk/Kh9TqEIgjEWnvwXyuBrFJni2Q
         m5TUSV0/NHFaWEJcziQic1miTxCLAiEZBxScOJY9L1LR5OOCDjkxgdFe23uY5YlamW
         B4kNfLtYE9L6n5oeKtq3sfJU/xLy9aAnjWOAg+uMMlGkG10agRTtjZzaYJlVRvr1F9
         RZc9DyU9vc1WDOZ8Q94LS9hyH2hytzyMlk+lSRZVL57L3xlGqh/hZYcneZhxqfkLRM
         1rRgxul8x18Ye9+udruLFPR1TfKHhU9ids03n4nm5ULSvH3vCyQhxumhhjAOlsFZc/
         lbofgbt5xvHfA==
Date:   Wed, 9 Nov 2022 13:23:13 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Shayne Chen <shayne.chen@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 08/10] wifi: mt76: connac: add more starec command tags
Message-ID: <Y2ubscudOqgM6KVz@localhost.localdomain>
References: <20221031164000.17063-1-shayne.chen@mediatek.com>
 <20221031164000.17063-9-shayne.chen@mediatek.com>
 <Y2uXJh5rFm9uocvz@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UCQWQl3MBJUcf10d"
Content-Disposition: inline
In-Reply-To: <Y2uXJh5rFm9uocvz@localhost.localdomain>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--UCQWQl3MBJUcf10d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > Add starec tags which will be used in new chipset.
> > This is a preliminary patch to add mt7996 chipset support.
> >=20
> > Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
> > ---
> >  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/dri=
vers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> > index ed1d24822c37..336c20fcc8dc 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> > +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> > @@ -791,6 +791,8 @@ enum {
> >  	STA_REC_PHY =3D 0x15,
> >  	STA_REC_HE_6G =3D 0x17,
> >  	STA_REC_HE_V2 =3D 0x19,
> > +	STA_REC_HDRT =3D 0x28,
> > +	STA_REC_HDR_TRANS =3D 0x2B,
> >  	STA_REC_MAX_NUM
> >  };
>=20
> I guess this patch does not apply cleanly.
>=20
> Regards,
> Lorenzo
>=20
> > =20
> > --=20
> > 2.25.1
> >=20

I guess I am missing sta_rec_he_v2 structure definition. Is it already upst=
ream
or have you missed it?

Regards,
Lorenzo

--UCQWQl3MBJUcf10d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY2ubrgAKCRA6cBh0uS2t
rKoRAP9fcTnggQxj1gHoI5gfn/9YlJ1lOMGr0cQU65KLW/TedwD/UbioEm9r0EpW
Gvo79uNqhSE2xbiru/pcgpeShHA8KgU=
=pM2l
-----END PGP SIGNATURE-----

--UCQWQl3MBJUcf10d--
