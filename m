Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58D97174D5F
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Mar 2020 13:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgCAMrS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Mar 2020 07:47:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:56278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgCAMrS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Mar 2020 07:47:18 -0500
Received: from localhost.localdomain (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5884C21D56;
        Sun,  1 Mar 2020 12:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583066837;
        bh=T4ko8vqh2kbpnUyYe3jtdWlxzQoXiZVqN1jIN+ZN6Ro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mguxzylJLHFVtmDCFcMzyM5GG+5tVo3/oh/kJWjnvuv7zI2wRIn4iNUuc/z/NbtYE
         jm+ESOG/OL3tCUyPP18H4MpXuzi6ifw733ddHy8qBm4OnpLwiQEZXe2tJbjQh6KhJ8
         POLL0FeICTck0kxsZN9ETL/atjUTEtrSWThBjnRI=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 4/4] mt76: mt7615: use proper size for mcu msg in mt7615_mcu_set_bmc
Date:   Sun,  1 Mar 2020 13:46:54 +0100
Message-Id: <4bf083c73040805b0bc750c65e61d7800cf6ab54.1583066508.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1583066508.git.lorenzo@kernel.org>
References: <cover.1583066508.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use proper buffer size for mcu messages in mt7615_mcu_set_bmc routine.
Allocate the mcu buffer relying on kmalloc instead of putting it on the
stack

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 82 ++++++++++---------
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   |  7 ++
 2 files changed, 52 insertions(+), 37 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 27dd0c13e43e..b76f32eaaf22 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1156,63 +1156,67 @@ int mt7615_mcu_set_bmc(struct mt7615_dev *dev,
 		       struct ieee80211_vif *vif, bool en)
 {
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
-	struct {
-		struct sta_req_hdr hdr;
-		struct sta_rec_basic basic;
-		u8 buf[MT7615_WTBL_UPDATE_MAX_SIZE];
-	} __packed req = {
-		.hdr = {
-			.bss_idx = mvif->idx,
-			.wlan_idx = mvif->sta.wcid.idx,
-			.tlv_num = cpu_to_le16(1),
-			.is_tlv_append = 1,
-			.muar_idx = mvif->omac_idx,
-		},
-		.basic = {
-			.tag = cpu_to_le16(STA_REC_BASIC),
-			.len = cpu_to_le16(sizeof(struct sta_rec_basic)),
-			.conn_type = cpu_to_le32(CONNECTION_INFRA_BC),
-		},
-	};
 	struct sta_rec_wtbl *wtbl = NULL;
+	struct sta_rec_basic *sta_basic;
 	struct wtbl_req_hdr *wtbl_hdr;
 	struct wtbl_generic *wtbl_g;
+	struct sta_req_hdr *sta_hdr;
 	struct wtbl_rx *wtbl_rx;
-	u8 *buf = req.buf;
+	int wtbl_len, err;
+	u8 *data, *buf;
 
-	eth_broadcast_addr(req.basic.peer_addr);
+	buf = kzalloc(MT7615_MCU_BMC_BUF_SIZE, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	data = buf;
+	sta_hdr = (struct sta_req_hdr *)data;
+	data += sizeof(*sta_hdr);
+	sta_hdr->bss_idx = mvif->idx;
+	sta_hdr->wlan_idx = mvif->sta.wcid.idx;
+	sta_hdr->tlv_num = cpu_to_le16(1);
+	sta_hdr->is_tlv_append = 1;
+	sta_hdr->muar_idx = mvif->omac_idx;
+
+	sta_basic = (struct sta_rec_basic *)data;
+	data += sizeof(*sta_basic);
+	sta_basic->tag = cpu_to_le16(STA_REC_BASIC);
+	sta_basic->len = cpu_to_le16(sizeof(*sta_basic));
+	sta_basic->conn_type = cpu_to_le32(CONNECTION_INFRA_BC);
+	eth_broadcast_addr(sta_basic->peer_addr);
 
 	if (dev->fw_ver > MT7615_FIRMWARE_V1) {
-		req.hdr.tlv_num = cpu_to_le16(2);
-		wtbl = (struct sta_rec_wtbl *)buf;
+		sta_hdr->tlv_num = cpu_to_le16(2);
+
+		wtbl = (struct sta_rec_wtbl *)data;
+		data += sizeof(*wtbl);
 		wtbl->tag = cpu_to_le16(STA_REC_WTBL);
-		buf += sizeof(*wtbl);
 	}
 
-	wtbl_hdr = (struct wtbl_req_hdr *)buf;
-	buf += sizeof(*wtbl_hdr);
+	wtbl_hdr = (struct wtbl_req_hdr *)data;
+	data += sizeof(*wtbl_hdr);
 	wtbl_hdr->wlan_idx = mvif->sta.wcid.idx;
 	wtbl_hdr->operation = WTBL_RESET_AND_SET;
 
 	if (en) {
-		req.basic.conn_state = CONN_STATE_PORT_SECURE;
-		req.basic.extra_info = cpu_to_le16(EXTRA_INFO_VER |
-						   EXTRA_INFO_NEW);
+		sta_basic->conn_state = CONN_STATE_PORT_SECURE;
+		sta_basic->extra_info = cpu_to_le16(EXTRA_INFO_VER |
+						    EXTRA_INFO_NEW);
 	} else {
-		req.basic.conn_state = CONN_STATE_DISCONNECT;
-		req.basic.extra_info = cpu_to_le16(EXTRA_INFO_VER);
+		sta_basic->conn_state = CONN_STATE_DISCONNECT;
+		sta_basic->extra_info = cpu_to_le16(EXTRA_INFO_VER);
 		goto out;
 	}
 
-	wtbl_g = (struct wtbl_generic *)buf;
-	buf += sizeof(*wtbl_g);
+	wtbl_g = (struct wtbl_generic *)data;
+	data += sizeof(*wtbl_g);
 	wtbl_g->tag = cpu_to_le16(WTBL_GENERIC);
 	wtbl_g->len = cpu_to_le16(sizeof(*wtbl_g));
 	wtbl_g->muar_idx = 0xe;
 	eth_broadcast_addr(wtbl_g->peer_addr);
 
-	wtbl_rx = (struct wtbl_rx *)buf;
-	buf += sizeof(*wtbl_rx);
+	wtbl_rx = (struct wtbl_rx *)data;
+	data += sizeof(*wtbl_rx);
 	wtbl_rx->tag = cpu_to_le16(WTBL_RX);
 	wtbl_rx->len = cpu_to_le16(sizeof(*wtbl_rx));
 	wtbl_rx->rv = 1;
@@ -1222,11 +1226,15 @@ int mt7615_mcu_set_bmc(struct mt7615_dev *dev,
 	wtbl_hdr->tlv_num = cpu_to_le16(2);
 
 out:
+	wtbl_len = data - (u8 *)wtbl_hdr;
 	if (wtbl)
-		wtbl->len = cpu_to_le16(buf - (u8 *)wtbl_hdr);
+		wtbl->len = cpu_to_le16(wtbl_len);
+
+	err = mt7615_mcu_send_sta_rec(dev, buf, (u8 *)wtbl_hdr, wtbl_len, en);
 
-	return mt7615_mcu_send_sta_rec(dev, (u8 *)&req, (u8 *)wtbl_hdr,
-				       buf - (u8 *)wtbl_hdr, en);
+	kfree(buf);
+
+	return err;
 }
 
 int mt7615_mcu_set_sta(struct mt7615_dev *dev, struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index bddfe69de752..4e296784a1ba 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -509,6 +509,13 @@ struct wtbl_raw {
 				 sizeof(struct sta_rec_wtbl) +	\
 				 MT7615_WTBL_UPDATE_MAX_SIZE)
 
+#define MT7615_MCU_BMC_BUF_SIZE	(sizeof(struct sta_req_hdr) +	\
+				 sizeof(struct sta_rec_basic) +	\
+				 sizeof(struct sta_rec_wtbl) +	\
+				 sizeof(struct wtbl_req_hdr) +	\
+				 sizeof(struct wtbl_generic) +	\
+				 sizeof(struct wtbl_rx))
+
 enum {
 	WTBL_GENERIC,
 	WTBL_RX,
-- 
2.24.1

