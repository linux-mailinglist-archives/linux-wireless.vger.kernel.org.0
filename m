Return-Path: <linux-wireless+bounces-32020-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGBlJqzclmlJpgIAu9opvQ
	(envelope-from <linux-wireless+bounces-32020-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 10:49:32 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3999F15D85B
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 10:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F0EF306B0BE
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 09:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E900319617;
	Thu, 19 Feb 2026 09:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HhLeDRwh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200FD30F7E2
	for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 09:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771494471; cv=none; b=RMEf/IIfcEoAtU/2AgtXK4E/orww26vkNSGXaHs8Zv7JjUJUhS3ZmsW0/v3rRFqYQ9jNaB3LOzTBVji6zrdst9bYC4GyTw2dRaGm37T0t2AZCQSIU7qyY+boBcFcdnXzKUPK52LEFwPAKUMzd0iIVvo1W3EVrBFn/psgyu821Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771494471; c=relaxed/simple;
	bh=Ja7lCchDZQzOTJFyowZf2uw0ByKRKVSDtC1X9sxJFgc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rwIrk9Y+Dj9zJiMiFdBx0jxYY5rG8bb+J+Bhv2KB3CB4jLsDYsXThhRebOluHCqpjL/JMaalMLdD3SRbHe3QeE2fGZ/HHSP88bGFyNx0HzIqUSMxNHXM+A8LcOIbHHseIrvXlCOozydhYh8BypyVP925qlNpX1sYj2pTh5J41sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HhLeDRwh; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771494469; x=1803030469;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ja7lCchDZQzOTJFyowZf2uw0ByKRKVSDtC1X9sxJFgc=;
  b=HhLeDRwhgKJw2R97FeI76umHCrpxIvIN2EReodsm40cY8FyOVi+zo3cR
   3gVqSCSJCOm7d5jctx7rDm70eK4rueIJ4PK+kDoIRUwbGUqgCsl2yJKYc
   c3UyQtR+qxfTQoBUTbZlYGvEg9zi+TEJvKyC/7I+oZxYFG6zD5eQuukLS
   wkAlYv4U7QfWpYzg4Dax45RggBG8xmx82Dx8EqFMWVgvag7g8y7vdhbqe
   cCl7AaIiV4iBCymkTL5hwij5p/8dWlPNZpCMKtUAMLJQn5KU4DrE+gsOy
   GHdjunoJpQLUd3bOD+EmCdahE/5cIFhC8fKY5AJga4ucCTjAeh7dNVi6E
   g==;
X-CSE-ConnectionGUID: JWC7eKQRQy2CFCiPWqkQ3A==
X-CSE-MsgGUID: Cp5eGCoNQdilOt2+Q3ADsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="83680106"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="83680106"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 01:47:49 -0800
X-CSE-ConnectionGUID: AMOUd1EfTdebuTowFg//Ng==
X-CSE-MsgGUID: ZSKIUloMRsCwC+/6c82iBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="218989033"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 01:47:48 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v4 wireless-next 10/15] wifi: nl80211: add support for NAN stations
Date: Thu, 19 Feb 2026 11:47:20 +0200
Message-Id: <20260219114327.d280936ee832.I6d859eee759bb5824a9ffd2984410faf879ba00e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260219094725.3846371-1-miriam.rachel.korenblit@intel.com>
References: <20260219094725.3846371-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32020-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3999F15D85B
X-Rspamd-Action: no action

There are 2 types of logical links with a NAN peer:
- management (NMI), which is used for Tx/Rx of NAN management frames.
- data (NDI), which is used for Tx/Rx of data frames, or non-NAN
  management frames.

The NMI station has two roles:
- representation of the NAN peer - for example, the peer's schedule
  and the HT, VHT, HE capabilities - belong to the NMI station, and not to
  the NDI ones.
- Tx/Rx of NAN management frames to/from the peer.

The NDI station is used for Tx/Rx data frames of a specific NDP that was
established with the NAN peer.

Note that a peer can choose to reuse its NMI address as the NDI address.
In that case, it is expected that two stations will be added even though
they will have the same address.

- An NDI station can only be added after the corresponding NMI station
  was configured with capabilities.
- All the NDI stations will be removed before the NDI interface is brought
  down.
