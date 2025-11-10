Return-Path: <linux-wireless+bounces-28771-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7D0C46BED
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 14:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B64FF4EAC74
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 13:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D534F30FC29;
	Mon, 10 Nov 2025 13:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dQnVrKln"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F5630F7FE
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 13:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762779759; cv=none; b=KPEHIsYi7oUilneBUUy+phVYDfW8/Zn5XZnwUJ6aILIq77f94XKTktDvQk/ZCmGLdOPW5nieLRb57n83YHIvR3AsQNP0jLyJ3AVm936XXDp16D7iFDCeLq8w/reI6JqYd24krDo1xFD1NAjIurEJI1dLCmAnG0vizzGch42vW/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762779759; c=relaxed/simple;
	bh=0sbwbYvwXItKwGSI9T86VMbmKxJrnk8HZ9zN59uQEl4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NcM7CXtQZ/Qx93xqBxLqusNt2OOJDgREavRP9xchrYpSHbKNzWHz3hTNR4vOy7RhBNdpfydZO5TtUEvEEeUM1fWFurLCfwQFFtKTfYlprKlcrIkGlFqTjTosbTLLgKHJA8l4CYnjyhj00A9a5d1D1xDq3I1bmZd2dFgiuT7STI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dQnVrKln; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762779758; x=1794315758;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0sbwbYvwXItKwGSI9T86VMbmKxJrnk8HZ9zN59uQEl4=;
  b=dQnVrKlnqnz8iH7+M19M5YB5nl3mH9H9FjPUx/xOonk5n2L+Z8bd/bo9
   yBFrjHGD3Q58CC4gjyYZXXYxJRCHDe+BfeFNhjx6FG2mTgPo/zGGql0gA
   TF66Oz1u8zFzAh9WbzM+XyurBOXlBYVshIMLiRleMavDxqOhBSaPNmbN2
   egqpmX5BilBtpkJyVjgHBt9idfVMiTWCBp+7BtTN+4gHzMG6C7Hh5BAcv
   9JPsn+ItL0H9mnPOcvLWm32/Ds706F+kf5NF/eXy8usCM74h+vCzardiV
   SO2T5Zxk0IizyMko9wTp4RoKrdzVzyH38boPGuMZi5KnHK4UvS0ViqkRO
   g==;
X-CSE-ConnectionGUID: chDQ+bMjSWiMkFqRlgWTQA==
X-CSE-MsgGUID: wsjBlFWmSkq0Rhu02o7jAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="82454876"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="82454876"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 05:02:38 -0800
X-CSE-ConnectionGUID: 2ND5wB8VTcSMkZaAQ7V2Wg==
X-CSE-MsgGUID: 1g1o1A4NRaaAVR4Llkoo2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="192928507"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 05:02:37 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 04/15] wifi: iwlwifi: mvm: check the validity of noa_len
Date: Mon, 10 Nov 2025 15:02:15 +0200
Message-Id: <20251110150012.99b663d9b424.I206fd54c990ca9e1160b9b94fa8be44e67bcc1b9@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110130226.223364-1-miriam.rachel.korenblit@intel.com>
References: <20251110130226.223364-1-miriam.rachel.korenblit@intel.com>
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

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 9c9e0e1c6e1d..4e8ebc0e875d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1768,6 +1768,20 @@ void iwl_mvm_probe_resp_data_notif(struct iwl_mvm *mvm,
 
 	mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
+	/*
+	 * len_low should be 2 + n*13 (where n is the number of descriptors.
+	 * 13 is the size of a NoA descriptor). We can have either one or two
+	 * descriptors.
+	 */
+	if (IWL_FW_CHECK(mvm, notif->noa_active &&
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


