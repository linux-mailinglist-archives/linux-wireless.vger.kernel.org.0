Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC5665F9A6
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jan 2023 03:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjAFCo1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Jan 2023 21:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjAFCoZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Jan 2023 21:44:25 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5052865AD0
        for <linux-wireless@vger.kernel.org>; Thu,  5 Jan 2023 18:44:20 -0800 (PST)
X-UUID: d6c2073855a1409a81a732d80dd20b0e-20230106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=yCgAEXW6eSFcKj+Z6Ey5MKhr/05jx4NkjqDNfQM7PgQ=;
        b=gVjpN6qKcPSL8sFzLgie2dNSyqbrV9x4/m2/AcWsQluZ8Yn4C+a74oTExrGyaGJVWwMkTBKsZ8VYJHuH9jbEpX/AzNzolTiv5B5ZiKCoakr29VnA6pj89Pvayx0h3n2ZDUVDPqozvRvgBnk1a9L1AwLewkRwycvZsI691JGacA0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:8b19a218-a5b0-4b0f-91cf-57a892852b18,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACT
        ION:release,TS:75
X-CID-INFO: VERSION:1.1.17,REQID:8b19a218-a5b0-4b0f-91cf-57a892852b18,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACT
        ION:quarantine,TS:75
X-CID-META: VersionHash:543e81c,CLOUDID:5ead688b-8530-4eff-9f77-222cf6e2895b,B
        ulkID:230106104415RDNRVZBT,BulkQuantity:0,Recheck:0,SF:28|17|19|48,TC:nil,
        Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0
X-CID-BVR: 0
X-UUID: d6c2073855a1409a81a732d80dd20b0e-20230106
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <chui-hao.chiu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1066521522; Fri, 06 Jan 2023 10:44:13 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 6 Jan 2023 10:44:13 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 6 Jan 2023 10:44:13 +0800
From:   Peter Chiu <chui-hao.chiu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.Lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Peter Chiu <chui-hao.chiu@mediatek.com>
Subject: [PATCH v2 2/2] wifi: mt76: mt7915: wed: enable red per-band token drop
Date:   Fri, 6 Jan 2023 10:44:12 +0800
Message-ID: <20230106024412.10064-2-chui-hao.chiu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230106024412.10064-1-chui-hao.chiu@mediatek.com>
References: <20230106024412.10064-1-chui-hao.chiu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Enable RED to limit the number of token used by each band. If single band
uses too many tokens, it would hurt the throughput of the other bands.The
software path can solve this problem by AQL so enable RED for HW path only.

Reviewed-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
---
v2:
  - Fix endianness and remove blank lines.
  - Add macro to prevent compile error without CONFIG_NET_MEDIATEK_SOC_SED.
  - Add static for mt7915_mcu_set_red.
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  1 +
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 50 ++++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  1 +
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  |  2 +-
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  1 +
 5 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index f1e942b9a887..855a434ecf54 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1171,6 +1171,7 @@ enum {
 	MCU_EXT_CMD_GET_MIB_INFO = 0x5a,
 	MCU_EXT_CMD_TXDPD_CAL = 0x60,
 	MCU_EXT_CMD_CAL_CACHE = 0x67,
+	MCU_EXT_CMD_RED_ENABLE = 0x68,
 	MCU_EXT_CMD_SET_RADAR_TH = 0x7c,
 	MCU_EXT_CMD_SET_RDD_PATTERN = 0x7d,
 	MCU_EXT_CMD_MWDS_SUPPORT = 0x80,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 37a3c1f082d9..b4fbd19e285a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2291,6 +2291,53 @@ mt7915_mcu_init_rx_airtime(struct mt7915_dev *dev)
 				 sizeof(req), true);
 }
 
+static int mt7915_red_set_watermark(struct mt7915_dev *dev)
+{
+#define RED_GLOBAL_TOKEN_WATERMARK 2
+	struct {
+		__le32 args[3];
+		u8 cmd;
+		u8 version;
+		u8 __rsv1[4];
+		__le16 len;
+		__le16 high_mark;
+		__le16 low_mark;
+		u8 __rsv2[12];
+	} __packed req = {
+		.args[0] = cpu_to_le32(MCU_WA_PARAM_RED_SETTING),
+		.cmd = RED_GLOBAL_TOKEN_WATERMARK,
+		.len = cpu_to_le16(sizeof(req) - sizeof(req.args)),
+		.high_mark = cpu_to_le16(MT7915_HW_TOKEN_SIZE - 256),
+		.low_mark = cpu_to_le16(MT7915_HW_TOKEN_SIZE - 256 - 1536),
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_WA_PARAM_CMD(SET), &req,
+				 sizeof(req), false);
+}
+
+static int mt7915_mcu_set_red(struct mt7915_dev *dev, bool enabled)
+{
+#define RED_DISABLE		0
+#define RED_BY_WA_ENABLE	2
+	int ret;
+	u32 red_type = enabled ? RED_BY_WA_ENABLE : RED_DISABLE;
+	__le32 req = cpu_to_le32(red_type);
+
+	if (enabled) {
+		ret = mt7915_red_set_watermark(dev);
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(RED_ENABLE), &req,
+				sizeof(req), false);
+	if (ret < 0)
+		return ret;
+
+	return mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(SET),
+				 MCU_WA_PARAM_RED, enabled, 0);
+}
+
 int mt7915_mcu_init_firmware(struct mt7915_dev *dev)
 {
 	int ret;
@@ -2339,8 +2386,7 @@ int mt7915_mcu_init_firmware(struct mt7915_dev *dev)
 	if (ret)
 		return ret;
 
-	return mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(SET),
-				 MCU_WA_PARAM_RED, 0, 0);
+	return mt7915_mcu_set_red(dev, mtk_wed_device_active(&dev->mt76.mmio.wed));
 }
 
 int mt7915_mcu_init(struct mt7915_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index 29b5434bfdb8..b9ea297f382c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -278,6 +278,7 @@ enum {
 	MCU_WA_PARAM_PDMA_RX = 0x04,
 	MCU_WA_PARAM_CPU_UTIL = 0x0b,
 	MCU_WA_PARAM_RED = 0x0e,
+	MCU_WA_PARAM_RED_SETTING = 0x40,
 };
 
 enum mcu_mmps_mode {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 1a2e4df8d1b5..b9e8cfd926c9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -748,7 +748,7 @@ int mt7915_mmio_wed_init(struct mt7915_dev *dev, void *pdev_ptr,
 		wed->wlan.wpdma_rx_glo = res->start + MT_WPDMA_GLO_CFG;
 		wed->wlan.wpdma_rx = res->start + MT_RXQ_WED_DATA_RING_BASE;
 	}
-	wed->wlan.nbuf = 4096;
+	wed->wlan.nbuf = MT7915_HW_TOKEN_SIZE;
 	wed->wlan.tx_tbit[0] = is_mt7915(&dev->mt76) ? 4 : 30;
 	wed->wlan.tx_tbit[1] = is_mt7915(&dev->mt76) ? 5 : 31;
 	wed->wlan.txfree_tbit = is_mt7986(&dev->mt76) ? 2 : 1;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 6351feba6bdf..45881e88efe0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -53,6 +53,7 @@
 #define MT7916_EEPROM_SIZE		4096
 
 #define MT7915_EEPROM_BLOCK_SIZE	16
+#define MT7915_HW_TOKEN_SIZE		4096
 #define MT7915_TOKEN_SIZE		8192
 
 #define MT7915_CFEND_RATE_DEFAULT	0x49	/* OFDM 24M */
-- 
2.18.0

