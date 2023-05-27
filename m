Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAB97133A9
	for <lists+linux-wireless@lfdr.de>; Sat, 27 May 2023 11:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjE0J01 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 27 May 2023 05:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjE0J00 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 27 May 2023 05:26:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58531D3
        for <linux-wireless@vger.kernel.org>; Sat, 27 May 2023 02:26:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD95B611BB
        for <linux-wireless@vger.kernel.org>; Sat, 27 May 2023 09:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90FBC433D2;
        Sat, 27 May 2023 09:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685179584;
        bh=gUblAUUKVj/Zvhr++6GPOw4kHqvW9mY1Fk7Z4tQNS2k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tE9YWYtvJaPLpC3HgNLUNoW/y6zAqiVedmnpg8GTQmcMGZiBBLNVAuAmg5hvjbtkv
         PptJdFn9R1ovTBHs9DMXt/e8qx/GskJ1eeUmhERP9XHzvXyrkMs09eile/gOhrgISP
         jsxcsv6LuVSRVme+pJ5yZSbpHowbnfejGk7FPZ8PzCBl+K8JfJAPiUPQLg33mBfTad
         t3RB40HJCKfPD0GCLGA0glsz1hlB1mgsz3NEfuCzqInKZZAra5lyiBuAUMELEZ0u+6
         Rawzxoaq5yMhR/q/QgAKcYrO6tNc2iAs4VkKfK3E2n0VGtnUfk/P3V+CC1fJoS3lph
         oTJhPOQgFScrg==
Date:   Sat, 27 May 2023 11:26:20 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: mt76: mt7996: fix endianness warning in
 mt7996_mac_write_txwi
Message-ID: <ZHHMvCLUmAXOc6wb@lore-desk>
References: <9509f4bc32d9321f3419a3c0029a01b426f13fd8.1684746447.git.lorenzo@kernel.org>
 <168517541096.19767.17568326076832648919.kvalo@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NCSZ9mLD6+kRW93O"
Content-Disposition: inline
In-Reply-To: <168517541096.19767.17568326076832648919.kvalo@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--NCSZ9mLD6+kRW93O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>=20
> > Fix the following endianness warning in mt7996_mac_write_txwi routine:
> >=20
> > drivers/net/wireless/mediatek/mt76/mt7996/mac.c:1091:25: warning: inval=
id assignment: |=3D
> > drivers/net/wireless/mediatek/mt76/mt7996/mac.c:1091:25:    left side h=
as type restricted __le32
> > drivers/net/wireless/mediatek/mt76/mt7996/mac.c:1091:25:    right side =
has type unsigned long
> >=20
> > Fixes: 15ee62e73705 ("wifi: mt76: mt7996: enable BSS_CHANGED_BASIC_RATE=
S support")
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > Reviewed-by: Simon Horman <simon.horman@corigine.com>
>=20
> Failed to apply, please rebase over wireless tree.
>=20
> error: sha1 information is lacking or useless (drivers/net/wireless/media=
tek/mt76/mt7996/mac.c).
> error: could not build fake ancestor
> hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
> Applying: wifi: mt76: mt7996: fix endianness warning in mt7996_mac_write_=
txwi
> Patch failed at 0001 wifi: mt76: mt7996: fix endianness warning in mt7996=
_mac_write_txwi
>=20
> Patch set to Changes Requested.

Hi Kalle,

my bad, it seems there is already a fix for this issue:

commit cdc26ee89bddb9b6b2ae026a46d97855d5ba6694
Author: Ryder Lee <ryder.lee@mediatek.com>
Date:   Mon Apr 24 05:39:05 2023 +0800

    wifi: mt76: mt7996: fix endianness of MT_TXD6_TX_RATE

    To avoid sparse warning:
    sparse: warning: invalid assignment: |=3D
    sparse:    left side has type restricted __le32
    sparse:    right side has type unsigned lon

    Fixes: 15ee62e73705 ("wifi: mt76: mt7996: enable BSS_CHANGED_BASIC_RATE=
S support")

we can drop this patch. Sorry for the noise.

Regards,
Lorenzo

>=20
> --=20
> https://patchwork.kernel.org/project/linux-wireless/patch/9509f4bc32d9321=
f3419a3c0029a01b426f13fd8.1684746447.git.lorenzo@kernel.org/
>=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches
>=20

--NCSZ9mLD6+kRW93O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZHHMvAAKCRA6cBh0uS2t
rAOJAQCnRE2lRpifJyWcC2C+kSGIplFa9KN3rQN3+7RYSU2JmgD/UahkT5l+SbNC
bMfESUIjmg2Ncd1QwOkN0qltptYGCgM=
=pV02
-----END PGP SIGNATURE-----

--NCSZ9mLD6+kRW93O--
