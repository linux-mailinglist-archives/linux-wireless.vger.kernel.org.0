Return-Path: <linux-wireless+bounces-26732-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2F5B396DA
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 10:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C0FA98077C
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 08:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F96B2E06EA;
	Thu, 28 Aug 2025 08:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="co36HT4R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE052DE1FA
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 08:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756369605; cv=none; b=J6l5ybC3OhCFC3ftrNvz4rgCENotvymlpuqPHuePufYGlXuMkdRoStFBYgQ84a8hNIm0glo1YHZ+b+eMIZ12W+kCC3UzaBhmX5sHbEkthfkpZlxfinuOV/P8JOyht6IbgfngBxP7Hx52kaMDVq16qPvJCEOugpkKwT6/g+dI3ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756369605; c=relaxed/simple;
	bh=QapgdBVWpR3ZOTMUk0RP+VP5ig3Oc3q+u87Y3FyA+HA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jO0ajxAviIANcpwTWQpOzXPbzo+5/JWJP3etzW9f2pYpno2DTOctrblVn7be5WdGTzEtYRAePJWeM/Ja9EIZrW+OG0XXlIbLcvGjcAsCmtvmpukwkqi12Jf89lUDgpzXsIzQDO3APbOD/QVQmvagbglop1h1I+v96dEfcHE8kZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=co36HT4R; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756369603; x=1787905603;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QapgdBVWpR3ZOTMUk0RP+VP5ig3Oc3q+u87Y3FyA+HA=;
  b=co36HT4RdxecoRwn4+yUuxU/8HOtmv1ZNg4UQI7RYkr2bk0shq7tvVgR
   Skqp9jtDkdTnhMqQRLLIxhO4PhHKAgwjGQUA6PfQgCGqm7rcB12uCZWPt
   lDiXeGnx635K1JYzrxGjqJokKLAIpilymXILm4MnfOq8qHbZ5zK/xxjSF
   B4QaGy4sSLQnznoeR4KexDalXrZGfMKBpnAhFqqFABWepFao+9f+N3y+D
   6ZvpqPGqKT1doHmHQsBD4G9O2I+LOwNADjtrCl+POsAWMCfi7gCYmItbK
   lTCw6O8++eYwSM9l8LjKDt2O1r9E/GLWN9y//FmDx47ZUmNYIrpLZfGGA
   w==;
X-CSE-ConnectionGUID: nLdf2sDRR7uKWCSe8+gXSw==
X-CSE-MsgGUID: q5YMxfutTRKguxjMluCyIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="70003325"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="70003325"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 01:26:34 -0700
X-CSE-ConnectionGUID: TSL1UASCQWuGt1BFZ//CkQ==
X-CSE-MsgGUID: xd9ym4SNQ4ST15tM59NPWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="170224483"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 01:26:33 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 02/15] wifi: iwlwifi: acpi: make iwl_guid static
Date: Thu, 28 Aug 2025 11:25:48 +0300
Message-Id: <20250828111032.83ec118cd1fb.I50c8e86fb786488f97e1ff2e115c4166c6b9bee1@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828082601.537908-1-miriam.rachel.korenblit@intel.com>
References: <20250828082601.537908-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This variable is now only used in the same file, so there's
no need to expose it. Make it static.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 6 +++---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h | 2 --
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index bee7d92293b8..0bfc7a40d5a6 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -9,9 +9,9 @@
 #include "acpi.h"
 #include "fw/runtime.h"
 
-const guid_t iwl_guid = GUID_INIT(0xF21202BF, 0x8F78, 0x4DC6,
-				  0xA5, 0xB3, 0x1F, 0x73,
-				  0x8E, 0x28, 0x5A, 0xDE);
+static const guid_t iwl_guid = GUID_INIT(0xF21202BF, 0x8F78, 0x4DC6,
+					 0xA5, 0xB3, 0x1F, 0x73,
+					 0x8E, 0x28, 0x5A, 0xDE);
 
 static const size_t acpi_dsm_size[DSM_FUNC_NUM_FUNCS] = {
 	[DSM_FUNC_QUERY] =			sizeof(u32),
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index 68d8fb5f6357..20bc6671f4eb 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -140,8 +140,6 @@ struct iwl_dsm_internal_product_reset_cmd {
 
 struct iwl_fw_runtime;
 
-extern const guid_t iwl_guid;
-
 union acpi_object *iwl_acpi_get_dsm_object(struct device *dev, int rev,
 					   int func, union acpi_object *args,
 					   const guid_t *guid);
-- 
2.34.1


