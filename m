Return-Path: <linux-wireless+bounces-3178-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 601A984A6E2
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 22:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9273E1C267F5
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 21:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551CB59177;
	Mon,  5 Feb 2024 19:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ii1Xe6Bw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D698A59179
	for <linux-wireless@vger.kernel.org>; Mon,  5 Feb 2024 19:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707160935; cv=none; b=cP+f5UD8HKsR0wwKRBcGqVCkpLUhJSREsnWEhczpUX4YNJsI29IVqx3HbG8NszD8HW8fb95L0A29Fds9kPpK8sMuQn2VzUx/QRqwZaMxv9czFjQ8/2DbgzQQ0lgaMY6uRgYXoyZrxgWsJ4UL0+QItqGYs1/r9AynThIY6L5OS44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707160935; c=relaxed/simple;
	bh=WStCvm8xM97KodmKppMWFojmBvs+fmxqxyXv3qM1crM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YwPKC76z+tXcplGeki4KeVgQjhhSzneJzeYJmFtGcnDcYlZdPS6IgBsGNQeCUd4MBgWXSPr6Vbj557DFSpirMlz7t60XPRTL3FsctQazbvpwhgTdEee94ZawtP8MKa7lkJVIH4GcofVs21NzH0s5WXsqOJ5HA5TNe4YieJUcLaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ii1Xe6Bw; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707160934; x=1738696934;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WStCvm8xM97KodmKppMWFojmBvs+fmxqxyXv3qM1crM=;
  b=ii1Xe6BwMxf/3epcbPt1oGt5nl5QIN/xGmMKmeodTEMnr5LhbUhTyUUF
   ob/wLsVeevtJrnEbwKUKdh8fcQE/QvdoeiHvAkCj20BWL9B3dvpyKFDAQ
   KJIkXbasMhvCShHHMnLfyXp9zlhrDygam1F+iidnBdo3WU3JG8tofpHVL
   TjriD1OBpK5SCTOWhB3Q/oW+2nyE0g6YMQLQ8AAo8sz5EWwTq0G6GJhQ2
   vgVwGztK66D1o8udNygW3n6fGfToMGtqbjp7rymfofSOYAUp/7CFWvWAS
   4YnqMdON636WXtKULtpQR1jkqsk+ZXoByp+IvAx0l/r6JPUcZmHM95oLJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="4381671"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="4381671"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 11:22:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="5403208"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 11:22:12 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 15/15] wifi: iwlwifi: mvm: don't do duplicate detection for nullfunc packets
Date: Mon,  5 Feb 2024 21:21:15 +0200
Message-Id: <20240205211151.4fea3bd2d4a6.Ib80764f4581d875cff08469016894f7c817c3828@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205192115.2320146-1-miriam.rachel.korenblit@intel.com>
References: <20240205192115.2320146-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

For non-QoS nullfunc packets we currently do the duplicate detection,
which seems a bit wrong. Fix the code to check for _any_ instead of
just _qos_ nullfunc.

Also remove setting the RX_FLAG_DUP_VALIDATED flag, we haven't done
anything here; in particular, we haven't checked for multicast in an
MLO scenario.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 7c0da3b8ad77..b7639e429889 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -519,11 +519,9 @@ static bool iwl_mvm_is_dup(struct ieee80211_sta *sta, int queue,
 	 * (IEEE 802.11-2012: 9.3.2.10 "Duplicate detection and recovery")
 	 */
 	if (ieee80211_is_ctl(hdr->frame_control) ||
-	    ieee80211_is_qos_nullfunc(hdr->frame_control) ||
-	    is_multicast_ether_addr(hdr->addr1)) {
-		rx_status->flag |= RX_FLAG_DUP_VALIDATED;
+	    ieee80211_is_any_nullfunc(hdr->frame_control) ||
+	    is_multicast_ether_addr(hdr->addr1))
 		return false;
-	}
 
 	if (ieee80211_is_data_qos(hdr->frame_control)) {
 		/* frame has qos control */
-- 
2.34.1


