Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98963249238
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Aug 2020 03:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgHSBSU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Aug 2020 21:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbgHSBST (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Aug 2020 21:18:19 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFEDC061389;
        Tue, 18 Aug 2020 18:18:18 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BWVK45Dnwz9sPC;
        Wed, 19 Aug 2020 11:18:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1597799896;
        bh=BGnSY/L4rMFN5hiyzbjFlIJn0xwu8rLrp6CJ/B4x3AQ=;
        h=Date:From:To:Cc:Subject:From;
        b=Q6s7YHpM/W668cHWycbiCClnmIxZl4KePadfIg9NtojfV1u8lUmWLccNheOU0LWhY
         E7tmFcWjlw6a1n280c9tHum+aGnLg5buoCQUfuuJZhuoMBlLSV6eIa0SR6/twYOTJN
         ThDNnydSH+uCRxV0+5OyVtXYrF/CRFUjZ07U/sxO49ROVkX8RX2KuEsgKK1/qNA3zb
         xy3jQKHvyR6FLhcyD+mxBiMuDYSD4p7bYuQu68J6H6V0YuTyd4qJN0IkNP15RFBQYa
         PABoqXUmqe7UNq7+RCC9A0t8YGDu6BLyJk5G2eEjSQgKr1gfbyENHN13NLb3Uu79DA
         8taK0kwInYXGA==
Date:   Wed, 19 Aug 2020 11:18:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Wireless <linux-wireless@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the wireless-drivers-next tree with the
 kspp-gustavo tree
Message-ID: <20200819111815.73cae4b0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/nxgxjrDrkGSnjgFgdc=dvp8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/nxgxjrDrkGSnjgFgdc=dvp8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the wireless-drivers-next tree got a
conflict in:

  drivers/net/wireless/ath/ath11k/dp_rx.c

between commit:

  58e813cceabd ("treewide: Use fallthrough pseudo-keyword")

from the kspp-gustavo tree and commit:

  0b294aebb6a0 ("ath11k: Use fallthrough pseudo-keyword")

from the wireless-drivers-next tree.

I fixed it up (the latter removed an extra blank line) and can carry the
fix as necessary. This is now fixed as far as linux-next is concerned,
but any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/nxgxjrDrkGSnjgFgdc=dvp8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl88fdgACgkQAVBC80lX
0Gxf6Af/QMgm4AGX0eG6/lRUViMK6SMA2QA2IrHVozhaxbGUvFx/MuQv8ayeBenI
H6HmfvkNP84BkLlQTGGHzUmEKeWrTjjQ+7arG/XIAOn+hzr8xjetyyQeK74tlfqX
3zbreNAuflWQpVuFBiPmAXI8uG0vj1Dl2nMy3lDWWuze8mmy32VNIKhM+KiHeSBc
/zc+tvcBDAoK7xHR/5VoEcq8/YbUFp1SAcCZ54WQhPxiqEdadr0qw0HE1Xd1I1Lg
UWeJPyXoRjX5cVHfSLIiz8GpPHg5sp1FjACjHZPOGny1PfbMVFfyr93s3sfW0+NJ
vTaiPAfVLJ9ftteav61sWU1Bay0QdA==
=upik
-----END PGP SIGNATURE-----

--Sig_/nxgxjrDrkGSnjgFgdc=dvp8--
