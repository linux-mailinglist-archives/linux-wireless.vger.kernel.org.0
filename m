Return-Path: <linux-wireless+bounces-35599-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCLfGlju8WmulgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35599-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 13:41:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DF2493A51
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 13:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB07D302737A
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 11:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FC126B2D2;
	Wed, 29 Apr 2026 11:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eaI47ljf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA033F0A98
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 11:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777462866; cv=none; b=omFoh0bAKjVe9TvZ8PXMYnY+vOnkCqIa9ppq2AvRvXJ8sLeM2B0NwgzH9VgupDxtX4WLUi7o7RW4ME3siKDE3H/l6CWu8a2Pw6/0kUVDyfreGyGuPThikT0Rq2UcEP8yUEpUPbQejK4skAK/0jvR90OkF9WRsffs8OOiAboqmzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777462866; c=relaxed/simple;
	bh=9xinH5SSmB+K7Bh5XMUGzbE8O26jHvdMfTJ3J/1RW1k=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pgTaN4OTjZkQZv671TWohWO2/osodRu2tlxG6ulEbxpQ2l/1xgsqdRunhxmDHRy6pm9IQYQhplazgMvn59ujdCgYEhx1+ReFYdi+aBONTr1SINvZji59V/R/hPmjP/Tf/HSwi61DEHFrSm9TorAwjm5IoFXNQ3hYirEV3CgsLcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eaI47ljf; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777462865; x=1808998865;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=9xinH5SSmB+K7Bh5XMUGzbE8O26jHvdMfTJ3J/1RW1k=;
  b=eaI47ljfKPtxarJ4JW+8ckJeYFrovIdyScHM9wTtsmU+u7o7D8QAIj8Q
   vQAb0kCm+Q8q73QwXYMVcaPYx3jOeKqlOkR7UX7MrdlsEvwD2uChOLOdZ
   tN/K4/2Er30ZsNU6MGjU830XTTv5jfQQ/o/kvdALUdx7ygBCbSpSveJdd
   mmhXVqQys8GFRly6SxNoUTLVZosd8Klrx/18OnbQhmBJ2E8eey043RYrN
   pH+GHZk7TeABQTTtBqyj+tpEMBjB4FZ5CjnamfqxKAR3+7B2xyGobklQy
   O5XObiUzx20YLmmLhMFO+82KVATx6Yt5jPRxtJQbQYmPKVHJpyzTnwHEg
   g==;
X-CSE-ConnectionGUID: CheDvjZ3TpqaVSdLtUq1KQ==
X-CSE-MsgGUID: OLcmTa20SOyLAwhdFpPFXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="88986107"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="88986107"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 04:41:04 -0700
X-CSE-ConnectionGUID: 4lg/iuquTRqP5ppBlVnWtw==
X-CSE-MsgGUID: 7qPYl9OORGe+WrCYtIKAbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="234505102"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 04:41:03 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v2 wireless-next 01/15] wifi: mac80211: track the id of the NAN cluster we joined
Date: Wed, 29 Apr 2026 14:40:35 +0300
Message-Id: <20260429143813.5dada1b756a4.I0f1060215267fd8aef31afd99f8f42e6fde7f234@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260429114049.4167111-1-miriam.rachel.korenblit@intel.com>
References: <20260429114049.4167111-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 16DF2493A51
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35599-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]

Currently, we store in nan.conf the cluster id that was configured from
upper layer to be used when the device opens a cluster.
But after we joined a cluster, the configured cluster id is no longer
relevant. Particularly, in reconfig we will give the driver the
(possibly) wrong cluster id.

Add an API to be called by the driver when joined a cluster
in which the cluster id will be updated.
Use the locally stored cluster id instead of cfg80211's copy.

Ignore cluster id updates from cfg80211 if we already have one
configured.

Adjust the drivers that use the cfg80211 API
(cfg80211_nan_cluster_joined) directly, otherwise we break functionality
(i.e. accept frame check won't evaluate to true).

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/mac80211.h | 14 ++++++++++++++
 net/mac80211/cfg.c     | 19 +++++++++++++++++++
 net/mac80211/rx.c      |  4 ++--
 net/mac80211/tx.c      |  2 +-
 4 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 02318a4be0e1..0d1b1d726b9c 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -7891,6 +7891,20 @@ void ieee80211_nan_func_match(struct ieee80211_vif *vif,
  */
 void ieee80211_nan_sched_update_done(struct ieee80211_vif *vif);
 
+/**
+ * ieee80211_nan_cluster_joined - notify about NAN cluster join.
+ *
+ * This function is used to notify mac80211 about NAN cluster join.
+ *
+ * @vif: &struct ieee80211_vif pointer from the add_interface callback.
+ * @cluster_id: the cluster ID that was joined
+ * @new_cluster: true if this is a new cluster
+ * @gfp: allocation flags
+ */
+void ieee80211_nan_cluster_joined(struct ieee80211_vif *vif,
+				  const u8 *cluster_id, bool new_cluster,
+				  gfp_t gfp);
+
 /**
  * ieee80211_calc_rx_airtime - calculate estimated transmission airtime for RX.
  *
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 00261bd6674b..c71af8878562 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -5215,6 +5215,25 @@ void ieee80211_nan_func_match(struct ieee80211_vif *vif,
 }
 EXPORT_SYMBOL(ieee80211_nan_func_match);
 
+void ieee80211_nan_cluster_joined(struct ieee80211_vif *vif,
+				  const u8 *cluster_id, bool new_cluster,
+				  gfp_t gfp)
+{
+	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
+
+	if (WARN_ON(vif->type != NL80211_IFTYPE_NAN))
+		return;
+
+	if (WARN_ON(!sdata->u.nan.started))
+		return;
+
+	ether_addr_copy(sdata->u.nan.conf.cluster_id, cluster_id);
+
+	cfg80211_nan_cluster_joined(ieee80211_vif_to_wdev(vif), cluster_id,
+				    new_cluster, gfp);
+}
+EXPORT_SYMBOL(ieee80211_nan_cluster_joined);
+
 static int ieee80211_set_multicast_to_unicast(struct wiphy *wiphy,
 					      struct net_device *dev,
 					      const bool enabled)
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 3e5d1c47a5b0..82ea7404f3da 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4629,7 +4629,7 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 		 * action frames or authentication frames that are addressed to
 		 * the local NAN interface.
 		 */
-		return memcmp(sdata->wdev.u.nan.cluster_id,
+		return memcmp(sdata->u.nan.conf.cluster_id,
 			      hdr->addr3, ETH_ALEN) == 0 &&
 			(ieee80211_is_public_action(hdr, skb->len) ||
 			 (ieee80211_is_auth(hdr->frame_control) &&
@@ -4646,7 +4646,7 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 			if (!nmi)
 				return false;
 
-			if (!ether_addr_equal(nmi->wdev.u.nan.cluster_id,
+			if (!ether_addr_equal(nmi->u.nan.conf.cluster_id,
 					      hdr->addr3))
 				return false;
 
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 8e4876d1c544..1702f816419b 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2854,7 +2854,7 @@ static struct sk_buff *ieee80211_build_hdr(struct ieee80211_sub_if_data *sdata,
 			ret = -ENOTCONN;
 			goto free;
 		}
-		memcpy(hdr.addr3, nmi->wdev.u.nan.cluster_id, ETH_ALEN);
+		memcpy(hdr.addr3, nmi->u.nan.conf.cluster_id, ETH_ALEN);
 		hdrlen = 24;
 		break;
 	}
-- 
2.34.1


