Return-Path: <linux-wireless+bounces-18809-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63314A31E1B
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 06:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8298188B755
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 05:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5071F8AC8;
	Wed, 12 Feb 2025 05:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LtnpYI2A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67567271837
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 05:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739339035; cv=none; b=rKrW42UKvQuatOhUc/y2Rt2Rbg0tyMB4YyWDW9bV4HKOSBvrVpz+Lk7ceKe0Sr3l0ws7g8mjf1kAdU5/eiutpDTw/MI2lY3GbOET5AYma0etReFNWYekJpoMS9WwfKfKm6mx1vxdai+YihKdDFkFRVYUFvyjGJMwzTFCNSl5QP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739339035; c=relaxed/simple;
	bh=edcEgtr+n9+aT60+Rms5SKSYyPL+yGPQxKQtc0eynqo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Je/f5E6NWggXzlYLwyjX44IMLDUIIjUC64XQyGZq084MB69YDw2eNJAo5ED1ZLj5Xi6blvUJhS/wIN8YVqzdqSHDKK7vlM0FtGsMvpn2tooWu20OKpGRbF6Iy7Rl6q36mukRVzgVpKao0s+E3gxg6IPbxbk9hCOX9DFDrvpDJQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LtnpYI2A; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739339034; x=1770875034;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=edcEgtr+n9+aT60+Rms5SKSYyPL+yGPQxKQtc0eynqo=;
  b=LtnpYI2AhyTInZn3bELZnImJCS0aAUYsujspyrgSHRoYPAxnboi9z6uZ
   Uu+3MbsjUkdbRZQE/ZM0SwoTgygq5RtLHr6h4ej5K5loa80DUZqrFhwFt
   mXe9nVHrCmA0ioaiTy/KjeysKmsqkwxg0Dx4QVSGUm72+RQQpoPbvONwF
   wy4cSMaSxfvXQUlL5F2RdZYiohCODfJHEPE+jlrnffJnDOqPoaDJxKSUZ
   ocQJ6W/VlYUfq488PxFXCy6BlQUxdtsztNNTiBOzK8xTcZ+B6sFYW7BjX
   LJCX3V8iI3VHR8Paa+jrE2G/4WVcqU/1EsFKkfR6q64uRnWOyW0myeRSf
   Q==;
X-CSE-ConnectionGUID: oFcC4LlxSmudYvsJczc0Xg==
X-CSE-MsgGUID: JNq8qbhaQ922ujgaIQln5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39172213"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="39172213"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 21:43:53 -0800
X-CSE-ConnectionGUID: p4BycsY3Qk6vJFkiTs+3OA==
X-CSE-MsgGUID: cLpbRcfLRXeWbWQNT0ludA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117893848"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 21:43:52 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 04/12] wifi: iwlwifi: mld: add a debug level for PTP prints
Date: Wed, 12 Feb 2025 07:43:25 +0200
Message-Id: <20250212073923.866f8f66b1d7.I764abcb845d992d058c753ce8fa9d45fed2ff4ec@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212054333.376219-1-miriam.rachel.korenblit@intel.com>
References: <20250212054333.376219-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This is required for PTP related debug prints.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-debug.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-debug.h b/drivers/net/wireless/intel/iwlwifi/iwl-debug.h
index bf52c2edaad1..5377dda9ad53 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-debug.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-debug.h
@@ -2,7 +2,7 @@
 /******************************************************************************
  *
  * Copyright(c) 2003 - 2014 Intel Corporation. All rights reserved.
- * Copyright(c) 2018 - 2021, 2024 Intel Corporation
+ * Copyright(c) 2018 - 2021, 2024-2025 Intel Corporation
  *
  * Portions of this file are derived from the ipw3945 project.
  *****************************************************************************/
@@ -156,6 +156,7 @@ do {                                            			\
 #define IWL_DL_FW		0x00010000
 #define IWL_DL_RF_KILL		0x00020000
 #define IWL_DL_TPT		0x00040000
+#define IWL_DL_PTP		0x00080000
 /* 0x00F00000 - 0x00100000 */
 #define IWL_DL_RATE		0x00100000
 #define IWL_DL_CALIB		0x00200000
@@ -216,5 +217,6 @@ do {                                            			\
 #define IWL_DEBUG_LAR(p, f, a...)	IWL_DEBUG(p, IWL_DL_LAR, f, ## a)
 #define IWL_DEBUG_FW_INFO(p, f, a...)		\
 		IWL_DEBUG(p, IWL_DL_INFO | IWL_DL_FW, f, ## a)
+#define IWL_DEBUG_PTP(p, f, a...)	IWL_DEBUG(p, IWL_DL_PTP, f, ## a)
 
 #endif
-- 
2.34.1


