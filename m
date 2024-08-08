Return-Path: <linux-wireless+bounces-11148-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC2094C5A9
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 22:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05B2B1F20F54
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 20:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA2015920E;
	Thu,  8 Aug 2024 20:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ezOZ+DQi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70C315920B
	for <linux-wireless@vger.kernel.org>; Thu,  8 Aug 2024 20:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723148604; cv=none; b=M2dxe18E15jcHjAAZgeTxez/MFYsbOK8qM/ESMPBG6nuOqPwjmqNv8t/DC8vTtMj5odyHRdyUAkMRfjRocvE86JYNxisl9ZoTaRU0uTMq5+Re4VMfNCCvxddvaCz9FaAlhtuHLcXh80hFPqPBOQ36fYiBYEtQwM4CVjY168TZRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723148604; c=relaxed/simple;
	bh=KvK2ziTuGp6TKxSMfgRLa6728jWxTlfxjaDtJq9o80M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bPsAsU4TXgo688jFbeyV4CcLzy36NtmQzMK41aXIm/cebTHpxMLN8d6USNpajdC+7Oav2dBmhTPj6TTPU68IR2U7/E+GXjXf/FodsFT0imv3PT3TkM/boeWHvdC5GMrLz2JFvUPIg4gJBmKu7gV4WgVejf+KMYcePFlXNxbltLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ezOZ+DQi; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723148603; x=1754684603;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KvK2ziTuGp6TKxSMfgRLa6728jWxTlfxjaDtJq9o80M=;
  b=ezOZ+DQi2Ju6QyH6Bpldrx5g6SRGCgvUGptJfZMVu3WVh70CWKf2dGek
   Ikq5E3yTerL6FWpmvJdMFyDMV34SOGvgjC020yv8tdO5J77AaavExT1y2
   6NVWdyZ5L87G0ybq54KAWRaJMGmAnbXoIWbtqMPi/hUD/9/7Xl+8UlBlp
   nrxc3302OL78iaV6bJVK1O28/SABVRLwLCBx1FsJH+fYmzCTcj5pxiBPB
   DSa8B/2rUVvf3LyUgSxi+H7HadEZ467udUYWcfCEFV17tUkPup+R5hBLg
   yoWncchbuYVFElcuGwBJeiHLz4TtGAA4ebHSca81Sws3MXUHRelt1bO9z
   Q==;
X-CSE-ConnectionGUID: 5zANVtkfSmy1ES1veq4FTw==
X-CSE-MsgGUID: x2uxP6LJSlOjAay5/VBW+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="38808871"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="38808871"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 13:23:21 -0700
X-CSE-ConnectionGUID: 6gO9CQ/KRu+BKodCmpsMFg==
X-CSE-MsgGUID: JGZc05HFSwegwfrZjK3k0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="57305354"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 13:23:19 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH 13/13] wifi: iwlwifi: allow only CN mcc from WRDD
Date: Thu,  8 Aug 2024 23:22:49 +0300
Message-Id: <20240808232017.fe6ea7aa4b39.I86004687a2963fe26f990770aca103e2f5cb1628@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240808202249.4004087-1-miriam.rachel.korenblit@intel.com>
References: <20240808202249.4004087-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Block other mcc expect CN from WRDD ACPI.

Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c       | 5 +++++
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.h | 2 ++
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c       | 2 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h       | 2 --
 4 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 79774c8c7ff4..d20cd49773c9 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -357,6 +357,11 @@ int iwl_acpi_get_mcc(struct iwl_fw_runtime *fwrt, char *mcc)
 	}
 
 	mcc_val = wifi_pkg->package.elements[1].integer.value;
+	if (mcc_val != BIOS_MCC_CHINA) {
+		ret = -EINVAL;
+		IWL_DEBUG_RADIO(fwrt, "ACPI WRDD is supported only for CN\n");
+		goto out_free;
+	}
 
 	mcc[0] = (mcc_val >> 8) & 0xff;
 	mcc[1] = mcc_val & 0xff;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
index c2209948b4c0..81787501d4a4 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
@@ -45,6 +45,8 @@
 #define IWL_WTAS_ENABLE_IEC_MSK	0x4
 #define IWL_WTAS_USA_UHB_MSK		BIT(16)
 
+#define BIOS_MCC_CHINA 0x434e
+
 /*
  * The profile for revision 2 is a superset of revision 1, which is in
  * turn a superset of revision 0.  So we can store all revisions
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index 754fc5014fbf..091fb6fd7c78 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -638,7 +638,7 @@ int iwl_uefi_get_mcc(struct iwl_fw_runtime *fwrt, char *mcc)
 		goto out;
 	}
 
-	if (data->mcc != UEFI_MCC_CHINA) {
+	if (data->mcc != BIOS_MCC_CHINA) {
 		ret = -EINVAL;
 		IWL_DEBUG_RADIO(fwrt, "UEFI WRDD is supported only for CN\n");
 		goto out;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
index 0b2477190070..e525d449e656 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
@@ -151,8 +151,6 @@ struct uefi_cnv_var_splc {
 	u32 default_pwr_limit;
 } __packed;
 
-#define UEFI_MCC_CHINA 0x434e
-
 /* struct uefi_cnv_var_wrdd - WRDD table as defined in UEFI
  * @revision: the revision of the table
  * @mcc: country identifier as defined in ISO/IEC 3166-1 Alpha 2 code
-- 
2.34.1


