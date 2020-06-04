Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE73F1ED97C
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2020 01:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgFCXd7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Jun 2020 19:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgFCXcQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Jun 2020 19:32:16 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7BEC08C5C7
        for <linux-wireless@vger.kernel.org>; Wed,  3 Jun 2020 16:32:14 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id q24so267545pjd.1
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jun 2020 16:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hMUFWqcrC1VZxvWDwrZSg4KS9BvtvLd2CEEYtAT+tik=;
        b=NPDoMZL+zfsatoKLllUEr8wu4PDByFvpOx0tUIG0zh+F9kNU3lZAIs4/72VWZHO62B
         wJNDmXTEzDkwVDFm5ZmRQQz2JzgS9VFCuCWR/c1ERdo1M9u6NFUkJjq4MdvlAxFdWiuA
         qZfnse2pv1GkiYqRcfQiacr45rwEs75PqerkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hMUFWqcrC1VZxvWDwrZSg4KS9BvtvLd2CEEYtAT+tik=;
        b=DGyJ7CornpHts+TnuQLpILjxKVfrPMH2riJyx1cvPj5gT7mWAFSFS4y8sM7eSc7k54
         kgKRfFJ+QRWNazS8U9ds53i+Hioiqqc4jehmLjO0PZ+Ed+pIUmSXu+4LYIUtag+8S59Z
         9SI6qRbPxBkXc0riQMQaxhpzuKZ611pTks0xofZZ5uzCK3DLYA1aSeV9hXpJMlxVVWZ9
         BhWLIRctAfiB7m1KCBhmYz6QXR0/sV2lpdL0Bh/+/fpbYVjZj7DvtQBSt8KAOHz9G1r+
         yDmxHyYKKeEDvicXg2xOo/dDAkwPHsyd1svz1XrxwHWp4ve16gXTR1IJ2FsxKh3Kq1bb
         fJ2g==
X-Gm-Message-State: AOAM532rLFgzbySHvn8UdSHAgmQE9UjVS5iVywPt8vhSCAQpvWDOp8do
        gkknxM7KwuxwufjzMcyXkku7AQ==
X-Google-Smtp-Source: ABdhPJwEforJlQ6Hw2sLXD7jNMrxzqXBv5BlsWVfup5BJSe8mp612gIHwefIBt6eEGH3vm6zOlawSw==
X-Received: by 2002:a17:90b:3448:: with SMTP id lj8mr2505301pjb.163.1591227134470;
        Wed, 03 Jun 2020 16:32:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b1sm3836777pjc.33.2020.06.03.16.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 16:32:12 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>, x86@kernel.org,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        b43-dev@lists.infradead.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mm@kvack.org, clang-built-linux@googlegroups.com
Subject: [PATCH 01/10] x86/mm/numa: Remove uninitialized_var() usage
Date:   Wed,  3 Jun 2020 16:31:54 -0700
Message-Id: <20200603233203.1695403-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200603233203.1695403-1-keescook@chromium.org>
References: <20200603233203.1695403-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Using uninitialized_var() is dangerous as it papers over real bugs[1]
(or can in the future), and suppresses unrelated compiler warnings (e.g.
"unused variable"). If the compiler thinks it is uninitialized, either
simply initialize the variable or make compiler changes. As a precursor
to removing[2] this[3] macro[4], refactor code to avoid its need.

The original reason for its use here was to work around the #ifdef
being the only place the variable was used. This is better expressed
using IS_ENABLED() and a new code block where the variable can be used
unconditionally.

[1] https://lore.kernel.org/lkml/20200603174714.192027-1-glider@google.com/
[2] https://lore.kernel.org/lkml/CA+55aFw+Vbj0i=1TGqCR5vQkCzWJ0QxK6CernOU6eedsudAixw@mail.gmail.com/
[3] https://lore.kernel.org/lkml/CA+55aFwgbgqhbp1fkxvRKEpzyR5J8n1vKT1VZdz9knmPuXhOeg@mail.gmail.com/
[4] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/mm/numa.c                | 18 +++++++++---------
 include/linux/page-flags-layout.h |  2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 59ba008504dc..38eeb15f3b07 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -541,7 +541,6 @@ static void __init numa_clear_kernel_node_hotplug(void)
 
 static int __init numa_register_memblks(struct numa_meminfo *mi)
 {
-	unsigned long uninitialized_var(pfn_align);
 	int i, nid;
 
 	/* Account for nodes with cpus and no memory */
@@ -569,15 +568,16 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
 	 * If sections array is gonna be used for pfn -> nid mapping, check
 	 * whether its granularity is fine enough.
 	 */
-#ifdef NODE_NOT_IN_PAGE_FLAGS
-	pfn_align = node_map_pfn_alignment();
-	if (pfn_align && pfn_align < PAGES_PER_SECTION) {
-		printk(KERN_WARNING "Node alignment %LuMB < min %LuMB, rejecting NUMA config\n",
-		       PFN_PHYS(pfn_align) >> 20,
-		       PFN_PHYS(PAGES_PER_SECTION) >> 20);
-		return -EINVAL;
+	if (IS_ENABLED(NODE_NOT_IN_PAGE_FLAGS)) {
+		unsigned long pfn_align = node_map_pfn_alignment();
+
+		if (pfn_align && pfn_align < PAGES_PER_SECTION) {
+			pr_warn("Node alignment %LuMB < min %LuMB, rejecting NUMA config\n",
+				PFN_PHYS(pfn_align) >> 20,
+				PFN_PHYS(PAGES_PER_SECTION) >> 20);
+			return -EINVAL;
+		}
 	}
-#endif
 	if (!numa_meminfo_cover_memory(mi))
 		return -EINVAL;
 
diff --git a/include/linux/page-flags-layout.h b/include/linux/page-flags-layout.h
index 71283739ffd2..1a4cdec2bd29 100644
--- a/include/linux/page-flags-layout.h
+++ b/include/linux/page-flags-layout.h
@@ -100,7 +100,7 @@
  * there.  This includes the case where there is no node, so it is implicit.
  */
 #if !(NODES_WIDTH > 0 || NODES_SHIFT == 0)
-#define NODE_NOT_IN_PAGE_FLAGS
+#define NODE_NOT_IN_PAGE_FLAGS 1
 #endif
 
 #if defined(CONFIG_NUMA_BALANCING) && LAST_CPUPID_WIDTH == 0
-- 
2.25.1

