Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B28C6EE78B
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Apr 2023 20:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbjDYSch (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Apr 2023 14:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234503AbjDYScc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Apr 2023 14:32:32 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788ACCC19
        for <linux-wireless@vger.kernel.org>; Tue, 25 Apr 2023 11:32:28 -0700 (PDT)
X-UUID: 84dca9a8e39711eda9a90f0bb45854f4-20230426
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=s4FvWSqMiOBPOzhODz7wI+80TVwIjGjbEnBS1kGAvbo=;
        b=l8BaiqUj1e7cgLT5rXqEliiSHAUklFpAjYaZtWhiEliKOvsXjJ0yQdjRJVM6YjUthkninA0JCgTKgG8K5zm2Iz/4qEtM8LTccop1mr089EN4pAVPYfe3d+WkRNa61PPn/E05401kADU46NwoGFp0CmqxUW88wkUtRitlRPyqK48=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:02ec4e34-639a-4d13-ae01-3e59e2a5b8c0,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.22,REQID:02ec4e34-639a-4d13-ae01-3e59e2a5b8c0,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:120426c,CLOUDID:b6727ca2-8fcb-430b-954a-ba3f00fa94a5,B
        ulkID:230426023224SYFO5X4A,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 84dca9a8e39711eda9a90f0bb45854f4-20230426
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 418966747; Wed, 26 Apr 2023 02:32:22 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 26 Apr 2023 02:32:17 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Wed, 26 Apr 2023 02:32:17 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2 3/3] wifi: mt76: report non-binding skb tx rate when WED is active
Date:   Wed, 26 Apr 2023 02:32:15 +0800
Message-ID: <f03e33083a828466106da818fb0d9c1e074b418d.1682446940.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <8febf5d1f44e7f0b1e9f6ca099bd5ffcc8816f86.1682446940.git.ryder.lee@mediatek.com>
References: <8febf5d1f44e7f0b1e9f6ca099bd5ffcc8816f86.1682446940.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Peter Chiu <chui-hao.chiu@mediatek.com>

AQL relies on accurate tx rate reporting, so add this patch for
non-binding skb rate when WED is enabled.

Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/tx.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 99d395bd1bba..37337595c65d 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -269,8 +269,22 @@ void __mt76_tx_complete_skb(struct mt76_dev *dev, u16 wcid_idx, struct sk_buff *
 #endif
 
 	if (cb->pktid < MT_PACKET_ID_FIRST) {
+		struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+		struct ieee80211_rate_status rs = {};
+
 		hw = mt76_tx_status_get_hw(dev, skb);
 		status.sta = wcid_to_sta(wcid);
+		if (mtk_wed_device_active(&dev->mmio.wed) &&
+		    (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS)) {
+			info->status.rates[0].idx = -1;
+			if (status.sta && (wcid->rate.flags || wcid->rate.legacy)) {
+				rs.rate_idx = wcid->rate;
+				status.rates = &rs;
+				status.n_rates = 1;
+			} else {
+				status.n_rates = 0;
+			}
+		}
 		spin_lock_bh(&dev->rx_lock);
 		ieee80211_tx_status_ext(hw, &status);
 		spin_unlock_bh(&dev->rx_lock);
-- 
2.18.0

