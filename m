Return-Path: <linux-wireless+bounces-33783-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMzSHEi1wmkvlAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33783-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 17:01:12 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BD00E318841
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 17:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4D29730AB815
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 15:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BA1366049;
	Tue, 24 Mar 2026 15:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="KX8Opcnh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F46D29ACC6
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 15:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774367360; cv=none; b=BJyqogGXWwLtXqFVfHqkI8hVARBTYqYGvEZUAUCMTNnWTtHuVwYHx5fzXY/xbIz//E7NWWM7vdy61wKvmn6Jh/fQ8LNjVo5sE/RHn26x4ybcXaQQ0+CiFppOX5rTeALQbwFeMMzjla2fw8Q68Bw9hucdceGZws8f7cOMsLeKY+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774367360; c=relaxed/simple;
	bh=SAuRfdp/5uU//AuFpSAZL3HW6UECzn5xPt39t0wSXE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=es+ff5U4hZVSWABuwUb7oGtTPjS280OCPXvgEMZJ9nd8cTwY9JKx75IypjhtnxEMx5/3tO1gcRrVtAmPBURlTATE3C2pyOLNhDR3tIqyu7yQL7SP3uj+x3GSyRTB050y4iXHKPwrxv9thzUG0TxxfC0c77YNrdkM9BLIfKiR75Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=pass smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=KX8Opcnh; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=EWPAJPNpqETTuCDIzpontr9dg/ChsvCM0HnHpq1NPmA=; b=KX8OpcnhhtNgAErB6X3OSb7380
	qPtuq2V0HF4b+PG0qHRlCNTub6q16Z3I3fjdXHxru/srBNgkHdtG34Vic9/shAVrTko1kFjDyrr0z
	I4GOiA9easAP2+wny8izrU/yf8hmZz1UyYnExXuMTi+o+e9lIjylANRyQt1VfQSTpn8w=;
Received: from p200300cadf3fa900000000000000085c.dip0.t-ipconnect.de ([2003:ca:df3f:a900::85c] helo=max)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1w540E-00Bfki-2h;
	Tue, 24 Mar 2026 16:49:10 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: Chad Monroe <chad@monroe.io>
Subject: [PATCH 1/2] wifi: mt76: mt7996: fix out-of-bounds array access during hardware restart
Date: Tue, 24 Mar 2026 15:49:03 +0000
Message-ID: <20260324154904.2555603-1-nbd@nbd.name>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[nbd.name:s=20160729];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nbd.name : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33783-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nbd.name:-];
	RSPAMD_EMAILBL_FAIL(0.00)[chad.monroe.io:query timed out];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nbd@nbd.name,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nbd.name:email,nbd.name:mid,monroe.io:email]
X-Rspamd-Queue-Id: BD00E318841
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

During hardware restart, link_id can be IEEE80211_LINK_UNSPECIFIED,
causing an out-of-bounds array access on msta->link[].

Add mt7996_sta_link() and mt7996_sta_link_protected() helper functions
for accessing sta links with proper RCU handling and bounds checking.
Use them for any sta link RCU access.

Reported-by: Chad Monroe <chad@monroe.io>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../wireless/mediatek/mt76/mt7996/debugfs.c   |  4 ++--
 .../net/wireless/mediatek/mt76/mt7996/mac.c   |  6 ++---
 .../net/wireless/mediatek/mt76/mt7996/main.c  | 17 +++++++-------
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 22 +++++++++----------
 .../wireless/mediatek/mt76/mt7996/mt7996.h    | 19 ++++++++++++++++
 5 files changed, 43 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
index 34af800964d1..ef9a9204adf5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
@@ -664,7 +664,7 @@ mt7996_sta_hw_queue_read(void *data, struct ieee80211_sta *sta)
 		if (!mlink)
 			continue;
 
-		msta_link = rcu_dereference(msta->link[link_id]);
+		msta_link = mt7996_sta_link(msta, link_id);
 		if (!msta_link)
 			continue;
 
