Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B634C10A2
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Feb 2022 11:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239710AbiBWKra (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Feb 2022 05:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239702AbiBWKr3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Feb 2022 05:47:29 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C016459A7F
        for <linux-wireless@vger.kernel.org>; Wed, 23 Feb 2022 02:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645613221; x=1677149221;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=xNg6HZuS0517rQ0aax8RVvw7J/U+klowaPBRDRQzJ0w=;
  b=skslHM1BewPjoxLAlAdcbroaq9Yvxb3Fq+BDDiiOrGe0IuoXgRKXO+mt
   IvtG3rbX6ZshgUaiPNEq/6236vq+ky/AEhN48pcJn0n73sScfF6Bid56X
   tVvaMH6RBGEyGede4guZ4jUcUAgdI86w+xRxIYaUnNfYHblRpYwa3GUj8
   s=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 23 Feb 2022 02:47:01 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 02:47:01 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 23 Feb 2022 02:47:01 -0800
Received: from hu-vjakkam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 23 Feb 2022 02:46:58 -0800
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <quic_usdutt@quicinc.com>
Subject: [PATCH v2 1/3] cfg80211: Add NL80211_IFTYPE_MLO_LINK type for MLO links on MLD STA
Date:   Wed, 23 Feb 2022 16:16:38 +0530
Message-ID: <1645613200-30221-2-git-send-email-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1645613200-30221-1-git-send-email-quic_vjakkam@quicinc.com>
References: <1645613200-30221-1-git-send-email-quic_vjakkam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sunil Dutt <quic_usdutt@quicinc.com>

Multi-Link Operation(MLO) introduced in 802.11be specification enables
Multi-Link Devices(MLD) to discover, associate and operate with multiple
links. Define new interface type(NL80211_IFTYPE_MLO_LINK) to represent
each individual MLO link that is affiliated to the non-AP MLD.

A non-AP MLD which supports MLO operation is represented by the
NL80211_IFTYPE_STATION associated with netdev interface. Each individual
MLO link affiliated to the non-AP MLD interface is represented by the
NL80211_IFTYPE_MLO_LINK type wdev. The NL80211_IFTYPE_MLO_LINK type
wdevs are not associated with a separate netdev.

Two link non-AP MLD representation:

                 wlan0 (non-AP MLD)
               IFTYPE_STATION (netdev + wdev)
                 /               \
                /                 \
              link0             link1
      IFTYPE_MLO_LINK (wdev)  IFTYPE_MLO_LINK (wdev)
              |                   |
              |                   |
            radio(2G)           radio(5G)

In contrast, NL80211_IFTYPE_MLO_LINK can't be used to represent AP MLO
link since an MLD AP must support pre-11be and 11be clients
simultaneously so each AP MLO link affiliated with AP MLD must also act
as independent AP for pre-11be clients so each AP MLO link must be
represented by NL80211_IFTYPE_AP associated with a separate netdev.

Two link AP MLD representation:

                 AP MLD
             (netdev + wdev)
                /      \
               /        \
          wlan0          wlan1
      IFTYPE_AP       IFTYPE_AP
   (netdev + wdev)  (netdev + wdev)
           |             |
           |             |
        radio(2G)      radio(5G)

Drivers must register and affiliate MLO link wdev to MLD STA wdev using
cfg80211_register_sta_mlo_link() for each of the MLO link it supports.
MLD STA wdev and MLO Link wdevs must belong to the same wiphy.

If driver indicates support for NL80211_IFTYPE_MLO_LINK in wiphy
capabilities userspace can consider driver supports MLO in STA mode.
Userspace can determine MLO link wdevs associated with MLD STA wdev with
NL80211_ATTR_MLO_LINK_INFO advertised in MLD STA wdev interface info.

Signed-off-by: Sunil Dutt <quic_usdutt@quicinc.com>
Co-developed-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
 include/net/cfg80211.h       | 34 +++++++++++++++
 include/uapi/linux/nl80211.h | 36 ++++++++++++++++
 net/mac80211/cfg.c           |  1 +
 net/mac80211/chan.c          |  2 +
 net/mac80211/iface.c         |  2 +
 net/mac80211/util.c          |  1 +
 net/wireless/chan.c          |  3 ++
 net/wireless/core.c          | 99 +++++++++++++++++++++++++++++++++++++++++++-
 net/wireless/core.h          |  4 ++
 net/wireless/nl80211.c       | 45 +++++++++++++++++++-
 net/wireless/util.c          |  1 +
 11 files changed, 226 insertions(+), 2 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 6871338..8298bec 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5561,6 +5561,9 @@ static inline void wiphy_unlock(struct wiphy *wiphy)
  * @pmsr_free_wk: (private) peer measurements cleanup work
  * @unprot_beacon_reported: (private) timestamp of last
  *	unprotected beacon report
+ * @mld_wdev: points to MLD wdev of type %NL80211_IFTYPE_STATION to which this
+ *	MLO link wdev is affiliated to. Valid for iftype
+ *	%NL80211_IFTYPE_MLO_LINK only.
  */
 struct wireless_dev {
 	struct wiphy *wiphy;
@@ -5639,6 +5642,8 @@ struct wireless_dev {
 	struct work_struct pmsr_free_wk;
 
 	unsigned long unprot_beacon_reported;
+
+	struct wireless_dev *mld_wdev;
 };
 
 static inline const u8 *wdev_address(struct wireless_dev *wdev)
@@ -8198,6 +8203,35 @@ void cfg80211_stop_iface(struct wiphy *wiphy, struct wireless_dev *wdev,
 			 gfp_t gfp);
 
 /**
+ * cfg80211_register_sta_mlo_link - Register an MLO link wdev and affiliate
+ *	with STA wdev.
+ * @sta_wdev: wireless device of a non-AP Station interface
+ * @link_wdev: wireless device of an MLO link affiliated to the Station
+ *	Iface(@sta_wdev).
+ *
+ * Create a wdev interface for an MLO link and associate it with existing MLD
+ * STA wdev. Both MLD STA wdev and MLO link wdev must belong to same wiphy.
+ * Driver must register all the MLO link wdevs with MLD STA wdev before
+ * STA wdev interface is up. Callers must hold the RTNL and wiphy mutex lock.
+ *
+ * Return: A zero on success or a negative error code.
+ */
+int cfg80211_register_sta_mlo_link(struct wireless_dev *sta_wdev,
+				   struct wireless_dev *link_wdev);
+
+/**
+ * cfg80211_unregister_sta_mlo_link - remove the given MLO link wdev
+ * @wdev: struct wireless_dev of a MLO link to remove
+ *
+ * This function removes the MLO link device so it can no longer be used.
+ * Requires the RTNL and wiphy mutex to be held.
+ */
+static inline void cfg80211_unregister_sta_mlo_link(struct wireless_dev *wdev)
+{
+	cfg80211_unregister_wdev(wdev);
+}
+
+/**
  * cfg80211_shutdown_all_interfaces - shut down all interfaces for a wiphy
  * @wiphy: the wiphy to shut down
  *
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 98ed526..4f3e15a 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2663,6 +2663,12 @@ enum nl80211_commands {
  *	association request when used with NL80211_CMD_NEW_STATION). Can be set
  *	only if %NL80211_STA_FLAG_WME is set.
  *
+ * @NL80211_ATTR_MLO_LINK_INFO: MLO links information associated with
+ *	%NL80211_IFTYPE_STA interface. This is used in
+ *	%NL80211_CMD_GET/SET/NEW_INTERFACE response to indicate information of
+ *	all the MLO links affiliated to %NL80211_IFTYPE_STATION interface.
+ *	See &enum nl80211_mlo_link_info_attributes for details.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3175,6 +3181,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_EHT_CAPABILITY,
 
+	NL80211_ATTR_MLO_LINK_INFO,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -3262,6 +3270,12 @@ enum nl80211_attrs {
  * @NL80211_IF_TYPE_OCB: Outside Context of a BSS
  *	This mode corresponds to the MIB variable dot11OCBActivated=true
  * @NL80211_IFTYPE_NAN: NAN device interface type (not a netdev)
+ * @NL80211_IFTYPE_MLO_LINK: MLO link device interface type, this is not a
+ *	netdev and can't be created in the normal ways. Drivers can
+ *	register and associate this interface with iftype
+ *	%NL80211_IFTYPE_STATION. Drivers shall indicate support for this
+ *	interface mode in %NL80211_ATTR_SUPPORTED_IFTYPES when MLO supported in
+ *	STA mode.
  * @NL80211_IFTYPE_MAX: highest interface type number currently defined
  * @NUM_NL80211_IFTYPES: number of defined interface types
  *
@@ -3283,6 +3297,7 @@ enum nl80211_iftype {
 	NL80211_IFTYPE_P2P_DEVICE,
 	NL80211_IFTYPE_OCB,
 	NL80211_IFTYPE_NAN,
+	NL80211_IFTYPE_MLO_LINK,
 
 	/* keep last */
 	NUM_NL80211_IFTYPES,
@@ -7600,4 +7615,25 @@ enum nl80211_ap_settings_flags {
 	NL80211_AP_SETTINGS_SA_QUERY_OFFLOAD_SUPPORT	= 1 << 1,
 };
 
+/**
+ * enum nl80211_mlo_link_info_attributes - MLO link's information.
+ *
+ * @__NL80211_MLO_LINK_INFO_ATTR_INVALID: Invalid
+ *
+ * @NL80211_MLO_LINK_INFO_ATTR_WDEV: wireless device identifier for MLO link
+ *	(u64)
+ *
+ * @__NL80211_MLO_LINK_INFO_ATTR_LAST: Internal
+ * @NL80211_MLO_LINK_INFO_ATTR_MAX: highest attribute
+ */
+enum nl80211_mlo_link_info_attributes {
+	__NL80211_MLO_LINK_INFO_ATTR_INVALID,
+
+	NL80211_MLO_LINK_INFO_ATTR_WDEV,
+
+	/* keep last */
+	__NL80211_MLO_LINK_INFO_ATTR_LAST,
+	NL80211_MLO_LINK_INFO_ATTR_MAX = __NL80211_MLO_LINK_INFO_ATTR_LAST - 1,
+};
+
 #endif /* __LINUX_NL80211_H */
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index aa45627..67a1602 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -532,6 +532,7 @@ static int ieee80211_add_key(struct wiphy *wiphy, struct net_device *dev,
 	case NL80211_IFTYPE_P2P_CLIENT:
 	case NL80211_IFTYPE_P2P_GO:
 	case NL80211_IFTYPE_OCB:
+	case NL80211_IFTYPE_MLO_LINK:
 		/* shouldn't happen */
 		WARN_ON_ONCE(1);
 		break;
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index e26d42d..7923852 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -291,6 +291,7 @@ ieee80211_get_chanctx_max_required_bw(struct ieee80211_local *local,
 		case NL80211_IFTYPE_MONITOR:
 		case NL80211_IFTYPE_P2P_CLIENT:
 		case NL80211_IFTYPE_P2P_GO:
+		case NL80211_IFTYPE_MLO_LINK:
 			WARN_ON_ONCE(1);
 		}
 		max_bw = max(max_bw, width);
@@ -1094,6 +1095,7 @@ ieee80211_vif_chanctx_reservation_complete(struct ieee80211_sub_if_data *sdata)
 	case NL80211_IFTYPE_P2P_GO:
 	case NL80211_IFTYPE_P2P_DEVICE:
 	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_MLO_LINK:
 	case NUM_NL80211_IFTYPES:
 		WARN_ON(1);
 		break;
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 4153147..6580520 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1177,6 +1177,7 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 	case NL80211_IFTYPE_P2P_CLIENT:
 	case NL80211_IFTYPE_P2P_GO:
 	case NL80211_IFTYPE_WDS:
+	case NL80211_IFTYPE_MLO_LINK:
 		/* cannot happen */
 		WARN_ON(1);
 		break;
@@ -1714,6 +1715,7 @@ static void ieee80211_setup_sdata(struct ieee80211_sub_if_data *sdata,
 		break;
 	case NL80211_IFTYPE_UNSPECIFIED:
 	case NL80211_IFTYPE_WDS:
+	case NL80211_IFTYPE_MLO_LINK:
 	case NUM_NL80211_IFTYPES:
 		WARN_ON(1);
 		break;
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index caea8db..5894de2 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2589,6 +2589,7 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 		case NL80211_IFTYPE_P2P_CLIENT:
 		case NL80211_IFTYPE_P2P_GO:
 		case NL80211_IFTYPE_WDS:
+		case NL80211_IFTYPE_MLO_LINK:
 			WARN_ON(1);
 			break;
 		}
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 8b7fb4a..c9495cd 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -582,6 +582,7 @@ int cfg80211_chandef_dfs_required(struct wiphy *wiphy,
 	case NL80211_IFTYPE_AP_VLAN:
 	case NL80211_IFTYPE_P2P_DEVICE:
 	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_MLO_LINK:
 		break;
 	case NL80211_IFTYPE_WDS:
 	case NL80211_IFTYPE_UNSPECIFIED:
@@ -728,6 +729,7 @@ bool cfg80211_beaconing_iface_active(struct wireless_dev *wdev)
 	case NL80211_IFTYPE_MONITOR:
 	case NL80211_IFTYPE_AP_VLAN:
 	case NL80211_IFTYPE_P2P_DEVICE:
+	case NL80211_IFTYPE_MLO_LINK:
 	/* Can NAN type be considered as beaconing interface? */
 	case NL80211_IFTYPE_NAN:
 		break;
@@ -1430,6 +1432,7 @@ cfg80211_get_chan_state(struct wireless_dev *wdev,
 		return;
 	case NL80211_IFTYPE_UNSPECIFIED:
 	case NL80211_IFTYPE_WDS:
+	case NL80211_IFTYPE_MLO_LINK:
 	case NUM_NL80211_IFTYPES:
 		WARN_ON(1);
 	}
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 3a54c8e..a036e60 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -261,6 +261,36 @@ void cfg80211_stop_nan(struct cfg80211_registered_device *rdev,
 	rdev->opencount--;
 }
 
+void cfg80211_start_mlo_link(struct cfg80211_registered_device *rdev,
+			     struct wireless_dev *wdev)
+{
+	lockdep_assert_held(&rdev->wiphy.mtx);
+
+	if (WARN_ON(wdev->iftype != NL80211_IFTYPE_MLO_LINK))
+		return;
+
+	if (wdev_running(wdev))
+		return;
+
+	wdev->is_running = true;
+	rdev->opencount++;
+}
+
+void cfg80211_stop_mlo_link(struct cfg80211_registered_device *rdev,
+			    struct wireless_dev *wdev)
+{
+	lockdep_assert_held(&rdev->wiphy.mtx);
+
+	if (WARN_ON(wdev->iftype != NL80211_IFTYPE_MLO_LINK))
+		return;
+
+	if (!wdev_running(wdev))
+		return;
+
+	wdev->is_running = false;
+	rdev->opencount--;
+}
+
 void cfg80211_shutdown_all_interfaces(struct wiphy *wiphy)
 {
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
@@ -285,6 +315,9 @@ void cfg80211_shutdown_all_interfaces(struct wiphy *wiphy)
 		case NL80211_IFTYPE_NAN:
 			cfg80211_stop_nan(rdev, wdev);
 			break;
+		case NL80211_IFTYPE_MLO_LINK:
+			/* dev_close() of MLD STA wdev calls MLO link stop */
+			break;
 		default:
 			break;
 		}
@@ -1156,6 +1189,9 @@ static void _cfg80211_unregister_wdev(struct wireless_dev *wdev,
 	case NL80211_IFTYPE_NAN:
 		cfg80211_stop_nan(rdev, wdev);
 		break;
+	case NL80211_IFTYPE_MLO_LINK:
+		cfg80211_stop_mlo_link(rdev, wdev);
+		break;
 	default:
 		break;
 	}
@@ -1257,6 +1293,7 @@ void __cfg80211_leave(struct cfg80211_registered_device *rdev,
 		break;
 	case NL80211_IFTYPE_UNSPECIFIED:
 	case NL80211_IFTYPE_WDS:
+	case NL80211_IFTYPE_MLO_LINK:
 	case NUM_NL80211_IFTYPES:
 		/* invalid */
 		break;
@@ -1322,6 +1359,7 @@ void cfg80211_init_wdev(struct wireless_dev *wdev)
 		wdev->netdev->priv_flags |= IFF_DONT_BRIDGE;
 
 	INIT_WORK(&wdev->disconnect_wk, cfg80211_autodisconnect_wk);
+	wdev->mld_wdev = NULL;
 }
 
 void cfg80211_register_wdev(struct cfg80211_registered_device *rdev,
@@ -1383,11 +1421,48 @@ int cfg80211_register_netdevice(struct net_device *dev)
 }
 EXPORT_SYMBOL(cfg80211_register_netdevice);
 
+int cfg80211_register_sta_mlo_link(struct wireless_dev *sta_wdev,
+				   struct wireless_dev *link_wdev)
+{
+	struct cfg80211_registered_device *rdev;
+	struct wireless_dev *wdev;
+
+	ASSERT_RTNL();
+
+	if (WARN_ON(link_wdev->iftype != NL80211_IFTYPE_MLO_LINK ||
+		    sta_wdev->iftype != NL80211_IFTYPE_STATION ||
+		    sta_wdev->wiphy != link_wdev->wiphy))
+		return -EINVAL;
+
+	rdev = wiphy_to_rdev(sta_wdev->wiphy);
+
+	lockdep_assert_held(&rdev->wiphy.mtx);
+
+	list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list) {
+		if (sta_wdev == wdev)
+			break;
+	}
+
+	if (wdev != sta_wdev)
+		return -ENODEV;
+
+	if (wdev_running(sta_wdev))
+		return -EBUSY;
+
+	cfg80211_init_wdev(link_wdev);
+	link_wdev->mld_wdev = sta_wdev;
+	cfg80211_register_wdev(rdev, link_wdev);
+	nl80211_notify_iface(rdev, sta_wdev, NL80211_CMD_SET_INTERFACE);
+
+	return 0;
+}
+EXPORT_SYMBOL(cfg80211_register_sta_mlo_link);
+
 static int cfg80211_netdev_notifier_call(struct notifier_block *nb,
 					 unsigned long state, void *ptr)
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
-	struct wireless_dev *wdev = dev->ieee80211_ptr;
+	struct wireless_dev *wdev = dev->ieee80211_ptr, *link_wdev, *tmp_wdev;
 	struct cfg80211_registered_device *rdev;
 	struct cfg80211_sched_scan_request *pos, *tmp;
 
@@ -1421,6 +1496,12 @@ static int cfg80211_netdev_notifier_call(struct notifier_block *nb,
 		 */
 		if (wdev->registered && !wdev->registering) {
 			wiphy_lock(&rdev->wiphy);
+			list_for_each_entry_safe(link_wdev, tmp_wdev, &rdev->wiphy.wdev_list, list) {
+				if (link_wdev->mld_wdev != wdev)
+					continue;
+
+				rdev_del_virtual_intf(rdev, link_wdev);
+			}
 			_cfg80211_unregister_wdev(wdev, false);
 			wiphy_unlock(&rdev->wiphy);
 		}
@@ -1448,6 +1529,14 @@ static int cfg80211_netdev_notifier_call(struct notifier_block *nb,
 		}
 
 		rdev->opencount--;
+
+		list_for_each_entry(link_wdev, &rdev->wiphy.wdev_list, list) {
+			if (link_wdev->mld_wdev != wdev)
+				continue;
+
+			cfg80211_stop_mlo_link(rdev, link_wdev);
+		}
+
 		wiphy_unlock(&rdev->wiphy);
 		wake_up(&rdev->dev_wait);
 		break;
@@ -1499,6 +1588,14 @@ static int cfg80211_netdev_notifier_call(struct notifier_block *nb,
 			/* assume this means it's off */
 			wdev->ps = false;
 		}
+
+		list_for_each_entry(link_wdev, &rdev->wiphy.wdev_list, list) {
+			if (link_wdev->mld_wdev != wdev)
+				continue;
+
+			cfg80211_start_mlo_link(rdev, link_wdev);
+		}
+
 		wiphy_unlock(&rdev->wiphy);
 		break;
 	case NETDEV_PRE_UP:
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 3a7dbd6..2258df9 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -575,5 +575,9 @@ void cfg80211_cqm_config_free(struct wireless_dev *wdev);
 void cfg80211_release_pmsr(struct wireless_dev *wdev, u32 portid);
 void cfg80211_pmsr_wdev_down(struct wireless_dev *wdev);
 void cfg80211_pmsr_free_wk(struct work_struct *work);
+void cfg80211_start_mlo_link(struct cfg80211_registered_device *rdev,
+			     struct wireless_dev *wdev);
+void cfg80211_stop_mlo_link(struct cfg80211_registered_device *rdev,
+			    struct wireless_dev *wdev);
 
 #endif /* __NET_WIRELESS_CORE_H */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 7543c73..81e5959 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1505,6 +1505,7 @@ static int nl80211_key_allowed(struct wireless_dev *wdev)
 	case NL80211_IFTYPE_NAN:
 	case NL80211_IFTYPE_P2P_DEVICE:
 	case NL80211_IFTYPE_WDS:
+	case NL80211_IFTYPE_MLO_LINK:
 	case NUM_NL80211_IFTYPES:
 		return -EINVAL;
 	}
@@ -3660,6 +3661,10 @@ static int nl80211_send_iface(struct sk_buff *msg, u32 portid, u32 seq, int flag
 {
 	struct net_device *dev = wdev->netdev;
 	void *hdr;
+	struct wireless_dev *link_wdev;
+	struct nlattr *nested, *nested_mlo_links;
+	int i = 0;
+
 
 	WARN_ON(cmd != NL80211_CMD_NEW_INTERFACE &&
 		cmd != NL80211_CMD_DEL_INTERFACE &&
@@ -3734,6 +3739,30 @@ static int nl80211_send_iface(struct sk_buff *msg, u32 portid, u32 seq, int flag
 		/* nothing */
 		break;
 	}
+
+	nested = nla_nest_start(msg, NL80211_ATTR_MLO_LINK_INFO);
+	if (!nested)
+		goto nla_put_failure_locked;
+
+	list_for_each_entry(link_wdev, &rdev->wiphy.wdev_list, list) {
+		if (link_wdev->iftype != NL80211_IFTYPE_MLO_LINK ||
+		    link_wdev->mld_wdev != wdev)
+			continue;
+
+		nested_mlo_links = nla_nest_start(msg, i);
+		if (!nested_mlo_links)
+			goto nla_put_failure_locked;
+
+		if (nla_put_u64_64bit(msg, NL80211_MLO_LINK_INFO_ATTR_WDEV,
+				      wdev_id(link_wdev), NL80211_ATTR_PAD))
+			goto nla_put_failure_locked;
+
+		nla_nest_end(msg, nested_mlo_links);
+		i++;
+	}
+
+	nla_nest_end(msg, nested);
+
 	wdev_unlock(wdev);
 
 	if (rdev->ops->get_txq_stats) {
@@ -3991,6 +4020,10 @@ static int nl80211_set_interface(struct sk_buff *skb, struct genl_info *info)
 			change = true;
 	}
 
+	if (otype == NL80211_IFTYPE_MLO_LINK ||
+	    ntype == NL80211_IFTYPE_MLO_LINK)
+		return -EOPNOTSUPP;
+
 	if (info->attrs[NL80211_ATTR_MESH_ID]) {
 		struct wireless_dev *wdev = dev->ieee80211_ptr;
 
@@ -4062,6 +4095,9 @@ static int _nl80211_new_interface(struct sk_buff *skb, struct genl_info *info)
 	if (!rdev->ops->add_virtual_intf)
 		return -EOPNOTSUPP;
 
+	if (type == NL80211_IFTYPE_MLO_LINK)
+		return -EOPNOTSUPP;
+
 	if ((type == NL80211_IFTYPE_P2P_DEVICE || type == NL80211_IFTYPE_NAN ||
 	     rdev->wiphy.features & NL80211_FEATURE_MAC_ON_CREATE) &&
 	    info->attrs[NL80211_ATTR_MAC]) {
@@ -4161,6 +4197,9 @@ static int nl80211_del_interface(struct sk_buff *skb, struct genl_info *info)
 	if (!rdev->ops->del_virtual_intf)
 		return -EOPNOTSUPP;
 
+	if (wdev->iftype == NL80211_IFTYPE_MLO_LINK)
+		return -EOPNOTSUPP;
+
 	/*
 	 * We hold RTNL, so this is safe, without RTNL opencount cannot
 	 * reach 0, and thus the rdev cannot be deleted.
@@ -8566,7 +8605,8 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 
 	wiphy = &rdev->wiphy;
 
-	if (wdev->iftype == NL80211_IFTYPE_NAN)
+	if (wdev->iftype == NL80211_IFTYPE_NAN ||
+	    wdev->iftype == NL80211_IFTYPE_MLO_LINK)
 		return -EOPNOTSUPP;
 
 	if (!rdev->ops->scan)
@@ -11692,6 +11732,7 @@ static int nl80211_register_mgmt(struct sk_buff *skb, struct genl_info *info)
 	case NL80211_IFTYPE_P2P_GO:
 	case NL80211_IFTYPE_P2P_DEVICE:
 		break;
+	case NL80211_IFTYPE_MLO_LINK:
 	case NL80211_IFTYPE_NAN:
 	default:
 		return -EOPNOTSUPP;
@@ -11748,6 +11789,7 @@ static int nl80211_tx_mgmt(struct sk_buff *skb, struct genl_info *info)
 	case NL80211_IFTYPE_AP_VLAN:
 	case NL80211_IFTYPE_MESH_POINT:
 	case NL80211_IFTYPE_P2P_GO:
+	case NL80211_IFTYPE_MLO_LINK:
 		break;
 	case NL80211_IFTYPE_NAN:
 	default:
@@ -11872,6 +11914,7 @@ static int nl80211_tx_mgmt_cancel_wait(struct sk_buff *skb, struct genl_info *in
 	case NL80211_IFTYPE_AP_VLAN:
 	case NL80211_IFTYPE_P2P_GO:
 	case NL80211_IFTYPE_P2P_DEVICE:
+	case NL80211_IFTYPE_MLO_LINK:
 		break;
 	case NL80211_IFTYPE_NAN:
 	default:
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 2eda097..e692a17 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1110,6 +1110,7 @@ int cfg80211_change_iface(struct cfg80211_registered_device *rdev,
 		case NL80211_IFTYPE_P2P_DEVICE:
 		case NL80211_IFTYPE_WDS:
 		case NL80211_IFTYPE_NAN:
+		case NL80211_IFTYPE_MLO_LINK:
 			WARN_ON(1);
 			break;
 		}
-- 
2.7.4

