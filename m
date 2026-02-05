Return-Path: <linux-wireless+bounces-31597-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNwjO3PIhGk45QMAu9opvQ
	(envelope-from <linux-wireless+bounces-31597-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 17:42:27 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2684EF55D0
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 17:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11539300CFED
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Feb 2026 16:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DB1423143;
	Thu,  5 Feb 2026 16:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="HErDp+3H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IIj1tN+f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D6642189D
	for <linux-wireless@vger.kernel.org>; Thu,  5 Feb 2026 16:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770309743; cv=none; b=K2LPRdx4MLIJ90xtm+5V0J1iFF6PMBsDfKij7KkRPw9KQzFFj0Thi+Q4dcBSmJECdotEYZevzxtU5TKLqQrKXSNez7TZ3Zx94se7cWqHqI95eHOCRwxceS2Cvz5LYD5ZviCz6MdLULM+JYaIO90U9zULzSE7JoE1WcxS6vXtcb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770309743; c=relaxed/simple;
	bh=KlIONm0g1NATPZIe9IxUaIcxS25VYoo8zRqDHBVcJvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PF3S2+O7A9ViyGnNLMAnCjkrgjDMXslo1KZy9XC69kTENiPmmCstAoeRCnvRCsQ0bmcFUN2IdLZIa6tfyAEzjOw6ukhTjl7dsUHvrvxo/yBDUq3Z6p6jI2G93RyVDZv8MjyIHogkjb1/EmhDUaRuYM5PUHWsh9K2UjK0IFVPx+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=HErDp+3H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IIj1tN+f; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 526E21D000AA;
	Thu,  5 Feb 2026 11:42:22 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 05 Feb 2026 11:42:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770309742; x=1770396142; bh=KlIONm0g1N
	ATPZIe9IxUaIcxS25VYoo8zRqDHBVcJvw=; b=HErDp+3HfLAcT2s+pjgbnsgadt
	EOR6ygNm0HOQSGe1aG/gh0kesIhSNG28sGoU1R2KY5DWRfsPLClz74v0ckv6xy+W
	O8EH+nm1zyrLdrk6Jqo+h6zzQ8fbttfXruPo4x77DU0iUgpgmb9ZPL6H4/b3CJ8q
	WcJo4Ya5thb2RrgLcbqPAEqovpVfyzNYtoStZabNv+LbzOLIdzRiVF4RUszbPoaU
	KdOHdw5JjbcJXDFQ9oWUta9Sv6P02KlnaXy+lvoooeu8+AEavhDaT9lLC21O5Ikr
	3LuvyGXCtAaTkvKBGQ0TyW6dYJtabgBs+eSXbK1cOpVSvGMNxX8BLtjBFZEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770309742; x=1770396142; bh=KlIONm0g1NATPZIe9IxUaIcxS25VYoo8zRq
	DHBVcJvw=; b=IIj1tN+fqJvfiwJ2rt49YFeDW5739les1oq4hC7gQSdzdNcczdk
	DmbgU84TmEvJgomBXtMowSBYqk5TbOeQnWEOvOAoxsfy1+j2XTY3bEkYbEntBVXk
	b+MEmR0mJFCio/PLcRXi01lRaVK36pYf8KlSFEShicElqjq563y48lTnHU1/AAkA
	WjR3qIhNUxMh+Oq9HAG17FqI2y8CtGoud+fKrRCGoKw8kwXyqS6CMUmDEJgIAt6P
	573lHG7c/OWiHqst4/rQqFc3ekrG1oH5+cuJYbeSpdGDpQ6wePlqMfMvqzLrMFvK
	c9plUJ9kRqIJIumACC+tC4b9WbzaRX6e8kw==
X-ME-Sender: <xms:bciEaRbGCxxi-hxijEQgZDlid_vArZ2k3khWu8RK-UuwYhebcMdbBA>
    <xme:bciEaaofETQoQvWOhk7XnlLg2GwRnA5nm1553AuhEDhz7c3DpxtgythkPxE72JtDv
    Y4EHwyD3cEfxuBlPUKvWxjc9Z9fRpXSAJoUBbrmvDkSl3J7MVY>
X-ME-Received: <xmr:bciEaWMTuRXe8-162rRgQzeQcggPgRkx0ik9F6Fmoi0ENOvKguH1NtnlBnHlL_e9W9GlLwlnMtDP8ZkkLSZA3h9JdzfTqeBjasLVuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeehkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvdevvd
    eljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrd
    gtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegsuhgsuhhpvghrshhonhgrlhesthhuthgrmhgrihhlrdgtohhmpdhrtghpthhtoheplh
    hinhhugidqshhtrghgihhngheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthho
    pehlihhnuhigqdifihhrvghlvghsshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:bciEaVqhK896scNPLYerng0BZQd7wujELZXd7xOVirL33h0r7EaiaQ>
    <xmx:bciEabdjN3vh4dh474GSmu7gMhdJa0QTuYnhfjgI2geqgBjIpEsFSw>
    <xmx:bciEabQ-LStPuPlUKmaaS7_-8-5OlUk9DViC81-ccnVnd902Gxhm5Q>
    <xmx:bciEaUbGY2JxnSPRmzhCF4LVQewHxyi-jv7Bv_KhgwD4gZ8pRKh1Lg>
    <xmx:bsiEaQ8m_NFcsRQCdOJkJ4PlpWU1yAoU9KRa6tHo3CzYzIBVF0Ha5W1C>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Feb 2026 11:42:21 -0500 (EST)
Date: Thu, 5 Feb 2026 17:42:19 +0100
From: Greg KH <greg@kroah.com>
To: bubupersonal@tutamail.com
Cc: Linux Staging <linux-staging@lists.linux.dev>,
	Linux Wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] rtw: btcoex: clean up style and documentation
Message-ID: <2026020541-pectin-jujitsu-0c63@gregkh>
References: <OkiaM3C--F-9@tutamail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OkiaM3C--F-9@tutamail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kroah.com,none];
	R_DKIM_ALLOW(-0.20)[kroah.com:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31597-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kroah.com:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greg@kroah.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2684EF55D0
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 05:18:54PM +0100, bubupersonal@tutamail.com wrote:
> From: Bubuworks <bubupersonal@tutamail.com>
> Date: Thu, 05 Feb 2026 17:25:00 +0200
> Subject: [PATCH] rtw: btcoex: clean up style and documentation
> Signed-off-by: Bubuworks <bubupersonal@tutamail.com>

This looks very odd, are you sure it's correct, because:

> <start of patch>
> >From 0eca95cba2b7bf7b7b4f2fa90734a85fcaa72782 Mon Sep 17 00:00:00 2001
> From: Tejun Heo <tj@kernel.org>
> Date: Wed, 4 Feb 2026 10:07:55 -1000
> Subject: [PATCH] sched_ext: Short-circuit sched_class operations on dead tasks

That's not your patch :(

Something went wrong with your email system :(


