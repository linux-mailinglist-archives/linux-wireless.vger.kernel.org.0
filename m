Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E9A7A45F8
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Sep 2023 11:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240898AbjIRJcN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Sep 2023 05:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239280AbjIRJbj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Sep 2023 05:31:39 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835B811F
        for <linux-wireless@vger.kernel.org>; Mon, 18 Sep 2023 02:31:31 -0700 (PDT)
X-UUID: 2321fc36560611eea33bb35ae8d461a2-20230918
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=lwUtkOJCCTygw9enC77meLONvP5uJ48TFFYAiBDCZFI=;
        b=Laie0ZziPUHNDW+DPmCsOqT/5yLIHq4QSdFhXrVy+jKoBVV5dAM1dRd7njaL/G+PRXqieJPSxtULlcV7hJJyXzBJOeNhihC+HNsKcBc9R4kP0ngXJFbdFIGTS8Daf6Qs5AjEUSt+OlVP2Bsa2q+SIkk1kdC7E3MlljhTdZu4M60=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:7c225f41-0f28-4f20-a6a2-4bc723f91749,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:0ad78a4,CLOUDID:4386d3ef-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 2321fc36560611eea33bb35ae8d461a2-20230918
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 931417652; Mon, 18 Sep 2023 17:31:25 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 18 Sep 2023 17:31:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 18 Sep 2023 17:31:23 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH v3 10/17] wifi: mt76: mt7925: add init.c
Date:   Mon, 18 Sep 2023 17:31:03 +0800
Message-ID: <562bb7504937585f05e2c547f8e47d147e6c8c02.1695024367.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1695024367.git.deren.wu@mediatek.com>
References: <cover.1695024367.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--0.935000-8.000000
X-TMASE-MatchedRID: 5jN1BnrlUP/KRSR886eK0gPZZctd3P4BX5TqQagR07e7qpOHKudqcwaT
        alM8C7739dqfQ8cn44rtaDDr9p69jUKtkjlYA82djoyKzEmtrEdhBfGxmdHCgrbbLoKsIHBMKEq
        aBfR+Xz1QSOMy6nPDAgSBk1SfUIyl62xBm/uUP3miAZ3zAhQYgpnaxzJFBx6vq8z7POX8FJOLXz
        LbvRX26+K/d2fI8g8m4oa+wa50SfhVDs7/hETL68nUT+eskUQPCt59Uh3p/NVF9mbJQ0Mzo7mKl
        v3K7lvCp918jSXTknUGkFVK03kqAy4tzJGceGC/o65WJt1k1O8oteqd/zXaI08hta3YuM64WmqQ
        M0czy/7/c/7O04tU0sJ0Nnp8kKkTNyl1nd9CIt0URSScn+QSXq0hbOeGOMG1+gtHj7OwNO22utO
        5qEfOUU3WJnw4dLkAr3MCZKTwZuwOmWv0B1TPm91UBOzE7FpkUY6rI6hyg+HDeC/Uhijs9uJ7Pd
        hSyq8boLf55zoqUr6gsYYwGwbY50ma3zYT97IFAYfQIAUhBayZvmCbKVb49sZL6x5U/HriPpCuf
        fGH9zI=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--0.935000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 8253C4DDFF98E0A0689989E067C6D6059AFEAF7472FDBB54E59B5AF997CA25642000:8
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
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

