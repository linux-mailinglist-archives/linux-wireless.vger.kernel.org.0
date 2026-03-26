Return-Path: <linux-wireless+bounces-33948-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAbNFYUMxWn05wQAu9opvQ
	(envelope-from <linux-wireless+bounces-33948-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 11:37:57 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C313B3338B8
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 11:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4D903198EEF
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 10:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4D93BE17E;
	Thu, 26 Mar 2026 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IOaIONfv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE6434DB78
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 10:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774520110; cv=none; b=jABmw1GagAszy0Cb9xYkeffYXskDUBNkSzRO6ksfOdGRQ0J5fHKKiEM4mM93p/pIR2dHgbG35Mju8W6nmHCozkmcvzlbkQpg3uhnGi16kFvCnOC4bTOtVM7mAIWh5Dwjvk+3rjoJpLppYR4TJurhf/Uu1ItSy5Kh9xPZr3/58Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774520110; c=relaxed/simple;
	bh=lEq0Y3Pzc9K6BSkdPLZ7zYdEZD9AelpDf4DbU9+z1uw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eRdeFnvU3yoVbSFccFqIBq5BEE3j93LrXLbM3s9d0PWu9P3wlToChst1RdQ2KMby3x6MmkKIUwooduteoCmOweKFrVUAx36qoxxuGJq93ZYGqEEugxrPYz4vnEBi5GPnoTkpsEb+Se4NPg7a/3QyzXH3vlJkyiLMjQRI0EN0Y+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IOaIONfv; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774520109; x=1806056109;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lEq0Y3Pzc9K6BSkdPLZ7zYdEZD9AelpDf4DbU9+z1uw=;
  b=IOaIONfvso2R5Nyqgx4UBO1YigTa5d9DfEZyiL/2MhU2Jo3sDZhokFqt
   YVZufF4hr9K8tVdoEzvRQ+qT8EBy9hiG7p7FUbxWb90DVS6OA5c/1yT0R
   Dl6RNsZh8o9EEVfuzGRKhwgYC1YaohZKE71EhDZbkyhwcd1TshWQhjRyP
   ohhEFY5jv6z9ie2X0QGvs2Xagycv4dyqjaBdzLzPsoCpTegbx9g80frKd
   QhmnXnhr9vTV7Py+/QE+t35wUy88TaBmXEV419pkO+9LgCgRuqcSOTNFs
   FCCLVemQ957sqgv+F+34lojuGYe5ciSHMbuYALcD3gTdKY4QfdZcpq1yt
   w==;
X-CSE-ConnectionGUID: wYXjlSF5Qim53y+UUcHcVw==
X-CSE-MsgGUID: RSqEI95oTBiw730J2bnb6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="87048556"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="87048556"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 03:15:09 -0700
X-CSE-ConnectionGUID: ZYl3kqspQB2A98zM7z7HAg==
X-CSE-MsgGUID: FC1OwFPTSAepsu5ILe8Zbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="221653102"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 03:15:01 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 wireless-next 01/15] wifi: mac80211: add a TXQ for management frames on NAN devices
Date: Thu, 26 Mar 2026 12:14:31 +0200
Message-Id: <20260326121156.32eddd986bd2.Iee95758287c276155fbd7779d3f263339308e083@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326101445.1443198-1-miriam.rachel.korenblit@intel.com>
References: <20260326101445.1443198-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33948-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: C313B3338B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Benjamin Berg <benjamin.berg@intel.com>

