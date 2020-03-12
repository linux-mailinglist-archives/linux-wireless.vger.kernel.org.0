Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88CC91835CE
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2020 17:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgCLQD1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Mar 2020 12:03:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727228AbgCLQD1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Mar 2020 12:03:27 -0400
Received: from lore-desk-wlan.redhat.com (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9E6D20724;
        Thu, 12 Mar 2020 16:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584029007;
        bh=a3d5M190XuICCbrMboxf9IxCVCj1d+urVqD3+JRtQq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RlH3ARHHSPMxeIQIJ/Wo+oIm/IDqNDCJwiee38Zjsurk/0QwJdXOcYIz+echQLwCK
         Odbge0ezpEv94MGbiVVeqUqdNdGri7Qh0eyvMFDRiYBdiua0s9+vpj10cWqedPoHuY
         DxCOMnLAEQrUx0C5FO8cotPsbcUzfCtDDxsQZrfM=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, linux-wireless@vger.kernel.org
Subject: [PATCH v3 24/25] mt76: mt7615: get rid of sta_rec_wtbl data structure
Date:   Thu, 12 Mar 2020 17:02:34 +0100
Message-Id: <1dafe228943409e41b4977681f585fc7812db874.1584028319.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1584028319.git.lorenzo@kernel.org>
References: <cover.1584028319.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sobstitute sta_rec_wtbl data structure with tlv one

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 17 +++++++----------
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.h |  7 +------
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index bb351303cc9f..67f41250fb52 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -478,7 +478,7 @@ static struct wtbl_req_hdr *
 mt7615_mcu_alloc_wtbl_req(struct mt7615_sta *msta, int cmd,
 			  void *sta_wtbl, struct sk_buff **skb)
 {
-	struct sta_rec_wtbl *sta_hdr = sta_wtbl;
+	struct tlv *sta_hdr = sta_wtbl;
 	struct wtbl_req_hdr hdr = {
 		.wlan_idx = msta->wcid.idx,
 		.operation = cmd,
@@ -504,7 +504,7 @@ mt7615_mcu_add_nested_tlv(struct sk_buff *skb, int tag, int len,
 			  void *sta_ntlv, void *sta_wtbl)
 {
 	struct sta_ntlv_hdr *ntlv_hdr = sta_ntlv;
-	struct sta_rec_wtbl *sta_hdr = sta_wtbl;
+	struct tlv *sta_hdr = sta_wtbl;
 	struct tlv *ptlv, tlv = {
 		.tag = cpu_to_le16(tag),
 		.len = cpu_to_le16(len),
@@ -1027,8 +1027,8 @@ mt7615_mcu_sta_ba(struct mt7615_dev *dev,
 		return PTR_ERR(skb);
 
 	mt7615_mcu_sta_ba_tlv(skb, params, enable, tx);
-	sta_wtbl = mt7615_mcu_add_tlv(skb, STA_REC_WTBL,
-				      sizeof(struct sta_rec_wtbl));
+
+	sta_wtbl = mt7615_mcu_add_tlv(skb, STA_REC_WTBL, sizeof(struct tlv));
 
 	wtbl_hdr = mt7615_mcu_alloc_wtbl_req(msta, WTBL_SET, sta_wtbl, &skb);
 	mt7615_mcu_wtbl_ba_tlv(skb, params, enable, tx, sta_wtbl, wtbl_hdr);
@@ -1073,8 +1073,7 @@ mt7615_mcu_add_sta_cmd(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 	if (enable && sta)
 		mt7615_mcu_sta_ht_tlv(skb, sta);
 
-	sta_wtbl = mt7615_mcu_add_tlv(skb, STA_REC_WTBL,
-				      sizeof(struct sta_rec_wtbl));
+	sta_wtbl = mt7615_mcu_add_tlv(skb, STA_REC_WTBL, sizeof(struct tlv));
 
 	wtbl_hdr = mt7615_mcu_alloc_wtbl_req(msta, WTBL_RESET_AND_SET,
 					     sta_wtbl, &skb);
@@ -1322,8 +1321,7 @@ mt7615_mcu_uni_tx_ba(struct mt7615_dev *dev,
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
-	sta_wtbl = mt7615_mcu_add_tlv(skb, STA_REC_WTBL,
-				      sizeof(struct sta_rec_wtbl));
+	sta_wtbl = mt7615_mcu_add_tlv(skb, STA_REC_WTBL, sizeof(struct tlv));
 
 	wtbl_hdr = mt7615_mcu_alloc_wtbl_req(msta, WTBL_SET, sta_wtbl, &skb);
 	if (IS_ERR(wtbl_hdr))
@@ -1374,8 +1372,7 @@ mt7615_mcu_uni_rx_ba(struct mt7615_dev *dev,
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
-	sta_wtbl = mt7615_mcu_add_tlv(skb, STA_REC_WTBL,
-				      sizeof(struct sta_rec_wtbl));
+	sta_wtbl = mt7615_mcu_add_tlv(skb, STA_REC_WTBL, sizeof(struct tlv));
 
 	wtbl_hdr = mt7615_mcu_alloc_wtbl_req(msta, WTBL_SET, sta_wtbl, &skb);
 	if (IS_ERR(wtbl_hdr))
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index 039634ae0412..19ea86d88f6b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -526,7 +526,7 @@ struct wtbl_raw {
 					 sizeof(struct sta_rec_basic) +	\
 					 sizeof(struct sta_rec_ht) +	\
 					 sizeof(struct sta_rec_vht) +	\
-					 sizeof(struct sta_rec_wtbl) +	\
+					 sizeof(struct tlv) +	\
 					 MT7615_WTBL_UPDATE_MAX_SIZE)
 
 #define MT7615_WTBL_UPDATE_BA_SIZE	(sizeof(struct wtbl_req_hdr) +	\
@@ -615,11 +615,6 @@ struct sta_rec_ba {
 	__le16 winsize;
 } __packed;
 
-struct sta_rec_wtbl {
-	__le16 tag;
-	__le16 len;
-} __packed;
-
 enum {
 	STA_REC_BASIC,
 	STA_REC_RA,
-- 
2.24.1

