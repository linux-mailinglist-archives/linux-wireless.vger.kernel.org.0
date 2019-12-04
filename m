Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEB25112434
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2019 09:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfLDINR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Dec 2019 03:13:17 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:42367 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfLDINR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Dec 2019 03:13:17 -0500
Received: by mail-pj1-f66.google.com with SMTP id o11so2663107pjp.9
        for <linux-wireless@vger.kernel.org>; Wed, 04 Dec 2019 00:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kLVVGHNKvob9eoQ/kiwi8Hd5PvOTq3zBu7HFDYNsI7o=;
        b=dW1k409Hwpne9y4cOUDwoaNXf/m2bg6wig4H+wPSOt+LKkQuKohHtDTRe/0bMYvJqF
         Ge1sTZ2HM81RJdZ+b8CZff1kARp2NNdFi5h05eIfpIDzXQtSocCRxTdz31Fbplc6Hnb2
         hVrkIx9Vu+3hSP+y5rBGNsyIP9YCtvGdj6QXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kLVVGHNKvob9eoQ/kiwi8Hd5PvOTq3zBu7HFDYNsI7o=;
        b=HriqZIir9kmo/77w9c/aBNFj8YtDENvXBgyCFJGL5xDXHE4zl1goE8JS4+ErPPvWD5
         9SrDUrRSOkt9L/tKbzeV+PwH8ns0VUnsgihxjtZpFF360m5IrxiGidpl66sMi6PsPO5d
         abx5H9crb4vmByNDEmkZ6TI09zgjOCUCc3gsSQWOHrW1CXoTVeOHLQLu2dnTgskhMcxX
         sTLvqk0bydSKItKXwDw22RT29YgO+ZoPwfPMS38kq5B0bPExWXseBecIP6sCbrwBmZwZ
         KTj7RzK9OonBuBbAMisX+J+0hSzFQyWFZl279Ck5n/CZ7NInbzKmzANhEmrNrCQ/5kE5
         AjNw==
X-Gm-Message-State: APjAAAUlabJMdZhPYKeBmXiYVd4tbiUYJ/VJ9ODqbk/Ax8zRKIWcgW3A
        LmEqwfWqj8CE+2Xl1eflCi3tHw==
X-Google-Smtp-Source: APXvYqyB1iRYmu9NxaK6tXmRL7wMYwxaJcR0mPrBrRqMo+4sZPD2J7OZJ1+Ll2NMDetAC7/eMFOkGg==
X-Received: by 2002:a17:902:b095:: with SMTP id p21mr2149106plr.313.1575447196552;
        Wed, 04 Dec 2019 00:13:16 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id a3sm5435699pjh.31.2019.12.04.00.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 00:13:15 -0800 (PST)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>, linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org (open list),
        clang-built-linux@googlegroups.com (open list:CLANG/LLVM BUILD SUPPORT)
Subject: [PATCH v2] wireless: Use offsetof instead of custom macro.
Date:   Wed,  4 Dec 2019 16:13:07 +0800
Message-Id: <20191204081307.138765-1-pihsun@chromium.org>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use offsetof to calculate offset of a field to take advantage of
compiler built-in version when possible, and avoid UBSAN warning when
compiling with Clang:

==================================================================
UBSAN: Undefined behaviour in net/wireless/wext-core.c:525:14
member access within null pointer of type 'struct iw_point'
CPU: 3 PID: 165 Comm: kworker/u16:3 Tainted: G S      W         4.19.23 #43
Workqueue: cfg80211 __cfg80211_scan_done [cfg80211]
Call trace:
 dump_backtrace+0x0/0x194
 show_stack+0x20/0x2c
 __dump_stack+0x20/0x28
 dump_stack+0x70/0x94
 ubsan_epilogue+0x14/0x44
 ubsan_type_mismatch_common+0xf4/0xfc
 __ubsan_handle_type_mismatch_v1+0x34/0x54
 wireless_send_event+0x3cc/0x470
 ___cfg80211_scan_done+0x13c/0x220 [cfg80211]
 __cfg80211_scan_done+0x28/0x34 [cfg80211]
 process_one_work+0x170/0x35c
 worker_thread+0x254/0x380
 kthread+0x13c/0x158
 ret_from_fork+0x10/0x18
===================================================================

Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---

Change since v1:
 * Add #include <stddef.h>

---
 include/uapi/linux/wireless.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/wireless.h b/include/uapi/linux/wireless.h
index 86eca3208b6b..a2c006a364e0 100644
--- a/include/uapi/linux/wireless.h
+++ b/include/uapi/linux/wireless.h
@@ -74,6 +74,8 @@
 #include <linux/socket.h>		/* for "struct sockaddr" et al	*/
 #include <linux/if.h>			/* for IFNAMSIZ and co... */
 
+#include <stddef.h>                     /* for offsetof */
+
 /***************************** VERSION *****************************/
 /*
  * This constant is used to know the availability of the wireless
@@ -1090,8 +1092,7 @@ struct iw_event {
 /* iw_point events are special. First, the payload (extra data) come at
  * the end of the event, so they are bigger than IW_EV_POINT_LEN. Second,
  * we omit the pointer, so start at an offset. */
-#define IW_EV_POINT_OFF (((char *) &(((struct iw_point *) NULL)->length)) - \
-			  (char *) NULL)
+#define IW_EV_POINT_OFF offsetof(struct iw_point, length)
 #define IW_EV_POINT_LEN	(IW_EV_LCP_LEN + sizeof(struct iw_point) - \
 			 IW_EV_POINT_OFF)
 

base-commit: c5db92909beddadddb705b92d3388ea50b01e1a2
-- 
2.24.0.393.g34dc348eaf-goog

