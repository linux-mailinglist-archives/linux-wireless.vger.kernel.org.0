Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96AB979EB6D
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Sep 2023 16:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241513AbjIMOok (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 10:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241469AbjIMOof (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 10:44:35 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C66A8
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 07:44:31 -0700 (PDT)
X-UUID: 088481e8524411eea33bb35ae8d461a2-20230913
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Ba6S9adPAWLGYboYX2BbN2qsBvx/vGtpZBCMQpt/U9Y=;
        b=rAYNEpfV8ZVdfgbenewA8SLnZ63GHaK2V31Iq2k/cRRxBt9cD/6uF9iGTb9Eoh0pvQhk3FtlTMPkowcU58voTApo+WtOgSb3QprMAO0QndvYKoJOqLQXXujgr8DmUGdm9TdiJBkvWecmAUZVmLlBlwvQDXTwb7hy69D1TdyUPQo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:17f06dd9-e3b7-44dd-b48e-05347326fa9c,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:0ad78a4,CLOUDID:4c44a8ef-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 088481e8524411eea33bb35ae8d461a2-20230913
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 271610329; Wed, 13 Sep 2023 22:44:24 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 13 Sep 2023 22:44:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 13 Sep 2023 22:44:23 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH v2 11/17] wifi: mt76: mt7925: add pci_mcu.c
Date:   Wed, 13 Sep 2023 22:43:39 +0800
Message-ID: <e70d792e7c37219ee48baf199a3275d98bf20900.1694595134.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1694595134.git.deren.wu@mediatek.com>
References: <cover.1694595134.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--5.646400-8.000000
X-TMASE-MatchedRID: 59Hu41dzmXTKRSR886eK0gPZZctd3P4BWjWsWQUWzVpnnK6mXN72m1Ue
        MbrYurbIadgG7kzTAhS5ujAticPZ9fm9WstcRwZxuZH4LSX2+NUfOdo4H355iGe6/ylXAzNJo8W
        MkQWv6iXBcIE78YqRWvcUt5lc1lLgoGRyAacnhaYq25BLAOYym3oGIxpTutRJqX5VCcpSMWDStc
        hC7WBwun7cGd19dSFd
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.646400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 4713915B6A59FB1A5B8A42FC35B5370034F84BA176D1928A0672B21B5E87B7782000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(Patches split into one patch per file for easier review, but the final
commit will be one big patch. See the cover letter for more info.)

Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7925/pci_mcu.c   | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/pci_mcu.c

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci_mcu.c
new file mode 100644
index 000000000000..f95bc5dcd830
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci_mcu.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2023 MediaTek Inc. */
+
+#include "mt7925.h"
+#include "mcu.h"
+
+static int
+mt7925_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
+			int cmd, int *seq)
+{
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
+	enum mt76_mcuq_id txq = MT_MCUQ_WM;
+	int ret;
+
+	ret = mt7925_mcu_fill_message(mdev, skb, cmd, seq);
+	if (ret)
+		return ret;
+
+	mdev->mcu.timeout = 3 * HZ;
+
+	if (cmd == MCU_CMD(FW_SCATTER))
+		txq = MT_MCUQ_FWDL;
+
+	return mt76_tx_queue_skb_raw(dev, mdev->q_mcu[txq], skb, 0);
+}
+
+int mt7925e_mcu_init(struct mt792x_dev *dev)
+{
+	static const struct mt76_mcu_ops mt7925_mcu_ops = {
+		.headroom = sizeof(struct mt76_connac2_mcu_txd),
+		.mcu_skb_send_msg = mt7925_mcu_send_message,
+		.mcu_parse_response = mt7925_mcu_parse_response,
+	};
+	int err;
+
+	dev->mt76.mcu_ops = &mt7925_mcu_ops;
+
+	err = mt792xe_mcu_fw_pmctrl(dev);
+	if (err)
+		return err;
+
+	err = __mt792xe_mcu_drv_pmctrl(dev);
+	if (err)
+		return err;
+
+	mt76_rmw_field(dev, MT_PCIE_MAC_PM, MT_PCIE_MAC_PM_L0S_DIS, 1);
+
+	err = mt7925_run_firmware(dev);
+
+	mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[MT_MCUQ_FWDL], false);
+
+	return err;
+}
-- 
2.18.0

