Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 205A9F09E8
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2019 23:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbfKEW5z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Nov 2019 17:57:55 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43835 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729895AbfKEW5z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Nov 2019 17:57:55 -0500
Received: by mail-pg1-f196.google.com with SMTP id l24so15647347pgh.10
        for <linux-wireless@vger.kernel.org>; Tue, 05 Nov 2019 14:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ux3dKW0prKZO3aM0tHhSumJ6CNbG27Yo0nWnQJPUF48=;
        b=JvHUjacDAHdn/08O3UuEAK7NeX1bL0lhpzAPZt7jGw/Q0wsOF5YfM5K3aEd/6J3ivJ
         x3QUBw4ZHNEx1VdKPGr418kDGjypB6aZJLWxOD1fdZ80STrdAE/lCkfRN6ZW08DglH9j
         bYrror2orKBgwX/yScm7T/skOa52sf4U9kIRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ux3dKW0prKZO3aM0tHhSumJ6CNbG27Yo0nWnQJPUF48=;
        b=hXGarl+RBFVV4qMcrLsgQX/1lEfmU6BwsdHMzVOyEyAfP1FMf9p8Ki+DaV+v5ZIRac
         XcqBSufnYODS0Hjlye1ZpIz4Ef4nJ7mWN+MUG7pW0hhJsQ75eUaYT9SaXSNGl9LwthdA
         Bpg2eOFXjhYnS2C5ZeeVzacJrh65/T+39c94LqFMm9QTrbIkog4ADA+0qGCJo5D/s/cY
         5aDqj3hyjwgB1eVLLolgWdsHglyR3TVC7hHlezYRcjq+msQabwfG8EUEZ4TcvpHUP4G9
         GOm8Bj4HWluG+YOseukVEW+k13Tl2mdTO1nk8Rmup7MizD4VHEZyqyeFuUerGNZulGLd
         qUEw==
X-Gm-Message-State: APjAAAXaGtLPPkvUKDjQ2kYTl8yWZpiN6CjCZ1jSW6K5V7alqTX6dVkz
        h5NyBSVpKgg8gA0n6f5mz9hgydhhzk0=
X-Google-Smtp-Source: APXvYqzbnp1TYPlANgqLzY6pXR/DkyxD3CPUiSHYlgkgZ88Hs9rnLhbZFGOBw/RaiLWvmLpgR4ufZg==
X-Received: by 2002:a62:5442:: with SMTP id i63mr40089234pfb.220.1572994674154;
        Tue, 05 Nov 2019 14:57:54 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id a21sm478057pjq.1.2019.11.05.14.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 14:57:53 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     <linux-wireless@vger.kernel.org>,
        wireless-regdb@lists.infradead.org
Cc:     Brian Norris <briannorris@chromium.org>
Subject: [PATCH] crda: Makefile: fix .so compilation line with some compilers
Date:   Tue,  5 Nov 2019 14:57:51 -0800
Message-Id: <20191105225751.1233-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Yes, I know CRDA is deprecated.

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

