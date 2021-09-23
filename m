Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696EC416107
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Sep 2021 16:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241662AbhIWOcB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Sep 2021 10:32:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:43870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241670AbhIWOb6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Sep 2021 10:31:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C81B610C8;
        Thu, 23 Sep 2021 14:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632407427;
        bh=pq7MPCL/sasItDSJyaQqdAM+NH3qr4uKo2854TBt06A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YWhY5CDhfNbchLNLGVI+8U6MaqC+dw/76g124YlKBK+0mekIHUouJWCsNO/hoX1Gt
         vMp2JI8shAnOQ8uUiQyRuNZPKfb2yhSUZafoYGybITPnOAtbRXMMiCvH54snXteSxd
         7/F6o6zOn3DgFpElotVH7Dtyvw8JdGk3DyfX9kuwsrRO90EUMgr/l4x32rDt2kNnH3
         R1GZMq0jgNSlA4EI4/ahNCHiwVnAwhVQ16QCGg+p1tX6C111KyVI4fo6TEUh7zzd3D
         dROzAa+amZUXA3MY35epdRCxVR0obAt6QHN7NEaWW/T3C1IT4RRAY4xfRJRMe3GTHl
         Q5bjt/5EUg5OA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, chui-hao.chiu@mediatek.com,
        evelyn.tsai@mediatek.com
Subject: [PATCH v5 2/5] mt76: mt7915: introduce mt7915_mcu_twt_agrt_update mcu command
Date:   Thu, 23 Sep 2021 16:29:31 +0200
Message-Id: <d037afb520aa6df83a84d9e5a9f66d8760340375.1632406731.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632406731.git.lorenzo@kernel.org>
References: <cover.1632406731.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a preliminary patch to add TWT support to mt7915

Tested-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Tested-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 50 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  9 ++++
 .../wireless/mediatek/mt76/mt7915/mt7915.h    | 20 ++++++++
 3 files changed, 79 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 39cba8210242..77d645268c9f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3966,3 +3966,53 @@ int mt7915_mcu_get_rx_rate(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 
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
+		.tbl_idx = flow->table_id,
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
index 9e966cfcf5a2..877c6d81dbf2 100644
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
index 5367b92de864..1256c6df4b6c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -67,6 +67,22 @@ struct mt7915_sta_key_conf {
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
+	u8 table_id;
+	u8 id;
+	u8 protection:1;
+	u8 flowtype:1;
+	u8 trigger:1;
+	u8 sched:1;
+};
+
 struct mt7915_sta {
 	struct mt76_wcid wcid; /* must be first */
 
@@ -286,6 +302,10 @@ int mt7915_dma_init(struct mt7915_dev *dev);
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

