Return-Path: <linux-wireless+bounces-30134-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B689ACDF4AB
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Dec 2025 06:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B16CC30062F1
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Dec 2025 05:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB9B2248B3;
	Sat, 27 Dec 2025 05:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="ayfCGb3u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sonic319-27.consmr.mail.bf2.yahoo.com (sonic319-27.consmr.mail.bf2.yahoo.com [74.6.131.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE443BB48
	for <linux-wireless@vger.kernel.org>; Sat, 27 Dec 2025 05:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.131.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766814145; cv=none; b=dj1loaQ1sL2huHwMTwXjFI1UIoUdHlCctB7TSmULRgCPwPh73kfGt4AbuIuhFGRWZAWULlCKe8jyy7NLk9SrI+/FDOOi7Oek/9S2X709vkR9+tm/B86c+aDAyU9AKiQdfUjhCv1nPan6GmvIiCQlgpe7VqyAGfIbgtUzzqJzw0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766814145; c=relaxed/simple;
	bh=G7dcBcX39I/DaGJY6WNVI+iHWYZIbkNRFqormajOaa8=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=KnfjfGh3oZBSHNuWboYRQzTCYMJm3QzGpYiKdZYushx1fxvDenYFtftQSm/iTBxUrOWjftY9CD+W/pbpHEqTVe5UUOTfEYE6cWvxgSMtoNTT70BHVwwHZ0CD+oK0/ShPC7rNBmbMOXzsGvGLuxNa4BG5FcI7cMWb2iwtqC9oDYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com; spf=pass smtp.mailfrom=aol.com; dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b=ayfCGb3u; arc=none smtp.client-ip=74.6.131.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1766814142; bh=G7dcBcX39I/DaGJY6WNVI+iHWYZIbkNRFqormajOaa8=; h=Date:From:To:In-Reply-To:References:Subject:From:Subject:Reply-To; b=ayfCGb3unhd/eUaXsoMQIiu6CBYJztb0O57MSsJ5ZyfeSLcwSx1Qpaz8aInR2rbcaj3nPqpTXkmpxi0rTqkO9tTC5YwOuuPNeL07zuYYRf+KaO+5Rs8XwHgYZztk/YpMtV0gDWp9obk6nqTWRNnMHcOw5dUp3mVk67JhUWNxC2XrSCsHcJWxn5oFyzX0j3vUav02Zu+q9a0RaKeq044isyL2DBrufw9oEpS3b2GQRVXcZv7ZLGGrdIytkpM7Csp2H/0nXpo4Q8NSjeX6HJ7bvJBiN8H8dFfczODQMEdyNUoBOLIg+/gD9JlV0B45eevmc3U54pn/oZY/YUeW8mPZ5A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1766814142; bh=UcHfU3D2ZaGa8sAASUIlKlGnzDycmkcHYDszjUJc1eX=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=aRJxTKinm6KpM5Kthm0TJbMhADMzT9TT4V0T/PBA+/XXqVJt7dOZeTxsYANs8BbGllC6bOQpleJJlRr2pox9ngX7VXIy5a8jqpuJs26gY4NPkOz7ygMYjBitthsmG1ODCWFNF8VDK+LGfNry/vDdQZpZc7laVGWwS4d/6L39zE1tC2AXCBejvoI86djqHQRk8OkcXLFXikN2osxsycQGVs5o0kxeiQII1R0m7ZZ2OYd7cIm2B6KvK+jOkZJg2xJ0xff0TxN8Pup1tacXOurRb7TAWJ7onPkjmAklAWsL0kZHjQOc6wG3VQW/Keic3mheEvgogVToIq29Sbr1j55rmQ==
