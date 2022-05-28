Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9177536D46
	for <lists+linux-wireless@lfdr.de>; Sat, 28 May 2022 16:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236490AbiE1OZ6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 28 May 2022 10:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235857AbiE1OZz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 28 May 2022 10:25:55 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22861834B
        for <linux-wireless@vger.kernel.org>; Sat, 28 May 2022 07:25:53 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ck4so13389355ejb.8
        for <linux-wireless@vger.kernel.org>; Sat, 28 May 2022 07:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rhuLu/zc6OSTKdNFD0CtRWDuw0q1u1ps2N0Jk8WZLn8=;
        b=i5OtqQLUDHdTR+E/1nfw5rm0SWku8A2ArnSqQ5MjjVfEgdflXStu8Y5IxDokOjW33D
         QlrRLXuCgVl+2+6o3hbA6kEbWEuv2Qo+fAecaRwxgojMMJMLtgnm9o8pz4oNb6g3HKVt
         Uqt5UUwwT0IHLX0n6tNZZs+XyxWgwogTZfw1LwWFuVREg19Q/+OwuVRynsEl0BG2AKHS
         hmm1G8GupHgh3Pzu82gmDKH8xaetu1Vh/RGFPyu0F04baR9Zvq75I3MRDKj61TMPHVqE
         weffu4Glu1ZZ7hStiFx7/Ci6v9irO4LMJbUUyKIL/JdfB98VZ2tkz6uO6pzOjfBxtKZV
         i2oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rhuLu/zc6OSTKdNFD0CtRWDuw0q1u1ps2N0Jk8WZLn8=;
        b=BFdYg4sPESx0RjmMHXc254j+toY9wGA4T2W/lmmYqlGXQojrkF6n91Aoll3F2540br
         blgD6YR6v5ArHFlL1IB1dIG9c78H78+WbUa7o/fAsNaAXQz6sVixcPRmAlGSdv9ccz2K
         WvheFZ5nj8YTC9xHUiIeUnsIvAVmBth+5VxVTPKz3k7dJoSBkLHkahCZrLmnYXZuHzp8
         TZp89a2/NXG8OPDC0vQAAoOXfXXuMcR2Xnku1tRBFqRJ5VoIM57O6O6nCFOASr2NDutK
         Wd+WncSeXJGmObrdK9rqHM6y3/1BD/02eaZPXih3WSUyaVQnhtQNodHQv7OjbtpYwKNB
         qTZA==
X-Gm-Message-State: AOAM533AHp8xHXl+xnTYLkzO2CtI3TLu0qdVDA5ziwx5xkQ4u4yiKNBt
        8hiA/Y3n/eu2vsFQKAXZgBYjbmvEWaM=
X-Google-Smtp-Source: ABdhPJyRFIGi2kNZzGDKQk8oaZCc1Y0dRXWTC/qPVxQZeILkTHiFhlp0g4V8NR7jRAlh3uX77gXLSw==
X-Received: by 2002:a17:907:162a:b0:6fe:c691:47f5 with SMTP id hb42-20020a170907162a00b006fec69147f5mr30975173ejc.289.1653747952236;
        Sat, 28 May 2022 07:25:52 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id m3-20020a50d7c3000000b0042bc5e8f7fdsm3601915edj.16.2022.05.28.07.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 May 2022 07:25:51 -0700 (PDT)
From:   Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 1/2] ath11k: fix missing srng_access_end in CE
Date:   Sat, 28 May 2022 16:25:15 +0200
Message-Id: <20220528142516.20819-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
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

When a CE completed send next operation is done, the srng access end is
never called. Correctly end the srng access to make sure we have the
correct values in the srng struct.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-01208-QCAHKSWPL_SILICONZ-1

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Signed-off-by: Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
---
 drivers/net/wireless/ath/ath11k/ce.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/ce.c b/drivers/net/wireless/ath/ath11k/ce.c
index c14c51f38709..665205d2322e 100644
--- a/drivers/net/wireless/ath/ath11k/ce.c
+++ b/drivers/net/wireless/ath/ath11k/ce.c
@@ -490,6 +490,8 @@ static struct sk_buff *ath11k_ce_completed_send_next(struct ath11k_ce_pipe *pipe
 	pipe->src_ring->sw_index = sw_index;
 
 err_unlock:
+	ath11k_hal_srng_access_end(ab, srng);
+
 	spin_unlock_bh(&srng->lock);
 
 	spin_unlock_bh(&ab->ce.ce_lock);
-- 
2.36.1

