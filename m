Return-Path: <linux-wireless+bounces-11045-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B56D949AF0
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 00:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5943BB21BCE
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 22:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC5916EC0B;
	Tue,  6 Aug 2024 22:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="uAHXZgtV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4A9158DC2;
	Tue,  6 Aug 2024 22:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722981872; cv=none; b=QfIko93/k4YSuCi3m/4xebQ3XW49UxnNCBmjvossaEWCQ1Duq7wWFXU4a2enk2/UYgSjaIdhbUiEsePY3sw3HB+btXQvJ0Ha8ZtX2l9uZjS6TOf9c1c+WfZBDRr7+DsqMaOPB7aVaYWkow51RMtR4Z0Ab7LOjbXvUjl9NBSsKPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722981872; c=relaxed/simple;
	bh=IK1yrsfgEjQIKVGGbWPMPH/rDmLHpfmvRvFqYw+/sCY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lCA8T9HP0E3+jyvwbfufWLqeFAc/5u18/DyTFfevjDLPLUcFAt24pdTmL6ouXzPNbzaWI+7vlik/HIM4SFInoWqVxSgDSkosPf+B7AqLFp6maeMlf2M9PCPSmy3LLI21WI0Tg8uKPgsihV/+ZoSSgl9ToUWjhMd5AC2Vu1+FYs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=uAHXZgtV; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1722981865;
	bh=x92JJMnksrdswWDvcf98xWpAg3P6+kdAl4wC+lFFrHM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uAHXZgtVb0Z4ejy+B3LsjhUjlogoyvcqzyDWBDFa3nO29n3YZlTLHgyRjUJDzpq8r
	 e3peacasSB4hCBFOGeirNTN3fKxDjtUv8204LaPlmsN3U6A4UiLsvRsIM44csbOSJS
	 TsAJ8ieB967NYpXUiq9qaRrnxL43CRr5XRdGNLu7WQWOgfOjbxFxDnElu3wzd3Dtot
	 bkXpMKV8ddY1Ah36CVvEpx8R1s5z4KeC2T7BtT/2Xj1Y+jh3SDY5krmoXIQQQA/LMu
	 UYpIZtKBHCS//YXtQuLSzG/qVMzhadu0TFlUnF/IC4HZWBWuhlJeHdPlU7j9qGRGsn
	 QpvQqGaGI5Ucw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WdnQd3RwFz4w2J;
	Wed,  7 Aug 2024 08:04:25 +1000 (AEST)
Date: Wed, 7 Aug 2024 08:04:23 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kalle Valo <kvalo@kernel.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, ath12k@lists.infradead.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: linux-next: request to include ath.git tree
Message-ID: <20240807080423.45efb506@canb.auug.org.au>
In-Reply-To: <87ed7163yd.fsf@kernel.org>
References: <87ed7163yd.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2Dxztpywhj4hqJGc_IHL1im";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/2Dxztpywhj4hqJGc_IHL1im
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

On Tue, 06 Aug 2024 18:55:38 +0300 Kalle Valo <kvalo@kernel.org> wrote:
>
> ath.git is a tree for Atheros and Qualcomm Wi-Fi drivers residing under
> drivers/net/wireless/ath/. Jeff and I are the maintainers. Over the
> years multiple people have been requesting including the tree to
> linux-next and finally we are biting the bullet.
>=20
> So we are requesting to pull two branches from our ath.git tree to linux-=
next:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git for-current
> git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git for-next
>=20
> for-current feeds the wireless tree and for-next feeds the wireless-next
> tree.

Added from today.  I have listed just you as a contect, should I list
anyone else (or a mailing list)?

> Because our for-next branch is very active one problem with is that the
> chances of having conflicts between the branches is high and that would
> be extra work for you :/ Do you have any suggestions for this? For
> example, should we create temporary merges for you or something like
> that? Just for this reason we do try to keep the number of patches going
> to for-current minimal and only take important fixes.

Well, your for-next branch should only contain patches that are ready
for integration i.e. reviewed and unit tested, so it should not be all
that busy.  I expect you may also have a development branch for patches
you are still testing.  Otherwise, you should concentrate on your own
tree and I will notify you of conflicts (and ask advice if the
conflicts are too difficult for me to resolve).

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--=20
Cheers,
Stephen Rothwell

--Sig_/2Dxztpywhj4hqJGc_IHL1im
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmaynegACgkQAVBC80lX
0GywuAf/a8+0nKxZXozMmMWGjZtvuHmORM3yJrjEFklRRq1SCSqf7pd4KADfJld7
38ihuNDqgtvjFFX5xvG5SFOYM3+s1jhguyiCAN70kKF/fV7WYa8Bo/m6jHuZuGta
cMcnuCZVVOFy0CZX5NqTYb0Kdqlu2S8IIq00CVa+SCr60PCsHrfMwYTYiu4LPNyv
Sw3qtDMvZw7+LjbOcvjl1GLW1xKiE6B1mZ/ylq7aqMs9rmZSpHho3y2SvfFRJLQ6
NPI38NojMzo9xL0lNTXS+cIF34YofOKb8jIlEDs/cWKvNJmAPgJZk+7N7CiY251B
EtdmdWuVwCWrXgRFKlfumCUlB1wSJw==
=e4jz
-----END PGP SIGNATURE-----

--Sig_/2Dxztpywhj4hqJGc_IHL1im--

