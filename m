Return-Path: <linux-wireless+bounces-35110-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEMiLKLk5mn01gEAu9opvQ
	(envelope-from <linux-wireless+bounces-35110-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 04:44:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C34435949
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 04:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 923F6301CFDC
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 02:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BCE288C34;
	Tue, 21 Apr 2026 02:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="S0QxaR/e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from n169-114.mail.139.com (n169-114.mail.139.com [120.232.169.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6AC28506C;
	Tue, 21 Apr 2026 02:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776739449; cv=none; b=O2wg3cQGNeMZSpeu9Rufok0Y6W2PFfauSDOWjeHWwQ3VVTIaRYXzAKFKP/xj3JtfRm1dWeuEvxEDXRnZNG7LBw3jzHbnb3aIHvU0M60zGC4PSo681WpnDzJMgdHTWPr3as5+n7C7s+Y3+XxjztTgjMMJZ7sDqcAZ2H6plAq9PGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776739449; c=relaxed/simple;
	bh=ihITWfqXfIkk0NFbWJBcLQXGoDTNPLYoU41UBKUhINU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BGoDaF5ESCI6YYscqu0mzHgZZ10yPAqujCsl/jrYwK5o9tX568cShpqQ6IRfxV6csela68jqzrUI+WB4AmOid6SFunnSezIPCHqvSZjR+/1c4XSS7AOUofwwZnwRNQyhIv07hoUOJejtFxdTvo/o7ACRFkZ41Ix1E/GO2xXa1BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=S0QxaR/e; arc=none smtp.client-ip=120.232.169.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=S0QxaR/eNJwnL3w8zyw75/l9Qj1R0GKAFiSP7qAcRyeNDm2nlsxruQcD5R/1EkmGIB9o8M15xfqCI
	 AUCXU3ogr+r78ism7oTxw9Ob73b6M7qabJ0xCA2cCrKS3Ww8EyIzqw5e6OR1giqihtIRBPcTfzrxxL
	 GgYdA2wZdRrDr5fw=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[60.247.85.88])
	by rmsmtp-lg-appmail-37-12051 (RichMail) with SMTP id 2f1369e6e472e59-03ea6;
	Tue, 21 Apr 2026 10:44:05 +0800 (CST)
X-RM-TRANSID:2f1369e6e472e59-03ea6
From: Li hongliang <1468888505@139.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	nbd@nbd.name
Cc: patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	toke@toke.dk,
	kvalo@kernel.org,
	johannes@sipsolutions.net,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	nbd@openwrt.org,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	johannes.berg@intel.com
Subject: [PATCH 5.15.y] wifi: mac80211: always free skb on ieee80211_tx_prepare_skb() failure
Date: Tue, 21 Apr 2026 10:44:03 +0800
Message-Id: <20260421024403.3132486-1-1468888505@139.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-35110-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,toke.dk,kernel.org,sipsolutions.net,gmail.com,collabora.com,openwrt.org,lists.infradead.org,intel.com];
	DMARC_NA(0.00)[139.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[139.com];
	FROM_NEQ_ENVFROM(0.00)[1468888505@139.com,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_SPAM(0.00)[0.180];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,nbd.name:email]
X-Rspamd-Queue-Id: 31C34435949
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit d5ad6ab61cbd89afdb60881f6274f74328af3ee9 ]

ieee80211_tx_prepare_skb() has three error paths, but only two of them
free the skb. The first error path (ieee80211_tx_prepare() returning
TX_DROP) does not free it, while invoke_tx_handlers() failure and the
fragmentation check both do.

Add kfree_skb() to the first error path so all three are consistent,
and remove the now-redundant frees in callers (ath9k, mt76,
mac80211_hwsim) to avoid double-free.

Document the skb ownership guarantee in the function's kdoc.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Link: https://patch.msgid.link/20260314065455.2462900-1-nbd@nbd.name
Fixes: 06be6b149f7e ("mac80211: add ieee80211_tx_prepare_skb() helper function")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
[ Exclude changes to drivers/net/wireless/mediatek/mt76/scan.c as this file is first
 introduced by commit 31083e38548f("wifi: mt76: add code for emulating hardware scanning")
 after linux-6.14.]
Signed-off-by: Li hongliang <1468888505@139.com>
---
 drivers/net/wireless/ath/ath9k/channel.c | 6 ++----
 drivers/net/wireless/mac80211_hwsim.c    | 1 -
 include/net/mac80211.h                   | 4 ++++
 net/mac80211/tx.c                        | 4 +++-
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/channel.c b/drivers/net/wireless/ath/ath9k/channel.c
index 6cf087522157..31b7921bf34f 100644
--- a/drivers/net/wireless/ath/ath9k/channel.c
+++ b/drivers/net/wireless/ath/ath9k/channel.c
@@ -1011,7 +1011,7 @@ static void ath_scan_send_probe(struct ath_softc *sc,
 	skb_set_queue_mapping(skb, IEEE80211_AC_VO);
 
 	if (!ieee80211_tx_prepare_skb(sc->hw, vif, skb, band, NULL))
-		goto error;
+		return;
 
 	txctl.txq = sc->tx.txq_map[IEEE80211_AC_VO];
 	if (ath_tx_start(sc->hw, skb, &txctl))
@@ -1124,10 +1124,8 @@ ath_chanctx_send_vif_ps_frame(struct ath_softc *sc, struct ath_vif *avp,
 
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
diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 7d7350258683..ed4d83775fe7 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -2347,7 +2347,6 @@ static void hw_scan_work(struct work_struct *work)
 						      hwsim->tmp_chan->band,
 						      NULL)) {
 				rcu_read_unlock();
-				kfree_skb(probe);
 				continue;
 			}
 
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index f101ef4a1fd6..a4ef9f93a53c 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -6454,6 +6454,10 @@ void ieee80211_report_wowlan_wakeup(struct ieee80211_vif *vif,
  * @band: the band to transmit on
  * @sta: optional pointer to get the station to send the frame to
  *
+ * Return: %true if the skb was prepared, %false otherwise.
+ * On failure, the skb is freed by this function; callers must not
+ * free it again.
+ *
  * Note: must be called under RCU lock
  */
 bool ieee80211_tx_prepare_skb(struct ieee80211_hw *hw,
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index a5be5fe5c6b4..054493161376 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1882,8 +1882,10 @@ bool ieee80211_tx_prepare_skb(struct ieee80211_hw *hw,
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
2.34.1



