Return-Path: <linux-wireless+bounces-27055-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC82B479A3
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Sep 2025 10:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B44B1B21F25
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Sep 2025 08:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264C0139D1B;
	Sun,  7 Sep 2025 08:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dVwjb4YK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF4121C9E4
	for <linux-wireless@vger.kernel.org>; Sun,  7 Sep 2025 08:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757233865; cv=none; b=VYcIxvV6zqsY4kSpjUR3YhsBNj++YM50AUgPEnkLMvhLThm4lCZR2JmgEqcPNArudZj03kmjbKxvAmfGuAqUUJ2ZtWaCfdxM2GqAGfcGtMo01XpANbQ569RUxiiIq7ecN2+6dQUa1PKdTBpTWWlUvn2Z9/yGeTPcZaUYn4lc8yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757233865; c=relaxed/simple;
	bh=36SLZfP67T4t/n6cL1v283mpx7AlsFyL9XXdKWiwyww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ITEdVrNE46a6ZtP3/zZoHG9LlukSOk68NypJppAZ1X/SgTVFzggrvcBC5NvjPn4k/XHKetNXLitUbJi/LN5XMSTJ72npwzyDmRL7EEEA4Q9QNTHlquojyj+JpYP2aEXZGhNZ3ebV3UyB2u3rlE88uk9+Xi9aJ/nxA4JfK6yaBuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dVwjb4YK; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757233862; x=1788769862;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=36SLZfP67T4t/n6cL1v283mpx7AlsFyL9XXdKWiwyww=;
  b=dVwjb4YKxmJ3pzK6uvFGaKOMtfMSsFIVbb8NbZ6z3hyykmDVD6mf2X5k
   NFKke7q+bTVQ18cIf0LrbamZhGHUq8EUdPoB7kIIu55nVuwYNCx9xqBOp
   YAYt16lhwWOHWCusVZKpyE4AhM08D0JzZMJmqx1zk6/QlpQBzusKh9vpi
   Oulr5vVE9Tp2wrgxOe2OqLOG0dA/YTeQoMrT3q7Y2tlGw4diotCWBX7VH
   53uYcL5e4FHCJBpKLnl6bxYYcqAUFSTxDHiIZksnI16QQsHKZ5bvqMQYA
   9k+GiTcW5aSRtrY9FvlgMSTCoR7hz53t5pn4Qs6dWw0sUdflEe3rC6CiW
   A==;
X-CSE-ConnectionGUID: JE2n9PjJRESSQT14Yg5s3w==
X-CSE-MsgGUID: f/tBP3h6QaqC6odIUgQ0Rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11545"; a="76973614"
X-IronPort-AV: E=Sophos;i="6.18,246,1751266800"; 
   d="scan'208";a="76973614"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 01:31:02 -0700
X-CSE-ConnectionGUID: C6mkmw+PRjycqcG0YV8KiQ==
X-CSE-MsgGUID: gNe6eqpgT06L2PFjsd0EuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,246,1751266800"; 
   d="scan'208";a="171790057"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 01:31:01 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Nidhish A N <nidhish.a.n@intel.com>,
	Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH iwlwifi-next 08/15] wifi: iwlwifi: fw: Add ASUS to PPAG and TAS list
Date: Sun,  7 Sep 2025 11:30:07 +0300
Message-Id: <20250907112757.499af6568e89.Iafb2cb1c83ff82712c0e9d5529f76bc226ed12dd@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250907083014.1439961-1-miriam.rachel.korenblit@intel.com>
References: <20250907083014.1439961-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Nidhish A N <nidhish.a.n@intel.com>

Add ASUS to the list of OEMs that are allowed to use
the PPAG and TAS feature.

Signed-off-by: Nidhish A N <nidhish.a.n@intel.com>
Reviewed-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
index 6e98ac341997..e1f28b053253 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
@@ -59,11 +59,16 @@ static const struct dmi_system_id dmi_ppag_approved_list[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
 		},
 	},
-	{ .ident = "ASUS",
+	{ .ident = "ASUSTEK",
 	  .matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 		},
 	},
+	{ .ident = "ASUS",
+	  .matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUS"),
+		},
+	},
 	{ .ident = "GOOGLE-HP",
 	  .matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Google"),
@@ -141,11 +146,16 @@ static const struct dmi_system_id dmi_tas_approved_list[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
 		},
 	},
-	{ .ident = "ASUS",
+	{ .ident = "ASUSTEK",
 	  .matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 		},
 	},
+	{ .ident = "ASUS",
+	  .matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUS"),
+		},
+	},
 	{ .ident = "GOOGLE-HP",
 	  .matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Google"),
-- 
2.34.1


