Return-Path: <linux-wireless+bounces-7512-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C1F8C3503
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 06:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EF3A1F21503
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 04:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5275CDF4D;
	Sun, 12 May 2024 04:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DkAdady6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7274BCA40
	for <linux-wireless@vger.kernel.org>; Sun, 12 May 2024 04:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715488289; cv=none; b=KMlvCeNluwOcItRs4WSwQK/3sd/vy5h4nRQCTTPx1hK350nAKpagtAryzeR/B1ya6nUnLKASWEIUM797S/yIyYcw/E4pSqhM4hNhRtM/UN9xL8O002gw/P6vLdnvrK37Es0U4v1s/IbO66JXrXqEsdOS1FdrcuNx1RHJwsXm9IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715488289; c=relaxed/simple;
	bh=NB8M6Y4Drs3wmgENe8Sf9O4xBibn84NlCGxczelPshM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X1cY9ZFnXI5+9Ko5TKifCL6apLbP9fPYVrILO0VN75JrbTXgfcAm+LYhuanOydBH8KX+n+qL/1ZD4djAKPGIoNDeEyxniEfZ7sjbaFNMXb5wXf6XFCa4vFUn7O02fxSvTDCEFpyDG76z+p7SL04PAKGpKQBkgNPoq/6zkuJAqcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DkAdady6; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715488287; x=1747024287;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NB8M6Y4Drs3wmgENe8Sf9O4xBibn84NlCGxczelPshM=;
  b=DkAdady6nyz+Uu5RPevoYpp1ERzUkix0ItYot5FXNNFI4R6vjCuEuJi5
   fhRopqm9uLhtMzqv1cjwoG5NgebdLYxx3sedTcwG8uKzQ3mzSnq62iYLZ
   x4dR5PMEqwvZR/iEWw8xH5lP3RPtzlO7p9TIM89fE/T4XsVbLbJ8ZXZxT
   ZXAIp62btnUIeiAbvDcFzU/sV1MzC48qSja5IoLyd1XSW07tm17lZJMmP
   KybcWIckes9RxsFIIVcw53mAlkupUU0GnSi8CWz0jHMg0gCOwbI/JSA3r
   bJRwfOrWS3cy8d/aWNtBm/VanLRiqnAEqnQccWxppkumJaoGfBJ0N4HwK
   A==;
X-CSE-ConnectionGUID: jKz4fKNpSmmZnUErmW9Saw==
X-CSE-MsgGUID: YvNgIizXRcaqW6hL9UlGPQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11070"; a="11323833"
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="11323833"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 21:31:27 -0700
X-CSE-ConnectionGUID: ZsmWnuj+RRyHTgl8J6Ey9g==
X-CSE-MsgGUID: pRLovPJtTzmsP23lN4bXXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="34532144"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 21:31:25 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 01/16] wifi: iwlwifi: mvm: don't always set anttena in beacon template cmd
Date: Sun, 12 May 2024 07:30:55 +0300
Message-Id: <20240512072733.73d790911268.I158dc1dbc9c2e199c69d8213e5496d2de72da28b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240512043110.3413383-1-miriam.rachel.korenblit@intel.com>
References: <20240512043110.3413383-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This needs to be set only if the FW is not capable of selecting an
antenna on its own.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 5a06f887769a..f6baf7135efd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1010,12 +1010,13 @@ static void iwl_mvm_mac_ctxt_set_tx(struct iwl_mvm *mvm,
 	tx->tx_flags = cpu_to_le32(tx_flags);
 
 	if (!fw_has_capa(&mvm->fw->ucode_capa,
-			 IWL_UCODE_TLV_CAPA_BEACON_ANT_SELECTION))
+			 IWL_UCODE_TLV_CAPA_BEACON_ANT_SELECTION)) {
 		iwl_mvm_toggle_tx_ant(mvm, &mvm->mgmt_last_antenna_idx);
 
-	tx->rate_n_flags =
-		cpu_to_le32(BIT(mvm->mgmt_last_antenna_idx) <<
-			    RATE_MCS_ANT_POS);
+		tx->rate_n_flags =
+			cpu_to_le32(BIT(mvm->mgmt_last_antenna_idx) <<
+				    RATE_MCS_ANT_POS);
+	}
 
 	rate = iwl_mvm_mac_ctxt_get_beacon_rate(mvm, info, vif);
 
-- 
2.34.1


