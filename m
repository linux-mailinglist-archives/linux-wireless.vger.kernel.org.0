Return-Path: <linux-wireless+bounces-9981-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D952D9270C8
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2024 09:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BDBA28706B
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2024 07:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5158E172BD8;
	Thu,  4 Jul 2024 07:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5bBRKlw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC31757E7
	for <linux-wireless@vger.kernel.org>; Thu,  4 Jul 2024 07:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720078859; cv=none; b=Yohampc20AIWEXOmjAlZ3skUepTpp+/se+836EMsaOo2XIYTq/geKb7OxShPIjTut6aTam0I2XVHE2k7XEUcFFf9fZfzcr48kEtJQFYi8BRf2/BDMVqOO2aMvnll5fW/yDSbt4WzyOuw57GH9GPQXfLWKnzxCxy1RC5fUzEK6ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720078859; c=relaxed/simple;
	bh=P2X9eNg0zJhDkvS/0QSLrIv8VHwE96wJYW4/7sZgXtw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Hm/DSlU1R4JmrvPSTPmdxT1m+8d4puMqklG2DzxCECcjb7bO/6ldnh5q3pNhRa9+XqESv63uLV2Ch0im9w8qnh3frYAPIH1Darc5Ma5eFkzIeTg00DXCUkb1kQiv6wNjHb1GBi3uF9Fb0dR21iRxkzL0fbi6szh1HdxKxGbJB9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5bBRKlw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C567C3277B;
	Thu,  4 Jul 2024 07:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720078858;
	bh=P2X9eNg0zJhDkvS/0QSLrIv8VHwE96wJYW4/7sZgXtw=;
	h=Date:From:To:Cc:Subject:From;
	b=t5bBRKlwvSvdw00ufc9mNyP0HwCzQbzF6dHpPrqBMty4WX1SmGT0UvvuUBfxluqLK
	 5HdwIdPcLf17Mx77rAzAwhKMPeuCNioMPUMGAlbQPNUvEAkOpwnWZ4K/FqxwDOGoQV
	 S65dKZmg8BpYGQPD4nMmDXkB8bFExxehFKtMFBcCqs7hb3vhGY9Jxp6FaVxtSq+oi8
	 93JLaSHgTPVLP1gNXQcStIBAvZveTCtsxeUTzZV5Z6NkCTgjbPV8QysLWf4PIvbgvP
	 V9DXrYpM5NQlSwx8wBeBvxpUyx1Qwppd5HW6YDR2JneTWJP8fj/H2UUF8lenJAP+dA
	 sPAIAbKE+10Mg==
Received: by wens.tw (Postfix, from userid 1000)
	id 6D4915F882; Thu,  4 Jul 2024 15:40:56 +0800 (CST)
Date: Thu, 4 Jul 2024 15:40:56 +0800
From: Chen-Yu Tsai <wens@kernel.org>
To: wireless-regdb@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [ANN] wireless-regdb: master-2024-07-04
Message-ID: <ZoZSCJeyLpAJhtVU@wens.tw>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dg4fhU5SQzvHajUY"
Content-Disposition: inline


--dg4fhU5SQzvHajUY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

A new release of wireless-regdb (master-2024-07-04) is available at:

https://www.kernel.org/pub/software/network/wireless-regdb/wireless-regdb-2024.07.04.tar.xz

The short log of changes since the master-2024-05-08 release is below.

--

Chen-Yu Tsai (1):
      wireless-regdb: update regulatory database based on preceding changes

Ping-Ke Shih (19):
      wireless-regdb: Update regulatory rules for Mongolia (MN) on 6GHz
      wireless-regdb: Update regulatory rules for Saudi Arabia (SA) on 6GHz
      wireless-regdb: Update regulatory rules for South Africa (ZA) on 6GHz
      wireless-regdb: Update regulatory info for Thailand (TH) on 6GHz
      wireless-regdb: Update regulatory info for Malaysia (MY) for 2022
      wireless-regdb: Update regulatory info for Morocco (MA) on 6GHz
      wireless-regdb: Update regulatory info for Chile (CL) on 6GHz
      wireless-regdb: Update regulatory info for Mexico (MX) on 6GHz
      wireless-regdb: Update regulatory info for Iceland (IS) on 6GHz
      wireless-regdb: Update regulatory info for Mauritius(MU) on 6GHz
      wireless-regdb: Update regulatory info for Argentina (AR) on 6GHz
      wireless-regdb: Update regulatory info for United Arab Emirates (AE) on 6GHz
      wireless-regdb: Update regulatory info for Colombia (CO) on 6GHz
      wireless-regdb: Update regulatory info for Costa Rica (CR) for 2021
      wireless-regdb: Update regulatory info for Dominican Republic (DO) on 6GHz
      wireless-regdb: Update regulatory info for Liechtenstein (LI) on 6GHz
      wireless-regdb: Update regulatory info for Jordan (JO) for 2022
      wireless-regdb: Update regulatory info for Kenya (KE) for 2022
      wireless-regdb: Update regulatory info for Macao (MO) for 2024


--dg4fhU5SQzvHajUY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE2nN1m/hhnkhOWjtHOJpUIZwPJDAFAmaGUggACgkQOJpUIZwP
JDDUWQ/+Pw40TP5zFnePwyGJI1aoV/7KF02K86L1wAWLE7Kgzxw3QUya5aEnoLEe
akgw5cgFj5DkNpQVgjh9ur3dSlFD3X0TOiXCDh5pUGvS9iV7dGQKTJMQCjb7WQJa
x3Y4jE4o17oThrLH9oymbCQ9NUq0G18vHnY9kMSOoe7c1y2zgHlqrUsMay6xbkZQ
5QKZhd/+bRWqjCvyE1EwKO4yEQyya0ifCVvQoOHrA7YGq+Rclg4GVaKq5oR6jGP3
EX55sKK7PEL2rWU7t/6Ld7rp/l+u41crWgLiwz8SrXLtQROzGn9ier608msYmCGI
zmtEn4HKLrp9f1Pnm4gpIAEfBF4+VxCyO7u2szKKHF1aOogYJ0M+xRdxW9IYV87d
1cvmTONCtov/V7lWggpFtTmwcxOuajML46zjMe8fWnaFNFKZ+4aaHYEXMp6mosLv
F0C2jwhkOrpMpJ3K2jX+dTIA5/x/IHYBxgjUiI6xiKgjwPNgjbFWDqPRvcN5soCg
77NpU+V1YT/Ljc9hkIDMoVNJa8+680JUemMtJxeF2Anuv10FJV8CNsDc16w+wwHq
IsBE5LwdQbBnWoVOPGmCCbCzEbcztQsyUQsCiiietKRhjgLFecHWnv0bfoOT7l2L
4Lb6NdzZLFoGj0KvbBGxZ7rG2YAwJEfY5DBRQ0GgaLc+lbzdUfs=
=xYUY
-----END PGP SIGNATURE-----

--dg4fhU5SQzvHajUY--

