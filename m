Return-Path: <linux-wireless+bounces-25791-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 161ACB0D078
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 05:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97FCB6C0D4C
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 03:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE4528C5CC;
	Tue, 22 Jul 2025 03:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g29HazN4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B4528C036
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 03:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753155727; cv=none; b=mkMLzBUUai+Z0G7QiF4H71w3vtSP7XCUgGeZ/urcQk+L0DoNDcnlt6VYK+RBjgqI9y5SNRJi7AXtccIgb45VNYcGkRsHkEZ2UKadRhgzyI4ZhgeOPfuX3j5m27a8gz7rSipyNkufN49pCSF4bxd1raZDYdIOH2RIe2MKlG3+SBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753155727; c=relaxed/simple;
	bh=lBwxqVxj/4g3ddTDPdNMNDaK82bIM5ZijsUq8Xx3CdA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SASJMXUjAG7Uz3HOiqNkh/XX9JclJk/b0pPLqyxqztVtVUrqE1tx/S1dW3J312dB7YAq5zxwLtU1oWaoC95ElgEG99sbqFoVB4k41rGbNsucBqcXHb+lSUxj/zW5Zlde3uAWqrNaMIUfkG2G/RFzrlHIyi4+1Q+zDS85SnKjdgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g29HazN4; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753155725; x=1784691725;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lBwxqVxj/4g3ddTDPdNMNDaK82bIM5ZijsUq8Xx3CdA=;
  b=g29HazN49H61ef2Azf4qgSx1g7ifdU1llJkb8VMJeVYWIvS51ORX5Cbz
   qhqUUCZccWMh+ko43Q7Cf2CGqzoRYt0Bh2aOcXPtIfZDgD6unQd38wUP4
   1CyOI+sEip1BcjCjZv9DlyJsjGMD3DyLXEn6WJe81ulsx0z/zyjvzq77s
   GxOy49Ffcl0IxTn6DX52gU7WbXmbSZON02zw4ikcQVe7Jspvnl2IkA9dy
   3Nyvmpa5AtlOtzDPZ4F8J6raEHnD8s3kEEJ+9IKl3UPcysmh0MCzjJPmD
   1ItxqMDwsFlPBUG8hFbtY0Ra/LKrUSjNVJ6wEQpXyoCxzkEguUZu8j7t/
   A==;
X-CSE-ConnectionGUID: dUfj1krLQHy4fqK3VvSgDg==
X-CSE-MsgGUID: wswhO1YWSjqtvQcmzkF4HA==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="43006167"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="43006167"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 20:42:05 -0700
X-CSE-ConnectionGUID: eiNj6hRlRnSbvJ2bKGulqA==
X-CSE-MsgGUID: MJx0ho5BRZOkFl3/dCXbgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="159338152"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 20:42:04 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Daniel Gabay <daniel.gabay@intel.com>
Subject: [PATCH iwlwifi-next 12/15] wifi: iwlwifi: mld: decode EOF bit for AMPDUs
Date: Tue, 22 Jul 2025 06:41:22 +0300
Message-Id: <20250722063923.bd0b27832a87.I4db4abf348f7b6dfc75f869770dd77655a204bc7@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722034125.1017387-1-miriam.rachel.korenblit@intel.com>
References: <20250722034125.1017387-1-miriam.rachel.korenblit@intel.com>
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


