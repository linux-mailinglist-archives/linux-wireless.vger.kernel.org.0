Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495F8551A2E
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jun 2022 15:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244762AbiFTNFz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Jun 2022 09:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244047AbiFTNEd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Jun 2022 09:04:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A5718B2F
        for <linux-wireless@vger.kernel.org>; Mon, 20 Jun 2022 05:59:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 862EC6153E
        for <linux-wireless@vger.kernel.org>; Mon, 20 Jun 2022 12:59:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F8DC341C6;
        Mon, 20 Jun 2022 12:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655729980;
        bh=0n/cZK/4NWQWgBYDwl/W4yneaiXCdmIMPHypQTwA9NI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KpLtLpR0shilI5n9xGvtnZMXvKil8M2LrmbuToRYO30Fg0c6wNeE7dCQVSCbrrU9O
         +aq0ZYdhFnbEAOxvez6oVQ2CBpNBUarNiLkebWxa+tZhKnw/He3+ClpCrKKg1G378R
         srNj15/XcFPAHTCXhIttndCybgRj4lKjQJf3xDPmz0HMCG6vvflwDDgpmbTuzOo4Z6
         JcfN7XmDhcBSw37psdKdwAvxOVtWQNt7GulzHlexrSanOHO0ZJVSQNgAKHUMdEC3MS
         twwFjTnnMR4uKQ/AdsoaXwHyJCGckwX/HSbyAoTX4u0KJuFeYFDuga3wMjBT9XOKhq
         SS59vkAhgZW1A==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, sean.wang@mediatek.com,
        deren.wu@mediatek.com
Subject: [PATCH 2/2] mt76: move mt76_connac2_mcu_fill_message in mt76_connac module
Date:   Mon, 20 Jun 2022 14:59:18 +0200
Message-Id: <b58fb37a94320874614c4ce310ba6194ed33664e.1655729403.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1655729403.git.lorenzo@kernel.org>
References: <cover.1655729403.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move mt76_connac2_mcu_fill_message routine in shared module in order to
reuse it for mt7921 and mt7915e drivers. This is a preliminary patch to
add mt7990 driver support.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   |  3 -
 .../wireless/mediatek/mt76/mt76_connac2_mac.h | 13 ++++
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 77 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  5 ++
 .../net/wireless/mediatek/mt76/mt7915/mac.h   | 12 ---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 61 ++-------------
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  3 -
 .../net/wireless/mediatek/mt76/mt7921/mac.h   | 13 ----
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 77 -------------------
 .../net/wireless/mediatek/mt76/mt7921/mcu.h   |  3 -
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  2 -
 .../wireless/mediatek/mt76/mt7921/pci_mcu.c   |  9 ++-
 .../wireless/mediatek/mt76/mt7921/sdio_mcu.c  |  9 ++-
 .../net/wireless/mediatek/mt76/mt7921/usb.c   |  9 ++-
 14 files changed, 125 insertions(+), 171 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index 47863ae9f30b..615956acc6b5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -201,9 +201,6 @@ struct mt7615_mcu_rdd_report {
 	} hw_pulse[32];
 };
 
