Return-Path: <linux-wireless+bounces-20084-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61669A580AE
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Mar 2025 06:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B01817A6770
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Mar 2025 05:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2711474CC;
	Sun,  9 Mar 2025 05:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B4Dr8jqi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309E615E5DC
	for <linux-wireless@vger.kernel.org>; Sun,  9 Mar 2025 05:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741498640; cv=none; b=GxNey++CUNikOMqVbqujzOMTPYZVBYm4klwJGFwN/PQs9Uj9wdjYG1xneAW9Ha5LW+n3Kfl04X/ZEHaTkO6zz/yL7GlJlNtsVOwRZ+3w5RoSOhZkz8QQFN+PohyBAXkebl5AREbSSs7NfM/COxFdLs6mSaSgKkTTx4x3PkLrC+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741498640; c=relaxed/simple;
	bh=dIwur6ttrR6eDMU6ax+fbSD92MTmtuIeYgs5PrhU/Co=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cM6mXp7HVKE/QzCQdzcsaeYvWKfoXfcVtifZyoeS5WuwaIYMJCcndkBgplzh5+JHydNPiGMwPyyK4J2TaYoqkr4AKYTwfFXhYqK3UiVd/AgrvDhvAcOwuM0Zre/WaVCtPCV2LSqwbzLlAlHr9AvEs38cn1uOtVNxofkftDxxprU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B4Dr8jqi; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741498639; x=1773034639;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dIwur6ttrR6eDMU6ax+fbSD92MTmtuIeYgs5PrhU/Co=;
  b=B4Dr8jqiZiq7boGFVVhTtQnCthBC2NzuHrsNswIv2MHogNfwPVxRaqvT
   hWjhwskE90uUrvnqurAhThH20eHJ6TPNwHs/nJrhMsfUC2T7jYjSB1/Ve
   4xz5CYdLJ2op+uieJ3izYHwrAAI2UYt9mf8CRuTYsfplaDDIy53xpDAZZ
   1BDkQgHfFx3uIqudqu4zj3obxPJhyikEAJ/bBUxQim5k2cGTZ2UtzN7Z3
   q7Sn3YsRuEu3cSkeL79DmAthQ2DXmJYNbIU6xQRrimSRBK/YJ/2hn0Oqz
   x87lKbKU1OX2CIC67t48DzXly8kePHJ5ErsQC22wtpYA9J1kvMoPiGIh5
   w==;
X-CSE-ConnectionGUID: Oppo40J8Q4aGRZI6j2on7w==
X-CSE-MsgGUID: QtBz8ap7S0qyWJVeICtg+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="41671698"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="41671698"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 21:37:18 -0800
X-CSE-ConnectionGUID: srdevqiPTU2mU8h1gIrmxA==
X-CSE-MsgGUID: ZpZibghNR3yNTShZlP4SAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="150470638"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 21:37:17 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 wireless-next 08/15] wifi: iwlwifi: mld: fix OMI time protection logic
Date: Sun,  9 Mar 2025 07:36:46 +0200
Message-Id: <20250309073442.58efb4c91655.Id596fcda2fb28f5945548d780be9ff90aee76b7e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250309053653.2697525-1-miriam.rachel.korenblit@intel.com>
References: <20250309053653.2697525-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

We're allowed to enter OMI only 5 seconds after the last
exit, so the logic needs to be inverted. Fix that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/link.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.c b/drivers/net/wireless/intel/iwlwifi/mld/link.c
index 64ebafc35c9b..f6d482817f1b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.c
@@ -760,8 +760,8 @@ void iwl_mld_check_omi_bw_reduction(struct iwl_mld *mld)
 		return;
 	}
 
-	if (time_is_before_jiffies(mld_link->rx_omi.exit_ts +
-				   msecs_to_jiffies(IWL_MLD_OMI_EXIT_PROTECTION)))
+	if (time_is_after_jiffies(mld_link->rx_omi.exit_ts +
+				  msecs_to_jiffies(IWL_MLD_OMI_EXIT_PROTECTION)))
 		return;
 
 	/* reduce bandwidth to 80 MHz to save power */
-- 
2.34.1


