Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 142C72D04FC
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Dec 2020 13:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgLFMzz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Dec 2020 07:55:55 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:34902 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727953AbgLFMzm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Dec 2020 07:55:42 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kltYz-003AHZ-Or; Sun, 06 Dec 2020 14:54:54 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Sun,  6 Dec 2020 14:54:42 +0200
Message-Id: <iwlwifi.20201206145305.58d33941fb9d.I0e7168c205c7949529c8e3b86f3c9b12c01a7017@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201206125450.564941-1-luca@coelho.fi>
References: <20201206125450.564941-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 03/11] cfg80211: support immediate reconnect request hint
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There are cases where it's necessary to disconnect, but an
immediate reconnection is desired. Support a hint to userspace
that this is the case, by including a new attribute in the
deauth or disassoc event.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 include/net/cfg80211.h       |  4 +++-
 include/uapi/linux/nl80211.h |  6 ++++++
 net/mac80211/mlme.c          |  5 +++--
 net/wireless/mlme.c          | 26 +++++++++++++++-----------
 net/wireless/nl80211.c       | 23 +++++++++++++++--------
 net/wireless/nl80211.h       |  8 +++++---
 net/wireless/trace.h         | 12 ++++++++----
 7 files changed, 55 insertions(+), 29 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index f6fc4408ba95..2d4ac810108e 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -6404,13 +6404,15 @@ void cfg80211_abandon_assoc(struct net_device *dev, struct cfg80211_bss *bss);
  * @dev: network device
  * @buf: 802.11 frame (header + body)
  * @len: length of the frame data
+ * @reconnect: immediate reconnect is desired (include the nl80211 attribute)
  *
  * This function is called whenever deauthentication has been processed in
  * station mode. This includes both received deauthentication frames and
  * locally generated ones. This function may sleep. The caller must hold the
  * corresponding wdev's mutex.
  */
-void cfg80211_tx_mlme_mgmt(struct net_device *dev, const u8 *buf, size_t len);
+void cfg80211_tx_mlme_mgmt(struct net_device *dev, const u8 *buf, size_t len,
+			   bool reconnect);
 
 /**
  * cfg80211_rx_unprot_mlme_mgmt - notification of unprotected mlme mgmt frame
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 3e0d4a038ab6..241ced71dabb 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2534,6 +2534,10 @@ enum nl80211_commands {
  *	This is a u8 attribute that encapsulates one of the values from
  *	&enum nl80211_sae_pwe_mechanism.
  *
+ * @NL80211_ATTR_RECONNECT_REQUESTED: flag attribute, used with deauth and
+ *	disassoc events to indicate that an immediate reconnect to the AP
+ *	is desired.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3025,6 +3029,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_SAE_PWE,
 
+	NL80211_ATTR_RECONNECT_REQUESTED,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 6adfcb9c06dc..673a1838691c 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2729,7 +2729,7 @@ static void ieee80211_report_disconnect(struct ieee80211_sub_if_data *sdata,
 	};
 
 	if (tx)
-		cfg80211_tx_mlme_mgmt(sdata->dev, buf, len);
+		cfg80211_tx_mlme_mgmt(sdata->dev, buf, len, false);
 	else
 		cfg80211_rx_mlme_mgmt(sdata->dev, buf, len);
 
@@ -4716,7 +4716,8 @@ void ieee80211_mgd_quiesce(struct ieee80211_sub_if_data *sdata)
 		if (ifmgd->auth_data)
 			ieee80211_destroy_auth_data(sdata, false);
 		cfg80211_tx_mlme_mgmt(sdata->dev, frame_buf,
-				      IEEE80211_DEAUTH_FRAME_LEN);
+				      IEEE80211_DEAUTH_FRAME_LEN,
+				      false);
 	}
 
 	/* This is a bit of a hack - we should find a better and more generic
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 0ac820780437..e1e90761dc00 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -4,7 +4,7 @@
  *
  * Copyright (c) 2009, Jouni Malinen <j@w1.fi>
  * Copyright (c) 2015		Intel Deutschland GmbH
- * Copyright (C) 2019 Intel Corporation
+ * Copyright (C) 2019-2020 Intel Corporation
  */
 
 #include <linux/kernel.h>
@@ -81,7 +81,8 @@ static void cfg80211_process_auth(struct wireless_dev *wdev,
 }
 
 static void cfg80211_process_deauth(struct wireless_dev *wdev,
-				    const u8 *buf, size_t len)
+				    const u8 *buf, size_t len,
+				    bool reconnect)
 {
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
 	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)buf;
@@ -89,7 +90,7 @@ static void cfg80211_process_deauth(struct wireless_dev *wdev,
 	u16 reason_code = le16_to_cpu(mgmt->u.deauth.reason_code);
 	bool from_ap = !ether_addr_equal(mgmt->sa, wdev->netdev->dev_addr);
 
-	nl80211_send_deauth(rdev, wdev->netdev, buf, len, GFP_KERNEL);
+	nl80211_send_deauth(rdev, wdev->netdev, buf, len, reconnect, GFP_KERNEL);
 
 	if (!wdev->current_bss ||
 	    !ether_addr_equal(wdev->current_bss->pub.bssid, bssid))
@@ -100,7 +101,8 @@ static void cfg80211_process_deauth(struct wireless_dev *wdev,
 }
 
 static void cfg80211_process_disassoc(struct wireless_dev *wdev,
-				      const u8 *buf, size_t len)
+				      const u8 *buf, size_t len,
+				      bool reconnect)
 {
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
 	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)buf;
