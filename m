Return-Path: <linux-wireless+bounces-36296-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEfaN+y6AmonwAEAu9opvQ
	(envelope-from <linux-wireless+bounces-36296-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 07:30:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EC12F51A135
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 07:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B9D9A30508BB
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 05:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9A536B043;
	Tue, 12 May 2026 05:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GY3RZ+/v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B78342509
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 05:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778563409; cv=none; b=kuWpOX0GefdpaPHkU7Mt3wzAQTRqJ01/w5gWYeNdzCc6kwqkYLp+wEuFN05cxZqvzENniaQGcMdVjZluymC3eoN1Ko2MbTWcYrUrsMykPKjNyuypHpQOoAMXIH+ynC8uSSbdETWvqS1moz1505lIT7sHrntbYK/wAttGLYsIsYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778563409; c=relaxed/simple;
	bh=I3E18f+dU7gGvwo5Z0htvak8qOTvuNJJpRv5ELkLwKE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tMtgWzxllw8df5g3ti2Zkc54DHqrM9Ikveefki1bWAyBjZxbndzKyofiBA5cacMRTUcDe4yCI7WnIb1AcmhxZcX2W5I27oK7Krcyq4qY0W4sSkr1z1pmk5GwdRjzF3nYc1XvshxNz0HJclPsgeHEnjLGLK666ua2j35fp5aF2fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GY3RZ+/v; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778563407; x=1810099407;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I3E18f+dU7gGvwo5Z0htvak8qOTvuNJJpRv5ELkLwKE=;
  b=GY3RZ+/vZElr10LtjLQ8XoYPiLeBis3pHDELjddfyze5FuM2yqagoPxm
   8qlLxbLq0g+K0xnDAwlhMtVzV8qhkQS2DziS/WMe1oUCpyhJ/QDM/fOq/
   CTE0/ZVotn7NIWoi1eg7VvLFoOBedakTWtc1+aCdic0/xh1YdZqaLYm4V
   9VnR9fw/f8MAwFPeeZ6+2zaUphEvJbpJPS0f00SWt2IFbYAJSmIlQ3Clx
   tHr2NcTb6k4M8aUpsuET/LeuqukgmDwh6JFmlnjPcCYu391TnjUxTtUO5
   gUcfyxMa5OdTHMiQVYOAB5LTSPOCZJh/cXDXGRMYDJMRFyei1bAzgMJsR
   A==;
X-CSE-ConnectionGUID: SY14GfAQQkaYcDBTcy1DEg==
X-CSE-MsgGUID: 84rGKJ2eS6Gb0O6mfJEwKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="78495092"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="78495092"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 22:23:27 -0700
X-CSE-ConnectionGUID: cdtMjvhFTEmNjt1q2EXbmQ==
X-CSE-MsgGUID: 36eXCluXRxWYRx6uCjE0Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="233187536"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 22:23:25 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 05/15] wifi: iwlwifi: add support for AX231
Date: Tue, 12 May 2026 08:22:57 +0300
Message-Id: <20260512082114.0685ed313987.Ibcfa24e196ac778405d2843f0984b66ca167704e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260512052307.1603442-1-miriam.rachel.korenblit@intel.com>
References: <20260512052307.1603442-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EC12F51A135
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-36296-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

AX231 is a device that is based on AX211 that doesn't support 6E and
its bandwidth is limited to 80 MHz.
Just re-use the radio config from AX203 which has the exact same
characteristics.
It has a specific subdevice ID to allow the driver to differentiate
between AX211 and AX231.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c  | 3 ++-
 drivers/net/wireless/intel/iwlwifi/iwl-config.h | 4 +++-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c   | 3 ++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c b/drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c
index c16cda087a7c..307b557dce99 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2025 Intel Corporation
+ * Copyright (C) 2018-2026 Intel Corporation
  */
 #include "iwl-config.h"
 
@@ -71,6 +71,7 @@ const char iwl_ax411_killer_1690i_name[] =
 
 const char iwl_ax210_name[] = "Intel(R) Wi-Fi 6E AX210 160MHz";
 const char iwl_ax211_name[] = "Intel(R) Wi-Fi 6E AX211 160MHz";
+const char iwl_ax231_name[] = "Intel(R) Wi-Fi 6 AX231";
 const char iwl_ax411_name[] = "Intel(R) Wi-Fi 6E AX411 160MHz";
 
 IWL_FW_AND_PNVM(IWL_SO_A_GF_A_FW_PRE, IWL_GF_UCODE_API_MAX);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 5f40cd15e27f..b9480a08bc86 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -2,7 +2,7 @@
 /*
  * Copyright (C) 2005-2014, 2018-2021 Intel Corporation
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2025 Intel Corporation
+ * Copyright (C) 2018-2026 Intel Corporation
  */
 #ifndef __IWL_CONFIG_H__
 #define __IWL_CONFIG_H__
@@ -667,6 +667,7 @@ extern const char iwl_ax411_killer_1690s_name[];
 extern const char iwl_ax411_killer_1690i_name[];
 extern const char iwl_ax210_name[];
 extern const char iwl_ax211_name[];
+extern const char iwl_ax231_name[];
 extern const char iwl_ax411_name[];
 extern const char iwl_killer_be1750s_name[];
 extern const char iwl_killer_be1750i_name[];
@@ -736,6 +737,7 @@ extern const struct iwl_rf_cfg iwl_rf_hr;
 extern const struct iwl_rf_cfg iwl_rf_hr_80mhz;
 
 extern const struct iwl_rf_cfg iwl_rf_gf;
+#define iwl_rf_ot iwl_rf_hr_80mhz
 #endif /* CONFIG_IWLMVM */
 
 #if IS_ENABLED(CONFIG_IWLMLD)
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index dc99e7ac4726..6ff773d22ce0 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2005-2014, 2018-2025 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2026 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -1014,6 +1014,7 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 
 /* GF RF */
 	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_name, RF_TYPE(GF)),
+	IWL_DEV_INFO(iwl_rf_ot, iwl_ax231_name, RF_TYPE(GF), SUBDEV(0x0294)),
 	IWL_DEV_INFO(iwl_rf_gf, iwl_ax411_name, RF_TYPE(GF), CDB),
 	IWL_DEV_INFO(iwl_rf_gf, iwl_ax210_name, DEVICE(0x2725)),
 
-- 
2.34.1


