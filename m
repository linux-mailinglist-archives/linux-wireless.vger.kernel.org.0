Return-Path: <linux-wireless+bounces-32739-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFojM+BjrmlbCwIAu9opvQ
	(envelope-from <linux-wireless+bounces-32739-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 07:08:32 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A1023419E
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 07:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF388303FFD5
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2026 06:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332CA3537FA;
	Mon,  9 Mar 2026 06:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="HP12uRCl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B206C34F48D
	for <linux-wireless@vger.kernel.org>; Mon,  9 Mar 2026 06:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773036466; cv=none; b=YLkJ8d0vc35tNnxc3f3HM5rfoATtfBaTE0S1fP56IURsglvrbITk1q9qMYp4RwUpOkEun/ODST5q7M3vqwNUSwMDaElAT3yQFs4mRC0rWb/CufT1603PDUkd+YvCN47dS/o5+ghuoXWmVPG7clnvXbCH+/iHJoZdnEftCNLuZ2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773036466; c=relaxed/simple;
	bh=cP7JFXRY6S0Xa7b4SGvfo5vhYLNUrbO5ksNC52nDMPM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZuF7uEtjTrJL86hZ0j5lmeL4BKtJ19+OXYLe9WXrD+wruN0bJrFLGnNyNET+OJJUJ4d4aSYjhOJuvTAZkRCm0HYUySSn7KlOuWPFHTpXal76Ip5z7zoyGANNBshhzkHqF0vIzKaZO1AJdSlNIUa8LZpkZ/qWgN02PhKFzMdAAH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=pass smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=HP12uRCl; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=TOYqq167cP0xoGc2kzerVbhS4KQUbhHFQ/7PC28fx1Q=; b=HP12uRClMLeWjKvaPkQ5BnPXpd
	zkYaDFEaIWm/+ICV9Ak45nVlP8JCmC+hWiqOy+XkmQ9WYmh7l+l2s7FOieiINJxNiwd2XhmgkFVyI
	NKoJ7vuDNFMEr6xgsrD8eXP5QtByGPdDLLblNNiy/vdvn4aEHpbALCqvHQrX2sz+BPQs=;
Received: from p200300cadf236500000000000000085c.dip0.t-ipconnect.de ([2003:ca:df23:6500::85c] helo=max)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1vzTmD-00GH43-0d
	for linux-wireless@vger.kernel.org;
	Mon, 09 Mar 2026 07:07:37 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH mt76 07/11] wifi: mt76: send nullfunc PS frames on offchannel transitions
Date: Mon,  9 Mar 2026 06:07:26 +0000
Message-ID: <20260309060730.87840-7-nbd@nbd.name>
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
X-Rspamd-Queue-Id: 75A1023419E
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
	TAGGED_FROM(0.00)[bounces-32739-lists,linux-wireless=lfdr.de];
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

Since mt76 uses chanctx, mac80211 does not send nullfunc power save
notifications when the driver goes offchannel for scan or ROC.
Add mt76_offchannel_notify() to send nullfunc PM=1 before going
offchannel and PM=0 after returning, so that the AP can buffer
frames during the absence.

For MLO, iterate all vif links on the phy and set
IEEE80211_TX_CTRL_MLO_LINK so that the driver's tx_prepare_skb
resolves the correct per-link wcid.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/channel.c  |  12 ++-
 drivers/net/wireless/mediatek/mt76/mac80211.c | 101 ++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h     |   1 +
 drivers/net/wireless/mediatek/mt76/scan.c     |   7 +-
 4 files changed, 117 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/channel.c b/drivers/net/wireless/mediatek/mt76/channel.c
