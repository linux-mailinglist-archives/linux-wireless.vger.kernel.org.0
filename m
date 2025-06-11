Return-Path: <linux-wireless+bounces-23960-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED23DAD4968
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 05:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A83BE16605F
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 03:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5300211497;
	Wed, 11 Jun 2025 03:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T16XFzLX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EE01EA7FF
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 03:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749612877; cv=none; b=Cd094G05lrSpbDrlfKc0tHt4sVhBRVEqz815/09sQGVqtMBoifF8nX8yYp3e/SvqPJeGe1wHcQbGPNq9Nj2A5IaNc57ySeTkNiS/98BGHPKWoMdrz2NGOJynYS65qPdEJclZ/7GXsnjudaAZinABzj8o9oQCInSJQlV9q4wba2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749612877; c=relaxed/simple;
	bh=vFaw8DdSiGh0at6BYe0LRkJWv/OhnvWxzE6n1Q3UtkM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nL5Y5EgyqQrobMvyCnGTFDUm0ohChTTzvWHUIDSRr0SnTyxT1iFvDKUmkZdw0m1P+F+gwwsQpc/qrIkuPMPqvR1VfXegaQUGnR3k3NN6Q0vpz61J/n6yrcRHT+iGOHE63fCiBun3v5RayOgFdfhHspQPkvvt9Uh6cT0GUfRAUnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T16XFzLX; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749612876; x=1781148876;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vFaw8DdSiGh0at6BYe0LRkJWv/OhnvWxzE6n1Q3UtkM=;
  b=T16XFzLXayJLJAVNrOWaqA3g10I1/CjnlyzO98gd98Ue5/Uid6jy/Efj
   ul4m7YfXR/G/HGXYuomoUriouKeXyRLyS6VFQdbOhD7qmPjpVjIFE57VT
   uIw/cWfhMGw33640u3v2FJMK0ZF6NCxPz0CooCc3CNiWmBfZsIiUgYUnF
   HCzdeygGG9plDtdJQ18H7zTRopcoAqsGZvlx1VPw9s6IkkaDVRdqnpBWu
   vTdAfHzn7VRFZpTvyWZNyQPZWh32C5BEZvFv/w4hrCyDdnp1kA7MmXNiw
   hK+ZM58jx1PavY89UypLc6nRq15O3XuSemZEbok+GtcX3V5C32ewoK2GL
   A==;
X-CSE-ConnectionGUID: F4nYBoH4RnOvsv9hxz0gqQ==
X-CSE-MsgGUID: MnAnsFStToWrR+76wjMtMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="63094880"
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="63094880"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 20:34:36 -0700
X-CSE-ConnectionGUID: Y0qL3h+eSTiW3cjX6RDtIA==
X-CSE-MsgGUID: 6C59R+XcTHexm4sxOs4i8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="150880921"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 20:34:34 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH iwlwifi-next 03/15] wifi: iwlwifi: mld: Add dump handler to iwl_mld
Date: Wed, 11 Jun 2025 06:34:03 +0300
Message-Id: <20250611063124.18ebf46690ce.Ia52941f761a446cb3e43cbe49d2b9a49fc15f4a8@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611033415.1175681-1-miriam.rachel.korenblit@intel.com>
References: <20250611033415.1175681-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Implement a dump handler in the iwl_mld operation mode to
collect firmware dump upon trigger from trans layer.

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mld.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
index 8cdd960c5245..103912c4e4cc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -723,6 +723,17 @@ static void iwl_mld_device_powered_off(struct iwl_op_mode *op_mode)
 {}
 #endif
 
+static void iwl_mld_dump(struct iwl_op_mode *op_mode)
+{
+	struct iwl_mld *mld = IWL_OP_MODE_GET_MLD(op_mode);
+	struct iwl_fw_runtime *fwrt = &mld->fwrt;
+
+	if (!iwl_trans_fw_running(fwrt->trans))
+		return;
+
+	iwl_dbg_tlv_time_point(fwrt, IWL_FW_INI_TIME_POINT_USER_TRIGGER, NULL);
+}
+
 static const struct iwl_op_mode_ops iwl_mld_ops = {
 	.start = iwl_op_mode_mld_start,
 	.stop = iwl_op_mode_mld_stop,
@@ -737,6 +748,7 @@ static const struct iwl_op_mode_ops iwl_mld_ops = {
 	.sw_reset = iwl_mld_sw_reset,
 	.time_point = iwl_mld_time_point,
 	.device_powered_off = pm_sleep_ptr(iwl_mld_device_powered_off),
+	.dump = iwl_mld_dump,
 };
 
 struct iwl_mld_mod_params iwlmld_mod_params = {
-- 
2.34.1


