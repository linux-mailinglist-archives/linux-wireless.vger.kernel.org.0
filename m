Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C7A401AB2
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Sep 2021 13:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239056AbhIFLqQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Sep 2021 07:46:16 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:39170 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S241352AbhIFLqP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Sep 2021 07:46:15 -0400
X-UUID: b857cc541a9c4a7f85092eee6804fe3c-20210906
X-UUID: b857cc541a9c4a7f85092eee6804fe3c-20210906
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 317439029; Mon, 06 Sep 2021 19:45:06 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 6 Sep 2021 19:45:06 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 6 Sep 2021 19:45:06 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v2 8/8] mt76: mt7915: set muru platform type
Date:   Mon, 6 Sep 2021 19:44:23 +0800
Message-ID: <20210906114423.13646-8-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210906114423.13646-1-shayne.chen@mediatek.com>
References: <20210906114423.13646-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Notify fw to init corresponding muru algorithm.

Suggested-by: Money Wang <money.wang@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c  | 16 ++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h  |  5 +++++
 .../net/wireless/mediatek/mt76/mt7915/testmode.h |  4 ----
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 229ba3c469d1..6242d5e11107 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2949,6 +2949,21 @@ static int mt7915_mcu_set_mwds(struct mt7915_dev *dev, bool enabled)
 				 sizeof(req), false);
 }
 
+static int mt7915_mcu_set_muru_ptype(struct mt7915_dev *dev)
+{
+	struct {
+		__le32 cmd;
+		u8 ptype;
+		u8 _rsv[3];
+	} __packed req = {
+		.cmd = MURU_SET_PLATFORM_TYPE,
+		.ptype = 2,
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(MURU_CTRL), &req,
+				 sizeof(req), false);
+}
+
 int mt7915_mcu_init(struct mt7915_dev *dev)
 {
 	static const struct mt76_mcu_ops mt7915_mcu_ops = {
@@ -2973,6 +2988,7 @@ int mt7915_mcu_init(struct mt7915_dev *dev)
 	mt7915_mcu_fw_log_2_host(dev, 0);
 	mt7915_mcu_set_mwds(dev, 1);
 	mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(SET), MCU_WA_PARAM_RED, 0, 0);
+	mt7915_mcu_set_muru_ptype(dev);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index 6344faf3f394..57be9262ec2a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -1086,6 +1086,11 @@ enum {
 	MT_BF_MODULE_UPDATE = 25
 };
 
+enum {
+	MURU_SET_ARB_OP_MODE = 14,
+	MURU_SET_PLATFORM_TYPE = 25,
+};
+
 #define MT7915_WTBL_UPDATE_MAX_SIZE	(sizeof(struct wtbl_req_hdr) +	\
 					 sizeof(struct wtbl_generic) +	\
 					 sizeof(struct wtbl_rx) +	\
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

