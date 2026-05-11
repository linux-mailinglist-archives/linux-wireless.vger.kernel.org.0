Return-Path: <linux-wireless+bounces-36247-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIsHOskaAmocoAEAu9opvQ
	(envelope-from <linux-wireless+bounces-36247-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 20:07:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9440751412F
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 20:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E9D930C10B3
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 17:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782B64657F8;
	Mon, 11 May 2026 17:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F2Udokan"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A965945BD6B
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 17:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521019; cv=none; b=jIXy6lHzot2GHZINVcM8aw+x+lEJIoAKRds4xSUahDwuD2ECk9AgMVAMaecY9AJVKc+z+tc8KLuhX9nHGILs77Ir71EwfVzwsj71nr5YeMcDszkeCZ5+mgiAXP7pSwSttQfAzYtqeNNWTXow5lXib2dTTQz7XZiJdQR6ya0Bw3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521019; c=relaxed/simple;
	bh=l7OWc82FRDKrG1ghK2X/QWZ/gBipnaVZniZwDrBVRhA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EyV7YNJMbdNYA5NZB8hgMae0R94Id+8tTwPv/tSSb+0erTsD0GC06eeTzSyGXRTZe7aP9oAhQ6CE5FxMYZfD/hJ6lS2i1Ec7K0SAVgcGqsVpEqYP3pBADk2w4HmC1aVCNec4sNtRB1iAgUtKFwTbvFB4aWMffPJXuMLzEg8i9JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F2Udokan; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778521018; x=1810057018;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l7OWc82FRDKrG1ghK2X/QWZ/gBipnaVZniZwDrBVRhA=;
  b=F2UdokangdvawMrJ20j5ACFYbAV1TG1bNPuMCBtOmnOKiuBqIrbQ8lc5
   euk5lCiP5LH/CTcT0DVqsPm1M/g3NJBBV4a0fk0nE4uUt/s13I5UAG5Kf
   d0iI60IXtHDkIgrc619T8O1kmlSDObMYJFdu9XN27VDqDIxYOW4RBXVyM
   xpwjbYFToD35H5Zd8qveXtrl1/EtFFXSME1n3treiZ0tkECL025votSzd
   gPFMMseIcaBkt8YhxfZ2oy1uwq4G0Pz+xIaYbm/liet9Why+kQE6Dabmw
   fdzuzyINIE0N+Ny/zvT3tAioY0Y1+Imky/FiMROBcLT7AvByzvFHCo5L/
   g==;
X-CSE-ConnectionGUID: BpclfTEkR7e9B5cCiBPIfQ==
X-CSE-MsgGUID: VKSBpK+jQ1Kl2wyNDqDFjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79314807"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="79314807"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 10:36:56 -0700
X-CSE-ConnectionGUID: aFTNqcToSjiQ8TfjZePrWg==
X-CSE-MsgGUID: +nasf9MwRh2GP7h/opCtZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="261004732"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 10:36:52 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH iwlwifi-next 06/15] wifi: iwlwifi: add XIAOMI to PPAG approved list
Date: Mon, 11 May 2026 20:36:22 +0300
Message-Id: <20260511203428.a6f01de83902.I9d5b5122d71ba872974f9e506e033dcb457d80a2@changeid>
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
X-Rspamd-Queue-Id: 9440751412F
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
	TAGGED_FROM(0.00)[bounces-36247-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Add XIAOMI to the list of the OEMs that are allowed to use
the PPAG feature

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
index 55128caac7ed..8d9ff36e30f5 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2023, 2025 Intel Corporation
+ * Copyright (C) 2023, 2025-2026 Intel Corporation
  */
 #include <linux/dmi.h>
 #include "iwl-drv.h"
@@ -112,6 +112,11 @@ static const struct dmi_system_id dmi_ppag_approved_list[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "WIKO"),
 		},
 	},
+	{ .ident = "XIAOMI",
+	  .matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "XIAOMI"),
+		},
+	},
 	{}
 };
 
-- 
2.34.1


