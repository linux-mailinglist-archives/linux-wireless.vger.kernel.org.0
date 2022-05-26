Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01AFB534C4E
	for <lists+linux-wireless@lfdr.de>; Thu, 26 May 2022 11:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346840AbiEZJJK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 May 2022 05:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346848AbiEZJJH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 May 2022 05:09:07 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEC1C6E60
        for <linux-wireless@vger.kernel.org>; Thu, 26 May 2022 02:09:04 -0700 (PDT)
X-UUID: 09f30c726dec4624952532b31b8c1c95-20220526
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:704cbe87-2e61-4fd4-b61b-8ecf7b671e68,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:e8d59147-4fb1-496b-8f1d-39e733fed1ea,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: 09f30c726dec4624952532b31b8c1c95-20220526
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 137534923; Thu, 26 May 2022 17:08:57 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 26 May 2022 17:08:56 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 26 May 2022 17:08:55 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 26 May 2022 17:08:56 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     <linux-wireless@vger.kernel.org>
CC:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        "Ryder Lee" <ryder.lee@mediatek.com>
Subject: [PATCH] mac80211: check skb_shared in ieee80211_8023_xmit()
Date:   Thu, 26 May 2022 17:08:53 +0800
Message-ID: <1ef9b892cc93a36b1e62a6dda0e2e0a019f4e5f7.1653555361.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add missing skb_shared check into 802.3 path as 802.11 path does
to prevent potential use-after-free from happening.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 net/mac80211/tx.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 0e4efc08c762..b026e746ac5b 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4437,7 +4437,7 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 				struct net_device *dev, struct sta_info *sta,
 				struct ieee80211_key *key, struct sk_buff *skb)
 {
-	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct ieee80211_tx_info *info;
 	struct ieee80211_local *local = sdata->local;
 	struct tid_ampdu_tx *tid_tx;
 	u8 tid;
@@ -4452,6 +4452,17 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 	    test_bit(SDATA_STATE_OFFCHANNEL, &sdata->state))
 		goto out_free;
 
+	if (skb_shared(skb)) {
+		struct sk_buff *tmp_skb = skb;
+
+		skb = skb_clone(skb, GFP_ATOMIC);
+		kfree_skb(tmp_skb);
+
+		if (!skb)
+			return;
+	}
+
+	info = IEEE80211_SKB_CB(skb);
 	memset(info, 0, sizeof(*info));
 
 	ieee80211_aggr_check(sdata, sta, skb);
-- 
2.29.2

