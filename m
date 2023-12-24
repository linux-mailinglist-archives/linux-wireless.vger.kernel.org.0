Return-Path: <linux-wireless+bounces-1272-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7837F81D82E
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Dec 2023 09:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23CB728232B
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Dec 2023 08:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4F1111D;
	Sun, 24 Dec 2023 08:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UOz0Poob"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB3115A1
	for <linux-wireless@vger.kernel.org>; Sun, 24 Dec 2023 08:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 90a20304a23311eeba30773df0976c77-20231224
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=M5Ap3MIoom3Cah/P1/+3hr2fJ0d5kw3uyf9qk8neY38=;
	b=UOz0Poobu0BU9HJ4vSZfEOaRxcmbk4eMPxDBtbM+5WdSnpJ4zFgZi9sg9ke/nq8kSNer2FdpusmGBfRmduqBdpIX65QImmoUrLoEYN+X/zYlGcoqsycoNAIMGHpcyks1PbVsOkaknv+Zk1UFZyHFXjPrL/1pdbnmzHo5h4vcTqo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:432a656e-86e2-4494-9d75-37034863bfd7,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:5d391d7,CLOUDID:d2311b82-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 90a20304a23311eeba30773df0976c77-20231224
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <deren.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1067553020; Sun, 24 Dec 2023 16:08:04 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 24 Dec 2023 16:08:03 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sun, 24 Dec 2023 16:08:02 +0800
From: Deren Wu <deren.wu@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC: Sean Wang <sean.wang@mediatek.com>, Soul Huang <Soul.Huang@mediatek.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>, Leon Yen
	<Leon.Yen@mediatek.com>, Eric-SY Chang <Eric-SY.Chang@mediatek.com>, KM Lin
	<km.lin@mediatek.com>, Robin Chiu <robin.chiu@mediatek.com>, CH Yeh
	<ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>, Quan Zhou
	<quan.zhou@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen
	<shayne.chen@mediatek.com>, linux-wireless <linux-wireless@vger.kernel.org>,
	linux-mediatek <linux-mediatek@lists.infradead.org>, Deren Wu
	<deren.wu@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7925: support temperature sensor
Date: Sun, 24 Dec 2023 16:04:59 +0800
Message-ID: <90a818483daff3c6fa2a2a2367dc0cc0be9b3378.1703403371.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--7.656000-8.000000
X-TMASE-MatchedRID: PehFwp3zCOBjcGvWjN+53s9tRbA8O6QzlZnydB88IJLfUZT83lbkEPq+
	JLKFEPMF4ZQqYHZtqxjtaDDr9p69jSFj8NsBczzdFYJUGv4DL3y2McZY43zJ423D6f6IpbLIawP
	hQZJn9Bzx6gF+AN4QjiB0rM1vTjvT87Q/R9NEbKsZXJLztZviXPngX/aL8PCNYdpcZH3BrBR0v1
	TYNt6TWl2EerRYP46mB6TWlWdPFRI2xqN5L+oQEqIBnfMCFBiCVddk7QGQHackm/L/MIL+8ppuE
	ZGhn28t3VN4WLcWL3BftuJwrFEhTY2j49Ftap9Eymsk/wUE4ho2+VkdMxapXE8iY45nBhHymHjZ
	ALHIFjpAtJKqHMn6+f1ZpzwLrNQq
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--7.656000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	C09AB1D4CF61D677CB0C535EF66C83E69EA53BCC56189DE152ACE82E3138E1F22000:8
X-MTK: N

Allow sensors tool to read radio's temperature, example:

mt7925_phy8-pci-3b00
Adapter: PCI adapter
temp1:        +35.0°C

Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/init.c  | 56 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 36 ++++++++++++
 .../wireless/mediatek/mt76/mt7925/mt7925.h    |  1 +
 3 files changed, 93 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/init.c b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
index 8f9b7a2f376c..c4cbc8976046 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
@@ -2,11 +2,61 @@
 /* Copyright (C) 2023 MediaTek Inc. */
 
 #include <linux/etherdevice.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/thermal.h>
 #include <linux/firmware.h>
 #include "mt7925.h"
 #include "mac.h"
 #include "mcu.h"
 
