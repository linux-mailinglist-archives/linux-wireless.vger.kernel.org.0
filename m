Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90FC7366CF8
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Apr 2021 15:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235479AbhDUNiC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Apr 2021 09:38:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:51274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230000AbhDUNiB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Apr 2021 09:38:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 90782611F2;
        Wed, 21 Apr 2021 13:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619012248;
        bh=/vqnoRjcgqzl92jVkfyIMhVFYf6dL6ZlyEgLUelraTU=;
        h=From:To:Cc:Subject:Date:From;
        b=nY5VPu79bLKV99GXuxKtIaU439ybyd7U6IYhPGTBw6xIBlA0qb6tAwwVkL2YTKbOo
         75moxHgKzWr+SN/Wrjzv4RwF6EdB/OIPuKUu2ZvR56omxKxKOUJx5gIIokgxwn0Upk
         MA+jCT8lfq0mXPyutt7SRKSQquraGG5Yob9hb31IQEfXBLv3+BEc3CH1WECh8XivEr
         n7vJ1qCkPtaGyPZXMziNbBksHssht6IYqM4kHBYbytMIR43lJstOogE75+Eex0XTDq
         Rs17+J3cCDxjVj4qIcDs7uZe+h2ruJ+SxWXTTy+1ADaLa9DdtuNsOFMenrqBLh9rC6
         EOF5dHC0klFlg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7921: reinit wpdma during drv_own if necessary
Date:   Wed, 21 Apr 2021 15:37:21 +0200
Message-Id: <2144f3c2f177f95bd492763f92100978e22637a6.1619011558.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Check dummy reg to reinitialized WPDMA during driver_own operation

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 43e3bf895b60..740feb0bf04f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -1308,6 +1308,8 @@ int mt7921_mcu_drv_pmctrl(struct mt7921_dev *dev)
 		err = -EIO;
 		goto out;
 	}
+
+	mt7921_wpdma_reinit_cond(dev);
 	clear_bit(MT76_STATE_PM, &mphy->state);
 
 	pm->stats.last_wake_event = jiffies;
-- 
2.30.2

