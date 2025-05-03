Return-Path: <linux-wireless+bounces-22372-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E48AAA825C
	for <lists+linux-wireless@lfdr.de>; Sat,  3 May 2025 21:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 033C8189D6E5
	for <lists+linux-wireless@lfdr.de>; Sat,  3 May 2025 19:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36ED127E7DB;
	Sat,  3 May 2025 19:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G2aryrWH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A8027F4CE
	for <linux-wireless@vger.kernel.org>; Sat,  3 May 2025 19:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746301501; cv=none; b=hsckFl6zl/CaXIViVLPqRj/wJc3HMoCX6mpvahbm4R6g9R62gZ01054foE6bpZXzcGgCvDP8C/UdEEbFmrYHwnnq9oiRAffzpJaygUtVBsyE/zE4uRgOzNJVxpRLYU4aN+jAVsiuKm5SpPRBVxSMbuhAVa8X5cDOBRmE8annOGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746301501; c=relaxed/simple;
	bh=qVNwS5y6YZPLsXNXAN0WQbnIrRGkzl8aoVHfAwJYiNA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ot1LsLkQdUENUAgMItVwz4L8MsPpyDamvJ/xehG2CMaL2ef9KEuy+2NMroQmrGbd7HYrgl2mG5/IjK39TbplGedfo44LjbToD+Dqp0Zx8z83KoRLt+81VUU10HOOHvNnPdJ6zbRrRmLt4zkPimlHNVJr/t3aexcZJYHkcZMtXA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G2aryrWH; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746301499; x=1777837499;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qVNwS5y6YZPLsXNXAN0WQbnIrRGkzl8aoVHfAwJYiNA=;
  b=G2aryrWHKFKpGWGsNSeHnC7iMz2OehNYXXoYbGA0vQyFOXkxPd9TbAvm
   YaeyyvqAUlz7NJCsCfqTiVfqpL6bCsIESHrnXCkDt25BbxrhdFD/jF4vz
   5Bvv8Knb6FUc5gMlGh69+TpfirSauIgT8Zv8ay8SgJpBvlhmCwO2VXRR/
   0JrE/bBctlrDuy21Y3JxZva4OfEk8BQjDyNgOEf6Prl+thcOyfhtzZaG/
   Beq2Y50X4fvHvtlIzfrusyFad4bfjsXbXO2zuDul+YOQwRfSSFg1iRc/3
   wLRASkDUIgVeVmvMT0k/cbP6HfCctmwkJmb00sPzXXFO9b6DiUhZmynmU
   Q==;
X-CSE-ConnectionGUID: s0qdbCmBRp2u5qqWqVbxeA==
X-CSE-MsgGUID: ujOvWhggTS6owHoXGmBW4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11422"; a="58613261"
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="58613261"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2025 12:44:59 -0700
X-CSE-ConnectionGUID: 9ut9xKh2R4KClmT3c160LQ==
X-CSE-MsgGUID: hfq8Nso4Ra+OEElqcBqfhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="134644281"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2025 12:44:57 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 05/15] wifi: iwlwifi: unexport iwl_trans_pcie_send_hcmd()
Date: Sat,  3 May 2025 22:44:24 +0300
Message-Id: <20250503224231.f457a737c663.I8d49b2955a4f2ca47deb664e5fd58e39d612bb63@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250503194434.147426-1-miriam.rachel.korenblit@intel.com>
References: <20250503194434.147426-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

It doesn't need to be exported since the code calling it
is in the same module.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 51a80a0f1688..3c86a5f23d8f 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -2688,4 +2688,3 @@ int iwl_trans_pcie_send_hcmd(struct iwl_trans *trans,
 
 	return iwl_trans_pcie_send_hcmd_sync(trans, cmd);
 }
-IWL_EXPORT_SYMBOL(iwl_trans_pcie_send_hcmd);
-- 
2.34.1


