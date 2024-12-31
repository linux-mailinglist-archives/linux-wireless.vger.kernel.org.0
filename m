Return-Path: <linux-wireless+bounces-16943-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D14149FEF42
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2024 13:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D84F11883507
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2024 12:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E563199FA2;
	Tue, 31 Dec 2024 11:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FdD1+C1L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4942192590
	for <linux-wireless@vger.kernel.org>; Tue, 31 Dec 2024 11:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735646387; cv=none; b=kvqij4wouEX+Zwkhhducs3K6PrvIgSkTaHUWJRqn4qs/kNRhuTQdI62xI7F+uM1f7DmFhhHtvggsU/5XZ1pKpx1IusRKBs6J/IGnMLEGcoEiLgFIRpadjYS+duEz9enfJmeDKlXPZ7yLilCkZrJ6X3ZuwjrRlrjyYjfxld4CX0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735646387; c=relaxed/simple;
	bh=E/RdQUVon3MuSGQcguJ6PyRpuJ6x2CAmQoK5kz9YWaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BM82CSShwZ7XonGEW0fXgwma4Sdu9TXKHpyqQTkgDmkU6/Z3CuIoA7S++7lXSTYkoC1yofGZOG6HBDTO6bykc8VyPQhP57iT6nCCKIYu1G1V/bPRfjMHnLOoWNBw14Y8q/EB1373I6YaFA46FdfbsbTc2s2g1UYnN6BxtC07XPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FdD1+C1L; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735646386; x=1767182386;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E/RdQUVon3MuSGQcguJ6PyRpuJ6x2CAmQoK5kz9YWaA=;
  b=FdD1+C1LURZmiVX9q+IGX/Mae+OCo2YXw0CjDMD/R5QD82wAjEu2udxI
   AHQLfX26VmHMtEcEIe6Y7w5mEjNGedsBxwKqQBICEbE0QXSRd5UQGRTrq
   TurhYUes4Nlc5YqGDOUlpTaLXHIE+tkAZss+V0Jk0nKQcVVrLEql8V9AQ
   zf7s7oACynotm44OnIdEf/bzQMLVhMH5rtCKPsIEvubE3R7/OOhV7PAH5
   yIRewJzM9X/8AeByecMl1Hot871ZR1gMOyvD5dDaGGBpszN4esroAqfmH
   PD7i9Y96TU3qgP8N05sIbusNlDpgB5Ef19MxIi3CzAljmC/58OiRs5JBG
   w==;
X-CSE-ConnectionGUID: pwbAXCsgS3GEHoPa1Q3Uxw==
X-CSE-MsgGUID: 82W57VBdQpe0jC8SychWMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="53330193"
X-IronPort-AV: E=Sophos;i="6.12,279,1728975600"; 
   d="scan'208";a="53330193"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 03:59:46 -0800
X-CSE-ConnectionGUID: lfbCSjAtQ++LaXvsRFp4SQ==
X-CSE-MsgGUID: lmeRWipeSBmA1DHhKbOcrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="138380334"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 03:59:45 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH 11/15] wifi: iwlwifi: mvm: handle version 3 GET_TAS_STATUS notification
Date: Tue, 31 Dec 2024 13:59:11 +0200
Message-Id: <20241231135726.1d571ac80957.Ia48b1cf5585a2a9f9c461e80f5a0ba2bb16c3af4@changeid>
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

From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Add a check to ensure only version-3 of GET_TAS_STATUS notification
is allowed.

Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 6ec1cae5314a..f6f5117b93c0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -579,6 +579,10 @@ static ssize_t iwl_dbgfs_tas_get_status_read(struct file *file,
 	if (!iwl_mvm_firmware_running(mvm))
 		return -ENODEV;
 
+	if (iwl_fw_lookup_notif_ver(mvm->fw, DEBUG_GROUP, GET_TAS_STATUS,
+				    0) != 3)
+		return -EOPNOTSUPP;
+
 	mutex_lock(&mvm->mutex);
 	ret = iwl_mvm_send_cmd(mvm, &hcmd);
 	mutex_unlock(&mvm->mutex);
-- 
2.34.1


