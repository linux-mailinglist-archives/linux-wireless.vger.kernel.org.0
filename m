Return-Path: <linux-wireless+bounces-30533-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FE8D04366
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 17:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05EF93161950
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 15:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BE6364E84;
	Thu,  8 Jan 2026 08:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CSVeZlLo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DDC34AAF6
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 08:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767861399; cv=none; b=FppMwaTFPTDyLecQrEXYPQFCwNbBxy818dGJ94BQLrvUmw5HiaarBXZB4gvELoq0mTbvZr9HgJiwKnBjj4ZG2mDLPvWykX2kR0f7CRJJ68VUCDZuvaxzVpJVNridrEV7myQKfse2QzOeirfdc0sb4Q6ZhOfx5rAB7fRP0tyR4zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767861399; c=relaxed/simple;
	bh=YZMOYGMT5qfWAg9y8xSHjiuEIMpRKiGAQT7FPUcwej0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G/O01ytNUHLcLSJUinNFgkikUxf0bCP79Nn6ep/2tFrNS0t05A6EeyIehwfMTMRIeTkXmlUNpoN4zKpzL8hq3RbAfLvI4Ap4xRGQhC3nKoN4qnFyh9/AGWBaN3Nxz2/bM7N/r4inCvgUFwpJlq4n9bH9d0iimWeR5TOF/1a+mmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CSVeZlLo; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767861390; x=1799397390;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YZMOYGMT5qfWAg9y8xSHjiuEIMpRKiGAQT7FPUcwej0=;
  b=CSVeZlLoAtKd67iJRpwWgQKrJ8+wLLORc3VI60xSpzR5HWQj7OAxaGm1
   HwQMguBgaaPQTxdhyEhZhVgm9Nkksv4e7O7EukFED7k6vmr0/pOMrDrsV
   5Kx5rJM9tkXN46C+fi6DjM9BuBReip+1lUw+yH/9yshCaMBvnYx1UPYr0
   2JyTajPz3Vp9lGUOYgLO3im9QNqg584SFi73oyTUqGZCSgIgdsVIuomXl
   +Uq2z69U4+VjZhQAgAVGt+O8kNxMhjmsnI5IrceB5soB9cZVfRefKRXUf
   iVbK1S1xLQHS3yQyYrkjlSCRlHRVfC3ucnicIY9R1IMpytkhrwCpxB4IG
   A==;
