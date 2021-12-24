Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5EC647EE5F
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Dec 2021 11:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352499AbhLXK6h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Dec 2021 05:58:37 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51856 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352500AbhLXK6g (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Dec 2021 05:58:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64F0262044
        for <linux-wireless@vger.kernel.org>; Fri, 24 Dec 2021 10:58:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907ACC36AEB;
        Fri, 24 Dec 2021 10:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640343515;
        bh=lk8LnXvCf9nF+KeY1S1+nwAN81h348iVwwKqwe1i52w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RhlBjuEE9VSbBxzOCNF4cvIs9b/Pz489b/QHVYzFna1/vCLVmGBtFPTRq4b3MAE24
         d3VMJgtNQwu/jSUsxvkjhRX8f+SAnk4yRSJMp9cQxW5vEfLMd9/nW1UP1mMyFDV+uR
         IPGl5ZwOgAWdGPijaJs4IVj+tXlBLzuAzSyqQ2gyomR2tLbyc8R37jqEbg6aD17G/i
         MBIsHLgLEg2JrFJ5kTecdO0XOSTkLywLzy0onI5udcXfCRYKiRFDSeTwiAmh+ghp5h
         X5YW4EwGvyJSdtLRo0IVeqPmpJSqiVqOaxaxRjzMYQIZpbvqKFCjDqyITsRCuI37Ix
         u/lZqiy3L6BGw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 04/10] mt76: mt7915: rely on mt76_connac_mcu_start_firmware
Date:   Fri, 24 Dec 2021 11:58:05 +0100
Message-Id: <0fef4bac344b6b482c8df728a51937392963e8ec.1640342400.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640342400.git.lorenzo@kernel.org>
References: <cover.1640342400.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rely on mt76_connac_mcu_start_firmware and remove duplicated code.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index b8640422d475..f5d24e03a861 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1941,21 +1941,6 @@ int mt7915_mcu_add_beacon(struct ieee80211_hw *hw,
 				     MCU_EXT_CMD(BSS_INFO_UPDATE), true);
 }
 
-static int mt7915_mcu_start_firmware(struct mt7915_dev *dev, u32 addr,
-				     u32 option)
-{
-	struct {
-		__le32 option;
-		__le32 addr;
-	} req = {
-		.option = cpu_to_le32(option),
-		.addr = cpu_to_le32(addr),
-	};
-
-	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD(FW_START_REQ), &req,
-				 sizeof(req), true);
-}
-
 static int mt7915_mcu_restart(struct mt76_dev *dev)
 {
 	struct {
@@ -2175,7 +2160,7 @@ mt7915_mcu_send_ram_firmware(struct mt7915_dev *dev,
 	if (is_wa)
 		option |= FW_START_WORKING_PDA_CR4;
 
-	return mt7915_mcu_start_firmware(dev, override, option);
+	return mt76_connac_mcu_start_firmware(&dev->mt76, override, option);
 }
 
 static int mt7915_load_ram(struct mt7915_dev *dev)
-- 
2.33.1

