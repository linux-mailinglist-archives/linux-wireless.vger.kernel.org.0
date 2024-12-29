Return-Path: <linux-wireless+bounces-16878-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F175F9FDF4F
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Dec 2024 15:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4AF61619B5
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Dec 2024 14:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9285B198A37;
	Sun, 29 Dec 2024 14:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J1Fvauwr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611EC18858A
	for <linux-wireless@vger.kernel.org>; Sun, 29 Dec 2024 14:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735483535; cv=none; b=LbM16awtCYzXV6z0evBRdcFxsITbipV6mxhY1+YHuCZIXuYmwZMtXtqBuU1ncqXPVaOCOS2H7dHCK4mTaNrbUm9YJ0XIiAZBTCFKvzU9jU7VLD4F3XyvMDPvEVLzZwIhFVgzO5WfB8FZQD+iNXY91EBbjRLQ6hfTDj1gltTOHhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735483535; c=relaxed/simple;
	bh=DudXzUWQMviBDrQP27WOMvgT9tjebUl0SkTCcNnojoI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b2qeD5kLuTjGHTovKLsxd9YkpknWW0VB3zVHkpWwcfOTl4mLvRwKJMkZxoP+E1vVSqDQvLaNNBnna6oqWYZyV3Gr99myJyz1zz+/BuGYSiVhpsd620egi7KY2GSXyLy4kGvbIlbUkaIIx9MjB3ohJESCeR3zS1mXDmo/X06u5eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J1Fvauwr; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735483534; x=1767019534;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DudXzUWQMviBDrQP27WOMvgT9tjebUl0SkTCcNnojoI=;
  b=J1FvauwrIp3KMI8eKKJJSfCjeaO/QFkyUBW3dfOOC6mjZvS1uWhhqBgG
   13VuSqJ8McRsfJ28TTw6d3qP7yrTVJMBFWqiquwFweCtY4DXvdf7irz+x
   GPEsZb3iLLw+eo1StROmsxQBWs1/fyRqA8KoLjRSsU555muO4wGgSIEJ+
   jNH+URHkLVPzftAf2ObSChtRpgJNn4VutFE3Uf1ziuKs6koFqOYtLry7m
   uL67OH0hDFdbOeN2oBjHzVSBcQDxAjVnYj/hQ0Dk8sdEQO3ZpgUlxJ6wO
   ZjG+3oAe3w6EXErwvazM0SgeYZLPb6p+U+/5OaNIsWED+CT1IPcYdCQBu
   Q==;
X-CSE-ConnectionGUID: KUIfUgDjSJSFDGokxPR31w==
X-CSE-MsgGUID: MoQg83CtROiuYh82cH8QJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="39572474"
X-IronPort-AV: E=Sophos;i="6.12,274,1728975600"; 
   d="scan'208";a="39572474"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 06:45:34 -0800
X-CSE-ConnectionGUID: XizIEBuWSLSYi1kUZs5m3A==
X-CSE-MsgGUID: dxn9FWThQgyN8pqiEK1lNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="105657007"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 06:45:32 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Jilin Yuan <yuanjilin@cdjrlc.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 17/17] wifi: iwlwifi: fw: fix repeated words in comments
Date: Sun, 29 Dec 2024 16:44:52 +0200
Message-Id: <20241229164246.2981c3b5a40e.I96ebda41f230d453d4bc0afb01ac43011c13a182@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241229144452.3151163-1-miriam.rachel.korenblit@intel.com>
References: <20241229144452.3151163-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Jilin Yuan <yuanjilin@cdjrlc.com>

Delete the redundant word 'for'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
Link: https://msgid.link/20220709140036.48913-1-yuanjilin@cdjrlc.com
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/paging.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/paging.c b/drivers/net/wireless/intel/iwlwifi/fw/paging.c
index 945bc4160cc9..a7b7cae874a2 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/paging.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/paging.c
@@ -249,7 +249,7 @@ static int iwl_send_paging_cmd(struct iwl_fw_runtime *fwrt,
 	};
 	int blk_idx;
 
-	/* loop for for all paging blocks + CSS block */
+	/* loop for all paging blocks + CSS block */
 	for (blk_idx = 0; blk_idx < fwrt->num_of_paging_blk + 1; blk_idx++) {
 		dma_addr_t addr = fwrt->fw_paging_db[blk_idx].fw_paging_phys;
 		__le32 phy_addr;
-- 
2.34.1


