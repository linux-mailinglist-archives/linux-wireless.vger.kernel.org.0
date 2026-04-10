Return-Path: <linux-wireless+bounces-34596-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MELEHru2GmejwgAu9opvQ
	(envelope-from <linux-wireless+bounces-34596-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 14:35:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA73C3D748E
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 14:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C111307C4B4
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 12:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAD33D9DB0;
	Fri, 10 Apr 2026 12:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQFHopbF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2571E3BF677;
	Fri, 10 Apr 2026 12:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775823605; cv=none; b=qAEsLr+ARlGHU00sd/hZB91g3Roa4iNgJLPWUMJlTPsSgVNfkwM97pJiiVFC9WH5WSI4NB+B0chDWNVdHsM9LH4tAriaNzcASZiGOpLWbdhzorJP0k04SN1Ftt3VA00PMwL/DXAC59QlxDI5asHxnlwDWUodAlOnswAqy2bsLZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775823605; c=relaxed/simple;
	bh=OJyrwmrX6lIri0LIdsFu5GdqSG8VG/nHQeslgTl5R4k=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=f8C69ZHYHqVaEEHCSz+BSHpPYfiyYeeTsesnva9tF6yMftVVeI/ci7D4MORtVDPSeyLCiM3pAxA+iZVuD0FypQssGdw3DvMwptXmm3D5gPd9Eau20LT+pNwAYWaWjskwcz9LEKMbeGBrvAi9pRpi2/Lex5ISPxpbmzli6c55EMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQFHopbF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1939C19425;
	Fri, 10 Apr 2026 12:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775823604;
	bh=OJyrwmrX6lIri0LIdsFu5GdqSG8VG/nHQeslgTl5R4k=;
	h=Date:From:To:Cc:Subject:References:From;
	b=SQFHopbFA4avzkQltPCDvONKOyWmV73pxkcg27G4tKW1mNfy7PYVk0h6FRJhlowhk
	 TQQGbFN8xcNa+loyfTw/Ao/LMW9fb2z9STU9hSKk0Q9e4TyhUmpic8YPBLcUkWvS5H
	 AbfS/R5YsMQyaoKc/WDlm6lhBx4bXYBfs3B4LA3Z/Y/SjzAwbFrEIx6rz/PfITLKPl
	 d1tT7WhENbDQpyhAelqaE4x97qqSWFBpW6gFyL/Wzy4bWcES9cochVgZgvdNMg3UtL
	 W9F79+f3Gx3pjpImzUkKb/YiEF7KogJM+PPf5Wjs2H8jaVYTBcG1Ittd3E5H9zOpng
	 +M493bQX3+83g==
Date: Fri, 10 Apr 2026 14:20:01 +0200
Message-ID: <20260410120318.862164111@kernel.org>
User-Agent: quilt/0.68
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>,
 kasan-dev@googlegroups.com,
 Arnd Bergmann <arnd@arndb.de>,
 x86@kernel.org,
 Lu Baolu <baolu.lu@linux.intel.com>,
 iommu@lists.linux.dev,
 Michael Grzeschik <m.grzeschik@pengutronix.de>,
 netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>,
 linux-crypto@vger.kernel.org,
 Vlastimil Babka <vbabka@kernel.org>,
 linux-mm@kvack.org,
 David Woodhouse <dwmw2@infradead.org>,
 Bernie Thompson <bernie@plugable.com>,
 linux-fbdev@vger.kernel.org,
 "Theodore Tso" <tytso@mit.edu>,
 linux-ext4@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Thomas Sailer <t.sailer@alumni.ethz.ch>,
 linux-hams@vger.kernel.org,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 linux-alpha@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-m68k@lists.linux-m68k.org,
 Dinh Nguyen <dinguyen@kernel.org>,
 Jonas Bonn <jonas@southpole.se>,
 linux-openrisc@vger.kernel.org,
 Helge Deller <deller@gmx.de>,
 linux-parisc@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org,
 Paul Walmsley <pjw@kernel.org>,
 linux-riscv@lists.infradead.org,
 Heiko Carstens <hca@linux.ibm.com>,
 linux-s390@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 sparclinux@vger.kernel.org
Subject: [patch 19/38] kcsan: Replace get_cycles() usage
References: <20260410120044.031381086@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,googlegroups.com,arndb.de,kernel.org,linux.intel.com,lists.linux.dev,pengutronix.de,vger.kernel.org,gondor.apana.org.au,kvack.org,infradead.org,plugable.com,mit.edu,linux-foundation.org,gmail.com,alumni.ethz.ch,zx2c4.com,linaro.org,armlinux.org.uk,lists.infradead.org,arm.com,linux-m68k.org,lists.linux-m68k.org,southpole.se,gmx.de,ellerman.id.au,lists.ozlabs.org,linux.ibm.com,davemloft.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-34596-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_TWELVE(0.00)[48];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: EA73C3D748E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

KCSAN uses get_cycles() for two purposes:

  1) Seeding the random state with get_cycles() is a historical leftover.

  2) The microbenchmark uses get_cycles(), which provides an unit less
     counter value and is not guaranteed to be functional on all
     systems/platforms.

Use random_get_entropy() for seeding the random state and ktime_get() which
is universaly functional and provides at least a comprehensible unit.

This is part of a larger effort to remove get_cycles() usage from
non-architecture code.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: Marco Elver <elver@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: kasan-dev@googlegroups.com
---
 kernel/kcsan/core.c    |    2 +-
 kernel/kcsan/debugfs.c |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -798,7 +798,7 @@ void __init kcsan_init(void)
 	BUG_ON(!in_task());
 
 	for_each_possible_cpu(cpu)
-		per_cpu(kcsan_rand_state, cpu) = (u32)get_cycles();
+		per_cpu(kcsan_rand_state, cpu) = (u32)random_get_entropy();
 
 	/*
 	 * We are in the init task, and no other tasks should be running;
--- a/kernel/kcsan/debugfs.c
+++ b/kernel/kcsan/debugfs.c
@@ -58,7 +58,7 @@ static noinline void microbenchmark(unsi
 {
 	const struct kcsan_ctx ctx_save = current->kcsan_ctx;
 	const bool was_enabled = READ_ONCE(kcsan_enabled);
-	u64 cycles;
+	ktime_t nsecs;
 
 	/* We may have been called from an atomic region; reset context. */
 	memset(&current->kcsan_ctx, 0, sizeof(current->kcsan_ctx));
@@ -70,16 +70,16 @@ static noinline void microbenchmark(unsi
 
 	pr_info("%s begin | iters: %lu\n", __func__, iters);
 
-	cycles = get_cycles();
+	nsecs = ktime_get();
 	while (iters--) {
 		unsigned long addr = iters & ((PAGE_SIZE << 8) - 1);
 		int type = !(iters & 0x7f) ? KCSAN_ACCESS_ATOMIC :
 				(!(iters & 0xf) ? KCSAN_ACCESS_WRITE : 0);
 		__kcsan_check_access((void *)addr, sizeof(long), type);
 	}
-	cycles = get_cycles() - cycles;
+	nsecs = ktime_get() - nsecs;
 
-	pr_info("%s end   | cycles: %llu\n", __func__, cycles);
+	pr_info("%s end   | nsecs: %llu\n", __func__, nsecs);
 
 	WRITE_ONCE(kcsan_enabled, was_enabled);
 	/* restore context */


