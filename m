Return-Path: <linux-wireless+bounces-36367-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UN0MIB8QBGoMDAIAu9opvQ
	(envelope-from <linux-wireless+bounces-36367-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 07:46:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D28E352DB45
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 07:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 426E030BB748
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 05:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A95A3A6EEC;
	Wed, 13 May 2026 05:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZfzCQT2r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBCD3A6EEE
	for <linux-wireless@vger.kernel.org>; Wed, 13 May 2026 05:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778651071; cv=none; b=Lxq5CDSJpU3Efh1HhlCrY+RFBdjZCpaSsTu95QvDmTBDS/rKy/HiMmRtEs835gdGKsUGnbZnHD5mdDsZt5VXWyBeufeNOd+3gfZmxgmL14j8v3FfLRYdR7hAqnAGiRwPmJQBzVlUXcnlit11yr81MAXkUMunWAwrBUilSrOnLmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778651071; c=relaxed/simple;
	bh=O92nAE98UPPJr8XOS7tH1ppqAw60hwfnt6RHEDtYlPU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p4D8j2/ddcQLJ8ru9lPF9+nI8Urm5uapVIhrXHwGEzkm8QIduNdOSnbFsoGmmDZgZf9BTZZ01xuaniyAyVuJaJkoTqNWCcuUB4nLwyJE79p2Wj1tf3oPe94ZVRmP8ZBC+OI1/o0eH9cSMByMm4eRF8xQT/z7ZV/gpuhbkWWr2nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZfzCQT2r; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778651070; x=1810187070;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O92nAE98UPPJr8XOS7tH1ppqAw60hwfnt6RHEDtYlPU=;
  b=ZfzCQT2rIbfUtU/AjKFGN2GoPxvojmzaNXo9EOOOt2GgmODNrABw2Owe
   JJ23cKF2J7amTTnsJR5gP+h683C9O9HIdhX0lpJe5ZhLPIW7dTSmjhO1l
   HQRNI9zNfhUxBrbXfO2a32dWaZXQfKnI3VmpBQfgIf0S246drhp9M0dVY
   UWjmMn2BXhlxc2V1z76w8hf1XIuBL/gw3JGb5Rrl8C+0VDUo7eEe5QwRp
   RW5JA2Jy578xp2OcqCQf9FwJsMHWGpE9K64Uhmy68S+c6lyQPD6oeNrzt
   uhixxqtG9LAxxpUjbSW5++a6AjRVXAiNeIUszuDqUrbfZQsPj/iRRw6oa
   Q==;
X-CSE-ConnectionGUID: 34pVlsQCTju2wyG/x63hjA==
X-CSE-MsgGUID: bxHQQgNoRd2/xBb1Bznncg==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79552838"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="79552838"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 22:44:28 -0700
X-CSE-ConnectionGUID: sk4GPB4ESwyOJ/M7/HpdgA==
X-CSE-MsgGUID: TWrWJqhJQy2flaGppqibcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="238077937"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 22:44:26 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Avinash Bhatt <avinash.bhatt@intel.com>
Subject: [PATCH iwlwifi-next 09/15] wifi: iwlwifi: mld: implement PSD/EIRP RSSI adjustment
Date: Wed, 13 May 2026 08:43:56 +0300
Message-Id: <20260513084215.ff1c5ba7491f.I2403678e34625809a7edf02f18760eda16a2c906@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260513054402.2897702-1-miriam.rachel.korenblit@intel.com>
References: <20260513054402.2897702-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D28E352DB45
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36367-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Avinash Bhatt <avinash.bhatt@intel.com>

APs operating in PSD mode increase transmit power with bandwidth,
requiring RSSI compensation for accurate link grading.

Parse TPE elements to determine power mode and apply RSSI adjustment
based on operational bandwidth and power constraints.

Signed-off-by: Avinash Bhatt <avinash.bhatt@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/link.c | 143 ++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.c b/drivers/net/wireless/intel/iwlwifi/mld/link.c
index 785459937fbe..70965627e2dd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.c
@@ -972,6 +972,145 @@ iwl_mld_get_dup_beacon_rssi_adjust(struct iwl_mld *mld,
 	}
 }
 
