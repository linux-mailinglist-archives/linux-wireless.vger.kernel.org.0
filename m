Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A127C10C2EF
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2019 04:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfK1DmA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Nov 2019 22:42:00 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:34561 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbfK1DmA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Nov 2019 22:42:00 -0500
Received: by mail-pj1-f68.google.com with SMTP id bo14so11227596pjb.1
        for <linux-wireless@vger.kernel.org>; Wed, 27 Nov 2019 19:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hwr92oLWatoGx3uzF+7NwO91jSr/7W7A5PP5SHm0/LQ=;
        b=ETU15TiAx1Z7yDqy7QMoVMpUVdU+jS29zjx0hkg2vHGrZC9+cE3pYr7tnCcoWVulGI
         zWSVYM8lf7PeTE0/AJ2/IneHvtpmVWtI7Uphk/svA1ggCvIJN+X2+009OSYIr8B4C4v6
         aoMyWoMwpOhJGrjs6ACfnG3fAh1gE3x4BqAZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hwr92oLWatoGx3uzF+7NwO91jSr/7W7A5PP5SHm0/LQ=;
        b=SDaZrSa+7Qvo3/5xI5kohftKCIMpkWhzczKOvesQ+B/FRr7/sftic75HxMSPbHm9yv
         o84mphT5i7Eypfx2xTB1ErbhBh4mUC+Ns3CMCLn+tRkgkBCcMoZfNewXN5qX+jIldY5i
         dXIrdRvT8j8Xl3DWBDea+tI284aT6MrqDsOQQNdfotgOTdTw43JcT3QxsAzx6z0jq2Qi
         wf0trtfikQJFBPC/uM547Up4iPuXQnVjii4IzBIMLqdxz5bKjv3Tyx2V7+EP8Hn/EF+v
         IDsF8dJOrdoi3K5AiSboz/+7knLARLEm7s4jgwaoImjK8CXpJXpSBTU77mL1mY2T1sIa
         6Fkg==
X-Gm-Message-State: APjAAAUIplc0Bo0ZHBYKfAz6V+AEsx6EVzq0wTGQHGP8dDp/R3S9YsKx
        HW9NvV9eeakkamopUsw4CTn4nQ==
X-Google-Smtp-Source: APXvYqy1OCgKLhJCs2ZmcSKLbGu91GfNXJGRdwdvYZO0yQlFwSXJTBn/cGRtVtoQEZ4veVA5UqYvzQ==
X-Received: by 2002:a17:90a:8c92:: with SMTP id b18mr8211986pjo.7.1574912518618;
        Wed, 27 Nov 2019 19:41:58 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id z23sm17607567pgj.43.2019.11.27.19.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 19:41:57 -0800 (PST)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>, linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org (open list),
        clang-built-linux@googlegroups.com (open list:CLANG/LLVM BUILD SUPPORT)
Subject: [PATCH RESEND] wireless: Use offsetof instead of custom macro.
Date:   Thu, 28 Nov 2019 11:39:58 +0800
Message-Id: <20191128033959.87715-1-pihsun@chromium.org>
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
 include/uapi/linux/wireless.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/uapi/linux/wireless.h b/include/uapi/linux/wireless.h
index 86eca3208b6b..f259cca5cc2b 100644
--- a/include/uapi/linux/wireless.h
+++ b/include/uapi/linux/wireless.h
@@ -1090,8 +1090,7 @@ struct iw_event {
 /* iw_point events are special. First, the payload (extra data) come at
  * the end of the event, so they are bigger than IW_EV_POINT_LEN. Second,
  * we omit the pointer, so start at an offset. */
-#define IW_EV_POINT_OFF (((char *) &(((struct iw_point *) NULL)->length)) - \
-			  (char *) NULL)
+#define IW_EV_POINT_OFF offsetof(struct iw_point, length)
 #define IW_EV_POINT_LEN	(IW_EV_LCP_LEN + sizeof(struct iw_point) - \
 			 IW_EV_POINT_OFF)
 

base-commit: 1875ff320f14afe21731a6e4c7b46dd33e45dfaa
-- 
2.24.0.393.g34dc348eaf-goog

