Return-Path: <linux-wireless+bounces-30091-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0FECD9DA8
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 16:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A144030968B0
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 15:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99090346AD6;
	Tue, 23 Dec 2025 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="fHqoc4zP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sonic321-26.consmr.mail.bf2.yahoo.com (sonic321-26.consmr.mail.bf2.yahoo.com [74.6.133.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497D533B6E9
	for <linux-wireless@vger.kernel.org>; Tue, 23 Dec 2025 15:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.133.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766504340; cv=none; b=I3DTdrAXmu+bO9WXdP3LEFB/08FQQ+dKh+sSKDKyV4vRh8/GqNy5Ef86qpbV7HiLfQuxC4zZE+DNucbxCSBfwttBQDqI0OJhMGuuddjnSiO8HlzfiwQRAPGSeguTVmrnoX9bojjNnloEWS1IDK0PUUGDRnSG1YR2WTNW+QcfvNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766504340; c=relaxed/simple;
	bh=LwvYDYaktTk8lXo8IkTorI+EErZp158qmx9KmCPBgCY=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=jWuYRl02nFdY4DbAeFfB4JJxGJbvLPJV1+ZZKLO8eGHbvZTNfVf6X04d9P4ffdUyf3KRU0QeQoHkA8uXTii/fo4bCw1ZIszLYgJ9+aBL6cXDh1qy+3Y+0sDIHiQYWiQHMkXw5P3H5WM0a8x3ds/ITdfL7aOXty/4g4ZjLOeIS+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com; spf=pass smtp.mailfrom=aol.com; dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b=fHqoc4zP; arc=none smtp.client-ip=74.6.133.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1766504337; bh=LwvYDYaktTk8lXo8IkTorI+EErZp158qmx9KmCPBgCY=; h=Date:From:To:In-Reply-To:References:Subject:From:Subject:Reply-To; b=fHqoc4zPRoDGl+fjhGvMU6V8nTQ8n0WZXOykfkmjhUTkiNGy5BYchhIqrYj2oZuym5RK3Sj+9nmhbAenW/X80RRZuHJhYjWFqCMrSRKpxAKvphAXf12fuZLiMrHg28sQFjCY1+KF9D+uz8XJJNQWJnt0KSviklUZuJDZCjG+r9x7P3mVrgdEzmkPA8flZVXjZoiZx/Z7Y0r+NWnESBthRD1SC7V+hHoNzOeOWq76VI624GlOI1uCwMTGu0sWl9TRiQXXUyLHXBnDGGu9IT0HrNkdH3bKuprpPtof0n1GrM64Pr/4izDfLn158caHyccq3OfGiqxqICkXgkxrAYBF1A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1766504337; bh=FK+0D4aVq0+ZqMT4moKw39iRtiiP0wEEczaoU6VtJMd=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=dM/7HeGnpXHEAsi4oiHr0PITszDJfC/G8Q1To/sT0+yP2VA7s13btcXWCpNWMntgYLjgF5XoUtE8o7Z/jOOMavwSDiap+9tlrIcuQe8ZLOHMy9vqmMCwuNyvPB31YC4oOuzotlIH34k611DCQH+yzbbBKBmDFF86pvuGwwBOAr0b7TvJQCTu5CIgqq/CfAadJpQEPUxT/48aME3U/cmM6mFMIDdgSENEcsRh3U/aJJ2CxA0y7yhFfi+WJoAZJATI8IXHDrQKr5v17pMT5DidYRcd6Pne9hSnvUbV5AC0Q42KEGMwIX19FXgitFdUvAg0bDCA7Ax76tKVlC+CUw4pJA==
