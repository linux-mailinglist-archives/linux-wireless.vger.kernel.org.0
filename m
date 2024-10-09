Return-Path: <linux-wireless+bounces-13768-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B65996264
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 10:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98C191C2189F
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 08:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018F8188903;
	Wed,  9 Oct 2024 08:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="UARQ6v4v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6197A188591
	for <linux-wireless@vger.kernel.org>; Wed,  9 Oct 2024 08:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728462363; cv=none; b=S3gLAChRIEzsUPbIJAjC7U/PKc3Z6CLCZHatz16Tkfv+OQ1AfJoxcS4SdEANMrb/r7ZIkuvCkI614pOye3N/V4S1I91NGOxDeRoeCEHgu4j18yPrUx1Qxbj/EM+m3vIsuWE9hW58qqYbRcOaFEJfg9j+eTrmnz4ymwzeTNfb5Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728462363; c=relaxed/simple;
	bh=BKC70bepRhUQVSeUp1QHlPvR0HzS83BVi5AVpSB11gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MYtA4QBp9Hd9cjjTL2Ecdiq6VqNBrSM2Qc+/OA4N+rW+TNB2+Pq/DHGlQqq6QY+yd+LVJvgRtf5OckEorUI01I8M+Ee9mExzqe4/cUESc3FieMntD4ZIgR77JKbxyuvnYLR2GVKC5IQNwIxWdJ6yx/CCS37e6TKUKWrK2QnEu+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=UARQ6v4v; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=HfAzdwi22BzlDOqbAFKfCIF/WcDA5pqDSlai1mvERE4=; b=UARQ6v4v3CAC45bZBQ1V/kjo76
	zsiCcYGBmbM4rFgX3UuI8vDCNZMJ7Y10Nsx3/1J4SsVIrIFRWrrB502XtHhelzmtPU9sUIm5NWwH2
	qQhKVehQopZzCMtL21sy36b2DYjB9odLEPSziNzYcquhLH9W345R85zGiHKDugx2zYy0=;
Received: from p54ae98e8.dip0.t-ipconnect.de ([84.174.152.232] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1syS13-006e0I-0J;
	Wed, 09 Oct 2024 10:25:53 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH v5 01/11] wifi: cfg80211: add option for vif allowed radios
Date: Wed,  9 Oct 2024 10:25:42 +0200
Message-ID: <eefcb218780f71a1549875d149f1196486762756.1728462320.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.7a6c6087b8cacec78525ec7f4f4d38c649d4a647.1728462320.git-series.nbd@nbd.name>
References: <cover.7a6c6087b8cacec78525ec7f4f4d38c649d4a647.1728462320.git-series.nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows users to prevent a vif from affecting radios other than the
configured ones. This can be useful in cases where e.g. an AP is running
on one radio, and triggering a scan on another radio should not disturb it.

Changing the allowed radios list for a vif is supported, but only while
it is down.

While it is possible to achieve the same by always explicitly specifying
a frequency list for scan requests and ensuring that the wrong channel/band
is never accidentally set on an unrelated interface, this change makes
multi-radio wiphy setups a lot easier to deal with for CLI users.

