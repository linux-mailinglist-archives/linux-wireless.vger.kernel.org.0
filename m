Return-Path: <linux-wireless+bounces-27127-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F310AB49FF8
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 05:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 141581B24361
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 03:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B322701D8;
	Tue,  9 Sep 2025 03:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ETbGlfX4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B446278761
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 03:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757388127; cv=none; b=LLac/Gan3qTrX/YvDkvqQsGX+/PNpQAHGBZ6VnThk7+Qck5hgwxDCO0eKznui8tjf+SeV+WcnYcY5JJe+XNM7Ae3fzRIyT2y2Fh5fywL0zs+j6Lbk8v91BwdzqV2v0PflShUbuIUX4JczUK9ABv4T34Eg58biFz3wOyNlw/6ZP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757388127; c=relaxed/simple;
	bh=36SLZfP67T4t/n6cL1v283mpx7AlsFyL9XXdKWiwyww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=plvz7lGxFS0+P94H1KlWoAs0uGTgvaE6v43bR0iN5sgeg2GgHqygYbv0icBb1rNMzZAjXevTM+B+Ye2SyXMrK/Y6HSMdKWDcAR8axmty/st7r5OkRnI1OyUO00llO7YGBez2DXao4NoEFAxSJMUg30p+tJpya75krEFmBtWlDBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ETbGlfX4; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757388126; x=1788924126;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=36SLZfP67T4t/n6cL1v283mpx7AlsFyL9XXdKWiwyww=;
  b=ETbGlfX4spixFtG491pxVp1UeCMYSgRAnP0gK5a0+PAtyxKZ19hRuMAB
   /KwDZMt1T51VBSTjGyOFevM7YZ/wDHJSzNlsNaZ4+CVYkXGUsUMJkkKSL
   0s/o9+U3EPAd7SGIOEpUwV2GvPCaHqbblhmytKacorBOQrIvOU1UxBf2W
   YYholA9ngSvJMGV6O465vJqI1DKhO0tXSmb6CymOSF1FZrMfkJszDZLqR
   jOSrZnXnl6F8muuUHEF+TPuB+8A3/tmSkarDEVB6f3pmnHrTjEk7SlS/E
   EBoNa1FtElNibsAG5LjLRRDWO4AgdCj0lmdgR800QHAu5rk9RwZ8eAjDi
   g==;
X-CSE-ConnectionGUID: kPMp1fHYRnqa+yP5GG8oYQ==
X-CSE-MsgGUID: AAiB5i8+ReaEN8T0XH9emQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="70281062"
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="70281062"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 20:22:06 -0700
X-CSE-ConnectionGUID: 5Fdif2iRR7Olkstg2ajMHw==
X-CSE-MsgGUID: AbDPwIvMRCmj98A6fOx8Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="203950379"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 20:22:05 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Nidhish A N <nidhish.a.n@intel.com>,
	Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH v2 iwlwifi-next 08/15] wifi: iwlwifi: fw: Add ASUS to PPAG and TAS list
Date: Tue,  9 Sep 2025 06:21:21 +0300
Message-Id: <20250909061931.499af6568e89.Iafb2cb1c83ff82712c0e9d5529f76bc226ed12dd@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250909032128.3318193-1-miriam.rachel.korenblit@intel.com>
References: <20250909032128.3318193-1-miriam.rachel.korenblit@intel.com>
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


