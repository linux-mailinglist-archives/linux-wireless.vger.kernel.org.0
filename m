Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1148221EE87
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2020 12:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgGNK7p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Jul 2020 06:59:45 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:58017 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbgGNK7p (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Jul 2020 06:59:45 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4B5cwb2qV0z9s1x;
        Tue, 14 Jul 2020 20:59:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1594724383;
        bh=CaU7hMehrwH/u8zCbwdV66QNc3iG4evLpsX9iI3ZC+Q=;
        h=Date:From:To:Cc:Subject:From;
        b=ZcQVvzY6KQEMk0CwfGUxxOYjXPcK05VLW5I2bcw0XwQMqWOhqm6jKRXo+4sgLJbOP
         yM0KlqRrUQkLiyLqm02ksHByF9A5aOtFP+TOsGyOb1Zow5kHOLTLNzvlu3OKSdFi8t
         tV05dE6Axo7cVmGMe5TqV8n7a6KbN/3dtE/27Upz/8gHWmlcjpKeZaPajR/7hof0JQ
         DCeOMEDgGKmaogRoBbT/CDPXFhsGAfrj6kj5wtUuOPDqNoC1N0gKLSsqzxNzhyR62U
         VTUkpWaKFcVb2BuxXj4glqiwmM28ExAdlKO1kDbSvHuH7XGIOHZWe3FDD1hDryslnb
         XflqvL8ic4caw==
Date:   Tue, 14 Jul 2020 20:59:42 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joseph Chuang <joseph.chuang@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Subject: linux-next: Fixes tag needs some work in the wireless-drivers-next
 tree
Message-ID: <20200714205942.26248f1c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/OiDA8Ai=f6igcds2bDJuwLA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/OiDA8Ai=f6igcds2bDJuwLA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  ad96bc27032c ("brcmfmac: initialize the requested dwell time")

Fixes tag

  Fixes: 4905432b28b7 ("brcmfmac: Fix P2P Group Formation failure via Go-ne=
g method")

has these problem(s):

  - Target SHA1 does not exist


Maybe you meant

Fixes: 9c29da3f4e7e ("brcmfmac: Fix P2P Group Formation failure via Go-neg =
method")

--=20
Cheers,
Stephen Rothwell

--Sig_/OiDA8Ai=f6igcds2bDJuwLA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8NkB4ACgkQAVBC80lX
0Gw50Af+LW7WJB3/+r+ZbjDE806XKes7SJGPe6XT5WjrV4ULYecYAKRr0v+IZTJr
V6GzRRJZzQ2KeIeCHSFjekWjsefCRn/Wdd8woFly/lAqWLGXA+t5ma/q4gAFxVOD
FnER451dMzVpAYyUVI7hcwaQd+W3S1eGBcWNGPDpQ8RU5f/ECQ8N1ushy2Mj0z+L
5a0XXn6W8DBJLON87dQYBmSubg+d68UMTz0JWP0pPcaoCLGZ/KrGhoHB+VGsMtEi
zZdk+kGLwpOnm3VACO2OCLd/rMwYB1kdean/n70wt1cJ2lpxxV152QZLCjbKNzbo
HS07Kz+w01ZP4GK0b50+dzodOiE0IQ==
=3u/W
-----END PGP SIGNATURE-----

--Sig_/OiDA8Ai=f6igcds2bDJuwLA--
