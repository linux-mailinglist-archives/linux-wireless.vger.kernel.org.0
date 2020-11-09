Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAD932AB428
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Nov 2020 10:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbgKIJ57 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Nov 2020 04:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729285AbgKIJ55 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Nov 2020 04:57:57 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC81C0613D4
        for <linux-wireless@vger.kernel.org>; Mon,  9 Nov 2020 01:57:57 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kc3vv-004EGg-At; Mon, 09 Nov 2020 10:57:55 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 8/8] cfg80211: remove WDS code
Date:   Mon,  9 Nov 2020 10:57:47 +0100
Message-Id: <20201109105103.8f5b98e4068d.I5f5129041649ef2862b69683574bb3344743727b@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201109095747.113720-1-johannes@sipsolutions.net>
References: <20201109095747.113720-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Remove all the code that was there to configure WDS interfaces,
now that there's no way to reach it anymore.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h       |  5 ----
 include/uapi/linux/nl80211.h |  3 ++-
 net/wireless/chan.c          |  6 ++---
 net/wireless/core.c          |  8 +-----
 net/wireless/nl80211.c       | 36 ++-----------------------
 net/wireless/rdev-ops.h      | 10 -------
 net/wireless/trace.h         |  5 ----
 net/wireless/util.c          |  5 ++--
 net/wireless/wext-compat.c   | 51 ------------------------------------
 9 files changed, 10 insertions(+), 119 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 0ba8d1fa6eb9..4ff804a8bc1d 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -3745,8 +3745,6 @@ struct mgmt_frame_regs {
  * @get_tx_power: store the current TX power into the dbm variable;
  *	return 0 if successful
  *
- * @set_wds_peer: set the WDS peer for a WDS interface
- *
  * @rfkill_poll: polls the hw rfkill line, use cfg80211 reporting
  *	functions to adjust rfkill hw state
  *
@@ -4067,9 +4065,6 @@ struct cfg80211_ops {
 	int	(*get_tx_power)(struct wiphy *wiphy, struct wireless_dev *wdev,
 				int *dbm);
 
-	int	(*set_wds_peer)(struct wiphy *wiphy, struct net_device *dev,
-				const u8 *addr);
-
 	void	(*rfkill_poll)(struct wiphy *wiphy);
 
 #ifdef CONFIG_NL80211_TESTMODE
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index e1e5b3d4dd81..3e0d4a038ab6 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -757,7 +757,8 @@
  *	of any other interfaces, and other interfaces will again take
  *	precedence when they are used.
  *
- * @NL80211_CMD_SET_WDS_PEER: Set the MAC address of the peer on a WDS interface.
+ * @NL80211_CMD_SET_WDS_PEER: Set the MAC address of the peer on a WDS interface
+ *	(no longer supported).
  *
  * @NL80211_CMD_SET_MULTICAST_TO_UNICAST: Configure if this AP should perform
  *	multicast to unicast conversion. When enabled, all multicast packets
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 22d1779ab2b1..e4030f1fbc60 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -530,10 +530,10 @@ int cfg80211_chandef_dfs_required(struct wiphy *wiphy,
 	case NL80211_IFTYPE_P2P_CLIENT:
 	case NL80211_IFTYPE_MONITOR:
 	case NL80211_IFTYPE_AP_VLAN:
-	case NL80211_IFTYPE_WDS:
 	case NL80211_IFTYPE_P2P_DEVICE:
 	case NL80211_IFTYPE_NAN:
 		break;
+	case NL80211_IFTYPE_WDS:
 	case NL80211_IFTYPE_UNSPECIFIED:
 	case NUM_NL80211_IFTYPES:
 		WARN_ON(1);
@@ -677,12 +677,12 @@ bool cfg80211_beaconing_iface_active(struct wireless_dev *wdev)
 	case NL80211_IFTYPE_P2P_CLIENT:
 	case NL80211_IFTYPE_MONITOR:
 	case NL80211_IFTYPE_AP_VLAN:
-	case NL80211_IFTYPE_WDS:
 	case NL80211_IFTYPE_P2P_DEVICE:
 	/* Can NAN type be considered as beaconing interface? */
 	case NL80211_IFTYPE_NAN:
 		break;
 	case NL80211_IFTYPE_UNSPECIFIED:
+	case NL80211_IFTYPE_WDS:
 	case NUM_NL80211_IFTYPES:
 		WARN_ON(1);
 	}
@@ -1324,12 +1324,12 @@ cfg80211_get_chan_state(struct wireless_dev *wdev,
 		break;
 	case NL80211_IFTYPE_MONITOR:
 	case NL80211_IFTYPE_AP_VLAN:
-	case NL80211_IFTYPE_WDS:
 	case NL80211_IFTYPE_P2P_DEVICE:
 	case NL80211_IFTYPE_NAN:
 		/* these interface types don't really have a channel */
 		return;
 	case NL80211_IFTYPE_UNSPECIFIED:
+	case NL80211_IFTYPE_WDS:
 	case NUM_NL80211_IFTYPES:
 		WARN_ON(1);
 	}
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 9f23923e8d29..f6b744e91ff4 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -631,10 +631,8 @@ static int wiphy_verify_combinations(struct wiphy *wiphy)
 				return -EINVAL;
 		}
 
-#ifndef CONFIG_WIRELESS_WDS
 		if (WARN_ON(all_iftypes & BIT(NL80211_IFTYPE_WDS)))
 			return -EINVAL;
-#endif
 
 		/* You can't even choose that many! */
 		if (WARN_ON(cnt < c->max_interfaces))
@@ -675,10 +673,8 @@ int wiphy_register(struct wiphy *wiphy)
 		     !(wiphy->nan_supported_bands & BIT(NL80211_BAND_2GHZ)))))
 		return -EINVAL;
 
