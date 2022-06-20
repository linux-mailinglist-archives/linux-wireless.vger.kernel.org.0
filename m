Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3888E551A1C
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jun 2022 15:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244801AbiFTNF5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Jun 2022 09:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244053AbiFTNEd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Jun 2022 09:04:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C245818B1E
        for <linux-wireless@vger.kernel.org>; Mon, 20 Jun 2022 05:59:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4363FB811BD
        for <linux-wireless@vger.kernel.org>; Mon, 20 Jun 2022 12:59:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88702C3411C;
        Mon, 20 Jun 2022 12:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655729977;
        bh=84ZwTWAjF6TuZCSDCLYTYTvy51BQ539mUvuPc4yM+GM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZmW6Hb9O5u9U5NDcnDLI5X3mbOLliW45VgiG65ntAICyWdyqavH5dgrw2c2s6X9Lo
         qNn54FfUAt1SEsWWbIEUbPQvbvbLEfJlMpybuCMRJHNu37liap46N3LeW2mk6+qQmu
         oqCWVDOIpLVApKOLZmjVV6jwrPdd0sHeu1a621/JDRcesSngD9kDyEheMDP4gWVVnt
         amFfYzihSRY3gnV1Na7IH06njUhYm/E83ckys/sJZ72Kaer1h11Dn6jf9rgxJOmvNA
         WtKJrn/C4N+2FpnvLPMEPNU49PhSdogE5NIQjq3SqyRhjVanYI6HLJ4B3o0BjNhtBn
         acG177O9gqhqg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, sean.wang@mediatek.com,
        deren.wu@mediatek.com
Subject: [PATCH 1/2] mt76: move mcu_txd/mcu_rxd structures in shared code
Date:   Mon, 20 Jun 2022 14:59:17 +0200
Message-Id: <38c5dda5ee968dac753ea9e44a138268c113408d.1655729403.git.lorenzo@kernel.org>
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

This is a preliminary patch to add mt7990 chipset support.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  | 85 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 29 ++++---
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   | 42 +--------
 .../net/wireless/mediatek/mt76/mt7921/mac.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  4 +-
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 33 +++----
 .../net/wireless/mediatek/mt76/mt7921/mcu.h   | 85 -------------------
 .../wireless/mediatek/mt76/mt7921/pci_mcu.c   |  2 +-
 .../wireless/mediatek/mt76/mt7921/sdio_mcu.c  |  3 +-
 .../net/wireless/mediatek/mt76/mt7921/usb.c   |  3 +-
 10 files changed, 131 insertions(+), 157 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index d65b3cba1ace..4d29345deae5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -33,6 +33,91 @@
 #define PATCH_SEC_ENC_SCRAMBLE_INFO_MASK	GENMASK(15, 0)
 #define PATCH_SEC_ENC_AES_KEY_MASK		GENMASK(7, 0)
 
