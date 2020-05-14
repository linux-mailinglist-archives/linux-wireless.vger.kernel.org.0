Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D891D3137
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2020 15:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgENN1O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 May 2020 09:27:14 -0400
Received: from mail.skyhub.de ([5.9.137.197]:43670 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbgENN1O (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 May 2020 09:27:14 -0400
Received: from zn.tnic (p200300EC2F0BBD00DC45039F589BC722.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:bd00:dc45:39f:589b:c722])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2CDB61EC0377;
        Thu, 14 May 2020 15:27:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1589462832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/gUNpFf2J8YxXc2dc4jvcIV4nSmrVfwfJRbIw3Hp9zA=;
        b=Cw5b4Kt0phDez6vovuoDcELNE1rn2Rb0qgYhKo7jNCZmoqvQWGaDSBduPb+thltajNRdgz
        clbAbfOLrwUM+npRa7Mj3sXbe/4A5yzpF3a2wAUbHKrmt81x2u4t6MumqmAMrvvvAgBfPN
        765zESrOT7yfhbY4p4wvG2NH/A7RFEk=
Date:   Thu, 14 May 2020 15:27:06 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Matz <matz@suse.de>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        Jakub Jelinek <jakub@redhat.com>
Subject: [PATCH] x86: Fix early boot crash on gcc-10, third try
Message-ID: <20200514132706.GB9266@zn.tnic>
References: <20200513222038.GC6733@zn.tnic>
 <CAHk-=wgybuOF+Jp2XYWqM7Xn1CW6szWQw_FgVoFh5jx_4YoCVw@mail.gmail.com>
 <20200513233616.GD6733@zn.tnic>
 <CAHk-=wjZXFe08MiNRevJFGDvX0O6kcQTiK8GFBS7hwUAzB+LQw@mail.gmail.com>
 <CAKwvOd=o_wuiVpw5KVzLEt25W-A9Ah9fzftPZLG+yutqJmWbOg@mail.gmail.com>
 <CAHk-=wg6G+p1RRjR6UZBEuSCDs9=iWBsxrDPTEwqh+y5RayqKA@mail.gmail.com>
 <CALCETrUYA60fWu+=MviKx0NmW+_ppsOcv-ShUXdbyM4EjyfzHQ@mail.gmail.com>
 <CAHk-=wgiGxRgJGS-zyer1C_x2MQUVo6iZn0=aJyuFTqJWk-mpA@mail.gmail.com>
 <20200514052234.GA1894416@rani.riverdale.lan>
 <CAK8P3a1Cfzu7L30bFP-Sf2_GbkN_10CCJsbefTXyfnGF16uHMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a1Cfzu7L30bFP-Sf2_GbkN_10CCJsbefTXyfnGF16uHMA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ok,

here's the new version. Changes are:

- It does mb() now (Linus).
- I've added a call to prevent_tail_call_optimization() in init/main.c
  because it does generate the stack canary there too. This is a
  future-proof thing. (Arvind).
- Dropped Reviewed-by tags.
- Dropped compiler checking from the branch (Linus).
- Added Cc:stable because gcc10 has released already, apparently.

Testing with gcc10 passes after making sure that without it it would
cause the tailcall optimization and fail stack check.

Plan is to send it to Linus on the weekend so that it makes it into 5.7.

Thx.

---
From: Borislav Petkov <bp@suse.de>

... or the odyssey of trying to disable the stack protector for the
function which generates the stack canary value.

The whole story started with Sergei reporting a boot crash with a kernel
built with gcc-10:

  Kernel panic — not syncing: stack-protector: Kernel stack is corrupted in: start_secondary
  CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.6.0-rc5—00235—gfffb08b37df9 #139
  Hardware name: Gigabyte Technology Co., Ltd. To be filled by O.E.M./H77M—D3H, BIOS F12 11/14/2013
  Call Trace:
    dump_stack
    panic
    ? start_secondary
    __stack_chk_fail
    start_secondary
    secondary_startup_64
  -—-[ end Kernel panic — not syncing: stack—protector: Kernel stack is corrupted in: start_secondary

This happens because gcc-10 tail-call optimizes the last function call
in start_secondary() - cpu_startup_entry() - and thus emits a stack
canary check which fails because the canary value changes after the
boot_init_stack_canary() call.

To fix that, the initial attempt was to mark the one function which
generates the stack canary with:

  __attribute__((optimize("-fno-stack-protector"))) ... start_secondary(void *unused)

however, using the optimize attribute doesn't work cumulatively
as the attribute does not add to but rather replaces previously
supplied optimization options - roughly all -fxxx options.

The key one among them being -fno-omit-frame-pointer and thus leading to
not present frame pointer - frame pointer which the kernel needs.

The next attempt to prevent compilers from tail-call optimizing
the last function call cpu_startup_entry(), shy of carving out
start_secondary() into a separate compilation unit and building it with
-fno-stack-protector, was to add an empty asm("").

This current solution was short and sweet, and reportedly, is supported
by both compilers but we didn't get very far this time: future (LTO?)
optimization passes could potentially eliminate this, which leads us
to the third attempt: having an actual memory barrier there which the
compiler cannot ignore or move around etc.

That should hold for a long time, but hey we said that about the other
two solutions too so...

Reported-by: Sergei Trofimovich <slyfox@gentoo.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: <stable@vger.kernel.org>
Link: https://lkml.kernel.org/r/20200314164451.346497-1-slyfox@gentoo.org
---
 arch/x86/include/asm/stackprotector.h | 7 ++++++-
 arch/x86/kernel/smpboot.c             | 8 ++++++++
 arch/x86/xen/smp_pv.c                 | 1 +
 include/linux/compiler.h              | 6 ++++++
 init/main.c                           | 2 ++
 5 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/stackprotector.h b/arch/x86/include/asm/stackprotector.h
index 91e29b6a86a5..9804a7957f4e 100644
--- a/arch/x86/include/asm/stackprotector.h
+++ b/arch/x86/include/asm/stackprotector.h
@@ -55,8 +55,13 @@
 /*
  * Initialize the stackprotector canary value.
  *
- * NOTE: this must only be called from functions that never return,
+ * NOTE: this must only be called from functions that never return
  * and it must always be inlined.
+ *
+ * In addition, it should be called from a compilation unit for which
+ * stack protector is disabled. Alternatively, the caller should not end
+ * with a function call which gets tail-call optimized as that would
+ * lead to checking a modified canary value.
  */
 static __always_inline void boot_init_stack_canary(void)
 {
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index fe3ab9632f3b..4f275ac7830b 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -266,6 +266,14 @@ static void notrace start_secondary(void *unused)
 
 	wmb();
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
+
+	/*
+	 * Prevent tail call to cpu_startup_entry() because the stack protector
+	 * guard has been changed a couple of function calls up, in
+	 * boot_init_stack_canary() and must not be checked before tail calling
+	 * another function.
+	 */
+	prevent_tail_call_optimization();
 }
 
 /**
diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index 8fb8a50a28b4..f2adb63b2d7c 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -93,6 +93,7 @@ asmlinkage __visible void cpu_bringup_and_idle(void)
 	cpu_bringup();
 	boot_init_stack_canary();
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
+	prevent_tail_call_optimization();
 }
 
 void xen_smp_intr_free_pv(unsigned int cpu)
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 034b0a644efc..448c91bf543b 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -356,4 +356,10 @@ static inline void *offset_to_ptr(const int *off)
 /* &a[0] degrades to a pointer: a different type from an array */
 #define __must_be_array(a)	BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
 
+/*
+ * This is needed in functions which generate the stack canary, see
+ * arch/x86/kernel/smpboot.c::start_secondary() for an example.
+ */
+#define prevent_tail_call_optimization()	mb()
+
 #endif /* __LINUX_COMPILER_H */
diff --git a/init/main.c b/init/main.c
index a48617f2e5e5..74ac7e48ce02 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1001,6 +1001,8 @@ asmlinkage __visible void __init start_kernel(void)
 
 	/* Do the rest non-__init'ed, we're now alive */
 	arch_call_rest_init();
+
+	prevent_tail_call_optimization();
 }
 
 /* Call all constructor functions linked into the kernel. */
-- 
2.21.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
