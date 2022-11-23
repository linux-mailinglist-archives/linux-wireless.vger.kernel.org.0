Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C1F6369F3
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Nov 2022 20:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236812AbiKWTiG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Nov 2022 14:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240017AbiKWTh7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Nov 2022 14:37:59 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA925ADD2
        for <linux-wireless@vger.kernel.org>; Wed, 23 Nov 2022 11:37:53 -0800 (PST)
X-UUID: 16e90557b2b64fb585a380986bf36c24-20221124
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=/bGL7NeH7E4fkHcQ5YBrB8gRbZfK+h45aAwfGCIDyJQ=;
        b=GrMuM1JCzeJMYddEW/2WVbeNRp+uj10sS4m6zxo7FA8w59VCHKxnJHInOGxUB8jFBVql5wA1c6Ag+VF9XjH3CNWURwEMnGuljEHqffVsS5IDqToqwZFhx6V+65MudZbODDxTPtT7l76uvkLtsM30pReFZPh1yFh94ixbS+KdxLI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.13,REQID:1f6d89b7-3fa1-4f9e-be52-e5cbd9d01d41,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d12e911,CLOUDID:b2221ff9-3a34-4838-abcf-dfedf9dd068e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 16e90557b2b64fb585a380986bf36c24-20221124
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 192169641; Thu, 24 Nov 2022 03:37:50 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 24 Nov 2022 03:37:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 24 Nov 2022 03:37:48 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 1/2] wifi: mt76: mt7915: introduce mt7915_get_power_bound()
Date:   Thu, 24 Nov 2022 03:37:17 +0800
Message-ID: <9a67f1617249be2c73bb5900d2df971b682f8772.1669229848.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add a helper for common boundary check. This is a preliminary patch
to add per bandwidth power control.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 12 +++++-------
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h | 12 ++++++++++++
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index f329705c4fa1..8a2546699c3b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3122,14 +3122,14 @@ int mt7915_mcu_set_txpower_frame(struct mt7915_phy *phy,
 		.txpower_max = DIV_ROUND_UP(mphy->txpower_cur, 2),
 		.wcid = cpu_to_le16(msta->wcid.idx),
 	};
-	int ret, n_chains = hweight8(mphy->antenna_mask);
+	int ret;
 	s8 txpower_sku[MT7915_SKU_RATE_NUM];
 
 	ret = mt7915_mcu_get_txpower_sku(phy, txpower_sku, sizeof(txpower_sku));
 	if (ret)
 		return ret;
 
-	txpower = txpower * 2 - mt76_tx_power_nss_delta(n_chains);
+	txpower = mt7915_get_power_bound(phy, txpower);
 	if (txpower > mphy->txpower_cur || txpower < 0)
 		return -EINVAL;
 
@@ -3181,12 +3181,10 @@ int mt7915_mcu_set_txpower_sku(struct mt7915_phy *phy)
 	};
 	struct mt76_power_limits limits_array;
 	s8 *la = (s8 *)&limits_array;
-	int i, idx, n_chains = hweight8(mphy->antenna_mask);
-	int tx_power = hw->conf.power_level * 2;
+	int i, idx;
+	int tx_power;
 
-	tx_power = mt76_get_sar_power(mphy, mphy->chandef.chan,
-				      tx_power);
-	tx_power -= mt76_tx_power_nss_delta(n_chains);
+	tx_power = mt7915_get_power_bound(phy, hw->conf.power_level);
 	tx_power = mt76_get_rate_power_limits(mphy, mphy->chandef.chan,
 					      &limits_array, tx_power);
 	mphy->txpower_cur = tx_power;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index 46c517e50ae4..382dcbda50bb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -509,4 +509,16 @@ enum {
 					 sizeof(struct bss_info_bcn_cont) + \
 					 sizeof(struct bss_info_inband_discovery))
 
+static inline s8
+mt7915_get_power_bound(struct mt7915_phy *phy, s8 txpower)
+{
+	struct mt76_phy *mphy = phy->mt76;
+	int n_chains = hweight8(mphy->antenna_mask);
+
+	txpower = mt76_get_sar_power(mphy, mphy->chandef.chan, txpower * 2);
+	txpower -= mt76_tx_power_nss_delta(n_chains);
+
+	return txpower;
+}
+
 #endif
-- 
2.36.1

