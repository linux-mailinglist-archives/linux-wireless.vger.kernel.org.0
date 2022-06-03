Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1E653C65B
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jun 2022 09:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242514AbiFCHfZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jun 2022 03:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242620AbiFCHfP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jun 2022 03:35:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A324338AB
        for <linux-wireless@vger.kernel.org>; Fri,  3 Jun 2022 00:35:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4DE0618F3
        for <linux-wireless@vger.kernel.org>; Fri,  3 Jun 2022 07:35:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78AFEC385A9;
        Fri,  3 Jun 2022 07:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654241713;
        bh=9RgZEj/aGukWMOOD7s+ViFEIX89kzK0VQUFSq29TzN4=;
        h=From:To:Cc:Subject:Date:From;
        b=oJwNILuTb9E5eh/dThPHVa7ATUct1Jr5mmWOkUKpHAEsslk6ttYgtC03kIrbJFbAE
         gHbcnn8yxletEK8gJNOmHrSZKX9vj+zICk2Z0HnV0CH1vTOTNC4+6lGY+EfghnPx/y
         ebyoe8zjg4xW/TKx0/R72MjGtnLMPINj0qq/dXd/LrelkYEdAAx/8tqcmLET1nL31L
         tPF1kSmww5EHkmMTE/5GlnwIVKZIq6uWaPUJ1MIjyuHadTAZtQRkAoDcJORSOeq4Zq
         9V3EcfVYFdxnwFzLS1h6FiRayDjtjCeXy27dW5i60hRuhu7De0QrwDv8xJ4hGWMIrg
         YaVplggsr09aw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: mt7921: add missing bh-disable around rx napi schedule
Date:   Fri,  3 Jun 2022 09:35:00 +0200
Message-Id: <e409d1226c837d609b80611a569ff3cf93b88093.1654241613.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

napi_schedule() can call __raise_softirq_irqoff(), which can perform
softirq handling, so it must not be called in a pure process context
with BH enabled.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index a630ddbf19e5..01ed779d3976 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1538,8 +1538,10 @@ void mt7921_pm_wake_work(struct work_struct *work)
 			mt76_connac_pm_dequeue_skbs(mphy, &dev->pm);
 			mt76_worker_schedule(&mdev->sdio.txrx_worker);
 		} else {
+			local_bh_disable();
 			mt76_for_each_q_rx(mdev, i)
 				napi_schedule(&mdev->napi[i]);
+			local_bh_enable();
 			mt76_connac_pm_dequeue_skbs(mphy, &dev->pm);
 			mt7921_mcu_tx_cleanup(dev);
 		}
-- 
2.35.3

