Return-Path: <linux-wireless+bounces-19184-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3A5A3D4B2
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 10:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BD263AC31E
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 09:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C821EB189;
	Thu, 20 Feb 2025 09:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLVrPjdQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD6B1E9B38
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 09:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740043718; cv=none; b=HFjuJoKaA4kmus5C4hp3XNBur8Ln8Fw2B20n+nb7utsoVMHBwfCLWaa3MIID3D/5Pb0kzvZswDD6muiiNkyvk6uN8z+S4NzLNcMfRoyURzXfkRG2VLUxuQfH4CsIF/ZLemG2vo7T9/0O8DrIZ6NNtwe8EnbnB2o1kfTGjwn3cG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740043718; c=relaxed/simple;
	bh=RB3tFdguX7UtV79sH+013wQUHHZUCzCes9I/9xq1P4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ofB0YQ/u0MZFGMmGOTDIU8NL4Zu1W50ZRyRhI72a54QP6tRJgDQMPGNaZ9B5PtX/GX0nm0Kt3FhV90cUdtIOEIAUobqxfmnkqOmePn0uCLxG36NMlIADdDdOq1qYCMj0kV0x68MRZE0+EUhgfDPM7zCL5eih5ahr7XJfDke/9wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLVrPjdQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5760CC4CED1;
	Thu, 20 Feb 2025 09:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740043717;
	bh=RB3tFdguX7UtV79sH+013wQUHHZUCzCes9I/9xq1P4Y=;
	h=Date:From:To:Cc:Subject:From;
	b=XLVrPjdQtf08j5fhCinjPQ+lcwhgFw3Pzq4YdX3EXGZ14fNUG/JBmkLbYOZiaOAim
	 i2w+Rfh+7r+53oxmZlp0CaxsFyhaSB7jnsU6QyW2Ei+J5QnDYZhAaWbRtlFoT/5ZJt
	 h1+BBctlolUrZpoROLD0M3nJLYUhlbA+mqEAnY8H2imFM0I3BGGwfB6swL8msOnx02
	 Dvn8Wv5/EOX2xYOY+2OrgUia7nYjQreyM57AbVfIBzQ9KVBn/rZP3uDBw2TgNhSjvq
	 jQYcZTiccOmrs2NsAiy08T2AsvyjvjPyMb2CbQTlMEaFzGB0z1DeTzbRiSQiQvaV5I
	 4gOSe65SBzqTg==
Received: by wens.tw (Postfix, from userid 1000)
	id 0F33C5F74F; Thu, 20 Feb 2025 17:28:35 +0800 (CST)
Date: Thu, 20 Feb 2025 17:28:35 +0800
From: Chen-Yu Tsai <wens@kernel.org>
To: wireless-regdb@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [ANN] wireless-regdb: master-2025-02-20
Message-ID: <Z7b1ww9K1kNUpMaW@wens.tw>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/JWyjuPuuT6NUC2C"
Content-Disposition: inline


--/JWyjuPuuT6NUC2C
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

A new release of wireless-regdb (master-2025-02-20) is available at:

https://www.kernel.org/pub/software/network/wireless-regdb/wireless-regdb-2=
025.02.20.tar.xz

The short log of changes since the master-2024-10-07 release is below.

--

Avgustina DiPierro (1):
      wireless-regdb: Update regulatory rules for Armenia (AM) on 2.4 and 5=
 GHz

Chen-Yu Tsai (1):
      wireless-regdb: update regulatory database based on preceding changes

Jakob Riepler (1):
      wireless-regdb: Update regulatory rules for Austria (AT)

Ping-Ke Shih (9):
      wireless-regdb: assert and correct maximum bandwidth within frequency=
 difference
      wireless-regdb: Update regulatory info for Syria (SY) for 2020
      wireless-regdb: Update regulatory info for Moldova (MD) on 6GHz for 2=
022
      wireless-regdb: Update regulatory info for Azerbaijan (AZ) on 6GHz fo=
r 2025
      wireless-regdb: Update regulatory info for Oman (OM)
      wireless-regdb: Update regulatory info for Cayman Islands (KY) for 20=
25
      wireless-regdb: allow NO-INDOOR flag in db.txt
      wireless-regdb: Update regulatory rules for Iran (IR) on both 2.4 and=
 5Ghz for 2021
      wireless-regdb: Update frequency range with NO-INDOOR for Oman (OM)

Robert J=F6rdens (1):
      wireless-regdb: Permit 320 MHz bandwidth in 6 GHz band in ETSI/CEPT


--/JWyjuPuuT6NUC2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE2nN1m/hhnkhOWjtHOJpUIZwPJDAFAme29cAACgkQOJpUIZwP
JDCFAxAAkCsd/krTuUlN6FqZzMZmgqWtaLEmitSWEUmwdyPILm/nc4E36VK2JBbJ
Wc0MFca38EIpwqT8AEqL38Qg2xb+MiIVdhcRVFGJ5CSLW66HcbZXHuo5W/recOXr
03SVh4HgWfvH5DLS5bVdo5euQeTVK+C9w2W/PiKe+hqJGTM0MOOoia4eEbKv4Zdb
/aE3gwlAVIZQQJRlE/76TcopJUbElEBp741zUTcVNaFP2z1DiYv/ItgPOMQgnOO9
uxicURYiB+/wzqTbv5uJYdP+V7oCO4pHAsCOvRfq0P/NNrNo9S+a+4cU8vFZ0BOh
cnCs15mz86JjzQB7zQU+s6KNPNkAjLhV+6Q39WCZYCQ72W4MlIIjDiqASij1N3uE
s4R6g458i49SQUJNIo3EDNAoaJ1ihG0TT2N+H7puTMXs4zLRbjlF4NaY17INO0Jx
QbGYW3op5oxvtDNjvmG0kjP4a0KluB2XW4DktIYtAGUdVQUMs89MT7xspgSAdhv6
0AJ76qV0uSCxfMenrilALOQBby477eqBM821PMAV7GauN8jF0Bw8xDi+Q8xvVxV9
nkCvGBz+cTAkEMYgFvGn01QR9J1wje6gPZ+ZaDDGqDQUn0YNsu7TnEYLC1lr/J5d
GltBG+V001EXvX2+tMhw/mbcaOUSvf8cuFVXtAcTDf7MXUdssiQ=
=alRR
-----END PGP SIGNATURE-----

--/JWyjuPuuT6NUC2C--

