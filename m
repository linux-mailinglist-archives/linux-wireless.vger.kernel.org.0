Return-Path: <linux-wireless+bounces-23868-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B95A7AD2572
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 20:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DB5C16D1F6
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 18:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F8921CC6C;
	Mon,  9 Jun 2025 18:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P6ctE096"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DAE21D3C5
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 18:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749493322; cv=none; b=WG7ipv8hd7w+Whdl6bzGR+2E/8wPnhFdFzY0uTqPNDKjdya2y6R6OCB49FPhb+KiEughtM7vNaV8WrMj0+YEbMNgwC/UqqzgCHl5+rJTr8oMIEByC8SeI5zBskY+9W5gMCBec+3QzFv7OJtksJdSFwUUcPEemo9dZe1D6J4KS9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749493322; c=relaxed/simple;
	bh=virmJCT7fXzQotnwZx+AC7fS8g3uf0WsW6o3mTyDq7w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UomCFh6MLkctx9NAygqftJy55cI+kqKmyw5Kyu6hZ1eyQQAN/bZu58ZXH8WRIUBfX0b1wgBxxoECufQpQuFkB2/APH4vYZ1/xxp3EzltoTe2vbCBaeIR+d+iEjYnavzVCnkYWQKKlFCOotM3MRdWUw+fI2zcOo25C0pLjQ4t74A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P6ctE096; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749493319; x=1781029319;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=virmJCT7fXzQotnwZx+AC7fS8g3uf0WsW6o3mTyDq7w=;
  b=P6ctE0966d6gYZpvMiyU6vbmHWtxn6O8UUKjTJeBN3/4pIZ/OGsphMyu
   i2LKDJB4vnJvBB5cp/zsSIP2mZTlzh7bmUsTAnZPIfRz45KOHGQOBlNF5
   LpMtU4x21+RMueMaA+55Tn2zfkFxPxlUlWZNtZdioQ9g8CgVE/0lF5XcS
   VflekGc/OxN6e1syyY0Wzaz/YmQBBF5jxpdXf//lGHNahRu8+Q3j4S+71
   fGkOuCe4AfyDilFjxYRn7x2ENilWBzzu7Hu9aAs7pS3AmO7WQZa30NUCn
   jZwkl64nG72UonrF/ZWxRV6U619gM3UD7Tyff8mjuBp1YhOY8cZtfyH9X
   A==;
X-CSE-ConnectionGUID: vfsbZcebQ8qySKubN9hFkg==
X-CSE-MsgGUID: 789tFPiPRjuyY6+bfgPmoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="62237689"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="62237689"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:21:59 -0700
X-CSE-ConnectionGUID: vaDPuXRPTCSbx4mzOdbCMA==
X-CSE-MsgGUID: IJEcdeHfQoqHXCR3+D55ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="146510338"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:21:58 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Itamar Shalev <itamar.shalev@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH iwlwifi-next 09/15] wifi: iwlwifi: mvm: enable antenna selection for AX210 family
Date: Mon,  9 Jun 2025 21:21:15 +0300
Message-Id: <20250609211928.098c7bc296f6.I1cb4e99aa2f5a3852e24e2d32795bae3a4a73742@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250609182121.3886519-1-miriam.rachel.korenblit@intel.com>
References: <20250609182121.3886519-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Itamar Shalev <itamar.shalev@intel.com>

Support for the `set antenna` command on AX210 family.

Signed-off-by: Itamar Shalev <itamar.shalev@intel.com>
Tested-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 0f056a6641bd..f99dc8624bd1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -312,7 +312,8 @@ int iwl_mvm_op_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 
 	/* This has been tested on those devices only */
 	if (mvm->trans->mac_cfg->device_family != IWL_DEVICE_FAMILY_9000 &&
-	    mvm->trans->mac_cfg->device_family != IWL_DEVICE_FAMILY_22000)
+	    mvm->trans->mac_cfg->device_family != IWL_DEVICE_FAMILY_22000 &&
+	    mvm->trans->mac_cfg->device_family != IWL_DEVICE_FAMILY_AX210)
 		return -EOPNOTSUPP;
 
 	if (!mvm->nvm_data)
-- 
2.34.1


