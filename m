Return-Path: <linux-wireless+bounces-6313-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E44A8A4AEF
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 10:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D71851F2064D
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 08:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F272482E2;
	Mon, 15 Apr 2024 08:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eul4A8gu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058FC4779F
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 08:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713171305; cv=none; b=NgZlCqICSqT/B8NC7Ozlfx2d8NJWXskxAO9hr7trZoojkxP6MiEp4AQMRq+MF7Ii/kigi3OyKEX9LHTpu5Shfq7QbQgh+JjNe0DUwyW3xMt9462VuCy/30xBzSUpkZ78s0WnAdbMhwsQuGwoChTAJKFreFW/rvseJ70GLrOPrR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713171305; c=relaxed/simple;
	bh=GDOhuqauysbMmVmh560fAYYqIPwU9oDYSsOrP77Gyus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MFBUSjO77KKBEJcxps+ybd4rd4VVHRWrhIwJNfPLQPpKxmR/p/FddbK6UcgACulduXIkPR5GQ25fo5KM04pbRTtBYyFIdj7r5RQixhFxKLyys4BUxEavkWV/5eGX4PaitOW6zb2M1OUl29M4UVa8maz52WbUKo+TF7ZvRze1l3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eul4A8gu; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713171304; x=1744707304;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GDOhuqauysbMmVmh560fAYYqIPwU9oDYSsOrP77Gyus=;
  b=Eul4A8gugyY9YPimrktKU73t3rwUz7o8hQb+uzRBToEzHLLV9SoeQF3W
   8LXKZOEAaberIsrIO7rO6yCUuJo+Vt3iNPBbDeZooY5XTAiIaLJU7gZK8
   4mtNC0Ymi7KLpe1aKFfFZWMPy/CFFFGGAc4KUoetvgHw/SXzw5jmgy9wn
   ZLB2B9uulOXFwVZnIYhRczJrRXKzBtRp1dXYgiWPg7VSjt3zlima0y13Z
   VUkgomZKasqsfrheKKdjr+cAJY888yZPo2gW9YGCqIbOcrrq8p/5jitmH
   Oa+zMlTTulNu+yHlEM/8jVQeixmIKUVnNSR0P76tf8zTGcTJVyFQTUFhN
   A==;
X-CSE-ConnectionGUID: gFlJgMSWQaCk649K+74Etg==
X-CSE-MsgGUID: 4/Mg2uLnQmmykLb5vYm1IA==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="9100592"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="9100592"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 01:55:04 -0700
X-CSE-ConnectionGUID: gDLnNcUkS8eW4ZMZbdJiEA==
X-CSE-MsgGUID: G7rPRhziT/aGfX6HbOmUFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="21768002"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 01:55:03 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH 05/11] wifi: iwlwifi: move WTAS macro to api file
Date: Mon, 15 Apr 2024 11:54:38 +0300
Message-Id: <20240415114847.61c9163859a7.Id29a86566ff313ab8e85aa1007f841e95a67d6b7@changeid>
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

From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

regulatory header file should not be included in API file,
as API defination should be independent.

Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h | 2 +-
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
index 988b5421a629..6f16d0d3d8e5 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
@@ -7,7 +7,6 @@
 #ifndef __iwl_fw_api_nvm_reg_h__
 #define __iwl_fw_api_nvm_reg_h__
 
-#include "fw/regulatory.h"
 /**
  * enum iwl_regulatory_and_nvm_subcmd_ids - regulatory/NVM commands
  */
@@ -439,6 +438,7 @@ enum iwl_mcc_source {
 	MCC_SOURCE_GETTING_MCC_TEST_MODE = 0x11,
 };
 
+#define IWL_WTAS_BLACK_LIST_MAX		16
 /**
  * struct iwl_tas_config_cmd_common - configures the TAS.
  * This is also the v2 structure.
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
index a0cb8881e629..c9fbd84e0436 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
@@ -11,6 +11,7 @@
 #include "fw/api/power.h"
 #include "fw/api/phy.h"
 #include "fw/api/config.h"
+#include "fw/api/nvm-reg.h"
 #include "fw/img.h"
 #include "iwl-trans.h"
 
@@ -39,7 +40,6 @@
 #define IWL_PPAG_ETSI_CHINA_MASK	3
 #define IWL_PPAG_REV3_MASK		0x7FF
 
-#define IWL_WTAS_BLACK_LIST_MAX	16
 #define IWL_WTAS_ENABLED_MSK		0x1
 #define IWL_WTAS_OVERRIDE_IEC_MSK	0x2
 #define IWL_WTAS_ENABLE_IEC_MSK	0x4
-- 
2.34.1


