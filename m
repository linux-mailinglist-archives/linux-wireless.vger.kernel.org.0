Return-Path: <linux-wireless+bounces-15597-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C69D79D5B36
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 09:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8259F28345C
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 08:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FD418BC32;
	Fri, 22 Nov 2024 08:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="HjgMZylF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D674C18C913
	for <linux-wireless@vger.kernel.org>; Fri, 22 Nov 2024 08:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732264956; cv=none; b=DCPCF6y2bUD/OjxM6/qQ30A/EY2BRWpISkX2wbDX6//rR8Ei7HQF4EIheBov826AHLF1YD4RrGIEV18B7ERABd8vwSvFoyuVJFwp19qLt2iMHdmP7jiDBN3tEM9qitAAMiML+gnYvyGW6Khhb4WZz7tyYF7/+HVK3RSqBpGjmUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732264956; c=relaxed/simple;
	bh=D3f4oS8Jwuz9ZC3KKzogLRHNHyv2/fHXllJN5Gpkp+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C50UWUwO1fFeRblhVA7qreJOjZpFNQ9xYt4UAOrdvfgK31VxctfjGmtJmAG1U2TH/hLcWCMhS6AyBTatBjYJ9JdsM+P7lR0vdAnHi+6JFq/tQsbTXA71bLZzQCP2lofs8IM7fcqgipaohpdaQ2O8LrHdKYMgDe8jBYrt5XXp4qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=HjgMZylF; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=7i+ZyYSSiRqHFM5Gjg0sekywdc8Ylh4PG5WDrWbX7vk=; t=1732264952; x=1733474552; 
	b=HjgMZylFyMXTzNDZN5XNARSVopcphLLLi4h1q4SqVcbETFCzQEQ7ZCd5jSRVsivB3LL+KxUARAH
	kOViFZUatnvTZCmEVi8kYQDZF47WlZyqCqJ4m70vC7gzFcnNFz+KhLqzvmfbP3QDH5paWzwWsnJnv
	PomFwP/TTaTi4kifD6gW6KRj2GADRHKC7YLBsjH/64EMFYhBWbfzaRX5eiHnF+G2r4TR11oBoCsSQ
	m8zWIQbQMWM0CEm4OU78GkbhmdYigckiVW7+jrre6ByiFAeN95BxT9v/uLxJxWtK2SF9uQ2U9bDDY
	RLsVjRBwbqIm8igXgF3YW1TPir/BSjXIB77w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tEPFE-0000000BUoF-21fd;
	Fri, 22 Nov 2024 09:42:28 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH v3 1/2] wifi: cfg80211: define and use wiphy guard
Date: Fri, 22 Nov 2024 09:42:25 +0100
Message-ID: <20241122094225.88765cbaab65.I610c9b14f36902e75e1d13f0db29f8bef2298804@changeid>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Define a guard for the wiphy mutex, and use it in
most code in cfg80211, though not all due to some
interaction with RTNL and/or indentation.

Suggested-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v3: remove scoped_guard inside wait_event(), it seems to
    cause issues due to multiple "unique" IDs being the
    same on the same line (for some compilers/configs)
---
 include/net/cfg80211.h     |   4 +
 net/wireless/chan.c        |   4 +-
 net/wireless/core.c        |  42 +++--
 net/wireless/mlme.c        |   8 +-
 net/wireless/nl80211.c     | 190 +++++++++-------------
 net/wireless/pmsr.c        |   4 +-
 net/wireless/reg.c         |  53 +++----
 net/wireless/scan.c        |  40 +++--
 net/wireless/sme.c         |  12 +-
 net/wireless/util.c        |   7 +-
 net/wireless/wext-compat.c | 317 +++++++++++++------------------------
 net/wireless/wext-sme.c    |  43 ++---
 12 files changed, 277 insertions(+), 447 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 27acf1292a5c..63e79a22a214 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -6031,6 +6031,10 @@ static inline void wiphy_unlock(struct wiphy *wiphy)
 	mutex_unlock(&wiphy->mtx);
 }
 
+DEFINE_GUARD(wiphy, struct wiphy *,
+	     mutex_lock(&_T->mtx),
+	     mutex_unlock(&_T->mtx))
+
 struct wiphy_work;
 typedef void (*wiphy_work_func_t)(struct wiphy *, struct wiphy_work *);
 
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 40b6375a5de4..833ea73053a4 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -1039,10 +1039,10 @@ bool cfg80211_any_wiphy_oper_chan(struct wiphy *wiphy,
 		if (!reg_dfs_domain_same(wiphy, &rdev->wiphy))
 			continue;
 
-		wiphy_lock(&rdev->wiphy);
+		guard(wiphy)(&rdev->wiphy);
+
 		found = cfg80211_is_wiphy_oper_chan(&rdev->wiphy, chan) ||
 			cfg80211_offchan_chain_is_active(rdev, chan);
-		wiphy_unlock(&rdev->wiphy);
 
 		if (found)
 			return true;
diff --git a/net/wireless/core.c b/net/wireless/core.c
index afbdc549fb4a..70857018f020 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -191,7 +191,8 @@ int cfg80211_switch_netns(struct cfg80211_registered_device *rdev,
 		return err;
 	}
 
-	wiphy_lock(&rdev->wiphy);
+	guard(wiphy)(&rdev->wiphy);
+
 	list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list) {
 		if (!wdev->netdev)
 			continue;
@@ -212,7 +213,6 @@ int cfg80211_switch_netns(struct cfg80211_registered_device *rdev,
 			continue;
 		nl80211_notify_iface(rdev, wdev, NL80211_CMD_NEW_INTERFACE);
 	}
-	wiphy_unlock(&rdev->wiphy);
 
 	return 0;
 }
@@ -221,9 +221,9 @@ static void cfg80211_rfkill_poll(struct rfkill *rfkill, void *data)
 {
 	struct cfg80211_registered_device *rdev = data;
 
-	wiphy_lock(&rdev->wiphy);
+	guard(wiphy)(&rdev->wiphy);
+
 	rdev_rfkill_poll(rdev);
-	wiphy_unlock(&rdev->wiphy);
 }
 
 void cfg80211_stop_p2p_device(struct cfg80211_registered_device *rdev,
@@ -283,7 +283,7 @@ void cfg80211_shutdown_all_interfaces(struct wiphy *wiphy)
 
 		/* otherwise, check iftype */
 
-		wiphy_lock(wiphy);
+		guard(wiphy)(wiphy);
 
 		switch (wdev->iftype) {
 		case NL80211_IFTYPE_P2P_DEVICE:
@@ -295,8 +295,6 @@ void cfg80211_shutdown_all_interfaces(struct wiphy *wiphy)
 		default:
 			break;
 		}
-
-		wiphy_unlock(wiphy);
 	}
 }
 EXPORT_SYMBOL_GPL(cfg80211_shutdown_all_interfaces);
@@ -331,9 +329,9 @@ static void cfg80211_event_work(struct work_struct *work)
 	rdev = container_of(work, struct cfg80211_registered_device,
 			    event_work);
 
-	wiphy_lock(&rdev->wiphy);
+	guard(wiphy)(&rdev->wiphy);
+
 	cfg80211_process_rdev_events(rdev);
-	wiphy_unlock(&rdev->wiphy);
 }
 
 void cfg80211_destroy_ifaces(struct cfg80211_registered_device *rdev)
@@ -347,10 +345,10 @@ void cfg80211_destroy_ifaces(struct cfg80211_registered_device *rdev)
 			if (wdev->netdev)
 				dev_close(wdev->netdev);
 
-			wiphy_lock(&rdev->wiphy);
+			guard(wiphy)(&rdev->wiphy);
+
 			cfg80211_leave(rdev, wdev);
 			cfg80211_remove_virtual_intf(rdev, wdev);
-			wiphy_unlock(&rdev->wiphy);
 		}
 	}
 }
@@ -423,9 +421,9 @@ static void cfg80211_wiphy_work(struct work_struct *work)
 
 	trace_wiphy_work_worker_start(&rdev->wiphy);
 
