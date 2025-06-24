Return-Path: <linux-wireless+bounces-24402-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCD0AE5CDC
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 08:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F2D17AFAE3
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 06:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D0913B284;
	Tue, 24 Jun 2025 06:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TxkvhFfX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EF8239E7E
	for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 06:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750746925; cv=none; b=uyOYsVlvk5oqSFUT+PNL/r/Qim4bKj/NFHeRr+RP0kDvJUw7mq0yHC1L4rE+TUrEVFCbipRMbYeFqWOSNPtjdUPyFFZ6iQGeAhiGzba8xVYGnGMaWmsLh2mk3vLIpVy+Db8hay+PPLdmF8Z1n45oJEeURlfFfRt9mJcTE9AXIZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750746925; c=relaxed/simple;
	bh=oGkj88TDdsDRGp2UGsDvOTyTnTDkurrqYBixnBW6fMc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=CTyZkKew2QG8RHbqjnJmz0jljusLyPPFl0CjteCazI+zDdg+O5HZbshi+w/slwn6/pi8iIna5jkEBoCVqHjWG6GvVdguzYwyPKRU8mJ+XPr3yST5hxuQvmi6XrU2w/huyYf2Nql6ft5Uq4sjzCBteYHEYa7MjjIR+84AOgJeQB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TxkvhFfX; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750746923; x=1782282923;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oGkj88TDdsDRGp2UGsDvOTyTnTDkurrqYBixnBW6fMc=;
  b=TxkvhFfXsFRc94jdcPmq97NK7ayQAX8z3S/WKE2MHInyxknWjIBGmRSL
   /H8UOlYgElOhm3Uj17tb2hpG7VHS0iszI9IwrCdMGX//7OnQPjwjRodl7
   BKGz9vs31cJouwm1M1R6vI4hZXFl29p3MJ8YpSL0cgWQliaCGX02P5lO7
   sQ6QkhU1bIjlPxC/llII6U839fDWwwijIFMB+Y0TgknpMA/sWvlDBkzUl
   9wZMV/NkNURKnVyg63pmIWt9ZVt3tpRH/Qo9iIj9rU9ouk8llKQhXgcZy
   1mBNblL6Z45q5GY+gBGWayVZTw7SLmcY/aA8aWACImoxempMCz+XIpx38
   w==;
X-CSE-ConnectionGUID: Iq9UCf2xTbSd2LdmYu8aYQ==
X-CSE-MsgGUID: 9gt8gwe7RF6IN/R4633dRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="63575373"
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="63575373"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 23:35:22 -0700
X-CSE-ConnectionGUID: WbEDjGg+RB6HkJ4eEXBNlw==
X-CSE-MsgGUID: S9fiGKOiRsO6wQ1eKIKhCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="152344653"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 23:35:22 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-fixes v3] wifi: iwlwifi: mvm: assume '1' as the default mac_config_cmd version
Date: Tue, 24 Jun 2025 09:35:03 +0300
Message-Id: <20250624063503.2628269-1-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Unfortunately, FWs of some devices don't have the version of the
iwl_mac_config_cmd defined in the TLVs. We send 0 as the 'def argument
to  iwl_fw_lookup_cmd_ver, so for such FWs, the return value will be 0,
leading to a warning, and to not sending the command.

Fix this by assuming that the default version is 1.

Fixes: df6146a0296e ("wifi: iwlwifi: Add a new version for mac config command")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
v2: removed the check if the ver is smaller than 1, as it can't happen
now.
v3: added a Fixes tag

 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
index 3c255ae916c8..3f8b840871d3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
@@ -32,9 +32,9 @@ static void iwl_mvm_mld_mac_ctxt_cmd_common(struct iwl_mvm *mvm,
 	unsigned int link_id;
 	int cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw,
 					    WIDE_ID(MAC_CONF_GROUP,
-						    MAC_CONFIG_CMD), 0);
+						    MAC_CONFIG_CMD), 1);
 
-	if (WARN_ON(cmd_ver < 1 || cmd_ver > 3))
+	if (WARN_ON(cmd_ver > 3))
 		return;
 
 	cmd->id_and_color = cpu_to_le32(mvmvif->id);
-- 
2.34.1


