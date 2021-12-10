Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 850A146FCB1
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Dec 2021 09:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbhLJI0u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Dec 2021 03:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbhLJI0u (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Dec 2021 03:26:50 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5435C061746
        for <linux-wireless@vger.kernel.org>; Fri, 10 Dec 2021 00:23:15 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e131-20020a25d389000000b005fb5e6eb757so15407858ybf.22
        for <linux-wireless@vger.kernel.org>; Fri, 10 Dec 2021 00:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=m5w0obK8XpECrHwe6XhlaqtvTKCo56VwLWe/17hHP5w=;
        b=W2QIjE051FGvUPlbVzwu8+TDwsJbys+QyI7+4v6rmg6eVwix7RJ16f3U2l9pmWuwQ2
         aEZGD0N+3hRv0WHx/zbKkXAE+xye/J2o4/rn9q+EH/6Oa57nmqY68aLpHFMwdX6tfQd6
         m8iEusC9qG2WeaDl6u8Rz7IXkZOlOfig5fXMe8EDDXpTBpKi/lFokdIEDrZEMk50kkB+
         MyzSqWF4zYYMrY05e5P3bVwQ+8PSQdK6pSVGqg3hPRGB7b9flBvLMxa9eMzjQUAc3ICm
         Cki1vxFHUgVBtrB9GNZM+AAYeRJfM098gY/qmM0OzQpf4+OR/KcgIFCAHIEf98ufnbxc
         2jxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=m5w0obK8XpECrHwe6XhlaqtvTKCo56VwLWe/17hHP5w=;
        b=1muGJTPQm299NKIgM0x1ws8ROJh9o8tEjHB+O6OXBbpZBL0kqehGCo5aO+DASXsE7a
         ayBUEu5EuXFCdSJ6cqWXk4ftZ6f057I/xUMc1VeyG8XksLXRkj1njkita3cwARwshn+j
         9uDhazDF1+DRYsRi1CGwpfPbRYnxPdO+9NuglF66rDx27wP9bV1oQGPhFJA8slYJEmAW
         faaN44UXSDldCVQxgpQG0ALirDvlyN+6p2iW29pyr6NJsscuEBg5XQSbGocW5KNtNFW+
         ASobzrSQIMHn569xt5wKMOzIwj6gfCHWsJLbdgLp8wO98veZqNln7icTwLIm6GQmXSyc
         QQ5w==
X-Gm-Message-State: AOAM533A/2l9JXBmtaBU8vof7H4gfObcowok+gTYHLvJPvEz9Jf0DnTG
        FL6xzGryhfdtfQ3ZTjKxKQqpU9aikLhc
X-Google-Smtp-Source: ABdhPJyhHAlYo0oWl5X+SXK54pI4d0XJ6M2S1VMZI3ZARevg8tX4lMUeQSC9jKmmfqK3xCmTy0NfgUpKe9pS
X-Received: from tzungbi-z840.tpe.corp.google.com ([2401:fa00:1:10:7fdb:7edf:3c09:a8eb])
 (user=tzungbi job=sendgmr) by 2002:a25:ade0:: with SMTP id
 d32mr12483108ybe.510.1639124595078; Fri, 10 Dec 2021 00:23:15 -0800 (PST)
Date:   Fri, 10 Dec 2021 16:22:47 +0800
Message-Id: <20211210082247.977043-1-tzungbi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH] mt76: mt7921: reduce log severity levels for informative messages
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
Reduces the severity level to info.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 6ada1ebe7d68..99b144fd8db5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -882,7 +882,7 @@ static int mt7921_load_firmware(struct mt7921_dev *dev)
 	dev->mt76.hw->wiphy->wowlan = &mt76_connac_wowlan_support;
 #endif /* CONFIG_PM */
 
-	dev_err(dev->mt76.dev, "Firmware init done\n");
+	dev_info(dev->mt76.dev, "Firmware init done\n");
 
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

