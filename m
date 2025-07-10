Return-Path: <linux-wireless+bounces-25192-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 821AAB00955
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 18:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EDD25C5101
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 16:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC99125B1D2;
	Thu, 10 Jul 2025 16:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mT0YcZhy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0333F2F0027
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 16:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752166519; cv=none; b=UHzb8z44nmLtfd/bFXVPWmHxFnLBCGjolADD+f0t9xDUjIa47b5fa4IDS73VeQuXpFhMk902GOa2qAtcwYN96H9LY8GzVLbB69ePE4mswQIV7H3ZeBL591uo4XKWe+1oYucw5dOdgTdG6v8Oke03Kf01nyfAy2nHF0TzM66QrSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752166519; c=relaxed/simple;
	bh=Njf+OIj0IFC+myOAf0x+ING3U18GuCWRFGzaeufbYy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KP+zn9xpFrtmJnvmEAbXcWZlmh9RMTYy5unDuZuWheD9DhdTlMWG/Z3q9TMjhPJ1sQMtudFNonBGsxW4yrrKBKX1bugHvwwEh8Hk0T8i8yPV1qIgHJc0LaTi5j+MNIscJrqvjgjNOM9EfHYrt/y6C6qxNULq6TDRRpXVgzir0mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mT0YcZhy; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752166518; x=1783702518;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Njf+OIj0IFC+myOAf0x+ING3U18GuCWRFGzaeufbYy0=;
  b=mT0YcZhyho/s23TJG6kTNdHYt7xz+fXTtgxvpsJQbB5hzxnFXi+Gcye3
   CSPQM/MhPWSEzqkUFtpaskWkfnbW0F/J4UnJJlibqNeJG08oSmijJ5tKj
   EZ2TYY8/5+AejWwgemCkSx/MYm8m7gCZCOd7U5VL8CDmojUZfWHJ0Zlu5
   iuusBtQGEZ+EegHFXigzKgWiKqBFrFaqFgf6dwIstTfI68/BA9J6Fk1p4
   WAoVN5vJjqmoT666aQxuUVB62s9CAM2Tuz68mE4GlyYN1RSWHyOhfZ6wB
   30nmNEm8xKuBBRtEbKfajcIk1KpyifsvlNB65Azd4lEfKXjKqrDj+96AJ
   Q==;
X-CSE-ConnectionGUID: dnj3KLYsQ0umDq7n5P6vHQ==
X-CSE-MsgGUID: E6iXV6CZRimWZfoK/iAxIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54609998"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="54609998"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 09:55:17 -0700
X-CSE-ConnectionGUID: BQ+hiAzXRzyIP7q4LlaFzQ==
X-CSE-MsgGUID: TORwXiqORySGL0ukwR6NXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="156277023"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 09:55:15 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 05/15] wifi: iwlwifi: mld: restrict puncturing disable to FM
Date: Thu, 10 Jul 2025 19:54:38 +0300
Message-Id: <20250710195219.6fa9c44964c1.I46a4cd744a769ec2ac3c8f9a04882140449394b8@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710165448.2553296-1-miriam.rachel.korenblit@intel.com>
References: <20250710165448.2553296-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Later RFs will always do puncturing, regardless of BIOS
configuration, and earlier RFs aren't supported in MLD.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mcc.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mcc.c b/drivers/net/wireless/intel/iwlwifi/mld/mcc.c
index 19cb562e7a73..680abda95adb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mcc.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mcc.c
@@ -177,11 +177,15 @@ iwl_mld_get_regdomain(struct iwl_mld *mld,
 
 	mld->mcc_src = resp->source_id;
 
-	if (!iwl_puncturing_is_allowed_in_bios(mld->bios_enable_puncturing,
-					       le16_to_cpu(resp->mcc)))
-		ieee80211_hw_set(mld->hw, DISALLOW_PUNCTURING);
-	else
-		__clear_bit(IEEE80211_HW_DISALLOW_PUNCTURING, mld->hw->flags);
+	/* FM is the earliest supported and later always do puncturing */
+	if (CSR_HW_RFID_TYPE(mld->trans->info.hw_rf_id) == IWL_CFG_RF_TYPE_FM) {
+		if (!iwl_puncturing_is_allowed_in_bios(mld->bios_enable_puncturing,
+						       le16_to_cpu(resp->mcc)))
+			ieee80211_hw_set(mld->hw, DISALLOW_PUNCTURING);
+		else
+			__clear_bit(IEEE80211_HW_DISALLOW_PUNCTURING,
+				    mld->hw->flags);
+	}
 
 out:
 	kfree(resp);
-- 
2.34.1


