Return-Path: <linux-wireless+bounces-2405-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C45839751
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 19:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 192A2B218FF
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 18:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7957FBB5;
	Tue, 23 Jan 2024 18:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MuQtRPoI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE9F81AC1
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jan 2024 18:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706033353; cv=none; b=BeF7IWyA525xu0QeYPixTTVIP6j1TSLRosLNrggVvWyvZR1uDL/8FR/sX7snVrPQoFQ35otj+MtQZdrYNXWHGoDGd7T4Dvx+VFvIeitZ1jPtTRFz/vO9IgW9gmQMjbevFb+nKXC6tktjbLYvao7WqqAd3sIajoUGKQk7WkYr4uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706033353; c=relaxed/simple;
	bh=Fr9Tk3R/5MGDCJ3wxnmfSBFh1krGYhQix5fL+25htlE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nSNrLCUI8iiEXTF7jAT2HmQKuzZ/BtZw3qExzwEBy5f4hvR9eEyY3FwnHWmpTbQiRRNpBJEDSuwbkhUeCwMRwv0TqPVkblZYnsWTQtnGx6vZwKauJWSP9gy50A24r1IR1V9cawodYnR5mycneYX7cCU+qBrjzJpwxbcLOa7ZspY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MuQtRPoI; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706033352; x=1737569352;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fr9Tk3R/5MGDCJ3wxnmfSBFh1krGYhQix5fL+25htlE=;
  b=MuQtRPoIVUy8eU+DyZNMiD8vjGpgM4owyBj2vW8jl4LzwkIC43uQfAKg
   uCgkm7ME8HBi3QKkGq6iRqIiC0rp9ZXxUCmKqlHqrtdHmC26xKdZlB/i5
   NYmEpI1Xgb0YRlf8mgelU18Gs0LJQKDca3ygeMfd4LT0N/krcdoQWaGVj
   VQdLphyU10YoCQtpd0tsVzya91WHODZbj6slncrNEM48S5juzKnuZYvaU
   yXhaNfkB5soX6RPZEPuLpuNU+rJTJqT0X/HswjVR8F327sYHuuXuuQj0g
   ahbyCXSSHT1lYX3qFBXfwSy/Ker9AeFeW/OhD1K1RGgB2KTVRwhCwde+Z
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="501923"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="501923"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 10:09:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="1666592"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 10:09:09 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 10/15] wifi: iwlwifi: skip affinity setting on non-SMP
Date: Tue, 23 Jan 2024 20:08:18 +0200
Message-Id: <20240123200528.ed9094390731.Ic4e5e019c01fd4231b99cf4919af5d19d6353869@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123180823.2441162-1-miriam.rachel.korenblit@intel.com>
References: <20240123180823.2441162-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

Without SMP the function is just a stub that returns an error code. Add
a compile time check for CONFIG_SMP in the interest of not logging an
error if setting affinity is not possible anyway.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 63e13577aff8..b5756e168f49 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1718,6 +1718,7 @@ iwl_pcie_set_interrupt_capa(struct pci_dev *pdev,
 
 static void iwl_pcie_irq_set_affinity(struct iwl_trans *trans)
 {
+#if defined(CONFIG_SMP)
 	int iter_rx_q, i, ret, cpu, offset;
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
@@ -1738,6 +1739,7 @@ static void iwl_pcie_irq_set_affinity(struct iwl_trans *trans)
 				"Failed to set affinity mask for IRQ %d\n",
 				trans_pcie->msix_entries[i].vector);
 	}
+#endif
 }
 
 static int iwl_pcie_init_msix_handler(struct pci_dev *pdev,
-- 
2.34.1


