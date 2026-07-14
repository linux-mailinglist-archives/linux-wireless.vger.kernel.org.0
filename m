Return-Path: <linux-wireless+bounces-39025-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yvpNIPASVmo1ywAAu9opvQ
	(envelope-from <linux-wireless+bounces-39025-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 12:44:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0642C753811
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 12:44:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Gurc3jYB;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39025-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39025-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5141430538EB
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 10:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F0037268B;
	Tue, 14 Jul 2026 10:43:42 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DD537D123
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 10:43:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025821; cv=none; b=JWukSVZm2SMWx1AclBix4Fi4hiDXdSIWz4d8h4x1ydyBpTKhm7B1+D8xWLJX9RyVBT9SV/Ed1EjF7STB3AyeJr0d2VNJr/3EI9bL+ENx/U3GPrHoBbJ0ImSYAMPxXpMhPl1w4xH02wfUBYaPasyY+iQAJUqXGudNwU4A1Ha5n6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025821; c=relaxed/simple;
	bh=mqs5eC0uxbyWnrfb3KJu3D71oE3H4m3l91Q8XxJ2vfw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s8B/YAY68odgAgxg8/Ksj9WWMTTowm+OtjGjvhNTyojcC6/LUnw7TI/LYox1oUb6MXZb6i7flWu4YGkmji4rbAMIId+rVmY1TDnO0nYhR4HaSmyKSlQgjF3GEUOUx76PJPDG8RH7oxcLG804IXF9A3JJHmMcUPWZcy+AXtFUJ7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gurc3jYB; arc=none smtp.client-ip=198.175.65.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784025820; x=1815561820;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mqs5eC0uxbyWnrfb3KJu3D71oE3H4m3l91Q8XxJ2vfw=;
  b=Gurc3jYB0iPi/XDEJNMUl/Ii0jGGN7s0RC/Mdq4cCs08ykHDCUr/IYDn
   MD06dktGYCWdVfHCURBobKQTaMyjOTFf3Tm4cVqQ57W67ZS9FkqaUy1f9
   ByvCpLv2EK5OZ4ymimNPdRKOawr+jlc0wtgAPm7BAyquO3xZ7Qtyb88ZQ
   MfDhR+o/LZhmPfbl+lZWtYOy/wlo+fEeJ4uyjB82nGrnZWDMNob4DNGfK
   KK/bSMEjqOJX2AJ2M3K3CkQvBXs5/rsaCD1zgyaEo+tCcAFi1IikrJbHj
   3l5LSiT3GpbVXyrXjVCdWHY8Pjn818+rbBRpgTqnuvHRHOuWGIPar4sJW
   Q==;
X-CSE-ConnectionGUID: ZEs6hBj/SB2dCM8BWKEQEQ==
X-CSE-MsgGUID: 4kpefUzaTt2ZO1i96kS9Yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="84424416"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="84424416"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 03:43:40 -0700
X-CSE-ConnectionGUID: XD4508NwSfeAGD431YLYJg==
X-CSE-MsgGUID: LY7IeTnXQF+nCDcCV4mt7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="253199817"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 03:43:38 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 wireless-next 1/2] wifi: mac80211: refactor multi-link assoc response parsing
Date: Tue, 14 Jul 2026 13:43:16 +0300
Message-Id: <20260714134154.e2fb22738aa1.Id86c1bd6ddb5ec13ad9cbf24fd36b8246f351fe6@changeid>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-39025-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:from_mime,intel.com:email,intel.com:dkim,changeid:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0642C753811

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

---
v2: add another patch which is dependent on this one
---

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


