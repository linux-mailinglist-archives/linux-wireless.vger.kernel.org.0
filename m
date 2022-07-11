Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16EC57054D
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Jul 2022 16:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiGKOTd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Jul 2022 10:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiGKOTb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Jul 2022 10:19:31 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3DD32EE1
        for <linux-wireless@vger.kernel.org>; Mon, 11 Jul 2022 07:19:29 -0700 (PDT)
X-UUID: e12548c3a1e34cd69d0d50e62d0197c5-20220711
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:70b79acb-66b1-4334-a339-b09f929a6d86,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:0f94e32,CLOUDID:78f9f963-0b3f-4b2c-b3a6-ed5c044366a0,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: e12548c3a1e34cd69d0d50e62d0197c5-20220711
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1128620938; Mon, 11 Jul 2022 22:19:24 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 11 Jul 2022 22:19:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Mon, 11 Jul 2022 22:19:23 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH] mt76: testmode: use random payload for tx packets
Date:   Mon, 11 Jul 2022 22:19:10 +0800
Message-ID: <20220711141910.17573-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Compared to fixed payload packets, random payload packets have better
measured EVM under the same txpower. Our tests show EVM becomes at least
2-3 dB better in test cases with high rate and long tx length, which also
aligns the testing results to proprietary driver.

Suggested-by: Jm Chen <jm.chen@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/testmode.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/testmode.c b/drivers/net/wireless/mediatek/mt76/testmode.c
index 47ac0ca1af32..fedc7a61ca37 100644
--- a/drivers/net/wireless/mediatek/mt76/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/testmode.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: ISC
 /* Copyright (C) 2020 Felix Fietkau <nbd@nbd.name> */
+
+#include <linux/random.h>
 #include "mt76.h"
 
 const struct nla_policy mt76_tm_policy[NUM_MT76_TM_ATTRS] = {
@@ -124,12 +126,14 @@ int mt76_testmode_alloc_skb(struct mt76_phy *phy, u32 len)
 	if (!head)
 		return -ENOMEM;
 
-	hdr = __skb_put_zero(head, head_len);
+	hdr = __skb_put_zero(head, sizeof(*hdr));
 	hdr->frame_control = cpu_to_le16(fc);
 	memcpy(hdr->addr1, td->addr[0], ETH_ALEN);
 	memcpy(hdr->addr2, td->addr[1], ETH_ALEN);
 	memcpy(hdr->addr3, td->addr[2], ETH_ALEN);
 	skb_set_queue_mapping(head, IEEE80211_AC_BE);
+	get_random_bytes(__skb_put(head, head_len - sizeof(*hdr)),
+			 head_len - sizeof(*hdr));
 
 	info = IEEE80211_SKB_CB(head);
 	info->flags = IEEE80211_TX_CTL_INJECTED |
@@ -157,7 +161,7 @@ int mt76_testmode_alloc_skb(struct mt76_phy *phy, u32 len)
 			return -ENOMEM;
 		}
 
-		__skb_put_zero(frag, frag_len);
+		get_random_bytes(__skb_put(frag, frag_len), frag_len);
 		head->len += frag->len;
 		head->data_len += frag->len;
 
-- 
2.25.1

