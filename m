Return-Path: <linux-wireless+bounces-22560-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E411EAAA9D1
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 03:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4358F3BD27D
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 01:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4753936BFF4;
	Mon,  5 May 2025 22:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFh/EbhC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EDB3579C9;
	Mon,  5 May 2025 22:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485065; cv=none; b=YFPRM8X8xN0Qkf/u7Qt0W9n9HXVzPA1lAKQVHgS91pYNv1hLDJqapoeJ7ovs3Aiy+ALzsipgjMXs8Ts4CCjG9bVbAGgHCpqqMpz/kHXBazuAcSjaotOK2EJYWf+ccseZNqkdAGXK2MKDxajFGIaIqkw1un31JFihKSwrAuRzDtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485065; c=relaxed/simple;
	bh=rwfp3rwV7Hldftal5rEpBflw9JYJBGFJqhLxGR+uRHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pAEM9Mf5YiV5x/BIz3GeAhucNlMSEIKiC1BxP2DYu/qS6ch05lIKa33pU/z4aVoD3+us+kVE6bzdPBVQGI+wFduATj4T91w7xGUxaC3vDXtkFQuAjX+l52o9OdLt+dGTb3mL468m4oTGI6l4UUkmxCJeOn5DuVpTqPlmn9M33bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vFh/EbhC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1CAC4CEEE;
	Mon,  5 May 2025 22:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485064;
	bh=rwfp3rwV7Hldftal5rEpBflw9JYJBGFJqhLxGR+uRHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vFh/EbhCR67VD1io7Bscz5nH/8AiHHaL8CDl+zPv6WdNeJstP5nuSAUACn3dHozXS
	 Mo65fzlmkcuVkeX4xzgffw+ay7ypIysoxiRk/lE/WBtUmXf8NMBSrCB/No26CiFhnl
	 WVft1/T/3WfWEuURJZjS/9RUnUIY+KK4sT/WGDeoeL4xoEfnQX42Vc9P5VTuzazEnE
	 0Z6zEHHFBO4mPZGj51ZKUBHx9joDuUfxXVm0HrN8Ke1N+WKEvJlemHP3/trlmsdGvK
	 meREPdECSMVZ1JNKMmbMu1qkOsPAsS0QhKL6QXVPxLnFATNZoeNlwQgnhgF212siRc
	 izDFM8vgpFVbg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 149/486] wifi: iwlwifi: fix debug actions order
Date: Mon,  5 May 2025 18:33:45 -0400
Message-Id: <20250505223922.2682012-149-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit eb29b4ffafb20281624dcd2cbb768d6f30edf600 ]

The order of actions taken for debug was implemented incorrectly.
Now we implemented the dump split and do the FW reset only in the
middle of the dump (rather than the FW killing itself on error.)
As a result, some of the actions taken when applying the config
will now crash the device, so we need to fix the order.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20250308231427.6de7fa8e63ed.I40632c48e2a67a8aca05def572a934b88ce7934b@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 08d990ba8a794..ce787326aa69d 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2018-2024 Intel Corporation
+ * Copyright (C) 2018-2025 Intel Corporation
  */
 #include <linux/firmware.h>
 #include "iwl-drv.h"
@@ -1372,15 +1372,15 @@ void _iwl_dbg_tlv_time_point(struct iwl_fw_runtime *fwrt,
 	switch (tp_id) {
 	case IWL_FW_INI_TIME_POINT_EARLY:
 		iwl_dbg_tlv_init_cfg(fwrt);
-		iwl_dbg_tlv_apply_config(fwrt, conf_list);
 		iwl_dbg_tlv_update_drams(fwrt);
 		iwl_dbg_tlv_tp_trigger(fwrt, sync, trig_list, tp_data, NULL);
+		iwl_dbg_tlv_apply_config(fwrt, conf_list);
 		break;
 	case IWL_FW_INI_TIME_POINT_AFTER_ALIVE:
 		iwl_dbg_tlv_apply_buffers(fwrt);
 		iwl_dbg_tlv_send_hcmds(fwrt, hcmd_list);
-		iwl_dbg_tlv_apply_config(fwrt, conf_list);
 		iwl_dbg_tlv_tp_trigger(fwrt, sync, trig_list, tp_data, NULL);
+		iwl_dbg_tlv_apply_config(fwrt, conf_list);
 		break;
 	case IWL_FW_INI_TIME_POINT_PERIODIC:
 		iwl_dbg_tlv_set_periodic_trigs(fwrt);
@@ -1390,14 +1390,14 @@ void _iwl_dbg_tlv_time_point(struct iwl_fw_runtime *fwrt,
 	case IWL_FW_INI_TIME_POINT_MISSED_BEACONS:
 	case IWL_FW_INI_TIME_POINT_FW_DHC_NOTIFICATION:
 		iwl_dbg_tlv_send_hcmds(fwrt, hcmd_list);
-		iwl_dbg_tlv_apply_config(fwrt, conf_list);
 		iwl_dbg_tlv_tp_trigger(fwrt, sync, trig_list, tp_data,
 				       iwl_dbg_tlv_check_fw_pkt);
+		iwl_dbg_tlv_apply_config(fwrt, conf_list);
 		break;
 	default:
 		iwl_dbg_tlv_send_hcmds(fwrt, hcmd_list);
-		iwl_dbg_tlv_apply_config(fwrt, conf_list);
 		iwl_dbg_tlv_tp_trigger(fwrt, sync, trig_list, tp_data, NULL);
+		iwl_dbg_tlv_apply_config(fwrt, conf_list);
 		break;
 	}
 }
-- 
2.39.5


