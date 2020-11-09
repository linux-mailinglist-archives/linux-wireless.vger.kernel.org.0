Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD422AB0EF
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Nov 2020 06:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbgKIFnu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Nov 2020 00:43:50 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:32799 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729192AbgKIFnu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Nov 2020 00:43:50 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4CV0Kb0PBRz9sRR;
        Mon,  9 Nov 2020 16:43:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1604900627;
        bh=bdmK5a+s1ofdbJThE3emUJNk5Im4+gY52NQ5p7IHJVI=;
        h=Date:From:To:Cc:Subject:From;
        b=p0QqsG7mMqWogtebyRwoBlkMZDVOYTCDGToE4q5jZ5nrJRU/2d+g5/8f5BzSOdwkj
         NJT9B8Jn/nuD0CQysKS72yo6OCaAa0KXA9zbBrP4KpSPVb0J6Jpf/8TCq1sAOpYsGv
         Okk04VCzUiQjCp8LekZZo+EE9lh9CFxZtB1zzOKZ8oq5TrWi76zk7/ongqRJ20I2Ug
         CUIr0er4u3M76hqtgpx9yXOldfQXISAXH5FptME8wWlV49JF/ztJkfx2rTkNII/rL1
         DU/CbQiU/bwSFPUuBaMeMo3Y07x4ybYzETQr8F2WCmV4bOn64LWWdFQl0j3TejmXpZ
         bpUmCVjHbTxpA==
Date:   Mon, 9 Nov 2020 16:43:42 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Jouni Malinen <jouni@codeaurora.org>,
        Rohan Dutta <drohan@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the mac80211-next tree
Message-ID: <20201109164342.1ff7d645@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4IvFbDjLaS5wDh7Zg6I7zEU";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/4IvFbDjLaS5wDh7Zg6I7zEU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mac80211-next tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/driver-api/80211/cfg80211:48: include/net/cfg80211.h:1014: WA=
RNING: Unexpected indentation.
Documentation/driver-api/80211/cfg80211:48: include/net/cfg80211.h:1016: WA=
RNING: Block quote ends without a blank line; unexpected unindent.
Documentation/driver-api/80211/cfg80211:48: include/net/cfg80211.h:1019: WA=
RNING: Unexpected indentation.

Introduced by commit

  9f0ffa418483 ("cfg80211: Add support to configure SAE PWE value to driver=
s")

--=20
Cheers,
Stephen Rothwell

--Sig_/4IvFbDjLaS5wDh7Zg6I7zEU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl+o1w8ACgkQAVBC80lX
0GzYEQgAkNqGxCkNfnaKrgJ8OnfYk3GNyUDICG6G84LOZloo8fFez/7lMqAxSHbH
QSJBQjH1oFwLaeUqIXo7tKa4kDxoN5ETK297OE5E5aSxZh0o9UFIwpcXmmYlMSjR
h6DNVJjahuPIyYI0GMOjuEwpte/6+Ol7JI9SxV9nt7M/0xx7LxIxWBtdwUYvV+7g
WmbkGbz5YerIch+N0ZqfDYtjCSMYHwqbP6/YzUZeQxnDJeCoxV85oV5yTRjHKGy2
Lpg4V7tp5bO01kMABqw+e3MSCrneVwV5B0fY7STxDCmokc74liFi1lLMf6eKvKeZ
EC0qo4mP0yA6z7qYuyj501xencNDgg==
=w9IH
-----END PGP SIGNATURE-----

--Sig_/4IvFbDjLaS5wDh7Zg6I7zEU--
