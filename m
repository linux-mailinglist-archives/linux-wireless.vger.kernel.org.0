Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC33A1BB3FC
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2020 04:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgD1C3k (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Apr 2020 22:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726261AbgD1C3j (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Apr 2020 22:29:39 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338DFC03C1A8;
        Mon, 27 Apr 2020 19:29:39 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49B5FW7173z9sSb;
        Tue, 28 Apr 2020 12:29:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1588040976;
        bh=vox0HHPOqBnsOzPyL0zRJVD1w17UiamGv8nIXzsZhu0=;
        h=Date:From:To:Cc:Subject:From;
        b=HPB+MhigvYcgrRgUmVUAWSlrcw3t1iwx49cj0yVN0WkI7u72uQrgEtegef1Y3EkBW
         PXNaPQk/1OfET3ZaLoiO/q2G58Zr+FiBS7vqhHm2yRsJDoVWh+QDRxbk4VPrQ0R2QK
         hZZRa6Lf7pPYIjrPi8wxaFOTBLilUGjotdK7n3EKYiFoEHDHIHa7UgiZeUTGCBJ13u
         TzTsr4xugl1Bbq4eJmx3F4AF+pfPqLjZ5NodewP+mVAHTMrNgPh+Zf7qx3H2myltkL
         N9kLioWxRA0C0BmLFOtz4BpbwdMEhKQw948lOxHKv2+oswmGHxCCEn7Sy+4bymH37q
         LsDU2sa9ufinQ==
Date:   Tue, 28 Apr 2020 12:29:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build failure after merge of the mac80211-next tree
Message-ID: <20200428122930.51b6a9c2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/RcmwP9G0Cxk_rW0_E.tyY=o";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/RcmwP9G0Cxk_rW0_E.tyY=o
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mac80211-next tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/staging/wilc1000/cfg80211.c:1668:3: error: 'const struct cfg80211_o=
ps' has no member named 'mgmt_frame_register'
 1668 |  .mgmt_frame_register =3D wilc_mgmt_frame_register,
      |   ^~~~~~~~~~~~~~~~~~~
drivers/staging/wilc1000/cfg80211.c:1668:25: error: initialization of 'int =
(*)(struct wiphy *, struct wireless_dev *, u64)' {aka 'int (*)(struct wiphy=
 *, struct wireless_dev *, long long unsigned int)'} from incompatible poin=
ter type 'void (*)(struct wiphy *, struct wireless_dev *, u16,  bool)' {aka=
 'void (*)(struct wiphy *, struct wireless_dev *, short unsigned int,  _Boo=
l)'} [-Werror=3Dincompatible-pointer-types]
 1668 |  .mgmt_frame_register =3D wilc_mgmt_frame_register,
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/staging/wilc1000/cfg80211.c:1668:25: note: (near initialization for=
 'wilc_cfg80211_ops.mgmt_tx_cancel_wait')
cc1: some warnings being treated as errors
drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c:3400:3: error: 'struct cf=
g80211_ops' has no member named 'mgmt_frame_register'
 3400 |  .mgmt_frame_register =3D cfg80211_rtw_mgmt_frame_register,
      |   ^~~~~~~~~~~~~~~~~~~
drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c:3400:25: error: initializ=
ation of 'int (*)(struct wiphy *, struct wireless_dev *, u64)' {aka 'int (*=
)(struct wiphy *, struct wireless_dev *, long long unsigned int)'} from inc=
ompatible pointer type 'void (*)(struct wiphy *, struct wireless_dev *, u16=
,  bool)' {aka 'void (*)(struct wiphy *, struct wireless_dev *, short unsig=
ned int,  _Bool)'} [-Werror=3Dincompatible-pointer-types]
 3400 |  .mgmt_frame_register =3D cfg80211_rtw_mgmt_frame_register,
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c:3400:25: note: (near init=
ialization for 'rtw_cfg80211_ops.mgmt_tx_cancel_wait')

Caused by commit

  6cd536fe62ef ("cfg80211: change internal management frame registration AP=
I")

I have used the mac80211-next from next-20200424 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/RcmwP9G0Cxk_rW0_E.tyY=o
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6nlQoACgkQAVBC80lX
0GyeMQf9G3QjjjZhzmtu4gkijiF++83UYKHWxF6qFp7Zfpm7NMdNhm6q0PQ8ebxj
pFom4FidAuCre5rBW6D6rK0BlvE6B2Eic93qfDLdfxT9kPngFJGn3gi8kXIdryJc
6X0nYIkg9yh/o9u8u7nNhadi5uQv+CzhKyZeiWJxm8F5DASnxzE69/7gBgu41RNh
//qbXDBArOIDdJwWkoCopCiTmjCCDqdiU0nqvdnzRBhnB7UpGXozA4w7gvCPg+Su
S5ZI7oRk/iTc4r6MMABOWT0BBkgvMC5Tn61R4f2Xl63lvhiGsuiWGpcElPcDCx0U
FjSfYnGQ5NjvZMwra3GWhN5jo51qRg==
=k85i
-----END PGP SIGNATURE-----

--Sig_/RcmwP9G0Cxk_rW0_E.tyY=o--
