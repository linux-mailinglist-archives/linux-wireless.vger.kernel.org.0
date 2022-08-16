Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5F4595274
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Aug 2022 08:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiHPGT1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Aug 2022 02:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiHPGTH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Aug 2022 02:19:07 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B031D77E9D
        for <linux-wireless@vger.kernel.org>; Mon, 15 Aug 2022 17:04:33 -0700 (PDT)
X-UUID: b69cdab21ad24aa39a5b3968d7a7ee1b-20220816
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=WJmXnrI7AXKAh54MmBJDCtdEQGeWwFYLjiiKMVAM8bU=;
        b=qrntE819aoO7eAsFiEPjDyyixJ89HcyggosFXx9LMGITpKgIJywFNSfuBF06ZPwb9d4XgmdeHBRkCBbZPo263sqEq/88NHalLgT0H4l1VhZu1Tgr/XVEz8804LngNKE3WDXkYT8vygaJjUB5UldVSUnXEVUIFFrSjzVaunJqQ14=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.9,REQID:7e629962-9fa2-43be-8291-9de1ef382957,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release
        _Ham,ACTION:release,TS:-20
X-CID-META: VersionHash:3d8acc9,CLOUDID:171563fd-9e71-4a0f-ba6b-417998daea35,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:
        nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: b69cdab21ad24aa39a5b3968d7a7ee1b-20220816
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1300245114; Tue, 16 Aug 2022 08:04:26 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 16 Aug 2022 08:04:24 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 16 Aug 2022 08:04:24 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <jenhao.yang@mediatek.com>,
        <robin.chiu@mediatek.com>, <Eddie.Chen@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <ted.huang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <Tom.Chou@mediatek.com>, <steve.lee@mediatek.com>,
        <jsiuda@google.com>, <frankgor@google.com>, <kuabhs@google.com>,
        <druth@google.com>, <abhishekpandit@google.com>,
        <shawnku@google.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Deren Wu" <deren.wu@mediatek.com>
Subject: [PATCH 8/9] wifi: mt76: mt7921: introduce remain_on_channel support
Date:   Tue, 16 Aug 2022 08:03:46 +0800
Message-ID: <f48a750e8ad17d5b2410eea03fc30a6403732168.1660606893.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1660606893.git.objelf@gmail.com>
References: <cover.1660606893.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Introduce remain_on_channel support. Additionally, we add
mt7921_check_offload_capability to disable .remain_on_channel and
.cancel_remain_on_channel and related configuration because those
operations would rely on the fundamental MCU commands that will be only
supported with newer firmware.

Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  36 ++++++
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 112 ++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   |  24 ++++
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  34 ++++++
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  13 +-
 .../net/wireless/mediatek/mt76/mt7921/sdio.c  |  11 +-
 .../net/wireless/mediatek/mt76/mt7921/usb.c   |   1 +
 7 files changed, 225 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index cd960e23770f..1b7a18d42f5b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -44,6 +44,35 @@ mt7921_regd_notifier(struct wiphy *wiphy,
 	mt7921_mutex_release(dev);
 }
 
