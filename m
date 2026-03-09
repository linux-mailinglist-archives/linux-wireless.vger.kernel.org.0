Return-Path: <linux-wireless+bounces-32735-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOMMC8FjrmlbCwIAu9opvQ
	(envelope-from <linux-wireless+bounces-32735-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 07:08:01 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A10EF234182
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 07:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDB613033F90
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2026 06:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E8634F470;
	Mon,  9 Mar 2026 06:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="EeKWQiqe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A02934E75D
	for <linux-wireless@vger.kernel.org>; Mon,  9 Mar 2026 06:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773036464; cv=none; b=CEvGTC1XUAr4MLBQlpiJ99jBa45KDlpFJ0FXmCwPGO26oiiTzdw4yYRNe3bWN/HchsDrKV+8Jq0Hkbk6tlDU7AO0lmmoGTjzhgKCNKxb6iPJWvO+xCSbQ2vqXtpSDzRz6hf5yzTY3t8/gI+mj1BV/NkopJmSjGA/Cc8SK4cSdgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773036464; c=relaxed/simple;
	bh=ElAXnKP67POoMr/UTdBDacQSdxLIHJ65KlcrT2eAJlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHGQ/li0yG4CJH7Xv1VTWTxNdt5rdfLy2p7M43DP87rV4pstKExWC2AL7/vDv745xalWZsdA4zOq4P58ixbudTOzghtUjgwLKbg9k34upfrXBgS1dk+PQnsAVozCIVBgFcPu5Gq21/2AXIrmHx0FW3C9WRyrDSz4rnVjb9j6UpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=pass smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=EeKWQiqe; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=NUzUh/5P3Fc2mGuAWypctAhr7zdF56s3yLo9rQ53p5g=; b=EeKWQiqeeurrpgCI/Y7VX5k/UB
	77FMtbICIQtSXEHJi6kK7fDAlc221xVzOm/gwhZ4QJWWFEy42YuCj6YzIje6BgzJMT6WYacMOAaMo
	v3A+l1cEudf2myqtpPwvWUAk8lDBE5LNsAFK3lX3jCaJboOLbDjitJV7PwCsHfjda9j8=;
Received: from p200300cadf236500000000000000085c.dip0.t-ipconnect.de ([2003:ca:df23:6500::85c] helo=max)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1vzTmB-00GH43-1Q;
	Mon, 09 Mar 2026 07:07:35 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: Chad Monroe <chad@monroe.io>,
	Piotr Kubik <piotr.kubik@adtran.com>
Subject: [PATCH mt76 02/11] wifi: mt76: support upgrading passive scans to active
Date: Mon,  9 Mar 2026 06:07:21 +0000
Message-ID: <20260309060730.87840-2-nbd@nbd.name>
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
X-Rspamd-Queue-Id: A10EF234182
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[nbd.name:s=20160729];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nbd.name : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32735-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[nbd@nbd.name,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nbd.name:-];
	NEURAL_HAM(-0.00)[-0.166];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nbd.name:mid,nbd.name:email]
X-Rspamd-Action: no action

From: Chad Monroe <chad@monroe.io>

On channels with NO_IR or RADAR flags, wait for beacon before sending
probe requests. Allows active scanning and WPS on restricted channels
if another AP is already present.

