Return-Path: <linux-wireless+bounces-36427-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Hq1OkYmBmqmfgIAu9opvQ
	(envelope-from <linux-wireless+bounces-36427-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 21:45:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C34A54676F
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 21:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7D859301846A
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 19:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8393AE198;
	Thu, 14 May 2026 19:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F1XwLVpg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D193B6344
	for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 19:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778787900; cv=none; b=hTXngj1+MPqzrTlGqe5qwLubCnHftuzSx49saG7XttA92H9lnXcyq9QIREHVL0oZQfYm8hRYv16TC/mXC3lo2u53Jpx3OIsSt66f3rHkhvwDH5t9VJRytqyoKGufUa8OkCIN5/8I1dJtZ3n6YyZAMuwzmL1vlk3ppfLHNSR5Pvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778787900; c=relaxed/simple;
	bh=bWvp2Ypn7W/g2B1mV1cfnUfSrNWstCxapvrK5usjX3E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dyaeOZM7NuLcWGqgp5SGoDoShCQFKHnUS0vAQmHI47jwk37cTEjxHGybB/2GHzvYTu43CmUTN1PkjTRYQXO4/0wlD1TF+1s9zZ9Lk/mXwt8Zd+ldPZi/12xSE83dU/p0vOTELAnr2rkJe4Y0Gc8oWp3AAG8FDE8MQgWxma/EpnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F1XwLVpg; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778787900; x=1810323900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bWvp2Ypn7W/g2B1mV1cfnUfSrNWstCxapvrK5usjX3E=;
  b=F1XwLVpgjhxtAbU7UNMyUDdUunVZ8Rs5mnR2OS9+M6rAG7kuVoeZHCxe
   JQ8Vbj87Cs8XCkFpHSw3oCMDT1RNZhVJ+8fQhDvcJiwAmEwfi9CI7saoz
   QYfSpmgXPsSr2af1ss3dh5NGqPwWtXhhPiHyqSSsXkTlDzorEzFEfoQLS
   lHtQUvSWhM6BPMMIqe9R6GEm8L1SfptCunmd2eI+2owSCV+3nNVe8KqOP
   Eo/sR8TaNQ96PL0W+oWsh4PsHgezAuX9+GoOejeNTKQgF75pHb+wk7b9M
   dLDJl0ga5SlzRhf3RCmr3rvxNJl5F/WWLmc+fsV00Epu/VCBzvXjSYA1a
   A==;
X-CSE-ConnectionGUID: yo4PdycmQqKE4bVJ+8U7EA==
X-CSE-MsgGUID: sJRUQxaNSsCAHMoHJfVDfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="83352584"
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="83352584"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 12:45:00 -0700
X-CSE-ConnectionGUID: nyTi+owUQtaqxBHlRd5WyA==
X-CSE-MsgGUID: lBP/IUwuT3iDgiS952/3YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="237616280"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 12:44:58 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Daniel Gabay <daniel.gabay@intel.com>
Subject: [PATCH iwlwifi-next 07/15] wifi: iwlwifi: print UHR rate type
Date: Thu, 14 May 2026 22:44:26 +0300
Message-Id: <20260514224230.768874507c43.I3cffe81612cd0f2fc218ab26ae2aa3e9ba541a15@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260514194434.401241-1-miriam.rachel.korenblit@intel.com>
References: <20260514194434.401241-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2C34A54676F
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
	TAGGED_FROM(0.00)[bounces-36427-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
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


