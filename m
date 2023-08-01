Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B867676B7AE
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 16:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbjHAOgB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Aug 2023 10:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234801AbjHAOf4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Aug 2023 10:35:56 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3EDE5C
        for <linux-wireless@vger.kernel.org>; Tue,  1 Aug 2023 07:35:53 -0700 (PDT)
X-UUID: b3012c36307811eeb20a276fd37b9834-20230801
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=lwUtkOJCCTygw9enC77meLONvP5uJ48TFFYAiBDCZFI=;
        b=SsIL5EqpqIgu01Z6OZRay0kdS8kYPVCVob4deNp2BPPtlFYE6fFfIKIAOXFYyy+2R7d1VG9KdoLn3/rcqmpw1PXrBP5WbjJCON8Ap8DSyziKLPclTfEaf6kV3xm9uBk0cljRmyNpiJq/x02zxsB4YpY58VKiOaY8D2VSOZNMqkU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:10cb34b8-59ff-48cc-879a-c81e4c83fa1b,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.30,REQID:10cb34b8-59ff-48cc-879a-c81e4c83fa1b,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:1fcc6f8,CLOUDID:e28e91d2-cd77-4e67-bbfd-aa4eaace762f,B
        ulkID:230801223546WQRIEWMK,BulkQuantity:0,Recheck:0,SF:17|19|48|38|29|28,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_ULN,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,
        TF_CID_SPAM_ASC,TF_CID_SPAM_FAS
