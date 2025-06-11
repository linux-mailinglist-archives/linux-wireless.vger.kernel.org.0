Return-Path: <linux-wireless+bounces-23965-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBDBAD496D
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 05:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F235169A77
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 03:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C43422171A;
	Wed, 11 Jun 2025 03:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JlZAhR3z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AE821E0AA
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 03:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749612883; cv=none; b=bUS3BFinrfHcIWIs9wPMyubi3vvqT8pt7IRToroUV1bliI0M00KWA3kEOnJs/6FB1YqW1/5D/1oI/NzLLOHD9uNnzOxsv0xZ0fVl7VH1akg6jHU8h7/fgPt7BpCTRTFW5UoSIrG9SmeFoOp+DJy/jZ5iokQhsmRC1iui41/aueY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749612883; c=relaxed/simple;
	bh=h/OcQtffMb6TcbuatTOWYtrnUNADKzrAmEMT9oiCllw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UpPctsTE0qlvWKOUE4nB3RyIGwBuZBESW/rmejKAvhz0U7qp3yHSkAExlzIAwfIFLpfGcQAKPsV3g8IjVAT0kVNk2Ia5IWwoZO/nyv2m4rArJbW4CwrnQu6ZL3QUXew+rmJugMWZ94FhWr+HMGCDQWTZ4zlGwh9Yj6LwTuyuiYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JlZAhR3z; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749612882; x=1781148882;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h/OcQtffMb6TcbuatTOWYtrnUNADKzrAmEMT9oiCllw=;
  b=JlZAhR3z+AuPUdvU3VselRc4aHnUA5lfyS5ivwByWaYsIwYqE9WUMetJ
   Q4eRiyDYxJ73KkA4HRdqS0kj5GR1C4FfSC/qZIjthOG5eKyNDWG/UzBwb
   LzIbdmoQgtelTbTy61TTrYnBLTTszbCtolw3sJSTv3aTF7YimHX8vHG+/
   CBBtW7Bb320F1KMJu9eqlmUMfIlxq73pOP1PXQ7rxaoWiyV55ornbyBxc
   +YXI4KNVG7tLNzdSRqr7Q8slM43l0uI07tAa5+kbvA45dTGGQQs0EDihm
   KDoe9ZlJgVvIjoXQG/25X+HoidRwlXkhscl5fKyAdtATGTY9IWdIIPtzV
   w==;
X-CSE-ConnectionGUID: aF1600aASg2+DrY7xFBb1w==
X-CSE-MsgGUID: zC3oQ9kBRfKKhevYSMNKeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="63094892"
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="63094892"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 20:34:42 -0700
X-CSE-ConnectionGUID: 1yG7y8JMRp6JPmTLNaPfWA==
X-CSE-MsgGUID: k9glgMXiRoCNqAOKtnUOIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="150880944"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 20:34:40 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 08/15] wifi: iwlwifi: mld: fix last_mlo_scan_time type
Date: Wed, 11 Jun 2025 06:34:08 +0300
Message-Id: <20250611063124.5381030253cd.I4e3a7bca5b52fc826e26311055286421508c4d1b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611033415.1175681-1-miriam.rachel.korenblit@intel.com>
References: <20250611033415.1175681-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This should be u64, otherwise it rolls over quickly on 32-bit
systems.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/scan.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/scan.h b/drivers/net/wireless/intel/iwlwifi/mld/scan.h
index 3ae940d55065..4044cac3f086 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/scan.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/scan.h
@@ -130,7 +130,7 @@ struct iwl_mld_scan {
 	void *cmd;
 	unsigned long last_6ghz_passive_jiffies;
 	unsigned long last_start_time_jiffies;
-	unsigned long last_mlo_scan_time;
+	u64 last_mlo_scan_time;
 };
 
 #endif /* __iwl_mld_scan_h__ */
-- 
2.34.1


