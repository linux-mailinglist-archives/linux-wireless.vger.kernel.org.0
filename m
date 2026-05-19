Return-Path: <linux-wireless+bounces-36636-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GAIIGcHDGqBUAUAu9opvQ
	(envelope-from <linux-wireless+bounces-36636-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 08:47:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC05D5784FE
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 08:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CF9D30A18EB
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 06:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2FD39B493;
	Tue, 19 May 2026 06:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="njA41dMo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A78839B4BB
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 06:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779172839; cv=none; b=As0Ga+S1Y/yS7yQrsAPQoIfqrDs6daRIfcF2/SQYIFpZ9ZuByu3UAdCFEUrvWdR+25fBwnjPoRFOkE4efM5cEkWF97HBXb7iNDsHlkuu4+ZdJK+Td3701Mfxkp16l336uH2YVp5rB8ZiyQGfqtWO/F2E94Pi5YjrY7O340AIJGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779172839; c=relaxed/simple;
	bh=HqDlWrFSEKtWltm9moMoK+V7kWjUQw8HT3W+a59fvUM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E8/RlwUFaMAqy6GMEPjRpRChfz7OdfPXYidCWAFdacZfOPzZaFgXEMGHYA3uKCbMwOtohl6A1Bw/PEaO5BFhnJjFOaUJIgsvEjgmpaIZhzhUu9GFwUVrlK+azwxLSuvwVk/o4+CO3nPADXVK6P9EMGk/r4bJhUXfCYJy0qR4et4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=njA41dMo; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779172838; x=1810708838;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HqDlWrFSEKtWltm9moMoK+V7kWjUQw8HT3W+a59fvUM=;
  b=njA41dMoBcl9AgCV3S7wRhbXJXclTa9dsk2hhClYUAGaqjNifhPGM2fn
   vo95C/+GH37BRmUb6UmuVcJ89Yi7RXx3YCu1c/zrjfB38STPwElX1FaQE
   nsYI/ZDRSDF5R04bNCNhQ3dmpbWnu72WaQ6IywsN/zB0RvaG5Od9fUE2U
   1BnrtQdUF32/zEzD/oCGbmT8sJTcHfUwJ7FEHe8fKIyhyW4y5dSYhn/kI
   lMq8POfUvn7KdGz3R6kOc1Zz9CCStGWWzwCWSIS0vfIHUsFIaNk1aDsZq
   kxWGXd/h1KgpvotjgFTXNAEDwe2xNp8LFgWkQQ77qoJ9MnvKIg9PKdw0W
   Q==;
X-CSE-ConnectionGUID: ZzhjDA1mSvW+LahywvcWrw==
X-CSE-MsgGUID: p5Ge1qPoRcm8lOazG/Jojw==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="82605667"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="82605667"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 23:40:37 -0700
X-CSE-ConnectionGUID: 3a+p9VnLSTGr4E4VDrfsrw==
X-CSE-MsgGUID: PvaCMtF4TluAtkeGlk5btw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="235227310"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 23:40:36 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v3 iwlwifi-next 10/15] wifi: iwlwifi: fw: move struct iwl_fw_ini_dump_entry to dbg.c
Date: Tue, 19 May 2026 09:40:05 +0300
Message-Id: <20260519064010.549003-11-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260519064010.549003-1-miriam.rachel.korenblit@intel.com>
References: <20260519064010.549003-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36636-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:email,intel.com:mid,intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CC05D5784FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

This is only used/needed in this file, so move it to clarify
that it's not part of any external API.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Link: https://patch.msgid.link/20260517100550.72b02319e812.I5cf95f64e3c3c688871bfabbe4fd7393b63a7dc8@changeid
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        | 14 +++++++++++++-
 drivers/net/wireless/intel/iwlwifi/fw/error-dump.h | 14 +-------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 0cffa5493704..4c41f042d6a0 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2005-2014, 2018-2025 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2026 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -2239,6 +2239,18 @@ struct iwl_dump_ini_mem_ops {
 			  void *range, u32 range_len, int idx);
 };
 
+/**
+ * struct iwl_fw_ini_dump_entry - dump entry descriptor
+ * @list: list of dump entries
+ * @size: size of the data
+ * @data: entry data
+ */
+struct iwl_fw_ini_dump_entry {
+	struct list_head list;
+	u32 size;
+	u8 data[];
+} __packed;
+
 /**
  * iwl_dump_ini_mem - dump memory region
  *
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
index 525a82030daa..07f1240df866 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2014, 2018-2025 Intel Corporation
+ * Copyright (C) 2014, 2018-2026 Intel Corporation
  * Copyright (C) 2014-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -265,18 +265,6 @@ struct iwl_fw_ini_error_dump_data {
 	__u8 data[];
 } __packed;
 
-/**
- * struct iwl_fw_ini_dump_entry - dump entry descriptor
- * @list: list of dump entries
- * @size: size of the data
- * @data: entry data
- */
-struct iwl_fw_ini_dump_entry {
-	struct list_head list;
-	u32 size;
-	u8 data[];
-} __packed;
-
 /**
  * struct iwl_fw_ini_dump_file_hdr - header of dump file
  * @barker: must be %IWL_FW_INI_ERROR_DUMP_BARKER
-- 
2.34.1


