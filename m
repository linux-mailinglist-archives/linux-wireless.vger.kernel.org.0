Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F613298161
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Oct 2020 11:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415317AbgJYK4a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 25 Oct 2020 06:56:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:34758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729434AbgJYK43 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 25 Oct 2020 06:56:29 -0400
Received: from localhost.localdomain (unknown [151.66.125.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B7D3222D9;
        Sun, 25 Oct 2020 10:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603623389;
        bh=nqcfKlngMYbe5CURXz47Q6fr00okgSrEeYnJW/ieuRU=;
        h=From:To:Cc:Subject:Date:From;
        b=IKJe/Sx7LEGKNvC0+fFInLhaqzB/DeLaEP9FTmsYfgPQaHPQjUlV5Wp8Urgi8OyMh
         eN3iCFrXuUGdCYweETCDC/w7MYl1OyTCJJQeeisGS2zM9MUxiWDS2fFUNUnkKrjQsX
         ws0bQJtxqBcnqhxJQMgR0GQKpFeJfPeeCQHEv1+0=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH] mt76: mt7915: make mt7915_eeprom_read static
Date:   Sun, 25 Oct 2020 11:56:16 +0100
Message-Id: <668602a204de889fd6700950538027f50a36475d.1603623178.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Make mt7915_eeprom_read routine static since it is used only in eeprom.c

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c | 9 ++-------
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h | 1 -
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index 7deba7ebd68a..cf3caa032038 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -4,16 +4,11 @@
 #include "mt7915.h"
 #include "eeprom.h"
 
-static inline bool mt7915_efuse_valid(u8 val)
-{
-	return !(val == 0xff);
-}
-
-u32 mt7915_eeprom_read(struct mt7915_dev *dev, u32 offset)
+static u32 mt7915_eeprom_read(struct mt7915_dev *dev, u32 offset)
 {
 	u8 *data = dev->mt76.eeprom.data;
 
-	if (!mt7915_efuse_valid(data[offset]))
+	if (data[offset] == 0xff)
 		mt7915_mcu_get_eeprom(dev, offset);
 
 	return data[offset];
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 89cabda64f41..984fb5f90af9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -261,7 +261,6 @@ void mt7915_unregister_device(struct mt7915_dev *dev);
 int mt7915_register_ext_phy(struct mt7915_dev *dev);
 void mt7915_unregister_ext_phy(struct mt7915_dev *dev);
 int mt7915_eeprom_init(struct mt7915_dev *dev);
-u32 mt7915_eeprom_read(struct mt7915_dev *dev, u32 offset);
 int mt7915_eeprom_get_target_power(struct mt7915_dev *dev,
 				   struct ieee80211_channel *chan,
 				   u8 chain_idx);
-- 
2.26.2

