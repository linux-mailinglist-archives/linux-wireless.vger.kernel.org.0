Return-Path: <linux-wireless+bounces-7518-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E00348C3509
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 06:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37B581F21680
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 04:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FB817997;
	Sun, 12 May 2024 04:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hEXhveI7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E097917547
	for <linux-wireless@vger.kernel.org>; Sun, 12 May 2024 04:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715488296; cv=none; b=WJVGQIksv4rk1uqoVi/Gf/4s4rFteJjpQZXqDaIF/XUrc/vJLCa+udDlGqkMi1FyDVzHuM/WfJZz3qDrX5KHq8oJBmtCcWSoe/eLXwO5FsesGtzbYPOSo+GcuWxioEj1EkHAAdmBJEmWWPxaKVBPvzDNzM6RJGo7nJgicJsCwQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715488296; c=relaxed/simple;
	bh=GG4124oFwRtWcHDBAYcq+lbViWy1XHZ+XMMXvpeQxNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CYHx+7ZnygEbMRgEEFlS3N52mGyDESD2AYVWJuEYe0YQFNRBoJpxCVWMGnb8bbugILxUAcSyRdPn0OEuC1SmlsFjcNDVMBZzDx8zHMbnY+ZvJEkYEd80aS28fvRio+OEKvRlH9+jj5ToiWWQsqD/RuHXpB3HSgAO8HAeG1FsdOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hEXhveI7; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715488295; x=1747024295;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GG4124oFwRtWcHDBAYcq+lbViWy1XHZ+XMMXvpeQxNQ=;
  b=hEXhveI7QMv2VhYQ3qIC4oaf5z3pOmHJNh4qXBBJUVCAbRPcDldbxtna
   KdiChnZtTfPyPivjLmDs3uixyjsWfGXdZrNgyTctzVjrlH01FTZoewxyk
   Dh9jBEVEn+MMZN2mFOvbSX5S4dgsTO5pgS6wRYNUs2H4vYB0MvhTtWo3B
   Hw2R3541n9v9FSXZk3kNXEKhFahUnkuPlck/gnA18MStdKtLQNM4qtR8V
   Mn9+8lR5/jIdH+BxAcjKt6hD10VK/ZAz19ODwaoc4TidE26uW6t4gHC1m
   EaQ3MqZ3f6b+oVouShoa47MdbqL1wMUMgqMZmWgxBuEmbkF9tbYr4t+0f
   Q==;
X-CSE-ConnectionGUID: xWug79aJSqaH1oTBeN4+Zg==
X-CSE-MsgGUID: yyP3NsQlQU6fYWQ+KPylNg==
X-IronPort-AV: E=McAfee;i="6600,9927,11070"; a="11323848"
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="11323848"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 21:31:35 -0700
X-CSE-ConnectionGUID: nB0U7xXeS1StJsDoGxUh3w==
X-CSE-MsgGUID: 3KTQmFlUQJy3Yn9dy6p4hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="34532159"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 21:31:33 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
	Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH 07/16] wifi: iwlwifi: fw: api: Add new timepoint for scan failure
Date: Sun, 12 May 2024 07:31:01 +0300
Message-Id: <20240512072733.6781e76990c4.Iadfb3f6dd63a98fc35019772266b5ebddc5b5270@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240512043110.3413383-1-miriam.rachel.korenblit@intel.com>
References: <20240512043110.3413383-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

Add new time point to get the details of scan failure
While on it added other missing enum to match with FW.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Reviewed-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
index 47c914de2992..6cfe8a779cc7 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
@@ -470,6 +470,10 @@ enum iwl_fw_ini_region_device_memory_subtype {
  * @IWL_FW_INI_TIME_POINT_EAPOL_FAILED: EAPOL failed
  * @IWL_FW_INI_TIME_POINT_FAKE_TX: fake Tx
  * @IWL_FW_INI_TIME_POINT_DEASSOC: de association
+ * @IWL_FW_INI_TIME_POINT_PRESET_OVERRIDE_EXT_REQ: request to override preset
+ * @IWL_FW_INI_TIME_POINT_PRESET_OVERRIDE_START: start handling override preset
+ *	request
+ * @IWL_FW_INI_TIME_SCAN_FAILURE: failed scan channel list
  * @IWL_FW_INI_TIME_POINT_NUM: number of time points
  */
 enum iwl_fw_ini_time_point {
@@ -500,6 +504,9 @@ enum iwl_fw_ini_time_point {
 	IWL_FW_INI_TIME_POINT_EAPOL_FAILED,
 	IWL_FW_INI_TIME_POINT_FAKE_TX,
 	IWL_FW_INI_TIME_POINT_DEASSOC,
+	IWL_FW_INI_TIME_POINT_PRESET_OVERRIDE_EXT_REQ,
+	IWL_FW_INI_TIME_POINT_PRESET_OVERRIDE_START,
+	IWL_FW_INI_TIME_SCAN_FAILURE,
 	IWL_FW_INI_TIME_POINT_NUM,
 }; /* FW_TLV_DEBUG_TIME_POINT_API_E */
 
-- 
2.34.1


