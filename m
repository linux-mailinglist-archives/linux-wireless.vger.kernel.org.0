Return-Path: <linux-wireless+bounces-9682-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E33E891B994
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2024 10:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B78FB21E86
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2024 08:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28CF13C674;
	Fri, 28 Jun 2024 08:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="RhwJ3p0w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA6E79F2
	for <linux-wireless@vger.kernel.org>; Fri, 28 Jun 2024 08:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719562383; cv=none; b=q8WbXO3wpvEf9UCtIRhDEaP6ugojyzrSXQr4u7D9no/G1fy9JOjwHnuJ3iPi+ffKkTHptjIKYLJ01jQI6oHNvFz/BkjGVwGZtkTQH58ec/zth9bwP1g+NjytADGApM4rPmI8SMHUMDB1cyfPGLbqN0EWz+XUB/10BdXP6ye8nHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719562383; c=relaxed/simple;
	bh=u9ILEQvGzcYrYK5a5D0UKiXE0pkK+L734W1/XNQoC8k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QYrkZXNxQzLji/FtD/dcRIAkfZ18bgFM5s1v1G0/Xsi5nOG6ibjEqcVnt17ZQSLHF/x1keDmynvp36HwN/igfW9vjjufP1jycY35oKaty7oMdDhlSRXO1io2yCYiNu49EhD5/AR6qQRPOigMe6sjxW3zIc1QlNPXp2wjgnv5FbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=RhwJ3p0w; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=jgWzeyjxNHl6j7Gu/TQNjYhErpXP70xJ3qoulgp/PHs=;
	t=1719562380; x=1720771980; b=RhwJ3p0wV3dADw/y+0qnsN8P10mVaaHWCsejsQBVDRDvC1R
	zb5smCffUjXdUuQYjQcFXvzecDvHv7HpQC7IYKw2hRAS+bjzELDvLFpiPc74yrwO8IbiCl5KJ/HQ7
	oCKb6IymuKQSV/ZuG1yGZGBYxc3+9x8D5Ptk52EZnzfxso8H8SIkE0o2nvJoS+rvLbf7sKiWcfO+D
	zZ1xm41ZSSqZHrI7y5hsJopounmC2cQdcbmiK+5OwMMsUe1As8YDwrJaSej4tQVF1rxh7TyouZ6Kv
	09si1oBQzjfLBhTSeVHXMpWcUG5yex17y7gy9Fqd+WPbrG/QBAFZUmcnPcE0tm2A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sN6j2-00000009Uhu-38Ka;
	Fri, 28 Jun 2024 10:12:56 +0200
Message-ID: <757b46fb3a4f107e03ded0bd9c97578bc2234a02.camel@sipsolutions.net>
Subject: Re: [PATCH 02/10] wifi: cfg80211: add support for advertising
 multiple radios belonging to a wiphy
From: Johannes Berg <johannes@sipsolutions.net>
To: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc: quic_adisi@quicinc.com, quic_periyasa@quicinc.com, 
	ath12k@lists.infradead.org
Date: Fri, 28 Jun 2024 10:12:55 +0200
In-Reply-To: <defa3f593a3b9bd42099cb945d3fede22f22f072.1718881762.git-series.nbd@nbd.name>
References: 
	<cover.a7730420cfba0f204a60e4c30e6b0e07b441ff6b.1718881762.git-series.nbd@nbd.name>
	 <defa3f593a3b9bd42099cb945d3fede22f22f072.1718881762.git-series.nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-06-20 at 13:11 +0200, Felix Fietkau wrote:
>=20
> + * @NL80211_WIPHY_RADIO_ATTR_FREQ_RANGES: Nested array of frequency rang=
es
> + *	supported by this radio.

That could point to &enum nl80211_wiphy_radio_freq_range (if it stays
this way)

However, also for new arrays defined in this patchset, which if I'm not
mistaken are

 - NL80211_ATTR_WIPHY_RADIOS
 - NL80211_ATTR_WIPHY_INTERFACE_COMBINATIONS
 - NL80211_WIPHY_RADIO_ATTR_FREQ_RANGES
 - NL80211_WIPHY_RADIO_ATTR_INTERFACE_COMBINATIONS

we should probably go with the times and use the multi-attr array
concept:
https://www.kernel.org/doc/html/latest/userspace-api/netlink/specs.html#mul=
ti-attr-arrays


That would change the structure so that each of the attributes listed
above can simply appear multiple times. I would consider at that point
renaming them all to singular (since each individually represents a
single entry), and perhaps at that point using a simple structure for
NL80211_WIPHY_RADIO_ATTR_FREQ_RANGE instead of the nesting. You could
even just move struct wiphy_radio_freq_range to nl80211.h

> +static int nl80211_put_radio(struct wiphy *wiphy, struct sk_buff *msg, i=
nt idx)
> +{
> +	const struct wiphy_radio *r =3D &wiphy->radio[idx];
> +	struct nlattr *radio, *freqs, *freq;
> +	int i;
> +
> +	radio =3D nla_nest_start(msg, idx);
> +	if (!radio)
> +		return -ENOBUFS;
> +
> +	freqs =3D nla_nest_start_noflag(msg, NL80211_WIPHY_RADIO_ATTR_FREQ_RANG=
ES);

Either way, however, new code should not use _noflag()

johannes


