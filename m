Return-Path: <linux-wireless+bounces-34904-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2E+CN9894WmaqgAAu9opvQ
	(envelope-from <linux-wireless+bounces-34904-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 21:51:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA284145A9
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 21:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30C0B300EAB6
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 19:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FC939BFFE;
	Thu, 16 Apr 2026 19:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjiRJ3JY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29713328E6;
	Thu, 16 Apr 2026 19:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776367791; cv=none; b=h99ZDiJjYePB6WtQ8oWD3oqwwTUfRnVzJ5XuXct2fHa9i9vyWZ8jvAuAhgyEvTA+87KWCQv19M4PFjm6qqpD8fVc1tfCAUWxg3JGyQ3SJGpw2a7ebmq4BWp3AXvDMnbkoVs9bpseVbSlZwae1juTZZ2ESuAnDW3s4SU4M5rRYik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776367791; c=relaxed/simple;
	bh=IYYhpzvOPkjnKmWSOWOV2gjFmCyUK20pzUwsrPCl5+c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qazqREEbkyQ2aUEUQzePNtMduFMBhFC4Jjy/K/gssK+BvWQIoy4aEylTzmD53RkSRgKqtGpfKEt/I4dtzes5XLmH/40YAWthemsbZIAgFqM+4rHeHfMyAcuuQk8G3H5YiQJilMyqW4geXA4qRdjHWlbFkeVIbin+CnKAMUOIl0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjiRJ3JY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F0EC2BCAF;
	Thu, 16 Apr 2026 19:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776367790;
	bh=IYYhpzvOPkjnKmWSOWOV2gjFmCyUK20pzUwsrPCl5+c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=TjiRJ3JYC6H6QODlRe73weMWqu2ToVyxgZaKwDYZeUuXvTFyEukiq8tmP1ejDxYzD
	 rmrx12vxM0g7ZC9obrRxDAfB+VnhJNvbWfFDZNFPe0bmQhLp4LsxxAr5syn+ysbEnb
	 CJFNwSq3IzVphxzvT3UyUKOg1K7FQt/yAeF/6TILljylkaralKACrM4Mn6BgOOeIKv
	 wGHlIow7JIanfsrwpPNBBsFvw34FcmmRQCfrRZvueDO/yyXUoANoGReW/3j6l4sYGi
	 SDFU6WZgysyVavWZIkFYQOfBKcrZOljXUSUoxloeAjzhJrasftfXxGpcy4vC+O3xsf
	 ay/dWzrcNvMPQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, Arnd
 Bergmann <arnd@arndb.de>, x86@kernel.org, Lu Baolu
 <baolu.lu@linux.intel.com>, iommu@lists.linux.dev, Michael Grzeschik
 <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
 linux-crypto@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>,
 linux-mm@kvack.org, David Woodhouse <dwmw2@infradead.org>, Bernie Thompson
 <bernie@plugable.com>, linux-fbdev@vger.kernel.org, Theodore Tso
 <tytso@mit.edu>, linux-ext4@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, Marco
 Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 kasan-dev@googlegroups.com, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Thomas Sailer <t.sailer@alumni.ethz.ch>, linux-hams@vger.kernel.org,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, Richard Henderson
 <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, Russell King
 <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Catalin
 Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-m68k@lists.linux-m68k.org, Dinh Nguyen <dinguyen@kernel.org>, Jonas
 Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, Helge Deller
 <deller@gmx.de>, linux-parisc@vger.kernel.org, Michael Ellerman
 <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Paul Walmsley
 <pjw@kernel.org>, linux-riscv@lists.infradead.org, "David S. Miller"
 <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: Re: [patch 35/38] s390: Select ARCH_HAS_RANDOM_ENTROPY
In-Reply-To: <20260416134238.9230Ba6-hca@linux.ibm.com>
References: <20260410120044.031381086@kernel.org>
 <20260410120319.924028412@kernel.org>
 <20260416134238.9230Ba6-hca@linux.ibm.com>
Date: Thu, 16 Apr 2026 21:29:46 +0200
Message-ID: <87y0imemad.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [4.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34904-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[48];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,body];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,arndb.de,kernel.org,linux.intel.com,lists.linux.dev,pengutronix.de,gondor.apana.org.au,kvack.org,infradead.org,plugable.com,mit.edu,linux-foundation.org,gmail.com,google.com,googlegroups.com,alumni.ethz.ch,zx2c4.com,linaro.org,armlinux.org.uk,lists.infradead.org,arm.com,linux-m68k.org,lists.linux-m68k.org,southpole.se,gmx.de,ellerman.id.au,lists.ozlabs.org,davemloft.net];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3EA284145A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16 2026 at 15:42, Heiko Carstens wrote:
> On Fri, Apr 10, 2026 at 02:21:19PM +0200, Thomas Gleixner wrote:
>> The only remaining non-architecture usage of get_cycles() is to provide
>> random_get_entropy().
>> 
>> Switch s390 over to the new scheme of selecting ARCH_HAS_RANDOM_ENTROPY and
>> providing random_get_entropy() in asm/random.h.
>> 
>> Add 'asm/timex.h' includes to the relevant files, so the global include can
>> be removed once all architectures are converted over.
>> 
>> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
>> Cc: Heiko Carstens <hca@linux.ibm.com>
>> Cc: linux-s390@vger.kernel.org
>> ---
>>  arch/s390/Kconfig              |    1 +
>>  arch/s390/include/asm/random.h |   12 ++++++++++++
>>  arch/s390/include/asm/timex.h  |    6 ------
>>  arch/s390/kernel/time.c        |    1 +
>>  arch/s390/kernel/vtime.c       |    1 +
>>  5 files changed, 15 insertions(+), 6 deletions(-)
>
> Acked-by: Heiko Carstens <hca@linux.ibm.com>
>
> Thomas, would you mind adding the below as minor improvement to this
> series?

Sure. I'll respin it next week.

