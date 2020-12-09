Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA2D2D4514
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 16:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgLIPGn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 10:06:43 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:23625 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbgLIPGm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 10:06:42 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607526380; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=JODP5lY+2kTHRo+xM0Iy9J2o/0Pip92k4HsgRmc1Y+E=; b=TBqQiSjyUONNEifVxmGrVDejyt+nMCqNShzbzB2E8CRLrnQlZa6GvFJGnTmM8yL6jaOC/B7D
 fAc7580L5OGX0zjLpVY8sQa4xdXYThktkmv3C4/6Qr7oOKlcimxeoqia0HoOw1pI+D5zCxA+
 gSQgN+85aPe/obRH/HGOOzZdPO0=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5fd0e7d26d5c2f1d209d12dd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 09 Dec 2020 15:05:54
 GMT
Sender: usdutt=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 37983C433C6; Wed,  9 Dec 2020 15:05:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from usdutt-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: usdutt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3E876C433CA;
        Wed,  9 Dec 2020 15:05:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3E876C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=usdutt@codeaurora.org
From:   Sunil Dutt <usdutt@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Subject: [RFC] Introduce NL80211_IFTYPE_MLO_LINK_DEVICE for MLO link (IEEE 802.11be)
Date:   Wed,  9 Dec 2020 07:05:02 -0800
Message-Id: <1607526302-8063-1-git-send-email-usdutt@codeaurora.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Multi-link support is introduced in 802.11be specification. This enables
Wi-Fi devices with multiple radios to use these links simultaneously for
data transfer.
This commit introduces a new interface type to represent an MLO link
for an MLO connection.

A Wi-Fi station's MLO connection to AP shall have multiple links
represented by an MLO link and each link need to carry the respective
connection information e.g., Connection State, Connected BSS Info,
Connection Frequency/properties, etc.
Thus, each MLO link of an MLO connection is represented by a wdev of
type NL80211_IFTYPE_MLO_LINK_DEVICE.
A MLO link wdev does not have an active netdev associated to it but will
be similar to that of NL80211_IFTYPE_STATION wdev with respect to
maintaining connection state information and providing the required
operations to establish an MLO link.

One of these MLO Links (wdev’s) needs to be the MLD interface of the MLO
connection and this will be the wdev with NL80211_IFTYPE_STATION which
has a netdev interface associated.
A MLO station can have multiple links to an MLO AP and thus the MLD-wdev
interface has to relate to all such MLO link's-wdev's.
MLD wdev and MLO link wdev's can also be on different wiphy's if the
host driver's register a single wiphy for each supported band/MAC/PHY.

MLO link wdev (NL80211_IFTYPE_MLO_LINK_DEVICE) is created by the userspace
prior the MLO connection.

struct cfg80211_connect_resp_params is now enhanced to also carry MLO
link specific (wdev) information along with the connection result.
Accordingly, cfg8011 shall get the information of the associated
MLO link's for the MLO connection and will notify the same to the
userspace.
User space entities will be able to configure the keys ( GTK / IGTK )
or any other MLO link specific information on the respective MLO link
wdev.

Please note that the enhancements in this commit are aimed to initiate
the design review. These changes have not yet been tested.

Also, this commit highlights the main areas that would need changes and
would need additional enhancements to make it complete.
One instance on this aspect is to consider a cfg80211 ops to start the
mlo link device (say start_mlo_link_device) for either the STA or AP
interface. This interface shall pair with stop_mlo_link_device and
thus provide the option for the user space to start/stop a specicic
MLO link. This again can be an optional interface which can be used
at the discretion of the driver architectures (driver's implicitly
starting an MLO link need not rely on this control from user space).

