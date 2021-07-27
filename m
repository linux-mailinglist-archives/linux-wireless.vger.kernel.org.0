Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809263D80B2
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jul 2021 23:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbhG0VHK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Jul 2021 17:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbhG0VG7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Jul 2021 17:06:59 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7166C0617BD
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jul 2021 14:06:56 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c16so15362plh.7
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jul 2021 14:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+j+u/2Y5xj0lHg0+NYIPs//vmCSVCR7ld8q4Rse+Wok=;
        b=Z3ztXP319Dh8l3oZBZJGcpVrN2yjz+4Ojp0xdciZQMieu4MElN+0uh/aio07BZugcM
         /IX8i89i9d4uIq473GDslpHYwhU2Ds+QQE/9q8XISm1huOhlc+3J3m4+mREFYd56BoTg
         skm6aewPub1EVzigwBqCw2/Yd1runR7VC+xlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+j+u/2Y5xj0lHg0+NYIPs//vmCSVCR7ld8q4Rse+Wok=;
        b=rvdc5ybkake72R9l+yxBsGYnE6PK5zZSXyWtDhOSLGQGKK6/E6Iim8pB5UuHobBLod
         JIarsQ6wffWAibuqccJf1Z/o3w6I13r645Xk/VyVq3v+QtDqxE3but5xamwwW9AIQvnE
         c7OIb6s8LVCBFK7vRzOUXOzPJLQHaOuXnfcykUkq/lH9eFJiV4FIeMPu9ztgEzjhR9f4
         usTUTVdV+kZS9mmXB4Z08+2KkKzyzenk3poL42GhplGWxYdCENGdcZ5MdOEQrOOupH4f
         lXoH4FRNFdYNDXQCFYvvQVK2nkuGMCJ4I3+DCjGBcPKhemcYdI1ZvpX/sh6iWZOmEjgl
         FBVw==
X-Gm-Message-State: AOAM5322UTqV738VbYlWlo6fRpgpRCBEzYu6IkkXNWCxMS2wcNdpuxW5
        2kUrE+bshOiI5402lkJl9G1beg==
X-Google-Smtp-Source: ABdhPJwY519iS8lVwKX1qEnCiC9eqr58WVWOOgD2YLBJLa/v/6HlmhUYFBKbzZ/EK3LD3+nNoyJZWw==
X-Received: by 2002:a65:564f:: with SMTP id m15mr25426446pgs.346.1627420016187;
        Tue, 27 Jul 2021 14:06:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a18sm4605717pfi.6.2021.07.27.14.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 14:06:54 -0700 (PDT)
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
Subject: [PATCH 42/64] net: qede: Use memset_after() for counters
Date:   Tue, 27 Jul 2021 13:58:33 -0700
Message-Id: <20210727205855.411487-43-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727205855.411487-1-keescook@chromium.org>
References: <20210727205855.411487-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1223; h=from:subject; bh=+oNHWYKI7OiMvUYldC+7QtNoxUdXE/kW9CQ+oRXYBqY=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhAHOJw9ilEafOIQz0OSX0a5+Mk3t4qj7IlMp5HpRI I8v04OeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYQBziQAKCRCJcvTf3G3AJuzVD/ 0RRox2qEIN95eJcW3A8vqt2ioE4mwhWDpnaG56BfiMQGgYavXHJCjNhgbBwOFJCV1qn/abootdw6gi MIuifo1LNauLOJXChBIxqmMU3Y5bpiCSS/AijpuBw4Z3iddlnotuhrfgguUBRoe0mf+iCQYvPctEPn WNEIRI5/AaV9Mf6UxjeOssFDHXcaYAH95H575iNwuiGKQ9U/X9kkZ7TMLIu3DjiAVdI1ef63t0bGqJ NT8VGIND8Jg3dGU7L51DnGwqESwUIdKaynpk/XskM+AdL5mIvIdzjm8Fq/DjRqSq+QyI5DmIWRXQ92 G5LTkFitmHW91XYAOIqhDmxJqafU5YThOy1v0k2C1xSOyQW9WGRkaNMfV1Rii3I9S27TQsObux3BPx k0wCCYVx0vsm4+HfA1bKzRQxQKkWvuUU5/SSR3pKmdD1YYGx7+h2DDpDTh81iNj5g82Wb6mv71dLOX p5X8qV5v1SXGEjLD3KX+fBCU6+dHKcl2DE2qIxdx8FlZ2TWZHRmmn1EfgLksLuMGt420FQH4fwsTlj y3dZYW3f4iMZvEmWpEXaMikr0p9gjMmvEAGCTavGtutONWZP9n7LQj7xSt7a/5jTYEF68rES7VaS64 nI2irr5vSpIpC9om4QpqvyeS3NCG27UfZ3SZyJRpHb6GNh+XvFlAs6IMK8aA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memset(), avoid intentionally writing across
neighboring fields.

Use memset_after() so memset() doesn't get confused about writing
beyond the destination member that is intended to be the starting point
of zeroing through the end of the struct.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
The old code seems to be doing the wrong thing: starting from not the
first member, but sized for the whole struct. Which is correct?
---
 drivers/net/ethernet/qlogic/qede/qede_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_main.c b/drivers/net/ethernet/qlogic/qede/qede_main.c
index 01ac1e93d27a..309dfe8c94fb 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_main.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_main.c
@@ -2419,7 +2419,7 @@ static int qede_load(struct qede_dev *edev, enum qede_load_mode mode,
 	goto out;
 err4:
 	qede_sync_free_irqs(edev);
-	memset(&edev->int_info.msix_cnt, 0, sizeof(struct qed_int_info));
+	memset_after(&edev->int_info, 0, msix);
 err3:
 	qede_napi_disable_remove(edev);
 err2:
-- 
2.30.2

