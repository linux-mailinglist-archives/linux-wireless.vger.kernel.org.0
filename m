Return-Path: <linux-wireless+bounces-31941-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MY8CZRXlGkXDAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31941-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 12:57:08 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C012C14BA88
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 12:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C87533012BE5
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 11:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247413358BD;
	Tue, 17 Feb 2026 11:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q8XydijH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6901C33557C
	for <linux-wireless@vger.kernel.org>; Tue, 17 Feb 2026 11:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771329403; cv=none; b=pU3x39azVkdYgsKR6gxNoF0K08XJ2yexE8u1H2GhBxwZl/i7grUtUJoZ+UqdxNLx7O5vOljryhOvPHmyO+XuPJFW9N3Vx14h0N0COXy9+8mtQW+KSIM9+mQtcn3BP+yNkwAcxaHPm2Y2KnGvtZ/v0Sp7At7kMWYU2eQLML1EU9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771329403; c=relaxed/simple;
	bh=Ja7lCchDZQzOTJFyowZf2uw0ByKRKVSDtC1X9sxJFgc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ec6YRxkZeEjqMJUQh3s3E9uDmLiXl0OfKBQJNhoawJh3iRJy8b+6CZm7ytgz5awuB63PACE9A2/wiu8uSaVqSZSmPHxggvHOp9WtXt3N7FF+qrgrIrYz1hTG/Rq2v/a5RsPJYRDqdmq8UXZ1IL27e5tyozqBJNaNS74Se/U9AxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q8XydijH; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771329402; x=1802865402;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ja7lCchDZQzOTJFyowZf2uw0ByKRKVSDtC1X9sxJFgc=;
  b=Q8XydijH148JJ4M2xCIAENZ1FF8SUoGffr4ZJ7Qr/37lna9EdNFBUF6t
   6RdNj0XBx9OXSl8tWajJTctMJZebHEUwUAOfYfTCkBGKoHhd3S8xa/qeV
   WNAH7vm/ua9L7xuyGZudf4zUUr1OlkhmFT9MI+35iNY2124bt44kZ88cr
   a0F0M1TYLbHoUzFCXHRcVgZW1hkuZWgXV3s010pB5robRsh6pePxDx8Wr
   TjIQdZD9xmhPtYm0EOEis44g3PxdXMMb/vzSL4uSKbhj6r9RdDmgC+3XN
   7B+FipSTtQdj2S1lQbkheqFvWcpiyVCjX/PknbH66VB8ncvAvb13yrIgw
   g==;
X-CSE-ConnectionGUID: UE1qf2+NTGa0XIDImwDN8w==
X-CSE-MsgGUID: 2wV8gg+cQ5Wi7SGVaO1/kA==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="83495873"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="83495873"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 03:56:42 -0800
X-CSE-ConnectionGUID: RjVmmXlJS6q+KaILwX8QOw==
X-CSE-MsgGUID: VV1Qb58pR4eYabFXPkBakQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="251547144"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 03:56:40 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v3 wireless-next 10/15] wifi: nl80211: add support for NAN stations
Date: Tue, 17 Feb 2026 13:56:13 +0200
Message-Id: <20260217134342.cb9a71a609f5.I6d859eee759bb5824a9ffd2984410faf879ba00e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260217115618.2066972-1-miriam.rachel.korenblit@intel.com>
References: <20260217115618.2066972-1-miriam.rachel.korenblit@intel.com>
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
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31941-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C012C14BA88
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


