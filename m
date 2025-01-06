Return-Path: <linux-wireless+bounces-17107-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C68A02439
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2025 12:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 873F93A14C9
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2025 11:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEE518A6B2;
	Mon,  6 Jan 2025 11:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="nGTwpF07"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F8A1DB37A
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jan 2025 11:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736162576; cv=none; b=X81kJDqt5ubyJPsGKwdWn4R/mb7d1ZcRMelYVqCUXPvrkZTNRx3IwtC93BcAuBir0NUqskpNvM3jIo/KYB+930s/179zZQJ7SzkeQFxa3QjqbpP9/gpYF7xJR7b2SK5SW+CNc1DcHBpD5mUc/+pm51tZv1SagxqzODTcW7V99RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736162576; c=relaxed/simple;
	bh=VHAw3IOWU2pVQHIX8eGIFaMq+DLfGeNsjhZZVZoacFI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YiEebXlQbleg6+qboe6F5cfWDzHBoDTbc+qvjBw18URzxQN15+iOHlN5/etp+vcnoUCnTVmB0EPwWGIuhQZka/vzDaOkRG3P9s+VloTnZVm2uXTco5sgYMwRy5QjsCPkVpTS2iJnVNQbqbvj0uDTZeJnPm3Qe9Dr8hZaUW5LJRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=nGTwpF07; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Type:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VHAw3IOWU2pVQHIX8eGIFaMq+DLfGeNsjhZZVZoacFI=; b=nGTwpF07/I5qOEgvstIMSZYihF
	aJA3Ig6HFtsuEC3juYnC3IG/y3ENnwguN1cIowFq/W0xHjLxRqMYuQHhB3ebw1+M7M35IpsGUkBB3
	V0UfpKhKA29vP5tY/LdXwwdz/wsUvZZlCNB2164DHj8Ei8P1Gw532TgMtZABt5n9B06hJVdbPP3i4
	2e/K9FQpanPxVBk216W+7cDQ1F3q/wjt4D/7xT7GtZ6kDqCPgEHLquYPF6sMYc0bN4fTWe9Wb4w1n
	ReCcyceiNl7A7UZlOeKy5Xn+HYE6KmsJdbYD6K6ck3Uw+jPbzPr4BN6BTKLJ3FJyQZQftpQ8Ip5Yj
	tNt+7NEw==;
Received: from cw141ip135.vpn.codeweavers.com ([10.69.141.135] helo=grey.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <stefan@codeweavers.com>)
	id 1tUlC9-0045wL-2R;
	Mon, 06 Jan 2025 05:22:54 -0600
From: Stefan =?UTF-8?B?RMO2c2luZ2Vy?= <stefan@codeweavers.com>
To: linux-wireless@vger.kernel.org,
 Arend van Spriel <arend.vanspriel@broadcom.com>
Subject:
 Re: [PATCH] wifi: brcmfmac: Check the return value of
 of_property_read_string_index
Date: Mon, 06 Jan 2025 14:22:29 +0300
Message-ID: <4619776.LvFx2qVVIh@grey>
Organization: CodeWeavers
In-Reply-To: <058aba76-817c-480a-9404-38b030325890@broadcom.com>
References:
 <20250106103749.5764-1-stefan@codeweavers.com>
 <058aba76-817c-480a-9404-38b030325890@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2351663.ElGaqSPkdT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart2351663.ElGaqSPkdT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Stefan =?UTF-8?B?RMO2c2luZ2Vy?= <stefan@codeweavers.com>
Date: Mon, 06 Jan 2025 14:22:29 +0300
Message-ID: <4619776.LvFx2qVVIh@grey>
Organization: CodeWeavers
In-Reply-To: <058aba76-817c-480a-9404-38b030325890@broadcom.com>
MIME-Version: 1.0

Am Montag, 6. Januar 2025, 14:02:17 Ostafrikanische Zeit schrieb Arend van=
=20
Spriel:
> On 1/6/2025 11:37 AM, Stefan D=C3=B6singer wrote:
> > Somewhen between 6.10 and 6.11 the driver started to crash on my
> > MacBookPro14,3. The property doesn't exist and 'tmp' remains
> > uninitialized, so we pass a random pointer to devm_kstrdup().
>=20
> By the looks of it this is an intel-based platform. Is that correct? So
> does it have a devicetree? I would expect the root node find to fail,
> but apparently is does not. Strange though that root node does not have
> a compatible property. Anyway, the analysis looks sane so ...

Yes, this is an Intel based MacBook Pro - the 2017 version.

I was curious about the same thing and tried to find out where it expects t=
o=20
get those properties from. I didn't find a definitive answer and concluded=
=20
that it reads the properties from somewhere on the wifi cards ROM rather th=
an=20
the computer's firmware / ACPI Tabes / whatever. If you can tell me where I=
=20
should look I can see if I find out more.

If you think it is helpful or might point towards deeper issues I can try d=
o a=20
bisect for whatever patch broke this. I vaguely suspect though that it was=
=20
always broken but by random luck a NULL pointer happened to be on the stack=
 in=20
the right place.

> No need to use 'err'. You can directly do
> of_property_read_string_index() in the if statement below.

Check, I'll resend. I found both styles in use (though admittedly reusing=20
'err' to print it to dmesg).

--nextPart2351663.ElGaqSPkdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEQxb0tqoFWyeVMl1sPRO8yFRPGiIFAmd7vPUACgkQPRO8yFRP
GiKvKBAAlAPoQZyBDlsyeegTJUGlIEbfq7Kdl+zwWmtZD6BVghaGiOyunPwqYwpZ
AfWoDvLlHOS6JuQZo1PB5fQAd4FibHUHOnqisxGTRajgVh0L7EXSaGE0pfXKt/Jb
Iyiu96cccASKuaduD0kVWKU9Z43P2Pbap2wVC336ae8SBFFYoBlJvqwnGvSVBMDR
WqsYOs2uhRgJlf8Ei/s3/gFMCAwCwnee62gMUuzeCbvM99TlCxdJGwcaDxCzWFl7
LvHdCorLtRxvCq0FNUGbtV4f/ciDoDV4AxWEU4dbVJKs8Bqg2Np7+N/1//ePEkyo
BCBkCwCwK3bVQfAhPC2tDUUyk/Y/5w7fdS9r5CCwtJx/PozP0dNO97l0RifhUa0I
O/irijhNcl6rD3SUXqCx3F14LT4ZgbXWJPsMu94Z8FF74STvaOiyMV7oeE4qngd3
mmMj9YuRCGxMIzRUFfBYMrP0tWH5Ht9IeBjRsQ2PadJlFVXc7J/I1snlx5sXruLu
2SUnMoPceKv97J4HkXW78R3y3Ge6kt5ObT381nHWVgr4VfwKlahENNsskL6P/yRd
qwwAXd+17e6ga9zC87/OEuzlxsnMQ6CMgIqfoHtjixjC7kEEFVZdkNK9GT8rjLZ1
3AOcsWQ0iZO1c1AfzyEF5W0k9Qt6k/diMja1SDwRShGFgI+F1lQ=
=Tjzd
-----END PGP SIGNATURE-----

--nextPart2351663.ElGaqSPkdT--




