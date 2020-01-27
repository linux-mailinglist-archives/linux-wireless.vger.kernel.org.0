Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E315149E09
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2020 01:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbgA0Amk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Jan 2020 19:42:40 -0500
Received: from ozlabs.org ([203.11.71.1]:50209 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbgA0Amk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Jan 2020 19:42:40 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 485WDZ09G6z9sR1;
        Mon, 27 Jan 2020 11:42:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1580085758;
        bh=wO0ypkROhkUr4z3gWxp0SqLXy6Npy/RkH51sLbfQp8c=;
        h=Date:From:To:Cc:Subject:From;
        b=WpLmCC3wzrlNW+RqVdz2rWmXgDFPOwW+2KMkDrt35TlPUm3B6p8wzDyNidi3JmMdV
         6MdbGSQl1aQDdsi6nppQ4Z0aIV8zyvFtG4P4ryd0NPX9DHhyOh1/sMw2HYdwUb23iv
         kc1A6A7fkKW9Xfk7L+ADwblpVLN88p+Q7T3YcBLz+vWEIAW6CP7FatMIDOasYcQzt4
         5QaLLe/b6p77txwV4slUoZuGkm/UI6+LdZ1oLPCIiKCS8YRbbYJ2cyswvdK/aBp12H
         JOq4jRuo4U19IaUJCAe3RdOLnnSIww/I2hZz45S3r7PfQF+bD+kPe51gyzz7UjI13K
         2Dl6IEHHvJpJA==
Date:   Mon, 27 Jan 2020 11:42:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rakesh Pillai <pillair@codeaurora.org>
Subject: linux-next: Fixes tag needs some work in the wireless-drivers-next
 tree
Message-ID: <20200127114221.52ba6027@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qyN85kgIZux/DvSwoHyT/kD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/qyN85kgIZux/DvSwoHyT/kD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

n commit

  6ba8b3b6bd77 ("ath10k: Correct the DMA direction for management tx buffer=
s")

Fixes tag

  Fixes: dc405152bb6 ("ath10k: handle mgmt tx completion event")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/qyN85kgIZux/DvSwoHyT/kD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl4uMe0ACgkQAVBC80lX
0GwIvgf/bmddk0hzqop3e1BFKbeq+Gf8UHsKmVdjUQyxY93Tf3w/quahjL+6oK9c
ht+QTLIlpJm7XjauCqP2d5zkysJ/07+x4pU7T7X1aB13MqyvjLVmUTTH6utzY6Ap
0f/KuaVja5pQcBqfZS5aSUN+WkoaUVeAMLxe6/2x+xxWKIgSbN25dHRf7apwEd/j
GYKRIoP5ECpapTYR4Ey9QA/rCLF+Ch32ECqhhFY4SmwBmxWtaH1LB3tbw5pEVw3t
AecgI9DoWVUkf+joztQDznLxdx31GQMsRlsTQBYbGoj9dOu4gGl4TtzhQe7wx0gK
uZ31CtU5+J0z+ibhGA7rgHDTVS6f6Q==
=jnjF
-----END PGP SIGNATURE-----

--Sig_/qyN85kgIZux/DvSwoHyT/kD--
