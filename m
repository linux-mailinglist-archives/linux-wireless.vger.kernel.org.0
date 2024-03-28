Return-Path: <linux-wireless+bounces-5466-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC87A89021D
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 15:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD1551C22D2A
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 14:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52936657B9;
	Thu, 28 Mar 2024 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Zmzg/mfF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77CA43ABE
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711636913; cv=none; b=juM/PURwLdefJZKp9CS9Q9fEKP+BZBSz+vDQuO6NMlJ2gZOyF55KjzjivIW2u1YFvXD+l8Q3+b1cOkL3mHhf/+UfzFuHbN+aQiqzt1OytHu4tlzFGDpl3PgNPD1vGGyxgsIqQpYpalKQkFtm2HDRfJdX9LCe9TRdzKHLtvgLwxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711636913; c=relaxed/simple;
	bh=ykG8YhLmBolM3JwuE6HwTKv8YeS5pdiVgZNJyxTLh9c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JsxUJMpI+Td39piZdnqTbxO5zKjz5EnHpBZA4x6qyDhp2YGZTYsgHzNfWKyHbSzKZL4YQ/xudw/wmQ+0ew1I1lmm/qTOTJ6IYZSAQ6c6jeO4LA+lXOgt5TdGwd20e8THIqPK3HdH/SPGURwVKAqYWMNvwSXtuFS89qfW+fqB4nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Zmzg/mfF; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=XoiwOMA8e8KHXegBzR80/tUvb/4hIiUPb1QIhySE8xE=;
	t=1711636910; x=1712846510; b=Zmzg/mfFUHNYFM4T0IgYTbIh5qTnaA/6ZcHMj+D8UzkePD2
	umv7ESm+JF77aUzrPtXvGwempQBnf2Iwt0MZQVYCK3Ki+oKCU1SfzXl8Yr7DZuaP0MzcmdRyBdsHK
	ImSEIlojBCGihJSL+neTwkIc9JhT6EO1eXBVnM9hYBNVVKAOXy1nG/rG9RN2AJgm9UWP67vpw42ms
	i9UYWQbRIgPer7lcxge/6vTTxQZqsXFvabUCn/Gom0vwiTCdC8aQOeJdlnpogPTyZC1HcWpiZYefj
	crqHnq4bnTRW0I1fYXk7y1JPeFSrlrSEWNKzY8GVDKAXl0O+Mrh8wlb7UdDgkR+g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rpqwt-000000013Nt-1qr0;
	Thu, 28 Mar 2024 15:41:47 +0100
Message-ID: <ca70eeb3cdee1e8c3caee69db595bc8160eb4115.camel@sipsolutions.net>
Subject: Re: [PATCH 11/13] wifi: mac80211: Add multi-hardware support in the
 iface comb helper
From: Johannes Berg <johannes@sipsolutions.net>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>, 
	ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Vasanthakumar Thiagarajan
	 <quic_vthiagar@quicinc.com>
Date: Thu, 28 Mar 2024 15:41:46 +0100
In-Reply-To: <20240328072916.1164195-12-quic_periyasa@quicinc.com>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
	 <20240328072916.1164195-12-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-03-28 at 12:59 +0530, Karthikeyan Periyasamy wrote:
> From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
>=20
> Currently, iface combination param supports single physical hardware.
> To support multi physical hardware, add hardware specific checks on the
> channel context creation and populate hardware specific parameters from
> the channel definition for which the interface combination need to check.

I haven't gone through this patch in detail, but again like on patch 9,
I'm not so sure about the implementation of the XOR behaviour of
checking global and per-HW limitations.

I probably wrote on the other patch that it seems it should check both,
but I realize now that doesn't make sense: After all, the top-level
combinations data must encode something that's supported _regardless_ of
channels, so likely only a subset of the combinations supported across
the different HW.

But that doesn't mean that I'm yet convinced that the design in patch 9
is actually good, with how it checks that depending on the 'chandef'
parameter. I'd like to explore other possibilities such as a different
function for that, for example. It could use the same underlying helpers
and mechanics, but it seems that might be better overall.

Or probably better yet: explore an approach where mac80211 doesn't even
have to _know_ about the cfg80211_get_hw_idx_by_chan() and all that, but
just prepares the information in a way that encodes enough data to
handle that, which really means going from

 int num_different_channels;
 int iftype_num[...];

to

 struct {
   enum nl80211_iftype iftype;
   u32 freq;
 } interfaces[];

or something like that.


I was almost going to write "links" instead of "interfaces" there, which
reminds me that none of this really even works well for MLO yet. Not
sure if that's better addressed as a separate first step?

johannes

