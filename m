Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8164311DA
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Oct 2021 10:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbhJRIKf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 04:10:35 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:49378 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231165AbhJRIKe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 04:10:34 -0400
X-UUID: 6fbb18c720a0442a9b1972025720a574-20211018
X-UUID: 6fbb18c720a0442a9b1972025720a574-20211018
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 955796513; Mon, 18 Oct 2021 16:08:21 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 18 Oct 2021 16:08:20 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 18 Oct
 2021 16:08:20 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 18 Oct 2021 16:08:20 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v7 8/8] mt76: mt7915: set muru platform type
Date:   Mon, 18 Oct 2021 16:07:06 +0800
Message-ID: <20211018080706.11401-8-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211018080706.11401-1-shayne.chen@mediatek.com>
References: <20211018080706.11401-1-shayne.chen@mediatek.com>
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
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 20 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   | 10 ++++++++++
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  1 +
 .../wireless/mediatek/mt76/mt7915/testmode.c  | 16 +++++----------
 .../wireless/mediatek/mt76/mt7915/testmode.h  |  4 ----
 5 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index f32e124b1a0f..d4c8759bedd8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2906,6 +2906,21 @@ static int mt7915_mcu_set_mwds(struct mt7915_dev *dev, bool enabled)
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
@@ -2935,6 +2950,11 @@ int mt7915_mcu_init(struct mt7915_dev *dev)
 	if (ret)
 		return ret;
 
+	ret = mt7915_mcu_set_muru_ctrl(dev, MURU_SET_PLATFORM_TYPE,
+				       MURU_PLATFORM_TYPE_PERF_LEVEL_2);
+	if (ret)
+		return ret;
+
 	return mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(SET),
 				 MCU_WA_PARAM_RED, 0, 0);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index a1a6cc064573..4043cf547c9e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -1092,6 +1092,16 @@ enum {
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
index 78c0896f97b9..bb8ef60f1b1e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -443,6 +443,7 @@ int mt7915_mcu_set_pulse_th(struct mt7915_dev *dev,
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
2.29.2

