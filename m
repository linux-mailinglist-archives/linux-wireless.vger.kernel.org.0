Return-Path: <linux-wireless+bounces-9170-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B091890CC8D
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 14:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19805285891
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 12:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DC8153506;
	Tue, 18 Jun 2024 12:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KF021jOF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9EE152E00;
	Tue, 18 Jun 2024 12:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714359; cv=none; b=kr73BQWuG94BgGQ2LHJE0ZKJDEdxVU6Ltl7mmteXOrDZbKfsSHfi1WMh6ydGj23auYdMnEMRXXCkMeW8Z2w8S/NJZHWjaQHvuWLBFCTs/IzJYIFJ36tPy8eDwxNfFwn59PznfRaOrbWyysCG9l5z2w11e7QQDe8UGcKR16Fzf1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714359; c=relaxed/simple;
	bh=/j+FhUnvdee0q69aEOnSKLN0Huq7fR9myK//MpH3GJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XIb3FaaixVNNDGC1Mi1z0YmVHOM5uHPEq11mAHEOH9RpKlL0I8eUA80jbyWb8re4CMwMfpZawTikmfk3hF4d7qpNRBGQ8epabIUMorzl3HPC1gHn6JbEj2ES1o/91NV8toPydxfxL3QVLyfVYw7gupCdF5AvKCGAVaSP/PB3TzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KF021jOF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA19C3277B;
	Tue, 18 Jun 2024 12:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714358;
	bh=/j+FhUnvdee0q69aEOnSKLN0Huq7fR9myK//MpH3GJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KF021jOF5OMb7gxXLuntYbHSbbv7MPJAsuSrc+MsjaA9tvtaC57G7OqWrXKAiGCxS
	 LpSr0qcSXEpthyrb/4uKMJYZB0EhheJHzf5BB9kxkk3sPSoai4opQTDr+kFP/WMYKU
	 55qzFC9ZJyn8faDCUbNVZrGnnfa5H+QaX5KI7sjKNyLxa8zFEDZUryIXcZhtBtJT6y
	 nAuBmxAqdcgLCxPxqTzj+gXZbrO9r1UTyvOGZR/b8v+r3IyZAFqbOnxt4bKWer33D4
	 GCBHsil6ms5w70haJW7iNIgxer7tQCM12YGNOF94+zpyP/ZVQA67CfzYiXgHxZA9/K
	 2Isp8RXeC0iHQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	gregory.greenman@intel.com,
	emmanuel.grumbach@intel.com,
	ilan.peer@intel.com,
	benjamin.berg@intel.com,
	shaul.triebitz@intel.com,
	dan.carpenter@linaro.org,
	andrei.otcheretianski@intel.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 18/35] wifi: iwlwifi: mvm: handle BA session teardown in RF-kill
Date: Tue, 18 Jun 2024 08:37:38 -0400
Message-ID: <20240618123831.3302346-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618123831.3302346-1-sashal@kernel.org>
References: <20240618123831.3302346-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.34
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 4d08c0b3357cba0aeffaf3abc62cae0c154f2816 ]

When entering RF-kill, mac80211 tears down BA sessions, but
due to RF-kill the commands aren't sent to the device. As a
result, there can be frames pending on the reorder buffer or
perhaps even received while doing so, leading to warnings.

Avoid the warnings by doing the BA session teardown normally
even in RF-kill, which also requires queue sync.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20240513132416.0762cd80fb3d.I43c5877f3b546159b2db4f36d6d956b333c41cf0@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c  |  3 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c      | 12 ++++++++----
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index e281e07be73fc..37f628a9b8115 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -6069,7 +6069,7 @@ void iwl_mvm_sync_rx_queues_internal(struct iwl_mvm *mvm,
 		.len[0] = sizeof(cmd),
 		.data[1] = data,
 		.len[1] = size,
-		.flags = sync ? 0 : CMD_ASYNC,
+		.flags = CMD_SEND_IN_RFKILL | (sync ? 0 : CMD_ASYNC),
 	};
 	int ret;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 2dcc13d4a4a79..e87cc1ddb9c2f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -1007,7 +1007,8 @@ static int iwl_mvm_mld_update_sta_baids(struct iwl_mvm *mvm,
 
 		cmd.modify.tid = cpu_to_le32(data->tid);
 
-		ret = iwl_mvm_send_cmd_pdu(mvm, cmd_id, 0, sizeof(cmd), &cmd);
+		ret = iwl_mvm_send_cmd_pdu(mvm, cmd_id, CMD_SEND_IN_RFKILL,
+					   sizeof(cmd), &cmd);
 		data->sta_mask = new_sta_mask;
 		if (ret)
 			return ret;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 2c231f4623893..84f4a9576cbda 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -2819,7 +2819,12 @@ static int iwl_mvm_fw_baid_op_cmd(struct iwl_mvm *mvm,
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
@@ -2831,7 +2836,7 @@ static int iwl_mvm_fw_baid_op_cmd(struct iwl_mvm *mvm,
 		cmd.alloc.ssn = cpu_to_le16(ssn);
 		cmd.alloc.win_size = cpu_to_le16(buf_size);
 		baid = -EIO;
-	} else if (iwl_fw_lookup_cmd_ver(mvm->fw, cmd_id, 1) == 1) {
+	} else if (iwl_fw_lookup_cmd_ver(mvm->fw, hcmd.id, 1) == 1) {
 		cmd.remove_v1.baid = cpu_to_le32(baid);
 		BUILD_BUG_ON(sizeof(cmd.remove_v1) > sizeof(cmd.remove));
 	} else {
@@ -2840,8 +2845,7 @@ static int iwl_mvm_fw_baid_op_cmd(struct iwl_mvm *mvm,
 		cmd.remove.tid = cpu_to_le32(tid);
 	}
 
-	ret = iwl_mvm_send_cmd_pdu_status(mvm, cmd_id, sizeof(cmd),
-					  &cmd, &baid);
+	ret = iwl_mvm_send_cmd_status(mvm, &hcmd, &baid);
 	if (ret)
 		return ret;
 
-- 
2.43.0


