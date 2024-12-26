Return-Path: <linux-wireless+bounces-16808-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF3A9FCBA2
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Dec 2024 16:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFC5618832ED
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Dec 2024 15:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0147080BFF;
	Thu, 26 Dec 2024 15:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VGJ9pct+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1704943AA8
	for <linux-wireless@vger.kernel.org>; Thu, 26 Dec 2024 15:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735227920; cv=none; b=go67PwwSsbkGGNqtyORo3hx7j8sL1pmQUZVPCTnVJTtwIpVlxd347jDySCCXz76HVem4cMEQtGL/+B1y3PFHFwdLfgS/oUaNyVgzxb25kLE2HX8yD2xAzRNqh7nlzeTjyZeEepvAjL015P/f9GX9J2B4RGNK2keS1IFy8ZvRi80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735227920; c=relaxed/simple;
	bh=6sZwtlenXHLET9Vc0M9SeEDLGqTDF1iM9Swa5FXOWw8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u7rCXgiweoIa5SlNKMb6I2q5lnR9cXmdccRqZGU3qV0XguY7wqwsdFETIvnZA9Nk7vNbKLYq9wI9dK88ti7ntgE24nrbH4xNL4xtSgTZYG2PIFOyTNZSjiVV5ZVM4eXYyKnkpH6KkIY+vsJFsYldtSQ/bC7ErLgIRX+KeGa83K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VGJ9pct+; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735227919; x=1766763919;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6sZwtlenXHLET9Vc0M9SeEDLGqTDF1iM9Swa5FXOWw8=;
  b=VGJ9pct+AhxP6mzqDjynWQnLzkffJtrmmogaZr7cmK8OJ6UIrXzwodP6
   PkcHY/upRD7mjFp4WuzlMtKXaM1zDRm+sZ4JJlTt6TX2hl/vRS9JuB3Jp
   myWXdPS5dXIgpVpvrosHbunzkMAqq/bIfw1HturqiGCjEZbdxpCNzYXJ1
   6nHH6IMi08ddMDAmnBNKU1YHtFInDOPmWgUF43eUSvwqoj7u/Cu3NDpyC
   KHqz1TLI+E2I2Z9eTGi80x7uSLn5cAsMUbIvjXOnBzEXvgLh/0+0l94pO
   /wU8b37rZvwILoSIS0fwuR9FQiLwI7ksN1iReIBnxlp69osqSWh/tX4qP
   A==;
X-CSE-ConnectionGUID: KrVAXiBKQ6yjRFDr/RBv9Q==
X-CSE-MsgGUID: Q25CVksrT/y5rkQKJwpy5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="35878131"
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="35878131"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2024 07:45:16 -0800
X-CSE-ConnectionGUID: 2h/W//2fQvCCO9r64UmhUw==
X-CSE-MsgGUID: I0lRJrs0TX6uADlyzRtXNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="99777982"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2024 07:45:15 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Daniel Gabay <daniel.gabay@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 03/15] wifi: iwlwifi: Remove mvm prefix from iwl_mvm_compressed_ba_notif
Date: Thu, 26 Dec 2024 17:44:44 +0200
Message-Id: <20241226174257.9b35dfce796b.Ie61e17a488f6a34bcbe814dd89a138fe1f55585c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241226154456.473690-1-miriam.rachel.korenblit@intel.com>
References: <20241226154456.473690-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Daniel Gabay <daniel.gabay@intel.com>

