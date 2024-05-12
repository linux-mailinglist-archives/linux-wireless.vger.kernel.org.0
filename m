Return-Path: <linux-wireless+bounces-7528-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC55D8C351A
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 06:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B924281E13
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 04:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF00EC2E9;
	Sun, 12 May 2024 04:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K2RvvymM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085D0BE6C
	for <linux-wireless@vger.kernel.org>; Sun, 12 May 2024 04:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715489946; cv=none; b=UN9hk2LjDNLHJz4Ychg5cYAX8ZxbnT/Mxxy4naz0l3rq/goxbElkKXvoyB5V0/LSnkdiU8qT/sV3WxdfKVr2x3bUObTBI37WPCTrZcPllALDOyF1PvQRvhJDdhtkUEEZhCukdv0XLN11eOdAobt7CTmX+xpdCf42NcgXbHb8tlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715489946; c=relaxed/simple;
	bh=lKu2QzwTHEfmelCnaUJPWqkXOpPDee2hQooz87hp6Ls=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nCj1KRyuB6UAPaOC8Q95nVfREWwGtGI6y6KKR+yzppqhF1IpIhZpkzUfdvVlBYd7GQjRGduSv7MDwbfVsxCiZRvOpFA02FqJE5chCim/4SuXYPCW75KCxUIxLVrpLSXkCcdvu9b8wkJSFBCIU078xjTC8bhrHR6xWfKry/uaG7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K2RvvymM; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715489945; x=1747025945;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lKu2QzwTHEfmelCnaUJPWqkXOpPDee2hQooz87hp6Ls=;
  b=K2RvvymMobXJFtpWylFE6Gvpds/xYsYEGs70FSrGSlcj6IN19UHKjTXJ
   Gc6gui0A3KRPeE/Y+eXru99KAXxf79yov1ImLvdJ3KAcuMSQALGIF5mtk
   TKGjs3anKvpeV4sD6QhBMvOdOdDdkGQH5wuVHETUxm+5NK+QDZ0gVDb1g
   OEW7+UqdxSj21D31psxAyRlSp7+ey3KSmApfolFI185HHlC1NKcwtgWxY
   56UOBg/JopX5258fkC4g2qspSeJdg27oqwtrJrYxOBfyIs1IinH8LoJnr
   bLw9rqJ0tum/9H+W+9BXGUrQyIfI28u7yeB8T6b+ofEIIFIw+HcbqugjK
   w==;
X-CSE-ConnectionGUID: 3UpxryD6SMSv9UpaHvmWKw==
X-CSE-MsgGUID: fZ34zGdFSHuHHSn//xtn3g==
X-IronPort-AV: E=McAfee;i="6600,9927,11070"; a="22843944"
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="22843944"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 21:59:04 -0700
X-CSE-ConnectionGUID: 3sDlXxtuQiy37m1DPEXaaA==
X-CSE-MsgGUID: plIHNvEHT3eThajPCr1iKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="30416695"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 21:59:03 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v2] wifi: iwlwifi: mvm: leave a print in the logs when we call fw_nmi()
Date: Sun, 12 May 2024 07:58:57 +0300
Message-Id: <20240512075822.e2558de222dc.Idd81777c47264e6f557b086625895c1dc2f667f3@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

When we crash the firmware, we need to know why we decided to do so.
Almost all the callsites of iwl_force_nmi() print something in the logs
that explain why the driver decided to crash the firmware.
Debugfs doesn't print anything and it is then hard to understand why the
firmware has crashed.
Add a simple print in the debugfs hook to ease the debug.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
v2: Removed the "Reviewed by" line
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 79f4ac8cbc72..96c9382b98fb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1396,6 +1396,8 @@ static ssize_t iwl_dbgfs_fw_nmi_write(struct iwl_mvm *mvm, char *buf,
 	if (!iwl_mvm_firmware_running(mvm))
 		return -EIO;
 
+	IWL_ERR(mvm, "Triggering an NMI from debugfs\n");
+
 	if (count == 6 && !strcmp(buf, "nolog\n"))
 		set_bit(IWL_MVM_STATUS_SUPPRESS_ERROR_LOG_ONCE, &mvm->status);
 
-- 
2.34.1


