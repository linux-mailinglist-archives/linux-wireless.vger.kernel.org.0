Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1723EFBA6
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Aug 2021 08:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239474AbhHRGNs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Aug 2021 02:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238800AbhHRGNW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Aug 2021 02:13:22 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEB1C07E5E0
        for <linux-wireless@vger.kernel.org>; Tue, 17 Aug 2021 23:06:06 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id j187so1064263pfg.4
        for <linux-wireless@vger.kernel.org>; Tue, 17 Aug 2021 23:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PTBKkWGSJ4jeq48Lif1HjorGsj7JNkZaLkD8D5Mis7A=;
        b=lcRiLN/pxXroa+z0dIVjwpE6juQ/WSj9kN1DJHiXQOxPdexqsXsummW+QGZRKJMuKE
         goKTAqxz4pwd1w10URarcs5dopjzXmwolbK+77hwkcGaxXJAK302qu5FzsGr1WTfWGGB
         ymGtBiAAT9XPK+AD9AOkBT52goGiThLInSsB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PTBKkWGSJ4jeq48Lif1HjorGsj7JNkZaLkD8D5Mis7A=;
        b=VLlo68EiLpqyKmZ3vh+ir2L6M1CAMPIsJHx0JFQb4FMve1wAbqGa5ymcRxPSJUPtys
         /lE0n+O7N8ocjG3E57MqttLTrJM12Bs4pMy9pMkSmJMCYJ9EWYIYfPrhUfOeSqIW8N/p
         E9urEcz1xqe/Gq7YMicj6o8P7JC44g7T7qjwAl5iJ0+ixfyrKJznKF2f3Joqon81UCA3
         9tNcIDO4oEpb9a8BucTJgfg9ZdM7ERyMB4kVlbawKJ6Or1C+v0TE8dKGDVuxeECiVoN4
         2KWnQlpLq20/hYW0lPZ7xU6rm3Ayr1DqKv5crtLYsq4+cJtvGn2NJKayqpY8BcD8N+b2
         UOow==
X-Gm-Message-State: AOAM531BdNzWAH3tCth8cptc4Gqlt/z9lq6q55gjRCtBx4wM9BZ/ofwW
        vOLfa6is1d9aKiXaeHkX1+7rIA==
X-Google-Smtp-Source: ABdhPJzCiookpb9ebYshndEgzHCX93ly5catWbwmyFE6JV+ARL2uHnLBYxH38LP6l1lYGAvgKe5gsQ==
X-Received: by 2002:a62:d085:0:b0:3e0:f21a:8030 with SMTP id p127-20020a62d085000000b003e0f21a8030mr7615770pfg.70.1629266766375;
        Tue, 17 Aug 2021 23:06:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j17sm4782687pfn.148.2021.08.17.23.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 23:06:02 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-staging@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kbuild@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2 47/63] intel_th: msu: Use memset_startat() for clearing hw header
Date:   Tue, 17 Aug 2021 23:05:17 -0700
Message-Id: <20210818060533.3569517-48-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818060533.3569517-1-keescook@chromium.org>
References: <20210818060533.3569517-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1239; h=from:subject; bh=uh3kPqi+1X1lyfKJytqHpZ67tA8Si7LB8pUN1izBRBI=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHKMokuhXR2p74Acuej4eCBPYM2cMZOT8THgQZzGV rdQKEmSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYRyjKAAKCRCJcvTf3G3AJvm1D/ 9kF/338CaDSDtZdoqV6TgTFjJO7GhbNkoBmaGibpVP14xbup3OFbl/8EWjfIgiZ5HEL4MqjjTWMyQD GVmRXMyIy+vWRh/NnndkDGceRW6qt3HsyulsPKChA7zxUB+DgshZpdqVp8ftqxAtnr7XjoSLpPjA6Q jd9iNmeK/83BSvOrCXzfw3QnVp7S/8MJgCGvFbdrnET8gv1IOUMB8G7m3XGNLUryv8ZV2DS5g85EQ0 9P28dpGxmAVMsi9vVqMViPQNC/BVKoo+Ax89vzH5K3aMn1bfmCCfXRiU1R1z687xeHxmN0mNjUu943 YG2huUBJz+HFlahhX/8DegqUfH3Roc81OdU4xQrSWUIynliECUj+/rLG3nUrqetH+63wRgHXzOS30A dNLHiD+cCMIYAMXAhvA/kiRl2zfl4bvvXGqwytmyz0E8wMCPXFx5NF0Kx2GmTm0w6DvHzyRwqGzrVe o+OGGog3VcigZZFQfBTpYUYJZ91yw92GJvsWxlN1Jlkk3oLo6ax2gSSw1Kw+wlUL5JUYGviliS2BrP Gjo9a6pi+N90GCV9dZw+rMpbHm49R3IBpe72LrTBqKtVtcEAuFolJR7jQHnLfVqdCTdUjl7xRKSpdJ L25TTHWjDtgY5E6pp3BASup3QhcHbz4WiGqQCnvgdUgeX69GFYXmzp9CuwAg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memset(), avoid intentionally writing across
neighboring fields.

Use memset_startat() so memset() doesn't get confused about writing
beyond the destination member that is intended to be the starting point
of zeroing through the end of the struct.

Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/hwtracing/intel_th/msu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 432ade0842f6..70a07b4e9967 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -658,13 +658,11 @@ static void msc_buffer_clear_hw_header(struct msc *msc)
 
 	list_for_each_entry(win, &msc->win_list, entry) {
 		unsigned int blk;
-		size_t hw_sz = sizeof(struct msc_block_desc) -
-			offsetof(struct msc_block_desc, hw_tag);
 
 		for_each_sg(win->sgt->sgl, sg, win->nr_segs, blk) {
 			struct msc_block_desc *bdesc = sg_virt(sg);
 
-			memset(&bdesc->hw_tag, 0, hw_sz);
+			memset_startat(bdesc, 0, hw_tag);
 		}
 	}
 }
-- 
2.30.2

