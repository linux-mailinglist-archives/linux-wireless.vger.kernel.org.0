Return-Path: <linux-wireless+bounces-20268-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B619A5E740
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 23:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 653A97A63D4
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 22:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186A91E2823;
	Wed, 12 Mar 2025 22:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XhwwjQ5+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F991F03DA
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 22:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818177; cv=none; b=DawTNE/x0+xuGU4L3CsdcMtpqaDRsm2gm0lZPMI9quCFv/n8Ul0+xJvuBtnSRrFcWwdgJ6TKsV/PetZV7PyJwduzc5H4VBhkyD343PbuhAsA/RmbtHdin5gSHk5GUxhGbY0laXCKxf01pfWSDeCpQ2GrPwcEQ5SdUaQywoRDFp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818177; c=relaxed/simple;
	bh=rMDRMC4hvfjJZcGrQFZH/FEnzdtO8LHq3OcTpCu81R8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sLhCeWvxu25/2eyAGWHaZbZaBqoBRahzs/XhZjxLPtD/emdHJkxdPu1qYR3IMZpsF2tlWlzgKCKsoexzR+TrSjxyj8YQI11JRvyzkgSNx6U9h/G344W8S2HIBHQcztVnzG0PXKIPl7iVIuJZBzMN/KAQiwLGryRrPQBuOCqTiL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XhwwjQ5+; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741818176; x=1773354176;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rMDRMC4hvfjJZcGrQFZH/FEnzdtO8LHq3OcTpCu81R8=;
  b=XhwwjQ5+nO/bEt0WkcLNw0eTc2h0DfiqmuTKRz4CTuBPcRZI88BNjZDn
   8IDZejEY3yGPxyVEHZVBg1AiioU+x+WgqMwp85K76KsEA0dbApuodcNUy
   aObpAAvmEUd/AyoDkYqgNViihoX+ru9DcjOMhWchy+j4HJDUMRgqV8YeN
   NeqsnU+ZsubDX6nAP8PkuaCW0D08YRG+tKiw9iJup8GNl++vHHfidg0l4
   JgEH1skcKJQDg1HtX03bE3JyVt9JylDXCfSYtA8xzIe6sNkStEHLDNB2W
   iRyM/I21EEr0WTUjhLSL7NdrDcva3L6pMVBbO29u0UoziRPCvhgAXr820
   g==;
X-CSE-ConnectionGUID: KQcKCsXrQRWuXjHxjeC4fw==
X-CSE-MsgGUID: YUTAGK0lRA+AUxBZh+jZVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42826738"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="42826738"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 15:22:56 -0700
X-CSE-ConnectionGUID: 9MEopoHGRqeHU/uMbumTrQ==
X-CSE-MsgGUID: /nBxuxclRVafBNUY1EbG5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="121267355"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 15:22:54 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH wireless-next 03/15] wifi: iwlwifi: mld: Ensure wiphy lock is held during debugfs read operations
Date: Thu, 13 Mar 2025 00:22:26 +0200
Message-Id: <20250313002008.2001d2335e9d.I607a8bd12efc6d1190cef1fca44279dbdd2756ea@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250312222238.2585340-1-miriam.rachel.korenblit@intel.com>
References: <20250312222238.2585340-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

The WIPHY_DEBUGFS_READ_WRITE_FILE_OPS_MLD macro is intended to call
read/write handlers with the wiphy lock held. However, the current
implementation uses the MLD_DEBUGFS_READ_WRAPPER macro, which does
not hold the wiphy lock during read operations. This fix updates
the WIPHY_DEBUGFS_READ_WRITE_FILE_OPS_MLD macro to use the
WIPHY_DEBUGFS_READ_WRAPPER_MLD macro instead, ensuring that the
wiphy lock is held during both read and write operations.

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/debugfs.c | 3 +--
 drivers/net/wireless/intel/iwlwifi/mld/debugfs.h | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
index 1d4b2ad5d388..c67dbbf575d7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
@@ -178,8 +178,7 @@ iwl_dbgfs_he_sniffer_params_write(struct iwl_mld *mld, char *buf,
 }
 
 static ssize_t
-iwl_dbgfs_he_sniffer_params_read(struct iwl_mld *mld, size_t count,
-				 char *buf)
+iwl_dbgfs_he_sniffer_params_read(struct iwl_mld *mld, char *buf, size_t count)
 {
 	return scnprintf(buf, count,
 			 "%d %02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx\n",
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.h b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.h
index 900aaed90775..eeba35342ba1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.h
@@ -204,10 +204,10 @@ static ssize_t __iwl_dbgfs_##name##_read(struct file *file,		\
 #define WIPHY_DEBUGFS_READ_WRITE_FILE_OPS_MLD(name, bufsz)		\
 	MLD_DEBUGFS_OPEN_WRAPPER(name, bufsz, struct iwl_mld)		\
 	WIPHY_DEBUGFS_WRITE_WRAPPER_MLD(name)				\
-	MLD_DEBUGFS_READ_WRAPPER(name)					\
+	WIPHY_DEBUGFS_READ_WRAPPER_MLD(name)				\
 	static const struct file_operations iwl_dbgfs_##name##_ops = {	\
 		.write = __iwl_dbgfs_##name##_write,			\
-		.read = _iwl_dbgfs_##name##_read,			\
+		.read = __iwl_dbgfs_##name##_read,			\
 		.open = _iwl_dbgfs_##name##_open,			\
 		.llseek = generic_file_llseek,				\
 		.release = _iwl_dbgfs_release,				\
-- 
2.34.1


