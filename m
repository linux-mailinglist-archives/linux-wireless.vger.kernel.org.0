Return-Path: <linux-wireless+bounces-26726-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09828B39468
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 08:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9601684131
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 06:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2333D2D0C67;
	Thu, 28 Aug 2025 06:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XoIhlQha"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1E52C2377
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 06:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756364166; cv=none; b=PieTJNojFb+5lVkQY5X00XDQ7NljAvMGnEF+9W/2wvJFUWndGHbEBwgGDzeue5ktx59NQD44Qowd9s1RaOjEqeFDa12QIxPaV0/j2Wu4XrrLQOPTutDQgECtQO3968EXNxglviIQfYqS4HA0CHc2J2aJlHL/cxA7G0ehz/GYLvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756364166; c=relaxed/simple;
	bh=K1u8actv6Zikb33Cy5zP7fOrBdmzJf9AI3Z5ay/alzk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u9bR9DE21PVkhM2cnAGNl4pDboOE6IkuXx5awCA5s8AtfpQnlUkN75GNtxD+yU97pcuOUNHaeAe68898EbuCw9uZEoMB2CWHWTAbRPEdAj3d5wmvQgp4vUz2XiHZdcZTm9t84uNTEye1IxBn9u9cFTqWPp/Jd8dTDA10qJOgQf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XoIhlQha; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756364165; x=1787900165;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K1u8actv6Zikb33Cy5zP7fOrBdmzJf9AI3Z5ay/alzk=;
  b=XoIhlQhab7T23gs6zeGgXOBzgRgL/9qdp7mx672AiSPBoc/APdiKL5Ca
   JESOa2SQHglLhKBvjV1DtopJh+5U5/tBpVAbteMjaEgci9+LrnvSCtcQZ
   N5hJ0xY8J1+hNWHJ5NtWqxwzJkLPBl9Q7T48SelvIB7il1rIMfOELCaO0
   uZ6xtj3YHDrByiwkZQN614dSqgQ/QL7CGoy1WZ0lvJrpPauq1gPAqTo6E
   GPVGrA3rqTCltI8S/endLNpyByapDeiSIlaP2IvAKLQ4ffqCsObFeQfPn
   Cpb8fpz18MnLqyi6eAj2zHSYZuMIgz4SRBY7Lqf/p3iIMvGY6K1ESDaUh
   Q==;
X-CSE-ConnectionGUID: sot4m80uQ164BjwyAbvaag==
X-CSE-MsgGUID: hgIBIsyaQKW9+UZgLf57cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="58723694"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="58723694"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 23:56:04 -0700
X-CSE-ConnectionGUID: Dv+GfA4cSNGogYdDt4uTKw==
X-CSE-MsgGUID: 6OQRxvowQCe64xlMCc7Grw==
X-ExtLoop1: 1
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 23:56:03 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-fixes 6/6] wifi: iwlwifi: cfg: add back more lost PCI IDs
Date: Thu, 28 Aug 2025 09:55:31 +0300
Message-Id: <20250828095500.46fee422651e.I8f6c3e9eea9523bb1658f5690b715eb443740e07@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828095500.0f203e559242.I59eff718cb5fda575db41081a1a389f7af488717@changeid>
References: <20250828095500.0f203e559242.I59eff718cb5fda575db41081a1a389f7af488717@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Add back a few more PCI IDs to the config match table that
evidently I lost during the cleanups.

Fixes: 1fb053d9876f ("wifi: iwlwifi: cfg: remove unnecessary configs")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index f5e72c90dd57..f9e2095d6490 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -673,6 +673,8 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 
 	IWL_DEV_INFO(iwl6005_n_cfg, iwl6005_2agn_sff_name,
 		     DEVICE(0x0082), SUBDEV_MASKED(0xC000, 0xF000)),
+	IWL_DEV_INFO(iwl6005_n_cfg, iwl6005_2agn_sff_name,
+		     DEVICE(0x0085), SUBDEV_MASKED(0xC000, 0xF000)),
 	IWL_DEV_INFO(iwl6005_n_cfg, iwl6005_2agn_d_name,
 		     DEVICE(0x0082), SUBDEV(0x4820)),
 	IWL_DEV_INFO(iwl6005_n_cfg, iwl6005_2agn_mow1_name,
@@ -964,6 +966,12 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x24F3), SUBDEV(0x0004)),
 	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2n_name,
 		     DEVICE(0x24F3), SUBDEV(0x0044)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F4)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl4165_2ac_name,
+		     DEVICE(0x24F5)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl4165_2ac_name,
+		     DEVICE(0x24F6)),
 	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
 		     DEVICE(0x24FD)),
 	IWL_DEV_INFO(iwl8265_cfg, iwl8275_2ac_name,
-- 
2.34.1


