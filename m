Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5311C10E4
	for <lists+linux-wireless@lfdr.de>; Fri,  1 May 2020 12:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbgEAKgk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 May 2020 06:36:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:43626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728480AbgEAKgj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 May 2020 06:36:39 -0400
Received: from lore-desk.lan (unknown [151.48.155.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E174D206B8;
        Fri,  1 May 2020 10:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588329399;
        bh=syDh+CbWHG+FupzW7mAHePHKP5kwkV5zNnIQC5lcJzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pdeL6D9eFNTqqXkQiiryRrngFkHxXCFOWYPdBxmYTMCCorQ9k3Zx6udx9zZp1UFNH
         HnpIeb30gqz6aJWc5FUkU8pDJ6y8uChwdozpC1X9VOZJXX6qRRDdZzcSfr3Xu6Q2dB
         N4HomLA+HDAm/WEDVSjClKa2Vb4/zLszzg3Lmk24=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, linux-mediatek@lists.infradead.org,
        soul.huang@mediatek.com
Subject: [PATCH 2/7] mt76: mt7615: introduce mt7615_mcu_set_hif_suspend mcu command
Date:   Fri,  1 May 2020 12:36:12 +0200
Message-Id: <4ad1f308b355118d26f2b854151a6b8d51154813.1588329170.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1588329170.git.lorenzo@kernel.org>
References: <cover.1588329170.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Introduce the mt7615_mcu_set_hif_suspend mcu command, which is usually
used to configure the interface including PCIe, USB or SDIO to the right
state during operation suspend / resume.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 36 ++++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   |  1 +
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  2 ++
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 0ae981a38f48..95cb239b03e5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -194,7 +194,8 @@ mt7615_mcu_parse_response(struct mt7615_dev *dev, int cmd,
 		break;
 	case MCU_UNI_CMD_DEV_INFO_UPDATE:
 	case MCU_UNI_CMD_BSS_INFO_UPDATE:
-	case MCU_UNI_CMD_STA_REC_UPDATE: {
+	case MCU_UNI_CMD_STA_REC_UPDATE:
+	case MCU_UNI_CMD_HIF_CTRL: {
 		struct mt7615_mcu_uni_event *event;
 
 		skb_pull(skb, sizeof(*rxd));
@@ -3212,3 +3213,36 @@ int mt7615_mcu_apply_tx_dpd(struct mt7615_phy *phy)
 
 	return ret;
 }
+
+int mt7615_mcu_set_hif_suspend(struct mt7615_dev *dev, bool suspend)
+{
+	struct {
+		struct {
+			u8 hif_type; /* 0x0: HIF_SDIO
+				      * 0x1: HIF_USB
+				      * 0x2: HIF_PCIE
+				      */
+			u8 pad[3];
+		} __packed hdr;
+		struct hif_suspend_tlv {
+			__le16 tag;
+			__le16 len;
+			u8 suspend;
+		} __packed hif_suspend;
+	} req = {
+		.hif_suspend = {
+			.tag = cpu_to_le16(0), /* 0: UNI_HIF_CTRL_BASIC */
+			.len = cpu_to_le16(sizeof(struct hif_suspend_tlv)),
+			.suspend = suspend,
+		},
+	};
+
+	if (mt76_is_mmio(&dev->mt76))
+		req.hdr.hif_type = 2;
+	else if (mt76_is_usb(&dev->mt76))
+		req.hdr.hif_type = 1;
+
+	return __mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_HIF_CTRL,
+				   &req, sizeof(req), true);
+}
+EXPORT_SYMBOL_GPL(mt7615_mcu_set_hif_suspend);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index 08dcfadceaf6..1579ad944479 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -280,6 +280,7 @@ enum {
 	MCU_UNI_CMD_DEV_INFO_UPDATE = MCU_UNI_PREFIX | 0x01,
 	MCU_UNI_CMD_BSS_INFO_UPDATE = MCU_UNI_PREFIX | 0x02,
 	MCU_UNI_CMD_STA_REC_UPDATE = MCU_UNI_PREFIX | 0x03,
+	MCU_UNI_CMD_HIF_CTRL = MCU_UNI_PREFIX | 0x07,
 };
 
 struct mt7615_mcu_uni_event {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index fdb20fbdfb90..6a26555dcce6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -531,6 +531,8 @@ int mt7615_dfs_init_radar_detector(struct mt7615_phy *phy);
 int mt7615_init_debugfs(struct mt7615_dev *dev);
 int mt7615_mcu_wait_response(struct mt7615_dev *dev, int cmd, int seq);
 
+int mt7615_mcu_set_hif_suspend(struct mt7615_dev *dev, bool suspend);
+
 int __mt7663_load_firmware(struct mt7615_dev *dev);
 
 /* usb */
-- 
2.25.4

