Return-Path: <linux-wireless+bounces-6312-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F16B8A4AEE
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 10:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C04541C212BB
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 08:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EDC45BE2;
	Mon, 15 Apr 2024 08:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Az6W55+S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D573044C61
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 08:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713171303; cv=none; b=QzhdCO8Ls59jlPCVt8VyxujZm8mwT9fQ7zVjD8mjNT7UjL5+jz1FXSlAMfhFPCPvl3dwGCrZfWVa6a+Dt4ylao7n5nwgkhF5sST4DclviVjrXFLd/xsQRsz7QWS/j3olpnFEjYBfTUoyFtA5MxojZ9+jjmJ1WvOESV4D/UFQ7KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713171303; c=relaxed/simple;
	bh=laNcgBko/kq0PUqo16sDtE+GZa1L0Bo1YoTnJFTMTeg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QATYcEQEhLOqLu7QHcGQWnHg+/LRGxiJ8Gt+KEqRE+ep1dnHQAE9UGtAaHeRxtO5YhLMzRR35BnlHoz959xp98nfTn8Q9d4uiQKx8TWtZxwfXzlMLm+XKn3RWqraK7/GqEiCNWl+Lkpb4TWinme6ggsxqnOdrHJO3CAayTkk7OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Az6W55+S; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713171302; x=1744707302;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=laNcgBko/kq0PUqo16sDtE+GZa1L0Bo1YoTnJFTMTeg=;
  b=Az6W55+S/dN0d4iWJSloGi4lMeeJm/7Hro/4+Y4SopeuQIjm3ofGqYru
   JLhgFnaaL0oL8Wx6Gpsys9IzCBFdkDozn4Ng3rVZpaMHtqahdNsJW1srU
   eBqJYyA1wc9gmyq/9U72gFz24ZiwFv7B08C7JX9DsPj0QEIzl/iLKXA0o
   q/uHRc0OuXzVFdXl8Fgw1xfXh41JbkDG9T6gwEdjQmwrfcUduy+Gs0Eyk
   eGIq+ZBRx0hXPUW6yvB1DFl85hooCCiwurWAxUik6mujSkeKpEQUFfuKf
   beYR+YPgLLWuMXc+frvcQajKqLspQe8km8++3vmAEXyTfAG6k/7lIe93g
   Q==;
X-CSE-ConnectionGUID: ocJjUKWVQU2TRg2mKI0T9w==
X-CSE-MsgGUID: 6B4GwsHSTjqVrbzkhA3Xcw==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="9100589"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="9100589"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 01:55:02 -0700
X-CSE-ConnectionGUID: GSsWIk3jSqmNDRWJOWdJGw==
X-CSE-MsgGUID: 487nD/OITv2qPzSEfS+aZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="21767981"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 01:55:01 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 04/11] wifi: iwlwifi: mvm: extend STEP URM workaround for new devices
Date: Mon, 15 Apr 2024 11:54:37 +0300
Message-Id: <20240415114847.db62bba6b2fa.Ie7fdc75c0b8759574a8744f0a316065cb791dd82@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415085444.3840884-1-miriam.rachel.korenblit@intel.com>
References: <20240415085444.3840884-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The same applies for newer devices (currently SC), so just
change the condition here.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 1f8d4723512f..5958e48d812b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -666,7 +666,7 @@ static int iwl_run_unified_mvm_ucode(struct iwl_mvm *mvm)
 	iwl_dbg_tlv_time_point(&mvm->fwrt, IWL_FW_INI_TIME_POINT_AFTER_ALIVE,
 			       NULL);
 
-	if (mvm->trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_BZ)
+	if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
 		mvm->trans->step_urm = !!(iwl_read_umac_prph(mvm->trans,
 							     CNVI_PMU_STEP_FLOW) &
 						CNVI_PMU_STEP_FLOW_FORCE_URM);
-- 
2.34.1


