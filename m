Return-Path: <linux-wireless+bounces-34516-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ErHCpUA1mk7AAgAu9opvQ
	(envelope-from <linux-wireless+bounces-34516-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 09:15:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBA73B7FDC
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 09:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F2973040965
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Apr 2026 07:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8553783AD;
	Wed,  8 Apr 2026 07:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HwdsTKgB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A0D35B65D;
	Wed,  8 Apr 2026 07:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775632480; cv=none; b=f/x3OMMoN2ukFuJfLApZlwjc4JvVzFyjE27dNnGNhJfpjhEFd+GBCR1qi2GTetUMfI+tUVBe48XEiCxIQVt5WJ1xkoRZ/9OI8N/+5HqhmcF8VaI+7a9UG+PtI8E3CiRjnjvkjcOi+mRnLTL7Ucd86pS98SQbUwS16g1FxeJWOzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775632480; c=relaxed/simple;
	bh=m7Yz2p3aVCXKQqlcwtRMbVyXwo44caQVriFS2/9CDvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/qrJseu5Oeu4pQPLtUosLu3UgeQc3ReJoe/iTBMiJYRNpqgehJWyC3tQUrh78pZxbsjelcdOjj07bWULD8Lm3JNVULmpjzvVrZCklakDoPoi3RzPHPqApqk8Npj2sS/ud7uhJhXcQ0Klgha7fjkZVcHcSyALE3Btn4eKIyjozE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HwdsTKgB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEBCDC19424;
	Wed,  8 Apr 2026 07:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775632480;
	bh=m7Yz2p3aVCXKQqlcwtRMbVyXwo44caQVriFS2/9CDvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HwdsTKgBZRw9wturcZ5tigyzMZnVfdYzixNLS8z9wjJowxPVQH8g71fkeUpbDsXRn
	 edlb9X+k7H41+wmuGzOij6bqB7+o9LehDWrkGeG7oKMjKXWyaddXUt84kz0TsBRIlc
	 ZvRAJSGMl4xD2DyDjFv1WOqAamb46Bdqt3H1ZDC7k4goFJ2xLFjRgCBPJHTmb07AaX
	 nL/6edwa6T7TttfmQx4IauQqPAp7pCE1Uzr4L9MnoSNEbifvRgznFYNQgRO5TwzCBo
	 e6mcU5ZaWgbS42WzThryRMmgs3Gt9qB4icOyt0SCpRyhtxLJYIktV9SVyoBo1CPXUG
	 NPwMLm/4G51Ug==
Date: Wed, 8 Apr 2026 00:13:23 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH wireless-next v2 0/6] Consolidate Michael MIC code into
 cfg80211
Message-ID: <20260408071323.GA157920@sol>
References: <20260408030651.80336-1-ebiggers@kernel.org>
 <56798292be29f3e76e88c837d41eff0cb9f8b36a.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56798292be29f3e76e88c837d41eff0cb9f8b36a.camel@sipsolutions.net>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34516-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AEBA73B7FDC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 08:32:12AM +0200, Johannes Berg wrote:
> So five out of six patches are wireless, should I apply the crypto one
> too?

It doesn't conflict with anything in linux-next, so it would be possible
to take it too.  Maybe wait a day or two and see if Herbert acks it.

- Eric

