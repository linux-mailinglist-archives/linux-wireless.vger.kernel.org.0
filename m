Return-Path: <linux-wireless+bounces-39044-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id edtNKA0fVmrTzQAAu9opvQ
	(envelope-from <linux-wireless+bounces-39044-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 13:35:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E4F753F1F
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 13:35:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=JAEcavB5;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39044-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39044-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB002313518B
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 11:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2FC367F48;
	Tue, 14 Jul 2026 11:33:07 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A168181334
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 11:33:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784028787; cv=none; b=hf4SvPmtGcG8O+JYErHYgztOBFf70dVpxSTzYKs3IK9GjeGL3bZUPlsqZMFXrGbzZ7WKaco88rfd3HbCNolFMUFrf9ihSuAsJOmwwz2ls+phTnK51BSYQCjbajHy+RXesjMQis0kUNXsE83qcQJEf/ywdgZkYQYpMSmPbrWIHwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784028787; c=relaxed/simple;
	bh=ssOes/gDOzh4JySWLZ1Me8sXtQsshqtcUsbLBH8XzrY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mNY9HmoPCYqrE2OIdoqWjZVTBPJfPLJAEBrX7SpNN1fhN0V2dgz51L153MPes2Vw7UOBAYHHy369Pt4WszNHBKzqWLfsiTmwoNq9k0kxFlMqZ69MgExh9iDIucTDl370+2O9WMLrUG1gEKF6YcaWAgLkArZhMOCHOZ1SCsfZFkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JAEcavB5; arc=none smtp.client-ip=192.198.163.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784028786; x=1815564786;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ssOes/gDOzh4JySWLZ1Me8sXtQsshqtcUsbLBH8XzrY=;
  b=JAEcavB5wyxsIgTXYgBnopWj6IvUwi5Mx6NERS+iVTbX8N4UsgH7tgA8
   qw/PigeUj4r8PVbL7Xfwav++HfxguvcIu91dC8uu6fjzpiKgbA9m6972R
   Ypsh4yNjRaSRgLwqSSo1Wky+Wl3CxExhH+uZSRg94cWgTNN9YQM2LttVv
   u3C4kwTJFD9/8tSnGs0P7Ly+WZI3LSDrEqPuZIRAdvC/wYy3UPWtSIGoe
   4d2APDe5g3rnEn/1enobQAPFUm4UqpYOmcp0E8reF9INnp20hCZr+kdH6
   BQGHl5wJkin23BeECUgathnJZc3mvN+bZZgPB2Kh520GlUGy/rLDP9pZa
   A==;
X-CSE-ConnectionGUID: X4/UQvcXRg65G1JIQf2F0Q==
X-CSE-MsgGUID: UdokQU0KR6C1+ZcMUrxheg==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="88469571"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="88469571"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 04:33:06 -0700
X-CSE-ConnectionGUID: afEReTaCSeqnuxYeNtEDyQ==
X-CSE-MsgGUID: N2A7a7TYSwC3BNAcZ9BXrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="255882902"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 04:33:04 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 02/15] wifi: iwlwifi: mvm: remove iwl_mvm_recalc_tcm()
Date: Tue, 14 Jul 2026 14:32:28 +0300
Message-Id: <20260714143119.dd9f49714128.I65fbe6890d67ec424d333c362aa7041a117aed44@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714143119.a549b9499e3e.Id1a95bbbf92b5862862becaf57419bb9fe1385e5@changeid>
References: <20260714143119.a549b9499e3e.Id1a95bbbf92b5862862becaf57419bb9fe1385e5@changeid>
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
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-39044-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[changeid:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:from_mime,intel.com:email,intel.com:dkim,vger.kernel.org:from_smtp,sipsolutions.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 08E4F753F1F

From: Johannes Berg <johannes@sipsolutions.net>

This function is only called in the worker, so it doesn't
need to exist at all, simply move the code there.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h   |  1 -
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c | 16 +++++-----------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 1b56a2695bde..4420005ef69e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2412,7 +2412,6 @@ bool iwl_mvm_is_vif_assoc(struct iwl_mvm *mvm);
 #define MVM_TCM_PERIOD (HZ * MVM_TCM_PERIOD_MSEC / 1000)
 #define MVM_LL_PERIOD (10 * HZ)
 void iwl_mvm_tcm_work(struct work_struct *work);
-void iwl_mvm_recalc_tcm(struct iwl_mvm *mvm);
 void iwl_mvm_pause_tcm(struct iwl_mvm *mvm, bool with_cancel);
 void iwl_mvm_resume_tcm(struct iwl_mvm *mvm);
 void iwl_mvm_tcm_add_vif(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index 849342c96ae7..7eae10982869 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -1055,7 +1055,7 @@ static unsigned long iwl_mvm_calc_tcm_stats(struct iwl_mvm *mvm,
 	/*
 	 * If the current load isn't low we need to force re-evaluation
 	 * in the TCM period, so that we can return to low load if there
-	 * was no traffic at all (and thus iwl_mvm_recalc_tcm didn't get
+	 * was no traffic at all (and thus iwl_mvm_tcm_work() didn't get
 	 * triggered by traffic).
 	 */
 	if (load != IWL_MVM_TRAFFIC_LOW)
@@ -1081,8 +1081,11 @@ static unsigned long iwl_mvm_calc_tcm_stats(struct iwl_mvm *mvm,
 	return 0;
 }
 
-void iwl_mvm_recalc_tcm(struct iwl_mvm *mvm)
+void iwl_mvm_tcm_work(struct work_struct *work)
 {
+	struct delayed_work *delayed_work = to_delayed_work(work);
+	struct iwl_mvm *mvm = container_of(delayed_work, struct iwl_mvm,
+					   tcm.work);
 	unsigned long ts = jiffies;
 	bool handle_uapsd =
 		time_after(ts, mvm->tcm.uapsd_nonagg_ts +
@@ -1119,15 +1122,6 @@ void iwl_mvm_recalc_tcm(struct iwl_mvm *mvm)
 	iwl_mvm_tcm_results(mvm);
 }
 
-void iwl_mvm_tcm_work(struct work_struct *work)
-{
-	struct delayed_work *delayed_work = to_delayed_work(work);
-	struct iwl_mvm *mvm = container_of(delayed_work, struct iwl_mvm,
-					   tcm.work);
-
-	iwl_mvm_recalc_tcm(mvm);
-}
-
 void iwl_mvm_pause_tcm(struct iwl_mvm *mvm, bool with_cancel)
 {
 	spin_lock_bh(&mvm->tcm.lock);
-- 
2.34.1


