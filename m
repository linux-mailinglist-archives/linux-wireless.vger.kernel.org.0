Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9614A2EB8D8
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Jan 2021 05:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbhAFEV6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Jan 2021 23:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbhAFEV5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Jan 2021 23:21:57 -0500
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3DDC06134C
        for <linux-wireless@vger.kernel.org>; Tue,  5 Jan 2021 20:21:17 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4D9blZ4LGSz9sRK;
        Wed,  6 Jan 2021 15:21:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1609906874;
        bh=O2QVo2Of1w+D0xD3GhAjQte/8k0579m36heorapA+XA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lASNxF7NHcpz9BoKftcKLUOYUhzPAvYgLBQ23f98chvi20TpNDBtoINsCcOPG8Qf6
         ixc5giLWloMpfvCc7nmKctx4taSHTx575ZG5YGhTLF8yGCQw4QI0zNpjX6zheUr0aB
         JG1S6Af5aely40KjqkD/Tt3ouNm1vW+Gps9nS1as1RubHnkYsX2oeHuULzXcOEAVSA
         PFhpCLdTtASMhQzYNR/vgyjTV1K4j33nvpL7/PIlwhmZ0+JmqLjZfLOqyQqfrSJxBv
         NNIYTYB6446SnOY/2BOswYh6QTlx96a/+aVpLQM4k78qwE0zoxNcVVWtV3bPbsKwVP
         YdksY/9k6QWuw==
Date:   Wed, 6 Jan 2021 15:21:11 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH v2] cfg80211/mac80211: fix kernel-doc for SAR APIs
Message-ID: <20210106152111.48af2ff8@canb.auug.org.au>
In-Reply-To: <20210105113717.ae7e89ee09ea.I8b9f0a9cbfe186931ef9640046f414371f216914@changeid>
References: <20210105113717.ae7e89ee09ea.I8b9f0a9cbfe186931ef9640046f414371f216914@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/W8Ss1ZyqCSaXo=xc8=XwL7E";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/W8Ss1ZyqCSaXo=xc8=XwL7E
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Johannes,

On Tue,  5 Jan 2021 11:38:04 +0100 Johannes Berg <johannes@sipsolutions.net=
> wrote:
>
> From: Johannes Berg <johannes.berg@intel.com>
>=20
> A stray @ caused the kernel-doc parser to not understand
> this, fix that. Also add some missing kernel-doc.
>=20
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: 6bdb68cef7bf ("nl80211: add common API to configure SAR power limi=
tations")
> Fixes: c534e093d865 ("mac80211: add ieee80211_set_sar_specs")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Tested-by: Stephen Rothwell <sfr@canb.auug.org.au> # build only

--=20
Cheers,
Stephen Rothwell

--Sig_/W8Ss1ZyqCSaXo=xc8=XwL7E
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl/1OrgACgkQAVBC80lX
0GyO6gf9Gp9CLOmF5ITpVLn3FOLNf7rHzgXJibn4D1+kRWGxkU5HQ7R0lvVLHJpR
GG7CVRVsX77yYKuPgwI0UA3PnXqmQVlw550fcY6U8e4Ah9qwrjtHZV8sdiFZSmYK
Is4D7wwAM4GgUwsW9GKg6zfO3LcIutBMmbl0jntlB3w3xL7RMwWtM6Xdz9zwM5Xp
/pT7Ww3OZYYhL3aLdVH3p5YCxvhhMnJmF8kaQf0oEb6kAX458Rq7QfcVFXob93x8
0hEt4GOFe97fOP5CaQvja6+PaOml5/UJ7aKe4MRPsmGQVronYoiuoprXkKDlauWK
PaczXRywFZrRmuLxzeL1o/Wgs/+VEQ==
=5NoF
-----END PGP SIGNATURE-----

--Sig_/W8Ss1ZyqCSaXo=xc8=XwL7E--
