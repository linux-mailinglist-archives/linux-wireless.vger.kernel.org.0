Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3A33303E2
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Mar 2021 19:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbhCGSVM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 7 Mar 2021 13:21:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:35592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230522AbhCGSVJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 7 Mar 2021 13:21:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 285CE6513D;
        Sun,  7 Mar 2021 18:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615141269;
        bh=Z/yzF1CfY4eiDaVH7PxeV7h9wRb6klGYTWlRQazPEWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VBpRglsXiXAA6O1QgO6KNWMpPbTalhHmYzwk08kv3/EA73pddLYQRqsKc77gYXcAE
         /084E9wdcrvz/zUXHVrZK2vYh+ML9rAA0OBHnFIHdllIf9WndHYBXznAuBEzWYVt0I
         R7tqrZXky4ObmEc99ZAMXp7cuTwcav0nu4Z35pdCYVK6qI5VOwgZaXenX5SBDZVjyA
         wDUr7q3uq4EGDDu8y4s70voHDj8XkLjJ8hS7MXgJaAjip3+GlfDbMpXk5yvSEMGU87
         hNakr3oQw+H1kRV5zGzIt2Tc9ek2KucuRLNKW3daORC08zbRd8bN50fKxABoyjrjvY
         7wbJrTRotcCfw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH 2/7] mt76: introduce mcu_reset function pointer in mt76_mcu_ops structure
Date:   Sun,  7 Mar 2021 19:20:46 +0100
Message-Id: <7b006e8eb99445b2efcdd7c7b726ba4a1aee0991.1615140875.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1615140875.git.lorenzo@kernel.org>
References: <cover.1615140875.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mcu_reset function pointer in mt76_mcu_ops structure in order
to run hw related reset function for the mcu running on the chipset.
This is a preliminary patch to introduce chip reset for mt7921 devices.

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mcu.c  | 4 ++++
 drivers/net/wireless/mediatek/mt76/mt76.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mcu.c b/drivers/net/wireless/mediatek/mt76/mcu.c
index d3a5e2c4f12a..70624cd07449 100644
--- a/drivers/net/wireless/mediatek/mt76/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mcu.c
@@ -99,6 +99,10 @@ int mt76_mcu_skb_send_and_get_msg(struct mt76_dev *dev, struct sk_buff *skb,
 			dev_kfree_skb(skb);
 	} while (ret == -EAGAIN);
 
+	/* notify driver code to reset the mcu */
+	if (ret == -ETIMEDOUT && dev->mcu_ops->mcu_reset)
+		dev->mcu_ops->mcu_reset(dev);
+
 out:
 	mutex_unlock(&dev->mcu.mutex);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 5d3438d86d2a..bbe6a70851c8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -166,6 +166,7 @@ struct mt76_mcu_ops {
 	int (*mcu_rd_rp)(struct mt76_dev *dev, u32 base,
 			 struct mt76_reg_pair *rp, int len);
 	int (*mcu_restart)(struct mt76_dev *dev);
+	void (*mcu_reset)(struct mt76_dev *dev);
 };
 
 struct mt76_queue_ops {
-- 
2.29.2

