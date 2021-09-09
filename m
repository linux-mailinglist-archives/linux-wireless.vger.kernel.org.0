Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A94994046D8
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Sep 2021 10:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbhIIIQi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Sep 2021 04:16:38 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:42680 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231281AbhIIIQe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Sep 2021 04:16:34 -0400
X-UUID: 2108034ce12e43b38a3f1f5c6b0a6788-20210909
X-UUID: 2108034ce12e43b38a3f1f5c6b0a6788-20210909
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1214636436; Thu, 09 Sep 2021 16:15:20 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 9 Sep 2021 16:15:19 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 9 Sep 2021 16:15:19 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v4 8/8] mt76: mt7915: set muru platform type
Date:   Thu, 9 Sep 2021 16:15:12 +0800
Message-ID: <20210909081512.5037-8-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210909081512.5037-1-shayne.chen@mediatek.com>
References: <20210909081512.5037-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Set muru platform type by mcu cmd to notify fw to init corresponding
algorithm.

Suggested-by: Money Wang <money.wang@mediatek.com>
Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
v3: - fix endianess
    - rework muru ctrl function
v4: use put_unaligned_le32() to get rid of undefined behavior
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 17 +++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h | 10 ++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mt7915.h  |  1 +
 .../wireless/mediatek/mt76/mt7915/testmode.c    | 16 +++++-----------
 .../wireless/mediatek/mt76/mt7915/testmode.h    |  4 ----
 5 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 229ba3c469d1..770e0c5604fd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2949,6 +2949,21 @@ static int mt7915_mcu_set_mwds(struct mt7915_dev *dev, bool enabled)
 				 sizeof(req), false);
 }
 
+int mt7915_mcu_set_muru_ctrl(struct mt7915_dev *dev, u32 cmd, u32 val)
+{
+	struct {
+		__le32 cmd;
+		u8 val[4];
+	} __packed req = {
+		.cmd = cpu_to_le32(cmd),
+	};
+
+	put_unaligned_le32(val, req.val);
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(MURU_CTRL), &req,
+				 sizeof(req), false);
+}
+
 int mt7915_mcu_init(struct mt7915_dev *dev)
 {
 	static const struct mt76_mcu_ops mt7915_mcu_ops = {
@@ -2973,6 +2988,8 @@ int mt7915_mcu_init(struct mt7915_dev *dev)
 	mt7915_mcu_fw_log_2_host(dev, 0);
 	mt7915_mcu_set_mwds(dev, 1);
 	mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(SET), MCU_WA_PARAM_RED, 0, 0);
+	mt7915_mcu_set_muru_ctrl(dev, MURU_SET_PLATFORM_TYPE,
+				 MURU_PLATFORM_TYPE_PERF_LEVEL_2);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index 6344faf3f394..8b9f4c169137 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -1086,6 +1086,16 @@ enum {
 	MT_BF_MODULE_UPDATE = 25
 };
 
+enum {
+	MURU_SET_ARB_OP_MODE = 14,
+	MURU_SET_PLATFORM_TYPE = 25,
+};
+
+enum {
+	MURU_PLATFORM_TYPE_PERF_LEVEL_1 = 1,
+	MURU_PLATFORM_TYPE_PERF_LEVEL_2,
+};
+
 #define MT7915_WTBL_UPDATE_MAX_SIZE	(sizeof(struct wtbl_req_hdr) +	\
 					 sizeof(struct wtbl_generic) +	\
 					 sizeof(struct wtbl_rx) +	\
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index f8f0bb3ca7cd..6b7e0e3aef5a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -351,6 +351,7 @@ int mt7915_mcu_set_pulse_th(struct mt7915_dev *dev,
 			    const struct mt7915_dfs_pulse *pulse);
 int mt7915_mcu_set_radar_th(struct mt7915_dev *dev, int index,
 			    const struct mt7915_dfs_pattern *pattern);
+int mt7915_mcu_set_muru_ctrl(struct mt7915_dev *dev, u32 cmd, u32 val);
 int mt7915_mcu_apply_group_cal(struct mt7915_dev *dev);
 int mt7915_mcu_apply_tx_dpd(struct mt7915_phy *phy);
 int mt7915_mcu_get_chan_mib_info(struct mt7915_phy *phy, bool chan_switch);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
index 00dcc46b9082..89aae323d29e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
@@ -169,22 +169,16 @@ static int
 mt7915_tm_set_tam_arb(struct mt7915_phy *phy, bool enable, bool mu)
 {
 	struct mt7915_dev *dev = phy->dev;
-	struct {
-		__le32 cmd;
-		u8 op_mode;
-	} __packed req = {
-		.cmd = cpu_to_le32(MURU_SET_ARB_OP_MODE),
-	};
+	u32 op_mode;
 
 	if (!enable)
-		req.op_mode = TAM_ARB_OP_MODE_NORMAL;
+		op_mode = TAM_ARB_OP_MODE_NORMAL;
 	else if (mu)
-		req.op_mode = TAM_ARB_OP_MODE_TEST;
+		op_mode = TAM_ARB_OP_MODE_TEST;
 	else
-		req.op_mode = TAM_ARB_OP_MODE_FORCE_SU;
+		op_mode = TAM_ARB_OP_MODE_FORCE_SU;
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(MURU_CTRL), &req,
-				 sizeof(req), false);
+	return mt7915_mcu_set_muru_ctrl(dev, MURU_SET_ARB_OP_MODE, op_mode);
 }
 
 static int
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.h b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.h
index 107f0cf2505e..5573ac309363 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.h
@@ -102,8 +102,4 @@ enum {
 	TAM_ARB_OP_MODE_FORCE_SU = 5,
 };
 
-enum {
-	MURU_SET_ARB_OP_MODE = 14,
-};
-
 #endif
-- 
2.25.1