X-YMail-OSG: DrmeVXAVM1k83cssHG.hBhVMRHWW70F.kDwZ1luQyN3AsYgXsCAuyW8lA4IqhGN
 xBrY4IsFj0ijiCWtAxqA4B7YQIfw72aGf_NPQF_xXAlxhRk16DvXwH8CxEywS_Agvem3b6M1rPVV
 EzpKqfrIuU0HduY6dw7rPERb6sAbTBRZaYWmA3Ef3kHljgI4Z5yNOecGeQdLknEckCoR7XhHHuz0
 ydKyTLjuS8rctjlbGOl12R0c6AgnLpQEa8Ld3Hcp19T0jrDHqwRe3jcclnb4fcNvjwNfS2xWoAWY
 uLVN7kRDrC_uU8ABjSPdDqNwek_ep3S2SKix4PtJc3PeVbTdf2ywlkeE__bLDvyY2GIX_7b_U8sL
 QOCgm2td.une1vIn1hCH8G8VOae8NABw9DuH_HbkTvtRxHMuwk1e3f2AR4q.4u5et4uh3xY_58II
 _iYCId4BPZDvfcr90.EW6bf3CtwPIhvzxrb47A0ZkapvpidrOr.n2tojnqFE4qJS90dmmY8YHqbj
 0.Pmw7esC7318LUHTjhThk.4yXC4j6y7DP7.4S9HKW86YDbnqA2t8cuKNUKswdKhM_HUBvuECe1f
 UoeP4MEpEfyPwltDHXAHrJT3y7W37ASDDgfk4MOLN1MY9CXv4iOqFVoRZTXSQoqUnmoG.kE0nkuX
 yvHnBxoMaLlHDfmOaA7v2GS3FJ45e4cxcee7Xn.u2vAQdKs2Q.G7H39fq5qTC6cVpmcNZAFUNcEV
 U0991zg4tM6QAS1XPZAZS9JfmxqWvG2gTM.3eRpfuQbqOljdDsRT9BWmoaJP0t0JUPv6Y8PoC54t
 xMsdYhVHyPFmwLxojbh6JnlMxAlMK8PwjZd9g5l0Kc.70GyeP_mO_FQDYUPIyYZuRYUIlu_sQatB
 fqH330e3ydCvlP.eJm7wJqai4AfvsJ__8pK1jftsDeQMwRtHY2reculnnxx4UhIsg0fJlq9.4WYi
 xKbkDD7Xvk4cl5weAmdxGieUVCdl_QO31HNgLmaNzjlo6bBi4Amny5mKtEakMuXezEPvHbHGRnav
 4vYc5fsVL2MtCBm2UVE2QNnV3hXwXuAYrwijqWEd2VZnX2E2PNVSf2DL9FUjgtGl53LZ9Pp_I8hz
 3gvyy47kY4iLyh6T.h_yydGZG8wyFk0ZDu7mS8g0NklL8fRwr3Ak9LbU7HHB8qFxrVXazj6IJVjB
 AdmzTvdWi9a1knJH65OsSJD8138BKaJNlFWNGZA6kkBCUooOAQIpEsGolMp_molNNr1izmAfGEDM
 ievz0qRXEG9XOZmyhl1MuFn8MQZ630jZxyV2sbAXT_Y89vrR_hg.D.s3uw4yA5VqkQbddNqmL1sU
 uYGMiFI.fnQZ80cedIZX47InB0Uyfx6srEj6zs0C2tvgg1Ox4ApyQwy78O9hdOxFj_W1NKwcOy_H
 TBmzHS5jSL15P7xXAZbCHfYdkDc165MyPUjxVEKWRrd.csaPS2vO6zStNLSpPYtvv.NADs..5L4e
 Q6HLqwBSvyfddtvFq59RO2wriST1iOkJCSo3c6wpF7Jv0IsPKJI34SEf_Z2WGd4ervqeL88u6XX5
 Ayn9MHAui1fZsYb3jZPTRFEsgilOmmW0CDKYyRNJ1dyHzD0H_1RwI_g2P_4UShZCkuNR5OCxRjKT
 QyISC16O0H1X5yEQZsZ49rkmWAMTIQKDyH2R72l_FslZYYzKxw7NZ849vkTzmPHi0ZwpwuXfNdfa
 gLWpSUMGts7JnIBJ6HDStYQ.xXo2MJ1gsf66SR8vuq7jdQfyEUIwd5XPFQrlupRl49g3JBEg0C32
 GHXBq_mpA4n4afnx.qMZ01rGASRh6xleMMPN.GE_TpQt0Jnh0xRxqh8EM3YGF8F1bH6phVW3w8GO
 ntpDXoGBuC0YU16N8Jk66Ep3tPccNlPoDI19weji5FVNtECxjYejcZTe0Ggpk1ZbKH1aKl2DeL3J
 qtSBjUOj6aEL9ln.DMkyU1zSO0b69Vka3TvBWuvyBxcPOc_L7Qm2xQcbjQpgGhkp8.RoPp6UlJpQ
 yY70VNjzVitwzfpOTJxoDt5aamczfTuDhjzV0xKcHfI0e36aMV8nChnsbLESKZ0KefflySPQbhi_
 8oacZHVm0nu1VArBNQI6mZKYtS4UmVhotBuTCqNCz50OkKv9kmSx8eiwnxOj0eg.J20RG.KL7f1F
 0A_k6Czrl5EUgT0WWzDLZV..ACTdUS79IlgAHEZ42r._c_Wa2Mf1BN7Ia.EdCb9hQP_6Ik0lJRaC
 Zszal8CY7EwOHEXtPb7O3A0WgBOZMnbMNn4g_7FgyIg--
