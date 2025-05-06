Return-Path: <linux-wireless+bounces-22690-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EFDAACE43
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 21:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB35F98395A
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 19:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA2620C46A;
	Tue,  6 May 2025 19:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nR0H5kjG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638E420CCC9
	for <linux-wireless@vger.kernel.org>; Tue,  6 May 2025 19:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746560499; cv=none; b=JhxFHiKP6vfDFpGRSu2spDRsTnOW+brBwg1UIpNW8g4khgthzW8W/aR3An7K4zyHoOf0DS4bnBqbEGqovpOEHwYaZbxWdna+vLqb2ufSdUju4aFdLtIwuDwg/aV1VAmIEQwExgUr2tIsopi6Y/xbyIp9pckUczrJDUgLKoi9l1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746560499; c=relaxed/simple;
	bh=unDIP3CLmiNMzGzSCF3PI3KG8mCc1O4ExfDD7z9FloQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HsRQCNjbnoznwR+wd0DSRq6pIQz6dwTwG3LfZb+N3Tdk/xnMPvQTbNAaanu/SD1OY4SQQpHvWlXv+OujqKdPvfJYsBJhnW2eINL4UUkeamcnbF/Ct8Ma04fP1ZvYRBptKWhaLvPiDiFb/rbdttfWm0pho16oDaY1aFYIJ4yeeBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nR0H5kjG; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746560499; x=1778096499;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=unDIP3CLmiNMzGzSCF3PI3KG8mCc1O4ExfDD7z9FloQ=;
  b=nR0H5kjGc82usyKQXelty89KKjvcgN4lrPH9Hdb98/mYTQvSFgUGZhR8
   K3OpFkXiP2LYE3XdoSYW//t0yYVX96Rkxg1odMRM4YMkWHX4ZR2eMnp4C
   OmeDHhl85eVj+bO9Bb3Z/PY+CY10317HOk6Ndw+n2aUNoZIuz+LjEtaAa
   TIs0sCt3YdxeikP1/3QnLiAze/d4cmJi967ukbO0/wDRB0c1HGTYoSzym
   m7G3oc1xupGumIyh0kLaPXRgt9S0el/AUMGeksr7+tsKMngIO+MIIAO3y
   ckS8V6EN6V5hHEqG7dYSZD8WnroEFtouO7zI8Q5Vwp1SJuRkuguCu1h78
   w==;
X-CSE-ConnectionGUID: 49YMOoqqS2G5T32PAf8f8g==
X-CSE-MsgGUID: vlSx77EdSVKkcsOfQdMrGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="47961684"
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="47961684"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 12:41:38 -0700
X-CSE-ConnectionGUID: wcedY9zWTjG3VUKWv9ltBw==
X-CSE-MsgGUID: ID145VFzTNSS8WwrwyJJBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="140465534"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 12:41:37 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 15/15] wifi: iwlwifi: add JF1/JF2 RF for dynamic FW building
Date: Tue,  6 May 2025 22:41:02 +0300
Message-Id: <20250506194102.3407967-16-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250506194102.3407967-1-miriam.rachel.korenblit@intel.com>
References: <20250506194102.3407967-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This is needed, otherwise we don't know what to do and will
not find the correct firmware.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Message-Id: <20250506223834.553254243af1.Ie1474166b505da2440fa9e34be412c18018540b0@changeid>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 6e0e03a59fdc..6cd520d50c98 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -240,6 +240,11 @@ const char *iwl_drv_get_fwname_pre(struct iwl_trans *trans, char *buf)
 	rf_step = iwl_drv_get_step(CSR_HW_RFID_STEP(trans->info.hw_rf_id));
 
 	switch (CSR_HW_RFID_TYPE(trans->info.hw_rf_id)) {
+	case IWL_CFG_RF_TYPE_JF1:
+	case IWL_CFG_RF_TYPE_JF2:
+		rf = "jf";
+		rf_step = 'b';
+		break;
 	case IWL_CFG_RF_TYPE_HR1:
 	case IWL_CFG_RF_TYPE_HR2:
 		rf = "hr";
-- 
2.34.1


