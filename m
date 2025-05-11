Return-Path: <linux-wireless+bounces-22850-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F29BAB29CB
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 18:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBAD23A675C
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 16:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0137225D535;
	Sun, 11 May 2025 16:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ifVgAOqL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B8C25D523
	for <linux-wireless@vger.kernel.org>; Sun, 11 May 2025 16:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746982430; cv=none; b=DaSMUYCT3A7eWBXChDM3jqnlW/o4b/wh6b0TScL0+UCmQHKhivWI3qf8kre18/uciCt1/Ge0qj4hOPPHRLYy63uT0f0Rk7zeeOhccFOEkZdtCFPrMOuuV/kwb0l64Oh9RlwgBNVGA4uYqAOtud46Q4qlNoSWsyszRUzyDHHVvW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746982430; c=relaxed/simple;
	bh=GIpiI8d8bc2hg6bt1DXiwtGCVwVTLAVWpfTYXcN/Wk4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mkMaZtmpP9MmZcj1VkQ/WSducyUy4Ki18G3aJVC2ypll5PfuIAUaV/Ev7GuQxshhoxL9sCo0kgUrC9WupLTr8aoH6aWR5/gWldxx4eXDZ7Fg3/gLEoo96pEEqptCr4e9XoHwbWdrTjviocgZ/KyaPiiDOQBb7cN3MAzrYPvUWdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ifVgAOqL; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746982430; x=1778518430;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GIpiI8d8bc2hg6bt1DXiwtGCVwVTLAVWpfTYXcN/Wk4=;
  b=ifVgAOqLXBqcAWm9yP5nldpC9H3zBNX70gqpiO7v426eUIWGUu9pJbpB
   FhECDQSLPLQjBviWlJBR8EuDHficgIxDIir+vAIKUR0WkyniRK+KWqJw0
   Z1Ic4JqyrqMrPnGTBbO/zClxmYwaQT9KjrKLt5uSs+TcjbREDY7rUkuN8
   a3+U9MsjLsDsqJ89t5HKw9pV+JwAqJ4xT/7nXAkYTn9zD1LGk4Z/Lr+hP
   QQWMsWT6+4xnzZHTVbQJuk7gf1WSbiqMzrFI13FGeEbkqKXJRP4DhUhVq
   ZdWf3R3t7w4p7cmYX3SnnuW5kC9/r27vdAfpNoxz7rYdqCNRvP5IkEEl1
   Q==;
X-CSE-ConnectionGUID: HxOcYGMbSga7x/coiR412A==
X-CSE-MsgGUID: phMPv4GXQjq+CurKboPYBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="52582699"
X-IronPort-AV: E=Sophos;i="6.15,280,1739865600"; 
   d="scan'208";a="52582699"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 09:53:49 -0700
X-CSE-ConnectionGUID: UrscfRm4TRilLFGUMX2FzA==
X-CSE-MsgGUID: 6boMdUf2TGOZgA0NqPfkzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,280,1739865600"; 
   d="scan'208";a="137655081"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 09:53:49 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 11/15] wifi: iwlwifi: map iwl_context_info to the matching struct
Date: Sun, 11 May 2025 19:53:17 +0300
Message-Id: <20250511195137.a7240935006e.I75e2e13421b5dac2c1bdbd01fdfd34c38f2d3d8c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250511165321.590808-1-miriam.rachel.korenblit@intel.com>
References: <20250511165321.590808-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Map iwl_context_info to the matching struct in the FW.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-context-info.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-context-info.h b/drivers/net/wireless/intel/iwlwifi/iwl-context-info.h
index 062334e1c449..7ae0fbdef208 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-context-info.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-context-info.h
@@ -179,7 +179,7 @@ struct iwl_context_info {
 	__le32 reserved2[16];
 	struct iwl_context_info_dram_nonfseq dram;
 	__le32 reserved3[16];
-} __packed;
+} __packed; /* BOOT_LOADER_CONTEXT_INFO_S */
 
 int iwl_pcie_ctxt_info_init(struct iwl_trans *trans, const struct fw_img *img);
 void iwl_pcie_ctxt_info_free(struct iwl_trans *trans);
-- 
2.34.1


