Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A4453BF27
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jun 2022 21:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238919AbiFBTwS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Jun 2022 15:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238037AbiFBTwN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Jun 2022 15:52:13 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1051FA66
        for <linux-wireless@vger.kernel.org>; Thu,  2 Jun 2022 12:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Zd4F+BvxvpoWw0E7dWqQSZOT7syxj2Njz3KGiWilgu8=; b=EWlO84wxv6wNDR+5xixkhoU0a9
        9CbUl6aML+ZxGKBIbVAdJnNQQM7XjNISQuV/nJrxJKgSSQS87emullYTI3I6rrGezJryCcs8bP/n0
        6e9sQDLZB78zEg9J/ZKZPZx9tesq1g/PBysBHA/hj7QpHCgPIkXpPgbz2feOYGHRg4YY=;
Received: from p200300daa70ef200058bb5d56adcce0c.dip0.t-ipconnect.de ([2003:da:a70e:f200:58b:b5d5:6adc:ce0c] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nwqrY-0004yp-AJ
        for linux-wireless@vger.kernel.org; Thu, 02 Jun 2022 21:52:08 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/2] mt76: mt7915: add missing bh-disable around tx napi enable/schedule
Date:   Thu,  2 Jun 2022 21:52:05 +0200
Message-Id: <20220602195206.31061-1-nbd@nbd.name>
X-Mailer: git-send-email 2.36.1
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
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 27b3080469a1..00d670fa26c9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -2183,8 +2183,10 @@ void mt7915_mac_reset_work(struct work_struct *work)
 
 	mt76_worker_enable(&dev->mt76.tx_worker);
 
+	local_bh_disable();
 	napi_enable(&dev->mt76.tx_napi);
 	napi_schedule(&dev->mt76.tx_napi);
+	local_bh_enable();
 
 	ieee80211_wake_queues(mt76_hw(dev));
 	if (ext_phy)
-- 
2.36.1

