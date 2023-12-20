Return-Path: <linux-wireless+bounces-1005-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F085818E64
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 18:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAD261C24869
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 17:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4375837D0A;
	Tue, 19 Dec 2023 17:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XdUdfOi3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4731B374F2
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 17:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703007685; x=1734543685;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gnzXdwlQ2Y0j8cOABdESAxsSj47dIvuCfe8Zkbn+oQw=;
  b=XdUdfOi3ALueTfODuxDwQyX5f3Zg6rewUkhCyiGk+MreS6H2pYGzAzK7
   kR8Ts3fxbLAuIAzOoooyo1rJII5nw0yLT7CEbpmCRjI7ZJjQingjAQ5/L
   i9xdUyDuVoYVsYtkrh+7ZGAioDE1fPpGMf3dfrlIdrdZ71eCKkLUfwYxz
   m12fkCGK9rorNN4b/yXUIEiWVaOtxcSY61V4CDS3R/5M+m+csE185/55R
   p74Vjdx0IKRDIWezj3/dH90HZaHGvmb096XB9Lwyqdgc+0rp9hnHPMB76
   JfgeceJc2yNAiTPBd/3gFvCksN83XVo/n+JqWoy2Hsdi1CZsF4I2oPLbZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="2790410"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="2790410"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 09:41:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="894370077"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="894370077"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 09:41:15 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 04/13] wifi: mac80211_hwsim: Add custom reg for DFS concurrent
Date: Wed, 20 Dec 2023 13:41:37 +0200
Message-Id: <20231220133549.4b08a6530fa3.Ic285ca7a4728e77a4bea1394a6a52cf286fbea22@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220133549.bdfb8a9c7c54.I973563562969a27fea8ec5685b96a3a47afe142f@changeid>
References: <20231220133549.bdfb8a9c7c54.I973563562969a27fea8ec5685b96a3a47afe142f@changeid>
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
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
v2: Fix wrong email addresses
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


