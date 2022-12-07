Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99115645CD1
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Dec 2022 15:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiLGOml (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Dec 2022 09:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiLGOmi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Dec 2022 09:42:38 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2587C2671
        for <linux-wireless@vger.kernel.org>; Wed,  7 Dec 2022 06:42:36 -0800 (PST)
Received: from dggpemm500007.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NS0KL5h9DzJp55;
        Wed,  7 Dec 2022 22:39:02 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 7 Dec
 2022 22:42:33 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <stf_xl@wp.pl>, <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <yangyingliang@huawei.com>
Subject: [PATCH] wifi: iwlegacy: common: don't call dev_kfree_skb() under spin_lock_irqsave()
Date:   Wed, 7 Dec 2022 22:40:13 +0800
Message-ID: <20221207144013.70210-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It is not allowed to call consume_skb() from hardware interrupt context
or with interrupts being disabled. So replace dev_kfree_skb() with
dev_consume_skb_irq() under spin_lock_irqsave(). Compile tested only.

Fixes: 4bc85c1324aa ("Revert "iwlwifi: split the drivers for agn and legacy devices 3945/4965"")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/net/wireless/intel/iwlegacy/common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/common.c b/drivers/net/wireless/intel/iwlegacy/common.c
index 341c17fe2af4..96002121bb8b 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.c
+++ b/drivers/net/wireless/intel/iwlegacy/common.c
@@ -5174,7 +5174,7 @@ il_mac_reset_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	memset(&il->current_ht_config, 0, sizeof(struct il_ht_config));
 
 	/* new association get rid of ibss beacon skb */
-	dev_kfree_skb(il->beacon_skb);
+	dev_consume_skb_irq(il->beacon_skb);
 	il->beacon_skb = NULL;
 	il->timestamp = 0;
 
@@ -5293,7 +5293,7 @@ il_beacon_update(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	}
 
 	spin_lock_irqsave(&il->lock, flags);
-	dev_kfree_skb(il->beacon_skb);
+	dev_consume_skb_irq(il->beacon_skb);
 	il->beacon_skb = skb;
 
 	timestamp = ((struct ieee80211_mgmt *)skb->data)->u.beacon.timestamp;
-- 
2.25.1

