Return-Path: <linux-wireless+bounces-32743-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FANIvNjrmlbCwIAu9opvQ
	(envelope-from <linux-wireless+bounces-32743-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 07:08:51 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9FF2341AD
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 07:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF6D53047039
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2026 06:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB4F355F3F;
	Mon,  9 Mar 2026 06:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="Yazdt9IK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E86434DCEE
	for <linux-wireless@vger.kernel.org>; Mon,  9 Mar 2026 06:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773036466; cv=none; b=OIP6/q7ZFpVFB45wn+crumrRMWG/9MwLyXRB9Jl/tUZme90zBDioBDj1PPcNeeXzg1d1GPO5vPabNK09TN1MdTZP+TuYcNkbtYqDASVb1KMSCqJ3944A7Hvad6R1DNwNrcts6bvWG1+Y5WQMfEtt/YNRmg5gZ0LHAbSKahczMv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773036466; c=relaxed/simple;
	bh=ygIXbwG2kBFAoIWEfijoWDnO3WzRC7N0lxnLSAMW3iY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gqBf9A7fLoBWHxugEGlhinohPpbU5cDHT7yCzl5rI/pYZmbhplKUDxuDnn+AuxnegADUMTdYjLikBkOhSdGV+IJhgk8wzJyFexjzt8AlZvMYxofWhQBKubSA+zEwJMBD3mDgfvBstU+dlSoVbZroHKYxvYfu5C9B3NXV/iFoTgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=pass smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=Yazdt9IK; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=dk4j+5Ec2C4g5MoPafZKnKZTctBEC9WBAljEEd8kiDU=; b=Yazdt9IKT+o7mr03JwY1g8A5kD
	hdNuwqnH1L3HhYdcCZilgyCkImwxEOe5JkCUPE/lrKUO9RDeapRr5QKc8cVwscVesJW1lNaMtTlMK
	IiLRYyBGXM182pAnzVy5N2cJ2Vd124cpswgxfPjIgy2yW0XwHRbkar7LcgYLUdPc4MNo=;
Received: from p200300cadf236500000000000000085c.dip0.t-ipconnect.de ([2003:ca:df23:6500::85c] helo=max)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1vzTmE-00GH43-0t
	for linux-wireless@vger.kernel.org;
	Mon, 09 Mar 2026 07:07:38 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH mt76 11/11] wifi: mt76: add per-link beacon monitoring for MLO
Date: Mon,  9 Mar 2026 06:07:30 +0000
Message-ID: <20260309060730.87840-11-nbd@nbd.name>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260309060730.87840-1-nbd@nbd.name>
References: <20260309060730.87840-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2E9FF2341AD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[nbd.name:s=20160729];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nbd.name : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32743-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nbd@nbd.name,linux-wireless@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.565];
	DKIM_TRACE(0.00)[nbd.name:-];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nbd.name:mid,nbd.name:email]
X-Rspamd-Action: no action

With chanctx drivers using hardware scan or remain-on-channel,
mac80211 does not know when the radio goes off-channel, which breaks
its software beacon loss detection.

Implement per-link beacon monitoring in the driver. Track the last
beacon timestamp per link and check for beacon loss periodically from
the mac_work handler.

Beacon monitoring is initialized on association and on late link
activation, and cleared on disassociation. The beacon_mon_last
timestamp is reset when returning from offchannel and after channel
switches to prevent false beacon loss detection.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/channel.c  |   2 +
 drivers/net/wireless/mediatek/mt76/mac80211.c | 109 +++++++++++++++++-
 drivers/net/wireless/mediatek/mt76/mt76.h     |   5 +
 .../net/wireless/mediatek/mt76/mt7996/mac.c   |   6 +-
 .../net/wireless/mediatek/mt76/mt7996/main.c  |  32 +++++
 drivers/net/wireless/mediatek/mt76/scan.c     |   1 -
 6 files changed, 150 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/channel.c b/drivers/net/wireless/mediatek/mt76/channel.c
index 3072e11e2688..cf3fc09e5d5a 100644
--- a/drivers/net/wireless/mediatek/mt76/channel.c
+++ b/drivers/net/wireless/mediatek/mt76/channel.c
@@ -257,6 +257,8 @@ int mt76_switch_vif_chanctx(struct ieee80211_hw *hw,
 			continue;
 
 		mlink->ctx = vifs->new_ctx;
+		if (mlink->beacon_mon_interval)
+			WRITE_ONCE(mlink->beacon_mon_last, jiffies);
 	}
 
 out:
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 38b2088e8c19..b4c935b8d0ec 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -2201,8 +2201,11 @@ mt76_offchannel_notify_iter(void *_data, u8 *mac, struct ieee80211_vif *vif)
 	mvif = mlink->mvif;
 
 	if (!ieee80211_vif_is_mld(vif)) {
-		if (mt76_vif_link_phy(mlink) == data->phy)
+		if (mt76_vif_link_phy(mlink) == data->phy) {
+			if (!data->offchannel && mlink->beacon_mon_interval)
+				WRITE_ONCE(mlink->beacon_mon_last, jiffies);
 			mt76_offchannel_send_nullfunc(data, vif, -1);
+		}
 		return;
 	}
 
