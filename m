Return-Path: <linux-wireless+bounces-9913-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 779B892579C
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 12:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2051D1F2672D
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 10:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2FE16132A;
	Wed,  3 Jul 2024 09:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MkOn708q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E83513DDA3
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 09:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720000774; cv=none; b=s4FtAYAotaBicMCyhWtyGuo01NCYCZJxwdkSHZhXXYH01HIGc85Gq5TLEEkajjnnIY17tVGA0NjwS7ISBJ8wDVmfLvNUKIktLFXrs71uDpTc0Xz6aJIcK1MghyVy+//bi6GUBI8FJSMhIZDQHhJab5mxwe20xEHHg/9sbIwW48c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720000774; c=relaxed/simple;
	bh=4SaEGdWstxWE3OZ82j5jR/oRtuNX0FcMeaRfblPs28g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BRJO5tCag39f1VihHH0MxeibYOfCe/2fedhqVja28KAiD2smAueg3DYDnaF3jOOZQQ1aLlMlwScUdN1/bbxjhkKJZ/vOsUfIgApSGVnFJ6IPOLUuMx2027ZZC0qC/J+CZ3v82WMCv/RvO3Ua3Nn/gOdhmCu6moKFcxB6vDFTSXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MkOn708q; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720000773; x=1751536773;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4SaEGdWstxWE3OZ82j5jR/oRtuNX0FcMeaRfblPs28g=;
  b=MkOn708qm4s/Xi5WyZ3oLMO4h1rwAj+Vjewj9MWkPQvGKHIlPQiCc/S0
   u1FbNvYwBOqMC3QMEla/vzZvBJhgDD6IlFyxTRf/lm4ZOV1oYpBKwgQZh
   PkuAB1Z3R5C0HcTGzrndQBnktGD66iLTbY+wpiuQ2JaV3ERDILykW/cG2
   aZHMWTBKz88Zrz2oI/R13HWNzRcCdmlguoQD9IU//tdujkZNvvVt3Jxcm
   dFOOKvvJ82ZNCGSEqb4cM9GRAy6Q1eC21Zq5TEJJ//oEx9guFDknTIQTy
   J5L9wkv+qZb8bnP/PTk/oP9a0lvm831OINYIO25esjNrQlXquyMbCXIa4
   A==;
X-CSE-ConnectionGUID: pI4GPTEdRfy8p63txbddhQ==
X-CSE-MsgGUID: 1o0JJRl3Sdau6YdydiA5Rg==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27837555"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="27837555"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 02:59:33 -0700
X-CSE-ConnectionGUID: /MtO3TC1TbiauyMD01CITA==
X-CSE-MsgGUID: aVNw8r+QR5m3iulM6jcbUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="45987826"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 02:59:31 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 12/18] wifi: iwlwifi: fw: api: mac: fix kernel-doc
Date: Wed,  3 Jul 2024 12:59:00 +0300
Message-Id: <20240703125541.a7179f1b0e7e.Idd7ce381960707978ff0b16035101a2a725a4fd9@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703095906.833028-1-miriam.rachel.korenblit@intel.com>
References: <20240703095906.833028-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Fix kernel-doc for MAC context APIs.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/mac.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
index 545826973a80..bcbbf8c4a297 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
@@ -310,6 +310,13 @@ struct iwl_ac_qos {
  * @filter_flags: combination of &enum iwl_mac_filter_flags
  * @qos_flags: from &enum iwl_mac_qos_flags
  * @ac: one iwl_mac_qos configuration for each AC
+ * @ap: AP specific config data, see &struct iwl_mac_data_ap
+ * @go: GO specific config data, see &struct iwl_mac_data_go
+ * @sta: BSS client specific config data, see &struct iwl_mac_data_sta
+ * @p2p_sta: P2P client specific config data, see &struct iwl_mac_data_p2p_sta
+ * @p2p_dev: P2P-device specific config data, see &struct iwl_mac_data_p2p_dev
+ * @pibss: Pseudo-IBSS specific data, unused; see struct iwl_mac_data_pibss
+ * @ibss: IBSS specific config data, see &struct iwl_mac_data_ibss
  */
 struct iwl_mac_ctx_cmd {
 	/* COMMON_INDEX_HDR_API_S_VER_1 */
-- 
2.34.1


