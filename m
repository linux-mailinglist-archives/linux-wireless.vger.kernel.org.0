Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 124F81C10E3
	for <lists+linux-wireless@lfdr.de>; Fri,  1 May 2020 12:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbgEAKgf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 May 2020 06:36:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:43572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728480AbgEAKge (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 May 2020 06:36:34 -0400
Received: from lore-desk.lan (unknown [151.48.155.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B32D206B8;
        Fri,  1 May 2020 10:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588329393;
        bh=6kM7lz9AESCKj2V9D/ogrjm+3ln+XLyrh47nhdiAx1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HZXE/oqgKAex9MDdgHAXlFgETZRp+A283sjX1jrI3m2cTgDmz5SsV22UiJ6HECnKR
         +Cwac4IhEoPj+OYG3FHSYb7QrfjneMVIgkZmU92IcBNlf3mf7eGfxzmt76hr19+xzB
         OqRocdz9NSov8ctw80iogX3+Jx/Ks5KmnpfZciEg=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, linux-mediatek@lists.infradead.org,
        soul.huang@mediatek.com
Subject: [PATCH 1/7] mt76: mt7615: introduce support for hardware beacon filter
Date:   Fri,  1 May 2020 12:36:11 +0200
Message-Id: <cc5d2dfc7f95bd2dbd06c76ee69676fbfdb482e4.1588329170.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1588329170.git.lorenzo@kernel.org>
References: <cover.1588329170.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce support for hw beacon filter if available in the firmware

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 41 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   |  2 +
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  2 +
 3 files changed, 45 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 6d536088f6c8..0ae981a38f48 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -2646,6 +2646,47 @@ void m7615_mcu_set_ps_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 				    &req, sizeof(req), false);
 }
 
+int mt7615_mcu_set_bss_pm(struct mt7615_dev *dev, struct ieee80211_vif *vif,
+			  bool enable)
+{
+	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
+	struct {
+		u8 bss_idx;
+		u8 dtim_period;
+		__le16 aid;
+		__le16 bcn_interval;
+		__le16 atim_window;
+		u8 uapsd;
+		u8 bmc_delivered_ac;
+		u8 bmc_triggered_ac;
+		u8 pad;
+	} req = {
+		.bss_idx = mvif->idx,
+		.aid = cpu_to_le16(vif->bss_conf.aid),
+		.dtim_period = vif->bss_conf.dtim_period,
+		.bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int),
+	};
+	struct {
+		u8 bss_idx;
+		u8 pad[3];
+	} req_hdr = {
+		.bss_idx = mvif->idx,
+	};
+	int err;
+
+	if (vif->type != NL80211_IFTYPE_STATION ||
+	    !mt7615_firmware_offload(dev))
+		return -ENOTSUPP;
+
+	err = __mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SET_BSS_ABORT,
+				  &req_hdr, sizeof(req_hdr), false);
+	if (err < 0 || !enable)
+		return err;
+
+	return __mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SET_BSS_CONNECTED,
+				   &req, sizeof(req), false);
+}
+
 int mt7615_mcu_set_channel_domain(struct mt7615_phy *phy)
 {
 	struct mt76_phy *mphy = phy->mt76;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index 032b5f98608e..08dcfadceaf6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -419,6 +419,8 @@ enum {
 	MCU_CMD_START_HW_SCAN = MCU_CE_PREFIX | 0x03,
 	MCU_CMD_SET_PS_PROFILE = MCU_CE_PREFIX | 0x05,
 	MCU_CMD_SET_CHAN_DOMAIN = MCU_CE_PREFIX | 0x0f,
+	MCU_CMD_SET_BSS_CONNECTED = MCU_CE_PREFIX | 0x16,
+	MCU_CMD_SET_BSS_ABORT = MCU_CE_PREFIX | 0x17,
 	MCU_CMD_CANCEL_HW_SCAN = MCU_CE_PREFIX | 0x1b,
 	MCU_CMD_SCHED_SCAN_ENABLE = MCU_CE_PREFIX | 0x61,
 	MCU_CMD_SCHED_SCAN_REQ = MCU_CE_PREFIX | 0x62,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 2321a1f23ec8..fdb20fbdfb90 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -474,6 +474,8 @@ int mt7615_mac_wtbl_update_key(struct mt7615_dev *dev,
 			       enum set_key_cmd cmd);
 void mt7615_mac_reset_work(struct work_struct *work);
 
+int mt7615_mcu_set_bss_pm(struct mt7615_dev *dev, struct ieee80211_vif *vif,
+			  bool enable);
 int mt7615_mcu_wait_response(struct mt7615_dev *dev, int cmd, int seq);
 int mt7615_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
 			int len, bool wait_resp);
-- 
2.25.4