- All NMI stations will be removed before NAN is stopped.
- Before NMI sta removal, all corresponding NDI stations will be removed

Add support for adding, removing, and changing NMI and NDI stations.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/cfg80211.h       |  56 ++++++++++++++++
 include/uapi/linux/nl80211.h |   8 ++-
 net/wireless/nl80211.c       | 120 ++++++++++++++++++++++++++++-------
 3 files changed, 161 insertions(+), 23 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 1eceb03892d1..0581fa9538d3 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1828,6 +1828,7 @@ struct cfg80211_ttlm_params {
  * @eml_cap: EML capabilities of this station
  * @link_sta_params: link related params.
  * @epp_peer: EPP peer indication
+ * @nmi_mac: MAC address of the NMI station of the NAN peer
  */
 struct station_parameters {
 	struct net_device *vlan;
@@ -1855,6 +1856,7 @@ struct station_parameters {
 	u16 eml_cap;
 	struct link_station_parameters link_sta_params;
 	bool epp_peer;
+	const u8 *nmi_mac;
 };
 
 /**
@@ -1894,6 +1896,8 @@ struct station_del_parameters {
  *	entry that is operating, has been marked authorized by userspace)
  * @CFG80211_STA_MESH_PEER_KERNEL: peer on mesh interface (kernel managed)
  * @CFG80211_STA_MESH_PEER_USER: peer on mesh interface (user managed)
+ * @CFG80211_STA_NAN_MGMT: NAN management interface station
+ * @CFG80211_STA_NAN_DATA: NAN data path station
  */
 enum cfg80211_station_type {
 	CFG80211_STA_AP_CLIENT,
@@ -1905,6 +1909,8 @@ enum cfg80211_station_type {
 	CFG80211_STA_TDLS_PEER_ACTIVE,
 	CFG80211_STA_MESH_PEER_KERNEL,
 	CFG80211_STA_MESH_PEER_USER,
+	CFG80211_STA_NAN_MGMT,
+	CFG80211_STA_NAN_DATA,
 };
 
 /**
@@ -3996,6 +4002,56 @@ struct cfg80211_qos_map {
  *
  * The local schedule specifies which channels the device is available on and
  * when. Must be cancelled before NAN is stopped.
+ *
+ * NAN Stations
+ * ~~~~~~~~~~~~
+ *
+ * There are two types of stations corresponding to the two interface types:
+ *
+ * - NMI station: Represents the NAN peer. Peer-specific data such as the peer's
+ *   schedule and the HT, VHT and HE capabilities belongs to the NMI station.
+ *   Also used for Tx/Rx of NAN management frames to/from the peer.
+ *   Added on the %NL80211_IFTYPE_NAN interface.
+ *
+ * - NDI station: Used for Tx/Rx of data frames (and non-NAN management frames)
+ *   for a specific NDP established with the NAN peer. Added on the
+ *   %NL80211_IFTYPE_NAN_DATA interface.
+ *
+ * A peer may reuse its NMI address as the NDI address. In that case, two
+ * separate stations should be added even though they share the same MAC
+ * address.
+ *
+ * HT, VHT and HE capabilities should not changes after it was set. It is the
+ * driver's responsibility to check that.
+ *
+ * An NDI station can only be added if the corresponding NMI station has already
+ * been configured with HT (and possibly VHT and HE) capabilities. It is the
+ * driver's responsibility to check that.
+ *
+ * All NDI stations must be removed before corresponding NMI station is removed.
+ * Therefore, removing a NMI station implies that the associated NDI station(s)
+ * (if any) will be removed first.
+ *
+ * NAN Dependencies
+ * ~~~~~~~~~~~~~~~~
+ *
+ * The following diagram shows the dependencies between NAN components.
+ * An arrow from A to B means A must be started/added before B, and B must be
+ * stopped/removed before A:
+ *
+ *       +-------------+
+ *       |  NMI iface  |---(local schedule)
+ *       +------+------+
+ *          /       \
+ *         v         v
+ *   +-----------+  +-------------+
+ *   | NDI iface |  |   NMI sta   |---(peer schedule)
+ *   +-----+-----+  +------+------+
+ *          \           /
+ *           v         v
+ *          +----------+
+ *          | NDI sta  |
+ *          +----------+
  */
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 44dff379b66b..7e00a31e5807 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2668,7 +2668,8 @@ enum nl80211_commands {
  *      a flow is assigned on each round of the DRR scheduler.
  * @NL80211_ATTR_HE_CAPABILITY: HE Capability information element (from
  *	association request when used with NL80211_CMD_NEW_STATION). Can be set
- *	only if %NL80211_STA_FLAG_WME is set.
+ *	only if %NL80211_STA_FLAG_WME is set (except for NAN, which uses WME
+ *	anyway).
  *
  * @NL80211_ATTR_FTM_RESPONDER: nested attribute which user-space can include
  *	in %NL80211_CMD_START_AP or %NL80211_CMD_SET_BEACON for fine timing
@@ -3048,6 +3049,9 @@ enum nl80211_commands {
  *	%NL80211_CMD_NAN_SCHED_UPDATE_DONE to indicate that the deferred
  *	schedule update completed successfully. If this flag is not present,
  *	the update failed.
+ * @NL80211_ATTR_NAN_NMI_MAC: The address of the NMI station to which this NDI
+ *	station belongs. Used with %NL80211_CMD_NEW_STATION when adding an NDI
+ *	station.
  *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
@@ -3630,6 +3634,8 @@ enum nl80211_attrs {
 	NL80211_ATTR_NAN_SCHED_DEFERRED,
 	NL80211_ATTR_NAN_SCHED_UPDATE_SUCCESS,
 
+	NL80211_ATTR_NAN_NMI_MAC,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 84cfd70eb8fd..986a1db9dcfd 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -988,6 +988,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_NAN_AVAIL_BLOB] =
 		NLA_POLICY_VALIDATE_FN(NLA_BINARY, validate_nan_avail_blob),
 	[NL80211_ATTR_NAN_SCHED_DEFERRED] = { .type = NLA_FLAG },
+	[NL80211_ATTR_NAN_NMI_MAC] = NLA_POLICY_ETH_ADDR,
 };
 
 /* policy for the key attributes */
@@ -7205,6 +7206,26 @@ static int parse_station_flags(struct genl_info *info,
 		if ((params->sta_flags_mask |
 		     params->sta_flags_set) & BIT(__NL80211_STA_FLAG_INVALID))
 			return -EINVAL;
+
+		if ((iftype == NL80211_IFTYPE_NAN ||
+		     iftype == NL80211_IFTYPE_NAN_DATA) &&
+		    params->sta_flags_mask &
+		    ~(BIT(NL80211_STA_FLAG_AUTHENTICATED) |
+		      BIT(NL80211_STA_FLAG_ASSOCIATED) |
+		      BIT(NL80211_STA_FLAG_AUTHORIZED) |
+		      BIT(NL80211_STA_FLAG_MFP)))
+				return -EINVAL;
+
+		/* WME is always used in NAN */
+		if (iftype == NL80211_IFTYPE_NAN_DATA) {
+			/* but don't let userspace control it */
+			if (params->sta_flags_mask & BIT(NL80211_STA_FLAG_WME))
+				return -EINVAL;
+
+			params->sta_flags_mask |= BIT(NL80211_STA_FLAG_WME);
+			params->sta_flags_set |= BIT(NL80211_STA_FLAG_WME);
+		}
+
 		return 0;
 	}
 
@@ -8087,7 +8108,7 @@ static int nl80211_dump_station(struct sk_buff *skb,
 	/* nl80211_prepare_wdev_dump acquired it in the successful case */
 	__acquire(&rdev->wiphy.mtx);
 
-	if (!wdev->netdev) {
+	if (!wdev->netdev && wdev->iftype != NL80211_IFTYPE_NAN) {
 		err = -EINVAL;
 		goto out_err;
 	}
@@ -8274,10 +8295,12 @@ int cfg80211_check_station_change(struct wiphy *wiphy,
 			return -EINVAL;
 		if (params->link_sta_params.supported_rates)
 			return -EINVAL;
-		if (params->ext_capab || params->link_sta_params.ht_capa ||
-		    params->link_sta_params.vht_capa ||
-		    params->link_sta_params.he_capa ||
-		    params->link_sta_params.eht_capa ||
+		if (statype != CFG80211_STA_NAN_MGMT &&
+		    (params->link_sta_params.ht_capa ||
+		     params->link_sta_params.vht_capa ||
+		     params->link_sta_params.he_capa))
+			return -EINVAL;
+		if (params->ext_capab || params->link_sta_params.eht_capa ||
 		    params->link_sta_params.uhr_capa)
 			return -EINVAL;
 		if (params->sta_flags_mask & BIT(NL80211_STA_FLAG_SPP_AMSDU))
@@ -8349,6 +8372,19 @@ int cfg80211_check_station_change(struct wiphy *wiphy,
 		    params->plink_action != NL80211_PLINK_ACTION_BLOCK)
 			return -EINVAL;
 		break;
+	case CFG80211_STA_NAN_MGMT:
+		if (params->sta_flags_mask &
+		    ~(BIT(NL80211_STA_FLAG_AUTHORIZED) |
+		      BIT(NL80211_STA_FLAG_MFP)))
+			return -EINVAL;
+		break;
+	case CFG80211_STA_NAN_DATA:
+		if (params->sta_flags_mask &
+		    ~(BIT(NL80211_STA_FLAG_AUTHORIZED) |
+		      BIT(NL80211_STA_FLAG_MFP) |
+		      BIT(NL80211_STA_FLAG_WME)))
+			return -EINVAL;
+		break;
 	}
 
 	/*
@@ -8563,7 +8599,8 @@ static int nl80211_set_station(struct sk_buff *skb, struct genl_info *info)
 
 	memset(&params, 0, sizeof(params));
 
-	if (!dev)
+	if (!dev && wdev->iftype != NL80211_IFTYPE_NAN &&
+	    wdev->iftype != NL80211_IFTYPE_NAN_DATA)
 		return -EINVAL;
 
 	if (!rdev->ops->change_station)
@@ -8706,6 +8743,8 @@ static int nl80211_set_station(struct sk_buff *skb, struct genl_info *info)
 	case NL80211_IFTYPE_STATION:
 	case NL80211_IFTYPE_ADHOC:
 	case NL80211_IFTYPE_MESH_POINT:
+	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_NAN_DATA:
 		break;
 	default:
 		err = -EOPNOTSUPP;
@@ -8734,7 +8773,7 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 
 	memset(&params, 0, sizeof(params));
 
-	if (!dev)
+	if (!dev && wdev->iftype != NL80211_IFTYPE_NAN)
 		return -EINVAL;
 
 	if (!rdev->ops->add_station)
@@ -8743,15 +8782,31 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 	if (!info->attrs[NL80211_ATTR_MAC])
 		return -EINVAL;
 
-	if (!info->attrs[NL80211_ATTR_STA_LISTEN_INTERVAL])
-		return -EINVAL;
+	if (wdev->iftype == NL80211_IFTYPE_NAN ||
+	    wdev->iftype == NL80211_IFTYPE_NAN_DATA) {
+		if (info->attrs[NL80211_ATTR_STA_SUPPORTED_RATES])
+			return -EINVAL;
+		if (wdev->iftype == NL80211_IFTYPE_NAN_DATA) {
+			if (!info->attrs[NL80211_ATTR_NAN_NMI_MAC])
+				return -EINVAL;
 
-	if (!info->attrs[NL80211_ATTR_STA_SUPPORTED_RATES])
-		return -EINVAL;
+			/* Only NMI stations receive the HT/VHT/HE capabilities */
+			if (info->attrs[NL80211_ATTR_HT_CAPABILITY] ||
+			    info->attrs[NL80211_ATTR_VHT_CAPABILITY] ||
+			    info->attrs[NL80211_ATTR_HE_CAPABILITY])
+				return -EINVAL;
+		}
+	} else {
+		if (!info->attrs[NL80211_ATTR_STA_LISTEN_INTERVAL])
+			return -EINVAL;
 
-	if (!info->attrs[NL80211_ATTR_STA_AID] &&
-	    !info->attrs[NL80211_ATTR_PEER_AID])
-		return -EINVAL;
+		if (!info->attrs[NL80211_ATTR_STA_SUPPORTED_RATES])
+			return -EINVAL;
+
+		if (!info->attrs[NL80211_ATTR_STA_AID] &&
+		    !info->attrs[NL80211_ATTR_PEER_AID])
+			return -EINVAL;
+	}
 
 	params.link_sta_params.link_id =
 		nl80211_link_id_or_invalid(info->attrs);
@@ -8767,12 +8822,16 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 		mac_addr = nla_data(info->attrs[NL80211_ATTR_MAC]);
 	}
 
-	params.link_sta_params.supported_rates =
-		nla_data(info->attrs[NL80211_ATTR_STA_SUPPORTED_RATES]);
-	params.link_sta_params.supported_rates_len =
-		nla_len(info->attrs[NL80211_ATTR_STA_SUPPORTED_RATES]);
-	params.listen_interval =
-		nla_get_u16(info->attrs[NL80211_ATTR_STA_LISTEN_INTERVAL]);
+	if (info->attrs[NL80211_ATTR_STA_SUPPORTED_RATES]) {
+		params.link_sta_params.supported_rates =
+			nla_data(info->attrs[NL80211_ATTR_STA_SUPPORTED_RATES]);
+		params.link_sta_params.supported_rates_len =
+			nla_len(info->attrs[NL80211_ATTR_STA_SUPPORTED_RATES]);
+	}
+
+	if (info->attrs[NL80211_ATTR_STA_LISTEN_INTERVAL])
+		params.listen_interval =
+			nla_get_u16(info->attrs[NL80211_ATTR_STA_LISTEN_INTERVAL]);
 
 	if (info->attrs[NL80211_ATTR_VLAN_ID])
 		params.vlan_id = nla_get_u16(info->attrs[NL80211_ATTR_VLAN_ID]);
@@ -8791,7 +8850,7 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 
 	if (info->attrs[NL80211_ATTR_PEER_AID])
 		params.aid = nla_get_u16(info->attrs[NL80211_ATTR_PEER_AID]);
-	else
+	else if (info->attrs[NL80211_ATTR_STA_AID])
 		params.aid = nla_get_u16(info->attrs[NL80211_ATTR_STA_AID]);
 
 	if (info->attrs[NL80211_ATTR_STA_CAPABILITY]) {
@@ -8912,6 +8971,16 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 			return -EINVAL;
 	}
 
+	if (wdev->iftype == NL80211_IFTYPE_NAN ||
+	    wdev->iftype == NL80211_IFTYPE_NAN_DATA) {
+		if (params.sta_modify_mask & STATION_PARAM_APPLY_UAPSD)
+			return -EINVAL;
+		/* NAN NMI station must be added in associated or authorized state */
+		if (!(params.sta_flags_set & (BIT(NL80211_STA_FLAG_ASSOCIATED) |
+					      BIT(NL80211_STA_FLAG_AUTHENTICATED))))
+			return -EINVAL;
+	}
+
 	/* Ensure that HT/VHT capabilities are not set for 6 GHz HE STA */
 	if (params.link_sta_params.he_6ghz_capa &&
 	    (params.link_sta_params.ht_capa || params.link_sta_params.vht_capa))
@@ -9004,6 +9073,11 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 		 */
 		params.sta_flags_mask &= ~BIT(NL80211_STA_FLAG_AUTHORIZED);
 		break;
+	case NL80211_IFTYPE_NAN:
+		break;
+	case NL80211_IFTYPE_NAN_DATA:
+		params.nmi_mac = nla_data(info->attrs[NL80211_ATTR_NAN_NMI_MAC]);
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -9045,7 +9119,7 @@ static int nl80211_del_station(struct sk_buff *skb, struct genl_info *info)
 
 	memset(&params, 0, sizeof(params));
 
-	if (!dev)
+	if (!dev && wdev->iftype != NL80211_IFTYPE_NAN)
 		return -EINVAL;
 
 	if (info->attrs[NL80211_ATTR_MAC])
@@ -9056,6 +9130,8 @@ static int nl80211_del_station(struct sk_buff *skb, struct genl_info *info)
 	case NL80211_IFTYPE_AP_VLAN:
 	case NL80211_IFTYPE_MESH_POINT:
 	case NL80211_IFTYPE_P2P_GO:
+	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_NAN_DATA:
 		/* always accept these */
 		break;
 	case NL80211_IFTYPE_ADHOC:
-- 
2.34.1


