Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036E02F6013
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Jan 2021 12:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbhANLa5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Jan 2021 06:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbhANLaz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Jan 2021 06:30:55 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BD3C061799
        for <linux-wireless@vger.kernel.org>; Thu, 14 Jan 2021 03:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=62kr2qOFw/KMM2Uh3WOUF9CQTzobILkZyEx8N4WUNz8=; b=awIXMZDX18nvncEahv0K2bUEsH
        CkDUuDOKKIRWKv1FXwT/hFnE6uY4ZE07OkvkG+SZ0jn2yLGUyTlgtdULzqIrrYfMJ4Nig+YgJjDxq
        DGRaBQpA6a0ay3R70Aw/lGCK0mfY9V26LIOhrnFqkiD2qY90CwBd698/QF0OPmqiJUbk=;
Received: from p54ae91f2.dip0.t-ipconnect.de ([84.174.145.242] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1l00og-0001PU-WD
        for linux-wireless@vger.kernel.org; Thu, 14 Jan 2021 12:29:27 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 3/7] mt76: mt7915: do not set DRR group for stations
Date:   Thu, 14 Jan 2021 12:29:21 +0100
Message-Id: <20210114112925.87646-3-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210114112925.87646-1-nbd@nbd.name>
References: <20210114112925.87646-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is causing some extreme latency spikes when sending traffic to
multiple stations at the same time. Disable this until the firmware issue
is sorted out

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 30 -------------------
 1 file changed, 30 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 6d4c5b7dfd56..ad42e9b48d35 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2198,32 +2198,6 @@ int mt7915_mcu_add_rate_ctrl(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 				     MCU_EXT_CMD_STA_REC_UPDATE, true);
 }
 
-static int
-mt7915_mcu_add_group(struct mt7915_dev *dev, struct ieee80211_vif *vif,
-		     struct ieee80211_sta *sta)
-{
-#define MT_STA_BSS_GROUP		1
-	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
-	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
-	struct {
-		__le32 action;
-		u8 wlan_idx_lo;
-		u8 status;
-		u8 wlan_idx_hi;
-		u8 rsv0[5];
-		__le32 val;
-		u8 rsv1[8];
-	} __packed req = {
-		.action = cpu_to_le32(MT_STA_BSS_GROUP),
-		.wlan_idx_lo = to_wcid_lo(msta->wcid.idx),
-		.wlan_idx_hi = to_wcid_hi(msta->wcid.idx),
-		.val = cpu_to_le32(mvif->idx % 16),
-	};
-
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_DRR_CTRL, &req,
-				 sizeof(req), true);
-}
-
 int mt7915_mcu_add_sta_adv(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta, bool enable)
 {
@@ -2233,10 +2207,6 @@ int mt7915_mcu_add_sta_adv(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 		return 0;
 
 	/* must keep the order */
-	ret = mt7915_mcu_add_group(dev, vif, sta);
-	if (ret)
-		return ret;
-
 	ret = mt7915_mcu_add_txbf(dev, vif, sta, enable);
 	if (ret)
 		return ret;
-- 
2.28.0

