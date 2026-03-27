Return-Path: <linux-wireless+bounces-34043-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJdFFDVQxmk2IgUAu9opvQ
	(envelope-from <linux-wireless+bounces-34043-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 10:39:01 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A124341D97
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 10:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2355F3085A47
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 09:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142303DD52B;
	Fri, 27 Mar 2026 09:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Lx6Hq/pP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5EA36AB46
	for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 09:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774604234; cv=none; b=nlBKoI+WbjKUizc0T0mPuEzBxQmen1f+6hi4ivHNb1hJLHR683YpacSF95VYVoxzSMXG8sCCSxcA4vzkkvlTccbHVCereyzFD7tB7PTG6IWN+5KcxJEiwplCC0KgQIZD+kwYJo1mmdngy68SZAkPzWfo55xYf7FeBIdGes9/TXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774604234; c=relaxed/simple;
	bh=YfTVX0Xw4PpJ46uKvytUcMIAvLujwx6B7vaCXQXsR9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qZDrTebDXCZblYDLhZ7O/AY3HgGe8A0zXrnjzGWoYU1alGqtwS4A8Rt8srZyryWlRdiHS3ijVy0kfmcDb2vTl/28EOngC6xTIwbUz83shPPVvry8Hlj65+pTUWYaPzgqScH/K+LkH2Fnfhv312v/42A4hk22KTATIzzzZTNQKkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Lx6Hq/pP; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=hOFbz4mHYlPG8Y6oP03DjF7KbsKzqv5Jv0jwrTCWgTY=;
	t=1774604232; x=1775813832; b=Lx6Hq/pPF8JqVTBGrpFUeKF3VObm+wMNCqoN+G0y6bcA7+Q
	05L/T+vuCH2nRb9Q64b2C71iEtxnCnsGPcq8Ko5Nd38nT8+e+EocbGIr2kw2hDnuSnXiC1jFgkOEG
	fdIBPb2WbpvctlXI25LEKPhPncOMe6ZoacmV7JDo/x5u2SCV+3KBs9kgJMt70xVYEGZYpuySgAcfr
	BJeOE6dJ70to5IOC8vg68eaaqiwdJyA7QtLXPPxGJZ/OVhvMxOK6IAb66FXIWsNan9ML8bbP9iPv5
	o25uwsctb9kDggUJbMym+jeIzWhTS3SBXyR52x6u+3yBq2EV6i60MdJS+1IeB5Sw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w63cs-0000000E83L-1g85;
	Fri, 27 Mar 2026 10:37:10 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH 14/19] wifi: cfg80211: move AP HT/VHT/... operation to beacon info
Date: Fri, 27 Mar 2026 10:31:40 +0100
Message-ID: <20260327103659.1cdda25b617f.I0d21120b41eed661eefc61d5417dadaae7145845@changeid>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34043-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sipsolutions.net:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0A124341D97
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

The HT/VHT/HE/EHT/UHR operation can change, and might thus be
updated on each beacon update. Move them to the beacon struct
and parse them out of the beacon also on updates, not just on
starting the AP.