X-UUID: b3012c36307811eeb20a276fd37b9834-20230801
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2110348172; Tue, 01 Aug 2023 22:35:45 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 1 Aug 2023 22:35:44 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 1 Aug 2023 22:35:44 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH 10/17] wifi: mt76: mt7925: add init.c
Date:   Tue, 1 Aug 2023 22:34:26 +0800
Message-ID: <c0b5d55eb5326ad38f3391466bdce99e9cc4021a.1690864199.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1690864199.git.deren.wu@mediatek.com>
References: <cover.1690864199.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(Patches split into one patch per file for easier review, but the final
commit will be one big patch. See the cover letter for more info.)

Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/init.c  | 235 ++++++++++++++++++
 1 file changed, 235 insertions(+)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/init.c

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/init.c b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
new file mode 100644
index 000000000000..8f9b7a2f376c
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2023 MediaTek Inc. */
+
+#include <linux/etherdevice.h>
+#include <linux/firmware.h>
+#include "mt7925.h"
+#include "mac.h"
+#include "mcu.h"
+
+static void
+mt7925_regd_notifier(struct wiphy *wiphy,
+		     struct regulatory_request *req)
+{
+	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt76_dev *mdev = &dev->mt76;
+
+	/* allow world regdom at the first boot only */
+	if (!memcmp(req->alpha2, "00", 2) &&
+	    mdev->alpha2[0] && mdev->alpha2[1])
+		return;
+
+	/* do not need to update the same country twice */
+	if (!memcmp(req->alpha2, mdev->alpha2, 2) &&
+	    dev->country_ie_env == req->country_ie_env)
+		return;
+
+	memcpy(mdev->alpha2, req->alpha2, 2);
+	mdev->region = req->dfs_region;
+	dev->country_ie_env = req->country_ie_env;
+
+	mt792x_mutex_acquire(dev);
+	mt7925_mcu_set_clc(dev, req->alpha2, req->country_ie_env);
+	mt7925_mcu_set_channel_domain(hw->priv);
+	mt7925_set_tx_sar_pwr(hw, NULL);
+	mt792x_mutex_release(dev);
+}
+
+static void mt7925_mac_init_basic_rates(struct mt792x_dev *dev)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mt76_rates); i++) {
+		u16 rate = mt76_rates[i].hw_value;
+		u16 idx = MT792x_BASIC_RATES_TBL + i;
+
+		rate = FIELD_PREP(MT_TX_RATE_MODE, rate >> 8) |
+		       FIELD_PREP(MT_TX_RATE_IDX, rate & GENMASK(7, 0));
+		mt7925_mac_set_fixed_rate_table(dev, idx, rate);
+	}
+}
+
+int mt7925_mac_init(struct mt792x_dev *dev)
+{
+	int i;
+
+	mt76_rmw_field(dev, MT_MDP_DCR1, MT_MDP_DCR1_MAX_RX_LEN, 1536);
+	/* enable hardware de-agg */
+	mt76_set(dev, MT_MDP_DCR0, MT_MDP_DCR0_DAMSDU_EN);
+
+	for (i = 0; i < MT792x_WTBL_SIZE; i++)
+		mt7925_mac_wtbl_update(dev, i,
+				       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
+	for (i = 0; i < 2; i++)
+		mt792x_mac_init_band(dev, i);
+
+	mt7925_mac_init_basic_rates(dev);
+
+	memzero_explicit(&dev->mt76.alpha2, sizeof(dev->mt76.alpha2));
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt7925_mac_init);
+
+static int __mt7925_init_hardware(struct mt792x_dev *dev)
+{
+	int ret;
+
+	ret = mt792x_mcu_init(dev);
+	if (ret)
+		goto out;
+
+	mt76_eeprom_override(&dev->mphy);
+
+	ret = mt7925_mcu_set_eeprom(dev);
+	if (ret)
+		goto out;
+
+	ret = mt7925_mac_init(dev);
+	if (ret)
+		goto out;
+
+out:
+	return ret;
+}
+
+static int mt7925_init_hardware(struct mt792x_dev *dev)
+{
+	int ret, i;
+
+	set_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
+
+	for (i = 0; i < MT792x_MCU_INIT_RETRY_COUNT; i++) {
+		ret = __mt7925_init_hardware(dev);
+		if (!ret)
+			break;
+
+		mt792x_init_reset(dev);
+	}
+
+	if (i == MT792x_MCU_INIT_RETRY_COUNT) {
+		dev_err(dev->mt76.dev, "hardware init failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void mt7925_init_work(struct work_struct *work)
+{
+	struct mt792x_dev *dev = container_of(work, struct mt792x_dev,
+					      init_work);
+	int ret;
+
+	ret = mt7925_init_hardware(dev);
+	if (ret)
+		return;
+
+	mt76_set_stream_caps(&dev->mphy, true);
+	mt7925_set_stream_he_eht_caps(&dev->phy);
+
+	ret = mt76_register_device(&dev->mt76, true, mt76_rates,
+				   ARRAY_SIZE(mt76_rates));
+	if (ret) {
+		dev_err(dev->mt76.dev, "register device failed\n");
+		return;
+	}
+
+	ret = mt7925_init_debugfs(dev);
+	if (ret) {
+		dev_err(dev->mt76.dev, "register debugfs failed\n");
+		return;
+	}
+
+	/* we support chip reset now */
+	dev->hw_init_done = true;
+
+	mt7925_mcu_set_deep_sleep(dev, dev->pm.ds_enable);
+}
+
+int mt7925_register_device(struct mt792x_dev *dev)
+{
+	struct ieee80211_hw *hw = mt76_hw(dev);
+	int ret;
+
+	dev->phy.dev = dev;
+	dev->phy.mt76 = &dev->mt76.phy;
+	dev->mt76.phy.priv = &dev->phy;
+	dev->mt76.tx_worker.fn = mt792x_tx_worker;
+
+	INIT_DELAYED_WORK(&dev->pm.ps_work, mt792x_pm_power_save_work);
+	INIT_WORK(&dev->pm.wake_work, mt792x_pm_wake_work);
+	spin_lock_init(&dev->pm.wake.lock);
+	mutex_init(&dev->pm.mutex);
+	init_waitqueue_head(&dev->pm.wait);
+	spin_lock_init(&dev->pm.txq_lock);
+	INIT_DELAYED_WORK(&dev->mphy.mac_work, mt792x_mac_work);
+	INIT_DELAYED_WORK(&dev->phy.scan_work, mt7925_scan_work);
+	INIT_DELAYED_WORK(&dev->coredump.work, mt7925_coredump_work);
+#if IS_ENABLED(CONFIG_IPV6)
+	INIT_WORK(&dev->ipv6_ns_work, mt7925_set_ipv6_ns_work);
+	skb_queue_head_init(&dev->ipv6_ns_list);
+#endif
+	skb_queue_head_init(&dev->phy.scan_event_list);
+	skb_queue_head_init(&dev->coredump.msg_list);
+
+	INIT_WORK(&dev->reset_work, mt7925_mac_reset_work);
+	INIT_WORK(&dev->init_work, mt7925_init_work);
+
+	INIT_WORK(&dev->phy.roc_work, mt7925_roc_work);
+	timer_setup(&dev->phy.roc_timer, mt792x_roc_timer, 0);
+	init_waitqueue_head(&dev->phy.roc_wait);
+
+	dev->pm.idle_timeout = MT792x_PM_TIMEOUT;
+	dev->pm.stats.last_wake_event = jiffies;
+	dev->pm.stats.last_doze_event = jiffies;
+	if (!mt76_is_usb(&dev->mt76)) {
+		dev->pm.enable_user = true;
+		dev->pm.enable = true;
+		dev->pm.ds_enable_user = true;
+		dev->pm.ds_enable = true;
+	}
+
+	if (!mt76_is_mmio(&dev->mt76))
+		hw->extra_tx_headroom += MT_SDIO_TXD_SIZE + MT_SDIO_HDR_SIZE;
+
+	mt792x_init_acpi_sar(dev);
+
+	ret = mt792x_init_wcid(dev);
+	if (ret)
+		return ret;
+
+	ret = mt792x_init_wiphy(hw);
+	if (ret)
+		return ret;
+
+	hw->wiphy->reg_notifier = mt7925_regd_notifier;
+	dev->mphy.sband_2g.sband.ht_cap.cap |=
+			IEEE80211_HT_CAP_LDPC_CODING |
+			IEEE80211_HT_CAP_MAX_AMSDU;
+	dev->mphy.sband_2g.sband.ht_cap.ampdu_density =
+			IEEE80211_HT_MPDU_DENSITY_2;
+	dev->mphy.sband_5g.sband.ht_cap.cap |=
+			IEEE80211_HT_CAP_LDPC_CODING |
+			IEEE80211_HT_CAP_MAX_AMSDU;
+	dev->mphy.sband_2g.sband.ht_cap.ampdu_density =
+			IEEE80211_HT_MPDU_DENSITY_1;
+	dev->mphy.sband_5g.sband.vht_cap.cap |=
+			IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454 |
+			IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK |
+			IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE |
+			IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE |
+			(3 << IEEE80211_VHT_CAP_BEAMFORMEE_STS_SHIFT);
+	dev->mphy.sband_5g.sband.vht_cap.cap |=
+			IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ |
+			IEEE80211_VHT_CAP_SHORT_GI_160;
+
+	dev->mphy.hw->wiphy->available_antennas_rx = dev->mphy.chainmask;
+	dev->mphy.hw->wiphy->available_antennas_tx = dev->mphy.chainmask;
+
+	queue_work(system_wq, &dev->init_work);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt7925_register_device);
-- 
2.18.0

