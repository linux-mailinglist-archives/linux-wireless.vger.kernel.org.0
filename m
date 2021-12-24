Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0548247EE61
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Dec 2021 11:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352506AbhLXK6l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Dec 2021 05:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352500AbhLXK6l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Dec 2021 05:58:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EC7C061401
        for <linux-wireless@vger.kernel.org>; Fri, 24 Dec 2021 02:58:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DDC0CB82288
        for <linux-wireless@vger.kernel.org>; Fri, 24 Dec 2021 10:58:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94BBEC36AE8;
        Fri, 24 Dec 2021 10:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640343518;
        bh=H1hyuFdmZF3eDVqahdWredqRjzqpGo8w/O82kiI1EiM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TZGKoYTXwLE5sAPDQ/TNqec20dDKfM2adLpV5x9JozaxKUL+BQeq7df/Few3pentl
         3/5CJKCjyJ1lv8nBAoB80TvOZYBn/FrgDEry9HTbt9slLH+cy54sEqvGNPecCnbzt6
         jgS6828QINfWqf/IjP0hDEJUdJjIlsr6jteDpw5oTfhl5q9NiyHxnjogK9eDykR7sr
         4zM3APZ/DzlNgLuHNaCJwlLHwbo6rECIp+D39WMtenZTB945ONQUQWsMYGoFWZ7YnV
         zfe8Z+bYOIMxjlsJ2uCJ/E/S7POrtEAEYROnhIxV+BSNgb8EU8HPfTTjkDDC0uVScL
         tdM6rWBs0A5cg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 06/10] mt76: mt7915: rely on mt76_connac_mcu_patch_sem_ctrl/mt76_connac_mcu_start_patch
Date:   Fri, 24 Dec 2021 11:58:07 +0100
Message-Id: <d6e0bb132508e73ca9b6fcd1b25b2d63439d5bde.1640342400.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640342400.git.lorenzo@kernel.org>
References: <cover.1640342400.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rely on mt76_connac_mcu_patch_sem_ctrl/mt76_connac_mcu_start_patch
routine in mt7915 driver and remove duplicated code.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 31 ++-----------------
 1 file changed, 3 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 77fa79ca8719..3eaf230b452e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1941,31 +1941,6 @@ int mt7915_mcu_add_beacon(struct ieee80211_hw *hw,
 				     MCU_EXT_CMD(BSS_INFO_UPDATE), true);
 }
 
-static int mt7915_mcu_patch_sem_ctrl(struct mt7915_dev *dev, bool get)
-{
-	struct {
-		__le32 op;
-	} req = {
-		.op = cpu_to_le32(get ? PATCH_SEM_GET : PATCH_SEM_RELEASE),
-	};
-
-	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD(PATCH_SEM_CONTROL), &req,
-				 sizeof(req), true);
-}
-
-static int mt7915_mcu_start_patch(struct mt7915_dev *dev)
-{
-	struct {
-		u8 check_crc;
-		u8 reserved[3];
-	} req = {
-		.check_crc = 0,
-	};
-
-	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD(PATCH_FINISH_REQ), &req,
-				 sizeof(req), true);
-}
-
 static int mt7915_driver_own(struct mt7915_dev *dev, u8 band)
 {
 	mt76_wr(dev, MT_TOP_LPCR_HOST_BAND(band), MT_TOP_LPCR_HOST_DRV_OWN);
@@ -2011,7 +1986,7 @@ static int mt7915_load_patch(struct mt7915_dev *dev)
 	const char *patch;
 	int i, ret, sem;
 
-	sem = mt7915_mcu_patch_sem_ctrl(dev, 1);
+	sem = mt76_connac_mcu_patch_sem_ctrl(&dev->mt76, 1);
 	switch (sem) {
 	case PATCH_IS_DL:
 		return 0;
@@ -2070,12 +2045,12 @@ static int mt7915_load_patch(struct mt7915_dev *dev)
 		}
 	}
 
-	ret = mt7915_mcu_start_patch(dev);
+	ret = mt76_connac_mcu_start_patch(&dev->mt76);
 	if (ret)
 		dev_err(dev->mt76.dev, "Failed to start patch\n");
 
 out:
-	sem = mt7915_mcu_patch_sem_ctrl(dev, 0);
+	sem = mt76_connac_mcu_patch_sem_ctrl(&dev->mt76, 0);
 	switch (sem) {
 	case PATCH_REL_SEM_SUCCESS:
 		break;
-- 
2.33.1

