Return-Path: <linux-wireless+bounces-34590-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCztB77s2GlLjwgAu9opvQ
	(envelope-from <linux-wireless+bounces-34590-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 14:27:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F783D703F
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 14:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 415B93087F5B
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 12:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EB73D3CFB;
	Fri, 10 Apr 2026 12:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdLSbwwL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810AB3BADB4;
	Fri, 10 Apr 2026 12:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775823575; cv=none; b=ofgh+PvuO0lxABxnJ5gkDdfHST6+naXUl7euh22VIARdnNwmpQwHdJnlCVI2dRd9IJVf8inMUMRrqS5VXeyuYBCryzTOYvWClXAptY/V0/Up8vKsN8IoyJWXHEw9OfEIjvGJ0902L8qRYtyE39f1qcwsjO/Pwcgi6R5GZ58w0as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775823575; c=relaxed/simple;
	bh=GB9a/XQKSHIwV9FYvefMOZoOdepkVaVbWcUyHQeAJMw=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=raGfblO+FxRYKmmu0rrIwE83eUii33gUA+Qd3o14/8XlIYmb2m5jpdm83UN+OYtHvMn1M29xxLaOPLBR39zIlm+FxFsVZV0ITd1zyVcI1sckJCHKNB1fi264dD3zs1i/5t/iw+XAITqJa7Q9uRj+zeWkKqvx/FqB16DbyWIvBpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdLSbwwL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D535C19421;
	Fri, 10 Apr 2026 12:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775823575;
	bh=GB9a/XQKSHIwV9FYvefMOZoOdepkVaVbWcUyHQeAJMw=;
	h=Date:From:To:Cc:Subject:References:From;
	b=kdLSbwwLxIuQWDxnaQ43x3JS9cXZHSMpULEhhU8ID9ECY5jS+n7m20CMk0YroM4U5
	 D4FjOptptOJeolxHIofJ3rTeQ/ALPjLpvnJ7Qi7NqzIwHDqURUXi9DJGGx8dZS+lLk
	 JCAzGIYvaKballV64My3qHcmSE8ptIN1eu7xnjzlOO9PgVdkDRLJV0RvV58tiiKr4i
	 bv+wJwmXD1eqFR2U5N9wMLLyoNfqxlEArSV4W94QZ6qgCudbzRKlUn/CHtSVarPoCX
	 xb06JWRkDGSiFGx6qUkcv+KUlCb5xHLy85m3KWHYpSlfnAmYw64l8Tsoi4lMULg/pB
	 WwpH4H0qB6HQQ==
Date: Fri, 10 Apr 2026 14:19:31 +0200
Message-ID: <20260410120318.454577282@kernel.org>
User-Agent: quilt/0.68
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
 linux-crypto@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>,
 x86@kernel.org,
 Lu Baolu <baolu.lu@linux.intel.com>,
 iommu@lists.linux.dev,
 Michael Grzeschik <m.grzeschik@pengutronix.de>,
 netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org,
 Vlastimil Babka <vbabka@kernel.org>,
 linux-mm@kvack.org,
 David Woodhouse <dwmw2@infradead.org>,
 Bernie Thompson <bernie@plugable.com>,
 linux-fbdev@vger.kernel.org,
 "Theodore Tso" <tytso@mit.edu>,
 linux-ext4@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>,
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
Subject: [patch 13/38] crypto: tcrypt: Replace get_cycles() with ktime_get()
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gondor.apana.org.au,vger.kernel.org,arndb.de,kernel.org,linux.intel.com,lists.linux.dev,pengutronix.de,kvack.org,infradead.org,plugable.com,mit.edu,linux-foundation.org,gmail.com,google.com,googlegroups.com,alumni.ethz.ch,zx2c4.com,linaro.org,armlinux.org.uk,lists.infradead.org,arm.com,linux-m68k.org,lists.linux-m68k.org,southpole.se,gmx.de,ellerman.id.au,lists.ozlabs.org,linux.ibm.com,davemloft.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-34590-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
X-Rspamd-Queue-Id: C5F783D703F
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
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-crypto@vger.kernel.org
---
 crypto/tcrypt.c |   84 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

--- a/crypto/tcrypt.c
+++ b/crypto/tcrypt.c
@@ -202,7 +202,7 @@ static int test_mb_aead_jiffies(struct t
 static int test_mb_aead_cycles(struct test_mb_aead_data *data, int enc,
 			       int blen, u32 num_mb)
 {
-	unsigned long cycles = 0;
+	unsigned long nsecs = 0;
 	int ret = 0;
 	int i;
 	int *rc;
@@ -220,20 +220,20 @@ static int test_mb_aead_cycles(struct te
 
 	/* The real thing. */
 	for (i = 0; i < 8; i++) {
-		cycles_t start, end;
+		ktime_t start, end;
 
-		start = get_cycles();
+		start = ktime_get();
 		ret = do_mult_aead_op(data, enc, num_mb, rc);
-		end = get_cycles();
+		end = ktime_get();
 
 		if (ret)
 			goto out;
 
-		cycles += end - start;
+		nsecs += (unsigned long)(end - start);
 	}
 
-	pr_cont("1 operation in %lu cycles (%d bytes)\n",
-		(cycles + 4) / (8 * num_mb), blen);
+	pr_cont("1 operation in %lu nsecs (%d bytes)\n",
+		nsecs / (8 * num_mb), blen);
 
 out:
 	kfree(rc);
@@ -475,7 +475,7 @@ static int test_aead_jiffies(struct aead
 
 static int test_aead_cycles(struct aead_request *req, int enc, int blen)
 {
-	unsigned long cycles = 0;
+	unsigned long nsecs = 0;
 	int ret = 0;
 	int i;
 
@@ -492,25 +492,24 @@ static int test_aead_cycles(struct aead_
 
 	/* The real thing. */
 	for (i = 0; i < 8; i++) {
-		cycles_t start, end;
+		ktime_t start, end;
 
-		start = get_cycles();
+		start = ktime_get();
 		if (enc)
 			ret = do_one_aead_op(req, crypto_aead_encrypt(req));
 		else
 			ret = do_one_aead_op(req, crypto_aead_decrypt(req));
-		end = get_cycles();
+		end = ktime_get();
 
 		if (ret)
 			goto out;
 
-		cycles += end - start;
+		nsecs += (unsigned long)(end - start);
 	}
 
 out:
 	if (ret == 0)
-		pr_cont("1 operation in %lu cycles (%d bytes)\n",
-			(cycles + 4) / 8, blen);
+		pr_cont("1 operation in %lu nsecs (%d bytes)\n", nsecs / 8, blen);
 
 	return ret;
 }
@@ -771,7 +770,7 @@ static int test_ahash_jiffies(struct aha
 static int test_ahash_cycles_digest(struct ahash_request *req, int blen,
 				    char *out)
 {
-	unsigned long cycles = 0;
+	unsigned long nsecs = 0;
 	int ret, i;
 
 	/* Warm-up run. */
@@ -783,25 +782,25 @@ static int test_ahash_cycles_digest(stru
 
 	/* The real thing. */
 	for (i = 0; i < 8; i++) {
-		cycles_t start, end;
+		ktime_t start, end;
 
-		start = get_cycles();
+		start = ktime_get();
 
 		ret = do_one_ahash_op(req, crypto_ahash_digest(req));
 		if (ret)
 			goto out;
 
-		end = get_cycles();
+		end = ktime_get();
 
-		cycles += end - start;
+		nsecs += (unsigned long)(end - start);
 	}
 
 out:
 	if (ret)
 		return ret;
 
-	pr_cont("%6lu cycles/operation, %4lu cycles/byte\n",
-		cycles / 8, cycles / (8 * blen));
+	pr_cont("%6lu nsecs/operation, %4lu nsecs/byte\n",
+		nsecs / 8, nsecs / (8 * blen));
 
 	return 0;
 }
@@ -809,7 +808,7 @@ static int test_ahash_cycles_digest(stru
 static int test_ahash_cycles(struct ahash_request *req, int blen,
 			     int plen, char *out)
 {
-	unsigned long cycles = 0;
+	unsigned long nsecs = 0;
 	int i, pcount, ret;
 
 	if (plen == blen)
@@ -832,9 +831,9 @@ static int test_ahash_cycles(struct ahas
 
 	/* The real thing. */
 	for (i = 0; i < 8; i++) {
-		cycles_t start, end;
+		ktime_t start, end;
 
-		start = get_cycles();
+		start = ktime_get();
 
 		ret = do_one_ahash_op(req, crypto_ahash_init(req));
 		if (ret)
@@ -848,17 +847,17 @@ static int test_ahash_cycles(struct ahas
 		if (ret)
 			goto out;
 
-		end = get_cycles();
+		end = ktime_get();
 
-		cycles += end - start;
+		nsecs += (unsigned long)(end - start);
 	}
 
 out:
 	if (ret)
 		return ret;
 
-	pr_cont("%6lu cycles/operation, %4lu cycles/byte\n",
-		cycles / 8, cycles / (8 * blen));
+	pr_cont("%6lu nsecs/operation, %4lu nsecs/byte\n",
+		nsecs / 8, nsecs / (8 * blen));
 
 	return 0;
 }
@@ -1019,7 +1018,7 @@ static int test_mb_acipher_jiffies(struc
 static int test_mb_acipher_cycles(struct test_mb_skcipher_data *data, int enc,
 			       int blen, u32 num_mb)
 {
-	unsigned long cycles = 0;
+	unsigned long nsecs = 0;
 	int ret = 0;
 	int i;
 	int *rc;
@@ -1037,20 +1036,20 @@ static int test_mb_acipher_cycles(struct
 
 	/* The real thing. */
 	for (i = 0; i < 8; i++) {
-		cycles_t start, end;
+		ktime_t start, end;
 
-		start = get_cycles();
+		start = ktime_get();
 		ret = do_mult_acipher_op(data, enc, num_mb, rc);
-		end = get_cycles();
+		end = ktime_get();
 
 		if (ret)
 			goto out;
 
-		cycles += end - start;
+		nsecs += (unsigned long)(end - start);
 	}
 
-	pr_cont("1 operation in %lu cycles (%d bytes)\n",
-		(cycles + 4) / (8 * num_mb), blen);
+	pr_cont("1 operation in %lu nsecs (%d bytes)\n",
+		nsecs / (8 * num_mb), blen);
 
 out:
 	kfree(rc);
@@ -1246,7 +1245,7 @@ static int test_acipher_jiffies(struct s
 static int test_acipher_cycles(struct skcipher_request *req, int enc,
 			       int blen)
 {
-	unsigned long cycles = 0;
+	unsigned long nsecs = 0;
 	int ret = 0;
 	int i;
 
@@ -1265,27 +1264,28 @@ static int test_acipher_cycles(struct sk
 
 	/* The real thing. */
 	for (i = 0; i < 8; i++) {
-		cycles_t start, end;
+		ktime_t start, end;
+
+		start = ktime_get();
 
-		start = get_cycles();
 		if (enc)
 			ret = do_one_acipher_op(req,
 						crypto_skcipher_encrypt(req));
 		else
 			ret = do_one_acipher_op(req,
 						crypto_skcipher_decrypt(req));
-		end = get_cycles();
+		end = ktime_get();
 
 		if (ret)
 			goto out;
 
-		cycles += end - start;
+		nsecs += (unsigned long)(end - start);
 	}
 
 out:
 	if (ret == 0)
-		pr_cont("1 operation in %lu cycles (%d bytes)\n",
-			(cycles + 4) / 8, blen);
+		pr_cont("1 operation in %lu nsecs (%d bytes)\n",
+			nsecs / 8, blen);
 
 	return ret;
 }


