Return-Path: <linux-wireless+bounces-27994-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C741BE12F9
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Oct 2025 03:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2927F3AB768
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Oct 2025 01:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB0A186294;
	Thu, 16 Oct 2025 01:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CKVukdgi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C098A1624D5;
	Thu, 16 Oct 2025 01:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760579363; cv=none; b=Tkw+CYSJpdLnBX8S3Lc7SS+233d1dqk2bKlM/vLgGdAJA8KeDrMa1FVh8tmJVVVwH98OgaKnAiNAx+GJ2E/D8jACr2XcFa1pA3uUgifepxXiXrEvAfzBnrJ2Vvf0yFMimm5aYlCw+a5OcSkwoq4Pz5qJ4gFbxfyK0wgwgnge8vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760579363; c=relaxed/simple;
	bh=+SJQe74DEmGx0h7tE1/KwhEqZvEV7qa0uH417xTizd0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QRJqGQGs19eEDy2CcIWMhI6nFz6ArTWfJG4FubM41qPZFdCPwWIgsl8Qi1Up2RSvVLm7Z7MlHBKKYHiotuF6ecDIucBwxQQoRCN4hm25OeSuiNOwe72w4R9vALJi+yFTv7c8JasO9V2DQTTCn0gpBrTnzBvTGaik+P59AEVPquU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CKVukdgi; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760579361; x=1792115361;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+SJQe74DEmGx0h7tE1/KwhEqZvEV7qa0uH417xTizd0=;
  b=CKVukdgiHvdkJAXnWLRDSdB0z5ni0uKUdZ4+dGOxaByxgjxchFt1spSW
   evw/+wO/VBSEsFkHULMQYsC+ItWdGfz1rwINQgodHJfI8SdBWRANRN6jB
   cnG3eiC50UFT9FFggU90ShbhbYhLfVBlUSZEgD089W4WZGsdn0I6Bmr0X
   NuckFNMYgisvSdMMMWTf89UhpVJru4dH+9OTlxDUEElPNdwgXJVdARZcZ
   v8T2sPo7dSVguv5lz42dRaJeO9QVxesXsqinklExv9j6B8r3bkhwg7uo3
   4nRBLFr7nfQsVg10fxGWsWMhY3KyaqGkMLoz7QqAtehZv560KEi3d3VIy
   w==;
X-CSE-ConnectionGUID: lPeH3NaFSxmTYOnlI5YiyQ==
X-CSE-MsgGUID: HHBtWQXPQvW618wOlQA2RQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="66626758"
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="66626758"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 18:49:20 -0700
X-CSE-ConnectionGUID: xKixhDlnTDqABrliovr50Q==
X-CSE-MsgGUID: N8dZ9f18Rvifle2KM8YdcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="219477475"
Received: from junjie-nuc14rvs.bj.intel.com ([10.238.152.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 18:49:17 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: linux-wireless@vger.kernel.org,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc: linux-kernel@vger.kernel.org,
	pagadala.yesu.anjaneyulu@intel.com,
	shaul.triebitz@intel.com,
	yedidya.ben.shimol@intel.com,
	junjie.cao@intel.com
Subject: [PATCH] wifi: iwlwifi: fix aux ROC time event iterator usage
Date: Thu, 16 Oct 2025 09:49:19 +0800
Message-ID: <20251016014919.383565-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The list_for_each_entry() iterator must not be used outside the loop.
Even though we break and check for NULL, doing so still violates kernel
iteration rules and triggers Coccinelle's use_after_iter.cocci warning.

Cache the matched entry in aux_roc_te and use it consistently after the
loop. This follows iterator best practices, resolves the warning, and
makes the code more maintainable.

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index 0c9c2492d8a7..0b12ee8ad618 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -463,7 +463,7 @@ static int iwl_mvm_aux_roc_te_handle_notif(struct iwl_mvm *mvm,
 	if (!aux_roc_te) /* Not a Aux ROC time event */
 		return -EINVAL;
 
-	iwl_mvm_te_check_trigger(mvm, notif, te_data);
+	iwl_mvm_te_check_trigger(mvm, notif, aux_roc_te);
 
 	IWL_DEBUG_TE(mvm,
 		     "Aux ROC time event notification  - UID = 0x%x action %d (error = %d)\n",
@@ -475,14 +475,14 @@ static int iwl_mvm_aux_roc_te_handle_notif(struct iwl_mvm *mvm,
 		/* End TE, notify mac80211 */
 		ieee80211_remain_on_channel_expired(mvm->hw);
 		iwl_mvm_roc_finished(mvm); /* flush aux queue */
-		list_del(&te_data->list); /* remove from list */
-		te_data->running = false;
-		te_data->vif = NULL;
-		te_data->uid = 0;
-		te_data->id = TE_MAX;
+		list_del(&aux_roc_te->list); /* remove from list */
+		aux_roc_te->running = false;
+		aux_roc_te->vif = NULL;
+		aux_roc_te->uid = 0;
+		aux_roc_te->id = TE_MAX;
 	} else if (le32_to_cpu(notif->action) == TE_V2_NOTIF_HOST_EVENT_START) {
 		set_bit(IWL_MVM_STATUS_ROC_AUX_RUNNING, &mvm->status);
-		te_data->running = true;
+		aux_roc_te->running = true;
 		ieee80211_ready_on_channel(mvm->hw); /* Start TE */
 	} else {
 		IWL_DEBUG_TE(mvm,
-- 
2.43.0


