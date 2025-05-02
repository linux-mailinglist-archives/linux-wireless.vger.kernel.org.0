Return-Path: <linux-wireless+bounces-22352-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2065EAA72B7
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 14:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D0B94A8275
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 12:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9601D255E2F;
	Fri,  2 May 2025 12:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YmKS9WkG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED26425485D
	for <linux-wireless@vger.kernel.org>; Fri,  2 May 2025 12:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746190624; cv=none; b=WJB99bO+D8jrDjei06uZ7YyKqpSVyR80+DsKoMrcoh5Zn/zz1y0ypLp+c/aq782b+g18wC6/wduRYhr1YSmxOPDG7RvqsnfQ+OpesdLZ6gQaJjyrjb/WsBdfL5rRLzZ/HIcmUT9O//bGNyq2uD/eFVW+gohi4xMCPxSHTWxqIRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746190624; c=relaxed/simple;
	bh=KOgS4LMxJb0xCWdMToRHWEW3yalt8h0ud9F2VmCtKIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VcbLAtRBIgB8yNy0V0Dr5kN218IU6CZb6F3UX+8nDejeqPWlFpgk2VJxgk7tuMFe/hfc+qp4WwUBPGt6VCiRZ+hbmiVsTdF3pgisaMEOan9Y/fIvWNm48Sc3HKaaIrlrBrFx0FXCAvPrR35xMMFFvzw1PL8wFfYOh9D5Srb95FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YmKS9WkG; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746190624; x=1777726624;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KOgS4LMxJb0xCWdMToRHWEW3yalt8h0ud9F2VmCtKIQ=;
  b=YmKS9WkGOpE0cvw7FE/hIqm7wtsJ0qs9VvNFeyHFvBr+Gub9+U1LdnE0
   9XgQgf2psdFnKs9KUI8wB2Tiig/e9WpeiCa4Iykf8598YnW5Umdr91XKl
   0ee2HP0LXh+wb0eKv6XJREMgS9yf1ViuMqubzBdycd/5ihT3lgo4V7nAX
   ZsQLTAA24KAZvrg28gPH+jGODOuZVcTsDsAk4REJ/2YoUzfZ1YF+Qv8bT
   MTycN8UiD24AIsp+ab5NDJoHy8spy6nvEKjTYvFtOxEhUzfURO9MB6mjw
   4vICfYSc/28ykrh4uCMhqmgwTFIbSuZNAW0vpXjSowXDzDx4eyYksS9tB
   A==;
X-CSE-ConnectionGUID: mrpj9/j4TC2jsmg0tEwUfg==
X-CSE-MsgGUID: B1Y5yinQRfC6iF+WCFKVdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="59255558"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="59255558"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:57:03 -0700
X-CSE-ConnectionGUID: uW6E3ILQTX6/i2DKHRriIg==
X-CSE-MsgGUID: bL4TQi8/TDODDbGaGmM4Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="165554748"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:57:02 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 11/15] wifi: iwlwifi: cfg: reduce mac_type to u8
Date: Fri,  2 May 2025 15:56:27 +0300
Message-Id: <20250502155404.c17d56f4ae0f.I487c8df18aa33c46aa6813bf5aebb5a23da67600@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250502125631.3184319-1-miriam.rachel.korenblit@intel.com>
References: <20250502125631.3184319-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

In theory, this should be 12 bits, but in practice all the
values we use now fit into 8 bits, so change the mac_type to
make room in struct iwl_dev_info.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-config.h | 4 ++--
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index cded707223fe..4b43f561bd12 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -459,8 +459,8 @@ struct iwl_cfg {
 struct iwl_dev_info {
 	u16 device;
 	u16 subdevice;
-	u16 mac_type;
 	u16 rf_type;
+	u8 mac_type;
 	u8 bw_limit;
 	u8 mac_step;
 	u8 rf_step;
@@ -477,7 +477,7 @@ extern const struct iwl_dev_info iwl_dev_info_table[];
 extern const unsigned int iwl_dev_info_table_size;
 const struct iwl_dev_info *
 iwl_pci_find_dev_info(u16 device, u16 subsystem_device,
-		      u16 mac_type, u8 mac_step, u16 rf_type, u8 cdb,
+		      u8 mac_type, u8 mac_step, u16 rf_type, u8 cdb,
 		      u8 jacket, u8 rf_id, u8 bw_limit, u8 cores, u8 rf_step);
 extern const struct pci_device_id iwl_hw_card_ids[];
 #endif
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 0165c06fd7aa..449ed4b02a5f 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -2103,7 +2103,7 @@ static int map_crf_id(struct iwl_trans *iwl_trans)
 
 VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info *
 iwl_pci_find_dev_info(u16 device, u16 subsystem_device,
-		      u16 mac_type, u8 mac_step, u16 rf_type, u8 cdb,
+		      u8 mac_type, u8 mac_step, u16 rf_type, u8 cdb,
 		      u8 jacket, u8 rf_id, u8 bw_limit, u8 cores, u8 rf_step)
 {
 	int num_devices = ARRAY_SIZE(iwl_dev_info_table);
@@ -2123,7 +2123,7 @@ iwl_pci_find_dev_info(u16 device, u16 subsystem_device,
 		    dev_info->subdevice != subsystem_device)
 			continue;
 
-		if (dev_info->mac_type != (u16)IWL_CFG_ANY &&
+		if (dev_info->mac_type != (u8)IWL_CFG_ANY &&
 		    dev_info->mac_type != mac_type)
 			continue;
 
-- 
2.34.1


