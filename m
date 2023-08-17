Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB62677FFA2
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Aug 2023 23:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355242AbjHQVPv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Aug 2023 17:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355214AbjHQVPj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Aug 2023 17:15:39 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A44359C
        for <linux-wireless@vger.kernel.org>; Thu, 17 Aug 2023 14:15:37 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-564cd28d48dso241381a12.0
        for <linux-wireless@vger.kernel.org>; Thu, 17 Aug 2023 14:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692306937; x=1692911737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phUiJ93OG5fT2HQgeI0x27DBfVFvmCA05DOo5t8M3F0=;
        b=m13GfLSVElpoUlkc8XTfd2EAm/nFZIAFv5nYubhdAXg39AjnARc8PDqRRwhZ7nFuMl
         THmkcqR9SondynXpKqbAIqxO5ImaGw85uLzxTZpc/SMsVg7BpStQ00iERACf6w/Uaz1H
         +HeZJOIfHkfhzg2I/Y98/HcqNNILtGguIkQO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692306937; x=1692911737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phUiJ93OG5fT2HQgeI0x27DBfVFvmCA05DOo5t8M3F0=;
        b=YsSc0eijLnJdWg9oW9v9jw3jupWJ03eA9G5jnr/xRjUtYcYR08YjP08994H1OQpRxl
         vHfRT52ZiGQNY3smVJfRoY/38fn4fyXaQHMRmS9of26G8AM/FK3zGJ4NqxpISu8t4D5J
         xKo8k8hvlat5Xfz5lZ+sS6gGlHJbUsd/9bWIuNZTmzNTWczRw6kPgI4yc68KCXLwNzfz
         HZueQlcwY2BD2qn7yvA0OaDwkoVz4JIs8g0dw9zbZDoOn6VQP/EVzSh22twNHg5lY1p2
         CMWcnz4lb1AaoEI8oKlvEu8vZrg3wu7igJT3y3JwNZjufw8UD+wSXxYtBYuVBkiKiyMq
         PEpw==
X-Gm-Message-State: AOJu0Yw5JvwuoFBRCcg/8Kad7xhdAuKnEg8VpgnFINX4A/RnLM6CP7Dk
        x8lAqHBwN1/9OjH2Gq36AIWiVQ==
X-Google-Smtp-Source: AGHT+IF7s+IU/lIpVVTRfA7A1qbIsiivth3Da3IhciHPIQm6pnVUAKXy1L3JsiXrPdjKSQOIbfeQaw==
X-Received: by 2002:a05:6a20:4420:b0:131:f504:a631 with SMTP id ce32-20020a056a20442000b00131f504a631mr1181516pzb.51.1692306937174;
        Thu, 17 Aug 2023 14:15:37 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m18-20020aa78a12000000b00688701c3941sm197317pfa.111.2023.08.17.14.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 14:15:35 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH 7/7] wifi: cfg80211: Annotate struct cfg80211_tid_config with __counted_by
Date:   Thu, 17 Aug 2023 14:15:29 -0700
Message-Id: <20230817211531.4193219-7-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817211114.never.208-kees@kernel.org>
References: <20230817211114.never.208-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1303; i=keescook@chromium.org;
 h=from:subject; bh=MqZgW0ZDJW9VKg5I69oHRlFrW/5s/bnzmd4geiRSuSA=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk3o3x/34xyuHIsFO373KwVl2QODEFDIBSLz76F
 4mS/Sq+pMaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZN6N8QAKCRCJcvTf3G3A
 JjEZEACO9GxRQKT9xf9tZlwDCcN6atAAOa0htPWNOoIsLNtvxWAYtKhtG8g1/ekxWwGhQF37YHo
 lJovHZ60rO+krmpUaxkVL5JglO/98U8OFfCt+Zm/XtjpwhrYgCk1rH4rBxQ05BFwiu3jDUK1rPx
 wrSqHb65i6piGqoNBN2P6KBm8E8+V25p2xE4fvwzJ/suiSSZoEWuK6HZYe6BIcIwQPAdT4JS1tW
 r8OEsiBL0pGU7Fnho3C2Qy1AuT42bVUTaS1PBVVDy830zM3Y39TqW7pWAD/N7mMNL36SVXXb/VY
 ujNzAglxUWExKIpLT5YouRtrrf7XBrJkOsZ9qEkj4JKqF9/iyQxhSopHsPuoOS8+cW8thVGuBDH
 z3scez2jr1rzzA1hPNKfOsmFMmJVIsQvgMERacrkLUXcnjkDdo9jsTn1zASB7NMYY4r4UjPz9cT
 m/vMQZpwV7/p9uZBhyBJrutEDl3b+ExnXiwukaJGKBRvhNznOEXbA9snzl3Vmjgijs4eELKywMM
 gfc4VntArWeYXia3LhmT2zLetKC0mrOBm/hHBTy6htJ0tG8Qkf+mYREzDm61HGSTZlDo6mwUzFk
 S88K7vNOHe5KjZ3/wUHPkbS28drKdo2jeZCveIDDJ0wNjY+Ih9FEGvjYYD8KY1lR5ZUMnQt6ovl gwCSNjN0bl2WPLQ==
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

As found with Coccinelle[1], add __counted_by for struct cfg80211_tid_config.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/net/cfg80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index a2afc94a5408..423fe9b85cb0 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -811,7 +811,7 @@ struct cfg80211_tid_cfg {
 struct cfg80211_tid_config {
 	const u8 *peer;
 	u32 n_tid_conf;
-	struct cfg80211_tid_cfg tid_conf[];
+	struct cfg80211_tid_cfg tid_conf[] __counted_by(n_tid_conf);
 };
 
 /**
-- 
2.34.1

