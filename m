Return-Path: <linux-wireless+bounces-34049-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJtUATdQxmk2IgUAu9opvQ
	(envelope-from <linux-wireless+bounces-34049-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 10:39:03 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2BF341D9E
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 10:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5BB07305F300
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 09:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65233DE42D;
	Fri, 27 Mar 2026 09:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="hqC3xGW3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84313DD526
	for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 09:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774604236; cv=none; b=qhedNSWz8e7s323b+d1WgpQUdqwr6w4junqo2qGwBr4wQ5I9YeS7lvIGYSN1dg0CabW6gSYp0gUcv9RB/cVTnYI/yC+xr4ihByll6ZHm47+BZBWQN8aDQmbxXmQYQzvVkWprZHYXOPZBBErJXBj8mpfUdnAd8BnY/dibUEfT86w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774604236; c=relaxed/simple;
	bh=NlSaYZA3M/iobvC4GcgbZ2txE35iZ3sgG8qnEEh/1fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mCWceF4BzJeRkrVd6Ilo8GA57A5oV3ANzkzviuZUzEtYqyc82Pk5Ur7j6qY+gbtqSVKV1dMSQT2ysQ1/9dA3PCUKOIAUk1+1QYqCh7gAdKoZ0IgeLRav9/Gpco6RU6GQaWf7/k+KN/GstSH/VQ60hU1mc9P1FdqyRnBwuWPDMjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=hqC3xGW3; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=yYiNNCuMEM5p/ut8Vd48IKwGprHLEcH5wUj2nXOIzqU=;
	t=1774604234; x=1775813834; b=hqC3xGW3iNDHfHOcnI+Tm4PULnoJK/8XRSetT0KH3dSaVwb
	tF0lJc6ECrgQLxgBqJ70RHWdPaxWvJ4wZm2ObJ2LoryXP8xH6Z7zhDYRsg+bmFRq8atDH6bNNXBUa
	T7ymQcWLmp+9rbN316HOikS6nPJmHtE/8neXWEBH5TVsxhPlikhpan2wOA3gTW4KKaziSla5D90Ch
	BzmGA1fWaR5+wdFVUuZXR6DR8mbLTvp/WU9mWeSScgNFPGbb9sUK9NByUEjj5QgBs36V+JAzTW0tY
	ZUw0aZis5xRUO+5xso4XQH6EG3REjS5Z6ad8l6NVvvfDiXMqeuBL60TIWLzw6Mpw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w63cu-0000000E83L-3PuK;
	Fri, 27 Mar 2026 10:37:13 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH 17/19] wifi: nl80211: always validate AP operation/PHY regulatory
Date: Fri, 27 Mar 2026 10:31:43 +0100
Message-ID: <20260327103659.46376d7268f8.I2e0b12ce5eddd422a553d10ba2ed7dcd0fbb1871@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327093659.711584-21-johannes@sipsolutions.net>
References: <20260327093659.711584-21-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34049-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sipsolutions.net:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9D2BF341D9E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

Instead of validating the AP operation elements and PHY regulatory
individually in each caller, which missed CSA and color change,
pass the channel to the beacon parsing function and validate the
parameters there. This adds it to the missing places.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 260 +++++++++++++++++++----------------------
 1 file changed, 123 insertions(+), 137 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index f65f3887ea62..b9c7dc099b33 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6394,9 +6394,104 @@ static int nl80211_parse_he_bss_color(struct nlattr *attrs,
 	return 0;
 }
 
