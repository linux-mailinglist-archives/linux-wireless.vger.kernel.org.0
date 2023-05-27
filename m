Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D201713489
	for <lists+linux-wireless@lfdr.de>; Sat, 27 May 2023 13:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjE0LuN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 27 May 2023 07:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjE0LuM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 27 May 2023 07:50:12 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168C5F7
        for <linux-wireless@vger.kernel.org>; Sat, 27 May 2023 04:50:11 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso1468004a12.1
        for <linux-wireless@vger.kernel.org>; Sat, 27 May 2023 04:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685188210; x=1687780210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXw8XZVdNOPcAjRz/0ksdBOnEvtr+FAl6XnaaGA0FqA=;
        b=qnU1U4Tia0W/jiFHdhtio8Qto7cIKeuDCREeKPJRp9REWKDTdxkXxGc7QvVUKNznqL
         jGlMAIB0aR8LZZ+Lm92xJcNlBcSgES9zVB/lCuzfp+f4AaVuCAfkV9HVFrBxspJztIn/
         DQlc5ywSwNvA+zAobxauNRyvwz1x3D+vzD2dtX6KhORQlgE3a3MgRVQXQNoD01wnsWQN
         TWpySM31l7zn8L58oWuQonoIjkfW1VkZAZY6C7dYqYoJQ1VpHszBc7past/HTRo7ltye
         IrY9ju14YR2fFSpAQRdrvc7BTGRiMq4GRg8Js7nLf4F6FaOfXryj9qLHQ3qpu2ZYSIz7
         JLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685188210; x=1687780210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qXw8XZVdNOPcAjRz/0ksdBOnEvtr+FAl6XnaaGA0FqA=;
        b=XNWm83dxMDNTtavMbbrUMBK69h7qsWJQwG/sVNxbnIh9ptt/4qDmOX04nlvc5MHft7
         pLUUwZLC0/XFAXF3LoPWHe7PS6LV1zZFjnL4ho5cTmNkkJM5J/hdfkA+24BMj5+OJ1QO
         AKbb7jbjZw5ojcIbxtZre5RCbA35LX6NproImdXQ08YoJ73JhQAAUr9pz+sKeR4FAuaT
         QfaI7rfY7K7Z1f0sHz+lKKVwbrYMi/TRMZgMsq6Lq+Ml7FgBi30mgn3JUeJlBx+3zmhd
         kjwuIXPijHyjs9Pgw+5ENE7VWPsDQ23BkqDxjowSvsgRPrNKreeEX6FLV4J6nRVn02At
         A3ww==
X-Gm-Message-State: AC+VfDybmkn7mKcRE9N6swUZBLZ0SpMYipgt7scdltZWeiAhh4O0+uQd
        cpPzmXgxZsXfYCvYoGe/0b0=
X-Google-Smtp-Source: ACHHUZ5IchJXomC4nTxx3xf7kOsfV0nWJmzLkfnrVr7qgg/SQYmAQc1G0vYMasppBOsQ8M2Ut+kyLQ==
X-Received: by 2002:a17:902:bb98:b0:1aa:d545:462e with SMTP id m24-20020a170902bb9800b001aad545462emr5089102pls.13.1685188210402;
        Sat, 27 May 2023 04:50:10 -0700 (PDT)
Received: from 6-0-u2204.. ([182.209.58.11])
        by smtp.gmail.com with ESMTPSA id t13-20020a1709028c8d00b001ac741dfd29sm4723163plo.295.2023.05.27.04.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 May 2023 04:50:10 -0700 (PDT)
From:   Juhee Kang <claudiajkang@gmail.com>
To:     aspriel@gmail.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, kvalo@kernel.org,
        linux-wireless@vger.kernel.org, pkshih@realtek.com
Cc:     brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com,
        Juhee Kang <claudiajkang@gmail.com>
Subject: [PATCH wireless-next 2/2] brcmutil: use helper function pktq_empty() instead of open code
Date:   Sat, 27 May 2023 20:49:54 +0900
Message-Id: <20230527114954.3281-2-claudiajkang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230527114954.3281-1-claudiajkang@gmail.com>
References: <20230527114954.3281-1-claudiajkang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

pktq_empty was added in commit 5b435de0d786 ("net: wireless: add brcm80211
drivers") but it is currently not being utilized in some areas. This commit
replaces the open code with the pktq_empty() function.

Signed-off-by: Juhee Kang <claudiajkang@gmail.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmutil/utils.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmutil/utils.c b/drivers/net/wireless/broadcom/brcm80211/brcmutil/utils.c
index e87e68cc46e2..fe94db0ba3f3 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmutil/utils.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmutil/utils.c
@@ -186,7 +186,7 @@ struct sk_buff *brcmu_pktq_peek_tail(struct pktq *pq, int *prec_out)
 {
 	int prec;
 
-	if (pq->len == 0)
+	if (pktq_empty(pq))
 		return NULL;
 
 	for (prec = 0; prec < pq->hi_prec; prec++)
@@ -223,7 +223,7 @@ struct sk_buff *brcmu_pktq_mdeq(struct pktq *pq, uint prec_bmp,
 	struct sk_buff *p;
 	int prec;
 
-	if (pq->len == 0)
+	if (pktq_empty(pq))
 		return NULL;
 
 	while ((prec = pq->hi_prec) > 0 &&
-- 
2.34.1

