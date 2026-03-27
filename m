Return-Path: <linux-wireless+bounces-34046-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABzPNypQxmk2IgUAu9opvQ
	(envelope-from <linux-wireless+bounces-34046-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 10:38:50 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9613A341D82
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 10:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BAC3430A84DD
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 09:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F063D8134;
	Fri, 27 Mar 2026 09:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="EDl21jhp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEDB3D3318
	for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 09:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774604235; cv=none; b=NNgueo56qSqeT9D0EU+Zk4Du/ZK6g/GU6mMM1r8NW4yu/OhH2Rjwl4qGP3XBHQ9/psZT47Yrn+t/H6reLx+4vNq8KNOxXpEYgxwrFHj+8hJF0MYkvaj9tht/kzraWgK9z+eJ4a5tVmE2OHhc4/hxBxn4BQXh5oc1p7LqBmALnIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774604235; c=relaxed/simple;
	bh=goU21D0yWdL5ADRt6W308OvlGgzf7gnq3VzuN8YBbCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KwARXwAZhncrz0KaL25RkcqTBeEOVlbDyN0DNBE0UZPzjf6Y/9p1mGD0hUnGW1thkqHJ1cWaWNoxnxmK01SGAfkbL97xuDiGtZVOF0h2rnqLcUK278dLqr4e0eWH1A9oGJ9W3BBjUrwNH1l3ZL+UzVLhga11dgfkNILj2F2p4qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=EDl21jhp; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=7cqBVCLDVswvHL8V4PFIaNxc0IVRcVJq3d8VN4bL9a0=;
	t=1774604234; x=1775813834; b=EDl21jhpt4j0T19nX93XPbMNbY/Dq6ba3JVMwCWAJWbE44H
	KTItQ2afh8l5/tCvYraIM2jADvqEFIbjUYijgoAgjaJtZTtAdg0695zaZGSJRaacam83fJzjZ0kgU
	JOWjGokjnR/bftZY6cvmw/nezTlFEPMw8CNRstuC0e5ZYHkQpAG3PZ0Uwy15XYXRt2tNkXZXYYPdU
	K9j1CQcuLjlHK94ACHxbWTivLx1v7NELkXxO8KWIddPkU810W08GarpSaV7OPY7U1RhpniO4cC/L8
	FJDi4L3MMK5g65belCWjBZ3sqJvTRHuCv2GaS142SQI3bg9jKHi8hQbdWmB9Bt/g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w63ct-0000000E83L-3I7V;
	Fri, 27 Mar 2026 10:37:12 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH 16/19] wifi: cfg80211: provide HT/VHT operation for AP beacon
Date: Fri, 27 Mar 2026 10:31:42 +0100
Message-ID: <20260327103659.58d4844576c6.Ia9692671b699164edcc0bdaf4fdbdbefc50b18f8@changeid>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34046-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 9613A341D82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

In addition to providing HE/EHT/UHR operation, also check
and provide HT/VHT operation, so that drivers have it and
can use it, e.g. to correctly calculate station bandwidth.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h |  4 ++++
 net/wireless/nl80211.c | 18 ++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index f3e46f6d7410..4705c53bd228 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1398,6 +1398,8 @@ struct cfg80211_rnr_elems {
  *	attribute is present in beacon data or not.
  * @ht_required: stations must support HT
  * @vht_required: stations must support VHT
+ * @ht_oper: HT operation element (or %NULL if HT isn't enabled)
+ * @vht_oper: VHT operation element (or %NULL if VHT isn't enabled)
  * @he_oper: HE operation IE (or %NULL if HE isn't enabled)
  * @eht_oper: EHT operation IE (or %NULL if EHT isn't enabled)
  * @uhr_oper: UHR operation (or %NULL if UHR isn't enabled)
@@ -1427,6 +1429,8 @@ struct cfg80211_beacon_data {
 	bool he_bss_color_valid;
 
 	bool ht_required, vht_required;
+	const struct ieee80211_ht_operation *ht_oper;
+	const struct ieee80211_vht_operation *vht_oper;
 	const struct ieee80211_he_operation *he_oper;
 	const struct ieee80211_eht_operation *eht_oper;
 	const struct ieee80211_uhr_operation *uhr_oper;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 263d04a1366e..f65f3887ea62 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6730,6 +6730,24 @@ static int nl80211_calculate_ap_operation(struct genl_info *info,
 		}
 	}
 
+	op = cfg80211_find_elem(WLAN_EID_HT_OPERATION, ies, ies_len);
+	if (op) {
+		if (op->datalen < sizeof(*bcn->ht_oper)) {
+			GENL_SET_ERR_MSG(info, "bad HT operation in beacon");
+			return -EINVAL;
+		}
+		bcn->ht_oper = (void *)op->data;
+	}
+
+	op = cfg80211_find_elem(WLAN_EID_VHT_OPERATION, ies, ies_len);
+	if (op) {
+		if (op->datalen < sizeof(*bcn->vht_oper)) {
+			GENL_SET_ERR_MSG(info, "bad VHT operation in beacon");
+			return -EINVAL;
+		}
+		bcn->vht_oper = (void *)op->data;
+	}
+
 	op = cfg80211_find_ext_elem(WLAN_EID_EXT_EHT_OPERATION, ies, ies_len);
 	if (op) {
 		if (!ieee80211_eht_oper_size_ok(op->data + 1,
-- 
2.53.0


