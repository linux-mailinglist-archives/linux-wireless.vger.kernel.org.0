Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286B66A05C4
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Feb 2023 11:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbjBWKMW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Feb 2023 05:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233933AbjBWKMR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Feb 2023 05:12:17 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9995191E
        for <linux-wireless@vger.kernel.org>; Thu, 23 Feb 2023 02:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677147132; x=1708683132;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iq/wJaw8sQ5ZOg+yqg8pftXHH2ZFUCrUeVPOD67TcfI=;
  b=URZWzD+z0cqZmT8v2Pg44ThITFApCiDf3gK2DGQz/gU9ve5H/E4GB6h+
   HXtYb4vh8SWVHcCcvevvebHeDblmqv9vyZsOHmRVCshX2KP8ZcnzgGsSJ
   gkc69eTX58r/wmCLe/Pf3fqnYRe7r5sqowQD0xdGSg1u463Or3TpAtzLH
   Utgrsed7rTa8VUHc5Fcjk16Vn9XOAYGSLKoTSbPbbm36j84k5qvRNzUd2
   /w2fqyvElRPKQRT8mQgT+FEVCXtMu9fhQq0Fk3lTtTKpKhXKxTrMhyrC4
   Xf7CL/yUUsmA8Yd94h7S53DNWostZ40ewGnxbz1ohYaTHT/VZzw/lckV8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="419396336"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="419396336"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 02:10:45 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="796245344"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="796245344"
Received: from bkalend-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.227.25])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 02:10:43 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Avraham Stern <avraham.stern@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 09/21] wifi: nl80211/cfg80211: add command to enable/disable HW timestamping
Date:   Thu, 23 Feb 2023 12:09:30 +0200
Message-Id: <20230223114629.2286397aa296.Iccc08869ea8156f1c71a3111a47f86dd56234bd0@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230223100942.767589-1-gregory.greenman@intel.com>
References: <20230223100942.767589-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

Add a command to enable and disable HW timestamping of TM and FTM
frames. HW timestamping can be enabled for a specific mac address
or for all addresses.
The low level driver will indicate for how many peers HW timestamping
can be enabled concurrently, and this information will be passed to
userspace.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/net/cfg80211.h       | 27 +++++++++++++++++++++++++
 include/uapi/linux/nl80211.h | 21 ++++++++++++++++++++
 net/wireless/nl80211.c       | 38 ++++++++++++++++++++++++++++++++++++
 net/wireless/rdev-ops.h      | 17 ++++++++++++++++
 net/wireless/trace.h         | 25 ++++++++++++++++++++++++
 5 files changed, 128 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 03b911abd772..f0da61c6ec4b 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -827,6 +827,18 @@ struct cfg80211_fils_aad {
 	const u8 *anonce;
 };
 
