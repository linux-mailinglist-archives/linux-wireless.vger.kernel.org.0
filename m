Return-Path: <linux-wireless+bounces-10973-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4DF948241
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 21:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD5892837E3
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 19:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAB116BE1A;
	Mon,  5 Aug 2024 19:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="E3WafDEE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98B415FA76
	for <linux-wireless@vger.kernel.org>; Mon,  5 Aug 2024 19:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722885821; cv=none; b=oMZQUGrpJJk0o029WIIKaovOAoXJ8MUnjKKLudlDKPsQISi4zl2PIrrWrv8k1sKlRPA/amXIM1VNT+iQJoJtPrjMhbz/PEg27xjJNmIZwTpSWn8eABj4i7K+c/PEv7kCjsL9UBxVlzM6IEPN8PB1xe/rceaOxcZXWl7nvg3J+E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722885821; c=relaxed/simple;
	bh=J03ohE86hNfK78Mvs7odslTMzBIXPPWVCE/YI/nYEM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oJZelhyJLTNtIa1S6nvMi9C5qpOaJCuWeMj93DqRo3HHnOX4pnZMznD2bqUtHoHVB2GXpgIHW0wmyUmZ/XtxK1tspL0un9Rm8HQdcTCgaMMmZfhawFDVxo7iG7FkThjBEt4BRi1691/3m5nMbF5NdSEsCKvhLUEXO4CchvXzicA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=E3WafDEE; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=BN5divBoZf05QiVe1StfbxuoTgGKD7Anik03uL9W9ns=; b=E3WafDEEhEP0BcHcshukRUeA9E
	8bSI+2GIbEqos+v5257+jsFaoYgRZSGFTv6C2wb4T6Uu8I+WPSywSPWAGut1Vt51OKzmFj9al4RLq
	apvJGHU0c4tUXBBRwTz9QEb4HKkGuN4nH2bX15hsXKy6m4036ojWS0N0pN+mUmQvvkpQ=;
