Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C59C32AE5CA
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Nov 2020 02:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731805AbgKKBYK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Nov 2020 20:24:10 -0500
Received: from ozlabs.org ([203.11.71.1]:39737 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727275AbgKKBYK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Nov 2020 20:24:10 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4CW6T31dRvz9s1l;
        Wed, 11 Nov 2020 12:24:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1605057847;
        bh=CGaYzZ3cQ2OPfOkEm+hVSmupJwD0hPIznG98MYGyQGk=;
        h=Date:From:To:Cc:Subject:From;
        b=a9NOZOQ7zMaNGvi+mAOuVTxhje5bwE/mPBtAZTPAjGdoVHnn3xist+6h0sSLNm7Z/
         SNvtxXPO1DijDFI+8qIQJAaoE50EWR4ADIDHrJ8HTH/c42ZiIpX4vOIVCq0NN2Lrhu
         bc4h4CeJPsT7C0A1zbCvx9MWDremExge6+ZAZHb5UiEIOLuQLqvsURL6W7QEnB5veI
         E0wmvi0EqeLhxuz/LtYtinPyBKUbatMn/ftXROv3Yplcp3ZxiZ1EljAursdAl8pT5V
         W0MkSFMQY7VLJhmyOs7dgVsP8QoBBoEsLA8L5eeQiAkpPK1aZBcZ/RRLnMpmc6dqlC
         Qx9KyuJ1NG0Yg==
Date:   Wed, 11 Nov 2020 12:24:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mac80211-next tree
Message-ID: <20201111122404.0a302029@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VB.KfIsMjM.mrn=YQBGypev";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/VB.KfIsMjM.mrn=YQBGypev
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mac80211-next tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/net/wireless/ath/ath9k/debug.c: In function 'read_file_misc':
drivers/net/wireless/ath/ath9k/debug.c:741:35: error: 'struct ath9k_vif_ite=
r_data' has no member named 'nwds'
  741 |       iter_data.nmeshes, iter_data.nwds);
      |                                   ^

Caused by commit

  f532b9716eeb ("ath9k: remove WDS code")

I have used the mac80211-next tree from next-20201110 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/VB.KfIsMjM.mrn=YQBGypev
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl+rPTQACgkQAVBC80lX
0GxuIAf9F/CkDwmofVKMVu7066rik0S2XoJvH5LzOwh/j6cUQwUF08dvEDecN+IW
9lULanSjrRJtOegOQ3Akx4J4jsMJCbCcl6I2pl/WFHvD5WpiAb5xdxaROU/riAhJ
ZwLlO9q+NDMsuS3rhJPDIzmki7Da0o3AFIiufwx2PDEbCkSZVeaKxCfd3uNmnpGQ
xgKKofDKPqJFlPpXDGNA9vowd0dNxVIe4lBvCF/95+lNeyS1UnkqvASzW3hI7LOG
T2F2iZ1Ah/j0DeOQW/7JNM3WdGsPZu3+16l/byFZ0dJJ9F5UpwJ2Wrupgf//ax+z
fVvMTXyH2tr+ux63bwGE+4MfwHQ4EQ==
=CBpO
-----END PGP SIGNATURE-----

--Sig_/VB.KfIsMjM.mrn=YQBGypev--
