Return-Path: <linux-wireless+bounces-33573-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDpIOokCvWkO5gIAu9opvQ
	(envelope-from <linux-wireless+bounces-33573-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 09:17:13 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 555602D7118
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 09:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 30D18305D7E4
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 08:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D57373BE3;
	Fri, 20 Mar 2026 08:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ISwtIiyk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B07D37DEBF
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 08:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994191; cv=none; b=TgR9kmX+tzkMzKRSGuO/sKBJHzSr9MyZXyj8F72reynTSakz7WL1GuncClcPvVa3a8C2oJNJXLxKOIQeaw7dOeRgDXw/cGcb5Xs2k4qnNQxOaQQxI7rYuddV0Wmst+FUZTLU5jG+YETpeQpko6RJYTZweyj4VpDOLB1Ie5dc340=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994191; c=relaxed/simple;
	bh=NupVV1UdRLXgSSpv0R9VCnnZqC6AMpi1zt7Oc4KBnXs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EV7OBHP1PmjJSxz+VYs6f2Ar51o7/LNMV4CjA/BEyIjm5b0r5FytLuhCGltOh9+Xvy0h5hY09tTXR3vxgL90hPr/SDEExfa3BoAYiG4VRujHIgx03WoGuVGXF0qpbVlbMQPixWdHm1+IQ7/0Fb5NwkWhroGYryoYzhU4/hMIKjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ISwtIiyk; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773994189; x=1805530189;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NupVV1UdRLXgSSpv0R9VCnnZqC6AMpi1zt7Oc4KBnXs=;
  b=ISwtIiykr3QwIiiCAOGogGL5JTMH+nUJFTHGT367XUWGB7VXfriBfWU8
   v04Wigez4+dTku3DpS+aBRDkv3YQEi6K/mh0goCJRTMW07cMcoxW7MiXr
   F2xNJi/tRfpCtiQ047OLOPRcOsyNwaA4aucivaO6FYPGsP5OQ3l+BKtF0
   nPXjvWFR/5FwanEJ9dVVtTZPEhnfjUy/wbTZIX7K27gVdn2OftrK4rR4a
   zvtPDzF1l3QnjlqPHRpNhdFfRUCdmUolgHciVk2rdnggWfUrfwcQoAoPt
   b3cj3RoLpvOoGo7x0vIIip2yv8T1SUwlKPasLeskan4pfczV+sb/FL1lJ
   w==;
X-CSE-ConnectionGUID: zKTAGgmDQLKB7pylicLbiQ==
X-CSE-MsgGUID: ez8BYGsgSxafU266/o5egw==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="86154151"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="86154151"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:09:48 -0700
X-CSE-ConnectionGUID: /ICh5Dz8QVaO9s2IPy+yyA==
X-CSE-MsgGUID: mdXd+tTCRuS1OnK9XTiVGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="227692620"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:09:48 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 12/15] wifi: iwlwifi: use IWL_FW_CHECK for sync timeout
Date: Fri, 20 Mar 2026 10:09:15 +0200
Message-Id: <20260320100746.2188e2efbead.I7dc5bd6f581a31ac51d8a854f3b3af4cb980223a@changeid>
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
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33573-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 555602D7118
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

This could be a firmware issue, it didn't send all the responses
quickly enough. There are other potential issues (interrupts not
being delivered, etc.) but the FW debug data will at least give
some better information, and it's not a WARN condition anyway.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/rx.c       | 5 +++--
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 7 ++++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/rx.c b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
index ff6e71e3ff6e..6f40d6e47083 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
@@ -2211,8 +2211,9 @@ void iwl_mld_sync_rx_queues(struct iwl_mld *mld,
 	ret = wait_event_timeout(mld->rxq_sync.waitq,
 				 READ_ONCE(mld->rxq_sync.state) == 0,
 				 SYNC_RX_QUEUE_TIMEOUT);
-	WARN_ONCE(!ret, "RXQ sync failed: state=0x%lx, cookie=%d\n",
-		  mld->rxq_sync.state, mld->rxq_sync.cookie);
+	IWL_FW_CHECK(mld, !ret,
+		     "RXQ sync failed: state=0x%lx, cookie=%d\n",
+		     mld->rxq_sync.state, mld->rxq_sync.cookie);
 
 out:
 	mld->rxq_sync.state = 0;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 090791fe0638..1ec9807e4827 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -6229,9 +6229,10 @@ void iwl_mvm_sync_rx_queues_internal(struct iwl_mvm *mvm,
 		ret = wait_event_timeout(mvm->rx_sync_waitq,
 					 READ_ONCE(mvm->queue_sync_state) == 0,
 					 SYNC_RX_QUEUE_TIMEOUT);
-		WARN_ONCE(!ret, "queue sync: failed to sync, state is 0x%lx, cookie %d\n",
-			  mvm->queue_sync_state,
-			  mvm->queue_sync_cookie);
+		IWL_FW_CHECK(mvm, !ret,
+			     "queue sync: failed to sync, state is 0x%lx, cookie %d\n",
+			     mvm->queue_sync_state,
+			     mvm->queue_sync_cookie);
 	}
 
 out:
-- 
2.34.1


