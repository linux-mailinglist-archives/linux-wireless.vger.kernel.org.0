Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCE42490F2
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Aug 2020 00:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgHRWeH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Aug 2020 18:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgHRWeH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Aug 2020 18:34:07 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E6EC061389;
        Tue, 18 Aug 2020 15:34:07 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BWQgW6XF5z9sPf;
        Wed, 19 Aug 2020 08:33:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1597790040;
        bh=k3pxQt90eE1hv4CqHI80gnmB8e6EPfCXSkwk+ZlMmI4=;
        h=Date:From:To:Cc:Subject:From;
        b=YybmRaTtsIR4PdObYNnpET3BTRyXgVIAepEKXD6b1M3tIbTFD6o0+EkvcH6PRGZVX
         cNeRSyaMhJd/9IqdIKajTXdKKhrAkKs5hrUx9PIZWEpqCR8gkBFwE4MwTWgwHpV5Ad
         6uXBPzlmbxwj8tRUnUygbjlqOxW3z4OJzqeT5Pdg53ALi7VkLpxAvij2dvWAmvacpD
         X1D1peglLZ2r3J5ebVu9VNQrqXvk5sCnxHrD/KrDDdrgohQfftaWCJ+oQyyiJugnf0
         mFHqNDrALDXqe6ZIKhFaTlp8wXTh4BdRx7sRD7USjZKxtxvcbLJtGbr6pWzC3Bo8uk
         PATLoCN/JU3Cw==
Date:   Wed, 19 Aug 2020 08:33:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: linux-next: Fixes tag needs some work in the wireless-drivers-next
 tree
Message-ID: <20200819083359.67f45112@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/oHp_qW2ROkDZtlx9g_HdhiR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/oHp_qW2ROkDZtlx9g_HdhiR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  3b9fb6791e71 ("wcn36xx: Fix reported 802.11n rx_highest rate wcn3660/wcn3=
680")

Fixes tag

  Fixes: 8e84c2582169 ("wcn36xx: mac80211 driver for Qualcomm WCN3660/WCN36=
80

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please do not split Fixes tags over more that one line.  Also, keep all
the commit message tags together at the end of the message.

--=20
Cheers,
Stephen Rothwell

--Sig_/oHp_qW2ROkDZtlx9g_HdhiR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl88V1cACgkQAVBC80lX
0Gx7xgf/d1v4bs1bxMPJDa8T426PtGjqkDAj1nMUYX9oAXdyMaKgmHKHOds+sjOP
BzZPw7TuY8n4Vcni7XOlq+D8IjNPOQVuYKNVPbpu2mApn1qo5u7WZ7MgxvWNjyti
+2jrmxZ3QwkQBVdj1c37XnCn/Pn/mU/caJnI0kYoRIcp1w+z+1yc7YhwP8OU6pAh
2d6G+5mP+Uy3Y6zY0jt7dW5Wt3vAWJE3OtYCbLtVQl0pjHnCuCLKRvmyxmwQM3Y9
RQ0B0b1g0WwSnCZBP8OjwQe6nFyX401KoxFc2YXMn108M+5eDDLQhw3P0tDjTW/q
euYoO2XsDU3WHHhveKV2vP0oQyBSvA==
=jnXl
-----END PGP SIGNATURE-----

--Sig_/oHp_qW2ROkDZtlx9g_HdhiR--