X-YMail-OSG: 9.bcxMYVM1mKRDRhKZSrbwO3oQuViIto6D8IOa.V0jpA0FH6d8C61o1QQMQ67pe
 QV2yREeuKtRZAWsVF9eF5JVzEIsOyim6yXy8Vwf43VXDFqU_3sNGBrmpSWUilqBFzyJA21Nn_Zab
 9o0GsuTj7LLrw_NaS7YDapQ_ihY2I2DV3VqFWHZaznZiadXxBTwSrWavXV7wsR8Nt6fHEjTRQFdR
 GhWNCm2XmypF10lHcsfbPKTyw7W8lCyFboMdPB2sltSfeYrmDQ6Mcs3fgznhf0IpjVjg1FKdLThv
 XdxDKVizPLLGtO4HXyZwsOUH_.rbyqA9Pn4jM69JFzltKBagPC6HjM52Zbdbwp7dhaMd_BFoFGFt
 EG6tKxE8C3pEyVbVIjhelklurpfeOhUDYdmTxEj4PG76hubT1QKzKohYwGDqfxyY9UzZDT5jr3cI
 QSivmYzzqtTmh7lEzWP8_q2ElGcfrO9mI4MFwhDCEstAAzptvUhM3bBYFq_oZyDvP3L6h2DldR8e
 ovx46nEvr0YN5rnMaB82LokGtTN7hDpzEBk16lA9fQmuan1cTi40amyUu4ciwn0iH8h8su6fDMFl
 MOYLSSs63usceojZ6evrFSFfzWRjJ7OuSsSUsdeZkUVobkcM9qw2MIYClYRbZNbeoWBPQjfd8FmY
 xLaPT8tKOPB2gpAgoTj0krC9n9n4Zsvu54leJScguh6WQKKVvYkj1jf5Qw2DBgpxTxX95JomZxI1
 x2626WOzZkEEdQXwc8JlkeRe8_VEcm4R24B8iIqZJxgsjOarSHCnIZNXAeeNBiM7JPE.hPzRFKuF
 wQAgpNFNzHPvSBMc2u4j61RETcpPlaLUpqWnDypopyonxV11d9M8kBvzF7Ep4o1u_BOvuHhwlQen
 LHfdZCLciWmrd4OCUMgpJpHcG9r9GyKwdNJO1AjC06RAauqomcGwqIoEGA3LM9vS7mxHxKIyH_.4
 JEIKJDkEzwtLs4lifm4W_xR2tc5BygxBz5rIx69RWiqQI4l5laHHesdIXrPaimWMhKl38vfGhfBd
 2arDkncVdC4ud9S.aIAHtw_dmSB_J7CJ5NP3O1MB1zcVLUOP91AktAlMFTXf7TKSZ4SuTiinm7gl
 AEjgJgwKBrVJ5bQyIAhhLyjFdPHl6PVHiDplr3zIGAnWTP.6dCYYRrrb_XW0yg5mmyZDP4AuYmrG
 4VYGDDr18zuKUR_8e.9bQ1sOGB01M_Xfx9kfB77iLWAl2mZImabwcsI0SCyQQuSA5.DyIXNc.q7h
 w07lgJWXLhqSVIogdgBbbt9zGN.eGNnxi.fFMBtHp5vlOPOR_nCSEN1ldCZW60D13ID1N_fJZwai
 xQJ8ooSCc0sBIqaUYg4agSiFdDFJs4sIh7vSp0cdPBfiRs7_McTiaEnunNPs4r9n1Db4iJbRrw32
 JxNAE1VAbniBuMHe4R8IQQKbteTzVS5ed6ADmlkB2w4aJoQMFe1XlRhi3KOXssrvReynkZFSob9S
 6nvj5_Bry2cQTJ1FUgm1ZI7unAa3nItAo.7MCOpqFXDuqTI9G_6MScDgGCaN4jeqCKeAJhgGjQTA
 .xoGRg0gEvZ0uVVGT5KyYVWkWrGGMZmyLy2nDcdnI8MCuaoHiFEOfNfgjXgsGkxzaSxADj_V9V6G
 ckmqX_JaN8nwX952ensVpqF0nZn01uoBayX5yfT9BaoDPL0MT_IE9wxVPmw9qLWutiHWuoxMU0K.
 vaTNF8ZcdqErPl14XkNPME4F7FRlxch7z3xkqffwwbFWKTVD5kVTQ_kXF1nQ2sbyhxH5C5oHBLfP
 H4GNiYxcwihM8XLLJYGvTzKzL71ldzhTNbGBcgGgtaKIqCkpbvUBZAIFSlZfKj2pvr1wuQxQZPFg
 qi41w6x6htlyi2prvdVpTU0km9.cnGXPkPg7c13OZnDBHqHWpzoBX5cCrtkTUtRVZZL4FwW_EkK0
 5JlI9FGBQPVFOy6QOPksOuIIwUWA2KMfgExdoe0iYNeWA6eyoGvmqWT4SPZAvL8Ro6Vg6hrFzXyz
 iGzpWsRh4822YK3CY_uxuoLvYdmLAwh8z_uDDP2i5sBfOyZ8BU4kdUeLXTfsNfzySSPUpoLbCxhV
 JXcSIlFIwZBL_ZLLByrkZUVzhlSlApUR2exAs.thunC9c_pfVcqJPknU1MqC47XBLXxczfagovuI
 Nybwc5ncKdpme0PxpuR3mTkgmViGAu5UCpMbdPsyjgqo7OH0flFjz_aaYwXhbFSl4eq4faZVLuQ1
 XXIHcv7US7a_IVM0ZViFz7qE7e3Iu4dw66tAZQpjtwg--