+static ssize_t mt7925_thermal_temp_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	switch (to_sensor_dev_attr(attr)->index) {
+	case 0: {
+		struct mt792x_phy *phy = dev_get_drvdata(dev);
+		struct mt792x_dev *mdev = phy->dev;
+		int temperature;
+
+		mt792x_mutex_acquire(mdev);
+		temperature = mt7925_mcu_get_temperature(phy);
+		mt792x_mutex_release(mdev);
+
+		if (temperature < 0)
+			return temperature;
+		/* display in millidegree Celsius */
+		return sprintf(buf, "%u\n", temperature * 1000);
+	}
+	default:
+		return -EINVAL;
+	}
+}
+static SENSOR_DEVICE_ATTR_RO(temp1_input, mt7925_thermal_temp, 0);
+
+static struct attribute *mt7925_hwmon_attrs[] = {
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(mt7925_hwmon);
+
+static int mt7925_thermal_init(struct mt792x_phy *phy)
+{
+	struct wiphy *wiphy = phy->mt76->hw->wiphy;
+	struct device *hwmon;
+	const char *name;
+
+	if (!IS_REACHABLE(CONFIG_HWMON))
+		return 0;
+
+	name = devm_kasprintf(&wiphy->dev, GFP_KERNEL, "mt7925_%s",
+			      wiphy_name(wiphy));
+
+	hwmon = devm_hwmon_device_register_with_groups(&wiphy->dev, name, phy,
+						       mt7925_hwmon_groups);
+	return PTR_ERR_OR_ZERO(hwmon);
+}
 static void
 mt7925_regd_notifier(struct wiphy *wiphy,
 		     struct regulatory_request *req)
@@ -142,6 +192,12 @@ static void mt7925_init_work(struct work_struct *work)
 		return;
 	}
 
+	ret = mt7925_thermal_init(&dev->phy);
+	if (ret) {
+		dev_err(dev->mt76.dev, "thermal init failed\n");
+		return;
+	}
+
 	/* we support chip reset now */
 	dev->hw_init_done = true;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index c5fd7116929b..d6909d77bbe1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -656,6 +656,42 @@ int mt7925_mcu_fw_log_2_host(struct mt792x_dev *dev, u8 ctrl)
 	return ret;
 }
 
+int mt7925_mcu_get_temperature(struct mt792x_phy *phy)
+{
+	struct {
+		u8 _rsv[4];
+
+		__le16 tag;
+		__le16 len;
+		u8 _rsv2[4];
+	} __packed req = {
+		.tag = cpu_to_le16(0x0),
+		.len = cpu_to_le16(sizeof(req) - 4),
+	};
+	struct mt7925_thermal_evt {
+		u8 rsv[4];
+		__le32 temperature;
+	} __packed * evt;
+	struct mt792x_dev *dev = phy->dev;
+	int temperature, ret;
+	struct sk_buff *skb;
+
+	ret = mt76_mcu_send_and_get_msg(&dev->mt76,
+					MCU_WM_UNI_CMD_QUERY(THERMAL),
+					&req, sizeof(req), true, &skb);
+	if (ret)
+		return ret;
+
+	skb_pull(skb, 4 + sizeof(struct tlv));
+	evt = (struct mt7925_thermal_evt *)skb->data;
+
+	temperature = le32_to_cpu(evt->temperature);
+
+	dev_kfree_skb(skb);
+
+	return temperature;
+}
+
 static void
 mt7925_mcu_parse_phy_cap(struct mt792x_dev *dev, char *data)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
index 33785f526acf..8a4a71f6bcb6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -271,6 +271,7 @@ int mt7925_mcu_set_sniffer(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 			   bool enable);
 int mt7925_mcu_config_sniffer(struct mt792x_vif *vif,
 			      struct ieee80211_chanctx_conf *ctx);
+int mt7925_mcu_get_temperature(struct mt792x_phy *phy);
 
 int mt7925_usb_sdio_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 				   enum mt76_txq_id qid, struct mt76_wcid *wcid,
-- 
2.18.0


