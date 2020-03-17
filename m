Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 297E5188AC7
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2020 17:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgCQQmc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Mar 2020 12:42:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbgCQQmc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Mar 2020 12:42:32 -0400
Received: from lore-desk-wlan.redhat.com (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58C5F20663;
        Tue, 17 Mar 2020 16:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584463351;
        bh=ynUZ5Y6q9lgAZbJYesFYCJto2omiLpDktVmChdZM5jU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pJbEJreYdeKzPzlKm7ZgF2nAvl7NE75kARF5RWhvcGn4tbLMvvy8s6vQ7aI2ufVPP
         luvKwViklkqCtXsllq6T2pne4/cAWnLTTXwoGkTL84ikFc5GEIm595Bv2bnaaYScRq
         2/YENc5hX591brNOrqmm85iRHjlSRQrgYbpbgTUQ=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 21/25] mt76: mt7615: introduce set_bmc and st_sta for uni commands
Date:   Tue, 17 Mar 2020 17:41:28 +0100
Message-Id: <887044814c14356c4b56a827e929c474e5b6da3b.1584463004.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1584463004.git.lorenzo@kernel.org>
References: <cover.1584463004.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt7615_mcu_uni_set_bmc and mt7615_mcu_uni_set_sta routines for
mt7663e commands.

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 27 ++++++++++++++++---
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   | 15 ++++++++++-
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 372ffc6322c9..a72b65ebdffc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1062,8 +1062,8 @@ mt7615_mcu_sta_rx_ba(struct mt7615_dev *dev,
 }
 
 static int
-mt7615_mcu_add_sta(struct mt7615_dev *dev, struct ieee80211_vif *vif,
-		   struct ieee80211_sta *sta, bool enable)
+mt7615_mcu_add_sta_cmd(struct mt7615_dev *dev, struct ieee80211_vif *vif,
+		       struct ieee80211_sta *sta, bool enable, int cmd)
 {
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
 	struct wtbl_req_hdr *wtbl_hdr;
@@ -1092,8 +1092,15 @@ mt7615_mcu_add_sta(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 			mt7615_mcu_wtbl_ht_tlv(skb, sta, sta_wtbl, wtbl_hdr);
 	}
 
-	return __mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				       MCU_EXT_CMD_STA_REC_UPDATE, true);
+	return __mt76_mcu_skb_send_msg(&dev->mt76, skb, cmd, true);
+}
+
+static int
+mt7615_mcu_add_sta(struct mt7615_dev *dev, struct ieee80211_vif *vif,
+		   struct ieee80211_sta *sta, bool enable)
+{
+	return mt7615_mcu_add_sta_cmd(dev, vif, sta, enable,
+				      MCU_EXT_CMD_STA_REC_UPDATE);
 }
 
 static const struct mt7615_mcu_ops sta_update_ops = {
@@ -1106,6 +1113,18 @@ static const struct mt7615_mcu_ops sta_update_ops = {
 	.sta_add = mt7615_mcu_add_sta,
 };
 
+static int
+mt7615_mcu_uni_add_sta(struct mt7615_dev *dev, struct ieee80211_vif *vif,
+		       struct ieee80211_sta *sta, bool enable)
+{
+	return mt7615_mcu_add_sta_cmd(dev, vif, sta, enable,
+				      MCU_UNI_CMD_STA_REC_UPDATE);
+}
+
+static const struct mt7615_mcu_ops uni_update_ops = {
+	.sta_add = mt7615_mcu_uni_add_sta,
+};
+
 static int mt7615_mcu_send_firmware(struct mt7615_dev *dev, const void *data,
 				    int len)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index 3aad460e0809..bc87cf0419d8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -269,6 +269,10 @@ enum {
 	MCU_EXT_CMD_SET_RDD_PATTERN = 0x7d,
 };
 
+enum {
+	MCU_UNI_CMD_STA_REC_UPDATE = MCU_UNI_PREFIX | 0x03,
+};
+
 #define MCU_CMD_ACK		BIT(0)
 #define MCU_CMD_UNI		BIT(1)
 #define MCU_CMD_QUERY		BIT(2)
@@ -607,6 +611,15 @@ struct sta_req_hdr {
 	u8 rsv[2];
 } __packed;
 
+struct sta_rec_state {
+	__le16 tag;
+	__le16 len;
+	u8 state;
+	__le32 flags;
+	u8 vhtop;
+	u8 pad[2];
+} __packed;
+
 struct sta_rec_basic {
 	__le16 tag;
 	__le16 len;
@@ -659,7 +672,7 @@ enum {
 	STA_REC_BF,
 	STA_REC_AMSDU, /* for CR4 */
 	STA_REC_BA,
-	STA_REC_RED, /* not used */
+	STA_REC_STATE,
 	STA_REC_TX_PROC, /* for hdr trans and CSO in CR4 */
 	STA_REC_HT,
 	STA_REC_VHT,
-- 
2.25.1