Received: from p54ae9b72.dip0.t-ipconnect.de ([84.174.155.114] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sb3Iu-00EHlS-00;
	Mon, 05 Aug 2024 21:23:36 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [RFC 1/6] wifi: cfg80211/mac80211: add option for vif allowed radios
Date: Mon,  5 Aug 2024 21:23:29 +0200
Message-ID: <c5548aef0d731b7ab3c0811d514d6bb07a076720.1722885720.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.c32cfe64c671566c111b1b7ea426dbd1e8f2c568.1722885720.git-series.nbd@nbd.name>
References: <cover.c32cfe64c671566c111b1b7ea426dbd1e8f2c568.1722885720.git-series.nbd@nbd.name>
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

It enforces the configured radio mask for configured frequencies, scan
frequency lists and remain-on-channel requests.

Changing the allowed radios list for a vif is supported, but only while
it is down.

While it is possible to achieve the same by always explicitly specifying
a frequency list for scan requests and ensuring that the wrong channel/band
is never accidentally set on an unrelated interface, this change makes
multi-radio wiphy setups a lot easier to deal with for CLI users.

Follow-up changes build on this to support per-radio monitor, filter and
started state.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 include/net/cfg80211.h       | 14 +++++++++++-
 include/uapi/linux/nl80211.h |  5 ++++-
 net/mac80211/cfg.c           |  7 ++++++-
 net/mac80211/chan.c          | 13 +++++++---
 net/mac80211/iface.c         |  1 +-
 net/mac80211/scan.c          | 10 +++++---
 net/wireless/nl80211.c       | 46 ++++++++++++++++++++++++++++++++++---
 net/wireless/scan.c          | 10 +++++---
 net/wireless/util.c          | 29 +++++++++++++++++++++++-
 9 files changed, 123 insertions(+), 12 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index c2a9af1e3c5e..3d7d07027f4f 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -769,6 +769,7 @@ static inline void wiphy_read_of_freq_limits(struct wiphy *wiphy)
  *	belonging to that MU-MIMO groupID; %NULL if not changed
  * @vht_mumimo_follow_addr: MU-MIMO follow address, used for monitoring
  *	MU-MIMO packets going to the specified station; %NULL if not changed
+ * @radio_mask: Bitmask of radios that this interface is allowed to operate on.
  */
 struct vif_params {
 	u32 flags;
@@ -776,6 +777,7 @@ struct vif_params {
 	u8 macaddr[ETH_ALEN];
 	const u8 *vht_mumimo_groups;
 	const u8 *vht_mumimo_follow_addr;
+	u32 radio_mask;
 };
 
 /**
@@ -6222,6 +6224,7 @@ enum ieee80211_ap_reg_power {
  * @links: array of %IEEE80211_MLD_MAX_NUM_LINKS elements containing @addr
  *	@ap and @client for each link
  * @valid_links: bitmap describing what elements of @links are valid
+ * @radio_mask: Bitmask of radios that this interface is allowed to operate on.
  */
 struct wireless_dev {
 	struct wiphy *wiphy;
@@ -6335,6 +6338,8 @@ struct wireless_dev {
 		};
 	} links[IEEE80211_MLD_MAX_NUM_LINKS];
 	u16 valid_links;
+
+	u32 radio_mask;
 };
 
 static inline const u8 *wdev_address(struct wireless_dev *wdev)
@@ -6521,6 +6526,15 @@ bool cfg80211_radio_chandef_valid(const struct wiphy_radio *radio,
 				  const struct cfg80211_chan_def *chandef);
 
 /**
+ * cfg80211_wdev_channel_allowed - Check if the wdev may use the channel
+ *
+ * @wdev: the wireless device
+ * @chan: channel to check
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
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 85cb71de370f..32d9b9293ff3 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -216,6 +216,13 @@ static int ieee80211_change_iface(struct wiphy *wiphy,
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
+	if (params->radio_mask && params->radio_mask != sdata->wdev.radio_mask) {
+		if (ieee80211_sdata_running(sdata))
+			return -EBUSY;
+
+		sdata->wdev.radio_mask = params->radio_mask;
+	}
+
 	ret = ieee80211_if_change_type(sdata, type);
 	if (ret)
 		return ret;
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index e8567723e94d..65451ffad1ce 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -1166,7 +1166,7 @@ ieee80211_replace_chanctx(struct ieee80211_local *local,
 static bool
 ieee80211_find_available_radio(struct ieee80211_local *local,
 			       const struct ieee80211_chan_req *chanreq,
-			       int *radio_idx)
+			       u32 radio_mask, int *radio_idx)
 {
 	struct wiphy *wiphy = local->hw.wiphy;
 	const struct wiphy_radio *radio;
@@ -1177,6 +1177,9 @@ ieee80211_find_available_radio(struct ieee80211_local *local,
 		return true;
 
 	for (i = 0; i < wiphy->n_radio; i++) {
+		if (!(radio_mask & BIT(i)))
+			continue;
+
 		radio = &wiphy->radio[i];
 		if (!cfg80211_radio_chandef_valid(radio, &chanreq->oper))
 			continue;
@@ -1210,7 +1213,9 @@ int ieee80211_link_reserve_chanctx(struct ieee80211_link_data *link,
 	new_ctx = ieee80211_find_reservation_chanctx(local, chanreq, mode);
 	if (!new_ctx) {
 		if (ieee80211_can_create_new_chanctx(local, -1) &&
-		    ieee80211_find_available_radio(local, chanreq, &radio_idx))
+		    ieee80211_find_available_radio(local, chanreq,
+						   sdata->wdev.radio_mask,
+						   &radio_idx))
 			new_ctx = ieee80211_new_chanctx(local, chanreq, mode,
 							false, radio_idx);
 		else
@@ -1880,7 +1885,9 @@ int _ieee80211_link_use_channel(struct ieee80211_link_data *link,
 	/* Note: context is now reserved */
 	if (ctx)
 		reserved = true;
-	else if (!ieee80211_find_available_radio(local, chanreq, &radio_idx))
+	else if (!ieee80211_find_available_radio(local, chanreq,
+						 sdata->wdev.radio_mask,
+						 &radio_idx))
 		ctx = ERR_PTR(-EBUSY);
 	else
 		ctx = ieee80211_new_chanctx(local, chanreq, mode,
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index d44920c937af..56fed4f69427 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -2172,6 +2172,7 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
 
 	if (ndev) {
 		ndev->ieee80211_ptr->use_4addr = params->use_4addr;
+		ndev->ieee80211_ptr->radio_mask = params->radio_mask;
 		if (type == NL80211_IFTYPE_STATION)
 			sdata->u.mgd.use_4addr = params->use_4addr;
 
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index b5f2df61c7f6..86188d041263 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -1200,7 +1200,9 @@ int ieee80211_request_ibss_scan(struct ieee80211_sub_if_data *sdata,
 				    &local->hw.wiphy->bands[band]->channels[i];
 
 				if (tmp_ch->flags & (IEEE80211_CHAN_NO_IR |
-						     IEEE80211_CHAN_DISABLED))
+						     IEEE80211_CHAN_DISABLED) ||
+				    !cfg80211_wdev_channel_allowed(&sdata->wdev,
+								   tmp_ch))
 					continue;
 
 				local->int_scan_req->channels[n_ch] = tmp_ch;
@@ -1215,14 +1217,16 @@ int ieee80211_request_ibss_scan(struct ieee80211_sub_if_data *sdata,
 	} else {
 		for (i = 0; i < n_channels; i++) {
 			if (channels[i]->flags & (IEEE80211_CHAN_NO_IR |
-						  IEEE80211_CHAN_DISABLED))
+						  IEEE80211_CHAN_DISABLED) ||
+			    !cfg80211_wdev_channel_allowed(&sdata->wdev,
+							   channels[i]))
 				continue;
 
 			local->int_scan_req->channels[n_ch] = channels[i];
 			n_ch++;
 		}
 
-		if (WARN_ON_ONCE(n_ch == 0))
+		if (n_ch == 0)
 			goto unlock;
 
 		local->int_scan_req->n_channels = n_ch;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 7397a372c78e..7096674c3610 100644
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
@@ -4312,6 +4314,28 @@ static int nl80211_valid_4addr(struct cfg80211_registered_device *rdev,
 	return -EOPNOTSUPP;
 }
 
+static int nl80211_parse_vif_radio_mask(struct genl_info *info,
+					struct vif_params *params)
+{
+	struct cfg80211_registered_device *rdev = info->user_ptr[0];
+	struct nlattr *attr = info->attrs[NL80211_ATTR_VIF_RADIO_MASK];
+	u32 mask, allowed;
+
+	if (!attr)
+		return 0;
+
+	allowed = BIT(rdev->wiphy.n_radio) - 1;
+	mask = nla_get_u32(attr);
+	if (mask & ~allowed)
+		return -EINVAL;
+
+	if (!mask)
+		mask = allowed;
+	params->radio_mask = mask;
+
+	return 1;
+}
+
 static int nl80211_set_interface(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
@@ -4364,6 +4388,12 @@ static int nl80211_set_interface(struct sk_buff *skb, struct genl_info *info)
 	if (err > 0)
 		change = true;
 
+	err = nl80211_parse_vif_radio_mask(info, &params);
+	if (err < 0)
+		return err;
+	if (err > 0)
+		change = true;
+
 	if (change)
 		err = cfg80211_change_iface(rdev, dev, ntype, &params);
 	else
@@ -4424,6 +4454,11 @@ static int _nl80211_new_interface(struct sk_buff *skb, struct genl_info *info)
 	if (err < 0)
 		return err;
 
+	params.radio_mask = BIT(rdev->wiphy.n_radio) - 1;
+	err = nl80211_parse_vif_radio_mask(info, &params);
+	if (err < 0)
+		return err;
+
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg)
 		return -ENOMEM;
@@ -9180,6 +9215,9 @@ static bool cfg80211_off_channel_oper_allowed(struct wireless_dev *wdev,
 
 	lockdep_assert_wiphy(wdev->wiphy);
 
+	if (!cfg80211_wdev_channel_allowed(wdev, chan))
+		return false;
+
 	if (!cfg80211_beaconing_iface_active(wdev))
 		return true;
 
@@ -9392,7 +9430,8 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 			}
 
 			/* ignore disabled channels */
-			if (chan->flags & IEEE80211_CHAN_DISABLED)
+			if (chan->flags & IEEE80211_CHAN_DISABLED ||
+			    !cfg80211_wdev_channel_allowed(wdev, chan))
 				continue;
 
 			request->channels[i] = chan;
@@ -9412,7 +9451,8 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 
 				chan = &wiphy->bands[band]->channels[j];
 
-				if (chan->flags & IEEE80211_CHAN_DISABLED)
+				if (chan->flags & IEEE80211_CHAN_DISABLED ||
+				    !cfg80211_wdev_channel_allowed(wdev, chan))
 					continue;
 
 				request->channels[i] = chan;
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index d99319d82205..fd49a2746675 100644
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
@@ -3485,9 +3486,12 @@ int cfg80211_wext_siwscan(struct net_device *dev,
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
index 9a7c3adc8a3b..cef7ad288ad6 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -2921,3 +2921,32 @@ bool cfg80211_radio_chandef_valid(const struct wiphy_radio *radio,
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

