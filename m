Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2A31A785
	for <lists+linux-wireless@lfdr.de>; Sat, 11 May 2019 12:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbfEKKSU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 11 May 2019 06:18:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:36744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728477AbfEKKSU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 11 May 2019 06:18:20 -0400
Received: from localhost.localdomain (unknown [151.66.17.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21E7C217D6;
        Sat, 11 May 2019 10:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557569899;
        bh=YyURxVP0byP2fWydyV9g8EubbWQ/U1vqF24McLJQOyo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pmmaPzFo29e3FxJ5Kv5/+bOsj38jSg03K9aeXZJGf5R0wTizorCFVWPM9aqBN17Do
         UE3GdtH9lgwyCDj4rd5mComu9prXtQIogbsTH8AnMYLSflgM+A8Nr5dmUbAv9L58Ez
         E0Cz7MJ51HQbOGIH5T5CWA/i0jBoFnIq2VIe0sHI=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sgruszka@redhat.com
Subject: [PATCH 1/4] mt76: mt76x02: remove enable from mt76x02_edcca_init signature
Date:   Sat, 11 May 2019 12:17:51 +0200
Message-Id: <74829534fbfd03a6346765a52c9d545ab2a08db5.1557567465.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1557567465.git.lorenzo@kernel.org>
References: <cover.1557567465.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove enable parameter from mt76x02_edcca_init routine signature since
it is always true

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x0/main.c     | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c     | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c     | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.h     | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/pci_phy.c  | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/usb_phy.c  | 2 +-
 8 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/main.c b/drivers/net/wireless/mediatek/mt76/mt76x0/main.c
index 691984037f98..800ebbfc3055 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/main.c
@@ -33,7 +33,7 @@ mt76x0_set_channel(struct mt76x02_dev *dev, struct cfg80211_chan_def *chandef)
 	mt76_rr(dev, MT_CH_IDLE);
 	mt76_rr(dev, MT_CH_BUSY);
 
-	mt76x02_edcca_init(dev, true);
+	mt76x02_edcca_init(dev);
 
 	if (mt76_is_mmio(dev)) {
 		mt76x02_dfs_init_params(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c b/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c
index b1d6fd4861e3..7853078e8ca4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c
@@ -125,7 +125,7 @@ mt76_edcca_set(void *data, u64 val)
 	dev->ed_monitor_enabled = !!val;
 	dev->ed_monitor = dev->ed_monitor_enabled &&
 			  region == NL80211_DFS_ETSI;
-	mt76x02_edcca_init(dev, true);
+	mt76x02_edcca_init(dev);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c b/drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c
index 17d12d212d1b..84b845647881 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c
@@ -887,7 +887,7 @@ mt76x02_dfs_set_domain(struct mt76x02_dev *dev,
 
 		dev->ed_monitor = dev->ed_monitor_enabled &&
 				  region == NL80211_DFS_ETSI;
-		mt76x02_edcca_init(dev, true);
+		mt76x02_edcca_init(dev);
 
 		dfs_pd->region = region;
 		mt76x02_dfs_init_params(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index 56510a1a843a..ee4a86971be7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -945,12 +945,12 @@ mt76x02_edcca_tx_enable(struct mt76x02_dev *dev, bool enable)
 	dev->ed_tx_blocked = !enable;
 }
 
-void mt76x02_edcca_init(struct mt76x02_dev *dev, bool enable)
+void mt76x02_edcca_init(struct mt76x02_dev *dev)
 {
 	dev->ed_trigger = 0;
 	dev->ed_silent = 0;
 
-	if (dev->ed_monitor && enable) {
+	if (dev->ed_monitor) {
 		struct ieee80211_channel *chan = dev->mt76.chandef.chan;
 		u8 ed_th = chan->band == NL80211_BAND_5GHZ ? 0x0e : 0x20;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
index e4a9e0d0924b..cb39da79527a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
@@ -209,5 +209,5 @@ int mt76x02_mac_set_beacon(struct mt76x02_dev *dev, u8 vif_idx,
 void mt76x02_mac_set_beacon_enable(struct mt76x02_dev *dev,
 				   struct ieee80211_vif *vif, bool val);
 
-void mt76x02_edcca_init(struct mt76x02_dev *dev, bool enable);
+void mt76x02_edcca_init(struct mt76x02_dev *dev);
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_phy.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_phy.c
index cc1aebcb0696..7a39a390a7ac 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_phy.c
@@ -74,7 +74,7 @@ mt76x2_phy_channel_calibrate(struct mt76x02_dev *dev, bool mac_stopped)
 		mt76x2_mac_resume(dev);
 
 	mt76x2_apply_gain_adj(dev);
-	mt76x02_edcca_init(dev, true);
+	mt76x02_edcca_init(dev);
 
 	dev->cal.channel_cal_done = true;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
index 97bcf6494ec1..6657693edc3e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
@@ -59,7 +59,7 @@ mt76x2u_set_channel(struct mt76x02_dev *dev,
 	err = mt76x2u_phy_set_channel(dev, chandef);
 
 	mt76x2_mac_resume(dev);
-	mt76x02_edcca_init(dev, true);
+	mt76x02_edcca_init(dev);
 
 	dev->beacon_ops->pre_tbtt_enable(dev, true);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_phy.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_phy.c
index 07f67cb6854c..c7208c5375ac 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_phy.c
@@ -45,7 +45,7 @@ mt76x2u_phy_channel_calibrate(struct mt76x02_dev *dev, bool mac_stopped)
 	if (!mac_stopped)
 		mt76x2_mac_resume(dev);
 	mt76x2_apply_gain_adj(dev);
-	mt76x02_edcca_init(dev, true);
+	mt76x02_edcca_init(dev);
 
 	dev->cal.channel_cal_done = true;
 }
-- 
2.20.1

