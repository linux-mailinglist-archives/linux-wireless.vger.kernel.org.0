Return-Path: <linux-wireless+bounces-36545-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JGIO611CWokbAQAu9opvQ
	(envelope-from <linux-wireless+bounces-36545-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 10:00:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B42E55FD42
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 10:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4F11B3003821
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 08:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE19C2F290B;
	Sun, 17 May 2026 08:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QHW/1JS0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697F2B67E
	for <linux-wireless@vger.kernel.org>; Sun, 17 May 2026 08:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779004839; cv=none; b=fbiARtEZGwRLWw5G/ds6v2S3TjjQpWOaViW6httWB7LCjR+s+HJRvQ1SHEtUaixrAMw7UWE0cz26HcHk/DWvwKat2UvFDqxH3FT5sTC5xfikmm6lnd5LsekE37Xr1z84hfghPAc+FlMgjnjUGTIqN9nwJ3vsnQihF5HTTkW5UHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779004839; c=relaxed/simple;
	bh=ar/FOeTIIzNL2OpXTNC2RyogeJHdJUgm92hL/lg9fqc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RxF/qansiORpPDPI2JNeqFN/GfKB+afQJ0m6rPwd1eDkFdG9feu0+6aYA6aBLX3Fqzc6KyAO286jMoVLQQB2z4S8enGwiwFaNyZQjKWWdQNyKdpE64kefsfLqgbA2vSd6XbTBwGWOvQ+klqDOcC+lezQGoaP78uM/Qp9c82WQB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QHW/1JS0; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779004838; x=1810540838;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ar/FOeTIIzNL2OpXTNC2RyogeJHdJUgm92hL/lg9fqc=;
  b=QHW/1JS02XWKzJGBoVNqGEI5V4qsqGkHXm8JJOX9xpYRMVT7BMfXs4MS
   kQ+1Iq7njmqz0VZLV1Eq5i0/Ll4PocusjuAer95Y9Vbx3cVOVt1V6p4TC
   eo/6UjHGFlHuak9G6KsO/U8kcYgI2tkIIfuV7iGOI2Vj00DPtlMZ1Rp2f
   hXjn1mbeCUR/ddYENKrMGLbZfPdLo3y/4vlJPAxXS3Z3doFQgNZFa88xm
   Piw74EPRhu5OEcXmZGnlpM61WyxUlTODCu/IMMe7FeUib7T/tt1sLR/qN
   rcdIRWc0Ec1jJFYPX5JEKUi4jL2O0I21ytGPiXtzA5+xqoapv/2u2AqtF
   Q==;
X-CSE-ConnectionGUID: 1THIinjiRCefNo/0SFBdAQ==
X-CSE-MsgGUID: n6kqHRsfTfuNz1/Ur7K/IQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="79606968"
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="79606968"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 01:00:38 -0700
X-CSE-ConnectionGUID: yDTpKsHySxmPLteyXnVMrw==
X-CSE-MsgGUID: jEOuLTfWRoOTGBhM54FsoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="236490485"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 01:00:37 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 iwlwifi-next 10/15] wifi: iwlwifi: fw: move struct iwl_fw_ini_dump_entry to dbg.c
Date: Sun, 17 May 2026 10:59:54 +0300
Message-Id: <20260517100550.72b02319e812.I5cf95f64e3c3c688871bfabbe4fd7393b63a7dc8@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260517075959.2815365-1-miriam.rachel.korenblit@intel.com>
References: <20260517075959.2815365-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1B42E55FD42
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36545-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

This is only used/needed in this file, so move it to clarify
that it's not part of any external API.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
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


