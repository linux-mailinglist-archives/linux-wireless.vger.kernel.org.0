Return-Path: <linux-wireless+bounces-39034-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BIblFukbVmoTzQAAu9opvQ
	(envelope-from <linux-wireless+bounces-39034-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 13:22:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A02C1753DA2
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 13:22:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=K1e7uTyU;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39034-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39034-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36F3D3155198
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 11:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9A2377559;
	Tue, 14 Jul 2026 11:20:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BC8363C60
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 11:20:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784028035; cv=none; b=iwTFIgiV8QW+L0It07RhJO4l9nFy0o5Wjb81lVH0Kz2ew+31QjSLShbAwsup8kLQthjZ3O0BKh7aPeCEwtzCiN+Pv1XrlSkB2IAqf3qZLmuThUus88jjPFouWXCynFZWzB1+a9eQuKx3B5x8VeKdaJ9HxPLv4R4u0fO6q4TTKvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784028035; c=relaxed/simple;
	bh=Cc7l79NrUNP0SHLwpPaMTdp/TD4PTtToZifJnazIGEc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qAzENHZNmAHQEyoGeFLIXDq9X+RPOL9GqR8tR3MukusGPD9dHOjjqnIIMGC7JSKPklR9KSS498kv0WOyNOXzWSOa3KyHRJPjSPGrswuKOiVWrTba7OP8wgxW4o/9ILCh66uJr/fm/PINgcs0aCzx9CFN5SYrJf5zjyUDh9dlGss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K1e7uTyU; arc=none smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784028034; x=1815564034;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cc7l79NrUNP0SHLwpPaMTdp/TD4PTtToZifJnazIGEc=;
  b=K1e7uTyUJ+v4DBw/JDZYddN8iZkwmy11k5pXrP10AEbFOkmQdcUGDulu
   mxH+wlNdQF001rmk7mwApdgALzrrnp+hsYwKrayGwxdvff5Cupzj9pUIz
   MRRFdMatkjez5d3+GASnVgQHjTpebj3WFJDhuX/rLFII/h9aELBN6ZFwl
   ryIZRLCmupcVhe+f2fGOzAupqQSWG+pE5x3QSTejVyxOXawG9GMgZ2pSP
   5Btn60bR8V9CLxOSfXao5OE3ow+EAhhFo2WfpZQFsbPhXKeN5ZhGruT4O
   PVn1KauG++vE3beQmZNphYGQXMlb2WbW8o107EvOaF4wmEdLGMYmSj2fp
   Q==;
X-CSE-ConnectionGUID: w7BMZB+sQBuoOkDFBRbBWA==
X-CSE-MsgGUID: PdxjFZXxTxWW2b/R6SeGgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="102200310"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="102200310"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 04:20:34 -0700
X-CSE-ConnectionGUID: seQpzcRPTp6FmqSJ52UMRw==
X-CSE-MsgGUID: IL9XPBSDTzGBn1KJko7hnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="280250169"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 04:20:33 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-fixes 07/15] wifi: iwlwifi: mvm: parse beacon notif per layout
Date: Tue, 14 Jul 2026 14:19:56 +0300
Message-Id: <20260714141909.cc8aa937f8e5.I921f8dadcb20cb73e8283e1b8546e1778205411f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714141909.fdf31f494f1c.I70d01ed2023f6584fb23ea8ab344a93d222cc4c0@changeid>
References: <20260714141909.fdf31f494f1c.I70d01ed2023f6584fb23ea8ab344a93d222cc4c0@changeid>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-39034-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:emmanuel.grumbach@intel.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:from_mime,intel.com:email,intel.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A02C1753DA2

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

The beacon TX notification can arrive in different layouts, and fields
must be read only after selecting the expected format.

Parse gp2 and TSF from the matching notification structure in each
branch, and keep using the parsed gp2 for CSA countdown and debug output.
Drop the obsolete cached gp2 field.

