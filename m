Return-Path: <linux-wireless+bounces-32494-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GamH3/uqGnBywAAu9opvQ
	(envelope-from <linux-wireless+bounces-32494-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 03:46:23 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABE520A4DA
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 03:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 773483061AFD
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 02:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D786420E6E2;
	Thu,  5 Mar 2026 02:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRdobPDi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E013368B8;
	Thu,  5 Mar 2026 02:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772678780; cv=none; b=NLZ1HUPPJlNEfjuaiuFnrNAMPicCUmV10p3vXV8Mh3DrVqdoOxPyTJCd8SVuKMcCjIZHM5eoD5TajtCTJzYMHAc+MyzrvdP3qOpucAVcAOWkcOvpFTlQbeg6mQw/hI5vMK51oXF9avGo+EB9N/Dv5r0gmjpF19093qIiwXUU2Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772678780; c=relaxed/simple;
	bh=716NSjDfnBH4wvGNMkViDj4MNrtcZ/8BS2a+BVqxF78=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uOdFcFPdG2lGjEcdM7f3gMXYi5kKSPJAQ8b2n7o/IegU6l+yklIPEg8tPl1aOQkbva697PmcdJa1mxHuwuvvRAew+XGssl0kZbmgOB9uE4aclxcujaoYJMjhp8PfjLCaT06qshdrjj1avgaCyaLXcP6OCAarUpzhzJkQe/UF6Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRdobPDi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDACBC4CEF7;
	Thu,  5 Mar 2026 02:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772678780;
	bh=716NSjDfnBH4wvGNMkViDj4MNrtcZ/8BS2a+BVqxF78=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iRdobPDitjkeht2U/V2Sv8K5vkvxsEC/HJXTgutMNPxc5wq2h9+oV/vZcrum1pYCD
	 Sl2mk6P0wfI4DR+KIMGTdNF1qgvPLs9ovpbhBt/zvif9QftyEU2ZZCIhn8UO5Th3UG
	 3RJnO0tjuPcXwrq0uOVEj8KlAOtoT+4OcGd4ojgTrBnqhm+QJuqCT9gZ3YTz6nbS+i
	 x+ljeo7Bop+IBuniPJaIl0JjTQg7GmFka3iXK3q/U3nnHnEv3kWFJqpBr8tL+7FoBP
	 07CiV1SRJKgmJA1bpReHfiFo5i1vNU3fgXp7Sj6US7su6pzXapx6vOedhJbD0b0HA8
	 pyKkdJc+dFASg==
Date: Wed, 4 Mar 2026 18:46:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [GIT PULL] wireless-next-2026-03-04
Message-ID: <20260304184610.29d263b5@kicinski-fedora-PF5CM1Y0>
In-Reply-To: <20260304113707.175181-3-johannes@sipsolutions.net>
References: <20260304113707.175181-3-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0ABE520A4DA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32494-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed,  4 Mar 2026 12:34:23 +0100 Johannes Berg wrote:
> And here's the -next side, since I'll need it all merged up to
> net-next as well to get the combination together to avoid the
> conflicts I mentioned.
> 
> But this time we actually also have a real new feature, notably
> support for EPPKE, association frame encryption and  802.1X over
> auth frames, from the upcoming 802.11bi amendment. When that'll
> be supported on both sides, association request/response will be
> encrypted for better privacy and hopefully faster connections
> (no more 4-way handshake.) Driver support will need to follow
> though.

pulled (both), thanks!

