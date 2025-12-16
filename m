Return-Path: <linux-wireless+bounces-29825-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A48FCC5569
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 23:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 711413007C5D
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 22:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869BF32C337;
	Tue, 16 Dec 2025 22:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="d9LktwgK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA2C313522;
	Tue, 16 Dec 2025 22:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765923810; cv=none; b=uG1DAeK9DcFgLlkSmr+o2aVi74bzHA8GU3wV5lYSL+4AN/xQwxXR39WL8JgjfanwEy/Lph8KipUTjyJoEQVI/h/pYy/wCTEJPxRJ9YCww7Uum5ZzQomncqaNLJOdEeyhlypJzmVglGuuMApicvwpzqgC353kgV7XNsk4T8JF4EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765923810; c=relaxed/simple;
	bh=S4t/BQXK/XSxRQzhdtDLyWri75icKGAYOUE8BKgkqD4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=J7i+FmaYzSye0mUP8m6zkAzeUoT60fGxywPWxKAprfiLGP8JINamMPHIJxn+LEvhmQsq1hPWYTEELfAxuAdJ1xCzWXX3osqyVEAqzsC9e5YUPIjWez3IkvWgOziEDU/tYVAMi8Yn3vpT4Tu6RCpo6vgskqUIWH/dMpkHDt5oUOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=d9LktwgK; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1765923801;
	bh=hUFCr1fRUm6Y410L1xsyecOPYyfQPhyugXaJeGwfSxU=;
	h=Date:From:To:Cc:Subject:From;
	b=d9LktwgKzmJL47ODPrq8LpwnBhOPH+u0zjXJxcY/IgkNdJf28HVk5bu9sLnRpBI4w
	 cUeOcI1SoVhB5AcxZ/X9vqHBQqKDwzzmGOXm9G0+F5tyKlBxS6tb5M3W2N++kwIEBa
	 qwuZrZB7SiVB6O1lDGTiAcIUNj048AGUgB9JrJx/5BUdsOH8ILBU0fO/wHB6xEcr4r
	 0wPVrn346hP6i2zv4gL2gAYEHevcX8ksD4Dp5dYEA6oamvCWQrBxLMPoP2zCdyxCXb
	 vY2yalbnhh+dpQFCxfLxViyPFmu3s8HHlaDWcuPdQ5iR61j5YTepSlwvjBsFANXnVl
	 92HGuHEeKM+LQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4dWBK46bdJz4wDt;
	Wed, 17 Dec 2025 09:23:20 +1100 (AEDT)
Date: Wed, 17 Dec 2025 09:23:20 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>, Johannes
 Berg <johannes@sipsolutions.net>
Cc: Wireless <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the iwlwifi tree
Message-ID: <20251217092320.6f487a4a@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zShCCD1lllsPKTzq46cByeO";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/zShCCD1lllsPKTzq46cByeO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the wireless tree as a different commit
(but the same patch):

  8943c0146834 ("wifi: iwlwifi: Implement settime64 as stub for MVM/MLD PTP=
")

This is commit

  81d90d93d22c ("wifi: iwlwifi: Implement settime64 as stub for MVM/MLD PTP=
")

in the wireless tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/zShCCD1lllsPKTzq46cByeO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmlB29gACgkQAVBC80lX
0GySRAf+OGRdY7T5Vfk9OCPnvETzcHvljclc6E7dcbTg4br8tR9LDKGnXSgUqUqV
rAtlzvNM9B+kLD7PzsutAJOjaF/DnNy/0E6oIOMVWhu/dveKjLbxK4rDbjWc69mj
8fL/48neLT6LFJqilaoeVXJRVGjOAz7rGxv3gATR8OIBr1+pCiVi6mxgO6WgGIz7
YgDKiOpIriFUJN0wdsqTO+658GlNWH8A9WInxUfvF4swqDh3SPnTMU0ZVEA9Pgr8
A2+vk1aLHpooNo+fuxiSAcFy04gyOrvjgEum77XvcWJwUj37HYrGnhjLj5NNObxL
irsfgMum+n6SPyOu9F30xVrLHzazBg==
=IQOs
-----END PGP SIGNATURE-----

--Sig_/zShCCD1lllsPKTzq46cByeO--

