Return-Path: <linux-wireless+bounces-32056-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OevG9ZtmGn4IAMAu9opvQ
	(envelope-from <linux-wireless+bounces-32056-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 15:21:10 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AA51684A5
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 15:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EE7130847C3
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 14:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEEE34D4E9;
	Fri, 20 Feb 2026 14:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="lOBxpSkh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4473734B185
	for <linux-wireless@vger.kernel.org>; Fri, 20 Feb 2026 14:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771597221; cv=none; b=M6Yml98Oj6et46UmgMRc3Xo6+cTONWWU0TRfOmWBQcdajPJfdr6A1lxoY6mo/i+/B3+QVR17uqZComcW/SjToidftF0tAfGZD8GqylyWzwQZKz3VJBVzbGvgHTB8PzVsPyMw6lSV0VMP5bG2IsLVsm9ozMp8pdGau6v4qn0ALs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771597221; c=relaxed/simple;
	bh=hlhrxD5Y4vMLdbvMZi5yQoX6unguVDHO7d6JkAXASyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qsCFjF8qgMsl7/b+vOPPZZQp/50MH4hOsQP/quh7SH0HZoYeRvDhpTSQ2eQ+YhwO/Px3QDp2Da+IDfiSwwD+Nr3Gv9CT7zLrv6aHbmIUcopmn/X7F5Zp5lEfjJiEgWtmoLar+pkJ5ZeViCc+FDrPAYYMpj0rgJlsnUqOGOJPalg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=lOBxpSkh; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=L7+VzXUEMEgaKOAlNXoEDub5ipxABmgGUBQBJTxZfiY=;
	t=1771597220; x=1772806820; b=lOBxpSkhZcQ+nPD1DnXyArARN91tW67TQv0mVgcGod58GUl
	cjUh1lI9ChrboKRwMYbHHdo0mwoMEZnqTvlcZAKeYhtCM7g7i0pNJjlpn+gqIPT0QjGp5TViZqHTn
	xTuqCbeGHIfKebzt5BvCZyNq3M9YoIKFvWb31r1VMIwCh3lVnJMsnuR8N1wV+xDC02pB35ofKu/Tj
	OdI52r0YrfOcc282DMQYow1qN9DWK2VznkhBCaXQu6BzGV1NbD9M0R0i0UKxkrZ5c57dwKv9jRXGQ
	3OGoUnWeCQgf0h/I7SJKue1u3xC0gIYAJcyDf8HGoquy3+ZBByxSwddyg4+9MgLA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1vtRMZ-0000000ECBC-3Tzx;
	Fri, 20 Feb 2026 15:20:12 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
	Ramasamy Kaliappan <ramasamy.kaliappan@oss.qualcomm.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [RFC PATCH 2/8] wifi: mac80211: change public RX API to use link stations
Date: Fri, 20 Feb 2026 15:19:32 +0100
Message-ID: <20260220151929.61ef722ac889.I4a2d45609e94b52654b10ec572e59a45d09c41f4@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260220141929.206976-10-benjamin@sipsolutions.net>
References: <20260220141929.206976-10-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-32056-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benjamin@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: C6AA51684A5
X-Rspamd-Action: no action

From: Benjamin Berg <benjamin.berg@intel.com>

If a station is passed then the link ID also needs to be known. As such,
it is a more natural API to simply pass the link station directly rather
than pushing the link information into the RX status.

Furthermore, having the link ID in the RX status is not actually correct
because the link IDs are VIF specific and there may be multiple VIFs. In
the case of a station this relationship is clear, but then one may as
well use the link station.

This patch only changes the API and emulates the old (incorrect)
behaviour for now. The mac80211 RX code will be updated in later
patches.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

---

This is obviously incomplete. Though one can adjust drivers easily by
passing sta->link[status->link_id] as that information has been
prepared.
---
 drivers/net/wireless/intel/iwlwifi/mld/rx.c   |  7 +------
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  6 +++---
 drivers/net/wireless/virtual/mac80211_hwsim.c |  3 ---
 include/net/mac80211.h                        | 16 +++++++++++----
 net/mac80211/rx.c                             | 20 ++++++++++++++-----
 6 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/rx.c b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
index de2feeb74009..2a12ae412bfd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
@@ -131,7 +131,7 @@ void iwl_mld_pass_packet_to_mac80211(struct iwl_mld *mld,
 		return;
 	}
 
-	ieee80211_rx_napi(mld->hw, link_sta->sta, skb, napi);
+	ieee80211_rx_napi(mld->hw, link_sta, skb, napi);
 }
 EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_mld_pass_packet_to_mac80211);
 
@@ -1765,11 +1765,6 @@ iwl_mld_rx_with_sta(struct iwl_mld *mld, struct ieee80211_hdr *hdr,
 
 	rx_status = IEEE80211_SKB_RXCB(skb);
 
-	if (link_sta && sta->valid_links) {
-		rx_status->link_valid = true;
-		rx_status->link_id = link_sta->link_id;
-	}
-
 	/* fill checksum */
 	if (ieee80211_is_data(hdr->frame_control) &&
 	    pkt->len_n_flags & cpu_to_le32(FH_RSCSR_RPA_EN)) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index d0c0faae0122..a83bede06487 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -90,7 +90,7 @@ static void iwl_mvm_pass_packet_to_mac80211(struct iwl_mvm *mvm,
 				fraglen, rxb->truesize);
 	}
 
