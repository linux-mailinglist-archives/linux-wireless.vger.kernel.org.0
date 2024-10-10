Return-Path: <linux-wireless+bounces-13851-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 985C0998473
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 13:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5741A285389
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 11:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49931C3F1A;
	Thu, 10 Oct 2024 11:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hc8DfKnL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E011C2439
	for <linux-wireless@vger.kernel.org>; Thu, 10 Oct 2024 11:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728558336; cv=none; b=bqcz0BXA5g6neWU4X63KF0IK6TjO0F+j77X1jvRLK1BBfqVJsgssiwe0RFyailks/HRbiJ/c0Uy6qRzcaS4ZZnsT54yxXENjC3CyrfPU4rTtrm+RPAyRF8utLoYwZTYy344vCEzVmPuVrAZ45DqmUeYO7c3czbbXZn9u3Vs5MiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728558336; c=relaxed/simple;
	bh=3ECqspv3YmPba6PIxQUUN4ClaJatIPZn/x4TEOVwLNM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kVpiHyNtaBq2TUSBoetM1IeEeHKe2e8wbyIunaxv3FnQzV8sOGAhxUGjwiVKfqXHJSnKXVqQvi8s1T1gSHWNscoCvZk8F1gsMZSWohxyigzdChH5/xlKh3xxs7A3IojmFs8T4A5sZUEgQdSYRvC1q32tvMplpnnTM0WVOtj2J5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hc8DfKnL; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728558335; x=1760094335;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3ECqspv3YmPba6PIxQUUN4ClaJatIPZn/x4TEOVwLNM=;
  b=Hc8DfKnLTMdmGg+x/D6F6SP+nEdIRceS7xSTcdm/HGPV42gm/1X0madW
   3ZwX1ezBqglNmvvC472bfBPkifF59t+ofQ9HG/iEcaDZgS20PQWj1iHOs
   Xqy2DiyKmkEAQPMZH/3fmCvUUDUVH7k6C7WWbMUUg5tWOUJ936AgEhECZ
   Hq6rElfzXQ+aw/aGRFyF3lXYvEPrwLeNQrzXkffyT4EtarCNmooK72TZz
   bIBhrKVJNvcv9woWc4nGlVDlPdkR3I7lA0Jb64L86gyiIT+EU+0T+qxmr
   kHaQ+iz0IyCiEIGfnYESSs+EEujQR3XXR9e1DSy+OLvzM278wzeU6YGzA
   w==;
X-CSE-ConnectionGUID: +YIPY6OQRaKLi/EZXVRQtw==
X-CSE-MsgGUID: Cf5Ao8WLSr+DdRYIIhe4nA==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="31697751"
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="31697751"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 04:05:34 -0700
X-CSE-ConnectionGUID: t/iDAKXnSKqqVwsk1CWUKw==
X-CSE-MsgGUID: kaujwZ4BQLmJfztswdFHlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="81362348"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 04:05:34 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 9/9] wifi: iwlwifi: mvm: tell iwlmei when we finished suspending
Date: Thu, 10 Oct 2024 14:05:07 +0300
Message-Id: <20241010140328.1dc3a7fea9d1.Ibf183824471ea5580d9276d104444e53191e6900@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241010110507.1006209-1-miriam.rachel.korenblit@intel.com>
References: <20241010110507.1006209-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Since we no longer shut down the device in suspend, we also no longer
call iwl_mvm_mei_device_state() and this is a problem because iwlmei
expects this to be called when it runs its own suspend sequence. It
checks mei->device_down in iwl_mei_remove() which is called upon
suspend.

Fix this by telling iwlmei when we're done accessing the device.
When we'll wake up, the device should be untouched if CSME didn't use it
during the suspend time. If CSME used it, we'll notice it through the
CSR_FUNC_SCRATCH register.

Fixes: e8bb19c1d590 ("wifi: iwlwifi: support fast resume")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 819e1c0c46ca..db0c6e7a186b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1237,6 +1237,7 @@ int __iwl_mvm_mac_start(struct iwl_mvm *mvm)
 	fast_resume = mvm->fast_resume;
 
 	if (fast_resume) {
+		iwl_mvm_mei_device_state(mvm, true);
 		ret = iwl_mvm_fast_resume(mvm);
 		if (ret) {
 			iwl_mvm_stop_device(mvm);
@@ -1356,10 +1357,13 @@ void __iwl_mvm_mac_stop(struct iwl_mvm *mvm, bool suspend)
 		iwl_mvm_rm_aux_sta(mvm);
 
 	if (suspend &&
-	    mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22000)
+	    mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22000) {
 		iwl_mvm_fast_suspend(mvm);
-	else
+		/* From this point on, we won't touch the device */
+		iwl_mvm_mei_device_state(mvm, false);
+	} else {
 		iwl_mvm_stop_device(mvm);
+	}
 
 	iwl_mvm_async_handlers_purge(mvm);
 	/* async_handlers_list is empty and will stay empty: HW is stopped */
-- 
2.34.1


