Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EDE78E6B1
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Aug 2023 08:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346097AbjHaGlm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Aug 2023 02:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245615AbjHaGll (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Aug 2023 02:41:41 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EC1A4
        for <linux-wireless@vger.kernel.org>; Wed, 30 Aug 2023 23:41:37 -0700 (PDT)
X-UUID: e88d8fe247c611eeb20a276fd37b9834-20230831
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=KfU4LEeC1RlS57fRfeRmoy2Ec+uKEXRjduS2hlBa8FA=;
        b=kHYs+pawtUmlGVVZpZ2CS6DYh6z4HbQORdmvMuUr29kKcMIjJij0DztxyuWOxKEhmnilQaPExxDL39cjGJ+XGSFotShVSnYT9qAbOcINMzKko+su4tVF/fdwIuPib5v0jXLxPzu28H6Qp0AA0tXC0y6G1akSYROQMEJz6w0D4yo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:0821a5d3-e637-43f7-b883-d9b2ad1d9993,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:85176413-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e88d8fe247c611eeb20a276fd37b9834-20230831
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 831151203; Thu, 31 Aug 2023 14:23:32 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 31 Aug 2023 14:23:31 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 31 Aug 2023 14:23:31 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 7/9] wifi: mt76: check vif type before reporting cca and csa
Date:   Thu, 31 Aug 2023 14:22:19 +0800
Message-ID: <20230831062221.20027-7-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230831062221.20027-1-shayne.chen@mediatek.com>
References: <20230831062221.20027-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Peter Chiu <chui-hao.chiu@mediatek.com>

Do not report cca and csa finish to upper layer on station type vif to
prevent warnings caused by setting beacon.

Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 8 +++++---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 8 +++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index a203f90367f4..79d0a0f3cc57 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -225,8 +225,10 @@ int mt7915_mcu_wa_cmd(struct mt7915_dev *dev, int cmd, u32 a1, u32 a2, u32 a3)
 static void
 mt7915_mcu_csa_finish(void *priv, u8 *mac, struct ieee80211_vif *vif)
 {
-	if (vif->bss_conf.csa_active)
-		ieee80211_csa_finish(vif);
+	if (!vif->bss_conf.csa_active || vif->type == NL80211_IFTYPE_STATION)
+		return;
+
+	ieee80211_csa_finish(vif);
 }
 
 static void
@@ -326,7 +328,7 @@ mt7915_mcu_rx_log_message(struct mt7915_dev *dev, struct sk_buff *skb)
 static void
 mt7915_mcu_cca_finish(void *priv, u8 *mac, struct ieee80211_vif *vif)
 {
-	if (!vif->bss_conf.color_change_active)
+	if (!vif->bss_conf.color_change_active || vif->type == NL80211_IFTYPE_STATION)
 		return;
 
 	ieee80211_color_change_finish(vif);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 27250e7a077d..12bf4e5038b5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -324,8 +324,10 @@ int mt7996_mcu_wa_cmd(struct mt7996_dev *dev, int cmd, u32 a1, u32 a2, u32 a3)
 static void
 mt7996_mcu_csa_finish(void *priv, u8 *mac, struct ieee80211_vif *vif)
 {
-	if (vif->bss_conf.csa_active)
-		ieee80211_csa_finish(vif);
+	if (!vif->bss_conf.csa_active || vif->type == NL80211_IFTYPE_STATION)
+		return;
+
+	ieee80211_csa_finish(vif);
 }
 
 static void
@@ -399,7 +401,7 @@ mt7996_mcu_rx_log_message(struct mt7996_dev *dev, struct sk_buff *skb)
 static void
 mt7996_mcu_cca_finish(void *priv, u8 *mac, struct ieee80211_vif *vif)
 {
-	if (!vif->bss_conf.color_change_active)
+	if (!vif->bss_conf.color_change_active || vif->type == NL80211_IFTYPE_STATION)
 		return;
 
 	ieee80211_color_change_finish(vif);
-- 
2.39.2

