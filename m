Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69065FD670
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Oct 2022 10:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiJMIs2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Oct 2022 04:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiJMIs1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Oct 2022 04:48:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8608C15E0CC
        for <linux-wireless@vger.kernel.org>; Thu, 13 Oct 2022 01:48:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E8E1616DB
        for <linux-wireless@vger.kernel.org>; Thu, 13 Oct 2022 08:48:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0257CC433C1;
        Thu, 13 Oct 2022 08:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665650901;
        bh=Db/4zGq9AnUW0anup6bunyNOeO5IJ6uMsV1WWiHKMZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IEapUYCHB06YXa23vtKTxTyzrtuKKDnXIPmDjxtiyRjGHFAQ+uMd1jDX5sqHMphi2
         tDLE9WBt/5dpW0D1CinD7As+zXg/q/WjQgZJVorR+XJQbWb5PnYhz+0bE38lFhK1zM
         j0/rCzYSqoDWxGo2ZrbPexsNTsY3xxH2mgxc6PE5kEH5I59D02MO95Awfhj0E7Tnf0
         gZ1Rc+oa86H9H05ud0cF4Js06TFtRxTsORS8CPleBODDp3JJ8zW0oMvwE9B0UvY5eg
         YXZ9RHjwGLyh4c5H8TaaTSLHtVtpF5TC8kz0Tw2ZGDB+roJd43kACGJv1tPXbhgTym
         Pfgq+IRQugeMQ==
Date:   Thu, 13 Oct 2022 10:48:17 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com, Bo.Jiao@mediatek.com,
        sujuan.chen@mediatek.com, ryder.Lee@mediatek.com,
        evelyn.tsai@mediatek.com, daniel@makrotopia.org,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 0/3] wifi: mt76: introduce WED TX support for mt7986 SoC
Message-ID: <Y0fQ0f3uy5p9f2mP@lore-desk>
References: <cover.1664356281.git.lorenzo@kernel.org>
 <87r0zd4mxw.fsf@kernel.org>
 <Y0aH8T8pTARNWcPE@lore-desk>
 <87zge0memc.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IZ86U2XJZJKcmdx2"
Content-Disposition: inline
In-Reply-To: <87zge0memc.fsf@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--IZ86U2XJZJKcmdx2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>=20
> >> Lorenzo Bianconi <lorenzo@kernel.org> writes:
> >>=20
> >> > Enable WED TX support for mt7915 and mt7986-wmac drivers running on =
MT7986 SoC.
> >>=20
> >> What's WED TX?
> >
> > It is the same as we did for MT7622. It is the capability to offload tr=
affic
> > from lan/wan to wlan. I specified "TX" since MT7986 supports even RX
> > offloading (I am working on it at the moment).
>=20
> It would be nice to mention in the commit log that the feature is about
> offloading traffic from lan/wan to wlan. That way it's stored to to git
> history and people like me have some clue what the patch is about,
> otherwise we are totally in dark.

I think Felix has already applied them.
@Felix: are you taking care of it or do I need to repost?

Regards,
Lorenzo

>=20
> --=20
> https://patchwork.kernel.org/project/linux-wireless/list/
>=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches

--IZ86U2XJZJKcmdx2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY0fQ0QAKCRA6cBh0uS2t
rLI1AQCX4CDrVuzbbjZnQ9FFkNL7JCemSr2XSVdRQMYzw/MY9wEAo10yZAJytWcT
FIybrAIjDLIqvOH3sbFNwwSL2b+KnQU=
=6nXc
-----END PGP SIGNATURE-----

--IZ86U2XJZJKcmdx2--
