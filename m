Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A8F3AC8D3
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 12:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbhFRKdB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 06:33:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:47480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229768AbhFRKdA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 06:33:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BDC6661241;
        Fri, 18 Jun 2021 10:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624012251;
        bh=J25cZJXLCJmx/gLqxoj3OGt7A2sAsMm6FM3lADYQxLc=;
        h=From:To:Cc:Subject:Date:From;
        b=F0ZkxO+w0uydWX/9m87tniZ7qtmBBPPohAlOot1JwH8sodQ28kOT7hU4FqKVPUPwG
         p3rgiUeFukISu0+0dV1/LPHtejV3dmPwU8K3VFHFJ5wNwAIDKgFd7QpvMjdMoB5N71
         XRMxGwWyYCJPe7Spxy/W9P2w8CvZ6OqSlw14q0dhaySiAtNhPaevBq9D8lWm8ULAVC
         4DEcGrhuYClsQPCRCtKZLF6vdzCYX4FKJXdvqK4HruFO/jMhPAkar1m+wtuEEoxgos
         8MVpq/4f9Dn8YsdhsEdb4xFrPgnYdDcHqt8u34lELeobKurId01s25w65i6dM1nOQY
         pgnoTTwgobCwA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7921: allow chip reset during device restart
Date:   Fri, 18 Jun 2021 12:30:47 +0200
Message-Id: <96d84ef577cb558969a56ed42e68769eac0d3a1c.1624012209.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Disable chip full reset just during device probing but allow
it during hw restart.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/init.c   | 8 +++++++-
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c    | 8 +++++---
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h | 3 ++-
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 9925c15ac9df..a9ce10b98827 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -236,7 +236,13 @@ int mt7921_register_device(struct mt7921_dev *dev)
 	if (ret)
 		return ret;
 
-	return mt76_connac_mcu_set_deep_sleep(&dev->mt76, dev->pm.ds_enable);
+	ret = mt76_connac_mcu_set_deep_sleep(&dev->mt76, dev->pm.ds_enable);
+	if (ret)
+		return ret;
+
+	dev->hw_init_done = true;
+
+	return 0;
 }
 
 void mt7921_unregister_device(struct mt7921_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index dbcc8146e87a..e97d3a6b2724 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1376,11 +1376,13 @@ void mt7921_reset(struct mt76_dev *mdev)
 {
 	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
 
-	if (!test_bit(MT76_STATE_RUNNING, &dev->mphy.state))
+	if (!dev->hw_init_done)
 		return;
 
-	if (!dev->hw_full_reset)
-		queue_work(dev->mt76.wq, &dev->reset_work);
+	if (dev->hw_full_reset)
+		return;
+
+	queue_work(dev->mt76.wq, &dev->reset_work);
 }
 
 static void
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 087067e7ea5b..a1962bfb4f67 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -160,7 +160,8 @@ struct mt7921_dev {
 	u16 chainmask;
 
 	struct work_struct reset_work;
-	bool hw_full_reset;
+	bool hw_full_reset:1;
+	bool hw_init_done:1;
 
 	struct list_head sta_poll_list;
 	spinlock_t sta_poll_lock;
-- 
2.31.1

