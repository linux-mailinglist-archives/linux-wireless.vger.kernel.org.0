Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 220EC174D5D
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Mar 2020 13:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgCAMrO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Mar 2020 07:47:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:56186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgCAMrO (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Mar 2020 07:47:14 -0500
Received: from localhost.localdomain (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DB3B2087F;
        Sun,  1 Mar 2020 12:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583066833;
        bh=dZcIbFqjKC6WXT3+tjE2HS0e90KY8tWoLhLIwIeLogQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HSQi6kAdMnVL5AViuSHZHNoENJq9dm0+6S1Ndv7Luf7APBfit3QxgI9mwcxBa+S3X
         +cQ040mdMvOXfW4G3gj2cGjEp2zNEe8vBG+H1Mi3zcrPdsjKJCYLZUMhrZRu+EjvIZ
         d9cjBmC3m7yLscdDMLaf8gUrffrNs49XIzAsNFkA=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 2/4] mt76: mt7615: use proper size for mcu msg in mt7615_mcu_set_rx_ba
Date:   Sun,  1 Mar 2020 13:46:52 +0100
Message-Id: <20adf9e814c3230a1df386ddaf793d0579e9d8e5.1583066508.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1583066508.git.lorenzo@kernel.org>
References: <cover.1583066508.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use proper buffer size for mcu messages in mt7615_mcu_set_rx_ba routine.
Allocate the mcu buffer relying on kmalloc instead of putting it on the
stack

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 77 +++++++++++--------
 1 file changed, 43 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index fd01c24c48e2..70bf84b31772 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1779,49 +1779,54 @@ int mt7615_mcu_set_rx_ba(struct mt7615_dev *dev,
 {
 	struct mt7615_sta *msta = (struct mt7615_sta *)params->sta->drv_priv;
 	struct mt7615_vif *mvif = msta->vif;
-	struct {
-		struct sta_req_hdr hdr;
-		struct sta_rec_ba ba;
-		u8 buf[MT7615_WTBL_UPDATE_MAX_SIZE];
-	} __packed req = {
-		.hdr = {
-			.bss_idx = mvif->idx,
-			.wlan_idx = msta->wcid.idx,
-			.tlv_num = cpu_to_le16(1),
-			.is_tlv_append = 1,
-			.muar_idx = mvif->omac_idx,
-		},
-		.ba = {
-			.tag = cpu_to_le16(STA_REC_BA),
-			.len = cpu_to_le16(sizeof(struct sta_rec_ba)),
-			.tid = params->tid,
-			.ba_type = MT_BA_TYPE_RECIPIENT,
-			.amsdu = params->amsdu,
-			.ba_en = add << params->tid,
-			.ssn = cpu_to_le16(params->ssn),
-			.winsize = cpu_to_le16(params->buf_size),
-		},
-	};
 	struct sta_rec_wtbl *wtbl = NULL;
 	struct wtbl_req_hdr *wtbl_hdr;
+	struct sta_req_hdr *sta_hdr;
+	struct sta_rec_ba *sta_ba;
 	struct wtbl_ba *wtbl_ba;
-	u8 *buf = req.buf;
+	int wtbl_len, err;
+	u8 *data, *buf;
+
+	buf = kzalloc(MT7615_MCU_BA_BUF_SIZE, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	data = buf;
+	sta_hdr = (struct sta_req_hdr *)data;
+	data += sizeof(*sta_hdr);
+	sta_hdr->bss_idx = mvif->idx;
+	sta_hdr->wlan_idx = msta->wcid.idx;
+	sta_hdr->tlv_num = cpu_to_le16(1);
+	sta_hdr->is_tlv_append = 1;
+	sta_hdr->muar_idx = mvif->omac_idx;
+
+	sta_ba = (struct sta_rec_ba *)data;
+	data += sizeof(*sta_ba);
+	sta_ba->tag = cpu_to_le16(STA_REC_BA);
+	sta_ba->len = cpu_to_le16(sizeof(*sta_ba));
+	sta_ba->tid = params->tid;
+	sta_ba->ba_type = MT_BA_TYPE_RECIPIENT;
+	sta_ba->amsdu = params->amsdu;
+	sta_ba->ba_en = add << params->tid;
+	sta_ba->ssn = cpu_to_le16(params->ssn);
+	sta_ba->winsize = cpu_to_le16(params->buf_size);
 
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
 	wtbl_hdr->wlan_idx = msta->wcid.idx;
 	wtbl_hdr->operation = WTBL_SET;
 	wtbl_hdr->tlv_num = cpu_to_le16(1);
 
-	wtbl_ba = (struct wtbl_ba *)buf;
-	buf += sizeof(*wtbl_ba);
+	wtbl_ba = (struct wtbl_ba *)data;
+	data += sizeof(*wtbl_ba);
 	wtbl_ba->tag = cpu_to_le16(WTBL_BA);
 	wtbl_ba->len = cpu_to_le16(sizeof(*wtbl_ba));
 	wtbl_ba->tid = params->tid;
@@ -1832,11 +1837,15 @@ int mt7615_mcu_set_rx_ba(struct mt7615_dev *dev,
 
 	memcpy(wtbl_ba->peer_addr, params->sta->addr, ETH_ALEN);
 
+	wtbl_len = sizeof(*wtbl_hdr) + sizeof(*wtbl_ba);
 	if (wtbl)
-		wtbl->len = cpu_to_le16(buf - (u8 *)wtbl_hdr);
+		wtbl->len = cpu_to_le16(wtbl_len);
 
-	return mt7615_mcu_send_sta_rec(dev, (u8 *)&req, (u8 *)wtbl_hdr,
-				       buf - (u8 *)wtbl_hdr, add);
+	err = mt7615_mcu_send_sta_rec(dev, buf, (u8 *)wtbl_hdr, wtbl_len,
+				      add);
+	kfree(buf);
+
+	return err;
 }
 
 int mt7615_mcu_get_temperature(struct mt7615_dev *dev, int index)
-- 
2.24.1

