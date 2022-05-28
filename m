Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3FC536D45
	for <lists+linux-wireless@lfdr.de>; Sat, 28 May 2022 16:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236437AbiE1OZ6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 28 May 2022 10:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236354AbiE1OZz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 28 May 2022 10:25:55 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B8418365
        for <linux-wireless@vger.kernel.org>; Sat, 28 May 2022 07:25:54 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id h11so8498187eda.8
        for <linux-wireless@vger.kernel.org>; Sat, 28 May 2022 07:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KbxWDlL+f31Iv4yXrvS4EjbF/ghfF72fs8lCTuVNEck=;
        b=bxjjLNS6XZw7QGXX5R+4Jf0lwNKpUqVRrxJataQlYji7m3EUis/wMQhmoW9bglan4M
         /UZSk+W3vUM/S67Fhk7RW5yi+n2BqJbUXg8teg7fS3l5g9iz++mQrbkhMrE6B3WobQjh
         MxDcYq2y+JktasQOXhELvnDKsTSInvOj8y9liVQ/A8mEcwo+uoGLs2QeR2pFpS2ZOjgd
         tZ3bd8zIvOFwX6luOaC6dF5JP/xKFh0afLaSN/F7EArwrmfg2XQSEjgcYfe74Ozi7s6b
         NOZpkaALfL8C3ZXOQpRuIhNnTYKfZ7s2c3bI41TczZtNpK/5bccbv7+3gs03ymeD1o8o
         lExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KbxWDlL+f31Iv4yXrvS4EjbF/ghfF72fs8lCTuVNEck=;
        b=6TBNwjhk4iKbgJFe59C3xG9n5osxxsZE+AjO7gfxdmrcl6f7Uj7523/Q3Gyhh0C6tA
         40R1JdNaUPU7/ohrSsmtRz1MdfrTHafTAHrza0PpT12RBs547Y00JdM9yes56jvjxhuU
         9GvBcYrDETzgpwfJV142RsfUT7AjKYjWMMLZl8DbADvBg4rHknmlFzU7W2Pw7Bfn0etM
         yb7cbt4XIPDVfxR6ZaQfHa3a3Qf3ZWjCm2V8M6or1y1vEYkFo4mqIidgAbGfQ/qR3mer
         HkbALXkzW/2LTLdBFQYeqAZfjCDcu8ibuEV4bTSy1CroCCg5foPQA0eToMDyr4fF0xbu
         A4Gg==
X-Gm-Message-State: AOAM533NOICKGMt8nWamCacmD1G1qNKwwXX3HNvxhHU8XS93RuVnxfKz
        5bC7SoAfulq6LKtRh9sfc52aFQC3LPs=
X-Google-Smtp-Source: ABdhPJyfxT8XAzGJC0dKREtecTLuyCjugmGL4SpYp30E2dfWq45XCrO/Sz1dg8SdzdayCNAjoJVh6A==
X-Received: by 2002:a50:d0da:0:b0:42b:cfa8:f1ce with SMTP id g26-20020a50d0da000000b0042bcfa8f1cemr16534313edf.365.1653747953124;
        Sat, 28 May 2022 07:25:53 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id m3-20020a50d7c3000000b0042bc5e8f7fdsm3601915edj.16.2022.05.28.07.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 May 2022 07:25:52 -0700 (PDT)
From:   Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 2/2] ath11k: fix missing skb drop on htc_tx_completion error
Date:   Sat, 28 May 2022 16:25:16 +0200
Message-Id: <20220528142516.20819-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220528142516.20819-1-ansuelsmth@gmail.com>
References: <20220528142516.20819-1-ansuelsmth@gmail.com>
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

On htc_tx_completion error the skb is not dropped. This is wrong since
the completion_handler logic expect the skb to be consumed anyway even
when an error is triggerer. Not freeing the skb on error is a memory
leak since the skb won't be freed anywere else. Correctly free the
packet on eid >= ATH11K_HTC_EP_COUNT before returning.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-01208-QCAHKSWPL_SILICONZ-1

Fixes: f951380a6022 ("ath11k: Disabling credit flow for WMI path")
Signed-off-by: Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
---
 drivers/net/wireless/ath/ath11k/htc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/htc.c b/drivers/net/wireless/ath/ath11k/htc.c
index 069c29a4fac7..ca3aedc0252d 100644
--- a/drivers/net/wireless/ath/ath11k/htc.c
+++ b/drivers/net/wireless/ath/ath11k/htc.c
@@ -258,8 +258,10 @@ void ath11k_htc_tx_completion_handler(struct ath11k_base *ab,
 	u8 eid;
 
 	eid = ATH11K_SKB_CB(skb)->eid;
-	if (eid >= ATH11K_HTC_EP_COUNT)
+	if (eid >= ATH11K_HTC_EP_COUNT) {
+		dev_kfree_skb_any(skb);
 		return;
+	}
 
 	ep = &htc->endpoint[eid];
 	spin_lock_bh(&htc->tx_lock);
-- 
2.36.1