-	wiphy_lock(&rdev->wiphy);
+	guard(wiphy)(&rdev->wiphy);
 	if (rdev->suspended)
-		goto out;
+		return;
 
 	spin_lock_irq(&rdev->wiphy_work_lock);
 	wk = list_first_entry_or_null(&rdev->wiphy_work_list,
@@ -441,8 +439,6 @@ static void cfg80211_wiphy_work(struct work_struct *work)
 	} else {
 		spin_unlock_irq(&rdev->wiphy_work_lock);
 	}
-out:
-	wiphy_unlock(&rdev->wiphy);
 }
 
 /* exported functions */
@@ -1526,9 +1522,9 @@ static int cfg80211_netdev_notifier_call(struct notifier_block *nb,
 		break;
 	case NETDEV_REGISTER:
 		if (!wdev->registered) {
-			wiphy_lock(&rdev->wiphy);
+			guard(wiphy)(&rdev->wiphy);
+
 			cfg80211_register_wdev(rdev, wdev);
-			wiphy_unlock(&rdev->wiphy);
 		}
 		break;
 	case NETDEV_UNREGISTER:
@@ -1537,16 +1533,16 @@ static int cfg80211_netdev_notifier_call(struct notifier_block *nb,
 		 * so check wdev->registered.
 		 */
 		if (wdev->registered && !wdev->registering) {
-			wiphy_lock(&rdev->wiphy);
+			guard(wiphy)(&rdev->wiphy);
+
 			_cfg80211_unregister_wdev(wdev, false);
-			wiphy_unlock(&rdev->wiphy);
 		}
 		break;
 	case NETDEV_GOING_DOWN:
-		wiphy_lock(&rdev->wiphy);
-		cfg80211_leave(rdev, wdev);
-		cfg80211_remove_links(wdev);
-		wiphy_unlock(&rdev->wiphy);
+		scoped_guard(wiphy, &rdev->wiphy) {
+			cfg80211_leave(rdev, wdev);
+			cfg80211_remove_links(wdev);
+		}
 		/* since we just did cfg80211_leave() nothing to do there */
 		cancel_work_sync(&wdev->disconnect_wk);
 		cancel_work_sync(&wdev->pmsr_free_wk);
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index a5eb92d93074..9d577523462d 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -627,10 +627,10 @@ void cfg80211_mgmt_registrations_update_wk(struct work_struct *wk)
 	rdev = container_of(wk, struct cfg80211_registered_device,
 			    mgmt_registrations_update_wk);
 
-	wiphy_lock(&rdev->wiphy);
+	guard(wiphy)(&rdev->wiphy);
+
 	list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list)
 		cfg80211_mgmt_registrations_update(wdev);
-	wiphy_unlock(&rdev->wiphy);
 }
 
 int cfg80211_mlme_register_mgmt(struct wireless_dev *wdev, u32 snd_portid,
@@ -1193,10 +1193,10 @@ cfg80211_background_cac_event(struct cfg80211_registered_device *rdev,
 			      const struct cfg80211_chan_def *chandef,
 			      enum nl80211_radar_event event)
 {
-	wiphy_lock(&rdev->wiphy);
+	guard(wiphy)(&rdev->wiphy);
+
 	__cfg80211_background_cac_event(rdev, rdev->background_radar_wdev,
 					chandef, event);
-	wiphy_unlock(&rdev->wiphy);
 }
 
 void cfg80211_background_cac_done_wk(struct work_struct *work)
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 9d2edb71f981..9590f9bd2ec0 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3626,7 +3626,7 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 	} else
 		wdev = netdev->ieee80211_ptr;
 
-	wiphy_lock(&rdev->wiphy);
+	guard(wiphy)(&rdev->wiphy);
 
 	/*
 	 * end workaround code, by now the rdev is available
@@ -3639,32 +3639,24 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 	rtnl_unlock();
 
 	if (result)
-		goto out;
+		return result;
 
 	if (info->attrs[NL80211_ATTR_WIPHY_TXQ_PARAMS]) {
 		struct ieee80211_txq_params txq_params;
 		struct nlattr *tb[NL80211_TXQ_ATTR_MAX + 1];
 
-		if (!rdev->ops->set_txq_params) {
-			result = -EOPNOTSUPP;
-			goto out;
-		}
+		if (!rdev->ops->set_txq_params)
+			return -EOPNOTSUPP;
 
-		if (!netdev) {
-			result = -EINVAL;
-			goto out;
-		}
+		if (!netdev)
+			return -EINVAL;
 
 		if (netdev->ieee80211_ptr->iftype != NL80211_IFTYPE_AP &&
-		    netdev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_GO) {
-			result = -EINVAL;
-			goto out;
-		}
+		    netdev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_GO)
+			return -EINVAL;
 
-		if (!netif_running(netdev)) {
-			result = -ENETDOWN;
-			goto out;
-		}
+		if (!netif_running(netdev))
+			return -ENETDOWN;
 
 		nla_for_each_nested(nl_txq_params,
 				    info->attrs[NL80211_ATTR_WIPHY_TXQ_PARAMS],
@@ -3675,10 +3667,11 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 							     txq_params_policy,
 							     info->extack);
 			if (result)
-				goto out;
+				return result;
+
 			result = parse_txq_params(tb, &txq_params);
 			if (result)
-				goto out;
+				return result;
 
 			txq_params.link_id =
 				nl80211_link_id_or_invalid(info->attrs);
@@ -3694,7 +3687,7 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 				result = rdev_set_txq_params(rdev, netdev,
 							     &txq_params);
 			if (result)
-				goto out;
+				return result;
 		}
 	}
 
@@ -3711,7 +3704,7 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 		}
 
 		if (result)
-			goto out;
+			return result;
 	}
 
 	if (info->attrs[NL80211_ATTR_WIPHY_TX_POWER_SETTING]) {
@@ -3722,19 +3715,15 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 		if (!(rdev->wiphy.features & NL80211_FEATURE_VIF_TXPOWER))
 			txp_wdev = NULL;
 
-		if (!rdev->ops->set_tx_power) {
-			result = -EOPNOTSUPP;
-			goto out;
-		}
+		if (!rdev->ops->set_tx_power)
+			return -EOPNOTSUPP;
 
 		idx = NL80211_ATTR_WIPHY_TX_POWER_SETTING;
 		type = nla_get_u32(info->attrs[idx]);
 
 		if (!info->attrs[NL80211_ATTR_WIPHY_TX_POWER_LEVEL] &&
-		    (type != NL80211_TX_POWER_AUTOMATIC)) {
-			result = -EINVAL;
-			goto out;
-		}
+		    (type != NL80211_TX_POWER_AUTOMATIC))
+			return -EINVAL;
 
 		if (type != NL80211_TX_POWER_AUTOMATIC) {
 			idx = NL80211_ATTR_WIPHY_TX_POWER_LEVEL;
@@ -3743,7 +3732,7 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 
 		result = rdev_set_tx_power(rdev, txp_wdev, type, mbm);
 		if (result)
-			goto out;
+			return result;
 	}
 
 	if (info->attrs[NL80211_ATTR_WIPHY_ANTENNA_TX] &&
@@ -3752,10 +3741,8 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 
 		if ((!rdev->wiphy.available_antennas_tx &&
 		     !rdev->wiphy.available_antennas_rx) ||
-		    !rdev->ops->set_antenna) {
-			result = -EOPNOTSUPP;
-			goto out;
-		}
+		    !rdev->ops->set_antenna)
+			return -EOPNOTSUPP;
 
 		tx_ant = nla_get_u32(info->attrs[NL80211_ATTR_WIPHY_ANTENNA_TX]);
 		rx_ant = nla_get_u32(info->attrs[NL80211_ATTR_WIPHY_ANTENNA_RX]);
@@ -3763,17 +3750,15 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 		/* reject antenna configurations which don't match the
 		 * available antenna masks, except for the "all" mask */
 		if ((~tx_ant && (tx_ant & ~rdev->wiphy.available_antennas_tx)) ||
-		    (~rx_ant && (rx_ant & ~rdev->wiphy.available_antennas_rx))) {
-			result = -EINVAL;
-			goto out;
-		}
+		    (~rx_ant && (rx_ant & ~rdev->wiphy.available_antennas_rx)))
+			return -EINVAL;
 
 		tx_ant = tx_ant & rdev->wiphy.available_antennas_tx;
 		rx_ant = rx_ant & rdev->wiphy.available_antennas_rx;
 
 		result = rdev_set_antenna(rdev, tx_ant, rx_ant);
 		if (result)
