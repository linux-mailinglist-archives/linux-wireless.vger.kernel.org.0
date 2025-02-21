Return-Path: <linux-wireless+bounces-19304-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CB3A4000A
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 20:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FCF41653BF
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 19:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFE21FF1BB;
	Fri, 21 Feb 2025 19:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="nFubQdeA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37291EBA0C
	for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 19:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740167540; cv=none; b=iUvuL/wm6k2DReqGDBut9CiXhp/itxozATlNIDIFVFtbzYzJc3S46TcD7wvpIKtx78Z5UM2rBnjNY7c9yL20K4CPF0R6EbKDNy/EbPRIKBI7aeHtWI8/CpbvK/hUxu82dqtmcWxOhBK5qCw0I4MCk9MxLQBTT1YNFbyRzC7reLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740167540; c=relaxed/simple;
	bh=TUFOEgXDEIJ1HoWNDNDRljK/Tunzb+ad81+WDLPYoG8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rG4FiZMm+BMvx4aTlHbQarx+7mUX0RVZecU8HnZtQ2W28zlDSG8hAUKnxQTCrPXMEALM2zBy69U4oFHkJPGKCnZVZU30Ll9lfY3cel+f0gihO5bsbHehAM2/yu3UvV4VRKfNkqtR3brb/jugTlRT8SmOBVbs8NJpEnx91zPIXMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=nFubQdeA; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=TUFOEgXDEIJ1HoWNDNDRljK/Tunzb+ad81+WDLPYoG8=;
	t=1740167538; x=1741377138; b=nFubQdeAS27k+abVjJkJxThW3lpKHwjetsC7REixtb1731+
	9HAkdtvTv45QzhyOR9dfg6r+dbzXjvsIQGrmBzhN0KfnLia2S5Ooxozaa/ScpE3u29FXb3lJ+L6ZX
	mlrspvxJSV8dwJvHckGASpjdh1y8TnEiKYP88O5PCjlwo3He22Ry+gbgQTa3fAd0mNS3vmvZ/fu38
	opG34NzX33m9ApLFzjNlqBITenJyLfHRdJQoy2Ujy2ubjlJMo8V/7JA36d8vHpDlv0Jk2eQl1ceaT
	L5YUhvWzwkWSp514jPP3apQkK+LrJV/mXWbaUMGhzCbB0D1KVsV6W+pca4sHxh8g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tlZ4K-00000005YhL-12UF;
	Fri, 21 Feb 2025 20:52:16 +0100
Message-ID: <1ec5dab3315e746b7682d092f20ab3f09011da05.camel@sipsolutions.net>
Subject: Re: /proc/net/wireless has gone missing in 6.13
From: Johannes Berg <johannes@sipsolutions.net>
To: Alex Gavin <a_gavin@icloud.com>, "Artem S. Tashkinov" <aros@gmx.com>, 
	linux-wireless@vger.kernel.org
Date: Fri, 21 Feb 2025 20:52:15 +0100
In-Reply-To: <035d9edc-9290-49ac-b875-749e709074d4@icloud.com>
References: <ea0541a6-9d4f-4d1c-8b4b-4bb29eb84639@gmx.com>
	 <035d9edc-9290-49ac-b875-749e709074d4@icloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2025-02-21 at 11:01 -0800, Alex Gavin wrote:
> On 2025-02-21 9:10 a.m., Artem S. Tashkinov wrote:
> > Hello,
> >=20
> > Multiple people report[1] that /proc/net/wireless has gone missing in 6=
.13.
> >=20
> > Many utilities/applications depend on this file presence.
> >=20
> > Please restore it as the kernel mustn't break userspace [interfaces].
> >=20
> >=20
> > 1. https://bugzilla.redhat.com/show_bug.cgi?id=3D2334171
> >=20
> >=20
> > Regards,
> > Artem
> >=20
>=20
> Support for /proc/net/wireless is still present in the kernel. However, i=
n the GitHub issue
> referenced by the bug report you linked, user 'clnhub' noted that Fedora =
has removed wireless
> extensions (wext) support from their 6.12+ kernel builds [1].
>=20
> You can still build it into the kernel by enabling 'WIRELESS_PROC' in you=
r configuration.

I'm happy to hear that! :-)

I'll also note that since multi-link / WiFi7 support is far more
complex, newer devices with multi-link capability will not have support
for wireless extensions, even if it's enabled /proc/net/wireless will
exist but the netdevs for them won't show up. Since that affects only
new hardware, it's not a regression, though I guess in some cases it
might technically depend on the driver.

johannes

