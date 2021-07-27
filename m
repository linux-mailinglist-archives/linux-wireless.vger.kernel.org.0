Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7309F3D7FFE
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jul 2021 23:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbhG0U7j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Jul 2021 16:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbhG0U7Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Jul 2021 16:59:25 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD0FC06179F
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jul 2021 13:59:12 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id t21so17526787plr.13
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jul 2021 13:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=siRAEsrzVlt9ucK6wXbx7gprBvPU1KNnXc5tokHkqwA=;
        b=jOYGss8jVrPhLdtzPZO0ka53DS3EL2t6yN9FdJhWvSggA+/r3A2IbCss40cFO7n/2Q
         spLM/Hggx35P3erp7stVOVXKhQclCsYzBx5ggNWy5bFqJCt4e2RjkcmLYwjoeCG08QqR
         9o3L6zH7N6jgNQlPlhWWsdJ03/mYomS7UyKoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=siRAEsrzVlt9ucK6wXbx7gprBvPU1KNnXc5tokHkqwA=;
        b=JombF7egl1lqeqmTx54NYXo8MJaI33T19Nv76zh38RNTAg7PAraq5CiHXzLkMKXjMR
         +0hXXNBSV2gwXU8Eh19xc06EK00YjzzbNOM72oHwcRZeM2z2g0Vb6AanEs51CzZXyhdp
         kqCsRhTjlYVgsBLhq14LHReHwydZWrxTgWag4CAFB+NfJHDqFE6y8v1srByGNRnSp6f9
         SM4Z2afujzMkPMWetzp7UnlHIW5oCQ7rzgajPQW6Dvsq0MRp1TqzogFSkuYhb5GR4z5c
         1gwmTqI+GCsdtmHqIBAOC6IIu7xZpR1pTamxu6GcZ2aAFBeTGFJHK7g9ESczvtW/S2iF
         kz8g==
X-Gm-Message-State: AOAM533AAlSCJqZ+DKSrT3RdIiQBTfWwrwYzrB9nLTQ3rSCF4sNWXK4S
        XgjuxVH+9M22kpCP+0dsp1SxFA==
X-Google-Smtp-Source: ABdhPJxcIDmVZ5nPEAkDsJLKerbXDHgogxNbJCx3ZtX0xM3wU3njxXgPWzNdCs2a3BpXrJ8CbQKtPw==
X-Received: by 2002:a17:902:b48b:b029:12c:59b:dc44 with SMTP id y11-20020a170902b48bb029012c059bdc44mr13599469plr.47.1627419552529;
        Tue, 27 Jul 2021 13:59:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d29sm4694011pfq.193.2021.07.27.13.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 13:59:12 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH 30/64] fortify: Move remaining fortify helpers into fortify-string.h
