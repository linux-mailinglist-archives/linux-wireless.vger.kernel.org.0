Return-Path: <linux-wireless+bounces-8130-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D69A8D0800
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 18:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0541D1F215A3
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 16:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B2116ABEB;
	Mon, 27 May 2024 16:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XvhfOLJK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3295616A399
	for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 16:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716826008; cv=none; b=h7A25UKj2RR8KbSg6YtOB9yMVmXI/v5/BeMDJwIF4jaRcjGULL/nUQMAF597uTWMwsluVNHDIlqkLc7pOmOFDrpOXicSvevCRIyOLeXHD9WxFT/CWF35HjfebySbxtuf4hdT/X9upzYAOhYL6P4aLKAFgJFLPfFZlJb6HLc8s94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716826008; c=relaxed/simple;
	bh=znVBTYtF+pt5O46QjnYGcwyoV78Uaec6desSDNbVHdg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u1rAetOnl8mRA4buZlFbp3Dk+9+7iOqQRqgJhSZD96zOjJuz1/JBZILQe+2pu6HyhBDeU8GMkD1EKiZ1U3cT87yR4Aox/Hw5gT94u45zuMQNoc62tpNhMkj4KlhWN1WzNzoNhzZzfhx4+8ozPATNyTbKKedYnegvmLkLhrdEznA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XvhfOLJK; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716826008; x=1748362008;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=znVBTYtF+pt5O46QjnYGcwyoV78Uaec6desSDNbVHdg=;
  b=XvhfOLJKYgn0qv0L1zanDI2RbrYVbe2ndgVBFV8YsPjQB+rtlxCd1Hh0
   QNyESl4U+5ZeWTUAG88x+DNvRy/qt8q/dA3oSH3mn6y95HNRqJyXzrG0g
   p0gIV7Ps+1q0ybbL90ijv2eJSsYIzMU8kFTIZaQW0BIWwbbOvA54qntpv
   ER3gcfzYwtlk31I6MZjVH8aU+AmE9FkX6MSpR0SWleD9zG/eJn7ON4NQX
   LlKzotCw4z/96gkLSfuzacpdavrIQ8nwG09yqve68nrZce1sXDkXjN/2a
   zLXUuNuItmNJ/Xvo9uSinXRALe6USiqlsAO8n/btGMWifOKDLHdrWGoDB
   Q==;
X-CSE-ConnectionGUID: D5Ejhbp9RUyp7X0OZn850A==
X-CSE-MsgGUID: K9QFlmSTRFygLvCufUal+w==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13002115"
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="13002115"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:06:47 -0700
X-CSE-ConnectionGUID: sMZ1sT5YSbKR+9K8TiQS5g==
X-CSE-MsgGUID: HaOHgFKsTguHOyy0AIQW3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="35407128"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:06:46 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 16/20] wifi: iwlwifi: mvm: declare band variable in the scope
Date: Mon, 27 May 2024 19:06:11 +0300
Message-Id: <20240527190228.b634d184980a.I9d9e71125f9a77ba4f9a33a7a2ff1e8e78e17767@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527160615.1549563-1-miriam.rachel.korenblit@intel.com>
References: <20240527160615.1549563-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

band is not used outside of the for loop, declare it inside it.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 5132964661c8..712dabb30acc 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -1730,7 +1730,6 @@ iwl_parse_nvm_mcc_info(struct device *dev, const struct iwl_cfg *cfg,
 	const u16 *nvm_chan;
 	struct ieee80211_regdomain *regd, *copy_rd;
 	struct ieee80211_reg_rule *rule;
-	enum nl80211_band band;
 	int center_freq, prev_center_freq = 0;
 	int valid_rules = 0;
 	bool new_rule;
@@ -1774,8 +1773,10 @@ iwl_parse_nvm_mcc_info(struct device *dev, const struct iwl_cfg *cfg,
 	reg_capa = iwl_get_reg_capa(cap, resp_ver);
 
 	for (ch_idx = 0; ch_idx < num_of_ch; ch_idx++) {
+		enum nl80211_band band =
+			iwl_nl80211_band_from_channel_idx(ch_idx);
+
 		ch_flags = (u16)__le32_to_cpup(channels + ch_idx);
-		band = iwl_nl80211_band_from_channel_idx(ch_idx);
 		center_freq = ieee80211_channel_to_frequency(nvm_chan[ch_idx],
 							     band);
 		new_rule = false;
-- 
2.34.1


