Return-Path: <linux-wireless+bounces-39024-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rjWHLIYRVmoIywAAu9opvQ
	(envelope-from <linux-wireless+bounces-39024-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 12:37:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5622875376E
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 12:37:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=T92WIAdt;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39024-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39024-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 76FC7300C7E5
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 10:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2A934E75A;
	Tue, 14 Jul 2026 10:37:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0797E36A358
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 10:37:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025473; cv=none; b=kjS/ELRz8MhVf4GE7tql/7vLeUtwCFgWY+WC6/S7PgWWY/2YScu4Ju2mc2um9saNome9bv8aaluwYHRbe3OOSotk5HlKOvgV+7SyK987QWhDB0GM5pxvZ60dn6+b1Mlo5PmAvGALrT4u+UOtHmOfup0r/y/k8cwo4cANJAmRMvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025473; c=relaxed/simple;
	bh=b3NWa7drYCkO7u4y2bGOZfPvZRZMzDU7eRyK2jHcjRI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J3u1GdFbuhoy6/P0KlbtO4Wr/7lSrJQWUyU1okuDiDdU4etitdxxx1/IUNFwzmHNG5Ghw3cBCaqBGZYOuyJq7t1O7fcBrxRCnpFKm2zrnbqX2WAZBWNhL/t2mQ00xl1dolT2Ya5OEu2iKr/VZVH8JDAedUdR+hlYbAgxW0dqXOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T92WIAdt; arc=none smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784025471; x=1815561471;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=b3NWa7drYCkO7u4y2bGOZfPvZRZMzDU7eRyK2jHcjRI=;
  b=T92WIAdtSkqPMzFmF9NVPAR0C/3bqb0Xn3fcAgwYKkJRBGDoTzC3pLgu
   hEU59uNUZTqLpPKz06LGX67H69Rhxm5ZVe+4rz7jQwkf1QCO5ZjMi4JJD
   PNwCu4QWAxETg/h2RjFHmtmHOq4bYrltzdwovfwjtFqa+EeEJjoZr9buw
   fmQi/VqJMi5nXAv9svaXVTH57MTjAaHtWfltZOkoU09ijMHfXqVSWLoi1
   tEiBwNst/EE1ADdnmISWjIk5uLp0gQxPPOVDcI2ZfDYbfOCCM+d44Cv2l
   jGY4IPs8dn90dA5XJ7WtWR1OTXVZI9e8KKkUnP/3671jKI5NUfm41s7vb
   g==;
X-CSE-ConnectionGUID: K4OUW3VdRwuP1q9okNEasQ==
X-CSE-MsgGUID: 2W1pSYERTOOc6oOrVueSJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="102196841"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="102196841"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 03:37:50 -0700
X-CSE-ConnectionGUID: 3HZ67fjHTJy73b66x3RdgQ==
X-CSE-MsgGUID: Q7Ju5Y49SMm55dvvFE9tew==
X-ExtLoop1: 1
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 03:37:49 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next] wifi: mac80211: refactor multi-link assoc response parsing
Date: Tue, 14 Jul 2026 13:37:27 +0300
Message-Id: <20260714133711.e2fb22738aa1.Id86c1bd6ddb5ec13ad9cbf24fd36b8246f351fe6@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-39024-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:johannes.berg@intel.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5622875376E

From: Johannes Berg <johannes.berg@intel.com>

Refactor the parsing code a bit, introducing specific error
messages for the various failures and moving the BSS parameter
change count parsing out a level to be easier to extend for
UHR.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 53 ++++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 9e92337bb6f9..f1172a950284 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5871,8 +5871,6 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 	const struct cfg80211_bss_ies *bss_ies = NULL;
 	struct ieee80211_supported_band *sband;
 	struct ieee802_11_elems *elems;
-	const __le16 prof_bss_param_ch_present =
-		cpu_to_le16(IEEE80211_MLE_STA_CONTROL_BSS_PARAM_CHANGE_CNT_PRESENT);
 	u16 capab_info;
 	bool ret;
 
@@ -5888,20 +5886,13 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 		 * successful, so set the status directly to success
 		 */
 		assoc_data->link[link_id].status = WLAN_STATUS_SUCCESS;
-		if (elems->ml_basic) {
-			int bss_param_ch_cnt =
-				ieee80211_mle_get_bss_param_ch_cnt((const void *)elems->ml_basic);
-
-			if (bss_param_ch_cnt < 0) {
-				ret = false;
-				goto out;
-			}
-			bss_conf->bss_param_ch_cnt = bss_param_ch_cnt;
-			bss_conf->bss_param_ch_cnt_link_id = link_id;
-		}
-	} else if (elems->parse_error & IEEE80211_PARSE_ERR_DUP_NEST_ML_BASIC ||
-		   !elems->prof ||
-		   !(elems->prof->control & prof_bss_param_ch_present)) {
+	} else if (elems->parse_error & IEEE80211_PARSE_ERR_DUP_NEST_ML_BASIC) {
+		sdata_info(sdata,
+			   "association response had nested multi-link element\n");
+		ret = false;
+		goto out;
+	} else if (!elems->prof) {
+		link_info(link, "link missing from association response\n");
 		ret = false;
 		goto out;
 	} else {
@@ -5915,10 +5906,6 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 		 */
 		capab_info = get_unaligned_le16(ptr);
 		assoc_data->link[link_id].status = get_unaligned_le16(ptr + 2);
-		bss_param_ch_cnt =
-			ieee80211_mle_basic_sta_prof_bss_param_ch_cnt(elems->prof);
-		bss_conf->bss_param_ch_cnt = bss_param_ch_cnt;
-		bss_conf->bss_param_ch_cnt_link_id = link_id;
 
 		if (assoc_data->link[link_id].status != WLAN_STATUS_SUCCESS) {
 			link_info(link, "association response status code=%u\n",
@@ -5926,6 +5913,32 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 			ret = true;
 			goto out;
 		}
+
+		if (!(elems->prof->control &
+		      cpu_to_le16(IEEE80211_MLE_STA_CONTROL_BSS_PARAM_CHANGE_CNT_PRESENT))) {
+			link_info(link,
+				  "per-STA profile missing BSS parameter change count\n");
+			ret = false;
+			goto out;
+		}
+		bss_param_ch_cnt =
+			ieee80211_mle_basic_sta_prof_bss_param_ch_cnt(elems->prof);
+		bss_conf->bss_param_ch_cnt = bss_param_ch_cnt;
+		bss_conf->bss_param_ch_cnt_link_id = link_id;
+	}
+
+	if (link_id == assoc_data->assoc_link_id && elems->ml_basic) {
+		int bss_param_ch_cnt =
+			ieee80211_mle_get_bss_param_ch_cnt((const void *)elems->ml_basic);
+
+		if (bss_param_ch_cnt < 0) {
+			sdata_info(sdata,
+				   "No BSS parameter change count in assoc response\n");
+			ret = false;
+			goto out;
+		}
+		bss_conf->bss_param_ch_cnt = bss_param_ch_cnt;
+		bss_conf->bss_param_ch_cnt_link_id = link_id;
 	}
 
 	if (!is_s1g && !elems->supp_rates) {
-- 
2.34.1


