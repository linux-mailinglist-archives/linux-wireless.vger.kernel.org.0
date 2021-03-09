Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B533322A0
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Mar 2021 11:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbhCIKJc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Mar 2021 05:09:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:37400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229691AbhCIKJQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Mar 2021 05:09:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0513765257;
        Tue,  9 Mar 2021 10:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615284556;
        bh=ExrBKg4inI96baXa7XVTQenb1XjPd1DKTrvHab2xmZU=;
        h=From:To:Cc:Subject:Date:From;
        b=q+ULo8fAmC8t46aqt8Q/6dXQjN8J63jFF/teoCf0odzyI3WQ+pjb5EMHTauslLb6p
         g1meO0lODdBj085IZOiHNPJ4q4KPDmoey4Knxmq5cgWolh16qhzx6iYnYFM/6D2U0Y
         Xc3SvKIEthX9PjCrWdo+erhjl+pzM1evvucBJIo3ifHdz5wEsjAqyWtUuIrsCztLTO
         kWSdlxRgbUKmmiWp2FiWptcM3frHLeV0h8JgUq9Z9dycXAKwRCIQx127K4qEY8+sC/
         4pyBQKN0WqT7kzcJ8duN9j7cYpxjUcdTXojZb0cWm5/MgahsufevriS+LqjSUFW0CW
         TiNGrkpYSsTDA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        nbd@nbd.name, sean.wang@mediatek.com, leon.yen@mediatek.com
Subject: [PATCH wireless-drivers] mt76: mt7921: fix airtime reporting
Date:   Tue,  9 Mar 2021 11:09:03 +0100
Message-Id: <c05333be0e3e85a50a71bb2de81034fe425e3701.1615284335.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix {tx,rx}_airtime reporting for mt7921 driver. Wrong register definitions
trigger a tx hangs before resetting airtime stats.

Fixes: 163f4d22c118d ("mt76: mt7921: add MAC support")
Tested-by: Leon Yen <leon.yen@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/regs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/regs.h b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
index 18980bb32dee..6dad7f6ab09d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
@@ -135,10 +135,10 @@
 
 #define MT_WTBLON_TOP_BASE		0x34000
 #define MT_WTBLON_TOP(ofs)		(MT_WTBLON_TOP_BASE + (ofs))
-#define MT_WTBLON_TOP_WDUCR		MT_WTBLON_TOP(0x0)
+#define MT_WTBLON_TOP_WDUCR		MT_WTBLON_TOP(0x200)
 #define MT_WTBLON_TOP_WDUCR_GROUP	GENMASK(2, 0)
 
-#define MT_WTBL_UPDATE			MT_WTBLON_TOP(0x030)
+#define MT_WTBL_UPDATE			MT_WTBLON_TOP(0x230)
 #define MT_WTBL_UPDATE_WLAN_IDX		GENMASK(9, 0)
 #define MT_WTBL_UPDATE_ADM_COUNT_CLEAR	BIT(12)
 #define MT_WTBL_UPDATE_BUSY		BIT(31)
-- 
2.29.2