-			goto out;
+			return result;
 	}
 
 	changed = 0;
@@ -3795,10 +3780,8 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[NL80211_ATTR_WIPHY_FRAG_THRESHOLD]) {
 		frag_threshold = nla_get_u32(
 			info->attrs[NL80211_ATTR_WIPHY_FRAG_THRESHOLD]);
-		if (frag_threshold < 256) {
-			result = -EINVAL;
-			goto out;
-		}
+		if (frag_threshold < 256)
+			return -EINVAL;
 
 		if (frag_threshold != (u32) -1) {
 			/*
@@ -3819,10 +3802,8 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	if (info->attrs[NL80211_ATTR_WIPHY_COVERAGE_CLASS]) {
-		if (info->attrs[NL80211_ATTR_WIPHY_DYN_ACK]) {
-			result = -EINVAL;
-			goto out;
-		}
+		if (info->attrs[NL80211_ATTR_WIPHY_DYN_ACK])
+			return -EINVAL;
 
 		coverage_class = nla_get_u8(
 			info->attrs[NL80211_ATTR_WIPHY_COVERAGE_CLASS]);
@@ -3830,20 +3811,17 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	if (info->attrs[NL80211_ATTR_WIPHY_DYN_ACK]) {
-		if (!(rdev->wiphy.features & NL80211_FEATURE_ACKTO_ESTIMATION)) {
-			result = -EOPNOTSUPP;
-			goto out;
-		}
+		if (!(rdev->wiphy.features & NL80211_FEATURE_ACKTO_ESTIMATION))
+			return -EOPNOTSUPP;
 
 		changed |= WIPHY_PARAM_DYN_ACK;
 	}
 
 	if (info->attrs[NL80211_ATTR_TXQ_LIMIT]) {
 		if (!wiphy_ext_feature_isset(&rdev->wiphy,
-					     NL80211_EXT_FEATURE_TXQS)) {
-			result = -EOPNOTSUPP;
-			goto out;
-		}
+					     NL80211_EXT_FEATURE_TXQS))
+			return -EOPNOTSUPP;
+
 		txq_limit = nla_get_u32(
 			info->attrs[NL80211_ATTR_TXQ_LIMIT]);
 		changed |= WIPHY_PARAM_TXQ_LIMIT;
@@ -3851,10 +3829,9 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 
 	if (info->attrs[NL80211_ATTR_TXQ_MEMORY_LIMIT]) {
 		if (!wiphy_ext_feature_isset(&rdev->wiphy,
-					     NL80211_EXT_FEATURE_TXQS)) {
-			result = -EOPNOTSUPP;
-			goto out;
-		}
+					     NL80211_EXT_FEATURE_TXQS))
+			return -EOPNOTSUPP;
+
 		txq_memory_limit = nla_get_u32(
 			info->attrs[NL80211_ATTR_TXQ_MEMORY_LIMIT]);
 		changed |= WIPHY_PARAM_TXQ_MEMORY_LIMIT;
@@ -3862,10 +3839,9 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 
 	if (info->attrs[NL80211_ATTR_TXQ_QUANTUM]) {
 		if (!wiphy_ext_feature_isset(&rdev->wiphy,
-					     NL80211_EXT_FEATURE_TXQS)) {
-			result = -EOPNOTSUPP;
-			goto out;
-		}
+					     NL80211_EXT_FEATURE_TXQS))
+			return -EOPNOTSUPP;
+
 		txq_quantum = nla_get_u32(
 			info->attrs[NL80211_ATTR_TXQ_QUANTUM]);
 		changed |= WIPHY_PARAM_TXQ_QUANTUM;
@@ -3877,10 +3853,8 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 		u8 old_coverage_class;
 		u32 old_txq_limit, old_txq_memory_limit, old_txq_quantum;
 
-		if (!rdev->ops->set_wiphy_params) {
-			result = -EOPNOTSUPP;
-			goto out;
-		}
+		if (!rdev->ops->set_wiphy_params)
+			return -EOPNOTSUPP;
 
 		old_retry_short = rdev->wiphy.retry_short;
 		old_retry_long = rdev->wiphy.retry_long;
@@ -3918,15 +3892,11 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 			rdev->wiphy.txq_limit = old_txq_limit;
 			rdev->wiphy.txq_memory_limit = old_txq_memory_limit;
 			rdev->wiphy.txq_quantum = old_txq_quantum;
-			goto out;
+			return result;
 		}
 	}
 
-	result = 0;
-
-out:
-	wiphy_unlock(&rdev->wiphy);
-	return result;
+	return 0;
 }
 
 int nl80211_send_chandef(struct sk_buff *msg, const struct cfg80211_chan_def *chandef)
@@ -4144,22 +4114,22 @@ static int nl80211_dump_interface(struct sk_buff *skb, struct netlink_callback *
 
 		if_idx = 0;
 
-		wiphy_lock(&rdev->wiphy);
+		guard(wiphy)(&rdev->wiphy);
+
 		list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list) {
 			if (if_idx < if_start) {
 				if_idx++;
 				continue;
 			}
+
 			if (nl80211_send_iface(skb, NETLINK_CB(cb->skb).portid,
 					       cb->nlh->nlmsg_seq, NLM_F_MULTI,
 					       rdev, wdev,
-					       NL80211_CMD_NEW_INTERFACE) < 0) {
-				wiphy_unlock(&rdev->wiphy);
+					       NL80211_CMD_NEW_INTERFACE) < 0)
 				goto out;
-			}
+
 			if_idx++;
 		}
-		wiphy_unlock(&rdev->wiphy);
 
 		if_start = 0;
 		wp_idx++;
@@ -4517,16 +4487,13 @@ static int _nl80211_new_interface(struct sk_buff *skb, struct genl_info *info)
 static int nl80211_new_interface(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
-	int ret;
 
 	/* to avoid failing a new interface creation due to pending removal */
 	cfg80211_destroy_ifaces(rdev);
 
-	wiphy_lock(&rdev->wiphy);
-	ret = _nl80211_new_interface(skb, info);
-	wiphy_unlock(&rdev->wiphy);
+	guard(wiphy)(&rdev->wiphy);
 
-	return ret;
+	return _nl80211_new_interface(skb, info);
 }
 
 static int nl80211_del_interface(struct sk_buff *skb, struct genl_info *info)
@@ -10098,7 +10065,7 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 	struct cfg80211_chan_def chandef;
 	enum nl80211_dfs_regions dfs_region;
 	unsigned int cac_time_ms;
-	int err = -EINVAL;
+	int err;
 
 	flush_delayed_work(&rdev->dfs_update_channels_wk);
 
@@ -10113,35 +10080,29 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 		return -EINVAL;
 	}
 
-	wiphy_lock(wiphy);
+	guard(wiphy)(wiphy);
 
 	dfs_region = reg_get_dfs_region(wiphy);
 	if (dfs_region == NL80211_DFS_UNSET)
-		goto unlock;
+		return -EINVAL;
 
 	err = nl80211_parse_chandef(rdev, info, &chandef);
 	if (err)
-		goto unlock;
+		return err;
 
 	err = cfg80211_chandef_dfs_required(wiphy, &chandef, wdev->iftype);
 	if (err < 0)
-		goto unlock;
+		return err;
 
-	if (err == 0) {
-		err = -EINVAL;
-		goto unlock;
-	}
+	if (err == 0)
+		return -EINVAL;
 