@@ -2216,6 +2219,9 @@ mt76_offchannel_notify_iter(void *_data, u8 *mac, struct ieee80211_vif *vif)
 		if (mt76_vif_link_phy(mlink) != data->phy)
 			continue;
 
+		if (!data->offchannel && mlink->beacon_mon_interval)
+			WRITE_ONCE(mlink->beacon_mon_last, jiffies);
+
 		mt76_offchannel_send_nullfunc(data, vif, link_id);
 	}
 }
@@ -2237,3 +2243,104 @@ void mt76_offchannel_notify(struct mt76_phy *phy, bool offchannel)
 	local_bh_enable();
 }
 EXPORT_SYMBOL_GPL(mt76_offchannel_notify);
+
+struct mt76_rx_beacon_data {
+	struct mt76_phy *phy;
+	const u8 *bssid;
+};
+
+static void mt76_rx_beacon_iter(void *_data, u8 *mac,
+				struct ieee80211_vif *vif)
+{
+	struct mt76_rx_beacon_data *data = _data;
+	struct mt76_vif_link *mlink = (struct mt76_vif_link *)vif->drv_priv;
+	struct mt76_vif_data *mvif = mlink->mvif;
+	int link_id;
+
+	if (vif->type != NL80211_IFTYPE_STATION || !vif->cfg.assoc)
+		return;
+
+	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
+		struct ieee80211_bss_conf *link_conf;
+
+		if (link_id == mvif->deflink_id)
+			mlink = (struct mt76_vif_link *)vif->drv_priv;
+		else
+			mlink = rcu_dereference(mvif->link[link_id]);
+		if (!mlink || !mlink->beacon_mon_interval)
+			continue;
+
+		if (mt76_vif_link_phy(mlink) != data->phy)
+			continue;
+
+		link_conf = rcu_dereference(vif->link_conf[link_id]);
+		if (!link_conf ||
+		    !ether_addr_equal(link_conf->bssid, data->bssid))
+			continue;
+
+		WRITE_ONCE(mlink->beacon_mon_last, jiffies);
+	}
+}
+
+void mt76_rx_beacon(struct mt76_phy *phy, struct sk_buff *skb)
+{
+	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
+	struct ieee80211_hdr *hdr = mt76_skb_get_hdr(skb);
+	struct mt76_rx_beacon_data data = {
+		.phy = phy,
+		.bssid = hdr->addr3,
+	};
+
+	mt76_scan_rx_beacon(phy->dev, phy->chandef.chan);
+
+	if (!phy->num_sta)
+		return;
+
+	if (status->flag & (RX_FLAG_FAILED_FCS_CRC | RX_FLAG_ONLY_MONITOR))
+		return;
+
+	ieee80211_iterate_active_interfaces_atomic(phy->hw,
+		IEEE80211_IFACE_ITER_RESUME_ALL,
+		mt76_rx_beacon_iter, &data);
+}
+EXPORT_SYMBOL_GPL(mt76_rx_beacon);
+
+static void mt76_beacon_mon_iter(void *data, u8 *mac,
+				 struct ieee80211_vif *vif)
+{
+	struct mt76_phy *phy = data;
+	struct mt76_vif_link *mlink = (struct mt76_vif_link *)vif->drv_priv;
+	struct mt76_vif_data *mvif = mlink->mvif;
+	int link_id;
+
+	if (vif->type != NL80211_IFTYPE_STATION || !vif->cfg.assoc)
+		return;
+
+	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
+		if (link_id == mvif->deflink_id)
+			mlink = (struct mt76_vif_link *)vif->drv_priv;
+		else
+			mlink = rcu_dereference(mvif->link[link_id]);
+		if (!mlink || !mlink->beacon_mon_interval)
+			continue;
+
+		if (mt76_vif_link_phy(mlink) != phy)
+			continue;
+
+		if (time_after(jiffies,
+			       READ_ONCE(mlink->beacon_mon_last) +
+			       MT76_BEACON_MON_MAX_MISS * mlink->beacon_mon_interval))
+			ieee80211_beacon_loss(vif);
+	}
+}
+
+void mt76_beacon_mon_check(struct mt76_phy *phy)
+{
+	if (phy->offchannel)
+		return;
+
+	ieee80211_iterate_active_interfaces_atomic(phy->hw,
+		IEEE80211_IFACE_ITER_RESUME_ALL,
+		mt76_beacon_mon_iter, phy);
+}
+EXPORT_SYMBOL_GPL(mt76_beacon_mon_check);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 0e6be1d0dffa..6dbd0bcbd1fe 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -367,6 +367,7 @@ enum mt76_wcid_flags {
 };
 
 #define MT76_N_WCIDS 1088
+#define MT76_BEACON_MON_MAX_MISS	7
 
 /* stored in ieee80211_tx_info::hw_queue */
 #define MT_TX_HW_QUEUE_PHY		GENMASK(3, 2)
