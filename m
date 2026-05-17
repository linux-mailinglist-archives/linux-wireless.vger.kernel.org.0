Return-Path: <linux-wireless+bounces-36539-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GI0lHKJ1CWolbAQAu9opvQ
	(envelope-from <linux-wireless+bounces-36539-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 10:00:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA8155FD34
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 10:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9D9E63004D9A
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 08:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AE2B67E;
	Sun, 17 May 2026 08:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MDk9l2wW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCEC2798F3
	for <linux-wireless@vger.kernel.org>; Sun, 17 May 2026 08:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779004830; cv=none; b=EbcTmyCFY6+E+4mU6yRoDfbA15zJt7EXbn2YZeKHcJz9IaZATxUlTIsmotcaWeer0ZTqHu085yIPNQ2q/tNS/t+W3Feho9P3EoFFLLSNXZszpPrWzA7yCrdzvUcsNcDjCJzmX4YJiOhJ5e1x11C5HOoB+tSXCevWT3P373b4C6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779004830; c=relaxed/simple;
	bh=B8dCp6hQzxjakc4KdHlSUrdFsUAR0c+QItZ+sTKH8uU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bk7l7gK1aJtr5dlAtocv2dGzTS8b5UgrMl/WUOFxV/6hmcgVyrDCVJWH0h+CotgD+E6FWGjI6qbgChHXuGyWMIXZWa/SrxGuHk4ZhBLBO+BgKluBxPJ4vALx9uQhE3UlsjKG4ma+L6TGPzWE8NTi89PSpUhWSGaaYoUCQIabY2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MDk9l2wW; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779004828; x=1810540828;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=B8dCp6hQzxjakc4KdHlSUrdFsUAR0c+QItZ+sTKH8uU=;
  b=MDk9l2wWwZbo74q7hFR60FAQ2DS/0Zin12Xk4Y4bVXVpEQbWs39uufAd
   YZIFV5vy9V2L8JvMu9idK8pRzAip8jEsMgnXoFDCj0Tad5tCw4+HbwILv
   jIFEN8CAsValc1mujR7B5J27tTYGx1kPz3Svd9sFB1R3OgM8HEIOgFFpe
   Qwx2e3O750Ogy9XqnJBp75pqqglNfrMAmdQJnv3VfOjKjJ/XhrjJIdXte
   JWfQ7pjl/tShKSQBFKSICAomwRtUI9kYZEiQooxyKD2DiCFxnU+9ag7aV
   o6s7uXT2iPcgJ2Hkh4ZsdqpHNeFdskGtuRnzQoGc0cUpuT+X2jD0OJt9h
   Q==;
X-CSE-ConnectionGUID: eBe3kfycSzeQCxAnf/MOXA==
X-CSE-MsgGUID: 2Id6auNBQPisHw4sWCzAOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="79606954"
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="79606954"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 01:00:28 -0700
X-CSE-ConnectionGUID: ndYyC7AQReWsPh9tHNF4Kg==
X-CSE-MsgGUID: W/Ncd/nzQiCid/MdXSB1wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="236490391"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 01:00:28 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v2 iwlwifi-next 03/15] wifi: iwlwifi: bump maximum core version for BZ/SC/DR to 105
Date: Sun, 17 May 2026 10:59:47 +0300
Message-Id: <20260517100550.8674feeafcad.I3d3ae3a7acb976a947cd7e65a8d7fb8199d2e1ab@changeid>
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
X-Rspamd-Queue-Id: 7AA8155FD34
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36539-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.993];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
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


