Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD6C4BFC6A
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Feb 2022 16:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbiBVPYH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Feb 2022 10:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbiBVPYE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Feb 2022 10:24:04 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C56E114766
        for <linux-wireless@vger.kernel.org>; Tue, 22 Feb 2022 07:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645543417; x=1677079417;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=9kQl2686FHeVrITngDth8n4jVDA8XxxfjrLVwk3IYX4=;
  b=Dw87wy6pZI3+ZkA78P2ziPDBOVQi1ViU6gTRBkqRx93W/D5kcAEVE4P4
   mN7GpViZMwMQUUzt2RG4ceLT9HqsS5gxSETQ5OIUM228X8fOX7mE8UXqz
   n+FdQS+36vE0VDNnI9oVi/EzPLbcLqFxjvdt3W0jKZi2A6kpFniDtBn5U
   I=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 22 Feb 2022 07:23:37 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 07:23:36 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 22 Feb 2022 07:23:36 -0800
Received: from hu-vjakkam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 22 Feb 2022 07:23:34 -0800
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <quic_usdutt@quicinc.com>
Subject: [PATCH 2/3] cfg80211: Indicate MLO links info in connect/roam events
Date:   Tue, 22 Feb 2022 20:53:12 +0530
Message-ID: <1645543393-22448-3-git-send-email-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1645543393-22448-1-git-send-email-quic_vjakkam@quicinc.com>
References: <1645543393-22448-1-git-send-email-quic_vjakkam@quicinc.com>
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

Add support for drivers to send MLO links info associated in current
connection in connect and roam cfg80211 callbacks on MLD STA wdev and
send the info to the userspace through corresponding netlink events
from cfg80211.

