Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12DEF39CF4E
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Jun 2021 15:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhFFNUJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Jun 2021 09:20:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230025AbhFFNUI (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Jun 2021 09:20:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 216A9613AF;
        Sun,  6 Jun 2021 13:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622985499;
        bh=mRj4mj6nVSCNSkqDXu2kclCnGMLxYsZDc8QFUJu1NAc=;
        h=From:To:Cc:Subject:Date:From;
        b=paLkM5Dbe0GHf7rJGBu8YQtLJ5LSqSDFZWkVwT2ld16Sx2DAbCD77pL63jHy/9gw6
         adSqU7CpCgUwR5lX/0avxUEWgbjPB2i7AP+5WjOewUetEFxDQ6M7Rs9CQWytM8pJlX
         sLpSaoIccSVpVfor4DygPGSIZa2h7sPX68oQt5IfJlipFf3uYg3JcuQSeXLWrPEdPE
         g6zpNF4mEszY515E7LBdMBV2+XukjVJ3+8ymFevaXuxpTf4TpwurieDE6uJ7xbBHSl
         yvDTqunm6MgPCYmtENsao7GS9kXB7BwTFoqxWju6hRDIRBSqE1uSY/GYSzXmr/ZAIp
         OgYc2kZf3+BVg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        deren.wu@mediatek.com, sean.wang@mediatek.com
Subject: [PATCH] mt76: connac: add mt76_connac_mcu_get_nic_capability utility routine
Date:   Sun,  6 Jun 2021 15:18:12 +0200
Message-Id: <fb07f0bbbe7d8f0519c452736486a77c96d13bf2.1622985463.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt76_connac_mcu_get_nic_capability utility routine to poll
device capabilities returned by mcu fw for CE devices (mt7663/mt7921).
This is a preliminary patch to introduce 6GHz support.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  1 +
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 54 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  | 24 +++++++++
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   |  2 +-
 4 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index ebacd55cb0cd..338219024ba7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -320,6 +320,7 @@ enum {
 struct mt76_hw_cap {
 	bool has_2ghz;
 	bool has_5ghz;
+	bool has_6ghz;
 };
 
 #define MT_DRV_TXWI_NO_FREE		BIT(0)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 7f144c414488..8fe09e7363ca 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1646,6 +1646,60 @@ void mt76_connac_mcu_coredump_event(struct mt76_dev *dev, struct sk_buff *skb,
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_coredump_event);
 
+int mt76_connac_mcu_get_nic_capability(struct mt76_phy *phy)
+{
+	struct mt76_connac_cap_hdr {
+		__le16 n_element;
+		u8 rsv[2];
+	} __packed * hdr;
+	struct sk_buff *skb;
+	int ret, i;
+
+	ret = mt76_mcu_send_and_get_msg(phy->dev, MCU_CMD_GET_NIC_CAPAB, NULL,
+					0, true, &skb);
+	if (ret)
+		return ret;
+
+	hdr = (struct mt76_connac_cap_hdr *)skb->data;
+	if (skb->len < sizeof(*hdr)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	skb_pull(skb, sizeof(*hdr));
+
+	for (i = 0; i < le16_to_cpu(hdr->n_element); i++) {
+		struct tlv_hdr {
+			__le32 type;
+			__le32 len;
+		} __packed * tlv = (struct tlv_hdr *)skb->data;
+		int len;
+
+		if (skb->len < sizeof(*tlv))
+			break;
+
+		skb_pull(skb, sizeof(*tlv));
+
+		len = le32_to_cpu(tlv->len);
+		if (skb->len < len)
+			break;
+
+		switch (le32_to_cpu(tlv->type)) {
+		case MT_NIC_CAP_6G:
+			phy->cap.has_6ghz = skb->data[0];
+			break;
+		default:
+			break;
+		}
+		skb_pull(skb, len);
+	}
+out:
+	dev_kfree_skb(skb);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_get_nic_capability);
+
 static void
 mt76_connac_mcu_build_sku(struct mt76_dev *dev, s8 *sku,
 			  struct mt76_power_limits *limits,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 258b262c7c23..1ffc890957d0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -559,6 +559,7 @@ enum {
 	MCU_CMD_SET_RATE_TX_POWER = MCU_CE_PREFIX | 0x5d,
 	MCU_CMD_SCHED_SCAN_ENABLE = MCU_CE_PREFIX | 0x61,
 	MCU_CMD_SCHED_SCAN_REQ = MCU_CE_PREFIX | 0x62,
+	MCU_CMD_GET_NIC_CAPAB = MCU_CE_PREFIX | 0x8a,
 	MCU_CMD_REG_WRITE = MCU_CE_PREFIX | 0xc0,
 	MCU_CMD_REG_READ = MCU_CE_PREFIX | MCU_QUERY_MASK | 0xc0,
 	MCU_CMD_CHIP_CONFIG = MCU_CE_PREFIX | 0xca,
@@ -591,6 +592,28 @@ enum {
 	UNI_OFFLOAD_OFFLOAD_BMC_RPY_DETECT,
 };
 
+enum {
+	MT_NIC_CAP_TX_RESOURCE,
+	MT_NIC_CAP_TX_EFUSE_ADDR,
+	MT_NIC_CAP_COEX,
+	MT_NIC_CAP_SINGLE_SKU,
+	MT_NIC_CAP_CSUM_OFFLOAD,
+	MT_NIC_CAP_HW_VER,
+	MT_NIC_CAP_SW_VER,
+	MT_NIC_CAP_MAC_ADDR,
+	MT_NIC_CAP_PHY,
+	MT_NIC_CAP_MAC,
+	MT_NIC_CAP_FRAME_BUF,
+	MT_NIC_CAP_BEAM_FORM,
+	MT_NIC_CAP_LOCATION,
+	MT_NIC_CAP_MUMIMO,
+	MT_NIC_CAP_BUFFER_MODE_INFO,
+	MT_NIC_CAP_HW_ADIE_VERSION = 0x14,
+	MT_NIC_CAP_ANTSWP = 0x16,
+	MT_NIC_CAP_WFDMA_REALLOC,
+	MT_NIC_CAP_6G,
+};
+
 #define UNI_WOW_DETECT_TYPE_MAGIC		BIT(0)
 #define UNI_WOW_DETECT_TYPE_ANY			BIT(1)
 #define UNI_WOW_DETECT_TYPE_DISCONNECT		BIT(2)
@@ -1032,6 +1055,7 @@ int mt76_connac_mcu_init_download(struct mt76_dev *dev, u32 addr, u32 len,
 int mt76_connac_mcu_start_patch(struct mt76_dev *dev);
 int mt76_connac_mcu_patch_sem_ctrl(struct mt76_dev *dev, bool get);
 int mt76_connac_mcu_start_firmware(struct mt76_dev *dev, u32 addr, u32 option);
+int mt76_connac_mcu_get_nic_capability(struct mt76_phy *phy);
 
 int mt76_connac_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
 			    struct ieee80211_scan_request *scan_req);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index bd94d1244975..ca481e37d22c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -988,7 +988,7 @@ int mt7921_run_firmware(struct mt7921_dev *dev)
 	set_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
 	mt7921_mcu_fw_log_2_host(dev, 1);
 
-	return 0;
+	return mt76_connac_mcu_get_nic_capability(&dev->mphy);
 }
 
 int mt7921_mcu_init(struct mt7921_dev *dev)
-- 
2.31.1

