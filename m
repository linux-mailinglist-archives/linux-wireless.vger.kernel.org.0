Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6D51206F7
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2019 14:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbfLPNUI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Dec 2019 08:20:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:41232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727653AbfLPNUI (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Dec 2019 08:20:08 -0500
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E8E9206D8;
        Mon, 16 Dec 2019 13:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576502407;
        bh=9qbdkbwDNLRoHDabCyvF754nFu1iK+7DbqoRoCM4G+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JJFMDMHIw3TKOekagIW48FPytIHya7RjDQ7tQf1xLQ9/c/+BLkJYW9C08JVEqcvSs
         vv/q1sFkqpeEgMGvM/DuwpOfwlX/eZ6z8Ni+MXfvMCln8x+3UAiV2RzvMDC2FU8FXm
         r37t1yQd3BHnGlmn1AZNqoR2xMP+faQI2QohSqc0=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH v2 1/2] mt76: mt76x02: simplify led reg definitions
Date:   Mon, 16 Dec 2019 14:19:58 +0100
Message-Id: <835892489c0ac97f55bd05cb3a78c3a8864a04e0.1576502217.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1576502217.git.lorenzo@kernel.org>
References: <cover.1576502217.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rely on FIELD_PREP macro for led register definitions and
remove open coding

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x02_regs.h | 12 +++---------
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c |  6 +++---
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_regs.h b/drivers/net/wireless/mediatek/mt76/mt76x02_regs.h
index 21c0f351fa09..3e722276b5c2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_regs.h
@@ -235,15 +235,9 @@
 #define MT_LED_S0(_n)			(MT_LED_S0_BASE + 8 * (_n))
 #define MT_LED_S1_BASE			0x0780
 #define MT_LED_S1(_n)			(MT_LED_S1_BASE + 8 * (_n))
-#define MT_LED_STATUS_OFF_MASK		GENMASK(31, 24)
-#define MT_LED_STATUS_OFF(_v)		(((_v) << __ffs(MT_LED_STATUS_OFF_MASK)) & \
-					 MT_LED_STATUS_OFF_MASK)
-#define MT_LED_STATUS_ON_MASK		GENMASK(23, 16)
-#define MT_LED_STATUS_ON(_v)		(((_v) << __ffs(MT_LED_STATUS_ON_MASK)) & \
-					 MT_LED_STATUS_ON_MASK)
-#define MT_LED_STATUS_DURATION_MASK	GENMASK(15, 8)
-#define MT_LED_STATUS_DURATION(_v)	(((_v) << __ffs(MT_LED_STATUS_DURATION_MASK)) & \
-					 MT_LED_STATUS_DURATION_MASK)
+#define MT_LED_STATUS_OFF		GENMASK(31, 24)
+#define MT_LED_STATUS_ON		GENMASK(23, 16)
+#define MT_LED_STATUS_DURATION		GENMASK(15, 8)
 
 #define MT_FCE_PSE_CTRL			0x0800
 #define MT_FCE_PARAMETERS		0x0804
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index ab717d82d771..f5fe3578f058 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -96,9 +96,9 @@ mt76x02_led_set_config(struct mt76_dev *mdev, u8 delay_on,
 					       mt76);
 	u32 val;
 
-	val = MT_LED_STATUS_DURATION(0xff) |
-	      MT_LED_STATUS_OFF(delay_off) |
-	      MT_LED_STATUS_ON(delay_on);
+	val = FIELD_PREP(MT_LED_STATUS_DURATION, 0xff) |
+	      FIELD_PREP(MT_LED_STATUS_OFF, delay_off) |
+	      FIELD_PREP(MT_LED_STATUS_ON, delay_on);
 
 	mt76_wr(dev, MT_LED_S0(mdev->led_pin), val);
 	mt76_wr(dev, MT_LED_S1(mdev->led_pin), val);
-- 
2.21.0

