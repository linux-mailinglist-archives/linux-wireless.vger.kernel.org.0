Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E147E9C49
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Nov 2023 13:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjKMMlT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Nov 2023 07:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjKMMlT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Nov 2023 07:41:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54971715
        for <linux-wireless@vger.kernel.org>; Mon, 13 Nov 2023 04:41:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17BC9C433C7;
        Mon, 13 Nov 2023 12:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699879275;
        bh=TvhejekUlcfdigQ37tJSXbufdwXbi+fgXDpxHhIXEIQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mpipH8suhG16TRvMWO/8tw9Kiy9NA1NFdzgfF+uEOdGvNEOZnLj0xJIRjgmIB53KC
         aJpyF1jmonmevxyyKd0Yh1gmBUzlxGsPdvZ3E9SVtlvae5Vj+ExwXujdNzxehmQvOk
         3sUOIUe6Ph6FF/SusQhXi/MZFpTRkNjbcpi0m2Zu0s80DLETJUq8SALhg6JWsVjSOg
         5YdJkvaJagF3YPd38w5DYY7pJqoCnGUuhTFTxmsZ7HqHECSvgkZ3M9mhLE56xKbUNb
         +pEezwjXua74CURbak9pY0OYa4Yge4CiRYUNKkp9amDF7OX226n9yNDWB/lH/u6iVu
         Xa15Iyb+ogzxg==
Date:   Mon, 13 Nov 2023 13:41:12 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        nbd@nbd.name, sean.wang@mediatek.com, deren.wu@mediatek.com
Subject: Re: [PATCH wireless] wifi: mt76: mt7925: fix typo in
 mt7925_init_he_caps
Message-ID: <ZVIZaEsH4gedQNCN@lore-desk>
References: <7de6e939dc75ee08f05bf1ee73253aa7eeccf28e.1699869649.git.lorenzo@kernel.org>
 <87cywdvox0.fsf@kernel.org>
 <ZVIXQx4nb25pO0EP@lore-desk>
 <87v8a5u8t7.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uUM79lxyAL58Tj3j"
Content-Disposition: inline
In-Reply-To: <87v8a5u8t7.fsf@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--uUM79lxyAL58Tj3j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>=20
> >> Lorenzo Bianconi <lorenzo@kernel.org> writes:
> >>=20
> >> > Use iftype for interface type switch in mt7925_init_he_caps routine
> >> >
> >> > Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver
> >> > for mt7925 chips")
> >> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> >>=20
> >> What issue does this fix? In other words, what are the user visible
> >> symptoms?
> >
> > Since we are using i (equal to 8 after the for loop above) instead of i=
ftype
> > we are missing some HE capabilities exposed to userspace (we are hittin=
g the
> > switch default branch). I agree this is something not so harmful and we=
 can
> > apply this fix to Felix's tree instead, up to you.
>=20
> No no, this is fine for the wireless tree :) I just want to document if
> this is fixing a real issue which users can see or just a theoretical
> fix you found during code review. It makes handling fixes a lot easier
> when we have this documented in the commit message.
>=20
> No need to resend because of this, I can update the commit log if you
> tell me what to add.

ack, thx. I will more 'verbose' next time :)

Regards,
Lorenzo

>=20
> --=20
> https://patchwork.kernel.org/project/linux-wireless/list/
>=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches

--uUM79lxyAL58Tj3j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZVIZZwAKCRA6cBh0uS2t
rI1SAP9SkpBXL52w7Q4/gxIP9ckAklyHOp7fhsZoBnUSFYoGXgD/S4oPejC8ZNZ8
MOwmazhr1hmmAsytxmA3Rf9VGHgkxws=
=KrJE
-----END PGP SIGNATURE-----

--uUM79lxyAL58Tj3j--