@@ -1042,7 +1042,7 @@ static ssize_t mt7996_link_sta_fixed_rate_set(struct file *file,
 
 	mutex_lock(&dev->mt76.mutex);
 
-	msta_link = mt76_dereference(msta->link[link_sta->link_id], &dev->mt76);
+	msta_link = mt7996_sta_link_protected(dev, msta, link_sta->link_id);
 	if (!msta_link) {
 		ret = -EINVAL;
 		goto out;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index e2a83da3a09c..c98446057282 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -48,7 +48,7 @@ static struct mt76_wcid *mt7996_rx_get_wcid(struct mt7996_dev *dev,
 		if (mlink->band_idx != band_idx)
 			continue;
 
-		msta_link = rcu_dereference(msta->link[i]);
+		msta_link = mt7996_sta_link(msta, i);
 		break;
 	}
 
@@ -1038,7 +1038,7 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	if (link_id != wcid->link_id && link_id != IEEE80211_LINK_UNSPECIFIED) {
 		if (msta) {
 			struct mt7996_sta_link *msta_link =
-				rcu_dereference(msta->link[link_id]);
+				mt7996_sta_link(msta, link_id);
 
 			if (msta_link)
 				wcid = &msta_link->wcid;
@@ -1346,7 +1346,7 @@ mt7996_mac_tx_free(struct mt7996_dev *dev, void *data, int len)
 					 IEEE80211_MLD_MAX_NUM_LINKS) {
 				struct mt7996_sta_link *msta_link;
 
-				msta_link = rcu_dereference(msta->link[id]);
+				msta_link = mt7996_sta_link(msta, id);
 				if (!msta_link)
 					continue;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index a8a6552d49f6..796a8af565cb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -207,8 +207,7 @@ mt7996_set_hw_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		struct mt7996_sta *msta;
 
 		msta = (struct mt7996_sta *)sta->drv_priv;
-		msta_link = mt76_dereference(msta->link[link_id],
-					     &dev->mt76);
+		msta_link = mt7996_sta_link_protected(dev, msta, link_id);
 		if (!msta_link)
 			return 0;
 
@@ -1381,7 +1380,7 @@ mt7996_mac_sta_event(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 		if (!link)
 			continue;
 
-		msta_link = mt76_dereference(msta->link[link_id], &dev->mt76);
+		msta_link = mt7996_sta_link_protected(dev, msta, link_id);
 		if (!msta_link)
 			continue;
 
@@ -1573,7 +1572,7 @@ static void mt7996_tx(struct ieee80211_hw *hw,
 	if (msta) {
 		struct mt7996_sta_link *msta_link;
 
-		msta_link = rcu_dereference(msta->link[link_id]);
+		msta_link = mt7996_sta_link(msta, link_id);
 		if (msta_link)
 			wcid = &msta_link->wcid;
 	}
@@ -1944,7 +1943,7 @@ static void mt7996_link_sta_rc_update(struct ieee80211_hw *hw,
 
 	rcu_read_lock();
 
-	msta_link = rcu_dereference(msta->link[link_sta->link_id]);
+	msta_link = mt7996_sta_link(msta, link_sta->link_id);
 	if (msta_link) {
 		struct mt7996_dev *dev = mt7996_hw_dev(hw);
 
@@ -1961,7 +1960,7 @@ static void mt7996_sta_rate_ctrl_update(void *data, struct ieee80211_sta *sta)
 	struct mt7996_sta_link *msta_link;
 	u32 *changed = data;
 
-	msta_link = rcu_dereference(msta->link[msta->deflink_id]);
+	msta_link = mt7996_sta_link(msta, msta->deflink_id);
 	if (msta_link)
 		mt7996_link_rate_ctrl_update(&changed, msta_link);
 }
@@ -2011,7 +2010,7 @@ static void mt7996_sta_set_4addr(struct ieee80211_hw *hw,
 		if (!link)
 			continue;
 
-		msta_link = mt76_dereference(msta->link[link_id], &dev->mt76);
+		msta_link = mt7996_sta_link_protected(dev, msta, link_id);
 		if (!msta_link)
 			continue;
 
@@ -2049,7 +2048,7 @@ static void mt7996_sta_set_decap_offload(struct ieee80211_hw *hw,
 		if (!link)
 			continue;
 
-		msta_link = mt76_dereference(msta->link[link_id], &dev->mt76);
+		msta_link = mt7996_sta_link_protected(dev, msta, link_id);
 		if (!msta_link)
 			continue;
 
@@ -2389,7 +2388,7 @@ mt7996_net_fill_forward_path(struct ieee80211_hw *hw,
 	if (!link)
 		return -EIO;
 
-	msta_link = rcu_dereference(msta->link[msta->deflink_id]);
+	msta_link = mt7996_sta_link(msta, msta->deflink_id);
 	if (!msta_link)
 		return -EIO;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 16420375112d..9aef28e66665 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -1136,7 +1136,7 @@ mt7996_mcu_bss_basic_tlv(struct sk_buff *skb,
 				struct mt7996_sta_link *msta_link;
 				int link_id = link_conf->link_id;
 
-				msta_link = rcu_dereference(msta->link[link_id]);
+				msta_link = mt7996_sta_link(msta, link_id);
 				if (msta_link)
 					sta_wlan_idx = msta_link->wcid.idx;
 			}
@@ -1429,7 +1429,7 @@ int mt7996_mcu_add_tx_ba(struct mt7996_dev *dev,
 		struct mt7996_sta_link *msta_link;
 		struct mt7996_vif_link *link;
 
-		msta_link = mt76_dereference(msta->link[link_id], &dev->mt76);
+		msta_link = mt7996_sta_link_protected(dev, msta, link_id);
 		if (!msta_link)
 			continue;
 
@@ -1463,7 +1463,7 @@ int mt7996_mcu_add_rx_ba(struct mt7996_dev *dev,
 		struct mt7996_sta_link *msta_link;
 		struct mt7996_vif_link *link;
 
-		msta_link = mt76_dereference(msta->link[link_id], &dev->mt76);
+		msta_link = mt7996_sta_link_protected(dev, msta, link_id);
 		if (!msta_link)
 			continue;
 
@@ -2200,7 +2200,7 @@ int mt7996_mcu_set_fixed_field(struct mt7996_dev *dev, struct mt7996_sta *msta,
 	if (!mlink)
 		goto error_unlock;
 
-	msta_link = rcu_dereference(msta->link[link_id]);
+	msta_link = mt7996_sta_link(msta, link_id);
 	if (!msta_link)
 		goto error_unlock;
 
@@ -2290,7 +2290,7 @@ mt7996_mcu_add_rate_ctrl_fixed(struct mt7996_dev *dev, struct mt7996_sta *msta,
 	if (!link)
 		goto error_unlock;
 
-	msta_link = rcu_dereference(msta->link[link_id]);
+	msta_link = mt7996_sta_link(msta, link_id);
 	if (!msta_link)
 		goto error_unlock;
 
@@ -2508,7 +2508,7 @@ int mt7996_mcu_add_rate_ctrl(struct mt7996_dev *dev, struct mt7996_sta *msta,
 	if (!link)
 		goto error_unlock;
 
-	msta_link = rcu_dereference(msta->link[link_id]);
+	msta_link = mt7996_sta_link(msta, link_id);
 	if (!msta_link)
 		goto error_unlock;
 
@@ -2663,7 +2663,7 @@ mt7996_mcu_sta_mld_setup_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
 	unsigned int link_id;
 	struct tlv *tlv;
 
-	msta_link = mt76_dereference(msta->link[msta->deflink_id], &dev->mt76);
+	msta_link = mt7996_sta_link_protected(dev, msta, msta->deflink_id);
 	if (!msta_link)
 		return;
 
@@ -2677,8 +2677,8 @@ mt7996_mcu_sta_mld_setup_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
 	mld_setup->primary_id = cpu_to_le16(msta_link->wcid.idx);
 
 	if (nlinks > 1) {
-		msta_link = mt76_dereference(msta->link[msta->seclink_id],
-					     &dev->mt76);
+		msta_link = mt7996_sta_link_protected(dev, msta,
+						      msta->seclink_id);
 		if (!msta_link)
 			return;
 	}
@@ -2689,7 +2689,7 @@ mt7996_mcu_sta_mld_setup_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
 	for_each_sta_active_link(vif, sta, link_sta, link_id) {
 		struct mt7996_vif_link *link;
 
-		msta_link = mt76_dereference(msta->link[link_id], &dev->mt76);
+		msta_link = mt7996_sta_link_protected(dev, msta, link_id);
 		if (!msta_link)
 			continue;
 
@@ -2837,7 +2837,7 @@ void mt7996_mcu_update_sta_rec_bw(void *data, struct ieee80211_sta *sta)
 	if (!link_sta)
 		return;
 
-	msta_link = mt76_dereference(msta->link[link_id], &dev->mt76);
+	msta_link = mt7996_sta_link_protected(dev, msta, link_id);
 	if (!msta_link)
 		return;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index bdcf72457954..0dc4198fcf8b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -642,6 +642,25 @@ mt7996_vif_conf_link(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 							    link_conf);
 }
 
+static inline struct mt7996_sta_link *
+mt7996_sta_link(struct mt7996_sta *msta, u8 link_id)
+{
+	if (link_id >= IEEE80211_MLD_MAX_NUM_LINKS)
+		return NULL;
+
+	return rcu_dereference(msta->link[link_id]);
+}
+
+static inline struct mt7996_sta_link *
+mt7996_sta_link_protected(struct mt7996_dev *dev, struct mt7996_sta *msta,
+			  u8 link_id)
+{
+	if (link_id >= IEEE80211_MLD_MAX_NUM_LINKS)
+		return NULL;
+
+	return mt76_dereference(msta->link[link_id], &dev->mt76);
+}
+
 #define mt7996_for_each_phy(dev, phy)					\
 	for (int __i = 0; __i < ARRAY_SIZE((dev)->radio_phy); __i++)	\
 		if (((phy) = (dev)->radio_phy[__i]) != NULL)
-- 
2.51.0


