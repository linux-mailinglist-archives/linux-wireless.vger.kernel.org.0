Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44AA722AE0
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jun 2023 17:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbjFEPWR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Jun 2023 11:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234183AbjFEPWI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Jun 2023 11:22:08 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEFE18E
        for <linux-wireless@vger.kernel.org>; Mon,  5 Jun 2023 08:21:58 -0700 (PDT)
X-UUID: b01a769e03b411eeb20a276fd37b9834-20230605
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=RZXEZCw31FaBhMKsyB3zJ9VlZt6/IvYCVkFUTILKzDs=;
        b=t0Sa3C7SGqyBdlY2fdTUz0LPKktB5QCwGRNUue2MMiqGjgd/gQrP4XdBn1XWC250x1JcOAM6UekbtSI0nKQ8vTlmQPZS9XkJhFd/oA0NhAOD8YzgNotbCFWnk6shfTJkliGrfe4U4anK6joxZ8EY3AW19SNH6o6KUkoM9TD4PUA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:805f950e-315c-4c46-8fa3-932f9f55ecea,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.25,REQID:805f950e-315c-4c46-8fa3-932f9f55ecea,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:d5b0ae3,CLOUDID:b317a23d-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:230605162048KAS35HAN,BulkQuantity:5,Recheck:0,SF:29|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:41,QS:nil,BEC:nil,COL:0,OSI
        :0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: b01a769e03b411eeb20a276fd37b9834-20230605
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 197562098; Mon, 05 Jun 2023 23:21:47 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 5 Jun 2023 23:21:46 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 5 Jun 2023 23:21:46 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v3 01/10] wifi: mt76: mt7996: move radio ctrl commands to proper functions
Date:   Mon, 5 Jun 2023 23:21:32 +0800
Message-ID: <20230605152141.17434-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
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