+/**
+ * struct cfg80211_set_hw_timestamp - enable/disable HW timestamping
+ * @macaddr: peer MAC address. NULL to enable/disable HW timestamping for all
+ *	addresses.
+ * @enable: if set, enable HW timestamping for the specified MAC address.
+ *	Otherwise disable HW timestamping for the specified MAC address.
+ */
+struct cfg80211_set_hw_timestamp {
+	const u8 *macaddr;
+	bool enable;
+};
+
 /**
  * cfg80211_get_chandef_type - return old channel type from chandef
  * @chandef: the channel definition
@@ -4330,6 +4342,8 @@ struct mgmt_frame_regs {
  * @add_link_station: Add a link to a station.
  * @mod_link_station: Modify a link of a station.
  * @del_link_station: Remove a link of a station.
+ *
+ * @set_hw_timestamp: Enable/disable HW timestamping of TM/FTM frames.
  */
 struct cfg80211_ops {
 	int	(*suspend)(struct wiphy *wiphy, struct cfg80211_wowlan *wow);
@@ -4683,6 +4697,8 @@ struct cfg80211_ops {
 				    struct link_station_parameters *params);
 	int	(*del_link_station)(struct wiphy *wiphy, struct net_device *dev,
 				    struct link_station_del_parameters *params);
+	int	(*set_hw_timestamp)(struct wiphy *wiphy, struct net_device *dev,
+				    struct cfg80211_set_hw_timestamp *hwts);
 };
 
 /*
@@ -5139,6 +5155,8 @@ struct wiphy_iftype_akm_suites {
 	int n_akm_suites;
 };
 
+#define CFG80211_HW_TIMESTAMP_ALL_PEERS	0xffff
+
 /**
  * struct wiphy - wireless hardware description
  * @mtx: mutex for the data (structures) of this device
@@ -5348,6 +5366,13 @@ struct wiphy_iftype_akm_suites {
  *	NL80211_MAX_NR_AKM_SUITES in order to avoid compatibility issues with
  *	legacy userspace and maximum allowed value is
  *	CFG80211_MAX_NUM_AKM_SUITES.
+ *
+ * @hw_timestamp_max_peers: maximum number of peers that the driver supports
+ *	enabling HW timestamping for concurrently. Setting this field to a
+ *	non-zero value indicates that the driver supports HW timestamping.
+ *	A value of %CFG80211_HW_TIMESTAMP_ALL_PEERS indicates the driver
+ *	supports enabling HW timestamping for all peers (i.e. no need to
+ *	specify a mac address).
  */
 struct wiphy {
 	struct mutex mtx;
@@ -5496,6 +5521,8 @@ struct wiphy {
 	u8 ema_max_profile_periodicity;
 	u16 max_num_akm_suites;
 
+	u16 hw_timestamp_max_peers;
+
 	char priv[] __aligned(NETDEV_ALIGN);
 };
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index c22eeb18b996..8655aa324ce7 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1299,6 +1299,16 @@
  * @NL80211_CMD_MODIFY_LINK_STA: Modify a link of an MLD station
  * @NL80211_CMD_REMOVE_LINK_STA: Remove a link of an MLD station
  *
+ * @NL80211_CMD_SET_HW_TIMESTAMP: Enable/disable HW timestamping of Timing
+ *	measurement and Fine timing measurement frames. If %NL80211_ATTR_MAC
+ *	is included, enable/disable HW timestamping only for frames to/from the
+ *	specified MAC address. Otherwise enable/disable HW timestamping for
+ *	all TM/FTM frames (including ones that were enabled with specific MAC
+ *	address). If %NL80211_ATTR_HW_TIMESTAMP_ENABLED is not included, disable
+ *	HW timestamping.
+ *	The number of peers that HW timestamping can be enabled for concurrently
+ *	is indicated by %NL80211_ATTR_MAX_HW_TIMESTAMP_PEERS.
+ *
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1550,6 +1560,8 @@ enum nl80211_commands {
 	NL80211_CMD_MODIFY_LINK_STA,
 	NL80211_CMD_REMOVE_LINK_STA,
 
+	NL80211_CMD_SET_HW_TIMESTAMP,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
@@ -2775,6 +2787,12 @@ enum nl80211_commands {
  *	indicates that the sub-channel is punctured. Higher 16 bits are
  *	reserved.
  *
+ * @NL80211_ATTR_MAX_HW_TIMESTAMP_PEERS: Maximum number of peers that HW
+ *	timestamping can be enabled for concurrently (u16), a wiphy attribute.
+ *	A value of 0xffff indicates setting for all peers (i.e. not specifying
+ *	an address with %NL80211_CMD_SET_HW_TIMESTAMP) is supported.
+ * @NL80211_ATTR_HW_TIMESTAMP_ENABLED: Indicates whether HW timestamping should
+ *	be enabled or not (flag attribute).
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3306,6 +3324,9 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_PUNCT_BITMAP,
 
+	NL80211_ATTR_MAX_HW_TIMESTAMP_PEERS,
+	NL80211_ATTR_HW_TIMESTAMP_ENABLED,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 112b4bb009c8..f687df8e20f9 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -806,6 +806,9 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_MLO_SUPPORT] = { .type = NLA_FLAG },
 	[NL80211_ATTR_MAX_NUM_AKM_SUITES] = { .type = NLA_REJECT },
 	[NL80211_ATTR_PUNCT_BITMAP] = NLA_POLICY_RANGE(NLA_U8, 0, 0xffff),
+
+	[NL80211_ATTR_MAX_HW_TIMESTAMP_PEERS] = { .type = NLA_U16 },
+	[NL80211_ATTR_HW_TIMESTAMP_ENABLED] = { .type = NLA_FLAG },
 };
 
 /* policy for the key attributes */
@@ -2964,6 +2967,11 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 		if (rdev->wiphy.flags & WIPHY_FLAG_SUPPORTS_MLO)
 			nla_put_flag(msg, NL80211_ATTR_MLO_SUPPORT);
 
+		if (rdev->wiphy.hw_timestamp_max_peers &&
+		    nla_put_u16(msg, NL80211_ATTR_MAX_HW_TIMESTAMP_PEERS,
+				rdev->wiphy.hw_timestamp_max_peers))
+			goto nla_put_failure;
+
 		/* done */
 		state->split_start = 0;
 		break;
@@ -16162,6 +16170,30 @@ nl80211_remove_link_station(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
+static int nl80211_set_hw_timestamp(struct sk_buff *skb,
+				    struct genl_info *info)
+{
+	struct cfg80211_registered_device *rdev = info->user_ptr[0];
+	struct net_device *dev = info->user_ptr[1];
+	struct cfg80211_set_hw_timestamp hwts = {};
+
+	if (!rdev->wiphy.hw_timestamp_max_peers)
+		return -EOPNOTSUPP;
+
+	if (rdev->wiphy.hw_timestamp_max_peers !=
+	    CFG80211_HW_TIMESTAMP_ALL_PEERS &&
+	    !info->attrs[NL80211_ATTR_MAC])
+		return -EOPNOTSUPP;
+
+	if (info->attrs[NL80211_ATTR_MAC])
+		hwts.macaddr = nla_data(info->attrs[NL80211_ATTR_MAC]);
+
+	hwts.enable =
+		nla_get_flag(info->attrs[NL80211_ATTR_HW_TIMESTAMP_ENABLED]);
+
+	return rdev_set_hw_timestamp(rdev, dev, &hwts);
+}
+
 #define NL80211_FLAG_NEED_WIPHY		0x01
 #define NL80211_FLAG_NEED_NETDEV	0x02
 #define NL80211_FLAG_NEED_RTNL		0x04
@@ -17336,6 +17368,12 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP |
 					 NL80211_FLAG_MLO_VALID_LINK_ID),
 	},