@@ -108,7 +110,8 @@ static void cfg80211_process_disassoc(struct wireless_dev *wdev,
 	u16 reason_code = le16_to_cpu(mgmt->u.disassoc.reason_code);
 	bool from_ap = !ether_addr_equal(mgmt->sa, wdev->netdev->dev_addr);
 
-	nl80211_send_disassoc(rdev, wdev->netdev, buf, len, GFP_KERNEL);
+	nl80211_send_disassoc(rdev, wdev->netdev, buf, len, reconnect,
+			      GFP_KERNEL);
 
 	if (WARN_ON(!wdev->current_bss ||
 		    !ether_addr_equal(wdev->current_bss->pub.bssid, bssid)))
@@ -133,9 +136,9 @@ void cfg80211_rx_mlme_mgmt(struct net_device *dev, const u8 *buf, size_t len)
 	if (ieee80211_is_auth(mgmt->frame_control))
 		cfg80211_process_auth(wdev, buf, len);
 	else if (ieee80211_is_deauth(mgmt->frame_control))
-		cfg80211_process_deauth(wdev, buf, len);
+		cfg80211_process_deauth(wdev, buf, len, false);
 	else if (ieee80211_is_disassoc(mgmt->frame_control))
-		cfg80211_process_disassoc(wdev, buf, len);
+		cfg80211_process_disassoc(wdev, buf, len, false);
 }
 EXPORT_SYMBOL(cfg80211_rx_mlme_mgmt);
 
@@ -180,22 +183,23 @@ void cfg80211_abandon_assoc(struct net_device *dev, struct cfg80211_bss *bss)
 }
 EXPORT_SYMBOL(cfg80211_abandon_assoc);
 
-void cfg80211_tx_mlme_mgmt(struct net_device *dev, const u8 *buf, size_t len)
+void cfg80211_tx_mlme_mgmt(struct net_device *dev, const u8 *buf, size_t len,
+			   bool reconnect)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct ieee80211_mgmt *mgmt = (void *)buf;
 
 	ASSERT_WDEV_LOCK(wdev);
 
-	trace_cfg80211_tx_mlme_mgmt(dev, buf, len);
+	trace_cfg80211_tx_mlme_mgmt(dev, buf, len, reconnect);
 
 	if (WARN_ON(len < 2))
 		return;
 
 	if (ieee80211_is_deauth(mgmt->frame_control))
-		cfg80211_process_deauth(wdev, buf, len);
+		cfg80211_process_deauth(wdev, buf, len, reconnect);
 	else
-		cfg80211_process_disassoc(wdev, buf, len);
+		cfg80211_process_disassoc(wdev, buf, len, reconnect);
 }
 EXPORT_SYMBOL(cfg80211_tx_mlme_mgmt);
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 8811a4b69f21..e71c703f56f5 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -718,6 +718,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_SAE_PWE] =
 		NLA_POLICY_RANGE(NLA_U8, NL80211_SAE_PWE_HUNT_AND_PECK,
 				 NL80211_SAE_PWE_BOTH),
+	[NL80211_ATTR_RECONNECT_REQUESTED] = { .type = NLA_REJECT },
 };
 
 /* policy for the key attributes */
@@ -15857,7 +15858,7 @@ static void nl80211_send_mlme_event(struct cfg80211_registered_device *rdev,
 				    const u8 *buf, size_t len,
 				    enum nl80211_commands cmd, gfp_t gfp,
 				    int uapsd_queues, const u8 *req_ies,
-				    size_t req_ies_len)
+				    size_t req_ies_len, bool reconnect)
 {
 	struct sk_buff *msg;
 	void *hdr;
@@ -15879,6 +15880,9 @@ static void nl80211_send_mlme_event(struct cfg80211_registered_device *rdev,
 	     nla_put(msg, NL80211_ATTR_REQ_IE, req_ies_len, req_ies)))
 		goto nla_put_failure;
 