By itself, this patch only enforces the radio mask for scanning requests
and remain-on-channel. Follow-up changes build on this to limit configured
frequencies.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 include/net/cfg80211.h       | 14 +++++++++-
 include/uapi/linux/nl80211.h |  5 +++-
 net/wireless/core.c          |  2 +-
 net/wireless/nl80211.c       | 60 ++++++++++++++++++++++++++++++++-----
 net/wireless/scan.c          | 10 ++++--
 net/wireless/util.c          | 29 ++++++++++++++++++-
 6 files changed, 109 insertions(+), 11 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 69ec1eb41a09..e4441e4536ae 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -6223,6 +6223,7 @@ enum ieee80211_ap_reg_power {
  *	entered.
  * @links.cac_time_ms: CAC time in ms
  * @valid_links: bitmap describing what elements of @links are valid
+ * @radio_mask: Bitmask of radios that this interface is allowed to operate on.
  */
 struct wireless_dev {
 	struct wiphy *wiphy;
@@ -6335,6 +6336,8 @@ struct wireless_dev {
 		unsigned int cac_time_ms;
 	} links[IEEE80211_MLD_MAX_NUM_LINKS];
 	u16 valid_links;
+
+	u32 radio_mask;
 };
 
 static inline const u8 *wdev_address(struct wireless_dev *wdev)
@@ -6521,6 +6524,17 @@ bool cfg80211_radio_chandef_valid(const struct wiphy_radio *radio,
 				  const struct cfg80211_chan_def *chandef);
 
 /**
+ * cfg80211_wdev_channel_allowed - Check if the wdev may use the channel
+ *
+ * @wdev: the wireless device
+ * @chan: channel to check
+ *
+ * Return: whether or not the wdev may use the channel
+ */
+bool cfg80211_wdev_channel_allowed(struct wireless_dev *wdev,
+				   struct ieee80211_channel *chan);
+
+/**
  * ieee80211_get_response_rate - get basic rate for a given rate
  *
  * @sband: the band to look for rates in
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index f97f5adc8d51..d31ccee99cc7 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2868,6 +2868,9 @@ enum nl80211_commands {
  *	nested item, it contains attributes defined in
  *	&enum nl80211_if_combination_attrs.
  *
+ * @NL80211_ATTR_VIF_RADIO_MASK: Bitmask of allowed radios (u32).
+ *	A value of 0 means all radios.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3416,6 +3419,8 @@ enum nl80211_attrs {
 	NL80211_ATTR_WIPHY_RADIOS,
 	NL80211_ATTR_WIPHY_INTERFACE_COMBINATIONS,
 
+	NL80211_ATTR_VIF_RADIO_MASK,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 661adfc77644..870ecd8d6197 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1386,6 +1386,8 @@ void cfg80211_init_wdev(struct wireless_dev *wdev)
 	/* allow mac80211 to determine the timeout */
 	wdev->ps_timeout = -1;
 
+	wdev->radio_mask = BIT(wdev->wiphy->n_radio) - 1;
+
 	if ((wdev->iftype == NL80211_IFTYPE_STATION ||
 	     wdev->iftype == NL80211_IFTYPE_P2P_CLIENT ||
 	     wdev->iftype == NL80211_IFTYPE_ADHOC) && !wdev->use_4addr)
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 9ab777e0bd4d..7f3bd35c8a3b 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -829,6 +829,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_MLO_TTLM_DLINK] = NLA_POLICY_EXACT_LEN(sizeof(u16) * 8),
 	[NL80211_ATTR_MLO_TTLM_ULINK] = NLA_POLICY_EXACT_LEN(sizeof(u16) * 8),
 	[NL80211_ATTR_ASSOC_SPP_AMSDU] = { .type = NLA_FLAG },
+	[NL80211_ATTR_VIF_RADIO_MASK] = { .type = NLA_U32 },
 };
 
 /* policy for the key attributes */
