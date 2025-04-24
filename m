Return-Path: <linux-wireless+bounces-21990-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1CDA9ADB0
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 14:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71C1492413C
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 12:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751AC27A12A;
	Thu, 24 Apr 2025 12:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U2vWnTh3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55C027B4F1
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 12:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745498348; cv=none; b=D66yFFB4TnEJXBu9u03ASgVfnGgUU/5taSbkZ2W8oZMFGC34yqbXvRYxhRD3RC6NH2uR3kZrgNaXGvzagy1PWb1wE26O77ch+pjR+ExWxHgfPtCcUsA9YO7DnnIE9xyeRsFVGV17xcXFlySyIBJ2K12PN6SYkiD+iCo5aybFtBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745498348; c=relaxed/simple;
	bh=0QHQr0qt7DIQqhpsui2TxuCQFKPSM0Nl7PJ7GzLIpFk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XFilvMuvh2/qVQdfgXawmOJPqn+84hChXRMGxlg1Pn0Qe5EqYU/2zUMwpCd375iZOAuinAu6K6Jp+UOOWc6WcSUwRMrDnTcnWalxBelUkcIlSnAL3FeY25PgVcTKyoOKMUqiYAUyK7PkjeVFSD/RCQvqQcoAr4ZuAHGvkJQpdrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U2vWnTh3; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745498347; x=1777034347;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0QHQr0qt7DIQqhpsui2TxuCQFKPSM0Nl7PJ7GzLIpFk=;
  b=U2vWnTh3QtsyAl3iHxplo4UtYS80U8KlD3MIBienhaYCiaTS+0NTMvc5
   i8TwRqzdgTQYgXu6v2ZcOJ3IUzZwvDb7aUHlaFFmKwhrsb96Ro5XXNAXB
   lsiIeXq4v+Wy+pKngHQauzH6zg8kw+OME+1t+69yJwDzUrp0jEZuoEOz3
   cfbc7Y4IKQiN3aXdK81TmZLXC69cNxfyyw4i4vPxgXEoh1lgOjn5n93aa
   etqXBLBb/2ALp7Y4yCk1fo8saI6MDg2MrvfJ6OrsT+PCuOF/r6bTvB5h3
   8TLWeFFEdzIlkgOHVVMBjFP5CaYMa86ZLan4hqKHMJNDsfZJbxiEFpPCf
   A==;
X-CSE-ConnectionGUID: GZYknH6fSVSzQ8r9oPcL/w==
X-CSE-MsgGUID: JDzZaxu4TbKUfX3ZKF9Yfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="47302446"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="47302446"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 05:39:06 -0700
X-CSE-ConnectionGUID: 1gnGHeOxQ6eJ3OYieW2Eag==
X-CSE-MsgGUID: WNg/ee6kS1CxaSIP+BRMkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="133137463"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 05:39:05 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH wireless-next 12/14] wifi: iwlwifi: add definitions for iwl_mac_power_cmd version 2
Date: Thu, 24 Apr 2025 15:38:29 +0300
Message-Id: <20250424153620.991ff01b8d16.Id0aa4061d7926753b03a13bf94ec1ac9e1d18745@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250424123831.3524359-1-miriam.rachel.korenblit@intel.com>
References: <20250424123831.3524359-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This version has a new flag bit that indicates whether or not SMPS is
allowed for the MAC.
This only adds the API, the actual support will be done in other
patches.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
index 29a1a7448cbe..1238c23ac48b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2025 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -89,6 +89,7 @@ struct iwl_ltr_config_cmd {
  * @POWER_FLAGS_LPRX_ENA_MSK: Low Power RX enable.
  * @POWER_FLAGS_UAPSD_MISBEHAVING_ENA_MSK: AP/GO's uAPSD misbehaving
  *		detection enablement
+ * @POWER_FLAGS_ENABLE_SMPS_MSK: SMPS is allowed for this vif
 */
 enum iwl_power_flags {
 	POWER_FLAGS_POWER_SAVE_ENA_MSK		= BIT(0),
@@ -99,6 +100,7 @@ enum iwl_power_flags {
 	POWER_FLAGS_ADVANCE_PM_ENA_MSK		= BIT(9),
 	POWER_FLAGS_LPRX_ENA_MSK		= BIT(11),
 	POWER_FLAGS_UAPSD_MISBEHAVING_ENA_MSK	= BIT(12),
+	POWER_FLAGS_ENABLE_SMPS_MSK		= BIT(14),
 };
 
 #define IWL_POWER_VEC_SIZE 5
@@ -216,7 +218,6 @@ struct iwl_mac_power_cmd {
 	/* CONTEXT_DESC_API_T_VER_1 */
 	__le32 id_and_color;
 
-	/* CLIENT_PM_POWER_TABLE_S_VER_1 */
 	__le16 flags;
 	__le16 keep_alive_seconds;
 	__le32 rx_data_timeout;
@@ -237,7 +238,7 @@ struct iwl_mac_power_cmd {
 	u8 heavy_rx_thld_percentage;
 	u8 limited_ps_threshold;
 	u8 reserved;
-} __packed;
+} __packed; /* CLIENT_PM_POWER_TABLE_S_VER_1, VER_2 */
 
 /*
  * struct iwl_uapsd_misbehaving_ap_notif - FW sends this notification when
-- 
2.34.1


