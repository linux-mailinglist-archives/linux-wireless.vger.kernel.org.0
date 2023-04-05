Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3B76D79E8
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Apr 2023 12:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237609AbjDEKjG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Apr 2023 06:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237684AbjDEKjF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Apr 2023 06:39:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDDA49F9
        for <linux-wireless@vger.kernel.org>; Wed,  5 Apr 2023 03:39:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA2316276C
        for <linux-wireless@vger.kernel.org>; Wed,  5 Apr 2023 10:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E350C433D2;
        Wed,  5 Apr 2023 10:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680691141;
        bh=bztIMOkVq04corbOYYxbneaufcCsb8VNc2lnWSNjf80=;
        h=From:To:Cc:Subject:Date:From;
        b=u/hC/JCKpvKwtOEQ9Xa7rk/5WpkWgTV7rK6mV4jqx/SGpH29ZZ09bqumfXVrhNevi
         QB15mHd4HATPoQ43l8zvoEkFr6VjI0RW9wYJyWBVYrMd1wFIBN6lCSBYrbmBfFITY5
         7O9s2NnN8qnZ+OWyUF7h7UI6V2vq4tKTfEhXN+YHCQuqzdu0cvw65kcYYcq2KPw7uZ
         ZpWJQdHj/0P4EUl+Oyccu0+DKa4ZGgjTZdGvRFWKwNE2GdV29WmjMskpEC7lpY/n7l
         1IMgXjiJsazoKFybdPSp4AAaXw267f6fZIdM/k8WsOYW1qxDilhey0itr+o65SPvwv
         +mRCLBMWWcZSA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] wifi: mt76: move mcu_uni_event and mcu_reg_event in common code
Date:   Wed,  5 Apr 2023 12:38:53 +0200
Message-Id: <df766131bce672469642823e23699bca5b8dfa6c.1680691008.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mcu_uni_event and mcu_reg_event structs are shared between mt7921 and
mt7615 drivers, so move them in connac lib.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c      |  8 ++++----
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.h      | 11 -----------
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h | 11 +++++++++++
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c      |  8 ++++----
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.h      | 11 -----------
 5 files changed, 19 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index eea398c79a98..5d324feaab49 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -163,16 +163,16 @@ int mt7615_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 		   cmd == MCU_UNI_CMD(HIF_CTRL) ||
 		   cmd == MCU_UNI_CMD(OFFLOAD) ||
 		   cmd == MCU_UNI_CMD(SUSPEND)) {
-		struct mt7615_mcu_uni_event *event;
+		struct mt76_connac_mcu_uni_event *event;
 
 		skb_pull(skb, sizeof(*rxd));
-		event = (struct mt7615_mcu_uni_event *)skb->data;
+		event = (struct mt76_connac_mcu_uni_event *)skb->data;
 		ret = le32_to_cpu(event->status);
 	} else if (cmd == MCU_CE_QUERY(REG_READ)) {
-		struct mt7615_mcu_reg_event *event;
+		struct mt76_connac_mcu_reg_event *event;
 
 		skb_pull(skb, sizeof(*rxd));
-		event = (struct mt7615_mcu_reg_event *)skb->data;
+		event = (struct mt76_connac_mcu_reg_event *)skb->data;
 		ret = (int)le32_to_cpu(event->val);
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index 615956acc6b5..8e9604be0792 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -206,17 +206,6 @@ enum {
 	MCU_ATE_SET_TX_POWER_CONTROL = 0x15,
 };
 
-struct mt7615_mcu_uni_event {
-	u8 cid;
-	u8 pad[3];
-	__le32 status; /* 0: success, others: fail */
-} __packed;
-
-struct mt7615_mcu_reg_event {
-	__le32 reg;
-	__le32 val;
-} __packed;
-
 struct mt7615_roc_tlv {
 	u8 bss_idx;
 	u8 token;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 40a99e0caded..1547623ba6ea 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1689,6 +1689,17 @@ struct mt76_connac_config {
 	u8 data[320];
 } __packed;
 
+struct mt76_connac_mcu_uni_event {
+	u8 cid;
+	u8 pad[3];
+	__le32 status; /* 0: success, others: fail */
+} __packed;
+
+struct mt76_connac_mcu_reg_event {
+	__le32 reg;
+	__le32 val;
+} __packed;
+
 static inline enum mcu_cipher_type
 mt76_connac_mcu_get_cipher(int cipher)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 04925e66f15b..259b6ea88be4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -67,19 +67,19 @@ int mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 		   cmd == MCU_UNI_CMD(HIF_CTRL) ||
 		   cmd == MCU_UNI_CMD(OFFLOAD) ||
 		   cmd == MCU_UNI_CMD(SUSPEND)) {
-		struct mt7921_mcu_uni_event *event;
+		struct mt76_connac_mcu_uni_event *event;
 
 		skb_pull(skb, sizeof(*rxd));
-		event = (struct mt7921_mcu_uni_event *)skb->data;
+		event = (struct mt76_connac_mcu_uni_event *)skb->data;
 		ret = le32_to_cpu(event->status);
 		/* skip invalid event */
 		if (mcu_cmd != event->cid)
 			ret = -EAGAIN;
 	} else if (cmd == MCU_CE_QUERY(REG_READ)) {
-		struct mt7921_mcu_reg_event *event;
+		struct mt76_connac_mcu_reg_event *event;
 
 		skb_pull(skb, sizeof(*rxd));
-		event = (struct mt7921_mcu_reg_event *)skb->data;
+		event = (struct mt76_connac_mcu_reg_event *)skb->data;
 		ret = (int)le32_to_cpu(event->val);
 	} else {
 		skb_pull(skb, sizeof(struct mt76_connac2_mcu_rxd));
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
index 96dc870fd35e..9b0aa3b70f0e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
@@ -50,22 +50,11 @@ struct mt7921_mcu_eeprom_info {
 #define MT_RA_RATE_DCM_EN		BIT(4)
 #define MT_RA_RATE_BW			GENMASK(14, 13)
 
-struct mt7921_mcu_uni_event {
-	u8 cid;
-	u8 pad[3];
-	__le32 status; /* 0: success, others: fail */
-} __packed;
-
 enum {
 	MT_EBF = BIT(0),	/* explicit beamforming */
 	MT_IBF = BIT(1)		/* implicit beamforming */
 };
 
-struct mt7921_mcu_reg_event {
-	__le32 reg;
-	__le32 val;
-} __packed;
-
 struct mt7921_mcu_ant_id_config {
 	u8 ant_id[4];
 } __packed;
-- 
2.39.2

