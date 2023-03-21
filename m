Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E5B6C32DC
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Mar 2023 14:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjCUN27 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Mar 2023 09:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjCUN26 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Mar 2023 09:28:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786754FA98
        for <linux-wireless@vger.kernel.org>; Tue, 21 Mar 2023 06:28:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D25661BBD
        for <linux-wireless@vger.kernel.org>; Tue, 21 Mar 2023 13:28:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26865C433D2;
        Tue, 21 Mar 2023 13:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679405310;
        bh=vgqCB8fj/TchSM2WxD9HfNupF8FuS3V9DkT+ANY4bqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nGtNXKRAFfCVp6DuSunu7Ll6loWzfe1pG5amr/OoGEdvp2Mcq5TiP77KXY4NaoNXJ
         Hq8lLej4mFG53mXdrg1PS+OkojZ2xjpm9f4MC87rNlcs0Lx3LsYlPMsQoGQzOJilCS
         J2D81iYQAAnZLX+QW3Tl3sowkUdOCZMSYWAdgb+epCSTl8SgtSHuzdBcpQdlguaxs0
         1AcfCnQI+eppGa/DIppJkkNneCWySm/FF3YCMNzskbwUMC2usMcQT9x645AzOqWW0k
         tv9G6InyJFLTMuTAvBYKX2gmCf1hGyQYSQeSWLXjUOWGDXtBE18xPf53i4YQFmSsgO
         jsTIVEl67lrbQ==
Date:   Tue, 21 Mar 2023 14:28:26 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Ben Greear <greearb@candelatech.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] wireless: mt76: mt7921: Fix use-after-free in fw
 features query.
Message-ID: <ZBmw+uTa+CiV/KKJ@lore-desk>
References: <20230308175832.2394061-1-greearb@candelatech.com>
 <ZBl/vVj3wiaZl+du@lore-desk>
 <8f3fce81-dae7-9850-87ac-ed2b869c9dfd@candelatech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="18XES8yLT2FoOP51"
Content-Disposition: inline
In-Reply-To: <8f3fce81-dae7-9850-87ac-ed2b869c9dfd@candelatech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--18XES8yLT2FoOP51
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 3/21/23 02:58, Lorenzo Bianconi wrote:
> > > From: Ben Greear <greearb@candelatech.com>
> > >=20
> > > Stop referencing 'features' memory after release_firmware is called.
> > >=20
> > > Fixes this crash:
> > >=20
> > > RIP: 0010:mt7921_check_offload_capability+0x17d
> > > mt7921_pci_probe+0xca/0x4b0
> > > ...
> > >=20
> > > Signed-off-by: Ben Greear <greearb@candelatech.com>
> > > ---
> > >   drivers/net/wireless/mediatek/mt76/mt7921/init.c | 11 +++++++++--
> > >   1 file changed, 9 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drive=
rs/net/wireless/mediatek/mt76/mt7921/init.c
> > > index 38d6563cb12f..d2bb8d02ce0a 100644
> > > --- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> > > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> > > @@ -165,12 +165,12 @@ mt7921_mac_init_band(struct mt7921_dev *dev, u8=
 band)
> > >   u8 mt7921_check_offload_capability(struct device *dev, const char *=
fw_wm)
> > >   {
> > > -	struct mt7921_fw_features *features =3D NULL;
> > >   	const struct mt76_connac2_fw_trailer *hdr;
> > >   	struct mt7921_realease_info *rel_info;
> > >   	const struct firmware *fw;
> > >   	int ret, i, offset =3D 0;
> > >   	const u8 *data, *end;
> > > +	u8 offload_caps =3D 0;
> > >   	ret =3D request_firmware(&fw, fw_wm, dev);
> > >   	if (ret)
> > > @@ -197,12 +197,19 @@ u8 mt7921_check_offload_capability(struct devic=
e *dev, const char *fw_wm)
> > >   	data +=3D sizeof(*rel_info);
> > >   	end =3D data + le16_to_cpu(rel_info->len);
> > > +	/* TODO:  This needs better sanity checking I think.
> > > +	 * Likely a corrupted firmware with bad rel_info->len, for instance,
> > > +	 * would blow this up.
> > > +	 */
> >=20
> > can you please repost dropping this comment?
>=20
> Why?  Looks to me like this portion of mtk driver logic assumes firmware =
is
> never corrupted on accident or on purpose.  It should be fixed at some po=
int.

even if this is a theoretical issue, this does not seem the right way to tr=
ack
it and it is not related to this patch.

Regards,
Lorenzo

>=20
> Thanks,
> Ben
>=20
> --=20
> Ben Greear <greearb@candelatech.com>
> Candela Technologies Inc  http://www.candelatech.com

--18XES8yLT2FoOP51
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZBmw+gAKCRA6cBh0uS2t
rIhWAQD0amDhnZ35j+epDOACpWA7rWsfLouUe5E6NONU+LFnyQEAsaMedSReQjMv
3wyagvSo3L3WSsC3lqHFDlzXOWvZWg8=
=pyIC
-----END PGP SIGNATURE-----

--18XES8yLT2FoOP51--
