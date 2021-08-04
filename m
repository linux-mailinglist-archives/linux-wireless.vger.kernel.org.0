Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEEF3DFC2B
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Aug 2021 09:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235807AbhHDHhR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Aug 2021 03:37:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:40266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235863AbhHDHhQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Aug 2021 03:37:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 52E8460EBC;
        Wed,  4 Aug 2021 07:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628062624;
        bh=tvJMTzhCH30qfTyf7xLBm8p3yZSIuTcY9OuoUCwXBQg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SsrnxjjfLToveRcT/HiVsS5/b3V1OBGjxDV/mCZjs/tq/STLz6JvBzkQoT+cm9auO
         ezdCcJ4thgdscM7iBQSeASnUcmFTFC3Ug97VfcehVI7+YVuwQmRa374QmOgi0THgEe
         DkI1HSdYQQdr1JbOr1ghWqCkzMrvcK4Jd6mAvQHa48+uKAzx05E2KN9/wxp9ovxyA0
         67g6AusCn1m9eQxZFGF/Q1l6BlNsebKmnOTBOsnNoQqNrYNeZLVLPWF52jwjGqjvvn
         EDnbO59pUfFIiHvSyqY7Y05m43Xd7ZhNa3FViUMqrYZorFeb7mnPJvii6hIYQj6pYZ
         zxXfubGcT4nDA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, chui-hao.chiu@mediatek.com
Subject: [PATCH mac80211-next 4/7] mt76: mt7915: introduce mt7915_mcu_twt_agrt_update mcu command
Date:   Wed,  4 Aug 2021 09:36:35 +0200
Message-Id: <d93b5447b9495b83c333f2b20b077b13937a0a1d.1628062233.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1628062233.git.lorenzo@kernel.org>
References: <cover.1628062233.git.lorenzo@kernel.org>
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
index f84c49969479..2266bc1c0de0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3904,3 +3904,53 @@ int mt7915_mcu_get_rx_rate(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 
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
index baa27dab0499..f4ba343b9413 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -276,6 +276,7 @@ enum {
 	MCU_EXT_CMD_MWDS_SUPPORT = 0x80,
 	MCU_EXT_CMD_SET_SER_TRIGGER = 0x81,
 	MCU_EXT_CMD_SCS_CTRL = 0x82,
+	MCU_EXT_CMD_TWT_AGRT_UPDATE = 0x94,
 	MCU_EXT_CMD_FW_DBG_CTRL = 0x95,
 	MCU_EXT_CMD_SET_RDD_TH = 0x9d,
 	MCU_EXT_CMD_SET_SPR = 0xa8,
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
index 068ef0f881b8..ad97980275a3 100644
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
 
@@ -284,6 +299,10 @@ int mt7915_dma_init(struct mt7915_dev *dev);
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

