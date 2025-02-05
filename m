Return-Path: <linux-wireless+bounces-18530-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 064A9A28B01
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 13:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0673B18814D5
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 12:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4348C11;
	Wed,  5 Feb 2025 12:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eH6lNpxC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDB0CA4E
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 12:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738760188; cv=none; b=S7KRL0UOwYTnYHMEtmIVSE4x1FyCj7hNM4bLVOaj7BfJFbINSTu4Sg3lN2Zu94cS5IpOL3nKuwhjEfdrGfvvVS3RhKH/qbCWR5iiYnG7nA0UltcF2xpZfalrB8Y71yXutuYDTBf163EPyMaeaRR/Z1KRGXhIL8w82lLqcO4OVCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738760188; c=relaxed/simple;
	bh=cqursYMHiw+c+vCSVH2IcdM4xl5QDS20lsKZKSaVyoY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZgzAsLit45RQZLaBj+Nj6CsPPI9EnNugghVA991BDguOH0sWqH8K6NnJU10j6HYNQeeXBh+B+LVjQRoePShr7QBSsQalrKWjQnSEVarokDEP4jbxrKGqMvmMpnQQImA1D5DFPVBTm3j9Y0afmDN4R2rK0GtWKNO7ilU5W/a8/08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eH6lNpxC; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738760184; x=1770296184;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cqursYMHiw+c+vCSVH2IcdM4xl5QDS20lsKZKSaVyoY=;
  b=eH6lNpxCt139d/fturHZXC2MKmZdRyr4ZH6FoNgdvJH8EwEHZkhT4LUG
   OvxyfZbucGsCBn/5e/u6pTtTwhlxLeis0nzDPM0jspNiYFmGNAhmzzVWw
   aOcNND0MUxYbZ8cPblsiTXKYaof0x7hfzFetrE9Vl4aj+hh81rMx5pJaH
   OQ5EfY8NJ6VXI3vDMZF6vx97VjOajm0drG4qN/ZSHLFzDZLqONp6x8xg/
   rw702LixvE71EQo00ueoIOhJL5gjXkwUuF5iQ3moCpvoFUPMxODbh9dP+
   bBZNN8DgNltBp/E68CGkfFeV+HTcfxvl7fI3WhH9PY2f9lqRh6QIk+gyw
   w==;
X-CSE-ConnectionGUID: YkVe2PrYRfymHovBff8/cQ==
X-CSE-MsgGUID: YyYO+PCYQnyVDfPtdJxxkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="42159205"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="42159205"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 04:56:23 -0800
X-CSE-ConnectionGUID: DqGa18X7TUmSmmAnxDbI8g==
X-CSE-MsgGUID: RKlnJ71JT/+LP+BEwhTbFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110745480"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 04:56:22 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 11/19] wifi: iwlwifi: fw: make iwl_send_dbg_dump_complete_cmd() static
Date: Wed,  5 Feb 2025 14:55:40 +0200
Message-Id: <20250205145347.319b66c00676.I3c06d6c2ee5850a5a89feff7d770e557fd625a6d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205125548.1963070-1-miriam.rachel.korenblit@intel.com>
References: <20250205125548.1963070-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

It's only used in the same file, so can be static.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 5 ++---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h | 3 ---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index fb2ea38e89ac..10bde19e9dca 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -3042,9 +3042,8 @@ int iwl_fw_start_dbg_conf(struct iwl_fw_runtime *fwrt, u8 conf_id)
 }
 IWL_EXPORT_SYMBOL(iwl_fw_start_dbg_conf);
 
-void iwl_send_dbg_dump_complete_cmd(struct iwl_fw_runtime *fwrt,
-				    u32 timepoint,
-				    u32 timepoint_data)
+static void iwl_send_dbg_dump_complete_cmd(struct iwl_fw_runtime *fwrt,
+					   u32 timepoint, u32 timepoint_data)
 {
 	struct iwl_dbg_dump_complete_cmd hcmd_data;
 	struct iwl_host_cmd hcmd = {
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
index 87998374f459..35e30e5db462 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
@@ -324,9 +324,6 @@ static inline void iwl_fwrt_update_fw_versions(struct iwl_fw_runtime *fwrt,
 }
 
 void iwl_fwrt_dump_error_logs(struct iwl_fw_runtime *fwrt);
-void iwl_send_dbg_dump_complete_cmd(struct iwl_fw_runtime *fwrt,
-				    u32 timepoint,
-				    u32 timepoint_data);
 bool iwl_fwrt_read_err_table(struct iwl_trans *trans, u32 base, u32 *err_id);
 void iwl_fw_disable_dbg_asserts(struct iwl_fw_runtime *fwrt);
 void iwl_fw_dbg_clear_monitor_buf(struct iwl_fw_runtime *fwrt);
-- 
2.34.1


