Return-Path: <linux-wireless+bounces-22464-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3DAAA9C0F
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 20:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97D5117D7B6
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 18:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C9326F444;
	Mon,  5 May 2025 18:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RBYKUiHV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0125326E146
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 18:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746471432; cv=none; b=MMbhEgD30rDCw5rwUY5He/50lZC76imhK8YiJy52IM9ba2Mwr4eO1tg4P3nhi9MllRptl2x5OVZY3f32oxb3iAyNrbMM1mQtUP+a2vkIpVjth/dgWoz1/edyNKS3/ECMSs8SR+a7C7DP0+brqctvL9VhJbWtJuAfJppojWcqCwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746471432; c=relaxed/simple;
	bh=XCUK2bhXng/sO6G4l78RlaoLex4lWrKXRJaNNf/a8pA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sDsSaK94bZdMs+EEmR7qFnVGFBbMf6u3vWRhj7lyOOIW1nrbUY+HuznmglI6rdwng5R66onKHn9DBibLP9UaCq2UzoBUklwNgQ7IZS5Tf6tntgstjHxIcrM2Ju8w9wHUutBWfsrd3kHDuBYYSOQxOt1BBstEckxFLVpq0KiGh58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RBYKUiHV; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746471431; x=1778007431;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XCUK2bhXng/sO6G4l78RlaoLex4lWrKXRJaNNf/a8pA=;
  b=RBYKUiHVQNKAS07QcPnTypx7g7bYTOcrNWdDTELGhqAJlkjL0SM35ND9
   BlZQq8sGII2hGdLO3292vPDScy07mP+vxY15lS25mj72+UCGC0BngjyXv
   F0eVyjX7l6OQW22EdlT6cJ0fvd5LouycofD8IihoDUiNtbz01K6meXDoQ
   9/mAZyjYEdjqw937lp9HYub368AUwLregy6BgOobpNQlkJiY697bRZh4c
   WagTVqrxCuuXFS0FivZnkOY5D4XCxyMgpw5nedKBRPQ8PfM6RT0GDq1SK
   z7hvn5g8H8b4J4kNY1HZ0A4NA20GUkcgKXmYzeeEgBXOzaolwfoSiM146
   Q==;
X-CSE-ConnectionGUID: YEylia+cQ9qTM/PA/jrLqA==
X-CSE-MsgGUID: Tjs57AXGRwiPQ2+v/7zFag==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="47359433"
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="47359433"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 11:57:10 -0700
X-CSE-ConnectionGUID: NW0ejxSBRK2H8SaCZz5hPA==
X-CSE-MsgGUID: rrj2lckARumpV9GeGNKuuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="135697900"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 11:57:09 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 01/15] wifi: iwlwifi: mld: remove one more error in unallocated BAID
Date: Mon,  5 May 2025 21:56:40 +0300
Message-Id: <20250505215512.115c9092cf63.Id5aa779b6a0a0d51cc127ba561c01ffc6594a178@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250505185654.2068339-1-miriam.rachel.korenblit@intel.com>
References: <20250505185654.2068339-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Since the FW is the one to assign an ID to a BA, it can happen that
the FW sends a bar_frame_release_notif before the driver had the chance to
allocate the BAID.

Convert the IWL_FW_CHECK into a regular debug print.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/agg.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/agg.c b/drivers/net/wireless/intel/iwlwifi/mld/agg.c
index f606a39a53ec..bda488ae9eec 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/agg.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/agg.c
@@ -124,10 +124,12 @@ void iwl_mld_handle_bar_frame_release_notif(struct iwl_mld *mld,
 
 	rcu_read_lock();
 	baid_data = rcu_dereference(mld->fw_id_to_ba[baid]);
-	if (IWL_FW_CHECK(mld, !baid_data,
-			 "Got valid BAID %d but not allocated, invalid BAR release!\n",
-			 baid))
+	if (!baid_data) {
+		IWL_DEBUG_HT(mld,
+			     "Got valid BAID %d but not allocated\n",
+			     baid);
 		goto out_unlock;
+	}
 
 	if (IWL_FW_CHECK(mld, tid != baid_data->tid ||
 			 sta_id > mld->fw->ucode_capa.num_stations ||
-- 
2.34.1


