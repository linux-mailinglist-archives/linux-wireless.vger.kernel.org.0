Return-Path: <linux-wireless+bounces-9903-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 770B192578C
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 11:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11FADB2440E
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 09:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9B51428EA;
	Wed,  3 Jul 2024 09:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l2L/PINN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92B01422DE
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 09:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720000758; cv=none; b=qY28KOm1AdOgliRvofDQi8dkRn/8xHjZi8ByWiwqhhIMV2JvptTQOXTCI7LXa4mvwpDDI3Kr0DHgGBFq2ixIb4hhDH3DYhLLvRTk4WUaP5hv/2F6QxTa3eol0pYnGgDLdbzbZocN7io9avLZ/lOhj58RSjQWF5dtawdmfNp13Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720000758; c=relaxed/simple;
	bh=x1FallbPa5TeFL/WOMulSew7zL3Dl2LRUXNPDSvR8GI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fWua9N0tpLXgdSwAMpIIKgMni0seZoq21212kpDM0oPXu4+ziYTjkLZNvB5ahtBCyIoQHBK4s8aHTKJZyDUcHiLEJW6qIVQu7XXFx6gQhHGj21scwuPyLDPaT56K23RE22T6/0Cq0opPzJLbju5o4iS0LpqAqEKmJHkpd8CYorY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l2L/PINN; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720000757; x=1751536757;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x1FallbPa5TeFL/WOMulSew7zL3Dl2LRUXNPDSvR8GI=;
  b=l2L/PINNp9LFLVjDRRg+WXcM/kyFjwtA12i5YYhkf7cWsSDQZp98aw+n
   9UK2K1un3XMZWXmDxEiKRwB46Ja+/ejqrjoHleElatQ4aicbfzHLt0r0k
   V+4BbMk8qPlUAvZhwZYPnbVVQoDyJk2+6QvQDv4Iok38HvTDL74EiHYmf
   wjX8AlRws0MKrjEMlfa/QlEAGJ5FAl4OKd/hHBkYZdEmeO/HSRyHDnzKP
   pBtgnC+H1K44BwLE0ZHBswswwoidhyUqB1swabDmPBgksjU+jKbNQ72c+
   76UgCmhcVO9SZZRqb7VryiINuFaRu+BR+iptGIls+JMF+HXp5ny1Pl/Of
   Q==;
X-CSE-ConnectionGUID: XeDIb+rWSJiY7cr5IfzQsg==
X-CSE-MsgGUID: z2tzoLHDRQqlE9AN4DXrnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27837510"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="27837510"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 02:59:17 -0700
X-CSE-ConnectionGUID: y1Xv1iHMS06SWtPBAoUgyg==
X-CSE-MsgGUID: yMx0wv98QieAeRW+xnAwhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="45987722"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 02:59:15 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 02/18] wifi: iwlwifi: mvm: align reorder buffer entries to cacheline
Date: Wed,  3 Jul 2024 12:58:50 +0300
Message-Id: <20240703125541.3bc7a55ac867.Id3c1df6d40e92c3de9caededcbc32d0e57e4423d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703095906.833028-1-miriam.rachel.korenblit@intel.com>
References: <20240703095906.833028-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The entries[] array needs to be cacheline aligned to avoid false
sharing between different queues, each queue has a set of entries
in it that it writes to.

While it is aligned in practice today given that each array entry
before it is aligned, it's still clearer to explicitly require it
to be aligned, so add the annotation for that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 227463522b7c..056fdc42e253 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -798,7 +798,7 @@ struct iwl_mvm_baid_data {
 	struct iwl_mvm_baid_data __rcu **rcu_ptr;
 	struct iwl_mvm *mvm;
 	struct iwl_mvm_reorder_buffer reorder_buf[IWL_MAX_RX_HW_QUEUES];
-	struct iwl_mvm_reorder_buf_entry entries[];
+	struct iwl_mvm_reorder_buf_entry entries[] ____cacheline_aligned_in_smp;
 };
 
 static inline struct iwl_mvm_baid_data *
-- 
2.34.1