This also fixes checks in two ways:
 - Regulatory checks in nl80211_validate_ap_phy_operation() are
   now done also on updates, disallowing enabling HE/EHT/UHR on
   channels that don't allow that after start. This checks only
   operation now, but clients can't use it without operation.
 - NL80211_ATTR_UHR_OPERATION is now required whenever UHR is
   present in the beacon, and rejected otherwise.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h |  17 +++---
 net/mac80211/cfg.c     |  10 ++--
 net/wireless/nl80211.c | 117 ++++++++++++++++++++++++++---------------
 3 files changed, 89 insertions(+), 55 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 8bebf45af95d..f3e46f6d7410 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1396,6 +1396,11 @@ struct cfg80211_rnr_elems {
  * @he_bss_color: BSS Color settings
  * @he_bss_color_valid: indicates whether bss color
  *	attribute is present in beacon data or not.
+ * @ht_required: stations must support HT
+ * @vht_required: stations must support VHT
+ * @he_oper: HE operation IE (or %NULL if HE isn't enabled)
+ * @eht_oper: EHT operation IE (or %NULL if EHT isn't enabled)
+ * @uhr_oper: UHR operation (or %NULL if UHR isn't enabled)
  */
 struct cfg80211_beacon_data {
 	unsigned int link_id;
@@ -1420,6 +1425,11 @@ struct cfg80211_beacon_data {
 	size_t civicloc_len;
 	struct cfg80211_he_bss_color he_bss_color;
 	bool he_bss_color_valid;
+
+	bool ht_required, vht_required;
+	const struct ieee80211_he_operation *he_oper;
+	const struct ieee80211_eht_operation *eht_oper;
+	const struct ieee80211_uhr_operation *uhr_oper;
 };
 
 struct mac_address {
@@ -1524,14 +1534,11 @@ struct cfg80211_s1g_short_beacon {
  * @vht_cap: VHT capabilities (or %NULL if VHT isn't enabled)
  * @he_cap: HE capabilities (or %NULL if HE isn't enabled)
  * @eht_cap: EHT capabilities (or %NULL if EHT isn't enabled)
- * @eht_oper: EHT operation IE (or %NULL if EHT isn't enabled)
- * @uhr_oper: UHR operation (or %NULL if UHR isn't enabled)
  * @ht_required: stations must support HT
  * @vht_required: stations must support VHT
  * @twt_responder: Enable Target Wait Time
  * @flags: flags, as defined in &enum nl80211_ap_settings_flags
  * @he_obss_pd: OBSS Packet Detection settings
- * @he_oper: HE operation IE (or %NULL if HE isn't enabled)
  * @fils_discovery: FILS discovery transmission parameters
  * @unsol_bcast_probe_resp: Unsolicited broadcast probe response parameters
  * @mbssid_config: AP settings for multiple bssid
@@ -1560,11 +1567,7 @@ struct cfg80211_ap_settings {
 	const struct ieee80211_ht_cap *ht_cap;
 	const struct ieee80211_vht_cap *vht_cap;
 	const struct ieee80211_he_cap_elem *he_cap;
-	const struct ieee80211_he_operation *he_oper;
 	const struct ieee80211_eht_cap_elem *eht_cap;
-	const struct ieee80211_eht_operation *eht_oper;
-	const struct ieee80211_uhr_operation *uhr_oper;
-	bool ht_required, vht_required;
 	bool twt_responder;
 	u32 flags;
 	struct ieee80211_he_obss_pd he_obss_pd;
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 4011d9d1ffcc..88057efae8e3 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1539,13 +1539,13 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 				cpu_to_le32(IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE);
 	}
 
-	if (params->he_cap && params->he_oper) {
+	if (params->he_cap && params->beacon.he_oper) {
 		link_conf->he_support = true;
 		link_conf->htc_trig_based_pkt_ext =
-			le32_get_bits(params->he_oper->he_oper_params,
+			le32_get_bits(params->beacon.he_oper->he_oper_params,
 			      IEEE80211_HE_OPERATION_DFLT_PE_DURATION_MASK);
 		link_conf->frame_time_rts_th =
-			le32_get_bits(params->he_oper->he_oper_params,
+			le32_get_bits(params->beacon.he_oper->he_oper_params,
 			      IEEE80211_HE_OPERATION_RTS_THRESHOLD_MASK);
 		changed |= BSS_CHANGED_HE_OBSS_PD;
 
@@ -1594,7 +1594,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 				 IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_160MHZ |
 				 IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_320MHZ);
 		link_conf->eht_disable_mcs15 =
-			u8_get_bits(params->eht_oper->params,
+			u8_get_bits(params->beacon.eht_oper->params,
 				    IEEE80211_EHT_OPER_MCS15_DISABLE);
 	} else {
 		link_conf->eht_su_beamformer = false;
@@ -1602,7 +1602,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 		link_conf->eht_mu_beamformer = false;
 	}
 
-	if (params->uhr_oper) {
+	if (params->beacon.uhr_oper) {
 		if (!link_conf->eht_support)
 			return -EOPNOTSUPP;
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 7a1c9faef443..e0ed9ed28093 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6628,7 +6628,7 @@ nl80211_parse_unsol_bcast_probe_resp(struct cfg80211_registered_device *rdev,
 	return 0;
 }
 
-static void nl80211_check_ap_rate_selectors(struct cfg80211_ap_settings *params,
+static void nl80211_check_ap_rate_selectors(struct cfg80211_beacon_data *bcn,
 					    const struct element *rates)
 {
 	int i;
@@ -6638,31 +6638,23 @@ static void nl80211_check_ap_rate_selectors(struct cfg80211_ap_settings *params,
 
 	for (i = 0; i < rates->datalen; i++) {
 		if (rates->data[i] == BSS_MEMBERSHIP_SELECTOR_HT_PHY)
-			params->ht_required = true;
+			bcn->ht_required = true;
 		if (rates->data[i] == BSS_MEMBERSHIP_SELECTOR_VHT_PHY)
-			params->vht_required = true;
+			bcn->vht_required = true;
 	}
 }
 
 /*
  * Since the nl80211 API didn't include, from the beginning, attributes about
- * HT/VHT requirements/capabilities, we parse them out of the IEs for the
- * benefit of drivers that rebuild IEs in the firmware.
+ * HT/VHT/... capabilities, we parse them out of the elements and check for
+ * validity for use by drivers/mac80211.
  */
-static int nl80211_calculate_ap_params(struct cfg80211_ap_settings *params)
+static int nl80211_calculate_ap_capabilities(struct cfg80211_ap_settings *params)
 {
-	const struct cfg80211_beacon_data *bcn = &params->beacon;
-	size_t ies_len = bcn->tail_len;
-	const u8 *ies = bcn->tail;
-	const struct element *rates;
+	size_t ies_len = params->beacon.tail_len;
+	const u8 *ies = params->beacon.tail;
 	const struct element *cap;
 
-	rates = cfg80211_find_elem(WLAN_EID_SUPP_RATES, ies, ies_len);
-	nl80211_check_ap_rate_selectors(params, rates);
-
-	rates = cfg80211_find_elem(WLAN_EID_EXT_SUPP_RATES, ies, ies_len);
-	nl80211_check_ap_rate_selectors(params, rates);
-
 	cap = cfg80211_find_elem(WLAN_EID_HT_CAPABILITY, ies, ies_len);
 	if (cap && cap->datalen >= sizeof(*params->ht_cap))
 		params->ht_cap = (void *)cap->data;
@@ -6672,31 +6664,62 @@ static int nl80211_calculate_ap_params(struct cfg80211_ap_settings *params)
 	cap = cfg80211_find_ext_elem(WLAN_EID_EXT_HE_CAPABILITY, ies, ies_len);
 	if (cap && cap->datalen >= sizeof(*params->he_cap) + 1)
 		params->he_cap = (void *)(cap->data + 1);
-	cap = cfg80211_find_ext_elem(WLAN_EID_EXT_HE_OPERATION, ies, ies_len);
-	if (cap && cap->datalen >= sizeof(*params->he_oper) + 1) {
-		params->he_oper = (void *)(cap->data + 1);
-		/* takes extension ID into account */
-		if (cap->datalen < ieee80211_he_oper_size((void *)params->he_oper))
-			return -EINVAL;
-	}
 	cap = cfg80211_find_ext_elem(WLAN_EID_EXT_EHT_CAPABILITY, ies, ies_len);
 	if (cap) {
-		if (!cap->datalen)
-			return -EINVAL;
 		params->eht_cap = (void *)(cap->data + 1);
 		if (!ieee80211_eht_capa_size_ok((const u8 *)params->he_cap,
 						(const u8 *)params->eht_cap,
 						cap->datalen - 1, true))
 			return -EINVAL;
 	}
-	cap = cfg80211_find_ext_elem(WLAN_EID_EXT_EHT_OPERATION, ies, ies_len);
-	if (cap) {
-		if (!cap->datalen)
+
+	return 0;
+}
+
+/*
+ * Since the nl80211 API didn't include, from the beginning, attributes about
+ * HT/VHT/... operation, we parse them out of the elements and check for
+ * validity for use by drivers/mac80211.
+ */
+static int nl80211_calculate_ap_operation(struct genl_info *info,
+					  struct cfg80211_beacon_data *bcn)
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
+	if (op && op->datalen >= sizeof(*bcn->he_oper) + 1) {
+		bcn->he_oper = (void *)(op->data + 1);
+		/* takes extension ID into account */
+		if (op->datalen < ieee80211_he_oper_size((void *)bcn->he_oper))
 			return -EINVAL;
-		params->eht_oper = (void *)(cap->data + 1);
-		if (!ieee80211_eht_oper_size_ok((const u8 *)params->eht_oper,
-						cap->datalen - 1))
+	}
+
+	op = cfg80211_find_ext_elem(WLAN_EID_EXT_EHT_OPERATION, ies, ies_len);
+	if (op) {
+		if (!ieee80211_eht_oper_size_ok(op->data + 1,
+						op->datalen - 1))
 			return -EINVAL;
+		bcn->eht_oper = (void *)(op->data + 1);
+	}
+
+	op = cfg80211_find_ext_elem(WLAN_EID_EXT_UHR_OPER, ies, ies_len);
+	if (op) {
+		/* need full UHR operation separately */
+		if (!info->attrs[NL80211_ATTR_UHR_OPERATION])
+			return -EINVAL;
+		bcn->uhr_oper = nla_data(info->attrs[NL80211_ATTR_UHR_OPERATION]);
+	} else if (info->attrs[NL80211_ATTR_UHR_OPERATION]) {
+		GENL_SET_ERR_MSG(info, "unexpected UHR operation");
+		return -EINVAL;
 	}
 
 	return 0;
@@ -6826,19 +6849,16 @@ static void nl80211_send_ap_started(struct wireless_dev *wdev,
 	nlmsg_free(msg);
 }
 
-static int nl80211_validate_ap_phy_operation(struct cfg80211_ap_settings *params)
+static int nl80211_validate_ap_phy_operation(struct ieee80211_channel *channel,
+					     struct cfg80211_beacon_data *bcn)
 {
-	struct ieee80211_channel *channel = params->chandef.chan;
-
-	if ((params->he_cap ||  params->he_oper) &&
-	    (channel->flags & IEEE80211_CHAN_NO_HE))
+	if (bcn->he_oper && (channel->flags & IEEE80211_CHAN_NO_HE))
 		return -EOPNOTSUPP;
 
-	if ((params->eht_cap || params->eht_oper) &&
-	    (channel->flags & IEEE80211_CHAN_NO_EHT))
+	if (bcn->eht_oper && (channel->flags & IEEE80211_CHAN_NO_EHT))
 		return -EOPNOTSUPP;
 
-	if (params->uhr_oper && (channel->flags & IEEE80211_CHAN_NO_UHR))
+	if (bcn->uhr_oper && (channel->flags & IEEE80211_CHAN_NO_UHR))
 		return -EOPNOTSUPP;
 
 	return 0;
@@ -7136,14 +7156,16 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 			goto out;
 	}
 
-	err = nl80211_calculate_ap_params(params);
+	err = nl80211_calculate_ap_capabilities(params);
 	if (err)
 		goto out;
 
-	if (info->attrs[NL80211_ATTR_UHR_OPERATION])
-		params->uhr_oper = nla_data(info->attrs[NL80211_ATTR_UHR_OPERATION]);
+	err = nl80211_calculate_ap_operation(info, &params->beacon);
+	if (err)
+		goto out;
 
-	err = nl80211_validate_ap_phy_operation(params);
+	err = nl80211_validate_ap_phy_operation(params->chandef.chan,
+						&params->beacon);
 	if (err)
 		goto out;
 
@@ -7218,6 +7240,15 @@ static int nl80211_set_beacon(struct sk_buff *skb, struct genl_info *info)
 	if (err)
 		goto out;
 
+	err = nl80211_calculate_ap_operation(info, &params->beacon);
+	if (err)
+		goto out;
+
+	err = nl80211_validate_ap_phy_operation(wdev->links[link_id].ap.chandef.chan,
+						&params->beacon);
+	if (err)
+		goto out;
+
 	/* recheck beaconing is permitted with possibly changed power type */
 	beacon_check.iftype = wdev->iftype;
 	beacon_check.relax = true;
-- 
2.53.0


