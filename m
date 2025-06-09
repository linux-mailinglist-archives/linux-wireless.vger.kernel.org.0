Return-Path: <linux-wireless+bounces-23882-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19828AD25B3
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 20:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC8E716EFBE
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 18:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58D321D3C0;
	Mon,  9 Jun 2025 18:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c+TdomYV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA8421E08A
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 18:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749494156; cv=none; b=Ik2SimDe/s5lz36do2CcWfJfGRGiIQ0kY4Bl3hUwwcp6G1cfYEFpOx4wTtUAc36WC2yAqW/372SnO0ckni5y/XDDiDe8eqrP9uomCALePltxA1iZG/muKYJL3wgKbqhG2IBA+Pz/30NfawA473r++ccEyWvSIeEiTTVCrKoEldI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749494156; c=relaxed/simple;
	bh=YuHIO7ybkEudnMbJQAX6ucB7J+NNu4zlIW8UAhdDBOk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SgNd8fuk06XgK82hHMAX39+WQbviA6ts4+RuTWTeuNwa5N264C+xvlp4958Vua2coz3feFX3HwmsjU0L/4WlErPS3ZWkuMURGhYLdHbJJ4MPDWAvJZcsT3YVJZKysL30p2eSAhYUtqKRvPki5seVAiWe0Xbrxb1cDsO5snbWVgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c+TdomYV; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749494154; x=1781030154;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YuHIO7ybkEudnMbJQAX6ucB7J+NNu4zlIW8UAhdDBOk=;
  b=c+TdomYVLOaj11nI+hlCngR3kV+pEQwmt5e7Lm9XGUxGhB+0ldXcRE7F
   2doZh7m4nkvMbUE6ymVMqXsN6B7mKdalrBz++pFGe2GvngGWT8OxhWCVm
   B/YXCYDDxjauAE6P4zkJPvhqjydzUTRqsai+OqTP0gs/bw2int1QKAmPf
   61nfHfSZlursIr7lTmdaF8EXb82aPEMTAySmKKldeQKxE4urorXRAF7pD
   wXJCVrE4V9FsgcCyCbbRUu11c4EV5aqgmyB1dDwVvhe7kNBJ8xnuMGl4x
   oKZCAC3mr92upMAZzMu98YI8rzKYfnNp28xf3SSEezBjyyFHLPnMnI7ue
   Q==;
