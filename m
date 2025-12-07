Return-Path: <linux-wireless+bounces-29571-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 856EDCAB8A2
	for <lists+linux-wireless@lfdr.de>; Sun, 07 Dec 2025 19:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F27130141EB
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Dec 2025 18:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288862D3A9E;
	Sun,  7 Dec 2025 18:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=sapience.com header.i=@sapience.com header.b="SeFbERYr";
	dkim=pass (2048-bit key) header.d=sapience.com header.i=@sapience.com header.b="kzn0TRak"
X-Original-To: linux-wireless@vger.kernel.org
Received: from s1.sapience.com (s1.sapience.com [72.84.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61A62E092E;
	Sun,  7 Dec 2025 18:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=72.84.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765130745; cv=fail; b=lHR+9UHPGmTDPNTlVefIQn9txyJdjekvQjbnsp9Oq1u+WHklGmrsjApLC9G0YyCwGkxRZVWvwrLuOXRInSe7mObqDOJ97SoGld67hBoThaSmA1BurtBTQvNADOi42xWBaSWR95E5TK9pNwTeVLwavRDPIAJMqXg2eZ+CKWS/Z+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765130745; c=relaxed/simple;
	bh=Q++gC+3ioqzZHPSBkqfCwWrV7HrOUBqS/RobES8vUtw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uALjX1B77Ep0xKoshFRNS+CUgQ7VJ5dz7EM5QYRUvZ4dVV2XRLzu1JdInynFwZ68lvNxlRuwLEJAggVRN+M1tMa4xxB6gLddscE4huUXfiI4HYgm7gfxMKUX/mKz4cqCH1QhB7RDcGL2Xax6GZxUZnOPWV4EbNHy8/ZeJkH6dl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sapience.com; spf=pass smtp.mailfrom=sapience.com; dkim=permerror (0-bit key) header.d=sapience.com header.i=@sapience.com header.b=SeFbERYr; dkim=pass (2048-bit key) header.d=sapience.com header.i=@sapience.com header.b=kzn0TRak; arc=fail smtp.client-ip=72.84.236.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sapience.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sapience.com
Authentication-Results: dkim-srvy7; dkim=pass (Good ed25519-sha256 
   signature) header.d=sapience.com header.i=@sapience.com 
   header.a=ed25519-sha256; dkim=pass (Good 2048 bit rsa-sha256 signature) 
   header.d=sapience.com header.i=@sapience.com header.a=rsa-sha256
Received: from smtp.sapience.com (srv8.prv.sapience.com [10.164.28.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by s1.sapience.com (Postfix) with ESMTPS id 2F30B480A68;
	Sun, 07 Dec 2025 12:58:21 -0500 (EST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-ed25519-220413; t=1765130301;
 h=message-id : subject : from : to : cc : date : in-reply-to :
 references : content-type : mime-version : from;
 bh=Q++gC+3ioqzZHPSBkqfCwWrV7HrOUBqS/RobES8vUtw=;
 b=SeFbERYr2xyYSQpb2h+gTObRiInm7JYJEtctSO276cdreZn1+n134WiUYMxdiOJETKHPQ
 wUUy/7sJzzo1fAMDw==
ARC-Seal: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412; t=1765130301;
	cv=none; b=ichWZYnPFBbjKFGDSk+edyXaBZLDvY/X4BZJh/lfA/3Gb1OLEs4cQrPRVqSL4gEJmAI7rQGscB1gJbIHgF8Dtdlr4WxqLWozi3eFyW/lcu2XAt/IDKG5o9P2IkDWyoSXQVrrDHqHZwMLRP/XRQCgS3s1FMMPsgXfG6OEXckypzZvbfbRXprVNwO/ue5ZFuXFI+Af0qqfeZRzH5Q6TuNEUBEpVIFeh3vyxaDDQas3ClHoyMOdXo9qMnWJ9h0DYQ6XD2NZzDo5SJPl4CL0k67qe+SNtxhfOdM5TfVfiQ7eLUdpa2pdYKhc0hU0qkyGqwvdErRhdWycc14htYPNtM7hmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412;
	t=1765130301; c=relaxed/simple;
	bh=Q++gC+3ioqzZHPSBkqfCwWrV7HrOUBqS/RobES8vUtw=;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Autocrypt:Content-Type:User-Agent:
	 MIME-Version; b=N/TODJGFJr0hhKvJSL1CnyItQLGwkELJaIK97gzqYXyXJeKe+njoMS+SPjaHZufFgVhCjG/JHUaekGFHx5PCYu157KOFTSe2PuoHWkOncR/X+moLNrHdMsd0Y64hAU4xH+7bTIhyDbw78vV7OEWsjbhqnRB4BUIRDz1+jJ+FxFsTQAyhmNYszWTlwdesqZh88Zx1tHNoIkJ0qnaIYIIJC4qFTe2eZgJn0LQpVqdovT6RhdSO48CzIvA4u6Nxulhw1TeYOVPSA79qr1qLFhByfMzFFof3ABDfapB247WKDzKCwB9uHNv71lQxaE3y06ECbpw+Toj+L9eRXxiLcwlRWA==
ARC-Authentication-Results: i=1; arc-srv8.sapience.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-rsa-220413; t=1765130301;
 h=message-id : subject : from : to : cc : date : in-reply-to :
 references : content-type : mime-version : from;
 bh=Q++gC+3ioqzZHPSBkqfCwWrV7HrOUBqS/RobES8vUtw=;
 b=kzn0TRakhac1V/51AOKNQHNv/0mM89YIuL2Wj4eJNn23PNzbO1f1g+KxS9FpT5PVXUDb3
 LQ9hPI35RTsK7NhnnGOB51xy2ORqG+S+lzRwvBtkMcFLUSaau+pthZPZ7I0w5sH/buVraIN
 guo1ykik7FpfAIfeBlqXo0rPAIDuKuXTsX26mad98Xh5psbb+FA+MVG0p8TtNqQMPdRXObl
 HVqO83dmw6FZiljvCkNw6olrBSbCbzj/axMih0AB5Lxo7dDRT8CSbVqhRnP/vPWYdmz8NPt
 Z+ZF9LdK2fdcfq/UMPaVJ2Rd/MUHYInTNSA3SFadksZYXYCH/lcEkmqSXntA==
Received: by smtp.sapience.com (Postfix) id C1C732801F9;
	Sun, 07 Dec 2025 12:58:21 -0500 (EST)
Message-ID: <2cc00d49014047ec83df3d4d4815b240949ffffa.camel@sapience.com>
Subject: Re: [PATCH iwlwifi-fixes] wifi: iwlwifi: Implement settime64 as
 stub for MVM/MLD PTP
From: Genes Lists <lists@sapience.com>
To: Yao Zi <ziyao@disroot.org>, Miri Korenblit	
 <miriam.rachel.korenblit@intel.com>, Richard Cochran
 <richardcochran@gmail.com>,  Johannes Berg <johannes.berg@intel.com>,
 Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>, Daniel Gabay	
 <daniel.gabay@intel.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit
	 <kexybiscuit@aosc.io>, Nathan Chancellor <nathan@kernel.org>
Date: Sun, 07 Dec 2025 12:58:21 -0500
In-Reply-To: <20251204123204.9316-1-ziyao@disroot.org>
References: <20251204123204.9316-1-ziyao@disroot.org>
Autocrypt: addr=lists@sapience.com; prefer-encrypt=mutual;
 keydata=mDMEXSY9GRYJKwYBBAHaRw8BAQdAwzFfmp+m0ldl2vgmbtPC/XN7/k5vscpADq3BmRy5R
 7y0LU1haWwgTGlzdHMgKEwwIDIwMTkwNzEwKSA8bGlzdHNAc2FwaWVuY2UuY29tPoiWBBMWCAA+Ah
 sBBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEE5YMoUxcbEgQOvOMKc+dlCv6PxQAFAmPJfooFCRl
 vRHEACgkQc+dlCv6PxQAc/wEA/Dbmg91DOGXll0OW1GKaZQGQDl7fHibMOKRGC6X/emoA+wQR5FIz
 BnV/PrXbao8LS/h0tSkeXgPsYxrzvfZInIAC
Content-Type: multipart/signed; micalg="pgp-sha384";
	protocol="application/pgp-signature"; boundary="=-YtdT4vGRfRO4/TJUbSKH"
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-YtdT4vGRfRO4/TJUbSKH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-12-04 at 12:32 +0000, Yao Zi wrote:
> Since commit dfb073d32cac ("ptp: Return -EINVAL on ptp_clock_register
> if
> required ops are NULL"), PTP clock registered through
> ptp_clock_register
> is required to have ptp_clock_info.settime64 set, however, neither
> MVM
> nor MLD's PTP clock implementation sets it, resulting in warnings
> when
> the interface starts up, like
>=20
> WARNING: drivers/ptp/ptp_clock.c:325 at
> ptp_clock_register+0x2c8/0x6b8, CPU#1: wpa_supplicant/469

I do see this warning at boot (mainline kernel), =C2=A0but you noted, it al=
l
works fine nonetheless.
I didn't see this in next or mainline yet.

Do you know when this might find it's way to mainline?

thanks

--=20
Gene

--=-YtdT4vGRfRO4/TJUbSKH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYJAB0WIQRByXNdQO2KDRJ2iXo5BdB0L6Ze2wUCaTXAPQAKCRA5BdB0L6Ze
279ZAP45H4PAf6etDK7xqIby8qcbWAhpzzeSzz/PT+xKlytXigD/T6IgKfuAYlUY
O8iWd5ZVcmEN0I5iS8ZpSxWxwSYpsQk=
=H1KP
-----END PGP SIGNATURE-----

--=-YtdT4vGRfRO4/TJUbSKH--

