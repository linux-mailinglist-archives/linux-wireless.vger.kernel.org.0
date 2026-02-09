Return-Path: <linux-wireless+bounces-31673-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBfBFbJdimkWJwAAu9opvQ
	(envelope-from <linux-wireless+bounces-31673-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 23:20:34 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4E911506F
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 23:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE1EF3019139
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Feb 2026 22:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0F22D97B4;
	Mon,  9 Feb 2026 22:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rhn5T5mz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B4D31159C;
	Mon,  9 Feb 2026 22:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770675630; cv=none; b=FBub4loq+OM3BgxijRSWKdOs1HHd9kvZ72wRyx9XYoXphdAHmo7hqdpZfyY/sEyYA9uXbVasTJcd8BtdFAbaae7Jw+HabwD3VFAdHQ7xPidp6JlpaqOCJL3e62hkraU9OnVePbjVmzFc8nIl0vvcbYOtdSAKLcHe+KHI68bHqEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770675630; c=relaxed/simple;
	bh=s7d/M1vKJfN+2zrV6zCSeKrYdtHPYyHp+ZgpNYNDzxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XaRiw5bzfBvmFLFAFJ1FV4U8Hlt4WnBJEbTPbeNP0Sk4ZmhSXrohXmR7GPzp5ILVV6U+S35zugUGB7bx1/5rwsr95X9583cBCcn8HFOJIrvssnAzX78LZ5WJhTMtnpSc1+Tlv0f3u0bEtpbY4aP3VATX3JOTNrdB9FFeqvwb2OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rhn5T5mz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B86C116C6;
	Mon,  9 Feb 2026 22:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770675629;
	bh=s7d/M1vKJfN+2zrV6zCSeKrYdtHPYyHp+ZgpNYNDzxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rhn5T5mz3yCjtJM5hXDDWBlaFcZliGgczMvH73aoFaYZizjWCx5bOTf7xseRLDtv6
	 iKMa3jtHnJXwcmxOoctoBVd4VYlzMw4lIyAI0TQt+P/43OKjb7ntpcUZw/NqMYLoSY
	 PIxBQFPnGkQHRQSBCF65cB5gonYNkGAp9uYUksegpLfVmZtgr2mNpRfuZbXNnpZ/y2
	 5K5Pya+6oc/P/yRoygnUSleOpS+aAdVce8IcKa/qq6lPZIPs6xOM9hfN7CY9iwam14
	 rsXSNxlCKG3s7TA2y6EfsaM/stQjHPiz2dJZW/VPpNG730QrGfvh62qyHdAHJjJ3ks
	 1P19MtVCx9QYQ==
Date: Mon, 9 Feb 2026 14:20:29 -0800
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Stanislaw Gruszka <stf_xl@wp.pl>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] iwlegacy: Avoid multiple
 -Wflex-array-member-not-at-end warnings
Message-ID: <202602091416.A7FD08F6C@keescook>
References: <aYlkt2WP2oQ1TgeH@kspp>
 <202602091212.743C6B9B7C@keescook>
 <4bf43164-b130-4643-9f4f-761f49bd0dc9@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bf43164-b130-4643-9f4f-761f49bd0dc9@embeddedor.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31673-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,wp.pl,sipsolutions.net,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kees@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CB4E911506F
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 03:23:59PM +0900, Gustavo A. R. Silva wrote:
> Ah yes, I can do this. The only thing is that I'd have to change every
> place where members in struct il4965_tx_resp are used, e.g.
> 
> s/frame_count/hdr.frame_count

Hm? No, that's what transparent struct members avoid: there is no
sub-struct name, the members of the struct are transparently visible in
the surrounding struct:

struct inside {
	int a;
	int b;
};

struct foo {
	struct inside;
	int c;
} *p;

"p->a" is valid.

> Another thing to take into account (fortunately, not in this case) is
> when the FAM needs to be annotated with __counted_by(). If we use a
> separate struct for the header portion of the flexible structure, GCC
> currently cannot _see_ the _counter_ if it's included in a non-anonymous
> structure. However, this will be possible in the near future, correct?

Right, that's still in progress. I don't expect it soon, though. :(

-- 
Kees Cook

