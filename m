Return-Path: <linux-wireless+bounces-36528-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6N7uMNLPCGp+6QMAu9opvQ
	(envelope-from <linux-wireless+bounces-36528-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 22:13:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3168455DA43
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 22:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E6D83027120
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 20:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398A335DA69;
	Sat, 16 May 2026 20:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lJe5Tqzw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E95E54654
	for <linux-wireless@vger.kernel.org>; Sat, 16 May 2026 20:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778962329; cv=none; b=I2NLPeKAv+lItWALL14+JG2kj2ytcJ68hy15mCkxitGRJXPFaCyUCqrNZwArbmYxeeJ0QWX3sSJgeMJ6xGGyi8xxfvOe43zJFoQSA3sHGWlTmfn3JLeBsZ5uiFYcWupAjqryYrmHT6wp9U3aALR24hgrNoTiaPhMTSTzGzq7rYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778962329; c=relaxed/simple;
	bh=ar/FOeTIIzNL2OpXTNC2RyogeJHdJUgm92hL/lg9fqc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k/7V7OOWJxME7Bc/IHsc4sxPKN2zj3L0KmEfhlcV4bOyARQRKZmc+MzGk0JdYbRSO0vPn5JRHM0p0fDJ2af1xo8c7cspkDcJtfrXN2JLAA1TV+HW0AC9His8/O6QQ5biFd3/p23Axmyor3tbdg1vCZJs4T7LXWu7+Z4zZgE0OaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lJe5Tqzw; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778962327; x=1810498327;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ar/FOeTIIzNL2OpXTNC2RyogeJHdJUgm92hL/lg9fqc=;
  b=lJe5Tqzw2HYDwmd3g8BJejPQ6bllMalti3tZIQVqBtdx06FYHUNuB35t
   GCKoq6w/sbbkdmM5ARA+pwLlV0+HcbTlrF5iltAcg8AQswXkR7pi2A8oH
   W4/WZYz8SWjFKJwR1Ku7GGteFKLLeHhg5eLz8r8yH5xQH3nwvoULL4g4Y
   LFImBgId8DonxJx36krb4vtTSRLCVAKMKXQcQMU8/Nb2t8baBS6KKzEjz
   TANzaS7kTJKD8pfR1KXge0FDPf698RgsPzRKMA9PTRJ0uj5mPyaekljYE
   A3CVoQ9kmh4x1GE0yjB9SYOSG/pbKPEh2RWnrwRItrQgqEogDHyFoqCbd
   Q==;
X-CSE-ConnectionGUID: H3ZAK3ZdQSOQd5kec8T8yw==
X-CSE-MsgGUID: K0hH7XwNTpSO1dxiAbRcxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="79845731"
X-IronPort-AV: E=Sophos;i="6.23,238,1770624000"; 
   d="scan'208";a="79845731"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2026 13:12:07 -0700
X-CSE-ConnectionGUID: axOjYHyNRg675R2ZGUFPPg==
X-CSE-MsgGUID: 86ajh4bcQ7esobz14/qZjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,238,1770624000"; 
   d="scan'208";a="239130918"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2026 13:12:06 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-fixes 10/15] wifi: iwlwifi: fw: move struct iwl_fw_ini_dump_entry to dbg.c
Date: Sat, 16 May 2026 23:11:32 +0300
Message-Id: <20260516230843.72b02319e812.I5cf95f64e3c3c688871bfabbe4fd7393b63a7dc8@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260516201137.2395464-1-miriam.rachel.korenblit@intel.com>
References: <20260516201137.2395464-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3168455DA43
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36528-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
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


