Return-Path: <linux-wireless+bounces-7525-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C120D8C3510
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 06:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69F781F21554
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 04:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6481EEFC;
	Sun, 12 May 2024 04:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d3jZax+E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FDD1E4B0
	for <linux-wireless@vger.kernel.org>; Sun, 12 May 2024 04:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715488307; cv=none; b=uPJoDi0Tp3uxddcJzSAi/3ZK3o6bNfauM/WacBm7VO6f48kT1G6vEi/SyDUQ5XBBnkOIUfxn+kJQFcpTqK7+d2Qva0eMbqn6ouFrCMv5qmaHaR/tcAHZxwCUMYcBhGUvi2QnhHW1G4PwPQPf6574ntEBqDfAw+iU/twSjlnLAv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715488307; c=relaxed/simple;
	bh=dDFCy/3W4Gm9FhtPzS4rE0ksb5M0igjNp+kgIjWUsyY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gDjYQQO71ys/qhF0jGDq+saGNzNuSoPzyBQrrpipPrGtjPB56CCGErPjbBEX2Ts5I3VzhizonKfY93Tbz+LhWv6Y8JQKFNtpFFOF8PC+8RPVuaWYkxURBHvg/Yp0ow82b0O/c4Dra9VpWmWduMxyMfMkKZXD+sxFtgCVIKCfsag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d3jZax+E; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715488306; x=1747024306;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dDFCy/3W4Gm9FhtPzS4rE0ksb5M0igjNp+kgIjWUsyY=;
  b=d3jZax+Er4tFvFWvJ465/k3jzZ/buIQDYRZdOCKWcuInc2ClABs1g6Wt
   RF0fSx7qyiXhQ7t2DNubtYdE6zth8HiG3IqQBJ//ZdnB3f55h5RWM99WO
   ftrUkdIncR4MbOjexHsYgUXwN4EMgyb57qs0FS+j3QPRnkLHVi+MTVjQk
   zzaOx6TSIyUBIt9bp3T7VP2vNNcYPQfcJGaQr7cFIxnTRwJdhGUFwTI7O
   KvIyCC0MK3JyGM1QmWp0TvYpIoFpMDyO7R4alrZLh7rauZG1bHiWJCM5e
   VYQHqOtp+tdHBZZ7QT9yMO9X7vqMaqnKa2sRFeiAAL+Vqqr4KiumWgsXa
   A==;
X-CSE-ConnectionGUID: RyEi8sVXSnmyxBRx7Aen+Q==
X-CSE-MsgGUID: VWShgQiyRrCjxUYSkQxxJw==
X-IronPort-AV: E=McAfee;i="6600,9927,11070"; a="11323870"
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="11323870"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 21:31:45 -0700
X-CSE-ConnectionGUID: SJzu38AQR6y9icpiF7tEbg==
X-CSE-MsgGUID: abcTtjArQk23779tqmc7cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="34532196"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 21:31:43 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 14/16] wifi: iwlwifi: mvm: use vif P2P type helper
Date: Sun, 12 May 2024 07:31:08 +0300
Message-Id: <20240512072733.15a00a812c1b.I5ffee795d960c9beda46a934f5b4c70acde112f9@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240512043110.3413383-1-miriam.rachel.korenblit@intel.com>
References: <20240512043110.3413383-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

Use ieee80211_vif_type_p2p instead of checking for IFTYPE_AP in
combination with vif->p2p.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index a7ec172eeade..695b5ba3d023 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -208,7 +208,7 @@ static void iwl_mvm_scan_iterator(void *_data, u8 *mac,
 
 	curr_mvmvif = iwl_mvm_vif_from_mac80211(data->current_vif);
 
-	if (vif->type == NL80211_IFTYPE_AP && vif->p2p &&
+	if (ieee80211_vif_type_p2p(vif) == NL80211_IFTYPE_P2P_GO &&
 	    mvmvif->deflink.phy_ctxt && curr_mvmvif->deflink.phy_ctxt &&
 	    mvmvif->deflink.phy_ctxt->id != curr_mvmvif->deflink.phy_ctxt->id)
 		data->is_dcm_with_p2p_go = true;
@@ -2875,7 +2875,7 @@ static void iwl_mvm_scan_respect_p2p_go_iter(void *_data, u8 *mac,
 	if (vif == data->current_vif)
 		return;
 
-	if (vif->type == NL80211_IFTYPE_AP && vif->p2p) {
+	if (ieee80211_vif_type_p2p(vif) == NL80211_IFTYPE_P2P_GO) {
 		u32 link_id;
 
 		for (link_id = 0;
-- 
2.34.1


