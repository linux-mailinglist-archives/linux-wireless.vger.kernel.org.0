Return-Path: <linux-wireless+bounces-8003-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C458CD009
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 12:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCC141C223F6
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 10:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E454514198A;
	Thu, 23 May 2024 10:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="VtoMAU/A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBFD1448C9
	for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 10:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716458998; cv=none; b=qP06Wx5MSJZYbk4DKKTKSoHF+ZoINgEAqkY6ZWeBpP3WS45apLxII9NiJKWaMCEMI9ZEEXjpELEGWIo/pNqAGsTQHpfPUDDZWAx0QUzpIa6iG+1ytBZBYC5fzkZU8qjwyafEwS5+HH39TjYEDbc+cIoA87y/lNaY0617wpeIqjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716458998; c=relaxed/simple;
	bh=Yojg4/2cJQEBnbv9rkl+mbZjO9zQsAnc1vOIYxpTOms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UEXskcBU58f4Ad20D2toxk9U6Qx1prXT6Itk60NV+lSWUOoa5qyqpQA5ZOVkm0J+JEakgQh9d9Ir805FTtLjIuxUUAZ0bNTpze1aP68zh+TOzWeCnq1bomhkMowjL57vLkGtSu9okFBprTDDfKOaNP0p+8tDlkcnNDdLaZDJ/R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=VtoMAU/A; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=pq1fukTBRBTSwtAr5BfNsLQfWEwt/a6s3UqV1nrYpr4=;
	t=1716458997; x=1717668597; b=VtoMAU/AZY/z0vPSf0LAZzPqTkHfy6EXYT68+A9auHMXzuL
	URMUbw0M+eQf2SDUk5cKxURn3/H7RMOdsn3hH/J3TA+0pVe8YjBuQqwfcxqV73AsEeOhXwwp9pu0p
	nMdYwWMT+RY0Y/OT10/h5Bihoau5HZ0em7FHC6VK2NGrS5pg1eUE950PutBRN8EhwwNH/Z1y1aY1j
	2JI7Emog/vYSrTx3gX2XhADW0Xwjg8iflXkPLeaD+8ZAx6P+HqOehw8hAyv684vK7ev99a4+aM/Zn
	9JDL7kDMDs1duO83wR7frz/jW2H8jmA/gW74jDNrCkPGcHNQ6Dzqwxyayr7e2Q3A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sA5OU-00000005wvn-1jUc;
	Thu, 23 May 2024 12:09:54 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 8/8] wifi: cfg80211: add regulatory flag to allow VLP AP operation
Date: Thu, 23 May 2024 12:09:49 +0200
Message-ID: <20240523120945.63792ce19790.Ie2a02750d283b78fbf3c686b10565fb0388889e2@changeid>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523120945.9a2c19a51e53.I50fa1b1a18b70f63a5095131ac23dc2e71f3d426@changeid>
References: <20240523120945.9a2c19a51e53.I50fa1b1a18b70f63a5095131ac23dc2e71f3d426@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Add a regulatory flag to allow VLP AP operation even on
channels otherwise marked NO_IR, which may be possible
in some regulatory domains/countries.

Note that this requires checking also when the beacon is
changed, since that may change the regulatory power type.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h       |  6 ++++++
 include/uapi/linux/nl80211.h |  6 ++++++
 net/wireless/chan.c          | 37 +++++++++++++++++++++++++-----------
 net/wireless/nl80211.c       | 27 ++++++++++++++++++++++++--
 net/wireless/reg.c           |  2 ++
 net/wireless/trace.h         | 15 +++++++++------
 6 files changed, 74 insertions(+), 19 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index dcb543344db6..3ae615e4cf20 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -125,6 +125,8 @@ struct wiphy;
  * @IEEE80211_CHAN_CAN_MONITOR: This channel can be used for monitor
  *	mode even in the presence of other (regulatory) restrictions,
  *	even if it is otherwise disabled.
