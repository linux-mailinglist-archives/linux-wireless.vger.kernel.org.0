Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66AC13636C8
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Apr 2021 18:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbhDRQqn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Apr 2021 12:46:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:49934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232212AbhDRQqm (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Apr 2021 12:46:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8CCD761359;
        Sun, 18 Apr 2021 16:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618764374;
        bh=Qcyjit270av8s5rkw1lAptBR1FzoPr89sm1FbOGdEZc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PFAjWJi24YKxW9eep46oZYAKtiesEfN/ITqORsA+RdCxK/37th8EB1osAoXjSezQs
         nYj921GRXdt9xfzGFpSNby81/9+aZpv9oWijPf4AwvWHEm8sMwDnSaoC7DKyJMTw6j
         nUX3thO+7Vm6fDw9226DHWhEEUtjxJha0k/GususjCdI/oVJcX7aP0ENsaLKbPBR8W
         sQOhX9dcZ2qLic5I+P/+KdAy0tDxACz0Kk6nblW/nHEZvdgjHwbiaDG6isBcoy+iHP
         EmvzUgClrCcbEBJg8q3npG+h6ZsgV9tqF93zp0L3OzMWp4hIEa+ottLMBS7voagbF/
         5QPnv/JT4IHFg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH 14/19] mt76: mt7615: rely on pm refcounting in mt7615_led_set_config
Date:   Sun, 18 Apr 2021 18:45:40 +0200
Message-Id: <8ca5f4f25fbf630bc6ab23852d2f76b710c47c21.1618763001.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1618763000.git.lorenzo@kernel.org>
References: <cover.1618763000.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rely on mt76_connac_pm_ref/mt76_connac_pm_unref utility routines in
mt7615_led_set_config

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
index 49540b00519d..736d19699a03 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
@@ -82,7 +82,7 @@ mt7615_led_set_config(struct led_classdev *led_cdev,
 	mt76 = container_of(led_cdev, struct mt76_dev, led_cdev);
 	dev = container_of(mt76, struct mt7615_dev, mt76);
 
-	if (test_bit(MT76_STATE_PM, &mt76->phy.state))
+	if (!mt76_connac_pm_ref(&dev->mphy, &dev->pm))
 		return;
 
 	val = FIELD_PREP(MT_LED_STATUS_DURATION, 0xffff) |
@@ -100,6 +100,8 @@ mt7615_led_set_config(struct led_classdev *led_cdev,
 		val |= MT_LED_CTRL_POLARITY(mt76->led_pin);
 	addr = mt7615_reg_map(dev, MT_LED_CTRL);
 	mt76_wr(dev, addr, val);
+
+	mt76_connac_pm_unref(&dev->pm);
 }
 
 static int
-- 
2.30.2