@@ -836,6 +837,8 @@ struct mt76_vif_link {
 	u8 mcast_rates_idx;
 	u8 beacon_rates_idx;
 	bool offchannel;
+	unsigned long beacon_mon_last;
+	u16 beacon_mon_interval;
 	struct ieee80211_chanctx_conf *ctx;
 	struct mt76_wcid *wcid;
 	struct mt76_vif_data *mvif;
@@ -1608,6 +1611,8 @@ int mt76_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		 struct ieee80211_scan_request *hw_req);
 void mt76_cancel_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
 void mt76_scan_rx_beacon(struct mt76_dev *dev, struct ieee80211_channel *chan);
+void mt76_rx_beacon(struct mt76_phy *phy, struct sk_buff *skb);
+void mt76_beacon_mon_check(struct mt76_phy *phy);
 void mt76_sw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		  const u8 *mac);
 void mt76_sw_scan_complete(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index ae7ce19a4d9b..ef31452d63ab 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -515,9 +515,6 @@ mt7996_mac_fill_rx(struct mt7996_dev *dev, enum mt76_rxq_id q,
 		qos_ctl = FIELD_GET(MT_RXD10_QOS_CTL, v2);
 		seq_ctrl = FIELD_GET(MT_RXD10_SEQ_CTRL, v2);
 
-		if (ieee80211_is_beacon(fc))
-			mt76_scan_rx_beacon(&dev->mt76, mphy->chandef.chan);
-
 		rxd += 4;
 		if ((u8 *)rxd - skb->data >= skb->len)
 			return -EINVAL;
@@ -664,6 +661,8 @@ mt7996_mac_fill_rx(struct mt7996_dev *dev, enum mt76_rxq_id q,
 
 		hdr = mt76_skb_get_hdr(skb);
 		fc = hdr->frame_control;
+		if (ieee80211_is_beacon(fc))
+			mt76_rx_beacon(mphy, skb);
 		if (ieee80211_is_data_qos(fc)) {
 			u8 *qos = ieee80211_get_qos_ctl(hdr);
 
@@ -2944,6 +2943,7 @@ void mt7996_mac_work(struct work_struct *work)
 
 	mutex_unlock(&mphy->dev->mutex);
 
+	mt76_beacon_mon_check(mphy);
 	mt76_tx_status_check(mphy->dev, false);
 
 	ieee80211_queue_delayed_work(mphy->hw, &mphy->mac_work,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index e1e51c9a0767..73ac230afde9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -376,6 +376,17 @@ int mt7996_vif_link_add(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 		mvif->mt76.deflink_id = link_conf->link_id;
 	}
 
+	if (vif->type == NL80211_IFTYPE_STATION) {
+		vif->driver_flags |= IEEE80211_VIF_BEACON_FILTER;
+
+		if (vif->cfg.assoc && link_conf->beacon_int) {
+			mlink->beacon_mon_interval =
+				msecs_to_jiffies(ieee80211_tu_to_usec(
+					link_conf->beacon_int) / 1000);
+			WRITE_ONCE(mlink->beacon_mon_last, jiffies);
+		}
+	}
+
 	return 0;
 }
 
@@ -831,6 +842,13 @@ mt7996_vif_cfg_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			if (!link)
 				continue;
 
+			if (vif->type == NL80211_IFTYPE_STATION) {
+				link->mt76.beacon_mon_interval =
+					msecs_to_jiffies(ieee80211_tu_to_usec(
+						link_conf->beacon_int) / 1000);
+				WRITE_ONCE(link->mt76.beacon_mon_last, jiffies);
+			}
+
 			if (!link->phy)
 				continue;
 
@@ -843,6 +861,20 @@ mt7996_vif_cfg_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		}
 	}
 
+	if ((changed & BSS_CHANGED_ASSOC) && !vif->cfg.assoc &&
+	    vif->type == NL80211_IFTYPE_STATION) {
+		struct ieee80211_bss_conf *link_conf;
+		unsigned long link_id;
+
+		for_each_vif_active_link(vif, link_conf, link_id) {
+			struct mt7996_vif_link *link;
+
+			link = mt7996_vif_link(dev, vif, link_id);
+			if (link)
+				link->mt76.beacon_mon_interval = 0;
+		}
+	}
+
 	mutex_unlock(&dev->mt76.mutex);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/scan.c b/drivers/net/wireless/mediatek/mt76/scan.c
index 04cf8a01f20d..fbc10c9657cf 100644
--- a/drivers/net/wireless/mediatek/mt76/scan.c
+++ b/drivers/net/wireless/mediatek/mt76/scan.c
@@ -105,7 +105,6 @@ void mt76_scan_rx_beacon(struct mt76_dev *dev, struct ieee80211_channel *chan)
 out:
 	spin_unlock(&dev->scan_lock);
 }
-EXPORT_SYMBOL_GPL(mt76_scan_rx_beacon);
 
 void mt76_scan_work(struct work_struct *work)
 {
-- 
2.51.0


