Return-Path: <linux-wireless+bounces-30017-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F441CD29E7
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Dec 2025 08:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43FC1300CBA6
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Dec 2025 07:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC5C1E766E;
	Sat, 20 Dec 2025 07:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="NUfxZe0H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sonic305-1.consmr.mail.bf2.yahoo.com (sonic305-1.consmr.mail.bf2.yahoo.com [74.6.133.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D569F2AE68
	for <linux-wireless@vger.kernel.org>; Sat, 20 Dec 2025 07:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.133.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766216222; cv=none; b=SYhkfzE+jeQAGlbhsppIbXm0skD903Z4K7aGK7tdTR00QlzdKddEMsT+SAZuHlcHokkAUMaDKcWz7m/bw6MHz5jW+7x6rHWuKHMmbgwfnuy6sXhDpI9tDoO7GT1YWhu1MaljEXX1Q3NqeFETCJdZCMGCTtP+dDfNK2GE88hYdIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766216222; c=relaxed/simple;
	bh=04NvTFnY0sMXvRDA3T0fuVePtvcp0I89pqq1kgGtLe4=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:
	 References; b=MFQ3/AHhHnRlj4yIec9JEjVpnH5eqWsAG6sCvlNMo0qQ2tJp/alkbscAsF+XO1XhfaIWQ7xfNkqpUYv/8YbCIl6umNWH0ULSz44TRj/Ix89L4wO9kplKTAc/KsWIw2YL3meIpTaPmgzwSgtBJSsQLLWXtMqkKV3aV/aKeOlpILI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com; spf=pass smtp.mailfrom=aol.com; dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b=NUfxZe0H; arc=none smtp.client-ip=74.6.133.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1766216214; bh=04NvTFnY0sMXvRDA3T0fuVePtvcp0I89pqq1kgGtLe4=; h=From:Date:Subject:To:References:From:Subject:Reply-To; b=NUfxZe0H+zeV4z0/z0blZDpIUum78JmS0H8n2jOh2XKd3GU5VTvnifQQ5WJvSKgYHSvJGumTCEjwOu6XqhIzQN9LpiMRLEhSXiElYESfBQguHyDmGVtWkYB/ktt3jRhsqpa2K3MktUa1AQkOyjbyqxj8ylMFZffuckA3lhdw9xpmRKmGSjABoEx6VB+jVnQEAwvsM6WHkJLPGTqcpBuZqmeLlm/lMxrFGDH36UDQsFVQ6zHizTYxD7J1CTk4l2bvm43q1iuJZ0iOYzub5t9OtY5cF8AGboxoEULLa6OWi/+fHIUnm9ZoN+HrITZPLXfdSQtRcA9gnLGwvXrQESUshQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1766216214; bh=fvP95/gpsSSHVFBzJlFSjKdTygpoQFiHiI9OgWwukNS=; h=X-Sonic-MF:From:Date:Subject:To:From:Subject; b=uKur1WoPTuZw3uAe5KxHRAIrNRuPEdd1DO4vV/zxcg5IgMkx44iXHEYxBiQfIB7eiXSjaLO1NJLYQqB2cxKxM/6i5O4kvyb8lWmmrxaK44rlIkIZLC3wK17xrOHEOtoQe6N8n4SnZEu25/a6kliKa4fQcycHihfFvKDFIWC2L4ogGJw5GOV6S2pLTn0rMHYTCLLNo/V4guzoAaKbEpqLUKTgV75BLMblhhOJEMIEnAQIu8EQ24v49GEO79fd1qYL4w4LAvCDCveBTayPK6wI2eAb2pjh9C7JiCQCbdzuCabQn/Bj7b5ZuSSjTOz9FOgyoKUDs1gzdtSq/O/rJr5MmA==
