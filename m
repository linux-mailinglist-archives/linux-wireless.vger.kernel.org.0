Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABEC3D80E5
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jul 2021 23:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbhG0VIP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Jul 2021 17:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbhG0VHj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Jul 2021 17:07:39 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8F9C06136E
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jul 2021 14:07:03 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id mt6so1868309pjb.1
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jul 2021 14:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9rtpQJfi9BLLOweU32TBsHXrBE4rsqDcc6NfaxawLSk=;
        b=RtzRv2Hcall8Q6XauG9EQPn8i+Z+6koyHdHqSdWr1lBpyDmTL2zq8f4/gYexNOgk1T
         WXmsT0CdeWzWqKO4r48fClVJNDtqn6UozibeVLNy9JNbVg75bxoYY9Ruld+9teuS9TwN
         pO5fWj3PBxdOW6auqhJTHSBpj70tfZtzUkWjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9rtpQJfi9BLLOweU32TBsHXrBE4rsqDcc6NfaxawLSk=;
        b=c1e55bY7bX79XsU3P5XGMJfAlFY+KIOMRIJbn8uYjc0w8iDwsYRiYXxEUlGwKo+Ric
         s8FeKWr4TMdyI7PvSl+fCGsOBTJ7YrKEhixOj8VAL8S5BiEjT+B3N6Qi3ISnDAGbygSh
         OlsrsAdnUUkyjGu82T1eSE+fXEnGHHZKMthXZZ37a8Z8gYQVfRIq9xdHf4116Xwshn7Z
         SsDUNib6BuajHJxaHZgkqaXwsADtMWQTA9vkfn8I2Ljku08q2+Xs0DP+1L/9oLF5C76z
         Ut4mFNbVpzZjunKoBZh0YldxkPqIGe8Jmwua00coM129F8NAyhNX/oJkFjUes7mhZmqp
         PjpQ==
X-Gm-Message-State: AOAM530D12CTRY4MERimI3VfvdnPm8nS6yRrYHvGK5VaMJ7euiDnrAc4
        UhfcxwD86dwOdGRCbRB1imQdaw==
X-Google-Smtp-Source: ABdhPJwtY/96GtTJvQKRxUE9f4XM5WO13IhPiZmvG1Gx9it1XsiDWBqLh+O5ytTK4J0lAw6QIUM9HA==
X-Received: by 2002:a62:3852:0:b029:32e:50d4:6ee5 with SMTP id f79-20020a6238520000b029032e50d46ee5mr24697953pfa.3.1627420023128;
        Tue, 27 Jul 2021 14:07:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 19sm5414686pgg.36.2021.07.27.14.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 14:07:01 -0700 (PDT)
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
Subject: [PATCH 50/64] KVM: x86: Use struct_group() to zero decode cache
Date:   Tue, 27 Jul 2021 13:58:41 -0700
Message-Id: <20210727205855.411487-51-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727205855.411487-1-keescook@chromium.org>
References: <20210727205855.411487-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1896; h=from:subject; bh=Yy2yFM1urtqhL7n0r4aqd2cxgBZVMAyveJbcFvHLMlI=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhAHOLO3D9COdGLWOeR85zbaklAzObwkj15dNUWB7V d7VJAUWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYQBziwAKCRCJcvTf3G3AJlCqD/ 9cyHvgurMj0+H5UBZbi3PT0Pbs8SRpr/t0XADG40BpZ+yVAAnrqFDSkxMwCaBqoxRSLdmcDqy3b5SU c20S1Aw1siyqHiVEI4mnsKY6Jgrwx/SMBp2bYIVeZru9HNSXKKx57kdf2tIrViE9LYxYJFaHrBwPb9 o5tiJQmaA6MIjjExAe20o1QhTaI/E8sNfmlXtKaS0+XA7Rm8s+Qw65FVDyLqzv2BWb50Hdr4cMYh1X MTXkpiMZrMaPEQ3Wa2TwW0eAlAoWXXUXCLZ9VWJ5QlWKljXrylcdoLAikqEE7v2J5Rlr6FXOAMs3tZ d2CLoMo36Px3zBdTlu90/UlVPgO3P/Uk2ZhkN4uzHd4n/DIvanRvGewXH4liErXPixMmOgnLGLl+5d dVxT4PdjmU6shd83BEuZ8GZH4T6M9tygTNcERhWYIFMPXxYO5sgBrAlOJPmGkJC7hJD/RcfcYrBrpN UanrlQrhn6AYQGnmxcAQjc9dQQiRJO+jcDS4dRElaZb2OkRAD8J6+dNCu3El0L2RSWF1CiAbnwjwZi vxQaozruf1DsPdfg+Bv8JNonOrCpc7rnWMUbZIM6n0KMZJB+puj15D3L2N22fwOUi7MkF9cUWlAzlk H8X7oTv0jAj5RR0KuG/re2JSTLAEqtF1EBsbI72rE8m6mO5OjrH8edIe/qDg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memset(), avoid intentionally writing across
neighboring fields.

Add struct_group() to mark region of struct x86_emulate_ctxt that should
be initialized to zero.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kvm/emulate.c     |  3 +--
 arch/x86/kvm/kvm_emulate.h | 19 +++++++++++--------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 2837110e66ed..2608a047e769 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -5377,8 +5377,7 @@ static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop)
 
 void init_decode_cache(struct x86_emulate_ctxt *ctxt)
 {
-	memset(&ctxt->rip_relative, 0,
-	       (void *)&ctxt->modrm - (void *)&ctxt->rip_relative);
+	memset(&ctxt->decode_cache, 0, sizeof(ctxt->decode_cache));
 
 	ctxt->io_read.pos = 0;
 	ctxt->io_read.end = 0;
diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index 68b420289d7e..9b8afcb8ad39 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -341,14 +341,17 @@ struct x86_emulate_ctxt {
 	 * the rest are initialized unconditionally in x86_decode_insn
 	 * or elsewhere
 	 */
-	bool rip_relative;
-	u8 rex_prefix;
-	u8 lock_prefix;
-	u8 rep_prefix;
-	/* bitmaps of registers in _regs[] that can be read */
-	u32 regs_valid;
-	/* bitmaps of registers in _regs[] that have been written */
-	u32 regs_dirty;
+	struct_group(decode_cache,
+		bool rip_relative;
+		u8 rex_prefix;
+		u8 lock_prefix;
+		u8 rep_prefix;
+		/* bitmaps of registers in _regs[] that can be read */
+		u32 regs_valid;
+		/* bitmaps of registers in _regs[] that have been written */
+		u32 regs_dirty;
+	);
+
 	/* modrm */
 	u8 modrm;
 	u8 modrm_mod;
-- 
2.30.2

