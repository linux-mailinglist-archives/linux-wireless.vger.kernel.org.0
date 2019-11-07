Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDA2F35CB
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2019 18:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730274AbfKGRh2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Nov 2019 12:37:28 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33050 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728847AbfKGRh2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Nov 2019 12:37:28 -0500
Received: by mail-pf1-f194.google.com with SMTP id c184so3069535pfb.0
        for <linux-wireless@vger.kernel.org>; Thu, 07 Nov 2019 09:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G8y85XrJTCjTVadT+VZjZfgtkbdkpE4HwtZrB/hkkbU=;
        b=E8E2iPw49phef3jOqYci51VI6Kd1TiJ171mkNuSMJ6qGk+x0btUN+/7B51r86qcCcr
         rlrjfSLHlXKF7FKZiOB2p2MRdtvsZJnsxiGyGfoB3JQQFJoU/fUpKYGDnu4VoWZZYTD3
         HiLxoJ0WovdVVQ3s28Uz2h42m39ZQ5iOeUOFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G8y85XrJTCjTVadT+VZjZfgtkbdkpE4HwtZrB/hkkbU=;
        b=giMsoUvlesu3xh7A1xo9hKpmQHJp+2s0sQ6scw+88r5FDVYczrUwazsGDaRV5NdlPY
         i085Wr2hhmYpeB4o01f6/kgNydh8vOJFX0W4PoxKdravMNHSyuDo8KyxpuplcwNtKiMA
         dLgZKAX3wo/1CtrCUgL0PdU9KP9s0bVY3nPKEv3AiZFuty2eTiF4eIbiO2wQob4xWGB3
         3SSY3AhS20hSp49VNBYfL3gNTN/RKhI1ZPQtBEBpocKw4VZ/uRc2v6ICxoMLiR8Bcnv6
         0JiEI1WTt7sSWCvZIcsZKo+VPDNF5DGF4cZZzcwzlFkOogH8LqNZeor2+VN8MSLLACch
         SAqw==
X-Gm-Message-State: APjAAAXUDqOKWbb4j0YVdwmNs+fJSTDRVr1z+6s34d5a7GHe3Z1S3MRe
        jkpcN2wbe34bCGzF4AHUD1ylqA==
X-Google-Smtp-Source: APXvYqwM54coTod1ECsQmgYl3gKe919AcyfnE1PVZ3nTQPO87kfGAijyExBU9k+VYiJjUrow4pUr4A==
X-Received: by 2002:a63:3d41:: with SMTP id k62mr5691676pga.129.1573148247589;
        Thu, 07 Nov 2019 09:37:27 -0800 (PST)
Received: from google.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id q8sm2489035pjp.10.2019.11.07.09.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 09:37:26 -0800 (PST)
Date:   Thu, 7 Nov 2019 09:37:24 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        wireless-regdb@lists.infradead.org
Subject: [RESEND PATCH] crda: Makefile: fix .so compilation line with some
 compilers
Message-ID: <20191107173723.GA157096@google.com>
References: <20191105225751.1233-1-briannorris@chromium.org>
 <CA+ASDXM_5Q3LNyv_mbrG8d8Qo1iZZz2A2CFfvQqj9_Ta-q-wMA@mail.gmail.com>
 <786f623306ad462e3776236c94e83b5f2e0648ab.camel@sipsolutions.net>
 <CA+ASDXMVJg0QSPzSiWFjoDH67yJ-NfYX4MQZUT3gaivx1SJ2aA@mail.gmail.com>
 <20191106231749.GM11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106231749.GM11244@42.do-not-panic.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Write the CC rule such that it only tries to produce a single output
file (the .so). When including the .h files in the compiler invocation,
this suggests we should be producing pre-compiled headers too, which
doesn't make sense in this context, and Clang happens not to like.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
On Wed, Nov 06, 2019 at 11:17:49PM +0000, Luis Chamberlain wrote:
> Sure, send me patches.

Done.

 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 6169b1f307da..6ca26f341dfa 100644
--- a/Makefile
+++ b/Makefile
@@ -114,9 +114,9 @@ keys-%.c: utils/key2pub.py $(wildcard $(PUBKEY_DIR)/*.pem)
 	$(NQ) '  Trusted pubkeys:' $(wildcard $(PUBKEY_DIR)/*.pem)
 	$(Q)./utils/key2pub.py --$* $(wildcard $(PUBKEY_DIR)/*.pem) $@
 
-$(LIBREG): regdb.h reglib.h reglib.c
+$(LIBREG): reglib.c regdb.h reglib.h
 	$(NQ) '  CC  ' $@
-	$(Q)$(CC) $(CFLAGS) $(CPPFLAGS) -o $@ -shared -Wl,-soname,$(LIBREG) $^
+	$(Q)$(CC) $(CFLAGS) $(CPPFLAGS) -o $@ -shared -Wl,-soname,$(LIBREG) $<
 
 install-libreg-headers:
 	$(NQ) '  INSTALL  libreg-headers'
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

