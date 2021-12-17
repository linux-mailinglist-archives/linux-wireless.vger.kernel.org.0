Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 720B2478E26
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Dec 2021 15:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237548AbhLQOls (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Dec 2021 09:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237454AbhLQOlf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Dec 2021 09:41:35 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFA3C06173E
        for <linux-wireless@vger.kernel.org>; Fri, 17 Dec 2021 06:41:34 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id y12so8528217eda.12
        for <linux-wireless@vger.kernel.org>; Fri, 17 Dec 2021 06:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YtXzvh0C6WiWca/wi/qfYHW/5QpcMjxHI9YNhLAWuJ0=;
        b=Z5ZRrmxwSJv9i19fPSkPWScIrN4tJBVTD5Er/ou2k9ZfJbuqbPWdF0gB+PYhYh83cs
         5TCqk+2oZdFe+S3/0evA0R3hOmhwoDopVdaZBhTEMTAJpL2jXWW3IMZPZAxxTFY6S7u/
         cPMwtote0l2lYQVFo5IRKzVDdo08mtzkYJdkQEIO+kF9froty6srsvbSDovwuGCC4ibm
         iiF6JInTkfPm4f3XwtZ205yhv9/doP5v3OFIwEnmsWZiu8uEWM0HrUJ2/RjcHJ9FG5XH
         btGf5ySG+s1sdl43Ooa2e2jLF7wFgnCJJTWuJHIJjNUz/lJYsfCtCovNBNwb4NXPdys+
         NSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YtXzvh0C6WiWca/wi/qfYHW/5QpcMjxHI9YNhLAWuJ0=;
        b=TNLYrn9TOmorWiaG5SFCIJLj9kUvUbDBRW1mT28Eh+VoNdZEEikCOuDEMHFexZVEQG
         N+6IQUU1J9E8f10VOzbDj2wS1Zq1pF7xTEa4B+6OBQOJyAYe4Jf5oaLYi3u/QbK1MGsK
         px/c0RiW++pIi6uJiCIoDbX+OttM8en5QLWdHdbsZwDEwcZGoaelNtd0FxhmKi+JcR+G
         b3q1L5O/CwIy9WNCnj4FMLPD6mUcbk6l249xgbsIAl4WO4SbbEGk/sCIThUCm1LB60Rg
         g1nhlGb0LpqhLuVzh/YzYubw+ORiR/fmHD2bJ0fvisxpmCvVkoJM5sOtqqiCTOxb4dMf
         +usQ==
X-Gm-Message-State: AOAM533kxJSEiM/FFx3QsR/mxlMnOIbvfAMB9u7AD30wngLZUBIMcXMv
        umHh2s7vKEoIrCmo2BzmckJEEg==
X-Google-Smtp-Source: ABdhPJwE5DG1GPBbARyfTn2B2dT+ezPQUD+vIyLEwqxURyDd3r3xXCtCoRncy6rsxZvxSAb+TFQ4oA==
X-Received: by 2002:a05:6402:c8:: with SMTP id i8mr3113551edu.183.1639752093143;
        Fri, 17 Dec 2021 06:41:33 -0800 (PST)
Received: from localhost (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id gn26sm2942234ejc.14.2021.12.17.06.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 06:41:32 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, woojung.huh@microchip.com,
        UNGLinuxDriver@microchip.com, davem@davemloft.net,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        clang-built-linux@googlegroups.com, ulli.kroll@googlemail.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        amitkarwar@gmail.com, nishants@marvell.com, gbhat@marvell.com,
        huxinming820@gmail.com, kvalo@codeaurora.org,
        linux-wireless@vger.kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, dmitry.torokhov@gmail.com,
        ndesaulniers@google.com, nathan@kernel.org,
        linux-input@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 4.19 4/6] ARM: 8800/1: use choice for kernel unwinders
Date:   Fri, 17 Dec 2021 15:41:17 +0100
Message-Id: <20211217144119.2538175-5-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217144119.2538175-1-anders.roxell@linaro.org>
References: <20211217144119.2538175-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Stefan Agner <stefan@agner.ch>

commit f9b58e8c7d031b0daa5c9a9ee27f5a4028ba53ac upstream.

While in theory multiple unwinders could be compiled in, it does
not make sense in practise. Use a choice to make the unwinder
selection mutually exclusive and mandatory.

Already before this commit it has not been possible to deselect
FRAME_POINTER. Remove the obsolete comment.

Furthermore, to produce a meaningful backtrace with FRAME_POINTER
enabled the kernel needs a specific function prologue:
    mov    ip, sp
    stmfd    sp!, {fp, ip, lr, pc}
    sub    fp, ip, #4

To get to the required prologue gcc uses apcs and no-sched-prolog.
This compiler options are not available on clang, and clang is not
able to generate the required prologue. Make the FRAME_POINTER
config symbol depending on !clang.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/arm/Kconfig.debug | 44 +++++++++++++++++++++++++++---------------
 lib/Kconfig.debug      |  6 +++---
 2 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index bee0ba1d1cfb..01c760929c9e 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -45,30 +45,42 @@ config DEBUG_WX
 
 		If in doubt, say "Y".
 
-# RMK wants arm kernels compiled with frame pointers or stack unwinding.
-# If you know what you are doing and are willing to live without stack
-# traces, you can get a slightly smaller kernel by setting this option to
-# n, but then RMK will have to kill you ;).
-config FRAME_POINTER
-	bool
-	depends on !THUMB2_KERNEL
-	default y if !ARM_UNWIND || FUNCTION_GRAPH_TRACER
+choice
+	prompt "Choose kernel unwinder"
+	default UNWINDER_ARM if AEABI && !FUNCTION_GRAPH_TRACER
+	default UNWINDER_FRAME_POINTER if !AEABI || FUNCTION_GRAPH_TRACER
+	help
+	  This determines which method will be used for unwinding kernel stack
+	  traces for panics, oopses, bugs, warnings, perf, /proc/<pid>/stack,
+	  livepatch, lockdep, and more.
+
+config UNWINDER_FRAME_POINTER
+	bool "Frame pointer unwinder"
+	depends on !THUMB2_KERNEL && !CC_IS_CLANG
+	select ARCH_WANT_FRAME_POINTERS
+	select FRAME_POINTER
 	help
-	  If you say N here, the resulting kernel will be slightly smaller and
-	  faster. However, if neither FRAME_POINTER nor ARM_UNWIND are enabled,
-	  when a problem occurs with the kernel, the information that is
-	  reported is severely limited.
+	  This option enables the frame pointer unwinder for unwinding
+	  kernel stack traces.
 
-config ARM_UNWIND
-	bool "Enable stack unwinding support (EXPERIMENTAL)"
+config UNWINDER_ARM
+	bool "ARM EABI stack unwinder"
 	depends on AEABI
-	default y
+	select ARM_UNWIND
 	help
 	  This option enables stack unwinding support in the kernel
 	  using the information automatically generated by the
 	  compiler. The resulting kernel image is slightly bigger but
 	  the performance is not affected. Currently, this feature
-	  only works with EABI compilers. If unsure say Y.
+	  only works with EABI compilers.
+
+endchoice
+
+config ARM_UNWIND
+	bool
+
+config FRAME_POINTER
+	bool
 
 config OLD_MCOUNT
 	bool
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 6970759f296c..621859a453f8 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1178,7 +1178,7 @@ config LOCKDEP
 	bool
 	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
 	select STACKTRACE
-	select FRAME_POINTER if !MIPS && !PPC && !ARM_UNWIND && !S390 && !MICROBLAZE && !ARC && !X86
+	select FRAME_POINTER if !MIPS && !PPC && !ARM && !S390 && !MICROBLAZE && !ARC && !X86
 	select KALLSYMS
 	select KALLSYMS_ALL
 
@@ -1589,7 +1589,7 @@ config FAULT_INJECTION_STACKTRACE_FILTER
 	depends on FAULT_INJECTION_DEBUG_FS && STACKTRACE_SUPPORT
 	depends on !X86_64
 	select STACKTRACE
-	select FRAME_POINTER if !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM_UNWIND && !ARC && !X86
+	select FRAME_POINTER if !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM && !ARC && !X86
 	help
 	  Provide stacktrace filter for fault-injection capabilities
 
@@ -1598,7 +1598,7 @@ config LATENCYTOP
 	depends on DEBUG_KERNEL
 	depends on STACKTRACE_SUPPORT
 	depends on PROC_FS
-	select FRAME_POINTER if !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM_UNWIND && !ARC && !X86
+	select FRAME_POINTER if !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM && !ARC && !X86
 	select KALLSYMS
 	select KALLSYMS_ALL
 	select STACKTRACE
-- 
2.34.1

