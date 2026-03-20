Return-Path: <linux-wireless+bounces-33563-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGksOmsBvWkO5gIAu9opvQ
	(envelope-from <linux-wireless+bounces-33563-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 09:12:27 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B96A32D6FB8
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 09:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 50AD63040131
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 08:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C7E3783C2;
	Fri, 20 Mar 2026 08:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A03trHjp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FA5377EC0
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 08:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994175; cv=none; b=k6Duyb9RHM+UVdl1xpWmuzGqwS/owF6G7EsWdDbMY3+6oieF7/TovNpD8q6VqyV91ybUXOE/H0hMin24pIvsEdA0jw3lnW/Nbnt85DKIKUkgjIAzmBf1NjAv3SSZEhvUOdgZkphUs+dALr4RLf9E+NDQbEPZ18qFlhrO+H73dTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994175; c=relaxed/simple;
	bh=+P0y4c2lCWkHx+BgaE+mwAo7H+Jvseg8H7uFrsT1GMU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZmVVnTPHTAyyLD0ZGIK2SKD/hBexMNhy6Q9JQ+XWCAbnADT5s8FK7MOiqgc8wO5o7ihk17rrnWidQ7WjSC7S0ntr5SxEzcjFeW5Dw693QSvBmF6q0zECBASBtJ2z2MAdRPlLPMe5Y2/HH54OR4HRfF1aILFB1iscYbm0IQA8dkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A03trHjp; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773994174; x=1805530174;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+P0y4c2lCWkHx+BgaE+mwAo7H+Jvseg8H7uFrsT1GMU=;
  b=A03trHjpgVhFjYvfLP21V8huKzur5fzkudPCOP0BAUpHBDPAp6UxxJLF
   86t04bHTG8k8gLhskJtVw+U8/Odz2vIJtRRIO5SlRUX6FIqxWwq4tzdv+
   dsOtlVGl3kB9IW+BFlvk3m70DJbhf2neKAElVUqzouotcY8FNFbURy4dW
   nj2zQ0pW73M9+dVY4f0Z6IHeeSQnqJVyO1zLo5+nl7SjMjwttNRfU9Ohh
   ZOj3yu8GFQ7r3jiM6eWpyIpbwfscX3dPMfJN3bF1mM0abs3n2jjEzIGad
   tC7aCmgl7crj6kK4a5pwB3nQ6JpI0epqidIe2/gnNuY6gR7Jo22RKc/Qg
   w==;
X-CSE-ConnectionGUID: AmW/vzVPQzKvum65E/eAPA==
X-CSE-MsgGUID: bfY7WTkARXCpabr8j7u+xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="86154108"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="86154108"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:09:32 -0700
X-CSE-ConnectionGUID: TQtpihLvSN6HznXSHsypZg==
X-CSE-MsgGUID: 14QsJwJKQuiAkx1hxdkkqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="227692551"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:09:31 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 01/15] wifi: iwlwifi: mld: enable UHR in TLC
Date: Fri, 20 Mar 2026 10:09:04 +0200
Message-Id: <20260320100746.7117009d7c39.If4e8cdc63fdf4c5f14d923a5c59fb7b43df72a67@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320080918.2567780-1-miriam.rachel.korenblit@intel.com>
References: <20260320080918.2567780-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33563-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B96A32D6FB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

Tell the firmware if UHR is supported, including ELR (enhanced
long range) MCS support.

Note that the spec currently doesn't differentiate between 1.5
and 3 Mbps ELR MCSes, unlike the firmware.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/tlc.c | 28 +++++++++++++++++---
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tlc.c b/drivers/net/wireless/intel/iwlwifi/mld/tlc.c
index 62a54c37a98c..ede385909e38 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tlc.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tlc.c
@@ -36,7 +36,8 @@ iwl_mld_get_tlc_cmd_flags(struct iwl_mld *mld,
 			  struct ieee80211_vif *vif,
 			  struct ieee80211_link_sta *link_sta,
 			  const struct ieee80211_sta_he_cap *own_he_cap,
-			  const struct ieee80211_sta_eht_cap *own_eht_cap)
+			  const struct ieee80211_sta_eht_cap *own_eht_cap,
+			  const struct ieee80211_sta_uhr_cap *own_uhr_cap)
 {
 	struct ieee80211_sta_ht_cap *ht_cap = &link_sta->ht_cap;
 	struct ieee80211_sta_vht_cap *vht_cap = &link_sta->vht_cap;
@@ -90,6 +91,12 @@ iwl_mld_get_tlc_cmd_flags(struct iwl_mld *mld,
 		flags |= IWL_TLC_MNG_CFG_FLAGS_EHT_EXTRA_LTF_MSK;
 	}
 
+	if (link_sta->uhr_cap.has_uhr && own_uhr_cap &&
+	    link_sta->uhr_cap.phy.cap & IEEE80211_UHR_PHY_CAP_ELR_RX &&
+	    own_uhr_cap->phy.cap & IEEE80211_UHR_PHY_CAP_ELR_TX)
+		flags |= IWL_TLC_MNG_CFG_FLAGS_UHR_ELR_1_5_MBPS_MSK |
+			 IWL_TLC_MNG_CFG_FLAGS_UHR_ELR_3_MBPS_MSK;
+
 	return cpu_to_le16(flags);
 }
 
