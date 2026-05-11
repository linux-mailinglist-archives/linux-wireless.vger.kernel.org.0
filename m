Return-Path: <linux-wireless+bounces-36262-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFOMGp0uAmq/ogEAu9opvQ
	(envelope-from <linux-wireless+bounces-36262-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 21:31:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF0D515251
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 21:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BE2F30210E2
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 19:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A5B3502A3;
	Mon, 11 May 2026 19:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C42KQ41W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA382BDC0F;
	Mon, 11 May 2026 19:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778527890; cv=none; b=NWl8loSeBe68ty8AppoRS+8ha+Ma3isUbjnFrmFYu5XZLMUDJezpFqjYLoCp9FxZTyqVyaS5OZSlAMM39flspDOBRrSdlIKVFg+FIvfDSRs62cGCss2W/M0kyLCtsQuJagg+jQ3B8CrMScZg4SgyYFFEG0zbExp/I2fXPWcj2wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778527890; c=relaxed/simple;
	bh=KrGrYXDQBEe3HlrkPoqTDtByhqTYffazSDqdjTNwfho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgweABoHlqtg2kJWnxEzRvEtM0Fsomupr8FE4dJzKzd5iDMRPQKuQmETv5fMsrueSBpEPYQJrED4INj048/ivKxco+yuB/NxFA/PDVMG19CmVt9JPCm+4lzi/bXlmeW9xfCLygONnMP5vLicqGiCYv8KQHFO9lQqUUVKhxbLXH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C42KQ41W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E9DC2BCB0;
	Mon, 11 May 2026 19:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778527890;
	bh=KrGrYXDQBEe3HlrkPoqTDtByhqTYffazSDqdjTNwfho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C42KQ41WDl6E16K2sXNnZdJ6mkv02370w16Q79c5SjJ6iNELNizZrDkTBtEu3rwH8
	 8559f3t5fRDYNoKvDUCMIM4pdCe4SGopIITxTgygiIiK+hmxC7BlFCVh8sMqOHAqNJ
	 e8dCExJTTySn4GlYqjseq3UTyQ1oLtqf2k/wwZCDjWeOhdYA4KT7/0kwZf3H0/hBYX
	 R2NTtpkYVByPJBB+hZQn2qzXBHtD79krifKRrae2Keuy/Rx/EtBB3cNjah6tQ0cz5+
	 jpmXmUc64vrWehrBu2/kgCWe/Lg3lQu57ZT4BSIFmSQo7jjYvPM5D6WQ1ui/TRY85d
	 acAmtws2evcYA==
Date: Mon, 11 May 2026 12:31:29 -0700
From: Kees Cook <kees@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Jiazi Li <jqqlijiazi@gmail.com>, Andy Shevchenko <andy@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-hardening@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Add str_alloc_free() helper
Message-ID: <202605111230.319F9EDB2@keescook>
References: <cover.1778051552.git.jqqlijiazi@gmail.com>
 <fe81137b849e349bd9b0529c7e0e4be6b4099a5b.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe81137b849e349bd9b0529c7e0e4be6b4099a5b.camel@sipsolutions.net>
X-Rspamd-Queue-Id: CBF0D515251
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,realtek.com,inria.fr,imag.fr,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-36262-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kees@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 01:10:03PM +0200, Johannes Berg wrote:
> On Thu, 2026-05-07 at 19:03 +0800, Jiazi Li wrote:
> > Currently finds 4 locations:
> > ./drivers/net/wireless/realtek/rtw89/fw.c:2557:7-12: opportunity for str_alloc_free(valid)
> > ./drivers/net/wireless/realtek/rtw89/fw.c:2693:7-12: opportunity for str_alloc_free(valid)
> > ./drivers/android/tests/binder_alloc_kunit.c:196:6-21: opportunity for str_alloc_free(alloc -> pages [ i ])
> > ./mm/slub.c:1634:3-8: opportunity for str_alloc_free(alloc)
> 
> It's what, three characters shorter for four users each? Is there really
> much point?
> 
> Reading just the name also is really confusing - yes it lines up with
> str_assert_deassert, but "alloc_free" really doesn't seem very obvious -
> why would you alloc and free a string in one function call?

Yeah, there seems to only be 1 source file instance of this? I don't
think this needs the entire helper infrastructure.

-- 
Kees Cook

