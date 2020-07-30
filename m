Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B73F233B37
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jul 2020 00:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbgG3WVJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 18:21:09 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:43881 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728063AbgG3WVJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 18:21:09 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BHlHR0sPjz9sTC;
        Fri, 31 Jul 2020 08:21:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1596147667;
        bh=v81W8GIsNfgI+jNrSnQzwtV4UC776qBdtzVq2xM/XQQ=;
        h=Date:From:To:Cc:Subject:From;
        b=UqXHJHdzyspL7lWX4rhLYDvN3nEx4Axl3nmlhDZWHztQzBp3xjhd4W03D2/qlrctd
         Ce9h6uOCex41gBy1mbMrG1+8SHHHBA9QKCNm4//GdqY6klyTUOTEqZCq4VzCxZFaBI
         RBawGJaetk2si3MZpNL4yYnWlQYw1H2UyURgerEs+rZAZyLXPYKVA81Hwy0BLZ9YaF
         N3MBmVh0d1ALlAj45ffnR9cPkHPThUhb2UIJflNp0RjwtotKkwoks1x7JyQnTDE2VO
         DH0d3P0YqYkEaRJPHhOII49+bEZUfROx/3E51vNeX7hQncuvm2jppTj7zdxNbiateA
         qYQY7xMXZ3AWQ==
Date:   Fri, 31 Jul 2020 08:21:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        P Praneesh <ppranees@codeaurora.org>
Subject: linux-next: Fixes tag needs some work in the mac80211-next tree
Message-ID: <20200731082105.75e60bda@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KdgfdNUuPJW4qH/heNXQkr5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/KdgfdNUuPJW4qH/heNXQkr5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  5fa4ab3cf34e ("mac80211: avoid bss color setting in non-HE modes")

Fixes tag

  Fixes: eb024f1abca3("mac80211: avoid bss color setting in non-he mode")

has these problem(s):

  - Target SHA1 does not exist

I can't find which commit is meant.

--=20
Cheers,
Stephen Rothwell

--Sig_/KdgfdNUuPJW4qH/heNXQkr5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8jR9EACgkQAVBC80lX
0Gy34Af/e7rSP2pQ9PkQud80zM3HRxW2nPNYDqI/xj3I28TsaAJRWLPEBWAhikLL
uoSQdUPTUZA3w3CoP77SSHLbCll/DpgJmouBWunL+5d7y4DVpSk0b8o1vOm8wyyL
h0KG4b2HGrwiH5KHA5tLExNN7bzELv7cORy7Z8RBD9EZ/Cas8enBi44oa/iLA9GO
WrJB1yUe4QsGOwSuV5opPkXaMSJuDH6IEn0LNltRNyx9mkkhhWJSsuOVMUsTHGX7
6cjtZEwT07jgenjPR0ca2uS0LEEzA7RQ6GB56V2Habw7CLbGeH1YNuyMjPyUzdTP
Y2LE+NdS7gWakniGnPTfa0q8k8qzaQ==
=DuOS
-----END PGP SIGNATURE-----

--Sig_/KdgfdNUuPJW4qH/heNXQkr5--
