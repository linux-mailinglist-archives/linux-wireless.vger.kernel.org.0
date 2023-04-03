Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F228C6D4222
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Apr 2023 12:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjDCKee (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Apr 2023 06:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjDCKea (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Apr 2023 06:34:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA963A92
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 03:34:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B0EC618B9
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 10:34:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99157C433D2;
        Mon,  3 Apr 2023 10:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680518065;
        bh=kWpo2EvNDB8xd4QQ8cU5YRLk8hn43gPv1G0tFrJQSkk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gPTlpD8la/xFbMEgEJLtgEfwIY3T8QiYhFQ7lYk2HnBzL3FacrAKO7TNhbP793xUQ
         o446iOAXN/w9FzksWPUvMm3kabXTQ3vCBhdRdX4D6WONR2OBWI2eAKh/xiTUilzCUc
         EWGGr1BlEQb/tnEbTQH168SpfsU2GBlwQtmuWFkuKeDb9a5pn6uYLawWMiqOWk5R9C
         eIhcUv1wVQ0r9sjpsumUMjHwRo9w7pfTzKWU3clBpbNIklua5vvR8dAEF+7Z5naybJ
         Pooa1FpbvUvZxU4+7YzsQCU0a0oy+K4ktjOI4PBQk8Dy85HfROopRNJ7YzlmjoLtS+
         9cf8aX3Of8ZFA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 5/6] wifi: mt76: mt7921: get rid of eeprom.h
Date:   Mon,  3 Apr 2023 12:33:59 +0200
Message-Id: <da1006542fa437479c633a172552bedf15680ab6.1680517676.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1680517676.git.lorenzo@kernel.org>
References: <cover.1680517676.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

eeprom.h is mostly empty for mt7921, so get rid of it.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt7921/debugfs.c   |  1 -
 .../wireless/mediatek/mt76/mt7921/eeprom.h    | 30 -------------------
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  1 -
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   |  1 -
 .../wireless/mediatek/mt76/mt7921/mt7921.h    | 11 +++++++
 5 files changed, 11 insertions(+), 33 deletions(-)
 delete mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/eeprom.h

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
index 29d8883268f6..d6b6edba2fec 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
@@ -2,7 +2,6 @@
 /* Copyright (C) 2020 MediaTek Inc. */
 
 #include "mt7921.h"
-#include "eeprom.h"
 
 static int
 mt7921_reg_set(void *data, u64 val)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7921/eeprom.h
deleted file mode 100644
index 4b647278eb30..000000000000
--- a/drivers/net/wireless/mediatek/mt76/mt7921/eeprom.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/* SPDX-License-Identifier: ISC */
-/* Copyright (C) 2020 MediaTek Inc. */
-
-#ifndef __MT7921_EEPROM_H
-#define __MT7921_EEPROM_H
-
-#include "mt7921.h"
-
-enum mt7921_eeprom_field {
-	MT_EE_CHIP_ID =		0x000,
-	MT_EE_VERSION =		0x002,
-	MT_EE_MAC_ADDR =	0x004,
-	MT_EE_WIFI_CONF =	0x07c,
-	MT_EE_HW_TYPE =		0x55b,
-	__MT_EE_MAX =		0x9ff
-};
-
-#define MT_EE_WIFI_CONF_TX_MASK			BIT(0)
-#define MT_EE_WIFI_CONF_BAND_SEL		GENMASK(3, 2)
-
-#define MT_EE_HW_TYPE_ENCAP			BIT(0)
-
-enum mt7921_eeprom_band {
-	MT_EE_NA,
-	MT_EE_5GHZ,
-	MT_EE_2GHZ,
-	MT_EE_DUAL_BAND,
-};
-
-#endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 80c71acfe159..2b1147761724 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -6,7 +6,6 @@
 #include "mt7921.h"
 #include "mac.h"
 #include "mcu.h"
-#include "eeprom.h"
 
 static const struct ieee80211_iface_limit if_limits[] = {
 	{
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index c5e7ad06f877..601d5aadb4f4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -5,7 +5,6 @@
 #include <linux/firmware.h>
 #include "mt7921.h"
 #include "mt7921_trace.h"
-#include "eeprom.h"
 #include "mcu.h"
 #include "mac.h"
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 53d12c4b94e2..813d5b039ac8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -266,6 +266,17 @@ struct mt7921_phy {
 	bool roc_grant;
 };
 
+enum mt7921_eeprom_field {
+	MT_EE_CHIP_ID =		0x000,
+	MT_EE_VERSION =		0x002,
+	MT_EE_MAC_ADDR =	0x004,
+	MT_EE_WIFI_CONF =	0x07c,
+	MT_EE_HW_TYPE =		0x55b,
+	__MT_EE_MAX =		0x9ff
+};
+
+#define MT_EE_HW_TYPE_ENCAP			BIT(0)
+
 #define mt7921_init_reset(dev)		((dev)->hif_ops->init_reset(dev))
 #define mt7921_dev_reset(dev)		((dev)->hif_ops->reset(dev))
 #define mt7921_mcu_init(dev)		((dev)->hif_ops->mcu_init(dev))
-- 
2.39.2

