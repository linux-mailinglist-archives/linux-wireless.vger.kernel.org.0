Return-Path: <linux-wireless+bounces-36243-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Fb/BbsaAmofoAEAu9opvQ
	(envelope-from <linux-wireless+bounces-36243-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 20:06:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A00D951411A
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 20:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16C2A31D9E3F
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 17:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1752344CF2C;
	Mon, 11 May 2026 17:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CNLz4huV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF5E3B4E9A
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 17:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521012; cv=none; b=a/S8EpZcuVYBZ/fp8NnvvPT9TLUittnaBN2w98BXZLNslA3FpOIPgeGThbZuEZ/iNNF//r2b50ZZ6pvPtfWyLpVc6fBIUx1N+FRxYWVxcBXp4sH8QYe6KVJox6ot6YxS4mAkGG1EF2j/sLCV84+mrwA4nSQaYEnw79lcPQSqVxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521012; c=relaxed/simple;
	bh=lm7lVMasoCPZaWXUK3LyLFK0f61Vwso1DzcSb03Fh5A=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t0aH4ZInYpK8AaATqzPKl/Kd2dQTlNUPXUMnkPFqVUXPep2QBzxELJ4BAayV8RCb11Q+swui37JH5UHbHWDGR2qKoOWAzLj3/XLcfQ+KyKQrqflBqe7eVPX3YZPAxua0BjOMm+ocgbbtI0e9JqH/1JQuEXitzMI6kSfKzRLRk+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CNLz4huV; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778521011; x=1810057011;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=lm7lVMasoCPZaWXUK3LyLFK0f61Vwso1DzcSb03Fh5A=;
  b=CNLz4huVGnGw1tpbqhKrPbvC0YBL0GSdAsaege7LO4is3dXuftWUctvB
   og2bgr/Vo2stTHW9bWafF0YVyf7bYliW7MwBFHnaEXXmZ0v+r0IE3OHUD
   7lBEzqnZxE0g5/rmmZDy/Va+ZnwivOUyIN8FdEQEOGgbhXdsE7zywDhmH
   gn71nfabsnI9v3FbqpmDMu4fLBRQdExAw3ENz+oBl+sutfDVQOTzg7ZBu
   A1ExNbrhWSf1IYz4FUpc8zxosSvNw03govP58WNjAfA3rfoZxC4joBWPN
   8nDM3PHJw0Sbrv9uO4lxUAc0H8aQHaZGwvxcO7n5DIq+e5gWssvh2TO7L
   Q==;
X-CSE-ConnectionGUID: lS9e0uvVRC6cxc/Ry0GXVw==
X-CSE-MsgGUID: k+DMVYRRRRKZ8/IhfPVd5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79314768"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="79314768"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 10:36:50 -0700
X-CSE-ConnectionGUID: UbNYQegYRnCjXY6FY2lSjA==
X-CSE-MsgGUID: DPm1pM17QOOTbaToOxxitQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="261004464"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 10:36:47 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 02/15] wifi: iwlwifi: bump core version for BZ/SC/DR to 103
Date: Mon, 11 May 2026 20:36:18 +0300
Message-Id: <20260511203428.663b92bb5637.Iae934894dcdfc2e75e305584c57bcb8642804614@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511173631.1067831-1-miriam.rachel.korenblit@intel.com>
References: <20260511173631.1067831-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A00D951411A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36243-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Start supporting Core 103 FW on these devices.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index 3653ddbf3ce9..8b3f15899396 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware core release supported */
-#define IWL_BZ_UCODE_CORE_MAX	102
+#define IWL_BZ_UCODE_CORE_MAX	103
 
 /* Lowest firmware API version supported */
 #define IWL_BZ_UCODE_API_MIN	100
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
index 83d893b10f8e..a8f2ac688d31 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
@@ -9,7 +9,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware core release supported */
-#define IWL_DR_UCODE_CORE_MAX	102
+#define IWL_DR_UCODE_CORE_MAX	103
 
 /* Lowest firmware API version supported */
 #define IWL_DR_UCODE_API_MIN	100
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index 749d46dc0236..8e6efde3c64b 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware core release supported */
-#define IWL_SC_UCODE_CORE_MAX	102
+#define IWL_SC_UCODE_CORE_MAX	103
 
 /* Lowest firmware API version supported */
 #define IWL_SC_UCODE_API_MIN	100
-- 
2.34.1


