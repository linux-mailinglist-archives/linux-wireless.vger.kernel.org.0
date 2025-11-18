Return-Path: <linux-wireless+bounces-29097-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B9EC68EC0
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 11:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8ABCD4F15A0
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 10:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E60320CA4;
	Tue, 18 Nov 2025 10:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="avjvREQw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A6C2EACEF
	for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 10:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763463167; cv=none; b=WnWnWy9HC7zo5StRNLHLiHZeUiyY4QoOYVsrFdX7G97edM5sRkVGdapNc52xBw/gnLcFeWa2/3GGsBnlUors56uT7apRSS3GkSQPr6aHjlFYUKM+FBZp1hydeydhhcHCIWuh1jmV5Se+TzGGf3DiqfHekt1IgwxgY3LyjRUA7J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763463167; c=relaxed/simple;
	bh=oiMqFLWoPNX7cGvuqUZaXEIaaFrAqTER6uEpSclbQ6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pcn7U5Lc/kqrKJp5+9PTZzvwIWjdk5hWTLK1jDpjjRIOTMxSTt7hUCw+5sMtiYZPxXmRk1mYwVYF14lxw4R452mbNtLPjJEgeCIW2ICUtlrowD+sCcS5ZzWO3IxjeCeLCqYNUK96AFJB0vsU/LP3mY3EK0zfQ/tjVRXJR7DOjE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=avjvREQw; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=5sAcxymm3e/Hx3IiRUa2sWzl2RuK2NaEjL2oF0VYsYA=; b=avjvREQwB0rVbKUR0WOoMDxRB3
	gSV+PtIpwIq3XXrzyCX33/Uk+b6uLEEZ9WrUwDpJwtBpDwYIE/3lWRHulAQW6inYDiZx43sI1TM4q
	pAjVE6F5fvhpvu6GZ1BCnfiI7+cMSVFQ9tLKKGAyVXXRZHqVIs2IU/Kwsv6hpZ9dBwvQ=;
Received: from p5b206646.dip0.t-ipconnect.de ([91.32.102.70] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1vLIvk-005In0-1U;
	Tue, 18 Nov 2025 11:27:24 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: Chad Monroe <chad@monroe.io>,
	Piotr Kubik <piotr.kubik@adtran.com>
Subject: [PATCH 2/2] wifi: mt76: support upgrading passive scans to active
Date: Tue, 18 Nov 2025 11:27:23 +0100
Message-ID: <20251118102723.47997-2-nbd@nbd.name>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251118102723.47997-1-nbd@nbd.name>
References: <20251118102723.47997-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chad Monroe <chad@monroe.io>

On channels with NO_IR or RADAR flags, wait for beacon before sending
probe requests. Allows active scanning and WPS on restricted channels
if another AP is already present.

Fixes: c56d6edebc1f ("wifi: mt76: mt7996: use emulated hardware scan support")
Tested-by: Piotr Kubik <piotr.kubik@adtran.com>
Signed-off-by: Chad Monroe <chad@monroe.io>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  3 ++
 .../net/wireless/mediatek/mt76/mt7996/mac.c   |  3 ++
 drivers/net/wireless/mediatek/mt76/scan.c     | 34 +++++++++++++++++--
 3 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 0c067b14a900..8125d9fd11fb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1012,6 +1012,8 @@ struct mt76_dev {
 		struct mt76_vif_link *mlink;
 		struct mt76_phy *phy;
 		int chan_idx;
+		bool beacon_wait;
+		bool beacon_received;
 	} scan;
 
 #ifdef CONFIG_NL80211_TESTMODE
@@ -1599,6 +1601,7 @@ int mt76_get_rate(struct mt76_dev *dev,
 int mt76_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		 struct ieee80211_scan_request *hw_req);
 void mt76_cancel_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
+void mt76_scan_rx_beacon(struct mt76_dev *dev, struct ieee80211_channel *chan);
 void mt76_sw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		  const u8 *mac);
 void mt76_sw_scan_complete(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 2560e2f46e89..11cbcf82460e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -554,6 +554,9 @@ mt7996_mac_fill_rx(struct mt7996_dev *dev, enum mt76_rxq_id q,
 		qos_ctl = FIELD_GET(MT_RXD10_QOS_CTL, v2);
 		seq_ctrl = FIELD_GET(MT_RXD10_SEQ_CTRL, v2);
 
+		if (ieee80211_is_beacon(fc))
+			mt76_scan_rx_beacon(&dev->mt76, mphy->chandef.chan);
+
 		rxd += 4;
 		if ((u8 *)rxd - skb->data >= skb->len)
 			return -EINVAL;
diff --git a/drivers/net/wireless/mediatek/mt76/scan.c b/drivers/net/wireless/mediatek/mt76/scan.c
index 0b1922f7792e..5746aeb3e608 100644
--- a/drivers/net/wireless/mediatek/mt76/scan.c
+++ b/drivers/net/wireless/mediatek/mt76/scan.c
@@ -79,6 +79,23 @@ mt76_scan_send_probe(struct mt76_dev *dev, struct cfg80211_ssid *ssid)
 	rcu_read_unlock();
 }
 
+void mt76_scan_rx_beacon(struct mt76_dev *dev, struct ieee80211_channel *chan)
+{
+	struct mt76_phy *phy;
+
+	if (!dev->scan.beacon_wait || dev->scan.beacon_received ||
+	    dev->scan.chan != chan)
+		return;
+
+	phy = dev->scan.phy;
+	if (!phy)
+		return;
+
+	dev->scan.beacon_received = true;
+	ieee80211_queue_delayed_work(phy->hw, &dev->scan_work, 0);
+}
+EXPORT_SYMBOL_GPL(mt76_scan_rx_beacon);
+
 void mt76_scan_work(struct work_struct *work)
 {
 	struct mt76_dev *dev = container_of(work, struct mt76_dev,
@@ -87,8 +104,15 @@ void mt76_scan_work(struct work_struct *work)
 	struct cfg80211_chan_def chandef = {};
 	struct mt76_phy *phy = dev->scan.phy;
 	int duration = HZ / 9; /* ~110 ms */
+	bool beacon_rx;
 	int i;
 
+	beacon_rx = dev->scan.beacon_wait && dev->scan.beacon_received;
+	dev->scan.beacon_wait = false;
+
+	if (beacon_rx)
+		goto probe;
+
 	if (dev->scan.chan_idx >= req->n_channels) {
 		mt76_scan_complete(dev, false);
 		return;
@@ -105,10 +129,16 @@ void mt76_scan_work(struct work_struct *work)
 	if (dev->scan.chan != phy->main_chandef.chan)
 		mt76_set_channel(phy, &chandef, true);
 
-	if (!req->n_ssids ||
-	    chandef.chan->flags & (IEEE80211_CHAN_NO_IR | IEEE80211_CHAN_RADAR))
+	if (!req->n_ssids)
 		goto out;
 
+	if (chandef.chan->flags & (IEEE80211_CHAN_NO_IR | IEEE80211_CHAN_RADAR)) {
+		dev->scan.beacon_received = false;
+		dev->scan.beacon_wait = true;
+		goto out;
+	}
+
+probe:
 	if (phy->offchannel)
 		duration = HZ / 16; /* ~60 ms */
 	local_bh_disable();
-- 
2.51.0


