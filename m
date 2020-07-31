Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50137233DB2
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jul 2020 05:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731262AbgGaD2h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 23:28:37 -0400
Received: from ozlabs.org ([203.11.71.1]:38525 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731175AbgGaD2h (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 23:28:37 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BHt6B2tGfz9sTC;
        Fri, 31 Jul 2020 13:28:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1596166114;
        bh=Bexc+EUBRFfOwFY1RGCD8ItRDD2/Qns19CwYnGfgcmY=;
        h=Date:From:To:Cc:Subject:From;
        b=BlWGLNcHdSrUe6xDCkWUe5H07xCTIN0wclnRWYBANERZVN6U2GJgHZuJ+2eLW5IQb
         dPyWeN+7mnzwKkk3z+qcfb4O8soEXyaiQXqEB+KeONCcH8Q5UaIr+o5p60BDI+by1l
         k9NX+qs2t9TZd+9/2rql0TXdsiqxnWv8F84AAxMkXHth/n1tTbie3wi2yNxNytBEaE
         3RQZKKU9DWsYR5wrXpzWdPnisMpF4AUhjsNuZFC2AKW29LObscV5B+InFVqKQCFR0D
         G1J+JKmPacb4kkJKeMFfEdQBPvgoSGthScxJiob6LBqo8VcR/YFzqaG68/xpizQ40g
         naiYngtxxfEXQ==
Date:   Fri, 31 Jul 2020 13:28:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: linux-next: build warnings after merge of the mac80211-next tree
Message-ID: <20200731132830.75d7a905@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.B7c2JVw=ftB8qCCNoqRfTd";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/.B7c2JVw=ftB8qCCNoqRfTd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mac80211-next tree, today's linux-next build (x86_64
allmodconfig) produced these warnings:

drivers/net/wireless/ath/ath10k/mac.c: In function 'chan_to_phymode':
drivers/net/wireless/ath/ath10k/mac.c:558:3: warning: enumeration value 'NL=
80211_CHAN_WIDTH_1' not handled in switch [-Wswitch]
  558 |   switch (chandef->width) {
      |   ^~~~~~
drivers/net/wireless/ath/ath10k/mac.c:558:3: warning: enumeration value 'NL=
80211_CHAN_WIDTH_2' not handled in switch [-Wswitch]
drivers/net/wireless/ath/ath10k/mac.c:558:3: warning: enumeration value 'NL=
80211_CHAN_WIDTH_4' not handled in switch [-Wswitch]
drivers/net/wireless/ath/ath10k/mac.c:558:3: warning: enumeration value 'NL=
80211_CHAN_WIDTH_8' not handled in switch [-Wswitch]
drivers/net/wireless/ath/ath10k/mac.c:558:3: warning: enumeration value 'NL=
80211_CHAN_WIDTH_16' not handled in switch [-Wswitch]
drivers/net/wireless/ath/ath10k/mac.c:581:3: warning: enumeration value 'NL=
80211_CHAN_WIDTH_1' not handled in switch [-Wswitch]
  581 |   switch (chandef->width) {
      |   ^~~~~~
drivers/net/wireless/ath/ath10k/mac.c:581:3: warning: enumeration value 'NL=
80211_CHAN_WIDTH_2' not handled in switch [-Wswitch]
drivers/net/wireless/ath/ath10k/mac.c:581:3: warning: enumeration value 'NL=
80211_CHAN_WIDTH_4' not handled in switch [-Wswitch]
drivers/net/wireless/ath/ath10k/mac.c:581:3: warning: enumeration value 'NL=
80211_CHAN_WIDTH_8' not handled in switch [-Wswitch]
drivers/net/wireless/ath/ath10k/mac.c:581:3: warning: enumeration value 'NL=
80211_CHAN_WIDTH_16' not handled in switch [-Wswitch]

Introduced by commit

  e5cb3d34a66d ("nl80211: S1G band and channel definitions")

--=20
Cheers,
Stephen Rothwell

--Sig_/.B7c2JVw=ftB8qCCNoqRfTd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8jj94ACgkQAVBC80lX
0GwpQggAlIYc8PA64dXCF3vyS5ERU+iiVRgxymcQNPRfd9M3VRLR9OimA4vHqkwC
uQW8rxdQItirDyV1J/2UDhRwbNZxErRrH0dNcbSgHCtL9CAnnEgsveZqL1IM4jk6
qdy2nmtU5oPCVVbWNU7+KFbwlQqt3WzL5DnKLfdNlKbaZhfCTxZ5SXpzmJ6NMwHa
4URX+xvemqvO4+JrzBKwn7MoZ1b80ahs3dYtvi3cCRLhwQkPVvD9iOChAOqFXCbB
u73yPXhAk34rljH7A3LNtImrqA6UBS2z2QpP8QBEUfx0BCDeMe3esoIclfXnyzke
rDqp8ixDyOhzg4HaaTMfc7tln5NgsA==
=G8SA
-----END PGP SIGNATURE-----

--Sig_/.B7c2JVw=ftB8qCCNoqRfTd--