+	{
+		.cmd = NL80211_CMD_SET_HW_TIMESTAMP,
+		.doit = nl80211_set_hw_timestamp,
+		.flags = GENL_UNS_ADMIN_PERM,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV),
+	},
 };
 
 static struct genl_family nl80211_fam __ro_after_init = {
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 13b209a8db28..2e497cf26ef2 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -1494,4 +1494,21 @@ rdev_del_link_station(struct cfg80211_registered_device *rdev,
 	return ret;
 }
 
+static inline int
+rdev_set_hw_timestamp(struct cfg80211_registered_device *rdev,
+		      struct net_device *dev,
+		      struct cfg80211_set_hw_timestamp *hwts)
+{
+	struct wiphy *wiphy = &rdev->wiphy;
+	int ret;
+
+	if (!rdev->ops->set_hw_timestamp)
+		return -EOPNOTSUPP;
+
+	trace_rdev_set_hw_timestamp(wiphy, dev, hwts);
+	ret = rdev->ops->set_hw_timestamp(wiphy, dev, hwts);
+	trace_rdev_return_int(wiphy, ret);
+
+	return ret;
+}
 #endif /* __CFG80211_RDEV_OPS */
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index ca7474eec723..f3fcfc4fcce5 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -3918,6 +3918,31 @@ TRACE_EVENT(rdev_del_link_station,
 		  __entry->link_id)
 );
 
+TRACE_EVENT(rdev_set_hw_timestamp,
+	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
+		 struct cfg80211_set_hw_timestamp *hwts),
+
+	TP_ARGS(wiphy, netdev, hwts),
+
+	TP_STRUCT__entry(
+		WIPHY_ENTRY
+		NETDEV_ENTRY
+		MAC_ENTRY(macaddr)
+		__field(bool, enable)
+	),
+
+	TP_fast_assign(
+		WIPHY_ASSIGN;
+		NETDEV_ASSIGN;
+		MAC_ASSIGN(macaddr, hwts->macaddr);
+		__entry->enable = hwts->enable;
+	),
+
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", mac %pM, enable: %u",
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->macaddr,
+		  __entry->enable)
+);
+
 #endif /* !__RDEV_OPS_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.38.1

