Return-Path: <linux-wireless+bounces-11892-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 729E195E22B
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 07:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2B591F218BF
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 05:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8A528F4;
	Sun, 25 Aug 2024 05:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iJCxymaX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D215D3CF5E
	for <linux-wireless@vger.kernel.org>; Sun, 25 Aug 2024 05:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724565414; cv=none; b=qzJEk16Zj/k4klPLN1rXIwtqVLXUg1FS133CGHKY8X9Bz9uulb2RFVNNqzFMnPUy5ZdBToDjfojpH0KgQ7JrHg47I2u39Rv+Zc2Q+C5FPPzl+RtVF+d75venzmsJBkqvI9R99EPMIbNziljxyF9e7sb9f13QDe4HAv/HGTsdyGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724565414; c=relaxed/simple;
	bh=Dv4u7fZFWyaLG3F3fp9qB/qF/go/nhtWdsCoO/Tus4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KB774iV16mwjWx7X31H4cCREXRIkertv/vToEsetebunvc9yMuneQBqEh346S+OOcQ7rTvLdDwN7vpfKCXoQlMXJ0VxCtEhfdcQ5Z3+UpSkPktgwGJqjh9iqf0QvUnqzzXDvQGDqorPGG+C7fHkPtP1FWULYLcVYD1PMFljaBMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iJCxymaX; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724565412; x=1756101412;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Dv4u7fZFWyaLG3F3fp9qB/qF/go/nhtWdsCoO/Tus4Y=;
  b=iJCxymaXcVSyJN/fJg8sUkj5OyEbb+bEePwT84uC1LGZccczmjm7kXfP
   myk0xv7RVNqyHA7nBZ5WLNSZOz+3M5ud9GMR67QmbCT2un1ZMMv8hxNMO
   dzdRKnxn49MyXihf8gEhZ/SzgZCHxD4Ux13+DYgeyRE2KyC9PUhGkw393
   fMC4JBaV6Os16eD3BjQ89y05DDcsaF/9lhNoyzYvsqpLZ2GonsEWK24Ot
   tjsyUbBVN+v10JvZ0A0aHBAh59tI2n/RKJRpxrD/RzclK0B05fvDaYe/V
   lGXChptyWtszYQ7S9d8AUXpK7JhjJsHkr0kuPuingTLI8lBucixr2SuPW
   Q==;
X-CSE-ConnectionGUID: b1CtwRftTWS7HyZ3P7ucAQ==
X-CSE-MsgGUID: 5tyX2XiYRzWxAMPI24aHjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="22869537"
X-IronPort-AV: E=Sophos;i="6.10,174,1719903600"; 
   d="scan'208";a="22869537"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2024 22:56:51 -0700
X-CSE-ConnectionGUID: zM+HVH7fSRqxdKwe5xxXJA==
X-CSE-MsgGUID: HsnkM0ZZT9arxiQicWn85Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,174,1719903600"; 
   d="scan'208";a="92993868"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2024 22:56:49 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: iwlwifi: mvm: Fix a race in scan abort flow
Date: Sun, 25 Aug 2024 08:56:37 +0300
Message-Id: <20240825085558.483989d3baef.I3340556a222388504c6330b333360bf77d10f9e2@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

When the upper layer requests to cancel an ongoing scan, a race
is possible in which by the time the driver starts to handle the
upper layers scan cancel flow, the FW already completed handling
the scan request and the driver received the scan complete
notification but still did not handle the notification. In such a
case the FW will simply ignore the scan abort request coming from
the driver, no notification would arrive from the FW and the entire
abort flow would be considered a failure.

To better handle this, check the status code returned by the FW for
the scan abort command. In case the status indicates that
no scan was aborted, complete the scan abort flow with success, i.e.,
the scan was aborted, as the flow is expected to consume the scan
complete notification.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
v2: fix uninitialized variable

 .../net/wireless/intel/iwlwifi/fw/api/scan.h  | 13 ++++++
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 42 +++++++++++++++----
 2 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
index 8598031567bb..0aefdf353b21 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
@@ -1132,6 +1132,19 @@ struct iwl_umac_scan_abort {
 	__le32 flags;
 } __packed; /* SCAN_ABORT_CMD_UMAC_API_S_VER_1 */
 
