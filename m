Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437777C7931
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Oct 2023 00:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442942AbjJLWAp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Oct 2023 18:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234509AbjJLWAo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Oct 2023 18:00:44 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D86EBB
        for <linux-wireless@vger.kernel.org>; Thu, 12 Oct 2023 15:00:38 -0700 (PDT)
X-UUID: c283fcaa694a11ee8051498923ad61e6-20231013
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=6ccyMZ2isxwLAUk2a1F8G2q9GYk1tSWppfRXB7kYv7s=;
        b=NhDlzRF7CX2X4Hl7bioCYFE8QshZTNYGjKljhkR/tJmES2eog0EgKgmTxlGo5IFUwBUS08g1NMDi7MMtU7QpZnYuAqISpxqvEeZ1CGM5WkKqpLacoimP4uVHISyZfvW3LglcML/1M/9JEVFnwdN4hA1Nu977SpiX2iP5iFByyvo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:3658a628-f091-43bf-8c52-5b3f38730e87,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:84090fc4-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c283fcaa694a11ee8051498923ad61e6-20231013
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yi-chia.hsieh@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 116371094; Fri, 13 Oct 2023 06:00:30 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 13 Oct 2023 06:00:29 +0800
Received: from mussdccf250.mussds.eus.mediatek.inc (10.73.250.250) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 13 Oct 2023 06:00:27 +0800
From:   Yi-Chia Hsieh <yi-chia.hsieh@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes.berg@intel.com>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Money Wang <money.wang@mediatek.com>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        Benjamin Lin <benjamin-jw.lin@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Yi-Chia Hsieh <yi-chia.hsieh@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7996: fix uninitialized variable in parsing txfree
Date:   Thu, 12 Oct 2023 15:00:26 -0700
Message-ID: <e6c9a6fdeeaa57d73560c895046da4a58983297d.1697146767.git.yi-chia.hsieh@mediatek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the uninitialized variable warning in mt7996_mac_tx_free.

Fixes: 2461599f835e: "wifi: mt76: mt7996: get tx_retries and tx_failed from txfree"
Signed-off-by: Yi-Chia Hsieh <yi-chia.hsieh@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 04540833485f..59ab07b89087 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1074,7 +1074,7 @@ mt7996_mac_tx_free(struct mt7996_dev *dev, void *data, int len)
 	struct mt76_phy *phy3 = mdev->phys[MT_BAND2];
 	struct mt76_txwi_cache *txwi;
 	struct ieee80211_sta *sta = NULL;
-	struct mt76_wcid *wcid;
+	struct mt76_wcid *wcid = NULL;
 	LIST_HEAD(free_list);
 	struct sk_buff *skb, *tmp;
 	void *end = data + len;
-- 
2.39.0

