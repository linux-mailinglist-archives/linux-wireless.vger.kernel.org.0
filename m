Return-Path: <linux-wireless+bounces-17011-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 282109FFBDF
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 17:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3034E3A37CE
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 16:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9B11632F6;
	Thu,  2 Jan 2025 16:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="n+q8d5eI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E738D16B3B7
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jan 2025 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735835725; cv=none; b=TjKao5SSQBO2h6aANWadYssIoVVmFfioXkCJNrJoxhQY/d0rEJ7LkBoHMidS23Tf7HawPpGZ/WKZxNoFBz5mBHXdp+nwRJc6YeXrmSWKeDnvRiWTfx/HXVnpzXXhyiqRG++qnH/TgSl9A8oSRtxxdx8vGD4Qr1+sUcNgMzpLbNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735835725; c=relaxed/simple;
	bh=8SxS/hCNASe3gAbp58aNNrYcIfzaG7h/3Qa0NZ1Jg8U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ShtddapTL0Nbv5NIIBHMj4UbIgYi6RBGkjbel6tlAYlplaSgEIVGS3MoZATYOLcYeWX0bx9cKpsNg5HUYT5djQfTubNxkLfiN2gXsKfw51kDEjFUnmEuv2GW1l6KEg+USwFLE1qxlXu6wjPYRGy+G8Rw6WZOdmT924k4KdMz8Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=n+q8d5eI; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=t7aqJXvahM7uB2BQB2DoD8pkeyMXQOKp5tnvnN9jlf0=; b=n+q8d5eIg8zrQ8kgygHW0Ny0hQ
	FsUt2AqSXoVQMHD+874dwAZU1EbsyJn9oULRGS9o2jJmtBTeIMcGjA9vLvcHA20maKJpm1PTYsGj3
	Ci972Ur2jcPugcImkexFRcw+eUoLRsHalq+CSv/zVKVchUhxZ1ya+eJXYwve3xKd5GQc=;
Received: from p4ff13c5f.dip0.t-ipconnect.de ([79.241.60.95] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1tTOAD-0008GS-1x
	for linux-wireless@vger.kernel.org;
	Thu, 02 Jan 2025 17:35:13 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 14/24] wifi: mt76: mt7996: pass wcid to mt7996_mcu_sta_hdr_trans_tlv
Date: Thu,  2 Jan 2025 17:34:58 +0100
Message-ID: <20250102163508.52945-14-nbd@nbd.name>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102163508.52945-1-nbd@nbd.name>
References: <20250102163508.52945-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Preparation for MLO support.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 1f0090c97e9c..ebb2ff15a8d8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -1795,11 +1795,9 @@ mt7996_mcu_sta_hdrt_tlv(struct mt7996_dev *dev, struct sk_buff *skb)
 
 static void
 mt7996_mcu_sta_hdr_trans_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
-			     struct ieee80211_vif *vif,
-			     struct ieee80211_sta *sta)
+			     struct ieee80211_vif *vif, struct mt76_wcid *wcid)
 {
 	struct sta_rec_hdr_trans *hdr_trans;
-	struct mt76_wcid *wcid;
 	struct tlv *tlv;
 
 	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_HDR_TRANS, sizeof(*hdr_trans));
@@ -1811,10 +1809,9 @@ mt7996_mcu_sta_hdr_trans_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
 	else
 		hdr_trans->from_ds = true;
 
-	if (!sta)
+	if (!wcid)
 		return;
 
-	wcid = (struct mt76_wcid *)sta->drv_priv;
 	hdr_trans->dis_rx_hdr_tran = !test_bit(MT_WCID_FLAG_HDR_TRANS, &wcid->flags);
 	if (test_bit(MT_WCID_FLAG_4ADDR, &wcid->flags)) {
 		hdr_trans->to_ds = true;
@@ -2194,7 +2191,7 @@ int mt7996_mcu_add_sta(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 		goto out;
 
 	/* starec hdr trans */
-	mt7996_mcu_sta_hdr_trans_tlv(dev, skb, vif, sta);
+	mt7996_mcu_sta_hdr_trans_tlv(dev, skb, vif, &msta->wcid);
 	/* starec tx proc */
 	mt7996_mcu_sta_tx_proc_tlv(skb);
 
@@ -4322,7 +4319,7 @@ int mt7996_mcu_wtbl_update_hdr_trans(struct mt7996_dev *dev,
 		return PTR_ERR(skb);
 
 	/* starec hdr trans */
-	mt7996_mcu_sta_hdr_trans_tlv(dev, skb, vif, sta);
+	mt7996_mcu_sta_hdr_trans_tlv(dev, skb, vif, &msta->wcid);
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
 				     MCU_WMWA_UNI_CMD(STA_REC_UPDATE), true);
 }
-- 
2.47.1


