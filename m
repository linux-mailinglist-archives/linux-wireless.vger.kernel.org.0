Return-Path: <linux-wireless+bounces-33229-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKCfMlIGtWlkvgAAu9opvQ
	(envelope-from <linux-wireless+bounces-33229-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Mar 2026 07:55:14 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DD24E28BE3A
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Mar 2026 07:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 18E8130086A4
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Mar 2026 06:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC6C19C540;
	Sat, 14 Mar 2026 06:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="JnDAHANl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF90D4594A
	for <linux-wireless@vger.kernel.org>; Sat, 14 Mar 2026 06:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773471309; cv=none; b=GsOHIVokAUxNweJQ1NWjFsd9HtKyPUclh7YgdldREA3HU4AlWweyUJmu3j8TrbBuo22YtUFALamNmXwXU8psfInCV5g3C3RYSrmoUDv+ZNKSIdQ2Mh6Jo1M5sMAbB33ZXN1yAaH/ftL2dcOoQybHSRGxPpqW324SwuO3BoaezIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773471309; c=relaxed/simple;
	bh=ntdPp+3cGWEdptTwKKkReS6Nl1J3zoPh4dDLdUOjHC0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BeE3pDIFbcRUVady9u5vxuam92QJdIYKQaqsYnGocIQxOiqqsLYDj7Cqhv37tMVrk3wnvXeIitOGFe8aiJLB2ieMBZhznEtBIKhYb96BtO8DKIxNqTwnhPLsSQaMdS5kZ4YrhuMuZcnbiBa24PtP0N+ESfKpdeYlLo6d25mHXfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=pass smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=JnDAHANl; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=L++PGcmVAAWZBBO+Ko6jfE/m3ta2SWl1WvFFBuVxvLQ=; b=JnDAHANlQvOGRQQJtI+A0MtiEv
	355gojCSVpOeRjZqH/AFSQ+0xBkMUsdNXdG0yMaqB1Hjxaw0jZ9TJKKOahDRq0BAu99f/Xg5oD+Ch
	ZvUEi/itDy7uC/A1FIQuksCu7RpvmrlfcbBBVTVUOrEVzxEDgga8md2VKMSdJ/80BHgs=;
Received: from p200300cadf236500000000000000085c.dip0.t-ipconnect.de ([2003:ca:df23:6500::85c] helo=max)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1w1Ito-002jTo-18;
	Sat, 14 Mar 2026 07:55:00 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH wireless] wifi: mac80211: always free skb on ieee80211_tx_prepare_skb() failure
Date: Sat, 14 Mar 2026 06:54:55 +0000
Message-ID: <20260314065455.2462900-1-nbd@nbd.name>
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
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nbd.name : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33229-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nbd@nbd.name,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.881];
	DKIM_TRACE(0.00)[nbd.name:-];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nbd.name:email,nbd.name:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DD24E28BE3A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ieee80211_tx_prepare_skb() has three error paths, but only two of them
free the skb. The first error path (ieee80211_tx_prepare() returning
TX_DROP) does not free it, while invoke_tx_handlers() failure and the
fragmentation check both do.

Add kfree_skb() to the first error path so all three are consistent,
and remove the now-redundant frees in callers (ath9k, mt76,
mac80211_hwsim) to avoid double-free.

Document the skb ownership guarantee in the function's kdoc.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/ath/ath9k/channel.c      | 6 ++----
 drivers/net/wireless/mediatek/mt76/scan.c     | 4 +---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 1 -
 include/net/mac80211.h                        | 4 +++-
 net/mac80211/tx.c                             | 4 +++-
 5 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/channel.c b/drivers/net/wireless/ath/ath9k/channel.c
index 121e51ce1bc0..8b27d8cc086a 100644
--- a/drivers/net/wireless/ath/ath9k/channel.c
+++ b/drivers/net/wireless/ath/ath9k/channel.c
@@ -1006,7 +1006,7 @@ static void ath_scan_send_probe(struct ath_softc *sc,
 	skb_set_queue_mapping(skb, IEEE80211_AC_VO);
 
 	if (!ieee80211_tx_prepare_skb(sc->hw, vif, skb, band, NULL))
-		goto error;
+		return;
 
 	txctl.txq = sc->tx.txq_map[IEEE80211_AC_VO];
 	if (ath_tx_start(sc->hw, skb, &txctl))
@@ -1119,10 +1119,8 @@ ath_chanctx_send_vif_ps_frame(struct ath_softc *sc, struct ath_vif *avp,
 
 		skb->priority = 7;
 		skb_set_queue_mapping(skb, IEEE80211_AC_VO);
-		if (!ieee80211_tx_prepare_skb(sc->hw, vif, skb, band, &sta)) {
-			dev_kfree_skb_any(skb);
+		if (!ieee80211_tx_prepare_skb(sc->hw, vif, skb, band, &sta))
 			return false;
-		}
 		break;
 	default:
 		return false;
diff --git a/drivers/net/wireless/mediatek/mt76/scan.c b/drivers/net/wireless/mediatek/mt76/scan.c
index ff9176cdee3d..63b0447e55c1 100644
--- a/drivers/net/wireless/mediatek/mt76/scan.c
+++ b/drivers/net/wireless/mediatek/mt76/scan.c
@@ -63,10 +63,8 @@ mt76_scan_send_probe(struct mt76_dev *dev, struct cfg80211_ssid *ssid)
 
 	rcu_read_lock();
 
-	if (!ieee80211_tx_prepare_skb(phy->hw, vif, skb, band, NULL)) {
-		ieee80211_free_txskb(phy->hw, skb);
+	if (!ieee80211_tx_prepare_skb(phy->hw, vif, skb, band, NULL))
 		goto out;
-	}
 
 	info = IEEE80211_SKB_CB(skb);
 	if (req->no_cck)
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 82adcc848189..721775d1426a 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -3157,7 +3157,6 @@ static void hw_scan_work(struct work_struct *work)
 						      hwsim->tmp_chan->band,
 						      NULL)) {
 				rcu_read_unlock();
-				kfree_skb(probe);
 				continue;
 			}
 
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 310546d4fca6..afe0bf29a9df 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -7411,7 +7411,9 @@ void ieee80211_report_wowlan_wakeup(struct ieee80211_vif *vif,
  * @band: the band to transmit on
  * @sta: optional pointer to get the station to send the frame to
  *
- * Return: %true if the skb was prepared, %false otherwise
+ * Return: %true if the skb was prepared, %false otherwise.
+ * On failure, the skb is freed by this function; callers must not
+ * free it again.
  *
  * Note: must be called under RCU lock
  */
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 04a3ea9beae5..d4527b19b48e 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1896,8 +1896,10 @@ bool ieee80211_tx_prepare_skb(struct ieee80211_hw *hw,
 	struct ieee80211_tx_data tx;
 	struct sk_buff *skb2;
 
-	if (ieee80211_tx_prepare(sdata, &tx, NULL, skb) == TX_DROP)
+	if (ieee80211_tx_prepare(sdata, &tx, NULL, skb) == TX_DROP) {
+		kfree_skb(skb);
 		return false;
+	}
 
 	info->band = band;
 	info->control.vif = vif;
-- 
2.51.0


