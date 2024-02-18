Return-Path: <linux-wireless+bounces-3749-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7FD859856
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Feb 2024 18:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D90F1F21968
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Feb 2024 17:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087AF6F08F;
	Sun, 18 Feb 2024 17:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oBoVRiLC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563A76F080
	for <linux-wireless@vger.kernel.org>; Sun, 18 Feb 2024 17:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708278747; cv=none; b=QGZDWJ1JUYp/Y5UOBltuUv9Axh0PLz8v+lBEm0xndfW3Jp7CvLhMONBLjbT8dTzw780lFJEWo/5Zv/uOLeAtYxHeh7ABXt3aWh7+aFthjnZxwEkSrnPlhEelahpV53P+Kg9Cd2oGi2qRfMaCegekNEsVL9WjZLvx5F+1Ci0s5sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708278747; c=relaxed/simple;
	bh=9zDHKr0sXLpcAQC2oU+jRY0kF5s2dE6lrdDWL1P+RFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qe/iu5hojkMZDFqIVf1mrMqO0HE5Bg/gbt4unweNNPw6dStUnCEKL10HprUkS2AwvM2tk0Y/gNRdEc7oYPWYSG8jjyTciCsmVIS6bMgOI3sAeG0TdczoCig7mZ1Rml6oNkeqr9jLsANQTvo1evSkIj0NervDJ4oUkE1Eag30QBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oBoVRiLC; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708278740; x=1739814740;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9zDHKr0sXLpcAQC2oU+jRY0kF5s2dE6lrdDWL1P+RFc=;
  b=oBoVRiLCyp74s7QYlnP1VedEZ7LbK/eSDP3iqXusJ21D4qUDXMUx6lRQ
   kWWEA/PwTN2FVajifZgeH5c8HY5E2x2Vxie0+xeGoW9Z+NGBmEZ4PigLc
   ypUI8BUrwVij7HSc316nWtXSJE0CJrn7FxiAJitJ5UDljrs6yS8sc+ppT
   EsR8OFWs6ZlYqf8wwAEpDgMOkmyUTT21vZAXJovqVuQfERpIP1M0TTurY
   vyHh4qQkHF9U2q9Kzy/X8GxOED0qBScqFG3v/6L/4u2Q4Hm+tcMsHljEm
   3UyHdZGdccUhu8BH2SyFkRkJ7qr7iseHDRpEilEcb3eoqkHGcM+dtF36i
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2464983"
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="2464983"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 09:52:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="27459446"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 09:52:17 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 07/11] wifi: iwlwifi: api: fix kernel-doc reference
Date: Sun, 18 Feb 2024 19:51:48 +0200
Message-Id: <20240218194912.5475d49bce86.I640a12bc799612e82c3e7a4d628bbb7760511297@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240218175152.3133364-1-miriam.rachel.korenblit@intel.com>
References: <20240218175152.3133364-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This is for iwl_tas_config_cmd_v4, not iwl_tas_config_cmd_v3.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
index 8c886569f01e..58034dfa7e70 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -462,7 +462,7 @@ struct iwl_tas_config_cmd_v3 {
 } __packed; /* TAS_CONFIG_CMD_API_S_VER_3 */
 
 /**
- * struct iwl_tas_config_cmd_v3 - configures the TAS
+ * struct iwl_tas_config_cmd_v4 - configures the TAS
  * @override_tas_iec: indicates whether to override default value of IEC regulatory
  * @enable_tas_iec: in case override_tas_iec is set -
  *	indicates whether IEC regulatory is enabled or disabled
-- 
2.34.1


