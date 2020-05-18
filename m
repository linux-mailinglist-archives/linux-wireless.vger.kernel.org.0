Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F571D7931
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2020 15:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgERNDQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 May 2020 09:03:16 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:46965 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbgERNDP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 May 2020 09:03:15 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49QfMN6SDLz9sTC;
        Mon, 18 May 2020 23:03:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1589806993;
        bh=2gvcFe7xk5po5g3UlIGKxvdmbLoE3llOYTT0e6mqOJU=;
        h=Date:From:To:Cc:Subject:From;
        b=lwFJT7u6BBGGPiufr4Ch9sqxg5yhP9wwR5EvlXf3HMSqrpt98otFcPxkc+5M1vH+d
         JXEExOqBCA0a5Oc8We+l+DfZVQM3fYELa4Ij4NJpJlcMMrANoE7dLJcDBWkhg0SMgE
         JJoWkCdDeQLFEf4S/Dh+iIlrdIUqd26PFcTPgGiM6Q8qG/aNb6PyzRbCa8RYqBB+w0
         bxkTFGGf+i6rkGgY1PFGxLQqmvE1uuHji/0DiqDPuSLUrRe5Kr2XddJ3T61Xs5tqIu
         oRSC2lPyW99VKaBdJVldE5ZWNvsDJIVov1LUCX1JZcYeeAFFI1GhcGZSAKkHS0PsXh
         /Atij/bRpXh0g==
Date:   Mon, 18 May 2020 23:03:11 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Felix Fietkau <nbd@nbd.name>
Subject: linux-next: Signed-off-by missing for commit in the
 wireless-drivers-next tree
Message-ID: <20200518230311.08df60cc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/J5hCWJ/AaAwOFDmtwxZtZ3j";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/J5hCWJ/AaAwOFDmtwxZtZ3j
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  89829c9e65ab ("mt76: mt7663: fix DMA unmap length")
  c0f8055b3986 ("mt76: mt7622: fix DMA unmap length")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/J5hCWJ/AaAwOFDmtwxZtZ3j
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7Ch48ACgkQAVBC80lX
0GxZpgf/drRAczBmtdwR2uQoY8jXEzxNb86cc6Xlv5/bkfWvmKoecA1MeP4h+WRG
dRKrNgOHIZXqZYzlgRPzUOfepwanJHFeMjchyu7e5qa3tA25J31Fqhys/g7Of/Iq
EDTD6z9fUadfJfpaHCAKEKyNKZ+C2NAUTuofGfJMJVBE77AAKOPCsfJW6+KxdwdK
pwZ0z1Eod30BRrqoZdg06thioLk8z597FuAaOBCzG6egIhvnh+PS3SiUWDMaG4bf
i66eVqorK6piiHOCXW+YErv7Nnqi5ASAQ/pcIkjyr0T5d7q8cxR8ASXvT9t/NISm
80X+yBlvGQzUmq/emPYQuBI99yy0qA==
=WpY0
-----END PGP SIGNATURE-----

--Sig_/J5hCWJ/AaAwOFDmtwxZtZ3j--
