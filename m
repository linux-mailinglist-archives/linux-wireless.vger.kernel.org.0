Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27A27BC023
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Oct 2023 22:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbjJFURW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Oct 2023 16:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbjJFURU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Oct 2023 16:17:20 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5A0C5
        for <linux-wireless@vger.kernel.org>; Fri,  6 Oct 2023 13:17:18 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-690f7bf73ddso2058048b3a.2
        for <linux-wireless@vger.kernel.org>; Fri, 06 Oct 2023 13:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696623438; x=1697228238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pjnr6MIfdcujcCvyrDmadksDTc6dwprcRhGznzbOSQc=;
        b=Wu/6dDFXiktLOMH8+ROpJmA6IOMvxkZP8PTPmCP8rGOgTUdCsiCnErr0RtCEukIt7I
         TzpsIkjBDP69hgfVTjPRxRVGcfyP15Em0ddUvyUN+W8sQbp3QKZ7Rbt3iP2Z67BTzaqR
         MDdb1cvyeyh+1T0t8pJRpGfw9gGkEt715P9yQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696623438; x=1697228238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pjnr6MIfdcujcCvyrDmadksDTc6dwprcRhGznzbOSQc=;
        b=mt1s42HU+YuhewxBKGTLr4+hy1w2JxJsKXbrk9dnivFbJSNa++CUNzod0WCmBqD8dp
         gzR+muT1Ds8tsHwObZYCtYWA6C8qEAAtT/4PvnG18lfX2I/LBKn3a/K8LQsIx+ezgcAn
         nm1MKzT7vyA6Yh4mNehrYeNbKvM28awoVOWkR3QKVkyKc7EkA22404B/xeKotLQXJ7Or
         KnteMO25gDBR1zSohHdoyp4nus6NZPcOtxuKSpmMGWITEpLqrKtl7ZqfT7X6mdEXkI6O
         b7xCkt1sJZpLrianbaT2ZrUCJTvjtP2JcLP5HJ2uMDRvvCz8TsUJH5GJMVlwjrS/1/oE
         InLg==
X-Gm-Message-State: AOJu0YwpQ2GoFPOT/OhQbdkeIud5pNQYFL59JVqh7UoX22T54Bh0/Ffq
        CzEt3EsF8tssgCPRitPV6MZLaA==
X-Google-Smtp-Source: AGHT+IGhzG4GvBHXlZewAFuebmu7Hkj7yf8HoMy1nAAB2s5OGn1TAkAWTm0IKsfUQhnoYlxwPnQqsA==
X-Received: by 2002:a05:6a20:6a11:b0:15a:1817:c493 with SMTP id p17-20020a056a206a1100b0015a1817c493mr10463727pzk.39.1696623437921;
        Fri, 06 Oct 2023 13:17:17 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c9-20020aa78809000000b0068a13b0b300sm1951757pfo.11.2023.10.06.13.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 13:17:17 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kees Cook <keescook@chromium.org>, Kalle Valo <kvalo@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-wireless@vger.kernel.org, linux-hardening@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] wifi: rtw89: coex: Annotate struct rtw89_btc_btf_set_slot_table with __counted_by
Date:   Fri,  6 Oct 2023 13:17:15 -0700
Message-Id: <20231006201715.work.239-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1321; i=keescook@chromium.org;
 h=from:subject:message-id; bh=eu6W7wXw5RTTiD60SAAgUrQDRZxpZuc1EvwMJ2JgTAI=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlIGtLFrvUk7TV+fsu3RoZBXUeAY5BE45UBpI5o
 H04FXBoP4qJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZSBrSwAKCRCJcvTf3G3A
 JkN9D/9DbkQ9s24VTWKihPeasIWSlCASR9Q6UgMN2sh4QmgFMoBiZlxb12IObvOXPnLVlYdHbmX
 EVy9OcIWuPk43HGC3iU/j44eEHlpM/TqUYFwvguvhr8W3ZvbTF8lzfpmCs0SmJXhbFMBaZ5+mB2
 2qIy4G6fMNcmwLK4jH/1l5P8/Ls4R6xkfMqkDb4ibaFLM+VlsWnSEQYN7HIWR5ZiT8vPIHPAymc
 6mi+AVnfzirQ380CiVqi7z4Llsn8ZXvpBa7RbJc+XMfQlLESPt2LTk6gskIP+d/mAzribY7z7xF
 UJr/yeImzGyEY+MrWTNG64p3AhBR3uTee3rMN+6QU/hQu8A9ng7ddLD+J/uVZYdOdMXqpHIQD0T
 sKVockWMg/GUEvNzpsNb6ebVslSZXGRRCN7NKF8y7T3jNQKzxDO0dppZdThl+D9gjUNeILx4rqs
 UWb00OkZQK2gTdUSzsm3Qy9fwl0/nCa7nwaIT86096mOrdJx+kkV23p4fujH9DXzzzuKJIrZ63h
 2aXKuHw1/zaTlGRFHj0yAW1UVA487R9UVz+H/dDgCooswodM7cvImtDGZvKogqwPG2ICG7pepP2
 V75uq6CUWbyaJRKJxrdFTlZLJtnlcmkqDtyNWUN7zOI8kEGoDOLH5Ab4a73LxseCO2tTiBtgstk
 FLmAlOo dZguPuXA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct
rtw89_btc_btf_set_slot_table.

Cc: Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 4ba8b3df70ae..d66a1152c3f5 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -237,7 +237,7 @@ struct rtw89_btc_btf_set_report {
 struct rtw89_btc_btf_set_slot_table {
 	u8 fver;
 	u8 tbl_num;
-	u8 buf[];
+	u8 buf[] __counted_by(tbl_num);
 } __packed;
 
 struct rtw89_btc_btf_set_mon_reg {
-- 
2.34.1

