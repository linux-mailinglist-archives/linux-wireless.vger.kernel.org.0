Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0647E360531
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Apr 2021 11:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbhDOJEa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Apr 2021 05:04:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231842AbhDOJEa (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Apr 2021 05:04:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D1DC61073;
        Thu, 15 Apr 2021 09:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618477447;
        bh=mX00MpGyDvBmSUErvltMQ84mOAb+jkfVbdedpKHU0SE=;
        h=From:To:Cc:Subject:Date:From;
        b=cZV2qiMGn6wFHBEkAlW+EU1Tsu8lMc40zPRKiaPPSMR055xhLhOMKT6HECkESTEW8
         VT6FyP4qDNC6kr2dzi38bpvt8pCY3JaM/dfQvQ68w9mfya63gAsLCsR0QcnxsQYFZ2
         5a66Ld+JvUzy2e7qccEQqDWcJUgMIbd1r1BJEgbuxlDbJ+0PcbGv6gDMcQuJycRLRu
         q1UFGfl/a7/0GTjqkajaewCXvDcHc70DiqM8s57gCviuYp1WZuRXfl8x9KYLw76K1G
         R+NEbs/pK/hq0bw3r+P0HmKwpgY0xemRPkTydhoXmAGqXALJbQhdlz9PjrBfEkmp5i
         VPlLtIqxd+4nA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7921: move hw configuration in mt7921_register_device
Date:   Thu, 15 Apr 2021 11:03:58 +0200
Message-Id: <40649f5e9ce9ab2a96ff4eb0587f82f300988280.1618477272.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Get rid of init work since firmware loading is already performed in
mt7921_init_hardware

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7921/init.c   | 18 ++++++------------
 .../net/wireless/mediatek/mt76/mt7921/mt7921.h |  1 -
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 0aedddb90858..eab6e2dcdb96 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -166,20 +166,10 @@ void mt7921_mac_init(struct mt7921_dev *dev)
 	mt76_connac_mcu_set_rts_thresh(&dev->mt76, 0x92b, 0);
 }
 
-static void mt7921_init_work(struct work_struct *work)
-{
-	struct mt7921_dev *dev = container_of(work, struct mt7921_dev,
-				 init_work);
-
-	mt7921_mcu_set_eeprom(dev);
-	mt7921_mac_init(dev);
-}
-
 static int mt7921_init_hardware(struct mt7921_dev *dev)
 {
 	int ret, idx;
 
-	INIT_WORK(&dev->init_work, mt7921_init_work);
 	spin_lock_init(&dev->token_lock);
 	idr_init(&dev->token);
 
@@ -202,6 +192,10 @@ static int mt7921_init_hardware(struct mt7921_dev *dev)
 	if (ret < 0)
 		return ret;
 
+	ret = mt7921_mcu_set_eeprom(dev);
+	if (ret)
+		return ret;
+
 	/* Beacon and mgmt frames should occupy wcid 0 */
 	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7921_WTBL_STA - 1);
 	if (idx)
@@ -212,6 +206,8 @@ static int mt7921_init_hardware(struct mt7921_dev *dev)
 	dev->mt76.global_wcid.tx_info |= MT_WCID_TX_INFO_SET;
 	rcu_assign_pointer(dev->mt76.wcid[idx], &dev->mt76.global_wcid);
 
+	mt7921_mac_init(dev);
+
 	return 0;
 }
 
@@ -266,8 +262,6 @@ int mt7921_register_device(struct mt7921_dev *dev)
 	if (ret)
 		return ret;
 
-	ieee80211_queue_work(mt76_hw(dev), &dev->init_work);
-
 	return mt7921_init_debugfs(dev);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 5cc01efee989..c34cf3e3a26b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -156,7 +156,6 @@ struct mt7921_dev {
 
 	u16 chainmask;
 
-	struct work_struct init_work;
 	struct work_struct reset_work;
 
 	struct list_head sta_poll_list;
-- 
2.30.2

