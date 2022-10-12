Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F735FC306
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Oct 2022 11:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiJLJZQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Oct 2022 05:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiJLJZP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Oct 2022 05:25:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6443123178
        for <linux-wireless@vger.kernel.org>; Wed, 12 Oct 2022 02:25:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 015D6B81996
        for <linux-wireless@vger.kernel.org>; Wed, 12 Oct 2022 09:25:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F3DC433D7;
        Wed, 12 Oct 2022 09:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665566709;
        bh=uiJY5+AkaAMp+NhogWhqvdKPXEcFzAOib0lDS14Z8y0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gde+pLBDezd1Hlldo5PeZMvMerNomZP/VdLolLF50NRihidToOkWg2zMmwkrwkK1F
         te6Wg4S1Buk4Z4cxI2lvTV3X0YJTkkry/hu7bKbido3W6l27ghd2/oAkftw4SmEnQ1
         MxnnQSVvBSyMdmC2tF0HSlAueypcf5EOxAX02A5ONo1RXln8Ho8e+qiVa5k3QnoOUs
         JgwFrW7GX4DUbgPdy7S+XcGSY+DJQydeIBRWrJ2uI9jaKml1QDwkt72AoQG+aADbrx
         kb7zTJfGqxY/XwlclrNgSZ/AAp79sOYiKssIuCDMGS4juo7+UflJhSFp2LcKpJve6N
         46yAmI9xq71Lg==
Date:   Wed, 12 Oct 2022 11:25:05 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com, Bo.Jiao@mediatek.com,
        sujuan.chen@mediatek.com, ryder.Lee@mediatek.com,
        evelyn.tsai@mediatek.com, daniel@makrotopia.org,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 0/3] wifi: mt76: introduce WED TX support for mt7986 SoC
Message-ID: <Y0aH8T8pTARNWcPE@lore-desk>
References: <cover.1664356281.git.lorenzo@kernel.org>
 <87r0zd4mxw.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GTbcF8eMCdPYvLM9"
Content-Disposition: inline
In-Reply-To: <87r0zd4mxw.fsf@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--GTbcF8eMCdPYvLM9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>=20
> > Enable WED TX support for mt7915 and mt7986-wmac drivers running on MT7=
986 SoC.
>=20
> What's WED TX?

It is the same as we did for MT7622. It is the capability to offload traffic
=66rom lan/wan to wlan. I specified "TX" since MT7986 supports even RX
offloading (I am working on it at the moment).

Regards,
Lorenzo

>=20
> --=20
> https://patchwork.kernel.org/project/linux-wireless/list/
>=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches

--GTbcF8eMCdPYvLM9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY0aH8QAKCRA6cBh0uS2t
rAa3AP9n3aPsW3C7quL5gEke3mF4EKMJsdqzGKU+d/Bx2PfZwAD8DQOAz2RLH1dY
L6F3og0vGJZgBtk3tviFsjtUlOtInwg=
=Iy2J
-----END PGP SIGNATURE-----

--GTbcF8eMCdPYvLM9--
