Return-Path: <linux-wireless+bounces-23971-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A889BAD4973
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 05:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C11A4169096
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 03:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74441211497;
	Wed, 11 Jun 2025 03:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f9Vma70Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E173D225A31
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 03:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749612890; cv=none; b=r7/jSrMlBCTkcoYhaaz+cRCzXyRsYSFgCw1cSWlCo1hNxEK/XM8vB/Nluh77pQuZVb3ZGqknL+dHLPHSynDEsNPEGRkryMddWp1RyceGWuVLqBWm/NrE49vBhsoJgmGLE2aazoUDP/+I8SdbILU4rVaF3ncH5lhmPVV4e4CiYrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749612890; c=relaxed/simple;
	bh=KGUc9nQ+tQ6kA7ubenYZgsBUkTWSIrfjmkv/zCoM5zM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TeECEpCW66PSBTHZdd/p/K1jr+YK2PhwrtghoqC6JbIbf8m6KYFzsJgFvnbRIuVUADA9IGUin9qVImWPg7zskt1hCzgIEE5HM+TpeKSYxn5x7y7siduOU1aeecgCI51fwbAyC61xIB5CFaeEn6ZfM1hhPimng4uhM+Ov3ankiMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f9Vma70Q; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749612889; x=1781148889;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KGUc9nQ+tQ6kA7ubenYZgsBUkTWSIrfjmkv/zCoM5zM=;
  b=f9Vma70QJ0pnfLQgxyUrYxCEfqv8cF4SoCFBzq7/xfGkv2CLioPb0eqR
   ZZ76vBCJWNXF0HRbvjtC3mbV4zhKQ7Jt/V9EAkQXqxPxt0guSjvZSwGom
   BIaXJlSMaaMF0HKtPINxsas3w1RrPn9UZ5beouKGxhcNJKxbIfnH46wbp
   vUqIePOuHmHlRmeDzJm+N5IHL0UemEYX9OQtIT78BsFT6roF2jkVodewq
   LYZ3LUKe3EXnDJYDGaeUEKQHoTz3ePZx2XDCYxdauvK+xU2219RWXS7kn
   kY5wzzlz2teHgloxr6CJWGqSuu2lpV7wqMPy7fy8eps7W1qrwAI3fnrYF
   Q==;
X-CSE-ConnectionGUID: pkpwBG1/ROicrdUiKHhdNQ==
X-CSE-MsgGUID: nA+d3TGXRaqkV5higP4Psw==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="63094898"
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="63094898"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 20:34:49 -0700
X-CSE-ConnectionGUID: Uywo3k28QEmQWQCUVR/hbQ==
X-CSE-MsgGUID: vTwgWXZdSW+f3TyKLq6orA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="150880982"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 20:34:47 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 14/15] wifi: iwlwifi: mld: make PHY config a debug message
Date: Wed, 11 Jun 2025 06:34:14 +0300
Message-Id: <20250611063124.72df4e8357f3.I2cf4e1e2e604b42b6eb9737c0ef3b75fec69edea@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611033415.1175681-1-miriam.rachel.korenblit@intel.com>
References: <20250611033415.1175681-1-miriam.rachel.korenblit@intel.com>
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


