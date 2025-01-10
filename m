Return-Path: <linux-wireless+bounces-17308-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CB8A08CBD
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 10:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF6C0168C2C
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 09:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFC320B1EB;
	Fri, 10 Jan 2025 09:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="hY95XkWd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CABC20A5E8
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 09:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736502354; cv=none; b=kuzi2KQvBtmx4J97a0LyOVDZA0KAe2j4Jt9LsaT9Hl5zON7oQYycAz4Ayzea//KsfmpyLdsoOwCMFvX1wf1q6Pms5tHs77Ptf+ctw2BC4EsjWzm+wmb2ozrXLsTbsTXlWGQj3qzAxfIfN2MiKY9yk70KVo8QER+ln5UvzwWvARY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736502354; c=relaxed/simple;
	bh=okHpzHEDtnBQgHrRxOTvwFSFG6nKfthXaDSrjU6XyTA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ubC2Yt01HiwVo4XxQDgkxaTxiAZxKlHtULjZcfuMfOkGsUSNLflKnerQ8UPyqaEWvIPIujQKxOvcj7cA1xyix+m+SwG10uyljBoFDgkhnHO9+me/r80SFc9EOxt9Cn1JPv0n4lMNNV9jsRSP5RBOK+izPBSO5x7xU74Nt1ierFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=hY95XkWd; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=2Hz7OrT8BbY2Sh+x3zPuGZpJnsKPpt9MzFOgKBshVX0=;
	t=1736502352; x=1737711952; b=hY95XkWdzvnspu2k/AfQ05wQoP642Il1Acp74NLTmGie9UO
	EfnkoKWIZ/9KAaQxQ8lNzqqwvnexupL7/MOakDg2TzBbdAlndPkhApt6aPeoBzlLQYQY8sYtI6zM8
	FU3g/G5C6cG46nXtRjL1dy8/FCyqZV1XYL5ZdGfto8nPQSxii4qFvzHWANXrGKjSyWqNhlrSaPa/w
	OeqZnVbf6eJvgCrIZWMW9wjf06gZ46P10fTeuElhX8/eyeCd7WU/dBbMDfxYSnlxJ2mD/lRPv5ra+
	EiM24gUAQChP3gVXZTloB4G6XnguhztXPpxXsqYU6YldOFUVAWi9S51X/W7SgQWA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tWBaP-0000000ATvP-17Ps;
	Fri, 10 Jan 2025 10:45:49 +0100
Message-ID: <8eae424c1dbb45921dcfa6cc8bd07440d3e77632.camel@sipsolutions.net>
Subject: Re: [PATCH RFC 0/7] wifi: cfg80211/mac80211: add support to handle
 per link statistics of multi-link station
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Fri, 10 Jan 2025 10:45:48 +0100
In-Reply-To: <20250110042449.1158789-1-quic_sarishar@quicinc.com>
References: <20250110042449.1158789-1-quic_sarishar@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2025-01-10 at 09:54 +0530, Sarika Sharma wrote:
>=20
> Current flow:

FWIW, I really would have preferred to see this discussion separately in
terms of cfg80211 and mac80211. Yes, the design phase obviously requires
both to be addressed, but once you have that I tend to think it's easier
to reason about them individually.

> Proposed flow: (Changes in last block)

Which kind of implies that cfg80211 didn't really change in terms of the
high-level overview, but I'm not sure that's really true?

>  +----------------------------------------------------------+
>  |                 sta_set_sinfo()                          |
>  |   1. fill sinfo structure- info related to station       |
>  |   2. if MLO                                              |
>  |      a. call sta_set_link_sinfo() for each valid link    |
>  |         i. Call mac80211 ops- .link_sta_statistics()     |
>  |            to fill link_sinfo structure                  |
>  |         ii. fill remaining link_sinfo structure          |
>  |      b. call sta_set_mld_info()- to fill accumulated     |
>  |         stats at MLO level                               |
>  |   3. if non-ML                                           |
>  |      a. call sta_set_link_sinfo() for deflink            |
>  |         i. Call mac80211 ops - .link_sta_statistics()    |
>  |            to fill deflink link_sinfo structure          |
>  |         ii. fill remaining link_sinfo structure          |

And that's simply too much detail. The ASCII art is also a distraction
rather than an aid if you ask me ;-)
>=20
> Alternate approach:
>    - Keep sinfo structure as it is and use this for non-ML or
>      accumulated statistics for ML station.
>    - Add link sinfo for links with only certain link specific statistics.
>    - Keep mac_op_sta_statistics at MLD level and let driver fill the
>      MLO and link level data, if driver not filling let mac80211 fill
>      the data.
>    - Corresponding changes done to embed statistics into the NL message
>      based on the sinfo/link_sinfo.

And this kind of data-structure based discussion is actually completely
missing for the proposed solution?

What about drivers that might offload link decisions and not really tell
you per-link statistics? I mean, I don't even know if such a thing
exists, but with a data structure like that you could still have it?

Should mac80211 even accumulate? Why not cfg80211 accumulate over the
links? And if mac80211 keeps the removed links per link then nothing
else is even needed? Or it could pre-fill the MLD level info?

johannes