+ * @IEEE80211_CHAN_ALLOW_6GHZ_VLP_AP: Allow using this channel for AP operation
+ *	with very low power (VLP), even if otherwise set to NO_IR.
  */
 enum ieee80211_channel_flags {
 	IEEE80211_CHAN_DISABLED			= BIT(0),
@@ -152,6 +154,7 @@ enum ieee80211_channel_flags {
 	IEEE80211_CHAN_NO_6GHZ_VLP_CLIENT	= BIT(22),
 	IEEE80211_CHAN_NO_6GHZ_AFC_CLIENT	= BIT(23),
 	IEEE80211_CHAN_CAN_MONITOR		= BIT(24),
+	IEEE80211_CHAN_ALLOW_6GHZ_VLP_AP	= BIT(25),
 };
 
 #define IEEE80211_CHAN_NO_HT40 \
@@ -8806,9 +8809,12 @@ static inline void cfg80211_report_obss_beacon(struct wiphy *wiphy,
  * @relax: allow IR-relaxation conditions to apply (e.g. another
  *	interface connected already on the same channel)
  *	NOTE: If this is set, wiphy mutex must be held.
+ * @reg_power: &enum ieee80211_ap_reg_power value indicating the
+ *	advertised/used 6 GHz regulatory power setting
  */
 struct cfg80211_beaconing_check_config {
 	enum nl80211_iftype iftype;
+	enum ieee80211_ap_reg_power reg_power;
 	bool relax;
 };
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index f917bc6c9b6f..6ae3997061b6 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4277,6 +4277,8 @@ enum nl80211_wmm_rule {
  * @NL80211_FREQUENCY_ATTR_CAN_MONITOR: This channel can be used in monitor
  *	mode despite other (regulatory) restrictions, even if the channel is
  *	otherwise completely disabled.
+ * @NL80211_FREQUENCY_ATTR_ALLOW_6GHZ_VLP_AP: This channel can be used for a
+ *	very low power (VLP) AP, despite being NO_IR.
  * @NL80211_FREQUENCY_ATTR_MAX: highest frequency attribute number
  *	currently defined
  * @__NL80211_FREQUENCY_ATTR_AFTER_LAST: internal use
@@ -4320,6 +4322,7 @@ enum nl80211_frequency_attr {
 	NL80211_FREQUENCY_ATTR_NO_6GHZ_VLP_CLIENT,
 	NL80211_FREQUENCY_ATTR_NO_6GHZ_AFC_CLIENT,
 	NL80211_FREQUENCY_ATTR_CAN_MONITOR,
+	NL80211_FREQUENCY_ATTR_ALLOW_6GHZ_VLP_AP,
 
 	/* keep last */
 	__NL80211_FREQUENCY_ATTR_AFTER_LAST,
@@ -4529,6 +4532,8 @@ enum nl80211_sched_scan_match_attr {
  *	Should be used together with %NL80211_RRF_DFS only.
  * @NL80211_RRF_NO_6GHZ_VLP_CLIENT: Client connection to VLP AP not allowed
  * @NL80211_RRF_NO_6GHZ_AFC_CLIENT: Client connection to AFC AP not allowed
+ * @NL80211_RRF_ALLOW_6GHZ_VLP_AP: Very low power (VLP) AP can be permitted
+ *	despite NO_IR configuration.
  */
 enum nl80211_reg_rule_flags {
 	NL80211_RRF_NO_OFDM		= 1<<0,
@@ -4553,6 +4558,7 @@ enum nl80211_reg_rule_flags {
 	NL80211_RRF_DFS_CONCURRENT	= 1<<21,
 	NL80211_RRF_NO_6GHZ_VLP_CLIENT	= 1<<22,
 	NL80211_RRF_NO_6GHZ_AFC_CLIENT	= 1<<23,
+	NL80211_RRF_ALLOW_6GHZ_VLP_AP	= 1<<24,
 };
 
 #define NL80211_RRF_PASSIVE_SCAN	NL80211_RRF_NO_IR
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 8b1796130b28..bf2fdcd42019 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -1523,28 +1523,38 @@ static bool cfg80211_ir_permissive_chan(struct wiphy *wiphy,
 static bool _cfg80211_reg_can_beacon(struct wiphy *wiphy,
 				     struct cfg80211_chan_def *chandef,
 				     enum nl80211_iftype iftype,
-				     bool check_no_ir)
+				     u32 prohibited_flags,
+				     u32 permitting_flags)
 {
-	bool res;
-	u32 prohibited_flags = IEEE80211_CHAN_DISABLED;
+	bool res, check_radar;
 	int dfs_required;
 
-	trace_cfg80211_reg_can_beacon(wiphy, chandef, iftype, check_no_ir);
+	trace_cfg80211_reg_can_beacon(wiphy, chandef, iftype,
+				      prohibited_flags,
+				      permitting_flags);
 
-	if (check_no_ir)
-		prohibited_flags |= IEEE80211_CHAN_NO_IR;
+	if (!_cfg80211_chandef_usable(wiphy, chandef,
+				      IEEE80211_CHAN_DISABLED, 0))
+		return false;
 
 	dfs_required = cfg80211_chandef_dfs_required(wiphy, chandef, iftype);
-	if (dfs_required != 0)
-		prohibited_flags |= IEEE80211_CHAN_RADAR;
+	check_radar = dfs_required != 0;
 
 	if (dfs_required > 0 &&
 	    cfg80211_chandef_dfs_available(wiphy, chandef)) {
 		/* We can skip IEEE80211_CHAN_NO_IR if chandef dfs available */
-		prohibited_flags = IEEE80211_CHAN_DISABLED;
+		prohibited_flags &= ~IEEE80211_CHAN_NO_IR;
+		check_radar = false;
 	}
 
-	res = _cfg80211_chandef_usable(wiphy, chandef, prohibited_flags, 0);
+	if (check_radar &&
+	    !_cfg80211_chandef_usable(wiphy, chandef,
+				      IEEE80211_CHAN_RADAR, 0))
+		return false;
+
+	res = _cfg80211_chandef_usable(wiphy, chandef,
+				       prohibited_flags,
+				       permitting_flags);
 
 	trace_cfg80211_return_bool(res);
 	return res;
@@ -1555,6 +1565,7 @@ bool cfg80211_reg_check_beaconing(struct wiphy *wiphy,
 				  struct cfg80211_beaconing_check_config *cfg)
 {
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
+	u32 permitting_flags = 0;
 	bool check_no_ir = true;
 
 	/*
@@ -1569,8 +1580,12 @@ bool cfg80211_reg_check_beaconing(struct wiphy *wiphy,
 							   chandef->chan);
 	}
 
+	if (cfg->reg_power == IEEE80211_REG_VLP_AP)
+		permitting_flags |= IEEE80211_CHAN_ALLOW_6GHZ_VLP_AP;
+
 	return _cfg80211_reg_can_beacon(wiphy, chandef, cfg->iftype,
-					check_no_ir);
+					check_no_ir ? IEEE80211_CHAN_NO_IR : 0,
+					permitting_flags);
 }
 EXPORT_SYMBOL(cfg80211_reg_check_beaconing);
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 00f7d36c66a5..7207e2bfb04d 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1207,6 +1207,9 @@ static int nl80211_msg_put_channel(struct sk_buff *msg, struct wiphy *wiphy,
 		if ((chan->flags & IEEE80211_CHAN_CAN_MONITOR) &&
 		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_CAN_MONITOR))
 			goto nla_put_failure;
+		if ((chan->flags & IEEE80211_CHAN_ALLOW_6GHZ_VLP_AP) &&
+		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_ALLOW_6GHZ_VLP_AP))
+			goto nla_put_failure;
 	}
 
 	if (nla_put_u32(msg, NL80211_FREQUENCY_ATTR_MAX_TX_POWER,
@@ -5954,6 +5957,7 @@ static int nl80211_validate_ap_phy_operation(struct cfg80211_ap_settings *params
 static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
+	struct cfg80211_beaconing_check_config beacon_check = {};
 	unsigned int link_id = nl80211_link_id(info->attrs);
 	struct net_device *dev = info->user_ptr[1];
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
@@ -6103,8 +6107,13 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 		goto out;
 	}
 
-	if (!cfg80211_reg_can_beacon_relax(&rdev->wiphy, &params->chandef,
-					   wdev->iftype)) {
+	beacon_check.iftype = wdev->iftype;
+	beacon_check.relax = true;
+	beacon_check.reg_power =
+		cfg80211_get_6ghz_power_type(params->beacon.tail,
+					     params->beacon.tail_len);
+	if (!cfg80211_reg_check_beaconing(&rdev->wiphy, &params->chandef,
+					  &beacon_check)) {
 		err = -EINVAL;
 		goto out;
 	}
@@ -6261,6 +6270,7 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 static int nl80211_set_beacon(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
+	struct cfg80211_beaconing_check_config beacon_check = {};
 	unsigned int link_id = nl80211_link_id(info->attrs);
 	struct net_device *dev = info->user_ptr[1];
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
@@ -6287,6 +6297,19 @@ static int nl80211_set_beacon(struct sk_buff *skb, struct genl_info *info)
 	if (err)
 		goto out;
 
+	/* recheck beaconing is permitted with possibly changed power type */
+	beacon_check.iftype = wdev->iftype;
+	beacon_check.relax = true;
+	beacon_check.reg_power =
+		cfg80211_get_6ghz_power_type(params->beacon.tail,
+					     params->beacon.tail_len);
+	if (!cfg80211_reg_check_beaconing(&rdev->wiphy,
+					  &wdev->links[link_id].ap.chandef,
+					  &beacon_check)) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	attr = info->attrs[NL80211_ATTR_FILS_DISCOVERY];
 	if (attr) {
 		err = nl80211_parse_fils_discovery(rdev, attr,
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 3cef0021a3db..4a27f3823e25 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -1600,6 +1600,8 @@ static u32 map_regdom_flags(u32 rd_flags)
 		channel_flags |= IEEE80211_CHAN_NO_6GHZ_AFC_CLIENT;
 	if (rd_flags & NL80211_RRF_PSD)
 		channel_flags |= IEEE80211_CHAN_PSD;
+	if (rd_flags & NL80211_RRF_ALLOW_6GHZ_VLP_AP)
+		channel_flags |= IEEE80211_CHAN_ALLOW_6GHZ_VLP_AP;
 	return channel_flags;
 }
 
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 14cfa0aba93a..33c3c4c1b158 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -3389,23 +3389,26 @@ TRACE_EVENT(cfg80211_cqm_rssi_notify,
 
 TRACE_EVENT(cfg80211_reg_can_beacon,
 	TP_PROTO(struct wiphy *wiphy, struct cfg80211_chan_def *chandef,
-		 enum nl80211_iftype iftype, bool check_no_ir),
-	TP_ARGS(wiphy, chandef, iftype, check_no_ir),
+		 enum nl80211_iftype iftype, u32 prohibited_flags,
+		 u32 permitting_flags),
+	TP_ARGS(wiphy, chandef, iftype, prohibited_flags, permitting_flags),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		CHAN_DEF_ENTRY
 		__field(enum nl80211_iftype, iftype)
-		__field(bool, check_no_ir)
+		__field(u32, prohibited_flags)
+		__field(u32, permitting_flags)
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
 		CHAN_DEF_ASSIGN(chandef);
 		__entry->iftype = iftype;
-		__entry->check_no_ir = check_no_ir;
+		__entry->prohibited_flags = prohibited_flags;
+		__entry->permitting_flags = permitting_flags;
 	),
-	TP_printk(WIPHY_PR_FMT ", " CHAN_DEF_PR_FMT ", iftype=%d check_no_ir=%s",
+	TP_printk(WIPHY_PR_FMT ", " CHAN_DEF_PR_FMT ", iftype=%d prohibited_flags=0x%x permitting_flags=0x%x",
 		  WIPHY_PR_ARG, CHAN_DEF_PR_ARG, __entry->iftype,
-		  BOOL_TO_STR(__entry->check_no_ir))
+		  __entry->prohibited_flags, __entry->permitting_flags)
 );
 
 TRACE_EVENT(cfg80211_chandef_dfs_required,
-- 
2.45.1


