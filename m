Return-Path: <linux-wireless+bounces-17001-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A259B9FFBD3
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 17:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D184A162B4E
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 16:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB0117B425;
	Thu,  2 Jan 2025 16:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="mAt8bQVy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA80155A52
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jan 2025 16:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735835723; cv=none; b=pAK+1PWY/LtLbePiClhC7vWWYzys6qTfVMhZ4YWc4gue1+zGUiftrcSVSDJHFNvcOoXDQiqqIf3lLBQJ0jMVchbNixJ2e8cy5LhbSzCnBX9CVYQuaRDx28MTIfKZgC8RYSNAn1pfK50IdEj27hC4lL6ZARMw3btgyq16EWns7E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735835723; c=relaxed/simple;
	bh=Fk9WmCt+w+/b9qjzmHq9c0eToBv9V0JWoxlR9TW8i0Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cLtIGFideXbycJlhete/vAJy3a6NDpT7jILK6j2N/OCY3RMYCNOLf+bJsHf1F1YxybETRCjbRm07uMV5oll1xwYP1nv8wMiboolJsE+oCsgLpNrQ5c4HF4hy7ok51Jb8lL9amtYrv9mF4WBJrU5uxyariymnit5ycRqvPaSkj6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=mAt8bQVy; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=B6NT21+nWdT1ZPlUht8DY6Dvi4GFqgeWZPjHPkE/Tj8=; b=mAt8bQVyNNBXj1GlX2o/TMtd0f
	mubqENqiRb+D0dVAWWrJx5xFYRtxczMc8Gb8UPnt4m8pDNSemkiQ6kpCKvywvKskB6zZkNGmvvZ/D
	SZQadHJqwshFXb8Rqcwqvhl9jb0e/Lmg93nsNy6uqfLz4a6fSkkSAQaNz0N/3AulrKwA=;
Received: from p4ff13c5f.dip0.t-ipconnect.de ([79.241.60.95] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1tTOAC-0008GS-0B
	for linux-wireless@vger.kernel.org;
	Thu, 02 Jan 2025 17:35:12 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 04/24] wifi: mt76: add vif link specific data structure
Date: Thu,  2 Jan 2025 17:34:48 +0100
Message-ID: <20250102163508.52945-4-nbd@nbd.name>
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

Preparation for splitting link data from vif data for MLO support.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt76.h | 53 +++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 1782ebc7085e..669cbd63f403 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -766,6 +766,15 @@ struct mt76_vif_link {
 	u8 beacon_rates_idx;
 	struct ieee80211_chanctx_conf *ctx;
 	struct mt76_wcid *wcid;
+	struct mt76_vif_data *mvif;
+	struct rcu_head rcu_head;
+};
+
+struct mt76_vif_data {
+	struct mt76_vif_link __rcu *link[IEEE80211_MLD_MAX_NUM_LINKS];
+
+	u16 valid_links;
+	u8 deflink_id;
 };
 
 struct mt76_phy {
@@ -1168,6 +1177,10 @@ static inline int mt76_wed_dma_setup(struct mt76_dev *dev, struct mt76_queue *q,
 	for (i = 0; i < ARRAY_SIZE((dev)->q_rx); i++)	\
 		if ((dev)->q_rx[i].ndesc)
 
+
+#define mt76_dereference(p, dev) \
+	rcu_dereference_protected(p, lockdep_is_held(&(dev)->mutex))
+
 struct mt76_dev *mt76_alloc_device(struct device *pdev, unsigned int size,
 				   const struct ieee80211_ops *ops,
 				   const struct mt76_driver_ops *drv_ops);
@@ -1755,4 +1768,44 @@ void mt76_wcid_init(struct mt76_wcid *wcid);
 void mt76_wcid_cleanup(struct mt76_dev *dev, struct mt76_wcid *wcid);
 void mt76_wcid_add_poll(struct mt76_dev *dev, struct mt76_wcid *wcid);
 
+static inline void
+mt76_vif_init(struct ieee80211_vif *vif, struct mt76_vif_data *mvif)
+{
+	struct mt76_vif_link *mlink = (struct mt76_vif_link *)vif->drv_priv;
+
+	mlink->mvif = mvif;
+	rcu_assign_pointer(mvif->link[0], mlink);
+}
+
+static inline void
+mt76_vif_cleanup(struct mt76_dev *dev, struct ieee80211_vif *vif)
+{
+	struct mt76_vif_link *mlink = (struct mt76_vif_link *)vif->drv_priv;
+	struct mt76_vif_data *mvif = mlink->mvif;
+
+	rcu_assign_pointer(mvif->link[0], NULL);
+}
+
+static inline struct mt76_vif_link *
+mt76_vif_link(struct mt76_dev *dev, struct ieee80211_vif *vif, int link_id)
+{
+	struct mt76_vif_link *mlink = (struct mt76_vif_link *)vif->drv_priv;
+	struct mt76_vif_data *mvif = mlink->mvif;
+
+	return mt76_dereference(mvif->link[link_id], dev);
+}
+
+static inline struct mt76_vif_link *
+mt76_vif_conf_link(struct mt76_dev *dev, struct ieee80211_vif *vif,
+		   struct ieee80211_bss_conf *link_conf)
+{
+	struct mt76_vif_link *mlink = (struct mt76_vif_link *)vif->drv_priv;
+	struct mt76_vif_data *mvif = mlink->mvif;
+
+	if (link_conf == &vif->bss_conf)
+		return mlink;
+
+	return mt76_dereference(mvif->link[link_conf->link_id], dev);
+}
+
 #endif
-- 
2.47.1


