Return-Path: <linux-wireless+bounces-25050-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6360AFDEFD
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 07:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C70FB1C26E40
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 05:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8062926A1B0;
	Wed,  9 Jul 2025 05:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JmlbPpTF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED2C26B2DB
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 05:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752037361; cv=none; b=j6tAwqqrAePC7U18/QhUyR66T2e4Ov5Omwg2zAyd44THoLMQjXCil+uqcWIzg1PA3YclhGYz/QHtywC1b/YonmJxoJ6wr96RFOmu3KKCXz99XFwsY88Zz4+AmSDlV/fghrjwDfrJjM4wvGHiy4OJqzjj4QjrgPQBFwhjYxJxLRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752037361; c=relaxed/simple;
	bh=NFmAn22hGb1uR3DqXm75s8Xdo9kyl9arFV93kUGLjiw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n7uuRF1LHuURL0SIyHrbEFyzhoFyKIhjBc1I4i3XeUz3NMRRp69/LlL4g9mCPnru4kH3mN8a4M3vqkqS7+eTOLXYceiqAOx6oM1suEpMSfqZu3smVZu0JCBm9HzQMDjpGVmitCrw8LfefsCwIolyWieFVvOd6orE0nnNTey/NEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JmlbPpTF; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752037360; x=1783573360;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NFmAn22hGb1uR3DqXm75s8Xdo9kyl9arFV93kUGLjiw=;
  b=JmlbPpTFT4YlKXQR6q0DA1XoFi8R6DaaVesqw0iAVilANAmNXgsfedIT
   CGBALJ88v19qjj63rAyP2ej3sUd9j3Z8cPWsAzDkwIQ6JCxQE8J13OWTH
   sWQNzg0/dzuysgZJFY10kqe/e5cgB4GVFE6boVCIvpopg8n9Rv+y7WteL
   XNWKl4MUG1RsGBoNV4z9fuTqS4Gu0fbWHT9sfNL25dIg4ql6MSxLiS9jf
   VvrwgSee0EurMqe5w+frd3eEyWLaUV5AvinrqwrouFP2sjo44P+4ElB/x
   lg4OU9z0dVN0Lwpx2vspIkDbXaI0zlaFhgLKBQGSsfrjOEuD7Oah/3/+V
   w==;
X-CSE-ConnectionGUID: h6NGHxVoRom5Gf0GZZY93Q==
X-CSE-MsgGUID: WZWjJelxTiSL+B5PlPYtIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="53501503"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="53501503"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:02:39 -0700
X-CSE-ConnectionGUID: H42PvemPTCyVG1V0W9wRcw==
X-CSE-MsgGUID: 5VSBW3/8RTeT85m5a6jWbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="192859276"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:02:39 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Itamar Shalev <itamar.shalev@intel.com>
Subject: [PATCH iwlwifi-next 13/15] wifi: iwlwifi: trans: remove retake_ownership parameter from sw_reset
Date: Wed,  9 Jul 2025 08:01:57 +0300
Message-Id: <20250709075928.62518001eeec.I2a3da6f83aa691496a53a548bd73bddd4d4d2db8@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709050159.854432-1-miriam.rachel.korenblit@intel.com>
References: <20250709050159.854432-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Itamar Shalev <itamar.shalev@intel.com>

Remove the retake_ownership parameter from the sw_reset function, as it
was always set to true and is not needed by other opmodes.
Simplify the sw_reset API function.

Signed-off-by: Itamar Shalev <itamar.shalev@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dump.c   | 2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c | 4 ++--
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dump.c b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
index 3ec42a4ea801..4e1ef165f058 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dump.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
@@ -199,7 +199,7 @@ static void iwl_fwrt_dump_lmac_error_log(struct iwl_fw_runtime *fwrt, u8 lmac_nu
 		IWL_ERR(trans, "HW error, resetting before reading\n");
 
 		/* reset the device */
-		err = iwl_trans_sw_reset(trans, true);
+		err = iwl_trans_sw_reset(trans);
 		if (err)
 			return;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index b6e71c172e7b..810923053053 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -498,9 +498,9 @@ void iwl_trans_set_pmi(struct iwl_trans *trans, bool state)
 }
 IWL_EXPORT_SYMBOL(iwl_trans_set_pmi);
 
-int iwl_trans_sw_reset(struct iwl_trans *trans, bool retake_ownership)
+int iwl_trans_sw_reset(struct iwl_trans *trans)
 {
-	return iwl_trans_pcie_sw_reset(trans, retake_ownership);
+	return iwl_trans_pcie_sw_reset(trans, true);
 }
 IWL_EXPORT_SYMBOL(iwl_trans_sw_reset);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 103a36d8ee30..ac37d9613ade 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1096,7 +1096,7 @@ static inline u32 iwl_trans_write_mem32(struct iwl_trans *trans, u32 addr,
 
 void iwl_trans_set_pmi(struct iwl_trans *trans, bool state);
 
-int iwl_trans_sw_reset(struct iwl_trans *trans, bool retake_ownership);
+int iwl_trans_sw_reset(struct iwl_trans *trans);
 
 void iwl_trans_set_bits_mask(struct iwl_trans *trans, u32 reg,
 			     u32 mask, u32 value);
-- 
2.34.1


