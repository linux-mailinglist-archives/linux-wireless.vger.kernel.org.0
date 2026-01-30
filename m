Return-Path: <linux-wireless+bounces-31345-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKLlCDYVfGn4KQIAu9opvQ
	(envelope-from <linux-wireless+bounces-31345-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 03:19:34 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C68B65EC
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 03:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 39642300598D
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 02:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF1428750A;
	Fri, 30 Jan 2026 02:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkICI+qS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA7D2367B3;
	Fri, 30 Jan 2026 02:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769739572; cv=none; b=AIlrQGbrkTCV2xHQ8XCk6cN4BKj4qh37WCUD93UU4yWSZudN5s/1J7ymKLUMINq+TKY697lHD1+XstfVX7jes5h0ixCbr0bG/Bh5tFn7MEc4jSKBWyWe3oVBm3SX9y5pZMdzMLjkYF0SdeDAeysoj42NHIDZlzOHceAsXHB2oE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769739572; c=relaxed/simple;
	bh=gZkMQkhEUvXZHWfBMMe5HCrgUclZt0xcMDnX+kw282g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TZmXXrgFjxg/HmYGui3XcrzvF4cTocH0gG3n0lDTdZLP6kO7P1GNvhpEyWdBZy/0zmL+dfR9kcWd9rPSAWBeCby8qAKcZeglkQ4ymLWL6iLcPagCi/IPXCBD40yNpIt0MVaOvEY9v+KLkJjQzPxnkHF3kfoqiaZhGZaVMdvJLXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkICI+qS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F7EC4CEF7;
	Fri, 30 Jan 2026 02:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769739571;
	bh=gZkMQkhEUvXZHWfBMMe5HCrgUclZt0xcMDnX+kw282g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TkICI+qSGIO32/Lj87LtONcmGLcBpJYozuNYY6NuKSWthc+viXda5FQ/ZWNFkjXHg
	 M4n1leiH7uNsqiLtDxbGMEzxa9CXeC8ak5/70VzxA8Uvblh9vV4jSB7d4Om5OUFieN
	 Ft72L1RxXAqgIL6V3O/R5Rur2FGdQG4loc23PyBg/h4HoLmiufRteXVVXhxSAl4TK/
	 ytlu8iji9o2xfj9EWddK3ubMe1XWWY0ReWfrB5L1Q78jeCLvNq84RKAdm26lnmc46V
	 jrJu1ydV79RTNN7IGoixPpjBvV8XDhdR9azMPRzCmJuWNZ6cPmsFimi+I4CPXpB24/
	 uWkuKLLL5DKLQ==
Date: Thu, 29 Jan 2026 18:19:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [GIT PULL] wireless-2026-01-29
Message-ID: <20260129181930.34ef6a88@kernel.org>
In-Reply-To: <20260129110403.178036-3-johannes@sipsolutions.net>
References: <20260129110403.178036-3-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31345-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C7C68B65EC
X-Rspamd-Action: no action

On Thu, 29 Jan 2026 12:03:45 +0100 Johannes Berg wrote:
> Here's just a single potential out-of-bounds read fix,
> and I really hope that's the last for this cycle.
> 
> Please pull and let us know if there's any problem.

This was merged and part of today's PR to Linus, thanks!
(Looks like the bot didn't fire.)

