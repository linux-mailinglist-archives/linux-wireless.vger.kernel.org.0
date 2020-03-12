Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66F501835CB
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2020 17:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgCLQDX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Mar 2020 12:03:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:57370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727228AbgCLQDX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Mar 2020 12:03:23 -0400
Received: from lore-desk-wlan.redhat.com (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11B0D206FA;
        Thu, 12 Mar 2020 16:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584029002;
        bh=wnH8Z5K3jXcgS+/ouPINQWgpnQxQ0iUPUsOtJML/32U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cs1k1CmDuvhbLTPcvGttG1+j6hCN3o9OaEnzVlFWuQynjxNgTc5XCeiGjsRQDYx9H
         4dtKJs0+DngcXEn+E/DVS7DaiQAqs4ZtvCqP5l5DcqJoZeUO89aK99POVWpkhbJhIs
         DheYMJ5TC3Xlg+gJq90p9Y6CM8S701inBwaWNbNE=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, linux-wireless@vger.kernel.org
Subject: [PATCH v3 21/25] mt76: mt7615: introduce set_bmc and st_sta for uni commands
Date:   Thu, 12 Mar 2020 17:02:31 +0100
Message-Id: <ee4629f8592911bec553612b111b96b00e9cf906.1584028319.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1584028319.git.lorenzo@kernel.org>
References: <cover.1584028319.git.lorenzo@kernel.org>
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
index 73c68ce871a6..b0c226cc0528 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1054,8 +1054,8 @@ mt7615_mcu_sta_rx_ba(struct mt7615_dev *dev,
 }
 
 static int
-mt7615_mcu_add_sta(struct mt7615_dev *dev, struct ieee80211_vif *vif,
-		   struct ieee80211_sta *sta, bool enable)
+mt7615_mcu_add_sta_cmd(struct mt7615_dev *dev, struct ieee80211_vif *vif,
+		       struct ieee80211_sta *sta, bool enable, int cmd)
 {
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
 	struct wtbl_req_hdr *wtbl_hdr;
@@ -1084,8 +1084,15 @@ mt7615_mcu_add_sta(struct mt7615_dev *dev, struct ieee80211_vif *vif,
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
@@ -1098,6 +1105,18 @@ static const struct mt7615_mcu_ops sta_update_ops = {
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
index bdbc5d9567cd..d44f54e3eb6c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -218,6 +218,10 @@ enum {
 	MCU_EXT_CMD_SET_RDD_PATTERN = 0x7d,
 };
 
+enum {
+	MCU_UNI_CMD_STA_REC_UPDATE = MCU_UNI_PREFIX | 0x03,
+};
+
 #define MCU_CMD_ACK		BIT(0)
 #define MCU_CMD_UNI		BIT(1)
 #define MCU_CMD_QUERY		BIT(2)
@@ -556,6 +560,15 @@ struct sta_req_hdr {
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
@@ -608,7 +621,7 @@ enum {
 	STA_REC_BF,
 	STA_REC_AMSDU, /* for CR4 */
 	STA_REC_BA,
-	STA_REC_RED, /* not used */
+	STA_REC_STATE,
 	STA_REC_TX_PROC, /* for hdr trans and CSO in CR4 */
 	STA_REC_HT,
 	STA_REC_VHT,
-- 
2.24.1

