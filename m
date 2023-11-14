Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C352E7EAE14
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Nov 2023 11:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbjKNKae (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Nov 2023 05:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKNKad (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Nov 2023 05:30:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B371A5
        for <linux-wireless@vger.kernel.org>; Tue, 14 Nov 2023 02:30:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B849DC433C7;
        Tue, 14 Nov 2023 10:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699957830;
        bh=Z5ZOVvQtxFD4RuHqG2UtLY++QxbSLM7pG+Rl8TPXUU8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SApPneKofgH3Cv6dXTLBlYSEXKM5u9fjhqFZU/9fTS3K+vmQ06myxagxJ1i4rKc8A
         mFPMJOsZSyVuiLBHKM+vfpWb1Q2+ac1ROL9n9uxYhIZ4eQaLPq3+ygl54B6Jltfgip
         CkTdyHj55j5WW3hDf4qP0JPMoPnfVF9BZLd8nmKzttl6jegaIv4H9i6JDfy/7Jv62h
         MMcz9DY10r2YRgJfdcxu+IdRI8yQsVxabbjSb6l4QtS8AYoyhIEv4PDSwqlLFF+xpY
         AGri+Y8QKjpDO1ub5loGZXd2qLx53/lwuKUffjU3ECuk+OVswDAnJVhxIECxiFAySN
         zhtGIqs2X4t8Q==
Date:   Tue, 14 Nov 2023 11:30:26 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        nbd@nbd.name, sean.wang@mediatek.com, deren.wu@mediatek.com
Subject: Re: [PATCH wireless] wifi: mt76: mt7925: fix typo in
 mt7925_init_he_caps
Message-ID: <ZVNMQrAHTE9eOcnw@lore-desk>
References: <7de6e939dc75ee08f05bf1ee73253aa7eeccf28e.1699869649.git.lorenzo@kernel.org>
 <87cywdvox0.fsf@kernel.org>
 <ZVIXQx4nb25pO0EP@lore-desk>
 <87v8a5u8t7.fsf@kernel.org>
 <ZVIZaEsH4gedQNCN@lore-desk>
 <875y24tzuv.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3k24CquD99EOx0NJ"
Content-Disposition: inline
In-Reply-To: <875y24tzuv.fsf@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--3k24CquD99EOx0NJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>=20
> >> Lorenzo Bianconi <lorenzo@kernel.org> writes:
> >>=20
> >> >> Lorenzo Bianconi <lorenzo@kernel.org> writes:
> >> >>=20
> >> >> > Use iftype for interface type switch in mt7925_init_he_caps routi=
ne
> >> >> >
> >> >> > Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 dri=
ver
> >> >> > for mt7925 chips")
> >> >> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> >> >>=20
> >> >> What issue does this fix? In other words, what are the user visible
> >> >> symptoms?
> >> >
> >> > Since we are using i (equal to 8 after the for loop above) instead o=
f iftype
> >> > we are missing some HE capabilities exposed to userspace (we are hit=
ting the
> >> > switch default branch). I agree this is something not so harmful and=
 we can
> >> > apply this fix to Felix's tree instead, up to you.
> >>=20
> >> No no, this is fine for the wireless tree :) I just want to document if
> >> this is fixing a real issue which users can see or just a theoretical
> >> fix you found during code review. It makes handling fixes a lot easier
> >> when we have this documented in the commit message.
> >>=20
> >> No need to resend because of this, I can update the commit log if you
> >> tell me what to add.
> >
> > ack, thx. I will more 'verbose' next time :)
>=20
> But what I should add to the commit message? Is this just a theoretical
> fix you found during code review? Or was there a bug report which
> prompted you to fix this?

I have just spot the bug during code review but it seems it is even reporte=
d in
coverity with id 1549845.

Regards,
Lorenzo

>=20
> --=20
> https://patchwork.kernel.org/project/linux-wireless/list/
>=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches

--3k24CquD99EOx0NJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZVNMQgAKCRA6cBh0uS2t
rIaqAQCNfHjPBSv2JrHAhJJcEzcJyjaCHaHmM1T5kH1hfbItcQEAi/gmLLLnk1dn
di9TVZY9j9RLj4PJ9p5Gl/QgH2LGQwc=
=5DFe
-----END PGP SIGNATURE-----

--3k24CquD99EOx0NJ--
