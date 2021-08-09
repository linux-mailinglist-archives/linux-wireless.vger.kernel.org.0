Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECDC3E41B5
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Aug 2021 10:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbhHIIik (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Aug 2021 04:38:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:43950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233903AbhHIIij (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Aug 2021 04:38:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0FB4660F55;
        Mon,  9 Aug 2021 08:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628498299;
        bh=BNiZvoYEnY1eUhfJPizwbFeIp7f4O/U2jVhd0TksxfQ=;
        h=From:To:Cc:Subject:Date:From;
        b=tpYrfcd7b1/eZQJmOFugh5rgIdtVGWnKUvNQs1kTsG0zQbSG8wEnxoGPRT2GRBQtS
         /aEupDBJtgUiMcRvpUO8x8gFlgkL93FnX+h1SdHUPv30PeCC7abKyCKKYMIWUA5j5+
         PKtBLUjnzUbZ64zYxTPfoMaLfa3i6N2q9bi/JC2hmOxoRKZOT0m3mOXrnV+KIHPSiG
         Y6/MfwrInbIhOGa8SfQD4r+JblnR1/OB+iMYzignjWvmw+lc/Y8ZOHiH4ECbaZyGtj
         oep68B7CStnNczoMofUragpG1zahJZaSl10cjusm8nPAE5tswn6tYXd35UX/kr5ds+
         g6mF/P5T+8q5w==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: mt7921: get rid of mt7921_mac_set_beacon_filter
Date:   Mon,  9 Aug 2021 10:38:03 +0200
Message-Id: <9495cf2a8ba645b5028f65ffa2bf0c6351ffa9c6.1628498244.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove mt7921_mac_set_beacon_filter routine since it is no longer used.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 28 -------------------
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  3 --
 2 files changed, 31 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 296e0f7a1d14..2fd9be46dfdf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1507,34 +1507,6 @@ void mt7921_pm_power_save_work(struct work_struct *work)
 	queue_delayed_work(dev->mt76.wq, &dev->pm.ps_work, delta);
 }
 
-int mt7921_mac_set_beacon_filter(struct mt7921_phy *phy,
-				 struct ieee80211_vif *vif,
-				 bool enable)
-{
-	struct mt7921_dev *dev = phy->dev;
-	bool ext_phy = phy != &dev->phy;
-	int err;
-
-	if (!dev->pm.enable)
-		return -EOPNOTSUPP;
-
-	err = mt7921_mcu_set_bss_pm(dev, vif, enable);
-	if (err)
-		return err;
-
-	if (enable) {
-		vif->driver_flags |= IEEE80211_VIF_BEACON_FILTER;
-		mt76_set(dev, MT_WF_RFCR(ext_phy),
-			 MT_WF_RFCR_DROP_OTHER_BEACON);
-	} else {
-		vif->driver_flags &= ~IEEE80211_VIF_BEACON_FILTER;
-		mt76_clear(dev, MT_WF_RFCR(ext_phy),
-			   MT_WF_RFCR_DROP_OTHER_BEACON);
-	}
-
-	return 0;
-}
-
 void mt7921_coredump_work(struct work_struct *work)
 {
 	struct mt7921_dev *dev;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 5fcd197936be..8722df3b9a29 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -377,9 +377,6 @@ int mt7921_mcu_fw_pmctrl(struct mt7921_dev *dev);
 void mt7921_pm_wake_work(struct work_struct *work);
 void mt7921_pm_power_save_work(struct work_struct *work);
 bool mt7921_wait_for_mcu_init(struct mt7921_dev *dev);
-int mt7921_mac_set_beacon_filter(struct mt7921_phy *phy,
-				 struct ieee80211_vif *vif,
-				 bool enable);
 void mt7921_pm_interface_iter(void *priv, u8 *mac, struct ieee80211_vif *vif);
 void mt7921_coredump_work(struct work_struct *work);
 int mt7921_wfsys_reset(struct mt7921_dev *dev);
-- 
2.31.1

