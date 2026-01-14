Return-Path: <linux-wireless+bounces-30809-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EDED1DB23
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 10:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12AD83007FF8
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 09:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666E1325709;
	Wed, 14 Jan 2026 09:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="lrRMNgLu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0589F3328F0
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 09:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768384085; cv=none; b=hpElPCoSM4IYTR9pD5VaL/U9oeC/UnOK4NPFYqHpbq56CzmSIJ8p1ZghP1dm2aXRjGxIzurxPziQxfKv6xTmtJlZam+YO+49+bSnbSPJ5dmIOrdAAfaxEnlSIbOfbKBqNuc1C+Hlfj6KgwTWOycFUoiNeS97rpLyVckJIfzOJJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768384085; c=relaxed/simple;
	bh=ufpRZ0O09Okc26dzuVpIdsUxMRmkbneXYKpFAjnsc3o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fob8ZEtxG05Z5H0HrpDU7IYz7jMYMncXxmCZho0c88s1yCOABYQbAh4mJcLVdUYiZtvCT7is81gaTBfRtu05Srfc+B7wvhhJcAXF7hBMhSWPeoTQLvOd3ZCCkeaimXAAB7kDtsJ/XItBEElOd5NKoss6G/MNLZ/l0EHAvJWZ5OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=lrRMNgLu; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ufpRZ0O09Okc26dzuVpIdsUxMRmkbneXYKpFAjnsc3o=;
	t=1768384084; x=1769593684; b=lrRMNgLuM6mNk9OWCBO+tufxZNnRxfiYQTGw6MViwP6QtP+
	B3mw7VYZoatR+dBvwkCD37Ov/6G9lonrZwrLqNfv8zvKeQQ+l4QE0F4Bbn67Kjkzn21NjZT+Xz3Zq
	oI7iR/CJZeei12IS56p+8pL8ci2ka24cmvv6PmKjqqWZTUslW3jmHAHtcfbtIdpb3Tef5YoR4gDM/
	WjVR8yJSC+4416SuwShYwq0ejrsi/i2W9XZLCp4wR13dtbW7m21o9+6ccf9+tjft4cCOdx47K8zCM
	SJ5mqGTBgTBlEbs95PvW5IHqbcoZ3j7a1lrvfCSij8nEalDOJCAVhHYSk9XO+usg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vfxTr-0000000BZWw-3PcL;
	Wed, 14 Jan 2026 10:48:00 +0100
Message-ID: <33d998cc225a7aeef4731ebc53c28a32b241ca7e.camel@sipsolutions.net>
Subject: Re: pull-request: ath-current-20260113
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
	linux-wireless@vger.kernel.org
Cc: ath10k@lists.infradead.org, ath11k@lists.infradead.org, 
	ath12k@lists.infradead.org, jjohnson@kernel.org
Date: Wed, 14 Jan 2026 10:47:59 +0100
In-Reply-To: <98386125-c0bb-495e-b2ba-2765aaed19d8@oss.qualcomm.com> (sfid-20260113_183400_758847_B264F10B)
References: <98386125-c0bb-495e-b2ba-2765aaed19d8@oss.qualcomm.com>
	 (sfid-20260113_183400_758847_B264F10B)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2026-01-13 at 09:33 -0800, Jeff Johnson wrote:
>=20
> Note to maintainers:
>=20
> This tag includes:
> 31707572108d ("wifi: ath12k: Fix wrong P2P device link id issue")
>=20
> That commit contains the following:
>=20
> Note to linux-next and netdev maintainers:

I'm a bit on the fence about this, I hadn't thought about it on the
prior -next PR much, but I feel like this is a process thing that
shouldn't get recorded in the tag for posterity?

I do appreciate the inclusion of this (*especially* when I won't notice
the merge conflict myself), but I tend to think it should be in the
email rather than the tag message, since the latter is something I use
for the merge commit message and it gets recorded.

Either way I have to preserve it manually to the next level, so it
doesn't really help all that much, although I guess in the tag there's a
chance I could see it again when preparing my PR.

I'll just edit it out this time I think since it's so long, but you can
complain and convince me otherwise for the next time ;-)

johannes