-#define MCU_PQ_ID(p, q)		(((p) << 15) | ((q) << 10))
-#define MCU_PKT_ID		0xa0
-
 enum {
 	MCU_ATE_SET_FREQ_OFFSET = 0xa,
 	MCU_ATE_SET_TX_POWER_CONTROL = 0x15,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
index a72ae9af9b38..67ce216fb564 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
@@ -307,4 +307,17 @@ enum {
 #define MT_CT_INFO_HSR2_TX		BIT(4)
 #define MT_CT_INFO_FROM_HOST		BIT(7)
 
+enum tx_mcu_port_q_idx {
+	MT_TX_MCU_PORT_RX_Q0 = 0x20,
+	MT_TX_MCU_PORT_RX_Q1,
+	MT_TX_MCU_PORT_RX_Q2,
+	MT_TX_MCU_PORT_RX_Q3,
+	MT_TX_MCU_PORT_RX_FWDL = 0x3e
+};
+
+enum tx_port_idx {
+	MT_TX_PORT_IDX_LMAC,
+	MT_TX_PORT_IDX_MCU
+};
+
 #endif /* __MT76_CONNAC2_MAC_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 8580efdc70d2..400b6009ad34 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -2,6 +2,7 @@
 /* Copyright (C) 2020 MediaTek Inc. */
 
 #include <linux/firmware.h>
+#include "mt76_connac2_mac.h"
 #include "mt76_connac_mcu.h"
 
 int mt76_connac_mcu_start_firmware(struct mt76_dev *dev, u32 addr, u32 option)
@@ -3032,5 +3033,81 @@ int mt76_connac2_load_patch(struct mt76_dev *dev, const char *fw_name)
 }
 EXPORT_SYMBOL_GPL(mt76_connac2_load_patch);
 
+int mt76_connac2_mcu_fill_message(struct mt76_dev *dev, struct sk_buff *skb,
+				  int cmd, int *wait_seq)
+{
+	int txd_len, mcu_cmd = FIELD_GET(__MCU_CMD_FIELD_ID, cmd);
+	struct mt76_connac2_mcu_uni_txd *uni_txd;
+	struct mt76_connac2_mcu_txd *mcu_txd;
+	__le32 *txd;
+	u32 val;
+	u8 seq;
+
+	/* TODO: make dynamic based on msg type */
+	dev->mcu.timeout = 20 * HZ;
+
+	seq = ++dev->mcu.msg_seq & 0xf;
+	if (!seq)
+		seq = ++dev->mcu.msg_seq & 0xf;
+
+	if (cmd == MCU_CMD(FW_SCATTER))
+		goto exit;
+
+	txd_len = cmd & __MCU_CMD_FIELD_UNI ? sizeof(*uni_txd) : sizeof(*mcu_txd);
+	txd = (__le32 *)skb_push(skb, txd_len);
+
+	val = FIELD_PREP(MT_TXD0_TX_BYTES, skb->len) |
+	      FIELD_PREP(MT_TXD0_PKT_FMT, MT_TX_TYPE_CMD) |
+	      FIELD_PREP(MT_TXD0_Q_IDX, MT_TX_MCU_PORT_RX_Q0);
+	txd[0] = cpu_to_le32(val);
+
+	val = MT_TXD1_LONG_FORMAT |
+	      FIELD_PREP(MT_TXD1_HDR_FORMAT, MT_HDR_FORMAT_CMD);
+	txd[1] = cpu_to_le32(val);
+
+	if (cmd & __MCU_CMD_FIELD_UNI) {
+		uni_txd = (struct mt76_connac2_mcu_uni_txd *)txd;
+		uni_txd->len = cpu_to_le16(skb->len - sizeof(uni_txd->txd));
+		uni_txd->option = MCU_CMD_UNI_EXT_ACK;
+		uni_txd->cid = cpu_to_le16(mcu_cmd);
+		uni_txd->s2d_index = MCU_S2D_H2N;
+		uni_txd->pkt_type = MCU_PKT_ID;
+		uni_txd->seq = seq;
+
+		goto exit;
+	}
+
+	mcu_txd = (struct mt76_connac2_mcu_txd *)txd;
+	mcu_txd->len = cpu_to_le16(skb->len - sizeof(mcu_txd->txd));
+	mcu_txd->pq_id = cpu_to_le16(MCU_PQ_ID(MT_TX_PORT_IDX_MCU,
+					       MT_TX_MCU_PORT_RX_Q0));
+	mcu_txd->pkt_type = MCU_PKT_ID;
+	mcu_txd->seq = seq;
+	mcu_txd->cid = mcu_cmd;
+	mcu_txd->ext_cid = FIELD_GET(__MCU_CMD_FIELD_EXT_ID, cmd);
+
+	if (mcu_txd->ext_cid || (cmd & __MCU_CMD_FIELD_CE)) {
+		if (cmd & __MCU_CMD_FIELD_QUERY)
+			mcu_txd->set_query = MCU_Q_QUERY;
+		else
+			mcu_txd->set_query = MCU_Q_SET;
+		mcu_txd->ext_cid_ack = !!mcu_txd->ext_cid;
+	} else {
+		mcu_txd->set_query = MCU_Q_NA;
+	}
+
+	if (cmd & __MCU_CMD_FIELD_WA)
+		mcu_txd->s2d_index = MCU_S2D_H2C;
+	else
+		mcu_txd->s2d_index = MCU_S2D_H2N;
+
+exit:
+	if (wait_seq)
+		*wait_seq = seq;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt76_connac2_mcu_fill_message);
+
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 4d29345deae5..f1d7c05bd794 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -33,6 +33,9 @@
 #define PATCH_SEC_ENC_SCRAMBLE_INFO_MASK	GENMASK(15, 0)
 #define PATCH_SEC_ENC_AES_KEY_MASK		GENMASK(7, 0)
 
+#define MCU_PQ_ID(p, q)		(((p) << 15) | ((q) << 10))
+#define MCU_PKT_ID		0xa0
+
 struct mt76_connac2_mcu_txd {
 	__le32 txd[8];
 
@@ -1804,4 +1807,6 @@ int mt76_connac_mcu_rdd_cmd(struct mt76_dev *dev, int cmd, u8 index,
 int mt76_connac2_load_ram(struct mt76_dev *dev, const char *fw_wm,
 			  const char *fw_wa);
 int mt76_connac2_load_patch(struct mt76_dev *dev, const char *fw_name);
+int mt76_connac2_mcu_fill_message(struct mt76_dev *mdev, struct sk_buff *skb,
+				  int cmd, int *wait_seq);
 #endif /* __MT76_CONNAC_MCU_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
index 3876a7457cde..6fa9c79f3e5f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
@@ -29,18 +29,6 @@ enum rx_pkt_type {
 	PKT_TYPE_TXRX_NOTIFY_V0 = 0x18,
 };
 
-enum tx_port_idx {
-	MT_TX_PORT_IDX_LMAC,
-	MT_TX_PORT_IDX_MCU
-};
-
-enum tx_mcu_port_q_idx {
-	MT_TX_MCU_PORT_RX_Q0 = 0x20,
-	MT_TX_MCU_PORT_RX_Q1,
-	MT_TX_MCU_PORT_RX_Q2,
-	MT_TX_MCU_PORT_RX_Q3,
-	MT_TX_MCU_PORT_RX_FWDL = 0x3e
-};
 #define MT_TX_FREE_VER			GENMASK(18, 16)
 #define MT_TX_FREE_MSDU_CNT		GENMASK(9, 0)
 #define MT_TX_FREE_MSDU_CNT_V0	GENMASK(6, 0)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index d5d4b20ec2af..5965b18bb04d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -181,69 +181,20 @@ mt7915_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 			int cmd, int *wait_seq)
 {
 	struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
-	struct mt76_connac2_mcu_txd *mcu_txd;
 	enum mt76_mcuq_id qid;
-	__le32 *txd;
-	u32 val;
-	u8 seq;
-
-	/* TODO: make dynamic based on msg type */
-	mdev->mcu.timeout = 20 * HZ;
+	int ret;
 
-	seq = ++dev->mt76.mcu.msg_seq & 0xf;
-	if (!seq)
-		seq = ++dev->mt76.mcu.msg_seq & 0xf;
+	ret = mt76_connac2_mcu_fill_message(mdev, skb, cmd, wait_seq);
+	if (ret)
+		return ret;
 
-	if (cmd == MCU_CMD(FW_SCATTER)) {
+	if (cmd == MCU_CMD(FW_SCATTER))
 		qid = MT_MCUQ_FWDL;
-		goto exit;
-	}
-
-	mcu_txd = (struct mt76_connac2_mcu_txd *)skb_push(skb, sizeof(*mcu_txd));
-	if (test_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state))
+	else if (test_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state))
 		qid = MT_MCUQ_WA;
 	else
 		qid = MT_MCUQ_WM;
 
-	txd = mcu_txd->txd;
-
-	val = FIELD_PREP(MT_TXD0_TX_BYTES, skb->len) |
-	      FIELD_PREP(MT_TXD0_PKT_FMT, MT_TX_TYPE_CMD) |
-	      FIELD_PREP(MT_TXD0_Q_IDX, MT_TX_MCU_PORT_RX_Q0);
-	txd[0] = cpu_to_le32(val);
-
-	val = MT_TXD1_LONG_FORMAT |
-	      FIELD_PREP(MT_TXD1_HDR_FORMAT, MT_HDR_FORMAT_CMD);
-	txd[1] = cpu_to_le32(val);
-
-	mcu_txd->len = cpu_to_le16(skb->len - sizeof(mcu_txd->txd));
-	mcu_txd->pq_id = cpu_to_le16(MCU_PQ_ID(MT_TX_PORT_IDX_MCU,
-					       MT_TX_MCU_PORT_RX_Q0));
-	mcu_txd->pkt_type = MCU_PKT_ID;
-	mcu_txd->seq = seq;
-
-	mcu_txd->cid = FIELD_GET(__MCU_CMD_FIELD_ID, cmd);
-	mcu_txd->set_query = MCU_Q_NA;
-	mcu_txd->ext_cid = FIELD_GET(__MCU_CMD_FIELD_EXT_ID, cmd);
-	if (mcu_txd->ext_cid) {
-		mcu_txd->ext_cid_ack = 1;
-
-		/* do not use Q_SET for efuse */
-		if (cmd & __MCU_CMD_FIELD_QUERY)
-			mcu_txd->set_query = MCU_Q_QUERY;
-		else
-			mcu_txd->set_query = MCU_Q_SET;
-	}
-
-	if (cmd & __MCU_CMD_FIELD_WA)
-		mcu_txd->s2d_index = MCU_S2D_H2C;
-	else
-		mcu_txd->s2d_index = MCU_S2D_H2N;
-
-exit:
-	if (wait_seq)
-		*wait_seq = seq;
-
 	return mt76_tx_queue_skb_raw(dev, mdev->q_mcu[qid], skb, 0);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index e1919e05de3a..da4ee0ac2618 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -233,9 +233,6 @@ struct mt7915_mcu_muru_stats {
 #define WMM_TXOP_SET		BIT(3)
 #define WMM_PARAM_SET		GENMASK(3, 0)
 
-#define MCU_PQ_ID(p, q)			(((p) << 15) | ((q) << 10))
-#define MCU_PKT_ID			0xa0
-
 enum {
 	MCU_FW_LOG_WM,
 	MCU_FW_LOG_WA,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.h b/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
index b8cabeb796b9..8afec600364f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
@@ -29,19 +29,6 @@ enum rx_pkt_type {
 	PKT_TYPE_NORMAL_MCU,
 };
 
-enum tx_port_idx {
-	MT_TX_PORT_IDX_LMAC,
-	MT_TX_PORT_IDX_MCU
-};
-
-enum tx_mcu_port_q_idx {
-	MT_TX_MCU_PORT_RX_Q0 = 0x20,
-	MT_TX_MCU_PORT_RX_Q1,
-	MT_TX_MCU_PORT_RX_Q2,
-	MT_TX_MCU_PORT_RX_Q3,
-	MT_TX_MCU_PORT_RX_FWDL = 0x3e
-};
-
 #define MT_TX_FREE_MSDU_CNT		GENMASK(9, 0)
 #define MT_TX_FREE_WLAN_ID		GENMASK(23, 14)
 #define MT_TX_FREE_LATENCY		GENMASK(12, 0)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index a323097ec00b..38f940c95328 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -84,83 +84,6 @@ int mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 }
 EXPORT_SYMBOL_GPL(mt7921_mcu_parse_response);
 
-int mt7921_mcu_fill_message(struct mt76_dev *mdev, struct sk_buff *skb,
-			    int cmd, int *wait_seq)
-{
-	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
-	int txd_len, mcu_cmd = FIELD_GET(__MCU_CMD_FIELD_ID, cmd);
-	struct mt76_connac2_mcu_uni_txd *uni_txd;
-	struct mt76_connac2_mcu_txd *mcu_txd;
-	__le32 *txd;
-	u32 val;
-	u8 seq;
-
-	if (cmd == MCU_UNI_CMD(HIF_CTRL) ||
-	    cmd == MCU_UNI_CMD(SUSPEND) ||
-	    cmd == MCU_UNI_CMD(OFFLOAD))
-		mdev->mcu.timeout = HZ;
-	else
-		mdev->mcu.timeout = 3 * HZ;
-
-	seq = ++dev->mt76.mcu.msg_seq & 0xf;
-	if (!seq)
-		seq = ++dev->mt76.mcu.msg_seq & 0xf;
-
-	if (cmd == MCU_CMD(FW_SCATTER))
-		goto exit;
-
-	txd_len = cmd & __MCU_CMD_FIELD_UNI ? sizeof(*uni_txd) : sizeof(*mcu_txd);
-	txd = (__le32 *)skb_push(skb, txd_len);
-
-	val = FIELD_PREP(MT_TXD0_TX_BYTES, skb->len) |
-	      FIELD_PREP(MT_TXD0_PKT_FMT, MT_TX_TYPE_CMD) |
-	      FIELD_PREP(MT_TXD0_Q_IDX, MT_TX_MCU_PORT_RX_Q0);
-	txd[0] = cpu_to_le32(val);
-
-	val = MT_TXD1_LONG_FORMAT |
-	      FIELD_PREP(MT_TXD1_HDR_FORMAT, MT_HDR_FORMAT_CMD);
-	txd[1] = cpu_to_le32(val);
-
-	if (cmd & __MCU_CMD_FIELD_UNI) {
-		uni_txd = (struct mt76_connac2_mcu_uni_txd *)txd;
-		uni_txd->len = cpu_to_le16(skb->len - sizeof(uni_txd->txd));
-		uni_txd->option = MCU_CMD_UNI_EXT_ACK;
-		uni_txd->cid = cpu_to_le16(mcu_cmd);
-		uni_txd->s2d_index = MCU_S2D_H2N;
-		uni_txd->pkt_type = MCU_PKT_ID;
-		uni_txd->seq = seq;
-
-		goto exit;
-	}
-
-	mcu_txd = (struct mt76_connac2_mcu_txd *)txd;
-	mcu_txd->len = cpu_to_le16(skb->len - sizeof(mcu_txd->txd));
-	mcu_txd->pq_id = cpu_to_le16(MCU_PQ_ID(MT_TX_PORT_IDX_MCU,
-					       MT_TX_MCU_PORT_RX_Q0));
-	mcu_txd->pkt_type = MCU_PKT_ID;
-	mcu_txd->seq = seq;
-	mcu_txd->cid = mcu_cmd;
-	mcu_txd->s2d_index = MCU_S2D_H2N;
-	mcu_txd->ext_cid = FIELD_GET(__MCU_CMD_FIELD_EXT_ID, cmd);
-
-	if (mcu_txd->ext_cid || (cmd & __MCU_CMD_FIELD_CE)) {
-		if (cmd & __MCU_CMD_FIELD_QUERY)
-			mcu_txd->set_query = MCU_Q_QUERY;
-		else
-			mcu_txd->set_query = MCU_Q_SET;
-		mcu_txd->ext_cid_ack = !!mcu_txd->ext_cid;
-	} else {
-		mcu_txd->set_query = MCU_Q_NA;
-	}
-
-exit:
-	if (wait_seq)
-		*wait_seq = seq;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(mt7921_mcu_fill_message);
-
 #ifdef CONFIG_PM
 
 static int
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
index a420821357e0..0d20f7d8d474 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
@@ -50,9 +50,6 @@ struct mt7921_mcu_eeprom_info {
 #define MT_RA_RATE_DCM_EN		BIT(4)
 #define MT_RA_RATE_BW			GENMASK(14, 13)
 
-#define MCU_PQ_ID(p, q)			(((p) << 15) | ((q) << 10))
-#define MCU_PKT_ID			0xa0
-
 struct mt7921_mcu_uni_event {
 	u8 cid;
 	u8 pad[3];
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 48fd14c67e44..efeb82cbbe83 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -419,8 +419,6 @@ int mt7921_testmode_dump(struct ieee80211_hw *hw, struct sk_buff *msg,
 			 struct netlink_callback *cb, void *data, int len);
 void mt7921_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi);
 void mt7921_mac_sta_poll(struct mt7921_dev *dev);
-int mt7921_mcu_fill_message(struct mt76_dev *mdev, struct sk_buff *skb,
-			    int cmd, int *wait_seq);
 int mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 			      struct sk_buff *skb, int seq);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
index 07d970ed6f87..5efda694fb9d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
@@ -26,10 +26,17 @@ mt7921_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	enum mt76_mcuq_id txq = MT_MCUQ_WM;
 	int ret;
 
-	ret = mt7921_mcu_fill_message(mdev, skb, cmd, seq);
+	ret = mt76_connac2_mcu_fill_message(mdev, skb, cmd, seq);
 	if (ret)
 		return ret;
 
+	if (cmd == MCU_UNI_CMD(HIF_CTRL) ||
+	    cmd == MCU_UNI_CMD(SUSPEND) ||
+	    cmd == MCU_UNI_CMD(OFFLOAD))
+		mdev->mcu.timeout = HZ;
+	else
+		mdev->mcu.timeout = 3 * HZ;
+
 	if (cmd == MCU_CMD(FW_SCATTER))
 		txq = MT_MCUQ_FWDL;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
index ba4fdff0da56..e038d7404323 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
@@ -29,10 +29,17 @@ mt7921s_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	if (dev->fw_assert)
 		return -EBUSY;
 
-	ret = mt7921_mcu_fill_message(mdev, skb, cmd, seq);
+	ret = mt76_connac2_mcu_fill_message(mdev, skb, cmd, seq);
 	if (ret)
 		return ret;
 
+	if (cmd == MCU_UNI_CMD(HIF_CTRL) ||
+	    cmd == MCU_UNI_CMD(SUSPEND) ||
+	    cmd == MCU_UNI_CMD(OFFLOAD))
+		mdev->mcu.timeout = HZ;
+	else
+		mdev->mcu.timeout = 3 * HZ;
+
 	if (cmd == MCU_CMD(FW_SCATTER))
 		type = MT7921_SDIO_FWDL;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
index 2966b2072d73..dd3b8884e162 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
@@ -102,10 +102,17 @@ mt7921u_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	u32 pad, ep;
 	int ret;
 
-	ret = mt7921_mcu_fill_message(mdev, skb, cmd, seq);
+	ret = mt76_connac2_mcu_fill_message(mdev, skb, cmd, seq);
 	if (ret)
 		return ret;
 
+	if (cmd == MCU_UNI_CMD(HIF_CTRL) ||
+	    cmd == MCU_UNI_CMD(SUSPEND) ||
+	    cmd == MCU_UNI_CMD(OFFLOAD))
+		mdev->mcu.timeout = HZ;
+	else
+		mdev->mcu.timeout = 3 * HZ;
+
 	if (cmd != MCU_CMD(FW_SCATTER))
 		ep = MT_EP_OUT_INBAND_CMD;
 	else
-- 
2.36.1

