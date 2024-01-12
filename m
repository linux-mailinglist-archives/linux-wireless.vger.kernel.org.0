Return-Path: <linux-wireless+bounces-1843-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0ADE82C593
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 19:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8267EB231E9
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 18:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F53C1548E;
	Fri, 12 Jan 2024 18:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="vkzg4qjJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08BE156CD
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 18:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=pFgsS3VYj//YTTIIwXJHY+CeFpCzprMxXACWgrWpTNc=;
	t=1705084952; x=1706294552; b=vkzg4qjJrw3w7KAS/5YEC9JJXytzk3qii3Pj6XWLrLQoqGB
	uMLmZiK9ZQBP7H0YH90wuyYxRVsdniaX9Zfdin3T6ui27HUIxQd2bmeL9eawl8whV9yuVj13jNWV0
	O9CiNn/KM5erOlYU6N2AcjA/sJIRae5jsPEa87xWYDQ6KQYKQfSJj1/i8iskQrF/5KHdxxhb/TzcV
	R47WAeS4r8D4ad8zXpmGmZYS21fODDOeUevkok4f0WUVm7p/Uv5bi3FDzpbCZrzeU5jEYHj/yaZf8
	q4OpX/lZz0AISs5HRncSowV1zg9/H5ti2Ppi1vvVpR9RTbvdqe3A9U6lxJ461YeA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rOMU9-0000000GvqW-03OU;
	Fri, 12 Jan 2024 19:42:29 +0100
Message-ID: <aae05a63171cf0f3c81dedc24d3b0a558ce530f5.camel@sipsolutions.net>
Subject: Re: [PATCH 5/8] wifi: mac80211: disallow drivers with HT wider than
 HE
From: Johannes Berg <johannes@sipsolutions.net>
To: Kalle Valo <kvalo@kernel.org>, Miri Korenblit
	 <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org, Gregory Greenman
	 <gregory.greenman@intel.com>
Date: Fri, 12 Jan 2024 19:42:27 +0100
In-Reply-To: <87wmsehf3d.fsf@kernel.org>
References: <20240111161746.3978601-1-miriam.rachel.korenblit@intel.com>
	 <20240111181514.da15fe3214d2.I4df51ad2f4c844615c168bf9bdb498925b3c77d4@changeid>
	 <87wmsehf3d.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-01-12 at 15:10 +0200, Kalle Valo wrote:
> Miri Korenblit <miriam.rachel.korenblit@intel.com> writes:
>=20
> > +			/* currently no support for HE client where HT has 40 MHz but not H=
T */
> > +			if (iftd->he_cap.has_he &&
> > +			    iftd->types_mask & (BIT(NL80211_IFTYPE_STATION) |
> > +						BIT(NL80211_IFTYPE_P2P_CLIENT)) &&
> > +			    sband->ht_cap.ht_supported &&
> > +			    sband->ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 &&
> > +			    !(iftd->he_cap.he_cap_elem.phy_cap_info[0] & he_40_mhz_cap))
> > +				return -EINVAL;
>=20
> Should there be a warning message so that this is noticed if it ever
> happens? I don't know.

Yeah I don't really know either. I've done that a lot in the past, but
these days I'm kind of thinking that people who develop their drivers
should have some debug story and be able to figure it out? You know
better perhaps ...

Though it'd kind of suck to indent this further with WARN_ON ;-)

johannes