This is not MVM specific.

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/commands.h  |  2 +-
 .../net/wireless/intel/iwlwifi/fw/api/tx.h    | 20 +++++++++----------
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |  5 ++---
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
index 2f40e69db318..34a1f97653c0 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
@@ -447,7 +447,7 @@ enum iwl_legacy_cmds {
 
 	/**
 	 * @BA_NOTIF:
-	 * BlockAck notification, uses &struct iwl_mvm_compressed_ba_notif
+	 * BlockAck notification, uses &struct iwl_compressed_ba_notif
 	 * or &struct iwl_mvm_ba_notif depending on the HW
 	 */
 	BA_NOTIF = 0xc5,
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
index f3bf2e087a40..04b177b8ef30 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
@@ -638,14 +638,14 @@ struct iwl_mvm_ba_notif {
 } __packed;
 
 /**
- * struct iwl_mvm_compressed_ba_tfd - progress of a TFD queue
+ * struct iwl_compressed_ba_tfd - progress of a TFD queue
  * @q_num: TFD queue number
  * @tfd_index: Index of first un-acked frame in the  TFD queue
  * @scd_queue: For debug only - the physical queue the TFD queue is bound to
  * @tid: TID of the queue (0-7)
  * @reserved: reserved for alignment
  */
-struct iwl_mvm_compressed_ba_tfd {
+struct iwl_compressed_ba_tfd {
 	__le16 q_num;
 	__le16 tfd_index;
 	u8 scd_queue;
@@ -654,12 +654,12 @@ struct iwl_mvm_compressed_ba_tfd {
 } __packed; /* COMPRESSED_BA_TFD_API_S_VER_1 */
 
 /**
- * struct iwl_mvm_compressed_ba_ratid - progress of a RA TID queue
+ * struct iwl_compressed_ba_ratid - progress of a RA TID queue
  * @q_num: RA TID queue number
  * @tid: TID of the queue
  * @ssn: BA window current SSN
  */
-struct iwl_mvm_compressed_ba_ratid {
+struct iwl_compressed_ba_ratid {
 	u8 q_num;
 	u8 tid;
 	__le16 ssn;
@@ -685,7 +685,7 @@ enum iwl_mvm_ba_resp_flags {
 };
 
 /**
- * struct iwl_mvm_compressed_ba_notif - notifies about reception of BA
+ * struct iwl_compressed_ba_notif - notifies about reception of BA
  * ( BA_NOTIF = 0xc5 )
  * @flags: status flag, see the &iwl_mvm_ba_resp_flags
  * @sta_id: Index of recipient (BA-sending) station in fw's station table
@@ -704,12 +704,12 @@ enum iwl_mvm_ba_resp_flags {
  * @tx_rate: the rate the aggregation was sent at
  * @tfd_cnt: number of TFD-Q elements
  * @ra_tid_cnt: number of RATID-Q elements
- * @tfd: array of TFD queue status updates. See &iwl_mvm_compressed_ba_tfd
+ * @tfd: array of TFD queue status updates. See &iwl_compressed_ba_tfd
  *	for details. Length in @tfd_cnt.
  * @ra_tid: array of RA-TID queue status updates. For debug purposes only. See
- *	&iwl_mvm_compressed_ba_ratid for more details. Length in @ra_tid_cnt.
+ *	&iwl_compressed_ba_ratid for more details. Length in @ra_tid_cnt.
  */
-struct iwl_mvm_compressed_ba_notif {
+struct iwl_compressed_ba_notif {
 	__le32 flags;
 	u8 sta_id;
 	u8 reduced_txp;
@@ -726,8 +726,8 @@ struct iwl_mvm_compressed_ba_notif {
 	__le16 tfd_cnt;
 	__le16 ra_tid_cnt;
 	union {
-		DECLARE_FLEX_ARRAY(struct iwl_mvm_compressed_ba_ratid, ra_tid);
-		DECLARE_FLEX_ARRAY(struct iwl_mvm_compressed_ba_tfd, tfd);
+		DECLARE_FLEX_ARRAY(struct iwl_compressed_ba_ratid, ra_tid);
+		DECLARE_FLEX_ARRAY(struct iwl_compressed_ba_tfd, tfd);
 	};
 } __packed; /* COMPRESSED_BA_RES_API_S_VER_4,
 	       COMPRESSED_BA_RES_API_S_VER_5 */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index c9867d26361b..f1a8f4ad8b39 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -2193,7 +2193,7 @@ void iwl_mvm_rx_ba_notif(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 	ba_info.flags = IEEE80211_TX_STAT_AMPDU;
 
 	if (iwl_mvm_has_new_tx_api(mvm)) {
-		struct iwl_mvm_compressed_ba_notif *ba_res =
+		struct iwl_compressed_ba_notif *ba_res =
 			(void *)pkt->data;
 		u8 lq_color = TX_RES_RATE_TABLE_COL_GET(ba_res->tlc_rate_info);
 		u16 tfd_cnt;
@@ -2241,8 +2241,7 @@ void iwl_mvm_rx_ba_notif(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 
 		/* Free per TID */
 		for (i = 0; i < tfd_cnt; i++) {
-			struct iwl_mvm_compressed_ba_tfd *ba_tfd =
-				&ba_res->tfd[i];
+			struct iwl_compressed_ba_tfd *ba_tfd = &ba_res->tfd[i];
 
 			tid = ba_tfd->tid;
 			if (tid == IWL_MGMT_TID)
-- 
2.34.1


