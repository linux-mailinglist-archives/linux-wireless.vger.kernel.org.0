Return-Path: <linux-wireless+bounces-26651-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A12B36F48
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 18:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23BB89800DE
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 15:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314A1369328;
	Tue, 26 Aug 2025 15:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ew5ETS1+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56626350D7C
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 15:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756223755; cv=none; b=X3rvBHvTVeKSlo77uPpufySYWsy4XUnuafSesPfS/cemYejQPA3Z0xQ4GGWyB+UKq4exBDqaV3HJxjQ7k3HdQcFKjHc3hje5RHGq7sk0b6x9NlQvMzrInS+maj/HPug6s9qUaSVNn1cvE24GrLS0+jW/EqeopBwJwhju1u7WHw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756223755; c=relaxed/simple;
	bh=w6N2UiGwioNjUGwUowF7JAEUVjowSEyKMFB6j8fo8dA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X0A+RvI/W1JNAmfQ6leHJp6tfw08oJ1BcfZLjc5/wkQSEqQu9ByItj/lwpZzxYQhtpm+E7UnXUtWBZRgtKkOhAP6r3FwoAoJbdhyFbDbvA1vREokQTxX8kD4RnjeU8LEvkkRMruTo979hZQaKAVoTLCgQtTtrh5eY2EXHSjHW+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ew5ETS1+; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756223753; x=1787759753;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w6N2UiGwioNjUGwUowF7JAEUVjowSEyKMFB6j8fo8dA=;
  b=ew5ETS1+14d+/crg5YzoHxAM1GORriSYmCJESHmwggDs4XZBskD4sTL2
   6Wh3QC3yt7OoPdELBOiJCpj4pTKHQUFZ2mqtK2AW7bdNgMFHfCFH29p0f
   96irTDRf02rQ4rjtXNTzQMO+goIJUNjEAyaLCZeYt0GPG9Orxp2Iu2Dzg
   vvDWMGJSSw8IHwebMjHcrs6v2ksTlAzCJA59n0ovsZ/ZQri37ffXAiesL
   szIIUXOYR8Yh+Hvt7P66y8ZTtqpjsmV40ikTRqm3QowG5/3po5MsiJpeu
   uF1lU07Q2sx1l/wW1Q0b0VHnhhO3uOW8Pn9yvzTVx8IjjUu1zJMdTOtIA
   g==;
X-CSE-ConnectionGUID: 4ZkHkquQS/Opec2pfCBBoQ==
X-CSE-MsgGUID: 7MuidmkATjmleQuN4RuirQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="62108438"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="62108438"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 08:55:47 -0700
X-CSE-ConnectionGUID: cxlhZKQ9TmabMf92ofud5A==
X-CSE-MsgGUID: ydLlZXTrTdawBRA92Mcetw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169218353"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 08:55:46 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 13/15] wifi: iwlwifi: mld: don't modify trans state where not needed
Date: Tue, 26 Aug 2025 18:55:02 +0300
Message-Id: <20250826184046.44c74ac0eb2a.Ic7369e622d908684f9b25ffc293d14c167c26414@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826155504.2982930-1-miriam.rachel.korenblit@intel.com>
References: <20250826155504.2982930-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

In suspend and resume flows, if we had any error we set the transport state to
'FW_ERROR' This was done to avoid sending commands when we shouldn't.

