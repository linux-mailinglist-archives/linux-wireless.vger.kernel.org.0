Return-Path: <linux-wireless+bounces-9915-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 820A492579E
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 12:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BD311F27060
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 10:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACC014372E;
	Wed,  3 Jul 2024 09:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ck9G0m0n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA3013DDA3
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 09:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720000777; cv=none; b=qcG8VAqrSK5feYZWnt/hwNRaSBoUoEEpdkko2jWeYkGKcypgyrEFDl4WquqOg/YiMLN7neNF0WxqDwxUysAJ6bpvJwRXP4A/Wh6IcUJAoSFjj7+wLgn9gx2bumd0kHHlBIriVxMuS2JelG0LiP/8RlsbSenxDr5Hv9KcLKILzFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720000777; c=relaxed/simple;
	bh=Pt86XH9+qh0ajNN0zkt05P6bZ3aKofLa/zqNnn1/kC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XcQY6kxMbUG4fYGxwZcRQC4t+oyT7cD1B6a6SvplR2vV0JOZZb/pQCfqNbDhWqYyY8ScEWcS4UKanhalV//4DIrvGRNSROJhfBDvE/3pHqPoR0h43665s+DZwXaXeweYVqazoPGSEFoYo8aQusoYjHsEvhsZiUb6QSRGJOT2HRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ck9G0m0n; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720000776; x=1751536776;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Pt86XH9+qh0ajNN0zkt05P6bZ3aKofLa/zqNnn1/kC8=;
  b=ck9G0m0nf+quDN9duP/z7jjV+EnUbBUNroltvJbkDo8AXKUCl1KUzoM1
   qjx/248BZ8BTOxYBlyFrbVJ3+mFYKQuHH58ibf8XR2Xr3LN9w0rTwsJYN
   J0dH8mLU3m2Dm+2Cd3aYkrHp/frgA42cpcP+nDSxRVVR+VFdugFmmgwL1
   VWCi99272CKfbGoMswp01nTqTAcUMKoKLWIQI6R3fXwsR1ZX7rqnmxJQT
   9CD+MQCTKpuk+iDjVDFY+8q5lWtNgJAHyrouRgJ7rrAP/FplpFCY44gTJ
   ORWm87r2y+I5VDT1sEvFoDtiEVsRaVo/0kKSAkJO2K10eUS3VqehWZkmP
   Q==;
X-CSE-ConnectionGUID: 4+/jL3jeRpeBancWthtKxw==
X-CSE-MsgGUID: oq584hOUQa+P1rbhDxUzQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27837559"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="27837559"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 02:59:36 -0700
X-CSE-ConnectionGUID: J0+R3V8vQfeKkNu2R35fLQ==
X-CSE-MsgGUID: NIaWxKTfRrCsiMNIfG7jkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="45987850"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 02:59:34 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 14/18] wifi: iwlwifi: document PPAG table command union correctly
Date: Wed,  3 Jul 2024 12:59:02 +0300
Message-Id: <20240703125541.2ff5ee61e9ec.I3a1299061e472490c38a9fff4bea319ba20f313a@changeid>
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

This is not documented correctly, fix it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
index 19eb6008fe4b..6e6a92d173cc 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
@@ -569,9 +569,12 @@ enum iwl_ppag_flags {
  * @v2: version 2
  * version 3, 4, 5 and 6 are the same structure as v2,
  *	but has a different format of the flags bitmap
- * @flags: values from &enum iwl_ppag_flags
- * @gain: table of antenna gain values per chain and sub-band
- * @reserved: reserved
+ * @v1.flags: values from &enum iwl_ppag_flags
+ * @v1.gain: table of antenna gain values per chain and sub-band
+ * @v1.reserved: reserved
+ * @v2.flags: values from &enum iwl_ppag_flags
+ * @v2.gain: table of antenna gain values per chain and sub-band
+ * @v2.reserved: reserved
  */
 union iwl_ppag_table_cmd {
 	struct {
-- 
2.34.1