@@ -3996,7 +3997,8 @@ static int nl80211_send_iface(struct sk_buff *msg, u32 portid, u32 seq, int flag
 	    nla_put_u32(msg, NL80211_ATTR_GENERATION,
 			rdev->devlist_generation ^
 			(cfg80211_rdev_list_generation << 2)) ||
-	    nla_put_u8(msg, NL80211_ATTR_4ADDR, wdev->use_4addr))
+	    nla_put_u8(msg, NL80211_ATTR_4ADDR, wdev->use_4addr) ||
+	    nla_put_u32(msg, NL80211_ATTR_VIF_RADIO_MASK, wdev->radio_mask))
 		goto nla_put_failure;
 
 	if (rdev->ops->get_channel && !wdev->valid_links) {
@@ -4312,6 +4314,29 @@ static int nl80211_valid_4addr(struct cfg80211_registered_device *rdev,
 	return -EOPNOTSUPP;
 }
 
+static int nl80211_parse_vif_radio_mask(struct genl_info *info,
+					u32 *radio_mask)
+{
+	struct cfg80211_registered_device *rdev = info->user_ptr[0];
+	struct nlattr *attr = info->attrs[NL80211_ATTR_VIF_RADIO_MASK];
+	u32 mask, allowed;
+
+	if (!attr) {
+		*radio_mask = 0;
+		return 0;
+	}
+
+	allowed = BIT(rdev->wiphy.n_radio) - 1;
+	mask = nla_get_u32(attr);
+	if (mask & ~allowed)
+		return -EINVAL;
+	if (!mask)
+		mask = allowed;
+	*radio_mask = mask;
+
+	return 1;
+}
+
 static int nl80211_set_interface(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
@@ -4319,6 +4344,8 @@ static int nl80211_set_interface(struct sk_buff *skb, struct genl_info *info)
 	int err;
 	enum nl80211_iftype otype, ntype;
 	struct net_device *dev = info->user_ptr[1];
+	struct wireless_dev *wdev = dev->ieee80211_ptr;
+	u32 radio_mask = 0;
 	bool change = false;
 
 	memset(&params, 0, sizeof(params));
@@ -4332,8 +4359,6 @@ static int nl80211_set_interface(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	if (info->attrs[NL80211_ATTR_MESH_ID]) {
-		struct wireless_dev *wdev = dev->ieee80211_ptr;
-
 		if (ntype != NL80211_IFTYPE_MESH_POINT)
 			return -EINVAL;
 		if (otype != NL80211_IFTYPE_MESH_POINT)
@@ -4364,6 +4389,12 @@ static int nl80211_set_interface(struct sk_buff *skb, struct genl_info *info)
 	if (err > 0)
 		change = true;
 
+	err = nl80211_parse_vif_radio_mask(info, &radio_mask);
+	if (err < 0)
+		return err;
+	if (err && netif_running(dev))
+		return -EBUSY;
+
 	if (change)
 		err = cfg80211_change_iface(rdev, dev, ntype, &params);
 	else
@@ -4372,11 +4403,11 @@ static int nl80211_set_interface(struct sk_buff *skb, struct genl_info *info)
 	if (!err && params.use_4addr != -1)
 		dev->ieee80211_ptr->use_4addr = params.use_4addr;
 
-	if (change && !err) {
-		struct wireless_dev *wdev = dev->ieee80211_ptr;
+	if (radio_mask)
+		wdev->radio_mask = radio_mask;
 
+	if (change && !err)
 		nl80211_notify_iface(rdev, wdev, NL80211_CMD_SET_INTERFACE);
-	}
 
 	return err;
 }
@@ -4387,6 +4418,7 @@ static int _nl80211_new_interface(struct sk_buff *skb, struct genl_info *info)
 	struct vif_params params;
 	struct wireless_dev *wdev;
 	struct sk_buff *msg;
+	u32 radio_mask;
 	int err;
 	enum nl80211_iftype type = NL80211_IFTYPE_UNSPECIFIED;
 
@@ -4424,6 +4456,10 @@ static int _nl80211_new_interface(struct sk_buff *skb, struct genl_info *info)
 	if (err < 0)
 		return err;
 
+	err = nl80211_parse_vif_radio_mask(info, &radio_mask);
+	if (err < 0)
+		return err;
+
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg)
 		return -ENOMEM;
@@ -4465,6 +4501,9 @@ static int _nl80211_new_interface(struct sk_buff *skb, struct genl_info *info)
 		break;
 	}
 
+	if (radio_mask)
+		wdev->radio_mask = radio_mask;
+
 	if (nl80211_send_iface(msg, info->snd_portid, info->snd_seq, 0,
 			       rdev, wdev, NL80211_CMD_NEW_INTERFACE) < 0) {
 		nlmsg_free(msg);
@@ -9180,6 +9219,9 @@ static bool cfg80211_off_channel_oper_allowed(struct wireless_dev *wdev,
 
 	lockdep_assert_wiphy(wdev->wiphy);
 
+	if (!cfg80211_wdev_channel_allowed(wdev, chan))
+		return false;
+
 	if (!cfg80211_beaconing_iface_active(wdev))
 		return true;
 
@@ -9392,7 +9434,8 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 			}
 
 			/* ignore disabled channels */
-			if (chan->flags & IEEE80211_CHAN_DISABLED)
+			if (chan->flags & IEEE80211_CHAN_DISABLED ||
+			    !cfg80211_wdev_channel_allowed(wdev, chan))
 				continue;
 
 			request->channels[i] = chan;
@@ -9412,7 +9455,8 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 
 				chan = &wiphy->bands[band]->channels[j];
 
-				if (chan->flags & IEEE80211_CHAN_DISABLED)
+				if (chan->flags & IEEE80211_CHAN_DISABLED ||
+				    !cfg80211_wdev_channel_allowed(wdev, chan))
 					continue;
 
 				request->channels[i] = chan;
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 59a90bf3c0d6..279af47651c1 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -956,7 +956,8 @@ static int cfg80211_scan_6ghz(struct cfg80211_registered_device *rdev)
 		struct ieee80211_channel *chan =
 			ieee80211_get_channel(&rdev->wiphy, ap->center_freq);
 
-		if (!chan || chan->flags & IEEE80211_CHAN_DISABLED)
+		if (!chan || chan->flags & IEEE80211_CHAN_DISABLED ||
+		    !cfg80211_wdev_channel_allowed(rdev_req->wdev, chan))
 			continue;
 
 		for (i = 0; i < rdev_req->n_channels; i++) {
@@ -3515,9 +3516,12 @@ int cfg80211_wext_siwscan(struct net_device *dev,
 			continue;
 
 		for (j = 0; j < wiphy->bands[band]->n_channels; j++) {
+			struct ieee80211_channel *chan;
+
 			/* ignore disabled channels */
-			if (wiphy->bands[band]->channels[j].flags &
-						IEEE80211_CHAN_DISABLED)
+			chan = &wiphy->bands[band]->channels[j];
+			if (chan->flags & IEEE80211_CHAN_DISABLED ||
+			    !cfg80211_wdev_channel_allowed(creq->wdev, chan))
 				continue;
 
 			/* If we have a wireless request structure and the
diff --git a/net/wireless/util.c b/net/wireless/util.c
index f49b55724f83..9ccc9602ac25 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -2923,3 +2923,32 @@ bool cfg80211_radio_chandef_valid(const struct wiphy_radio *radio,
 	return true;
 }
 EXPORT_SYMBOL(cfg80211_radio_chandef_valid);
+
+bool cfg80211_wdev_channel_allowed(struct wireless_dev *wdev,
+				   struct ieee80211_channel *chan)
+{
+	struct wiphy *wiphy = wdev->wiphy;
+	const struct wiphy_radio *radio;
+	struct cfg80211_chan_def chandef;
+	u32 radio_mask;
+	int i;
+
+	radio_mask = wdev->radio_mask;
+	if (!wiphy->n_radio || radio_mask == BIT(wiphy->n_radio) - 1)
+		return true;
+
+	cfg80211_chandef_create(&chandef, chan, NL80211_CHAN_HT20);
+	for (i = 0; i < wiphy->n_radio; i++) {
+		if (!(radio_mask & BIT(i)))
+			continue;
+
+		radio = &wiphy->radio[i];
+		if (!cfg80211_radio_chandef_valid(radio, &chandef))
+			continue;
+
+		return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL(cfg80211_wdev_channel_allowed);
-- 
git-series 0.9.1

