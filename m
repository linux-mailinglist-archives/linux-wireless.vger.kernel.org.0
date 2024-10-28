Return-Path: <linux-wireless+bounces-14597-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCDA9B2F65
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 12:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F9D51C210A9
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 11:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C971D9681;
	Mon, 28 Oct 2024 11:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aTtatIll"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36A81D95B5
	for <linux-wireless@vger.kernel.org>; Mon, 28 Oct 2024 11:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730116533; cv=none; b=PJY3J2wr8fTYyIU69k01LjagIX+QqKQd0MyHaNBByTMQUyxNFbGj9G+69oMiFnVJt19Z8fq3Lyh43TfBzUPgOCJGtM1xVHj6ZRAIAPImuZqJkfhRLJ4cTjp9O1+epjVTA26UUC14fCnUL+66WiLtvoR+TUtvWyBOkjGAe2pAqxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730116533; c=relaxed/simple;
	bh=pBlu0dLY9etlexjJygupcmU7lhZc+sU0rYdX/jGbjuA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZACbtbu/90xRws3qjwD8rtFP/Tp1CMqCTDkAqOzu517zwx3kL2qGhgcjqAxatblU4AZwmSR8lywxPb6muAdKBVbTFKG/Sa2DaUpGkczvYg55KIhqx9uRtuixJ7pZ1MF70iTeKgYEl4P/562cd74n+Um6570NX0+rrfVtV+8V6as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aTtatIll; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730116532; x=1761652532;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pBlu0dLY9etlexjJygupcmU7lhZc+sU0rYdX/jGbjuA=;
  b=aTtatIllbKuXiIplL+VZdwsC8wypsUZZsxpu/cOceN/jr7dxVgwGr3a7
   p8mtl5xbyLbhoS59HM8mNcs/jThfUMnSvEsisnMis0FQAhNQVup+y0pS2
   +aql83NKCsHzUiu7k9AV/zQztx6ZoDOAV/b38+VAjZb1u+yCYVkZcpjS3
   OJdxdC0Mp1x0mMUMCyrBF5HabzfvMoOEcEwfSyfWyk4xoPNDDu0ItAzWz
   N2gk/I1xpFjCk2JWwZ5rqp1Orq0yrqld/PXn4uIqPSzU3VmG1gYq/qGhl
   GGxsmq/qcfW0dsat43ssgj6Y/mrcKbYAz6TP6gG5l7zTda4VKnj1J6FSH
   Q==;
X-CSE-ConnectionGUID: rbSSUNL1R1md5vRssp47mQ==
X-CSE-MsgGUID: ThKETcx8T8+CobIGFbi/Jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="29813907"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="29813907"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 04:55:30 -0700
X-CSE-ConnectionGUID: LD1FZF20T3mQwAqB9/eRRw==
X-CSE-MsgGUID: 6IhYKRHiQjqX7huNGl0fGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="112432598"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 04:55:28 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 09/15] wifi: iwlwifi: mvm: tell iwlmei when we finished suspending
Date: Mon, 28 Oct 2024 13:54:54 +0200
Message-Id: <20241028135215.525287b90af2.Ibf183824471ea5580d9276d104444e53191e6900@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028115500.351123-1-miriam.rachel.korenblit@intel.com>
References: <20241028115500.351123-1-miriam.rachel.korenblit@intel.com>
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
index 4616a5b394c0..23ccbe7b74c0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1237,6 +1237,7 @@ int __iwl_mvm_mac_start(struct iwl_mvm *mvm)
 	fast_resume = mvm->fast_resume;
 
 	if (fast_resume) {
+		iwl_mvm_mei_device_state(mvm, true);
 		ret = iwl_mvm_fast_resume(mvm);
 		if (ret) {
 			iwl_mvm_stop_device(mvm);
@@ -1371,10 +1372,13 @@ void __iwl_mvm_mac_stop(struct iwl_mvm *mvm, bool suspend)
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


