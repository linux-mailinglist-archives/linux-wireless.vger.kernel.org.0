Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33EFF10EC3
	for <lists+linux-wireless@lfdr.de>; Wed,  1 May 2019 23:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbfEAVu2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 May 2019 17:50:28 -0400
Received: from ozlabs.org ([203.11.71.1]:33125 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbfEAVu1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 May 2019 17:50:27 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44vXBS5rrYz9sBr;
        Thu,  2 May 2019 07:50:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556747424;
        bh=d3Hyk9hoEweP+8Kkjjy6MEk0dCy8BrNxMT1l9x4eh9g=;
        h=Date:From:To:Cc:Subject:From;
        b=ZeX8n2tVqFnsOZIK5QUp3ZPpD4UoedjwpAET595PbZNe0cDaIhWbZ+evxdN7cd2vW
         OcDFnlnICiCrnzoEq9DdOREW+xEyAFEeUiV5jX32H47thn6TNe6+o0363CoUST+4gd
         q1vKIClq8wcpYpdo2vGjWiy0Nj6W/ILBu8ZrdPw7O8KG6tTjL64f1NvFJR0W2DldUR
         Fnej5wAkY8sbVhiyhEau9t/p0njBahKeIS2LqMbCEb+Y41QO7JwcpcdyEdEwOIJelO
         LD3Isv6W5KcCBi5lsgeWiCc42KzG5eoyTLIuGs0dm+aj9e0tDUipr/SCg3XeMJrTOl
         +N1KiFKOz3cKg==
Date:   Thu, 2 May 2019 07:50:22 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>
Subject: linux-next: Fixes tag needs some work in the wireless-drivers-next
 tree
Message-ID: <20190502075022.7d0a9f69@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/pnpuXjq4S2scTonmj6=o__M"; protocol="application/pgp-signature"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/pnpuXjq4S2scTonmj6=o__M
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  9c7c756eb066 ("mt76: mt76x02: mt76x02_poll_tx() can be static")

Fixes tag

  Fixes: ec7d2d74760a ("mt76: mt76x02: use napi polling for tx cleanup")

has these problem(s):

  - Target SHA1 does not exist

Did you mean

Fixes: 2ac515a5d74f ("mt76: mt76x02: use napi polling for tx cleanup")

And BTW, we prefer real names on Signed-off-by tags ...
--=20
Cheers,
Stephen Rothwell

--Sig_/pnpuXjq4S2scTonmj6=o__M
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzKFJ4ACgkQAVBC80lX
0GzsKgf9GnowrC+vNhy3Jh0EFLyI+uRZuNKBeVzZB5O9c/Gjv8YAQwjLPq/9eeqp
6ENGMLsRry09lpI2yaVjp4FrjAFzqQtI+MXw9nfwlQzF4++gx4qLEnUKGIWKw8jq
pm70SSE+mJtT51rVtmAuSDQcVKSikAzTJ7uXBB1m0VyFB3IwOtVa0kJLwGxkn2LJ
HwhwXg6TQH7MKeIef+IBQomNJDSgJrTdMgAb1wXPj45M3VeVDvMcX4ZWXMqqvMPy
atYlLou0HahPjrybAvs68zrlj+iBUufL+7A3w+PN3T8D5+Fhu7N7AWOP+ZrAPhqc
qoocrbAZdm2XSjhTCfyJEZSJhetWKA==
=dMg2
-----END PGP SIGNATURE-----

--Sig_/pnpuXjq4S2scTonmj6=o__M--
