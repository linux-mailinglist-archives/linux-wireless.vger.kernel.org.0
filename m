Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8035A45F0C1
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Nov 2021 16:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353776AbhKZPgo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Nov 2021 10:36:44 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43852 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378111AbhKZPen (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Nov 2021 10:34:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29B54622BA
        for <linux-wireless@vger.kernel.org>; Fri, 26 Nov 2021 15:26:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A35C93056;
        Fri, 26 Nov 2021 15:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637940377;
        bh=6/qrAYw+whqcJo7MCn4hyxZcOd0cV2shcH2A8oWT/Fk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UpNDowBOjDcrKie5PHh1eq8fakGEncAImXf+YddUozMx5CYm9HY0jOmL8eVBgaV/N
         jZ7m0+d25taXBmpdjGVsPHZmoUu8eW78cSb77uOiFF3qW45L/m9NOdG3bTe6mV/9iQ
         cfIz1OSko/kBC19w4V/oO/afB4xp8zPbPl9myYso2mIz0XSp2CMiv1ONBpFQrRJSlD
         IWXkjDAN6FoustMHfTPx+O7vD6H6awyMJqr6cKwdSSam1UhmW7Yjm4kO0eMCXd7JtS
         69eTmXrwgKsF3gFKB+Fpp3kNERTZnMi/UR6rhIoA9m0GNIkEU9nCq2lrL17RT0KKks
         oC1bQPnija2EA==
Date:   Fri, 26 Nov 2021 16:26:13 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com
Subject: Re: [PATCH wireless-drivers] mt76: fix possible pktid leak
Message-ID: <YaD8lT5csiLvmBzS@lore-desk>
References: <a560caffcc24452fb48af53904bbe5c45ea5db93.1637602268.git.lorenzo@kernel.org>
 <163777451567.4686.3609119971518562275.kvalo@codeaurora.org>
 <YaDo21+/MBeeuTDN@lore-desk>
 <87fsrj3qxo.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="azYq2eXH+Xd4ojZx"
Content-Disposition: inline
In-Reply-To: <87fsrj3qxo.fsf@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--azYq2eXH+Xd4ojZx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>=20
> >> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> >>=20
> >> > Fix a possible idr pkt-id leak if the packet is dropped on tx side
> >> >=20
> >> > Fixes: bd1e3e7b693c ("mt76: introduce packet_id idr")
> >> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> >> > Acked-by: Felix Fietkau <nbd@nbd.name>
> >>=20
> >> Patch applied to wireless-drivers.git, thanks.
> >>=20
> >> 2a9e9857473b mt76: fix possible pktid leak
> >
> > Hi Kalle,
> >
> > Unfortunately I found a regression introduced by this patch for mt7663u=
 (and I
> > guess for mt7921s as well). Do you want me to post a fix or just a v2?
>=20
> I don't rebase my trees, so please post a fix. I was planning to submit
> a pull request to net tree today, but is this so serious that I should
> skip that?

I have already tested mt7663u but I do not have mt7921s hw for testing (but=
 the
behaviour should be the same). I guess we can split the patch, just post the
fix for mt7663u and let Sean the time to test it on mt7921s (I am not sure
mt7921s is already available on the market). In this way you can send the PR
today. What do you think?

Regards,
Lorenzo

>=20
> --=20
> https://patchwork.kernel.org/project/linux-wireless/list/
>=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches

--azYq2eXH+Xd4ojZx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYaD8lQAKCRA6cBh0uS2t
rDaMAP9OF7kn9oWS5pOFHBiD0m0Jig8oiSe+uLWIHOMrOfElKAEA/6hDI0PTHVdl
bAfDI36heuYvN3k9go8U3ezyouYV9w8=
=mZZj
-----END PGP SIGNATURE-----

--azYq2eXH+Xd4ojZx--
