Return-Path: <linux-wireless+bounces-23864-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D785BAD256F
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 20:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99B511891299
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 18:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFDD215766;
	Mon,  9 Jun 2025 18:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M1auHHCN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE76721CC71
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 18:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749493316; cv=none; b=JsksjqvEHOmeefUuahhIlePm0OiZ+iU2Ib1Bs/GD1leBPBnsExroQ4kAKLDuqkHQczhfaJdds+izSaArLFNrFF2aLltADlR5Mrt8PlPR50HJqxr9UdGdSGGhET2Gzekkm1GOsnj/R1b1RhkQE/yKx1mrBTfgQd93xSNTbDmvYNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749493316; c=relaxed/simple;
	bh=LOWI0PlxHRzqimUkDZzkH21UCUsdC6LKaNEQ2d2xx3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RV3xirXI8MBmsyy1Nw/E5nWZJzXIEeSYj42TB49ola60FaZhDU6JjiIrAtd6AbOG3/c0zIG/iXyUhzM35jdOExnFjZSh1nA0/czccLM+sYfbeLhyCFDhVUjATsY11MpBd7DYokNufTwrf7Bp6m317Nb8HGrwtHY8iVilxtxwCoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M1auHHCN; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749493314; x=1781029314;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LOWI0PlxHRzqimUkDZzkH21UCUsdC6LKaNEQ2d2xx3A=;
  b=M1auHHCNhfTxeXvR3vehXKdubcq6RHkWLXO151+4BP9jGAGO8/qt3yYv
   rgIy5AKrWCDYIB0W6uA1bCg0STB3pa867VWO6Va1RtZRydt+l4z79FD6j
   snUhGuEvOlA2ztJg/bFckVB6gFCtyT9f55RdwBHKh5HVos7WaY18k3Q/6
   beKd4iC0tq61o+3zkPvuGTAT4aCvO5NZa+B+60dVmAxN+G0EjKY0m8hVA
   vkI9GXV9vv5n3THN98C6kJxsCmJNVs3W28BOF9tjlcMcbuu3jhcNQByeK
   RKRgjB68K7wLePRD1aGCMDaT+/9I0pcFCaAP/ZNavfIh4/4K6BbKulTrX
   A==;
X-CSE-ConnectionGUID: LFmHy9F6TOWz5gQpm1wq9w==
X-CSE-MsgGUID: shNdbzjATNKXnWAinSzT8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="62237676"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="62237676"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:21:54 -0700
X-CSE-ConnectionGUID: t+RHXQF4R7GXr/JiJYKoFg==
X-CSE-MsgGUID: H5QnvXEhR5mINOU0XtPWvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="146510274"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:21:53 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 05/15] wifi: iwlwifi: move iwl-context-info header files
Date: Mon,  9 Jun 2025 21:21:11 +0300
Message-Id: <20250609211928.606f48f72bcd.I4b89d373d961146e5369d1aed9f625150de7bf7d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250609182121.3886519-1-miriam.rachel.korenblit@intel.com>
References: <20250609182121.3886519-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

context info is PCIE specific, so it should be located in pcie
directory. The c files are already there, move also the header files.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c                  | 2 +-
 .../net/wireless/intel/iwlwifi/{ => pcie}/iwl-context-info-v2.h | 0
 .../net/wireless/intel/iwlwifi/{ => pcie}/iwl-context-info.h    | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/net/wireless/intel/iwlwifi/{ => pcie}/iwl-context-info-v2.h (100%)
 rename drivers/net/wireless/intel/iwlwifi/{ => pcie}/iwl-context-info.h (100%)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index 8a40801cf0dd..221c3997ee87 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -15,7 +15,7 @@
 #include <linux/dmapool.h>
 #include "fw/api/commands.h"
 #include "pcie/internal.h"
-#include "iwl-context-info-v2.h"
+#include "pcie/iwl-context-info-v2.h"
 
 struct iwl_trans_dev_restart_data {
 	struct list_head list;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-v2.h b/drivers/net/wireless/intel/iwlwifi/pcie/iwl-context-info-v2.h
similarity index 100%
rename from drivers/net/wireless/intel/iwlwifi/iwl-context-info-v2.h
rename to drivers/net/wireless/intel/iwlwifi/pcie/iwl-context-info-v2.h
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-context-info.h b/drivers/net/wireless/intel/iwlwifi/pcie/iwl-context-info.h
similarity index 100%
rename from drivers/net/wireless/intel/iwlwifi/iwl-context-info.h
rename to drivers/net/wireless/intel/iwlwifi/pcie/iwl-context-info.h
-- 
2.34.1


