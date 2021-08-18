Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B283EFC90
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Aug 2021 08:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238575AbhHRGYs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Aug 2021 02:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238176AbhHRGYr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Aug 2021 02:24:47 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A18C0613D9
        for <linux-wireless@vger.kernel.org>; Tue, 17 Aug 2021 23:24:13 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id y11so1102340pfl.13
        for <linux-wireless@vger.kernel.org>; Tue, 17 Aug 2021 23:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sw/Jd50933MgMDKcslseqtGFSA6d20C1365G+gy2Cx4=;
        b=lkb90SqGpvhafiRjISSgB0a2FrYdpBXG9CDn9kyMEGK8G+C6mKoqovQIKPmXFTd6fX
         KhJkX9Egylj1mwlSIMLNcs5ZBl52s9MtlmYUhK0Xdyehqw1A6JTalUf7LXgHvquVhuiB
         vdvmLxRGM0/kjfEaChvj3QOfSe7n54uv/XChU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sw/Jd50933MgMDKcslseqtGFSA6d20C1365G+gy2Cx4=;
        b=QFBiGpIHt0CvIq/TMVZ54ggTjFKdU2feNbembh8EicPbBnLBFdS22S4AWe64TVFl6U
         v8JlpN9/a+D2dbuJJ3zOmEvxQ25VfwJ0KTlaDNRhB3cBtRzq2s3vWyPOsBuc95zSe8Cw
         cGtN6OVU743AFmTxcHaRHk1q+JBBe8+AxiruqCpbLkveDFBle+BN2rHcKCwufHRPZgyT
         tm3i6pfXcc/F09otXrhSlqQFKyQ+ePzd87sMTj/6c5/aL2L9KlfHZmoIH7nqjdQbZBMD
         XGANtkGtKW+DSnDkoWzN2GEGeD3LKtBHxL8XwnUfO9o7P6Bk8rTEFcOqA16AusL+zYpH
         OfBg==
X-Gm-Message-State: AOAM530PuW1/HEDd7VlGOnC0NXMAyFFQrlXBMHJLmwlft7MCT0Shh5BS
        jXdM1UDybGL3IlsUVFIjezQ2+g==
X-Google-Smtp-Source: ABdhPJy9CLfg35oDbbdeQsU7HbtEw7JEEvFjjstjJ1u7tRCnU3ll7bgG1jvkDuiyrvoW+GnkiwkfjA==
X-Received: by 2002:a63:fb08:: with SMTP id o8mr7314165pgh.72.1629267853126;
        Tue, 17 Aug 2021 23:24:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n13sm4501409pff.164.2021.08.17.23.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 23:24:12 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Harald Welte <laforge@gnumonks.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-staging@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kbuild@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2 52/63] cm4000_cs: Use struct_group() to zero struct cm4000_dev region
Date:   Tue, 17 Aug 2021 23:05:22 -0700
Message-Id: <20210818060533.3569517-53-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818060533.3569517-1-keescook@chromium.org>
References: <20210818060533.3569517-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1756; h=from:subject; bh=J4NGkJQCgahZv2zewL/wYUO+MpNSkAZfZF2EdzgyTRQ=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHKMplIHvWiwQENOF2c7XlC/x85JbSdFgE5kqsWuK 0OxdRfuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYRyjKQAKCRCJcvTf3G3AJtHPD/ 9w1C3xZTkrQOl8qCphP1NuYb6Zzm4m2uWKaotV03HQ6T9nZ1pYcDMMaHhAraQDtG/+gMBjur6kCewv ayrtSdcUPKzKabKpDYkkQQGEE9qhvOYR4et5WymZDf+eN80rUG6e4eGkoBaSg8aVufvzlEbWGGJI1g tqDg4cuv/AswW6J0SfIjA0LGvOcP86foOnbG0fLo1CjkuPmC73qAisdtYqZ728UwCF73xtFOwOcz58 eqjKu4Hpj2sUaNV2ghIn1t2tsXH9VMc5RRvDzUnjKE8WQiYMXT1GnQMQC30RP8X5s0vnTZZK9COqg4 oewq2GoOKKBWejZCZnIt2PWaHfLpUYE3cXHVsUUrUzVwgg/Sk3purVXNGauBM7zNDyMu+OqTX4ib/A +HNqKaO/5WxWULHr6ttMgZKJiYQpCIvqqVqyHlMArxKxGWwiOSShxbeoadhVmd0SxeqdGPdNCiAuk6 FFaKdGvO/XR7rdo2FnWbhYIs1bjRjMoCnyn4vUMe6sRx6ESs8Bvvf+nu0uOBDONLatp0KRkgfFUvYM i85g6GvFHJOXM2duu8wB+SxG0oCcvOTXiLpU3c5ok266H6TYTMs6yQQ6fEkcPZU/wwc56QrWbNdrgO Cwck+Q8ubdcpIlRqgjAb6NEZ7diJsEGXAyIkWnhUKNVIgROWsl4C+tImakjQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memset(), avoid intentionally writing across
neighboring fields.

Add struct_group() to mark region of struct cm4000_dev that should be
initialized to zero.

Cc: Harald Welte <laforge@gnumonks.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/lkml/YQDvxAofJlI1JoGZ@kroah.com
---
 drivers/char/pcmcia/cm4000_cs.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/char/pcmcia/cm4000_cs.c b/drivers/char/pcmcia/cm4000_cs.c
index 8f1bce0b4fe5..2f43e7088e16 100644
--- a/drivers/char/pcmcia/cm4000_cs.c
+++ b/drivers/char/pcmcia/cm4000_cs.c
@@ -116,8 +116,9 @@ struct cm4000_dev {
 	wait_queue_head_t atrq;		/* wait for ATR valid */
 	wait_queue_head_t readq;	/* used by write to wake blk.read */
 
-	/* warning: do not move this fields.
+	/* warning: do not move this struct group.
 	 * initialising to zero depends on it - see ZERO_DEV below.  */
+	struct_group(init,
 	unsigned char atr_csum;
 	unsigned char atr_len_retry;
 	unsigned short atr_len;
@@ -140,12 +141,10 @@ struct cm4000_dev {
 
 	struct timer_list timer;	/* used to keep monitor running */
 	int monitor_running;
+	);
 };
 
-#define	ZERO_DEV(dev)  						\
-	memset(&dev->atr_csum,0,				\
-		sizeof(struct cm4000_dev) - 			\
-		offsetof(struct cm4000_dev, atr_csum))
+#define	ZERO_DEV(dev)	memset(&dev->init, 0, sizeof(dev->init))
 
 static struct pcmcia_device *dev_table[CM4000_MAX_DEV];
 static struct class *cmm_class;
-- 
2.30.2

