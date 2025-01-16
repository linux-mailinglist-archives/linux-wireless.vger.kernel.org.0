Return-Path: <linux-wireless+bounces-17578-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B28A13114
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 03:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 785D91889037
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 02:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D8274059;
	Thu, 16 Jan 2025 02:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="vJdFX+7P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60667082D;
	Thu, 16 Jan 2025 02:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736993299; cv=none; b=t8SarM61ijPy3wlHBL6Rt2QiEtkXFDhrc6Z6Z9Rc7H5VlHgGoU0XwoOzR6/Fga7CeTPEDe2b5JoAzcs8fRENdlVZQwder47kfxgUJr/Th7mu7ILRHHLdlaUYb+SpjSHeq5Tm/kXC4XhOBIdnFEXne7y8feHOfAzwqEIzMQdIq7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736993299; c=relaxed/simple;
	bh=dq25cu2CFcaEy0Sjy94dpa6TNJ5EsczGcqwiGw4b3KM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=cWAHF50nODKgvLpLEcMBgSFomfPQ0+yAgTKNQ/D3ajTeNz1zwmurXYxQMQrcR2PV3LmHfcQq7yhM+DEaHkj1zzm2Z+3ImMFc0zbBt6fa8h8jD0ZDvv+tWEZrz/yoHV7mAxW7g+E3Uzm9dOiUqk/jXFwYn+pCCgvEW7dh2u8/QCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=vJdFX+7P; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1736993285;
	bh=PPpDrhEzQh9Fo/crDUCNf6BtsRd8ABancL1Cmvc3SAM=;
	h=Date:From:To:Cc:Subject:From;
	b=vJdFX+7Pw4pmJjFbEzZ+w1wRoVnFmUIpuf82b/8mFrKEJfBC8rFDLTdfKEKTSzVm9
	 B7Bxy9/iirn2b7DYw0qY+pHz2G+KiBS2P1VmUhaBpdojsIIPs/UXr/ZbWOcElS3W3N
	 w+lv7Pr8W3zrJ79LoXi18Es7LJcA3qtH5hbZucTciYgyyUN8D0L4H/kB9p+v9VubvV
	 oykO2sxcO1Nlpas3V7/RgE9z1CTysYS98eEBZ+J65qnBEWxCTBmjDMx5JjrCpgJSKm
	 eWmgUfKTBUGA8/THWYq+A2RKCvKpDMh530qicO5/udvjSLKSyDaSLhd9qbO3V5I6lR
	 Q2cAljz43Lg/A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4YYR9123cxz4xQq;
	Thu, 16 Jan 2025 13:08:05 +1100 (AEDT)
Date: Thu, 16 Jan 2025 13:08:12 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes@sipsolutions.net>
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>, Ping-Ke Shih
 <pkshih@realtek.com>, Wireless <linux-wireless@vger.kernel.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the wireless-next tree
Message-ID: <20250116130812.6e6c7b3e@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CJABub7zUDeTb3IYWBzXz+x";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/CJABub7zUDeTb3IYWBzXz+x
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the wireless-next tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/net/wireless/realtek/rtw88/led.c:19:6: error: redefinition of 'rtw_=
led_init'
   19 | void rtw_led_init(struct rtw_dev *rtwdev)
      |      ^~~~~~~~~~~~
In file included from drivers/net/wireless/realtek/rtw88/led.c:7:
drivers/net/wireless/realtek/rtw88/led.h:15:20: note: previous definition o=
f 'rtw_led_init' with type 'void(struct rtw_dev *)'
   15 | static inline void rtw_led_init(struct rtw_dev *rtwdev)
      |                    ^~~~~~~~~~~~
drivers/net/wireless/realtek/rtw88/led.c:64:6: error: redefinition of 'rtw_=
led_deinit'
   64 | void rtw_led_deinit(struct rtw_dev *rtwdev)
      |      ^~~~~~~~~~~~~~
drivers/net/wireless/realtek/rtw88/led.h:19:20: note: previous definition o=
f 'rtw_led_deinit' with type 'void(struct rtw_dev *)'
   19 | static inline void rtw_led_deinit(struct rtw_dev *rtwdev)
      |                    ^~~~~~~~~~~~~~

Caused by commit

  4b6652bc6d8d ("wifi: rtw88: Add support for LED blinking")

I have used the wireless-next tree from next-20250115 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/CJABub7zUDeTb3IYWBzXz+x
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmeIagwACgkQAVBC80lX
0GyW7Qf+I+Ci4aadJ1YDY0r5cryldp039QRO6Utn2iwRMuMeE7KUz1ktbGjB75vT
9ghsZud1xJ57PvwUrbKeCP848164Y6cOUR15Mk86jKCLHxIql1KW3k9IpqOR6Tg5
R4c6Ks3nzOp5tXEejVqkRjZXPrwbFonXSUScLkGclLgH+SdOfFa0x1oBDgHAC2Tl
t/g8v8YNwo3873TOTTGkv9AZ4zAUSzh5YK04qoX3acIQt8YXCnrS7UB/d7trKcTw
/+spxcbLuiEVNmOQ67qD/i4R6Y8KwVYIHPc17Udc0mmUK/jjEIkU75f42KMqwUIZ
h4fxkcgRXcrMAGHknc70pvG9YPuiyw==
=mNBR
-----END PGP SIGNATURE-----

--Sig_/CJABub7zUDeTb3IYWBzXz+x--

