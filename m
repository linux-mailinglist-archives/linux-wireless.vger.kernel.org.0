Return-Path: <linux-wireless+bounces-13677-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DA1993DFD
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 06:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 998CBB24BFA
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 04:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A007742ABE;
	Tue,  8 Oct 2024 04:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BmK8nvq9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2602513D250
	for <linux-wireless@vger.kernel.org>; Tue,  8 Oct 2024 04:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728361563; cv=none; b=nTSV/OEp7pmbnadegPyw/Zv/U+68cf05rUhaEuIEecAQbetZtZAAv7aU4YHvQFZWvbVTFtWsY9cYxxQmPgIJ4tIjYVeAn9Hsd1kMv55SgFHZSlcmB3vmzTvS6YWdKAp6jkhHOD3FhVOqCPWZ9nGOYHReaH+JXRmYaAgkNEtDmi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728361563; c=relaxed/simple;
	bh=hCthz/FiJPNZEQyMKckM/YWoUkInQkXA8bPKRkaUpko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CTgK5VCtAJa8HCIcFqWA+DvGb1pqeZMQTT12/DX2vxG9iM2cmSmUtxV4Pg1LkoEHd3vpyQEY83uE/GrIazac71Sr5BDlP3oUK3AaywNnB+LKhbsYvLkDWEEy4v+JzWxLmPeFPxspy6Og7+wLJZL4+YuHU9wXwWv+cw/4m6SFlKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BmK8nvq9; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728361562; x=1759897562;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hCthz/FiJPNZEQyMKckM/YWoUkInQkXA8bPKRkaUpko=;
  b=BmK8nvq9JHVvK840NW76z/AD2WpG1eAE7kkR5xc7lRnMw45pbtTpIeUD
   cLOASHZW6WSje5rqc6jxlPg+raOOuegmZRW7pg9KJwkE5N8TUnAVO12e4
   qvTVm/PvTWj0XPD5rIwBER1Cb5Hwto6Ki2l3v27Gwdf8hm/fZfAx4Bejn
   yd6ID8rS2D69qpG4F7yCld29xZvS4/Ic5ROgFR6DH2J7dgt3/6o75+23D
   QXowc0HkhaDFvcslF3Lt9UO+6l07eu9S7NBfUGVD1LOk2D0aLC6pp03o3
   q6kaxIEnDIxxriDgwP+0MT+uRp6Y2Xeo1Ew8WeUFRmzQ4GfHwCxaZ5XSQ
   A==;
X-CSE-ConnectionGUID: 1B5F2DF6S82Ux0FBO888Qg==
X-CSE-MsgGUID: TtWwogeMQ6mQrQ9TmPMkQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="27024316"
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="27024316"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 21:26:02 -0700
X-CSE-ConnectionGUID: Z9dcWhmUQHCRwZKc4vfYxg==
X-CSE-MsgGUID: ymw0nRCvTsakJKSfQAA4gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="80486424"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 21:26:01 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 14/14] wifi: iwlwifi: allow IWL_FW_CHECK() with just a string
Date: Tue,  8 Oct 2024 07:25:28 +0300
Message-Id: <20241008072037.96e8554cb7a2.I0e06d8fd49f86bd4e9e216fc2265c43d7e78a095@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008042528.2549752-1-miriam.rachel.korenblit@intel.com>
References: <20241008042528.2549752-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

We require a message, but the macros shouldn't require a
formatted message, a constant one can be fine. Change the
macros to support that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
index 9d8f89adc322..f4803b55adb9 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
@@ -331,15 +331,15 @@ bool iwl_fwrt_read_err_table(struct iwl_trans *trans, u32 base, u32 *err_id);
 void iwl_fw_disable_dbg_asserts(struct iwl_fw_runtime *fwrt);
 void iwl_fw_dbg_clear_monitor_buf(struct iwl_fw_runtime *fwrt);
 
-#define IWL_FW_CHECK_FAILED(_obj, _fmt, ...)				\
-	IWL_ERR_LIMIT(_obj, _fmt, __VA_ARGS__)
+#define IWL_FW_CHECK_FAILED(_obj, ...)					\
+	IWL_ERR_LIMIT(_obj, __VA_ARGS__)
 
 #define IWL_FW_CHECK(_obj, _cond, _fmt, ...)				\
 	({								\
 		bool __cond = (_cond);					\
 									\
 		if (unlikely(__cond))					\
-			IWL_FW_CHECK_FAILED(_obj, _fmt, __VA_ARGS__);	\
+			IWL_FW_CHECK_FAILED(_obj, _fmt, ##__VA_ARGS__);	\
 									\
 		unlikely(__cond);					\
 	})
-- 
2.34.1