X-Sonic-MF: <russomch@aol.com>
X-Sonic-ID: 510bae83-a7c3-422b-8163-90cf32ff4a47
Received: from sonic.gate.mail.ne1.yahoo.com by sonic319.consmr.mail.bf2.yahoo.com with HTTP; Sat, 27 Dec 2025 05:42:22 +0000
Date: Sat, 27 Dec 2025 05:21:13 +0000 (UTC)
From: Chris <russomch@aol.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	Ping-Ke Shih <pkshih@realtek.com>
Message-ID: <1619250700.2388478.1766812873221@mail.yahoo.com>
In-Reply-To: <dae24a713d354c27ac3814c02822099d@realtek.com>
References: <AB8446D8-708B-4971-8852-87353112E60F.ref@aol.com> <AB8446D8-708B-4971-8852-87353112E60F@aol.com> <3dcf5e11aa284daa9d3733141ccdc17f@realtek.com> <2033055489.1974567.1766503717295@mail.yahoo.com> <dae24a713d354c27ac3814c02822099d@realtek.com>
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

On Tuesday, December 23, 2025 at 09:12:32 PM EST, Ping-Ke Shih <pkshih@real=
tek.com> wrote:=20




Chris <russomch@aol.com> wrote:
> On Tuesday, December 23, 2025 at 02:48:01 AM EST, Ping-Ke Shih <pkshih@re=
altek.com> wrote:
>=20
>=20
>=20
>=20
> Chris Russomanno <russomch@aol.com> wrote:
>=20
> > Hello,
> >
> > I am reporting two issues encountered on brand-new hardware using Linux=
 Mint 22.3 with Kernel
