Return-Path: <linux-wireless+bounces-24407-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D66AE5D7E
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 09:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9DF57A5435
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 07:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D872505A9;
	Tue, 24 Jun 2025 07:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eMH6gfji"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1434A1F463B
	for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 07:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750749289; cv=none; b=caUXqXnvv7UJWkUnCXKHwWf6aWEy9GS51ojqn+CRYA+t75DZv4uLuNDjhWAUXN2qQwxu9cuStpTadZL0t8IrKFtHvUxfPuJLniFyVXApnCnj/MP3f65S7lD88DkHiTxGFIy3TJXxxMqd2w0b+yY8YkVpip2DssCxutpUW/hX8Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750749289; c=relaxed/simple;
	bh=K/q4hvU0LToV5FxsuEeMZMknRuqoIrTGCKFnU+j1frU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=rmVgpoztEnJzaiStXMGlVheHo1FXEs8SBHRwqvlvscCH1yD6UOQxoJ3CD6pBic0LcwPM9+m3oCuxsGMymOMA/8EVGW4I2PyLz31DRVrz9RMzSk+B5ZUwK2RMaQ3Vg/fq2SYHpc7SF3spA8nK6wfSu2Dt6M8qLRekdEtM+ac5f9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eMH6gfji; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750749287; x=1782285287;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=K/q4hvU0LToV5FxsuEeMZMknRuqoIrTGCKFnU+j1frU=;
  b=eMH6gfjib4jVY1BTe/ZC79eF+eZM39Z8xoNNB4NwZ4B1RxWVaEhVVSwF
   LNDz4E9fCtioRgowOFOoPVsB7r6/llQwkEIN/aUe/777PYIZPDe2PaqDv
   MGpO3zZajI3mWY6LeewFe7tyvyU5vjpho6m1Jih6w48lC64o+bi+Z0ZUU
   xPtrjiCr67DOJrrNn0ytlmeJhdNh3R7SMbN0BBfgJylfZHhk5JPgC/2oT
   99tjGz1PZoTK9Zxm1gkNqf3fw+/f6Xc1nEoxG06LDdhRdiWJh7wvsgVUC
   NFrhfukhwlo5uesHkqVOWLy+9v4CxBPtJLaACxxA0eqWEvOFOjvjmH3SA
   g==;
X-CSE-ConnectionGUID: IxJsNllvTne7zji0Z/4LsA==
X-CSE-MsgGUID: ld4qZ09oTqGfYVmbOcWwSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="53110152"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="53110152"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 00:14:47 -0700
X-CSE-ConnectionGUID: DC542Wp6Qq+u7FU1jlFqgg==
X-CSE-MsgGUID: kJoPHdSDTKCf5wYFcz55GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="152135557"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 00:14:46 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-fixes v4] wifi: iwlwifi: mvm: assume '1' as the default mac_config_cmd version
Date: Tue, 24 Jun 2025 10:14:27 +0300
Message-Id: <20250624071427.2662621-1-miriam.rachel.korenblit@intel.com>
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

Fixes: 83f3ac2848b4 ("wifi: iwlwifi: Fix incorrect logic on cmd_ver range checking")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
v2: removed the check if the ver is smaller than 1, as it can't happen
now.
v3: added a Fixes tag
v4: changed the Fixes tag to the commit that introduced breakage

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


