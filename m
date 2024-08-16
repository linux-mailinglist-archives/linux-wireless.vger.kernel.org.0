Return-Path: <linux-wireless+bounces-11568-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23035955011
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 19:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D431E2869A7
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 17:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065181C37A0;
	Fri, 16 Aug 2024 17:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="tEU3Fd9K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99C31BF324
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 17:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723829741; cv=none; b=GRQY5lL4VgMajfdOnb6NCO8O8byRbKBfvXp4icuwK/9GFsdMVFnZTvy8HV1p4Kutt2MIltf0nR+zFz9mw5Er3Q0d4llbjmVws3JoRpMdV7yQ8ICoyjCnW5u7TFs6TsBMbdPjBI2n1Xjr8Zjsbf4XGYhj/xliodBFJTI0UrhBjaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723829741; c=relaxed/simple;
	bh=OdEKbaFJw5tmylo0Q1lvTvctOC14bj0AhR52G97rJuE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLoeH5+dnLVv6WC9MSc4tlAchd5N55asjRGkGS1bsfH0/aSNmYvd72U5VifmoyTLiuf3+R44LgIiK2FTGXKbaO2vE6WpT5IGWqNsMKJjSBfkvgaLWHteZ+O8plhNz56JvC3Q+ySwKtVbnr40tNoqWDeeyRfuX7ZPwMLsmlATVrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=tEU3Fd9K; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=o7eZBopJ5GL1TGY41TKBK9+jKOPoROCUIpmy2J1xPgI=; b=tEU3Fd9KqAlXMe7FC6KfDXlUF6
	4Mi67tZmbdAYx2aHjfT3frX+I2dQxH+YdwrTaUVOIX5oGVDtPJlmokOaftpaMGrTUXaYgm9tR647Q
	IkFsbynbWaehRyDf5/fiMXIY3XGVqXYclWtMlKK2TzBJUvgKbtLwhZ9CeQ9YrfpTNPqU=;
Received: from p54ae95e7.dip0.t-ipconnect.de ([84.174.149.231] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sf0rR-000ObE-31
	for linux-wireless@vger.kernel.org;
	Fri, 16 Aug 2024 19:35:38 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 09/16] wifi: mt76: connac: add support for IEEE 802.11 fragmentation
Date: Fri, 16 Aug 2024 19:35:22 +0200
Message-ID: <20240816173529.17873-9-nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240816173529.17873-1-nbd@nbd.name>
References: <20240816173529.17873-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Lin <benjamin-jw.lin@mediatek.com>

Add fragmentation index into TXD.DW2 to support IEEE 802.11 fragmentation.

Signed-off-by: Benjamin Lin <benjamin-jw.lin@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h |  7 +++++++
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c  | 10 +++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
index 5f132115ebfc..eb4765365b8c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
@@ -355,4 +355,11 @@ enum tx_port_idx {
 	MT_TX_PORT_IDX_MCU
 };
 
+enum tx_frag_idx {
+	MT_TX_FRAG_NONE,
+	MT_TX_FRAG_FIRST,
+	MT_TX_FRAG_MID,
+	MT_TX_FRAG_LAST
+};
+
 #endif /* __MT76_CONNAC2_MAC_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index b841bf628d02..a3db65254e37 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -391,6 +391,7 @@ mt76_connac2_mac_write_txwi_80211(struct mt76_dev *dev, __le32 *txwi,
 	bool multicast = is_multicast_ether_addr(hdr->addr1);
 	u8 tid = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
 	__le16 fc = hdr->frame_control;
+	__le16 sc = hdr->seq_ctrl;
 	u8 fc_type, fc_stype;
 	u32 val;
 
@@ -432,6 +433,13 @@ mt76_connac2_mac_write_txwi_80211(struct mt76_dev *dev, __le32 *txwi,
 	    info->flags & IEEE80211_TX_CTL_USE_MINRATE)
 		val |= MT_TXD2_FIX_RATE;
 
+	if (ieee80211_has_morefrags(fc) && ieee80211_is_first_frag(sc))
+		val |= FIELD_PREP(MT_TXD2_FRAG, MT_TX_FRAG_FIRST);
+	else if (ieee80211_has_morefrags(fc) && !ieee80211_is_first_frag(sc))
+		val |= FIELD_PREP(MT_TXD2_FRAG, MT_TX_FRAG_MID);
+	else if (!ieee80211_has_morefrags(fc) && !ieee80211_is_first_frag(sc))
+		val |= FIELD_PREP(MT_TXD2_FRAG, MT_TX_FRAG_LAST);
+
 	txwi[2] |= cpu_to_le32(val);
 
 	if (ieee80211_is_beacon(fc)) {
@@ -440,7 +448,7 @@ mt76_connac2_mac_write_txwi_80211(struct mt76_dev *dev, __le32 *txwi,
 	}
 
 	if (info->flags & IEEE80211_TX_CTL_INJECTED) {
-		u16 seqno = le16_to_cpu(hdr->seq_ctrl);
+		u16 seqno = le16_to_cpu(sc);
 
 		if (ieee80211_is_back_req(hdr->frame_control)) {
 			struct ieee80211_bar *bar;
-- 
2.44.0


