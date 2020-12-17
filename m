Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3EF52DD5C6
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Dec 2020 18:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgLQRLu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Dec 2020 12:11:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:38502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727414AbgLQRLu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Dec 2020 12:11:50 -0500
Date:   Thu, 17 Dec 2020 18:11:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608225069;
        bh=i/Hv6kJp9s5d3WIMkY3jkR/F8YZH/7i8An5bfZ6lt8M=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=KmUD8O/lm/sKyejUUoGnYeZXWiR/T3cil14bKVzIIhFnJKq0rFDejl8i7U16uZbOv
         FmI5lfTAOgjcennsjVhVhzNWwLbGmm+/xzknOJZpv5k3u3X9kKgapt3XLlsRDqGnsZ
         JgIOzBYb5hdW0V3bvB23Tsr2bf0EcOsyw9f+bVKrzOSbl0qZ93HAIKrDoyRfQywFu/
         n4eGUp2+18l7v/9ytr6weGViDsGv1wuLk6y22jZ2S6CDvolhOXVm2PWzzC21hDasSa
         ONXYLW9uDX9biw1Gg/HiuZFnukQYuqg8e1xY8/Ga8ob4a8yOk4ZW5Iwhf2v8DxtQwM
         F7WVUf+m2Gnqg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH] mt76: mt76s: fix NULL pointer dereference in
 mt76s_process_tx_queue
Message-ID: <20201217171105.GC16606@lore-desk>
References: <b49c1b4edacd87b2241a9fd0431dd4864c8963f6.1607418933.git.lorenzo@kernel.org>
 <20201217163616.546AFC433CA@smtp.codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZwgA9U+XZDXt4+m+"
Content-Disposition: inline
In-Reply-To: <20201217163616.546AFC433CA@smtp.codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--ZwgA9U+XZDXt4+m+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>=20
> > Fix a possible NULL pointer dereference in mt76s_process_tx_queue that
> > can occur if status thread runs before allocating tx queues
> >=20
> > Fixes: 6a618acb7e62 ("mt76: sdio: convert {status/net}_work to mt76_wor=
ker")
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> Failed to apply to wireless-drivers:

Hi Kalle,

sorry for the noise. I guess to apply this patch we need to apply even the
following series:
https://patchwork.kernel.org/project/linux-wireless/cover/cover.1607164041.=
git.lorenzo@kernel.org/

@Felix: do you think it is ok to apply "remove wake queue tx logic for
usb/sdio" series to wireless-drivers?

If not I can rebase this path ontop of current wireless-drivers tree.

Regards,
Lorenzo

>=20
> fatal: sha1 information is lacking or useless (drivers/net/wireless/media=
tek/mt76/sdio.c).
> error: could not build fake ancestor
> Applying: mt76: mt76s: fix NULL pointer dereference in mt76s_process_tx_q=
ueue
> Patch failed at 0001 mt76: mt76s: fix NULL pointer dereference in mt76s_p=
rocess_tx_queue
> The copy of the patch that failed is found in: .git/rebase-apply/patch
>=20
> Patch set to Changes Requested.
>=20
> --=20
> https://patchwork.kernel.org/project/linux-wireless/patch/b49c1b4edacd87b=
2241a9fd0431dd4864c8963f6.1607418933.git.lorenzo@kernel.org/
>=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches
>=20

--ZwgA9U+XZDXt4+m+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCX9uRJgAKCRA6cBh0uS2t
rDdZAQDdPlP+pg5MxtMYRslw/lLKt+QhA/j/Czf0EjjQLNiTjwEAgBmv5VSGgpyi
Chbb4cvymZwZP+qcZnvw93vmjShBmw0=
=+cpr
-----END PGP SIGNATURE-----

--ZwgA9U+XZDXt4+m+--
