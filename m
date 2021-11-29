Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2DD1461692
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Nov 2021 14:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243261AbhK2NiT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Nov 2021 08:38:19 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:49772 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1377671AbhK2NgO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Nov 2021 08:36:14 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mrgm6-0012xo-RL; Mon, 29 Nov 2021 15:32:55 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Mon, 29 Nov 2021 15:32:34 +0200
Message-Id: <iwlwifi.20211129152938.2467809e8cb3.I45574185b582666bc78eef0c29a4c36b478e5382@changeid>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211129133248.83829-1-luca@coelho.fi>
References: <20211129133248.83829-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 02/16] cfg80211: Add support for notifying association comeback
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

Thought the underline driver MLME can handle association temporal
rejection with comeback, it is still useful to notify this to
user space, as user space might want to handle the temporal
rejection differently. For example, in case the comeback time
is too long, user space can deauthenticate immediately and try
to associate with a different AP.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 include/net/cfg80211.h       | 12 ++++++++++++
 include/uapi/linux/nl80211.h |  7 +++++++
 net/wireless/nl80211.c       | 38 ++++++++++++++++++++++++++++++++++++
 net/wireless/trace.h         | 17 ++++++++++++++++
 4 files changed, 74 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 362da9f6bf39..b9b269504591 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -8269,6 +8269,18 @@ bool cfg80211_iftype_allowed(struct wiphy *wiphy, enum nl80211_iftype iftype,
 			     bool is_4addr, u8 check_swif);
 
 
+/**
+ * cfg80211_assoc_comeback - notification of association that was
+ * temporarly rejected with a comeback
+ * @netdev: network device
+ * @bss: the bss entry with which association is in progress.
+ * @timeout: timeout interval value TUs.
+ *
+ * this function may sleep. the caller must hold the corresponding wdev's mutex.
+ */
+void cfg80211_assoc_comeback(struct net_device *netdev,
+			     struct cfg80211_bss *bss, u32 timeout);
+
 /* Logging, debugging and troubleshooting/diagnostic helpers. */
 
 /* wiphy_printk helpers, similar to dev_printk */
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 3e734826792f..5ab616dc363e 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1232,6 +1232,11 @@
  *	&NL80211_ATTR_FILS_NONCES - for FILS Nonces
  *		(STA Nonce 16 bytes followed by AP Nonce 16 bytes)
  *
+ * @NL80211_CMD_ASSOC_COMEBACK: notification about an association
+ *      temporal rejection with comeback. The event includes %NL80211_ATTR_MAC
+ *      to describe the BSSID address of the AP and %NL80211_ATTR_TIMEOUT to
+ *      specify the timeout value.
+ *
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1474,6 +1479,8 @@ enum nl80211_commands {
 
 	NL80211_CMD_SET_FILS_AAD,
 
+	NL80211_CMD_ASSOC_COMEBACK,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 83a1ba96e172..249109848497 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -17040,6 +17040,44 @@ static void nl80211_send_remain_on_chan_event(
 	nlmsg_free(msg);
 }
 
+void cfg80211_assoc_comeback(struct net_device *netdev,
+			     struct cfg80211_bss *bss, u32 timeout)
+{
+	struct wireless_dev *wdev = netdev->ieee80211_ptr;
+	struct wiphy *wiphy = wdev->wiphy;
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
+	struct sk_buff *msg;
+	void *hdr;
+
+	trace_cfg80211_assoc_comeback(wdev, bss->bssid, timeout);
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return;
+
+	hdr = nl80211hdr_put(msg, 0, 0, 0, NL80211_CMD_ASSOC_COMEBACK);
+	if (!hdr) {
+		nlmsg_free(msg);
+		return;
+	}
+
+	if (nla_put_u32(msg, NL80211_ATTR_WIPHY, rdev->wiphy_idx) ||
+	    nla_put_u32(msg, NL80211_ATTR_IFINDEX, netdev->ifindex) ||
+	    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, bss->bssid) ||
+	    nla_put_u32(msg, NL80211_ATTR_TIMEOUT, timeout))
+		goto nla_put_failure;
+
+	genlmsg_end(msg, hdr);
+
+	genlmsg_multicast_netns(&nl80211_fam, wiphy_net(&rdev->wiphy), msg, 0,
+				NL80211_MCGRP_MLME, GFP_KERNEL);
+	return;
+
+ nla_put_failure:
+	nlmsg_free(msg);
+}
+EXPORT_SYMBOL(cfg80211_assoc_comeback);
+
 void cfg80211_ready_on_channel(struct wireless_dev *wdev, u64 cookie,
 			       struct ieee80211_channel *chan,
 			       unsigned int duration, gfp_t gfp)
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 0b27eaa14a18..e0a80349c5b3 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -3693,6 +3693,23 @@ TRACE_EVENT(rdev_set_radar_offchan,
 		  WIPHY_PR_ARG, CHAN_DEF_PR_ARG)
 );
 
+TRACE_EVENT(cfg80211_assoc_comeback,
+	TP_PROTO(struct wireless_dev *wdev, const u8 *bssid, u32 timeout),
+	TP_ARGS(wdev, bssid, timeout),
+	TP_STRUCT__entry(
+		WDEV_ENTRY
+		MAC_ENTRY(bssid)
+		__field(u32, timeout)
+	),
+	TP_fast_assign(
+		WDEV_ASSIGN;
+		MAC_ASSIGN(bssid, bssid);
+		__entry->timeout = timeout;
+	),
+	TP_printk(WDEV_PR_FMT ", " MAC_PR_FMT ", timeout: %u TUs",
+		  WDEV_PR_ARG, MAC_PR_ARG(bssid), __entry->timeout)
+);
+
 #endif /* !__RDEV_OPS_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.33.1

