Return-Path: <linux-wireless+bounces-34445-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AP3jIw2m1GmkwAcAu9opvQ
	(envelope-from <linux-wireless+bounces-34445-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 08:37:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA69C3AA57D
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 08:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BD1B309FC56
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 06:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205963890FF;
	Tue,  7 Apr 2026 06:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lV+XETSA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6282B36C5AA;
	Tue,  7 Apr 2026 06:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775543623; cv=none; b=NIou7X9QecMJlGFT2vQ0D+2R9Yyh8MjRwTsOyCyhdNvzBxEqjGlKr2V7QtBkmFsQqKFxjuwGyQ5lnLbYlyoxZwndgyCrFD/Hdq1fIn8+kDpZbkvdjnbR+nictc6MhGOGjtCEOBFBLtUNZXRo3rZAJWmfnWeiXOKDtEjWHJiacI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775543623; c=relaxed/simple;
	bh=q4ksZXFenGLkecr4cxoxIHq690iPPqgs2Il8OvFD+x0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBxSeUGcI5Oaykz/LoMdYvqi6sMwBA5FgcVf2GRTDHESoCqMXt1R3UJTOMFM2K+6IveF6oN3zKcII87kPbxy0qj6BEMe2R3EEe4usn4BmGdKMUcGFPk2V2e2i1TRcBjoOLR9PxMepzMbT6bYgeKL3pbptlMBNjjWAMQQBsY/r5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lV+XETSA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=O0+oU+8dOi7vjEWpWkPEezjlqyMMmgpe5+Z4WzfNH30=; b=lV+XETSAv4nxW7/WW3cakEnSN5
	2i0Nk/g5TflL/0q3tJuMFdUL68MDP3J4LSuwXYs4ENUtBivEFPQXqnYbNYS7I2ijA/Zd4HSg0wqb2
	pv6npcv8w/MhJvOjo56ProWg0TQ42px7BeS/SBZECrLj1hpBVzVtc2OpXBb7TFrUIkSXXfJzx1dM+
	VW3pwkgPMc0JNGsEf5RV2bo5g0z+lVn/BKOO8G7ZWl5ZlCfnDV2rp1dZ3AP0KetOIG/MSgDpvEQn9
	Ezhg3uWo12YByIUIwUCCLioc+obfPiyA2x5QJjEyiXNj1rbA7DldJkdyj7LRXbp5msknjMDUU3rSn
	X8KWMZ6w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wA00K-00000005zud-3NOL;
	Tue, 07 Apr 2026 06:33:40 +0000
Date: Mon, 6 Apr 2026 23:33:40 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Christoph Hellwig <hch@infradead.org>,
	Eric Biggers <ebiggers@kernel.org>, linux-wireless@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH wireless-next 0/6] Consolidate Michael MIC code into
 mac80211
Message-ID: <adSlROOcBbM83DrU@infradead.org>
References: <20260405052734.130368-1-ebiggers@kernel.org>
 <7f69d6e6c2057858eda5c65ec77be44d72c6ac78.camel@sipsolutions.net>
 <20260407061508.GA7934@sol>
 <adSjHlfi15v_U62B@infradead.org>
 <b4a8265d1814eb63be9a64ab4581439829f22fb0.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4a8265d1814eb63be9a64ab4581439829f22fb0.camel@sipsolutions.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34445-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[infradead.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:dkim,infradead.org:mid]
X-Rspamd-Queue-Id: DA69C3AA57D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 08:28:20AM +0200, Johannes Berg wrote:
> On Mon, 2026-04-06 at 23:24 -0700, Christoph Hellwig wrote:
> > On Mon, Apr 06, 2026 at 11:15:08PM -0700, Eric Biggers wrote:
> > > Just to clarify, mac80211 already contains the michael_mic() function.
> > > And every driver that needs Michael MIC already depends on mac80211
> > > except for ipw2x00.  So bloat-wise I assumed it's probably better to
> > > make that one driver depend on mac80211, rather than make every driver
> > > pull in the Michael MIC code (by moving it from mac80211 to cfg80211).
> > > But if you prefer that the code be in cfg80211 we can do it that way.
> > 
> > To me the most sensible thing would be to have a separate module for
> > the code.  If you don't want to expose it too widely for understandable
> > reasons, keep the module in net/wireless/.
> > 
> Maybe, but that'd probably be more overhead than anything else? The
> text+data is 725 bytes (on x86-64).

Yeah.  Just thinking out loud, if the wireless maintainers are fine with
the cگg80211 version that's probably fine.


