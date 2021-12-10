Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7764146FD8B
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Dec 2021 10:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236579AbhLJJVd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Dec 2021 04:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbhLJJVd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Dec 2021 04:21:33 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74084C061746
        for <linux-wireless@vger.kernel.org>; Fri, 10 Dec 2021 01:17:58 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id t184-20020a2546c1000000b006008b13c80bso15746504yba.1
        for <linux-wireless@vger.kernel.org>; Fri, 10 Dec 2021 01:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=9CJ4nkBMRuxK4SSkNM4ap1zouh60oyFPsU/ELuKKgck=;
        b=Ir9SzvbgbyXCoADDrhwtz+KS5nFpEppthfgfk1R2pL7UOrzEEup1fY3cN/KFYmf5lx
         GwoLZ+o8wdVQM1h7FBuYy5JBmXf5WF5eJGO3+Yro5iTFDxZtKNEsjh7Mr5FiIIx/P3ky
         6O0CFoY6CmcrYUwVQMQ/4atz/hD5g4dlUInq9GTooTPIEaEXhJfK1z191Q75c8ty2PUK
         EnHuTH8EgAvXUdDs6pRlogofebJZ4rg3Z6b/kevTQYrAQEDEvRCDQlKKEtPIsCnge58L
         2j6DYZUctmLUxkDfYa+EebCmMiINpQxJHO8ffYszvHnSft3wU9vNBMWkrs+FQWiXaj9n
         VpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=9CJ4nkBMRuxK4SSkNM4ap1zouh60oyFPsU/ELuKKgck=;
        b=ReDyjkjT80cqAiJowD4v8GPWDLVuW4NVPz3PaOgC6UjzOqKC7UFKqLE7FGtSrt4n/C
         zcSRHrLem3Hmr1y3LhyM4TGqRG9Nloj5nigO6A8OCDELlCkVM5us52yYr5Cgh6hAdssK
         fJg3UXHEeu0KMdhP48F/mIQKOn22UpWg2IAwT+l1JPQRKSJYAKp/piPokPFIK5cmgemy
         +2gCk0Tzs/NvqTDG41r8fkM33U2CPXx62ztqKu6P/ttyzmQCfiyTiUNt72w1hFRfRJtr
         Vk1rfRAA8VgJX+zdRZMp6QV16oKoiQI4paktokZIfJbO/rf+uajHyv3jVKPYq0xP+GKz
         8qvg==
X-Gm-Message-State: AOAM5332B9MLJmYRoRHVclfFAGzkLtLBIXGc5+qgUOvM1bBMXb8yxpFU
        BlLtYf6XA3FSusrr58LL0T2bkVW3+8Or
X-Google-Smtp-Source: ABdhPJzaXkHhrvQwQArRlKNxmjtyYtnhjBRqP0OwC9I8b5nWLvzMBUlpFM96pHvXuROD9qh2sVJg6TXl4xp6
X-Received: from tzungbi-z840.tpe.corp.google.com ([2401:fa00:1:10:7fdb:7edf:3c09:a8eb])
 (user=tzungbi job=sendgmr) by 2002:a25:8e04:: with SMTP id
 p4mr14339827ybl.165.1639127877702; Fri, 10 Dec 2021 01:17:57 -0800 (PST)
Date:   Fri, 10 Dec 2021 17:17:46 +0800
Message-Id: <20211210091746.1010113-1-tzungbi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v2] mt76: mt7921: reduce log severity levels for informative messages
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     nbd@nbd.name, lorenzo.bianconi83@gmail.com, ryder.lee@mediatek.com,
        kvalo@codeaurora.org
Cc:     shayne.chen@mediatek.com, sean.wang@mediatek.com,
        linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, tzungbi@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

"ASIC revision" and "Firmware init done" shouldn't be error messages.
Reduces the severity levels.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
Changes from v1[1]:
- Use dbg level for "Firmware init done" message.
- Modify commit message accordingly.

[1]: https://patchwork.kernel.org/project/linux-wireless/patch/20211210082247.977043-1-tzungbi@google.com/

 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 6ada1ebe7d68..a57ca4ad8cab 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -882,7 +882,7 @@ static int mt7921_load_firmware(struct mt7921_dev *dev)
 	dev->mt76.hw->wiphy->wowlan = &mt76_connac_wowlan_support;
 #endif /* CONFIG_PM */
 
-	dev_err(dev->mt76.dev, "Firmware init done\n");
+	dev_dbg(dev->mt76.dev, "Firmware init done\n");
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 305b63fa1a8a..8c53e376aa4e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -188,7 +188,7 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 	tasklet_init(&dev->irq_tasklet, mt7921_irq_tasklet, (unsigned long)dev);
 	mdev->rev = (mt7921_l1_rr(dev, MT_HW_CHIPID) << 16) |
 		    (mt7921_l1_rr(dev, MT_HW_REV) & 0xff);
-	dev_err(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
+	dev_info(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
 
 	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA, 0);
 
-- 
2.34.1.173.g76aa8bc2d0-goog

