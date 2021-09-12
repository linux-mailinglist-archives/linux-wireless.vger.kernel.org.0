Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78FF407E24
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Sep 2021 17:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbhILPvX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 12 Sep 2021 11:51:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229560AbhILPvW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 12 Sep 2021 11:51:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BB3660F56;
        Sun, 12 Sep 2021 15:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631461807;
        bh=M5n1fYvm1nEuJxee8E1/CcgUg31YccAxk+XFUrQDNbc=;
        h=From:To:Cc:Subject:Date:From;
        b=XKwZiflnF6vPyXWZx+qGNmMigWGg1ZIpAhdwKVzfkoGdG3YovnMcIzez+gX70VPLE
         WDgXQmbtHxyLCJ8tx6d01U6z1sws9Oq3Qncun1L0+xG1/pACzntGSq3cXjDQxfsGOW
         v9DBSTAPVrw1Nlb87bkTgBZL4GSSExf9oU5WGdHK04V4XwOJNrnYDD9XLNQ3jNGUdM
         I/exZIbdps7zaawTf+v549yaLwLck6lhYmrRew1I5e1+plHPWT3SjvnLAU9p4GoNLN
         zeIeRzOP4Kuu7fQ6z/qZQ/KO66cOLyx9xNhxRl7hHh12mrT442RpiSv0JPokCZN+hg
         ICv6RUZGoStgw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: mt7915: honor all possible error conditions in mt7915_mcu_init()
Date:   Sun, 12 Sep 2021 17:49:50 +0200
Message-Id: <bc75f22bbc3c1c1e2cd73101a40ddff84e9356a7.1631461720.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Check all possible errors returned in mt7915_mcu_init routine.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 39cba8210242..4b54a3a91241 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -416,7 +416,7 @@ mt7915_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	return mt76_tx_queue_skb_raw(dev, mdev->q_mcu[qid], skb, 0);
 }
 
-static void
+static int
 mt7915_mcu_wa_cmd(struct mt7915_dev *dev, int cmd, u32 a1, u32 a2, u32 a3)
 {
 	struct {
@@ -429,7 +429,7 @@ mt7915_mcu_wa_cmd(struct mt7915_dev *dev, int cmd, u32 a1, u32 a2, u32 a3)
 		},
 	};
 
-	mt76_mcu_send_msg(&dev->mt76, cmd, &req, sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, cmd, &req, sizeof(req), true);
 }
 
 static void
@@ -2933,11 +2933,16 @@ int mt7915_mcu_init(struct mt7915_dev *dev)
 		return ret;
 
 	set_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
-	mt7915_mcu_fw_log_2_host(dev, 0);
-	mt7915_mcu_set_mwds(dev, 1);
-	mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(SET), MCU_WA_PARAM_RED, 0, 0);
+	ret = mt7915_mcu_fw_log_2_host(dev, 0);
+	if (ret)
+		return ret;
 
-	return 0;
+	ret = mt7915_mcu_set_mwds(dev, 1);
+	if (ret)
+		return ret;
+
+	return mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(SET),
+				 MCU_WA_PARAM_RED, 0, 0);
 }
 
 void mt7915_mcu_exit(struct mt7915_dev *dev)
-- 
2.31.1

