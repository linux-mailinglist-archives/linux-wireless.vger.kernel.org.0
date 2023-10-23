Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CB67D3B1D
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Oct 2023 17:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbjJWPmV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Oct 2023 11:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjJWPmN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Oct 2023 11:42:13 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF73210A
        for <linux-wireless@vger.kernel.org>; Mon, 23 Oct 2023 08:42:08 -0700 (PDT)
X-UUID: b43f0bee71ba11eea33bb35ae8d461a2-20231023
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=nbbJzjCUWbQxubs9OMtOWWmlA3+xOUYS/DRjRy0p08g=;
        b=T+23oUgsdzF0YAAAspm+VtHYiuTUnD/ISPRBH5qpDkYFdw7kZmAPSMn1pCTcBVkZi6DIWtGEDUHwt6ORrz5UHtW5j54yf7aGzeZWSi4YekJjd8ByTiTZaGUkYrxOoIwq8GdrpOfds56EPE5xiHMTuXKWF8cW500/IyXrMshNccQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:2210efb5-0081-42ad-9a4b-fe729bcef7c9,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:5f78ec9,CLOUDID:cf95abfb-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: b43f0bee71ba11eea33bb35ae8d461a2-20231023
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 462291391; Mon, 23 Oct 2023 23:41:59 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 23 Oct 2023 23:41:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 23 Oct 2023 23:41:58 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Howard Hsu <howard-yh.hsu@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 03/11] wifi: mt76: connac: add thermal protection support for mt7996
Date:   Mon, 23 Oct 2023 23:38:46 +0800
Message-ID: <20231023153854.10708-3-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231023153854.10708-1-shayne.chen@mediatek.com>
References: <20231023153854.10708-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Howard Hsu <howard-yh.hsu@mediatek.com>

Implement thermal protection commands and support Linux cooling device
control for mt7996 chipsets.

Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |   1 +
 .../net/wireless/mediatek/mt76/mt7996/init.c  | 102 +++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7996/main.c  |   8 ++
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 104 ++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7996/mcu.h   |  44 ++++++++
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  15 +++
 6 files changed, 274 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 97822f7d46cc..1d8680b153a7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1021,6 +1021,7 @@ enum {
 	MCU_UNI_EVENT_RDD_REPORT = 0x11,
 	MCU_UNI_EVENT_ROC = 0x27,
 	MCU_UNI_EVENT_TX_DONE = 0x2d,
+	MCU_UNI_EVENT_THERMAL = 0x35,
 	MCU_UNI_EVENT_NIC_CAPAB = 0x43,
 	MCU_UNI_EVENT_WED_RRO = 0x57,
 	MCU_UNI_EVENT_PER_STA_INFO = 0x6d,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 5af85ddfdc36..02b47b299ea8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -43,6 +43,97 @@ static const struct ieee80211_iface_combination if_comb[] = {
 	}
 };
 
