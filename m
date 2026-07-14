Return-Path: <linux-wireless+bounces-39026-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0VGwB+YTVmp1ywAAu9opvQ
	(envelope-from <linux-wireless+bounces-39026-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 12:48:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EB17538E2
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 12:48:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Mjlj0NdX;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39026-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39026-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68B6A31BE768
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 10:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F5537DEAD;
	Tue, 14 Jul 2026 10:43:54 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6024379C40
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 10:43:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025834; cv=none; b=TNr8AngbJGERB+uCrY/A636e4nYYA42HHwLWG1fppbnGkOMNDcHtXotletO8W4CXKPnm9f3DLa6M8BmomVpyiOJn4WAcIQnwAig8w/RIgixrnRFvmvkFQGiANcGf5d2aI2TvArGEgKvI6eOsQFok+2qln6ltUI0yBpWqjwx8Aq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025834; c=relaxed/simple;
	bh=sBbNxGtdvn04S9KqvwPLoEGZQ76NKDjfd/yo5JkdwsA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BDFLVNOxy+9xmUn25SE0EdMS/J1YxRB/OFHRomfb+2yNG4FxpeFOt7T4cZEEE3u1fDWlSoqCwBeULROynIp5nGXRd69WSIoNn+Nprz6qzpzQUr+QOPAtQJkdGUkhgHTfIQ9EkJMvD6miSOFOklTr5GrjcINOnU011vn/OSsOkQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mjlj0NdX; arc=none smtp.client-ip=198.175.65.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784025822; x=1815561822;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sBbNxGtdvn04S9KqvwPLoEGZQ76NKDjfd/yo5JkdwsA=;
  b=Mjlj0NdX6avALaIwcf+G+0ZtzruiebINSnz5RUjekjLKjGk/DQjqr7kl
   fgLVLkEEJlszd4A77UI8SclvCnVxjcypd8ogw8KkQXOB3pRbIdOsMjMEB
   RGYIyrco4csEk27N4Po8hbYO1Ltg6d/hebv8X5/pOgLFN3jEA+nj6o+af
   G7BQESdK8a7ZlcNX3uPL1nIeazpCQ6XmV7KS1ublcIDKy5hzXqf2vp+Rw
   Z0pqZUG0Gjdah1KlDMGuoyJkguSiir6RfAcs8DWWKntu/aysK1ZgIHq57
   337eNnZr1b5DwkllblWFvzUbKF/qWhCoiRUyx1+Zc+hgAI//ajFPNT6ux
   g==;
X-CSE-ConnectionGUID: yTxqkNp8QF6UgOf3ZdyYyQ==
X-CSE-MsgGUID: M40yIXdjTAygm/JqgV+IbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="84424420"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="84424420"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 03:43:42 -0700
X-CSE-ConnectionGUID: FBHifsM3R2a/VWeICSWBYg==
X-CSE-MsgGUID: yqftksACQSysarsdXidyoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="253199831"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 03:43:39 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 wireless-next 2/2] wifi: mac80211: parse enhanced critical updates field
Date: Tue, 14 Jul 2026 13:43:17 +0300
Message-Id: <20260714134154.adb9fc29252d.I625580fbadbbf4a1440d88d3675586477f1a3263@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714134154.e2fb22738aa1.Id86c1bd6ddb5ec13ad9cbf24fd36b8246f351fe6@changeid>
References: <20260714134154.e2fb22738aa1.Id86c1bd6ddb5ec13ad9cbf24fd36b8246f351fe6@changeid>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-39026-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[changeid:mid,intel.com:from_mime,intel.com:email,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 67EB17538E2

From: Johannes Berg <johannes.berg@intel.com>

For association and link reconfiguration response, parse
and store the enhanced BSS parameter change counter out
of the enhanced critical updates field in the multi-link
common info or per-STA profile. These are required for
UHR connections.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/linux/ieee80211-eht.h | 92 +++++++++++++++++++++++++++++++++++
 include/net/mac80211.h        |  6 +++
 net/mac80211/mlme.c           | 38 ++++++++++++++-
 3 files changed, 134 insertions(+), 2 deletions(-)

diff --git a/include/linux/ieee80211-eht.h b/include/linux/ieee80211-eht.h
index 18f9c662cf4c..928811328bb0 100644
--- a/include/linux/ieee80211-eht.h
+++ b/include/linux/ieee80211-eht.h
@@ -481,6 +481,7 @@ struct ieee80211_multi_link_elem {
 #define IEEE80211_MLC_BASIC_PRES_MLD_CAPA_OP		0x0100
 #define IEEE80211_MLC_BASIC_PRES_MLD_ID			0x0200
 #define IEEE80211_MLC_BASIC_PRES_EXT_MLD_CAPA_OP	0x0400
+#define IEEE80211_MLC_BASIC_PRES_ENH_CRIT_UPD		0x0800
 
 #define IEEE80211_MED_SYNC_DELAY_DURATION		0x00ff
 #define IEEE80211_MED_SYNC_DELAY_SYNC_OFDM_ED_THRESH	0x0f00
@@ -809,6 +810,49 @@ static inline u16 ieee80211_mle_get_ext_mld_capa_op(const u8 *data)
 	return get_unaligned_le16(common);
 }
 
+/**
+ * ieee80211_mle_get_enh_crit_upd_info - returns the enhanced critical
+ *	updates information
+ * @data: pointer to the multi-link element
+ * Return: the enhanced critical updates information field, or %NULL
+ *
+ * The element is assumed to be of the correct type (BASIC) and big enough,
+ * this must be checked using ieee80211_mle_type_ok().
+ */
+static inline const struct ieee80211_enh_crit_upd *
+ieee80211_mle_get_enh_crit_upd_info(const u8 *data)
+{
+	const struct ieee80211_multi_link_elem *mle = (const void *)data;
+	u16 control = le16_to_cpu(mle->control);
+	const u8 *common = mle->variable;
+
+	/*
+	 * common points now at the beginning of
+	 * ieee80211_mle_basic_common_info
+	 */
+	common += sizeof(struct ieee80211_mle_basic_common_info);
+
+	if (!(control & IEEE80211_MLC_BASIC_PRES_ENH_CRIT_UPD))
+		return NULL;
+
+	if (control & IEEE80211_MLC_BASIC_PRES_LINK_ID)
+		common += 1;
+	if (control & IEEE80211_MLC_BASIC_PRES_BSS_PARAM_CH_CNT)
+		common += 1;
+	if (control & IEEE80211_MLC_BASIC_PRES_MED_SYNC_DELAY)
+		common += 2;
+	if (control & IEEE80211_MLC_BASIC_PRES_EML_CAPA)
+		common += 2;
+	if (control & IEEE80211_MLC_BASIC_PRES_MLD_CAPA_OP)
+		common += 2;
+	if (control & IEEE80211_MLC_BASIC_PRES_MLD_ID)
+		common += 1;
+	if (control & IEEE80211_MLC_BASIC_PRES_EXT_MLD_CAPA_OP)
+		common += 2;
+
+	return (const void *)common;
+}
+
 /**
  * ieee80211_mle_get_mld_id - returns the MLD ID
  * @data: pointer to the multi-link element
@@ -883,6 +927,8 @@ static inline bool ieee80211_mle_size_ok(const u8 *data, size_t len)
 			common += 1;
 		if (control & IEEE80211_MLC_BASIC_PRES_EXT_MLD_CAPA_OP)
 			common += 2;
+		if (control & IEEE80211_MLC_BASIC_PRES_ENH_CRIT_UPD)
+			common += 1;
 		break;
 	case IEEE80211_ML_CONTROL_TYPE_PREQ:
 		common += sizeof(struct ieee80211_mle_preq_common_info);
@@ -959,6 +1005,8 @@ enum ieee80211_mle_subelems {
 #define IEEE80211_MLE_STA_CONTROL_NSTR_LINK_PAIR_PRESENT	0x0200
 #define IEEE80211_MLE_STA_CONTROL_NSTR_BITMAP_SIZE		0x0400
 #define IEEE80211_MLE_STA_CONTROL_BSS_PARAM_CHANGE_CNT_PRESENT	0x0800
+#define IEEE80211_MLE_STA_CONTROL_ENH_CRIT_UPD_PRESENT		0x1000
+#define IEEE80211_MLE_STA_CONTROL_AP_CONDUCTED_TX_PWR_PRESENT	0x2000
 
 struct ieee80211_mle_per_sta_profile {
 	__le16 control;
@@ -1004,6 +1052,12 @@ static inline bool ieee80211_mle_basic_sta_prof_size_ok(const u8 *data,
 	if (control & IEEE80211_MLE_STA_CONTROL_BSS_PARAM_CHANGE_CNT_PRESENT)
 		info_len += 1;
 
+	if (control & IEEE80211_MLE_STA_CONTROL_ENH_CRIT_UPD_PRESENT)
+		info_len += 1;
+
+	if (control & IEEE80211_MLE_STA_CONTROL_AP_CONDUCTED_TX_PWR_PRESENT)
+		info_len += 1;
+
 	return prof->sta_info_len >= info_len &&
 	       fixed + prof->sta_info_len - 1 <= len;
 }
@@ -1044,6 +1098,44 @@ ieee80211_mle_basic_sta_prof_bss_param_ch_cnt(const struct ieee80211_mle_per_sta
 	return *pos;
 }
 
+/**
+ * ieee80211_mle_basic_sta_prof_enh_crit_upd - get per-STA profile enhanced
+ *	critical updates field
+ * @prof: the per-STA profile, having been checked with
+ *	ieee80211_mle_basic_sta_prof_size_ok() for the correct length
+ *
+ * Return: The enhanced critical updates field if present, %NULL otherwise.
+ */
+static inline const struct ieee80211_enh_crit_upd *
+ieee80211_mle_basic_sta_prof_enh_crit_upd(const struct ieee80211_mle_per_sta_profile *prof)
+{
+	u16 control = le16_to_cpu(prof->control);
+	const u8 *pos = prof->variable;
+
+	if (!(control & IEEE80211_MLE_STA_CONTROL_ENH_CRIT_UPD_PRESENT))
+		return NULL;
+
+	if (control & IEEE80211_MLE_STA_CONTROL_STA_MAC_ADDR_PRESENT)
+		pos += 6;
+	if (control & IEEE80211_MLE_STA_CONTROL_BEACON_INT_PRESENT)
+		pos += 2;
+	if (control & IEEE80211_MLE_STA_CONTROL_TSF_OFFS_PRESENT)
+		pos += 8;
+	if (control & IEEE80211_MLE_STA_CONTROL_DTIM_INFO_PRESENT)
+		pos += 2;
+	if (control & IEEE80211_MLE_STA_CONTROL_COMPLETE_PROFILE &&
+	    control & IEEE80211_MLE_STA_CONTROL_NSTR_LINK_PAIR_PRESENT) {
+		if (control & IEEE80211_MLE_STA_CONTROL_NSTR_BITMAP_SIZE)
+			pos += 2;
+		else
+			pos += 1;
+	}
+	if (control & IEEE80211_MLE_STA_CONTROL_BSS_PARAM_CHANGE_CNT_PRESENT)
+		pos += 1;
+
+	return (const void *)pos;
+}
+
 #define IEEE80211_MLE_STA_RECONF_CONTROL_LINK_ID			0x000f
 #define IEEE80211_MLE_STA_RECONF_CONTROL_COMPLETE_PROFILE		0x0010
 #define IEEE80211_MLE_STA_RECONF_CONTROL_STA_MAC_ADDR_PRESENT		0x0020
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 4f95da023746..948a7cdab27c 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -790,6 +790,10 @@ struct ieee80211_bss_npca_params {
  *	be updated to 1, even if bss_param_ch_cnt didn't change. This allows
  *	the link to know that it heard the latest value from its own beacon
  *	(as opposed to hearing its value from another link's beacon).
+ * @enh_bss_param_ch_cnt: In BSS-mode, the enhanced BSS parameters change
+ *	counter. See @bss_param_ch_cnt, it works the same way.
+ * @enh_bss_param_ch_cnt_link_id: In BSS-mode, the link_id for the enhanced
+ *	BSS parameter change counter, see @bss_param_ch_cnt_link_id.
  * @s1g_long_beacon_period: number of beacon intervals between each long
  *	beacon transmission.
  * @npca: NPCA parameters
@@ -894,6 +898,8 @@ struct ieee80211_bss_conf {
 
 	u8 bss_param_ch_cnt;
 	u8 bss_param_ch_cnt_link_id;
+	u8 enh_bss_param_ch_cnt;
+	u8 enh_bss_param_ch_cnt_link_id;
 
 	u8 s1g_long_beacon_period;
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index f1172a950284..5827a34ba6a7 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5925,11 +5925,28 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 			ieee80211_mle_basic_sta_prof_bss_param_ch_cnt(elems->prof);
 		bss_conf->bss_param_ch_cnt = bss_param_ch_cnt;
 		bss_conf->bss_param_ch_cnt_link_id = link_id;
+
+		if (link->u.mgd.conn.mode >= IEEE80211_CONN_MODE_UHR) {
+			const struct ieee80211_enh_crit_upd *enh_crit_upd;
+
+			enh_crit_upd = ieee80211_mle_basic_sta_prof_enh_crit_upd(elems->prof);
+			if (!enh_crit_upd) {
+				link_info(link,
+					  "per-STA profile missing enhanced critical updates\n");
+				ret = false;
+				goto out;
+			}
+
+			bss_conf->enh_bss_param_ch_cnt =
+				u8_get_bits(enh_crit_upd->v,
+					    IEEE80211_ENH_CRIT_UPD_EBPCC);
+			bss_conf->enh_bss_param_ch_cnt_link_id = link_id;
+		}
 	}
 
 	if (link_id == assoc_data->assoc_link_id && elems->ml_basic) {
-		int bss_param_ch_cnt =
-			ieee80211_mle_get_bss_param_ch_cnt((const void *)elems->ml_basic);
+		const void *mle = (const void *)elems->ml_basic;
+		int bss_param_ch_cnt = ieee80211_mle_get_bss_param_ch_cnt(mle);
 
 		if (bss_param_ch_cnt < 0) {
 			sdata_info(sdata,
@@ -5939,6 +5956,23 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 		}
 		bss_conf->bss_param_ch_cnt = bss_param_ch_cnt;
 		bss_conf->bss_param_ch_cnt_link_id = link_id;
+
+		if (link->u.mgd.conn.mode >= IEEE80211_CONN_MODE_UHR) {
+			const struct ieee80211_enh_crit_upd *enh_crit_upd;
+
+			enh_crit_upd = ieee80211_mle_get_enh_crit_upd_info(mle);
+			if (!enh_crit_upd) {
+				link_info(link,
+					  "No enhanced critical updates in assoc response\n");
+				ret = false;
+				goto out;
+			}
+
+			bss_conf->enh_bss_param_ch_cnt =
+				u8_get_bits(enh_crit_upd->v,
+					    IEEE80211_ENH_CRIT_UPD_EBPCC);
+			bss_conf->enh_bss_param_ch_cnt_link_id = link_id;
+		}
 	}
 
 	if (!is_s1g && !elems->supp_rates) {
-- 
2.34.1


