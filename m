Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA311A83D
	for <lists+linux-wireless@lfdr.de>; Sat, 11 May 2019 17:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbfEKPa0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 11 May 2019 11:30:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:33062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728617AbfEKPaZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 11 May 2019 11:30:25 -0400
Received: from localhost.localdomain (unknown [151.66.17.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E72E2183F;
        Sat, 11 May 2019 15:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557588625;
        bh=UD9mweJo81tzm8Nlut+OGiZeWBc70Q9rMqUPKdPqA20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YJb4+/C5DrSRx0opN1Us8AJWalyBejOE9SgKEka1milqXi1eqociXA/a//gCw+5iH
         mm7G07oNZIy30Vi67r0bt3dirfzAcTN8+/KW89XqIrtzQ/ujdJ32T+xi+4jS7Qw/5A
         zJ0ZLvGap9nn7d7MvJ2OYM/CEhz2y/51w1U6rhn0=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sgruszka@redhat.com
Subject: [PATCH v2 4/4] mt76: mt76x02: run mt76x02_edcca_init atomically in mt76_edcca_set
Date:   Sat, 11 May 2019 17:30:10 +0200
Message-Id: <fde3fda80e04bc1957f98ec48bb33485bb60e3c2.1557587336.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1557587336.git.lorenzo@kernel.org>
References: <cover.1557587336.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Run mt76x02_edcca_init atomically in mt76_edcca_set since it runs
concurrently with calibration work and mt76x2_set_channel.
Moreover perform phy calibration atomically

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c | 4 ++++
 drivers/net/wireless/mediatek/mt76/mt76x2/pci_phy.c  | 6 ++++++
 drivers/net/wireless/mediatek/mt76/mt76x2/usb_phy.c  | 5 +++++
 3 files changed, 15 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c b/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c
index 7853078e8ca4..f412c779d8e2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c
@@ -122,11 +122,15 @@ mt76_edcca_set(void *data, u64 val)
 	struct mt76x02_dev *dev = data;
 	enum nl80211_dfs_regions region = dev->dfs_pd.region;
 
+	mutex_lock(&dev->mt76.mutex);
+
 	dev->ed_monitor_enabled = !!val;
 	dev->ed_monitor = dev->ed_monitor_enabled &&
 			  region == NL80211_DFS_ETSI;
 	mt76x02_edcca_init(dev);
 
+	mutex_unlock(&dev->mt76.mutex);
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_phy.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_phy.c
index 7a39a390a7ac..2edf1bd0c18c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_phy.c
@@ -294,10 +294,16 @@ void mt76x2_phy_calibrate(struct work_struct *work)
 	struct mt76x02_dev *dev;
 
 	dev = container_of(work, struct mt76x02_dev, cal_work.work);
+
+	mutex_lock(&dev->mt76.mutex);
+
 	mt76x2_phy_channel_calibrate(dev, false);
 	mt76x2_phy_tssi_compensate(dev);
 	mt76x2_phy_temp_compensate(dev);
 	mt76x2_phy_update_channel_gain(dev);
+
+	mutex_unlock(&dev->mt76.mutex);
+
 	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->cal_work,
 				     MT_CALIBRATE_INTERVAL);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_phy.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_phy.c
index c7208c5375ac..dfd54f9b0e97 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_phy.c
@@ -55,10 +55,15 @@ void mt76x2u_phy_calibrate(struct work_struct *work)
 	struct mt76x02_dev *dev;
 
 	dev = container_of(work, struct mt76x02_dev, cal_work.work);
+
+	mutex_lock(&dev->mt76.mutex);
+
 	mt76x2u_phy_channel_calibrate(dev, false);
 	mt76x2_phy_tssi_compensate(dev);
 	mt76x2_phy_update_channel_gain(dev);
 
+	mutex_unlock(&dev->mt76.mutex);
+
 	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->cal_work,
 				     MT_CALIBRATE_INTERVAL);
 }
-- 
2.20.1