X-CSE-ConnectionGUID: 4UcPaSnNQbKhYJF1EPJZ+g==
X-CSE-MsgGUID: nPVfBCFkS86xPmF0sd5MJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="73084804"
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="73084804"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 00:36:06 -0800
X-CSE-ConnectionGUID: 8ylBWqGXSY+nKoy4NC421w==
X-CSE-MsgGUID: tE6Zyd8AQoSGpxbpAJBi5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="233847510"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 00:36:04 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next v2 11/14] wifi: nl80211: add support for NAN stations
Date: Thu,  8 Jan 2026 10:35:37 +0200
Message-Id: <20260108102921.badf5aaa8d0f.I6d859eee759bb5824a9ffd2984410faf879ba00e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260108083540.3129471-1-miriam.rachel.korenblit@intel.com>
References: <20260108083540.3129471-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

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
index 2f58dfe7b392..197b53c9726e 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1785,6 +1785,7 @@ struct cfg80211_ttlm_params {
  *	present/updated
  * @eml_cap: EML capabilities of this station
  * @link_sta_params: link related params.
+ * @nmi_mac: MAC address of the NMI station of the NAN peer
  */
 struct station_parameters {
 	struct net_device *vlan;
@@ -1811,6 +1812,7 @@ struct station_parameters {
 	bool eml_cap_present;
 	u16 eml_cap;
 	struct link_station_parameters link_sta_params;
+	const u8 *nmi_mac;
 };
 
 /**
@@ -1850,6 +1852,8 @@ struct station_del_parameters {
  *	entry that is operating, has been marked authorized by userspace)
  * @CFG80211_STA_MESH_PEER_KERNEL: peer on mesh interface (kernel managed)
  * @CFG80211_STA_MESH_PEER_USER: peer on mesh interface (user managed)
+ * @CFG80211_STA_NAN_MGMT: NAN management interface station
+ * @CFG80211_STA_NAN_DATA: NAN data path station
  */
 enum cfg80211_station_type {
 	CFG80211_STA_AP_CLIENT,
@@ -1861,6 +1865,8 @@ enum cfg80211_station_type {
 	CFG80211_STA_TDLS_PEER_ACTIVE,
 	CFG80211_STA_MESH_PEER_KERNEL,
 	CFG80211_STA_MESH_PEER_USER,
+	CFG80211_STA_NAN_MGMT,
+	CFG80211_STA_NAN_DATA,
 };
 
 /**
@@ -3945,6 +3951,56 @@ struct cfg80211_qos_map {
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
index 751d613bc9bf..6f921168e6a2 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2657,7 +2657,8 @@ enum nl80211_commands {
  *      a flow is assigned on each round of the DRR scheduler.
  * @NL80211_ATTR_HE_CAPABILITY: HE Capability information element (from
  *	association request when used with NL80211_CMD_NEW_STATION). Can be set
- *	only if %NL80211_STA_FLAG_WME is set.
+ *	only if %NL80211_STA_FLAG_WME is set (except for NAN, which uses WME
+ *	anyway).
  *
  * @NL80211_ATTR_FTM_RESPONDER: nested attribute which user-space can include
  *	in %NL80211_CMD_START_AP or %NL80211_CMD_SET_BEACON for fine timing
@@ -3005,6 +3006,9 @@ enum nl80211_commands {
  *	the attributes of this type.
  *	Each slots spans over 16TUs, hence the entire schedule spans over
  *	512TUs. Other slot durations and periods are currently not supported.
+ * @NL80211_ATTR_NAN_NMI_MAC: The address of the NMI station to which this NDI
+ *	station belongs. Used with %NL80211_CMD_NEW_STATION when adding an NDI
+ *	station.
  *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
@@ -3579,6 +3583,8 @@ enum nl80211_attrs {
 	NL80211_ATTR_NAN_TIME_SLOTS,
 	NL80211_ATTR_NAN_RX_NSS,
 
+	NL80211_ATTR_NAN_NMI_MAC,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 0cf3db9315e9..176e33407c94 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -937,6 +937,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_NAN_RX_NSS] = { .type = NLA_U8 },
 	[NL80211_ATTR_NAN_TIME_SLOTS] =
 		NLA_POLICY_EXACT_LEN(CFG80211_NAN_SCHED_NUM_TIME_SLOTS),
+	[NL80211_ATTR_NAN_NMI_MAC] = NLA_POLICY_ETH_ADDR,
 };
 
 /* policy for the key attributes */
@@ -7089,6 +7090,26 @@ static int parse_station_flags(struct genl_info *info,
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
 
@@ -7953,7 +7974,7 @@ static int nl80211_dump_station(struct sk_buff *skb,
 	/* nl80211_prepare_wdev_dump acquired it in the successful case */
 	__acquire(&rdev->wiphy.mtx);
 
-	if (!wdev->netdev) {
+	if (!wdev->netdev && wdev->iftype != NL80211_IFTYPE_NAN) {
 		err = -EINVAL;
 		goto out_err;
 	}
@@ -8140,10 +8161,12 @@ int cfg80211_check_station_change(struct wiphy *wiphy,
 			return -EINVAL;
 		if (params->link_sta_params.supported_rates)
 			return -EINVAL;
-		if (params->ext_capab || params->link_sta_params.ht_capa ||
-		    params->link_sta_params.vht_capa ||
-		    params->link_sta_params.he_capa ||
-		    params->link_sta_params.eht_capa)
+		if (statype != CFG80211_STA_NAN_MGMT &&
+		    (params->link_sta_params.ht_capa ||
+		     params->link_sta_params.vht_capa ||
+		     params->link_sta_params.he_capa))
+			return -EINVAL;
+		if (params->ext_capab || params->link_sta_params.eht_capa)
 			return -EINVAL;
 		if (params->sta_flags_mask & BIT(NL80211_STA_FLAG_SPP_AMSDU))
 			return -EINVAL;
@@ -8214,6 +8237,19 @@ int cfg80211_check_station_change(struct wiphy *wiphy,
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
@@ -8418,7 +8454,8 @@ static int nl80211_set_station(struct sk_buff *skb, struct genl_info *info)
 
 	memset(&params, 0, sizeof(params));
 
-	if (!dev)
+	if (!dev && wdev->iftype != NL80211_IFTYPE_NAN &&
+	    wdev->iftype != NL80211_IFTYPE_NAN_DATA)
 		return -EINVAL;
 
 	if (!rdev->ops->change_station)
@@ -8561,6 +8598,8 @@ static int nl80211_set_station(struct sk_buff *skb, struct genl_info *info)
 	case NL80211_IFTYPE_STATION:
 	case NL80211_IFTYPE_ADHOC:
 	case NL80211_IFTYPE_MESH_POINT:
+	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_NAN_DATA:
 		break;
 	default:
 		err = -EOPNOTSUPP;
@@ -8589,7 +8628,7 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 
 	memset(&params, 0, sizeof(params));
 
-	if (!dev)
+	if (!dev && wdev->iftype != NL80211_IFTYPE_NAN)
 		return -EINVAL;
 
 	if (!rdev->ops->add_station)
@@ -8598,15 +8637,31 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
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
@@ -8622,12 +8677,16 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
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
@@ -8646,7 +8705,7 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 
 	if (info->attrs[NL80211_ATTR_PEER_AID])
 		params.aid = nla_get_u16(info->attrs[NL80211_ATTR_PEER_AID]);
-	else
+	else if (info->attrs[NL80211_ATTR_STA_AID])
 		params.aid = nla_get_u16(info->attrs[NL80211_ATTR_STA_AID]);
 
 	if (info->attrs[NL80211_ATTR_STA_CAPABILITY]) {
@@ -8756,6 +8815,16 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
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
@@ -8848,6 +8917,11 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
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
@@ -8885,7 +8959,7 @@ static int nl80211_del_station(struct sk_buff *skb, struct genl_info *info)
 
 	memset(&params, 0, sizeof(params));
 
-	if (!dev)
+	if (!dev && wdev->iftype != NL80211_IFTYPE_NAN)
 		return -EINVAL;
 
 	if (info->attrs[NL80211_ATTR_MAC])
@@ -8896,6 +8970,8 @@ static int nl80211_del_station(struct sk_buff *skb, struct genl_info *info)
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


