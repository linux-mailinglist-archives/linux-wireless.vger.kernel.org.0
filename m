Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EACD6188ACE
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2020 17:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgCQQmi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Mar 2020 12:42:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:47924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbgCQQmi (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Mar 2020 12:42:38 -0400
Received: from lore-desk-wlan.redhat.com (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 071C320663;
        Tue, 17 Mar 2020 16:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584463357;
        bh=hTimax+oZjOzD9e1mB5+sI8iqyRbV+3ZpwnJohD8n/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mLkhiKbH5cpqVOR6A2HRYCXaMbPkiFpKjDnknScy781x3/+S3mG8JSGA15GYY4jNU
         Ae/Zvf8eOPLG2qJ14eeGR52wnE8C6L6H+chPkd62iEgNL8kiZ9v6TcX6XVXtLvwABa
         YAKZAcpjqqOznRC3cWnVHB2B5pZHt9YNh3O9VlF0=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 24/25] mt76: mt7615: get rid of sta_rec_wtbl data structure
Date:   Tue, 17 Mar 2020 17:41:31 +0100
Message-Id: <02778e136c4b5d5bc5897ee19e8053686f3c6358.1584463004.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1584463004.git.lorenzo@kernel.org>
References: <cover.1584463004.git.lorenzo@kernel.org>
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
index 9840933211a4..8e0225e6cc72 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -486,7 +486,7 @@ static struct wtbl_req_hdr *
 mt7615_mcu_alloc_wtbl_req(struct mt7615_sta *msta, int cmd,
 			  void *sta_wtbl, struct sk_buff **skb)
 {
-	struct sta_rec_wtbl *sta_hdr = sta_wtbl;
+	struct tlv *sta_hdr = sta_wtbl;
 	struct wtbl_req_hdr hdr = {
 		.wlan_idx = msta->wcid.idx,
 		.operation = cmd,
@@ -512,7 +512,7 @@ mt7615_mcu_add_nested_tlv(struct sk_buff *skb, int tag, int len,
 			  void *sta_ntlv, void *sta_wtbl)
 {
 	struct sta_ntlv_hdr *ntlv_hdr = sta_ntlv;
-	struct sta_rec_wtbl *sta_hdr = sta_wtbl;
+	struct tlv *sta_hdr = sta_wtbl;
 	struct tlv *ptlv, tlv = {
 		.tag = cpu_to_le16(tag),
 		.len = cpu_to_le16(len),
@@ -1035,8 +1035,8 @@ mt7615_mcu_sta_ba(struct mt7615_dev *dev,
 		return PTR_ERR(skb);
 
 	mt7615_mcu_sta_ba_tlv(skb, params, enable, tx);
-	sta_wtbl = mt7615_mcu_add_tlv(skb, STA_REC_WTBL,
-				      sizeof(struct sta_rec_wtbl));
+
+	sta_wtbl = mt7615_mcu_add_tlv(skb, STA_REC_WTBL, sizeof(struct tlv));
 
 	wtbl_hdr = mt7615_mcu_alloc_wtbl_req(msta, WTBL_SET, sta_wtbl, &skb);
 	mt7615_mcu_wtbl_ba_tlv(skb, params, enable, tx, sta_wtbl, wtbl_hdr);
@@ -1081,8 +1081,7 @@ mt7615_mcu_add_sta_cmd(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 	if (enable && sta)
 		mt7615_mcu_sta_ht_tlv(skb, sta);
 
-	sta_wtbl = mt7615_mcu_add_tlv(skb, STA_REC_WTBL,
-				      sizeof(struct sta_rec_wtbl));
+	sta_wtbl = mt7615_mcu_add_tlv(skb, STA_REC_WTBL, sizeof(struct tlv));
 
 	wtbl_hdr = mt7615_mcu_alloc_wtbl_req(msta, WTBL_RESET_AND_SET,
 					     sta_wtbl, &skb);
@@ -1330,8 +1329,7 @@ mt7615_mcu_uni_tx_ba(struct mt7615_dev *dev,
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
-	sta_wtbl = mt7615_mcu_add_tlv(skb, STA_REC_WTBL,
-				      sizeof(struct sta_rec_wtbl));
+	sta_wtbl = mt7615_mcu_add_tlv(skb, STA_REC_WTBL, sizeof(struct tlv));
 
 	wtbl_hdr = mt7615_mcu_alloc_wtbl_req(msta, WTBL_SET, sta_wtbl, &skb);
 	if (IS_ERR(wtbl_hdr))
@@ -1382,8 +1380,7 @@ mt7615_mcu_uni_rx_ba(struct mt7615_dev *dev,
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
-	sta_wtbl = mt7615_mcu_add_tlv(skb, STA_REC_WTBL,
-				      sizeof(struct sta_rec_wtbl));
+	sta_wtbl = mt7615_mcu_add_tlv(skb, STA_REC_WTBL, sizeof(struct tlv));
 
 	wtbl_hdr = mt7615_mcu_alloc_wtbl_req(msta, WTBL_SET, sta_wtbl, &skb);
 	if (IS_ERR(wtbl_hdr))
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index 62a7b86f2a3b..d1f7391472fc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -577,7 +577,7 @@ struct wtbl_raw {
 					 sizeof(struct sta_rec_basic) +	\
 					 sizeof(struct sta_rec_ht) +	\
 					 sizeof(struct sta_rec_vht) +	\
-					 sizeof(struct sta_rec_wtbl) +	\
+					 sizeof(struct tlv) +	\
 					 MT7615_WTBL_UPDATE_MAX_SIZE)
 
 #define MT7615_WTBL_UPDATE_BA_SIZE	(sizeof(struct wtbl_req_hdr) +	\
@@ -666,11 +666,6 @@ struct sta_rec_ba {
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
2.25.1