Fixes: c56d6edebc1f ("wifi: mt76: mt7996: use emulated hardware scan support")
Tested-by: Piotr Kubik <piotr.kubik@adtran.com>
Signed-off-by: Chad Monroe <chad@monroe.io>
Link: https://patch.msgid.link/20251118102723.47997-2-nbd@nbd.name
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c |  1 +
 drivers/net/wireless/mediatek/mt76/mt76.h     |  4 ++
 .../net/wireless/mediatek/mt76/mt7996/mac.c   |  3 ++
 drivers/net/wireless/mediatek/mt76/scan.c     | 51 +++++++++++++++++--
 4 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index d0c522909e98..3c539c263238 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -726,6 +726,7 @@ mt76_alloc_device(struct device *pdev, unsigned int size,
 	INIT_LIST_HEAD(&dev->rxwi_cache);
 	dev->token_size = dev->drv->token_size;
 	INIT_DELAYED_WORK(&dev->scan_work, mt76_scan_work);
+	spin_lock_init(&dev->scan_lock);
 
 	for (i = 0; i < ARRAY_SIZE(dev->q_rx); i++)
 		skb_queue_head_init(&dev->rx_skb[i]);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 7f6f075b3088..efb57a0d8965 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1006,6 +1006,7 @@ struct mt76_dev {
 	u32 rxfilter;
 
 	struct delayed_work scan_work;
+	spinlock_t scan_lock;
 	struct {
 		struct cfg80211_scan_request *req;
 		struct ieee80211_channel *chan;
@@ -1013,6 +1014,8 @@ struct mt76_dev {
 		struct mt76_vif_link *mlink;
 		struct mt76_phy *phy;
 		int chan_idx;
+		bool beacon_wait;
+		bool beacon_received;
 	} scan;
 
 #ifdef CONFIG_NL80211_TESTMODE
@@ -1600,6 +1603,7 @@ int mt76_get_rate(struct mt76_dev *dev,
 int mt76_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		 struct ieee80211_scan_request *hw_req);
 void mt76_cancel_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
+void mt76_scan_rx_beacon(struct mt76_dev *dev, struct ieee80211_channel *chan);
 void mt76_sw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		  const u8 *mac);
 void mt76_sw_scan_complete(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index a415cc610eee..ed9ada53f8e5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -515,6 +515,9 @@ mt7996_mac_fill_rx(struct mt7996_dev *dev, enum mt76_rxq_id q,
 		qos_ctl = FIELD_GET(MT_RXD10_QOS_CTL, v2);
 		seq_ctrl = FIELD_GET(MT_RXD10_SEQ_CTRL, v2);
 
+		if (ieee80211_is_beacon(fc))
+			mt76_scan_rx_beacon(&dev->mt76, mphy->chandef.chan);
+
 		rxd += 4;
 		if ((u8 *)rxd - skb->data >= skb->len)
 			return -EINVAL;
diff --git a/drivers/net/wireless/mediatek/mt76/scan.c b/drivers/net/wireless/mediatek/mt76/scan.c
index 89f16c23e352..2b5f30cef795 100644
--- a/drivers/net/wireless/mediatek/mt76/scan.c
+++ b/drivers/net/wireless/mediatek/mt76/scan.c
@@ -27,6 +27,10 @@ static void mt76_scan_complete(struct mt76_dev *dev, bool abort)
 
 void mt76_abort_scan(struct mt76_dev *dev)
 {
+	spin_lock_bh(&dev->scan_lock);
+	dev->scan.beacon_wait = false;
+	spin_unlock_bh(&dev->scan_lock);
+
 	cancel_delayed_work_sync(&dev->scan_work);
 	mt76_scan_complete(dev, true);
 }
@@ -79,6 +83,28 @@ mt76_scan_send_probe(struct mt76_dev *dev, struct cfg80211_ssid *ssid)
 	rcu_read_unlock();
 }
 
+void mt76_scan_rx_beacon(struct mt76_dev *dev, struct ieee80211_channel *chan)
+{
+	struct mt76_phy *phy;
+
+	spin_lock(&dev->scan_lock);
+
+	if (!dev->scan.beacon_wait || dev->scan.beacon_received ||
+	    dev->scan.chan != chan)
+		goto out;
+
+	phy = dev->scan.phy;
+	if (!phy)
+		goto out;
+
+	dev->scan.beacon_received = true;
+	ieee80211_queue_delayed_work(phy->hw, &dev->scan_work, 0);
+
+out:
+	spin_unlock(&dev->scan_lock);
+}
+EXPORT_SYMBOL_GPL(mt76_scan_rx_beacon);
+
 void mt76_scan_work(struct work_struct *work)
 {
 	struct mt76_dev *dev = container_of(work, struct mt76_dev,
@@ -87,9 +113,20 @@ void mt76_scan_work(struct work_struct *work)
 	struct cfg80211_chan_def chandef = {};
 	struct mt76_phy *phy = dev->scan.phy;
 	int duration = HZ / 9; /* ~110 ms */
-	bool offchannel = true;
+	bool beacon_rx, offchannel = true;
 	int i;
 
+	if (!phy || !req)
+		return;
+
+	spin_lock_bh(&dev->scan_lock);
+	beacon_rx = dev->scan.beacon_wait && dev->scan.beacon_received;
+	dev->scan.beacon_wait = false;
+	spin_unlock_bh(&dev->scan_lock);
+
+	if (beacon_rx)
+		goto probe;
+
 	if (dev->scan.chan_idx >= req->n_channels) {
 		mt76_scan_complete(dev, false);
 		return;
@@ -110,10 +147,18 @@ void mt76_scan_work(struct work_struct *work)
 
 	mt76_set_channel(phy, &chandef, offchannel);
 
-	if (!req->n_ssids ||
-	    chandef.chan->flags & (IEEE80211_CHAN_NO_IR | IEEE80211_CHAN_RADAR))
+	if (!req->n_ssids)
 		goto out;
 
+	if (chandef.chan->flags & (IEEE80211_CHAN_NO_IR | IEEE80211_CHAN_RADAR)) {
+		spin_lock_bh(&dev->scan_lock);
+		dev->scan.beacon_received = false;
+		dev->scan.beacon_wait = true;
+		spin_unlock_bh(&dev->scan_lock);
+		goto out;
+	}
+
+probe:
 	if (phy->offchannel)
 		duration = HZ / 16; /* ~60 ms */
 	local_bh_disable();
-- 
2.51.0


