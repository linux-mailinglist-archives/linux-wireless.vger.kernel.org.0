Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2FE6C022F
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Mar 2023 14:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjCSNza (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Mar 2023 09:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjCSNz2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Mar 2023 09:55:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11464C17D
        for <linux-wireless@vger.kernel.org>; Sun, 19 Mar 2023 06:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679234079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SE+hbc2PpdOm6jFmUnfn7gxJd8fzcxI50vFrTMNLyGw=;
        b=EFBVyo3t042lQ0SJqmg8vRLVYth0htRjbboZFg72pcjPykgB4MW0qomrGA9mzdOiCArFEB
        ES/WsW1unnbkNAmW8KPKRgfMwvmrBJyEKTL9BDibeu/RIZrS6y6RY8t+BUlvjrcuH3AYlR
        1BkDsiXspK6hbMT16gfSjdFlWeFhFJc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-oGaAvZQQMyKPQYqzFDq-Gw-1; Sun, 19 Mar 2023 09:54:35 -0400
X-MC-Unique: oGaAvZQQMyKPQYqzFDq-Gw-1
Received: by mail-qv1-f69.google.com with SMTP id pr2-20020a056214140200b005b3ed9328a3so4892857qvb.10
        for <linux-wireless@vger.kernel.org>; Sun, 19 Mar 2023 06:54:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679234075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SE+hbc2PpdOm6jFmUnfn7gxJd8fzcxI50vFrTMNLyGw=;
        b=kCt9MXzR1nmd4mEBKHI4n42+/YSkw3cPIz1TjyVtFK5XTXsV+nJG7Y9607RdVzCrDL
         J1RfGYu0hMn+lr4mkQsBO165gpeCVoXIoVHyJ5CS/iMSkBj/GtsU2oGE8x9LAZVeRb0r
         NY2kCoMxyWKvNmJINoySuafZYiPVTVM94uqSIVvi49IBrwi9kFYDlRdLv0Wk3CUNw3oE
         Wr/w5jetIpWL/TZg7DmUzRYMDsDes2MzpalttHjsKyc88VbltQsYld0GnqQPyLhW0fHI
         4g5K2CROm3t06MV0N496DCFz0/M6IvyjoZMupnqNgndZVcnB1jDDuHmJabhCxIyi5rYn
         fmWg==
X-Gm-Message-State: AO0yUKX0hjPYCtd5vnA8JDG/5XGlwo8wgW39qnXoqMICNeiCEab0J8AT
        stUy/ixTNNs7VZbNSjucb+wjL4iaJdFEHErjgLdLar5FPf3/vTWM2+6hPIvk+JCnrqDQu5j4pq9
        +yVfQe3mvS5mUNSe5VbvUYKaWD8o=
X-Received: by 2002:a05:622a:1387:b0:3bf:daae:7ee6 with SMTP id o7-20020a05622a138700b003bfdaae7ee6mr22103392qtk.18.1679234075269;
        Sun, 19 Mar 2023 06:54:35 -0700 (PDT)
X-Google-Smtp-Source: AK7set/SUf1dS9D3NGgKWgB9272dqTQaCIgVClcOcHUMHiPQbfT/rPxkVqzfjAoOoL29N2AJV31JPQ==
X-Received: by 2002:a05:622a:1387:b0:3bf:daae:7ee6 with SMTP id o7-20020a05622a138700b003bfdaae7ee6mr22103366qtk.18.1679234075026;
        Sun, 19 Mar 2023 06:54:35 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id x26-20020ac86b5a000000b003bfa2c512e6sm4859344qts.20.2023.03.19.06.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 06:54:34 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     stas.yakovlev@gmail.com, kvalo@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] ipw2x00: remove unused _ipw_read16 function
Date:   Sun, 19 Mar 2023 09:54:18 -0400
Message-Id: <20230319135418.1703380-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

clang with W=1 reports
drivers/net/wireless/intel/ipw2x00/ipw2200.c:381:19: error:
  unused function '_ipw_read16' [-Werror,-Wunused-function]
static inline u16 _ipw_read16(struct ipw_priv *ipw, unsigned long ofs)
                  ^
This function and its wrapping marco are not used, so remove them.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/wireless/intel/ipw2x00/ipw2200.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2200.c b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
index b91b1a2d0be7..dfe0f74369e6 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2200.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
@@ -377,19 +377,6 @@ static inline u8 _ipw_read8(struct ipw_priv *ipw, unsigned long ofs)
 	_ipw_read8(ipw, ofs); \
 })
 
-/* 16-bit direct read (low 4K) */
-static inline u16 _ipw_read16(struct ipw_priv *ipw, unsigned long ofs)
-{
-	return readw(ipw->hw_base + ofs);
-}
-
-/* alias to 16-bit direct read (low 4K of SRAM/regs), with debug wrapper */
-#define ipw_read16(ipw, ofs) ({ \
-	IPW_DEBUG_IO("%s %d: read_direct16(0x%08X)\n", __FILE__, __LINE__, \
-			(u32)(ofs)); \
-	_ipw_read16(ipw, ofs); \
-})
-
 /* 32-bit direct read (low 4K) */
 static inline u32 _ipw_read32(struct ipw_priv *ipw, unsigned long ofs)
 {
-- 
2.27.0

