Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D7453BF26
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jun 2022 21:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238900AbiFBTwT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Jun 2022 15:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238383AbiFBTwN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Jun 2022 15:52:13 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9A21FCD1
        for <linux-wireless@vger.kernel.org>; Thu,  2 Jun 2022 12:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=wwg5Fn4ZR/f4m/a3Lub/EGiIHyASoRXB1ZgE5pTZGYw=; b=R1IxFxwK9dgnoOC4yhkUdPZC3J
        4SGRmb2/f3ibIN+76xZ4EVN5Uct/t3YhB7zmQLeDtKXEyz0/LxSvenYSbcPuPMIUSa/T7M3EUpJdw
        GMZFze0jociuTblOQKSsfA+GRQYeUz8k2kpkWimNAzIE1vJgJXEQhjQeL6t6HDYuBjYY=;
Received: from p200300daa70ef200058bb5d56adcce0c.dip0.t-ipconnect.de ([2003:da:a70e:f200:58b:b5d5:6adc:ce0c] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nwqrY-0004yp-H9
        for linux-wireless@vger.kernel.org; Thu, 02 Jun 2022 21:52:08 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/2] mt76: mt7615: add missing bh-disable around rx napi schedule
Date:   Thu,  2 Jun 2022 21:52:06 +0200
Message-Id: <20220602195206.31061-2-nbd@nbd.name>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220602195206.31061-1-nbd@nbd.name>
References: <20220602195206.31061-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

napi_schedule() can call __raise_softirq_irqoff(), which can perform softirq
handling, so it must not be called in a pure process context with BH enabled.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index bd687f7de628..f26213c4e64c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -2094,8 +2094,10 @@ void mt7615_pm_wake_work(struct work_struct *work)
 			mt76_connac_pm_dequeue_skbs(mphy, &dev->pm);
 			mt76_worker_schedule(&mdev->sdio.txrx_worker);
 		} else {
+			local_bh_disable();
 			mt76_for_each_q_rx(mdev, i)
 				napi_schedule(&mdev->napi[i]);
+			local_bh_enable();
 			mt76_connac_pm_dequeue_skbs(mphy, &dev->pm);
 			mt76_queue_tx_cleanup(dev, mdev->q_mcu[MT_MCUQ_WM],
 					      false);
-- 
2.36.1

