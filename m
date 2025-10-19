Return-Path: <linux-wireless+bounces-28061-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3203EBEE0EF
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 10:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D2CAD34A910
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 08:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F502BDC25;
	Sun, 19 Oct 2025 08:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mssx+2II"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B75B189F20
	for <linux-wireless@vger.kernel.org>; Sun, 19 Oct 2025 08:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760863539; cv=none; b=GxUdiMz+PvQLZTFPGX6QYLoJ3Co8HoTdjLqSf1gpor1WS8e711zw3+wpeBJcABAImFDzUebxTBbxdHXt9nc6m3W5bb5bDN3cBHAIAiJWm2kqYIpl9TYfGHrSm1/7iyZP6sEE2qz9W4TSDYnWYILrtcNUhAru6bA5CFpEBnHPUWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760863539; c=relaxed/simple;
	bh=sL0fy+PN/CiNgewjhpZX83Vs3NKsqjJAuDGPZCNI/mM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RxpDgm4a5po3Jq/apfSsv2FGqrcqyIfddBoe+wilPJh1cB11Ivt3P6M/XaKz2EouotlzQpmVRYgRPKvavUTWJwb+p26HFitBy1KdSnBtmP8xSGdGYNYoYCyo4YLEyhaFQmDAxDXIOuOn2u0WlhD7g3aUnLPza/2cey7Lzn+Yl3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mssx+2II; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760863538; x=1792399538;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sL0fy+PN/CiNgewjhpZX83Vs3NKsqjJAuDGPZCNI/mM=;
  b=mssx+2II1AsExO7JvrdzzBMdcI1mChXNTapXOSyaRoIr5zLhTvUJOKyp
   yVN9gZCD/TXHZj1KFzhVr3oM44RFq4ZD9kJ1ahbnLG0gsEgj/UON1AC/m
   jQdFtrbT25orNWW6gCkgh+L++miwsq3zYSgSCM+m4UsffN74wJBuzAWow
   CjPC8zBpU2DnXSc3oiZWBHoUo9QdFleBipST0OplarJfr4C/MbotolVCh
   6CmiwXRV0B/Nu+Hd77vgU1JYkH4Ju6bEwWkPohgy9I5Zlm6ufNzl+BpIb
   CiyXpvYbcIInwHJ41Jb/NNhdN0yBYfmTOVs9OgKNHGPA1KI12/Xrl7Uot
   A==;
X-CSE-ConnectionGUID: kl8kf5kASkmm4lAsMDeGDw==
X-CSE-MsgGUID: MeAD3uigTCittFaMhl1XEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74363184"
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="74363184"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:45:37 -0700
X-CSE-ConnectionGUID: sra6i41eSYGtdawrAn8xZQ==
X-CSE-MsgGUID: +2xCiHazTdihNofLFbiMzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="182279878"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:45:36 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 06/15] wifi: iwlwifi: mld: check the validity of noa_len
Date: Sun, 19 Oct 2025 11:45:07 +0300
Message-Id: <20251019114304.b127a2b57e8c.I7ccaf118d236fb39da5da351b95ad9b37b825bc2@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251019084516.2568208-1-miriam.rachel.korenblit@intel.com>
References: <20251019084516.2568208-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Validate iwl_probe_resp_data_notif::noa_attr::len_low since we are using
its value to determine the noa_len, which is later used for the NoA
attribute.

Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/iface.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.c b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
index ed379825a923..a5ececfc13e4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
@@ -528,6 +528,19 @@ void iwl_mld_handle_probe_resp_data_notif(struct iwl_mld *mld,
 
 	mld_link = &iwl_mld_vif_from_mac80211(vif)->deflink;
 
+	/* len_low should be 2 + n*13 (where n is the number of descriptors.
+	 * 13 is the size of a NoA descriptor). We can have either one or two
+	 * descriptors.
+	 */
+	if (IWL_FW_CHECK(mld, notif->noa_active &&
+			 notif->noa_attr.len_low != 2 +
+			 sizeof(struct ieee80211_p2p_noa_desc) &&
+			 notif->noa_attr.len_low != 2 +
+			 sizeof(struct ieee80211_p2p_noa_desc) * 2,
+			 "Invalid noa_attr.len_low (%d)\n",
+			 notif->noa_attr.len_low))
+		return;
+
 	new_data = kzalloc(sizeof(*new_data), GFP_KERNEL);
 	if (!new_data)
 		return;
-- 
2.34.1


