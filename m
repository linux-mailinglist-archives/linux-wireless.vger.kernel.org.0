Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05B6709C85
	for <lists+linux-wireless@lfdr.de>; Fri, 19 May 2023 18:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjESQgT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 May 2023 12:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjESQgS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 May 2023 12:36:18 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5038F
        for <linux-wireless@vger.kernel.org>; Fri, 19 May 2023 09:36:17 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 8F0E1C0009B
        for <linux-wireless@vger.kernel.org>; Fri, 19 May 2023 16:36:15 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id D5EB313C2B0;
        Fri, 19 May 2023 09:36:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com D5EB313C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1684514174;
        bh=l7ea+bs8bxlAWU+jgTrt27EimjhtfnXmrEdSTpXWkMs=;
        h=From:To:Cc:Subject:Date:From;
        b=f4dLjer4qmPjVR/EG0B1e7bcWXrniKUISMbzGo4cKuXy4Rg5P1lNTfR9GOjyBGOrI
         AhRu9Nn2DoFaF0VApR+mdHnqiIDi+giNxv+kz+VttOXZqdL70eBTC1wdBNd073sj+B
         CFi8ELk13sziw6JTz0KyCZZGGeZY6e2ZnWVO50sk=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH v2] wifi: mt76: mt7921:  Support temp sensor.
Date:   Fri, 19 May 2023 09:36:11 -0700
Message-Id: <20230519163611.1640585-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MDID: 1684514176-S414O4ruwi13
X-MDID-O: us5;ut7;1684514176;S414O4ruwi13;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Allow sensors tool to read radio's temperature, example:

mt7921_phy17-pci-1800
Adapter: PCI adapter
temp1:        +72.0°C

Signed-off-by: Ben Greear <greearb@candelatech.com>
---

v2:  Add mutex to protect mcu call, fix nits.

 .../net/wireless/mediatek/mt76/mt7921/init.c  | 56 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 17 ++++++
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  1 +
 3 files changed, 74 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index c15ce1a19000..01ad28102c8c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -2,6 +2,9 @@
 /* Copyright (C) 2020 MediaTek Inc. */
 
 #include <linux/etherdevice.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/thermal.h>
 #include <linux/firmware.h>
 #include "mt7921.h"
 #include "../mt76_connac2_mac.h"
@@ -58,6 +61,53 @@ static const struct ieee80211_iface_combination if_comb_chanctx[] = {
 	}
 };
 
+static ssize_t mt7921_thermal_temp_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	switch (to_sensor_dev_attr(attr)->index) {
+	case 0:
+		struct mt7921_phy *phy = dev_get_drvdata(dev);
+		struct mt7921_dev *mdev = phy->dev;
+		int temperature;
+
+		mt7921_mutex_acquire(mdev);
+		temperature = mt7921_mcu_get_temperature(phy);
+		mt7921_mutex_release(mdev);
+
+		if (temperature < 0)
+			return temperature;
+		/* display in millidegree Celcius */
+		return sprintf(buf, "%u\n", temperature * 1000);
+	default:
+		return -EINVAL;
+	}
+}
+static SENSOR_DEVICE_ATTR_RO(temp1_input, mt7921_thermal_temp, 0);
+
+static struct attribute *mt7921_hwmon_attrs[] = {
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(mt7921_hwmon);
+
+static int mt7921_thermal_init(struct mt7921_phy *phy)
+{
+	struct wiphy *wiphy = phy->mt76->hw->wiphy;
+	struct device *hwmon;
+	const char *name;
+
+	name = devm_kasprintf(&wiphy->dev, GFP_KERNEL, "mt7921_%s",
+			      wiphy_name(wiphy));
+
+	hwmon = devm_hwmon_device_register_with_groups(&wiphy->dev, name, phy,
+						       mt7921_hwmon_groups);
+	if (IS_ERR(hwmon))
+		return PTR_ERR(hwmon);
+
+	return 0;
+}
+
 static void
 mt7921_regd_notifier(struct wiphy *wiphy,
 		     struct regulatory_request *request)
@@ -384,6 +434,12 @@ static void mt7921_init_work(struct work_struct *work)
 		return;
 	}
 
+	ret = mt7921_thermal_init(&dev->phy);
+	if (ret) {
+		dev_err(dev->mt76.dev, "thermal_init failed\n");
+		return;
+	}
+
 	/* we support chip reset now */
 	dev->hw_init_done = true;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 9c4dcc0e5a7c..abeedacc28f2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -1346,6 +1346,23 @@ int mt7921_mcu_set_clc(struct mt7921_dev *dev, u8 *alpha2,
 	return 0;
 }
 
+int mt7921_mcu_get_temperature(struct mt7921_phy *phy)
+{
+	struct mt7921_dev *dev = phy->dev;
+	struct {
+		u8 ctrl_id;
+		u8 action;
+		u8 band_idx;
+		u8 rsv[5];
+	} req = {
+		.ctrl_id = THERMAL_SENSOR_TEMP_QUERY,
+		.band_idx = phy->mt76->band_idx,
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(THERMAL_CTRL), &req,
+				 sizeof(req), true);
+}
+
 int mt7921_mcu_set_rxfilter(struct mt7921_dev *dev, u32 fif,
 			    u8 bit_op, u32 bit_map)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 706f00df6836..85fddf99d497 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -568,6 +568,7 @@ int mt7921_mcu_set_sniffer(struct mt7921_dev *dev, struct ieee80211_vif *vif,
 			   bool enable);
 int mt7921_mcu_config_sniffer(struct mt7921_vif *vif,
 			      struct ieee80211_chanctx_conf *ctx);
+int mt7921_mcu_get_temperature(struct mt7921_phy *phy);
 
 int mt7921_usb_sdio_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 				   enum mt76_txq_id qid, struct mt76_wcid *wcid,
-- 
2.40.0

