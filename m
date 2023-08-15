Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D9F77CAD0
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Aug 2023 11:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236280AbjHOJzV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Aug 2023 05:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236291AbjHOJy6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Aug 2023 05:54:58 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BDFE74
        for <linux-wireless@vger.kernel.org>; Tue, 15 Aug 2023 02:54:49 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-563e21a6011so3888861a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 15 Aug 2023 02:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692093289; x=1692698089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+6xZsxCJBj5ooqjMSycG2/e1rkomp2plIVyfULRs0gE=;
        b=PHhIzKaAUmWrdBFImrEd8NscMC9vk5M1uobmdvxBAu/+UiTPCCghwt1m6I7bUxAXQD
         FRbeAVl9tHo8Ztss82Ob0qYTelGtkdQTPOtlHvQxQKzxZEQocemiv3T7dC8mnc9v9iax
         sYPdlF6h/ikTqzVIdYc1FJv7q4FacJHfKIh6esXIEdgNJMEKUlsTiHq/yGRaIEiuRq0w
         M0tuO0DsnCV3x5d1eCfcKx9c6TdFL1ntu3R/jEMomIKHuUMWUNSbbSZ8YfaozgZRnYSy
         5LJDUjztCrg0GXCNIDEn6xDA7OPCan19sajUS90pfFnELJnYYV4XBirfGeCfrn/OAW/R
         aV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692093289; x=1692698089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+6xZsxCJBj5ooqjMSycG2/e1rkomp2plIVyfULRs0gE=;
        b=JYRSWgEanahcc0WqBMDGGwfyrG31nBQl1BMOS3THpCgxtGqhOExhChEVymOnuwMG1D
         9Nmvg9uUh8JPE4WvjXva9YhRVapVS9+15VD0wN8OVtJyaJOzhFI4/HvjXkvJZ1trOJWM
         YnOXbsOOWK9wtkoW3H6inhA/oNIlTdWV6a/9KYfmRFN+nrqgPT2bT+BQj51hCpFgJDi/
         zc4hCei//TZ8BSTFf2e93YDLLL2U9Axg8RLtTOQz/VGB3+aGBKuC6Q4rk80ZajTX9rvK
         bXigwnTftJ4hs8i6rksTxPm57m904FGGRrSTBjsTPLIvR/hW3HzYy0mQ7NE+z5pr4w0W
         yNmw==
X-Gm-Message-State: AOJu0YzcYQE2ijuLYaIgBav/xQvLO9Sh2ry36L2678YgXY5/iizEb7h+
        xMXNp3YGr7px01RfSN86kut3Plqlt/z/skjk
X-Google-Smtp-Source: AGHT+IEJIS2A427UsdOPqkwpGBWMrtfQ9kmEkPKQXETB64Sc6wWVnrxBHvZxutdWDfyNhtajoM+WgA==
X-Received: by 2002:a17:90b:1b45:b0:26b:7b4c:4c98 with SMTP id nv5-20020a17090b1b4500b0026b7b4c4c98mr623152pjb.40.1692093289126;
        Tue, 15 Aug 2023 02:54:49 -0700 (PDT)
Received: from localhost.localdomain ([180.217.112.72])
        by smtp.gmail.com with ESMTPSA id t14-20020a17090a950e00b0026b4d215627sm4019297pjo.21.2023.08.15.02.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 02:54:48 -0700 (PDT)
From:   EN-WEI WU <rickywu0421@gmail.com>
X-Google-Original-From: EN-WEI WU <enweiwu@FreeBSD.org>
To:     johannes@sipsolutions.net
Cc:     kvalo@kernel.org, linux-wireless@vger.kernel.org,
        enweiwu@FreeBSD.org
Subject: [PATCH] wifi: mac80211_hwsim: avoid calling nlmsg_free() in IRQ or IRQ disabled
Date:   Tue, 15 Aug 2023 17:54:27 +0800
Message-Id: <20230815095427.13589-1-enweiwu@FreeBSD.org>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The nlmsg_free() ends up calling kfree_skb(), and kfree_skb() is not allowed to be called
from hardware interrupt context or with hardware interrupts being disabled. Replace the
mistaken usage of nlmsg_free() by dev_kfree_skb_irq(), which is safe in both cases.

Signed-off-by: EN-WEI WU <enweiwu@FreeBSD.org>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index f446fd0e8cd0..678021cf4e57 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -6314,7 +6314,7 @@ static void hwsim_virtio_tx_done(struct virtqueue *vq)
 
 	spin_lock_irqsave(&hwsim_virtio_lock, flags);
 	while ((skb = virtqueue_get_buf(vq, &len)))
-		nlmsg_free(skb);
+		dev_kfree_skb_irq(skb);
 	spin_unlock_irqrestore(&hwsim_virtio_lock, flags);
 }
 
@@ -6383,14 +6383,14 @@ static void hwsim_virtio_rx_work(struct work_struct *work)
 
 	spin_lock_irqsave(&hwsim_virtio_lock, flags);
 	if (!hwsim_virtio_enabled) {
-		nlmsg_free(skb);
+		dev_kfree_skb_irq(skb);
 		goto out_unlock;
 	}
 	vq = hwsim_vqs[HWSIM_VQ_RX];
 	sg_init_one(sg, skb->head, skb_end_offset(skb));
 	err = virtqueue_add_inbuf(vq, sg, 1, skb, GFP_ATOMIC);
 	if (WARN(err, "virtqueue_add_inbuf returned %d\n", err))
-		nlmsg_free(skb);
+		dev_kfree_skb_irq(skb);
 	else
 		virtqueue_kick(vq);
 	schedule_work(&hwsim_virtio_rx);
-- 
2.37.1 (Apple Git-137.1)

