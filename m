Return-Path: <linux-wireless+bounces-23867-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A119AD2576
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 20:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C3413AFA87
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 18:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E68021CC5A;
	Mon,  9 Jun 2025 18:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LNrWK0tg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED77121CA14
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 18:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749493319; cv=none; b=Ark0gE1/VWfbB4+Civ7RnIUry6UKldEuprkR6cX2KYFL+How1owaJe8jDmlEOs7U7V8j/xLeeSBVjCMBv989h2lbGsb9M/tXKfsAzpt1oVqKlPLpfsU8TmpPMiLjMKzkGr4wrrmtFzjX6YSzOGZVidwcVQA/8yhLAFw8oOel0CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749493319; c=relaxed/simple;
	bh=jI/EMHOL9jDiBrDUK8hnsP4ssKNQRkPjNil3bI+doHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dYhVaKokCwkQ6jBBSIwj8YphpGBSZgfSl8P+EJMsck5BdrXh3CmeHTRdh0hZzvBje7wQVBXRHW1JEIG9thAKqUol9P66+052Z8y0YbaTJIV83Z4TCmouCrbEJ8nnqeHbTn80MQGmRXUIRRUEq3DZPqVs2vGzfiBPwkhK3uFTMwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LNrWK0tg; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749493318; x=1781029318;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jI/EMHOL9jDiBrDUK8hnsP4ssKNQRkPjNil3bI+doHw=;
  b=LNrWK0tgPRrKgXoj+4ux0bDanPx2/xeLkvawyjfNth0lrMfQaXzs0gk9
   D3Pi1t/io7KgGWuXQfyQRq78k4JmVZQpz6VnmizrkAI34YVeXoze4MTT5
   r3a1/k2GMZlMrkApG/O6UcSSsgcCL2WuLbF4oDqsrUE3pNe9Pk6Gd93wt
   hT7tSOMRuVU/9vuCDbUYh/chPI7Sk5jxPLtiT1ycLct+BYjysA2xlssdW
   DeX/2wKG1rFH/lEAWrB4xysygzbF6Rjj/ALTP10XJP5U97gdGqxruBw5K
   PfMWfY2cLMJGNkhNwhcjaWzzaGw0LaMXQp8DuL3/zLWKYT+qJvpbxIeW5
   w==;
X-CSE-ConnectionGUID: 8FeqG+pCSNyuwFNYfYrP6Q==
X-CSE-MsgGUID: 6Q6Vn3WXToafzFrk4nObEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="62237686"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="62237686"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:21:57 -0700
X-CSE-ConnectionGUID: /st1nbnDQVWVyBZctXLkVw==
X-CSE-MsgGUID: xzrAdMQsS0+BsVJT6pXBFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="146510316"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:21:56 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH iwlwifi-next 08/15] wifi: iwlwifi: parse VLP AP not allowed nvm channel flag
Date: Mon,  9 Jun 2025 21:21:14 +0300
Message-Id: <20250609211928.a433cb0ea0f3.Ifc6d7ba96d200dca0e3d38ec8d71625fd81a10ae@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250609182121.3886519-1-miriam.rachel.korenblit@intel.com>
References: <20250609182121.3886519-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

OEMs need the option to enable/disable VLP AP.
Add NVM flag to control VLP AP configuration.

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 41 +++++++++++--------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 0592f0f59d1c..56bac0a9755a 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -160,23 +160,26 @@ static struct ieee80211_rate iwl_cfg80211_rates[] = {
  * @NVM_CHANNEL_DC_HIGH: DC HIGH required/allowed (?)
  * @NVM_CHANNEL_VLP: client support connection to UHB VLP AP
  * @NVM_CHANNEL_AFC: client support connection to UHB AFC AP
+ * @NVM_CHANNEL_VLP_AP_NOT_ALLOWED: UHB VLP AP not allowed,
+ *	Valid only when %NVM_CHANNEL_VLP is enabled.
  */
 enum iwl_nvm_channel_flags {
-	NVM_CHANNEL_VALID                   = BIT(0),
-	NVM_CHANNEL_IBSS                    = BIT(1),
-	NVM_CHANNEL_ALLOW_20MHZ_ACTIVITY    = BIT(2),
-	NVM_CHANNEL_ACTIVE                  = BIT(3),
-	NVM_CHANNEL_RADAR                   = BIT(4),
-	NVM_CHANNEL_INDOOR_ONLY             = BIT(5),
-	NVM_CHANNEL_GO_CONCURRENT           = BIT(6),
-	NVM_CHANNEL_UNIFORM                 = BIT(7),
-	NVM_CHANNEL_20MHZ                   = BIT(8),
-	NVM_CHANNEL_40MHZ                   = BIT(9),
-	NVM_CHANNEL_80MHZ                   = BIT(10),
-	NVM_CHANNEL_160MHZ                  = BIT(11),
-	NVM_CHANNEL_DC_HIGH                 = BIT(12),
-	NVM_CHANNEL_VLP                     = BIT(13),
-	NVM_CHANNEL_AFC                     = BIT(14),
+	NVM_CHANNEL_VALID			= BIT(0),
+	NVM_CHANNEL_IBSS			= BIT(1),
+	NVM_CHANNEL_ALLOW_20MHZ_ACTIVITY	= BIT(2),
+	NVM_CHANNEL_ACTIVE			= BIT(3),
+	NVM_CHANNEL_RADAR			= BIT(4),
+	NVM_CHANNEL_INDOOR_ONLY			= BIT(5),
+	NVM_CHANNEL_GO_CONCURRENT		= BIT(6),
+	NVM_CHANNEL_UNIFORM			= BIT(7),
+	NVM_CHANNEL_20MHZ			= BIT(8),
+	NVM_CHANNEL_40MHZ			= BIT(9),
+	NVM_CHANNEL_80MHZ			= BIT(10),
+	NVM_CHANNEL_160MHZ			= BIT(11),
+	NVM_CHANNEL_DC_HIGH			= BIT(12),
+	NVM_CHANNEL_VLP				= BIT(13),
+	NVM_CHANNEL_AFC				= BIT(14),
+	NVM_CHANNEL_VLP_AP_NOT_ALLOWED		= BIT(15),
 };
 
 /**
@@ -1685,10 +1688,12 @@ static u32 iwl_nvm_get_regdom_bw_flags(const u16 *nvm_chan,
 	}
 
 	/* Set the AP type for the UHB case. */
-	if (nvm_flags & NVM_CHANNEL_VLP)
-		flags |= NL80211_RRF_ALLOW_6GHZ_VLP_AP;
-	else
+	if (nvm_flags & NVM_CHANNEL_VLP) {
+		if (!(nvm_flags & NVM_CHANNEL_VLP_AP_NOT_ALLOWED))
+			flags |= NL80211_RRF_ALLOW_6GHZ_VLP_AP;
+	} else {
 		flags |= NL80211_RRF_NO_6GHZ_VLP_CLIENT;
+	}
 
 	if (!(nvm_flags & NVM_CHANNEL_AFC))
 		flags |= NL80211_RRF_NO_6GHZ_AFC_CLIENT;
-- 
2.34.1


