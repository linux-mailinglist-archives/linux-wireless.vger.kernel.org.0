Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 129AA3D7F9E
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jul 2021 22:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbhG0U7E (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Jul 2021 16:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbhG0U7D (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Jul 2021 16:59:03 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828A9C0613D3
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jul 2021 13:59:03 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d1so24324pll.1
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jul 2021 13:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7nuFdIglNEHNCZJ4OURvNLaS8oKexf2Xbsw8tAobRMI=;
        b=fXdIa5xzPdxqW9JkE+8PrL7R3HOjzt/uPGhXwllYH14fLZCAy6MK5N+Aom2hlW1RLu
         LzaLP/I2bdBUasKo/LWt7kuMLca0bx1GK2a8LA0g1v3rpw0p8gJnsxnOKfkunXhaof5t
         +9cGUtaq4+nJifYIALqVfSUNMPZBcUPcyBLJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7nuFdIglNEHNCZJ4OURvNLaS8oKexf2Xbsw8tAobRMI=;
        b=qQDbQKL+XLHMJcZVn1hW7IERVhNXSwxeslv9tMvvLDLzzuq8MzNraMyPl7muPCg079
         WUz5dMAfZmRaK8gURcYYt0y/QIR0FTvkvjo1+lcTjYB/x8HdnR6noc4xQo++pd4+g5I9
         cym/hX/7tD/5VqF0xd1FtdQj8HVcLwmOG/9H78/QHPPCJ5cdImgfzG/eMhKaQZASCtH6
         6OlOY/QNgsDrdR91ZENBVTJkj3sU5UdW9D/hUoH1akecj/GOI4zxu7discxa/yYWjnZB
         KtvGc+mzFIyG1nfz1ZJkvr9LdfOl3hubmQS5CcY0h5HE880sKCOqPhk9jZFgmukHmUAX
         gutA==
X-Gm-Message-State: AOAM53143lKJdJbnVjzTrVZScUdfN9DKGnRndsyavxAFVzSreU0dcMS+
        PwKzeaTrMhcYybKprTVae6BsUw==
X-Google-Smtp-Source: ABdhPJxucZUfEOCwFmOc5wsWAybtREO6GX9yQ3Vd7QeNwkxYfGm08yYOn/RWC1L2rMGwaMab2R+i4g==
X-Received: by 2002:a17:90a:af8c:: with SMTP id w12mr12989398pjq.109.1627419543028;
        Tue, 27 Jul 2021 13:59:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i1sm3849350pjs.31.2021.07.27.13.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 13:59:02 -0700 (PDT)
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
Subject: [PATCH 01/64] media: omap3isp: Extract struct group for memcpy() region
Date:   Tue, 27 Jul 2021 13:57:52 -0700
Message-Id: <20210727205855.411487-2-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727205855.411487-1-keescook@chromium.org>
References: <20210727205855.411487-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4703; h=from:subject; bh=LCf4h7e2PK4sOgvQBd73gWCkmhRKJC4tH4kH78fVevA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhAHOAJSAPyozNrKWpqJWAzYod2fmvBM+4l2MwYKWh O4ocQxiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYQBzgAAKCRCJcvTf3G3AJoP0D/ 9KTuhNSJSjVRPOJFWeuepSlknmUmM/K2t4MDDXqOX/kDkR2wcXh6ttU5lVNW0YgBjHXAF5eWLYpPt5 XHm/KeoOX2MLhuXazp4Ti4YBKlziUsZTs5O6dl8oGQF8vvSOgQVD4x549qIJAaUMy/Q9HqWzVqq85p yP3Plkr/yT7Fr9RDFQxzPqOdsDFBoD1ZLcppau6vdTB0PZWIhyCpFYq2uKiDluWvj75Xhxrp9micdg U2R1bGYEEaNcOOSkguLQYe0+7XbhyY11oRTvhbZEZRUrrqPf99XF/yF1XvvLi6e8z/hVvbVGsEd8Mv Qiu6hKrvxmLG/6Gu1PUewl4RyNN90iXJ3Rh3zLatEPwPBHAFaGnBpr5RP4Ntn7iSsskKZBwlebvul7 dZxKtji4NE+xbeZup0zNKAjAcLeI8QVdmPiAbeqCybdrJc75zf4LhhuDwRXTdbrsXCooEGGuiMw3/v x+EUAxYAP0mwGpMCMNzDB9dpyGAKbRXmGfGhZu9JSilm3k8JsxQ47nQ3+PU4JxTEAGP/RA6CAwR6zV 7KB5mLzU0yyN2b7Az2uKl0RkeneD9qcEy0xqorM/qFH7O+d020ljiEXSwPXdgJdOF7fiAdpmoeK2uM 3RKFyedkYhLmnhtvfdEg6qb1tMNiC33AbBzVnm8LJMBkL2upkdQjzlsDvzsA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally writing across neighboring fields.  Wrap the target region
in a common named structure. This additionally fixes a theoretical
misalignment of the copy (since the size of "buf" changes between 64-bit
and 32-bit, but this is likely never built for 64-bit).

FWIW, I think this code is totally broken on 64-bit (which appears to
not be a "real" build configuration): it would either always fail (with
an uninitialized data->buf_size) or would cause corruption in userspace
due to the copy_to_user() in the call path against an uninitialized
data->buf value:

omap3isp_stat_request_statistics_time32(...)
    struct omap3isp_stat_data data64;
    ...
    omap3isp_stat_request_statistics(stat, &data64);

int omap3isp_stat_request_statistics(struct ispstat *stat,
                                     struct omap3isp_stat_data *data)
    ...
    buf = isp_stat_buf_get(stat, data);

static struct ispstat_buffer *isp_stat_buf_get(struct ispstat *stat,
                                               struct omap3isp_stat_data *data)
...
    if (buf->buf_size > data->buf_size) {
            ...
            return ERR_PTR(-EINVAL);
    }
    ...
    rval = copy_to_user(data->buf,
                        buf->virt_addr,
                        buf->buf_size);

Regardless, additionally initialize data64 to be zero-filled to avoid
undefined behavior.

Fixes: 378e3f81cb56 ("media: omap3isp: support 64-bit version of omap3isp_stat_data")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/media/platform/omap3isp/ispstat.c |  5 +--
 include/uapi/linux/omap3isp.h             | 44 +++++++++++++++++------
 2 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/drivers/media/platform/omap3isp/ispstat.c b/drivers/media/platform/omap3isp/ispstat.c
index 5b9b57f4d9bf..ea8222fed38e 100644
--- a/drivers/media/platform/omap3isp/ispstat.c
+++ b/drivers/media/platform/omap3isp/ispstat.c
@@ -512,7 +512,7 @@ int omap3isp_stat_request_statistics(struct ispstat *stat,
 int omap3isp_stat_request_statistics_time32(struct ispstat *stat,
 					struct omap3isp_stat_data_time32 *data)
 {
-	struct omap3isp_stat_data data64;
+	struct omap3isp_stat_data data64 = { };
 	int ret;
 
 	ret = omap3isp_stat_request_statistics(stat, &data64);
@@ -521,7 +521,8 @@ int omap3isp_stat_request_statistics_time32(struct ispstat *stat,
 
 	data->ts.tv_sec = data64.ts.tv_sec;
 	data->ts.tv_usec = data64.ts.tv_usec;
-	memcpy(&data->buf, &data64.buf, sizeof(*data) - sizeof(data->ts));
+	data->buf = (uintptr_t)data64.buf;
+	memcpy(&data->frame, &data64.buf, sizeof(data->frame));
 
 	return 0;
 }
diff --git a/include/uapi/linux/omap3isp.h b/include/uapi/linux/omap3isp.h
index 87b55755f4ff..0a16af91621f 100644
--- a/include/uapi/linux/omap3isp.h
+++ b/include/uapi/linux/omap3isp.h
@@ -159,13 +159,25 @@ struct omap3isp_h3a_aewb_config {
 };
 
 /**
- * struct omap3isp_stat_data - Statistic data sent to or received from user
- * @ts: Timestamp of returned framestats.
- * @buf: Pointer to pass to user.
+ * struct omap3isp_stat_frame - Statistic data without timestamp nor pointer.
+ * @buf_size: Size of buffer.
  * @frame_number: Frame number of requested stats.
  * @cur_frame: Current frame number being processed.
  * @config_counter: Number of the configuration associated with the data.
  */
+struct omap3isp_stat_frame {
+	__u32 buf_size;
+	__u16 frame_number;
+	__u16 cur_frame;
+	__u16 config_counter;
+};
+
+/**
+ * struct omap3isp_stat_data - Statistic data sent to or received from user
+ * @ts: Timestamp of returned framestats.
+ * @buf: Pointer to pass to user.
+ * @frame: Statistic data for frame.
+ */
 struct omap3isp_stat_data {
 #ifdef __KERNEL__
 	struct {
@@ -176,10 +188,15 @@ struct omap3isp_stat_data {
 	struct timeval ts;
 #endif
 	void __user *buf;
-	__u32 buf_size;
-	__u16 frame_number;
-	__u16 cur_frame;
-	__u16 config_counter;
+	union {
+		struct {
+			__u32 buf_size;
+			__u16 frame_number;
+			__u16 cur_frame;
+			__u16 config_counter;
+		};
+		struct omap3isp_stat_frame frame;
+	};
 };
 
 #ifdef __KERNEL__
@@ -189,10 +206,15 @@ struct omap3isp_stat_data_time32 {
 		__s32	tv_usec;
 	} ts;
 	__u32 buf;
-	__u32 buf_size;
-	__u16 frame_number;
-	__u16 cur_frame;
-	__u16 config_counter;
+	union {
+		struct {
+			__u32 buf_size;
+			__u16 frame_number;
+			__u16 cur_frame;
+			__u16 config_counter;
+		};
+		struct omap3isp_stat_frame frame;
+	};
 };
 #endif
 
-- 
2.30.2

