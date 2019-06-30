Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF52E5B220
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2019 23:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfF3Vom (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 30 Jun 2019 17:44:42 -0400
Received: from ozlabs.org ([203.11.71.1]:47709 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbfF3Vol (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 30 Jun 2019 17:44:41 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45cPD55D9Yz9s4V;
        Mon,  1 Jul 2019 07:44:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561931079;
        bh=5Q7PsZRSQEvQQaFy/v+Dm9WDxsEWB/XXM10hRf9ZO9A=;
        h=Date:From:To:Cc:Subject:From;
        b=d8w8R9Le5o1hJByNNR8AzpVcNEnXHo2ApQKwPBOJQ8AGraPj5l4SkNbEMXBJB53io
         t1W+XOMvq++Iq0lhwFWMGPfinoNWuvbTbOUNzVoTgzfpGPjlUcsXM/AiFPrTWOsxcQ
         ThLjhuB0L9vcCqGAphxq26wP9pLVtB4Wef5VJBN/jG1Fiv1rY8PKdP7Nuqrzp/pNsZ
         XAKm2INCKZuWUlA4m2Bt6/6V/C/c4CZTZcPASO/vBFhwBQnIkacAalOrQFlOyfVau1
         QE/h7T76j2z2N80EIYW2j965hjH/XZcL/kzj4lLwWEK4+PtTzTImQocA04tQHdjOY/
         17Q31spsKaldA==
Date:   Mon, 1 Jul 2019 07:44:37 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: linux-next: Fixes tag needs some work in the wireless-drivers-next
 tree
Message-ID: <20190701074437.6455d067@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Zs_iQ_.WqrJ9LRAGgobfKNH"; protocol="application/pgp-signature"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/Zs_iQ_.WqrJ9LRAGgobfKNH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  d923cf6bc38a ("mt76: mt7615: fix sparse warnings: warning: cast from rest=
ricted __le16")

Fixes tag

  Fixes: 3ca0a6f6e9df ("mt7615: mcu: use standard signature for mt7615_mcu_=
msg_send")

has these problem(s):

  - Target SHA1 does not exist

Did you mean

Fixes: 516c3e380533 ("mt7615: mcu: use standard signature for mt7615_mcu_ms=
g_send")

In commit

  eda96044de27 ("mt76: mt7615: fix sparse warnings: incorrect type in assig=
nment (different base types)")

Fixes tag

  Fixes: 7339fbc0caa5 ("mt7615: mcu: do not use function pointers whenever =
possible")

has these problem(s):

  - Target SHA1 does not exist

Did you mean

Fixes: 1ca8089a55ee ("mt7615: mcu: do not use function pointers whenever po=
ssible")

In commit

  1a09d9e0e5f0 ("mt76: mt7615: fix incorrect settings in mesh mode")

Fixes tag

  Fixes: f072c7ba2150 ("mt76: mt7615: enable support for mesh")

has these problem(s):

  - Target SHA1 does not exist

Did you mean

Fixes: f4ec7fdf7f83 ("mt76: mt7615: enable support for mesh")

--=20
Cheers,
Stephen Rothwell

--Sig_/Zs_iQ_.WqrJ9LRAGgobfKNH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0ZLUUACgkQAVBC80lX
0GwvtAgAlAobMtWuJTwN5NzDbTTbGYPoAzk1MQiiBtHZZQxCHvuN0NLZP66EKzfB
HI6WW/5ePlYtivml4L4XU8hO+j5q5VAFhwP+SFYetu2IF5zByAjDb4j3Xhbq40Ua
6cAtiae3j1L6deVUgzQzc4+YLhTOhX4U38kKKkVr04BYth7oJvsCEHLuT4psHraR
WfkhxH6BsydaPzow4i62cekeCj7I62wmlMdbA3IvyWmE30KfhqOucVvixUTaQTzn
WqPrq4qw9isrHqHsnCTuBYxIx5O/OXaFNYhi6FdMZmZ7FT6uBaVH+RTTbWy58D2x
HPRZ/fHF+ugY8WFDjVXZWRKLc7sNXw==
=PpeC
-----END PGP SIGNATURE-----

--Sig_/Zs_iQ_.WqrJ9LRAGgobfKNH--