Signed-off-by: Sunil Dutt <quic_usdutt@quicinc.com>
Co-developed-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
 include/net/cfg80211.h       | 32 +++++++++++++++++
 include/uapi/linux/nl80211.h | 14 ++++++++
 net/wireless/chan.c          | 20 ++++++++++-
 net/wireless/core.c          |  1 +
 net/wireless/core.h          |  4 +++
 net/wireless/nl80211.c       | 83 ++++++++++++++++++++++++++++++++++++++++----
 net/wireless/scan.c          | 25 +++++++++++++
 net/wireless/sme.c           | 79 +++++++++++++++++++++++++++++++++++++++--
 8 files changed, 248 insertions(+), 10 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 8298bec..f000e87 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2735,6 +2735,9 @@ struct cfg80211_auth_request {
  *	userspace if this flag is set. Only applicable for cfg80211_connect()
  *	request (connect callback).
  * @ASSOC_REQ_DISABLE_HE:  Disable HE
+ * @ASSOC_MLO_SUPPORT: Userspace indicates support for handling MLO links.
+ *	Drivers shall disable MLO features for the current association if this
+ *	flag is not set.
  */
 enum cfg80211_assoc_req_flags {
 	ASSOC_REQ_DISABLE_HT			= BIT(0),
@@ -2742,6 +2745,7 @@ enum cfg80211_assoc_req_flags {
 	ASSOC_REQ_USE_RRM			= BIT(2),
 	CONNECT_REQ_EXTERNAL_AUTH_SUPPORT	= BIT(3),
 	ASSOC_REQ_DISABLE_HE			= BIT(4),
+	ASSOC_MLO_SUPPORT			= BIT(5),
 };
 
 /**
@@ -5564,6 +5568,12 @@ static inline void wiphy_unlock(struct wiphy *wiphy)
  * @mld_wdev: points to MLD wdev of type %NL80211_IFTYPE_STATION to which this
  *	MLO link wdev is affiliated to. Valid for iftype
  *	%NL80211_IFTYPE_MLO_LINK only.
+ * @link_bssid: BSSID of the AP associated with the MLO link wdev. Valid for
+ *	iftype %NL80211_IFTYPE_MLO_LINK. Scan result of the BSS associated with
+ *	the MLO link may not be available in rdev->bss_list so we can't use
+ *	@current_bss.
+ * @link_id: AP's MLO link ID to which this non-AP station's MLO link wdev is
+ *	associated. Valid only if iftype is %NL80211_IFTYPE_MLO_LINK.
  */
 struct wireless_dev {
 	struct wiphy *wiphy;
@@ -5644,6 +5654,8 @@ struct wireless_dev {
 	unsigned long unprot_beacon_reported;
 
 	struct wireless_dev *mld_wdev;
+	u8 link_bssid[ETH_ALEN];
+	u8 link_id;
 };
 
 static inline const u8 *wdev_address(struct wireless_dev *wdev)
@@ -7172,6 +7184,18 @@ struct cfg80211_fils_resp_params {
 };
 
 /**
+ * struct cfg80211_mlo_link_params - MLO link device params.
+ * @wdev: the wireless device associated with the MLO link device.
+ * @bssid: BSSID of the MLO link to which this MLO link is connected to.
+ * @link_id: Link ID of the AP's MLO link to which this @wdev is connected to.
+ */
+struct cfg80211_mlo_link_params {
+	struct wireless_dev *wdev;
+	u8 bssid[ETH_ALEN];
+	u8 link_id;
+};
+
+/**
  * struct cfg80211_connect_resp_params - Connection response params
  * @status: Status code, %WLAN_STATUS_SUCCESS for successful connection, use
  *	%WLAN_STATUS_UNSPECIFIED_FAILURE if your device cannot give you
@@ -7199,6 +7223,8 @@ struct cfg80211_fils_resp_params {
  *	not known. This value is used only if @status < 0 to indicate that the
  *	failure is due to a timeout and not due to explicit rejection by the AP.
  *	This value is ignored in other cases (@status >= 0).
+ * @mlo_links: Array of each MLO link's connection parameters.
+ * @n_mlo_links: Number of valid links that are indicated in @mlo_links.
  */
 struct cfg80211_connect_resp_params {
 	int status;
@@ -7210,6 +7236,8 @@ struct cfg80211_connect_resp_params {
 	size_t resp_ie_len;
 	struct cfg80211_fils_resp_params fils;
 	enum nl80211_timeout_reason timeout_reason;
+	const struct cfg80211_mlo_link_params *mlo_links;
+	int n_mlo_links;
 };
 
 /**
@@ -7359,6 +7387,8 @@ cfg80211_connect_timeout(struct net_device *dev, const u8 *bssid,
  * @resp_ie: association response IEs (may be %NULL)
  * @resp_ie_len: assoc response IEs length
  * @fils: FILS related roaming information.
+ * @mlo_links: Array of each MLO link's connection parameters.
+ * @n_mlo_links: Number of valid links that are indicated in @mlo_links.
  */
 struct cfg80211_roam_info {
 	struct ieee80211_channel *channel;
@@ -7369,6 +7399,8 @@ struct cfg80211_roam_info {
 	const u8 *resp_ie;
 	size_t resp_ie_len;
 	struct cfg80211_fils_resp_params fils;
+	const struct cfg80211_mlo_link_params *mlo_links;
+	int n_mlo_links;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 4f3e15a..191bc80 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2667,7 +2667,15 @@ enum nl80211_commands {
  *	%NL80211_IFTYPE_STA interface. This is used in
  *	%NL80211_CMD_GET/SET/NEW_INTERFACE response to indicate information of
  *	all the MLO links affiliated to %NL80211_IFTYPE_STATION interface.
+ *	This is also used with %NL80211_CMD_CONNECT and %NL80211_CMD_ROAM events
+ *	to indicate associated MLO links information for current connection.
  *	See &enum nl80211_mlo_link_info_attributes for details.
+ * @NL80211_ATTR_MLO_SUPPORT: Flag attribute to indicate that the user space
+ *	supports MLO connection. This is used with %NL80211_CMD_CONNECT or
+ *	%NL80211_CMD_ASSOCIATE. The driver shall use MLO link wdevs in
+ *	connection only when userpsace indicates support for MLO connection.
+ *	Using MLO links without userspace support may lead to disconnection
+ *	since RSN connection in MLO needs supplicant support.
  *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
@@ -3182,6 +3190,7 @@ enum nl80211_attrs {
 	NL80211_ATTR_EHT_CAPABILITY,
 
 	NL80211_ATTR_MLO_LINK_INFO,
+	NL80211_ATTR_MLO_SUPPORT,
 
 	/* add attributes here, update the policy in nl80211.c */
 
@@ -7622,6 +7631,9 @@ enum nl80211_ap_settings_flags {
  *
  * @NL80211_MLO_LINK_INFO_ATTR_WDEV: wireless device identifier for MLO link
  *	(u64)
+ * @NL80211_MLO_LINK_INFO_ATTR_BSSID: BSSID associated with this MLO link
+ *	(6 octets).
+ * @NL80211_MLO_LINK_INFO_ATTR_LINK_ID: link id of associated BSSID (u8)
  *
  * @__NL80211_MLO_LINK_INFO_ATTR_LAST: Internal
  * @NL80211_MLO_LINK_INFO_ATTR_MAX: highest attribute
@@ -7630,6 +7642,8 @@ enum nl80211_mlo_link_info_attributes {
 	__NL80211_MLO_LINK_INFO_ATTR_INVALID,
 
 	NL80211_MLO_LINK_INFO_ATTR_WDEV,
+	NL80211_MLO_LINK_INFO_ATTR_BSSID,
+	NL80211_MLO_LINK_INFO_ATTR_LINK_ID,
 
 	/* keep last */
 	__NL80211_MLO_LINK_INFO_ATTR_LAST,
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index c9495cd..941b892 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -1386,6 +1386,25 @@ cfg80211_get_chan_state(struct wireless_dev *wdev,
 			return;
 		}
 		break;
+	case NL80211_IFTYPE_MLO_LINK:
+		if (!is_zero_ether_addr(wdev->link_bssid)) {
+			if (!memcmp(wdev->link_bssid,
+				    wdev->mld_wdev->current_bss->pub.bssid,
+				    ETH_ALEN))
+				*chan = wdev->current_bss->pub.channel;
+			else
+				*chan = cfg80211_get_colocated_ap_chan(
+						wiphy_to_rdev(wdev->wiphy),
+						wdev->mld_wdev->current_bss,
+						wdev->link_bssid);
+
+			if (WARN_ON(!*chan))
+				return;
+
+			*chanmode = CHAN_MODE_SHARED;
+			return;
+		}
+		break;
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_P2P_GO:
 		if (wdev->cac_started) {
@@ -1432,7 +1451,6 @@ cfg80211_get_chan_state(struct wireless_dev *wdev,
 		return;
 	case NL80211_IFTYPE_UNSPECIFIED:
 	case NL80211_IFTYPE_WDS:
-	case NL80211_IFTYPE_MLO_LINK:
 	case NUM_NL80211_IFTYPES:
 		WARN_ON(1);
 	}
diff --git a/net/wireless/core.c b/net/wireless/core.c
index a036e60..68e3ae1 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1360,6 +1360,7 @@ void cfg80211_init_wdev(struct wireless_dev *wdev)
 
 	INIT_WORK(&wdev->disconnect_wk, cfg80211_autodisconnect_wk);
 	wdev->mld_wdev = NULL;
+	eth_zero_addr(wdev->link_bssid);
 }
 
 void cfg80211_register_wdev(struct cfg80211_registered_device *rdev,
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 2258df9..f3a5d7a 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -579,5 +579,9 @@ void cfg80211_start_mlo_link(struct cfg80211_registered_device *rdev,
 			     struct wireless_dev *wdev);
 void cfg80211_stop_mlo_link(struct cfg80211_registered_device *rdev,
 			    struct wireless_dev *wdev);
+struct ieee80211_channel *
+cfg80211_get_colocated_ap_chan(struct cfg80211_registered_device *rdev,
+			       struct cfg80211_internal_bss *intbss,
+			       const u8 *colocated_bssid);
 
 #endif /* __NET_WIRELESS_CORE_H */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 81e5959..37f483f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -790,6 +790,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 		NLA_POLICY_RANGE(NLA_BINARY,
 				 NL80211_EHT_MIN_CAPABILITY_LEN,
 				 NL80211_EHT_MAX_CAPABILITY_LEN),
+	[NL80211_ATTR_MLO_SUPPORT] = { .type = NLA_FLAG },
 };
 
 /* policy for the key attributes */
@@ -1499,13 +1500,16 @@ static int nl80211_key_allowed(struct wireless_dev *wdev)
 		if (!wdev->current_bss)
 			return -ENOLINK;
 		break;
+	case NL80211_IFTYPE_MLO_LINK:
+		if (is_zero_ether_addr(wdev->link_bssid))
+			return -ENOLINK;
+		break;
 	case NL80211_IFTYPE_UNSPECIFIED:
 	case NL80211_IFTYPE_OCB:
 	case NL80211_IFTYPE_MONITOR:
 	case NL80211_IFTYPE_NAN:
 	case NL80211_IFTYPE_P2P_DEVICE:
 	case NL80211_IFTYPE_WDS:
-	case NL80211_IFTYPE_MLO_LINK:
 	case NUM_NL80211_IFTYPES:
 		return -EINVAL;
 	}
@@ -3757,6 +3761,13 @@ static int nl80211_send_iface(struct sk_buff *msg, u32 portid, u32 seq, int flag
 				      wdev_id(link_wdev), NL80211_ATTR_PAD))
 			goto nla_put_failure_locked;
 
+		if (!is_zero_ether_addr(link_wdev->link_bssid) &&
+		    (nla_put(msg, NL80211_MLO_LINK_INFO_ATTR_BSSID, ETH_ALEN,
+			     link_wdev->link_bssid) ||
+		     nla_put_u8(msg, NL80211_MLO_LINK_INFO_ATTR_LINK_ID,
+				link_wdev->link_id)))
+			goto nla_put_failure_locked;
+
 		nla_nest_end(msg, nested_mlo_links);
 		i++;
 	}
@@ -10439,6 +10450,9 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 		req.flags |= ASSOC_REQ_USE_RRM;
 	}
 
+	if (nla_get_flag(info->attrs[NL80211_ATTR_MLO_SUPPORT]))
+		req.flags |= ASSOC_MLO_SUPPORT;
+
 	if (info->attrs[NL80211_ATTR_FILS_KEK]) {
 		req.fils_kek = nla_data(info->attrs[NL80211_ATTR_FILS_KEK]);
 		req.fils_kek_len = nla_len(info->attrs[NL80211_ATTR_FILS_KEK]);
@@ -11291,6 +11305,9 @@ static int nl80211_connect(struct sk_buff *skb, struct genl_info *info)
 		connect.flags |= CONNECT_REQ_EXTERNAL_AUTH_SUPPORT;
 	}
 
+	if (nla_get_flag(info->attrs[NL80211_ATTR_MLO_SUPPORT]))
+		connect.flags |= ASSOC_MLO_SUPPORT;
+
 	wdev_lock(dev->ieee80211_ptr);
 
 	err = cfg80211_connect(rdev, dev, &connect, connkeys,
@@ -16813,6 +16830,42 @@ void nl80211_send_assoc_timeout(struct cfg80211_registered_device *rdev,
 				  addr, gfp);
 }
 
+static int
+nl80211_put_mlo_link_params(struct sk_buff *msg,
+			    const struct cfg80211_mlo_link_params *mlo_links,
+			    int n_mlo_links)
+{
+	struct nlattr *nested, *nested_mlo_links;
+	int i;
+
+	if (n_mlo_links) {
+		nested = nla_nest_start(msg, NL80211_ATTR_MLO_LINK_INFO);
+		if (!nested)
+			return -ENOBUFS;
+
+		for (i = 0; i < n_mlo_links; i++) {
+			nested_mlo_links = nla_nest_start(msg, i + 1);
+			if (!nested_mlo_links)
+				return -ENOBUFS;
+
+			if (nla_put_u64_64bit(msg,
+					      NL80211_MLO_LINK_INFO_ATTR_WDEV,
+					      wdev_id(mlo_links[i].wdev),
+					      NL80211_ATTR_PAD) ||
+			    nla_put(msg, NL80211_MLO_LINK_INFO_ATTR_BSSID,
+				    ETH_ALEN, mlo_links[i].bssid) ||
+			    nla_put_u8(msg, NL80211_MLO_LINK_INFO_ATTR_LINK_ID,
+				       mlo_links[i].link_id))
+				return -ENOBUFS;
+
+			nla_nest_end(msg, nested_mlo_links);
+		}
+		nla_nest_end(msg, nested);
+	}
+
+	return 0;
+}
+
 void nl80211_send_connect_result(struct cfg80211_registered_device *rdev,
 				 struct net_device *netdev,
 				 struct cfg80211_connect_resp_params *cr,
@@ -16820,10 +16873,15 @@ void nl80211_send_connect_result(struct cfg80211_registered_device *rdev,
 {
 	struct sk_buff *msg;
 	void *hdr;
+	int mlo_link_info_size = cr->n_mlo_links *
+				 (nla_total_size_64bit(sizeof(u64)) +
+				  nla_total_size(ETH_ALEN) +
+				  nla_total_size(sizeof(u8)));
 
 	msg = nlmsg_new(100 + cr->req_ie_len + cr->resp_ie_len +
 			cr->fils.kek_len + cr->fils.pmk_len +
-			(cr->fils.pmkid ? WLAN_PMKID_LEN : 0), gfp);
+			(cr->fils.pmkid ? WLAN_PMKID_LEN : 0) +
+			mlo_link_info_size, gfp);
 	if (!msg)
 		return;
 
@@ -16862,6 +16920,9 @@ void nl80211_send_connect_result(struct cfg80211_registered_device *rdev,
 	       nla_put(msg, NL80211_ATTR_PMKID, WLAN_PMKID_LEN, cr->fils.pmkid)))))
 		goto nla_put_failure;
 
+	if (nl80211_put_mlo_link_params(msg, cr->mlo_links, cr->n_mlo_links))
+		goto nla_put_failure;
+
 	genlmsg_end(msg, hdr);
 
 	genlmsg_multicast_netns(&nl80211_fam, wiphy_net(&rdev->wiphy), msg, 0,
@@ -16879,10 +16940,16 @@ void nl80211_send_roamed(struct cfg80211_registered_device *rdev,
 	struct sk_buff *msg;
 	void *hdr;
 	const u8 *bssid = info->bss ? info->bss->bssid : info->bssid;
-
-	msg = nlmsg_new(100 + info->req_ie_len + info->resp_ie_len +
-			info->fils.kek_len + info->fils.pmk_len +
-			(info->fils.pmkid ? WLAN_PMKID_LEN : 0), gfp);
+	int mlo_link_info_size = info->n_mlo_links *
+				 (nla_total_size_64bit(sizeof(u64)) +
+				  nla_total_size(ETH_ALEN) +
+				  nla_total_size(sizeof(u8)));
+
+	msg = nlmsg_new(100 + info->req_ie_len +
+			info->resp_ie_len + info->fils.kek_len +
+			info->fils.pmk_len +
+			(info->fils.pmkid ? WLAN_PMKID_LEN : 0) +
+			mlo_link_info_size, gfp);
 	if (!msg)
 		return;
 
@@ -16913,6 +16980,10 @@ void nl80211_send_roamed(struct cfg80211_registered_device *rdev,
 	     nla_put(msg, NL80211_ATTR_PMKID, WLAN_PMKID_LEN, info->fils.pmkid)))
 		goto nla_put_failure;
 
+	if (nl80211_put_mlo_link_params(msg, info->mlo_links,
+					info->n_mlo_links))
+		goto nla_put_failure;
+
 	genlmsg_end(msg, hdr);
 
 	genlmsg_multicast_netns(&nl80211_fam, wiphy_net(&rdev->wiphy), msg, 0,
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index b2fdac9..9ec8434 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2706,6 +2706,31 @@ void cfg80211_update_assoc_bss_entry(struct wireless_dev *wdev,
 	spin_unlock_bh(&rdev->bss_lock);
 }
 
+struct ieee80211_channel *
+cfg80211_get_colocated_ap_chan(struct cfg80211_registered_device *rdev,
+			       struct cfg80211_internal_bss *intbss,
+			       const u8 *colocated_bssid)
+{
+	struct cfg80211_colocated_ap *ap;
+	LIST_HEAD(coloc_ap_list);
+	struct cfg80211_bss *res = &intbss->pub;
+	const struct cfg80211_bss_ies *ies = rcu_access_pointer(res->ies);
+	struct ieee80211_channel *chan = NULL;
+
+	cfg80211_parse_colocated_ap(ies, &coloc_ap_list);
+
+	list_for_each_entry(ap, &coloc_ap_list, list) {
+		if (memcmp(colocated_bssid, ap->bssid, ETH_ALEN))
+			continue;
+
+		chan = ieee80211_get_channel(&rdev->wiphy, ap->center_freq);
+		break;
+	}
+
+	cfg80211_free_coloc_ap_list(&coloc_ap_list);
+	return chan;
+}
+
 #ifdef CONFIG_CFG80211_WEXT
 static struct cfg80211_registered_device *
 cfg80211_get_dev_from_ifindex(struct net *net, int ifindex)
diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index ff4d48fc..5d76e52 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -680,9 +680,12 @@ void __cfg80211_connect_result(struct net_device *dev,
 			       bool wextev)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
+	struct wireless_dev *link_wdev;
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
 	const struct element *country_elem;
 	const u8 *country_data;
 	u8 country_datalen;
+	int i;
 #ifdef CONFIG_CFG80211_WEXT
 	union iwreq_data wrqu;
 #endif
@@ -763,6 +766,25 @@ void __cfg80211_connect_result(struct net_device *dev,
 	if (!(wdev->wiphy->flags & WIPHY_FLAG_HAS_STATIC_WEP))
 		cfg80211_upload_connect_keys(wdev);
 
+	list_for_each_entry(link_wdev, &rdev->wiphy.wdev_list, list) {
+		if (link_wdev->mld_wdev != wdev)
+			continue;
+
+		eth_zero_addr(link_wdev->link_bssid);
+	}
+
+	for (i = 0; i < cr->n_mlo_links; i++) {
+		list_for_each_entry(link_wdev, &rdev->wiphy.wdev_list, list) {
+			if (link_wdev != cr->mlo_links[i].wdev)
+				continue;
+
+			link_wdev->link_id = cr->mlo_links[i].link_id;
+			memcpy(link_wdev->link_bssid, cr->mlo_links[i].bssid,
+			       ETH_ALEN);
+			break;
+		}
+	}
+
 	rcu_read_lock();
 	country_elem = ieee80211_bss_get_elem(cr->bss, WLAN_EID_COUNTRY);
 	if (!country_elem) {
@@ -792,6 +814,8 @@ void cfg80211_connect_done(struct net_device *dev,
 	struct cfg80211_event *ev;
 	unsigned long flags;
 	u8 *next;
+	int mlo_link_params_size =
+		params->n_mlo_links * sizeof(struct cfg80211_mlo_link_params);
 
 	if (params->bss) {
 		struct cfg80211_internal_bss *ibss = bss_from_pub(params->bss);
@@ -830,7 +854,8 @@ void cfg80211_connect_done(struct net_device *dev,
 	ev = kzalloc(sizeof(*ev) + (params->bssid ? ETH_ALEN : 0) +
 		     params->req_ie_len + params->resp_ie_len +
 		     params->fils.kek_len + params->fils.pmk_len +
-		     (params->fils.pmkid ? WLAN_PMKID_LEN : 0), gfp);
+		     (params->fils.pmkid ? WLAN_PMKID_LEN : 0) +
+		     mlo_link_params_size, gfp);
 	if (!ev) {
 		cfg80211_put_bss(wdev->wiphy, params->bss);
 		return;
@@ -877,6 +902,13 @@ void cfg80211_connect_done(struct net_device *dev,
 		       WLAN_PMKID_LEN);
 		next += WLAN_PMKID_LEN;
 	}
+	if (params->n_mlo_links) {
+		ev->cr.n_mlo_links = params->n_mlo_links;
+		ev->cr.mlo_links = (struct cfg80211_mlo_link_params *)next;
+		memcpy((void *)ev->cr.mlo_links, params->mlo_links,
+		       mlo_link_params_size);
+		next += mlo_link_params_size;
+	}
 	ev->cr.fils.update_erp_next_seq_num = params->fils.update_erp_next_seq_num;
 	if (params->fils.update_erp_next_seq_num)
 		ev->cr.fils.erp_next_seq_num = params->fils.erp_next_seq_num;
@@ -900,6 +932,10 @@ void __cfg80211_roamed(struct wireless_dev *wdev,
 #ifdef CONFIG_CFG80211_WEXT
 	union iwreq_data wrqu;
 #endif
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
+	struct wireless_dev *link_wdev;
+	int i;
+
 	ASSERT_WDEV_LOCK(wdev);
 
 	if (WARN_ON(wdev->iftype != NL80211_IFTYPE_STATION &&
@@ -923,6 +959,26 @@ void __cfg80211_roamed(struct wireless_dev *wdev,
 	nl80211_send_roamed(wiphy_to_rdev(wdev->wiphy),
 			    wdev->netdev, info, GFP_KERNEL);
 
+	list_for_each_entry(link_wdev, &rdev->wiphy.wdev_list, list) {
+		if (link_wdev->mld_wdev != wdev)
+			continue;
+
+		eth_zero_addr(link_wdev->link_bssid);
+	}
+
+	for (i = 0; i < info->n_mlo_links; i++) {
+		list_for_each_entry(link_wdev, &rdev->wiphy.wdev_list, list) {
+			if (link_wdev != info->mlo_links[i].wdev)
+				continue;
+
+			link_wdev->link_id = info->mlo_links[i].link_id;
+			memcpy((void *)link_wdev->link_bssid,
+			       info->mlo_links[i].bssid,
+			       ETH_ALEN);
+			break;
+		}
+	}
+
 #ifdef CONFIG_CFG80211_WEXT
 	if (info->req_ie) {
 		memset(&wrqu, 0, sizeof(wrqu));
@@ -960,6 +1016,8 @@ void cfg80211_roamed(struct net_device *dev, struct cfg80211_roam_info *info,
 	struct cfg80211_event *ev;
 	unsigned long flags;
 	u8 *next;
+	int mlo_link_params_size =
+		info->n_mlo_links * sizeof(struct cfg80211_mlo_link_params);
 
 	if (!info->bss) {
 		info->bss = cfg80211_get_bss(wdev->wiphy, info->channel,
@@ -974,7 +1032,8 @@ void cfg80211_roamed(struct net_device *dev, struct cfg80211_roam_info *info,
 
 	ev = kzalloc(sizeof(*ev) + info->req_ie_len + info->resp_ie_len +
 		     info->fils.kek_len + info->fils.pmk_len +
-		     (info->fils.pmkid ? WLAN_PMKID_LEN : 0), gfp);
+		     (info->fils.pmkid ? WLAN_PMKID_LEN : 0) +
+		     mlo_link_params_size, gfp);
 	if (!ev) {
 		cfg80211_put_bss(wdev->wiphy, info->bss);
 		return;
@@ -1015,6 +1074,13 @@ void cfg80211_roamed(struct net_device *dev, struct cfg80211_roam_info *info,
 		       WLAN_PMKID_LEN);
 		next += WLAN_PMKID_LEN;
 	}
+	if (info->n_mlo_links) {
+		ev->rm.n_mlo_links = info->n_mlo_links;
+		ev->rm.mlo_links = (struct cfg80211_mlo_link_params *)next;
+		memcpy((void *)ev->rm.mlo_links, info->mlo_links,
+		       mlo_link_params_size);
+		next += mlo_link_params_size;
+	}
 	ev->rm.fils.update_erp_next_seq_num = info->fils.update_erp_next_seq_num;
 	if (info->fils.update_erp_next_seq_num)
 		ev->rm.fils.erp_next_seq_num = info->fils.erp_next_seq_num;
@@ -1074,7 +1140,7 @@ EXPORT_SYMBOL(cfg80211_port_authorized);
 void __cfg80211_disconnected(struct net_device *dev, const u8 *ie,
 			     size_t ie_len, u16 reason, bool from_ap)
 {
-	struct wireless_dev *wdev = dev->ieee80211_ptr;
+	struct wireless_dev *wdev = dev->ieee80211_ptr, *link_wdev;
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
 	int i;
 #ifdef CONFIG_CFG80211_WEXT
@@ -1133,6 +1199,13 @@ void __cfg80211_disconnected(struct net_device *dev, const u8 *ie,
 	wdev->wext.connect.ssid_len = 0;
 #endif
 
+	list_for_each_entry(link_wdev, &rdev->wiphy.wdev_list, list) {
+		if (link_wdev->mld_wdev != wdev)
+			continue;
+
+		eth_zero_addr(wdev->link_bssid);
+	}
+
 	schedule_work(&cfg80211_disconnect_work);
 }
 
-- 
2.7.4

