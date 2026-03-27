Return-Path: <linux-wireless+bounces-34045-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLMlBiBQxmk2IgUAu9opvQ
	(envelope-from <linux-wireless+bounces-34045-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 10:38:40 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A17341D6C
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 10:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE9E330A1DC0
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 09:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB923DD518;
	Fri, 27 Mar 2026 09:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="AnChP5V9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5153DCD8C
	for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 09:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774604234; cv=none; b=JIWxSVTYFom+MOFnDUyiJts4zV+2eI7PBlO73pvgJ6g+qFtlHRjqfYTVYNo0QzGpw8QZ8MPe4q9wQkoIYaqRaixNd2Td0ap7VOUhdG3c9NgJ4d5ut52UXWyhaGi4VN8qaP5UMjNQL1lBZuOk4APaq97T+V7PsSclQ9Nawf3G/08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774604234; c=relaxed/simple;
	bh=UvsBdjWjYnrKxHFBDWLMrLD4qKJZGdD1YY8ojqMCQPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HcJA7Z4kSO+Nn47gqhulia+oT+dXPVuJrBsGuDGhZ5NtgT7PwrIalVQklG2TWzaOPCwvbtgxp4W2w/kirjeLh+PbA+As1VWxJsw+t7s9VBtKyyirR8qwUWv1BYqaci0ON2Umit7zPkkNhYSMwl0vq5/UcU5LppcVhyYNJhkPttE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=AnChP5V9; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=RNBEoxkOZpB20HM+MEkb/7esdQ9Jw/Bi8o7NCsnb4hg=;
	t=1774604233; x=1775813833; b=AnChP5V9g8F/8BAJZiJfjs5P4I1ivn7SkBNfsjUICklJ0Xb
	Jgfw+//mReeaSbXOSme3/q47fD6a5aG58CD9D26r8HG/WtX/qHHmwL/7DFIWANVEtxfz/ZX/3kX8u
	c5aP5X9EZDAy2vAg3rRbGatZE63u/GzY+zCXyXcfFNqdcdO2tL4EGawvGCwcyOOCCYGWNl4WcWzqa
	1iuZSq7yGXGbCSkVJ8if4HUSZQhm6y3Oai9Tf15RtXxKvoI/5v6eveESqR5iP3WnkfvcrEC0k4rMl
	dP5ugJG2PpYh90Qo8w4hYDvUMwLv7fFNvbHqkafgaDFY+G+wUmMxX2YBYU7C5fzg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w63ct-0000000E83L-0B0i;
	Fri, 27 Mar 2026 10:37:11 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH 15/19] wifi: nl80211: reject too short HT/VHT/HE/EHT capability/operation
Date: Fri, 27 Mar 2026 10:31:41 +0100
Message-ID: <20260327103659.0030d54a57a7.Ib1368e4d8e33a396f332a38a6ba6708fd188f143@changeid>
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
	TAGGED_FROM(0.00)[bounces-34045-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: A2A17341D6C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

If any of these are present, the code only assigns pointers when
they're also long enough. Instead of ignoring them in that case,
reject the configuration instead.

Also add error messages to existing error paths.

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


