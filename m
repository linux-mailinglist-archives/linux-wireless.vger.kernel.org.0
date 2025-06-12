Return-Path: <linux-wireless+bounces-24067-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 187FEAD6F6F
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 13:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0356177038
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 11:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271A1229B36;
	Thu, 12 Jun 2025 11:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NdqnpIPZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994D323C51E
	for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 11:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749728973; cv=none; b=fZu9SnxKnJ7BM2omJqU3PfZXh0qdgCOt3nCguIq49jO6HYmRtJFxVY40BYF6vs7RrcmohmbY1CZgDPc6K6bgHiIFHV4+4adtT+VQ4/p6xXupShj0eIW0r2WUXnPyle5dhsuP4X2o5UwNDsnV91SiiucEMYkfZKAZ9IPouYJp0h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749728973; c=relaxed/simple;
	bh=uR1gKbg8EopYdjQ4CuC8hZYiEk/vbZjxZn+RGDAjDQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kC1IqAwPjaKWivyVzbi7I/Z7cg2bchv8VolHit9Rl3fJYKSCjoFhz3xlzX88Ybc8T7mqYPJhwmtQNzyrGE1QlzXOMVnTcDbG3qo7PdKGNcUdw8uBuct9SaypT+jIJcDTjFfFlUqIYi9b8fQjsLpgazFqg+x/gJOhtX98FqJhLbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NdqnpIPZ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749728971; x=1781264971;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uR1gKbg8EopYdjQ4CuC8hZYiEk/vbZjxZn+RGDAjDQ8=;
  b=NdqnpIPZ6MTImMa14e1u0Hj3O3fs/mY9V3eTX9WFxP2viAgC2rHX+uAk
   meV8rPLzNeJcTPeEsT/67TKmQGoGPO3ydGbhZDIKwBkWquBXxhFWgJwoY
   Yb3yOY/rTzLenLAdRcy9JE8JvSatcv+8pJphWPVZM9KDj6/lGg/eeN0tp
   zk4/XhsIOWkkEnOuDM0YNFrxvXwhYl1c8TMmjfNZgBG/NPH49uLib/Yu4
   7GRuPNTs51o2Yi1PJ6tjqFdfkdY2QVflmUMAhsrcI35J+GZ2ZxyL0BQEG
   YvF3E2BHNmzNkMH2mqkQ8TR0XASKYNTbDbDUeSvznnWGuBVtqnh7LNqmV
   A==;
X-CSE-ConnectionGUID: LCXne6orRlK65YX6UIjSHQ==
X-CSE-MsgGUID: 3G1uL0zjR9irE5ic3cC8yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="63248352"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="63248352"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 04:49:31 -0700
X-CSE-ConnectionGUID: WUSC4e6bTvGWkBX0Xmlnug==
X-CSE-MsgGUID: 97FfGEu4SlqxCQo93oiMWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="147382194"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 04:49:30 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 13/13] wifi: iwlwifi: pcie: fix non-MSIX handshake register
Date: Thu, 12 Jun 2025 14:48:59 +0300
Message-Id: <20250612144708.83aafead6061.I2f8571aafa55aa3b936a30b938de9d260592a584@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250612114859.3094387-1-miriam.rachel.korenblit@intel.com>
References: <20250612114859.3094387-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

When reading the interrupt status after a FW reset handshake
timeout, read the actual value not the mask for the non-MSIX
case.

Fixes: ab606dea80c4 ("wifi: iwlwifi: pcie: add support for the reset handshake in MSI")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c
index b5e4b60f710c..0df8522ca410 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c
@@ -125,7 +125,7 @@ void iwl_trans_pcie_fw_reset_handshake(struct iwl_trans *trans)
 			reset_done =
 				inta_hw & MSIX_HW_INT_CAUSES_REG_RESET_DONE;
 		} else {
-			inta_hw = iwl_read32(trans, CSR_INT_MASK);
+			inta_hw = iwl_read32(trans, CSR_INT);
 			reset_done = inta_hw & CSR_INT_BIT_RESET_DONE;
 		}
 
-- 
2.34.1