+static s8 iwl_mld_get_primary_psd(const struct ieee80211_parsed_tpe_psd *psd,
+				  const struct cfg80211_chan_def *chandef,
+				  int bw_mhz)
+{
+	int start_freq, primary_idx;
+
+	if (!psd->valid)
+		return S8_MAX;
+
+	start_freq = chandef->center_freq1 - (bw_mhz / 2);
+	primary_idx = (chandef->chan->center_freq - start_freq - 10) / 20;
+
+	if (primary_idx < 0 || primary_idx >= psd->count)
+		return S8_MAX;
+
+	/* TPE element stores PSD limit as value * 2 */
+	return psd->power[primary_idx] / 2;
+}
+
+static s8 iwl_mld_get_psd_eirp_rssi_adjust(struct ieee80211_bss_conf *link_conf)
+{
+	const struct ieee80211_parsed_tpe *tpe = &link_conf->tpe;
+	s8 psd_20mhz, psd_oper, psd_local, psd_reg, psd_boost;
+	s8 min_20mhz, min_oper, adjustment, ap_power_limit;
+	s8 psd_avg_local = S8_MAX, psd_avg_reg = S8_MAX;
+	s8 eirp_20mhz, eirp_oper, eirp_local, eirp_reg;
+	int bw_mhz, num_subchans;
+	u8 bw_index;
+
+	/* PSD/EIRP adjustment is only specific to 6 GHz */
+	if (WARN_ONCE(link_conf->chanreq.oper.chan->band != NL80211_BAND_6GHZ,
+		      "PSD/EIRP adjustment called for non-6 GHz band %d\n",
+		      link_conf->chanreq.oper.chan->band))
+		return 0;
+
+	bw_mhz = nl80211_chan_width_to_mhz(link_conf->chanreq.oper.width);
+
+	switch (bw_mhz) {
+	case 20:
+		bw_index = 0;
+		break;
+	case 40:
+		bw_index = 1;
+		break;
+	case 80:
+		bw_index = 2;
+		break;
+	case 160:
+		bw_index = 3;
+		break;
+	case 320:
+		bw_index = 4;
+		break;
+	default:
+		WARN_ONCE(1, "Unexpected bandwidth: %d MHz\n", bw_mhz);
+		return 0;
+	}
+
+	if (link_conf->power_type == IEEE80211_REG_VLP_AP)
+		ap_power_limit = 14;
+	else
+		ap_power_limit = 23;
+
+	/* Primary 20 MHz PSD */
+	psd_local = iwl_mld_get_primary_psd(&tpe->psd_local[0],
+					    &link_conf->chanreq.oper,
+					    bw_mhz);
+	psd_reg = iwl_mld_get_primary_psd(&tpe->psd_reg_client[0],
+					  &link_conf->chanreq.oper,
+					  bw_mhz);
+	psd_20mhz = min(psd_local, psd_reg);
+
+	/* TPE element stores EIRP limit as value * 2 */
+	eirp_local = (tpe->max_local[0].valid && tpe->max_local[0].count > 0) ?
+			tpe->max_local[0].power[0] / 2 : S8_MAX;
+	eirp_reg = (tpe->max_reg_client[0].valid &&
+		    tpe->max_reg_client[0].count > 0) ?
+		      tpe->max_reg_client[0].power[0] / 2 : S8_MAX;
+	eirp_20mhz = min(eirp_local, eirp_reg);
+
+	num_subchans = bw_mhz / 20;
+
+	if (tpe->psd_local[0].valid) {
+		int sum_local = 0, valid_local = 0;
+		int count_local = min(num_subchans, tpe->psd_local[0].count);
+
+		for (int i = 0; i < count_local; i++) {
+			if (tpe->psd_local[0].power[i] != S8_MIN) {
+				sum_local += tpe->psd_local[0].power[i];
+				valid_local++;
+			}
+		}
+		/* TPE element stores PSD limit as value * 2 */
+		if (valid_local > 0)
+			psd_avg_local = sum_local / valid_local / 2;
+	}
+
+	if (tpe->psd_reg_client[0].valid) {
+		int sum_reg = 0, valid_reg = 0;
+		int count_reg = min(num_subchans, tpe->psd_reg_client[0].count);
+
+		for (int i = 0; i < count_reg; i++) {
+			if (tpe->psd_reg_client[0].power[i] != S8_MIN) {
+				sum_reg +=
+					tpe->psd_reg_client[0].power[i];
+				valid_reg++;
+			}
+		}
+		/* TPE element stores PSD limit as value * 2 */
+		if (valid_reg > 0)
+			psd_avg_reg = sum_reg / valid_reg / 2;
+	}
+
+	psd_oper = min(psd_avg_local, psd_avg_reg);
+
+	/* TPE element stores EIRP limit as value * 2 */
+	eirp_local = (tpe->max_local[0].valid &&
+		      tpe->max_local[0].count > bw_index) ?
+			tpe->max_local[0].power[bw_index] / 2 : S8_MAX;
+	eirp_reg = (tpe->max_reg_client[0].valid &&
+		    tpe->max_reg_client[0].count > bw_index) ?
+		      tpe->max_reg_client[0].power[bw_index] / 2 : S8_MAX;
+	eirp_oper = min(eirp_local, eirp_reg);
+
+	min_20mhz = min(ap_power_limit, min(eirp_20mhz, psd_20mhz));
+
+	/* PSD boost: 10*log10(BW/20) approximated as 3*ilog2(BW/20) */
+	psd_boost = 3 * ilog2(bw_mhz / 20);
+
+	/* Use int for psd_oper + psd_boost to prevent s8 overflow */
+	min_oper = min(ap_power_limit,
+		       min(eirp_oper,
+			   (s8)min_t(int, psd_oper + psd_boost, S8_MAX)));
+
+	adjustment = max(min_oper - min_20mhz, 0);
+
+	return adjustment;
+}
+
 /* This function calculates the grade of a link. Returns 0 in error case */
 unsigned int iwl_mld_get_link_grade(struct iwl_mld *mld,
 				    struct ieee80211_bss_conf *link_conf)
@@ -1000,6 +1139,10 @@ unsigned int iwl_mld_get_link_grade(struct iwl_mld *mld,
 		s8 rssi_adj_6g =
 			iwl_mld_get_dup_beacon_rssi_adjust(mld, link_conf);
 
+		if (!rssi_adj_6g)
+			rssi_adj_6g =
+				iwl_mld_get_psd_eirp_rssi_adjust(link_conf);
+
 		if (!rssi_adj_6g)
 			rssi_adj_6g = 4;
 
-- 
2.34.1


