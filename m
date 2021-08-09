Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299BB3E40EA
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Aug 2021 09:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbhHIHio (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Aug 2021 03:38:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:37440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233161AbhHIHio (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Aug 2021 03:38:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 44F6C61058;
        Mon,  9 Aug 2021 07:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628494704;
        bh=rwkrRbH7Ltoi1G+zrvt1GB+D/VqD3gaMLX0LiZ32sfA=;
        h=From:To:Cc:Subject:Date:From;
        b=UoEVPDrrQXLJiRQIrCzkHXWvViJl7tZ7Xv5KA80bFmw7d/h8aHKX9FLFkzRQ+VYGL
         ULDPPqAX8Nt4tVjlPDeWbC1yEcbhSPReswlt4oEf9uxdx9y63g0boQOWML2yttFZ3g
         C8PsDuzrAjE5GnXIx5eF+vOCup2MwzmAYJYNXsICswHvTUo3TNGYtPALSGtq/f6h5m
         x0WsOfLjXg7mj4zm6mEDCozCjDbrd1q2cXIifcoqzHoJZsZSRh5ctEZQL4nD/5Lm1P
         Zqj9V7Dsd+Zt1pyuZwZSRPgUVqO8/vSCwLP7HMc4OgR3h2qS8KpZ9jXFfhGeGd2oC+
         bTSO6ROJB6wrQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: mt7921: get rid of monitor_vif
Date:   Mon,  9 Aug 2021 09:38:07 +0200
Message-Id: <803484aa5d3ed16be7432665d77bcc129768a916.1628494557.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove monitor_vif pointer from mt7921 since it is just a leftover of
initial porting.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   | 7 -------
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h | 2 --
 2 files changed, 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 7c4f97d65aae..b121a0e369c7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -243,10 +243,6 @@ static int mt7921_add_interface(struct ieee80211_hw *hw,
 
 	mt7921_mutex_acquire(dev);
 
-	if (vif->type == NL80211_IFTYPE_MONITOR &&
-	    is_zero_ether_addr(vif->addr))
-		phy->monitor_vif = vif;
-
 	mvif->mt76.idx = ffs(~dev->mt76.vif_mask) - 1;
 	if (mvif->mt76.idx >= MT7921_MAX_INTERFACES) {
 		ret = -ENOSPC;
@@ -306,9 +302,6 @@ static void mt7921_remove_interface(struct ieee80211_hw *hw,
 	struct mt7921_phy *phy = mt7921_hw_phy(hw);
 	int idx = msta->wcid.idx;
 
-	if (vif == phy->monitor_vif)
-		phy->monitor_vif = NULL;
-
 	mt7921_mutex_acquire(dev);
 	mt76_connac_free_pending_tx_skbs(&dev->pm, &msta->wcid);
 	mt76_connac_mcu_uni_add_dev(&dev->mphy, vif, &mvif->sta.wcid, false);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 6e9e4dfb3928..5fcd197936be 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -123,8 +123,6 @@ struct mt7921_phy {
 
 	struct ieee80211_sband_iftype_data iftype[2][NUM_NL80211_IFTYPES];
 
-	struct ieee80211_vif *monitor_vif;
-
 	u32 rxfilter;
 	u64 omac_mask;
 
-- 
2.31.1

