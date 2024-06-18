Return-Path: <linux-wireless+bounces-9212-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E975990D9BC
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 18:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CB6E1C20A0B
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 16:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31350152164;
	Tue, 18 Jun 2024 16:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LF2pbDxB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966A01442F5
	for <linux-wireless@vger.kernel.org>; Tue, 18 Jun 2024 16:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718729082; cv=none; b=rI24Rnm6G16dRaR6LLbKbN+5BbkoMgQS6uKxM1QmEc/svhdmUiYFQQkidmk8RkpRE8NjsXZuUKHc4S03uBMuLDzznCbC8WUpcZ479paX3LNMaHSHBIqs5e+90aM72iUEyLE+Tbyt+h7Lwri7KhrX0TD2sK7f/cJdNWQH6cvboXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718729082; c=relaxed/simple;
	bh=qZ6o2wBujyHW31PDxWJJbFd1QnIAOTUd0Ggvs7sHMeE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uCqeWwNKaXaa/K+BVgkaClCU4UHm9ZW3a8QQ5xgQ6ecI3pNuhSx8KJCiIgORtnoX0OFa+fhYtmAcieBKhnAi9YpHRW+6zfgvgYohuqR8EgM2NOCuYcOI1vQfPsViYrKOFCDqhJJL3lFoXRbt77csIo384/hU84dVITwMJuFjAqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LF2pbDxB; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718729080; x=1750265080;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qZ6o2wBujyHW31PDxWJJbFd1QnIAOTUd0Ggvs7sHMeE=;
  b=LF2pbDxBFlJP/594IgxpL9waJzMpHTEG1t+EgyqGAahoiOnTHfm/KSNJ
   oMERYqgKaojPCozOHkYOu8m75F2EXgsk1HIzBNwxW/be0cPKoW+isIg50
   no4AlUo8WrRTHM1G51lqgl++/bbbtAU3pBOpXPmnjnu+iNZSNUVtefJyn
   PMhvTkSgoF/Tr8dYhLIb4jLUc+IbqBR/jzW+g9Yh4s8yYqYXO1Pbv7/xY
   2v24iqMPafWKdZPNLYigLLlpDfVQbbHhJ8Kc5WUX/nd8GuYw1Wr4pwpC3
   eAjxB/ku72pFnFCmdPPuIeZqys9phtRXl6vz6XzSUe93gkU9sZbq4THQf
   w==;
X-CSE-ConnectionGUID: jgDT35HmS4alnE2lIizfDQ==
X-CSE-MsgGUID: C07QulkWTduDASQiyzYbZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="26257216"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="26257216"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 09:44:40 -0700
X-CSE-ConnectionGUID: cFkoLQKnTgOJZCIreKoPpQ==
X-CSE-MsgGUID: vmYRWGgeRHCjdGRMgGu+GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="42306558"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 09:44:39 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 11/11] wifi: iwlwifi: mvm: enable VLP AP on VLP channels
Date: Tue, 18 Jun 2024 19:44:13 +0300
Message-Id: <20240618194245.e15f24fc6bc8.I33ed7d141fec731e79370ba6c7cfbe28776944a0@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618164413.2416719-1-miriam.rachel.korenblit@intel.com>
References: <20240618164413.2416719-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If channels are marked VLP, then we're actually also
allowed to be VLP AP/GO. Enable this.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 712dabb30acc..c2656dee5a86 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -370,7 +370,9 @@ static u32 iwl_get_channel_flags(u8 ch_num, int ch_idx, enum nl80211_band band,
 		flags |= IEEE80211_CHAN_IR_CONCURRENT;
 
 	/* Set the AP type for the UHB case. */
-	if (!(nvm_flags & NVM_CHANNEL_VLP))
+	if (nvm_flags & NVM_CHANNEL_VLP)
+		flags |= IEEE80211_CHAN_ALLOW_6GHZ_VLP_AP;
+	else
 		flags |= IEEE80211_CHAN_NO_6GHZ_VLP_CLIENT;
 	if (!(nvm_flags & NVM_CHANNEL_AFC))
 		flags |= IEEE80211_CHAN_NO_6GHZ_AFC_CLIENT;
@@ -1661,7 +1663,9 @@ static u32 iwl_nvm_get_regdom_bw_flags(const u16 *nvm_chan,
 
 	/* Set the AP type for the UHB case. */
 	if (uats_enabled) {
-		if (!(nvm_flags & NVM_CHANNEL_VLP))
+		if (nvm_flags & NVM_CHANNEL_VLP)
+			flags |= NL80211_RRF_ALLOW_6GHZ_VLP_AP;
+		else
 			flags |= NL80211_RRF_NO_6GHZ_VLP_CLIENT;
 
 		if (!(nvm_flags & NVM_CHANNEL_AFC))
-- 
2.34.1