X-CSE-ConnectionGUID: tbXdSL/5TOCKuTv/wcoUCQ==
X-CSE-MsgGUID: UG2KlG7uQ6iZvw87Fcb6LA==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="55249765"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="55249765"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:35:53 -0700
X-CSE-ConnectionGUID: ci5iLjacQRmur2xPs7qJFg==
X-CSE-MsgGUID: fBnAqrWFTy69uQctDXBOOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="151732488"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:35:52 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH wireless-next 07/15] wifi: cfg80211: hide scan internals
Date: Mon,  9 Jun 2025 21:35:19 +0300
Message-Id: <20250609213231.6a62e41858e2.I004f66e9c087cc6e6ae4a24951cf470961ee9466@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250609183527.3974138-1-miriam.rachel.korenblit@intel.com>
References: <20250609183527.3974138-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Hide the internal scan fields from mac80211 and drivers, the
'notified' variable is for internal tracking, and the 'info'
is output that's passed to cfg80211_scan_done() and stored
only for delayed userspace notification.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/cfg80211.h  |   6 --
 net/wireless/core.c     |   4 +-
 net/wireless/core.h     |  11 ++-
 net/wireless/nl80211.c  |  97 +++++++++++----------
 net/wireless/rdev-ops.h |   6 +-
 net/wireless/scan.c     | 188 +++++++++++++++++++++-------------------
 net/wireless/sme.c      |  40 ++++-----
 net/wireless/trace.h    |  23 ++---
 8 files changed, 196 insertions(+), 179 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index d1848dc8ec99..07368dd9a212 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2645,8 +2645,6 @@ struct cfg80211_scan_6ghz_params {
  * @wiphy: the wiphy this was for
  * @scan_start: time (in jiffies) when the scan started
  * @wdev: the wireless device to scan for
- * @info: (internal) information about completed scan
- * @notified: (internal) scan request was notified as done or aborted
  * @no_cck: used to send probe requests at non CCK rate in 2GHz band
  * @mac_addr: MAC address used with randomisation
  * @mac_addr_mask: MAC address mask used with randomisation, bits that
@@ -2677,12 +2675,8 @@ struct cfg80211_scan_request {
 	u8 mac_addr[ETH_ALEN] __aligned(2);
 	u8 mac_addr_mask[ETH_ALEN] __aligned(2);
 	u8 bssid[ETH_ALEN] __aligned(2);
-
-	/* internal */
 	struct wiphy *wiphy;
 	unsigned long scan_start;
-	struct cfg80211_scan_info info;
-	bool notified;
 	bool no_cck;
 	bool scan_6ghz;
 	u32 n_6ghz_params;
diff --git a/net/wireless/core.c b/net/wireless/core.c
index dcce326fdb8c..c82bced6c156 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -239,7 +239,7 @@ void cfg80211_stop_p2p_device(struct cfg80211_registered_device *rdev,
 
 	rdev->opencount--;
 
-	if (rdev->scan_req && rdev->scan_req->wdev == wdev) {
+	if (rdev->scan_req && rdev->scan_req->req.wdev == wdev) {
 		if (WARN_ON(!rdev->scan_req->notified &&
 			    (!rdev->int_scan_req ||
 			     !rdev->int_scan_req->notified)))
@@ -1555,7 +1555,7 @@ static int cfg80211_netdev_notifier_call(struct notifier_block *nb,
 	case NETDEV_DOWN:
 		wiphy_lock(&rdev->wiphy);
 		cfg80211_update_iface_num(rdev, wdev->iftype, -1);
-		if (rdev->scan_req && rdev->scan_req->wdev == wdev) {
+		if (rdev->scan_req && rdev->scan_req->req.wdev == wdev) {
 			if (WARN_ON(!rdev->scan_req->notified &&
 				    (!rdev->int_scan_req ||
 				     !rdev->int_scan_req->notified)))
diff --git a/net/wireless/core.h b/net/wireless/core.h
index c56a35040caa..b6bd7f4d6385 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -21,6 +21,13 @@
 
 #define WIPHY_IDX_INVALID	-1
 
+struct cfg80211_scan_request_int {
+	struct cfg80211_scan_info info;
+	bool notified;
+	/* must be last - variable members */
+	struct cfg80211_scan_request req;
+};
+
 struct cfg80211_registered_device {
 	const struct cfg80211_ops *ops;
 	struct list_head list;
@@ -70,8 +77,8 @@ struct cfg80211_registered_device {
 	struct rb_root bss_tree;
 	u32 bss_generation;
 	u32 bss_entries;
-	struct cfg80211_scan_request *scan_req; /* protected by RTNL */
-	struct cfg80211_scan_request *int_scan_req;
+	struct cfg80211_scan_request_int *scan_req; /* protected by RTNL */
+	struct cfg80211_scan_request_int *int_scan_req;
 	struct sk_buff *scan_msg;
 	struct list_head sched_scan_req_list;
 	time64_t suspend_at;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index fd5f79266471..42774c02a18f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -9316,12 +9316,12 @@ nl80211_check_scan_flags(struct wiphy *wiphy, struct wireless_dev *wdev,
 		mac_addr = req->mac_addr;
 		mac_addr_mask = req->mac_addr_mask;
 	} else {
-		struct cfg80211_scan_request *req = request;
+		struct cfg80211_scan_request_int *req = request;
 
 		randomness_flag = NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR;
-		flags = &req->flags;
-		mac_addr = req->mac_addr;
-		mac_addr_mask = req->mac_addr_mask;
+		flags = &req->req.flags;
+		mac_addr = req->req.mac_addr;
+		mac_addr_mask = req->req.mac_addr_mask;
 	}
 
 	*flags = nla_get_u32(attrs[NL80211_ATTR_SCAN_FLAGS]);
@@ -9376,7 +9376,7 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	struct wireless_dev *wdev = info->user_ptr[1];
-	struct cfg80211_scan_request *request;
+	struct cfg80211_scan_request_int *request;
 	struct nlattr *scan_freqs = NULL;
 	bool scan_freqs_khz = false;
 	struct nlattr *attr;
@@ -9428,21 +9428,21 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 	if (ie_len > wiphy->max_scan_ie_len)
 		return -EINVAL;
 
-	size = struct_size(request, channels, n_channels);
+	size = struct_size(request, req.channels, n_channels);
 	ssids_offset = size;
-	size = size_add(size, array_size(sizeof(*request->ssids), n_ssids));
+	size = size_add(size, array_size(sizeof(*request->req.ssids), n_ssids));
 	ie_offset = size;
 	size = size_add(size, ie_len);
 	request = kzalloc(size, GFP_KERNEL);
 	if (!request)
 		return -ENOMEM;
-	request->n_channels = n_channels;
+	request->req.n_channels = n_channels;
 
 	if (n_ssids)
-		request->ssids = (void *)request + ssids_offset;
-	request->n_ssids = n_ssids;
+		request->req.ssids = (void *)request + ssids_offset;
+	request->req.n_ssids = n_ssids;
 	if (ie_len)
-		request->ie = (void *)request + ie_offset;
+		request->req.ie = (void *)request + ie_offset;
 
 	i = 0;
 	if (scan_freqs) {
@@ -9465,7 +9465,7 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 			    !cfg80211_wdev_channel_allowed(wdev, chan))
 				continue;
 
-			request->channels[i] = chan;
+			request->req.channels[i] = chan;
 			i++;
 		}
 	} else {
@@ -9486,7 +9486,7 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 				    !cfg80211_wdev_channel_allowed(wdev, chan))
 					continue;
 
-				request->channels[i] = chan;
+				request->req.channels[i] = chan;
 				i++;
 			}
 		}
@@ -9497,10 +9497,10 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 		goto out_free;
 	}
 
-	request->n_channels = i;
+	request->req.n_channels = i;
 
-	for (i = 0; i < request->n_channels; i++) {
-		struct ieee80211_channel *chan = request->channels[i];
+	for (i = 0; i < request->req.n_channels; i++) {
+		struct ieee80211_channel *chan = request->req.channels[i];
 
 		/* if we can go off-channel to the target channel we're good */
 		if (cfg80211_off_channel_oper_allowed(wdev, chan))
@@ -9519,22 +9519,23 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 				err = -EINVAL;
 				goto out_free;
 			}
-			request->ssids[i].ssid_len = nla_len(attr);
-			memcpy(request->ssids[i].ssid, nla_data(attr), nla_len(attr));
+			request->req.ssids[i].ssid_len = nla_len(attr);
+			memcpy(request->req.ssids[i].ssid,
+			       nla_data(attr), nla_len(attr));
 			i++;
 		}
 	}
 
 	if (info->attrs[NL80211_ATTR_IE]) {
-		request->ie_len = nla_len(info->attrs[NL80211_ATTR_IE]);
-		memcpy((void *)request->ie,
+		request->req.ie_len = nla_len(info->attrs[NL80211_ATTR_IE]);
+		memcpy((void *)request->req.ie,
 		       nla_data(info->attrs[NL80211_ATTR_IE]),
-		       request->ie_len);
+		       request->req.ie_len);
 	}
 
 	for (i = 0; i < NUM_NL80211_BANDS; i++)
 		if (wiphy->bands[i])
-			request->rates[i] =
+			request->req.rates[i] =
 				(1 << wiphy->bands[i]->n_bitrates) - 1;
 
 	if (info->attrs[NL80211_ATTR_SCAN_SUPP_RATES]) {
@@ -9554,16 +9555,16 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 			err = ieee80211_get_ratemask(wiphy->bands[band],
 						     nla_data(attr),
 						     nla_len(attr),
-						     &request->rates[band]);
+						     &request->req.rates[band]);
 			if (err)
 				goto out_free;
 		}
 	}
 
 	if (info->attrs[NL80211_ATTR_MEASUREMENT_DURATION]) {
-		request->duration =
+		request->req.duration =
 			nla_get_u16(info->attrs[NL80211_ATTR_MEASUREMENT_DURATION]);
-		request->duration_mandatory =
+		request->req.duration_mandatory =
 			nla_get_flag(info->attrs[NL80211_ATTR_MEASUREMENT_DURATION_MANDATORY]);
 	}
 
@@ -9572,7 +9573,7 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 	if (err)
 		goto out_free;
 
-	request->no_cck =
+	request->req.no_cck =
 		nla_get_flag(info->attrs[NL80211_ATTR_TX_NO_CCK_RATE]);
 
 	/* Initial implementation used NL80211_ATTR_MAC to set the specific
@@ -9585,19 +9586,21 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 	 * (NL80211_ATTR_SCAN_FLAGS is used to enable random MAC address use).
 	 */
 	if (info->attrs[NL80211_ATTR_BSSID])
-		memcpy(request->bssid,
+		memcpy(request->req.bssid,
 		       nla_data(info->attrs[NL80211_ATTR_BSSID]), ETH_ALEN);
-	else if (!(request->flags & NL80211_SCAN_FLAG_RANDOM_ADDR) &&
+	else if (!(request->req.flags & NL80211_SCAN_FLAG_RANDOM_ADDR) &&
 		 info->attrs[NL80211_ATTR_MAC])
-		memcpy(request->bssid, nla_data(info->attrs[NL80211_ATTR_MAC]),
+		memcpy(request->req.bssid,
+		       nla_data(info->attrs[NL80211_ATTR_MAC]),
 		       ETH_ALEN);
 	else
-		eth_broadcast_addr(request->bssid);
+		eth_broadcast_addr(request->req.bssid);
 
-	request->tsf_report_link_id = nl80211_link_id_or_invalid(info->attrs);
-	request->wdev = wdev;
-	request->wiphy = &rdev->wiphy;
-	request->scan_start = jiffies;
+	request->req.tsf_report_link_id =
+		nl80211_link_id_or_invalid(info->attrs);
+	request->req.wdev = wdev;
+	request->req.wiphy = &rdev->wiphy;
+	request->req.scan_start = jiffies;
 
 	rdev->scan_req = request;
 	err = cfg80211_scan(rdev);
@@ -17899,7 +17902,7 @@ void nl80211_notify_iface(struct cfg80211_registered_device *rdev,
 static int nl80211_add_scan_req(struct sk_buff *msg,
 				struct cfg80211_registered_device *rdev)
 {
-	struct cfg80211_scan_request *req = rdev->scan_req;
+	struct cfg80211_scan_request_int *req = rdev->scan_req;
 	struct nlattr *nest;
 	int i;
 	struct cfg80211_scan_info *info;
@@ -17910,19 +17913,20 @@ static int nl80211_add_scan_req(struct sk_buff *msg,
 	nest = nla_nest_start_noflag(msg, NL80211_ATTR_SCAN_SSIDS);
 	if (!nest)
 		goto nla_put_failure;
-	for (i = 0; i < req->n_ssids; i++) {
-		if (nla_put(msg, i, req->ssids[i].ssid_len, req->ssids[i].ssid))
+	for (i = 0; i < req->req.n_ssids; i++) {
+		if (nla_put(msg, i, req->req.ssids[i].ssid_len,
+			    req->req.ssids[i].ssid))
 			goto nla_put_failure;
 	}
 	nla_nest_end(msg, nest);
 
-	if (req->flags & NL80211_SCAN_FLAG_FREQ_KHZ) {
+	if (req->req.flags & NL80211_SCAN_FLAG_FREQ_KHZ) {
 		nest = nla_nest_start(msg, NL80211_ATTR_SCAN_FREQ_KHZ);
 		if (!nest)
 			goto nla_put_failure;
-		for (i = 0; i < req->n_channels; i++) {
+		for (i = 0; i < req->req.n_channels; i++) {
 			if (nla_put_u32(msg, i,
-				   ieee80211_channel_to_khz(req->channels[i])))
+					ieee80211_channel_to_khz(req->req.channels[i])))
 				goto nla_put_failure;
 		}
 		nla_nest_end(msg, nest);
@@ -17931,19 +17935,20 @@ static int nl80211_add_scan_req(struct sk_buff *msg,
 					     NL80211_ATTR_SCAN_FREQUENCIES);
 		if (!nest)
 			goto nla_put_failure;
-		for (i = 0; i < req->n_channels; i++) {
-			if (nla_put_u32(msg, i, req->channels[i]->center_freq))
+		for (i = 0; i < req->req.n_channels; i++) {
+			if (nla_put_u32(msg, i,
+					req->req.channels[i]->center_freq))
 				goto nla_put_failure;
 		}
 		nla_nest_end(msg, nest);
 	}
 
-	if (req->ie &&
-	    nla_put(msg, NL80211_ATTR_IE, req->ie_len, req->ie))
+	if (req->req.ie &&
+	    nla_put(msg, NL80211_ATTR_IE, req->req.ie_len, req->req.ie))
 		goto nla_put_failure;
 
-	if (req->flags &&
-	    nla_put_u32(msg, NL80211_ATTR_SCAN_FLAGS, req->flags))
+	if (req->req.flags &&
+	    nla_put_u32(msg, NL80211_ATTR_SCAN_FLAGS, req->req.flags))
 		goto nla_put_failure;
 
 	info = rdev->int_scan_req ? &rdev->int_scan_req->info :
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 9f4783c2354c..ccca538819f7 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -456,15 +456,15 @@ rdev_set_monitor_channel(struct cfg80211_registered_device *rdev,
 }
 
 static inline int rdev_scan(struct cfg80211_registered_device *rdev,
-			    struct cfg80211_scan_request *request)
+			    struct cfg80211_scan_request_int *request)
 {
 	int ret;
 
-	if (WARN_ON_ONCE(!request->n_ssids && request->ssids))
+	if (WARN_ON_ONCE(!request->req.n_ssids && request->req.ssids))
 		return -EINVAL;
 
 	trace_rdev_scan(&rdev->wiphy, request);
-	ret = rdev->ops->scan(&rdev->wiphy, request);
+	ret = rdev->ops->scan(&rdev->wiphy, &request->req);
 	trace_rdev_return_int(&rdev->wiphy, ret);
 	return ret;
 }
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index ddd3a97f6609..d12ece068c10 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -782,9 +782,9 @@ cfg80211_parse_colocated_ap(const struct cfg80211_bss_ies *ies,
 }
 EXPORT_SYMBOL_IF_CFG80211_KUNIT(cfg80211_parse_colocated_ap);
 
-static  void cfg80211_scan_req_add_chan(struct cfg80211_scan_request *request,
-					struct ieee80211_channel *chan,
-					bool add_to_6ghz)
+static void cfg80211_scan_req_add_chan(struct cfg80211_scan_request *request,
+				       struct ieee80211_channel *chan,
+				       bool add_to_6ghz)
 {
 	int i;
 	u32 n_channels = request->n_channels;
@@ -843,25 +843,25 @@ static int cfg80211_scan_6ghz(struct cfg80211_registered_device *rdev)
 	u8 i;
 	struct cfg80211_colocated_ap *ap;
 	int n_channels, count = 0, err;
-	struct cfg80211_scan_request *request, *rdev_req = rdev->scan_req;
+	struct cfg80211_scan_request_int *request, *rdev_req = rdev->scan_req;
 	LIST_HEAD(coloc_ap_list);
 	bool need_scan_psc = true;
 	const struct ieee80211_sband_iftype_data *iftd;
 	size_t size, offs_ssids, offs_6ghz_params, offs_ies;
 
-	rdev_req->scan_6ghz = true;
+	rdev_req->req.scan_6ghz = true;
 
 	if (!rdev->wiphy.bands[NL80211_BAND_6GHZ])
 		return -EOPNOTSUPP;
 
 	iftd = ieee80211_get_sband_iftype_data(rdev->wiphy.bands[NL80211_BAND_6GHZ],
-					       rdev_req->wdev->iftype);
+					       rdev_req->req.wdev->iftype);
 	if (!iftd || !iftd->he_cap.has_he)
 		return -EOPNOTSUPP;
 
 	n_channels = rdev->wiphy.bands[NL80211_BAND_6GHZ]->n_channels;
 
-	if (rdev_req->flags & NL80211_SCAN_FLAG_COLOCATED_6GHZ) {
+	if (rdev_req->req.flags & NL80211_SCAN_FLAG_COLOCATED_6GHZ) {
 		struct cfg80211_internal_bss *intbss;
 
 		spin_lock_bh(&rdev->bss_lock);
@@ -883,8 +883,8 @@ static int cfg80211_scan_6ghz(struct cfg80211_registered_device *rdev)
 			 * This is relevant for ML probe requests when the lower
 			 * band APs have not been discovered.
 			 */
-			if (is_broadcast_ether_addr(rdev_req->bssid) ||
-			    !ether_addr_equal(rdev_req->bssid, res->bssid) ||
+			if (is_broadcast_ether_addr(rdev_req->req.bssid) ||
+			    !ether_addr_equal(rdev_req->req.bssid, res->bssid) ||
 			    res->channel->band != NL80211_BAND_6GHZ)
 				continue;
 
@@ -911,13 +911,13 @@ static int cfg80211_scan_6ghz(struct cfg80211_registered_device *rdev)
 		spin_unlock_bh(&rdev->bss_lock);
 	}
 
-	size = struct_size(request, channels, n_channels);
+	size = struct_size(request, req.channels, n_channels);
 	offs_ssids = size;
-	size += sizeof(*request->ssids) * rdev_req->n_ssids;
+	size += sizeof(*request->req.ssids) * rdev_req->req.n_ssids;
 	offs_6ghz_params = size;
-	size += sizeof(*request->scan_6ghz_params) * count;
+	size += sizeof(*request->req.scan_6ghz_params) * count;
 	offs_ies = size;
-	size += rdev_req->ie_len;
+	size += rdev_req->req.ie_len;
 
 	request = kzalloc(size, GFP_KERNEL);
 	if (!request) {
@@ -926,26 +926,26 @@ static int cfg80211_scan_6ghz(struct cfg80211_registered_device *rdev)
 	}
 
 	*request = *rdev_req;
-	request->n_channels = 0;
-	request->n_6ghz_params = 0;
-	if (rdev_req->n_ssids) {
+	request->req.n_channels = 0;
+	request->req.n_6ghz_params = 0;
+	if (rdev_req->req.n_ssids) {
 		/*
 		 * Add the ssids from the parent scan request to the new
 		 * scan request, so the driver would be able to use them
 		 * in its probe requests to discover hidden APs on PSC
 		 * channels.
 		 */
-		request->ssids = (void *)request + offs_ssids;
-		memcpy(request->ssids, rdev_req->ssids,
-		       sizeof(*request->ssids) * request->n_ssids);
+		request->req.ssids = (void *)request + offs_ssids;
+		memcpy(request->req.ssids, rdev_req->req.ssids,
+		       sizeof(*request->req.ssids) * request->req.n_ssids);
 	}
-	request->scan_6ghz_params = (void *)request + offs_6ghz_params;
+	request->req.scan_6ghz_params = (void *)request + offs_6ghz_params;
 
-	if (rdev_req->ie_len) {
+	if (rdev_req->req.ie_len) {
 		void *ie = (void *)request + offs_ies;
 
-		memcpy(ie, rdev_req->ie, rdev_req->ie_len);
-		request->ie = ie;
+		memcpy(ie, rdev_req->req.ie, rdev_req->req.ie_len);
+		request->req.ie = ie;
 	}
 
 	/*
@@ -953,10 +953,12 @@ static int cfg80211_scan_6ghz(struct cfg80211_registered_device *rdev)
 	 * and at least one of the reported co-located APs with same SSID
 	 * indicating that all APs in the same ESS are co-located
 	 */
-	if (count && request->n_ssids == 1 && request->ssids[0].ssid_len) {
+	if (count &&
+	    request->req.n_ssids == 1 &&
+	    request->req.ssids[0].ssid_len) {
 		list_for_each_entry(ap, &coloc_ap_list, list) {
 			if (ap->colocated_ess &&
-			    cfg80211_find_ssid_match(ap, request)) {
+			    cfg80211_find_ssid_match(ap, &request->req)) {
 				need_scan_psc = false;
 				break;
 			}
@@ -968,51 +970,52 @@ static int cfg80211_scan_6ghz(struct cfg80211_registered_device *rdev)
 	 * regardless of the collocated APs (PSC channels or all channels
 	 * in case that NL80211_SCAN_FLAG_COLOCATED_6GHZ is not set)
 	 */
-	for (i = 0; i < rdev_req->n_channels; i++) {
-		if (rdev_req->channels[i]->band == NL80211_BAND_6GHZ &&
+	for (i = 0; i < rdev_req->req.n_channels; i++) {
+		if (rdev_req->req.channels[i]->band == NL80211_BAND_6GHZ &&
 		    ((need_scan_psc &&
-		      cfg80211_channel_is_psc(rdev_req->channels[i])) ||
-		     !(rdev_req->flags & NL80211_SCAN_FLAG_COLOCATED_6GHZ))) {
-			cfg80211_scan_req_add_chan(request,
-						   rdev_req->channels[i],
+		      cfg80211_channel_is_psc(rdev_req->req.channels[i])) ||
+		     !(rdev_req->req.flags & NL80211_SCAN_FLAG_COLOCATED_6GHZ))) {
+			cfg80211_scan_req_add_chan(&request->req,
+						   rdev_req->req.channels[i],
 						   false);
 		}
 	}
 
-	if (!(rdev_req->flags & NL80211_SCAN_FLAG_COLOCATED_6GHZ))
+	if (!(rdev_req->req.flags & NL80211_SCAN_FLAG_COLOCATED_6GHZ))
 		goto skip;
 
 	list_for_each_entry(ap, &coloc_ap_list, list) {
 		bool found = false;
 		struct cfg80211_scan_6ghz_params *scan_6ghz_params =
-			&request->scan_6ghz_params[request->n_6ghz_params];
+			&request->req.scan_6ghz_params[request->req.n_6ghz_params];
 		struct ieee80211_channel *chan =
 			ieee80211_get_channel(&rdev->wiphy, ap->center_freq);
 
 		if (!chan || chan->flags & IEEE80211_CHAN_DISABLED ||
-		    !cfg80211_wdev_channel_allowed(rdev_req->wdev, chan))
+		    !cfg80211_wdev_channel_allowed(rdev_req->req.wdev, chan))
 			continue;
 
-		for (i = 0; i < rdev_req->n_channels; i++) {
-			if (rdev_req->channels[i] == chan)
+		for (i = 0; i < rdev_req->req.n_channels; i++) {
+			if (rdev_req->req.channels[i] == chan)
 				found = true;
 		}
 
 		if (!found)
 			continue;
 
-		if (request->n_ssids > 0 &&
-		    !cfg80211_find_ssid_match(ap, request))
+		if (request->req.n_ssids > 0 &&
+		    !cfg80211_find_ssid_match(ap, &request->req))
 			continue;
 
-		if (!is_broadcast_ether_addr(request->bssid) &&
-		    !ether_addr_equal(request->bssid, ap->bssid))
+		if (!is_broadcast_ether_addr(request->req.bssid) &&
+		    !ether_addr_equal(request->req.bssid, ap->bssid))
 			continue;
 
-		if (!request->n_ssids && ap->multi_bss && !ap->transmitted_bssid)
+		if (!request->req.n_ssids && ap->multi_bss &&
+		    !ap->transmitted_bssid)
 			continue;
 
-		cfg80211_scan_req_add_chan(request, chan, true);
+		cfg80211_scan_req_add_chan(&request->req, chan, true);
 		memcpy(scan_6ghz_params->bssid, ap->bssid, ETH_ALEN);
 		scan_6ghz_params->short_ssid = ap->short_ssid;
 		scan_6ghz_params->short_ssid_valid = ap->short_ssid_valid;
@@ -1028,14 +1031,14 @@ static int cfg80211_scan_6ghz(struct cfg80211_registered_device *rdev)
 		if (cfg80211_channel_is_psc(chan) && !need_scan_psc)
 			scan_6ghz_params->psc_no_listen = true;
 
-		request->n_6ghz_params++;
+		request->req.n_6ghz_params++;
 	}
 
 skip:
 	cfg80211_free_coloc_ap_list(&coloc_ap_list);
 
-	if (request->n_channels) {
-		struct cfg80211_scan_request *old = rdev->int_scan_req;
+	if (request->req.n_channels) {
+		struct cfg80211_scan_request_int *old = rdev->int_scan_req;
 
 		rdev->int_scan_req = request;
 
@@ -1063,35 +1066,36 @@ static int cfg80211_scan_6ghz(struct cfg80211_registered_device *rdev)
 
 int cfg80211_scan(struct cfg80211_registered_device *rdev)
 {
-	struct cfg80211_scan_request *request;
-	struct cfg80211_scan_request *rdev_req = rdev->scan_req;
+	struct cfg80211_scan_request_int *request;
+	struct cfg80211_scan_request_int *rdev_req = rdev->scan_req;
 	u32 n_channels = 0, idx, i;
 
 	if (!(rdev->wiphy.flags & WIPHY_FLAG_SPLIT_SCAN_6GHZ))
 		return rdev_scan(rdev, rdev_req);
 
-	for (i = 0; i < rdev_req->n_channels; i++) {
-		if (rdev_req->channels[i]->band != NL80211_BAND_6GHZ)
+	for (i = 0; i < rdev_req->req.n_channels; i++) {
+		if (rdev_req->req.channels[i]->band != NL80211_BAND_6GHZ)
 			n_channels++;
 	}
 
 	if (!n_channels)
 		return cfg80211_scan_6ghz(rdev);
 
-	request = kzalloc(struct_size(request, channels, n_channels),
+	request = kzalloc(struct_size(request, req.channels, n_channels),
 			  GFP_KERNEL);
 	if (!request)
 		return -ENOMEM;
 
 	*request = *rdev_req;
-	request->n_channels = n_channels;
+	request->req.n_channels = n_channels;
 
-	for (i = idx = 0; i < rdev_req->n_channels; i++) {
-		if (rdev_req->channels[i]->band != NL80211_BAND_6GHZ)
-			request->channels[idx++] = rdev_req->channels[i];
+	for (i = idx = 0; i < rdev_req->req.n_channels; i++) {
+		if (rdev_req->req.channels[i]->band != NL80211_BAND_6GHZ)
+			request->req.channels[idx++] =
+				rdev_req->req.channels[i];
 	}
 
-	rdev_req->scan_6ghz = false;
+	rdev_req->req.scan_6ghz = false;
 	rdev->int_scan_req = request;
 	return rdev_scan(rdev, request);
 }
@@ -1099,7 +1103,7 @@ int cfg80211_scan(struct cfg80211_registered_device *rdev)
 void ___cfg80211_scan_done(struct cfg80211_registered_device *rdev,
 			   bool send_message)
 {
-	struct cfg80211_scan_request *request, *rdev_req;
+	struct cfg80211_scan_request_int *request, *rdev_req;
 	struct wireless_dev *wdev;
 	struct sk_buff *msg;
 #ifdef CONFIG_CFG80211_WEXT
@@ -1118,12 +1122,12 @@ void ___cfg80211_scan_done(struct cfg80211_registered_device *rdev,
 	if (!rdev_req)
 		return;
 
-	wdev = rdev_req->wdev;
+	wdev = rdev_req->req.wdev;
 	request = rdev->int_scan_req ? rdev->int_scan_req : rdev_req;
 
 	if (wdev_running(wdev) &&
 	    (rdev->wiphy.flags & WIPHY_FLAG_SPLIT_SCAN_6GHZ) &&
-	    !rdev_req->scan_6ghz && !request->info.aborted &&
+	    !rdev_req->req.scan_6ghz && !request->info.aborted &&
 	    !cfg80211_scan_6ghz(rdev))
 		return;
 
@@ -1136,10 +1140,10 @@ void ___cfg80211_scan_done(struct cfg80211_registered_device *rdev,
 		cfg80211_sme_scan_done(wdev->netdev);
 
 	if (!request->info.aborted &&
-	    request->flags & NL80211_SCAN_FLAG_FLUSH) {
+	    request->req.flags & NL80211_SCAN_FLAG_FLUSH) {
 		/* flush entries from previous scans */
 		spin_lock_bh(&rdev->bss_lock);
-		__cfg80211_bss_expire(rdev, request->scan_start);
+		__cfg80211_bss_expire(rdev, request->req.scan_start);
 		spin_unlock_bh(&rdev->bss_lock);
 	}
 
@@ -1175,13 +1179,16 @@ void __cfg80211_scan_done(struct wiphy *wiphy, struct wiphy_work *wk)
 void cfg80211_scan_done(struct cfg80211_scan_request *request,
 			struct cfg80211_scan_info *info)
 {
-	struct cfg80211_scan_info old_info = request->info;
+	struct cfg80211_scan_request_int *intreq =
+		container_of(request, struct cfg80211_scan_request_int, req);
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(request->wiphy);
+	struct cfg80211_scan_info old_info = intreq->info;
 
-	trace_cfg80211_scan_done(request, info);
-	WARN_ON(request != wiphy_to_rdev(request->wiphy)->scan_req &&
-		request != wiphy_to_rdev(request->wiphy)->int_scan_req);
+	trace_cfg80211_scan_done(intreq, info);
+	WARN_ON(intreq != rdev->scan_req &&
+		intreq != rdev->int_scan_req);
 
-	request->info = *info;
+	intreq->info = *info;
 
 	/*
 	 * In case the scan is split, the scan_start_tsf and tsf_bssid should
@@ -1189,14 +1196,13 @@ void cfg80211_scan_done(struct cfg80211_scan_request *request,
 	 * be non zero.
 	 */
 	if (request->scan_6ghz && old_info.scan_start_tsf) {
-		request->info.scan_start_tsf = old_info.scan_start_tsf;
-		memcpy(request->info.tsf_bssid, old_info.tsf_bssid,
-		       sizeof(request->info.tsf_bssid));
+		intreq->info.scan_start_tsf = old_info.scan_start_tsf;
+		memcpy(intreq->info.tsf_bssid, old_info.tsf_bssid,
+		       sizeof(intreq->info.tsf_bssid));
 	}
 
-	request->notified = true;
-	wiphy_work_queue(request->wiphy,
-			 &wiphy_to_rdev(request->wiphy)->scan_done_wk);
+	intreq->notified = true;
+	wiphy_work_queue(request->wiphy, &rdev->scan_done_wk);
 }
 EXPORT_SYMBOL(cfg80211_scan_done);
 
@@ -3500,7 +3506,7 @@ int cfg80211_wext_siwscan(struct net_device *dev,
 	struct cfg80211_registered_device *rdev;
 	struct wiphy *wiphy;
 	struct iw_scan_req *wreq = NULL;
-	struct cfg80211_scan_request *creq;
+	struct cfg80211_scan_request_int *creq;
 	int i, err, n_channels = 0;
 	enum nl80211_band band;
 
@@ -3530,19 +3536,20 @@ int cfg80211_wext_siwscan(struct net_device *dev,
 		n_channels = ieee80211_get_num_supported_channels(wiphy);
 	}
 
-	creq = kzalloc(struct_size(creq, channels, n_channels) +
+	creq = kzalloc(struct_size(creq, req.channels, n_channels) +
 		       sizeof(struct cfg80211_ssid),
 		       GFP_ATOMIC);
 	if (!creq)
 		return -ENOMEM;
 
-	creq->wiphy = wiphy;
-	creq->wdev = dev->ieee80211_ptr;
+	creq->req.wiphy = wiphy;
+	creq->req.wdev = dev->ieee80211_ptr;
 	/* SSIDs come after channels */
-	creq->ssids = (void *)creq + struct_size(creq, channels, n_channels);
-	creq->n_channels = n_channels;
-	creq->n_ssids = 1;
-	creq->scan_start = jiffies;
+	creq->req.ssids = (void *)creq +
+			  struct_size(creq, req.channels, n_channels);
+	creq->req.n_channels = n_channels;
+	creq->req.n_ssids = 1;
+	creq->req.scan_start = jiffies;
 
 	/* translate "Scan on frequencies" request */
 	i = 0;
@@ -3558,7 +3565,7 @@ int cfg80211_wext_siwscan(struct net_device *dev,
 			/* ignore disabled channels */
 			chan = &wiphy->bands[band]->channels[j];
 			if (chan->flags & IEEE80211_CHAN_DISABLED ||
-			    !cfg80211_wdev_channel_allowed(creq->wdev, chan))
+			    !cfg80211_wdev_channel_allowed(creq->req.wdev, chan))
 				continue;
 
 			/* If we have a wireless request structure and the
@@ -3581,7 +3588,8 @@ int cfg80211_wext_siwscan(struct net_device *dev,
 			}
 
 		wext_freq_found:
-			creq->channels[i] = &wiphy->bands[band]->channels[j];
+			creq->req.channels[i] =
+				&wiphy->bands[band]->channels[j];
 			i++;
 		wext_freq_not_found: ;
 		}
@@ -3592,28 +3600,30 @@ int cfg80211_wext_siwscan(struct net_device *dev,
 		goto out;
 	}
 
-	/* Set real number of channels specified in creq->channels[] */
-	creq->n_channels = i;
+	/* Set real number of channels specified in creq->req.channels[] */
+	creq->req.n_channels = i;
 
 	/* translate "Scan for SSID" request */
 	if (wreq) {
 		if (wrqu->data.flags & IW_SCAN_THIS_ESSID) {
 			if (wreq->essid_len > IEEE80211_MAX_SSID_LEN)
 				return -EINVAL;
-			memcpy(creq->ssids[0].ssid, wreq->essid, wreq->essid_len);
-			creq->ssids[0].ssid_len = wreq->essid_len;
+			memcpy(creq->req.ssids[0].ssid, wreq->essid,
+			       wreq->essid_len);
+			creq->req.ssids[0].ssid_len = wreq->essid_len;
 		}
 		if (wreq->scan_type == IW_SCAN_TYPE_PASSIVE) {
-			creq->ssids = NULL;
-			creq->n_ssids = 0;
+			creq->req.ssids = NULL;
+			creq->req.n_ssids = 0;
 		}
 	}
 
 	for (i = 0; i < NUM_NL80211_BANDS; i++)
 		if (wiphy->bands[i])
-			creq->rates[i] = (1 << wiphy->bands[i]->n_bitrates) - 1;
+			creq->req.rates[i] =
+				(1 << wiphy->bands[i]->n_bitrates) - 1;
 
-	eth_broadcast_addr(creq->bssid);
+	eth_broadcast_addr(creq->req.bssid);
 
 	scoped_guard(wiphy, &rdev->wiphy) {
 		rdev->scan_req = creq;
diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index cf998500a965..6d7a7e7f0fc2 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -5,7 +5,7 @@
  * (for nl80211's connect() and wext)
  *
  * Copyright 2009	Johannes Berg <johannes@sipsolutions.net>
- * Copyright (C) 2009, 2020, 2022-2024 Intel Corporation. All rights reserved.
+ * Copyright (C) 2009, 2020, 2022-2025 Intel Corporation. All rights reserved.
  * Copyright 2017	Intel Deutschland GmbH
  */
 
@@ -64,7 +64,7 @@ static void cfg80211_sme_free(struct wireless_dev *wdev)
 static int cfg80211_conn_scan(struct wireless_dev *wdev)
 {
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
-	struct cfg80211_scan_request *request;
+	struct cfg80211_scan_request_int *request;
 	int n_channels, err;
 
 	lockdep_assert_wiphy(wdev->wiphy);
@@ -77,13 +77,13 @@ static int cfg80211_conn_scan(struct wireless_dev *wdev)
 	else
 		n_channels = ieee80211_get_num_supported_channels(wdev->wiphy);
 
-	request = kzalloc(sizeof(*request) + sizeof(request->ssids[0]) +
-			  sizeof(request->channels[0]) * n_channels,
+	request = kzalloc(sizeof(*request) + sizeof(request->req.ssids[0]) +
+			  sizeof(request->req.channels[0]) * n_channels,
 			  GFP_KERNEL);
 	if (!request)
 		return -ENOMEM;
 
-	request->n_channels = n_channels;
+	request->req.n_channels = n_channels;
 	if (wdev->conn->params.channel) {
 		enum nl80211_band band = wdev->conn->params.channel->band;
 		struct ieee80211_supported_band *sband =
@@ -93,8 +93,8 @@ static int cfg80211_conn_scan(struct wireless_dev *wdev)
 			kfree(request);
 			return -EINVAL;
 		}
-		request->channels[0] = wdev->conn->params.channel;
-		request->rates[band] = (1 << sband->n_bitrates) - 1;
+		request->req.channels[0] = wdev->conn->params.channel;
+		request->req.rates[band] = (1 << sband->n_bitrates) - 1;
 	} else {
 		int i = 0, j;
 		enum nl80211_band band;
@@ -109,26 +109,26 @@ static int cfg80211_conn_scan(struct wireless_dev *wdev)
 				channel = &bands->channels[j];
 				if (channel->flags & IEEE80211_CHAN_DISABLED)
 					continue;
-				request->channels[i++] = channel;
+				request->req.channels[i++] = channel;
 			}
-			request->rates[band] = (1 << bands->n_bitrates) - 1;
+			request->req.rates[band] = (1 << bands->n_bitrates) - 1;
 		}
 		n_channels = i;
 	}
-	request->n_channels = n_channels;
-	request->ssids = (void *)request +
-		struct_size(request, channels, n_channels);
-	request->n_ssids = 1;
+	request->req.n_channels = n_channels;
+	request->req.ssids = (void *)request +
+			     struct_size(request, req.channels, n_channels);
+	request->req.n_ssids = 1;
 
-	memcpy(request->ssids[0].ssid, wdev->conn->params.ssid,
-		wdev->conn->params.ssid_len);
-	request->ssids[0].ssid_len = wdev->conn->params.ssid_len;
+	memcpy(request->req.ssids[0].ssid, wdev->conn->params.ssid,
+	       wdev->conn->params.ssid_len);
+	request->req.ssids[0].ssid_len = wdev->conn->params.ssid_len;
 
-	eth_broadcast_addr(request->bssid);
+	eth_broadcast_addr(request->req.bssid);
 
-	request->wdev = wdev;
-	request->wiphy = &rdev->wiphy;
-	request->scan_start = jiffies;
+	request->req.wdev = wdev;
+	request->req.wiphy = &rdev->wiphy;
+	request->req.scan_start = jiffies;
 
 	rdev->scan_req = request;
 
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 4ed9fada4ec0..083c35d97ed2 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -373,7 +373,8 @@ TRACE_EVENT(rdev_return_int,
 );
 
 TRACE_EVENT(rdev_scan,
-	TP_PROTO(struct wiphy *wiphy, struct cfg80211_scan_request *request),
+	TP_PROTO(struct wiphy *wiphy,
+		 struct cfg80211_scan_request_int *request),
 	TP_ARGS(wiphy, request),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
@@ -3685,12 +3686,12 @@ TRACE_EVENT(cfg80211_tdls_oper_request,
 	);
 
 TRACE_EVENT(cfg80211_scan_done,
-	TP_PROTO(struct cfg80211_scan_request *request,
+	TP_PROTO(struct cfg80211_scan_request_int *request,
 		 struct cfg80211_scan_info *info),
 	TP_ARGS(request, info),
 	TP_STRUCT__entry(
 		__field(u32, n_channels)
-		__dynamic_array(u8, ie, request ? request->ie_len : 0)
+		__dynamic_array(u8, ie, request ? request->req.ie_len : 0)
 		__array(u32, rates, NUM_NL80211_BANDS)
 		__field(u32, wdev_id)
 		MAC_ENTRY(wiphy_mac)
@@ -3701,16 +3702,16 @@ TRACE_EVENT(cfg80211_scan_done,
 	),
 	TP_fast_assign(
 		if (request) {
-			memcpy(__get_dynamic_array(ie), request->ie,
-			       request->ie_len);
-			memcpy(__entry->rates, request->rates,
+			memcpy(__get_dynamic_array(ie), request->req.ie,
+			       request->req.ie_len);
+			memcpy(__entry->rates, request->req.rates,
 			       NUM_NL80211_BANDS);
-			__entry->wdev_id = request->wdev ?
-					request->wdev->identifier : 0;
-			if (request->wiphy)
+			__entry->wdev_id = request->req.wdev ?
+					request->req.wdev->identifier : 0;
+			if (request->req.wiphy)
 				MAC_ASSIGN(wiphy_mac,
-					   request->wiphy->perm_addr);
-			__entry->no_cck = request->no_cck;
+					   request->req.wiphy->perm_addr);
+			__entry->no_cck = request->req.no_cck;
 		}
 		if (info) {
 			__entry->aborted = info->aborted;
-- 
2.34.1


