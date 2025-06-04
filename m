Return-Path: <linux-wireless+bounces-23668-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 236E9ACD65A
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 05:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D6DD3A5D5E
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 03:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F2B23AE83;
	Wed,  4 Jun 2025 03:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UP4iXNWv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0849D2356DA
	for <linux-wireless@vger.kernel.org>; Wed,  4 Jun 2025 03:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749006824; cv=none; b=AwCBW/mo1ZnpF6FE/6uutyotII9YQD5ntwKMdzoL4+le+t7QEnyUSeO9xu5avbMFh2gChUlZvkR0UhSy0loDuBkvZKg9YP9n2UA0i7VHfDhjVs5MYGMTkKU0AXhsykOysN4wFG78uDpPVNuWZuxLK9Akp4HWswYsWygnfGgeH1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749006824; c=relaxed/simple;
	bh=dc/1ZDC3Evbx/JaoLTWNNxoPozMZJPgMN0ZKvLhOqyU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VXRdYx6ZL9sPrtHpePbk7CwexPyZi2S7iBQphGixQS7OCLNlchLjaaYiG9VlPhUqqVvphLQnT3nrq5TGkCkDgehjjFsSOHPooWQisT0goku0+ugTqQ12ukrtb9cBc+xKhdwblu8ApOcl1Vr0BP/yaLqp/fGPmgaGlZMnIGMo2X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UP4iXNWv; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749006822; x=1780542822;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dc/1ZDC3Evbx/JaoLTWNNxoPozMZJPgMN0ZKvLhOqyU=;
  b=UP4iXNWv7U+OHl8qSF2hVRiBe7YbInosDwEikHAluyjSoDhVgerLvNsV
   uzh9EF/J6+Us6JNATsmryUTUm5quQBWtY+Ca+Heq2NAhwdjfxx1X1koYq
   k1MR19H9bGIBSCTp4w1w8GRayqTgaoZAGEf0XRs+ePPSHtXppWeooAwSZ
   GNjfihDDxVZFcsYle6O8GqE5iUUj97ISil9lkfnCGJNDVyUvrc1cd4VXF
   59in0Ylx3y8A3B8FP3za2Dzvh2IesnPErVzVIY/SQ60NqRuFMYq+nUsCh
   jThMIL+QVl1s8X470aRwYTDzNd93+fyaW09xyGIQ5JWs2zCmFZdBifbOb
   g==;
X-CSE-ConnectionGUID: Hge58aYqSqmXEp7OV3YHow==
X-CSE-MsgGUID: cKJAluATQuejR7ujw02i7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="68504619"
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; 
   d="scan'208";a="68504619"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 20:13:41 -0700
X-CSE-ConnectionGUID: JBRhRy7qTPirmgvkrowEHw==
X-CSE-MsgGUID: bMa/gPq2S0m5n0itIdFRYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; 
   d="scan'208";a="182227376"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 20:13:40 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-fixes 3/4] wifi: iwlwifi: pcie: fix non-MSIX handshake register
Date: Wed,  4 Jun 2025 06:13:20 +0300
Message-Id: <20250604061200.87a849a55086.I2f8571aafa55aa3b936a30b938de9d260592a584@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250604031321.2277481-1-miriam.rachel.korenblit@intel.com>
References: <20250604031321.2277481-1-miriam.rachel.korenblit@intel.com>
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
 drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index 38ad719161e6..c8f4f3a1d2eb 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
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