-#ifndef CONFIG_WIRELESS_WDS
 	if (WARN_ON(wiphy->interface_modes & BIT(NL80211_IFTYPE_WDS)))
 		return -EINVAL;
-#endif
 
 	if (WARN_ON(wiphy->pmsr_capa && !wiphy->pmsr_capa->ftm.supported))
 		return -EINVAL;
@@ -1202,9 +1198,6 @@ void __cfg80211_leave(struct cfg80211_registered_device *rdev,
 	case NL80211_IFTYPE_OCB:
 		__cfg80211_leave_ocb(rdev, dev);
 		break;
-	case NL80211_IFTYPE_WDS:
-		/* must be handled by mac80211/driver, has no APIs */
-		break;
 	case NL80211_IFTYPE_P2P_DEVICE:
 	case NL80211_IFTYPE_NAN:
 		/* cannot happen, has no netdev */
@@ -1214,6 +1207,7 @@ void __cfg80211_leave(struct cfg80211_registered_device *rdev,
 		/* nothing to do */
 		break;
 	case NL80211_IFTYPE_UNSPECIFIED:
+	case NL80211_IFTYPE_WDS:
 	case NUM_NL80211_IFTYPES:
 		/* invalid */
 		break;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index aad37e7c7f91..b76bdc8417c4 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1885,7 +1885,6 @@ static int nl80211_add_commands_unsplit(struct cfg80211_registered_device *rdev,
 		if (nla_put_u32(msg, i, NL80211_CMD_SET_CHANNEL))
 			goto nla_put_failure;
 	}
-	CMD(set_wds_peer, SET_WDS_PEER);
 	if (rdev->wiphy.flags & WIPHY_FLAG_SUPPORTS_TDLS) {
 		CMD(tdls_mgmt, TDLS_MGMT);
 		CMD(tdls_oper, TDLS_OPER);
@@ -2863,8 +2862,8 @@ static int parse_txq_params(struct nlattr *tb[],
 static bool nl80211_can_set_dev_channel(struct wireless_dev *wdev)
 {
 	/*
-	 * You can only set the channel explicitly for WDS interfaces,
-	 * all others have their channel managed via their respective
+	 * You can only set the channel explicitly for some interfaces,
+	 * most have their channel managed via their respective
 	 * "establish a connection" command (connect, join, ...)
 	 *
 	 * For AP/GO and mesh mode, the channel can be set with the
@@ -3069,29 +3068,6 @@ static int nl80211_set_channel(struct sk_buff *skb, struct genl_info *info)
 	return __nl80211_set_channel(rdev, netdev, info);
 }
 
-static int nl80211_set_wds_peer(struct sk_buff *skb, struct genl_info *info)
-{
-	struct cfg80211_registered_device *rdev = info->user_ptr[0];
-	struct net_device *dev = info->user_ptr[1];
-	struct wireless_dev *wdev = dev->ieee80211_ptr;
-	const u8 *bssid;
-
-	if (!info->attrs[NL80211_ATTR_MAC])
-		return -EINVAL;
-
-	if (netif_running(dev))
-		return -EBUSY;
-
-	if (!rdev->ops->set_wds_peer)
-		return -EOPNOTSUPP;
-
-	if (wdev->iftype != NL80211_IFTYPE_WDS)
-		return -EOPNOTSUPP;
-
-	bssid = nla_data(info->attrs[NL80211_ATTR_MAC]);
-	return rdev_set_wds_peer(rdev, dev, bssid);
-}
-
 static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev;
@@ -15173,14 +15149,6 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.internal_flags = NL80211_FLAG_NEED_NETDEV |
 				  NL80211_FLAG_NEED_RTNL,
 	},
-	{
-		.cmd = NL80211_CMD_SET_WDS_PEER,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = nl80211_set_wds_peer,
-		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV |
-				  NL80211_FLAG_NEED_RTNL,
-	},
 	{
 		.cmd = NL80211_CMD_JOIN_MESH,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 950d57494168..5e2f349c92a8 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -582,16 +582,6 @@ static inline int rdev_get_tx_power(struct cfg80211_registered_device *rdev,
 	return ret;
 }
 
-static inline int rdev_set_wds_peer(struct cfg80211_registered_device *rdev,
-				    struct net_device *dev, const u8 *addr)
-{
-	int ret;
-	trace_rdev_set_wds_peer(&rdev->wiphy, dev, addr);
-	ret = rdev->ops->set_wds_peer(&rdev->wiphy, dev, addr);
-	trace_rdev_return_int(&rdev->wiphy, ret);
-	return ret;
-}
-
 static inline int
 rdev_set_multicast_to_unicast(struct cfg80211_registered_device *rdev,
 			      struct net_device *dev,
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 6e218a0acd4e..817c6fef13be 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -838,11 +838,6 @@ DEFINE_EVENT(wiphy_netdev_mac_evt, rdev_del_mpath,
 	TP_ARGS(wiphy, netdev, mac)
 );
 
-DEFINE_EVENT(wiphy_netdev_mac_evt, rdev_set_wds_peer,
-	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev, const u8 *mac),
-	TP_ARGS(wiphy, netdev, mac)
-);
-
 TRACE_EVENT(rdev_dump_station,
 	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev, int _idx,
 		 u8 *mac),
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 5b6c80ae564a..5af88037f1fb 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -550,8 +550,7 @@ int ieee80211_data_to_8023_exthdr(struct sk_buff *skb, struct ethhdr *ehdr,
 			return -1;
 		break;
 	case cpu_to_le16(IEEE80211_FCTL_TODS | IEEE80211_FCTL_FROMDS):
-		if (unlikely(iftype != NL80211_IFTYPE_WDS &&
-			     iftype != NL80211_IFTYPE_MESH_POINT &&
+		if (unlikely(iftype != NL80211_IFTYPE_MESH_POINT &&
 			     iftype != NL80211_IFTYPE_AP_VLAN &&
 			     iftype != NL80211_IFTYPE_STATION))
 			return -1;
@@ -1051,7 +1050,6 @@ int cfg80211_change_iface(struct cfg80211_registered_device *rdev,
 		case NL80211_IFTYPE_P2P_GO:
 		case NL80211_IFTYPE_AP:
 		case NL80211_IFTYPE_AP_VLAN:
-		case NL80211_IFTYPE_WDS:
 		case NL80211_IFTYPE_MESH_POINT:
 			/* bridging OK */
 			break;
@@ -1063,6 +1061,7 @@ int cfg80211_change_iface(struct cfg80211_registered_device *rdev,
 			/* not happening */
 			break;
 		case NL80211_IFTYPE_P2P_DEVICE:
+		case NL80211_IFTYPE_WDS:
 		case NL80211_IFTYPE_NAN:
 			WARN_ON(1);
 			break;
diff --git a/net/wireless/wext-compat.c b/net/wireless/wext-compat.c
index 78f2927ead7f..b84a345b2653 100644
--- a/net/wireless/wext-compat.c
+++ b/net/wireless/wext-compat.c
@@ -49,9 +49,6 @@ int cfg80211_wext_siwmode(struct net_device *dev, struct iw_request_info *info,
 	case IW_MODE_ADHOC:
 		type = NL80211_IFTYPE_ADHOC;
 		break;
-	case IW_MODE_REPEAT:
-		type = NL80211_IFTYPE_WDS;
-		break;
 	case IW_MODE_MONITOR:
 		type = NL80211_IFTYPE_MONITOR;
 		break;
@@ -1150,50 +1147,6 @@ static int cfg80211_wext_giwpower(struct net_device *dev,
 	return 0;
 }
 
-static int cfg80211_wds_wext_siwap(struct net_device *dev,
-				   struct iw_request_info *info,
-				   struct sockaddr *addr, char *extra)
-{
-	struct wireless_dev *wdev = dev->ieee80211_ptr;
-	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
-	int err;
-
-	if (WARN_ON(wdev->iftype != NL80211_IFTYPE_WDS))
-		return -EINVAL;
-
-	if (addr->sa_family != ARPHRD_ETHER)
-		return -EINVAL;
-
-	if (netif_running(dev))
-		return -EBUSY;
-
-	if (!rdev->ops->set_wds_peer)
-		return -EOPNOTSUPP;
-
-	err = rdev_set_wds_peer(rdev, dev, (u8 *)&addr->sa_data);
-	if (err)
-		return err;
-
-	memcpy(&wdev->wext.bssid, (u8 *) &addr->sa_data, ETH_ALEN);
-
-	return 0;
-}
-
-static int cfg80211_wds_wext_giwap(struct net_device *dev,
-				   struct iw_request_info *info,
-				   struct sockaddr *addr, char *extra)
-{
-	struct wireless_dev *wdev = dev->ieee80211_ptr;
-
-	if (WARN_ON(wdev->iftype != NL80211_IFTYPE_WDS))
-		return -EINVAL;
-
-	addr->sa_family = ARPHRD_ETHER;
-	memcpy(&addr->sa_data, wdev->wext.bssid, ETH_ALEN);
-
-	return 0;
-}
-
 static int cfg80211_wext_siwrate(struct net_device *dev,
 				 struct iw_request_info *info,
 				 struct iw_param *rate, char *extra)
@@ -1371,8 +1324,6 @@ static int cfg80211_wext_siwap(struct net_device *dev,
 		return cfg80211_ibss_wext_siwap(dev, info, ap_addr, extra);
 	case NL80211_IFTYPE_STATION:
 		return cfg80211_mgd_wext_siwap(dev, info, ap_addr, extra);
-	case NL80211_IFTYPE_WDS:
-		return cfg80211_wds_wext_siwap(dev, info, ap_addr, extra);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -1389,8 +1340,6 @@ static int cfg80211_wext_giwap(struct net_device *dev,
 		return cfg80211_ibss_wext_giwap(dev, info, ap_addr, extra);
 	case NL80211_IFTYPE_STATION:
 		return cfg80211_mgd_wext_giwap(dev, info, ap_addr, extra);
-	case NL80211_IFTYPE_WDS:
-		return cfg80211_wds_wext_giwap(dev, info, ap_addr, extra);
 	default:
 		return -EOPNOTSUPP;
 	}
-- 
2.26.2

