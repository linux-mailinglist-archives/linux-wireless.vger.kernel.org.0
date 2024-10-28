Return-Path: <linux-wireless+bounces-14598-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DB09B2F66
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 12:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E2CE1C21090
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 11:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BC41D86CB;
	Mon, 28 Oct 2024 11:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YbvCoLFT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2891D966A
	for <linux-wireless@vger.kernel.org>; Mon, 28 Oct 2024 11:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730116534; cv=none; b=TIt4QR+2b/rDT5NKaqLH07ELI1UTPbr+Ww1EyUmfeOfnrWVGli654MELnvk7hvHd8PAZSgALSuT/H0OEr00PJ0ys9ulhJtMBGkNS8GZUf6oBGl6rG/x1fnS+SsOWQ7oyOKvU31ue/GYde9n4va6EjpLykI1MkM+myd4Sv8foydQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730116534; c=relaxed/simple;
	bh=XW5nlOpaXGipEl+zf2Nml6x0rKQWkGaW+ks5Di+R9s8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ld71C/S9B40/Evcr6cv2RPA9Md0b2NsiFKpEBnq9tp8kn/tImOTqdfE+Qb3zWeQUwFns+aeMzAlnOG8yZH4QQgjkBlmuR2YnAuWtYl1V4TKrdDg6icMjiq/R2vjqy7BHpdg/O6GlWEZosaVL+Ip8Sz6muT3GZpd4c/7uCPts5UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YbvCoLFT; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730116533; x=1761652533;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XW5nlOpaXGipEl+zf2Nml6x0rKQWkGaW+ks5Di+R9s8=;
  b=YbvCoLFTCRJ7wTJsp0ne3qOjucalkIVcGsDVJ1JKs7x1Z1VISgnDAx12
   SxCpbZoTp4dLFAwDWlUqfVqmljtjoKSM16Bn+yJcp/rPnXvvLePX9beWf
   ItbmBEgSkr4EPx8gVHaN7Stum+nhbB6VnuZENdG2zv8sJGJ1Q5g+YCBxa
   I/o7lxfz0iNv2lgFW+DMWFxsJtvMgtqETj/9ERDNsKKNb21LoBRxaFJRi
   j8TXuH9B7LhYLclxx/ePtBvY/E7VvWnJurMrC7D4CkyMrrWJb19mv+w57
   qMvyw7M3nRfzVwl/1QGHhHlAxhDdvZkD5zq3YEb8TicxiwVzWRjivIVNv
   A==;
X-CSE-ConnectionGUID: ifpAIMOZSU+s1hS9elsECw==
X-CSE-MsgGUID: PPHos19qTWyiGK7281Pb+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="29813909"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="29813909"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 04:55:31 -0700
X-CSE-ConnectionGUID: JJLoAZdnQUOLlz3acD5biw==
X-CSE-MsgGUID: q4K8FdxHRpmt+RCBtol8hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="112432603"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 04:55:29 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 10/15] wifi: iwlwifi: be less noisy if the NIC is dead in S3
Date: Mon, 28 Oct 2024 13:54:55 +0200
Message-Id: <20241028135215.3a18682261e5.I18f336a4537378a4c1a8537d7246cee1fc82b42c@changeid>
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

If the NIC is dead upon resume, try to catch the error earlier and exit
earlier. We'll print less error messages and get to the same recovery
path as before: reload the firmware.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dump.c   | 11 ++++++++---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h | 13 +++++++------
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c    | 18 +++++++++++++-----
 .../net/wireless/intel/iwlwifi/pcie/trans.c    |  2 ++
 4 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dump.c b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
index 3cabdeb53e99..8e0c85a1240d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dump.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
@@ -537,13 +537,18 @@ bool iwl_fwrt_read_err_table(struct iwl_trans *trans, u32 base, u32 *err_id)
 		/* cf. struct iwl_error_event_table */
 		u32 valid;
 		__le32 err_id;
-	} err_info;
+	} err_info = {};
+	int ret;
 
 	if (!base)
 		return false;
 
