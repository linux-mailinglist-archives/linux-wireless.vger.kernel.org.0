Return-Path: <linux-wireless+bounces-25827-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C80B0D4A8
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 10:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C5673AA877
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 08:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3132D8DAE;
	Tue, 22 Jul 2025 08:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KcCk7mUL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC282D878A
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 08:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753172989; cv=none; b=qeJ5+Wi/HZR3Izx6/r2WArS3ZPButFCEoZUUkEk34N+wAq8lUzmX6Ll3l6I6oGfstPAc00My7J7dATZIa9PiL6H96Oq35PVgbPYFKqMxWNFXGgQMXfEP5I/Qi//bEbxURkrwr+NHBRw9pztd+yPTYTdPqKvkYXeUPoWrOMDyPTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753172989; c=relaxed/simple;
	bh=lBwxqVxj/4g3ddTDPdNMNDaK82bIM5ZijsUq8Xx3CdA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FN2ckLRZ5xyEmm0f3EoB2iLCLX8H9ypu0oxjt2em0pdtQHrKY2Z/RjI2u7fTaM0HyOKrEXvUXopY2w4D7eGn1y0nDn3gNQqo0ILygbBeVuXPCYdhrVIVZKAkMR51oEg77O3DTqMc7ParZXSQdUVANE54i2SgbWryUNEQ2LpAbYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KcCk7mUL; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753172988; x=1784708988;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lBwxqVxj/4g3ddTDPdNMNDaK82bIM5ZijsUq8Xx3CdA=;
  b=KcCk7mULgFLFaBTmr+JpAxIfLVHVdVWeLCtHapUu8WcmsGYDjU7ytwPe
   tQGBbzq4bqKvKZWskGSRHxD2wjbBQWjqorBWzVGjPpyMrKXnxALN/oImT
   dXrsfIwyeirFSwQ4/VoKqhJs+LBxjDrsDb2A4VlNQAT540Oz2NsYfjvgD
   nDVqAdH01+mR+yP1MZ+rQUOtUfkPxZmomHtoGC0Qka4QXgIsWDNG0mZY6
   SYPajkh312aaj7bflOCgG4Q0RZzph0lJu0twqTHUw3NSSbFnKd6T9C2fB
   jxJ9tmXxYwjQQ5hcONg9+roSrSXb6evwK2VyQAz/IgcLlgTSs8rLUdndM
   Q==;
X-CSE-ConnectionGUID: zxomD/pqSNOOPoCa+Hktgg==
X-CSE-MsgGUID: TJO5NKzYRjuk6dF90zu/Tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="55569952"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="55569952"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 01:29:48 -0700
X-CSE-ConnectionGUID: R2qw5MIITsi8+ZZaSpIq8g==
X-CSE-MsgGUID: 7braItW1R0ml2R9I+sslWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="163124305"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 01:29:46 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Daniel Gabay <daniel.gabay@intel.com>
Subject: [PATCH iwlwifi-next 12/15] wifi: iwlwifi: mld: decode EOF bit for AMPDUs
Date: Tue, 22 Jul 2025 11:29:07 +0300
Message-Id: <20250722112718.bd0b27832a87.I4db4abf348f7b6dfc75f869770dd77655a204bc7@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722082910.1206370-1-miriam.rachel.korenblit@intel.com>
References: <20250722082910.1206370-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

Only the EOF bit handling for single frames was ported to the MLD
driver. The code to handle AMPDUs correctly was forgotten. Add it back
so that the bit is reported in the radiotap headers again.

Fixes: d1e879ec600f ("wifi: iwlwifi: add iwlmld sub-driver")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Daniel Gabay <daniel.gabay@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/rx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/rx.c b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
index 3d19cec3f696..b6dedd1ecd4d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
@@ -1089,6 +1089,15 @@ static void iwl_mld_rx_eht(struct iwl_mld *mld, struct sk_buff *skb,
 			rx_status->flag |= RX_FLAG_AMPDU_EOF_BIT;
 	}
 
+	/* update aggregation data for monitor sake on default queue */
+	if (!queue && (phy_info & IWL_RX_MPDU_PHY_TSF_OVERLOAD) &&
+	    (phy_info & IWL_RX_MPDU_PHY_AMPDU) && phy_data->first_subframe) {
+		rx_status->flag |= RX_FLAG_AMPDU_EOF_BIT_KNOWN;
+		if (phy_data->data0 &
+		    cpu_to_le32(IWL_RX_PHY_DATA0_EHT_DELIM_EOF))
+			rx_status->flag |= RX_FLAG_AMPDU_EOF_BIT;
+	}
+
 	if (phy_info & IWL_RX_MPDU_PHY_TSF_OVERLOAD)
 		iwl_mld_decode_eht_phy_data(mld, phy_data, rx_status, eht, usig);
 
-- 
2.34.1


