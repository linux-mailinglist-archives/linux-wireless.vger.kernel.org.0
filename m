Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEAB3F46F2
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Aug 2021 10:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235733AbhHWIxx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Aug 2021 04:53:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235691AbhHWIxw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Aug 2021 04:53:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E77FD6102A;
        Mon, 23 Aug 2021 08:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629708790;
        bh=CCz//cD/JjIqiIAf5rENP3Io9oGbhFBtMxemeirWFF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=agAvQmIz16guFFEjdo1y1rHSHLwJwRpAudZa3gV+Rh0tq0CDY983ZeaAWvoFwVXc0
         Z9QYD2mh5nI0Q3GAdvJ2Wumyio9zG+GKvtx6IyDA3OhRbnE5X6rOIKMPwbOZYDgVwJ
         t3v7ETVivDYddMu/A6rK+l5H0E8lR8btT0EGSX+nYvCtFbSuWDH5MO/SVRwLS23CSO
         ULeMnXDOxGJVo9mL46DU267yGCFjJGdEcaGQ1TppePVAu9BGphfUx0ojVkEd/8eVDL
         9yBFElMBFsy8OjV5eRw/h8eGgvX/feAbB1M7vy3NCYRPz1rx0wPZCib1SYVYEb8cOD
         J3+Im3pAvwgtQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, chui-hao.chiu@mediatek.com
Subject: [PATCH v3 mac80211-next 4/7] mt76: mt7915: introduce mt7915_mcu_twt_agrt_update mcu command
Date:   Mon, 23 Aug 2021 10:52:42 +0200
Message-Id: <e5ce4675fe275adc7b9b58ebd2e300b7ad773b0f.1629706968.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629706968.git.lorenzo@kernel.org>
References: <cover.1629706968.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a preliminary patch to add TWT support to mt7915

Tested-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 50 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  9 ++++
 .../wireless/mediatek/mt76/mt7915/mt7915.h    | 19 +++++++
 3 files changed, 78 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 50b89d41822a..8bf3d08884f4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3893,3 +3893,53 @@ int mt7915_mcu_get_rx_rate(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 
 	return ret;
 }
+
+#define TWT_AGRT_TRIGGER	BIT(0)
+#define TWT_AGRT_ANNOUNCE	BIT(1)
+#define TWT_AGRT_PROTECT	BIT(2)
+
+int mt7915_mcu_twt_agrt_update(struct mt7915_dev *dev,
+			       struct mt7915_vif *mvif,
+			       struct mt7915_twt_flow *flow,
+			       int cmd)
+{
+	struct {
+		u8 tbl_idx;
+		u8 cmd;
+		u8 own_mac_idx;
+		u8 flowid; /* 0xff for group id */
+		__le16 peer_id; /* specify the peer_id (msb=0)
+				 * or group_id (msb=1)
+				 */
+		u8 duration; /* 256 us */
+		u8 bss_idx;
+		__le64 start_tsf;
+		__le16 mantissa;
+		u8 exponent;
+		u8 is_ap;
+		u8 agrt_params;
+		u8 rsv[23];
+	} __packed req = {
+		.tbl_idx = flow->id,
+		.cmd = cmd,
+		.own_mac_idx = mvif->omac_idx,
+		.flowid = flow->id,
+		.peer_id = cpu_to_le16(flow->wcid),
+		.duration = flow->duration,
+		.bss_idx = mvif->idx,
+		.start_tsf = cpu_to_le64(flow->tsf),
+		.mantissa = flow->mantissa,
+		.exponent = flow->exp,
+		.is_ap = true,
+	};
+
+	if (flow->protection)
+		req.agrt_params |= TWT_AGRT_PROTECT;
+	if (!flow->flowtype)
+		req.agrt_params |= TWT_AGRT_ANNOUNCE;
+	if (flow->trigger)
+		req.agrt_params |= TWT_AGRT_TRIGGER;
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(TWT_AGRT_UPDATE),
+				 &req, sizeof(req), true);
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index eda17a94ac58..deec516e905a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -275,6 +275,7 @@ enum {
 	MCU_EXT_CMD_MWDS_SUPPORT = 0x80,
 	MCU_EXT_CMD_SET_SER_TRIGGER = 0x81,
 	MCU_EXT_CMD_SCS_CTRL = 0x82,
+	MCU_EXT_CMD_TWT_AGRT_UPDATE = 0x94,
 	MCU_EXT_CMD_FW_DBG_CTRL = 0x95,
 	MCU_EXT_CMD_SET_RDD_TH = 0x9d,
 	MCU_EXT_CMD_MURU_CTRL = 0x9f,
@@ -284,6 +285,14 @@ enum {
 	MCU_EXT_CMD_PHY_STAT_INFO = 0xad,
 };
 
+enum {
+	MCU_TWT_AGRT_ADD,
+	MCU_TWT_AGRT_MODIFY,
+	MCU_TWT_AGRT_DELETE,
+	MCU_TWT_AGRT_TEARDOWN,
+	MCU_TWT_AGRT_GET_TSF,
+};
+
 enum {
 	MCU_WA_PARAM_CMD_QUERY,
 	MCU_WA_PARAM_CMD_SET,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index c2909247cfd4..8129f54c2f3f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -67,6 +67,21 @@ struct mt7915_sta_key_conf {
 	u8 key[16];
 };
 
+struct mt7915_twt_flow {
+	struct list_head list;
+	u64 start_tsf;
+	u64 tsf;
+	u32 duration;
+	u16 wcid;
+	__le16 mantissa;
+	u8 exp;
+	u8 id;
+	u8 protection:1;
+	u8 flowtype:1;
+	u8 trigger:1;
+	u8 sched:1;
+};
+
 struct mt7915_sta {
 	struct mt76_wcid wcid; /* must be first */
 
@@ -286,6 +301,10 @@ int mt7915_dma_init(struct mt7915_dev *dev);
 void mt7915_dma_prefetch(struct mt7915_dev *dev);
 void mt7915_dma_cleanup(struct mt7915_dev *dev);
 int mt7915_mcu_init(struct mt7915_dev *dev);
+int mt7915_mcu_twt_agrt_update(struct mt7915_dev *dev,
+			       struct mt7915_vif *mvif,
+			       struct mt7915_twt_flow *flow,
+			       int cmd);
 int mt7915_mcu_add_dev_info(struct mt7915_phy *phy,
 			    struct ieee80211_vif *vif, bool enable);
 int mt7915_mcu_add_bss_info(struct mt7915_phy *phy,
-- 
2.31.1

