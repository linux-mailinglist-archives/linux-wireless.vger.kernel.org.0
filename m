Return-Path: <linux-wireless+bounces-2549-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 188DB83D816
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 11:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AF2C1C2A89E
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 10:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BB014286;
	Fri, 26 Jan 2024 10:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="tHHyMiiU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1311B7EB
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jan 2024 10:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706263616; cv=none; b=RM/KCDU0dMqIcb5RKRXilmhyLbPDX1z7oE8hC3e4uW6gfLIKvdywWQPZx7tqdahRpn4yMynfGpRFtRZgPbxjqKp/fyoHuIKPOKFozBuUNRoxJe/1MvgazbVslQBQi88N/UljkuQOnzuySTd6Pv3El8LaismFMCq71Qev7GGESZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706263616; c=relaxed/simple;
	bh=LEY2HBcgg/1ykhkXT8aO1AL2IeryMzBVVoxqjjHq9NI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HwXP2CGYLnxrl8/4fZPhB2S7CSWm4CS9ojyblUw97xIQPf105h5TlZi8RAbhkZf+gxBKoxijc4mNTQ/y3MMgm0Q/IZUWjfVRW4FF2AGnOgOSYKl73w2cb5UJ+8MNgL/RZoXdXoQqOxDishydgDfcJKCkBhR63T/KV9nih+JqfPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=tHHyMiiU; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=3kCfvh7+/XsnIFMFABpIRUj5uwT6wyn8Ex382/T768M=;
	t=1706263614; x=1707473214; b=tHHyMiiUXMdmWsLIRbCQD73FaVDMtQJ0zbhFoieENzI7cC4
	0OKPfR+DGzIPZ9WvYyYpfXqPYi5aMoQkhl+upNqGdO69ZtzuKJwn+aBGY1K2yPIyOUOlx386DhtUp
	xbb8U0gzcLuIJZ6/YRerahfV5vqBd8r7CCBfNkQi2vmamDIhI81nQu5wKIkY0NulvgUVwbuYVoJgt
	SGySQYPlt0igqBq1wmwGopuBJUSR4u2NhoDT+05gy75ZlWCeoPu/44Z/gBj8GVG6UDHN9VXO9D6mj
	i2IOWKaRTjk0REcXsoUUHQF2uuGsMmP+U9oi4JWiF4bXwN9ddq8o6kHZNjO+nh4A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rTJ6p-000000016Nd-0jkK;
	Fri, 26 Jan 2024 11:06:51 +0100
Message-ID: <818ba565b910f87d6863576044a32459cbb84839.camel@sipsolutions.net>
Subject: Re: [PATCH 1/1] wifi: mac80211: ignore the bitrate mask when
 scanning
From: Johannes Berg <johannes@sipsolutions.net>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org, 
	lvc-project@linuxtesting.org, 
	syzbot+fdc5123366fb9c3fdc6d@syzkaller.appspotmail.com
Date: Fri, 26 Jan 2024 11:06:50 +0100
In-Reply-To: <20240125090737.49673-2-dmantipov@yandex.ru>
References: 
	<58970b94a314414402a932576ec54188c0675016.camel@sipsolutions.net>
	 <20240125090737.49673-1-dmantipov@yandex.ru>
	 <20240125090737.49673-2-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-01-25 at 12:07 +0300, Dmitry Antipov wrote:
>=20
> +++ b/net/mac80211/rate.c
> @@ -351,6 +351,7 @@ static void __rate_control_send_low(struct ieee80211_=
hw *hw,
>  	int i;
>  	u32 rate_flags =3D
>  		ieee80211_chandef_rate_flags(&hw->conf.chandef);
> +	bool scanning =3D !!(info->control.flags & IEEE80211_TX_CTRL_SCAN_TX);
> =20
>  	if (sband->band =3D=3D NL80211_BAND_S1GHZ) {
>  		info->control.rates[0].flags |=3D IEEE80211_TX_RC_S1G_MCS;
> @@ -364,7 +365,8 @@ static void __rate_control_send_low(struct ieee80211_=
hw *hw,
> =20
>  	info->control.rates[0].idx =3D 0;
>  	for (i =3D 0; i < sband->n_bitrates; i++) {
> -		if (!(rate_mask & BIT(i)))
> +		/* Do not use the bitrate mask when scanning. */
> +		if (!scanning && !(rate_mask & BIT(i)))
>  			continue;
>=20

I know my patch didn't work, but I think I'd still prefer if we didn't
pass a 0 rate mask around to ignore it - maybe we can just make it ~0 in
the outer place that looks at the sdata mask(s)?

I'm not sure why we fill "BIT(sband->n_bitrates) - 1" rather than ~0 in
the first place, we always (have to) check anyway, so wouldn't really
care about having more bits set than rates exist ...

johannes