X-Sonic-MF: <russomch@aol.com>
X-Sonic-ID: 5e079aa0-f50e-42e9-a405-4eea7ac4a35d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic321.consmr.mail.bf2.yahoo.com with HTTP; Tue, 23 Dec 2025 15:38:57 +0000
Date: Tue, 23 Dec 2025 15:28:37 +0000 (UTC)
From: Chris <russomch@aol.com>
To: Ping-Ke Shih <pkshih@realtek.com>, 
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Message-ID: <2033055489.1974567.1766503717295@mail.yahoo.com>
In-Reply-To: <3dcf5e11aa284daa9d3733141ccdc17f@realtek.com>
References: <AB8446D8-708B-4971-8852-87353112E60F.ref@aol.com> <AB8446D8-708B-4971-8852-87353112E60F@aol.com> <3dcf5e11aa284daa9d3733141ccdc17f@realtek.com>
Subject: Re: [BUG] Intel B580 (e20b) HDMI Flicker & Realtek RTL8922AE 6GHz
 missing - Mint 22.3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.24866 AolMailNorrin

On Tuesday, December 23, 2025 at 02:48:01 AM EST, Ping-Ke Shih <pkshih@real=
tek.com> wrote:=20




Chris Russomanno <russomch@aol.com> wrote:

> Hello,
>=20
> I am reporting two issues encountered on brand-new hardware using Linux M=
int 22.3 with Kernel 6.14.0-generic.
>=20
> Hardware Environment:
> - GPU: Intel Arc B580 (Battlemage), PCI ID: [8086:e20b]
> - WiFi: Realtek RTL8922AE (rtw89), Firmware: rtw8922a_fw-3.bin
> - Display: Samsung 4K Monitor connected via HDMI (No DisplayPort availabl=
e)
>=20
> Issue 1: Intel Xe HDMI Flickering
> The Samsung monitor experiences intermittent black-screen flickering (1-2=
 seconds) at both 4K and 1080p