> 6.14.0-generic.
> >
> > Hardware Environment:
> > - GPU: Intel Arc B580 (Battlemage), PCI ID: [8086:e20b]
> > - WiFi: Realtek RTL8922AE (rtw89), Firmware: rtw8922a_fw-3.bin
> > - Display: Samsung 4K Monitor connected via HDMI (No DisplayPort availa=
ble)
> >
> > Issue 1: Intel Xe HDMI Flickering
> > The Samsung monitor experiences intermittent black-screen flickering (1=
-2 seconds) at both 4K and 1080p
> > resolutions. This behavior is not present on Windows 11.
> > Troubleshooting attempted:
> > - Added kernel parameters: quiet splash i915.enable_psr=3D0 xe.force_pr=
obe=3De20b i915.enable_dc=3D0
> > intel_iommu=3Digfx_off intel_idle.max_cstate=3D2
> > - Forced "TearFree" and "TripleBuffer" in xorg.conf.
> > - Frequency remains at 60Hz.
> >
> > Issue 2: Realtek RTL8922AE 6GHz/WiFi 7 Missing
> > The card functions on 5GHz (1200 Mb/s) but does not scan or see 6GHz fr=
equencies.
> > Troubleshooting attempted:
> > - Set regdom to US (iw reg set US).
> > - Driver options: rtw89_pci disable_aspm=3Dy, rtw89_core disable_6g=3DN=
.
> > - 'iw list' does not return any 6GHz/6105 MHz frequencies.
>=20
>=20
> Please share output of 'iw list' before/after setting US.
>=20
> In my side (expected) frequencies of band 4 are:
>=20
> [Before]
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Frequencies:
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 * 5955.0 MHz [1] (disabled)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 * 5975.0 MHz [5] (disabled)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 * 5995.0 MHz [9] (disabled)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 * 6015.0 MHz [13] (disabled)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 * 6035.0 MHz [17] (disabled)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 * 6055.0 MHz [21] (disabled)
>=20
> [After]
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Frequencies:
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 * 5955.0 MHz [1] (12.0 dBm) (no IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 * 5975.0 MHz [5] (12.0 dBm) (no IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 * 5995.0 MHz [9] (12.0 dBm) (no IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 * 6015.0 MHz [13] (12.0 dBm) (no IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 * 6035.0 MHz [17] (12.0 dBm) (no IR)
>=20
>=20
>=20
> ________________________
>=20
>=20
>=20
>=20
> Hello Ping-Ke,
>=20
> Here is the output from my RTL8922AE on Linux Mint 22.3 (Kernel 6.x):
>=20
> [Before iw reg set US]
>=20
> Frequencies:
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 5955.0 MHz [1] (12.0 dBm) (no =
IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 5975.0 MHz [5] (12.0 dBm) (no =
IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 5995.0 MHz [9] (12.0 dBm) (no =
IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6015.0 MHz [13] (12.0 dBm) (no=
 IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6035.0 MHz [17] (12.0 dBm) (no=
 IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6055.0 MHz [21] (12.0 dBm) (no=
 IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6075.0 MHz [25] (12.0 dBm) (no=
 IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6095.0 MHz [29] (12.0 dBm) (no=
 IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6115.0 MHz [33] (12.0 dBm) (no=
 IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6135.0 MHz [37] (12.0 dBm) (no=
 IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6155.0 MHz [41] (12.0 dBm) (no=
 IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6175.0 MHz [45] (12.0 dBm) (no=
 IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6195.0 MHz [49] (12.0 dBm) (no=
 IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6215.0 MHz [53] (12.0 dBm) (no=
 IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6235.0 MHz [57] (12.0 dBm) (no=
 IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6255.0 MHz [61] (12.0 dBm) (no=
 IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6275.0 MHz [65] (12.0 dBm) (no=
 IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6295.0 MHz [69] (12.0 dBm) (no=
 IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6315.0 MHz [73] (12.0 dBm) (no=
 IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6335.0 MHz [77] (12.0 dBm) (no=
 IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6355.0 MHz [81] (12.0 dBm) (no=
 IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6375.0 MHz [85] (12.0 dBm) (no=
 IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6395.0 MHz [89] (12.0 dBm) (no=
 IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6415.0 MHz [93] (12.0 dBm) (no=
 IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6435.0 MHz [97] (12.0 dBm) (no=
 IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6455.0 MHz [101] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6475.0 MHz [105] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6495.0 MHz [109] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6515.0 MHz [113] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6535.0 MHz [117] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6555.0 MHz [121] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6575.0 MHz [125] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6595.0 MHz [129] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6615.0 MHz [133] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6635.0 MHz [137] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6655.0 MHz [141] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6675.0 MHz [145] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6695.0 MHz [149] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6715.0 MHz [153] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6735.0 MHz [157] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6755.0 MHz [161] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6775.0 MHz [165] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6795.0 MHz [169] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6815.0 MHz [173] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6835.0 MHz [177] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6855.0 MHz [181] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6875.0 MHz [185] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6895.0 MHz [189] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6915.0 MHz [193] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6935.0 MHz [197] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6955.0 MHz [201] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6975.0 MHz [205] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6995.0 MHz [209] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 7015.0 MHz [213] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 7035.0 MHz [217] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 7055.0 MHz [221] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 7075.0 MHz [225] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 7095.0 MHz [229] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 7115.0 MHz [233] (12.0 dBm) (n=
o IR)
>=20
>=20
> [After iw reg set US]
>=20
> Frequencies:
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 5955.0 MHz [1] (12.0 dBm) (no =
IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 5975.0 MHz [5] (12.0 dBm) (no =
IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 5995.0 MHz [9] (12.0 dBm) (no =
IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6015.0 MHz [13] (12.0 dBm) (no=
 IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6035.0 MHz [17] (12.0 dBm) (no=
 IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6055.0 MHz [21] (12.0 dBm) (no=
 IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6075.0 MHz [25] (12.0 dBm) (no=
 IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6095.0 MHz [29] (12.0 dBm) (no=
 IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6115.0 MHz [33] (12.0 dBm) (no=
 IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6135.0 MHz [37] (12.0 dBm) (no=
 IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6155.0 MHz [41] (12.0 dBm) (no=
 IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6175.0 MHz [45] (12.0 dBm) (no=
 IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6195.0 MHz [49] (12.0 dBm) (no=
 IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6215.0 MHz [53] (12.0 dBm) (no=
 IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6235.0 MHz [57] (12.0 dBm) (no=
 IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6255.0 MHz [61] (12.0 dBm) (no=
 IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6275.0 MHz [65] (12.0 dBm) (no=
 IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6295.0 MHz [69] (12.0 dBm) (no=
 IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6315.0 MHz [73] (12.0 dBm) (no=
 IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6335.0 MHz [77] (12.0 dBm) (no=
 IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6355.0 MHz [81] (12.0 dBm) (no=
 IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6375.0 MHz [85] (12.0 dBm) (no=
 IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6395.0 MHz [89] (12.0 dBm) (no=
 IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6415.0 MHz [93] (12.0 dBm) (no=
 IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6435.0 MHz [97] (12.0 dBm) (no=
 IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6455.0 MHz [101] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6475.0 MHz [105] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6495.0 MHz [109] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6515.0 MHz [113] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6535.0 MHz [117] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6555.0 MHz [121] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6575.0 MHz [125] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6595.0 MHz [129] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6615.0 MHz [133] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6635.0 MHz [137] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6655.0 MHz [141] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6675.0 MHz [145] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6695.0 MHz [149] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6715.0 MHz [153] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6735.0 MHz [157] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6755.0 MHz [161] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6775.0 MHz [165] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6795.0 MHz [169] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6815.0 MHz [173] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6835.0 MHz [177] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6855.0 MHz [181] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6875.0 MHz [185] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6895.0 MHz [189] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6915.0 MHz [193] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6935.0 MHz [197] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6955.0 MHz [201] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6975.0 MHz [205] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6995.0 MHz [209] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 7015.0 MHz [213] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 7035.0 MHz [217] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 7055.0 MHz [221] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 7075.0 MHz [225] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 7095.0 MHz [229] (12.0 dBm) (n=
o IR)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 7115.0 MHz [233] (12.0 dBm) (n=
o IR)
>=20
>=20
> I have tested the iw list command before and after setting the region to =
US.
>=20
> The Result: The frequencies in Band 4 remain identical. Both "Before" and=
 "After" already show (no IR) for
> all 6GHz frequencies. There was no change from (disabled) to (no IR), as =
they were already set to (no IR).
>=20
> Even with the status at (no IR), the card is unable to see or connect to =
my 6GHz SSID, which is confirmed
> working on other devices and even with Windows 11. It appears the card re=
mains in a passive-only state
> regardless of the regulatory setting.

At 6GHz channels, it should be passive scan.=20

With "no IR", I suppose it can find AP operating on 6GHz channels, so let's
clarify scan first. Setup a trace-cmd before doing scan at another terminal=
.

=C2=A0 sudo trace-cmd record=C2=A0 -e mac80211 -e cfg80211

Then, do scan by

=C2=A0 sudo iw wlan1 scan | grep "\(SSID\|freq\):"

Stop trace-cmd by ctrl-C, and check report by

=C2=A0 trace-cmd report

If you can see something like below, AP on 6GHz channels is found:

=C2=A0 (trace-cmd report)
=C2=A0 cfg80211_return_bss:=C2=A0 aa:bb:cc:dd:ee:ff, band: 3, freq: 6135.00=
0

=C2=A0 (iw scan result)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 freq: 6135.0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 SSID: abc_6G


Ping-Ke


__________


Hello Ping-Ke,

I have completed the trace-cmd recording and analyzed the full report.

A search of the entire report shows zero entries for band: 3 and zero entri=
es for any frequencies in the 6xxx.000 range.

The trace successfully captured scanning on Band 1 (5GHz), with many entrie=
s for freq: 5500.000 and 5530.000.

The manual iw scan also returned no results for 6GHz.

So we know the card appears to be successfully scanning 2.4GHz and 5GHz, bu=
t is completely silent on 6GHz. Even though iw list shows the channels as (=
no IR), the driver/firmware does not seem to be initiating a passive scan o=
n those frequencies.

I have the trace.dat file ready if you would like me to provide it.

Thank you,

Chris

