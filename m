Return-Path: <linux-wireless+bounces-22818-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABCFAB2508
	for <lists+linux-wireless@lfdr.de>; Sat, 10 May 2025 20:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5AAFA015A0
	for <lists+linux-wireless@lfdr.de>; Sat, 10 May 2025 18:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9B62836B1;
	Sat, 10 May 2025 18:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VaOrUvQY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AF8283FCA
	for <linux-wireless@vger.kernel.org>; Sat, 10 May 2025 18:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746902930; cv=none; b=TgjXSM75gWw0x8PUdTM1JNA0UOc6FKSzGqwmhUR1qs4Nm+wwvHzNjPBbfGb75zqKoNNR3keVEfU0N7oszmN3XOkZloQz+ps/gJN1iXPLF3vwY0SGZljYHNXPNpZdpHQR5P9J8r/FJsVMGszS6wwrxX8B0rRU37GbS64F50RO+S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746902930; c=relaxed/simple;
	bh=ufh8yn+05jb2u14YcvFE/GBC95y3o32ce6hDVyY/Rso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZFEE6ESrbJdVm65m695s2zDJxnejJCDyDZkFJHbPJXAg/qvQRvjS79JqaRJrn488MxIfMetMieYQq9XrphHa0egQAlP5UZdWYoDEw3KMaxwb0lGR+FEQ2wcC+Y4Z4vZsmvM5zEEkc8VFmPEbsnCU0WCv410xTJLlTdlB0HkDAiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VaOrUvQY; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746902929; x=1778438929;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ufh8yn+05jb2u14YcvFE/GBC95y3o32ce6hDVyY/Rso=;
  b=VaOrUvQYRg6+Rq5ZCMnKPGIkm/CisHoNMgvKRNCNK6Q9OSwCxoX+hQit
   kfLcPgraSOcDYF0lB/scCFVS9XXi25FsaQnG5eCly/fHxCTnRyy06Z7ND
   2ig9iZZLNPaP29vwNGx+IkaeQNEI2GfC2OWCohUTmEJK1D5arwRcDe0qM
   jUlIllUpDTS0gydhspFPqD6uj4mGiZ3OmnDyih1i8fbgT4T2dQN43GrFY
   Wwvsy3Otr72H810dqyAP01i2GWOIufLd/LIoocqdW19qGI6tJVdgW9MbG
   MVJj2Jj8KNP6O9Y2vX0euzlzrTzqac/m40LzqH+f0GiwZNI1QcUYWSmif
   A==;
X-CSE-ConnectionGUID: gbm1vSmkRzeVx9D6qIKy4A==
X-CSE-MsgGUID: L08ivHAUQLeLyfjIjx1m3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11429"; a="48880881"
X-IronPort-AV: E=Sophos;i="6.15,278,1739865600"; 
   d="scan'208";a="48880881"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2025 11:48:49 -0700
X-CSE-ConnectionGUID: FkJDEnesRxCMEJ/ooyh+2w==
X-CSE-MsgGUID: xaOZyjQ1RWeIe1cO4dTjfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,278,1739865600"; 
   d="scan'208";a="142033424"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2025 11:48:48 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 05/15] wifi: iwlwifi: cfg: fix Ma device configs
Date: Sat, 10 May 2025 21:48:17 +0300
Message-Id: <20250510214621.4dd365eb76cd.I91f368df691a3ce6c545d9cdc44676e7883efa16@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250510184827.3800322-1-miriam.rachel.korenblit@intel.com>
References: <20250510184827.3800322-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

These should be according to their RF type, not just use
GF unconditionally. Fix that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 0d26fd0168a5..51c9a871d1da 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1379,11 +1379,9 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     MAC_STEP(B), RF_TYPE(HR2), BW_NOT_LIMITED, NO_CDB),
 
 /* Ma */
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax201_name, MAC_TYPE(MA), RF_TYPE(HR2),
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name, MAC_TYPE(MA), RF_TYPE(HR2),
 		     NO_CDB),
 	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_name, MAC_TYPE(MA), RF_TYPE(GF)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax231_name, MAC_TYPE(MA), RF_TYPE(FM),
-		     NO_CDB),
 
 /* So with Hr */
 	IWL_DEV_INFO(iwl_rf_hr_80mhz, iwl_ax203_name, MAC_TYPE(SO),
@@ -1450,6 +1448,8 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 
 #endif /* CONFIG_IWLMVM */
 #if IS_ENABLED(CONFIG_IWLMLD)
+	IWL_DEV_INFO(iwl_rf_fm, iwl_ax231_name, MAC_TYPE(MA), RF_TYPE(FM),
+		     NO_CDB),
 /* Bz */
 	IWL_DEV_INFO(iwl_rf_fm, iwl_ax201_name, MAC_TYPE(BZ), RF_TYPE(HR2)),
 
-- 
2.34.1


