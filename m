Return-Path: <linux-wireless+bounces-20271-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2E3A5E743
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 23:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32F2916183E
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 22:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2B21EF370;
	Wed, 12 Mar 2025 22:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ILMbZs3/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDCF1EFFAC
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 22:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818182; cv=none; b=QoLvaFlbbFOUtEOh88wlsc0MthYPQf5zj3cUNgzM1nGWVrwJsPw/4NEKNVxAULmQ1svQiGfw+QID9/P4gCrycJWcgrzEnMvYXqUxW/fA3GDvQqm1VM4N5V67LgpUDSYX0qUq2oJm+zpxjypXjbXQQDUWXB1zheUt4ORCSOIZfPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818182; c=relaxed/simple;
	bh=7mlyVuLa722+2+u7CxUf2bFsPAs/d/a5jo36IU0uDYg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=exeRlEbDYuhlRKmmoIUelnJD4ppkqZtsglFRzBAypFd7fzXqfFdab8kuZFSX+eJpxLGnzVauUW36NAMCziR50Bw888a86l5Jz7KiFl68Us/8N+ml0VVad7dKaELV78aeBRw4UJkpdsPxCVRfUTbGFZm4zBBSIQNWHHFL4I+mqMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ILMbZs3/; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741818181; x=1773354181;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7mlyVuLa722+2+u7CxUf2bFsPAs/d/a5jo36IU0uDYg=;
  b=ILMbZs3/l/QrsaHKQGTvyRAPzOU01oZo3TonIrMm0r5mRxZ2P1ADGnDJ
   wn0c0GGulfncmz2al7Lq/LJ8YmiSr1EJl/6Jut8X4E+cScYH7xNGR6osc
   lhkeJ0mrLxhVw1HR0trOxOy8Unkh59fV8JixVVEV/rCPLmaE7xQNtParE
   W1OZZ4qHpIrWJPrp1TDJIkd5aY2hgTA2q/10e+MvV1nvYPbGxrSxXEzZr
   C7yrGMA5yWkLvcAqUaUMLivTLAbTrFHEBTgL4EP3TUPD7TzabF5patW9r
   ZFA2+lmw8972MDGgojL/mMOqvpvlJBqnpadMar76+bSX7Om+9YnFKBoAN
   w==;
X-CSE-ConnectionGUID: +yhF97+iRSezC2xlJ5bIoA==
X-CSE-MsgGUID: jKJbPeiZQp2UYVgjrh67Lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42826747"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="42826747"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 15:23:01 -0700
X-CSE-ConnectionGUID: OPhSkv/4S8uCJNloaqK5zg==
X-CSE-MsgGUID: Omer2yQ4TmOg3SwedqB2yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="121267373"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 15:22:59 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH wireless-next 06/15] wifi: iwlwifi: mld: prevent toggling EMLSR due to FW requests
Date: Thu, 13 Mar 2025 00:22:29 +0200
Message-Id: <20250313002008.f0e74a7f99af.I447c8788afba85a2a5040ae2c1213b6e05ec14f3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250312222238.2585340-1-miriam.rachel.korenblit@intel.com>
References: <20250312222238.2585340-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

We exit EMLSR mode if the FW requested to do so.
To prevent repeated toggling of the EMLSR mode (frequent entry and
exit), add this exit reason to the EMLSR prevention mechanism.
This mechanism avoids re-entering EMLSR for a certain period of time
after multiple exits caused by the same reason.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
index 9556ff3a75a1..8f6da90bf82c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
@@ -116,8 +116,9 @@ void iwl_mld_emlsr_tmp_non_bss_done_wk(struct wiphy *wiphy,
 #define IWL_MLD_SCAN_EXPIRE_TIME	(HZ * IWL_MLD_SCAN_EXPIRE_TIME_SEC)
 
 /* Exit reasons that can cause longer EMLSR prevention */
-#define IWL_MLD_PREVENT_EMLSR_REASONS	(IWL_MLD_EMLSR_EXIT_MISSED_BEACON | \
-					 IWL_MLD_EMLSR_EXIT_LINK_USAGE)
+#define IWL_MLD_PREVENT_EMLSR_REASONS	(IWL_MLD_EMLSR_EXIT_MISSED_BEACON	| \
+					 IWL_MLD_EMLSR_EXIT_LINK_USAGE		| \
+					 IWL_MLD_EMLSR_EXIT_FW_REQUEST)
 #define IWL_MLD_PREVENT_EMLSR_TIMEOUT	(HZ * 400)
 
 #define IWL_MLD_EMLSR_PREVENT_SHORT	(HZ * 300)
-- 
2.34.1