-	ieee80211_rx_napi(mvm->hw, sta, skb, napi);
+	ieee80211_rx_napi(mvm->hw, &sta->deflink, skb, napi);
 }
 
 /*
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 7f0b4f5daa21..fe5a2d0a798b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2025 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2026 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -243,7 +243,7 @@ static void iwl_mvm_pass_packet_to_mac80211(struct iwl_mvm *mvm,
 		return;
 	}
 
-	ieee80211_rx_napi(mvm->hw, sta, skb, napi);
+	ieee80211_rx_napi(mvm->hw, &sta->deflink, skb, napi);
 }
 
 static bool iwl_mvm_used_average_energy(struct iwl_mvm *mvm,
@@ -2528,7 +2528,7 @@ void iwl_mvm_rx_monitor_no_data(struct iwl_mvm *mvm, struct napi_struct *napi,
 	}
 
 	rcu_read_lock();
-	ieee80211_rx_napi(mvm->hw, sta, skb, napi);
+	ieee80211_rx_napi(mvm->hw, &sta->deflink, skb, napi);
 	rcu_read_unlock();
 }
 
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 4d9f5f87e814..7d529aa129f8 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -1755,9 +1755,6 @@ static void mac80211_hwsim_rx(struct mac80211_hwsim_data *data,
 				sp->active_links_rx &= ~BIT(link_id);
 			else
 				sp->active_links_rx |= BIT(link_id);
-
-			rx_status->link_valid = true;
-			rx_status->link_id = link_id;
 		}
 		rcu_read_unlock();
 	}
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 7f9d96939a4e..4d9dbd35369b 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -5207,14 +5207,18 @@ void ieee80211_restart_hw(struct ieee80211_hw *hw);
  * mixed for a single hardware. Must not run concurrently with
  * ieee80211_tx_status_skb() or ieee80211_tx_status_ni().
  *
+ * For data frames, when hardware has done address translation, a link station
+ * has to be provided and the frequency information may be skipped.
+ *
  * This function must be called with BHs disabled and RCU read lock
  *
  * @hw: the hardware this frame came in on
- * @sta: the station the frame was received from, or %NULL
+ * @link_sta: the link station the data frame was received from, or %NULL
  * @skb: the buffer to receive, owned by mac80211 after this call
  * @list: the destination list
  */
-void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
+void ieee80211_rx_list(struct ieee80211_hw *hw,
+		       struct ieee80211_link_sta *link_sta,
 		       struct sk_buff *skb, struct list_head *list);
 
 /**
@@ -5232,14 +5236,18 @@ void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
  * mixed for a single hardware. Must not run concurrently with
  * ieee80211_tx_status_skb() or ieee80211_tx_status_ni().
  *
+ * For data frames, when hardware has done address translation, a link station
+ * has to be provided and the frequency information may be skipped.
+ *
  * This function must be called with BHs disabled.
  *
  * @hw: the hardware this frame came in on
- * @sta: the station the frame was received from, or %NULL
+ * @link_sta: the link station the data frame was received from, or %NULL
  * @skb: the buffer to receive, owned by mac80211 after this call
  * @napi: the NAPI context
  */
-void ieee80211_rx_napi(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
+void ieee80211_rx_napi(struct ieee80211_hw *hw,
+		       struct ieee80211_link_sta *link_sta,
 		       struct sk_buff *skb, struct napi_struct *napi);
 
 /**
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 11d6c56c9d7e..4098f63ec824 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -5432,7 +5432,8 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
  * This is the receive path handler. It is called by a low level driver when an
  * 802.11 MPDU is received from the hardware.
  */
-void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
+void ieee80211_rx_list(struct ieee80211_hw *hw,
+		       struct ieee80211_link_sta *link_pubsta,
 		       struct sk_buff *skb, struct list_head *list)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
@@ -5440,6 +5441,7 @@ void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
 	struct ieee80211_supported_band *sband;
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct ieee80211_sta *pubsta;
 
 	WARN_ON_ONCE(softirq_count() == 0);
 
@@ -5562,8 +5564,15 @@ void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
 		}
 	}
 
-	if (WARN_ON_ONCE(status->link_id >= IEEE80211_LINK_UNSPECIFIED))
-		goto drop;
+	/* FIXME: Emulate the old driver behaviour for now */
+	if (link_pubsta) {
+		status->link_valid = 1;
+		status->link_id = link_pubsta->link_id;
+		pubsta = link_pubsta->sta;
+	} else {
+		status->link_valid = 0;
+		pubsta = NULL;
+	}
 
 	status->rx_flags = 0;
 
@@ -5595,7 +5604,8 @@ void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
 }
 EXPORT_SYMBOL(ieee80211_rx_list);
 
-void ieee80211_rx_napi(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
+void ieee80211_rx_napi(struct ieee80211_hw *hw,
+		       struct ieee80211_link_sta *link_pubsta,
 		       struct sk_buff *skb, struct napi_struct *napi)
 {
 	struct sk_buff *tmp;
@@ -5608,7 +5618,7 @@ void ieee80211_rx_napi(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
 	 * receive processing
 	 */
 	rcu_read_lock();
-	ieee80211_rx_list(hw, pubsta, skb, &list);
+	ieee80211_rx_list(hw, link_pubsta, skb, &list);
 	rcu_read_unlock();
 
 	if (!napi) {
-- 
2.53.0


