Return-Path: <linux-wireless+bounces-9159-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0147D90CC0E
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 14:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3900A284DB4
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 12:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934C313D242;
	Tue, 18 Jun 2024 12:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqp+3PSk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695F713CFBD;
	Tue, 18 Jun 2024 12:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714223; cv=none; b=Hyr1zc0m3EMwt71/WSX1jrBlI1w9EC5BRJxmLH2Mc0hHt6L1LC9XBsikemyB+Nwwi36QOMbx6m2dUFku92mlrlwIrF6EBQ+DOcFzvaPNnM809P7VE3jY/tf5/M73cdnsz3JjIvK0ZC19E1QEr673Lqkst4u64w1zOv9vU4J/4E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714223; c=relaxed/simple;
	bh=NkI3c3iYst98/SZuV5LeFHrWGYrCSmQ6eVKN/G+NLys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DUsNc2ZqhE3SJyc9MdsMn0VQ4KMkkrrCvxGjCsS8G0ukFPqXg1DyyAQXxGOjQXx2LYsCvosbi/cVy3w3l4sA8+uRMRFgdf9Xkb3aFlGFDUn5Hol5zvGKZqm3lmzBkGJD/eGAhvRboOD0FGUFeJl5jAnQMRHUVgHhfhurOKMTKiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqp+3PSk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B740FC32786;
	Tue, 18 Jun 2024 12:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714223;
	bh=NkI3c3iYst98/SZuV5LeFHrWGYrCSmQ6eVKN/G+NLys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nqp+3PSkIOk3oo5BvdV5XJPOx+fEg4359R5/6bO+uNVTJZLcDdiHbDi5hbMD9/6OY
	 p3zIlCn2//8sNtVBd2ZBHNHpL3cjwnYUy8beNZm2MziCC6H/47jAIS8tQJAd8eQos6
	 nmUnaqF7A5cT9ee5E4NAbWWNNfYY79J2aAVeHmncOUvU3ZwWNIKN4VZBUyfHfp342Z
	 hlRAxSvKvohZjVBAzvhfGRz5p6uema+M4MtHvDP+mYsp3Oo4GQYvWjhMWJMGKitd3Z
	 LlC38BY4aLxCB/oeNFDqnpYxcyU3hogCWiHIeFuHFZUgHEsSz/N8wE6P1VXHdZHP92
	 I9QlD5KYE+G8A==
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
	daniel.gabay@intel.com,
	dan.carpenter@linaro.org,
	andrei.otcheretianski@intel.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 21/44] wifi: iwlwifi: mvm: handle BA session teardown in RF-kill
Date: Tue, 18 Jun 2024 08:35:02 -0400
Message-ID: <20240618123611.3301370-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618123611.3301370-1-sashal@kernel.org>
References: <20240618123611.3301370-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.5
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
index d2557d9f63e59..02f181a2b983f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -6162,7 +6162,7 @@ void iwl_mvm_sync_rx_queues_internal(struct iwl_mvm *mvm,
 		.len[0] = sizeof(cmd),
 		.data[1] = data,
 		.len[1] = size,
-		.flags = sync ? 0 : CMD_ASYNC,
+		.flags = CMD_SEND_IN_RFKILL | (sync ? 0 : CMD_ASYNC),
 	};
 	int ret;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index a21e29947475f..dbe668db7ce37 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -1012,7 +1012,8 @@ static int iwl_mvm_mld_update_sta_baids(struct iwl_mvm *mvm,
 
 		cmd.modify.tid = cpu_to_le32(data->tid);
 
-		ret = iwl_mvm_send_cmd_pdu(mvm, cmd_id, 0, sizeof(cmd), &cmd);
+		ret = iwl_mvm_send_cmd_pdu(mvm, cmd_id, CMD_SEND_IN_RFKILL,
+					   sizeof(cmd), &cmd);
 		data->sta_mask = new_sta_mask;
 		if (ret)
 			return ret;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 491c449fd4316..908d0bc474da6 100644
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
2.43.0


