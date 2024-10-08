Return-Path: <linux-wireless+bounces-13672-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAD9993DF8
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 06:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED09DB24A62
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 04:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A487A13C3CD;
	Tue,  8 Oct 2024 04:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NoxecGie"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229251369B6
	for <linux-wireless@vger.kernel.org>; Tue,  8 Oct 2024 04:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728361555; cv=none; b=AUZ6J0CU5fpSgrvyEH5aWkiAfRj80YnQGyoaD+v7lF6aDOOoumisq7AWOCjKCAbN03Fh2BQcUcPGncKVrBeD6DTtdc21HTit9WrgYr/ZHRzb6+GDgAI7etaVN00EI1rsI6MdJ7dR2a09JfSlalmLcugnt6pi3EHB/w/+fv2u95A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728361555; c=relaxed/simple;
	bh=zrOhAFBVSPLXoTK8bTtox4ymEp/1RUxAlkEFjdmSTUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PQLBBuAL6hO9/uZTRr2YCGumGuE+CezU95ZMzetP+uo9Yp5O3aUwdLiSn06CFJxC0EOQ+rMOWv+OJivYD0oJaXJ6rsvMB7GywcOjSEUIN00jk3vz3aGP1miQhCrpTB9PGlrzxf7Op9rGhZS9FtJvFMM8vACrqfs2HCMDtVT43rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NoxecGie; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728361554; x=1759897554;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zrOhAFBVSPLXoTK8bTtox4ymEp/1RUxAlkEFjdmSTUA=;
  b=NoxecGiek95wI5WM6MXDqlLXJTzPGFLhpuoLrEGfkgCAUEIBDRgpCZE9
   57ho9Faj1VkuGRmvXkiHmB7beH+2BAFCvVPXX3DYZiQG8f+y1WVIoyHjg
   KWIVsRkVNH6r2yR0+duTE1OPu1JGjvcgqKiEjUOKzSp/IDaOG1umrsEyy
   MgXzH7p8CBqHla3oqDpKqZ7T205U9zbU3TOI8+R5cvSeSX62JPC/pgopy
   Gr6LM/8GGzi3rNjQ4LC1d1OmxWSAZIr88pc5SWiHpouHnCC6I6pjxS/kD
   Feej7W7lRDT6fPcQpVEaIdqSNB6XhrO36LE1Q7Tfiejrkknrn5ZFZVRZ4
   Q==;
X-CSE-ConnectionGUID: StBi8yBKQfGsZTE7+GXQjw==
X-CSE-MsgGUID: +1a8QugaQ+my9kdjGeGcKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="27024288"
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="27024288"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 21:25:54 -0700
X-CSE-ConnectionGUID: ttwy4XfvTkCe/+hD6g/J/w==
X-CSE-MsgGUID: wWaa1d28RhyqBnysDlMylQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="80486366"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 21:25:53 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 09/14] wifi: iwlwifi: mvm: remove unneeded check
Date: Tue,  8 Oct 2024 07:25:23 +0300
Message-Id: <20241008072037.78b0adbb7b50.I630a64f06ca86baecde6a2a238733b7df3cf70e4@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008042528.2549752-1-miriam.rachel.korenblit@intel.com>
References: <20241008042528.2549752-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

When checking if extra LTF should be disabled, we don't need to check the
the HW revision.
sband_eht_cap will be NULL if eht_capa::has_eht is false,
and that will be the case for the HWs that don't support EHT.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index 05715e5af6ab..a0c088efd240 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -615,11 +615,8 @@ void iwl_mvm_rs_fw_rate_init(struct iwl_mvm *mvm,
 	int cmd_ver;
 	int ret;
 
-	/* Enable external EHT LTF only for GL device and if there's
-	 * mutual support by AP and client
-	 */
-	if (CSR_HW_REV_TYPE(mvm->trans->hw_rev) == IWL_CFG_MAC_TYPE_GL &&
-	    sband_eht_cap &&
+	/* Enable extra EHT LTF if there's mutual support by AP and client */
+	if (sband_eht_cap &&
 	    sband_eht_cap->eht_cap_elem.phy_cap_info[5] &
 		IEEE80211_EHT_PHY_CAP5_SUPP_EXTRA_EHT_LTF &&
 	    link_sta->eht_cap.has_eht &&
-- 
2.34.1


