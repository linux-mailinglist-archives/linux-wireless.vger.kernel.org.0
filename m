Return-Path: <linux-wireless+bounces-24349-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92406AE3DBC
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 13:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0BBE1897590
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 11:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFED323D284;
	Mon, 23 Jun 2025 11:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R81/LODI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52D319F480
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 11:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750677252; cv=none; b=V/al0R9cK8Dh1NqaRRx196Rl8XciGvKvZN/22GWr5qaIrHi6aisH6d2qDRvamDFARxrZ2t/YqCN8xeWhCaJq5eKm50Jbt5wEMQXRZHdUjKoyLypM4sMk+xOEXKVA2h8nl6OyZfYi9Wg8C3tdEKbMtPKrdMuwlH6vGrCSnBXClyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750677252; c=relaxed/simple;
	bh=RXP+6nxmiDyBjivK0O/Sitclnz0PuNOfD7kibkk0hHQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=j94KWgzqPQW8OR1Qv33uGHmewIngygFj3vjFANth2mJP2+23rXO2Kl3EG7p7qfaHwKW8/66G4uyvkgxjki9UspLu7uWgss31lXcHJrouBWWj2bIlBdaztYvfaCcmGsEMDM5IBljTrG9hcJO1TNOcDJZZZd3Ty/uGtReOqyCthp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R81/LODI; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750677251; x=1782213251;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RXP+6nxmiDyBjivK0O/Sitclnz0PuNOfD7kibkk0hHQ=;
  b=R81/LODIEKOU+q7A17HVmSXHPsSOehhS8JsLGCA5CPLhzSa4Wsm+sSlk
   NMwLQSzNGOUowX/5xS9lyVYuNUFdANoCbK2sKUz9lNz7b6V6DxSjEd8r0
   D3HOloCnyf+Db0Da1mymElmPdozqKCE8k75gxFF8W2kKzRkBNwwBjyJF2
   pXC7cfa4TJbnWdQ+QzkRFH0BlzKyFBu2sWUQXwDc4WXGobhlFCZ18L+RH
   F/RuI+sStPdDHpS7A7TZvggDQGMvT4j4Vn7k6iMYa3h+TzKyLTtZfCXrf
   kjFrwFvQ7YKlX3XlSJnSUMl3D/H6QsEtgM6idV2I6p19cOUmbRe5JvgGf
   Q==;
X-CSE-ConnectionGUID: /N1CdgVoSgCQWl+QWQ5HKw==
X-CSE-MsgGUID: B8Ny7yxKQLuAAfWEkHYJ5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="52595284"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="52595284"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 04:14:10 -0700
X-CSE-ConnectionGUID: Xw9/gVG8QS2XAOGPMmqsVQ==
X-CSE-MsgGUID: IRWI0oqOTQiQ6H2+Z5W5Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="155874754"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 04:14:09 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-fixes v2] wifi: iwlwifi: mvm: assume '1' as the default mac_config_cmd version
Date: Mon, 23 Jun 2025 14:13:51 +0300
Message-Id: <20250623111351.1819915-1-miriam.rachel.korenblit@intel.com>
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

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
v2: removed the check if the ver is smaller than 1, as it can't happen
now.

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


