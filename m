Return-Path: <linux-wireless+bounces-13849-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C63B998470
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 13:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B415E28541A
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 11:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F5A1C3F1B;
	Thu, 10 Oct 2024 11:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U8z5lG33"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186D71C233D
	for <linux-wireless@vger.kernel.org>; Thu, 10 Oct 2024 11:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728558333; cv=none; b=nKnFV7rUsyAiic6QtezJSoXx6XqMEoOThi7z2KeO4QiMFouApk/wbw5sTAXSQLv9HCAKd7i4NQTo2Yv/uTb8ihkLN1/x34AQAf4e+oWLhj6G8Ekzxf9UptC8n3g1Z9VeEBzWvY6mFTuxzlmdFQKanUXFXts35vK6e117EyXyuEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728558333; c=relaxed/simple;
	bh=kgE85E5qYH3RIjRT6vV0QZytKgELcDLkPnRluAEpDrk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P1HaaI1gx6ivsNN1oiZMr0ihR8zHqBFoZSWBXhtIfZpXXbphBbhZqcOOFeK9O0LZzxAWlX56bJJ54zUwlyNqdS7chWZR1NmtWgyD1ci7E30jJlPUaPEzI9G/GDuHiCUmndFzyAk/JpjH4rhs2qUweklgUIhywAGqtowkEghdilo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U8z5lG33; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728558332; x=1760094332;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kgE85E5qYH3RIjRT6vV0QZytKgELcDLkPnRluAEpDrk=;
  b=U8z5lG33LOrJHibvjP+EObiXiVmhMYOp+YvueUsOsEBNv1R8HPANY8v8
   Q82/9k4arZZK2jIfodbPrkl2Hoin2Y7WaLaHwll4qvERBJbyQ2qsxXeND
   BnnKJ4P+u7BovurebWsOvdF91AYDSIEPDhP9vq6wyG3btoyaOLTfWbawa
   r5CuHZv1MVCsFHnX82ln6ZTPz9N1i3ABKCnzPK7wzvpdrlFFsFIyNBmB1
   AGg0Njl7LtzwQusTZ/hMWAevpTH6huRIKeCprjT2+996XoQ0DjlLzM3nX
   1u1Sf8zEHrsFGpEzeczUX3Qu/+M7pW74Vok8wKVAfP7lbcsKV2RfN8qWQ
   g==;
X-CSE-ConnectionGUID: vLn9dmwNTs2xcJSXnA4J7A==
X-CSE-MsgGUID: scwdMAquRXGv/EyxR0/HoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="31697746"
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="31697746"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 04:05:32 -0700
X-CSE-ConnectionGUID: kts0Z5kZSPiXgurMmw2eZg==
X-CSE-MsgGUID: 5pqcHfUQSnOKRyhawlOwww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="81362339"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 04:05:31 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Daniel Gabay <daniel.gabay@intel.com>
Subject: [PATCH 7/9] wifi: iwlwifi: mvm: Fix response handling in iwl_mvm_send_recovery_cmd()
Date: Thu, 10 Oct 2024 14:05:05 +0300
Message-Id: <20241010140328.76c73185951e.Id3b6ca82ced2081f5ee4f33c997491d0ebda83f7@changeid>
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

From: Daniel Gabay <daniel.gabay@intel.com>

1. The size of the response packet is not validated.
2. The response buffer is not freed.

Resolve these issues by switching to iwl_mvm_send_cmd_status(),
which handles both size validation and frees the buffer.

Fixes: f130bb75d881 ("iwlwifi: add FW recovery flow")
Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 08546e673cf5..f30b0fc8eca9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1307,8 +1307,8 @@ static void iwl_mvm_disconnect_iterator(void *data, u8 *mac,
 void iwl_mvm_send_recovery_cmd(struct iwl_mvm *mvm, u32 flags)
 {
 	u32 error_log_size = mvm->fw->ucode_capa.error_log_size;
+	u32 status = 0;
 	int ret;
-	u32 resp;
 
 	struct iwl_fw_error_recovery_cmd recovery_cmd = {
 		.flags = cpu_to_le32(flags),
@@ -1316,7 +1316,6 @@ void iwl_mvm_send_recovery_cmd(struct iwl_mvm *mvm, u32 flags)
 	};
 	struct iwl_host_cmd host_cmd = {
 		.id = WIDE_ID(SYSTEM_GROUP, FW_ERROR_RECOVERY_CMD),
-		.flags = CMD_WANT_SKB,
 		.data = {&recovery_cmd, },
 		.len = {sizeof(recovery_cmd), },
 	};
@@ -1336,7 +1335,7 @@ void iwl_mvm_send_recovery_cmd(struct iwl_mvm *mvm, u32 flags)
 		recovery_cmd.buf_size = cpu_to_le32(error_log_size);
 	}
 
-	ret = iwl_mvm_send_cmd(mvm, &host_cmd);
+	ret = iwl_mvm_send_cmd_status(mvm, &host_cmd, &status);
 	kfree(mvm->error_recovery_buf);
 	mvm->error_recovery_buf = NULL;
 
@@ -1347,11 +1346,10 @@ void iwl_mvm_send_recovery_cmd(struct iwl_mvm *mvm, u32 flags)
 
 	/* skb respond is only relevant in ERROR_RECOVERY_UPDATE_DB */
 	if (flags & ERROR_RECOVERY_UPDATE_DB) {
-		resp = le32_to_cpu(*(__le32 *)host_cmd.resp_pkt->data);
-		if (resp) {
+		if (status) {
 			IWL_ERR(mvm,
 				"Failed to send recovery cmd blob was invalid %d\n",
-				resp);
+				status);
 
 			ieee80211_iterate_interfaces(mvm->hw, 0,
 						     iwl_mvm_disconnect_iterator,
-- 
2.34.1


