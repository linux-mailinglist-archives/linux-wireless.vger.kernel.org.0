Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91ED8239CB9
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 00:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgHBWEE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 18:04:04 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:48343 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbgHBWEE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 18:04:04 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BKZmJ1BkMz9sPC;
        Mon,  3 Aug 2020 08:03:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1596405842;
        bh=pQ3Sd7U4vE+w2/lTVbDs04/hjZDdOaGEZd/XadR12Ao=;
        h=Date:From:To:Cc:Subject:From;
        b=Y8mOqd7hVKh/YCJsydQj0+K4RC0gJBzDXV2ag5TQJ1TEry6nM4mEhvtNlOi4CXRG/
         wn7Pl0+vVdfNEe5cW+FYqWCdnd19bM9BKek1pvqRjXT8C+6kkjlbQSdtPNzlJ482Tf
         gCivxyyx8i1dh6PVck3I9f51sJkby9pTKRnVIYR7cQU7KIG5lbX5WL35a5LPHUw8nM
         /HT5U9OeMCots+BykzpQlFMM1OWXRwaC/kdlDB4r3KvesCBl/ALAyRoZbIWMgWBmDc
         eNf1Gh2HL572GuQxvSOarApPGeibtZn3R5gChelh23jp2632XmrvswkZhNAf5Vf0s6
         GUUiINjoMyhhQ==
Date:   Mon, 3 Aug 2020 08:03:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>
Subject: linux-next: Fixes tag needs some work in the wireless-drivers-next
 tree
Message-ID: <20200803080359.64b417e3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.dw=d/6DpwdkTfTtS7D8fHD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/.dw=d/6DpwdkTfTtS7D8fHD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  4c7e1711cf4c ("mt76: mt7915: fix potential memory leak in mcu message han=
dler")

Fixes tag

  Fixes: c6b002bcdfa6 ("mt76: add mac80211 driver for MT7915 PCIe-based chi=
psets")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: e57b7901469f ("mt76: add mac80211 driver for MT7915 PCIe-based chips=
ets")

--=20
Cheers,
Stephen Rothwell

--Sig_/.dw=d/6DpwdkTfTtS7D8fHD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8nOE8ACgkQAVBC80lX
0GxaUAf/SptKRVKpWm13tMWq0MJ7Yw2NRvk6LlQHOMweDoHDz7a95dmR3g37k5sp
wrTdKF4Cpt43G8Q1+rNlOk8YW1gY7JhMvQ5A1N3dv8x9mgC69/WJXBSibR7r+GxB
BxrOiluNB7OWsNyYE1Eyim+BZeq2EeD3cBPVmdW43Wh1HyCzBwVGvTtU68vtZgtM
Yzv+6zXGp+6eZK4bUTDzziZRLisI2SX0nSgEb1tYau/g2xy4Bupm7dKOmONB4s8U
6xRjhLDxuCDKYnzLSxTH77IssJGeMu7b1sKHfqxmvemxAr4mOnJK4N1gYvN1dsf2
CBEKb0qK1qH8OKXiJLs7pDQu3VYSQA==
=eZJ2
-----END PGP SIGNATURE-----

--Sig_/.dw=d/6DpwdkTfTtS7D8fHD--
