Return-Path: <linux-wireless+bounces-37206-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YC6sLm0THGraJQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37206-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 12:54:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E094615AC8
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 12:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69ECB3051D07
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 10:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E468F376BC6;
	Sun, 31 May 2026 10:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fS8bjOFn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2081376A1B
	for <linux-wireless@vger.kernel.org>; Sun, 31 May 2026 10:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780224816; cv=none; b=e5q/bowqirrnf66VEZvQ4P81WTRKyZO2OVGsV3yhdS1KPwVhi3OEUVEpbGkhIq1e7yu3CYrjpNdNAareMyTZZaV9QDMLb4qqK9KmpGgTW/ZLDFz1oH3ES0IIUX4AUslAZLpYg1wTaGeBM7HgftnZGAGpE1A5hsHvHSQ9hwy2SQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780224816; c=relaxed/simple;
	bh=folZhDyNpdwCjrRBQqdqJJd4fem7+hl05Bm5hw0/xE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U8x4k+bIQLLgB9ZfppoEOASt/l5+O52Qj7l6fVz6iLoYh9SEk6x+cDq3aH+t9s0c4Jz04/cseniC2mRoQ0u33dKQ/cJH6fY21pZHmzESDNlraYszCBZw2wDMdAo6bekG06EluElywFIPUr+Re5Xqtrhhb1w6KanyUUE7axMJjcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fS8bjOFn; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780224816; x=1811760816;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=folZhDyNpdwCjrRBQqdqJJd4fem7+hl05Bm5hw0/xE8=;
  b=fS8bjOFn4INhLxvvjJ2L0o3O1EDmo1GD1N0pshHzvZyCU/P+ehMaM6Yp
   OV39nfYb7UJ4D84+MhpnkwKQ+GkyAPikXFshpVvs7V76sOoulq+L1aDCU
   FIjMq7BryRVF91dS3rOVydTht/9bAbi3Digi2baSsJHVQzZjhidXN43/D
   7HgjyzFUjjcjL8eFqxdp0g3anOe734+ViTce6lUO/TBVjIM6U2GEgw0XH
   Y4w/Fpng7b1Ib3/C+RwoLbnrdsqofybe2zRPtk+FOT24i/hUBRXdmkHkY
   sgcGqQu/6n+e4UdBhlweg53iKJ5PkORdmKuYfkUf3y0noW/7gdu7awxP1
   w==;
X-CSE-ConnectionGUID: 8HExMJmvRrOMyWSP9c7J/A==
X-CSE-MsgGUID: 8hgikJuLS0us6oHyPMuvkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11802"; a="80039671"
X-IronPort-AV: E=Sophos;i="6.24,179,1774335600"; 
   d="scan'208";a="80039671"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 03:53:35 -0700
X-CSE-ConnectionGUID: MgUYvWSSShy0JScngHdlfw==
X-CSE-MsgGUID: MDX57tSbRnuM5jzoh9WQOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,179,1774335600"; 
   d="scan'208";a="240296020"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 03:53:34 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH wireless-next 10/10] wifi: iwlwifi: bump maximum core version for BZ/SC/DR to 106
Date: Sun, 31 May 2026 13:53:09 +0300
Message-Id: <20260531135036.4ec96e57a17b.I1eea0a221656b2f03839964734d9a3624530b964@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260531105309.125363-1-miriam.rachel.korenblit@intel.com>
References: <20260531105309.125363-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-37206-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5E094615AC8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Start supporting Core 106 FW on these devices.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index 1542cbc3bb22..606362463dc7 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware core release supported */
-#define IWL_BZ_UCODE_CORE_MAX	105
+#define IWL_BZ_UCODE_CORE_MAX	106
 
 /* Lowest firmware core release supported */
 #define IWL_BZ_UCODE_CORE_MIN	102
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
index 6a5870619411..946975294b4f 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
@@ -9,7 +9,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware core release supported */
-#define IWL_DR_UCODE_CORE_MAX	105
+#define IWL_DR_UCODE_CORE_MAX	106
 
 /* Lowest firmware core release supported */
 #define IWL_DR_UCODE_CORE_MIN	102
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index f8913293ccef..e8240c1782ac 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware core release supported */
-#define IWL_SC_UCODE_CORE_MAX	105
+#define IWL_SC_UCODE_CORE_MAX	106
 
 /* Lowest firmware core release supported */
 #define IWL_SC_UCODE_CORE_MIN	102
-- 
2.34.1


