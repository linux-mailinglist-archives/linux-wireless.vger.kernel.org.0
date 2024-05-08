Return-Path: <linux-wireless+bounces-7325-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4594E8BF4D2
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 05:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAF941F257DB
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 03:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C0C125AE;
	Wed,  8 May 2024 03:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udqOH7L7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5113C12E6C
	for <linux-wireless@vger.kernel.org>; Wed,  8 May 2024 03:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715137344; cv=none; b=FIDyoOK085abhlcwdowlsUTbwbfQkdQI0UVfeeVMBc6PCdLUt7f0hSsNw5dCEkmiah4CWzH4Fm+2f3/44uae0OV1Ytj2Xya2NJeV8tgWm3EOUFUpk7mxLCPQyv8JYgnV7M455i6OAn9aa3gnjJJRAVq9YauJHC2x6OuS68bqM/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715137344; c=relaxed/simple;
	bh=90oJydsi78W8YIejrIj/zbsBZsNZoeGC4uJZLq4O3Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Roxf9b+YfTbT98gvWYGva71+8Xgpt7EaahsNyHFw9IJv1LGrnu4qOWEgL/U0S8DCOkA/UPTUi/Nczj+gIwFf/cSLgVTx/TULKQpKBH9+nFGaS1VdaXXnXdxwe3hW6lKYHzIuqcqejRwd3+APn0u7hm7AjbbwR/O85P9cj7bv3Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=udqOH7L7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0E7C2BBFC;
	Wed,  8 May 2024 03:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715137344;
	bh=90oJydsi78W8YIejrIj/zbsBZsNZoeGC4uJZLq4O3Uc=;
	h=Date:From:To:Cc:Subject:From;
	b=udqOH7L7nh3uOT+qRVL3GJ9fsEQSLnQz6H6dvvYbzifWDoMPzvpIv45a1yh9Lxqdi
	 ddOiedhOZwU4BQWUMAr3dZJczzOtzFOMdqWoQAeyZKQp0rg7cja7dULbZLk3tzDquj
	 PYPA4AzLwez5sYDZDB3H/IT0Vxa36QGixLZFUdzfVvyvefb7tqGxanEMnq7QZjN5ju
	 AkrVGMqPNhrx7LmoO5FQWhZMM2ePe2PhtPu6BYdup9foY9q85s+hx35NFUcwhIuXEv
	 murIBfhwzpXrQz0UIHL0InCwU/bbxq6EFgUiv6p5QhA2ZzA3GYlvzyiJWl4/T78+lT
	 knENrvEYUQt1g==
Received: by wens.tw (Postfix, from userid 1000)
	id 136CB5F9F2; Wed,  8 May 2024 11:02:21 +0800 (CST)
Date: Wed, 8 May 2024 11:02:21 +0800
From: Chen-Yu Tsai <wens@kernel.org>
To: wireless-regdb@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [ANN] wireless-regdb: master-2024-05-08
Message-ID: <ZjrrPdr1WBCEd1oI@wens.tw>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/PxTT5WPElcuA/tU"
Content-Disposition: inline


--/PxTT5WPElcuA/tU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

A new release of wireless-regdb (master-2024-05-08) is available at:

https://www.kernel.org/pub/software/network/wireless-regdb/wireless-regdb-2024.05.08.tar.xz

The short log of changes since the master-2024-01-23 release is below.

--

Andrew Yong (1):
      Revert "wireless-regdb: Update and disable 5470-5730MHz band according to TPC requirement for Singapore (SG)"

Chen-Yu Tsai (1):
      wireless-regdb: update regulatory database based on preceding changes

Deren Wu (1):
      wireless-regdb: Update regulatory rules for Taiwan (TW) on 6GHz


--/PxTT5WPElcuA/tU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE2nN1m/hhnkhOWjtHOJpUIZwPJDAFAmY66zwACgkQOJpUIZwP
JDAvDQ//f6Uhz3m6tv4poNGgnQSYb1ed9y/p5lVV6uwHKz7WoLrgqQue+CO3FZxM
AxEzaPszFLZZTWQNRhC8HW1oqkWC9mw0Z+XXRTkgzDArFZa+TmNpd9aGKSuYt5C1
Grxn0JRnsxGQQrc7OwRL6MI6XYmffi8HMWzJFazIU9MDNXSfdLc7tAE+agYyIHfi
BmEDjWvDzI70wegoMVUqS/0cBRr+czAPEexFQzxPKfdQXtOHj5i5/6DXy3t561EG
5J8ucjs4PZnTS7/+Nrhl83nyOEvR8JgHI2Xd9Y7DZGLTOtKfxwDQR+5COa9yfJTi
gich2ALiZ1Kr4ABJjN1mhjxNrPwy/H69ZWuXX8yrpH1giTXJgJAMbbMYyUMbHDis
a9+Et35UOO7uVs0rOh25U4hArnn63ij9g6Ke62LCgKANMmy/ljRdneNT3Ga5F3oe
IVO/00NUc2pO159S4SEEcnD4/yETgRoDEyu2CT7RKH+DQWzHRKBHruDOwIOCCU4L
7mg1jp0gA2Oe8z7v2rFfYU7qrePU9bvR6Xgf9BbngDcv4INQU+anBzjaUFVENqTJ
m//XZMJ9/lTQToeKJqwSYFFURLVlLHsS0S00y81IesjTYis70bWEjnCmdUGN6Na0
MTm7VrcNEOidHEbdzO+WJZhB9xuAME9fleCF6ot8NJwrkT1HFAs=
=p0VT
-----END PGP SIGNATURE-----

--/PxTT5WPElcuA/tU--

