Return-Path: <linux-wireless+bounces-10430-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69375938DC2
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2024 12:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A5241C212CD
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2024 10:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057A814F70;
	Mon, 22 Jul 2024 10:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="JG178J68"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B10B16A94F
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jul 2024 10:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721645894; cv=none; b=e5dVHzKgkQRGJFA7uoFAxfX8i7uKKCVjRw0pi+Iba3pNzQSIT3wPoEiwz3v+9Vw8Z4/ZFaUSfjjfpBVXNXqnUK/xgPwUt9A89KNIOQwxwQYm93THbmDsGMlR4NS1M1IdMNNTi+5fB+5gmp8f4PP8toJgjDFGduA8mZMX5C/zw0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721645894; c=relaxed/simple;
	bh=ARiMbNQicyesiBTuxf6uqNL0Bqi/Q55SDNf9Oj9bboo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=opgJV/cdbdiZQwZmBTpvUah+4ukMZnUbui/PFLa2VOhI+MFbgFrqEDT3197SLwXk7nk8BvSnOPWKu58E9F+FQ9EjfQyOlkYGBBvSIibVfl3L49CEopgDtKes0c4ZJrLg1+uF/2Z9zlKTLoMOwlspYT5ywn8M78fZsXYzzy/G4bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=JG178J68; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=JDArOkGJxIIXvs/Ept1x2IXujIMBymTLZqcyICiH62U=;
	t=1721645891; x=1722855491; b=JG178J68NyU9rnceDU0EusRJAH+3LoHVvrHMpsdWSpjaPqP
	qOJwtJxi9gqGv6R+XyOLKa4z4QdYigEQYHZEyEXDcBbW8/mw3eBZrm+pV4EbFRWhxF6jQk3BjkUjv
	v9cS0Y8nPgq3tIYyV4wIozVnm+i2DmKswMto8HT8SsKFENcjBWf4lndFj1CqtwdfnhyVlp8GBprLA
	ZoSACYEZaNhUw1v8oNuYR/RFRXPlJ+mL9EA8YrRUh4HyPgch0M7XZjFZMB9E8CAKAJaFwemSMvq0L
	AYg2OK89ZGFgVd9aQXfXkcWlBcJp4ztH3L/vMV03QhmSzjpmtwlqtGRwpDT4KLKA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sVqjx-00000009mTi-2e0e;
	Mon, 22 Jul 2024 12:58:01 +0200
Message-ID: <e4ff967f72cc2138b9171e81ccadc35488c45559.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/2] wifi: rtw88: 8822c: Fix reported RX band width
From: Johannes Berg <johannes@sipsolutions.net>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>, 
 "linux-wireless@vger.kernel.org"
	 <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
Date: Mon, 22 Jul 2024 12:58:00 +0200
In-Reply-To: <d3267712-e458-4a02-9408-f3d443185207@gmail.com>
References: <d3267712-e458-4a02-9408-f3d443185207@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2024-07-22 at 13:50 +0300, Bitterblue Smith wrote:
> "iw dev wlp2s0 station dump" shows incorrect rx bitrate:
>=20
> tx bitrate:     866.7 MBit/s VHT-MCS 9 80MHz short GI VHT-NSS 2
> rx bitrate:     86.7 MBit/s VHT-MCS 9 VHT-NSS 1
>=20
> This is because the RX band width is calculated incorrectly. Fix the
> calculation according to the phydm_rxsc_2_bw() function from the
> official drivers.
>=20
> After:
>=20
> tx bitrate:     866.7 MBit/s VHT-MCS 9 80MHz short GI VHT-NSS 2
> rx bitrate:     390.0 MBit/s VHT-MCS 9 80MHz VHT-NSS 1
>=20
> It also works correctly with the AP configured for 20 MHz and 40 MHz.
>=20
> Tested with RTL8822CE.
>=20
> Fixes: e3037485c68e ("rtw88: new Realtek 802.11ac driver")
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> ---
> v2:
>  - Use Fixes instead of Cc: stable.
>=20

For the record, if you want it backported, you really should have
_both_. Having the Fixes: is good, but will not necessarily lead to it
being backported when/where you want it.

johannes