+/**
+ * enum iwl_umac_scan_abort_status
+ *
+ * @IWL_UMAC_SCAN_ABORT_STATUS_SUCCESS: scan was successfully aborted
+ * @IWL_UMAC_SCAN_ABORT_STATUS_IN_PROGRESS: scan abort is in progress
+ * @IWL_UMAC_SCAN_ABORT_STATUS_NOT_FOUND: nothing to abort
+ */
+enum iwl_umac_scan_abort_status {
+	IWL_UMAC_SCAN_ABORT_STATUS_SUCCESS = 0,
+	IWL_UMAC_SCAN_ABORT_STATUS_IN_PROGRESS,
+	IWL_UMAC_SCAN_ABORT_STATUS_NOT_FOUND,
+};
+
 /**
  * struct iwl_umac_scan_complete
  * @uid: scan id, &enum iwl_umac_scan_uid_offsets
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 8e0df31f1b3e..4ae6339f87c7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -3301,13 +3301,23 @@ void iwl_mvm_rx_umac_scan_iter_complete_notif(struct iwl_mvm *mvm,
 		       mvm->scan_start);
 }
 
-static int iwl_mvm_umac_scan_abort(struct iwl_mvm *mvm, int type)
+static int iwl_mvm_umac_scan_abort(struct iwl_mvm *mvm, int type, bool *wait)
 {
-	struct iwl_umac_scan_abort cmd = {};
+	struct iwl_umac_scan_abort abort_cmd = {};
+	struct iwl_host_cmd cmd = {
+		.id = WIDE_ID(IWL_ALWAYS_LONG_GROUP, SCAN_ABORT_UMAC),
+		.len = { sizeof(abort_cmd), },
+		.data = { &abort_cmd, },
+		.flags = CMD_SEND_IN_RFKILL,
+	};
+
 	int uid, ret;
+	u32 status = IWL_UMAC_SCAN_ABORT_STATUS_NOT_FOUND;
 
 	lockdep_assert_held(&mvm->mutex);
 
+	*wait = true;
+
 	/* We should always get a valid index here, because we already
 	 * checked that this type of scan was running in the generic
 	 * code.
@@ -3316,17 +3326,28 @@ static int iwl_mvm_umac_scan_abort(struct iwl_mvm *mvm, int type)
 	if (WARN_ON_ONCE(uid < 0))
 		return uid;
 
-	cmd.uid = cpu_to_le32(uid);
+	abort_cmd.uid = cpu_to_le32(uid);
 
 	IWL_DEBUG_SCAN(mvm, "Sending scan abort, uid %u\n", uid);
 
-	ret = iwl_mvm_send_cmd_pdu(mvm,
-				   WIDE_ID(IWL_ALWAYS_LONG_GROUP, SCAN_ABORT_UMAC),
-				   CMD_SEND_IN_RFKILL, sizeof(cmd), &cmd);
+	ret = iwl_mvm_send_cmd_status(mvm, &cmd, &status);
+
+	IWL_DEBUG_SCAN(mvm, "Scan abort: ret=%d, status=%u\n", ret, status);
 	if (!ret)
 		mvm->scan_uid_status[uid] = type << IWL_MVM_SCAN_STOPPING_SHIFT;
 
-	IWL_DEBUG_SCAN(mvm, "Scan abort: ret=%d\n", ret);
+	/* Handle the case that the FW is no longer familiar with the scan that
+	 * is to be stopped. In such a case, it is expected that the scan
+	 * complete notification was already received but not yet processed.
+	 * In such a case, there is no need to wait for a scan complete
+	 * notification and the flow should continue similar to the case that
+	 * the scan was really aborted.
+	 */
+	if (status == IWL_UMAC_SCAN_ABORT_STATUS_NOT_FOUND) {
+		mvm->scan_uid_status[uid] = type << IWL_MVM_SCAN_STOPPING_SHIFT;
+		*wait = false;
+	}
+
 	return ret;
 }
 
@@ -3336,6 +3357,7 @@ static int iwl_mvm_scan_stop_wait(struct iwl_mvm *mvm, int type)
 	static const u16 scan_done_notif[] = { SCAN_COMPLETE_UMAC,
 					      SCAN_OFFLOAD_COMPLETE, };
 	int ret;
+	bool wait = true;
 
 	lockdep_assert_held(&mvm->mutex);
 
@@ -3347,7 +3369,7 @@ static int iwl_mvm_scan_stop_wait(struct iwl_mvm *mvm, int type)
 	IWL_DEBUG_SCAN(mvm, "Preparing to stop scan, type %x\n", type);
 
 	if (fw_has_capa(&mvm->fw->ucode_capa, IWL_UCODE_TLV_CAPA_UMAC_SCAN))
-		ret = iwl_mvm_umac_scan_abort(mvm, type);
+		ret = iwl_mvm_umac_scan_abort(mvm, type, &wait);
 	else
 		ret = iwl_mvm_lmac_scan_abort(mvm);
 
@@ -3355,6 +3377,10 @@ static int iwl_mvm_scan_stop_wait(struct iwl_mvm *mvm, int type)
 		IWL_DEBUG_SCAN(mvm, "couldn't stop scan type %d\n", type);
 		iwl_remove_notification(&mvm->notif_wait, &wait_scan_done);
 		return ret;
+	} else if (!wait) {
+		IWL_DEBUG_SCAN(mvm, "no need to wait for scan type %d\n", type);
+		iwl_remove_notification(&mvm->notif_wait, &wait_scan_done);
+		return 0;
 	}
 
 	return iwl_wait_notification(&mvm->notif_wait, &wait_scan_done,
-- 
2.34.1