+struct mt76_connac2_mcu_txd {
+	__le32 txd[8];
+
+	__le16 len;
+	__le16 pq_id;
+
+	u8 cid;
+	u8 pkt_type;
+	u8 set_query; /* FW don't care */
+	u8 seq;
+
+	u8 uc_d2b0_rev;
+	u8 ext_cid;
+	u8 s2d_index;
+	u8 ext_cid_ack;
+
+	u32 rsv[5];
+} __packed __aligned(4);
+
+/**
+ * struct mt76_connac2_mcu_uni_txd - mcu command descriptor for firmware v3
+ * @txd: hardware descriptor
+ * @len: total length not including txd
+ * @cid: command identifier
+ * @pkt_type: must be 0xa0 (cmd packet by long format)
+ * @frag_n: fragment number
+ * @seq: sequence number
+ * @checksum: 0 mean there is no checksum
+ * @s2d_index: index for command source and destination
+ *  Definition              | value | note
+ *  CMD_S2D_IDX_H2N         | 0x00  | command from HOST to WM
+ *  CMD_S2D_IDX_C2N         | 0x01  | command from WA to WM
+ *  CMD_S2D_IDX_H2C         | 0x02  | command from HOST to WA
+ *  CMD_S2D_IDX_H2N_AND_H2C | 0x03  | command from HOST to WA and WM
+ *
+ * @option: command option
+ *  BIT[0]: UNI_CMD_OPT_BIT_ACK
+ *          set to 1 to request a fw reply
+ *          if UNI_CMD_OPT_BIT_0_ACK is set and UNI_CMD_OPT_BIT_2_SET_QUERY
+ *          is set, mcu firmware will send response event EID = 0x01
+ *          (UNI_EVENT_ID_CMD_RESULT) to the host.
+ *  BIT[1]: UNI_CMD_OPT_BIT_UNI_CMD
+ *          0: original command
+ *          1: unified command
+ *  BIT[2]: UNI_CMD_OPT_BIT_SET_QUERY
+ *          0: QUERY command
+ *          1: SET command
+ */
+struct mt76_connac2_mcu_uni_txd {
+	__le32 txd[8];
+
+	/* DW1 */
+	__le16 len;
+	__le16 cid;
+
+	/* DW2 */
+	u8 rsv;
+	u8 pkt_type;
+	u8 frag_n;
+	u8 seq;
+
+	/* DW3 */
+	__le16 checksum;
+	u8 s2d_index;
+	u8 option;
+
+	/* DW4 */
+	u8 rsv1[4];
+} __packed __aligned(4);
+
+struct mt76_connac2_mcu_rxd {
+	__le32 rxd[6];
+
+	__le16 len;
+	__le16 pkt_type_id;
+
+	u8 eid;
+	u8 seq;
+	u8 rsv[2];
+
+	u8 ext_eid;
+	u8 rsv1[2];
+	u8 s2d_index;
+};
+
 struct mt76_connac2_patch_hdr {
 	char build_date[16];
 	char platform[4];
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 45fd844a4ce2..d5d4b20ec2af 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -150,7 +150,7 @@ static int
 mt7915_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 			  struct sk_buff *skb, int seq)
 {
-	struct mt7915_mcu_rxd *rxd;
+	struct mt76_connac2_mcu_rxd *rxd;
 	int ret = 0;
 
 	if (!skb) {
@@ -159,7 +159,7 @@ mt7915_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 		return -ETIMEDOUT;
 	}
 
-	rxd = (struct mt7915_mcu_rxd *)skb->data;
+	rxd = (struct mt76_connac2_mcu_rxd *)skb->data;
 	if (seq != rxd->seq)
 		return -EAGAIN;
 
@@ -170,7 +170,7 @@ mt7915_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 		skb_pull(skb, sizeof(*rxd) + 4);
 		ret = le32_to_cpu(*(__le32 *)skb->data);
 	} else {
-		skb_pull(skb, sizeof(struct mt7915_mcu_rxd));
+		skb_pull(skb, sizeof(struct mt76_connac2_mcu_rxd));
 	}
 
 	return ret;
@@ -181,7 +181,7 @@ mt7915_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 			int cmd, int *wait_seq)
 {
 	struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
-	struct mt7915_mcu_txd *mcu_txd;
+	struct mt76_connac2_mcu_txd *mcu_txd;
 	enum mt76_mcuq_id qid;
 	__le32 *txd;
 	u32 val;
@@ -199,7 +199,7 @@ mt7915_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 		goto exit;
 	}
 
-	mcu_txd = (struct mt7915_mcu_txd *)skb_push(skb, sizeof(*mcu_txd));
+	mcu_txd = (struct mt76_connac2_mcu_txd *)skb_push(skb, sizeof(*mcu_txd));
 	if (test_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state))
 		qid = MT_MCUQ_WA;
 	else