> resolutions. This behavior is not present on Windows 11.
> Troubleshooting attempted:
> - Added kernel parameters: quiet splash i915.enable_psr=3D0 xe.force_prob=
e=3De20b i915.enable_dc=3D0
> intel_iommu=3Digfx_off intel_idle.max_cstate=3D2
> - Forced "TearFree" and "TripleBuffer" in xorg.conf.
> - Frequency remains at 60Hz.
>=20
> Issue 2: Realtek RTL8922AE 6GHz/WiFi 7 Missing
> The card functions on 5GHz (1200 Mb/s) but does not scan or see 6GHz freq=
uencies.
> Troubleshooting attempted:
> - Set regdom to US (iw reg set US).
> - Driver options: rtw89_pci disable_aspm=3Dy, rtw89_core disable_6g=3DN.
> - 'iw list' does not return any 6GHz/6105 MHz frequencies.


Please share output of 'iw list' before/after setting US.=20

In my side (expected) frequencies of band 4 are:

[Before]
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Frequencies:
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 * 5955.0 MHz [1] (disabled)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 * 5975.0 MHz [5] (disabled)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 * 5995.0 MHz [9] (disabled)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 * 6015.0 MHz [13] (disabled)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 * 6035.0 MHz [17] (disabled)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 * 6055.0 MHz [21] (disabled)

