Return-Path: <linux-wireless+bounces-36521-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sN4pM6TPCGp+6QMAu9opvQ
	(envelope-from <linux-wireless+bounces-36521-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 22:12:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7191155DA11
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 22:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E5AE3017013
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 20:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545B835E1D9;
	Sat, 16 May 2026 20:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HfuchdoP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859F829A32D
	for <linux-wireless@vger.kernel.org>; Sat, 16 May 2026 20:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778962318; cv=none; b=d0k7+9saoM1nox3wSZpEIJoDY1ZTuYxMdR7G11aJnuHqF5rJuDNI8XfOHQApfYAKi9bma2nAPJOK2dXgqy4UZ4QvSreqtwsIyzb/OCOdZg+fhF0pqiWPML5NYR4+3kiB7kvKgCI5ocJan2Gm3nxCzigTxMLlSOv8HEPLUedHrkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778962318; c=relaxed/simple;
	bh=B8dCp6hQzxjakc4KdHlSUrdFsUAR0c+QItZ+sTKH8uU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qum6NWno/lTty92pieCnUhm++xzsJTvVarpm6PiRdC0L58EjOlUj11TBteLHTFkRIvQ/wXbwaJ/uCGFGWF/V3XbjtZXqdY2hC2H6gv/aqjzQWnp6McvQRIlIjTuJ+BIep7M5MWMxr+gTohXRJAQMbDBnfBs4U1MizxPrTdvBl8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HfuchdoP; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778962317; x=1810498317;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=B8dCp6hQzxjakc4KdHlSUrdFsUAR0c+QItZ+sTKH8uU=;
  b=HfuchdoPA+EikQtcQuyxDFbVy6mI29SNo6lLJOt1tBiayM8tLXXe4/Qo
   lkjbOdaqOKn0XfTyRlQgqNsZFaR0luKGeeoUzODjvc+o5cY4afJn88skW
   JNhUX+kjhRq1D17liq5M/vf23gGhgOVjiF7G2z/DNgj7gWlMelYcwJCr8
   jV5y3r7X7bJDKq98qBr83cCABqkUOY7nDVd0cLgr37vWu61YGTCcSiXGG
   f2XU7JpqhSaZeX8cBgKHyv5ojj0WxkEFTbt+gvyqlHm3sGC9+LiW7jYWk
   XSBzrmJ5yJIVDu4FTG57y2uLLBxBC1W3uUaWDfL6oj79cR7uuYtjdBLIc
   g==;
X-CSE-ConnectionGUID: l5pydWQXSPmS8p2Kjqa1jg==
X-CSE-MsgGUID: MVFlUuqETEC7tD4f35MZ8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="79845724"
X-IronPort-AV: E=Sophos;i="6.23,238,1770624000"; 
   d="scan'208";a="79845724"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2026 13:11:56 -0700
X-CSE-ConnectionGUID: Jid289TbTO+ESOfTiZrFqg==
X-CSE-MsgGUID: 2EHT80C0SYmhJy8z0NeAeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,238,1770624000"; 
   d="scan'208";a="239130866"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2026 13:11:56 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-fixes 03/15] wifi: iwlwifi: bump maximum core version for BZ/SC/DR to 105
Date: Sat, 16 May 2026 23:11:25 +0300
Message-Id: <20260516230843.8674feeafcad.I3d3ae3a7acb976a947cd7e65a8d7fb8199d2e1ab@changeid>
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
X-Rspamd-Queue-Id: 7191155DA11
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36521-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.993];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

Start supporting Core 105 FW on these devices.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index 51d7c599e998..ecb4f81a99f5 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware core release supported */
-#define IWL_BZ_UCODE_CORE_MAX	104
+#define IWL_BZ_UCODE_CORE_MAX	105
 
 /* Lowest firmware core release supported */
 #define IWL_BZ_UCODE_CORE_MIN	101
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
index 76fbc120a092..e8968b3051d3 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
@@ -9,7 +9,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware core release supported */
-#define IWL_DR_UCODE_CORE_MAX	104
+#define IWL_DR_UCODE_CORE_MAX	105
 
 /* Lowest firmware core release supported */
 #define IWL_DR_UCODE_CORE_MIN	101
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index db7858b2cb74..6aaa49aeec99 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware core release supported */
-#define IWL_SC_UCODE_CORE_MAX	104
+#define IWL_SC_UCODE_CORE_MAX	105
 
 /* Lowest firmware core release supported */
 #define IWL_SC_UCODE_CORE_MIN	101
-- 
2.34.1


