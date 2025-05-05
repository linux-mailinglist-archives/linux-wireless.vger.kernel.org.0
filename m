Return-Path: <linux-wireless+bounces-22476-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D45E4AA9C1D
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 20:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 160613A1868
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 18:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8299825D539;
	Mon,  5 May 2025 18:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aoHyDFbR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17802701D9
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 18:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746471451; cv=none; b=WU2Dhu7Ms9E/jxnSp3VH6UwZWqYzemWfR3Muwkzv8TKR2qDuSSNF/kcGg8pEvaCrR8pvx5GQjHe3zo0qC0bIGGIeHO1yapdVXYq9JFTs1JHWA9qbWOTj3/Zm98AgLCFCjVRANboK1jd/DRp/bTsE1EbbM7ScVPOv3DEmmbRpXx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746471451; c=relaxed/simple;
	bh=W3tlzxUzLV4wZdoobCkWSj+0YXF50DDjqD6+SgI/rVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EMDa1B38eleJKf4WLQwn5JONtCrMgt8+B2Ul1jqRM3M/EITHu07kUOirwE0LXwsL/YcqvtwxgYEXcQeH5MIBiO+6pXRLuoVhIYSfB/DWr8A5AsnHbh9PWWJm2mefIbL1ngPgcMAWFSNgW3LmQ4rUGb3vAdem4W8FrVmzRKJPlko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aoHyDFbR; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746471449; x=1778007449;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W3tlzxUzLV4wZdoobCkWSj+0YXF50DDjqD6+SgI/rVU=;
  b=aoHyDFbRFGplsz9JsEwH4HkZjp9g337sSurwXUfkubv3SLTNZa6eTinG
   3uh8xKmJZerYEXDrxFF2LEKwBsUwQli/z/boAFHaYa0CIaaZbF9Mbv5ky
   dXQuRXknteN5EN8Zw1mZhhsN3aXE58RJX2ELTWTEftfkDayslyttPiruD
   nM1Szs8X+8R+EJL0ltJ1du9WnZ2Hd72tK2z9Igfbsf9R2uvN3DYm52hmK
   eyNxN8tdChHZEsKlslgHKAWwoQRSKJSr4agB6b0UQhtPe1xrR/vuL0K2y
   1Wt1X0Yi05Caica8mnnv7lwGQp6dbhIkyQYmI3pd01bDRETEtZA0Z0kxP
   w==;
X-CSE-ConnectionGUID: DaNNyJkwS4eVpj82BwcBgg==
X-CSE-MsgGUID: pT29Yj1EQQKFLHx7Z4yP5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="47359461"
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="47359461"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 11:57:29 -0700
X-CSE-ConnectionGUID: QXLNHrgdSXyHbWpUd74t/Q==
X-CSE-MsgGUID: mu2Yi97kTnS8jEePMYspXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="135698048"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 11:57:28 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 13/15] wifi: iwlwifi: fix 6005N/SFF match
Date: Mon,  5 May 2025 21:56:52 +0300
Message-Id: <20250505215513.63bdbd67b72d.Id9b93b695c91117967dfd339c76bdfcd2872bee6@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250505185654.2068339-1-miriam.rachel.korenblit@intel.com>
References: <20250505185654.2068339-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

That mask should never have been 0xFFFF (mask also doesn't
make sense in that case) but rather 0xF000 since I combined
a few entries with 0xC___.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 36ae27a5cd42..22049bc7e72e 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -669,7 +669,7 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x0085), SUBDEV_MASKED(0x6, 0xF)),
 
 	IWL_DEV_INFO(iwl6005_n_cfg, iwl6005_2agn_sff_name,
-		     DEVICE(0x0082), SUBDEV_MASKED(0xC000, 0xFFFF)),
+		     DEVICE(0x0082), SUBDEV_MASKED(0xC000, 0xF000)),
 	IWL_DEV_INFO(iwl6005_n_cfg, iwl6005_2agn_d_name,
 		     DEVICE(0x0082), SUBDEV(0x4820)),
 	IWL_DEV_INFO(iwl6005_n_cfg, iwl6005_2agn_mow1_name,
-- 
2.34.1


