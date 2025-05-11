Return-Path: <linux-wireless+bounces-22841-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 590B9AB29C5
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 18:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 156467A1A67
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 16:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D96225D534;
	Sun, 11 May 2025 16:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JZkT9ZWu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB9F25C82E
	for <linux-wireless@vger.kernel.org>; Sun, 11 May 2025 16:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746982421; cv=none; b=HzUD1IJsC+Pmyeb4qvmzO/BXiNleevgPDfR/SKSbkzIjMnt1iHSpkS7umwyKxW3sV36SPP6tzFOGOH/Sankg+wru1ENIiu5ahRgPXjyLIbQBl+2RlluO1uwrnDyczbbWl7KH5n5Sd5I2wXleyCJ2+7EaGOUgcJRFyzkB5pQLkWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746982421; c=relaxed/simple;
	bh=qHFGrl7XZEEfCZO7xvwpEKU6tO34G/s9ieoqgMINYKk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eRpO/M+r+0uMFtKPqclH51YFf4/2ne2hVEU11OTKuqr4Ep8Un9EQbKYZ4FIG9mFYro54KNMeQoGzFi+bocIIy4n+5DX766pwVSrwK+9+judWLcWzveaxjAlNjIsUbe1U6guK5zLU3LuaQuQ1hJ9TQ/Cj09XiXybwnnaTb0Z5ji0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JZkT9ZWu; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746982419; x=1778518419;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qHFGrl7XZEEfCZO7xvwpEKU6tO34G/s9ieoqgMINYKk=;
  b=JZkT9ZWuVqW6HB98WcEA1RM9gYF8zguELvBU6B8WvUCpBa3KEEDNRfgv
   vUNQmGNuOW8tqZRy2FlhaN6df6t5oDtqQrR3sJSqE7DMN6A7NtS9BWA1o
   mF1Cwg1x66ULw9awBg2lBv6NWTPG7iQiDIEAg9A+/DeqaFJKAiClZEK02
   t6WQGAya5NhQbeogFMSuk/0RmyOKdwKCAyjvdGyNr6T1IYdjwSkXs9Sf7
   AchfLvm1NVYGeiVF4salKQDc1lOd8MXNUN37fZKbQIA6aqcBXEq58VjU5
   RaAERKyB0bSiiBG2DfpfV3kq8MnVtfDjmSTkuM7kJTMS+dKW3iWlfcjHz
   g==;
X-CSE-ConnectionGUID: f0Gt70CUQ+WmfdmhCqkI5A==
X-CSE-MsgGUID: zWPYJbX9RESKbK9Sy9dsvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="52582681"
X-IronPort-AV: E=Sophos;i="6.15,280,1739865600"; 
   d="scan'208";a="52582681"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 09:53:38 -0700
X-CSE-ConnectionGUID: kuFh8kvYQqSZziHlWeXCeg==
X-CSE-MsgGUID: PGeGKa4/RIubyEpU95udJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,280,1739865600"; 
   d="scan'208";a="137655015"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 09:53:38 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH iwlwifi-next 02/15] wifi: iwlwifi: Add helper function to extract device ID
Date: Sun, 11 May 2025 19:53:08 +0300
Message-Id: <20250511195137.4411402701f2.I81cde20de05e3bb993977f8d4bbf90707819347f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250511165321.590808-1-miriam.rachel.korenblit@intel.com>
References: <20250511165321.590808-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Add iwl_trans_get_device_id() to extract the device ID
from the hw_id member in the iwl_trans structure.
hw_id member contains both sub-device ID and device ID,
with the device ID occupying bits 16 to 31.

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index d76caf5bf4c9..57a7747c92c4 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -832,6 +832,8 @@ struct iwl_txq {
  * @hw_crf_id: the device CRF ID
  * @hw_wfpm_id: the device wfpm ID
  * @hw_id: the ID of the device / sub-device
+ *	Bits 0:15 represent the sub-device ID
+ *	Bits 16:31 represent the device ID.
  * @pcie_link_speed: current PCIe link speed (%PCI_EXP_LNKSTA_CLS_*),
  *	only valid for discrete (not integrated) NICs
  * @num_rxqs: number of RX queues allocated by the transport
@@ -1263,4 +1265,9 @@ static inline void iwl_trans_set_info(struct iwl_trans *trans,
 	*write = *info;
 }
 
+static inline u16 iwl_trans_get_device_id(struct iwl_trans *trans)
+{
+	return u32_get_bits(trans->info.hw_id, GENMASK(31, 16));
+}
+
 #endif /* __iwl_trans_h__ */
-- 
2.34.1