Signed-off-by: Sunil Dutt <usdutt@codeaurora.org>
---
 include/net/cfg80211.h       | 24 ++++++++++++++++++++++++
 include/uapi/linux/nl80211.h | 12 ++++++++++++
 net/wireless/chan.c          |  3 +++
 net/wireless/core.c          | 34 ++++++++++++++++++++++++++++++++++
 net/wireless/core.h          |  3 +++
 net/wireless/nl80211.c       | 44 +++++++++++++++++++++++++++++++++++++++++---
 net/wireless/rdev-ops.h      |  8 ++++++++
 net/wireless/sme.c           | 43 +++++++++++++++++++++++++++++++++++++++++--
 net/wireless/trace.h         |  5 +++++
 net/wireless/util.c          |  4 ++++
 10 files changed, 175 insertions(+), 5 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 9678d32..cea3b14 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -3935,6 +3935,7 @@ struct mgmt_frame_regs {
  *	This callback may sleep.
  * @reset_tid_config: Reset TID specific configuration for the peer, for the
  *	given TIDs. This callback may sleep.
+ * @stop_mlo_link_device: Stop the MLO Link device.
  */
 struct cfg80211_ops {
 	int	(*suspend)(struct wiphy *wiphy, struct cfg80211_wowlan *wow);
@@ -4260,6 +4261,8 @@ struct cfg80211_ops {
 				  struct cfg80211_tid_config *tid_conf);
 	int	(*reset_tid_config)(struct wiphy *wiphy, struct net_device *dev,
 				    const u8 *peer, u8 tids);
+	void    (*stop_mlo_link_device)(struct wiphy *wiphy,
+				    struct wireless_dev *wdev);
 };
 
 /*
@@ -5248,6 +5251,12 @@ struct cfg80211_cqm_config;
  * @pmsr_free_wk: (private) peer measurements cleanup work
  * @unprot_beacon_reported: (private) timestamp of last
  *	unprotected beacon report
+ * @mlo_list: Used to collect the MLO links. Applicable for iftype
+ *	NL80211_IFTYPE_MLO_LINK_DEVICE.
+ * @mlo_link_wdev_list: MLO Link wdev's list associated for the current
+ *	MLO connection. Applicable for iftype NL80211_IFTYPE_STATION.
+ * @mld_wdev: MLD (MLO Data) wdev associated for the MLO link wdev for
+ *	an MLO connection. Applicable for iftype NL80211_IFTYPE_MLO_LINK_DEVICE.
  */
 struct wireless_dev {
 	struct wiphy *wiphy;
@@ -5327,6 +5336,9 @@ struct wireless_dev {
 	struct work_struct pmsr_free_wk;
 
 	unsigned long unprot_beacon_reported;
+	struct list_head mlo_list;
+	struct list_head mlo_link_wdev_list;
+	struct wireless_dev *mld_wdev;
 };
 
 static inline u8 *wdev_address(struct wireless_dev *wdev)
@@ -6828,6 +6840,16 @@ struct cfg80211_fils_resp_params {
 };
 
 /**
+ * struct cfg80211_mlo_link_device_params - MLO Link device params.
+ * @wdev: the wireless device associated with the MLO Link device.
+ * @bss: Entry of bss to which MLO Link got connected to.
+ */
+struct cfg80211_mlo_link_device_params {
+	struct wireless_dev *wdev;
+	struct cfg80211_bss *bss;
+};
+
+/**
  * struct cfg80211_connect_resp_params - Connection response params
  * @status: Status code, %WLAN_STATUS_SUCCESS for successful connection, use
  *	%WLAN_STATUS_UNSPECIFIED_FAILURE if your device cannot give you
@@ -6866,6 +6888,8 @@ struct cfg80211_connect_resp_params {
 	size_t resp_ie_len;
 	struct cfg80211_fils_resp_params fils;
 	enum nl80211_timeout_reason timeout_reason;
+	const struct cfg80211_mlo_link_device_params *mlo_links;
+	int n_mlo_links;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 3e0d4a0..2b01e4f 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2534,6 +2534,11 @@ enum nl80211_commands {
  *	This is a u8 attribute that encapsulates one of the values from
  *	&enum nl80211_sae_pwe_mechanism.
  *
+ * @NL80211_ATTR_MLO_LINK_INFO: MLO Links connection information.
+ *	It is a nested attribute, carrying the MLO links connection information.
+ *	Carries the %NL80211_ATTR_WIPHY, %NL80211_ATTR_WDEV, of each MLO Link
+ *	device, along with the connected BSSID for that link through
+ *	%NL80211_ATTR_MAC.
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3025,6 +3030,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_SAE_PWE,
 
+	NL80211_ATTR_MLO_LINK_INFO,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -3110,6 +3117,7 @@ enum nl80211_attrs {
  * @NL80211_IF_TYPE_OCB: Outside Context of a BSS
  *	This mode corresponds to the MIB variable dot11OCBActivated=true
  * @NL80211_IFTYPE_NAN: NAN device interface type (not a netdev)
+ * @NL80211_IFTYPE_MLO_LINK_DEVICE: MLO Link device interface type (not a netdev).
  * @NL80211_IFTYPE_MAX: highest interface type number currently defined
  * @NUM_NL80211_IFTYPES: number of defined interface types
  *
@@ -3131,6 +3139,7 @@ enum nl80211_iftype {
 	NL80211_IFTYPE_P2P_DEVICE,
 	NL80211_IFTYPE_OCB,
 	NL80211_IFTYPE_NAN,
+	NL80211_IFTYPE_MLO_LINK_DEVICE,
 
 	/* keep last */
 	NUM_NL80211_IFTYPES,
@@ -5908,6 +5917,8 @@ enum nl80211_feature_flags {
  * @NL80211_EXT_FEATURE_BEACON_RATE_HE: Driver supports beacon rate
  *	configuration (AP/mesh) with HE rates.
  *
+ * @NL80211_EXT_FEATURE_MLO: Driver/device supports MLO (Multi Link Operation).
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -5969,6 +5980,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_FILS_DISCOVERY,
 	NL80211_EXT_FEATURE_UNSOL_BCAST_PROBE_RESP,
 	NL80211_EXT_FEATURE_BEACON_RATE_HE,
+	NL80211_EXT_FEATURE_MLO,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index e4030f1..1a5bb09 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -532,6 +532,7 @@ int cfg80211_chandef_dfs_required(struct wiphy *wiphy,
 	case NL80211_IFTYPE_AP_VLAN:
 	case NL80211_IFTYPE_P2P_DEVICE:
 	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_MLO_LINK_DEVICE:
 		break;
 	case NL80211_IFTYPE_WDS:
 	case NL80211_IFTYPE_UNSPECIFIED:
@@ -678,6 +679,7 @@ bool cfg80211_beaconing_iface_active(struct wireless_dev *wdev)
 	case NL80211_IFTYPE_MONITOR:
 	case NL80211_IFTYPE_AP_VLAN:
 	case NL80211_IFTYPE_P2P_DEVICE:
+	case NL80211_IFTYPE_MLO_LINK_DEVICE:
 	/* Can NAN type be considered as beaconing interface? */
 	case NL80211_IFTYPE_NAN:
 		break;
@@ -1278,6 +1280,7 @@ cfg80211_get_chan_state(struct wireless_dev *wdev,
 		break;
 	case NL80211_IFTYPE_STATION:
 	case NL80211_IFTYPE_P2P_CLIENT:
+	case NL80211_IFTYPE_MLO_LINK_DEVICE:
 		if (wdev->current_bss) {
 			*chan = wdev->current_bss->pub.channel;
 			*chanmode = CHAN_MODE_SHARED;
diff --git a/net/wireless/core.c b/net/wireless/core.c
index f6b744e..24aab59 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -261,6 +261,31 @@ void cfg80211_stop_nan(struct cfg80211_registered_device *rdev,
 	rdev->opencount--;
 }
 
+void cfg80211_stop_mlo_link_device(struct cfg80211_registered_device *rdev,
+				   struct wireless_dev *wdev)
+{
+	ASSERT_RTNL();
+
+	if (WARN_ON(wdev->iftype != NL80211_IFTYPE_MLO_LINK_DEVICE))
+		return;
+
+	if (!wdev_running(wdev))
+		return;
+
+	rdev_stop_mlo_link_device(rdev, wdev);
+	wdev->is_running = false;
+
+	rdev->opencount--;
+
+	if (rdev->scan_req && rdev->scan_req->wdev == wdev) {
+		if (WARN_ON(!rdev->scan_req->notified &&
+			    (!rdev->int_scan_req ||
+			     !rdev->int_scan_req->notified)))
+			rdev->scan_req->info.aborted = true;
+		___cfg80211_scan_done(rdev, false);
+	}
+}
+
 void cfg80211_shutdown_all_interfaces(struct wiphy *wiphy)
 {
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
@@ -281,6 +306,9 @@ void cfg80211_shutdown_all_interfaces(struct wiphy *wiphy)
 		case NL80211_IFTYPE_NAN:
 			cfg80211_stop_nan(rdev, wdev);
 			break;
+		case NL80211_IFTYPE_MLO_LINK_DEVICE:
+			cfg80211_stop_mlo_link_device(rdev, wdev);
+			break;
 		default:
 			break;
 		}
@@ -1118,6 +1146,9 @@ static void __cfg80211_unregister_wdev(struct wireless_dev *wdev, bool sync)
 	case NL80211_IFTYPE_NAN:
 		cfg80211_stop_nan(rdev, wdev);
 		break;
+	case NL80211_IFTYPE_MLO_LINK_DEVICE:
+		cfg80211_stop_mlo_link_device(rdev, wdev);
+		break;
 	default:
 		break;
 	}
@@ -1200,6 +1231,7 @@ void __cfg80211_leave(struct cfg80211_registered_device *rdev,
 		break;
 	case NL80211_IFTYPE_P2P_DEVICE:
 	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_MLO_LINK_DEVICE:
 		/* cannot happen, has no netdev */
 		break;
 	case NL80211_IFTYPE_AP_VLAN:
@@ -1254,6 +1286,8 @@ void cfg80211_init_wdev(struct cfg80211_registered_device *rdev,
 	spin_lock_init(&wdev->mgmt_registrations_lock);
 	INIT_LIST_HEAD(&wdev->pmsr_list);
 	spin_lock_init(&wdev->pmsr_lock);
+	INIT_LIST_HEAD(&wdev->mlo_link_wdev_list);
+	INIT_LIST_HEAD(&wdev->mlo_list);
 	INIT_WORK(&wdev->pmsr_free_wk, cfg80211_pmsr_free_wk);
 
 	/*
diff --git a/net/wireless/core.h b/net/wireless/core.h
index e1ec9ac..785d7c6 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -532,6 +532,9 @@ void cfg80211_leave(struct cfg80211_registered_device *rdev,
 void cfg80211_stop_p2p_device(struct cfg80211_registered_device *rdev,
 			      struct wireless_dev *wdev);
 
+void cfg80211_stop_mlo_link_device(struct cfg80211_registered_device *rdev,
+				   struct wireless_dev *wdev);
+
 void cfg80211_stop_nan(struct cfg80211_registered_device *rdev,
 		       struct wireless_dev *wdev);
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index b76bdc8..189ca2c 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -718,6 +718,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_SAE_PWE] =
 		NLA_POLICY_RANGE(NLA_U8, NL80211_SAE_PWE_HUNT_AND_PECK,
 				 NL80211_SAE_PWE_BOTH),
+	[NL80211_ATTR_MLO_LINK_INFO] = { .type = NLA_NESTED },
 };
 
 /* policy for the key attributes */
@@ -1400,6 +1401,7 @@ static int nl80211_key_allowed(struct wireless_dev *wdev)
 	case NL80211_IFTYPE_ADHOC:
 	case NL80211_IFTYPE_STATION:
 	case NL80211_IFTYPE_P2P_CLIENT:
+	case NL80211_IFTYPE_MLO_LINK_DEVICE:
 		if (!wdev->current_bss)
 			return -ENOLINK;
 		break;
@@ -3805,6 +3807,7 @@ static int nl80211_new_interface(struct sk_buff *skb, struct genl_info *info)
 		return -EOPNOTSUPP;
 
 	if ((type == NL80211_IFTYPE_P2P_DEVICE || type == NL80211_IFTYPE_NAN ||
+	     type == NL80211_IFTYPE_MLO_LINK_DEVICE ||
 	     rdev->wiphy.features & NL80211_FEATURE_MAC_ON_CREATE) &&
 	    info->attrs[NL80211_ATTR_MAC]) {
 		nla_memcpy(params.macaddr, info->attrs[NL80211_ATTR_MAC],
@@ -3858,11 +3861,13 @@ static int nl80211_new_interface(struct sk_buff *skb, struct genl_info *info)
 		       wdev->mesh_id_up_len);
 		wdev_unlock(wdev);
 		break;
+	case NL80211_IFTYPE_MLO_LINK_DEVICE:
 	case NL80211_IFTYPE_NAN:
 	case NL80211_IFTYPE_P2P_DEVICE:
 		/*
-		 * P2P Device and NAN do not have a netdev, so don't go
-		 * through the netdev notifier and must be added here
+		 * P2P Device, NAN and MLO Link device do not have a netdev,
+		 * so don't go through the netdev notifier and must be added
+		 * here
 		 */
 		cfg80211_init_wdev(rdev, wdev);
 		break;
@@ -11125,6 +11130,7 @@ static int nl80211_register_mgmt(struct sk_buff *skb, struct genl_info *info)
 	case NL80211_IFTYPE_MESH_POINT:
 	case NL80211_IFTYPE_P2P_GO:
 	case NL80211_IFTYPE_P2P_DEVICE:
+	case NL80211_IFTYPE_MLO_LINK_DEVICE:
 		break;
 	case NL80211_IFTYPE_NAN:
 	default:
@@ -11181,6 +11187,7 @@ static int nl80211_tx_mgmt(struct sk_buff *skb, struct genl_info *info)
 	case NL80211_IFTYPE_AP_VLAN:
 	case NL80211_IFTYPE_MESH_POINT:
 	case NL80211_IFTYPE_P2P_GO:
+	case NL80211_IFTYPE_MLO_LINK_DEVICE:
 		break;
 	case NL80211_IFTYPE_NAN:
 	default:
@@ -11305,6 +11312,7 @@ static int nl80211_tx_mgmt_cancel_wait(struct sk_buff *skb, struct genl_info *in
 	case NL80211_IFTYPE_AP_VLAN:
 	case NL80211_IFTYPE_P2P_GO:
 	case NL80211_IFTYPE_P2P_DEVICE:
+	case NL80211_IFTYPE_MLO_LINK_DEVICE:
 		break;
 	case NL80211_IFTYPE_NAN:
 	default:
@@ -16023,10 +16031,14 @@ void nl80211_send_connect_result(struct cfg80211_registered_device *rdev,
 {
 	struct sk_buff *msg;
 	void *hdr;
+	struct nlattr *nested, *nested_mlo_links;
+	struct cfg80211_mlo_link_device_params *mlo_link;
+	int i = 0;
 
 	msg = nlmsg_new(100 + cr->req_ie_len + cr->resp_ie_len +
 			cr->fils.kek_len + cr->fils.pmk_len +
-			(cr->fils.pmkid ? WLAN_PMKID_LEN : 0), gfp);
+			(cr->fils.pmkid ? WLAN_PMKID_LEN : 0) +
+			(cr->n_mlo_links ? cr->n_mlo_links * 32 : 0), gfp);
 	if (!msg)
 		return;
 
@@ -16065,6 +16077,32 @@ void nl80211_send_connect_result(struct cfg80211_registered_device *rdev,
 	       nla_put(msg, NL80211_ATTR_PMKID, WLAN_PMKID_LEN, cr->fils.pmkid)))))
 		goto nla_put_failure;
 
+	if (cr->n_mlo_links) {
+		nested = nla_nest_start(msg, NL80211_ATTR_MLO_LINK_INFO);
+		if (!nested)
+			goto nla_put_failure;
+
+		for (i = 0; i < cr->n_mlo_links; i++) {
+			mlo_link = (struct cfg80211_mlo_link_device_params *)&cr->mlo_links[i];
+			nested_mlo_links = nla_nest_start(msg, i + 1);
+			if (!nested_mlo_links)
+				goto nla_put_failure;
+
+			if ((mlo_link->wdev &&
+			     nla_put_u32(msg, NL80211_ATTR_WIPHY,
+					 wiphy_to_rdev(mlo_link->wdev->wiphy)->wiphy_idx)) ||
+			    (mlo_link->wdev &&
+			     nla_put_u64_64bit(msg, NL80211_ATTR_WDEV, wdev_id(mlo_link->wdev),
+					       NL80211_ATTR_PAD)) ||
+			    (mlo_link->bss &&
+			     nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, mlo_link->bss->bssid)))
+				goto nla_put_failure;
+
+			nla_nest_end(msg, nested_mlo_links);
+		}
+		nla_nest_end(msg, nested);
+	}
+
 	genlmsg_end(msg, hdr);
 
 	genlmsg_multicast_netns(&nl80211_fam, wiphy_net(&rdev->wiphy), msg, 0,
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 5e2f349..68bdfb8 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -1022,6 +1022,14 @@ rdev_nan_change_conf(struct cfg80211_registered_device *rdev,
 	return ret;
 }
 
+static inline void rdev_stop_mlo_link_device(struct cfg80211_registered_device *rdev,
+					     struct wireless_dev *wdev)
+{
+	trace_rdev_stop_mlo_link_device(&rdev->wiphy, wdev);
+	rdev->ops->stop_mlo_link_device(&rdev->wiphy, wdev);
+	trace_rdev_return_void(&rdev->wiphy);
+}
+
 static inline int rdev_set_mac_acl(struct cfg80211_registered_device *rdev,
 				   struct net_device *dev,
 				   struct cfg80211_acl_data *params)
diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index 38df713..60a3720 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -682,6 +682,8 @@ void __cfg80211_connect_result(struct net_device *dev,
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	const u8 *country_ie;
+	struct cfg80211_mlo_link_device_params *mlo_link;
+	int i = 0;
 #ifdef CONFIG_CFG80211_WEXT
 	union iwreq_data wrqu;
 #endif
@@ -783,6 +785,20 @@ void __cfg80211_connect_result(struct net_device *dev,
 	regulatory_hint_country_ie(wdev->wiphy, cr->bss->channel->band,
 				   country_ie + 2, country_ie[1]);
 	kfree(country_ie);
+
+	for (i = 0; i < cr->n_mlo_links; i++) {
+		mlo_link = (struct cfg80211_mlo_link_device_params *)&cr->mlo_links[i];
+		if (mlo_link->wdev) {
+			list_add_rcu(&mlo_link->wdev->mlo_list, &wdev->mlo_link_wdev_list);
+			mlo_link->wdev->mld_wdev = wdev;
+			if (mlo_link->bss) {
+				mlo_link->wdev->current_bss = bss_from_pub(mlo_link->bss);
+				cfg80211_hold_bss(bss_from_pub(mlo_link->bss));
+			}
+			mlo_link->wdev->is_running = true;
+			wiphy_to_rdev(mlo_link->wdev->wiphy)->opencount++;
+		}
+	}
 }
 
 /* Consumes bss object one way or another */
@@ -833,7 +849,9 @@ void cfg80211_connect_done(struct net_device *dev,
 	ev = kzalloc(sizeof(*ev) + (params->bssid ? ETH_ALEN : 0) +
 		     params->req_ie_len + params->resp_ie_len +
 		     params->fils.kek_len + params->fils.pmk_len +
-		     (params->fils.pmkid ? WLAN_PMKID_LEN : 0), gfp);
+		     (params->fils.pmkid ? WLAN_PMKID_LEN : 0) +
+		     (params->n_mlo_links ? params->n_mlo_links *
+		      sizeof(struct cfg80211_mlo_link_device_params) : 0), gfp);
 	if (!ev) {
 		cfg80211_put_bss(wdev->wiphy, params->bss);
 		return;
@@ -880,6 +898,14 @@ void cfg80211_connect_done(struct net_device *dev,
 		       WLAN_PMKID_LEN);
 		next += WLAN_PMKID_LEN;
 	}
+	if (params->n_mlo_links) {
+		ev->cr.mlo_links = (struct cfg80211_mlo_link_device_params *)next;
+		memcpy((void *)ev->cr.mlo_links, params->mlo_links,
+		       params->n_mlo_links *
+		       sizeof(struct cfg80211_mlo_link_device_params));
+		next += params->n_mlo_links *
+			sizeof(struct cfg80211_mlo_link_device_params);
+	}
 	ev->cr.fils.update_erp_next_seq_num = params->fils.update_erp_next_seq_num;
 	if (params->fils.update_erp_next_seq_num)
 		ev->cr.fils.erp_next_seq_num = params->fils.erp_next_seq_num;
@@ -888,6 +914,7 @@ void cfg80211_connect_done(struct net_device *dev,
 	ev->cr.bss = params->bss;
 	ev->cr.status = params->status;
 	ev->cr.timeout_reason = params->timeout_reason;
+	ev->cr.n_mlo_links = params->n_mlo_links;
 
 	spin_lock_irqsave(&wdev->event_lock, flags);
 	list_add_tail(&ev->list, &wdev->event_list);
@@ -1077,7 +1104,7 @@ EXPORT_SYMBOL(cfg80211_port_authorized);
 void __cfg80211_disconnected(struct net_device *dev, const u8 *ie,
 			     size_t ie_len, u16 reason, bool from_ap)
 {
-	struct wireless_dev *wdev = dev->ieee80211_ptr;
+	struct wireless_dev *wdev = dev->ieee80211_ptr, *mlo_wdev;
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
 	int i;
 #ifdef CONFIG_CFG80211_WEXT
@@ -1136,6 +1163,18 @@ void __cfg80211_disconnected(struct net_device *dev, const u8 *ie,
 	wdev->wext.connect.ssid_len = 0;
 #endif
 
+	list_for_each_entry(mlo_wdev, &wdev->mlo_link_wdev_list, mlo_list) {
+		cfg80211_stop_mlo_link_device(wiphy_to_rdev(mlo_wdev->wiphy), mlo_wdev);
+		list_del_rcu(&mlo_wdev->mlo_list);
+		mlo_wdev->mld_wdev = NULL;
+		if (mlo_wdev->current_bss) {
+			cfg80211_unhold_bss(mlo_wdev->current_bss);
+			cfg80211_put_bss(mlo_wdev->wiphy, &wdev->current_bss->pub);
+		}
+		mlo_wdev->current_bss = NULL;
+		mlo_wdev->ssid_len = 0;
+	}
+
 	schedule_work(&cfg80211_disconnect_work);
 }
 
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 817c6fe..93f06eb 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -2139,6 +2139,11 @@ TRACE_EVENT(rdev_set_mac_acl,
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->acl_policy)
 );
 
+DEFINE_EVENT(wiphy_wdev_evt, rdev_stop_mlo_link_device,
+	     TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev),
+	     TP_ARGS(wiphy, wdev)
+);
+
 TRACE_EVENT(rdev_update_ft_ies,
 	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
 		 struct cfg80211_update_ft_ies_params *ftie),
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 5af8803..c592bb7 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1017,6 +1017,8 @@ int cfg80211_change_iface(struct cfg80211_registered_device *rdev,
 					    WLAN_REASON_DEAUTH_LEAVING, true);
 			wdev_unlock(dev->ieee80211_ptr);
 			break;
+		case NL80211_IFTYPE_MLO_LINK_DEVICE:
+			break;
 		case NL80211_IFTYPE_MESH_POINT:
 			/* mesh should be handled? */
 			break;
@@ -1065,6 +1067,8 @@ int cfg80211_change_iface(struct cfg80211_registered_device *rdev,
 		case NL80211_IFTYPE_NAN:
 			WARN_ON(1);
 			break;
+		case NL80211_IFTYPE_MLO_LINK_DEVICE:
+			break;
 		}
 	}
 
-- 
2.7.4

