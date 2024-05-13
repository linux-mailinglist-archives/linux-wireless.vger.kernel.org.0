Return-Path: <linux-wireless+bounces-7584-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0230A8C3EDE
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 12:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0D30286E6A
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 10:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED47714A623;
	Mon, 13 May 2024 10:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hZdnAe89"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CA714A4E2
	for <linux-wireless@vger.kernel.org>; Mon, 13 May 2024 10:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715596046; cv=none; b=SFGJB/0tZeCxcO1lq5Z4w0Js1MVVu+4d6JuD1TVDUMI/JXp2TDFEh15QUYyLCRQHXdCFhf8ZxlfmRmyv8oNCWsVA99Uo1jeuJbYPF3eJhojM05rCxtJRpDbgX9qf1q+N4xhny6yxSXuw1iXeD9JKzJyEJqvnmeezyVMh6az0CkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715596046; c=relaxed/simple;
	bh=vON7C3yzzNYKstMeK9jY6q/ClYPhuR0C9p5D2HAr03I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sd6DOU03LkcHrsm8HF0vLyz+xmkt6lb43c8zOiAbq2NBjBYW8bHr5YnxnCkA1Da9VMr1odm61nkCU/6xswcPZ+SDxaWOHfR16xZkIxk9GN1pj4HIPd35T+HuNSL+dSNDZYNc5chJaFxyQo5nz4C1RN/MxD3dt6zFO+B6Jq77VXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hZdnAe89; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715596046; x=1747132046;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vON7C3yzzNYKstMeK9jY6q/ClYPhuR0C9p5D2HAr03I=;
  b=hZdnAe892out3sYjWGT+mzwwrLEAQlgnP0vKmEsv0KM+BNXzjq5ZWs2b
   Vm16MNN9Y3hfUUu7WRc35xXEhdxpXxAetsAMzoIabX5LaHHIgliPeLG6/
   COxGt1XwwcIaN5WkbAr8j/gpP1QR0jnv7X1HCDVUWNN/G1nBrj5XigOPa
   LWCR4nAfgdm2NqonVnNKGm5gN9THaVgjTN6SdoAdx4ruW+2TSh1acbE3D
   0ErxHoutUsgLu6QXwdCudGlVO6/1FIqcaD7LEPVSvMzUWH3iCdsKm5+P9
   uiA0QCozOP/CfqYqA/oJJ4ckS9qnXYZ2t9xJCXdG+Pud0B8gAVzpi9MwU
   Q==;
X-CSE-ConnectionGUID: /IUuYwinTyS/jqyjp1NGSA==
X-CSE-MsgGUID: 7ny05GgnRIOwcgm8wkzsZw==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="22928653"
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="22928653"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 03:27:26 -0700
X-CSE-ConnectionGUID: Vv8AGKtjT8qzzMYZMLeipQ==
X-CSE-MsgGUID: 8whYSqsURgacSJKhpyr0MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="53516406"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 03:27:23 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/7] wifi: iwlwifi: mvm: handle BA session teardown in RF-kill
Date: Mon, 13 May 2024 13:27:10 +0300
Message-Id: <20240513132416.0762cd80fb3d.I43c5877f3b546159b2db4f36d6d956b333c41cf0@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513102714.469087-1-miriam.rachel.korenblit@intel.com>
References: <20240513102714.469087-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

When entering RF-kill, mac80211 tears down BA sessions, but
due to RF-kill the commands aren't sent to the device. As a
result, there can be frames pending on the reorder buffer or
perhaps even received while doing so, leading to warnings.

Avoid the warnings by doing the BA session teardown normally
even in RF-kill, which also requires queue sync.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c  |  3 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c      | 12 ++++++++----
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 290670310ae8..70b769eb5861 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -6129,7 +6129,7 @@ void iwl_mvm_sync_rx_queues_internal(struct iwl_mvm *mvm,
 		.len[0] = sizeof(cmd),
 		.data[1] = data,
 		.len[1] = size,
-		.flags = sync ? 0 : CMD_ASYNC,
+		.flags = CMD_SEND_IN_RFKILL | (sync ? 0 : CMD_ASYNC),
 	};
 	int ret;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 0fcbc400caef..b98256edb52e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -1009,7 +1009,8 @@ static int iwl_mvm_mld_update_sta_baids(struct iwl_mvm *mvm,
 
 		cmd.modify.tid = cpu_to_le32(data->tid);
 
-		ret = iwl_mvm_send_cmd_pdu(mvm, cmd_id, 0, sizeof(cmd), &cmd);
+		ret = iwl_mvm_send_cmd_pdu(mvm, cmd_id, CMD_SEND_IN_RFKILL,
+					   sizeof(cmd), &cmd);
 		data->sta_mask = new_sta_mask;
 		if (ret)
 			return ret;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 491c449fd431..908d0bc474da 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -2836,7 +2836,12 @@ static int iwl_mvm_fw_baid_op_cmd(struct iwl_mvm *mvm,
 		.action = start ? cpu_to_le32(IWL_RX_BAID_ACTION_ADD) :
 				  cpu_to_le32(IWL_RX_BAID_ACTION_REMOVE),
 	};
-	u32 cmd_id = WIDE_ID(DATA_PATH_GROUP, RX_BAID_ALLOCATION_CONFIG_CMD);
+	struct iwl_host_cmd hcmd = {
+		.id = WIDE_ID(DATA_PATH_GROUP, RX_BAID_ALLOCATION_CONFIG_CMD),
+		.flags = CMD_SEND_IN_RFKILL,
+		.len[0] = sizeof(cmd),
+		.data[0] = &cmd,
+	};
 	int ret;
 
 	BUILD_BUG_ON(sizeof(struct iwl_rx_baid_cfg_resp) != sizeof(baid));
@@ -2848,7 +2853,7 @@ static int iwl_mvm_fw_baid_op_cmd(struct iwl_mvm *mvm,
 		cmd.alloc.ssn = cpu_to_le16(ssn);
 		cmd.alloc.win_size = cpu_to_le16(buf_size);
 		baid = -EIO;
-	} else if (iwl_fw_lookup_cmd_ver(mvm->fw, cmd_id, 1) == 1) {
+	} else if (iwl_fw_lookup_cmd_ver(mvm->fw, hcmd.id, 1) == 1) {
 		cmd.remove_v1.baid = cpu_to_le32(baid);
 		BUILD_BUG_ON(sizeof(cmd.remove_v1) > sizeof(cmd.remove));
 	} else {
@@ -2857,8 +2862,7 @@ static int iwl_mvm_fw_baid_op_cmd(struct iwl_mvm *mvm,
 		cmd.remove.tid = cpu_to_le32(tid);
 	}
 
-	ret = iwl_mvm_send_cmd_pdu_status(mvm, cmd_id, sizeof(cmd),
-					  &cmd, &baid);
+	ret = iwl_mvm_send_cmd_status(mvm, &hcmd, &baid);
 	if (ret)
 		return ret;
 
-- 
2.34.1