@@ -326,10 +326,12 @@ mt7915_mcu_rx_radar_detected(struct mt7915_dev *dev, struct sk_buff *skb)
 static void
 mt7915_mcu_rx_log_message(struct mt7915_dev *dev, struct sk_buff *skb)
 {
-	struct mt7915_mcu_rxd *rxd = (struct mt7915_mcu_rxd *)skb->data;
-	const char *data = (char *)&rxd[1];
-	const char *type;
+	struct mt76_connac2_mcu_rxd *rxd;
 	int len = skb->len - sizeof(*rxd);
+	const char *data, *type;
+
+	rxd = (struct mt76_connac2_mcu_rxd *)skb->data;
+	data = (char *)&rxd[1];
 
 	switch (rxd->s2d_index) {
 	case 0:
@@ -377,8 +379,9 @@ mt7915_mcu_rx_bcc_notify(struct mt7915_dev *dev, struct sk_buff *skb)
 static void
 mt7915_mcu_rx_ext_event(struct mt7915_dev *dev, struct sk_buff *skb)
 {
-	struct mt7915_mcu_rxd *rxd = (struct mt7915_mcu_rxd *)skb->data;
+	struct mt76_connac2_mcu_rxd *rxd;
 
+	rxd = (struct mt76_connac2_mcu_rxd *)skb->data;
 	switch (rxd->ext_eid) {
 	case MCU_EXT_EVENT_THERMAL_PROTECT:
 		mt7915_mcu_rx_thermal_notify(dev, skb);
@@ -403,8 +406,9 @@ mt7915_mcu_rx_ext_event(struct mt7915_dev *dev, struct sk_buff *skb)
 static void
 mt7915_mcu_rx_unsolicited_event(struct mt7915_dev *dev, struct sk_buff *skb)
 {
-	struct mt7915_mcu_rxd *rxd = (struct mt7915_mcu_rxd *)skb->data;
+	struct mt76_connac2_mcu_rxd *rxd;
 
+	rxd = (struct mt76_connac2_mcu_rxd *)skb->data;
 	switch (rxd->eid) {
 	case MCU_EVENT_EXT:
 		mt7915_mcu_rx_ext_event(dev, skb);
@@ -417,8 +421,9 @@ mt7915_mcu_rx_unsolicited_event(struct mt7915_dev *dev, struct sk_buff *skb)
 
 void mt7915_mcu_rx_event(struct mt7915_dev *dev, struct sk_buff *skb)
 {
-	struct mt7915_mcu_rxd *rxd = (struct mt7915_mcu_rxd *)skb->data;
+	struct mt76_connac2_mcu_rxd *rxd;
 
+	rxd = (struct mt76_connac2_mcu_rxd *)skb->data;
 	if (rxd->ext_eid == MCU_EXT_EVENT_THERMAL_PROTECT ||
 	    rxd->ext_eid == MCU_EXT_EVENT_FW_LOG_2_HOST ||
 	    rxd->ext_eid == MCU_EXT_EVENT_ASSERT_DUMP ||
@@ -2275,7 +2280,7 @@ mt7915_mcu_init_rx_airtime(struct mt7915_dev *dev)
 int mt7915_mcu_init(struct mt7915_dev *dev)
 {
 	static const struct mt76_mcu_ops mt7915_mcu_ops = {
-		.headroom = sizeof(struct mt7915_mcu_txd),
+		.headroom = sizeof(struct mt76_connac2_mcu_txd),
 		.mcu_skb_send_msg = mt7915_mcu_send_message,
 		.mcu_parse_response = mt7915_mcu_parse_response,
 		.mcu_restart = mt76_connac_mcu_restart,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index 5abde482a97f..e1919e05de3a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -6,25 +6,6 @@
 
 #include "../mt76_connac_mcu.h"
 
-struct mt7915_mcu_txd {
-	__le32 txd[8];
-
-	__le16 len;
-	__le16 pq_id;
-
-	u8 cid;
-	u8 pkt_type;
-	u8 set_query; /* FW don't care */
-	u8 seq;
-
-	u8 uc_d2b0_rev;
-	u8 ext_cid;
-	u8 s2d_index;
-	u8 ext_cid_ack;
-
-	u32 reserved[5];
-} __packed __aligned(4);
-
 enum {
 	MCU_ATE_SET_TRX = 0x1,
 	MCU_ATE_SET_FREQ_OFFSET = 0xa,
@@ -32,21 +13,6 @@ enum {
 	MCU_ATE_CLEAN_TXQUEUE = 0x1c,
 };
 
-struct mt7915_mcu_rxd {
-	__le32 rxd[6];
-
-	__le16 len;
-	__le16 pkt_type_id;
-
-	u8 eid;
-	u8 seq;
-	__le16 __rsv;
-
-	u8 ext_eid;
-	u8 __rsv1[2];
-	u8 s2d_index;
-};
-
 struct mt7915_mcu_thermal_ctrl {
 	u8 ctrl_id;
 	u8 band_idx;
@@ -63,7 +29,7 @@ struct mt7915_mcu_thermal_ctrl {
 } __packed;
 
 struct mt7915_mcu_thermal_notify {
-	struct mt7915_mcu_rxd rxd;
+	struct mt76_connac2_mcu_rxd rxd;
 
 	struct mt7915_mcu_thermal_ctrl ctrl;
 	__le32 temperature;
@@ -71,7 +37,7 @@ struct mt7915_mcu_thermal_notify {
 } __packed;
 
 struct mt7915_mcu_csa_notify {
-	struct mt7915_mcu_rxd rxd;
+	struct mt76_connac2_mcu_rxd rxd;
 
 	u8 omac_idx;
 	u8 csa_count;
@@ -80,7 +46,7 @@ struct mt7915_mcu_csa_notify {
 } __packed;
 
 struct mt7915_mcu_bcc_notify {
-	struct mt7915_mcu_rxd rxd;
+	struct mt76_connac2_mcu_rxd rxd;
 
 	u8 band_idx;
 	u8 omac_idx;
@@ -89,7 +55,7 @@ struct mt7915_mcu_bcc_notify {
 } __packed;
 
 struct mt7915_mcu_rdd_report {
-	struct mt7915_mcu_rxd rxd;
+	struct mt76_connac2_mcu_rxd rxd;
 
 	u8 band_idx;
 	u8 long_detected;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index b8fe61355cce..eb1bfb682e02 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -970,7 +970,7 @@ void mt7921_coredump_work(struct work_struct *work)
 		if (!skb)
 			break;
 
-		skb_pull(skb, sizeof(struct mt7921_mcu_rxd));
+		skb_pull(skb, sizeof(struct mt76_connac2_mcu_rxd));
 		if (!dump || data + skb->len - dump > MT76_CONNAC_COREDUMP_SZ) {
 			dev_kfree_skb(skb);
 			continue;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 0d319f6f89b1..0968b47ec4a1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1168,7 +1168,7 @@ void mt7921_scan_work(struct work_struct *work)
 						scan_work.work);
 
 	while (true) {
-		struct mt7921_mcu_rxd *rxd;
+		struct mt76_connac2_mcu_rxd *rxd;
 		struct sk_buff *skb;
 
 		spin_lock_bh(&phy->dev->mt76.lock);
@@ -1178,7 +1178,7 @@ void mt7921_scan_work(struct work_struct *work)
 		if (!skb)
 			break;
 
-		rxd = (struct mt7921_mcu_rxd *)skb->data;
+		rxd = (struct mt76_connac2_mcu_rxd *)skb->data;
 		if (rxd->eid == MCU_EVENT_SCHED_SCAN_DONE) {
 			ieee80211_sched_scan_results(phy->mt76->hw);
 		} else if (test_and_clear_bit(MT76_HW_SCANNING,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index fbc27f4dab7b..a323097ec00b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -19,7 +19,7 @@ mt7921_mcu_parse_eeprom(struct mt76_dev *dev, struct sk_buff *skb)
 	if (!skb)
 		return -EINVAL;
 
-	skb_pull(skb, sizeof(struct mt7921_mcu_rxd));
+	skb_pull(skb, sizeof(struct mt76_connac2_mcu_rxd));
 
 	res = (struct mt7921_mcu_eeprom_info *)skb->data;
 	buf = dev->eeprom.data + le32_to_cpu(res->addr);
@@ -32,7 +32,7 @@ int mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 			      struct sk_buff *skb, int seq)
 {
 	int mcu_cmd = FIELD_GET(__MCU_CMD_FIELD_ID, cmd);
-	struct mt7921_mcu_rxd *rxd;
+	struct mt76_connac2_mcu_rxd *rxd;
 	int ret = 0;
 
 	if (!skb) {
@@ -43,7 +43,7 @@ int mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 		return -ETIMEDOUT;
 	}
 
-	rxd = (struct mt7921_mcu_rxd *)skb->data;
+	rxd = (struct mt76_connac2_mcu_rxd *)skb->data;
 	if (seq != rxd->seq)
 		return -EAGAIN;
 
@@ -77,7 +77,7 @@ int mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 		event = (struct mt7921_mcu_reg_event *)skb->data;
 		ret = (int)le32_to_cpu(event->val);
 	} else {
-		skb_pull(skb, sizeof(struct mt7921_mcu_rxd));
+		skb_pull(skb, sizeof(struct mt76_connac2_mcu_rxd));
 	}
 
 	return ret;
@@ -89,8 +89,8 @@ int mt7921_mcu_fill_message(struct mt76_dev *mdev, struct sk_buff *skb,
 {
 	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
 	int txd_len, mcu_cmd = FIELD_GET(__MCU_CMD_FIELD_ID, cmd);
-	struct mt7921_uni_txd *uni_txd;
-	struct mt7921_mcu_txd *mcu_txd;
+	struct mt76_connac2_mcu_uni_txd *uni_txd;
+	struct mt76_connac2_mcu_txd *mcu_txd;
 	__le32 *txd;
 	u32 val;
 	u8 seq;
@@ -122,7 +122,7 @@ int mt7921_mcu_fill_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	txd[1] = cpu_to_le32(val);
 
 	if (cmd & __MCU_CMD_FIELD_UNI) {
-		uni_txd = (struct mt7921_uni_txd *)txd;
+		uni_txd = (struct mt76_connac2_mcu_uni_txd *)txd;
 		uni_txd->len = cpu_to_le16(skb->len - sizeof(uni_txd->txd));
 		uni_txd->option = MCU_CMD_UNI_EXT_ACK;
 		uni_txd->cid = cpu_to_le16(mcu_cmd);
@@ -133,7 +133,7 @@ int mt7921_mcu_fill_message(struct mt76_dev *mdev, struct sk_buff *skb,
 		goto exit;
 	}
 
-	mcu_txd = (struct mt7921_mcu_txd *)txd;
+	mcu_txd = (struct mt76_connac2_mcu_txd *)txd;
 	mcu_txd->len = cpu_to_le16(skb->len - sizeof(mcu_txd->txd));
 	mcu_txd->pq_id = cpu_to_le16(MCU_PQ_ID(MT_TX_PORT_IDX_MCU,
 					       MT_TX_MCU_PORT_RX_Q0));
@@ -241,7 +241,7 @@ mt7921_mcu_connection_loss_event(struct mt7921_dev *dev, struct sk_buff *skb)
 	struct mt76_connac_beacon_loss_event *event;
 	struct mt76_phy *mphy = &dev->mt76.phy;
 
-	skb_pull(skb, sizeof(struct mt7921_mcu_rxd));
+	skb_pull(skb, sizeof(struct mt76_connac2_mcu_rxd));
 	event = (struct mt76_connac_beacon_loss_event *)skb->data;
 
 	ieee80211_iterate_active_interfaces_atomic(mphy->hw,
@@ -255,7 +255,7 @@ mt7921_mcu_bss_event(struct mt7921_dev *dev, struct sk_buff *skb)
 	struct mt76_phy *mphy = &dev->mt76.phy;
 	struct mt76_connac_mcu_bss_event *event;
 
-	skb_pull(skb, sizeof(struct mt7921_mcu_rxd));
+	skb_pull(skb, sizeof(struct mt76_connac2_mcu_rxd));
 	event = (struct mt76_connac_mcu_bss_event *)skb->data;
 	if (event->is_absent)
 		ieee80211_stop_queues(mphy->hw);
@@ -275,7 +275,7 @@ mt7921_mcu_debug_msg_event(struct mt7921_dev *dev, struct sk_buff *skb)
 		u8 content[512];
 	} __packed * msg;
 
-	skb_pull(skb, sizeof(struct mt7921_mcu_rxd));
+	skb_pull(skb, sizeof(struct mt76_connac2_mcu_rxd));
 	msg = (struct mt7921_debug_msg *)skb->data;
 
 	if (msg->type == 3) { /* fw log */
@@ -298,7 +298,7 @@ mt7921_mcu_low_power_event(struct mt7921_dev *dev, struct sk_buff *skb)
 		u8 reserved[3];
 	} __packed * event;
 
-	skb_pull(skb, sizeof(struct mt7921_mcu_rxd));
+	skb_pull(skb, sizeof(struct mt76_connac2_mcu_rxd));
 	event = (struct mt7921_mcu_lp_event *)skb->data;
 
 	trace_lp_event(dev, event->state);
@@ -309,7 +309,7 @@ mt7921_mcu_tx_done_event(struct mt7921_dev *dev, struct sk_buff *skb)
 {
 	struct mt7921_mcu_tx_done_event *event;
 
-	skb_pull(skb, sizeof(struct mt7921_mcu_rxd));
+	skb_pull(skb, sizeof(struct mt76_connac2_mcu_rxd));
 	event = (struct mt7921_mcu_tx_done_event *)skb->data;
 
 	mt7921_mac_add_txs(dev, event->txs);
@@ -318,8 +318,9 @@ mt7921_mcu_tx_done_event(struct mt7921_dev *dev, struct sk_buff *skb)
 static void
 mt7921_mcu_rx_unsolicited_event(struct mt7921_dev *dev, struct sk_buff *skb)
 {
-	struct mt7921_mcu_rxd *rxd = (struct mt7921_mcu_rxd *)skb->data;
+	struct mt76_connac2_mcu_rxd *rxd;
 
+	rxd = (struct mt76_connac2_mcu_rxd *)skb->data;
 	switch (rxd->eid) {
 	case MCU_EVENT_BSS_BEACON_LOSS:
 		mt7921_mcu_connection_loss_event(dev, skb);
@@ -353,12 +354,12 @@ mt7921_mcu_rx_unsolicited_event(struct mt7921_dev *dev, struct sk_buff *skb)
 
 void mt7921_mcu_rx_event(struct mt7921_dev *dev, struct sk_buff *skb)
 {
-	struct mt7921_mcu_rxd *rxd;
+	struct mt76_connac2_mcu_rxd *rxd;
 
 	if (skb_linearize(skb))
 		return;
 
-	rxd = (struct mt7921_mcu_rxd *)skb->data;
+	rxd = (struct mt76_connac2_mcu_rxd *)skb->data;
 
 	if (rxd->eid == 0x6) {
 		mt76_mcu_rx_event(&dev->mt76, skb);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
index 77cc0cc5b436..a420821357e0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
@@ -6,76 +6,6 @@
 
 #include "../mt76_connac_mcu.h"
 
-struct mt7921_mcu_txd {
-	__le32 txd[8];
-
-	__le16 len;
-	__le16 pq_id;
-
-	u8 cid;
-	u8 pkt_type;
-	u8 set_query; /* FW don't care */
-	u8 seq;
-
-	u8 uc_d2b0_rev;
-	u8 ext_cid;
-	u8 s2d_index;
-	u8 ext_cid_ack;
-
-	u32 reserved[5];
-} __packed __aligned(4);
-
-/**
- * struct mt7921_uni_txd - mcu command descriptor for firmware v3
- * @txd: hardware descriptor
- * @len: total length not including txd
- * @cid: command identifier
- * @pkt_type: must be 0xa0 (cmd packet by long format)
- * @frag_n: fragment number
- * @seq: sequence number
- * @checksum: 0 mean there is no checksum
- * @s2d_index: index for command source and destination
- *  Definition              | value | note
- *  CMD_S2D_IDX_H2N         | 0x00  | command from HOST to WM
- *  CMD_S2D_IDX_C2N         | 0x01  | command from WA to WM
- *  CMD_S2D_IDX_H2C         | 0x02  | command from HOST to WA
- *  CMD_S2D_IDX_H2N_AND_H2C | 0x03  | command from HOST to WA and WM
- *
- * @option: command option
- *  BIT[0]: UNI_CMD_OPT_BIT_ACK
- *          set to 1 to request a fw reply
- *          if UNI_CMD_OPT_BIT_0_ACK is set and UNI_CMD_OPT_BIT_2_SET_QUERY
- *          is set, mcu firmware will send response event EID = 0x01
- *          (UNI_EVENT_ID_CMD_RESULT) to the host.
- *  BIT[1]: UNI_CMD_OPT_BIT_UNI_CMD
- *          0: original command
- *          1: unified command
- *  BIT[2]: UNI_CMD_OPT_BIT_SET_QUERY
- *          0: QUERY command
- *          1: SET command
- */
-struct mt7921_uni_txd {
-	__le32 txd[8];
-
-	/* DW1 */
-	__le16 len;
-	__le16 cid;
-
-	/* DW2 */
-	u8 reserved;
-	u8 pkt_type;
-	u8 frag_n;
-	u8 seq;
-
-	/* DW3 */
-	__le16 checksum;
-	u8 s2d_index;
-	u8 option;
-
-	/* DW4 */
-	u8 reserved2[4];
-} __packed __aligned(4);
-
 struct mt7921_mcu_tx_done_event {
 	u8 pid;
 	u8 status;
@@ -108,21 +38,6 @@ enum {
 	MCU_EXT_EVENT_RATE_REPORT = 0x87,
 };
 
-struct mt7921_mcu_rxd {
-	__le32 rxd[6];
-
-	__le16 len;
-	__le16 pkt_type_id;
-
-	u8 eid;
-	u8 seq;
-	__le16 __rsv;
-
-	u8 ext_eid;
-	u8 __rsv1[2];
-	u8 s2d_index;
-};
-
 struct mt7921_mcu_eeprom_info {
 	__le32 addr;
 	__le32 valid;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
index a1ab5f878f81..07d970ed6f87 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
@@ -39,7 +39,7 @@ mt7921_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 int mt7921e_mcu_init(struct mt7921_dev *dev)
 {
 	static const struct mt76_mcu_ops mt7921_mcu_ops = {
-		.headroom = sizeof(struct mt7921_mcu_txd),
+		.headroom = sizeof(struct mt76_connac2_mcu_txd),
 		.mcu_skb_send_msg = mt7921_mcu_send_message,
 		.mcu_parse_response = mt7921_mcu_parse_response,
 		.mcu_restart = mt76_connac_mcu_restart,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
index efcbe06964db..ba4fdff0da56 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
@@ -72,7 +72,8 @@ static u32 mt7921s_clear_rm3r_drv_own(struct mt7921_dev *dev)
 int mt7921s_mcu_init(struct mt7921_dev *dev)
 {
 	static const struct mt76_mcu_ops mt7921s_mcu_ops = {
-		.headroom = MT_SDIO_HDR_SIZE + sizeof(struct mt7921_mcu_txd),
+		.headroom = MT_SDIO_HDR_SIZE +
+			    sizeof(struct mt76_connac2_mcu_txd),
 		.tailroom = MT_SDIO_TAIL_SIZE,
 		.mcu_skb_send_msg = mt7921s_mcu_send_message,
 		.mcu_parse_response = mt7921_mcu_parse_response,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
index 4e4cd2dc2aeb..2966b2072d73 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
@@ -125,7 +125,8 @@ mt7921u_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 static int mt7921u_mcu_init(struct mt7921_dev *dev)
 {
 	static const struct mt76_mcu_ops mcu_ops = {
-		.headroom = MT_SDIO_HDR_SIZE + sizeof(struct mt7921_mcu_txd),
+		.headroom = MT_SDIO_HDR_SIZE +
+			    sizeof(struct mt76_connac2_mcu_txd),
 		.tailroom = MT_USB_TAIL_SIZE,
 		.mcu_skb_send_msg = mt7921u_mcu_send_message,
 		.mcu_parse_response = mt7921_mcu_parse_response,
-- 
2.36.1

