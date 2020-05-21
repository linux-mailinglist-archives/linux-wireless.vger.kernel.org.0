Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91261DD812
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2020 22:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgEUUOb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 May 2020 16:14:31 -0400
Received: from mout-p-202.mailbox.org ([80.241.56.172]:13450 "EHLO
        mout-p-202.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgEUUOa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 May 2020 16:14:30 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 49Sgnc6gLGzQlGc;
        Thu, 21 May 2020 22:14:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id mIKNOPuHvLEp; Thu, 21 May 2020 22:14:25 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     johannes.berg@intel.com
Cc:     ndesaulniers@google.com, pihsun@chromium.org,
        linux-wireless@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] wireless: Use linux/stddef.h instead of stddef.h
Date:   Thu, 21 May 2020 22:14:22 +0200
Message-Id: <20200521201422.16493-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E706A1758
X-Rspamd-Score: 0.28 / 15.00 / 15.00
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When compiling inside the kernel include linux/stddef.h instead of
stddef.h. When I compile this header file in backports for power PC I
run into a conflict with ptrdiff_t. I was unable to reproduce this in
mainline kernel. I still would like to fix this problem in the kernel.

Fixes: 6989310f5d43 ("wireless: Use offsetof instead of custom macro.")
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 include/uapi/linux/wireless.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/wireless.h b/include/uapi/linux/wireless.h
index a2c006a364e0..24f3371ad826 100644
--- a/include/uapi/linux/wireless.h
+++ b/include/uapi/linux/wireless.h
@@ -74,7 +74,11 @@
 #include <linux/socket.h>		/* for "struct sockaddr" et al	*/
 #include <linux/if.h>			/* for IFNAMSIZ and co... */
 
-#include <stddef.h>                     /* for offsetof */
+#ifdef __KERNEL__
+#	include <linux/stddef.h>	/* for offsetof */
+#else
+#	include <stddef.h>		/* for offsetof */
+#endif
 
 /***************************** VERSION *****************************/
 /*
-- 
2.20.1