+static void nl80211_check_ap_rate_selectors(struct cfg80211_beacon_data *bcn,
+					    const struct element *rates)
+{
+	int i;
+
+	if (!rates)
+		return;
+
+	for (i = 0; i < rates->datalen; i++) {
+		if (rates->data[i] == BSS_MEMBERSHIP_SELECTOR_HT_PHY)
+			bcn->ht_required = true;
+		if (rates->data[i] == BSS_MEMBERSHIP_SELECTOR_VHT_PHY)
+			bcn->vht_required = true;
+	}
+}
+
+/*
+ * Since the nl80211 API didn't include, from the beginning, attributes about
+ * HT/VHT/... operation, we parse them out of the elements and check for
+ * validity for use by drivers/mac80211.
+ */
+static int nl80211_calculate_ap_operation(struct nlattr *attrs[],
+					  struct cfg80211_beacon_data *bcn,
+					  struct netlink_ext_ack *extack)
+{
+	size_t ies_len = bcn->tail_len;
+	const u8 *ies = bcn->tail;
+	const struct element *rates;
+	const struct element *op;
+
+	rates = cfg80211_find_elem(WLAN_EID_SUPP_RATES, ies, ies_len);
+	nl80211_check_ap_rate_selectors(bcn, rates);
+
+	rates = cfg80211_find_elem(WLAN_EID_EXT_SUPP_RATES, ies, ies_len);
+	nl80211_check_ap_rate_selectors(bcn, rates);
+
+	op = cfg80211_find_ext_elem(WLAN_EID_EXT_HE_OPERATION, ies, ies_len);
+	if (op) {
+		if (op->datalen < sizeof(*bcn->he_oper) + 1) {
+			NL_SET_ERR_MSG(extack, "bad HE operation in beacon");
+			return -EINVAL;
+		}
+		bcn->he_oper = (void *)(op->data + 1);
+		/* takes extension ID into account */
+		if (op->datalen < ieee80211_he_oper_size((void *)bcn->he_oper)) {
+			NL_SET_ERR_MSG(extack, "bad HE operation in beacon");
+			return -EINVAL;
+		}
+	}
+
+	op = cfg80211_find_elem(WLAN_EID_HT_OPERATION, ies, ies_len);
+	if (op) {
+		if (op->datalen < sizeof(*bcn->ht_oper)) {
+			NL_SET_ERR_MSG(extack, "bad HT operation in beacon");
+			return -EINVAL;
+		}
+		bcn->ht_oper = (void *)op->data;
+	}
+
+	op = cfg80211_find_elem(WLAN_EID_VHT_OPERATION, ies, ies_len);
+	if (op) {
+		if (op->datalen < sizeof(*bcn->vht_oper)) {
+			NL_SET_ERR_MSG(extack, "bad VHT operation in beacon");
+			return -EINVAL;
+		}
+		bcn->vht_oper = (void *)op->data;
+	}
+
+	op = cfg80211_find_ext_elem(WLAN_EID_EXT_EHT_OPERATION, ies, ies_len);
+	if (op) {
+		if (!ieee80211_eht_oper_size_ok(op->data + 1,
+						op->datalen - 1)) {
+			NL_SET_ERR_MSG(extack, "bad EHT operation in beacon");
+			return -EINVAL;
+		}
+		bcn->eht_oper = (void *)(op->data + 1);
+	}
+
+	op = cfg80211_find_ext_elem(WLAN_EID_EXT_UHR_OPER, ies, ies_len);
+	if (op) {
+		/* need full UHR operation separately */
+		if (!attrs[NL80211_ATTR_UHR_OPERATION]) {
+			NL_SET_ERR_MSG(extack, "missing UHR operation");
+			return -EINVAL;
+		}
+		bcn->uhr_oper = nla_data(attrs[NL80211_ATTR_UHR_OPERATION]);
+	} else if (attrs[NL80211_ATTR_UHR_OPERATION]) {
+		NL_SET_ERR_MSG(extack, "unexpected UHR operation");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int nl80211_parse_beacon(struct cfg80211_registered_device *rdev,
 				struct nlattr *attrs[],
 				struct cfg80211_beacon_data *bcn,
+				struct ieee80211_channel *chan,
 				struct netlink_ext_ack *extack)
 {
 	bool haveinfo = false;
@@ -6511,6 +6606,19 @@ static int nl80211_parse_beacon(struct cfg80211_registered_device *rdev,
 		}
 	}
 
+	err = nl80211_calculate_ap_operation(attrs, bcn, extack);
+	if (err)
+		return err;
+
+	if (bcn->he_oper && (chan->flags & IEEE80211_CHAN_NO_HE))
+		return -EOPNOTSUPP;
+
+	if (bcn->eht_oper && (chan->flags & IEEE80211_CHAN_NO_EHT))
+		return -EOPNOTSUPP;
+
+	if (bcn->uhr_oper && (chan->flags & IEEE80211_CHAN_NO_UHR))
+		return -EOPNOTSUPP;
+
 	return 0;
 }
 
@@ -6628,22 +6736,6 @@ nl80211_parse_unsol_bcast_probe_resp(struct cfg80211_registered_device *rdev,
 	return 0;
 }
 
-static void nl80211_check_ap_rate_selectors(struct cfg80211_beacon_data *bcn,
-					    const struct element *rates)
-{
-	int i;
-
-	if (!rates)
-		return;
-
-	for (i = 0; i < rates->datalen; i++) {
-		if (rates->data[i] == BSS_MEMBERSHIP_SELECTOR_HT_PHY)
-			bcn->ht_required = true;
-		if (rates->data[i] == BSS_MEMBERSHIP_SELECTOR_VHT_PHY)
-			bcn->vht_required = true;
-	}
-}
-
 /*
  * Since the nl80211 API didn't include, from the beginning, attributes about
  * HT/VHT/... capabilities, we parse them out of the elements and check for
@@ -6697,83 +6789,6 @@ static int nl80211_calculate_ap_capabilities(struct genl_info *info,
 	return 0;
 }
 
-/*
- * Since the nl80211 API didn't include, from the beginning, attributes about
- * HT/VHT/... operation, we parse them out of the elements and check for
- * validity for use by drivers/mac80211.
- */
-static int nl80211_calculate_ap_operation(struct genl_info *info,
-					  struct cfg80211_beacon_data *bcn)
-{
-	size_t ies_len = bcn->tail_len;
-	const u8 *ies = bcn->tail;
-	const struct element *rates;
-	const struct element *op;
-
-	rates = cfg80211_find_elem(WLAN_EID_SUPP_RATES, ies, ies_len);
-	nl80211_check_ap_rate_selectors(bcn, rates);
-
-	rates = cfg80211_find_elem(WLAN_EID_EXT_SUPP_RATES, ies, ies_len);
-	nl80211_check_ap_rate_selectors(bcn, rates);
-
-	op = cfg80211_find_ext_elem(WLAN_EID_EXT_HE_OPERATION, ies, ies_len);
-	if (op) {
-		if (op->datalen < sizeof(*bcn->he_oper) + 1) {
-			GENL_SET_ERR_MSG(info, "bad HE operation in beacon");
-			return -EINVAL;
-		}
-		bcn->he_oper = (void *)(op->data + 1);
-		/* takes extension ID into account */
-		if (op->datalen < ieee80211_he_oper_size((void *)bcn->he_oper)) {
-			GENL_SET_ERR_MSG(info, "bad HE operation in beacon");
-			return -EINVAL;
-		}
-	}
-
-	op = cfg80211_find_elem(WLAN_EID_HT_OPERATION, ies, ies_len);
-	if (op) {
-		if (op->datalen < sizeof(*bcn->ht_oper)) {
-			GENL_SET_ERR_MSG(info, "bad HT operation in beacon");
-			return -EINVAL;
-		}
-		bcn->ht_oper = (void *)op->data;
-	}
-
-	op = cfg80211_find_elem(WLAN_EID_VHT_OPERATION, ies, ies_len);
-	if (op) {
-		if (op->datalen < sizeof(*bcn->vht_oper)) {
-			GENL_SET_ERR_MSG(info, "bad VHT operation in beacon");
-			return -EINVAL;
-		}
-		bcn->vht_oper = (void *)op->data;
-	}
-
-	op = cfg80211_find_ext_elem(WLAN_EID_EXT_EHT_OPERATION, ies, ies_len);
-	if (op) {
-		if (!ieee80211_eht_oper_size_ok(op->data + 1,
-						op->datalen - 1)) {
-			GENL_SET_ERR_MSG(info, "bad EHT operation in beacon");
-			return -EINVAL;
-		}
-		bcn->eht_oper = (void *)(op->data + 1);
-	}
-
-	op = cfg80211_find_ext_elem(WLAN_EID_EXT_UHR_OPER, ies, ies_len);
-	if (op) {
-		/* need full UHR operation separately */
-		if (!info->attrs[NL80211_ATTR_UHR_OPERATION]) {
-			GENL_SET_ERR_MSG(info, "missing UHR operation");
-			return -EINVAL;
-		}
-		bcn->uhr_oper = nla_data(info->attrs[NL80211_ATTR_UHR_OPERATION]);
-	} else if (info->attrs[NL80211_ATTR_UHR_OPERATION]) {
-		GENL_SET_ERR_MSG(info, "unexpected UHR operation");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static bool nl80211_get_ap_channel(struct cfg80211_registered_device *rdev,
 				   struct cfg80211_ap_settings *params)
 {
@@ -6898,21 +6913,6 @@ static void nl80211_send_ap_started(struct wireless_dev *wdev,
 	nlmsg_free(msg);
 }
 
-static int nl80211_validate_ap_phy_operation(struct ieee80211_channel *channel,
-					     struct cfg80211_beacon_data *bcn)
-{
-	if (bcn->he_oper && (channel->flags & IEEE80211_CHAN_NO_HE))
-		return -EOPNOTSUPP;
-
-	if (bcn->eht_oper && (channel->flags & IEEE80211_CHAN_NO_EHT))
-		return -EOPNOTSUPP;
-
-	if (bcn->uhr_oper && (channel->flags & IEEE80211_CHAN_NO_UHR))
-		return -EOPNOTSUPP;
-
-	return 0;
-}
-
 static int
 nl80211_parse_s1g_short_beacon(struct cfg80211_registered_device *rdev,
 			       struct nlattr *attrs,
@@ -6985,11 +6985,6 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 	if (!params)
 		return -ENOMEM;
 
-	err = nl80211_parse_beacon(rdev, info->attrs, &params->beacon,
-				   info->extack);
-	if (err)
-		goto out;
-
 	params->beacon_interval =
 		nla_get_u32(info->attrs[NL80211_ATTR_BEACON_INTERVAL]);
 	params->dtim_period =
@@ -7106,6 +7101,11 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 		goto out;
 	}
 
+	err = nl80211_parse_beacon(rdev, info->attrs, &params->beacon,
+				   params->chandef.chan, info->extack);
+	if (err)
+		goto out;
+
 	beacon_check.iftype = wdev->iftype;
 	beacon_check.relax = true;
 	beacon_check.reg_power =
@@ -7209,15 +7209,6 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 	if (err)
 		goto out;
 
-	err = nl80211_calculate_ap_operation(info, &params->beacon);
-	if (err)
-		goto out;
-
-	err = nl80211_validate_ap_phy_operation(params->chandef.chan,
-						&params->beacon);
-	if (err)
-		goto out;
-
 	if (info->attrs[NL80211_ATTR_AP_SETTINGS_FLAGS])
 		params->flags = nla_get_u32(
 			info->attrs[NL80211_ATTR_AP_SETTINGS_FLAGS]);
@@ -7285,19 +7276,11 @@ static int nl80211_set_beacon(struct sk_buff *skb, struct genl_info *info)
 		return -ENOMEM;
 
 	err = nl80211_parse_beacon(rdev, info->attrs, &params->beacon,
+				   wdev->links[link_id].ap.chandef.chan,
 				   info->extack);
 	if (err)
 		goto out;
 
-	err = nl80211_calculate_ap_operation(info, &params->beacon);
-	if (err)
-		goto out;
-
-	err = nl80211_validate_ap_phy_operation(wdev->links[link_id].ap.chandef.chan,
-						&params->beacon);
-	if (err)
-		goto out;
-
 	/* recheck beaconing is permitted with possibly changed power type */
 	beacon_check.iftype = wdev->iftype;
 	beacon_check.relax = true;
@@ -11898,11 +11881,16 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 
 	params.count = cs_count;
 
+	err = nl80211_parse_chandef(rdev, info->extack, info->attrs,
+				    &params.chandef);
+	if (err)
+		goto free;
+
 	if (!need_new_beacon)
 		goto skip_beacons;
 
 	err = nl80211_parse_beacon(rdev, info->attrs, &params.beacon_after,
-				   info->extack);
+				   params.chandef.chan, info->extack);
 	if (err)
 		goto free;
 
@@ -11919,6 +11907,7 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 		goto free;
 
 	err = nl80211_parse_beacon(rdev, csa_attrs, &params.beacon_csa,
+				   wdev->links[link_id].ap.chandef.chan,
 				   info->extack);
 	if (err)
 		goto free;
@@ -11947,11 +11936,6 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 		goto free;
 
 skip_beacons:
-	err = nl80211_parse_chandef(rdev, info->extack, info->attrs,
-				    &params.chandef);
-	if (err)
-		goto free;
-
 	if (!cfg80211_reg_can_beacon_relax(&rdev->wiphy, &params.chandef,
 					   wdev->iftype)) {
 		err = -EINVAL;
@@ -18405,6 +18389,7 @@ static int nl80211_color_change(struct sk_buff *skb, struct genl_info *info)
 	params.color = nla_get_u8(info->attrs[NL80211_ATTR_COLOR_CHANGE_COLOR]);
 
 	err = nl80211_parse_beacon(rdev, info->attrs, &params.beacon_next,
+				   wdev->links[params.link_id].ap.chandef.chan,
 				   info->extack);
 	if (err)
 		return err;
@@ -18420,6 +18405,7 @@ static int nl80211_color_change(struct sk_buff *skb, struct genl_info *info)
 		goto out;
 
 	err = nl80211_parse_beacon(rdev, tb, &params.beacon_color_change,
+				   wdev->links[params.link_id].ap.chandef.chan,
 				   info->extack);
 	if (err)
 		goto out;
-- 
2.53.0


