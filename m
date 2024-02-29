Return-Path: <linux-wireless+bounces-4256-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F01F86CC47
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 16:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECC472814CD
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 15:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8EB7D419;
	Thu, 29 Feb 2024 15:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="VTV7AJrr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4E31E885
	for <linux-wireless@vger.kernel.org>; Thu, 29 Feb 2024 15:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709218861; cv=none; b=gdPYtx4m9lgfwiINR3+7tN6bDMhQJ18EpCoIDKLBo/vAWKtQPN/XNdkaJFRdOBnh5uXQX5pLkSZ7nJelRPuHuhiatblRb/j/EOQ5eXaArHWzqo3gqqgzGehsaT6lrw5wOe9eOf4EZJmvDeNWwddVJeIXgkio97HRvgMJY4/WRyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709218861; c=relaxed/simple;
	bh=cUVgi5ZDWIz41sKJ7g1DF368Aa3pDomwK85wey4ibiI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pW4DXJVt6tDFICZP4fW9B0OUZhJejeDaowfUANUmy0cd8/vsoSZi8UPnK0GHy3Bed83jZt3hh8psU00wND7zCL+6SMXuFDEx/trj1nQ9f/LdtwN97tm/iiY/VQQjKpXBcr76rxY3uRR/Z+XzjtMs4EdOLQTwcslEPCoP875yLmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=VTV7AJrr; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=mU56VwBgI+WrEQ5CJfeHa/rJkmhZfltDPzzNAXEskWQ=;
	t=1709218860; x=1710428460; b=VTV7AJrrjuN8bg23mZYvgVD1XWPCFF9OoOO/BX970kHPZst
	WszwtjoYPUSjOqw7pqoS84BGzGBrpijtkLPDH7TBOSXmqmxhl5LebjCT8ddpXF1Vzxkp6bHg7qWEv
	UXFqCpgYxsQjwLsFyYW8XjUKJOxgaSpFSoYbvbsqhMfRuhXsXwMSuJgdpoQvnUeFftEQips76sEEr
	+RM4NBRQIuSy9BVQgbkyxSbFDO+F278tyXsmrkNz3/BOmEUkGdUpkZe0+sr9/BKrB+9LN3QMOSikB
	zVbeABrGhEMSPVumYuUnrb+7UFY3522xtZWw2FgjGfC2a2fni73bLfkjLjEyRRlQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rfhu5-0000000DeTz-2k4h;
	Thu, 29 Feb 2024 16:00:57 +0100
Message-ID: <88fe8575145bbd78a8207537dae85c81aa4955f0.camel@sipsolutions.net>
Subject: Re: "iwlwifi: probe of 0000:00:14.3 failed with error -22"
From: Johannes Berg <johannes@sipsolutions.net>
To: Harald Dunkel <harald.dunkel@aixigo.com>, linux-wireless@vger.kernel.org
Date: Thu, 29 Feb 2024 16:00:56 +0100
In-Reply-To: <5cd86456-ff2b-4e4a-aa12-1e11e5de92a5@aixigo.com>
References: <dd1e2440-bb05-48d7-9f68-29bae758110d@aixigo.com>
	 <9edf7003715cfdda3c794f3adbaeac5f36ada8ee.camel@sipsolutions.net>
	 <b9b2224a-f021-483a-8606-6aed94c5f6f9@aixigo.com>
	 <795b376aa2c9112527cf135a5176f01c6af69ade.camel@sipsolutions.net>
	 <5cd86456-ff2b-4e4a-aa12-1e11e5de92a5@aixigo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi Harald,

> The laptop recovered on a power off reset over night. It worked again
> on the next morning (I was told). I logged in via VPN to upgrade kernel
> and ucode file. My colleague rebooted it once again, and it is still
> working.

Fun :)

Well also good I guess. No idea what could have happened though.

> root@ppcl013:~# grep rfid /var/log/kern.log
> 2024-02-26T09:55:24.858020+01:00 ppcl013 kernel: [   82.527151] iwlwifi: =
No config found for PCI dev 51f1/0000, rev=3D0x370, rfid=3D0x1010c000
> 2024-02-26T13:21:24.361666+01:00 ppcl013 kernel: [   20.136735] iwlwifi: =
No config found for PCI dev 51f1/0000, rev=3D0x370, rfid=3D0x1010c000
> 2024-02-26T15:30:25.639827+01:00 ppcl013 kernel: [   38.203931] iwlwifi 0=
000:00:14.3: PCI dev 51f1/0000, rev=3D0x370, rfid=3D0x3010a100
> 2024-02-26T15:30:25.639828+01:00 ppcl013 kernel: [   38.204862] iwlwifi: =
No config found for PCI dev 51f1/0000, rev=3D0x370, rfid=3D0x3010a100
> 2024-02-26T20:45:28.752692+01:00 ppcl013 kernel: [   21.294757] iwlwifi 0=
000:00:14.3: PCI dev 51f1/0074, rev=3D0x370, rfid=3D0x10a100
> 2024-02-26T20:45:28.752723+01:00 ppcl013 kernel: [   21.813877] iwlwifi 0=
000:00:14.3: Detected RF HR B3, rfid=3D0x10a100
> 2024-02-27T09:11:49.132498+01:00 ppcl013 kernel: [   48.939136] iwlwifi 0=
000:00:14.3: PCI dev 51f1/0074, rev=3D0x370, rfid=3D0x10a100
> 2024-02-27T09:11:49.132582+01:00 ppcl013 kernel: [   49.420458] iwlwifi 0=
000:00:14.3: Detected RF HR B3, rfid=3D0x10a100
> 2024-02-27T09:44:52.740746+01:00 ppcl013 kernel: [   57.435249] iwlwifi 0=
000:00:14.3: PCI dev 51f1/0074, rev=3D0x370, rfid=3D0x10a100
> 2024-02-27T09:44:52.740759+01:00 ppcl013 kernel: [   57.764033] iwlwifi 0=
000:00:14.3: Detected RF HR B3, rfid=3D0x10a100

That's interesting though because at one point it bound to it properly,
but still had a 0000 PCI ID and the (likely wrong) RFID 0x3010a100, vs.
most of the working cases have 0074 PCI ID and 0x10a100 RFID.

So looks like something is not quite stable with this system, but it
still worked most of the time!

> We will check when my colleague is back from home office, but this
> might take some time.

Sure. Seems to work now, so at least that's good, I guess.

I still think this might be an issue here, or maybe the CRF is just
flaky somehow? Don't have any experience with these kind of issues
either, TBH.

Anyway, glad it works again.

johannes

