Return-Path: <linux-wireless+bounces-16868-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA779FDF45
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Dec 2024 15:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47C3C18821D1
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Dec 2024 14:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043D013B280;
	Sun, 29 Dec 2024 14:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GI+0Q2os"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465F133062
	for <linux-wireless@vger.kernel.org>; Sun, 29 Dec 2024 14:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735483518; cv=none; b=FOW4gNHiKXqV0wAg36w1gGF/Lx/YKkq8TtD5IyPnABSpFAkPklGjBltLSlNl0QDYcvC6u2Jwg9g7ch48IsMnLUbmkPMTQOdT9AtMWGBE/AhHGXMtIM7xzFC+nj8EuIFsChmdnhI5b6k35i8EIjR8IE5oyGu8ZDf9Ab9XIV7qb3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735483518; c=relaxed/simple;
	bh=ZC5pRzfuRIux8chj7mLzqB4WGR19U8Fd9ysW8qsUGfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HXR8T+SYIX1QGlQEOPT8lacItlYG4HSsbShglvfyEewUJIpBticxOtEgHCWz8ZJPz6Ob/dLgj/4mdF1QVbKVVvZOsoe9C4aAd6fIwsQPlta9T09L0/Vcwrc8S6YSrAxo8yv9OfynIZFfcUNzNLnw71Feuh9dTK47CwudETfVop8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GI+0Q2os; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735483518; x=1767019518;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZC5pRzfuRIux8chj7mLzqB4WGR19U8Fd9ysW8qsUGfQ=;
  b=GI+0Q2osy5Xt37mqELmPZr9EcLJBPc2WhEZFaJiztnvPaN5d9pl9SjAT
   KfJydnLumgz2cFT6ELrxJXzoUwwr9dX8IWCNZxeXHLcy0cng0Jdv+ck46
   OAa1MiIQKu2Ty5+JVpIAg66Je9XbjhLQqLvvVdg/CaryM4OVpJ3Ot6Ybz
   pU5YtIWTgk8pDyqEQ77h83AplF+EnGmifR5qmSJon4RLiu3jBiBbt5Nb3
   BFVcTIZEOQA9d5kreYpZOo/cpdfOVxPvqWwmqxcYrGnprwlptMXpoKjTR
   VvlPfvEuKJovE9YtiD1J/cGlBb/noRKWq/P8Y86+Eq7RjK+kZGoX2D+6D
   A==;
X-CSE-ConnectionGUID: lqH5eD+gTBiX3Ykyiq/JDg==
X-CSE-MsgGUID: 7ZUBsqxWShixB0w0TzAEDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="39572441"
X-IronPort-AV: E=Sophos;i="6.12,274,1728975600"; 
   d="scan'208";a="39572441"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 06:45:17 -0800
X-CSE-ConnectionGUID: 7JUms/FURWKI7Os+FEu0xQ==
X-CSE-MsgGUID: h0YUmCpuSJ28pdob7+QaWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="105656923"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 06:45:15 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 07/17] wifi: iwlwifi: mvm: remove unneeded NULL pointer checks
Date: Sun, 29 Dec 2024 16:44:42 +0200
Message-Id: <20241229164246.c8ce6e041e4b.I4dc19289e3f3807386768c846e08be3ea322cd15@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241229144452.3151163-1-miriam.rachel.korenblit@intel.com>
References: <20241229144452.3151163-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Smatch reported that we dereference the data pointer to calculate the
expected length before we check it's not NULL. While this is true (and
hence needs to be fixed), this will never happen because the data
pointer comes from struct iwl_rx_packet object which has the following
layout:

struct iwl_rx_packet {
        __le32 len_n_flags;
        struct iwl_cmd_header hdr;
        u8 data[];
} __packed;

So, if the pointer to iwl_rx_packet is valid, data will be valid as
well.

Remove the NULL pointer check on 'data' to avoid confusing smatch.
Also remove the check from similar functions in the same flow that were
cargo cult copy-pasted.

Fixes: 4635e6eaa0fe ("wifi: iwlwifi: mvm: support new versions of the wowlan APIs")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202411210812.0eLaonw3-lkp@intel.com/
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index cbb09389f3bf..6dd2729d9781 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2491,12 +2491,6 @@ static void iwl_mvm_parse_wowlan_info_notif(struct iwl_mvm *mvm,
 	u32 expected_len = sizeof(*data) +
 		data->num_mlo_link_keys * sizeof(status->mlo_keys[0]);
 
-	if (!data) {
-		IWL_ERR(mvm, "iwl_wowlan_info_notif data is NULL\n");
-		status = NULL;
-		return;
-	}
-
 	if (len < expected_len) {
 		IWL_ERR(mvm, "Invalid WoWLAN info notification!\n");
 		status = NULL;
@@ -2548,12 +2542,6 @@ iwl_mvm_parse_wowlan_info_notif_v4(struct iwl_mvm *mvm,
 	u32 i;
 	u32 expected_len = sizeof(*data);
 
-	if (!data) {
-		IWL_ERR(mvm, "iwl_wowlan_info_notif data is NULL\n");
-		status = NULL;
-		return;
-	}
-
 	if (has_mlo_keys)
 		expected_len += (data->num_mlo_link_keys *
 				 sizeof(status->mlo_keys[0]));
@@ -2602,12 +2590,6 @@ iwl_mvm_parse_wowlan_info_notif_v2(struct iwl_mvm *mvm,
 {
 	u32 i;
 
-	if (!data) {
-		IWL_ERR(mvm, "iwl_wowlan_info_notif data is NULL\n");
-		status = NULL;
-		return;
-	}
-
 	if (len < sizeof(*data)) {
 		IWL_ERR(mvm, "Invalid WoWLAN info notification!\n");
 		status = NULL;
-- 
2.34.1


