Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B454B6D11FD
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Mar 2023 00:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjC3WK2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Mar 2023 18:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjC3WK0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Mar 2023 18:10:26 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F78C113
        for <linux-wireless@vger.kernel.org>; Thu, 30 Mar 2023 15:10:25 -0700 (PDT)
X-UUID: a93f88c4cf4711eda9a90f0bb45854f4-20230331
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=dzcXFIe6xfhgc1APTrTG7JZEbQeJT6UjUj8mcefKjNI=;
        b=pmM9WXHCIeJJRtspyhketl5J/sJj9MtlPiGJjh5rBQx6B12PbmpgaCQkxXgGiP1sGYtozJA1+cZOMK3/5TkkYOgY6/kZyH4aePBDURQp3bMq1EuU1TxGK6dFA34ervHPPG3d84VEiPeLHqYh1NE2nHLKqY9DPKLTIlK3JvaJfjM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:45e0e19d-2359-496b-8b30-c245ddf32091,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:686b022a-564d-42d9-9875-7c868ee415ec,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: a93f88c4cf4711eda9a90f0bb45854f4-20230331
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 375618698; Fri, 31 Mar 2023 06:10:20 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 31 Mar 2023 06:10:19 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 31 Mar 2023 06:10:19 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7915: drop redundant prefix of mt7915_txpower_puts()
Date:   Fri, 31 Mar 2023 06:10:17 +0800
Message-ID: <7354540481df61f7768a395c5ccb7859bdbc35e9.1680214066.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Just a cosmetic patch to drop redundant prefix for txpower ouput text.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 36 +++++++++----------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 5a46813a59ea..879884ead660 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -958,10 +958,10 @@ mt7915_xmit_queues_show(struct seq_file *file, void *data)
 
 DEFINE_SHOW_ATTRIBUTE(mt7915_xmit_queues);
 
-#define mt7915_txpower_puts(prefix, rate)					\
+#define mt7915_txpower_puts(rate)						\
 ({										\
-	len += scnprintf(buf + len, sz - len, "%-16s:", #prefix " (tmac)");	\
-	for (i = 0; i < mt7915_sku_group_len[rate]; i++, offs++)		\
+	len += scnprintf(buf + len, sz - len, "%-16s:", #rate " (TMAC)");	\
+	for (i = 0; i < mt7915_sku_group_len[SKU_##rate]; i++, offs++)		\
 		len += scnprintf(buf + len, sz - len, " %6d", txpwr[offs]);	\
 	len += scnprintf(buf + len, sz - len, "\n");				\
 })
@@ -1004,41 +1004,41 @@ mt7915_rate_txpower_get(struct file *file, char __user *user_buf,
 			 phy != &dev->phy, phy->mt76->chandef.chan->hw_value);
 	len += scnprintf(buf + len, sz - len, "%-16s  %6s %6s %6s %6s\n",
 			 " ", "1m", "2m", "5m", "11m");
-	mt7915_txpower_puts(CCK, SKU_CCK);
+	mt7915_txpower_puts(CCK);
 
 	len += scnprintf(buf + len, sz - len,
 			 "%-16s  %6s %6s %6s %6s %6s %6s %6s %6s\n",
 			 " ", "6m", "9m", "12m", "18m", "24m", "36m", "48m",
 			 "54m");
-	mt7915_txpower_puts(OFDM, SKU_OFDM);
+	mt7915_txpower_puts(OFDM);
 
 	len += scnprintf(buf + len, sz - len,
 			 "%-16s  %6s %6s %6s %6s %6s %6s %6s %6s\n",
 			 " ", "mcs0", "mcs1", "mcs2", "mcs3", "mcs4",
 			 "mcs5", "mcs6", "mcs7");
-	mt7915_txpower_puts(HT20, SKU_HT_BW20);
+	mt7915_txpower_puts(HT_BW20);
 
 	len += scnprintf(buf + len, sz - len,
 			 "%-16s  %6s %6s %6s %6s %6s %6s %6s %6s %6s\n",
 			 " ", "mcs0", "mcs1", "mcs2", "mcs3", "mcs4", "mcs5",
 			 "mcs6", "mcs7", "mcs32");
-	mt7915_txpower_puts(HT40, SKU_HT_BW40);
+	mt7915_txpower_puts(HT_BW40);
 
 	len += scnprintf(buf + len, sz - len,
 			 "%-16s  %6s %6s %6s %6s %6s %6s %6s %6s %6s %6s %6s %6s\n",
 			 " ", "mcs0", "mcs1", "mcs2", "mcs3", "mcs4", "mcs5",
 			 "mcs6", "mcs7", "mcs8", "mcs9", "mcs10", "mcs11");
-	mt7915_txpower_puts(VHT20, SKU_VHT_BW20);
-	mt7915_txpower_puts(VHT40, SKU_VHT_BW40);
-	mt7915_txpower_puts(VHT80, SKU_VHT_BW80);
-	mt7915_txpower_puts(VHT160, SKU_VHT_BW160);
-	mt7915_txpower_puts(HE26, SKU_HE_RU26);
-	mt7915_txpower_puts(HE52, SKU_HE_RU52);
-	mt7915_txpower_puts(HE106, SKU_HE_RU106);
-	mt7915_txpower_puts(HE242, SKU_HE_RU242);
-	mt7915_txpower_puts(HE484, SKU_HE_RU484);
-	mt7915_txpower_puts(HE996, SKU_HE_RU996);
-	mt7915_txpower_puts(HE996x2, SKU_HE_RU2x996);
+	mt7915_txpower_puts(VHT_BW20);
+	mt7915_txpower_puts(VHT_BW40);
+	mt7915_txpower_puts(VHT_BW80);
+	mt7915_txpower_puts(VHT_BW160);
+	mt7915_txpower_puts(HE_RU26);
+	mt7915_txpower_puts(HE_RU52);
+	mt7915_txpower_puts(HE_RU106);
+	mt7915_txpower_puts(HE_RU242);
+	mt7915_txpower_puts(HE_RU484);
+	mt7915_txpower_puts(HE_RU996);
+	mt7915_txpower_puts(HE_RU2x996);
 
 	reg = is_mt7915(&dev->mt76) ? MT_WF_PHY_TPC_CTRL_STAT(band) :
 	      MT_WF_PHY_TPC_CTRL_STAT_MT7916(band);
-- 
2.18.0

