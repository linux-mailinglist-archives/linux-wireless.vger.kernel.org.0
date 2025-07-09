Return-Path: <linux-wireless+bounces-25122-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA103AFF2B0
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 22:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 940953BEEDF
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 20:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1799267729;
	Wed,  9 Jul 2025 20:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kmlBK37A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D871265631
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 20:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752091580; cv=none; b=paP29Fnknbd0yLj379JQcNC/g6CGo9gNNqpkAZbuAkxHkfi64epoRFCDzkxBLPHBmC1RA18LHAEx1ZPTM+qeyZFvxPltSCHKlCWLyrqhJqnm/jSE9FDlDUAzyyb3aNplAmWJ6fXLfNV9P+lMlGrGvHG0y+C/Fd/xX+YNOBrypnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752091580; c=relaxed/simple;
	bh=NFmAn22hGb1uR3DqXm75s8Xdo9kyl9arFV93kUGLjiw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p5PC4/VTPP818ax/2xlrlVqWFNtMHY3I5LFjVk/G6834pE818TlkAZbcWG7hTD1gHp44Ag7/LrFNrDrBTxJXSG3+SEE8fnafPbiuypJ21d6q2NthZeg3Za0jRMzQqTIyvROZXBzfR9Bf65kr6zW9jcImQDMUm4wIJspbv5S5FNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kmlBK37A; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752091579; x=1783627579;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NFmAn22hGb1uR3DqXm75s8Xdo9kyl9arFV93kUGLjiw=;
  b=kmlBK37AV46LwlfsVZ4g1F4+A8GDtTBZnFtbOJLUzbLfc+3RinKacvqQ
   D37wCiCoIYM7atC+TLxwoJ6NEZSh2mAQNQwMQhmwmY9q2AlG+NGaUtbXE
   KD4LcRj0gMYaqZTv0JyrYnQTNgRlBNQMvOgOIeXEJcBETzctguyB91FXQ
   st8/7JEVdHv1AKYY/PGdfiHlxoWFgyg8lZsI3Da09wmlpYQYZ1v/JfqQp
   iN0fqM4bm08EBJKLhe3AjciCAu1G8HEg/UyqQSHLmT2BloZxfzNMbnjSs
   bHU++u0dRvLlfGZT/nh6fIrfg7ngoErDWkDq5lMnnfdfZ4WfZmsKxK97A
   Q==;
X-CSE-ConnectionGUID: InPyE7pYQq2VXV6AUA4KLA==
X-CSE-MsgGUID: wLWbdWuVQM642l/vM2gnpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54240327"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54240327"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:06:19 -0700
X-CSE-ConnectionGUID: nR9aqwyBSHWCl8H8PieEYw==
X-CSE-MsgGUID: ztqZH5ISTvybcTPe5cdjAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="160126084"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:06:18 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Itamar Shalev <itamar.shalev@intel.com>
Subject: [PATCH iwlwifi-next 13/15] wifi: iwlwifi: trans: remove retake_ownership parameter from sw_reset
Date: Wed,  9 Jul 2025 23:05:41 +0300
Message-Id: <20250709230308.0a103d021815.I2a3da6f83aa691496a53a548bd73bddd4d4d2db8@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709200543.1628666-1-miriam.rachel.korenblit@intel.com>
References: <20250709200543.1628666-1-miriam.rachel.korenblit@intel.com>
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


