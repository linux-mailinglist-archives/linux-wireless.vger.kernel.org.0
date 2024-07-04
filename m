Return-Path: <linux-wireless+bounces-9982-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B062F92721F
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2024 10:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E11F01C23E50
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2024 08:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE10D1A4F37;
	Thu,  4 Jul 2024 08:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="N8ewp5kH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B591370;
	Thu,  4 Jul 2024 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720083157; cv=none; b=pmyOqt1vWN4vN1B1hBExZgesoiWTnzaCFwadoEWUOQHqB7m8EYojY7um5GJJFzCp0OEZybjGSz98xwwWBMa+KYd3cfkbk8d33HK3vul6Zut9Tl2qKFEZRsMBEPIxHwRwUwD+BeZH43UYUl210hkwYXKuD5lc+FK9I9jwGeS22BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720083157; c=relaxed/simple;
	bh=EzvZSv9u4C52XIDviykSLvDAqwCZcCGzJYldUbku4w0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NdbD+zG5pwGQTlykykRRpPAbvfPvhzh0ZvJ82ynT/9I9ukhOkwjdLNfj85Gc4W0hzboi5pXliVg068QFZ+aABSjabqc6cuj8pZ2esCHuxn/77VMZ0YTNHz9wQxDYVGCa6/WK3nadxaDWjq8INZV6YmmNPKgInEbE7PYpxTQu1tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=N8ewp5kH; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Z0GrIIuPiJHUS+FoHoFca7SE4SA2paRmFGCT26MFRPU=;
	t=1720083151; x=1721292751; b=N8ewp5kHuHpFza/PYM/qogbXfjFLxiAjzhp4qqGubWfqrX/
	SAPUvKizRTk0bbyf2Esj4YL2kRXfYqFxnFRe1ug98T73Gl6ORBoRNTqjvkTShAGQLyYCpMBqDBy5K
	P0YzVTnrq5vD9XuYcKYV5R89nYLkhik1eQQkvmLIdWfb9AsIRWkbWQ83IoNpTIy2jWUQDTmb+Qko/
	oFeRYUU1B9qBhWel63vDW6w7eMmFWBp+De5Fiopmx9Y2JoAfKztcImkLxJ0Hkmaxph883VFuQQjKu
	XYJRm7kTlnitcYXPf9FNeOBDjM+2nNUr9TRBIdW0sjWevGD7RulB45QK16aGIGIA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sPICV-0000000CFEO-1uyB;
	Thu, 04 Jul 2024 10:52:23 +0200
Message-ID: <cc86acec3c7b0daab85263acba6eef42fe9cd0ec.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: virt_wifi: avoid reporting connection success
 with wrong SSID
From: Johannes Berg <johannes@sipsolutions.net>
To: En-Wei Wu <en-wei.wu@canonical.com>, kvalo@kernel.org,
 edumazet@google.com,  davem@davemloft.net, linux-wireless@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: rickywu0421@gmail.com, 
	syzbot+d6eb9cee2885ec06f5e3@syzkaller.appspotmail.com
Date: Thu, 04 Jul 2024 10:52:20 +0200
In-Reply-To: <20240704030304.16213-1-en-wei.wu@canonical.com>
References: <20240704030304.16213-1-en-wei.wu@canonical.com>
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

On Thu, 2024-07-04 at 11:03 +0800, En-Wei Wu wrote:
>=20
> +#define VIRT_WIFI_SSID_LEN 8
> +#define VIRT_WIFI_SSID "VirtWifi"

Use strlen(VIRT_WIFI_SSID) for VIRT_WIFI_SSID_LEN maybe? It should be
constant "enough" for the compiler.

> +	if (!sme->ssid) {
> +		wiphy_err(wiphy, "invalid SSID\n");
> +		return -EINVAL;

I wouldn't print an error here

> +	ssid_len =3D min_t(u32, sme->ssid_len, IEEE80211_MAX_SSID_LEN);

The min_t() is unnecessary, cfg80211 won't give you too long SSIDs.

>  	bool right_addr =3D ether_addr_equal(requested_bss, fake_router_bssid);
> +	bool right_ssid =3D (priv->connect_requested_ssid_len =3D=3D VIRT_WIFI_=
SSID_LEN ?
> +			  !memcmp(priv->connect_requested_ssid, VIRT_WIFI_SSID,
> +				  priv->connect_requested_ssid_len) : false);

the ternary seems odd, why not just

 priv->connect_requested_ssid_len =3D=3D VIRT_WIFI_SSID_LEN &&
 !memcmp(...);

?

johannes

