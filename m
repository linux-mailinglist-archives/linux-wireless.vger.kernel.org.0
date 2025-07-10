Return-Path: <linux-wireless+bounces-25209-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD415B00B61
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 20:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AFCD1895078
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 18:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE692FCFE0;
	Thu, 10 Jul 2025 18:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RtTufAE/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C592FCFD5
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 18:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752172141; cv=none; b=ckHXnFFI5PCG2vvcY0YNYVzvVSayM3NGXLx//QJRA64S8SMOwN/cgSiW55X/JVZmLsvK3ZkpL+KEXZB5BPsLu65QKHIj2yAbn/SmAThIL10jo9R/F9PW0Niomvj2gxAIpPQzbh+42UpZRtmvRbEdlj6FwQF/YtpNldD5jZ3G/VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752172141; c=relaxed/simple;
	bh=Njf+OIj0IFC+myOAf0x+ING3U18GuCWRFGzaeufbYy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aWY0aMuKj3EnwdOLVtbbLCQZ0mhWSkNZ6msb5MOMptErjzxFNjoZxyppXKy6A0lK6WEBuDTQd+Xogd9tQkMvhG15GQMnMSNnORaO1GG5zhy968+g0PadzMXR3PVIh1qenADWnva0nv6byblIjFSe7P7qaWy/kXrd/HJIJH76jHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RtTufAE/; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752172140; x=1783708140;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Njf+OIj0IFC+myOAf0x+ING3U18GuCWRFGzaeufbYy0=;
  b=RtTufAE/YTnt7FHq79cizoZvUIppeUVtpLk5KCl0alMbyIZ5b3eXcmov
   TmCm9kqdn3Q5LvmXwwmcP3dKzfObyHrEs31m/3ZPK3L3oss2zgSZHYiRI
   m2otjg8FmB2MVUclxgPS6TRc0ZVqwXVf+qfNL6laGT7X0Gp57oZmsIdHg
   uP4cubq256P4LlczvGAkMn9zwqSZiJshoIhOwvvfyAj6FG5wYlNLWvJgq
   YI5o41TiKr2ptlcSf0HM6UQRI99LljPNztMhTRVKyeQT29KEk0CMnCFZi
   VHASH5d2z90Hfuv/aRyafaZ4SBBnLIe43SQqBacf6nRr2dcnjILT0lvxx
   A==;
X-CSE-ConnectionGUID: amT5bcc7Q7GDn3JP72TuGg==
X-CSE-MsgGUID: QJVai+4+Qt62SppnGvi/qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="57077793"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="57077793"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 11:29:00 -0700
X-CSE-ConnectionGUID: UVn2aTzfQoSbqvRoM3O7BQ==
X-CSE-MsgGUID: CUQslETQRBeBEhZmtAbq8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="160718714"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 11:28:58 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 05/15] wifi: iwlwifi: mld: restrict puncturing disable to FM
Date: Thu, 10 Jul 2025 21:28:22 +0300
Message-Id: <20250710212632.6fa9c44964c1.I46a4cd744a769ec2ac3c8f9a04882140449394b8@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710182832.2615019-1-miriam.rachel.korenblit@intel.com>
References: <20250710182832.2615019-1-miriam.rachel.korenblit@intel.com>
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


