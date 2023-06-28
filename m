Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8167409DD
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jun 2023 09:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjF1Hwi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Jun 2023 03:52:38 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:38902 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230201AbjF1Hw3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Jun 2023 03:52:29 -0400
X-UUID: 69f83be4158211ee9cb5633481061a41-20230628
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=V4Sk0ho4dALJLCSGdgPxDc+E/xVNOvig750/aX3CYRo=;
        b=BDEMmMMxcqC0ZeIkADu+6kWAoU4TTWgkgNcTanzzlVkfYHh624cnhnPiq9a2TZ3gIT9T43ak/UPxLTL0rEAIkzOKr/POORqRwHU+wqeMls1D3+smZtX02P1zxTRZrQf9SrVZBo2O3wvJZi7xrfjV7f5J8Gbhhhvfzn31DU6qg2I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:f4ddc402-60df-4d72-8d54-2100cdf483c5,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.27,REQID:f4ddc402-60df-4d72-8d54-2100cdf483c5,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:01c9525,CLOUDID:97694f0d-26a8-467f-b838-f99719a9c083,B
        ulkID:230628150718HX0N6ARL,BulkQuantity:1,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,
        OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,
        TF_CID_SPAM_ASC
X-UUID: 69f83be4158211ee9cb5633481061a41-20230628
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1125110546; Wed, 28 Jun 2023 15:07:16 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 28 Jun 2023 15:07:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 28 Jun 2023 15:07:15 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH 08/16] wifi: mt76: mt792x: move shared structure definition in mt792x.h
Date:   Wed, 28 Jun 2023 15:05:54 +0800
Message-ID: <173063c1ec7683cf919b7eaa23d686ec2ce5f4c5.1687919628.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1687919628.git.deren.wu@mediatek.com>
References: <cover.1687919628.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

This is a preliminary patch to introduce WiFi7 chipset support

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7921/mt7921.h    | 111 +--------------
 drivers/net/wireless/mediatek/mt76/mt792x.h   | 129 ++++++++++++++++++
 2 files changed, 130 insertions(+), 110 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt792x.h

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index e84c6a56d40e..b04d78a5d51a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -4,9 +4,7 @@
 #ifndef __MT7921_H
 #define __MT7921_H
 
-#include <linux/interrupt.h>
-#include <linux/ktime.h>
-#include "../mt76_connac_mcu.h"
+#include "../mt792x.h"
 #include "regs.h"
 #include "acpi_sar.h"
 
