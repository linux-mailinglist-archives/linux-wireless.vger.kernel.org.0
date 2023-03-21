Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE72B6C3465
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Mar 2023 15:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjCUOh2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Mar 2023 10:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjCUOh1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Mar 2023 10:37:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10674DE20
        for <linux-wireless@vger.kernel.org>; Tue, 21 Mar 2023 07:37:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8E952B81664
        for <linux-wireless@vger.kernel.org>; Tue, 21 Mar 2023 14:37:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8D2C433D2;
        Tue, 21 Mar 2023 14:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679409443;
        bh=sjNqu5eRo4wCbueLnNxd6bJp6i8UH79kDeDsibmbOBs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ArbrDmsmNJBlUln+S+wTQK8mLAFd4g0lekShoUi7B/XNQZPxAsIFiYoEYPf/IyVmW
         WeqZ9rUXZSjNvWZihQdHlghaeZozKnRlB6p3xqClNb3XqW9iC7DO9GL0tA9m0bUSG9
         HFwLM2KOMCmj66rUGVUX0gzEauQWKjPkiph1Kg3NmVBdyt+8Y4eM/wurCGitnQUcjN
         koyLrnyAmQjiCA7113euG33vOtgdL/artbuHZBKoYqXo+03vmkw7ZZU3r8cyc6e18t
         IUT3z2RESe0AP1G4ewmjE5r6bxQIc9qo8KT1SwseJSq1+CUqr4Wz+7xCAInV0Vaqb9
         PDOLco3eD9WkQ==
Date:   Tue, 21 Mar 2023 15:37:19 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Ben Greear <greearb@candelatech.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] wireless: mt76: mt7921: Fix use-after-free in fw
 features query.
Message-ID: <ZBnBH9oiwogHqfUt@lore-desk>
References: <20230308175832.2394061-1-greearb@candelatech.com>
 <ZBl/vVj3wiaZl+du@lore-desk>
 <8f3fce81-dae7-9850-87ac-ed2b869c9dfd@candelatech.com>
 <ZBmw+uTa+CiV/KKJ@lore-desk>
 <98c35dc6-580b-d877-4124-93d98f2a163c@candelatech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nuAhalTTnsUumyp0"
Content-Disposition: inline
In-Reply-To: <98c35dc6-580b-d877-4124-93d98f2a163c@candelatech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--nuAhalTTnsUumyp0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 3/21/23 06:28, Lorenzo Bianconi wrote:
> > > On 3/21/23 02:58, Lorenzo Bianconi wrote:
> > > > > From: Ben Greear <greearb@candelatech.com>
> > > > >=20
> > > > > Stop referencing 'features' memory after release_firmware is call=
ed.
> > > > >=20
> > > > > Fixes this crash:
> > > > >=20
> > > > > RIP: 0010:mt7921_check_offload_capability+0x17d
> > > > > mt7921_pci_probe+0xca/0x4b0
> > > > > ...
> > > > >=20
> > > > > Signed-off-by: Ben Greear <greearb@candelatech.com>
> > > > > ---
> > > > >    drivers/net/wireless/mediatek/mt76/mt7921/init.c | 11 ++++++++=
+--
> > > > >    1 file changed, 9 insertions(+), 2 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/d=
rivers/net/wireless/mediatek/mt76/mt7921/init.c
> > > > > index 38d6563cb12f..d2bb8d02ce0a 100644
> > > > > --- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> > > > > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> > > > > @@ -165,12 +165,12 @@ mt7921_mac_init_band(struct mt7921_dev *dev=
, u8 band)
> > > > >    u8 mt7921_check_offload_capability(struct device *dev, const c=
har *fw_wm)
> > > > >    {
> > > > > -	struct mt7921_fw_features *features =3D NULL;
> > > > >    	const struct mt76_connac2_fw_trailer *hdr;
> > > > >    	struct mt7921_realease_info *rel_info;
> > > > >    	const struct firmware *fw;
> > > > >    	int ret, i, offset =3D 0;
> > > > >    	const u8 *data, *end;
> > > > > +	u8 offload_caps =3D 0;
> > > > >    	ret =3D request_firmware(&fw, fw_wm, dev);
> > > > >    	if (ret)
> > > > > @@ -197,12 +197,19 @@ u8 mt7921_check_offload_capability(struct d=
evice *dev, const char *fw_wm)
> > > > >    	data +=3D sizeof(*rel_info);
> > > > >    	end =3D data + le16_to_cpu(rel_info->len);
> > > > > +	/* TODO:  This needs better sanity checking I think.
> > > > > +	 * Likely a corrupted firmware with bad rel_info->len, for inst=
ance,
> > > > > +	 * would blow this up.
> > > > > +	 */
> > > >=20
> > > > can you please repost dropping this comment?
> > >=20
> > > Why?  Looks to me like this portion of mtk driver logic assumes firmw=
are is
> > > never corrupted on accident or on purpose.  It should be fixed at som=
e point.
> >=20
> > even if this is a theoretical issue, this does not seem the right way t=
o track
> > it and it is not related to this patch.
>=20
> There is no better way I know to track such problems, it is not like rand=
om OSS developers will
> read kernel bugzilla for this sort of thing, and email bug report about i=
t will be buried in days
> and never seen again.
>=20
> And it is related to crazy memory corruption bugs since a corrupted firmw=
are could cause similar
> memory corruption.  So next time someone is working on this code, maybe t=
hey will see the
> comment and code it more defensively.

honestly I do not think this comment is so useful to understand a memory co=
rruption issue,
it just makes the code uglier. If you feel this is a real issue, I would sa=
y to post a
patch to improve the code :).

Regards,
Lorenzo

>=20
> Anyway, if you insist, I can re-spin the patch against 6.2 and repost.  I=
 also hear that it will not
> apply to 6.3, but I'm not yet working on 6.3.
>=20
> Thanks,
> Ben
>=20
> --=20
> Ben Greear <greearb@candelatech.com>
> Candela Technologies Inc  http://www.candelatech.com

--nuAhalTTnsUumyp0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZBnBHwAKCRA6cBh0uS2t
rAHQAQCDoIQq3bVpfiIdopPTT0ks7JZbD7RAUGeZZHtCpk3k4AEA/sM24gxL95OU
F+lDB8RwAoBeqtBc//RhtdUQgMYvWgE=
=yPuP
-----END PGP SIGNATURE-----

--nuAhalTTnsUumyp0--