+static int
+mt7996_thermal_get_max_throttle_state(struct thermal_cooling_device *cdev,
+				      unsigned long *state)
+{
+	*state = MT7996_CDEV_THROTTLE_MAX;
+
+	return 0;
+}
+
+static int
+mt7996_thermal_get_cur_throttle_state(struct thermal_cooling_device *cdev,
+				      unsigned long *state)
+{
+	struct mt7996_phy *phy = cdev->devdata;
+
+	*state = phy->cdev_state;
+
+	return 0;
+}
+
+static int
+mt7996_thermal_set_cur_throttle_state(struct thermal_cooling_device *cdev,
+				      unsigned long state)
+{
+	struct mt7996_phy *phy = cdev->devdata;
+	u8 throttling = MT7996_THERMAL_THROTTLE_MAX - state;
+	int ret;
+
+	if (state > MT7996_CDEV_THROTTLE_MAX) {
+		dev_err(phy->dev->mt76.dev,
+			"please specify a valid throttling state\n");
+		return -EINVAL;
+	}
+
+	if (state == phy->cdev_state)
+		return 0;
+
+	/* cooling_device convention: 0 = no cooling, more = more cooling
+	 * mcu convention: 1 = max cooling, more = less cooling
+	 */
+	ret = mt7996_mcu_set_thermal_throttling(phy, throttling);
+	if (ret)
+		return ret;
+
+	phy->cdev_state = state;
+
+	return 0;
+}
+
+static const struct thermal_cooling_device_ops mt7996_thermal_ops = {
+	.get_max_state = mt7996_thermal_get_max_throttle_state,
+	.get_cur_state = mt7996_thermal_get_cur_throttle_state,
+	.set_cur_state = mt7996_thermal_set_cur_throttle_state,
+};
+
+static void mt7996_unregister_thermal(struct mt7996_phy *phy)
+{
+	struct wiphy *wiphy = phy->mt76->hw->wiphy;
+
+	if (!phy->cdev)
+		return;
+
+	sysfs_remove_link(&wiphy->dev.kobj, "cooling_device");
+	thermal_cooling_device_unregister(phy->cdev);
+}
+
+static int mt7996_thermal_init(struct mt7996_phy *phy)
+{
+	struct wiphy *wiphy = phy->mt76->hw->wiphy;
+	struct thermal_cooling_device *cdev;
+	const char *name;
+
+	name = devm_kasprintf(&wiphy->dev, GFP_KERNEL, "mt7996_%s",
+			      wiphy_name(wiphy));
+
+	cdev = thermal_cooling_device_register(name, phy, &mt7996_thermal_ops);
+	if (!IS_ERR(cdev)) {
+		if (sysfs_create_link(&wiphy->dev.kobj, &cdev->device.kobj,
+				      "cooling_device") < 0)
+			thermal_cooling_device_unregister(cdev);
+		else
+			phy->cdev = cdev;
+	}
+
+	/* initialize critical/maximum high temperature */
+	phy->throttle_temp[MT7996_CRIT_TEMP_IDX] = MT7996_CRIT_TEMP;
+	phy->throttle_temp[MT7996_MAX_TEMP_IDX] = MT7996_MAX_TEMP;
+
+	return 0;
+}
+
 static void mt7996_led_set_config(struct led_classdev *led_cdev,
 				  u8 delay_on, u8 delay_off)
 {
@@ -429,6 +520,10 @@ static int mt7996_register_phy(struct mt7996_dev *dev, struct mt7996_phy *phy,
 	if (ret)
 		goto error;
 
+	ret = mt7996_thermal_init(phy);
+	if (ret)
+		goto error;
+
 	ret = mt7996_init_debugfs(phy);
 	if (ret)
 		goto error;
@@ -456,6 +551,8 @@ mt7996_unregister_phy(struct mt7996_phy *phy, enum mt76_band_id band)
 	if (!phy)
 		return;
 
+	mt7996_unregister_thermal(phy);
+
 	mphy = phy->dev->mt76.phys[band];
 	mt76_unregister_phy(mphy);
 	ieee80211_free_hw(mphy->hw);
@@ -1130,6 +1227,10 @@ int mt7996_register_device(struct mt7996_dev *dev)
 	if (ret)
 		return ret;
 
+	ret = mt7996_thermal_init(&dev->phy);
+	if (ret)
+		return ret;
+
 	ieee80211_queue_work(mt76_hw(dev), &dev->init_work);
 
 	ret = mt7996_register_phy(dev, mt7996_phy2(dev), MT_BAND1);
@@ -1154,6 +1255,7 @@ void mt7996_unregister_device(struct mt7996_dev *dev)
 	cancel_work_sync(&dev->wed_rro.work);
 	mt7996_unregister_phy(mt7996_phy3(dev), MT_BAND2);
 	mt7996_unregister_phy(mt7996_phy2(dev), MT_BAND1);
+	mt7996_unregister_thermal(&dev->phy);
 	mt7996_coredump_unregister(dev);
 	mt76_unregister_device(&dev->mt76);
 	mt7996_wed_rro_free(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index f074616c7007..33a9d50d3366 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -51,6 +51,14 @@ int mt7996_run(struct ieee80211_hw *hw)
 	if (ret)
 		goto out;
 
+	ret = mt7996_mcu_set_thermal_throttling(phy, MT7996_THERMAL_THROTTLE_MAX);
+	if (ret)
+		goto out;
+
+	ret = mt7996_mcu_set_thermal_protect(phy, true);
+	if (ret)
+		goto out;
+
 	set_bit(MT76_STATE_RUNNING, &phy->mt76->state);
 
 	ieee80211_queue_delayed_work(hw, &phy->mt76->mac_work,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index e379ac4cc5d3..34e83795c76b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -497,6 +497,34 @@ mt7996_mcu_rx_all_sta_info_event(struct mt7996_dev *dev, struct sk_buff *skb)
 	}
 }
 
+static void
+mt7996_mcu_rx_thermal_notify(struct mt7996_dev *dev, struct sk_buff *skb)
+{
+#define THERMAL_NOTIFY_TAG 0x4
+#define THERMAL_NOTIFY 0x2
+	struct mt76_phy *mphy = &dev->mt76.phy;
+	struct mt7996_mcu_thermal_notify *n;
+	struct mt7996_phy *phy;
+
+	n = (struct mt7996_mcu_thermal_notify *)skb->data;
+
+	if (le16_to_cpu(n->tag) != THERMAL_NOTIFY_TAG)
+		return;
+
+	if (n->event_id != THERMAL_NOTIFY)
+		return;
+
+	if (n->band_idx > MT_BAND2)
+		return;
+
+	mphy = dev->mt76.phys[n->band_idx];
+	if (!mphy)
+		return;
+
+	phy = (struct mt7996_phy *)mphy->priv;
+	phy->throttle_state = n->duty_percent;
+}
+
 static void
 mt7996_mcu_rx_ext_event(struct mt7996_dev *dev, struct sk_buff *skb)
 {
@@ -520,6 +548,9 @@ mt7996_mcu_rx_unsolicited_event(struct mt7996_dev *dev, struct sk_buff *skb)
 	case MCU_EVENT_EXT:
 		mt7996_mcu_rx_ext_event(dev, skb);
 		break;
+	case MCU_UNI_EVENT_THERMAL:
+		mt7996_mcu_rx_thermal_notify(dev, skb);
+		break;
 	default:
 		break;
 	}
@@ -3571,6 +3602,79 @@ int mt7996_mcu_get_chan_mib_info(struct mt7996_phy *phy, bool chan_switch)
 	return 0;
 }
 
+int mt7996_mcu_set_thermal_throttling(struct mt7996_phy *phy, u8 state)
+{
+	struct {
+		u8 _rsv[4];
+
+		__le16 tag;
+		__le16 len;
+
+		struct mt7996_mcu_thermal_ctrl ctrl;
+	} __packed req = {
+		.tag = cpu_to_le16(UNI_CMD_THERMAL_PROTECT_DUTY_CONFIG),
+		.len = cpu_to_le16(sizeof(req) - 4),
+		.ctrl = {
+			.band_idx = phy->mt76->band_idx,
+		},
+	};
+	int level, ret;
+
+	/* set duty cycle and level */
+	for (level = 0; level < 4; level++) {
+		req.ctrl.duty.duty_level = level;
+		req.ctrl.duty.duty_cycle = state;
+		state /= 2;
+
+		ret = mt76_mcu_send_msg(&phy->dev->mt76, MCU_WM_UNI_CMD(THERMAL),
+					&req, sizeof(req), false);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+int mt7996_mcu_set_thermal_protect(struct mt7996_phy *phy, bool enable)
+{
+#define SUSTAIN_PERIOD		10
+	struct {
+		u8 _rsv[4];
+
+		__le16 tag;
+		__le16 len;
+
+		struct mt7996_mcu_thermal_ctrl ctrl;
+		struct mt7996_mcu_thermal_enable enable;
+	} __packed req = {
+		.len = cpu_to_le16(sizeof(req) - 4 - sizeof(req.enable)),
+		.ctrl = {
+			.band_idx = phy->mt76->band_idx,
+			.type.protect_type = 1,
+			.type.trigger_type = 1,
+		},
+	};
+	int ret;
+
+	req.tag = cpu_to_le16(UNI_CMD_THERMAL_PROTECT_DISABLE);
+
+	ret = mt76_mcu_send_msg(&phy->dev->mt76, MCU_WM_UNI_CMD(THERMAL),
+				&req, sizeof(req) - sizeof(req.enable), false);
+	if (ret || !enable)
+		return ret;
+
+	/* set high-temperature trigger threshold */
+	req.tag = cpu_to_le16(UNI_CMD_THERMAL_PROTECT_ENABLE);
+	req.enable.restore_temp = cpu_to_le32(phy->throttle_temp[0]);
+	req.enable.trigger_temp = cpu_to_le32(phy->throttle_temp[1]);
+	req.enable.sustain_time = cpu_to_le16(SUSTAIN_PERIOD);
+
+	req.len = cpu_to_le16(sizeof(req) - 4);
+
+	return mt76_mcu_send_msg(&phy->dev->mt76, MCU_WM_UNI_CMD(THERMAL),
+				 &req, sizeof(req), false);
+}
+
 int mt7996_mcu_set_ser(struct mt7996_dev *dev, u8 action, u8 val, u8 band)
 {
 	struct {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
index e32a78d6622b..4a73850db9c0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
@@ -30,6 +30,28 @@ struct mt7996_mcu_uni_event {
 	__le32 status; /* 0: success, others: fail */
 } __packed;
 
+struct mt7996_mcu_thermal_ctrl {
+	u8 ctrl_id;
+	u8 band_idx;
+	union {
+		struct {
+			u8 protect_type; /* 1: duty admit, 2: radio off */
+			u8 trigger_type; /* 0: low, 1: high */
+		} __packed type;
+		struct {
+			u8 duty_level;	/* level 0~3 */
+			u8 duty_cycle;
+		} __packed duty;
+	};
+} __packed;
+
+struct mt7996_mcu_thermal_enable {
+	__le32 trigger_temp;
+	__le32 restore_temp;
+	__le16 sustain_time;
+	u8 rsv[2];
+} __packed;
+
 struct mt7996_mcu_csa_notify {
 	struct mt7996_mcu_rxd rxd;
 
@@ -214,6 +236,22 @@ enum  {
 	UNI_WED_RRO_BA_SESSION_DELETE,
 };
 
+struct mt7996_mcu_thermal_notify {
+	struct mt7996_mcu_rxd rxd;
+
+	u8 __rsv1[4];
+
+	__le16 tag;
+	__le16 len;
+
+	u8 event_id;
+	u8 band_idx;
+	u8 level_idx;
+	u8 duty_percent;
+	__le32 restore_temp;
+	u8 __rsv2[4];
+} __packed;
+
 enum mt7996_chan_mib_offs {
 	UNI_MIB_OBSS_AIRTIME = 26,
 	UNI_MIB_NON_WIFI_TIME = 27,
@@ -719,6 +757,12 @@ enum{
 	UNI_CMD_SR_SET_SIGA = 0xd0,
 };
 
+enum {
+	UNI_CMD_THERMAL_PROTECT_ENABLE = 0x6,
+	UNI_CMD_THERMAL_PROTECT_DISABLE,
+	UNI_CMD_THERMAL_PROTECT_DUTY_CONFIG,
+};
+
 enum {
 	UNI_CMD_ACCESS_REG_BASIC = 0x0,
 	UNI_CMD_ACCESS_RF_REG_BASIC,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 6acc0ae286fa..61e0f905d902 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -50,6 +50,13 @@
 #define MT7996_BASIC_RATES_TBL		11
 #define MT7996_BEACON_RATES_TBL		25
 
+#define MT7996_THERMAL_THROTTLE_MAX	100
+#define MT7996_CDEV_THROTTLE_MAX	99
+#define MT7996_CRIT_TEMP_IDX		0
+#define MT7996_MAX_TEMP_IDX		1
+#define MT7996_CRIT_TEMP		110
+#define MT7996_MAX_TEMP			120
+
 #define MT7996_RRO_MAX_SESSION		1024
 #define MT7996_RRO_WINDOW_MAX_LEN	1024
 #define MT7996_RRO_ADDR_ELEM_LEN	128
@@ -195,6 +202,11 @@ struct mt7996_phy {
 
 	struct ieee80211_vif *monitor_vif;
 
+	struct thermal_cooling_device *cdev;
+	u8 cdev_state;
+	u8 throttle_state;
+	u32 throttle_temp[2]; /* 0: critical high, 1: maximum */
+
 	u32 rxfilter;
 	u64 omac_mask;
 
@@ -453,6 +465,9 @@ int mt7996_mcu_set_radio_en(struct mt7996_phy *phy, bool enable);
 int mt7996_mcu_set_rts_thresh(struct mt7996_phy *phy, u32 val);
 int mt7996_mcu_set_timing(struct mt7996_phy *phy, struct ieee80211_vif *vif);
 int mt7996_mcu_get_chan_mib_info(struct mt7996_phy *phy, bool chan_switch);
+int mt7996_mcu_get_temperature(struct mt7996_phy *phy);
+int mt7996_mcu_set_thermal_throttling(struct mt7996_phy *phy, u8 state);
+int mt7996_mcu_set_thermal_protect(struct mt7996_phy *phy, bool enable);
 int mt7996_mcu_rdd_cmd(struct mt7996_dev *dev, int cmd, u8 index,
 		       u8 rx_sel, u8 val);
 int mt7996_mcu_rdd_background_enable(struct mt7996_phy *phy,
-- 
2.39.2

