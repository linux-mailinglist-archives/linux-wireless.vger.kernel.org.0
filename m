Return-Path: <linux-wireless+bounces-22497-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A34AAA283
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 01:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 284F63AAAAA
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 22:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE05280A3B;
	Mon,  5 May 2025 22:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLh2K/TG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CC92DAF9E;
	Mon,  5 May 2025 22:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483693; cv=none; b=bCt/XUdP7wf+ZiN/w3qM0Wh6ovR4P8zLrCWUsOrmTBq2uxKrF7suOpVz9mjd/+98ciKOMP7PHRHoTLAgsl3ybhW7wFcgNo2w0sj9y5f5k8kMctjm62QxRVPlu1nBg3Wt55uMMKhnmWkFUMKgEVFAVd04dPQrt6C3SeJgIiV07zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483693; c=relaxed/simple;
	bh=rwfp3rwV7Hldftal5rEpBflw9JYJBGFJqhLxGR+uRHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p/lhXPddLMvbaS/IpC9BIlRTKIa7w5TTsNWXFh2V2A70m7YWn3awhBVXWST1PKmH7gm8CewpvVxB0lu3K66ER0X2mIPwJqk4dp+QuihkCvIRtmK3MWZEr6mIWFBQ3y5qZBwDaq/Vm/QrVa2d4+UrDlGuGFR/rw/zJr1URqvolK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLh2K/TG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6366FC4CEEE;
	Mon,  5 May 2025 22:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483693;
	bh=rwfp3rwV7Hldftal5rEpBflw9JYJBGFJqhLxGR+uRHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JLh2K/TGEaCCgtv9BQIBRxYLp0zsOEUGSWcd0D7dvq//XgC2EsKVACZbywN32FrwC
	 yGo1hMRjTUHcyLLVE7A7df/9X+yrDlA3q8RSwUSaMo7s9xXU5YtdTmdZ3jIZg+QNyL
	 wg90CAWMNbKl4nHJ4ObWCKfbj4nyoaZONtrpfQyuFflARKmdHBiNg39mF6Hu6jiM9s
	 0u65pNPWbjzpI/K/2wiD8uKWu5OWtv8StBkhykn1yniXzrJCp5brhMp8XkcEYs/Mjw
	 oBtvGl/HvpRleXYnQhrku81/9j/PavV/NioiY6dE/wNNA8yw01o6Hig/UdH7+2JDUA
	 sH8/7P+kFp5Hg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 183/642] wifi: iwlwifi: fix debug actions order
Date: Mon,  5 May 2025 18:06:39 -0400
Message-Id: <20250505221419.2672473-183-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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


