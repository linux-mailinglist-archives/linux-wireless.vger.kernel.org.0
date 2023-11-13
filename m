Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEA87E9C25
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Nov 2023 13:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjKMMcO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Nov 2023 07:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjKMMcL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Nov 2023 07:32:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E54171C
        for <linux-wireless@vger.kernel.org>; Mon, 13 Nov 2023 04:32:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0893FC433C8;
        Mon, 13 Nov 2023 12:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699878727;
        bh=TDo8fPGDFZRU+DD933YAT/iiXu1hv4rnTxb9t8ZpvlU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aZaC5LPtlMgZNGLEfvnVInU67bZz3DP3wkmK9OXMAnOBXxahbyeFoAtddd5WewLAo
         RCRtkvzfynW1Oh90varhWd5EI0RfzaflKeZ2s9f/gSH7ACo49VQS0vV0mEsr6X1Opq
         p90Oo8djeqT+gjnNB2TRZvH7ESFmIYwKA9cD+qnvysNwNKlfRkb4+SdLaMfpVjjAu8
         on2+w1j8dt4Ow8QpVGHueyNKso9DLbJTJFSIEN6CkPX+kkrvbjmgb9hUglGt0pQyN7
         FGCMIoxeUXyy00sJkfUMe2a/zFXq1llKLmAK9Pq5zX9dhvNmfqKOwHc3GG/HSvJXrc
         iwHUL77V0ak/w==
Date:   Mon, 13 Nov 2023 13:32:03 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        nbd@nbd.name, sean.wang@mediatek.com, deren.wu@mediatek.com
Subject: Re: [PATCH wireless] wifi: mt76: mt7925: fix typo in
 mt7925_init_he_caps
Message-ID: <ZVIXQx4nb25pO0EP@lore-desk>
References: <7de6e939dc75ee08f05bf1ee73253aa7eeccf28e.1699869649.git.lorenzo@kernel.org>
 <87cywdvox0.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NPBqBuo54QMuH0+5"
Content-Disposition: inline
In-Reply-To: <87cywdvox0.fsf@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--NPBqBuo54QMuH0+5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>=20
> > Use iftype for interface type switch in mt7925_init_he_caps routine
> >
> > Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver
> > for mt7925 chips")
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> What issue does this fix? In other words, what are the user visible
> symptoms?

Since we are using i (equal to 8 after the for loop above) instead of iftype
we are missing some HE capabilities exposed to userspace (we are hitting the
switch default branch). I agree this is something not so harmful and we can
apply this fix to Felix's tree instead, up to you.

Regards,
Lorenzo

>=20
> --=20
> https://patchwork.kernel.org/project/linux-wireless/list/
>=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches

--NPBqBuo54QMuH0+5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZVIXQwAKCRA6cBh0uS2t
rFMTAP4q8uShsvRUks3UMoKkg42BPg2DYjJqCE+iv5+zMpepngD7BlADrUPZwaQf
YNPADmLJxOu3Rn8Y03mG/udQjga6qgs=
=i1QA
-----END PGP SIGNATURE-----

--NPBqBuo54QMuH0+5--