Currently there is no TXQ for non-data frames. Add a new txq_mgmt for
this purpose and create one of these on NAN devices. On NAN devices,
these frames may only be transmitted during the discovery window and it
is therefore helpful to schedule them using a queue.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/mac80211.h |  2 ++
 net/mac80211/iface.c   | 28 ++++++++++++++++++++++++++--
 net/mac80211/tx.c      | 20 ++++++++++++++++----
 net/mac80211/util.c    | 34 +++++++++++++++++++++++-----------
 4 files changed, 67 insertions(+), 17 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 9cc482191ab9..2959736efdf3 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2074,6 +2074,7 @@ enum ieee80211_neg_ttlm_res {
  * @drv_priv: data area for driver use, will always be aligned to
  *	sizeof(void \*).
  * @txq: the multicast data TX queue
+ * @txq_mgmt: the mgmt frame TX queue, currently only exists for NAN devices
  * @offload_flags: 802.3 -> 802.11 enapsulation offload flags, see
  *	&enum ieee80211_offload_flags.
  */
@@ -2092,6 +2093,7 @@ struct ieee80211_vif {
 	u8 hw_queue[IEEE80211_NUM_ACS];
 
 	struct ieee80211_txq *txq;
+	struct ieee80211_txq *txq_mgmt;
 
 	netdev_features_t netdev_features;
 	u32 driver_flags;
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 125897717a4c..7518dcbcdf1c 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -682,6 +682,10 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	if (sdata->vif.txq)
 		ieee80211_txq_purge(sdata->local, to_txq_info(sdata->vif.txq));
 
+	if (sdata->vif.txq_mgmt)
+		ieee80211_txq_purge(sdata->local,
+				    to_txq_info(sdata->vif.txq_mgmt));
+
 	sdata->bss = NULL;
 
 	if (local->open_count == 0)
@@ -2223,10 +2227,16 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (type == NL80211_IFTYPE_P2P_DEVICE || type == NL80211_IFTYPE_NAN) {
+		int size = ALIGN(sizeof(*sdata) + local->hw.vif_data_size,
+				 sizeof(void *));
 		struct wireless_dev *wdev;
+		int txq_size = 0;
+
+		if (type == NL80211_IFTYPE_NAN)
+			txq_size = sizeof(struct txq_info) +
+				   local->hw.txq_data_size;
 
-		sdata = kzalloc(sizeof(*sdata) + local->hw.vif_data_size,
-				GFP_KERNEL);
+		sdata = kzalloc(size + txq_size, GFP_KERNEL);
 		if (!sdata)
 			return -ENOMEM;
 		wdev = &sdata->wdev;
@@ -2236,6 +2246,16 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
 		ieee80211_assign_perm_addr(local, wdev->address, type);
 		memcpy(sdata->vif.addr, wdev->address, ETH_ALEN);
 		ether_addr_copy(sdata->vif.bss_conf.addr, sdata->vif.addr);
+
+		/*
+		 * Add a management TXQ for NAN devices which includes frames
+		 * that will only be transmitted during discovery windows (DWs)
+		 */
+		if (type == NL80211_IFTYPE_NAN) {
+			txqi = (struct txq_info *)((unsigned long)sdata + size);
+			ieee80211_txq_init(sdata, NULL, txqi,
+					   IEEE80211_NUM_TIDS);
+		}
 	} else {
 		int size = ALIGN(sizeof(*sdata) + local->hw.vif_data_size,
 				 sizeof(void *));
@@ -2386,6 +2406,10 @@ void ieee80211_if_remove(struct ieee80211_sub_if_data *sdata)
 	if (sdata->vif.txq)
 		ieee80211_txq_purge(sdata->local, to_txq_info(sdata->vif.txq));
 
+	if (sdata->vif.txq_mgmt)
+		ieee80211_txq_purge(sdata->local,
+				    to_txq_info(sdata->vif.txq_mgmt));
+
 	synchronize_rcu();
 
 	cfg80211_unregister_wdev(&sdata->wdev);
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 3844c7fbb8a8..730c208c3bdf 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1313,13 +1313,19 @@ static struct txq_info *ieee80211_get_txq(struct ieee80211_local *local,
 	    unlikely(!ieee80211_is_data_present(hdr->frame_control))) {
 		if ((!ieee80211_is_mgmt(hdr->frame_control) ||
 		     ieee80211_is_bufferable_mmpdu(skb) ||
-		     vif->type == NL80211_IFTYPE_STATION) &&
+		     vif->type == NL80211_IFTYPE_STATION ||
+		     vif->type == NL80211_IFTYPE_NAN ||
+		     vif->type == NL80211_IFTYPE_NAN_DATA) &&
 		    sta && sta->uploaded) {
 			/*
 			 * This will be NULL if the driver didn't set the
 			 * opt-in hardware flag.
 			 */
 			txq = sta->sta.txq[IEEE80211_NUM_TIDS];
+		} else if ((!ieee80211_is_mgmt(hdr->frame_control) ||
+			    ieee80211_is_bufferable_mmpdu(skb)) &&
+			   !sta) {
+			txq = vif->txq_mgmt;
 		}
 	} else if (sta) {
 		u8 tid = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
@@ -1512,9 +1518,15 @@ void ieee80211_txq_init(struct ieee80211_sub_if_data *sdata,
 	txqi->txq.vif = &sdata->vif;
 
 	if (!sta) {
-		sdata->vif.txq = &txqi->txq;
-		txqi->txq.tid = 0;
-		txqi->txq.ac = IEEE80211_AC_BE;
+		txqi->txq.tid = tid;
+
+		if (tid == IEEE80211_NUM_TIDS) {
+			sdata->vif.txq_mgmt = &txqi->txq;
+			txqi->txq.ac = IEEE80211_AC_VO;
+		} else {
+			sdata->vif.txq = &txqi->txq;
+			txqi->txq.ac = IEEE80211_AC_BE;
+		}
 
 		return;
 	}
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 8987a4504520..72e73f4f79c5 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -325,7 +325,7 @@ static void __ieee80211_wake_txqs(struct ieee80211_sub_if_data *sdata, int ac)
 	struct ieee80211_vif *vif = &sdata->vif;
 	struct fq *fq = &local->fq;
 	struct ps_data *ps = NULL;
-	struct txq_info *txqi;
+	struct txq_info *txqi = NULL;
 	struct sta_info *sta;
 	int i;
 
@@ -344,37 +344,49 @@ static void __ieee80211_wake_txqs(struct ieee80211_sub_if_data *sdata, int ac)
 
 		for (i = 0; i < ARRAY_SIZE(sta->sta.txq); i++) {
 			struct ieee80211_txq *txq = sta->sta.txq[i];
+			struct txq_info *sta_txqi;
 
 			if (!txq)
 				continue;
 
-			txqi = to_txq_info(txq);
+			sta_txqi = to_txq_info(txq);
 
 			if (ac != txq->ac)
 				continue;
 
 			if (!test_and_clear_bit(IEEE80211_TXQ_DIRTY,
-						&txqi->flags))
+						&sta_txqi->flags))
 				continue;
 
 			spin_unlock(&fq->lock);
-			drv_wake_tx_queue(local, txqi);
+			drv_wake_tx_queue(local, sta_txqi);
 			spin_lock(&fq->lock);
 		}
 	}
 
-	if (!vif->txq)
-		goto out;
+	if (vif->txq) {
+		txqi = to_txq_info(vif->txq);
 
-	txqi = to_txq_info(vif->txq);
+		/* txq and txq_mgmt are mutually exclusive */
+		WARN_ON_ONCE(vif->txq_mgmt);
 
-	if (!test_and_clear_bit(IEEE80211_TXQ_DIRTY, &txqi->flags) ||
-	    (ps && atomic_read(&ps->num_sta_ps)) || ac != vif->txq->ac)
-		goto out;
+		if (!test_and_clear_bit(IEEE80211_TXQ_DIRTY, &txqi->flags) ||
+		    (ps && atomic_read(&ps->num_sta_ps)) ||
+		    ac != vif->txq->ac)
+			txqi = NULL;
+	} else if (vif->txq_mgmt) {
+		txqi = to_txq_info(vif->txq_mgmt);
+
+		if (!test_and_clear_bit(IEEE80211_TXQ_DIRTY, &txqi->flags) ||
+		    ac != vif->txq_mgmt->ac)
+			txqi = NULL;
+	}
 
 	spin_unlock(&fq->lock);
 
-	drv_wake_tx_queue(local, txqi);
+	if (txqi)
+		drv_wake_tx_queue(local, txqi);
+
 	local_bh_enable();
 	return;
 out:
-- 
2.34.1