+	if (reconnect && nla_put_flag(msg, NL80211_ATTR_RECONNECT_REQUESTED))
+		goto nla_put_failure;
+
 	if (uapsd_queues >= 0) {
 		struct nlattr *nla_wmm =
 			nla_nest_start_noflag(msg, NL80211_ATTR_STA_WME);
@@ -15907,7 +15911,8 @@ void nl80211_send_rx_auth(struct cfg80211_registered_device *rdev,
 			  size_t len, gfp_t gfp)
 {
 	nl80211_send_mlme_event(rdev, netdev, buf, len,
-				NL80211_CMD_AUTHENTICATE, gfp, -1, NULL, 0);
+				NL80211_CMD_AUTHENTICATE, gfp, -1, NULL, 0,
+				false);
 }
 
 void nl80211_send_rx_assoc(struct cfg80211_registered_device *rdev,
@@ -15917,23 +15922,25 @@ void nl80211_send_rx_assoc(struct cfg80211_registered_device *rdev,
 {
 	nl80211_send_mlme_event(rdev, netdev, buf, len,
 				NL80211_CMD_ASSOCIATE, gfp, uapsd_queues,
-				req_ies, req_ies_len);
+				req_ies, req_ies_len, false);
 }
 
 void nl80211_send_deauth(struct cfg80211_registered_device *rdev,
 			 struct net_device *netdev, const u8 *buf,
-			 size_t len, gfp_t gfp)
+			 size_t len, bool reconnect, gfp_t gfp)
 {
 	nl80211_send_mlme_event(rdev, netdev, buf, len,
-				NL80211_CMD_DEAUTHENTICATE, gfp, -1, NULL, 0);
+				NL80211_CMD_DEAUTHENTICATE, gfp, -1, NULL, 0,
+				reconnect);
 }
 
 void nl80211_send_disassoc(struct cfg80211_registered_device *rdev,
 			   struct net_device *netdev, const u8 *buf,
-			   size_t len, gfp_t gfp)
+			   size_t len, bool reconnect, gfp_t gfp)
 {
 	nl80211_send_mlme_event(rdev, netdev, buf, len,
-				NL80211_CMD_DISASSOCIATE, gfp, -1, NULL, 0);
+				NL80211_CMD_DISASSOCIATE, gfp, -1, NULL, 0,
+				reconnect);
 }
 
 void cfg80211_rx_unprot_mlme_mgmt(struct net_device *dev, const u8 *buf,
@@ -15964,7 +15971,7 @@ void cfg80211_rx_unprot_mlme_mgmt(struct net_device *dev, const u8 *buf,
 
 	trace_cfg80211_rx_unprot_mlme_mgmt(dev, buf, len);
 	nl80211_send_mlme_event(rdev, dev, buf, len, cmd, GFP_ATOMIC, -1,
-				NULL, 0);
+				NULL, 0, false);
 }
 EXPORT_SYMBOL(cfg80211_rx_unprot_mlme_mgmt);
 
diff --git a/net/wireless/nl80211.h b/net/wireless/nl80211.h
index d3e8e426c486..a3f387770f1b 100644
--- a/net/wireless/nl80211.h
+++ b/net/wireless/nl80211.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Portions of this file
- * Copyright (C) 2018 Intel Corporation
+ * Copyright (C) 2018, 2020 Intel Corporation
  */
 #ifndef __NET_WIRELESS_NL80211_H
 #define __NET_WIRELESS_NL80211_H
@@ -69,10 +69,12 @@ void nl80211_send_rx_assoc(struct cfg80211_registered_device *rdev,
 			   const u8 *req_ies, size_t req_ies_len);
 void nl80211_send_deauth(struct cfg80211_registered_device *rdev,
 			 struct net_device *netdev,
-			 const u8 *buf, size_t len, gfp_t gfp);
+			 const u8 *buf, size_t len,
+			 bool reconnect, gfp_t gfp);
 void nl80211_send_disassoc(struct cfg80211_registered_device *rdev,
 			   struct net_device *netdev,
-			   const u8 *buf, size_t len, gfp_t gfp);
+			   const u8 *buf, size_t len,
+			   bool reconnect, gfp_t gfp);
 void nl80211_send_auth_timeout(struct cfg80211_registered_device *rdev,
 			       struct net_device *netdev,
 			       const u8 *addr, gfp_t gfp);
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 817c6fef13be..d75cd23aea02 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -2679,19 +2679,23 @@ DEFINE_EVENT(netdev_frame_event, cfg80211_rx_mlme_mgmt,
 );
 
 TRACE_EVENT(cfg80211_tx_mlme_mgmt,
-	TP_PROTO(struct net_device *netdev, const u8 *buf, int len),
-	TP_ARGS(netdev, buf, len),
+	TP_PROTO(struct net_device *netdev, const u8 *buf, int len,
+		 bool reconnect),
+	TP_ARGS(netdev, buf, len, reconnect),
 	TP_STRUCT__entry(
 		NETDEV_ENTRY
 		__dynamic_array(u8, frame, len)
+		__field(int, reconnect)
 	),
 	TP_fast_assign(
 		NETDEV_ASSIGN;
 		memcpy(__get_dynamic_array(frame), buf, len);
+		__entry->reconnect = reconnect;
 	),
-	TP_printk(NETDEV_PR_FMT ", ftype:0x%.2x",
+	TP_printk(NETDEV_PR_FMT ", ftype:0x%.2x reconnect:%d",
 		  NETDEV_PR_ARG,
-		  le16_to_cpup((__le16 *)__get_dynamic_array(frame)))
+		  le16_to_cpup((__le16 *)__get_dynamic_array(frame)),
+		  __entry->reconnect)
 );
 
 DECLARE_EVENT_CLASS(netdev_mac_evt,
-- 
2.29.2

