Return-Path: <linux-wireless+bounces-39040-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iW7nLhkcVmodzQAAu9opvQ
	(envelope-from <linux-wireless+bounces-39040-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 13:23:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 134F8753DB7
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 13:23:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Pfam2qx6;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39040-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39040-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B68C318EA19
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 11:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76ED5373C12;
	Tue, 14 Jul 2026 11:20:44 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18743367F4A
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 11:20:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784028044; cv=none; b=X8Gt01R+vPZdNny2LnecppNicNgsSEMhhHQBGIYFvDvWBwEeM5p068qv4K44t6v7kF5GshPyMpfEhfLIa8utyy79T29XaogddLD3ozIA/RAS7ZOHp+W5w7tnlNo5HCqJR4YkpNGkCUo5uMADOON3dkl3tUnqYOSrG3HdjOrSCvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784028044; c=relaxed/simple;
	bh=jj/U42TcoyFi65cBZTdmbotzWI4OJ8+7B6U5JjHTCSY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uqnF1JU5aQUPhvd7/stnN1O/byd86zuDIcJT7LnOYxvHFcW1FS2HcyE8ILt+hPUl1OzVd0cTd8lWdiwK6ifi6ePLr1t0t2UgG23lpYhBcLapx4Iu1EiNoD4kzeKNUQQSTzQnRzeSZbBgKFbU8h9SDKvQh0jTgUFQcM4yIjnI1NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pfam2qx6; arc=none smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784028043; x=1815564043;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jj/U42TcoyFi65cBZTdmbotzWI4OJ8+7B6U5JjHTCSY=;
  b=Pfam2qx6M8QuX5nb1iv7mQeyz36CbADX5nUBYjEUNXuTqoabsTm8c9hh
   xi7ootDetF0CUzRg6VrCc+GNAjixSy54XqDvhFVrxwfYe3Xz1nTLZsFOO
   eW5fZciiayObcqrnfYyzeKjT2gLBEOLKUaXbUjZM9W9Sa/yGrsxTI4Igr
   lsnAz2b1NMVgXRyxVGWzOngjiKYCOeQ2kjhTJvv7tPzt9XjgnIzFzR/DU
   jj83vNUxADDa4xmWAy6uGiXsMquBYpMAz+JIEYaUzdUTH+awaFZ7Ix09g
   DRMAhEvir9WLQDMg5UELP22gsmJlPWcZYabs4ywiW19GcUNbRCQyPNu4A
   A==;
X-CSE-ConnectionGUID: k1bw7i3KQqW6cPX9IP1eEQ==
X-CSE-MsgGUID: rQ51MNfPT4ixBExc2aSD9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="102200324"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="102200324"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 04:20:43 -0700
X-CSE-ConnectionGUID: i1gwBxH6Q4GztY1InlIlYw==
X-CSE-MsgGUID: bP5PqXlKSxeXLdEdwwHnXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="280250200"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 04:20:42 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH iwlwifi-fixes 13/15] wifi: iwlwifi: mvm: fix sched scan IE sizing
Date: Tue, 14 Jul 2026 14:20:02 +0300
Message-Id: <20260714141909.53d2722c79e7.Iebb922efa6173c92f14cd8aa8b4e7f372c0a0fb7@changeid>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-39040-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:emmanuel.grumbach@intel.com,m:ilan.peer@intel.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[changeid:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:from_mime,intel.com:email,intel.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 134F8753DB7

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Scheduled scan built the probe request before iwl_mvm_scan_fits(),
so oversized IEs could be copied into the fixed preq buffer before
length validation. Move iwl_mvm_build_scan_probe() after the fits
check.

Also advertise max_sched_scan_ie_len using iwl_mvm_max_scan_ie_len()
so userspace limits account for driver-inserted DS/TPC bytes.

Assisted-by: GitHubCopilot:gpt-5.3-codex
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 4 +---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c     | 4 ++--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index f4f4446bef54..3e73a6195fd9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -625,9 +625,7 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 	hw->wiphy->max_sched_scan_reqs = 1;
 	hw->wiphy->max_sched_scan_ssids = PROBE_OPTION_MAX;
 	hw->wiphy->max_match_sets = iwl_umac_scan_get_max_profiles(mvm->fw);
-	/* we create the 802.11 header and zero length SSID IE. */
-	hw->wiphy->max_sched_scan_ie_len =
-		SCAN_OFFLOAD_PROBE_REQ_SIZE - 24 - 2;
+	hw->wiphy->max_sched_scan_ie_len = iwl_mvm_max_scan_ie_len(mvm);
 	hw->wiphy->max_sched_scan_plans = IWL_MAX_SCHED_SCAN_PLANS;
 	hw->wiphy->max_sched_scan_plan_interval = U16_MAX;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 42f9d9a713b8..3831b3c27e0f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -3144,8 +3144,6 @@ int iwl_mvm_sched_scan_start(struct iwl_mvm *mvm,
 	if (ret)
 		return ret;
 
-	iwl_mvm_build_scan_probe(mvm, vif, ies, &params);
-
 	/* for 6 GHZ band only PSC channels need to be added */
 	for (i = 0; i < params.n_channels; i++) {
 		struct ieee80211_channel *channel = params.channels[i];
@@ -3179,6 +3177,8 @@ int iwl_mvm_sched_scan_start(struct iwl_mvm *mvm,
 		goto out;
 	}
 
+	iwl_mvm_build_scan_probe(mvm, vif, ies, &params);
+
 	uid = iwl_mvm_build_scan_cmd(mvm, vif, &hcmd, &params, type);
 	if (uid < 0) {
 		ret = uid;
-- 
2.34.1


