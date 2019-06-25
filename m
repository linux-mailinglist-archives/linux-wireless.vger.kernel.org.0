Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70BC652341
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 08:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbfFYGEk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 02:04:40 -0400
Received: from ozlabs.org ([203.11.71.1]:35045 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbfFYGEj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 02:04:39 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Xwbj6HJ3z9s8m;
        Tue, 25 Jun 2019 16:04:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561442675;
        bh=gqgpgNuir0xa0VZxhOcjCH6I2s7E7+xdr3188tvHy/U=;
        h=Date:From:To:Cc:Subject:From;
        b=udnhh+J/BQ1YYJeyPozym+yIvynscvlqdiOcawjpoeSk/Ku0KfSQWfLMFJ5rI3oTo
         eqgwi2DnR7Os2ztXN8fuJrPwUYNsF5GhHpKnxERouvwpM6VTTwE0D/x5EtmtdGzVCH
         nvlK+uhC/MDj8uPITxk4tKBI3FRucv4x7QP4PTpUiF7r/WPaKMSAvEQnN1p5JPDGxU
         713qh8rWVvwDcO7ScVjc5oAipQc3LvfbXLts3sLPr/AEqGAhIuEO0wK/cy0UpY/ZyC
         L7G9rRxLyDa76TTy63VNMEWyTt8gio6gtEL+mKhMvTxPcJCW12g1Ksw7E/aXXR3O7I
         /tQVyKg8FmqQA==
Date:   Tue, 25 Jun 2019 16:04:32 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian Lamparter <chunkeey@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: linux-next: build failure after merge of the tip tree
Message-ID: <20190625160432.533aa140@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/oufE/.3INgAoB24nFYBeodF"; protocol="application/pgp-signature"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/oufE/.3INgAoB24nFYBeodF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tip tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

drivers/net/wireless/intersil/p54/txrx.c: In function 'p54_rx_data':
drivers/net/wireless/intersil/p54/txrx.c:386:28: error: implicit declaratio=
n of function 'ktime_get_boot_ns'; did you mean 'ktime_get_raw_ns'? [-Werro=
r=3Dimplicit-function-declaration]
   rx_status->boottime_ns =3D ktime_get_boot_ns();
                            ^~~~~~~~~~~~~~~~~
                            ktime_get_raw_ns

Caused by commit

  c11c75ec784e ("p54: Support boottime in scan results")

from the wireless-drivers-next tree interacting with commit

  9285ec4c8b61 ("timekeeping: Use proper clock specifier names in functions=
")

from the tip tree.

I have added the following merge fix patch:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 25 Jun 2019 15:55:36 +1000
Subject: [PATCH] p54: fix up for ktime_get_boot_ns() name change

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/net/wireless/intersil/p54/txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intersil/p54/txrx.c b/drivers/net/wireles=
s/intersil/p54/txrx.c
index be6968454282..873fea59894f 100644
--- a/drivers/net/wireless/intersil/p54/txrx.c
+++ b/drivers/net/wireless/intersil/p54/txrx.c
@@ -383,7 +383,7 @@ static int p54_rx_data(struct p54_common *priv, struct =
sk_buff *skb)
=20
 	fc =3D ((struct ieee80211_hdr *)skb->data)->frame_control;
 	if (ieee80211_is_probe_resp(fc) || ieee80211_is_beacon(fc))
-		rx_status->boottime_ns =3D ktime_get_boot_ns();
+		rx_status->boottime_ns =3D ktime_get_boottime_ns();
=20
 	if (unlikely(priv->hw->conf.flags & IEEE80211_CONF_PS))
 		p54_pspoll_workaround(priv, skb);
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/oufE/.3INgAoB24nFYBeodF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0RuXAACgkQAVBC80lX
0Gy6rAf/dwngi30bPaG/rjkqs7iS/f+5HGQwWQ3OHRyai8ENCY0xP5QCXXiJ2T8X
UPHxkcZI3Pd8WSQSsGk7QO22MKQVRuMZXZlUqd+QUmeGUY2ZrnrxbNaF3zqOjSkC
SC+loQQF7ZDhunuuE6iKOGdAXhI29FVzLRlglWkR0XPNEIg/+TuX1orHq+75noND
FWUXDq4JEs98kigxby8MzdlhBXuq0h60JMlnDZyey173O2KnMb1HetMXjntkPG28
YxErKXWGDTjSiKkbpItOpXMwOZsLU9VnGP+AYjSCs52jvGQE8KDAjaorvfgESbfm
bHe+L3S41avlNDwQYG7fsxmKySiIMQ==
=Anm+
-----END PGP SIGNATURE-----

--Sig_/oufE/.3INgAoB24nFYBeodF--
