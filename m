Return-Path: <linux-wireless+bounces-31826-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iH6REpkSkGmYVwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31826-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 07:13:45 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFE813B361
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 07:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DC56301779F
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 06:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B4D30BF52;
	Sat, 14 Feb 2026 06:11:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.unwrap.rs (mail.unwrap.rs [172.232.15.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC55308F23;
	Sat, 14 Feb 2026 06:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.232.15.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771049483; cv=none; b=hD/HNaLX263M99E4IPJr+yarfNI+rK/LXmMnKCRJcosLd5bQTmKjyMHZWEO6f6xZlqTyV2f4JoQG63/fAGUQPeVLBdg1pEUCyxsHEYCXM0eQ59mOYS6NZrobax7MJ3fy6FTULV4oqSyIRU1f9yxMAYpB+yfcON0Olzchg+6dcgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771049483; c=relaxed/simple;
	bh=ZdklO99KobPfE7nP+R7wfAztS1NohORm4OAQF5IMavk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aXkwCvl2XDenDrYV/sB+ASpJDWnOPiMoGHNwf3BDCWWqWWLvij8f50Rhx0t2/C7LIIDtEASDqE9rbmScfm4/zjktiHWOEO71RS5A3gYnjqcvmRNpBXJy7Z0o6/CoXxFxNBjgr8NSjTS7fbEQD87+btK7JddeINay+SrWAa51zqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unwrap.rs; spf=pass smtp.mailfrom=unwrap.rs; arc=none smtp.client-ip=172.232.15.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unwrap.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unwrap.rs
From: Cole Leavitt <cole@unwrap.rs>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Cole Leavitt <cole@unwrap.rs>
Subject: [PATCH] wifi: iwlwifi: mld: stop mac80211 TX queues on firmware error
Date: Fri, 13 Feb 2026 23:07:16 -0700
Message-ID: <20260214060716.16394-1-cole@unwrap.rs>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[unwrap.rs : SPF not aligned (strict), No valid DKIM,reject];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_THREE(0.00)[3];
	R_DKIM_NA(0.00)[];
	TAGGED_FROM(0.00)[bounces-31826-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,unwrap.rs:mid,unwrap.rs:email];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cole@unwrap.rs,linux-wireless@vger.kernel.org]
X-Rspamd-Queue-Id: 9CFE813B361
X-Rspamd-Action: no action

When firmware encounters an error in the iwlmld driver, nothing prevents
mac80211 from continuing to feed TX packets. The mvm driver uses atomic
status bits (IWL_MVM_STATUS_HW_RESTART_REQUESTED) checked in its TX path
to gate transmissions, but the mld driver has no equivalent check --
iwl_mld_tx_from_txq() only checks mld_txq->status.stop_full.

This allows TX to proceed while firmware is unresponsive, causing
spinlock contention and soft lockups lasting 22-26 seconds.

Add ieee80211_stop_queues() in both iwl_mld_nic_error() and
iwl_mld_sw_reset() to stop TX at the mac80211 level when a restart will
follow, and add the corresponding ieee80211_wake_queues() in
iwl_mld_restart_cleanup() to resume TX after recovery.

The stop in iwl_mld_nic_error() is placed inside the conditional that
sets in_hw_restart to ensure queues are only stopped when a restart will
actually follow, avoiding a permanent TX stall on error paths where no
restart occurs (e.g. IWL_ERR_TYPE_RESET_HS_TIMEOUT with
!fw_status.running). The stop in iwl_mld_sw_reset() is unconditional
since that path always sets in_hw_restart.

Tested on ThinkPad P16 Gen3 with Intel BE200 (WiFi7) running kernel
6.19.0-rc8.

Fixes: d1e879ec600f ("wifi: iwlwifi: add iwlmld sub-driver")
Cc: stable@vger.kernel.org
Signed-off-by: Cole Leavitt <cole@unwrap.rs>
---
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c | 2 ++
 drivers/net/wireless/intel/iwlwifi/mld/mld.c      | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index df8221277d51..552888538e16 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -558,6 +558,8 @@ iwl_mld_restart_cleanup(struct iwl_mld *mld)
 					  iwl_mld_cleanup_sta, NULL);
 
 	iwl_mld_ftm_restart_cleanup(mld);
+
+	ieee80211_wake_queues(mld->hw);
 }
 
 static
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
index 495e9d8f3af6..ed44c10c08a1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -672,8 +672,10 @@ iwl_mld_nic_error(struct iwl_op_mode *op_mode,
 	 * setting doesn't matter if we're going to be unbound either.
 	 */
 	if (type != IWL_ERR_TYPE_RESET_HS_TIMEOUT &&
-	    mld->fw_status.running)
+	    mld->fw_status.running) {
+		ieee80211_stop_queues(mld->hw);
 		mld->fw_status.in_hw_restart = true;
+	}
 }
 
 static void iwl_mld_dump_error(struct iwl_op_mode *op_mode,
@@ -703,6 +705,7 @@ static bool iwl_mld_sw_reset(struct iwl_op_mode *op_mode,
 	 * had a NIC error both were already done.
 	 */
 	iwl_mld_report_scan_aborted(mld);
+	ieee80211_stop_queues(mld->hw);
 	mld->fw_status.in_hw_restart = true;
 
 	/* Do restart only in the following conditions are met:

base-commit: 66af8ac52d10ea229d5755b8700e2fe86fc037f7
-- 
2.52.0


