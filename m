Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC975488B78
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Jan 2022 18:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236349AbiAIR5J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 Jan 2022 12:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235907AbiAIR5I (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 Jan 2022 12:57:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9971BC06173F
        for <linux-wireless@vger.kernel.org>; Sun,  9 Jan 2022 09:57:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3764560F45
        for <linux-wireless@vger.kernel.org>; Sun,  9 Jan 2022 17:57:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94B7C36AE3;
        Sun,  9 Jan 2022 17:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641751027;
        bh=ijDpT4iphq9q3PgRcb4nOPS0S2TXjSc95wRKVuLQbIg=;
        h=From:To:Cc:Subject:Date:From;
        b=ThLPaZvLJXI5Zeau4NPan7AJ/26fjrsLiqTgqOEJOv7c1vhF6HY7EjtFlRHHYbs0G
         Ik6iNzByHooVi6rP0GeojA66PxA0pBQuyguvTJvUbwm09vU9JXVMJC3iMuN41fAgOF
         J14G/DFm4jZpuBPIXzoITjGHCM/pKMm9tXal/BCO7Ug8/lzYawuKLlPAfTtaeXTMZr
         KQMGXXxpdaTpdB/HWFhZFVwgfgr2vokoYowL6fJrGb+LRiEVZPpAxk/9VFFiQcQyC4
         QDiF+VLMwxEaX8BsBRk8w2OAVMtVA2xNoO0XM++5ApJDpYf/d7hIHaIAoddTV/LBvj
         eZiyOqE0lgMRw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com, deren.wu@mediatek.com
Subject: [PATCH] mt76: mt7921: fix endianness issues in mt7921_mcu_set_tx()
Date:   Sun,  9 Jan 2022 18:56:57 +0100
Message-Id: <cae92d89b677c880831c633598266fd20874fabb.1641750911.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the following sparse warning in mt7921_mcu_set_tx routine:

drivers/net/wireless/mediatek/mt76/mt7921/mcu.c:792:25: warning: incorrect type in assignment (different base types)
drivers/net/wireless/mediatek/mt76/mt7921/mcu.c:792:25:    expected restricted __le16 [usertype] aifs
drivers/net/wireless/mediatek/mt76/mt7921/mcu.c:792:25:    got unsigned char [usertype] aifs
drivers/net/wireless/mediatek/mt76/mt7921/mcu.c:798:35: warning: incorrect type in assignment (different base types)
drivers/net/wireless/mediatek/mt76/mt7921/mcu.c:798:35:    expected restricted __le16 [usertype] cw_min

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 76279f3c37f71..509595c4157ce 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -740,7 +740,6 @@ EXPORT_SYMBOL_GPL(mt7921_mcu_exit);
 int mt7921_mcu_set_tx(struct mt7921_dev *dev, struct ieee80211_vif *vif)
 {
 	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
-
 	struct edca {
 		__le16 cw_min;
 		__le16 cw_max;
@@ -760,7 +759,6 @@ int mt7921_mcu_set_tx(struct mt7921_dev *dev, struct ieee80211_vif *vif)
 		.qos = vif->bss_conf.qos,
 		.wmm_idx = mvif->mt76.wmm_idx,
 	};
-
 	struct mu_edca {
 		u8 cw_min;
 		u8 cw_max;
@@ -784,20 +782,20 @@ int mt7921_mcu_set_tx(struct mt7921_dev *dev, struct ieee80211_vif *vif)
 		.qos = vif->bss_conf.qos,
 		.wmm_idx = mvif->mt76.wmm_idx,
 	};
-	int to_aci[] = {1, 0, 2, 3};
+	static const int to_aci[] = { 1, 0, 2, 3 };
 	int ac, ret;
 
 	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
 		struct ieee80211_tx_queue_params *q = &mvif->queue_params[ac];
 		struct edca *e = &req.edca[to_aci[ac]];
 
-		e->aifs = q->aifs;
+		e->aifs = cpu_to_le16(q->aifs);
 		e->txop = cpu_to_le16(q->txop);
 
 		if (q->cw_min)
 			e->cw_min = cpu_to_le16(q->cw_min);
 		else
-			e->cw_min = 5;
+			e->cw_min = cpu_to_le16(5);
 
 		if (q->cw_max)
 			e->cw_max = cpu_to_le16(q->cw_max);
-- 
2.33.1

