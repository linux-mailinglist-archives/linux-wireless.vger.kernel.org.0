Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30EB9366934
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Apr 2021 12:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbhDUK3Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Apr 2021 06:29:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239508AbhDUK3L (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Apr 2021 06:29:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D2736144A;
        Wed, 21 Apr 2021 10:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619000918;
        bh=AU5dJtwmc78YFxyQMs8aPuZmCwMUZmdVABTged1cg8Y=;
        h=From:To:Cc:Subject:Date:From;
        b=QJVFec+f1l+20KGOXAH+8dB0dvPvMbVjdAOWrQr2JuC6/pKLMEQITC8rRPZwC78HT
         c54VUKObNF7PVQ1qS76A4MWujzmw1mh0W0keIs6apBcdUXao7zsUilOgzu6PfkUXuf
         8UxTHdQMDYP76ZMXukk4/FoE98VMqG+0YfKX5bGDwPBX4PyUxoPQqp2mHAUyn2I5S4
         jRab5t60Er9j5ZUYqCdO2yS3uQcH/PUpI3XWFcoX2CI9O9GgRHbPp8OVX+Zr5cJZCw
         PSx6viXtvYUNmsIjqEUW5nnUjV5OvI3+jlKp3ZIIn11M1JlMchXM1veC7s6l83gofr
         Ifeb7C3t0jjwg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7921: get rid of mcu_reset function pointer
Date:   Wed, 21 Apr 2021 12:28:33 +0200
Message-Id: <364293ec8609dd254067d8173c1599526ffd662c.1619000828.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

since mcu_reset it used only by mt7921, move the reset callback to
mt7921_mcu_parse_response routine and get rid of the function pointer.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mcu.c        | 4 ----
 drivers/net/wireless/mediatek/mt76/mt76.h       | 1 -
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c | 3 ++-
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mcu.c b/drivers/net/wireless/mediatek/mt76/mcu.c
index 70624cd07449..d3a5e2c4f12a 100644
--- a/drivers/net/wireless/mediatek/mt76/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mcu.c
@@ -99,10 +99,6 @@ int mt76_mcu_skb_send_and_get_msg(struct mt76_dev *dev, struct sk_buff *skb,
 			dev_kfree_skb(skb);
 	} while (ret == -EAGAIN);
 
-	/* notify driver code to reset the mcu */
-	if (ret == -ETIMEDOUT && dev->mcu_ops->mcu_reset)
-		dev->mcu_ops->mcu_reset(dev);
-
 out:
 	mutex_unlock(&dev->mcu.mutex);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index cc5d95aeebbd..3b09ea8176a3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -168,7 +168,6 @@ struct mt76_mcu_ops {
 	int (*mcu_rd_rp)(struct mt76_dev *dev, u32 base,
 			 struct mt76_reg_pair *rp, int len);
 	int (*mcu_restart)(struct mt76_dev *dev);
-	void (*mcu_reset)(struct mt76_dev *dev);
 };
 
 struct mt76_queue_ops {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 5bdb9914ead8..43e3bf895b60 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -162,6 +162,8 @@ mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 	if (!skb) {
 		dev_err(mdev->dev, "Message %08x (seq %d) timeout\n",
 			cmd, seq);
+		mt7921_reset(mdev);
+
 		return -ETIMEDOUT;
 	}
 
@@ -974,7 +976,6 @@ int mt7921_mcu_init(struct mt7921_dev *dev)
 		.mcu_skb_send_msg = mt7921_mcu_send_message,
 		.mcu_parse_response = mt7921_mcu_parse_response,
 		.mcu_restart = mt7921_mcu_restart,
-		.mcu_reset = mt7921_reset,
 	};
 
 	dev->mt76.mcu_ops = &mt7921_mcu_ops;
-- 
2.30.2

