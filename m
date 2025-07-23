Return-Path: <linux-wireless+bounces-25903-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0413B0EAE2
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 08:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B15AE7B1972
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 06:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA5D271443;
	Wed, 23 Jul 2025 06:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PcmPTZuv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5947F270EDF
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 06:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753253155; cv=none; b=Z8nOtIv4w1Qkdnj/VqOMNot56pYzNMzSXy60PGIrIqT7YiJ0ry8fqT1lc24nS+Jr9cTW3lokbuN4f5FT1PKoBkD9YbCO8KVIcRgxoar6QjmPnDdH0rRWsI4BO/S8Ns8KBRBaNm0FPDik9PGpuIZLmZXsILIwzGW//gPOjNkBWjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753253155; c=relaxed/simple;
	bh=lBwxqVxj/4g3ddTDPdNMNDaK82bIM5ZijsUq8Xx3CdA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DJu3s8YV6dinEwyHSJo4RVRGDRcXM6hiYeGzDhJHAbkTu82Y0qh7UIfJRFo7AsA5C6DHJy1IbibRe5K7VdbvPc95+z+mIogAa/PsocATH3/NCqn5PpLvnPBOYiU6ZDRjFo33D6coynqKJcybostMP0hoLuBAnAzrTYYGPb4h1/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PcmPTZuv; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753253154; x=1784789154;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lBwxqVxj/4g3ddTDPdNMNDaK82bIM5ZijsUq8Xx3CdA=;
  b=PcmPTZuvPxNrJXrOdW5QlV4nZ/BI62OmQbAm++m1W+jWwH/bJmJgXfHV
   RKqlL729CDKCkXMSBu3uLaASXXzpqZ+zU0QVc2L/m8rKG9BIGUtTdcgII
   NR5f3ZMJs1/0jy1pf5vKWhQdIdUe6Bu+JtqyqykLvasW+prBHrvoyBpOL
   rLa7hTsxkNeDxkQa2W/TwyB+u3klUzW+i2rvFi4wqnUn9BbVonJsr/P63
   94mr7l8BEqfP/mZGucTa5ewAOCmJOuuCcY8OgEfPETF5luqlzTdOmkQp8
   aBPuVfgoalpZlQ8xqeAFV7Ie8LbQ0rnltGP4oj2coRVdQdDZ8LEcHGLlN
   w==;
X-CSE-ConnectionGUID: D4ytm/znSjueyUCoPCfqJg==
X-CSE-MsgGUID: x21lbhoFTyu8wAI8FsMs+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="59340774"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="59340774"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 23:45:51 -0700
X-CSE-ConnectionGUID: Y97KxZ7SRG6C2VaMz35Efg==
X-CSE-MsgGUID: tyTy18ASScetZiGNHUTvVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="159918104"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 23:45:49 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Daniel Gabay <daniel.gabay@intel.com>
Subject: [PATCH iwlwifi-next 10/14] wifi: iwlwifi: mld: decode EOF bit for AMPDUs
Date: Wed, 23 Jul 2025 09:45:11 +0300
Message-Id: <20250723094230.195be86372d5.I4db4abf348f7b6dfc75f869770dd77655a204bc7@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250723064515.2084903-1-miriam.rachel.korenblit@intel.com>
References: <20250723064515.2084903-1-miriam.rachel.korenblit@intel.com>
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


