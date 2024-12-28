Return-Path: <linux-wireless+bounces-16856-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AF89FDC38
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Dec 2024 21:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFE9816157C
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Dec 2024 20:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247D618A922;
	Sat, 28 Dec 2024 20:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GXC+Oif0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B4D1990CF
	for <linux-wireless@vger.kernel.org>; Sat, 28 Dec 2024 20:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735418097; cv=none; b=hsrWRedsBYXb/EIzqKin/TwWJifF/AqxIKZevAr5s2JrxR+nXNbE0VukLOHBN5uxUpgu6XuoOQG59vS7t0qv5uayttWvi2cKPZOnI5v9TZO850EgRNzFfogrrFF3FTfHCDil/80kcXvBpBatNmABuYml3u22Sp0ujnTBeJbyYzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735418097; c=relaxed/simple;
	bh=lP9DRq6rlE86Ure9e4wX49DTWynRn2dDVtEZGSYHpYE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ATLbJjgK2zJ/TkQHWD3oN4mQV/0UnRNAuyRV7xT/iv9YZVz5wHjnJzXPt3QPDT+G8hKhljFWBFKI/GbbtBl914d8kVqkYQ2sER3oc/oOKDz/PEEOCzXIFk6JXwMhIlhiIWNklO3baUpq914Lso0glWQVJFf+Dmi2NxIl2RbmEz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GXC+Oif0; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735418095; x=1766954095;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lP9DRq6rlE86Ure9e4wX49DTWynRn2dDVtEZGSYHpYE=;
  b=GXC+Oif0lX+9Zvdz+YrNvmkugFkkLykQ/VF1QI/hsOdMVpHOgCBx+HWV
   q6Cu0lq7QA0iatwP5YkTKuvdQjfVOR7duZ/c8RyXdF1UC1KkPEZyIJOrI
   5DwXblQ41KjoZUipyqIT6iM4jnr7lSj1gJr0feLWAfmELfFfTxVlKiMJv
   Y/bYmI2j6Df+rhlTrp/pXGtsWuzpiEyGwvO8fWbTR/OcdBQYyAV7ogdhD
   Cai47BMEs1eHYwFYvhSX9Y6OBVH/3HU90BNpV8b8uX2hE1pUcj3aVc7g5
   axeUjJbzXJ+VZ+2gOlMn894DzBm7jP8PTHd2EAsXIRo9vfsmI0/L71u35
   w==;
X-CSE-ConnectionGUID: fNZJjnAbRXCnkGcspAK3Hg==
X-CSE-MsgGUID: OzgVeZlmRJ2pIUEJGzUAeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="35479781"
X-IronPort-AV: E=Sophos;i="6.12,273,1728975600"; 
   d="scan'208";a="35479781"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2024 12:34:55 -0800
X-CSE-ConnectionGUID: Xvvx2R4STTG2fu3P/D3tfQ==
X-CSE-MsgGUID: ApON1S0CR0WYhX1tHRLA9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104488427"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2024 12:34:53 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 14/15] wifi: iwlwifi: mvm: fix add stream vs. restart race
Date: Sat, 28 Dec 2024 22:34:18 +0200
Message-Id: <20241228223206.9c30af039b4d.I1a32936776f8ba5e83dda0a68ffc2722d9d37950@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241228203419.2443350-1-miriam.rachel.korenblit@intel.com>
References: <20241228203419.2443350-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

My recent restart related work has made this race more likely
to happen and we've now noticed it, but it seems that it was
always possible. The race is that the add stream work can be
scheduled just before a restart is scheduled and then execute
before the restart, accessing the device while it's doing the
restart and not accessible.

To fix this, check if the device is restarting and abort the
work in that case. Reschedule it after the restart as well.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 4 ++++
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c      | 9 ++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index a88ca5b48eca..d34ce4ffa980 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1341,6 +1341,10 @@ static void iwl_mvm_restart_complete(struct iwl_mvm *mvm)
 
 	IWL_INFO(mvm, "restart completed\n");
 	iwl_trans_finish_sw_reset(mvm->trans);
+
+	/* no need to lock, adding in parallel would schedule too */
+	if (!list_empty(&mvm->add_stream_txqs))
+		schedule_work(&mvm->add_stream_wk);
 }
 
 void iwl_mvm_mac_reconfig_complete(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index cd74c181c260..ede053507366 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -1520,7 +1520,12 @@ void iwl_mvm_add_new_dqa_stream_wk(struct work_struct *wk)
 	struct iwl_mvm *mvm = container_of(wk, struct iwl_mvm,
 					   add_stream_wk);
 
-	mutex_lock(&mvm->mutex);
+	guard(mvm)(mvm);
+
+	/* will reschedule to run after restart */
+	if (test_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED, &mvm->status) ||
+	    test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status))
+		return;
 
 	iwl_mvm_inactivity_check(mvm, IWL_INVALID_STA);
 
@@ -1564,8 +1569,6 @@ void iwl_mvm_add_new_dqa_stream_wk(struct work_struct *wk)
 		iwl_mvm_mac_itxq_xmit(mvm->hw, txq);
 		local_bh_enable();
 	}
-
-	mutex_unlock(&mvm->mutex);
 }
 
 static int iwl_mvm_reserve_sta_stream(struct iwl_mvm *mvm,
-- 
2.34.1


