Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B107A27AB
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Sep 2023 22:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbjIOUHi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Sep 2023 16:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237078AbjIOUHF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Sep 2023 16:07:05 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B05A2D4A
        for <linux-wireless@vger.kernel.org>; Fri, 15 Sep 2023 13:06:39 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6c0b3cea424so1450834a34.2
        for <linux-wireless@vger.kernel.org>; Fri, 15 Sep 2023 13:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694808398; x=1695413198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jatWasS204QwZuZ1cmt7SDqxcoxRSBD/dVPK2mjyGCY=;
        b=DtiS/q9QD7Bu9ldNxfYjldKjFGNjvcVc/fz5/RfSEIqbbfr+obLCqFTu7691R8IBvZ
         +4ju+MQ3V7Ahyx/K56Ph/8Eo5P/PZzsOzeLQj98S//Pql5uwoC69jiU8/5ZczX19tFVM
         4aBgjzBoQ8p5sNwmOxFH26Z3pe0YlGlUTGuow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694808398; x=1695413198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jatWasS204QwZuZ1cmt7SDqxcoxRSBD/dVPK2mjyGCY=;
        b=la2NQVJqLyRMmMfJ4ORmwE3FbPkuW3t2v7RYylW76aj9roG2w/5CdYmCtjCaXHyyHs
         Q9EVEMwAHBx/50Qv5pMKqqp47cyMxL46oKWdd0V2TDDorlZjqYNd9moS5mBSbKJmx2wI
         Uv8yQfcbCVtw7AjAa57pdVX2K9g3e3y7coxjvNsp9cHfYF18fQWt1bjfsN1siSlwApYm
         VcMmByOpulqRW/y48nuS7zlg0qgsrtqnAhUxxuNS9DfNzi69hQNjQyjuUjGabq20S4rv
         L2XDZvImvTNCEM0wJDJsN/HJkkH83EJI6wVEFiSULAMTn6bMcZnNHa6+Foh+h7ThCjSF
         mNAA==
X-Gm-Message-State: AOJu0Yxchxb5UvkGDnM30VdhSAGCs7cuJRNUywjxIbbeueht3u5yhNpq
        y4Ly9ACX5LI+jGuR2G8l9QvafQ==
X-Google-Smtp-Source: AGHT+IGXQqiIq6S4bgOC/rczT8CEqgDpEzDp+av8eoitgJQpUO9EnGhGdKEsv8TA7BWoVjF1DIS9yQ==
X-Received: by 2002:a05:6358:2910:b0:134:c37f:4b64 with SMTP id y16-20020a056358291000b00134c37f4b64mr3429872rwb.30.1694808398331;
        Fri, 15 Sep 2023 13:06:38 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b127-20020a633485000000b005709b5aea02sm3039409pga.63.2023.09.15.13.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:06:37 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] wifi: ath10k: Annotate struct ath10k_ce_ring with __counted_by
Date:   Fri, 15 Sep 2023 13:06:36 -0700
Message-Id: <20230915200636.never.762-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1238; i=keescook@chromium.org;
 h=from:subject:message-id; bh=W0Z7FKEp2ozBJ5/t2fUugzUzm+3pU7NY9bmGkgl9TaQ=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlBLlMujYCGGfE+LkiGsu88vAuQpO/bsLI9ODrg
 7qJQcqRlzGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQS5TAAKCRCJcvTf3G3A
 Jjo0D/0ZhZjM3umwDd4cScp/pX69G3PAuyE5MgO0WMxQPUuULMPhwefs2sxa4V3f11IiNVJnHtW
 soi02X7jMpU81gA0gZljCei7qMNuZza5nCUsLw/tZFEvOS7by/LWH8N8eKeC1HM/gX5nJzk87sJ
 524wLuAgNxeE0ZKs0kE17vg/QAtRZ6AlhVxJHN7W7oZ9vFiabMcnvDOvUvhnIuCmf8H3yyepMSJ
 d6PSUEAVtDnmd2z/r+XAp2jILEyXzM6oLz4v5N01BYz3qvzxRPyleV3r9ohrfGd6QO72+Mhqytj
 XRd8Uq2Ltx/5ewjaD0vkDWzbroV8Tqj72dqgpBMXz4328EyeVueyo6mlXGorpgbPwNZSpdZP3a1
 0454XWq12ei33x2sH7xkEJxQLtIOT2zKBbsHKbRwvZce2PQ8CJ4LxhI3H3epIf+UrS+uNI0uWhk
 jfhiAhauj9nXhsBYt0O13AerPQdVoH4ctqLYVVemaRiw/5hjYV4KGHuBBJDVUn764lRWVLTVrn9
 I1XmUF7VjpYkMj69QmvuVWq2SH9J86c7DoBPTsvhm+jnuIpGgHXpSAv4Lxn1jCzcqAnQtT1Wtsj
 nHP3/4jYzPx4uftHyuLbcVY2hdrDEZmCqB1MR+NSI/12asuT8+6iz3aZ1CejZmkYpC3UTRBOnfT
 uRisExq MWP+8iwA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct ath10k_ce_ring.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Kalle Valo <kvalo@kernel.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: ath10k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/wireless/ath/ath10k/ce.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/ce.h b/drivers/net/wireless/ath/ath10k/ce.h
index 666ce384a1d8..27367bd64e95 100644
--- a/drivers/net/wireless/ath/ath10k/ce.h
+++ b/drivers/net/wireless/ath/ath10k/ce.h
@@ -110,7 +110,7 @@ struct ath10k_ce_ring {
 	struct ce_desc_64 *shadow_base;
 
 	/* keep last */
-	void *per_transfer_context[];
+	void *per_transfer_context[] __counted_by(nentries);
 };
 
 struct ath10k_ce_pipe {
-- 
2.34.1

