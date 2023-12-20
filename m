Return-Path: <linux-wireless+bounces-968-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C6A81838A
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 09:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C06711F24EE5
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 08:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B36414017;
	Tue, 19 Dec 2023 08:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M/sEjFJi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200DF13AE4
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 08:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702975069; x=1734511069;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Eams0VpuoMMZYPAL1KSvNA5aYq7KuRSd1uTuaQwKWjw=;
  b=M/sEjFJi8ViboVXfK4GICprA+qRJKJhv6U2odSDvDdje0yyWihmn2N+h
   LfJqW3u38gN9sWBp4Knu4wkegjtsaqK3EEPnY8SEIqFWj/sL44E/b8dWf
   seEVMYFKul96s5IWiVdubQqdCuOIVAd3ycMGcQl8m+znwCSbZIX92dhCn
   VJpw0RtBeqMIXbLaqDGwjIymnIvQIePgiJSvk+8nQE4RzMp8saSpN1B6r
   ZuDrdx2LUbNCnsPZrX6ihAyj8hwkX2S/i8tOm4OfJIcfYmpBO6JD/DXaI
   n86vU2wNQfe96itdY7f/MVGGGOnUauCiiGujvl8FRKALnIKVvP+7lOLI+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="459969201"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="459969201"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:37:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="846266293"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="846266293"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:37:47 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
	Greenman@web.codeaurora.org, Gregory <gregory.greenman@intel.com>
Subject: [PATCH 04/15] wifi: mac80211_hwsim: Add custom reg for DFS concurrent
Date: Wed, 20 Dec 2023 04:37:52 +0200
Message-Id: <20231220043149.9fed2ad31759.Ic285ca7a4728e77a4bea1394a6a52cf286fbea22@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220023803.2901117-1-miriam.rachel.korenblit@intel.com>
References: <20231220023803.2901117-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>

Add custom regulatory that marks DFS channels as DFS_CONCURRENT.

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Reviewed-by: Greenman, Gregory <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index c7b4414cc6c3..3816b0d335f0 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -190,10 +190,25 @@ static const struct ieee80211_regdomain hwsim_world_regdom_custom_03 = {
 	}
 };
 
+static const struct ieee80211_regdomain hwsim_world_regdom_custom_04 = {
+	.n_reg_rules = 6,
+	.alpha2 =  "99",
+	.reg_rules = {
+		REG_RULE(2412 - 10, 2462 + 10, 40, 0, 20, 0),
+		REG_RULE(2484 - 10, 2484 + 10, 40, 0, 20, 0),
+		REG_RULE(5150 - 10, 5240 + 10, 80, 0, 30, 0),
+		REG_RULE(5260 - 10, 5320 + 10, 80, 0, 30,
+			 NL80211_RRF_DFS_CONCURRENT | NL80211_RRF_DFS),
+		REG_RULE(5745 - 10, 5825 + 10, 80, 0, 30, 0),
+		REG_RULE(5855 - 10, 5925 + 10, 80, 0, 33, 0),
+	}
+};
+
 static const struct ieee80211_regdomain *hwsim_world_regdom_custom[] = {
 	&hwsim_world_regdom_custom_01,
 	&hwsim_world_regdom_custom_02,
 	&hwsim_world_regdom_custom_03,
+	&hwsim_world_regdom_custom_04,
 };
 
 struct hwsim_vif_priv {
@@ -5288,6 +5303,10 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 		schedule_timeout_interruptible(1);
 	}
 
+	/* TODO: Add param */
+	wiphy_ext_feature_set(hw->wiphy,
+			      NL80211_EXT_FEATURE_DFS_CONCURRENT);
+
 	if (param->no_vif)
 		ieee80211_hw_set(hw, NO_AUTO_VIF);
 
-- 
2.34.1