[After]
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Frequencies:
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 * 5955.0 MHz [1] (12.0 dBm) (no IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 * 5975.0 MHz [5] (12.0 dBm) (no IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 * 5995.0 MHz [9] (12.0 dBm) (no IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 * 6015.0 MHz [13] (12.0 dBm) (no IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 * 6035.0 MHz [17] (12.0 dBm) (no IR)


=C2=A0
________________________




Hello Ping-Ke,

Here is the output from my RTL8922AE on Linux Mint 22.3 (Kernel 6.x):

[Before iw reg set US]=C2=A0

Frequencies:
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 5955.0 MHz [1] (12.0 dBm) (no I=
R)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 5975.0 MHz [5] (12.0 dBm) (no I=
R)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 5995.0 MHz [9] (12.0 dBm) (no I=
R)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6015.0 MHz [13] (12.0 dBm) (no =
IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6035.0 MHz [17] (12.0 dBm) (no =
IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6055.0 MHz [21] (12.0 dBm) (no =
IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6075.0 MHz [25] (12.0 dBm) (no =
IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6095.0 MHz [29] (12.0 dBm) (no =
IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6115.0 MHz [33] (12.0 dBm) (no =
IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6135.0 MHz [37] (12.0 dBm) (no =
IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6155.0 MHz [41] (12.0 dBm) (no =
IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6175.0 MHz [45] (12.0 dBm) (no =
IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6195.0 MHz [49] (12.0 dBm) (no =
IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6215.0 MHz [53] (12.0 dBm) (no =
IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6235.0 MHz [57] (12.0 dBm) (no =
IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6255.0 MHz [61] (12.0 dBm) (no =
IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6275.0 MHz [65] (12.0 dBm) (no =
IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6295.0 MHz [69] (12.0 dBm) (no =
IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6315.0 MHz [73] (12.0 dBm) (no =
IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6335.0 MHz [77] (12.0 dBm) (no =
IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6355.0 MHz [81] (12.0 dBm) (no =
IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6375.0 MHz [85] (12.0 dBm) (no =
IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6395.0 MHz [89] (12.0 dBm) (no =
IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6415.0 MHz [93] (12.0 dBm) (no =
IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6435.0 MHz [97] (12.0 dBm) (no =
IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6455.0 MHz [101] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6475.0 MHz [105] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6495.0 MHz [109] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6515.0 MHz [113] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6535.0 MHz [117] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6555.0 MHz [121] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6575.0 MHz [125] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6595.0 MHz [129] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6615.0 MHz [133] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6635.0 MHz [137] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6655.0 MHz [141] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6675.0 MHz [145] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6695.0 MHz [149] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6715.0 MHz [153] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6735.0 MHz [157] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6755.0 MHz [161] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6775.0 MHz [165] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6795.0 MHz [169] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6815.0 MHz [173] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6835.0 MHz [177] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6855.0 MHz [181] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6875.0 MHz [185] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6895.0 MHz [189] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6915.0 MHz [193] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6935.0 MHz [197] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6955.0 MHz [201] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6975.0 MHz [205] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6995.0 MHz [209] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 7015.0 MHz [213] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 7035.0 MHz [217] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 7055.0 MHz [221] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 7075.0 MHz [225] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 7095.0 MHz [229] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 7115.0 MHz [233] (12.0 dBm) (no=
 IR)


[After iw reg set US]

Frequencies:
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 5955.0 MHz [1] (12.0 dBm) (no I=
R)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 5975.0 MHz [5] (12.0 dBm) (no I=
R)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 5995.0 MHz [9] (12.0 dBm) (no I=
R)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6015.0 MHz [13] (12.0 dBm) (no =
IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6035.0 MHz [17] (12.0 dBm) (no =
IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6055.0 MHz [21] (12.0 dBm) (no =
IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6075.0 MHz [25] (12.0 dBm) (no =
IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6095.0 MHz [29] (12.0 dBm) (no =
IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6115.0 MHz [33] (12.0 dBm) (no =
IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6135.0 MHz [37] (12.0 dBm) (no =
IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6155.0 MHz [41] (12.0 dBm) (no =
IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6175.0 MHz [45] (12.0 dBm) (no =
IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6195.0 MHz [49] (12.0 dBm) (no =
IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6215.0 MHz [53] (12.0 dBm) (no =
IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6235.0 MHz [57] (12.0 dBm) (no =
IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6255.0 MHz [61] (12.0 dBm) (no =
IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6275.0 MHz [65] (12.0 dBm) (no =
IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6295.0 MHz [69] (12.0 dBm) (no =
IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6315.0 MHz [73] (12.0 dBm) (no =
IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6335.0 MHz [77] (12.0 dBm) (no =
IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6355.0 MHz [81] (12.0 dBm) (no =
IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6375.0 MHz [85] (12.0 dBm) (no =
IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6395.0 MHz [89] (12.0 dBm) (no =
IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6415.0 MHz [93] (12.0 dBm) (no =
IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6435.0 MHz [97] (12.0 dBm) (no =
IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6455.0 MHz [101] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6475.0 MHz [105] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6495.0 MHz [109] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6515.0 MHz [113] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6535.0 MHz [117] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6555.0 MHz [121] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6575.0 MHz [125] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6595.0 MHz [129] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6615.0 MHz [133] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6635.0 MHz [137] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6655.0 MHz [141] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6675.0 MHz [145] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6695.0 MHz [149] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6715.0 MHz [153] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6735.0 MHz [157] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6755.0 MHz [161] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6775.0 MHz [165] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6795.0 MHz [169] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6815.0 MHz [173] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6835.0 MHz [177] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6855.0 MHz [181] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6875.0 MHz [185] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6895.0 MHz [189] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6915.0 MHz [193] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6935.0 MHz [197] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6955.0 MHz [201] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6975.0 MHz [205] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6995.0 MHz [209] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 7015.0 MHz [213] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 7035.0 MHz [217] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 7055.0 MHz [221] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 7075.0 MHz [225] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 7095.0 MHz [229] (12.0 dBm) (no=
 IR)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 7115.0 MHz [233] (12.0 dBm) (no=
 IR)


I have tested the iw list command before and after setting the region to US=
.

The Result: The frequencies in Band 4 remain identical. Both "Before" and "=
After" already show (no IR) for all 6GHz frequencies. There was no change f=
rom (disabled) to (no IR), as they were already set to (no IR).

Even with the status at (no IR), the card is unable to see or connect to my=
 6GHz SSID, which is confirmed working on other devices and even with Windo=
ws 11. It appears the card remains in a passive-only state regardless of th=
e regulatory setting.

Please let me know if you need specific dmesg logs or if I should test a sp=
ecific patch.

Thank you for your help!

- Chris

