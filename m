Return-Path: <linux-wireless+bounces-23961-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC62CAD4969
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 05:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50CA13A4D20
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 03:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CDC1EA7FF;
	Wed, 11 Jun 2025 03:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y6zKO+VS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DFE20C465
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 03:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749612878; cv=none; b=ojZSiAyU9QZ2SkBzP/J/GgGCJY5Ex6b2SH75bqnkTZoNiVbaBtYclU2H9h7Qc/V2chdx6krb9AdtvgBO+l2tIBBHF9kRgoOm+A6CVYBz/sa5RG9sM8aabHE6yt6VaDwT64uCM2AhPm9u+IBk/tQS2vmrDQL41aqbgRIl5h6XKJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749612878; c=relaxed/simple;
	bh=vVOEhfS8uBmV2AWGbh9zbfC7yYm/3cLvNe3Sk55Reuk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UQc2rcC00KesTH1/HNb/zHijDVzKFop8yuF5cENLXIrHP9/buXtQX/lx/9JZJLotjDv0J/WL7hdY6aSgSJQsvJyvVORPvFmGBRnP0qr3kVjz3uhlb5iwgUy5gdcim4eOx2nsN/YkuqKXpnYGWdwinDg6+blyHBgqL4Di61Xvo+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y6zKO+VS; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749612877; x=1781148877;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vVOEhfS8uBmV2AWGbh9zbfC7yYm/3cLvNe3Sk55Reuk=;
  b=Y6zKO+VSoVHp+Bcp3dyReO/H8wagfHLe6juMDxgCAQBbMYQJbwEJMSGB
   KErIxQ/ql4/bLE/a7ZR5RZ+WsfmRIPfajt0HupN0ChI9bUJfUx6fuS9oL
   Y5lqSOtQzz6p3q0FOqQfZoh9BTOniPjj4b6fee6zS37fpMSty15d9UdmT
   p9C+/tdxxHmTcGuK4K2vvTe84Gj7C9VvJBz011im7BKLTyyyw0WKcIJZ5
   cfMZNUfsu5czHapZrUEMl+fz1j7tvSi7Kyy2eGSmu3kAQwg+Q8xD4jT9r
   3fTBQxnv9a6E0IHcHNJvAAkaVcFNaOmy/gvcnj0rJk5+0OXbHt6NKf1uk
   g==;
X-CSE-ConnectionGUID: GLsNyLC+RJGDIeEKNzzlFA==
X-CSE-MsgGUID: CijijZfXRCKY4doQ44dsOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="63094885"
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="63094885"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 20:34:37 -0700
X-CSE-ConnectionGUID: TRDooyxASFGP13sEGX+RFw==
X-CSE-MsgGUID: 5B99nye8TZiKsZInNpziWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="150880926"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 20:34:36 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH iwlwifi-next 04/15] wifi: iwlwifi: fw: Fix possible memory leak in iwl_fw_dbg_collect
Date: Wed, 11 Jun 2025 06:34:04 +0300
Message-Id: <20250611063124.8158d15ec866.Ifa3e422c302397111f20a16da7509e6574bc19e3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611033415.1175681-1-miriam.rachel.korenblit@intel.com>
References: <20250611033415.1175681-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Ensure descriptor is freed on error to avoid memory leak.

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index ea739ebe7cb0..95a732efce45 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -3008,6 +3008,7 @@ int iwl_fw_dbg_collect(struct iwl_fw_runtime *fwrt,
 	struct iwl_fw_dump_desc *desc;
 	unsigned int delay = 0;
 	bool monitor_only = false;
+	int ret;
 
 	if (trigger) {
 		u16 occurrences = le16_to_cpu(trigger->occurrences) - 1;
@@ -3038,7 +3039,11 @@ int iwl_fw_dbg_collect(struct iwl_fw_runtime *fwrt,
 	desc->trig_desc.type = cpu_to_le32(trig);
 	memcpy(desc->trig_desc.data, str, len);
 
-	return iwl_fw_dbg_collect_desc(fwrt, desc, monitor_only, delay);
+	ret = iwl_fw_dbg_collect_desc(fwrt, desc, monitor_only, delay);
+	if (ret)
+		kfree(desc);
+
+	return ret;
 }
 IWL_EXPORT_SYMBOL(iwl_fw_dbg_collect);
 
-- 
2.34.1