X-YMail-OSG: 0pTs5IYVM1nESxWxP.TNEQELynoaHeUpCRAHHhYRAp5tEnxNQDt8eZtDO6SZnXG
 QRvNVCBWEwGlOVbUZ7vkWUhXtjfNPrYtHdHVOCubAQX15OXup4_6UyGeshQorNgBRQh0nP_6vTrw
 _0o8cTtqhbg4RjepX6GF4Wku0LkAR0lWVphoQ0yInZ7mEXHpXdciWa1ohHbkPs3Qt6JYk_pnWOOO
 izWLOMzrQu5EI6XLENhKndhQn8Gi.G6Id.fdLaIu5B3VI.9nLqJMnqPU2p7Jv2LFzrJVHG1aJJrt
 kIyiAsD9SZp.2sA.qwqqd7TT_qeCCkN1w_rLlq9tjc0MJwpxU1O0HPuBGYNaVoUv0U8YvZVDKBAY
 HGF5394Juf5K656uqIg.xCzOHgVPI4T.70sGYzbWyPXxHda_YBeGasnh7WwVBApkbeSWCaISVMiw
 Cqj17HRuI9GyyUPAzaIMQ0Uw_9x5Tgi3sn1n6qvH75L7yB2wz053zmK3GbI1vZdhBnIa9szPNZSP
 F9fdYKBbgx9NqTtNKiUqBt0JKbsnQ5jCQNWEbCzY7vSzFFmjYttIUnwWIEUz1D9jhdLmRJe0qVSi
 wPheF1PfOJDS1a3iGk_FLLA8X4EcKg3HvpRhYmHQ9j3ApfAyw2xC0z.qDtOKEPnY6XC78NH_bNgo
 LoZSUb1JPu.fqNxJmKoT5piLsxCMp0EDEB00f5CJsx1v4KXSnXvpOc9tWggisrEfZ1aCjFnc2eFe
 SKFFBMFrsWmylXJG9Ybu7sTvHQ3qG0wmK0diTlzCIcDa5hzXPS4MccMwSqNXPXTBsaPjwnf2RdAc
 3peLNsgR.XIuDIN3LyUv.15f8YlONbMXcIKFJia9LSCVsIUQt9ZgfCcntUJnHts5Z44Bud4KfwsL
 M2dG5btq2YtC8WW7S_zmooUiurvSKeyrORVMcHcGmulvKgx7jwQkQOilB_.YJQOudolQu.QhcHXH
 ritCP2FkjMK4ToY1XrKR91ZmgwqZPUqD50_URfmaGHXRLDWpp6O2lv2vajAoI24Fz2D6WMh7ENs7
 ZonUc_Bn2eGGR6s34Lasr68nbsBxzTRj_Csem.YDF_EWIFD5aa8WvgF3bkCu5Xp1aiB4hPBBlun0
 .qsW6CSBaTRdccuTyX1prXoMBm65cTtX91Hjmsp2fiFV7Fvdhh5RiCf8BOVchyPjNwmYkFmB86g0
 7lTRHo49CNARr41_ZxKPgxsWAWWzpKCoNst9BPSTB5k8VQYDOfLK4.0m3siGHT.PqR0nu09Kpo92
 TRZCeBBK2L5jRnN1eehMpQJWcc0QBB9w0XWBWrJqsI_CSt1BX8_MzCAuQ7hWXY2008Kiujqg4L7C
 5Q9ooAiRFKR6vvfcIhICjVQ2cFoUkpBLKEqFhcXqqM5gBV4Jfnwg8c9_DIujx31T7Lps_iZrht.i
 G2uD4CS7WHswfx0Jl7NzDZqvbnjKOAza6JD2j.d0gXCpL3scOVT3TszxT2Qebxx2j8XTCt4Y3cTk
 2fSd3WSUq_WpEwrezBofI0ZDQ68n6LYcB0wJw27di1GD8kl9YdfUvA5DHdPAOAMd78mIFkhieqdo
 gJ7jlGTCab356nNwHXu0mrWYJjn7PLuKzDLE3Dh.cJpm0sZHrtsLYBhD0s7p9qIgNGu8s1e_x1fU
 mfkje4AvJgh3loGmvJkN292m.4yDI.A67ITPoz6hUQZQ27JP9bcrC5AguX3MHf4Wfm9GJT8DXfup
 FklaNMYqlLJjZxpEslCNXf4q_qusR_GOhmcwpOfoyZYWuEJJWFYPOLJl1y_lTgV03cAxvYrhmdYS
 X6kuUvpIOyduS0.PD7R.N_LSlHHcTf7CQfc5.GdnIFIAGFmXCE8ToQxGWvtUsc67kFzDhYP7gs.S
 Hc1iDwiSSS6vNANTazKBiEwVXByeYMWxG6zjgVeZDx_eL4LDqXY3OBdxDzzitXIRCYuC_w0aCAyB
 5mi_WpLDK.p4gA1pVqa2NN3owELYErtMGdG13lSl0WqfCDC4FUghAoN.4ttm4Sn24SfyUk15Psfi
 sLWGQalOQVqKEbQiqdXM686GodnYYhc1p3ayc.P1CmoR_dwC8oeyuWekZ82XTi4yY04u9FHdvH64
 eYzCSWAezkuaxsRTA0ABhP3EoNHtc.j3mXxf.l__xAm1EKCQmazD8XM5KbZ41GGOWQrDmYAo5.xc
 ZhpT7O4NSuSKWXJeMlTWoxKKLXakWFW9fYEfElGtV.pywETR7.1kxTq3JH8ih1e66aBWXTcjaBmy
 GtDq4AIYyqbZnMCPNiQPhYKM-
