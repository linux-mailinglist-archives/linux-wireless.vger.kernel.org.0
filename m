Return-Path: <linux-wireless+bounces-33872-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFSCJCdSxGljyAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33872-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 22:22:47 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F9F32C608
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 22:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A3B1307652B
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 21:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F3834E763;
	Wed, 25 Mar 2026 21:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lvyzmC9i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A51301460
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 21:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774473352; cv=none; b=CEEwUR3X+TvRU5SpyKTRCxuYv99Dps3rVrP8Pvipwhb2+z5THuO9WcJPbg8Ld5G4U5PNxOHUU94YhogXCBcVojESmLxaDGEscN9k5aiImvmLG3GKA7zt2C8QV09A39hoc2Lybv2+FLT8UAbX0mroyhwQSssQuqTnvfBxoGb1T98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774473352; c=relaxed/simple;
	bh=v0taeqlMuW/rAgEo9Vs2ITsStevpFLY2AsF18kwrCdE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c68Neuk0+4Mbpo+HblGcI5Up2oK6CElILkVTc+/OaYwZkbeSYTWytnel6KRRtUSoSf76pbV+hUVaLfDuvt+17r5dC0qZjK52tT0lQa5B0J0J5InneB/RbozoTSu0xWej6hyuH7b9TkY+i16gI6fBV4rq2AClY1JwVQCE+sk0qg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lvyzmC9i; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774473351; x=1806009351;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v0taeqlMuW/rAgEo9Vs2ITsStevpFLY2AsF18kwrCdE=;
  b=lvyzmC9ib5aKQEI+GFZmuErSyxHio9IWe4quuvYCagrn6/ddM5uz9j3L
   P+127O6P1nkV9a2gMvYYWTa+ckTjeuoMgo45n81IEKVTsvpgqZCZTz4Kl
   sXJHrerGQEAozpa6fbEY1tjdQRXNT1oiRkzi6M08b3pE6bK+269KtPdvK
   flUST7wY+9BipRK2c/Yxwy8vt5CZqrPtmOk0Fs0GT/B847gZEcMjLdR7Y
   5tSTemvKmTY86Q6Sge/PkgxzJn5wJirNufshOlOcxKyzwCFP/D3E1v89c
   mbcF27RTt5JfhC2DNigS0CLBFvY6H9/JX4k3cQotK+zzRRhcvDE9Psd9R
   g==;
X-CSE-ConnectionGUID: nnla30rbTZ+iB5qNsasZxQ==
X-CSE-MsgGUID: o/ZWwbP7Q8Wn6PvJXBvSgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75485334"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="75485334"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 14:15:50 -0700
X-CSE-ConnectionGUID: eIyn8awKSSC/eeKN97rmag==
X-CSE-MsgGUID: YhbyJPQ4QqaSbO6QetlUiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="224747465"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 14:15:49 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 01/15] wifi: mac80211: add a TXQ for management frames on NAN devices
Date: Wed, 25 Mar 2026 23:15:22 +0200
Message-Id: <20260325230443.f20deeb5d13d.Iee95758287c276155fbd7779d3f263339308e083@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325211536.910411-1-miriam.rachel.korenblit@intel.com>
References: <20260325211536.910411-1-miriam.rachel.korenblit@intel.com>
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
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33872-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 13F9F32C608
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Benjamin Berg <benjamin.berg@intel.com>

Currently there is no TXQ for non-data frames. Add a new txq_mgmt for
this purpose and create one of these on NAN devices. On NAN devices,
these frames may only be transmitted during the discovery window and it
is therefore helpful to schedule them using a queue.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
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