-	if (!cfg80211_chandef_dfs_usable(wiphy, &chandef)) {
-		err = -EINVAL;
-		goto unlock;
-	}
+	if (!cfg80211_chandef_dfs_usable(wiphy, &chandef))
+		return -EINVAL;
 
-	if (nla_get_flag(info->attrs[NL80211_ATTR_RADAR_BACKGROUND])) {
-		err = cfg80211_start_background_radar_detection(rdev, wdev,
-								&chandef);
-		goto unlock;
-	}
+	if (nla_get_flag(info->attrs[NL80211_ATTR_RADAR_BACKGROUND]))
+		return cfg80211_start_background_radar_detection(rdev, wdev,
+								 &chandef);
 
 	if (cfg80211_beaconing_iface_active(wdev)) {
 		/* During MLO other link(s) can beacon, only the current link
@@ -10151,26 +10112,19 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 		    !wdev->links[link_id].ap.beacon_interval) {
 			/* nothing */
 		} else {
-			err = -EBUSY;
-			goto unlock;
+			return -EBUSY;
 		}
 	}
 
-	if (wdev->links[link_id].cac_started) {
-		err = -EBUSY;
-		goto unlock;
-	}
+	if (wdev->links[link_id].cac_started)
+		return -EBUSY;
 
 	/* CAC start is offloaded to HW and can't be started manually */
-	if (wiphy_ext_feature_isset(wiphy, NL80211_EXT_FEATURE_DFS_OFFLOAD)) {
-		err = -EOPNOTSUPP;
-		goto unlock;
-	}
+	if (wiphy_ext_feature_isset(wiphy, NL80211_EXT_FEATURE_DFS_OFFLOAD))
+		return -EOPNOTSUPP;
 
-	if (!rdev->ops->start_radar_detection) {
-		err = -EOPNOTSUPP;
-		goto unlock;
-	}
+	if (!rdev->ops->start_radar_detection)
+		return -EOPNOTSUPP;
 
 	cac_time_ms = cfg80211_chandef_dfs_cac_time(&rdev->wiphy, &chandef);
 	if (WARN_ON(!cac_time_ms))
@@ -10197,10 +10151,8 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 		wdev->links[link_id].cac_start_time = jiffies;
 		wdev->links[link_id].cac_time_ms = cac_time_ms;
 	}
-unlock:
-	wiphy_unlock(wiphy);
 
-	return err;
+	return 0;
 }
 
 static int nl80211_notify_radar_detection(struct sk_buff *skb,
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index 0396fa19bdf1..a117f5093ca2 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -630,9 +630,9 @@ void cfg80211_pmsr_free_wk(struct work_struct *work)
 	struct wireless_dev *wdev = container_of(work, struct wireless_dev,
 						 pmsr_free_wk);
 
-	wiphy_lock(wdev->wiphy);
+	guard(wiphy)(wdev->wiphy);
+
 	cfg80211_pmsr_process_abort(wdev);
-	wiphy_unlock(wdev->wiphy);
 }
 
 void cfg80211_pmsr_wdev_down(struct wireless_dev *wdev)
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 1df65a5a44f7..2dd0533e7660 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2465,11 +2465,11 @@ static void reg_leave_invalid_chans(struct wiphy *wiphy)
 	struct wireless_dev *wdev;
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 
-	wiphy_lock(wiphy);
+	guard(wiphy)(wiphy);
+
 	list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list)
 		if (!reg_wdev_chan_valid(wiphy, wdev))
 			cfg80211_leave(rdev, wdev);
-	wiphy_unlock(wiphy);
 }
 
 static void reg_check_chans_work(struct work_struct *work)
@@ -2649,13 +2649,11 @@ void wiphy_apply_custom_regulatory(struct wiphy *wiphy,
 		return;
 
 	rtnl_lock();
-	wiphy_lock(wiphy);
-
-	tmp = get_wiphy_regdom(wiphy);
-	rcu_assign_pointer(wiphy->regd, new_regd);
-	rcu_free_regdom(tmp);
-
-	wiphy_unlock(wiphy);
+	scoped_guard(wiphy, wiphy) {
+		tmp = get_wiphy_regdom(wiphy);
+		rcu_assign_pointer(wiphy->regd, new_regd);
+		rcu_free_regdom(tmp);
+	}
 	rtnl_unlock();
 }
 EXPORT_SYMBOL(wiphy_apply_custom_regulatory);
@@ -2825,9 +2823,9 @@ reg_process_hint_driver(struct wiphy *wiphy,
 
 		tmp = get_wiphy_regdom(wiphy);
 		ASSERT_RTNL();
-		wiphy_lock(wiphy);
-		rcu_assign_pointer(wiphy->regd, regd);
-		wiphy_unlock(wiphy);
+		scoped_guard(wiphy, wiphy) {
+			rcu_assign_pointer(wiphy->regd, regd);
+		}
 		rcu_free_regdom(tmp);
 	}
 
@@ -3205,9 +3203,9 @@ static void reg_process_self_managed_hints(void)
 	ASSERT_RTNL();
 
 	for_each_rdev(rdev) {
-		wiphy_lock(&rdev->wiphy);
+		guard(wiphy)(&rdev->wiphy);
+
 		reg_process_self_managed_hint(&rdev->wiphy);
-		wiphy_unlock(&rdev->wiphy);
 	}
 
 	reg_check_channels();
@@ -3600,14 +3598,12 @@ static bool is_wiphy_all_set_reg_flag(enum ieee80211_regulatory_flags flag)
 	struct wireless_dev *wdev;
 
 	for_each_rdev(rdev) {
-		wiphy_lock(&rdev->wiphy);
+		guard(wiphy)(&rdev->wiphy);
+
 		list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list) {
-			if (!(wdev->wiphy->regulatory_flags & flag)) {
-				wiphy_unlock(&rdev->wiphy);
+			if (!(wdev->wiphy->regulatory_flags & flag))
 				return false;
-			}
 		}
-		wiphy_unlock(&rdev->wiphy);
 	}
 
 	return true;
@@ -3883,19 +3879,18 @@ static int reg_set_rd_driver(const struct ieee80211_regdomain *rd,
 
 	if (!driver_request->intersect) {
 		ASSERT_RTNL();
-		wiphy_lock(request_wiphy);
-		if (request_wiphy->regd)
-			tmp = get_wiphy_regdom(request_wiphy);
+		scoped_guard(wiphy, request_wiphy) {
+			if (request_wiphy->regd)
+				tmp = get_wiphy_regdom(request_wiphy);
 
-		regd = reg_copy_regd(rd);
-		if (IS_ERR(regd)) {
-			wiphy_unlock(request_wiphy);
-			return PTR_ERR(regd);
+			regd = reg_copy_regd(rd);
+			if (IS_ERR(regd))
+				return PTR_ERR(regd);
+
+			rcu_assign_pointer(request_wiphy->regd, regd);
+			rcu_free_regdom(tmp);
 		}
 
-		rcu_assign_pointer(request_wiphy->regd, regd);
-		rcu_free_regdom(tmp);
-		wiphy_unlock(request_wiphy);
 		reset_regdomains(false, rd);
 		return 0;
 	}
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 1c6fd45aa809..d056248c43d2 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1238,7 +1238,8 @@ void cfg80211_sched_scan_results_wk(struct work_struct *work)
 	rdev = container_of(work, struct cfg80211_registered_device,
 			   sched_scan_res_wk);
 
-	wiphy_lock(&rdev->wiphy);
+	guard(wiphy)(&rdev->wiphy);
+
 	list_for_each_entry_safe(req, tmp, &rdev->sched_scan_req_list, list) {
 		if (req->report_results) {
 			req->report_results = false;
@@ -1253,7 +1254,6 @@ void cfg80211_sched_scan_results_wk(struct work_struct *work)
 						NL80211_CMD_SCHED_SCAN_RESULTS);
 		}
 	}
-	wiphy_unlock(&rdev->wiphy);
 }
 
 void cfg80211_sched_scan_results(struct wiphy *wiphy, u64 reqid)
