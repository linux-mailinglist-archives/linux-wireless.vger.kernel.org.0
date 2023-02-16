Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0EA69941E
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Feb 2023 13:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjBPMQY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Feb 2023 07:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjBPMQX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Feb 2023 07:16:23 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1036F61BE;
        Thu, 16 Feb 2023 04:16:21 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id dr8so4582022ejc.12;
        Thu, 16 Feb 2023 04:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RqeJJOsnrA8Tc9BGMHN4R0KwaZi2oQ8E4MJIKs4Vwbo=;
        b=gGX9Fyw9ju9wEBdTNG696E1urvTcmbdcGp6aTYePM2xZ6EVc12+g+Rqu14lO8J3+S1
         3CqXrF/iuyfyvIB/WjVoguEKWYrzAE2Sx9X+qFp+Ey/IFQkVuoCWN4pVyHaBH/MQDZ8B
         2OnnRiDO72QKoWZ/8qemwwdf+5vHzprMywKbLZzTLkgv0tuDo5VfeMXZIbTB3RfTpNSD
         pc9eAyP7RLSaKgmyS5IHuCbT0K116VkEVS8By89nYBHCBj84jLAKzUWXxUQUUHro1ezo
         Ot1UjXpobo34rGeXslaJ/RPlUJJ8ruWhFThJbntltvwxT887sH+azLr4+oiq+hbVBrWw
         qFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RqeJJOsnrA8Tc9BGMHN4R0KwaZi2oQ8E4MJIKs4Vwbo=;
        b=BCmsUbu3O9ecG5IBLbwxcudU0riAzTSZJMzpC13EjyirrvBqIpmd7piIBCEiUq4g1R
         yldVQZVfBFAsAYTZL5SjxqIsbcp5V6ZDH86YqpMBiPCbJ5TRdWi5mtsFIeWaWutQb5mN
         oeTg847Eh9GUQDedVCMI6HdNgf81iqhxPIGyTdnkJH7XTUAUAf1jOIm92Hrz8cTClFaI
         98j/SEcJHY/Nn9Z4QqHPtDdzaW+i13xj+QmDQfrV4+ofTEA2SU7MqRwAZ7N7OnNgz6rY
         oycbnjs6Aau4RqRh9cJ04ozXwU6g+FCjDIxBMZU9+Oq//jbvyOtLYMyA6bV1whoDoPbR
         gO8A==
X-Gm-Message-State: AO0yUKWWaUY62SYH4ZGgsYi4TADLba6X3kl+LFjJralmzCkgv8qgS3rD
        El1fthceLDUwZ29VyBk4mBY=
X-Google-Smtp-Source: AK7set9a2dzMneXv10tWH6ZpgIkqcyr87yWBX4+qP0Q4BYfehU2A1yfYYGPygn5IFC9ufQYpC16ebA==
X-Received: by 2002:a17:906:b78c:b0:8b1:3d04:c2da with SMTP id dt12-20020a170906b78c00b008b13d04c2damr7048553ejb.45.1676549779465;
        Thu, 16 Feb 2023 04:16:19 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id g23-20020a170906539700b008b128106fc7sm744064ejo.46.2023.02.16.04.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 04:16:19 -0800 (PST)
Date:   Thu, 16 Feb 2023 15:16:14 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Kalle Valo <quic_kvalo@quicinc.com>
Cc:     P Praneesh <quic_ppranees@quicinc.com>,
        Bhagavathi Perumal S <quic_bperumal@quicinc.com>,
        Wen Gong <quic_wgong@quicinc.com>,
        Balamurugan Selvarajan <quic_bselvara@quicinc.com>,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] wifi: ath12k: use kfree_skb() instead of kfree()
Message-ID: <Y+4ejiYakhEvEw7c@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sk_buffs are supposed to be freed with kfree_skb().

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/net/wireless/ath/ath12k/dp_tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index 95294f35155c..fd8d850f9818 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -270,7 +270,7 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_vif *arvif,
 					  skb_ext_desc->len, DMA_TO_DEVICE);
 		ret = dma_mapping_error(ab->dev, ti.paddr);
 		if (ret) {
-			kfree(skb_ext_desc);
+			kfree_skb(skb_ext_desc);
 			goto fail_unmap_dma;
 		}
 
-- 
2.39.1

