Return-Path: <linux-wireless+bounces-25135-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1A1AFF329
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 22:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B7B21BC6D21
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 20:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE412243374;
	Wed,  9 Jul 2025 20:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gXA+TeC8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05121246BC6
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 20:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752093513; cv=none; b=i8aH0eLvakUKQJ8kEibBunGRdFzNIWw3N/0ToUjNx4mr7Ng7udgaS5qJbK0dY3WWb22Hk0DkgGSQkQKBfbQkdfvz80ieEJGh7lFl4VL340pe5P9+TIAt4+ySOg+IqOUDTXwzykOVua4NlGMOra2Ytask2Jj1qrV9/1Q/hVjTU7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752093513; c=relaxed/simple;
	bh=N/uY5u3A0eIJyRndKwZfeQew6g9a/r1RUIzGRxqFpBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H1mQy5NqFUaeqIQyd9EAhlWwOnXZ1mdnqfXb1a1YCNjg4DywuF26Wcb+KpvhdTHNkeqTReLwNZ3xUJ2LoZvGwThceXNoge0hXPWLaATwbfnBjSEnfDqy2/nyhBLqPJlg70XXrwpc1GmoU/DDrn2gNqDjLL0n2Zp9BSd1xa4K+0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gXA+TeC8; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752093512; x=1783629512;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N/uY5u3A0eIJyRndKwZfeQew6g9a/r1RUIzGRxqFpBo=;
  b=gXA+TeC82huY2OwdT3+Iq9dOCKm88/p4AhVetaajZ1Umj8sbZTxORBBI
   R0//x5gL6A87RSdbO+CVlbLE/maX1QRY6FPuuMOaBfF+Ycsughc0ChtI+
   LWSmrv5oZlAN/7WEgQMzlhyVWaMZu0Eh8fZJtZD0FN20TC3cvWiAbByLw
   q4xRvYtoyk+VPHCY6GNLr2Z7fdUPxtB51yNlbZvswvYx/S6r0RQxR9yY8
   bl3DQNMD7gx/EOSBguZDt1urdBVx3VfnXBhKtBYBV6dUknMh4Qi+2UUdI
   Klr2zxeTdSkmqHTpkvuGUD7kQk9saRfr5cgraSMBTy7pv7bqXjjoJWw0p
   Q==;
X-CSE-ConnectionGUID: pnZe5wtJRkumLZSUzzns4w==
X-CSE-MsgGUID: Bh8MprvDQdO8sj/CPfDpeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="56974448"
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="56974448"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:38:31 -0700
X-CSE-ConnectionGUID: 9tFKttISQMm8AW2bF1vDJg==
X-CSE-MsgGUID: 5YZ2Ja7HRpu7frQaAZQpwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="161533012"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:38:30 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 06/11] wifi: mac80211_hwsim: Declare support for AP scanning
Date: Wed,  9 Jul 2025 23:37:58 +0300
Message-Id: <20250709233537.6916e0a49955.I48e374ad7e3ea5877a5e93e5c5fe8301465771c8@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709203803.1736809-1-miriam.rachel.korenblit@intel.com>
References: <20250709203803.1736809-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

To support testing scenarios.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index eefe8da3b14d..3789d46d5614 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -5384,7 +5384,8 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 			       NL80211_FEATURE_AP_MODE_CHAN_WIDTH_CHANGE |
 			       NL80211_FEATURE_STATIC_SMPS |
 			       NL80211_FEATURE_DYNAMIC_SMPS |
-			       NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR;
+			       NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR |
+			       NL80211_FEATURE_AP_SCAN;
 	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_VHT_IBSS);
 	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_BEACON_PROTECTION);
 	wiphy_ext_feature_set(hw->wiphy,
-- 
2.34.1


