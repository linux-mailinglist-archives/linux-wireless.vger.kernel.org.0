Return-Path: <linux-wireless+bounces-13667-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37945993DF3
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 06:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73CB6B24830
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 04:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5B713541B;
	Tue,  8 Oct 2024 04:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KCAYe6ER"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382063C0C
	for <linux-wireless@vger.kernel.org>; Tue,  8 Oct 2024 04:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728361548; cv=none; b=oIc7Oiu7xZjf3VmEWovFGLYYOjsDGkq5moT9xZ+urM/VkoZ8pBi5zEBFBdfOQ3sc7ehThH5KvB1AbtGLo9f55Obk99xnykCzGvBvGUYXapy4x0fJC3oI+satiLCorlf0CxAgOHSq3NXRX2HRVM5w2NjY2dNv7jAdOuMLanA7MkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728361548; c=relaxed/simple;
	bh=ZwtdlBCUZnuOqpcidnfHycZze3+d4q9H3u2YelPl6gs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d8n7mtxpsR7uhl7z4Eg1Qitji7Q7Xr0NIEEuGOL9oZmMR1boedxv1+kj9z5E9o7FQNCLvQRn+kzuKdMf1xyMY9u1q8FcDzfizMPK7O4LNR4i3o8lVRZiONpqEGgN11/UqcxS9flO4H1rbWrWD27BKT+xj1T5SoaronWUY5hwMK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KCAYe6ER; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728361547; x=1759897547;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZwtdlBCUZnuOqpcidnfHycZze3+d4q9H3u2YelPl6gs=;
  b=KCAYe6ERmELXpqvmj8JRpx/XlxwoVdQm2coSnMnDzOxrPPMXDr+Dy9pH
   AEfQnQMNz+hgFCae1NmHEGQHveppGnv1boEetr0Or5N+cnMIFmbJeNePR
   gYZdJlc+2khRscUjoNq0IsMKj0qF/bEq7rsWKUyK+cf10Q6eoieDfYe4Y
   R0A2KoXyiWiIx47ikhqE9KBz6CpFYRedetJU35TSbcOHZKNxZojMhPbTg
   yjdGJ3i4p7rtt9bZzKFxqMh44raMfceL0Ei5NukruKHXN+w88w7BqUmTV
   y6b1RPTXeJxyqAXz3gmcsEuL7HLHBnipceuqmOx2V6Z5T/6wfcsYNTgb/
   Q==;
X-CSE-ConnectionGUID: wkDk/hvVRdqSMNGBLlfpyQ==
X-CSE-MsgGUID: oCakPO4nQfK192jZISrSxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="27024264"
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="27024264"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 21:25:47 -0700
X-CSE-ConnectionGUID: E12MzglQRfWqfu5Puv/MMQ==
X-CSE-MsgGUID: iqjmHM0BRS+lRYnl5uOhKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="80486318"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 21:25:46 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 04/14] wifi: iwlwifi: mvm: log information about HW restart completion
Date: Tue,  8 Oct 2024 07:25:18 +0300
Message-Id: <20241008072037.d205dd88fb9d.Ic43a1b399f59d2ab1018ff2f9e6e3a0324692660@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008042528.2549752-1-miriam.rachel.korenblit@intel.com>
References: <20241008042528.2549752-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

It can happen that more errors occur after a firmware assertion. In that
case, having another log message after the restart has completed makes
it easier to see which errors where still part of the restart flow.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 3fefb0696248..4db7c3ee6bf5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1336,6 +1336,8 @@ static void iwl_mvm_restart_complete(struct iwl_mvm *mvm)
 	 * of packets the FW sent out, so we must reconnect.
 	 */
 	iwl_mvm_teardown_tdls_peers(mvm);
+
+	IWL_INFO(mvm, "restart completed\n");
 }
 
 void iwl_mvm_mac_reconfig_complete(struct ieee80211_hw *hw,
-- 
2.34.1


