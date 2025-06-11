Return-Path: <linux-wireless+bounces-24014-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A931AD5F12
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 21:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 474D63A8F02
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 19:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DC32BDC02;
	Wed, 11 Jun 2025 19:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NeWyCgzX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720772BD5AE
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 19:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749670029; cv=none; b=mTRVYlaKxNj4GqiRjI4LNTFNkypsQ1Fs7WJ4iR7XVqbFF3/P6vAqfcslXsQDCqXYSxM2xXo8E6hY7tkad6D4GLrQlpDwFj5ucXUH+gOrF92TYXycdGwdMIeG0JJ7bktia5fW/Q/cdg09DtFpSRcU+TZh3A8IlOOJn3SRjdvYW+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749670029; c=relaxed/simple;
	bh=KGUc9nQ+tQ6kA7ubenYZgsBUkTWSIrfjmkv/zCoM5zM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d5p/stBVbFwZO8weWk5qS8mpabenj9u17upfgdBKEqOwFL1Vuaz8Ccprs9acPrh4NfxmSMG2kd8vJKidU4z5wkFcXP80zXBoQohL2RR5frYnsKWCO3YDpkfpaUp89e4/fTp5j2P/v1K5yvglP4F/apWionFVnZgubVpdMWpw/pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NeWyCgzX; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749670029; x=1781206029;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KGUc9nQ+tQ6kA7ubenYZgsBUkTWSIrfjmkv/zCoM5zM=;
  b=NeWyCgzX7GNpjQl5lC3vQaL36MPiTh92lc7t/ppPkYVD2mnZaYxuYNgZ
   FBcE3HT82WF9zyokF5jhgSEjkN0wr46OGkhAqu/JB/Http8l86fl5FVP6
   uAd5/1Rjbm33Yr7lFwvh+4gexTnHexYQioAPSrmVB0/bfrYuDGp9chPxC
   qXi5C3SR5kJGokdAx6mLA5UdQ4ruzHI0Z9Z57K18MiZHmQgs2XmBqD8yd
   bCihlTb/tEEj8dyAG3k3C+qxOcbRJg0lYUL8pTH6VZ3ID8G/ebBShfWr9
   BFQjGf+LYjS8yIdX1iDMZgAmIizysnB3KMXWJPeMlvIcpMbMlWnnxWsQy
   Q==;
X-CSE-ConnectionGUID: OMP6bC0DQEK9qYgMbgJvBQ==
X-CSE-MsgGUID: 4S6/eF8KSd+ew4GOwib4YA==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="74360905"
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="74360905"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 12:27:09 -0700
X-CSE-ConnectionGUID: eUV1BuQ8RjKbwA+u2b9LjA==
X-CSE-MsgGUID: 6WhQ/IMVRzqRbbK7tvMwCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="147165889"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 12:27:07 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next v2 14/15] wifi: iwlwifi: mld: make PHY config a debug message
Date: Wed, 11 Jun 2025 22:26:33 +0300
Message-Id: <20250611222325.ee6254c03a33.I2cf4e1e2e604b42b6eb9737c0ef3b75fec69edea@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611192634.2416885-1-miriam.rachel.korenblit@intel.com>
References: <20250611192634.2416885-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This means nothing to a normal user and really has no value
for most people, print it as a debug message instead.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/phy.c b/drivers/net/wireless/intel/iwlwifi/mld/phy.c
index d5a32ee56b92..1d93fb9e4dbf 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/phy.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/phy.c
@@ -181,7 +181,7 @@ int iwl_mld_send_phy_cfg_cmd(struct iwl_mld *mld)
 		.phy_specific_cfg = mld->fwrt.phy_filters,
 	};
 
-	IWL_INFO(mld, "Sending Phy CFG command: 0x%x\n", cmd.phy_cfg);
+	IWL_DEBUG_INFO(mld, "Sending Phy CFG command: 0x%x\n", cmd.phy_cfg);
 
 	return iwl_mld_send_cmd_pdu(mld, PHY_CONFIGURATION_CMD, &cmd);
 }
-- 
2.34.1


