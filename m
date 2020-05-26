Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398DE1E42B6
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2020 14:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbgE0MxG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 May 2020 08:53:06 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41376 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729996AbgE0MxG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 May 2020 08:53:06 -0400
Received: by mail-pl1-f194.google.com with SMTP id a13so10110813pls.8
        for <linux-wireless@vger.kernel.org>; Wed, 27 May 2020 05:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:resent-from:resent-date:resent-message-id
         :resent-to:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UXRYeaDc02XdMrQZXPWL4bjUJlIpwN0dvTWzE8/MMVk=;
        b=qFsP3D8KYLpRVjfhq/SwtGBvOBeTTWpoGbue3gA72kokywiUQybPBleMd0U1ziTpuG
         89g94/CEQPorKTrl18FNXCZ3azwPVBRXGkg3iWyo9XHcmkuKj2I4OizGrc1RErU4jepp
         6NA1z9QCz5k1q6GfLm7+K12swsfWVOLu4TwaRLhVKpJbZBkFK8OIrZnBYYd06AXFjpk9
         RF8jJUwhEgXYWKqEVqT2ZCqMHUTExjVywkb0zak+Htjdys+17QJrdFrf9/KA3f/GG86U
         EKWPefWRNv2RUu6hncIWT/p+HEfEgSLcoptoJ6WBu2SkBtjLBXEW/FmSLH29T1qlVerq
         68Ig==
X-Gm-Message-State: AOAM532SJhm8aE0MuYzU+DfyHRez8U/Z/YQ4uKX1x6h6EH9k3cV3hA/l
        Sta9f72FPVdSnFEY8GFl9AxWXgmzM3H0hA==
X-Google-Smtp-Source: ABdhPJwMCW7fFpZ/UvjWvAVI3jCGhdM8d8BhJ0CII0fE+lGgZP5tnoP6hQRj5nH/EWvNB+Mv4yLugQ==
X-Received: by 2002:a17:90a:3326:: with SMTP id m35mr5101494pjb.10.1590583983544;
        Wed, 27 May 2020 05:53:03 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id b23sm2041528pgs.33.2020.05.27.05.53.03
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 05:53:03 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 3A50140605; Wed, 27 May 2020 12:53:02 +0000 (UTC)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id x13sm15122851pfn.200.2020.05.26.07.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 07:58:22 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 6982C41D12; Tue, 26 May 2020 14:58:18 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     jeyu@kernel.org, davem@davemloft.net, kuba@kernel.org
Cc:     michael.chan@broadcom.com, dchickles@marvell.com,
        sburla@marvell.com, fmanlunas@marvell.com, aelior@marvell.com,
        GR-everest-linux-l2@marvell.com, kvalo@codeaurora.org,
        johannes@sipsolutions.net, akpm@linux-foundation.org,
        arnd@arndb.de, rostedt@goodmis.org, mingo@redhat.com,
        aquini@redhat.com, cai@lca.pw, dyoung@redhat.com, bhe@redhat.com,
        peterz@infradead.org, tglx@linutronix.de, gpiccoli@canonical.com,
        pmladek@suse.com, tiwai@suse.de, schlad@suse.de,
        andriy.shevchenko@linux.intel.com, derosier@gmail.com,
        keescook@chromium.org, daniel.vetter@ffwll.ch, will@kernel.org,
        mchehab+samsung@kernel.org, vkoul@kernel.org,
        mchehab+huawei@kernel.org, robh@kernel.org, mhiramat@kernel.org,
        sfr@canb.auug.org.au, linux@dominikbrodowski.net,
        glider@google.com, paulmck@kernel.org, elver@google.com,
        bauerman@linux.ibm.com, yamada.masahiro@socionext.com,
        samitolvanen@google.com, yzaikin@google.com, dvyukov@google.com,
        rdunlap@infradead.org, corbet@lwn.net, dianders@chromium.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v3 4/8] panic: make taint data type clearer
Date:   Tue, 26 May 2020 14:58:11 +0000
Message-Id: <20200526145815.6415-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200526145815.6415-1-mcgrof@kernel.org>
References: <20200526145815.6415-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TUID: ofW0vIudzYdt
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Let us be clearer about the the data type for the taint flag.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 include/asm-generic/bug.h | 4 ++--
 include/linux/kernel.h    | 4 ++--
 kernel/panic.c            | 8 ++++----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index c94e33ae3e7b..87dbe57301f4 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -80,7 +80,7 @@ struct bug_entry {
  */
 #ifndef __WARN_FLAGS
 extern __printf(4, 5)
-void warn_slowpath_fmt(const char *file, const int line, unsigned taint,
+void warn_slowpath_fmt(const char *file, const int line, unsigned int taint,
 		       const char *fmt, ...);
 #define __WARN()		__WARN_printf(TAINT_WARN, NULL)
 #define __WARN_printf(taint, arg...) do {				\
@@ -110,7 +110,7 @@ extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 struct warn_args;
 struct pt_regs;
 
-void __warn(const char *file, int line, void *caller, unsigned taint,
+void __warn(const char *file, int line, void *caller, unsigned int taint,
 	    struct pt_regs *regs, struct warn_args *args);
 
 #ifndef WARN_ON
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index a1974907c320..d154844eb9cd 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -563,8 +563,8 @@ enum lockdep_ok {
 	LOCKDEP_STILL_OK,
 	LOCKDEP_NOW_UNRELIABLE
 };
-extern void add_taint(unsigned flag, enum lockdep_ok);
-extern int test_taint(unsigned flag);
+extern void add_taint(unsigned int flag, enum lockdep_ok);
+extern int test_taint(unsigned int flag);
 extern unsigned long get_taint(void);
 extern int root_mountflags;
 
diff --git a/kernel/panic.c b/kernel/panic.c
index cb1c5619e983..3cfe84318ecf 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -421,7 +421,7 @@ const char *print_tainted(void)
 	return buf;
 }
 
-int test_taint(unsigned flag)
+int test_taint(unsigned int flag)
 {
 	return test_bit(flag, &tainted_mask);
 }
@@ -440,7 +440,7 @@ unsigned long get_taint(void)
  * If something bad has gone wrong, you'll want @lockdebug_ok = false, but for
  * some notewortht-but-not-corrupting cases, it can be set to true.
  */
-void add_taint(unsigned flag, enum lockdep_ok lockdep_ok)
+void add_taint(unsigned int flag, enum lockdep_ok lockdep_ok)
 {
 	if (lockdep_ok == LOCKDEP_NOW_UNRELIABLE && __debug_locks_off()) {
 		pr_warn("Disabling lock debugging due to kernel taint\n");
@@ -579,7 +579,7 @@ struct warn_args {
 	va_list args;
 };
 
-void __warn(const char *file, int line, void *caller, unsigned taint,
+void __warn(const char *file, int line, void *caller, unsigned int taint,
 	    struct pt_regs *regs, struct warn_args *args)
 {
 	disable_trace_on_warning();
@@ -622,7 +622,7 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 }
 
 #ifndef __WARN_FLAGS
-void warn_slowpath_fmt(const char *file, int line, unsigned taint,
+void warn_slowpath_fmt(const char *file, int line, unsigned int taint,
 		       const char *fmt, ...)
 {
 	struct warn_args args;
-- 
2.26.2

