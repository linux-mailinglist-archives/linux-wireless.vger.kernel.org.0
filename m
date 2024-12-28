Return-Path: <linux-wireless+bounces-16849-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8F29FDC31
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Dec 2024 21:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 967E7161498
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Dec 2024 20:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6958038DC8;
	Sat, 28 Dec 2024 20:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W1LZk1a0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46B01E515
	for <linux-wireless@vger.kernel.org>; Sat, 28 Dec 2024 20:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735418090; cv=none; b=nETRP0NwC1zEB+ZfoBbLtmeuxPH+J0fVmcxHdbWW0f4Oeiok3AeH53hz9DIureUeDVdQUs3BJBIyWGzRx7/IucK4ipo6lv1PDy5zYievW8HpX9pfJwkoqg7kpEBzmPkaZSTyQ/+/URGMO91M15/elaH/EaGZBfZOuq71IHC4OJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735418090; c=relaxed/simple;
	bh=h3q/WIbw/sxxfKW9aZaa4gjwG5X4m+x7JoOYhwBoKfs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ETg7jlNfF46FQXutlkKDrMpGYWAvenJPHKoLrHD2v54s0G5FDcZqm8z9rFNtEJtFucHo8WOxZW6c1/XLOhAsA8BugFTvBZPulS5nUL4FDKqEidqQP8ABi0N/MRxm+NkxV18WbYjulEnFkn95Qzd3EMwzf9At4Ac1W+k2RJab6Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W1LZk1a0; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735418089; x=1766954089;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h3q/WIbw/sxxfKW9aZaa4gjwG5X4m+x7JoOYhwBoKfs=;
  b=W1LZk1a0BUGcweziFVH3y8EDCcOcJ9KRAilcq5mZaEp447yFRDrIgiuM
   h8nsgEbPYVqbn9YaZFW81HytNbw+CX2xNR3ULWQaal8HvawGRLH5JV6R/
   8vUvJomOt4gTC23dCsb2FWQvISdqb1uHAMPg7poHJqlQr+IlkguMQDzfi
   6acQE1buIBwo1lJPSC/6EV98v0kEyQcr5tppwY+63xEA3lkaIcPUguytW
   Mqmjdt2gCkeYCbbEeffYN8IglPf4Ci51lgA8iVgInuMO1ERSy/6jzQQzl
   lzPkhw0RiXWtMgDVfpsCbGSmib+7ek5CBPkZZ2/9uhmBDEgMnTrysuuG4
   w==;
X-CSE-ConnectionGUID: oNZXS+u0QQOBIrT/Rd8SpQ==
X-CSE-MsgGUID: 5YGxARTIRZaPpql9E8oraQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="35479766"
X-IronPort-AV: E=Sophos;i="6.12,273,1728975600"; 
   d="scan'208";a="35479766"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2024 12:34:48 -0800
X-CSE-ConnectionGUID: xRNZMLS0R+mnhK1TKbVNHQ==
X-CSE-MsgGUID: kaWDQS9LR0eEQBpGX0JLUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104488402"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2024 12:34:42 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	"Somashekhar(Som)" <somashekhar.puttagangaiah@intel.com>
Subject: [PATCH 07/15] wifi: iwlwifi: add mapping of prph register crf for PE RF
Date: Sat, 28 Dec 2024 22:34:11 +0200
Message-Id: <20241228223206.a8899d585a6e.I9d9b223c75d5370811220291c62c364967c0acc3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241228203419.2443350-1-miriam.rachel.korenblit@intel.com>
References: <20241228203419.2443350-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: "Somashekhar(Som)" <somashekhar.puttagangaiah@intel.com>

In blank OTP, we get the CRF type from a peripheral register,
support it for PE CRF

Signed-off-by: Somashekhar(Som) <somashekhar.puttagangaiah@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h | 1 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
index dc171c29eb7b..8d4ff42da35a 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -458,6 +458,7 @@ enum {
 #define REG_CRF_ID_TYPE_GF			0x410
 #define REG_CRF_ID_TYPE_FM			0x910
 #define REG_CRF_ID_TYPE_WHP			0xA10
+#define REG_CRF_ID_TYPE_PE			0xA30
 
 #define HPM_DEBUG			0xA03440
 #define PERSISTENCE_BIT			BIT(12)
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 8297d56815fa..e73a9a47bf1d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1267,6 +1267,9 @@ static int map_crf_id(struct iwl_trans *iwl_trans)
 	case REG_CRF_ID_TYPE_WHP:
 		iwl_trans->hw_rf_id = (IWL_CFG_RF_TYPE_WH << 12);
 		break;
+	case REG_CRF_ID_TYPE_PE:
+		iwl_trans->hw_rf_id = (IWL_CFG_RF_TYPE_PE << 12);
+		break;
 	default:
 		ret = -EIO;
 		IWL_ERR(iwl_trans,
-- 
2.34.1


