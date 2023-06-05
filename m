Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693417220D3
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jun 2023 10:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjFEIUy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Jun 2023 04:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjFEIUv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Jun 2023 04:20:51 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF148A9
        for <linux-wireless@vger.kernel.org>; Mon,  5 Jun 2023 01:20:47 -0700 (PDT)
X-UUID: d963a2e0037911eeb20a276fd37b9834-20230605
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=RZXEZCw31FaBhMKsyB3zJ9VlZt6/IvYCVkFUTILKzDs=;
        b=ctJSiUxkZW0VE9wXJ1W9EjS+tGZKr8agk9h92XVdYaQmBsE1JlRl7RUswAW3fnGei8RBQV5ifJXK5NmlsmpG3fXWNKSm8dh84YojNOJtR5YNMCxxXF4LSeeRsd8JPV3acRf886BxXEOH8OVWQFhPJBi9myBZi+vB6s2z95hm9I4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:17c390cf-0a2c-48de-a959-e3191adceecf,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:3d0b983d-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: d963a2e0037911eeb20a276fd37b9834-20230605
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1805934669; Mon, 05 Jun 2023 16:20:36 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.194) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 5 Jun 2023 16:20:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 5 Jun 2023 16:20:36 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v2 01/10] wifi: mt76: mt7996: move radio ctrl commands to proper functions
Date:   Mon, 5 Jun 2023 16:19:38 +0800
Message-ID: <20230605081947.12804-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move radio enable/disable commands into functions for configuring
per-phy radio.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 0975774fe244..8a1edc5c1288 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -43,6 +43,10 @@ int mt7996_run(struct ieee80211_hw *hw)
 	if (ret)
 		goto out;
 
+	ret = mt7996_mcu_set_radio_en(phy, true);
+	if (ret)
+		goto out;
+
 	ret = mt7996_mcu_set_chan_info(phy, UNI_CHANNEL_RX_PATH);
 	if (ret)
 		goto out;
@@ -82,6 +86,8 @@ static void mt7996_stop(struct ieee80211_hw *hw)
 
 	mutex_lock(&dev->mt76.mutex);
 
+	mt7996_mcu_set_radio_en(phy, false);
+
 	clear_bit(MT76_STATE_RUNNING, &phy->mt76->state);
 
 	mutex_unlock(&dev->mt76.mutex);
@@ -190,10 +196,6 @@ static int mt7996_add_interface(struct ieee80211_hw *hw,
 	if (ret)
 		goto out;
 
-	ret = mt7996_mcu_set_radio_en(phy, true);
-	if (ret)
-		goto out;
-
 	dev->mt76.vif_mask |= BIT_ULL(mvif->mt76.idx);
 	phy->omac_mask |= BIT_ULL(mvif->mt76.omac_idx);
 
@@ -253,7 +255,6 @@ static void mt7996_remove_interface(struct ieee80211_hw *hw,
 		phy->monitor_vif = NULL;
 
 	mt7996_mcu_add_dev_info(phy, vif, false);
-	mt7996_mcu_set_radio_en(phy, false);
 
 	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
 
-- 
2.39.2

