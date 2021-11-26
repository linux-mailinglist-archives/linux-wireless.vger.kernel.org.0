Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B63545F248
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Nov 2021 17:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378676AbhKZQlv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Nov 2021 11:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378684AbhKZQjv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Nov 2021 11:39:51 -0500
X-Greylist: delayed 3413 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 26 Nov 2021 08:23:11 PST
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E900C061399
        for <linux-wireless@vger.kernel.org>; Fri, 26 Nov 2021 08:23:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA8F0622B7
        for <linux-wireless@vger.kernel.org>; Fri, 26 Nov 2021 16:23:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD2AC93056;
        Fri, 26 Nov 2021 16:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637943790;
        bh=UKKwM2m+sH+4g4wE7xatRpyzE9EhE/tXLP02E+/e4H8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r9fvgA10fvbt6Qm/qQNZwNlrwUu+mYSEKP3bUrbY3ftlcK4AX45P5VdSAp1hm573y
         ytqvcxjipj2NG8Y0N+r0i1Y4th5PkE02HRqXwP1uSS7aX80djJyuVQnfJBcbDAcx7l
         /Z9HYtmh+3yAGWN2VrT6j/w3amaiSZWcJu3/hieMXSb97O7hdEj8K8YQL95QiuYl3c
         CZt5qHFJ/4KbFLPMB3H0rImZPVFW/DlwsjOOeXrDnHXCGkMNsppc+rvWgt64Qe11sY
         mxQiCCDwJ3I+bdjHGYFfG3EJG1TNzlm4J/qzljVwAZJY1rsh9s5k7a7USJhFio0qkr
         3XVlVxJj4frvw==
Date:   Fri, 26 Nov 2021 17:23:06 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com
Subject: Re: [PATCH wireless-drivers] mt76: fix possible pktid leak
Message-ID: <YaEJ6hQ0uC32+Mts@lore-desk>
References: <a560caffcc24452fb48af53904bbe5c45ea5db93.1637602268.git.lorenzo@kernel.org>
 <163777451567.4686.3609119971518562275.kvalo@codeaurora.org>
 <YaDo21+/MBeeuTDN@lore-desk>
 <87fsrj3qxo.fsf@codeaurora.org>
 <YaD8lT5csiLvmBzS@lore-desk>
 <87sfvij4eh.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0jlUeta7muUdJbMT"
Content-Disposition: inline
In-Reply-To: <87sfvij4eh.fsf@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--0jlUeta7muUdJbMT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>=20
> >> Lorenzo Bianconi <lorenzo@kernel.org> writes:
> >>=20
> >> >> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> >> >>=20
> >> >> > Fix a possible idr pkt-id leak if the packet is dropped on tx side
> >> >> >=20
> >> >> > Fixes: bd1e3e7b693c ("mt76: introduce packet_id idr")
> >> >> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> >> >> > Acked-by: Felix Fietkau <nbd@nbd.name>
> >> >>=20
> >> >> Patch applied to wireless-drivers.git, thanks.
> >> >>=20
> >> >> 2a9e9857473b mt76: fix possible pktid leak
> >> >
> >> > Hi Kalle,
> >> >
> >> > Unfortunately I found a regression introduced by this patch for mt76=
63u (and I
> >> > guess for mt7921s as well). Do you want me to post a fix or just a v=
2?
> >>=20
> >> I don't rebase my trees, so please post a fix. I was planning to submit
> >> a pull request to net tree today, but is this so serious that I should
> >> skip that?
> >
> > I have already tested mt7663u but I do not have mt7921s hw for testing =
(but the
> > behaviour should be the same). I guess we can split the patch, just pos=
t the
> > fix for mt7663u and let Sean the time to test it on mt7921s (I am not s=
ure
> > mt7921s is already available on the market). In this way you can send t=
he PR
> > today. What do you think?
>=20
> I think it's best to wait, I prefer to have proper build testing on my
> tree before I submit the pull request.

ack, fine to me. Let's wait for Sean in this case.

Regards,
Lorenzo

>=20
> --=20
> https://patchwork.kernel.org/project/linux-wireless/list/
>=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches

--0jlUeta7muUdJbMT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYaEJ6gAKCRA6cBh0uS2t
rKWNAQCx4kXVMUxGJnwCQTkziK1f4UR+vvKJxRt9biH7MqnKBwD/RGAt4dEVj32h
nOxB1DeJUX3/tPkhTFg+uLqQA7R64Qw=
=GNIL
-----END PGP SIGNATURE-----

--0jlUeta7muUdJbMT--
