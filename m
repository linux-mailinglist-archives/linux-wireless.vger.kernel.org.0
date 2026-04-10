Return-Path: <linux-wireless+bounces-34595-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFtjLGHu2GlLjwgAu9opvQ
	(envelope-from <linux-wireless+bounces-34595-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 14:34:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 712F63D7421
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 14:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B2B6307802C
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 12:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EED3CAE6E;
	Fri, 10 Apr 2026 12:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAmn2yz6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9123C9EFE;
	Fri, 10 Apr 2026 12:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775823600; cv=none; b=BA04YgR7ol+UFlnyeMGxIX9JJapi5P+DpwD+4z8F5mYUkgC3uR84zQ7PuKPZffWeJrEzxORq5hn6JNhkozHotqQDgtN1O1RKmTM3RJHM2HVfRLJNtf3mBi1U/3QWwgTEvlvipTFs1aI52maDwx2GPlFGLfPYh4KQkj5JSSNZOpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775823600; c=relaxed/simple;
	bh=p4ShM3O0GBFCP2qPjb6zSxh+Ha5oLOtvBK8/RtfAnVs=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=bPz3KR+7Cs1qoa7AMSZYQs3mwFwGiVffmg3WafL7SkDEqsFq+dGsYvb+yx1PAoJ6dwHFVet5WDt8IlMLiGvP64fHX3iYLiZmHKvXzhPh5t7jWb5XB63t/tTLp224p2GKOSybc/2KSAYtgmbVXmWs6v4UCtSMZ+ZjCOYL2aLNnrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAmn2yz6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25608C2BC87;
	Fri, 10 Apr 2026 12:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775823599;
	bh=p4ShM3O0GBFCP2qPjb6zSxh+Ha5oLOtvBK8/RtfAnVs=;
	h=Date:From:To:Cc:Subject:References:From;
	b=dAmn2yz62WI0i12fcQ9F03BvOYg2+eAhjig+X04BVmpX8c9M01sHZgZEu1rVRhWki
	 aMBfoGnUl9WpMMqLWFryj6yJQ9lwTCD1i0oDG/S5mN25bXyGqKT30GrztgQQ3rav4T
	 BmbqmYb8KPxXW6sSQ9CXXe5EvhipWJeX23ghk7uDybakuO9EcTg4cMG5iBSrRe/GPa
	 tJ33MSKa5EFjbZHZi72K/jby5Pm2bPWRte8ZG3Zb5p2f71WeXeB85PUV24dYQuwkS9
	 ZuUw9oOAlqL+roK/1FBLE3TIhiCqSUqlbqWXBE/GwV9uTSEnFXIo6OPA+8wwtYtllu
	 kFOMRP9PboEEQ==
Date: Fri, 10 Apr 2026 14:19:56 +0200
Message-ID: <20260410120318.794680738@kernel.org>
User-Agent: quilt/0.68
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 linux-mm@kvack.org,
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
 David Woodhouse <dwmw2@infradead.org>,
 Bernie Thompson <bernie@plugable.com>,
 linux-fbdev@vger.kernel.org,
 "Theodore Tso" <tytso@mit.edu>,
 linux-ext4@vger.kernel.org,
 Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>,
 kasan-dev@googlegroups.com,
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
Subject: [patch 18/38] lib/tests: Replace get_cycles() with ktime_get()
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,kvack.org,arndb.de,kernel.org,linux.intel.com,lists.linux.dev,pengutronix.de,vger.kernel.org,gondor.apana.org.au,infradead.org,plugable.com,mit.edu,google.com,googlegroups.com,alumni.ethz.ch,zx2c4.com,linaro.org,armlinux.org.uk,lists.infradead.org,arm.com,linux-m68k.org,lists.linux-m68k.org,southpole.se,gmx.de,ellerman.id.au,lists.ozlabs.org,linux.ibm.com,davemloft.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-34595-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: 712F63D7421
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

get_cycles() is the historical access to a fine grained time source, but it
is a suboptimal choice for two reasons:

   - get_cycles() is not guaranteed to be supported and functional on all
     systems/platforms. If not supported or not functional it returns 0,
     which makes benchmarking moot.

   - get_cycles() returns the raw counter value of whatever the
     architecture platform provides. The original x86 Time Stamp Counter
     (TSC) was despite its name tied to the actual CPU core frequency.
     That's not longer the case. So the counter value is only meaningful
     when the CPU operates at the same frequency as the TSC or the value is
     adjusted to the actual CPU frequency. Other architectures and
     platforms provide similar disjunct counters via get_cycles(), so the
     result is operations per BOGO-cycles, which is not really meaningful.

Use ktime_get() instead which provides nanosecond timestamps with the
granularity of the underlying hardware counter, which is not different to
the variety of get_cycles() implementations.

This provides at least understandable metrics, i.e. operations/nanoseconds,
and is available on all platforms. As with get_cycles() the result might
have to be put into relation with the CPU operating frequency, but that's
not any different.

This is part of a larger effort to remove get_cycles() usage from
non-architecture code.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: linux-mm@kvack.org
---
 lib/interval_tree_test.c |   16 ++++++++--------
 lib/rbtree_test.c        |   46 +++++++++++++++++++++++-----------------------
 lib/test_vmalloc.c       |   10 +++++-----
 3 files changed, 36 insertions(+), 36 deletions(-)

--- a/lib/interval_tree_test.c
+++ b/lib/interval_tree_test.c
@@ -65,13 +65,13 @@ static void init(void)
 static int basic_check(void)
 {
 	int i, j;
-	cycles_t time1, time2, time;
+	ktime_t time1, time2, time;
 
 	printk(KERN_ALERT "interval tree insert/remove");
 
 	init();
 
-	time1 = get_cycles();
+	time1 = ktime_get();
 
 	for (i = 0; i < perf_loops; i++) {
 		for (j = 0; j < nnodes; j++)
@@ -80,11 +80,11 @@ static int basic_check(void)
 			interval_tree_remove(nodes + j, &root);
 	}
 
-	time2 = get_cycles();
+	time2 = ktime_get();
 	time = time2 - time1;
 
 	time = div_u64(time, perf_loops);
-	printk(" -> %llu cycles\n", (unsigned long long)time);
+	printk(" -> %llu nsecs\n", (unsigned long long)time);
 
 	return 0;
 }
@@ -93,7 +93,7 @@ static int search_check(void)
 {
 	int i, j;
 	unsigned long results;
-	cycles_t time1, time2, time;
+	ktime_t time1, time2, time;
 
 	printk(KERN_ALERT "interval tree search");
 
@@ -102,7 +102,7 @@ static int search_check(void)
 	for (j = 0; j < nnodes; j++)
 		interval_tree_insert(nodes + j, &root);
 
-	time1 = get_cycles();
+	time1 = ktime_get();
 
 	results = 0;
 	for (i = 0; i < search_loops; i++)
@@ -113,12 +113,12 @@ static int search_check(void)
 			results += search(&root, start, last);
 		}
 
-	time2 = get_cycles();
+	time2 = ktime_get();
 	time = time2 - time1;
 
 	time = div_u64(time, search_loops);
 	results = div_u64(results, search_loops);
-	printk(" -> %llu cycles (%lu results)\n",
+	printk(" -> %llu nsecs (%lu results)\n",
 	       (unsigned long long)time, results);
 
 	for (j = 0; j < nnodes; j++)
--- a/lib/rbtree_test.c
+++ b/lib/rbtree_test.c
@@ -243,14 +243,14 @@ static void check_augmented(int nr_nodes
 static int basic_check(void)
 {
 	int i, j;
-	cycles_t time1, time2, time;
+	ktime_t time1, time2, time;
 	struct rb_node *node;
 
 	printk(KERN_ALERT "rbtree testing");
 
 	init();
 
-	time1 = get_cycles();
+	time1 = ktime_get();
 
 	for (i = 0; i < perf_loops; i++) {
 		for (j = 0; j < nnodes; j++)
@@ -259,14 +259,14 @@ static int basic_check(void)
 			erase(nodes + j, &root);
 	}
 
-	time2 = get_cycles();
+	time2 = ktime_get();
 	time = time2 - time1;
 
 	time = div_u64(time, perf_loops);
-	printk(" -> test 1 (latency of nnodes insert+delete): %llu cycles\n",
+	printk(" -> test 1 (latency of nnodes insert+delete): %llu nsecs\n",
 	       (unsigned long long)time);
 
-	time1 = get_cycles();
+	time1 = ktime_get();
 
 	for (i = 0; i < perf_loops; i++) {
 		for (j = 0; j < nnodes; j++)
@@ -275,52 +275,52 @@ static int basic_check(void)
 			erase_cached(nodes + j, &root);
 	}
 
-	time2 = get_cycles();
+	time2 = ktime_get();
 	time = time2 - time1;
 
 	time = div_u64(time, perf_loops);
-	printk(" -> test 2 (latency of nnodes cached insert+delete): %llu cycles\n",
+	printk(" -> test 2 (latency of nnodes cached insert+delete): %llu nsecs\n",
 	       (unsigned long long)time);
 
 	for (i = 0; i < nnodes; i++)
 		insert(nodes + i, &root);
 
-	time1 = get_cycles();
+	time1 = ktime_get();
 
 	for (i = 0; i < perf_loops; i++) {
 		for (node = rb_first(&root.rb_root); node; node = rb_next(node))
 			;
 	}
 
-	time2 = get_cycles();
+	time2 = ktime_get();
 	time = time2 - time1;
 
 	time = div_u64(time, perf_loops);
-	printk(" -> test 3 (latency of inorder traversal): %llu cycles\n",
+	printk(" -> test 3 (latency of inorder traversal): %llu nsecs\n",
 	       (unsigned long long)time);
 
-	time1 = get_cycles();
+	time1 = ktime_get();
 
 	for (i = 0; i < perf_loops; i++)
 		node = rb_first(&root.rb_root);
 
-	time2 = get_cycles();
+	time2 = ktime_get();
 	time = time2 - time1;
 
 	time = div_u64(time, perf_loops);
 	printk(" -> test 4 (latency to fetch first node)\n");
-	printk("        non-cached: %llu cycles\n", (unsigned long long)time);
+	printk("        non-cached: %llu nsecs\n", (unsigned long long)time);
 
-	time1 = get_cycles();
+	time1 = ktime_get();
 
 	for (i = 0; i < perf_loops; i++)
 		node = rb_first_cached(&root);
 
-	time2 = get_cycles();
+	time2 = ktime_get();
 	time = time2 - time1;
 
 	time = div_u64(time, perf_loops);
-	printk("        cached: %llu cycles\n", (unsigned long long)time);
+	printk("        cached: %llu nsecs\n", (unsigned long long)time);
 
 	for (i = 0; i < nnodes; i++)
 		erase(nodes + i, &root);
@@ -345,13 +345,13 @@ static int basic_check(void)
 static int augmented_check(void)
 {
 	int i, j;
-	cycles_t time1, time2, time;
+	ktime_t time1, time2, time;
 
 	printk(KERN_ALERT "augmented rbtree testing");
 
 	init();
 
-	time1 = get_cycles();
+	time1 = ktime_get();
 
 	for (i = 0; i < perf_loops; i++) {
 		for (j = 0; j < nnodes; j++)
@@ -360,13 +360,13 @@ static int augmented_check(void)
 			erase_augmented(nodes + j, &root);
 	}
 
-	time2 = get_cycles();
+	time2 = ktime_get();
 	time = time2 - time1;
 
 	time = div_u64(time, perf_loops);
-	printk(" -> test 1 (latency of nnodes insert+delete): %llu cycles\n", (unsigned long long)time);
+	printk(" -> test 1 (latency of nnodes insert+delete): %llu nsecs\n", (unsigned long long)time);
 
-	time1 = get_cycles();
+	time1 = ktime_get();
 
 	for (i = 0; i < perf_loops; i++) {
 		for (j = 0; j < nnodes; j++)
@@ -375,11 +375,11 @@ static int augmented_check(void)
 			erase_augmented_cached(nodes + j, &root);
 	}
 
-	time2 = get_cycles();
+	time2 = ktime_get();
 	time = time2 - time1;
 
 	time = div_u64(time, perf_loops);
-	printk(" -> test 2 (latency of nnodes cached insert+delete): %llu cycles\n", (unsigned long long)time);
+	printk(" -> test 2 (latency of nnodes cached insert+delete): %llu nsecs\n", (unsigned long long)time);
 
 	for (i = 0; i < check_loops; i++) {
 		init();
--- a/lib/test_vmalloc.c
+++ b/lib/test_vmalloc.c
@@ -454,8 +454,8 @@ static struct test_driver {
 	struct task_struct *task;
 	struct test_case_data data[ARRAY_SIZE(test_case_array)];
 
-	unsigned long start;
-	unsigned long stop;
+	ktime_t start;
+	ktime_t stop;
 } *tdriver;
 
 static void shuffle_array(int *arr, int n)
@@ -490,7 +490,7 @@ static int test_func(void *private)
 	 */
 	synchronize_srcu(&prepare_for_test_srcu);
 
-	t->start = get_cycles();
+	t->start = ktime_get();
 	for (i = 0; i < ARRAY_SIZE(test_case_array); i++) {
 		index = random_array[i];
 
@@ -519,7 +519,7 @@ static int test_func(void *private)
 
 		t->data[index].time = delta;
 	}
-	t->stop = get_cycles();
+	t->stop = ktime_get();
 	test_report_one_done();
 
 	/*
@@ -619,7 +619,7 @@ static void do_concurrent_test(void)
 				t->data[j].time);
 		}
 
-		pr_info("All test took worker%d=%lu cycles\n",
+		pr_info("All test took worker%d=%lld nsecs\n",
 			i, t->stop - t->start);
 	}
 