@@ -1288,9 +1288,9 @@ EXPORT_SYMBOL(cfg80211_sched_scan_stopped_locked);
 
 void cfg80211_sched_scan_stopped(struct wiphy *wiphy, u64 reqid)
 {
-	wiphy_lock(wiphy);
+	guard(wiphy)(wiphy);
+
 	cfg80211_sched_scan_stopped_locked(wiphy, reqid);
-	wiphy_unlock(wiphy);
 }
 EXPORT_SYMBOL(cfg80211_sched_scan_stopped);
 
@@ -3565,10 +3565,8 @@ int cfg80211_wext_siwscan(struct net_device *dev,
 	/* translate "Scan for SSID" request */
 	if (wreq) {
 		if (wrqu->data.flags & IW_SCAN_THIS_ESSID) {
-			if (wreq->essid_len > IEEE80211_MAX_SSID_LEN) {
-				err = -EINVAL;
-				goto out;
-			}
+			if (wreq->essid_len > IEEE80211_MAX_SSID_LEN)
+				return -EINVAL;
 			memcpy(creq->ssids[0].ssid, wreq->essid, wreq->essid_len);
 			creq->ssids[0].ssid_len = wreq->essid_len;
 		}
@@ -3584,20 +3582,20 @@ int cfg80211_wext_siwscan(struct net_device *dev,
 
 	eth_broadcast_addr(creq->bssid);
 
-	wiphy_lock(&rdev->wiphy);
-
-	rdev->scan_req = creq;
-	err = rdev_scan(rdev, creq);
-	if (err) {
-		rdev->scan_req = NULL;
-		/* creq will be freed below */
-	} else {
-		nl80211_send_scan_start(rdev, dev->ieee80211_ptr);
-		/* creq now owned by driver */
-		creq = NULL;
-		dev_hold(dev);
+	scoped_guard(wiphy, &rdev->wiphy) {
+		rdev->scan_req = creq;
+		err = rdev_scan(rdev, creq);
+		if (err) {
+			rdev->scan_req = NULL;
+			/* creq will be freed below */
+		} else {
+			nl80211_send_scan_start(rdev, dev->ieee80211_ptr);
+			/* creq now owned by driver */
+			creq = NULL;
+			dev_hold(dev);
+		}
 	}
-	wiphy_unlock(&rdev->wiphy);
+
  out:
 	kfree(creq);
 	return err;
diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index 431da30817a6..7a734c8085af 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -251,7 +251,7 @@ void cfg80211_conn_work(struct work_struct *work)
 	u8 bssid_buf[ETH_ALEN], *bssid = NULL;
 	enum nl80211_timeout_reason treason;
 
-	wiphy_lock(&rdev->wiphy);
+	guard(wiphy)(&rdev->wiphy);
 
 	list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list) {
 		if (!wdev->netdev)
@@ -279,8 +279,6 @@ void cfg80211_conn_work(struct work_struct *work)
 			__cfg80211_connect_result(wdev->netdev, &cr, false);
 		}
 	}
-
-	wiphy_unlock(&rdev->wiphy);
 }
 
 static void cfg80211_step_auth_next(struct cfg80211_conn *conn,
@@ -692,13 +690,13 @@ static bool cfg80211_is_all_idle(void)
 	 * as chan dfs state, etc.
 	 */
 	for_each_rdev(rdev) {
-		wiphy_lock(&rdev->wiphy);
+		guard(wiphy)(&rdev->wiphy);
+
 		list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list) {
 			if (wdev->conn || wdev->connected ||
 			    cfg80211_beaconing_iface_active(wdev))
 				is_all_idle = false;
 		}
-		wiphy_unlock(&rdev->wiphy);
 	}
 
 	return is_all_idle;
@@ -1582,7 +1580,7 @@ void cfg80211_autodisconnect_wk(struct work_struct *work)
 		container_of(work, struct wireless_dev, disconnect_wk);
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
 
-	wiphy_lock(wdev->wiphy);
+	guard(wiphy)(wdev->wiphy);
 
 	if (wdev->conn_owner_nlportid) {
 		switch (wdev->iftype) {
@@ -1618,6 +1616,4 @@ void cfg80211_autodisconnect_wk(struct work_struct *work)
 			break;
 		}
 	}
-
-	wiphy_unlock(wdev->wiphy);
 }
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 040d62051eb9..c7c6261c9146 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -2572,7 +2572,6 @@ int cfg80211_get_station(struct net_device *dev, const u8 *mac_addr,
 {
 	struct cfg80211_registered_device *rdev;
 	struct wireless_dev *wdev;
-	int ret;
 
 	wdev = dev->ieee80211_ptr;
 	if (!wdev)
@@ -2584,11 +2583,9 @@ int cfg80211_get_station(struct net_device *dev, const u8 *mac_addr,
 
 	memset(sinfo, 0, sizeof(*sinfo));
 
-	wiphy_lock(&rdev->wiphy);
-	ret = rdev_get_station(rdev, dev, mac_addr, sinfo);
-	wiphy_unlock(&rdev->wiphy);
+	guard(wiphy)(&rdev->wiphy);
 
-	return ret;
+	return rdev_get_station(rdev, dev, mac_addr, sinfo);
 }
 EXPORT_SYMBOL(cfg80211_get_station);
 
diff --git a/net/wireless/wext-compat.c b/net/wireless/wext-compat.c
index 90d5c0592667..687f93664d1f 100644
--- a/net/wireless/wext-compat.c
+++ b/net/wireless/wext-compat.c
@@ -39,7 +39,6 @@ int cfg80211_wext_siwmode(struct net_device *dev, struct iw_request_info *info,
 	struct cfg80211_registered_device *rdev;
 	struct vif_params vifparams;
 	enum nl80211_iftype type;
-	int ret;
 
 	rdev = wiphy_to_rdev(wdev->wiphy);
 
@@ -62,11 +61,9 @@ int cfg80211_wext_siwmode(struct net_device *dev, struct iw_request_info *info,
 
 	memset(&vifparams, 0, sizeof(vifparams));
 
-	wiphy_lock(wdev->wiphy);
-	ret = cfg80211_change_iface(rdev, dev, type, &vifparams);
-	wiphy_unlock(wdev->wiphy);
+	guard(wiphy)(wdev->wiphy);
 
-	return ret;
+	return cfg80211_change_iface(rdev, dev, type, &vifparams);
 }
 
 int cfg80211_wext_giwmode(struct net_device *dev, struct iw_request_info *info,
@@ -258,23 +255,17 @@ int cfg80211_wext_siwrts(struct net_device *dev,
 	u32 orts = wdev->wiphy->rts_threshold;
 	int err;
 
-	wiphy_lock(&rdev->wiphy);
-	if (rts->disabled || !rts->fixed) {
+	guard(wiphy)(&rdev->wiphy);
+	if (rts->disabled || !rts->fixed)
 		wdev->wiphy->rts_threshold = (u32) -1;
-	} else if (rts->value < 0) {
-		err = -EINVAL;
-		goto out;
-	} else {
+	else if (rts->value < 0)
+		return -EINVAL;
+	else
 		wdev->wiphy->rts_threshold = rts->value;
-	}
 
 	err = rdev_set_wiphy_params(rdev, WIPHY_PARAM_RTS_THRESHOLD);
-
 	if (err)
 		wdev->wiphy->rts_threshold = orts;
-
-out:
-	wiphy_unlock(&rdev->wiphy);
 	return err;
 }
 
@@ -302,12 +293,12 @@ int cfg80211_wext_siwfrag(struct net_device *dev,
 	u32 ofrag = wdev->wiphy->frag_threshold;
 	int err;
 
-	wiphy_lock(&rdev->wiphy);
+	guard(wiphy)(&rdev->wiphy);
+
 	if (frag->disabled || !frag->fixed) {
 		wdev->wiphy->frag_threshold = (u32) -1;
 	} else if (frag->value < 256) {
-		err = -EINVAL;
-		goto out;
+		return -EINVAL;
 	} else {
 		/* Fragment length must be even, so strip LSB. */
 		wdev->wiphy->frag_threshold = frag->value & ~0x1;
@@ -316,9 +307,6 @@ int cfg80211_wext_siwfrag(struct net_device *dev,
 	err = rdev_set_wiphy_params(rdev, WIPHY_PARAM_FRAG_THRESHOLD);
 	if (err)
 		wdev->wiphy->frag_threshold = ofrag;
-out:
-	wiphy_unlock(&rdev->wiphy);
-
 	return err;
 }
 
@@ -352,7 +340,8 @@ static int cfg80211_wext_siwretry(struct net_device *dev,
 	    (retry->flags & IW_RETRY_TYPE) != IW_RETRY_LIMIT)
 		return -EINVAL;
 
-	wiphy_lock(&rdev->wiphy);
+	guard(wiphy)(&rdev->wiphy);
+
 	if (retry->flags & IW_RETRY_LONG) {
 		wdev->wiphy->retry_long = retry->value;
 		changed |= WIPHY_PARAM_RETRY_LONG;
@@ -371,7 +360,6 @@ static int cfg80211_wext_siwretry(struct net_device *dev,
 		wdev->wiphy->retry_short = oshort;
 		wdev->wiphy->retry_long = olong;
 	}
-	wiphy_unlock(&rdev->wiphy);
 
 	return err;
 }
@@ -578,9 +566,9 @@ static int cfg80211_wext_siwencode(struct net_device *dev,
 	struct iw_point *erq = &wrqu->encoding;
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
-	int idx, err;
-	bool remove = false;
 	struct key_params params;
+	bool remove = false;
+	int idx;
 
 	if (wdev->iftype != NL80211_IFTYPE_STATION &&
 	    wdev->iftype != NL80211_IFTYPE_ADHOC)
@@ -592,11 +580,9 @@ static int cfg80211_wext_siwencode(struct net_device *dev,
 	    !rdev->ops->set_default_key)
 		return -EOPNOTSUPP;
 
-	wiphy_lock(&rdev->wiphy);
-	if (wdev->valid_links) {
-		err = -EOPNOTSUPP;
-		goto out;
-	}
+	guard(wiphy)(&rdev->wiphy);
+	if (wdev->valid_links)
+		return -EOPNOTSUPP;
 
 	idx = erq->flags & IW_ENCODE_INDEX;
 	if (idx == 0) {
@@ -604,8 +590,7 @@ static int cfg80211_wext_siwencode(struct net_device *dev,
 		if (idx < 0)
 			idx = 0;
 	} else if (idx < 1 || idx > 4) {
-		err = -EINVAL;
-		goto out;
+		return -EINVAL;
 	} else {
 		idx--;
 	}
@@ -614,7 +599,8 @@ static int cfg80211_wext_siwencode(struct net_device *dev,
 		remove = true;
 	else if (erq->length == 0) {
 		/* No key data - just set the default TX key index */
-		err = 0;
+		int err = 0;
+
 		if (wdev->connected ||
 		    (wdev->iftype == NL80211_IFTYPE_ADHOC &&
 		     wdev->u.ibss.current_bss))
@@ -622,28 +608,22 @@ static int cfg80211_wext_siwencode(struct net_device *dev,
 						   true);
 		if (!err)
 			wdev->wext.default_key = idx;
-		goto out;
+		return err;
 	}
 
 	memset(&params, 0, sizeof(params));
 	params.key = keybuf;
 	params.key_len = erq->length;
-	if (erq->length == 5) {
+	if (erq->length == 5)
 		params.cipher = WLAN_CIPHER_SUITE_WEP40;
-	} else if (erq->length == 13) {
+	else if (erq->length == 13)
 		params.cipher = WLAN_CIPHER_SUITE_WEP104;
-	} else if (!remove) {
-		err = -EINVAL;
-		goto out;
-	}
+	else if (!remove)
+		return -EINVAL;
 
-	err = cfg80211_set_encryption(rdev, dev, false, NULL, remove,
-				      wdev->wext.default_key == -1,
-				      idx, &params);
-out:
-	wiphy_unlock(&rdev->wiphy);
-
-	return err;
+	return cfg80211_set_encryption(rdev, dev, false, NULL, remove,
+				       wdev->wext.default_key == -1,
+				       idx, &params);
 }
 
 static int cfg80211_wext_siwencodeext(struct net_device *dev,
@@ -659,7 +639,6 @@ static int cfg80211_wext_siwencodeext(struct net_device *dev,
 	bool remove = false;
 	struct key_params params;
 	u32 cipher;
-	int ret;
 
 	if (wdev->iftype != NL80211_IFTYPE_STATION &&
 	    wdev->iftype != NL80211_IFTYPE_ADHOC)
@@ -734,16 +713,13 @@ static int cfg80211_wext_siwencodeext(struct net_device *dev,
 		params.seq_len = 6;
 	}
 
-	wiphy_lock(wdev->wiphy);
-	ret = cfg80211_set_encryption(
-			rdev, dev,
-			!(ext->ext_flags & IW_ENCODE_EXT_GROUP_KEY),
-			addr, remove,
-			ext->ext_flags & IW_ENCODE_EXT_SET_TX_KEY,
-			idx, &params);
-	wiphy_unlock(wdev->wiphy);
+	guard(wiphy)(wdev->wiphy);
 
-	return ret;
+	return cfg80211_set_encryption(rdev, dev,
+				       !(ext->ext_flags & IW_ENCODE_EXT_GROUP_KEY),
+				       addr, remove,
+				       ext->ext_flags & IW_ENCODE_EXT_SET_TX_KEY,
+				       idx, &params);
 }
 
 static int cfg80211_wext_giwencode(struct net_device *dev,
@@ -794,61 +770,41 @@ static int cfg80211_wext_siwfreq(struct net_device *dev,
 	struct cfg80211_chan_def chandef = {
 		.width = NL80211_CHAN_WIDTH_20_NOHT,
 	};
-	int freq, ret;
+	int freq;
 
-	wiphy_lock(&rdev->wiphy);
+	guard(wiphy)(&rdev->wiphy);
 
 	switch (wdev->iftype) {
 	case NL80211_IFTYPE_STATION:
-		ret = cfg80211_mgd_wext_siwfreq(dev, info, wextfreq, extra);
-		break;
+		return cfg80211_mgd_wext_siwfreq(dev, info, wextfreq, extra);
 	case NL80211_IFTYPE_ADHOC:
-		ret = cfg80211_ibss_wext_siwfreq(dev, info, wextfreq, extra);
-		break;
+		return cfg80211_ibss_wext_siwfreq(dev, info, wextfreq, extra);
 	case NL80211_IFTYPE_MONITOR:
 		freq = cfg80211_wext_freq(wextfreq);
-		if (freq < 0) {
-			ret = freq;
-			break;
-		}
-		if (freq == 0) {
-			ret = -EINVAL;
-			break;
-		}
+		if (freq < 0)
+			return freq;
+		if (freq == 0)
+			return -EINVAL;
+
 		chandef.center_freq1 = freq;
 		chandef.chan = ieee80211_get_channel(&rdev->wiphy, freq);
-		if (!chandef.chan) {
-			ret = -EINVAL;
-			break;
-		}
-		ret = cfg80211_set_monitor_channel(rdev, dev, &chandef);
-		break;
+		if (!chandef.chan)
+			return -EINVAL;
+		return cfg80211_set_monitor_channel(rdev, dev, &chandef);
 	case NL80211_IFTYPE_MESH_POINT:
 		freq = cfg80211_wext_freq(wextfreq);
-		if (freq < 0) {
-			ret = freq;
-			break;
-		}
-		if (freq == 0) {
-			ret = -EINVAL;
-			break;
-		}
+		if (freq < 0)
+			return freq;
+		if (freq == 0)
+			return -EINVAL;
 		chandef.center_freq1 = freq;
 		chandef.chan = ieee80211_get_channel(&rdev->wiphy, freq);
-		if (!chandef.chan) {
-			ret = -EINVAL;
-			break;
-		}
-		ret = cfg80211_set_mesh_channel(rdev, wdev, &chandef);
-		break;
+		if (!chandef.chan)
+			return -EINVAL;
+		return cfg80211_set_mesh_channel(rdev, wdev, &chandef);
 	default:
-		ret = -EOPNOTSUPP;
-		break;
+		return -EOPNOTSUPP;
 	}
-
-	wiphy_unlock(&rdev->wiphy);
-
-	return ret;
 }
 
 static int cfg80211_wext_giwfreq(struct net_device *dev,
@@ -861,35 +817,26 @@ static int cfg80211_wext_giwfreq(struct net_device *dev,
 	struct cfg80211_chan_def chandef = {};
 	int ret;
 
-	wiphy_lock(&rdev->wiphy);
+	guard(wiphy)(&rdev->wiphy);
+
 	switch (wdev->iftype) {
 	case NL80211_IFTYPE_STATION:
-		ret = cfg80211_mgd_wext_giwfreq(dev, info, freq, extra);
-		break;
+		return cfg80211_mgd_wext_giwfreq(dev, info, freq, extra);
 	case NL80211_IFTYPE_ADHOC:
-		ret = cfg80211_ibss_wext_giwfreq(dev, info, freq, extra);
-		break;
+		return cfg80211_ibss_wext_giwfreq(dev, info, freq, extra);
 	case NL80211_IFTYPE_MONITOR:
-		if (!rdev->ops->get_channel) {
-			ret = -EINVAL;
-			break;
-		}
+		if (!rdev->ops->get_channel)
+			return -EINVAL;
 
 		ret = rdev_get_channel(rdev, wdev, 0, &chandef);
 		if (ret)
-			break;
+			return ret;
 		freq->m = chandef.chan->center_freq;
 		freq->e = 6;
-		ret = 0;
-		break;
+		return ret;
 	default:
-		ret = -EINVAL;
-		break;
+		return -EINVAL;
 	}
-
-	wiphy_unlock(&rdev->wiphy);
-
-	return ret;
 }
 
 static int cfg80211_wext_siwtxpower(struct net_device *dev,
@@ -900,7 +847,6 @@ static int cfg80211_wext_siwtxpower(struct net_device *dev,
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
 	enum nl80211_tx_power_setting type;
 	int dbm = 0;
-	int ret;
 
 	if ((data->txpower.flags & IW_TXPOW_TYPE) != IW_TXPOW_DBM)
 		return -EINVAL;
@@ -942,11 +888,9 @@ static int cfg80211_wext_siwtxpower(struct net_device *dev,
 		return 0;
 	}
 
-	wiphy_lock(&rdev->wiphy);
-	ret = rdev_set_tx_power(rdev, wdev, type, DBM_TO_MBM(dbm));
-	wiphy_unlock(&rdev->wiphy);
+	guard(wiphy)(&rdev->wiphy);
 
-	return ret;
+	return rdev_set_tx_power(rdev, wdev, type, DBM_TO_MBM(dbm));
 }
 
 static int cfg80211_wext_giwtxpower(struct net_device *dev,
@@ -965,9 +909,9 @@ static int cfg80211_wext_giwtxpower(struct net_device *dev,
 	if (!rdev->ops->get_tx_power)
 		return -EOPNOTSUPP;
 
-	wiphy_lock(&rdev->wiphy);
-	err = rdev_get_tx_power(rdev, wdev, &val);
-	wiphy_unlock(&rdev->wiphy);
+	scoped_guard(wiphy, &rdev->wiphy) {
+		err = rdev_get_tx_power(rdev, wdev, &val);
+	}
 	if (err)
 		return err;
 
@@ -1209,9 +1153,9 @@ static int cfg80211_wext_siwpower(struct net_device *dev,
 			timeout = wrq->value / 1000;
 	}
 
-	wiphy_lock(&rdev->wiphy);
+	guard(wiphy)(&rdev->wiphy);
+
 	err = rdev_set_power_mgmt(rdev, dev, ps, timeout);
-	wiphy_unlock(&rdev->wiphy);
 	if (err)
 		return err;
 
@@ -1244,8 +1188,8 @@ static int cfg80211_wext_siwrate(struct net_device *dev,
 	struct cfg80211_bitrate_mask mask;
 	u32 fixed, maxrate;
 	struct ieee80211_supported_band *sband;
-	int band, ridx, ret;
 	bool match = false;
+	int band, ridx;
 
 	if (!rdev->ops->set_bitrate_mask)
 		return -EOPNOTSUPP;
@@ -1283,14 +1227,12 @@ static int cfg80211_wext_siwrate(struct net_device *dev,
 	if (!match)
 		return -EINVAL;
 
-	wiphy_lock(&rdev->wiphy);
-	if (dev->ieee80211_ptr->valid_links)
-		ret = -EOPNOTSUPP;
-	else
-		ret = rdev_set_bitrate_mask(rdev, dev, 0, NULL, &mask);
-	wiphy_unlock(&rdev->wiphy);
+	guard(wiphy)(&rdev->wiphy);
 
-	return ret;
+	if (dev->ieee80211_ptr->valid_links)
+		return -EOPNOTSUPP;
+	
+	return rdev_set_bitrate_mask(rdev, dev, 0, NULL, &mask);
 }
 
 static int cfg80211_wext_giwrate(struct net_device *dev,
@@ -1319,9 +1261,9 @@ static int cfg80211_wext_giwrate(struct net_device *dev,
 	if (err)
 		return err;
 
-	wiphy_lock(&rdev->wiphy);
-	err = rdev_get_station(rdev, dev, addr, &sinfo);
-	wiphy_unlock(&rdev->wiphy);
+	scoped_guard(wiphy, &rdev->wiphy) {
+		err = rdev_get_station(rdev, dev, addr, &sinfo);
+	}
 	if (err)
 		return err;
 
@@ -1420,23 +1362,17 @@ static int cfg80211_wext_siwap(struct net_device *dev,
 	struct sockaddr *ap_addr = &wrqu->ap_addr;
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
-	int ret;
 
-	wiphy_lock(&rdev->wiphy);
+	guard(wiphy)(&rdev->wiphy);
+
 	switch (wdev->iftype) {
 	case NL80211_IFTYPE_ADHOC:
-		ret = cfg80211_ibss_wext_siwap(dev, info, ap_addr, extra);
-		break;
+		return cfg80211_ibss_wext_siwap(dev, info, ap_addr, extra);
 	case NL80211_IFTYPE_STATION:
-		ret = cfg80211_mgd_wext_siwap(dev, info, ap_addr, extra);
-		break;
+		return cfg80211_mgd_wext_siwap(dev, info, ap_addr, extra);
 	default:
-		ret = -EOPNOTSUPP;
-		break;
+		return -EOPNOTSUPP;
 	}
-	wiphy_unlock(&rdev->wiphy);
-
-	return ret;
 }
 
 static int cfg80211_wext_giwap(struct net_device *dev,
@@ -1446,23 +1382,17 @@ static int cfg80211_wext_giwap(struct net_device *dev,
 	struct sockaddr *ap_addr = &wrqu->ap_addr;
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
-	int ret;
 
-	wiphy_lock(&rdev->wiphy);
+	guard(wiphy)(&rdev->wiphy);
+
 	switch (wdev->iftype) {
 	case NL80211_IFTYPE_ADHOC:
-		ret = cfg80211_ibss_wext_giwap(dev, info, ap_addr, extra);
-		break;
+		return cfg80211_ibss_wext_giwap(dev, info, ap_addr, extra);
 	case NL80211_IFTYPE_STATION:
-		ret = cfg80211_mgd_wext_giwap(dev, info, ap_addr, extra);
-		break;
+		return cfg80211_mgd_wext_giwap(dev, info, ap_addr, extra);
 	default:
-		ret = -EOPNOTSUPP;
-		break;
+		return -EOPNOTSUPP;
 	}
-	wiphy_unlock(&rdev->wiphy);
-
-	return ret;
 }
 
 static int cfg80211_wext_siwessid(struct net_device *dev,
@@ -1472,23 +1402,17 @@ static int cfg80211_wext_siwessid(struct net_device *dev,
 	struct iw_point *data = &wrqu->data;
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
-	int ret;
 
-	wiphy_lock(&rdev->wiphy);
+	guard(wiphy)(&rdev->wiphy);
+
 	switch (wdev->iftype) {
 	case NL80211_IFTYPE_ADHOC:
-		ret = cfg80211_ibss_wext_siwessid(dev, info, data, ssid);
-		break;
+		return cfg80211_ibss_wext_siwessid(dev, info, data, ssid);
 	case NL80211_IFTYPE_STATION:
-		ret = cfg80211_mgd_wext_siwessid(dev, info, data, ssid);
-		break;
+		return cfg80211_mgd_wext_siwessid(dev, info, data, ssid);
 	default:
-		ret = -EOPNOTSUPP;
-		break;
+		return -EOPNOTSUPP;
 	}
-	wiphy_unlock(&rdev->wiphy);
-
-	return ret;
 }
 
 static int cfg80211_wext_giwessid(struct net_device *dev,
@@ -1498,26 +1422,20 @@ static int cfg80211_wext_giwessid(struct net_device *dev,
 	struct iw_point *data = &wrqu->data;
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
-	int ret;
 
 	data->flags = 0;
 	data->length = 0;
 
-	wiphy_lock(&rdev->wiphy);
+	guard(wiphy)(&rdev->wiphy);
+
 	switch (wdev->iftype) {
 	case NL80211_IFTYPE_ADHOC:
-		ret = cfg80211_ibss_wext_giwessid(dev, info, data, ssid);
-		break;
+		return cfg80211_ibss_wext_giwessid(dev, info, data, ssid);
 	case NL80211_IFTYPE_STATION:
-		ret = cfg80211_mgd_wext_giwessid(dev, info, data, ssid);
-		break;
+		return cfg80211_mgd_wext_giwessid(dev, info, data, ssid);
 	default:
-		ret = -EOPNOTSUPP;
-		break;
+		return -EOPNOTSUPP;
 	}
-	wiphy_unlock(&rdev->wiphy);
-
-	return ret;
 }
 
 static int cfg80211_wext_siwpmksa(struct net_device *dev,
@@ -1528,7 +1446,6 @@ static int cfg80211_wext_siwpmksa(struct net_device *dev,
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
 	struct cfg80211_pmksa cfg_pmksa;
 	struct iw_pmksa *pmksa = (struct iw_pmksa *)extra;
-	int ret;
 
 	memset(&cfg_pmksa, 0, sizeof(struct cfg80211_pmksa));
 
@@ -1538,39 +1455,27 @@ static int cfg80211_wext_siwpmksa(struct net_device *dev,
 	cfg_pmksa.bssid = pmksa->bssid.sa_data;
 	cfg_pmksa.pmkid = pmksa->pmkid;
 
-	wiphy_lock(&rdev->wiphy);
+	guard(wiphy)(&rdev->wiphy);
+
 	switch (pmksa->cmd) {
 	case IW_PMKSA_ADD:
-		if (!rdev->ops->set_pmksa) {
-			ret = -EOPNOTSUPP;
-			break;
-		}
+		if (!rdev->ops->set_pmksa)
+			return -EOPNOTSUPP;
 
-		ret = rdev_set_pmksa(rdev, dev, &cfg_pmksa);
-		break;
+		return rdev_set_pmksa(rdev, dev, &cfg_pmksa);
 	case IW_PMKSA_REMOVE:
-		if (!rdev->ops->del_pmksa) {
-			ret = -EOPNOTSUPP;
-			break;
-		}
+		if (!rdev->ops->del_pmksa)
+			return -EOPNOTSUPP;
 
-		ret = rdev_del_pmksa(rdev, dev, &cfg_pmksa);
-		break;
+		return rdev_del_pmksa(rdev, dev, &cfg_pmksa);
 	case IW_PMKSA_FLUSH:
-		if (!rdev->ops->flush_pmksa) {
-			ret = -EOPNOTSUPP;
-			break;
-		}
+		if (!rdev->ops->flush_pmksa)
+			return -EOPNOTSUPP;
 
-		ret = rdev_flush_pmksa(rdev, dev);
-		break;
+		return rdev_flush_pmksa(rdev, dev);
 	default:
-		ret = -EOPNOTSUPP;
-		break;
+		return -EOPNOTSUPP;
 	}
-	wiphy_unlock(&rdev->wiphy);
-
-	return ret;
 }
 
 static const iw_handler cfg80211_handlers[] = {
diff --git a/net/wireless/wext-sme.c b/net/wireless/wext-sme.c
index 8edd9ada69d0..573b6b15a446 100644
--- a/net/wireless/wext-sme.c
+++ b/net/wireless/wext-sme.c
@@ -302,8 +302,8 @@ int cfg80211_wext_siwgenie(struct net_device *dev,
 	struct iw_point *data = &wrqu->data;
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
+	int ie_len = data->length;
 	u8 *ie = extra;
-	int ie_len = data->length, err;
 
 	if (wdev->iftype != NL80211_IFTYPE_STATION)
 		return -EOPNOTSUPP;
@@ -311,39 +311,31 @@ int cfg80211_wext_siwgenie(struct net_device *dev,
 	if (!ie_len)
 		ie = NULL;
 
-	wiphy_lock(wdev->wiphy);
+	guard(wiphy)(wdev->wiphy);
 
 	/* no change */
-	err = 0;
 	if (wdev->wext.ie_len == ie_len &&
 	    memcmp(wdev->wext.ie, ie, ie_len) == 0)
-		goto out;
+		return 0;
 
 	if (ie_len) {
 		ie = kmemdup(extra, ie_len, GFP_KERNEL);
-		if (!ie) {
-			err = -ENOMEM;
-			goto out;
-		}
-	} else
+		if (!ie)
+			return -ENOMEM;
+	} else {
 		ie = NULL;
+	}
 
 	kfree(wdev->wext.ie);
 	wdev->wext.ie = ie;
 	wdev->wext.ie_len = ie_len;
 
-	if (wdev->conn) {
-		err = cfg80211_disconnect(rdev, dev,
-					  WLAN_REASON_DEAUTH_LEAVING, false);
-		if (err)
-			goto out;
-	}
+	if (wdev->conn)
+		return cfg80211_disconnect(rdev, dev,
+					   WLAN_REASON_DEAUTH_LEAVING, false);
 
 	/* userspace better not think we'll reconnect */
-	err = 0;
- out:
-	wiphy_unlock(wdev->wiphy);
-	return err;
+	return 0;
 }
 
 int cfg80211_wext_siwmlme(struct net_device *dev,
@@ -353,7 +345,6 @@ int cfg80211_wext_siwmlme(struct net_device *dev,
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct iw_mlme *mlme = (struct iw_mlme *)extra;
 	struct cfg80211_registered_device *rdev;
-	int err;
 
 	if (!wdev)
 		return -EOPNOTSUPP;
@@ -366,17 +357,13 @@ int cfg80211_wext_siwmlme(struct net_device *dev,
 	if (mlme->addr.sa_family != ARPHRD_ETHER)
 		return -EINVAL;
 
-	wiphy_lock(&rdev->wiphy);
+	guard(wiphy)(&rdev->wiphy);
+
 	switch (mlme->cmd) {
 	case IW_MLME_DEAUTH:
 	case IW_MLME_DISASSOC:
-		err = cfg80211_disconnect(rdev, dev, mlme->reason_code, true);
-		break;
+		return cfg80211_disconnect(rdev, dev, mlme->reason_code, true);
 	default:
-		err = -EOPNOTSUPP;
-		break;
+		return -EOPNOTSUPP;
 	}
-	wiphy_unlock(&rdev->wiphy);
-
-	return err;
 }
-- 
2.47.0