Assisted-by: GitHub Copilot:gpt-5.3-codex
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 25 +++++++++++--------
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  1 -
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  3 ---
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index d6a8624b1ae5..b2c5be22c293 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1493,49 +1493,54 @@ void iwl_mvm_rx_beacon_notif(struct iwl_mvm *mvm,
 {
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
 	unsigned int pkt_len = iwl_rx_packet_payload_len(pkt);
-	struct iwl_extended_beacon_notif *beacon = (void *)pkt->data;
-	struct iwl_extended_beacon_notif_v5 *beacon_v5 = (void *)pkt->data;
 	struct ieee80211_vif *csa_vif;
 	struct ieee80211_vif *tx_blocked_vif;
 	struct agg_tx_status *agg_status;
+	u32 beacon_gp2;
 	u16 status;
 
 	lockdep_assert_held(&mvm->mutex);
 
-	mvm->ap_last_beacon_gp2 = le32_to_cpu(beacon->gp2);
-
 	if (!iwl_mvm_is_short_beacon_notif_supported(mvm)) {
+		struct iwl_extended_beacon_notif_v5 *beacon = (void *)pkt->data;
 		struct iwl_tx_resp *beacon_notify_hdr =
-			&beacon_v5->beacon_notify_hdr;
+			&beacon->beacon_notify_hdr;
 
-		if (unlikely(pkt_len < sizeof(*beacon_v5)))
+		if (unlikely(pkt_len < sizeof(*beacon)))
 			return;
 
-		mvm->ibss_manager = beacon_v5->ibss_mgr_status != 0;
+		beacon_gp2 = le32_to_cpu(beacon->gp2);
+
+		mvm->ibss_manager = beacon->ibss_mgr_status != 0;
 		agg_status = iwl_mvm_get_agg_status(mvm, beacon_notify_hdr);
 		status = le16_to_cpu(agg_status->status) & TX_STATUS_MSK;
 		IWL_DEBUG_RX(mvm,
 			     "beacon status %#x retries:%d tsf:0x%016llX gp2:0x%X rate:%d\n",
 			     status, beacon_notify_hdr->failure_frame,
 			     le64_to_cpu(beacon->tsf),
-			     mvm->ap_last_beacon_gp2,
+			     beacon_gp2,
 			     le32_to_cpu(beacon_notify_hdr->initial_rate));
 	} else {
+		const struct iwl_extended_beacon_notif *beacon =
+			(void *)pkt->data;
+
 		if (unlikely(pkt_len < sizeof(*beacon)))
 			return;
 
+		beacon_gp2 = le32_to_cpu(beacon->gp2);
+
 		mvm->ibss_manager = beacon->ibss_mgr_status != 0;
 		status = le32_to_cpu(beacon->status) & TX_STATUS_MSK;
 		IWL_DEBUG_RX(mvm,
 			     "beacon status %#x tsf:0x%016llX gp2:0x%X\n",
 			     status, le64_to_cpu(beacon->tsf),
-			     mvm->ap_last_beacon_gp2);
+			     beacon_gp2);
 	}
 
 	csa_vif = rcu_dereference_protected(mvm->csa_vif,
 					    lockdep_is_held(&mvm->mutex));
 	if (unlikely(csa_vif && csa_vif->bss_conf.csa_active))
-		iwl_mvm_csa_count_down(mvm, csa_vif, mvm->ap_last_beacon_gp2,
+		iwl_mvm_csa_count_down(mvm, csa_vif, beacon_gp2,
 				       (status == TX_STATUS_SUCCESS));
 
 	tx_blocked_vif = rcu_dereference_protected(mvm->csa_tx_blocked_vif,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 48cc10db7b96..f4f4446bef54 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3061,7 +3061,6 @@ void iwl_mvm_stop_ap_ibss_common(struct iwl_mvm *mvm,
 	}
 
 	mvmvif->ap_ibss_active = false;
-	mvm->ap_last_beacon_gp2 = 0;
 
 	if (vif->type == NL80211_IFTYPE_AP && !vif->p2p) {
 		iwl_mvm_vif_set_low_latency(mvmvif, false,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 683cac56822c..31912f4d0175 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1168,9 +1168,6 @@ struct iwl_mvm {
 	struct ieee80211_vif __rcu *csa_tx_blocked_vif;
 	u8 csa_tx_block_bcn_timeout;
 
-	/* system time of last beacon (for AP/GO interface) */
-	u32 ap_last_beacon_gp2;
-
 	/* indicates that we transmitted the last beacon */
 	bool ibss_manager;
 
-- 
2.34.1