index f42f25101544..3072e11e2688 100644
--- a/drivers/net/wireless/mediatek/mt76/channel.c
+++ b/drivers/net/wireless/mediatek/mt76/channel.c
@@ -328,8 +328,10 @@ void mt76_roc_complete(struct mt76_phy *phy)
 	if (mlink)
 		mlink->mvif->roc_phy = NULL;
 	if (phy->chanctx && phy->main_chandef.chan && phy->offchannel &&
-	    !test_bit(MT76_MCU_RESET, &dev->phy.state))
+	    !test_bit(MT76_MCU_RESET, &dev->phy.state)) {
 		__mt76_set_channel(phy, &phy->main_chandef, false);
+		mt76_offchannel_notify(phy, false);
+	}
 	mt76_put_vif_phy_link(phy, phy->roc_vif, phy->roc_link);
 	phy->roc_vif = NULL;
 	phy->roc_link = NULL;
@@ -367,6 +369,7 @@ int mt76_remain_on_channel(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct mt76_phy *phy = hw->priv;
 	struct mt76_dev *dev = phy->dev;
 	struct mt76_vif_link *mlink;
+	bool offchannel;
 	int ret = 0;
 
 	phy = dev->band_phys[chan->band];
@@ -392,8 +395,11 @@ int mt76_remain_on_channel(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	mlink->mvif->roc_phy = phy;
 	phy->roc_vif = vif;
 	phy->roc_link = mlink;
-	ret = __mt76_set_channel(phy, &chandef,
-				 mt76_offchannel_chandef(phy, chan, &chandef));
+
+	offchannel = mt76_offchannel_chandef(phy, chan, &chandef);
+	if (offchannel)
+		mt76_offchannel_notify(phy, true);
+	ret = __mt76_set_channel(phy, &chandef, offchannel);
 	if (ret) {
 		mlink->mvif->roc_phy = NULL;
 		phy->roc_vif = NULL;
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 3c539c263238..e6315d35c683 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -2132,3 +2132,104 @@ u16 mt76_select_links(struct ieee80211_vif *vif, int max_active_links)
 	return sel_links;
 }
 EXPORT_SYMBOL_GPL(mt76_select_links);
+
+struct mt76_offchannel_cb_data {
+	struct mt76_phy *phy;
+	bool offchannel;
+};
+
+static void
+mt76_offchannel_send_nullfunc(struct mt76_offchannel_cb_data *data,
+			      struct ieee80211_vif *vif, int link_id)
+{
+	struct mt76_phy *phy = data->phy;
+	struct ieee80211_tx_info *info;
+	struct ieee80211_sta *sta = NULL;
+	struct ieee80211_hdr *hdr;
+	struct mt76_wcid *wcid;
+	struct sk_buff *skb;
+
+	skb = ieee80211_nullfunc_get(phy->hw, vif, link_id, true);
+	if (!skb)
+		return;
+
+	hdr = (struct ieee80211_hdr *)skb->data;
+	if (data->offchannel)
+		hdr->frame_control |= cpu_to_le16(IEEE80211_FCTL_PM);
+
+	skb->priority = 7;
+	skb_set_queue_mapping(skb, IEEE80211_AC_VO);
+
+	if (!ieee80211_tx_prepare_skb(phy->hw, vif, skb,
+				      phy->main_chandef.chan->band,
+				      &sta)) {
+		ieee80211_free_txskb(phy->hw, skb);
+		return;
+	}
+
+	if (sta)
+		wcid = (struct mt76_wcid *)sta->drv_priv;
+	else
+		wcid = ((struct mt76_vif_link *)vif->drv_priv)->wcid;
+
+	if (link_id >= 0) {
+		info = IEEE80211_SKB_CB(skb);
+		info->control.flags &= ~IEEE80211_TX_CTRL_MLO_LINK;
+		info->control.flags |=
+			u32_encode_bits(link_id, IEEE80211_TX_CTRL_MLO_LINK);
+	}
+
+	mt76_tx(phy, sta, wcid, skb);
+}
+
+static void
+mt76_offchannel_notify_iter(void *_data, u8 *mac, struct ieee80211_vif *vif)
+{
+	struct mt76_offchannel_cb_data *data = _data;
+	struct mt76_vif_link *mlink;
+	struct mt76_vif_data *mvif;
+	int link_id;
+
+	if (vif->type != NL80211_IFTYPE_STATION || !vif->cfg.assoc)
+		return;
+
+	mlink = (struct mt76_vif_link *)vif->drv_priv;
+	mvif = mlink->mvif;
+
+	if (!ieee80211_vif_is_mld(vif)) {
+		if (mt76_vif_link_phy(mlink) == data->phy)
+			mt76_offchannel_send_nullfunc(data, vif, -1);
+		return;
+	}
+
+	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
+		if (link_id == mvif->deflink_id)
+			mlink = (struct mt76_vif_link *)vif->drv_priv;
+		else
+			mlink = rcu_dereference(mvif->link[link_id]);
+		if (!mlink)
+			continue;
+		if (mt76_vif_link_phy(mlink) != data->phy)
+			continue;
+
+		mt76_offchannel_send_nullfunc(data, vif, link_id);
+	}
+}
+
+void mt76_offchannel_notify(struct mt76_phy *phy, bool offchannel)
+{
+	struct mt76_offchannel_cb_data data = {
+		.phy = phy,
+		.offchannel = offchannel,
+	};
+
+	if (!phy->num_sta)
+		return;
+
+	local_bh_disable();
+	ieee80211_iterate_active_interfaces_atomic(phy->hw,
+		IEEE80211_IFACE_ITER_NORMAL,
+		mt76_offchannel_notify_iter, &data);
+	local_bh_enable();
+}
+EXPORT_SYMBOL_GPL(mt76_offchannel_notify);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index fe1c50af460c..bafbc1747673 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1816,6 +1816,7 @@ struct mt76_vif_link *mt76_get_vif_phy_link(struct mt76_phy *phy,
 					    struct ieee80211_vif *vif);
 void mt76_put_vif_phy_link(struct mt76_phy *phy, struct ieee80211_vif *vif,
 			   struct mt76_vif_link *mlink);
+void mt76_offchannel_notify(struct mt76_phy *phy, bool offchannel);
 
 /* usb */
 static inline bool mt76u_urb_error(struct urb *urb)
diff --git a/drivers/net/wireless/mediatek/mt76/scan.c b/drivers/net/wireless/mediatek/mt76/scan.c
index 5a67e9b8183a..04cf8a01f20d 100644
--- a/drivers/net/wireless/mediatek/mt76/scan.c
+++ b/drivers/net/wireless/mediatek/mt76/scan.c
@@ -17,8 +17,10 @@ static void mt76_scan_complete(struct mt76_dev *dev, bool abort)
 	clear_bit(MT76_SCANNING, &phy->state);
 
 	if (dev->scan.chan && phy->main_chandef.chan && phy->offchannel &&
-	    !test_bit(MT76_MCU_RESET, &dev->phy.state))
+	    !test_bit(MT76_MCU_RESET, &dev->phy.state)) {
 		mt76_set_channel(phy, &phy->main_chandef, false);
+		mt76_offchannel_notify(phy, false);
+	}
 	mt76_put_vif_phy_link(phy, dev->scan.vif, dev->scan.mlink);
 	memset(&dev->scan, 0, sizeof(dev->scan));
 	if (!test_bit(MT76_MCU_RESET, &dev->phy.state))
@@ -135,12 +137,15 @@ void mt76_scan_work(struct work_struct *work)
 	if (dev->scan.chan && phy->num_sta && phy->offchannel) {
 		dev->scan.chan = NULL;
 		mt76_set_channel(phy, &phy->main_chandef, false);
+		mt76_offchannel_notify(phy, false);
 		goto out;
 	}
 
 	dev->scan.chan = req->channels[dev->scan.chan_idx++];
 	offchannel = mt76_offchannel_chandef(phy, dev->scan.chan, &chandef);
 
+	if (offchannel)
+		mt76_offchannel_notify(phy, true);
 	mt76_set_channel(phy, &chandef, offchannel);
 
 	if (!req->n_ssids)
-- 
2.51.0


