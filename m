Return-Path: <linux-wireless+bounces-21931-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D23A99490
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 18:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D623F9A5A99
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 16:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02910289346;
	Wed, 23 Apr 2025 15:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="eBPsN635"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C1228B517
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 15:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745423346; cv=none; b=aAgrR+rKhSMcg+kgoHYKR02q2gxAlcl0b51onKU/ctVs7SMi+9xYlCRt82+IOqWFufkBarSKlTXYTQ1mbNXpaOSE7+dOn6asKQOvhX2Inr98fCk4gnjGP9pocUilly/7prgCBb1CDg05BkXTmdP4vkCCHmqOdvX2a2jUOlmIHJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745423346; c=relaxed/simple;
	bh=I7GJ5ab6NizcbsXVO1QhIBWOyQEALSMe+q7WOwSHyn8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q14X7UGU+1xi1Tv3SGnK6bH7qDXmZMwi8Ib9Ya/yn4w+/sxOpFTtHGfO+JpTmeGSxZYBmUMajY8fdGfhEG+ua6cbKd0FcgjrGFx9ysSQGYCSLqPsb2ob1IXCRTfqCCQ4xwhBGTp7Ag5uhe0/5vZHitp3g8WooiFenpzqNyzszOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=eBPsN635; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=kZ1YmQem+CBn6BHfVDzS6NDx5HOQF6CUdjdpvtBYbS4=;
	t=1745423345; x=1746632945; b=eBPsN635RXsX5M3gGqXqK/RLnKkt3gE2R8j0BUG6ay5Fzu8
	rOAz4iEmkAkoQczK9Xi1bhcwt1C7M807PHnFJpCgv+156SscPM21CIt4Be8Ik+z2tMMJntLz7gO4e
	7jfEj6nw8vjY9dP9VTjgNMRMR8juK6lhEL1SYrXImSUGqd1rVrm3//Dzwp+0xnDVLmpL+tmEL/GS4
	W3lmi4E5Zy7AV+zbC60EsGTvclh8IGCPj7U6OumzVN5d/b2IE8rkfX/m+AmvQP8A9qqOe7y7chrH4
	LvIHjIrKUHP5CDN9p3jht0ZS0lklHlXNVupyNoJKmOSicZzBAc1lZrNAJ/6LwLzA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u7cLO-0000000Eo5h-1f1X;
	Wed, 23 Apr 2025 17:49:02 +0200
Message-ID: <f8e7b061a913ade9a8a1ad91f9cff09faa2c1bce.camel@sipsolutions.net>
Subject: Re: [RFC v2 wireless-next 1/2] wifi: cfg80211: allow send/recv
 tagged EAPOLs
From: Johannes Berg <johannes@sipsolutions.net>
To: Janusz Dziedzic <janusz.dziedzic@gmail.com>, 
	linux-wireless@vger.kernel.org
Cc: j@w1.fi
Date: Wed, 23 Apr 2025 17:49:01 +0200
In-Reply-To: <20250407183818.759759-1-janusz.dziedzic@gmail.com>
References: <20250407183818.759759-1-janusz.dziedzic@gmail.com>
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


>  				   const u8 *buf, size_t len,
>  				   const u8 *dest, const __be16 proto,
>  				   const bool noencrypt, int link_id,
> -				   u64 *cookie);
> +				   u64 *cookie, u16 vlan_id);

It's tempting to say we should finally put all those parameters into a
struct ...

> +++ b/net/wireless/nl80211.c
> @@ -11009,6 +11009,10 @@ static int nl80211_crypto_settings(struct cfg802=
11_registered_device *rdev,
> =20
>  		if (info->attrs[NL80211_ATTR_CONTROL_PORT_NO_PREAUTH])
>  			settings->control_port_no_preauth =3D true;
> +
> +		if (info->attrs[NL80211_ATTR_VLAN_ID])
> +			settings->control_port_vlan_id =3D
> +				nla_get_u16(info->attrs[NL80211_ATTR_VLAN_ID]);

I'm not convinced it belongs into crypto settings? At least not with the
commit message you wrote ;-)

And either way it seems you probably need a feature flag to say it's
supported for both cases?

johannes