+static int mt7921_check_offload_capability(struct mt7921_dev *dev)
+{
+	struct ieee80211_hw *hw = mt76_hw(dev);
+	int year, mon, day, hour, min, sec;
+	struct wiphy *wiphy = hw->wiphy;
+	bool fw_can_roc = false;
+	int ret;
+
+	ret = sscanf(dev->mt76.hw->wiphy->fw_version + 11, "%4d%2d%2d%2d%2d%2d",
+		     &year, &mon, &day, &hour, &min, &sec);
+	if (ret != 6)
+		goto out;
+
+	/* Old firmware cannot support remained on channel and channel
+	 * context management.
+	 */
+	fw_can_roc =  mktime64(year, mon, day, hour, min, sec) >=
+		      mktime64(2022, 7, 15, 12, 1, 1);
+out:
+	if (!fw_can_roc) {
+		dev->ops->remain_on_channel = NULL;
+		dev->ops->cancel_remain_on_channel = NULL;
+
+		wiphy->flags &= ~WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL;
+	}
+
+	return 0;
+}
+
 static int
 mt7921_init_wiphy(struct ieee80211_hw *hw)
 {
@@ -70,6 +99,7 @@ mt7921_init_wiphy(struct ieee80211_hw *hw)
 	wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
 				 BIT(NL80211_IFTYPE_AP);
 	wiphy->n_iface_combinations = ARRAY_SIZE(if_comb);
+	wiphy->max_remain_on_channel_duration = 5000;
 	wiphy->max_scan_ie_len = MT76_CONNAC_SCAN_IE_LEN;
 	wiphy->max_scan_ssids = 4;
 	wiphy->max_sched_scan_plan_interval =
@@ -79,6 +109,7 @@ mt7921_init_wiphy(struct ieee80211_hw *hw)
 	wiphy->max_match_sets = MT76_CONNAC_MAX_SCAN_MATCH;
 	wiphy->max_sched_scan_reqs = 1;
 	wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
+	wiphy->flags |= WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL;
 	wiphy->reg_notifier = mt7921_regd_notifier;
 
 	wiphy->features |= NL80211_FEATURE_SCHED_SCAN_RANDOM_MAC_ADDR |
@@ -222,6 +253,7 @@ static void mt7921_init_work(struct work_struct *work)
 	if (ret)
 		return;
 
+	mt7921_check_offload_capability(dev);
 	mt76_set_stream_caps(&dev->mphy, true);
 	mt7921_set_stream_he_caps(&dev->phy);
 
@@ -277,6 +309,10 @@ int mt7921_register_device(struct mt7921_dev *dev)
 	INIT_WORK(&dev->reset_work, mt7921_mac_reset_work);
 	INIT_WORK(&dev->init_work, mt7921_init_work);
 
+	INIT_WORK(&dev->phy.roc_work, mt7921_roc_work);
+	timer_setup(&dev->phy.roc_timer, mt7921_roc_timer, 0);
+	init_waitqueue_head(&dev->phy.roc_wait);
+
 	dev->pm.idle_timeout = MT7921_PM_TIMEOUT;
 	dev->pm.stats.last_wake_event = jiffies;
 	dev->pm.stats.last_doze_event = jiffies;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index b280f184244f..ae0aabe052e3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -386,6 +386,116 @@ static void mt7921_remove_interface(struct ieee80211_hw *hw,
 	mt76_packet_id_flush(&dev->mt76, &msta->wcid);
 }
 
+static void mt7921_roc_iter(void *priv, u8 *mac,
+			    struct ieee80211_vif *vif)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt7921_phy *phy = priv;
+
+	mt7921_mcu_abort_roc(phy, mvif, phy->roc_token_id);
+}
+
+void mt7921_roc_work(struct work_struct *work)
+{
+	struct mt7921_phy *phy;
+
+	phy = (struct mt7921_phy *)container_of(work, struct mt7921_phy,
+						roc_work);
+
+	if (!test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
+		return;
+
+	mt7921_mutex_acquire(phy->dev);
+	ieee80211_iterate_active_interfaces(phy->mt76->hw,
+					    IEEE80211_IFACE_ITER_RESUME_ALL,
+					    mt7921_roc_iter, phy);
+	mt7921_mutex_release(phy->dev);
+	ieee80211_remain_on_channel_expired(phy->mt76->hw);
+}
+
+void mt7921_roc_timer(struct timer_list *timer)
+{
+	struct mt7921_phy *phy = from_timer(phy, timer, roc_timer);
+
+	ieee80211_queue_work(phy->mt76->hw, &phy->roc_work);
+}
+
+static int mt7921_abort_roc(struct mt7921_phy *phy, struct mt7921_vif *vif)
+{
+	int err;
+
+	if (!test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
+		return 0;
+
+	del_timer_sync(&phy->roc_timer);
+	cancel_work_sync(&phy->roc_work);
+	err = mt7921_mcu_abort_roc(phy, vif, phy->roc_token_id);
+	clear_bit(MT76_STATE_ROC, &phy->mt76->state);
+
+	return 00;
+}
+
+static int mt7921_set_roc(struct mt7921_phy *phy,
+			  struct mt7921_vif *vif,
+			  struct ieee80211_channel *chan,
+			  int duration,
+			  enum mt7921_roc_req type)
+{
+	int err;
+
+	if (test_and_set_bit(MT76_STATE_ROC, &phy->mt76->state))
+		return -EBUSY;
+
+	phy->roc_grant = false;
+
+	err = mt7921_mcu_set_roc(phy, vif, chan, duration, type,
+				 ++phy->roc_token_id);
+	if (err < 0) {
+		clear_bit(MT76_STATE_ROC, &phy->mt76->state);
+		goto out;
+	}
+
+	if (!wait_event_timeout(phy->roc_wait, phy->roc_grant, HZ)) {
+		mt7921_mcu_abort_roc(phy, vif, phy->roc_token_id);
+		clear_bit(MT76_STATE_ROC, &phy->mt76->state);
+		err = -ETIMEDOUT;
+	}
+
+out:
+	return err;
+}
+
+static int mt7921_remain_on_channel(struct ieee80211_hw *hw,
+				    struct ieee80211_vif *vif,
+				    struct ieee80211_channel *chan,
+				    int duration,
+				    enum ieee80211_roc_type type)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	int err;
+
+	mt7921_mutex_acquire(phy->dev);
+	err = mt7921_set_roc(phy, mvif, chan, duration, MT7921_ROC_REQ_ROC);
+	mt7921_mutex_release(phy->dev);
+
+	return err;
+}
+
+static int mt7921_cancel_remain_on_channel(struct ieee80211_hw *hw,
+					   struct ieee80211_vif *vif)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	int err;
+
+	mt7921_mutex_acquire(phy->dev);
+	err = mt7921_abort_roc(phy, mvif);
+	mt7921_mutex_release(phy->dev);
+
+	return err;
+}
+
 static int mt7921_set_channel(struct mt7921_phy *phy)
 {
 	struct mt7921_dev *dev = phy->dev;
@@ -1618,6 +1728,8 @@ const struct ieee80211_ops mt7921_ops = {
 #endif /* CONFIG_PM */
 	.flush = mt7921_flush,
 	.set_sar_specs = mt7921_set_sar_specs,
+	.remain_on_channel = mt7921_remain_on_channel,
+	.cancel_remain_on_channel = mt7921_cancel_remain_on_channel,
 };
 EXPORT_SYMBOL_GPL(mt7921_ops);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 05b625e02265..529fb56323ef 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -127,6 +127,29 @@ void mt7921_mcu_set_suspend_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 
 #endif /* CONFIG_PM */
 
+static void
+mt7921_mcu_uni_roc_event(struct mt7921_dev *dev, struct sk_buff *skb)
+{
+	struct mt7921_roc_grant_tlv *grant;
+	struct mt76_connac2_mcu_rxd *rxd;
+	int duration;
+
+	rxd = (struct mt76_connac2_mcu_rxd *)skb->data;
+	grant = (struct mt7921_roc_grant_tlv *)(rxd->tlv + 4);
+
+	/* should never happen */
+	WARN_ON_ONCE((le16_to_cpu(grant->tag) != UNI_EVENT_ROC_GRANT));
+
+	if (grant->reqtype == MT7921_ROC_REQ_ROC)
+		ieee80211_ready_on_channel(dev->mt76.phy.hw);
+
+	dev->phy.roc_grant = true;
+	wake_up(&dev->phy.roc_wait);
+	duration = le32_to_cpu(grant->max_interval);
+	mod_timer(&dev->phy.roc_timer,
+		  round_jiffies_up(jiffies + msecs_to_jiffies(duration)));
+}
+
 static void
 mt7921_mcu_scan_event(struct mt7921_dev *dev, struct sk_buff *skb)
 {
@@ -283,6 +306,7 @@ mt7921_mcu_uni_rx_unsolicited_event(struct mt7921_dev *dev,
 
 	switch (rxd->eid) {
 	case MCU_UNI_EVENT_ROC:
+		mt7921_mcu_uni_roc_event(dev, skb);
 		break;
 	default:
 		break;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index c9044d546e94..280605ffc4da 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -65,6 +65,30 @@ enum mt7921_roc_req {
 	MT7921_ROC_REQ_NUM
 };
 
+enum {
+	UNI_EVENT_ROC_GRANT = 0,
+	UNI_EVENT_ROC_TAG_NUM
+};
+
+struct mt7921_roc_grant_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 bss_idx;
+	u8 tokenid;
+	u8 status;
+	u8 primarychannel;
+	u8 rfsco;
+	u8 rfband;
+	u8 channelwidth;
+	u8 centerfreqseg1;
+	u8 centerfreqseg2;
+	u8 reqtype;
+	u8 dbdcband;
+	u8 rsv[1];
+	__le32 max_interval;
+} __packed;
+/* cnm end */
+
 enum mt7921_sdio_pkt_type {
 	MT7921_SDIO_TXD,
 	MT7921_SDIO_DATA,
@@ -185,9 +209,16 @@ struct mt7921_phy {
 
 	struct sk_buff_head scan_event_list;
 	struct delayed_work scan_work;
+
 #ifdef CONFIG_ACPI
 	struct mt7921_acpi_sar *acpisar;
 #endif
+
+	struct work_struct roc_work;
+	struct timer_list roc_timer;
+	wait_queue_head_t roc_wait;
+	u8 roc_token_id;
+	bool roc_grant;
 };
 
 #define mt7921_init_reset(dev)		((dev)->hif_ops->init_reset(dev))
@@ -228,6 +259,7 @@ struct mt7921_dev {
 	struct mt76_connac_pm pm;
 	struct mt76_connac_coredump coredump;
 	const struct mt7921_hif_ops *hif_ops;
+	struct ieee80211_ops *ops;
 
 	struct work_struct ipv6_ns_work;
 	/* IPv6 addresses for WoWLAN */
@@ -412,6 +444,8 @@ int mt7921_mcu_uni_rx_ba(struct mt7921_dev *dev,
 			 struct ieee80211_ampdu_params *params,
 			 bool enable);
 void mt7921_scan_work(struct work_struct *work);
+void mt7921_roc_work(struct work_struct *work);
+void mt7921_roc_timer(struct timer_list *timer);
 int mt7921_mcu_uni_bss_ps(struct mt7921_dev *dev, struct ieee80211_vif *vif);
 int mt7921_mcu_drv_pmctrl(struct mt7921_dev *dev);
 int mt7921_mcu_fw_pmctrl(struct mt7921_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 9d1ba838e54f..0692fb0f91ca 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -252,6 +252,7 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 	};
 
 	struct mt76_bus_ops *bus_ops;
+	struct ieee80211_ops *ops;
 	struct mt7921_dev *dev;
 	struct mt76_dev *mdev;
 	int ret;
@@ -277,8 +278,14 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 	if (mt7921_disable_aspm)
 		mt76_pci_disable_aspm(pdev);
 
-	mdev = mt76_alloc_device(&pdev->dev, sizeof(*dev), &mt7921_ops,
-				 &drv_ops);
+	ops = devm_kmemdup(&pdev->dev, &mt7921_ops, sizeof(mt7921_ops),
+			   GFP_KERNEL);
+	if (!ops) {
+		ret = -ENOMEM;
+		goto err_free_pci_vec;
+	}
+
+	mdev = mt76_alloc_device(&pdev->dev, sizeof(*dev), ops, &drv_ops);
 	if (!mdev) {
 		ret = -ENOMEM;
 		goto err_free_pci_vec;
@@ -286,7 +293,7 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 
 	dev = container_of(mdev, struct mt7921_dev, mt76);
 	dev->hif_ops = &mt7921_pcie_ops;
-
+	dev->ops = ops;
 	mt76_mmio_init(&dev->mt76, pcim_iomap_table(pdev)[0]);
 	tasklet_init(&dev->irq_tasklet, mt7921_irq_tasklet, (unsigned long)dev);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
index 487acd6e2be8..6d27875f41b8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
@@ -120,18 +120,23 @@ static int mt7921s_probe(struct sdio_func *func,
 		.fw_own = mt7921s_mcu_fw_pmctrl,
 	};
 
+	struct ieee80211_ops *ops;
 	struct mt7921_dev *dev;
 	struct mt76_dev *mdev;
 	int ret;
 
-	mdev = mt76_alloc_device(&func->dev, sizeof(*dev), &mt7921_ops,
-				 &drv_ops);
+	ops = devm_kmemdup(&func->dev, &mt7921_ops, sizeof(mt7921_ops),
+			   GFP_KERNEL);
+	if (!ops)
+		return -ENOMEM;
+
+	mdev = mt76_alloc_device(&func->dev, sizeof(*dev), ops, &drv_ops);
 	if (!mdev)
 		return -ENOMEM;
 
 	dev = container_of(mdev, struct mt7921_dev, mt76);
 	dev->hif_ops = &mt7921_sdio_ops;
-
+	dev->ops = ops;
 	sdio_set_drvdata(func, dev);
 
 	ret = mt76s_init(mdev, func, &mt7921s_ops);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
index d06cee386acd..cf3ec59a4270 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
@@ -217,6 +217,7 @@ static int mt7921u_probe(struct usb_interface *usb_intf,
 
 	dev = container_of(mdev, struct mt7921_dev, mt76);
 	dev->hif_ops = &hif_ops;
+	dev->ops = ops;
 
 	udev = usb_get_dev(udev);
 	usb_reset_device(udev);
-- 
2.25.1

