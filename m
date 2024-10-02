Return-Path: <linux-wireless+bounces-13422-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6484B98D3C2
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2024 14:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0811BB20A50
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2024 12:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CF21D016E;
	Wed,  2 Oct 2024 12:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="mqkKZLtC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B731CFEDA
	for <linux-wireless@vger.kernel.org>; Wed,  2 Oct 2024 12:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727873714; cv=none; b=tkh4otJtT4GsleGW80Y6KohtOm9A4M6X1v79w72HMUeMc7KgAxIOHISd+RDlJZb7TZ0OEyCD+LHMfI0wxVoHVJWpqQbMbvcxwbQIWh8haAOpRjvl+oRf66tSzk8+lu3OZHCXw0W/89crl5aYtvULDF931EAu9BU2vcUKNLPzb58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727873714; c=relaxed/simple;
	bh=HrOlmf6/0IbqsX5wy95/YCXuFDnU+BI+gJFUrr3DukA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uMtERohs4IQnFGTLzYs2s5QDXxdYJYs7byV46kd8Cc/sQJDyeJDCcJ6laD1tmYTJkZBqgQr8k86QYPt04ciADj05zBYvx/xhemPmIPQez41+HHOsUHvO5PCh5vJe64w6KvCF/2I/xTvciX2J+Sr9v2ROy6l6wuoaQ1YzrlpmDwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=mqkKZLtC; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=XnIqgYH6sc9oBvfacWxc0I8pfusocTBqDxwDR+PJmzw=;
	t=1727873712; x=1729083312; b=mqkKZLtCZHFjPlv5gQZn2SjLiblFIMjgRelrj7RKDGjRraf
	XIpdNySE5lR9O1VfOkjtMxJ8EACMBaRCUotqO5e8R3PsYryddltpE23kWJRuMWvbeIMsUOF+WxOiy
	h4Hu0Ogvo+v5duudMaP5tsc8o+NgYl/+I3lTLKeqtzIxPLiMWF4JCqIlo6dlQWgW+tyFh7NOMSr7y
	CkaKuhRxQ7FcntYlUAN0ON1PnRScxtXgEpJB1hTd6rL0D+Uye+mA0K7/fjBFO4Dvpd/Dz0aaF445A
	GdpJiHMqr6UVP7bbHwiyEjdcdfzeunsh3ItCBokBIkxCbqZ7LPQ+x2JqqZbCUdRw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1svysh-0000000FdaU-38t1;
	Wed, 02 Oct 2024 14:55:03 +0200
Message-ID: <c049e6f7de9c840affa3970cb774c7bd4aa21629.camel@sipsolutions.net>
Subject: Re: [PATCH 01/11] wifi: cfg80211: add option for vif allowed radios
From: Johannes Berg <johannes@sipsolutions.net>
To: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Date: Wed, 02 Oct 2024 14:55:03 +0200
In-Reply-To: <0ab36f572fd2a2fd8d1d1d6e6c348cf20ca9826f.1727869380.git-series.nbd@nbd.name>
References: 
	<cover.cb088351ab8df44310eee259bf2dbec858702463.1727869380.git-series.nbd@nbd.name>
	 <0ab36f572fd2a2fd8d1d1d6e6c348cf20ca9826f.1727869380.git-series.nbd@nbd.name>
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


> + * @NL80211_ATTR_VIF_RADIO_MASK: Bitmask of allowed radios (u32).
> + *	A value of 0 means all radios.

The handling of 0 seems inconsistent, you don't always initialize it, so
0 could be reported to userspace (for interfaces created other than
through nl80211), but setting it to 0 results in non-zero "full" bitmap.

Probably just need to always initialize it in cfg80211_init_wdev()?

Though not quite sure how that meshes with the nl80211 creation.

> +static int nl80211_parse_vif_radio_mask(struct genl_info *info,
> +					u32 *radio_mask)
> +{
> +	struct cfg80211_registered_device *rdev =3D info->user_ptr[0];
> +	struct nlattr *attr =3D info->attrs[NL80211_ATTR_VIF_RADIO_MASK];
> +	u32 mask, allowed;
> +
> +	if (!attr)
> +		return 0;

Might be nicer to also initialize *radio_mask here

> +	err =3D nl80211_parse_vif_radio_mask(info, &radio_mask);
> +	if (err < 0)
> +		return err;
> +	if (radio_mask && netif_running(dev))
> +		return -EBUSY;

and use the return value (=3D=3D1) to distinguish this, rather than the
value you initialized radio_mask to (which is then not needed)?

Not sure, I can see benefits of this approach too I guess, just got
confused about it - and especially due to the zero issue pointed out
above.

johannes

