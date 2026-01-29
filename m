Return-Path: <linux-wireless+bounces-31333-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKMxAK6Ke2mlFQIAu9opvQ
	(envelope-from <linux-wireless+bounces-31333-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 17:28:30 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 572F7B22BD
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 17:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6869A3003813
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 16:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B3B33FE26;
	Thu, 29 Jan 2026 16:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnDXN0yE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DF23314C4;
	Thu, 29 Jan 2026 16:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769704103; cv=none; b=YE9LQM1BErXO0x5FhEyTxMMQP5/7VJc/IGeR4u4JuzpM9K50jTbi7BmZvECmlodmmZjY+CqafL5ckojQszT+COS4UHMJU17q14iuQ4If8YlP2sxSFBk7hxv+Pw5orQ27J9l31S5oF3sabsU52ZgTyayeaXjNDXbcmuTENWKhSyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769704103; c=relaxed/simple;
	bh=1J7pS2RukN9wYM2u+ak+A9j8Lr2XJjk8BRjgXJeOOik=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RQF4PioffZrnAqycAluHqwc9m8jbHybxEp0oEVvwl/wA8SepYOj7a5OAZPSD9oKWE+gnF+tq1FHGe2+3flfhAt842dNeopUb7M2XzhSmxQlrrUH+xREUMXAU51ggvGgzX4EyVyJfpTtznkC0V/6OlYJ7bLnYXgddyAmtoK6J1r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnDXN0yE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B4FC4CEF7;
	Thu, 29 Jan 2026 16:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769704103;
	bh=1J7pS2RukN9wYM2u+ak+A9j8Lr2XJjk8BRjgXJeOOik=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QnDXN0yEWy5PXynKdw7QI3UOOAgxIx0f9zZY2XRD2KDQ0UNrRslZ9d5CV39J8DZA5
	 winjMwZ0xGsy9xbzlyBxmAOq8Cuh3opC4xLhcEN2ttFgjYPhWY5DBdw3/aKff0vg56
	 aRfFcjebjyVh7noQTLxuMBWUuRleXqw5oH5HSFjkGprawHee6KTUB4BquAYIcBO0Ik
	 8BlnUmtA6nSxa6lBQuiRS5D8y35lawji6Bj2zg9c7rsZiHvR9yRi8PSsMmlvtPpy71
	 XZzJcZYMHExoG0avv52emYMM9CtxOrkuEqRGtGnFUYRHUJvkzD1nCKLGFY+8eX2Mes
	 wz0UXyG5JoVLw==
Date: Thu, 29 Jan 2026 08:28:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org
Subject: Re: [GIT PULL] wireless-next-2026-01-29
Message-ID: <20260129082822.7ccf788a@kernel.org>
In-Reply-To: <b0d6887f-7946-46b6-986a-bf410b832d66@redhat.com>
References: <20260129110136.176980-39-johannes@sipsolutions.net>
	<b0d6887f-7946-46b6-986a-bf410b832d66@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31333-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 572F7B22BD
X-Rspamd-Action: no action

On Thu, 29 Jan 2026 15:08:46 +0100 Paolo Abeni wrote:
> https://patchwork.kernel.org/project/netdevbpf/patch/20260129110136.176980-39-johannes@sipsolutions.net/
> 
> so it could be a CI flake, but could you please have a look?

flake, fwiw

