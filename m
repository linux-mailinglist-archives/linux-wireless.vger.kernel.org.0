Return-Path: <linux-wireless+bounces-34788-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2O/VAreI32kHVAAAu9opvQ
	(envelope-from <linux-wireless+bounces-34788-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 14:46:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F0057404696
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 14:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4881C304BC6B
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 12:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA945331A7A;
	Wed, 15 Apr 2026 12:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="eNMOX9Gi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA774336885
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 12:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776257133; cv=none; b=e5ke+dTAmmn5VkwHzaIgKnR/QZqFuo5LzH0oQXXpZqTvuq4zIkIEwFPfu7ozjccmJY6tSutSssTVtW9Av3aY7S3FIawrtkgnazT8L0YS1K4F6EG7Sk2c199SuOzDpP6zGjFNh7ch1pPO/QB7/ZbE1gO4qLbn0mSZv7nwrCUs4hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776257133; c=relaxed/simple;
	bh=re6jedUR6sH7hgccICtnutNLAp4byIlONJRuEFkgJYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOuPdXAy3y7mhvvu7Xk7SlHsw482hSs7O1p3LXB2OqiL8bJNkRR/UNrSeHhfyDH9+iMtteUKS7ArY9IluRSaUVtTXg3rrN8ZIFMiTzRlpXXx34ocDRFzw/by/WLQekNaics/kTrgwxneddb9SnUQw86JATcfZwrzxejlUMMT0XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=eNMOX9Gi; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=WVvTUTFT6oqohHAXVMwMxVPdfShecu2e1Sf9DbvNH2Q=;
	t=1776257130; x=1777466730; b=eNMOX9GiTaMpQC/C5gr9m/z4KxZZBad3+zTMpiBZZknm5+d
	A2z+nF+MPMGrxdDKT5WFMhsI00RloN9BGSwGmlMFCUKB7LT73H5dR6I7br3fwHmLxy9HOw2MCBG1L
	39xJRsXrjWvMEw5zFJukKczgVLLQOUN6V4swmnKDUis9Su0t4NawiYa5FSurPRWwZdCRsDH2fVvHk
	WNrTbaoPEv4akY5mVzv7nNtOxRSOHKKK3LHU0PpmUwRxwLwF7mljQtl1nYtdrwVhwwnq90yseOLS7
	yILgu+HlpvevJmBoTYNsYjQ/pKTaARrrfk2Gvt6i17F5tuoLN0FrQ3SGqXobnmJg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wCzcW-00000006OgW-160v;
	Wed, 15 Apr 2026 14:45:28 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 16/20] wifi: nl80211: reject too short HT/VHT/HE/EHT capability/operation
Date: Wed, 15 Apr 2026 14:42:14 +0200
Message-ID: <20260415144514.40c24d7ee2df.Ib1368e4d8e33a396f332a38a6ba6708fd188f143@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415124514.284345-22-johannes@sipsolutions.net>
References: <20260415124514.284345-22-johannes@sipsolutions.net>
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
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-34788-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sipsolutions.net:dkim,intel.com:email]
X-Rspamd-Queue-Id: F0057404696
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

If any of these are present, the code only assigns pointers when
they're also long enough. Instead of ignoring them in that case,
reject the configuration instead.

