Return-Path: <linux-wireless+bounces-34441-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPmCAiWj1GmAwAcAu9opvQ
	(envelope-from <linux-wireless+bounces-34441-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 08:24:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D95B3AA3E0
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 08:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0ED1030074AE
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 06:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8B338553E;
	Tue,  7 Apr 2026 06:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bUYzNHPQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D29DDCD;
	Tue,  7 Apr 2026 06:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775543072; cv=none; b=BOCxp6X27/ipMXmC3+m91FqyX3P5rjnWn+Z/d60Qq1IWjkr2AQ4VRe8poT5iHOj+NZy4xjGA3jupor/djTW6w3D2F5P/PZxGq3wkWFmYoyIZ8jJEUQuYZQ9P+fqoFyoHCKH8yiyEP4Ed5y5zlJdv4uPM0VHlc9Pj4/qGvwn8tlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775543072; c=relaxed/simple;
	bh=gEmydQWU5H0gU/LawkroIsii6moWN5ZHx2VJ7BK0QnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKIR9RH5aEC47fHtES6qo6Quw/QUEw0am2dBvNxK+etLYUm7Bfjitu06RcL95zI2HuqOx8neso/J5ia3ZR0V7zAqo5DH/dfMHu1R4rcJcASPPpGa70y5tgRQRksBrTzVsTk7xGbxZRdZ9gJfbUYzJtGLOTSEmRd8Wbom5a2wraA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bUYzNHPQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lpdAosinKyrrqUh3CA7cYZ19ZJs2FIASHNDL4+fYZcs=; b=bUYzNHPQR6OUtUZTZtIoqpN1BA
	/tCjamHLI+9iPG9hZYdkKzpmxnv5iLKYcCalZIxfmdnh82T+w6yWsXjp9WeDvKMabUHKqhh+kXs7R
	Qpc09HwaCWCgfY5hklKxXNqzHtaNV5cI6lNjWb+0tOmiqhyCrOYP+o4+gZLel7E2BzWD+kB/VFVM+
	70gHMYtS5/zYzSaD4qHkPlwBXKMbpR+TmV1BEW5vvRz9uxXlza+dMnUBnyS6RHV2ZPQeg1gDrCDGM
	CNIo7I+9l8POlVsNSJSGEm9Ob6FJ8jO4V8smfaRPxI/LQL2DDHFC6q0UPw3EzA5hVDRewhLWsCGlw
	zaRBcnJA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9zrS-00000005z4m-2Vc0;
	Tue, 07 Apr 2026 06:24:30 +0000
Date: Mon, 6 Apr 2026 23:24:30 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH wireless-next 0/6] Consolidate Michael MIC code into
 mac80211
Message-ID: <adSjHlfi15v_U62B@infradead.org>
References: <20260405052734.130368-1-ebiggers@kernel.org>
 <7f69d6e6c2057858eda5c65ec77be44d72c6ac78.camel@sipsolutions.net>
 <20260407061508.GA7934@sol>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407061508.GA7934@sol>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34441-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,infradead.org:dkim,infradead.org:mid]
X-Rspamd-Queue-Id: 9D95B3AA3E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 06, 2026 at 11:15:08PM -0700, Eric Biggers wrote:
> Just to clarify, mac80211 already contains the michael_mic() function.
> And every driver that needs Michael MIC already depends on mac80211
> except for ipw2x00.  So bloat-wise I assumed it's probably better to
> make that one driver depend on mac80211, rather than make every driver
> pull in the Michael MIC code (by moving it from mac80211 to cfg80211).
> But if you prefer that the code be in cfg80211 we can do it that way.

To me the most sensible thing would be to have a separate module for
the code.  If you don't want to expose it too widely for understandable
reasons, keep the module in net/wireless/.


