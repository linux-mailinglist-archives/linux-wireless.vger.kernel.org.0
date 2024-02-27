Return-Path: <linux-wireless+bounces-4065-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC1B868C11
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 10:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 979701F22CC9
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 09:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A78136646;
	Tue, 27 Feb 2024 09:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="MzYOTGsX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45B015D0
	for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 09:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709025687; cv=none; b=KnK6T8yBICNAbY0SpLRdGNWBxiaGg4Z8D/VMCWZDzPhjIF08oBgUWSwTGT6dURk6rh0w/jZ9/ff6RbXz/QUQrKhQvw7QzUmXAqrjti8xSsiVKovKCTbRMHshr7bqCT88m6bWhB89phO0wv/FKzpikrF4DSNhrFaD2IvQmoOwW7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709025687; c=relaxed/simple;
	bh=oKxiK5s2uWZDox+i4fVrYUL+Yrb44uR49YECWajWV6Y=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ngEE9GWO2RQ/jTyrnE5a9N7+gjwwRCuVC4Do/oNq2HNlkuIavCBlHC9wgkrcUgkR31kPy9jBXcp9spBxKAGv3D451tptE2KaZhyzq0rAD1HDlwTO+/lZ1OAfMbDvhTl/paHr6wEY45l45YJ992LKmc7VMLNAlJs69FhtFFmwSkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=MzYOTGsX; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=oKxiK5s2uWZDox+i4fVrYUL+Yrb44uR49YECWajWV6Y=;
	t=1709025684; x=1710235284; b=MzYOTGsXrJB1kbqKYHGHfCW/3cJY0tDYqlrSbuQQjrH9czR
	vFN/zHT8pVL/wRFxTVKQiAbdbv1CcEzhp0nYQzLZUgE7VzBI7rnyOftAArFBeNPXvnodBbLD+rE93
	gVhvoOKoB2kYGkTILsI91IiqxVsMGOR2RYpuo+MIV5pWnTINnP0XQ1HLzHlK+bz6PuXynP8PX8QLl
	UozK9D7ImiseS4isGJ6YlI82QYf2xzjr23hVU2/ZX2TW5ttUEGo+2u3LtabrD9fNRqFuGBgwk3Pxm
	X7pBAHQLJSRpdeYAsI67WGemrjkrhL7u4HywzJ+kJJSHetGMxZQ3iGTOi8PrWKDw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1reteE-0000000AYJU-2LNV;
	Tue, 27 Feb 2024 10:21:14 +0100
Message-ID: <9edf7003715cfdda3c794f3adbaeac5f36ada8ee.camel@sipsolutions.net>
Subject: Re: "iwlwifi: probe of 0000:00:14.3 failed with error -22"
From: Johannes Berg <johannes@sipsolutions.net>
To: Harald Dunkel <harald.dunkel@aixigo.com>, linux-wireless@vger.kernel.org
Date: Tue, 27 Feb 2024 10:21:13 +0100
In-Reply-To: <dd1e2440-bb05-48d7-9f68-29bae758110d@aixigo.com>
References: <dd1e2440-bb05-48d7-9f68-29bae758110d@aixigo.com>
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

On Tue, 2024-02-27 at 09:12 +0100, Harald Dunkel wrote:
> The Intel Wifi hardware of a colleague's Tuxedo laptop (running Debian 12=
,
> kernel 6.1.76) isn't found at boot time anymore. It doesn't come back on =
a
> reboot. The kernel log shows
>=20
> [Mon Feb 26 13:21:23 2024] Intel(R) Wireless WiFi driver for Linux
> [Mon Feb 26 13:21:23 2024] RAPL PMU: API unit is 2^-32 Joules, 3 fixed co=
unters, 655360 ms ovfl timer
> [Mon Feb 26 13:21:23 2024] iwlwifi 0000:00:14.3: enabling device (0000 ->=
 0002)
> [Mon Feb 26 13:21:23 2024] iwlwifi 0000:00:14.3: Adding cdb to rf id
> [Mon Feb 26 13:21:23 2024] iwlwifi 0000:00:14.3: Detected RF 0x1010c000 f=
rom crf id 0x504
> [Mon Feb 26 13:21:23 2024] iwlwifi: No config found for PCI dev 51f1/0000=
, rev=3D0x370, rfid=3D0x1010c000
> [Mon Feb 26 13:21:23 2024] iwlwifi: probe of 0000:00:14.3 failed with err=
or -22

Are you saying that it used to work with that same kernel, or are you
saying that it worked with an older kernel?

In either case, do you have a working log?

If you really have subdevice ID 0000 then something went wrong and you
have a blank OTP (now), which seems very strange.

This is an integrated NIC where part of the NIC is integrated into the
platform, and other parts are on the companion RF (CRF), so could also
be that the CRF module isn't seated well any more in the slot and it
just cannot access the data properly?

johannes