Also add error messages to existing error paths.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 51 +++++++++++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 10 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index e0ed9ed28093..263d04a1366e 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6649,28 +6649,49 @@ static void nl80211_check_ap_rate_selectors(struct cfg80211_beacon_data *bcn,
  * HT/VHT/... capabilities, we parse them out of the elements and check for
  * validity for use by drivers/mac80211.
  */
-static int nl80211_calculate_ap_capabilities(struct cfg80211_ap_settings *params)
+static int nl80211_calculate_ap_capabilities(struct genl_info *info,
+					     struct cfg80211_ap_settings *params)
 {
 	size_t ies_len = params->beacon.tail_len;
 	const u8 *ies = params->beacon.tail;
 	const struct element *cap;
 
 	cap = cfg80211_find_elem(WLAN_EID_HT_CAPABILITY, ies, ies_len);
-	if (cap && cap->datalen >= sizeof(*params->ht_cap))
+	if (cap) {
+		if (cap->datalen < sizeof(*params->ht_cap)) {
+			GENL_SET_ERR_MSG(info, "bad HT capability in beacon");
+			return -EINVAL;
+		}
 		params->ht_cap = (void *)cap->data;
+	}
+
 	cap = cfg80211_find_elem(WLAN_EID_VHT_CAPABILITY, ies, ies_len);
-	if (cap && cap->datalen >= sizeof(*params->vht_cap))
+	if (cap) {
+		if (cap->datalen < sizeof(*params->vht_cap)) {
+			GENL_SET_ERR_MSG(info, "bad VHT capability in beacon");
+			return -EINVAL;
+		}
 		params->vht_cap = (void *)cap->data;
+	}
+
 	cap = cfg80211_find_ext_elem(WLAN_EID_EXT_HE_CAPABILITY, ies, ies_len);
-	if (cap && cap->datalen >= sizeof(*params->he_cap) + 1)
+	if (cap) {
+		if (cap->datalen < sizeof(*params->he_cap) + 1) {
+			GENL_SET_ERR_MSG(info, "bad HE capability in beacon");
+			return -EINVAL;
+		}
 		params->he_cap = (void *)(cap->data + 1);
+	}
+
 	cap = cfg80211_find_ext_elem(WLAN_EID_EXT_EHT_CAPABILITY, ies, ies_len);
 	if (cap) {
 		params->eht_cap = (void *)(cap->data + 1);
 		if (!ieee80211_eht_capa_size_ok((const u8 *)params->he_cap,
 						(const u8 *)params->eht_cap,
-						cap->datalen - 1, true))
+						cap->datalen - 1, true)) {
+			GENL_SET_ERR_MSG(info, "bad EHT capability in beacon");
 			return -EINVAL;
+		}
 	}
 
 	return 0;
@@ -6696,26 +6717,36 @@ static int nl80211_calculate_ap_operation(struct genl_info *info,
 	nl80211_check_ap_rate_selectors(bcn, rates);
 
 	op = cfg80211_find_ext_elem(WLAN_EID_EXT_HE_OPERATION, ies, ies_len);
-	if (op && op->datalen >= sizeof(*bcn->he_oper) + 1) {
+	if (op) {
+		if (op->datalen < sizeof(*bcn->he_oper) + 1) {
+			GENL_SET_ERR_MSG(info, "bad HE operation in beacon");
+			return -EINVAL;
+		}
 		bcn->he_oper = (void *)(op->data + 1);
 		/* takes extension ID into account */
-		if (op->datalen < ieee80211_he_oper_size((void *)bcn->he_oper))
+		if (op->datalen < ieee80211_he_oper_size((void *)bcn->he_oper)) {
+			GENL_SET_ERR_MSG(info, "bad HE operation in beacon");
 			return -EINVAL;
+		}
 	}
 
 	op = cfg80211_find_ext_elem(WLAN_EID_EXT_EHT_OPERATION, ies, ies_len);
 	if (op) {
 		if (!ieee80211_eht_oper_size_ok(op->data + 1,
-						op->datalen - 1))
+						op->datalen - 1)) {
+			GENL_SET_ERR_MSG(info, "bad EHT operation in beacon");
 			return -EINVAL;
+		}
 		bcn->eht_oper = (void *)(op->data + 1);
 	}
 
 	op = cfg80211_find_ext_elem(WLAN_EID_EXT_UHR_OPER, ies, ies_len);
 	if (op) {
 		/* need full UHR operation separately */
-		if (!info->attrs[NL80211_ATTR_UHR_OPERATION])
+		if (!info->attrs[NL80211_ATTR_UHR_OPERATION]) {
+			GENL_SET_ERR_MSG(info, "missing UHR operation");
 			return -EINVAL;
+		}
 		bcn->uhr_oper = nla_data(info->attrs[NL80211_ATTR_UHR_OPERATION]);
 	} else if (info->attrs[NL80211_ATTR_UHR_OPERATION]) {
 		GENL_SET_ERR_MSG(info, "unexpected UHR operation");
@@ -7156,7 +7187,7 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 			goto out;
 	}
 
-	err = nl80211_calculate_ap_capabilities(params);
+	err = nl80211_calculate_ap_capabilities(info, params);
 	if (err)
 		goto out;
 
-- 
2.53.0


