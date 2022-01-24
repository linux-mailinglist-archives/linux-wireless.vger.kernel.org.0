Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1797498E68
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jan 2022 20:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353545AbiAXTlC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Jan 2022 14:41:02 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:34628 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344211AbiAXThG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Jan 2022 14:37:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F83C614FC
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jan 2022 19:37:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79ABEC340E5;
        Mon, 24 Jan 2022 19:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643053024;
        bh=LNa05smz+DxfK84lmbHJUSnaKHvEy1HvSLBxEO8Jnpg=;
        h=From:To:Cc:Subject:Date:From;
        b=QweerIwL/41OSzy+VdEl18bLTgD6IKqnoHD2Y7KNT4iasWqNX9InO2LOFNRjSwYnd
         UiNEXWcjma4QhHzNB9+XrXJ9bz2UynbbkrQU/OwfPjrpvY8nOD8eqODT0hi6u7fGrT
         r2sj+O6XMb+FnmNKhA+QN7nqLljOju4KBF0HBchKv2CfOi34GpjoaSLajCh6jz5NIq
         NYEFu5BD9ZWWACGH3TTo5Lr5ubxO6g0/h6tR/3ebZtVzLyoiHgRTrpmgVDTmYjwYi0
         8NvqdSHZCSqC+wKrbeuW0B6LpMH6QVgAidjMuFG/28ab5XwG/qHSqJ1CZXhQB+1Bqi
         Z28iuqM4rRbvw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, shayne.chen@mediatek.com
Subject: [PATCH] mt76: mt7915: fix possible memory leak in mt7915_mcu_add_sta
Date:   Mon, 24 Jan 2022 20:36:52 +0100
Message-Id: <db9343b959e96bcaaf9e8d7423a1ad9d101769b4.1643052920.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Free allocated skb in mt7915_mcu_add_sta routine in case of failures.

Fixes: 89bbd3730f382 ("mt76: mt7915: rework starec TLV tags")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index e42900b2545f..d810d5776034 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1686,8 +1686,10 @@ int mt7915_mcu_add_sta(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 	}
 
 	ret = mt7915_mcu_sta_wtbl_tlv(dev, skb, vif, sta);
-	if (ret)
+	if (ret) {
+		dev_kfree_skb(skb);
 		return ret;
+	}
 
 	if (sta && sta->ht_cap.ht_supported) {
 		/* starec amsdu */
@@ -1701,8 +1703,10 @@ int mt7915_mcu_add_sta(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 	}
 
 	ret = mt7915_mcu_add_group(dev, vif, sta);
-	if (ret)
+	if (ret) {
+		dev_kfree_skb(skb);
 		return ret;
+	}
 out:
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
 				     MCU_EXT_CMD(STA_REC_UPDATE), true);
-- 
2.34.1