@@ -406,6 +413,7 @@ iwl_mld_fill_supp_rates(struct iwl_mld *mld, struct ieee80211_vif *vif,
 			struct ieee80211_supported_band *sband,
 			const struct ieee80211_sta_he_cap *own_he_cap,
 			const struct ieee80211_sta_eht_cap *own_eht_cap,
+			const struct ieee80211_sta_uhr_cap *own_uhr_cap,
 			struct iwl_tlc_config_cmd *cmd)
 {
 	int i;
@@ -423,7 +431,16 @@ iwl_mld_fill_supp_rates(struct iwl_mld *mld, struct ieee80211_vif *vif,
 	cmd->non_ht_rates = cpu_to_le16(non_ht_rates);
 	cmd->mode = IWL_TLC_MNG_MODE_NON_HT;
 
-	if (link_sta->eht_cap.has_eht && own_he_cap && own_eht_cap) {
+	if (link_sta->uhr_cap.has_uhr && own_uhr_cap) {
+		cmd->mode = IWL_TLC_MNG_MODE_UHR;
+		/*
+		 * FIXME: spec currently inherits from EHT but has no
+		 * finer MCS bits. Once that's there, need to add them
+		 * to the bitmaps (and maybe copy this to UHR, or so.)
+		 */
+		iwl_mld_fill_eht_rates(vif, link_sta, own_he_cap,
+				       own_eht_cap, cmd);
+	} else if (link_sta->eht_cap.has_eht && own_he_cap && own_eht_cap) {
 		cmd->mode = IWL_TLC_MNG_MODE_EHT;
 		iwl_mld_fill_eht_rates(vif, link_sta, own_he_cap,
 				       own_eht_cap, cmd);
@@ -519,13 +536,16 @@ static void iwl_mld_send_tlc_cmd(struct iwl_mld *mld,
 		ieee80211_get_he_iftype_cap_vif(sband, vif);
 	const struct ieee80211_sta_eht_cap *own_eht_cap =
 		ieee80211_get_eht_iftype_cap_vif(sband, vif);
+	const struct ieee80211_sta_uhr_cap *own_uhr_cap =
+		ieee80211_get_uhr_iftype_cap_vif(sband, vif);
 	struct iwl_tlc_config_cmd cmd = {
 		/* For AP mode, use 20 MHz until the STA is authorized */
 		.max_ch_width = mld_sta->sta_state > IEEE80211_STA_ASSOC ?
 			iwl_mld_fw_bw_from_sta_bw(link_sta) :
 			IWL_TLC_MNG_CH_WIDTH_20MHZ,
 		.flags = iwl_mld_get_tlc_cmd_flags(mld, vif, link_sta,
-						   own_he_cap, own_eht_cap),
+						   own_he_cap, own_eht_cap,
+						   own_uhr_cap),
 		.chains = iwl_mld_get_fw_chains(mld),
 		.sgi_ch_width_supp = iwl_mld_get_fw_sgi(link_sta),
 		.max_mpdu_len = cpu_to_le16(link_sta->agg.max_amsdu_len),
@@ -555,7 +575,7 @@ static void iwl_mld_send_tlc_cmd(struct iwl_mld *mld,
 
 	iwl_mld_fill_supp_rates(mld, vif, link_sta, sband,
 				own_he_cap, own_eht_cap,
-				&cmd);
+				own_uhr_cap, &cmd);
 
 	if (cmd_ver == 6) {
 		cmd_ptr = &cmd;
-- 
2.34.1