In the mentioned flows, we can have a few types of errors:
1. logic errors
2. FW is in error state (can't send commands)
3. FW is misbehaving
4. D3 handshake error

In the first, we can still talk to the firmware.
In the second - the transport already knows about the FW error, no need to tell it.
In the third - we need to treat it as any other FW misbehaviour. There is no reason
to have a special handling here.

So we only need it for the last type. Change the code to set the
tansport state to FW error only in case of a d3 handshake error.

While at it, add a comment explaining why the opmode sets the FW error
bits.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/d3.c   | 35 ++++++-------------
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  7 +---
 2 files changed, 11 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
index 5d24292c45a5..8cd9d61a92e8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
@@ -1212,6 +1212,9 @@ static int iwl_mld_wait_d3_notif(struct iwl_mld *mld,
 
 	ret = iwl_trans_d3_resume(mld->trans, false);
 	if (ret) {
+		/* Avoid sending commands if the FW is dead */
+		mld->trans->state = IWL_TRANS_NO_FW;
+		set_bit(STATUS_FW_ERROR, &mld->trans->status);
 		iwl_remove_notification(&mld->notif_wait, &wait_d3_notif);
 		return ret;
 	}
@@ -1245,16 +1248,11 @@ int iwl_mld_no_wowlan_suspend(struct iwl_mld *mld)
 
 	iwl_mld_low_latency_stop(mld);
 
-	/* This will happen if iwl_mld_supsend failed with FW error */
-	if (mld->trans->state == IWL_TRANS_NO_FW &&
-	    test_bit(STATUS_FW_ERROR, &mld->trans->status))
-		return -ENODEV;
-
 	ret = iwl_mld_update_device_power(mld, true);
 	if (ret) {
 		IWL_ERR(mld,
 			"d3 suspend: couldn't send power_device %d\n", ret);
-		goto out;
+		return ret;
 	}
 
 	ret = iwl_mld_send_cmd_pdu(mld, D3_CONFIG_CMD,
@@ -1262,24 +1260,21 @@ int iwl_mld_no_wowlan_suspend(struct iwl_mld *mld)
 	if (ret) {
 		IWL_ERR(mld,
 			"d3 suspend: couldn't send D3_CONFIG_CMD %d\n", ret);
-		goto out;
+		return ret;
 	}
 
 	ret = iwl_trans_d3_suspend(mld->trans, false);
 	if (ret) {
 		IWL_ERR(mld, "d3 suspend: trans_d3_suspend failed %d\n", ret);
+		/* We are going to stop the FW. Avoid sending commands in that flow */
+		mld->trans->state = IWL_TRANS_NO_FW;
+		set_bit(STATUS_FW_ERROR, &mld->trans->status);
 	} else {
 		/* Async notification might send hcmds, which is not allowed in suspend */
 		iwl_mld_cancel_async_notifications(mld);
 		mld->fw_status.in_d3 = true;
 	}
 
- out:
-	if (ret) {
-		mld->trans->state = IWL_TRANS_NO_FW;
-		set_bit(STATUS_FW_ERROR, &mld->trans->status);
-	}
-
 	return ret;
 }
 
@@ -1299,15 +1294,12 @@ int iwl_mld_no_wowlan_resume(struct iwl_mld *mld)
 	iwl_fw_dbg_read_d3_debug_data(&mld->fwrt);
 
 	ret = iwl_mld_wait_d3_notif(mld, &resume_data, false);
+	if (ret)
+		return ret;
 
 	if (!ret && (resume_data.d3_end_flags & IWL_D0I3_RESET_REQUIRE))
 		return -ENODEV;
 
-	if (ret) {
-		mld->trans->state = IWL_TRANS_NO_FW;
-		set_bit(STATUS_FW_ERROR, &mld->trans->status);
-		return ret;
-	}
 	iwl_mld_low_latency_restart(mld);
 
 	return iwl_mld_update_device_power(mld, false);
@@ -1820,7 +1812,6 @@ int iwl_mld_wowlan_resume(struct iwl_mld *mld)
 	};
 	int link_id;
 	int ret;
-	bool fw_err = false;
 
 	lockdep_assert_wiphy(mld->wiphy);
 
@@ -1863,7 +1854,6 @@ int iwl_mld_wowlan_resume(struct iwl_mld *mld)
 	ret = iwl_mld_wait_d3_notif(mld, &resume_data, true);
 	if (ret) {
 		IWL_ERR(mld, "Couldn't get the d3 notifs %d\n", ret);
-		fw_err = true;
 		goto err;
 	}
 
@@ -1900,11 +1890,6 @@ int iwl_mld_wowlan_resume(struct iwl_mld *mld)
 	goto out;
 
  err:
-	if (fw_err) {
-		mld->trans->state = IWL_TRANS_NO_FW;
-		set_bit(STATUS_FW_ERROR, &mld->trans->status);
-	}
-
 	mld->fw_status.in_hw_restart = true;
 	ret = 1;
  out:
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index f434012b03a6..debfb986a387 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -1966,13 +1966,8 @@ iwl_mld_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wowlan)
 	iwl_fw_runtime_suspend(&mld->fwrt);
 
 	ret = iwl_mld_wowlan_suspend(mld, wowlan);
-	if (ret) {
-		if (ret < 0) {
-			mld->trans->state = IWL_TRANS_NO_FW;
-			set_bit(STATUS_FW_ERROR, &mld->trans->status);
-		}
+	if (ret)
 		return 1;
-	}
 
 	if (iwl_mld_no_wowlan_suspend(mld))
 		return 1;
-- 
2.34.1


