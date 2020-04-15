Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82A2C1A9018
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2020 03:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733312AbgDOBG4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Apr 2020 21:06:56 -0400
Received: from ozlabs.org ([203.11.71.1]:60505 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733298AbgDOBGz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Apr 2020 21:06:55 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4924240ZcPz9sSm;
        Wed, 15 Apr 2020 11:06:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1586912812;
        bh=N93VbRgWkP+7p9le9DrxWLyxRR0fhGdzDtwKbqMiNXY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tr5GK7dA3Qd+dTHalq3ZKHlsSI0/jteCi1bIsq87S5PF8Dm0QoVPe9CUDu7XlTbj7
         C0XR8lMeE/3+WIKJSs2gDtKpJal4iYRX3YWLkrotbT6lLMMrXMLBRgsEynmIFkXhFQ
         tV/qKdRNwktH3Z6uAIgIDLgiAkcx7fK12o1Hd9NHfuMUIOu/o82El+Ob8aZSiQ4h6R
         ylbxNErCgRQWYOkGhQfZzdUFgrSCXZ9l3Khuz+i+A+lGrU4IJ5YgMSgw+aC/jIKRoN
         vUVxm40nfhO9Iwpkxw80q6QQxPKolZvZiCTN3izuS+C7taekh6M5DUP43JzbYhaQjl
         O7JOH+t2H+CZg==
Date:   Wed, 15 Apr 2020 11:06:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Wireless <linux-wireless@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the
 wireless-drivers-next tree
Message-ID: <20200415110649.39e26be3@canb.auug.org.au>
In-Reply-To: <5b17fefe-f99d-2e4c-ded2-93fd3554687c@lwfinger.net>
References: <20200415080827.30c2c9c1@canb.auug.org.au>
        <5b17fefe-f99d-2e4c-ded2-93fd3554687c@lwfinger.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/EtE4TBJ0sj/5b6yW=ZpHMT3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/EtE4TBJ0sj/5b6yW=ZpHMT3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Larry,

On Tue, 14 Apr 2020 19:36:28 -0500 Larry Finger <Larry.Finger@lwfinger.net>=
 wrote:
>
> On 4/14/20 5:08 PM, Stephen Rothwell wrote:
> >=20
> > In commit
> >=20
> >    ec4d3e3a0545 ("b43legacy: Fix case where channel status is corrupted=
")
> >=20
> > Fixes tag
> >=20
> >    Fixes: 75388acd0cd8 ("add mac80211-based driver for legacy BCM43xx d=
evices")
> >=20
> > has these problem(s):
> >=20
> >    - Subject does not match target commit subject
> >      Just use
> > 	git log -1 --format=3D'Fixes: %h ("%s")'
>=20
> I do not understand what you want here. The subject describes what was fi=
xed.=20
> The error has been in the driver since it was merged. The Fixes: line is =
a=20
> description of the commit that introduced the driver file with the error.

The subject I was referring to is the subject quoted in the Fixes tag,
not the subject of the fixing commit.  So:

Fixes: 75388acd0cd8 ("[B43LEGACY]: add mac80211-based driver for legacy BCM=
43xx devices")

Its not very important, just a consistency thing - I wouldn't bother
rebasing just to fix this, just for the future ...
--=20
Cheers,
Stephen Rothwell

--Sig_/EtE4TBJ0sj/5b6yW=ZpHMT3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6WXikACgkQAVBC80lX
0Gyk3wf9FQAMSjeEO5pTA/utCKN7T+qLef2SQ1Z9wmAh+MfY93X1DdOOwTYe+ekp
HWr+mpM6g2W6nPnyJ/rVyg2FPldXwQ/KWQ5Nk28K9ic9E2i7fLKX9lP9Hg9gs7uf
cPlfulp5/M5YCQ8MChuEnf1zPOJl2mmq4JP7BCzNi9eTKhY3L9mt0R22/kVWkYVx
v+9MID8ZD1vrYmz9pzQTufWxyKLpRJZGlIdjZvfEnWsM1FTWUX9fdmfo1vzrdMRJ
cTh6WwCQDa5GSYxHhcFfUEqK22NrWa9gG2ZRre2LIObdodrBaZ+GgtgvRdc5x8yV
5RhCDelxcFPT99iUbfJvbdIzUbLu2Q==
=ospa
-----END PGP SIGNATURE-----

--Sig_/EtE4TBJ0sj/5b6yW=ZpHMT3--
