Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1E53D80D6
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jul 2021 23:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbhG0VHy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Jul 2021 17:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbhG0VHL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Jul 2021 17:07:11 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A106C0617B1
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jul 2021 14:07:01 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id e2-20020a17090a4a02b029016f3020d867so1074091pjh.3
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jul 2021 14:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RRl4QwGFVHrrGOIPdMRW7d1sxZ/z0xnxJ3QgfuV7q+Y=;
        b=VLdolfVHCXSWi55Yx/uNOx2x9gNCjcm8fAuonyRhF6lka+9tJjMC+ljSDw1I2hhSPl
         IPeW06Di2elnxoPtiM8a7tbufyY5DIpbj0wKJi28F7I97+I2C7r+CBhjZpWfsMqRUJOq
         uPrEwdOtDaUl+C26xZmgSdL3xsdhOztQ/ekno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RRl4QwGFVHrrGOIPdMRW7d1sxZ/z0xnxJ3QgfuV7q+Y=;
        b=ikwVRWyN1/fuNckZPExrZrMe97qpCt3rbvdzZ4mzcTfvwYZWWk802ZGWiYP0uotdip
         UreM9P3MZUdwZaai+8/OTL0lei9Y8pjl0LPnXvtSyyXQwZwAX587XQ88hof0DmsB2QMW
         o/sjVcGw4oU1TI+7PYXV24cyCP1YBYDziUnyAVrzWIZUVQgKWjcuFs7GdlXS8i0pM8dK
         qRvwEt8uCC1wV0UNt+xTntuVLYr07cGLi5EZIYsvNgij2wpmMDkW5+2/IoxiNjZeWYTS
         vC7n87lpb6ZQR6tNpwMXssP7KJ0czMDbx6Rr9BevNBjUXAyEFh4hYvVvQA8AqbaGDr0Q
         fYog==
X-Gm-Message-State: AOAM531dS4elad1CbO2RhuCVO43aj9Yu631idT7MC3UmCq3VnBvPBRhr
        xxrIBh5yuvkccK6ULd3f8yS9ZA==
X-Google-Smtp-Source: ABdhPJz1O0RCaY6YxEHXQjrBeBf6WlvQVtA9lzuclsJxgu0ny8IwFRemKEhaTqFBHWHY+58Ad0sxsg==
X-Received: by 2002:a17:90b:1097:: with SMTP id gj23mr24623197pjb.65.1627420020773;
        Tue, 27 Jul 2021 14:07:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k4sm1283492pgh.9.2021.07.27.14.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 14:06:55 -0700 (PDT)
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
Subject: [PATCH 53/64] HID: roccat: Use struct_group() to zero kone_mouse_event
Date:   Tue, 27 Jul 2021 13:58:44 -0700
Message-Id: <20210727205855.411487-54-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727205855.411487-1-keescook@chromium.org>
References: <20210727205855.411487-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1730; h=from:subject; bh=EUTv4O0nvngYWbdXtF9deGR2fwqq+6xUthh2+Rv4aLw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhAHOMI/KVhJIquCmbVDokB41QtN0+bK1f1n8H1BjO /vI3XCGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYQBzjAAKCRCJcvTf3G3AJigBD/ 4xOpohWQjjZHlbRQQB4Xc96JEF9UrR/87ufDJ/LQCR9f7bpU5HN4prxvGPl+Gh14S3nTWDhs7tQLV8 lgvttBveo3P3wp1AEgc84pleIWnY19RV8DcusmvreDhDG62N4MMW91V+yoqBuqB34xAxKaVJ0z6h4X tMH1NjPo77yLscB15GrJ4m3R/aS/iaccGcVUCwTR/CdCDoI/vLaImBCCH5YwQovtUmT1k04HUparAv jTs0fwcc1LfmJGkpT/YOIJnJ2shh0qAzEBKxdHgAIYE1pJJ59NQ6IfNzbMcQzEeapQ0p+kJRjODNpd oBpl+VAcjcyG71c3NBYs64mHgmd7xQgqxrKHeTTPI73krFkwv0sjaz1tYf6t3wGr+MJBryeUc/XLef bBUhQQ+U2nmjxMpH5biZuX8R5fJd8K2A6iOdS4OCIgCexMIqdOf47mtYSGy6w/OqX0D0HulkNM6Ak5 /kO3TY/+btKVuq9e6QW5DQLMbCfCbRrCJHmWxOFI5GVH3bchbtyGtVnd5VCwHQJhG28UCjTcKMLd10 3FKyVUcll/fy3asrDwz923cHSGawsRdwuUUF+B/1A93hUfh8ZPHnbv0X2Rh95SGmSNd9p793a13Ftn 6BVstROxT8kaLKdvZkdDDu6WqpqQxHglko/wXhuVc2rwuMX8jO3UGuzQBK9A==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memset(), avoid intentionally writing across
neighboring fields.

Add struct_group() to mark region of struct kone_mouse_event that should
be initialized to zero.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/hid/hid-roccat-kone.c |  2 +-
 drivers/hid/hid-roccat-kone.h | 12 +++++++-----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-roccat-kone.c b/drivers/hid/hid-roccat-kone.c
index 1ca64481145e..ea17abc7ad52 100644
--- a/drivers/hid/hid-roccat-kone.c
+++ b/drivers/hid/hid-roccat-kone.c
@@ -857,7 +857,7 @@ static int kone_raw_event(struct hid_device *hdev, struct hid_report *report,
 		memcpy(&kone->last_mouse_event, event,
 				sizeof(struct kone_mouse_event));
 	else
-		memset(&event->tilt, 0, 5);
+		memset(&event->wipe, 0, sizeof(event->wipe));
 
 	kone_keep_values_up_to_date(kone, event);
 
diff --git a/drivers/hid/hid-roccat-kone.h b/drivers/hid/hid-roccat-kone.h
index 4a1a9cb76b08..65c800e3addc 100644
--- a/drivers/hid/hid-roccat-kone.h
+++ b/drivers/hid/hid-roccat-kone.h
@@ -152,11 +152,13 @@ struct kone_mouse_event {
 	uint16_t x;
 	uint16_t y;
 	uint8_t wheel; /* up = 1, down = -1 */
-	uint8_t tilt; /* right = 1, left = -1 */
-	uint8_t unknown;
-	uint8_t event;
-	uint8_t value; /* press = 0, release = 1 */
-	uint8_t macro_key; /* 0 to 8 */
+	struct_group(wipe,
+		uint8_t tilt; /* right = 1, left = -1 */
+		uint8_t unknown;
+		uint8_t event;
+		uint8_t value; /* press = 0, release = 1 */
+		uint8_t macro_key; /* 0 to 8 */
+	);
 } __attribute__ ((__packed__));
 
 enum kone_mouse_events {
-- 
2.30.2

