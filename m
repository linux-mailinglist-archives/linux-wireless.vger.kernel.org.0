Return-Path: <linux-wireless+bounces-20067-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFA8A57F35
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 23:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67C3B3ABD7D
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 22:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEB41B0411;
	Sat,  8 Mar 2025 22:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mv7IRbYi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086101EB5DF
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 22:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741471309; cv=none; b=L+c9pO5xrgwdxoxUkxs68cYyt5wt5UFFtG99BMyL3jW5MeAoveHlc3N+9Hg4rAMkzwywrULyxWxCZeSz++Hs16qgGO66dKxoJ5GVhUVo5dArad6caf69cWkU7C75oK+Rd41wmV7X1ZCWzfaMbdDlyX8Dj7ma6IZ+43vmcBhxsMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741471309; c=relaxed/simple;
	bh=WLUhtHJhudWqJPWAQV2HbGbmgk9SwTLmDIYLA1wZ0Bc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k9/LCTpiww8kSayYP1iPqiaIndYY5xM9YCNV2AvyDv5pkBCJba9XQUSnKl2PwVo0LAd5oWOqonpfF2jTtXIwCKUnhIEhBPq4yKTs1MQ2xYABQnTYXI4f44CUGqz0Xxpgt362UpMJDiHRSrzUPGPnDD5As38Y+iOVKCBt7XAWQ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mv7IRbYi; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741471308; x=1773007308;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WLUhtHJhudWqJPWAQV2HbGbmgk9SwTLmDIYLA1wZ0Bc=;
  b=Mv7IRbYiKJTlW5YI/3Idy5hvuMl6pZZ3X1WLNm92EDxm7RCXgzPOBgIp
   rhMfOU4Yiw26SBwtINV1BEUxL8hGlJSDQowYOCV9p5dxePys+9iPniFvz
   3oGPsQ8Hnb+MmHhlcSFwB6PUOhmAAbz88F5z9JtCzWLnXpaMxY+7ZMp+f
   rWSrwhvp8gMdednhROz6KQCiEgCegK1c0b+6N9uEvNsK1A8itIO93Uzup
   PmjNjsaFpgot4ewjuHXQLCjHjIhUhEZ8KHwEtYqYDXqP14aIJrU/aG4CB
   RBtRLd67+tKlR4FtWarhJPPCoL0CoVl4bsHuio85nXCH5M7O9nzeHpYO/
   Q==;
X-CSE-ConnectionGUID: jZpc2hEkT7+8YWEgnRvUqA==
X-CSE-MsgGUID: OcPz7VP8TUGjgqReaaqtRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="42540631"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="42540631"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 14:01:48 -0800
X-CSE-ConnectionGUID: LkzndhWxSYuwkfi9Dticmw==
X-CSE-MsgGUID: mD0Gn6v4R76r1Xx/qxV3mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="120352124"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 14:01:46 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Daniel Gabay <daniel.gabay@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH wireless-next 07/15] wifi: iwlwifi: mld: use the right iface iterator in low_latency
Date: Sun,  9 Mar 2025 00:01:17 +0200
Message-Id: <20250308235203.925cdca61ed0.I34f5c52d27414cb4c301bbd24df7c3530a43fa1d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250308220125.2388933-1-miriam.rachel.korenblit@intel.com>
References: <20250308220125.2388933-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

We used ieee80211_iterate_active_interfaces instead of
ieee80211_iterate_active_interfaces_mtx, which is the one to use when
the wiphy lock is held.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Daniel Gabay <daniel.gabay@intel.com>
Reviewed-by: Benjamin Berg <benjamin.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/low_latency.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/low_latency.c b/drivers/net/wireless/intel/iwlwifi/mld/low_latency.c
index 439fc10a4a41..e74e66735f52 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/low_latency.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/low_latency.c
@@ -120,9 +120,9 @@ static void iwl_mld_low_latency_wk(struct wiphy *wiphy, struct wiphy_work *wk)
 		wiphy_delayed_work_queue(mld->wiphy, &mld->low_latency.work,
 					 MLD_LL_ACTIVE_WK_PERIOD);
 
-	ieee80211_iterate_active_interfaces(mld->hw,
-					    IEEE80211_IFACE_ITER_NORMAL,
-					    iwl_mld_low_latency_iter, mld);
+	ieee80211_iterate_active_interfaces_mtx(mld->hw,
+						IEEE80211_IFACE_ITER_NORMAL,
+						iwl_mld_low_latency_iter, mld);
 }
 
 int iwl_mld_low_latency_init(struct iwl_mld *mld)
-- 
2.34.1