X-Sonic-MF: <russomch@aol.com>
X-Sonic-ID: b35d48b6-57aa-4276-990b-ceeba9a3e0e6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Sat, 20 Dec 2025 07:36:54 +0000
Received: by hermes--production-bf1-55f79789b4-bpm5h (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4dcb5bd9949bba3c68a4b3e05a320d3e;
          Sat, 20 Dec 2025 07:36:53 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From: Chris Russomanno <russomch@aol.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Sat, 20 Dec 2025 02:36:42 -0500
Subject: [BUG] Intel B580 (e20b) HDMI Flicker & Realtek RTL8922AE 6GHz missing - Mint 22.3
Message-Id: <AB8446D8-708B-4971-8852-87353112E60F@aol.com>
To: intel-xe@lists.freedesktop.org, linux-wireless@vger.kernel.org
X-Mailer: iPhone Mail (22H124)
References: <AB8446D8-708B-4971-8852-87353112E60F.ref@aol.com>

Hello,

I am reporting two issues encountered on brand-new hardware using Linux Mint=
 22.3 with Kernel 6.14.0-generic.

Hardware Environment:
- GPU: Intel Arc B580 (Battlemage), PCI ID: [8086:e20b]
- WiFi: Realtek RTL8922AE (rtw89), Firmware: rtw8922a_fw-3.bin
- Display: Samsung 4K Monitor connected via HDMI (No DisplayPort available)

Issue 1: Intel Xe HDMI Flickering
The Samsung monitor experiences intermittent black-screen flickering (1-2 se=
conds) at both 4K and 1080p resolutions. This behavior is not present on Win=
dows 11.
Troubleshooting attempted:
- Added kernel parameters: quiet splash i915.enable_psr=3D0 xe.force_probe=3D=
e20b i915.enable_dc=3D0 intel_iommu=3Digfx_off intel_idle.max_cstate=3D2
- Forced "TearFree" and "TripleBuffer" in xorg.conf.
- Frequency remains at 60Hz.

Issue 2: Realtek RTL8922AE 6GHz/WiFi 7 Missing
The card functions on 5GHz (1200 Mb/s) but does not scan or see 6GHz frequen=
cies.=20
Troubleshooting attempted:
- Set regdom to US (iw reg set US).
- Driver options: rtw89_pci disable_aspm=3Dy, rtw89_core disable_6g=3DN.
- 'iw list' does not return any 6GHz/6105 MHz frequencies.

Please let me know which logs (dmesg, etc.) or specific tests you would like=
 me to run to assist in stabilizing support for these 2025 components.

Best regards,

Chris




