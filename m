Return-Path: <linux-wireless+bounces-23060-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD5BAB971F
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 10:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E38B7ADE7F
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 08:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842FB21CC4D;
	Fri, 16 May 2025 08:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="g2cpSz0Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00F91F866B;
	Fri, 16 May 2025 08:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747382740; cv=none; b=h9oRpdcKAEVt9StgKGraeaW3Y6GNoCl72DETiOxYqw6Ak9SnulbrvOadZsHavJnNiuYmzAGgzgA1jU9Sv8YI+b/8RJtzfvQXmyvKIErXIYBCgsl5/jyKezz58GAwIOKEpsbqS36rG1Xu0fTGSiryZpVR93MU39eh6UJW3/oAmJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747382740; c=relaxed/simple;
	bh=4Dur5LcJY0Rru4CF6YGZCkt+dSlj3SfRF3eQtTCBifI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tiulRXR1eLBnDsX6BXP4dzlSojcZ7g5v9vtJNh7gsHl0kkUlas5G5fDFbQiH6ookEgZQ4WulmPCLFoJFrcWVEB+FQFXdjv0UsuiQtl7Th/eUYA3e6D0OUrRlyM6NhyZPDy86Kn0odXbVEGcsSXdTsgSGRV40ivq9/lvYgZ9KmjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=g2cpSz0Z; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=e0NeXVJw3ujz9iV+I5DNa6JpkKtpG1sdmlMDy54FzXM=;
	t=1747382739; x=1748592339; b=g2cpSz0ZjlM60g+KQ3HlVOOpy5bfzGGUNh5L6ChryiN92z7
	/cwqnEW1TcOfUN2C9is8JxXPfYwcn0rgLOFHo41//C1ziM3sip3ddM/XaYj93edcMKF35EhIggXQc
	7Yb7QvjvLVCnZRHHkJ1bFMT2dblCcWpbiXAgq04a9cZ+V9PaPi0490TeEBilGdHKhKCKFZNy2NhR4
	/p7ewedond1SCiPjFf67P1s/zPW8BRWKVa2XIxmKpyetPGIwmVf1N4nPcMVZUFNz0Jn0GGwNzXLIm
	4TZh6W51rLjAYBktzVKL/yyShwdW0CO5m9SmbSGQCRIgh3BISXQ6/G94bXODn8hg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uFq4V-0000000E2Jf-0sHu;
	Fri, 16 May 2025 10:05:35 +0200
Message-ID: <fb6cb470c66e215c0fde3652c1986d604731ac94.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 3/3] wifi: mac80211: Allow DFS/CSA on a
 radio if scan is ongoing on another radio
From: Johannes Berg <johannes@sipsolutions.net>
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, Aditya
 Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Fri, 16 May 2025 10:05:34 +0200
In-Reply-To: <20250514-mlo-dfs-acs-v1-3-74e42a5583c6@quicinc.com>
References: <20250514-mlo-dfs-acs-v1-0-74e42a5583c6@quicinc.com>
	 <20250514-mlo-dfs-acs-v1-3-74e42a5583c6@quicinc.com>
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

On Wed, 2025-05-14 at 16:58 +0530, Raj Kumar Bhagat wrote:
>=20
> +static bool
> +__ieee80211_is_scan_ongoing(struct wiphy *wiphy,
> +			    struct ieee80211_local *local,
> +			    struct cfg80211_chan_def *chandef)

Any particular reason or the __ name? We usually have that for internal
locking-related things, but here doesn't matter, and there's no non-__
version either?

> +{
> +	struct cfg80211_scan_request *scan_req;
> +	int chan_radio_idx, req_radio_idx;
> +	struct ieee80211_roc_work *roc;
> +	bool ret =3D false;
> +
> +	if (!list_empty(&local->roc_list) || local->scanning)
> +		ret =3D true;
> +
> +	if (wiphy->n_radio < 2)
> +		return ret;
> +
> +	/*
> +	 * Multiple HWs are grouped under same wiphy. If not scanning then
> +	 * return now itself
> +	 */
> +	if (!ret)
> +		return ret;

I don't fully understand this logic, and certainly not the comment. You
can certainly "return false" here anyway or something. And initialize
ret =3D list_empty || scanning or something, the whole thing is hard to
follow?


> +	if (!list_empty(&local->roc_list)) {
> +		list_for_each_entry(roc, &local->roc_list, list) {

There's no point in checking first before iterating, it's perfectly fine
to iterate an empty list and do nothing while doing so ...


Also patch-order wise, it seems this one really should go before the
2nd?

johannes

