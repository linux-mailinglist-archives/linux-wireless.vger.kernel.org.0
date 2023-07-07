Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801C574B33F
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jul 2023 16:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbjGGOsv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Jul 2023 10:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjGGOsu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Jul 2023 10:48:50 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8C31FD7
        for <linux-wireless@vger.kernel.org>; Fri,  7 Jul 2023 07:48:49 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fbc587febfso20336325e9.2
        for <linux-wireless@vger.kernel.org>; Fri, 07 Jul 2023 07:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citymesh.com; s=google; t=1688741328; x=1691333328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t+W5Rk/cflPgn8rvKwsUFWa9ozTvPv5RDoKQhBnj0NU=;
        b=fh6I6PVGfEWTCmtBtEXQigMl02oCyAtyMRC5//VFJwlLnWSmEJD9Sc8lFBziaNWKTp
         G2wV46Kqjl30qwBJF32T4LYKixu0mhryRO0EzqIu0PAj+g4j3bOanvvbHIYpjNhwg3wx
         z/WS0VKsbgMHHBlW6buZe2GncW7xggLHPVZMFJKtGNiJfxAwGsJU6jI4jefuU7ulwGIU
         RaeVf+Nu4D3jv8huZExjcxZTw2H5QFwq26XlixnuzgDXhUPR4U1xTOnwdeQ/MFgh4/sw
         hz+GcZE0OLOzPQPDmFEmQNBem5xN2v/QPrK8NkaumyCLu6UbbkbyyLlBOuzV+0PZduVA
         Kipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688741328; x=1691333328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t+W5Rk/cflPgn8rvKwsUFWa9ozTvPv5RDoKQhBnj0NU=;
        b=DBqSKq2wWOhux4wrVdHkxqQdsX8lkeKxwWa5+9h5JdHRK8Zq4MtK+Z1HsV799FCS/S
         Y295+KA2S2c7AZAn0thwYv6EXvhDUs7X/KANCF/3ljx22JAhhnv5e5w5FVWYEkZgxjex
         8+J2uGvIpI4SQ6QOcsBANweSvpG5rbQ2DQ9DHLzrMFWRs/xrIcWGCxlToRety4E6vm1M
         jDJ5OMGHhPotatjx0cSKv+6EEZcFmxtI7mQujc/aixfnp/9nWmS61XqbPSozZKoig6f0
         DNOnjHk8TKcCmqPeWjPdd3QCzC8fpNZDX1zvdfaheZz4+dydC21PDwe9eqecfnw3argx
         qjoQ==
X-Gm-Message-State: ABy/qLa41HOhRq8GWHlUAdVCkus7Jv/baaa/lVUr10FuV8QEQhw8QaQu
        0OlQYRh0FRd2ZG3JgHG1IJ7N1qd45nOqjFZqHSs=
X-Google-Smtp-Source: APBJJlGUX3NLfI3L/Ivtwo/OK9/J3WRQLaRszpIZBYtRioaTmjOqlglXhSwq/jotIbbUCdDrXBzXEA==
X-Received: by 2002:a5d:5942:0:b0:313:ef57:5bde with SMTP id e2-20020a5d5942000000b00313ef575bdemr3988161wri.42.1688741328268;
        Fri, 07 Jul 2023 07:48:48 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:4ca:30f::4e:5f])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d4d0d000000b002fb60c7995esm4662830wrt.8.2023.07.07.07.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 07:48:48 -0700 (PDT)
From:   Koen Vandeputte <koen.vandeputte@citymesh.com>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net,
        Koen Vandeputte <koen.vandeputte@citymesh.com>
Subject: [PATCH] iw: fix attribute size mismatch
Date:   Fri,  7 Jul 2023 16:48:26 +0200
Message-Id: <20230707144826.3043151-1-koen.vandeputte@citymesh.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

NL80211_ATTR_MAX_AP_ASSOC_STA gets packed as u32 in the kernel.
Change the receiving side to match this, or it will be wrong
on big-endian.

Signed-off-by: Koen Vandeputte <koen.vandeputte@citymesh.com>
---
 info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/info.c b/info.c
index 364f9b3..4c5f463 100644
--- a/info.c
+++ b/info.c
@@ -879,7 +879,7 @@ broken_combination:
 
 	if (tb_msg[NL80211_ATTR_MAX_AP_ASSOC_STA])
 		printf("\tMaximum associated stations in AP mode: %u\n",
-		       nla_get_u16(tb_msg[NL80211_ATTR_MAX_AP_ASSOC_STA]));
+		       nla_get_u32(tb_msg[NL80211_ATTR_MAX_AP_ASSOC_STA]));
 
 	return NL_SKIP;
 }
-- 
2.34.1

