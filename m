Return-Path: <linux-wireless+bounces-16934-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D997E9FEF39
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2024 12:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 920E6161C27
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2024 11:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872F219CC17;
	Tue, 31 Dec 2024 11:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DPYIqlgJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6448199FA2
	for <linux-wireless@vger.kernel.org>; Tue, 31 Dec 2024 11:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735646374; cv=none; b=HPoUjyR0b7xDds/yadAFTZv/R2CJSY72fT1LEj2ZAQqLMODHjnaqtRIfE5dPv6dUHTpvLZU3Vox08HaEszdp+rt7PYKdvHzCnwv+FAl0hDtjv+QD/9HgmUGf1gsHPxcmDtUNbHyVQXZapCzHkrChr1JV6dkM28r1/F53jRcxU3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735646374; c=relaxed/simple;
	bh=52iYNotIMu9ZEeA7TsQXd+16FA3hE/bJx9MEaUIFRlc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bJDvhSst9RX6hAR9jWbZpKLJdh0A0OGqJJUja5DXyCA8VSfobUWNtkE4ZUfS2a3BMHilTCkSZpg9CjGyy2Fd3Qc43OP3wQ+KvG98r03WvHO2/0NeJBuVXXtmlsJhNETOKDZH7vsNH8p5w/CMMiPvNARR8A+Ne/3r9nBVBA+8wRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DPYIqlgJ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735646373; x=1767182373;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=52iYNotIMu9ZEeA7TsQXd+16FA3hE/bJx9MEaUIFRlc=;
  b=DPYIqlgJBUZm1tpe4Wi7tEJKmsJJuoJQ/Q2uhQJ3rX4/GoswaYt/aZsb
   S8l85NI5DcqIm2Ze+62tEJabxGu6wAdvd56vKJM7Ky6uYipGMSskum40t
   d0pBnqrWwEZUy4VoPd56joGIkqZ8fdeXtRXarHVoWi6s6NjJHR4wcSt24
   NGznpM0wxLkIDNAYmTn/LMlVbsY04hloASc9BKakifx7bJ3j1mVnPelzJ
   kw2ZyCu10dU48Hm15tY6gfGzJ1bEgmeUaQA+TE9zt9n3umeE4KtJjyF0f
   9L6i6/HMBzsg8YXwmE/Kvg1D2NRJaSUQcMCv7FdUXWbz/HTlXEvJ23eZs
   A==;
X-CSE-ConnectionGUID: YuXScFYqQ7WYf1ZXpuUDgg==
X-CSE-MsgGUID: vVieMDSoT+Gwv88x1U+d9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="53330159"
X-IronPort-AV: E=Sophos;i="6.12,279,1728975600"; 
   d="scan'208";a="53330159"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 03:59:33 -0800
X-CSE-ConnectionGUID: LeYex/HDSiyZPbbSnMFfZQ==
X-CSE-MsgGUID: 9Be56NoVTd2a+QiHqcdYHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="138380262"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 03:59:32 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 02/15] wifi: iwlwifi: get the max number of links from the firmware
Date: Tue, 31 Dec 2024 13:59:02 +0200
Message-Id: <20241231135726.5eb29510f2b4.I7f35f61987c2ee905960ee476df6803632b0feb8@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241231115915.1082656-1-miriam.rachel.korenblit@intel.com>
References: <20241231115915.1082656-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

The firmware advertises the maximum number of links.
Use it.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/file.h |  1 +
 drivers/net/wireless/intel/iwlwifi/fw/img.h  |  3 ++-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 14 ++++++++++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index dce61869a7e3..9860903ecd3f 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -104,6 +104,7 @@ enum iwl_ucode_tlv_type {
 	IWL_UCODE_TLV_CURRENT_PC		= 68,
 
 	IWL_UCODE_TLV_FW_NUM_STATIONS		= IWL_UCODE_TLV_CONST_BASE + 0,
+	IWL_UCODE_TLV_FW_NUM_LINKS		= IWL_UCODE_TLV_CONST_BASE + 1,
 	IWL_UCODE_TLV_FW_NUM_BEACONS		= IWL_UCODE_TLV_CONST_BASE + 2,
 
 	IWL_UCODE_TLV_TYPE_DEBUG_INFO		= IWL_UCODE_TLV_DEBUG_BASE + 0,
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/img.h b/drivers/net/wireless/intel/iwlwifi/fw/img.h
index 96bda80632f3..f9de139561a0 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/img.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/img.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2018-2023 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2024 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016 Intel Deutschland GmbH
  */
@@ -51,6 +51,7 @@ struct iwl_ucode_capabilities {
 	u32 error_log_addr;
 	u32 error_log_size;
 	u32 num_stations;
+	u32 num_links;
 	u32 num_beacons;
 	unsigned long _api[BITS_TO_LONGS(NUM_IWL_UCODE_TLV_API)];
 	unsigned long _capa[BITS_TO_LONGS(NUM_IWL_UCODE_TLV_CAPA)];
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index fba9feee923d..57991c251cbf 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -22,6 +22,7 @@
 #include "iwl-modparams.h"
 #include "fw/api/alive.h"
 #include "fw/api/mac.h"
+#include "fw/api/mac-cfg.h"
 
 /******************************************************************************
  *
@@ -1197,6 +1198,19 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 			capa->num_stations =
 				le32_to_cpup((const __le32 *)tlv_data);
 			break;
+		case IWL_UCODE_TLV_FW_NUM_LINKS:
+			if (tlv_len != sizeof(u32))
+				goto invalid_tlv_len;
+			if (le32_to_cpup((const __le32 *)tlv_data) >
+			    IWL_FW_MAX_LINK_ID + 1) {
+				IWL_ERR(drv,
+					"%d is an invalid number of links\n",
+					le32_to_cpup((const __le32 *)tlv_data));
+				goto tlv_error;
+			}
+			capa->num_links =
+				le32_to_cpup((const __le32 *)tlv_data);
+			break;
 		case IWL_UCODE_TLV_FW_NUM_BEACONS:
 			if (tlv_len != sizeof(u32))
 				goto invalid_tlv_len;
-- 
2.34.1


