Return-Path: <linux-wireless+bounces-36472-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJmMDMARB2rgrQIAu9opvQ
	(envelope-from <linux-wireless+bounces-36472-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 14:29:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF89C54F8F9
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 14:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89D20310ED99
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 12:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A9F47A0D1;
	Fri, 15 May 2026 12:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YMHxQgsh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043BC47CC8E
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 12:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778847014; cv=none; b=DQX2xfIpRJ3UVL/y/ZbAU9C9mBskaZGE/hmIZzwnmtqr7QFoZZ9i9pQHebPq5bEH4X5pQnvPrWQ3AjgXf7u7HFT7NDilBfqiEX98EcsySL8QrpgLExO8pGnryf2ftrhJdWF1qCr+fsfK9yRSh2OFrhVQnVA4u2fLrRMzqiog4Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778847014; c=relaxed/simple;
	bh=bWvp2Ypn7W/g2B1mV1cfnUfSrNWstCxapvrK5usjX3E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t10j7VuPX8GZC+eKKkumXhqjCRwhjFV5Fezqz0VEMdAQASMQsuS+9jGSD7tPMuAwk/AlW90zXs712rN49rwHngM44Xnd5n/HpY4q/+GjLOf1px//qKYGeNdFA2HQdXS7D3MoxRtac7HR7U3AZ1E89YI8JH/4bSsllcnXaFbA1Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YMHxQgsh; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778847013; x=1810383013;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bWvp2Ypn7W/g2B1mV1cfnUfSrNWstCxapvrK5usjX3E=;
  b=YMHxQgshMHeIrsVxdmfmrmMFOPlt/VZ5h9806DOf/OBZn+JHE2rp8C6Y
   XOqpapdLHI+hwAgot5c4FK4XXC8ReaU1+Rb50a2kB4ieCw6uJAfmWkw6A
   XWu1KmY05VmH07oGIljq+lBmm2lFTq7ZdTAeQzHc51WS5kgvClvXOaVky
   pnM1LkHAUNvbrFfhqgRYLBf1Crl7Z+BWVfRvhgV922RQno8QiyHmRRCgO
   XnLOapd8oLbVBploljrEvEilXJjlsFVAvLWIV93NuwYvlS8DPtkFp1JC5
   bQL/E8l7AuxTSwqX0vDcc0Qdlmz5GvECXhz47S0gsNtXjBFpMYIdc9Cqi
   g==;
X-CSE-ConnectionGUID: NlDyE6ICSPCkrmkTOO8NuQ==
X-CSE-MsgGUID: /Msw6sccSD6pB/r3/zBefA==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="91185678"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="91185678"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 05:10:12 -0700
X-CSE-ConnectionGUID: OFsl5py2QTC7GO2zIrM6jA==
X-CSE-MsgGUID: HbzdNmwJT/qKEehuqSbZPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="243650004"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 05:10:11 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Daniel Gabay <daniel.gabay@intel.com>
Subject: [PATCH v2 iwlwifi-next 07/15] wifi: iwlwifi: print UHR rate type
Date: Fri, 15 May 2026 15:09:40 +0300
Message-Id: <20260515150751.768874507c43.I3cffe81612cd0f2fc218ab26ae2aa3e9ba541a15@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260515120948.1157329-1-miriam.rachel.korenblit@intel.com>
References: <20260515120948.1157329-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BF89C54F8F9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36472-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Daniel Gabay <daniel.gabay@intel.com>

Log "UHR" in rs_pretty_print_rate() instead of "Unknown".

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/rs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/rs.c b/drivers/net/wireless/intel/iwlwifi/fw/rs.c
index 746f2acffb8f..2aa300b26158 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/rs.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2021-2022, 2025 Intel Corporation
+ * Copyright (C) 2021-2022, 2025-2026 Intel Corporation
  */
 
 #include <net/mac80211.h>
@@ -124,6 +124,9 @@ int rs_pretty_print_rate(char *buf, int bufsz, const u32 rate)
 	case RATE_MCS_MOD_TYPE_EHT:
 		type = "EHT";
 		break;
+	case RATE_MCS_MOD_TYPE_UHR:
+		type = "UHR";
+		break;
 	default:
 		type = "Unknown"; /* shouldn't happen */
 	}
-- 
2.34.1