@@ -127,9 +125,6 @@ struct mt7921_sdio_intr {
 #define to_rssi(field, rxv)		((FIELD_GET(field, rxv) - 220) / 2)
 #define to_rcpi(rssi)			(2 * (rssi) + 220)
 
-struct mt792x_vif;
-struct mt792x_sta;
-
 enum mt7921_txq_id {
 	MT7921_TXQ_BAND0,
 	MT7921_TXQ_BAND1,
@@ -143,39 +138,6 @@ enum mt7921_rxq_id {
 	MT7921_RXQ_MCU_WM = 0,
 };
 
-DECLARE_EWMA(avg_signal, 10, 8)
-
-struct mt792x_sta {
-	struct mt76_wcid wcid; /* must be first */
-
-	struct mt792x_vif *vif;
-
-	u32 airtime_ac[8];
-
-	int ack_signal;
-	struct ewma_avg_signal avg_ack_signal;
-
-	unsigned long last_txs;
-
-	struct mt76_connac_sta_key_conf bip;
-};
-
-DECLARE_EWMA(rssi, 10, 8);
-
-struct mt792x_vif {
-	struct mt76_vif mt76; /* must be first */
-
-	struct mt792x_sta sta;
-	struct mt792x_sta *wep_sta;
-
-	struct mt792x_phy *phy;
-
-	struct ewma_rssi rssi;
-
-	struct ieee80211_tx_queue_params queue_params[IEEE80211_NUM_ACS];
-	struct ieee80211_chanctx_conf *ctx;
-};
-
 enum {
 	MT7921_CLC_POWER,
 	MT7921_CLC_CHAN,
@@ -199,40 +161,6 @@ struct mt7921_clc {
 	u8 data[];
 } __packed;
 
-struct mt792x_phy {
-	struct mt76_phy *mt76;
-	struct mt792x_dev *dev;
-
-	struct ieee80211_sband_iftype_data iftype[NUM_NL80211_BANDS][NUM_NL80211_IFTYPES];
-
-	u64 omac_mask;
-
-	u16 noise;
-
-	s16 coverage_class;
-	u8 slottime;
-
-	u32 rx_ampdu_ts;
-	u32 ampdu_ref;
-
-	struct mt76_mib_stats mib;
-
-	u8 sta_work_count;
-
-	struct sk_buff_head scan_event_list;
-	struct delayed_work scan_work;
-#ifdef CONFIG_ACPI
-	void *acpisar;
-#endif
-	void *clc[MT7921_CLC_MAX_NUM];
-
-	struct work_struct roc_work;
-	struct timer_list roc_timer;
-	wait_queue_head_t roc_wait;
-	u8 roc_token_id;
-	bool roc_grant;
-};
-
 enum mt7921_eeprom_field {
 	MT_EE_CHIP_ID =		0x000,
 	MT_EE_VERSION =		0x002,
@@ -249,43 +177,6 @@ enum mt7921_eeprom_field {
 #define mt7921_mcu_init(dev)		((dev)->hif_ops->mcu_init(dev))
 #define __mt7921_mcu_drv_pmctrl(dev)	((dev)->hif_ops->drv_own(dev))
 #define	__mt7921_mcu_fw_pmctrl(dev)	((dev)->hif_ops->fw_own(dev))
-struct mt792x_hif_ops {
-	int (*init_reset)(struct mt792x_dev *dev);
-	int (*reset)(struct mt792x_dev *dev);
-	int (*mcu_init)(struct mt792x_dev *dev);
-	int (*drv_own)(struct mt792x_dev *dev);
-	int (*fw_own)(struct mt792x_dev *dev);
-};
-
-struct mt792x_dev {
-	union { /* must be first */
-		struct mt76_dev mt76;
-		struct mt76_phy mphy;
-	};
-
-	const struct mt76_bus_ops *bus_ops;
-	struct mt792x_phy phy;
-
-	struct work_struct reset_work;
-	bool hw_full_reset:1;
-	bool hw_init_done:1;
-	bool fw_assert:1;
-
-	struct work_struct init_work;
-
-	u8 fw_debug;
-	u8 fw_features;
-
-	struct mt76_connac_pm pm;
-	struct mt76_connac_coredump coredump;
-	const struct mt792x_hif_ops *hif_ops;
-
-	struct work_struct ipv6_ns_work;
-	/* IPv6 addresses for WoWLAN */
-	struct sk_buff_head ipv6_ns_list;
-
-	enum environment_cap country_ie_env;
-};
 
 enum {
 	TXPWR_USER,
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
new file mode 100644
index 000000000000..2c17c2e71af1
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -0,0 +1,129 @@
+/* SPDX-License-Identifier: ISC */
+/* Copyright (C) 2023 MediaTek Inc. */
+
+#ifndef __MT792X_H
+#define __MT792X_H
+
+#include <linux/interrupt.h>
+#include <linux/ktime.h>
+
+#include "mt76_connac_mcu.h"
+
+struct mt792x_vif;
+struct mt792x_sta;
+
+enum {
+	MT792x_CLC_POWER,
+	MT792x_CLC_CHAN,
+	MT792x_CLC_MAX_NUM,
+};
+
+DECLARE_EWMA(avg_signal, 10, 8)
+
+struct mt792x_sta {
+	struct mt76_wcid wcid; /* must be first */
+
+	struct mt792x_vif *vif;
+
+	u32 airtime_ac[8];
+
+	int ack_signal;
+	struct ewma_avg_signal avg_ack_signal;
+
+	unsigned long last_txs;
+
+	struct mt76_connac_sta_key_conf bip;
+};
+
+DECLARE_EWMA(rssi, 10, 8);
+
+struct mt792x_vif {
+	struct mt76_vif mt76; /* must be first */
+
+	struct mt792x_sta sta;
+	struct mt792x_sta *wep_sta;
+
+	struct mt792x_phy *phy;
+
+	struct ewma_rssi rssi;
+
+	struct ieee80211_tx_queue_params queue_params[IEEE80211_NUM_ACS];
+	struct ieee80211_chanctx_conf *ctx;
+};
+
+struct mt792x_phy {
+	struct mt76_phy *mt76;
+	struct mt792x_dev *dev;
+
+	struct ieee80211_sband_iftype_data iftype[NUM_NL80211_BANDS][NUM_NL80211_IFTYPES];
+
+	u64 omac_mask;
+
+	u16 noise;
+
+	s16 coverage_class;
+	u8 slottime;
+
+	u32 rx_ampdu_ts;
+	u32 ampdu_ref;
+
+	struct mt76_mib_stats mib;
+
+	u8 sta_work_count;
+
+	struct sk_buff_head scan_event_list;
+	struct delayed_work scan_work;
+#ifdef CONFIG_ACPI
+	void *acpisar;
+#endif
+	void *clc[MT792x_CLC_MAX_NUM];
+
+	struct work_struct roc_work;
+	struct timer_list roc_timer;
+	wait_queue_head_t roc_wait;
+	u8 roc_token_id;
+	bool roc_grant;
+};
+
+struct mt792x_hif_ops {
+	int (*init_reset)(struct mt792x_dev *dev);
+	int (*reset)(struct mt792x_dev *dev);
+	int (*mcu_init)(struct mt792x_dev *dev);
+	int (*drv_own)(struct mt792x_dev *dev);
+	int (*fw_own)(struct mt792x_dev *dev);
+};
+
+struct mt792x_dev {
+	union { /* must be first */
+		struct mt76_dev mt76;
+		struct mt76_phy mphy;
+	};
+
+	const struct mt76_bus_ops *bus_ops;
+	struct mt792x_phy phy;
+
+	struct work_struct reset_work;
+	bool hw_full_reset:1;
+	bool hw_init_done:1;
+	bool fw_assert:1;
+	bool has_eht:1;
+
+	struct work_struct init_work;
+
+	u8 fw_debug;
+	u8 fw_features;
+
+	struct mt76_connac_pm pm;
+	struct mt76_connac_coredump coredump;
+	const struct mt792x_hif_ops *hif_ops;
+
+	struct work_struct ipv6_ns_work;
+	/* IPv6 addresses for WoWLAN */
+	struct sk_buff_head ipv6_ns_list;
+
+	enum environment_cap country_ie_env;
+	u32 backup_l1;
+	u32 backup_l2;
+};
+
+#endif /* __MT7925_H */
-- 
2.18.0

