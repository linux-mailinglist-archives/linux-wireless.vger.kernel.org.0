Return-Path: <linux-wireless+bounces-3223-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7377F84B88A
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 15:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75C361C21127
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 14:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A13133420;
	Tue,  6 Feb 2024 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VGbi8QRK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678D412FF7C
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 14:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707231268; cv=none; b=G9p/RWblNmDulY3KMAxcBjfYnj+N2IiL3nQcuSAMi6JgeiPfg74uOke6yDlW7Jsn5C5t7rKZYAVJM3je53t44DClqtNhG0jpaWa1Jw6QPnRMj4/6ZHLym0Hmu7ilN7G1Xd+GlPxF7Wsc6uJ5zLs5hTmB5rpd1egzsMwx3jN3Cfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707231268; c=relaxed/simple;
	bh=YhjBnTOz2cys/RE0TKMvtTeQDcrMLdICNmFhoY6w5UU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hrWccvJVHpmqVJBruv13cT72O8qmQXMoEPSzS7fyJNrMMGJUdPDLDC56180zlOSmLl99Quxwkvs2CTLDzHhDEZXNxG7HBsTFmacHYUrA5qYBSfOOBB6t3n9cAfH29uvWNjJbHCuWZDLZVU44I5jklhcMLKt/eo7HjBXtrBUzkaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VGbi8QRK; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707231266; x=1738767266;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YhjBnTOz2cys/RE0TKMvtTeQDcrMLdICNmFhoY6w5UU=;
  b=VGbi8QRKO9/iB+6aH8/1hxeoFP7pCoUvLPC0mxJ++JkP9poT5VMtD2mG
   d8UauV4pv8MnPz4p9etC7MS/i/TmIEHpyogKLPHJi9C6E03xsLdEkI2Y5
   6o06e/T9GhosEYlvvV26WPgNP6fGMqaXKOA1XAuYAzwtXa/zivsg3eaDE
   tDTLRu42YJ6A1iAMgzg3Lfa5EW74ZDVHuPEbHn9pPFrjOZyXd/rs0LvA4
   PO9C1C3YQyCWGa/27j7Ayf0JUTtOYMoOkQ/otSsYBNqAPBHaCgmxO8GRW
   M+hOm/mtDGBSct/mmwwTTRuUSVUfgKPSvQVQ6cMLIR9P9U61tcsqnxXEh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="917784"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="917784"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 06:54:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="824197907"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="824197907"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 06:54:24 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Subject: [PATCH 1/8] wifi: mac80211_hwsim: Add 160MHz bw range to regdom_custom_04
Date: Tue,  6 Feb 2024 16:54:04 +0200
Message-Id: <20240206164849.1b9955e511f0.I5e5315e3a047db3677bfb5ead003a3a4f7d29b13@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206145411.3217588-1-miriam.rachel.korenblit@intel.com>
References: <20240206145411.3217588-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>

This allows testing 160MHz channels with DFS concurrent.
While at it, remove the TODO for adding a module param to enable
NL80211_EXT_FEATURE_DFS_CONCURRENT. This is not really needed as
mac80211_hwsim still needs to be loaded with custom regdom.

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index a06a462d38f0..3f7cb3568477 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -196,8 +196,11 @@ static const struct ieee80211_regdomain hwsim_world_regdom_custom_04 = {
 	.reg_rules = {
 		REG_RULE(2412 - 10, 2462 + 10, 40, 0, 20, 0),
 		REG_RULE(2484 - 10, 2484 + 10, 40, 0, 20, 0),
-		REG_RULE(5150 - 10, 5240 + 10, 80, 0, 30, 0),
+		REG_RULE(5150 - 10, 5240 + 10, 80, 0, 30, NL80211_RRF_AUTO_BW),
 		REG_RULE(5260 - 10, 5320 + 10, 80, 0, 30,
+			 NL80211_RRF_DFS_CONCURRENT | NL80211_RRF_DFS |
+			 NL80211_RRF_AUTO_BW),
+		REG_RULE(5500 - 10, 5720 + 10, 160, 0, 30,
 			 NL80211_RRF_DFS_CONCURRENT | NL80211_RRF_DFS),
 		REG_RULE(5745 - 10, 5825 + 10, 80, 0, 30, 0),
 		REG_RULE(5855 - 10, 5925 + 10, 80, 0, 33, 0),
@@ -5386,7 +5389,6 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 		schedule_timeout_interruptible(1);
 	}
 
-	/* TODO: Add param */
 	wiphy_ext_feature_set(hw->wiphy,
 			      NL80211_EXT_FEATURE_DFS_CONCURRENT);
 
-- 
2.34.1


