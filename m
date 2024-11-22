Return-Path: <linux-wireless+bounces-15595-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 586669D5B13
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 09:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E1092832C7
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 08:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786C8165EE6;
	Fri, 22 Nov 2024 08:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="cFiUfi3K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ABE156F3F
	for <linux-wireless@vger.kernel.org>; Fri, 22 Nov 2024 08:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732264602; cv=none; b=fUIA+1fAyjBEPTZnSVPR52kic7S+1L+iCHoC/An8pxB4rw6iOJnd0/HaszhrCwuA1XbElnIVf1Gi9NE+DKSqCG0NxZMmgdQec6zN5a2aoL7JIid7hNTPlxGBWvG7x7q4J3kD/IeFbFewA3O9819hwW3U/DnPDtTdFjBgEelc5DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732264602; c=relaxed/simple;
	bh=AH7zn0bQ5VBd04xuK9woCP6HnjMQEWmhoXwEYWrs918=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t4N0xgyiM6UPonhXERbX6hwFFTPPxtaWT5UZyt3rzypCr2uUMB9cluNqprxCogBmrwH+P2byVoqdMmGsHQbGqbnMpXHAJAY8OWDsIXaEAn7+cuSLynbDZTf6TiszJy5sJ70TzuTcTdpq3d9VIAGKJg9ZsrVlEYNlgwy3HMpfeFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=cFiUfi3K; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=AH7zn0bQ5VBd04xuK9woCP6HnjMQEWmhoXwEYWrs918=;
	t=1732264601; x=1733474201; b=cFiUfi3K3Ea5Bm+QEEGkKzU2q87czyahBQyTC6VLGDr6h3r
	LMAOvzWCKDhzT57+TAqBe48mGs7Q5qXLsjWHfNL3bqtrEjNORok0Gi1Gad0KIk9fm6LSH1IX47P9A
	7jPVKpTjVHq1HMOetLgZli4MER2Qt3c4i0r/5R/n1iIaD0Jl6Hmt74Zm91+AcGQHMSIYt4B8iCy/n
	RYWmBYFducD7yeozUF2VfcVs34LEKICF3tkosbhQ/gdEVZKVu4clfWUAWzFOBQguaaNnLr32OGkH9
	6HaDZ3NpYRBVYMP+YeAuqvsYn4i6ER+cicqQ7gTJ7ywgP55kOcRldoHwz5GRcWkQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tEP9Y-0000000BUgR-3P9N;
	Fri, 22 Nov 2024 09:36:36 +0100
Message-ID: <0158732da5a64f907326f89de8f9c8aa27aae874.camel@sipsolutions.net>
Subject: Re: Regression "Direct Firmware loading for Intel Wi-Fi 6 AX201
 (rev 30) QuZ-a0-hr-b0-77 failed"
From: Johannes Berg <johannes@sipsolutions.net>
To: Zoran Davidovac <zoran.davidovac@gmail.com>, 
 linux-wireless@vger.kernel.org, Stanislav Yakovlev
 <stas.yakovlev@gmail.com>,  Miri Korenblit
 <miriam.rachel.korenblit@intel.com>
Date: Fri, 22 Nov 2024 09:36:36 +0100
In-Reply-To: <f5c7eb4f-fd8d-457b-92c4-8957f70888b9@gmail.com>
References: <ab27218b-5e16-4932-a497-eb19491568b1@gmail.com>
	 <f5c7eb4f-fd8d-457b-92c4-8957f70888b9@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

Sorry, what, I'm confused.

> it will not even try to load next working QuZ-a0-hr-b0-74.ucode


That's intentional... We released -77 firmware for this device in 2022,
a little over two years ago. We can't and won't support ancient firmware
*forever*. We've already supported it for a very long time.

> either direct loading or with included firmware in kernel
> ("CONFIG_EXTRA_FIRMWARE=3D"i915/tgl_dmc_ver2_12.bin intel/ibt-19-0-4.sfi =
intel/ibt-19-0-4.ddc iwlwifi-QuZ-a0-hr-b0-77.ucode"
> caused kernel reboot) and that kernel 6.4.X could load
> firmware direct or included.

I have no idea what might be the issue here. Perhaps your kernel ends up
too big for the way you're booting it? If you insist on booting without
initramfs but with iwlwifi built-in, you need to debug and fix *this*.
Or I guess you could always try probing/binding the driver again after
the system really boots.

> =C2=A0vanilla kernel from 6.11.9 log:=20
> =C2=A0[ =C2=A0=C2=A0=C2=A01.903903] Intel(R) Wireless WiFi driver for Lin=
ux=20
> =C2=A0[ =C2=A0=C2=A0=C2=A01.904006] iwlwifi 0000:00:14.3: enabling device=
 (0000 -> 0002)=20
> =C2=A0[ =C2=A0=C2=A0=C2=A01.906832] iwlwifi 0000:00:14.3: Detected crf-id=
 0x3617, cnv-id 0x20000302 wfpm id 0x80000000=20
> =C2=A0[ =C2=A0=C2=A0=C2=A01.906890] iwlwifi 0000:00:14.3: PCI dev a0f0/00=
74, rev=3D0x351, rfid=3D0x10a100=20
> =C2=A0[ =C2=A0=C2=A0=C2=A01.906891] iwlwifi 0000:00:14.3: Detected Intel(=
R) Wi-Fi 6 AX201 160MHz=20
> =C2=A0...
> =C2=A0[ =C2=A0=C2=A0=C2=A01.907036] iwlwifi 0000:00:14.3: Direct firmware=
 load for iwlwifi-QuZ-a0-hr-b0-77.ucode failed with error -2=20

but I guess that's when you try to have wifi built-in and no firmware
built-in

johannes

