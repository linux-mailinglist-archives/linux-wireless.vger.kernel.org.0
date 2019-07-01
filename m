Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D47CF5C506
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2019 23:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfGAVdR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Jul 2019 17:33:17 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:59671 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbfGAVdR (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Jul 2019 17:33:17 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45d0wV0qB6z9s8m;
        Tue,  2 Jul 2019 07:33:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562016794;
        bh=2Hj7vKCK5VJUw//FnwjqKlrsQfYRnMAyUvxcTDPMICM=;
        h=Date:From:To:Cc:Subject:From;
        b=KEhrJWQPR9DHU/zh5QTIZLTeJazn2ks09IWHYECeQSPtJ18zfqDU25SapAIkP9l5z
         t/x2V4s+Z1lZYFHa0j2xTMrx/9HLZwYUZSRzgbTFpz+3KOevFsdWlFpXB+o6B8NPjX
         4/E8+Lkfl4KY35zF1zM5+hvMGmisiYIpSKJl/4VEhAiOWIBBr21z00CTdJ4kuRJsYt
         O2EM4Y2P2HhKVpjSBlSAjrfhSIJHT8mSIvnfwpEk7iFh6zg35OTrgWMRUXqRo1f9Kn
         1AgCBOii0IEd3mKVUKb+FF/BDQuSS1788Dw2aXByQxIJXMlp7GHH8LVor/8DhOSFcG
         vz+UViDpYjlJg==
Date:   Tue, 2 Jul 2019 07:33:06 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dundi Raviteja <dundi@codeaurora.org>
Subject: linux-next: Fixes tag needs some work in the wireless-drivers-next
 tree
Message-ID: <20190702073306.3bd439ab@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/wLuOVOKTF0HYp0zZKauyHrx"; protocol="application/pgp-signature"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/wLuOVOKTF0HYp0zZKauyHrx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  c709df58832c ("ath10k: Fix memory leak in qmi")

Fixes tag

  Fixes: fda6fee0001e ("ath10k: add QMI message handshake for wcn3990 clien=
t")

has these problem(s):

  - Target SHA1 does not exist

Did you mean

Fixes: ba94c753ccb4 ("ath10k: add QMI message handshake for wcn3990 client")

--=20
Cheers,
Stephen Rothwell

--Sig_/wLuOVOKTF0HYp0zZKauyHrx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0afBIACgkQAVBC80lX
0GxElQgAnv/zBAAvzc/VYVnJVODY5e078yQnunyevK54QBSVNYpsNcVkmsrgOZwJ
4VTPSMiK7j6/xIcXP8mqfPvHq2gh3025XvD+7Le7J7p1JAUrEWWeXSigVJf8o1jA
Qr1ztZzBcB98CHDyHanCxlWkngkJ4WzjZEZ5SZ6aAjsxk+4UGK7f6vJWh9rcgYGH
D26n0DCjh5zzW3rzeKJKlZAfRQx6wcw8haGsC18rlOWUFZTSQuxZFsqC7bKBo9lM
x9exupOHNMsQ7e0fNkgj2O38rsa3LzSq7zQVPTRlxOosxqkiCCYoj0A3VnS7mgDf
dik68rts8oDRqEF9TzfaTlLOwA4J4w==
=aM/W
-----END PGP SIGNATURE-----

--Sig_/wLuOVOKTF0HYp0zZKauyHrx--