Date:   Tue, 27 Jul 2021 13:58:21 -0700
Message-Id: <20210727205855.411487-31-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727205855.411487-1-keescook@chromium.org>
References: <20210727205855.411487-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3145; h=from:subject; bh=12T5m5DUCmUyeamBVCK0X9eqcX/3MZ+nSw3lqvb6DZM=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhAHOGsI5uu4BBDAJak9w31PhY/56QIHQY9qYASnaR 5iXUW6WJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYQBzhgAKCRCJcvTf3G3AJnzWD/ 9zeRHN60Hh1cQdFdjudukv1XfFs+XvKe8NvV9QEHftgDf2iwskre+nLxfXPqwh1hMt9zDWXWY5oRPL 5VdwOf+Yp9IHA0ZzvWzN9d58Qs8EypT2ZK/kY3cBfJ3yHut4U6ddUMH/lIca2buFlaScq15XFNg1Im rQzpN5e0CppW/K6Uh74IxLf9omIWV4GRZ6idGpyfpYdUfI7PbfKfCohrObRQ1ABLMmT/sPmKk2zaCX Cmi2zrNghZVgHMU+Pg0pdsixXI9Do5CVE2nIJ1WB0MlsV/DWz5dRZUn+TU0+YvLwlJdIMOPa2ai6UY SUSovgWePofTVKoTMd6kPo4TNS3nEp5IECkkfec1TThvwuBJW4pgk6u/B5Rit/+OtAqwgemzwWJr5n RkUHACvdcXL6tFqPzDreUzCsCPDvyKJtmR+KPFY2YXCdZH/M0+jWsWVdpvwGHwsmlrw05Cdc2k0oD5 wJcl6Bbk1cUNmBEXi4KHLsRXhnJ1lIP/ctdobCyCAvEq6TKILCsxY+qy0FrM64KtV992CwhdYlkFbq t4KAGEnA4K8jVSm8FgMRrRNGTsLfVRxhyemcFixXRjlPWoj+SO5oJ/TB7kkRUhfleRU7MprwtYNIlk DAYfW1/LZPaRs0Qt9/nWQtdTDdNHUPM7txeSEdhZJMmGBl/8AspkFYgPJZDQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When commit a28a6e860c6c ("string.h: move fortified functions definitions
in a dedicated header.") moved the fortify-specific code, some helpers
were left behind. Moves the remaining fortify-specific helpers into
fortify-string.h so they're together where they're used. This requires
that any FORTIFY helper function prototypes be conditionally built to
avoid "no prototype" warnings. Additionally removes unused helpers.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/fortify-string.h | 7 +++++++
 include/linux/string.h         | 9 ---------
 lib/string_helpers.c           | 2 ++
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index c1be37437e77..7e67d02764db 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -2,6 +2,13 @@
 #ifndef _LINUX_FORTIFY_STRING_H_
 #define _LINUX_FORTIFY_STRING_H_
 
+#define __FORTIFY_INLINE extern __always_inline __attribute__((gnu_inline))
+#define __RENAME(x) __asm__(#x)
+
+void fortify_panic(const char *name) __noreturn __cold;
+void __read_overflow(void) __compiletime_error("detected read beyond size of object (1st parameter)");
+void __read_overflow2(void) __compiletime_error("detected read beyond size of object (2nd parameter)");
+void __write_overflow(void) __compiletime_error("detected write beyond size of object (1st parameter)");
 
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 extern void *__underlying_memchr(const void *p, int c, __kernel_size_t size) __RENAME(memchr);
diff --git a/include/linux/string.h b/include/linux/string.h
index b48d2d28e0b1..9473f81b9db2 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -249,15 +249,6 @@ static inline const char *kbasename(const char *path)
 	return tail ? tail + 1 : path;
 }
 
-#define __FORTIFY_INLINE extern __always_inline __attribute__((gnu_inline))
-#define __RENAME(x) __asm__(#x)
-
-void fortify_panic(const char *name) __noreturn __cold;
-void __read_overflow(void) __compiletime_error("detected read beyond size of object passed as 1st parameter");
-void __read_overflow2(void) __compiletime_error("detected read beyond size of object passed as 2nd parameter");
-void __read_overflow3(void) __compiletime_error("detected read beyond size of object passed as 3rd parameter");
-void __write_overflow(void) __compiletime_error("detected write beyond size of object passed as 1st parameter");
-
 #if !defined(__NO_FORTIFY) && defined(__OPTIMIZE__) && defined(CONFIG_FORTIFY_SOURCE)
 #include <linux/fortify-string.h>
 #endif
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index bde13612c25d..faa9d8e4e2c5 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -883,9 +883,11 @@ char *strreplace(char *s, char old, char new)
 }
 EXPORT_SYMBOL(strreplace);
 
+#ifdef CONFIG_FORTIFY_SOURCE
 void fortify_panic(const char *name)
 {
 	pr_emerg("detected buffer overflow in %s\n", name);
 	BUG();
 }
 EXPORT_SYMBOL(fortify_panic);
+#endif /* CONFIG_FORTIFY_SOURCE */
-- 
2.30.2

