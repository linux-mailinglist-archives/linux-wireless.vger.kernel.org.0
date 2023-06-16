Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADE37327FD
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jun 2023 08:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235690AbjFPGzI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jun 2023 02:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243657AbjFPGyw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jun 2023 02:54:52 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6941FE8
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 23:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686898490; x=1718434490;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8WeT9Rjm+pvtYYRuxJE4mLvVJB07NPqYhNU/ai7sFkc=;
  b=LFj2PXEZyHqpvyYMlrCr/GJtP2bUhoBDSeJZ5IExqLUWXMlKqCsThMzN
   vGPXA6DhQpTtkgJNt/DPLlWZRGg0JHOtJZyOE9nL0N1MWJGKOrfrjouNl
   OtQxdKAHfDhgNErjILBwR/oNfa0PMsOOpvh2Xc+ocBA1WBSiCvgpQSyxA
   ZY79oFn2QuaBKIqjEZhhRha7NctZKMcGCt+w5NZM/CVauL0K8EbvSigO7
   A+pv+/1JblwNwLQFwzuGcdJWT8ogiRJkgIiH5JO+CtV690TcKI6dRLrFS
   j29GkP7hjEhWMW8HhcjHraHP9NHAKjnjfMf6pciiTEdBtedX7G2AEYEXB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="425078878"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="425078878"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 23:54:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="802720109"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="802720109"
Received: from ereznaim-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.237.118])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 23:54:48 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 11/20] wifi: cfg80211: add inform_bss op to update BSS
Date:   Fri, 16 Jun 2023 09:54:00 +0300
Message-Id: <20230616094949.8d7781b0f965.I80041183072b75c081996a1a5a230b34aff5c668@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230616065409.633290-1-gregory.greenman@intel.com>
References: <20230616065409.633290-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Benjamin Berg <benjamin.berg@intel.com>

This new function is called from within the inform_bss(_frame)_data
functions in order for the driver to update data that it is tracking.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/net/cfg80211.h  | 13 +++++++++++++
 net/wireless/rdev-ops.h | 12 ++++++++++++
 net/wireless/scan.c     |  4 ++++
 net/wireless/trace.h    | 17 +++++++++++++++++
 4 files changed, 46 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 5b1d76583dbb..94ca5cb340f6 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2708,6 +2708,7 @@ enum cfg80211_signal_type {
  *	the BSS that requested the scan in which the beacon/probe was received.
  * @chains: bitmask for filled values in @chain_signal.
  * @chain_signal: per-chain signal strength of last received BSS in dBm.
+ * @drv_data: Data to be passed through to @inform_bss
  */
 struct cfg80211_inform_bss {
 	struct ieee80211_channel *chan;
@@ -2718,6 +2719,8 @@ struct cfg80211_inform_bss {
 	u8 parent_bssid[ETH_ALEN] __aligned(2);
 	u8 chains;
 	s8 chain_signal[IEEE80211_MAX_CHAINS];
+
+	void *drv_data;
 };
 
 /**
@@ -4089,6 +4092,13 @@ struct mgmt_frame_regs {
  *
  * @change_bss: Modify parameters for a given BSS.
  *
+ * @inform_bss: Called by cfg80211 while being informed about new BSS data
+ *	for every BSS found within the reported data or frame. This is called
+ *	from within the cfg8011 inform_bss handlers while holding the bss_lock.
+ *	The data parameter is passed through from drv_data inside
+ *	struct cfg80211_inform_bss.
+ *	The new IE data for the BSS is explicitly passed.
+ *
  * @set_txq_params: Set TX queue parameters
  *
  * @libertas_set_mesh_channel: Only for backward compatibility for libertas,
@@ -4476,6 +4486,9 @@ struct cfg80211_ops {
 	int	(*change_bss)(struct wiphy *wiphy, struct net_device *dev,
 			      struct bss_parameters *params);
 
+	void	(*inform_bss)(struct wiphy *wiphy, struct cfg80211_bss *bss,
+			      const struct cfg80211_bss_ies *ies, void *data);
+
 	int	(*set_txq_params)(struct wiphy *wiphy, struct net_device *dev,
 				  struct ieee80211_txq_params *params);
 
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index f8c310849438..90bb7ac4b930 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -407,6 +407,18 @@ static inline int rdev_change_bss(struct cfg80211_registered_device *rdev,
 	return ret;
 }
 
+static inline void rdev_inform_bss(struct cfg80211_registered_device *rdev,
+				   struct cfg80211_bss *bss,
+				   const struct cfg80211_bss_ies *ies,
+				   void *drv_data)
+
+{
+	trace_rdev_inform_bss(&rdev->wiphy, bss);
+	if (rdev->ops->inform_bss)
+		rdev->ops->inform_bss(&rdev->wiphy, bss, ies, drv_data);
+	trace_rdev_return_void(&rdev->wiphy);
+}
+
 static inline int rdev_set_txq_params(struct cfg80211_registered_device *rdev,
 				      struct net_device *dev,
 				      struct ieee80211_txq_params *params)
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 8984f74da891..d9abbf123ad1 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2027,6 +2027,8 @@ cfg80211_inform_single_bss_data(struct wiphy *wiphy,
 	if (!res)
 		goto drop;
 
+	rdev_inform_bss(rdev, &res->pub, ies, data->drv_data);
+
 	if (non_tx_data) {
 		/* this is a nontransmitting bss, we need to add it to
 		 * transmitting bss' list if it is not there
@@ -2502,6 +2504,8 @@ cfg80211_inform_single_bss_frame_data(struct wiphy *wiphy,
 	if (!res)
 		goto drop;
 
+	rdev_inform_bss(rdev, &res->pub, ies, data->drv_data);
+
 	spin_unlock_bh(&rdev->bss_lock);
 
 	trace_cfg80211_return_bss(&res->pub);
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 63aed8d59d25..41dc87ee62f0 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -1159,6 +1159,23 @@ TRACE_EVENT(rdev_change_bss,
 		  __entry->ap_isolate, __entry->ht_opmode)
 );
 
+TRACE_EVENT(rdev_inform_bss,
+	TP_PROTO(struct wiphy *wiphy, struct cfg80211_bss *bss),
+	TP_ARGS(wiphy, bss),
+	TP_STRUCT__entry(
+		WIPHY_ENTRY
+		MAC_ENTRY(bssid)
+		CHAN_ENTRY
+	),
+	TP_fast_assign(
+		WIPHY_ASSIGN;
+		MAC_ASSIGN(bssid, bss->bssid);
+		CHAN_ASSIGN(bss->channel);
+	),
+	TP_printk(WIPHY_PR_FMT ", %pM, " CHAN_PR_FMT,
+		  WIPHY_PR_ARG, __entry->bssid, CHAN_PR_ARG)
+);
+
 TRACE_EVENT(rdev_set_txq_params,
 	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
 		 struct ieee80211_txq_params *params),
-- 
2.38.1

