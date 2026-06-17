Return-Path: <linux-wireless+bounces-37864-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TqgEFbqFMmrF1QUAu9opvQ
	(envelope-from <linux-wireless+bounces-37864-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 13:32:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE406991A0
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 13:32:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=kaMhlXNx;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37864-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37864-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4CE2327A529
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 11:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D134E3C4B93;
	Wed, 17 Jun 2026 11:23:18 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F303ECBC8;
	Wed, 17 Jun 2026 11:23:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781695398; cv=none; b=rvmIjpXdbJu977l8MSG9tXEx0qhBkjnswMHLFiyexRMuyJ4oe71NGsDY0B0ZF6J02ZYG9Z1zaSZ0XA6BHQGWfNu6P2zOuyK5yQeHYHQcV0+9FqjDM6oTqoztY2mRXvidhwqoFj03vcaBvKcawYcr3BzREguxIAvqjj4fE1i2/5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781695398; c=relaxed/simple;
	bh=vgnqatpwfjhAFlgAOEx8E7pxYPSM+zpaFuWJeLRCv7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iICeMx4BfUQWnnhSynbKO1rlGmhhuV+oRVT6vhGEoSq9XfEO2f8r9PeqZD/BtRX7pKGho6p65X9e3bOs7OxlYzWfV4wvORFiPB6KebuLPB6j1tQNVVVKaSdho7VSSUsEf6rDXhOT8q3O4UGqRzVCtWxCU3Qq7T8BLQWla1KhLTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kaMhlXNx; arc=none smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781695389; x=1813231389;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vgnqatpwfjhAFlgAOEx8E7pxYPSM+zpaFuWJeLRCv7Y=;
  b=kaMhlXNx4c15MP8HDmixQtOnxZFbcTHPRO7X1uWznPHJ25LyQdSoq3gb
   5eL+uEYdLHb6UgUbWcZFNX8OHlkO37lJ4DW/gGGDoB5nIW6ImbRYSHxEv
   Nj4jAhX8hF+UwL20oGlZtzicegTi1eQtiTuIkyt4AAZ9abbXcv7+XuFGa
   kvbXkwQjGQ9Zl6YOW9hsG2h59h2/Mxkfmrhrzi3YuHuUHypjLSIcCt8cr
   4KQIFElLqsrq3caWmybvTKOXBx/Z3VUZ6EPMrII+o/RcGj7JH9jSd01Vz
   +Qgu2Q8qpyyrruABhdaWg8UobgfVvyB08Wyy+OX5IBsQbp98BAmagCPbN
   g==;
X-CSE-ConnectionGUID: RVp3ERH4QvOp8FznfCZAfg==
X-CSE-MsgGUID: vOjvdZDfQOiWNYzEhsLjvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="100048621"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="100048621"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 04:22:58 -0700
X-CSE-ConnectionGUID: gpaZvOPQTPSWD5EHMd19yQ==
X-CSE-MsgGUID: EujAmUH0Rh+3HVmetXcW5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="271756534"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 17 Jun 2026 04:22:56 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 7A42A98; Wed, 17 Jun 2026 13:22:55 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Johannes Berg <johannes.berg@intel.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] overflow: Allow to sum a few arguments at once
Date: Wed, 17 Jun 2026 13:12:36 +0200
Message-ID: <20260617112250.2791461-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260617112250.2791461-1-andriy.shevchenko@linux.intel.com>
References: <20260617112250.2791461-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37864-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes.berg@intel.com,m:linux-hardening@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:kees@kernel.org,m:gustavoars@kernel.org,m:johannes@sipsolutions.net,m:andriy.shevchenko@linux.intel.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[andriy.shevchenko@linux.intel.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,linux.intel.com:mid,linux.intel.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4CE406991A0

Convert size_add() to take variadic argument, so we can simplify users
with using a macro only once.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/overflow.h | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index a8cb6319b4fb..a8b0325e73f3 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -2,9 +2,10 @@
 #ifndef __LINUX_OVERFLOW_H
 #define __LINUX_OVERFLOW_H
 
+#include <linux/args.h>
 #include <linux/compiler.h>
-#include <linux/limits.h>
 #include <linux/const.h>
+#include <linux/limits.h>
 
 /*
  * We need to compute the minimum and maximum values representable in a given
@@ -337,16 +338,7 @@ static __always_inline size_t __must_check size_mul(size_t factor1, size_t facto
 	return bytes;
 }
 
-/**
- * size_add() - Calculate size_t addition with saturation at SIZE_MAX
- * @addend1: first addend
- * @addend2: second addend
- *
- * Returns: calculate @addend1 + @addend2, both promoted to size_t,
- * with any overflow causing the return value to be SIZE_MAX. The
- * lvalue must be size_t to avoid implicit type conversion.
- */
-static __always_inline size_t __must_check size_add(size_t addend1, size_t addend2)
+static __always_inline size_t __must_check __size_add(size_t addend1, size_t addend2)
 {
 	size_t bytes;
 
@@ -356,6 +348,29 @@ static __always_inline size_t __must_check size_add(size_t addend1, size_t adden
 	return bytes;
 }
 
+#define __size_add0(addend1, ...)						\
+	__size_add(addend1, 0)
+#define __size_add1(addend1, addend2, ...)					\
+	__size_add(addend1,  addend2)
+#define __size_add2(addend1, addend2, addend3, ...)				\
+	__size_add(__size_add(addend1,  addend2), addend3)
+#define __size_add3(addend1, addend2, addend3, addend4, ...)			\
+	__size_add(__size_add2(addend1,  addend2, addend3), addend4)
+#define __size_add4(addend1, addend2, addend3, addend4, addend5, ...)		\
+	__size_add(__size_add3(addend1,  addend2, addend3, addend4), addend5)
+
+/**
+ * size_add() - Calculate size_t addition with saturation at SIZE_MAX
+ * @addend1: first addend
+ * @...: more to add (optional)
+ *
+ * Returns: calculate @addend1 + @addend2, both promoted to size_t,
+ * with any overflow causing the return value to be SIZE_MAX. The
+ * lvalue must be size_t to avoid implicit type conversion.
+ */
+#define size_add(addend1, ...)	\
+	CONCATENATE(__size_add, COUNT_ARGS(__VA_ARGS__))(addend1, __VA_ARGS__)
+
 /**
  * size_sub() - Calculate size_t subtraction with saturation at SIZE_MAX
  * @minuend: value to subtract from
-- 
2.50.1