-	iwl_trans_read_mem_bytes(trans, base,
-				 &err_info, sizeof(err_info));
+	ret = iwl_trans_read_mem_bytes(trans, base,
+				       &err_info, sizeof(err_info));
+
+	if (ret)
+		return true;
+
 	if (err_info.valid && err_id)
 		*err_id = le32_to_cpu(err_info.err_id);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index e95ffe303547..c70da7281551 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1074,12 +1074,13 @@ int iwl_trans_read_config32(struct iwl_trans *trans, u32 ofs,
 void iwl_trans_debugfs_cleanup(struct iwl_trans *trans);
 #endif
 
-#define iwl_trans_read_mem_bytes(trans, addr, buf, bufsize)		      \
-	do {								      \
-		if (__builtin_constant_p(bufsize))			      \
-			BUILD_BUG_ON((bufsize) % sizeof(u32));		      \
-		iwl_trans_read_mem(trans, addr, buf, (bufsize) / sizeof(u32));\
-	} while (0)
+#define iwl_trans_read_mem_bytes(trans, addr, buf, bufsize)	\
+	({							\
+		if (__builtin_constant_p(bufsize))		\
+			BUILD_BUG_ON((bufsize) % sizeof(u32));	\
+		iwl_trans_read_mem(trans, addr, buf,		\
+				   (bufsize) / sizeof(u32));	\
+	})
 
 int iwl_trans_write_imr_mem(struct iwl_trans *trans, u32 dst_addr,
 			    u64 src_addr, u32 byte_cnt);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index fae9eabfa56e..a6082150deab 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -3107,7 +3107,6 @@ static void iwl_mvm_d3_disconnect_iter(void *data, u8 *mac,
 		ieee80211_resume_disconnect(vif);
 }
 
-
 static bool iwl_mvm_check_rt_status(struct iwl_mvm *mvm,
 				   struct ieee80211_vif *vif)
 {
@@ -3706,22 +3705,31 @@ int iwl_mvm_fast_resume(struct iwl_mvm *mvm)
 	iwl_fw_dbg_read_d3_debug_data(&mvm->fwrt);
 
 	if (iwl_mvm_check_rt_status(mvm, NULL)) {
+		IWL_ERR(mvm,
+			"iwl_mvm_check_rt_status failed, device is gone during suspend\n");
 		set_bit(STATUS_FW_ERROR, &mvm->trans->status);
 		iwl_mvm_dump_nic_error_log(mvm);
 		iwl_dbg_tlv_time_point(&mvm->fwrt,
 				       IWL_FW_INI_TIME_POINT_FW_ASSERT, NULL);
 		iwl_fw_dbg_collect_desc(&mvm->fwrt, &iwl_dump_desc_assert,
 					false, 0);
-		return -ENODEV;
+		mvm->trans->state = IWL_TRANS_NO_FW;
+		ret = -ENODEV;
+
+		goto out;
 	}
 	ret = iwl_mvm_d3_notif_wait(mvm, &d3_data);
+
+	if (ret) {
+		IWL_ERR(mvm, "Couldn't get the d3 notif %d\n", ret);
+		mvm->trans->state = IWL_TRANS_NO_FW;
+	}
+
+out:
 	clear_bit(IWL_MVM_STATUS_IN_D3, &mvm->status);
 	mvm->trans->system_pm_mode = IWL_PLAT_PM_MODE_DISABLED;
 	mvm->fast_resume = false;
 
-	if (ret)
-		IWL_ERR(mvm, "Couldn't get the d3 notif %d\n", ret);
-
 	return ret;
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 3b9943eb6934..d19b3bd0866b 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1643,6 +1643,8 @@ int iwl_trans_pcie_d3_resume(struct iwl_trans *trans,
 out:
 	if (*status == IWL_D3_STATUS_ALIVE)
 		ret = iwl_pcie_d3_handshake(trans, false);
+	else
+		trans->state = IWL_TRANS_NO_FW;
 
 	return ret;
 }
-- 
2.34.1


