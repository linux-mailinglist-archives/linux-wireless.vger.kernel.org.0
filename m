Return-Path: <linux-wireless+bounces-11841-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E366F95CAA6
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 12:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0129284992
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 10:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8E8149C40;
	Fri, 23 Aug 2024 10:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="lNyoYqLj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C035028EA;
	Fri, 23 Aug 2024 10:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724409729; cv=none; b=VIylkKzDeijdQH4tHHYLWL7ARsJC1pgNofgbhryHbmcSeV3sJe50OsrkpjcxIBMrIrT+vlXponLQRUsJYMLpY5dyCkeu43raTMn2LZ6icR0GQVYd819ATlYQi+RTLPScd0Yb3CZgf1U3KUvgOLl1a6wwzjekv0Q1K1GA9scrgnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724409729; c=relaxed/simple;
	bh=5KK2RJQAtkePrpJ0BcZucFZ37M/1X8amjjqPRfU7Umw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fy/TCbbiYVyORt+csGDbS340gKAV8f9s8+4jI8hFwITYwyKnhNRrfcOOLt8jAEsMy51RT0mqOjOpRUrHy5c1jXamorRwTu8zpeXOxq+5vnTFF5TLvQEkOLXZR0FxAPLtmZ1NsP85Q4/E2RBwquRQY/oysLiPSGURLu/b/gCX5hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=lNyoYqLj; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ySAq5GhCFf2JrQxerjYMWjlswlOjNEg+iTM1YZdGN5M=;
	t=1724409727; x=1725619327; b=lNyoYqLjQeDAHQk+UswukTWKJB/UbQhwKUR2oCULwDRg3iy
	Q3/opl9NoV0k+yHrOa0IYC9GAIr/sAECL5kitBnDwlJFdP++fj9mzrYRhQrMM6FSVJRFPQjrY63Hh
	UkrObAOLXeevlzmgdVQlKbDjGtl3PzcsJspgd4773+w8jzYE8y/LFt7Dh/vO7KiR7tQ4fHhgfcsjL
	+q00hpU+KZZ/VcKuZbUURQHrTrHmCDac9YJxOOJcqV0e60uTRRXdATulJt2I/DyHLRtQfvabZEiXU
	r/qHZK6ae2Jxpu0uvrnkCZBqcOyVVR9pKNI4lnun+2HKv7dzmpKiAoe6i08JBdLg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1shRk3-0000000FS9z-2l39;
	Fri, 23 Aug 2024 12:42:03 +0200
Message-ID: <6a9916848826a07ca41f1170e1d20cda9e798872.camel@sipsolutions.net>
Subject: Re: [PATCH v3] wifi: cfg80211: Set the channel definition for the
 different Wi-Fi modes when starting CAC
From: Johannes Berg <johannes@sipsolutions.net>
To: Issam Hamdi <ih@simonwunderlich.de>, quic_jjohnson@quicinc.com
Cc: kvalo@kernel.org, linux-wireless@vger.kernel.org, lkp@intel.com, 
	llvm@lists.linux.dev, mathias.kretschmer@fit.fraunhofer.de, 
	oe-kbuild-all@lists.linux.dev
Date: Fri, 23 Aug 2024 12:42:02 +0200
In-Reply-To: <20240816142418.3381951-1-ih@simonwunderlich.de>
References: <9809b165-8d25-4984-a1dd-6fca28f1dda9@quicinc.com>
	 <20240816142418.3381951-1-ih@simonwunderlich.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-08-16 at 16:24 +0200, Issam Hamdi wrote:
>=20
> @@ -10143,7 +10143,23 @@ static int nl80211_start_radar_detection(struct =
sk_buff *skb,
> =20
>  	err =3D rdev_start_radar_detection(rdev, dev, &chandef, cac_time_ms);
>  	if (!err) {
> -		wdev->links[0].ap.chandef =3D chandef;
> +		switch (wdev->iftype) {
> +		case NL80211_IFTYPE_MESH_POINT:
> +			wdev->u.mesh.chandef =3D chandef;
> +			break;
> +		case NL80211_IFTYPE_ADHOC:
> +			wdev->u.ibss.chandef =3D chandef;
> +			break;
> +		case NL80211_IFTYPE_OCB:
> +			wdev->u.ocb.chandef =3D chandef;
> +			break;
>=20

OCB cannot even get to this code given earlier conditions, why are you
adding it here?


I guess this should conflict:

https://lore.kernel.org/linux-wireless/20240711035147.1896538-1-quic_adisi@=
quicinc.com/

but it's probably not too hard to resolve that.

johannes

