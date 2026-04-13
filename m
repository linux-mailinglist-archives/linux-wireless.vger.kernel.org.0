Return-Path: <linux-wireless+bounces-34681-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEFxNrSD3GnnSAkAu9opvQ
	(envelope-from <linux-wireless+bounces-34681-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 07:48:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7153E790D
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 07:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7BCB3011C49
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 05:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817F02FFF8D;
	Mon, 13 Apr 2026 05:47:49 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7222773E5;
	Mon, 13 Apr 2026 05:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776059269; cv=none; b=QeSSnTQ5WCx2Uj3fQdKD5vClqnMl+kAXwHmoQSJ7Xs9dksD57pMKsWjzf8ew395QnU6gG7A8xHfQ/5HRlSo+Ooelzk2PAceFZkBb0WVjZnWcwVm+2JFeL9NF5PCSnBjDXXtyzGERfi8IpNVFQRf0vUsE4RLqWnt795LtRmapbk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776059269; c=relaxed/simple;
	bh=YxepDZzylg7DLxJ1UuKV5wvO8y/p14MplYX7PzmcQ08=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MWbOo9tARfrBcn9eCmjchtLcu1r1J5lRuBc0zX4vTTkBRHjrM005QWIXYzagKgVmbOA1+vcY/1KRpr+8fALLgx5V8fd5yZ9xvRcO92MT2JFxDdxJKKXegRxQ3RbBl/dgtmtyV2UHqPH0cPMUsH8IqkMp1AyutpAbh+2ZqvUfQSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 2FA4892009C; Mon, 13 Apr 2026 07:47:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 283D292009B;
	Mon, 13 Apr 2026 06:47:45 +0100 (BST)
Date: Mon, 13 Apr 2026 06:47:45 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Thomas Gleixner <tglx@kernel.org>
cc: LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
    x86@kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev, 
    Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org, 
    linux-wireless@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
    linux-crypto@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>, 
    linux-mm@kvack.org, David Woodhouse <dwmw2@infradead.org>, 
    Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org, 
    Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Uladzislau Rezki <urezki@gmail.com>, Marco Elver <elver@google.com>, 
    Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
    Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
    Thomas Sailer <t.sailer@alumni.ethz.ch>, linux-hams@vger.kernel.org, 
    "Jason A. Donenfeld" <Jason@zx2c4.com>, 
    Richard Henderson <richard.henderson@linaro.org>, 
    linux-alpha@vger.kernel.org, Russell King <linux@armlinux.org.uk>, 
    linux-arm-kernel@lists.infradead.org, 
    Catalin Marinas <catalin.marinas@arm.com>, 
    Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
    Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, 
    Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, 
    linux-openrisc@vger.kernel.org, Helge Deller <deller@gmx.de>, 
    linux-parisc@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
    linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>, 
    linux-riscv@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>, 
    linux-s390@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
    sparclinux@vger.kernel.org
Subject: Re: [patch 28/38] mips: Select ARCH_HAS_RANDOM_ENTROPY
In-Reply-To: <20260410120319.462206386@kernel.org>
Message-ID: <alpine.DEB.2.21.2604130638270.29980@angie.orcam.me.uk>
References: <20260410120044.031381086@kernel.org> <20260410120319.462206386@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34681-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[orcam.me.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,arndb.de,kernel.org,linux.intel.com,lists.linux.dev,pengutronix.de,gondor.apana.org.au,kvack.org,infradead.org,plugable.com,mit.edu,linux-foundation.org,gmail.com,google.com,googlegroups.com,alumni.ethz.ch,zx2c4.com,linaro.org,armlinux.org.uk,lists.infradead.org,arm.com,linux-m68k.org,lists.linux-m68k.org,southpole.se,gmx.de,ellerman.id.au,lists.ozlabs.org,linux.ibm.com,davemloft.net];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[macro@orcam.me.uk,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,angie.orcam.me.uk:mid]
X-Rspamd-Queue-Id: 7A7153E790D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 10 Apr 2026, Thomas Gleixner wrote:

> The only solution for now is to uninline random_get_entropy().  Fix up all
> other dependencies on the content of asm/timex.h in those files which
> really depend on it.

 Oh dear!  I'd yet have to fully evaluate the consequences, but offhand 
this has clearly turned what compiles to a single CPU instruction on the 
vast majority of MIPS platforms into an expensive function call, possibly 
also changing the caller from a leaf to a nested function with all the 
associated execution penalty.  Is there no other way?

 Cf. commit 06947aaaf9bf ("MIPS: Implement random_get_entropy with CP0 
Random").

  Maciej

