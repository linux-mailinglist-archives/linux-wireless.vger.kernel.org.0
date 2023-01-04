Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B33865CF45
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jan 2023 10:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbjADJMu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Jan 2023 04:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbjADJMr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Jan 2023 04:12:47 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8303101C2
        for <linux-wireless@vger.kernel.org>; Wed,  4 Jan 2023 01:12:43 -0800 (PST)
X-UUID: 64b218b1a48b4aa595dc86624cbc4d60-20230104
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=MwUIJnrccU0sOuwc06e3T/w6uq2nxB8dWICj2l+EXTc=;
        b=Bqfqm1mODnzT9e2NAtjr9BVU5IcdVzl0bwMB8lmyaIgD3Sduu6wEoyAaVA/Q+h8vFPO07bPU6MjxhphCb3jD47gO7mIoKtfsYNm7a/rwIBFimdl3Hf6/1vGxnUAiR6MBnxQoesuIDR3XhDCMjnQA5v+hScT/jlP65EgDxCX3pe8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.16,REQID:3dd1ef9b-6a25-43d0-97ee-d168ada657b7,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.16,REQID:3dd1ef9b-6a25-43d0-97ee-d168ada657b7,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:09771b1,CLOUDID:9185368b-8530-4eff-9f77-222cf6e2895b,B
        ulkID:230104171239B5APNSO9,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0
X-CID-BVR: 0,NGT
X-UUID: 64b218b1a48b4aa595dc86624cbc4d60-20230104
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1201650500; Wed, 04 Jan 2023 17:12:37 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 4 Jan 2023 17:12:35 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 4 Jan 2023 17:12:35 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2] wifi: mt76: fix WED TxS reporting
Date:   Wed, 4 Jan 2023 17:12:34 +0800
Message-ID: <2a9e0776c57c260e7734e46f2db8432ec80c1761.1672823371.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The previous commit forgot to remove a leftover check and set wrong bitmask
that led to unexpected tx_stat reporting.

Fixes: 43eaa3689507 ("wifi: mt76: add PPDU based TxS support for WED device")
Reported-By: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
changes since v2 - correct bitmask
---
 drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h | 10 ++++------
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c       |  3 ---
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
index f33171bcd343..39cdadcb3d07 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
@@ -159,12 +159,10 @@ enum {
 #define MT_TXS4_TIMESTAMP		GENMASK(31, 0)
 
 /* PPDU based TXS */
-#define MT_TXS5_MPDU_TX_BYTE		GENMASK(22, 0)
-#define MT_TXS5_MPDU_TX_CNT		GENMASK(31, 23)
-
-#define MT_TXS6_MPDU_FAIL_CNT		GENMASK(31, 23)
-
-#define MT_TXS7_MPDU_RETRY_CNT		GENMASK(31, 23)
+#define MT_TXS5_MPDU_TX_BYTE		GENMASK(23, 0)
+#define MT_TXS5_MPDU_TX_CNT		GENMASK(31, 24)
+#define MT_TXS6_MPDU_FAIL_CNT		GENMASK(31, 24)
+#define MT_TXS7_MPDU_RETRY_CNT		GENMASK(31, 24)
 
 /* RXD DW1 */
 #define MT_RXD1_NORMAL_WLAN_IDX		GENMASK(9, 0)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index f0d5a3603902..1a6def77db57 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1061,9 +1061,6 @@ static void mt7915_mac_add_txs(struct mt7915_dev *dev, void *data)
 	u16 wcidx;
 	u8 pid;
 
-	if (le32_get_bits(txs_data[0], MT_TXS0_TXS_FORMAT) > 1)
-		return;
-
 	wcidx = le32_get_bits(txs_data[2], MT_TXS2_WCID);
 	pid = le32_get_bits(txs_data[3], MT_TXS3_PID);
 
-- 
2.18.0

