Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F784353400
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Apr 2021 14:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236660AbhDCM0w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 3 Apr 2021 08:26:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:60062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230409AbhDCM0v (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 3 Apr 2021 08:26:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F23F66121F;
        Sat,  3 Apr 2021 12:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617452809;
        bh=3HVBp8VXqO9PK5lY2wfx+RMG+EikDPQaOSPTvIZmmfc=;
        h=From:To:Cc:Subject:Date:From;
        b=Ha+m9fP8SYsGzZc+N6BVqI/jVXer3FdpSHPms55n9dByaZ0S5zIMSR8BOMKWRpEnQ
         PWWjxVaMT7f0oxo7UvAPhZLaTARkDlNFn+DxYzzZ+i9afJuvwNZpCvtI7lBIFPXU60
         9dL+9TEI5NHyYLJttY09pM/kXqpYAelrLaFLI2nLfZvzfIqec6tKHtkqcn8t3hfPW9
         XhbgInuRrd5VXc/Dz2cesvqHbT77eYfUqjVRhOX83PvWeE+gzU5rrcr5aOThhXSMTV
         AhKz+VoAEzT0az3ocSk4oSSeoCQleSy0El8VvQtSQNtaKLIZEhnND3vAa0E3lrHVYg
         MjRqGnIGp5fzQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, leon.yen@mediatek.com
Subject: [PATCH] mt76: mt7921: always wake the device in mt7921_remove_interface
Date:   Sat,  3 Apr 2021 14:26:39 +0200
Message-Id: <934f570b49be460fd4702f3dec172b6d09eeb0f8.1617452694.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Make sure the mcu is not in sleep mode before sending mcu messages in
mt7921_remove_interface routine.

Fixes: 1d8efc741df80 ("mt76: mt7921: introduce Runtime PM support")
Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Co-developed-by: Leon Yen <leon.yen@mediatek.com>
Signed-off-by: Leon Yen <leon.yen@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index c0ebb6077fa8..dc157d5f926d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -360,12 +360,12 @@ static void mt7921_remove_interface(struct ieee80211_hw *hw,
 	if (vif == phy->monitor_vif)
 		phy->monitor_vif = NULL;
 
+	mt7921_mutex_acquire(dev);
 	mt76_connac_free_pending_tx_skbs(&dev->pm, &msta->wcid);
 	mt76_connac_mcu_uni_add_dev(&dev->mphy, vif, &mvif->sta.wcid, false);
 
 	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
 
-	mt7921_mutex_acquire(dev);
 	dev->mt76.vif_mask &= ~BIT(mvif->mt76.idx);
 	phy->omac_mask &= ~BIT_ULL(mvif->mt76.omac_idx);
 	mt7921_mutex_release(dev);
-- 
2.30.2

